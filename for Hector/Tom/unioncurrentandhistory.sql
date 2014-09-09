select a.ea, a.treatment, a.county, a.route, a.year, to_char(a.beg_pm, 990.999) as beg_pm, to_char(a.end_pm, 990.999) as end_pm, to_char(a.length, 990.999) as length, a.budget_group from s1383currentl a
where a.county = 'SON'
union 
select b.ea, b.treatment, b.county, b.route, b.year, to_char(b.beg_pm, 990.999), to_char(b.end_pm, 990.999), to_char(b.length, 990.999), b.budget_group from s1383historyl b
where b.county = 'SON'
order by year, beg_pm;

select a.ea, a.treatment, a.county, a.route, a.year, to_char(a.beg_pm, 990.999) as beg_pm, to_char(a.end_pm, 990.999) as end_pm, to_char(a.length, 990.999) as length, a.budget_group from s1383currentl a
where a.county = 'MRN'
union 
select b.ea, b.treatment, b.county, b.route, b.year, to_char(b.beg_pm, 990.999), to_char(b.end_pm, 990.999), to_char(b.length, 990.999), b.budget_group from s1383historyl b
where b.county = 'MRN'
order by year, beg_pm;

select a.ea, a.treatment, a.county, a.route, a.year, to_char(a.beg_pm, 990.999) as beg_pm, to_char(a.end_pm, 990.999) as end_pm, to_char(a.length, 990.999) as length, a.budget_group from s1383currentl a
where a.county = 'SF'
union 
select b.ea, b.treatment, b.county, b.route, b.year, to_char(b.beg_pm, 990.999), to_char(b.end_pm, 990.999), to_char(b.length, 990.999), b.budget_group from s1383historyl b
where b.county = 'SF'
order by year, beg_pm;

select a.ea, a.treatment, a.county, a.route, a.year, to_char(a.beg_pm, 990.999) as beg_pm, to_char(a.end_pm, 990.999) as end_pm, to_char(a.length, 990.999) as length, a.budget_group from s1383currentl a
where a.county = 'SM'
union 
select b.ea, b.treatment, b.county, b.route, b.year, to_char(b.beg_pm, 990.999), to_char(b.end_pm, 990.999), to_char(b.length, 990.999), b.budget_group from s1383historyl b
where b.county = 'SM'
order by year, beg_pm;





select a.ea, a.treatment, a.county, a.route, a.year, to_char(a.beg_pm, 990.999) as beg_pm, to_char(a.end_pm, 990.999) as end_pm, to_char(a.length, 990.999) as length, a.budget_group from s1383currentr a
where a.county = 'SON' 
union 
select b.ea, b.treatment, b.county, b.route, b.year, to_char(b.beg_pm, 990.999), to_char(b.end_pm, 990.999), to_char(b.length, 990.999), b.budget_group from s1383historyr b
where b.county = 'SON' 
order by year, beg_pm;

select a.ea, a.treatment, a.county, a.route, a.year, to_char(a.beg_pm, 990.999) as beg_pm, to_char(a.end_pm, 990.999) as end_pm, to_char(a.length, 990.999) as length, a.budget_group from s1383currentr a
where a.county = 'SF' 
union 
select b.ea, b.treatment, b.county, b.route, b.year, to_char(b.beg_pm, 990.999), to_char(b.end_pm, 990.999), to_char(b.length, 990.999), b.budget_group from s1383historyr b
where b.county = 'SF' 
order by year, beg_pm;

select a.ea, a.treatment, a.county, a.route, a.year, to_char(a.beg_pm, 990.999) as beg_pm, to_char(a.end_pm, 990.999) as end_pm, to_char(a.length, 990.999) as length, a.budget_group from s1383currentr a
where a.county = 'SM' 
union 
select b.ea, b.treatment, b.county, b.route, b.year, to_char(b.beg_pm, 990.999), to_char(b.end_pm, 990.999), to_char(b.length, 990.999), b.budget_group from s1383historyr b
where b.county = 'SM' 
order by year, beg_pm;

select a.ea, a.treatment, a.county, a.route, a.year, to_char(a.beg_pm, 990.999) as beg_pm, to_char(a.end_pm, 990.999) as end_pm, to_char(a.length, 990.999) as length, a.budget_group from s1383currentr a
where a.county = 'MRN' 
union 
select b.ea, b.treatment, b.county, b.route, b.year, to_char(b.beg_pm, 990.999), to_char(b.end_pm, 990.999), to_char(b.length, 990.999), b.budget_group from s1383historyr b
where b.county = 'MRN' 
order by year, beg_pm;



