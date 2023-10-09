/************************************************************************/
/*   Archivo:              sp_modificar_operacion_busin.sp              */
/*   Stored procedure:     sp_modificar_operacion_busin                 */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             cob_pac                                      */
/*   Disenado por:         Ruperado de Base datos                       */
/*   Fecha de escritura:   May 2017                                     */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/* 05/05/2017        M. Custode           Eliminaciond el conver tramite*/
/*                                        por i_banco                   */
/* 05/04/2020        D. Cumbal            Actualizacion desplazamiento  */
/* 17-09-2020        Sonia Rojas          Req #140073                   */
/* 14/11/2022        D. Cumbal            Req #194284                   */ 
/************************************************************************/
use cob_pac
go

if object_id ('sp_modificar_operacion_busin') is not null
	drop procedure sp_modificar_operacion_busin
go

create proc sp_modificar_operacion_busin
        @s_user                 login        = null,
        @s_sesn                 int          = null,
        @s_date                 datetime     = null,
        @s_term                 varchar(30)  = null,
        @s_ofi                  int          = null,
        @s_culture              varchar(10)  = null,
        @s_srv                  varchar(30)  = null,
        @s_lsrv                 varchar(30)  = null,
        @s_rol                  smallint     = null,
        @s_ssn                  int          = null,
        @s_org                  char(1)      = null,
        @t_debug                char(1)      = 'N',
        @t_trn                  int          = null,
        @i_calcular_tabla       char(1)      = 'N',
        @i_tabla_nueva          char(1)      = 'S',
        @i_operacionca          int          = null,
        @i_banco                cuenta       = null,
        @i_anterior             cuenta       = null,
        @i_migrada              cuenta       = null,
        @i_tramite              int          = null,
        @i_cliente              int          = null,
        @i_debcta               char(1)      = null,
        @i_nombre               descripcion  = null,
        @i_sector               catalogo     = null,
        @i_toperacion           catalogo     = null,
        @i_oficina              smallint     = null,
        @i_moneda               tinyint      = null,
        @i_comentario           varchar(255) = null,
        @i_oficial              smallint     = null,
        @i_fecha_ini            datetime     = null,
        @i_fecha_fin            datetime     = null,
        @i_fecha_ult_proceso    datetime     = null,
        @i_fecha_liq            datetime     = null,
        @i_fecha_reajuste       datetime     = null,
        @i_base_calculo     	  char(1)      = null,
        @i_monto                money        = null,
        @i_monto_aprobado       money        = null,
        @i_destino              catalogo     = null,
        @i_lin_credito          cuenta       = null,
        @i_ciudad               smallint     = null,
        @i_estado               tinyint      = null,
        @i_periodo_reajuste     smallint     = null,
        @i_reajuste_especial    char(1)      = null,
        @i_tipo                 char(1)      = null,
        @i_forma_pago           catalogo     = null,
        @i_cuenta               cuenta       = null,
        @i_dias_anio            smallint     = null,
        @i_tipo_amortizacion    varchar(10)  = null,
        @i_cuota_completa       char(1)      = null,
        @i_tipo_cobro           char(1)      = null,
        @i_tipo_reduccion       char(1)      = null,
        @i_aceptar_anticipos    char(1)      = null,
        @i_precancelacion       char(1)      = null,
        @i_tipo_aplicacion      char(1)      = null,
        @i_tplazo               catalogo     = null,
        @i_plazo                int          = null,
        @i_tdividendo           catalogo     = null,
        @i_periodo_cap          int          = null,
        @i_periodo_int          int          = null,
        @i_dist_gracia          char(1)      = null,
        @i_gracia_cap           int          = null,
        @i_gracia_int           int          = null,
        @i_dia_fijo             int          = null,
        @i_cuota                money        = null,
        @i_evitar_feriados      char(1)      = null,
        @i_num_renovacion       int          = null,
        @i_renovacion           char(1)      = null,
        @i_mes_gracia           tinyint      = null,
        @i_formato_fecha        int          = 101,
        @i_upd_clientes         char(1)      = null,
        @i_dias_gracia          smallint     = null,
        @i_reajustable          char(1)      = null,
        @i_fijo_desde           int          = null,  --JG Y BP
        @i_fijo_hasta           int          = null,  --JG Y BP
        @i_cta_certificado      varchar(24)  = null,
        @i_cta_ahorro           varchar(24)  = null,
        @i_tipo_bloqueo         char(1)      = null,
        @i_clase_bloqueo        char(1)      = null,
        @i_doble_alicuota       char(1)      = null,
		  @i_activa_TirTea		  char(1)		 = 'S',       --JMORAN 23Mar2016 Se agrega impresion mensaje TIR-TEA
        @i_alicuota_aho         varchar(10)  = null,
        @i_alicuota             varchar(10)  = null,  --LGU ini 27.03.2002
        @i_actividad_destino    catalogo     = null,
        @i_compania             int          = null,
        @i_salida               char(1)      = 'S',   --Muestra datos al frontend
        @i_tipo_cca             catalogo     = null,  --LGU fin 09.04.2002
        @i_reaj_diario          char(1)      = null,
        @i_seg_cre              catalogo     = null,  --SRA SEGMENTO CREDITO 14/092007
        @i_es_interno           char(1)      = 'N',   --N = No es un programa interno, se llama desde frontend, 'S'= es un llamada desde otro sp
        @i_prodbanc_aho         smallint     = null,  --PRON:14NOV07 prod bancario para simulacion
        @i_prodbanc_cer         smallint     = null,  --PRON:14NOV07 prod bancario para simulacion
        @i_base_dias_int        char(1)      = null,  --PRON:8ENE08
        @i_p_cuota		money	     = null,  --cll REQ-956 Obligaciones Financieras
        @i_fecha_redescuento    datetime     = null,  --APE REQ-2400 Aumento del campo fecha de redescuento en la fgenamor de cartera,
        @i_entra_fecha_redes    char(1)      = 'S',   --PRON
        @i_parroquia            catalogo     = null,
        @i_fecha_vcmto1         datetime     = null,
        @i_fecha_dispersion     datetime     = null,
        @i_desplazamiento       int          = null,         --SRO. 140073
		@i_dia_pago             datetime     = null,         --DCU  194284
        @o_cta_ahorro           varchar(24)  = null output,  --PRON:28AGO06
        @o_cta_certificado      varchar(24)  = null output,  --PRON:28AGO06
        --Variables de output Implantación Originador CPN
        @o_tea                  float        = null output,
        @o_tir                  float        = null output,
        @o_plazo                int          = null output,
        @o_tplazo               catalogo     = null output,
        @o_cuota                money        = null output
as
declare 
@w_sp_name               descripcion,
@w_return                int,
@w_error                 int,
@w_valor_rubro           money,
@w_moneda                tinyint,
@w_concepto              catalogo,
@w_dias_plazo            int,
@w_dias_dividendo        INT,
@w_opt_tramite           INT,
@w_opt_banco             VARCHAR(30),
@w_opt_operacion         INT,
@w_sector                catalogo,
-- Variable para la extraccion del dia habil
@w_fecha_hab_disp        datetime,
@w_numero_dias           int,
@w_ciudad_nacional       int,
@w_fecha_proceso         datetime,
@w_fecha_con_disper      datetime,
@w_fecha_tmp             datetime,
@w_desplazamiento_cuota  char(1),
@w_dias_desplazados      int = 0,
@w_int_espera            varchar(10),
@w_num_div               int,
@w_monto_int_desp        money,
@w_param_oferta_producto char(1),
@w_factor                smallint,
@w_fecha_ini             datetime,
@w_per_cuotas            int,
@w_dias_primer_pago      int,
@w_dia_inicio            int,
@w_fecha_ini_tmp         datetime,
@w_dias_evaluar          int,
@w_fecha_inicio_op       datetime,
@w_tplazo                catalogo,
@w_tdividendo            catalogo,
@w_periodo_cap           int,
@w_periodo_int           int,
@w_toperacion            varchar(100)

-- CARGAR VALORES INICIALES
select 
@w_sp_name = 'sp_modificar_operacion_busin',
@i_activa_TirTea = isnull(@i_activa_TirTea, 'S')  --JMORAN 23Mar2016 Se agrega impresion mensaje TIR-TEA

if exists (select 1 from cob_cartera..ca_operacion where op_banco = @i_banco and op_toperacion = 'INDIVIDUAL')
   select @i_fecha_dispersion = fp_fecha from cobis..ba_fecha_proceso 

if @i_calcular_tabla = 'S' begin
   -- OBTENER FECHA CON PARAMETRO DE DIAS HABILES 
   -- PARAMETRO NUMERO DE DIAS DE DISPERSION
   select @w_numero_dias = pa_int 
   from cobis..cl_parametro
   where pa_nemonico = 'DHFDD'
   --print @w_numero_dias
   
   -- PARAMETRO CODIGO CIUDAD FERIADOS NACIONALES
   select @w_ciudad_nacional = pa_int
   from   cobis..cl_parametro with (nolock)
   where  pa_nemonico = 'CIUN'
   and    pa_producto = 'ADM'
   --print @w_ciudad_nacional
   
   select @w_param_oferta_producto = isnull(pa_char, 'N')
   from cobis..cl_parametro 
   where pa_nemonico = 'OFEPRO'
   
   
   select @w_factor     = td_factor 
   from   cob_cartera..ca_tdividendo
   where  td_tdividendo = @i_tplazo
   and    td_estado     = 'V'
   
   select @w_factor  = isnull(@w_factor, 7)
   
   if @w_param_oferta_producto = 'S' begin
      select @w_dias_desplazados = @w_factor * isnull(@i_desplazamiento, 0) --Semanal
   end
   
   select @w_dias_desplazados = isnull(@w_dias_desplazados, 0)
   
   if @i_tplazo = 'BW' begin --BISEMANAL
      select @w_tplazo           ='W',   
             @w_tdividendo       ='W',   
             @w_periodo_cap      =2,   
             @w_periodo_int      =2      
   end
   else
   begin
      select @w_tplazo           = @i_tplazo,   
             @w_tdividendo       = @i_tdividendo,   
             @w_periodo_cap      = @i_periodo_cap,   
             @w_periodo_int      = @i_periodo_int
      
   end   
   
   print '@w_tplazo: ' + convert(varchar,@w_tplazo)
   print '@w_tdividendo: ' + convert(varchar,@w_tdividendo)
   print '@w_periodo_int: ' + convert(varchar,@w_periodo_int)
   print '@w_periodo_cap: ' + convert(varchar,@w_periodo_cap)
   -- FECHA DE PROCESO
   select @w_fecha_proceso = fp_fecha
   from cobis..ba_fecha_proceso
   --print @w_fecha_proceso
   --print 'FECHA DISPERSION'+convert(varchar(10),@i_fecha_dispersion,101)
   
   -----------------------------------------
   select @i_dia_pago = isnull(@i_dia_pago, @w_fecha_proceso)
   if exists (select 1 from cobis..cl_dias_feriados where df_fecha = @i_dia_pago and df_ciudad = @w_ciudad_nacional) begin
      print 'la fecha pago ingresada es feriado'
      select @w_error = 701195 -- fecha de pago incorrecta
      goto   ERROR
   end
   ------------------------------------------
   
   IF EXISTS (SELECT 1 FROM cobis..cl_dias_feriados WHERE df_fecha = @i_fecha_dispersion AND df_ciudad = @w_ciudad_nacional) begin
      print 'la fecha ingresada es feriado'
      select @w_error = 701194 -- fecha de dispersión incorrecta
      goto   ERROR
   end

   select @w_fecha_tmp = @w_fecha_proceso 
   -- VERIFICACION DE DIAS HABILES
   while @w_numero_dias >0
   begin
      select @w_fecha_tmp = DATEADD (dd, 1, @w_fecha_tmp)
      IF NOT EXISTS (SELECT 1 FROM cobis..cl_dias_feriados WHERE df_fecha = @w_fecha_tmp AND df_ciudad = @w_ciudad_nacional)
      begin
         set @w_fecha_hab_disp = @w_fecha_tmp
         set @w_numero_dias =@w_numero_dias-1             
      end 
   end
 


   -----------------------------------------
   if @i_fecha_dispersion < @w_fecha_proceso or  @i_fecha_dispersion > @w_fecha_hab_disp begin
      select @w_error = 701194 -- fecha de dispersión incorrecta
      goto   ERROR
   end

   ----------------------------------------------
   exec cob_cartera..sp_valida_diapago
    @i_banco            = @i_banco           ,
    @i_fecha_dispersion = @i_fecha_dispersion,
    @i_dia_pago         = @i_dia_pago        ,
    @i_periodo_int      = @w_periodo_int     ,
    @i_tplazo           = @w_tplazo          ,
    @o_fecha_inicio     = @w_fecha_ini_tmp out,
    @o_dia_inicio       = @w_dia_inicio    out,       
    @o_error            = @w_error         out
	
   if @w_error <> 0 begin
      select @w_error = @w_error
      goto   ERROR
   end
   print '@w_fecha_ini_tmp modifica: ' + convert(varchar, @w_fecha_ini_tmp) 
   print '@w_error modifica: ' + convert(varchar, @w_error) 
   ----------------------------------------------
  
   select @i_tramite = op_tramite
   from cob_cartera..ca_operacion
   where op_banco = @i_banco
   
   -- Actualizacion de la fecha de dispersion 
   -- en la tabla cob_credito en la columna agregada
   update cob_credito..cr_tramite
   set tr_fecha_dispersion = @w_fecha_ini_tmp--@i_fecha_dispersion
   where tr_tramite=@i_tramite
   
   -- Actualizacion de la fecha de dispersion 
   -- en vez de de la fecha liquidacion
   update cob_cartera..ca_operacion
   set op_fecha_ini = @w_fecha_ini_tmp,--@i_fecha_dispersion,
       op_fecha_liq = @w_fecha_ini_tmp--@i_fecha_dispersion
   where op_tramite = @i_tramite
  
   update cob_cartera..ca_operacion_tmp
   set opt_fecha_ini = @w_fecha_ini_tmp,--@i_fecha_dispersion,
       opt_fecha_liq = @w_fecha_ini_tmp--@i_fecha_dispersion
   where opt_tramite = @i_tramite
   
   select 
   @i_fecha_ini = @w_fecha_ini_tmp,
   @i_fecha_liq = @w_fecha_ini_tmp
end


--No es llamado de otro programa, se llama desde frontend
if @i_es_interno = 'N'
begin
  --crea tabla para calculo de TIR
  create table #dividendos_tea (
  operacion       int,
  dividendo       smallint,
  dias            int,
  cuota           money,
  amortiza        money,
  saldo_bloq_aho  money,
  saldo_bloq_cer  money
  )
end
else
  select @i_salida = 'N'

begin tran

if @i_doble_alicuota = 'S'
   select @i_clase_bloqueo = 'D'

--PRON:19JUN06 En actualizacion no modifica aun aqui al cliente
--sino hasta pasar a las tablas definitivas
select @i_upd_clientes = 'N'


if isnull(@i_tipo_amortizacion,'') <> '' --CLL REQ#3309
begin
   --CLL REQ#3180: Base de calculo
   select @w_dias_plazo = td_factor * @i_plazo
     from cob_cartera..ca_tdividendo
    where td_tdividendo = @i_tplazo

   select @w_dias_dividendo = td_factor * @i_periodo_cap
     from cob_cartera..ca_tdividendo
    where td_tdividendo = @i_tdividendo

   if (@w_dias_plazo / @w_dias_dividendo) = 1
      select @i_dias_anio = 365 --base de calculo pagos NO Periodicos (un solo dividendo)
   else
      select @i_dias_anio = 360 --base de calculo pagos Periodicos
end


if @i_operacionca is null
BEGIN

   --PRINT 'ES Tramite @i_operacionca ------------------------------'

     SELECT   @w_opt_tramite = opt_tramite,
              @w_opt_banco = opt_banco,
              @w_opt_operacion = opt_operacion,
              @w_sector       = opt_sector
     FROM cob_cartera..ca_operacion_tmp 
     WHERE opt_banco = @i_banco --// 5001015

end

--VALIDACION RANGO DE CUOTAS

exec @w_error = cob_cartera..sp_valida_plazo
        @i_operacion    = 'I',
        @i_operacionca  = @i_operacionca,
        @i_moneda       = @i_moneda,
        @i_toperacion   = @i_toperacion,
        @i_tplazo       = @i_tplazo,
        @i_plazo        = @i_plazo

   if @w_error <> 0
   begin
      select @o_tplazo = @i_tplazo,
             @o_plazo = @i_plazo
      goto ERROR
   end



exec @w_return = cob_pac..sp_modificar_ope_int_busin
     @s_user                 = @s_user,
     @s_sesn                 = @s_sesn,
     @s_date                 = @s_date,
     @s_term                 = @s_term,
     @s_ofi                  = @s_ofi,
     @i_calcular_tabla       = @i_calcular_tabla,
     @i_tabla_nueva          = @i_tabla_nueva,
     @i_operacionca          = @i_operacionca,
     @i_banco                = @i_banco,
     @i_anterior             = @i_anterior,
     @i_migrada              = @i_migrada,
     @i_tramite              = @i_tramite,
     @i_cliente              = @i_cliente,
     @i_nombre               = @i_nombre,
     @i_sector               = @i_sector,
     @i_toperacion           = @i_toperacion,
     @i_oficina              = @i_oficina,
     @i_moneda               = @i_moneda,
     @i_comentario           = @i_comentario,
     @i_oficial              = @i_oficial,
     @i_fecha_ini            = @i_fecha_ini,
     @i_fecha_fin            = @i_fecha_fin,
     @i_fecha_ult_proceso    = @i_fecha_ult_proceso,
     @i_fecha_liq            = @i_fecha_liq,
     @i_fecha_reajuste       = @i_fecha_reajuste,
     @i_monto                = @i_monto,
     @i_monto_aprobado       = @i_monto_aprobado,
     @i_destino              = @i_destino,
     @i_lin_credito          = @i_lin_credito,
     @i_ciudad               = @i_ciudad,
     @i_estado               = @i_estado,
     @i_periodo_reajuste     = @i_periodo_reajuste,
     @i_reajuste_especial    = @i_reajuste_especial,
     @i_tipo                 = @i_tipo,
     @i_forma_pago           = @i_forma_pago,
     @i_cuenta               = @i_cuenta,
     @i_dias_anio            = @i_dias_anio,
     @i_tipo_amortizacion    = @i_tipo_amortizacion,
     @i_cuota_completa       = @i_cuota_completa,
     @i_tipo_cobro           = @i_tipo_cobro,
     @i_tipo_reduccion       = @i_tipo_reduccion,
     @i_aceptar_anticipos    = @i_aceptar_anticipos,
     @i_precancelacion       = @i_precancelacion,
     @i_tipo_aplicacion      = @i_tipo_aplicacion,
     @i_tplazo               = @w_tplazo,--@i_tplazo,
     @i_plazo                = @i_plazo,
     @i_tdividendo           = @w_tdividendo,--@i_tdividendo,
     @i_periodo_cap          = @w_periodo_cap,
     @i_periodo_int          = @w_periodo_int,
     @i_dist_gracia          = @i_dist_gracia,
     @i_gracia_cap           = @i_gracia_cap,
     @i_gracia_int           = @i_gracia_int,
     @i_dia_fijo             = @i_dia_fijo,
     @i_cuota                = @i_cuota,
     @i_evitar_feriados      = @i_evitar_feriados,
     @i_num_renovacion       = @i_num_renovacion,
	  @i_activa_TirTea		 = @i_activa_TirTea,     --JMORAN 23Mar2016 Se agrega impresion mensaje TIR-TEA
     @i_renovacion           = @i_renovacion,
     @i_mes_gracia           = @i_mes_gracia,
     @i_formato_fecha        = @i_formato_fecha,
     @i_upd_clientes         = @i_upd_clientes,
     @i_dias_gracia          = @i_dias_gracia,
     @i_reajustable          = @i_reajustable,
     @i_fijo_desde           = @i_fijo_desde,  --JG Y BP
     @i_fijo_hasta           = @i_fijo_hasta,   --JG Y BP
     @i_cta_certificado      = @i_cta_certificado,
     @i_cta_ahorro	        = @i_cta_ahorro,
     @i_tipo_bloqueo	        = @i_tipo_bloqueo,
     @i_clase_bloqueo        = @i_clase_bloqueo,
     @i_doble_alicuota       = @i_doble_alicuota,
     @i_alicuota             = @i_alicuota,
     @i_alicuota_aho         = @i_alicuota_aho,  -- LGU ini 27.03.2002
     @i_actividad_destino    = @i_actividad_destino,
     @i_compania             = @i_compania,
     @i_tipo_cca             = @i_tipo_cca,      -- LGU fin 09.04.2002
     @i_salida               = @i_salida,
     @i_reaj_diario          = @i_reaj_diario,
     @i_seg_cre              = @i_seg_cre, --SRA SEGMENTO CREDITO 14/092007
     @i_prodbanc_aho         = @i_prodbanc_aho,
     @i_prodbanc_cer         = @i_prodbanc_cer,
     @i_base_calculo         = @i_base_calculo,
     @i_es_interno           = @i_es_interno,              --PRON:9MAY08
     @i_base_dias_int        = @i_base_dias_int,
     @i_p_cuota		        = @i_p_cuota,                 --cll REQ-956 Obligaciones Financieras
     @i_fecha_redescuento    = @i_fecha_redescuento,       --APE REQ-2400 Aumento del campo fecha de redescuento en la fgenamor de cartera,
     @i_entra_fecha_redes    = @i_entra_fecha_redes,
     @i_parroquia            = @i_parroquia,
	 @i_desplazamiento       = @i_desplazamiento,
     @o_cta_ahorro           = @o_cta_ahorro output,       --PRON:28AGO06
     @o_cta_certificado      = @o_cta_certificado output,  --PRON:28AGO06
	 --Implantación Originador CPN
	  @o_tea                  = @o_tea    output,
     @o_tir                  = @o_tir    output,
     @o_plazo                = @o_plazo  output,
     @o_tplazo               = @o_tplazo output,
     @o_cuota                = @o_cuota  output

if @w_return <> 0 begin
   select @w_error = @w_return
   goto   ERROR
end

select @o_tplazo = case when @o_tplazo = 'W' and @i_periodo_int = 2 and @i_periodo_cap = 2 then 'BW' else @o_tplazo end

if @w_dias_desplazados > 0 and @i_toperacion = 'GRUPAL' begin
  select     @i_operacionca  = opt_operacion,
             @i_cliente      = opt_cliente,
             @w_fecha_ini    = opt_fecha_ini
   from cob_cartera..ca_operacion_tmp
   where opt_banco = @i_banco   
  
   if (select datediff(dd, dit_fecha_ini, dit_fecha_ven) from cob_cartera..ca_dividendo_tmp where dit_operacion = @i_operacionca and dit_dividendo = 1) < @w_dias_desplazados begin
      print '@i_banco: '+ @i_banco
      print '@i_cliente: '+ convert(varchar,@i_cliente)
      print '@w_fecha_proceso: '+ convert(varchar,@w_fecha_proceso)
      print '@i_desplazamiento:' + convert(varchar,@i_desplazamiento)
      
      exec @w_error      = cob_cartera..sp_desplazamiento
      @i_banco           = @i_banco,
      @i_cliente         = @i_cliente,
      @i_fecha_valor     = @w_fecha_ini,--@w_fecha_proceso,
      @i_cuotas          = @i_desplazamiento,
      @i_archivo         = 'WORKFLOW',
      @i_oper_nueva      = 'S'
      
      if @w_error <> 0 
         goto ERROR
	  
   end
 
end     

exec @w_return = cob_cartera..sp_dia_pago
  @i_banco            = @i_banco,
  @i_fecha_inicio     = @w_fecha_ini_tmp,
  @i_num_dias         = @w_dia_inicio
 

--select * from cob_cartera..ca_operacion_tmp where opt_banco = 
   
exec @w_return = cob_cartera..sp_pasodef
     @i_banco           = @i_banco,
     @i_dividendo       = 'S',
     @i_amortizacion    = 'S',
     @i_cuota_adicional = 'S',
     @i_rubro_op        = 'S',
     @i_operacionca     = 'S' 


commit tran
return 0

ERROR:
if @i_es_interno = 'N'
begin
  exec cobis..sp_cerror
       @t_debug='N',
       @t_file = null,
       @t_from =@w_sp_name,
       @i_num = @w_error
    --   @i_cuenta= ' '
end
return @w_error

go

