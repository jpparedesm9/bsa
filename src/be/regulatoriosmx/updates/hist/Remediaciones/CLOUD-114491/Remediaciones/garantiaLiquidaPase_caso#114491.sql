--2129 - BONDOJITO PAGO A LAS 14:14
--232 - FE Y ESPERANZA PAGO A LAS 14:38
--1072 - INDE2018 PAGO A LAS 14:44
--1692 - LOS LOPEZ PAGO A LAS 14:31 --- mal nombre son MARRUECOS el codigo 1692

print 'BONDOJITO'---LOURDES RODRIGUEZ GONZALEZ-2403	lrodriguez
declare @w_tramite int 
select @w_tramite = io_campo_3 from cob_workflow..wf_inst_proceso 
where io_codigo_alterno = 'SOLCRGRSTD.9001.19.000985' -- Cambiar según el caso

exec cob_cartera..sp_ruteo_actividad_wf
     @s_ssn             =  11111, 
     @s_user            =  'lrodriguez',
     @s_sesn            =   11111,
     @s_term            =  'pc01tec77',
     @s_date            =  '03/08/2019',
     @s_srv             =  '',
     @s_lsrv            =  '',
     @s_ofi             =  2403,
     @i_tramite         =  @w_tramite,
     @i_param_etapa     =  'EAGARL'
go
	 
print 'FE Y ESPERANZA'---RAUL VARGAS CHAVEZ-3345	rvargasch
declare @w_tramite int 
select @w_tramite = io_campo_3 from cob_workflow..wf_inst_proceso 
where io_codigo_alterno = 'SOLCRGRSTD.3345.19.000036' -- Cambiar según el caso

exec cob_cartera..sp_ruteo_actividad_wf
     @s_ssn             =  11111, 
     @s_user            =  'rvargasch',
     @s_sesn            =   11111,
     @s_term            =  'pc01tec77',
     @s_date            =  '03/08/2019',
     @s_srv             =  '',
     @s_lsrv            =  '',
     @s_ofi             =  3345,
     @i_tramite         =  @w_tramite,
     @i_param_etapa     =  'EAGARL'
go
print 'INDE2018'---	JOSE GABRIEL BELLO CUEVAS-1032	jgbello

declare @w_tramite int 
select @w_tramite = io_campo_3 from cob_workflow..wf_inst_proceso 
where io_codigo_alterno = 'SOLCRGRSTD.1032.19.000024' -- Cambiar según el caso

exec cob_cartera..sp_ruteo_actividad_wf
     @s_ssn             =  11111, 
     @s_user            =  'jgbello',
     @s_sesn            =   11111,
     @s_term            =  'pc01tec77',
     @s_date            =  '03/08/2019',
     @s_srv             =  '',
     @s_lsrv            =  '',
     @s_ofi             =  1032,
     @i_tramite         =  @w_tramite,
     @i_param_etapa     =  'EAGARL'
go
	 