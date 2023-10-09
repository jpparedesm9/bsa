/*****************************************************************************/
/* Archivo           :  regrepr0451.sp                                       */
/* Stored procedure  :  sp_reporte_r0451                                     */
/* Base de datos     :  cob_conta_super                                      */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                            PROPOSITO                                      */
/* Programa que genera el reporte regulatorio C- 0451                        */
/*****************************************************************************/
/*                           MODIFICACIONES                                  */
/* FECHA           AUTOR               RAZON                                 */
/* 08/11/2016      Nolberto Vite       Emision Inicial                       */
/* 15/12/2016      Juan Tagle          Refactor 451                          */
/*****************************************************************************/
use cob_conta_super
go
if exists (select 1 from sysobjects where name = 'sp_reporte_r0451')
   drop proc sp_reporte_r0451
go

create proc sp_reporte_r0451
(  
   @t_show_version   bit = 0,
   @i_param1         datetime,  -- inicio semana
   @i_param2         tinyint    -- Periodicidad
)

as 
declare
   @i_fecha          datetime,
   @i_periodicidad   tinyint,

   @w_return         int,     /* valor que retorna */
   @w_sp_name        varchar(32),
   @w_bancamia       varchar(24),
   @w_clave          varchar(30),
   @w_clave_sic      varchar(30),
   @w_subreporte     varchar(30),
   @w_fecha_ini      datetime,
   @w_fecha_sic      datetime,
   @w_prod_pcame     varchar(10),
   @w_prod_pcaaso    varchar(10),
   @w_prod_pcaasa    varchar(10),
   @w_mayor_edad     tinyint,
   @w_cod_rel        int,
   @w_mes_fecha      tinyint,
   @w_moneda_local   tinyint,
   @w_s_app          varchar(50),
   @w_path           varchar(50),
   @w_destino        varchar(2500),
   @w_msg            varchar(200),
   @w_error          int,
   @w_errores        varchar(1500),
   @w_comando        varchar(2500),
   @w_destino1       varchar(2500)

select
   @w_sp_name        = 'sp_reporte_r0451',
   @i_fecha          = @i_param1,
   @i_periodicidad   = @i_param2

--Versionamiento del Programa --
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
  return 0
end

delete sb_errorlog
 where er_fuente = @w_sp_name

--Valida periodicidad trimestral
select @w_mes_fecha = datepart(mm, @i_fecha)
if @w_mes_fecha % @i_periodicidad <> 0 goto FIN

--Clave de Entidad
select @w_clave = pa_char
from cobis..cl_parametro
where pa_nemonico = 'CLAVEN'
and   pa_producto = 'REC'
   
if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO CLAVEN'
   goto ERRORFIN
end

--Subreporte
select @w_subreporte = pa_char
from cobis..cl_parametro
where pa_nemonico = 'SUBREP'
and   pa_producto = 'REC'
   
if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO SUBREP'
   goto ERRORFIN
end


--Fecha Consulta SIC
select @w_fecha_sic = pa_datetime
from cobis..cl_parametro
where pa_nemonico = 'FECSIC'
and   pa_producto = 'REC'
   
if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO FECSIC'
   goto ERRORFIN
end


--Clave SIC
select @w_clave_sic = pa_char
from cobis..cl_parametro
where pa_nemonico = 'CLASIC'
and   pa_producto = 'REC'
   
if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO CLASIC'
   goto ERRORFIN
end


select @w_s_app = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO S_APP'
   goto ERRORFIN
end

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = 36001

if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE RUTA PATH DESTINO'
   goto ERRORFIN
end

--Fecha inicio mes segun periodicidad
select @w_fecha_ini = dateadd(mm,-(@i_periodicidad - 1),@i_fecha)
select @w_fecha_ini = dateadd(dd,-(datepart(day,@w_fecha_ini)) + 1, @w_fecha_ini)

select  r0451_fecha                 = do_fecha,
        r0451_periodo               = convert(varchar, datepart(yy, do_fecha)) + right('0'+ convert(varchar,datepart(mm,do_fecha)),2),   -- 1
        r0451_clave_entidad         = convert(numeric(6),@w_clave),                                                                    
        r0451_subreporte            = convert(numeric(4),@w_subreporte),                                                               
        r0451_municipio             = (select convert(varchar(6),eq_valor_cat)                                                         
                                         from cob_conta_super..sb_equivalencias
                                        where eq_catalogo   = 'CODPROV'
                                          and eq_valor_arch = dd_provincia),                                                            
        r0451_estado                = (select convert(varchar(3),eq_valor_cat)                                                       
                                         from cob_conta_super..sb_equivalencias
                                        where eq_catalogo   = 'CODCIU'
                                          and eq_valor_arch = dd_ciudad),                                                               
        r0451_identificador_acred   = convert(varchar(12),dc_cliente),                                                                 
        r0451_persona_jurid         = (select convert(numeric(3),eq_valor_cat)
                                         from cob_conta_super..sb_equivalencias
                                        where eq_catalogo  = 'TIPO_ENTE'
                                          and eq_valor_arch = dc_subtipo),                                             
        r0451_nom_raz_social        = upper(ltrim(rtrim(isnull(dc_nombre,'0')))),                                                      
        r0451_p_apellido            = case dc_subtipo
                                           when 'P' then upper(ltrim(rtrim(isnull(dc_p_apellido,'0'))))
                                           else '0'
                                      end,                                                                                             
        r0451_s_apellido            = case dc_subtipo                                                      -- 10
                                           when 'P' then upper(ltrim(rtrim(isnull(dc_s_apellido,'0'))))
                                           else '0'
                                      end,                                                                                              
        r0451_rfc_socio             = upper(ltrim(rtrim(isnull(dc_nit,'0')))),                                              
        r0451_curp_socio            = case dc_subtipo
                                           when 'P' then (select case dc_tipo_ced
                                                                      when 'CC' then isnull(dc_ced_ruc,'0')
                                                                      else '0'
                                                                 end)
                                           else '0'
                                      end,                                                                                   
        r0451_genero                = case when dc_sexo in('F','M')
                                           then (select convert(numeric(3),eq_valor_cat)
                                                   from cob_conta_super..sb_equivalencias
                                                  where eq_catalogo  = 'CL_SEXO'
                                                    and eq_valor_arch = dc_sexo)
                                           else 3
                                      end,                                                                                  
        r0451_ope_banco             = do_banco,                                                                             
        r0451_oficina               = convert(varchar(6),do_oficina),                                       -- 15                
        r0451_clasif_cred           = case do_clase_cartera
                                           when '1' then (select isnull(convert(varchar(6),eq_valor_cat),'130105060000')                                                         
                                                            from cob_conta_super..sb_equivalencias
                                                           where eq_catalogo   = 'CA_SUBTLIN'
                                                             and eq_valor_arch = do_subtipo_cartera)
                                           when '2' then '131190000000' --Otros creditos al consumo
                                           when '3' then '131601000000' --Vivienda Media y Residencial
										   else '130105070000'          --Microcreditos
                                      end,
        r0451_product_credit        = convert(varchar(200),do_tipo_operacion) + '',                                         
        r0451_fecha_conse           = isnull(convert(varchar,do_fecha_concesion,112),'19000101'),                           
        r0451_fecha_vencimiento     = isnull(convert(varchar,do_fecha_vencimiento,112),'19000101'),                         
        r0451_tipo_modalidad        = do_mod_pago,                                                          -- 20                                                             
        r0451_monto                 = convert(numeric(16),do_monto),
        r0451_frec_pagos_capital    = convert(numeric(4),do_frec_pagos_capital),                                            
        r0451_frec_pagos_int        = convert(numeric(4),do_frec_pagos_int),                                                
        r0451_tasa                  = ROUND(do_tasa,4),                                                                     
        r0451_fecha_ult_pago_cap    = isnull(convert(varchar,do_fecha_ult_pago_cap,112),'19000101'),            -- 25                           
        r0451_valor_ult_pago_cap    = convert(varchar(20),do_valor_ult_pago_cap),                                               
        r0451_fecha_ult_pago_int    = isnull(convert(varchar,do_fecha_ult_pago_int,112),'19000101'),                            
        r0451_valor_ult_pago_int    = convert(varchar(20),do_valor_ult_pago_int),                                               
        r0451_fec_pri_amort_cubi    = isnull(convert(varchar,do_fec_pri_amort_cubierta,112),'19000101'),                    
        r0451_monto_condo           = convert(numeric(16),do_monto_condo),                                  -- 30
        r0451_fecha_condo           = isnull(convert(varchar,do_fecha_condo,112),'19000101'),
        r0451_dias_mora             = DATEDIFF(day,do_fec_pri_amort_cubierta,@i_param1),                                    
        r0451_tipo_cred             = case when ((do_reestructuracion = NULL or do_reestructuracion = 'N') and 
                                                 (do_no_renovacion = NULL or do_no_renovacion = 0)) 
                                                then 1
                                           when (do_reestructuracion = 'N') and (do_no_renovacion > 0) 
                                                then 2
                                           when (do_reestructuracion = 'S') and (do_no_renovacion = 0) 
                                                then 3
                                      end,                                                                                   
        r0451_situa_contable        = case when (do_estado_cartera = 1 and do_num_cuotaven <= 0) then 1
                                           when (do_estado_cartera = 1 and do_num_cuotaven  > 0) then 2
                                           when do_estado_cartera in (2) then 3
                                           when do_estado_cartera in (6,9) then 4
                                      else 0 end,
        r0451_saldo_capital         = convert(numeric(16),do_saldo_cap),                                                         -- 35
        r0451_saldo_interes         = convert(numeric(16),do_saldo_int),
        r0451_mora                  = convert(numeric(16),do_valor_mora),  
        r0451_inte_ordin_venc       = convert(numeric(16),do_inte_vencido),
        r0451_inte_mora_fue_balance = convert(numeric(16),do_inte_vencido_fbalance),
		r0451_inte_refinan          = convert(numeric(16),do_inte_refina),                                                       -- 40
        r0451_saldo_insoluto        = convert(numeric(16),do_saldo_cap + do_saldo_int),
        r0451_tipo_acred_rel        = null,           --'consultar, añadir',
        r0451_tipo_cca_califica     = null,           --'sb_dato_operacion.do_clase_cartera y homologar vs los productos',
        r0451_califica_deudor       = '0',
        r0451_califica_cubierta     = '0',                                                                  -- 45
        r0451_califica_expuesta     = '0',
        r0451_monto_cubierta        = null,           --'Pendiente de Consulta',
        r0451_monto_expuesta        = null,           --'Pendiente de Consulta',
        r0451_estima_prevent_int    = null,           --'calcular de acuerdo a Anexo C de estimaciones preventivas',
        r0451_estima_prevent_riesg  = null,           --'calcular de acuerdo a Anexo C de estimaciones preventivas',   -- 50
        r0451_estima_prevent_orde   = null,           --'calcular de acuerdo a Anexo C de estimaciones preventivas',
        r0451_fecha_sic             = isnull(convert(varchar,@w_fecha_sic,112),'19000101'),
        r0451_clave_preven          = isnull(@w_clave_sic,'1234567890'),
        r0451_garantia_liquida      = (select isnull(sum(dc_valor_actual - dc_valor_uti_opera),0)
                                         from cob_conta_super..sb_dato_custodia, cob_conta_super..sb_dato_garantia
                                        where dc_garantia  = dg_garantia
                                          and dc_fecha     = dg_fecha
                                          and dc_categoria = 'L'
                                          and dc_fecha     = do_fecha
                                          and dg_banco     = do_banco
                                        group by dg_banco),
        r0451_garantia_hipotecaria  = (select isnull(sum(dc_valor_actual - dc_valor_uti_opera),0)
                                         from cob_conta_super..sb_dato_custodia, cob_conta_super..sb_dato_garantia
                                        where dc_garantia  = dg_garantia
                                          and dc_fecha     = dg_fecha
                                          and dc_categoria = 'H'
                                          and dc_fecha     = do_fecha
                                          and dg_banco     = do_banco
                                        group by dg_banco)
            
  into #reporte_r0451

  from cob_conta_super..sb_dato_operacion,
       cob_conta_super..sb_dato_cliente,
       cob_conta_super..sb_dato_direccion
       
 where do_codigo_cliente = dc_cliente
   and dd_cliente        = dc_cliente
   and dc_fecha          = (select max(dc_fecha) from cob_conta_super..sb_dato_cliente where dc_cliente = do_codigo_cliente)
   and dd_fecha          = (select max(dd_fecha) from cob_conta_super..sb_dato_direccion where dd_cliente = do_codigo_cliente)
   and do_fecha between @w_fecha_ini and @i_fecha
   and do_estado_cartera in (1,2)
   and dd_principal      = 'S'
   and do_aplicativo in (select eq_valor_arch
                           from sb_equivalencias
                          where eq_catalogo   = 'TIPRODUCTO'
                            and eq_valor_cat  in ('CARTERA'))


if @@error <> 0 begin
   select @w_msg = 'ERROR INSERTANDO DATOS DE AHORROS EN #reporte_r0451'
   goto ERRORFIN
end

truncate table cob_conta_super..sb_reporte_r0451

insert into cob_conta_super..sb_reporte_r0451
(
    PERIODO,                    CLAVE_ENTIDAD,              SUBREPORTE,                 MUNICIPIO,                     ESTADO,
    IDENTIFICADOR_ACRED,        PERSONA_JURID,              NOM_RAZ_SOCIAL,             APELLIDO_PATERNO,              APELLIDO_MATERNO,
    RFC_SOCIO,                  CURP_SOCIO,                 GENERO,                     OPE_BANCO,                     OFICINA,
    CLASIF_CRED,                PRODUCT_CREDIT,             FECHA_CONSE,                FECHA_VENCIMIENTO,             TIPO_MODALIDAD,
    MONTO,                      FREC_PAGOS_CAPITAL,         FREC_PAGOS_INT,             TASA,                          FECHA_ULT_PAGO_CAP,
    VALOR_ULT_PAGO_CAP,         FECHA_ULT_PAGO_INT,         VALOR_ULT_PAGO_INT,         FEC_PRI_AMORT_NO_CUBI,         MONTO_CONDO,
    FECHA_CONDO,                DIAS_MORA,                  TIPO_CRED,                  SITUA_CONTABLE,                SALDO_CAPITAL,
    SALDO_INTERES,              INTERES_MORA,               INTE_ORDIN_VENC,            INTE_MORA_FUE_BALANCE,		   INTE_REFINAN,               
	SALDO_INSOLUTO,             TIPO_ACRED_REL,             TIPO_CCA_CALIFICA,          CALIFICA_DEUDOR,               CALIFICA_CUBIERTA,          
	CALIFICA_EXPUESTA,			MONTO_CUBIERTA,             MONTO_EXPUESTA,             ESTIMA_PREVENT_INT,            ESTIMA_PREVENT_RIESG,       
	ESTIMA_PREVENT_ORDE,        FECHA_SIC,                  CLAVE_PREVEN,               GARANTIA_LIQUIDA,              GARANTIA_HIPOTECARIA
)
select
    r0451_periodo,              r0451_clave_entidad,        r0451_subreporte,           r0451_municipio,               r0451_estado,
    r0451_identificador_acred,  r0451_persona_jurid,        r0451_nom_raz_social,       r0451_p_apellido,              r0451_s_apellido,
    r0451_rfc_socio,            r0451_curp_socio,           r0451_genero,               r0451_ope_banco,               r0451_oficina,
    r0451_clasif_cred,          r0451_product_credit,       r0451_fecha_conse,          r0451_fecha_vencimiento,       r0451_tipo_modalidad,
    r0451_monto,                r0451_frec_pagos_capital,   r0451_frec_pagos_int,       r0451_tasa,                    r0451_fecha_ult_pago_cap,
    r0451_valor_ult_pago_cap,   r0451_fecha_ult_pago_int,   r0451_valor_ult_pago_int,   r0451_fec_pri_amort_cubi,      r0451_monto_condo,
    r0451_fecha_condo,          r0451_dias_mora,            r0451_tipo_cred,            r0451_situa_contable,          r0451_saldo_capital,
    r0451_saldo_interes,        r0451_mora,                 r0451_inte_ordin_venc,      r0451_inte_mora_fue_balance,   r0451_inte_refinan,         
	r0451_saldo_insoluto,		r0451_tipo_acred_rel,       r0451_tipo_cca_califica,    r0451_califica_deudor,         r0451_califica_cubierta,    
	r0451_califica_expuesta,	r0451_monto_cubierta,       r0451_monto_expuesta,       r0451_estima_prevent_int,      r0451_estima_prevent_riesg, 
	r0451_estima_prevent_orde,  r0451_fecha_sic,            r0451_clave_preven,         r0451_garantia_liquida,        r0451_garantia_hipotecaria
from #reporte_r0451
where r0451_fecha = (select max(r0451_fecha) from #reporte_r0451 b where b.r0451_ope_banco = a.r0451_ope_banco)

if @@error <> 0 begin
   select @w_msg = 'ERROR INSERTANDO DATOS DE AHORROS EN SB_reporte_r0451'
   goto ERRORFIN
end

--Ejecucion para Generar Archivo Datos
select @w_comando = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_reporte_r0451 out '

select @w_destino  = @w_path + 'reporte_r0451_' + convert(varchar, datepart(yy, @i_fecha)) + right('0'+ convert(varchar,datepart(mm,@i_fecha)),2) + '.txt',
       @w_errores  = @w_path + 'reporte_r0451_' + convert(varchar, datepart(yy, @i_fecha)) + right('0'+ convert(varchar,datepart(mm,@i_fecha)),2) + '.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e -T -C' + @w_errores + ' -t";" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

select @w_comando
    exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_msg = 'ERROR EN EJECUCION ' + @w_comando
   goto ERRORFIN
end

FIN:
return 0

ERRORFIN: 

exec cob_conta_super..sp_errorlog
@i_operacion     = 'I',
@i_fecha_fin     = @i_fecha,
@i_fuente        = @w_sp_name,
@i_origen_error  = '28016',
@i_descrp_error  = @w_msg
   
return 1
go

