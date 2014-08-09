select count(*) from excel;

select count(ea) from (select distinct ea from excel);

create table eaandcount as select ea, count(ea) as rec_count from excel group by ea;

create table excelandcount as 
  select   ee.district,  
  ee.year,
  ee.ea,
  cc.rec_count,
  ee.ca_projectid,
  ee.county, 
  ee.route,
  ee.rs,
  ee.bpp,
  ee.beg_pm,
  ee.bps,
  ee.epp,
  ee.end_pm,
  ee.eps,
  ee.dir,
  ee.lane,
  ee.TOTAL_LANE_MILES,
  ee.treatment,
  ee.budget_group,
  ee.ESTIMATED_COST,
  ee.PERFORMANCE_PRESERVATION
  from EXCEL ee, EAANDCOUNT cc
  where ee.ea = cc.ea; 
  
select treatment from excelandcount;
  