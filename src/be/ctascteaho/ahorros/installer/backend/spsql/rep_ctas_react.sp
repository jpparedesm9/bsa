/************************************************************************/
/*      Archivo:                rep_ctas_react.sp                       */
/*      Stored procedure:       sp_rep_ctas_react                       */
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
/*      Reporte de Cuentas React                                        */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_rep_ctas_react')
   drop proc sp_rep_ctas_react
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_rep_ctas_react (
@t_show_version  bit = 0,
@i_param1   int,       --Filial
@i_param2   datetime,  --Fecha Proceso
@i_param3   char(1),   --Opcion Sucursal
@i_param4   int = NULL --Codigo Sucursal
)
as
declare
@w_sp_name       varchar(30),
@w_mes           char(2),
@w_anio          char(4),
@w_maxofi        int,
@w_minofi        int,
@w_filial        int,
@w_cod_sucursal  int,
@w_opcion_suc    char(1),
@w_fecha_proceso datetime,
@w_fecha_inicio  datetime,
@w_fecha_ini     datetime,
@w_fecha_fin     datetime,
@w_s_app         varchar(255),
@w_path          varchar(255),
@w_nombre        varchar(255),
@w_nombre_cab    varchar(255),
@w_destino       varchar(2500),
@w_errores       varchar(1500),
@w_error         int,
@w_comando       varchar(3500),
@w_nombre_plano  varchar(2500),
@w_msg           varchar(255),
@w_col_id        int,
@w_columna       varchar(100),
@w_cabecera      varchar(2500),
@w_nom_tabla     varchar(100)

/* Captura del nombre del stored procedure */
select @w_sp_name = 'sp_rep_ctas_react'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

/* INICIALIZACION VARIABLES DE TRABAJO */
select
@w_mes           = datepart(mm, @i_param2),
@w_anio          = datepart(yyyy, @i_param2),
@w_filial        = convert(int,@i_param1),
@w_fecha_proceso = convert(varchar(10), @i_param2, 101),
@w_opcion_suc    = convert(char(1), @i_param3)

if @w_opcion_suc = 'E'
begin
   select @w_cod_sucursal = convert(int, @i_param4)

   if @w_cod_sucursal is NULL
   begin
      select
      @w_msg = 'Falta definir el codigo de la sucursal'
      goto ERRORFIN
   end
end

if len(@w_mes) = 1
   select @w_fecha_ini = convert(varchar(10),('0' + substring(@w_mes, 1, 1) + '/01/' + @w_anio), 103)
else
   select @w_fecha_ini = convert(varchar(10),(@w_mes + '/01/' + @w_anio), 103)

select @w_fecha_fin = @w_fecha_proceso

if @w_opcion_suc = 'T'
begin
   select @w_minofi = min(of_oficina) from cobis..cl_oficina
   select @w_maxofi = max(of_oficina) from cobis..cl_oficina
end else
begin
   select
   @w_minofi = @w_cod_sucursal,
   @w_maxofi = @w_cod_sucursal
end

if exists (select 1 from sysobjects where name = 'ORS485_ctas_react' and type = 'U')
   drop table ORS485_ctas_react

select
'OFICINA_REACTIVACION' = ts_oficina,
'CUENTA'               = ah_cta_banco,
'NOMBRE_CUENTA'        = substring(ah_nombre,1,40),
'FECHA_Y_HORA'         = ts_hora,
'MONTO_INICIO_DIA'     = ts_valor,
'TRANSACCION'          = (substring((select tn_descripcion from cobis..cl_ttransaccion where tn_trn_code = tm_tipo_tran),1, 50)),
'AFECTACION'           = case when tm_signo = 'D' then 'DEBITO' else (case when tm_signo = 'C' then 'CREDITO' end) end,
'VALOR_TRANSACCION'    = tm_valor,
'MONTO_FIN_DIA'        = ah_disponible,
'OFICINA_MOVIMIENTO'   = tm_oficina,
'USUARIO_REACTIVA'     = ts_usuario,
'ESTADO_CUENTA'        = (select c.valor from cobis..cl_catalogo c, cobis..cl_tabla t where t.tabla = 'ah_estado_cta' and t.codigo = c.tabla and c.codigo = ah_estado)
into ORS485_ctas_react
from cob_ahorros..ah_tran_servicio_tmp with(nolock)
     INNER JOIN cob_ahorros..ah_cuenta with(nolock)
     ON  ts_cta_banco = ah_cta_banco
     and ah_oficina  between  @w_minofi and  @w_maxofi
     LEFT JOIN cob_ahorros..ah_tran_monet_tmp with(nolock)
     ON tm_cta_banco  = ah_cta_banco
where ts_tipo_transaccion = 203
and ts_tsfecha between @w_fecha_ini and @w_fecha_fin
and ts_cod_alterno = 1
order by ah_oficina, ah_cta_banco

/*** GENERAR BCP ***/
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 4

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select
@w_nombre       = 'ahctartv',
@w_nom_tabla    = 'ORS485_ctas_react',
@w_col_id       = 0,
@w_columna      = '',
@w_cabecera     = convert(varchar(2000), ''),
@w_nombre_cab   = @w_nombre

select
@w_nombre_plano = @w_path + @w_nombre_cab + '_' + convert(varchar(2), datepart(dd,getdate())) + '_' + convert(varchar(2), datepart(mm,getdate())) + '_' + convert(varchar(4), datepart(yyyy, getdate())) + '.txt'

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
select @w_comando = @w_s_app + 's_app bcp -auto -login cob_ahorros..ORS485_ctas_react out '

select
@w_destino  = @w_path + 'ahctartv.txt',
@w_errores  = @w_path + 'ahctartv.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error Generando Archivo Cupos_Credito'
end

----------------------------------------
--Union de archivos (cab) y (dat)
----------------------------------------

select @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path + 'ahctartv.txt' + ' ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERRORFIN
end

return 0

ERRORFIN:
   print @w_msg

go

