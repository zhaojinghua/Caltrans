//script setup
import com.agileassetsinc.core.*;
//import all the classes from the package com.agileassetsinc.core.

DataLayer dl = new Datalayer();     //declare a new DataLayer instance dl.
ds_in = dl.createDataStore("select 1 as NCB_SUBSTR_COND_N, 2 as NCB_DECK_COND_N, 3 as NCB_SUPERST_COND_N from dual");
//call the instance method on dl with the parameter of the select statement then assign the result to ds_in.
//(without declaration of type?????????????????????????????????????????????????????????)
ds_in.retrieve();           //call the instance method retrieve() on ds_in.
row_in = 1;                 //assign 1 to variable row_in (without declaring the type?)
alt_in = 0;                 //assign 0 to variable alt_in (without declaring the type?)
//end of script setup

import com.agileassetsinc.main.optim.*;
//import all the classes from the package of com.agileassetsinc.main.optim.

import com.agileassetsinc.core.TRDIUtils;
//import the TRDIUtils class from the package of com.agileassetsinc.core.

Integer max_accum_years = PerfMod.getMaxAccumYears();
//declare Integer variable max_accum_years and assign the returned value
//after executing perfMod.getMaxAccumyears() funciton to the variable.

double wpcv_wt = 4.0;                          //declare double variable wpcv_wt and assign 4.0 to the variable.
double flx_tcv_wt = 1.0;                      //declare double variable flx_tcv_wt and assign 1.0 to the variable.
double jcp_3CK_wt = 4.0;
double fht_wt = 1.0;
Double[] benThreshold = new Double[4];                   //declare Double array benThreshold with a length of 4.
benThreshold[0] = 30.0;                                  //assign 30.0 to the first cell
benThreshold[1] = 2.0;                                   //assign 2.0 to the second cell
benThreshold[2] = 10.0;                                  //assign 10.0 to the third cell
benThreshold[3] = 0.25;                                  //assign 0.25 to the last cell
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
String[] column_in = new String[4];                  //declare String array culumn_in with a length of 4.
column_in[0] = ""CA_WPCV"";                           //assign "CA_WPCV" to the first cell.
column_in[1] = ""CA_FLX_TCV"";                        //assign "CA_FLX_TCV" to the second cell.
column_in[2] = ""CA_APCS_JPC_CK3_PCT"";
column_in[3] = ""CA_FHT_VAL"";
//String altAddition = (alt_in==0?"""":""_ALT_""+alt_in);
// declare String variable altAddition and assign to it with an expression which evaluate whether alt_in equals to 0,
// if equals return ""; if not equals return "_ALT" + alt_in. (COMMENT THE LINE OF CODE for better printing)

PerformanceIndex[] pi = new PerformanceIndex[4];    //declare an PerformanceIndex array with a length of 4.
pi[0] = PI.get(""CA_WPCV"");
//calling the PI getter function with a parameter "CA_WPCV" and assign the returned value to the first cell.
pi[1] = PI.get(""CA_FLX_TCV"");
//calling the PI getter function with a parameter "CA_FLX_TCV" and assign the returned value to the second cell.
pi[2] = PI.get(""CA_APCS_JPC_CK3_PCT"");
pi[3] = PI.get(""CA_FHT_VAL"");

for (int i = 1; i <= ds_in.rowCount(); i++)
//repeat the following code many times based on the returned value of ds_in.rowCount().
//ds_in.rowCount() probably counts the row numbers of the ds_in instance.
{
    Integer treatment = ds_in.getItemInteger(i, ""PMS_TREATMENT_ID"" + altAddition);
    //declare treatment integer variable and assign to it the returned value of ds_in.getItenInteger() with
    // parameters of the counter of the for loop and the string of "PMS_TREAT_ID" + altAddition.

    if (alt_in > 0 && (treatment == null || treatment == 0))
        continue;
    //if alt_in is greater than 0 AND treatment is null or 0 then go to next iteration w/o executing the following code.

    Double[] ben = new Double[4];             //declare ben double array with a length of 4.
    ben[0] = 0.0;                             //assign 0.0 to the first cell.
    ben[1] = 0.0;                             //assign 0.0 to the second cell.
    ben[2] = 0.0;                             //assign 0.0 to the third cell.
    ben[3] = 0.0;                             //assign 0.0 to the last cell.

    int wcId = ds_in.getItemInteger(i, ""WC_ID"");
    //declare integer primitive variable wcId and assign to it the returned value of
    // ds_in.getItenInteger() with the parameters of the counter and the string "WC_ID".
    // IMPORTANT -- wcId may be different for each iteration of the outer loop. -- IMPORTANT

    for (int piArrayIndex = (wcId == 1 ? 0 : 2); piArrayIndex <= (wcId == 1 ? 1 : 3); piArrayIndex++)
    //repeat the following code many times based on the value of the parameter wcId,
    // if it equals to 1 then two times; if not equals to 1 then still two times. ***THERE IS AN INNER LOOP.***
    {
        int accumYears = 1;             //declare integer variable accumYears and assign 1 to it.
        Integer node_in = ds_in.getItemInteger(i, ""MOD_NODE_ID"" + altAddition);
        //declare Integer variable node_in and assign to it the return value of the ds_in.getItemInteger() function
        // with parameters of outer loop counter and a string of "MOD_NODE_ID"  + altAddition.

        Integer rec_num = ds_in.getItemInteger(i, ""ENGINE_REC_ID"");
        //declare Integer variable rec_num and assign to it the return value of the ds_in.getItemInteger() function
        // with parameters of outer loop counter and a string of "ENGINE_REG_ID".

        String mapName = ds_in.getItemInteger(i, ""ENGINE_REC_ID"") +
                (alt_in == 0 ? ""A"": alt_in == 1 ? ""X"": alt_in == 2 ? ""Y"": ""Z"") +treatment;
//declare String variable mapName and assign to it the value returned by ds_in.getItemInteger() with the parameter of
//outer counter i and "ENGINE_REC_ID" then + either "A" or "X" or "Y" or "Z" depends on alt_in's value then + treatment.

        Integer deter_type = alt_in == 0 ? 4 : (Integer) pi[piArrayIndex].getAddDeterParm(""DET_TYPE"" + mapName);
        //declare Integer variable deter_type and assign to it either 4
        // or the number returned by pi[piArrayIndex].getAddDeterParm(""DET_TYPE"" + mapName) and casted to Integer
        // depends on the value of alt_in.

        Integer num_years = deter_type == 1 || deter_type == 4 ?
                0 : (Integer) pi[piArrayIndex].getAddDeterParm(""NUM_YEARS"" + mapName);
        //declare Integer variable num_years and assign to it 0 (if deter_type is 1 or 4)
        // or assign ot it the value returned by pi[piArrayIndex].getAddDeterParm(""NUM_YEARS"" + mapName)

        Double coef = deter_type == 1 || deter_type == 4 ?
                1.0 : (Double) pi[piArrayIndex].getAddDeterParm(""X_COEF"" + mapName);
        //declare Double variable coef and assign to it 1.0 (if deter_type is 1 or 4) or assign ot it
        //the value returned by pi[piArrayIndex].getAddDeterParm(""X_COEF"" + mapName) and casted to Double.

        Double value_in = ds_in.getItemNumber(i, column_in[piArrayIndex] + altAddition);
        //declare Double variable value_in and assign to it the value returned by the function
        // ds_in.getItemNumber(i, column_in[piArrayIndex] + altAddition)

        Double[] detValues = PerfMod.DeteriorateArr(column_in[piArrayIndex], node_in, rec_num, value_in,
                deter_type == 1 ? null : ds_add_deter, max_accum_years, coef, num_years);
        //declare Double array detValues and assign to it the array returned by the function PerfMod.DeteriorateArr()
        // with parameters of column_in[piArrayIndex], node_in, rec_num, value_in,
        // deter_type == 1 ? null : ds_add_deter, max_accum_years, coef, num_years.

        detValues[0] = [benThreshold[piArrayIndex] - pi[piArrayIndex].ConvertFrom100(value_in), 0].max();
        //assign to the first cell with the maximum value of 0 and the value
        // evaluated by the expression benThreshold[piArrayIndex] - pi[piArrayIndex].ConvertFrom100(value_in)
        // to make sure the value is a NON-NEGATIVE NUMBER.
        //? ? ? Why isolate the first cell and don't add the first cell to ben[piArrayIndex] ? ? ?
        //The reason to isolate it is because the following while loop needs to retrieve a previous value.

        while (accumYears < max_accum_years && detValues[accumYears] != null) {
            detValues[accumYears] =
                    [benThreshold[piArrayIndex] - pi[piArrayIndex].ConvertFrom100(detValues[accumYears]), 0].max();
            ben[piArrayIndex] += 0.5 * (detValues[accumYears] + detValues[accumYears - 1]);
            accumYears++;
        }
        //This while loop iterate through all the possible year AND valid detValues[accumYears] value
        // and accumulate the trapezoid area to ben[piArrayIndex] for each inner for loop iteration.
        //I think they intention not to time the HEIGHT of the trapezoid, which is 1. (Anything times 1 is still same.)
    }
    Double totBenefit = (wcId == 1
            ? (wpcv_wt * ben[0] / benThreshold[0] + flx_tcv_wt * ben[1] / benThreshold[1]) / (wpcv_wt + flx_tcv_wt)
            : (jcp_3CK_wt * ben[2] / benThreshold[2] + fht_wt * ben[3] / benThreshold[3]) / (jcp_3CK_wt + fht_wt)
    ); //declare Double variable totBenefit and assign to it
      // either (wpcv_wt * ben[0] / benThreshold[0] + flx_tcv_wt * ben[1] / benThreshold[1]) / (wpcv_wt + flx_tcv_wt)
      // or (jcp_3CK_wt * ben[2] / benThreshold[2] + fht_wt * ben[3] / benThreshold[3]) / (jcp_3CK_wt + fht_wt)

    ds_in.setItemNumber(i, col_in + altAddition, TRDIUtils.roundNumber(totBenefit, 2));
    //call the instance method setItemNumber() on ds_in
    // with parameter of the outer counter i, col_in+altAddition,
    // and the returned value executing TRDIUtils.roundNumber(totBenefit, 2)

    ds_in.setItemNumber(i, col_in + ""DIFF"", TRDIUtils.roundNumber(totBenefit - ds_in.getItemNumber(i, col_in), 2));
    //call the instance method setItemNumber() on ds_in
    // with parameter of the outer counter i, col_in+"DIFF",
    // and the returned value executing TRDIUtils.roundNumber(totBenefit - ds_in.getItemNumber(i, col_in), 2)
}