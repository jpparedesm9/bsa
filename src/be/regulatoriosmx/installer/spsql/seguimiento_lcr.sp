
/*************************************************************************/  
/*   Archivo:              seguimiento_lcr.sp		                     */
/*   Stored procedure:     sp_seguimiento_lcr       					 */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Fecha de escritura:   Septiembre 2019                               */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   Genera reporte regulatorio seguimienti LCR que es llamado desde	 */
/*   banxico desde la sarta 22                 							 */
/*                                                                       */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    17/Septiembre/2019      									   		 */
/*    07/noviembre/2019     JCH  	optimizacion de caso 122487 a 129694 */
/*	  23/Abril/2021			DGC		Caso 154324							 */	
/*    01/noviembre/2021     DCU     Caso 169559                          */
/*    04/noviembre/2021     DCU     Caso: 169559 Ajuste reporte banxico  */
/*	  13/enero/2022   	    JEOM    Caso #172727                         */
/*************************************************************************/

USE cob_conta_super
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select 1 from sysobjects where name = 'sp_seguimiento_lcr')
   drop proc sp_seguimiento_lcr
go

create proc sp_seguimiento_lcr 
(
@i_ruta_arch 		   varchar(255)   ,
@i_fecha_inicio        datetime = null,--'7/01/2019 12:00:00 AM ' 
@i_fecha_fin           datetime = null,--'8/30/2019 12:00:00 AM '
@i_fecha_corte		   datetime = null,
@i_fecha_fin_bmp	   datetime = null--fecha fin de bimestre habil
)
as
declare
	@w_return			int			 ,
	@w_error			int			 ,	
	@w_reporte          varchar(24)  ,
	@w_mensaje          varchar(150) ,
	@w_sql				varchar(5000),
	@w_sql_bcp		  	varchar(5000),
	@w_sp_name          varchar(64)  ,
	@w_msg              varchar(255) ,
	@w_fecha_proceso	datetime	 ,
	@w_reporte_lcr   	varchar(30)  ,
	@w_fecha_inicio    	datetime  	 ,
    @w_fecha_fin       	datetime  	 , 
    @w_fecha_fin_bmp   	datetime  	 ,--inicio del mes menos un dia y dia habil del mes
    @w_dias_bimestre   	int       	 ,
    @w_num_dec         	int       	 ,
	@w_fecha_bmp1       datetime     ,
	--Estados de cartera ---
	@w_est_vigente           tinyint,
	@w_est_novigente         tinyint,
	@w_est_vencido           tinyint,
	@w_est_cancelado         tinyint,
	@w_est_suspenso          tinyint,
	@w_est_castigado         tinyint,
	@w_est_diferido          tinyint,
	@w_est_anulado           tinyint,
	@w_est_condonado         tinyint,
	@w_est_credito           TINYINT,
	--JEOM 21/01/2022 INI
	@w_fecha_saldo_ant_uno   DATETIME,
	@w_fecha_saldo_ant_dos   DATETIME,
	--DEBM 01/03/2022 INI
	@w_fecha_ini_bim_ant     DATETIME,
	@w_fecha_fin_bim_ant     DATETIME,
	--DEBM 01/03/2022 FIN
	@fecha_habil 			 DATETIME,
	@w_est_etapa2			 tinyint
	--JEOM 21/01/2022 FIN
	

select @w_fecha_inicio  = @i_fecha_inicio 
select @w_fecha_fin     = @i_fecha_fin
select @w_fecha_fin_bmp = @i_fecha_fin_bmp ---inicio del mes menos un dia y dia habil del mes


--JEOM 21/01/2022 INI
SELECT @w_fecha_saldo_ant_uno = DATEADD(MONTH,-1,DATEADD(mm, DATEDIFF(mm,0,@w_fecha_fin), 0)) 
SELECT @w_fecha_saldo_ant_dos = DATEADD(dd, datepart(dd, @w_fecha_fin) * -1, @w_fecha_fin)
--JEOM 21/01/2022 FIN

--DEBM 01/03/2022 INI
SELECT @w_fecha_ini_bim_ant = DATEADD(MONTH,-3,DATEADD(mm, DATEDIFF(mm,0,@w_fecha_fin), 0)) 
SELECT @w_fecha_fin_bim_ant = DATEADD(dd, datepart(dd, @w_fecha_inicio) * -1, @w_fecha_inicio)
--DEBM 01/03/2022 FIN

exec cob_cartera..sp_decimales
@i_moneda    = 0,
@o_decimales = @w_num_dec out

declare @resultadobcp 		table (linea varchar(max))
select @w_sp_name = 'sp_seguimiento_lcr'

--------------fecha proceso----------------
select @w_fecha_proceso = fp_fecha 
from cobis..ba_fecha_proceso

--------------------------------------------------
---Estados de cartera-----------------------------
--------------------------------------------------
exec @w_error=cob_cartera..sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_novigente  = @w_est_novigente out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_suspenso   = @w_est_suspenso  out,
@o_est_diferido   = @w_est_diferido  out,
@o_est_anulado    = @w_est_anulado   out,
@o_est_condonado  = @w_est_condonado out,
@o_est_credito    = @w_est_credito   out,
@o_est_etapa2 	  = @w_est_etapa2	 out

if @w_error <> 0 
begin
	return 1
end
  
-----------------------------------------
----------calcular dias habiles----------
-----------------------------------------
select @w_dias_bimestre = datediff(dd, @w_fecha_inicio,@w_fecha_fin)
------------------------------------------------------------------------
-------------------------LIMPIAR TEMPORALES-----------------------------
------------------------------------------------------------------------

if object_id('tempdb..##tmp_linea_revolvente') is not null  drop table ##tmp_linea_revolvente 
if object_id('tempdb..##saldo_promedios') 	   is not null  drop table ##saldo_promedios 
if object_id('tempdb..##saldo_anteriores') 	   is not null  drop table ##saldo_anteriores 
if object_id('tempdb..##countas_vencidas') 	   is not null  drop table ##countas_vencidas 
if object_id('tempdb..##saldo_clientes') 	   is not null  drop table ##saldo_clientes 
if object_id('tempdb..##saldo_fm') 	   		   is not null  drop table ##saldo_fm 
if object_id('tempdb..##com_utilizacion') 	   is not null  drop table ##com_utilizacion 
--JEOM 24/01/2022 INI
if object_id('tempdb..##sb_dato_transaccion_det') is not null drop table ##sb_dato_transaccion_det
if object_id('tempdb..##sb_dato_operacion_abono') is not null drop table ##sb_dato_operacion_abono
--JEOM 24/01/2022 INI

---------------------------------------------------------------------------------------------
-------------------------       REPORTE CREDITO REVOLVENTE       ----------------------------
---------------------------------------------------------------------------------------------
select
cr_id_producto              = 069402,    --1 fijo
cr_foliocredito				= do_banco,  --2
cr_tramite                  = do_tramite,--campo ayuda para el campo 22
cr_permite_uso        		= case when do_dias_mora_365 = 0 then 'S' else 'N'end ,--campo ayuda para el campo 22
cr_saldo_ult_1              = convert(varchar(1),'N'),--campo ayuda para el campo 22
cr_saldo_ult_3              = convert(varchar(1),'N'),--campo ayuda para el campo 22
cr_pago_ult_4               = convert(varchar(1),'N'),--campo ayuda para el campo 22
cr_limcredito				= do_monto_aprobado , --3*
cr_saldotot					= do_saldo - do_saldo_otros - do_saldo_int_contingente - do_saldo_otr_contingente   , --4*
cr_pagongi					= do_saldo - do_saldo_otros - do_saldo_int_contingente - do_saldo_otr_contingente   , --5*
cr_saldorev1				= convert(money,0)	, --6,
cr_interesrev               = convert(money,0.00),--do_saldo_int	, --7
cr_saldopmsi                = convert(money,0.00),--8 fijos
cr_meses                    = floor(do_dias_mora_365/30),--9*
cr_pagomin                  = convert(money,0)	 ,--10,
cr_tasarev                  = do_tasa           , --11*													   
cr_saldopci                 = convert(money,0.00),--12 fijos
cr_interespci               = convert(money,0.00),--13 fijos
cr_saldopagar               = convert(money,0.00),--14
cr_pagoreal                 = convert(money,0.00),--15,
cr_limcreditoa              = convert(money,0.00),--16
cr_pagoexige                = convert(money,0.00),--17
cr_impagosc                 = convert(varchar(2),' ')    ,--18*
cr_impagosum                = convert(varchar(10),' ')	 ,--19
cr_mesapert                 = datediff(mm,do_fecha_concesion,@w_fecha_fin) , --20*
cr_saldocont                = do_saldo_cap + do_saldo_int ,   --21*
cr_situacion                = convert(varchar(2),' '), 		  --22
cr_probinc					= convert(varchar(10),' '),--fijos --23
cr_sevper					= convert(varchar(10),' '),--fijos --24
cr_expinc                   = convert(varchar(10),' '),--fijos --25
cr_mreserv                  = convert(varchar(10),' '),--fijos --26
cr_relacion                 = convert(varchar(2),' '),--fijos --27
/*cr_clascont                 = case when do_estado_cartera in (@w_est_vigente,@w_est_cancelado) then 1 --when do_estado_cartera in (1,3) then 1
                                   when do_estado_cartera = @w_est_vencido                     then 5 --when do_estado_cartera = 2      then 5                                              
								   else do_estado_cartera
							  end,  */                   --28*
cr_clascont					=  CASE WHEN do_dias_mora_365 <= 30 THEN '1' 
                                    WHEN do_dias_mora_365 >= 31 AND do_dias_mora_365 <= 89 THEN '2'
                                    WHEN do_dias_mora_365 >= 90 THEN '3'
                               END,							  
cr_cvecons                  = convert(varchar(64),''), --29
cr_limcreditocalif          = do_monto_aprobado ,      --30* 
cr_montopagarinst           = convert(money,0.00),     --31
cr_montopagarsic			= convert(int,'0'), 	   --32 *temporal en 0
cr_mesantig                 = convert(varchar(3),do_meses_primer_op),  --fijos  --33
cr_mesesic                  = convert(int,'0'),		   --34 *temporal en 0
cr_segmento                 = convert(varchar(1),' '),  --fijos  --35
cr_gveces                   = convert(varchar(1),' '),  --fijos  --36
cr_garantia                 = convert(varchar(1),'1'), --fijos --37 
cr_catcuenta               = do_valor_cat,            --38*
cr_indicadorcat             = convert(varchar(1),'1'), --fijos --39
cr_folio_cliente            = do_codigo_cliente,	   --40
cr_CP                       = convert(int,'0') , 	   --41
cr_comtotal                 = convert(money,0.00),	   --42
cr_comtardio                = convert(money,0.00),	   --43
cr_pagongiinicio            = convert(money,0.00),     --44								 
cr_pagoexigepsi             = convert(money,0.00),	   --45 fijos
cr_fecha_apertura			= do_fecha_concesion,		-- campo ayuda para el campo 29*
cr_cliente					= do_codigo_cliente			-- campo ayuda para el campo 29*
--JEOM 05/01/2022 INI
,cr_fecha_originacion		= FORMAT (do_fecha_concesion, 'yyyy/MM/dd'),
cr_fecha_vencimiento		= FORMAT (do_fecha_vencimiento, 'yyyy/MM/dd'),
cr_banca_internet			= 0,
cr_qcbd						= convert(money,0.00),
cr_saldorev_ant				= convert(money,0.00),
cr_saldorev					= convert(money,0.00),
cr_pagoexige_ini 			= convert(money,0.00),
cr_pme_cap_ini				= convert(money,0.00),
cr_pme_int_ini				= convert(money,0.00),
cr_pme_int_ini_com			= convert(money,0.00),
cr_pme_int_ini_com_cob		= convert(money,0.00),
cr_pme_otro_ini				= convert(money,0.00),
cr_pagomin_corte			= convert(money,0.00),
cr_pme_cap_corte			= convert(money,0.00),
cr_pme_int_ini_cort			= convert(money,0.00),
cr_pme_int__com_corte		= convert(money,0.00),
cr_pme_int_corte			= convert(money,0.00),
cr_pagoreal_ant				= convert(money,0.00),
cr_pme_otro_corte			= convert(money,0.00),
cr_pagoreal_corte			= convert(money,0.00),
cr_pagoreal_cap_corte		= convert(money,0.00),
cr_pagoreal_int_corte_cap	= convert(money,0.00),
cr_pagoreal_int_corte		= convert(money,0.00),
cr_pagoreal_int_corte_com	= convert(money,0.00),
cr_pagoreal_otro_corte		= convert(money,0.00),
cr_meses_cons_sic			= convert(money,0.00),
cr_etapa_cred				=CASE WHEN do_dias_mora_365 <= 29 THEN '1' 
                                    WHEN do_dias_mora_365 >= 30 AND do_dias_mora_365 <= 89 THEN '2'
                                    WHEN do_dias_mora_365 >= 90 AND do_dias_mora_365 <= 179 THEN '3'
                              END,
cr_tasa_cobrada			    = do_tasa,
cr_plazo_remanente			= convert(money,0.00)
--JEOM 05/01/2022 FIN
into  ##tmp_linea_revolvente 
from  cob_conta_super..sb_dato_operacion 
where do_fecha              = @w_fecha_fin
--and (do_estado_cartera      in (@w_est_vigente,@w_est_vencido) or (do_estado_cartera =  @w_est_cancelado  and do_fecha_vencimiento >= @w_fecha_fin))  --3 cancelado 2 vencido 1 vigente 
and (do_estado_cartera in (@w_est_vigente,@w_est_etapa2,@w_est_vencido) or (do_estado_cartera = @w_est_cancelado and do_fecha_vencimiento >= @w_fecha_fin)) --3 cancelado 2 vencido 1 vigente
--and (do_estado_cartera      in (1,2) or (do_estado_cartera = 3 and do_fecha_vencimiento >= @w_fecha_fin))  
and do_aplicativo 		 = 7
and do_tipo_amortizacion = 'ROTATIVA'


--Crear un indice cluster para el cr_foliocredito y cr_folio_cliente 
CREATE CLUSTERED INDEX  idx01
    ON tempdb..##tmp_linea_revolvente (cr_foliocredito,cr_folio_cliente)


---------------------------------
---Actualizacion campo 6
---------------------------------
select
dr_banco      =dr_banco, 
dr_saldorev   =round(sum(case when dr_categoria in ('C', 'I') then dr_acumulado - dr_pagado else 0 end )/@w_dias_bimestre ,@w_num_dec)--6
-- dr_interesrev =round(sum(case when dr_categoria =  'I' then dr_acumulado - dr_pagado else 0 end )/@w_dias_bimestre ,@w_num_dec) -- 7 removido por caso #154324 */
into ##saldo_promedios
from cob_conta_super..sb_dato_operacion_rubro  , ##tmp_linea_revolvente
where dr_fecha  between @w_fecha_inicio and @w_fecha_fin
and dr_banco    = cr_foliocredito
group by dr_banco

select
dr_banco,
dr_saldo_ex      = sum(case when dr_exigible   = 1   then  isnull(dr_valor, 0) else 0 end),
dr_int    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end)
			+ sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end)
			+ sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end)
into #rubros
from cob_conta_super..sb_dato_operacion_rubro
where dr_fecha      = @w_fecha_fin
and   dr_aplicativo = 7
group by dr_banco

update  ##tmp_linea_revolvente set 
cr_saldorev1   = dr_saldorev   --6
-- cr_interesrev = dr_interesrev  --7 removido por caso #154324
from  ##saldo_promedios
where cr_foliocredito=dr_banco

----------------------------------------------------------------
---Campo 14 , campo 16 ,campo 44 al finalizar el bimestre pasado
----------------------------------------------------------------
update  ##tmp_linea_revolvente set 
cr_saldopagar     = do_saldo,          --14
cr_limcreditoa    = do_monto_aprobado, --16
cr_pagongiinicio  = do_saldo           --44
from  cob_conta_super..sb_dato_operacion  
where do_fecha   = @w_fecha_fin_bmp  --fecha anterior del bimestre
and   do_banco   = cr_foliocredito 

----------------------------------------------------------------
---Campo 15 SUMA DE PAGOS EN EL BIMESTRE 
----------------------------------------------------------------
select 
fecha      = dt_fecha,
banco      = dt_banco,
secuencial = dt_secuencial 
into #pagos_total
from sb_dato_transaccion ,##tmp_linea_revolvente
where  dt_reversa    = 'N'
and dt_tipo_trans    = 'PAG'
and dt_banco  		 = cr_foliocredito 
and dt_fecha  between @w_fecha_inicio and @w_fecha_fin

delete #pagos_total  
from sb_dato_transaccion 
where banco     =  dt_banco  
and  secuencial = -1*dt_secuencial 
and  dt_reversa = 'S'
and  dt_fecha   between @w_fecha_inicio and @w_fecha_fin       

select 
banco = dd_banco,
monto = sum(dd_monto)
into #pagos_bimestre
from sb_dato_transaccion_det ,#pagos_total       --detalles de pago 
where dd_banco    = banco 
and dd_secuencial = secuencial 
and dd_fecha      = fecha
and dd_codigo_valor <= 999
and dd_aplicativo = 7
group by dd_banco

update ##tmp_linea_revolvente set 
cr_pagoreal = monto 
from #pagos_bimestre 
where  banco = cr_foliocredito


----------------------------------------------------------------
-- campo 17  Saldo exigible al final del bimestee
----------------------------------------------------------------
select
sa_banco        = dr_banco,
sa_pagoexige    = sum(case when dr_exigible=1 then dr_acumulado - dr_pagado else 0 end )--17
into ##saldo_anteriores
from cob_conta_super..sb_dato_operacion_rubro  ,##tmp_linea_revolvente
where dr_fecha = @w_fecha_inicio
and dr_banco   = cr_foliocredito 
group by dr_banco

update  ##tmp_linea_revolvente set 
cr_pagoexige = sa_pagoexige      --17	
from  ##saldo_anteriores 
where sa_banco  = cr_foliocredito 


----------------------------------------------------------------
-- campo 18, 19, 22, 27
----------------------------------------------------------------

UPDATE ##tmp_linea_revolvente set 
cr_impagosc  = NULL,
cr_impagosum = NULL,
cr_situacion = NULL,
cr_relacion  = NULL
;

/* Removido por caso #154324
------------------------------------------------------------------
--campo 19 numero de impagas
------------------------------------------------------------------

select @w_fecha_bmp1=	dateadd(mm,-4,@w_fecha_inicio)

select 
cv_banco  = dc_banco,
cv_impagosum = count(1)
into ##countas_vencidas
from cob_conta_super..sb_dato_cuota_pry ,##tmp_linea_revolvente
where dc_fecha      = @w_fecha_fin
and   dc_banco      = cr_foliocredito
and   dc_fecha_vto  between  @w_fecha_bmp1 and @w_fecha_fin
and   (dc_estado =@w_est_vencido or (dc_estado=@w_est_cancelado and dc_fecha_can>dc_fecha_vto))--[2 vencido]  [3 cancelado]
group by dc_banco 
 
update  ##tmp_linea_revolvente set 
cr_impagosum = cv_impagosum      --19
from  ##countas_vencidas 
where cv_banco  = cr_foliocredito  


-----------------------------------------------------------------
---- campo 22 situacion 
-----------------------------------------------------------------
if object_id('tempdb..#prestamos_dividendos') is not null
   drop table #prestamos_dividendos

create table #prestamos_dividendos(
secuencial      int IDENTITY(1,1),
operacion       int, 
banco           cuenta,
cliente         int,
monto_aprobado  money,
id_inst_proceso int,
fecha_ini       datetime,
fecha_fin       datetime,
fecha_des       datetime,
utilizacion     money,
pagos           money,
diferencia      money,
numero_cuota    int
)

exec cob_cartera..sp_lcr_gen_dividendos 
@i_cortes = 4, 
@i_fecha  = @w_fecha_fin

update  ##tmp_linea_revolvente set 
cr_permite_uso  = 'N'
from sb_datos_lcr 
where dl_banco = cr_foliocredito
and   dl_fecha = @w_fecha_fin
and   dl_aplicativo = 7 
and   dl_bloqueado = 'SI'


update ##tmp_linea_revolvente set 
cr_saldo_ult_1 = 'S'
from #prestamos_dividendos , sb_dato_operacion 
where banco        = do_banco 
and   do_banco     = cr_foliocredito
and   do_fecha     = fecha_fin
and   numero_cuota = 1
and   do_saldo >0

update ##tmp_linea_revolvente set 
cr_saldo_ult_3 = 'S'
from #prestamos_dividendos , sb_dato_operacion 
where banco        = do_banco 
and   do_banco     = cr_foliocredito
and   do_fecha     = fecha_fin
and   do_saldo >0
and   numero_cuota in ( 2,3,4)


select 
fecha      = dt_fecha,
banco      = dt_banco,
secuencial = dt_secuencial 
into #pagos_total2
from sb_dato_transaccion ,#prestamos_dividendos
where  dt_reversa    = 'N'
and dt_tipo_trans    = 'PAG'
and dt_banco         = banco
and dt_fecha  between fecha_ini and fecha_fin

delete #pagos_total2  
from sb_dato_transaccion , #prestamos_dividendos d, #pagos_total2 p
where d.banco      =  dt_banco 
and   dt_banco     =  p.banco
and   p.secuencial = -1*dt_secuencial 
and  dt_reversa    = 'S'
and  dt_fecha   between d.fecha_ini and d.fecha_fin        


update ##tmp_linea_revolvente set 
cr_pago_ult_4 = 'S'
from #pagos_total2 
where banco     = cr_foliocredito


update  ##tmp_linea_revolvente set 
cr_situacion = case when cr_permite_uso = 'S' and cr_saldo_ult_1 = 'S'                                                    then '6'
					when cr_permite_uso = 'S' and cr_saldo_ult_1 = 'N' and cr_saldo_ult_3 = 'N' and cr_pago_ult_4  = 'N'  then '7'
                    when cr_permite_uso = 'S' and cr_saldo_ult_1 = 'N' and cr_saldo_ult_3 = 'N' and cr_pago_ult_4  = 'S'  then '8'
                    when cr_permite_uso = 'S' and cr_saldo_ult_1 = 'N' and cr_saldo_ult_3 = 'S'                           then '9'
					
					when cr_permite_uso = 'N' and cr_saldo_ult_1 = 'S'                                                    then '10'
					when cr_permite_uso = 'N' and cr_saldo_ult_1 = 'N' and cr_saldo_ult_3 = 'N' and cr_pago_ult_4  = 'N'  then '11'
                    when cr_permite_uso = 'N' and cr_saldo_ult_1 = 'N' and cr_saldo_ult_3 = 'N' and cr_pago_ult_4  = 'S'  then '12'
                    when cr_permite_uso = 'N' and cr_saldo_ult_1 = 'N' and cr_saldo_ult_3 = 'S'                           then '13'
					else '0'
			   end 
   



*/
   
---------------------------------------------------------------------
--CAMPO 29  Clave de Consulta a la Sociedad de Información Crediticia.
----------------------------------------------------------------------
update ##tmp_linea_revolvente  set 
cr_cvecons = tr_folio_buro 
from cob_credito..cr_tramite 
where cr_tramite = tr_tramite

update ##tmp_linea_revolvente  set 
cr_cvecons = ib_folio 
from cob_credito..cr_interface_buro 
where cr_cliente = ib_cliente AND CAST(ib_fecha as DATE) <= CAST(cr_fecha_apertura AS DATE)  AND cr_cvecons IS NULL  

SELECT cr_cliente AS cliente, MAX(ibh_secuencial) AS secuencial
INTO #consultaBuro
FROM ##tmp_linea_revolvente, cob_credito_his..cr_interface_buro_his
WHERE cr_cliente = ibh_cliente AND CAST(ibh_fecha as DATE) <= CAST(cr_fecha_apertura AS DATE) AND cr_cvecons IS NULL
GROUP BY cr_cliente

UPDATE ##tmp_linea_revolvente SET cr_cvecons = ibh_folio
FROM #consultaBuro, cob_credito_his..cr_interface_buro_his
WHERE  cr_cliente = ibh_cliente AND ibh_secuencial = secuencial AND cr_cvecons IS NULL
AND cliente = cr_cliente 

------------------------------------------------------------------
-- campo 31 monto a pagar
------------------------------------------------------------------
select
sc_cliente          = do_codigo_cliente,
sc_montopagarinst   = sum(do_saldo)    --31
into ##saldo_clientes
from cob_conta_super..sb_dato_operacion ,##tmp_linea_revolvente
where do_fecha = @w_fecha_fin
and  do_codigo_cliente = cr_folio_cliente 
group by do_codigo_cliente

update  ##tmp_linea_revolvente set 
cr_montopagarinst = sc_montopagarinst  --31
from  ##saldo_clientes 
where sc_cliente  = cr_folio_cliente 


-----------------------------------------------------------------
---campo 41 codigo postal
-----------------------------------------------------------------
update  ##tmp_linea_revolvente set 
cr_CP = di_codpostal  --41
from cobis..cl_direccion 
where di_ente = cr_folio_cliente 
and di_principal = 'S'

-----------------------------------------------------------------
---campo 42 , campo 43,campo 10 Importe promedio 
-----------------------------------------------------------------
select
sf_banco        =  dr_banco,
sf_pagomin      =  sum(case when dr_exigible=1    then dr_acumulado - dr_pagado else 0 end ),--10
sf_cap_no_exig  =  sum(case when dr_exigible=0 and dr_categoria = 'C'   then dr_acumulado - dr_pagado else 0 end ),--10
sf_comtotal     =  sum(case when dr_categoria='O' then dr_acumulado else 0 end ),            --42- 
sf_comtardio    =  sum(case when dr_categoria='O' then dr_acumulado else 0 end )             --43
into ##saldo_fm
from cob_conta_super..sb_dato_operacion_rubro , ##tmp_linea_revolvente
where dr_fecha = @w_fecha_fin
and   dr_banco = cr_foliocredito
group by dr_banco

--Campo 10
update ##saldo_fm set 
sf_pagomin = sf_pagomin + sf_cap_no_exig
--comision por utilizacion
select  
cu_banco       = dt_banco,
cu_utilizacion = sum(dd_monto)
into ##com_utilizacion
from sb_dato_transaccion , sb_dato_transaccion_det,##tmp_linea_revolvente
where dt_fecha     = dd_fecha
and  dt_banco      = dd_banco
and  dt_secuencial = dt_secuencial
and  dt_tipo_trans = 'DES' 
and  dt_reversa    = 'N'
and  dt_fecha  between @w_fecha_inicio  and @w_fecha_fin
and  dt_banco 	   = cr_foliocredito 
and dd_concepto    ='COM' --comision utilizacion
group by dt_banco

update  ##saldo_fm set 
sf_comtotal= sf_comtotal + cu_utilizacion
from ##com_utilizacion
where cu_banco = sf_banco

update  ##tmp_linea_revolvente set 
cr_pagomin    = sf_pagomin,   --10
cr_comtotal   = sf_comtotal,  --42
cr_comtardio  =	sf_comtardio  --43
from ##saldo_fm
where sf_banco=cr_foliocredito

-----------------------------------------------------------------
---campo 9 cr_banca_internet JEOM Probar
-----------------------------------------------------------------
--se valida si la fecha fin menos dos meses es valida y no es un dia festivo
SELECT @fecha_habil = (SELECT DISTINCT df_fecha FROM cobis..cl_dias_feriados WHERE df_fecha = DATEADD(MONTH,-2, @w_fecha_fin))

WHILE (SELECT count(1) FROM cobis..cl_dias_feriados WHERE df_fecha =  @fecha_habil) > 0 
BEGIN 
	SELECT @fecha_habil =  DATEADD(DAY,-1, @fecha_habil)
	PRINT @fecha_habil
END;

if @fecha_habil is  null  SELECT @fecha_habil =  DATEADD(MONTH,-2, @w_fecha_fin)


SELECT *
into ##sb_dato_transaccion_det
FROM sb_dato_transaccion_det
WHERE dd_fecha = @w_fecha_fin

SELECT *
into ##sb_dato_operacion_abono
FROM sb_dato_operacion_abono
WHERE doa_fecha IN ( @fecha_habil, @w_fecha_fin)

CREATE CLUSTERED INDEX  sb_det
    ON tempdb..##sb_dato_transaccion_det (dd_banco,dd_fecha)

CREATE CLUSTERED INDEX  sb_dato_oper
    ON tempdb..##sb_dato_operacion_abono (doa_banco,doa_fecha)	


UPDATE ##tmp_linea_revolvente SET
cr_banca_internet = 1
FROM cob_bvirtual..bv_ente,
cob_bvirtual..bv_login
where en_ente_mis = cr_cliente and en_ente = lo_ente

--Se agrega el siguiente update ya que no existe otra forma de realizar desembolsos en LCR que no sea por banca internet
UPDATE ##tmp_linea_revolvente SET
cr_banca_internet = 1
FROM cob_conta_super..sb_dato_transaccion
where dt_banco = cr_foliocredito and dt_tipo_trans = 'DES'


UPDATE ##tmp_linea_revolvente SET
 cr_qcbd =
 (SELECT ISNULL(
		(SELECT  sum(doa_total)        
		FROM ##sb_dato_operacion_abono 
		WHERE doa_fecha = @w_fecha_fin
		AND   doa_banco = cr_foliocredito
		AND doa_condonaciones = 'S' ),0 )
 )

--Se deja para que tome desde el primer dia del mes 01/MM/YYYY y el 
--ultimo dia 28, 30 y 31 llegado el caso 31/MM/YYYY
UPDATE ##tmp_linea_revolvente 
	SET cr_saldorev_ant = 
	(SELECT ISNULL(
		(SELECT sum(do_saldo)/30.4 
		FROM cob_conta_super..sb_dato_operacion 
		WHERE do_fecha between @w_fecha_saldo_ant_uno 
		AND   @w_fecha_saldo_ant_dos
		AND   do_banco  = cr_foliocredito ),0 )
	)

UPDATE ##tmp_linea_revolvente 
	SET cr_saldorev = 
	(SELECT ISNULL(
		(SELECT sum(do_saldo)/30.4 
			FROM cob_conta_super..sb_dato_operacion 
			WHERE do_fecha  between @w_fecha_inicio  and @w_fecha_fin
			AND   do_banco  = cr_foliocredito),0 )
	)


UPDATE ##tmp_linea_revolvente 
	SET cr_interesrev = dr_int
from #rubros
where dr_banco = cr_foliocredito


--Si tiene dias mora retorna el do_saldo_cap_total/3 si no retorna el saldo total
--Suma de pd.do_saldo_cap + pd.do_saldo_int  de hace dos meses
--llegado el caso que no haya informacion para ese momento retorna 0
UPDATE ##tmp_linea_revolvente 
	SET cr_pagoexige_ini =CASE WHEN py.do_dias_mora_365  = 0 then 0
ELSE
	(SELECT ISNULL((SELECT sum(dr_valor)  FROM cob_conta_super..sb_dato_operacion_rubro 
	WHERE dr_exigible = 1 AND dr_concepto in('CAP','INT','COMMORA','IVA_INT', 'IVA_CMORA')
AND dr_banco  = cr_foliocredito AND dr_fecha = @fecha_habil),0 ) )
END 
FROM cob_conta_super..sb_dato_operacion py
WHERE   py.do_banco  = cr_foliocredito 
AND py.do_fecha = @fecha_habil

UPDATE ##tmp_linea_revolvente 
	SET cr_pme_cap_ini = (SELECT ISNULL((SELECT sum(dr_valor)  FROM cob_conta_super..sb_dato_operacion_rubro 
	WHERE dr_exigible = 1 AND dr_concepto = 'CAP'
AND dr_banco  = cr_foliocredito AND dr_fecha = @fecha_habil),0 ) )


UPDATE ##tmp_linea_revolvente 
	SET cr_pme_int_ini = (SELECT ISNULL((SELECT sum(dr_valor)  FROM cob_conta_super..sb_dato_operacion_rubro 
	WHERE dr_exigible = 1 AND dr_concepto = 'INT'
AND dr_banco  = cr_foliocredito AND dr_fecha = @fecha_habil),0 ) )

--39
UPDATE ##tmp_linea_revolvente 
	SET cr_pme_int_ini_com_cob = 
	(SELECT ISNULL(
		(SELECT sum(dr_valor) FROM sb_dato_operacion_rubro WHERE dr_banco  = cr_foliocredito
		AND dr_concepto = 'COMMORA'
		AND dr_fecha = @fecha_habil ),0 )
	)

UPDATE ##tmp_linea_revolvente 
	SET cr_pme_otro_ini = 
	(SELECT ISNULL(
		(SELECT sum(dr_valor) FROM sb_dato_operacion_rubro WHERE dr_banco  = cr_foliocredito
		AND dr_concepto LIKE '%IVA%'
		AND dr_fecha = @fecha_habil ),0 )	
	)


UPDATE ##tmp_linea_revolvente 
	SET cr_pme_int_ini_cort = (SELECT ISNULL((SELECT sum(dr_valor)  FROM cob_conta_super..sb_dato_operacion_rubro 
	WHERE dr_exigible = 1 AND dr_concepto = 'INT'
AND dr_banco  = cr_foliocredito AND dr_fecha = @w_fecha_fin),0 ) )


UPDATE ##tmp_linea_revolvente 
	SET cr_pme_int__com_corte = 0


UPDATE ##tmp_linea_revolvente 
	SET cr_pme_int_corte = 
	(SELECT ISNULL(
		(SELECT sum(dr_valor) FROM cob_conta_super..sb_dato_operacion_rubro WHERE dr_banco  = cr_foliocredito
		AND dr_exigible = 1
		AND dr_concepto = 'COMMORA'
		AND dr_fecha =  @w_fecha_fin ),0 )
	)

UPDATE ##tmp_linea_revolvente 
	SET cr_pme_otro_corte = 
	(SELECT ISNULL(
		(SELECT sum(dr_valor) FROM cob_conta_super..sb_dato_operacion_rubro WHERE dr_banco  = cr_foliocredito
		AND dr_exigible = 1
		AND dr_concepto LIKE '%IVA%'
		AND dr_fecha =  @w_fecha_fin ),0 )	
	)

UPDATE ##tmp_linea_revolvente 
	SET cr_pme_cap_corte = (SELECT ISNULL(
		(SELECT sum(dr_valor) FROM cob_conta_super..sb_dato_operacion_rubro WHERE dr_banco  = cr_foliocredito
		AND dr_exigible = 1
		AND dr_concepto LIKE 'CAP'
		AND dr_fecha =  @w_fecha_fin ),0 )	
	)

UPDATE ##tmp_linea_revolvente 
	SET cr_pagomin_corte = cm_monto
FROM cob_conta_super..sb_dato_operacion py, cob_conta_super..sb_cuota_minima, #rubros
WHERE   py.do_banco  = cr_foliocredito
AND py.do_fecha = @w_fecha_fin
and dr_banco = py.do_banco
and cm_fecha = @w_fecha_fin
and cm_banco = py.do_banco
and do_dias_mora_365 = 0

UPDATE ##tmp_linea_revolvente 
	SET cr_pagomin_corte = dr_saldo_ex 
FROM cob_conta_super..sb_dato_operacion py, cob_conta_super..sb_cuota_minima, #rubros
WHERE   py.do_banco  = cr_foliocredito
AND py.do_fecha = @w_fecha_fin
and dr_banco = py.do_banco
and cm_fecha = @w_fecha_fin
and cm_banco = py.do_banco
and do_dias_mora_365 != 0

--49 ***********************
UPDATE ##tmp_linea_revolvente 
	SET cr_pagoreal_ant = 
	(SELECT ISNULL((SELECT sum(dd_monto)
					FROM cob_conta_super..sb_dato_transaccion, cob_conta_super..sb_dato_transaccion_det
					WHERE dd_banco = dt_banco
					AND dt_banco = cr_foliocredito
					and dd_fecha = dt_fecha
					and dd_secuencial = dt_secuencial
					and dd_aplicativo = dt_aplicativo
					and dt_fecha_trans between @w_fecha_ini_bim_ant and @w_fecha_fin_bim_ant
					and dt_tipo_trans = 'PAG'
					and dd_dividendo >= 0
					and dd_concepto IN ('IVA_INT','IVA_CMORA','CAP','INT','COMMORA','SALDOSMINI')),0 )
	)		

UPDATE ##tmp_linea_revolvente 
	SET cr_pagoreal_corte = 
		(SELECT ISNULL((SELECT sum(dd_monto)
					FROM cob_conta_super..sb_dato_transaccion, cob_conta_super..sb_dato_transaccion_det
					WHERE dd_banco = dt_banco
					AND dt_banco = cr_foliocredito
					and dd_fecha = dt_fecha
					and dd_secuencial = dt_secuencial
					and dd_aplicativo = dt_aplicativo
					and dt_fecha_trans between @w_fecha_inicio and @w_fecha_fin
					and dt_tipo_trans = 'PAG'
					and dd_dividendo >= 0
					and dd_concepto IN ('IVA_INT','IVA_CMORA','CAP','INT','COMMORA','SALDOSMINI')),0 )
	)		


UPDATE ##tmp_linea_revolvente 
	SET cr_pagoreal_cap_corte = 
	(SELECT ISNULL((SELECT sum(dd_monto)
					FROM cob_conta_super..sb_dato_transaccion, cob_conta_super..sb_dato_transaccion_det
					WHERE dd_banco = dt_banco
					AND dt_banco = cr_foliocredito
					and dd_fecha = dt_fecha
					and dd_secuencial = dt_secuencial
					and dd_aplicativo = dt_aplicativo
					and dt_fecha_trans between @w_fecha_inicio and @w_fecha_fin
					and dt_tipo_trans = 'PAG'
					and dd_concepto = 'CAP'),0 )
	)	


UPDATE ##tmp_linea_revolvente 
SET cr_pagoreal_int_corte_cap = 
(SELECT ISNULL((SELECT sum(dd_monto)
FROM sb_dato_transaccion,
sb_dato_transaccion_det
where dt_fecha = dd_fecha
and dt_secuencial = dd_secuencial
and dt_tipo_trans = 'PAG'
and dt_banco = dd_banco
and dt_banco = cr_foliocredito
and dt_fecha between @w_fecha_inicio and @w_fecha_fin
and dd_concepto = 'INT'),0 )
)


UPDATE ##tmp_linea_revolvente 
	SET cr_pagoreal_int_corte = 0

UPDATE ##tmp_linea_revolvente 
	SET cr_pagoreal_int_corte_com = 
	(SELECT ISNULL((SELECT sum(dd_monto)
	FROM sb_dato_transaccion,
	sb_dato_transaccion_det
	where dt_fecha = dd_fecha
	and dt_secuencial = dd_secuencial
	and dt_tipo_trans = 'PAG'
	and dt_banco = dd_banco
	and dt_banco = cr_foliocredito
	and dt_fecha between @w_fecha_inicio and @w_fecha_fin
	and dd_concepto in ('COMMORA')),0)
	)

--Se comenta mientras se valida, pues no se encuentra correlacion

--update ##tmp_linea_revolvente
--set cr_pagoreal_int_corte = cr_pagoreal_int_corte_com + cu_utilizacion
--FROM ##com_utilizacion
--WHERE
--cu_banco = cr_foliocredito

UPDATE ##tmp_linea_revolvente 
	SET cr_pagoreal_otro_corte =
	(SELECT ISNULL((SELECT sum(dd_monto)
	FROM sb_dato_transaccion,
	sb_dato_transaccion_det
	where dt_fecha = dd_fecha
	and dt_secuencial = dd_secuencial
	and dt_tipo_trans = 'PAG'
	and dt_banco = dd_banco
	and dt_banco = cr_foliocredito
	and dt_fecha between @w_fecha_inicio and @w_fecha_fin
	and dd_concepto in('IVA_CMORA')),0)
	)

UPDATE ##tmp_linea_revolvente 
	SET cr_pagoreal_otro_corte = cr_pagoreal_otro_corte +
	(SELECT ISNULL((SELECT sum(dd_monto)
	FROM sb_dato_transaccion,
	sb_dato_transaccion_det
	where dt_fecha = dd_fecha
	and dt_secuencial = dd_secuencial
	and dt_tipo_trans = 'PAG'
	and dt_banco = dd_banco
	and dt_banco = cr_foliocredito
	and dt_fecha between @w_fecha_inicio and @w_fecha_fin
	and dd_concepto in('IVA_INT')),0)
	)

UPDATE ##tmp_linea_revolvente 
	SET cr_meses_cons_sic = (
SELECT  ABS(DATEDIFF(month, max(ib_fecha), @w_fecha_fin)) FROM cob_credito..cr_interface_buro WHERE ib_cliente = cr_cliente )

UPDATE ##tmp_linea_revolvente 
	SET cr_plazo_remanente = do_num_cuotas-do_cuotas_pag
FROM  cob_conta_super..sb_dato_operacion WHERE cr_foliocredito = do_banco 
AND do_num_cuotaven = 0 AND do_fecha = @w_fecha_fin	


------------------------------------------------------------------------
-------------------------GENERACION TABLA-----------------------------
------------------------------------------------------------------------
truncate table sb_banxico_lcr
/*insert into sb_banxico_lcr(
 sb_id_producto                                              , sb_foliocredito            						         ,sb_limcredito                                                  , 
 sb_saldotot                                                 , sb_pagongi                 						         ,sb_saldorev         		                                     ,
 sb_interesrev                                               , sb_saldopmsi               						         ,sb_meses                                                       , 
 sb_pagomin          	                                     , sb_tasarev             	 						         ,sb_saldopci       			                                 ,     
 sb_interespci                                               , sb_saldopagar              						         ,sb_pagoreal                                                    , 
 sb_limcreditoa      	                                     , sb_pagoexige           	 						         ,sb_impagosc        		                                     ,     
 sb_impagosum                                                , sb_mesapert                						         ,sb_saldocont                                                   , 
 sb_situacion        	                                     , sb_probinc	             	 					         ,sb_sevper	      			                                     ,	
 sb_expinc                                                   , sb_mreserv                 						         ,sb_relacion                                                    , 
 sb_clascont         	                                     , sb_cvecons             	 						         ,sb_limcreditocalif 		                                     ,
 sb_montopagarinst                                           , sb_montopagarsic           						         ,sb_mesantig                                                    , 
 sb_mesesic          	                                     , sb_segmento            	 						         ,sb_gveces          		                                     ,  
 sb_garantia                                                 , sb_catcuenta               						         ,sb_indicadorcat                                                ,
 sb_folio_cliente    	                                     , sb_CP                  	 						         ,sb_comtotal        		                                     , 
 sb_comtardio                                                , sb_pagongiinicio           						         ,sb_pagoexigepsi  
 )
select
cr_id_producto          				   		  			 , cr_foliocredito	 			 				             ,FORMAT(CONVERT(money, isnull(cr_limcredito,0.00)),'######0.00'),
FORMAT(CONVERT(money, isnull(cr_saldotot,0.00)),'######0.00'), FORMAT(CONVERT(money, cr_pagongi),'######0.00')           ,cr_saldorev   	  				  				             ,			
cr_interesrev            						             , cr_saldopmsi  	                         				 ,cr_meses                  	                                 ,
cr_pagomin										             , FORMAT(cr_tasarev,'N4')				    				 ,cr_saldopci		     							             ,            
cr_interespci							                     , cr_saldopagar											 ,cr_pagoreal	  									             ,
cr_limcreditoa  				  				             , cr_pagoexige	 										     ,cr_impagosc           		                                 ,            
cr_impagosum      		                                     , cr_mesapert               	                         	 ,cr_saldocont 				 						             ,
cr_situacion         	                                     , cr_probinc 		                         				 ,cr_sevper		            				                     ,	
cr_expinc                                 		             , cr_mreserv   	                         				 ,cr_relacion    	                    			             , 
cr_clascont 	                                             , cr_cvecons    		   		                         	 ,cr_limcreditocalif    		                                 ,         
cr_montopagarinst 				  				             , cr_montopagarsic	                      	 			     ,cr_mesantig   	                  				             , 
cr_mesesic                               		             , cr_segmento		                         				 ,cr_gveces 		                  				             ,         
cr_garantia                               		             , FORMAT(CONVERT(money,cr_catcuenta) ,'######0.00')		 ,cr_indicadorcat	                  				         	 , 
cr_folio_cliente                                             , cr_CP         		   		                         	 ,cr_comtotal  									                 ,       
cr_comtardio	 				  				             , FORMAT(CONVERT(money,cr_pagongiinicio) ,'######0.00')	 ,cr_pagoexigepsi 	   
from  ##tmp_linea_revolvente */	
insert into sb_banxico_lcr(
 /*1*/ sb_foliocredito							 	 		/*2*/  ,sb_folio_cliente										/*3*/ ,sb_id_producto							,
 /*4*/ sb_fecha_originacion                          		/*5*/  ,sb_fecha_iniprograma 									/*6*/ ,sb_fecha_finprograma  					,
 /*7*/ sb_tip_est_cuenta								 	/*8*/  ,sb_est_cue_papel										/*9*/ ,sb_banca_internet						,
 /*10*/sb_clascont									 		/*11*/ ,sb_reestructura									    	/*12*/,sb_med_adqui								,
 /*13*/sb_qcbd										 		/*14*/ ,sb_tasarev										    	/*15*/,sb_limcreditoa							,
 /*16*/sb_limcredito							  	 		/*17*/ ,sb_limcredito_calc								    	/*18*/,sb_saldopagar							,
 /*19*/sb_saldotot									 		/*20*/ ,sb_saldo_msi										    /*21*/,sb_saldoc_msi							,
 /*22*/sb_saldocont									 		/*23*/ ,sb_saldorev_ant											/*24*/,sb_saldopmsi_ant							,
 /*25*/sb_saldopci_ant										/*26*/ ,sb_saldorev												/*27*/,sb_saldopmsi								,
 /*28*/sb_saldopci											/*29*/ ,sb_interesrev											/*30*/,sb_interespci							,	
 /*31*/sb_pagoexigepsi_ini									/*32*/ ,sb_pagoexigec_ini										/*33*/,sb_pagoexigepsi							,
 /*34*/sb_pagoexigec										/*35*/ ,sb_pagoexige_ini										/*36*/,sb_pme_cap_ini							,
 /*37*/sb_pme_int_ini										/*38*/ ,sb_pme_int_ini_com										/*39*/,sb_pme_int_ini_com_cob					,
 /*40*/sb_pme_otro_ini										/*41*/ ,sb_pagoexige											/*42*/,sb_pagomin_corte							,
 /*43*/sb_pme_cap_corte										/*44*/ ,sb_pme_int_ini_act										/*45*/,sb_pme_int__com_corte					,
 /*46*/sb_pme_int_corte										/*47*/ ,sb_pme_otro_corte										/*48*/,sb_pagongi								,
 /*49*/sb_pagoreal_ant										/*50*/ ,sb_pagoreal_corte										/*51*/,sb_pagoreal_cap_corte					,
 /*52*/sb_pagoreal_int_corte_cap							/*53*/ ,sb_pagoreal_int_corte									/*54*/,sb_pagoreal_int_corte_com				,
 /*55*/sb_pagoreal_otro_corte								/*56*/ ,sb_catcuenta											/*57*/,sb_indicadorcat							,
 /*58*/sb_tipo_met											/*59*/ ,sb_indicador_sic										/*60*/,sb_meses_cons_sic						,
 /*61*/sb_segmento											/*62*/ ,sb_garantia												/*63*/,sb_relacion								,
 /*64*/sb_meses												/*65*/ ,sb_montopagarinst										/*66*/,sb_montopagarsic							,
 /*67*/sb_mesantig											/*68*/ ,sb_mesesic												/*69*/,sb_mesapert								,
 /*70*/sb_plazo_remanente  									/*71*/ ,sb_gveces												/*72*/,sb_impagosc								,
 /*73*/sb_impagosum											/*74*/ ,sb_etapa_cred											/*75*/,sb_tasa_cobrada							,
 /*76*/sb_probinc											/*77*/ ,sb_sevper												/*78*/,sb_expinc								,
 /*79*/sb_rvas_12											/*80*/ ,sb_rvas_vida											/*81*/,sb_rvas_total							,
 /*82*/sb_etapa_cred_interna								/*83*/ ,sb_fact_cred											/*84*/,sb_tasa_met_cobrada						,
 /*85*/sb_tasa_int_cobrada									/*86*/ ,sb_tasa_prep_cobrada									/*87*/,sb_probabint								,
 /*88*/sb_severint											/*89*/ ,sb_exposint												/*90*/,sb_rvasint_12							,
 /*91*/sb_rvas_vida_int										/*92*/ ,sb_rvas_total_int										/*93*/,sb_probabinc_cap							,
 /*94*/sb_sevper_cap										/*95*/ ,sb_expinc_cap											/*96*/,sb_rvas_total_cap						,
 /*97*/sb_rvas_adicionales
 )
select
/*1*/ cr_foliocredito										/*2*/ ,cr_folio_cliente										/*3*/ ,cr_id_producto								,
/*4*/ cr_fecha_originacion									/*5*/ ,cr_fecha_originacion									/*6*/ ,cr_fecha_vencimiento							,
/*7*/ 0														/*8*/ ,0													/*9*/ ,cr_banca_internet							,
/*10*/cr_clascont									   		/*11*/,60												    /*12*/,1											,
/*13*/cr_qcbd											   	/*14*/,FORMAT(cr_tasarev,'N4')							    /*15*/,cr_limcreditoa								,
/*16*/FORMAT(CONVERT(money, isnull(cr_limcredito,0.00)),'######0.00'), /*17*/FORMAT(CONVERT(money, isnull(cr_limcredito,0.00)),'######0.00'), /*18*/cr_saldopagar			,
/*19*/FORMAT(CONVERT(money, isnull(cr_saldotot,0.00)),'######0.00'),   /*20*/0											/*21*/,0											,		
/*22*/cr_saldocont  										/*23*/,cr_saldorev_ant										/*24*/,0											,
/*25*/0														/*26*/,cr_saldorev											/*27*/,0											,
/*28*/0														/*29*/,cr_interesrev										/*30*/,cr_interespci								,
/*31*/0														/*32*/,0													/*33*/,0											,
/*34*/0														/*35*/,cr_pagoexige_ini										/*36*/,cr_pme_cap_ini								,
/*37*/cr_pme_int_ini										/*38*/,cr_pme_int_ini_com									/*39*/,cr_pme_int_ini_com_cob						,
/*40*/cr_pme_otro_ini										/*41*/,cr_saldopagar										/*42*/,cr_pagomin_corte								,
/*43*/cr_pme_cap_corte										/*44*/,cr_pme_int_ini_cort									/*45*/,cr_pme_int__com_corte						,
/*46*/cr_pme_int_corte										/*47*/,cr_pme_otro_corte									/*48*/,FORMAT(CONVERT(money, cr_pagongi),'######0.00') ,
/*49*/cr_pagoreal_ant										/*50*/,cr_pagoreal_corte									/*51*/,cr_pagoreal_cap_corte						,
/*52*/cr_pagoreal_int_corte_cap								/*53*/,cr_pagoreal_int_corte								/*54*/,cr_pagoreal_int_corte_com					,
/*55*/cr_pagoreal_otro_corte								/*56*/,FORMAT(CONVERT(money,cr_catcuenta) ,'######0.00')	/*57*/,cr_indicadorcat								,
/*58*/0														/*59*/,1													/*60*/,cr_meses_cons_sic							,
/*61*/cr_segmento											/*62*/,cr_garantia											/*63*/,cr_relacion									,
/*64*/cr_meses												/*65*/,NULL													/*66*/,NULL											,
/*67*/NULL													/*68*/,NULL													/*69*/,cr_mesapert									,
/*70*/cr_plazo_remanente									/*71*/,NULL													/*72*/,NULL											,
/*73*/NULL													/*74*/,cr_etapa_cred										/*75*/,cr_tasa_cobrada								,
/*76*/NULL													/*77*/,NULL													/*78*/,NULL											,
/*79*/NULL													/*80*/,NULL													/*81*/,NULL											,
/*82*/0														/*83*/,0													/*84*/,0 											,
/*85*/0														/*86*/,0													/*87*/,0											,
/*88*/0														/*89*/,0													/*90*/,0											,
/*91*/0														/*92*/,0													/*93*/,0											,
/*94*/0														/*95*/,0													/*96*/,0											,
/*97*/0
from  ##tmp_linea_revolvente						

/*
update  sb_banxico_lcr set 
sb_catcuenta	  = FORMAT(CONVERT(money, isnull(sb_catcuenta,0.00)) ,'######0.00')--38
*/

/*
------------------------------------------------------------------------
-------------------------PRUBAS GENERACION ARCHIVO-----------------------
------------------------------------------------------------------------
select @w_reporte_lcr = 'CR_SEGUIMIENTO_'

select @w_sql = 'select * from cob_conta_super..sb_banxico_lcr'

select	@w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @i_ruta_arch + @w_reporte_lcr + replace(convert(varchar,@i_fecha_corte, 104), '.', '') +'".txt"'  + '" -C -c -t";" -T'

delete from @resultadobcp
insert into @resultadobcp
EXEC xp_cmdshell @w_sql_bcp;
select * from @resultadobcp
*/


return 0
GO

