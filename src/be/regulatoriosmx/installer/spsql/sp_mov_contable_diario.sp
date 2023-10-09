/*************************************************************************/
/*   Archivo:              sp_mov_contable_diario.sp                     */
/*   Stored procedure:     sp_mov_contable_diario                        */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         DCU                                           */
/*   Fecha de escritura:   Mayo 2018                                     */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   Movimentos contables del mes anterior a la fecha de proceso         */
/*                              CAMBIOS                                  */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    28/May/2018           DCU              emision inicial             */
/*    31/Ene/2019           JLSDV         modificaciones req # 108543    */
/*    26/Feb/2019           JLSDV      Error en encabezados req # 108543 */
/*    07/Nov/2019           MTA        Deshabilitar el sp                */
/*************************************************************************/
use cob_conta_super
go

if exists(select 1 from sysobjects where name = 'sp_mov_contable_diario')
    drop proc sp_mov_contable_diario
go

create proc sp_mov_contable_diario 
(
	@i_param1  DATETIME
)
AS

DECLARE
@w_sp_name          VARCHAR(64),
@w_msg              VARCHAR(255),
@w_ciudad_nacional  SMALLINT,
@w_primer_dia_habil DATETIME,
@w_fecha_desde      DATETIME,
@w_fecha_hasta      DATETIME,
@w_sep              CHAR(1)

DECLARE
@w_return            INT,
@w_empresa           TINYINT,
@w_fecha_proceso     DATETIME,
@w_file_rpt          varchar(100),
@w_file_rpt_1        varchar(140),
@w_file_rpt_1_out    varchar(140),
@w_bcp               varchar(2000),
@w_path_destino      varchar(200),
@w_s_app             varchar(40),
@w_fecha_r           varchar(10),
@w_mes               varchar(2),
@w_dia               varchar(2),
@w_anio              varchar(4)

-- Elimina la tabla temporal #tmp_mov_diario 
IF OBJECT_ID('tempdb..#tmp_mov_diario') 
	IS NOT NULL DROP TABLE #tmp_mov_diario

SELECT @w_sp_name       = 'sp_mov_contable_mes',
       @w_fecha_proceso = @i_param1
	   
return 0  --MTA se deshabilita el sp ya que no se usa por pedido del banco

SELECT @w_sep = '|'
--SELECT @w_sep = CHAR(64)



select @w_empresa = pa_tinyint 
from   cobis..cl_parametro
where  pa_nemonico = 'EMP' 
and pa_producto    = 'ADM'

if @@rowcount <> 1 
begin
   select 
		@w_return = 101254,
      @w_msg = 'NO ESTA DEFINIDA LA EMPRESA CONTABLE'
   goto ERROR_PROCESO
end

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

select @w_path_destino = pp_path_destino
from   cobis..ba_path_pro
where  pp_producto = 6 -- CONTABILIDAD

/* DETERMINAR INICIO DE MES ACTUAL */
select @w_fecha_desde = dateadd(dd, 1-datepart(dd, @w_fecha_proceso), @w_fecha_proceso)

/* DETERMINAR SI SE EJECUTA O NO EL REPORTE */
select @w_mes         = substring(convert(varchar,@w_fecha_proceso, 101),1,2)
select @w_dia         = substring(convert(varchar,@w_fecha_proceso, 101),4,2)
select @w_anio        = substring(convert(varchar,@w_fecha_proceso, 101),7,4)

select @w_fecha_r = @w_dia + '_' + @w_mes + '_' + @w_anio

select @w_file_rpt = 'Movimientos_Contables_Acumulados' -- Cambio de nombre Movimientos_Contables
select @w_file_rpt_1     = @w_path_destino + @w_file_rpt + '_' + @w_fecha_r + '.txt'
select @w_file_rpt_1_out = @w_path_destino + @w_file_rpt + '_' + @w_fecha_r + '.err'

--Se copian los datos a la tabla temporal #tmp_mov_diario
select    
   mdt_concepto		= sa_concepto, 
   mdt_fecha_tran	= CONVERT(VARCHAR, sa_fecha_tran,  103),
   mdt_comprobante	= CONVERT(VARCHAR, sa_comprobante),
   mdt_cuenta		= sa_cuenta,   
   mdt_oficina_dest = LTRIM(CONVERT(VARCHAR(20), sa_oficina_dest)),
   mdt_area_dest	= CONVERT(VARCHAR, sa_area_dest),
   mdt_debito		= CONVERT(VARCHAR, ISNULL(sa_debito, 0)),      
   mdt_credito		= CONVERT(VARCHAR, ISNULL(sa_credito,0)),
   mdt_prestamo		= ISNULL(CASE WHEN sa_concepto like '%GAR%' THEN CONVERT(VARCHAR, sa_ente) ELSE sa_documento END, ' '),
   mdt_grupo		= CONVERT(varchar(20),' '),
   mdt_es_gar		= CASE WHEN sa_concepto like '%GAR%' THEN 'S' ELSE 'N' END,
   mdt_producto		= sa_producto
into #tmp_mov_diario
from cob_conta_tercero..ct_sasiento with (index = ct_sasiento_AKey1 nolock)
where sa_empresa       = @w_empresa
and   sa_fecha_tran    between @w_fecha_desde and @w_fecha_proceso
order by sa_empresa, sa_cuenta, sa_fecha_tran, 
         sa_oficina_dest, sa_area_dest, sa_ente

update #tmp_mov_diario set 
mdt_grupo = cg_grupo
from cobis..cl_cliente_grupo 
where cg_ente = convert(int, mdt_prestamo)
and cg_fecha_desasociacion is null 
and mdt_es_gar = 'S'
		 
update #tmp_mov_diario 
set mdt_grupo = dc_grupo
from cob_cartera..ca_operacion, cob_cartera..ca_det_ciclo 
where op_banco = mdt_prestamo 
and op_operacion = dc_operacion
and mdt_es_gar = 'N' 
and mdt_producto = 7

--Se elimina datos de la tabla
TRUNCATE TABLE sb_mov_diario_tmp

-- Se crea el encabezado
INSERT INTO sb_mov_diario_tmp
SELECT 'CONCEPTO', 'FECHA', 'COMPROBANTE', 'CUENTA', 'OFICINA', 'AREA', 'DEBITO', 'CREDITO', 'NUMERO CREDITO', 'ID GRUPO'

INSERT INTO sb_mov_diario_tmp
SELECT 
   mdt_concepto = mdt_concepto,
   mdt_fecha_tran = mdt_fecha_tran,
   mdt_comprobante = mdt_comprobante,
   mdt_cuenta = mdt_cuenta,   
   mdt_oficina_dest = mdt_oficina_dest ,
   mdt_area_dest = mdt_area_dest,
   mdt_debito = mdt_debito,     
   mdt_credito = mdt_credito,
   mdt_prestamo = mdt_prestamo,
   mdt_grupo = mdt_grupo
FROM #tmp_mov_diario          

SELECT @w_bcp = @w_s_app + 's_app bcp -auto -login ' + 'cob_conta_super..sb_mov_diario_tmp' + ' out ' + @w_file_rpt_1 + ' -c -t\t -b 5000 -e' + @w_file_rpt_1_out + ' -config ' + @w_s_app + 's_app.ini'
PRINT '===> ' + @w_bcp 

--Ejecucion para Generar Archivo Datos
exec @w_return = xp_cmdshell @w_bcp

if @w_return <> 0 
begin
  select @w_return = 70146,
  @w_msg = 'Fallo el BCP'
  goto ERROR_PROCESO
end

SALIDA_PROCESO:

return 0

ERROR_PROCESO:

exec @w_return       = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @i_param1,
     @i_origen_error = @w_return,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

return @w_return

GO
