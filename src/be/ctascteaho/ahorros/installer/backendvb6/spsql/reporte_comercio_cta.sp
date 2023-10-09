/************************************************************************/
/*      Archivo:                reporte_comercio_cta.sp                 */
/*      Stored procedure:       sp_reporte_comercio_cta                 */
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
/*      Generando Archivo ah_reporte_comercio_cta                       */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_reporte_comercio_cta')
   drop proc sp_reporte_comercio_cta
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc sp_reporte_comercio_cta (
@t_show_version      bit = 0,
@i_param1            varchar(255),     --Fecha Inicio
@i_param2            varchar(255)      --Fecha Fin

)
as
declare
@i_fecha_ini         datetime,
@i_fecha_fin         datetime,
@i_tipo              varchar(1),
@w_periodicidad      varchar(1),
@w_sp_name           varchar(20),
@w_fecha_ant         datetime,
@w_slm               money,
@w_s_app             varchar(50),
@w_path              varchar(50),
@w_nombre            varchar(32),
@w_nombre_cab        varchar(30),
@w_cmd               varchar(255),
@w_destino           varchar(2500),
@w_errores           varchar(1500),
@w_error             int,
@w_comando           varchar(2500),
@w_nombre_plano      varchar(1500),
@w_mensaje           varchar(200),
@w_msg               varchar(200),
@w_col_id            int,
@w_columna           varchar(30),
@w_cabecera          varchar(2500)

-- Captura nombre de Stored Procedure
select @w_sp_name       = 'sp_reporte_comercio_cta'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select
@i_fecha_ini     = convert(datetime, @i_param1),
@i_fecha_fin     = convert(datetime, @i_param2)

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = pa_char
from cobis..cl_parametro
where pa_nemonico = 'RUTBM'

if @w_path is null
begin
   select
        @w_msg     = 'ERROR CARGANDO LA RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION',
        @w_error   = 4000002
   goto ERRORFIN
end

-------------------------------------------
--Generar Archivo de Informacion (detalle)
-------------------------------------------

truncate table ah_reporte_comercio_cta

--cta destino
insert into ah_reporte_comercio_cta (
tipo_id,             identificacion,             codigo_comercio,
tipo_tran,           causal,                     monto,
fecha_tran,          hora_tran,                  id_tran,
estado_tran,         ctaahoorg,                  ctaahodest
)
select
en_tipo_ced,         en_ced_ruc,                 mc_comercio,
case when ts_tipo_tran in (26540, 26541) then 'NC' else tn_desc_larga end,
case when ts_tipo_tran in (26540, 26541) then (select top 1 b.valor
                                               from cobis..cl_tabla a, cobis..cl_catalogo b
                                               where a.tabla  = 'ah_causa_nc'
                                               and   a.codigo = b.tabla
                                               and   b.codigo = X.ts_campo4) else '' end,
isnull(ts_monto,0),
convert(varchar(10),ts_fecha,103),
convert(varchar(2),datepart(hh, ts_hora)) + ':' + convert(varchar(2),datepart(mi, ts_hora)) + ':' + convert(varchar(2),datepart(ss, ts_hora)),
ts_sec_ext,
case when ts_estado = 'X' then 'DECLINADO'
     when ts_estado = 'A' then 'EXITOSO'
     when ts_estado = 'R' then 'REVERSADO'
end,
ts_banco_orig,
ts_banco_dest
from cob_remesas..re_marcacion_cuentas with (nolock), cob_ahorros..ah_cuenta with (nolock), cobis..cl_ente with (nolock),
     cobis..ws_tran_servicio X, cobis..cl_ttransaccion with (nolock)
where mc_servicio  = 'COM'
and   mc_cuenta    = ah_cta_banco
and   ah_cliente   = en_ente
and   ah_cta_banco = ts_banco_dest
and   tn_trn_code  = ts_tipo_tran
and   ts_fecha     between @i_fecha_ini and @i_fecha_fin
and   ts_tipo_tran in (26533, 26534, 56535, 26536, 26537, 26538, 26539, 26540, 26541)
and   ts_canal = 10

--cta origen
insert into ah_reporte_comercio_cta (
tipo_id,             identificacion,             codigo_comercio,
tipo_tran,           causal,                     monto,
fecha_tran,          hora_tran,                  id_tran,
estado_tran,         ctaahoorg,                  ctaahodest
)
select
en_tipo_ced,         en_ced_ruc,                 mc_comercio,
case when ts_tipo_tran in (26540, 26541) then 'ND' else tn_desc_larga end,
case when ts_tipo_tran in (26540, 26541) then (select top 1 b.valor
                                               from cobis..cl_tabla a, cobis..cl_catalogo b
                                               where a.tabla  = 'ah_causa_nd'
                                               and   a.codigo = b.tabla
                                               and   b.codigo = X.ts_campo4) else '' end,
isnull(ts_monto,0),
convert(varchar(10),ts_fecha,103),
convert(varchar(2),datepart(hh, ts_hora)) + ':' + convert(varchar(2),datepart(mi, ts_hora)) + ':' + convert(varchar(2),datepart(ss, ts_hora)),
ts_sec_ext,
case when ts_estado = 'X' then 'DECLINADO'
     when ts_estado = 'A' then 'EXITOSO'
     when ts_estado = 'R' then 'REVERSADO'
end,
ts_banco_orig,
ts_banco_dest
from cob_remesas..re_marcacion_cuentas with (nolock), cob_ahorros..ah_cuenta with (nolock), cobis..cl_ente with (nolock),
     cobis..ws_tran_servicio X, cobis..cl_ttransaccion with (nolock)
where mc_servicio  = 'COM'
and   mc_cuenta    = ah_cta_banco
and   ah_cliente   = en_ente
and   ah_cta_banco = ts_banco_orig
and   tn_trn_code  = ts_tipo_tran
and   ts_fecha     between @i_fecha_ini and @i_fecha_fin
and   ts_tipo_tran in (26533, 26534, 56535, 26536, 26537, 26538, 26539, 26540, 26541)
and   ts_canal = 10

-------------------------------------------
--Generar Archivo de Informacion (totales)
-------------------------------------------
insert into ah_reporte_comercio_cta (
tipo_id,             identificacion,             codigo_comercio,
tipo_tran,           causal,                     monto,
fecha_tran,          hora_tran,                  id_tran,
estado_tran,         ctaahoorg,                  ctaahodest
)
select
null,                'TOTALES',                  null,
tipo_tran,           causal,                     null,
null,                null,                       count(1),
null,                null,                       null
from ah_reporte_comercio_cta
group by tipo_tran, causal

insert into ah_reporte_comercio_cta (
tipo_id,             identificacion,             codigo_comercio,
tipo_tran,           causal,                     monto,
fecha_tran,          hora_tran,                  id_tran,
estado_tran,         ctaahoorg,                  ctaahodest
)
select
null,                'TOTALES',                  mc_comercio,
null,                null,                       null,
null,                null,                       count(1),
null,                null,                       null
from cob_remesas..re_marcacion_cuentas with (nolock), ah_reporte_comercio_cta with (nolock)
where mc_servicio  = 'COM'
and   (mc_cuenta   = ctaahoorg or mc_cuenta = ctaahodest)
group by mc_comercio


----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select
@w_col_id       = 0,
@w_columna      = '',
@w_cabecera     = convert(varchar(2000), ''),
@w_nombre       = 'REPORTE_CTA_COMERCIO',
@w_nombre_cab   = @w_nombre

select
@w_nombre_plano = @w_path + @w_nombre_cab + '_' + convert(varchar(2), datepart(dd,@i_fecha_fin)) + '_' + convert(varchar(2), datepart(mm,@i_fecha_fin)) + '_' + convert(varchar(4), datepart(yyyy, @i_fecha_fin)) + '.txt'

while 1 = 1 begin
   set rowcount 1
   select @w_columna = c.name,
          @w_col_id  = c.colid
   from sysobjects o, syscolumns c
   where o.id    = c.id
   and   o.name  = 'ah_reporte_comercio_cta'
   and   c.colid > @w_col_id
   order by c.colid

   if @@rowcount = 0 begin
      set rowcount 0
      break
   end

   select @w_cabecera = @w_cabecera + @w_columna + '^|'
end

select @w_cabecera = left(@w_cabecera, datalength(@w_cabecera) - 2)

--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
    select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERRORFIN
end


--Ejecucion para Generar Archivo Datos

select @w_comando = @w_s_app + 's_app bcp -auto -login cob_ahorros..ah_reporte_comercio_cta out '

select
@w_destino  = @w_path + 'ah_reporte_comercio_cta.txt',
@w_errores  = @w_path + 'ah_reporte_comercio_cta.err'

select
@w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error Generando Archivo ah_reporte_comercio_cta '
   return @w_error
end


----------------------------------------
--Uni½n de archivo @w_nombre_plano con archivo ah_reporte_comercio_cta.txt
----------------------------------------

select @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path + 'ah_reporte_comercio_cta.txt' + ' ' + @w_nombre_plano

select @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
    select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERRORFIN
end


return 0

ERRORFIN:

   select @w_mensaje = @w_sp_name + ' --> ' + @w_mensaje
   print @w_mensaje

   return 1

go

