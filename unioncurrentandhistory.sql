select a.ea, a.treatment, a.county, a.route, a.year_ as year, a.beg_pm, a.end_pm, a.length, a.budget_group from s1383current a
union 
select b.ea, b.treatment, b.county, b.route, b.year, b.beg_pm, b.end_pm, b.length, b.budget_group from s1383history b;