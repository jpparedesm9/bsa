/************************************************************************/
/*      Archivo:                tracomp.sp                              */
/*      Stored procedure:       sp_traslado_compensacion                */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Memito Saborio                          */
/*      Fecha de documentacion: 24/Ago/2001                             */
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
/*      Este procedimiento almacenado realiza la actualizacion de datos */
/*      de los movimientos a la tabla de compensacion.                  */
/*                                                                      */
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

if exists (select 1 from sysobjects where name = 'sp_traslado_compensacion')
   drop proc sp_traslado_compensacion 
go

create proc sp_traslado_compensacion (
@s_ssn                  int         = NULL,
@s_user                 login       = NULL,
@s_sesn                 int         = NULL,
@s_term                 varchar(30) = NULL,
@s_date                 datetime    = NULL,
@s_srv                  varchar(30) = NULL,
@s_lsrv                 varchar(30) = NULL,
@s_ofi                  smallint    = NULL,
@s_rol                  smallint    = NULL,
@t_debug                char(1)     = 'N',
@t_file                 varchar(10) = NULL,
@t_from                 varchar(32) = NULL,
@t_trn                  smallint,
@i_fecha                datetime,
@i_borrar               char(1)     = 'S',
@i_en_linea             char(1)     = 'N'
)
with encryption
as
declare         
@w_sp_name              varchar(32),
@w_secuencial           int

    
select @w_sp_name = 'sp_traslado_compensacion',
       @w_secuencial = @s_ssn

if @t_trn <> 14154 begin
  exec sp_errorlog @i_fecha = @s_date,
                 @i_error = 141112, @i_usuario=@s_user,
                 @i_tran=@t_trn,@i_cuenta=' '

  /*  'Error en codigo de transaccion' */
  return 1
end

if @s_ssn IS   NULL
begin
  exec @w_secuencial=sp_gen_sec 
  select @s_ssn = @w_secuencial
end 

begin tran

/* ELIMINACION DE TABLAS DE COMPENSACION */
if @i_borrar = 'S' begin
   delete pf_compensa_mov
	 if @@error > 0 begin
     exec sp_errorlog @i_fecha = @s_date,
                 @i_error = 149088, @i_usuario=@s_user,
                 @i_tran=@t_trn,@i_cuenta=' '

     /*  'Error en codigo de transaccion' */
     return 1
   end
   
   delete pf_compensa_ope
   if @@error > 0  begin
     exec sp_errorlog @i_fecha = @s_date,
                 @i_error = 149089, @i_usuario=@s_user,
                 @i_tran=@t_trn,@i_cuenta=' '

     /*  'Error en codigo de transaccion' */
     return 1
   end 
end

/**********************************************
*** COMIENZA LA TRANSACCION CON EL TRASLA-  ***
*** DO DE DATOS A LA TABLA DE COMPENSACION  ***
**********************************************/

/*** Se insertan los pagos de certificados en efectivo en caja ***/
insert pf_compensa_mov (
	cm_operacion,	cm_tran, cm_secuencia, cm_secuencial, cm_sub_secuencia,
	cm_fecha_aplicacion, cm_producto, cm_cuenta, cm_valor, cm_estado,
	cm_tipo, cm_beneficiario,  cm_impuesto, cm_moneda, cm_valor_ext,
	cm_fecha_crea, cm_fecha_mod, cm_oficina, cm_impuesto_capital_me,
  cm_fecha_real,  cm_secuencia_emis_che, cm_user, cm_tipo_cliente,
	cm_autorizado, cm_cotizacion, cm_tipo_cotiza
	)
select mm_operacion, mm_tran, mm_secuencia, mm_secuencial, mm_sub_secuencia,
	mm_fecha_aplicacion, mm_producto, mm_cuenta, 0, mm_estado,
	mm_tipo, mm_beneficiario, mm_impuesto, mm_moneda, mm_valor,
	mm_fecha_crea, mm_fecha_mod, mm_oficina, mm_impuesto_capital_me,
  mm_fecha_real, mm_secuencia_emis_che, mm_user, mm_tipo_cliente,
	mm_autorizado, mm_cotizacion, mm_tipo_cotiza
from pf_mov_monet
where mm_estado = 'A'  
  and mm_tipo = 'C'
  and mm_tran = 14903
  and mm_tran <> 14905
  and mm_fecha_aplicacion = @i_fecha
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
if @@error > 0  begin
  exec sp_errorlog @i_fecha = @s_date,
                 @i_error = 149090, @i_usuario=@s_user,
                 @i_tran=@t_trn,@i_cuenta=' '

  /*  'Error en codigo de transaccion' */
  return 1
end 

insert pf_compensa_mov (
	cm_operacion,	cm_tran, cm_secuencia, cm_secuencial, cm_sub_secuencia,
	cm_fecha_aplicacion, cm_producto, cm_cuenta, cm_valor, cm_estado,
	cm_tipo, cm_beneficiario,  cm_impuesto, cm_moneda, cm_valor_ext,
	cm_fecha_crea, cm_fecha_mod, cm_oficina, cm_impuesto_capital_me,
  cm_fecha_real,  cm_secuencia_emis_che, cm_user, cm_tipo_cliente,
	cm_autorizado, cm_cotizacion, cm_tipo_cotiza
	)
select ec_operacion, ec_tran, ec_secuencia, mm_secuencial, mm_sub_secuencia,
	mm_fecha_aplicacion, ec_fpago, mm_cuenta, 0, mm_estado,
	mm_tipo, mm_beneficiario, mm_impuesto, mm_moneda, ec_valor,
	mm_fecha_crea, mm_fecha_mod, mm_oficina, mm_impuesto_capital_me,
  mm_fecha_real, mm_secuencia_emis_che, mm_user, mm_tipo_cliente,
	mm_autorizado, mm_cotizacion, mm_tipo_cotiza
from pf_mov_monet, pf_emision_cheque
where (ec_fecha_caja = @i_fecha or (ec_fecha_emision = @i_fecha
  and (ec_fpago = 'GINT' or ec_fpago = 'COMP')))
  and mm_tran <> 14905
  and mm_estado = 'A'  
  and mm_operacion = ec_operacion
  and mm_secuencial = ec_secuencial
  and mm_secuencia = ec_secuencia
  and mm_sub_secuencia = ec_sub_secuencia
  and mm_tran = ec_tran
  and (ec_caja = 'S' or ec_fpago = 'COMP' or ec_fpago = 'GINT')
  and ec_fpago in (select fp_mnemonico 
                      from pf_fpago 
                      where fp_estado = 'A'
                        and isnull(fp_compensa, 'N') = 'S')
if @@error > 0  begin
  exec sp_errorlog @i_fecha = @s_date,
                 @i_error = 149090, @i_usuario=@s_user,
                 @i_tran=@t_trn,@i_cuenta=' '

  /*  'Error en codigo de transaccion' */
  return 1
end 

insert pf_compensa_mov (
	cm_operacion,	cm_tran, cm_secuencia, cm_secuencial, cm_sub_secuencia,
	cm_fecha_aplicacion, cm_producto, cm_cuenta, cm_valor, cm_estado,
	cm_tipo, cm_beneficiario,  cm_impuesto, cm_moneda, cm_valor_ext,
	cm_fecha_crea, cm_fecha_mod, cm_oficina, cm_impuesto_capital_me,
  cm_fecha_real,  cm_secuencia_emis_che, cm_user, cm_tipo_cliente,
	cm_autorizado, cm_cotizacion, cm_tipo_cotiza
	)

select ec_operacion, ec_tran, ec_secuencia, mm_secuencial, mm_sub_secuencia,
	mm_fecha_aplicacion, ec_fpago, mm_cuenta, 0, mm_estado,
	mm_tipo, mm_beneficiario, mm_impuesto, mm_moneda, ec_valor,
	mm_fecha_crea, mm_fecha_mod, mm_oficina, mm_impuesto_capital_me,
  mm_fecha_real, mm_secuencia_emis_che, mm_user, mm_tipo_cliente,
	mm_autorizado, mm_cotizacion, mm_tipo_cotiza
from pf_mov_monet, pf_emision_cheque
where 
  mm_tran = 14943
  and (ec_fecha_caja = @i_fecha or 
      (ec_fecha_emision = @i_fecha and 
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

if @@error > 0  begin
  exec sp_errorlog @i_fecha = @s_date,
                 @i_error = 149090, @i_usuario=@s_user,
                 @i_tran=@t_trn,@i_cuenta=' '

  /*  'Error en codigo de transaccion' */
  return 1
end 

insert pf_compensa_mov (
	cm_operacion,	cm_tran, cm_secuencia, cm_secuencial, cm_sub_secuencia,
	cm_fecha_aplicacion, cm_producto, cm_cuenta, cm_valor, cm_estado,
	cm_tipo, cm_beneficiario,  cm_impuesto, cm_moneda, cm_valor_ext,
	cm_fecha_crea, cm_fecha_mod, cm_oficina, cm_impuesto_capital_me,
  cm_fecha_real,  cm_secuencia_emis_che, cm_user, cm_tipo_cliente,
	cm_autorizado, cm_cotizacion, cm_tipo_cotiza
	)
select mm_operacion,	mm_tran, mm_secuencia, mm_secuencial, mm_sub_secuencia,
	mm_fecha_aplicacion, mm_producto, mm_cuenta, 0, mm_estado,
	mm_tipo, mm_beneficiario, mm_impuesto, mm_moneda, mm_valor,
	mm_fecha_crea, mm_fecha_mod, mm_oficina, mm_impuesto_capital_me,
  mm_fecha_real, mm_secuencia_emis_che, mm_user, mm_tipo_cliente,
	mm_autorizado, mm_cotizacion, mm_tipo_cotiza
from pf_mov_monet
where mm_fecha_aplicacion = @i_fecha
  and mm_estado = 'A'  
  and mm_tran <> 14904
  and mm_tipo = 'B'
  and mm_producto in (select fp_mnemonico 
                      from pf_fpago 
                      where fp_estado = 'A' 
                        and isnull(fp_compensa, 'N') = 'S')
if @@error > 0  begin
  exec sp_errorlog @i_fecha = @s_date,
                 @i_error = 149090, @i_usuario=@s_user,
                 @i_tran=@t_trn,@i_cuenta=' '

  /*  'Error en codigo de transaccion' */
  return 1
end 

insert pf_compensa_ope (
	co_num_banco,	co_operacion,	co_ente, co_toperacion, co_tipo_plazo)
select op_num_banco, op_operacion, op_ente, op_toperacion, op_tipo_plazo
from pf_operacion 
where op_operacion in (select distinct cm_operacion from pf_compensa_mov)

if @@error > 0  begin
  exec sp_errorlog @i_fecha = @s_date,
                 @i_error = 149091, @i_usuario=@s_user,
                 @i_tran=@t_trn,@i_cuenta=' '

  /*  'Error en codigo de transaccion' */
  return 1
end 

/**************** fin de la transaccion *****************/
commit tran  
return 0
go
