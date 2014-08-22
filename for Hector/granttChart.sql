select county, route, max(end_pm - beg_pm) as range from CONSTRUCTIONHISTORYPM where county='SON' and route='001' group by county, route order by range desc, county, route;

select distinct county, route, year, beg_pm, (end_pm-beg_pm) as length from CONSTRUCTIONHISTORYPM where county='SON' and route='001' order by county, route, year;

select distinct county from CONSTRUCTIONHISTORYPM order by county;

select count(*) from CONSTRUCTIONHISTORYPM;

select count(*) from SENARIO_1366_RESULTS;

select s.district, 
  s.year, 
  s.ea, 
  s.ca_projectid, 
  s.county, 
  s.route, 
  s.rs,
  s.bpp, 
  s.beg_pm, 
  s.bps, 
  s.epp, 
  s.end_pm, 
  s.eps, 
  s.dir, 
  s.lane, 
  s.total_lane_miles, 
  s.treatment, 
  s.budget_group, 
  s.estimated_cost, 
  s.preservation_benefit_cost, 
  s.pavement_type, 
  s.length, 
  s.mwp_project_status, 
  s.class, 
  null as contract_id,
  null as work_code, 
  null as conpletion_date, 
  null as project_code, 
  null as project_type
  from senario_1366_results s
union all
select null as district,
  c.year, 
  c.ea, 
  null as ca_projectid, 
  c.county, 
  c.route, 
  c.rs,
  c.bpp, 
  c.beg_pm, 
  c.bps, 
  c.epp, 
  c.end_pm, 
  c.eps, 
  c.dir, 
  c.lane, 
  null as total_lane_miles, 
  c.treatment, 
  null as budget_group, 
  null as estimated_cost, 
  null as preservation_benefit_cost, 
  null as pavement_type, 
  null as length, 
  null as mwp_project_status, 
  null as class, 
  c.contract_id, 
  c.work_code, 
  c.completion_date,
  c.project_code,
  c.project_type
  from constructionhistorypm c;
  
  
  