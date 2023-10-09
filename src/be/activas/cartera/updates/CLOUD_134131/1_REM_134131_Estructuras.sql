USE cob_cartera
GO

if object_id ('dbo.ca_cobranza_batch') is not null
	drop table dbo.ca_cobranza_batch
go

create table ca_cobranza_batch(
cb_contrato    varchar(40),
cb_grupo_id    varchar(40),
cb_fecha_pago  varchar(40),
cb_hora_pago   varchar(40),
cb_origen_pago varchar(40),
cb_monto       varchar(40)
)
GO


USE cob_credito
GO

if object_id ('dbo.cr_buro_diario') is not null
	drop table dbo.cr_buro_diario
go

create table cr_buro_diario(
bd_cod_cliente       varchar(40),
bd_tipo_cliente      varchar(40),
bd_nombre            varchar(40),
bd_buc               varchar(40),
bd_fecha_act         varchar(40),
bd_forma_pago        varchar(40),
bd_hist_pagos        varchar(40),
bd_saldo_vencido     varchar(40),
bd_tipo_contrato     varchar(40),
bd_fecha_cierre      varchar(40),
bd_clave_obs         varchar(40),
bd_clave_otorgante   varchar(40),
bd_tipo_cuenta       varchar(40),
bd_tipo_respon       varchar(40),
bd_fecha_apert_cta   varchar(40),
bd_credito_max       varchar(40),
bd_saldo_act         varchar(40),
bd_frec_pago         varchar(40),
bd_nombre_otorgante  varchar(40)
)
GO



USE cobis
GO

if object_id ('dbo.cl_ingresos_sistema') is not null
	drop table dbo.cl_ingresos_sistema
go

create table cl_ingresos_sistema(
is_usuario           varchar(30),
is_nombre            varchar(64),
is_medio             varchar(30),
is_fecha             varchar(10),
is_hora              varchar(30)
)
GO



---------------------
--CREACION DEL BATCH
---------------------
USE cobis
GO

declare @w_server           varchar(24),
        @w_path_fuente_CCA  varchar(255),
        @w_path_destino_CCA varchar(255),
        @w_path_fuente_CLI  varchar(255),
        @w_path_destino_CLI varchar(255),
        @w_path_fuente_CRE  varchar(255),
        @w_path_destino_CRE varchar(255)

select @w_server = pa_char
from cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'
 
select @w_path_fuente_CCA  = pp_path_fuente, 
       @w_path_destino_CCA = pp_path_destino
from ba_path_pro
where pp_producto = 7

select @w_path_fuente_CLI  = pp_path_fuente, 
       @w_path_destino_CLI = pp_path_destino
from ba_path_pro
where pp_producto = 2

select @w_path_fuente_CRE  = pp_path_fuente, 
       @w_path_destino_CRE = pp_path_destino
from ba_path_pro
where pp_producto = 21


--BATCH
--7592
if exists (select 1 from ba_batch where ba_batch =  7592 and ba_nombre = 'REPORTE COBRANZAS DIARIO' )
begin
   delete ba_batch where ba_batch =  7592 and ba_nombre = 'REPORTE COBRANZAS DIARIO'
end
insert into cobis..ba_batch 
(ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7592,  'REPORTE COBRANZAS DIARIO', 'REPORTE COBRANZAS DIARIO','SP', getdate(), 7, 'P', 1, 'CARTERA','COBRANZA_','cob_cartera..sp_reporte_cobranza_batch', 1,   null, @w_server, 'S', @w_path_fuente_CCA, @w_path_destino_CCA)

--PARAMETRO 
if exists(select 1 from ba_parametro where pa_batch = 7592)
begin
   delete  ba_parametro where pa_batch = 7592
end
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES ( 0, 7592, 0, 1, 'param1', 'D',  getdate())

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES ( 0, 7592, 0, 2, 'param2', 'D',  getdate())
 


--21008
if exists (select 1 from ba_batch where ba_batch =  21008 and ba_nombre = 'REPORTE DE BURO DIARIO' )
begin
   delete ba_batch where ba_batch =  21008 and ba_nombre = 'REPORTE DE BURO DIARIO'
end
insert into cobis..ba_batch 
(ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (21008,  'REPORTE DE BURO DIARIO', 'REPORTE DE BURO DIARIO','SP', getdate(), 21, 'P', 1, 'CREDITO','BURO_CREDITO_','cob_credito..sp_reporte_buro_batch', 1,   null, @w_server, 'S', @w_path_fuente_CRE, @w_path_destino_CRE)

--PARAMETRO 
if exists(select 1 from ba_parametro where pa_batch = 21008)
begin
   delete  ba_parametro where pa_batch = 21008
end
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES ( 0, 21008, 0, 1, 'param1', 'D',  getdate())

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES ( 0, 21008, 0, 2, 'param2', 'D',  getdate())
 



--2044
if exists (select 1 from ba_batch where ba_batch =  2044 and ba_nombre = 'REPORTE INGRESOS AL SISTEMA' )
begin
   delete ba_batch where ba_batch =  2044 and ba_nombre = 'REPORTE INGRESOS AL SISTEMA'
end
insert into cobis..ba_batch 
(ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (2044,  'REPORTE INGRESOS AL SISTEMA', 'REPORTE INGRESOS AL SISTEMA','SP', getdate(), 2, 'P', 1, 'CLIENTES','INGRESOS_AL_SISTEMA_','cobis..sp_rep_ingresos_sistema', 1,   null, @w_server, 'S', @w_path_fuente_CLI, @w_path_destino_CLI)

--PARAMETRO 
if exists(select 1 from ba_parametro where pa_batch = 2044)
begin
   delete  ba_parametro where pa_batch = 2044
end
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES ( 0, 2044, 0, 1, 'param1', 'D',  getdate())

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES ( 0, 2044, 0, 2, 'param2', 'D',  getdate())
 
go


--ERRORES
if exists (select 1 from cl_errores where numero =  17048 )
begin
   delete cl_errores where numero =  17048
END
INSERT INTO cl_errores(numero, severidad, mensaje) VALUES(17048 ,0, 'ERROR AL INSERTAR REGISTRO EN TABLA CA_COBRANZA_BATCH')
GO

if exists (select 1 from cl_errores where numero =  17049)
begin
   delete cl_errores where numero =  17049
END
INSERT INTO cl_errores(numero, severidad, mensaje) VALUES(17049 ,0, 'ERROR AL INSERTAR REGISTRO EN TABLA CR_BURO_DIARIO')
GO

if exists (select 1 from cl_errores where numero =  17050)
begin
   delete cl_errores where numero =  17050
END
INSERT INTO cl_errores(numero, severidad, mensaje) VALUES(17050 ,0, 'ERROR AL INSERTAR REGISTRO EN TABLA CR_BURO_DIARIO')
GO