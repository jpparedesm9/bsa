/************************************************************************/
/*   Archivo:              riesgo_provision.sp                          */
/*   Stored procedure:     sp_riesgo_provision                          */
/*   Base de datos:        cob_ccnta_super                              */
/*   Producto:             Regulatorios                                 */
/*   Disenado por:                                                      */
/*   Fecha de escritura:   Marzo 2018                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Genera archivo de interface para operaciones en mora diarias       */
/*   banco SANTANDER MX.                                                */
/*                              CAMBIOS                                 */
/*    dcumbal               06/12/2019        Cambios en provisiones    */
/*    srojas                28/05/2020        #140125                   */
/*    Jsarzosa              16/09/2020        Optimizacion Batch        */
/*    dcumbal               14/01/2022        Caso #172727              */
/*    kvizcaino             27/01/2022        Error #177284              */
/*    kvizcaino             08/02/2022        Req.#177295-Cambio Formula*/
/*    dcumbal               09/03/2022        Caso #179643              */
/*    dcumbal               25/03/2022        Req. #179694              */
/*    KVI                   25/08/2022        Sop.189747                */
/************************************************************************/
use cob_conta_super
go

if exists (select 1 from sysobjects where name = 'sp_riesgo_provision')
   drop proc sp_riesgo_provision
go

create proc sp_riesgo_provision
(
   @i_param1   datetime = null   --FECHA REPROCESO
)

as

declare
@w_error                int,
@w_return               int,
@w_mensaje              varchar(255),
@w_sql                  varchar(5000),
@w_msg_error            varchar(150),
@w_comando              varchar(5000),
@w_ruta_arch            varchar(255),
@w_nombre_arch          varchar(150),
@w_sp_name              varchar(30),
@w_fecha_proceso        datetime,
@w_msg                  varchar(255),
@w_batch                int,
@w_s_app                varchar(30),
@w_destino              varchar(1000),
@w_errores              varchar(1000),
@w_est_no_vigente       tinyint,
@w_est_vigente          tinyint,
@w_est_vencido          tinyint,
@w_est_cancelado        tinyint,
@w_est_castigado        tinyint,
@w_est_diferido        tinyint,
@w_est_suspenso        tinyint,
@w_ciudad_nacional      int,
@w_fecha_ini            datetime,
@w_fecha_fin            datetime,
@w_fecha_corte          datetime,
@w_ffecha_data          smallint,
@w_ffecha_reporte       smallint,
@w_columna              varchar(50),
@w_col_id               int,
@w_cabecera             varchar(8000),
@w_nom_cabecera         varchar(8000),
@w_nom_columnas         varchar(8000),
@w_cont_columnas        int,
@w_fecha                datetime,
@w_nom_columnas_tot     VARCHAR(8000),
@w_cabecera_tot         VARCHAR(8000),
@w_est_etapa2           int

select @w_sp_name = 'sp_riesgo_provision'

select @w_fecha = @i_param1

declare @resultadobcp table (linea varchar(max))

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_ffecha_data = 111, @w_ffecha_reporte = 112, @w_batch = 36428

--Este proceso solo se ejecuta el primero de cada mes
if datediff(dd, @w_fecha, @w_fecha_proceso) = 0 begin 
   if datepart(dd,@w_fecha_proceso) <> 1 
   return 0
end else select @w_fecha_proceso = @w_fecha

--Obtiene el parametro de la ubicacion del kernel\bin en el servidor
select @w_s_app = pa_char
from  cobis..cl_parametro
where pa_producto = 'ADM' 
and   pa_nemonico = 'S_APP'


select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

--- ESTADOS DE CARTERA
exec @w_error    = cob_cartera..sp_estados_cca
@o_est_vigente   = @w_est_vigente   out,
@o_est_cancelado = @w_est_cancelado out,
@o_est_vencido   = @w_est_vencido   out,
@o_est_castigado = @w_est_castigado out,
@o_est_diferido  = @w_est_diferido  out,
@o_est_suspenso  = @w_est_suspenso  out,
@o_est_etapa2    = @w_est_etapa2     out

if @w_error <> 0 goto ERROR_PROCESO

truncate table sb_riesgo_provision

if exists(select 1 from sysobjects where name = 'sb_tmp_cabecera_provision' and type = 'U')
   drop table sb_tmp_cabecera_provision

create table sb_tmp_cabecera_provision
(
    cabecera01  varchar(50),
    cabecera02  varchar(50),
    cabecera03  varchar(50),
    cabecera04  varchar(50),
    cabecera05  varchar(50),
    cabecera06  varchar(50),
    cabecera07  varchar(50),
    cabecera08  varchar(50),
    cabecera09  varchar(50),
    cabecera10  varchar(50),
    cabecera11  varchar(50),
    cabecera12  varchar(50),
    cabecera13  varchar(50),
    cabecera14  varchar(50),
    cabecera15  varchar(50),
    cabecera16  varchar(50),
    cabecera17  varchar(50),
    cabecera18  varchar(50),
    cabecera19  varchar(50),
    cabecera20  varchar(50),
    cabecera21  varchar(50),
    cabecera22  varchar(50),
    cabecera23  varchar(50),
    cabecera24  varchar(50),
    cabecera25  varchar(50),
    cabecera26  varchar(50),
    cabecera27  varchar(50),
    cabecera28  varchar(50),
    cabecera29  varchar(50),
    cabecera30  varchar(50),
    cabecera31  varchar(50),
    cabecera32  varchar(50),
    cabecera33  varchar(50),
    cabecera34  varchar(50),
    cabecera35  varchar(50),
    cabecera36  varchar(50),
    cabecera37  varchar(50),
    cabecera38  varchar(50),
    cabecera39  varchar(50),
    cabecera40  varchar(50),
    cabecera41  varchar(50),
    cabecera42  varchar(50),
    cabecera43  varchar(50),
    cabecera44  varchar(50),
    cabecera45  varchar(50),
    cabecera46  varchar(50),
    cabecera47  varchar(50),
    cabecera48  varchar(50),
    cabecera49  varchar(50),
    cabecera50  varchar(50),
    cabecera51  varchar(50),
    cabecera52  varchar(50),
    cabecera53  varchar(50),
    cabecera54  varchar(50),
    cabecera55  varchar(50),
    cabecera56  varchar(50),
    cabecera57  varchar(50),
    cabecera58  varchar(50),
    cabecera59  varchar(50),
    cabecera60  varchar(50),
    cabecera61  varchar(50),
    cabecera62  varchar(50),
    cabecera63  varchar(50),
    cabecera64  varchar(50),
    cabecera65  varchar(50),
    cabecera66  varchar(50),
    cabecera67  varchar(50),
    cabecera68  varchar(50),
    cabecera69  varchar(50),
    cabecera70  varchar(50),
    cabecera71  varchar(50),
    cabecera72  varchar(50),
    cabecera73  varchar(50),
    cabecera74  varchar(50),
    cabecera75	 varchar(50),
    cabecera76	 varchar(50),
    cabecera77	 varchar(50),
    cabecera78	 varchar(50),
    cabecera79	 varchar(50),
    cabecera80	 varchar(50),
    cabecera81	 varchar(50),
    cabecera82	 varchar(50),
    cabecera83	 varchar(50),
    cabecera84	 varchar(50),
    cabecera85	 varchar(50),
    cabecera86	 varchar(50),
    cabecera87	 varchar(50),
    cabecera88	 varchar(50),
    cabecera89	 varchar(50),
    cabecera90	 varchar(50),
    cabecera91	 varchar(50),
    cabecera92	 varchar(50),
    cabecera93	 varchar(50),
    cabecera94	 varchar(50),
    cabecera95	 varchar(50),
    cabecera96	 varchar(50),
    cabecera97	 varchar(50),
    cabecera98	 varchar(50),
    cabecera99	 varchar(50),
    cabecera100	 varchar(50),
    cabecera101	 varchar(50),
    cabecera102	 varchar(50),
    cabecera103	 varchar(50),
    cabecera104	 varchar(50),
    cabecera105	 varchar(50),
    cabecera106	 varchar(50),
	cabecera107	 varchar(50) -- Sop.189747 
)

select @w_fecha_fin = dateadd(dd,0-datepart(dd,@w_fecha_proceso),@w_fecha_proceso)

select
@w_ruta_arch    = ba_path_destino,
@w_nombre_arch  = isnull(upper(ba_arch_resultado), 'COBIS_PROV') + '_' + convert(varchar(8), @w_fecha_fin, 112)
from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
end

--HASTA ENCONTRAR EL HABIL ANTERIOR
select @w_fecha_corte  = @w_fecha_fin

while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_corte)
   select @w_fecha_corte = dateadd(dd,-1,@w_fecha_corte)


print 'selecciona data'

SELECT * INTO #sb_riesgo_provision FROM sb_riesgo_provision WHERE 1 = 2

insert into #sb_riesgo_provision
select
Num_cred              = ltrim(rtrim(do_banco)),
Num_cliente           = do_codigo_cliente,
Num_grupo             = convert(varchar(10), isnull(do_grupo,'')),
Cod_producto          = '96',
Cod_subproducto       = case do_tipo_operacion
                             when 'GRUPAL'     then '0001'
                             when 'INDIVIDUAL' then '0004'
                             when 'INTERCICLO' then '0003'
                        end,
Cod_periodo_capital   = case do_periodicidad_cuota
                             when 1  then 'D'
                             when 7  then 'W'
							 when 14 then 'Q'
                             when 15 then 'Q'
                             when 30 then 'M'
                             when 90 then 'T'
                        end,
Cod_periodo_intereses = case do_periodicidad_cuota
                             when 1  then 'D'
                             when 7  then 'W'
							 when 14 then 'Q'
                             when 15 then 'Q'
                             when 30 then 'M'
                             when 90 then 'T'
                        end,
Exig_T1               = convert(varchar(20), 0.00),
Pago_T1               = convert(varchar(20), 0.00),
Fec_Exig_T1           = convert(varchar(20), '00010101'),
Fec_Pago_T1           = convert(varchar(20), '00010101'),
Exig_T2               = convert(varchar(20), 0.00),
Pago_T2               = convert(varchar(20), 0.00),
Fec_Exig_T2           = convert(varchar(20), '00010101'),
Fec_Pago_T2           = convert(varchar(20), '00010101'),
Exig_T3               = convert(varchar(20), 0.00),
Pago_T3               = convert(varchar(20), 0.00),
Fec_Exig_T3           = convert(varchar(20), '00010101'),
Fec_Pago_T3           = convert(varchar(20), '00010101'),
Exig_T4               = convert(varchar(20), 0.00),
Pago_T4               = convert(varchar(20), 0.00),
Fec_Exig_T4           = convert(varchar(20), '00010101'),
Fec_Pago_T4           = convert(varchar(20), '00010101'),
Exig_T5               = convert(varchar(20), 0.00),
Pago_T5               = convert(varchar(20), 0.00),
Fec_Exig_T5           = convert(varchar(20), '00010101'),
Fec_Pago_T5           = convert(varchar(20), '00010101'),
Exig_T6               = convert(varchar(20), 0.00),
Pago_T6               = convert(varchar(20), 0.00),
Fec_Exig_T6           = convert(varchar(20), '00010101'),
Fec_Pago_T6           = convert(varchar(20), '00010101'),
Exig_T7               = convert(varchar(20), 0.00),
Pago_T7               = convert(varchar(20), 0.00),
Fec_Exig_T7           = convert(varchar(20), '00010101'),
Fec_Pago_T7           = convert(varchar(20), '00010101'),
Exig_T8               = convert(varchar(20), 0.00),
Pago_T8               = convert(varchar(20), 0.00),
Fec_Exig_T8           = convert(varchar(20), '00010101'),
Fec_Pago_T8           = convert(varchar(20), '00010101'),
Exig_T9               = convert(varchar(20), 0.00),
Pago_T9               = convert(varchar(20), 0.00),
Fec_Exig_T9           = convert(varchar(20), '00010101'),
Fec_Pago_T9           = convert(varchar(20), '00010101'),
Exig_T10              = convert(varchar(20), 0.00),
Pago_T10              = convert(varchar(20), 0.00),
Fec_Exig_T10          = convert(varchar(20), '00010101'),
Fec_Pago_T10          = convert(varchar(20), '00010101'),
Exig_T11              = convert(varchar(20), 0.00),
Pago_T11              = convert(varchar(20), 0.00),
Fec_Exig_T11          = convert(varchar(20), '00010101'),
Fec_Pago_T11          = convert(varchar(20), '00010101'),
Exig_T12              = convert(varchar(20), 0.00),
Pago_T12              = convert(varchar(20), 0.00),
Fec_Exig_T12          = convert(varchar(20), '00010101'),
Fec_Pago_T12          = convert(varchar(20), '00010101'),
Exig_T13              = convert(varchar(20), 0.00),
Pago_T13              = convert(varchar(20), 0.00),
Fec_Exig_T13          = convert(varchar(20), '00010101'),
Fec_Pago_T13          = convert(varchar(20), '00010101'),
Exig_T14              = convert(varchar(20), 0.00),
Pago_T14              = convert(varchar(20), 0.00),
Fec_Exig_T14          = convert(varchar(20), '00010101'),
Fec_Pago_T14          = convert(varchar(20), '00010101'),
Exig_T15              = convert(varchar(20), 0.00),
Pago_T15              = convert(varchar(20), 0.00),
Fec_Exig_T15          = convert(varchar(20), '00010101'),
Fec_Pago_T15          = convert(varchar(20), '00010101'),
Exig_T16              = convert(varchar(20), 0.00),
Pago_T16              = convert(varchar(20), 0.00),
Fec_Exig_T16          = convert(varchar(20), '00010101'),
Fec_Pago_T16          = convert(varchar(20), '00010101'),
Imp_total_riesgo      = convert(varchar(20), isnull(do_saldo_cap,0.00) + isnull(do_saldo_int, 0.00)),
Integrantes           = convert(varchar(4),isnull(do_numero_integrantes,1)),
Ciclos                = convert(varchar(4),isnull(do_numero_ciclos,1)),
Exig_T17	          = convert(varchar(20), 0.00),
Pago_T17	          = convert(varchar(20), 0.00),
Fec_Exig_T17	      = convert(varchar(20), '00010101'),
Fec_Pago_T17	      = convert(varchar(20), '00010101'),
Exig_T18	          = convert(varchar(20), 0.00),
Pago_T18	          = convert(varchar(20), 0.00),
Fec_Exig_T18	      = convert(varchar(20), '00010101'),
Fec_Pago_T18	      = convert(varchar(20), '00010101'),
Exig_T19	          = convert(varchar(20), 0.00),
Pago_T19	          = convert(varchar(20), 0.00),
Fec_Exig_T19	      = convert(varchar(20), '00010101'),
Fec_Pago_T19	      = convert(varchar(20), '00010101'),
Exig_T20	          = convert(varchar(20), 0.00),
Pago_T20	          = convert(varchar(20), 0.00),
Fec_Exig_T20	      = convert(varchar(20), '00010101'),
Fec_Pago_T20	      = convert(varchar(20), '00010101'),
Exig_T21	          = convert(varchar(20), 0.00),
Pago_T21	          = convert(varchar(20), 0.00),
Fec_Exig_T21	      = convert(varchar(20), '00010101'),
Fec_Pago_T21	      = convert(varchar(20), '00010101'),
Exig_T22	          = convert(varchar(20), 0.00),
Pago_T22	          = convert(varchar(20), 0.00),
Fec_Exig_T22	      = convert(varchar(20), '00010101'),
Fec_Pago_T22	      = convert(varchar(20), '00010101'),
Exig_T23	          = convert(varchar(20), 0.00),
Pago_T23	          = convert(varchar(20), 0.00),
Fec_Exig_T23	      = convert(varchar(20), '00010101'),
Fec_Pago_T23	      = convert(varchar(20), '00010101'),
Exig_T24	          = convert(varchar(20), 0.00),
Pago_T24	          = convert(varchar(20), 0.00),
Fec_Exig_T24	      = convert(varchar(20), '00010101'),
Fec_Pago_T24	      = convert(varchar(20), '00010101'),
Folio_Consulta_Buro   = (select tr_folio_buro from cob_credito..cr_tramite where tr_tramite = do_tramite) -- Sop.189747
from  cob_conta_super..sb_dato_operacion
where do_fecha      = @w_fecha_corte
and   do_aplicativo = 7
and   do_estado_cartera in (@w_est_vigente, @w_est_etapa2, @w_est_vencido)
and   do_tipo_operacion not in ('REVOLVENTE')
ORDER BY do_banco

if @@error != 0
begin
   print 'Error en la carga inicial de Operaciones'
   select
   @w_error   = 724617,
   @w_mensaje = 'Error en la carga inicial de Operaciones'
   goto ERROR_PROCESO
end

CREATE CLUSTERED INDEX idx_banco ON #sb_riesgo_provision(Num_cred)
CREATE INDEX idx_cliente ON #sb_riesgo_provision(Num_cliente)


-- Inicio Req.#177295 ------------------------------------------------

/* Capitales e intereses*/
select
dr_banco,
--CAPITALES
dr_cap_vig_ex    = sum(case when dr_categoria  = 'C'  and dr_estado in (@w_est_vigente, @w_est_vencido, @w_est_castigado)  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_cap_vig_ne    = sum(case when dr_categoria  = 'C'  and dr_estado =   @w_est_vigente  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end ), 
--INTERESES
dr_int_vig_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_int_vig_ne    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end), 
dr_int_ven_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
dr_int_ven_ne    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end),
dr_int_sus_ex    = sum(case when dr_categoria  = 'I' and dr_estado in (@w_est_suspenso,@w_est_castigado) and dr_exigible   = 1   then  isnull(dr_valor,0) else 0 end ),
dr_int_sus_ne    = sum(case when dr_categoria  = 'I' and dr_estado in (@w_est_suspenso,@w_est_castigado) and dr_exigible   = 0   then  isnull(dr_valor,0) else 0 end ),
--SEGUROS
dr_seg_saldo     = sum(case when dr_categoria  = 'S' then  isnull(dr_valor, 0) else 0 end)
into #rubros
from #sb_riesgo_provision, cob_conta_super..sb_dato_operacion_rubro
where dr_fecha      = @w_fecha_corte
and   dr_aplicativo = 7
and   dr_banco      = Num_cred
group by dr_banco

create table #rubros_hrc(
  imp_cap_noexig        money        null,
  imp_cap_exig          money        null,
  imp_int_noexig        money        null,
  imp_int_exig          money        null,
  imp_int_suspen        money        null,
  imp_seguro_vida       money        null,
  imp_total_riesgo      money        null,
  num_cred              varchar(24)  null
)

insert into #rubros_hrc
select
imp_cap_noexig           = dr_cap_vig_ne,
imp_cap_exig             = dr_cap_vig_ex,
imp_int_noexig           = dr_int_vig_ne + dr_int_ven_ne,
imp_int_exig             = dr_int_vig_ex + dr_int_ven_ex,
imp_int_suspen           = dr_int_sus_ex + dr_int_sus_ne,
imp_seguro_vida          = dr_seg_saldo,
imp_total_riesgo         = null,
num_cred                 = dr_banco  
from #rubros

update #rubros_hrc set 
imp_total_riesgo         = isnull(imp_cap_noexig,0) + isnull(imp_cap_exig,0) + isnull(imp_int_noexig,0) + isnull(imp_int_exig,0)

update #sb_riesgo_provision
set Imp_total_riesgo = convert(varchar(20), isnull(imp_total_riesgo,0.00))
from #rubros_hrc
where num_cred       = Num_cred

-- Fin Req.#177295 --------------------------------------------------------------

select 
grupo         = Num_grupo,
ciclo         = Ciclos,
integr        = count(1) 
into #grupo_integrantes
from #sb_riesgo_provision 
group by Num_grupo ,Ciclos

update #sb_riesgo_provision set
Integrantes = 1
where Cod_subproducto = '0004' 
/*
select 
cliente = op_cliente, ---------------**Cambio de sb_dato_operacion por ca_operacion
ciclo   = count(distinct op_banco)
into #ciclo_individual
from  cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal
where op_fecha_liq      <= @w_fecha_corte
--and   do_aplicativo = 7
and   op_estado in (@w_est_vigente,   @w_est_vencido,  @w_est_cancelado,
                    @w_est_castigado, @w_est_diferido, @w_est_suspenso)--(1,2,3,4,8,9)
and   op_toperacion not in ('REVOLVENTE')
and   op_tipo <> 'O' -- o es el papa
and   tg_cliente  = op_cliente
and   tg_prestamo = op_banco
and   tg_monto > 0
and   tg_participa_ciclo = 'S'
group by op_cliente
ORDER BY op_cliente

CREATE CLUSTERED INDEX idx_cli ON #ciclo_individual(cliente)

update #sb_riesgo_provision set 
Ciclos = ciclo
from #ciclo_individual
where Num_cliente = cliente*/

update #sb_riesgo_provision 
set Ciclos    = isnull(dc_ciclo,0) ---caso#166473
from cob_cartera..ca_operacion, cob_cartera..ca_det_ciclo 
where Num_cred = op_banco
and op_operacion = dc_operacion


update #sb_riesgo_provision set
Num_cliente = isnull(en_banco,'')
from  cobis..cl_ente
where Num_cliente = en_ente

if @@error != 0
begin
   print 'Error al actualizar informacion referencial de Clientes'
   select
   @w_error = 705074,
   @w_mensaje = 'Error al actualizar informacion referencial de Clientes'
   goto ERROR_PROCESO
end

select
banco     = dc_banco,
num_cuota = dc_num_cuota,
max_cuota = max(dc_num_cuota),
Exig_Parc = isnull(sum(dc_cap_cuota + dc_int_acum + dc_iva_int_acum),0), -- Suma de IVA Sop.189747
Pago      = convert(money,0),--isnull(sum(dc_cap_pag   + dc_int_pag   ),0),
Fec_Exig  = isnull(max(dc_fecha_vto),'01/01/1900'),
Fec_Pago  = convert(datetime,null),--isnull(max(dc_fecha_upago),'01/01/1900'),
FechaIni  = isnull(max(dc_fecha_ini),'01/01/1900'),
pendiente = convert(money,0),
Exig      = convert(money,0)
into  #exigibles
from  cob_conta_super..sb_dato_cuota_pry
where dc_fecha      = @w_fecha_corte
and   dc_aplicativo = 7
and   dc_fecha_vto  <= @w_fecha_fin
group by dc_banco, dc_num_cuota
ORDER BY dc_banco

CREATE CLUSTERED INDEX idx_banco_cuota ON #exigibles (banco)

if @@error != 0
begin
   print 'Error al consultar saldos exigibles'
   select
   @w_error = 724619,
   @w_mensaje = 'Error al consultar saldos exigibles'
   goto ERROR_PROCESO
end

--ActualizacionPagos
select 
fecha      = dt_fecha,
banco      = dt_banco,
secuencial = dt_secuencial,
fecha_trans= dt_fecha_trans 
into #pagos_total
from sb_dato_transaccion, #sb_riesgo_provision
where  dt_banco   = Num_cred
and dt_reversa    = 'N'
and dt_tipo_trans = 'PAG'
and dt_fecha   <= @w_fecha_corte
ORDER BY dt_banco

CREATE CLUSTERED INDEX idx_banco_sec ON #pagos_total(banco)

delete #pagos_total  from sb_dato_transaccion 
where banco     =  dt_banco  
and  secuencial = -1*dt_secuencial 
and  dt_reversa = 'S'

select dt_banco = banco, dt_fecha_trans = fecha_trans, valor_pago= sum(dd_monto)
into #pagos
from #pagos_total,
     cob_conta_super..sb_dato_transaccion_det
where banco          = dd_banco
and   secuencial     = dd_secuencial
and   fecha          = dd_fecha
and   dd_concepto    in ('CAP', 'INT', 'IVA_INT') -- Suma de IVA Sop.189747
group by banco, fecha_trans
ORDER BY banco

CREATE CLUSTERED INDEX idx_banco_fech ON #pagos(dt_banco)

select  banco_p = banco            , 
        num_cuota_p = num_cuota    , 
        valor_pago_p = sum(valor_pago),
        fecha_pago_p = max(dt_fecha_trans) 
into #pagos_operaciones
from #exigibles,
     #pagos
where banco        = dt_banco
and   dt_fecha_trans  > FechaIni
and   dt_fecha_trans <= Fec_Exig
group by banco, num_cuota
order by banco

CREATE CLUSTERED INDEX idx_banco_num_cuota ON #pagos_operaciones(banco_p)

update #exigibles set 
Pago     = valor_pago_p,
Fec_Pago = fecha_pago_p
from  #pagos_operaciones
where banco_p     = banco
and   num_cuota_p = num_cuota

update #exigibles set
pendiente = Exig_Parc - Pago

select banco_t                = banco,
       num_cuota_t            = num_cuota,
       monto_pendiente_sumado =  (select sum(pendiente)
                                  from #exigibles t
                                  where t.banco      = d.banco
                                  and   t.num_cuota <= d.num_cuota)             
into #pendientes_totales
from #exigibles d
group by banco, num_cuota
ORDER by banco

CREATE CLUSTERED INDEX idx_banco_num_cta ON #pendientes_totales(banco_t)

select ep_banco     = banco, 
       ep_num_cuota = num_cuota ,
       'valor_suma_cuota' = isnull((select sum(isnull(monto_pendiente_sumado,0))
                                    from #pendientes_totales
                                    where banco_t     = banco
                                    and   num_cuota_t = num_cuota - 1
                                   ),0)
into #exigibles_pendientes
from #exigibles
group by banco, num_cuota
ORDER BY banco

CREATE CLUSTERED INDEX idx_banco_numcuota ON #exigibles_pendientes(ep_banco)

update #exigibles set
Exig = case when Exig_Parc + isnull(valor_suma_cuota,0) > Exig_Parc then
          Exig_Parc + isnull(valor_suma_cuota,0)
       else 
          Exig_Parc end
from #exigibles_pendientes                            
where  banco = ep_banco 
and    num_cuota = ep_num_cuota

select
banco_max     = banco,
num_cuota_max = max(num_cuota)
into #exigibles_max
from #exigibles
group by banco
ORDER BY banco

CREATE CLUSTERED INDEX idx_banco ON #exigibles_max(banco_max)

if @@error != 0
begin
   print 'Error al consultar saldos exigibles maximos'
   select
   @w_error = 724619,
   @w_mensaje = 'Error al consultar saldos exigibles maximos'
   goto ERROR_PROCESO
end

update #exigibles set
max_cuota = num_cuota_max
from #exigibles_max
where banco = banco_max

if @@error != 0
begin
   print 'Error al actualizar saldos exigibles maximos'
   select
   @w_error = 705074,
   @w_mensaje = 'Error al actualizar saldos exigibles maximos'
   goto ERROR_PROCESO
end

select
ex_Num_cred      = banco,
ex_Exig_T1       = isnull(sum(case max_cuota - num_cuota + 1 when 1 then Exig else 0 end),0),
ex_Pago_T1       = isnull(sum(case max_cuota - num_cuota + 1 when 1 then Pago else 0 end),0),
ex_Fec_Exig_T1   = max(case max_cuota - num_cuota + 1        when 1 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T1   = max(case max_cuota - num_cuota + 1        when 1 then Fec_Pago else '01/01/1900' end),
ex_Exig_T2       = isnull(sum(case max_cuota - num_cuota + 1 when 2 then Exig else 0 end),0),
ex_Pago_T2       = isnull(sum(case max_cuota - num_cuota + 1 when 2 then Pago else 0 end),0),
ex_Fec_Exig_T2   = max(case max_cuota - num_cuota + 1        when 2 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T2   = max(case max_cuota - num_cuota + 1        when 2 then Fec_Pago else '01/01/1900' end),
ex_Exig_T3       = isnull(sum(case max_cuota - num_cuota + 1 when 3 then Exig else 0 end),0),
ex_Pago_T3       = isnull(sum(case max_cuota - num_cuota + 1 when 3 then Pago else 0 end),0),
ex_Fec_Exig_T3   = max(case max_cuota - num_cuota + 1        when 3 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T3   = max(case max_cuota - num_cuota + 1        when 3 then Fec_Pago else '01/01/1900' end),
ex_Exig_T4       = isnull(sum(case max_cuota - num_cuota + 1 when 4 then Exig else 0 end),0),
ex_Pago_T4       = isnull(sum(case max_cuota - num_cuota + 1 when 4 then Pago else 0 end),0),
ex_Fec_Exig_T4   = max(case max_cuota - num_cuota + 1        when 4 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T4   = max(case max_cuota - num_cuota + 1        when 4 then Fec_Pago else '01/01/1900' end),
ex_Exig_T5       = isnull(sum(case max_cuota - num_cuota + 1 when 5 then Exig else 0 end),0),
ex_Pago_T5       = isnull(sum(case max_cuota - num_cuota + 1 when 5 then Pago else 0 end),0),
ex_Fec_Exig_T5   = max(case max_cuota - num_cuota + 1        when 5 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T5   = max(case max_cuota - num_cuota + 1        when 5 then Fec_Pago else '01/01/1900' end),
ex_Exig_T6       = isnull(sum(case max_cuota - num_cuota + 1 when 6 then Exig else 0 end),0),
ex_Pago_T6       = isnull(sum(case max_cuota - num_cuota + 1 when 6 then Pago else 0 end),0),
ex_Fec_Exig_T6   = max(case max_cuota - num_cuota + 1        when 6 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T6   = max(case max_cuota - num_cuota + 1        when 6 then Fec_Pago else '01/01/1900' end),
ex_Exig_T7       = isnull(sum(case max_cuota - num_cuota + 1 when 7 then Exig else 0 end),0),
ex_Pago_T7       = isnull(sum(case max_cuota - num_cuota + 1 when 7 then Pago else 0 end),0),
ex_Fec_Exig_T7   = max(case max_cuota - num_cuota + 1        when 7 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T7   = max(case max_cuota - num_cuota + 1        when 7 then Fec_Pago else '01/01/1900' end),
ex_Exig_T8       = isnull(sum(case max_cuota - num_cuota + 1 when 8 then Exig else 0 end),0),
ex_Pago_T8       = isnull(sum(case max_cuota - num_cuota + 1 when 8 then Pago else 0 end),0),
ex_Fec_Exig_T8   = max(case max_cuota - num_cuota + 1        when 8 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T8   = max(case max_cuota - num_cuota + 1        when 8 then Fec_Pago else '01/01/1900' end),
ex_Exig_T9       = isnull(sum(case max_cuota - num_cuota + 1 when 9 then Exig else 0 end),0),
ex_Pago_T9       = isnull(sum(case max_cuota - num_cuota + 1 when 9 then Pago else 0 end),0),
ex_Fec_Exig_T9   = max(case max_cuota - num_cuota + 1        when 9 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T9   = max(case max_cuota - num_cuota + 1        when 9 then Fec_Pago else '01/01/1900' end),
ex_Exig_T10      = isnull(sum(case max_cuota - num_cuota + 1 when 10 then Exig else 0 end),0),
ex_Pago_T10      = isnull(sum(case max_cuota - num_cuota + 1 when 10 then Pago else 0 end),0),
ex_Fec_Exig_T10  = max(case max_cuota - num_cuota + 1        when 10 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T10  = max(case max_cuota - num_cuota + 1        when 10 then Fec_Pago else '01/01/1900' end),
ex_Exig_T11      = isnull(sum(case max_cuota - num_cuota + 1 when 11 then Exig else 0 end),0),
ex_Pago_T11      = isnull(sum(case max_cuota - num_cuota + 1 when 11 then Pago else 0 end),0),
ex_Fec_Exig_T11  = max(case max_cuota - num_cuota + 1        when 11 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T11  = max(case max_cuota - num_cuota + 1        when 11 then Fec_Pago else '01/01/1900' end),
ex_Exig_T12      = isnull(sum(case max_cuota - num_cuota + 1 when 12 then Exig else 0 end),0),
ex_Pago_T12      = isnull(sum(case max_cuota - num_cuota + 1 when 12 then Pago else 0 end),0),
ex_Fec_Exig_T12  = max(case max_cuota - num_cuota + 1        when 12 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T12  = max(case max_cuota - num_cuota + 1        when 12 then Fec_Pago else '01/01/1900' end),
ex_Exig_T13      = isnull(sum(case max_cuota - num_cuota + 1 when 13 then Exig else 0 end),0),
ex_Pago_T13      = isnull(sum(case max_cuota - num_cuota + 1 when 13 then Pago else 0 end),0),
ex_Fec_Exig_T13  = max(case max_cuota - num_cuota + 1        when 13 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T13  = max(case max_cuota - num_cuota + 1        when 13 then Fec_Pago else '01/01/1900' end),
ex_Exig_T14      = isnull(sum(case max_cuota - num_cuota + 1 when 14 then Exig else 0 end),0),
ex_Pago_T14      = isnull(sum(case max_cuota - num_cuota + 1 when 14 then Pago else 0 end),0),
ex_Fec_Exig_T14  = max(case max_cuota - num_cuota + 1        when 14 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T14  = max(case max_cuota - num_cuota + 1        when 14 then Fec_Pago else '01/01/1900' end),
ex_Exig_T15      = isnull(sum(case max_cuota - num_cuota + 1 when 15 then Exig else 0 end),0),
ex_Pago_T15      = isnull(sum(case max_cuota - num_cuota + 1 when 15 then Pago else 0 end),0),
ex_Fec_Exig_T15  = max(case max_cuota - num_cuota + 1        when 15 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T15  = max(case max_cuota - num_cuota + 1        when 15 then Fec_Pago else '01/01/1900' end),
ex_Exig_T16      = isnull(sum(case max_cuota - num_cuota + 1 when 16 then Exig else 0 end),0),
ex_Pago_T16      = isnull(sum(case max_cuota - num_cuota + 1 when 16 then Pago else 0 end),0),
ex_Fec_Exig_T16  = max(case max_cuota - num_cuota + 1        when 16 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T16  = max(case max_cuota - num_cuota + 1        when 16 then Fec_Pago else '01/01/1900' end),
ex_Exig_T17      = isnull(sum(case max_cuota - num_cuota + 1 when 17 then Exig else 0 end),0),
ex_Pago_T17      = isnull(sum(case max_cuota - num_cuota + 1 when 17 then Pago else 0 end),0),
ex_Fec_Exig_T17  = max(case max_cuota - num_cuota + 1        when 17 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T17  = max(case max_cuota - num_cuota + 1        when 17 then Fec_Pago else '01/01/1900' end),
ex_Exig_T18      = isnull(sum(case max_cuota - num_cuota + 1 when 18 then Exig else 0 end),0),
ex_Pago_T18      = isnull(sum(case max_cuota - num_cuota + 1 when 18 then Pago else 0 end),0),
ex_Fec_Exig_T18  = max(case max_cuota - num_cuota + 1        when 18 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T18  = max(case max_cuota - num_cuota + 1        when 18 then Fec_Pago else '01/01/1900' end),
ex_Exig_T19      = isnull(sum(case max_cuota - num_cuota + 1 when 19 then Exig else 0 end),0),
ex_Pago_T19      = isnull(sum(case max_cuota - num_cuota + 1 when 19 then Pago else 0 end),0),
ex_Fec_Exig_T19  = max(case max_cuota - num_cuota + 1        when 19 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T19  = max(case max_cuota - num_cuota + 1        when 19 then Fec_Pago else '01/01/1900' end),
ex_Exig_T20      = isnull(sum(case max_cuota - num_cuota + 1 when 20 then Exig else 0 end),0),
ex_Pago_T20      = isnull(sum(case max_cuota - num_cuota + 1 when 20 then Pago else 0 end),0),
ex_Fec_Exig_T20  = max(case max_cuota - num_cuota + 1        when 20 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T20  = max(case max_cuota - num_cuota + 1        when 20 then Fec_Pago else '01/01/1900' end),
ex_Exig_T21      = isnull(sum(case max_cuota - num_cuota + 1 when 21 then Exig else 0 end),0),
ex_Pago_T21      = isnull(sum(case max_cuota - num_cuota + 1 when 21 then Pago else 0 end),0),
ex_Fec_Exig_T21  = max(case max_cuota - num_cuota + 1        when 21 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T21  = max(case max_cuota - num_cuota + 1        when 21 then Fec_Pago else '01/01/1900' end),
ex_Exig_T22      = isnull(sum(case max_cuota - num_cuota + 1 when 22 then Exig else 0 end),0),
ex_Pago_T22      = isnull(sum(case max_cuota - num_cuota + 1 when 22 then Pago else 0 end),0),
ex_Fec_Exig_T22  = max(case max_cuota - num_cuota + 1        when 22 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T22  = max(case max_cuota - num_cuota + 1        when 22 then Fec_Pago else '01/01/1900' end),
ex_Exig_T23      = isnull(sum(case max_cuota - num_cuota + 1 when 23 then Exig else 0 end),0),
ex_Pago_T23      = isnull(sum(case max_cuota - num_cuota + 1 when 23 then Pago else 0 end),0),
ex_Fec_Exig_T23  = max(case max_cuota - num_cuota + 1        when 23 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T23  = max(case max_cuota - num_cuota + 1        when 23 then Fec_Pago else '01/01/1900' end),
ex_Exig_T24      = isnull(sum(case max_cuota - num_cuota + 1 when 24 then Exig else 0 end),0),
ex_Pago_T24      = isnull(sum(case max_cuota - num_cuota + 1 when 24 then Pago else 0 end),0),
ex_Fec_Exig_T24  = max(case max_cuota - num_cuota + 1        when 24 then Fec_Exig else '01/01/1900' end),
ex_Fec_Pago_T24  = max(case max_cuota - num_cuota + 1        when 24 then Fec_Pago else '01/01/1900' end)
into  #exigibles_h
from  #exigibles
GROUP BY banco
ORDER BY banco

if @@error != 0
begin
   print 'Error al consultar saldos exigibles'
   select
   @w_error = 724619,
   @w_mensaje = 'Error al consultar saldos exigibles'
   goto ERROR_PROCESO
end

update #sb_riesgo_provision set
Exig_T1       = convert(varchar, ex_Exig_T1),
Pago_T1       = convert(varchar, ex_Pago_T1),
Fec_Exig_T1   = case ex_Fec_Exig_T1 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T1, @w_ffecha_reporte) end,
Fec_Pago_T1   = case ex_Fec_Pago_T1 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T1, @w_ffecha_reporte) end,
Exig_T2       = convert(varchar, ex_Exig_T2),
Pago_T2       = convert(varchar, ex_Pago_T2),
Fec_Exig_T2   = case ex_Fec_Exig_T2 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T2, @w_ffecha_reporte) end,
Fec_Pago_T2   = case ex_Fec_Pago_T2 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T2, @w_ffecha_reporte) end,
Exig_T3       = convert(varchar, ex_Exig_T3),
Pago_T3       = convert(varchar, ex_Pago_T3),
Fec_Exig_T3   = case ex_Fec_Exig_T3 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T3, @w_ffecha_reporte) end,
Fec_Pago_T3   = case ex_Fec_Pago_T3 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T3, @w_ffecha_reporte) end,
Exig_T4       = convert(varchar, ex_Exig_T4),
Pago_T4       = convert(varchar, ex_Pago_T4),
Fec_Exig_T4   = case ex_Fec_Exig_T4 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T4, @w_ffecha_reporte) end,
Fec_Pago_T4   = case ex_Fec_Pago_T4 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T4, @w_ffecha_reporte) end,
Exig_T5       = convert(varchar, ex_Exig_T5),
Pago_T5       = convert(varchar, ex_Pago_T5),
Fec_Exig_T5   = case ex_Fec_Exig_T5 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T5, @w_ffecha_reporte) end,
Fec_Pago_T5   = case ex_Fec_Pago_T5 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T5, @w_ffecha_reporte) end,
Exig_T6       = convert(varchar, ex_Exig_T6),
Pago_T6       = convert(varchar, ex_Pago_T6),
Fec_Exig_T6   = case ex_Fec_Exig_T6 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T6, @w_ffecha_reporte) end,
Fec_Pago_T6   = case ex_Fec_Pago_T6 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T6, @w_ffecha_reporte) end,
Exig_T7       = convert(varchar, ex_Exig_T7),
Pago_T7       = convert(varchar, ex_Pago_T7),
Fec_Exig_T7   = case ex_Fec_Exig_T7 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T7, @w_ffecha_reporte) end,
Fec_Pago_T7   = case ex_Fec_Pago_T7 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T7, @w_ffecha_reporte) end,
Exig_T8       = convert(varchar, ex_Exig_T8),
Pago_T8       = convert(varchar, ex_Pago_T8),
Fec_Exig_T8   = case ex_Fec_Exig_T8 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T8, @w_ffecha_reporte) end,
Fec_Pago_T8   = case ex_Fec_Pago_T8 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T8, @w_ffecha_reporte) end,
Exig_T9       = convert(varchar, ex_Exig_T9),
Pago_T9       = convert(varchar, ex_Pago_T9),
Fec_Exig_T9   = case ex_Fec_Exig_T9 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T9, @w_ffecha_reporte) end,
Fec_Pago_T9   = case ex_Fec_Pago_T9 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T9, @w_ffecha_reporte) end,
Exig_T10      = convert(varchar, ex_Exig_T10),
Pago_T10      = convert(varchar, ex_Pago_T10),
Fec_Exig_T10  = case ex_Fec_Exig_T10 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T10, @w_ffecha_reporte) end,
Fec_Pago_T10  = case ex_Fec_Pago_T10 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T10, @w_ffecha_reporte) end,
Exig_T11      = convert(varchar, ex_Exig_T11),
Pago_T11      = convert(varchar, ex_Pago_T11),
Fec_Exig_T11  = case ex_Fec_Exig_T11 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T11, @w_ffecha_reporte) end,
Fec_Pago_T11  = case ex_Fec_Pago_T11 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T11, @w_ffecha_reporte) end,
Exig_T12      = convert(varchar, ex_Exig_T12),
Pago_T12      = convert(varchar, ex_Pago_T12),
Fec_Exig_T12  = case ex_Fec_Exig_T12 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T12, @w_ffecha_reporte) end,
Fec_Pago_T12  = case ex_Fec_Pago_T12 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T12, @w_ffecha_reporte) end,
Exig_T13      = convert(varchar, ex_Exig_T13),
Pago_T13      = convert(varchar, ex_Pago_T13),
Fec_Exig_T13  = case ex_Fec_Exig_T13 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T13, @w_ffecha_reporte) end,
Fec_Pago_T13  = case ex_Fec_Pago_T13 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T13, @w_ffecha_reporte) end,
Exig_T14      = convert(varchar, ex_Exig_T14),
Pago_T14      = convert(varchar, ex_Pago_T14),
Fec_Exig_T14  = case ex_Fec_Exig_T14 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T14, @w_ffecha_reporte) end,
Fec_Pago_T14  = case ex_Fec_Pago_T14 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T14, @w_ffecha_reporte) end,
Exig_T15      = convert(varchar, ex_Exig_T15),
Pago_T15      = convert(varchar, ex_Pago_T15),
Fec_Exig_T15  = case ex_Fec_Exig_T15 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T15, @w_ffecha_reporte) end,
Fec_Pago_T15  = case ex_Fec_Pago_T15 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T15, @w_ffecha_reporte) end,
Exig_T16      = convert(varchar, ex_Exig_T16),
Pago_T16      = convert(varchar, ex_Pago_T16),
Fec_Exig_T16  = case ex_Fec_Exig_T16 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T16, @w_ffecha_reporte) end,
Fec_Pago_T16  = case ex_Fec_Pago_T16 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T16, @w_ffecha_reporte) end,
Exig_T17      = convert(varchar, ex_Exig_T17),
Pago_T17      = convert(varchar, ex_Pago_T17),
Fec_Exig_T17  = case ex_Fec_Exig_T17 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T17, @w_ffecha_reporte) end,
Fec_Pago_T17  = case ex_Fec_Pago_T17 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T17, @w_ffecha_reporte) end,
Exig_T18      = convert(varchar, ex_Exig_T18),
Pago_T18      = convert(varchar, ex_Pago_T18),
Fec_Exig_T18  = case ex_Fec_Exig_T18 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T18, @w_ffecha_reporte) end,
Fec_Pago_T18  = case ex_Fec_Pago_T18 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T18, @w_ffecha_reporte) end,
Exig_T19      = convert(varchar, ex_Exig_T19),
Pago_T19      = convert(varchar, ex_Pago_T19),
Fec_Exig_T19  = case ex_Fec_Exig_T19 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T19, @w_ffecha_reporte) end,
Fec_Pago_T19  = case ex_Fec_Pago_T19 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T19, @w_ffecha_reporte) end,
Exig_T20      = convert(varchar, ex_Exig_T20),
Pago_T20      = convert(varchar, ex_Pago_T20),
Fec_Exig_T20  = case ex_Fec_Exig_T20 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T20, @w_ffecha_reporte) end,
Fec_Pago_T20  = case ex_Fec_Pago_T20 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T20, @w_ffecha_reporte) end,
Exig_T21      = convert(varchar, ex_Exig_T21),
Pago_T21      = convert(varchar, ex_Pago_T21),
Fec_Exig_T21  = case ex_Fec_Exig_T21 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T21, @w_ffecha_reporte) end,
Fec_Pago_T21  = case ex_Fec_Pago_T21 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T21, @w_ffecha_reporte) end,
Exig_T22      = convert(varchar, ex_Exig_T22),
Pago_T22      = convert(varchar, ex_Pago_T22),
Fec_Exig_T22  = case ex_Fec_Exig_T22 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T22, @w_ffecha_reporte) end,
Fec_Pago_T22  = case ex_Fec_Pago_T22 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T22, @w_ffecha_reporte) end,
Exig_T23      = convert(varchar, ex_Exig_T23),
Pago_T23      = convert(varchar, ex_Pago_T23),
Fec_Exig_T23  = case ex_Fec_Exig_T23 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T23, @w_ffecha_reporte) end,
Fec_Pago_T23  = case ex_Fec_Pago_T23 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T23, @w_ffecha_reporte) end,
Exig_T24      = convert(varchar, ex_Exig_T24),
Pago_T24      = convert(varchar, ex_Pago_T24),
Fec_Exig_T24  = case ex_Fec_Exig_T24 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Exig_T24, @w_ffecha_reporte) end,
Fec_Pago_T24  = case ex_Fec_Pago_T24 when '01/01/1900' then '00010101' else convert(varchar, ex_Fec_Pago_T24, @w_ffecha_reporte) end
from  #exigibles_h
where Num_cred = ex_Num_cred

if @@error != 0
begin
   print 'Error al consultar saldos exigibles'
   select
   @w_error = 724619,
   @w_mensaje = 'Error al consultar saldos exigibles'
   goto ERROR_PROCESO
end

--Folio Consulta Buro -- Sop.189747
update #sb_riesgo_provision 
set Folio_Consulta_Buro = ib_folio
from cob_credito..cr_interface_buro
where Num_cliente = ib_cliente
and   ib_estado  = 'V'
and   ib_folio is not null
and   Folio_Consulta_Buro is null  

INSERT INTO sb_riesgo_provision 
SELECT Num_cred, 
convert(varchar(20), isnull(Num_cliente,'')),
Num_grupo, Cod_producto, Cod_subproducto, Cod_periodo_capital, 
Cod_periodo_intereses, Exig_T1, Pago_T1, Fec_Exig_T1, 
Fec_Pago_T1, Exig_T2, Pago_T2, Fec_Exig_T2, Fec_Pago_T2, 
Exig_T3, Pago_T3, Fec_Exig_T3, Fec_Pago_T3, Exig_T4, 
Pago_T4, Fec_Exig_T4, Fec_Pago_T4, Exig_T5, Pago_T5,
Fec_Exig_T5, Fec_Pago_T5, Exig_T6, Pago_T6, Fec_Exig_T6,
Fec_Pago_T6, Exig_T7, Pago_T7, Fec_Exig_T7, Fec_Pago_T7,
Exig_T8, Pago_T8, Fec_Exig_T8, Fec_Pago_T8, Exig_T9, Pago_T9,
Fec_Exig_T9, Fec_Pago_T9, Exig_T10, Pago_T10, Fec_Exig_T10,
Fec_Pago_T10, Exig_T11, Pago_T11, Fec_Exig_T11, Fec_Pago_T11,
Exig_T12, Pago_T12, Fec_Exig_T12, Fec_Pago_T12, Exig_T13, Pago_T13,
Fec_Exig_T13, Fec_Pago_T13, Exig_T14, Pago_T14, Fec_Exig_T14,
Fec_Pago_T14, Exig_T15, Pago_T15, Fec_Exig_T15, Fec_Pago_T15,
Exig_T16, Pago_T16, Fec_Exig_T16, Fec_Pago_T16, Imp_total_riesgo,
Integrantes, Ciclos, Exig_T17, Pago_T17, Fec_Exig_T17, Fec_Pago_T17,
Exig_T18, Pago_T18, Fec_Exig_T18, Fec_Pago_T18, Exig_T19, Pago_T19,
Fec_Exig_T19, Fec_Pago_T19, Exig_T20, Pago_T20, Fec_Exig_T20,
Fec_Pago_T20, Exig_T21, Pago_T21, Fec_Exig_T21, Fec_Pago_T21,
Exig_T22, Pago_T22, Fec_Exig_T22, Fec_Pago_T22, Exig_T23, Pago_T23,
Fec_Exig_T23, Fec_Pago_T23, Exig_T24, Pago_T24, Fec_Exig_T24, Fec_Pago_T24,
Folio_Consulta_Buro
FROM #sb_riesgo_provision
ORDER BY Num_cred

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

   select @w_columna = c.name,
          @w_col_id  = c.colid
   from sysobjects o, syscolumns c
   where o.id    = c.id
   and   o.name  = 'sb_riesgo_provision'
   and   c.colid > @w_col_id
   order by c.colid

   if @@rowcount = 0 begin
      set rowcount 0
      break
   end

   set rowcount 0

   select @w_cont_columnas = @w_cont_columnas + 1

   select @w_nom_cabecera = @w_nom_cabecera + 'cabecera' 
   + case when len(@w_cont_columnas) <= 2 then right('00' + convert(varchar(2), @w_cont_columnas), 2)
          when len(@w_cont_columnas) >  2 then right('00' + convert(varchar(3), @w_cont_columnas), 3)
	 end
   + char(44)
   select @w_cabecera = @w_cabecera + char(39) + @w_columna + char(39) + char(44)
   select @w_nom_columnas = @w_nom_columnas +  @w_columna + char(44)
end


select @w_cabecera = substring(@w_cabecera, 1, len(@w_cabecera) - 1),
       @w_nom_cabecera = substring(@w_nom_cabecera, 1, len(@w_nom_cabecera) - 1),
       @w_nom_columnas = substring(@w_nom_columnas, 1, len(@w_nom_columnas) - 1)

SELECT @w_cabecera_tot = char(39)+'Imp_total_riesgo'+char(39)+','+char(39)+'Integrantes'+CHAR(39)+','+CHAR(39)+'Ciclos'+char(39)
SELECT @w_cabecera = replace( @w_cabecera, ','+@w_cabecera_tot,'')
SELECT @w_cabecera = @w_cabecera + ','+@w_cabecera_tot


SELECT @w_nom_columnas_tot = 'Imp_total_riesgo,Integrantes,Ciclos'
SELECT @w_nom_columnas = replace( @w_nom_columnas, ','+@w_nom_columnas_tot,'')
SELECT @w_nom_columnas = @w_nom_columnas + ','+@w_nom_columnas_tot


select  @w_sql = 'insert into cob_conta_super..sb_tmp_cabecera_provision '
select  @w_sql = @w_sql + '('
select  @w_sql = @w_sql + @w_nom_cabecera
select  @w_sql = @w_sql + ')'
select  @w_sql = @w_sql + ' values '
select  @w_sql = @w_sql + '('
select  @w_sql = @w_sql + @w_cabecera
select  @w_sql = @w_sql + ')'

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
select @w_sql = @w_sql + ' from cob_conta_super..sb_tmp_cabecera_provision '
select @w_sql = @w_sql + ' union all '
select @w_sql = @w_sql + 'select '
select @w_sql = @w_sql + @w_nom_columnas
select @w_sql = @w_sql + ' from cob_conta_super..sb_riesgo_provision '

select @w_comando = 'bcp "' + @w_sql + '" queryout "'
select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'+ ' -t"|" '

delete from @resultadobcp

insert into @resultadobcp
exec xp_cmdshell @w_comando

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
GO

