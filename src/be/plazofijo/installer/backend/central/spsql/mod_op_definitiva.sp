/*modpfdef.sp*/
/************************************************************************/
/*      Archivo:                modpfdef.sp                             */
/*      Stored procedure:       sp_mod_op_definitiva                    */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 13-Sep-95                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa mueve la informacion de las tablas temporales     */
/*      de operaciones de plazo fijo nuevas a las tablas definitivas    */
/*      realizando la funcion completa de modificacion del deposito.    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR             RAZON                              */
/*      07-Nov-94  Ricardo Valencia  Creacion                           */
/*      25-Nov-94  Juan Jose Lam     Modificacion                       */
/*      29-Abr-99  Ximena Cartagena  Envio de parametros de capitaliza- */
/*                                   cion de intereses a sp_estima_int  */
/*      12-Oct-99  Marcelo Cartagena Se cambio el parametro @i_puntos   */
/*                                   de smallint a float                */
/*      04/04/2000 Ricardo Alvarez   Cambios Fechas Comerciales         */
/*      06-Abr-00  Ximena Cartagena  Prorroga Automatica.               */
/*      12-Abr-00  Ximena Cartagena  Tasa Variable.                     */
/*      17-Ago-01  Memito Saborio    Inclusion de un campo nuevo que    */
/*                                   lleva una instruccion especial.    */
/*     2005/10/04 Carlos Cruz D.    Se aumenta campo para manejo de su- */
/*                                  cursal de retencion de corresponden-*/
/*                                  cia                                 */
/*     22/Jul/2009   Y. Martinez    NYM DOF00015 ICA                    */
/*     12/Ene/2017   Jorge Salazar  DPF-H94952 MANEJO DE RETENCIONES MX */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_mod_op_definitiva')
   drop proc sp_mod_op_definitiva
go

create proc sp_mod_op_definitiva (
      @s_ssn                  int             = NULL,
      @s_user                 login           = NULL,
      @s_term                 varchar(30)     = NULL,
      @s_date                 datetime        = NULL,
      @s_sesn                 int             = NULL,
      @s_srv                  varchar(30)     = NULL,
      @s_lsrv                 varchar(30)     = NULL,
      @s_ofi                  smallint        = NULL,
      @s_rol                  smallint        = NULL,
      @t_debug                char(1)         = 'N',
      @t_file                 varchar(10)     = NULL,
      @t_from                 varchar(32)     = NULL,
      @t_trn                  smallint        = NULL,
      @i_cuenta               cuenta,
      @i_autorizado           varchar(10)     = NULL,
      @i_renova_todo          char(1)         = 'N',
      @i_renovaut             char(1)         = 'N',
      @i_cancelaut            char(1)         = 'N',
      @i_operacion            char(1)         = 'U',
      @i_puntos               float           = 0,
      @i_numdoc               smallint        = 0,
      @i_moneda_pg            char(2)         = NULL,
      @i_monto_base           money           = 0,
      @i_activa               char(1)         = 'N',
      @i_formato_fecha        int             = 0,  /* GESCY2K B270 */
      @i_aut_spread           login           = NULL,--12-Abr-2000 Tasa Variabl
      @i_autoriza_pago_otros  login           = NULL,
      @i_instruccion_especial varchar(255)    = NULL,
      @i_firmas_aut           char(1)         = NULL,--gap DP00008 Firmas Autorizadas
      @i_dias_hold            int             = 0,
--CVA Jun-28-06 parametros para escalonado cuando se le cambian las tasas en modificacion deposito ingresado
      @i_modifica             char(1)         = 'N',
      @i_op_operacion         int             = NULL

)
with encryption
as
declare @w_sp_name                        varchar(32),
        @w_return                         int,
        @w_ced_ruc                        numero,
        @w_comentario                     varchar(32),
        @w_siguiente                      int,
        @w_sig_ant                        int,
        @w_secuencial                     int,
        @w_sec                            int,
        @w_num_oficial                    int,
        @w_money                          money,
        @w_total_monet                    money,
        @w_clase                          char(1),
        @w_cuenta_dias                    int,
        @w_max_ttransito                  int,
        @w_dif                            smallint,
        @w_impuesto                       money,
        @w_num_pagos                      smallint,
        @w_sec_ticket                     int,
   /*  Variables para la operacion anterior en Update */
        @w_p_operacionpf                  int,
        @w_p_ente                         int,
        @w_p_toperacion                   catalogo,
        @w_p_categoria                    catalogo,
        @w_p_oficina                      smallint,
        @w_p_moneda                       tinyint,
        @w_p_casilla                      tinyint,
        @w_p_direccion                    tinyint,
        @w_p_num_dias                     smallint,
        @w_p_monto                        money,
        @w_p_monto_pg_int                 money,
        @w_p_monto_pgdo                   money,
        @w_p_monto_blq                    money,
        @w_p_tasa                         float,
        @w_tasa                           float,
        @w_p_tasa_efectiva                float,
        @w_p_int_ganado                   float,
        @w_p_int_estimado                 money,
        @w_p_int_estim                    money,
        @w_p_int_pagados                  money,
        @w_p_int_provision                money,
        @w_p_total_int_ganados            money,
        @w_p_total_retencion              money,
        @w_p_total_int_pagados            money,
        @w_p_total_int_estimado           money,
        @w_p_total_int_estim              money,
        @w_dif_estim                      money,
        @w_dif_estimado                   money,
        @w_dif_impuesto                   money,
        @w_p_fpago                        catalogo,
        @w_p_ppago                        catalogo,
        @w_p_dia_pago                     tinyint,
        @w_p_historia                     smallint,
        @w_p_base_calculo                 smallint,
        @w_p_duplicados                   tinyint,
        @w_p_renovaciones                 smallint,
        @w_p_incremento                   smallint,
        @w_p_mon_sgte                     smallint,
        @w_p_estado                       catalogo,
        @w_p_pignorado                    char (1),
        @w_p_retenido                     char (1),
        @w_p_totalizado                   char (1),
        @w_p_tcapitalizacion              char (1),
        @w_p_oficial                      login,
        @w_p_descripcion                  varchar(255),
        @w_p_causa_mod                    varchar(60),
        @w_p_fecha_valor                  datetime,
        @w_p_fecha_ven                    datetime,
        @w_fecha_ven1                     datetime,
        @w_op_dias_reales                 char(1),
        @w_p_fecha_pg_int                 datetime,
        @w_p_fecha_ult_pg_int             datetime,
        @w_p_accion_sgte                  varchar(4),
        @w_p_fecha_ing                    datetime,
        @w_p_fecha_total                  datetime,
        @w_p_retienimp                    char(1),
        @w_p_tipo_plazo                   catalogo,
        @w_p_tipo_monto                   catalogo,
        @w_p_fecha_crea                   datetime,
        @w_p_fecha_mod                    datetime,
        --GES 03-11-1999 RET-IMPTO. 1%
        @w_p_retiene_imp_capital          char(1),
        @w_p_impuesto_capital             money,
        @w_p_anio_comercial               char(1), --04/04/2000 Fecha Comercial
        @w_p_prorroga_aut                 char(1), --06-Abr-2000 Prorroga Aut.
        @w_p_num_dias_gracia              int,     --06-Abr-2000 Prorroga Aut.
        @w_p_flag_tasaefec                char(1), --04-May-2000 Efec/Nominal.
        @w_ente                           int,     -- GES 09/12/01 CUZ-031-034
        @w_tipo_persona                   catalogo, --KTA GB-GAPDP00143
        @w_origen_fondos                  catalogo, --KTA GB-GAPDP00143
        @w_proposito_cuenta               catalogo, --KTA GB-GAPDP00143
        @w_producto_bancario1             catalogo, --KTA GB-GAPDP00143
        @w_producto_bancario2             catalogo,  --KTA GB-GAPDP00143
        @w_sucursal                       smallint,
        @w_tran_sabado                    char(1),
        -- NYM DOF00015 ICA
        @w_ret_ica                        char(1),
        @w_tasa_retencion                 float,
        @w_tasa_ica                       float,
        @w_base_ret                       money,
        @w_base_ica                       money,
        @w_tot_int_est_neto               money,
        @w_impuesto_ica                   money,
        -- NYM DPF00015 ICA
        @w_tipo_deposito                  int,
        @w_valor_retenido                 money

select @w_sp_name = 'sp_mod_op_definitiva',
       @w_secuencial = @s_ssn


/**  VERIFICAR CODIGO DE TRANSACCION DE APERTURA  **/
if   (@t_trn <> 14917 or @i_operacion <> 'U')
begin
  exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141112
  return 1
end


select
  @w_p_toperacion          = op_toperacion,
  @w_p_operacionpf         = op_operacion,
  @w_p_ente                = op_ente,
  @w_p_categoria           = op_categoria,
  @w_p_oficina             = op_oficina,
  @w_p_moneda              = op_moneda,
  @w_p_casilla             = op_casilla,
  @w_p_direccion           = op_direccion,
  @w_p_num_dias            = op_num_dias,
  @w_p_monto               = op_monto,
  @w_p_monto_pg_int        = op_monto_pg_int,
  @w_p_monto_pgdo          = op_monto_pgdo,
  @w_p_monto_blq           = op_monto_blq,
  @w_p_tasa                = op_tasa,
  @w_p_tasa_efectiva       = op_tasa_efectiva,
  @w_p_int_ganado          = op_int_ganado,
  @w_p_int_estimado        = op_int_estimado,
  @w_p_int_pagados         = op_int_pagados,
  @w_p_int_provision       = op_int_provision,
  @w_p_total_int_ganados   = op_total_int_ganados,
  @w_p_total_retencion     = op_total_retencion,
  @w_p_total_int_pagados   = op_total_int_pagados,
  @w_p_total_int_estimado  = op_total_int_estimado,
  @w_p_fpago               = op_fpago,
  @w_p_ppago               = op_ppago,
  @w_p_dia_pago            = op_dia_pago,
  @w_p_historia            = op_historia,
  @w_p_base_calculo        = op_base_calculo,
  @w_p_duplicados          = op_duplicados,
  @w_p_renovaciones        = op_renovaciones,
  @w_p_incremento          = op_incremento,
  @w_p_mon_sgte            = op_mon_sgte,
  @w_p_estado              = op_estado,
  @w_p_pignorado           = op_pignorado,
  @w_p_retenido            = op_retenido,
  @w_p_totalizado          = op_totalizado,
  @w_p_tcapitalizacion     = op_tcapitalizacion,
  @w_p_oficial             = op_oficial,
  @w_p_descripcion         = op_descripcion,
  @w_p_causa_mod           = op_causa_mod,
  @w_p_fecha_valor         = op_fecha_valor,
  @w_p_fecha_ven           = op_fecha_ven,
  @w_p_fecha_pg_int        = op_fecha_pg_int,
  @w_p_fecha_ult_pg_int    = op_fecha_ult_pg_int,
  @w_p_accion_sgte         = op_accion_sgte,
  @w_p_fecha_ing           = op_fecha_ingreso,
  @w_p_fecha_total         = op_fecha_total,
  @w_p_retienimp           = op_retienimp,
  @w_p_tipo_plazo          = op_tipo_plazo,
  @w_p_tipo_monto          = op_tipo_monto,
  @w_p_fecha_mod           = op_fecha_mod,
  @w_p_fecha_crea          = op_fecha_crea,
  @w_p_impuesto_capital    = op_impuesto_capital,
  @w_p_retiene_imp_capital = op_retiene_imp_capital,
  @w_p_anio_comercial      = op_anio_comercial,--04/04/2000 Fecha Comercial
  @w_p_prorroga_aut        = op_prorroga_aut, --06-Abr-2000 Prorroga Aut.
  @w_p_num_dias_gracia     = op_num_dias_gracia, --06-Abr-2000 Prorroga Aut.
  @w_p_flag_tasaefec       = op_flag_tasaefec, --04-May-2000 Efectiva/Nominal
  @w_origen_fondos         = op_origen_fondos,      --KTA GB-GAPDP00143
  @w_proposito_cuenta      = op_proposito_cuenta,   --KTA GB-GAPDP00143
  @w_producto_bancario1    = op_producto_bancario1, --KTA GB-GAPDP00143
  @w_producto_bancario2    = op_producto_bancario2,  --KTA GB-GAPDP00143
  @w_sucursal              = op_sucursal,
  @w_op_dias_reales        = op_dias_reales
from  pf_operacion
where op_num_banco = @i_cuenta
and   op_estado = 'ING'

if @@rowcount = 0
begin
  exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                           @t_from  = @w_sp_name, @i_num   = 141051
  return 1
end

--INI NYM DPF00015 ICA
exec @w_return = cob_pfijo..sp_aplica_impuestos
     @s_ofi              = @s_ofi,
     @t_debug            = @t_debug,
     @i_operacion        = 'T',
     @i_ente             = @w_p_ente,
     @i_plazo            = @w_p_num_dias,
     @i_capital          = @w_p_monto,
     @i_interes          = @w_p_total_int_estim,
     @i_base_calculo     = @w_p_base_calculo,
     @o_retienimp        = @w_p_retienimp    out,
     @o_tasa_retencion   = @w_tasa_retencion out,
     @o_valor_retencion  = @w_valor_retenido out

if @w_return <> 0
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_return
   return @w_return
end
--FIN NYM DPF00015 ICA


select @w_tipo_persona = td_tipo_persona,
       @w_tipo_deposito = isnull(td_tipo_deposito,0)

  from pf_tipo_deposito
 where td_mnemonico = @w_p_toperacion


/* GES 11/24/1998 REVISAR PF_SECUEN TICKET PARA VER SI YA SE COBRO EN CAJA */

if exists (select * from pf_secuen_ticket
           where (st_estado = 'A' or st_estado = 'C')
             and st_operacion = @w_p_operacionpf)
begin
  exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 141152
  return  1
end

begin tran
  delete pf_operacion
   where op_num_banco = @i_cuenta
  if @@error <> 0
  begin
    exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                    @t_from  = @w_sp_name, @i_num   = 703028
    select @w_return = 1
    goto borra
  end

  delete pf_operacion_his        --LIM 15/DIC/2005
   where oh_num_banco = @i_cuenta
  if @@error <> 0
  begin
    exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                    @t_from  = @w_sp_name, @i_num   = 703028
    select @w_return = 1
    goto borra
  end

  delete pf_rubro_op          --CVA JUN-27-06 para escalonados
  where ro_operacion = @w_p_operacionpf
  if @@error <> 0
  begin
    exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                    @t_from  = @w_sp_name, @i_num   = 703028
    select @w_return = 1
    goto borra
  end

  delete pf_beneficiario
   where be_operacion = @w_p_operacionpf
  if @@error <> 0
  begin
    exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                    @t_from  = @w_sp_name, @i_num   = 703028
    select @w_return = 1
    goto borra
  end

  delete pf_mov_monet
  where mm_operacion = @w_p_operacionpf
  if @@error <> 0
  begin
    exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                    @t_from  = @w_sp_name, @i_num   = 703028
    select @w_return = 1
    goto borra
  end

   /** GES 11/23/1998 SE MODIFICAN LOS REGISTROS NO APLICADOS EN PF_SECUEN_TICKET*/
  update pf_secuen_ticket
  set st_estado = 'N', st_fecha_modificacion = @s_date
  where st_operacion = @w_p_operacionpf

  if @@error <> 0
  begin
    exec cobis..sp_cerror
         @t_debug = @t_debug,  @t_file = @t_file,
         @t_from = @w_sp_name, @i_num = 145042
    return 1
  end

  delete pf_emision_cheque
   where ec_operacion = @w_p_operacionpf
  if @@error <> 0
  begin
    exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                    @t_from  = @w_sp_name, @i_num   = 703028
    select @w_return = 1
    goto borra
  end

  delete pf_det_pago
   where dp_operacion = @w_p_operacionpf
  if @@error <> 0
  begin
    exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                    @t_from  = @w_sp_name, @i_num   = 703028
    select @w_return = 1
    goto borra
  end



  delete  pf_renovacion
   where re_operacion = @w_p_operacionpf
  if @@error <> 0
  begin
    exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                    @t_from  = @w_sp_name, @i_num   = 703028
    select @w_return = 1
    goto borra
  end

  delete pf_cancelacion
   where ca_operacion = @w_p_operacionpf
  if @@error <> 0
  begin
    exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                    @t_from  = @w_sp_name, @i_num   = 703028
    select @w_return = 1
    goto borra
  end

  select @w_sig_ant = dp_det_producto
   from cobis..cl_det_producto
   where dp_cuenta = @i_cuenta
     and dp_producto = 14

  delete cobis..cl_det_producto
   where dp_cuenta = @i_cuenta
     and dp_producto = 14
  if @@error <> 0
  begin
    exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                    @t_from  = @w_sp_name, @i_num   = 703028
    select @w_return = 1
    goto borra
  end

  delete cobis..cl_cliente
   where cl_det_producto = @w_sig_ant
  if @@error <> 0
  begin
    exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                    @t_from  = @w_sp_name, @i_num   = 703028
     select @w_return = 1
    goto borra
  end

  exec @w_return = sp_ins_op_definitiva
       @s_ssn                  = @s_ssn,
       @s_user                 = @s_user,
       @s_sesn                 = @s_sesn,
       @s_ofi                  = @s_ofi, @s_date = @s_date,@t_trn=14916,
       @s_srv                  = @s_srv, @s_term = @s_term, @t_file = @t_file,
       @t_from                 = @w_sp_name, @t_debug = @t_debug,
       @i_cuenta               = @i_cuenta,
       @i_operacion            = @i_operacion,
       @i_autorizado           = @i_autorizado,
       @i_aut_spread           = @i_aut_spread, --12-Abr-2000 Tasa Variable
       @i_puntos               = @i_puntos,
       @i_renovaut             = @i_renovaut,
       @i_cancelaut            = @i_cancelaut,
       @i_renova_todo          = @i_renova_todo,
       @i_fecha_crea           = @w_p_fecha_crea,
       @i_activa               = @i_activa,
       @i_numdoc               = @i_numdoc,
       @i_moneda_pg            = @i_moneda_pg,
       @i_historia             = @w_p_historia,
       @i_monto_base           = @i_monto_base,
       @i_autoriza_pago_otros  = @i_autoriza_pago_otros,
       @i_instruccion_especial = @i_instruccion_especial,
       @i_firmas_aut           = @i_firmas_aut, --gap DP00008
       @i_dias_hold            = @i_dias_hold,
       @i_modifica             = @i_modifica,
       @i_op_operacion         = @i_op_operacion,
       @o_sec_ticket           = @w_sec_ticket

   if @w_return <> 0
   begin
      select @w_return = 1
      goto borra
   end

  set rowcount 0

  /* Inserta transaccion de servicio anterior */
   insert ts_operacion (secuencial, tipo_transaccion, clase,
     usuario, terminal, srv, lsrv, fecha, num_banco, operacion,
     ente, toperacion, categoria, producto, oficina, moneda, num_dias,
     monto, monto_pg_int,monto_pgdo, monto_blq, tasa, int_ganado, int_estimado,
     int_pagados, int_provision, total_int_ganados, total_int_pagados,
     total_int_estimado,ppago,dia_pago, historia, incremento,duplicados,
     renovaciones, estado, pignorado,oficial, descripcion, fecha_valor,
     fecha_ven,fecha_pg_int, fecha_ult_pg_int, fecha_crea, fecha_mod,
     fecha_ingreso,totalizado,fecha_total,tipo_plazo,tipo_monto,causa_mod,
     retenido,total_retencion,retienimp,tasa_efectiva,accion_sgte,mon_sgte,
     tcapitalizacion,fpago,base_calculo,casilla,direccion,
     sucursal, ica -- NYM DPF00015 ICA
  )
  values (@s_ssn, @t_trn,'P', @s_user, @s_term, @s_srv,
     @s_lsrv, @s_date, @i_cuenta, @w_p_operacionpf,
     @w_p_ente, @w_p_toperacion, @w_p_categoria,14, @w_p_oficina,@w_p_moneda,
     @w_p_num_dias,@w_p_monto,@w_p_monto_pg_int,@w_p_monto_pgdo,
     @w_p_monto_blq, @w_p_tasa,
     @w_p_int_ganado, @w_p_int_estimado,@w_p_int_pagados,@w_p_int_provision,
     @w_p_total_int_ganados, @w_p_total_int_pagados,@w_p_total_int_estimado,
     @w_p_ppago,@w_p_dia_pago, @w_p_historia,@w_p_incremento,@w_p_duplicados,
     @w_p_renovaciones, @w_p_estado,@w_p_pignorado,@w_p_oficial,
     @w_p_descripcion,
     @w_p_fecha_valor, @w_p_fecha_ven,@w_p_fecha_pg_int, @w_p_fecha_ult_pg_int,
     @s_date,@s_date,@w_p_fecha_ing,@w_p_totalizado,@w_p_fecha_total,
     @w_p_tipo_plazo,@w_p_tipo_monto,@w_p_causa_mod,@w_p_retenido,
     @w_p_total_retencion,
     @w_p_retienimp,@w_p_tasa_efectiva,@w_p_accion_sgte,@w_p_mon_sgte,
     @w_p_tcapitalizacion,@w_p_fpago,@w_p_base_calculo,@w_p_casilla,@w_p_direccion,
     @w_sucursal, @w_ret_ica -- NYM DPF00015 ICA
  )

  if @@error <> 0
  begin
    exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 143005
    select @w_return = 1
    goto borra
  end

   /*  Pantalla de Resumen  */
  select @w_max_ttransito = isnull(max(fp_ttransito),0)
   from pf_fpago,pf_mov_monet
  where fp_mnemonico = mm_producto
    and fp_estado <> 'E'
    and mm_operacion = @w_p_operacionpf
    and mm_secuencia = 0
    and fp_ttransito > 0

   select @w_cuenta_dias=0

   if @w_max_ttransito > 0
   begin
      -- Calcula el próximo día hábil
      exec sp_primer_dia_labor
           @t_debug         = @t_debug,
           @t_file          = @t_file,
           @t_from          = @w_sp_name,
           @i_fecha         = @w_p_fecha_valor,
           @s_ofi           = @s_ofi,
           @i_tran_sabado   = 'S',  -- GES 05/10/01 CUZ-009-031
           @i_operacion     = 'C',
           @i_ttransito     = @w_max_ttransito,   --20-Sep-2005 xca
           @i_tipo_deposito = @w_tipo_deposito,
           @o_fecha_labor   = @w_p_fecha_valor out

   end

   if @w_p_anio_comercial = 'N'   --04/04/2000 Fecha Comercial
      select @w_p_fecha_ven=dateadd(dd,@w_p_num_dias,@w_p_fecha_valor)
   else
   begin
      --04/04/2000 Fecha Comercial
      /*FIN PROC INCREMENTADO PARA TOMAR LA FECHA DE VENCIMINETO COMERCIAL */
      exec sp_funcion_1 @i_operacion = 'SUMDIA',
           @i_fechai   = @w_p_fecha_valor,
           @i_dias     = @w_p_num_dias,
           @i_dia_pago = @w_p_dia_pago,   --*-*
           @o_fecha    = @w_p_fecha_ven out
      --print 'MODPFDEF.XCA FECHA_VEN %1!, NUM_DIAS %2! ',@w_p_fecha_ven,@w_p_num_dias

      /*FIN PROC INCREMENTADO PARA TOMAR LA FECHA DE VENCIMINETO COMERCIAL */
      --04/04/2000 Fecha Comercial
   end


  exec sp_primer_dia_labor 
  	   @t_debug         = @t_debug, 
  	   @t_file          = @t_file,
       @t_from          = @w_sp_name, 
       @i_fecha         = @w_p_fecha_ven,
       @s_ofi           = @s_ofi, 
       @i_tipo_deposito = @w_tipo_deposito,
       @o_fecha_labor   = @w_fecha_ven1 out

  if @w_p_anio_comercial = 'N' and @w_max_ttransito > 0
  begin
    select @w_tran_sabado = td_tran_sabado
     from pf_tipo_deposito
    where td_mnemonico = @w_p_toperacion


           ----------------------------------------------
           -- Calcular la fecha de vencimiento laborable
           ----------------------------------------------
           exec sp_primer_dia_labor
                @t_debug         = @t_debug,
                @t_file          = @t_file,
                @t_from          = @w_sp_name,
                @i_fecha         = @w_fecha_ven1,
                @s_ofi           = @s_ofi,

                @i_tran_sabado   = @w_tran_sabado,
        	    @i_tipo_deposito = @w_tipo_deposito,
                @o_fecha_labor   = @w_fecha_ven1 out
   end

   select @w_dif=datediff(dd,@w_p_fecha_ven,@w_fecha_ven1)

   if @w_dif > 0
    select @w_p_num_dias=@w_p_num_dias+@w_dif

   --  select @w_p_dia_pago = datepart(dd,@w_p_fecha_valor)

   /* GES 09/12/01 CUZ-031-032 BUSQUEDA DE CLIENTE PARA VERIFICAR TASA IMPTO. */
     select @w_ente = op_ente,
            @w_tasa = op_impuesto
     from pf_operacion
     where op_operacion = @w_p_operacionpf --@i_operacion

   select @w_dif_estim    = @w_p_total_int_estim - @w_p_total_int_estimado,
          @w_dif_impuesto = 0

   if @w_p_retienimp = 'S'
   begin
      select @w_impuesto     = @w_p_total_int_estim * @w_tasa/100,
             @w_dif_impuesto = @w_dif_estim * @w_tasa/100
   end  /* Si paga impuesto  */

   select @w_dif_estimado = @w_dif_estim - @w_dif_impuesto



commit tran

       select 'NUM. BANCO'          = @i_cuenta,
              'NUM. OPERACION'      = @w_p_operacionpf,
              'FECHA VENCIMIENTO'   = convert(varchar(10),@w_fecha_ven1,@i_formato_fecha),
              'INTERES ESTIMADO'    = @w_p_int_estim,
              'IMPUESTOS A PAGAR '  = @w_impuesto,
              'TOTAL INT. ESTIMADO' = @w_p_total_int_estim,
              'FECHA PAGO INTERES'  = convert(varchar(10),@w_p_fecha_pg_int, @i_formato_fecha),
              'DIA DE PAGO'         = convert(varchar(3),@w_p_dia_pago) + ' DE CADA MES',
              'NUMERO DE PAGOS'     = @w_num_pagos,
              'PLAZO'               = @w_p_num_dias,
              'DIFERENCIA INTERES'  = @w_dif_estimado,
              'SECUENCIAL TICKET'   = @w_sec_ticket,
              'TIPO PERSONA'        = @w_tipo_persona


  --select @w_return = 0

goto borra

/**  ELIMINACION DE TEMPORALES **/

  borra:
  set rowcount 0
  delete pf_operacion_tmp where
         ot_usuario = @s_user and ot_sesion = @s_sesn
  delete pf_mov_monet_tmp where
         mt_usuario = @s_user and mt_sesion = @s_sesn
  delete pf_beneficiario_tmp where
         bt_usuario = @s_user and bt_sesion = @s_sesn
  delete pf_det_pago_tmp where
         dt_usuario = @s_user and dt_sesion = @s_sesn
  delete pf_det_cheque_tmp where
         ct_usuario = @s_user and ct_sesion = @s_sesn
return 0
go
