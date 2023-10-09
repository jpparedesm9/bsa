use cob_cartera
go

/************************************************************************/
/*   Archivo:              qopsolwf.sp                                  */
/*   Stored procedure:     sp_qry_oper_sol_wf                           */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Raul Altamirano Mendez                       */
/*   Fecha de escritura:   Ene-05-2017                                  */
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
/************************************************************************/
/*                               CAMBIOS                                */
/*    FECHA          AUTOR              CAMBIO                          */
/*    ENE-05-2017    Raul Altamirano    Emision Inicial - Version MX    */
/*    ABR-10-2017    Luis Ponce         Cambios Santander Credito Grupal*/
/*    ABR-19-2017    Milton Custode     Tramites grupales grupos new    */
/*    AGO-13-2019    Nathali Mejia      Se agregan campos ingresos      */
/*                                      mensuales y nivel de colectivo  */
/*    AGO-23-2019    Nathali Mejia      Se modifican campos ingresos    */
/*                                      mensuales y nivel de colectivo  */
/*    Sep-17-2020    Sonia Rojas        Req #140073                     */
/*    Jun-29-2020    ACH                Err#161210 y nota#5             */
/*    Jul-20-2021    Sonia Rojas        162288                          */
/************************************************************************/

if exists (select 1 from sysobjects where name = 'sp_qry_oper_sol_wf')
drop proc sp_qry_oper_sol_wf
go

create proc sp_qry_oper_sol_wf (
@t_debug               varchar(1)   = 'N',
@t_file                varchar(14)  = null,
@t_from                varchar(30)  = null,
@t_trn                 int          = null,
@i_tramite             int          = null,
@i_numero_op_banco     cuenta       = null,
@i_linea_credito       cuenta       = null,
@i_producto            catalogo     = null,
@i_es_acta             varchar(1)   = null,
@i_operacion           varchar(1)   = null,
@i_tipo                varchar(1)   = null,
@i_truta               tinyint      = null,
@i_oficina_tr          smallint     = null,
@i_usuario_tr          login        = null,
--@i_fecha_crea        datetime     = null,
--@i_oficial           smallint     = null,
--@i_sector            catalogo     = null,
--@i_ciudad            smallint     = null,
--@i_estado            varchar(1)   = null,
--@i_nivel_ap          tinyint      = null,
--@i_fecha_apr         datetime     = null,
---@i_usuario_apr      login        = null,
@i_proposito           catalogo     = null,
@i_razon               catalogo     = null,
@i_txt_razon           varchar(255) = null,
@i_efecto              catalogo     = null,
@i_cliente             int          = null,
@i_grupo               int          = null,
@i_fecha_inicio        datetime     = null,
@i_num_dias            smallint     = 0,
@i_per_revision        catalogo     = null,
@i_condicion_especial  varchar(255) = null,
@i_rotativa            varchar(1)   = null,
@i_toperacion          catalogo     = null,
@i_monto               money        = 0,
@i_moneda              tinyint      = 0,
@i_periodo             catalogo     = null,
@i_num_periodos        smallint     = 0,
@i_destino             catalogo     = null,
@i_ciudad_destino      smallint     = null,
--@i_parroquia         catalogo     = null,   -- ITO:12/12/2011
@i_cuenta_corriente    cuenta       = null,
--@i_garantia_limpia   char         = null,
@i_monto_desembolso    money        = null,
@i_reajustable         varchar(1)   = null,
@i_per_reajuste        tinyint      = null,
@i_reajuste_especial   varchar(1)   = null,
@i_fecha_reajuste      datetime     = null,
@i_cuota_completa      varchar(1)   = null,
@i_tipo_cobro          varchar(1)   = null,
@i_tipo_reduccion      varchar(1)   = null,
@i_aceptar_anticipos   varchar(1)   = null,
@i_precancelacion      varchar(1)   = null,
@i_tipo_aplicacion     varchar(1)   = null,
@i_renovable           varchar(1)   = null,
@i_fpago               catalogo     = null,
@i_cuenta              cuenta       = null,
@i_fondos_propios      varchar(1)   = 'N',
@i_renovacion          smallint     = null,
@i_cliente_cca         int          = null,
@i_op_renovada         cuenta       = null,
@i_deudor              int          = null,
@i_op_reestructurar    cuenta       = null,
--@i_cuenta_certificado  cuenta       = null,
--@i_alicuota            catalogo     = null,
--@i_alicuota_aho        catalogo     = null,
--@i_doble_alicuota      varchar(1)   = null,
--@i_actividad_destino   catalogo     = null,
@i_plazo               smallint     = null,
@i_tplazo              catalogo     = null,
--@i_compania            int          = null,
--@i_tipo_cca            catalogo     = null,
--@i_vinculado           varchar(1)   = 'N',
--@i_causal_vinculacion  catalogo     = null,
--@i_verificador         catalogo     = null,
--@i_seg_cre             catalogo     = null,
--@i_activa_TirTea       varchar(1)   = 'S',
@i_sobrepasa           varchar(1)   = 'N',
@i_forward             varchar(1)   = null,
@i_elegible            varchar(1)   = 'N',
@i_emp_emisora         int          = null,
@i_formato_fecha       int          = 103,
@i_tram_ext            varchar(1)   = 'N'
)
as
declare @w_tramite            int,
@w_truta              tinyint,
@w_tipo               char(1),
@w_desc_tipo          descripcion,
@w_oficina_tr         int,
@w_desc_oficina       descripcion,
@w_usuario_tr         login,
@w_nom_usuario_tr     varchar(30),
@w_fecha_crea         datetime,
@w_oficial            int,
@w_sector             catalogo,
@w_ciudad             int,
@w_desc_ciudad        descripcion,
@w_estado             char(1),
@w_nivel_ap           int,
@w_fecha_apr          datetime,
@w_usuario_apr        login,
@w_nom_usuario_apr    varchar(30),
@w_secuencia          int,
@w_numero_op          int,
@w_numero_op_banco    cuenta,
@w_desc_ruta          descripcion,
@w_proposito          catalogo,
@w_des_proposito      descripcion,
@w_razon              catalogo,
@w_des_razon          descripcion,
@w_txt_razon          varchar(255),
@w_efecto             catalogo,
@w_des_efecto         descripcion,
@w_cliente            int,
@w_grupo              int,
@w_fecha_inicio       datetime,
@w_num_dias           int,
@w_per_revision       catalogo,
@w_condicion_especial varchar(255),
@w_linea_credito      int,
@w_toperacion         catalogo,
@w_producto           catalogo,
@w_monto              money,
@w_moneda             int,
@w_periodo            catalogo,
@w_num_periodos       int,
@w_destino            catalogo,
@w_ciudad_destino     int,
@w_cuenta_corriente   cuenta,
@w_garantia_limpia    char(1),
@w_renovacion         int,
@w_aprob_por          login,
@w_nivel_por          int,
@w_comite             catalogo,
@w_acta               cuenta,
@w_fecha_concesion    datetime,
--variables para datos adicionales de operaciones de cartera
@w_fecha_reajuste     datetime,
@w_monto_desembolso   money,
@w_periodo_reajuste   int,
@w_reajuste_especial  char(1),
@w_forma_pago         catalogo,
@w_cuenta             varchar(24),
@w_cuota_completa     char(1),
@w_tipo_cobro         char(1),
@w_tipo_reduccion     char(1),
@w_aceptar_anticipos  char(1),
@w_precancelacion     char(1),
@w_tipo_aplicacion    char(1),
@w_renovable          char(1),
@w_reajustable        char(1),
@w_val_tasaref        float,
@w_cuenta_certificado cuenta,
@w_alicuota           catalogo,
@w_alicuota_aho       catalogo,
@w_doble_alicuota     char(1),
@w_tdividendo         catalogo,
@w_desc_tdividendo    descripcion,
@w_motivo_uno         varchar(255),
@w_motivo_dos         varchar(255),
@w_motivo_rechazo     catalogo,
--variables para completar datos del registro de un tramite
@w_des_oficial        descripcion,
@w_des_sector         descripcion,
@w_des_nivel_ap       descripcion,
@w_nom_ciudad         descripcion,
@w_nom_cliente        varchar(255),
@w_ciruc_cliente      numero,
@w_nom_grupo          descripcion,
@w_des_per_revision   descripcion,
@w_des_segmento       descripcion,
@w_des_toperacion     descripcion,
@w_des_moneda        descripcion,
@w_des_periodo        descripcion,
@w_des_destino        descripcion,
@w_nom_aprob_por      descripcion,
@w_des_fpago          descripcion,
@w_li_num_banco       cuenta,
@w_des_comite         descripcion,
@w_paso               tinyint,
@w_numero_operacion   int,
@w_cont_dividendos    int,
--variables para operacion a reestructurar
@w_banco_rest         cuenta,               --numero de banco
@w_operacion_rest     int,                  --secuencial
@w_toperacion_rest    catalogo,             --tipo de operacion
@w_fecha_vto_rest     datetime,             --fecha vencimiento
@w_monto_rest         money,                --monto original
@w_saldo_rest         money,                --saldo capital
@w_moneda_rest        tinyint,              --moneda
@w_renovacion_rest    smallint,             --numero de renovacion
@w_renovable_rest     char(1),              --renovable
@w_fecha_ini_rest     datetime,             --fecha concesion
@w_producto_rest      catalogo,             --producto
@w_actividad_destino  catalogo,             --Codigo actividad destino de la operacion
@w_descripcion_ad     descripcion,          --Descripcion actividad destino
@w_tipo_cca           catalogo,             --Tipo cartera
@w_seg_cre            catalogo,             --Segmento Credito 18/09/2007
@w_descripcion_segmento descripcion,        --Segmento Credito 18/09/2007
@w_descripcion_tipo   descripcion,          --Descripcion tipo cartera
@w_clase_bloqueo      char(1),
@w_op_banco           varchar(24),
@w_op_compania        int,                  --Institucion Deudor
@w_desc_compania      descripcion,
@w_op_vinculado       char(1),              --Datos Vinculacion
@w_op_cliente         int,
@w_op_causal_vinc     catalogo,
@w_op_tipo_vinc       catalogo,
@w_causal_vinc_desc   descripcion,
@w_tipo_vinc_desc     descripcion,
@w_verificador        catalogo,
@w_des_verificador    descripcion,
@w_parroquia          catalogo,
@w_des_parroquia      descripcion,
@w_fecha_liq          datetime,
@w_fecha_venc         datetime,
@w_tipo_credito       char(1),
@w_simbolo_moneda     varchar(10),
@w_provincia          int,
@levelIndeb           char(1),
@w_fecha_venci        datetime,
@w_clase              catalogo,
@w_dias_anio          smallint,
@w_monto_aprobado     money,
@w_comentario         varchar(255),
@w_banca              catalogo,
@w_error              int,
@w_tr_grupal          char(1),
@w_promocion          char(1),   --LPO Santander
@w_acepta_ren         char(1),   --LPO Santander
@w_no_acepta          char(1000),--LPO Santander
@w_emprendimiento     char(1),    --LPO Santander
@w_garantia           float,
@w_monto_solicitado   money,
@w_sum_mont_grupal    money,      -- suma de montos grupal
@w_sum_mont_grupal_sol money,     -- suma de montos grupal
@w_numero_ciclo       int,
@w_numero_grupo       int,
@w_plazo              int,        -- Santander
@w_tplazo             catalogo,   -- Santander 
@w_es_partner         catalogo,   -- Santander 
@w_tplazo_descrip     varchar(64),-- Santander 
@w_bc_lis_negra       varchar(10),
@w_alianza            int,
@w_experiencia_cli    char(1),    --Santander
@w_monto_max_tr       money,       --Santander
@w_tplazo_lcr         varchar(10),
-- Variable para la extraccion del dia habil
@w_fecha_hab_disp       datetime,
@w_numero_dias          int,
@w_ciudad_nacional      int,
@w_fecha_proceso        datetime,
@w_fecha_con_disper     datetime,
@w_aux_monto            money,
@w_aux_monto_aprobado   money,
@w_est_novigente        int,
@w_est_anulado          int,
@w_est_credito          int,
@w_ingresos_mensuales   money, --NME 13/08/2019
@w_nivel_colectivo      char(10), --NME 13/08/2019
@w_colectivo            varchar(30),
@w_es_candidato         char(1),
@w_gracia               varchar(4),
@w_capacidad_pago_mensual money

/* Estados */
exec cob_externos..sp_estados
@i_producto      = 7,
@o_est_novigente = @w_est_novigente out,
@o_est_anulado   = @w_est_anulado out,
@o_est_credito   = @w_est_credito out

select @w_est_novigente = isnull(@w_est_novigente, 0),
@w_est_anulado = isnull(@w_est_anulado, 6),
@w_est_credito = isnull(@w_est_credito, 99)


--Verificacion de Existencias
SELECT
@w_tramite = tr_tramite,
@w_truta = tr_truta,
@w_tipo = tr_tipo,
@w_oficina_tr = tr_oficina,
@w_usuario_tr = tr_usuario,
@w_nom_usuario_tr = substring(a.fu_nombre,1,30),
@w_fecha_crea = tr_fecha_crea,
@w_oficial = tr_oficial,
@w_sector = tr_sector,
@w_ciudad = tr_ciudad,
@w_estado = tr_estado,
@w_nivel_ap = tr_nivel_ap,
@w_fecha_apr = tr_fecha_apr,
@w_usuario_apr        = tr_usuario_apr,
@w_nom_usuario_apr = substring(b.fu_nombre,1,30),
@w_numero_op = tr_numero_op,
@w_numero_op_banco = tr_numero_op_banco,
@w_proposito = tr_proposito, /* garantias*/
@w_razon = tr_razon,
@w_txt_razon = rtrim(tr_txt_razon),
@w_efecto = tr_efecto,
@w_cliente = tr_cliente, /*lineas*/
@w_grupo = tr_grupo,
@w_fecha_inicio = tr_fecha_inicio,
@w_num_dias = tr_num_dias,
@w_per_revision = tr_per_revision,
@w_condicion_especial = tr_condicion_especial,
@w_linea_credito = tr_linea_credito,  /*renov. y operaciones*/
@w_toperacion = tr_toperacion,
@w_producto = tr_producto,
@w_monto = tr_monto,
@w_moneda = tr_moneda,
@w_periodo = tr_periodo,
@w_num_periodos = tr_num_periodos,
@w_destino = tr_destino,
@w_ciudad_destino = tr_ciudad_destino,
@w_cuenta_corriente = tr_cuenta_corriente,
@w_garantia_limpia = null, --tr_garantia_limpia,
@w_renovacion = tr_renovacion,
@w_aprob_por = tr_aprob_por,
@w_nivel_por = tr_nivel_por,
@w_comite    = tr_comite,
@w_acta      = tr_acta,
@w_fecha_concesion = tr_fecha_concesion,
@w_cuenta_certificado = null , --tr_cuenta_certificado,
@w_alicuota          = null, --tr_alicuota,
@w_alicuota_aho      = null, --tr_alicuota_aho,
@w_doble_alicuota    = null, --tr_doble_alicuota,
@w_actividad_destino = null, --tr_actividad_destino,
@w_tipo_cca          = null, --tr_tipo_cca,
@w_verificador       = null, --tr_verificador,
@w_seg_cre           = null, --tr_seg_cre,
@w_tr_grupal         = tr_grupal,
@w_garantia          = tr_porc_garantia,
@w_monto_solicitado  = tr_monto_solicitado,
@w_plazo             = tr_plazo,
@w_tplazo            = tr_tipo_plazo,
@w_alianza           = tr_alianza,
@w_experiencia_cli   = tr_experiencia,
@w_monto_max_tr      = tr_monto_max
FROM cob_credito..cr_tramite
LEFT JOIN cobis..cl_funcionario a ON tr_usuario = a.fu_login
LEFT JOIN cobis..cl_funcionario b ON tr_usuario_apr = b.fu_login
--     cobis..cl_funcionario a,
--     cobis..cl_funcionario b
WHERE tr_tramite = @i_tramite
--AND tr_usuario *= a.fu_login
--AND tr_usuario_apr *= b.fu_login

if @@rowcount = 0
begin
select @w_error = 2101005
goto ERROR_PROCESO
end

--OBTENER INFORMACION COMPLEMENTARIA
select
@w_secuencia = null,
@w_paso      = null,
@w_desc_ruta = null

--descripcion del tipo de tramite
select @w_desc_tipo = tt_descripcion
from cob_credito..cr_tipo_tramite
where tt_tipo = @w_tipo

--descripcion de la oficina
select @w_desc_oficina = of_nombre
from cobis..cl_oficina
where of_oficina = @w_oficina_tr

--descripcion y provincia de la ciudad
select @w_desc_ciudad = ci_descripcion
from cobis..cl_ciudad
where ci_ciudad = @w_ciudad

--numero de banco de la linea de credito
select @w_li_num_banco = li_num_banco
from cob_credito..cr_linea
where li_numero = @w_linea_credito

--nombre del oficial
select @w_des_oficial = substring(fu_nombre,1,30)
from cobis..cc_oficial, cobis..cl_funcionario
where oc_oficial = @w_oficial
and oc_funcionario = fu_funcionario

--descripcion del sector
select @w_des_sector = a.valor
from cobis..cl_catalogo a, cobis..cl_tabla b
where b.tabla  = 'cc_sector'
and a.codigo = @w_sector
and a.tabla  = b.codigo

--descripcion del destino
if @w_destino is not null
begin
select @w_des_destino = a.valor
from cobis..cl_catalogo a, cobis..cl_tabla b
where a.codigo = @w_destino
and a.tabla  = b.codigo
and b.tabla  = 'cr_destino'
end

--descripcion de la actividad  SPO
if @w_actividad_destino is not null
begin
select @w_descripcion_ad = ae_descripcion
from cobis..cl_act_economica
where ae_codigo = @w_actividad_destino
end

--Clase de cartera SPO
if @w_tipo_cca is not null
begin
select @w_descripcion_tipo = a.valor
from cobis..cl_catalogo a, cobis..cl_tabla b
where a.codigo = @w_tipo_cca
and a.tabla  = b.codigo
and b.tabla  = 'ca_tipo_cartera'
end

--Tipo Segmento Credito
if @w_seg_cre is not null
begin
select @w_descripcion_segmento = a.valor
from cobis..cl_catalogo a, cobis..cl_tabla b
where a.codigo = @w_seg_cre
and a.tabla = b.codigo
and b.tabla = 'ca_segmento_credito'
end

--nivel de aprobacion
if @w_nivel_ap is not null
begin
select @w_des_nivel_ap = a.valor
from cobis..cl_catalogo a, cobis..cl_tabla b
where a.codigo = convert(varchar(10),@w_nivel_ap)
and   a.tabla = b.codigo
and   b.tabla = 'cr_nivel'
end

--nombre del cliente
if @w_tipo in ('O', 'R', 'E')
begin
select @w_cliente = de_cliente
from   cob_credito..cr_deudores
where  de_tramite = @i_tramite
and    de_rol = 'D'
end

if @w_cliente is not null
begin
select @w_nom_cliente = rtrim(p_p_apellido)+' '+rtrim(p_s_apellido)+' '+rtrim(en_nombre),
@w_ciruc_cliente = en_ced_ruc
from cobis..cl_ente
where en_ente = @w_cliente
end

--nombre del grupo
if @w_grupo is not null
begin
select @w_nom_grupo = gr_nombre
from cobis..cl_grupo
where gr_grupo = @w_grupo
end

--periodicidad de revision
if @w_per_revision is not null
begin
select @w_des_per_revision = pe_descripcion
from cob_credito..cr_periodo
where pe_periodo = @w_per_revision
end

--tipo de operacion
if @w_toperacion is not null
begin
select @w_des_toperacion = to_descripcion
from cob_credito..cr_toperacion
where to_toperacion =@w_toperacion
and to_producto = @w_producto
end

--moneda
if @w_moneda is not null
begin
select @w_des_moneda = mo_descripcion,
@w_simbolo_moneda = mo_simbolo
from cobis..cl_moneda
where mo_moneda = @w_moneda
end

--ciudad destino
if @w_ciudad_destino is not null
begin
select @w_nom_ciudad = ci_descripcion,
@w_provincia  = ci_provincia
from cobis..cl_ciudad
where ci_ciudad = @w_ciudad_destino
end

--descripcion de razon de cambio de garantia
if @w_razon is not null
begin
select @w_des_razon = a.valor
from cobis..cl_catalogo a, cobis..cl_tabla b
where a.codigo = @w_razon
and a.tabla = b.codigo
and b.tabla = 'cr_razon'
end

--descripcion de proposito de cambio de garantia
if @w_proposito is not null
begin
select @w_des_proposito = a.valor
from cobis..cl_catalogo a, cobis..cl_tabla b
where a.codigo = @w_proposito
and a.tabla = b.codigo
and b.tabla = 'cr_proposito'
end

--descripcion de efecto de cambio de garantia
if @w_efecto is not null
begin
select @w_des_efecto = a.valor
from cobis..cl_catalogo a, cobis..cl_tabla b
where a.codigo = @w_efecto
and a.tabla = b.codigo
and b.tabla = 'cr_efecto'
end

--nombre del usuario que fue sustituido
if @w_aprob_por is not null
begin
select @w_nom_aprob_por = substring(fu_nombre,1,30)
from   cobis..cl_funcionario
where  fu_login = @w_aprob_por
end

-- descripcion del comite
if @w_comite is not null
begin
select @w_des_comite = a.valor
from cobis..cl_catalogo a, cobis..cl_tabla b
where a.codigo = @w_comite
and a.tabla = b.codigo
and b.tabla = 'cr_comite'
end

-- Nombre del Verificador
select @w_verificador = null,
@w_des_verificador = null

--CONSULTAR LA INFORMACION ADICIONAL
if @w_producto = 'CCA'
begin
--CONSULTAR INFORMACION CONSIDERANDO EL ENVIO DE NUMERO DE TRAMITE
select @w_numero_operacion = op_operacion,
@w_fecha_reajuste        = op_fecha_reajuste,
@w_monto_desembolso      = op_monto,
@w_periodo_reajuste      = op_periodo_reajuste,
@w_reajuste_especial     = op_reajuste_especial,
@w_forma_pago            = op_forma_pago,
@w_cuenta                = op_cuenta,
@w_cuota_completa        = op_cuota_completa,
@w_tipo_cobro            = op_tipo_cobro,
@w_tipo_reduccion        = op_tipo_reduccion,
@w_aceptar_anticipos     = op_aceptar_anticipos,
@w_precancelacion        = op_precancelacion,
@w_tipo_aplicacion       = op_tipo_aplicacion,
@w_renovable             = op_renovacion,
@w_reajustable           = op_reajustable,
@w_fecha_inicio          = op_fecha_ini,
@w_periodo               = case when op_tplazo = 'W' and op_periodo_int = 2 and op_periodo_cap = 2 then 'BW' else op_tplazo end,--SRO
@w_des_periodo           = case when op_tplazo = 'W' and op_periodo_int = 2 and op_periodo_cap = 2 then 'CATORCENAL' else td_descripcion end, --SRO
@w_tdividendo            = case when op_tdividendo = 'W' and op_periodo_int = 2 and op_periodo_cap = 2 then 'BW' else op_tdividendo end, --SRO
@w_num_periodos          = op_plazo,
@w_clase_bloqueo         = null,  --op_clase_bloqueo,
@w_op_banco              = op_banco,
@w_op_compania           = null,  --op_compania,
@w_op_cliente            = op_cliente,
--@w_op_vinculado        = e.en_vinculacion,
@w_op_causal_vinc        = null,  --op_rubro,
@w_cuenta_corriente      = null,  --op_cta_ahorro,
@w_cuenta_certificado    = null,  --op_cta_certificado,
@w_parroquia             = null,  --op_parroquia,
@w_clase                 = op_clase,
@w_dias_anio             = op_dias_anio,
@w_monto_aprobado        = op_monto_aprobado,
@w_comentario            = op_comentario,
@w_banca                 = op_banca,
@w_promocion             = op_promocion,     --LPO Santander
@w_acepta_ren            = op_acepta_ren,    --LPO Santander
@w_no_acepta             = op_no_acepta,     --LPO Santander
@w_emprendimiento        = op_emprendimiento, --LPO Santander
@w_gracia                = convert(varchar(4), isnull(op_desplazamiento,0))--SRO 140073
from cob_cartera..ca_operacion op,
cob_cartera..ca_tdividendo
where op_tramite = @i_tramite
and   td_tdividendo = op_tplazo

--SRO. INDIVIDUAL
select @w_tplazo = case when @w_tplazo = 'W' and @w_periodo = 'BW' then @w_periodo else @w_tplazo end

--NRO CUENTA DEL CLIENTE
SELECT @w_cuenta = ea_cta_banco
  FROM cobis..cl_ente_aux
 WHERE ea_ente = @w_op_cliente
 
select @w_op_vinculado = isnull(en_vinculacion, 'N')
from cobis..cl_ente
where en_ente = @w_op_cliente

if @w_op_vinculado is null select @w_op_vinculado = 'N'

--descripcion de la parroquia
select @w_parroquia = null, @w_des_parroquia = null

--INSTITUCION DEUDOR
select @w_op_compania = isnull(@w_op_compania,0)

if @w_op_compania > 0
begin
select @w_desc_compania = en_nombre
from   cobis..cl_ente
where  en_ente = @w_op_compania
end

--DATOS DE VINCULACION
if @w_op_vinculado <>'N'
begin
    select @w_causal_vinc_desc = rtrim(b.valor)
    from   cobis..cl_tabla a, cobis..cl_catalogo b
    where  a.tabla  = 'cl_causal_vinculacion'
    and    b.tabla  = a.codigo
    and    b.codigo = @w_op_causal_vinc
    select @w_causal_vinc_desc  =  rtrim(@w_op_causal_vinc) + '-' +  rtrim(@w_causal_vinc_desc)
    select @w_op_tipo_vinc = en_tipo_vinculacion
    from   cobis..cl_ente
    where  en_ente = @w_op_cliente
    select @w_tipo_vinc_desc = rtrim(b.valor)
    from   cobis..cl_tabla a, cobis..cl_catalogo b
    where  a.tabla  = 'cl_tipo_vinculacion'
    and    b.tabla  = a.codigo
    and    b.codigo = @w_op_tipo_vinc
    select @w_tipo_vinc_desc  =  rtrim(@w_op_tipo_vinc) + '-' +  rtrim(@w_tipo_vinc_desc)
end

select @w_numero_op_banco = isnull(@w_numero_op_banco,@w_op_banco)

if @w_forma_pago is not null
begin
select @w_des_fpago = cp_descripcion
from cob_cartera..ca_producto
where cp_producto = @w_forma_pago
end

--no se usa select @w_desc_tdividendo = td_descripcion from cob_cartera..ca_tdividendo where td_tdividendo = @w_tdividendo

--tasa de interes
select @w_val_tasaref = isnull(sum(ro_porcentaje),0)
from   cob_cartera..ca_rubro_op
where  ro_operacion  = @w_numero_operacion
and    ro_tipo_rubro = 'I'
and    ro_fpago      in ('P','A')
and    ro_concepto   in (select pa_char from cobis..cl_parametro
where pa_nemonico ='INT')

--Fecha de Vencimiento de una operaci+�n
select @w_fecha_venci = di_fecha_ven
from   cob_cartera..ca_dividendo
where  di_operacion = @w_numero_operacion and di_dividendo = 1


--contador de dividendos
select @w_cont_dividendos = count(*)
from   cob_cartera..ca_dividendo
where  di_operacion = @w_numero_operacion

select @w_fecha_liq  = op_fecha_liq,
@w_fecha_venc = op_fecha_fin
from cob_cartera..ca_operacion
where op_operacion = @w_numero_operacion

--datos de la operacion a reestructurar
if @w_tipo = 'E'
begin
--obtener el numero de banco de la operacion
select @w_banco_rest = or_num_operacion
from   cob_credito..cr_op_renovar
where  or_tramite = @i_tramite
--obtener los datos de la operacion
select
@w_operacion_rest  = op_operacion,
@w_toperacion_rest = op_toperacion,
@w_fecha_vto_rest  = op_fecha_fin,
@w_monto_rest      = op_monto,
@w_moneda_rest     = op_moneda,
@w_renovacion_rest = op_num_renovacion,
@w_renovable_rest  = op_renovacion,
@w_fecha_ini_rest  = op_fecha_liq,
@w_producto_rest   = 'CCA'
from  cob_cartera..ca_operacion
where op_banco = @w_banco_rest

--obtener el saldo de capital
--select @w_saldo_rest = sum(isnull(am_cuota,0) + isnull(am_gracia,0) - isnull(am_pagado,0) - isnull(am_exponencial,0))
select @w_saldo_rest = sum(isnull(am_cuota,0) + isnull(am_gracia,0) - isnull(am_pagado,0))
from   cob_cartera..ca_amortizacion, cob_cartera..ca_rubro_op
where  ro_operacion = @w_operacion_rest
and    ro_tipo_rubro in ('C')    -- tipo de rubro capital
and    am_operacion = ro_operacion
and    am_concepto  = ro_concepto
end

end

--obtener nivel de colectivo e ingreson mensuales
SELECT 
@w_colectivo       = isnull(ea_colectivo, ''),
@w_nivel_colectivo = isnull(ea_nivel_colectivo, '') --NME 13/08/2019
FROM cobis..cl_ente_aux
WHERE ea_ente = @w_cliente
 
--Caso#161210-Calculo de @w_capacidad_pago_mensual--el valor de cero es de @w_ing_negocio, no se tiene el dato
--referencia la suma viene de la pantalla de mantenimiento metodo task.calculateAvailableBalance
select @w_ingresos_mensuales = isnull(en_otros_ingresos,''), --NME 13/08/2019
       @w_capacidad_pago_mensual = (ea_ventas + en_otros_ingresos + 0) - (ea_ct_ventas + ea_ct_operativo)
from cobis..cl_ente, cobis..cl_ente_aux
where en_ente = @w_cliente
and en_ente = ea_ente
			
-- Informacion de Datos Adicionales: Rechazo, motivo y justificacion
select
@w_motivo_rechazo = null,
@w_motivo_uno = null,
@w_motivo_dos = null

-- Suma de montos
select @w_sum_mont_grupal     = sum(tg_monto),
       @w_sum_mont_grupal_sol = sum(tg_monto_aprobado)
from   cob_credito..cr_tramite_grupal
where  tg_tramite = @i_tramite

select @w_numero_grupo        = tg_grupo
from   cob_credito..cr_tramite_grupal
where  tg_tramite = @i_tramite

select @w_numero_ciclo = gr_num_ciclo 
from cobis..cl_grupo where gr_grupo = @w_numero_grupo


if @w_numero_ciclo IS NULL
	select @w_numero_ciclo=0

select @w_numero_ciclo=@w_numero_ciclo+1


if @w_toperacion = 'INDIVIDUAL'
begin
   /* Se extrae el plazo para individual */
   select @w_num_periodos = tr_plazo
   from cob_credito..cr_tramite 
   where tr_tramite = @w_tramite
   
   /* Se reeplaza el periodo del tramite por el tipo de plazo */
   select @w_periodo = @w_tdividendo
   
   /* INICIO INVERTIR Se invirte el orden de las variables de monto solicitado y monto autorizado, el cambio es por conceptos */
   select @w_aux_monto = @w_monto
   select @w_aux_monto_aprobado = @w_monto_aprobado
   
   /* Invertir */
   select @w_monto = @w_aux_monto_aprobado
   select @w_monto_aprobado = @w_aux_monto
   /* FIN INVERTIR*/
   
   /* Obtener ciclo individual */
   select @w_numero_ciclo = count(*) from cob_cartera..ca_operacion 
   where op_cliente = @w_cliente
   and op_toperacion = @w_toperacion
   and op_tramite <> @w_tramite
   and op_estado not in (@w_est_novigente, @w_est_anulado, @w_est_credito)
   
   if @w_numero_ciclo < 0 or @w_numero_ciclo is null
      select @w_numero_ciclo = 0
   select @w_numero_ciclo = @w_numero_ciclo + 1
   
   /* Es Partner*/
   select @w_es_partner = isnull(ea_partner, 'N') 
   from cobis..cl_ente_aux 
   where ea_ente = @w_cliente
end


--descripcion del plazo, no funciona para catorcenal
--select @w_tplazo_descrip = case when @w_des_periodo is null then td_descripcion else @w_des_periodo end from cob_cartera..ca_tdividendo where td_tdividendo = @w_periodo

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

-- FECHA DE PROCESO

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

-- VERIFICACION DE DIAS HABILES
while @w_numero_dias >0
begin
   select @w_fecha_proceso = DATEADD (dd, 1, @w_fecha_proceso)

   IF NOT EXISTS (SELECT 1 FROM cobis..cl_dias_feriados WHERE df_fecha = @w_fecha_proceso AND df_ciudad = @w_ciudad_nacional)
   begin
     set @w_fecha_hab_disp = @w_fecha_proceso
     set @w_numero_dias =@w_numero_dias-1 
      
   end 
end


-- obtencion de la fecha de dispersion
select @w_fecha_con_disper = tr_fecha_dispersion 
from cob_credito..cr_tramite
where tr_tramite = @w_tramite

select @w_tplazo_lcr      = tr_periodicidad_lcr
from cob_credito..cr_tramite
where tr_tramite = @w_tramite

--
if @w_toperacion = 'REVOLVENTE'
begin
	if exists(select * from cob_cartera..ca_lcr_candidatos where cc_cliente = @w_cliente)
	begin
		select @w_es_candidato = 'S'
	end
end

--PARA RENOVACIONES SE EVITA QUE SE EJECUTEN SENTENCIAS EN CODIGO HEREDADO PARA REFINANCIAMENTO
IF(@w_tipo ='R')
	SELECT @w_tipo = 'O'

--retorno al front-end
select
@w_tramite,                                --1
@w_desc_ruta,
@w_tipo,
@w_desc_tipo,                              --4
@w_oficina_tr,
@w_desc_oficina,
@w_usuario_tr,                             --7
@w_nom_usuario_tr,
@w_fecha_crea,
@w_oficial,
@w_ciudad_destino,--@w_ciudad,
@w_desc_ciudad,                            --12
@w_estado,
@w_secuencia,
@w_numero_op_banco,                        --15
@w_proposito,
@w_des_proposito,                          --17
@w_razon,
@w_des_razon,
@w_txt_razon,
@w_efecto,
@w_des_efecto,
@w_cliente,                                --23
isnull(@w_grupo,@w_numero_grupo),
@w_fecha_inicio,
@w_num_dias,
@w_per_revision,
@w_condicion_especial,
@w_toperacion,
@w_producto,                               --30
@w_li_num_banco,
@w_monto,
@w_moneda,
@w_periodo,
@w_num_periodos,                           --35
@w_destino,
@w_ciudad_destino,
@w_renovacion,
@w_fecha_reajuste,
isnull(@w_monto_desembolso,@w_monto),      --40 mc
@w_periodo_reajuste,
@w_reajuste_especial,
@w_forma_pago,                             --43
@w_cuenta,
@w_cuota_completa,
@w_tipo_cobro,
@w_tipo_reduccion,
@w_aceptar_anticipos,                      --48
@w_precancelacion,
@w_tipo_aplicacion,
@w_renovable,
@w_reajustable,
@w_val_tasaref,                            --53
@w_fecha_concesion,
@w_seg_cre,                                            --@w_sector, OGU modificado
@w_des_oficial,
@w_des_sector,
@w_des_nivel_ap,
@w_nom_ciudad,
@w_nom_cliente,
@w_ciruc_cliente,                          --61
@w_nom_grupo,
@w_des_per_revision,
@w_des_segmento,
@w_des_toperacion,
@w_des_moneda,
@w_des_periodo,
@w_des_destino,
@w_des_fpago,
@w_paso,
@w_cont_dividendos,                         --71
@w_banco_rest,
@w_operacion_rest,
@w_toperacion_rest,
@w_fecha_vto_rest,
@w_monto_rest,
@w_saldo_rest,                              --77
@w_moneda_rest,
@w_renovacion_rest,
@w_renovable_rest,
@w_fecha_ini_rest,    --80
@w_producto_rest,                           --82
' ',           -- INICIO NUEVOS DATOS
' ',
' ',
' ',
' ',
' ',
' ',
' ',
' ',    --90
' ',
' ',
' ',
' ',
@w_monto, --@w_monto_solicitado,              --96
0.00,
@w_periodo,
@w_moneda, --@w_moneda_solicitada,
@w_provincia, --@w_provincia,
0.00,    --100
@w_num_periodos, --@w_pplazo,
' ',
' ',
' ',
@w_actividad_destino,                         --106
0,
0,
0.00,
0.00,
0,    --110
@w_tipo_credito,
0.00,
' ',
' ', --@w_objeto,
@w_des_oficial,
' ', --@w_origen_fondos,
@w_des_periodo, --@w_des_frec_pago,
0.00,
0.00,             --120
@w_simbolo_moneda, --@w_simbolo_moneda,   --120
' ',
0,
' ',
@w_numero_operacion,                      --125
@levelIndeb,
@levelIndeb,
' ',
@w_numero_op_banco,                       --129
@levelIndeb,
' ',
@w_motivo_uno,           -- Etapa de rechazo
@w_motivo_dos,           -- Etapa de rechazo
@w_motivo_rechazo,       -- Etapa de rechazo
' ',
@w_linea_credito,
' ',
0,
@levelIndeb,
' ',
' ',
' ',
' ',
@w_op_vinculado as es_vinculado,
@w_parroquia,
@w_fecha_venci,
@w_clase,
@w_dias_anio,
@w_monto_aprobado,
@w_comentario,
isnull(@w_banca,''),                          --151
@w_tr_grupal,                                 --152
@w_promocion,     --LPO Santander             --153
@w_acepta_ren,    --LPO Santander             --154
@w_no_acepta,     --LPO Santander             --155
@w_emprendimiento, --LPO Santander            --156
@w_garantia,                                  --157
@w_sum_mont_grupal,          --Santander      --158
@w_sum_mont_grupal_sol,      --Santander      --159
convert(varchar(30), @w_numero_ciclo),
@w_alianza,                  -- Santander      --161
@w_tplazo,                  -- Santander       --162
@w_es_partner,              -- Santander       --163
@w_bc_lis_negra,            -- Santander       --164
@w_des_periodo,             -- Santander       --165--Antes:@w_tplazo_descrip
@w_experiencia_cli,         -- Santander       --166
@w_monto_max_tr,             -- Santander      --167
@w_tplazo_lcr,               -- Santander      --168
@w_fecha_con_disper,                           --169
@w_fecha_hab_disp,                             --170
@w_colectivo,                                  --171 SRO
ltrim(rtrim(@w_nivel_colectivo)),              --172 NME 13/08/2019
@w_ingresos_mensuales,                         --173 NME 13/08/2019
@w_es_candidato,                               --174
@w_gracia,                                     --175 SRO
@w_capacidad_pago_mensual                      --176 Caso#161210
if @i_es_acta = 'T' select @w_comite, @w_acta

return 0

ERROR_PROCESO:

return @w_error


GO
