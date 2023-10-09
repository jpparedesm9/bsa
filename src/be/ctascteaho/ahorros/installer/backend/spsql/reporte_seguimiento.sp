/************************************************************************/
/*      Archivo:                reporte_seguimiento.sp                  */
/*      Stored procedure:       sp_reporte_seguimiento                  */
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
/*      Generando bcp Reporte de Seguimiento                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_reporte_seguimiento')
   drop proc sp_reporte_seguimiento
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_reporte_seguimiento (
@t_show_version     bit = 0,
@i_param1           varchar(255) -- Fecha Proceso
)
as
declare @i_fecha_proceso        varchar(12),
        @w_return               int,
        @w_sp_name              varchar(30),
        @w_path_destino         varchar(100),
        @w_cmd                  varchar(255),
        @w_comando              varchar(500),
        @w_path_s_app           varchar(100),
        @w_msg                  varchar(50),
        @w_s_app                varchar(250),
        @w_sqr                  varchar(100),
        @w_path                 varchar(250),
        @w_archivo              varchar(255),
       -- @w_oficina              smallint,
        @w_oficina              varchar(5),
        @w_cuenta               int,
        @w_rcount               tinyint,
        @w_estado               char(1),
        @w_sldo_esp             money,
        @w_sldo_hoy             money,
        @w_cta_banco            varchar(16),
        @w_nombre               varchar(100),
        --@w_sucursal             smallint,
        @w_sucursal             varchar(5),
        @w_cliente              int,
        @w_fecha                varchar(10),
        @w_numero               tinyint,
        @w_anio                 int,
        @w_mes                  int,
        @w_dia                  int,
        @w_fecha_reporte        varchar(10),
        @w_nom_archivo          varchar(100),
        @w_error                varchar(255)

-- Captura nombre de Stored Procedure
select  @w_sp_name = 'sp_reporte_seguimiento'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select  @i_fecha_proceso   = convert(datetime, @i_param1)

truncate table ah_cuenta_cumple_tmp

--select @w_fecha = convert(varchar(10), @i_fecha_proceso, 101)

exec cobis..sp_datepart
     @i_fecha = @i_fecha_proceso,
     @o_dia   = @w_dia out,
     @o_mes   = @w_mes out,
     @o_anio  = @w_anio out
if @@error <> 0 Begin
   select @w_msg = 'ERROR 3: ERROR EN EL SP_DATEPART'
   print @w_msg
   return 1
End

--INCLUIR CABECERA DEL ARCHIVO
insert into ah_cuenta_cumple_tmp values ('Sucursal','Oficina','Nro. Cuenta','Nombre Titular','Saldo Esperado','Saldo Real')

declare ah_cumpli cursor for
-- Determinacion de los datos de la cuenta
select  distinct im_cuenta
from  cob_ahorros..ah_imprime_plan
where im_estado = 'C'
and   im_fecha_aprox <= @i_fecha_proceso--@w_fecha

open  ah_cumpli

fetch ah_cumpli into
  @w_cuenta

while @@fetch_status = 0
begin
   if (@@fetch_status = -1)
   begin
      print 'sp_reporte_seguimiento Error en lectura cursor de incumplimientos'
      return 1
   end
    if exists (select 1
                from  cob_ahorros..ah_imprime_plan
                where im_cuenta = @w_cuenta
                and   im_estado = 'D'
                and   im_fecha_aprox <= @i_fecha_proceso) --@w_fecha)

        goto SIGUIENTE

        select top 1
          @w_numero           = im_numero,
          @w_sldo_esp         = im_sldo_esp,
          @w_sldo_hoy         = ah_disponible,
          @w_oficina          = convert(varchar(5),ah_oficina),
          @w_cta_banco        = ah_cta_banco,
          @w_cliente          = ah_cliente
        from  cob_ahorros..ah_cuenta, cob_ahorros..ah_imprime_plan
        where  ah_cuenta = im_cuenta
          and  ah_cuenta = @w_cuenta
          and  im_fecha_aprox  <= @i_fecha_proceso --@w_fecha
       order by im_numero desc

       select @w_nombre = en_nomlar
         from cobis..cl_ente
       where en_ente = @w_cliente

       select @w_sucursal = convert(varchar(10),isnull(of_sucursal,of_regional))
       from cobis..cl_oficina
       where of_oficina = @w_oficina

       insert into ah_cuenta_cumple_tmp (cc_sucursal,cc_oficina,cc_cta_banco,cc_nombre,cc_sld_espe,cc_sld_act)
       values                           (@w_sucursal,@w_oficina,@w_cta_banco, @w_nombre,@w_sldo_esp,@w_sldo_hoy)

SIGUIENTE:
fetch ah_cumpli into
  @w_cuenta
end
close ah_cumpli
deallocate ah_cumpli

--********************* **********************--
---> GENERAR BCP
--*******************************************--
select @w_path_s_app = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'S_APP'

if @w_path_s_app is null begin
    select @w_error = 999999, @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
    goto ERROR
end

select @w_path = pp_path_destino
from   cobis..ba_path_pro
where  pp_producto = 4

if @@rowcount = 0
Begin
   select @w_msg = 'ERROR 1: NO EXISTE RUTA DE LISTADOS PARA EL BATCH sp_nc_remesa_automatica'
   print  @w_msg
   return 1
End

select @w_fecha_reporte = convert(varchar,@w_anio)+right((replicate('0', 2) + convert(varchar,@w_mes)),2)+right((replicate('0', 2) + convert(varchar,@w_dia)),2)
--GENERA BCP
select @w_nom_archivo = 'Cumplimientos_' + @w_fecha_reporte + '.txt'
select @w_archivo = @w_path + @w_nom_archivo

select @w_cmd     = @w_path_s_app + 's_app bcp -auto -login cob_ahorros..ah_cuenta_cumple_tmp out '

select @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e ' + @w_archivo + '.err' + ' -t"|" -config '+ @w_path_s_app + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_msg = 'ERROR: '+@w_error+' ERROR GENERANDO BCP ' + @w_comando
   print @w_msg
   return 1
end

ERROR:

   insert into cob_ahorros..ah_errorlog
   values (@i_fecha_proceso,1,'batch',1,'No existe path','No existe path',null,'sp_reporte_seguimiento')
   return @w_error

return 0

go

