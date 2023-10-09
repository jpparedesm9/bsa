
USE cobis
GO

print 'cobis..cew_menu ' 

update cobis..cew_menu
set me_url ='views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=1'
where  me_name ='MNU_ASSETS_VALDATE' 



update cobis..cew_menu
set me_url ='views/ASSTS/CMMNS/T_LOANSEARCHSWA_959/1.0.0/VC_LOANSEARHC_144959_TASK.html?menu=2'
where  me_name ='MNU_ASSETS_REVERSE' 
