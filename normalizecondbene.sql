select ea, county, route, PERFORMANCE_PRESERVATION, (40 * PERFORMANCE_PRESERVATION / (select max(performance_preservation) from excel)) as normailizeIndex from excel;

select max(performance_preservation) from excel;

select PERFORMANCE_PRESERVATION, 
    ((40 * (PERFORMANCE_PRESERVATION - (select min(performance_preservation) from excel))
    / ((select max(performance_preservation) from excel) - (select min(performance_preservation) from excel)))) as normIndex from excel;
    
    
select PERFORMANCE_PRESERVATION, (select min(performance_preservation) from excel) as mmin,
    (select max(performance_preservation) from excel) as mmax, 
    ((40 * (PERFORMANCE_PRESERVATION - mmin)
    / ( mmax - mmin))) as normIndex from excel;
    
       ((40 * ( 10000*a.ca_benefit_pres - 10000*(select min( ca_benefit_pres) from ca_ea_benefit_vw))
    / (10000*(select max( ca_benefit_pres) from ca_ea_benefit_vw) - 10000*(select min( ca_benefit_pres) from ca_ea_benefit_vw)))) as condition,    
	
	
       ((40 * ( 10000*a.ca_benefit_pres - 10000*(select min(aa.ca_benefit_pres) from ca_ea_benefit_vw aa))
    / (10000*(select max(bb.ca_benefit_pres) from ca_ea_benefit_vw bb) - 10000*(select min(cc.ca_benefit_pres) from ca_ea_benefit_vw cc)))) as Normalized,	
    
	
40 * ( 10000*a.ca_benefit_pres - 10000*(select min( aa.ca_benefit_pres) from ca_ea_benefit_vw aa where $P{PMS_SCENARIO_ID} = aa.pms_scenario_id))
    / (10000*(select max( bb.ca_benefit_pres) from ca_ea_benefit_vw bb where $P{PMS_SCENARIO_ID} = bb.pms_scenario_id) 
	- 10000*(select min( cc.ca_benefit_pres) from ca_ea_benefit_vw cc where $P{PMS_SCENARIO_ID} = cc.pms_scenario_id)) as	
	
	
working!!	
	
10000*(select max( aa.ca_benefit_pres) from ca_ea_benefit_vw aa 
       where aa.pms_scenario_id = wp.pms_scenario_id and wp.MWP_PROJECT_STATUS_ID=1 and aa.lane_miles>=$P{LANE_MILE_MIN}
       AND wp.loc_ident = lwp.loc_ident and LWP.CA_COUNTY_FROM=C.CA_COUNTY_ID
       and ((aa.pms_budget_cat_id in (1,8) and aa.project_price>=$P{BUDGET_MIN_HM}) or
       (aa.pms_budget_cat_id in (2,5) and aa.project_price>=$P{BUDGET_MIN_SHOPP}))
       AND lwp.sourse_table = 'PMS_ANALYSIS_SCENARIO_WP'
       AND aa.pms_scenario_id = $P{PMS_SCENARIO_ID}
       and substr(aa.ca_ea_no, -1)='T'
       and aa.pms_scenario_id = b.pms_scenario_id) as Normalized,  
       
       
       40*((10000*a.ca_benefit_pres)-(10000*(select min( aa.ca_benefit_pres) from ca_ea_benefit_vw aa 
       where aa.pms_scenario_id = wp.pms_scenario_id and wp.MWP_PROJECT_STATUS_ID=1 and aa.lane_miles>=$P{LANE_MILE_MIN}
       AND wp.loc_ident = lwp.loc_ident and LWP.CA_COUNTY_FROM=C.CA_COUNTY_ID
       and ((aa.pms_budget_cat_id in (1,8) and aa.project_price>=$P{BUDGET_MIN_HM}) or
       (aa.pms_budget_cat_id in (2,5) and aa.project_price>=$P{BUDGET_MIN_SHOPP}))
       AND lwp.sourse_table = 'PMS_ANALYSIS_SCENARIO_WP'
       AND aa.pms_scenario_id = $P{PMS_SCENARIO_ID}
       and substr(aa.ca_ea_no, -1)='T'
       and aa.pms_scenario_id = b.pms_scenario_id)))/((10000*(select max( bb.ca_benefit_pres) from ca_ea_benefit_vw bb 
       where bb.pms_scenario_id = wp.pms_scenario_id and wp.MWP_PROJECT_STATUS_ID=1 and bb.lane_miles>=$P{LANE_MILE_MIN}
       AND wp.loc_ident = lwp.loc_ident and LWP.CA_COUNTY_FROM=C.CA_COUNTY_ID
       and ((bb.pms_budget_cat_id in (1,8) and bb.project_price>=$P{BUDGET_MIN_HM}) or
       (bb.pms_budget_cat_id in (2,5) and bb.project_price>=$P{BUDGET_MIN_SHOPP}))
       AND lwp.sourse_table = 'PMS_ANALYSIS_SCENARIO_WP'
       AND bb.pms_scenario_id = $P{PMS_SCENARIO_ID}
       and substr(bb.ca_ea_no, -1)='T'
       and bb.pms_scenario_id = b.pms_scenario_id))-(10000*(select min( cc.ca_benefit_pres) from ca_ea_benefit_vw cc 
       where cc.pms_scenario_id = wp.pms_scenario_id and wp.MWP_PROJECT_STATUS_ID=1 and cc.lane_miles>=$P{LANE_MILE_MIN}
       AND wp.loc_ident = lwp.loc_ident and LWP.CA_COUNTY_FROM=C.CA_COUNTY_ID
       and ((cc.pms_budget_cat_id in (1,8) and cc.project_price>=$P{BUDGET_MIN_HM}) or
       (cc.pms_budget_cat_id in (2,5) and cc.project_price>=$P{BUDGET_MIN_SHOPP}))
       AND lwp.sourse_table = 'PMS_ANALYSIS_SCENARIO_WP'
       AND cc.pms_scenario_id = $P{PMS_SCENARIO_ID}
       and substr(cc.ca_ea_no, -1)='T'
       and cc.pms_scenario_id = b.pms_scenario_id))) as Normalized, 
       
  

       
       
       
       
       
       
       
       
       
       
       