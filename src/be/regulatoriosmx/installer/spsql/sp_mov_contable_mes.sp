/*************************************************************************/
/*   Archivo:              sp_mov_contable_mes.sp                        */
/*   Stored procedure:     sp_mov_contable_mes                           */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         LGU                                           */
/*   Fecha de escritura:   Abril 2018                                    */
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
/*    16/Abr/18             LGU              emision inicial             */
/*    31/Ene/2019           JLSDV        modificaciones req # 108543     */
/*    26/Feb/2019           JLSDV  error en los encabezados req # 108543 */
/*                                                                       */
/*    07/Ago/2019           DXCC         Req. #  123571                  */ 
/*    28/Oct/2019           DXCC         Inc. #128564                    */
/*    07/Nov/2019           MTA          Inc. 127543                     */
/*    10/Dic/2019           MTA        Cambio de nombre reporte diario   */
/*    18/11/2020            JCASTRO  Cambio nombre reporte REQ#149340    */
/*    25/11/2020            DCumbal  Cambio actualizacion rgupo #149622  */
/*************************************************************************/
use cob_conta_super
go

if exists(select 1 from sysobjects where name = 'sp_mov_contable_mes')
    drop proc sp_mov_contable_mes
go

create proc sp_mov_contable_mes 
(
	@i_param1  DATETIME,
	@i_param2  varchar(10) --BATCH 
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
@w_anio              varchar(4),
@w_fecha_piv         datetime,
@w_cont              int,
@w_mensual           char(1),
@w_proceso_mensual   int

select @w_mensual = 'N'
select @w_proceso_mensual = pa_int from cobis..cl_parametro where pa_nemonico = 'CBMMC' and pa_producto = 'CON'

if convert(int,@i_param2) = @w_proceso_mensual -- batch mensual
   select @w_mensual = 'S'

SELECT @w_sp_name       = 'sp_mov_contable_mes',
       @w_fecha_proceso = @i_param1

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
where  pp_producto = 36 -- REGULATORIOS

/* DETERMINAR INICIO Y FIN DE MES ANTERIOR */
if @w_mensual = 'S'
begin
   SELECT @w_fecha_hasta = dateadd(dd, -1*datepart(dd, @w_fecha_proceso), @w_fecha_proceso )
   SELECT @w_fecha_desde = dateadd(dd, 1, dateadd(dd, -1*datepart(dd, @w_fecha_hasta), @w_fecha_hasta ))
      
   select @w_file_rpt = 'Movimientos_Contables_Acumulado_Mes' -- Cambio de nombre Movimientos_Contables REQ#149340
   
   --CONTROL PARA NO EJECUTAR SI NO ES EL 4 DIA HABIL DEL MES
   select 
   @w_cont      = 0, 
   @w_fecha_piv = @w_fecha_proceso
   
   while @w_fecha_piv > @w_fecha_hasta  
   begin
      if not exists ( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_piv)
         select @w_cont = @w_cont +1
         
         select @w_fecha_piv = dateadd (dd,-1 ,@w_fecha_piv)
   end
   
   if @w_cont >= 5 
   BEGIN
	  print' SALE porque solo se ejecuta los primeros DIAS del MES ' + convert(VARCHAR, @w_cont )
      return 0
   END 
end 
else
begin
   SELECT @w_fecha_hasta = @w_fecha_proceso 
   SELECT @w_fecha_desde = dateadd(dd, 1, dateadd(dd, -1*datepart(dd, @w_fecha_hasta), @w_fecha_hasta ))
   select @w_file_rpt = 'Movtos_Contab_AC' -- Cambio de nombre Movimientos_Contables REQ#149340
end 
 
print 'w_fecha_hasta  '+ convert(varchar,@w_fecha_hasta)
print 'w_fecha_desde  '+ convert(varchar,@w_fecha_desde)
print @w_file_rpt
 
if exists (select 1 from sb_ods_ult_ejec where ou_archivo = @w_file_rpt and ou_fecha = @w_fecha_hasta) 
BEGIN
	PRINT ' ya existen datos'
    delete sb_ods_ult_ejec where ou_archivo = @w_file_rpt and ou_fecha = @w_fecha_hasta --MTA borra la data de los registros de los primeros 4 dias
end

select @w_mes         = substring(convert(varchar,@w_fecha_hasta, 101),1,2)
select @w_dia         = substring(convert(varchar,@w_fecha_hasta, 101),4,2)
select @w_anio        = substring(convert(varchar,@w_fecha_hasta, 101),7,4)

select @w_fecha_r = @w_dia + '_' + @w_mes + '_' + @w_anio

select @w_file_rpt_1     = @w_path_destino + @w_file_rpt + '_' + @w_fecha_r + '.txt'
select @w_file_rpt_1_out = @w_path_destino + @w_file_rpt + '_' + @w_fecha_r + '.err'

-- Se copian los datos a la tabla temporal #tmp_mov_mes
select 
   mmt_concepto		= sa_concepto, 
   mmt_fecha_tran	= CONVERT(VARCHAR, sa_fecha_tran,  103),
   mmt_comprobante	= CONVERT(VARCHAR, sa_comprobante),
   mmt_cuenta		= sa_cuenta,   
   mmt_oficina_dest = LTRIM(CONVERT(VARCHAR(20), sa_oficina_dest)),
   mmt_area_dest	= CONVERT(VARCHAR, sa_area_dest),
   mmt_debito		= CONVERT(VARCHAR, ISNULL(sa_debito, 0)),      
   mmt_credito		= CONVERT(VARCHAR, ISNULL(sa_credito,0)),
   mmt_prestamo		= ISNULL(
		   					case 
		   						when sa_concepto like '%Trn:GAR %' 
		   								THEN substring(sa_concepto, charindex('Cli:',sa_concepto)+4, 
		   																	 charindex('Sec:',sa_concepto)-1 -
		   																	(charindex('Cli:',sa_concepto)+4))
		   						when sa_concepto like '%PRV.%' 
		   								THEN substring(sa_concepto, charindex('Op:' ,sa_concepto)+3,
		   																	 charindex(' Co:',sa_concepto) -
		   																	 (charindex('Op:' ,sa_concepto)+3))
		   						when sa_concepto like '%Ban:%' 
		   								THEN substring(sa_concepto, charindex('Ban:',sa_concepto)+4,
		   																	 charindex('Sec:',sa_concepto)-1 -
		   																	 (charindex('Ban:',sa_concepto)+4))
		   						else 
		   								sa_documento
		   						end, 
		   					' ' ),
   mmt_grupo		= CONVERT(varchar(20),' '),
   mmt_es_gar		= case 
   							when sa_concepto like '%Trn:GAR%' or sa_concepto like '%Trn:DGL %' 
   							  or sa_concepto like '%Trn:DSE %'or sa_concepto like '%Trn:SEG %'  then 'S' 
   							when sa_concepto like '%Trn:DSC%' then 'G' 
   						else 'N' end,
   mmt_producto		= sa_producto
into #tmp_mov_mes
from cob_conta_tercero..ct_sasiento 
where sa_empresa       = @w_empresa
and   sa_fecha_tran   between @w_fecha_desde and @w_fecha_hasta
order by sa_empresa, sa_cuenta, sa_fecha_tran, 
         sa_oficina_dest, sa_area_dest, sa_ente  
		 
         
		 
update #tmp_mov_mes set 
mmt_grupo = cg_grupo
from cobis..cl_cliente_grupo 
where cg_ente = convert(int, mmt_prestamo)
and cg_fecha_desasociacion is null 
and mmt_es_gar = 'S'
	
update #tmp_mov_mes set 
mmt_grupo = dc_grupo
from cob_cartera..ca_operacion, cob_cartera..ca_det_ciclo 
where op_banco = mmt_prestamo 
and op_operacion = dc_operacion
and mmt_es_gar = 'N' 
and mmt_producto = 7

	
update #tmp_mov_mes set 
mmt_grupo = ci_grupo
from cob_cartera..ca_ciclo 
where ci_prestamo = mmt_prestamo
and mmt_es_gar = 'G'  -- Para la nueva transaccion DSC (en tuiio confiamos)
and mmt_producto = 7

-- Se elimina datos de la tabla
TRUNCATE TABLE sb_mov_mes_tmp

-- Se crea el encabezado
INSERT INTO sb_mov_mes_tmp
SELECT 'CONCEPTO', 'FECHA', 'COMPROBANTE', 'CUENTA', 'OFICINA', 'AREA', 'DEBITO', 'CREDITO', 'NUMERO CREDITO', 'ID GRUPO'

INSERT INTO sb_mov_mes_tmp
SELECT 
   mmt_concepto		= mmt_concepto,
   mmt_fecha_tran	= mmt_fecha_tran,
   mmt_comprobante	= mmt_comprobante,
   mmt_cuenta		= mmt_cuenta,   
   mmt_oficina_dest = mmt_oficina_dest ,
   mmt_area_dest	= mmt_area_dest,
   mmt_debito		= mmt_debito,     
   mmt_credito		= mmt_credito,
   mmt_prestamo		= mmt_prestamo,
   mmt_grupo		= mmt_grupo 
FROM #tmp_mov_mes    

SELECT @w_bcp = @w_s_app + 's_app bcp -auto -login ' + 'cob_conta_super..sb_mov_mes_tmp' + ' out ' + @w_file_rpt_1 + ' -c -t\t -b 5000 -e' + @w_file_rpt_1_out + ' -config ' + @w_s_app + 's_app.ini'
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
  insert into sb_ods_ult_ejec values (@w_file_rpt, @w_fecha_hasta) --Tabla que lleva el registro de la ejecucion fin mes

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
