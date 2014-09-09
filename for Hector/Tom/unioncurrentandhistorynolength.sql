select a.ea, a.treatment, a.county, a.route, a.year, a.beg_pm, a.end_pm, (a.end_pm-a.beg_pm) as length, a.budget_group from s1383currentl a
where a.county = 'SON'
union 
select b.ea, b.treatment, b.county, b.route, b.year, b.beg_pm, b.end_pm, (b.end_pm-b.beg_pm) as length, b.budget_group from s1383historyl b
where b.county = 'SON'
order by year, beg_pm, end_pm;

select a.ea, a.treatment, a.county, a.route, a.year, a.beg_pm, a.end_pm, (a.end_pm-a.beg_pm) as length, a.budget_group from s1383currentl a
where a.county = 'MRN'
union 
select b.ea, b.treatment, b.county, b.route, b.year, b.beg_pm, b.end_pm, (b.end_pm-b.beg_pm) as length, b.budget_group from s1383historyl b
where b.county = 'MRN'
order by year, beg_pm, end_pm;

select a.ea, a.treatment, a.county, a.route, a.year, a.beg_pm, a.end_pm, (a.end_pm-a.beg_pm) as length, a.budget_group from s1383currentl a
where a.county = 'SF'
union 
select b.ea, b.treatment, b.county, b.route, b.year, b.beg_pm, b.end_pm, (b.end_pm-b.beg_pm) as length, b.budget_group from s1383historyl b
where b.county = 'SF'
order by year, beg_pm, end_pm;

select a.ea, a.treatment, a.county, a.route, a.year, a.beg_pm, a.end_pm, (a.end_pm-a.beg_pm) as length, a.budget_group from s1383currentl a
where a.county = 'SM'
union 
select b.ea, b.treatment, b.county, b.route, b.year, b.beg_pm, b.end_pm, (b.end_pm-b.beg_pm) as length, b.budget_group from s1383historyl b
where b.county = 'SM'
order by year, beg_pm, end_pm;





select a.ea, a.treatment, a.county, a.route, a.year, a.beg_pm, a.end_pm, (a.end_pm-a.beg_pm) as length, a.budget_group from s1383currentr a
where a.county = 'SON' 
union 
select b.ea, b.treatment, b.county, b.route, b.year, b.beg_pm, b.end_pm, (b.end_pm-b.beg_pm) as length, b.budget_group from s1383historyr b
where b.county = 'SON' 
order by year, beg_pm, end_pm;

select a.ea, a.treatment, a.county, a.route, a.year, a.beg_pm, a.end_pm, (a.end_pm-a.beg_pm) as length, a.budget_group from s1383currentr a
where a.county = 'SF' 
union 
select b.ea, b.treatment, b.county, b.route, b.year, b.beg_pm, b.end_pm, (b.end_pm-b.beg_pm) as length, b.budget_group from s1383historyr b
where b.county = 'SF' 
order by year, beg_pm, end_pm;

select a.ea, a.treatment, a.county, a.route, a.year, a.beg_pm, a.end_pm, (a.end_pm-a.beg_pm) as length, a.budget_group from s1383currentr a
where a.county = 'SM' 
union 
select b.ea, b.treatment, b.county, b.route, b.year, b.beg_pm, b.end_pm, (b.end_pm-b.beg_pm) as length, b.budget_group from s1383historyr b
where b.county = 'SM' 
order by year, beg_pm, end_pm;

select a.ea, a.treatment, a.county, a.route, a.year, a.beg_pm, a.end_pm, (a.end_pm-a.beg_pm) as length, a.budget_group from s1383currentr a
where a.county = 'MRN' 
union 
select b.ea, b.treatment, b.county, b.route, b.year, b.beg_pm, b.end_pm, (b.end_pm-b.beg_pm) as length, b.budget_group from s1383historyr b
where b.county = 'MRN' 
order by year, beg_pm, end_pm;



