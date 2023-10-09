/************************************************************************/
/*      Archivo:                pagoint.sp                              */
/*      Stored procedure:       sp_pago_intereses                       */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miriam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
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
/*      Este script crea el procedimiento de pago de intereses          */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      25-Nov-94  Juan Lam           Creacion                          */
/*      19-Sep-95  Carolina Alvarado  XXXX                              */
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

if exists ( select 1 from sysobjects where name = 'sp_pago_intereses' and type = 'P')
   drop proc sp_pago_intereses
go

create proc sp_pago_intereses (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  int             = NULL,
@i_producto             catalogo,
@i_cuenta               cuenta,
@i_intereses            money,
@i_num_banco            cuenta,
@i_impuesto             money,
@i_tasa1                float,--xca  
@i_beneficiario         int,
@i_flag_int_anticipado  int             = NULL)/*Pago antic int poliza*/
with encryption
as
declare 
@w_sp_name              descripcion,
@w_return               int,
@w_fecha_hoy            datetime,
@w_fecha_temp           datetime,
@w_secuencial           int,
@w_secuencia            int,
@w_contor               tinyint,
@w_error                int,
@w_tran_pin             int,
@w_tran_pro             int,
@w_money                money,
@w_total_ben            money,
@w_ben_tot              float,
@w_total_porc           float,
@w_ret_pg_int           money,
@w_ret_npg_int          money,
@w_numdeci              tinyint,
@w_usadeci              char(1),
/** VARIABLES PARA PF_OPERACION **/
@w_num_banco            cuenta,
@w_operacionpf          int,
@w_toperacion           catalogo,
@w_moneda               smallint,
@w_categoria            catalogo,
@w_int_ganado           float,
@w_int_pagados          money,
@w_int_estimado         money,
@w_int_provision        money,
@w_total_int_pagados    money,
@w_fpago                char(1),
@w_ppago                char(3),
@w_tcapitalizacion      catalogo,
@w_historia             smallint,
@w_fecha_ult_pg_int     datetime,
@w_fecha_mod            datetime,
@w_estado               catalogo,
@v_monto_pg_int         money, 
@v_int_ganado           float, 
@v_int_pagados          float, 
@v_int_estimado         money,
@v_int_provision        money,
@v_total_int_pagados    money,
@v_fecha_ult_pg_int     datetime,
@v_historia             int, 
@v_fecha_mod            datetime

select @w_sp_name  = 'sp_pago_intereses'

select @w_tran_pin= 14905

select @w_fecha_hoy = convert(datetime,convert(varchar,@s_date,101))

/**  VERIFICAR CODIGO DE TRANSACCION **/
if @t_trn <> 14912
  begin
    exec cobis..sp_cerror
    @t_debug = @t_debug, @t_file = @t_file,
    @t_from = @w_sp_name, @i_num = 141018
    return 1
  end


/** SECCION DE LECTURA DE PF_OPERACION **/

select @w_num_banco  	     = op_num_banco,  
       @w_operacionpf        = op_operacion,       
       @w_toperacion	     = op_toperacion,
       @w_categoria 	     = op_categoria,
       @w_int_ganado         = op_int_ganado,
       @w_int_pagados        = op_int_pagados,
       @w_int_estimado       = op_int_estimado,
       @w_int_provision      = op_int_provision,
       @w_total_int_pagados  = op_total_int_pagados,
       @w_fpago  	     = op_fpago,
       @w_ppago  	     = op_ppago,
       @w_moneda             = op_moneda,
       @w_tcapitalizacion    = op_tcapitalizacion,
       @w_secuencia    	     = op_mon_sgte,
       @w_historia	     = op_historia,
       @w_fecha_ult_pg_int   = op_fecha_ult_pg_int,
       @w_estado	     = op_estado,
       @w_fecha_mod	     = op_fecha_mod
from pf_operacion 
where op_num_banco = @i_num_banco   
  and op_fecha_valor < @w_fecha_hoy 
  and op_estado = 'ACT'

if @@rowcount = 0
  begin
    exec cobis..sp_cerror
    @t_debug = @t_debug, @t_file = @t_file,
    @t_from  = @w_sp_name, @i_num = 141004
    return 1
  end

/* Encuentra parametro de decimales */
select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_moneda

if @w_usadeci = 'S'
begin
        select @w_numdeci = isnull (pa_tinyint,0)
        from cobis..cl_parametro
        where pa_nemonico = 'DCI'
          and pa_producto = 'PFI'
end
else
        select @w_numdeci = 0
  

/************************************************************************/
/***       AJUSTE DE VARIABLES E INICIALIZACION DE VARIABLES          **/
/************************************************************************/

if @w_tcapitalizacion = 'S'
  begin
    exec cobis..sp_cerror
    @t_debug      = @t_debug, @t_file       = @t_file,
    @t_from       = @w_sp_name, @i_num        = 141109
    return 1
   end

select @v_int_ganado        = @w_int_ganado,
       @v_int_provision     = @w_int_provision,
       @v_int_pagados       = @w_int_pagados, 
       @v_int_estimado      = @w_int_estimado,
       @v_total_int_pagados = @w_total_int_pagados,
       @v_fecha_ult_pg_int  = @w_fecha_ult_pg_int,
       @v_historia          = @w_historia,
       @v_fecha_mod         = @w_fecha_mod

/************************************************************************/
/**                       PAGO DE INTERESES                            **/
/************************************************************************/

begin tran
save tran pago_intereses
/** VERIFICACION DE MONTO **/

/* if @w_int_ganado - @w_int_pagados <  convert(float,@i_intereses)
  begin
    select @w_error = 141088
    goto ERROR
  end
*/
/** VERIFICACION DE PROVISION **/

--exec sp_round @i_valor      = @i_intereses,
              --@o_resultado  = @i_intereses out

/** PAGO A LA CUENTA CAPTURADA **/
/* GES 05/05/1999 Comentado porque no se calcula el secuencial
exec @w_secuencial=sp_gen_sec                                  */

exec @w_return=sp_debita_int
--       @s_ssn  = @w_secuencial, @s_user = @s_user,
         @s_ssn  = @s_ssn, @s_user = @s_user,
         @s_ofi = @s_ofi, @s_date = @s_date,@s_term = @s_term,
         @s_srv = @s_srv, @t_debug = @t_debug,
         @t_trn = 14905, @i_secuencia  = @w_secuencia,
         @i_sub_secuencia = 1, @i_num_banco  = @w_num_banco,
         @i_monto = @i_intereses, @i_producto = @i_producto,
         @i_tot_monto = @i_intereses, @i_tot_impuesto = 0, --04/15/98 xca 
         @i_fecha_proceso = @w_fecha_hoy,
         @i_cuenta = @i_cuenta, @i_en_linea = 'S',	
	 @i_beneficiario = @i_beneficiario,@i_tasa1 = @i_tasa1,
	 @i_capital='N',@i_normal='S',@i_impuesto=@i_impuesto,
         @i_flag_int_anticipado = @i_flag_int_anticipado

if @w_return <> 0
  begin
    select @w_error = @w_return
    goto ERROR
  end


/** SE VUELVEN A LEER LOS VALORES MONETARIOS MODIFICADOS EN LA OPERACION **/

select @w_int_ganado        = op_int_ganado,
       @w_int_provision     = op_int_provision,
       @w_total_int_pagados = op_total_int_pagados,
       @w_int_pagados       = op_int_pagados
from pf_operacion where op_operacion = @w_operacionpf

/** ACTUALIZACION DE LA OPERACION EXCEPTO LOS VALORES DEBITADOS**/

select @w_fecha_ult_pg_int = @w_fecha_hoy,
       @w_historia         = @w_historia + 1,
       @w_int_pagados     = @w_int_pagados + @i_intereses,
       @w_total_int_pagados = @w_total_int_pagados + @i_intereses

--print 'pagoint: op_total_int_ret: %1!', @i_impuesto

update pf_operacion set 
    --op_fecha_ult_pg_int  = @w_fecha_ult_pg_int,
    op_historia          = @w_historia,
    op_mon_sgte 	 = op_mon_sgte + 1,
    op_fecha_mod         = @s_date,
    op_total_int_retenido= op_total_int_retenido + 
                           round(@i_impuesto, @w_numdeci)
   where op_operacion = @w_operacionpf

if @@error <> 0
  begin
    select @w_error = 145001
    goto ERROR
  end

/** INSERCION DEL HISTORIAL **/

insert pf_historia (hi_operacion, hi_secuencial, hi_fecha,
       hi_trn_code, hi_valor, hi_funcionario, hi_oficina,
       hi_fecha_crea, hi_fecha_mod) 
            values (@w_operacionpf, @v_historia,@s_date,
       @t_trn,@i_intereses, @s_user, @s_ofi,
       @s_date,@s_date)
if @@error <> 0
  begin
    select @w_error = 143006
    goto ERROR
  end

/** PREPARACION DE VALORES DE TRANSACCION DE SERVICIO **/

if @w_int_estimado = @v_int_estimado
  select @w_int_estimado = NULL, @v_int_estimado = NULL

if @w_total_int_pagados = @v_total_int_pagados
  select @w_total_int_pagados = NULL, @v_total_int_pagados = NULL

if @w_fecha_ult_pg_int = @v_fecha_ult_pg_int
  select @w_fecha_ult_pg_int = NULL, @v_fecha_ult_pg_int = NULL

if @w_historia = @v_historia
  select @w_historia = NULL, @v_historia = NULL

/** INSERCION DE TRANSACCION DE SERVICIO PREVIA **/

/* GES 05/05/1999 Comentado porque no se calcula el secuencial
exec @w_secuencial=sp_gen_sec                    */

insert ts_operacion (secuencial, tipo_transaccion, clase,
     usuario, terminal, srv, lsrv, fecha, num_banco, 
     operacion,  int_ganado, int_provision,
     int_estimado, total_int_pagados, fecha_ult_pg_int,
     historia, fecha_mod)
--           values (@w_secuencial, @t_trn,'P',
             values (@s_ssn, @t_trn,'P',
     @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @w_num_banco,
     @w_operacionpf,@v_int_ganado,@v_int_provision,
     @v_int_estimado, @v_total_int_pagados, @v_fecha_ult_pg_int,
     @v_historia,@v_fecha_mod)
if @@error <> 0
  begin
    select @w_error = 143005
    goto ERROR
  end

/** INSERCION DE TRANSACCION DE SERVICIO ACTUALIZACION **/

insert ts_operacion (secuencial, tipo_transaccion, clase,
     usuario, terminal, srv, lsrv, fecha, num_banco, 
     operacion, int_ganado, int_provision,
     int_estimado, total_int_pagados, fecha_ult_pg_int, 
     historia, fecha_mod)
/* GES 05/05/1999 Comentado porque no se calcula el secuencial
             values (@w_secuencial, @t_trn,'A',              */
             values (@s_ssn, @t_trn,'A',
     @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @w_num_banco,
     @w_operacionpf,@w_int_ganado,@w_int_provision,
     @w_int_estimado, @w_total_int_pagados, @w_fecha_ult_pg_int,
     @w_historia,@s_date)
if @@error <> 0
  begin
    select @w_error = 143005
    goto ERROR
  end
commit tran

/************************************************************************/
/**                      FIN: PAGO DE INTERESES                        **/
/************************************************************************/
return  0

ERROR:
    exec cobis..sp_cerror
    @t_debug  = @t_debug, @t_file = @t_file,
    @t_from  = @w_sp_name, @i_num = @w_error
    if @@trancount > 0
      rollback tran 
    return 1
go
