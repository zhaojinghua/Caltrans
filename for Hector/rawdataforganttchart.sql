select county, route, max(end_pm - beg_pm) as range from CONSTRUCTIONHISTORYPM where county='SON' and route='001' group by county, route order by range desc, county, route;

select distinct county, route, year, beg_pm, end_pm, (end_pm-beg_pm) as length from CONSTRUCTIONHISTORYPM where county='SON' and route='001' order by county, route, year;


select b.ea, b.treatment, b.county, b.route, b.year, 
  b.beg_pm, b.end_pm, (b.end_pm-b.beg_pm) as length 
  from CONSTRUCTIONHISTORYPM b 
  where b.county='SBD' and b.route='062' and b.dir='Right'
  order by b.year, b.beg_pm, end_pm;
  
  
select county, route, count(year) as num
  from CONSTRUCTIONHISTORYPM
  group by county, route
  order by num desc, county, route;  
  