/************************************************************************/
/*      Archivo:                rep_reex_td.sp                          */
/*      Stored procedure:       sp_rep_reex_td                          */
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
/*      Rerpote de Reexpedicion de Tarjeta de Debito                    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_rep_reex_td')
   drop proc sp_rep_reex_td
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc sp_rep_reex_td (
@t_show_version  bit = 0,
@i_param1   char(1)    = null,  --Operacion
@i_param2   datetime   = null   --Fecha fin de proceso
)
as
declare @w_tabla     int,
        @w_proceso   char(1),
        @w_fecha     datetime,
        @w_error     int,
        @w_msg       varchar(255),
        @w_destino   varchar(500),
        @w_s_app     varchar(100),
        @w_path      varchar(60) ,
        @w_cmd       varchar(500),
        @w_errores   varchar(500),
        @w_archivo   varchar(500),
        @w_comando   varchar(500),
        @w_error_tmp int,
        @w_registros int,
        @w_sp_name   varchar(32)

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_rep_reex_td'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_proceso   = @i_param1,
       @w_registros = 0

if @w_proceso = 'A'
   select @w_archivo = 'ACUMULADO_REPREEX_'
else
   select @w_archivo = 'DIARIO_REPREEX_'

if @w_proceso not in ('A', 'D')
begin
   select @w_error = 4000001,
          @w_msg   = 'OPERACION NO VALIDA'

   insert into   ah_errores_rr values(@w_error, @w_msg)
   SELECT @w_msg
   goto ERRORFIN
end

if exists(select 1 from sysobjects where name = 'ah_rep_rex')
   drop table ah_rep_rex

create table ah_rep_rex
(
 rr_contenido varchar(1000)
)

if exists(select 1 from sysobjects where name = 'ah_errores_rr')
   drop table ah_errores_rr

create table ah_errores_rr
(
 er_numero  int,
 er_mensaje varchar(1000)
)

select @w_fecha = @i_param2

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

If @w_s_app is null
begin
   select
   @w_msg     = 'ERROR CARGANDO PARAMETRO BCP',
   @w_error   = 4000002

   insert into   ah_errores_rr values(@w_error, @w_msg)

   goto ERRORFIN
end

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = 4270

If @w_path is null
begin
   select
   @w_msg     = 'ERROR CARGANDO LA RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION',
   @w_error   = 4000003

   insert into   ah_errores_rr values(@w_error, @w_msg)

   goto ERRORFIN
end

select @w_tabla = codigo
from   cobis..cl_tabla
where  tabla = 're_novedades_enroll'

if @w_proceso not in ('A', 'D')
begin
   select @w_error = 4000004,
          @w_msg   = 'CATALOGO DE MOTIVOS NO EXISTE'

   insert into   ah_errores_rr values(@w_error, @w_msg)
   SELECT @w_msg
   goto ERRORFIN
end

--Relaciones realizadas para la fecha
select
Oficina          = convert(int,dp_oficina),
NomOficina       = convert(varchar(60),''),
Cuenta           = rc_cuenta,
Cliente          = dp_cliente,
IDCliente        = convert(varchar(30),''),
TarjetaVigente   = rc_tarj_debito,
Motivo           = rc_motivo + (select '-' + upper(valor) from  cobis..cl_catalogo where tabla = @w_tabla and codigo = rc_motivo),
FechaExpedicion  = convert(datetime,rc_fecha),
TarjetaCancelada = convert(varchar(20), '0000000000000000'),
MotivoCancelacion= convert(varchar(80), '00'),
FechaCancelacion = convert(datetime,'01/01/1900')
into  #vigentes
from  cob_conta_super..sb_relacion_canal with(nolock), cob_conta_super..sb_dato_pasivas  with(nolock)
where rc_canal = 'TAR'
and   rc_estado = 'V'
and   ((rc_fecha  <= @w_fecha and @w_proceso = 'A') or (rc_fecha  = @w_fecha and @w_proceso = 'D'))
and   rc_cuenta = dp_banco
and   dp_aplicativo = 4
and   dp_fecha = @w_fecha

if @@ERROR <> 0
begin
   select @w_error = 4000005,
          @w_msg   = 'EXISTIO UN ERROR AL EXTRAER LOS REGISTROS PARA LA FECHA'

   insert into   ah_errores_rr values(@w_error, @w_msg)
   SELECT @w_msg
   goto ERRORFIN
end

--Se eliminan las relaciones que estan vigentes
delete #vigentes
where  Cuenta not in (select rc_cuenta from  cob_conta_super..sb_relacion_canal where rc_canal = 'TAR'
and    rc_estado = 'E')

if @@ERROR <> 0
begin
   select @w_error = 4000006,
          @w_msg   = 'ERROR AL DEPURAR TABLA DE TRABAJO'

   insert into   ah_errores_rr values(@w_error, @w_msg)
   SELECT @w_msg
   goto ERRORFIN
end

select @w_registros = COUNT(1) from #vigentes

if @w_registros = 0
begin
   select @w_error = 4000007,
          @w_msg   = 'NO HAY REGISTROS DE REEXPEDICIÓN CON EL CRITERIO DE BUSQUEDA'

   insert into   ah_errores_rr values(@w_error, @w_msg)
   SELECT @w_msg
   goto ERRORFIN
end

--Se extrae la ultima fecha de modificacion de la relacion
select FechaMod = max(rc_fecha_mod), CuentaMaxE = rc_cuenta
into  #MaxElim
from  cob_conta_super..sb_relacion_canal, #vigentes
where rc_canal = 'TAR'
and   rc_estado = 'E'
and   Cuenta    = rc_cuenta
group by rc_cuenta

if @@ERROR <> 0
begin
   select @w_error = 4000008,
          @w_msg   = 'EXISTIO UN ERROR AL EXTRAER LA RELACION MAS RECIENTE'

   insert into   ah_errores_rr values(@w_error, @w_msg)
   SELECT @w_msg
   goto ERRORFIN
end


--Agrupo los registros por pares, eliminada con reexpedida
select
CuentaE = rc_cuenta,
TarjetaC= rc_tarj_debito,
MotivoC = rc_motivo + (select '-' + upper(valor) from  cobis..cl_catalogo where tabla = @w_tabla and codigo = rc_motivo),
FechaC  = convert(datetime,rc_fecha_mod)
into  #eliminadas
from  cob_conta_super..sb_relacion_canal, #vigentes
where rc_canal = 'TAR'
and   rc_estado = 'E'
and   Cuenta    = rc_cuenta
and   rc_fecha_mod in (select FechaMod from #MaxElim where rc_canal = 'TAR' and CuentaMaxE = rc_cuenta)

if @@ERROR <> 0
begin
   select @w_error = 4000009,
          @w_msg   = 'EXISTIO UN ERROR ACTUALIZAR LA TARJETA REEXPEDIDA AL REPORTE'

   insert into   ah_errores_rr values(@w_error, @w_msg)
   SELECT @w_msg
   goto ERRORFIN
end

--Actualizo datos de la tabla principal
update #vigentes set
TarjetaCancelada = TarjetaC,
MotivoCancelacion= MotivoC,
FechaCancelacion = FechaC
from    #eliminadas
where   Cuenta = CuentaE

if @@ERROR <> 0
begin
   select @w_error = 4000010,
          @w_msg   = 'EXISTIO UN ERROR AL ACTUALIZAR EL MOTIVO DE LA CANCELACION'

   insert into   ah_errores_rr values(@w_error, @w_msg)
   SELECT @w_msg
   goto ERRORFIN
end

--Actualizo
update #vigentes
set    NomOficina = of_nombre
from   cobis..cl_oficina
where  Oficina = of_oficina

if @@ERROR <> 0
begin
   select @w_error = 4000011,
          @w_msg   = 'EXISTIO UN ERROR AL ACTUALIZAR LA DESCRIPCION DE LA OFICINA'

   insert into   ah_errores_rr values(@w_error, @w_msg)
   SELECT @w_msg
   goto ERRORFIN
end

update #vigentes
set    IDCliente = en_ced_ruc
from   cobis..cl_ente
where  Cliente = en_ente

if @@ERROR <> 0
begin
   select @w_error = 4000012,
          @w_msg   = 'EXISTIO UN ERROR AL ACTUALIZAR LA CEDULA DEL CLIENTE'

   insert into   ah_errores_rr values(@w_error, @w_msg)
   SELECT @w_msg
   goto ERRORFIN
end

--Borro los registros que tengan mas de dos tarjetas vigente, cruzando la tarjeta nueva con la vieja
delete from #vigentes
where TarjetaVigente = TarjetaCancelada

if @@ERROR <> 0
begin
   select @w_error = 4000014,
          @w_msg   = 'EXISTIO UN ERROR AL DEPURAR TABLA DE TRABAJO'

   insert into   ah_errores_rr values(@w_error, @w_msg)
   SELECT @w_msg
   goto ERRORFIN
end

insert into ah_rep_rex values('FECHA DE PROCESO|CODIGO DE OFICINA|NOMBRE OFICINA|NUMERO CUENTA CLIENTE|CEDULA CLIENTE|NUMERO TARJETA DE DEBITO REEXPEDIDA|FECHA ENTREGA TARJETA REEXPEDIDA|FORMA ENTREGA|NUMERO DE TARJETA DEBITO CANCELADA|FECHA DE CANCELACION|MOTIVO CANCELACION')


insert into ah_rep_rex
select convert(varchar, convert(varchar(10), isnull(@i_param2, '01/01/1900'), 103)       ) + '|' +
       convert(varchar, Oficina                                                          ) + '|' +
       convert(varchar, NomOficina                                                       ) + '|' +
       convert(varchar, Cuenta                                                           ) + '|' +
       convert(varchar, IDCliente                                                        ) + '|' +
       convert(varchar, TarjetaVigente                                                   ) + '|' +
       convert(varchar, convert(varchar(10), isnull(FechaExpedicion, '01/01/1900'), 103) ) + '|' +
       convert(varchar, Motivo                                                           ) + '|' +
       convert(varchar, TarjetaCancelada                                                 ) + '|' +
       convert(varchar, convert(varchar(10), isnull(FechaCancelacion, '01/01/1900'), 103)) + '|' +
       convert(varchar, MotivoCancelacion                                                ) --+ '|' +
from #vigentes

if @@ERROR <> 0
begin
   select @w_error = 4000013,
          @w_msg   = 'ERROR AL GENERAR LA TABLA DE TRABAJO PARA EL REPORTE'

   insert into   ah_errores_rr values(@w_error, @w_msg)
   SELECT @w_msg
   goto ERRORFIN
end

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_ahorros..ah_rep_rex out '

select
@w_destino  = @w_path + @w_archivo + replace(convert(varchar, @w_fecha, 102), '.', '') +'.txt',
@w_errores  = @w_path + @w_archivo + replace(convert(varchar, @w_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.err'

select @w_comando = @w_cmd + @w_destino + ' -b5000  -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

PRINT @w_comando
exec @w_error_tmp = xp_cmdshell @w_comando

return 0

ERRORFIN:

PRINT @w_msg

--select @w_archivo = @w_archivo

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_ahorros..ah_errores_rr out '

select
@w_destino  = @w_path + @w_archivo + replace(convert(varchar, @w_fecha, 102), '.', '') +'.txt',
@w_errores  = @w_path + @w_archivo + replace(convert(varchar, @w_fecha, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.err'

select @w_comando = @w_cmd + @w_destino + ' -b1000  -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

PRINT @w_comando
exec @w_error_tmp = xp_cmdshell @w_comando

set nocount off

return 0

go

