/************************************************************************/
/*      Archivo:                validamy.sp                             */
/*      Stored procedure:       sp_valida_ejecmay                       */
/*      Base de datos:          cob_conta                               */
/*      Producto:               Contabilidad                            */
/*      Disenado por:           Mauricio Rincon Romero                  */
/*      Fecha de escritura:     10-Agosto-2006                          */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa registra ingresos a Autorizacion,Desautorizacion, */
/*      Rev Comprobantes y marca el parametro de ejecucion Mayorizacion */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR               RAZON                       */
/*      10/Ago/2006     Mauricio Rincon R.  Emision Inicial             */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_valida_ejecmay')
   drop proc sp_valida_ejecmay
go
create proc sp_valida_ejecmay   (
    @s_ssn        int         = null,
    @s_date        datetime    = null,
    @s_user        login       = 'usuario',
    @s_term        descripcion = 'terminal',
    @s_corr        char(1)     = null,
    @s_ssn_corr    int         = null,
    @s_ofi         smallint    = 255,
    @t_rty         char(1)     = null,
    @t_trn         smallint,
    @t_debug       char(1)     = 'N',
    @t_file        varchar(14) = null,
    @t_from        varchar(30) = null,
    @i_empresa     tinyint,
    @i_operacion   char(1),
    @i_proceso     char(1)
)
as 
declare 
        @w_sp_name      varchar(30),
        @w_error        int,
        @w_ejecucion    char(1),
        @w_proceso_may  int,
        @w_usuario_lin  tinyint

select @w_sp_name = 'sp_valida_ejecmay'

/***  Validacion Tipo de Transaccion ***/
if (@t_trn <> 6059 and @i_operacion  <> 'A') or
   (@t_trn <> 6059 and @i_operacion  <> 'D') or
   (@t_trn <> 6059 and @i_operacion  <> 'R') or
   (@t_trn <> 6059 and @i_operacion  <> 'X') or
   (@t_trn <> 6059 and @i_operacion  <> 'V') or
   (@t_trn <> 6059 and @i_operacion  <> 'E') or
   (@t_trn <> 6059 and @i_operacion  <> 'N')
begin
   /* 'Tipo de transaccion no corresponde' */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 601077
   return 1
end

if @t_debug = 'S'
begin
   exec cobis..sp_begin_debug @t_file = @t_file
   select '/** Store Procedure **/ ' = @w_sp_name,
          t_file      = @t_file,
          t_from      = @t_from,
          i_empresa   = @i_empresa,
          i_operacion = @i_operacion,
          i_proceso   = @i_proceso
   exec cobis..sp_end_debug
end

/* Ingreso marca de control Autorizacion,Desautorizacion y Rev Comprobantes */
if @i_operacion = 'A' or @i_operacion = 'D' or @i_operacion = 'R'
begin
   insert cob_conta..cb_usu_capt_comp values (@s_ofi,@s_term,@s_user,@i_proceso,'E',getdate())
   select @w_error = @@error
   if @w_error <> 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 601016
      return 1
   end
end

/* Elimina marca de control Autorizacion,Desautorizacion y Rev Comprobantes */
if @i_operacion = 'X'
begin
   if @i_proceso <> 'M'
   begin
      delete cob_conta..cb_usu_capt_comp where cc_oficina = @s_ofi and cc_terminal = @s_term
      select @w_error = @@error
      if @w_error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 601022
         return 1
      end
   end
   else
   begin
      update cobis..cl_parametro set pa_char = null where pa_producto = 'CON' and pa_nemonico = 'NBMC'
      select @w_error = @@error
      if @w_error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 601020
         return 1
      end
      delete cob_conta..cb_usu_capt_comp where cc_oficina = @s_ofi and cc_terminal = @s_term and cc_proceso = @i_proceso
      select @w_error = @@error
      if @w_error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 601044
         return 1
      end
   end
end

/* Validacion control de ejecuciones proceso - Mayorizacion de comprobantes */
if @i_operacion = 'V'
begin
   select @w_ejecucion = pa_char from cobis..cl_parametro where pa_producto = 'CON' and pa_nemonico = 'NBMC'
   if @w_ejecucion <> null
   begin
      if @i_proceso = 'A'
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 601010
         return 1
      end
      if @i_proceso = 'D'
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 601011
         return 1
      end
      if @i_proceso = 'R'
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 601012
         return 1
      end
   end
end

/* Validacion e ingreso control Ejecucion Proceso Mayorizacion Comprobantes */
if @i_operacion = 'E'
begin
   select @w_usuario_lin = 0
   select @w_usuario_lin = count(0)
     from cob_conta..cb_usu_capt_comp
    where cc_proceso <> 'M'
   if @w_usuario_lin > 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 601013
      return 1
   end
   else
   begin
      begin tran
      insert cob_conta..cb_usu_capt_comp values (@s_ofi,@s_term,@s_user,@i_proceso,'E',getdate())
      select @w_error = @@error
      if @w_error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 601014
         rollback tran
         return 1
      end
      update cobis..cl_parametro set pa_char = 'E' where pa_producto = 'CON' and pa_nemonico = 'NBMC'
      select @w_error = @@error
      if @w_error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 601015
         rollback tran
         return 1
      end
      commit tran
   end
end

/* Limpia marca Ejecucion Proceso Mayorizacion Comprobante y tabla usuarios */
if @i_operacion = 'N'
begin
   if @i_proceso = 'A'
   begin
      delete cob_conta..cb_usu_capt_comp
      update cobis..cl_parametro set pa_char = null where pa_producto = 'CON' and pa_nemonico = 'NBMC'
   end
   else
   begin
      update cobis..cl_parametro set pa_char = null where pa_producto = 'CON' and pa_nemonico = 'NBMC'
   end
end

return 0
go

