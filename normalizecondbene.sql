select ea, county, route, PERFORMANCE_PRESERVATION, (40 * PERFORMANCE_PRESERVATION / (select max(performance_preservation) from excel)) as normailizeIndex from excel;

select max(performance_preservation) from excel;