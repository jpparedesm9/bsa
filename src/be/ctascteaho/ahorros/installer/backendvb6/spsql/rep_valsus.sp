/************************************************************************/
/*      Archivo:                rep_valsus.sp                           */
/*      Stored procedure:       sp_rep_valsus                           */
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
/*      Reporte de Valores en Suspenso                                  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_rep_valsus')
   drop proc sp_rep_valsus
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc sp_rep_valsus(
@t_show_version  bit = 0,
@i_param1     datetime  = null, --Fecha Inicial
@i_param2     datetime  = null, --Fecha Final
@i_corresponsal char(1) = 'N'  --Req. 381 CB Red Posicionada
)
as
declare
@w_fecha_ini     datetime,
@w_fecha_fin     datetime,
@w_msg           descripcion,
@w_sp_name       varchar(20),
@w_s_app         varchar(255),
@w_path          varchar(255),
@w_nombre        varchar(255),
@w_nombre_cab    varchar(255),
@w_destino       varchar(2500),
@w_errores       varchar(1500),
@w_error         int,
@w_nombre_plano  varchar(2500),
@w_col_id        int,
@w_columna       varchar(100),
@w_cabecera      varchar(2500),
@w_nom_tabla     varchar(100),
@w_comando       varchar(2500),
@w_fecha_proc    datetime,
@w_prod_bancario varchar(50) --Req. 381 CB Red Posicionada

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_rep_valsus'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select
@w_fecha_ini  = @i_param1,
@w_fecha_fin  = @i_param2,
@w_fecha_proc = fp_fecha from cobis..ba_fecha_proceso

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo and
      cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

select
'OFICINA' = vs_oficina,
'CUENTA'  = vs_cuenta,
'NOMBRE'  = (select ah_nombre from ah_cuenta where ah_cuenta = vs_cuenta),
'CAUSA'   = vs_servicio + ' - ' + (select c.valor
                                   from   cobis..cl_catalogo c,
                                          cobis..cl_tabla t
                                   where  t.tabla = 'ah_causa_nd'
                                   and    t.codigo = c.tabla
                                   and    c.codigo = vs_servicio),
'VALOR'   = vs_valor,
'ESTADO'  = (case vs_estado when 'N' then 'PENDIENTE' when 'C' then 'CANCELADO' else '' end)
into  Report_Val_Suspenso
from  cob_ahorros..ah_val_suspenso
where vs_fecha between @w_fecha_ini and @w_fecha_fin

if @@ROWCOUNT = 0
begin
   select
   @w_error = 0,
   @w_msg = 'NO EXISTEN DATOS EN LAS FECHAS SOLICITADAS'
   goto ERRORFIN
end

/*** GENERAR BCP ***/
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

select @w_path = pp_path_destino
from   cobis..ba_path_pro
where  pp_producto = 4

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select
@w_nombre       = 'ahvalsus',
@w_nom_tabla    = 'Report_Val_Suspenso',
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
select @w_comando = @w_s_app + 's_app bcp -auto -login cob_ahorros..Report_Val_Suspenso out '

select
@w_destino  = @w_path + 'ahvalsus.txt',
@w_errores  = @w_path + 'ahvalsus.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_msg = 'Error Generando Archivo Reporte de Valores en Suspenso'
   goto ERRORFIN
end

----------------------------------------
--Union de archivos (cab) y (dat)
----------------------------------------

select @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path + 'ahvalsus.txt' + ' ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERRORFIN
end

if exists (select 1 from sysobjects where name = 'Report_Val_Suspenso')
   drop table Report_Val_Suspenso

set nocount off

return 0

ERRORFIN:

if exists (select 1 from sysobjects where name = 'Report_Val_Suspenso')
   drop table Report_Val_Suspenso

exec cobis..sp_errorlog
   @i_fecha       = @w_fecha_proc,
   @i_error       = @w_error,
   @i_tran        = null,
   @i_usuario     = 'op_batch',
   @i_tran_name   = 'Report_Val_Suspenso',
   @i_cuenta      = '',
   @i_rollback    = 'N',
   @i_descripcion = @w_msg

   return @w_error

go

