/***********************************************************************/
/*     Archivo:                         cr_score_buro.sp               */
/*     Stored procedure:                sp_score_buro                  */
/*     Base de Datos:                   cob_credito                    */
/*     Producto:                        Credito                        */
/*     Disenado por:                    D. Cumbal                      */
/*     Fecha de Documentacion:          12/Mar/2018                    */
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
/*  12/Mar/2018      D. Cumbal            Emision Inicial - REQ 93182  */
/*  05-07-2019       srojas            Reestructuración Buro histórico */
/***********************************************************************/
use cob_credito
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if object_id ('sp_score_buro') is not null
begin
   drop proc sp_score_buro
end
go

   create proc sp_score_buro (
   @s_ssn           int          = null,
   @s_user          login        = null,
   @s_sesn          int          = null,
   @s_term          descripcion  = null,
   @s_date          datetime     = null,
   @s_srv           varchar(30)  = null,
   @s_lsrv          varchar(30)  = null,
   @s_rol           smallint     = null,
   @s_ofi           smallint     = null,
   @s_org_err       char(1)      = null,
   @s_error         int          = null,
   @s_sev           tinyint      = null,
   @s_msg           descripcion  = null,
   @s_org           char(1)      = null,
   @t_rty           char(1)      = null,
   @t_trn           smallint     = null,
   @t_debug         char(1)      = 'N',
   @t_file          varchar(14)  = null,
   @t_from          varchar(30)  = null,
   @i_operacion     char(1)      = null,     
   @i_ente          int          = null,
   @i_fecha         datetime     = null,
   @i_formato_fecha int          = 101 ,
   @i_nombre_score  varchar(30)  = null,
   @i_codigo_score  varchar(3)   = null,
   @i_valor_score   varchar(4)   = null,
   @i_codigo_razon  varchar(3)   = null,
   @i_codigo_error  varchar(2)   = null
     )
as
declare
@w_error_number    int,
@w_sp_name         varchar(100),
@w_secuencial      int, 
@w_msg             varchar(255)
   
select @w_sp_name = 'sp_score_buro'

if @i_fecha is null
   select @i_fecha = fp_fecha
   from cobis..ba_fecha_proceso

if @i_operacion='Q' begin

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
   @i_ente ,
   sb_nombre,
   sb_codigo,
   sb_valor ,
   sb_codigo_razon,
   sb_codigo_error
   from cr_score_buro
   where sb_ib_secuencial = @w_secuencial


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

   insert into dbo.cr_score_buro 
   (sb_ib_secuencial,   sb_nombre , 
   sb_codigo        ,   sb_valor       ,   sb_codigo_razon, 
   sb_codigo_error)                       
   values 
   (@w_secuencial ,   @i_nombre_score, 
   @i_codigo_score,   @i_valor_score,   @i_codigo_razon, 
   @i_codigo_error)
    
   if @@error <> 0 
   begin
        set @w_error_number = 357043        
        goto ERROR
   end

   end
   
--if @i_operacion = 'U' 
--begin
--   update dbo.cr_score_buro set
--   sb_nombre       = @i_nombre_score,
--   sb_codigo       = @i_codigo_score,
--   sb_valor        = @i_valor_score,
--   sb_codigo_razon = @i_codigo_razon,
--   sb_codigo_error = @i_codigo_error
--   where sb_cliente      = @i_ente
--   and   sb_fecha        = @i_fecha
--     
--   if @@error <> 0 begin
--      select @w_error_number = 708152        
--      goto ERROR
--   end
--      
--end      
--   
--if @i_operacion = 'D' 
--begin
--   delete 
--   from cr_score_buro 
--   where  sb_cliente = @i_ente
--end

return 0

ERROR:
EXEC cobis..sp_cerror
@t_from  = @w_sp_name,
@i_num   = @w_error_number

RETURN @w_error_number


go
