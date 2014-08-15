package gov.ca.dot.pm

import com.agileassetsinc.main.optim.*;
import com.agileassetsinc.core.TRDIUtils;

Integer max_accum_years=PerfMod.getMaxAccumYears();
double wpcv_wt=4.0;
double flx_tcv_wt=1.0;
double jcp_3CK_wt=4.0;
double fht_wt=1.0;

Double[] benThreshold = new Double[4];
benThreshold[0]=30.0;
benThreshold[1]=2.0;
benThreshold[2]=10.0;
benThreshold[3]=0.25;
/*
 * Original request fomula:
 * Case when a.wc_id=1 then
 * Benefit_pres=0.5*(wpcv_wt*(100- CA_WPCV) +flex_tci_wt *  CA_FLEX_TCI)
 * When a.wc_id=2 then
 * Benefit_pres=0.5*greatest((jcp_3CK_wt*(100-6*  CA_APCS_JPC_CK3_PCT) +(100*fht_wt*((5.8- CA_FHT_VAL)/5.8)),0)
 * Else Benefit_pres =0
 * End
 * 
 * Formula that gives the same value always but uses indices converted in 100 - 0 scale:
 * wc_id=1
 * 0.5*(wpcv_wt* a.CA_WPCV  +flex_tci_wt*a.CA_FLEX_TCI)
 * wc_id=2
 * 0.5*greatest(jcp_3CK_wt*(100-6*(100 - CA_APCS_JPC_CK3_PCT)) +fht_wt* CA_FHT_VAL,0)
 */

String[] column_in = new String[4];
column_in[0]=""CA_WPCV"";
column_in[1]=""CA_FLX_TCV"";
column_in[2]=""CA_APCS_JPC_CK3_PCT"";
column_in[3]=""CA_FHT_VAL"";
String altAddition = (alt_in==0?"""":""_ALT_""+alt_in);

PerformanceIndex [] pi=new  PerformanceIndex[4];
pi[0]=PI.get(""CA_WPCV"");
pi[1]=PI.get(""CA_FLX_TCV"");
pi[2]=PI.get(""CA_APCS_JPC_CK3_PCT"");
pi[3]=PI.get(""CA_FHT_VAL"");

for (int i = 1; i <= ds_in.rowCount(); i++)
{
	Integer treatment = ds_in.getItemInteger(i, ""PMS_TREATMENT_ID""+ altAddition);
	if (alt_in>0 &&(treatment == null || treatment == 0))
		continue;
	Double[] ben = new Double[4];
	ben[0]=0.0;
	ben[1]=0.0;
	ben[2]=0.0;
	ben[3]=0.0;
	
	int wcId=ds_in.getItemInteger(i,""WC_ID"");
	for (int piArrayIndex=(wcId==1?0:2);piArrayIndex<=(wcId==1?1:3);piArrayIndex++)
	{
		int accumYears = 1;
		Integer node_in = ds_in.getItemInteger(i,""MOD_NODE_ID""+altAddition);
		Integer rec_num = ds_in.getItemInteger(i,""ENGINE_REC_ID"");
		String mapName = ds_in.getItemInteger(i, ""ENGINE_REC_ID"") + (alt_in == 0 ? ""A"":alt_in == 1 ? ""X"" : alt_in == 2 ? ""Y"" : ""Z"") + treatment;
		Integer deter_type = alt_in == 0 ? 4:(Integer) pi[piArrayIndex].getAddDeterParm(""DET_TYPE"" + mapName);
		Integer num_years = deter_type==1 || deter_type==4?0:(Integer) pi[piArrayIndex].getAddDeterParm(""NUM_YEARS"" + mapName);
		Double coef = deter_type==1 || deter_type==4?1.0:(Double) pi[piArrayIndex].getAddDeterParm(""X_COEF"" + mapName);

		Double value_in = ds_in.getItemNumber(i,column_in[piArrayIndex]+altAddition);

		Double[] detValues=PerfMod.DeteriorateArr(column_in[piArrayIndex],node_in,rec_num,value_in,deter_type==1?null:ds_add_deter,max_accum_years,coef,num_years);

		detValues[0] = [benThreshold[piArrayIndex]-pi[piArrayIndex].ConvertFrom100(value_in),0].max();
		while (accumYears < max_accum_years && detValues[accumYears]!=null)
		{
			detValues[accumYears] = [benThreshold[piArrayIndex]-pi[piArrayIndex].ConvertFrom100(detValues[accumYears]),0].max();
			ben[piArrayIndex] += 0.5*(detValues[accumYears] + detValues[accumYears -1]);
			accumYears++;
		}
	}
	Double totBenefit= (wcId==1
			? (wpcv_wt*ben[0]/benThreshold[0]+flx_tcv_wt*ben[1]/benThreshold[1])/(wpcv_wt+flx_tcv_wt)
			: (jcp_3CK_wt*ben[2]/benThreshold[2]+fht_wt*ben[3]/benThreshold[3])/(jcp_3CK_wt+fht_wt)
			);
    ds_in.setItemNumber(i,col_in+altAddition,TRDIUtils.roundNumber(totBenefit,2));
	ds_in.setItemNumber(i,col_in+""_DIFF"",TRDIUtils.roundNumber(totBenefit-ds_in.getItemNumber(i,col_in),2));
}