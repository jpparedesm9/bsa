/*****************************************************************************/
/* Archivo           :  rep_conta_gar.sp                                     */
/* Stored procedure  :  sp_rep_conta_gar                                     */
/* Base de datos     :  cob_conta_super                                      */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                            PROPOSITO                                      */
/* Programa que genera un reporte para la contabilizacionde Garantias        */
/*****************************************************************************/
/*                           MODIFICACIONES                                  */
/* FECHA           AUTOR               RAZON                                 */
/* 01/12/2016      Nolberto Vite       Emision Inicial                       */
/*****************************************************************************/
use cob_conta_super
go
if exists (select 1 from sysobjects where name = 'sp_rep_conta_gar')
   drop proc sp_rep_conta_gar
go
 
create proc sp_rep_conta_gar
(  
   @t_show_version   bit = 0,
   @i_param1         datetime
)

as 
declare
   @i_fecha          datetime,
   @i_periodicidad   tinyint,

   @w_return         int,     /* valor que retorna */
   @w_sp_name        varchar(32),
   @w_bancamia       varchar(24),
   @w_clave          varchar(30),
   @w_subreporte     varchar(30),
   @w_fecha_ini      datetime,
   @w_prod_pcame     varchar(10),
   @w_prod_pcaaso    varchar(10),
   @w_prod_pcaasa    varchar(10),
   @w_mayor_edad     tinyint,
   @w_cod_rel        int,
   @w_mes_fecha      tinyint,
   @w_moneda_local   tinyint,
   @w_s_app          varchar(50),
   @w_path           varchar(50),
   @w_destino        varchar(2500),
   @w_msg            varchar(200),
   @w_error          int,
   @w_errores        varchar(1500),
   @w_comando        varchar(2500)

select
   @w_sp_name        = 'sp_rep_conta_gar',
   @i_fecha          = @i_param1

--Versionamiento del Programa --
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
  return 0
end

delete sb_errorlog
where er_fuente = @w_sp_name

select @w_s_app = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'ADM'
and pa_nemonico = 'S_APP'

if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO S_APP'
   goto ERRORFIN
end

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = 36001

if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE RUTA PATH DESTINO'
   goto ERRORFIN
end

select 	cg_categoria           = dc_categoria,
		cg_tipo                = dc_tipo,
		cg_calidad_gar         = isnull(dc_calidad_gar, ''),
		cg_garantia            = dc_garantia,
		cg_valor_comerc        = dc_valor_avaluo,
		cg_valor_util          = dc_valor_actual,
		cg_valor_uti_opera     = dc_valor_uti_opera,
		cg_saldo_disp_cobe     = (dc_valor_actual - dc_valor_uti_opera)
into #rep_conta_gar
from sb_dato_custodia
INNER JOIN sb_dato_garantia
ON sb_dato_custodia.dc_garantia = sb_dato_garantia.dg_garantia
where dc_fecha = dg_fecha
and dc_fecha = @i_fecha
order by dc_garantia 

if @@error <> 0 begin
   select @w_msg = 'ERROR INSERTANDO DATOS DE AHORROS EN #rep_conta_gar'
   goto ERRORFIN
end

truncate table cob_conta_super..sb_rep_conta_gar

--Inserta cabecera
insert into cob_conta_super..sb_rep_conta_gar
values ('CATEGORIA','TIPO','CALIDAD GARANTIA','GARANTIA',       
		'         VALOR COMERCIAL','        VALOR UTILIZABLE',' VALOR UTIL CUBRIR PREST', '        SALDO DISPONIBLE')

--Inserta Datos
insert into cob_conta_super..sb_rep_conta_gar
(
	cg_categoria,        cg_tipo,         cg_calidad_gar,     cg_garantia,       
	cg_valor_comerc,     cg_valor_util,   cg_valor_uti_opera, cg_saldo_disp_cobe
)
select
	cg_categoria,               cg_tipo,                cg_calidad_gar,            cg_garantia,       
	cg_valor_comerc,     cg_valor_util,   cg_valor_uti_opera, cg_saldo_disp_cobe
from #rep_conta_gar

if @@error <> 0 begin
   select @w_msg = 'ERROR INSERTANDO DATOS EN SB_rep_conta_gar'
   goto ERRORFIN
end

--Ejecucion para Generar Archivo Datos
select @w_comando = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_rep_conta_gar out '

select @w_destino  = @w_path + 'rep_conta_gar_' + convert(varchar, datepart(yy, @i_fecha)) + right('0'+ convert(varchar,datepart(mm,@i_fecha)),2) + '.txt',
       @w_errores  = @w_path + 'rep_conta_gar_' + convert(varchar, datepart(yy, @i_fecha)) + right('0'+ convert(varchar,datepart(mm,@i_fecha)),2) + '.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e -T -C' + @w_errores + ' -t"\t" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_msg = 'ERROR EN EJECUCION ' + @w_comando
   goto ERRORFIN
end

FIN:
return 0

ERRORFIN: 

   exec cob_conta_super..sp_errorlog
   @i_operacion     = 'I',
   @i_fecha_fin     = @i_fecha,
   @i_fuente        = @w_sp_name,
   @i_origen_error  = '28016',
   @i_descrp_error  = @w_msg
   
   return 1
go
