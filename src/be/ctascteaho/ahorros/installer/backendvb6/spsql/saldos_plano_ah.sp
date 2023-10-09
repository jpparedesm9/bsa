/************************************************************************/
/*      Archivo:                saldos_plano_ah.sp                      */
/*      Stored procedure:       sp_saldos_plano_ah                      */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:                                                   */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                               IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por  escrito de COBISCorp.    */
/*  Este programa esta  protegido  por la ley de   derechos de autor    */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Generar Archivo Plano de Saldos de Cuentas de Ahorros              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_saldos_plano_ah')
   drop proc sp_saldos_plano_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_saldos_plano_ah (
@t_show_version bit = 0,
@i_param1       varchar(10)     = null,   --Fecha Proceso
@i_corresponsal char(1)         = 'N'  --Req. 381 CB Red Posicionada
)
as
declare  @w_msg           descripcion,
         @w_sp_name       varchar(30),
         @w_fecha         smalldatetime,
         @w_fecha1        smalldatetime,
         @w_error         int,
         @w_max_ofi       int,
         @w_min_ofi       int,
         @w_path_s_app    varchar(30),
         @w_path          varchar(250),
         @w_s_app         varchar(250),
         @w_archivo       descripcion,
         @w_errores       descripcion,
         @w_archivo_bcp   descripcion,
         @w_cmd           varchar(250),
         @w_comando       varchar(250),
         @w_oficina       int,
         @w_fecha_aux     smalldatetime,
         @w_prod_bancario varchar(50) --Req. 381 CB Red Posicionada

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_saldos_plano_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

if @i_param1 is null
begin
   select
   @w_msg   = case when @i_param1 is null then 'PARAMETRO FECHA ES OBLIGATORIO' end,
   @w_error = case when @i_param1 is null then 101114  end,
   @w_fecha = fp_fecha from cobis..ba_fecha_proceso
   goto ERROR
end
else
   select @w_fecha = convert(smalldatetime,@i_param1)

exec @w_error = cob_remesas..sp_fecha_habil
@i_fecha       = @w_fecha,
@i_oficina     = 1,
@i_efec_dia    = 'S',
@i_finsemana   = 'N',
@w_dias_ret    = 1,
@o_fecha_sig   = @w_fecha_aux    out

if @w_error <> 0 or @@error <> 0
begin
   --Error al determinar ultimo dia habil del mes
   exec cobis..sp_cerror
   @i_num       = 201163
   return 201163
end

if convert(varchar(2),(datepart(mm,@w_fecha_aux))) = convert(varchar(2),(datepart(mm,@w_fecha)))
begin
   print 'No es fin de mes'
   return 0 --Solo ejecuta en ultimo dia del mes
end

select @w_fecha1   = convert(smalldatetime,(substring(convert(varchar(10),@w_fecha,101),1,2) + '/' + '01' + '/' + substring(convert(varchar(10),@w_fecha,101),7,4)))

/* SE LIMPIA LA TABLA DEL REPORTE LA TABLA */
truncate table cob_ahorros..ah_saldos_cta

select *
into #ah_saldos_cta
from cob_ahorros..ah_saldos_cta

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo and
      cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

-- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
if @i_corresponsal = 'N'
begin
   /*SE INSERTAN LOS REGISTROS DEL REPORTE*/
   insert into #ah_saldos_cta
   select distinct
   '"' + isnull(convert(varchar(10),@w_fecha,112),'') + '"|' +
   '"' + isnull(cast(ah_oficina as varchar(20)),'') + '"|' +
   '"' + isnull(substring(of_nombre,1,15),'') + '"|' +
   '"' + isnull(ah_ced_ruc,'') + '"|' +
   '"' + isnull(substring(ah_nombre,1,40),'') + '"|' +
   '"' + isnull(convert(varchar(10),ah_fecha_aper, 112),'') + '"|' +
   '"' + isnull(sd_estado,'') + '"|' +
   '"' + isnull(ah_cta_banco,'') + '"|' +
   '"' + isnull(cast(sd_saldo_disponible as varchar(20)),'') + '"|' +
   '"' + isnull(cast(sd_saldo_contable as varchar(20)),'') + '"|' +
   '"' + case ah_estado
         when 'C' then isnull((select cast(hc_saldo as varchar(20)) from cob_ahorros..ah_his_cierre where hc_cuenta = a.ah_cuenta and hc_estado = 'C'),0.00)
         else '0.00'
         end + '"|' +
   '"' + isnull(convert(varchar(6),ci_ciudad),'') + '"|' +
   '"' + isnull(substring(ci_descripcion,1,20),'') + '"|' +
   '"' + isnull(convert(varchar(5), ci_provincia),'') + '"|' +
   '"' + isnull((select substring(pv_descripcion,1,20) from cobis..cl_provincia where pv_provincia = c.ci_provincia),'') + '"'
   from  cob_ahorros..ah_cuenta_tmp a, cobis..cl_oficina, cobis..cl_ciudad c, cob_ahorros_his..ah_saldo_diario
   where ah_oficina   = of_oficina
   and   of_ciudad    = ci_ciudad
   and   ah_cuenta    = sd_cuenta
   and   sd_fecha     = @i_param1
   and   ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
   union
   select distinct
   '"' + isnull(convert(varchar(10),@w_fecha,112),'') + '"|' +
   '"' + isnull(cast(ah_oficina as varchar(20)),'') + '"|' +
   '"' + isnull(substring(of_nombre,1,15),'') + '"|' +
   '"' + isnull(ah_ced_ruc,'') + '"|' +
   '"' + isnull(substring(ah_nombre,1,40),'') + '"|' +
   '"' + isnull(convert(varchar(10),ah_fecha_aper, 112),'') + '"|' +
   '"' + isnull(ah_estado,'') + '"|' +
   '"' + isnull(ah_cta_banco,'') + '"|' +
   '"' + '0.00' + '"|' +
   '"' + '0.00' + '"|"' +
   case ah_estado
         when 'C' then isnull(cast(hc_saldo as varchar(20)),'0.00')
         else '0.00'
         end  + '"|' +
   '"' + isnull(convert(varchar(6),ci_ciudad),'') + '"|' +
   '"' + isnull(substring(ci_descripcion,1,20),'') + '"|' +
   '"' + isnull(convert(varchar(5), ci_provincia),'') + '"|' +
   '"' + isnull((select substring(pv_descripcion,1,20) from cobis..cl_provincia where pv_provincia = c.ci_provincia),'') + '"'
   from  cob_ahorros..ah_cuenta_tmp a, cobis..cl_oficina, cobis..cl_ciudad c, cob_ahorros..ah_his_cierre
   where ah_oficina = of_oficina
   and   of_ciudad  = ci_ciudad
   and   ah_estado  = 'C'
   and   ah_fecha_ult_mov < @w_fecha1
   and   hc_estado = 'C'
   and   hc_saldo  > 0
   and   hc_cuenta = ah_cuenta
   and   ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

   /* SE INSERTA LE ENCABEZADO DEL REPORTE */
   insert into cob_ahorros..ah_saldos_cta values ('"FECHACORTE"|"OFICINA"|"NOMBREOFICINA"|"IDENTIFICACION"|"NOMBRECLIENTE"|"FECHAAPER"|"ESTADO"|"CUENTA"|"DISPONIBLE"|"CONTABLE"|"PORENTREGAR"|"CIUDAD"|"NOMCIUDAD"|"DEPARTAMENTO"|"NOMBREDEPTO"|')

   insert into cob_ahorros..ah_saldos_cta
   select distinct *
   from   #ah_saldos_cta


   if @@rowcount > 1
   begin
      select @w_path_s_app = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'ADM'
      and    pa_nemonico = 'S_APP'

      if @w_path_s_app is null begin
         select @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
         goto ERROR
      end

      /* Se Realiza BCP */
      select @w_s_app = @w_path_s_app + 's_app'

      select @w_path = ba_path_destino
      from  cobis..ba_batch
      where ba_batch = 4139

      select @w_archivo = 'SALDOSCTA_' + convert(varchar,@w_fecha,112) + '.txt',
             @w_errores = 'ERR_SALDOSCTA_' + convert(varchar,@w_fecha,112) + '.txt'

      select @w_archivo_bcp = @w_path  + @w_archivo,
             @w_errores     = @w_path  + @w_errores,
             @w_cmd         = @w_s_app + ' bcp -auto -login cob_ahorros..ah_saldos_cta out '

      select @w_comando = @w_cmd + @w_archivo_bcp + ' -b5000 -c -e'+@w_errores  +  ' -config '+ @w_s_app + '.ini'

      exec @w_error = xp_cmdshell @w_comando

      if @w_error <> 0 begin
         print 'Comando ejecutado ' + @w_comando
         select @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_archivo + ' '+ convert(varchar, @w_error)
         goto ERROR
      end
   end
   else
   begin
      select @w_msg = 'No Existen datos Para Generar Archivo Plano de Saldos de Cuentas de Ahorros'
      goto ERROR
   end
end
else
begin
   /*SE INSERTAN LOS REGISTROS DEL REPORTE*/
   insert into #ah_saldos_cta
   select distinct
   '"' + isnull(convert(varchar(10),@w_fecha,112),'') + '"|' +
   '"' + isnull(cast(ah_oficina as varchar(20)),'') + '"|' +
   '"' + isnull(substring(of_nombre,1,15),'') + '"|' +
   '"' + isnull(ah_ced_ruc,'') + '"|' +
   '"' + isnull(substring(ah_nombre,1,40),'') + '"|' +
   '"' + isnull(convert(varchar(10),ah_fecha_aper, 112),'') + '"|' +
   '"' + isnull(sd_estado,'') + '"|' +
   '"' + isnull(ah_cta_banco,'') + '"|' +
   '"' + isnull(cast(sd_saldo_disponible as varchar(20)),'') + '"|' +
   '"' + isnull(cast(sd_saldo_contable as varchar(20)),'') + '"|' +
   '"' + case ah_estado
         when 'C' then isnull((select cast(hc_saldo as varchar(20)) from cob_ahorros..ah_his_cierre where hc_cuenta = a.ah_cuenta and hc_estado = 'C'),0.00)
         else '0.00'
         end + '"|' +
   '"' + isnull(convert(varchar(6),ci_ciudad),'') + '"|' +
   '"' + isnull(substring(ci_descripcion,1,20),'') + '"|' +
   '"' + isnull(convert(varchar(5), ci_provincia),'') + '"|' +
   '"' + isnull((select substring(pv_descripcion,1,20) from cobis..cl_provincia where pv_provincia = c.ci_provincia),'') + '"'
   from  cob_ahorros..ah_cuenta_tmp a, cobis..cl_oficina, cobis..cl_ciudad c, cob_ahorros_his..ah_saldo_diario
   where ah_oficina   = of_oficina
   and   of_ciudad    = ci_ciudad
   and   ah_cuenta    = sd_cuenta
   and   sd_fecha     = @i_param1
   union
   select distinct
   '"' + isnull(convert(varchar(10),@w_fecha,112),'') + '"|' +
   '"' + isnull(cast(ah_oficina as varchar(20)),'') + '"|' +
   '"' + isnull(substring(of_nombre,1,15),'') + '"|' +
   '"' + isnull(ah_ced_ruc,'') + '"|' +
   '"' + isnull(substring(ah_nombre,1,40),'') + '"|' +
   '"' + isnull(convert(varchar(10),ah_fecha_aper, 112),'') + '"|' +
   '"' + isnull(ah_estado,'') + '"|' +
   '"' + isnull(ah_cta_banco,'') + '"|' +
   '"' + '0.00' + '"|' +
   '"' + '0.00' + '"|"' +
   case ah_estado
         when 'C' then isnull(cast(hc_saldo as varchar(20)),'0.00')
         else '0.00'
         end  + '"|' +
   '"' + isnull(convert(varchar(6),ci_ciudad),'') + '"|' +
   '"' + isnull(substring(ci_descripcion,1,20),'') + '"|' +
   '"' + isnull(convert(varchar(5), ci_provincia),'') + '"|' +
   '"' + isnull((select substring(pv_descripcion,1,20) from cobis..cl_provincia where pv_provincia = c.ci_provincia),'') + '"'
   from  cob_ahorros..ah_cuenta_tmp a, cobis..cl_oficina, cobis..cl_ciudad c, cob_ahorros..ah_his_cierre
   where ah_oficina = of_oficina
   and   of_ciudad  = ci_ciudad
   and   ah_estado  = 'C'
   and   ah_fecha_ult_mov < @w_fecha1
   and   hc_estado = 'C'
   and   hc_saldo  > 0
   and   hc_cuenta = ah_cuenta

   /* SE INSERTA LE ENCABEZADO DEL REPORTE */
   insert into cob_ahorros..ah_saldos_cta values ('"FECHACORTE"|"OFICINA"|"NOMBREOFICINA"|"IDENTIFICACION"|"NOMBRECLIENTE"|"FECHAAPER"|"ESTADO"|"CUENTA"|"DISPONIBLE"|"CONTABLE"|"PORENTREGAR"|"CIUDAD"|"NOMCIUDAD"|"DEPARTAMENTO"|"NOMBREDEPTO"|')

   insert into cob_ahorros..ah_saldos_cta
   select distinct *
   from   #ah_saldos_cta

   if @@rowcount > 1
   begin
      select @w_path_s_app = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'ADM'
      and    pa_nemonico = 'S_APP'

      if @w_path_s_app is null begin
         select @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
         goto ERROR
      end

      /* Se Realiza BCP */
      select @w_s_app = @w_path_s_app + 's_app'

      select @w_path = ba_path_destino
      from  cobis..ba_batch
      where ba_batch = 4139

      select @w_archivo = 'SALDOSCTA_' + convert(varchar,@w_fecha,112) + '.txt',
             @w_errores = 'ERR_SALDOSCTA_' + convert(varchar,@w_fecha,112) + '.txt'

      select @w_archivo_bcp = @w_path  + @w_archivo,
             @w_errores     = @w_path  + @w_errores,
             @w_cmd         = @w_s_app + ' bcp -auto -login cob_ahorros..ah_saldos_cta out '

      select @w_comando = @w_cmd + @w_archivo_bcp + ' -b5000 -c -e'+@w_errores  +  ' -config '+ @w_s_app + '.ini'

      exec @w_error = xp_cmdshell @w_comando

      if @w_error <> 0 begin
         print 'Comando ejecutado ' + @w_comando
         select @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_archivo + ' '+ convert(varchar, @w_error)
         goto ERROR
      end
   end
   else
   begin
      select @w_msg = 'No Existen datos Para Generar Archivo Plano de Saldos de Cuentas de Ahorros'
      goto ERROR
   end
end
return 0

ERROR:
exec sp_errorlog
@i_fecha   = @w_fecha,
@i_error   = @w_error,
@i_usuario = 'Operador',
@i_tran    = 0,
@i_cuenta  = '',
@i_descripcion = @w_msg

return 1

go

