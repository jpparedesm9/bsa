/**************************************************************************/
/*      Archivo:                consoper.sp                               */
/*      Stored procedure:       sp_consulta_oper                          */
/*      Base de datos:          cobis                                     */
/*      Producto:               Plazo Fijo                                */
/*      Disenado por:           Myriam Davila                             */
/*      Fecha de documentacion: 21-Nov-1994                               */
/**************************************************************************/
/*                              IMPORTANTE                                */
/*      Este programa es parte de los paquetes bancarios propiedad de     */
/*      'MACOSA', representantes exclusivos para el Ecuador de la         */
/*      'NCR CORPORATION'.                                                */
/*      Su uso no autorizado queda expresamente prohibido asi como        */
/*      cualquier alteracion o agregado hecho por alguno de sus           */
/*      usuarios sin el debido consentimiento por escrito de la           */
/*      Presidencia Ejecutiva de MACOSA o su representante.               */
/**************************************************************************/
/*                              PROPOSITO                                 */
/*      Este programa procesa las transacciones de QUERY a la tabla       */
/*      de operaciones 'pf_operacion' retornando el registro completo     */
/*      con todas las descripciones de las tablas foraneas 'cl_ente',     */
/*      'cl_oficina', 'cl_funcionario', 'cl_producto', 'cl_moneda',       */
/*      'cl_tabla', 'cl_catalogo' y 'pf_ppago',pf_tipo_deposito           */
/**************************************************************************/
/*                              MODIFICACIONES                            */
/*      FECHA         AUTOR              RAZON                            */
/*      25-Oct-01     N. Silva           Cambios y Correcciones BMK       */
/*      14-Abr-2005   G. Arboleda        Bloqueo Legal                    */
/*      2005/10/05    Carlos Cruz D.     Se devuelve el valor de          */
/*                                       la sucursal para reten-          */
/*                                       cion de correspondencia          */
/*      15-Oct-2005   Luis Im            Monto Bloqueo legal              */
/*      03-Ago-06     Ricardo Ramos      Adicionar campo de fideicomiso   */
/*      03/16/2007    Ricardo Ramos      Colocar int.pagados del op_monto */
/*      22/Jul/2009   Y. Martinez        NYM DPF00015 ICA                 */
/*      10/Ene/2017   J. Salazar         DPF-H94952 MANEJO RETENCIONES MX */
/**************************************************************************/

use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_consulta_oper') is not null
   drop proc sp_consulta_oper
go

create proc sp_consulta_oper (
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
      @t_trn                  smallint        = NULL,
      @i_operacion            char(1),
      @i_flag                 char(1)         ='N',
      @i_estado1              catalogo        ='%',
      @i_estado2              catalogo        ='%',
      @i_estado3              catalogo        ='%',
      @i_estado4              catalogo        ='%',
      @i_accion_sgte          catalogo        ='%',
      @i_cuenta               cuenta,
      @i_siguientes           char(1)         = 'N',
      @i_formato_fecha        int             = 101,
      @i_incremento           char(1)         = 'N',
      @i_revincre             char(1)         = 'N',
      @i_revcan               char(1)         = 'N',
      @i_tasa_var             char(1)         = '%',
      @i_flag_val_instruccion char(1)         = 'N',
      @i_flag_val_cambio_tasa char(1)         = 'N',   --ccr validar si se puede cambiar la tasa
      @i_flag_val_incre       char(1)         = 'N',   --ccr validar si se permiten incrementos/decrementos
      @i_flag_val_inact       char(1)         = 'S',
      @i_flag_per             char(1)         = 'N',
      @i_flag_val_tipo_deposito char(1)       = 'N',   --ccr validar si el tipo de deposito se encuentra habilitado
      @i_flag_pago              char(1)       = 'N'
)
with encryption
as
declare
      @w_sp_name                   varchar(32),
      @o_inactivo                  char(1),
      @o_num_banco                 cuenta,
      @o_cert_origen               cuenta,
      @o_fecha_cert_origen         datetime,
      @o_fecha_cert_origen_temp    datetime,
      @o_tasa_congelado            float,
      @o_num_banco_new             cuenta,
      @o_operacion                 int,
      @o_operacion_new             int,
      @o_ente                      int,
      @o_en_nombre_completo        varchar(254),
      @o_toperacion                catalogo,
      @o_desc_toperacion           descripcion,
      @o_categoria                 catalogo,
      @o_desc_categoria            descripcion,
      @o_producto                  tinyint,
      @o_pd_descripcion            descripcion,
      @o_oficina                   smallint,
      @o_ced_ruc                   varchar(35),
      @o_of_nombre                 descripcion,
      @o_moneda                    tinyint,
      @o_mo_descripcion            descripcion,
      @o_num_dias                  smallint,
      @o_dias_anio                 smallint,
      @o_monto                     money,
      @o_monto_pg_int              money,
      @o_moneda_pg                 char(2),
      @o_monto_pgdo                money,
      @o_monto_blq                 money,
      @o_tasa                      float,
      @o_meses                     tinyint,
      @o_int_ganado                money,
      @o_int_estimado              money,
      @w_total                     money,
      @o_int_pagados               money,
      @o_int_provision             money,
      @o_total_int_ganados         money,
      @o_total_int_pagados         money,
      @o_total_int_estimado        money,
      @o_total_int_retenido        money,
      @o_tcapitalizacion           char(1),
      @o_fpago                     char(3),
      @w_msg                       varchar(30),
      @o_ppago                     char(3),
      @o_pp_descripcion            descripcion,
      @o_dia_pago                  smallint,
      @o_historia                  smallint,
      @o_duplicados                tinyint,
      @o_renovaciones              smallint,
      @o_numdoc                    smallint,
      @o_estado                    catalogo,
      @o_pignorado                 char(1),
      @o_oficial                   login,
      @o_telefono                  varchar(8),
      @o_telefono2                 varchar(8),
      @o_direccion                 tinyint,
      @o_casilla                   tinyint,
      @o_cd_descripcion            descripcion,
      @o_fu_nombre                 descripcion,
      @o_descripcion               varchar(255),
      @o_accion_sgte               catalogo,
      @o_fecha_valor               datetime,
      @o_fecha_ven                 datetime,
      @o_fecha_can                 datetime,
      @o_fecha_pg_int              datetime,
      @o_fecha_ult_pg_int          datetime,
      @o_fecha_crea                datetime,
      @o_fecha_ult_calculo         datetime,
      @o_fecha_ing                 datetime,
      @o_dia_vencido               int,
      @o_ciudad                    descripcion,
      @o_preimpreso                int,
      @o_condicion2                char(1),
      @o_condicion3                char(1),
      @w_dia_vencido               int,
      @o_retienimp                 char(1),
      @o_impuesto                  money,
      @w_ente2                     int,
      @w_ente3                     int,
      @w_dias                      float,
      @o_fecha_mod                 datetime,
      @o_mantiene                  char(1),
      @o_alterno3                  char(30),
      @o_disponible                int,
      @o_factor_en_meses           tinyint,
      @o_alterno                   char(30),
      @o_num_imp_orig              tinyint,
      @o_dias_antes_impresion      tinyint,
      @o_impuesto_capital          money,
      @o_capital_pagado            money,
      @o_ley                       char(1),
      @o_fecha_cal_tasa            datetime,
      @w_operacion_reprog          int,
      @w_certificado_origen        int,
      @w_tasa_moneda               char(3),
      @o_anio_comercial            char(1),
      @o_tasa_variable             char(1),
      @o_tasa_efectiva             float,
      @o_flag_tasaefec             char(1),
      @o_total_int_acumulado       money,
      @o_tot_int_est_ant           money,
      @o_residuo                   float,
      @o_imprime                   char(1),
      @o_plazo_ant                 smallint,
      @o_fecven_ant                datetime,
      @o_fech_ord_act              datetime,
      @o_retenido                  char(1),
      @o_tipo_monto                catalogo,
      @o_tipo_plazo                catalogo,
      @o_estatus_prorroga          char(1),
      @o_num_prorroga              int,
      @o_mnemonico_tasavar         catalogo,
      @o_modalidad_tasa            char(1),
      @o_periodo_tasa              smallint,
      @o_operador                  char(1),
      @o_spread                    float,
      @o_puntos                    float,
      @o_desc_tasa_var             descripcion,
      @o_base_calculo              int,
      @o_op_causa_mod              char(4),
      @o_op_incremento             money,
      @o_tipo_tasa_var             char(1),
      @o_tv_spread_max             float,
      @o_tv_spread_min             float,
      @o_op_plazo_orig             int,
      @o_bloqueo_legal             char(1),
      @o_oficial_principal         login,
      @o_oficial_secundario        login,
      @o_ente_corresp              int, --GAR GB-DP00120
      @o_dias_reales               char(1), --GAR Dias Reales
      @o_fecha_ult_renov           datetime,
      @o_localizado                char(1),
      @o_fecha_localizacion        smalldatetime,
      @o_fecha_no_localiza         smalldatetime,
      @o_mo_mnemonico              catalogo,
      @o_sucursal                  smallint,
      @o_instruccion               descripcion, --CVA Oct-06-05
      @w_td_cambio_tasa            char(1),
      @w_incr_decr                 char(1),
      @o_monto_blqlegal            money,
      @o_fecha_ult_pago_int_ant    datetime,
      @o_nombre_oficial_principal  varchar(30),
      @o_nombre_oficial_secundario varchar(30),
      @w_msg_out                   varchar(255),      --LIM 01/NOV/2005
      @o_fecha_ult_inc_dism        varchar(10),     --LIM 09/NOV/2005
      @w_operacion                 int,       --LIM 09/NOV/2005
      @o_aprobado                  char(1),      --LIM 17/NOV/2005
      @o_tasa_base                 float,
      @o_fideicomiso               varchar(15),
   -- NYM DOF00015 ICA
      @w_return                    int,
      @w_total_aux                 money,
      @o_ret_ica                   char(1),
      @o_tasa_retencion            float,
      @o_tasa_ica                  float,
      @o_base_ret                  money,
      @o_base_ica                  money,
      @o_imp_ica                   money,
      @o_decimal_imp               tinyint,
        -- NYM DPF00015 ICA
      @o_desmaterializa            char(1)      --'ER DCVAL

select @w_sp_name        = 'sp_consulta_oper',
   @o_num_banco_new = null,
   @o_mantiene      = 'N',
   @o_disponible    = 0,
   @o_numdoc        = 0,
   @o_num_imp_orig  = 0

/*--------------------------------------------*/
/* Verificar codigo de transaccion para Query */
/*--------------------------------------------*/
if ( @i_operacion = 'Q' ) and ( @t_trn <> 14158 )
begin
   /**  ERROR : CODIGO DE TRANSACCION PARA QUERY NO VALIDO  **/
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141042
   return 141042
end

if @i_tasa_var is null
   select @i_tasa_var ='%'

---------------------------
-- Busqueda de operaciones
---------------------------
if @i_operacion = 'Q'
begin
   select @w_operacion = op_operacion              --LIM 09/NOV/2005
     from pf_operacion
    where op_num_banco = @i_cuenta

   select @o_fecha_ult_inc_dism = convert(varchar(10),max(mm_fecha_aplicacion),@i_formato_fecha)   --LIM 09/NOV/2005
                                      from pf_mov_monet
                                      where mm_operacion = @w_operacion
                                        and mm_tran in (14989,14990)
                                        and mm_estado = 'A'
   ---------------------------------------
   -- Lectura del registro de operaciones
   ---------------------------------------
   select @o_num_banco                  = op_num_banco,        /* 0 */
          @o_operacion                  = op_operacion,
          @o_ente                       = op_ente,
          @o_toperacion                 = op_toperacion,
          @o_categoria                  = op_categoria,
          @o_producto                   = op_producto,
          @o_oficina                    = op_oficina,
          @o_moneda                     = op_moneda,
          @o_num_dias                   = op_num_dias,
          @o_telefono                   = op_telefono,         /* 11 */
          @o_dias_anio                  = op_base_calculo,
          @o_monto                      = op_monto,
          @o_monto_pg_int               = op_monto,
          @o_monto_pgdo                 = op_monto_pgdo,
          @o_monto_blq                  = op_monto_blq,
          @o_tasa                       = op_tasa,
          @o_int_ganado                 = op_int_ganado,
          @o_int_estimado               = op_int_estimado,
          @o_int_pagados                = op_int_pagados,
          @o_int_provision              = op_int_provision,     /* 21 */
          @o_total_int_ganados          = op_total_int_ganados,
          @o_total_int_pagados          = op_total_int_pagados,
          @o_total_int_estimado         = op_total_int_estimado,
          @o_total_int_retenido         = op_total_int_retenido,
          @o_tcapitalizacion            = op_tcapitalizacion,
          @o_fpago                      = op_fpago,
          @o_ppago                      = op_ppago,
          @o_dia_pago                   = op_dia_pago,
          @o_direccion                  = op_direccion,
          @o_casilla                    = op_casilla,           /* 31 */
          @o_historia                   = op_historia,
          @o_duplicados                 = op_duplicados,
          @o_renovaciones               = op_renovaciones,
          @o_estado                     = op_estado,
          @o_pignorado                  = op_pignorado,
          @o_oficial                    = op_oficial,
          @o_descripcion                = op_descripcion,
          @o_fecha_ing                  = op_fecha_ingreso,
          @o_fecha_valor                = op_fecha_valor,
          @o_fecha_ven                  = op_fecha_ven,         /* 41 */
          @o_fecha_pg_int               = op_fecha_pg_int,
          @o_fecha_ult_pg_int           = op_fecha_ult_pg_int,
          @o_fecha_ult_calculo          = op_ult_fecha_calculo,
          @o_accion_sgte                = op_accion_sgte,
          @o_fecha_crea                 = op_fecha_crea,
          @o_retienimp                  = op_retienimp,
          @o_moneda_pg                  = op_moneda_pg,
          @o_fecha_mod                  = op_fecha_mod,
          @o_fecha_can                  = op_fecha_cancela,
          @o_preimpreso                 = op_preimpreso,        /* 51 */
          @o_num_imp_orig               = op_num_imp_orig ,
          @o_impuesto_capital           = op_impuesto_capital,
          @o_ley                        = op_ley,
          @o_fecha_cal_tasa             = op_ult_fecha_cal_tasa,
          @o_anio_comercial             = isnull(op_anio_comercial,'N'),
          @o_tasa_variable              = isnull(op_tasa_variable,'N'),
          @o_flag_tasaefec              = isnull(op_flag_tasaefec,'N'),
          @o_tasa_efectiva              = op_tasa_efectiva,
          @o_total_int_acumulado        = op_total_int_acumulado,
          @o_tot_int_est_ant            = op_tot_int_est_ant,   /* 61 */
          @o_residuo                    = op_residuo,
          @o_imprime                    = op_imprime,
          @o_plazo_ant                  = op_plazo_ant,
          @o_fecven_ant                 = op_fecven_ant,
          @o_fech_ord_act               = op_fecha_ord_act,
          @o_retenido                   = op_retenido,
          @o_tipo_monto                 = op_tipo_monto,
          @o_tipo_plazo                 = op_tipo_plazo,
          @o_estatus_prorroga           = op_estatus_prorroga,
          @o_num_prorroga               = op_num_prorroga,      /* 71 */
          @o_mnemonico_tasavar          = op_mnemonico_tasa,
          @o_modalidad_tasa             = op_modalidad_tasa,
          @o_periodo_tasa               = op_periodo_tasa,
          @o_operador                   = op_operador,
          @o_spread                     = op_spread,
          @o_desc_tasa_var              = op_descr_tasa,
          @o_puntos                     = op_puntos,
          @o_base_calculo               = op_base_calculo,     /* 79 */
          @o_op_causa_mod               = op_causa_mod,
          @o_op_incremento              = op_incremento,
          @o_tipo_tasa_var              = op_tipo_tasa_var,
          @o_op_plazo_orig              = op_plazo_orig,
          @o_bloqueo_legal              = op_bloqueo_legal,
          @o_oficial_principal          = op_oficial_principal,
          @o_oficial_secundario         = op_oficial_secundario,
          @o_ente_corresp               = op_ente_corresp, --GAR GB-DP00120
          @o_dias_reales                = op_dias_reales, --GAR Dias Reales
          @o_fecha_ult_renov            = op_fecha_ult_renov,
          @o_localizado                 = op_localizado,
          @o_fecha_localizacion         = op_fecha_localizacion,
          @o_fecha_no_localiza          = op_fecha_no_localiza,
          @o_inactivo                   = isnull(op_inactivo,'N'),
          @o_sucursal                   = op_sucursal,
          @o_monto_blqlegal             = op_monto_blqlegal,    --LIM DP00056
          @o_fecha_ult_pago_int_ant     = op_fecha_ult_pago_int_ant,
          @o_aprobado                   = op_aprobado,         --LIM 17/NOV/2005
          @o_tasa_base                  = op_tasa_mer,
          @o_fideicomiso                = op_fideicomiso,
          @o_desmaterializa             = op_desmaterializa    -- ER DCVAL

     from pf_operacion with (1)
    where op_num_banco          = @i_cuenta
      and op_tasa_variable      like @i_tasa_var

   /*  Verificar si se encontro la operacion */
   if @@rowcount = 0
   begin
      /**  ERROR : NO EXISTE OPERACION  **/
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141051
      return 141051
   end
   else
   begin
      if @o_fpago in ('PER','PRA') -- 13-Mar-2000 PRA
      begin
         select @o_factor_en_meses = pp_factor_en_meses
           from pf_ppago
          where rtrim(pp_codigo) = rtrim(@o_ppago)
      end
   end

   if @i_flag_per = 'S'             --LIM 07/FEB/2006
      select @i_accion_sgte = @o_accion_sgte


   --CVA Oct-28-06 Verificar el pago pendiente del batch
   if @i_flag_pago = 'S'
   begin
        if exists(select op_operacion from pf_operacion
        where op_num_banco = @o_num_banco
               and isnull(op_pago_interes,'S') = 'N')
   begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141220
         return 141220
   end
   end



   if @i_flag = 'S'
   begin
      if exists(select * from pf_tipo_deposito
                 where td_mnemonico = @o_toperacion
                   and td_mantiene_stock = 'S')
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141149
         return 1
      end
   end

   if @i_flag='N'
   begin
      select @o_mantiene = td_mantiene_stock,
             @o_disponible = td_stock
        from pf_tipo_deposito
       where td_mantiene_stock = 'S'
         and td_mnemonico = @o_toperacion
      if @o_mantiene = 'S'
         select @o_numdoc = ( select count(*)
                                from pf_det_lote
                               where dl_lote = @i_cuenta )
   end
--print 'estado1: %1! - estado2: %2! - estado3: %3! - op_causa_mod: %4!', @i_estado1, @i_estado2, @i_estado3, @o_op_causa_mod
   if not ((@o_estado like @i_estado1 )
            or (@o_estado like @i_estado2  and @o_accion_sgte like @i_accion_sgte)
       or (@o_estado like @i_estado4 )        --CVA Ago-07-06
            or ( @o_estado like @i_estado3 )) and @o_op_causa_mod <> 'CANP'
            --or ( @o_estado like @i_estado3 )) and @i_incremento <> 'S' and @o_op_causa_mod <> 'CANP'
   begin
      if @o_accion_sgte = 'XREN'                         --LIM 01/NOV/2005
         select @w_msg_out = 'Operacion no permitida, el deposito tiene instruccion de renovacion'
      else
         if @o_estado <> @i_estado2 and @o_estado = 'CAN'
            select @w_msg_out = 'Deposito no permite Mantenimientos por estar cancelado'
         else
            if @o_accion_sgte = 'XCAN'                         --LIM 01/NOV/2005
               select @w_msg_out = 'Operacion no permitida, el deposito tiene instruccion de cancelacion'
            else
                                 if @o_aprobado = 'N'    --LIM 17/NOV/2005
                  select @w_msg_out = 'Operacion no permitida, el deposito no ha sido aprobado'
                                        else
                  if (@o_aprobado = 'S') and (@o_estado ='ING' or @o_estado = 'XACT')  --LIM 17/NOV/2005                --LIM 17/NOV/2005
                              select @w_msg_out = 'Operacion no permitida, el deposito no ha sido activado'
                  else
                     select @w_msg_out = 'Operacion o transaccion no permitida'
      select @w_msg_out = '[' + @w_sp_name +'] ' + @w_msg_out
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141112,
         @i_msg   = @w_msg_out      --LIM 01/NOV/2005
      return 141112
   end

   if @i_flag_per = 'S' and @o_fpago = 'VEN'
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_msg   = 'Transaccion no permitida. Operacion es de frecuencia al vencimiento',
           @i_num   = 141051
      return 141051

   end

   /**********************************************************
   CCR Validar que el tipo de deposito se encuentre habilitado
   **********************************************************/
   if @i_flag_val_tipo_deposito ='S'
   begin
      if not exists  (select 1 from pf_tipo_deposito
            where td_mnemonico   = @o_toperacion
            and   td_estado   = 'A')
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 141212
         return 141212
      end
   end
   /*********FIN CCR Val tipo deposito habilitado************/

   /*********************************************************
      CCR VALIDAR QUE NO SE PUEDA CANCELAR, INCREMENTAR, DISMINUIR, MANTENER UN DPF
      QUE TIENE UNA INSTRUCCION DE CANCELACION/RENOVACION
   *********************************************************/
   if @i_flag_val_instruccion = 'S'
   begin
      if isnull(@o_accion_sgte, 'NULL') is null
      begin
         exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141191
         return 141191
      end
   end

   /******************************************************************
   CCR VALIDAR QUE NO SE PUEDA HACER AUTORIZACION DE SPREAD SI EL TIPO
   DE DEPOSITO POSEE CAMBIO DE TASA (NO)
   ******************************************************************/
   if @i_flag_val_cambio_tasa = 'S'
   begin
      select   @w_td_cambio_tasa = td_cambio_tasa
      from  pf_tipo_deposito
      where td_mnemonico      = @o_toperacion
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 141115
         return 141115
      end

      if @w_td_cambio_tasa = 'N'
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 149080
         return 149080
      end
   end

   /******************************************************************
   CCR VALIDAR QUE NO SE PUEDA HACER INCREMENTOS/DECREMENTOS SI EL TIPO
   DE DEPOSITO POSEE INCREMENTOS/DECREMENTOS (NO)
   ******************************************************************/
   if @i_flag_val_incre = 'S'
   begin
      select   @w_incr_decr   =td_incr_decr
      from  pf_tipo_deposito
      where td_mnemonico      = @o_toperacion
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 141115
         return 141115
      end

      if @w_incr_decr = 'N'
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 149096
         return 149096
      end
   end

   /******************************************************************
   VALIDAR QUE LA OPERACION NO SE ENCUENTRA INACTIVA. ESTA VALIDACION
   SE REALIZARA SI EL PARAMETRO @i_flag_val_inact = 'S'
   ******************************************************************/
   if @i_flag_val_inact = 'S' and @o_estado <> 'ACT' --@o_inactivo = 'S'
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file     = @t_file,
         @t_from     = @w_sp_name,
         @i_num      = 149097
      return 149097
   end

   ------------------------------------------------------------------
   -- Lectura de los registros relacionados el registro de operacion
   ------------------------------------------------------------------
   select @o_en_nombre_completo = isnull(en_nomlar,en_nombre + p_p_apellido  + p_s_apellido),
     @o_ced_ruc = en_ced_ruc
     from cobis..cl_ente
    where en_ente           = @o_ente
   select @o_of_nombre      = of_nombre,
          @o_ciudad         = ci_descripcion
     from cobis..cl_oficina, cobis..cl_ciudad
    where of_oficina = @o_oficina
      and of_ciudad = ci_ciudad
   select @o_mo_descripcion = mo_descripcion,
          @o_mo_mnemonico   = '' --mo_nemonico
     from cobis..cl_moneda
    where mo_moneda         = @o_moneda
   select @o_pp_descripcion = pp_descripcion,
          @o_meses = pp_factor_en_meses
     from pf_ppago
    where rtrim(pp_codigo)         = rtrim(@o_ppago)

   select @o_fu_nombre      = fu_nombre
     from cobis..cl_funcionario
    where fu_login          = @o_oficial

   select @o_desc_toperacion = td_descripcion
     from pf_tipo_deposito
    where @o_toperacion = td_mnemonico

   select @o_desc_categoria = y.valor
     from cobis..cl_tabla    x,
          cobis..cl_catalogo y,
          pf_operacion
    where x.tabla  = 'pf_categoria'
      and x.codigo = y.tabla
      and y.codigo = @o_categoria

   if @o_direccion  IS NOT null
      select @o_cd_descripcion = di_descripcion
        from cobis..cl_direccion
       where di_ente = @o_ente
         and di_direccion  = @o_direccion
   else
      if @o_casilla IS NOT null
         select @o_cd_descripcion = cs_valor
           from cobis..cl_casilla
          where cs_ente = @o_ente
            and cs_casilla  = @o_casilla
      else
         select @o_cd_descripcion = of_nombre
   from cobis..cl_oficina
   where of_oficina = @o_sucursal

   select @w_dia_vencido = datediff(dd,@s_date,@o_fecha_ven)

   if @w_dia_vencido >=0
      select @o_dia_vencido = 0
   else
      select @o_dia_vencido = -@w_dia_vencido


   if @o_fpago = 'VEN'
      if @o_total_int_ganados = 0 and @o_total_int_pagados = 0
         select @w_total = @o_total_int_estimado  - @o_total_int_pagados
      else
         select @w_total = @o_total_int_ganados  - @o_total_int_pagados

   if @o_fpago in ('ANT','PRA')  -- 13-Mar-2000 PRA
      select @w_total = @o_total_int_ganados  - @o_total_int_estimado
   if @o_fpago = 'PER'
      if @o_int_ganado = 0 and @o_int_pagados = 0
         select @w_total = @o_int_estimado  - @o_int_pagados
      else
         select @w_total = @o_int_ganado - @o_int_pagados --xca 04/17/98


   --INI NYM DPF00015 ICA
   exec @w_return = sp_aplica_impuestos
   @s_ofi              = @s_ofi,
   @t_debug            = @t_debug,
   @i_ente             = @o_ente,
   @i_plazo            = @o_num_dias,
   @i_capital          = @o_monto_pg_int,
   @i_interes          = @w_total,
   @i_base_calculo     = @o_dias_anio,
   @o_retienimp        = @o_retienimp      out,
   @o_tasa_retencion   = @o_tasa_retencion out,
   @o_valor_retencion  = @o_impuesto       out

   if @w_return <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = @w_return
      return @w_return
   end

   --------------------
   -- Envio de Valores
   --------------------
   select @w_dias = datediff(dd,@o_fecha_valor,@s_date)

   ------------------------------------------------
   -- Control de estado para operaciones renovadas
   ------------------------------------------------
   if @o_estado='REN'
   begin
      select @o_operacion_new=re_operacion_new
        from pf_renovacion
       where re_operacion=@o_operacion
      select @o_num_banco_new=op_num_banco
        from pf_operacion
       where op_operacion=@o_operacion_new
   end
   if @o_duplicados = 99
      select @o_duplicados = 0
   select @o_dias_antes_impresion = pa_tinyint from cobis..cl_parametro
    where pa_nemonico = 'DIC'
      and pa_producto = 'PFI'

   ---------------
   -- Condiciones
   ---------------
   set rowcount  1
   select @w_ente2 =be_ente,
          @o_condicion2 = be_condicion
     from pf_beneficiario
    where be_operacion = @o_operacion
      and be_rol = 'A'

   if @@rowcount <> 0
   begin
      select @o_alterno = en_nomlar
        from cobis..cl_ente
       where en_ente           = @w_ente2

      set rowcount 1
      select @w_ente3 =be_ente,
             @o_condicion3 = be_condicion
        from pf_beneficiario
       where be_operacion = @o_operacion
         and be_rol = 'A'
         and be_ente <> @w_ente2

      if @@rowcount <> 0
      begin
         select @o_alterno3 = en_nomlar
           from cobis..cl_ente
          where en_ente = @w_ente3

      end
   else
         select @o_condicion3 = ''
   end
   else    -- @o_ley is not null
      select @o_condicion2 = ''

   ------------------
   -- Capital pagado
   ------------------
   select @o_capital_pagado =pa_money from cobis..cl_parametro
    where pa_nemonico = 'PROVCB'

   --------------------
   -- Segundo Telefono
   --------------------
   select @o_telefono2 =te_valor from cobis..cl_telefono
    where te_ente = @o_ente
      and te_direccion = @o_direccion
      and te_secuencial = 2

   --------------------------------------------------------
   -- Revisar si la Operacion tiene incremento o Reduccion
   --------------------------------------------------------
   if rtrim(ltrim(@o_op_causa_mod)) in ('INC','DEC') and isnull(@o_op_incremento,0) <> 0 and @i_revincre = 'S'
   begin
      select @o_monto = @o_op_incremento
   end

   --------------------------------------------------
   -- Valor para operaciones con cancelación parcial
   --------------------------------------------------
   if rtrim(ltrim(@o_op_causa_mod)) = 'CANP' and @i_revcan = 'S'
   begin
      select @o_monto = ca_valor
        from cob_pfijo..pf_cancelacion
       where ca_operacion = @o_operacion
         and ca_secuencial = (select max(ca_secuencial)
        from pf_cancelacion
       where ca_operacion = @o_operacion)
   end

   -------------------------------------------
   -- Busqueda de valores de la tasa Variable
   -------------------------------------------
   if @o_tasa_variable = 'S'
   begin
      select @o_tv_spread_max = tv_spread_max,
             @o_tv_spread_min = tv_spread_min
        from cob_pfijo..pf_tasa_variable
       where tv_mnemonico_prod = @o_toperacion
         and tv_mnemonico_tasa = @o_mnemonico_tasavar
         and tv_tipo_monto     = @o_tipo_monto
         and tv_tipo_plazo     = @o_tipo_plazo
         and tv_moneda         = @o_moneda
         and tv_estado         = 'I'
   end

   select @o_instruccion = isnull(in_instruccion,'')
     from pf_instruccion
    where in_operacion = @o_operacion
      and isnull(in_estadoxren,'N') = 'N'


   /********************************************
   CCR Consulta de oficial principal y suplente
   ********************************************/
   select   @o_nombre_oficial_principal   = fu_nombre
   from  cobis..cl_funcionario
   where fu_login = @o_oficial_principal

   select @o_nombre_oficial_secundario = fu_nombre
   from  cobis..cl_funcionario
   where fu_login = @o_oficial_secundario

   /*********Fin CCR consulta oficiales********/

   -----------------------------
   -- 12-Abr-2000 Tasa Variable
   -----------------------------
   if @i_siguientes = 'N'
   begin
      select  '14897'                 = @o_num_banco,
              '14898'                 = @o_ente,
              '14899'                 = @o_en_nombre_completo,
              '14900'                 = @o_desc_toperacion,
              '14901'                 = @o_desc_categoria,
              '14902'                 = @o_of_nombre,
              '14903'                 = @o_mo_descripcion,
              '14904'                 = @o_num_dias,
              '14905'                 = @o_monto,
              'Amount pg_int'         = @o_monto_pg_int, /*10*/
              '14906'                 = @o_monto_pgdo,
              '14907'                 = @o_monto_blq,
              '15535'                 = @o_tasa,
              '14909'                 = @o_int_ganado,
              '14910'                 = @o_int_estimado,
              '14911'                 = @o_int_pagados,
              '14912'                 = @o_total_int_ganados,
              '14913'                 = @o_total_int_pagados,
              '14914'                 = @o_total_int_estimado,
              '14804'                 = @o_tcapitalizacion, /*20*/
              '14915'                 = @o_fpago,
              '14916'                 = @o_pp_descripcion,
              '14917'                 = @o_duplicados,
              '14918'                 = @o_renovaciones,
              '14919'                 = @o_estado,
              '14920'                 = @o_pignorado,
              '14921'                 = @o_fu_nombre,
              'Customer'              = @o_descripcion,
              '14808'                 = convert(char(10),@o_fecha_ing,@i_formato_fecha),/*29*/
              '14809'                 = convert(char(10),@o_fecha_valor,@i_formato_fecha),/*30*/
              '14923'                 = convert(char(10),@o_fecha_ven,@i_formato_fecha),
              '14924'                 = convert(char(10),@o_fecha_pg_int,@i_formato_fecha),
              '14925'                 = convert(char(10),isnull(@o_fecha_ult_pg_int, @o_fecha_valor), @i_formato_fecha),
              '14926'                 = convert(char(10),@o_fecha_ult_calculo,@i_formato_fecha),
              '14927'                 = @o_retienimp,
              'Tax'                   = @o_impuesto, /*36*/
              '14928'                 = @o_dia_vencido,
              '14929'                 = @o_dias_anio,
              '14922'                 = @o_pd_descripcion,
              'Pay day'               = @o_dia_pago, /*40*/
              '14930'                 = @o_toperacion,
              '14931'                 = @o_moneda,
              '14932'                 = @o_categoria,
              '14933'                 = @o_ppago,
              '14934'                 = @o_accion_sgte,
              '14935'                 = @o_total_int_retenido,
              '14936'                 = convert(char(10),@o_fecha_can,@i_formato_fecha),
              '14937'                 = @o_tasa_retencion,
              '14938'                 = @w_dias,
              'Num bank new'          = @o_num_banco_new, /*50*/
              '14939'                 = @o_ced_ruc,
              '14940'                 = @o_cd_descripcion,
              '14941'                 = @o_telefono,
              '14942'                 = @o_meses,
              '14943'                 = @o_numdoc,
              '14944'                 = @o_mantiene,
              '15774'                 = @o_disponible,
              '14946'                 = @o_moneda_pg,
              '14947'                 = @o_direccion,
              '11236'                 = @o_ciudad, /*60*/
              '14948'                 = @o_preimpreso ,
              '14949'                 = @o_factor_en_meses,
              '14950'                 = @o_alterno,
              '15744'                 = @o_operacion,
              '15534'                 = @o_oficina,
              '14953'                 = @o_num_imp_orig,
              '14954'                 = @o_dias_antes_impresion,
              '14955'                 = @o_impuesto_capital,
              '14956'                 = @o_condicion2,
              'Customer Y/O'          = @o_condicion3, /*70*/
              '14957'                 = @o_capital_pagado ,
              '14958'                 = @o_alterno3,
              '14959'                 = @o_telefono2,
              '14960'                 = @o_ley,
              '14961'                 = @o_cert_origen,
              '15395'                 = @o_fecha_cal_tasa, /*76*/
              '14962'                 = convert(char(10),@o_fecha_cert_origen, @i_formato_fecha),
              '14963'                 = @o_tasa_congelado,
              '15780'                 = @o_anio_comercial,
              '14965'                 = @o_tasa_variable,
              '14966'                 = @o_flag_tasaefec,
              '14967'                 = @o_tasa_efectiva,
              '14968'                 = @o_total_int_acumulado,
              '14969'                 = @o_tot_int_est_ant,
              '14970'                 = @o_residuo,
              '14971'                 = @o_imprime,
              '14972'                 = @o_plazo_ant,
              '14973'                 = @o_fecven_ant,
              '14974'                 = @o_fech_ord_act,
              '14975'                 = @o_int_provision,
              '14976'                 = @o_retenido,
              '14977'                 = @o_tipo_monto,/*92*/
              '14978'                 = @o_tipo_plazo,
              '14979'                 = @o_estatus_prorroga,
              '14980'                 = @o_num_prorroga,
              '14981'                 = @o_mnemonico_tasavar,
              '14982'                 = @o_modalidad_tasa,
              '14983'                 = @o_periodo_tasa,
              '14984'                 = @o_operador,
              '15530'                 = @o_spread,
              '15777'                 = @o_base_calculo,
              '15757'                 = @o_tipo_tasa_var,  /*102*/
              'Spread Min'            = @o_tv_spread_max,
              'Spread Max'            = @o_tv_spread_min,
              '14987'                 = @o_desc_tasa_var,
              'Plz pactado'           = @o_op_plazo_orig,
              'Oficial Pr'            = @o_oficial_principal,
              'Oficial Sc'            = @o_oficial_secundario,
              'Instruccion'           = @o_instruccion,   --CVA Oct-06-05
              'Monto Bloq. Legal'     = @o_monto_blqlegal,   --LIM Oct-15-05
              'Ult. Fecha Inc. Dism.' = @o_fecha_ult_inc_dism, --LIM 09/NOV/2005
              'Desmaterializa'        = @o_desmaterializa
   end
 else  -- Si la consulta es para traer los siguientes reg. 12-Abr-2000 TVar.
   begin
      select  '14987'                 = @o_desc_tasa_var,
              '14988'                 = @o_puntos,
              'Bloqueo Legal'         = @o_bloqueo_legal,--GAR GB-DP00036
              'Cliente Corresp'       = @o_ente_corresp, --GAR GB-DP00120
              'Dias Reales'           = @o_dias_reales,  --GAR Dias Reales                   --5
              'Ultima Fecha Renov'    = @o_fecha_ult_renov,
              'Localizado S/N'        = isnull(@o_localizado, 'N'),
              'Fecha Localizacion'    = convert(varchar, @o_fecha_localizacion, @i_formato_fecha),
              'Fecha No Localizacion' = convert(varchar, @o_fecha_no_localiza, @i_formato_fecha),
              'Casilla'               = @o_casilla,                                                 --10
              'Mnemonico Moneda'      = @o_mo_mnemonico,
              'Sucursal'              = @o_sucursal,
              'Fch Ult Pago Int Ant'  = convert(varchar(10), isnull(@o_fecha_ult_pago_int_ant, @o_fecha_valor), @i_formato_fecha),
              'Inactivo'              = @o_inactivo,
              'Nombre Oficial Princ'  = @o_nombre_oficial_principal,         --15
              'Nombre Oficial Sec'    = @o_nombre_oficial_secundario,
              'Tasa Base'             = @o_tasa_base,
              'Fideicomiso'           = @o_fideicomiso,
            --NYM DPF00015 ICA
              'IMP_ICA'               = @o_ret_ica,
              'VALOR IMPUESTO ICA'    = @o_imp_ica,     --20
              'TASA IMPUESTO RENTA'   = @o_tasa_retencion,
              'TASA IMPUESTO ICA'     = @o_tasa_ica

   end
end
return 0

go

