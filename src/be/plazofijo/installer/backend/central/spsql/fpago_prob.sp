/************************************************************************/
/*      Archivo:                problem.sp                              */
/*      Stored procedure:       sp_fpago_prob                           */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Gustavo Calderon                        */
/*      Fecha de documentacion: 14/Ago/95                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa el mantenimiento de la tabla              */
/*      con los problemas en formas de pago                             */
/*      Insercion de pf_mov_monet_prob                                  */
/*      Actualizacion de pf_mov_monet_prob                              */
/*      Eliminacion de pf_mov_monet_prob                                */
/*      Help a la tabla pf_mov_monet_prob                               */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      20-Sep-95  Erika Sanchez      creacion                          */
/*                                                                      */
/*      05/Dic/2016 A.Zuluaga         Desacople                         */
/************************************************************************/
use cob_pfijo
go

if exists (select * from sysobjects where name = 'sp_fpago_prob')
   drop proc sp_fpago_prob
go

create proc sp_fpago_prob (
      @s_ssn                  int = NULL,
      @s_user                 login = NULL,
      @s_term                 varchar(30) = NULL,
      @s_date                 datetime = NULL,
      @s_srv                  varchar(30) = NULL,
      @s_lsrv                 varchar(30) = NULL,
      @s_ofi                  smallint = NULL,
      @s_rol                  smallint = NULL,
      @t_debug                char(1) = 'N',
      @t_file                 varchar(10) = NULL,
      @t_from                 varchar(32) = NULL,
      @t_trn                  smallint = NULL,
      @i_operacion            char(1),
      @i_estado                 char(1) = NULL,
      @i_num_banco            cuenta,
      @i_tipo                 char(1) = NULL,
      @i_secuencia            int  = NULL,
      @i_subsecuencia         tinyint = NULL,
      @i_motivo               catalogo  = "NNN",
      @i_banco                  catalogo = NULL,
      @i_cuenta               cuenta = NULL,
      @i_cheque                  int = NULL,
      @i_valor                money = NULL,
      @i_en_linea             char(1)        = 'S'
)
as
declare
    @w_sp_name              varchar(32),
      @w_return                  int,
      @w_operacion            char(1),
      @w_operacionpf          int,
      @w_tipo                 char(1),
      @w_secuencia            int ,
      @w_subsecuencia         tinyint ,
      @w_motivo               catalogo ,
      @w_banco                  catalogo ,
      @w_cuenta               cuenta,
      @w_cheque                  int ,
      @w_estado                  char(1) ,
      @w_valor                catalogo,
      @v_operacion            char(1),
      @v_iperacionpf          int,
      @v_tipo                 char(1),
      @v_secuencia            int ,
      @v_subsecuencia         tinyint ,
      @v_motivo               catalogo ,
      @v_banco                  catalogo ,
      @v_cuenta               cuenta,
      @v_cheque                  int ,
      @v_estado                  char(1) ,
      @v_valor                money

select @w_sp_name = 'sp_fpago_prob'


if   (@t_trn != 14139 or @i_operacion != 'I') and
     (@t_trn != 14339 or @i_operacion != 'D') and
     (@t_trn != 14642 or @i_operacion != 'H')

begin
   exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141112
          return 141112
end

/** SECCION DE LECTURA DE PF_OPERACION **/
select @w_operacionpf   = op_operacion
from pf_operacion
where op_num_banco = @i_num_banco
  and (op_estado = 'XACT'
       or op_estado = 'ACT')

if @@rowcount = 0
begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 141051
   return 141051
end

/** Insert **/
If @i_operacion = 'I'
begin
   if @i_en_linea = 'S' begin tran

--print '%1!',@w_operacionpf
--print '%1!',@i_secuencia
--print '%1!',@i_subsecuencia
--print '%1!',@i_banco
--print '%1!',@i_cuenta
--print '%1!',@i_cheque
   set rowcount 1
       update pf_emision_cheque
       set ec_estado = 'P'
          where ec_operacion = @w_operacionpf
           and ec_secuencia = @i_secuencia
           and ec_sub_secuencia = @i_subsecuencia
           and ec_banco = @i_banco
           and ec_cuenta = @i_cuenta
           and ec_numero = @i_cheque
     if @@rowcount = 0
   begin
    exec cobis..sp_cerror
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_num          = 141095
    return 141095
   end
--print '%1!',@w_operacionpf
--print '%1!',@i_secuencia
--print '%1!',@i_subsecuencia
--print '%1!',@i_banco
--print '%1!',@i_cuenta
--print '%1!',@i_cheque
--print '%1!',@i_valor
--print '%1!',@i_motivo
--print '%1!',@s_date
--print '%1!',@s_date
set rowcount 0
     insert into pf_mov_monet_prob ( pr_operacion, pr_secuencia ,
      pr_subsecuencia, pr_motivo , pr_banco, pr_cuenta,
      pr_cheque, pr_valor, pr_estado, pr_fecha_crea, pr_fecha_mod)

          values    ( @w_operacionpf, @i_secuencia ,
         @i_subsecuencia, @i_motivo , @i_banco, @i_cuenta,
         @i_cheque, @i_valor,'I',@s_date, @s_date)

      /* si no se puede insertar, error */
      if @@error != 0
      begin
    exec cobis..sp_cerror
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_num          = 143042
    return 143042
      end

      /* Transaccion de servicio  */

      insert into ts_mov_monet_prob (secuencial, tipo_transaccion, clase, fecha,
               usuario, terminal, srv, lsrv, operacion,
                secuencia , subsecuencia, motivo , banco, cuenta,
      cheque, valor, estado, fecha_crea, fecha_mod)
      values (@s_ssn, @t_trn, 'N', @s_date,
         @s_user, @s_term, @s_srv, @s_lsrv,
         @w_operacionpf, @i_secuencia , @i_subsecuencia, @i_motivo,
         @i_banco, @i_cuenta, @i_cheque, @i_valor,'I',@s_date, @s_date)

      /* si no se puede insertar transaccion de servicio, error */
      if @@error != 0
      begin
     exec cobis..sp_cerror
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_num          = 143005
      /*'Error en insercion de transaccion de servicio'*/
     return 143005
      end
  if @i_en_linea = 'S' commit tran

return 0

end

/** Delete **/
if @i_operacion = 'D'
begin
  if @i_en_linea = 'S' begin tran
   set rowcount 1
     update pf_emision_cheque
     set ec_estado = 'A'
      where ec_operacion = @w_operacionpf
           and ec_secuencia = @i_secuencia
           and ec_sub_secuencia = @i_subsecuencia
           and ec_banco = @i_banco
           and ec_cuenta = @i_cuenta
           and ec_numero = @i_cheque
     if @@rowcount = 0
   begin
    exec cobis..sp_cerror
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_num          = 141095
    return 141095
   end
    delete pf_mov_monet_prob
    where pr_operacion = @w_operacionpf
      and pr_secuencia = @i_secuencia
      and pr_subsecuencia = @i_subsecuencia
      and pr_banco = @i_banco
      and pr_cuenta = @i_cuenta
      and pr_cheque = @i_cheque
      and pr_estado = 'I'
    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
   @t_debug        = @t_debug,
   @t_file         = @t_file,
   @t_from         = @w_sp_name,
   @i_num          = 147039
      return 147039
    end
 if @i_en_linea = 'S' commit tran
  return 0

end /* end de if operacion = D */

/** Help **/

if @i_operacion = 'H'
begin
   set rowcount 20
   
   create table #re_banco (
   ba_banco      varchar(24)      null
   )
   
   select @i_banco = ec_banco
   from pf_mov_monet a, pf_fpago b, cobis..cl_moneda c,
        pf_emision_cheque  
   where ec_operacion       = @w_operacionpf
     and   ec_operacion     = mm_operacion
     and   ec_secuencia     = 0
     and   ec_sub_secuencia = mm_sub_secuencia
     and   ec_secuencia     = mm_secuencia
     and   ec_estado        = @i_estado
     and   mm_producto      = fp_mnemonico
     and   mm_moneda        = mo_moneda
     and   fp_estado        = 'A' 
   
   exec @w_return = cob_interfase..sp_iremesas
        @i_operacion  = 'D',
        @i_banco      = @i_banco
   
   if @w_return <> 0
      return @w_return

   select 
   fp_descripcion,
   ba_descripcion,
   ec_cuenta,
   ec_numero,
   ec_valor,
   mo_descripcion,
   ec_banco,
   ec_secuencia,
   ec_sub_secuencia
   from pf_mov_monet a, pf_fpago b, cobis..cl_moneda c,
        pf_emision_cheque d, #re_banco
   where ec_operacion     = @w_operacionpf
   and   ec_operacion     = mm_operacion
   and   ec_secuencia     = 0
   and   ec_sub_secuencia = mm_sub_secuencia
   and   ec_secuencia     = mm_secuencia
   and   ec_estado        = @i_estado
   and   mm_producto      = fp_mnemonico
   and   mm_moneda        = mo_moneda
   and   ba_banco         = ec_banco
   and   fp_estado        = 'A'
   
   set rowcount 0
end
go

