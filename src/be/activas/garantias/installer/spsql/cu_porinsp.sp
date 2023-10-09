/************************************************************************/
/*      Archivo:              cu_porinsp.sp                             */
/*      Stored procedure:     sp_bcp_gar_por_inspeccionar               */
/*      Base de datos:        cob_custodia                              */
/*      Producto:             Garantias                                 */
/*      Disenado por:         Johan Ardila                              */
/*      Fecha de escritura:   08/Jul/2011                               */
/************************************************************************/
/*              IMPORTANTE                                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP'.                                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*      PROPOSITO                                                       */
/*      Este programa realiza lo siguiente:                             */
/*      Crea un Archivo plano con la informacion de las garantías por   */
/*      inspecccionar en un rango de fechas                             */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*      FECHA         AUTOR           RAZON                             */
/*      08/Jul/2011   Johan Ardila    REQ 266 - Emision Inicial         */
/************************************************************************/
use cob_custodia
go

if object_id('sp_bcp_gar_por_inspeccionar') is not null
begin
   drop proc sp_bcp_gar_por_inspeccionar
end
go

create proc sp_bcp_gar_por_inspeccionar (
   @i_param1   varchar(255) = null,   -- Fecha Ini
   @i_param2   varchar(255) = null,   -- Fecha Fin
   @i_param3   varchar(255) = null    -- Codigo de Oficina (0-Todas las Oficinas)
)
as
declare  
   @w_msg           descripcion,
   @w_error         int,
   @w_path          varchar(255),
   @w_s_app         varchar(255),
   @w_oficina       int,
   @w_encabezado    varchar(255),
   @w_fecha_ini     datetime,
   @w_fecha_fin     datetime,
   @w_hora_arch     varchar(4),
   @w_comando       varchar(355),
   @w_plano_errores varchar(200),
   @w_cmd           varchar(300),
   @w_fecha_proc    varchar(10),
   @w_nom_arch      descripcion

select @w_fecha_proc = fp_fecha
  from cobis..ba_fecha_proceso

if @@rowcount = 0 begin
   select @w_error = 2101084, @w_msg = 'ERROR AL OBTENER LA FECHA DE PROCESO'
   return 2101084
end

select @w_hora_arch = substring(convert(varchar,getdate(),108),1,2) + substring(convert(varchar,getdate(),108),4,2)

select @w_path = ba_path_destino
  from cobis..ba_batch
 where ba_arch_fuente = 'cob_custodia..sp_bcp_gar_por_inspeccionar'

if @@rowcount = 0 begin
   select @w_error = 2101084, @w_msg = 'ERROR EN LA BUSQUEDA DEL PATH EN LA TABLA ba_batch'
   return @w_error
end

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

if @@rowcount = 0 begin
   select @w_error = 2101084, @w_msg = 'NO EXISTE EL PARAMETRO GENERAL s_app DE MODULO adm'
   return @w_error
end

-- Todas las Oficinas
if @i_param3 = '0' select @i_param3 = null

select   
   @w_fecha_ini = convert(datetime, @i_param1),
   @w_fecha_fin = convert(datetime, @i_param2),
   @w_oficina   = convert(int,      @i_param3)

if @i_param1 is null
begin
   select @w_fecha_ini = @w_fecha_proc
end

if @i_param2 is null
begin
   select @w_fecha_fin = @w_fecha_proc
end
   
if @w_fecha_fin < @w_fecha_ini
begin
   select @w_error = 999999, @w_msg = 'FECHA INICIAL MAYOR QUE FECHA FINAL'
   return @w_error
end

/* GARANTIAS POR INSPECCIONAR */
if object_id ('cu_gar_por_visitar') is not null drop table cu_gar_por_visitar

exec @w_error = sp_por_inspeccionar
   @i_operacion     = 'Z',
   @t_trn           = 19167,
   @i_batch         = 'S',
   @i_fecha_ini     = @w_fecha_ini,
   @i_fecha_fin     = @w_fecha_fin,
   @i_sucursal      = @w_oficina,
   @i_filial        = 1,
   @i_formato_fecha = 101   
   
if @w_error <> 0 
begin
   select @w_msg = 'ERROR AL EJECUTAR sp_por_inspeccionar'
   return @w_error
end   


if object_id('cu_gar_por_visitar_tmp') is not null
begin
   drop table cu_gar_por_visitar_tmp
end

select OFICINA,    DESC_OFICINA,     GARANTIA,         
       TIPO,       DESCRIPCION,      NOMBRE_CLIENTE,   
       FECHA_ANT,  NOMBRE_AVAL_ANT,  ESTADO_ANT,       
       CIUDAD,     NOMBRE_AVALUADOR, DETALLE           
  into cu_gar_por_visitar_tmp
  from cu_gar_por_visitar
 order by OFICINA, TIPO, GARANTIA

if @@rowcount > 1
begin
   select @w_nom_arch = 'cu_gar_por_visitar_' + convert(varchar, getdate(), 112) + '.txt' 
   select
   @w_plano_errores = @w_path + 'cu_gar_por_visitar' + replace(convert(varchar, @w_hora_arch, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.err',
   @w_cmd           = @w_s_app + 's_app bcp -auto -login cob_custodia..cu_gar_por_visitar_tmp out ',
   @w_comando       = @w_cmd + @w_path + @w_nom_arch + ' -c -e' + @w_plano_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'
   
   exec @w_error = xp_cmdshell @w_comando
   
   if @w_error <> 0 
   begin
       select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVIZAR ARCHIVOS DE LOG GENERADOS.'
       return @w_error
   end
end
return 0
go

