/***********************************************************************/
/*     Archivo:                         cr_consulta_buro.sp            */
/*     Stored procedure:                sp_consulta_buro               */
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
/*  13/Mar/2018      D. Cumbal            Emision Inicial - REQ 93182  */
/*  05-07-2019       srojas           Reestructuración Buro histórico  */
/***********************************************************************/
use cob_credito
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if object_id ('sp_consulta_buro') is not null
begin
   drop proc sp_consulta_buro
end
go

create proc sp_consulta_buro (
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
@i_fecha_consulta      varchar(8)    = null,
@i_identificacion_buro varchar(4)    = null,
@i_clave_otorgante     varchar(10)   = null,
@i_nombre_otorgante    varchar(16)   = null,
@i_telefono_otorgante  varchar(11)   = null,
@i_tipo_contrato       varchar(2)    = null, 
@i_clave_monetaria     varchar(2)    = null, 
@i_importe_contrato    varchar(9)    = null, 
@i_ind_tipo_responsa   char(1)       = null, 
@i_consumidor_nuevo    char(1)       = null, 
@i_resultado_final     varchar(25)   = null, 
@i_identificador_cons  varchar(25)   = null )
as
declare
@w_error_number    int,
@w_sp_name         varchar(100),
@w_secuencial      int,
@w_msg             varchar(255)

select @w_sp_name = 'sp_score_empleo'

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
   ce_fecha_consulta     , 
   ce_identificacion_buro, 
   ce_clave_otorgante    , 
   ce_nombre_otorgante   , 
   ce_telefono_otorgante , 
   ce_tipo_contrato      , 
   ce_clave_monetaria    , 
   ce_importe_contrato   , 
   ce_ind_tipo_responsa  , 
   ce_consumidor_nuevo   , 
   ce_resultado_final    , 
   ce_identificador_cons
   from cr_consultas_buro 
   where ce_ib_secuencial = @w_secuencial

  
end --@i_operacion
   
if @i_operacion='I'
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
   
   insert into dbo.cr_consultas_buro (
   ce_ib_secuencial      ,  ce_fecha_consulta   , 
   ce_identificacion_buro, ce_clave_otorgante   ,  ce_nombre_otorgante, 
   ce_telefono_otorgante , ce_tipo_contrato     , ce_clave_monetaria  , 
   ce_importe_contrato   , ce_ind_tipo_responsa , ce_consumidor_nuevo , 
   ce_resultado_final    , ce_identificador_cons)
   values 
   (@w_secuencial        , @i_fecha_consulta   , 
   @i_identificacion_buro, @i_clave_otorgante   , @i_nombre_otorgante , 
   @i_telefono_otorgante , @i_tipo_contrato     , @i_clave_monetaria  , 
   @i_importe_contrato   , @i_ind_tipo_responsa , @i_consumidor_nuevo , 
   @i_resultado_final    , @i_identificador_cons)
     
   if @@error <> 0 begin
         set @w_error_number = 357043        
         goto ERROR
   end

end
   
--if @i_operacion = 'U' 
--begin
--      
--   update dbo.cr_consultas_buro set
--   ce_fecha_consulta      = @i_fecha_consulta,
--   ce_identificacion_buro = @i_identificacion_buro,
--   ce_clave_otorgante     = @i_clave_otorgante,
--   ce_nombre_otorgante    = @i_nombre_otorgante,
--   ce_telefono_otorgante  = @i_telefono_otorgante,
--   ce_tipo_contrato       = @i_tipo_contrato,
--   ce_clave_monetaria     = @i_clave_monetaria,
--   ce_importe_contrato    = @i_importe_contrato,
--   ce_ind_tipo_responsa   = @i_ind_tipo_responsa,
--   ce_consumidor_nuevo    = @i_consumidor_nuevo,
--   ce_resultado_final     = @i_resultado_final,
--   ce_identificador_cons  = @i_identificador_cons
--   where  ce_fecha   = @i_fecha
--   and    ce_cliente = @i_ente
--     
--     
--   if @@error <> 0 begin
--     select @w_error_number = 708152        
--     goto ERROR
--   end
--      
--end   
--   
--   
--   if @i_operacion = 'D' 
--   begin
--	     delete 
--	     from cr_consultas_buro 
--	     where  ce_cliente = @i_ente
--   end
   
return 0

ERROR:
EXEC cobis..sp_cerror
     @t_from  = @w_sp_name,
     @i_num   = @w_error_number

 RETURN 1


go
