/************************************************************************/
/*      Archivo:                custotmp.sp                             */
/*      Stored procedure:       sp_custodia_tmp                        */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Walter Solis                            */
/*      Fecha de documentacion: 14/07/01                                */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de INSERT y DELETE a    */
/*      la tabla temporal de 'pf_custodia_tmp'.                         */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_custodia_tmp')
   drop proc sp_custodia_tmp
go

create proc sp_custodia_tmp (
      @s_ssn                  int             = NULL,
      @s_user                 login           = NULL,
      @s_sesn                 int             = NULL,
      @s_term                 varchar(30)     = NULL,
      @s_date                 datetime        = NULL,
      @s_srv                  varchar(30)     = NULL,
      @s_lsrv                 varchar(30)     = NULL,
      @s_ofi                  smallint        = NULL,
      @s_rol                  smallint        = NULL,
      @t_debug                char(1)         = 'N',
      @t_file                 varchar(10)     = NULL,
      @t_from                 varchar(32)     = NULL,
      @t_trn                  smallint        = NULL,
      @i_operacion            char(1),
      @i_cuenta               cuenta,        
      @i_cupon                tinyint         = NULL)
with encryption
as
declare
      @w_sp_name              varchar(32),
      @w_operacionpf	      int

select @w_sp_name = 'sp_custodia_tmp'


/**  VERIFICAR CODIGO DE TRANSACCION **/
if  @t_trn <> 14152
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

If @i_operacion = 'I'
begin
   begin tran

      insert pf_custodia_tmp
      (st_usuario, st_sesion, st_operacion, st_cupon, st_procesado)
      values (@s_user, @s_sesn, @w_operacionpf,@i_cupon,'N')
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 143050
         return 1
      end

      commit tran
   end


/**  ELIMINACION DEL TOTAL DE REGISTROS TEMPORALES **/
If @i_operacion = 'D'
begin
   begin tran
      delete from pf_custodia_tmp
      where st_usuario   = @s_user
      and   st_sesion    = @s_sesn
      and   st_operacion = @w_operacionpf

      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 147043
         return 1
      end

   commit tran
end

return 0
go
      
