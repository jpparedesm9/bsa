declare @w_tramite int 
select @w_tramite = io_campo_3 from cob_workflow..wf_inst_proceso where io_codigo_alterno = 'SOLCRGRSTD.1101.18.000047'



exec cob_cartera..sp_ruteo_actividad_wf
     @s_ssn     =  11111, 
     @s_user            =  'admuser',
     @s_sesn            =   11111,
     @s_term            =  'pc01tec77',
     @s_date            =  '12/04/2017',
     @s_srv             =  '',
     @s_lsrv            =  '',
     @s_ofi             =  2078,
     @i_tramite     =  @w_tramite,
     @i_param_etapa  =  'EAGARL'