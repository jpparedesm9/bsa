/************************************************************************/
/*      Archivo:                cambtasa.sp                             */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               PLAZO FIJO                              */
/*      Disenado por:                                                   */
/*      Fecha de escritura:     10/Abr/2000                             */
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
/*      Este script cambia la tasa de una operacion prorrogada haciendo */
/*      un recalculo de los intereses a partir de la fecha de prorroga. */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR                   RAZON                   */
/*      10/Abr/2000     Gabriela Estupinan Emision Inicial              */
/*      20-Jun-2000     Marcelo Cartagena  Cambio de tipo de variable   */
/*                                         cotizacion de money a float  */ 
/*      18-Mar-2005     N. Silva           Indentacion, correcciones,   */
/*                                         adecuacion para pagos per    */
/*      03-Nov-2005     Luis Im            Contemplar tipo de dpf       */
/*                                         inhabilitados                */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cambia_tasa')
   drop proc sp_cambia_tasa
go

create proc sp_cambia_tasa(
@s_ssn                  int         = NULL,
@s_user                 login       = NULL,
@s_sesn                 int         = NULL,
@s_term                 varchar(30) = NULL,
@s_date                 datetime    = NULL,
@s_srv                  varchar(30) = NULL,
@s_lsrv                 varchar(30) = NULL,
@s_rol                  smallint    = NULL,
@s_ofi                  smallint    = NULL,
@s_org_err              char(1)     = NULL,
@s_error                int         = NULL,
@s_sev                  tinyint     = NULL,
@s_msg                  descripcion = NULL,
@s_org                  char(1)     = NULL,
@t_debug                char(1)     = 'N',
@t_file                 varchar(14) = NULL,
@t_from                 varchar(32) = NULL,
@t_trn                  smallint    = NULL,
@i_tasa                 float,
@i_num_banco            cuenta,
@i_autorizado           login,
@i_spread               float       = 0,
@i_flag					char(1)     = 'N'			--LIM 03/NOV/2005

)
with encryption
as
declare
@w_sp_name                     varchar(32),
@w_intereses_periodo           money,
@w_num_dias_periodo            int,
@w_numdeci                     tinyint, 
@w_usadeci                     char(1), 
@w_num_meses                   tinyint,
@w_dias                        tinyint,
@w_contador_registros          int,
@w_rowcount					   int,					--LIM 03/NOV/2005

/* VARIABLES PF_OPERACION */

        @w_op_operacion                int,
        @w_op_int_provision            float,
        @w_op_int_estimado             money,
        @w_op_int_ganado               money,
        @w_op_total_int_ganados        money,
        @w_op_int_pagados              money,
        @w_op_total_int_pagados        money,
        @w_op_fecha_valor              datetime,
        @w_op_fecha_ven                datetime,
        @w_op_fecha_pg_int             datetime,
        @w_op_fecha_ult_pg_int         datetime,
        @w_fecha_ult_provision         datetime,
        @w_op_monto                    money,
        @w_op_tasa                     float,
        @w_op_ppago                    catalogo,
        @w_op_tipo_plazo               catalogo,
        @w_op_tipo_monto               catalogo,
        @w_op_toperacion               catalogo,
        @w_op_moneda                   tinyint,
        @w_op_base_calculo             smallint,
        @w_op_total_int_estimado       money,
        @w_op_producto                 tinyint,
        @w_op_oficina                  smallint,
        @w_op_estado                   catalogo,
        @w_op_historia                 smallint,
        @w_op_fecha_mod                datetime,
        @w_num_dias                    smallint,
        @w_num_dias_pagados            int,
        @w_num_dias_provisionados      int,
        @w_num_dias_ganados            int,
        @w_int_dias_pagados            money,
        @w_int_dias_ganados            money,
        @w_total_int_dias_ganados      money,
        @w_total_int_estimado          money,
        @w_op_fpago                    catalogo,
        @w_op_ley                      char(1),
        @w_fecha_hoy                   datetime,
        @w_tot_dias                    int,
        @w_tot_int_estim_new           money,
        @w_op_tplazo                   catalogo,
        @w_op_ente                     int,
        @w_op_operador                 char(1),
        @w_op_spread                   float,

/* Variables para reversar provision monto blq */
        @w_op_monto_blq                money,   
        @w_dias_blq                    tinyint,
        @w_fecha_bloqueo               datetime,
        @w_provision_blq               money,
        @w_provision_blq_nueva         money,
        @w_dif_provision_blq           money,
        @w_op_tasa_variable            char(1),
/* Variables para reversar provision monto pgdo */
        @w_op_monto_pgdo               money,  
        @w_dias_pgdo                   tinyint,
        @w_fecha_pignoracion           datetime,
        @w_provision_pgdo              money,
        @w_provision_pgdo_nueva        money,
        @w_dif_provision_pgdo          money,
        @w_tot_intereses               money,
        @w_veces                       tinyint,
        @w_flag_pgdo_blq               tinyint, 
        

        @v_total_int_estimado          money,
        @v_int_estimado                money,
        @v_total_int_ganado            money,
        @v_int_ganado                  money,
        @v_int_provision               money,
        @v_tasa                        float,
        @v_historia                    smallint,
        @v_fecha_mod                   datetime,
        @v_provision                   float, 
        @v_total_int_ganados           money,


/* VARIABLES PF_DET_PAGO */
        @w_pt_tipo                     catalogo,
        @w_pt_secuencia                int,
        @w_pt_forma_pago               catalogo,
        @w_pt_cuenta                   cuenta,
        @w_pt_monto                    money,
        @w_pt_porcentaje               tinyint,
        @w_monto_mov                   money,

        @w_int_a_pagar                 money,   -- GES 01/13/2000
        @w_tasa1                       float,   -- GES 01/13/2000
        @w_error                       int,
	@w_op_retienimp		       char(1),
        @w_num_dias_ppago              money,   -- GES 01/24/2000

        @w_dias_cambio_tasa            smallint,
        @w_fecha_tope                  datetime,
        @w_total_int_ganados_ant       money,
        @w_dias_renovado               int,
        @w_fecha_proceso               datetime,
        @w_tasa                        float,

/* Variables para contabilizacion */
        @w_codval                      varchar(20),	--cambia tipo de dato a varchar
        @w_perfil                      int,
        @w_debcred                     char(1),
        @w_contador                    smallint,
        @w_comprobante                 int,
        @w_area_dest                   int,
        @w_descripcion                 descripcion,
        @w_cotizacion                  float,
        @w_moneda                      tinyint,

        @w_tipo                        char(1),
        @w_total_int_ganados           money,
        @w_diferencia_provision        money,
        @w_return                      int,
        @w_provision                   float,
        @w_residuo                     float,
        @w_cambio_tasa                 char(1),
        @w_op_cupon                    char(1),
        @w_num_dias_ntas               int,
        @w_op_mnemonico_tasa           catalogo,
        @w_valor_tasa_var              float,
        @w_op_periodo_tasa             smallint,
        @w_op_modalidad_tasa           char(1),
        @w_op_descr_tasa               descripcion,
        @w_tasa_efectiva_conver        float


/*-------------------------------*/
/* Validar codigo de transaccion */
/*-------------------------------*/
if @t_trn <> 14959
begin
   select @w_error = 141018
   goto ERROR
end    

------------------------------- 
-- Inicializacion de variables
-------------------------------
select @w_fecha_proceso = @s_date

------------------------------------------
-- Obtener datos de la tabla pf_operacion 
------------------------------------------
select @w_op_operacion          = op_operacion,
       @w_op_int_estimado       = op_int_estimado,
       @w_op_int_ganado         = op_int_ganado,
       @w_op_total_int_ganados  = op_total_int_ganados,
       @w_op_total_int_estimado = op_total_int_estimado,
       @w_op_fecha_valor        = op_fecha_valor,
       @w_op_fecha_ven          = op_fecha_ven,
       @w_op_fecha_pg_int       = op_fecha_pg_int,
       @w_op_fecha_ult_pg_int   = op_fecha_ult_pg_int,
       @w_op_monto              = op_monto,
       @w_op_tasa               = op_tasa,
       @w_op_ppago              = op_ppago,
       @w_op_toperacion         = op_toperacion,
       @w_op_moneda             = op_moneda,
       @w_op_base_calculo       = op_base_calculo,
       @w_num_dias              = op_num_dias,
       @w_op_fpago              = op_fpago,
       @w_op_retienimp          = op_retienimp,
       @w_op_tplazo             = op_tipo_plazo,
       @w_op_producto           = op_producto,
       @w_op_oficina            = op_oficina,
       @w_op_estado             = op_estado,
       @w_op_historia           = op_historia,
       @w_op_int_provision      = op_int_provision,
       @w_op_fecha_mod          = op_fecha_mod,
       @w_op_ente               = op_ente,
       @w_op_monto_pgdo         = op_monto_pgdo,
       @w_op_monto_blq          = op_monto_blq,
       @w_op_cupon              = op_cupon,
       @w_op_total_int_pagados  = op_total_int_pagados,
       @w_op_tasa_variable      = op_tasa_variable,
       @w_op_operador           = op_operador,
       @w_op_spread             = op_spread,
       @w_op_mnemonico_tasa     = op_mnemonico_tasa,
       @w_op_periodo_tasa       = op_periodo_tasa,
       @w_op_modalidad_tasa     = op_modalidad_tasa,
       @w_op_descr_tasa         = op_descr_tasa

  from cob_pfijo..pf_operacion 
 where op_num_banco = @i_num_banco 
   and op_estado = 'ACT'

if @@rowcount = 0
begin
   select @w_error = 141090
   goto ERROR
end

------------------------------------------------------------------
-- Verificar si el tipo de deposito se puede o no cambiar de tasa
------------------------------------------------------------------
if @i_flag = 'S'							--LIM 03/NOV/2005
begin
	select @w_cambio_tasa = td_cambio_tasa   
  	from pf_tipo_deposito
 	where td_mnemonico = @w_op_toperacion  
   	  and td_estado = 'A'

	select @w_rowcount = @@rowcount			--LIM 03/NOV/2005
end
else
begin
	select @w_cambio_tasa = td_cambio_tasa	--LIM 03/NOV/2005   
  	from pf_tipo_deposito
 	where td_mnemonico = @w_op_toperacion  

	select @w_rowcount = @@rowcount			--LIM 03/NOV/2005
end
if @w_rowcount = 0
begin
   select @w_error = 141115
   goto ERROR
end

If @w_cambio_tasa <> 'S'
begin
   select @w_error = 149080
   goto ERROR
end

------------------------------------------------------------------------
-- Asignacion a nuevas variables los valores originales de la operacion 
------------------------------------------------------------------------
select @v_total_int_estimado = @w_op_int_estimado,
       @v_int_estimado       = @w_op_int_estimado,
       @v_total_int_ganado   = @w_op_total_int_ganados,
       @v_int_ganado         = @w_op_int_ganado,
       @v_historia           = @w_op_historia,
       @v_tasa               = @w_op_tasa,
       @v_provision          = @w_op_int_provision,
       @v_fecha_mod          = @w_op_fecha_mod

select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @w_op_moneda

if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull(pa_tinyint,0)
     from cobis..cl_parametro
    where pa_nemonico = 'DCI' 
      and pa_producto = 'PFI'
end
else
  select @w_numdeci = 0  

select @w_dias_cambio_tasa = pa_tinyint
  from cobis..cl_parametro
 where pa_producto='PFI' 
   and pa_nemonico = 'DCT'
if @@rowcount = 0
begin
   select @w_error = 141140
   goto ERROR
end 

select @w_fecha_tope=dateadd(dd, @w_dias_cambio_tasa, @w_op_fecha_valor)

if @w_fecha_proceso > @w_fecha_tope
begin
   select @w_error = 141164
   goto ERROR

end 
else
begin
   begin tran
      
      -- Proceso para validacion y manejo de tasa variable
      -----------------------------------------------------
      if @w_op_tasa_variable = 'S'
      begin

                -----------------------------------------------------------
                -- Proceso para tomar el valor de la tasa variable para el
                -- siguiente periodo de pago de intereses (Tasa Variable)
                -----------------------------------------------------------
                exec @w_return = cob_pfijo..sp_cons_tasa_var
                     @t_trn          = 14416,
                     @i_operacion    = 'Q',
                     @i_tipo         = 'N',
                     @i_cod_tasa_ref = @w_op_mnemonico_tasa,--Cod. tasa referencial
                     @i_fecha        = @w_op_fecha_ult_pg_int,   --Fecha de consulta
                     @i_moneda       = @w_op_moneda, --Moneda de la negociacion
                     @i_batch        = 'S',
                     @o_valor_ref    = @w_valor_tasa_var out --valor tasa referencial 
  
                if @w_return <> 0
                begin                 
                   select @w_error = @w_return
                   goto ERROR
                end

                ------------------------------------------------------------                
                -- Obtener el factor en meses para calculo de tasa variable
                ------------------------------------------------------------  
                select @w_num_meses = pp_factor_en_meses
                  from pf_ppago
                 where pp_codigo = @w_op_ppago

                if @w_op_ppago = 'NNN'
                   select @w_num_meses = 1
 
                --------------------------------------------
                -- Proceso para Calculo de la tasa variable
                --------------------------------------------           
                exec @w_return = cob_pfijo..sp_calcula_tasa_var
                     @t_trn            = 14948,
                     @i_vr_tasa_var    = @w_valor_tasa_var,
                     @i_periodo_tasa   = @w_op_periodo_tasa,
                     @i_modalidad_tasa = @w_op_modalidad_tasa, 
                     @i_descr_tasa     = @w_op_descr_tasa,
                     @i_mnemonico_tasa = @w_op_mnemonico_tasa,
                     @i_operador       = @w_op_operador,
                     @i_spread         = @i_spread,
                     @i_base_calculo   = @w_op_base_calculo,
                     @i_modalidad_prod = @w_op_fpago,
                     @i_per_pago       = @w_num_meses,
                     @i_toperacion     = @w_op_toperacion,
                     @i_en_linea       = 'N',
                     @i_moneda         = @w_op_moneda,
                     @i_monto          = @w_op_monto,
                     @i_plazo          = @w_num_dias,
                     @o_tasa_EA        = @w_tasa_efectiva_conver out, -- valor tasa efect 
                     @o_tasa_nom_reexp = @w_tasa                 out  -- valor tasa nominal 
                if @w_return <> 0
                begin               
                  select @w_error = @w_return
                  goto ERROR
                end          
      end
      else
         select @w_tasa = round((@i_tasa + @i_spread),6)

      -------------------------------------------------------------
      -- Recalculo de intereses estimados aplicando la nueva tasa
      -------------------------------------------------------------
      /* Se obtiene el nuevo interes total estimado, a partir de la ultima fecha de pago de interes */
      select @w_num_dias_ntas = datediff(dd,@w_op_fecha_ult_pg_int,@w_op_fecha_ven)
      select @w_tot_int_estim_new = @w_op_total_int_pagados + round(((@w_tasa * @w_op_monto * @w_num_dias_ntas) / (100 * @w_op_base_calculo)),@w_numdeci)

      if @w_op_fpago = 'PER'  /* Operaciones Periodicas */
      begin
         select @w_num_meses = pp_factor_en_meses 
           from pf_ppago
          where pp_codigo = @w_op_ppago

         select @w_num_dias_ppago = datediff(dd,@w_op_fecha_ult_pg_int,@w_op_fecha_pg_int)     --- REVISAR ESTE CAMPO DE FECHAS SIN DIFERENCIAR

         select @w_intereses_periodo = round((((@w_tasa * @w_op_monto * @w_num_dias_ppago) / (100 * @w_op_base_calculo))),@w_numdeci)
     end
     else /* Operaciones al vencimiento */
        select  @w_intereses_periodo = @w_tot_int_estim_new

     -------------------------------------------------------
     -- Acceso y actualizacion de la tabla detalle de pagos
     -------------------------------------------------------
     if @w_op_fpago <> 'NNN'
     begin
        select @w_pt_secuencia = 0
        while 2=2
        begin
            set rowcount 1
            select @w_pt_tipo       = dp_tipo,
                   @w_pt_secuencia  = dp_secuencia,
                   @w_pt_forma_pago = dp_forma_pago,
                   @w_pt_cuenta     = dp_cuenta,
                   @w_pt_monto      = dp_monto,
                   @w_pt_porcentaje = dp_porcentaje
              from pf_det_pago
             where dp_operacion = @w_op_operacion 
               and dp_secuencia  > @w_pt_secuencia 
               and dp_tipo = 'INT'
               and dp_estado = 'I'      
               and dp_estado_xren = 'N'            
            order by dp_secuencia

            if @@rowcount = 0
               break

            set rowcount 0
       
            if @w_pt_monto is null
               select @w_monto_mov = @w_pt_porcentaje*@w_intereses_periodo/100
            else
               select @w_monto_mov = @w_intereses_periodo

            ------------------------------------------
            -- Se incluye el impuesto en el recalculo 
            ------------------------------------------
            if @w_op_retienimp = 'N'
               select @w_int_a_pagar = round(@w_monto_mov ,@w_numdeci)
            else
            begin
               exec @w_return = sp_impuesto_renta
                    @t_trn       = 14813,
                    @i_tipo      = 'N',
                    @i_num_banco = @i_num_banco, 
                    @o_tasa      = @w_tasa1 out
               if @w_return <> 0
               begin
                  select @w_error = @w_return
                  goto ERROR
               end                               
            
               select @w_int_a_pagar = round(@w_monto_mov - (@w_monto_mov * @w_tasa1/100),@w_numdeci)
            end
       
            update pf_det_pago 
               set dp_monto = @w_int_a_pagar                        
             where dp_operacion = @w_op_operacion
               and dp_secuencia = @w_pt_secuencia
               and dp_tipo = 'INT'
               and dp_estado = 'I'
               and dp_estado_xren = 'N'

            set rowcount 0 
         end
      end

      ---------------------------------
      -- Actualizacion de la operacion
      ---------------------------------
      select @w_num_dias_ntas = datediff(dd,@w_op_fecha_ult_pg_int,@w_fecha_proceso)
      select @w_dias_renovado = datediff(dd, @w_op_fecha_valor, @w_fecha_proceso)
      select @w_total_int_ganados = @w_op_total_int_pagados + ((@w_tasa * @w_op_monto * @w_num_dias_ntas) / (100 * @w_op_base_calculo))   

      select @w_provision =  (@w_tasa * @w_op_monto) / (100 * @w_op_base_calculo)  

      select @w_residuo = @w_provision - round(@w_provision, @w_numdeci)
    
      select @w_provision = round(@w_provision, @w_numdeci)

      if @w_op_tasa > @w_tasa   -- Se debe reversar provision
         select @w_tipo = 'R'
      else 
         select @w_tipo = 'N'

      select @w_diferencia_provision = @w_op_total_int_ganados - @w_total_int_ganados
   
      select @w_descripcion ='AJST PROV CAMB TAS (' + rtrim(@i_num_banco) + ')'
 
      select @w_tot_intereses = round((abs(@w_diferencia_provision)), @w_numdeci)

      -------------------------------------------------------------
      -- Contabilizacion de ajuste de provision por cambio de tasa
      -------------------------------------------------------------
      if @w_tot_intereses > 0
      begin           
         exec @w_return = cob_pfijo..sp_aplica_conta
              @s_ssn           = @s_ssn,
              @s_date          = @s_date,
              @s_user          = @s_user,
              @s_term          = @s_term,
              @s_ofi           = @s_ofi,
              @t_debug         = @t_debug,
              @t_file          = @t_file,
              @t_from          = @t_from,
              @t_trn           = 14937,
              @i_en_linea      = 'N',
              @i_empresa       = 1,
              @i_fecha         = @s_date,
              @i_tran          = 14926,
              @i_producto      = @w_op_producto,     -- op_producto 
              @i_oficina_oper  = @w_op_oficina,
              @i_oficina       = @s_ofi,
              @i_toperacion    = @w_op_toperacion,   -- op_toperacionMCA06-Nov-99
              @i_tplazo        = @w_op_tplazo,       -- Nemonico tipo de plazo 
              @i_operacionpf   = @w_op_operacion,
              @i_estado        = @w_op_estado ,
              @i_valor         = @w_tot_intereses,   
              @i_moneda        = @w_op_moneda,
              @i_afectacion    = @w_tipo,            -- N=Normal,  R=Reverso  
              @i_descripcion   = @w_descripcion,
              @i_codval        = '18',               -- Codigo de valor para el detalle 
              @i_movmonet      = '1',
              @i_debcred       = '1',                -- Si es debito = 1 o credito = 2 
              @i_flag_pgdo_blq = @w_flag_pgdo_blq  
       
         if @w_return <> 0
         begin
            -- Error en contabilizacion de la operacion
            select @w_error = 149061
            goto ERROR
         end
      end 

      --------------------------------------------------------------------------------
      -- Se considera que el cambio de tasa se lo va a realizar al, inicio del plazo, 
      -- no se han pagado intereses, por lo que el interes ganado y el total interes 
      -- ganado son los mismos.  
      --------------------------------------------------------------------------------
      select @w_op_historia = @w_op_historia + 1

      if @w_op_tasa_variable = 'S'
      begin
  
         update pf_operacion 
            set op_tasa               = @w_tasa,
                op_int_estimado       = @w_intereses_periodo,
                op_total_int_estimado = @w_tot_int_estim_new,
                op_int_ganado         = @w_total_int_ganados,  
                op_total_int_ganados  = @w_total_int_ganados,
                op_int_provision      = @w_provision,
                op_fecha_mod          = @s_date,
                op_historia           = @w_op_historia,
                op_residuo            = @w_residuo,
                op_ult_fecha_cal_tasa = @s_date,
                op_nueva_tasa         = @w_tasa,
                op_spread             = @i_spread,
                op_tasa_efectiva      = @w_tasa_efectiva_conver
          where op_num_banco = @i_num_banco
      end
      else
      begin
         update pf_operacion 
            set op_tasa               = @w_tasa,
                op_int_estimado       = @w_intereses_periodo,
                op_total_int_estimado = @w_tot_int_estim_new,
                op_int_ganado         = @w_total_int_ganados,  
                op_total_int_ganados  = @w_total_int_ganados,
                op_int_provision      = @w_provision,
                op_fecha_mod          = @s_date,
                op_historia           = @w_op_historia,
                op_residuo            = @w_residuo,
                op_ult_fecha_cal_tasa = @s_date,
                op_nueva_tasa         = @w_tasa,
                op_tasa_efectiva      = @w_tasa
          where op_num_banco = @i_num_banco
      end 

      if @@error <> 0
      begin
         select @w_error = 145001
         goto ERROR
      end  

      -------------------------------------------------
      -- Insercion de Autorizacion para cambio de tasa
      -------------------------------------------------
      insert pf_autorizacion (au_operacion    , au_autoriza  , au_oficina,
                              au_tautorizacion, au_fecha_crea, au_num_banco,au_oficial)
                     values  (@w_op_operacion , @i_autorizado, @s_ofi,
                              'CATA'          , @s_date      , @i_num_banco,@s_user)
      if @@error <> 0
      begin
         select @w_error = 143040
         goto ERROR
      end

      insert pf_historia (hi_operacion   , hi_secuencial , hi_fecha,
                          hi_trn_code    , hi_valor      , hi_funcionario,
                          hi_oficina     , hi_observacion, hi_fecha_crea, 
                          hi_fecha_mod   , hi_tasa)
                  values (@w_op_operacion, @v_historia   , @s_date,
                          @t_trn         , @w_tasa       , @s_user,
                          @s_ofi         , ''            , @s_date,
                          @s_date        , @w_op_tasa)
      if @@error <> 0
      begin
         select @w_error = 143006
         goto ERROR
      end                         

      --------------------------------------------------
      -- Insercion de la transaccion de servicio Previa
      --------------------------------------------------
      insert ts_operacion (secuencial           , tipo_transaccion, clase               , usuario,
                           terminal             , srv             , lsrv                , fecha,
                           num_banco            , operacion       , int_provision       , int_estimado,
                           total_int_estimado   , int_ganado      , total_int_ganados   , tasa, 
                           historia             , fecha_mod)
                   values (@s_ssn               , @t_trn          , 'P'                 , @s_user,
                           @s_term              , @s_srv          , @s_lsrv             , @s_date,
                           @i_num_banco         , @w_op_operacion , @v_int_provision    , @v_int_estimado,
                           @v_total_int_estimado, @v_int_ganado   , @v_total_int_ganados, @v_tasa, 
                           @v_historia          , @v_fecha_mod)
      if @@error <> 0
      begin
         select @w_error = 143005
         goto ERROR
      end

      ---------------------------------------------------------
      -- Insercion de la transaccion de servicio Actualizacion
      ---------------------------------------------------------
      insert ts_operacion (secuencial           , tipo_transaccion    , clase               , usuario,
                           terminal             , srv                 , lsrv                , fecha,
                           num_banco            , operacion           , int_provision       , int_estimado,
                           total_int_estimado   , int_ganado          , total_int_ganados   , tasa, 
                           historia             , fecha_mod)
                   values (@s_ssn               , @t_trn              , 'A'                 , @s_user,
                           @s_term              , @s_srv              , @s_lsrv             , @s_date,
                           @i_num_banco         , @w_op_operacion     , @w_op_int_provision , @w_intereses_periodo,
                           @w_tot_int_estim_new , @w_total_int_ganados, @w_total_int_ganados, @w_tasa, 
                           @w_op_historia       , @s_date)
      if @@error <> 0
      begin
         select @w_error = 143005
         goto ERROR
      end
 
   commit tran
end
return 0

-------------------
-- Manejo de error
-------------------
ERROR:
   rollback tran
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name, 
        @i_num = @w_error
   return  1
go        
