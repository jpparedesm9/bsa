use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_crea_op_redes')
   drop proc sp_crea_op_redes 
go

create proc sp_crea_op_redes
        @s_date                       datetime = null,
        @s_ssn                        int = null,
        @s_sesn                       int = null,
        @s_ofi                        smallint = null,
        @s_user                       login = null,
        @s_term                       varchar(30) = null,
        @s_srv                        varchar(30) = null,
        @t_debug                      char(1) = 'N',
        @t_file                       varchar(14) = null,
        @t_from                       varchar(20) = null,
        @i_fecha_proceso              datetime = null,
        @i_usuario_tr                 login = null,
        @i_tramite_activa             int = null,
        @i_tramite                    int = null,       --Archivo Redescuento
        @i_modo                       smallint = null   --Archivo Redescuento 1 Crea,  null
as

DECLARE @w_sp_name    		      varchar(64),
	@w_nombre_completo            varchar(64),
        @w_error                      int,
        @w_return                     int,
        @w_ente                       int,
        @w_ente_empresa               int,
        @w_subtipo                    char(30),
        @w_identificacion             numero,
        @w_linea_credito              catalogo,
        @w_norma_legal                catalogo,
        @w_dir_predio                 varchar(60),
        @w_dir_cli                    varchar(60),
        @w_monto                      money,
        @w_moneda                     tinyint,
        @w_cod_entidad                char(3),
        @w_sector                     catalogo,
        @w_oficina_oper               smallint,
        @w_oficial                    smallint,
        @w_destino                    catalogo,
        @w_ubicacion                  int,
        @w_fecha_inicio               datetime,
        @w_forma_pago                 catalogo,
        @w_referencia_desem           cuenta,
        @w_estado_registro            char(1),
        @w_banco                      cuenta,
        @w_ciudad                     int,
        @w_periodo                    catalogo,
        @w_num_periodos               smallint,
        @w_clase                      catalogo,
        @w_tramite                    int,
	@w_cupo_linea                 cuenta,
	@w_operacionca                int,
	@w_operacioncai               int,
        @w_operacion                  int,
        @w_descripcion                varchar(255),
        @w_banca                      catalogo,
        @w_var_linea                  varchar(20),
        @w_op_operacion               int,
        @w_concepto_credito           catalogo,
        @w_margen_redescuento         float,
        @w_clase_cartera              catalogo,
        @w_mercado_objetivo           catalogo,
        @w_tipo_productor             varchar(24),
        @w_fecha_redes                datetime,
        @w_valor_proyecto             money,
        @w_sindicado                  char(1),
        @w_asociativo                 char(1),
        @w_incentivo                  char(1),
        @w_pos                        smallint,
        @w_parametro                  varchar(30),
        @w_parametro_of_pag           int,
        @w_parametro_nom_pag          varchar(30),
        @w_parametro_dir              varchar(30),
        @w_par_cod_ase                varchar(30),
        @w_par_cod_pol                varchar(30),
        @w_par_cob_pol                varchar(30),
        @w_par_fec_vig                varchar(30),
        @w_par_cod_alm                varchar(30),
        @w_par_nom_alm                varchar(30),
        @w_par_dir_alm                varchar(30),
        @w_num_pagare                 varchar(24),
        @w_rubro_economico            catalogo,
        @w_op_destino                 catalogo,
        @w_ciudad_inversion           int,
        @w_nom_beneficiario           varchar(64),
        @w_codigo_ciiu                catalogo,
        @w_ced_ruc                    varchar(14),
        @w_nom_oficina                varchar(64),
        @w_direccion                  varchar(200),
        @w_capital                    money,
        @w_valor_redescuento          money,
        @w_periodo_gracia             smallint,
        @w_plazo		      smallint,
        @w_fecha_vto_ini	      datetime,
        @w_fecha_vto_1cap	      datetime,
        @w_fecha_vto_fin	      datetime,
        @w_valor_cuota	              money,
        @w_num_dias                   smallint,
        @w_fecha_inicio_tr            datetime,
        @w_elegible                   char(1),
        @w_forward                    char(1),
        @w_tplazo                     catalogo,
        @w_tdividendo                 catalogo,
        @w_periodo_cap                int,
        @w_periodo_int                int,
        @w_dist_gracia                char(1),
        @w_gracia_cap                 int,
        @w_gracia_int                 int,
        @w_dia_fijo                   int,
        @w_evitar_feriados            char(1),
        @w_num_renovacion             int,
        @w_renovacion                 char(1),
        @w_mes_gracia                 tinyint,
        @w_reajustable                char(1),
        @w_dias_clausula              int,
        @w_periodo_crecimiento        smallint,
        @w_tasa_crecimiento           float,
        @w_opcion_cap                 char(1),
        @w_tasa_cap                   float,
        @w_dividendo_cap              smallint,
        @w_tipo_crecimiento           char(1),
	@w_reestructuracion           char(1),
      	@w_mora_retroactiva           char(1),
        @w_llave_redes                cuenta,
        @w_llave_redes_fin            cuenta,
        @w_subtipo_cliente            catalogo,
        @w_tipo_amortizacion          varchar(60),
        @w_tipo_plan                  char(2),
        @w_de_ced_ruc                 varchar(14),
        @w_ide_ben_1                  varchar(14),
        @w_doc_ben_1                  char(1),
        @w_tipo_ide 	              catalogo,
	@w_nom_ben_1                  descripcion,
        @w_nom_deudor                 descripcion,
	@w_tip_ben_1                  char(2),
        @w_tipo_cliente               catalogo,
	@w_sub_ben_1		      char(2),
        @w_act_ben_1                  money,
        @w_total_activos              money,
        @w_dir_ben_1                  varchar(60),
	@w_tel_ben_1                  cuenta,
        @w_telefono                   cuenta,
        @w_ide_ben_2                  varchar(14),
	@w_nom_ben_2                  descripcion,
        @w_doc_ben_2                  char(1),
	@w_tip_ben_2                  char(2),
	@w_sub_ben_2		      char(2),
        @w_act_ben_2                  money,
        @w_dir_ben_2                  descripcion,
	@w_tel_ben_2                  cuenta,
        @w_ide_ben_3                  varchar(14),
	@w_nom_ben_3                  descripcion,
        @w_doc_ben_3                  char(1),
	@w_tip_ben_3                  char(2),
	@w_sub_ben_3		      char(2),
        @w_act_ben_3                  money,
        @w_dir_ben_3                  descripcion,
	@w_tel_ben_3                  cuenta,
        @w_ide_ben_4                  varchar(14),
	@w_nom_ben_4                  descripcion,
        @w_doc_ben_4                  char(1),
	@w_tip_ben_4                  char(2),
	@w_sub_ben_4		      char(2),
        @w_act_ben_4                  money,
        @w_dir_ben_4                  descripcion,
	@w_tel_ben_4                  cuenta,
        @w_contador                   smallint,
        @w_cliente                    int,
        @w_ofi_pagare                 int,
        @w_nom_oficina_pagare         descripcion,
        @w_fecha_vig_poliza           datetime,
        @w_cod_poliza                 varchar(20),
        @w_cob_poliza                 catalogo,
        @w_cod_almacenadora           smallint,
        @w_nom_almacenera           descripcion,
        @w_cant_unidades              int,
        @w_valor_x_unidad             money,
        @w_valor_total                money,
        @w_sist_almacenamiento        catalogo,
        @w_num_cdm                    varchar(20),
        @w_tipo_tenencia              varchar(20),
        @w_cod_mun_almacen            int,
        @w_dir_almacen                descripcion,
        @w_margen_red_gar             float,
        @w_tipo_tasa                  char(1),
        @w_abonos_cap                 int,
        @w_abonos_int                 int,
        @w_porc_cap                   float,
        @w_porc_cap_1                 float,
        @w_porc_cap_2                 float,
        @w_fecha_hasta_cap            datetime,
        @w_puntos_tasa                float,
        @w_cod_aseguradora            varchar(20),
        @w_ac_divf                    int,
   	@w_cuota_desde_1		smallint ,
   	@w_cuota_hasta_1		smallint ,
   	@w_valor_cuota_1		money ,
   	@w_cuota_desde_2		smallint ,
   	@w_cuota_hasta_2		smallint ,
   	@w_valor_cuota_2		money ,
   	@w_cuota_desde_3		smallint ,
   	@w_cuota_hasta_3		smallint ,
   	@w_valor_cuota_3		money ,
   	@w_cuota_desde_4		smallint ,
   	@w_cuota_hasta_4		smallint ,
   	@w_valor_cuota_4		money ,
   	@w_cuota_desde_5		smallint ,
   	@w_cuota_hasta_5		smallint ,
   	@w_valor_cuota_5		money ,
   	@w_cuota_desde_6		smallint ,
   	@w_cuota_hasta_6		smallint ,
   	@w_valor_cuota_6		money ,
   	@w_cuota_desde_7		smallint ,
   	@w_cuota_hasta_7		smallint ,
   	@w_valor_cuota_7		money ,
   	@w_cuota_desde_8		smallint ,
   	@w_cuota_hasta_8		smallint ,
   	@w_valor_cuota_8		money ,
   	@w_cuota_desde_9		smallint ,
   	@w_cuota_hasta_9		smallint ,
   	@w_valor_cuota_9		money ,
   	@w_cuota_desde_10		smallint ,
   	@w_cuota_hasta_10		smallint ,
   	@w_valor_cuota_10		money ,
   	@w_fecha_amor_1		datetime ,
   	@w_valor_amor_1		money ,
   	@w_tipo_amor_1		smallint ,
   	@w_fecha_amor_2		datetime ,
   	@w_valor_amor_2		money ,
   	@w_tipo_amor_2		smallint ,
   	@w_fecha_amor_3		datetime ,
   	@w_valor_amor_3		money ,
   	@w_tipo_amor_3		smallint ,
   	@w_fecha_amor_4		datetime ,
   	@w_valor_amor_4		money ,
   	@w_tipo_amor_4		smallint ,
   	@w_fecha_amor_5		datetime ,
   	@w_valor_amor_5		money ,
   	@w_tipo_amor_5		smallint ,
   	@w_fecha_amor_6		datetime ,
   	@w_valor_amor_6		money ,
   	@w_tipo_amor_6		smallint ,
   	@w_fecha_amor_7		datetime ,
   	@w_valor_amor_7		money ,
   	@w_tipo_amor_7		smallint ,
   	@w_fecha_amor_8		datetime ,
   	@w_valor_amor_8		money ,
   	@w_tipo_amor_8		smallint ,
   	@w_fecha_amor_9		datetime ,
   	@w_valor_amor_9		money ,
   	@w_tipo_amor_9		smallint ,
   	@w_fecha_amor_10		datetime ,
   	@w_valor_amor_10		money ,
   	@w_tipo_amor_10		smallint ,
   	@w_fecha_amor_11		datetime ,
   	@w_valor_amor_11		money ,
   	@w_tipo_amor_11		smallint ,
   	@w_fecha_amor_12		datetime ,
   	@w_valor_amor_12		money ,
   	@w_tipo_amor_12		smallint ,
   	@w_fecha_amor_13		datetime ,
   	@w_valor_amor_13		money ,
   	@w_tipo_amor_13		smallint ,
   	@w_fecha_amor_14		datetime ,
   	@w_valor_amor_14		money ,
   	@w_tipo_amor_14		smallint ,
   	@w_fecha_amor_15		datetime ,
   	@w_valor_amor_15		money ,
   	@w_tipo_amor_15		smallint ,
   	@w_fecha_amor_16		datetime ,
   	@w_valor_amor_16		money ,
   	@w_tipo_amor_16		smallint ,
   	@w_fecha_amor_17		datetime ,
   	@w_valor_amor_17		money ,
   	@w_tipo_amor_17		smallint ,
   	@w_fecha_amor_18		datetime ,
   	@w_valor_amor_18		money ,
   	@w_tipo_amor_18		smallint ,
   	@w_fecha_amor_19		datetime ,
   	@w_valor_amor_19		money ,
   	@w_tipo_amor_19		smallint ,
   	@w_fecha_amor_20		datetime ,
   	@w_valor_amor_20		money ,
   	@w_tipo_amor_20		smallint ,
   	@w_fecha_amor_21		datetime ,
   	@w_valor_amor_21		money ,
   	@w_tipo_amor_21		smallint ,
   	@w_fecha_amor_22		datetime ,
   	@w_valor_amor_22		money ,
   	@w_tipo_amor_22		smallint ,
   	@w_fecha_amor_23		datetime ,
   	@w_valor_amor_23		money ,
   	@w_tipo_amor_23		smallint ,
   	@w_fecha_amor_24		datetime ,
   	@w_valor_amor_24		money ,
   	@w_tipo_amor_24		smallint ,
   	@w_fecha_amor_25		datetime ,
   	@w_valor_amor_25		money ,
   	@w_tipo_amor_25		smallint ,
   	@w_fecha_amor_26		datetime ,
   	@w_valor_amor_26		money ,
   	@w_tipo_amor_26		smallint ,
   	@w_fecha_amor_27		datetime ,
   	@w_valor_amor_27		money ,
   	@w_tipo_amor_27		smallint ,
   	@w_fecha_amor_28		datetime ,
   	@w_valor_amor_28		money ,
   	@w_tipo_amor_28		smallint ,
   	@w_fecha_amor_29		datetime ,
   	@w_valor_amor_29		money ,
   	@w_tipo_amor_29		smallint ,
   	@w_fecha_amor_30		datetime ,
   	@w_valor_amor_30		money ,
   	@w_tipo_amor_30		smallint ,
   	@w_fecha_amor_31		datetime ,
   	@w_valor_amor_31		money ,
   	@w_tipo_amor_31		smallint ,
   	@w_fecha_amor_32		datetime ,
   	@w_valor_amor_32		money ,
   	@w_tipo_amor_32		smallint ,
   	@w_fecha_amor_33		datetime ,
   	@w_valor_amor_33		money ,
   	@w_tipo_amor_33		smallint ,
   	@w_fecha_amor_34		datetime ,
   	@w_valor_amor_34		money ,
   	@w_tipo_amor_34		smallint ,
   	@w_fecha_amor_35		datetime ,
   	@w_valor_amor_35		money ,
   	@w_tipo_amor_35		smallint ,
   	@w_fecha_amor_36		datetime ,
   	@w_valor_amor_36		money ,
   	@w_tipo_amor_36		smallint ,
   	@w_fecha_amor_37		datetime ,
   	@w_valor_amor_37		money ,
   	@w_tipo_amor_37		smallint ,
   	@w_fecha_amor_38		datetime ,
   	@w_valor_amor_38		money ,
   	@w_tipo_amor_38		smallint ,
   	@w_fecha_amor_39		datetime ,
   	@w_valor_amor_39		money ,
   	@w_tipo_amor_39		smallint ,
   	@w_fecha_amor_40		datetime ,
   	@w_valor_amor_40		money ,
   	@w_tipo_amor_40		smallint ,
   	@w_fecha_amor_41		datetime ,
   	@w_valor_amor_41		money ,
   	@w_tipo_amor_41		smallint ,
   	@w_fecha_amor_42		datetime ,
   	@w_valor_amor_42		money ,
   	@w_tipo_amor_42		smallint ,
   	@w_fecha_amor_43		datetime ,
   	@w_valor_amor_43		money ,
   	@w_tipo_amor_43		smallint ,
   	@w_fecha_amor_44		datetime ,
   	@w_valor_amor_44		money ,
   	@w_tipo_amor_44		smallint ,
   	@w_fecha_amor_45		datetime ,
   	@w_valor_amor_45		money ,
   	@w_tipo_amor_45		smallint ,
   	@w_fecha_amor_46		datetime ,
   	@w_valor_amor_46		money ,
   	@w_tipo_amor_46		smallint ,
   	@w_fecha_amor_47		datetime ,
   	@w_valor_amor_47		money ,
   	@w_tipo_amor_47		smallint ,
   	@w_fecha_amor_48		datetime ,
   	@w_valor_amor_48		money ,
   	@w_tipo_amor_48		smallint ,
   	@w_fecha_amor_49		datetime ,
   	@w_valor_amor_49		money ,
   	@w_tipo_amor_49		smallint ,
   	@w_fecha_amor_50		datetime ,
   	@w_valor_amor_50		money ,
   	@w_tipo_amor_50		smallint ,
   	@w_fecha_amor_51		datetime ,
   	@w_valor_amor_51		money ,
   	@w_tipo_amor_51		smallint ,
   	@w_fecha_amor_52		datetime ,
   	@w_valor_amor_52		money ,
   	@w_tipo_amor_52		smallint ,
   	@w_fecha_amor_53		datetime ,
   	@w_valor_amor_53		money ,
   	@w_tipo_amor_53		smallint ,
   	@w_fecha_amor_54		datetime ,
   	@w_valor_amor_54		money ,
   	@w_tipo_amor_54		smallint ,
   	@w_fecha_amor_55		datetime ,
   	@w_valor_amor_55		money ,
   	@w_tipo_amor_55		smallint ,
   	@w_fecha_amor_56		datetime ,
   	@w_valor_amor_56		money ,
   	@w_tipo_amor_56		smallint ,
   	@w_fecha_amor_57		datetime ,
   	@w_valor_amor_57		money ,
   	@w_tipo_amor_57		smallint ,
   	@w_fecha_amor_58		datetime ,
   	@w_valor_amor_58		money ,
   	@w_tipo_amor_58		smallint ,
   	@w_fecha_amor_59		datetime ,
   	@w_valor_amor_59		money ,
   	@w_tipo_amor_59		smallint ,
   	@w_fecha_amor_60		datetime ,
   	@w_valor_amor_60		money ,
   	@w_tipo_amor_60		smallint ,
   	@w_cod_rubro_ppal		char(6)	,
   	@w_cant_unid_finan_ppal	int ,
   	@w_costo_inv_rubro_ppal	money ,
   	@w_valor_fin_rubro_ppal	money ,
   	@w_cod_rubro_2		char(6) ,
   	@w_cant_unid_finan_2	        int ,
   	@w_costo_inv_rubro_2	        money ,
   	@w_valor_fin_rubro_2	        money ,
   	@w_cod_rubro_3		char(6) ,
   	@w_cant_unid_finan_3	        int ,
   	@w_costo_inv_rubro_3	        money ,
   	@w_valor_fin_rubro_3		money ,
   	@w_cod_rubro_4		char(6) ,
   	@w_cant_unid_finan_4		int ,
   	@w_costo_inv_rubro_4		money ,
   	@w_valor_fin_rubro_4		money ,
   	@w_cod_rubro_5		char(6)	,
   	@w_cant_unid_finan_5		int ,
   	@w_costo_inv_rubro_5		money ,
   	@w_valor_fin_rubro_5		money ,
   	@w_concepto                  catalogo,
   	@w_cuota                     money,
   	@w_cuota_ant                 money,
   	@w_interes                   money,
   	@w_dividendo                 smallint,
   	@w_destino_t                 char(6),
   	@w_unidad_t                  int,
   	@w_costo_t                   money,
   	@w_valor_t                   money,
   	@w_rol_t                     char(1),
   	@w_banco_pasiva              cuenta,
   	@w_banco_activa              cuenta,
   	@w_tramite_activa            int,
   	@w_operacion_activa          int,
   	@w_operacion_pasiva          int,
   	@w_tipo_redondeo             int,
   	@w_montop                    money,
   	@w_linea_act                 int,
   	@w_num_deudores              smallint,
   	@w_tipo_gar_aso              catalogo,
   	@w_ac_operacion    		int,
   	@w_ac_div_ini      		int,
   	@w_ac_div_fin      		int,
   	@w_ac_rubro        		catalogo,
   	@w_ac_valor        		money,
   	@w_ac_porcentaje   		float,
   	@w_ac_divf_ini     		int,
   	@w_ac_divf_fin     		int,
   	@w_ac_rubrof       		catalogo,
   	@w_ac_secuencial   		int,
        @w_num_operacion                cuenta,
        @w_num_finagro                  int,
	@w_origen_fondos          catalogo,
        @w_cuenta_div             int,
        @w_div_ini                int,
        @w_cuota_tmp              money,
        @w_fin_datos              int,
        @w_ultimo_reg             char(1),
   	@w_tipo_cuota     	  smallint,
        @w_fecha_amortizacion     datetime,
        @w_signo                  char(1),
        @w_num_res          int,
        @w_tramite_activo   int,
        @w_fecha_corte      datetime,
        @w_codigo_externo   varchar(64),
        @w_cont_ddiv   int,
        @w_dias_div    smallint,
        @w_porcentaje  float,
        @w_ruta_fag    int ,
        @w_etapa_fag   tinyint,
        @w_tipo_esp    varchar(30),
        @w_recfag      varchar(30),
        @w_pid_asig	   int,
        @w_fag         char(1),
        @w_ncofag      int,
        @w_cofag       char(1),
        @w_fact_ben_1  datetime,
        @w_pas_fin     money,
        @w_fpas_fin_1  datetime,
        @w_num_desemb  int,
        @w_tnum_desemb int,
        @w_linea_cupo  int,
        @w_tr_tipo     char(1),
   	@w_linea_credito_pren 	varchar(20),
        @w_tr_num_desemb 	int,
	@w_tr_cod_actividad 	catalogo,
        @w_cont_ddiv1   int,
        @w_dias_div1    smallint,
	@w_retorno_cap		char(1),
	@w_retorno_int		char(1),
	@w_sujcred              catalogo,
        @w_fabrica              catalogo,
        @w_callcenter           catalogo,
        @w_apr_fabrica          catalogo,
        @w_rowcount             int,
        @w_monto_solicitado     money,
        @w_tipo_plazo	        catalogo,
        @w_tipo_cuota_cat       catalogo,
        @w_plazo_tra            smallint,
        @w_cuota_aproximada	    money,
        @w_fuente_recurso	    varchar(10),
        @w_tipo_credito	        char(1),
        @w_migrado	            varchar(16)
        

SELECT @w_sp_name       = 'sp_crea_op_redes',
       @w_ente          = 0,
       @w_ente_empresa  = 0,
       @w_tramite       = 0,
       @i_fecha_proceso = @s_date,
       @w_contador      = 0
select @w_pid_asig = @@spid * 100
 /* Obtener codigo de Banco Asignado por Finagro */
 SELECT @w_cod_entidad = pa_char                  -- Campo 58
 FROM cobis..cl_parametro
 WHERE pa_producto = 'CRE'
   and pa_nemonico = 'BAC'
 set transaction isolation level read uncommitted

 if @w_cod_entidad is null 
 BEGIN
      /* Error, no existe valor de Parametro */
      SELECT @w_return = 2101084

      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = @w_return,
           @i_msg   = 'Parametro BAC No Definido'

      return @w_return
 END

--Fecha de corte para liquidacion de operaciones
SELECT @w_fecha_corte = pa_datetime
FROM cobis..cl_parametro
WHERE pa_nemonico = 'FCOMF'
  AND pa_producto = 'CRE'
  select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted

 if @w_fecha_corte is null or @w_rowcount = 0
 BEGIN
      /* Error, no existe valor de Parametro */
      SELECT @w_return = 2101084

      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = @w_return,
           @i_msg   = 'Parametro FCOMF No Definido'

      return @w_return
 END


if @i_modo is null  -- Creacion Tramite de Redescuento Pasivo
BEGIN
   BEGIN TRAN --atomicidad por registro

        SELECT @w_estado_registro = 'T'

         /* DATOS PARA CREACION TRAMITE */
        select
          @w_ente                       = tr_cliente,
          @w_linea_credito              = tr_toperacion,
          @w_monto                      = tr_monto * (tr_margen_redescuento/100),
          @w_moneda                     = tr_moneda,
          @w_sector                     = tr_sector,
          @w_cliente                    = tr_cliente,
          @w_oficina_oper               = tr_oficina,
          @w_oficial                    = tr_oficial,
          @w_destino                    = tr_destino,
          @w_ubicacion                  = tr_ciudad_destino,
          @w_fecha_inicio               = @s_date,
          @w_estado_registro            = @w_estado_registro,
          @w_ciudad                     = tr_ciudad,
          @w_periodo                    = tr_periodo,
          @w_num_periodos               = tr_num_periodos,
          @w_clase                      = tr_clase,
          @w_tramite                    = tr_tramite,
          @w_concepto_credito           = tr_concepto_credito,
          @w_subtipo                    = tr_subtipo,
          @w_margen_redescuento         = tr_margen_redescuento,
          @w_mercado_objetivo           = tr_mercado_objetivo,
          @w_tipo_productor             = tr_tipo_productor,
          @w_valor_proyecto             = tr_valor_proyecto,
          @w_sindicado                  = tr_sindicado,
          @w_asociativo                 = tr_asociativo,
          @w_incentivo                  = tr_incentivo,
          @w_fecha_inicio_tr            = tr_fecha_inicio,
          @w_num_dias                   = tr_num_dias,
          @w_elegible                   = tr_elegible,
          @w_forward                    = tr_forward,
          @w_llave_redes                = tr_llave_redes,
 	  @w_operacion_activa           = op_operacion,
          @w_montop                     = tr_montop,
          @w_clase_cartera              = tr_clase,
	  @w_tr_cod_actividad   	= tr_cod_actividad,
	  @w_tr_num_desemb		= tr_num_desemb,
	  @w_sujcred                    = tr_sujcred,
          @w_fabrica                    = tr_fabrica,
          @w_callcenter                 = tr_callcenter,
          @w_apr_fabrica                = tr_apr_fabrica,
          @w_monto_solicitado           = tr_monto_solicitado,
        @w_tipo_plazo	        = tr_tipo_plazo,
        @w_tipo_cuota_cat       = tr_tipo_cuota,
        @w_plazo_tra	            = tr_plazo,
        @w_cuota_aproximada	    = tr_cuota_aproximada,
        @w_fuente_recurso	    = tr_fuente_recurso,
        @w_tipo_credito	        = tr_tipo_credito,
        @w_migrado	            = tr_migrado

        FROM 	cob_credito..cr_tramite,
		cob_cartera..ca_operacion,
		cobis..cl_oficina
        WHERE tr_tramite   = @i_tramite_activa
        and   tr_tramite   = op_tramite
        and   tr_oficina   = of_oficina


        select @i_fecha_proceso = op_fecha_ini
	from   cob_cartera..ca_operacion
	where  op_tramite       = @i_tramite_activa

         /* OBTENER LA BANCA Y NOMBRE DEL CLIENTE */
         SELECT @w_banca = en_banca,
                @w_nombre_completo  = case when en_subtipo = 'C' then en_nombre else rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido) + ' ' + rtrim(en_nombre) end,
                @w_identificacion   = en_ced_ruc
          FROM cobis..cl_ente
         WHERE en_ente = @w_ente

         select @w_rowcount = @@rowcount
         set transaction isolation level read uncommitted

         if @w_rowcount = 0
         BEGIN
             SELECT @w_return      = 2101005, -- Registro No existe
                    @w_descripcion =  'El Cliente no tiene banca asociada'
             goto  ERROR
         end


         SELECT @w_ciudad = of_ciudad
         FROM cobis..cl_oficina
         WHERE of_oficina = @w_oficina_oper
	 set transaction isolation level read uncommitted


         
         SELECT @w_linea_credito = codigo_sib
         from   cr_corresp_sib
         where  tabla = 'T200'
         and    codigo = @w_linea_credito


        /* OBTENER EL ORIGEN DE FONDOS */
        SELECT @w_origen_fondos = dt_categoria
        FROM cob_cartera..ca_default_toperacion
        WHERE dt_toperacion = @w_linea_credito
          and dt_moneda = @w_moneda

         if @@rowcount = 0
         BEGIN
             SELECT @w_return       = 2101005, -- Registro No existe
                    @w_descripcion = 'No existe Origen de Fondos'
             goto  ERROR
         end



         /*************************************/
	 /* CREAR OPERACION PASIVA EN CARTERA */
         /*************************************/

         /* SACAR SECUENCIALES SESIONES */
         exec @s_ssn = cob_cartera..sp_gen_sec
              @i_operacion  = -1

         exec @s_sesn = cob_cartera..sp_gen_sec
              @i_operacion  = -1


	 /* INGRESAR DEUDOR EN cob_cartera..ca_cliente_tmp */
	 exec @w_return = cob_cartera..sp_codeudor_tmp
         @s_sesn        = @s_sesn,
         @s_user        = @s_user,
         @i_borrar      = 'S',
         @i_secuencial  = 1,
         @i_titular     = @w_ente,
         @i_operacion   = 'A',
         @i_codeudor    = @w_ente,
         @i_ced_ruc     = @w_identificacion,
         @i_rol         = 'D',
         @i_externo     = 'N'

          if @w_return != 0
          BEGIN
             if @w_return = 1
                SELECT @w_descripcion =  'Genero error ejecutando sp_codeudor_tmp'
             goto ERROR
          end


 /* CREACION DE LA OPERACION EN TEMPORALES */
          exec @w_return = cob_cartera..sp_crear_operacion
 	  @s_user              = @s_user,
	  @s_date              = @s_date,
	  @s_term              = @s_term,
	  @i_cliente           = @w_ente,
	  @i_nombre            = @w_nombre_completo,
	  @i_sector            = @w_sector,
	  @i_toperacion        = @w_linea_credito,
	  @i_oficina           = @w_oficina_oper,
	  @i_moneda            = @w_moneda,
	  @i_comentario        = 'OPERACION DE REDESCUENTO PASIVA',
	  @i_oficial           = @w_oficial,
	  @i_fecha_ini         = @i_fecha_proceso,
	  @i_monto             = @w_monto,
	  @i_monto_aprobado    = @w_monto,
	  @i_destino           = @w_destino,
	  @i_ciudad            = @w_ciudad,
	  @i_forma_pago        = @w_forma_pago,
	  @i_cuenta            = @w_referencia_desem,
	  @i_formato_fecha     = 101,
	  @i_fondos_propios    = 'N',
	  @i_origen_fondos     = @w_origen_fondos,      -- MLO
      @i_lin_credito       = @w_cupo_linea,		--SBU 03/ene/2002
      @i_clase_cartera     = @w_clase_cartera,
	  @o_banco             = @w_banco output

          if @w_return != 0
          BEGIN
             if @w_return = 1
                SELECT @w_descripcion =  'Genero error ejecutando sp_crear_operacion'
              goto ERROR
          end


	   /* PASO A  DEFINITIVAS */
	   exec @w_return = cob_cartera..sp_operacion_def
	   @s_date   = @s_date,
	   @s_sesn   = @s_sesn,
	   @s_user   = @s_user,
	   @s_ofi    = @w_oficina_oper,
	   @i_banco  = @w_banco

	   if @w_return != 0
           BEGIN
              if @w_return = 1
                 SELECT @w_descripcion =  'Genero error ejecutando sp_operacion_def'
	      goto ERROR
	   end


           /* BORRAR TEMPORALES */
           exec @w_return = cob_cartera..sp_borrar_tmp
           @i_banco  = @w_banco,
           @s_user   = @s_user

           if @w_return <> 0
           BEGIN
              if @w_return = 1
                 SELECT @w_descripcion =  'Genero error ejecutando sp_borrar_tmp'
              goto  ERROR
           end



         /***************************************/
	 /* CREAR TRAMITE PARA OPERACION PASIVA */
         /***************************************/
          SELECT @w_tramite = 0

          exec @w_return =  cob_credito..sp_crea_tr_redes
   	  @s_ssn                =  @s_ssn,
          @s_sesn               =  @s_sesn,
          @s_user               =  @s_user,
          @s_term               =  @s_term,
          @s_date               =  @s_date,
          @s_srv                =  @s_srv,
          @s_lsrv               =  @s_srv,
          @s_ofi                =  @w_oficina_oper,
          @i_tipo               =  'O',
          @i_oficina_tr         =  @w_oficina_oper,
          @i_usuario_tr         =  @i_usuario_tr,
          @i_fecha_crea         =  @i_fecha_proceso,
          @i_oficial            =  @w_oficial,
          @i_sector             =  @w_sector,
          @i_ciudad             =  @w_ciudad,
          @i_banco              =  @w_banco,
          @i_linea_credito      =  @w_cupo_linea,
          @i_toperacion         =  @w_linea_credito,
          @i_producto           = 'CCA',
          @i_monto              =  @w_monto,
          @i_moneda             =  @w_moneda,
          @i_periodo            =  @w_periodo,
          @i_num_periodos       =  @w_num_periodos,
          @i_destino            =  @w_destino,
          @i_ciudad_destino     =  @w_ubicacion,
          @i_cliente            =  @w_ente,
          @i_estado             =  'N',
          @i_clase              =  @w_clase,
          @i_concepto_credito   =  @w_concepto_credito,
          @i_subtipo            =  @w_subtipo,
          @i_margen_redescuento =  @w_margen_redescuento,
          @i_tramite_activa     =  @i_tramite_activa,
          @i_mercado_objetivo   =  @w_mercado_objetivo,
          @i_tipo_productor     =  @w_tipo_productor,
          @i_valor_proyecto     =  @w_valor_proyecto,
          @i_sindicado          =  @w_sindicado,
          @i_asociativo         =  @w_asociativo,
          @i_incentivo          =  @w_incentivo,
          @i_num_dias           =  @w_num_dias,
          @i_fecha_inicio       =  @w_fecha_inicio_tr,
          @i_elegible           =  @w_elegible,
          @i_forward            =  @w_forward,
          @i_montop             =  @w_montop,
 	      @i_sujcred            =  @w_sujcred,
          @i_fabrica            =  @w_fabrica,
          @i_callcenter         =  @w_callcenter,
          @i_apr_fabrica        =  @w_apr_fabrica,
          @i_monto_solicitado   =  @w_monto_solicitado,
          @i_tipo_plazo	        =  @w_tipo_plazo,
          @i_tipo_cuota_cat     =  @w_tipo_cuota_cat,
          @i_plazo_tra	        =  @w_plazo_tra,
          @i_cuota_aproximada	=  @w_cuota_aproximada,
          @i_fuente_recurso	    =  @w_fuente_recurso,
          @i_tipo_credito	    =  @w_tipo_credito,
          @i_migrado	        =  @w_migrado,
          @o_tramite            =  @w_tramite   out

          if @w_return != 0
          BEGIN
             if @w_return = 1
                SELECT @w_descripcion =  'Genero error cob_credito..sp_crea_tr_redes'
             goto  ERROR
          END

          /* ACTUALIZAR ESTADO DE LA OPERACION */
          UPDATE cob_cartera..ca_operacion
          SET    op_tramite = @w_tramite,
                 op_estado  = 99
          WHERE op_banco = @w_banco

          if @@error != 0
          BEGIN
             SELECT @w_return = 2105001,  -- Error en actualizacion de registro
                    @w_descripcion =  'Error al actualizar estado en cartera'
             goto ERROR
          END


          /* ACTUALIZACION DEL TR_OP_REDESCUENTO */
          SELECT @w_op_operacion = op_operacion
            FROM cob_cartera..ca_operacion
          WHERE op_tramite = @w_tramite

          UPDATE cob_credito..cr_tramite
          SET tr_op_redescuento = convert(int,@w_banco)
          WHERE tr_tramite = @i_tramite_activa

          if @@error != 0
          BEGIN
             SELECT @w_return = 2105001,  -- Error en actualizacion de registro
                    @w_descripcion =  'Error al actualizar Numero de Redescuento en el Tramite'
             goto ERROR
          END


          UPDATE cob_credito..cr_tramite
	  SET 	 tr_cod_actividad    = @w_tr_cod_actividad,
		 tr_num_desemb       = @w_tr_num_desemb
          WHERE  tr_tramite 	     = @w_tramite

          print 'Creacion Tramite Pasiva No. : %1!' + cast (@w_tramite as varchar)

          select
           @w_plazo             = op_plazo,
           @w_tplazo            = op_tplazo,
           @w_tdividendo        = op_tdividendo,
           @w_periodo_cap       = op_periodo_cap,
           @w_periodo_int       = op_periodo_int,
           @w_dist_gracia       = op_dist_gracia,
           @w_gracia_cap        = op_gracia_cap,
           @w_gracia_int        = op_gracia_int,
           @w_dia_fijo          = op_dia_fijo,
           @w_cuota             = op_cuota,
           @w_evitar_feriados   = op_evitar_feriados,
           @w_num_renovacion    = op_num_renovacion,
           @w_renovacion        = op_renovacion,
           @w_mes_gracia        = op_mes_gracia,
           @w_reajustable       = op_reajustable,
           @w_dias_clausula     = op_dias_clausula,
           @w_periodo_crecimiento = op_periodo_crecimiento,
           @w_tasa_crecimiento    = op_tasa_crecimiento,
           @w_opcion_cap          = op_opcion_cap,
           @w_tasa_cap            = op_tasa_cap,
           @w_dividendo_cap       = op_dividendo_cap,
           @w_tipo_crecimiento    = op_tipo_crecimiento,
	   @w_reestructuracion    = op_reestructuracion,
      	   @w_mora_retroactiva    = op_mora_retroactiva,
           @w_tipo_amortizacion   = op_tipo_amortizacion,
           @w_tipo_redondeo       = op_tipo_redondeo
          FROM cob_cartera..ca_operacion
          WHERE op_tramite = @i_tramite_activa

          SELECT @w_banco = op_banco
          FROM cob_cartera..ca_operacion
          WHERE op_tramite = @w_tramite

	  SELECT @w_operacionca = convert(int,@w_banco)



         /*****************************************************************************/
	 /* MODIFICAR EN LA OPERACION PASIVA LOS VALORES PERSONALIZADOS EN LA ACTIVA  */
         /*****************************************************************************/

	/* GENERAR TABLAS TEMPORALES */
	exec @w_return = cob_cartera..sp_crear_tmp
	@s_user        = @s_user,
	@s_term        = @s_term,
	@i_banco       = @w_banco,
	@i_accion      = 'A'


        /*MODIFICACION DE LA OPERACION PASIVA*/
        SELECT @w_evitar_feriados =  dt_evitar_feriados
        FROM   cob_cartera..ca_default_toperacion
        WHERE  dt_toperacion	= @w_linea_credito

        exec @w_return = cob_cartera..sp_modificar_operacion_int
          @s_user              = @s_user,
          @s_sesn              = @s_sesn,
          @s_date              = @s_date,
          @s_term              = @s_term,
          @s_ofi               = @s_ofi,
	  @i_banco             = @w_banco,
	  @i_operacion         = 'U',
	  @i_operacionca       = @w_operacionca,
          @i_calcular_tabla    = 'S',
          @i_tabla_nueva       = 'S',
          @i_plazo               = @w_plazo,
          @i_tplazo              = @w_tplazo,
          @i_tdividendo          = @w_tdividendo,
          @i_periodo_cap         = @w_periodo_cap,
          @i_periodo_int         = @w_periodo_int,
          @i_dist_gracia         = @w_dist_gracia,
          @i_gracia_cap          = @w_gracia_cap,
          @i_gracia_int          = @w_gracia_int,
          @i_dia_fijo            = @w_dia_fijo,
          @i_cuota               = @w_cuota,
          @i_evitar_feriados     = @w_evitar_feriados,
          @i_num_renovacion      = @w_num_renovacion,
          @i_renovacion          = @w_renovacion,
          @i_mes_gracia          = @w_mes_gracia,
          @i_reajustable         = @w_reajustable,
          @i_dias_clausula       = @w_dias_clausula,
          @i_periodo_crecimiento = @w_periodo_crecimiento,
          @i_tasa_crecimiento    = @w_tasa_crecimiento,
          @i_opcion_cap          = @w_opcion_cap,
          @i_tasa_cap            = @w_tasa_cap,
          @i_dividendo_cap       = @w_dividendo_cap,
          @i_tipo_crecimiento    = @w_tipo_crecimiento,
	  @i_reestructuracion    = @w_reestructuracion,
      	  @i_mora_retroactiva    = @w_mora_retroactiva,
          @i_tipo_amortizacion   = @w_tipo_amortizacion,
	  @i_tipo_redondeo       = @w_tipo_redondeo,
          @i_operacion_activa    = @w_operacion_activa


	   /* PASO A  DEFINITIVAS */
	   exec @w_return = cob_cartera..sp_operacion_def
	   @s_date   = @s_date,
	   @s_sesn   = @s_sesn,
	   @s_user   = @s_user,
	   @s_ofi    = @w_oficina_oper,
	   @i_banco  = @w_banco

	   if @w_return != 0
           BEGIN
              if @w_return = 1
                 SELECT @w_descripcion =  'Genero error ejecutando sp_operacion_def'
	      goto ERROR
	   end


           /* BORRAR TEMPORALES */
           exec @w_return = cob_cartera..sp_borrar_tmp
           @i_banco  = @w_banco,
           @s_user   = @s_user
           if @w_return <> 0
           BEGIN
              SELECT @w_error = @w_return
              if @w_error = 1
                 SELECT @w_descripcion =  'Genero error ejecutando sp_borrar_tmp'
              goto  ERROR
           end


         /* COPIAR ACCIONES DE LA OPERACION */
         DECLARE seleccion_pasiva CURSOR FOR
	 SELECT convert(int,@w_banco),
		ac_div_ini,
		ac_div_fin,
		ac_rubro,
		ac_valor,
		ac_porcentaje,
		ac_divf_ini,
		ac_divf_fin,
		ac_rubrof
	 FROM cob_cartera..ca_acciones
	 WHERE ac_operacion = @w_operacion_activa
         for read only

         OPEN seleccion_pasiva

         FETCH seleccion_pasiva INTO
               @w_ac_operacion,  @w_ac_div_ini,  @w_ac_div_fin,  @w_ac_rubro, @w_ac_valor,
               @w_ac_porcentaje, @w_ac_divf_ini, @w_ac_divf_fin, @w_ac_rubrof

         WHILE @@fetch_status = 0
         BEGIN
            if (@@fetch_status = -1)
            BEGIN
               PRINT 'Error al leer datos del cursor'
               SELECT @w_return = 710004
               goto ERROR
            end

            exec @w_ac_secuencial = cob_cartera..sp_gen_sec
                    @i_operacion  = @w_ac_operacion

            INSERT cob_cartera..ca_acciones
            values (@w_ac_operacion,	@w_ac_div_ini,	  @w_ac_div_fin,   @w_ac_rubro,
	 	    @w_ac_valor,	@w_ac_porcentaje, @w_ac_divf_ini,  @w_ac_divf_fin,
	 	    @w_ac_rubrof,	@w_ac_secuencial)

            if @@error <> 0
            BEGIN
               SELECT @w_return = 710001
               goto ERROR
            end

            FETCH seleccion_pasiva INTO
                  @w_ac_operacion,  @w_ac_div_ini,  @w_ac_div_fin,  @w_ac_rubro, @w_ac_valor,
                  @w_ac_porcentaje, @w_ac_divf_ini, @w_ac_divf_fin, @w_ac_rubrof
         END
         CLOSE seleccion_pasiva
         deallocate seleccion_pasiva


        if @w_tipo_amortizacion = 'MANUAL'
        BEGIN
           DELETE cob_cartera..ca_amortizacion        WHERE am_operacion = convert(int,@w_banco)
            if @@error <> 0
            BEGIN
               SELECT @w_return = 2107001 -- Error en eliminacion de registro
               goto ERROR
            end


           DELETE cob_cartera..ca_cuota_adicional     WHERE ca_operacion = convert(int,@w_banco)
           if @@error <> 0
            BEGIN
               SELECT @w_return = 2107001 -- Error en eliminacion de registro
               goto ERROR
            end


           DELETE cob_cartera..ca_dividendo           WHERE di_operacion = convert(int,@w_banco)
           if @@error <> 0
            BEGIN
               SELECT @w_return = 2107001 -- Error en eliminacion de registro
               goto ERROR
            end


           INSERT INTO cob_cartera..ca_amortizacion
	   SELECT convert(int,@w_banco), am_dividendo,		am_concepto,		am_estado,
		  am_periodo,		 am_cuota,		am_gracia,		am_pagado,
		  am_acumulado,		 am_secuencia
	   FROM cob_cartera..ca_amortizacion
	   WHERE am_operacion = @w_operacion_activa
	     and am_concepto in (SELECT ru_concepto
				FROM 	cob_cartera..ca_rubro
				WHERE 	ru_toperacion	= @w_linea_credito)

           if @@error <> 0
            BEGIN
               SELECT @w_return = 2103001 -- Error en insercion de registro
               goto ERROR
            end


           INSERT INTO cob_cartera..ca_dividendo
           SELECT convert(int,@w_banco), di_dividendo,	di_fecha_ini,	di_fecha_ven,
                  di_de_capital,	 di_de_interes,	di_gracia,	di_gracia_disp,
                  di_estado,		 di_dias_cuota,	di_intento,	di_prorroga, di_fecha_can
           FROM 	cob_cartera..ca_dividendo
           WHERE 	di_operacion = @w_operacion_activa

           if @@error <> 0
            BEGIN
               SELECT @w_return = 2103001 -- Error en insercion de registro
               goto ERROR
            END

           SELECT @w_operacioncai = convert(int,@w_banco)

           exec  @w_return      = cob_cartera..sp_int_pasivas_manuales
                 @i_operacionca = @w_operacioncai

       END
COMMIT TRAN     ---Fin de la transaccion
END
ELSE
BEGIN
      /*********************************/
      /* CREACION ARCHIVO REDESCUENTO  */
      /*********************************/


        select  @w_banco              = op_banco,              --ok
                @w_operacion          = op_operacion,          --ok
        	@w_tramite            = tr_tramite,            --ok
		@w_num_finagro        =(CASE 	datalength(tr_llave_redes)
					WHEN 	18 	THEN convert(int,substring(tr_llave_redes, 11, 6))
					ELSE 	convert(int,substring(tr_llave_redes, 11, 5))
					END ),
                @w_cliente            = tr_cliente,
        	@w_ciudad_inversion   = tr_ciudad_destino,      -- Campo 18
        	@w_llave_redes        = tr_llave_redes,         -- campo 2 y 5
        	@w_fecha_redes        = op_fecha_ini,           -- campo 10, 11 y 12
        	@w_capital            = op_monto_aprobado,      -- Campo 95
        	@w_plazo              = op_plazo,               -- Campo 77
        	@w_tplazo             = op_tplazo,              -- ok
	        @w_periodo_cap        = op_periodo_cap,         -- campo 81
        	@w_periodo_int        = op_periodo_int,         -- campo 88
	        @w_tipo_productor     = tr_tipo_productor,      -- campo 23, 24
        	@w_oficina_oper       = tr_oficina,             -- campo 52, 56
        	@w_nom_oficina        = of_nombre,              -- campo 57
                @w_margen_redescuento = tr_margen_redescuento,  -- campo 94
                @w_linea_credito      = op_toperacion,
        	@w_tipo_amortizacion  = op_tipo_amortizacion,
                @w_tdividendo         = op_tdividendo
        FROM cob_credito..cr_tramite, cob_cartera..ca_operacion, cobis..cl_oficina
        WHERE tr_tramite   = @i_tramite
        and   tr_tramite   = op_tramite
        and   tr_oficina   = of_oficina

        if @w_tramite = 0
        BEGIN
            /* Registro No existe */
            SELECT @w_return = 2101005

            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = @w_return,
               @i_msg   = 'Operacion u Oficina no existe'

            return @w_return
        END

        /*** NORMA LEGAL ***/                             -- Campo 4
        SELECT @w_parametro = pa_char
        FROM cobis..cl_parametro
        WHERE pa_nemonico = 'NLLF'
        set transaction isolation level read uncommitted

        select @w_norma_legal = rtrim(dt_valor)
        FROM cr_datos_tramites
        WHERE dt_tramite = @i_tramite
        and   dt_dato    = rtrim(@w_parametro)

        SELECT @w_pos = charindex('-',@w_norma_legal)
        if @w_pos > 0
           SELECT @w_norma_legal = rtrim(substring(@w_norma_legal, 1, @w_pos-1))
--         NOMRA LEGAL SE UTILIZA PARA FINAGRO
--        if @w_norma_legal is null
--        BEGIN
--
--            /* Registro No existe */
--            SELECT @w_return = 2101005
--
--            exec cobis..sp_cerror
--               @t_debug = @t_debug,
--               @t_file  = @t_file,
--               @t_from  = @w_sp_name,
--               @i_num   = @w_return,
--               @i_msg   = 'Tramite No Tiene Norma Legal'
--
--            return @w_return
--        END


              SELECT @w_num_deudores = count(1)
              FROM cr_deudores
              WHERE de_tramite = @i_tramite
              and   de_rol in ('D', 'S')

        if @@rowcount = 0
        BEGIN
            /* Registro No existe */
            SELECT @w_return = 2101005
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = @w_return,
               @i_msg   = 'Tramite No Tiene Deudores Principales ni Solidarios'

            return @w_return
        END

        /*** Consultar Numero de Operacion Activa ***/
        select @w_banco_pasiva = op_banco,
               @w_operacion_pasiva = op_operacion
        FROM cob_cartera..ca_operacion
        WHERE op_tramite = @i_tramite

        if @@rowcount = 0
        BEGIN
            /* Registro No existe */
            SELECT @w_return = 2101005

            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = @w_return,
               @i_msg   = 'No existe Operacion en Cartera'

            return @w_return
        END

        SELECT @w_tramite_activa = tr_tramite,
               @w_num_desemb     = tr_num_desemb,
               @w_linea_cupo     = tr_linea_credito,
               @w_tr_tipo        = tr_tipo
        FROM   cr_tramite
        WHERE  tr_op_redescuento = @w_operacion_pasiva

        if @@rowcount = 0
        BEGIN
            /* Registro No existe */
            SELECT @w_return = 2101005

            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = @w_return,
               @i_msg   = 'No existe Tramite Activo'

            return @w_return
        END

        select 	@w_tnum_desemb = dd_numdes
        from 	cr_distribucion_desembolso,
                cr_linea
        where	dd_tramite       = li_tramite
	and	li_numero      	 = @w_linea_cupo


        SELECT @w_banco_activa     = op_banco,
               @w_operacion_activa = op_operacion,
	       @w_op_destino       = op_destino
        FROM cob_cartera..ca_operacion
        WHERE op_tramite = @w_tramite_activa

        if @@rowcount = 0
        BEGIN
            /* Registro No existe */
            SELECT @w_return = 2101005

            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = @w_return,
               @i_msg   = 'No existe Operacion Activa'

            return @w_return
        END


        if @w_tr_tipo  = 'R'
        begin
           select @w_tnum_desemb = 1,
                  @w_num_desemb  = 1
        end


        /*** Rubro Principal ***/
        SELECT @w_rubro_economico  = dt_destino            -- CAMPO 17
        FROM cr_destino_tramite
        WHERE dt_tramite = @w_tramite_activa
        and   dt_rol = 'S'

	if @w_rubro_economico  is null
	   select @w_rubro_economico = @w_op_destino



        /* Puntos adicionales para calculo de tasa total */   -- CAMPO 99
        select @w_puntos_tasa = ro_factor,      -- CAMPO 99
               @w_signo       = ro_signo
        FROM cob_cartera..ca_rubro_op
        WHERE ro_operacion = @w_operacion_activa
          and ro_tipo_rubro = 'I'

        if @w_signo = '-'
           select @w_puntos_tasa = @w_puntos_tasa  * -1.00


        SELECT 	@w_linea_credito_pren= SUBSTRING(pa_char,1,DATALENGTH(pa_char)-1)+'1'
        FROM 	cobis..cl_parametro
        WHERE 	pa_producto 	= 'CRE'
        and 	pa_nemonico 	= 'BPREN'

        if exists (select 1
   	    	   from  cr_tramite
           	   where tr_tramite 	= @w_tramite_activa
           	   and   tr_toperacion	= @w_linea_credito_pren)
	BEGIN
         SELECT   @w_codigo_externo = cu_codigo_externo,
                  @w_num_pagare     = cu_codigo_externo
           FROM   cr_gar_propuesta,
                  cob_custodia..cu_custodia
          WHERE   gp_tramite 	= @w_tramite_activa
          and     gp_garantia 	= cu_codigo_externo
          and     cu_tipo 	in ('3100')
          and     cu_estado 	in ('P','V','F')
	END
        else
        BEGIN
           /*** Numero de Pagare ***/
           SELECT  @w_codigo_externo = cu_codigo_externo
           FROM  cr_gar_propuesta,
                 cob_custodia..cu_custodia
           WHERE  gp_tramite = @w_tramite_activa
           and    gp_garantia = cu_codigo_externo
           and    cu_tipo in ('6100','6300')
           and    cu_estado in ('P','V','F')

           if  @w_fecha_redes < @w_fecha_corte
               select 	@w_num_pagare 	  = ic_valor_item
               from 	cob_custodia..cu_item_custodia
               where 	ic_codigo_externo = @w_codigo_externo and ic_item = 2
           else
               SELECT  @w_num_pagare = @w_codigo_externo       -- Campo 9

           if @@rowcount = 0
           BEGIN
              /* Registro No existe */
              SELECT @w_return = 2101005

             exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = @w_return,
               @i_msg   = 'No existe Pagare para la Operacion Activa'
              return @w_return
           END
        END


        /**************************/
        /*** DATOS DE CLIENTES ****/
        /**************************/

        /*** Tipo y Subtipo del cliente ***/
        /* Para todos los clientes del tramite, se asigna el valor definido en el tramtie */
        SELECT @w_tipo_cliente    = substring(codigo_sib, 1, 2),    -- campo 23
               @w_subtipo_cliente = substring(codigo_sib, 3, 2)     -- campo 24
        FROM cr_corresp_sib
        WHERE tabla = 'T24'
        and   codigo = @w_tipo_productor

        if @@rowcount = 0
        BEGIN
            /* Error, no existe valor de Parametro */
            SELECT @w_return = 2101084

            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = @w_return,
               @i_msg   = 'No existe Tipo/SubTipo de Cliente en tabla de correspondencias T24'

            return @w_return
        END


        /*** Direccion del Cliente ***/  -- Campo 26
        /* Colocar la direccion del predio para todos los clientes */

        select @w_parametro_dir = pa_char
        from cobis..cl_parametro
        where pa_nemonico = 'DP'
        set transaction isolation level read uncommitted


        /* SPO Se cambia por la direccion del cliente. Pedido usuario
        select @w_dir_predio = ltrim(rtrim(dt_valor))
        from cr_datos_tramites
        where dt_tramite = @w_tramite_activa
        and   dt_dato    = rtrim(@w_parametro_dir)
        */


        SELECT @w_contador = 0
        delete cr_ben_redes
        where  br_tramite =  @i_tramite

        DECLARE cursor_cliente CURSOR FOR
    	SELECT  en_ente,
            --ltrim(rtrim(en_nomlar)),      -- campo 22
                case when en_subtipo='C' then en_nombre else ltrim(rtrim(p_p_apellido)) + ' ' + ltrim(rtrim(ltrim(rtrim(p_s_apellido + ' ' + en_nombre)))) end, --campo 22
        	ltrim(rtrim(en_ced_ruc)),     -- campo 20
	        tr_cod_actividad,
        	isnull(c_total_activos,0),    -- campo 25
            en_tipo_ced                   -- campo 21
	    FROM cob_credito..cr_tramite, cr_deudores, cobis..cl_ente
        WHERE tr_tramite   = @i_tramite
          and tr_tramite   = de_tramite
          and de_rol in ('D', 'S')
          and de_cliente   = en_ente
        order by de_rol
        for read only

        OPEN cursor_cliente
        FETCH cursor_cliente
        INTO @w_ente, @w_nom_beneficiario, @w_ced_ruc, @w_codigo_ciiu, @w_total_activos, @w_tipo_ide

        while @@fetch_status = 0
        BEGIN
           if (@@fetch_status = -1)
           BEGIN
              /* Error en recuperacion de Datos del Cursor */
              SELECT @w_return = 2101015

              exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = @w_return,
                 @i_msg   = 'Error Recuperar Datos Cursor cursor_cliente'

              return @w_return
           END

           /* iniciar variables */
           select @w_telefono   = null

          select @w_contador = @w_contador + 1

           /* Tipo de Identificacion de Cliente, segun Clasificacion de Finagro */
           select @w_tipo_ide = codigo_sib
           from cr_corresp_sib
           where tabla = 'T30'
             and codigo = @w_tipo_ide

           if @@rowcount = 0
           BEGIN
              /* Error, No existen datos del Cliente o Codigos de Correspondencia */
              SELECT @w_return = 2101094

              exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = @w_return,
                 @i_msg   = 'Error, No existe Tipo de Identificacion de Cliente en Tabla de Correspondencia T30'

              return @w_return
           END


           /* Buscar telefono del cliente */
           /* Asignar a todos los clientes la direccion del predio */

           set rowcount 1
           select @w_dir_cli = ''
           select @w_dir_cli = di_descripcion
           from cobis..cl_direccion
           where di_ente = @w_ente
           and di_principal = 'S'

           SET ROWCOUNT 1
           select @w_telefono   = te_valor
           FROM cobis..cl_telefono
           WHERE te_ente = @w_ente
  	       set transaction isolation level read uncommitted
           SET ROWCOUNT 0

           if @w_contador = 1
              SELECT @w_ide_ben_1 = @w_ced_ruc,
		     @w_doc_ben_1 = @w_tipo_ide,
		     @w_nom_ben_1 = @w_nom_beneficiario,
		     @w_act_ben_1 = @w_total_activos,
             @w_tip_ben_1 = @w_tipo_cliente,
		     @w_sub_ben_1 = @w_subtipo_cliente,
		     @w_dir_ben_1 = @w_dir_cli,--@w_dir_predio, -- @w_direccion,
		     @w_tel_ben_1 = @w_telefono
           if @w_contador = 2
              SELECT @w_ide_ben_2 = @w_ced_ruc,
		     @w_doc_ben_2 = @w_tipo_ide,
		     @w_nom_ben_2 = @w_nom_beneficiario,
		     @w_act_ben_2 = @w_total_activos,
                     @w_tip_ben_2 = @w_tipo_cliente,
		     @w_sub_ben_2 = @w_subtipo_cliente,
		     @w_dir_ben_2 = @w_dir_cli,--@w_dir_predio, -- @w_direccion,
		     @w_tel_ben_2 = @w_telefono
           if @w_contador = 3
              SELECT @w_ide_ben_3 = @w_ced_ruc,
		     @w_doc_ben_3 = @w_tipo_ide,
		     @w_nom_ben_3 = @w_nom_beneficiario,
		     @w_act_ben_3 = @w_total_activos,
                     @w_tip_ben_3 = @w_tipo_cliente,
		     @w_sub_ben_3 = @w_subtipo_cliente,
		     @w_dir_ben_3 = @w_dir_cli,--@w_dir_predio, -- @w_direccion,
		     @w_tel_ben_3 = @w_telefono

           if @w_contador = 4
              SELECT @w_ide_ben_4 = @w_ced_ruc,
		     @w_doc_ben_4 = @w_tipo_ide,
		     @w_nom_ben_4 = @w_nom_beneficiario,
		     @w_act_ben_4 = @w_total_activos,
             @w_tip_ben_4 = @w_tipo_cliente,
		     @w_sub_ben_4 = @w_subtipo_cliente,
		     @w_dir_ben_4 = @w_dir_cli,--@w_dir_predio, -- @w_direccion,
		     @w_tel_ben_4 = @w_telefono

            insert into cr_ben_redes
            (br_tramite,
             br_ide_ben,
             br_doc_ben,
             br_nom_ben,
             br_tip_ben,
             br_sub_ben,
             br_act_ben,
             br_dir_ben,
             br_tel_ben)
            values(
             @i_tramite,
             @w_ced_ruc,
             @w_tipo_ide,
             @w_nom_beneficiario,
             @w_tipo_cliente,
             @w_subtipo_cliente,
             @w_total_activos,
             @w_dir_cli,
             @w_telefono)





            FETCH cursor_cliente
            INTO @w_ente, @w_nom_beneficiario, @w_ced_ruc, @w_codigo_ciiu, @w_total_activos, @w_tipo_ide
        END
        CLOSE cursor_cliente
        deallocate cursor_cliente


        /******************************/
        /*   OFICINA REPOSA PAGARE    */
        /******************************/
        SELECT @w_parametro_of_pag = pa_int                  -- Campo 58
        FROM cobis..cl_parametro
        WHERE pa_nemonico = 'OFPAG' -- OFICINA REPOSA PAGARE
        select @w_rowcount = @@rowcount
	set transaction isolation level read uncommitted

        if @w_parametro_of_pag is null or @w_rowcount = 0
        BEGIN
            /* Error, no existe valor de Parametro */
            SELECT @w_return = 2101084

            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = @w_return,
               @i_msg   = 'Parametro OFPAG No Definido'

            return @w_return
        END

        /* Nombre Oficina Reposa Pagare */                 -- Campo 59
        SELECT @w_parametro_nom_pag = pa_char
        FROM cobis..cl_parametro
        WHERE pa_nemonico = 'NOPAG' -- NOMBRE OFICINA REPOSA PAGARE
        select @w_rowcount = @@rowcount
	set transaction isolation level read uncommitted

        if @w_parametro_of_pag is null or @w_rowcount = 0
        BEGIN
            /* Error, no existe valor de Parametro */
            SELECT @w_return = 2101084

            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = @w_return,
               @i_msg   = 'Parametro NOPAG No Definido'

            return @w_return
        END




        /************************************************/
        /*** bono de prenda sobre la operacion activa ***/
        /************************************************/

        /* Obtener codigo de Linea Bono Prenda */
        SELECT @w_parametro = pa_char
        FROM cobis..cl_parametro
        WHERE pa_producto = 'CRE'
          and pa_nemonico = 'BPREN'  -- LINEA BONO PRENDA

        if @w_parametro is null or @@rowcount = 0
        BEGIN
            /* Error, no existe valor de Parametro */
            SELECT @w_return = 2101084

            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = @w_return,
               @i_msg   = 'Parametro BPREN No Definido'

            return @w_return
        END


        /* SI ES UNA LINEA DE BONO PRENDA CONSULTAR DATOS */
        IF @w_parametro = @w_linea_credito
        BEGIN
           /*** Codigo Almacenadora ***/                              -- Campo 64
           select @w_par_cod_alm = pa_char
           FROM cobis..cl_parametro
           WHERE pa_nemonico = 'CODALM'  and pa_producto = 'CRE'
           select @w_rowcount = @@rowcount
	   set transaction isolation level read uncommitted

           if @w_parametro is null or @w_rowcount = 0
           BEGIN
               /* Error, no existe valor de Parametro */
               SELECT @w_return = 2101084

               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = @w_return,
                  @i_msg   = 'Parametro CODALM No Definido'

               return @w_return
           END

           select @w_cod_almacenadora   = convert(smallint,rtrim(dt_valor))
           FROM cr_datos_tramites
           WHERE dt_tramite = @i_tramite
           and   dt_dato    = rtrim(@w_par_cod_alm)


           /*** Nombre Almacenadora ***/                              -- Campo 65
           select @w_par_nom_alm = pa_char
           FROM cobis..cl_parametro
           WHERE pa_nemonico = 'NOMALM'  and pa_producto = 'CRE'
           select @w_rowcount = @@rowcount
 	   set transaction isolation level read uncommitted

           if @w_parametro is null or @w_rowcount = 0
           BEGIN
               /* Error, no existe valor de Parametro */
               SELECT @w_return = 2101084

               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = @w_return,
                  @i_msg   = 'Parametro NOMALM No Definido'

               return @w_return
           END

           select @w_nom_almacenera     = rtrim(dt_valor)
           FROM cr_datos_tramites
           WHERE dt_tramite = @i_tramite
           and   dt_dato    = rtrim(@w_par_nom_alm)



           /*** Datos de la Mercaderia  ***/

           /*** Cantidad de unidades de la mercaderia ***/            -- Campo 66
           select @w_parametro = pa_char
           FROM cobis..cl_parametro
           WHERE pa_nemonico = 'NUNID'  and pa_producto = 'CRE'
           select @w_rowcount = @@rowcount
	   set transaction isolation level read uncommitted

           if @w_parametro is null or @w_rowcount = 0
           BEGIN
               /* Error, no existe valor de Parametro */
               SELECT @w_return = 2101084

               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = @w_return,
                  @i_msg   = 'Parametro NUNID No Definido'

               return @w_return
           END

           select @w_cant_unidades  = convert(int,rtrim(dt_valor))
           FROM cr_datos_tramites
           WHERE dt_tramite = @i_tramite
           and   dt_dato    = rtrim(@w_parametro)



           /*** Valor por unidad de la mercaderia ***/                -- Campo 67
           select @w_parametro = pa_char
           FROM cobis..cl_parametro
           WHERE pa_nemonico = 'VRUNI'  and pa_producto = 'CRE'
           select @w_rowcount = @@rowcount
	   set transaction isolation level read uncommitted

           if @w_parametro is null or @w_rowcount = 0
           BEGIN
               /* Error, no existe valor de Parametro */
               SELECT @w_return = 2101084

               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = @w_return,
                  @i_msg   = 'Parametro VRUNI No Definido'

               return @w_return
           END

           select @w_valor_x_unidad  = convert(money,rtrim(dt_valor))
           FROM cr_datos_tramites
           WHERE dt_tramite = @i_tramite
           and   dt_dato    = rtrim(@w_parametro)


           /*** Valor Total de la mercaderia ***/                       -- Campo 68
           select @w_parametro = pa_char
           FROM cobis..cl_parametro
           WHERE pa_nemonico = 'VRMCI'  and pa_producto = 'CRE'
           select @w_rowcount = @@rowcount
	   set transaction isolation level read uncommitted

           if @w_parametro is null or @w_rowcount = 0
           BEGIN
               /* Error, no existe valor de Parametro */
               SELECT @w_return = 2101084

               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = @w_return,
                  @i_msg   = 'Parametro VRMCI No Definido'

               return @w_return
           END

           select @w_valor_total = convert(money,rtrim(dt_valor))
           FROM cr_datos_tramites
           WHERE dt_tramite = @i_tramite
           and   dt_dato    = rtrim(@w_parametro)



           /*** Sistema de Almacenamiento ***/                        -- Campo 69
           select @w_parametro = pa_char
           FROM cobis..cl_parametro
           WHERE pa_nemonico = 'SISTAL'  and pa_producto = 'CRE'
           select @w_rowcount = @@rowcount
	   set transaction isolation level read uncommitted

           if @w_parametro is null or @w_rowcount = 0
           BEGIN
               /* Error, no existe valor de Parametro */
               SELECT @w_return = 2101084

               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = @w_return,
                  @i_msg   = 'Parametro SISTAL No Definido'

               return @w_return
           END

           select @w_sist_almacenamiento = dt_valor
           FROM cr_datos_tramites
           WHERE dt_tramite = @i_tramite
           and   dt_dato    = rtrim(@w_parametro)


           /*** Numero CDM ***/                                        -- Campo 70
           select @w_parametro = pa_char
           FROM cobis..cl_parametro
           WHERE pa_nemonico = 'CDM'  and pa_producto = 'CRE'
           select @w_rowcount = @@rowcount
  	   set transaction isolation level read uncommitted

           if @w_parametro is null or @w_rowcount = 0
           BEGIN
               /* Error, no existe valor de Parametro */
               SELECT @w_return = 2101084

               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = @w_return,
                  @i_msg   = 'Parametro CODCDM No Definido'

               return @w_return
           END

           select @w_num_cdm        = rtrim(dt_valor)
           FROM cr_datos_tramites
           WHERE dt_tramite = @i_tramite
           and   dt_dato    = rtrim(@w_parametro)



           /*** Tipo Tenencia ***/                        -- Campo 71
           select @w_parametro = pa_char
           FROM cobis..cl_parametro
           WHERE pa_nemonico = 'TENEN'  and pa_producto = 'CRE'
           select @w_rowcount = @@rowcount
  	   set transaction isolation level read uncommitted

           if @w_parametro is null or @w_rowcount = 0
           BEGIN
               /* Error, no existe valor de Parametro */
               SELECT @w_return = 2101084

               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = @w_return,
                  @i_msg   = 'Parametro TENEN No Definido'

               return @w_return
           END

           select @w_tipo_tenencia = rtrim(dt_valor)
           FROM cr_datos_tramites
           WHERE dt_tramite = @i_tramite
           and   dt_dato    = rtrim(@w_parametro)


           /*** Codigo de Municipio donde se localiza el almacen ***/    -- Campo 72
           select @w_parametro = pa_char
           FROM cobis..cl_parametro
           WHERE pa_nemonico = 'COMU'  and pa_producto = 'CRE'
           select @w_rowcount = @@rowcount
  	   set transaction isolation level read uncommitted

           if @w_parametro is null or @w_rowcount = 0
           BEGIN
               /* Error, no existe valor de Parametro */
               SELECT @w_return = 2101084

               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = @w_return,
                  @i_msg   = 'Parametro COMU No Definido'

               return @w_return
           END

           select @w_cod_mun_almacen = convert(int, rtrim(dt_valor))
           FROM cr_datos_tramites
           WHERE dt_tramite = @i_tramite
           and   dt_dato    = rtrim(@w_parametro)


           /*** Direccion Bodega ***/                              -- Campo 73
           select @w_par_dir_alm = pa_char
           FROM cobis..cl_parametro
           WHERE pa_nemonico = 'DIRALM'  and pa_producto = 'CRE'
           select @w_rowcount = @@rowcount
 	   set transaction isolation level read uncommitted

           if @w_par_dir_alm is null or @w_rowcount = 0
           BEGIN
               /* Error, no existe valor de Parametro */
               SELECT @w_return = 2101084

               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = @w_return,
                  @i_msg   = 'Parametro DIRALM No Definido'

               return @w_return
           END

           select @w_dir_almacen        = rtrim(dt_valor)
           FROM cr_datos_tramites
           WHERE dt_tramite = @i_tramite
           and   dt_dato    = rtrim(@w_par_dir_alm)



           /*** Porcentaje de descuento establecido para el bono prenda ***/    -- Campo 74
           select @w_parametro = pa_char
           FROM cobis..cl_parametro
           WHERE pa_nemonico = 'MDTO'  and pa_producto = 'CRE'
           select @w_rowcount = @@rowcount
 	   set transaction isolation level read uncommitted

           if @w_parametro is null or @w_rowcount = 0
           BEGIN
               /* Error, no existe valor de Parametro */
               SELECT @w_return = 2101084

               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = @w_return,
                  @i_msg   = 'Parametro MDTO No Definido'

               return @w_return
           END

           select @w_margen_red_gar   = convert(float, rtrim(dt_valor))
           FROM cr_datos_tramites
           WHERE dt_tramite = @i_tramite
           and   dt_dato    = rtrim(@w_parametro)

        END -- Bono Prenda



        /**********************/
        /*    TIPO DE PLAN    */                                       -- CAMPO 75
        /**********************/
        /* Preferencia: 1) Capitalizable,  2) Variable  3) Lineal  */

        /* SIN IMPORTAR EL TIPO DE AMORTIZACION, SI EXISTEN REGISTROS EN CA_ACCIONES, ES CAPITALIZABLE*/

        if exists ( SELECT 1 FROM cob_cartera..ca_acciones --Capitalizacion
                    WHERE ac_operacion = @w_operacion )
           SELECT @w_tipo_plan = '10'  -- CAPITALIZABLE
        ELSE
        begin  

           exec sp_cal_tplan
		@i_operacion	= @w_operacion,
		@i_concepto	= 'C',
		@o_retorno	= @w_retorno_cap output 

	   exec sp_cal_tplan
	   	@i_operacion	= @w_operacion,
		@i_concepto	= 'I',
		@o_retorno	= @w_retorno_int output 
      
           if @w_retorno_cap = 'L' and @w_retorno_int = 'L'
              SELECT @w_tipo_plan = '2' -- LINEAL
           else
              SELECT @w_tipo_plan = '9' --Variable Total


        end




        /*** Tipo de Tasa ***/                     -- Campo 76
        SELECT @w_tipo_tasa = ro_fpago
        FROM cob_cartera..ca_rubro_op
        WHERE ro_operacion = @w_operacion
        -- and   ro_concepto  = 'CAP'
        --and   ro_tipo_rubro = 'C'
        and   ro_tipo_rubro = 'I'   --SPO se debe tomar el rubro de interes

        if @w_tipo_tasa = 'P'
           SELECT @w_tipo_tasa = 'V'


        /***  Plazo  ***/                                      -- Campo 77
        SELECT @w_plazo      = (@w_plazo * td_factor)/30
	FROM   cob_cartera..ca_tdividendo
        WHERE  td_tdividendo  = @w_tplazo


        /*** Fecha 1er vencimiento ***/
        SELECT @w_fecha_vto_ini = min(di_fecha_ven) -- CAMPO 78
        FROM cob_cartera..ca_dividendo
        WHERE di_operacion = @w_operacion


        /*** Fecha 1er vencimiento de Capital ***/
        --SELECT @w_fecha_vto_1cap = min(di_fecha_ven)
        --FROM cob_cartera..ca_dividendo
        --WHERE di_operacion = @w_operacion
        --  and di_de_capital = 'S'

        SELECT @w_fecha_vto_1cap = min(di_fecha_ven)
        FROM cob_cartera..ca_amortizacion, cob_cartera..ca_dividendo
        WHERE am_operacion = @w_operacion
        and am_concepto = 'CAP'
        and am_cuota > 0
        and am_operacion = di_operacion
        and am_dividendo = di_dividendo


        /*** Fecha Vcto Final ***/
        SELECT @w_fecha_vto_fin = max(di_fecha_ven)  -- CAMPO 80
        FROM cob_cartera..ca_dividendo
        WHERE di_operacion = @w_operacion

        /*** Frecuencia de Capital, Periodo Gracia, Frecuencia Interes ***/
	SELECT @w_periodo_cap    = (@w_periodo_cap * td_factor)/30,                  -- campo 81
               @w_periodo_gracia = datediff (mm, @w_fecha_redes, @w_fecha_vto_1cap), -- campo 83
               @w_periodo_int    = (@w_periodo_int * td_factor)/30                   -- campo 88
	FROM   cob_cartera..ca_tdividendo
        WHERE  td_tdividendo  = @w_tdividendo




        -- Tipo de plan Variable o Capitalizable ==> Periodo = 1
        if @w_tipo_plan = '10' or @w_tipo_plan = '9'
           SELECT @w_periodo_cap = 1,                                    -- campo 81,
                  @w_periodo_int = 1                                     -- campo 88

        /*** Abonos de Capital ***/                                      -- CAMPO 82
        select @w_abonos_cap = count(1)
        FROM  cob_cartera..ca_dividendo, cob_cartera..ca_amortizacion
        WHERE di_operacion  = @w_operacion
        and   di_operacion  = am_operacion
        and   di_dividendo  = am_dividendo
        and   am_concepto   = 'CAP'
        and   am_cuota      > 0


        /*** Abonos de interes ***/                                      -- CAMPO 89
        select @w_abonos_int = count(1)
        FROM  cob_cartera..ca_dividendo, cob_cartera..ca_amortizacion
        WHERE di_operacion  = @w_operacion
        and   di_operacion  = am_operacion
        and   di_dividendo  = am_dividendo
        and   am_concepto   = 'INT'
        and   am_cuota      > 0


        /******************/
        /* CAPITALIZACION */
        /******************/

        SELECT @w_contador = 0

        set rowcount 2 -- Se requiere unicamente las 2 primeras capitalizaciones

        DECLARE cursor_capitaliza CURSOR FOR

        SELECT ac_porcentaje, ac_div_fin, di_fecha_ven
        FROM cob_cartera..ca_acciones,
             cob_cartera..ca_dividendo
        WHERE ac_operacion = @w_operacion
          and ac_operacion = di_operacion
          and ac_div_fin   = di_dividendo
        order by ac_secuencial asc


        OPEN cursor_capitaliza
        FETCH cursor_capitaliza into @w_porc_cap, @w_ac_divf, @w_fecha_hasta_cap
        WHILE @@fetch_status = 0
        BEGIN
            if (@@fetch_status = -1)
            BEGIN
              /* Error en recuperacion de Datos del Cursor */
              SELECT @w_return = 2101015

              exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = @w_return,
                 @i_msg   = 'Error Recuperar Datos Cursor cursor_capitaliza'

              return @w_return
            END

            SELECT @w_contador = @w_contador + 1

            if @w_contador = 1
               SELECT @w_porc_cap_1      = @w_porc_cap,        -- CAMPO 91
                      @w_fecha_hasta_cap = @w_fecha_hasta_cap  -- CAMPO 92

            if @w_contador = 2
               SELECT @w_porc_cap_2 = @w_porc_cap        -- CAMPO 93

             FETCH cursor_capitaliza into @w_porc_cap, @w_ac_divf, @w_fecha_hasta_cap
        end
        close cursor_capitaliza
        deallocate cursor_capitaliza
        set rowcount 0


        /************************************/
        /*           PLAN DE CUOTAS         */
        /************************************/

        /* Planes NO VARIABLES llena campos re_cuota_XXXXXX */
        if @w_tipo_plan not in( '9','10')
        BEGIN

            DECLARE cursor_cuotas CURSOR FOR
            SELECT am_dividendo, am_cuota
            FROM cob_cartera..ca_amortizacion
            WHERE am_operacion = @w_operacion
              and am_concepto  = 'CAP'
              and am_cuota > 0
            order by am_dividendo
            for read only

            select @w_contador   = 0,
                   @w_cuenta_div = 0,
                   @w_div_ini    = 0,
                   @w_cuota_tmp  = 0,
                   @w_ultimo_reg = 'N'

             OPEN cursor_cuotas
             FETCH cursor_cuotas INTO @w_dividendo,  @w_cuota

            select @w_fin_datos = @@fetch_status

            while @w_fin_datos != 2 or @w_ultimo_reg = 'N'
            BEGIN

              if (@w_fin_datos = 1)
              BEGIN
                 /* Error en recuperacion de Datos del Cursor */
                 SELECT @w_return = 2101015

                 exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = @w_return,
                    @i_msg   = 'Error Recuperar Datos Cursor cursor_cuotas'

                 return @w_return
               END

              /* Varible utilizada para forzar un ingreso mas al while, despues que haya leido */
              /* todos los registros, para grabar en la tabla, los datos del ultimo registro   */
              if @w_fin_datos = 2
                 select @w_ultimo_reg 	= 'S',
			@w_cuota	= 0,
			@w_dividendo	= 0


              if @w_cuenta_div = 0
                 select @w_cuota_tmp  = @w_cuota,
                        @w_div_ini    = 1

              if @w_cuota_tmp = @w_cuota  /* Cuotas Iguales */
                 select @w_cuenta_div = @w_cuenta_div + 1

              else /* Cuotas Diferentes */
              BEGIN
                   SELECT @w_contador = @w_contador + 1

                   /* Asignar variables para grabar en la tabla */
                   if @w_contador = 1
                      SELECT  @w_cuota_desde_1 = @w_div_ini,
                              @w_cuota_hasta_1 = @w_cuenta_div,
                              @w_valor_cuota_1 = @w_cuota_tmp

                   if @w_contador = 2
                      SELECT  @w_cuota_desde_2 = @w_div_ini,
                              @w_cuota_hasta_2 = @w_cuenta_div,
                              @w_valor_cuota_2 = @w_cuota_tmp

                   if @w_contador = 3
                      SELECT  @w_cuota_desde_3 = @w_div_ini,
                              @w_cuota_hasta_3 = @w_cuenta_div,
                              @w_valor_cuota_3 = @w_cuota_tmp

                   if @w_contador = 4
                      SELECT  @w_cuota_desde_4 = @w_div_ini,
                              @w_cuota_hasta_4 = @w_cuenta_div,
                              @w_valor_cuota_4 = @w_cuota_tmp

                  if @w_contador = 5
                      SELECT  @w_cuota_desde_5 = @w_div_ini,
                              @w_cuota_hasta_5 = @w_cuenta_div,
                              @w_valor_cuota_5 = @w_cuota_tmp

                   if @w_contador = 6
                      SELECT  @w_cuota_desde_6 = @w_div_ini,
                              @w_cuota_hasta_6 = @w_cuenta_div,
                              @w_valor_cuota_6 = @w_cuota_tmp
                   if @w_contador = 7
                      SELECT  @w_cuota_desde_7 = @w_div_ini,
                              @w_cuota_hasta_7 = @w_cuenta_div,
                              @w_valor_cuota_7 = @w_cuota_tmp

                   if @w_contador = 8
                      SELECT  @w_cuota_desde_8 = @w_div_ini,
                              @w_cuota_hasta_8 = @w_cuenta_div,
                              @w_valor_cuota_8 = @w_cuota_tmp

                   if @w_contador = 9
                      SELECT  @w_cuota_desde_9 = @w_div_ini,
                              @w_cuota_hasta_9 = @w_cuenta_div,
                              @w_valor_cuota_9 = @w_cuota_tmp

                   if @w_contador = 10
                      SELECT  @w_cuota_desde_10 = @w_div_ini,
                              @w_cuota_hasta_10 = @w_cuenta_div,
                              @w_valor_cuota_10 = @w_cuota_tmp

                 select @w_div_ini    = @w_cuenta_div + 1,
                        @w_cuota_tmp  = @w_cuota,
                        @w_cuenta_div = @w_cuenta_div + 1

              END -- else /* Cuotas Diferentes */
             FETCH cursor_cuotas INTO @w_dividendo,  @w_cuota
             select @w_fin_datos = @@fetch_status

           END -- while

           close cursor_cuotas
           deallocate cursor_cuotas

        END
        else -- plan variable


        BEGIN
            DECLARE cursor_dividendos CURSOR FOR
            SELECT di_dividendo, di_fecha_ven, am_cuota,
                   case
                       WHEN am_cuota = 0 then 5
                       else  3
                   end
            FROM cob_cartera..ca_dividendo,
                 cob_cartera..ca_amortizacion
            WHERE di_operacion = @w_operacion
              and di_operacion = am_operacion
              and di_dividendo = am_dividendo
              and am_concepto = 'CAP'
             order by di_dividendo
             for read only

            select @w_contador   = 0

            OPEN cursor_dividendos
            FETCH cursor_dividendos INTO @w_dividendo,  @w_fecha_amortizacion, @w_cuota, @w_tipo_cuota

            while @@fetch_status = 0
            BEGIN

                if (@@fetch_status = -1)
                BEGIN
                    /* Error en recuperacion de Datos del Cursor */
                    SELECT @w_return = 2101015

                    exec cobis..sp_cerror
                       @t_debug = @t_debug,
                       @t_file  = @t_file,
                       @t_from  = @w_sp_name,
                       @i_num   = @w_return,
                       @i_msg   = 'Error Recuperar Datos Cursor cursor_dividendos'

                    return @w_return
                 END

                select @w_contador = @w_contador + 1

                if @w_contador = 1
	           SELECT @w_fecha_amor_1 = @w_fecha_amortizacion,
                          @w_valor_amor_1 = @w_cuota,
                          @w_tipo_amor_1  = @w_tipo_cuota

                if @w_contador = 2
	           SELECT @w_fecha_amor_2 = @w_fecha_amortizacion,
                          @w_valor_amor_2 = @w_cuota,
                          @w_tipo_amor_2  = @w_tipo_cuota

                if @w_contador = 3
	           SELECT @w_fecha_amor_3 = @w_fecha_amortizacion,
                          @w_valor_amor_3 = @w_cuota,
                          @w_tipo_amor_3  = @w_tipo_cuota

                if @w_contador = 4
	           SELECT @w_fecha_amor_4 = @w_fecha_amortizacion,
                          @w_valor_amor_4 = @w_cuota,
                          @w_tipo_amor_4  = @w_tipo_cuota

               if @w_contador = 5
	           SELECT @w_fecha_amor_5 = @w_fecha_amortizacion,
                          @w_valor_amor_5 = @w_cuota,
                          @w_tipo_amor_5  = @w_tipo_cuota

                if @w_contador = 6
	           SELECT @w_fecha_amor_6 = @w_fecha_amortizacion,
                          @w_valor_amor_6 = @w_cuota,
                          @w_tipo_amor_6  = @w_tipo_cuota

                if @w_contador = 7
	           SELECT @w_fecha_amor_7 = @w_fecha_amortizacion,
                          @w_valor_amor_7 = @w_cuota,
                          @w_tipo_amor_7  = @w_tipo_cuota

                if @w_contador = 8
	           SELECT @w_fecha_amor_8 = @w_fecha_amortizacion,
                          @w_valor_amor_8 = @w_cuota,
                          @w_tipo_amor_8  = @w_tipo_cuota

                if @w_contador = 9
	           SELECT @w_fecha_amor_9 = @w_fecha_amortizacion,
                          @w_valor_amor_9 = @w_cuota,
                          @w_tipo_amor_9  = @w_tipo_cuota


                if @w_contador = 10
	           SELECT @w_fecha_amor_10 = @w_fecha_amortizacion,
                          @w_valor_amor_10 = @w_cuota,
                          @w_tipo_amor_10  = @w_tipo_cuota

                if @w_contador = 11
	           SELECT @w_fecha_amor_11 = @w_fecha_amortizacion,
                          @w_valor_amor_11 = @w_cuota,
                          @w_tipo_amor_11  = @w_tipo_cuota

                if @w_contador = 12
	           SELECT @w_fecha_amor_12 = @w_fecha_amortizacion,
                          @w_valor_amor_12 = @w_cuota,
                          @w_tipo_amor_12  = @w_tipo_cuota

                if @w_contador = 13
	           SELECT @w_fecha_amor_13 = @w_fecha_amortizacion,
                          @w_valor_amor_13 = @w_cuota,
                          @w_tipo_amor_13  = @w_tipo_cuota

                if @w_contador = 14
	           SELECT @w_fecha_amor_14 = @w_fecha_amortizacion,
                          @w_valor_amor_14 = @w_cuota,
                          @w_tipo_amor_14  = @w_tipo_cuota

               if @w_contador = 15
	           SELECT @w_fecha_amor_15 = @w_fecha_amortizacion,
                          @w_valor_amor_15 = @w_cuota,
                          @w_tipo_amor_15  = @w_tipo_cuota

                if @w_contador = 16
	           SELECT @w_fecha_amor_16 = @w_fecha_amortizacion,
                          @w_valor_amor_16 = @w_cuota,
                          @w_tipo_amor_16  = @w_tipo_cuota

                if @w_contador = 17
	           SELECT @w_fecha_amor_17 = @w_fecha_amortizacion,
                          @w_valor_amor_17 = @w_cuota,
                          @w_tipo_amor_17  = @w_tipo_cuota

                if @w_contador = 18
	           SELECT @w_fecha_amor_18 = @w_fecha_amortizacion,
                          @w_valor_amor_18 = @w_cuota,
                          @w_tipo_amor_18  = @w_tipo_cuota

                if @w_contador = 19
	           SELECT @w_fecha_amor_19 = @w_fecha_amortizacion,
                          @w_valor_amor_19 = @w_cuota,
                          @w_tipo_amor_19  = @w_tipo_cuota


                if @w_contador = 20
	           SELECT @w_fecha_amor_20 = @w_fecha_amortizacion,
                          @w_valor_amor_20 = @w_cuota,
                          @w_tipo_amor_20  = @w_tipo_cuota

                if @w_contador = 21
	           SELECT @w_fecha_amor_21 = @w_fecha_amortizacion,
                          @w_valor_amor_21 = @w_cuota,
                          @w_tipo_amor_21  = @w_tipo_cuota

                if @w_contador = 22
	           SELECT @w_fecha_amor_22 = @w_fecha_amortizacion,
                          @w_valor_amor_22 = @w_cuota,
                          @w_tipo_amor_22  = @w_tipo_cuota

                if @w_contador = 23
	           SELECT @w_fecha_amor_23 = @w_fecha_amortizacion,
                          @w_valor_amor_23 = @w_cuota,
                          @w_tipo_amor_23  = @w_tipo_cuota

                if @w_contador = 24
	           SELECT @w_fecha_amor_24 = @w_fecha_amortizacion,
                          @w_valor_amor_24 = @w_cuota,
                          @w_tipo_amor_24  = @w_tipo_cuota

               if @w_contador = 25
	           SELECT @w_fecha_amor_25 = @w_fecha_amortizacion,
                          @w_valor_amor_25 = @w_cuota,
                          @w_tipo_amor_25  = @w_tipo_cuota

                if @w_contador = 26
	           SELECT @w_fecha_amor_26 = @w_fecha_amortizacion,
                          @w_valor_amor_26 = @w_cuota,
                          @w_tipo_amor_26  = @w_tipo_cuota

                if @w_contador = 27
	           SELECT @w_fecha_amor_27 = @w_fecha_amortizacion,
                          @w_valor_amor_27 = @w_cuota,
                          @w_tipo_amor_27  = @w_tipo_cuota

                if @w_contador = 28
	           SELECT @w_fecha_amor_28 = @w_fecha_amortizacion,
                          @w_valor_amor_28 = @w_cuota,
                          @w_tipo_amor_28  = @w_tipo_cuota

                if @w_contador = 29
	           SELECT @w_fecha_amor_29 = @w_fecha_amortizacion,
                          @w_valor_amor_29 = @w_cuota,
                          @w_tipo_amor_29  = @w_tipo_cuota


                if @w_contador = 30
	           SELECT @w_fecha_amor_30 = @w_fecha_amortizacion,
                          @w_valor_amor_30 = @w_cuota,
                          @w_tipo_amor_30  = @w_tipo_cuota

                if @w_contador = 31
	           SELECT @w_fecha_amor_31 = @w_fecha_amortizacion,
                          @w_valor_amor_31 = @w_cuota,
                          @w_tipo_amor_31  = @w_tipo_cuota

                if @w_contador = 32
	           SELECT @w_fecha_amor_32 = @w_fecha_amortizacion,
                          @w_valor_amor_32 = @w_cuota,
                          @w_tipo_amor_32  = @w_tipo_cuota

                if @w_contador = 33
	           SELECT @w_fecha_amor_33 = @w_fecha_amortizacion,
                          @w_valor_amor_33 = @w_cuota,
                          @w_tipo_amor_33  = @w_tipo_cuota

                if @w_contador = 34
	           SELECT @w_fecha_amor_34 = @w_fecha_amortizacion,
                          @w_valor_amor_34 = @w_cuota,
                          @w_tipo_amor_34  = @w_tipo_cuota

               if @w_contador = 35
	           SELECT @w_fecha_amor_35 = @w_fecha_amortizacion,
                          @w_valor_amor_35 = @w_cuota,
                          @w_tipo_amor_35  = @w_tipo_cuota

                if @w_contador = 36
	           SELECT @w_fecha_amor_36 = @w_fecha_amortizacion,
                          @w_valor_amor_36 = @w_cuota,
                          @w_tipo_amor_36  = @w_tipo_cuota

                if @w_contador = 37
	           SELECT @w_fecha_amor_37 = @w_fecha_amortizacion,
                          @w_valor_amor_37 = @w_cuota,
                          @w_tipo_amor_37  = @w_tipo_cuota

                if @w_contador = 38
	           SELECT @w_fecha_amor_38 = @w_fecha_amortizacion,
                          @w_valor_amor_38 = @w_cuota,
                          @w_tipo_amor_38  = @w_tipo_cuota

                if @w_contador = 39
	           SELECT @w_fecha_amor_39 = @w_fecha_amortizacion,
                          @w_valor_amor_39 = @w_cuota,
                          @w_tipo_amor_39  = @w_tipo_cuota


                if @w_contador = 40
	           SELECT @w_fecha_amor_40 = @w_fecha_amortizacion,
                          @w_valor_amor_40 = @w_cuota,
                          @w_tipo_amor_40  = @w_tipo_cuota

                if @w_contador = 41
	           SELECT @w_fecha_amor_41 = @w_fecha_amortizacion,
                          @w_valor_amor_41 = @w_cuota,
                          @w_tipo_amor_41  = @w_tipo_cuota

                if @w_contador = 42
	           SELECT @w_fecha_amor_42 = @w_fecha_amortizacion,
                          @w_valor_amor_42 = @w_cuota,
                          @w_tipo_amor_42  = @w_tipo_cuota

                if @w_contador = 43
	           SELECT @w_fecha_amor_43 = @w_fecha_amortizacion,
                          @w_valor_amor_43 = @w_cuota,
                          @w_tipo_amor_43  = @w_tipo_cuota

                if @w_contador = 44
	           SELECT @w_fecha_amor_44 = @w_fecha_amortizacion,
                          @w_valor_amor_44 = @w_cuota,
                          @w_tipo_amor_44  = @w_tipo_cuota

               if @w_contador = 45
	           SELECT @w_fecha_amor_45 = @w_fecha_amortizacion,
                          @w_valor_amor_45 = @w_cuota,
                          @w_tipo_amor_45  = @w_tipo_cuota

                if @w_contador = 46
	           SELECT @w_fecha_amor_46 = @w_fecha_amortizacion,
                          @w_valor_amor_46 = @w_cuota,
                          @w_tipo_amor_46  = @w_tipo_cuota

                if @w_contador = 47
	           SELECT @w_fecha_amor_47 = @w_fecha_amortizacion,
                          @w_valor_amor_47 = @w_cuota,
                          @w_tipo_amor_47  = @w_tipo_cuota

                if @w_contador = 48
	           SELECT @w_fecha_amor_48 = @w_fecha_amortizacion,
                          @w_valor_amor_48 = @w_cuota,
                          @w_tipo_amor_48  = @w_tipo_cuota

                if @w_contador = 49
	           SELECT @w_fecha_amor_49 = @w_fecha_amortizacion,
                          @w_valor_amor_49 = @w_cuota,
                          @w_tipo_amor_49  = @w_tipo_cuota

               if @w_contador = 50
	           SELECT @w_fecha_amor_50 = @w_fecha_amortizacion,
                          @w_valor_amor_50 = @w_cuota,
                          @w_tipo_amor_50  = @w_tipo_cuota

                if @w_contador = 51
	           SELECT @w_fecha_amor_51 = @w_fecha_amortizacion,
                          @w_valor_amor_51 = @w_cuota,
                          @w_tipo_amor_51  = @w_tipo_cuota

                if @w_contador = 52
	           SELECT @w_fecha_amor_52 = @w_fecha_amortizacion,
                          @w_valor_amor_52 = @w_cuota,
                          @w_tipo_amor_52  = @w_tipo_cuota

                if @w_contador = 53
	           SELECT @w_fecha_amor_53 = @w_fecha_amortizacion,
                          @w_valor_amor_53 = @w_cuota,
                          @w_tipo_amor_53  = @w_tipo_cuota

                if @w_contador = 54
	           SELECT @w_fecha_amor_54 = @w_fecha_amortizacion,
                          @w_valor_amor_54 = @w_cuota,
                          @w_tipo_amor_54  = @w_tipo_cuota

               if @w_contador = 55
	           SELECT @w_fecha_amor_55 = @w_fecha_amortizacion,
                          @w_valor_amor_55 = @w_cuota,
                          @w_tipo_amor_55  = @w_tipo_cuota

                if @w_contador = 56
	           SELECT @w_fecha_amor_56 = @w_fecha_amortizacion,
                          @w_valor_amor_56 = @w_cuota,
                          @w_tipo_amor_56  = @w_tipo_cuota

                if @w_contador = 57
	           SELECT @w_fecha_amor_57 = @w_fecha_amortizacion,
                          @w_valor_amor_57 = @w_cuota,
                          @w_tipo_amor_57  = @w_tipo_cuota

                if @w_contador = 58
	           SELECT @w_fecha_amor_58 = @w_fecha_amortizacion,
                          @w_valor_amor_58 = @w_cuota,
                          @w_tipo_amor_58  = @w_tipo_cuota

                if @w_contador = 59
	           SELECT @w_fecha_amor_59 = @w_fecha_amortizacion,
                          @w_valor_amor_59 = @w_cuota,
                          @w_tipo_amor_59  = @w_tipo_cuota

               if @w_contador = 60
	           SELECT @w_fecha_amor_60 = @w_fecha_amortizacion,
                          @w_valor_amor_60 = @w_cuota,
                          @w_tipo_amor_60  = @w_tipo_cuota


                FETCH cursor_dividendos INTO @w_dividendo,  @w_fecha_amortizacion, @w_cuota, @w_tipo_cuota

            END -- while
            CLOSE cursor_dividendos
            deallocate cursor_dividendos

        END -- plan variable


        /***********************/
        /*** DATOS DE RUBROS ***/
        /***********************/

        SELECT @w_contador = 1

        DECLARE cursor_destino CURSOR FOR
        select dt_destino, dt_unidad, dt_costo, dt_valor, dt_rol
        FROM cr_destino_tramite
        WHERE dt_tramite = @w_tramite_activa
        for read only

        OPEN cursor_destino
        FETCH cursor_destino into @w_destino_t, @w_unidad_t, @w_costo_t, @w_valor_t, @w_rol_t

        while @@fetch_status = 0
        BEGIN
           if (@@fetch_status = -1)
           BEGIN
                 /* Error en recuperacion de Datos del Cursor */
                 SELECT @w_return = 2101015

                 exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = @w_return,
                    @i_msg   = 'Error Recuperar Datos Cursor cursor_destino'

                 return @w_return
            END

           if @w_rol_t = 'S'
              SELECT @w_cod_rubro_ppal = @w_destino_t,
                     @w_cant_unid_finan_ppal = @w_unidad_t,
                     @w_costo_inv_rubro_ppal = @w_costo_t,
                     @w_valor_fin_rubro_ppal = @w_valor_t

           if @w_rol_t != 'S'
           BEGIN
              SELECT @w_contador = @w_contador + 1
              if @w_contador = 2
                 SELECT @w_cod_rubro_2 = @w_destino_t,
                        @w_cant_unid_finan_2 = @w_unidad_t,
                        @w_costo_inv_rubro_2 = @w_costo_t,
                        @w_valor_fin_rubro_2 = @w_valor_t
              if @w_contador = 3
                 SELECT @w_cod_rubro_3 = @w_destino_t,
                        @w_cant_unid_finan_3 = @w_unidad_t,
                        @w_costo_inv_rubro_3 = @w_costo_t,
                        @w_valor_fin_rubro_3 = @w_valor_t
              if @w_contador = 4
                 SELECT @w_cod_rubro_4 = @w_destino_t,
                        @w_cant_unid_finan_4 = @w_unidad_t,
                        @w_costo_inv_rubro_4 = @w_costo_t,
                        @w_valor_fin_rubro_4 = @w_valor_t
              if @w_contador = 5
                 SELECT @w_cod_rubro_5 = @w_destino_t,
                        @w_cant_unid_finan_5 = @w_unidad_t,
                        @w_costo_inv_rubro_5 = @w_costo_t,
                        @w_valor_fin_rubro_5 = @w_valor_t
           end
           FETCH cursor_destino into @w_destino_t, @w_unidad_t, @w_costo_t, @w_valor_t, @w_rol_t
        end
        close cursor_destino
        deallocate cursor_destino


        /*** FIN CAPTURA DE DATOS ***/
        /****************************/

   BEGIN TRAN

      /* Limpia Datos si Existieran */
      if @i_tramite is not null
      BEGIN
          if exists (SELECT 1 FROM cr_archivo_redescuento
                     WHERE re_tramite = @i_tramite)
          BEGIN
              /* Borrar Redescuento */
              SELECT @w_num_operacion = re_operacion
              FROM cr_archivo_redescuento
              WHERE re_tramite = @i_tramite

              exec @w_return = sp_archivo_redescuento
                   @t_trn           = 21780,
                   @i_operacion     = 'D',
                   @i_num_operacion = @w_num_operacion

              if @w_return != 0
              BEGIN
                 exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = @w_return,
                    @i_msg   = 'Error al eliminar Archivo de Redescuento'
                 rollback tran
                 return @w_return
              END


              /* borra registro redescuento en cartera si existiese */
              exec  @w_return = cob_cartera..sp_redescuento
                    @s_user      = @s_user,
                    @s_date      = @s_date,
                    @s_ofi       = @s_ofi,
                    @s_term      = @s_term,
                    @i_operacion = 'D',              --'D' : Delete
                    @i_pasiva    = @w_banco_pasiva,  -- op_banco de la pasiva
                    @i_activa    = @w_banco_activa,  -- op_banco de la activa
                    @i_moneda    = @w_moneda,        -- moneda de la operacion
                    @i_tipo_op   = 'C',
                    @i_hereda    = 'N',
                    @i_credito   = 'S'

              if @w_return != 0
              BEGIN
                 exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = @w_return,
                    @i_msg   = 'Error al eliminar Archivo de Redescuento en Cartera'
                 return @w_return
              END

           END


            print 'Creando Archivo Redescuento.......... '

            /* INSERCION EN ARCHIVO REDESCUENTOS */
            /*************************************/
                select @w_ruta_fag = pa_int
                from cobis..cl_parametro
                where pa_producto = 'CRE'
                and pa_nemonico = 'CODPAG'

                select @w_etapa_fag = pa_tinyint
                from cobis..cl_parametro
                where pa_producto = 'CRE'
                and pa_nemonico = 'ETRFAG'

                select @w_tipo_esp = pa_char
                from cobis..cl_parametro
                where pa_producto = 'GAR'
                and pa_nemonico = 'FAG'

                Select @w_recfag = pa_char
                from cobis..cl_parametro
                where pa_producto = 'GAR'
                and pa_nemonico = 'COMISI'


                /* BORRADO Y LLENADO DE LA TABLAcr_tipos_fng_temp */
                delete cr_tipos_fag_ftemp
                insert into cr_tipos_fag_ftemp
                select 	@w_pid_asig, tc_tipo
                from 	cob_custodia..cu_tipo_custodia
                where 	tc_tipo 		= @w_tipo_esp
                union
                select 	@w_pid_asig,tc_tipo
                from 	cob_custodia..cu_tipo_custodia
                where 	tc_tipo_superior 	= @w_tipo_esp
                union
                select 	@w_pid_asig,tc_tipo
                from 	cob_custodia..cu_tipo_custodia
                where 	tc_tipo_superior in (select 	tc_tipo
                			      from cob_custodia..cu_tipo_custodia
                			      Where tc_tipo_superior = @w_tipo_esp)



                select  @w_ncofag       = count(1)
                from    cob_cartera..ca_rubro_op
                where   ro_operacion    = @w_operacion_activa
                and     ro_concepto     = @w_recfag
                and     ro_fpago        = 'L'

                if @w_ncofag > 0
                   select @w_cofag = 'U'
                else
                   select @w_cofag = 'A'

                select @w_porcentaje = gp_porcentaje
                from   cob_credito..cr_gar_propuesta,
                       cob_custodia..cu_custodia
                where  gp_tramite    = @w_tramite_activa
                and    cu_codigo_externo = gp_garantia
                and    cu_tipo in (  select  tipo
        			                 from    cr_tipos_fag_ftemp
                                     where   sesion = @w_pid_asig)
                and    cu_estado in ('P','V','F','X')

                select @w_porcentaje = isnull(@w_porcentaje,0)

                if @w_porcentaje <> 0
                    begin
                       select @w_fag = 'S'
                    end
                else
                    begin
                        select @w_fag   = 'N',
                               @w_cofag = ''

                    end

            select
                  @w_fact_ben_1 = en_fecha_patri_bruto,
                  @w_pas_fin    = en_pas_finan,
                  @w_fpas_fin_1 = en_fpas_finan
            FROM  cob_credito..cr_tramite,
                  cobis..cl_ente
            WHERE tr_tramite   = @i_tramite
            and   tr_cliente   = en_ente

            -- Las obligaciones con plazo menor a 24 meses 
            -- no se reportan con periodo de gracia.

            if @w_plazo <= 24
            begin
               select @w_periodo_gracia = 0
            end

            /* Creando Datos Principales */
            /*****************************/
       	    exec @w_return = cob_credito..sp_archivo_redescuento
    	   	  	@s_ssn                     = @s_ssn,
	          	@s_sesn                    = @s_sesn,
	          	@s_user                    = @s_user,
	          	@s_term                    = @s_term,
	          	@s_date                    = @s_date,
	          	@s_srv                     = @s_srv,
	          	@s_lsrv                    = @s_srv,
	          	@s_ofi                     = @w_oficina_oper,
	          	@t_trn                	   = 21778,
	          	@i_operacion          	   = 'I',
		        @i_tramite                 = @w_tramite,
		        @i_num_operacion           = @w_banco,
		        @i_fecha_envio		   = @s_date,
		        @i_cliente		   = @w_cliente,
		        @i_estado_reg              = 'T',
		        @i_llave_redescuento       = @w_llave_redes,
		        @i_num_finagro             = @w_num_finagro,
		        @i_cod_entidad	           = @w_cod_entidad,
		        @i_toperacion	           = @w_norma_legal,
		        @i_num_pagare	           = @w_num_pagare,
		        @i_fecha_suscripcion	   = @w_fecha_redes,
		        @i_fecha_redes	           = @w_fecha_redes,
		        @i_rubro_economico	   = @w_rubro_economico,
		        @i_ciudad_inversion	   = @w_ciudad_inversion,
		        @i_nit_deudor    	   = '0',
		        @i_ide_ben_1               = @w_ide_ben_1,
		        @i_doc_ben_1		   = @w_doc_ben_1,
		        @i_nom_ben_1               = @w_nom_ben_1,
		        @i_tip_ben_1		   = @w_tip_ben_1,
		        @i_sub_ben_1		   = @w_sub_ben_1,
		        @i_act_ben_1               = @w_act_ben_1,
		        @i_dir_ben_1		   = @w_dir_ben_1,
		        @i_tel_ben_1               = @w_tel_ben_1,
		        @i_ide_ben_2               = @w_ide_ben_2,
		        @i_doc_ben_2		   = @w_doc_ben_2,
		        @i_nom_ben_2               = @w_nom_ben_2,
		        @i_tip_ben_2		   = @w_tip_ben_2,
		        @i_sub_ben_2		   = @w_sub_ben_2,
		        @i_act_ben_2               = @w_act_ben_2,
		        @i_dir_ben_2		   = @w_dir_ben_2,
		        @i_tel_ben_2               = @w_tel_ben_2,
		        @i_ide_ben_3               = @w_ide_ben_3,
		        @i_doc_ben_3		   = @w_doc_ben_3,
		        @i_nom_ben_3               = @w_nom_ben_3,
		        @i_tip_ben_3		   = @w_tip_ben_3,
		        @i_sub_ben_3		   = @w_sub_ben_3,
		        @i_act_ben_3               = @w_act_ben_3,
		        @i_dir_ben_3		   = @w_dir_ben_3,
		        @i_tel_ben_3               = @w_tel_ben_3,
		        @i_ide_ben_4               = @w_ide_ben_4,
		        @i_doc_ben_4		   = @w_doc_ben_4,
		        @i_nom_ben_4               = @w_nom_ben_4,
		        @i_tip_ben_4		   = @w_tip_ben_4,
		        @i_sub_ben_4		   = @w_sub_ben_4,
		        @i_act_ben_4               = @w_act_ben_4,
		        @i_dir_ben_4		   = @w_dir_ben_4,
		        @i_tel_ben_4               = @w_tel_ben_4,
		        -- MLO @i_acta		           = @w_acta,
		        @i_codigo_ciiu	           = @w_codigo_ciiu,
		        @i_oficina		   = @w_oficina_oper,
		        @i_nom_oficina	           = @w_nom_oficina,
		        @i_ofi_pagare              = @w_parametro_of_pag,
		        @i_nom_oficina_pagare      = @w_parametro_nom_pag,
		        @i_cod_aseguradora         = @w_cod_aseguradora,
		        @i_cod_poliza              = @w_cod_poliza,
		        @i_cob_poliza	           = @w_cob_poliza,
		        @i_fecha_vig_poliza	   = @w_fecha_vig_poliza,
		        @i_cod_almacenadora	   = @w_cod_almacenadora,
		        @i_nom_almacenadora	   = @w_nom_almacenera,
		        @i_cant_unidades           = @w_cant_unidades,
		        @i_valor_x_unidad	   = @w_valor_x_unidad,
		        @i_valor_total	           = @w_valor_total,
		        @i_sist_almacenamiento     = @w_sist_almacenamiento,
		        @i_num_cdm		   = @w_num_cdm,
		        @i_tipo_tenencia	   = @w_tipo_tenencia,
		        @i_cod_mun_almacen	   = @w_cod_mun_almacen,
		        @i_dir_almacen	           = @w_dir_almacen,
		        @i_margen_red_gar	   = @w_margen_red_gar,
		        @i_tipo_plan               = @w_tipo_plan,
		        @i_tipo_tasa               = @w_tipo_tasa,
		        @i_plazo		   = @w_plazo,
		        @i_fecha_vto_ini	   = @w_fecha_vto_ini,
		        @i_fecha_vto_fin	   = @w_fecha_vto_fin,
		        @i_frec_cap                = @w_periodo_cap,
		        @i_abonos_cap	           = @w_abonos_cap,
		        @i_periodo_gracia	   = @w_periodo_gracia,
		        @i_frec_int	           = @w_periodo_int,
		        @i_abonos_int	           = @w_abonos_int,
		        @i_porc_cap_1 	           = @w_porc_cap_1,
		        @i_fecha_hasta_cap	   = @w_fecha_hasta_cap,
		        @i_porc_cap_2     	   = @w_porc_cap_2,
		        @i_margen_redescuento      = @w_margen_redescuento,
		        @i_capital		   = @w_capital,
		        @i_puntos_tasa             = @w_puntos_tasa,
                @i_valor_redescuento       = @w_valor_redescuento,
                @i_num_deudores            = @w_num_deudores,
                @i_revisado                = 'N',
                @i_porcentaje_fag          = @w_porcentaje,
                @i_fag                     = @w_fag,
                @i_tcom_fag                = @w_cofag,
                @i_fact_ben_1              = @w_fact_ben_1,
                @i_pas_fin                 = @w_pas_fin,
                @i_fpas_fin_1              = @w_fpas_fin_1,
                @i_num_desemb              = @w_num_desemb,
                @i_tnum_desemb             = @w_tnum_desemb



                if @w_return != 0
                BEGIN
                   print 'Error en Creacion tramite en Archivo Redescuento'

                   exec cobis..sp_cerror
                      @t_debug = @t_debug,
                      @t_file  = @t_file,
                      @t_from  = @w_sp_name,
                      @i_num   = @w_return,
                      @i_msg   = 'Error en Creacion tramite en Archivo Redescuento'
                   return @w_return
                END




                /* Creando Tabla de Amortizacion */
                /*********************************/
          	exec @w_return = cob_credito..sp_archivo_redescuento_PA
	   	  	@s_ssn                     = @s_ssn,
	          	@s_sesn                    = @s_sesn,
	          	@s_user                    = @s_user,
	          	@s_term                    = @s_term,
	          	@s_date                    = @s_date,
	          	@s_srv                     = @s_srv,
	          	@s_lsrv                    = @s_srv,
	          	@s_ofi                     = @w_oficina_oper,
	          	@t_trn                	   = 22000,
	          	@i_operacion          	   = 'I',
		        @i_tramite                 = @w_tramite,
		        @i_num_operacion           = @w_banco,
		        @i_fecha_envio		   = @s_date,
		        @i_cliente		   = @w_cliente,
			@i_cuota_desde_1           =  @w_cuota_desde_1,
		        @i_cuota_hasta_1	        =  @w_cuota_hasta_1,
		        @i_valor_cuota_1		=  @w_valor_cuota_1,
		        @i_cuota_desde_2		=  @w_cuota_desde_2,
		        @i_cuota_hasta_2		=  @w_cuota_hasta_2,
		        @i_valor_cuota_2		=  @w_valor_cuota_2,
		        @i_cuota_desde_3		=  @w_cuota_desde_3,
		        @i_cuota_hasta_3		=  @w_cuota_hasta_3,
		        @i_valor_cuota_3		=  @w_valor_cuota_3,
		        @i_cuota_desde_4		=  @w_cuota_desde_4,
		        @i_cuota_hasta_4		=  @w_cuota_hasta_4,
		        @i_valor_cuota_4		=  @w_valor_cuota_4,
		        @i_cuota_desde_5		=  @w_cuota_desde_5,
		        @i_cuota_hasta_5		=  @w_cuota_hasta_5,
		        @i_valor_cuota_5		=  @w_valor_cuota_5,
		        @i_cuota_desde_6		=  @w_cuota_desde_6,
		        @i_cuota_hasta_6		=  @w_cuota_hasta_6,
		        @i_valor_cuota_6		=  @w_valor_cuota_6,
		        @i_cuota_desde_7		=  @w_cuota_desde_7,
		        @i_cuota_hasta_7		=  @w_cuota_hasta_7,
		        @i_valor_cuota_7		=  @w_valor_cuota_7,
		        @i_cuota_desde_8		=  @w_cuota_desde_8,
		        @i_cuota_hasta_8		=  @w_cuota_hasta_8,
		        @i_valor_cuota_8		=  @w_valor_cuota_8,
		        @i_cuota_desde_9		=  @w_cuota_desde_9,
		        @i_cuota_hasta_9		=  @w_cuota_hasta_9,
		        @i_valor_cuota_9		=  @w_valor_cuota_9,
		        @i_cuota_desde_10		=  @w_cuota_desde_10,
		        @i_cuota_hasta_10		=  @w_cuota_hasta_10,
		        @i_valor_cuota_10		=  @w_valor_cuota_10,
		        @i_fecha_amor_1		        =  @w_fecha_amor_1,
		        @i_valor_amor_1		        = @w_valor_amor_1,
		        @i_tipo_amor_1		        = @w_tipo_amor_1,
		        @i_fecha_amor_2		        = @w_fecha_amor_2,
		        @i_valor_amor_2		        = @w_valor_amor_2,
		        @i_tipo_amor_2		        = @w_tipo_amor_2,
		        @i_fecha_amor_3		        = @w_fecha_amor_3,
		        @i_valor_amor_3		        = @w_valor_amor_3,
		        @i_tipo_amor_3		        = @w_tipo_amor_3	,
		        @i_fecha_amor_4		        = @w_fecha_amor_4,
		        @i_valor_amor_4		        = @w_valor_amor_4,
		        @i_tipo_amor_4		        = @w_tipo_amor_4	,
		        @i_fecha_amor_5		        = @w_fecha_amor_5,
		        @i_valor_amor_5		        = @w_valor_amor_5,
		        @i_tipo_amor_5		        = @w_tipo_amor_5	,
		        @i_fecha_amor_6		        = @w_fecha_amor_6,
		        @i_valor_amor_6		        = @w_valor_amor_6,
		        @i_tipo_amor_6		        = @w_tipo_amor_6	,
		        @i_fecha_amor_7		        = @w_fecha_amor_7,
		        @i_valor_amor_7		        = @w_valor_amor_7,
		        @i_tipo_amor_7		        = @w_tipo_amor_7	,
		        @i_fecha_amor_8		        = @w_fecha_amor_8,
		        @i_valor_amor_8		        = @w_valor_amor_8,
		        @i_tipo_amor_8		        = @w_tipo_amor_8	,
		        @i_fecha_amor_9		        = @w_fecha_amor_9,
		        @i_valor_amor_9		        = @w_valor_amor_9,
		        @i_tipo_amor_9		        = @w_tipo_amor_9	,
		        @i_fecha_amor_10		= @w_fecha_amor_10,
		        @i_valor_amor_10		=  @w_valor_amor_10,
		        @i_tipo_amor_10		        =  @w_tipo_amor_10,
		        @i_fecha_amor_11		= @w_fecha_amor_11,
		        @i_valor_amor_11		=  @w_valor_amor_11,
		        @i_tipo_amor_11		        =  @w_tipo_amor_11,
		        @i_fecha_amor_12		= @w_fecha_amor_12,
		        @i_valor_amor_12		=  @w_valor_amor_12,
		        @i_tipo_amor_12		        =  @w_tipo_amor_12,
		        @i_fecha_amor_13		= @w_fecha_amor_13,
		        @i_valor_amor_13		=  @w_valor_amor_13,
		        @i_tipo_amor_13		        =  @w_tipo_amor_13,
		        @i_fecha_amor_14		= @w_fecha_amor_14,
		        @i_valor_amor_14		=  @w_valor_amor_14,
		        @i_tipo_amor_14		        =  @w_tipo_amor_14,
		        @i_fecha_amor_15		= @w_fecha_amor_15,
		        @i_valor_amor_15		=  @w_valor_amor_15,
		        @i_tipo_amor_15		        =  @w_tipo_amor_15,
		        @i_fecha_amor_16		= @w_fecha_amor_16,
			@i_valor_amor_16		=  @w_valor_amor_16,
		        @i_tipo_amor_16		        =  @w_tipo_amor_16,
		        @i_fecha_amor_17		= @w_fecha_amor_17,
		        @i_valor_amor_17		=  @w_valor_amor_17,
		        @i_tipo_amor_17		        =  @w_tipo_amor_17,
		        @i_fecha_amor_18		= @w_fecha_amor_18,
		        @i_valor_amor_18		=  @w_valor_amor_18,
		        @i_tipo_amor_18		        =  @w_tipo_amor_18,
		        @i_fecha_amor_19		= @w_fecha_amor_19,
		        @i_valor_amor_19		=  @w_valor_amor_19,
		        @i_tipo_amor_19		        =  @w_tipo_amor_19,
		        @i_fecha_amor_20		= @w_fecha_amor_20,
		        @i_valor_amor_20		=  @w_valor_amor_20,
		        @i_tipo_amor_20		        =  @w_tipo_amor_20,
		        @i_fecha_amor_21		= @w_fecha_amor_21,
		        @i_valor_amor_21		=  @w_valor_amor_21,
		        @i_tipo_amor_21		        =  @w_tipo_amor_21,
		        @i_fecha_amor_22		= @w_fecha_amor_22,
		        @i_valor_amor_22		=  @w_valor_amor_22,
		        @i_tipo_amor_22		        =  @w_tipo_amor_22,
		        @i_fecha_amor_23		= @w_fecha_amor_23,
		        @i_valor_amor_23		=  @w_valor_amor_23,
		        @i_tipo_amor_23		        =  @w_tipo_amor_23,
		        @i_fecha_amor_24		= @w_fecha_amor_24,
		        @i_valor_amor_24		=  @w_valor_amor_24,
		        @i_tipo_amor_24		        =  @w_tipo_amor_24,
		        @i_fecha_amor_25		= @w_fecha_amor_25,
		        @i_valor_amor_25		=  @w_valor_amor_25,
		        @i_tipo_amor_25		        =  @w_tipo_amor_25,
		        @i_fecha_amor_26		= @w_fecha_amor_26,
		        @i_valor_amor_26		=  @w_valor_amor_26,
		        @i_tipo_amor_26		        =  @w_tipo_amor_26,
		        @i_fecha_amor_27		= @w_fecha_amor_27,
		        @i_valor_amor_27		=  @w_valor_amor_27,
		        @i_tipo_amor_27		        =  @w_tipo_amor_27,
		        @i_fecha_amor_28		= @w_fecha_amor_28,
		        @i_valor_amor_28		=  @w_valor_amor_28,
		        @i_tipo_amor_28		        =  @w_tipo_amor_28,
		        @i_fecha_amor_29		= @w_fecha_amor_29,
		        @i_valor_amor_29		=  @w_valor_amor_29,
		        @i_tipo_amor_29		        =  @w_tipo_amor_29,
		        @i_fecha_amor_30		= @w_fecha_amor_30,
		        @i_valor_amor_30		=  @w_valor_amor_30,
		        @i_tipo_amor_30		        =  @w_tipo_amor_30,
		        @i_fecha_amor_31		= @w_fecha_amor_31,
		        @i_valor_amor_31		=  @w_valor_amor_31,
		        @i_tipo_amor_31		        =  @w_tipo_amor_31,
		        @i_fecha_amor_32		= @w_fecha_amor_32,
		        @i_valor_amor_32		=  @w_valor_amor_32,
		        @i_tipo_amor_32		        =  @w_tipo_amor_32,
		        @i_fecha_amor_33		= @w_fecha_amor_33,
		        @i_valor_amor_33		=  @w_valor_amor_33,
		        @i_tipo_amor_33		        =  @w_tipo_amor_33,
		        @i_fecha_amor_34		= @w_fecha_amor_34,
		        @i_valor_amor_34		=  @w_valor_amor_34,
		        @i_tipo_amor_34		        =  @w_tipo_amor_34,
		        @i_fecha_amor_35		= @w_fecha_amor_35,
		        @i_valor_amor_35		=  @w_valor_amor_35,
		        @i_tipo_amor_35		        =  @w_tipo_amor_35,
		        @i_fecha_amor_36		= @w_fecha_amor_36,
		        @i_valor_amor_36		=  @w_valor_amor_36,
		        @i_tipo_amor_36		        =  @w_tipo_amor_36,
		        @i_fecha_amor_37		= @w_fecha_amor_37,
		        @i_valor_amor_37		=  @w_valor_amor_37,
		        @i_tipo_amor_37		        =  @w_tipo_amor_37,
		        @i_fecha_amor_38		= @w_fecha_amor_38,
		        @i_valor_amor_38		=  @w_valor_amor_38,
		        @i_tipo_amor_38		        =  @w_tipo_amor_38,
		        @i_fecha_amor_39		= @w_fecha_amor_39,
		        @i_valor_amor_39		=  @w_valor_amor_39,
		        @i_tipo_amor_39		        =  @w_tipo_amor_39,
		        @i_fecha_amor_40		= @w_fecha_amor_40,
		        @i_valor_amor_40		=  @w_valor_amor_40,
		        @i_tipo_amor_40		        =  @w_tipo_amor_40,
		        @i_fecha_amor_41		= @w_fecha_amor_41,
		        @i_valor_amor_41		=  @w_valor_amor_41,
		        @i_tipo_amor_41		        =  @w_tipo_amor_41,
		        @i_fecha_amor_42		= @w_fecha_amor_42,
		        @i_valor_amor_42		=  @w_valor_amor_42,
		        @i_tipo_amor_42		        =  @w_tipo_amor_42,
		        @i_fecha_amor_43		= @w_fecha_amor_43,
		        @i_valor_amor_43		= @w_valor_amor_43,
		        @i_tipo_amor_43		        = @w_tipo_amor_43,
		        @i_fecha_amor_44		= @w_fecha_amor_44,
		        @i_valor_amor_44		= @w_valor_amor_44,
		        @i_tipo_amor_44		        = @w_tipo_amor_44,
		        @i_fecha_amor_45		= @w_fecha_amor_45,
		        @i_valor_amor_45		= @w_valor_amor_45,
		        @i_tipo_amor_45		        = @w_tipo_amor_45,
		        @i_fecha_amor_46		= @w_fecha_amor_46,
		        @i_valor_amor_46		= @w_valor_amor_46,
		        @i_tipo_amor_46		        = @w_tipo_amor_46,
		        @i_fecha_amor_47		= @w_fecha_amor_47,
		        @i_valor_amor_47		= @w_valor_amor_47,
		        @i_tipo_amor_47		        = @w_tipo_amor_47,
		        @i_fecha_amor_48		= @w_fecha_amor_48,
		        @i_valor_amor_48		= @w_valor_amor_48,
		        @i_tipo_amor_48		        = @w_tipo_amor_48,
		        @i_fecha_amor_49		= @w_fecha_amor_49,
		        @i_valor_amor_49		= @w_valor_amor_49,
		        @i_tipo_amor_49		        = @w_tipo_amor_49,
		        @i_fecha_amor_50		= @w_fecha_amor_50,
		        @i_valor_amor_50		= @w_valor_amor_50,
		        @i_tipo_amor_50		        = @w_tipo_amor_50,
		        @i_fecha_amor_51		= @w_fecha_amor_51,
		        @i_valor_amor_51		= @w_valor_amor_51,
		        @i_tipo_amor_51		        = @w_tipo_amor_51,
		        @i_fecha_amor_52		= @w_fecha_amor_52,
		        @i_valor_amor_52		= @w_valor_amor_52,
		        @i_tipo_amor_52		        = @w_tipo_amor_52,
		        @i_fecha_amor_53		= @w_fecha_amor_53,
		        @i_valor_amor_53		= @w_valor_amor_53,
		        @i_tipo_amor_53		        = @w_tipo_amor_53,
		        @i_fecha_amor_54		= @w_fecha_amor_54,
		        @i_valor_amor_54		= @w_valor_amor_54,
		        @i_tipo_amor_54		        = @w_tipo_amor_54,
		        @i_fecha_amor_55		= @w_fecha_amor_55,
		        @i_valor_amor_55		= @w_valor_amor_55,
		        @i_tipo_amor_55		        = @w_tipo_amor_55,
		        @i_fecha_amor_56		= @w_fecha_amor_56,
		        @i_valor_amor_56		= @w_valor_amor_56,
		        @i_tipo_amor_56		        = @w_tipo_amor_56,
		        @i_fecha_amor_57		= @w_fecha_amor_57,
		        @i_valor_amor_57		= @w_valor_amor_57,
		        @i_tipo_amor_57		        = @w_tipo_amor_57,
		        @i_fecha_amor_58		= @w_fecha_amor_58,
		        @i_valor_amor_58		= @w_valor_amor_58,
		        @i_tipo_amor_58		        = @w_tipo_amor_58,
		        @i_fecha_amor_59		= @w_fecha_amor_59,
		        @i_valor_amor_59		= @w_valor_amor_59,
		        @i_tipo_amor_59		        = @w_tipo_amor_59,
		        @i_fecha_amor_60		= @w_fecha_amor_60,
		        @i_valor_amor_60		= @w_valor_amor_60,
		        @i_tipo_amor_60		        = @w_tipo_amor_60,
		        @i_cod_rubro_ppal		= @w_cod_rubro_ppal,
		        @i_cant_unid_finan_ppal	        = @w_cant_unid_finan_ppal,
		        @i_costo_inv_rubro_ppal	        = @w_costo_inv_rubro_ppal,
		        @i_valor_fin_rubro_ppal	        = @w_valor_fin_rubro_ppal,
		        @i_cod_rubro_2		        = @w_cod_rubro_2,
		        @i_cant_unid_finan_2	        = @w_cant_unid_finan_2,
		        @i_costo_inv_rubro_2	        = @w_costo_inv_rubro_2,
		        @i_valor_fin_rubro_2	        = @w_valor_fin_rubro_2,
		        @i_cod_rubro_3		        = @w_cod_rubro_3	,
		        @i_cant_unid_finan_3	        = @w_cant_unid_finan_3,
		        @i_costo_inv_rubro_3	        = @w_costo_inv_rubro_3,
		        @i_valor_fin_rubro_3	        = @w_valor_fin_rubro_3,
		        @i_cod_rubro_4		        = @w_cod_rubro_4,
		        @i_cant_unid_finan_4	        = @w_cant_unid_finan_4,
		        @i_costo_inv_rubro_4	        = @w_costo_inv_rubro_4,
		        @i_valor_fin_rubro_4	        = @w_valor_fin_rubro_4,
		        @i_cod_rubro_5		        = @w_cod_rubro_5	,
		        @i_cant_unid_finan_5	        = @w_cant_unid_finan_5,
		        @i_costo_inv_rubro_5	        = @w_costo_inv_rubro_5,
		        @i_valor_fin_rubro_5	        = @w_valor_fin_rubro_5,
                        @i_codesamo                     = 0,
                        @i_covalgir                     = 0,
                        @i_copermue                     = 0


                if @w_return != 0
                BEGIN
                   print 'Error en Creacion tramite en Archivo Redescuento Plan Amortizacion'

                   exec cobis..sp_cerror
                      @t_debug = @t_debug,
                      @t_file  = @t_file,
                      @t_from  = @w_sp_name,
                      @i_num   = @w_return,
                      @i_msg   = 'Error en Creacion tramite en Archivo Redescuento Plan Amortizacion'
                   return @w_return
                END

            select  @w_num_res = count(1)
            from    cob_cartera..ca_transaccion,
                    cob_cartera..ca_det_trn
            where   tr_secuencial = dtr_secuencial
            and     tr_operacion  = dtr_operacion
            and     tr_tran       = 'RES'
            and     tr_estado     in ('CON','ING')
            and     tr_operacion  = @w_operacion

            select  @w_llave_redes_fin = substring (re_llave_redescuento, 1, datalength(re_llave_redescuento) - 1) + convert(char(1),@w_num_res)
            from    cr_archivo_redescuento
            where   re_tramite = @i_tramite


            update  cr_archivo_redescuento
            set     re_llave_redescuento = @w_llave_redes_fin
            where   re_tramite = @i_tramite

            update  cr_tramite
            set     tr_llave_redes  = @w_llave_redes_fin
            where   tr_tramite      = @i_tramite

            update  cob_cartera..ca_operacion
            set     op_codigo_externo   = @w_llave_redes_fin
            where   op_tramite          = @i_tramite

            select  @w_tramite_activo       = tr_tramite
            from    cob_cartera..ca_operacion, cr_tramite
            where   op_tramite              = @i_tramite
            and     op_operacion            = tr_op_redescuento

            update  cob_cartera..ca_operacion
            set     op_codigo_externo   = @w_llave_redes_fin
            where   op_tramite          = @w_tramite_activo

            update  cr_tramite
            set     tr_llave_redes  = @w_llave_redes_fin
            where   tr_tramite      = @w_tramite_activo



           COMMIT TRAN
        END
        else
        BEGIN
            print 'No Genero Archivo Redescuento'

            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 1,
                 @i_msg   = 'No Genero Archivo Redescuento'
            return @w_return
        END
END

return 0

   ERROR:
   SELECT @w_descripcion = 'CREACION DE TRAMITES' + ' ' + @w_descripcion

      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = @w_return,
           @i_msg   = @w_descripcion
      return @w_return



                                                              
                                                                                                                                                                                                                                                             
                                                                                                                                                                                                              
go
