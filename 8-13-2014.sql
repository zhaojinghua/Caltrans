select (select count(*) from s1318 ee where ee.ea=eee.ea) as rec_count, 
    year, 
    ea,
    district,     
    ca_projectid, 
    county, 
    route, 
    total_lane_miles,
    treatment, 
    budget_group,
    estimated_cost,
    case when mwp_project_status <> 'Programmed' then estimated_cost else 0 end as rec_cost,
    case when mwp_project_status = 'Programmed' then estimated_cost else 0 end as prog_cost,
    rs, 
    bpp, 
    beg_pm, 
    bps, 
    epp, 
    end_pm, 
    eps, 
    dir, 
    lane
    from s1318 eee order by ea; 
    
    select distinct mwp_project_status from s1318;
    select distinct lane from s1318;
    