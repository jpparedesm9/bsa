/************************************************************************/
/*      Archivo:                rep_clientes_td.sp                      */
/*      Stored procedure:       sp_rep_clientes_td                      */
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
/*      Reporte de Clientes Tarjetas de Debito                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_rep_clientes_td')
   drop proc sp_rep_clientes_td
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc sp_rep_clientes_td (
@t_show_version  bit = 0,
@i_param1        datetime,
@i_param2        datetime
)
as
declare
@w_sp_name        varchar(30),
@w_fecha          datetime,
@w_fecha_ini      datetime,
@w_fecha_fin      datetime,
@w_msg            varchar(254),
@w_path_s_app     varchar(254),
@w_path           varchar(254),
@w_s_app          varchar(254),
@w_cmd            varchar(254),
@w_bd             varchar(254),
@w_tabla          varchar(254),
@w_tablac         varchar(254),
@w_tablad         varchar(254),
@w_destino        varchar(254),
@w_errores        varchar(254),
@w_erroresc       varchar(254),
@w_destinoc       varchar(254),
@w_comando        varchar(512),
@w_fecha_arch     varchar(10),
@w_nombre         varchar(64),
@w_archivo        varchar(64),
@w_archivoc       varchar(64),
@w_archivod       varchar(64),
@w_arch_out       varchar(64),
@w_batch          int,
@w_error          int,
@w_cont           int,
@anio_listado     varchar(10),
@mes_listado      varchar(10),
@dia_listado      varchar(10)

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_rep_clientes_td'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

if exists (select 1 from sysobjects where name = 'ah_rep_clientes_tarj_deb_cab')
    drop table ah_rep_clientes_tarj_deb_cab

create table ah_rep_clientes_tarj_deb_cab(
et_tarj_debito               varchar(30),
et_ced_ruc                   varchar(30),
et_nombre                    varchar(30),
et_ciudad                    varchar(30),
et_telefono                  varchar(30),
et_celular                   varchar(30))


if exists (select 1 from sysobjects where name = 'ah_rep_clientes_tarj_deb_det')
    drop table ah_rep_clientes_tarj_deb_det

create table ah_rep_clientes_tarj_deb_det(
et_tarj_debito           varchar(24),
et_ced_ruc               varchar(24),
et_nombre                varchar(60),
et_ciudad                varchar(64),
et_telefono              varchar(28),
et_celular               varchar(15)
)

insert into ah_rep_clientes_tarj_deb_cab
values('N. tarjeta', 'Cedula','Nombre', 'Ciudad', 'Telefono', 'Celular')

/*Fecha de Proceso*/
select @w_fecha = fp_fecha
from cobis..ba_fecha_proceso

/*Validacion Fecha para Tipo de Reporte*/
if @i_param1 is null
   select @i_param1 = fp_fecha from cobis..ba_fecha_proceso

if @i_param2 is null
   select @i_param2 = fp_fecha from cobis..ba_fecha_proceso

select
@w_fecha_ini = @i_param1,
@w_fecha_fin = @i_param2

insert into ah_rep_clientes_tarj_deb_det
select  rc_tarj_debito,
        ah_ced_ruc,
        ah_nombre,
        (select ci_descripcion
                    from cobis..cl_direccion,cobis..cl_ciudad
                    where di_principal     = 'S'
                    and   di_ciudad        = ci_ciudad
                    and   di_ente          = rc_cliente),
        (select top 1 isnull('('+ltrim(rtrim(te_prefijo))+')'+ltrim(rtrim(te_valor)),'-')
    from cobis..cl_direccion,cobis..cl_telefono
    where te_ente          = di_ente
    and   di_direccion     = te_direccion
    and   di_principal     = 'S'
    and   te_tipo_telefono = 'D'
    and   di_ente          = rc_cliente),
        rc_tel_celular
from cob_remesas..re_relacion_cta_canal,cob_ahorros..ah_cuenta
where rc_canal   = 'TAR'
and   rc_fecha  between @w_fecha_ini and @w_fecha_fin
and   rc_cuenta  = ah_cta_banco
and   rc_cliente = ah_cliente
order by ah_ced_ruc

if @@error <> 0 begin
   select @w_msg = 'ERROR AL INSERTAR EN TABLA DETALLE'
   goto ERROR
end

select
@w_cont      = 0,
@w_bd        = 'cob_ahorros',
@w_tablac    = 'ah_rep_clientes_tarj_deb_cab',
@w_tablad    = 'ah_rep_clientes_tarj_deb_det',
@w_arch_out  = 'REP_NUEVOS_CLIENTES_TD',
@w_batch     = 4022
goto BCP

BCP:

/*Creacion BCP*/
select @w_path_s_app = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'S_APP'

if @w_path_s_app is null begin
   select @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
   goto ERROR
end

select
@w_s_app = @w_path_s_app + 's_app'

/*Path destino archivo BCP*/
select
@w_path = ba_path_destino
from  cobis..ba_batch
where ba_batch = @w_batch

/*Generacion archivo cabecera*/
select
@w_cmd       = @w_s_app + ' bcp -auto -login ',
@w_tabla     = @w_tablac,
@w_archivoc  = @w_tablac

select
@w_destinoc  = @w_path + @w_archivoc +'.txt',
@w_erroresc  = @w_path + @w_archivoc +'.err'

select
@w_comando = @w_cmd + @w_bd + '..' + @w_tablac + ' out ' + @w_destinoc + ' -b5000 -c -e' + @w_erroresc + ' -t"|" ' + '-config ' + @w_s_app + '.ini'

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO CABECERA ' + @w_destinoc + ' ' + convert(varchar, @w_error)
   goto ERROR
end

/*Generacion archivo datos*/
select
@w_cmd      = @w_s_app + ' bcp -auto -login ',
@w_tabla    = @w_tablad,
@w_archivod = @w_tablad

select
@w_destino  = @w_path + @w_archivod +'.txt',
@w_errores  = @w_path + @w_archivod +'.err'

select
@w_comando = @w_cmd + @w_bd + '..' + @w_tablad + ' out ' + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config ' + @w_s_app + '.ini'

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_destino + ' ' + convert(varchar, @w_error)
   goto ERROR
end

select @w_fecha_arch = convert(varchar, @w_fecha, 112),
       @anio_listado = substring(@w_fecha_arch,1,4),
       @mes_listado  = substring(@w_fecha_arch,5,2),
       @dia_listado  = substring(@w_fecha_arch,7,2)

select @w_fecha_arch = @mes_listado + @dia_listado + @anio_listado

/*Fusion archivos de cabecera y de datos*/
select @w_nombre = @w_arch_out + @w_fecha_arch

select
@w_archivo  = @w_path + @w_nombre +'.txt',
@w_comando = 'type ' + @w_destinoc + ' ' + @w_destino + ' > ' + @w_archivo

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO FINAL ' + @w_archivo + ' ' + convert(varchar, @w_error)
   goto ERROR
end

/*Eliminacion Archivo de cabecera y de datos*/
select
@w_comando = 'rm ' + @w_destinoc

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO FINAL ' + @w_archivo + ' '+ convert(varchar, @w_error)
   goto ERROR
end

select
@w_comando = 'rm ' + @w_erroresc

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO FINAL ' + @w_archivo + ' ' + convert(varchar, @w_error)
   goto ERROR
end

select
@w_comando = 'rm ' + @w_destino

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO FINAL ' + @w_archivo+ ' ' + convert(varchar, @w_error)
   goto ERROR
end

select
@w_comando = 'rm ' + @w_errores

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'ERROR AL GENERAR ARCHIVO FINAL '+@w_archivo+ ' '+ convert(varchar, @w_error)
   goto ERROR
end

if exists (select 1 from sysobjects where name = 'ah_rep_clientes_tarj_deb_cab')
    drop table ah_rep_clientes_tarj_deb_cab

if exists (select 1 from sysobjects where name = 'ah_rep_clientes_tarj_deb_det')
    drop table ah_rep_clientes_tarj_deb_det

return 0

ERROR:
print @w_msg

exec @w_error = cobis..sp_errorlog
@i_fecha      = @w_fecha,
@i_error      = 22681,
@i_usuario    = 'op_batch',
@i_tran       = 4022,
@i_tran_name  = @w_msg,
@i_rollback   = 'N'
return 22681

go

