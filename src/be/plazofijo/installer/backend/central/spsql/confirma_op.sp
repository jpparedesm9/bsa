/*confirma.sp*/
/************************************************************************/
/*      Archivo:                confirma.sp                             */
/*      Stored procedure:       sp_confirma_op                          */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
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
/*      Este script cambia a las op.  de plazo fijo a estado activo     */
/*      despues de haber validado que no exitan problemas en la cap-    */
/*      tacion hecha que tuvo dias de transito.  Si hubo problemas se   */
/*      gera el movimiento monetario por el monto total de todos los    */
/*      problemas que tuvo el deposito.                                 */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/************************************************************************/
/*      13-Jul-95  Erika Sanchez      Creacion                          */   
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_confirma_op') is not null
   drop proc sp_confirma_op
go

create proc sp_confirma_op(
@s_ssn                  int             = NULL,
@s_user                 login           = 'sa',
@s_term                 varchar(30)     = 'consola',
@s_date                 datetime        = NULL,
@s_sesn                 int             = NULL,
@s_srv                  varchar(30)     = 'PRSSRVP',
@s_lsrv                 varchar(30)     = 'PRSSRVP',
@s_ofi                  smallint        = NULL,   
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = 14924, 
@i_fecha_valor          datetime,
@i_fecha_pg_int         datetime,
@i_num_banco            cuenta,
@i_num_dias             int,  
@i_moneda               int,  
@i_moneda_pg            int,  
@i_operacion            int,
@i_estado               catalogo        = 'XACT',
@i_mon_sgte             int,
@i_ente                 int,
@i_fecha_mod            datetime,
@i_causa_mod            catalogo,
@i_monto_pg_int         money,
@i_total_int_estimado   money,
@i_impuesto             money = null,
@i_fpago                catalogo,
@i_retienimp            char(1),
@i_en_linea             char(1) = 'S',
@i_historia             int,
@i_ppago                catalogo,
@i_tcapitalizacion      char(1),
@i_tasa                 float,
@i_tasa1                float = 0, 
@i_tot_impuesto         money = 0, 
@i_tot_monto            money = 0, 
@i_dias_anio            smallint,
@i_toperacion           catalogo,
@i_fecha_hoy            datetime,   
@i_renova_todo          char(1))
with encryption
as
declare 
  @w_sp_name                      varchar(32),
  @w_string                       varchar(30),
  @w_descripcion                  descripcion,
  @w_s_ssn                        int,
  @w_trn                          int,
  @w_vuelto                       char(1), 
  @w_problema                     char(1), 
  @w_movmonet                     char(1), 
  @w_moneda_base                  tinyint,
  @w_moneda_pg                    tinyint,
  @w_transito                     tinyint,
  @w_intren                       money,
  @w_valor                        money, 
  @w_valor_tran                   money, 
  @w_op_dias_reales               char(1),
  @w_valor_tot_tran               money, --acum. mm_valor de reg Tran xca
  @w_valor_tran_ext               money, 
  @w_return                       int,
  @w_secuencial                   int,
  @w_secuencia                    int,
  @w_secuencia_ren                int,
  @w_num_oficial                  int,
  @w_money                        money,
  @w_codval                       varchar(20),  --cambia tipo de dato
  @w_monto_cap                    money,
  @w_total_monet                  money,
  @w_max_ttransito        smallint,
  @w_dia_pago             smallint,
  @w_numdoc               smallint,
  @w_base_calculo         smallint,
  @w_dias                         int,
  @w_sub_sec           tinyint,
  @w_numdeci                      tinyint,
  @w_numdeci_pg                   tinyint,
  @w_usadeci                      char(1),
  @w_mantiene_stock               char(1),
  /* VARIABLES NECESARIAS PARA PF_OPERACION */
  @w_operacionpf                  int,
  @w_toperacion                   catalogo, 
  @w_operacion                    char(1),
  @w_tplazo                       catalogo,
  @w_num_banco                    cuenta,
  @w_total_int_pagado             money,
  @w_monto_pg_int                 money,
  @w_total_int_estimado           money,
  @w_int_estimado      money,
  @w_total_int_acumulado          money,
  @w_total_pagar                  money,
  @w_total_pagar_pg               money,
  @w_impuesto                    money,
  @w_impuesto_ren           money,
  @w_impuesto_pg            money,
  @w_factor                   float,
  @w_imp                          money,
  @w_tasa                float,
  @w_tasa1                    float,
  @w_mon_sgte                     int,
  @w_historia                     smallint,
  @w_estado         catalogo,
  @w_estado_ant           catalogo,
  @w_fpago          catalogo,
  @w_ppago          catalogo,
  @w_error          int,
  @w_fecha          datetime,
  @w_fecha_mod         datetime,
  @w_fecha_valor       datetime,
  @w_fecha_pg_int      datetime,
  @w_fecha_ven         datetime,
  @w_causa_mod         catalogo,
  @w_forma_pago           catalogo,
  @w_fecha_hoy              datetime,
  @w_imprime                char(1),
  @w_tcapitalizacion         char(1),
  @v_historia                     smallint,
  @v_estado         catalogo,
  @v_fecha_mod         datetime,
  @v_causa_mod         catalogo,
  @v_mon_sgte          int,
  @w_fecha_temp_hoy       datetime,
  @w_cuenta_dias            smallint,
  @w_oficina                      smallint,   -- GAL 31/AGO/2009 - RVVUNICA
  @w_producto                     tinyint,
  @w_moneda                       tinyint, --29-abr-99 capitalizacion xca B062
  @w_retienimp                    char(1), --29-abr-99 capitalizacion xca B062
  @w_tasa_variable                char(1), --12-Abr-2000 Tasa Variable  
/* VARIABLES NECESARIAS PARA PF_MOV_MONET_PROB */
  @w_sum_monto_problema           money,
  @w_monto_dif                    money,
  @w_tipo                     varchar(1),
/* VARIABLES NECESARIAS PARA PF_MOV_MONET */
  @w_mm_sub_secuencia             tinyint,
  @w_mm_producto             catalogo,
  @w_mm_cuenta                    cuenta,
  @w_mm_moneda                    smallint,
  @w_tran_ape               int,
  @w_mm_valor                money,
  @w_mm_valor_ext            money,
  @w_pt_forma_pago        catalogo,
  @w_pt_beneficiario      int,
  @w_pt_secuencia                 smallint,
  @w_pt_cuenta         cuenta,
  @w_pt_monto          money,
  @w_tot_pt_monto                 money,
  @w_pt_mont                      money,
  @w_pt_porcentaje        float,
  @w_monto_mov         money,
  @w_contor         smallint,
  @w_sum_reversados               money,
  @w_op_monto                     money,
  @w_monto_contabilizar           money,
/* VARIABLES PARA CONTABILIZACION */  
  @w_cotizacion                   money,
  @w_cotizacion_conta             money,
  @w_cotizacion_venta_b           money,
  @w_cotizacion_compra_b          money,
  @w_contador                     smallint,
  @w_debcred                      char,
  @w_cheque_pro                   catalogo,
  @w_valor_mn                     money,
  @w_valor_me                     money,
  @w_perfil                       varchar(10),
  @w_comprobante                  int,
  @w_area_dest                    int,
  @w_tot_valor_mn                 money,
  @w_tot_valor_me                 money ,
  @w_tot_valor_or                 money ,   -- MCA 06-Nov-1999 
  @w_impuesto_capital             money,    -- Actualizacion Perfil 4
  @w_anio_comercial       char(1),  -- Fecha Comercial
  @w_area_origen                  int,      
  @w_ente                         int,
  @w_rollback                     char(1),      --LIM 16/NOV/2005   
  @w_mensaje                      varchar(250),    --LIM 16/NOV/2005
  @w_mnemonico_tasa                catalogo,    -- 12-Abr-2000 Tasa Variable 
  @w_modalidad_tasa        char(1),     -- 12-Abr-2000 Tasa Variable 
  @w_periodo_tasa          smallint,    -- 12-Abr-2000 Tasa Variable 
  @w_descr_tasa            descripcion, -- 12-Abr-2000 Tasa Variable 
  @w_tipo_deposito         int



select @w_sp_name    = 'sp_confirma_op',
       @w_secuencial    = @s_ssn,
       @w_tran_ape   = 14901, @w_vuelto = 'N', @w_problema = 'N', 
       @w_valor_tran    = 0, @w_valor_tot_tran = 0, @w_valor_tran_ext = 0

select @w_rollback = 'N'                  --LIM 16/NOV/2005

select @w_moneda_base = em_moneda_base
from cob_conta..cb_empresa 
where em_empresa = 1

select @w_factor = 1,
       @i_fecha_mod           = convert(datetime,convert(varchar,@i_fecha_mod,101)),
       @i_fecha_valor         = convert(datetime,convert(varchar,@i_fecha_valor,101)),
       @w_operacionpf         = @i_operacion,
       @w_estado              = @i_estado,
       @w_mon_sgte            = @i_mon_sgte,
       @w_fecha_mod           = @i_fecha_mod,       
       @w_causa_mod        = @i_causa_mod,
       @w_fecha_valor         = @i_fecha_valor,
       @w_monto_pg_int        = @i_monto_pg_int,  
       @w_ppago            = @i_ppago,
       @w_fpago            = @i_fpago,
       @w_tcapitalizacion     = @i_tcapitalizacion,
       @w_tasa1            = @i_tasa,
       @w_base_calculo        = @i_dias_anio, 
       @w_fecha_hoy        = @i_fecha_hoy,
       @w_toperacion       = @i_toperacion,
       @v_historia            = @i_historia,
       @w_historia            = @i_historia + 1,
       @v_estado              = @i_estado,
       @v_fecha_mod           = @i_fecha_mod,
       @v_causa_mod        = @i_causa_mod,
       @v_mon_sgte            = @i_mon_sgte,
       @w_total_int_acumulado = 0,
       @i_tasa1            = @i_tasa, 
       @i_tot_monto        = 0,
       @i_tot_impuesto        = 0, 
       @w_total_int_pagado    = 0
select @w_forma_pago = pa_char 
  from cobis..cl_parametro 
 where pa_nemonico = 'FPDE' 
   and pa_producto='PFI' 
if @@rowcount = 0
begin
   select @w_mensaje = 'No exite forma de pago de devolucion'     --LIM 16/NOV/2005
   select @w_error =  141140                 --LIM 16/NOV/2005
   goto ERROR
end

select @w_operacion = 'I'

if exists (select * 
             from pf_renovacion
            where re_estado = 'A' 
              and re_operacion_new = @i_operacion )
begin
   select @w_moneda_pg    = convert(tinyint,re_moneda_pg),
          @w_operacion    = 'R',
          @w_estado_ant   = re_estado_ant,
     @w_intren       = re_tot_int, 
     @w_impuesto_ren = re_impuesto*re_int_vencido/re_tot_int,
     @w_impuesto     = re_impuesto
     from pf_renovacion 
    where re_estado = 'A' 
      and re_operacion_new = @i_operacion 
    
   select @w_impuesto_ren =round(@w_impuesto - @w_impuesto_ren,@w_numdeci)
end
else
   select @w_moneda_pg = @i_moneda_pg

------------------------------------
-- Encuentra parametro de decimales 
------------------------------------
select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @i_moneda

if @w_usadeci = 'S'
begin
  select @w_numdeci = isnull (pa_tinyint,0)
  from cobis..cl_parametro
  where pa_nemonico = 'DCI'
    and pa_producto = 'PFI'
end
else
  select @w_numdeci = 0  

select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @w_moneda_pg

if @w_usadeci = 'S'
begin
  select @w_numdeci_pg = isnull (pa_tinyint,0)
    from cobis..cl_parametro
   where pa_nemonico = 'DCI'
     and pa_producto = 'PFI'
end
else
  select @w_numdeci_pg = 0  

if @i_moneda <> @w_moneda_pg
begin
  exec sp_calc_cotiza 
       @t_trn       = 14439,
       @i_moneda1   = @i_moneda,
       @i_moneda2   = @w_moneda_pg,
       @i_operacion = 'Q',
       @o_factor    = @w_factor out
end  

-------------------------------------------------------------
-- Validacion de movimiento monetario con tiempo de transito
--------------------------------------------------------------
select @w_max_ttransito = max(fp_ttransito),
       @w_valor_tran = isnull(sum(mm_valor + mm_impuesto),0), 
       @w_valor_tran_ext = isnull(sum(mm_valor_ext + mm_impuesto_capital_me),0) 
  from pf_fpago,pf_mov_monet
 where fp_mnemonico = mm_producto
   and fp_estado = 'A'
   and mm_operacion = @w_operacionpf
   and mm_secuencia = 0
   and fp_ttransito > 0 
group by mm_operacion
if @@rowcount = 0
begin
   select @w_mensaje = 'No exite tiempo de transito para la operacion'     --LIM 16/NOV/2005
   select @w_error =  141000                    --LIM 16/NOV/2005
   goto ERROR
end
--------------------------------------------------------------------
-- Validar que los dias de transito sean unicamente dias laborables 
--------------------------------------------------------------------
select @w_cuenta_dias = 0,
       @w_fecha_temp_hoy = @w_fecha_valor,
       @w_rollback = 'S'                     --LIM 16/NOV/2005

   begin tran

   if @w_fecha_valor <= @w_fecha_hoy /** EL DEPOSITO DEBE SER ACTIVADO**/
   begin
      -----------------------------------------
      -- Sumatoria de movimientos con problema
      -----------------------------------------
      select @w_sum_monto_problema = sum(pr_valor)
        from pf_mov_monet_prob
       where pr_secuencia = 0  
         and pr_operacion = @w_operacionpf 
         and pr_estado = 'I' 
       group by  pr_operacion

      if @@rowcount = 0
      begin
         select @w_sum_monto_problema = 0
      end

      -------------------------------------------------
      -- Leer todos los registros con dias de transito
      -------------------------------------------------
      select @w_mm_sub_secuencia   = 0 

      while 1 = 1
      begin
         set rowcount 1
      
         select @w_mm_sub_secuencia = mm_sub_secuencia,
                @w_mm_producto      = mm_producto,
           @w_mm_moneda     = mm_moneda,
                @w_mm_cuenta        = mm_cuenta,
                @w_mm_valor         = isnull(mm_valor,0),
                @w_mm_valor_ext     = isnull(mm_valor_ext,0)
           from pf_mov_monet
          where mm_operacion   = @w_operacionpf
            and mm_secuencia   = 0
             and mm_estado      = 'A'
            and mm_sub_secuencia > @w_mm_sub_secuencia
            and mm_tran        = 14901
          order by mm_sub_secuencia

         if @@rowcount = 0
         begin
            break     
         end
      
         select @w_transito = fp_ttransito 
           from cob_pfijo..pf_fpago 
          where fp_mnemonico = @w_mm_producto 
            and fp_estado = 'A'

         if @w_mm_moneda = @w_moneda_base
            select @w_valor_tot_tran = @w_valor_tot_tran + @w_mm_valor 
         else
            select @w_valor_tot_tran = @w_valor_tot_tran + @w_mm_valor_ext
      end /* WHile 1= 1  */

      ---------------------------------
      -- Si el deposito tuvo problemas
      ---------------------------------
      if @w_sum_monto_problema > 0    
      begin
         select @w_sum_reversados = 0
         select @w_mm_sub_secuencia = 0
         select @w_tot_valor_or = isnull(sum(st_valor),0)
      from pf_secuen_ticket
     where st_estado in ('C','A')  
       and st_num_banco = @i_num_banco 
     group by  st_num_banco

         while 1 = 1
         begin
            set rowcount 1
            select @w_mm_sub_secuencia = mm_sub_secuencia,
                   @w_mm_producto      = mm_producto,
                   @w_mm_moneda        = mm_moneda,
                   @w_mm_cuenta        = mm_cuenta,
                   @w_mm_valor         = mm_valor + mm_impuesto, 
                   @w_mm_valor_ext     = mm_valor_ext + mm_impuesto_capital_me 
              from pf_mov_monet
             where mm_operacion   = @w_operacionpf
               and mm_secuencia   = 0
               and mm_estado      = 'A'
               and mm_sub_secuencia > @w_mm_sub_secuencia
               and mm_producto in (select fp_mnemonico from pf_fpago 
                                    where fp_estado = 'A' and fp_producto = 4) 
            order by mm_secuencia,mm_sub_secuencia
            if @@rowcount = 0
               break


            select @w_sum_reversados = @w_sum_reversados + @w_mm_valor
         
            set rowcount 0        

            if @w_mm_moneda = @w_moneda_base
               select @w_mm_valor_ext = 0
        
            exec @w_return=sp_aplica_mov
                 @s_ssn           = @s_ssn,  
                 @s_user          = @s_user,
                 @s_ofi           = @s_ofi,              
                 @s_date          = @s_date,
                 @s_srv           = @s_srv,              
                 @s_term          = @s_term, 
                 @t_file          = @t_file,        
                 @t_from          = @w_sp_name, 
                 @t_debug         = @t_debug,     
                 @t_trn           = @w_tran_ape, 
                 @i_tipo          = 'R',        
                 @i_operacionpf   = @w_operacionpf,
                 @i_secuencia     = 0,     
                 @i_sub_secuencia = @w_mm_sub_secuencia, 
                 @i_en_linea      = @i_en_linea
 
            if @w_return <> 0
            begin
         select @w_mensaje = 'Error reverso de movimientos' 
         select @w_error =  @w_return                 
         goto ERROR
            end
         end /* END WHILE 1 */    
      
     
         select @w_mm_sub_secuencia = 0
        
         select @w_tipo      = 'R',
           @w_imprime   = 'N',   
                @w_estado    = 'ANU',@w_problema = 'S', 
                @w_monto_dif = @w_tot_valor_or - @w_sum_monto_problema,
                @w_monto_cap = @w_tot_valor_or - @w_valor_tran

         select @w_monto_dif = round(@w_monto_dif, @w_numdeci)
      
         select @w_monto_cap = round(@w_monto_cap, @w_numdeci)

         ----------------------------------------------
         -- Generar movimiento de Devolucion del resto
         ----------------------------------------------
         if @w_monto_dif > 0
         begin
            insert pf_mov_monet(mm_operacion    , mm_tran        , mm_secuencia        , mm_secuencial,
                                mm_sub_secuencia, mm_producto    , mm_cuenta           , mm_valor,
                                mm_fecha_crea   , mm_fecha_mod   , mm_tipo             , mm_moneda,
                                mm_estado       , mm_beneficiario, mm_fecha_aplicacion , mm_user)
                         values(@w_operacionpf  , @t_trn         , @w_mon_sgte         , 0,
                                1               , @w_forma_pago  , @w_num_banco        , @w_monto_dif,
                                @s_date         , NULL           , 'C'                 , @i_moneda,
                                NULL            , @i_ente        , null                , @s_user)
            if @@error <> 0 
            begin
               select @w_mensaje = 'Error de insercion de movimientos monetarios'   --LIM 16/NOV/2005
             select @w_error =  143022                --LIM 16/NOV/2005
             goto ERROR
            end        
               
       select @w_secuencia = @w_mon_sgte
              
            exec @w_return=sp_aplica_mov
                 @s_ssn           = @s_ssn,                       @s_user = @s_user,
                 @s_ofi           = @s_ofi,                          @s_date = @s_date,
                 @s_srv           = @s_srv,                          @s_term = @s_term, 
                 @t_file          = @t_file,
                 @t_from          = @w_sp_name, 
                 @t_debug         = @t_debug, 
                 @t_trn           = @t_trn, 
                 @i_operacionpf   = @w_operacionpf,
                 @i_fecha_proceso = @w_fecha_hoy ,
                 @i_secuencia     = @w_secuencia , 
                 @i_tipo          = 'N',
                 @i_sub_secuencia = 1,
                 @i_en_linea      = @i_en_linea

            if @w_return <> 0
            begin
          select @w_mensaje = 'Error devolucion del resto'
             select @w_error   = @w_return               
             goto ERROR
            end 
          
            select @w_mon_sgte= @w_mon_sgte +1
         end 

         ------------------------------------------------------
         -- Actualizacion de estado de registros con problemas
         ------------------------------------------------------          
         update pf_mov_monet_prob 
       set pr_estado= 'A' 
          where  pr_secuencia = 0  
       and pr_operacion = @w_operacionpf
         if @@error <> 0
         begin
       select @w_mensaje = 'Error en actualizacion de registros con problemas'           --LIM 16/NOV/2005
          select @w_error =  145001                      --LIM 16/NOV/2005
          goto ERROR
         end
      end
      else /* El deposito debe ser activado no tuvo problemas */
      begin
         select @w_tipo            = 'C',
           @w_estado         = 'ACT',
                @w_problema          = 'N', 
                @w_imprime         = 'S'  
      end /* fin del begin else */

      select @w_producto         = op_producto ,
             @w_num_banco        = op_num_banco, 
             @w_oficina          = op_oficina ,
             @w_toperacion       = op_toperacion, 
             @w_tplazo           = op_tipo_plazo,
             @w_op_monto         = op_monto,
             @w_retienimp        = op_retienimp,          -- capitalizacion
             @w_moneda           = op_moneda,             -- apitalizacion 
             @w_impuesto_capital = op_impuesto_capital,   -- Actualiz.impuesto capital perfil 4
             @w_anio_comercial   = op_anio_comercial,     -- Fecha Comercial
             @w_tasa_variable    = op_tasa_variable,      -- Tasa Varable 
             @w_dia_pago    = op_dia_pago,      --*-*
             @w_ente             = op_ente,
        @w_op_dias_reales   = op_dias_reales,
        @w_periodo_tasa  = op_periodo_tasa,       -- cobis..te_pizarra..pi_periodo
        @w_modalidad_tasa   = op_modalidad_tasa,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica 
        @w_descr_tasa    = op_descr_tasa,
             @w_mnemonico_tasa   = op_mnemonico_tasa   -- DTF, TCC, IPC, PRIME, ESC               
        from pf_operacion 
       where op_operacion = @i_operacion 


   select   @w_tipo_deposito = isnull(td_tipo_deposito,0)
   from     pf_tipo_deposito
   where    td_mnemonico = @w_toperacion


      ------------------------------
      -- Control de fecha comercial
      ------------------------------
      if @w_anio_comercial = 'N' --04/04/2000 Fecha Comercial
         select @w_fecha_ven = dateadd(dd,@i_num_dias,@w_fecha_temp_hoy)
      else
      begin
         exec sp_funcion_1 @i_operacion = 'SUMDIA',
            @i_fechai   = @w_fecha_temp_hoy,
            @i_dias     = @i_num_dias,
            @i_dia_pago = @w_dia_pago,  --*-*
            @o_fecha    = @w_fecha_ven out
      end   

      exec sp_primer_dia_labor 
         @t_debug       =   @t_debug, 
         @t_file        =   @t_file,
         @s_ofi         =   @s_ofi,
         @t_from        =   @w_sp_name, @i_fecha=@w_fecha_ven,
         @i_tipo_deposito = @w_tipo_deposito,
         @o_fecha_labor =   @w_fecha_ven out

      --if @w_op_dias_reales  = 'S' 
      --begin
      exec sp_estima_int 
         @i_fecha_inicio    = @w_fecha_temp_hoy,
         @s_ofi             = @s_ofi,
         @s_date            = @s_date, 
         @i_fecha_final     = @w_fecha_ven,
         @i_monto           = @w_monto_pg_int,
         @i_tasa            = @w_tasa1,
         @i_tcapitalizacion = @w_tcapitalizacion,
         @i_fpago           = @w_fpago,
         @i_ppago           = @w_ppago,
         @i_dias_anio       = @w_base_calculo,
         @i_dia_pago        = @w_dia_pago,
         @i_batch           = 'S', --CVA Jul-11-06
         @i_retienimp       = @w_retienimp,-- capitalizacion
         @i_moneda          = @w_moneda,   -- capitalizacion
         @i_ente            = @w_ente,  
         @i_tasa_imp        = @w_tasa,  
         --I. CVA Jul-11-06 Parametros para escalonado
         @i_op_operacion    = @i_operacion,
         @i_toperacion      = @w_toperacion,               
         @i_periodo_tasa    = @w_periodo_tasa,       -- cobis..te_pizarra..pi_periodo
         @i_modalidad_tasa  = @w_modalidad_tasa,     -- cobis..te_pizarra..pi_modalidad, en la IPC no aplica 
         @i_descr_tasa      = @w_descr_tasa,
         @i_mnemonico_tasa  = @w_mnemonico_tasa,     -- DTF, TCC, IPC, PRIME, ESC
         @i_tipo_plazo      = @w_tplazo, 
         @i_en_linea        = 'N',     
         @i_dias_reales     = @w_op_dias_reales,                          -- GAL 14/SEP/2009 - RVVUNICA
         --F. CVA Jul-11-06 Parametros para escalonado
         @o_fecha_prox_pg   = @w_fecha_pg_int out,
         @o_int_pg_pp       = @w_int_estimado out,
         @o_int_pg_ve       = @w_total_int_estimado out
      /*end                                                                   GAL 14/SEP/2009 - RVVUNICA
      else     --04/04/2000 Fecha Comercial
      begin
         exec sp_estima_int_com 
            @i_fecha_inicio    = @w_fecha_temp_hoy,
            @s_ofi             = @s_ofi,
            @s_date            = @s_date,
            @i_fecha_final     = @w_fecha_ven,
            @i_monto           = @w_monto_pg_int,
            @i_tasa            = @w_tasa1,
            @i_tcapitalizacion = @w_tcapitalizacion,
            @i_fpago           = @w_fpago,
            @i_ppago           = @w_ppago,
            @i_dias_anio       = @w_base_calculo,
            @i_dia_pago        = @w_dia_pago,
            @i_batch           = 1,
            @i_retienimp       = @w_retienimp,       -- capitalizacion 
            @i_moneda          = @w_moneda,          -- capitalizacion 
            @i_num_dias        = @i_num_dias,   -- Fecha Comercial
            @i_ente            = @w_ente,  
            @i_tasa_imp        = @w_tasa,  
            @o_fecha_prox_pg   = @w_fecha_pg_int out,
            @o_int_pg_pp       = @w_int_estimado out,
            @o_int_pg_ve       = @w_total_int_estimado out
      end
      */

      ------------------------------   
      -- Pago de interes anticipado
      ------------------------------
      select @w_impuesto = 0
           
      if @w_estado = 'ACT' and @i_fpago in ('ANT','PRA') --13-Mar-2000 PRA
      begin
         if @i_retienimp='S'
         begin
  
            exec @w_return = sp_impuesto_renta
                 @t_trn = 14813,
                 @i_tipo = 'E',
                 @i_ente = @w_ente,
                 @o_tasa = @w_tasa out
            if @w_return <> 0
            begin
         select @w_mensaje = 'Error en impuesto a la renta'  
            select @w_error =  @w_return                    
            goto ERROR
            end                  
            select @w_impuesto = @w_tasa * @w_total_int_estimado / 100
         end
   
         if @i_renova_todo = 'N'
         begin
            select @w_contor       = 1,
                   @w_pt_secuencia = 0 ,
                   @w_total_pagar  = @w_total_int_estimado - @w_impuesto 

            select @w_total_pagar_pg = @w_total_pagar * @w_factor,
              @w_impuesto_pg = @w_impuesto * @w_factor
         
            while 2=2
            begin
               set rowcount 1
               select @w_pt_beneficiario = dp_ente,        
            @w_pt_forma_pago   = dp_forma_pago,
                      @w_pt_cuenta       = dp_cuenta,
                      @w_pt_secuencia    = dp_secuencia,
                      @w_pt_monto        = dp_monto,
                      @w_pt_porcentaje   = dp_porcentaje
                 from pf_det_pago
                where dp_operacion  = @w_operacionpf 
             and dp_secuencia    > @w_pt_secuencia 
             and dp_tipo         = 'INT' 
             and dp_estado_xren  = 'N'
                  and dp_estado         = 'I'
                order by dp_tipo,dp_secuencia

               if @@rowcount = 0
                  break
      
               set rowcount 0
         
               if @w_pt_monto is null 
               begin
             select @w_monto_mov = @w_pt_porcentaje*@w_total_pagar_pg/100
                  select @w_imp = @w_pt_porcentaje*@w_impuesto_pg/100
               end
               else
               begin
                  select @w_monto_mov = @w_pt_monto
                  select @w_imp=(@w_pt_monto*@w_impuesto_pg)/@w_total_pagar_pg
               end

               select @w_monto_mov = round(@w_monto_mov,@w_numdeci)
               select @w_imp = round(@w_imp,@w_numdeci)
               select @i_tasa1 = @w_tasa
            
               exec @w_return=sp_debita_int
                    @s_ssn             = @s_ssn, 
                    @s_user            = @s_user,
                    @s_ofi             = @s_ofi,                     
                    @s_date            = @s_date,
               @s_term            = @s_term,
                    @s_srv             = @s_srv, 
                    @t_debug           = @t_debug, 
                    @t_trn             = 14905, 
                    @i_secuencia       = @w_mon_sgte,
                    @i_sub_secuencia   = @w_contor, 
                    @i_num_banco       = @i_num_banco,
                    @i_monto           = @w_monto_mov, 
                    @i_moneda          = @w_moneda_pg,
                    @i_producto        = @w_pt_forma_pago,
                    @i_fecha_proceso   = @w_fecha_hoy,
                    @i_cuenta          = @w_pt_cuenta,
                    @i_en_linea        = @i_en_linea,
                    @i_beneficiario    = @w_pt_beneficiario,
                    @i_pago_anticipado = 'S',
                    @i_capital         = 'N',
                    @i_normal          = 'S',
                    @i_impuesto        = @w_imp,
                    @i_tot_impuesto    = @w_imp,
                    @i_tot_monto       = @w_monto_mov,   
                    @i_tasa1           = @i_tasa1, 
                    @i_tasa_variable   = @w_tasa_variable
                                
               if @w_return <> 0
               begin
        select @w_mensaje = 'Error en sp_debita_int'        --LIM 16/NOV/2005
           select @w_error =  @w_return               --LIM 16/NOV/2005
           goto ERROR                     --LIM 16/NOV/2005
               end
         
               select @w_contor = @w_contor + 1
            end /* END WHILE 2 */
 
            ------------------------
            -- Obtener secuenciales
            ------------------------    
            select @w_mon_sgte=@w_mon_sgte + 1
            select @w_historia = op_historia,
                   @v_historia = op_historia
              from pf_operacion
             where op_operacion = @i_operacion 
         end
         else
            select @w_total_int_acumulado = @w_total_int_estimado - @w_impuesto 
      end /* Anticipado    */ 

      ----------------------------
      -- Administracion de vuelto
      ----------------------------  
      if @w_estado='ACT'
      begin
         select @w_pt_secuencia   =0,
                @w_sub_sec=0
    
         while 3=3
         begin
            set rowcount 1
            select @w_pt_beneficiario = dp_ente,
                   @w_pt_forma_pago = dp_forma_pago,
                   @w_pt_cuenta = dp_cuenta,
                   @w_pt_secuencia = dp_secuencia,
                   @w_pt_monto = dp_monto,
                   @w_pt_porcentaje = dp_porcentaje
              from pf_det_pago
             where dp_operacion = @w_operacionpf 
               and dp_secuencia > @w_pt_secuencia 
               and dp_tipo = 'VUL' 
               and dp_estado_xren='N'
             order by dp_tipo,dp_secuencia
       
            if @@rowcount = 0
               break  
      
            select @w_vuelto = 'S'
            select @w_sub_sec=@w_sub_sec + 1
            select @w_pt_mont = round(@w_pt_monto, @w_numdeci)

            -------------------------------------      
            -- Insercion de movimiento monetario
            -------------------------------------
            insert pf_mov_monet (mm_operacion       , mm_tran           , mm_secuencia, mm_sub_secuencia,
                                 mm_producto        , mm_cuenta         , mm_valor    , mm_valor_ext,
                                 mm_impuesto        , mm_fecha_crea     , mm_fecha_mod, mm_tipo,
                                 mm_secuencial      , mm_beneficiario   , mm_moneda   , mm_estado,
                                 mm_fecha_aplicacion, mm_user)
                         values (@w_operacionpf     , 14928             , @w_mon_sgte , @w_sub_sec,
                                 @w_pt_forma_pago   , @w_pt_cuenta      , @w_pt_mont  , @w_pt_mont,
                                 0                  , @s_date           , @s_date     , 'C',
                                 0                  , @w_pt_beneficiario, @i_moneda   , null,
                                 null               , @s_user)
            if @@error <> 0
            begin
       select @w_mensaje = 'Error insercion de movimientos monetarios vuelto'    --LIM 16/NOV/2005
          select @w_error =  145000                   --LIM 16/NOV/2005
          goto ERROR                         --LIM 16/NOV/2005
            end    

            exec @w_return=sp_aplica_mov
                 @s_ssn           = @s_ssn,
                 @s_user          = @s_user,
                 @s_ofi           = @s_ofi,
                 @s_date          = @s_date,
                 @s_srv           = @s_srv,
                 @s_term          = @s_term, 
                 @t_file          = @t_file,
                 @t_from          = @w_sp_name, 
                 @t_debug         = @t_debug,
                 @t_trn           = 14928, 
                 @i_operacionpf   = @w_operacionpf, 
                 @i_fecha_proceso = @w_fecha_hoy,
                 @i_secuencia     = @w_mon_sgte,
                 @i_tipo          = 'N',
                 @i_sub_secuencia = @w_sub_sec,
                 @i_en_linea      = @i_en_linea
  
            if @w_return <> 0
            begin
       select @w_mensaje = 'Error en aplicacion de vuelto'           --LIM 16/NOV/2005    
          select @w_error =  @w_return                   --LIM 16/NOv/2005
          goto ERROR                         --LIM 16/NOV/2005
            end
         end  /* while 3 */
      end /* generacion de vuelto para activo */

      -------------------------------------------------------------
      -- Generacion de pago cuando la activacion es por renovacion
      -------------------------------------------------------------
      if @w_operacion = 'R' and @w_estado = 'ACT'
      begin
         select @w_mon_sgte = @w_mon_sgte+1
         select @w_pt_secuencia = 0,
                @w_sub_sec = 1
          
         while 3=3
         begin
            set rowcount 1
            select @w_pt_beneficiario = dp_ente,
                   @w_pt_forma_pago   = dp_forma_pago,
                   @w_pt_cuenta       = dp_cuenta,
                   @w_pt_secuencia    = dp_secuencia,
                   @w_pt_monto        = dp_monto,
                   @w_pt_porcentaje   = dp_porcentaje
              from pf_det_pago
             where dp_operacion  = @w_operacionpf 
               and dp_secuencia  > @w_pt_secuencia 
               and dp_tipo       = 'REN' 
               and dp_estado_xren   ='N'
             order by dp_secuencia        
            if @@rowcount = 0
               break
    
            set rowcount 0
    
            select @w_pt_mont = round(@w_pt_monto, @w_numdeci_pg) 

            insert pf_mov_monet (mm_operacion       , mm_tran           , mm_secuencia, mm_sub_secuencia,
                                 mm_producto        , mm_cuenta         , mm_valor    , mm_valor_ext,
                                 mm_impuesto        , mm_fecha_crea     , mm_fecha_mod, mm_tipo,
                                 mm_secuencial      , mm_beneficiario   , mm_moneda   , mm_estado,
                                 mm_fecha_aplicacion, mm_user)
                         values (@w_operacionpf     , 14919             , @w_mon_sgte , @w_sub_sec,
                                 @w_pt_forma_pago   , @w_pt_cuenta      , @w_pt_mont  , @w_pt_mont,
                                 0                  , @s_date           , @s_date     , 'C',
                                 0                  , @w_pt_beneficiario, @w_moneda_pg, null,
                                 null               , @s_user)
            if @@error <> 0
            begin
           select @w_mensaje = 'Error en insercion de movimientos monetarios'    --LIM 16/NOV/2005
         select @w_error =  143020                    --LIM 16/NOV/2005
         goto ERROR                          --LIM 16/NOV/2005
            end  
    
            select @w_secuencia_ren = @w_mon_sgte
    
            exec @w_return=sp_aplica_mov
                 @s_ssn           = @s_ssn,
                 @s_user          = @s_user,
                 @s_ofi           = @s_ofi, 
                 @s_date          = @s_date,
                 @s_srv           = @s_srv, 
                 @s_term          = @s_term, 
                 @t_file          = @t_file,  
                 @t_from          = @w_sp_name, 
                 @t_debug         = @t_debug,
                 @t_trn           = 14919, 
                 @i_operacionpf   = @w_operacionpf,
                 @i_fecha_proceso = @w_fecha_hoy,
                 @i_secuencia     = @w_mon_sgte,
                 @i_tipo          = 'N',
                 @i_sub_secuencia = @w_sub_sec,
                 @i_en_linea      = @i_en_linea 

            if @w_return <> 0
            begin
               select @w_mensaje = 'Error en sp_aplica_mov'         --LIM 16/NOV/2005
               select @w_error =  @w_return             --LIM 16/NOV/2005
               goto ERROR                   --LIM 16/NOV/2005
            end 
            select @w_sub_sec=@w_sub_sec + 1
         end  /* while 3 */

         ------------------------------------------
         -- Contabilizacion por pago de renovacion
         ------------------------------------------
         if @w_sub_sec > 1 --Contabiliza el pago si existe movimiento
         begin
            select @w_codval = '36',   -- cambio tipo dato a varchar
                   @w_movmonet = '5', 
                   @w_descripcion='PAGO POR RENOVACION DE DPF ('+ @w_num_banco + ')'

            select @w_fecha = convert(datetime,convert(varchar,@s_date,101))

            exec @w_return = cob_pfijo..sp_aplica_conta
                 @s_ssn                 = @s_ssn,
                 @s_date                = @s_date,
                 @s_user                = @s_user,
                 @s_term                = @s_term,
                 @s_ofi                 = @w_oficina,
                 @t_debug               = @t_debug,
                 @t_file                = @t_file,
                 @t_from                = @t_from,
                 @t_trn                 = 14937,
                 @i_en_linea            = 'N',
                 @i_empresa             = 1,
                 @i_fecha               = @w_fecha,
                 @i_tran                = 14919,
                 @i_producto            = @w_producto,    -- op_producto de pf_operacion 
                 @i_toperacion          = @w_toperacion,  -- op_toperacion de pf_operacion 
                 @i_tplazo              = @w_tplazo,      -- op_tipo_plazo de pf_operacion 
                 @i_operacionpf         = @i_operacion,
                 @i_afectacion          = 'N',            -- N=Normal,  R=Reverso 
                 @i_codval              = @w_codval,      -- Codigo de valor para el detalle
                 @i_descripcion         = @w_descripcion,
                 @i_secuencia           = @w_secuencia_ren,
                 @i_estado              = @w_estado_ant,
                 @i_oficina_oper        = @w_oficina,     -- op_oficina de pf_operacion 
                 @i_oficina             = @w_oficina,     -- @s_ofi 
                 @i_moneda              = @i_moneda, 
                 @i_moneda_pg           = @w_moneda_pg, 
                 @i_valor               = @w_intren,
                 @i_impuesto            = @w_impuesto_ren,
                 @i_movmonet            = @w_movmonet, 
                 @i_forma_pago          = @w_fpago, 
                 @i_debcred             = '2'             -- Si es debito = 1 o credito = 2 

            if @w_return <> 0 and @w_return <> 9
            begin 
          select @w_mensaje = 'Error en sp_aplica_conta'             --LIM 16/NOV/2005
             select @w_error =  143041                   --LIM 16/NOV/2005
             goto ERROR                         --LIM 16/NOV/2005
            end
         end  -- if @w_sub_sec
      end 

         if @w_sub_sec > 0
            select @w_mon_sgte = @w_mon_sgte + 1

         if @w_fpago in ('ANT','PRA')  -- 13-Mar-2000 PRA
            select @w_total_int_pagado = @w_total_int_estimado 

         update pf_operacion 
            set op_estado              = @w_estado, 
                op_imprime             = @w_imprime, 
                op_total_int_acumulado = round(@w_total_int_acumulado ,@w_numdeci),   
                op_mon_sgte            = @w_mon_sgte, 
                op_total_int_retenido  = round(@w_impuesto,@w_numdeci),
                op_int_pagados         = round(@w_total_int_pagado,@w_numdeci),   
                op_int_ganado          = op_int_ganado - round(@w_total_int_pagado,@w_numdeci),       
                op_total_int_pagados   = round(@w_total_int_pagado,@w_numdeci),  
                op_int_estimado        = round(@w_int_estimado,@w_numdeci), 
                op_total_int_estimado  = round(@w_total_int_estimado, @w_numdeci),
                op_historia            = @w_historia,
                op_fecha_ven           = @w_fecha_ven, 
                op_fecha_mod           = convert(datetime,convert(varchar,@s_date,101)),
                op_fecha_valor         = convert(datetime,convert(varchar,@w_fecha_temp_hoy,101)),
                op_fecha_ult_pg_int    = convert(datetime,convert(varchar, @w_fecha_valor,101)),
                op_ult_fecha_calculo   = '01/01/1900',
                op_causa_mod           = 'CACT'
          where op_operacion = @w_operacionpf

         if @@error <> 0
         begin
       select @w_mensaje = 'Error en act. de la operacion'  --LIM 16/NOV/2005
          select @w_error =  145001                --LIM 16/NOV/2005
          goto ERROR                         --LIM 16/NOV/2005
         end

         -------------------------------------------
         -- Insercion de la transaccion de servicio
         -------------------------------------------
         insert ts_operacion (secuencial  , tipo_transaccion, clase         , usuario,
                              terminal    , srv             , lsrv          , fecha, 
                              num_banco   , mon_sgte        , operacion     , historia,
                              estado      , fecha_mod       , imprime       , causa_mod)
                      values (@s_ssn      , @t_trn          , 'P'           , @s_user,
                              @s_term     , @s_srv          , @s_lsrv       , @s_date,
                              @i_num_banco, @v_mon_sgte     , @w_operacionpf, @v_historia, 
                              @v_estado   , @v_fecha_mod    , 'N'           , @v_causa_mod)
         if @@error <> 0
         begin
       select @w_mensaje = 'Error en insercion de tran. de servicio' --LIM 16/NOV/2005
          select @w_error =  143005                --LIM 16/NOV/2005
          goto ERROR 
         end

         -------------------------------------------------
         -- Insercion transaccion de servicio actualizado
         -------------------------------------------------
         insert ts_operacion (secuencial  , tipo_transaccion, clase         , usuario,
                              terminal    , srv             , lsrv          , fecha,
                              num_banco   , mon_sgte        , operacion     , historia,
                              estado      , fecha_mod       , imprime       , causa_mod)
                      values (@s_ssn      , @t_trn          , 'A'           , @s_user,
                              @s_term     , @s_srv          , @s_lsrv       , @s_date,
                              @i_num_banco, @w_mon_sgte     , @w_operacionpf, @w_historia,
                              @w_estado   , @s_date         , @w_imprime    , 'CACT') 

         if @@error <> 0
         begin
            select @w_mensaje = 'Error en insercion de tran. de servicio'  --LIM 16/NOV/2005
          select @w_error =  143005                --LIM 16/NOV/2005
          goto ERROR                         --LIM 16/NOV/2005
         end

         --------------------------
         -- Insercion de Historico
         --------------------------
         insert pf_historia (hi_operacion   , hi_secuencial , hi_fecha  , hi_trn_code,
                             hi_valor       , hi_funcionario, hi_oficina, hi_observacion,
                             hi_fecha_crea  , hi_fecha_mod) 
                     values (@w_operacionpf , @v_historia   , @s_date   , @t_trn,
                             @w_monto_pg_int, @s_user       , @s_ofi    , 'Confirmacion de depositos',
                             @s_date        , @s_date)
         if @@error <> 0
         begin
       select @w_mensaje = 'Error en insercion del historico'     --LIM 16/NOV/2005
          select @w_error =  143006                --LIM 16/NOV/2005
            goto ERROR                       --LIM 16/NOV/2005
         end
   
         ----------------------------------------------------------------------  
         -- Ejecucion de pago de intereses para la operacion a la fecha de hoy 
         -- Provisiono los intereses cuando es fecha retroactiva 
         ----------------------------------------------------------------------
         if @w_tipo = 'C'
         begin
            if @w_anio_comercial = 'N'
            begin
               select @w_dias = datediff(dd,@w_fecha_temp_hoy,@w_fecha_hoy)
            end
            else
            begin
               exec sp_funcion_1 
                  @i_operacion = 'DIFE30',
                  @i_fechai   = @w_fecha_temp_hoy,
                  @i_fechaf   = @w_fecha_hoy,
                  @i_dia_pago = @w_dia_pago, --*-*                    
                  @o_dias     = @w_dias out            
            end   

            if @w_dias > 0
            begin
               exec @w_return = sp_calc_diario_int
                    @s_ssn           = @s_ssn,
                    @s_user          = @s_user,
                    @s_ofi           = @s_ofi, 
                    @s_date          = @s_date,
                    @s_srv           = @s_srv,
                    @s_lsrv          = @s_lsrv,
                    @s_term          = @s_term,
                    @s_rol           = @s_rol,
                    @t_debug         = @t_debug,
                    @t_file          = @t_file,
                    @t_from          = @t_from,
                    @t_trn           = 14926,  
                    @i_fecha_proceso = @w_fecha_temp_hoy,
                    @i_num_banco     = @i_num_banco ,
                    @i_tipo_act      = 'R',
                    @i_dias_interes  = @w_dias

               if @w_return <> 0
               begin
        select @w_mensaje = 'Error en sp_calc_diario_int'      --LIM 16/NOV/2005
           select @w_error =  149015               --LIM 16/NOV/2005
           goto ERROR                     --LIM 16/NOV/2005
               end 
            end
         end
      
   commit tran
end  /* fin de if de que es el dia de activacion */
return 0

ERROR:

   if  @w_rollback = 'S'                  --LIM 16/NOV/2005
      rollback tran

   exec  sp_errorlog                      --LIM 16/NOV/2005
         @i_fecha   = @s_date,
         @s_date    = @s_date,
         @i_error   = @w_error, 
         @i_usuario = @s_user,
         @i_tran    = @t_trn,
         @i_cuenta  = @w_num_banco,
         @i_cta_pagrec = @w_mensaje, 
         @i_descripcion = @w_sp_name

   return @w_error
go


