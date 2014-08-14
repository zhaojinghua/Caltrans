select * from s1366;

select distinct budget_group from s1366;

select distinct mwp_project_status from s1366;

select treatment, 
  budget_group, 
  mwp_project_status, 
  min(s1366.preservation_benefit_cost) as min,
  max(s1366.preservation_benefit_cost) as max
  from s1366 
  where budget_group in ('CAPM', 'Corrective Maintenance', 'Rehab', 'Preventive Maintenance')
  and mwp_project_status not in ('Under Construction', 'Completed')
  and treatment <> 'Non-Mainline Related CAPM'
  and treatment <> 'Non-Mainline Related Rehab'  
  and treatment <> 'Non-Mainline Related Corrective Maintenance'
  group by treatment, budget_group, mwp_project_status
  order by mwp_project_status, budget_group;