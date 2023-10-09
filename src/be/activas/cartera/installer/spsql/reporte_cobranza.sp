/****************************************************************************/
/*   Archivo:                 sp_reporte_cobranza.sp                        */ 
/*   Stored procedure:        sp_reporte_cobranza                           */
/*   Base de Datos:           cob_cartera                                   */
/*   Producto:                Cartera                                       */
/*   Disenado por:            AGO                                           */
/*   Fecha de Documentacion:  DIC 02 de 2019                                */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*   Este programa es parte de los paquetes bancario s propiedad de         */
/*   'MACOSA'.                                                              */
/*   Su uso no autorizado queda expresamente prohibido asi como             */
/*   cualquier autorizacion o agregado hecho por alguno de sus              */
/*   usuario sin el debido consentimiento por escrito de la                 */
/*   Presidencia Ejecutiva de MACOSA o su representante                     */
/****************************************************************************/
/*                         PROPOSITO                                        */
/*                     Reporte de Cobranza                                  */
/*	 Reporta Los pagos  grupales. Si hay un pago grupal                     */
/*   de  los 10 integrantes, se presenta en el reporte como un solo pago;   */
/*   si hay un pago LCR el pago es uno.Los campos del reporte se obtendran  */
/*   de las tablas vivas de Cartera (no del consolidador),                  */
/*   ya que es un reporte cada hora.                                        */
/***************************************************************************/
/*                     MODIFICACIONES                                       */
/* FECHA                AUTOR                DETALLE                        */
/* 28/04/2021          Wismark Castro      Ajuste inclusión de registros    */
/*                                         para pago financiado             */
/* 29/04/2021          Wismark Castro      Se actualiza campo Origen de pago*/
/*										   Req.#14799 - Nota #131           */
/****************************************************************************/

use cob_cartera 
go 

if exists(select 1 from sysobjects where name = 'sp_reporte_cobranza')
    drop proc sp_reporte_cobranza
go

create proc sp_reporte_cobranza  
(
    @i_fecha_desde           datetime   =   null ,
	@i_fecha_hasta           datetime   =   null ,
	@i_operacion             char                  --Parametro de operación 12/05/2021
)as

declare
  @w_sp_name        varchar(20),
  @w_s_app          varchar(50),
  @w_path           varchar(255),  
  @w_msg            varchar(200),  
  @w_return         int,
  @w_dia            varchar(2),
  @w_mes            varchar(2),
  @w_anio           varchar(4),
  @w_fecha_r        varchar(10),
  @w_file_rpt       varchar(40),
  @w_file_rpt_1     varchar(200),
  @w_file_rpt_1_out varchar(140),
  @w_bcp            varchar(2000),
  @w_error          int,
  @w_msg_error      varchar(255),
  @w_max_div		int,
  @w_max_div_his	int,
  @w_fecha_actual   datetime ,
  @t_show_version   int,
  @w_hora_anterior  datetime ,
  @w_fecha_desde    datetime,
  @w_fecha_hasta    datetime,
  @w_cmd            varchar(1000),
  @w_destino        varchar(1000),
  @w_comando        varchar(1000),
  @w_errores        varchar(1000),
  @w_horas          varchar(10)
  
select @w_sp_name = 'sp_reporte_cobranza'

--Versionamiento del Programa
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '1.0.0.0'
  return 0
end

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

--LECTURA DEL PARAMETRO ULTIMA HORA DE EJECUCION 
select @w_fecha_desde = pa_datetime 
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'UFRCO'

select @w_fecha_desde = isnull ( @w_fecha_desde, DATEADD(HH, -1, GETDATE()))

select 
@w_fecha_desde = isnull(@i_fecha_desde, @w_fecha_desde), 
@w_fecha_hasta = isnull(@i_fecha_hasta, getdate())

if(@i_operacion='I') begin

   print 'Operación I - Creación tabla - inicio'
   
   truncate table ca_reporte_cobranza_tmp
   select @w_max_div = 0, @w_max_div_his = 0
   
   -- -------------------------------------------------------------------------------
   -- DIRECCION DEL ARCHIVO A GENERAR
   -- -------------------------------------------------------------------------------
   
   
   --DETERMINAR UNIVERSO DE REGISTROS A REPORTAR 
   
   select 
   secuencial_id      = convert(int,co_secuencial),
   banco              = convert(varchar(24),null),
   grupal             = case co_tipo when 'PG' then 'S' else 'N'  end ,
   operacion          = co_codigo_interno,
   fecha_val          = co_fecha_valor, 
   fecha_real         = co_fecha_real,
   monto              = co_monto,
   reverso            = case co_accion when 'R' then 'SI' else 'NO' end,
   canal_id           = co_trn_id_corresp,
   origen_pago        = co_corresponsal,
   referencia         = co_referencia,
   pag_estado         = (case co_estado 
                             when 'A' then 'Anulado'
   						  when 'I' then 'Pendiente'
   						  when 'R' then 'Reversado'
   						  when 'E' then 'Error'
   						  when 'P' then 'Aplicado'
                             else  '' end )
   into #pagos
   from ca_corresponsal_trn
   where co_fecha_real  between @w_fecha_desde and @w_fecha_hasta
   and   co_tipo     <> 'GL'
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CREAR UNIVERSO DE OPERACIONES'
      goto ERROR_PROCESO
   end
   
   --CREAR TABLA DE DETALLE DE PAGOS CON SECUENCIALES ING 
   select 
   operacion      = cd_operacion,
   banco          = cd_banco,
   grupal         = grupal,
   secuencial_ing = cd_sec_ing ,
   secuencial_rpa = convert(int,0),
   secuencial_pag = convert(int,0),
   secuencial     = secuencial_id,
   refinanciado   = 'N'
   into #detalle_pagos
   from #pagos,ca_corresponsal_det
   where secuencial_id =cd_secuencial
   and reverso = 'NO'
   and pag_estado not in ( 'Anulado', 'Pendiente', 'Error')
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR REGISTROS DE DETALLES DE PAGOS'
      goto ERROR_PROCESO
   end
   
   -----------------------------------------------------------------------
   
   insert into #detalle_pagos
   select 
   operacion      = cd_operacion,
   banco          = cd_banco,
   grupal         = grupal,
   secuencial_ing = cd_sec_ing ,
   secuencial_rpa = convert(int,0),
   secuencial_pag = convert(int,0),
   secuencial     = secuencial_id,
   'N'
   from #pagos,ca_corresponsal_det
   where cd_secuencial =  convert(int, canal_id) 
   and reverso = 'SI'
   and pag_estado not in ( 'Anulado', 'Pendiente', 'Error')
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR REGISTROS DE DETALLES DE PAGOS'
      goto ERROR_PROCESO
   end
   
   -----------------------------------------------------------------------
   
   --ACTUALIZAMOS RPA Y PAG PARA OPERACIONES NO GRUPALES
   
   update #detalle_pagos set 
   secuencial_rpa     = abs(tr_secuencial)
   from ca_transaccion 
   where tr_operacion = operacion 
   and  tr_dias_calc  = secuencial_ing
   and tr_tran = 'RPA'
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR LOS SECUENCIALES RPA'
      goto ERROR_PROCESO
   end
   
   update #detalle_pagos set 
   secuencial_pag     = tr_secuencial
   from ca_transaccion 
   where tr_operacion      = operacion 
   and   tr_secuencial_ref  = secuencial_rpa
   and   tr_tran = 'PAG'
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR LOS SECUENCIALES PAG'
      goto ERROR_PROCESO
   end
   
   
   ----#pagos  y detalle llenas ------------------------------------
   
   insert  into #pagos 
   select 
   secuencial_id      = tr_secuencial,
   banco              = tr_banco,
   grupal             = 'S',
   operacion          = tr_operacion,
   fecha_val          = tr_fecha_ref, 
   fecha_real         = tr_fecha_real,
   monto              = 0,
   reverso            = case 
                           when tr_estado='RV' then 'SI'
                           when tr_secuencial<0   then 'SI' 
                           else 'NO' end,
   canal_id           = 0,   -- de donde se toma el valor de canal Santander
   origen_pago        = 'PAGO FINANCIADO',
   referencia         = '',
   pag_estado         = 'Aplicado'
   from  ca_transaccion 
   where tr_tran = 'PAG'
   and   tr_estado <> 'RV'
   and   tr_secuencial >0 
   and   tr_observacion = 'RENOVACION'
   and   tr_fecha_mov BETWEEN @w_fecha_desde and @w_fecha_hasta
   
   insert into #detalle_pagos
   select 
   operacion,
   banco ,
   grupal,
   ab_secuencial_ing ,
   ab_secuencial_rpa,
   ab_secuencial_pag,
   secuencial_id,
   'S'
   from  #pagos a  , ca_abono b
   where operacion = ab_operacion 
   and   secuencial_id  = ab_secuencial_pag
   and   origen_pago    = 'PAGO FINANCIADO' -- !
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR REGISTROS DE DETALLES DE PAGOS'
      goto ERROR_PROCESO
   end
   
   ----------------------------------------
   /*DETERMINAR LA CUOTA EXIGIBLE DE LOS PRESTAMOS */
   select 
   di_operacion  = di_operacion,
   di_secuencial = secuencial_pag,
   di_exigible   = max(di_dividendo),
   di_grupal     = grupal, 
   di_secuencial_corresp = secuencial
   into #exigible
   from ca_dividendo, #detalle_pagos
   where di_operacion = operacion
   and   di_fecha_ven <= @w_fecha_hasta
   group by di_operacion, secuencial_pag,grupal,secuencial
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL INSERTAR  LOS DIVIDENDOS EXIGIBLES MENORES A FECHA HASTA'
      goto ERROR_PROCESO
   end
   
   insert into  #exigible
   select 
   di_operacion   =operacion, 
   di_secuencial  =secuencial_pag, 
   di_exigible    =0,
   di_grupal      = grupal,
   di_secuencial_corresp  = secuencial 
   from ca_dividendo, #detalle_pagos
   where di_operacion = operacion 
   and   @w_fecha_hasta between di_fecha_ini  and di_fecha_ven
   and   operacion not in (select di_operacion from #exigible)
   group by operacion, secuencial_pag,grupal,secuencial
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL INSERTAR  LOS DIVIDENDOS EXIGIBLES MENORES A FECHA HASTA'
      goto ERROR_PROCESO
   end
   
   
   /* OBTENER EL DETALLE DE TODAS LAS TRANSACCIONES A REPORTAR */
   select
   dtr_operacion      = dtr_operacion,
   dtr_secuencial     = dtr_secuencial,
   dtr_concepto       = dtr_concepto,
   dtr_categoria      = convert(varchar(20), ''),
   dtr_concepto_asoc  = convert(varchar(20), ''), 
   dtr_categoria_asoc = convert(varchar(20), ''),
   dtr_dividendo      = dtr_dividendo,
   dtr_exigible       = 'S',
   dtr_monto          = sum(dtr_monto),
   dtr_grupal         = grupal,
   dtr_sec_id         = secuencial,
   dtr_ref            = refinanciado
   into #pagos_det
   from ca_det_trn, #detalle_pagos
   where dtr_operacion  = operacion 
   and   dtr_secuencial = secuencial_pag
   and   dtr_concepto <> 'VAC0'
   group by dtr_operacion, dtr_secuencial,dtr_dividendo, dtr_concepto,grupal,secuencial, refinanciado
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL INSERTAR DETALLE DE PAGOS PAGOS_DET'
      goto ERROR_PROCESO
   end
   
   
   /* MARCAR LOS VALORES NO EXIGIBLES */
   update #pagos_det set
   dtr_exigible = 'N'
   from #exigible
   where dtr_operacion = di_operacion
   and   dtr_dividendo > di_exigible
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR EXIGIBLE'
      goto ERROR_PROCESO
   end
   
   
   
   /* DETERMINAR LOS RUBROS ASOCIADOS DE LOS CONCEPTOS */
   update #pagos_det set
   dtr_concepto_asoc = ro_concepto_asociado
   from ca_rubro_op
   where ro_operacion = dtr_operacion
   and   ro_concepto  = dtr_concepto
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR RUBROS ASOCIADOS'
      goto ERROR_PROCESO
   end
   
   
   
   
   /* DETERMINAR CATEGORIA DEL RUBRO */
   update #pagos_det set
   dtr_categoria       = co_categoria
   from ca_concepto
   where dtr_concepto  = co_concepto
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR CATEGORIA DEL RUBRO'
      goto ERROR_PROCESO
   end
   
   
   
   /* DETERMINAR CATEGORIA DEL RUBRO ASOCIADO */
   update #pagos_det set
   dtr_categoria_asoc = co_categoria
   from ca_concepto
   where dtr_concepto_asoc  = co_concepto
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR CATEGORIA DEL RUBRO ASOCIADO'
      goto ERROR_PROCESO
   end
   
   select 
   dh_operacion   = max(dtr_operacion),
   dh_secuencial  = dtr_secuencial,
   dh_cap_ne      = sum(case when dtr_categoria = 'C' and dtr_exigible = 'N'       then dtr_monto else 0 end), 
   dh_cap_ex      = sum(case when dtr_categoria = 'C' and dtr_exigible = 'S'       then dtr_monto else 0 end), 
   dh_int         = sum(case when dtr_categoria = 'I'                              then dtr_monto else 0 end), 
   dh_iva_int     = sum(case when dtr_categoria = 'A' and dtr_categoria_asoc = 'I' then dtr_monto else 0 end), 
   dh_imo         = sum(case when dtr_categoria = 'M'                              then dtr_monto else 0 end), 
   dh_iva_imo     = sum(case when dtr_categoria = 'A' and dtr_categoria_asoc = 'M' then dtr_monto else 0 end), 
   dh_com         = sum(case when dtr_categoria = 'O'                              then dtr_monto else 0 end), 
   dh_iva_com     = sum(case when dtr_categoria = 'A' and dtr_categoria_asoc = 'O' then dtr_monto else 0 end),
   dh_sobrante    = sum(case when dtr_concepto  = 'SOBRANTE'                       then dtr_monto else 0 end),
   dh_div_min     = min(dtr_dividendo),
   dh_grupal      = dtr_grupal,
   dh_sec_id      = dtr_sec_id -----el identity del coreesponsal
   into #pagos_det_h
   from #pagos_det
   where dtr_ref = 'N'
   group by  dtr_grupal,dtr_sec_id,dtr_secuencial
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL INSERTAR REGISTROS HORIZONTALES DE DETALLE DE TRANSACCIONES'
      goto ERROR_PROCESO
   end
   
   ---------------------------------------------------------------------------------------------------------------
   
   insert into #pagos_det_h
   select 
   dh_operacion   = dtr_operacion,
   dh_secuencial  = dtr_secuencial,
   dh_cap_ne      = sum(case when dtr_categoria = 'C' and dtr_exigible = 'N'       then dtr_monto else 0 end), 
   dh_cap_ex      = sum(case when dtr_categoria = 'C' and dtr_exigible = 'S'       then dtr_monto else 0 end), 
   dh_int         = sum(case when dtr_categoria = 'I'                              then dtr_monto else 0 end), 
   dh_iva_int     = sum(case when dtr_categoria = 'A' and dtr_categoria_asoc = 'I' then dtr_monto else 0 end), 
   dh_imo         = sum(case when dtr_categoria = 'M'                              then dtr_monto else 0 end), 
   dh_iva_imo     = sum(case when dtr_categoria = 'A' and dtr_categoria_asoc = 'M' then dtr_monto else 0 end), 
   dh_com         = sum(case when dtr_categoria = 'O'                              then dtr_monto else 0 end), 
   dh_iva_com     = sum(case when dtr_categoria = 'A' and dtr_categoria_asoc = 'O' then dtr_monto else 0 end),
   dh_sobrante    = sum(case when dtr_concepto  = 'SOBRANTE'                       then dtr_monto else 0 end),
   dh_div_min     = min(dtr_dividendo),
   dh_grupal      = dtr_grupal,
   dh_sec_id      = dtr_sec_id -----el identity del coreesponsal
   from #pagos_det
   where dtr_ref = 'S'
   group by  dtr_operacion,dtr_grupal,dtr_sec_id,dtr_secuencial
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL INSERTAR REGISTROS HORIZONTALES DE DETALLE DE TRANSACCIONES'
      goto ERROR_PROCESO
   end
   
   ---------------------------------------------------------------------------------------------------------------
   
   --LLENADO DE TABlA DE TRABAJO 
   select
   contrato           = convert(varchar(64), ''),            -- 1 CONTRATO             
   cliente_id         = convert(int,0),                       --2 ID CLIENTE                   
   grupo_id           = convert(int,0),                       --3 ID GRUPO 
   nombre             = convert(varchar(64), ''),             --4 NOMBRE GRUPO 
   operacion          = operacion, 
   secuencial_pag     = dh_secuencial,   
   fecha_trn          = convert(datetime, NULL),              -- 5	FECHA TRANSACCION  (REAL) 
   canal_id           = convert(int,0),                       -- 6 ID de Canal de Pago    --PENDIENTE                 
   fecha_valor        = convert(datetime, NULL),              -- 7	FECHA VALOR                         
   nro_cuota_pagada   = dh_div_min,                           -- 8	NRO CUOTA ABONADA
   fecha_cuota_pagada = convert(datetime, NULL),              -- 9	FECHA DE LA CUOTA
   importe_tot        = dh_cap_ne + dh_cap_ex  + 
                        dh_int    + dh_iva_int + 
   					 dh_imo    + dh_iva_imo + 
   					 dh_com    + dh_iva_com,              --10	IMPORTE PAGO TOTAL (PAGADO)
   eventos_pago       = convert(int,0),                      --11 EVENTOS DE PAGO 
   importe_cap        = dh_cap_ne + dh_cap_ex ,              --12	IMPORTE PAGADO CAP
   importe_int        = dh_int,                              --13	IMPORTE PAGADO INT.                          
   importe_iva_int    = dh_iva_int,                          --14	IMPORTE PAGADO IVA_INT
   importe_imo        = dh_imo,                              --15	IMPORTE PAGADO IMO
   importe_iva_imo    = dh_iva_imo,                          --16	IMPORTE PAGADO IVA_IMO                    
   importe_com        = dh_com,                              --17  IMPORTE PAGADO COM
   importe_iva_com    = dh_iva_com,                          --18  IMPORTE PAGADO IVA_COM
   importe_sob        = dh_sobrante,                         --19  SOBRANTE
   saldo_cap_desp     = -1*(dh_cap_ne + dh_cap_ex),          --20	SALDO CAPITAL DESPUES DEL PAGO
   saldo_cap_ex_desp  = -1*(dh_cap_ex),                      --21	SALDO EXIGIBLE CAPITAL DESPUES DEL PAGO
   trn_id             = secuencial,                          --22	ID DE LA TRANSACCIÃƒâ€œN
   tipo_pago          = convert(varchar(15), 'NORMAL'),      --23	TIPO DE PAGO
   reverso            = convert(varchar(24),''),             --24	REVERSO
   origen_pago        = case 
   						when refinanciado = 'S' then 'PAGO FINANCIADO'
   						else convert(varchar(64), '') 
   					 end,                                 --25	ORIGEN DE PAGO          
   referencia         = convert(varchar(24), ''),            --26 REFERENCIA
   pag_estado         = convert(varchar(24),''),             --27 ESTATUS DEL PAGO  
   grupal             = dh_grupal
   into #reporte_pagos
   from #detalle_pagos, #pagos_det_h
   where operacion      = dh_operacion
   and   dh_sec_id      = secuencial
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CREAR TABLA DE REPORTES DE PAGO'
      goto ERROR_PROCESO
   end
   
   
   --ACTUALIZO EL BANCO DE LA OPERACION 
   update #pagos set
   banco          = op_banco 
   from ca_operacion 
   where operacion = op_operacion 
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR EL CONTRATO DE LA OPERACION'
      goto ERROR_PROCESO
   end
   
   
   --cuota de sobrante
   select
   so_operacion 		= operacion,
   so_cuota			= convert(money,0),
   so_dividendo		= convert(int,0),
   so_secuencial_corresp = secuencial,
   so_fecha_ven       = convert(datetime, null) 
   into #sobrante
   from ca_det_trn,#detalle_pagos
   where dtr_operacion	= operacion
   and dtr_concepto 	=  'SOBRANTE'
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CREAR TABLA DE SOBRANTES'
      goto ERROR_PROCESO
   end
   
   
   
   select 
   operacion = di_operacion,
   min_div   = min(di_dividendo)
   into #min_div 
   from ca_dividendo,#sobrante
   where di_operacion = so_operacion 
   and di_fecha_can  between convert(datetime,convert(varchar(10),@w_fecha_desde,101),101) and convert(datetime,convert(varchar(10),@w_fecha_hasta,101),101)
   group by di_operacion
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CREAR TABLA DE MINIMOS DIVIDENDOS DEL SOBRANTE '
      goto ERROR_PROCESO
   end
   
   
   update #sobrante set 
   so_dividendo = min_div,
   so_fecha_ven = di_fecha_ven
   from ca_dividendo, #min_div 
   where di_operacion = operacion
   and di_fecha_can between convert(datetime,convert(varchar(10),@w_fecha_desde,101),101) and convert(datetime,convert(varchar(10),@w_fecha_hasta,101),101)
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CREAR ACTUALIZAR DE MINIMOS DIVIDENDOS DEL SOBRANTE '
      goto ERROR_PROCESO
   end
   
   
   
   update #reporte_pagos set 
   nro_cuota_pagada   = so_dividendo,
   fecha_cuota_pagada = so_fecha_ven
   from #sobrante
   where so_secuencial_corresp = trn_id
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CREAR ACTUALIZAR NRO DE CUOTA DE PAGADA'
      goto ERROR_PROCESO
   end
   
   
   --ACTUALIZAMOS EL RESTO DE REGISTROS QUE NO TIENEN DETALLE ( PENDIENTES, ANULADOS, ERROR) 
   -----------------------------------------------------------------------------------------
   
   insert into #reporte_pagos
   select 
   contrato           = convert(varchar(64), ''),             -- 1 CONTRATO             
   cliente_id         = convert(int,0),                       --*2 ID CLIENTE                   
   grupo_id           = convert(int,0),                       --*3 ID GRUPO 
   nombre             = convert(varchar(64), ''),             --*4 NOMBRE GRUPO 
   operacion          = operacion, 
   secuencial_pag     =  0,   
   fecha_trn          = convert(datetime, NULL),              -- 5	FECHA TRANSACCION  (REAL) 
   canal_id           = canal_id,                             -- *6 ID de Canal de Pago    --PENDIENTE                 
   fecha_valor        = convert(datetime, NULL),              -- 7	FECHA VALOR                         
   nro_cuota_pagada   = 0,                                    -- 8	NRO CUOTA ABONADA
   fecha_cuota_pagada = convert(datetime, NULL),              -- *9	FECHA DE LA CUOTA
   importe_tot        = monto,                                --10	IMPORTE PAGO TOTAL (PAGADO)
   eventos_pago       = convert(int,0),                       -- *11 EVENTOS DE PAGO 
   importe_cap        = 0,                                    --12	IMPORTE PAGADO CAP
   importe_int        = 0,                                    --13	IMPORTE PAGADO INT.                          
   importe_iva_int    = 0,                                    --14	IMPORTE PAGADO IVA_INT
   importe_imo        = 0,                                     --15	IMPORTE PAGADO IMO
   importe_iva_imo    = 0,                                    --16	IMPORTE PAGADO IVA_IMO                    
   importe_com        = 0,                                    --17  IMPORTE PAGADO COM
   importe_iva_com    = 0,                                    --18  IMPORTE PAGADO IVA_COM
   importe_sob        = 0,                                    --19  SOBRANTE
   saldo_cap_desp     = 0,                                    --20	SALDO CAPITAL DESPUES DEL PAGO
   saldo_cap_ex_desp  = 0,                                    --21	SALDO EXIGIBLE CAPITAL DESPUES DEL PAGO
   trn_id             = secuencial_id,                        --22	ID DE LA TRANSACCIÓN
   tipo_pago          = convert(varchar(15), 'NORMAL'),       --*23	TIPO DE PAGO
   reverso            = convert(varchar(24),''),                             --24	REVERSO
   origen_pago        = convert(varchar(64), ''),             --*25	ORIGEN DE PAGO          
   referencia         = referencia,            --*26 REFERENCIA
   pag_estado         = pag_estado ,
   grupal             = grupal           --*27 ESTATUS DEL PAGO  
   from #pagos
   where pag_estado in ( 'Anulado', 'Pendiente', 'Error')
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CREAR TABLA DE REPORTES DE PAGO'
      goto ERROR_PROCESO
   end
   
   
   update #reporte_pagos set 
   grupo_id = ci_grupo
   from ca_ciclo ,#reporte_pagos 
   where ci_operacion = operacion 
   and grupal = 'S'
   and pag_estado in ( 'Anulado', 'Pendiente', 'Error')
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR ID DE GRUPOS'
      goto ERROR_PROCESO
   end
   
   
   
   update #reporte_pagos set 
   nombre = gr_nombre
   from cobis..cl_grupo
   where gr_grupo = grupo_id
   and grupal = 'S'
   and pag_estado in ( 'Anulado', 'Pendiente', 'Error')
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR ID DE GRUPOS'
      goto ERROR_PROCESO
   end
   
   
   --DATOS DEL CLIENTE 
   update #reporte_pagos set 
   cliente_id = op_cliente
   from cob_cartera..ca_operacion
   where op_operacion = operacion
   and grupal = 'N'
   and pag_estado in ( 'Anulado', 'Pendiente', 'Error')
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR ID DE GRUPOS'
      goto ERROR_PROCESO
   end
   
   
   ---------------------------------------------------------------
   
   update #reporte_pagos set 
   contrato    = a.banco,
   fecha_trn   = a.fecha_real,
   canal_id    = a.canal_id,
   fecha_valor = a.fecha_val,
   reverso     = a.reverso,
   origen_pago = a.origen_pago,
   referencia  = a.referencia,
   pag_estado  = a.pag_estado
   from #pagos a
   where secuencial_id = trn_id
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR TABLA DE REPORTE DE PAGOS CAMPOS VARIOS'
      goto ERROR_PROCESO
   end
   
   
   
   /* DETERMINAR SALDO DE CAPITAL ANTES DEL PAGO TABLAS HIS  */
   select 
   his_operacion = max(amh_operacion),
   his_secuencial= amh_secuencial,
   his_cap_ne    = sum(case when amh_dividendo > di_exigible then amh_cuota - amh_pagado else 0 end),
   his_cap_ex    = sum(case when amh_dividendo <=di_exigible then amh_cuota - amh_pagado else 0 end),
   his_grupal      = di_grupal ,
   his_secuencial_corresp  = di_secuencial_corresp
   into #saldo_his
   from ca_amortizacion_his, #exigible
   where amh_operacion  = di_operacion
   and   amh_secuencial = di_secuencial
   and   amh_concepto   = 'CAP'
   group by di_grupal,amh_secuencial,di_secuencial_corresp
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CREAR TABLA CON VALORES HISTORICOS'
      goto ERROR_PROCESO
   end
   
   
   
   /* DETERMINAR SALDO DE CAPITAL ANTES DEL PAGO TABLAS HIS */
   insert into #saldo_his
   select 
   his_operacion = max(amh_operacion),
   his_secuencial= amh_secuencial,
   his_cap_ne    = sum(case when amh_dividendo > di_exigible then amh_cuota - amh_pagado else 0 end),
   his_cap_ex    = sum(case when amh_dividendo <=di_exigible then amh_cuota - amh_pagado else 0 end),
   his_grupal    = di_grupal ,
   his_secuencial_corresp = di_secuencial_corresp
   from cob_cartera_his..ca_amortizacion_his, #exigible
   where amh_operacion  = di_operacion
   and   amh_secuencial = di_secuencial
   and   amh_concepto   = 'CAP'
   group by di_grupal,amh_secuencial,di_secuencial_corresp
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CREAR TABLA CON VALORES HISTORICOS'
      goto ERROR_PROCESO
   end
   
   
   --SALDO CAPITAL DESPUES DEL PAGO 
   --SALDO CAP EX DESPUES DEL PAGO 
   
   update #reporte_pagos set
   saldo_cap_desp     = saldo_cap_desp      + his_cap_ex + his_cap_ne,
   saldo_cap_ex_desp  = saldo_cap_ex_desp   + his_cap_ex 
   from #saldo_his
   where his_operacion  = operacion
   and   his_secuencial = secuencial_pag
   and   his_secuencial_corresp = trn_id
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR TABLA CON VALORES HISTORICOS'
      goto ERROR_PROCESO
   end
   
   
   
   --NOMBRE DEL GRUPO
   select
   gr_operacion         = operacion,
   gr_grupo_id          = convert(int,0),
   gr_grupo_nom         = convert(varchar(64), '')
   into #grupo
   from #reporte_pagos
   where pag_estado not in ( 'Anulado', 'Pendiente', 'Error')
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CARGAR REGISTRO DE GRUPOS'
      goto ERROR_PROCESO
   end
   
   
   
   
   update #grupo set 
   gr_grupo_id = dc_grupo
   from ca_det_ciclo
   where dc_operacion = gr_operacion
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR ID DE GRUPOS'
      goto ERROR_PROCESO
   end
   
   
   
   update #grupo set 
   gr_grupo_nom = gr_nombre
   from cobis..cl_grupo
   where gr_grupo = gr_grupo_id
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR REGISTROS DE GRUPOS'
      goto ERROR_PROCESO
   end
   
   
   update #reporte_pagos set 
   grupo_id = gr_grupo_id,
   nombre   = gr_grupo_nom
   from #grupo
   where gr_operacion = operacion
   and grupal = 'S'
   and pag_estado not in ( 'Anulado', 'Pendiente', 'Error')
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR REGISTROS DE OPERACIONES'
      goto ERROR_PROCESO
   end
   
   
   
   --DATOS DEL CLIENTE 
   update #reporte_pagos set 
   cliente_id = op_cliente
   from cob_cartera..ca_operacion
   where op_operacion = operacion
   and grupal = 'N'
   and pag_estado not in ( 'Anulado', 'Pendiente', 'Error')
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR DATOS DEL CLIENTE'
      goto ERROR_PROCESO
   end
   
   
   
   
   --FECHA CUOTA PAGADA
   update #reporte_pagos set 
   fecha_cuota_pagada = di_fecha_ven
   from ca_dividendo
   where di_operacion = operacion
   and di_dividendo = nro_cuota_pagada
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR REGISTROS DE DIA DE PAGO'
      goto ERROR_PROCESO
   end
   
   
   
   --EVENTOS DE PAGOS 
   
   select 
   oper      = dtr_operacion ,
   sec_id    = dtr_sec_id,              ---secuencial del corresponsal
   eventos   =  (count(distinct(dtr_dividendo)))
   into #eventos 
   from #pagos_det 
   group by dtr_sec_id,dtr_operacion
   
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CREAR REGISTROS DE EVENTOS'
      goto ERROR_PROCESO
   end
   
   
   
   select 
   sec_id  = sec_id,
   eventos = isnull(sum(eventos),0) 
   into #total_eventos 
   from #eventos
   group by sec_id
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CREAR REGISTROS DE EVENTOS'
      goto ERROR_PROCESO
   end
   
   
   
   update #reporte_pagos set 
   eventos_pago = eventos
   from #pagos_det , #total_eventos
   where trn_id = sec_id  
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR REGISTROS DE EVENTO DE PAGO'
      goto ERROR_PROCESO
   end
   
   --ORIGEN DE PAGO
   
   select
   or_operacion         = operacion,
   or_secuencial_rpa    = secuencial_rpa,  
   or_secuencial        = secuencial_pag,  
   or_origen            = convert(varchar(64), ''),
   or_descripcion       = convert(varchar(64), ''),
   or_tipo_reduccion    = convert(varchar(2), 'N'),
   or_tipo_pago         = convert(varchar(64), 'NORMAL')
   into #origen_pago
   from #detalle_pagos
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CREAR REGISTROS DE ORIGENES DE PAGO'
      goto ERROR_PROCESO
   end
   
   
   update  #origen_pago  set 
   or_origen         = abd_concepto,
   or_tipo_reduccion = ab_tipo_reduccion
   from cob_cartera..ca_abono, cob_cartera..ca_abono_det
   where ab_operacion    = abd_operacion 
   and or_operacion      = ab_operacion
   and ab_secuencial_rpa = or_secuencial_rpa
   and abd_concepto     != 'SOBRANTE'
   and ab_secuencial_ing = abd_secuencial_ing
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR REGISTROS DE ORIGENES DE PAGO'
      goto ERROR_PROCESO
   end
   
   
   update #origen_pago set
   or_tipo_pago = case 
      when or_tipo_reduccion = 'T'  and  or_origen <> 'GAR_DEB'    then convert(varchar(15), 'R. TIEMPO')
      when or_tipo_reduccion = 'T'  and  or_origen = 'GAR_DEB'     then convert(varchar(15), 'GARANTIA')
      when or_tipo_reduccion = 'C'                                 then convert(varchar(15), 'R. CUOTA')
      when or_tipo_reduccion = 'N'                                 then convert(varchar(15), 'NORMAL')
      end
      
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR REGISTROS DE TIPO DE PAGO'
      goto ERROR_PROCESO
   end
   
   
   update #origen_pago set 
   or_descripcion = cp_descripcion
   from ca_producto
   where cp_producto = or_origen
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR REGISTROS DE DESCRIPCION DE PAGO'
      goto ERROR_PROCESO
   end
   
   
   --TIPO DE PAGO
   update #reporte_pagos set 
   tipo_pago   = or_tipo_pago    --MTA
   from #origen_pago
   where or_operacion  = operacion
   and   or_secuencial = trn_id
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CREAR REGISTRO DE TIPO DE PAGO'
      goto ERROR_PROCESO
   end
   
   
   --P. Cancelacion
   select
   pc_operacion 		= operacion,
   pc_estado		 	= convert(int, 0),
   pc_tipo_pago 		= tipo_pago
   into #pcancelacion
   from #reporte_pagos
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CARGAR REGISTRO PARA OBTENER P. CANCELACION'
      goto ERROR_PROCESO
   end
   
   update #pcancelacion set 
   pc_estado = op_estado
   from ca_operacion
   where op_operacion = pc_operacion
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL OBTENER ESTADO'
      goto ERROR_PROCESO
   end
   
   update #reporte_pagos set 
   tipo_pago = convert(varchar(15), 'P. CANCELACION')
   from #pcancelacion
   where pc_operacion = operacion
   and pc_estado = 3
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL ACTUALIZAR REGISTROS DE TIPO P.CANCELACION'
      goto ERROR_PROCESO
   end
   
   
   update #reporte_pagos  set 
   contrato = op_banco 
   from ca_operacion ,#reporte_pagos
   where operacion = op_operacion 
   and  origen_pago = 'PAGO FINANCIADO'   -- !
   
   select 
   contrato           = contrato,
   cliente_id         = cliente_id,
   grupo_id           = grupo_id,
   nombre             = nombre,
   fecha_trn          = fecha_trn,
   fecha_cuota_pagada = fecha_cuota_pagada,
   importe_tot        = sum(importe_tot),
   eventos_pago       = eventos_pago,
   importe_cap        = sum(importe_cap),
   importe_int        = sum(importe_int),
   importe_iva_int    = sum(importe_iva_int),
   importe_imo        = sum(importe_imo) , 
   importe_iva_imo    = sum(importe_iva_imo), 
   importe_com        = sum(importe_com),    
   importe_iva_com    = sum(importe_iva_com), 
   importe_sob        = sum(importe_sob),     
   saldo_cap_desp     = sum(saldo_cap_desp),
   saldo_cap_ex_desp  = sum(saldo_cap_ex_desp),
   trn_id             = trn_id,
   tipo_pago          = tipo_pago,
   reverso            = reverso,
   origen_pago        = origen_pago,
   referencia         = referencia,
   pag_estado         = pag_estado,
   canal_id           = canal_id,
   fecha_valor        = fecha_valor, 
   nro_cuota_pagada   = nro_cuota_pagada
   into #reporte_pagos1 
   from #reporte_pagos  
   --where origen_pago  <> 'PAGO FINANCIADO'
   group by contrato  ,cliente_id      ,grupo_id,
   nombre    ,nro_cuota_pagada,fecha_cuota_pagada,
   trn_id    ,tipo_pago,reverso,origen_pago,referencia,
   pag_estado,fecha_trn,canal_id,fecha_valor,eventos_pago
   
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL CREAR TABLA AGRUPADA DE REPORTE DE PAGO'
      goto ERROR_PROCESO
   end




   insert into ca_reporte_cobranza_tmp(         
   
   rc_contrato             ,rc_cliente_id                   ,rc_grupo_id,           
   rc_grupo                ,rc_fecha_trn                        ,rc_canal_id,         
   rc_fecha_valor          ,rc_cuota_abonada                ,rc_fecha_cuota_pagada,
   rc_importe_tot          ,rc_eventos_pago                 ,rc_importe_cap, 
   rc_importe_int          ,rc_importe_iva_int              ,rc_importe_imo,
   rc_importe_iva_imo      ,rc_importe_com                  ,rc_importe_iva_com,
   rc_importe_sob          ,rc_saldo_cap_desp               ,rc_saldo_cap_ex_desp,
   rc_trn_id               ,rc_tipo_pago                    ,rc_reverso,
   rc_origen_pago          ,rc_referencia                   ,rc_pag_estado )
   select 
   'CONTRATO'              ,'ID CLIENTE'                    ,'ID GRUPO'                               ,
   'NOMBRE_GRUPO'          ,'FECHA DE TRANSACCION'          ,'ID de Canal de Pago'                    ,
   'FECHA VALOR'           ,'NRO CUOTA ABONADA'             ,'FECHA DE LA CUOTA'                      ,
   'IMPORTE PAGO TOTAL'    ,'EVENTOS DE PAGO'               ,'IMPORTE PAGADO CAP'                     ,
   'IMPORTE PAGADO INT.'   ,'IMPORTE PAGADO IVA_INT'        ,'IMPORTE PAGADO IMO'                     ,
   'IMPORTE PAGADO IVA_IMO','IMPORTE PAGADO COM'            ,'IMPORTE PAGADO IVA_COM'                 ,
   'SOBRANTE'              ,'SALDO CAPITAL DESPUES DEL PAGO','SALDO EXIGIBLE CAPITAL DESPUES DEL PAGO',
   'ID DE LA TRANSACCION'  ,'TIPO DE PAGO'                  ,'REVERSO'                                ,
   'ORIGEN DE PAGO'        ,'REFERENCIA'                    ,'ESTATUS DEL PAGO'                       
   
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL INSERTAR CABECERA'
      goto ERROR_PROCESO
   end
   
   --carga tabla definitiva
   insert into ca_reporte_cobranza_tmp(
   rc_contrato                ,rc_cliente_id              ,rc_grupo_id,           
   rc_grupo                   ,rc_fecha_trn              ,rc_canal_id ,               
   rc_fecha_valor             ,rc_cuota_abonada           ,rc_fecha_cuota_pagada,
   rc_importe_tot             ,rc_eventos_pago            ,rc_importe_cap, 
   rc_importe_int             ,rc_importe_iva_int         ,rc_importe_imo,
   rc_importe_iva_imo         ,rc_importe_com             ,rc_importe_iva_com,
   rc_importe_sob             ,rc_saldo_cap_desp          ,rc_saldo_cap_ex_desp,
   rc_trn_id                  ,rc_tipo_pago               ,rc_reverso,
   rc_origen_pago             ,rc_referencia              ,rc_pag_estado )
   													   
   select 
   isnull(contrato       ,'')  ,isnull(cliente_id     ,'')                     ,isnull(grupo_id,''),          
   isnull(nombre          ,'')  ,isnull(convert(varchar(35),fecha_trn,100),'')  ,isnull(canal_id       ,'') ,       
   isnull(fecha_valor    ,'')  ,isnull(nro_cuota_pagada  ,'')                  ,isnull(convert(varchar(10),fecha_cuota_pagada,103),''),
   isnull(importe_tot    ,'')  ,isnull(eventos_pago   ,'')  ,isnull(importe_cap      ,''),
   isnull(importe_int    ,'')  ,isnull(importe_iva_int,'')  ,isnull(importe_imo      ,''),
   isnull(importe_iva_imo,'')  ,isnull(importe_com    ,'')  ,isnull(importe_iva_com  ,''),
   isnull(importe_sob    ,'')  ,isnull(saldo_cap_desp ,'')  ,isnull(saldo_cap_ex_desp,''),
   isnull(trn_id         ,'')  ,isnull(tipo_pago      ,'')  ,isnull(reverso          ,''),
   isnull(origen_pago    ,'')  ,isnull(referencia     ,'')  ,isnull(pag_estado       ,'')
   from #reporte_pagos1
   
   
   
   
   if @@error != 0 begin
      select 
      @w_error = 9999,
      @w_msg_error = 'ERROR AL INSERTAR REGISTRO EN TABLA FINAL CA_REPORTE_COBRANZA_TMP'
      goto ERROR_PROCESO
   end
   
   -------SE ACTUALIZA YA QUE EL CLIENTE CANCELO EL CREDITO EN LA MODALIDAD DE RENOVACION (SALDO CAPITAL = 0 )
   update ca_reporte_cobranza_tmp set 
   rc_saldo_cap_desp = 0,
   rc_saldo_cap_ex_desp = 0
   where rc_origen_pago = 'PAGO FINANCIADO'
   
   ----Se actualiza campo Origen de pago Req.#14799 - Nota #131
   update ca_reporte_cobranza_tmp set 
   rc_origen_pago = 'BANCO SANTANDER'
   where rc_origen_pago = 'PAGO FINANCIADO'
  
   print 'Operación I - Creación tabla - FIN'
end

if (@i_operacion ='F') begin
    
	print 'Operación F - Generación reporte  - Inicio'
   --GENERACION DEL REPORTE 
   --FORMATO DE HORAS 
   select 
   @w_mes   = substring(convert(varchar,@w_fecha_hasta, 101),1,2),
   @w_dia   = substring(convert(varchar,@w_fecha_hasta, 101),4,2),
   @w_anio  = substring(convert(varchar,@w_fecha_hasta, 101),9,2),
   @w_horas = substring(replace(convert(varchar, getdate(),  108), ':', '') ,1,2)
   
   
   --DATOS DEL ARCHIVO
   select 
   @w_file_rpt =  ba_arch_resultado,
   @w_path     =  ba_path_destino,
   @w_fecha_r  =  @w_dia + @w_mes + @w_anio +'_'+@w_horas
   from cobis..ba_batch 
   where ba_batch = 287932
   
   --ARMADA DEL NOMBRE DEL REPORTE 
   select 
   @w_file_rpt       = isnull(@w_file_rpt, 'MC_COBRANZA_'),
   @w_file_rpt_1     = @w_path + @w_file_rpt + @w_fecha_r + '_' +'N'+'.txt',
   @w_file_rpt_1_out = @w_path + @w_file_rpt + @w_fecha_r + '_' +'N'+'.err'
   
   
   select @w_cmd     = @w_s_app + 's_app bcp -auto -login cob_cartera..ca_reporte_cobranza_tmp out '
   
   
   select @w_comando = @w_cmd  +  @w_file_rpt_1  + ' -b5000 -c -T -e ' + @w_file_rpt_1_out+ ' -t"\t" ' + '-config ' + @w_s_app + 's_app.ini'
   
   
   exec @w_error = xp_cmdshell @w_comando
   
   if @w_error <> 0 begin
     select 
     @w_return = 70146,
     @w_msg    = 'Fallo el BCP'
     goto ERROR_PROCESO
   end
   
   --ACTUALIZO CON LA ULTIMA HORA EN LA QUE SE EJECUTO LA CONSULTA 
   if @i_fecha_desde is null begin
   
      update cobis..cl_parametro set 
      pa_datetime = @w_fecha_hasta
      where  pa_producto = 'CCA'
      and    pa_nemonico = 'UFRCO'
   
   end 
   
   print 'Operación F - Generación reporte  - FIN'
   
end


--ERROR GENERAL DEL PROCESO 
return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_msg, 'ERROR GENERAL DEL PROCESO')
	 
     exec cob_cartera..sp_errorlog
     @i_fecha     	  = @w_fecha_hasta,
	 @i_error         = @w_error,
	 @i_usuario       = 'usrbatch',
	 @i_tran          = 26004,
	 @i_tran_name     = null,
	 @i_rollback      = 'S'

     return @w_error

GO



