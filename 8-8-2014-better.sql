select year, 
    ea, 
    (select count(*) from s1318 ee where ee.ea=eee.ea) as rec_count, 
    ca_projectid, 
    county, 
    route, 
    rs, 
    bpp, 
    beg_pm, 
    bps, 
    epp, 
    end_pm, 
    eps, 
    dir, 
    lane, 
    estimated_cost 
    from s1318 eee order by ea; 
    
    