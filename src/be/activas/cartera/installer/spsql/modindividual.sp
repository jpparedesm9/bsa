
use cob_cartera
go

/************************************************************************/
/*   Archivo:              modindividual.sp                             */
/*   Stored procedure:     sp_modificar_individual                      */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Andy Gonzalez                                */
/*   Fecha de escritura:   Nov-06-2019|                                 */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/*  Modificar desde WF las operaciones Individuales(Consumo,Vivienda,   */
/*  Prendario,Microcredito, etc.)                                       */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*   12/11/2019      A. Gonzalez       Ajustes de montos                */
/*   17/09/2020      S. Rojas          Req #140073                      */
/*   07/20/2021      A. Gonzalez       Ajustes BW Cred. Simple          */
/*   30/20/2021      A. Chiluisa       #162288 Cliente no puede ser aval*/
/*   25/11/2022      ACH               REQ#194284 Dia de Pago           */
/************************************************************************/

if exists (select 1 from sysobjects where name = 'sp_modificar_individual')
    drop proc sp_modificar_individual
go
create proc sp_modificar_individual(
@s_srv                   varchar(30),
@s_lsrv                  varchar(30),
@s_ssn                   int,
@s_user                  login,
@s_term                  varchar(30),
@s_date                  datetime,
@s_sesn                  int,
@s_ofi                   smallint,
@t_debug                 char(1)     = 'N',
@t_file                  varchar(10) = null,    
@t_trn                   int          = null,
@i_operacion             varchar(1)   = null,   
@i_calcular_tabla        varchar(1)   = 'N',    
@i_tabla_nueva           varchar(1)   = 'S',    
@i_operacionca           int          = null,   
@i_banco                 cuenta       = null,   
@i_tipo                  varchar(1)   = 'O',    
@i_anterior              cuenta       = null,   
@i_migrada               cuenta       = null,   
@i_tramite               int          = null,   
@i_cliente               int 	     = 0,      
@i_nombre                descripcion  = null,     
@i_sector                catalogo     = null,   
@i_toperacion            catalogo     = null,   
@i_oficina               smallint     = null,   
@i_moneda                tinyint      = null,   
@i_comentario            varchar(255) = null,   
@i_oficial               smallint     = null,   
@i_fecha_ini             datetime     = null,   
@i_fecha_fin             datetime     = null,   
@i_fecha_ult_proceso     datetime     = null,   
@i_fecha_liq             datetime     = null,   
@i_fecha_reajuste        datetime     = null,   
@i_monto                 money        = null,
@i_monto_aprobado        money        = null,
@i_destino               catalogo     = null,
@i_lin_credito           cuenta       = null,
@i_ciudad                int          = null,
@i_estado                tinyint      = null,
@i_periodo_reajuste      smallint     = 0,
@i_reajuste_especial     varchar(1)   = 'N',     
@i_forma_pago            catalogo     = null,    
@i_cuenta                cuenta       = null,    
@i_dias_anio             smallint     = null,    
@i_tipo_amortizacion     varchar(10)  = null,    
@i_cuota_completa        varchar(1)   = null,    
@i_tipo_cobro            varchar(1)   = null,    
@i_tipo_reduccion        varchar(1)   = null,    
@i_aceptar_anticipos     varchar(1)   = null,    
@i_precancelacion        varchar(1)   = null,    
@i_tipo_aplicacion       varchar(1)   = null,    
@i_tplazo                catalogo     = null,    
@i_plazo                 int          = null,    
@i_tdividendo            catalogo     = null,    
@i_periodo_cap           int          = null,    
@i_periodo_int           int          = null,    
@i_dist_gracia           varchar(1)   = null,    
@i_gracia_cap            int          = null,    
@i_gracia_int            int          = null,    
@i_dia_fijo              int          = null,    
@i_cuota                 money        = 0,    
@i_evitar_feriados       varchar(1)   = null,    
@i_num_renovacion        int          = 0,       
@i_renovacion            varchar(1)   = null,    
@i_mes_gracia            tinyint      = null,    
@i_upd_clientes          varchar(1)   = 'U',     
@i_dias_gracia           smallint     = null,    
@i_reajustable           varchar(1)   = null,    
@i_es_interno            varchar(1)   = 'N',     
@i_formato_fecha         int          = 101,
@i_no_banco 	            varchar(1)   = 'S',
@i_grupal                char(1)	     = null,
@i_banca                 catalogo     = null,
@i_en_linea              varchar(1)   = 'S',
@i_externo               varchar(1)   = 'S',
@i_desde_web             varchar(1)   = 'S',
@i_salida                varchar(1)   = 'N',
@i_promocion             char(1)      = null,
@i_acepta_ren            char(1)      = null,
@i_no_acepta             char(1000)   = null,
@i_emprendimiento        char(1)      = null,
@i_garantia              float        = null,
@i_alianza               int          = null,  
@i_ciudad_destino        int          = null,
@i_experiencia_cli       char(1)      = null,
@i_monto_max_tr          money        = null,
@i_desplazamiento        int          = 0,
@i_tasa                  float        = null,
@o_banco                 cuenta      = null out,
@o_operacion             int         = null out,
@o_tramite               int         = null out,
@o_plazo                 smallint    = null out,
@o_tplazo                catalogo    = null out,
@o_cuota                 money       = null out,
@o_msg                   varchar(100) = null out,
@o_tasa_grp              varchar(255) = null out
)as 

declare
@w_sp_name              varchar(64),
@w_return               int,
@w_error                int,   
@w_fecha_proceso        datetime,
@w_banco                cuenta,
@w_ced_ruc              varchar(15),
@w_ced_ruc_codeudor     varchar(15),
@w_nombre               varchar(60),
@w_prod_cobis		    smallint,   
@w_tramite              int,
@w_tplazo               catalogo,
@w_plazo                smallint,
@w_commit               char(1),
@w_dias_plazo           smallint,
@w_moneda               smallint,
@w_dias_dividendo       int,
@w_toperacion           catalogo,
@w_filas_rec            int,
@w_op_estado            smallint,
@w_monto_min            money,
@w_monto_aprobado       money,
@w_monto_aprobado_tmp   money,
@w_valida_bloqueos      char(1),
@w_doble_alicuota       char(1),
@w_est_novigente        tinyint,
@w_est_credito          tinyint,
@w_clase_bloqueo        char(1),
@w_cliente              int,
@w_dias_gracia          int,
@w_monto                money,
@w_fecha_reajuste       datetime,
@w_monto_tmp            money,
@w_monto_max            money,
@w_fecha_fin            datetime,
@w_fecha_f              datetime,
@w_fecha_ini            datetime,
@w_estado               char(1),
@w_razon                catalogo = null,
@w_txt_razon            varchar(255) = null,
@w_tr_fecha_ini         datetime = null,
@w_tr_num_dias          smallint = 0,
@w_tr_monto             money = 0,
@w_tr_plazo             smallint = null,
@w_tr_monto_soli        money    = null,
@w_miembros 			int,
@w_monto_antes_aux      money,
@w_promocion            char(1)    = null,
@w_acepta_ren           char(1)    = null,
@w_no_acepta            char(1000) = null,
@w_emprendimiento       char(1)    = null,
@w_garantia             float      = null,
@w_tr_tplazo            catalogo   = null,
@w_alianza              int        = null,
@i_w_alianza            int        = null,
@i_w_ciudad_destino     int        = null, 
@i_w_experiencia_cli    char(1)    = null, 
@i_w_monto_max_tr       money      = null, 
@w_ofi_def_app_movil    smallint,
@w_grupo                int        = null,
@w_oficina_aux          int        = null,
@w_tg_prestamo          varchar(20),
@w_tg_operacion         int,
@w_nueva_op_aux         int,
@w_tramite_hijo         int,
@w_estado_cl            varchar(2),
@w_val_ahorro_vol       float ,
@w_base_calculo         char(1), 
@w_paso_actual          int         ,
@w_codigo_actividad     int         ,
@w_desc_actividad       varchar(255),
@w_procesa_gentabla     char(1),
@w_fecha_liq            datetime,
@w_tramite_anterior     int,
@w_promo_anterior       char(1),
@w_ciclo                int,
@w_porcen_colateral     float,
@w_operacionca          int, 
@w_tir                  float, 
@w_tea                  float, 
@w_cat                  float,
@w_aux_monto            money,
@w_aux_monto_aprobado   money,
@w_msg                   varchar(100),
@w_desplazamiento        int,
@w_param_oferta_producto char(1),
@w_dias_desplazados      int,
@w_factor                int,
@w_desplazamiento_aux    int,
@w_tasa                  float ,
@w_tdividendo           char(1),
@w_periodo_cap      int,
@w_periodo_int      int,
@w_fecha_dispercion datetime,
@w_dia_inicio       int,
@v_fecha_dispercion datetime,
@v_fecha_ini        datetime,
@v_dia_inicio       int,
@v_fecha_dia_pag    datetime,
@w_fecha_inicio     datetime,
@w_fecha_ini_tmp     datetime,
@w_id_proceso        int, 
@w_id_inst_act_max   int

select @w_fecha_proceso = fc_fecha_cierre
from   cobis..ba_fecha_cierre
where  fc_producto = 7

select @w_id_proceso = io_id_inst_proc 
from cob_workflow..wf_inst_proceso 
where io_campo_3 = @i_tramite

select @w_id_inst_act_max = max(ia_id_inst_act) 
from cob_workflow..wf_inst_actividad
where ia_id_inst_proc = @w_id_proceso

if exists ( select 1 from cob_workflow..wf_inst_actividad
            where ia_id_inst_proc IN (@w_id_proceso) 
            and ia_id_inst_act = @w_id_inst_act_max
            and ltrim(ia_nombre_act) in (select ltrim(valor) from cobis..cl_catalogo 
                                         where tabla in (select codigo from cobis..cl_tabla where tabla = 'eli_reg_dia_pago')
                                         and estado = 'V')) begin
    print 'Ingreso a etapas del catalogo eli_reg_dia_pago'
    delete cob_cartera..ca_dia_pago where dp_banco = @i_banco    
end

if exists(select 1 from cob_cartera..ca_dia_pago where dp_banco = @i_banco) begin -- se agrega porque se recalculaba la tabla de amortizacion, dividiendo su plazo a la mitad
    select @i_fecha_ini = dp_ini_operacion_tmp,
	       @w_dia_inicio = dp_dias_regla,
		   @w_fecha_dispercion = dp_fecha_dispercion
	from cob_cartera..ca_dia_pago where dp_banco = @i_banco 
end else 
    select @w_dia_inicio = 0

if (@i_cliente = @i_alianza) -- caso#162288. Definicion, producto de las pruebas
begin
    select 
    @w_msg  = 'ERROR: El cliente no puede ser Aval' ,
    @w_error= 2108088
    GOTO ERROR_PROCESO
end

select 
@w_sp_name          = 'sp_modificar_individual',
@w_commit           = 'N',
@w_oficina_aux      = @i_oficina,
@w_procesa_gentabla = 'N',
@i_tdividendo       = @i_tplazo

/* Se invirte el orden de las variables de monto solicitado y monto autorizado, el cambio es por conceptos */
select @w_aux_monto = @i_monto
select @w_aux_monto_aprobado = @i_monto_aprobado
/* Invertir */
select @i_monto = @w_aux_monto_aprobado
select @i_monto_aprobado = @w_aux_monto

-- 'NUMERO DE OFICINA POR DEFECTO DEL APP MOVIL'
select @w_ofi_def_app_movil = pa_smallint from cobis..cl_parametro 
where  pa_nemonico = 'OFIAPP' 
and    pa_producto = 'CRE'

if(@i_oficina = @w_ofi_def_app_movil) begin
	select @i_oficina = fu_oficina	
	from   cobis..cl_funcionario, cobis..cc_oficial
	where  oc_oficial     = @i_oficial
	and    oc_funcionario = fu_funcionario
end

if @i_es_interno = 'S' select @i_salida = 'N'


exec @w_error = sp_estados_cca
@o_est_novigente  = @w_est_novigente out,
@o_est_credito    = @w_est_credito   out

--SRO. 140073
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

select @w_toperacion = isnull(@w_toperacion, @i_toperacion)
select @w_moneda = isnull(@w_moneda, @i_moneda)

select 
@w_monto_min         = dt_monto_min,
@w_monto_max         = dt_monto_max,
@w_plazo             = case when @w_toperacion <> 'GRUPAL' then isnull(@i_plazo, dt_plazo)
                            when @w_param_oferta_producto = 'N' and  @w_toperacion = 'GRUPAL'  then dt_plazo
                            when @w_param_oferta_producto = 'S' and  @w_toperacion = 'GRUPAL'  then isnull(@i_plazo, dt_plazo)
					   end,
@w_desplazamiento_aux = case when @w_toperacion <> 'GRUPAL' then isnull(@i_desplazamiento, dt_desplazamiento)
                            when @w_param_oferta_producto = 'N' and  @w_toperacion = 'GRUPAL'  then dt_desplazamiento
                            when @w_param_oferta_producto = 'S' and  @w_toperacion = 'GRUPAL'  then isnull(@i_desplazamiento, dt_desplazamiento)
					   end							
from   cob_cartera..ca_default_toperacion
where  dt_toperacion = @w_toperacion
and    dt_moneda     = @w_moneda

if isnull(@i_tipo_amortizacion,'') <> '' begin
   select @w_dias_plazo = td_factor * @w_plazo
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


if isnull(@i_monto_aprobado, 0) > 0  begin

   if isnull(@w_monto_min,0) > 0 or isnull(@w_monto_max,0) > 0 begin
   
      if @i_monto_aprobado < @w_monto_min or @i_monto_aprobado > @w_monto_max begin
	    select 
		@w_msg  = 'ERROR: MONTO APROBADO MENOR AL MINIMO' ,
		@w_error= 724608
		GOTO ERROR_PROCESO
      end
   end
   
end

if @@trancount = 0 begin
   begin tran
   select @w_commit = 'S'
end   

if exists(select 1 from ca_operacion_tmp where opt_banco = @i_banco and @i_en_linea = 'N') begin
   -- BORRAR LA TEMPORAL
   exec @w_error = sp_borrar_tmp
   @s_user      = @s_user,
   @s_term      = @s_term,
   @s_sesn      = @s_sesn,
   @i_desde_cre = 'N',
   @i_banco     = @i_banco 
   
   if @w_error  <> 0 begin
      select 
      @w_msg  = 'ERROR: ERROR EN BORRADO DE TEMPORALES' ,
      @w_error= 713220
      goto ERROR_PROCESO
   end
  
end

if @i_en_linea = 'N' begin
   
   ---PASAR A TEMPRALES CON LOS ULTIMOS DATOS    
   exec @w_error       = sp_pasotmp
   @s_term             = @s_term,
   @s_user             = @s_user,
   @i_banco            = @i_banco,
   @i_operacionca      = 'S',
   @i_dividendo        = 'S',
   @i_amortizacion     = 'S',
   @i_cuota_adicional  = 'S',
   @i_rubro_op         = 'S',
   @i_nomina           = 'S' 
     
   if @w_error != 0 begin
      select 
      @w_msg  = 'ERROR: EN EL PASO A TEMPORALES' ,
      @w_error= 710201
      goto ERROR_PROCESO
   end

end

select 
@w_operacionca    = opt_operacion,
@w_toperacion     = opt_toperacion,
@w_moneda         = opt_moneda,
@w_cliente        = opt_cliente,
@w_op_estado      = opt_estado,
@w_monto          = isnull(@i_monto,opt_monto_aprobado),
@w_monto_aprobado = isnull(@i_monto_aprobado,opt_monto_aprobado),
@w_tramite        = opt_tramite,
@w_banco          = opt_banco,
@w_fecha_ini      = isnull(@i_fecha_ini,opt_fecha_ini),
@w_fecha_liq      = opt_fecha_liq,
@w_base_calculo   = opt_base_calculo, --LGU
@w_porcen_colateral = opt_margen_redescuento,
@w_desplazamiento   = opt_desplazamiento
from   cob_cartera..ca_operacion_tmp
where  opt_banco = @i_banco

if @@rowcount = 0 begin
   select 
   @w_msg  = 'ERROR: NO EXISTE OPERACION EN TEMPORALES' ,
   @w_error= 710202
   goto ERROR_PROCESO
end

if @w_desplazamiento_aux >  0 and @w_desplazamiento_aux is not null and @w_desplazamiento_aux <> @w_desplazamiento
   select @w_desplazamiento = @w_desplazamiento_aux
   
select @w_tasa = isnull(rot_porcentaje,@i_tasa) 
from ca_rubro_op_tmp
where rot_operacion = @w_operacionca 
and rot_concepto = 'INT'  
--PARA SIMULACION DE OPERACIONES SE DEBE ENVIAR EL CODIGO -666
if @w_cliente = -666 select @i_cliente = @w_cliente

if @i_ciudad=0 select  @i_ciudad=null

if @w_fecha_liq is not null and @w_fecha_liq > @i_fecha_ini
   select @i_fecha_ini = @w_fecha_liq

select @i_tramite = isnull(@i_tramite, @w_tramite)

select @i_tplazo = isnull (@i_tplazo, 'W') -- AGO por error en la creacion de tramite grupal desde la movil

if @i_tplazo = 'W' begin --SEMANAL ---PERIODICIDAD DE PAGO 

   select 
   @w_tplazo           ='W',
   @w_tdividendo       ='W',
   @w_periodo_cap      =1,
   @w_periodo_int      =1
   
  end 


if @i_tplazo = 'BW' begin --BISEMANAL

   select 
   @w_tplazo           ='W',
   @w_tdividendo       ='W',
   @w_periodo_cap      =2,
   @w_periodo_int      =2
   
   
end 


if @i_tplazo = 'M' begin --MENSUAL---PERIODICIDAD DE PAGO 

   select 
   @w_tplazo           ='M',
   @w_tdividendo       ='M',
   @w_periodo_cap      =1,
   @w_periodo_int      =1
   
end 



exec @w_error          = sp_operacion_tmp
@s_user                = @s_user,
@s_sesn                = @s_sesn,
@s_date                = @s_date,
@i_operacion           = 'U',
@i_operacionca         = @w_operacionca ,
@i_banco               = @i_banco ,
@i_anterior            = @i_anterior,
@i_migrada             = @i_migrada,
@i_tramite             = @i_tramite,
@i_cliente             = @i_cliente,
@i_nombre              = @i_nombre,
@i_sector              = @i_sector,
@i_toperacion          = @i_toperacion,
@i_oficina             = @i_oficina,
@i_moneda              = @i_moneda, 
@i_comentario          = @i_comentario,
@i_oficial             = @i_oficial,
@i_fecha_ini           = @i_fecha_ini,
@i_fecha_fin           = @i_fecha_fin,
@i_fecha_ult_proceso   = @i_fecha_ult_proceso,
@i_fecha_liq           = @i_fecha_liq,
@i_fecha_reajuste      = @i_fecha_reajuste, 
@i_monto               = @i_monto, 
@i_monto_aprobado      = @i_monto_aprobado,
@i_destino             = @i_destino,
@i_lin_credito         = @i_lin_credito,
@i_ciudad              = @i_ciudad,
@i_estado              = @i_estado,
@i_periodo_reajuste    = @i_periodo_reajuste,
@i_reajuste_especial   = @i_reajuste_especial,
@i_tipo                = @i_tipo, 
@i_forma_pago          = @i_forma_pago,
@i_cuenta              = @i_cuenta,
@i_dias_anio           = @i_dias_anio, 
@i_tipo_amortizacion   = @i_tipo_amortizacion,
@i_cuota_completa      = @i_cuota_completa,
@i_tipo_cobro          = @i_tipo_cobro,
@i_tipo_reduccion      = @i_tipo_reduccion,
@i_aceptar_anticipos   = @i_aceptar_anticipos,
@i_precancelacion      = @i_precancelacion,
@i_tipo_aplicacion     = @i_tipo_aplicacion,
@i_tplazo              = @w_tplazo,
@i_plazo               = @i_plazo,
@i_tdividendo          = @w_tdividendo,
@i_periodo_cap         = @w_periodo_cap,
@i_periodo_int         = @w_periodo_int,
@i_dist_gracia         = @i_dist_gracia,
@i_gracia_cap          = @i_gracia_cap,
@i_gracia_int          = @i_gracia_int,
@i_dia_fijo            = @i_dia_fijo,
@i_cuota               = @i_cuota,
@i_evitar_feriados     = @i_evitar_feriados,
@i_renovacion          = @i_renovacion,
@i_mes_gracia          = @i_mes_gracia,
@i_reajustable         = @i_reajustable,
@i_dias_clausula       = null,
@i_base_calculo        = @w_base_calculo, 
@i_recalcular          = null,
@i_tipo_empresa        = 1, 
@i_tipo_crecimiento    = 'A',   
@i_banca               = @i_banca,
@i_grupal              = @i_grupal,
@i_promocion           = @i_promocion,     
@i_acepta_ren          = @i_acepta_ren,    
@i_no_acepta           = @i_no_acepta,     
@i_emprendimiento      = @i_emprendimiento,
@i_porcen_colateral    = @w_porcen_colateral,
@i_desplazamiento      = @w_desplazamiento

if @w_error <> 0 begin
   select 
   @w_msg  = 'ERROR: EN EL ACTUALIZACION DE TEMPORALES' ,
   @w_error= 710221
   goto ERROR_PROCESO
end

-- DIAS DE GRACIA CUANDO LLAMO DESDE RUBROS
select @w_dias_gracia =dit_gracia
from cob_cartera..ca_dividendo_tmp
where dit_operacion = @i_operacionca 
and dit_dividendo = 1

if @i_dias_gracia is null
   select @i_dias_gracia = isnull(@w_dias_gracia,0)

select 
@i_monto   = isnull(@i_monto, @w_monto),
@i_monto_aprobado = isnull(@i_monto_aprobado, @w_monto_aprobado)



if @i_calcular_tabla = 'N' and @w_op_estado in (@w_est_novigente, @w_est_credito) begin
    
   exec cob_credito..sp_busca_etapa_tramite
   @i_tramite          = @i_tramite              ,
   @o_paso_actual      = @w_paso_actual       out,
   @o_codigo_actividad = @w_codigo_actividad  out,
   @o_desc_actividad   = @w_desc_actividad    out
    
   if exists(select 1 
              from cobis..cl_tabla t, cobis..cl_catalogo c
              where t.tabla  = 'cr_etapa_genera_tabla'
              and   t.codigo = c.tabla
              and   c.codigo = convert(varchar(8),@w_codigo_actividad))
           select @w_procesa_gentabla = 'S'
   
    if (@i_monto <> 0 and @i_monto <> @w_monto) or (@i_monto_aprobado <> 0 and @i_monto_aprobado <> @w_monto_aprobado) 
	or @w_procesa_gentabla = 'S' or (@i_plazo <> @w_plazo) or (@i_desplazamiento <> @w_desplazamiento) 
	begin
	   select @i_calcular_tabla = 'S'
	end
end


if @i_calcular_tabla = 'S' begin


   /* GENERACION DE LA TABLA DE AMORTIZACION */
   exec @w_error = sp_gentabla
   @i_operacionca = @w_operacionca,
   @i_tabla_nueva = 'S',
   @i_actualiza_rubros = 'N',
   @i_tasa             =  @w_tasa ,
   @o_fecha_fin = @w_fecha_fin out
  

   if @w_error != 0 begin
      select 
      @w_msg  = 'ERROR: EN EL GENERACION DE TABLA DE AMORT' ,
      @w_error= 710999
      goto ERROR_PROCESO
   end

   
   -- ACTUALIZACION DE LA OPERACION 
   if isnull(@i_periodo_reajuste,0) != 0 begin
   
      select @w_fecha_reajuste = min(re_fecha)
      from   cob_cartera..ca_reajuste
      where  re_operacion = @i_operacionca
      and    re_fecha    >= @i_fecha_ult_proceso

      select @w_fecha_reajuste = isnull(@i_fecha_reajuste,@w_fecha_reajuste)
   end 
   else 
      select @w_fecha_reajuste = '01/01/1900'
	  

   --CONTROL DEL MONTO SEA MENOR O IGUAL AL MONTO APROBADO
   select 
   @w_monto_tmp          = opt_monto,
   @w_monto_aprobado_tmp = opt_monto_aprobado,
   @w_fecha_ini          = opt_fecha_ini
   from  cob_cartera..ca_operacion_tmp
   where opt_banco = @i_banco

   if @w_monto_tmp > @w_monto_aprobado_tmp begin
      print 'inconsistencia en monto aprobado'
     -- select @w_error = 710024
      --goto ERROR_PROCESO
   end   


   update cob_cartera..ca_operacion_tmp
   set opt_fecha_fin  = @w_fecha_fin,
   opt_fecha_reajuste = @w_fecha_reajuste,
   opt_plazo          = @o_plazo,
   opt_tplazo         = @o_tplazo
   where opt_operacion = @i_operacionca

   if @@error != 0  begin
      select 
      @w_msg  = 'ERROR: EN EL ACTUALIZACION  DE TABLAS TEMPORALES' ,
      @w_error= 710999
      goto ERROR_PROCESO
   end
   
   
   --SE DISPLAYA DATOS AL FRONTEND DESDE LA PANTALLA FGENAMORTIZACION
   if @i_salida = 'S' begin
      
	  select @w_fecha_f  = convert(varchar(10),@w_fecha_fin,@i_formato_fecha)

      select 
	  @w_fecha_f,     --1
      @o_cuota,
      @o_plazo,       --3
      @o_tplazo,
      td_descripcion  --5
      from  cob_cartera..ca_tdividendo
      where td_tdividendo = @o_tplazo 
	  
   end
end


--MODIFICAR TRAMITE DEBIDO AL RECHAZO


if isnull(@i_tramite, 0) > 0 and (@w_op_estado in (@w_est_novigente, @w_est_credito))
begin

   select 
   @w_estado         = tr_estado,
   @w_razon          = tr_razon,
   @w_txt_razon      = tr_txt_razon,
   @w_tr_fecha_ini   = tr_fecha_inicio,
   @w_tr_num_dias    = tr_num_dias,   
   @w_tr_monto       = tr_monto,
   @w_tr_monto_soli  = tr_monto_solicitado,
   @w_tr_plazo       = tr_plazo,
   @w_promocion      = tr_promocion,
   @w_acepta_ren     = tr_acepta_ren,
   @w_no_acepta      = tr_no_acepta,
   @w_emprendimiento = tr_emprendimiento,
   @w_garantia       = isnull(tr_porc_garantia,0),
   @w_tr_tplazo      = tr_tipo_plazo,
   @w_alianza        = isnull(tr_alianza,0),
   @i_w_ciudad_destino   = tr_ciudad_destino,
   @i_w_experiencia_cli  = tr_experiencia,
   @i_w_monto_max_tr     = tr_monto_max
   from cob_credito..cr_tramite
   where tr_tramite = @i_tramite

   if @@rowcount = 0 begin
      select 
      @w_msg  = 'ERROR: NO EXISTE REGISTRO EN TRAMITE' ,
      @w_error= 212882
      goto ERROR_PROCESO
   end
   
   --Almacena el valor del monto antes de actualizar para comparar
	--con el valor de ingreso y asi realizar la divisi=n para grupos
    select  @w_monto_antes_aux = tr_monto
    from    cob_credito..cr_tramite 
    where   tr_tramite = @i_tramite

  if @i_tplazo = 'BW' select @i_tplazo = 'W'
  
   exec @w_error        = cob_credito..sp_up_tramite_cca
   @s_date               = @s_date,
   @s_lsrv               = @s_lsrv,
   @s_ofi                = @s_ofi,
   @s_sesn               = @s_sesn,
   @s_srv                = @s_srv,
   @s_ssn                = @s_ssn,
   @s_term               = @s_term,
   @s_user               = @s_user,
   @t_trn                = @t_trn,
   @i_operacion	       = 'U',
   @i_tramite            = @i_tramite,
   @i_fecha_inicio       = @i_fecha_ini,
   @i_num_dias           = @w_plazo,
   @i_monto              = @i_monto,
   @i_grupal             = @i_grupal,
   @i_monto_solicitado   = @i_monto_aprobado,
   @i_plazo              = @w_plazo,
   @i_tplazo             = @i_tplazo,   -- Santander
   @i_estado             = @i_estado,
   @i_w_estado           = @w_estado,
   @i_w_razon            = @w_razon,
   @i_w_txt_razon        = @w_txt_razon,
   @i_w_numero_op_banco  = @i_banco,
   @i_w_fecha_inicio     = @w_tr_fecha_ini,
   @i_w_num_dias         = @w_tr_num_dias,
   @i_w_monto            = @w_tr_monto,
   @i_w_plazo            = @w_tr_plazo,
   @i_w_monto_solicitado = @w_tr_monto_soli,
   @i_promocion          = @i_promocion,      
   @i_acepta_ren         = @i_acepta_ren,     
   @i_no_acepta          = @i_no_acepta,      
   @i_emprendimiento     = @i_emprendimiento, 
   @i_garantia           = @i_garantia,       
   @i_w_promocion        = @w_promocion,      
   @i_w_acepta_ren       = @w_acepta_ren,     
   @i_w_no_acepta        = @w_no_acepta,      
   @i_w_emprendimiento   = @w_emprendimiento, 
   @i_w_garantia         = @w_garantia,          
   @i_w_tplazo           = @w_tr_tplazo,
   @i_alianza            = @i_alianza,
   @i_w_alianza          = @w_alianza,
   @i_ciudad_destino     = @i_ciudad_destino, --Santander
   @i_experiencia_cli    = @i_experiencia_cli, --Santander
   @i_monto_max_tr       = @i_monto_max_tr, --Santander
   @i_w_ciudad_destino   = @i_w_ciudad_destino,
   @i_w_experiencia_cli  = @i_w_experiencia_cli,
   @i_w_monto_max_tr     = @i_w_monto_max_tr,
   @o_tasa_grp           = @o_tasa_grp out


   if @w_error <> 0   begin
      select 
      @w_msg  = 'ERROR: EN ACTUALIZACION DE TRAMITE' ,
      @w_error= 212382
      goto ERROR_PROCESO
   end
end


select @w_dias_desplazados = isnull(@w_dias_desplazados, 0)

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
         goto ERROR_PROCESO
	  
   end
 
end  

exec @w_error = sp_dia_pago
  @i_banco            = @i_banco,
  @i_fecha_inicio     = @i_fecha_ini,
  @i_num_dias         = @w_dia_inicio

if @w_error <> 0 begin 
   select 
   @w_msg  = 'ERROR: EN sp_dia_pago' ,
   @w_error = @w_error
   goto ERROR_PROCESO
end

--TRASLADO DE INFORMACION DESDE LAS TMP A DEFINITIVAS
exec @w_error = sp_operacion_def
@s_date  = @s_date,
@s_sesn  = @s_sesn,
@s_user  = @s_user,
@s_ofi   = @s_ofi,
@i_banco = @w_banco

if @w_error <> 0 begin 
   select 
   @w_msg  = 'ERROR: EN PASO A DEFINITVAS' ,
   @w_error= 212382
   goto ERROR_PROCESO
end

exec @w_error = sp_tir
@i_banco      = @w_banco,
@i_desacumula = 'S',
@o_tir        = @w_tir out,
@o_tea        = @w_tea out,
@o_cat        = @w_cat out
  
if @w_error   <> 0 begin
   select 
   @w_msg  = 'ERROR: ERROR EN CALCULO DE TIR' ,
   @w_error= 713220
   goto ERROR_PROCESO
end


update cob_cartera..ca_operacion SET 
op_valor_cat = @w_cat
where op_operacion = @i_operacionca

if @@error <> 0 begin
   select 
   @w_msg  = 'ERROR: ERROR EN ACTUALIZACION DE TIR' ,
   @w_error= 713820
   goto ERROR_PROCESO
end


update cob_credito..cr_tramite set 
tr_plazo         = @i_plazo,
tr_periodo       = @i_tdividendo,
tr_tipo_plazo    = @i_tplazo
where tr_tramite = @w_tramite

if @@error <> 0 begin
   select 
   @w_msg  = 'ERROR: ERROR EN ACTUALIZACION DE DATOS DEL TRAMITE' ,
   @w_error= 213344
   goto ERROR_PROCESO
end


-- BORRAR LA TEMPORAL
exec @w_error = sp_borrar_tmp
@s_user      = @s_user,
@s_term      = @s_term,
@s_sesn      = @s_sesn,
@i_desde_cre = 'N',
@i_banco     = @w_banco

if @w_error  <> 0 begin
   select 
   @w_msg  = 'ERROR: ERROR EN BORRADO DE TEMPORALES' ,
   @w_error= 713220
   goto ERROR_PROCESO
end

--PRINT 'ENVIO DE LOS NUMEROS DE OPERACION Y TRAMITE GENERADOS'
select 
@o_banco     = @w_banco,
@o_operacion = @i_operacionca,
@o_tramite   = @w_tramite
---------------------------------------------

if @w_commit = 'S' begin 
   commit tran
   select @w_commit = 'N'
end

return 0


ERROR_PROCESO:

if @w_commit = 'S'begin 
   select @w_commit = 'N'
   rollback tran    
end 

if @i_en_linea = 'S' begin 
   exec cobis..sp_cerror
   @t_debug = 'N',
   @t_from  = @w_sp_name,
   @i_num   = @w_error,
   @i_msg   = @w_msg

end else begin 

   exec sp_errorlog 
   @i_fecha       = @s_date,
   @i_error       = @w_error,
   @i_usuario     = @s_user,
   @i_tran        = 7999,
   @i_tran_name   = @w_sp_name,
   @i_cuenta      = @w_banco,
   @i_rollback    = 'N',
   @i_descripcion = @w_msg
end   


return @w_error

go
