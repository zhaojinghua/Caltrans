select
(100*BENEFIT*LANE_MILES/PROJECT_PRICE) as BENEFIT,
(select b.offset_from from setup_loc_ident b where a.loc_ident=b.loc_ident and b.sourse_table='PMS_ANALYSIS_SCENARIO_WP') as CA_BEG_STODM,
(10000*a.CA_BENEFIT_PRES_DIFF*a.LANE_MILES/a.PROJECT_PRICE) as CA_BENEFIT_PRES,
(100*CA_BEN_IRI_RUC_DIFF*LANE_MILES/PROJECT_PRICE) as CA_BEN_IRI_RUC,
(10000*CA_BEN_IRI_TRAFFIC_DIFF*LANE_MILES/PROJECT_PRICE) as CA_BEN_IRI_TRAFFIC,
(10000*CA_BEN_IRI_TRAF_PRES_DIFF*LANE_MILES/PROJECT_PRICE) as CA_BEN_IRI_TRAF_PRES,
(       SELECT MIN (b.ca_class_no)
          FROM network_master b, setup_loc_ident la, setup_loc_ident lb
         WHERE     a.loc_ident = la.loc_ident
               AND la.sourse_table = 'PMS_ANALYSIS_SCENARIO_WP'
               AND b.loc_ident = lb.loc_ident
               AND lb.sourse_table = 'NETWORK_MASTER'
               AND la.route_id = lb.route_id
               AND (la.lane_dir = lb.lane_dir OR la.lane_dir = 0 OR lb.lane_dir = 0)
               AND (la.lane_id = lb.lane_id OR la.lane_id = 0 OR lb.lane_id = 0)
               AND la.offset_from < lb.offset_to
               AND la.offset_to > lb.offset_from) as CA_CLASS_NO,
(select c.CA_COUNTY_ABBREV from SETUP_CA_COUNTY c where b.CA_COUNTY_FROM=c.CA_COUNTY_ID) as CA_COUNTY_FROM,
(nvl(( select max(lpad(ca_district_id,2,'0')) from PMS_CA_DISTRICT_EXCEPT ex, setup_loc_ident sli, setup_loc_ident la
where ex.loc_ident=sli.loc_ident and SLI.SOURSE_TABLE='PMS_CA_DISTRICT_EXCEPT' 
and a.loc_ident = la.loc_ident
and la.sourse_table='PMS_ANALYSIS_SCENARIO_WP'
and sli.route_id=LA.ROUTE_ID
and (la.lane_id=0 or sli.lane_id=0 or sli.lane_id=la.lane_id)
and (la.lane_dir=0 or sli.lane_dir=0 or sli.lane_dir=la.lane_dir)
and SLI.OFFSET_FROM<lA.OFFSET_TO
and SLI.OFFSET_TO>lA.OFFSET_FROM),(select d.ca_district_code from setup_ca_district d, setup_loc_ident la, setup_ca_county co
where a.loc_ident=la.loc_ident and la.sourse_table='PMS_ANALYSIS_SCENARIO_WP'
and la.ca_county_from=co.ca_county_id and co.ca_district_id=d.ca_district_id))) as CA_DISTRICT_CODE,
a.CA_EA_NO,
(select b.offset_to from setup_loc_ident b where a.loc_ident=b.loc_ident and b.sourse_table='PMS_ANALYSIS_SCENARIO_WP') as CA_END_STODM,
(10000*CA_GHG_DIFF*LANE_MILES/PROJECT_PRICE) as CA_GHG,
a.CA_IS_NHS,
b.CA_PM_PREFIX_FROM,
b.CA_PM_PREFIX_TO,
b.CA_PM_SUFFIX_FROM,
b.CA_PM_SUFFIX_TO,
b.CA_POSTMILE_BEG,
b.CA_POSTMILE_END,
a.CA_PROJECTID,
(select c.ROUTE_NAME from ROUTE_LIST c where b.CA_ROUTE_FROM=c.CA_ROUTE_FROM) as CA_ROUTE_FROM,
b.CA_RTE_SUFFIX_FROM,
(select a.PLAN_YEAR +b.PMS_ANALYSIS_START_YEAR-nvl(b.POSTPONE_DETERIORATION,0) from pms_analysis_scenario b where a.pms_scenario_id=b.pms_scenario_id) as EFF_YEAR,
(select c.LANE_DIR_NAME from SETUP_LANE_DIR c where b.LANE_DIR=c.LANE_DIR) as LANE_DIR,
(select c.LANE_ID_NAME from SETUP_LANE_ID c where b.LANE_ID=c.LANE_ID) as LANE_ID,
a.LANE_MILES,
a.LENGTH,
a.LOC_IDENT,
(select c.MWP_PROJECT_STATUS_NAME from SETUP_MWP_PROJECT_STATUS c where a.MWP_PROJECT_STATUS_ID=c.MWP_PROJECT_STATUS_ID) as MWP_PROJECT_STATUS_ID,
a.PLAN_YEAR,
(select c.PMS_BUDGET_CAT_NAME from PMS_BUDGET_CAT c where a.PMS_BUDGET_CAT_ID=c.PMS_BUDGET_CAT_ID) as PMS_BUDGET_CAT_ID,
a.PMS_SECTION_ID,
(select c.PMS_TREATMENT_NAME from MS_TREATMENT c where a.PMS_TREATMENT_ID=c.PMS_TREATMENT_ID) as PMS_TREATMENT_ID,
a.PROJECT_PRICE,
(select c.WC_NAME from PMS_WC c where a.WC_ID=c.WC_ID) as WC_ID
from pms_analysis_scenario_wp a, setup_loc_ident b
where A.LOC_IDENT=B.LOC_IDENT and B.SOURSE_TABLE='PMS_ANALYSIS_SCENARIO_WP'  and A.PMS_SCENARIO_ID=:PMS_SCENARIO_ID;
