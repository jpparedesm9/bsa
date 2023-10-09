/************************************************************************/
/*      Archivo:                rep_vsusp.sp                            */
/*      Stored procedure:       sp_rep_vsusp                            */
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

if exists (select 1 from sysobjects where name = 'sp_rep_vsusp')
   drop proc sp_rep_vsusp
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc sp_rep_vsusp (
   @t_show_version  bit = 0
)

as
declare
   @w_sp_name            varchar(32),
   @w_msg                varchar(100),
   @w_error              int,
   @w_s_app              varchar(30),
   @w_comando            varchar(1000),
   @w_nombre             varchar(255),
   @w_columna            varchar(100),
   @w_nom_tabla          varchar(100),
   @w_col_id             int,
   @w_cabecera           varchar(2000),
   @w_nombre_cab         varchar(255),
   @w_destino            varchar(255),
   @w_errores            varchar(1500),
   @w_nombre_plano       varchar(2500),
   @w_path               varchar(250),
   @w_cmd                varchar (2500),
   @w_fecha_proc         datetime,
   @w_prod_bancario      char,
   @w_tabla              int,
   @w_cont               int

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_rep_vsusp'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

set nocount on

select @w_fecha_proc = fp_fecha from cobis..ba_fecha_proceso

-- c¾digo de tabla
select @w_tabla = codigo
from   cobis..cl_tabla
where  tabla = 'ah_causa_nd'

If @w_tabla is null
begin
   select
   @w_msg   = 'ERROR CARGANDO TABLA',
   @w_error = 251141
   goto ERRORFIN
end

--Ruta bcp
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

If @w_s_app is null
begin
   select
   @w_msg   = 'ERROR CARGANDO PARAMETRO BCP',
   @w_error = 251142
   goto ERRORFIN
end

/* PATH DESTINO */
select @w_path = ba_path_destino
   from cobis..ba_batch
   where ba_batch = 4271

if @w_path is null
begin
   select
   @w_msg     = 'ERROR CARGANDO LA RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION',
   @w_error   = 251143
   goto ERRORFIN
end

--Producto Bancario para CB
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla = cl_tabla.codigo and
cl_tabla.tabla = 're_pro_banc_cb'
and cl_catalogo.estado = 'V'


If @w_prod_bancario is null
begin
   select
   @w_msg     = 'NO EXISTE PRODUCTO BANCARIO CB EN CATALOGO',
   @w_error   = 251144
   goto ERRORFIN
end

--Borrado de datos
truncate table  cob_ahorros..ah_reporte_vsuspenso

---- B·squeda de valores en suspenso
insert into cob_ahorros..ah_reporte_vsuspenso
select
ah_fecha           = getdate(),
ah_ofi_suspenso    = vs_oficina,
ah_ofi_sus_desc    = (select of_nombre from cobis..cl_oficina where of_oficina = vs_oficina),
ah_oficina_cta     = ah_oficina,
ah_nom_oficina_cta = (select of_nombre from cobis..cl_oficina where of_oficina = ah_oficina),
ah_zona_cta        = (select of_zona from cobis..cl_oficina  where of_subtipo = 'O' and of_oficina = ah_oficina),
ah_zona_cta_desc   = convert(varchar(60),''),
ah_causal          = vs_servicio,
ah_concepto        = (select valor from cobis..cl_catalogo where tabla = @w_tabla and codigo = vs_servicio),
ah_fecha_cobro     = convert(varchar(10),vs_fecha,103),
ah_valor           = vs_valor,
ah_nombre_cliente  = ah_nombre,
ah_id_cliente      = ah_ced_ruc,
ah_cuenta          = ah_cta_banco,
ah_saldo_cuenta    = convert(varchar(20),ah_disponible),
ah_dias            = convert(varchar(20), abs(datediff(dd,vs_fecha, @w_fecha_proc)))
from   cob_ahorros..ah_val_suspenso with(nolock),
       cob_ahorros..ah_cuenta_tmp with(nolock)
where  vs_cuenta = ah_cuenta
and    convert (char,ah_prod_banc) <> @w_prod_bancario
and    vs_estado = 'N'
order by ah_ced_ruc

if @@ROWCOUNT = 0
   select @w_cabecera = 'NO HAY REGISTROS DE VALORES EN SUSPENSO PENDIENTES'
else
   select @w_cabecera = 'FECHA_EJECUCION^|OFI_VSUSP^|NOM_OFI_VSUSP^|OFI_CTA^|NOM_OFI_CTA^|ZONA_CTA^|ZONA_CTA_DESC^|CAUSAL^|CONCEPTO_CAUSAL^|FECHA_GEN_VSUSP^|VALOR_SUSPENSO^|NOMBRE_CLIENTE^|CEDULA_CLIENTE^|NRO_CUENTA^|SALDO_CUENTA^|NUM_DIAS_VSUSP'

update cob_ahorros..ah_reporte_vsuspenso
set ah_zona_cta_desc = of_nombre
from   cobis..cl_oficina
where  of_oficina = ah_zona_cta


if (@@ERROR <> 0)
begin
   select
   @w_error = 263500,
   @w_msg   = 'ERROR EN INSERCION DE REGISTRO'
   goto ERRORFIN
end
----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select
@w_nombre       = 'REPSUSP',
@w_nom_tabla    = 'ah_reporte_vsuspenso',
@w_col_id       = 0,
@w_columna      = '',
--@w_cabecera     = convert(varchar(2000), ''),
@w_nombre_cab   = @w_nombre

select @w_nombre_plano = @w_path +  @w_nombre_cab + '_'+ replace(convert(varchar,@w_fecha_proc,102),'.','')+'.txt'


--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
   select
   @w_msg   = 'EJECUCION bcp FALLIDA AL GENERAR REPORTE.',
   @w_error = 2902797
   goto ERRORFIN
end

--Ejecucion para Generar Archivo Datos

select @w_comando = @w_s_app + 's_app bcp -auto -login cob_ahorros..ah_reporte_vsuspenso out '

select
@w_destino  = @w_path + @w_nombre+'.txt',
@w_errores  = @w_path + @w_nombre+'.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
   select @w_msg = 'Error Generando Archivo Reporte de: '+ @w_nombre,
   @w_error = 2902797

   goto ERRORFIN
end

----------------------------------------
--Union de archivos (cab) y (dat)
----------------------------------------
select @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path + @w_nombre+'.txt' + ' ' + @w_nombre_plano

exec @w_error = xp_cmdshell @w_comando

select @w_cmd = 'del ' + @w_destino
exec xp_cmdshell @w_cmd

if @w_error <> 0
begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERRORFIN
end
else
begin
   -- elimina archivo errores de no existir
   select @w_comando = 'del ' + @w_path + @w_nombre + '.err'

   exec @w_error = xp_cmdshell @w_comando
      if @w_error <> 0
      begin
         select @w_msg = 'EJECUCION comando bcp FALLIDA (Eliminacion temp .err). REVISAR ARCHIVOS DE LOG GENERADOS. '
         goto ERRORFIN
      end
end


return 0

ERRORFIN:
exec cob_ahorros..sp_errorlog
@i_fecha        = @w_fecha_proc,
@i_error        = @w_error,
@i_usuario      = 'batch',
@i_tran         = 26004,
@i_descripcion  = @w_msg,
@i_programa     = @w_sp_name

return @w_error

go

