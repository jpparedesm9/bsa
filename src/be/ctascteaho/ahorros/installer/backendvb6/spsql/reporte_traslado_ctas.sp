/************************************************************************/
/*      Archivo:                reporte_traslado_ctas.sp                */
/*      Stored procedure:       sp_reporte_traslado_ctas                */
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
/*      Archivo Reporte de Traslado Masivo de Oficinas                  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_reporte_traslado_ctas')
   drop proc sp_reporte_traslado_ctas
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc sp_reporte_traslado_ctas (
@t_show_version  bit = 0,
@i_param1    datetime  --Fecha de traslado de oficina
)
as
declare
/*param de sp*/
@w_fecha_proceso            datetime,
@w_fecha_traslado           datetime,
@w_fecha_ini                datetime,
@w_dias                     int,
/* param propios de bcp*/
@w_msg                      descripcion,
@w_sp_name                  varchar(20),
@w_s_app                    varchar(255),
@w_path                     varchar(255),
@w_nombre                   varchar(255),
@w_nombre_cab               varchar(255),
@w_destino                  varchar(2500),
@w_errores                  varchar(1500),
@w_error                    int,
@w_nombre_plano             varchar(2500),
@w_col_id                   int,
@w_columna                  varchar(100),
@w_cabecera                 varchar(2500),
@w_nom_tabla                varchar(100),
@w_comando                  varchar(2500),
@w_fecha_proc               datetime,
@w_path_destino             varchar(30),
@w_cmd                      varchar(2500),
@w_anio                     varchar(4),
@w_mes                      varchar(2),
@w_dia                      varchar(2),
@w_fecha1                   varchar(10)

/*  Captura nombre de Stored Procedure  */
select @w_sp_name    = 'sp_reporte_traslado_ctas'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

if exists (select 1 from sysobjects where name = 'ah_reporte_traslado_ofi' and type = 'U')
   drop table ah_reporte_traslado_ofi

create table ah_reporte_traslado_ofi(
Fecha_Traslado    varchar(10),
Numero_Cuenta     cuenta,
Oficina_Origen    smallint,
Oficina_Destino   smallint,
Estado_Cuenta     varchar(3)   null,
Saldo_Disponible  money        null,
Saldo_Contable    money        null,
Saldo_Interes     money        null,
Producto_bancario smallint     null,
Moneda            tinyint      null,
Clase_Cliente     char(1)      null,
Codigo_Cliente    int          null,
Usuario           descripcion  null,
Terminal          descripcion  null,
Hora              datetime     null)

/*** VALIDACION DE PARAMETROS DE ENTRADA ***/
if @i_param1 = ''
begin
   select
   @w_error = 2902799,
   @w_msg   = 'EL PARAMETRO FECHA ES OBLIGATORIO'
   goto ERRORFIN
end
else
begin
   select
   @w_fecha_traslado = @i_param1,
   @w_dias           = 0

   select
   @w_dias           = datepart(dd, @w_fecha_traslado),
   @w_fecha_ini      = dateadd(dd, -@w_dias + 1, @w_fecha_traslado)
end


if @w_fecha_traslado < @w_fecha_proceso
begin
   insert into ah_reporte_traslado_ofi(
   Fecha_Traslado,                         Numero_Cuenta,   Oficina_Origen,
   Oficina_Destino,                        Estado_Cuenta,   Saldo_Disponible,
   Saldo_Contable,                         Saldo_Interes,   Producto_bancario,
   Moneda,                                 Clase_Cliente,   Codigo_Cliente,
   Usuario,                                Terminal,        Hora)
   select
   convert(varchar(10),hs_tsfecha, 101),   hs_cta_banco,    hs_oficina,
   hs_oficina_cta,                         hs_causa,        hs_valor,
   hs_saldo,                               hs_interes,      hs_prod_banc,
   hs_moneda,                              hs_clase_clte,   hs_cliente,
   hs_usuario,                             hs_terminal,     hs_hora
   from  cob_ahorros_his..ah_his_servicio
   where hs_tipo_transaccion = 374
   and   hs_tsfecha          between @w_fecha_ini and @w_fecha_traslado
   and   hs_clase            = 'D'
end
else
if @w_fecha_traslado >= @w_fecha_proceso
begin
   insert into ah_reporte_traslado_ofi(
   Fecha_Traslado,                         Numero_Cuenta,   Oficina_Origen,
   Oficina_Destino,                        Estado_Cuenta,   Saldo_Disponible,
   Saldo_Contable,                         Saldo_Interes,   Producto_bancario,
   Moneda,                                 Clase_Cliente,   Codigo_Cliente,
   Usuario,                                Terminal,        Hora)
   select
   convert(varchar(10),ts_tsfecha, 101),   ts_cta_banco,    ts_oficina,
   ts_oficina_cta,                         ts_causa,        ts_valor,
   ts_saldo,                               ts_interes,      ts_prod_banc,
   ts_moneda,                              ts_clase_clte,   ts_cliente,
   ts_usuario,                             ts_terminal,     ts_hora
   from  ah_tran_servicio
   where ts_tipo_transaccion = 374
   and   ts_tsfecha          between @w_fecha_ini and @w_fecha_traslado
   and   ts_clase            = 'D'
end

/* Iniciando BCP */
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

--Generando la fecha para el nombre del archivo
select @w_anio = convert(varchar(4),datepart(yyyy,@w_fecha_proceso)),
       @w_mes = convert(varchar(2),datepart(mm,@w_fecha_proceso)),
       @w_dia = convert(varchar(2),datepart(dd,@w_fecha_proceso))

select @w_fecha1  = (@w_anio + right('00' + @w_mes,2) + right('00'+ @w_dia,2) )

--Seleccionando el path destino para archivo de salida
select @w_path = pp_path_destino
from   cobis..ba_path_pro
where  pp_producto = 4

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select
@w_nombre       = 'REPORTE_TRAS_AHO',
@w_nom_tabla    = 'ah_reporte_traslado_ofi',
@w_col_id       = 0,
@w_columna      = '',
@w_cabecera     = convert(varchar(2000), ''),
@w_nombre_cab   = @w_nombre

select @w_nombre_plano = @w_path + @w_nombre_cab + '_' + @w_fecha1 + '.txt'

while 1 = 1
begin
   set rowcount 1
   select
   @w_columna = c.name,
   @w_col_id  = c.colid
   from cob_ahorros..sysobjects o, cob_ahorros..syscolumns c
   where o.id    = c.id
   and   o.name  = @w_nom_tabla
   and   c.colid > @w_col_id
   order by c.colid

   if @@rowcount = 0
   begin
      set rowcount 0
      break
   end

   select @w_cabecera = @w_cabecera + @w_columna + '^|'
end

select @w_cabecera = left(@w_cabecera, datalength(@w_cabecera) - 2)

--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERRORFIN
end

--Ejecucion para Generar Archivo Datos
select @w_comando = @w_s_app + 's_app bcp -auto -login cob_ahorros..ah_reporte_traslado_ofi out '

select
@w_destino  = @w_path + 'REPORTE_TRAS_AHO.txt',
@w_errores  = @w_path + 'REPORTE_TRAS_AHO.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
   select @w_msg = 'Error Generando Archivo Reporte de Traslado Masivo de Oficinas'
   goto ERRORFIN
end

----------------------------------------
--Union de archivos (cab) y (dat)
----------------------------------------
select @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path + 'REPORTE_TRAS_AHO.txt' + ' ' + @w_nombre_plano
exec @w_error = xp_cmdshell @w_comando

select @w_cmd = 'del ' + @w_destino
exec xp_cmdshell @w_cmd

if @w_error <> 0
begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERRORFIN
end
else
   drop table ah_reporte_traslado_ofi

SET NOCOUNT OFF

return 0

ERRORFIN:
print 'Se genero Error, se procede a eliminar tabla ah_reporte_traslado_ofi'
if exists (select 1 from sysobjects where name = 'ah_reporte_traslado_ofi')
   drop table ah_reporte_traslado_ofi

   exec cob_ahorros..sp_errorlog
   @i_fecha       = @w_fecha_proceso,
   @i_error       = @w_error,
   @i_tran        = null,
   @i_usuario     = 'op_batch',
   @i_descripcion = @w_msg,
   @i_programa    = @w_sp_name,
   @i_rollback    = 'N'
   print @w_msg
return 1

go

