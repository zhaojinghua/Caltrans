SELECT a.pms_scenario_id,
       b.pms_scenario_name,
       (select count(*) from pms_analysis_scenario_wp wpc where a.pms_scenario_id=wpc.pms_scenario_id and a.ca_ea_no=wpc.ca_ea_no) as rec_count,
       a.eff_year,
       a.ca_ea_no,
       TO_NUMBER (SUBSTR (a.ca_ea_no, 1, 2)) AS ca_district_num,
       a.ca_projectid,
       a.ca_county_name,
       a.ca_route_from,
       a.lane_miles,
       (select t.pms_treatment_name from ms_treatment t where wp.pms_treatment_id=t.pms_treatment_id) as pms_treatment_id,
       (select bc.PMS_BUDGET_CAT_NAME from PMS_BUDGET_CAT bc where bc.pms_budget_cat_id=a.pms_budget_cat_id) pms_budget_cat_id,
       a.project_price,
case when wp.MWP_PROJECT_STATUS_ID=1 then wp.project_price else 0 end as rec_cost,
case when wp.MWP_PROJECT_STATUS_ID<>1 then wp.project_price else 0 end as prog_cost,
case when wp.MWP_PROJECT_STATUS_ID=1 then wp.lane_miles else 0 end as rec_lm,
case when wp.MWP_PROJECT_STATUS_ID<>1 then wp.lane_miles else 0 end as prog_lm,
       10000 * a.ca_benefit_pres AS ca_benefit_pres,
       10000 * a.ca_ben_iri_traffic AS ca_ben_iri_traffic,
       10000 * a.ca_ghg_diff AS ca_ghg,
       C.CA_COUNTY_ABBREV as ca_county_from,
       lwp.ca_route_from as loc_route,
       lwp.ca_rte_suffix_from,
       lwp.ca_pm_prefix_from,
       lwp.ca_postmile_beg,
       lwp.ca_pm_suffix_from,
       lwp.ca_pm_prefix_to,
       lwp.ca_postmile_end,
       lwp.ca_pm_suffix_to,
       (select a.lane_dir_name from setup_lane_dir a where lwp.lane_dir=a.lane_dir) as lane_dir,
       decode(lwp.lane_id,0,'All',lwp.lane_id) as lane_id,
       lwp.offset_from,
       wp.lane_miles as wp_lane_miles,
       wp.project_price as wp_project_price,
       10000*wp.CA_BENEFIT_PRES_DIFF*wp.LANE_MILES/wp.PROJECT_PRICE as wp_benefit_pres,
       (select s.MWP_PROJECT_STATUS_NAME  from setup_MWP_PROJECT_STATUS s where wp.MWP_PROJECT_STATUS_ID=s.MWP_PROJECT_STATUS_ID) as MWP_PROJECT_STATUS_ID
  FROM ca_ea_benefit_vw a, pms_analysis_scenario_wp wp, pms_analysis_scenario b, setup_loc_ident lwp, setup_ca_county c
 WHERE     a.pms_scenario_id = wp.pms_scenario_id and wp.MWP_PROJECT_STATUS_ID=1 and a.lane_miles>=$P{LANE_MILE_MIN}
       AND wp.loc_ident = lwp.loc_ident and LWP.CA_COUNTY_FROM=C.CA_COUNTY_ID
       and ((a.pms_budget_cat_id in (1,8) and a.project_price>=$P{BUDGET_MIN_HM}) or
       (a.pms_budget_cat_id in (2,5) and a.project_price>=$P{BUDGET_MIN_SHOPP}))
       AND lwp.sourse_table = 'PMS_ANALYSIS_SCENARIO_WP'
       AND a.ca_ea_no = wp.ca_ea_no
       AND a.pms_scenario_id = $P{PMS_SCENARIO_ID}
       and a.pms_scenario_id = b.pms_scenario_id
       order by a.pms_scenario_id,
       decode(a.pms_budget_cat_id,8,1,1,2,5,3,2,4,10),
       a.eff_year,
       10000 * a.ca_benefit_pres DESC,
       a.ca_ea_no,
       C.CA_COUNTY_ABBREV,
       lwp.ca_route_from,
       lwp.offset_from,
       lwp.lane_dir,
       lwp.lane_id