/************************************************************************/
/*      Archivo:              cu_vepol.sp                               */
/*      Stored procedure:     sp_venc_poliza                            */
/*      Base de datos:        cob_credito                               */
/*      Producto:             Credito                                   */
/*      Disenado por:         Luis Ponce                                */
/*      Fecha de escritura:   06/Jul/2011                               */
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
/*      Crea un Archivo plano con la informacion de las polizas de      */
/*      garantias y sus fechas de vencimiento                           */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*      FECHA         AUTOR           RAZON                             */
/*      06/Jul/2011   LPO             Emision Inicial                   */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_venc_poliza')
   drop proc sp_venc_poliza
go
create proc sp_venc_poliza (
        @i_param1   varchar(255) = null,
        @i_param2   varchar(255) = null,
        @i_param3   varchar(255) = null,   --Codigo de Ciudad  (Null Todas las Ciudades)
        @i_param4   varchar(255) = null,   --Codigo de Oficina (Null Todas las Oficinas)
        @i_param5   varchar(255) = null    --Codigo de Tipo de Garantia (Null Todos los Tipos)
)
as
declare  @w_msg           descripcion,
         @w_error         int,
         @w_path_s_app    varchar(30),
         @w_path          varchar(255),
         @w_s_app         varchar(255),
         @w_archivo       descripcion,
         @w_cargo_DPE     varchar(10),
         @w_errores       descripcion,
         @w_archivo_bcp   descripcion,
         @w_saldo_ini     money,
         @w_saldo_fin     money,
         @w_oficina       int,
         @w_encabezado    varchar(8000),
         @i_fecha1        datetime,
         @i_fecha2        datetime,
         @w_fecha_arch    varchar(10),
         @w_hora_arch     varchar(4),
         @w_comando       varchar(1000),
         @w_plano_errores varchar(200),
         @w_cmd           varchar(300),
         @w_sqr           varchar(70),
         @w_fecha_proc    varchar(10),
         @w_tipo_gar      varchar(255),
         @w_ciudad        int

select @w_fecha_proc = convert(varchar, fp_fecha, 101)
from cobis..ba_fecha_proceso

if @@rowcount = 0 begin
   select @w_error = 2101084, @w_msg = 'ERROR AL OBTENER LA FECHA DE PROCESO'
   return 1
end

select
@w_sqr           = 'cob_custodia..cu_venc_poliza',
@w_fecha_arch    = substring(convert(varchar(10),@w_fecha_proc),1,2)+ substring(convert(varchar(10),@w_fecha_proc),4,2)+substring(convert(varchar(10),@w_fecha_proc),7,4),
@w_hora_arch     = substring(convert(varchar,GetDate(),108),1,2) + substring(convert(varchar,GetDate(),108),4,2)

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_arch_fuente = 'cob_custodia..sp_venc_poliza'

if @@rowcount = 0 begin
   select @w_error = 2101084, @w_msg = 'ERROR EN LA BUSQUEDA DEL PATH EN LA TABLA ba_batch'
   return @w_error
end

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

if @@rowcount = 0 begin
   select @w_error = 2101084, @w_msg = 'NO EXISTE EL PARAMETRO GENERAL s_app DE MODULO adm'
   return @w_error
end

if @i_param3 = '0'
   select @i_param3 = null

if @i_param4 = '0'
   select @i_param4 = null

if @i_param5 = '0'
   select @i_param5 = null

select   @i_fecha1      = convert(datetime,    @i_param1)
select   @i_fecha2      = convert(datetime,    @i_param2)
select   @w_ciudad      = convert(int,         @i_param3)
select   @w_oficina     = convert(int,         @i_param4)
select   @w_tipo_gar    = ltrim(rtrim(@i_param5))
                  
if @i_param1 is null
begin
   select
   @i_fecha1 = fp_fecha,
   @i_fecha2 = fp_fecha 
   from cobis..ba_fecha_proceso
end
else 
   if @i_fecha2 is null
   begin
      select 
      @i_fecha2 = fp_fecha  
      from cobis..ba_fecha_proceso 
   end
   
if @i_fecha2 < @i_fecha1
begin
   select @w_error = 999999, @w_msg = 'FECHA INICIAL MAYOR QUE FECHA FINAL'
   return @w_error
end


if exists (select 1 from cob_custodia..sysobjects where name = 'cu_venc_poliza')
   drop table cu_venc_poliza

select
CIUDAD_GARANTIA   = (select ci_descripcion from cobis..cl_ciudad where ci_ciudad = C.cu_ciudad_gar),
OFICINA_GARANTIA  = (select of_nombre from cobis..cl_oficina where of_oficina = C.cu_oficina),
COD_CLIENTE       = cu_garante,
NOMBRE_CLIENTE    = (select ltrim(rtrim(isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'') + ' ' +
                                       isnull(en_nombre,'')))
                     from cobis..cl_ente where en_ente = C.cu_garante),
No_GARANTIA       = cu_codigo_externo,
VALOR_GARANTIA    = cu_valor_actual,
POLIZA            = po_poliza,
ASEGURADORA       = po_aseguradora,
FECHA_DESDE       = po_fvigencia_inicio,
FECHA_HASTA       = po_fvigencia_fin,
UBICACION_VALOR   = po_monto_poliza,
DIRECCION_CLIENTE = (select top 1 di_direccion from cobis..cl_ente, cobis..cl_direccion where en_ente = di_ente and en_ente = C.cu_garante),
TIPO_GARANTIA     = (select tc_tipo + '-' + tc_descripcion from cob_custodia..cu_tipo_custodia where tc_tipo = C.cu_tipo)
into cob_custodia..cu_venc_poliza
from cob_custodia..cu_poliza, cob_custodia..cu_custodia C
where po_codigo_externo = cu_codigo_externo
  and cu_ciudad_gar     = isnull(@w_ciudad,   cu_ciudad_gar)
  and cu_oficina        = isnull(@w_oficina,  cu_oficina)
  and cu_tipo           = isnull(@w_tipo_gar, cu_tipo)
order by cu_ciudad_gar,cu_oficina

if @@rowcount > 1
begin

select
@w_plano_errores = @w_path + 'cu_venc_poliza' + replace(convert(varchar, @w_hora_arch, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.err',
@w_cmd           = @w_s_app + 's_app bcp -auto -login cob_custodia..cu_venc_poliza out ',
@w_comando       = @w_cmd + @w_path +'cu_venc_poliza.txt -b5000 -c -e' + @w_plano_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
    select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    return 1
end
end
return 0
go

