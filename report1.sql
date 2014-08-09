SELECT a.pms_scenario_id,(select count(*) from pms_analysis_scenario_wp wpc where a.pms_scenario_id=wpc.pms_scenario_id and a.ca_ea_no=wpc.ca_ea_no) as rec_count,
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
       lwp.lane_id,
       lwp.offset_from,
       wp.lane_miles as wp_lane_miles,
       wp.project_price as wp_project_price,
       10000*wp.CA_BENEFIT_PRES_DIFF*wp.LANE_MILES/wp.PROJECT_PRICE as wp_benefit_pres,
       (select s.MWP_PROJECT_STATUS_NAME  from setup_MWP_PROJECT_STATUS s where wp.MWP_PROJECT_STATUS_ID=s.MWP_PROJECT_STATUS_ID) as MWP_PROJECT_STATUS_ID
  FROM ca_ea_benefit_vw a, pms_analysis_scenario_wp wp, setup_loc_ident lwp, setup_ca_county c
 WHERE     a.pms_scenario_id = wp.pms_scenario_id
                AND ((wp.mwp_project_status_id = 1 AND a.lane_miles >= $P{LANE_MILE_MIN}
              AND ( (a.pms_budget_cat_id IN (1, 8) AND a.project_price >= $P{BUDGET_MIN_HM})
                   OR (a.pms_budget_cat_id IN (2, 5) AND a.project_price >= $P{BUDGET_MIN_SHOPP})))
                   OR wp.mwp_project_status_id <> 1
                   )
       AND wp.loc_ident = lwp.loc_ident and LWP.CA_COUNTY_FROM=C.CA_COUNTY_ID
       AND lwp.sourse_table = 'PMS_ANALYSIS_SCENARIO_WP'
       AND a.ca_ea_no = wp.ca_ea_no
       AND a.pms_scenario_id = $P{PMS_SCENARIO_ID}
       order by a.pms_scenario_id,
       TO_NUMBER (SUBSTR (a.ca_ea_no, 1, 2)),
       a.eff_year,
       decode(a.pms_budget_cat_id,8,1,1,2,5,3,2,4,10),
       a.ca_ea_no,
       C.CA_COUNTY_ABBREV,
       lwp.ca_route_from,
       lwp.offset_from,
       lwp.lane_dir,
       lwp.lane_id;