select county, route, max(end_pm - beg_pm) as range from CONSTRUCTIONHISTORYPM where county='SON' and route='001' group by county, route order by range desc, county, route;

select distinct county, route, year, beg_pm, end_pm, (end_pm-beg_pm) as length from CONSTRUCTIONHISTORYPM where county='SON' and route='001' order by county, route, year;

select * from constructionhistorypm;
select distinct treatment, work_code, project_type from constructionhistorypm order by project_type, work_code, treatment;
select * from excel;

select distinct treatment, budget_group from excelnew order by budget_group, treatment;

select b.ea, b.treatment, b.county, b.route, b.year, 
  b.beg_pm, b.end_pm, (b.end_pm-b.beg_pm) as length 
  from CONSTRUCTIONHISTORYPM b 
  where b.county='SON' and b.route='001' and b.dir='Right'
  order by b.year, b.beg_pm, end_pm;
  
select b.ea, b.treatment, b.county, b.route, b.year, 
  ('Beg PM: ' || to_char(b.beg_pm, 990.999)) as "Beg PM", ('End PM: ' || to_char(b.end_pm, 990.999)) as "End PM", (b.end_pm-b.beg_pm) as length 
  from CONSTRUCTIONHISTORYPM b 
  where b.county='SON' and b.route='001' and b.dir='Right'
  order by b.year, b.beg_pm, end_pm;
  
  
select b.ea, b.Treatment, 
  b.County, b.Route, b.Year, 
  ('Beg PM: ' || to_char(b.beg_pm, 990.999)) as "Beg PM", 
  ('End PM: ' || to_char(b.end_pm, 990.999)) as "End PM", 
  (b.end_pm-b.beg_pm) as Len,
  decode(treatment, 
    'Chip Seal', 'CAPM', 
    'HMA Thin Overlay', 'Preventive Maintenance',
    'N/A') as "Budget Group", 
  ('Length: '|| to_char(b.end_pm-b.beg_pm, 990.999)) as Length
  from CONSTRUCTIONHISTORYPM b 
  where b.county='SON' and b.route='001' and b.dir='Right'
  order by b.year, b.beg_pm, end_pm;  
  
select county, route, count(year) as num
  from CONSTRUCTIONHISTORYPM
  group by county, route
  order by num desc, county, route;  
  
  
  

  