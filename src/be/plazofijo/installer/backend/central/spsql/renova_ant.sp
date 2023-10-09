/************************************************************************/
/*      Archivo:                renoant.sp                              */
/*      Stored procedure:       sp_renova_ant                           */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 21-Sep-95                               */
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
/*      Este programa mueve realiza todas las operaciones sobre el      */
/*      deposito anterior , si es renovacion de vencida o es una        */
/*      instruccion de renovacion que llega a su fecha de vencimiento.  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA         AUTOR              RAZON                       */
/*      06-Jun-2000  Ricardo Alvarez     Eliminar llamadas a sp_round   */
/*      19-Oct-2001  N. Silva            Correcciones Bench Mark        */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_renova_ant')
   drop proc sp_renova_ant
go

create proc sp_renova_ant (
      @s_ssn                  int             = NULL,
      @s_ssn_branch           int             = NULL,
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
      @i_en_linea             char(1)         = 'S',
      @i_fecha_proceso        datetime        = NULL,
      @i_inicio               int             = NULL,
      @i_fin                  int             = NULL,
      @i_alt                  int             = NULL,
      @o_retiene_imp_capital  char(1)     out,
      @o_impuesto_capital     money       out,
      @o_historia             int         out
)
with encryption
as
declare @w_sp_name                      varchar(32),
        @w_string                       varchar(30),
        @w_descripcion                  descripcion,
        @w_return                       int,
        @w_comentario                   varchar(32),
        @w_siguiente                    int,
        @w_error                        int,
        @w_secuencial                   int,
        @w_secuencia                    int,
        @w_secuencia_n                  int,
        @w_sec                          int,
        @w_ofi_ing                      int,
        @w_money                        money,
        @w_monto_renovar                money,
        @w_monto_capital                money,
        @w_monto_cierre                 money,
        @w_impuesto                     money,
        @w_impuest                      money,
        @w_impvenc                      money,
        @w_incremento                   money,
        @w_moneda                       tinyint,
        @w_total_monet                  money,
   @w_activa                    char(1),
   @w_retieneimp                char(1),
   @w_normal                    char(1),
   @w_tipo                      char(1),
   @w_fecha_hoy         datetime,
   @w_tasa           float,
   @w_tasa1       float,
   @w_producto       catalogo,
   @w_codval         tinyint,
   @w_p_producto        tinyint,
   @w_ch1                  catalogo,
   @w_cuenta         cuenta,
        @w_numdeci                      tinyint,
        @w_usadeci                      char(1),
        @w_moneda_base                  tinyint,
   @w_fpago_ticket         int,

/*  Variables para la operacion anterior en Renovacion */
   @w_p_operacionpf       int,
        @w_p_historia                     smallint,
        @w_p_renovaciones                 smallint,
        @w_p_monto_pg_int                 money,
        @w_p_mon_sgte                     smallint,
        @w_p_estado                       catalogo,
        @w_p_causa_mod                    catalogo,
        @w_p_fecha_mod                    datetime,
   @w_renova_todo         char (1),
        @w_estado                         catalogo,
        @w_causa_mod                      catalogo,
        @w_historia                       smallint,
   @w_total_int_acumulado       money ,
   @w_total_int_ganado          money ,
   @w_total_int_estimado        money ,
   @w_total_int_pagado          money ,
   @w_int_renovar         money,
        @w_int_renov                      money,
   @w_int_vencido         money,
   @w_int_ven          money,
   @w_int_ren          money,
   @w_toperacion          catalogo,
   @w_tplazo              catalogo,
   @w_oficina             smallint,
   @w_int_ganado          money,
        @w_retiene_imp_capital            char(1),
        @w_p_fecha_valor                  datetime,
        @w_p_num_dias                     smallint,
        @w_impuesto_capital               money,
        @w_tasa_imp_capital               float,
        @w_dias_hasta_dic                 smallint,
        @w_plazo                          int,
        @w_ente                           int,
        @w_dias_calculo                   int,
        @w_cotizacion                     float,
        @w_monto_cierre_ext               money,
        @w_op_int_total_prov_vencida      money,     -- Back Value
        @w_re_fecha_valor                 datetime,   -- Fecha Real de Renovacion
        @w_re_spread                      float,
   @w_re_fecha_crea                  datetime,
   @w_incremento_suspenso     money,
   @w_susp           money,
   @w_p_tasa         float,      --ccr tasa anterior a al renovacion
   @w_desc_aux       descripcion,
   @w_re_operador_fijo     char(1),
        @w_tot_dism_inc       money,      --LIM 05/DIC/2005
   @w_trn            smallint,   --LIM 05/DIC/2005
        @w_cont            tinyint,    --LIM 05/DIC/2005
        @w_max_sec                      int


/*---------------------------------*/
/* Verificar codigo de transaccion */
/*---------------------------------*/
if   @t_trn <> 14919
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 141112
   return 141112
end

-------------------------------
-- Inicializacion de variables
-------------------------------
select @w_sp_name    = 'sp_renova_ant',
       @w_secuencial = @s_ssn,
       @w_impuesto   = 0,
       @w_impvenc    = 0,
       @w_ofi_ing    = @s_ofi,
       @w_int_ven    = 0

-----------------------------
-- Moneda Base 26-Jun-2002
-----------------------------
select @w_moneda_base = em_moneda_base
    from cob_conta..cb_empresa
   where em_empresa = 1

if @i_fecha_proceso IS   NULL
   select @i_fecha_proceso = @s_date

select @w_fecha_hoy = @i_fecha_proceso
select @w_p_operacionpf             = op_operacion,
       @w_p_monto_pg_int            = op_monto,
       @w_p_historia                = op_historia,
       @w_p_renovaciones            = op_renovaciones,
       @w_p_mon_sgte                = op_mon_sgte,
       @w_p_causa_mod               = op_causa_mod,
       @w_retieneimp                = op_retienimp,
       @w_p_producto                = op_producto,
       @w_p_fecha_mod               = op_fecha_mod,
       @w_renova_todo               = op_renova_todo,
       @w_total_int_acumulado       = op_total_int_acumulado,
       @w_total_int_ganado          = op_total_int_ganados,
       @w_total_int_estimado        = op_total_int_estimado,
       @w_total_int_pagado          = op_total_int_pagados,
       @w_moneda              = op_moneda,
       @w_toperacion             = op_toperacion,
       @w_oficina             = op_oficina,
       @w_tplazo              = op_tipo_plazo,
       @w_int_ganado             = op_int_ganado,
       @w_p_estado                  = op_estado,
       @w_p_fecha_valor             = op_fecha_valor,
       @w_p_num_dias                = op_num_dias,
       @w_op_int_total_prov_vencida = op_int_total_prov_vencida,
   @w_incremento_suspenso     = isnull(op_incremento_suspenso, 0),
   @w_p_tasa         = op_tasa   --CCR tasa anterior a la renovacion
  from pf_operacion
 where op_num_banco        = @i_cuenta
   and op_operacion >= @i_inicio
   and op_operacion <= @i_fin

if @@rowcount = 0
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 141051
   return 141051
end

------------------------------------
-- Encuentra parametro de decimales
------------------------------------
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

select @w_secuencia   = @w_p_mon_sgte,
       @w_secuencia_n = @w_p_mon_sgte,
       @w_sec         = @w_secuencia - 1,
       @w_estado      = 'REN',
       @w_int_vencido = 0,
       @w_historia    = @w_p_historia + 1

if @w_p_estado = 'ACT'
   select @w_normal     ='S',
     @w_causa_mod  ='TVEN', @w_codval = 1

if @w_p_estado = 'VEN'
   select @w_normal     ='N',
     @w_causa_mod  ='VEN', @w_codval = 38

select  @w_int_vencido    = re_int_vencido,
        @w_incremento     = re_incremento,
        @w_tasa1          = re_tasa,
        @w_re_fecha_valor = re_fecha_valor,
        @w_re_spread      = re_spread_fijo,
        @w_re_fecha_crea  = re_fecha_crea,  --CVA Oct-04-05
   @w_re_operador_fijo  = re_operador_fijo
  from pf_renovacion
 where re_operacion= @w_p_operacionpf
   and re_estado = 'I'
if @@rowcount = 0
begin
   if @i_en_linea = 'S'
   begin
      exec cobis..sp_cerror
            @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_num       = 141138
      return 141138
   end
   else
   begin
   select @w_error = 141138
   goto ERROR
   end
end

   -----------------------------------------------------------------------------
   -- Si no se ha efectuado el incremento de la instruccion
   -- si es con Cheques o Efectivo.
   -----------------------------------------------------------------------------
        if @i_en_linea = 'N'
        begin

      --CCR se busca en pf_mov_monet la existencia de valores en suspenso para
      --comparar con op_incremento_suspenso
      select @w_susp = 0

      select @w_susp = sum(mm_valor)
      from pf_mov_monet
      where mm_tran     = 14904
      and   mm_producto = 'SUSP'
      and   mm_estado is null
      and   mm_operacion   = @w_p_operacionpf
      and   mm_valor <> 0
      and   mm_secuencia   = (select max(mm_secuencia)
                  from pf_mov_monet
                  where mm_operacion   = @w_p_operacionpf
                  and mm_tran    = 14904
                  and mm_estado      is null
                  and mm_valor      <> 0
                  and mm_producto      = 'SUSP')

      select @w_susp = isnull(@w_susp, 0)

      if @w_incremento_suspenso < @w_susp
         select @w_incremento = 0

   end

      if @w_incremento < 0
            select @w_monto_cierre=@w_p_monto_pg_int + @w_incremento
      else
            select @w_monto_cierre= @w_p_monto_pg_int

   ------------------------------------------------------------------------
   -- Se aumenta condicion para moneda extranjera
   ------------------------------------------------------------------------
   set rowcount 1
   select @w_cotizacion = co_conta
     from cob_pfijo..pf_cotizacion
    where co_moneda = @w_moneda
    order by co_hora desc
   set rowcount 0
   if @w_moneda = @w_moneda_base
      select @w_monto_cierre_ext = 0
   else
      select @w_monto_cierre_ext = @w_monto_cierre,
             @w_monto_cierre     = @w_monto_cierre * @w_cotizacion

   select @w_monto_cierre = round(@w_monto_cierre, @w_numdeci)

   insert pf_mov_monet(mm_operacion    , mm_tran        , mm_secuencia       , mm_sub_secuencia, mm_producto,
                       mm_cuenta       , mm_valor       , mm_valor_ext       , mm_fecha_crea   , mm_fecha_mod,
                       mm_tipo         , mm_secuencial  , mm_fecha_aplicacion, mm_estado       , mm_moneda,
                       mm_usuario      , mm_fecha_valor)
                values(@w_p_operacionpf, @t_trn         , @w_secuencia       , 1               , 'REN',
                       @i_cuenta       , @w_monto_cierre, @w_monto_cierre_ext, @s_date         , @s_date,
                       'I'             , 0              , NULL               , NULL            , @w_moneda,
                       @s_user         , @s_date)
   if @@error <> 0
   begin
      select @w_error = 143022
      goto ERROR
   end

   exec @w_return = sp_aplica_mov
        @s_ssn           = @s_ssn,
        @s_ssn_branch    = @s_ssn_branch,
        @s_user          = @s_user,
        @s_ofi           = @s_ofi,
        @s_date          = @s_date,
        @s_srv           = @s_srv,
        @s_term          = @s_term,
        @t_file          = @t_file,
        @t_from          = @w_sp_name,
        @t_debug         = @t_debug,
        @t_trn           = @t_trn,
        @i_tipo          = 'N',
        @i_en_linea      = @i_en_linea,
        @i_operacionpf   = @w_p_operacionpf,
        @i_secuencia     = @w_secuencia,
        @i_sub_secuencia = 1,
        @i_alt           = @i_alt,
        @i_op_num_banco  = @i_cuenta
   if @w_return <> 0
   begin
      select @w_error = @w_return
      goto ERROR
   end

   --------------------------------------
   -- Reverso de intererses (Back Value)
   --------------------------------------
   if @w_re_fecha_valor < @s_date
   begin
      select @w_descripcion   = 'Reverso de Int. Renov por Back-Value (' + @i_cuenta + ')'

      exec @w_return = cob_pfijo..sp_aplica_conta
        @s_date         = @s_date,
        @s_user         = @s_user,
        @s_term         = @s_term,
        @s_ofi          = @s_ofi,
        @i_fecha        = @s_date,
        @i_tran         = 14926,
        @i_oficina_oper = @w_oficina,
        @i_tplazo       = @w_tplazo,
        @i_operacionpf  = @w_p_operacionpf,
        @i_valor        = @w_op_int_total_prov_vencida,
        @i_afectacion   = 'R',
        @i_descripcion  = @w_descripcion
   end
   if @w_return <> 0
   begin
     select @w_error =@w_return
     goto ERROR
   end

   select @w_int_renovar      = @w_total_int_estimado- @w_total_int_pagado,
          @w_total_int_pagado = @w_total_int_ganado,
          @w_tipo             = 'I'

   if @w_tasa1=0 and @w_renova_todo='S'
      select @w_int_renovar=@w_total_int_acumulado + @w_int_ganado,
        @w_total_int_acumulado=@w_int_renovar

   select @w_int_renovar = round(@w_int_renovar,@w_numdeci)
   if @w_retieneimp = 'S' and @w_int_renovar > 0
   begin
      select @w_tasa = pa_float
        from cobis..cl_parametro
       where pa_producto = 'PFI'
         and pa_nemonico = 'IMP'

      select @w_impuesto = (@w_int_renovar*@w_tasa/100)
   end  /* Si paga impuesto  */
   else
      select @w_impuesto = 0

   select @w_int_renovar=@w_int_renovar - @w_impuesto

   if @w_renova_todo='S'
      select @w_int_ren = @w_int_renovar
   else
      select @w_int_ren=0

   if @w_int_ren > 0
   begin
      select @w_secuencia = @w_secuencia + 1
      select @w_int_renov = round(@w_int_renovar, @w_numdeci)
      select @w_impuest = round(@w_impuesto, @w_numdeci)

      insert pf_mov_monet(mm_operacion    , mm_tran            , mm_secuencia , mm_sub_secuencia, mm_producto ,
                          mm_cuenta       , mm_valor           , mm_fecha_crea, mm_fecha_mod    , mm_tipo     ,
                          mm_secuencial   , mm_fecha_aplicacion, mm_estado    , mm_moneda       , mm_valor_ext,
                mm_impuesto     , mm_usuario         , mm_fecha_valor)
                   values(@w_p_operacionpf, @t_trn             , @w_secuencia , 1               , 'REN',
                          @i_cuenta       , @w_int_renov       , @s_date      , @s_date         , @w_tipo,
                          0               , NULL               , NULL         , @w_moneda       , @w_int_renov,
                          @w_impuest      , @s_user            , @s_date)
      if @@error <> 0
      begin
         select @w_error = 143022
         goto ERROR
      end
      select @w_int_renovar=@w_int_renovar + @w_impuesto

      ------------------------------------------
      -- Insercion mov mon de cierre de interes
      ------------------------------------------

      exec @w_return = sp_aplica_mov
           @s_ssn           = @s_ssn,
            @s_ssn_branch    = @s_ssn_branch,
           @s_user          = @s_user,
           @s_ofi           = @s_ofi,
           @s_date          = @s_date,
           @s_srv           = @s_srv,
           @s_term          = @s_term,
           @t_file          = @t_file,
           @t_from          = @w_sp_name,
           @t_debug         = @t_debug,
           @t_trn           = @t_trn,
           @i_tipo          = 'N',
           @i_en_linea      = @i_en_linea,
           @i_operacionpf   = @w_p_operacionpf,
           @i_secuencia     = @w_secuencia,
      @i_sub_secuencia = 1,
           @i_alt           = @i_alt,
           @i_op_num_banco  = @i_cuenta
      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end /* int a renovar > 0 */

   if @w_int_vencido > 0
   begin
      if @w_retieneimp = 'S'
      begin
         select @w_tasa = pa_float from cobis..cl_parametro
          where pa_producto = 'PFI'
            and pa_nemonico = 'IMP'

         select @w_impvenc  = (@w_int_vencido*@w_tasa/100)
   end
   else
      select @w_impvenc = 0

   if @w_renova_todo='S'
      select @w_int_ven=@w_int_vencido - @w_impvenc
   else
      select @w_int_ven=0
   end
   select @w_impuesto = @w_impuesto + @w_impvenc

   --------------------------------------------------------------------------------
   -- Calculo del impuesto sobre el capital para la nueva operacion
   -- Se lee de la pf_renovacion si retiene imp.sobre el capital.
   --------------------------------------------------------------------------------
   select @w_retiene_imp_capital = re_retiene_imp_capital,
          @w_plazo               = re_plazo
     from pf_renovacion
    where re_operacion = @w_p_operacionpf
      and re_estado = 'I'

   if @@rowcount = 0
   begin
      select @w_error = 141056
      goto ERROR
   end

   if @w_retiene_imp_capital = 'S'
   begin
      select @w_tasa_imp_capital = pa_float
        from cobis..cl_parametro
       where pa_nemonico = 'IMC'
         and pa_producto = 'PFI'

      if @@rowcount = 0
      begin
         select @w_error = 141140
         goto ERROR
      end

      if @w_plazo > 360
         select @w_dias_calculo = 360
      else
        select @w_dias_calculo = @w_plazo

      select @w_impuesto_capital = (@w_p_monto_pg_int+@w_int_ren + @w_int_ven) * @w_tasa_imp_capital / 36000 * @w_dias_calculo
      select @w_impuesto_capital = round(@w_impuesto_capital, @w_numdeci)
   end
   else
      select @w_impuesto_capital = 0

   select @o_retiene_imp_capital = @w_retiene_imp_capital
   select @o_impuesto_capital = @w_impuesto_capital
   select @w_monto_renovar = @w_p_monto_pg_int + @w_int_ren + isnull(@w_int_ven,0) - @w_impuesto_capital
   select @w_monto_renovar = round(@w_monto_renovar,@w_numdeci)

   update pf_renovacion
      set re_monto_renovar = @w_monto_renovar
    where re_operacion = @w_p_operacionpf
      and re_estado = 'I'
   if @@error  <> 0
   begin
      select @w_error = 145001
      goto ERROR
   end

   select @w_monto_renovar = @w_monto_renovar

select @w_tot_dism_inc = isnull(sum(mm_valor),0)
 from pf_mov_monet
where mm_operacion  = @w_p_operacionpf
  and mm_tran       = 14904
  and mm_fecha_crea = (select max(mm_fecha_crea)
            from pf_mov_monet
            where mm_operacion  = @w_p_operacionpf
            and   mm_tran       = 14904
                                and   mm_estado     is null)
  and mm_estado     is null

--CVA Dic-21-05 Para instrucciones de renovacion que tome la secuencia del ultimo
--              movimiento por 14904
select @w_secuencia_n = mm_secuencia
 from pf_mov_monet
where mm_operacion  = @w_p_operacionpf
  and mm_tran       = 14904
  and mm_fecha_crea = (select max(mm_fecha_crea)
            from pf_mov_monet
            where mm_operacion  = @w_p_operacionpf
            and   mm_tran       = 14904
                                and   mm_estado     is null)
  and mm_estado     is null

   ---------------------------
   -- Insercion del Historial
   ---------------------------
select @w_desc_aux   = convert(varchar, @w_re_operador_fijo) + convert(varchar, @w_re_spread)
select @w_trn     = @t_trn,
       @w_cont       = 1,
       @w_monto_capital = 0

--CVA Dic-21-05 Para instrucciones de renovacion
while @w_cont <=  2
begin
   insert pf_historia (hi_operacion    , hi_secuencial, hi_fecha     , hi_trn_code,   hi_valor,
                       hi_funcionario  , hi_oficina   , hi_fecha_crea, hi_fecha_mod , hi_tasa,
                       hi_observacion  , hi_secuencia , hi_saldo_capital)     --LIM 05/DIC/2005
               values (@w_p_operacionpf, @w_p_historia, @s_date      , @w_trn,        @w_monto_renovar,     --LIM 05/DIC/2005
                       @s_user         , @s_ofi       , @s_date      , @s_date,      @w_p_tasa,
                       @w_desc_aux     , @w_secuencia , @w_monto_capital)     --LIM 05/DIC/2005
   if @@error <> 0
   begin
      select @w_error = 143006
      goto ERROR
   end

   if @w_cont = 1
      select @o_historia = @w_p_historia

   if abs(@w_tot_dism_inc) > 0               --LIM 05/DIC/2005
      select @w_p_historia    = @w_p_historia + 1,
             @w_historia   = @w_p_historia,
             @w_trn     = 14904,
             @w_monto_capital   = @w_monto_renovar + @w_incremento,
             @w_monto_renovar    = @w_tot_dism_inc,
             @w_secuencia       = @w_secuencia_n      --LIM 22/DIC/2005
   else
      break

   select @w_cont = @w_cont + 1

end

   --CVA Oct-05-05 Actualizar el siguiente de historicos
   update pf_operacion
      set op_historia = @w_historia
   where op_operacion = @w_p_operacionpf
   if @@error <> 0
   begin
        select @w_error = 145001
        goto ERROR
   end

   -----------------------------------------------
   -- Insercion de transaccion de servicio previa
   -----------------------------------------------
   insert ts_operacion (secuencial   , tipo_transaccion, clase         , usuario  , terminal,
                        srv          , lsrv            , fecha         , num_banco, operacion,
                        historia     , estado          , causa_mod     , fecha_mod)
                values (@s_ssn       , @t_trn          , 'P'           , @s_user  , @s_term,
                        @s_srv       , @s_lsrv         , @s_date       , @i_cuenta, @w_p_operacionpf,
                        @w_p_historia, @w_p_estado     , @w_p_causa_mod, @w_p_fecha_mod)
   if @@error <> 0
   begin
      select @w_error = 143005
      goto ERROR
   end

   ------------------------------------------------------
   -- Insercion de transaccion de servicio actualizacion
   ------------------------------------------------------
   insert ts_operacion (secuencial , tipo_transaccion, clase       , usuario  , terminal,
                        srv        , lsrv            , fecha       , num_banco, operacion,
                        historia   , estado          , causa_mod   , fecha_mod)
                values (@s_ssn     , @t_trn          , 'A'         , @s_user  , @s_term  ,
                        @s_srv     , @s_lsrv         , @s_date     , @i_cuenta, @w_p_operacionpf,
                        @w_historia, @w_estado       , @w_causa_mod, @s_date)
   if @@error <> 0
   begin
      select @w_error = 143005
      goto ERROR
   end

return 0

-------------------
-- Manejo de Error
-------------------
ERROR:

  if @i_en_linea = 'N' --Instrucciones de Renovacion
  begin
   update pf_renovacion
      set re_estado = 'X'
     where re_operacion= @w_p_operacionpf

   update pf_operacion
      set op_accion_sgte = 'NULL',
          op_causa_mod   = 'NULL'
   where op_operacion = @w_p_operacionpf

   set rowcount 0

   delete from pf_rubro_op_tmp where rot_operacion = @w_p_operacionpf
  end

  return @w_error
go

