/************************************************************************/
/*   Archivo:              coprenwf.sp                                  */
/*   Stored procedure:     sp_crear_ren_sol_wf                          */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:        Andy Gonzalez                                 */
/*   Fecha de escritura:   Enero 11 2021                                */
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
/*  CREACION DE RENOVACIONES DESDE LA PANTALLA  DE INGRESO              */
/*                            MODIFICACIONES                            */
/*   12-01-2021             A. Gonzalez           Emisión Inicial       */
/*   26-01-2021             S. Rojas              Merge Oferta Producto */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_crear_ren_sol_wf')
    drop proc sp_crear_ren_sol_wf
go

create proc sp_crear_ren_sol_wf(
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
   --@i_tg_monto_aprobado money     = null,   
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
   @i_naturaleza       varchar(10)    = NULL,
   @i_desplazamiento   int            = null,
   ---------------------------------------
   @o_banco            cuenta         = null out,
   @o_operacion        int            = null out,
   @o_tramite          int            = null out,
   @o_oficina          int            = null out,
   @o_msg              varchar(100)   = null out,
   @o_ciclo            int            = null out,
   @o_fecha_creacion   varchar(10)    = null out,
   @o_tasa_grp         varchar(255)   = null out
)as

declare
@w_sp_name                     varchar(64),
@w_return                      int,
@w_error                       int,
@w_fecha_proceso               datetime,
@w_operacion                   int,
@w_banco                       cuenta,
@w_ced_ruc                     varchar(15),
@w_ced_ruc_codeudor            varchar(15),
@w_nombre                      varchar(60),
@w_prod_cobis                  smallint,
@w_tramite                     int,
@w_tplazo                      catalogo,
@w_plazo                       smallint,
@w_commit                      char(1),
@w_ced_ruc_codeudor_gr         VARCHAR(30),
@w_miembros                    int,
@w_cta_grupal                  cuenta,
@w_max_tramite                 int,         -- LGU max tramite grupal
@w_grupo_id                    int,         -- LGU id del grupo del interciclo
@w_operacion_1                 int,
@w_periodo_reajuste            smallint,
@w_reajuste_especial           char(1),
@w_precancelacion              char(1),
@w_tipo                        char(1),
@w_cuota_completa              char(1),
@w_tipo_reduccion              char(1),
@w_aceptar_anticipos           char(1),
@w_tdividendo                  catalogo,
@w_periodo_cap                 smallint,
@w_periodo_int                 smallint,
@w_gracia_cap                  smallint,
@w_gracia_int                  smallint,
@w_dist_gracia                 char(1),
@w_dias_anio                   smallint,
@w_tipo_amortizacion           varchar(30),
@w_fecha_fija                  char(1),
@w_cuota_fija                  char(1),
@w_evitar_feriados             char(1),
@w_renovacion                  char(1),
@w_mes_gracia                  tinyint,
@w_tipo_aplicacion             char(1),
@w_tipo_cobro                  char(1),
@w_reajustable                 char(1),
@w_base_calculo                char(1),
@w_ult_dia_habil               char(1),
@w_recalcular                  char(1),
@w_prd_cobis                   tinyint,
@w_tipo_redondeo               tinyint,
@w_causacion                   char(1),
@w_convierte_tasa              char(1),
@w_tipo_linea                  catalogo,
@w_subtipo_linea               catalogo,
@w_bvirtual                    char(1),
@w_extracto                    char(1),
@w_subtipo                     char(1),
@w_naturaleza                  char(1),
@w_pago_caja                   char(1),
@w_nace_vencida                char(1),
@w_calcula_devolucion          char(1),
@w_dias_gracia                 smallint,
@w_entidad_convenio            catalogo,
@w_mora_retroactiva            char(1),
@w_prepago_desde_lavigente     char(1),
@w_control_dia_pago            char(1),
@w_sector                      catalogo,
@w_clase_cartera               catalogo,
@w_dia_pago                    tinyint,
@w_ofi_def_app_movil           smallint,
@w_monto_max                   money,
@w_monto_min                   money,
@w_porcentaje                  float,
@w_id_inst_proc                int,
@w_id_inst_act                 int,
@w_id_empresa                  int,
@w_rule                        int,
@w_rule_version                int,
@w_retorno_val                 varchar(255),
@w_retorno_id                  int,
@w_variables                   varchar(255),
@w_result_values               varchar(255),
@w_ciclo                       int,
@w_fecha_creacion              datetime,
@w_comentario			       varchar(510),
@w_habilitado_animate          char(1),
@w_ciclo_grupal                int,
@w_aux_monto                   money,
@w_aux_monto_aprobado          money,
@w_msg                         varchar(255),
@w_cat                         float,
@w_tir                         float,
@w_toperacion                  catalogo,
@w_ciudad                      int,
@w_ente                        int,
@w_tea                         float,
@w_est_novigente               int,
@w_est_anulado                 int,
@w_est_credito                 int, 
@w_opeeracionca                int,
@w_num_renovacion              int,
@w_oficina                     int,
@w_monto_or                    float,
@w_banco_ant                   cuenta ,
@w_max_ciclo                   int,
@w_numero_prestamos            int,
@w_prestamos_cancelados        int ,
@w_operacionca_or              int, 
@w_desplazamiento              int,
@w_param_oferta_producto       varchar(30),
@w_factor                      int,
@w_dias_desplazados            int,
@w_tasa_grupal_ant             float,
@w_reduccion_tasa_grupal       float,
@w_min_porc_tasa_grupal        float   

select @w_habilitado_animate = pa_char 
from cobis..cl_parametro 
where pa_nemonico = 'HAPRAN'

select @w_habilitado_animate = isnull ( @w_habilitado_animate, 'S')

select @w_param_oferta_producto = pa_char
from cobis..cl_parametro 
where pa_nemonico = 'OFEPRO'

select @w_param_oferta_producto = isnull ( @w_param_oferta_producto, 'N')

-- SRO. PARAMETRO REDUCCION DE TASA GRUPAL
select @w_reduccion_tasa_grupal = pa_float
from cobis..cl_parametro
where pa_nemonico               = 'RDTGRP'
and   pa_producto               = 'CRE'

select @w_reduccion_tasa_grupal = isnull( @w_reduccion_tasa_grupal, 3.0 ) 

-- SRO. PARAMETRO MINIMO TASA GRUPAL
select @w_min_porc_tasa_grupal  = pa_float
from cobis..cl_parametro
where pa_nemonico               = 'MNPRTG'
and   pa_producto               = 'CRE'

select @w_min_porc_tasa_grupal = isnull( @w_min_porc_tasa_grupal, 70.0)

print '@w_habilitado_animate: ' + @w_habilitado_animate

if @i_grupal = 'S' and  @w_habilitado_animate ='N'
begin
   select @w_ciclo_grupal = isnull(gr_num_ciclo,0) + 1
   from cobis..cl_grupo
   where gr_grupo = @i_cliente
   
   if @w_ciclo_grupal = 1
      select @i_promocion = 'N'
end

print '@i_promocion: ' + @i_promocion

--PRINT 'CARGAR VALORES INICIALES'
select @w_sp_name  = 'sp_crear_oper_ren_wf',
       @w_commit   = 'N'


--PRINT 'CONSULTAR FECHA DE PROCESO'
select @w_fecha_proceso = fc_fecha_cierre
from   cobis..ba_fecha_cierre
where  fc_producto = 7

/* Se invirte el orden de las variables de monto solicitado y monto autorizado, el cambio es por conceptos */
select @w_aux_monto = @i_monto
select @w_aux_monto_aprobado = @i_monto_aprobado
/* Invertir */
select @i_monto = @w_aux_monto_aprobado
select @i_monto_aprobado = @w_aux_monto

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
@w_tplazo                    = dt_tplazo,
@w_plazo                     = dt_plazo,
@w_tdividendo                = dt_tdividendo,
@w_periodo_cap               = dt_periodo_cap,
@w_periodo_int               = dt_periodo_int,
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
@i_sector                    = isnull(@i_sector,dt_clase_sector),
@i_clase_cartera             = isnull(@i_clase_cartera,dt_clase_cartera),
@w_monto_min                 = dt_monto_min,
@w_monto_max                 = dt_monto_max,
@w_desplazamiento            = dt_desplazamiento
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
@w_plazo            = isnull(@i_plazo,  @w_plazo),
@i_sector           = isnull(@i_sector,@w_sector),
@i_clase_cartera    = isnull(@i_clase_cartera,@w_clase_cartera),
@w_desplazamiento   = isnull(isnull(@i_desplazamiento, @w_desplazamiento), 0)

select @w_ofi_def_app_movil = pa_int from cobis..cl_parametro
where  pa_nemonico = 'MOBOFF'
and    pa_producto = 'ADM'

if((@i_oficina = @w_ofi_def_app_movil) OR (@s_ofi = @w_ofi_def_app_movil))
begin
	if isnull(@i_monto_aprobado, 0) > 0
	begin
	   if isnull(@w_monto_min,0) > 0 or isnull(@w_monto_max,0) > 0
	   begin
	      if @i_monto_aprobado < @w_monto_min or @i_monto_aprobado > @w_monto_max
		  begin
		     select @w_error = 724609

				exec cobis..sp_cerror
				        @t_debug = @t_debug,
				        @t_file  = @t_file,
				        @t_from  = @w_sp_name,
				        @i_num   = @w_error
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
  
select @w_ciudad = isnull(@i_ciudad ,of_ciudad )
from cobis..cl_oficina 
where of_oficina = @i_oficina 


if @i_grupal = 'S' and  @w_habilitado_animate ='N'
begin
   select @w_ciclo_grupal = isnull(gr_num_ciclo,0) + 1
   from cobis..cl_grupo
   where gr_grupo = @i_cliente
   
   if @w_ciclo_grupal = 1
      select @i_promocion = 'N'
end

   

if @@trancount = 0 begin
   begin tran
   select @w_commit = 'S'
end

-- buscar el tramite, operacion y banco GRUPAL
select @w_grupo_id = cg_grupo
from   cobis..cl_cliente_grupo
where  cg_ente = @i_cliente
and cg_fecha_desasociacion is null

---------------------------------------------
--PRINT 'CONSULTAR INFORMACION DEL DEUDOR PRINCIPAL ' + CONVERT(VARCHAR, @i_cliente)
select
@w_ced_ruc = en_ced_ruc,
@w_nombre  = rtrim(isnull(p_p_apellido,''))+' '+rtrim(isnull(p_s_apellido,''))+' '+rtrim(isnull(en_nombre,''))
from  cobis..cl_ente
where en_ente = @i_cliente
--PRINT CONVERT(VARCHAR, @@rowcount)
set transaction isolation level read uncommitted

if @i_grupal = 'S'
   select
   @w_ced_ruc = convert(varchar, gr_grupo),
   @w_nombre  = rtrim(gr_nombre)
   from  cobis..cl_grupo
   where gr_grupo = @i_cliente


if @w_ced_ruc is null or @w_nombre is null
begin
--   PRINT CONVERT(VARCHAR, @@rowcount) + ' ' + @w_ced_ruc + ' ' + @w_nombre
   select @w_error = 710200  --No existe cliente solicitado
   goto ERROR_PROCESO
end


--PRINT 'REGISTRAR DEUDOR PRINCIPAL'
exec @w_return = sp_codeudor_tmp
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

if @w_return != 0
begin
   select @w_error = @w_return
   goto ERROR_PROCESO
end


--PRINT 'VERIFICAR ENVIO DE CODEUDOR'
if isnull(@i_codeudor, 0) != 0
begin
--   PRINT 'CONSULTAR INFORMACION DEL CODEUDOR'
   select @w_ced_ruc_codeudor = en_ced_ruc
   from cobis..cl_ente
   where  en_ente = @i_codeudor
   set transaction isolation level read uncommitted

   if @w_ced_ruc_codeudor is null
   begin
      select @w_error = 710200  --No existe cliente solicitado
      goto ERROR_PROCESO
   end


--   PRINT 'REGISTRAR CODEUDOR'
   exec @w_return = sp_codeudor_tmp
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

   if @w_return != 0
   begin
      select @w_error = @w_return
      goto ERROR_PROCESO
   end
end

-- Se realiza esto dado que por pantalla para grupal
-- se requiere que el valor inicial sea 0
IF @i_grupal= 'S'
BEGIN
    if(@i_automatica = 'N') --No ingresa por batch
    begin
       select @i_monto =  dt_monto_min
       from   cob_cartera..ca_default_toperacion
       where  dt_toperacion = @i_toperacion
       and    dt_moneda     = @i_moneda

       SELECT @i_monto_aprobado = @i_monto
    end
END
------------------------
--PRINT 'CREACION DE LA OPERACION'

select @i_comentario = isnull(@i_comentario , 'Operacion renovada')

exec @w_return = cob_cartera..sp_crear_operacion
@s_user           = @s_user,
@s_sesn           = @s_sesn,
@s_term           = @s_term,
@s_date           = @s_date,
@i_anterior       = @i_anterior,
@i_comentario     = @i_comentario,
@i_oficial        = @i_oficial,
@i_destino        = @i_destino,
@i_monto_aprobado = @i_monto_aprobado,
@i_fondos_propios = @i_fondos_propios,
@i_ciudad         = @i_ciudad,
@i_cliente        = @i_cliente,
@i_nombre         = @w_nombre,
@i_sector         = @i_sector,
@i_oficina        = @i_oficina,
@i_toperacion     = @i_toperacion,
@i_monto          = @i_monto,
@i_moneda         = @i_moneda,
@i_fecha_ini      = @i_fecha_ini,
@i_lin_credito    = @i_lin_credito,
@i_migrada        = @i_migrada,
@i_formato_fecha  = @i_formato_fecha,
@i_forma_pago     = @i_forma_pago,
@i_cuenta         = @i_cuenta,
@i_clase_cartera  = @i_clase_cartera,
@i_origen_fondos  = @i_origen_fondos,
@i_sujeta_nego    = @i_sujeta_nego,   -- sujeta a negociacion
@i_ref_exterior   = @i_ref_exterior,  -- numero de referencia exterior
@i_convierte_tasa = @i_convierte_tasa,
@i_tasa_equivalente = @i_tasa_equivalente,
@i_fec_embarque   = @i_fec_embarque,
@i_reestructuracion = @i_reestructuracion,
@i_tipo_cambio    = @i_tipo_cambio,
@i_grupal         = @i_grupal,
@i_promocion      = @i_promocion,
@i_acepta_ren     = @i_acepta_ren,
@i_no_acepta      = @i_no_acepta,
@i_emprendimiento = @i_emprendimiento,
@i_banca          = @i_banca,
@i_plazo            = @w_plazo,
@i_tplazo           = @w_tplazo,
@i_tdividendo       = @w_tdividendo,
@i_periodo_cap      = @w_periodo_cap,
@i_periodo_int      = @w_periodo_int,
@i_desplazamiento   = @w_desplazamiento,        --SRO #140073
@o_banco          = @w_banco output

if @w_return <> 0
begin
   select @w_error = @w_return
   goto ERROR_PROCESO
end


--PRINT 'OBTENER NUMERO DE OPERACION DESDE TEMPORAL'
select
@w_operacion    = opt_operacion,
@w_prod_cobis   = opt_prd_cobis
from   ca_operacion_tmp
where  opt_banco = @w_banco

if @@rowcount = 0
begin
   select @w_error = 701050  --No existe Operacion Temporal
   goto ERROR_PROCESO
end


--PRINT 'GENERAR TRAMITE DEBIDO A LA CREACION DIRECTA EN CCA (VERIFICAR AL FINAL)'
exec @w_return = cob_credito..sp_tramite_cca
@s_ssn               = @s_ssn,
@s_user              = @s_user,
@s_sesn              = @s_sesn,
@s_term              = @s_term,
@s_date              = @s_date,
@s_srv               = @s_srv,
@s_lsrv              = @s_lsrv,
@s_ofi               = @s_ofi,
@i_oficina_tr        = @i_oficina,
@i_fecha_crea        = @i_fecha_ini,
@i_oficial           = @i_oficial,
@i_sector            = @i_sector,
@i_banco             = @w_banco,
@i_linea_credito     = @i_lin_credito,
@i_toperacion        = @i_toperacion,
@i_producto          = 'CCA',
@i_tipo              = @i_tipo,
@i_monto             = @i_monto,
@i_moneda            = @i_moneda,
@i_periodo           = @w_tplazo,
@i_num_periodos      = @w_plazo,
@i_destino           = @i_destino,
@i_ciudad_destino    = @i_ciudad_destino,
@i_renovacion        = @i_num_renovacion,
@i_clase             = @i_clase_cartera,
@i_cliente           = @i_cliente,
@i_grupal            = @i_grupal,
@i_promocion         = @i_promocion,
@i_acepta_ren        = @i_acepta_ren,
@i_no_acepta         = @i_no_acepta,
@i_emprendimiento    = @i_emprendimiento,
@i_participa_ciclo   = @i_participa_ciclo,
@i_monto_aprobado    = @i_monto_aprobado, --@i_tg_monto_aprobado,
@i_garantia          = @i_garantia,
@i_ahorro            = @i_ahorro,
@i_monto_max         = @i_monto_max,
@i_bc_ln             = @i_bc_ln,
@i_plazo             = @i_plazo,
@i_tplazo            = @i_tplazo,
@i_alianza           = @i_alianza,
@i_experiencia_cli   = @i_experiencia_cli,--Santander
@i_monto_max_tr      = @i_monto_max_tr,   --Santander
@i_naturaleza        = @i_naturaleza,
@o_tramite           = @w_tramite out

if @w_return <> 0
begin
   select @w_error = @w_return
   goto ERROR_PROCESO
end


update ca_operacion_tmp
set    opt_tramite = @w_tramite
where  opt_banco   = @w_banco

if @@error <> 0
begin
   select @w_error = 2103001
   goto ERROR_PROCESO
end


---------------------------------------------

select @w_factor     = td_factor 
from   cob_cartera..ca_tdividendo
where  td_tdividendo = @i_tplazo
and    td_estado     = 'V'

select @w_factor  = isnull(@w_factor, 7)

if @w_param_oferta_producto = 'S' begin
   select @w_dias_desplazados = @w_factor * isnull(@i_desplazamiento, 0) --Semanal
end

select @w_dias_desplazados = isnull(@w_dias_desplazados, 0)


if @w_dias_desplazados is not null and @w_dias_desplazados > 0 and @i_toperacion = 'GRUPAL' begin

   print 'DESPLAZAMIENTO --- @w_banco' + @w_banco
   print 'DESPLAZAMIENTO --- @i_cliente' + convert(varchar,@i_cliente)
   print 'DESPLAZAMIENTO --- @w_fecha_proceso' + convert(varchar,@w_fecha_proceso)
   
   if (select datediff(dd, dit_fecha_ini, dit_fecha_ven) from ca_dividendo_tmp where dit_operacion = @w_operacion and dit_dividendo = 1) < @w_dias_desplazados begin
      print 'Entrar a desplazar'
      exec @w_error      = sp_desplazamiento
      @i_banco           = @w_banco,
      @i_cliente         = @i_cliente,
      @i_fecha_valor     = @i_fecha_ini,
      @i_cuotas          = @i_desplazamiento,
      @i_archivo         = 'WORKFLOW',
      @i_oper_nueva      = 'S'
      
      if @w_error <> 0  goto ERROR_PROCESO
   end

end     
--------------------------------------------

--PRINT 'TRASLADO DE INFORMACION DESDE LAS TMP A DEFINITIVAS'
exec @w_return = sp_operacion_def
@s_date  = @s_date,
@s_sesn  = @s_sesn,
@s_user  = @s_user,
@s_ofi   = @s_ofi,
@i_banco = @w_banco,
@i_claseoper = @w_banco

if @w_return <> 0
begin
   select @w_error = @w_return
   goto ERROR_PROCESO
end


if isnull(@w_tramite, 0) > 0 begin

   update cob_credito..cr_tramite
   set    tr_numero_op = @w_operacion
   where  tr_tramite   = @w_tramite

   if @@error <> 0 begin
      select @w_error = 2103001
      goto ERROR_PROCESO
   end


--------------------------------------------

   if not exists (select 1 from cob_credito..cr_deudores
   where de_tramite = @w_tramite)  begin
   
   
      insert into cob_credito..cr_deudores
      (de_tramite, de_cliente, de_rol, de_ced_ruc)
      select
      @w_tramite, cl_cliente, cl_rol, cl_ced_ruc
      from cobis..cl_det_producto, cobis..cl_cliente
      where dp_cuenta = @w_banco
      and   dp_producto = 7
      and   cl_det_producto = dp_det_producto
   
      --Bandera que indica el tramite es grupal
       --PRINT 'sp_tramite_cca ACTUALIZO LA BANDERA DE GRUPAL ' + convert(varchar,@w_tramite) + '@i_banco ' + @w_banco
      if @i_grupal = 'S'
         update cob_credito..cr_deudores  set de_rol = 'G'
         where de_tramite = @w_tramite
   
         if @@error <> 0 begin
            select @w_error = 2103001
            goto ERROR_PROCESO
         end
   end

------------------------------------------
end


exec @w_return = sp_borrar_tmp
@s_sesn   = @s_sesn,
@s_user   = @s_user,
@s_term   = @s_term,
@i_banco  = @w_banco

if @w_return <> 0 begin
   select @w_error = @w_return
   goto ERROR_PROCESO
end


exec @w_return = sp_tir
@i_banco      = @w_banco,
@i_desacumula = 'S',
@o_tir        = @w_tir out,
@o_tea        = @w_tea out,
@o_cat        = @w_cat out

if @w_return != 0 begin 
   select @w_error = @w_return
   goto ERROR_PROCESO
end


if @i_grupal = 'S' begin 

   if @w_banco is null  begin
      print '1 - Banco : ' + isnull(@w_banco,'-999999999')
      print 'Error update TRAMITE_GRUPAL REF_GRUPAL'
      select @w_error = 7100021
      goto ERROR_PROCESO
   end
   
   select @w_cta_grupal = gr_cta_grupal
   from cobis..cl_grupo
   where gr_grupo = @w_grupo_id
   
   update cob_credito..cr_tramite_grupal
   set tg_referencia_grupal = @w_banco
   where tg_tramite = @w_tramite
   and tg_grupal  = 'S'
   
   update cob_credito..cr_tramite
   set tr_numero_op_banco = @w_banco
   where tr_tramite = @w_tramite

   update cob_cartera..ca_operacion SET 
   op_valor_cat = @w_cat,
   op_cuenta = @w_cta_grupal
   where op_operacion = @w_operacion
   
   if @@error <> 0 begin
      select @w_error = 2103001
      goto ERROR_PROCESO
   end
   
end else begin 

   update cob_cartera..ca_operacion SET 
   op_valor_cat = @w_cat
   where op_operacion = @w_operacion
   
   if @@error <> 0 begin
      select @w_error = 2103001
      goto ERROR_PROCESO
   end
-- LGU-FIN 2017-11-11
end

/* Ciclo del grupo */ 
select @w_ciclo = gr_num_ciclo from cobis..cl_grupo where gr_grupo = @i_cliente
/* Fecha de Creacion (Fecha Proceso) */ 
select @w_fecha_creacion = fp_fecha from cobis..ba_fecha_proceso


-----RENOVACIONES------------


update ca_operacion set 
op_renovacion  = 'S'
where op_banco = @w_banco 

if @@error <> 0 begin 
   select 
   @w_error = 70006,
   @w_msg   = 'ERROR: AL ACTUALIZAR LA OP EN LA MARCA COMO RENOVABLE'
   GOTO ERROR_PROCESO
end 

---MAXIMO VIGENTE ANTERIOR 
select  
@w_max_ciclo = isnull(max(dc_ciclo_grupo),0)
from cob_cartera..ca_det_ciclo 
where dc_grupo  = @i_cliente 

if @@rowcount = 0  or @w_max_ciclo = 0 begin 
   select 
   @w_error = 70006,
   @w_msg   = 'ERROR: NO TIENE OPERACIONES ANTERIORES '
   GOTO ERROR_PROCESO

end 


select distinct @w_banco_ant =  dc_referencia_grupal
from ca_det_ciclo 
where dc_grupo = @i_cliente 
and dc_ciclo_grupo = @w_max_ciclo

select 
@w_operacionca_or = op_operacion
from ca_operacion 
where op_banco =@w_banco_ant


--ACTUALIZAR AL BANCO NUEVO CON EL NUMERO DE TRAMITE NUEVO DE RENOVACION 

select @w_tasa_grupal_ant = ro_porcentaje
from ca_rubro_op
where ro_operacion        = @w_operacionca_or
and   ro_concepto         = 'INT'

select @w_num_renovacion = isnull(max(op_num_renovacion),0)
from   ca_operacion 
where  op_banco   = @w_banco_ant

---CONTAMOS CUANTOS PRESTAMOS ESTAN EN ESE CICLO

select @w_numero_prestamos =count(1)
from ca_det_ciclo 
where dc_grupo     =@i_cliente 
and dc_ciclo_grupo =@w_max_ciclo 


--VERIFICACION SI TODOS LOS PRESTAMOS DEL CICLO ANTERIOR AL MENOS HAY UN VIGENTE

select 
operacion = dc_operacion 
into #operaciones
from ca_det_ciclo 
where dc_grupo     =   @i_cliente 
and dc_ciclo_grupo =   @w_max_ciclo 


--- PRESTAMOS CANCELADOS ANTERIORES SI TODOS ESTAN CANCELADOS NO APLICA RENOVACION 
select @w_prestamos_cancelados = count(1)
from ca_operacion 
where op_estado = 3 
and   op_operacion in (select operacion from #operaciones )

if  @w_numero_prestamos =@w_prestamos_cancelados begin 
   select 
   @w_error = 70008,
   @w_msg   = 'ERROR:NO EXISTE PRESTAMOS VIGENTES ANTERIORES '
   GOTO ERROR_PROCESO 

end 

---

--ACTUALIZAR FECHA FIN  -1 ( PARA QUE NO SALGA EN LAS BUSQUEDAS )  OPERACION VIEJA
update ca_operacion set 
op_fecha_fin = dateadd(dd,-1,@w_fecha_proceso)
where op_banco  = @w_banco_ant

if @@error <> 0 begin 
   select 
   @w_error = 70006,
   @w_msg   = 'ERROR: AL ACTUALIZAR FECHA FIN DE LA OP'
   GOTO ERROR_PROCESO 
end  


update ca_operacion set 
op_oficina        =  @i_oficina,
op_oficial        =  @i_oficial,
op_ciudad         =  @w_ciudad ,
op_tramite        =  @w_tramite,
op_anterior       =  @w_banco_ant,
op_num_renovacion =  @w_num_renovacion  +1
where op_banco    =  @w_banco

if @@error <> 0 begin 
   select 
   @w_error = 70008,
   @w_msg   = 'ERROR: AL ACTUALIZAR LA LCR OFICIAL CIUDAD OFICINA '
   GOTO ERROR_PROCESO 
end 
 
insert into cob_credito..cr_op_renovar(
or_tramite        ,or_num_operacion      ,or_monto_original,  
or_saldo_original ,or_toperacion         ,or_login,
or_producto       ,or_finalizo_renovacion,or_operacion_original,
or_monto_inicial  ,or_referencia_grupal  ,
or_ciclo_original ,or_grupo              ,or_tasa_ciclo_ant   ) -- monto, solicitado y si tiene padre o no 
values(
@w_tramite       ,@w_banco               ,@i_monto,
0                ,@w_toperacion          ,@s_user,
'CARTERA'        ,'N'                    ,@w_operacionca_or,
0                ,null                   ,
@w_max_ciclo     ,@i_cliente             ,@w_tasa_grupal_ant )

if @@error <> 0 begin 
   select 
   @w_error = 70009,
   @w_msg   = 'ERROR: AL INSERTAR EN LA CR_OP_RENOVAR '
   GOTO ERROR_PROCESO 
end 


-----------------------------

--PRINT 'ENVIO DE LOS NUMEROS DE OPERACION Y TRAMITE GENERADOS'
select
@o_banco           = @w_banco,
@o_operacion       = @w_operacion,
@o_tramite         = @w_tramite,
@o_oficina         = @i_oficina,
@o_ciclo           = @w_ciclo + 1, --Se suma 1 al ciclo real
@o_fecha_creacion  = convert(varchar(10),@w_fecha_creacion,103)
------------------------


-----------------------------------------
--OBTENCION DE LA TASA GRUPAL PARA APK 
  
select @o_tasa_grp = @w_tasa_grupal_ant - @w_reduccion_tasa_grupal 
if @o_tasa_grp < @w_min_porc_tasa_grupal select @o_tasa_grp = convert(float, @w_tasa_grupal_ant)

print 'SRO @o_tasa_grp >>'+convert(varchar, @o_tasa_grp)
------------------------------------------

--FIN DE ATOMICIDAD 
if @w_commit = 'S'begin 
   select @w_commit = 'N'
   commit tran    
end 

return 0


ERROR_PROCESO:

if @w_commit = 'S'
   rollback tran

return @w_error

go

