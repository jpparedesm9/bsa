/*   Archivo:                 sp_admin_conect_timb.sp                   */
/*   Stored procedure:        sp_admin_conect_timb                      */
/*   Base de Datos:           cob_conta_super                           */
/*   Producto:                Cartera                                   */
/*   Disenado por:                                                      */
/*   Fecha de Documentacion:  06/04/2021                                */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancario s propiedad de     */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Generar reporte operativo de cartera y archivo plano respectivo    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha      Nombre          Proposito                               */
/*   06/04/2021 AIN             Emision Inicial                         */
/************************************************************************/

use cob_conta_super
go

if not object_id('sp_admin_conect_timb') is null
   drop proc sp_admin_conect_timb
go

create  proc sp_admin_conect_timb
   @i_operacion          char(1)           ,
   @i_tabla              varchar(30) = null, -- nombre de la tabla para retornar el secuencial
   @i_parametro          varchar(6)  = null,
   @i_archivo_zip        varchar(100)= null,
   @i_factura            varchar(100)= null,
   @i_complemento        varchar(100)= null,
   @i_estado             varchar(2)  = null,
   @i_tipo_conector      char(1)     = null,
   @t_show_version       bit         = 0   ,
   @t_debug              char(1)     = 'N' ,
   @t_file               varchar(10) = null

AS

declare
@w_sp_name              varchar(30),
@w_secuencial           int


select @w_sp_name = 'sp_admin_conect_timb'

-- Devolver los conectores habilitados
if @i_operacion = 'C'
begin 
   select * 
   from cob_credito..cr_conector_timbrado
   where ct_estado = 'V'
   and ct_tipo_conector = @i_tipo_conector
end

-- Devolver el secuencial segun la tabla
SET NOCOUNT ON -- Para que no se confunda, el java toma el exec del sp como otro resultado además del select
if @i_operacion = 'S'
begin 
   exec cobis..sp_cseqnos
        @t_debug     = 'N',
        @t_file      = 'sp_admin_conect_timb.sp', 
        @t_from      = 'sp_admin_conect_timb',
        @i_tabla     = @i_tabla,
        @o_siguiente = @w_secuencial out

  select @w_secuencial
  
end

-- Devolver el valor del parametro
if @i_operacion = 'P'
begin 
   select case 
   when pa_tipo = 'C' then pa_char
   when pa_tipo = 'I' then convert(varchar,pa_int)
   end
   from cobis..cl_parametro
   where pa_nemonico = @i_parametro
end

if @i_operacion = 'I'
begin
     insert into sb_factura_paquete(fp_fecha_registro, fp_archivo_zip, fp_factura)
     values (getdate(), @i_archivo_zip, @i_factura)
     
     if @@error != 0 
     begin
        return 70135
     end
end  

if @i_operacion = 'O'
begin
     insert into sb_complemento_paquete(cp_fecha_registro, cp_archivo_zip, cp_complemento)
     values (getdate(), @i_archivo_zip, @i_complemento)
	 
	 if @@error != 0 
     begin
        return 70135
     end
end  
--sb_log_factuacion estado = guardar cuando inicio la compresión (P) y cuando termino (F)
if @i_operacion = 'L' 
begin
     insert into sb_log_factuacion(ff_fecha, lf_archivo, lf_estado)
     values (getdate(), @i_archivo_zip, @i_estado)
	 
	 if @@error != 0 
     begin
        return 70135
     end

end      

--sb_log_complemento estado = guardar cuando inicio la compresión (P) y cuando termino (F)
if @i_operacion = 'M' 
begin
     insert into sb_log_complemento(lc_fecha, lc_archivo, lc_estado)
     values (getdate(), @i_archivo_zip, @i_estado)
	 
	 if @@error != 0 
     begin
        return 70135
     end

end 
return 0