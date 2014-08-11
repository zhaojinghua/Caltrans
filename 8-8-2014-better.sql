select year, 
    ea, 
    (select count(*) from excelnew ee where ee.ea=eee.ea) as rec_count, 
    ca_projectid, 
    county, 
    route, 
    rs, 
    bpp, 
    beg_pm, 
    bps, epp, 
    end_pm, 
    eps, 
    dir, 
    lane, 
    estimated_cost 
    from excelnew eee order by ea; 
    
    
select * from s1318;