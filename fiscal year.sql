select (EXTRACT(YEAR FROM sysdate) +  DECODE(SIGN(TO_CHAR(sysdate, 'MM') - 6), -1, -1,  0, 0, 1, 1)) as FY from dual;

select SIGN(TO_CHAR(sysdate, 'MM') - 6) as sign from dual;

select (EXTRACT(YEAR FROM sysdate) +  SIGN(TO_CHAR(sysdate, 'MM') - 6)) as FY from dual;

select SIGN(TO_CHAR(sysdate, 'MM') - 6) * 5 from dual;
