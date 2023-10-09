
/************************************************/
/*Pasa etapa de gar espera automatica           */
/************************************************/

declare @w_tramite int 

select @w_tramite = io_campo_3 from cob_workflow..wf_inst_proceso 
where io_codigo_alterno = 'SOLCRGRSTD.3345.19.000076'

exec cob_cartera..sp_ruteo_actividad_wf
     @s_ssn             =  11111, 
     @s_user            =  'rvargasch',
     @s_sesn            =   11111,
     @s_term            =  'consola',
     @s_date            =  '05/17/2019',
     @s_srv             =  '',
     @s_lsrv            =  '',
     @s_ofi             =   3345,
     @i_tramite         =  @w_tramite,
     @i_param_etapa     =  'EAGARL'
