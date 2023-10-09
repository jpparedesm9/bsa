use cob_credito
go
/************************************************************/
/*   ARCHIVO:         cr_envestcta.sp                       */
/*   NOMBRE LOGICO:   sp_actualiza_est_cta_env              */
/*   PRODUCTO:        COBIS CREDITO                         */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  biginternacionales de */
/*   propiedad bigintelectual.  Su uso  no  autorizado dara */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*  Control del envio del estado de cuenta de los clientes. */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR         RAZON                      */
/* 31/AGO/2017     WToledo			Emision inicial 		      */
/************************************************************/

if exists(select 1 from sysobjects where name = 'sp_actualiza_est_cta_env')
    drop proc sp_actualiza_est_cta_env
go
create proc sp_actualiza_est_cta_env (
   @i_operacion    char(1) = null,
   @i_cliente      int = null,
   @i_nombre_arch  varchar(100) = null
   --@i_nombre_xml   varchar(100) = null
)as
declare
   @w_sp_name  varchar(24),
   @w_msg      varchar(200),
   -- -----------------------
   @w_password varchar(30),
   @w_fecha_proceso datetime,
   @w_numerr   int

select   @w_sp_name= 'sp_genera_estado_cta_xml'

select @w_fecha_proceso = fp_fecha 
from cobis..ba_fecha_proceso

if @i_operacion = 'I'
begin
   if exists(select 1 from cr_estado_cta_enviado where ec_id_cliente = @i_cliente and ec_estado = 'P')
   begin
      update cr_estado_cta_enviado
      set ec_nombre_arch  = isnull(@i_nombre_arch,ec_nombre_arch)
      where ec_id_cliente = @i_cliente
      and ec_estado = 'P'
      and ec_fecha_proc = @w_fecha_proceso
   end
   else
   begin
      insert into cr_estado_cta_enviado(ec_id_cliente	,ec_nombre_arch ,ec_estado, ec_fecha_proc)
      values( @i_cliente, @i_nombre_arch,'P', @w_fecha_proceso) --Pendiente
   end
   if @@error <> 0
   begin
      select 
         @w_numerr = 2101140,
         @w_msg = 'ERROR EN INSERCION/ACTUALIZACION CR_ESTADO_CTA_ENVIADO - OPERACION I'
      goto ERROR
   end
end

if @i_operacion = 'Q'
begin
   select 
      "CLIENTE" = ec_id_cliente, 
      "ARCHIVO" = ec_nombre_arch,
      "EMAIL"   = (select top 1 di_descripcion from cobis..cl_direccion where di_ente = ec_id_cliente and di_tipo = 'CE'),
      "NOMBRE"  = (select en_nomlar from cobis..cl_ente where en_ente = ec_id_cliente )
   from cr_estado_cta_enviado 
   where ec_estado = 'P'
   and ec_fecha_proc = @w_fecha_proceso
   if @@rowcount = 0
   begin
      select 
         @w_numerr = 101144,
         @w_msg = 'NO EXISTE DATO - CR_ESTADO_CTA_ENVIADO - OPERACION Q'
      goto ERROR
   end
end

if @i_operacion = 'S'
begin
   select @w_password = pa_char
   from cobis..cl_parametro
   where pa_producto = 'CRE'
   and pa_nemonico = 'PWDEEC'
   if @@rowcount = 0
   begin
      select 
         @w_numerr = 101144,
         @w_msg = 'NO EXISTE DATO - CR_ESTADO_CTA_ENVIADO - OPERACION S'
      goto ERROR
   end
   
   select "PASSWORD" = @w_password
end

if @i_operacion = 'D'
begin
   update cr_estado_cta_enviado
   set ec_estado     = 'T', --Terminado
       ec_fecha_proc = @w_fecha_proceso
   where ec_id_cliente = @i_cliente
   if @@error <> 0
   begin
      select 
         @w_numerr = 2101140,
         @w_msg = 'ERROR EN ACTUALIZACION CR_ESTADO_CTA_ENVIADO - OPERACION D'
      goto ERROR
   end
end

return 0

ERROR:
exec cobis..sp_cerror
   @t_debug	= 'N',                                                                                                                                                                                                        
   @t_file	= '',
   @t_from  = @w_sp_name,
   @i_num	= @w_numerr,
   @i_msg	= @w_msg
return @w_numerr

go
