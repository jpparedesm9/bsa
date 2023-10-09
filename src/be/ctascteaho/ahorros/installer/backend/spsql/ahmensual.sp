/************************************************************************/
/*      Archivo:                ahmensual.sp                            */
/*      Stored procedure:       sp_ahmensual                            */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas Ahorros                         */
/*      Disenado por:           M. Bayas/J. Navarrete/X. Bucheli        */
/*      Fecha de escritura:     12-Ene-1993                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza las transacciones de:                     */
/*      Devolucion IDB                                                  */
/*      Calcula interes                                                 */
/*      Capitaliza                                                      */
/*      Almacena datos para reportes varios                             */
/*      Reitengro de Gmf por alianza Cormecial -J. Colorado 04/15/2013  */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA         AUTOR           RAZON                                 */
/*  02/May/2016   Javier Calderon Migración a CEN                       */
/*  21/Jul/2016   J. Tagle        Productos que no Provisionan          */
/*  05/Ago/2016   J. Tagle        Provision Diaria por parametro PRVDIA */
/*  05/Ago/2016   J. Salazar      Cobro de Impuesto a la Renta          */
/*  24/Ago/2016   J. Tagle        Ajustes Provisión y Capitalización    */
/*  03/Sep/2016   J. Tagle        Cierre Ctas Aporte Social             */
/*  23/Sep/2016   J. Tagle        Ajustes Cuentas Contractuales         */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS on
GO

set QUOTED_IDENTIFIER on
GO

if exists (select 1
           from sysobjects
           where name = 'sp_ahmensual')
    drop proc sp_ahmensual
go

create proc sp_ahmensual
(
    @s_ssn          int         = null, 
    @s_srv          varchar(30) = null, 
    @s_lsrv         varchar(30) = null, 
    @s_user         varchar(30) = null, 
    @s_term         varchar(10) = null, 
    @s_date         datetime    = null, 
    @s_ofi          smallint    = null, 
    @s_ssn_branch   int         = null, 
    @s_org          char(1)     = 'C', 
    @t_show_version bit         = 0,
    @i_param1       varchar(10) = null,--> filial
    @i_param2       varchar(10) = null,--> fecha
    @i_param3       varchar(10) = null,--> hijo
    @i_param4       varchar(10) = null,--> nro de hijos
    @s_rol          smallint    = null,
    @i_fecha        smalldatetime = null,
    @i_srv          varchar(64) = null,
    @i_filial       int         = null,
    @i_sec          int         = 1,
    @i_turno        smallint    = null,
    @i_canal        smallint    = 4,
    @i_cuenta       cuenta      = null,
    @o_procesadas   int         = null out
)
as
  declare
    @w_return               int,
    @w_cuenta               int,
    @w_moneda               int,
    @w_cta_banco            cuenta,
    @w_disponible           money,
    @w_promedio1            money,
    @w_disponible_imp       money,
    @w_promedio1_imp        money,
    @w_filial               int,
    @w_oficina              smallint,
    @w_categoria            char(1),
    @w_rol_ente             char(1),
    @w_tipo_def             char(1),
    @w_prod_banc            smallint,
    @w_producto             smallint,
    @w_tipo                 char(1),
    @w_default              int,
    @w_contable             money,
    @w_prom_disponible      money,
    @w_contable_imp         money,
    @w_prom_disponible_imp  money,
    @w_ssn                  int,
    @w_ssn_aut              int,
    @w_clase_clte           char(1),
    @w_tipocta              char(1),
    @w_personalizada        char(1),
    @w_usadeci              char(1),
    @w_numdeci              int,
    @w_numdeci_imp          int,
    @w_12h                  money,
    @w_24h                  money,
    @w_48h                  money,
    @w_remesas              money,
    @w_saldo_interes        money,
    @w_int_mes              money,
    @w_valor_acreditar      money,
    @w_tasa_interes         real,
    @w_tasa_maxima          real,
    @w_dias_anio            smallint,
    @w_manana_sinferiados                datetime,
    @w_ciudad               int,
    @w_sucursal             smallint,
    @w_dias                 int,
    @w_bco                  int,
    @w_tipo_atributo        char(1),
    @w_monto                money,
    @w_int_hoy              money,
    @w_fecha_ult_ret        datetime,
    @w_dif_dias             smallint,
    @w_min_dispmes          money,
    @w_mes_dif              smallint,
    @w_fecha_aper           datetime,
    @w_actualiza            char(1),
    @w_tasa_hoy             real,
    @w_dias_mes             int,
    @w_auxiliar             varchar(10),
    @w_tipo_promedio        char(1),
    @w_estado               char(1),
    @w_nombre               char(60),
    @w_saldo_ayer           money,
    @w_fecha_ult_mov        datetime,
    @w_fecha_ult_mov_int    datetime,
    @w_saldo_rep1           money,
    @w_saldo_rep2           money,
    @w_saldo_rep3           money,
    @w_sld_rep1             money,
    @w_sld_rep2             money,
    @w_sld_rep3             money,
    @w_val_absoluto         money,
    @w_sec                  int,
    @w_alicuota             float,
    @w_saldo_mayor          char(1),
    @w_creditos_hoy         money,
    @w_debitos_hoy          money,
    @w_trn                  int,
    @w_valor_cobrar         real,
    @w_sp_name              descripcion,
    @w_causa                varchar(3),
    @w_girar                money,
    @w_bloqueos             money,
    @w_tasa_imp             float,
    @w_tasa_imp_gral        float,
    @w_manana_cambia_mes    char(1),
    @w_dia_ini_prx_mes      datetime,
    @w_dias_mes_act         int,
    @w_dias_mes_act_aux     int,
    @w_dias_prx_mes         int,
    @w_control              int,
    @w_lp_sec               int,
    @w_sec_vs               int,
    @w_tinm                 int,
    @w_debitos              money,
    @w_creditos             money,
    @w_monto_imp            money,
    @w_imp1                 money,
    @w_imp2                 money,
    @w_suspensos            smallint,
    @w_lineas               smallint,
    @w_contador_trx         int,
    @w_fecha_ult_capi       datetime,
    @w_cta_funcionario      char(1),
    @w_cliente              int,
    @w_valor_impuesto       money,
    @w_total_interes        money,
    @w_trn_code             int,
    @w_calculo_int          char(1),
    @w_tasa_impuesto        float,
    @w_tasa_imp_usado       float,
    @w_promedio2            money,
    @w_val_efe              money,
    @w_val                  money,
    @w_val2                 money,
    @w_accion               char(1),
    @w_alic                 money,
    @w_anio                 smallint,
    @w_mes                  int,
    @w_tipo_exonerado_imp   char(2),
    @w_retencion            char(1),
    @w_cta                  cuenta,
    @w_lote                 int,
    @w_dev_idb              char(1),
    @w_error                int,
    @w_compra               money,
    @w_nomtrn               varchar(10),
    @w_hora                 datetime,
    @w_tcapitalizacion      char (1),
    @w_fecha_prx_capita     datetime,
    @w_ult_dia_mes_sinferiado      datetime,
    @w_ult_dia_mes_ant_sinferiado  datetime,
    @w_ult_dia_cuota_sinferiado    datetime,
    --@w_corte_mes            datetime,
    @w_tipocta_super        char(1),
    @w_meses_prx_capita     integer,
    @w_fecha_hoy            datetime,
    @w_aplica_tasacorp      char(1),
    @w_monto_ult_capi       money,
    @w_moneda_local         int,
    @w_moneda_dolar         int,
    @w_saldo_mantval        money,
    @w_cot_hoy              float,
    @w_cot_hoy_aux          float,
    @w_cot_sig              float,
    @w_cot_sig_aux          float,
    @w_fecha_aux            datetime,
    @w_rubro                char(10),
    @w_impuesto             char(1),
    @w_promedio             money,
    @w_saldo_interes_tot    money,
    @w_tasa_ayer            real,
    @w_binc                 money,
    @w_numdecipar           int,
    @w_contador_tasas       int,
    @w_flag_tasas           int,
    @w_monto_interes        money,
    @w_rango_hasta          money,
    @w_rango_busqueda       money,
    @w_monto_calculo        money,
    @w_monto_total          money,
    @w_tasa_interes_acum    float,
    @w_rango_hasta_ant      money,
    @w_procesado_ok         int,
    @w_rango_intervalo      money,
    @w_rango_desde          money,
    @w_fecha_ini_anio_mes   datetime,
    @w_ultimo_rango         int,
    @w_monto_interes1       money,
    @w_monto_interes2       money,
    @w_penultimo_rango      int,
    @w_pen_rango_hasta      money,
    @w_codigo_pais          char(2),
    @w_cpto_rte             char(4),
    @w_cpto_rteica          char(4),
    @w_acumu_deb            money,
    @w_acumu_deb_total      money,
    @w_base                 money,
    @w_base_gmf             money,
    @w_total_gmf            money,
    @w_base_gmf_imp         money,
    @w_gmf_impuesto         money,
    @w_base_gmf_ica         money,
    @w_gmf_reteica          money,
    @w_base_rtfte           money,
    @w_porcentaje           float,
    @w_tasa_reteica         float,
    @w_valor_reteica        money,
    @w_min_rtfte            money,
    @w_dias_capi            smallint,
    @w_ini_mes_sinferiado   datetime,
    @w_hoy_es_inicio_mes    char(1),
    @w_ini_mes_actual       datetime,
    @w_exento               char(1),
    @w_fecha_ini_anio       datetime,
    @w_ciudad_rte_ica       int,
    @w_anios                int,
    @w_seccta               cuenta,
    @w_cursor               char(1),
    @w_msg                  varchar(255),
    @w_factor               float,
    @w_factor1              float,
    @w_factor2              float,
    @w_cant_sec             int,
    @w_posteo               char(1),
    @w_pro_final            smallint,
    @w_tasagmf              float,
    @w_gmfbco               money,
    @w_clase_clte_b         char(1),
    @w_siguiente_dia        datetime,
    @w_commit               char(1),
    @w_hijos                int,
    @w_hijo                 int,
    @w_orden                int,
    @w_filial_2             int,
    @w_oficina_2            int,
    @w_moneda_2             int,
    @w_producto_2           int,
    @w_prod_banc_2          int,
    @w_tipocta_2            char(1),
    @w_categoria_2          char(1),
    @w_debug                char(1),
    
    @w_cont_modulo          int,
    @w_cont_profinal        int,
    @w_cont_cta_banco       varchar(24),
    @w_cont_plazo           int,
    @w_cont_cuota           money,
    @w_cont_periodicidad    varchar(10),
    @w_cont_monto_final     money,
    @w_cont_intereses       money,
    @w_cont_ptos_premio     float,
    @w_cont_estado          char(1),
    @w_cont_categoria       char(1),
    @w_cont_fecha_crea      datetime,
    @w_cont_periodos_incump int,
    @w_es_contractual       char(1),
    @w_fecha_ult_cuo        datetime,
	@w_fecha_final          datetime,
    @w_cuotas_contractual   int,
    @w_saldo_mes            money,
    @w_meses                int,
    @w_disponible_esp       money,
    @w_num_rango            int,
    @w_prod_contractual     int,
    @w_fecha_saldo_ant      datetime,
    @w_camcat               char(1),
    @w_ajuste               money,
    @w_incumple_saldo       char(1),
    @w_gmf_reintegro        money,
    @w_total_reintegro      money,
    @w_tasa_reintegro       float,
    @w_gmf_reintegro_ica    money,
    @w_nemo                 char(4),
    @w_prov_diaria          char(1),   -- Parametro Provisión Diaria
    @w_pf_provisiona        char(1),
    @w_cta_pro_final        int,
    @w_cta_banco_rel        cuenta,
    @w_cta_plazo            smallint,   
    @w_cta_aporte_social    char(1),    
    @w_saldo_max            money,
    @w_exencion_isr         char(1),
    @w_num_anualidades      int,
    @w_salario_minimo       money,
    @w_valor_exencion_isr   money,
    @w_valor_grabado        money,
    @w_cobro_isr            char(1),
    @w_is_batch             char(1)
    
/* INICIALIZAR VARIABLES DE TRABAJO */
select
    @w_sp_name              = 'sp_ahmensual',
    @w_lote                 = 3000,
    @w_nomtrn               = 'REGISTRO',
    @w_manana_cambia_mes    = 'N',
    @w_cursor               = 'N',
    @w_trn_code             = 0,
    @w_gmfbco               = 0,
    @w_saldo_interes_tot    = 0,
    @w_hijo                 = convert(int, @i_param3),
    @w_hijos                = convert(int, @i_param4),
    @w_hoy_es_inicio_mes                = 'N',
    @w_cpto_rte             = null,
    @w_cpto_rteica          = null,
    @w_commit               = 'N',
    @w_debug                = 'S',--HABILITAR/DESHABILITAR PRINT EN OUTDIR.   
    @w_es_contractual       = 'N',--ADI REQ 217 AHORRO CONTRACTUAL
    @w_total_reintegro      = 0,
    @w_gmf_reintegro_ica    = 0,
    @w_gmf_reintegro        = 0,    
    @w_prov_diaria          = 'S',
    @w_cta_aporte_social    = 'N'


set nocount on

select
    @w_sp_name = 'sp_ahmensual'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
end

if @i_param2 is not null
begin
    select @s_rol = pa_tinyint
        from cobis..cl_parametro
        where pa_nemonico = 'ROB'
        and pa_producto = 'ADM'

    if @s_rol is null
        select @s_rol = 1

    select @i_srv = nl_nombre,
            @i_sec = 0,
            @i_canal = 4
        from cobis..ad_nodo_oficina
        where nl_nodo = 1

    select  @i_filial = convert(tinyint, @i_param1),
            @i_fecha = convert(smalldatetime, @i_param2)
end

select @w_ini_mes_actual = dateadd(dd,1 - datepart(dd,@i_fecha),@i_fecha) --inicio del mes actual
print 'INICIA PROC BATCH'

/* DETERMINAR EL PAIS DONDE SE ESTA EJECUTANDO EL PROCESO */
select @w_codigo_pais = pa_char    --*** ABREVIACION DEL PAIS
    from cobis..cl_parametro
    where pa_nemonico = 'ABPAIS'
    and pa_producto = 'ADM'

if @@rowcount = 0
begin
    select  @w_error = 101190,
            @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL ABPAIS DEL ADMIN'
    goto ERRORFIN
end

/* DETERMINAR EL BANCO DONDE SE ESTA EJECUTANDO EL PROCESO */
select @w_bco = pa_tinyint
    from cobis..cl_parametro
    where pa_producto = 'CTE'
    and pa_nemonico = 'CBCO'

if @@rowcount <> 1
begin
    select  @w_error = 111020,
            @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL CBCO DE CUENTAS CORRIENTES '
    goto ERRORFIN
end

/*GRAVAMEN A LOS MOVIMIENTOS FINANCIEROS (SOLO PARA COLOMBIA) */
select @w_tasagmf = pa_float  --*** TASA GMF
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'IGMF'

if @@rowcount = 0
begin
    select  @w_error = 201196,
            @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL IGMF DE CUENTAS AHORROS '
    goto ERRORFIN
end

/* DETERMINAR LA CIUDAD DE LOS FERIADOS NACIONALES */
select @w_ciudad = pa_int
    from cobis..cl_parametro
    where pa_producto = 'CTE'
    and pa_nemonico = 'CMA'

if @@rowcount <> 1
begin
    select  @w_error = 205031,
            @w_msg = 'ERROR EN PARAMETRO DE CIUDAD DE FERIADOS NACIONALES'
    goto ERRORFIN
end

if exists (select 1
            from cobis..cl_dias_feriados
            where df_fecha  = @i_fecha
            and df_ciudad = @w_ciudad)
begin
    select  @w_error = 205031,
            @w_msg = 'ESTE PROCESO NO SE PUEDE EJECUTAR EN FERIADOS NACIONALES'
    goto ERRORFIN
end

/* DETERMINAR EL SIGUIENTE DIA HABIL (ULTIMO PROCESO) */
select @w_siguiente_dia = dateadd(dd,1,@i_fecha) 

while datepart(mm,@i_fecha) = datepart(mm,@w_siguiente_dia) and exists(select 1 
                                                                       from cobis..cl_dias_feriados 
                                                                       where  df_ciudad = @w_ciudad 
                                                                       and df_fecha  = @w_siguiente_dia)
begin
    select @w_siguiente_dia = dateadd(dd, 1,@w_siguiente_dia)
end

/* ** REQ 217 PARAMETRO CAMBIO DE CATEGORIA ** */
select @w_camcat = pa_char
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'CAMCAT'

if @@rowcount = 0
begin
    print 'NO EXISTE PARAMETRO CAMBIO DE CATEGORIA'
    select  @w_error = 0,
            @w_msg = 'NO EXISTE PARAMETRO CAMBIO DE CATEGORIA'
    goto ERRORFIN
end

/* ** REQ 217 PARAMETRO INCUMPLIMIENTO POR SALDO ** */
select @w_incumple_saldo = pa_char
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'CUMSAL'

if @@rowcount = 0
begin
    print 'NO EXISTE PARAMETRO INCUMPLIMIENTO POR SALDO'
    select  @w_error = 0,
            @w_msg = 'NO EXISTE PARAMETRO INCUMPLIMIENTO POR SALDO'
    goto ERRORFIN
end



/* ****************************************************** */
/* (HIJO 0) GENERACION DEL UNIVERSO DE CUENTAS A PROCESAR */
/* ****************************************************** */
print '  COMIENZA PARA EL UNIVERSO ' + cast (@w_hijo as varchar)
if @w_hijo = 0
begin
    print ' Comienza hijo 0 ' 

    -- Se agrega control para guardar cuentas NO PROCESADAS ya que el rolback  al haber error cicla el proceso al quitar el hijo = 0 de la cuenta fallida
    if exists(select 1 from sysobjects where name = 'ah_ctas_no_procesadas')
        exec('drop table ah_ctas_no_procesadas')

    exec('create table ah_ctas_no_procesadas
        (
            cta_banco cuenta not null,
            hijo      int not null,
            orden     int identity
        )')

    /* CONTROL PARA QUE ESTE PROCESO SEA REPROCESABLE */
    if exists(select 1 from sysobjects where name = 'ah_universo_ahmensual')
    begin
        if exists(select 1 from ah_universo_ahmensual where hijo <> 0)
            return 0
    end

    if exists(select 1 from sysobjects where name = 'ah_universo_ahmensual')
        exec('drop table ah_universo_ahmensual')

    exec('create table ah_universo_ahmensual
        (
            cta_banco cuenta not null,
            hijo      int not null,
            orden     int identity
        )')
      
    set rowcount 0

    insert into ah_universo_ahmensual
        select ah_cta_banco,ah_cuenta % @w_hijos + 1
            from cob_ahorros..ah_cuenta
            where ah_estado not in ('C', 'G', 'N')
            and ah_filial   = @i_filial
            and isnull(ah_fecha_ult_proceso, @i_fecha) < @w_siguiente_dia
            and ah_cta_banco = isnull(@i_cuenta, ah_cta_banco)
            order by ah_filial, ah_moneda, ah_producto,
                    ah_oficina, ah_prod_banc, ah_tipocta, ah_categoria

    set rowcount 0
        create index idx1
            on ah_universo_ahmensual(hijo, orden)
                on indexgroup

    delete cob_ahorros..ah_acumulador
        where ac_trn in (271, 379)

    if @@error <> 0
    begin
        select  @w_error = 205031,
                @w_msg = 'ERROR EN ELIMINACION DE ACUMULADOR'
        goto ERRORFIN
    end

    if @w_debug = 'S'
    begin
        print '-------------------------------------------------------------------------'
        print '......................... @w_hijos ' + cast (@w_hijos as varchar)
        print '......................... @i_fecha  ' + cast (@i_fecha as varchar)
        print '......................... @i_filial  ' + cast (@i_filial as varchar)
        print '......................... @i_cuenta  ' + cast (@i_cuenta as varchar)
        print '......................... @w_siguiente_dia  ' + cast (@w_siguiente_dia as varchar)
        print '-------------------------------------------------------------------------'
    end

    print ' Termina Proceso hijo 0 '
    return 0
end -- hijo 0


/* ********************************************************** */
/* (HIJO 999) PROCESO DE CIERRE DE LOS PROCESOS PARALELIZADOS */
/* ********************************************************** */
if @w_hijo = 999
begin
    print ' Inicia proceso Hijo 999 '
    /* CONTROL PARA EVITAR QUE ESTE PROCESO SE EJECUTE MIENTRAS LOS HIJOS NO HAYAN TERMINADO DE TRABAJAR */
    if exists(select 1 from ah_universo_ahmensual where hijo <> 0)
    begin
        select  @w_error = 0,
                @w_msg = 'ERROR SE DETECTARON OPERACIONES SI PROCESAR (ah_universo_ahmensual CON HIJOS <> A CERO)'
        goto ERRORFIN
    end

    if @w_codigo_pais = 'CO'
    begin
        print ' Codigo_pais = CO '
        select @w_cliente = pa_int
            from cobis..cl_parametro
            where pa_nemonico = 'CCBA'
            and pa_producto = 'CTE'      

        if @@rowcount <> 1
        begin
            select  @w_error = 201196,
                    @w_msg = 'ERROR EN PARAMETRO DE CODIGO CLIENTE BANCO'
            goto ERRORFIN
        end

        select @w_clase_clte_b  =   case c_tipo_compania
                                        when 'OF' then 'O'
                                        else 'P'
                                    end
            from cobis..cl_ente
            where en_ente = @w_cliente

        if @@rowcount <> 1
        begin
            select  @w_error = 201196,
                    @w_msg = 'CLIENTE NO EXISTE'
            goto ERRORFIN
        end

        insert into cob_ahorros..ah_tran_servicio
                    (ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha, ts_usuario,
                    ts_terminal, ts_oficina, ts_reentry, ts_origen, ts_cta_banco,
                    ts_valor, ts_moneda, ts_oficina_cta, ts_prod_banc, ts_categoria,
                    ts_tipocta_super, ts_turno, ts_clase_clte, ts_cliente, ts_interes)
            select  max(ac_ssn), max(ac_ssn), 379, @i_fecha, 'op_batch', 
                    'consola', ac_oficina, 'N', 'U', '0',
                    sum(ac_intereses), ac_moneda, ac_oficina, ac_prod_banc, ac_categoria,
                    ac_tipocta_super, @i_turno, ac_clase_clte, @w_cliente, sum(ac_intereses) / @w_tasagmf
                from cob_ahorros..ah_acumulador
                where ac_fecha  = @i_fecha
                and ac_trn      = 379
                group by ac_oficina, ac_moneda, ac_prod_banc, ac_categoria, ac_tipocta_super, ac_clase_clte

        if @@error <> 0
        begin
            select  @w_error = 201196,
                    @w_msg = 'ERROR AL REGISTRAR LOS gmf EN LAS TRANSACCIONES DE SERVICIO'
            goto ERRORFIN
        end
    end -- solo para Colombia  

    /*REGISTRAR LOS INTERESES CALCULADOS EN LAS TRANSACCIONES DE SERVICIO */
    if @w_bco <> 59
    begin
        --  Se excluye para BANCAMIA debido a que la  contabilidad de los intereses es por tercero
        print ' Insercion en ah_tran_servicio  trn=271 agrupado '
        insert into cob_ahorros..ah_tran_servicio
                    (ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha, ts_usuario,
                    ts_terminal, ts_oficina, ts_reentry, ts_origen, ts_cta_banco,
                    ts_valor, ts_moneda, ts_oficina_cta, ts_prod_banc, ts_categoria,
                    ts_tipocta_super, ts_turno, ts_clase_clte, ts_cliente, ts_interes)
            select max(ac_ssn), max(ac_ssn), 271, @i_fecha, 'op_batch',
                    'consola', ac_oficina, 'N', 'U', '0',
                    sum(ac_intereses), ac_moneda, ac_oficina, ac_prod_banc, ac_categoria,
                    ac_tipocta_super, @i_turno, ac_clase_clte, @w_cliente, sum(ac_intereses)
                from cob_ahorros..ah_acumulador
                where ac_fecha  = @i_fecha
                and ac_trn      = 271
                group by ac_oficina, ac_moneda, ac_prod_banc, ac_categoria, ac_tipocta_super, ac_clase_clte

        if @@error <> 0
        begin
            select  @w_error = 201196,
                    @w_msg = 'ERROR AL REGISTRAR LOS INTERESES EN LAS TRANSACCIONES DE SERVICIO'
            goto ERRORFIN
        end
    end -- bco <> 59

    /* CONTROL CUENTAS SIN PROCESAR */
    if exists(select 1 
            from cob_ahorros..ah_cuenta
            where (ah_fecha_ult_proceso < @w_siguiente_dia
                or ah_fecha_ult_proceso is null)
            and ah_estado not in ('C', 'G', 'N')) 
    begin
        print 'HIJO 999 - EXISTEN CUENTAS SIN PROCESAR'
        select  @w_error = 201196,
                @w_msg = 'ERROR - EXISTEN CUENTAS SIN PROCESAR'
        goto ERRORFIN
    end

    print ' Termina el proceso del hijo 999'
    return 0
end -- hijo 999

/* ****************************************************** */
/*     PROCESO QUE EJECUTAN EXCLUSIVAMENTE LOS HIJOS      */
/* ****************************************************** */

select 'Inicio Procesamiento' = convert(varchar(30), getdate(), 109)

select @w_lp_sec = siguiente + @i_sec
    from cobis..cl_seqnos
    where tabla = 'ah_lpendiente'

if @w_lp_sec > 2147483640
    select @w_lp_sec = @i_sec

if @i_turno is null
    select @i_turno = @s_rol

  -- PARAMETRO DE DECIMALES
select @w_numdecipar = pa_tinyint
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'DCI'

if @@rowcount <> 1
begin
    select  @w_error = 111020,
            @w_msg = 'ERROR EN PARAMETRO DE DECIMALES PARA AHORROS'
    goto ERRORFIN
end

-- PARAMETRO DE DECIMALES PARA IMPUESTOS
select @w_numdeci_imp = pa_tinyint
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'DIM'
  
if @@rowcount <> 1
begin
    select  @w_error = 111020,
            @w_msg = 'ERROR EN PARAMETRO DE DECIMALES DE IMPUESTOS PARA AHORROS'
    goto ERRORFIN
end

-- Codigo de moneda local
select @w_moneda_local = pa_tinyint
    from cobis..cl_parametro
    where pa_producto = 'ADM'
    and pa_nemonico = 'CMNAC'

if @@rowcount <> 1
begin
    select  @w_error = 111020,
            @w_msg = 'ERROR EN PARAMETRO DE MONEDA NACIONAL'
    goto ERRORFIN
end

select @w_moneda_dolar = pa_tinyint
    from cobis..cl_parametro
    where pa_producto = 'ADM'
    and pa_nemonico = 'CDOLAR'

if @@rowcount <> 1
begin
    select  @w_error = 111020,
            @w_msg = 'ERROR EN PARAMETRO DE MONEDA DOLAR'
    goto ERRORFIN
end

-- Encuentra valor de parametro para comparar saldos
select @w_saldo_rep1 = pa_money
    from cobis..cl_parametro
    where pa_nemonico = 'DS0'

if @@rowcount <> 1
begin
    select  @w_error = 205031,
            @w_msg = 'ERROR EN PARAMETRO DE DIFERENCIA DE SALDOS'
    goto ERRORFIN
end

-- Encuentra valor de parametro para comparar saldos
select @w_saldo_rep2 = pa_money
    from cobis..cl_parametro
    where pa_nemonico = 'RCLS0'

if @@rowcount <> 1
begin
    select  @w_error = 205031,
            @w_msg = 'ERROR EN PARAMETRO DE SALDOS MAYORES A UN VALOR'
    goto ERRORFIN
end

-- Encuentra valor de parametro para saldos superiores
select @w_saldo_rep3 = pa_money
    from cobis..cl_parametro
    where pa_nemonico = 'RCS0'
  
if @@rowcount <> 1
begin
    select  @w_error = 205031,
            @w_msg = 'ERROR EN PARAMETRO DE RET/DEP MAYORES A UN VALOR'
    goto ERRORFIN
end

-- Encuentra el dias del anio para provision diaria interes
select @w_dias_anio = pa_smallint
    from cobis..cl_parametro
    where pa_producto = 'ADM'
    and pa_nemonico = 'DIA'

if @@rowcount <> 1
begin
    select  @w_error = 205031,
            @w_msg = 'ERROR EN PARAMETRO DE NUMERO DE DIAS ANIO'
    goto ERRORFIN
end

-- Guardar Provisión DIARIA en ah_tran_servicio
select @w_prov_diaria = pa_char
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'PRVDIA'
  
if @@rowcount <> 1
begin
    select  @w_error = 205032,
            @w_msg = 'ERROR EN PARAMETRO EFECTUAR PROVISION DIARIA'
    goto ERRORFIN
end      
  
-- Cobro Impuesto ISR
select @w_cobro_isr = pa_char
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'CIISR'
  
if @@rowcount <> 1
begin
    select  @w_error = 205033,
            @w_msg = 'ERROR EN PARAMETRO COBRO IMPUESTO ISR'
    goto ERRORFIN
end
 
-- Excencion ISR
select @w_exencion_isr = pa_char
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'AEXISR'

if @@rowcount <> 1
begin
    select  @w_error = 205034,
            @w_msg = 'ERROR EN PARAMETRO APLICACION DE EXENCION ISR'
    goto ERRORFIN
end

-- Numero de Anualidades ISR
select @w_num_anualidades = pa_tinyint
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'NAISR'
  
if @@rowcount <> 1
begin
    select  @w_error = 205035,
            @w_msg = 'ERROR EN PARAMETRO NUMERO DE ANUALIDADES ISR'
    goto ERRORFIN
end

-- Salario Minimo Vital
select @w_salario_minimo = pa_money
    from cobis..cl_parametro
    where pa_producto = 'ADM'
    and pa_nemonico = 'SMV'

if @@rowcount <> 1
begin
    select  @w_error = 205036,
            @w_msg = 'ERROR EN PARAMETRO SALARIO MINIMO VITAL MENSUAL'
    goto ERRORFIN
end


-- Tasa de Impuesto
select @w_tasa_imp_gral = pa_float
    from cobis..cl_parametro
    where pa_producto = 'ADM'
    and pa_nemonico = 'TIDB'
  
if @@rowcount <> 1
begin
    select  @w_error = 205031,
            @w_msg = 'ERROR EN PARAMETRO DE TASA DE IMPUESTO'
    goto ERRORFIN
end

-- Obtener el secuencial para numero de control y linea pendiente
select @w_control = siguiente
    from cobis..cl_seqnos
    where tabla = 'ah_control'

if @w_control > 9999
    select @w_control = 0

-- Parametro para Inmovilizacion de Cuentas
select @w_tinm = pa_tinyint
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'TIN'
 
if @@rowcount <> 1
begin
    select  @w_error = 201196,
            @w_msg = 'ERROR EN PARAMETRO DE TIEMPO INMIVILIZACION'
    goto ERRORFIN
end

-- Parametro para Base Diaria Interes para calculo de retenci˘n
select @w_binc = isnull(pa_money,0)
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'BINCR'

if @@rowcount <> 1
begin
    select  @w_error = 201196,
            @w_msg = 'ERROR EN PARAMETRO DE BASE DIARIA'
    goto ERRORFIN
end

/* SOLO PARA COLOMBIA */
if @w_codigo_pais = 'CO'
begin
    select @w_min_rtfte = isnull(pa_money,0)
        from cobis..cl_parametro
        where pa_nemonico = 'MRTF'
        and pa_producto = 'AHO'

    if @@rowcount = 0
    begin
        select  @w_error = 101077,
                @w_msg = 'NO EXISTE PARAMETRO DE MONTO MINIMO DE RETEFTE'
        goto ERRORFIN
    end

    --Parametro concepto de retencion
    select @w_cpto_rte = ci_concepto
        from cob_remesas..re_concepto_imp
        where ci_tran        = 308
        and ci_impuesto    = 'R'
        and ci_contabiliza = 'tm_valor'

    if @@rowcount <> 1
    begin
        select  @w_error = 201196,
                @w_msg = 'ERROR EN PARAMETRO DE CONCEPTO DE RETENCION'
        goto ERRORFIN
    end

    --Parametro concepto de reteica
    select @w_cpto_rteica = ci_concepto
        from cob_remesas..re_concepto_imp
        where ci_tran     = 334
        and ci_impuesto = 'C'

    if @@rowcount <> 1
    begin
        select  @w_error = 201196,
                @w_msg = 'ERROR EN PARAMETRO DE CONCEPTO DE RETEICA'
        goto ERRORFIN
    end

    /* ** PARAMETRO PRODUCTO AHORRO CONTRACTUAL ** */
    select @w_prod_contractual = pa_int
        from cobis..cl_parametro
        where pa_producto = 'AHO'
        and pa_nemonico = 'PAHCT'

    if @@rowcount = 0
    begin
        print 'NO EXISTE PARAMETRO PRODUCTO CONTRACTUAL'
        select  @w_error = 201196,
                @w_msg = 'NO EXISTE PARAMETRO PRODUCTO CONTRACTUAL'
        goto ERRORFIN
    end

    if (select count(1)
            from cob_remesas..pe_pro_bancario
            where pb_pro_bancario = @w_prod_contractual) = 0
    begin
        print 'PRODUCTO DEFINIDO EN PARAMETRO NO EXISTE'
        select @w_error = 201196,
                 @w_msg = 'PRODUCTO DEFINIDO EN PARAMETRO NO EXISTE'
        goto ERRORFIN
    end
end

/* *************************************************** */
/*                 Controles de Fecha                  */
/* *************************************************** */

-- Determinar el numero de dias de feriados nacionales
select @w_manana_sinferiados = dateadd(dd,1,@i_fecha)

while 1 = 1
begin
    -- Determino si existe cambio de mes entre dias feriados
    if datepart(mm,@w_manana_sinferiados) <> datepart(mm,@i_fecha) and @w_manana_cambia_mes = 'N'
        select  @w_manana_cambia_mes = 'S',
                @w_dia_ini_prx_mes = @w_manana_sinferiados
      
    if exists (select df_fecha
                from cobis..cl_dias_feriados
                where df_ciudad = @w_ciudad
                and df_fecha  = @w_manana_sinferiados)
        select @w_manana_sinferiados = dateadd(dd,1,@w_manana_sinferiados)
    else
        break
end

select @w_ini_mes_sinferiado = @w_ini_mes_actual

/* BUSCAR EL PRIMER DIA HABIL DEL MES */
while exists(select 1
                from cobis..cl_dias_feriados
                where df_ciudad = @w_ciudad
                and df_fecha  = @w_ini_mes_sinferiado)
begin
    select @w_ini_mes_sinferiado = dateadd(dd,1,@w_ini_mes_sinferiado)
end

if @w_ini_mes_sinferiado = @i_fecha
    select @w_hoy_es_inicio_mes = 'S'

-- Numero de dias entre hoy y proxima fecha laborable nacional
if @w_manana_cambia_mes = 'S'
begin
    select  @w_dias_mes_act = datediff(dd,@i_fecha,@w_dia_ini_prx_mes),
            @w_dias_prx_mes = datediff(dd,@w_dia_ini_prx_mes,@w_manana_sinferiados)
end
else
begin
    if @w_hoy_es_inicio_mes = 'S'
        select @w_dias_mes_act = 1 + (datediff(dd,@w_ini_mes_sinferiado,@w_manana_sinferiados) - 1)
    else
        select @w_dias_mes_act = datediff(dd,@i_fecha,@w_manana_sinferiados)

    select @w_dias_prx_mes = 0
end

--  JTA backup de dias a provisionar 
select @w_dias_mes_act_aux = @w_dias_mes_act

/* ******************************************************************* */
/* DETERMINAR LA CANTIDAD DE CUENTAS DE AHORRO A PROCESAR EN ESTE HIJO */
/* ******************************************************************* */

select @w_cant_sec = count(1) * 3
    from ah_universo_ahmensual with (index = idx1 )
    where hijo = @w_hijo

update cobis..ba_secuencial
    set @w_ssn = se_numero,
        se_numero = @w_ssn + @w_cant_sec

if @@rowcount <> 1
begin
    select  @w_error = 205031,
            @w_msg = 'Error en actualizacion de SSN'
    goto ERRORFIN
end

select pf_pro_final,
        me_tipo_ente,
        me_pro_bancario,
        pf_filial,
        pf_sucursal,
        pf_producto,
        pf_moneda,
        pf_tipo
    into #tmp_profinal
    from cob_remesas..pe_pro_final,
        cob_remesas..pe_mercado
    where pf_mercado = me_mercado


/* TABLA TEMPORAL DE TRABAJO */
select *
    into #pint4
    from tempdb..pint4
    where  1 = 2

if @@error <> 0
begin
    select  @w_error = 351504,
            @w_msg = 'NO SE PUEDE CREAR TABLA DE TRABAJO PINT4'
    goto ERRORFIN
end

select  @w_error            = 0,
        @w_filial_2         = -1,
        @w_oficina_2        = -1,
        @w_producto_2       = -1,
        @w_moneda_2         = -1,
        @w_prod_banc_2      = -1,
        @w_tipocta_2        = 'X',
        @w_categoria_2      = 'X'

-- ++++++++++++++++++++++++++++++++++++++++++
-- Cursor para el procesamiento de cuentas --
-- ++++++++++++++++++++++++++++++++++++++++++

while 1 = 1
begin
    set rowcount 1

    select  @w_cta_banco = cta_banco,
            @w_orden = orden
        from ah_universo_ahmensual with (index = idx1 )
        where hijo = @w_hijo
        and cta_banco not in (select cta_banco from ah_ctas_no_procesadas)

    if @@rowcount = 0
    begin
        set rowcount 0
        break
    end

    set rowcount 0

    if @w_debug = 'S'
    begin
        print ''
        print ''
        print ''
        print ' ----------------------------------'
        print ' PROCESANDO CUENTA: ' + @w_cta_banco
        print ' ----------------------------------'
    end

    update ah_universo_ahmensual with (rowlock)
        set hijo = 0
        from ah_universo_ahmensual with (index = idx1 )
        where hijo  = @w_hijo
        and orden   = @w_orden

    insert into ah_ctas_no_procesadas
    values (@w_cta_banco,@w_hijo )
    
    /* VALORES DE CUENTA    */
    select  @w_cuenta           = ah_cuenta,
            @w_cta_banco        = ah_cta_banco,
            @w_categoria        = ah_categoria,
            @w_tipocta          = ah_tipocta,
            @w_rol_ente         = ah_rol_ente,
            @w_tipo_def         = ah_tipo_def,
            @w_prod_banc        = ah_prod_banc,
            @w_producto         = ah_producto,
            @w_tipo             = ah_tipo,
            @w_default          = ah_default,
            @w_personalizada    = ah_personalizada,
            @w_oficina          = ah_oficina,
            @w_12h              = ah_12h,
            @w_24h              = ah_24h,
            @w_48h              = ah_48h,
            @w_remesas          = ah_remesas,
            @w_disponible       = ah_disponible,
            @w_filial           = ah_filial,
            @w_moneda           = ah_moneda,
            @w_promedio1        = ah_promedio1,
            @w_promedio2        = ah_promedio2,
            @w_prom_disponible  = ah_prom_disponible,
            @w_saldo_interes    = ah_saldo_interes,
            @w_int_hoy          = ah_int_hoy,
            @w_fecha_ult_ret    = ah_fecha_ult_ret,
            @w_min_dispmes      = ah_min_dispmes,
            @w_fecha_aper       = ah_fecha_aper,
            @w_tasa_hoy         = ah_tasa_hoy,
            @w_tipo_promedio    = ah_tipo_promedio,
            @w_estado           = ah_estado,
            @w_nombre           = ah_nombre,
            @w_saldo_ayer       = ah_saldo_ayer,
            @w_fecha_ult_mov    = ah_fecha_ult_mov,
            @w_fecha_ult_mov_int= ah_fecha_ult_mov_int,
            @w_creditos_hoy     = ah_creditos_hoy,
            @w_debitos_hoy      = ah_debitos_hoy,
            @w_cta_funcionario  = ah_cta_funcionario,
            @w_debitos          = ah_debitos,
            @w_bloqueos         = ah_monto_bloq + ah_monto_consumos,
            @w_creditos         = ah_creditos,
            @w_monto_imp        = ah_monto_imp,
            @w_suspensos        = ah_suspensos,
            @w_lineas           = ah_linea,
            @w_contador_trx     = ah_contador_trx,
            @w_fecha_ult_capi   = ah_fecha_ult_capi,
            @w_cliente          = ah_cliente,
            @w_tcapitalizacion  = ah_capitalizacion,
            @w_fecha_prx_capita = ah_fecha_prx_capita,
            @w_int_mes          = ah_int_mes,
            @w_tipocta_super    = ah_tipocta_super,
            @w_aplica_tasacorp  = ah_aplica_tasacorp,
            @w_monto_ult_capi   = ah_monto_ult_capi,
            @w_saldo_mantval    = ah_saldo_mantval,
            @w_clase_clte       = ah_clase_clte,
            @w_es_contractual   = 'N'
        from cob_ahorros..ah_cuenta
        where ah_cta_banco = @w_cta_banco

    /* PROVISIONA SI O NO */  
    select  @w_pf_provisiona = isnull(pf_provisiona ,'S'),
            @w_cta_pro_final = pf_pro_final 
    from cob_remesas..pe_pro_final 
    where pf_sucursal in (select case of_subtipo
                            when 'O' then of_regional
                            else of_oficina
                            end
                            from cobis..cl_oficina
                            where of_oficina = @w_oficina)
    and pf_mercado in (select me_mercado 
                            From cob_remesas..pe_mercado 
                            where me_pro_bancario in (select pb_pro_bancario 
                                                        from cob_remesas..pe_pro_bancario 
                                                        where pb_pro_bancario   = @w_prod_banc)
                                                        and me_tipo_ente        = @w_tipocta)

    /* APORTE SOCIAL ADICIONAL */  -- JTA
    select @w_dias_mes_act = @w_dias_mes_act_aux
    if (@w_prod_banc in (select pa_int from cobis..cl_parametro where  pa_producto = 'AHO' and  pa_nemonico = 'PCAASA' ))
    begin
        select @w_cta_aporte_social  = 'S'
        
        select  @w_cta_banco_rel = ca_cta_banco_rel,  -- cta donde iran los intereses por NC
                @w_cta_plazo     = ca_dias_plazo,     -- dias plazo 
                @w_saldo_max     = ca_saldo_max
        from cob_ahorros..ah_cuenta_aux
        where ca_cta_banco = @w_cta_banco
                
        -- si (dias que provisionará)  >  (dias que falta provisionar)  =  cambie dias a provisionar
        if (@w_dias_mes_act  >  (@w_cta_plazo - datediff(dd,@w_fecha_ult_mov,@i_fecha)) and @w_cta_plazo < datediff(dd,@w_fecha_ult_mov,@i_fecha))
            select @w_dias_mes_act = @w_cta_plazo - datediff(dd,@w_fecha_ult_mov,@i_fecha)
            
        -- si (dias que se ha provisionado) > dias plazo de cta  =  no provisione
        if (datediff(dd,@w_fecha_ult_mov,@i_fecha) >= @w_cta_plazo)
            select @w_dias_mes_act = 0

        -- si (no llega al saldo maximo) =  no provisione
        if (@w_disponible < @w_saldo_max)
            select @w_dias_mes_act = 0  

        if @w_debug = 'S'
        begin
            print '...... APORTE SOCIAL ADICIONAL --------------------------------------'
            print '...... @w_cta_aporte_social : ' + convert(varchar, @w_cta_aporte_social )
            print '...... @w_cta_banco_rel     : ' + convert(varchar, @w_cta_banco_rel     )
            print '...... @w_saldo_max         : ' + convert(varchar, @w_saldo_max         )
            print '...... dias a provisionar   : ' + convert(varchar, @w_cta_plazo         )
            print '...... dias provisionados   : ' + convert(varchar, datediff(dd,@w_fecha_ult_mov,dateadd(dd,-1,@i_fecha))  )
            print '...... @w_dias_mes_act      : ' + convert(varchar, @w_dias_mes_act      )
            print '-----------------------------------------------'
        end             
    end
    else
    begin
        select @w_cta_aporte_social  = 'N'  
    end
    
    /* AHORRO CONTRACTUAL */
    if(@w_prod_banc = @w_prod_contractual)
    begin
        select  @w_es_contractual       = 'S',
                @w_cont_modulo          = cc_modulo,
                @w_cont_profinal        = cc_profinal,
                @w_cont_cta_banco       = cc_cta_banco,
                @w_cont_plazo           = cc_plazo,
                @w_cont_cuota           = cc_cuota,
                @w_cont_periodicidad    = cc_periodicidad,
                @w_cont_monto_final     = cc_monto_final,
                @w_cont_intereses       = cc_intereses,
                @w_cont_ptos_premio     = cc_ptos_premio,
                @w_cont_estado          = cc_estado,
                @w_cont_categoria       = cc_categoria,
                @w_cont_fecha_crea      = convert(varchar, cc_fecha_crea, 101),
                @w_cont_periodos_incump = cc_periodos_incump,
                @w_fecha_ult_cuo        = convert(varchar, dateadd(mm,cc_plazo - 1,@w_fecha_aper), 101)
            from cob_remesas..re_cuenta_contractual
            where cc_cta_banco  = @w_cta_banco
            and cc_prodbanc     = @w_prod_contractual
            and cc_estado       = 'A'
			
		-- ultimo dia del mes (DE ULTIMA CUOTA) sin feriados
		select @w_ult_dia_cuota_sinferiado = dateadd(dd,-datepart(dd,dateadd(mm,1,@w_fecha_ult_cuo)),dateadd(mm,1,@w_fecha_ult_cuo))
		
		while 1 = 1
		begin
			if exists (select 1
						from cobis..cl_dias_feriados
						where df_ciudad = @w_ciudad
						and df_fecha  = @w_ult_dia_cuota_sinferiado)
				select @w_ult_dia_cuota_sinferiado = dateadd(dd,-1, @w_ult_dia_cuota_sinferiado)
			else
				break
		end
				
        if @w_debug = 'S'
        begin
            print '...... CONTRACTUAL -------------------------------'
            print '...... @w_es_contractual           : ' + convert(varchar, @w_es_contractual)
            print '...... @w_cont_modulo              : ' + convert(varchar, @w_cont_modulo)
            print '...... @w_cont_profinal            : ' + convert(varchar, @w_cont_profinal)
            print '...... @w_cont_cta_banco           : ' + convert(varchar, @w_cont_cta_banco)
            print '...... @w_cont_plazo               : ' + convert(varchar, @w_cont_plazo)
            print '...... @w_cont_cuota               : ' + convert(varchar, @w_cont_cuota)
            print '...... @w_cont_periodicidad        : ' + convert(varchar, @w_cont_periodicidad)
            print '...... @w_cont_monto_final         : ' + convert(varchar, @w_cont_monto_final)
            print '...... @w_cont_intereses           : ' + convert(varchar, @w_cont_intereses)
            print '...... @w_cont_ptos_premio         : ' + convert(varchar, @w_cont_ptos_premio)
            print '...... @w_cont_estado              : ' + convert(varchar, @w_cont_estado)
            print '...... @w_cont_categoria           : ' + convert(varchar, @w_cont_categoria)
            print '...... @w_cont_fecha_crea          : ' + convert(varchar, @w_cont_fecha_crea)
            print '...... @w_cont_periodos_incump     : ' + convert(varchar, @w_cont_periodos_incump)
            print '...... @w_fecha_ult_cuo            : ' + convert(varchar, @w_fecha_ult_cuo)
            print '...... @w_fecha_final              : ' + convert(varchar, @w_fecha_final)
            print '...... @w_ult_dia_cuota_sinferiado : ' + convert(varchar, @w_ult_dia_cuota_sinferiado)
            print '--------------------------------------------------------------------'
        end         
    end

    /* FIN ADI: REQ 217  DATOS DE CUENTA - AHORRO CONTRACTUAL */

    /* ******************* */
    /* CAMBIO DE VARIABLES */
    /* ******************* */
    
    if @w_debug = 'S'
    begin
        print '......................... CAMBIO DE VARIABLES ------------'
        print '...... @w_oficina   : ' + convert(varchar, @w_oficina)
        print '...... @w_producto  : ' + convert(varchar, @w_producto)
        print '...... @w_moneda    : ' + convert(varchar, @w_moneda)
        print '...... @w_prod_banc : ' + convert(varchar, @w_prod_banc)
        print '...... @w_tipocta   : ' + convert(varchar, @w_tipocta)
        print '...... @w_categoria : ' + convert(varchar, @w_categoria)
    end
        
    if  @w_filial <> @w_filial_2
        or @w_oficina <> @w_oficina_2
        or @w_producto <> @w_producto_2
        or @w_moneda <> @w_moneda_2
        or @w_prod_banc <> @w_prod_banc_2
        or @w_tipocta <> @w_tipocta_2
        or @w_categoria <> @w_categoria_2
    begin
        /* DETERMINAR LA SUCURSAL DE LA OFICINA */
        select @w_sucursal = isnull(of_regional,of_oficina)
            from cobis..cl_oficina
            where of_oficina = @w_oficina

        /* DETERMINAR EL NUMERO DE DECIMALES QUE MANEJA LA MONEDA */
        if @w_moneda <> @w_moneda_2
        begin
            select  @w_numdeci      = 0,
                    @w_numdeci_imp  = 0

            select @w_numdeci   = @w_numdecipar
                from cobis..cl_moneda
                where mo_moneda = @w_moneda
                and mo_decimales= 'S'
        end

        /* DETERMINAR LA CIUDAD DE LA OFICINA DE LA CUENTA */
        if @w_oficina <> @w_oficina_2
        begin
            select @w_ciudad_rte_ica = of_ciudad
                from cobis..cl_oficina
                where of_oficina = @w_oficina
        end

        /* DETERMINAR LA MODALIDAD DE CALCULO DEL VALOR BASE SOBRE EL QUE SE PAGARA EL INTERES */
        select @w_tipo_atributo = tipo_atributo
            from tempdb..pe_tipo_atributo
            where filial    = @w_filial
            and sucursal    = @w_sucursal
            and producto    = @w_producto
            and moneda      = @w_moneda
            and pro_bancario= @w_prod_banc
            and tipo_cta    = @w_tipocta
            and servicio    = 'PINT'
            and rubro       = '18'

        if @@rowcount = 0
        begin
            select  @w_error = 351504,
                    @w_msg = 'NO SE ECUENTRA TIPO DE ATRIBUTO tempdb..pe_tipo_atributo'
            goto ERROR
        end

        truncate table #pint4
		
        insert into #pint4
            select *
                from tempdb..pint4
                where filial      = @w_filial
                and sucursal      = @w_sucursal
                and producto      = @w_producto
                and moneda        = @w_moneda
                and pro_bancario  = @w_prod_banc
                and tipo_ente     = @w_tipocta
                and servicio_dis  = 'PINT'
                and rubro         = '18'
                and tipo_atributo = @w_tipo_atributo
                and categoria     = @w_categoria

        if @@rowcount = 0
        begin
            select  @w_error = 351504,
                    @w_msg = 'NO SE ECUENTRAN REGISTROS EN LA TABLA tmpdb..pint4'
            goto ERROR
        end

        /* REQ 217 AHORRO CONTRACTUAL - No. RANGOS A TRABAJAR */
        select @w_num_rango = isnull(cp_tipo_rango,2)
            from cob_remesas..pe_capitaliza_profinal
            where cp_profinal            = @w_cont_profinal
            and cp_tipo_capitalizacion = @w_tcapitalizacion

        /* DETERMINAR EL ULTIMO Y PENULTIMO RANGO ADEMAS LA MAXIMA TASA */
        select @w_ultimo_rango = max(rango)
            from #pint4

        select @w_penultimo_rango = max(rango)
            from #pint4
            where rango < @w_ultimo_rango

        select @w_tasa_maxima = max(valor)
            from #pint4

        -- SE UBICA EL ULTIMO RANGO DE INTERES PARA DETERMINAR LA TASA
        select  @w_rango_hasta = rango_hasta,
                @w_rango_desde = rango_desde
            from #pint4
            where rango = @w_ultimo_rango

        if @@rowcount = 0
        begin
            select  @w_error = 351504,
                    @w_msg = 'ERROR AL BUSCAR RANGO HASTA'
            select @w_flag_tasas = 0
            goto ERROR
        end

        -- SE UBICA EL PENULTIMO RANGO DE INTERES PARA DETERMINAR LA TASA A LA QUE SE DEBE PAGAR
        if @w_num_rango = 2 -- SOLO PARA PRODUCTOS CON DOS RANGOS             
        begin
            select @w_pen_rango_hasta = rango_hasta
                from #pint4
                where rango = @w_penultimo_rango

            if @@rowcount = 0
            begin
                select  @w_error = 351504,
                        @w_msg = 'ERROR AL BUSCAR PENULTIMO RANGO HASTA'
                select  @w_flag_tasas = 0
                goto ERROR
            end

            /* SI EL RANGO DESDE DEFINIDO ES MENOR QUE CERO SE SETEA EL VALOR EN CERO  */
            if @w_rango_desde < 0
                select @w_rango_desde = 0

            --NO EVALUAR CONTRA EL SALDO DESDE DEL ULTIMO RANGO SINO CONTRA EL SALDO HASTA DEL PENULTIMO RANGO
            if @w_pen_rango_hasta is null
                select @w_pen_rango_hasta = 0
        end --FIN - SOLO PARA PRODUCTOS CON DOS RANGOS

        if @w_debug = 'S'
        begin
			print '......'
            print '...... rango desde    : ' + convert(varchar, @w_rango_desde)
            print '...... rango hasta    : ' + convert(varchar, @w_rango_hasta)
            print '...... decimales      : ' + convert(varchar, @w_numdeci)
        end
        
        select  @w_filial_2 = @w_filial,
                @w_oficina_2 = @w_oficina,
                @w_producto_2 = @w_producto,
                @w_moneda_2 = @w_moneda,
                @w_prod_banc_2 = @w_prod_banc,
                @w_tipocta_2 = @w_tipocta,
                @w_categoria_2 = @w_categoria
    end

    select
        @w_procesado_ok     = 1,-- POR DEFAULT LA CUENTA FALLA
        @w_dev_idb          = 'N',
        @w_error            = 0,
        @w_tasa_imp         = 0,
        @w_tasa_impuesto    = 0,
        @w_tipo_exonerado_imp = '',
        @w_acumu_deb_total  = 0,
        @w_acumu_deb        = 0,
        @w_trn_code         = 271,
        @w_valor_reteica    = 0,
        @w_gmf_reteica      = 0,
        @w_total_reintegro  = 0,
        @w_gmf_reintegro_ica = 0,
        @w_gmf_reintegro    = 0

    -- CALCULO DE LA ALICUOTA PARA EL PROMEDIO
    select @w_alicuota = fp_alicuota
        from cob_ahorros..ah_fecha_promedio
        where fp_tipo_promedio = @w_tipo_promedio
        and fp_fecha_inicio  = @i_fecha

    if @@rowcount = 0
    begin
        select  @w_error = 251013,
                @w_msg = 'NO SE ENCUENTRAN REGISTROS EN LA TABLA ah_fecha_promedio'
        goto ERROR
    end

        -- Calcula saldo minimo del mes
    if @w_min_dispmes = -1
    begin
        if @w_disponible >= 0
            select @w_min_dispmes = @w_disponible
        else
            select @w_min_dispmes = 0
    end
    else if @w_disponible < @w_min_dispmes
        select @w_min_dispmes = @w_disponible

    select @w_contable = @w_12h + @w_24h + @w_disponible + @w_48h -- + @w_remesas

    /* CALCULO DE INTERES */
    select
        @w_valor_acreditar  = 0,
        @w_calculo_int      = 'N',
        @w_tasa_ayer        = @w_tasa_hoy,
        @w_contador_tasas   = 1,
        @w_flag_tasas       = 1,
        @w_monto_calculo    = 0,
        @w_monto_total      = 0,
        @w_rango_hasta_ant  = 0,
        @w_monto_interes    = 0,
        @w_tasa_interes_acum = 0,
        @w_monto_interes1   = 0,
        @w_monto_interes2   = 0,
        @w_total_reintegro  = 0,
        @w_gmf_reintegro_ica = 0,
        @w_gmf_reintegro    = 0

    if @w_tipo_atributo = 'B' /* Saldo promedio */
        select @w_monto = @w_promedio1
    else if @w_tipo_atributo = 'C' /* Saldo Contable */
        select @w_monto = @w_contable
    else if @w_tipo_atributo = 'A' /* Saldo Disponible */
        select @w_monto = @w_disponible
    else if @w_tipo_atributo = 'E' /* Promedio Disponible */   
        select @w_monto = @w_prom_disponible
    else if @w_tipo_atributo = 'D' /* Saldo minimo mensual */
        select @w_monto = @w_min_dispmes
    else
        select @w_monto = $1

    if @w_debug = 'S'
    begin 
		print '......'
        print '@w_tipo_atributo  ' + @w_tipo_atributo
        print '@w_monto          ' + cast (@w_monto as varchar ) 
    end

    -- --------------------------------------------------------------------------------------------------
    -- ADI REQ 217: AJUSTE DE MONTOS PARA UN SOLO RANGO -------------------------------------------------
    -- --------------------------------------------------------------------------------------------------
    if @w_num_rango = 1
    begin
        select @w_monto_interes1 = 0
        select @w_monto_interes2 = @w_monto
    end
    else
    begin
        if @w_monto > @w_pen_rango_hasta
        begin
            select @w_monto_interes1 = @w_monto - @w_pen_rango_hasta  -- lo que debe calcularse en el rango mas alto
            select @w_monto_interes2 = @w_pen_rango_hasta             -- lo que debe calcularse en el rango que le toque
        end
        else
        begin
            select @w_monto_interes1 = 0             -- lo que debe calcularse en el rango mas alto
            select @w_monto_interes2 = @w_monto      -- lo que debe calcularse en el rango que le toque
        end
    end
    -- ------------------------------------------------------------------------------------------------

    if @w_debug = 'S'
    begin
		print '......'
        print '@w_monto_interes1 ' + cast (@w_monto_interes1 as varchar) + '   @w_monto_interes2  ' + cast (@w_monto_interes2 as varchar)
        print '......'
	end


    
    
    -- ----------------------------------------------------------------------------------------------
    -- PERIODOS INCUMPLIMIENTO - AHORRO CONTRACTUAL -------------------------------------------------
    -- ----------------------------------------------------------------------------------------------
    if @w_es_contractual = 'S' and @w_categoria <> @w_camcat
    begin
        -- toma ultimo dia del periodo por periodicidad sin contar feriados
        select @w_ult_dia_mes_sinferiado = pe_fecha_fin
            from cob_ahorros..ah_periodo
            where pe_capitalizacion = @w_cont_periodicidad
            and pe_periodo          = (select datepart(mm,@i_fecha))

        while 1 = 1
        begin
            if exists (select 1 from cobis..cl_dias_feriados where  df_ciudad = @w_ciudad and df_fecha = @w_ult_dia_mes_sinferiado)
                select @w_ult_dia_mes_sinferiado = dateadd(dd, -1, @w_ult_dia_mes_sinferiado)
            else
                break
        end

        -- SI HOY ES EL ULTIMO DIA DEL MES ?? (CAPITALIZACION)
        if @i_fecha = @w_ult_dia_mes_sinferiado 
        begin
            -- toma ultimo dia del MES ANTERIOR sin contar feriados
            select @w_ult_dia_mes_ant_sinferiado = dateadd(dd,-datepart(dd,@i_fecha),@i_fecha)
            while 1 = 1
            begin
                if exists (select 1 from cobis..cl_dias_feriados where  df_ciudad = @w_ciudad and df_fecha = @w_ult_dia_mes_ant_sinferiado)
                    select @w_ult_dia_mes_ant_sinferiado = dateadd(dd,-1,@w_ult_dia_mes_ant_sinferiado)
                else
                    break
            end

            -- Hallar ULTIMO Saldo Mes Anterior
            select @w_fecha_saldo_ant = max(sd_fecha)
                from cob_ahorros_his..ah_saldo_diario
                where sd_cuenta = @w_cuenta
                and sd_fecha  <= @w_ult_dia_mes_ant_sinferiado

            if exists (select sd_saldo_disponible
                        from cob_ahorros_his..ah_saldo_diario
                        where sd_cuenta = @w_cuenta
                        and sd_fecha  = @w_fecha_saldo_ant)
                select @w_saldo_mes = (@w_disponible - isnull(sd_saldo_disponible,0))
                    from cob_ahorros_his..ah_saldo_diario
                    where sd_cuenta = @w_cuenta
                    and sd_fecha  = @w_fecha_saldo_ant
            else
                select @w_saldo_mes = @w_disponible

            -- INCUMPLIMIENTO POR CUOTA
            -- SALDO (inicio al fin de mes) < CUOTA Contractual
            if @w_saldo_mes < @w_cont_cuota
            begin
                -- INCUMPLIMIENTO POR CUOTA DEL MES
                select @w_cont_periodos_incump = @w_cont_periodos_incump + 1
            end
            else
            begin
                if @w_incumple_saldo = 'S'  -- Param: 'AHO' 'CUMSAL'
                begin
                    -- INCUMPLIMIENTO POR SALDO TOTAL ESPERADO (cuotas x mes)
                    select @w_meses = datediff(mm, @w_fecha_aper, @i_fecha) + 1
                    select @w_disponible_esp = (@w_cont_cuota * @w_meses)

                    if @w_disponible < @w_disponible_esp
                    begin
                        select @w_cont_periodos_incump = @w_cont_periodos_incump + 1
                    end
                end
            end
            if @w_debug = 'S'
            begin
                print '......'
                print '...... Periodos Incumplimiento --------------------------------------------'
                print '...... Ult Dia Per sin Saldo:  @w_ult_dia_mes_sinferiado     : ' + convert(varchar, @w_ult_dia_mes_sinferiado)
                print '...... Ult Dia Per sin Saldo:  @w_ult_dia_mes_ant_sinferiado : ' + convert(varchar, @w_ult_dia_mes_ant_sinferiado)
                print '...... hoy:  @i_fecha                                        : ' + convert(varchar, @i_fecha)
                print '...... fecha saldo mes ant:  @w_fecha_saldo_ant              : ' + convert(varchar, @w_fecha_saldo_ant)
                print '...... saldo mes ant: @w_saldo_mes                           : ' + convert(varchar, @w_saldo_mes)
                print '...... cuota:  @w_cont_cuota                                 : ' + convert(varchar, @w_cont_cuota)
                print '...... @w_cont_periodos_incump                               : ' + convert(varchar, @w_cont_periodos_incump)
                print '...... @w_incumple_saldo                                     : ' + convert(varchar, @w_incumple_saldo)
                print '...... @w_meses                                              : ' + convert(varchar, @w_meses)
                print '...... @w_disponible                                         : ' + convert(varchar, @w_disponible)
                print '...... @w_disponible_esp                                     : ' + convert(varchar, @w_disponible_esp)
                print '......'
            end     
        end
    end    
    -- FIN PERIODOS INCUMPLIMIENTO - AHORRO CONTRACTUAL --------------------------------------------------
  
  
  
  
  
  
  
    select  @w_tasa_interes = 0,
            @w_tasa_maxima = 0

    -- -------------------------------------------------------------------------------------------
    -- ----------- monto interes 1 ---------------------------------------------------------------
    -- -------------------------------------------------------------------------------------------      
    if @w_monto_interes1 > 0
    begin
        select @w_rango_busqueda = @w_rango_hasta - 1

        if @w_personalizada = 'N'
        begin /* Cuentas Normales */
            select @w_tasa_interes = valor / 100
                from #pint4
                where rango_desde <= @w_rango_busqueda
                and rango_hasta > @w_rango_busqueda

            if @@rowcount <> 1
            begin
                print 'Procesando ...7 ERROR EN TABLA TMP DE PERSONALIZACION'
                select  @w_error = 351504,
                        @w_msg = 'ERROR EN TABLA TMP DE PERSONALIZACION'
                goto ERROR
            end
        end
        else
        begin -- SI esta personalizada
            exec @w_error = cob_remesas..sp_genera_costos
                @i_fecha       = @i_fecha,
                @i_categoria   = @w_categoria,
                @i_tipo_ente   = @w_tipocta,
                @i_rol_ente    = @w_rol_ente,
                @i_tipo_def    = @w_tipo_def,
                @i_prod_banc   = @w_prod_banc,
                @i_producto    = @w_producto,
                @i_moneda      = @w_moneda,
                @i_tipo        = @w_tipo,
                @i_codigo      = @w_default,
                @i_servicio    = 'PINT',
                @i_rubro       = '18',
                @i_disponible  = @w_rango_busqueda,
                @i_contable    = @w_rango_busqueda,
                @i_promedio    = @w_rango_busqueda,
                @i_prom_disp   = @w_rango_busqueda,
                @i_personaliza = @w_personalizada,
                @i_filial      = @w_filial,
                @i_oficina     = @w_oficina,
                @i_batch       = 'S',
                @o_valor_total = @w_tasa_interes out

            if @w_error <> 0 or @@error <> 0
            begin
                select @w_msg = mensaje
                    from cobis..cl_errores
                    where numero = @w_return

                if @@rowcount = 0
                begin
                    select  @w_msg = 'ERROR EN CUENTA PERSONALIZADA AL EXTRAER COSTO',
                            @w_error = 351504
                end
                goto ERROR
            end
        end -- fin Personalizada

        select  @w_valor_acreditar  = 0,
                @w_factor1          = 0,
                @w_factor2          = 0,
                @w_factor           = 0,
                @w_total_reintegro  = 0

        if (@w_tasa_interes <> 0)
        begin
            --Convierte a tasa nominal (diaria)
            select @w_factor1 = 1 + @w_tasa_interes
            select @w_factor2 = (convert(float, 1)) / @w_dias_anio
            select @w_factor = (power (@w_factor1,@w_factor2)) - 1
            select @w_valor_acreditar = round((@w_monto_interes1 * @w_factor),@w_numdeci)
            select @w_valor_acreditar = @w_valor_acreditar * @w_dias_mes_act

            --PCOELLO ESTE IF SOLO VA A SER VERDADERO SI NO ENCONTRO TASA EN EL RANGO MAXIMO
            --SOLO SI NO ENCONTRO TASA EN EL RANGO ANTERIOR ACUMULA
            if @w_tasa_maxima = 0
                select @w_tasa_maxima = @w_tasa_interes

			if @w_debug = 'S'
			begin
				print 'monto interes 1'
				print '......'
				print '...... @w_tasa_interes ' + cast(@w_tasa_interes as varchar)
				print '...... @w_factor1 ' + cast(@w_factor1 as varchar) + ' @w_factor2 ' + cast(@w_factor1 as varchar) + ' @w_factor ' + cast(@w_factor as varchar)
				print '...... @w_valor_acreditar ' + cast(@w_valor_acreditar as varchar)
			end   			
        end
    end 
    -- fin monto interes 1 -----------------------------------------------------------------------

    select  @w_monto_interes = @w_monto_interes + @w_valor_acreditar
    select  @w_tasa_interes_acum = @w_tasa_interes_acum + @w_tasa_interes
    select  @w_tasa_interes     = 0,
            @w_valor_acreditar  = 0,
            @w_total_reintegro  = 0,
            @w_gmf_reintegro_ica = 0,
            @w_gmf_reintegro    = 0

    -- -------------------------------------------------------------------------------------------
    -- ----------- monto interes 2 ---------------------------------------------------------------
    -- -------------------------------------------------------------------------------------------
    if @w_monto_interes2 > 0
    begin
        if  @w_monto_interes1 > 0
            -- debe buscar en el rango inferior al maximo el saldo
            select @w_rango_busqueda = @w_rango_desde - 1
        else
            -- no llego al rango maximo busca el monto total en el rango que le toca
            select @w_rango_busqueda = @w_monto_interes2
            -- - 1 --PCOELLO RESTARLE UNO PARA QUE CAIGA EN EL RANGO ANTERIOR

        if @w_personalizada = 'N'
        begin /* Cuentas Normales */
            select @w_tasa_interes = valor / 100
                from #pint4
                where rango_desde <= @w_rango_busqueda
                and rango_hasta > @w_rango_busqueda

            /* ****PCOELLO SI EL VALOR COINCIDE CON EL RANGO HASTA NO LO ENCUENTRA Y LO CALCULA A TASA CERO LO CUAL ESTA MAL
            POR ESO SI NO ENCONTRO EN EL RANGO INDICADO, BUSCA EN EL RANGO CON EL VALOR MENOS UNO PARA QUE 
            ENCUENTRE LA TASA CORRECTA ******** */
            select @w_return = @@rowcount

            if @w_return <> 1
            begin
                print 'Procesando ...7 ERROR EN TABLA TMP DE PERSONALIZACION'
                select  @w_error = 351551,
                        @w_msg = 'Procesando ...7 ERROR EN TABLA TMP DE PERSONALIZACION'
                goto ERROR
            end

            if @w_return = 0
            begin
                if exists(select 1 from   #pint4) and @w_monto_interes1 = 0
                begin
                    select @w_rango_busqueda = @w_monto_interes2 - 1

                    --PCOELLO RESTARLE UNO PARA QUE CAIGA EN EL RANGO ANTERIOR
                    select @w_tasa_interes = valor / 100
                        from #pint4
                        where rango_desde <= @w_rango_busqueda
                        and rango_hasta > @w_rango_busqueda

                    if @@rowcount <> 1
                    begin
                        select  @w_error = 351551,
                                @w_msg = 'Procesando ...4ERROR EN TABLA TMP DE PERSONALIZACION ' + cast(@w_monto_interes1 as varchar) + ' ' + cast(@w_monto_interes2 as varchar)
                        goto ERROR
                    end
                end
                else
                begin
                    select  @w_error = 351551,
                            @w_msg = 'Procesando ...4..ERROR NO EXISTE RANGO TABLA TMP DE PERS.'
                    goto ERROR
                end
            end
        end
        else
        begin -- SI esta personalizada
            exec @w_return = cob_remesas..sp_genera_costos
                @i_fecha       = @i_fecha,
                @i_categoria   = @w_categoria,
                @i_tipo_ente   = @w_tipocta,
                @i_rol_ente    = @w_rol_ente,
                @i_tipo_def    = @w_tipo_def,
                @i_prod_banc   = @w_prod_banc,
                @i_producto    = @w_producto,
                @i_moneda      = @w_moneda,
                @i_tipo        = @w_tipo,
                @i_codigo      = @w_default,
                @i_servicio    = 'PINT',
                @i_rubro       = '18',
                @i_disponible  = @w_rango_busqueda,
                @i_contable    = @w_rango_busqueda,
                @i_promedio    = @w_rango_busqueda,
                @i_prom_disp   = @w_rango_busqueda,
                @i_personaliza = @w_personalizada,
                @i_filial      = @w_filial,
                @i_oficina     = @w_oficina,
                @i_batch       = 'S',
                @o_valor_total = @w_tasa_interes out

            if @w_return <> 0 or @@error <> 0
            begin
                print 'Procesando ...3----'
                select @w_msg = mensaje
                    from cobis..cl_errores
                    where numero = @w_return

                if @@rowcount = 0
                    select  @w_msg = 'ERROR EN CUENTA PERSONALIZADA AL EXTRAER COSTO',
                            @w_error = 351552
                else
                    select @w_error = @w_return
                goto ERROR
            end

			if @w_debug = 'S'
			begin
				print 'monto interes 2'
				print '......'
				print '...... @w_tasa_interes ' + cast(@w_tasa_interes as varchar)
			end 

        end -- fin Personalizada 

        select  @w_valor_acreditar  = 0,
                @w_factor1          = 0,
                @w_factor2          = 0,
                @w_factor           = 0,
                @w_total_reintegro  = 0,
                @w_gmf_reintegro_ica = 0,
                @w_gmf_reintegro    = 0

        select @w_ajuste = 0
	
        if (@w_tasa_interes <> 0)
        begin --Convierte a tasa nominal (diaria)
            
            /* INTERESES ADICIONALES - CONTRACTUALES */ 
            if @w_es_contractual = 'S'
            begin
                if (@w_es_contractual = 'S'
                    and @w_categoria <> @w_camcat -- no ha finalizado
                    and convert(varchar, @i_fecha, 101) >= convert(varchar, @w_ult_dia_cuota_sinferiado, 101 )
                    and ((@w_disponible + @w_saldo_interes >= @w_cont_monto_final and @w_incumple_saldo = 'S') or (@w_incumple_saldo = 'N'))
                    and @w_cont_periodos_incump = 0)
                begin
                    /* RECALCULO DE INTERESES - AHORRO CONTRACTUAL */
                    exec @w_error = sp_ahmensual_contract
                        @i_ssn           = @w_ssn,
                        @i_fecha         = @w_ult_dia_cuota_sinferiado,
                        @i_cuenta        = @w_cuenta,
                        @i_ptos_premio   = @w_cont_ptos_premio,
                        @i_tipo_atributo = @w_tipo_atributo,
                        @i_numdeci       = @w_numdeci,
                        @i_min_dispmes   = @w_min_dispmes,
                        @i_turno         = @i_turno,
                        @i_oficina       = @w_oficina,
                        @i_categoria     = @w_categoria,
                        @i_prod_banc     = @w_prod_banc,
                        @i_clase_clte    = @w_clase_clte,
                        @i_tipocta_super = @w_tipocta_super,
                        @i_moneda        = @w_moneda,
                        @i_cta_banco     = @w_cta_banco,
                        @i_cliente       = @w_cliente,
                        @i_tasa_pactada  = @w_tasa_interes,
                        @o_ajuste        = @w_ajuste out

                    if @w_error <> 0
                    begin
                        select @w_msg = 'ERROR sp_ahmensual_contract - RECALCULO DE INTERESES'
                        goto ERROR
                    end

					if @w_debug = 'S'
					begin
						print 'interes adicional CONTRACTUAL'
						print '......'
						print '...... @w_tasa_interes     ' + cast(@w_tasa_interes as varchar)
					end 					
                    select @w_tasa_interes = @w_tasa_interes + (convert(float, @w_cont_ptos_premio)/100)
					if @w_debug = 'S'
					begin
						print '...... @w_cont_ptos_premio ' + cast(@w_cont_ptos_premio as varchar)
						print '...... @w_tasa_interes     ' + cast(@w_tasa_interes as varchar)
						print '......'
					end 					

                end
            end
            /* FIN ADI REQ 217: SUMA DE INTERESES ADICIONALES */            
            
            select @w_factor1 = 1 + @w_tasa_interes
            select @w_factor2 = (convert(float, 1)) / @w_dias_anio
            select @w_factor = (power (@w_factor1,@w_factor2)) - 1
            select @w_valor_acreditar = round((@w_monto_interes2 * @w_factor),@w_numdeci)
            select @w_valor_acreditar = @w_valor_acreditar * @w_dias_mes_act

			if @w_debug = 'S'
			begin
				print 'monto interes 2'
				print '......'
				print '...... @w_tasa_interes ' + cast(@w_tasa_interes as varchar)
				print '...... @w_factor1 ' + cast(@w_factor1 as varchar)
				print '...... @w_factor2 ' + cast(@w_factor1 as varchar)
				print '...... @w_factor  ' + cast(@w_factor as varchar)
				print '...... @w_valor_acreditar ' + cast(@w_valor_acreditar as varchar)
			end        			
        end
    end

    -- fin monto interes 2 -----------------------------------------------------------------------

    
    
    
    

    
    /* **************************************************************** */
    select @w_monto_interes = @w_monto_interes + @w_valor_acreditar
    select @w_tasa_interes_acum = @w_tasa_interes_acum + @w_tasa_interes

    if @w_monto_interes1 > 0
        select @w_tasa_interes_acum = @w_tasa_interes_acum / 2

    select @w_monto_interes = round(@w_monto_interes,@w_numdeci)
    select @w_valor_acreditar = @w_monto_interes

    -- Calculo de la tasa aplicada en base al valor de interes obtenido en los pasos anteriores
    if ((@w_dias_mes_act <> 0) and (@w_monto <> 0) and (@w_valor_acreditar <> 0))
        if @w_num_rango > 1
            select @w_tasa_interes = ((convert(real, @w_valor_acreditar) / convert(real, @w_dias_mes_act)) / convert(real, @w_monto)) * convert(real, @w_dias_anio)
        else
            select @w_tasa_interes = @w_factor * @w_dias_anio
    else
        select @w_tasa_interes = 0
        
    if @w_tasa_interes > 0
        select @w_calculo_int = 'S'
    else
        select  @w_valor_acreditar = 0,
                @w_calculo_int = 'N'

    -- JTA - SI no Producto NO CAPITALIZA no guarda valores calculados de provision
    if @w_pf_provisiona = 'N'
        select  @w_saldo_interes    = 0,
                @w_valor_acreditar  = 0,
                @w_ajuste           = 0,
                @w_tasa_interes     = 0,
                @w_calculo_int      = 'N'
    
    -- Nuevos saldos de interes
    select  @w_saldo_interes = @w_saldo_interes + @w_valor_acreditar + isnull(@w_ajuste,0),
            @w_int_hoy = @w_valor_acreditar,
            @w_tasa_hoy = round((@w_tasa_interes * 100),@w_numdeci),
            @w_int_mes = @w_int_mes + @w_valor_acreditar + isnull(@w_ajuste, 0)
    
    -- ASIGNA INTERESES A CONTRACTUAL
    if (@w_es_contractual = 'S' and @w_ult_dia_mes_sinferiado = @i_fecha and @w_categoria <> @w_camcat)
        select @w_cont_intereses = @w_cont_intereses + isnull(@w_saldo_interes, 0)


    if @w_debug = 'S'
    begin
        print '-------------------------------------------------------------------------'
        print ' CALCULO DE INTERESES ---------------------------------------------------'
        print '-------------------------------------------------------------------------'
        print '...... PRVDIA:                 : ' + @w_prov_diaria
        print '...... pf_provisiona:          : ' + @w_pf_provisiona
        print '...... w_fecha_ult_mov_int     : ' + cast (@w_fecha_ult_mov_int as varchar)
        print '...... @w_cta_aporte_social    : ' + convert(varchar, @w_cta_aporte_social)      
        print '...... @w_saldo_interes        : ' + cast (@w_saldo_interes as varchar)
		print '...... @w_cont_intereses       : ' + cast (@w_cont_intereses as varchar)
        print '...... @w_int_hoy              : ' + cast (@w_int_hoy as varchar)
        print '...... @w_tasa_hoy             : ' + cast (@w_tasa_hoy as varchar)
        print '...... @w_tasa_interes         : ' + cast (@w_tasa_interes as varchar)
        print '...... @w_dias_mes_act         : ' + cast (@w_dias_mes_act as varchar)
        print '...... @i_fecha                : ' + cast (@i_fecha as varchar)
        print '...... @w_ajuste               : ' + cast (@w_ajuste as varchar)
        print '...... @w_int_mes              : ' + cast (@w_int_mes as varchar)
        print '...... @w_cta_aporte_social    : ' + cast (@w_cta_aporte_social as varchar)
        print '......-----------------------------------------------'               
        print '...... @w_fecha_prx_capita     : ' + cast( @w_fecha_prx_capita  as varchar)      
        print '...... @i_fecha                : ' + cast( @i_fecha  as varchar)     
        print '......-----------------------------------------------'       
    end
    /* FIN CALCULO DE INTERES */
    
	
	
	


    if @w_fecha_prx_capita > @i_fecha
        goto CAMBIA_FECHA_CAP  -- No capitaliza, revisa periodos de incumplimiento y actualiza fecha de prox capitalizacion

    /* *************************************************** */
    /* *******  EFECTUA  CAPITALIZACION  ***************** */
    /* *************************************************** */
    select @w_valor_impuesto = 0

    if @w_saldo_interes > 0 
    begin
        if @w_debug = 'S'
            print '*************** Entra a capitalizar ****************'

        /* ** Preguntar si el cliente es sujeto de retencion ** */
        select @w_retencion = isnull(en_retencion,'N')
            from cobis..cl_ente
            where en_ente = @w_cliente

        if @@rowcount = 0
        begin
            select @w_error = 121032,
                   @w_msg = 'NO EXISTE EL CLIENTE:' + convert(varchar, @w_cliente)
            goto ERROR
        end

        select @w_dias_capi = abs(datediff(dd,@w_fecha_ult_capi,@w_fecha_prx_capita))
        select @w_base_rtfte = @w_dias_capi * @w_binc 

        if @w_debug = 'S'
        begin
            print '......------------------------------------------------'
            print '...... @w_cpto_rte       : ' + cast (@w_cpto_rte as varchar)
            print '...... @w_base_rtfte     : ' + cast (@w_base_rtfte as varchar)
            print '...... @w_saldo_interes  : ' + cast (@w_saldo_interes as varchar)
            print '...... @w_filial         : ' + cast (@w_filial as varchar)
            print '...... @w_oficina        : ' + cast (@w_oficina as varchar)
            print '...... @w_cliente        : ' + cast (@w_cliente as varchar)
            print '......------------------------------------------------'
        end
        
        if @w_cpto_rte is not null and @w_saldo_interes >= @w_base_rtfte
        begin
            --Calculo tasa retefuente - interfaz con contabilidad en variable @w_tasa_impuesto
            exec @w_error = cob_interfase..sp_icon_impuestos
                @i_empresa      = @w_filial,
                @i_concepto     = @w_cpto_rte,
                @i_debcred      = 'D',
                @i_monto        = @w_saldo_interes,
                @i_impuesto     = 'R',--Verificar nemonico tipo de impuesto
                @i_oforig_admin = @w_oficina,
                @i_ofdest_admin = @w_oficina,
                @i_ente         = @w_cliente,
                @i_producto     = 4,
                @o_exento       = @w_exento out,
                @o_porcentaje   = @w_porcentaje out
            
            if @w_error <> 0
            begin
                select @w_msg = 'ERROR INTERFAZ sp_icon_impuestos - CALCULO DE RETENCION'
                goto ERROR
            end
        
            if  @w_exento = 'N'
                select @w_tasa_impuesto = (@w_porcentaje / 100)
            else
                select @w_tasa_impuesto = 0
        end

        if @w_debug = 'S'
        begin
            print '......------------------------------------------------'
            print '...... @w_exento ' + cast (@w_exento as varchar)
            print '...... @w_porcentaje  ' + cast (@w_porcentaje as varchar)
            print '...... @w_tasa_impuesto  ' + cast (@w_tasa_impuesto as varchar)
            print '......------------------------------------------------'
        end

        if @w_tasa_impuesto is null
        begin
            select @w_tasa_impuesto = 0

            if @w_tasa_imp > 0
                select @w_valor_impuesto = round((@w_saldo_interes * @w_tasa_imp),@w_numdeci_imp)
            else
                select @w_valor_impuesto = 0

            select @w_tasa_imp_usado = @w_tasa_imp
        end
        else
        begin
            select @w_tasa_imp = 0

            if @w_tasa_impuesto > 0
            begin
                if @w_exencion_isr = 'S' and @w_cobro_isr = 'S'
                begin
                    select @w_valor_exencion_isr = @w_salario_minimo * @w_num_anualidades * 12

                    if @w_saldo_interes > @w_valor_exencion_isr
                        select @w_valor_grabado = @w_saldo_interes - @w_valor_exencion_isr
                    else
                        select @w_valor_grabado = 0

                    if @w_valor_grabado > 0
                        select @w_valor_impuesto = round((@w_valor_grabado * @w_tasa_impuesto / @w_dias_anio),@w_numdeci)
                end
                else
                    if @w_exencion_isr = 'N' and @w_cobro_isr = 'S'
                        select @w_valor_impuesto = round((@w_saldo_interes * @w_tasa_impuesto / @w_dias_anio),@w_numdeci)
            end
            else
                select @w_valor_impuesto = 0
                select @w_tasa_imp_usado = @w_tasa_impuesto
        end

        if @w_debug = 'S'
        begin
            print '......------------------------------------------------'
            print '...... @w_tasa_imp_gral ' + cast (@w_tasa_imp_gral as varchar)
            print '...... @w_tasa_imp  ' + cast (@w_tasa_imp as varchar)
            print '......------------------------------------------------'
        end

        if (@w_tasa_imp_gral > 0 and (@w_tasa_impuesto > 0 or @w_tasa_imp > 0) )
        begin
            /* Verificar que la cuenta este exonerada  de IDB*/
            select @w_tipo_exonerado_imp = ei_tipo_exonerado_imp
                from cob_remesas..re_exoneracion_impuesto
                where ei_producto   = 'AHO'
                and ei_cuenta       = @w_cuenta

            if @@rowcount = 1 -- Cuenta exonerada
                select @w_tasa_imp_gral = 0.0
        end

        /* CALCULO DEL MONTO DE IDB */
        if (@w_tasa_imp_gral > 0 and (@w_tasa_impuesto > 0 or @w_tasa_imp > 0) )
            select @w_imp2 = round((@w_valor_impuesto * @w_tasa_imp_gral),@w_numdeci_imp)
        else
            select @w_imp2 = $0

        if @w_debug = 'S'
        begin
            print '......------------------------------------------------'
            print '...... @w_valor_impuesto ' + cast (@w_valor_impuesto as varchar)
            print '......------------------------------------------------'
        end
        ---------------------------------------
        -- IMPUESTO   -------------------------
        ---------------------------------------
        if @w_valor_impuesto > 0
        begin
            --Calculo de cliente exonerado GMF
            select  @w_total_gmf        = 0,
                    @w_base_gmf         = 0,
                    @w_gmf_reintegro    = 0,
                    @w_total_reintegro  = 0

            if @w_codigo_pais = 'CO' -- Colombia
            begin
			exec @w_return = cob_ahorros..sp_calcula_gmf
				@s_date            = @i_fecha,
				@i_cliente         = @w_cliente,--JCO
				@i_cuenta          = @w_cuenta,
				@i_cta             = @w_cta_banco,
				@i_operacion       = 'Q',
				@i_val             = @w_valor_impuesto,
				@o_total_gmf       = @w_total_gmf out,
				@o_acumu_deb       = @w_acumu_deb out,
				@o_base_gmf        = @w_base_gmf out,
				@o_actualiza       = @w_actualiza out,
				@o_tasa_reintegro  = @w_tasa_reintegro out,--JCO
				@o_valor_reintegro = @w_gmf_reintegro out -- JCO 
			end

			select @w_imp2 = @w_imp2 + @w_total_gmf
			select @w_gmf_impuesto = @w_total_gmf
			select @w_acumu_deb_total = @w_acumu_deb
			select @w_base_gmf_imp = @w_base_gmf
			select @w_total_reintegro = isnull(@w_gmf_reintegro,0)

			if @w_debug = 'S'
			begin
				print 'Valor dela Retencion ' + cast ( @w_valor_impuesto as varchar) + ' Valor del gmf: '+ cast (@w_total_gmf as varchar)
			end
		end

		---------------------------------------
		-- TASA DE RETEICA  -------------------
		---------------------------------------
		if @w_cpto_rteica is not null
		begin
			exec @w_error = cob_interfase..sp_icon_impuestos
				@i_empresa      = @w_filial,
				@i_concepto     = @w_cpto_rteica,
				@i_debcred      = 'D',
				@i_monto        = @w_saldo_interes,
				@i_impuesto     = 'C',
				@i_oforig_admin = @w_oficina,
				@i_ofdest_admin = @w_oficina,
				@i_ente         = @w_cliente,
				@i_ciudad       = @w_ciudad_rte_ica,
				@i_producto     = 4,
				@o_exento       = @w_exento out,
				@o_porcentaje   = @w_porcentaje out

			if @w_error <> 0
			begin
				select @w_msg = 'ERROR INTERFAZ sp_icon_impuestos - CALCULO DE RETEICA'
				goto ERROR
			end

			if @w_exento = 'N'
				select @w_tasa_reteica = round((@w_porcentaje / 100),@w_numdeci_imp)
			else
				select @w_tasa_reteica = 0

			if @w_tasa_reteica > 0
				select @w_valor_reteica = round((@w_saldo_interes * @w_tasa_reteica),@w_numdeci_imp)
			else
				select @w_valor_reteica = 0
		end
		else
			select @w_valor_reteica = 0

		if @w_valor_reteica > 0
		begin
			--Calculo de cliente exonerado GMF
			select  @w_total_gmf = 0,
					@w_base_gmf = 0,
					@w_gmf_reintegro_ica = 0

			if @w_codigo_pais = 'CO'
			begin -- Colombia
				exec @w_error = cob_ahorros..sp_calcula_gmf
					@s_date            = @i_fecha,
					@i_cuenta          = @w_cuenta,
					@i_operacion       = 'Q',
					@i_cta             = @w_cta_banco,
					@i_val             = @w_valor_reteica,
					@i_cliente         = @w_cliente,--JCO
					@o_total_gmf       = @w_total_gmf out,
					@o_acumu_deb       = @w_acumu_deb out,
					@o_base_gmf        = @w_base_gmf out,
					@o_actualiza       = @w_actualiza out,
					@o_tasa_reintegro  = @w_tasa_reintegro out,--JCO
					@o_valor_reintegro = @w_gmf_reintegro_ica out -- JCO 

				if @w_error <> 0
				begin
					select @w_msg = 'ERROR INTERFAZ sp_icon_impuestos - CALCULO DE RETEICA'
					goto ERROR
				end
			end

			select @w_imp2 = @w_imp2 + @w_total_gmf
			select @w_gmf_reteica = @w_total_gmf
			select @w_base_gmf_ica = @w_base_gmf
			select @w_acumu_deb_total = @w_acumu_deb_total + @w_acumu_deb
			select @w_total_reintegro = isnull(@w_total_reintegro, 0) + isnull(@w_gmf_reintegro_ica, 0)

			if @w_debug = 'S'
			begin
				print 'Valor del Reteica ' + cast ( @w_valor_reteica as varchar) + ' Valor del gmf: ' + cast (@w_total_gmf as varchar)
			end
		end

		if (@s_ssn is null)
		begin
			select @w_is_batch = 'S'
			exec @w_ssn_aut = ADMIN...rp_ssn
		end
		else
		begin
			select @w_is_batch = 'N'
			select @w_ssn_aut = @s_ssn
		end
			
		if @w_commit = 'N'
		begin
			begin tran
			select @w_commit = 'S'
		end

		/* ********************************************* */
		/*  ACTUALIZAR INTERESES EN CUENTA CONTRACTUAL   */
		/* ********************************************* */
		if @w_es_contractual = 'S'
		begin
			update cob_remesas..re_cuenta_contractual
			set cc_intereses = @w_cont_intereses
			where cc_cta_banco  = @w_cta_banco
			and cc_estado       = 'A'

			if @@error <> 0
			begin
				select  @w_error = 0,
						@w_msg = 'ERROR EN ACTUALIZACION CONDICIONES CUENTA CONTRACTUAL'
				goto ERROR
			end
		end

		/* ***** */
		/*  GMF  */
		/* ***** */
		if @w_codigo_pais = 'CO'
		begin -- Colombia -- Actualiza acumulados topes gmf 
			if @w_actualiza = 'S' and isnull(@w_acumu_deb_total,0) <> 0
			begin
				exec @w_error = sp_calcula_gmf
					@s_date      = @i_fecha,
					@i_cuenta    = @w_cuenta,
					@i_producto  = @w_producto,
					@i_operacion = 'U',
					@i_acum_deb  = @w_acumu_deb

				if @w_error <> 0
				begin
					select @w_msg = 'ERROR ACTUALIZANDO BASE GMF'
					goto ERROR
				end
			end
		end

		select @w_fecha_ult_mov_int = @i_fecha
		select @w_fecha_ult_capi = @i_fecha

		if @w_cta_aporte_social = 'N' 
		begin     
			select @w_total_interes = round(@w_saldo_interes,@w_numdeci) --JAR 14/01/2010
			select @w_prom_disponible = @w_prom_disponible+ convert(money, round((@w_total_interes * @w_alicuota),@w_numdeci))
			select @w_promedio1 = @w_promedio1 + convert(money, round((@w_total_interes *@w_alicuota), @w_numdeci))

			select @w_saldo_interes = round(@w_saldo_interes,@w_numdeci)

			select @w_disponible = @w_disponible + @w_saldo_interes
			select @w_contable = @w_contable + @w_saldo_interes

			if @w_estado = 'I'
				select @w_trn_code = 304
			else
				select @w_trn_code = 221
		  
			select @w_saldo_interes_tot = @w_saldo_interes_tot + @w_saldo_interes

			if @w_debug = 'S'
			begin
				print '......------------------------------------------------'
				print '...... NO ES APORTE SOCIAL '
				print '...... @w_trn_code           : ' + cast (@w_trn_code as varchar)
				print '...... @w_disponible         : ' + cast (@w_disponible as varchar)
				print '...... @w_total_interes      : ' + cast (@w_total_interes as varchar)
				print '...... @w_saldo_interes      : ' + cast (@w_saldo_interes as varchar)
				print '...... @w_saldo_interes_tot  : ' + cast (@w_saldo_interes_tot as varchar)
				print '......------------------------------------------------'
			end             
			-- Inserta transaccion monetaria de capitalizacion ---
			insert into ah_notcredeb
					(secuencial, ssn_branch, alterno, tipo_tran, oficina,
					usuario, terminal, correccion, sec_correccion, reentry,
					origen, nodo, fecha, cta_banco, signo,
					indicador, remoto_ssn, moneda, causa, interes,
					valor, saldocont, saldodisp, oficina_cta, filial,
					prod_banc, categoria, monto_imp, tipo_exonerado, hora,
					tipocta_super, turno, canal, cliente, clase_clte)
				values
					(@w_ssn, @w_ssn, 1, @w_trn_code, @w_oficina,
					'op_batch', 'consola', 'N', null, 'N',
					'L', @i_srv, @i_fecha, @w_cta_banco, 'C',
					1, null, @w_moneda, null, null,
					@w_saldo_interes, @w_contable, @w_disponible, @w_oficina, @w_filial,
					@w_prod_banc, @w_categoria, null, null, getdate(),
					@w_tipocta_super, @i_turno, @i_canal, @w_cliente, @w_clase_clte)

			if @@error <> 0
			begin
				select  @w_error = 255004,
						@w_msg = 'ERROR AL INSERTAR LA NOTA DE DEBITO (1)'
				goto ERROR
			end
		end
		
		if @w_cta_aporte_social = 'S' 
		begin
			if (@s_ssn_branch is null)
				select @s_ssn_branch = @w_ssn_aut
				
			if (@s_user is null)
				select @s_user = 'op_batch'
				
			if (@s_date is null)
				select @s_date = @i_fecha
				
			if (@s_srv is null)
				select @s_srv = @i_srv

			if @w_debug = 'S'
			begin
				print '......------------------------------------------------'
				print '...... APORTE SOCIAL ADICIONAL - DEPOSITO RELACIONADO'
				print '...... @w_cta_plazo         : ' + cast (@w_cta_plazo as varchar)
				print '...... @w_saldo_interes     : ' + cast (@w_saldo_interes as varchar)
				print '......------------------------------------------------'
			end
			-- JTA - Cuentas de Producto de APORTE SOCIAL ADICIONAL capitalizan en cuenta relacionada mediante Nota de Debito
			if (@w_saldo_interes > 0)  -- (datediff(dd,@w_fecha_ult_mov,@i_fecha) < @w_cta_plazo)
			begin                       
				exec  @w_return = cob_ahorros..sp_ahndc_automatica
					@s_srv          = @s_srv,
					@s_ofi          = @w_oficina,
					@s_ssn          = @w_ssn_aut,
					@s_ssn_branch   = @s_ssn_branch,
					@s_user         = @s_user,
					@s_org          = @s_org,
					@t_trn          = 253,
					@i_is_batch     = @w_is_batch,
					@i_cta          = @w_cta_banco_rel,
					@i_val          = @w_saldo_interes,
					@i_cau          = '17',   -- Transferencias de Saldos 
					@i_mon          = @w_moneda,
					@i_fecha        = @s_date,
					@i_canal        = 4 

				if @w_return <> 0
				begin
					select @w_msg = mensaje
						from cobis..cl_errores
						where numero = @w_return

					--rollback tran 
					print 'Procesando 1 ... Error EJECUCION NOTA CREDITO A CUENTA RELACIONADA'
					select  @w_error = @w_return,
							@w_msg = isnull(@w_msg, 'Error') + ' - EJECUCION NOTA CREDITO A CUENTA RELACIONADA'
					goto ERROR
				end
			end
		end

		select @w_trn = 379 --GMF SOBRE RENDIMIENTOS A CARGO DEL BANCO

		select @w_gmfbco = round((isnull(@w_saldo_interes,0) * isnull(@w_tasagmf,0)),@w_numdeci_imp)
		if @w_debug = 'S'
			print 'Valor GMF para el banco ' + cast (@w_gmfbco as varchar)

		insert into ah_acumulador
				(ac_oficina, ac_moneda, ac_prod_banc, ac_categoria, ac_ssn,
				ac_usuario, ac_terminal, ac_trn, ac_fecha, ac_reentry,
				ac_origen, ac_cta_banco, ac_intereses, ac_tipocta_super,
				ac_clase_clte)
			values
				(@w_oficina, @w_moneda, @w_prod_banc, @w_categoria, @w_ssn,
				'op_batch', 'consola', @w_trn, @i_fecha, 'N',
				'U', '0', @w_gmfbco, @w_tipocta_super, @w_clase_clte)

		if @@error <> 0
		begin
			select  @w_error = 255004,
					@w_msg = 'Procesando ...8 ERROR INSERTAR ACUMULADO DE GMF'
			goto ERROR
		end

		select @w_pro_final = pf_pro_final
			from #tmp_profinal
			where me_tipo_ente  = @w_tipocta
			and me_pro_bancario = @w_prod_banc
			and pf_filial       = @w_filial
			and pf_sucursal     = @w_sucursal
			and pf_producto     = @w_producto
			and pf_moneda       = @w_moneda
			and pf_tipo         = @w_tipo

		if @@rowcount = 0
		begin
			select  @w_error = 351527,
					@w_msg = 'NO EXISTE PRODUCTO FINAL - VERIFICA POSTEO'
			goto ERROR
		end

		select @w_posteo = cp_posteo
			from cob_remesas..pe_categoria_profinal
			where cp_profinal  = @w_pro_final
			and cp_categoria = @w_categoria

		if @w_posteo is null
			select @w_posteo = 'N'

		if @w_posteo = 'S'
		begin
			/* Insertar Linea Pendiente de capitalizacion */
			select  @w_lineas = @w_lineas + 1,
					@w_control = @w_control + 1,
					@w_lp_sec = @w_lp_sec + 4

			if @w_control > 9999
				select @w_control = 0

			if @w_lp_sec > 2147483640
				select @w_lp_sec = @i_sec

			insert into ah_linea_pendiente
					(lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha,
					lp_control, lp_signo, lp_enviada)
				values
					(@w_cuenta, @w_lp_sec, 'INT', @w_saldo_interes, @i_fecha,
					@w_control, 'C', 'N')

			if @@error <> 0
			begin
				select  @w_error = 351527,
						@w_msg = 'ERROR EN INSERCION DE LINEA PENDIENTE 1'
				goto ERROR
			end
		end

		-- ------------------------------------------
		-- Retención de Impuesto --------------------
		-- ------------------------------------------
		if (@w_retencion = 'S' and @w_valor_impuesto > 0)
		begin
			/* *** Manejo del disponible y contable restando solo el impuesto de retencion *** */
			if @w_debug = 'S'
				print 'SALDO DISPONIBLE RETENCION ' + cast(@w_disponible as varchar) + ' Valor imp ' + cast (@w_valor_impuesto as varchar) + ' gmf impuesto ' + cast (@w_gmf_impuesto as varchar)

			select @w_disponible_imp = @w_disponible - @w_valor_impuesto - @w_gmf_impuesto
			select @w_contable_imp = @w_contable - @w_valor_impuesto - @w_gmf_impuesto

			select @w_disponible = isnull(@w_disponible_imp,0) - isnull(@w_valor_reteica,0) - isnull(@w_gmf_reteica,0)
			select @w_contable = isnull(@w_contable_imp,0) - isnull(@w_valor_reteica,0) - isnull(@w_gmf_reteica,0)

			select @w_prom_disponible = @w_prom_disponible - convert(money, round(((@w_valor_impuesto + @w_gmf_impuesto) * @w_alicuota),@w_numdeci))
			select @w_promedio1 = @w_promedio1 - convert(money,round(((@w_valor_impuesto+@w_gmf_impuesto) * @w_alicuota),@w_numdeci))

			if @w_estado = 'I'
				select @w_trn_code = 309
			else
				select @w_trn_code = 308

			if @w_debug = 'S'
			begin
				print '......------------------------------------------------'
				print '...... RETENCION IMPUESTO '
				print '...... @w_retencion ' + cast (@w_retencion as varchar)
				print '...... @w_valor_impuesto  ' + cast (@w_valor_impuesto as varchar)
				print '...... @w_trn_code ' + cast (@w_trn_code as varchar)
				print '...... @w_contable  ' + cast (@w_contable as varchar)
				print '...... @w_promedio1  ' + cast (@w_promedio1 as varchar)
				print '...... @w_disponible  ' + cast (@w_disponible as varchar)
				print '...... @w_prom_disponible  ' + cast (@w_prom_disponible as varchar)
				print '...... @w_valor_reteica  ' + cast (@w_valor_reteica as varchar)                   
				print '......------------------------------------------------'
			end
				
			/* Inserta transaccion monetaria de retencion de IPF */                  
			insert into ah_notcredeb
					(secuencial, ssn_branch, alterno, tipo_tran, oficina,
					usuario, terminal, correccion, sec_correccion, reentry,
					origen, nodo, fecha, cta_banco, signo,
					indicador, remoto_ssn, moneda, causa, interes,
					valor, val_cheque, saldocont, saldodisp, oficina_cta,
					filial, prod_banc, categoria, monto_imp, tipo_exonerado,
					hora, tipocta_super, turno, canal, cliente,
					base_gmf, clase_clte)
				values
					(@w_ssn, @w_ssn, 2, @w_trn_code, @w_oficina,
					'op_batch', 'consola', 'N', null, 'N',
					'L', @i_srv, @i_fecha, @w_cta_banco, 'D',
					1, null, @w_moneda, null, @w_saldo_interes,
					@w_valor_impuesto, @w_tasa_imp_usado, @w_contable_imp,
					@w_disponible_imp, @w_oficina,
					@w_filial, @w_prod_banc, @w_categoria, @w_gmf_impuesto,
					@w_tipo_exonerado_imp,
					getdate(), @w_tipocta_super, @i_turno, @i_canal, @w_cliente,
					@w_base_gmf_imp, @w_clase_clte)

			if @@error <> 0
			begin
				select  @w_error = 0,
						@w_msg = 'ERROR EN INSERCION DE TRANSACCION MONETARIA RETENCION'
				goto ERROR
			end
		end

		if @w_valor_reteica > 0
		begin
			select @w_trn_code = 334
			if @w_debug = 'S'
				print 'SALDO DISPONIBLE PARA RETEICA  ' + cast(@w_disponible as varchar) + ' Reteica ' + cast (@w_valor_reteica as varchar) + ' gmf impuesto ' + cast (@w_gmf_reteica as varchar)

			select @w_prom_disponible = @w_prom_disponible - convert(money, round(((@w_valor_reteica+ @w_gmf_reteica) * @w_alicuota),@w_numdeci))
			select @w_promedio1 = @w_promedio1 - convert(money,round(((@w_valor_reteica + @w_gmf_reteica) * @w_alicuota),@w_numdeci))

			/* Inserta transaccion de servicio para reteica */
			insert into ah_notcredeb
					(secuencial, ssn_branch, alterno, tipo_tran, oficina,
					usuario, terminal, correccion, sec_correccion, reentry,
					origen, nodo, fecha, cta_banco, signo,
					indicador, remoto_ssn, moneda, causa, interes,
					valor, val_cheque, saldocont, saldodisp, oficina_cta,
					filial, prod_banc, categoria, monto_imp, tipo_exonerado,
					hora, tipocta_super, turno, canal, cliente,
					base_gmf, clase_clte)
				values
					(@w_ssn, @w_ssn, 3, @w_trn_code, @w_oficina,
					'op_batch', 'consola', 'N', null, 'N',
					'L', @i_srv, @i_fecha, @w_cta_banco, 'D',
					1, null, @w_moneda, null, @w_saldo_interes,
					@w_valor_reteica, @w_tasa_imp_usado, @w_contable, @w_disponible, @w_oficina,
					@w_filial, @w_prod_banc, @w_categoria, @w_gmf_reteica, @w_tipo_exonerado_imp,
					getdate(), @w_tipocta_super, @i_turno, @i_canal, @w_cliente,
					@w_base_gmf_ica, @w_clase_clte)

			if @@error <> 0
			begin
				select  @w_error = 0,
						@w_msg = 'ERROR EN INSERCION DE TRANSACCION MONETARIA RETEICA'
				goto ERROR
			end
		end

		if @w_valor_impuesto > 0 and @w_posteo = 'S'
		begin
			/* Insertar Linea Pendiente de Retencion */
			select  @w_control = @w_control + 1,
					@w_lp_sec = @w_lp_sec + 4,
					@w_lineas = @w_lineas + 1

			if @w_control > 9999
				select @w_control = 1

			if @w_lp_sec > 2147483640
				select @w_lp_sec = @i_sec

			insert into ah_linea_pendiente
					(lp_cuenta,lp_linea,lp_nemonico,lp_valor,lp_fecha,
					lp_control,lp_signo,lp_enviada)
				values
					( @w_cuenta,@w_lp_sec,'RET',@w_valor_impuesto,@i_fecha,
					@w_control,'D','N')

			if @@error <> 0
			begin
				select  @w_error = 0,
						@w_msg = 'ERROR EN INSERCION DE LINEA PENDIENTE 2'
				goto ERROR
			end
		end

		if @w_imp2 > 0 and @w_posteo = 'S'
		begin
			/* Insertar Linea Pendiente de IDB */
			select @w_control = @w_control + 1,
					@w_lp_sec = @w_lp_sec + 4,
					@w_lineas = @w_lineas + 1

			if @w_control > 9999
				select @w_control = 0

			if @w_lp_sec > 2147483640
				select @w_lp_sec = @i_sec

				insert into ah_linea_pendiente
					(lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha,
					lp_control, lp_signo, lp_enviada)
				values
					(@w_cuenta, @w_lp_sec, 'IDB', @w_imp2, @i_fecha,
					@w_control, 'D', 'N')

            if @@error <> 0
            begin
                select  @w_error = 0,
                        @w_msg = 'ERROR EN INSERCION DE LINEA PENDIENTE 3'
                goto ERROR
            end
        end 

        if @w_total_reintegro > 0
        begin
            select  @w_contable = @w_contable + @w_total_reintegro,
                    @w_disponible = @w_disponible + @w_total_reintegro,
                    @w_prom_disponible = @w_prom_disponible + convert(money, round((@w_total_reintegro * @w_alicuota) , @w_numdeci)),
                    @w_promedio1 = @w_promedio1 + convert(money, round((@w_total_reintegro * @w_alicuota), @w_numdeci))

            insert into ah_notcredeb
                    (secuencial, ssn_branch, alterno, tipo_tran, oficina,
                    usuario, terminal, correccion, sec_correccion, reentry,
                    origen, nodo, fecha, cta_banco, signo,
                    indicador, remoto_ssn, moneda, causa, valor,
                    saldocont, saldodisp, oficina_cta, filial, prod_banc,
                    categoria, tipo_exonerado, hora, tipocta_super, turno,
                    canal, cliente, clase_clte)
                values
                    (@w_ssn, @w_ssn, 4, 253, @w_oficina,
                    'op_batch', 'consola', 'N', null, 'N',
                    'L', @i_srv, @i_fecha, @w_cta_banco, 'C',
                    1, null, @w_moneda, '20', @w_total_reintegro,
                    @w_contable, @w_disponible, @w_oficina, @w_filial, @w_prod_banc,
                    @w_categoria, @w_tipo_exonerado_imp, getdate(), @w_tipocta_super,
                    @i_turno, @i_canal, @w_cliente, @w_clase_clte)

            if @@error <> 0
            begin
                select  @w_error = 0,
                        @w_msg = 'ERROR EN INSERCION DE TRANSACCION MONETARIA REINTEGRO GMF'
                goto ERROR
            end

            if @w_posteo = 'S'
            begin
                select @w_nemo = tn_nemonico
                    from cobis..cl_ttransaccion
                    where tn_trn_code = 253

                /* Insertar Linea Pendiente de IDB */
                select  @w_control = @w_control + 1,
                        @w_lp_sec = @w_lp_sec + 4,
                        @w_lineas = @w_lineas + 1

                if @w_control > 9999
                    select @w_control = 0

                if @w_lp_sec > 2147483640
                    select @w_lp_sec = @i_sec

                insert into ah_linea_pendiente
                        (lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha,
                        lp_control, lp_signo, lp_enviada)
                    values
                        (@w_cuenta, @w_lp_sec, @w_nemo, @w_total_reintegro, @i_fecha,
                        @w_control, 'D', 'N')

                if @@error <> 0
                begin
                    select  @w_error = 0,
                            @w_msg = 'ERROR EN INSERCION DE LINEA PENDIENTE de reintegro'
                    goto ERROR
                end
            end
        end

        select  @w_creditos         = @w_creditos + @w_saldo_interes + @w_total_reintegro,
                @w_creditos_hoy     = @w_creditos_hoy + @w_saldo_interes + @w_total_reintegro,
                @w_debitos          = @w_debitos + @w_valor_impuesto + @w_valor_reteica + @w_imp2,
                @w_debitos_hoy      = @w_debitos_hoy + @w_valor_impuesto + @w_valor_reteica + @w_imp2,
                @w_monto_imp        = @w_monto_imp + @w_imp2,
                @w_monto_ult_capi   = @w_saldo_interes

        select @w_saldo_interes = 0
        select @w_int_mes = 0

    end -- @w_saldo_interes > 0 
    else
        print ' Saldo_Interes < 0 '

        
        

    /* *********************************************************** */
    /* CAMBIA FECHA DE CAPITALIZACION POR SI ALGUN FERIADO U OTROS */
    /* *********************************************************** */
    
    CAMBIA_FECHA_CAP: 

        if @w_debug = 'S'
        begin
            print '*********** ACTUALIZA FECHA CAPITALIZACION ************'
        end
        
        if @w_commit = 'N'
        begin
            begin tran
            select @w_commit = 'S'
        end

        /* **************************************** */
        /* MARCAR INCUMPLIMENTOS AHORRO CONTRACTUAL */
        /* **************************************** */
        if @w_es_contractual = 'S'
        begin
            update cob_remesas..re_cuenta_contractual
            set    cc_periodos_incump = @w_cont_periodos_incump
            where  cc_cta_banco = @w_cta_banco
            and    cc_estado    = 'A'
         
            if @@error <> 0
            begin
                select  @w_error = 0,
                        @w_msg = 'ERROR EN ACTUALIZACION CONDICIONES CUENTA CONTRACTUAL'
                goto ERROR
            end

            if @w_cont_periodos_incump > 0  -- Diariamente, mientras no cumpla monto de periodo
            begin
                if @w_incumple_saldo = 'N'
                begin
                    insert into ah_tran_servicio
                            (ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha, ts_usuario,
                            ts_terminal, ts_ctacte, ts_filial, ts_valor, ts_oficina,
                            ts_oficina_cta, ts_prod_banc, ts_categoria, ts_moneda, ts_tipocta_super,
                            ts_turno, ts_cta_banco, ts_cliente, ts_clase_clte,
                            ts_saldo, ts_monto, ts_observacion)
                        values
                            (@w_ssn, @w_ssn, 4135, @i_fecha, 'op_batch',
                            'consola', @w_cuenta, @w_filial, @w_disponible, @w_oficina,
                            @w_oficina, @w_prod_banc, @w_categoria, @w_moneda, @w_tipocta_super,
                            @i_turno, @w_cta_banco, @w_cliente, @w_clase_clte, @w_saldo_mes,
                            @w_cont_cuota, 'INCUMPLIMIENTO POR CUOTA')

                    if @@error <> 0
                    begin
                        select  @w_error = 0,
                                @w_msg = 'ERROR AL INSERTAR TRANSACCION DE SERVICIO'
                        goto ERROR
                    end
                end
                else
                begin
                    insert into ah_tran_servicio
                            (ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha, ts_usuario,
                            ts_terminal, ts_ctacte, ts_filial, ts_valor,ts_oficina,
                            ts_oficina_cta, ts_prod_banc, ts_categoria, ts_moneda, ts_tipocta_super,
                            ts_turno, ts_cta_banco, ts_cliente, ts_clase_clte, 
                            ts_saldo, ts_monto, ts_observacion)
                        values
                            (@w_ssn, @w_ssn, 4135, @i_fecha, 'op_batch',
                            'consola', @w_cuenta, @w_filial, @w_disponible, @w_oficina,
                            @w_oficina, @w_prod_banc, @w_categoria, @w_moneda, @w_tipocta_super,
                            @i_turno, @w_cta_banco, @w_cliente, @w_clase_clte,
                            @w_disponible, @w_disponible_esp, 'INCUMPLIMIENTO POR SALDO')

                    if @@error <> 0
                    begin
                        select  @w_error = 0,
                                @w_msg = 'ERROR AL INSERTAR TRANSACCION DE SERVICIO'
                        goto ERROR
                    end
                end
            end
        end
        /* ** FIN - MARCAR INCUMPLIMIENTOS * */
        
        
        /* ***************************************** */
        /* ACTUALIZA FECHA DE PROXIMA CAPITALIZACION */
        /* ***************************************** */
        if @w_tcapitalizacion = 'D'
        begin
            select @w_fecha_prx_capita = @w_manana_sinferiados --Proximo dia laborable
        end
        else
        begin
            select @w_fecha_hoy = @w_manana_sinferiados
            select @w_anios = datepart(yyyy, @w_fecha_hoy)

            if @w_tcapitalizacion = 'E' -- CAPITALIZACION SEMANAL
            begin
                select @w_fecha_ini_anio = convert(datetime, '01/01/' + convert(varchar(4),@w_anios))
                select @w_meses_prx_capita = ceiling(datediff(dd, @w_fecha_ini_anio, @w_fecha_hoy) / 7.0) + 1
            end

            if @w_tcapitalizacion = 'Q' -- CAPITALIZACION QUINCENAL      
            begin
                select @w_fecha_ini_anio = convert(datetime, '01/01/' + convert(varchar(4),@w_anios))
                select @w_meses_prx_capita = ceiling(datediff(dd, @w_fecha_ini_anio, @w_fecha_hoy)/15.0)+1
            end
            
            if @w_tcapitalizacion = 'M'  -- Mensual
                select @w_meses_prx_capita = datepart(mm,@w_fecha_hoy)
            if @w_tcapitalizacion = 'B'  -- Bimensual
                select @w_meses_prx_capita = ceiling((datepart(mm, @w_fecha_hoy) - 1) / 2) + 1
            if @w_tcapitalizacion = 'T'  -- Trimestral
                select @w_meses_prx_capita = ceiling((datepart(mm, @w_fecha_hoy) - 1) / 3) + 1
            if @w_tcapitalizacion = 'S'  -- Semestral
                select @w_meses_prx_capita = ceiling((datepart(mm, @w_fecha_hoy) - 1) / 6) + 1

            select @w_ult_dia_mes_sinferiado = pe_fecha_fin
                from cob_ahorros..ah_periodo
                where pe_capitalizacion = @w_tcapitalizacion
                and pe_periodo          = @w_meses_prx_capita

            if @@rowcount = 0
            begin
                select  @w_error = 0,
                        @w_msg = 'NO SE ENCUENTRAN REGISTROS EN LA TABLA ah_periodo'
                goto ERROR
            end

            if @w_anios <> datepart(yyyy,@i_fecha)
                select @w_ult_dia_mes_sinferiado = dateadd(yy,1,@w_ult_dia_mes_sinferiado)

            while 1 = 1
            begin
                if exists (select 1
                           from cobis..cl_dias_feriados
                           where df_ciudad = @w_ciudad
                           and df_fecha  = @w_ult_dia_mes_sinferiado)
                    select @w_ult_dia_mes_sinferiado = dateadd(dd,-1,@w_ult_dia_mes_sinferiado)
                else
                    break
            end
            select @w_fecha_prx_capita = @w_ult_dia_mes_sinferiado
        end

        if @w_debug = 'S'
        begin
            print '...... Cambio Fecha Capitalización -------------------------'
            print '...... tipo capitalizacion:              ' + @w_tcapitalizacion
            print '...... Prox capitalizacion ah_periodo sin feriado:     ' + cast (@w_fecha_prx_capita as varchar)
        end
        
    /* Fin de Cambio de Fecha de Capitalización */ 

    
    
    
    
    
    -- ----------------------------
    -- DEVOLUCION DE IDB ----------
    -- ----------------------------
    idb:

    if @w_estado = 'A'
        and @w_tipocta = 'P'
        and @w_monto_imp > 0
        and @w_dev_idb = 'S'
    begin
        select @w_causa = '3'

        if @w_posteo = 'S'
        begin
            /* Numero de control y linea pendiente */
            select  @w_lineas = @w_lineas + 1,
                    @w_control = @w_control + 1,
                    @w_lp_sec = @w_lp_sec + 4

            if @w_control > 9999
                select @w_control = 0
            if @w_lp_sec > 2147483640
                select @w_lp_sec = @i_sec

            /* Inserta en linea pendiente */
                insert into ah_linea_pendiente
                    (lp_cuenta, lp_linea, lp_nemonico, lp_valor, lp_fecha,
                    lp_control, lp_signo, lp_enviada)
                values 
                    (@w_cuenta, @w_lp_sec, 'NCSL', @w_monto_imp, @i_fecha,
                    @w_control, 'C', 'N')

            if @@error <> 0
            begin
                select   @w_error = 0,
                        @w_msg = 'ERROR EN INSERCION DE LINEA PENDIENTE 4'
                goto ERROR
            end
        end

        select @w_alic = round(@w_monto_imp * @w_alicuota,@w_numdeci)

        select  @w_creditos = @w_creditos + @w_monto_imp,
                @w_creditos_hoy = @w_creditos_hoy + @w_monto_imp,
                @w_promedio1 = @w_promedio1 + @w_alic,
                @w_prom_disponible = @w_prom_disponible + @w_alic,
                @w_disponible = @w_disponible + @w_monto_imp,
                @w_contable = @w_contable + @w_monto_imp,
                @w_fecha_ult_mov_int = @i_fecha,
                @w_fecha_ult_capi = @i_fecha,
                @w_contador_trx = @w_contador_trx + 1

        select @w_trn_code = 253
        print ' Realiza insercion de la transaccion 253 -- devolucion de IDB '

        insert into ah_notcredeb
                (secuencial, ssn_branch, alterno, tipo_tran, oficina,
                usuario, terminal, correccion, sec_correccion, reentry,
                origen, nodo, fecha, cta_banco, signo,
                indicador, remoto_ssn, moneda, causa, fecha_efec,
                saldo_lib, valor, control, interes, saldocont,
                saldodisp, saldoint, departamento, oficina_cta, prod_banc,
                categoria, monto_imp, tipo_exonerado, serial, hora,
                tipocta_super, turno, canal, cliente)
            values
                (@w_ssn, @w_ssn, 5, @w_trn_code, @w_oficina,
                'op_batch', 'consola', 'N', null, 'N',
                'L', @i_srv, @i_fecha, @w_cta_banco, 'C',
                1, null, @w_moneda, @w_causa, null,
                null, @w_monto_imp, null, null, @w_contable,
                @w_disponible, null, null, @w_oficina, @w_prod_banc,
                @w_categoria, null, null, null, getdate(),
                @w_tipocta_super, @i_turno, @i_canal, @w_cliente)

        if @@error <> 0
        begin
            select  @w_error = 0,
                    @w_msg = 'ERROR EN INSERCION DE DEVOLUCION DE IDB'
            goto ERROR
        end
    end -- FIN DEVOLUCION DE IDB

    
    -- ----------------------------------------
    -- GENERACION DE SALDOS PARA REPORTES -----
    -- ----------------------------------------
    if @w_moneda <> @w_moneda_local
    begin
        select @w_compra = ct_valor
            from cob_conta..cb_cotizacion
            where ct_moneda = @w_moneda
            and ct_fecha  = @i_fecha

        if @@rowcount = 0
        begin
            select @w_error = 0,
                    @w_msg = 'Procesando ....21 ERROR EN TABLA DE COTIZACIONES'
            goto ERROR
        end

        select  @w_sld_rep1 = @w_saldo_rep1 / @w_compra,
                @w_sld_rep2 = @w_saldo_rep2 / @w_compra,
                @w_sld_rep3 = @w_saldo_rep3 / @w_compra
    end
    else
        select  @w_sld_rep1 = @w_saldo_rep1,
                @w_sld_rep2 = @w_saldo_rep2,
                @w_sld_rep3 = @w_saldo_rep3

    select @w_val_absoluto = abs(@w_contable - @w_saldo_ayer)

    if @w_val_absoluto >= @w_sld_rep1
    begin
        -- si el saldo es mayor al primero de los reportes
        select @w_saldo_mayor = 'A'
        insert into cob_ahorros..ah_saldos_rep
                (se_cuenta, se_nombre, se_oficina, se_moneda, se_prod_banc,
                se_categoria, se_saldo_ayer, se_saldo_contable, se_saldo_mayor)
            values
                (@w_cta_banco, @w_nombre, @w_oficina, @w_moneda, @w_prod_banc,
                @w_categoria, @w_saldo_ayer, @w_contable, @w_saldo_mayor)

            if @@error <> 0
            begin
                select  @w_error = 0,
                        @w_msg = 'Procesando ...22 ERROR EN INSERCION DE SALDO REP A'
                goto ERROR
            end
    end

    if @w_contable >= @w_sld_rep2
    begin
        select @w_saldo_mayor = 'B'
        insert into ah_saldos_rep
                (se_cuenta, se_nombre, se_oficina, se_moneda, se_prod_banc,
                se_categoria, se_saldo_ayer, se_saldo_contable, se_saldo_mayor)
            values
                (@w_cta_banco, @w_nombre, @w_oficina, @w_moneda, @w_prod_banc,
                @w_categoria, @w_saldo_ayer, @w_contable, @w_saldo_mayor)

        if @@error <> 0
        begin
            select  @w_error = 0,
                    @w_msg = 'Procesando ...23 ERROR EN INSERCION DE SALDO REPB'
            goto ERROR
        end
    end

    -- INSERTO CUENTAS CON MOVIMIENTOS DEPOSITO/RETIRO MAYORES A
    if (@w_creditos_hoy >= @w_sld_rep3) or (@w_debitos_hoy >= @w_sld_rep3)
    begin
        select @w_saldo_mayor = 'C'
        insert into ah_saldos_rep
                (se_cuenta, se_nombre, se_oficina, se_moneda, se_prod_banc,
                se_categoria, se_saldo_ayer, se_saldo_contable, se_saldo_mayor)
            values
                (@w_cta_banco, @w_nombre, @w_oficina, @w_moneda, @w_prod_banc,
                @w_categoria, @w_creditos_hoy, @w_debitos_hoy, @w_saldo_mayor)

        if @@error <> 0
        begin
            select  @w_error = 0,
                    @w_msg = 'Procesando ...24 ERROR EN INSERCION DE SALDO REPC'
            goto ERROR
        end
    end

    -- ---------------------------------------
    -- ACTUALIZACION DE DATOS DE LA CUENTA ---
    -- ---------------------------------------
    select @w_saldo_mantval = 0

    update cob_ahorros..ah_cuenta with (rowlock)
        set ah_disponible        = @w_disponible,
            ah_prom_disponible   = @w_prom_disponible,
            ah_promedio1         = @w_promedio1,
            ah_saldo_interes     = @w_saldo_interes,
            ah_int_hoy           = @w_int_hoy,
            ah_tasa_hoy          = @w_tasa_hoy,
            ah_min_dispmes       = @w_min_dispmes,
            ah_estado            = @w_estado,
            ah_fecha_ult_mov_int = @w_fecha_ult_mov_int,
            ah_fecha_prx_capita  = @w_fecha_prx_capita,
            ah_monto_imp         = @w_monto_imp,
            ah_debitos           = @w_debitos,
            ah_creditos          = @w_creditos,
            ah_debitos_hoy       = @w_debitos_hoy,
            ah_creditos_hoy      = @w_creditos_hoy,
            ah_linea             = @w_lineas,
            ah_contador_trx      = @w_contador_trx,
            ah_int_mes           = @w_int_mes,
            ah_monto_ult_capi    = @w_monto_ult_capi,
            ah_saldo_mantval     = @w_saldo_mantval,
            ah_12h_dif           = isnull(@w_valor_impuesto,0),
            ah_tasa_ayer         = @w_tasa_ayer,
            ah_fecha_ult_capi    = @w_fecha_ult_capi,
            ah_fecha_ult_proceso = @w_siguiente_dia
        where  ah_cta_banco         = @w_cta_banco

    if @@error <> 0
    begin
        select  @w_error = 0,
                @w_msg = 'Procesando ...12 ERROR EN ACTUALIZACION DE CUENTA'
        goto ERROR
    end

    -- se quita registro de tablas para que queden solo las no procesadas
    delete ah_ctas_no_procesadas where cta_banco = @w_cta_banco

    /* REQ 217 CAMBIO DE CATEGORIA AL CUMPLIR PLAZO */
    if (@w_es_contractual = 'S' and @i_fecha >= @w_ult_dia_cuota_sinferiado)
    begin
        exec @w_error = cob_ahorros..sp_cambio_categoria
            @i_cta_banco = @w_cta_banco

        if @w_error <> 0
        begin
            select @w_msg = 'Procesando ... ERROR EN CAMBIO DE CATEGORIA'
            goto ERROR
        end
        if @w_debug = 'S'
        begin
            print '...... CONTRACTUAL Cambio de Categoria al cumplir Plazo -----'
            print '...... i_fecha:                    ' + cast (@i_fecha as varchar)
            print '...... w_ult_dia_cuota_sinferiado: ' + cast (@w_ult_dia_cuota_sinferiado as varchar)
        end		
    end
    /* FIN - REQ 217 CAMBIO DE CATEGORIA AL CUMPLIR PLAZO */

    if @w_valor_acreditar >= 0.01 and @w_prov_diaria = 'S'
    begin
        select @w_trn_code = 271

        if @w_bco = 59
        begin
            --Para el Proyecto de Bancamia, la  contabilidad de los intereses es por tercero
            insert into cob_ahorros..ah_tran_servicio
                    (ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha, ts_usuario,
                    ts_terminal, ts_oficina, ts_reentry, ts_origen, ts_cta_banco,
                    ts_valor, ts_moneda, ts_oficina_cta, ts_prod_banc, ts_categoria,
                    ts_tipocta_super, ts_turno, ts_clase_clte, ts_cliente, ts_tasa)
                values
                    (@w_ssn, @w_ssn, @w_trn_code, @i_fecha, 'op_batch',
                    'consola', @w_oficina, 'N', 'U', @w_cta_banco,
                    @w_valor_acreditar, @w_moneda, @w_oficina, @w_prod_banc, @w_categoria,
                    @w_tipocta_super, @i_turno, @w_clase_clte, @w_cliente, convert(float, @w_tasa_hoy))

            if @@error <> 0
            begin
                select  @w_error = 0,
                        @w_msg = 'Procesando ...26 ERROR AL INSERTAR TRANSACCION DE SERVICIO'
                goto ERROR
            end
        end
        else
        begin
            insert into ah_acumulador
                    (ac_oficina, ac_moneda, ac_prod_banc, ac_categoria, ac_ssn,
                    ac_usuario, ac_terminal, ac_trn, ac_fecha, ac_reentry,
                    ac_origen, ac_cta_banco, ac_intereses, ac_tipocta_super, ac_clase_clte)
                values
                    (@w_oficina, @w_moneda, @w_prod_banc, @w_categoria, @w_ssn,
                    'op_batch', 'consola', @w_trn, @i_fecha, 'N',
                    'U', '0', @w_valor_acreditar, @w_tipocta_super, @w_clase_clte)

            if @@error <> 0
            begin
                select  @w_error = 0,
                        @w_msg = 'Procesando ...8 ERROR INSERTAR ACUMULADO DE INTERES',
                        @w_cta_banco = '0'
                goto ERROR
            end
        end -- solo para bancamia
    end

    /* FIN DE ACUMULAR INTERES */

    select @w_ssn = @w_ssn + 1
    select @w_procesado_ok = 0 -- LA CUENTA SE PROCESO CORRECTAMENTE

    LEER:
    if @w_commit = 'S'
    begin
        commit tran
        select @w_commit = 'N'
    end
    goto SALDO

    ERROR:
    print @w_msg
    if @w_commit = 'S'
    begin
        rollback tran
        select @w_commit = 'N'
    end

    exec sp_errorlog
        @i_fecha       = @i_fecha,
        @i_error       = @w_error,
        @i_usuario     = 'batch',
        @i_tran        = @w_trn_code,
        @i_cuenta      = @w_cta_banco,
        @i_descripcion = @w_msg,
        @i_rollback    = 'S',
        @i_programa    = @w_sp_name

    SALDO:
    /* *** Se elimino la carga para la tabla de ah_saldo_diario **** */      

    leer2:
    select @w_ssn = @w_ssn + 1
end
-- ++++++++++++++++++++++++++++++++++++++++++----
-- FIN Cursor para el procesamiento de cuentas --
-- ++++++++++++++++++++++++++++++++++++++++++----  

while @@trancount > 0
    commit tran

select 'Fin Procesamiento' = convert(varchar(30), getdate(), 109)
return 0

ERRORFIN:
exec sp_errorlog
    @i_fecha       = @i_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = @w_trn_code,
    @i_descripcion = @w_msg,
    @i_programa    = @w_sp_name

return @w_error

go

