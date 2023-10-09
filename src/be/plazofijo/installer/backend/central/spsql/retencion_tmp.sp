/************************************************************************/
/*     Archivo:                retentmp.sp                              */
/*     Stored procedure:       sp_retencion_tmp                         */
/*     Base de datos:          cob_pfijo                                */
/*     Producto:               Plazo Fijo                               */
/*     Disenado por:           Gabriela Estupinan                       */
/*     Fecha de documentacion: 03-Jul-2001                              */
/************************************************************************/
/*                             IMPORTANTE                               */
/*     Este programa es parte de los paquetes bancarios propiedad de    */
/*     'MACOSA', representantes exclusivos para el Ecuador de la        */
/*     'NCR CORPORATION'.                                               */
/*     Su uso no autorizado queda expresamente prohibido asi como       */
/*     cualquier alteracion o agregado hecho por alguno de sus          */
/*     usuarios sin el debido consentimiento por escrito de la          */
/*     Presidencia Ejecutiva de MACOSA o su representante.              */
/*                             PROPOSITO                                */
/*     Este programa procesa las transacciones de INSERT y DELETE a     */
/*     la tabla temporal de movimientos monetarios 'pf_mov_monet_tmp'.  */
/*                                                                      */
/*                             MODIFICACIONES                           */
/*     FECHA       AUTOR                RAZON                           */
/*     03-Jul-01   Gabriela Estupinan   Emision Inicial                 */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_retencion_tmp')
   drop proc sp_retencion_tmp
go
   
create proc sp_retencion_tmp (
   @s_ssn           int         = NULL,
   @s_user          login       = NULL,
   @s_sesn          int         = NULL,
   @s_term          varchar(30) = NULL,
   @s_date          datetime    = NULL,
   @s_srv           varchar(30) = NULL,
   @s_lsrv          varchar(30) = NULL,
   @s_ofi           smallint    = NULL,
   @s_rol           smallint    = NULL,
   @t_debug         char(1)     = 'N',
   @t_file          varchar(10) = NULL,
   @t_from          varchar(32) = NULL,
   @t_trn           smallint    = NULL,
   @i_operacion     char(1),
   @i_cuenta        cuenta,        
   @i_valor         money,
   @i_motivo        catalogo    = NULL,
   @i_cupon         tinyint,
   @i_secuencial    tinyint     = NULL,
   @i_funcionario   login       = NULL --KTA GB-GAPDP00130
)
with encryption
as
declare @w_sp_name       varchar(32),
        @w_operacionpf   int

select @w_sp_name = 'sp_retencion_tmp'

----------------------------------------------
-- VERIFICAR CODIGO DE TRANSACCION PARA INSERT
----------------------------------------------
if  @i_operacion <> 'I' or  @t_trn <> 14150 
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141040
   return 1
end

select @w_operacionpf = op_operacion
  from pf_operacion
 where op_num_banco = @i_cuenta

if @@rowcount = 0
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141051
   return 1
end

if @i_operacion = 'I'
begin
   begin tran
      insert pf_retencion_tmp (et_usuario,     et_sesion, et_operacion,   et_secuencial,
                               et_valor,       et_motivo, et_cupon)
                       values (@i_funcionario, @s_sesn,   @w_operacionpf, @i_secuencial,
                               @i_valor,       @i_motivo, @i_cupon)
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 143022
         return 1
      end
   commit tran
end
---------------------------------------------------
-- ELIMINACION DE MOVIMIENTOS MONETARIOS TEMPORALES
---------------------------------------------------
if @i_operacion = 'D'
begin
   begin tran
      delete from pf_retencion_tmp
       where et_usuario   = @s_user
         and et_sesion    = @s_sesn
         and et_operacion = @w_operacionpf

      if @@error <> 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 147022
         return 1
      end
   commit tran
end 
return 0
go
      
