
/************************************************/
/*Pasa etapa de gar espera automatica           */
/************************************************/

declare @w_tramite int 

select @w_tramite = io_campo_3 from cob_workflow..wf_inst_proceso 
where io_codigo_alterno = 'SOLCRGRSTD.1032.18.000053'

exec cob_cartera..sp_ruteo_actividad_wf
     @s_ssn             =  11111, 
     @s_user            =  'jtrujilloav',
     @s_sesn            =   11111,
     @s_term            =  'consola',
     @s_date            =  '01/08/2019',
     @s_srv             =  '',
     @s_lsrv            =  '',
     @s_ofi             =   1032,
     @i_tramite         =  @w_tramite,
     @i_param_etapa     =  'EAGARL'
