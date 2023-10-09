
/************************************************************************/
/*   Archivo:              creaindividual.sp                            */
/*   Stored procedure:     sp_crear_individual                          */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Andy Gonzalez                                */
/*   Fecha de escritura:   06-11-2019                                   */
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
/*  Crear desde WF las operaciones Individuales(Consumo,Vivienda,       */
/*  Prendario,Microcredito, etc.)                                       */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*   12/11/2019      A. Gonzalez       Ajustes de montos                */
/*   17/09/2020      S. Rojas          Req #140073                      */
/*   07/20/2021      A. Gonzalez       Ajustes BW Cred. Simple          */
/*   30/20/2021      A. Chiluisa       #162288 Cliente no puede ser aval*/
/*   01/03/2022      A. Gonzalez       #Parametro i tasa                */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_crear_individual')
    drop proc sp_crear_individual
go

create proc sp_crear_individual(
@s_srv              varchar(30)    = null,
@s_lsrv             varchar(30)    = null,             
@s_ssn              int            = null,
@s_rol              int            = null,
@s_org              char(1)        = null,
@s_user             login          = null,
@s_term             varchar(30)    = null,
@s_date             datetime       = null,
@s_sesn             int            = null,
@s_ofi              smallint       = null,
---------------------------------------
@t_trn              int            = null,
@t_debug            char(1)        = null,
@t_file             varchar(30)    = null,
---------------------------------------
@i_tipo             varchar(1)     = 'O',
@i_anterior         cuenta         = null,
@i_migrada          cuenta         = null,
@i_tramite          int            = null,
@i_cliente          int            = 0,
@i_nombre           descripcion    = null,
@i_codeudor         int            = 0,
@i_sector           catalogo       = null,
@i_toperacion       catalogo       = null,
@i_oficina          smallint       = null,
@i_moneda           tinyint        = null,
@i_comentario       varchar(255)   = null,
@i_oficial          smallint       = null,
@i_fecha_ini        datetime       = null,
@i_monto            money          = null,
@i_monto_aprobado   money          = null,
@i_destino          catalogo       = null,
@i_lin_credito      cuenta         = null,
@i_ciudad           int            = null,
@i_forma_pago       catalogo       = null,
@i_cuenta           cuenta         = null,
@i_formato_fecha    int            = 101,
@i_no_banco         varchar(1)     = 'S',
@i_clase_cartera    catalogo       = null,
@i_origen_fondos    catalogo       = null,
@i_fondos_propios   varchar(1)     = 'S',
@i_ref_exterior     cuenta         = null,
@i_sujeta_nego      varchar(1)     = 'N' ,
@i_convierte_tasa   varchar(1)     = null,
@i_tasa_equivalente varchar(1)     = null,
@i_fec_embarque     datetime       = null,
@i_reestructuracion varchar(1)     = null,
@i_numero_reest     int            = null,
@i_num_renovacion   int            = 0,
@i_tipo_cambio      varchar(1)     = null,
@i_grupal           char(1)        = null,
@i_en_linea         varchar(1)     = 'S',
@i_externo          varchar(1)     = 'S',
@i_desde_web        varchar(1)     = 'S',
@i_banca            catalogo       = null,
@i_salida           varchar(1)     = 'N',
@i_promocion        char(1)        = 'N', 
@i_acepta_ren       char(1)        = null,
@i_no_acepta        char(1000)     = null,
@i_emprendimiento   char(1)        = null,
@i_participa_ciclo  char(1)        = null,
@i_garantia         float          = null,
@i_ahorro           money          = null,
@i_monto_max        money          = null,
@i_bc_ln            char(10)       = null,
@i_plazo            int            = null,
@i_tplazo           catalogo       = null,
@i_tdividendo       catalogo       = null,
@i_periodo_cap      int            = null,
@i_periodo_int      int            = null,
@i_alianza          int            = null, 
@i_ciudad_destino   int            = null, 
@i_experiencia_cli  char(1)        = null, 
@i_monto_max_tr     money          = null, 
@i_automatica       char(1)        = 'N',  
@i_tasa             float          = null ,
@i_naturaleza       varchar(10)    = NULL,
@i_onboarding       char(1)        = 'N',
---------------------------------------
@o_banco            cuenta         = null out,
@o_operacion        int            = null out,
@o_tramite          int            = null out,
@o_oficina          int            = null out,
@o_msg              varchar(100)   = null out,
@o_ciclo            int            = 0    out,
@o_fecha_creacion   varchar(10)    = null out
)as

declare
@w_sp_name                  varchar(64),
@w_return                   int,
@w_error                    int,
@w_fecha_proceso            datetime,
@w_operacion                int,
@w_banco                    cuenta,
@w_ced_ruc                  varchar(15),
@w_ced_ruc_codeudor         varchar(15),
@w_nombre                   varchar(60),
@w_prod_cobis               smallint,
@w_tramite                  int,
@w_tplazo                   catalogo,
@w_plazo                    smallint,
@w_commit                   char(1),
@w_ced_ruc_codeudor_gr      VARCHAR(30),
@w_max_tramite              int,             
@w_operacion_1              int,
@w_periodo_reajuste         smallint,
@w_reajuste_especial        char(1),
@w_precancelacion           char(1),
@w_tipo                     char(1),
@w_cuota_completa           char(1),
@w_tipo_reduccion           char(1),
@w_aceptar_anticipos        char(1),
@w_tdividendo               catalogo,
@w_periodo_cap              smallint,
@w_periodo_int              smallint,
@w_gracia_cap               smallint,
@w_gracia_int               smallint,
@w_dist_gracia              char(1),
@w_dias_anio                smallint,
@w_tipo_amortizacion        varchar(30),
@w_fecha_fija               char(1),
@w_cuota_fija               char(1),
@w_evitar_feriados          char(1),
@w_renovacion               char(1),
@w_mes_gracia               tinyint,
@w_tipo_aplicacion          char(1),
@w_tipo_cobro               char(1),
@w_reajustable              char(1),
@w_base_calculo             char(1),
@w_ult_dia_habil            char(1),
@w_recalcular               char(1),
@w_prd_cobis                tinyint,
@w_tipo_redondeo            tinyint,
@w_causacion                char(1),
@w_convierte_tasa           char(1),
@w_tipo_linea               catalogo,
@w_subtipo_linea            catalogo,
@w_bvirtual                 char(1),
@w_extracto                 char(1),
@w_subtipo                  char(1),
@w_naturaleza               char(1),
@w_pago_caja                char(1),
@w_nace_vencida             char(1),
@w_calcula_devolucion       char(1),
@w_dias_gracia              smallint,
@w_entidad_convenio         catalogo,
@w_mora_retroactiva         char(1),
@w_prepago_desde_lavigente  char(1),
@w_control_dia_pago         char(1),
@w_sector                   catalogo,
@w_clase_cartera            catalogo,
@w_dia_pago                 tinyint,
@w_ofi_def_app_movil        smallint,
@w_monto_max                money,
@w_monto_min                money,
@w_porcentaje               float,
@w_id_inst_proc             int,
@w_id_inst_act              int,
@w_id_empresa               int,
@w_rule                     int,
@w_rule_version             int,
@w_retorno_val              varchar(255),
@w_retorno_id               int,
@w_variables                varchar(255),
@w_result_values            varchar(255),
@w_ciclo                    int,
@w_fecha_creacion           datetime,
@w_tir                      float, 
@w_tea                      float, 
@w_cat                      FLOAT,
@w_ciudad                   int, 
@w_oficial                  int,
@w_oficina                  int,
@w_ente                     int,
@w_toperacion               catalogo,
@w_moneda                   int,
@w_est_novigente            int,
@w_est_anulado              int,
@w_est_credito              int,
@w_aux_monto                money,
@w_aux_monto_aprobado       money,
@w_msg                      varchar(100)                

if (@i_cliente = @i_alianza) -- caso#162288. Definicion, producto de las pruebas
begin
    select 
    @w_msg  = 'ERROR: El cliente no puede ser Aval' ,
    @w_error= 2108088
    GOTO ERROR_PROCESO
end

/* Estados */
exec cob_externos..sp_estados
@i_producto      = 7,
@o_est_novigente = @w_est_novigente out,
@o_est_anulado   = @w_est_anulado out,
@o_est_credito   = @w_est_credito out

select 
@w_est_novigente = isnull(@w_est_novigente, 0),
@w_est_anulado   = isnull(@w_est_anulado, 6),
@w_est_credito   = isnull(@w_est_credito, 99),
@i_tdividendo    = @i_tplazo


if @i_onboarding  = 'N' begin
/* Se invirte el orden de las variables de monto solicitado y monto autorizado, el cambio es por conceptos */
   select @w_aux_monto = @i_monto
   select @w_aux_monto_aprobado = @i_monto_aprobado
/* Invertir */
   select @i_monto = @w_aux_monto_aprobado
   select @i_monto_aprobado = @w_aux_monto
end 

/* DETERMINAR LOS VALORES POR DEFECTO PARA EL TIPO DE OPERACION */
select
@w_toperacion                = dt_toperacion,
@w_periodo_reajuste          = dt_periodo_reaj,
@w_reajuste_especial         = dt_reajuste_especial,
@w_precancelacion            = dt_precancelacion,
@w_tipo                      = dt_tipo,
@w_cuota_completa            = dt_cuota_completa,
@w_tipo_reduccion            = dt_tipo_reduccion,
@w_aceptar_anticipos         = dt_aceptar_anticipos,
@w_tplazo                    = isnull(@i_tplazo,dt_tplazo),
@w_plazo                     = isnull(@i_plazo,dt_plazo),
@w_tdividendo                = isnull(@i_tdividendo,dt_tdividendo),
@w_periodo_cap               = isnull(@i_periodo_cap,dt_periodo_cap),
@w_periodo_int               = isnull(@i_periodo_int,dt_periodo_int),
@w_gracia_cap                = dt_gracia_cap,
@w_gracia_int                = dt_gracia_int,
@w_dist_gracia               = dt_dist_gracia,
@w_dias_anio                 = dt_dias_anio,
@w_tipo_amortizacion         = dt_tipo_amortizacion,
@w_fecha_fija                = dt_fecha_fija,
@w_dia_pago                  = dt_dia_pago,
@w_cuota_fija                = dt_cuota_fija,
@w_evitar_feriados           = dt_evitar_feriados,
@w_renovacion                = dt_renovacion,
@w_mes_gracia                = dt_mes_gracia,
@w_tipo_aplicacion           = dt_tipo_aplicacion,
@w_tipo_cobro                = dt_tipo_cobro,
@w_reajustable               = dt_reajustable,
@w_base_calculo              = dt_base_calculo,
@w_ult_dia_habil             = dt_dia_habil,
@w_recalcular                = dt_recalcular_plazo,
@w_prd_cobis                 = dt_prd_cobis,
@w_tipo_redondeo             = dt_tipo_redondeo,
@w_causacion                 = dt_causacion,
@w_convierte_tasa            = isnull(dt_convertir_tasa, 'S'),
@w_tipo_linea                = dt_tipo_linea,
@w_subtipo_linea             = dt_subtipo_linea,
@w_bvirtual                  = dt_bvirtual,
@w_extracto                  = dt_extracto,
@w_naturaleza                = dt_naturaleza,
@w_pago_caja                 = dt_pago_caja,
@w_nace_vencida              = dt_nace_vencida,
@w_calcula_devolucion        = dt_calcula_devolucion,
@w_dias_gracia               = dt_dias_gracia,
@w_entidad_convenio          = dt_entidad_convenio,
@w_mora_retroactiva          = dt_mora_retroactiva,
@w_prepago_desde_lavigente   = isnull(dt_prepago_desde_lavigente,'N'),
@w_control_dia_pago          = dt_control_dia_pago,
@w_sector                    = dt_clase_sector,
@w_clase_cartera             = dt_clase_cartera,
@w_monto_min                 = dt_monto_min,
@w_monto_max                 = dt_monto_max
from ca_default_toperacion
where dt_toperacion = @i_toperacion
and   dt_moneda     = @i_moneda

if @@rowcount = 0 begin 

   select 
   @w_msg  = 'ERROR: NO EXISTE DEFAULT DE OPERACION' ,
   @w_error= 724609
   GOTO ERROR_PROCESO
   
end 



select
@w_sp_name  = 'sp_crear_individuales',
@w_commit   = 'N'

select @w_fecha_proceso = fc_fecha_cierre
from   cobis..ba_fecha_cierre
where  fc_producto = 7


select @w_ofi_def_app_movil = pa_int from cobis..cl_parametro
where  pa_nemonico = 'MOBOFF'
and    pa_producto = 'ADM'


if((@i_oficina = @w_ofi_def_app_movil) OR (@s_ofi = @w_ofi_def_app_movil))
begin

   if @i_monto_aprobado > @i_monto and @i_onboarding = 'N' begin
      select 
      @w_msg  = 'ERROR: MONTO APROBADO MAYOR AL MONTO PERMITIDO' ,
      @w_error= 724604
      GOTO ERROR_PROCESO
   end

   if @i_monto > @i_monto_aprobado  and @i_onboarding = 'S' begin
      select 
      @w_msg  = 'ERROR: MONTO APROBADO MAYOR AL MONTO PERMITIDO' ,
      @w_error= 724604
      GOTO ERROR_PROCESO
   end

	if isnull(@i_monto_aprobado, 0) > 0
	begin
	   if isnull(@w_monto_min,0) > 0 or isnull(@w_monto_max,0) > 0
	   begin
	      if @i_monto_aprobado < @w_monto_min or @i_monto_aprobado > @w_monto_max
		  begin
	
			    select 
                @w_msg  = 'ERROR: MONTO APROBADO MENOR AL MINIMO' ,
                @w_error= 724608
                GOTO ERROR_PROCESO
   
	      end
	   end
	end
end



if(@i_oficina = @w_ofi_def_app_movil)
begin
	select @i_oficina = fu_oficina
	from   cobis..cl_funcionario, cobis..cc_oficial
	where  oc_oficial     = @i_oficial
	and    oc_funcionario = fu_funcionario
end

print '-->>Antes: @i_ciudad' + convert(varchar, isnull(@i_ciudad, '9999'))
print '-->>Antes: @i_ciudad_destino' + convert(varchar, isnull(@i_ciudad_destino, '9999'))

--@i_ciudad_destino--catalogo
if ((@i_ciudad = 0 or @i_ciudad is null) and @i_ciudad_destino is not null)
    select @i_ciudad = @i_ciudad_destino

print '-->>Despues: @i_ciudad' + convert(varchar, isnull(@i_ciudad, '9999'))

select @w_ciudad = case when @i_ciudad is null or @i_ciudad = 0 then of_ciudad
                                                                 else @i_ciudad
                   end
from cobis..cl_oficina 
where of_oficina = @i_oficina 

select 
--@w_ciudad  = isnull(@i_ciudad ,@w_ciudad),
@w_oficina  = isnull(@i_oficina ,@w_oficina),
@w_ced_ruc = en_ced_ruc,
@w_nombre  = rtrim(isnull(p_p_apellido,''))+' '+rtrim(isnull(p_s_apellido,''))+' '+rtrim(isnull(en_nombre,''))
from  cobis..cl_ente
where en_ente = @i_cliente


if @w_ced_ruc is null or @w_nombre is null begin

   select 
   @w_msg  = 'ERROR: NO EXISTE CLIENTE SOLICITADO' ,
   @w_error= 710200
   goto ERROR_PROCESO
   
end

if @@trancount = 0 begin
   begin tran
   select @w_commit = 'S'
end


exec @w_error = sp_codeudor_tmp
@s_sesn        = @s_sesn,
@s_user        = @s_user,
@i_borrar      = 'S',
@i_secuencial  = 1,
@i_titular     = @i_cliente,
@i_operacion   = 'A',
@i_codeudor    = @i_cliente,
@i_ced_ruc     = @w_ced_ruc,
@i_rol         = 'D',
@i_externo     = 'N'

if @w_error != 0 begin
   select 
   @w_msg  = 'ERROR: EN LA CREACION DE CODEUDORES' ,
   @w_error= 710201
   goto ERROR_PROCESO
end


if isnull(@i_codeudor, 0) <> 0 begin

   select @w_ced_ruc_codeudor = en_ced_ruc
   from cobis..cl_ente
   where  en_ente = @i_codeudor
   set transaction isolation level read uncommitted

   if @w_ced_ruc_codeudor is null begin
      select 
      @w_msg  = 'ERROR: NO EXISTE CLIENTE SOLICITADO' ,
      @w_error= 710202
      goto ERROR_PROCESO
   end

   exec @w_error = sp_codeudor_tmp
   @s_sesn        = @s_sesn,
   @s_user        = @s_user,
   @i_borrar      = 'N',
   @i_secuencial  = 2,
   @i_titular     = @i_cliente,
   @i_operacion   = 'A',
   @i_codeudor    = @i_codeudor,
   @i_ced_ruc     = @w_ced_ruc_codeudor,
   @i_rol         = 'C',
   @i_externo     = 'N'

   if @w_error != 0 begin
      select 
      @w_msg  = 'ERROR: EN LA CREACION DE CODEUDORES' ,
      @w_error= 710203
      goto ERROR_PROCESO
   end
   
end

if @i_tplazo is null  begin
   select 
   @w_msg  = 'ERROR: TIPO DE PLAZO VACIO' ,
   @w_error= 710202
   goto ERROR_PROCESO
end


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







exec @w_error = cob_cartera..sp_crear_operacion
@s_user             = @s_user,
@s_sesn             = @s_sesn,
@s_term             = @s_term,
@s_date             = @w_fecha_proceso,
@i_anterior         = null,
@i_comentario       = 'OPERACION CREADA DESDE WORKFLOW',
@i_oficial          = @i_oficial,
@i_destino          = @i_destino,
@i_monto_aprobado   = @i_monto_aprobado,
@i_cliente          = @i_cliente,
@i_nombre           = @w_nombre,
@i_oficina          = @w_oficina,
@i_toperacion       = @w_toperacion,
@i_monto            = @i_monto, 
@i_moneda           = @i_moneda,
@i_fecha_ini        = @i_fecha_ini,
@i_forma_pago       = 'ND_BCO_MN',
@i_cuenta           = @i_cuenta,
@i_ciudad           = @w_ciudad,
@i_tasa             = @i_tasa,
@i_reestructuracion = 'N',
@i_grupal           = 'N',
@i_promocion        = 'N',
@i_plazo            = @i_plazo,
@i_tplazo           = @w_tplazo,
@i_tdividendo       = @w_tdividendo,
@i_periodo_cap      = @w_periodo_cap,
@i_periodo_int      = @w_periodo_int,
@o_banco            = @w_banco output

if @w_error != 0 begin
   select 
   @w_msg  = 'ERROR: EN LA CREACION DE OPERACION' ,
   @w_error= 710213
   goto ERROR_PROCESO
end


select
@w_operacion    = opt_operacion,
@w_prod_cobis   = opt_prd_cobis,
@w_ente         = opt_cliente
from   ca_operacion_tmp
where  opt_banco = @w_banco

if @@rowcount = 0 begin
   select 
   @w_msg  = 'ERROR: NO EXISTE LA OPERACION TEMPORAL' ,
   @w_error= 710250
   goto ERROR_PROCESO
end


--CREA TRAMITE
exec @w_error = cob_credito..sp_tramite_cca
@s_user				= @s_user,
@s_term				= @s_term,
@s_ofi				= @s_ofi,
@s_ssn				= @s_ssn,
@s_lsrv				= @s_lsrv,
@s_date				= @w_fecha_proceso,	  
@i_tipo				= @w_tipo,
@i_oficina_tr		= @i_oficina,
@i_fecha_crea		= @w_fecha_proceso,
@i_oficial			= @i_oficial,
@i_sector			= 'S',
@i_ciudad			= @w_ciudad,
@i_toperacion		= @w_toperacion,
@i_producto			= 'CCA',
@i_monto		    = @i_monto,
@i_moneda			= @i_moneda,
@i_destino			= @i_destino,
@i_ciudad_destino	= @w_ciudad,
@i_cliente			= @w_ente,
@i_tplazo         = @w_tplazo,
@i_plazo          = @w_plazo,
@i_periodo        = @w_tdividendo,
@i_alianza        = @i_alianza,
@i_operacion		= 'I',
@o_tramite			= @w_tramite out

if @w_error  <> 0 begin
   select 
   @w_msg  = 'ERROR: NO SE PUDO CREAR TRAMITE' ,
   @w_error= 710220
   goto ERROR_PROCESO
end


update ca_operacion_tmp
set    opt_tramite = @w_tramite
where  opt_banco   = @w_banco

if @@error <> 0 begin
   select 
   @w_msg  = 'ERROR: NO SE PUDO ACTUALIZAR TRAMITE EN TEMPORALES' ,
   @w_error= 710120
   goto ERROR_PROCESO
end

exec @w_error = sp_operacion_def
@s_date      = @s_date,
@s_sesn      = @s_sesn,
@s_user      = @s_user,
@s_ofi       = @s_ofi,
@i_banco     = @w_banco,
@i_claseoper = @w_banco

if @w_error <> 0 begin
   select 
   @w_msg  = 'ERROR: ERROR EN PASO A DEFINITIVOS' ,
   @w_error= 710220
   goto ERROR_PROCESO
end


if isnull(@w_tramite, 0) > 0 begin

   update cob_credito..cr_tramite
   set    tr_numero_op = @w_operacion
   where  tr_tramite   = @w_tramite

   if @@error <> 0 begin
      select 
      @w_msg  = 'ERROR: ERROR EN ACTUALIZACION DE TRAMITE' ,
      @w_error= 714220
      goto ERROR_PROCESO
   end


   if not exists (select 1 from cob_credito..cr_deudores where de_tramite = @w_tramite) begin

      insert into cob_credito..cr_deudores
      (de_tramite, de_cliente, de_rol, de_ced_ruc)
      select
      @w_tramite, cl_cliente, cl_rol, cl_ced_ruc
      from cobis..cl_det_producto, cobis..cl_cliente
      where dp_cuenta = @w_banco
      and   dp_producto = 7
      and   cl_det_producto = dp_det_producto
   
   end

end


exec @w_error = sp_borrar_tmp
@s_sesn   = @s_sesn,
@s_user   = @s_user,
@s_term   = @s_term,
@i_banco  = @w_banco

if @w_error   <> 0 begin
   select 
   @w_msg  = 'ERROR: ERROR EN BORRADO DE TEMPORALES' ,
   @w_error= 713220
   goto ERROR_PROCESO
end

exec @w_error = sp_tir
@i_banco      = @w_banco,
@i_desacumula = 'S',
@o_tir        = @w_tir out,
@o_tea        = @w_tea out,
@o_cat        = @w_cat out


if @w_error <> 0 begin
   select 
   @w_msg  = 'ERROR: ERROR EN CALCULO DE TIR' ,
   @w_error= 713220
   goto ERROR_PROCESO
end

	
update cob_cartera..ca_operacion set 
op_valor_cat = @w_cat
where op_operacion = @w_operacion

if @@error <> 0 begin
  select 
   @w_msg  = 'ERROR: ERROR EN ACTUALIZACION DE TIR' ,
   @w_error= 713820
   goto ERROR_PROCESO
end

/* Obtener ciclo individual */
select @w_ciclo = count(*) from cob_cartera..ca_operacion 
where op_cliente = @i_cliente
and op_toperacion = @i_toperacion
and op_tramite <> @w_tramite
and op_estado not in (@w_est_novigente, @w_est_anulado, @w_est_credito)

if @w_ciclo < 0 or @w_ciclo is null
   select @w_ciclo = 0

select @w_ciclo = @w_ciclo + 1 --Se suma 1 al ciclo real

/* Fecha de Creacion (Fecha Proceso) */ 
select @w_fecha_creacion = fp_fecha from cobis..ba_fecha_proceso

select
@o_banco           = @w_banco,
@o_operacion       = @w_operacion,
@o_tramite         = @w_tramite,
@o_oficina         = @i_oficina,
@o_ciclo           = @w_ciclo, 
@o_fecha_creacion  = convert(varchar(10),@w_fecha_creacion,103)


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

