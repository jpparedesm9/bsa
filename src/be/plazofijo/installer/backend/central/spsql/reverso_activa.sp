/************************************************************************/
/*      Archivo:                revacti.sp                              */
/*      Stored procedure:       sp_reverso_activa                       */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha:                  07-Sep-95                               */
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
/*      Este script realiza el reverso de activacion                    */
/*                              MODIFICACIONES                          */
/*      28-03-2008   D.Guerrero     Actualiza campo op_aprobado         */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_reverso_activa')
   drop proc sp_reverso_activa
go

create proc sp_reverso_activa (
      @s_ssn                  int             = NULL,
      @s_user                 login           = NULL,
      @s_term                 varchar(30)     = NULL,
      @s_date                 datetime        = NULL,
      @s_sesn                 int             = NULL,
      @s_srv                  varchar(30)     = NULL,
      @s_lsrv                 varchar(30)     = NULL,
      @s_ofi                  smallint        = NULL,
      @s_rol                  smallint        = NULL,
      @s_ssn_branch   	      int             = NULL,
      @t_debug                char(1)         = 'N',
      @t_file                 varchar(10)     = NULL,
      @t_from                 varchar(32)     = NULL,
      @t_trn                  smallint        = NULL,
      @i_num_banco            cuenta,
      @i_autorizado           login,
      @i_numdoc               int            = NULL,
      @i_observacion          descripcion    = NULL,
      @i_front                varchar(1)     = 'N',
      @i_empresa              tinyint        = 1,
      @i_caja                 char(1)        = 'N')
with encryption
as
declare @w_sp_name                      varchar(32),
        @w_string                       varchar(30),
        @w_descripcion                  descripcion,
        @w_return                       int,
        @w_tran_ape                     int,
        @w_tran_pin                     int,
        @w_ofi_ing                      int,
        @w_estado_tmp                   catalogo,
        @w_estado_ant                   catalogo,
        @w_transito                     tinyint,
        @w_vuelto                       char(1),
        @w_valor_transito               money,

        @w_valor_transito_ext           money,
        --@w_codval                       tinyint, --cambio tipo de dato
        @w_codval                       varchar(20),
        @w_movmonet                     char(1),
        @w_numdoc                int,
        @w_moneda_base                  tinyint,
        @w_secuencial                   int,
        @w_operacion                   char(1),
        @w_operacion_tmp                int,
        @w_secuencia         int,
        @w_total_pagar       money,
        @w_int_renovar       money,
        @w_int_vencido          money,
        @w_incremento        money,
        @w_incr_ext          money,
        @w_num_oficial                  int,
        @w_money                        money,
        @w_impuesto                     money,
        @w_total_monet                  money,
        @w_tasa           float,
        @w_numdeci                      tinyint,
        @w_usadeci                      char(1),
        @w_mantiene_stock               char(1),
        @w_stock                        int,
        /* VARIABLES NECESARIAS PARA PF_OPERACION */
        @w_num_banco                    cuenta,
        @w_num_banco_tmp                cuenta,
        @w_operacionpf                  int,
        @w_historia                     smallint,
        @w_oficina                      smallint,
        @w_moneda                       smallint,
        @w_int_pagados                  money,
        @w_int_ganados                  money,
        @w_tot_int_pagados              money,
        @w_total_int_estimado           money,
        @w_tot_int_est_ant              money,
        @w_total_int_ganados            money,
        @w_monto                        money,
        @w_monto1                       money,
        @w_valor                        money,
        @w_producto                     tinyint,
        @w_estado         catalogo,
        @w_tplazo         catalogo,
        @w_ch1               catalogo,
        @w_retienimp         char(1),
        @w_toperacion        catalogo,
        @w_msg            catalogo,
        @w_fpago          catalogo,
        @w_fecha_mod         datetime,
        @w_fecha_crea        datetime,
        @w_fecha_ing         datetime,
        @w_fecha_act         datetime,
        @w_fecha_ord_act     datetime,
        @v_historia                     smallint,
        @v_estado         catalogo,
        @v_fecha_mod         datetime,
        @w_treverso       smallint,
        @w_plazo_ant         smallint,
        @w_fecven_ant        datetime,
        @w_fecha_ult         datetime,
        @w_dif_estimado         money,
        @w_dif_estim         money,
        @w_dif_impuesto         money,
        
        
/*      VARIABLES NECESARIAS PARA PF_MOV_MONET */
        @w_mm_secuencia                 smallint,
        @w_mm_sub_secuencia             tinyint,
        @w_mm_producto                  catalogo,
        @w_mm_cuenta               cuenta,
        @w_mm_moneda                    tinyint,
        @w_mm_valor                     money,
        @w_mm_valor_ext                 money,
        @w_mm_impuesto                  money,
        @w_dias                 int,
        @w_valor_utilizado              money,
        @w_count                        int,

        @w_ente                         int,        --07/26/2000 Rep SIPLA
        @w_terceros                     char(1),    --07/26/2000 Rep SIPLA
        @w_monsipla_mn                  money,      --07/26/2000 Rep SIPLA
        @w_monsipla_me                  money,      --07/26/2000 Rep SIPLA
        @w_factor         float,      --07/26/2000 Rep SIPLA
        @w_cuota                        tinyint,    -- GES 07/13/01 CUZ-020-099
        @w_ec_estado                    catalogo,  -- GES 12/13/01 CUZ-051-002
        @w_ec_caja                      char(1),    -- GES 12/13/01 CUZ-051-002

        /*Variables para pf_emision_cheque */
        @w_ec_sub_secuencia           int,
        @w_ec_numero         int,
        @w_codigo_alterno    int,
        @w_ec_secuencia         int,
        @w_ec_moneda                    int,
        @w_ec_fpago       catalogo,
        @w_ec_secuencial_lote           int,
        @w_anio_comercial               char(1),
        @w_dia_pago                     smallint,
        @w_bloqueo_jud                  money,
        @w_bloqueo_adm                  money,
        @w_bloqueo_pig                  money,
        @w_mpago_chql                   varchar(10),     -- NYMR NR 192 
        @w_rt_secuencial                int,
        @w_rt_valor                     money



select @w_sp_name = 'sp_reverso_activa',
@w_secuencial = @s_ssn,
@w_valor_transito = 0, @w_valor_transito_ext = 0, @w_vuelto = 'N',
@w_ofi_ing = @s_ofi,
@w_total_pagar = 0



/**  VERIFICAR CODIGO DE TRANSACCION DE ACTIVACION  **/

select @w_tran_ape = 14901
if  ( @t_trn <> 14915)

begin
   exec cobis..sp_cerror 
        @t_debug = @t_debug, 
        @t_file  = @t_file,
        @t_from  = @w_sp_name, 
        @i_num   = 141040
   return 1
end

-- NYMR NR 192 MEDIO DE PAGO CHEQUE LOCAL
select @w_mpago_chql = pa_char
from cobis..cl_parametro
where pa_nemonico = 'NCHQL'
and   pa_producto = 'PFI'


select @w_moneda_base = em_moneda_base
from   cob_conta..cb_empresa where em_empresa = @i_empresa

/** LECTURA DEPOSITO **/
select @w_operacionpf        = op_operacion,
       @w_estado             = op_estado,
       @w_historia           = op_historia,
       @w_fpago              = op_fpago,
       @w_producto           = op_producto,
       @w_int_pagados        = op_int_pagados,
       @w_int_ganados        = op_int_ganado,
       @w_monto              = op_monto_pg_int,
       @w_retienimp          = op_retienimp,
       @w_moneda             = op_moneda,
       @w_oficina            = op_oficina,
       @w_tplazo             = op_tipo_plazo,
       @w_toperacion         = op_toperacion,
       @w_tot_int_pagados    = op_total_int_pagados,
       @w_total_int_estimado = op_total_int_estimado,
       @w_total_int_ganados  = op_total_int_ganados,
       @w_fecha_mod          = op_fecha_mod,
       @w_fecha_crea         = op_fecha_crea,
       @w_fecha_ing          = op_fecha_ingreso,
       @w_fecha_act          = op_fecha_valor,
       @w_fecha_ord_act      = op_fecha_ord_act,
       @w_fecha_ult          = op_ult_fecha_calculo,
       @w_plazo_ant          = op_plazo_ant,
       @w_fecven_ant         = op_fecven_ant,
       @w_tot_int_est_ant    = op_tot_int_est_ant,
       @w_ente               = op_ente,         --Rep. SIPLA
       @w_anio_comercial     = op_anio_comercial,
       @w_dia_pago           = op_dia_pago,
       @w_bloqueo_jud        = isnull(op_monto_blqlegal, 0),
       @w_bloqueo_adm        = isnull(op_monto_blq, 0),
       @w_bloqueo_pig        = isnull(op_monto_pgdo, 0)
from   pf_operacion
where  op_num_banco          = @i_num_banco
--  and  op_oficina        = @s_ofi CVA Set-29-05
and    op_estado          in ('ACT' ,'XACT')

if @@rowcount = 0
begin
   exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
                       @t_from=@w_sp_name, @i_num = 141004
   return  1
end

/*********** ENCUENTRA PARAMETRO DE DECIMALES ***********/

select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_moneda

if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
   from   cobis..cl_parametro
   where  pa_nemonico = 'DCI'
   and    pa_producto = 'PFI'
end
else
   select @w_numdeci = 0

/* GES 03/29/1999 Verifica si se realizo ingreso en caja y se ejecuta el
   reverso desde front end */

if @i_front = 'S'
   if exists(select * from pf_secuen_ticket
   where st_num_banco = @i_num_banco
   and st_estado = 'C')
   begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
      @t_from=@w_sp_name,   @i_num = 141152
      return 1
   end


/**********  VERIFICA SI TIPO DE OPERACION MANEJA INVENTARIO **********/

select @w_mantiene_stock = td_mantiene_stock,
       @w_stock         = td_stock
       from pf_tipo_deposito
       where td_mnemonico=@w_toperacion
       
if  datediff(dd,@w_fecha_crea,@s_date) <> 0
begin
       exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
                          @t_from=@w_sp_name, @i_num = 141141
       return  1
end

/* Verifica de bloqueos vigentes */ 
-- Bloqueos Legales
if @w_bloqueo_jud > 0
begin
   exec cobis..sp_cerror 
        @t_debug = @t_debug, 
        @t_file  = @t_file,
        @t_from  = @w_sp_name, 
        @i_num   = 141200
   return 1
end
-- Bloqueos Administrativos
if @w_bloqueo_adm > 0
begin
   -- NYMR NR 192
   if not exists(select 1 from cob_pfijo..pf_retencion where rt_operacion = @w_operacionpf and rt_motivo = 'BCHQL') begin
      exec cobis..sp_cerror 
        @t_debug = @t_debug, 
        @t_file  = @t_file,
        @t_from  = @w_sp_name, 
        @i_num   = 141019
      return 1
   end
end
-- Bloqueos x Garantias
if @w_bloqueo_pig > 0
begin
   exec cobis..sp_cerror 
        @t_debug = @t_debug, 
        @t_file  = @t_file,
        @t_from  = @w_sp_name, 
        @i_num   = 149006
   return 1
end

select  @w_operacion = 'A' --si la operacion esta activa por apertura
select  @w_impuesto = re_impuesto,
   @w_secuencia = re_renovacion,
   @w_estado_ant  = re_estado_ant,
   @w_monto1  = re_monto,
   @w_operacion_tmp  = re_operacion,
   @w_int_renovar = re_tot_int,
   @w_int_vencido = re_int_vencido,
   @w_incremento = re_incremento
   from  pf_renovacion
   where re_operacion_new  = @w_operacionpf
        and re_estado = 'A'
 if @@rowcount = 1
    begin
      select @w_operacion = 'R' -- si es nueva operacion y activa por renovacion
      select @w_num_banco_tmp = op_num_banco from pf_operacion
           where op_operacion = @w_operacion_tmp
    end
 else select @w_secuencia = 0

 select @w_secuencia = 0
 if @w_incremento < 0
       select @w_secuencia = 1
       select @v_historia    = @w_historia,
              @v_estado      = @w_estado,
              @v_fecha_mod   = @w_fecha_mod,
              @w_historia    = @w_historia + 1,
              @w_estado      = 'ING'

/* 'ACAU' = ACTIVACION AUTOMATICA */
if exists (select * from pf_autorizacion where au_operacion = @w_operacionpf
           and au_tautorizacion = 'ACAU')
   delete pf_autorizacion where au_operacion = @w_operacionpf
              and au_tautorizacion = 'ACAU'

   select @w_dif_estim = @w_total_int_estimado - @w_tot_int_est_ant,
          @w_dif_impuesto=0
          if @w_retienimp = 'S'
                  begin
                    /* GES 09/13/01 CUZ-031-055 COMENTADO
                    select @w_tasa = pa_float from cobis..cl_parametro
                        where pa_producto = 'PFI'
                          and pa_nemonico = 'IMP'
                    FIN COMENTADO */

                   /* GES 09/10/01 CUZ-031-055 BUSQUEDA DE TASA DE RETENCION */
                    exec @w_return = sp_impuesto_renta
                    @t_trn = 14813,
                    @i_tipo = 'N',
                    @i_num_banco = @i_num_banco,
                    @o_tasa = @w_tasa out
                    if @w_return <> 0
                    begin
                       exec cobis..sp_cerror
                       @t_debug     = @t_debug,
                       @t_file      = @t_file,
                       @t_from      = @w_sp_name,
                       @i_num       = @w_return
                       return 1
                    end


                   select @w_dif_impuesto = @w_dif_estim * @w_tasa /100
                  end  /* Si paga impuesto  */



   select @w_dif_estimado = @w_dif_estim - @w_dif_impuesto
   if (@w_dif_estimado > 0) and (@w_fpago='ANT')
        begin
          set rowcount 1
          update pf_det_pago
                set dp_monto=dp_monto-round(@w_dif_estimado, @w_numdeci)
                where dp_operacion = @w_operacionpf
                  and dp_tipo='INT'
                  and dp_estado_xren='N'
        and dp_secuencia=1
           set rowcount 0
        end

              /******** ACTIVACION DE APERTURA ********/

begin tran


---------------------------------------------
-- REVERSO EMISION CHEQUE EMITIDO POR VUELTO
---------------------------------------------
if exists (select mm_operacion from pf_mov_monet
      where mm_operacion = @w_operacionpf
      and   mm_tran      = 14901
                and   mm_tipo      = 'C'
                and   mm_estado    = 'A')
begin

if exists (select ec_operacion
           from   pf_emision_cheque,
                  pf_fpago
           where  ec_operacion      = @w_operacionpf
             and  ec_fecha_emision IS   NOT NULL
             and  ec_tran           = 14901
             and  ec_caja           = 'S'
             and  ec_fpago          = fp_mnemonico
           and  ec_tipo           = 'C'
             and  fp_producto       = 42)
begin
   select @w_ec_sub_secuencia = 0,
          @w_codigo_alterno = 0

   while 1 = 1
   begin
      set rowcount 1
      select @w_ec_numero           = ec_numero,
             @w_ec_secuencia        = ec_secuencia,
             @w_ec_sub_secuencia    = ec_sub_secuencia,
             @w_ec_moneda           = ec_moneda,
             @w_ec_fpago            = ec_fpago,
             @w_ec_secuencial_lote  = ec_secuencial_lote
      from   pf_emision_cheque,
             pf_fpago
      where  ec_operacion      = @w_operacionpf
        and  ec_fecha_emision IS   NOT NULL
        and  ec_tran           = 14901
        and  ec_caja           = 'S'
        and  ec_sub_secuencia  > @w_ec_sub_secuencia
        and  ec_fpago          = fp_mnemonico
   and  ec_tipo           = 'C'
        and  fp_producto       = 42

      if @@rowcount = 0
         break

      -------------------------------------------
      -- Reversar cheque si no fue emitido en SB
      -------------------------------------------

      select @w_codigo_alterno = @w_codigo_alterno + 1

      exec  @w_return =  cob_interfase..sp_isba_reversar_lotes  -- BRON: 15/07/09  cob_sbancarios..sp_reversar_lotes
            @s_ssn              = @s_ssn,
            @s_date             = @s_date,
            @s_term             = @s_term,
            @s_sesn             = @s_sesn,
            @s_srv              = @s_srv,
            @s_lsrv             = @s_lsrv,
            @s_user             = @s_user,
            @s_ofi              = @s_ofi,
            @s_rol              = @s_rol,
            @t_debug            = 'N',
            @t_file             = @t_file,
            @t_trn              = 29301,
            @i_codigo_alterno   = @w_codigo_alterno,  -- SI SE LLAMA MAS DE UNA VEZ DESDE UN SP DEBE SUMARSE UNO A ESTE CAMPO PARA LA TRANSACCION DE SERVICIO
            @i_origen_ing       = '1',                -- 1 INTERFASE 2 CARGA  3 MANUAL
            @i_secuencial       = @w_ec_secuencial_lote,       -- CODIGO GENERADO POR SBA DEL CHEQUE A REVERSAR
            @i_modulo           = 'PFI',              -- MODULO QUE GENERO LA SOLICITUD DEL CHEQUE
            @i_moneda           = @w_ec_moneda,       -- MONEDA DEL INSTRUMENTO
            @i_func_aut         = @s_user             -- LOGIN DEL FUNCIONARIO QUE AUTORIZA EL REVERSO EN EL MODULO ORIGINAL
      if @w_return <> 0
      begin
      exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = @w_return
         return 1
      end

      --------------------------------
      -- Actualizar registro reversado
      --------------------------------
      update pf_emision_cheque
      set    ec_caja = NULL
      where  ec_operacion      = @w_operacionpf
        and  ec_fecha_emision IS   NOT NULL
        and  ec_tran          = 14901
        and  ec_caja          = 'S'
        and  ec_secuencia     = @w_ec_secuencia
        and  ec_sub_secuencia = @w_ec_sub_secuencia
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141166
         return 1
      end
   end --while 1 = 1
end
end
-----------------------------------
-- FIN REVERSO DE CHEQUES
-----------------------------------

------------------------------------------
--REVERSO DE MOVIMIENTOS MONETARIOS
------------------------------------------
  select @w_mm_sub_secuencia = 0
  while 1 = 1
    begin
      set rowcount 1
      select @w_mm_sub_secuencia = mm_sub_secuencia,
             @w_mm_producto      = mm_producto,
             @w_mm_moneda        = mm_moneda,
             @w_mm_cuenta        = mm_cuenta,
             @w_mm_valor         = mm_valor,
             @w_mm_valor_ext     = mm_valor_ext
      from pf_mov_monet
      where  mm_operacion   = @w_operacionpf
      and    mm_secuencia   = 0
      and    mm_estado      = 'A'
      and    mm_sub_secuencia > @w_mm_sub_secuencia
   order by mm_secuencia,mm_sub_secuencia
      if @@rowcount = 0
        break

      set rowcount 0

      if @w_mm_moneda = @w_moneda_base  /**  SUCRES  **/
         select @w_mm_valor_ext = 0

      select @w_incr_ext = @w_incr_ext + @w_mm_valor_ext
      select @w_transito = 0
      select @w_transito = fp_ttransito
      from cob_pfijo..pf_fpago
      where fp_mnemonico = @w_mm_producto and
            fp_estado = 'A'

      if @w_transito > 0
        select @w_valor_transito = @w_valor_transito + @w_mm_valor,
          @w_valor_transito_ext = @w_valor_transito_ext + @w_mm_valor_ext

      -- NYMR NR 192
      if @w_mm_producto in (@w_mpago_chql) begin
         
         
         select  @w_rt_secuencial = isnull(rt_secuencial, 0),
                 @w_rt_valor      = rt_valor
         from    cob_pfijo..pf_retencion
         where   rt_operacion = @w_operacionpf
         and     rt_motivo    = 'BCHQL'
         
         if @w_rt_secuencial > 0 begin
            exec @w_return = cob_pfijo..sp_retencion
               @s_ssn             = @s_ssn,
               @s_user            = @s_user,
               @s_ofi             = @s_ofi,
               @s_date            = @s_date,
               @s_srv             = @s_srv,
               @s_term            = @s_term,
               @t_file            = @t_file,
               @t_from            = @w_sp_name,
               @t_debug           = @t_debug,
               @t_trn	            = 14308,
               @i_operacion       = 'D',
               @i_cuenta          = @i_num_banco,
               @i_secuencial      = @w_rt_secuencial,
               @i_valor           = @w_rt_valor,
               @i_observacion     = 'LEVANTAMIENTO BLOQUEO CHEQUE CANJE',
               @i_motivo          = 'BCHQL',
               @i_funcionario     = @s_user,
               @i_tipo            = 'D',
               @i_batch           = 'N'
               
            if @@error<> 0 begin
               exec sp_errorlog 
                  @i_fecha       = @s_date,
                  @i_error       = 143008, 
                  @i_usuario     = @s_user,
                  @i_tran        = 14308,
                   @i_descripcion = 'ERROR LEVANTAMIENTO BLOQUEO CHEQUE CANJE',
                  @i_cuenta      = @i_num_banco
            end

            select @w_historia  = op_historia + 1,
                   @v_historia   = op_historia
            from   cob_pfijo..pf_operacion
            where  op_num_banco = @i_num_banco

	 end
      end



      exec @w_return=sp_aplica_mov
            @s_ssn  = @s_ssn, @s_user = @s_user,
            @s_ofi = @s_ofi, @s_date = @s_date,
            @s_srv = @s_srv, @s_term = @s_term, @t_file = @t_file,
            @t_from = @w_sp_name, @t_debug = @t_debug,
            @t_trn = @w_tran_ape, @i_tipo = 'R',
            @s_ssn_branch   = @s_ssn_branch,
       @i_operacionpf = @w_operacionpf,@i_secuencia = 0,
       @i_sub_secuencia= @w_mm_sub_secuencia
      if @w_return <> 0
        begin
          exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
               @t_from=@w_sp_name,   @i_num = @w_return
          return 1
        end
    end /* END WHILE 1 */


  select @w_mm_sub_secuencia = 0
  if @v_estado = 'ACT' and @w_operacion = 'R'
  begin
     /* sacamos secuencia de det_pago */
     while 2 = 2
       begin
         set rowcount 1
         select @w_mm_sub_secuencia = mm_sub_secuencia,
         @w_mm_secuencia  = mm_secuencia,
         @w_mm_producto      = mm_producto,
         @w_mm_cuenta        = mm_cuenta,
         @w_mm_valor         = mm_valor,
         @w_mm_impuesto   = mm_impuesto
         from pf_mov_monet
         where    mm_operacion   = @w_operacionpf
           and    mm_tran        = 14919 /* renovacion */
           and    mm_estado      = 'A'
           and    mm_secuencia   > 0
           and    mm_sub_secuencia > @w_mm_sub_secuencia
    order by mm_secuencia,mm_sub_secuencia

         if @@rowcount = 0
           break

         set rowcount 0
         select @w_secuencia = @w_mm_secuencia
         select @w_total_pagar = @w_total_pagar + @w_mm_valor

/* GES 05/05/1999 Comentado porque no se calcula el secuencial
         exec @w_secuencial=sp_gen_sec                        */

         exec @w_return=sp_aplica_mov
-- GES 05/05/1999 @s_ssn  = @w_secuencial, @s_user = @s_user,
              @s_ssn  = @s_ssn, @s_user = @s_user,
              @s_ofi = @s_ofi, @s_date = @s_date,
              @s_srv = @s_srv, @s_term = @s_term, @t_file = @t_file,
              @t_from = @w_sp_name, @t_debug = @t_debug,
              @t_trn = 14919, @i_tipo = 'R',
              @s_ssn_branch   = @s_ssn_branch,
              @i_operacionpf = @w_operacionpf,@i_secuencia = @w_mm_secuencia,
              @i_sub_secuencia= @w_mm_sub_secuencia

      if @w_return <> 0
        begin
          exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
               @t_from=@w_sp_name,   @i_num = @w_return
          return 1
        end
    end /* END WHILE 2 */
    set rowcount 0
  end  /* End de  pago para renovacion*/

  /********** CONTABILIZACION DE LA OPERACION **********/

/* GES 03/27/01 CUZ-002-040 Comentado
  --print 'REVACTI.SP OPERACION %1!',@w_operacion
--if @w_operacion <> 'R' -- si no es operacion renovada
/* comentariado para que no realice los asientos de reversa y como al         */
/* reversar va a poner en estado de 'R' al comprobante ya no pasaran          */
/* los asientos a ser contabilizados, si se ejecuta esta seccion se descuadra */
/* porque pasaran los asientos de REVERSO pero ya no pasan los de ACTIVACION  */

if @w_operacion <> 'R' -- si no es operacion renovada
begin
/*************/
/* REPORTE DE SIPLA */ --Version Colombia
--print 'aqui va!!!'

if @w_moneda <> @w_moneda_base
begin
   select @w_factor = co_conta
   from pf_cotizacion
   where co_moneda = @w_moneda
    and co_fecha = @s_date
  order by co_hora desc
   if @@rowcount <> 1
   begin
          exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
               @t_from=@w_sp_name,   @i_num = 14582, @i_msg = 'No existe cotizacion'
          return 1
   end
end
else
   select @w_factor = 1


select @w_terceros = pa_char
        from cobis..cl_parametro
where   pa_producto = 'PFI'
        and pa_nemonico = 'CTE'

/*************/

   select @w_descripcion = 'despues REVERSO ACTIVACION DPFI'
end
else /* REVERSO DE ACTIVACION POR RENOVACION */
 begin
  /* EJECUTO EL ASIENTO CONTABLE PARA EL REVERSO DE ACTIVACION DE RENOVACION */
    select @w_descripcion = 'REV.ACT. DE REN. (' + @w_num_banco_tmp + ')'
    if @w_estado_ant = 'VEN' select @w_codval = '38'
    else
       select @w_codval = '1'
    select @w_valor = @w_valor_transito
/* COMENTARIADO PARA QUE NO HAGA EL REVERSO DE ACTIVACION POR RENOVACION */
/* PUES AL COMPROBANTE DEBE PONERLO EN ESTADO 'R' Y YA NO PASAN LOS ASIENTOS */
/* DE LA TABLA PF_SASIENTO. xcar                                             */
/* FIN SECCION COMENTARIADA POR REVERSO DE ACTIVACION EN RENOVACION */


/***********/
/* REPORTE DE SIPLA */ --Version Colombia

--print 'aqui va de nuevo!!!'

if @w_moneda <> @w_moneda_base
begin
        select @w_factor = co_conta
        from pf_cotizacion
        where co_moneda = @w_moneda
          and co_fecha = @s_date
        order by co_hora_desc
        if @@rowcount <> 1
        begin
          exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
               @t_from=@w_sp_name,   @i_num = 14582, @i_msg = 'No existe cotizacion'
          return 1
        end
end
else
        select @w_factor = 1


select @w_terceros = pa_char
        from cobis..cl_parametro
where   pa_producto = 'PFI'
        and pa_nemonico = 'CTE'

/***********/

/******************************************************************/
end /* generacion del reverso por renovacion  */

GES 03/27/01 CUZ-002-040 Fin comentado */

  /***  REVERSO DE INTERESES SI ES CRAIN EN ACTIVACION INICIAL  ***/
  if @v_estado = 'ACT' and @w_fpago = 'ANT' and @w_operacion <> 'R'
  begin
  /*  Reverso de intereses si es CRAIN en activacion inicial */
  while 2 = 2
    begin
      set rowcount 1
      select @w_mm_sub_secuencia = mm_sub_secuencia,
        @w_mm_secuencia  = mm_secuencia,
             @w_mm_producto      = mm_producto,
             @w_mm_cuenta        = mm_cuenta,
             @w_mm_valor         = mm_valor,
        @w_mm_impuesto   = mm_impuesto
      from pf_mov_monet
      where  mm_operacion   = @w_operacionpf
      and    mm_tran        = 14905 /* pago de intereses */
      and    mm_estado      = 'A'
      and    mm_secuencia   > 0
      and    mm_sub_secuencia > @w_mm_sub_secuencia
   order by mm_secuencia,mm_sub_secuencia

      if @@rowcount = 0
        break


      set rowcount 0

       exec @w_return=sp_aplica_mov
            @s_ssn  = @s_ssn, @s_user = @s_user,
            @s_ofi = @s_ofi, @s_date = @s_date,
            @s_srv = @s_srv, @s_term = @s_term, @t_file = @t_file,
            @t_from = @w_sp_name, @t_debug = @t_debug,
            @t_trn = 14905, @i_tipo = 'R',
            @s_ssn_branch   = @s_ssn_branch,
            @i_operacionpf = @w_operacionpf,@i_secuencia = @w_mm_secuencia,
            @i_sub_secuencia= @w_mm_sub_secuencia,
       @i_capital='N',@i_normal='S'

      if @w_return <> 0
        begin
          exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
               @t_from=@w_sp_name,   @i_num = @w_return
          return 1
        end
    end /* END WHILE 2 */
   end  /* End de fpago = 'ANT' */

  /***   FIN DE REVERSO DE INTERESES SI ES CRAIN EN ACTIVACION INICIAL  ***/

    /********** REVERSO DE LOS INTERESES GANADOS *********/
       if @w_anio_comercial = 'N'
       begin
          select @w_dias = datediff(dd,@w_fecha_act,@w_fecha_ult)
       end
       else
       begin
          exec sp_funcion_1 @i_operacion   = 'DIFE30',
               @i_fechai   = @w_fecha_act,
               @i_fechaf   = @w_fecha_ult,
               @i_dia_pago = @w_dia_pago,
               @o_dias     = @w_dias out
       end
       select @w_dias = @w_dias +1
       if @w_dias > 0
        begin
        --print 'entre a reverso de provision '
         exec @w_return = sp_calc_diario_int
                @s_ssn    = @s_ssn, @s_user   = @s_user,
                @s_ofi    = @s_ofi, @s_date   = @s_date,
                @s_srv    = @s_srv, @s_lsrv   = @s_lsrv,
                @s_term   = @s_term, @s_rol    = @s_rol, 
                @t_debug  = @t_debug,@t_file   = @t_file, 
                @t_from   = @t_from,  @t_trn    = @t_trn,
                @i_fecha_proceso = @w_fecha_act, @i_num_banco    = @i_num_banco ,
                @i_tipo         = 'R', @i_tipo_act     = 'R',
                @i_dias_interes = @w_dias
          if @w_return <> 0
                   begin
               exec cobis..sp_cerror @t_debug=@t_debug,
                     @t_file=@t_file,
                                 @t_from=@w_sp_name,
                     @i_num = 149015
               return 1
                   end
        end

    /********** FIN DE REVERSO DE LOS INTERESES GANADOS *********/


/** ACTUALIZACION DE LA OPERACION **/
  update pf_operacion set
         op_estado      = @w_estado,
         op_historia    = @w_historia,
    op_int_pagados  = 0,
    op_int_ganado   = 0,
    op_residuo = 0,
         op_preimpreso = 0,
    op_total_int_pagados = 0,
    op_total_int_ganados = 0,
    op_total_int_retenido = 0,
         op_fecha_valor   = @w_fecha_ord_act,
         op_fecha_ord_act   = NULL,
         op_fecha_mod   = @s_date,
    op_accion_sgte = 'NULL',
   op_num_dias = @w_plazo_ant,
   op_fecha_ven   = @w_fecven_ant,
   op_total_int_estimado   = round(@w_tot_int_est_ant, @w_numdeci),
   op_aprobado = 'N'
  where op_operacion = @w_operacionpf

  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 145001
      return 1
    end

/**  ACTUALIZACION DE PF_SECUEN_TICKET  **/
  set rowcount 0
  select @w_count = count(*)
  from pf_secuen_ticket
  where st_operacion = @w_operacionpf

  if @i_caja = 'S'
     select @i_caja = 'I'
  else
     select @i_caja = 'R'

  update pf_secuen_ticket
  set st_estado = @i_caja
  where st_operacion = @w_operacionpf

  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 145042
      return 1
    end



/**  INSERCION TRANSACCION DE SERVICIO PREVIO  **/

  insert ts_operacion (secuencial, tipo_transaccion, clase,
     usuario, terminal, srv, lsrv, fecha, num_banco,
     operacion,  historia, estado, fecha_mod)
               values (@s_ssn, @t_trn,'P',
     @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @i_num_banco,
     @w_operacionpf,  @v_historia, @v_estado, @v_fecha_mod )

  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 143005
       return 1
    end

/**  INSERCION TRANSACCION DE SERVICIO ACTUALIZADO  **/

  insert ts_operacion (secuencial, tipo_transaccion, clase,
     usuario, terminal, srv, lsrv, fecha, num_banco,
     operacion,  historia, estado, fecha_mod)
               values (@s_ssn, @t_trn,'A',
     @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @i_num_banco,
     @w_operacionpf, @w_historia, @w_estado,@s_date)

  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 143005
       return 1
    end

/**  INSERCION EN PF_AUTORIZACION **/

  /*Modificacion:  Walter Solis M. 8/5/01  DP00014-8 */
  if @i_autorizado is NOT NULL
  begin
    --GAR 21-feb-2005 DP00036 Inserta solo si se envia el autorizador
    insert pf_autorizacion (au_operacion,au_autoriza,au_oficina,
      au_tautorizacion,au_fecha_crea,au_num_banco,au_oficial)
    values (@w_operacionpf,@i_autorizado,@s_ofi,'REAC',@s_date,@i_num_banco,@s_user)

    if @@error <> 0
      begin
        exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 143040
       return 1
    end
  end
     /********  SI MANTIENE INVENTARIIO SE AGREGA UNO AL DISPONIBLE  ********/

     if @w_mantiene_stock='S'
        begin
                set rowcount 0
                update pf_det_lote
                   set dl_estado = @w_estado
                   where dl_lote=@i_num_banco

                if @@error <> 0
                  begin
                    exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
                    @t_from=@w_sp_name,   @i_num = 145040
                    return 1
                  end
      /*Modificacion por conversion a oracle ral 0/03/2000*/
       select @w_numdoc = count(*) from pf_det_lote
                        where dl_lote=@i_num_banco

                update pf_tipo_deposito
                   set td_stock=@w_stock+@w_numdoc
                   where td_mnemonico=@w_toperacion

                if @@error <> 0
                  begin
                    exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
                    @t_from=@w_sp_name,   @i_num = 145034
                    return 1
                  end
        end /* si mantiene stock */

     /****** FIN DE SI MANTIENE INVENTARIIO AGREGAR UNO AL DISPONIBLE  ******/

/**  INSERCION HISTORICO **/
  insert pf_historia (hi_operacion, hi_secuencial, hi_fecha,
         hi_trn_code, hi_valor, hi_funcionario, hi_oficina,
         hi_observacion, hi_fecha_crea, hi_fecha_mod)
              values (@w_operacionpf, @v_historia,@s_date,
         @t_trn,@w_monto, @s_user, @s_ofi,
         @i_observacion, @s_date,@s_date)

  if @@error <> 0
    begin
      exec cobis..sp_cerror @t_debug=@t_debug,@t_file=@t_file,
           @t_from=@w_sp_name,   @i_num = 143006
      return 1
     end

   /********** REVERSO DE COMPROBANTES CONTABLES  ***********/

set rowcount 0
update pf_relacion_comp set rc_estado = 'R'
where rc_num_banco = @i_num_banco and
rc_tran      = 'APR' and
rc_estado      = 'N'

update pf_scomprobante set sc_estado = 'R'
from pf_relacion_comp
where  sc_comprobante = rc_comp and
sc_estado = 'I' and
rc_estado = 'R' and
rc_tran = 'APR' and
rc_num_banco = @i_num_banco
if @@error  <> 0
begin
   exec cobis..sp_cerror
   @t_debug         = @t_debug,
   @t_file          = @t_file,
   @t_from          = @w_sp_name,
   @i_num           = 143041
   return 1
end

exec @w_return = sp_aplica_conta
@i_anulacion     = 'S',
@i_operacionpf   = @w_operacionpf,
@i_tipo_trn      = 'APE',
@i_fecha         = @s_date

if @w_return <> 0 begin
   rollback tran
   exec cobis..sp_cerror
   @t_from          = @w_sp_name,
   @i_num           = @w_return
   
   return @w_return
end

-- Borra registros de provicion diaria
delete pf_prov_dia 
where pd_operacion = @w_operacionpf
 and pd_fecha_proceso between @w_fecha_act and @s_date
if @@error  <> 0
begin
 exec cobis..sp_cerror
  @t_debug         = @t_debug,
  @t_file          = @t_file,
  @t_from          = @w_sp_name,
  @i_num           = 143041,
  @i_msg        = 'Error al eliminar registros de provision'
 return 1
end

--Reverso de la provision a nivel contable
exec @w_return = sp_aplica_conta
@i_anulacion     = 'S',
@i_operacionpf   = @w_operacionpf,
@i_tipo_trn      = 'CAU',
@i_fecha         = @s_date

if @w_return <> 0 begin
   rollback tran
   exec cobis..sp_cerror
   @t_from          = @w_sp_name,
   @i_num           = @w_return
   
   return @w_return
end
         
/**********FIN DE  REVERSO DE COMPROBANTES CONTABLES  ***********/

      if exists (select * from pf_cuotas where cu_operacion = @w_operacionpf)
      begin
         select @w_cuota = 0
         set rowcount 0
         while 1 = 1
         begin
            select @w_cuota = cu_cuota
            from pf_cuotas
            where cu_operacion = @w_operacionpf
            and cu_cuota > @w_cuota
            if @@rowcount = 0
               break

            delete pf_cuotas
            where cu_operacion = @w_operacionpf
            and cu_cuota = @w_cuota
            if @@error  <> 0
            begin
               exec cobis..sp_cerror
               @t_debug         = @t_debug,
               @t_file          = @t_file,
               @t_from          = @w_sp_name,
               @i_num           = 147042
               return 1
            end
            insert into ts_cuotas (secuencial, tipo_transaccion, clase, fecha,
            usuario, terminal, srv, lsrv,
            operacion, cuota) values
            (@s_ssn,  14146, 'B', @s_date, @s_user, @s_term, @s_srv, @s_lsrv,
            @w_operacionpf, @w_cuota)
            if @@error <> 0
            begin
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file = @t_file,
               @t_from = @w_sp_name,
               @i_num = 143005
               rollback tran
               return 1
            end

         end
         set rowcount 0
      end

/******************************************************************/
commit tran
return 0
go
