select ea, county, route, PERFORMANCE_PRESERVATION, (40 * PERFORMANCE_PRESERVATION / (select max(performance_preservation) from excel)) as normailizeIndex from excel;

select max(performance_preservation) from excel;

select PERFORMANCE_PRESERVATION, 
    ((40 * (PERFORMANCE_PRESERVATION - (select min(performance_preservation) from excel))
    / ((select max(performance_preservation) from excel) - (select min(performance_preservation) from excel)))) as normIndex from excel;
    
    
select PERFORMANCE_PRESERVATION, (select min(performance_preservation) from excel) as mmin,
    (select max(performance_preservation) from excel) as mmax, 
    ((40 * (PERFORMANCE_PRESERVATION - mmin)
    / ( mmax - mmin))) as normIndex from excel;
    
       ((40 * ( 10000*a.ca_benefit_pres - 10000*(select min( ca_benefit_pres) from ca_ea_benefit_vw))
    / (10000*(select max( ca_benefit_pres) from ca_ea_benefit_vw) - 10000*(select min( ca_benefit_pres) from ca_ea_benefit_vw)))) as condition,    
    
    
    