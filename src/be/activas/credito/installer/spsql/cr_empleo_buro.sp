/***********************************************************************/
/*     Archivo:                         cr_empleo_buro.sp              */
/*     Stored procedure:                sp_empleo_buro                 */
/*     Base de Datos:                   cob_credito                    */
/*     Producto:                        Credito                        */
/*     Disenado por:                    D. Cumbal                      */
/*     Fecha de Documentacion:          13/Mar/2018                    */
/***********************************************************************/
/*               IMPORTANTE                                            */
/*     Este programa es parte de los paquetes bancarios propiedad de   */
/*     "MACOSA",representantes exclusivos para el Ecuador de la        */
/*     AT&T                                                            */
/*     Su uso no autorizado queda expresamente prohibido asi como      */
/*     cualquier autorizacion o agregado hecho por alguno de sus       */
/*     usuario sin el debido consentimiento por escrito de la          */
/*     Presidencia Ejecutiva de MACOSA o su representante              */
/***********************************************************************/
/*                            PROPOSITO                                */
/*     Procedimiento para obterner el reporte de consultas a buro      */
/***********************************************************************/
/*               MODIFICACIONES                                        */
/*     FECHA          AUTOR                  RAZON                     */
/*  13/Mar/2018      D. Cumbal         Emision Inicial - REQ 93182     */
/*  05-07-2019       srojas            Reestructuración Buro histórico */
/***********************************************************************/
use cob_credito
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if object_id ('sp_empleo_buro') is not null
begin
   drop proc sp_empleo_buro
end
go

create proc sp_empleo_buro (
@s_ssn                 int          = null,
@s_user                login        = null,
@s_sesn                int          = null,
@s_term                descripcion  = null,
@s_date                datetime     = null,
@s_srv                 varchar(30)  = null,
@s_lsrv                varchar(30)  = null,
@s_rol                 smallint     = null,
@s_ofi                 smallint     = null,
@s_org_err             char(1)      = null,
@s_error               int          = null,
@s_sev                 tinyint      = null,
@s_msg                 descripcion  = null,
@s_org                 char(1)      = null,
@t_rty                 char(1)      = null,
@t_trn                 smallint     = null,
@t_debug               char(1)      = 'N',
@t_file                varchar(14)  = null,
@t_from                varchar(30)  = null,
@i_operacion           char(1)            ,
@i_ente                int           = null,
@i_fecha               datetime      = null,
@i_formato_fecha       int           = 101 ,
@i_nombre_empresa      varchar(40)   = null, 
@i_direccion_uno       varchar(40)   = null,
@i_direccion_dos       varchar(40)   = null,
@i_colonia             varchar(40)   = null,
@i_delegacion          varchar(40)   = null,
@i_ciudad              varchar(40)   = null,
@i_estado              varchar(4)    = null,
@i_codigo_postal       varchar(5)    = null,
@i_numero_telefono     varchar(11)   = null,
@i_extension           varchar(8)    = null, 
@i_fax                 varchar(11)   = null, 
@i_cargo               varchar(30)   = null,  
@i_fecha_contratacion  varchar(8)    = null,  
@i_clave_moneda        varchar(2)    = null,  
@i_salario             varchar(9)    = null,  
@i_base_salarial       char(1)       = null, 
@i_num_empleado        varchar(15)   = null,  
@i_fecha_ult_dia       varchar(8)    = null,
@i_codigo_pais         varchar(2)    = null,
@i_fecha_reporto_empl  varchar(8)    = null,
@i_fecha_verificacion  varchar(8)    = null,
@i_modo_verificacion   char(1)       = null )
as
declare
@w_error_number    int,
@w_sp_name         varchar(100),
@w_secuencial      int,
@w_msg             varchar(255)

select @w_sp_name = 'sp_empleo_buro'

if @i_fecha is null
   select @i_fecha = fp_fecha
   from cobis..ba_fecha_proceso
   
if @i_operacion='Q'
begin

   select @w_secuencial = ib_secuencial
   from cob_credito..cr_interface_buro
   where ib_cliente = @i_ente
   and   ib_estado  = 'V'
   
   if @@rowcount = 0 begin
      select 
	  @w_error_number = 2108056 ,
	  @w_msg = 'No existe registro en el buro para el cliente.'
   end
   
   select 
   @i_ente              ,
   eb_nombre_empresa    ,
   eb_direccion_uno     ,
   eb_direccion_dos     ,
   eb_colonia           ,
   eb_delegacion        ,
   eb_ciudad            ,
   eb_estado            ,
   eb_codigo_postal     ,
   eb_numero_telefono   ,
   eb_extension         ,
   eb_fax               ,
   eb_cargo             ,
   eb_fecha_contratacion,
   eb_clave_moneda      ,
   eb_salario           , 
   eb_base_salarial	   ,
   eb_num_empleado 	   ,
   eb_fecha_ult_dia 	   ,
   eb_codigo_pais 	   ,
   eb_fecha_rept_empleo ,
   eb_fecha_verificacion,
   eb_modo_verificiacion
   from cr_empleo_buro
   where eb_ib_secuencial = @w_secuencial

end --@i_operacion

if @i_operacion='I' begin

   select @w_secuencial = ib_secuencial
   from cob_credito..cr_interface_buro
   where ib_cliente = @i_ente
   and   ib_estado  = 'V'
   
   if @@rowcount = 0 begin
      select 
      @w_error_number = 2108056 ,
      @w_msg = 'No existe registro en buro para el cliente ingresado.'
   end

   insert into  cr_empleo_buro 
   (eb_ib_secuencial   ,     eb_nombre_empresa    , 
   eb_direccion_uno    ,     eb_direccion_dos     ,      eb_colonia           , 
   eb_delegacion       ,     eb_ciudad            ,      eb_estado            , 
   eb_codigo_postal    ,     eb_numero_telefono   ,      eb_extension         , 
   eb_fax              ,     eb_cargo             ,      eb_fecha_contratacion, 
   eb_clave_moneda     ,     eb_salario           ,      eb_base_salarial     , 
   eb_num_empleado     ,     eb_fecha_ult_dia     ,      eb_codigo_pais       ,
   eb_fecha_rept_empleo,     eb_fecha_verificacion,      eb_modo_verificiacion)
   values 
   (@w_secuencial      ,     @i_nombre_empresa    , 
   @i_direccion_uno    ,     @i_direccion_dos     ,      @i_colonia           , 
   @i_delegacion       ,     @i_ciudad            ,      @i_estado            , 
   @i_codigo_postal    ,     @i_numero_telefono   ,      @i_extension         , 
   @i_fax              ,     @i_cargo             ,      @i_fecha_contratacion, 
   @i_clave_moneda     ,     @i_salario           ,      @i_base_salarial     , 
   @i_num_empleado     ,     @i_fecha_ult_dia     ,      @i_codigo_pais       ,
   @i_fecha_reporto_empl,    @i_fecha_verificacion,      @i_modo_verificacion )   

   if @@error <> 0 begin
      select @w_error_number = 357043        
      goto ERROR
   end

end

--if @i_operacion = 'U' 
--begin
--      
--      update dbo.cr_empleo_buro
--     set eb_nombre_empresa     = @i_nombre_empresa,
--         eb_direccion_uno      = @i_direccion_uno,
--         eb_direccion_dos      = @i_direccion_dos,
--          eb_colonia            = @i_colonia,
--         eb_delegacion         = @i_delegacion,
--         eb_ciudad             = @i_ciudad,
--         eb_estado             = @i_estado,
--         eb_codigo_postal      = @i_codigo_postal,
--         eb_numero_telefono    = @i_numero_telefono,
--         eb_extension          = @i_extension,
--         eb_fax                = @i_fax,
--         eb_cargo              = @i_cargo,
--         eb_fecha_contratacion = @i_fecha_contratacion,
--         eb_clave_moneda       = @i_clave_moneda,
--         eb_salario            = @i_salario,
--          eb_base_salarial      = @i_base_salarial,
--         eb_num_empleado       = @i_num_empleado,
--         eb_fecha_ult_dia      = @i_fecha_ult_dia,
--         eb_codigo_pais        = @i_codigo_pais,
--         eb_fecha_rept_empleo  = @i_fecha_reporto_empl,
--         eb_fecha_verificacion = @i_fecha_verificacion,
--         eb_modo_verificiacion = @i_modo_verificacion
--     where eb_fecha     = @i_fecha
--    and   eb_cliente   =  @i_ente
--
--     if @@error <> 0 
--    begin
--          set @w_error_number = 708152        
--          goto ERROR
--      end
--      
--end   
--   
--   
--   if @i_operacion = 'D' 
--   begin
--	     delete 
--	     from cr_empleo_buro 
--	     where  eb_cliente = @i_ente
--   end
--   

return 0

ERROR:
EXEC cobis..sp_cerror
     @t_from  = @w_sp_name,
     @i_num   = @w_error_number

 RETURN 1


go
