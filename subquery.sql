select count(*) from (select ea, mwp_project_status from EXCELNEW GROUP BY ea, mwp_project_status) ;
select ea, mwp_project_status from EXCELNEW GROUP BY ea, mwp_project_status;
select ea, sum(estimated_cost) as costSum from excelnew group by ea;
select year, ea, (select count(*) from excelnew ee where ee.ea=eee.ea) as rec_count, ca_projectid, county, route, rs, bpp, beg_pm, bps, epp, end_pm, eps, dir, lane, estimated_cost from excelnew eee order by ea; 

select count(*) from excelnew;

select * from excelnew where CA_PROJECTID=0112000282;
select * from excelnew order by ea;
select count(*) from excelnew;
select count(*) from excelnew ee, excelnew eee;
select ea, count(*) as rec_count from excelnew group by ea order by ea;
select count(*) from (select ee.CA_PROJECTID, ee.ea, eee.ESTIMATED_COST from excelnew ee, excelnew eee);