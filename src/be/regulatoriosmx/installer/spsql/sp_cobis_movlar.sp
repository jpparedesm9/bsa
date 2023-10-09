/*************************************************************************/
/*   Archivo:              sp_cobis_movlar.sp		                     */
/*   Stored procedure:     sp_cobis_movlar                               */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         Dario Cumbal - Daniel Berrio                  */
/*   Fecha de escritura:   Abril 2022                                    */
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
/*   Genera reporte COBIS_MOVLAR_AAAAMMDD.txt del requerimiento 172199   */
/*                                                                       */
/*       Parametros de Entrada                                           */
/*			Fecha de proceso                                             */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    04/Abril/2022          DBM              emision inicial            */
/*************************************************************************/


USE [cob_conta_super]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('dbo.sp_cobis_movlar') IS NOT NULL
	DROP PROCEDURE dbo.sp_cobis_movlar
GO

CREATE proc [dbo].[sp_cobis_movlar](
   @i_param1  DATETIME
)
AS

DECLARE
@w_formato_fecha int,
@w_fecha datetime,
@w_fecha_ini datetime,
@w_fecha_fin datetime,
@w_batch int,
@w_empresa INT,
@w_ruta_arch varchar(255),
@w_nombre_arch varchar(30),
@w_error int,
@w_reporte varchar(24),
@w_sql varchar(5000),
@w_sql_bcp varchar(5000),
@w_msg varchar(150),
@w_ciudad int

--obtiene parametro DISTRITO FERIADO NACIONAL
select @w_ciudad = pa_smallint 
	from cobis..cl_parametro 
	where pa_nemonico = 'CFN' 
	AND pa_producto = 'ADM'

if @@error != 0 or @@ROWCOUNT != 1
begin
   select @w_error = 609318
   goto ERROR_PROCESO
end


select @w_fecha  = @i_param1

--Se resta un día al proceso porque se ejecutará al inicio de día del día siguiente
select @w_fecha  = dateadd(dd,-1, @w_fecha )

while exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha  and df_ciudad = @w_ciudad)
begin
                select @w_fecha  = dateadd(dd,-1, @w_fecha )
end

--Reporte 6.11 COBIS_MOVLAR_AAAAMMDD.txt

select  @w_formato_fecha = 111, 
		@w_batch = 36430, 
		@w_empresa = 1 

select	
@w_ruta_arch	= ba_path_destino,
--@w_nombre_arch	= replace(convert(varchar,@i_param1, 106), ' ', '_')
@w_nombre_arch	= CONVERT(varchar,DATEPART(yyyy, @w_fecha),4)+CONVERT(varchar,cobis.dbo.fn_llena_0(DATEPART(mm, @w_fecha),2),2)+CONVERT(varchar,cobis.dbo.fn_llena_0(DATEPART(dd, @w_fecha),2),2)

from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
END

IF OBJECT_ID('tempdb..##tmp_cobis_movlar') IS NOT NULL DROP TABLE ##tmp_cobis_movlar

select 
@w_fecha_ini = DATEADD(dd, DATEDIFF(dd, 0, @w_fecha), 0),
@w_fecha_fin = DATEADD(second, 59, DATEADD(hour, 23, DATEADD(minute, 59, DATEADD(dd, DATEDIFF(dd, 0, @w_fecha), 0))))


SELECT
datos =
cobis.dbo.fn_llena_0('78',4) + 
cobis.dbo.fn_llena_0(sa_asiento,7) +
cobis.dbo.fn_llena_0(sa_asiento,9) + --N_NUMASOFI
cobis.dbo.fn_llena_0(sa_comprobante,7) + --N_NUM-APUNTE
convert(varchar,sa_fecha_tran,23)  + --D_FECHA_CONTABLE
convert(varchar,sc_fecha_gra,23)  + --D_FECHA_PROC
'S'+--V_HAYCLAUT
cobis.dbo.fn_llena_0(sa_cuenta,15) + --V_COD_CUENTA
cobis.dbo.fn_llena_0(sc_oficina_orig,4)+ --V_COD_CENTRO_OPE
cobis.dbo.fn_llena_0(sc_oficina_orig,4)+ --V_COD_CENTRO_ORI
cobis.dbo.fn_llena_0(sa_oficina_dest,4)+ --V_COD_CENTRO_DESTINO
'MXP' + --V_COD_DIVISA
' ' + --V_HATDVISA
cobis.dbo.fn_llena_0(sum(case when sa_debito  <> 0 then 1 else 0 end ),7) +--N_NUM_OPE_DEBE
cobis.dbo.fn_llena_0(sum(case when sa_credito <> 0 then 1 else 0 end ),7) +--N_NUM_OPE_HABER
case when sum(sa_debito) < 0 then
      '-'+cobis.dbo.fn_llena_0(convert(varchar,-sum(sa_debito)),17)
else
      cobis.dbo.fn_llena_0(convert(varchar,sum(sa_debito)),18)
end +--N_DEBE
case when sum(sa_credito) < 0 then
      '-'+cobis.dbo.fn_llena_0(convert(varchar,-sum(sa_credito)),17)
else
      cobis.dbo.fn_llena_0(convert(varchar,sum(sa_credito)),18)
end +--N_HABER
cobis.dbo.fn_llena_0('0.00',18)+ --N_DEBE_DIVISA
cobis.dbo.fn_llena_0('0.00',18)+ --N_HABER_DIVISA
'N'+ --V_CORRECCION
case when sa_producto = 6 then 'S' else 'N' end+--V_AJUSTE_MANUAL
cobis.dbo.fn_llena_0('0.000000',17)+--N_TIPO_CAMBIO
'N'+--V_INDNUMDO
'            '+--V_NUMDO
'            '+--V_REFDOC
'          '+--V_FALTPART
case when charindex('Trn',sa_concepto,0)  > 0 then 
          substring(sa_concepto,charindex('Trn',sa_concepto,0) + 4, 3)
     when charindex('PRV.',sa_concepto,0)  > 0 then
          'PRV'    
else '   ' end +  --V_CLACON  
convert(char(14),case when charindex('Trn',sa_concepto,0)  > 0 then 
     (select substring(c.valor,1,14)
      from cobis..cl_tabla t, cobis..cl_catalogo c
      where t.tabla = 'cl_cla_con'
      and t.codigo  = c.tabla
      and c.codigo  =  substring(sa_concepto,charindex('Trn',sa_concepto,0) + 4, 3))
     when charindex('PRV.',sa_concepto,0)  > 0 then
     (select substring(c.valor,1,14)
      from cobis..cl_tabla t, cobis..cl_catalogo c
      where t.tabla = 'cl_cla_con'
      and t.codigo  = c.tabla
      and c.codigo  =  'PRV')
      else '              ' end) +--V_DESCON                       
' ' +--V_TIPAPUN  
case when sc_digitador not in ('sp_caconta', 'sp_caconta_prv','sa') then 'O' else 'B' end + --V_ONLINE_BATCH
cobis.dbo.fn_llena_0(0,8)+ --N_HANAPANU     
case when sa_documento is not null then cobis.dbo.fn_llena_0(sa_documento,12) 
                        when sa_documento is null and charindex('Ban:',sa_concepto,0)>0 then cobis.dbo.fn_llena_0(substring(sa_concepto,charindex('Ban:',sa_concepto,0) + 4, charindex('Sec:',sa_concepto,0)-5),12)
                        else '            ' end +  -- V_IDENTIFICADOR_OPE
convert(char(48),' ') + --V_GLOSA                         
substring(sc_digitador,1,8)+
convert(char(4),' ')+
convert(varchar, sc_fecha_gra, 8)+
convert(char(1),' ')+
substring(sc_digitador,1,8)+
convert(char(4),' ')+
convert(char(8),' ')+
'COB'
INTO ##tmp_cobis_movlar
from cob_conta_tercero..ct_sasiento,
cob_conta_tercero..ct_scomprobante
where sc_fecha_tran  = sa_fecha_tran
and   sc_comprobante = sa_comprobante
and sc_fecha_gra >= @w_fecha_ini
and sc_fecha_gra <= @w_fecha_fin
and sc_producto   = sa_producto
group by sa_producto,sa_empresa, sa_comprobante, sa_documento,sa_concepto, sc_digitador, sa_asiento, sa_fecha_tran, sa_cuenta, sc_oficina_orig, sa_oficina_dest, sc_fecha_gra

DELETE FROM ##tmp_cobis_movlar
WHERE datos IS NULL

select @w_reporte = 'COBIS_MOVLAR_'
select @w_sql = 'select * from ##tmp_cobis_movlar'


select	@w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_reporte + @w_nombre_arch +'".txt"'+'" -C -c -t";" -T'

EXEC xp_cmdshell @w_sql_bcp


IF NOT EXISTS (select 1 from cobis..cl_log_notificador where ln_nemonico = 'COPYBTI' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha)
BEGIN
	INSERT INTO cobis..cl_log_notificador (ln_nemonico, ln_report_name, ln_generation_date, ln_gen_process_date, ln_upload_date, ln_copy_date, ln_report_pattern, ln_status)
	VALUES ('COPYBTI', @w_reporte + @w_nombre_arch +'.txt', GETDATE(),@w_fecha, null, null, @w_reporte +'{PPD:yyyyMMdd}.txt', null)
END
ELSE
BEGIN
	UPDATE cobis..cl_log_notificador
	SET
		ln_generation_date = GETDATE(),
		ln_status = NULL
	where ln_nemonico = 'COPYBTI' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha
END

IF NOT EXISTS (select 1 from cobis..cl_log_notificador where ln_nemonico = 'CHARITS' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha)
BEGIN
	INSERT INTO cobis..cl_log_notificador (ln_nemonico, ln_report_name, ln_generation_date, ln_gen_process_date, ln_upload_date, ln_copy_date, ln_report_pattern, ln_status)
	VALUES ('CHARITS', @w_reporte + @w_nombre_arch +'.txt', GETDATE(),@w_fecha, null, null, @w_reporte +'{PPD:yyyyMMdd}.txt', null)
END
ELSE
BEGIN
	UPDATE cobis..cl_log_notificador
	SET
		ln_generation_date = GETDATE(),
		ln_status = NULL
	where ln_nemonico = 'CHARITS' and ln_report_name = @w_reporte + @w_nombre_arch +'.txt' and ln_gen_process_date = @w_fecha
END

return 0

ERROR_PROCESO:

select @w_msg = mensaje
from cobis..cl_errores with (nolock)
where numero = @w_error
