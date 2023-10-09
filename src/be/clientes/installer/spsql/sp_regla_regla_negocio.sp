
/*************************************************************************/
/*   ARCHIVO:         sp_regla_regla_negocio.sp                          */
/*   NOMBRE LOGICO:   sp_regla_regla_negocio                             */
/*   Base de datos:   cobis                                              */
/*   PRODUCTO:        Credito                                            */
/*   Fecha de escritura:   Enero 2018                                    */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                     PROPOSITO                                         */
/*  Permite insertar alertas de los clientes cada semana, si se estan en */
/*  Listas negras o Negativ File                                         */
/*************************************************************************/
/*                     MODIFICACIONES                                    */
/*   FECHA         AUTOR            RAZON                                */
/* 28/Jun/2018    PXSG   Emision inicial                                 */
/* 27/Mayo/2019   PXSG   Se aumenta regla para                           */
/*                       credito individual revolvente caso 114569       */
/* 08/Ago/2019    PRO    Se evita alerta para fpago FALLECIDO            */
/* 19/Sept/2019   RMA    #126117 Se evita alerta para fpago FALLECIDO    */
/*************************************************************************/
USE cobis
go
IF OBJECT_ID ('dbo.sp_regla_regla_negocio') IS NOT NULL
    DROP PROCEDURE dbo.sp_regla_regla_negocio
GO

CREATE PROCEDURE sp_regla_regla_negocio (   
    @t_debug                char(1)         = 'N',
    @t_file                 varchar(10)     = null,
    @i_operacion        char(1) = NULL,
    @i_fecha_proceso        Datetime        = NULL,
    @i_meses_reportar   TINYINT = 1,
    @o_error_mens       varchar(255)  = null OUT
)
as 

DECLARE
    @w_sp_name               varchar(32),
    @w_mensaje_fallo_regla   varchar(100),
    @w_ejecutar_regla        char(1) = 'S',
    @w_variables             varchar(255),
    @w_result_values         varchar(max),
    @w_error                 int,
    @w_parent                int,
    @w_etiqueta              varchar(255),
    @w_tipo_alerta           varchar(255),
    @w_tipo_operacion        varchar(255),
    @w_nivel_obt_riesgo      varchar(255),
    @w_pos                   int,
    @w_monto_anti            money,     
    @w_monto_mxn             money,
    @w_monto_usd             money, 
    @w_monto_mxn_dia         money,
    @w_monto_usd_dia         money,
    @w_moneda_mxn            varchar(100),
    @w_moneda_usd            varchar(100),
    @w_valor_variable_regla  varchar(100),
    @w_fecha_proceso         datetime,
    @w_fecha_mes_ante        datetime,  
    @w_cotizacion            float,
    @w_error_mens            varchar(255),
    @w_id_sucursal           SMALLINT,
    @w_id_grupo              INT,
    @w_nombre_grupo          VARCHAR(64),
    @w_id_ente               INT,
    @w_nombre_cliente        VARCHAR(254),
    @w_rfc_cliente           VARCHAR(30),
    @w_num_contrato          INT,
    @w_tipo_Producto         VARCHAR(255),
    @w_tipo_lista            CHAR(2),
    @w_fecha_alerta          DATETIME,
    @w_fecha_operacion       DATETIME,
    @w_fecha_dictaminacion   DATETIME,
    @w_fecha_reporte         DATETIME,
    @w_observaciones         VARCHAR(255),
    @w_escenario             VARCHAR(300),
    @w_monto                 MONEY,
    @w_status                VARCHAR(30),
    @w_generar_reporte       VARCHAR(2),
    @w_periodo_mensual       CHAR(1),
    @w_periodo_diario        CHAR(1),
    @w_meses_reportar        TINYINT,
    @w_estatus_ei            varchar(2),
	@w_fecha_salida          datetime,
	@w_num_pa_rev_mes        int,
	@w_num_lim_pa_rev_mes    int,
	@num_cod_operacion       int,
    @num_operacion_rev       int,
    @w_reporte          varchar(10),
    @w_return           int,
    @w_existe_solicitud char (1) ,
    @w_ini_mes          datetime ,
    @w_fin_mes          datetime ,
    @w_fin_mes_hab      datetime ,
    @w_fin_mes_ant      datetime ,
    @w_fin_mes_ant_hab  DATETIME ,
    @w_mes_aux          int      ,
    @w_anio_aux         int      , 
    @w_fin_aux          datetime
    
          
/*  Inicializacion de Variables  */
select @w_sp_name = 'sp_regla_regla_negocio'

PRINT 'Ingreso a regla de negocio'
select @w_mensaje_fallo_regla = 'Fallo Ejecución Regla'

select @o_error_mens = '---' -- para validacion

if @i_fecha_proceso is null
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
else
   select @w_fecha_proceso = @i_fecha_proceso


if datepart(dd, @w_fecha_proceso) > 0 -- procesar con mes anterior
begin                  
    select @w_mes_aux  = datepart(mm,@w_fecha_proceso),
           @w_anio_aux = datepart(yy,@w_fecha_proceso)    
                    
    select @w_fin_aux = convert(datetime,convert(varchar,@w_mes_aux)+'/01/'+convert(varchar,@w_anio_aux))
end 

print ' @w_fin_aux= ' + isnull(convert(varchar,@w_fin_aux         ),'x')

set @w_reporte='NINGUN'
EXEC @w_return = cob_conta..sp_calcula_ultima_fecha_habil
     @i_reporte          = @w_reporte,
     @i_fecha            = @w_fin_aux,
     @o_existe_solicitud = @w_existe_solicitud  out,
     @o_ini_mes          = @w_ini_mes out,
     @o_fin_mes          = @w_fin_mes out,
     @o_fin_mes_hab      = @w_fin_mes_hab out,
     @o_fin_mes_ant      = @w_fin_mes_ant out,
     @o_fin_mes_ant_hab  = @w_fin_mes_ant_hab OUT
     
     if @w_return != 0
     begin
         select @w_error = @w_return
         --select @w_msg   = 'Fallo ejecucion cob_conta..sp_calcula_ultima_fecha_habil'
         goto ERROR
     end     

print ' @i_fecha_proceso    = ' + isnull(convert(varchar,@i_fecha_proceso  ),'x')  
print ' @w_fecha_proceso    = ' + isnull(convert(varchar,@w_fecha_proceso   ),'x')    
print ' @o_existe_solicitud = ' + convert(varchar,@w_existe_solicitud)
print ' @o_ini_mes          = ' + isnull(convert(varchar,@w_ini_mes         ),'x')
print ' @o_fin_mes          = ' + isnull(convert(varchar,@w_fin_mes         ),'x')
print ' @o_fin_mes_hab      = ' + isnull(convert(varchar,@w_fin_mes_hab     ),'x')
print ' @o_fin_mes_ant      = ' + isnull(convert(varchar,@w_fin_mes_ant     ),'x')
print ' @o_fin_mes_ant_hab  = ' + isnull(convert(varchar,@w_fin_mes_ant_hab ),'x')  

/* FECHA SALIDA */
select @w_fecha_salida = pa_datetime 
from   cobis..cl_parametro 
where  pa_nemonico = 'FCSALD' 
and    pa_producto='CLI' 
/*NUMERO DE PAGOS REVOLVENTE*/
select @w_num_pa_rev_mes=pa_int 
from cobis..cl_parametro
where pa_nemonico='NPAMRE'
and   pa_producto='REC'
/*NUMERO PAGO  LIMITE CREDITO REVOLVENTE */
SELECT @w_num_lim_pa_rev_mes=pa_int 
FROM cobis..cl_parametro 
WHERE pa_nemonico ='NLICRE'
AND pa_producto   ='REC'


select @w_meses_reportar = isnull(@i_meses_reportar,1)

--select @w_fecha_mes_ante = dateadd(m,-1*@w_meses_reportar, @w_fecha_proceso )
--Se encuentra el primer dia del mes a la fecha de ingreso
select @w_fecha_mes_ante = dateadd(dd, 1-datepart(dd, @w_fecha_proceso  ), @w_fecha_proceso )
select @w_moneda_mxn = mo_moneda from cobis..cl_moneda where mo_nemonico = 'MXN'    --0
select @w_moneda_usd = mo_moneda from cobis..cl_moneda where mo_nemonico = 'USD'    --2

set @w_periodo_mensual='M'
set @w_periodo_diario='D'
set @w_estatus_ei='EI'

--Buscar Cotizacion 


EXEC cob_cartera..sp_buscar_cotizacion
@i_moneda=@w_moneda_usd,
@i_fecha=@w_fecha_proceso,
@o_cotizacion=@w_cotizacion OUT
IF(@w_cotizacion IS null)
BEGIN
 select @w_error = 208937  --Error el grupo tiene un trámite en ejecución. 
 goto ERROR	
END

print'cotizacion'+ convert(VARCHAR(50),@w_cotizacion) 



--Ingreso borrando la tabla cl_alertas_riesgo pero solo los de las Reglas
-- LGU: no se borra xq se pierde las observaciones del usuario
/*********
delete cl_alertas_riesgo 
where ar_etiqueta IN( select clc.valor
                   from cobis..cl_tabla clt, cobis..cl_catalogo  clc 
                   where clt.codigo=clc.tabla
                   and  clt. tabla='cli_eti_reg_neg')
******/                   
--Tabla temporal pagos precancelaciones
DECLARE @temp_precancelacion AS TABLE 
(op_monto_precan MONEY,
 op_cliente      INT,
 op_monto_regla  money ,
 periodo_precan  CHAR (1),
 tproducto       VARCHAR(10),
 banco           varchar(32),
 oficina         smallint,
 fecha_operacion datetime,
 producto_riesgo int 
)

--Tabla temporal pagos mensuales en moneda nacional
declare @temp_pagos_mensual_mx AS TABLE 
(op_monto_mensual_mx MONEY,
 op_cliente INT,
 op_moneda_pg_mx INT ,
 periodo_pg_mx   CHAR (1),
 tproducto       VARCHAR(10),
 banco           varchar(32),
 oficina         smallint,
 fecha_operacion datetime,
 producto_riesgo int
)

--Tabla temporal pagos mensuales en dolares
declare @temp_pagos_mensual_usd AS TABLE 
(op_monto_mensual_do MONEY,
 op_monto_mensual_mnx MONEY,
 op_cliente INT,
 op_moneda_pg_usd INT ,
 periodo_pg_usd  CHAR (1),
 tproducto       VARCHAR(10),
 banco           varchar(32),
 oficina         smallint,
 fecha_operacion datetime,
 producto_riesgo int
)

--Tabla temporal pagos diarios en moneda nacional
declare @temp_pagos_dia_mnx AS TABLE 
(op_monto_dia_mnx MONEY,
 op_cliente INT ,
 op_moneda_pd_mnx INT ,
 periodo_pd_mnx CHAR (1),
 tproducto        VARCHAR(10),
 banco           varchar(32),
 oficina         smallint,
 fecha_operacion datetime,
 producto_riesgo int,
 dividendo       int,
 fecha_fin_div   datetime,
 secuencial      int
)

--Tabla temporal pagos diarios en moneda nacional
declare @temp_pagos_dia_usd AS TABLE 
(op_monto_dia_do MONEY,
 op_monto_dia_mnx MONEY,
 op_cliente      INT ,
 op_moneda_pd_usd INT ,
 periodo_pd_usd  CHAR (1),
 tproducto       VARCHAR(10),
 banco           varchar(32),
 oficina         smallint,
 fecha_operacion datetime,
 producto_riesgo int
)

--Tabla temporal resultado precancelacion
declare @temp_res_precan AS TABLE 
(op_monto_preca MONEY,
 op_cliente      INT,
 etiqueta        varchar(255),
 tipo_alerta     varchar(255),
 tipo_operacion  varchar(255),
 nivel_riesgo    varchar(255),
 tproducto       VARCHAR(10),
 banco           varchar(32),
 oficina         smallint,
 fecha_operacion datetime,
 producto_riesgo int
  
)

--Tabla temporal resultado pagos mensuales  en moneda nacional
declare @temp_res_pm_mx AS TABLE 
(op_monto_pm_mx MONEY,
 op_cliente      INT,
 etiqueta        varchar(255),
 tipo_alerta     varchar(255),
 tipo_operacion  varchar(255),
 nivel_riesgo    varchar(255),
 tproducto       VARCHAR(10),
 banco           varchar(32),
 oficina         smallint,
 fecha_operacion datetime,
 producto_riesgo int
  
)

--Tabla temporal resultado pagos mensuales  en dolares
declare @temp_res_pm_usd AS TABLE 
(op_monto_pm_usd MONEY,
 op_monto_pm_mnx MONEY,
 op_cliente      INT,
 etiqueta        varchar(255),
 tipo_alerta     varchar(255),
 tipo_operacion  varchar(255),
 nivel_riesgo    varchar(255),
 tproducto       VARCHAR(10),
 banco           varchar(32),
 oficina         smallint,
 fecha_operacion datetime,
 producto_riesgo int
  
)

--Tabla temporal resultado pagos diarios  en moneda nacional
declare @temp_res_pd_mx AS TABLE 
(op_monto_pd_mx MONEY,
 op_cliente      INT,
 etiqueta        varchar(255),
 tipo_alerta     varchar(255),
 tipo_operacion  varchar(255),
 nivel_riesgo    varchar(255),
 tproducto       VARCHAR(10),
 banco           varchar(32),
 oficina         smallint,
 fecha_operacion datetime,
 producto_riesgo int,
 dividendo       int,
 sec             int
  
)

--Tabla temporal resultado pagos diarios  en moneda nacional
declare @temp_res_pd_usd AS TABLE 
(op_monto_pd_usd MONEY,
 op_monto_pd_mnx MONEY,
 op_cliente      INT,
 etiqueta        varchar(255),
 tipo_alerta     varchar(255),
 tipo_operacion  varchar(255),
 nivel_riesgo    varchar(255),
 tproducto       VARCHAR(10),
 banco           varchar(32),
 oficina         smallint,
 fecha_operacion datetime,
 producto_riesgo int
  
)

--Tabla temporal de las reglas 
declare @temp_reglas_negocio AS TABLE 
(   monto_riesgo_ini     money,
    monto_riesgo_hasta   money,
    operador_monto      VARCHAR(20),
    operador_moneda      VARCHAR(20),
    moneda               INT,
    periodo              CHAR(1),
    producto             INT,
    etiqueta             VARCHAR(255),
    tipo_alerta          VARCHAR(255),
    tipo_operacion       VARCHAR(255),
    nivel_riesgo         VARCHAR(255)
) 
--Tabla temporal para los de la etiqueta 500
declare @temp_res_pm_usd_500 AS TABLE 
(op_monto_pm_usd_500 money,
 op_monto_pm_mnx_500 money,
 op_cliente_500      int,
 etiqueta_500        varchar(255),
 tipo_alerta_500     varchar(255),
 tipo_operacion_500  varchar(255),
 nivel_riesgo_500    varchar(255),
 tproducto_500       VARCHAR(10),
 banco_500           varchar(32),
 oficina_500         smallint,
 fecha_operacion_500 datetime,
 producto_riesgo_500 int 
  
)

--Tabla temporal para obtemer los que pagaron mas de 9000 pesos
declare @temp_res_pd_mx_9 AS TABLE 
(op_monto_pd_mx_9  money,
 op_cliente_9      int,
 etiqueta_9        varchar(255),
 tipo_alerta_9     varchar(255),
 tipo_operacion_9  varchar(255),
 nivel_riesgo_9    varchar(255),
 tproducto_9       VARCHAR(10),
 banco_9           varchar(32),
 oficina_9         smallint,
 fecha_operacion_9 datetime,
 producto_riesgo_9 int,
 dividendo_9       int,
 sec_9             int  
) 

--Tabla temporal pagos precancelaciones
DECLARE @temp_num_pagos_rev AS TABLE 
(op_monto_precan MONEY,
 op_cliente   INT,
 op_monto_regla  money ,
 periodo_precan  CHAR (1),
 tproducto       VARCHAR(10),
 banco           varchar(32),
 oficina         smallint,
 fecha_operacion DATETIME,
 producto_riesgo INT,
 num_pagos       INT,
 cuenta_num_pago CHAR(1)  
)

--Tabla temporal resultado precancelacion
declare @temp_res_num_pagos_rev AS TABLE 
(op_monto_preca        MONEY,
 op_cliente            INT,
 etiqueta              varchar(255),
 tipo_alerta           varchar(255),
 tipo_operacion        varchar(255),
 nivel_riesgo          varchar(255),
 tproducto             VARCHAR(10),
 banco                 varchar(32),
 oficina               smallint,
 fecha_operacion       DATETIME,
 producto_riesgo       INT,
 num_pagos_rev         INT,
 cuenta_num_pago_rev   CHAR(1) 
)

--tabla temporal para el numero de pagos liquidados para revolventes
CREATE TABLE #pagos_lid_rev(
tr_sec INT,
tr_ope  INT,
tr_tran CHAR(10),
tr_fecha_mov DATETIME,
incremento_cupo MONEY,
monto_pag MONEY
)

--tabla temporal para el numero de pagos liq revolvente    
DECLARE @temp_num_pagos_liq AS TABLE 
(op_monto_precan MONEY,
 op_cliente   INT,
 op_monto_regla  money ,
 periodo_precan  CHAR (1),
 tproducto       VARCHAR(10),
 banco           varchar(32),
 oficina         smallint,
 fecha_operacion DATETIME,
 producto_riesgo INT,
 num_pagos_liq       INT,
 cuenta_num_pago CHAR(1),
 tr_operacion int  
)  

--tabla temporal final  para el numero de pagos liq revolvente  
declare @temp_res_num_pagos_liq AS TABLE 
(op_monto_preca        MONEY,
 op_cliente            INT,
 etiqueta              varchar(255),
 tipo_alerta           varchar(255),
 tipo_operacion        varchar(255),
 nivel_riesgo          varchar(255),
 tproducto             VARCHAR(10),
 banco                 varchar(32),
 oficina               smallint,
 fecha_operacion       DATETIME,
 producto_riesgo       INT,
 num_pagos_liq         INT,
 cuenta_num_pago   CHAR(1) 
)

--Tabla temporal que guarda todos los datos de la cl_alertas_riesgo
declare @alertas_cli_monto as table 
(
    sucursal        int, 
    grupo           int,
    codigoCliente   int,
    nombreGrupo     varchar(64),
    nombreCliente   varchar(100), 
    rfc             varchar(30),
    contrato        varchar(24), 
    tipoProducto    varchar(255), 
    tipoLista       varchar(2), 
	fechaConsulta   datetime,
    fechaAlerta     datetime, 
    fechaOperacion  datetime, 
    fechaDictamina  datetime, 
    fechaReporte    datetime, 
    observaciones   varchar(255), 
    nivelRiesgo     varchar(255), 
    etiqueta        varchar(255), 
    escenario       varchar(300), 
    tipoAlerta      varchar(100), 
    tipoOperacion   varchar(255), 
    monto           money, 
    estadoAlerta    varchar(100), 
    generaReporte   varchar(2),
	codigoIP        int
)

--Tabla temporal que guarda todos los datos de la cl_alertas_riesgo
declare @alertas_cli_monto_diario as table 
(
    sucursal        int, 
    grupo           int,
    codigoCliente  int,
    nombreGrupo     varchar(64),
    nombreCliente   varchar(100), 
    rfc             varchar(30),
    contrato        varchar(24), 
    tipoProducto    varchar(255), 
    tipoLista       varchar(2), 
	fechaConsulta   datetime,
    fechaAlerta     datetime, 
    fechaOperacion  datetime, 
    fechaDictamina  datetime, 
    fechaReporte    datetime, 
    observaciones   varchar(255), 
    nivelRiesgo     varchar(255), 
    etiqueta        varchar(255), 
    escenario       varchar(300), 
    tipoAlerta      varchar(100), 
    tipoOperacion   varchar(255), 
    monto           money, 
    estadoAlerta    varchar(100), 
    generaReporte   varchar(2),
	codigoIP        int
)


insert into @temp_reglas_negocio
select  
      'monto_riesgo_ini'    = cr_etiqueta.cr_min_value,   
      'monto_riesgo_hasta'  = cr_etiqueta.cr_max_value,
      'operador_monto'      = cr_etiqueta.cr_operator, 
      'operador_moneda'     = cr_2.cr_operator, 
      'moneda'              = cr_2.cr_max_value,
      'periodo'             = cr_3.cr_max_value,
      'producto'            = cr_4.cr_max_value  ,
      'etiqueta'            = cr_5.cr_max_value  ,
      'tipo_alerta'         = cr_6.cr_max_value  ,
      'tipo_operacion'      = cr_7.cr_max_value ,
      'nivel_riesgo'        = cr_8.cr_max_value
from cob_pac..bpl_rule r

        inner join cob_pac..bpl_rule_version rv on rv.rl_id = r.rl_id
        
        inner join cob_pac..bpl_condition_rule cr_etiqueta on rv.rv_id = cr_etiqueta.rv_id and cr_etiqueta.cr_parent is null
        
        inner join cob_workflow..wf_variable v_cr_etiqueta on v_cr_etiqueta.vb_codigo_variable = cr_etiqueta.vd_id
        
        inner join cob_pac..bpl_condition_rule cr_2 on rv.rv_id = cr_2.rv_id and cr_2.cr_parent = cr_etiqueta.cr_id
        
        inner join cob_workflow..wf_variable v_2 on v_2.vb_codigo_variable = cr_2.vd_id
        
        inner join cob_pac..bpl_condition_rule cr_3 on rv.rv_id = cr_3.rv_id and cr_3.cr_parent = cr_2.cr_id
        
        inner join cob_workflow..wf_variable v_3 on v_3.vb_codigo_variable = cr_3.vd_id
        inner join cob_pac..bpl_condition_rule cr_4 on rv.rv_id = cr_4.rv_id and cr_4.cr_parent = cr_3.cr_id
        
        inner join cob_workflow..wf_variable v_4 on v_4.vb_codigo_variable = cr_4.vd_id
        inner join cob_pac..bpl_condition_rule cr_5 on rv.rv_id = cr_5.rv_id and cr_5.cr_parent = cr_4.cr_id
        
        inner join cob_workflow..wf_variable v_5 on v_5.vb_codigo_variable = cr_5.vd_id
        inner join cob_pac..bpl_condition_rule cr_6 on rv.rv_id = cr_6.rv_id and cr_6.cr_parent = cr_5.cr_id
        
        inner join cob_workflow..wf_variable v_6 on v_6.vb_codigo_variable = cr_6.vd_id
        inner join cob_pac..bpl_condition_rule cr_7 on rv.rv_id = cr_7.rv_id and cr_7.cr_parent = cr_6.cr_id
        
        inner join cob_workflow..wf_variable v_7 on v_7.vb_codigo_variable = cr_7.vd_id
        inner join cob_pac..bpl_condition_rule cr_8 on rv.rv_id = cr_8.rv_id and cr_8.cr_parent = cr_7.cr_id
        
        inner join cob_workflow..wf_variable v_8 on v_8.vb_codigo_variable = cr_8.vd_id
        
        where rl_acronym = 'REGNEGOCIO' and rv.rv_status = 'PRO'

--select * from  @temp_reglas_negocio
--update @temp_reglas_negocio SET monto_riesgo_hasta = 200 where monto_riesgo_ini IS NULL and monto_riesgo_hasta > 0
--update @temp_reglas_negocio SET monto_riesgo_hasta = 200 , monto_riesgo_ini = 0 where monto_riesgo_ini = 500 and monto_riesgo_hasta > 0
--update @temp_reglas_negocio SET monto_riesgo_hasta = 200 , monto_riesgo_ini = 0 where monto_riesgo_ini = 300000 and monto_riesgo_hasta > 0
--select * from  @temp_reglas_negocio



if @i_operacion = 'I'
begin   
       

   
   /*
   PAGOS MENSUALES
   */  
              
   if(@w_fecha_proceso=@w_fin_mes_hab)
   begin
  
       Print'Se ejecuta en Fin de Mes'
       
   /* 1.- Pago anticipado de los clientes del crédito grupal*/  
   insert into @temp_precancelacion
   select
        'monto_preca'    = sum(abd_monto_mn),
        'cliente'        = op_cliente,
        'op_monto_regla' = 0,
        'periodo'        = @w_periodo_mensual,
        'operacion'      = max(op_toperacion),
        'banco'          = max(op_banco),
        'oficina'         = max(op_oficina),
		'fecha_operacion'= max(ab_fecha_pag),
		'producto'       = 1 --solo grupal
   from  cob_cartera..ca_abono, 
         cob_cartera..ca_abono_det,
         cob_cartera..ca_operacion
   where ab_operacion         = abd_operacion
   and   ab_secuencial_ing    = abd_secuencial_ing 
   and   ab_operacion         = op_operacion
   and   ab_estado            = 'A'
   and   op_estado            = 3 --CANCELADO
   and   op_fecha_ult_proceso BETWEEN @w_ini_mes AND @w_fin_mes 																
   and   op_fecha_ult_proceso < op_fecha_fin
   and   op_fecha_ult_proceso between op_fecha_liq and dateadd(m,@w_meses_reportar, op_fecha_liq )--durante el primer mes
   and   ab_fecha_pag         between op_fecha_liq and dateadd(m,@w_meses_reportar, op_fecha_liq )--durante el primer mes
   and   ab_fecha_pag         >= @w_fecha_salida
   and   op_toperacion        ='GRUPAL'
   and abd_concepto NOT IN ('SOBRANTE','FALLECIDO')
   GROUP BY op_cliente,op_banco
     
   insert into @temp_res_precan
   select 
        'op_monto_preca' = op_monto_precan, 
        'op_cliente'     = op_cliente ,  
        'etiqueta'       = etiqueta,   
        'tipo_alerta'    = tipo_alerta ,
        'tipo_operacion' = tipo_operacion,
        'nivel_riesgo'   = nivel_riesgo,  
        'operacion'      = tproducto,
        'banco'          = banco,
        'oficina'         = oficina,
		'fecha_operacion' = fecha_operacion,
		'producto'       = producto_riesgo
   from @temp_precancelacion,@temp_reglas_negocio
   where monto_riesgo_hasta = op_monto_regla
   and   periodo            = periodo_precan
   and   producto           = producto_riesgo
   ORDER BY op_cliente ASC
             
   /*2.- Moneda Nacional Mensual*/
   insert into  @temp_pagos_mensual_mx
   select 
        'monto_mensual_mnx'= sum(abd_monto_mn),
        'cliente'          = op_cliente,
        'moneda_mnx'       = @w_moneda_mxn,
        'perido_m'         = @w_periodo_mensual, 
        'operacion'        = max(op_toperacion),
        'banco'            = max(op_banco),
        'oficina'          = max(op_oficina),
		'fecha_operacion'  = max(ab_fecha_pag),
		'producto'         =4	
   from  cob_cartera..ca_abono, 
         cob_cartera..ca_abono_det, 
         cob_cartera..ca_operacion
   where ab_operacion         = abd_operacion
   and   ab_secuencial_ing    = abd_secuencial_ing 
   and   ab_operacion         = op_operacion
   and   op_estado     not in (0,99)
   and   ab_estado     = 'A'
   and   ab_fecha_pag  between @w_fecha_mes_ante and @w_fecha_proceso-- fecha entre mes
   and   ab_fecha_pag  >= @w_fecha_salida
   and   abd_moneda    = @w_moneda_mxn 
   and   abd_concepto NOT IN ('SOBRANTE','FALLECIDO')
   GROUP BY op_cliente,op_banco
           
   insert into @temp_res_pm_mx
   select 
        'op_monto_pm_mx' = op_monto_mensual_mx, 
        'Cliente'        = op_cliente ,  
        'Etiqueta'       = etiqueta,   
        'Tipo_alerta'    = tipo_alerta ,
        'Tipo_operacion' = tipo_operacion,
        'Nivel_riesgo'   = nivel_riesgo,
        'operacion'      = tproducto,
        'banco'          = banco,
        'oficina'         = oficina,
		'fecha_operacion' = fecha_operacion,
		'producto'        = producto_riesgo
   from @temp_pagos_mensual_mx,@temp_reglas_negocio
   where ( (operador_monto='>=' and op_monto_mensual_mx >=monto_riesgo_hasta) 
          OR ((op_monto_mensual_mx BETWEEN monto_riesgo_ini and monto_riesgo_hasta )and lower(operador_monto)=lower('between' )))
   and op_moneda_pg_mx = moneda
   and periodo_pg_mx   = periodo
   and producto        = producto_riesgo
              
   /*3.-Moneda Extranjera Mensual*/  
   insert into @temp_pagos_mensual_usd 
   select 
        'monto_mensual_usd' = ((sum(abd_monto_mn))/@w_cotizacion) ,
        'monto_mensual_mnx' = (sum(abd_monto_mn)),
        'cliente'           = op_cliente,
        'moneda_usd'        = @w_moneda_usd,
        'perido_m'          = @w_periodo_mensual,
        'operacion'        = max(op_toperacion),
        'banco'            = max(op_banco),
        'oficina'           = max(op_oficina),
		'fecha_operacion'   = max(ab_fecha_pag),
		'producto'          = 4
   from  cob_cartera..ca_abono, 
         cob_cartera..ca_abono_det, 
         cob_cartera..ca_operacion
   where ab_operacion         = abd_operacion
   and   ab_secuencial_ing    = abd_secuencial_ing 
   and   ab_operacion         = op_operacion
   and   op_estado not in (0,99)
   and   ab_estado     = 'A'
   and   ab_fecha_pag between @w_fecha_mes_ante and @w_fecha_proceso --fecha entre mes
   and   abd_moneda    = @w_moneda_mxn
   and   abd_concepto NOT IN ('SOBRANTE','FALLECIDO')
   and   ab_fecha_pag         >= @w_fecha_salida
   GROUP BY op_cliente,op_banco
           
 
   insert into @temp_res_pm_usd
   select 
        'op_monto_pm_usd' = op_monto_mensual_do, 
        'op_monto_pm_mnx' = op_monto_mensual_mnx, 
        'Cliente'        = op_cliente ,  
        'Etiqueta'       = etiqueta,   
        'Tipo_alerta'    = tipo_alerta ,
        'Tipo_operacion' = tipo_operacion,
        'Nivel_riesgo'   = nivel_riesgo  ,
        'operacion'      = tproducto,
        'banco'          = banco,
        'oficina'         = oficina,
		'fecha_operacion' = fecha_operacion,
		'producto'        = producto_riesgo
   from @temp_pagos_mensual_usd,@temp_reglas_negocio
   where ( (operador_monto='>=' and op_monto_mensual_do >=monto_riesgo_hasta) 
        OR ((op_monto_mensual_do BETWEEN monto_riesgo_ini and monto_riesgo_hasta ) and lower(operador_monto)=lower('between' )) )
   and op_moneda_pg_usd = moneda
   and periodo_pg_usd   = periodo
   and producto         = producto_riesgo

   --Inserto en tabla demporal  los de Etiqueta 'AML_MOEXT_500'
  insert into @temp_res_pm_usd_500
  select * from @temp_res_pm_usd 
  where etiqueta ='AML_MOEXT_500'
  
  --Elimino de la tabla temporal los que encontro con etiqueta
  --'AML_MOEXT_500'  
  delete from @temp_res_pm_usd
  where etiqueta ='AML_MOEXT_500'
  
  select * from  @temp_res_pm_usd_500
  
  select * from 
  @temp_res_pm_usd_500
  where tproducto_500='GRUPAL'
 
 --Resto el valor de sus Cuota al Monto pagado Para Los Grupales
  update @temp_res_pm_usd_500
  set op_monto_pm_usd_500=op_monto_pm_usd_500
    -(  select isnull(sum(am_cuota)/@w_cotizacion,0)--Cotizacion 
        from cob_cartera..ca_amortizacion, 
        cob_cartera..ca_dividendo,
        cob_cartera..ca_operacion
        where am_operacion = di_operacion
        and am_dividendo   = di_dividendo
        and am_operacion   = op_operacion
        and di_fecha_ven between @w_fecha_mes_ante and @w_fecha_proceso
        and op_banco=banco_500
        --and di_estado=3
        )
      where tproducto_500 not in ('REVOLVENTE' )
      
 --Resto el valor de sus Cuota al Monto pagado Para Los Revolventes
  update @temp_res_pm_usd_500
     set op_monto_pm_usd_500=(op_monto_pm_usd_500-
                            (SELECT isnull(sum(dtr_monto)/@w_cotizacion,0)
                            FROM cob_cartera..ca_transaccion,cob_cartera..ca_det_trn,
                            cob_cartera..ca_operacion
                            WHERE tr_secuencial = dtr_secuencial
                            AND tr_operacion =dtr_operacion
                            and op_operacion=tr_operacion
                            AND tr_secuencial>0
                            AND tr_estado<>'RV'
                            AND dtr_concepto='CAP'      
                            AND tr_fecha_ref between @w_fecha_mes_ante and @w_fecha_proceso
                            and op_banco=banco_500
                            AND tr_toperacion='REVOLVENTE'
                            and tr_tran='DES'
                               ))
        where tproducto_500='REVOLVENTE'  
     
   select * from  @temp_res_pm_usd_500     
   --ejecuto nuevamnete la tabla @temp_res_pm_usd para ver que registros nomas cauen en la regla 
   --restado el valor de sus cuotas   
   insert into @temp_res_pm_usd
   select 
        'op_monto_pm_usd_500' =op_monto_pm_usd_500, 
        'op_monto_pm_mnx' =op_monto_pm_usd_500*@w_cotizacion,
        'Cliente'        = op_cliente_500  ,   
        'Etiqueta'       = tmp.etiqueta ,      
        'Tipo_alerta'    = tmp.tipo_alerta ,   
        'Tipo_operacion' = tmp.tipo_operacion ,
        'Nivel_riesgo'   = tmp.nivel_riesgo ,  
        'operacion'      = tproducto_500  ,    
        'banco'          = banco_500 ,         
        'oficina'         =oficina_500 ,       
		'fecha_operacion' =fecha_operacion_500,
		'producto'       = producto_riesgo_500
   from @temp_res_pm_usd_500 pm_500,@temp_reglas_negocio tmp
   where ( (operador_monto='>=' and op_monto_pm_usd_500 >=monto_riesgo_hasta) 
        OR ((op_monto_pm_usd_500 between monto_riesgo_ini and monto_riesgo_hasta ) and lower(operador_monto)=lower('between' )) )
   and   producto  = producto_riesgo_500
   and   periodo   = @w_periodo_mensual
   and   moneda    = @w_moneda_usd

   
   select * from @temp_res_pm_usd    
   
      --4 Numero de pagos Revolvente Mensual 
   insert into @temp_num_pagos_rev
   select 
        'monto_pagado'    = sum(abd_monto_mn),
        'cliente'         = op_cliente,
        'op_monto_regla'  = 0,
        'periodo'         = 'M',
        'operacion'       = max(op_toperacion),
        'banco'           = max(op_banco),
        'oficina'         = max(op_oficina),
		'fecha_operacion' = max(ab_fecha_pag),
		'producto'        = case WHEN max(op_toperacion) = 'REVOLVENTE' THEN 2
		                         WHEN max(op_toperacion) = 'INDIVIDUAL' THEN 3
		                    end     , --Individual/Revolvente
		'Numero pagos'    = count(*),
		'cuenta num pagos'='S'
   from  cob_cartera..ca_abono, 
         cob_cartera..ca_abono_det, 
         cob_cartera..ca_operacion
   where ab_operacion         = abd_operacion
   and   ab_secuencial_ing    = abd_secuencial_ing 
   and   ab_operacion         = op_operacion
   and   op_estado     not in (0,99)
   and   ab_estado     = 'A'
   and   ab_fecha_pag  between @w_fecha_mes_ante and @w_fecha_proceso-- fecha entre mes
   and   ab_fecha_pag  >= @w_fecha_salida
   and   abd_moneda    = @w_moneda_mxn 
   and   abd_concepto not in ('SOBRANTE','FALLECIDO')
   and   op_toperacion in('REVOLVENTE','INDIVIDUAL')
   group by op_cliente,op_banco
   
   select * from @temp_num_pagos_rev

   insert into @temp_res_num_pagos_rev
   select 
        'op_monto_preca' = op_monto_precan, 
        'op_cliente'     = op_cliente ,  
        'etiqueta'       = etiqueta,   
        'tipo_alerta'    = tipo_alerta ,
        'tipo_operacion' = tipo_operacion,
        'nivel_riesgo'   = nivel_riesgo,  
        'operacion'      = tproducto,
        'banco'          = banco,
        'oficina'         = oficina,
		'fecha_operacion' = fecha_operacion,
		'producto'       = producto_riesgo,
		'num_pagos'      = num_pagos,
		'cuenta num pagos'='S'
   from @temp_num_pagos_rev,@temp_reglas_negocio
   where monto_riesgo_hasta = op_monto_regla
   and   periodo            = periodo_precan
   and   producto           = producto_riesgo
   AND   num_pagos>isnull(@w_num_pa_rev_mes,20)
   ORDER BY op_cliente ASC
   
      --5 Numero de pagos limite de credito Revolvente
   insert into #pagos_lid_rev
   select 
         ab_secuencial_pag,
         op_operacion,
         ab_tipo,
         ab_fecha_pag,
        isnull((select max(ic_monto_aprobado_fin) 
                from cob_cartera..ca_incremento_cupo
                 where ic_operacion=op_operacion
                 and ic_fecha_proceso<ab_fecha_pag),
               (select op_monto_aprobado 
                from cob_cartera..ca_operacion 
                 where op_operacion=op.op_operacion
                )
                ),
         sum(abd_monto_mn) 
   from  cob_cartera..ca_abono, 
         cob_cartera..ca_abono_det, 
         cob_cartera..ca_operacion op
   where ab_operacion         = abd_operacion
   and   ab_secuencial_ing    = abd_secuencial_ing 
   and   ab_operacion         = op_operacion
   and   op_estado     not in (0,99)
   and   ab_estado     = 'A'
   and   ab_fecha_pag  between @w_fecha_mes_ante and @w_fecha_proceso-- fecha entre mes
   and   ab_fecha_pag  >= @w_fecha_salida
   and   abd_moneda     = @w_moneda_mxn 
   and   abd_concepto not in ('SOBRANTE')
   and   op_toperacion in('REVOLVENTE')
   group by ab_secuencial_pag,op_operacion,ab_tipo,ab_fecha_pag
   
   insert into @temp_num_pagos_liq
   select 
        'monto_pagado'    = sum(abd_monto_mn),
        'cliente'         = op_cliente,
        'op_monto_regla'  = 0,
        'periodo'         = 'M',
        'operacion'       = max(op_toperacion),
        'banco'           = max(op_banco),
        'oficina'         = max(op_oficina),
		'fecha_operacion'   = max(ab_fecha_pag),
		'producto'        = 2,--Individual Revolvente
		'Numero pagos'    = 0,
		'cuenta num pagos'= 'N',
		'operacion'         = op_operacion 
   from  cob_cartera..ca_abono, 
         cob_cartera..ca_abono_det, 
         cob_cartera..ca_operacion op
   where ab_operacion         = abd_operacion
   and   ab_secuencial_ing    = abd_secuencial_ing 
   and   ab_operacion         = op_operacion
   and   op_estado     not in (0,99)
   and   ab_estado     = 'A'
   and   ab_fecha_pag  between @w_fecha_mes_ante and @w_fecha_proceso-- fecha entre mes
   and   ab_fecha_pag  >= @w_fecha_salida
   and   abd_moneda     = @w_moneda_mxn 
   and   abd_concepto not in ('SOBRANTE','FALLECIDO')
   and   op_toperacion in('REVOLVENTE')
   group by op_cliente,op_banco,op_operacion
       
   update @temp_num_pagos_liq
    set num_pagos_liq=( select count(*) from
              #pagos_lid_rev
                        where monto_pag >= incremento_cupo
              and tr_operacion=tr_ope
               )      
      
   select * from #pagos_lid_rev 
     
   select * from @temp_num_pagos_liq


   insert into @temp_res_num_pagos_liq
   select 
        'op_monto_preca' = op_monto_precan, 
        'op_cliente'     = op_cliente ,  
        'etiqueta'       = etiqueta,   
        'tipo_alerta'    = tipo_alerta ,
        'tipo_operacion' = tipo_operacion,
        'nivel_riesgo'   = nivel_riesgo,  
        'operacion'      = tproducto,
        'banco'          = banco,
        'oficina'         = oficina,
		'fecha_operacion' = fecha_operacion,
		'producto'       = producto_riesgo,
		'num_pagos'      = num_pagos_liq,
		'cuenta num pagos'='N'
   from @temp_num_pagos_liq,@temp_reglas_negocio
   where monto_riesgo_hasta = op_monto_regla
   and   periodo            = periodo_precan
   and   producto           = producto_riesgo
   and   num_pagos_liq      > isnull(@w_num_lim_pa_rev_mes,8)
   order by op_cliente asc
   
   select * from @temp_res_num_pagos_liq   
   
      /* Insercion en la tabla temporal*/
      
       --4.- Insercion en la @alertas_cli_monto el resultado de la regla de numero de pagos revolvente Mensual
   insert into @alertas_cli_monto
   select  
   'sucursal'          = oficina,
   'grupo'             = (select cg_grupo from cobis..cl_cliente_grupo where cg_ente = en.en_ente 
                          and cg_estado ='V' and cg_fecha_desasociacion IS NULL ),
   'codigoCliente'     = op_cliente,
   'nombreGrupo'       = (select gr_nombre from cobis..cl_grupo where gr_grupo = (select top 1 cg_grupo from cobis..cl_cliente_grupo 
                             where cg_ente = en.en_ente and cg_estado = 'V' and cg_fecha_desasociacion IS NULL )),
   'nombreCliente'     = isnull(en.en_nombre,'')+ ' ' +isnull(en.p_s_nombre,'')+ ' ' +isnull(en.p_p_apellido,'') +' ' +isnull(en.p_s_apellido,''),
   'rfc'               = isnull(en.en_nit,en.en_rfc),
   'contrato'          = banco,
   'tipoProducto'      = tproducto,
   'tipoLista'         = (select clc.codigo from cobis..cl_tabla clt, cobis..cl_catalogo  clc 
                            where clt.codigo = clc.tabla and  clt. tabla = 'cl_alertas_tlista' 
                            and clc.valor = pre.tipo_operacion),
	'fechaConsulta'    = @w_fecha_proceso,						 
   'fechaAlerta'       = @w_fecha_proceso,
   'fechaOperacion'    = fecha_operacion,
   'fechaDictamina'    = null,
   'fechaReporte'      = null,
   'observaciones'     = null,
   'nivelRiesgo'       = pre.nivel_riesgo,
   'etiqueta'          = pre.etiqueta,
   'escenario'         = (select TOP 1 reg_neg_descripcion from cobis..cl_cat_reg_negocio where reg_neg_etiqueta = pre.etiqueta
                            AND reg_neg_cuenta_pagos='S'),
   'tipoAlerta'        = pre.tipo_alerta, 
   'tipoOperacion'     = pre.tipo_operacion,
   'monto'             = pre.op_monto_preca,
   'estado'            = 'EI',
   'generaReporte'     = null,
   'codigoIP'         = null
   from @temp_res_num_pagos_rev pre,cobis..cl_ente en
   where pre.op_cliente = en.en_ente
   and  cuenta_num_pago_rev ='S'
   
   --Se actualiza el monto y la fecha de consulta si existe la misma alerta para ese mes  
   update cobis..cl_alertas_riesgo SET
   ar_fecha_consulta=fechaConsulta,
   ar_monto = monto
   from  @alertas_cli_monto 
   where ar_ente     = codigoCliente
   and ar_tipo_lista = tipoLista
   and ar_etiqueta   = etiqueta
   and ltrim(rtrim(ar_escenario))  = (select TOP 1 ltrim(rtrim(reg_neg_descripcion))  
                                                  from cobis..cl_cat_reg_negocio
                                                  where reg_neg_etiqueta='AML_PAN_1'
                                                  and   reg_neg_cuenta_pagos='S')
   and ar_fecha_alerta between @w_fecha_mes_ante and @w_fecha_proceso --cuando la regla este entre el primer dia del mes de la fecha de proceso	
   
   --Se elimina de la tabla temporal cuan ya existe una alerta revolvente para el mismo mes
   delete @alertas_cli_monto 
   from cobis..cl_alertas_riesgo 
   where ar_ente     = codigoCliente
   and ar_tipo_lista = tipoLista
   and ar_etiqueta   = etiqueta
   and ltrim(rtrim(ar_escenario))  = (select TOP 1 ltrim(rtrim(reg_neg_descripcion))  
                                                  from cobis..cl_cat_reg_negocio
                                                  where reg_neg_etiqueta='AML_PAN_1'
                                                  and   reg_neg_cuenta_pagos='S')
   and ar_fecha_alerta between @w_fecha_mes_ante AND @w_fecha_proceso --cuando la regla este entre el primer dia del mes de la fecha de proceso	

   SELECT * FROM @alertas_cli_monto
    
      --5 Insercion en la @alertas_cli_monto el resultado de la regal de Numero de pagos limite de credito Revolvente Mensual
   insert into @alertas_cli_monto
   select  
   'sucursal'          = oficina,
   'grupo'             = (select cg_grupo from cobis..cl_cliente_grupo where cg_ente = en.en_ente 
                          and cg_estado ='V' and cg_fecha_desasociacion IS NULL ),
   'codigoCliente'     = op_cliente,
   'nombreGrupo'       = (select gr_nombre from cobis..cl_grupo where gr_grupo = (select top 1 cg_grupo from cobis..cl_cliente_grupo 
                             where cg_ente = en.en_ente and cg_estado = 'V' and cg_fecha_desasociacion IS NULL )),
   'nombreCliente'     = isnull(en.en_nombre,'')+ ' ' +isnull(en.p_s_nombre,'')+ ' ' +isnull(en.p_p_apellido,'') +' ' +isnull(en.p_s_apellido,''),
   'rfc'               = isnull(en.en_nit,en.en_rfc),
   'contrato'          = banco,
   'tipoProducto'      = tproducto,
   'tipoLista'         = (select clc.codigo from cobis..cl_tabla clt, cobis..cl_catalogo  clc 
                            where clt.codigo = clc.tabla and  clt. tabla = 'cl_alertas_tlista' 
                            and clc.valor = pre.tipo_operacion),
	'fechaConsulta'    = @w_fecha_proceso,						 
   'fechaAlerta'       = @w_fecha_proceso,
   'fechaOperacion'    = fecha_operacion,
   'fechaDictamina'    = null,
   'fechaReporte'      = null,
   'observaciones'     = null,
   'nivelRiesgo'       = pre.nivel_riesgo,
   'etiqueta'          = pre.etiqueta,
   'escenario'         = (select TOP 1 reg_neg_descripcion from cobis..cl_cat_reg_negocio where reg_neg_etiqueta = pre.etiqueta
                            AND reg_neg_cuenta_pagos='N'),
   'tipoAlerta'        = pre.tipo_alerta, 
   'tipoOperacion'     = pre.tipo_operacion,
   'monto'             = pre.op_monto_preca,
   'estado'            = 'EI',
   'generaReporte'     = null,
	'codigoIP'         = null
   from @temp_res_num_pagos_liq pre,cobis..cl_ente en
   where pre.op_cliente = en.en_ente
   and  cuenta_num_pago ='N'
   
   --se actualiza el monto y la fecha de consulta si existe la misma alerta para ese mes  
   update cobis..cl_alertas_riesgo SET
   ar_fecha_consulta=fechaConsulta,
   ar_monto = monto
   from  @alertas_cli_monto 
   where ar_ente     = codigoCliente
   and ar_tipo_lista = tipoLista
   and ar_etiqueta   = etiqueta
   and ltrim(rtrim(ar_escenario))  = (select TOP 1 ltrim(rtrim(reg_neg_descripcion))  
                                                  from cobis..cl_cat_reg_negocio
                                                  where reg_neg_etiqueta='AML_PAN_1'
                                                  and   reg_neg_cuenta_pagos='N')
   and ar_fecha_alerta between @w_fecha_mes_ante AND @w_fecha_proceso --cuando la regla este entre el primer dia del mes de la fecha de proceso	
   
   --Se elimina de la tabla temporal cuan ya existe una alerta revolvente para el mismo mes
   delete @alertas_cli_monto 
   from cobis..cl_alertas_riesgo 
   where ar_ente     = codigoCliente
   and ar_tipo_lista = tipoLista
   and ar_etiqueta   = etiqueta
   and ltrim(rtrim(ar_escenario))  = (select TOP 1 ltrim(rtrim(reg_neg_descripcion))  
                                                  from cobis..cl_cat_reg_negocio
                                                  where reg_neg_etiqueta='AML_PAN_1'
                                                  and   reg_neg_cuenta_pagos='N')
   and ar_fecha_alerta between @w_fecha_mes_ante AND @w_fecha_proceso --cuando la regla este entre el primer dia del mes de la fecha de proceso	

  
  select * from @alertas_cli_monto

   ---1.- Insercion en la tabla cl_alertas_riesgo para precancelacion   
   insert into @alertas_cli_monto
   select  
   'sucursal'          = oficina,
   'grupo'             = (select cg_grupo from cobis..cl_cliente_grupo where cg_ente = en.en_ente 
                          and cg_estado ='V' and cg_fecha_desasociacion IS NULL ),
   'codigoCliente'     = op_cliente,
   'nombreGrupo'       = (select gr_nombre from cobis..cl_grupo where gr_grupo = (select top 1 cg_grupo from cobis..cl_cliente_grupo 
                             where cg_ente = en.en_ente and cg_estado = 'V' and cg_fecha_desasociacion IS NULL )),
   'nombreCliente'     = isnull(en.en_nombre,'')+ ' ' +isnull(en.p_s_nombre,'')+ ' ' +isnull(en.p_p_apellido,'') +' ' +isnull(en.p_s_apellido,''),
   'rfc'               = isnull(en.en_nit,en.en_rfc),
   'contrato'          = banco,
   'tipoProducto'      = tproducto,
   'tipoLista'         = (select clc.codigo from cobis..cl_tabla clt, cobis..cl_catalogo  clc 
                            where clt.codigo = clc.tabla and  clt. tabla = 'cl_alertas_tlista' 
                            and clc.valor = pre.tipo_operacion),
	'fechaConsulta'     = @w_fecha_proceso,						 
   'fechaAlerta'       = @w_fecha_proceso,
   'fechaOperacion'    = fecha_operacion,
   'fechaDictamina'    = null,
   'fechaReporte'      = null,
   'observaciones'     = null,
   'nivelRiesgo'       = pre.nivel_riesgo,
   'etiqueta'          = pre.etiqueta,
   'escenario'         = (select TOP 1 reg_neg_descripcion from cl_cat_reg_negocio where reg_neg_etiqueta = pre.etiqueta),
   'tipoAlerta'        = pre.tipo_alerta, 
   'tipoOperacion'     = pre.tipo_operacion,
   'monto'             = pre.op_monto_preca,
   'estado'            = @w_estatus_ei,
   'generaReporte'     = null,
	'codigoIP'          = null
   from @temp_res_precan pre,cobis..cl_ente en
   where pre.op_cliente = en.en_ente
   --and fecha_operacion between @w_fecha_mes_ante and @w_fecha_proceso
   --elimino cuando ya precnacelo anteriormente
   delete @alertas_cli_monto 
   from cobis..cl_alertas_riesgo 
   where ar_ente     = codigoCliente
   and ar_tipo_lista = tipoLista
   and ar_etiqueta   = etiqueta
   
    ---2.- Insercion en la tabla @alertas_cli_monto mensual moneda Nacional    
   insert into @alertas_cli_monto
   select  
   'sucursal'          = oficina,
   'grupo'             = (select cg_grupo from cobis..cl_cliente_grupo where cg_ente = en.en_ente 
                          and cg_estado='V' and cg_fecha_desasociacion IS NULL ),
   'codigoCliente'     = op_cliente,
   'nombreGrupo'       = (select gr_nombre from cobis..cl_grupo where gr_grupo = (select top 1 cg_grupo from cobis..cl_cliente_grupo 
                             where cg_ente = en.en_ente and cg_estado = 'V' and cg_fecha_desasociacion IS NULL )),
   'nombreCliente'     = isnull(en.en_nombre,'')+ ' ' +isnull(en.p_s_nombre,'')+ ' ' +isnull(en.p_p_apellido,'') +' ' +isnull(en.p_s_apellido,''),
   'rfc'               = isnull(en.en_nit,en.en_rfc),
   'contrato'          = banco,
   'tipoProducto'      = tproducto,
   'tipoLista'         = (select clc.codigo from cobis..cl_tabla clt, cobis..cl_catalogo  clc 
                            where clt.codigo = clc.tabla and  clt. tabla='cl_alertas_tlista' 
                            and clc.valor    = pmnx.tipo_operacion),
   'fechaConsulta'     = @w_fecha_proceso,						 
   'fechaAlerta'       = @w_fecha_proceso,
   'fechaOperacion'    = fecha_operacion,
   'fechaDictamina'    = null,
   'fechaReporte'      = null,
   'observaciones'     = null,
   'nivelRiesgo'       = pmnx.nivel_riesgo,
   'etiqueta'          = pmnx.etiqueta,
   'escenario'         = (select TOP 1 reg_neg_descripcion from cl_cat_reg_negocio where reg_neg_etiqueta = pmnx.etiqueta),
   'tipoAlerta'        = pmnx.tipo_alerta, 
   'tipoOperacion'     = pmnx.tipo_operacion,
   'monto'             = pmnx.op_monto_pm_mx,
   'estado'            = @w_estatus_ei,
   'generaReporte'     = null,
   'codigoIP'          = null
   from @temp_res_pm_mx pmnx,cobis..cl_ente en
   where pmnx.op_cliente = en.en_ente  
        
    --3 Insercion en la tabla @alertas_cli_monto mensual dolares    
    insert into @alertas_cli_monto
    select
   'sucursal'          = oficina,
   'grupo'             = (select cg_grupo from cobis..cl_cliente_grupo where cg_ente = en.en_ente 
                          and cg_estado ='V' and cg_fecha_desasociacion IS NULL ),
   'codigoCliente'     = op_cliente,
   'nombreGrupo'       = (select gr_nombre from cobis..cl_grupo where gr_grupo = (select top 1 cg_grupo from cobis..cl_cliente_grupo 
                             where cg_ente = en.en_ente and cg_estado = 'V' and cg_fecha_desasociacion IS NULL )),
   'nombreCliente'     = isnull(en.en_nombre,'')+ ' ' +isnull(en.p_s_nombre,'')+ ' ' +isnull(en.p_p_apellido,'') +' ' +isnull(en.p_s_apellido,''),
   'rfc'               = isnull(en.en_nit,en.en_rfc),
   'contrato'          = banco,
   'tipoProducto'      = tproducto,
   'tipoLista'         = (select clc.codigo from cobis..cl_tabla clt, cobis..cl_catalogo  clc 
                            where clt.codigo = clc.tabla and  clt. tabla = 'cl_alertas_tlista' 
                            and clc.valor=pmusd.tipo_operacion),
   'fechaConsulta'     = @w_fecha_proceso,						 
   'fechaAlerta'       = @w_fecha_proceso,
   'fechaOperacion'    = fecha_operacion,
   'fechaDictamina'    = null,
   'fechaReporte'      = null,
   'observaciones'     = null,
   'nivelRiesgo'       = pmusd.nivel_riesgo,
   'etiqueta'          = pmusd.etiqueta,
   'escenario'         = (select TOP 1 reg_neg_descripcion from cl_cat_reg_negocio where reg_neg_etiqueta = pmusd.etiqueta),
   'tipoAlerta'        = pmusd.tipo_alerta, 
   'tipoOperacion'     = pmusd.tipo_operacion,
   'monto'             = pmusd.op_monto_pm_mnx,
   'estado'            = @w_estatus_ei,
   'generaReporte'     = null,
   'codigoIP'          = null
   from @temp_res_pm_usd pmusd,cobis..cl_ente en
   where pmusd.op_cliente = en.en_ente
       
   --se actualiza la fecha de consulta y el monto para alertas mensuales
   update cobis..cl_alertas_riesgo SET
   ar_fecha_consulta=fechaConsulta,
   ar_monto = monto
   from  @alertas_cli_monto 
   where ar_ente     = codigoCliente
   and ar_tipo_lista = tipoLista
   and ar_etiqueta   = etiqueta
      and ar_fecha_alerta between @w_fecha_mes_ante and @w_fecha_proceso --cuando la regla este entre el primer dia del mes de la fecha de proceso	
   
   
   delete @alertas_cli_monto 
   from cobis..cl_alertas_riesgo 
   where ar_ente     = codigoCliente
   and ar_tipo_lista = tipoLista
   and ar_etiqueta   = etiqueta
   and ar_fecha_alerta between @w_fecha_mes_ante and @w_fecha_proceso --cuando la regla este entre el primer dia del mes de la fecha de proceso	
   
      select etiqueta,* from @alertas_cli_monto
      
      --inserto en la cl_Alertas diario cuando es mensual
      insert into cobis..cl_alertas_riesgo
      select 
      sucursal,
      grupo,
      codigoCliente, 
      nombreGrupo,
      nombreCliente, 
      rfc,
      contrato, 
      tipoProducto,
      tipoLista, 
      fechaConsulta,	   
      fechaAlerta, 
      fechaOperacion, 
      fechaDictamina, 
      fechaReporte, 
      observaciones, 
      nivelRiesgo, 
      etiqueta,
      escenario,
      tipoAlerta,
      tipoOperacion,
      monto,
      estadoAlerta,
      generaReporte,
      codigoIP		   
      from  @alertas_cli_monto
      
  end--Final del if Mensual
    
   /*
   PAGOS DIARIOS
   */  
 
   /*1.- Moneda Nacional Diaria*/
   insert into @temp_pagos_dia_mnx
   select 
        'monto_dia_mnx' = sum(abd_monto_mn),
        'cliente'       = op_cliente,
        'moneda_mnx'    = @w_moneda_mxn,
        'perido_m'      = @w_periodo_diario,
        'operacion'     = max(op_toperacion),
        'banco'         = max(op_banco),
        'oficina'         = max(op_oficina),
		'fecha_operacion'  = max(ab_fecha_pag),
		'producto'         = 4,
		'dividendo'        = 0,
		'fecha_fin_div'    = max(op_fecha_fin),
		'secuencial'       = max(ab_secuencial_pag)
   from  cob_cartera..ca_abono, 
         cob_cartera..ca_abono_det, 
         cob_cartera..ca_operacion
   where ab_operacion         = abd_operacion
   and   ab_secuencial_ing    = abd_secuencial_ing 
   and   ab_operacion         = op_operacion
   and   op_estado not in (0,99)
   and   ab_estado     = 'A'
   and   ab_fecha_pag  = @w_fecha_proceso --diaria
   and   abd_moneda    = @w_moneda_mxn 
   and   abd_concepto NOT IN ('SOBRANTE')
   GROUP BY op_cliente,op_banco 
     
   --actualiza el dividendo
   update @temp_pagos_dia_mnx set 
   dividendo =case when fecha_fin_div <@w_fecha_proceso
     then  
      (select isnull(max(di_dividendo),0) from
      cob_cartera..ca_operacion,cob_cartera..ca_dividendo
      where op_operacion=di_operacion
      and op_banco=banco
      )
     else  
     (select isnull(min( di_dividendo),1) from
      cob_cartera..ca_operacion,cob_cartera..ca_dividendo
      where op_operacion=di_operacion
      and op_banco=banco
      and @w_fecha_proceso  >  di_fecha_ini 
      and @w_fecha_proceso   <= di_fecha_ven )    
     end 
     

   insert into @temp_res_pd_mx
   select 
        'Op_monto_dia_mnx' = op_monto_dia_mnx, 
        'Cliente'          = op_cliente ,  
        'Etiqueta'         = etiqueta,   
        'Tipo_alerta'      = tipo_alerta ,
        'Tipo_operacion'   = tipo_operacion,
        'Nivel_riesgo'     = nivel_riesgo ,
        'operacion'        = tproducto,
        'banco'            = banco,
        'oficina'          = oficina,
		'fecha_operacion'  = fecha_operacion,
		  'producto'         = producto_riesgo,
		  'dividendo'        = dividendo,
		  'sec'              = secuencial 
   from @temp_pagos_dia_mnx,@temp_reglas_negocio
   where ( (operador_monto='>=' and op_monto_dia_mnx >=monto_riesgo_hasta) 
          OR ((op_monto_dia_mnx BETWEEN monto_riesgo_ini and monto_riesgo_hasta )and lower(operador_monto)=lower('between' )))
   and op_moneda_pd_mnx = moneda
   and periodo_pd_mnx   = periodo
   and producto           = producto_riesgo
   
   --Se crea tabla temporal para actualizar los montos de la etiqueta 'AML_PETRA'
   insert into @temp_res_pd_mx_9
   select * from @temp_res_pd_mx
   where etiqueta='AML_PETRA'
          
  --Elimino de la tabla temporal @temp_res_pd_mx los que encontro con etiqueta
  --'AML_PETRA'  
  delete from @temp_res_pd_mx
  where etiqueta ='AML_PETRA'

   select * from @temp_res_pd_mx_9
   
  --Resto el valor de su ultima counta pagada Cuota al Monto en ese mes 
  update @temp_res_pd_mx_9
  set op_monto_pd_mx_9=op_monto_pd_mx_9
    -(select isnull(sum(am_cuota),0)--Encuentro la couta del dividendo 
                           from cob_cartera..ca_amortizacion, 
                           cob_cartera..ca_dividendo,
                           cob_cartera..ca_operacion
                           where am_operacion = di_operacion
                           and am_dividendo   = di_dividendo
                           and am_operacion   = op_operacion
                           and op_banco=banco_9
                      and di_dividendo=dividendo_9                
       )
       where tproducto_9 not in ('REVOLVENTE' )
       
   --Resto el valor de su ultima counta pagada Cuota al Monto en ese mes para los Revolventes
  update @temp_res_pd_mx_9
  set op_monto_pd_mx_9=(op_monto_pd_mx_9-(select isnull(sum( dtr_monto),0)
                        from cob_cartera..ca_transaccion,cob_cartera..ca_det_trn,
                            cob_cartera..ca_operacion
                        where tr_secuencial = dtr_secuencial
                        and tr_operacion =dtr_operacion
                            and op_operacion=tr_operacion
                        and tr_secuencial>0
                        and tr_estado<>'RV'
                        and dtr_concepto='CAP'      
                        --AND tr_fecha_ref between '08/01/2019' and '08/30/2019'
                            and op_banco=banco_9
                        and tr_toperacion='REVOLVENTE'
                        and tr_secuencial= (select isnull(max( tr_secuencial),0)
                                            from cob_cartera..ca_transaccion,cob_cartera..ca_det_trn,
                                            cob_cartera..ca_operacion
                                            where tr_secuencial = dtr_secuencial
                                            and tr_operacion =dtr_operacion
                                            and op_operacion=tr_operacion
                                            and tr_secuencial>0
                                            and tr_estado<>'RV'
                                            and dtr_concepto='CAP'      
                                            --AND tr_fecha_ref between '08/01/2019' and '08/30/2019'
                                            
                                            and tr_toperacion='REVOLVENTE'
                                            and tr_secuencial <sec_9
                                            and op_banco=banco_9
                                            and tr_tran='DES')
                                           ))
       where tproducto_9 ='REVOLVENTE'
     
   select * from  @temp_res_pd_mx_9 
   
   --Evaluo nuevamente la regla con los nuevos valores en inserto el tabla original las operaciones definitivos
   insert into @temp_res_pd_mx
   select 
        'Op_monto_dia_mnx' = op_monto_pd_mx_9, 
        'Cliente'          = op_cliente_9 ,  
        'Etiqueta'         = tmp.etiqueta,   
        'Tipo_alerta'      = tmp.tipo_alerta ,
        'Tipo_operacion'   = tmp.tipo_operacion,
        'Nivel_riesgo'     = tmp.nivel_riesgo ,
        'operacion'        = tproducto_9,
        'banco'            = banco_9,
        'oficina'          = oficina_9,
		'fecha_operacion'  = fecha_operacion_9,
		  'producto'         = producto_riesgo_9,
		  'dividendo'        = dividendo_9,
		  'sec'              = sec_9
   from @temp_res_pd_mx_9,@temp_reglas_negocio tmp
   where ( (operador_monto='>=' and op_monto_pd_mx_9 >=monto_riesgo_hasta) 
          OR ((op_monto_pd_mx_9 between monto_riesgo_ini and monto_riesgo_hasta )and lower(operador_monto)=lower('between' )))
   and producto           = producto_riesgo_9 
   and periodo=@w_periodo_diario
   and moneda=@w_moneda_mxn
   
   select * from @temp_res_pd_mx 

    /*2.-Moneda Extranjera Diaria*/
   insert into @temp_pagos_dia_usd
   select 
        'monto_dia_usd' = ((sum(abd_monto_mn))/@w_cotizacion),
        'monto_dia_mnx' = (sum(abd_monto_mn)),
        'cliente'       = op_cliente,
        'moneda_usd'    = @w_moneda_usd,
        'perido_d'      = @w_periodo_diario,
        'operacion'     = max(op_toperacion),
        'banco'         = max(op_banco),
        'oficina'         = max(op_oficina),
		'fecha_operacion' = max(ab_fecha_pag),
		'producto'        = 4
   from  cob_cartera..ca_abono, 
         cob_cartera..ca_abono_det, 
         cob_cartera..ca_operacion
   where ab_operacion         = abd_operacion
   and   ab_secuencial_ing    = abd_secuencial_ing 
   and   ab_operacion         = op_operacion
   and   op_estado not in (0,99)
   and   ab_estado     = 'A'
   and   ab_fecha_pag  = @w_fecha_proceso --fecha diaria
   and   abd_moneda    = @w_moneda_mxn
   and   abd_concepto NOT IN ('SOBRANTE')
   GROUP BY op_cliente,op_banco
       

   insert into @temp_res_pd_usd
   select 
   'Op_monto_dia_do' = op_monto_dia_do,
   'Op_monto_dia_mnx' = op_monto_dia_mnx, 
   'Cliente'          = op_cliente ,  
   'Etiqueta'         = etiqueta,   
   'Tipo_alerta'      = tipo_alerta ,
   'Tipo_operacion'   = tipo_operacion,
   'Nivel_riesgo'     = nivel_riesgo ,
   'operacion'        = tproducto,
   'banco'            = banco,
   'oficina'          = oficina,
   'fecha_operacion'  = fecha_operacion,
   'producto'         = producto_riesgo
   from @temp_pagos_dia_usd,@temp_reglas_negocio
   where ( (operador_monto='>=' and op_monto_dia_do >=monto_riesgo_hasta) 
          OR ( (op_monto_dia_do BETWEEN monto_riesgo_ini and monto_riesgo_hasta )and lower(operador_monto)=lower('between' )))
   and op_moneda_pd_usd = moneda
   and periodo_pd_usd   = periodo
   and producto         = producto_riesgo

   
    --1 Insercion en la tabla @alertas_cli_monto diario moneda nacional 
   insert into @alertas_cli_monto_diario
   select
   'sucursal'          = oficina,
   'grupo'             = (select cg_grupo from cobis..cl_cliente_grupo where cg_ente = en.en_ente 
                          and cg_estado='V' and cg_fecha_desasociacion IS NULL ),
   'codigoCliente'     = op_cliente,
   'nombreGrupo'       = (select gr_nombre from cobis..cl_grupo where gr_grupo = (select top 1 cg_grupo from cobis..cl_cliente_grupo 
                          where cg_ente = en.en_ente and cg_estado = 'V' and cg_fecha_desasociacion IS NULL )),
   'nombreCliente'     = isnull(en.en_nombre,'')+ ' ' +isnull(en.p_s_nombre,'')+ ' ' +isnull(en.p_p_apellido,'') +' ' +isnull(en.p_s_apellido,''),
   'rfc'               = isnull(en.en_nit,en.en_rfc),
   'contrato'          = banco,
   'tipoProducto'      = tproducto,
   'tipoLista'         = (select  clc.codigo from cobis..cl_tabla clt, cobis..cl_catalogo  clc 
                            where clt.codigo = clc.tabla and  clt. tabla = 'cl_alertas_tlista' 
                            and   clc.valor  = pdmx.tipo_operacion),
   'fechaConsulta'     = @w_fecha_proceso,						 
   'fechaAlerta'       = @w_fecha_proceso,
   'fechaOperacion'    = fecha_operacion,
   'fechaDictamina'    = null,
   'fechaReporte'      = null,
   'observaciones'     = null,
   'nivelRiesgo'       = pdmx.nivel_riesgo,
   'etiqueta'          = pdmx.etiqueta,
   'escenario'         = (select TOP 1 reg_neg_descripcion from cl_cat_reg_negocio where reg_neg_etiqueta = pdmx.etiqueta),
   'tipoAlerta'        = pdmx.tipo_alerta, 
   'tipoOperacion'     = pdmx.tipo_operacion,
   'monto'             = pdmx.op_monto_pd_mx,
   'estado'            = @w_estatus_ei,
   'generaReporte'     = null,
   'codigoIP'          = null
   from @temp_res_pd_mx pdmx,cobis..cl_ente en
   where pdmx.op_cliente = en.en_ente 
        
    --2 Insercion en la tabla @alertas_cli_monto diario dolares
    
   insert into @alertas_cli_monto_diario
   select  
   'sucursal'          = oficina,
   'grupo'             = (select cg_grupo from cobis..cl_cliente_grupo where cg_ente = en.en_ente 
                          and cg_estado='V' and cg_fecha_desasociacion IS NULL ),
   'codigoCliente'     = op_cliente,
   'nombreGrupo'       = (select gr_nombre from cobis..cl_grupo where gr_grupo = (select top 1 cg_grupo from cobis..cl_cliente_grupo 
                             where cg_ente = en.en_ente and cg_estado = 'V' and cg_fecha_desasociacion IS NULL )),
   'nombreCliente'     = isnull(en.en_nombre,'')+ ' ' +isnull(en.p_s_nombre,'')+ ' ' +isnull(en.p_p_apellido,'') +' ' +isnull(en.p_s_apellido,''),
   'rfc'               = isnull(en.en_nit,en.en_rfc),
   'contrato'          = banco,
   'tipoProducto'      = tproducto,
   'tipoLista'         = (select  clc.codigo from cobis..cl_tabla clt, cobis..cl_catalogo  clc 
                            where clt.codigo = clc.tabla and  clt. tabla = 'cl_alertas_tlista' 
                            and   clc.valor  = pdusd.tipo_operacion),
   'fechaConsulta'     = @w_fecha_proceso,						 
   'fechaAlerta'       = @w_fecha_proceso,
   'fechaOperacion'    = fecha_operacion,
   'fechaDictamina'    = null,
   'fechaReporte'      = null,
   'observaciones'     = null,
   'nivelRiesgo'       = pdusd.nivel_riesgo,
   'etiqueta'          = pdusd.etiqueta,
   'escenario'         = (select TOP 1 reg_neg_descripcion from cl_cat_reg_negocio where reg_neg_etiqueta = pdusd.etiqueta),
   'tipoAlerta'        = pdusd.tipo_alerta, 
   'tipoOperacion'     = pdusd.tipo_operacion,
   'monto'             = pdusd.op_monto_pd_mnx,
   'estado'            = @w_estatus_ei,
   'generaReporte'     = null,
   'codigoIP'          = null
   from @temp_res_pd_usd pdusd,cobis..cl_ente en
   where pdusd.op_cliente = en.en_ente 

   update cobis..cl_alertas_riesgo SET
   --ar_fecha_consulta=fechaConsulta,
   ar_monto = monto
   from  @alertas_cli_monto_diario 
   where ar_ente     = codigoCliente
   and ar_tipo_lista = tipoLista
   and ar_etiqueta   = etiqueta
   and ar_fecha_alerta = @w_fecha_proceso --cuando la regla este entre el primer dia del mes de la fecha de proceso	
   
   
   delete @alertas_cli_monto_diario 
   from cobis..cl_alertas_riesgo 
   where ar_ente     = codigoCliente
   and ar_tipo_lista = tipoLista
   and ar_etiqueta   = etiqueta
   and ar_fecha_alerta = @w_fecha_proceso           
        
   select etiqueta,* from @alertas_cli_monto_diario

   --inserto en la cl_alertas riegos cuando es diaria
   insert into cobis..cl_alertas_riesgo
   select 
   sucursal,
   grupo,
   codigoCliente, 
   nombreGrupo,
   nombreCliente, 
   rfc,
   contrato, 
   tipoProducto,
   tipoLista, 
   fechaConsulta,	   
   fechaAlerta, 
   fechaOperacion, 
   fechaDictamina, 
   fechaReporte, 
   observaciones, 
   nivelRiesgo, 
   etiqueta,
   escenario,
   tipoAlerta,
   tipoOperacion,
   monto,
   estadoAlerta,
   generaReporte,
   codigoIP		   
   from  @alertas_cli_monto_diario
   

end

return 0

ERROR:
   begin --Devolver mensaje de Error 
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_error
   return @w_error
  end
--go

go
