use cobis
go



/* ACTUALIZACION DEL MENU  DE RENOVACIONES */
update cobis..cew_menu 
set    me_url   = 'views/ASSTS/TRNSC/T_REFINANCELISS_781/1.0.0/VC_REFINANCSL_902781_TASK.html?menu=9'
where  me_name  = 'MNU_ASSETS_RENOVACIONES'


go







