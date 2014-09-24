CREATE OR REPLACE FORCE VIEW ca_ea_benefit_vw
(
   pms_scenario_id,
   ca_ea_no,
   ca_projectid,
   eff_year,
   lane_miles,
   project_price,
   pms_treatment_id,
   pms_budget_cat_id,
   ca_benefit_pres,
   ca_ben_iri_traffic,
   ca_ghg_diff,
   ca_county_name,
   ca_route_from,
   ca_class_no
)
AS
     SELECT a.pms_scenario_id,
            a.ca_ea_no,
            a.ca_projectid,
            sc.pms_analysis_start_year + a.plan_year AS eff_year,
            SUM (a.lane_miles) AS lane_miles,
            SUM (a.project_price) AS project_price,
            MAX (a.pms_treatment_id) AS pms_treatment_id,
            DECODE (MAX (DECODE (a.pms_budget_cat_id,  8, 1,  1, 2,  5, 3,  4)),  1, 8,  2, 1,  3, 5,  2)
               AS pms_budget_cat_id,
            CASE
               WHEN SUM (a.lane_miles) = 0
               THEN
                  NULL
               ELSE
                  (SUM (a.lane_miles) * SUM (a.ca_benefit_pres_diff * a.lane_miles) / SUM (a.lane_miles))
                  / SUM (a.project_price)
            END
               AS ca_benefit_pres,
            CASE
               WHEN SUM (a.lane_miles) = 0
               THEN
                  NULL
              ELSE
                  (SUM (a.lane_miles) * SUM (a.ca_ben_iri_traffic_diff * a.lane_miles) / SUM (a.lane_miles))
                  / SUM (a.project_price)
            END
               AS ca_ben_iri_traffic,
            CASE
               WHEN SUM (a.lane_miles) = 0
               THEN
                  NULL
               ELSE
                  (SUM (a.lane_miles) * SUM (a.ca_ghg_diff * a.lane_miles) / SUM (a.lane_miles)) / SUM (a.project_price)
            END
               AS ca_ghg,
            REGEXP_REPLACE (listagg (c.ca_county_abbrev, ', ') WITHIN GROUP (ORDER BY la.ca_county_from),
                            '([^,]+)(, \1)+',
                            '\1')
               AS ca_county_name,
            -- MAX (la.ca_route_from) AS ca_route_from,
            REGEXP_REPLACE (
               listagg (la.ca_route_from || la.ca_rte_suffix_from, ', ')
                  WITHIN GROUP (ORDER BY la.ca_route_from || la.ca_rte_suffix_from),
               '([^,]+)(, \1)+',
               '\1')
               AS ca_route_from,
            a.ca_class_no
       FROM pms_analysis_scenario_wp a,
            setup_loc_ident la,
            pms_analysis_scenario sc,
            setup_ca_county c
      WHERE     a.loc_ident = la.loc_ident
            AND la.ca_county_from = c.ca_county_id
            AND la.sourse_table = 'PMS_ANALYSIS_SCENARIO_WP'
            AND a.pms_scenario_id = sc.pms_scenario_id
            AND a.ca_ea_no IS NOT NULL
   GROUP BY a.pms_scenario_id,
            a.ca_ea_no,
            a.ca_class_no,
            sc.pms_analysis_start_year + a.plan_year,
            a.ca_projectid;
