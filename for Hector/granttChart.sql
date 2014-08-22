select county, route, max(end_pm - beg_pm) as range from CONSTRUCTIONHISTORYPM where county='SON' and route='001' group by county, route order by range desc, county, route;

select county, route, year, beg_pm, end_pm from CONSTRUCTIONHISTORYPM where county='SON' and route='001' order by county, route, year;

select distinct county from CONSTRUCTIONHISTORYPM order by county;