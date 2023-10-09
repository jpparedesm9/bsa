/************************************************************************/
/*   Archivo:              riesgo_hrc_glb.sp                            */
/*   Stored procedure:     sp_riesgo_hrc_glb                            */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Regulatorios                                 */
/*   Disenado por:         Raúl Altamirano Mendez                       */
/*   Fecha de escritura:   Enero 2018                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Genera archivo de interface de Riesgo para reportar operaciones    */
/*   vigentes y vencidas del banco SANTANDER MX (Archivo 7 - HRC).      */
/*                              CAMBIOS                                 */
/************************************************************************/
/*                          MODIFICACIONES                              */
/* FECHA           AUTOR       DESCRICIPCION                            */
/* 26/03/2018      MTA         Validacion de fecha de venc.             */
/*                             de la cuota y quitar estados             */
/* 15/01/2019      MTA         Agregar campos con inf de grupos         */
/* 19/07/2019      POV         Agregar ejecucion de LCR                 */
/* 31/07/2019      POV         Agregar parametro de entrada             */
/* 04/10/2019      D. Cumbal   #126877                                  */
/* 28/10/2019      ACHP        Caso #Soporte #128989                    */
/* 23/01/2020      DCU         Caso #133108                             */
/* 15/04/2020      SRO         Caso #138102                             */
/* 28/07/2020      DCU         Caso #143417                             */
/* 16/10/2020      DCU         Caso #147859                             */
/* 29/11/2021      ACH         Caso #173628 Catalogos HRC simple reportes*/
/* 13/12/2021      JEOM        Caso #172727                             */
/* 28/02/2022      DCU         Caso #177295                             */
/* 04/03/2022      DCU         Caso: 179643                             */
/* 04/03/2022      DCU         Caso: 179296                             */
/* 04/03/2022      DCU         Caso: 183102                             */
/* 25/08/2022      KVI         Sop.189747                               */
/************************************************************************/

use cob_conta_super
go

if exists (select 1 from sysobjects where name = 'sp_riesgo_hrc_glb')
   drop proc sp_riesgo_hrc_glb
go
create proc sp_riesgo_hrc_glb
   @i_param1   datetime    = null   --FECHA
as
declare 
        @w_error                int,
        @w_return               int,
        @w_mensaje              varchar(255),
        @w_sql                  varchar(5000),
        @w_fecha_proceso        datetime,
        @w_fecha_corte          datetime,
        @w_ffecha_data          int,
        @w_ffecha_reporte       int,
        @w_ruta_arch            varchar(255),
        @w_nombre_arch          varchar(255),
        @w_sp_name              varchar(30),
        @w_msg                  varchar(255),
        @w_batch                int,
        @w_empresa              int,
        @w_ciudad_nacional      int,
        @w_dmora_pven_cuota     tinyint,
        @w_s_app                varchar(40),
        @w_est_vencido          int,
        @w_est_vigente          int,
        @w_est_no_vigente       int,
        @w_est_cancelado        int,
        @w_destino              varchar(255),
        @w_errores              varchar(255),
        @w_archivo_cab          varchar(255),
        @w_archivo_det          varchar(255),
        @w_comando              varchar(8000),
        @w_columna              varchar(50),
        @w_col_id               int,
        @w_cabecera             varchar(8000),
        @w_nom_cabecera         varchar(8000), 
        @w_nom_columnas         varchar(8000),
        @w_cont_columnas        int,
		@w_est_suspenso         int,
		@w_est_etapa2           int,
		@w_fecha_consolidador   datetime,
		@w_sub_prod_rep         int,
		@w_cod_subproducto_ind  varchar(4), -- Sop.189747
		@w_est_anulado          int,        -- Sop.189747
		@w_est_credito          int         -- Sop.189747 


select @w_sp_name = 'sp_riesgo_hrc_glb'
declare @resultadobcp table (linea varchar(max))

if @i_param1 is null
   select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
else
   select @w_fecha_proceso = @i_param1

select @w_ffecha_data = 120, @w_ffecha_reporte = 111, @w_batch = 36431
select @w_sub_prod_rep = codigo from cobis..cl_tabla where tabla = 'ca_sub_producto_rep'

if exists(select 1 from sysobjects where name = 'sb_tmp_cabecera_hrc' and type = 'U')
   drop table sb_tmp_cabecera_hrc
   
create table sb_tmp_cabecera_hrc
(
    cabecera01    varchar(50), 
    cabecera02    varchar(50),
    cabecera03    varchar(50),
    cabecera04    varchar(50),
    cabecera05    varchar(50),
    cabecera06    varchar(50),
    cabecera07    varchar(50),
    cabecera08    varchar(50),
    cabecera09    varchar(50),
    cabecera10    varchar(50),
    cabecera11    varchar(50),
    cabecera12    varchar(50),
    cabecera13    varchar(50),
    cabecera14    varchar(50),
    cabecera15    varchar(50),
    cabecera16    varchar(50),
    cabecera17    varchar(50),
    cabecera18    varchar(50),
    cabecera19    varchar(50),
    cabecera20    varchar(50),
    cabecera21    varchar(50),
    cabecera22    varchar(50),
    cabecera23    varchar(50),
    cabecera24    varchar(50),
    cabecera25    varchar(50),
    cabecera26    varchar(50),
    cabecera27    varchar(50),
    cabecera28    varchar(50),
    cabecera29    varchar(50),
    cabecera30    varchar(50),
    cabecera31    varchar(50),
    cabecera32    varchar(50),
    cabecera33    varchar(50),
    cabecera34    varchar(50),
    cabecera35    varchar(50),
    cabecera36    varchar(50),
    cabecera37    varchar(50),
    cabecera38    varchar(50),
    cabecera39    varchar(50),
    cabecera40    varchar(50),
    cabecera41    varchar(50),
    cabecera42    varchar(50),
    cabecera43    varchar(50),
    cabecera44    varchar(50),
    cabecera45    varchar(50),
    cabecera46    varchar(50),
    cabecera47    varchar(50),
    cabecera48    varchar(50),
    cabecera49    varchar(50),
    cabecera50    varchar(50),
    cabecera51    varchar(50),
    cabecera52    varchar(50),
    cabecera53    varchar(50),
    cabecera54    varchar(50),
    cabecera55    varchar(50),
    cabecera56    varchar(50),
    cabecera57    varchar(50),
    cabecera58    varchar(50),
    cabecera59    varchar(50),
    cabecera60    varchar(50),
    cabecera61    varchar(50),
    cabecera62    varchar(50),
    cabecera63    varchar(50),
    cabecera64    varchar(50),
    cabecera65    varchar(50),
    cabecera66    varchar(50),
    cabecera67    varchar(50),
    cabecera68    varchar(50),
    cabecera69    varchar(50),
    cabecera70    varchar(50),
    cabecera71    varchar(50),
    cabecera72    varchar(50),
    cabecera73    varchar(50),
    cabecera74    varchar(50),
    cabecera75    varchar(50),
    cabecera76    varchar(50),
    cabecera77    varchar(50),
    cabecera78    varchar(50),
    cabecera79    varchar(50),
    cabecera80    varchar(50),
    cabecera81    varchar(50),
    cabecera82    varchar(50),
    cabecera83    varchar(50),
    cabecera84    varchar(50),
    cabecera85    varchar(50),
    cabecera86    varchar(50),
    cabecera87    varchar(50),
    cabecera88    varchar(50),
    cabecera89    varchar(50),
    cabecera90    varchar(50),
    cabecera91    varchar(50),
    cabecera92    varchar(50),
    cabecera93    varchar(50),
    cabecera94    varchar(50),
    cabecera95    varchar(50),
    cabecera96    varchar(50),
    cabecera97    varchar(50),
    cabecera98    varchar(50),
    cabecera99    varchar(50),
	cabecera100    varchar(50), --MTA nuevos campos
	cabecera101    varchar(50),
	cabecera102    varchar(50)
)   

select @w_empresa = pa_tinyint from cobis..cl_parametro 
where pa_nemonico = 'EMP' and pa_producto = 'ADM'

if @@error != 0 or @@rowcount != 1 
begin
   select 
   @w_error = 70135,
   @w_mensaje = 'Error Al consultar informacion de parametro EMP'
   goto ERROR_PROCESO
end

select @w_s_app = pa_char from cobis..cl_parametro
where  pa_producto = 'ADM' and pa_nemonico = 'S_APP'

if @@error != 0 or @@rowcount != 1 
begin
   select 
   @w_error = 70135,
   @w_mensaje = 'Error Al consultar informacion de parametro S_APP'
   goto ERROR_PROCESO
end

---NUMERO DE DIAS DE MORA PARA REALIZAR EL PASO AUTOMATICO A VENCIDO - OPER. NORMALES
select @w_dmora_pven_cuota = pa_tinyint
from  cobis..cl_parametro with (nolock)
where pa_producto = 'CCA'
and   pa_nemonico = 'DMOVCN'

if @@error != 0 or @@rowcount != 1
begin
   select 
   @w_error = 70135,
   @w_mensaje = 'Error Al consultar informacion de parametro DMOVCN'
   goto ERROR_PROCESO
end

select @w_dmora_pven_cuota = isnull(@w_dmora_pven_cuota, 90)

select
@w_ruta_arch    = ba_path_destino,
@w_nombre_arch  = lower(isnull(ba_arch_resultado, 'cobis_hrc_glb'))
from  cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select 
   @w_error = 70134,
   @w_mensaje = 'NO Existe parametria del Batch ' + convert(varchar, @w_batch)
   goto ERROR_PROCESO
end

--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec @w_error     = cob_cartera..sp_estados_cca
@o_est_vigente    = @w_est_vigente    out,
@o_est_vencido    = @w_est_vencido    out,
@o_est_novigente  = @w_est_no_vigente out,
@o_est_cancelado  = @w_est_cancelado  out,
@o_est_suspenso   = @w_est_suspenso   out,
@o_est_etapa2     = @w_est_etapa2     out,
@o_est_anulado    = @w_est_anulado    out, -- Sop.189747
@o_est_credito    = @w_est_credito    out  -- Sop.189747

if @w_error > 0 or @w_est_vencido is null or @w_est_vigente is null or @w_est_no_vigente is null
begin
   select
   @w_error   = 2108029,
   @w_mensaje = 'No Encontro Estado Vencido/Vigente/No Vigente para Cartera'
   goto ERROR_PROCESO
end


select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'


--HASTA ENCONTRAR EL HABIL ANTERIOR
select @w_fecha_corte  = dateadd(dd,-1,@w_fecha_proceso)

while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_corte)
begin
   if datepart(dd, @w_fecha_corte) != 1 select @w_fecha_corte = dateadd(dd, -1, @w_fecha_corte) else break
end
   
select @w_nombre_arch = @w_nombre_arch + '_' + replace(convert(varchar(10), @w_fecha_corte, @w_ffecha_reporte), '/', '')

SELECT 
fec_info    = convert(varchar(10), @w_fecha_corte, @w_ffecha_data),
num_cred    = op_banco,
operacion   = op_operacion, 
cliente     = op_cliente,
periodo_cap = op_periodo_cap,
periodo_int = op_periodo_int,
tdividendo  = op_tdividendo,
destino_cr  = op_destino,
num_cliente_operativo = convert(varchar(20), null),
desc_nombre_cliente   = convert(varchar(255), null),
cod_entidad  = convert(varchar(10),'0078'),
desc_entidad = 'SANTANDER INCLUSION FINANCIERA',
desc_sistema_origen = 'COBIS',
num_suc_titular = convert(varchar(20), op_oficina),
cod_producto    = '96',
cod_subproducto = (select substring(valor, 1 , charindex(';', valor)-1) 
                   from cobis..cl_catalogo where tabla = @w_sub_prod_rep and codigo = op_toperacion), --caso#173628
				   /*case op_toperacion 
                    when 'GRUPAL' then '0001' 
                    when 'INDIVIDUAL' then '0004'--'0002' 
                    when 'INTERCICLO' then '0003'					
                  end,*/
desc_producto  = 'INCLUSION FINANCIERA',
desc_subproducto = (select substring(valor, charindex(';', valor)+1, len(valor)) 
                            from cobis..cl_catalogo where tabla = @w_sub_prod_rep and codigo = op_toperacion), --caso#173628
                   /*case op_toperacion 
                    when 'GRUPAL' then 'Grupal' 
                    when 'INDIVIDUAL' then 'Simple'--'Individual' 
                    when 'INTERCICLO' then 'Interciclo'
                  end,*/
flg_revolvente           = '0',
flg_tratamiento_contable = '0',
cod_tipo_amortiza        = '1',
desc_tipo_amortiza       = 'Capital E Intereses Periodicos',
--desc_tipo_amortiza       = 'CAPITAL E INTERESES PERI'+char(ascii('Ó'))+'DICOS',
num_cta_cheques          = op_cuenta,
fec_formaliza            = convert(varchar(10), op_fecha_ini, @w_ffecha_data),
fec_vencimiento          = convert(varchar(10), op_fecha_fin, @w_ffecha_data),
cod_tasa                 = case op_reajustable 
                            when 'N' then 'FIJA'
                            else 'VAR'
                           end,
desc_tasa               = case op_reajustable 
                            when 'N' then 'TASA FIJA'
                            else 'TASA VARIABLE'
                          end,
flg_tasa_variable       = case op_reajustable 
                            when 'N' then '0'
                            else '1'
                          end,
fec_prox_revisa_tasa    = convert(varchar(10), NULL),
cod_periodo_revisa_tasa = convert(varchar(10), NULL),
pct_tasa_cobr           = convert(varchar(8), null),
num_puntos_spread        = '0',
fec_ult_amort_incump_cap = convert(varchar(10), null),
fec_ult_amort_incump_int = convert(varchar(10), null),
num_doctos_vencidos      = convert(varchar(2),  null),
cod_periodo_capital      = convert(varchar(3),  null),
desc_periodo_capital     = convert(varchar(64), null),
cod_periodo_intereses    = convert(varchar(3),  null),
desc_periodo_intereses   = convert(varchar(64), null),
cod_bloqueo             = convert(varchar(10), NULL),
desc_bloqueo            = convert(varchar(20), NULL),
cod_moneda              = 'MXN',
imp_concedido           = convert(varchar(20), isnull(op_monto,0)),
imp_limite_credito      = '0',
imp_disponible          = '0',
imp_total_riesgo_sistema = convert(varchar(10), null),
imp_cap_noexig           = convert(varchar(10), null),
imp_cap_exig             = convert(varchar(10), null),
imp_int_noexig           = convert(varchar(10), null),
imp_int_exig             = convert(varchar(10), null),
imp_int_suspen           = convert(varchar(10), null),
imp_inversion            = convert(varchar(10), null),
imp_total_riesgo         = convert(varchar(10), null),
fec_traspaso_vencido     = case op_estado WHEN @w_est_vencido then convert(varchar(10),op_fecha_suspenso,@w_ffecha_data) else null end,
num_linea_madre          = convert(varchar(20), ltrim(rtrim(space(1)))),
flg_mora_sistema         = convert(char(1), '0'),
fec_prox_corte           = convert(varchar(10), '0001-01-01'), 
cod_pais_origen          = convert(varchar(10), NULL),
cod_pais_residencia      = convert(varchar(10), NULL),
cod_tipo_persona         = convert(char(1), NULL),
cod_sector_economico     = convert(varchar(10), NULL), 
cod_unidad_negocio       = ltrim(rtrim(space(1))),
cod_unidad_negocio_ope_ori = ltrim(rtrim(space(1))),
cod_sector_contable        = ltrim(rtrim(space(1))),
cod_actividad_economica  = convert(varchar(10), NULL),
desc_rfc                 = convert(varchar(255), null),  
desc_pais_origen         = convert(varchar(64), 'MEXICO'),
desc_pais_residencia     = convert(varchar(64), 'MEXICO'),
desc_sector_economico    = convert(varchar(200), NULL),
desc_tipo_persona        = convert(varchar(64), NULL),
desc_unidad_negocio      = convert(varchar(64), NULL),
cod_localidad_dom_primario   = convert(varchar(64), NULL),
desc_actividad_economica_esp = convert(varchar(200), NULL),
fec_prox_corte_prin      = convert(varchar(10), null),
fec_prox_corte_int       = convert(varchar(10), '0001-01-01'),
fec_formaliza_ult_disp   = convert(varchar(10), NULL),
imp_seguro_desempleo     = '0',
imp_seguro_vida          = '0',
flg_garantia             = convert(char(1), '0'),
pct_tasa_base            = convert(varchar(8), null),
imp_pag_adelantado       = convert(varchar(20), 0),
num_ult_recibo_facturado = convert(varchar(3), null),
cod_bloq_disposicion     = convert(varchar(10), NULL),
imp_pago_domiciliado     = convert(varchar(20), '0.00'),
fec_cobranza             = convert(varchar(10), NULL),
pct_cat                  = convert(varchar(20), op_valor_cat),
desc_tipo_solicitud      = 'MERCADO ABIERTO',  
desc_canal               = 'OFICINAS TUIIO',  
fec_vencimiento_renovacion = convert(varchar(10), NULL),
fec_nacimiento           = convert(varchar(10), null),
cod_estado_civil         = convert(varchar(10), NULL),
cod_genero               = convert(varchar(10), NULL),
imp_ingreso_dispersion   = '0',
flg_dispersion_ult_3m    = '0',
cod_tipo_interviniente   = convert(varchar(10), NULL),
cod_finalidad_credito    = convert(varchar(64), null),
cod_periodo_capital1     = convert(varchar(3),  null),
cod_periodo_capital2     = convert(varchar(3),  null),
num_dias_atraso          = convert(varchar(10), null),
num_plazo_remanente_dias = convert(varchar(10), datediff(dd, op_fecha_ini, op_fecha_fin)),
--MTA Caso 111362 nuevos campos
num_hijas_grupo          = convert(varchar(10), null),  --integrantes_grupo
ciclo_ind                = convert(varchar(10), null), 
ciclo_grupo              = convert(varchar(10), null),
tramite_grp              = convert(varchar(10), null)
into #operaciones_hrc
from  cob_cartera..ca_operacion
where op_estado in (@w_est_vigente, @w_est_etapa2, @w_est_vencido)
and   op_toperacion not in ('REVOLVENTE') 

if @@error != 0
begin
   select
   @w_error   = 724617,
   @w_mensaje = 'Error en la carga incial de Operaciones'
   goto ERROR_PROCESO   
end


select 
oper_periodo = operacion, 
periodo_cap  = (periodo_cap * td_factor), 
tperiodo_cap = convert(char(2), null), -- Err al ejecutar el caso
periodo_int  = (periodo_int * td_factor), 
tperiodo_int = convert(char(2), null), -- Err al ejecutar el caso
tipo_periodo = tdividendo, 
cod_per_cap  = convert(varchar(3), null), 
desc_per_cap = convert(varchar(64), null),
cod_per_int  = convert(varchar(3), null), 
desc_per_int = convert(varchar(64), null)
into #oper_tipo_periodo
from #operaciones_hrc, cob_cartera..ca_tdividendo
where td_tdividendo = tdividendo

if @@error != 0
begin
   select 
   @w_error = 710007,
   @w_mensaje = 'Error en la carga inicial de tipos de periodo'
   goto ERROR_PROCESO
end

update #oper_tipo_periodo set
tperiodo_cap = td_tdividendo
from cob_cartera..ca_tdividendo
where td_factor = periodo_cap

if @@error != 0
begin
   select 
   @w_error = 710007,
   @w_mensaje = 'Error en la actualizacion del tipo de periodo para Capital'
   goto ERROR_PROCESO
end

update #oper_tipo_periodo set
tperiodo_int = td_tdividendo
from cob_cartera..ca_tdividendo
where td_factor = periodo_int

if @@error != 0
begin
   select 
   @w_error = 710007,
   @w_mensaje = 'Error en la actualizacion del tipo de periodo para Interes'
   goto ERROR_PROCESO
end

update #oper_tipo_periodo set 
cod_per_cap = case tperiodo_cap 
              when 'D' then '101'
              when 'W' then '107'
			  when 'BW' then '115'
              when 'Q' then '115'
              when 'M' then '201'
              when 'T' then '203'
              else NULL
              end, 
desc_per_cap = case tperiodo_cap
               when 'D' then 'Diario'
               when 'W' then '7 Dias'
			   when 'BW'then 'Quincenal'
               when 'Q' then 'Quincenal'
               when 'M' then 'Mensual'
               when 'T' then 'Trimestral'
               else NULL
               end,
cod_per_int  = case tperiodo_int
               when 'D' then '101'
               when 'W' then '107'
			   when 'BW' then '115'
               when 'Q' then '115'
               when 'M' then '201'
               when 'T' then '203'
               else NULL
               end, 
desc_per_int = case tperiodo_int
               when 'D' then 'Diario'
               when 'W' then '7 Dias'
			   when 'BW' then 'Quincenal'
               when 'Q' then 'Quincenal'
               when 'M' then 'Mensual'
               when 'T' then 'Trimestral'
               else NULL
               end
               
if @@error != 0
begin
   select 
   @w_error = 710007,
   @w_mensaje = 'Error en la actualizacion del tipo de periodo'
   goto ERROR_PROCESO
end               
               
update #operaciones_hrc set 
cod_periodo_capital = cod_per_cap,
desc_periodo_capital= desc_per_cap,
cod_periodo_intereses = cod_per_int,
desc_periodo_intereses= desc_per_int,
cod_periodo_capital1  = cod_per_cap,
cod_periodo_capital2  = cod_per_cap
from #oper_tipo_periodo 
where oper_periodo = operacion 

if @@error != 0
begin
   select 
   @w_error = 710007,
   @w_mensaje = 'Error en la actualizacion del tipo de periodo'
   goto ERROR_PROCESO
end
               
select 
oper_vigente      = di_operacion, 
div_vigente       = min(di_dividendo), 
fecha_vigente     = convert(varchar(10),min(di_fecha_ven),@w_ffecha_data),
div_cap_vigente   = min(di_dividendo),  
fecha_cap_vigente = convert(varchar(10),min(di_fecha_ven),@w_ffecha_data)
into  #div_vigentes
from  #operaciones_hrc, cob_cartera..ca_dividendo
where di_operacion = operacion 
and di_fecha_ven > @w_fecha_corte
group by di_operacion

if @@error != 0
begin
   select 
   @w_error = 701179,
   @w_mensaje = 'Error al consultar Dividendos Vigentes'
   goto ERROR_PROCESO
end

select 
oper_vencida  = do_operacion, 
div_vencido   = do_venc_dividendo,--isnull(min(di_dividendo),0), 
num_vencido   = do_num_cuotaven, 
fecha_vencido = do_fecha_dividendo_ven,--convert(varchar(10),min(di_fecha_ven),@w_ffecha_data),
dias_vencido  = do_dias_mora_365 --datediff(dd, isnull(min(di_fecha_ven), @w_fecha_corte), @w_fecha_corte)
into  #div_vencidos
from  #operaciones_hrc, cob_conta_super..sb_dato_operacion 
where do_operacion           = operacion 
and   do_estado_cartera      <> @w_est_cancelado 
and   datediff(dd,do_fecha, @w_fecha_corte) = 0


if @@error != 0
begin
   select 
   @w_error = 708163,
   @w_mensaje = 'Error al consultar Dividendos Vencidos'
   goto ERROR_PROCESO
end

select 
oper_saldo = operacion, 
concepto   = am_concepto, 
exigible     = case when di_fecha_ven <= @w_fecha_corte then 1 else 0 end,
estado       = am_estado,
saldo_exi    = isnull(sum(case when di_fecha_ven <= @w_fecha_corte then (isnull(am_acumulado, 0) - isnull(am_pagado, 0)) else 0 end), 0),
saldo_no_exi = isnull(sum(case when di_fecha_ven > @w_fecha_corte then (isnull(am_acumulado, 0) - isnull(am_pagado, 0)) else 0 end),0)
into  #saldos
from  #operaciones_hrc, cob_cartera..ca_dividendo, cob_cartera..ca_amortizacion
where di_operacion = operacion
and   am_operacion = di_operacion
and   am_dividendo = di_dividendo
and   am_concepto in ('CAP', 'INT', 'INT_ESPERA')
group by operacion, am_concepto, case when di_fecha_ven <= @w_fecha_corte then 1 else 0 end, am_estado

if @@error != 0
begin
   select 
   @w_error = 724619,
   @w_mensaje = 'Error al consultar saldos exigibles'
   goto ERROR_PROCESO
end

/*Actualizacion de saldos vencidos no exigibles */

update #saldos set
saldo_exi = isnull(saldo_exi,0) + isnull(saldo_no_exi,0)
where estado   = @w_est_vencido
and   exigible = 0
and   concepto in ('INT', 'INT_ESPERA')

update #saldos set
saldo_no_exi = 0,
exigible = 1
where estado   = @w_est_vencido
and   exigible = 0
and   concepto in ('INT', 'INT_ESPERA')

/************************************************************/


update #operaciones_hrc set 
fec_prox_corte      = convert(varchar(10), fecha_vigente, @w_ffecha_data),
fec_prox_corte_prin = convert(varchar(10), fecha_cap_vigente, @w_ffecha_data),
fec_prox_corte_int  = convert(varchar(10), fecha_vigente, @w_ffecha_data)
from  #div_vigentes
where operacion = oper_vigente

if @@error != 0
begin
   select 
   @w_error = 701179,
   @w_mensaje = 'Error al actualizar Fechas de Corte Principal/Interes'
   goto ERROR_PROCESO
end

update #operaciones_hrc set 
fec_ult_amort_incump_cap = convert(varchar(10), fecha_vencido, @w_ffecha_data),
fec_ult_amort_incump_int = convert(varchar(10), fecha_vencido, @w_ffecha_data),
num_doctos_vencidos      = num_vencido,
num_dias_atraso          = dias_vencido,
--JEOM INI 13/12/2021 INI
--flg_mora_sistema         = case WHEN dias_vencido >= 90 then '1' else '0' end
flg_mora_sistema         = CASE  WHEN dias_vencido <= 30 THEN '0' 
                                 WHEN dias_vencido >= 31 AND dias_vencido <= 89 THEN '1'
                                 WHEN dias_vencido >= 90 THEN '2'
                           END      
--JEOM INI 13/12/2021 FIN
from  #div_vencidos
where operacion = oper_vencida

if @@error != 0
begin
   select 
   @w_error = 708163,
   @w_mensaje = 'Error al actualizar fecha de incumplimiento de Dividendos Vencidos'
   goto ERROR_PROCESO
end

update #operaciones_hrc set
imp_cap_noexig = (select convert(varchar, sum(convert(money, isnull(saldo_no_exi,0))))
                  from  #saldos
                  where oper_saldo = op.operacion
                  and   concepto = 'CAP'
                  group by oper_saldo, concepto),
imp_cap_exig   = (select convert(varchar, sum(convert(money, isnull(saldo_exi,0))))
                  from  #saldos
                  where oper_saldo = op.operacion
                  and   concepto = 'CAP'
                  group by oper_saldo, concepto)
from #operaciones_hrc op

if @@error != 0
begin
   select 
   @w_error = 724619,
   @w_mensaje = 'Error al actualizar saldos exigibles de Capital'
   goto ERROR_PROCESO
end

update #operaciones_hrc set
imp_int_noexig = isnull((select convert(varchar, sum(convert(money, isnull(saldo_no_exi,0))))
                  from  #saldos
                  where oper_saldo = op.operacion
                  and   concepto = 'INT'
                  and   estado <> @w_est_suspenso
                  group by oper_saldo, concepto),'0.00'),
imp_int_exig   = isnull((select convert(varchar, sum(convert(money, isnull(saldo_exi,0))))
                  from  #saldos
                  where oper_saldo = op.operacion
                  and   concepto = 'INT'
                  and   estado <> @w_est_suspenso
                  group by oper_saldo, concepto),'0.00')
from #operaciones_hrc op

if @@error != 0
begin
   select 
   @w_error = 724619,
   @w_mensaje = 'Error al actualizar saldos exigibles de Interes'
   goto ERROR_PROCESO
end

update #operaciones_hrc set
imp_int_noexig =  convert (VARCHAR, convert(MONEY, isnull(imp_int_noexig,'0.00')) + isnull((select sum(convert(money, saldo_no_exi))
                  from  #saldos
                  where oper_saldo = op.operacion
                  and   concepto = 'INT_ESPERA'
                  and   estado <> @w_est_suspenso
                  group by oper_saldo, concepto),'0.00')),
imp_int_exig   =  convert (VARCHAR, convert(MONEY, isnull(imp_int_exig,'0.00')) + isnull((select sum(convert(money, saldo_exi))
                  from  #saldos
                  where oper_saldo = op.operacion
                  and   concepto = 'INT_ESPERA'
                  and   estado <> @w_est_suspenso
                  group by oper_saldo, concepto),'0.00'))
from #operaciones_hrc op

if @@error != 0
begin
   select 
   @w_error = 724619,
   @w_mensaje = 'Error al actualizar saldos exigibles de Interes'
   goto ERROR_PROCESO
end

update #operaciones_hrc set
imp_int_suspen = isnull((select convert(varchar, sum(convert(money, isnull(saldo_exi,0))) + sum(convert(money, isnull(saldo_no_exi,0))))
                  from  #saldos
                  where oper_saldo = op.operacion
                  and   concepto = 'INT'
                  and   estado = @w_est_suspenso
                  group by oper_saldo, concepto, estado),'0.00')
from #operaciones_hrc op  

if @@error != 0
begin
   select 
   @w_error = 724619,
   @w_mensaje = 'Error al actualizar saldos exigibles de Interes en Suspenso'
   goto ERROR_PROCESO
end


update #operaciones_hrc set
imp_int_suspen =  convert( varchar, convert(money,isnull(imp_int_suspen,'0.00')) + isnull((select sum(convert(money, saldo_exi)) + sum(convert(money, saldo_no_exi))
                  from  #saldos
                  where oper_saldo = op.operacion
                  and   concepto = 'INT_ESPERA'
                  and   estado = @w_est_suspenso
                  group by oper_saldo, concepto, estado),'0.00'))
from #operaciones_hrc op  

if @@error != 0
begin
   select 
   @w_error = 724619,
   @w_mensaje = 'Error al actualizar saldos exigibles de Interes en Suspenso'
   goto ERROR_PROCESO
end

/*update #operaciones_hrc set
imp_total_riesgo_sistema = convert(varchar, (convert(money, imp_cap_noexig) + convert(money, imp_cap_exig) + convert(money, imp_int_noexig) + convert(money, imp_int_exig) - convert(money, imp_int_suspen))),
imp_inversion            = convert(varchar, (convert(money, imp_cap_noexig) + convert(money, imp_cap_exig) + convert(money, imp_int_noexig) + convert(money, imp_int_exig) - convert(money, imp_int_suspen))),
imp_total_riesgo         = convert(varchar, (convert(money, imp_cap_noexig) + convert(money, imp_cap_exig) + convert(money, imp_int_noexig) + convert(money, imp_int_exig) - convert(money, imp_int_suspen)))
*/

update #operaciones_hrc set
imp_total_riesgo_sistema = convert(varchar, (convert(money, imp_cap_noexig) + convert(money, imp_cap_exig) + convert(money, imp_int_noexig) + convert(money, imp_int_exig))),
imp_inversion            = convert(varchar, (convert(money, imp_cap_noexig) + convert(money, imp_cap_exig) + convert(money, imp_int_noexig) + convert(money, imp_int_exig))),
imp_total_riesgo         = convert(varchar, (convert(money, imp_cap_noexig) + convert(money, imp_cap_exig) + convert(money, imp_int_noexig) + convert(money, imp_int_exig)))

if @@error != 0
begin
   select 
   @w_error = 724619,
   @w_mensaje = 'Error al actualizar saldos exigibles para riesgo'
   goto ERROR_PROCESO
end

update #operaciones_hrc set 
pct_tasa_cobr = convert(varchar(8), round(ro_porcentaje, 4)), 
pct_tasa_base = convert(varchar(8), round(ro_porcentaje, 4))
from cob_cartera..ca_rubro_op
where ro_operacion = operacion
and   ro_concepto  = 'INT'

if @@error != 0  
begin
   select 
   @w_error = 724669,
   @w_mensaje = 'Error al actualizar TASA de Interes'
   goto ERROR_PROCESO
end


update #operaciones_hrc set
num_ult_recibo_facturado = 
(select isnull(max(di_dividendo), 0)
from  cob_cartera..ca_dividendo, cob_cartera..ca_amortizacion
where di_operacion = op.operacion
and di_fecha_ven < @w_fecha_corte
and am_operacion = di_operacion
and am_dividendo = di_dividendo
group by di_operacion)
from #operaciones_hrc op

if @@error != 0  
begin
   select 
   @w_error = 705043,
   @w_mensaje = 'Error al actualizar ultimo Dividendo'
   goto ERROR_PROCESO
end

update #operaciones_hrc set   
num_cliente_operativo = en_banco,
desc_rfc              = en_rfc,
desc_nombre_cliente   = upper(isnull(ltrim(rtrim(p_p_apellido)), '') + space(1) + isnull(ltrim(rtrim(p_s_apellido)), '') + space(1) + 
                        isnull(ltrim(rtrim(en_nombre)), '') + space(1) + isnull(ltrim(rtrim(p_s_nombre)), '')),
fec_nacimiento        = convert(varchar(10), p_fecha_nac, @w_ffecha_data)
from  cobis..cl_ente 
where en_ente = cliente

if @@error != 0
begin
   select 
   @w_error = 705074,
   @w_mensaje = 'Error al actualizar informacion referencial de Clientes'
   goto ERROR_PROCESO
end

update #operaciones_hrc set   
cod_finalidad_credito  = case destino_cr when '01' then 'Capital de Trabajo' else lower(c.valor) end
from  cobis..cl_tabla t, cobis..cl_catalogo c
where t.tabla = 'cr_destino'
and   c.tabla = t.codigo
and   c.codigo = destino_cr

if @@error != 0
begin
   print 'Error al actualizar informacion de Destino Economico del Credito'
   select 
   @w_error = 705074,
   @w_mensaje = 'Error al actualizar informacion de Destino Economico del Credito'
   goto ERROR_PROCESO
end

update #operaciones_hrc set   
num_linea_madre = convert(varchar, tg_grupo),
tramite_grp     = convert(varchar, tg_tramite)
from  cob_credito..cr_tramite_grupal
where cod_subproducto = '0001'
and   tg_operacion = operacion 
and   tg_prestamo  = num_cred

if @@error != 0
begin
   print 'Error al actualizar informacion de Grupos'
   select 
   @w_error = 705074,
   @w_mensaje = 'Error al actualizar informacion de Grupos'
   goto ERROR_PROCESO
end
/*
update #operaciones_hrc set 
num_linea_madre = convert(varchar, dc_grupo)
from cob_cartera..ca_det_ciclo
where dc_operacion = operacion
and   dc_cliente   = cliente

if @@error != 0
begin
   print 'Error al actualizar informacion de Grupos'
   select 
   @w_error = 705074,
   @w_mensaje = 'Error al actualizar informacion de Grupos'
   goto ERROR_PROCESO
end
*/
--MTA Inicio Caso 111362
--llenar datos del consolidador
select @w_fecha_consolidador = max(do_fecha)
FROM   cob_conta_super..sb_dato_operacion
where  do_aplicativo = 7
AND    do_fecha < @w_fecha_proceso

SELECT do_numero_ciclos, do_numero_integrantes, do_fecha, banco= do_banco, do_codigo_cliente, do_tramite, do_grupo
into #datos_consolidador
FROM   cob_conta_super..sb_dato_operacion,
       #operaciones_hrc
where  do_fecha      = @w_fecha_consolidador
and    do_aplicativo = 7
AND    do_banco = num_cred

SELECT tg_grupo, nro_integrantes = count(tg_cliente) 
INTO  #integrantes
FROM  #datos_consolidador,
      cob_credito..cr_tramite_grupal
WHERE banco = tg_prestamo
AND   do_grupo = tg_grupo
AND   tg_participa_ciclo = 'S'
GROUP BY tg_grupo

UPDATE #operaciones_hrc 
SET   num_hijas_grupo = do_numero_integrantes
FROM  #datos_consolidador
WHERE num_cred = banco

--INDIVIDUAL -- Sop.189747
select @w_cod_subproducto_ind = (select substring(valor, 1 , charindex(';', valor)-1) 
                                 from cobis..cl_catalogo where tabla = @w_sub_prod_rep and codigo = 'INDIVIDUAL')
update #operaciones_hrc 
set    num_hijas_grupo = '1'
where  cod_subproducto = @w_cod_subproducto_ind

--integrantes del grupo  y ciclo grupal
UPDATE #operaciones_hrc 
SET ciclo_grupo = do_numero_ciclos
FROM #datos_consolidador
WHERE num_cred = banco

--ciclo individual
SELECT num_ciclo = count(1), ente = tg_cliente 
INTO #ciclo_ind
FROM cob_credito..cr_tramite_grupal,
cob_cartera..ca_operacion
where tg_operacion = op_operacion
AND op_estado NOT IN (0,99,6)
AND tg_monto >0 
and tg_prestamo <> tg_referencia_grupal
AND tg_participa_ciclo = 'S'                
GROUP BY tg_cliente 


UPDATE #operaciones_hrc
SET ciclo_ind = num_ciclo
FROM #ciclo_ind
WHERE cliente = ente  

--ciclo individual INDIVIDUAL -- Sop.189747
select 
@w_est_no_vigente = isnull(@w_est_no_vigente, 0),
@w_est_anulado    = isnull(@w_est_anulado, 6),
@w_est_credito    = isnull(@w_est_credito, 99)

select num_ciclo = count(1), ente = op_cliente 
into #ciclo_ind_ind
from cob_cartera..ca_operacion  
where op_toperacion = 'INDIVIDUAL'
and op_estado not in (@w_est_no_vigente, @w_est_anulado, @w_est_credito)
group by op_cliente

update #operaciones_hrc
set  ciclo_ind = num_ciclo
from #ciclo_ind_ind
where cliente = ente  
and   cod_subproducto = @w_cod_subproducto_ind


--MTA Fin

/* Se Genera LCR */
exec sp_riesgo_hrc_lcr
@i_param1 = @w_fecha_proceso,
@i_param2 = @w_ffecha_data,
@i_param3 = 'C'

truncate table cob_conta_super..sb_riesgo_hrc
insert into cob_conta_super..sb_riesgo_hrc
(
rh_fec_info                     ,
rh_num_cred                     ,
rh_num_cliente_operativo        ,
rh_desc_nombre_cliente          ,
rh_cod_entidad                  ,
rh_desc_entidad                 ,
rh_desc_sistema_origen          ,
rh_num_suc_titular              ,
rh_cod_producto                 ,
rh_cod_subproducto              ,
rh_desc_producto                ,
rh_desc_subproducto             ,
rh_flg_revolvente               ,
rh_flg_tratamiento_contable     ,
rh_cod_tipo_amortiza            ,
rh_desc_tipo_amortiza           ,
rh_num_cta_cheques              ,
rh_fec_formaliza                ,
rh_fec_vencimiento              ,
rh_cod_tasa                     ,
rh_desc_tasa                    ,
rh_flg_tasa_variable            ,
rh_fec_prox_revisa_tasa         ,
rh_cod_periodo_revisa_tasa      ,
rh_pct_tasa_cobr                ,
rh_num_puntos_spread            ,
rh_fec_ult_amort_incump_cap     ,
rh_fec_ult_amort_incump_int     ,
rh_num_doctos_vencidos          ,
rh_cod_periodo_capital          ,
rh_desc_periodo_capital         ,
rh_cod_periodo_intereses        ,
rh_desc_periodo_intereses       ,
rh_cod_bloqueo                  ,
rh_desc_bloqueo                 ,
rh_cod_moneda                   ,
rh_imp_concedido                ,
rh_imp_limite_credito           ,
rh_imp_disponible               ,
rh_imp_total_riesgo_sistema     ,
rh_imp_cap_noexig               ,
rh_imp_cap_exig                 ,
rh_imp_int_noexig               ,
rh_imp_int_exig                 ,
rh_imp_int_suspen               ,
rh_imp_inversion                ,
rh_imp_total_riesgo             ,
rh_fec_traspaso_vencido         ,
rh_num_linea_madre              ,
rh_flg_mora_sistema             ,
rh_fec_prox_corte               ,
rh_cod_pais_origen              ,
rh_cod_pais_residencia          ,
rh_cod_tipo_persona             ,
rh_cod_sector_economico         ,
rh_cod_unidad_negocio           ,
rh_cod_unidad_negocio_ope_ori   ,
rh_cod_sector_contable          ,
rh_cod_actividad_economica      ,
rh_desc_rfc                     ,
rh_desc_pais_origen             ,
rh_desc_pais_residencia         ,
rh_desc_sector_economico        ,
rh_desc_tipo_persona            ,
rh_desc_unidad_negocio          ,
rh_cod_localidad_dom_primario   ,
rh_desc_actividad_economica_esp ,
rh_fec_prox_corte_prin          ,
rh_fec_prox_corte_int           ,
rh_fec_formaliza_ult_disp       ,
rh_imp_seguro_desempleo         ,
rh_imp_seguro_vida              ,
rh_flg_garantia                 ,
rh_pct_tasa_base                ,
rh_imp_pag_adelantado           ,
rh_num_ult_recibo_facturado     ,
rh_cod_bloq_disposicion         ,
rh_imp_pago_domiciliado         ,
rh_fec_cobranza                 ,
rh_pct_cat                      ,
rh_desc_tipo_solicitud          ,
rh_desc_canal                   ,
rh_fec_vencimiento_renovacion   ,
rh_fec_nacimiento               ,
rh_cod_estado_civil             ,
rh_cod_genero                   ,
rh_imp_ingreso_dispersion       ,
rh_flg_dispersion_ult_3m        ,
rh_cod_tipo_interviniente       ,
rh_cod_finalidad_credito        ,
rh_cod_periodo_capital1         ,
rh_cod_periodo_capital2         ,
rh_num_dias_atraso              ,
rh_num_plazo_remanente_dias     ,
rh_integrantes_grupo            ,
rh_ciclo_individual             ,
rh_ciclo_grupal                 
)
select 
fec_info              ,
num_cred              ,
--operacion           , 
--cliente             ,
num_cliente_operativo ,
desc_nombre_cliente   ,
cod_entidad           ,
desc_entidad          ,
desc_sistema_origen   ,
num_suc_titular       ,
cod_producto          ,
cod_subproducto       ,
desc_producto         ,
desc_subproducto      ,
flg_revolvente           ,
flg_tratamiento_contable ,
cod_tipo_amortiza        ,
desc_tipo_amortiza       ,
num_cta_cheques          ,
fec_formaliza            ,
fec_vencimiento          ,
cod_tasa                 ,
desc_tasa                ,
flg_tasa_variable        ,
fec_prox_revisa_tasa     ,
cod_periodo_revisa_tasa  ,
pct_tasa_cobr            ,
num_puntos_spread        ,
fec_ult_amort_incump_cap ,
fec_ult_amort_incump_int ,
num_doctos_vencidos      ,
cod_periodo_capital      ,
desc_periodo_capital     ,
cod_periodo_intereses    ,
desc_periodo_intereses   ,
cod_bloqueo              ,
desc_bloqueo             ,
cod_moneda               ,
imp_concedido            ,
imp_limite_credito       ,
imp_disponible           ,
imp_total_riesgo_sistema ,
imp_cap_noexig           ,
imp_cap_exig             ,
imp_int_noexig           ,
imp_int_exig             ,
imp_int_suspen           ,
imp_inversion            ,
imp_total_riesgo         ,
fec_traspaso_vencido     ,
num_linea_madre          ,
flg_mora_sistema         ,
fec_prox_corte           , 
cod_pais_origen          ,
cod_pais_residencia      ,
cod_tipo_persona         ,
cod_sector_economico     , 
cod_unidad_negocio       ,
cod_unidad_negocio_ope_ori ,
cod_sector_contable        ,
cod_actividad_economica    ,
desc_rfc                 ,  
desc_pais_origen         ,
desc_pais_residencia     ,
desc_sector_economico    ,
desc_tipo_persona        ,
desc_unidad_negocio      ,
cod_localidad_dom_primario   ,
desc_actividad_economica_esp ,
fec_prox_corte_prin      ,
fec_prox_corte_int       ,
fec_formaliza_ult_disp   ,
imp_seguro_desempleo     ,
imp_seguro_vida          ,
flg_garantia             ,
pct_tasa_base            ,
imp_pag_adelantado       ,
num_ult_recibo_facturado ,
cod_bloq_disposicion     ,
imp_pago_domiciliado     ,
fec_cobranza             ,
pct_cat                  ,
desc_tipo_solicitud      ,  
desc_canal               ,  
fec_vencimiento_renovacion  ,
fec_nacimiento           ,
cod_estado_civil         ,
cod_genero               ,
imp_ingreso_dispersion   ,
flg_dispersion_ult_3m    ,
cod_tipo_interviniente   ,
cod_finalidad_credito    ,
cod_periodo_capital1     ,
cod_periodo_capital2     ,
num_dias_atraso          ,
num_plazo_remanente_dias ,
num_hijas_grupo          ,
ciclo_ind                ,
ciclo_grupo
from  #operaciones_hrc
union
select
FECHA_INFO,
NUM_CRED,
NUM_CLIENTE_OPERATIVO,
DESC_NOMBRE_CLIENTE,
COD_ENTIDAD,
DESC_ENTIDAD,
DESC_SISTEMA_ORIG,
NUM_SUC_TITULAR,
COD_PRODUCTO,
COD_SUBPRODUCTO,
DESC_PRODUCTO,
DESC_SUBPRODUCTO,
FLG_REVOLVENTE,
FLG_TRATAMIENTO_CONTABLE,
COD_TIPO_AMORTIZA,
DESC_TIPO_AMORTIZA,
NUM_CTA_CHEQUES,
FEC_FORMALIZA,
FEC_VENCIMIENTO,
COD_TASA,
DESC_TASA,
FLG_TASA_VARIABLE,
FEC_PROX_REVISA_TASA,
COD_PERIODO_REVISA_TASA,
PCT_TASA_COBR,
NUM_PUNTOS_SPREAD,
FEC_ULT_AMORT_INCUMP_CAP,
FEC_ULT_AMORT_INCUMP_INT,
NUM_DOCTOS_VENCIDOS,
COD_PERIODO_CAPITAL,
DESC_PERIODO_CAPITAL,
COD_PERIODO_INTERESES,
DESC_PERIODO_INTERESES,
COD_BLOQUEO,
DESC_BLOQUEO,
COD_MONEDA,
IMP_CONCEDIDO,
IMP_LIMITE_CREDITO,
IMP_DISPONIBLE,
IMP_TOTAL_RIESGO_SISTEMA,
IMP_CAP_NOEXIG,
IMP_CAP_EXIG,
IMP_INT_NOEXIG,
IMP_INT_EXIG,
IMP_INT_SUSPEN,
IMP_INVERSION,
IMP_TOTAL_RIESGO,
FEC_TRASPASO_VENCIDO,
NUM_LINEA_MADRE,
FLG_MORA_SISTEMA,
FEC_PROX_CORTE,
COD_PAIS_ORIGEN,
COD_PAIS_RESIDENCIA,
COD_TIPO_PERSONA,
COD_SECTOR_ECONOMICO,
COD_UNIDAD_NEGOCIO,
COD_UNIDAD_NEGOCIO_OPE_ORI,
COD_SECTOR_CONTABLE,
COD_ACTIVIDAD_ECONOMICA,
DESC_RFC,
DESC_PAIS_ORIGEN,
DESC_PAIS_RESIDENCIA,
DESC_SECTOR_ECONOMICO,
DESC_TIPO_PERSONA,
DESC_UNIDAD_NEGOCIO,
COD_LOCALIDAD_DOM_PRIMARIO,
DESC_ACTIVIDAD_ECONOMICA_ESP,
FEC_PROX_CORTE_PRIN,
FEC_PROX_CORTE_INT,
FEC_FORMALIZA_ULT_DISP,
IMP_SEGURO_DESEMPLEO,
IMP_SEGURO_VIDA,
FLG_GARANTIA,
PCT_TASA_BASE,
IMP_PAG_ADELANTADO,
NUM_ULT_RECIBO_FACTURADO,
COD_BLOQ_DISPOSICION,
IMP_PAGO_DOMICILIADO,
FEC_COBRANZA,
PCT_CAT,
DESC_TIPO_SOLICITUD,
DESC_CANAL,
FEC_VENCIMIENTO_RENOVACION,
FEC_NACIMIENTO,
COD_ESTADO_CIVIL,
COD_GENERO,
IMP_INGRESO_DISPERSION,
FLG_DISPERSION_ULT_3M,
COD_TIPO_INTERVINIENTE,
COD_FINALIDAD_CREDITO,
COD_PERIODO_CAPITAL_1,
COD_PERIODO_CAPITAL_1,
NUM_DIAS_ATRASO,
NUM_PLAZO_REMANENTE_DIAS,
INTEGRANTES_GRUPO, -- Sop.189747
CICLO_INDIVIDUAL,  -- Sop.189747
''
from cob_conta_super..sb_riesgo_hrc_lcr

if @@error != 0
begin
   print 'Error al actualizar informacion en Estructura para generar Reporte'
   select 
   @w_error = 70137,
   @w_mensaje = 'Error al actualizar informacion en Estructura para generar Reporte'
   goto ERROR_PROCESO
end

print 'Generando Cabeceras'
select @w_destino = @w_ruta_arch + @w_nombre_arch + '.txt',
       @w_errores = @w_ruta_arch + @w_nombre_arch + '.err'

select @w_col_id   = 0,
       @w_columna  = '',
       @w_cabecera = '',
       @w_nom_cabecera = '', 
       @w_nom_columnas = '',
       @w_cont_columnas = 0
       
while 1 = 1 begin
   set rowcount 1 
   select @w_columna = upper(substring(ltrim(rtrim(c.name)), 4, len(ltrim(rtrim(c.name))) - 3)),
          @w_col_id  = c.colid
   from sysobjects o, syscolumns c
   where o.id    = c.id
   and   o.name  = 'sb_riesgo_hrc'
   and   c.colid > @w_col_id
   order by c.colid
    
   if @@rowcount = 0 begin
      set rowcount 0
      break
   end
   
   set rowcount 0 
   select @w_cont_columnas = @w_cont_columnas + 1

   select @w_nom_cabecera = @w_nom_cabecera + 'cabecera' + right('00' + convert(varchar(2), @w_cont_columnas), 2) + char(44)
   select @w_cabecera = @w_cabecera + char(39) + @w_columna + char(39) + char(44)
   select @w_nom_columnas = @w_nom_columnas + 'rh_' + lower(@w_columna) + char(44)   
end

select @w_cabecera = substring(@w_cabecera, 1, len(@w_cabecera) - 1),
       @w_nom_cabecera = substring(@w_nom_cabecera, 1, len(@w_nom_cabecera) - 1),
       @w_nom_columnas = substring(@w_nom_columnas, 1, len(@w_nom_columnas) - 1)

--Escribir Cabecera
select    @w_sql = 'insert into cob_conta_super..sb_tmp_cabecera_hrc '
select    @w_sql = @w_sql + '('
select    @w_sql = @w_sql + @w_nom_cabecera
select    @w_sql = @w_sql + ')'
select    @w_sql = @w_sql + ' values '
select    @w_sql = @w_sql + '('
select    @w_sql = @w_sql + @w_cabecera
select    @w_sql = @w_sql + ')'

exec (@w_sql)

if @@ERROR <> 0 begin
   print 'Error generando Archivo de Cabeceras'
   print @w_sql
   select
   @w_error = 2108048,
   @w_mensaje = 'Error generando Archivo de Cabeceras'
   goto ERROR_PROCESO
end

select @w_sql = 'select '
select @w_sql = @w_sql + @w_nom_cabecera
select @w_sql = @w_sql + ' from cob_conta_super..sb_tmp_cabecera_hrc '
select @w_sql = @w_sql + ' union all ' 
select @w_sql = @w_sql + 'select '
select @w_sql = @w_sql + @w_nom_columnas
select @w_sql = @w_sql + ' from cob_conta_super..sb_riesgo_hrc '

select @w_comando = 'bcp "' + @w_sql + '" queryout "'
select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'+ ' -t"|" '

delete from @resultadobcp

insert into @resultadobcp
exec xp_cmdshell @w_comando;

select * from @resultadobcp

--SELECCIONA CON %ERROR% SI NO ENCUENTRA EN EL FORMATO: ERROR = 
if @w_mensaje is null
    select top 1 @w_mensaje = linea
    from  @resultadobcp 
    where upper(linea) like upper('%Error %')

print @w_mensaje

SALIDA_PROCESO:
   return 0

ERROR_PROCESO:

select @w_msg = mensaje
from  cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted

if @w_msg is null select @w_msg = @w_mensaje
else select @w_msg = @w_msg + ' - ' + @w_mensaje

exec @w_return       = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha_proceso,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

return @w_error

go