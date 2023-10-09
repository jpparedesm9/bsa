/************************************************************************/
/*      Archivo:                rep_pend_dtn.sp                         */
/*      Stored procedure:       sp_rep_pend_dtn                         */
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
/*    Generacion de Cuentas Pendientes de Reintegro                     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_rep_pend_dtn')
   drop proc sp_rep_pend_dtn
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc sp_rep_pend_dtn(
   @t_show_version  bit = 0
)

as
declare
@w_sp_name           varchar(24),
@w_s_app             varchar(50),
@w_app               varchar(50),
@w_path              varchar(50),
@w_cmd               varchar(255),
@w_error             int,
@w_destino           varchar(255),
@w_comando           varchar(300),
@w_errores           varchar(255)

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_rep_pend_dtn'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

if @w_s_app is null
begin
   print 'No existe parametro @w_s_app'
   return 1
end

select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 4

if @w_path is null
begin
   print 'No existe parametro @w_path'
   return 1
end

select 'cuenta'    = tn_cuenta,
       'fechatras' = tn_fecha,
       'valor'     = tn_saldo_inicial,
       'id'        = tn_ced_ruc,
       'nombre'    = en_nomlar
into #datos_p
 from cob_remesas..re_tesoro_nacional, cobis..cl_ente with (nolock)
where en_ced_ruc = tn_ced_ruc
and tn_estado = 'P'

if @@error <> 0
begin
   print 'Error en insercion de datos'
   return 1
end

if exists(select 1 from sysobjects where name = 'ah_datos_temp')
   drop table ah_datos_temp

create table ah_datos_temp
(
 ad_data varchar(1000)
)

insert into ah_datos_temp values('Cuenta|Fecha Traslado|Valor|Doc Cliente|Nombre')

insert into ah_datos_temp
select cuenta  + '|' + convert(varchar(10),fechatras,101) + '|' + convert(varchar(20),valor) + '|' + id + '|'+ nombre
from  #datos_p
order by fechatras

if @@error <> 0
begin
   print 'Error en insercion de datos en temporal'
   return 1
end

/********************************/
/*GENERACION ARCHIVO PLANO      */
/********************************/

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_ahorros..ah_datos_temp out '

select
@w_destino  = @w_path + 'ctas_act_pend_reintegro_'+convert(varchar, getdate(),112)+'.txt',
@w_errores  = @w_path + 'ctas_act_pend_reintegro_'+convert(varchar, getdate(),112)+'.err'

select @w_comando = @w_cmd + @w_destino + ' -b5000  -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

print @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
   print 'Error generando el archivo plano'
   return 1
end


--pendiente reintegro
select 'cuenta'    = tn_cuenta,
       'fechatras' = tn_fecha,
       'valor'     = tn_saldo_inicial,
       'id'        = tn_ced_ruc,
       'nombre'    = en_nomlar
into #datos
 from cob_remesas..re_tesoro_nacional, cobis..cl_ente with (nolock)
where en_ced_ruc = tn_ced_ruc
and tn_estado = 'S'

if @@error <> 0
begin
   print 'Error en insercion de datos'
   return 1
end

if exists(select 1 from sysobjects where name = 'ah_datos_temp')
   drop table ah_datos_temp

create table ah_datos_temp
(
 ad_data varchar(1000)
)

insert into ah_datos_temp values('Cuenta|Fecha Traslado|Valor|Doc Cliente|Nombre')

insert into ah_datos_temp
select cuenta  + '|' + convert(varchar(10),fechatras,101) + '|' + convert(varchar(20),valor) + '|' + id + '|'+ nombre
from  #datos
order by fechatras

if @@error <> 0
begin
   print 'Error en insercion de datos en temporal'
   return 1
end

/********************************/
/*GENERACION ARCHIVO PLANO      */
/********************************/

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_ahorros..ah_datos_temp out '

select
@w_destino  = @w_path + 'ctas_pend_reintegro_'+convert(varchar, getdate(),112)+'.txt',
@w_errores  = @w_path + 'ctas_pend_reintegro_'+convert(varchar, getdate(),112)+'.err'

select @w_comando = @w_cmd + @w_destino + ' -b5000  -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

print @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
   print 'Error generando el archivo plano'
   return 1
end

drop table ah_datos_temp

return 0

go

