/*************************************************************************************/
--No Historia				 : H83193
--Título de la Historia		 : PASO DE DATOS A cob_conta_super
--Fecha					     : 13/06/2016
--Descripción del Problema	 : Se requiero de una funcionalidad que consulte las 
--                             retenciones (ISR) generadas por todos los productos COBIS
--Descripción de la Solución : Determinar los procesos que realizan el paso de datos a cob_externos
--                             Determinar los procesos que realizan el paso de datos a cob_conta_super
--Autor						 : Jorge Salazar Andrade
--Instalador                 : cbsup_table.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/RegulatoriosMX/BackEnd/sql
/*************************************************************************************/
USE cob_conta_super
GO

IF OBJECT_ID ('dbo.sb_calendario_proyec') IS NOT NULL
	DROP TABLE dbo.sb_calendario_proyec
GO

CREATE TABLE [sb_calendario_proyec]
(
	[cp_fecha_proc] [datetime] NOT NULL,
	[cp_tipo_info] [varchar](10) NOT NULL,
	[cp_fecha_ing] [datetime] NOT NULL
)

CREATE NONCLUSTERED INDEX [idx1] ON [sb_calendario_proyec]
(
	[cp_fecha_proc]
)
GO


/*************************************************************************************/
--No Historia				 : H83193
--Título de la Historia		 : PASO DE DATOS A cob_conta_super
--Fecha					     : 13/06/2016
--Descripción del Problema	 : Determinar los procesos que realizan el paso de datos a cob_externos
--                             Determinar los procesos que realizan el paso de datos a cob_conta_super
--Descripción de la Solución : Creacion de parametro general CIUN: CODIGO CIUDAD FERIADOS NACIONALES
--Autor						 : Jorge Salazar Andrade
--Instalador                 : adm_param.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/CtasCteAho/Dependencias/sql
/*************************************************************************************/
USE cobis
GO

DELETE FROM cobis..cl_parametro
 WHERE pa_nemonico = 'CIUN' 
   AND pa_producto = 'ADM'

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO CIUDAD FERIADOS NACIONALES', 'CIUN', 'I', NULL, NULL, NULL, 99999, NULL, NULL, NULL, 'ADM')
GO


/*************************************************************************************/
--No Historia				 : H83193
--Título de la Historia		 : PASO DE DATOS A cob_conta_super
--Fecha					     : 13/06/2016
--Descripción del Problema	 : Determinar los procesos que realizan el paso de datos a cob_externos
--                             Determinar los procesos que realizan el paso de datos a cob_conta_super
--Descripción de la Solución : Creacion de la sarta 14001: CONTABILIDAD DE PLAZO FIJO 
--Autor						 : Jorge Salazar Andrade
--Instalador                 : pf_batch.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/CtasCteAho/Dependencias/sql
/*************************************************************************************/
use cobis
go

print '-->Procesos Batch: Sarta 14001: CONTABILIDAD DE PLAZO FIJO'
if exists (select 1 from cobis..ba_sarta where sa_sarta like '14001%')
   delete cobis..ba_sarta where sa_sarta like '14001%'
go

insert into cobis..ba_sarta values (14001,'CONTABILIDAD DE PLAZO FIJO','CONTABILIDAD DE PLAZO FIJO','05/28/2014','wcastillo',14,null,null)
go

print '-->Procesos Batch: Batch'
if exists (select 1 from cobis..ba_sarta_batch, cobis..ba_batch where sb_sarta like '14001%' and sb_batch = ba_batch)
   delete cobis..ba_batch from cobis..ba_sarta_batch, cobis..ba_batch where sb_sarta like '14001%' and sb_batch = ba_batch
go

declare @w_usuario       varchar(60),
        @w_servidor      varchar(100),
        @w_path_destino  varchar(100),
        @w_path_fuente   varchar(100),
        @w_producto      int,
        @w_fecha_proceso datetime

select  @w_usuario   = 'admuser',
        @w_producto  = 14

--Fecha cierre
delete cobis..ba_fecha_cierre where fc_producto = @w_producto

select @w_fecha_proceso = isnull(fp_fecha, getdate()) from ba_fecha_proceso   

insert into cobis..ba_fecha_cierre (fc_producto, fc_fecha_cierre, fc_fecha_propuesta)
values (@w_producto, @w_fecha_proceso, null)

--Path de producto
delete cobis..ba_path_pro where pp_producto = @w_producto

insert into cobis..ba_path_pro (pp_producto, pp_path_fuente, pp_path_destino)
values (@w_producto, 'C:/Cobis/vbatch/Pfijo/objetos/', 'C:/Cobis/vbatch/Pfijo/listados/')

select @w_servidor = pa_char
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'SRVR'

select @w_path_destino = pp_path_destino
  from ba_path_pro
 where pp_producto = @w_producto

select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/Pfijo/listados/')

select @w_path_fuente = pp_path_fuente
  from ba_path_pro
 where pp_producto = @w_producto

select @w_path_fuente = isnull(@w_path_fuente, 'C:/Cobis/vbatch/Pfijo/objetos/')

insert into cobis..ba_batch values ('14003', 'GENERACION DE TOTALES PARA GRAFICOS ESTADISTICOS', 'GENERACION DE TABLA DE TOTALES PARA LOS GRAFICOS ESTADISTICOS EN EL FRONT-END DEL MODULO', 'SP ', '02/20/2010', '14', 'P', '1', 'PF_ESTADISTICA', '', 'cob_pfijo..sp_graba_totales', '50', '', @w_servidor, 'S', @w_path_fuente, '')
insert into cobis..ba_batch values ('14005', 'PROGRAMA DE CONTABILIDAD', 'PROGRAMA DE CONTABILIDAD', 'SP ', '02/20/2010', '14', 'R', '1', 'PF_TRANSACCION', 'texto.lis', 'cob_pfijo..sp_conta', '50', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14006', 'DESMARCADOR', 'DESMARCADOR', 'SP ', '02/20/2010', '14', 'R', '1', '', 'textol.is', 'cob_pfijo..sp_desmarcar_trn', '50', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14008', 'REPORTE DE PROVISION DIARIA DE INTERESES', 'PERMITE VISUALIZAR LAS CANTIDADES QUE SE PROVISIONAN O AMORTIZAN EN EL DIA. IMPRIME LA PROVISION ACUMULADA, NUMERO DE DIAS PROVISIONADOS, INTERES PAGADO O INTERES POR AMORTIZAR.', 'QR ', '02/20/2010', '14', 'R', '1', 'PF_OPERACION,CL_CIUDAD,CL_OFICINA,PF_PLAZO', 'pf_prami.lis', 'pf_prami.sqr', '50', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14009', 'REC', 'REC', 'SP ', '02/20/2010', '14', 'R', '1', '', 'texto.lis', 'cob_pfijo..sp_consolidador', '50', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14048', 'REPORTE DE ERROR BATCH', 'LISTADO DE LOG DE ERRORES', 'QR ', '02/20/2010', '14', 'R', '1', 'PF_ERRORLOG,PF_OPERACION,CL_ERRORES', 'pf_loger.lis', 'pf_loger.sqr', '50', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14090', 'GENERACION ARCHIVO (P) DECEVAL', 'GENERACION ARCHIVO (P) DECEVAL', 'SP ', '02/20/2010', '14', 'R', '1', '', 'arch_deceval_p.lis', 'cob_pfijo..sp_arch_deceval_p', '50', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14091', 'CARGA ARCHIVO (Z) DECEVAL', 'CARGA ARCHIVO (Z) DECEVAL', 'SP ', '02/20/2010', '14', 'R', '1', '', 'arch_deceval_p.lis', 'cob_pfijo..sp_arch_deceval_z', '50', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14092', 'REPORTE OPERACIONES DECEVAL', 'REPORTE OPERACIONES DECEVAL', 'QR ', '02/20/2010', '14', 'R', '1', '', 'deceval.lis', 'deceval.sqr', '50', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14093', 'MAESTRO PLAZO FIJO', 'GENERA ARCHIVO PLANO MAESTRO PFIJO', 'SP ', '04/12/2010', '14', 'R', '1', 'PF_OPERACION,PF_CUOTAS', 'maestro_pf.lis', 'cob_pfijo..maestro_pf', '50', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('14094', 'MAESTRO PROYECCIONES FIJO', 'GENERA ARCHIVO PLANO MAESTRO PROYECCIONES PFIJO', 'SP ', '04/12/2010', '14', 'R', '1', 'PF_OPERACION,PF_CUOTAS', 'mestro_pry_pf.lis', 'cob_pfijo..maestro_pry_pf', '50', 'lp', @w_servidor, 'S', @w_path_fuente, @w_path_destino)
insert into cobis..ba_batch values ('6525',  'VALIDACION DE COMPROBANTES POR PRODUCTO', 'VALIDACION DE COMPROBANTES POR PRODUCTO', 'SP ', '05/23/2009', '6', 'P', '1', 'COMPROBANTES', '', 'cob_conta..sp_ejec_asientos_val', '100', '', @w_servidor, 'S', @w_path_fuente, '')
go


print '-->Procesos Batch: Sarta-Batch'
if exists (select 1 from cobis..ba_sarta_batch where sb_sarta like '14001%')
   delete cobis..ba_sarta_batch where sb_sarta like '14001%'
go

insert into cobis..ba_sarta_batch values (14001, 14003 , 2  , null , 'S' , 'N' , 1695  , 540  , 21007 , 'N')
insert into cobis..ba_sarta_batch values (14001, 14005 , 3  , '2'  , 'S' , 'N' , 2790  , 555  , 21007 , 'S')
insert into cobis..ba_sarta_batch values (14001, 14006 , 4  , '1'  , 'S' , 'N' , 3870  , 540  , 21007 , 'S')
insert into cobis..ba_sarta_batch values (14001, 14008 , 7  , null , 'S' , 'N' , 6180  , 2025 , 21007 , 'S')
insert into cobis..ba_sarta_batch values (14001, 14009 , 5  , '4'  , 'S' , 'N' , 5025  , 540  , 21007 , 'S')
insert into cobis..ba_sarta_batch values (14001, 14048 , 6  , '5'  , 'S' , 'N' , 6195  , 540  , 21007 , 'S')
insert into cobis..ba_sarta_batch values (14001, 14090 , 8  , null , 'S' , 'N' , 7230  , 2070 , 21007 , 'S')
insert into cobis..ba_sarta_batch values (14001, 14091 , 9  , '8'  , 'S' , 'N' , 8460  , 2085 , 21007 , 'S')
insert into cobis..ba_sarta_batch values (14001, 14092 , 10 , '9'  , 'S' , 'N' , 9690  , 2085 , 21007 , 'S')
insert into cobis..ba_sarta_batch values (14001, 14093 , 11 , '10' , 'S' , 'N' , 10830 , 2070 , 21007 , 'S')
insert into cobis..ba_sarta_batch values (14001, 14094 , 12 , '11' , 'S' , 'N' , 11955 , 2055 , 21007 , 'S')
insert into cobis..ba_sarta_batch values (14001, 6525  , 1  , null , 'S' , 'N' , 450   , 525  , 21007 , 'S')
go

print '-->Procesos Batch: Parametro'
if exists (select 1 from cobis..ba_sarta_batch, cobis..ba_batch, cobis..ba_parametro 
            where sb_batch = ba_batch 
              and ba_batch = pa_batch
              and sb_sarta = pa_sarta
              and sb_sarta in (14001))
   delete cobis..ba_parametro from cobis..ba_sarta_batch, cobis..ba_batch, cobis..ba_parametro 
    where sb_batch = ba_batch 
      and ba_batch = pa_batch
      and sb_sarta = pa_sarta
      and sb_sarta in (14001)
go

insert into cobis..ba_parametro values (14001 , 14008 , 7  , 1 , 'FECHA'          , 'D' , '03/24/2015')
insert into cobis..ba_parametro values (14001 , 14094 , 12 , 2 , 'FECHA FINAL'    , 'D' , '03/24/2015')
insert into cobis..ba_parametro values (14001 , 6525  , 1  , 3 , 'PRODUCTO'       , 'I' , '14'        )
insert into cobis..ba_parametro values (14001 , 14048 , 6  , 1 , 'FECHA INICIAL'  , 'D' , '03/24/2015')
insert into cobis..ba_parametro values (14001 , 14093 , 11 , 1 , 'FECHA INICIAL'  , 'D' , '03/24/2015')
insert into cobis..ba_parametro values (14001 , 14048 , 6  , 2 , 'FECHA FINAL'    , 'D' , '03/24/2015')
insert into cobis..ba_parametro values (14001 , 14008 , 7  , 3 , 'CIUDAD'         , 'C' , 'T'         )
insert into cobis..ba_parametro values (14001 , 14003 , 2  , 1 , 'FECHA'          , 'D' , '03/24/2015')
insert into cobis..ba_parametro values (14001 , 14094 , 12 , 1 , 'FECHA INICIAL'  , 'D' , '03/24/2015')
insert into cobis..ba_parametro values (14001 , 6525  , 1  , 1 , 'OPERACION (V)'  , 'C' , 'V'         )
insert into cobis..ba_parametro values (14001 , 14008 , 7  , 2 , 'TOPERACION'     , 'C' , 'T'         )
insert into cobis..ba_parametro values (14001 , 14008 , 7  , 4 , 'OFICINA'        , 'C' , 'T'         )
insert into cobis..ba_parametro values (14001 , 6525  , 1  , 2 , 'EMPRESA'        , 'I' , '1'         )
insert into cobis..ba_parametro values (14001 , 14093 , 11 , 2 , 'FECHA FINAL'    , 'D' , '03/24/2015')
go

print '-->Procesos Batch: Enlace'
if exists (select 1 from cobis..ba_enlace where en_sarta in (14001))
   delete cobis..ba_enlace where en_sarta in (14001)
go

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (14001, 6525, 1, 14003, 2, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (14001, 14003, 2, 14005, 3, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (14001, 14005, 3, 14006, 4, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (14001, 14006, 4, 14009, 5, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (14001, 14009, 5, 14048, 6, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (14001, 14048, 6, 14008, 7, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (14001, 14008, 7, 14090, 8, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (14001, 14090, 8, 14091, 9, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (14001, 14091, 9, 14092, 10, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (14001, 14092, 10, 14093, 11, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (14001, 14093, 11, 14094, 12, 'S', null, 'N')

insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values (14001, 14094, 12, 0, 0, 'S', null, 'N')
go


/*************************************************************************************/
--No Historia				 : H83193
--Título de la Historia		 : PASO DE DATOS A cob_conta_super
--Fecha					     : 13/06/2016
--Descripción del Problema	 : Determinar los procesos que realizan el paso de datos a cob_externos
--                             Determinar los procesos que realizan el paso de datos a cob_conta_super
--Descripción de la Solución : Creacion de catalogos de equivalencia CATPRODUCT, TIPCONCEPT, TIPESTPRY
--Autor						 : Jorge Salazar Andrade
--Instalador                 : pf_conta.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/PlazoFijo/backend/central/sql
/*************************************************************************************/
use cob_pfijo
go

delete cob_pfijo..pf_equivalencias
 where eq_modulo = 36
   and eq_tabla in ('CATPRODUCT','TIPCONCEPT','TIPESTPRY')
go

insert into cob_pfijo..pf_equivalencias values (36, 'CATPRODUCT', null,     30, 999999999, 'CDT',  'CERTIFICADO DE DEPOSITO A TERMINO')
insert into cob_pfijo..pf_equivalencias values (36, 'CATPRODUCT', null,      1,        29, 'CDAT', 'CERTIFICADO DE DEPOSITO A TERMINO FIJO')

insert into cob_pfijo..pf_equivalencias values (36, 'TIPCONCEPT', 'CAP',   null,     null, 'CAP',  'CAPITAL')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPCONCEPT', 'INT',   null,     null, 'INT',  'INTERES')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPCONCEPT', 'RET',   null,     null, 'RET',  'RETENCION')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPCONCEPT', 'GMF',   null,     null, 'GMF',  'GRAVAMEN MOVIMIENTO FINANCIERO')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPCONCEPT', 'CHC',   null,     null, 'CHCOMER',  'CHEQUE COMERCIAL')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPCONCEPT', 'CHQL',  null,     null, 'CHLOCAL',  'CHEQUE LOCAL')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPCONCEPT', 'CHG',   null,     null, 'CHGEREN',  'CHEQUE GERENCIA')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPCONCEPT', 'PCHC',  null,     null, 'CTAPTE',  'CTA PTE CHEQUE COM')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPCONCEPT', 'CTRL',  null,     null, 'CTAPTE',     'CTA PTE')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPCONCEPT', 'EFEC',  null,     null, 'EFMN',     'EFECTIVO')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPCONCEPT', 'OTROS', null,     null, 'CTAPTE',     'CTA PTE')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPCONCEPT', 'VXP',   null,     null, 'CTAPTE',     'CTA PTE')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPCONCEPT', 'SEBRA', null,     null, 'SEBRA',     'SEBRA')

insert into cob_pfijo..pf_equivalencias values (36, 'TIPESTPRY',  'ING',   null,     null, '0',    'NO VIGENTE')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPESTPRY',  'ACT',   null,     null, '1',    'VIGENTE')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPESTPRY',  'VEN',   null,     null, '2',    'VENCIDO')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPESTPRY',  'CAN',   null,     null, '3',    'CANCELADO')
insert into cob_pfijo..pf_equivalencias values (36, 'TIPESTPRY',  'XACT',  null,     null, '0',    'NO VIGENTE')
go

