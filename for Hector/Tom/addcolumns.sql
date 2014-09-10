alter table s1383historyL 
    ADD project_status varchar2(30);
    
alter table s1383historyL 
    ADD length_mile varchar2(30);    

update s1383historyl set project_status = 'Completed';

update s1383historyl set length_mile = ('Length:' || to_char(end_pm-beg_pm, 990.999));


alter table s1383historyR 
    ADD project_status varchar2(30);
    
alter table s1383historyR 
    ADD length_mile varchar2(30);    
     
update s1383historyr set project_status = 'Completed';

update s1383historyr set length_mile = ('Length:' || to_char(end_pm-beg_pm, 990.999));

commit;


alter table s1383currentR 
    ADD project_status varchar2(30);
    
alter table s1383currentR 
    ADD length_mile varchar2(30);    
     
update s1383currentr set project_status = 'Completed';

update s1383currentr set length_mile = ('Length:' || to_char(end_pm-beg_pm, 990.999));

commit;


alter table s1383currentL 
    ADD project_status varchar2(30);
    
alter table s1383currentL 
    ADD length_mile varchar2(30);    
     
update s1383currentl set project_status = 'Completed';

update s1383currentl set length_mile = ('Length:' || to_char(end_pm-beg_pm, 990.999));

commit;