/************************************************************************/
/*      Archivo:                compensa.sp                             */
/*      Stored procedure:       sp_compensa                             */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Gabriela Estupinan                      */
/*      Fecha de documentacion: 25/Sep/01                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este script realiza el calculo de los valores a compensar entre */
/*      banco local y offshore.                                         */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*	25-Sep-01  Gabriela Estupinan Emision Inicial                   */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_compensa' and type = 'P')
	drop proc sp_compensa
go

create proc sp_compensa (
@s_ssn                  int             = NULL,
@s_user                 login           = 'sa',
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  int             = 14975,
@i_empresa              tinyint         = 1,
@i_fecha_proceso        datetime)
with encryption
as
declare
@w_sp_name              descripcion,
@w_error                int,
@w_tot_debitos          money,
@w_tot_creditos         money,
@w_tr_causa             varchar(3) ,
@w_tran                 int,
@w_cuenta               cuenta,
@w_valor_aplicar        money,
@w_moneda_base          tinyint,
@w_afectacion           char(1),
@w_return               int,
@w_ofi                  int

select @w_sp_name = 'sp_compensa'

select @w_moneda_base = em_moneda_base
from cob_conta..cb_empresa
where em_empresa = @i_empresa
if @@rowcount = 0
begin
  select @w_error = 601018
  goto ERROR 
end     

select @w_cuenta = pa_char
from cobis..cl_parametro
where pa_producto = 'CTE'
  and pa_nemonico = 'CCL'
if @@rowcount = 0
begin
  select @w_error = 141140
  goto ERROR
end

declare cursor_oficina cursor
for select
of_oficina
from cobis..cl_oficina

open cursor_oficina 
fetch cursor_oficina into @w_ofi

begin tran
   while @@fetch_status <> -1
   begin
     if @@fetch_status = -2
     begin
       close cursor_operacion
       deallocate cursor_operacion
       raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
       return 0
     end    
   
      select @w_tot_debitos = sum(mm_valor)
      from pf_mov_monet, pf_fpago
      where
      --mm_tran in (14901, 14919, 14965)
        mm_oficina = @w_ofi
        and mm_fecha_aplicacion = @i_fecha_proceso
        and mm_estado = 'A'
        and mm_tran <> 14904
        and mm_tipo = 'B'
        and mm_producto = fp_mnemonico
        and fp_producto = 14
        and fp_estado = 'A'
        and fp_compensa = 'S'
   
      select @w_tot_creditos = sum(mm_valor)
      from pf_mov_monet, pf_emision_cheque
      where
      --mm__tran in (14903, 14966, 14919, 14928)
        mm_oficina = @w_ofi
        and (ec_fecha_caja = @i_fecha_proceso or 
         (ec_fecha_emision = @i_fecha_proceso and 
         (ec_fpago = 'GINT' or ec_fpago = 'COMP')))
        and mm_estado = 'A'
        and mm_tipo = 'C'
        and mm_operacion = ec_operacion
        and mm_tran not in (14904, 14905)
        and mm_secuencial = ec_secuencial
        and mm_secuencia = ec_secuencia
        and mm_sub_secuencia = ec_sub_secuencia
        and mm_tran = ec_tran
        and (ec_caja = 'S' or ec_fpago = 'COMP' or ec_fpago = 'GINT')
        and ec_fpago in (select fp_mnemonico 
                      from pf_fpago 
                      where fp_estado = 'A' 
                        and fp_producto = 14
		      and isnull(fp_compensa, 'N') = 'S')
   
     /*** Se suman los intereses de los cupones pagados ***/
     select @w_tot_creditos = isnull(@w_tot_creditos, 0) + isnull(sum(mm_valor),0)
     from pf_mov_monet, pf_emision_cheque
     where 
        mm_oficina = @w_ofi
       and mm_tran = 14943
       and (ec_fecha_caja = @i_fecha_proceso or 
         (ec_fecha_emision = @i_fecha_proceso and 
         (ec_fpago = 'GINT' or ec_fpago = 'COMP')))
       and mm_estado = 'A'
       and mm_tipo = 'C'
       and mm_secuencia_emis_che = ec_secuencia
       and mm_operacion = ec_operacion
       and mm_fecha_aplicacion = ec_fecha_emision
       and (ec_caja = 'S' or ec_fpago = 'COMP' or ec_fpago = 'GINT')
       and ec_fpago in (select fp_mnemonico 
                      from pf_fpago 
                      where fp_estado = 'A' 
                        and fp_producto = 14
                        and isnull(fp_compensa, 'N') = 'S')
       and 14905 = (select mm_tran from pf_mov_monet
                      where mm_operacion = pf_emision_cheque.ec_operacion
                        and mm_secuencial = pf_emision_cheque.ec_secuencial
                        and mm_secuencia = pf_emision_cheque.ec_secuencia
                        and mm_sub_secuencia = pf_emision_cheque.ec_sub_secuencia
                        and mm_tran = pf_emision_cheque.ec_tran
                        and mm_tran = 14905)

      /*** Suma los pagos en efectivo directo en caja ***/   
      select @w_tot_creditos = isnull(@w_tot_creditos, 0) + isnull(sum(mm_valor),0)
      from pf_mov_monet
      where mm_estado = 'A'  
        and mm_tipo = 'C'
        and mm_tran = 14903
        and mm_tran <> 14904
        and mm_oficina = @w_ofi
        and mm_fecha_aplicacion = @i_fecha_proceso
        and 0 = (select isnull(count(*),0) 
                 from pf_emision_cheque 
                 where ec_operacion = pf_mov_monet.mm_operacion 
                   and ec_sub_secuencia = pf_mov_monet.mm_sub_secuencia
                   and ec_secuencial = pf_mov_monet.mm_secuencial 
                   and ec_secuencia = pf_mov_monet.mm_secuencia 
                   and ec_tran = pf_mov_monet.mm_tran)
        and mm_producto in (select fp_mnemonico 
                            from pf_fpago 
                            where fp_estado = 'A'
                              and isnull(fp_compensa, 'N') = 'S')

      if isnull(@w_tot_creditos, 0) > isnull(@w_tot_debitos,0)
         select @w_afectacion = 'C',
                @w_tran = 48, 
                @w_tr_causa = '16'
      else
         select @w_afectacion = 'D',
                @w_tran = 50, 
                @w_tr_causa = '47'   
   
      select @w_valor_aplicar = abs(isnull(@w_tot_creditos,0)
                                - isnull(@w_tot_debitos,0))
      if @w_valor_aplicar <> 0
      begin
  
         exec @s_ssn = sp_gen_sec @i_inicio_fin = 'F'      
/***** Comentado no existe en global
         exec @w_return=cob_cuentas..sp_ccndc_automatica_batch
           @s_srv = @s_srv, @s_ofi = @w_ofi, @s_ssn = @s_ssn, @s_user = @s_user,
           @s_date = @s_date,
           @t_trn = @w_tran, @i_cta = @w_cuenta, @i_val = @w_valor_aplicar,
           @i_cau = @w_tr_causa, @i_mon = @w_moneda_base,
           @i_fecha = @s_date, @i_concepto = 'COMPENSACION DESDE PLAZO FIJO'
         if @w_return <> 0
         begin
            select @w_error = 149013
            goto ERROR
         end
Fin comentado no existe en global *****/
   
      end
   
      fetch cursor_oficina into
      @w_ofi

   end  -- 
commit tran     
close cursor_oficina
deallocate cursor_oficina      

return 0


ERROR:
rollback tran
exec sp_errorlog @i_fecha = @s_date,
   @i_error = @w_error, @i_usuario=@s_user,
   @i_tran=@t_trn, @i_cuenta=@w_cuenta      

close cursor_oficina
deallocate cursor_oficina      
return @w_error

go
