use cob_conta_super
go
/************************************************************/
/*   ARCHIVO:         genera_buro_ttj.sp                    */
/*   NOMBRE LOGICO:   sp_genera_buro_ttj                    */
/*   PRODUCTO:        COBIS CREDITO                         */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  biginternacionales de */
/*   propiedad bigintelectual.  Su uso  no  autorizado dara */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*  Genera los datos (cliente, direccion, empleo y creditos)*/
/*  para el rep. reg. Buro de Credito.                      */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR            RAZON                   */
/* 30/AGO/2021     DCumbal          Emision Inicial         */
/* 26/Oct/2022     KVI              Error.191254            */
/************************************************************/
if exists(select 1 from sysobjects where name = 'sp_genera_buro_ttj')
   drop proc sp_genera_buro_ttj
go
create proc sp_genera_buro_ttj (
  @t_show_version       bit         =   0,
  @i_param1             datetime    =   null -- FECHA DE PROCESO
)as
declare
  @w_sp_name        varchar(20),
  @w_s_app          varchar(50),
  @w_path           varchar(255),
  @w_path_obj       varchar(255),
  @w_destino        varchar(2500),
  @w_msg            varchar(200),
  @w_error          int,
  @w_errores        varchar(1500),
  @w_comando        varchar(2500),
  @w_multiplicador  int,
  @w_redondeo       int,
  -- ----------------------------
  @w_cadena         varchar (1000),
  @w_tipo_telef     varchar(10),
  @w_version        varchar(10),
  @w_member_code    varchar(20),
  @w_nombre_banco   varchar(20),
  @w_factor         float,
  @w_nombre_repo    varchar(21),
  @w_nombre_usuario varchar(20),
  @w_direccion      varchar(100),
  @w_direccion_p1   varchar(30),
  @w_direccion_p2   varchar(30),
  @w_direccion_p3   varchar(30),
  @w_fecha_rep      datetime   ,
  @w_anio_ing       int        ,
  @w_mes_ing        int        ,
  @w_est_vencido    int        ,
  @w_est_vigente    int        ,
  @w_est_castigado  int        ,
  @w_est_suspenso   INT,
  @w_equivalencias  equivalencias, --Nuevo tipo de dato tipo tabla de equivalencias
  @w_CL_MONEDA      equivalencias,
  @w_FREC_PAGOS     equivalencias,
  @w_CL_PAIS_A6     equivalencias,
  @w_CL_ECIVIL      equivalencias,
  @w_ESTADOS_A7     equivalencias,
  @w_num_registros  int,
  @w_num_reg_total  int,
  @w_monto_vencido  BIGINT,
  @w_monto_ven_tot  BIGINT,
  @w_saldo_reg      BIGINT,
  @w_saldo_total    BIGINT,
  @w_fecha_ini      datetime,
  @w_anio_actual    int,
  @w_mes_actual     int,
  @w_mes            int, 
  @w_anio           int,
  @w_fecha_aux      datetime,
  @w_fin_mes_rev    datetime,
  @w_num_reg_cliente    int, -- Error.191254 
  @w_num_reg_cliente2   int, -- Error.191254 
  @w_num_reg_cli_total  int, -- Error.191254 
  @w_num_reg_direccion  int, -- Error.191254  
  @w_num_reg_direccion2 int, -- Error.191254
  @w_num_reg_dir_total  int, -- Error.191254
  @w_num_reg_empleo     int, -- Error.191254
  @w_num_reg_empleo2    int, -- Error.191254
  @w_num_reg_emp_total  int  -- Error.191254
  
  
  declare @w_fecha_fin_mes table(fecha datetime)
  DECLARE @w_cl_ciudad TABLE(ci_ciudad INT, ci_descripcion VARCHAR(64))
  DECLARE @w_cl_parroquia TABLE(pq_parroquia INT, pq_descripcion VARCHAR(64))
  
select @w_sp_name= 'sp_genera_buro_ttj'

--Versionamiento del Programa --
if @t_show_version = 1
begin
 print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.1'
 return 0
end

INSERT INTO @w_equivalencias
SELECT eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado
FROM sb_equivalencias WHERE eq_catalogo = 'CHAR_ASCII'

INSERT INTO @w_CL_MONEDA
SELECT eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado
FROM sb_equivalencias WHERE eq_catalogo = 'CL_MONEDA'

INSERT INTO @w_FREC_PAGOS
SELECT eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado
FROM sb_equivalencias WHERE eq_catalogo = 'FREC_PAGOS'

INSERT INTO @w_CL_PAIS_A6
SELECT eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado
FROM sb_equivalencias WHERE eq_catalogo = 'CL_PAIS_A6'

INSERT INTO @w_CL_ECIVIL
SELECT eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado
FROM sb_equivalencias WHERE eq_catalogo = 'CL_ECIVIL'

INSERT INTO @w_ESTADOS_A7
SELECT eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado
FROM sb_equivalencias WHERE eq_catalogo = 'ESTADOS_A7'

INSERT INTO @w_cl_ciudad
SELECT ci_ciudad, ci_descripcion from cobis..cl_ciudad

INSERT INTO @w_cl_parroquia
SELECT pq_parroquia, pq_descripcion FROM cobis..cl_parroquia
 
select @w_nombre_repo = pa_char 
from   cobis..cl_parametro
where  pa_producto = 'REC'
and    pa_nemonico = 'NRBCDN'

select @w_nombre_usuario = pa_char
from   cobis..cl_parametro
where  pa_producto = 'REC'
and    pa_nemonico = 'NUBRCD'--NRBRCD

--Para direccion
select @w_direccion_p1 = pa_char
from   cobis..cl_parametro
where  pa_producto = 'REC'
and    pa_nemonico = 'DRBCD1'

select @w_direccion_p2 = pa_char
from   cobis..cl_parametro
where  pa_producto = 'REC'
and    pa_nemonico = 'DRBCD2'

select @w_direccion_p3 = pa_char
from   cobis..cl_parametro
where  pa_producto = 'REC'
and    pa_nemonico = 'DRBCD3'

select @w_direccion = isnull(@w_direccion_p1,'') + ' '+ isnull(@w_direccion_p2,'') + ' '+ isnull(@w_direccion_p3,'')

--///////////////////////////////
-- validar si se procesa o no
DECLARE
@w_reporte          VARCHAR(10),
@w_return           int,
@w_existe_solicitud char (1) ,
@w_ini_mes          datetime ,
@w_fin_mes          datetime ,
@w_fin_mes_hab      datetime ,
@w_fin_mes_ant      datetime ,
@w_fin_mes_ant_hab  datetime

--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec @w_error    = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vencido   = @w_est_vencido   out,
@o_est_vigente   = @w_est_vigente   out,
@o_est_castigado = @w_est_castigado out,
@o_est_suspenso  = @w_est_suspenso  out 

SELECT @w_reporte = 'BUROM'

EXEC @w_return = cob_conta..sp_calcula_ultima_fecha_habil
    @i_reporte          = @w_reporte,  -- buro mensual
    @i_fecha            = @i_param1,
    @o_existe_solicitud = @w_existe_solicitud  out,
    @o_ini_mes          = @w_ini_mes out,
    @o_fin_mes          = @w_fin_mes out,
    @o_fin_mes_hab      = @w_fin_mes_hab out,
    @o_fin_mes_ant      = @w_fin_mes_ant out,
    @o_fin_mes_ant_hab  = @w_fin_mes_ant_hab OUT
	

	
if @w_return != 0
begin
    select @w_error = @w_return
    select @w_msg   = 'Fallo ejecucion cob_conta..sp_calcula_ultima_fecha_habil'
    select 'zzzzzzzzzzzzzz'
    goto ERROR_PROCESO
end



if @w_existe_solicitud = 'N' goto SALIDA_PROCESO

-- SI SE EJECUTA EN OTRO DIA, TOMA LAS FECHA DEL MES ANTERIOR
select @w_anio_ing = datepart (yy,@i_param1)
select @w_mes_ing  = datepart (mm,@i_param1)

if exists(select 1
          from  cob_conta..cb_solicitud_reportes_reg
          where sr_reporte = @w_reporte
          and   sr_status  = 'I'
          and   sr_anio    = @w_anio_ing
          and   sr_mes     = @w_mes_ing)
      select @w_fecha_rep  = @i_param1
else                                                                 
      select @w_fecha_rep  =  @w_fin_mes_hab 
          


if not exists (select 1 
           from sb_dato_operacion
           where do_fecha     = @w_fecha_rep
           and   do_aplicativo= 7)            
begin   
     select @w_msg = 'ERROR NO EXISTE LA DATA CONSOLIDADA PARA LA FECHA:' + convert(varchar(10),@w_fecha_rep,101)
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '70011010',
     @i_descrp_error  = @w_msg
end   

if datepart(dd, @i_param1) > 1 -- procesar con mes anterior
begin
   select @i_param1   = dateadd(dd,1, @w_fin_mes)
end

--///////////////////////////////
SELECT
    '@o_ini_mes        '  = @w_ini_mes ,
    '@o_fin_mes        '  = @w_fin_mes ,
    '@o_fin_mes_hab    '  = @w_fin_mes_hab ,
    '@o_fin_mes_ant    '  = @w_fin_mes_ant ,
    '@o_fin_mes_ant_hab'  = @w_fin_mes_ant_hab ,
    '@i_param1         '  = @i_param1
--/////////////////////

select @w_tipo_telef = pa_char
from cobis..cl_parametro
where pa_nemonico='TTBC'

-- SE USA PARA SUBIR LA PARTE DECIMAL A LA PARTE ENTERA POR LA RESTRICCION DE NO DECIMALES EN LOS CAMPOS MONEDA
select @w_multiplicador=1 
--NUMERO DE DECIMALES PARA REDONDEAR
select @w_redondeo=0 

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

select @w_path = ba_path_destino,
       @w_path_obj = ba_path_fuente
from cobis..ba_batch
where ba_batch = 36007

select @w_factor = 30.4


create table #operacion_min_fecha
(
  banco             varchar(20),
  operacion         int,
  fecha_min_ven     datetime null,
  dias_maximo_ven   int      null,
  vencidas          char(1)  null
)

-- ----------------------------------------------------
SELECT @w_version  = '14'

select @w_member_code = pa_char
from cobis..cl_parametro
where pa_nemonico='MNBRCD'
and pa_producto='REC'

select @w_nombre_banco = pa_char
from cobis..cl_parametro
where pa_nemonico='NUBRCD'
and pa_producto='REC'
-- ----------------------------------------------------

CREATE TABLE #sb_reporte_buro_cuentas (
	rb_fecha_report DATETIME NOT NULL,
	rb_operacion    INT NOT NULL,
	rb_ente         INT NOT NULL,
	[04]            VARCHAR (255) NOT NULL,
	[05]            VARCHAR (255),
	[06]            VARCHAR (255),
	[07]            VARCHAR (255),
	[08]            VARCHAR (255),
	[09]            BIGINT,
	[10]            VARCHAR (255),
	[11]            VARCHAR (255),
	[12]            VARCHAR (255),
	[13]            VARCHAR (255),
	[14]            VARCHAR (255),
	[15]            VARCHAR (255),
	[16]            VARCHAR (255),
	[17]            VARCHAR (255),
	[20]            VARCHAR (1),
	[21]            VARCHAR (255),
	[22]            BIGINT,
	[23]            VARCHAR (20),
	[24]            BIGINT,
	[25]            VARCHAR (255),
	[26]            VARCHAR (255),
	[30]            VARCHAR (6),
	[39]            VARCHAR (1),
	[40]            VARCHAR (1),
	[41]            VARCHAR (1),
	[43]            VARCHAR (255),
	[44]            VARCHAR (255),
	[45]            VARCHAR (255),
	[46]            VARCHAR (255),
	[47]            VARCHAR (255),
	[48]            VARCHAR (255),
	[49]            VARCHAR (255),
	[50]            VARCHAR (255),
	[51]            VARCHAR (255),
	[52]            VARCHAR (255),
        fecha_inicio    datetime,
	fecha_cierre    datetime null,
	fecha_primer_at datetime null,
	saldo           money    null,
	saldo_cap       money    null,
	monto_pagar     money    null
)

--LLENAR TABLA CON FECHA DE DESEMBOLSO, FECHA DE ULTIMO PAGO, MONTO DE ULTIMO PAGO, 
--CUOTA(VIGENTE O ULTIMA CUOTA VENCIDA), SALDO (CUOTA VENCIDA O CUOTA VENCE HOY), NUMERO DE CUOTAS 
--Y CORREO ELECTRONICO DEL CLIENTE
CREATE TABLE #desembolso_pago (
op             INT,
bco            cuenta null,
cliente        INT NULL,
fecha_ini      DATE NULL,
ult_pago       DATE NULL,
sec_ult_pago   INT NULL,
monto_ult_pago MONEY NULL,
cuota          MONEY NULL,
saldo          MONEY NULL,
num_cuotas     INT   NULL,
estado         int   null,
fec_cierre     datetime null,
correo_e       VARCHAR (255) NULL) 

CREATE CLUSTERED INDEX idx_1 ON #desembolso_pago(op)

INSERT INTO #desembolso_pago(op, bco,fecha_ini, cliente,estado,fec_cierre)
SELECT 
op_operacion, 
op_banco, 
op_fecha_ini, 
op_cliente, 
op_estado, 
'fec_cierre' = (case when do_estado_cartera = '3' and do_tipo_operacion <> 'REVOLVENTE' then do_fecha_proceso else '' end)
from  sb_dato_operacion, cob_cartera..ca_operacion
where do_fecha          = @w_fecha_rep
AND   do_banco          = op_banco
ORDER BY op_operacion

SELECT op = tr_operacion, fecha_des = max(tr_fecha_ref)
INTO #temp2
FROM #desembolso_pago, cob_cartera..ca_transaccion
WHERE op = tr_operacion
AND tr_tran = 'DES'
AND tr_estado != 'RV'
GROUP BY tr_operacion
ORDER BY tr_operacion

UPDATE #desembolso_pago SET fecha_ini = fecha_des
FROM #temp2
WHERE #desembolso_pago.op = #temp2.op

SELECT op = ab_operacion, ult_pag = max(ab_fecha_pag)
INTO #pago 
FROM  cob_cartera..ca_abono, #desembolso_pago
WHERE ab_operacion = op
AND ab_estado='A'
GROUP BY ab_operacion
ORDER BY ab_operacion

SELECT op, sec = max(ab_secuencial_ing)
INTO #pago_sec
FROM cob_cartera..ca_abono, #pago 
WHERE ab_operacion = op
AND ab_fecha_pag = ult_pag
GROUP BY op
ORDER BY op

SELECT op, monto_ult_pag = abd_monto_mop
INTO #pago_monto
FROM cob_cartera..ca_abono_det, #pago_sec
WHERE abd_operacion = op
AND abd_secuencial_ing = sec
ORDER BY op

UPDATE #desembolso_pago
SET ult_pago = ult_pag
FROM #pago
WHERE #desembolso_pago.op = #pago.op

UPDATE #desembolso_pago
SET monto_ult_pago = monto_ult_pag
FROM #pago_monto
WHERE #desembolso_pago.op = #pago_monto.op

SELECT oper = op, max_div = max(di_dividendo)
INTO #max_div
FROM cob_cartera..ca_dividendo, #desembolso_pago
WHERE di_operacion = op 
AND di_estado IN (1,2)
GROUP BY op
ORDER BY op 

SELECT oper, cuota = sum(am_cuota)
INTO #op_cuota
FROM cob_cartera..ca_amortizacion, #max_div
WHERE am_operacion = oper
AND am_dividendo = max_div
GROUP BY oper
ORDER BY oper

UPDATE #desembolso_pago
SET cuota = #op_cuota.cuota
FROM #op_cuota
WHERE op = oper

SELECT oper = op, max_div = max(di_dividendo)
INTO #max_div_vencido
FROM cob_cartera..ca_dividendo, #desembolso_pago
WHERE di_operacion = op 
AND di_estado IN (1,2)
AND di_fecha_ven <= @w_fecha_rep
GROUP BY op
ORDER BY op 

SELECT oper, saldo = sum(am_cuota-am_pagado)
INTO #op_saldo
FROM cob_cartera..ca_amortizacion, #max_div_vencido
WHERE am_operacion = oper
AND am_dividendo = max_div
GROUP BY oper
ORDER BY oper

UPDATE #desembolso_pago
SET saldo = #op_saldo.saldo
FROM #op_saldo
WHERE op = oper

SELECT op, num_cuotas = count(1)
INTO #num_cuotas
FROM #desembolso_pago, cob_cartera..ca_dividendo
WHERE di_operacion = op
GROUP BY op
ORDER BY op

UPDATE #desembolso_pago
SET #desembolso_pago.num_cuotas = #num_cuotas.num_cuotas
FROM #num_cuotas
WHERE #desembolso_pago.op = #num_cuotas.op

select op, cliente, max_correo = max(di_direccion)
INTO #max_correo_e
FROM cobis..cl_direccion, #desembolso_pago
WHERE di_ente = cliente
AND di_tipo='CE'
GROUP BY op, cliente
ORDER BY op

UPDATE #desembolso_pago
SET correo_e = di_descripcion
FROM #max_correo_e, cobis..cl_direccion
WHERE #desembolso_pago.op = #max_correo_e.op
AND di_ente = #desembolso_pago.cliente
AND #desembolso_pago.cliente = #max_correo_e.cliente
AND di_direccion = max_correo
AND di_tipo='CE'

UPDATE #desembolso_pago SET
cuota      = isnull(cuota, 0),
saldo      = isnull(saldo, 0),
num_cuotas = isnull(num_cuotas, 0)


--PROCESAR PAGOS CONDONADOS Y HAYAN CANCELADO EL PRESTAMO EL MISMO DIA 



----------------------------------------------------------------------------------------
---SECCION DE PAGOS QUE RESULTARON DE PAGOS CONDONADOS CANCELADOS EL MISMO DIA --------
----------------------------------------------------------------------------------------

select 
operacion 		  = ab_operacion ,
banco             = convert(varchar(24), null), 
fecha_pag         = replace(convert(varchar(10),max(ab_fecha_pag),103),'/',''),
estado_op         = convert(int, null),
fecha_can         = replace(convert(varchar(10),max(fec_cierre),103),'/',''),
fecha_can_date    = max(fec_cierre),
monto_con 		  =sum(abd_monto_mn),
secuencial_cond   = max(ab_secuencial_ing) 
into #abonos_con
from cob_cartera..ca_abono,
cob_cartera..ca_abono_det ,
#desembolso_pago
where ab_operacion = op
and ab_operacion  = abd_operacion
and ab_secuencial_ing = abd_secuencial_ing
and ab_estado = 'A'
and abd_tipo = 'CON'
and ab_usuario <> 'usrcond'
group by ab_operacion




update #abonos_con set 
estado_op   = op_estado,
banco       = op_banco 
from  cob_cartera..ca_operacion 
where operacion   = op_operacion 



delete #abonos_con where estado_op not in (3)


delete #abonos_con where fecha_pag <>fecha_can  


--FIN LLENAR TABLA #desembolso_pago

INSERT INTO #sb_reporte_buro_cuentas
( rb_fecha_report, rb_operacion, rb_ente,
    [04], [05], [06], [07], [08], --[09], 
	[10], [11], [12], [13], [14], [15], [16], [17],
    [21], [22], [23], [24], [25], [26], [30], [43], [44], [45], [46], --[47], [48], [49], 
	[50], [51], [52], fecha_inicio)
select
    'fecha'      = @i_param1,
    'operacion'  = op_operacion,
    'ente'       = op_cliente,
    -- numero de cuenta
    '04' = ltrim(rtrim(op_banco)),
    -- tipo de responsabilidad de la cuenta
    '05' = 'I',
    -- tipo de cuenta
    '06' = case when do_tipo_operacion in ('REVOLVENTE') then
			dbo.fn_formatea_texto(1,'R',null,'S','S','S')
		   else
			dbo.fn_formatea_texto(1,'I',null,'S','S','S') end,
    -- tipo de contrato o producto
    '07' = case when do_tipo_operacion in ('REVOLVENTE') then 
	         dbo.fn_formatea_texto(2,'CL',null,'S','S','S')
			 else dbo.fn_formatea_texto(2,'PL',null,'S','S','S') end,
    -- moneda del credito
    '08' = dbo.fn_formatea_texto(2,
            (select eq_valor_arch from @w_CL_MONEDA where eq_valor_cat=op_moneda),null,'S','S','S'),
    -- importe del valuo
    -- '09' = 0,
    -- numero de pagos
    '10' = case when do_tipo_operacion in ('REVOLVENTE') then '00'
		 else dbo.fn_formatea_texto(4,null, num_cuotas, null,'N','S') end,
    -- frecuncia de pagos
    '11' = case when do_tipo_operacion not in ('REVOLVENTE') then  dbo.fn_formatea_texto(1,
            case (select eq_valor_arch from @w_FREC_PAGOS where eq_valor_cat = op_tplazo)
            when null then ''
            else (select upper(eq_valor_arch) from @w_FREC_PAGOS where eq_valor_cat = op_tplazo)
            end
            ,null,'S','S','S') else dbo.fn_formatea_texto(1,'Z',null,'S','S','S') end,
    -- monto a pagar
    '12' = CASE
              when op_tplazo= 'W' and do_tipo_operacion not in ('REVOLVENTE') 
		         THEN convert(bigint,round(cuota * 4,@w_redondeo)*@w_multiplicador)
              when op_tplazo = 'Q' and do_tipo_operacion not in ('REVOLVENTE')
                 THEN convert(bigint,round(cuota * 2,@w_redondeo)*@w_multiplicador)            
              when op_tplazo = 'M' and do_tipo_operacion not in ('REVOLVENTE')
                 THEN convert(bigint,round(cuota,@w_redondeo)*@w_multiplicador)            
		      when do_tipo_operacion = 'REVOLVENTE'
                 THEN convert(bigint,round(saldo,@w_redondeo)*@w_multiplicador)            
              else 0
           end,
    '13'  = dbo.fn_formatea_texto(8,isnull(replace(convert(varchar(10),do_fecha_concesion,103),'/',''),'01011900'),null,'S','S','S'),   --***
    '14' =  case when do_tipo_operacion != 'REVOLVENTE' and ult_pago IS NOT null
             THEN
	            dbo.fn_formatea_texto(8,replace(convert(varchar(10),ult_pago, 103), '/',''),null,'S','N','S') 
		    when do_tipo_operacion = 'REVOLVENTE' and op_monto = 0  then dbo.fn_formatea_texto(8,isnull(replace(convert(varchar(10),op_fecha_ini,103),'/',''),'01011900'),null,'S','S','S')                      
			when do_tipo_operacion = 'REVOLVENTE' and ult_pago IS NOT NULL then dbo.fn_formatea_texto(8,replace(convert(varchar(10),
                ult_pago, 103), '/',''),null,'S','N','S')
			when do_tipo_operacion = 'REVOLVENTE' and ult_pago IS NULL then 
				dbo.fn_formatea_texto(8,replace(convert(varchar(10),fecha_ini, 103), '/',''),null,'S','N','S')					
            when do_tipo_operacion != 'REVOLVENTE' and ult_pago is null	then -- Error.191254
				dbo.fn_formatea_texto(8,replace(convert(varchar(10),fecha_ini, 103), '/',''),null,'S','N','S')			
             else
                '00'
             end,
    '15'  = case when do_tipo_operacion <> 'REVOLVENTE' then dbo.fn_formatea_texto(8,isnull(replace(convert(varchar(10),do_fecha_concesion,103),'/',''),'01011900'),null,'S','S','S')
			when do_tipo_operacion = 'REVOLVENTE' then dbo.fn_formatea_texto(8,replace(convert(varchar(10),fecha_ini, 103), '/',''),null,'S','N','S')else '' 
		   end,
	-- fecha de cierre / cancelacion
    '16'  = case when do_estado_cartera = 3 and do_tipo_operacion <> 'REVOLVENTE' then 
                      dbo.fn_formatea_texto(8,replace(convert(varchar(10),do_fecha_proceso,103),'/',''),null,'S','S','S') 
	             when do_estado_cartera = 3 and do_tipo_operacion = 'REVOLVENTE' and do_fecha_vencimiento < @w_fecha_rep then
	        	      dbo.fn_formatea_texto(8,isnull(replace(convert(varchar(10),do_fecha_vencimiento,103),'/',''),'01011900'),null,'S','S','S')
	        	 else ''
	        end,
    --fecha de reporte de la informacion = fin de mes
    '17'  = dbo.fn_formatea_texto(8,replace(convert(varchar(10),@w_fin_mes,103),'/',''),null,'S','S','S'),
    --'20' = '',--VALIDAR - Se comenta por ser campo Opcional
    -- credit maximo autorizado
    '21'   = case when do_tipo_operacion <> 'REVOLVENTE' then  
                  dbo.fn_formatea_texto(9,null,convert(bigint,(round(do_monto,@w_redondeo))*@w_multiplicador),null,'N','S')
             else
                  dbo.fn_formatea_texto(9,null,convert(bigint,(round(do_monto_aprobado,@w_redondeo))*@w_multiplicador),null,'N','S')
             end,    
    -- saldo actual
    '22' = 0,
    -- limiredito
    '23' = case when do_tipo_operacion <> 'REVOLVENTE' then'00'
           else dbo.fn_formatea_texto(9,null,convert(bigint,(round(do_monto_aprobado,@w_redondeo))*@w_multiplicador),null,'N','S')
           end,
    -- saldo vencido
    '24' = null,
    -- numero de pagos vencidos	
    '25' = '',
    -- forma de pago actual
    '26' = '',
    -- clave de observacion a fecha [17]
    '30' = '',/*case op_estado
              when 3 then                   
              '30'+ dbo.fn_formatea_texto(2,'CC',null,'N','S','S')              
              else ''
           end,*/
    --'39' = '',--NO VAN - Se comenta por ser campo Opcional
    --'40' = '',--NO VAN - Se comenta por ser campo Opcional
    --'41' = '',--NO VAN - Se comenta por ser campo Opcional     
     -- fecha de primer incumplimiento
    '43' = dbo.fn_formatea_texto(8,'01011900',null,null,'N','S'),    
    -- saldo insoluto de capital
    '44' =  dbo.fn_formatea_texto(10,null,(
                select convert(bigint,0)
                ),null,'N','S') ,
    -- monto del ultimo pago
    '45' = case when ult_pago IS NOT null
             then
	            dbo.fn_formatea_texto(9,null,convert(bigint,(round(isnull(monto_ult_pago,0),@w_redondeo))*@w_multiplicador),null,'N','S')                         
             else                
                 '00'                    
             end,
    -- fecha de ingreso a cartera vencida
    '46' = 	case when do_dias_mora_365 >= 90 then 
				dbo.fn_formatea_texto(8,isnull((replace(convert(varchar(10),do_fecha_suspenso,103),'/','')),'01011900'),null,null,'N','S')
			else 
				dbo.fn_formatea_texto(8,'01011900',null,null,'N','S') 
			end, --MTA    
    -- plazo en meses
    '50' = case when  do_tipo_operacion = 'REVOLVENTE'  then '010'
           else
           '0' + convert(VARCHAR,len(round(round(datediff (day,op_fecha_ini,op_fecha_fin)/@w_factor,2),2))) + 
	             convert(VARCHAR,round(round(datediff (day,op_fecha_ini,op_fecha_fin)/@w_factor,2),2))
           end,	            
    -- monto de credto a la originacion
    '51' = dbo.fn_formatea_texto(9,null,convert(bigint,(round(do_monto_aprobado,@w_redondeo))*@w_multiplicador),null,'N','S'), --REVISAR MONTOS
    -- correo electronico del consumidor
    '52' = dbo.fn_formatea_texto(100, correo_e,null,null,'N','S'),
	do_fecha_concesion
from  sb_dato_operacion,
      cob_cartera..ca_operacion, 
      cob_cartera..ca_estado, #desembolso_pago
where do_fecha          = @w_fecha_rep
and   do_banco          = op_banco
and   do_estado_cartera = es_codigo
and   op_monto <= 99999999
AND   op_operacion = op
ORDER BY op_operacion

if @@error <> 0
begin
    select @w_msg = 'ERROR EN INSERCION #SB_REPORTE_BURO_CUENTAS'
    exec sp_errorlog
    @i_fecha_fin     = @i_param1,
    @i_fuente        = @w_sp_name,
    @i_origen_error  = '70011010',
    @i_descrp_error  = @w_msg
end

CREATE CLUSTERED INDEX idx_reporte_buro ON #sb_reporte_buro_cuentas(rb_operacion,[04])
CREATE INDEX idx_repor_cl ON #sb_reporte_buro_cuentas(rb_ente)
CREATE INDEX idx_repor_lc ON #sb_reporte_buro_cuentas([30])

----------------------------------------------------------------------
-- Obtener fechas
----------------------------------------------------------------------
select @w_fecha_ini = min(fecha_inicio)
from  #sb_reporte_buro_cuentas


select
@w_anio_actual  = year(@w_fecha_rep),
@w_mes_actual   = month(@w_fecha_rep)

select @w_fecha_ini = isnull(@w_fecha_ini, @w_fecha_rep)
select @w_mes = month(@w_fecha_ini), @w_anio = year(@w_fecha_ini)

while 1 = 1
begin
   if (@w_anio = @w_anio_actual and @w_mes_actual = @w_mes)
      break
   
   select @w_fecha_aux = convert(datetime, convert(varchar(2),@w_mes) +'/01/'+convert(varchar(4), @w_anio)) 
   
   exec cob_conta..sp_calcula_ultima_fecha_habil
   @i_reporte			= 'NINGUN',
   @i_fecha             = @w_fecha_aux,
   @o_fin_mes_hab		= @w_fin_mes_rev out
   
   
   --select @w_mes, @w_anio, @w_fecha_aux, @w_fin_mes
   insert into @w_fecha_fin_mes values( @w_fin_mes_rev)
   
   select @w_mes = @w_mes + 1
   if @w_mes > 12 
   begin
      select @w_mes = 1
      select @w_anio = @w_anio + 1
   end   
end

----------------------------------------------------------------------
----------------------------------------------------------------------


print 'Datos Vencimiento'
insert into #operacion_min_fecha (
            banco,
            operacion,
            dias_maximo_ven,
            fecha_min_ven)
select op_banco,
       op_operacion,
       dias_maximo_ven = isnull(do_dias_mora_365,0),
       fecha_min_ven   = case when do_dias_mora_365>= 1 then
                              dateadd(dd,1-do_dias_mora_365,@w_fecha_rep)
                         else 
                              '01/01/1900'
                         end
from  sb_dato_operacion ,cob_cartera..ca_operacion 
where do_fecha     = @w_fecha_rep
and  do_banco      = op_banco 
and do_aplicativo  = 7 
ORDER BY op_banco, op_operacion


CREATE CLUSTERED INDEX idx_op_min_fecha ON #operacion_min_fecha(operacion)
CREATE NONCLUSTERED INDEX idx_op_min_fecha_2 ON #operacion_min_fecha(banco)

update #operacion_min_fecha
set dias_maximo_ven = 0
where dias_maximo_ven <0

update #operacion_min_fecha set
vencidas = 'S'
where dias_maximo_ven <> 0

select
dr_banco,
--CAPITAL
--CAPITAL VIGENTE EXIGIBLE
dr_cap_vig_ex    = sum(case when dr_categoria  = 'C'  and dr_estado =   @w_est_vigente  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
--CAPITAL VENCIDO EXIGIBLE
dr_cap_ven_ex    = sum(case when dr_categoria  = 'C'  and dr_estado in (@w_est_vencido,@w_est_castigado)  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
--CAPITAL VIGENTE NO EXIGIBLE
dr_cap_vig_ne    = sum(case when dr_categoria  = 'C'  and dr_estado =   @w_est_vigente  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end ), 
--INTERES
--INTERES VIGENTE EXIGIBLE
dr_int_vig_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
--INTERES VENCIDO EXIGIBLE
dr_int_ven_ex    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 1 then  isnull(dr_valor,0) else 0 end),
--INTERES VENCIDO NO EXIGIBLE
dr_int_ven_ne    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vencido  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end),
--INTERES VIGENTE NO EXIGIBLE
dr_int_vig_ne    = sum(case when dr_categoria  = 'I' and dr_estado =   @w_est_vigente  and dr_exigible   = 0 then  isnull(dr_valor,0) else 0 end),
dr_saldo         = convert(money,null),
dr_saldo_vencido = convert(money,null)
into #rubros
from #sb_reporte_buro_cuentas, 
     sb_dato_operacion_rubro
where dr_fecha      = @w_fecha_rep
and   dr_aplicativo = 7
and   dr_banco      = [04]
group by dr_banco
ORDER BY dr_banco

CREATE CLUSTERED INDEX idx_rubros ON #rubros(dr_banco)

update #rubros
set dr_saldo_vencido = 1
where dr_saldo_vencido > 0 
and   dr_saldo_vencido < 1

update #rubros
set dr_saldo = case when dr_saldo  - floor(dr_saldo) < 0.5 then
                 floor(dr_saldo)
               else
                 round(dr_saldo,@w_redondeo)
               end,
    dr_saldo_vencido = case when dr_saldo_vencido  - floor(dr_saldo_vencido) < 0.5 then
                            floor(dr_saldo_vencido)
                       else
                            round(dr_saldo_vencido,@w_redondeo)
                       end

SELECT 
di_banco    = [04],
di_vigente  = convert(smallint,0)
into #dividendos2
from #sb_reporte_buro_cuentas
ORDER BY di_banco

CREATE CLUSTERED INDEX idx_div2 ON #dividendos2(di_banco)

UPDATE #dividendos2 SET 
di_vigente  = dc_num_cuota
from sb_dato_cuota_pry
where dc_fecha      = @w_fecha_rep
and   dc_aplicativo = 7
and   dc_banco      = di_banco
AND   dc_estado     = 1

--/////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////

update #sb_reporte_buro_cuentas
set -- numero de pagos    
     -- monto a pagar

    [12] = case when do_estado_cartera = 3 and  do_tipo_operacion <> 'REVOLVENTE'  then 0
                when do_estado_cartera = 3 and  do_tipo_operacion = 'REVOLVENTE'   and do_fecha_vencimiento < @w_fecha_rep then 0
                when do_estado_cartera <> 3 and  do_tipo_operacion <> 'REVOLVENTE' then
	                 case do_periodicidad_cuota
                     when 7  then convert(bigint,(round(isnull(do_valor_cuota,0)* 4,@w_redondeo))*@w_multiplicador)
			         when 14 then convert(bigint,(round(isnull(do_valor_cuota,0)* 2,@w_redondeo))*@w_multiplicador)
                     when 15 then convert(bigint,(round(isnull(do_valor_cuota,0)* 2,@w_redondeo))*@w_multiplicador)                    
                     when 30 then convert(bigint,(round(isnull(do_valor_cuota,0)* 1,@w_redondeo))*@w_multiplicador)
                     else 0
                     end
	            when do_tipo_operacion = 'REVOLVENTE' and do_edad_mora > 0 then
	                 convert(bigint,(ceiling(isnull(do_saldo_cuotaven,0))) *@w_multiplicador)	                             	                        
	            when do_tipo_operacion = 'REVOLVENTE' and do_edad_mora = 0 and do_fecha_vencimiento >= @w_fecha_rep then
	                 convert(bigint,(ceiling(isnull(do_saldo,0)/3)) *@w_multiplicador)
		   end,
    monto_pagar = case when do_estado_cartera = 3 and  do_tipo_operacion <> 'REVOLVENTE'  then 0
                when do_estado_cartera = 3 and  do_tipo_operacion = 'REVOLVENTE'   and do_fecha_vencimiento < @w_fecha_rep then 0
                when do_estado_cartera <> 3 and  do_tipo_operacion <> 'REVOLVENTE' then
	                 case do_periodicidad_cuota
                     when 7  then round(isnull(do_valor_cuota,0)* 4,@w_redondeo)
			         when 14 then round(isnull(do_valor_cuota,0)* 2,@w_redondeo)
                     when 15 then round(isnull(do_valor_cuota,0)* 2,@w_redondeo)
                     when 30 then round(isnull(do_valor_cuota,0)* 1,@w_redondeo)
                     else 0
                     end
	            when do_tipo_operacion = 'REVOLVENTE' and do_edad_mora > 0 then
	                 ceiling(isnull(do_saldo_cuotaven,0))                       	                        
	            when do_tipo_operacion = 'REVOLVENTE' and do_edad_mora = 0 and do_fecha_vencimiento >= @w_fecha_rep then
	                 ceiling(isnull(do_saldo,0)/3)
		   end,
    [14] = case when (do_fecha_ult_pago is not null)
           then
	            dbo.fn_formatea_texto(8,replace(convert(varchar(10),
                (do_fecha_ult_pago), 103), '/',''),null,'S','N','S')                          
           else
                /*case when do_tipo_operacion <> 'REVOLVENTE' then
                          '00'
                     when do_tipo_operacion = 'REVOLVENTE'  then*/ -- Comentado por Error.191254
                          dbo.fn_formatea_texto(8,replace(convert(varchar(10),fecha_ini, 103), '/',''),null,'S','N','S')
               /*end*/ 
           end, 
    --Fecha Cierre   
    [16]  = case when do_estado_cartera = 3 and do_tipo_operacion <> 'REVOLVENTE' then 
                      '16' + dbo.fn_formatea_texto(8,replace(convert(varchar(10),do_fecha_proceso,103),'/',''),null,'S','S','S') 
	             when do_estado_cartera = 3 and do_tipo_operacion = 'REVOLVENTE' and do_fecha_vencimiento < @w_fecha_rep then
	        	      '16' + dbo.fn_formatea_texto(8,isnull(replace(convert(varchar(10),do_fecha_vencimiento,103),'/',''),'01011900'),null,'S','S','S')
	        	 else ''
	        end,
	fecha_cierre  = case when do_estado_cartera = 3 and do_tipo_operacion <> 'REVOLVENTE' then 
                      do_fecha_proceso
	             when do_estado_cartera = 3 and do_tipo_operacion = 'REVOLVENTE' and do_fecha_vencimiento < @w_fecha_rep then
	        	      do_fecha_vencimiento
	        	 else null
	        end,		
    [22] = convert(bigint,(round(isnull(ceiling(do_saldo),0),@w_redondeo))*@w_multiplicador),
	saldo = do_saldo,
    [24] = case when do_tipo_operacion <> 'REVOLVENTE'  then
                convert(bigint,(round(isnull(ceiling(do_saldo_total_Vencido),0),@w_redondeo))*@w_multiplicador)
                when do_tipo_operacion = 'REVOLVENTE' and  do_edad_mora > 0 then
                     convert(bigint,(round(isnull(ceiling(do_saldo_cuotaven),0),@w_redondeo))*@w_multiplicador)
                else 
                     0
           end,
    [25] = case when (do_num_cuotaven != 0 and do_num_cuotaven is not null)
	       then
		      '25' + (select dbo.fn_formatea_texto(4,null,(do_num_cuotaven),null,'N','S'))
		   else
		       ''
           end,
     -- forma de pago actual
    [26] = dbo.fn_formatea_texto(2,
           (select codigo_sib 
            from cob_credito..cr_corresp_sib
            where tabla = 'ca_forma_pago_mop'
            and   isnull(dias_maximo_ven, 0)
                between limite_inf and limite_sup)
           ,null,null,'N','S'),
    [30] = case when do_tipo_operacion <> 'REVOLVENTE' and do_estado_cartera = 3 then                   
                '30'+ dbo.fn_formatea_texto(2,'CC',null,'N','S','S') 
                when do_tipo_operacion = 'REVOLVENTE' and do_estado_cartera = 3 and do_fecha_vencimiento <@w_fecha_rep then              
                '30'+ dbo.fn_formatea_texto(2,'CC',null,'N','S','S') 
           else ''
           end,
     -- fecha de primer incumplimiento
     [43] = case when (fecha_min_ven <> '01/01/1900')
            then 
                 dbo.fn_formatea_texto(8,
                  isnull(
                  (replace(convert(varchar(10),fecha_min_ven,103),'/','')
                  ),'01011900')
                  ,null,null,'N','S')
             else
                 dbo.fn_formatea_texto(8,'01011900',null,null,'N','S') 
             end,
	fecha_primer_at = case when (fecha_min_ven <> '01/01/1900') then 
                         fecha_min_ven
                      else
                         null
                      end,			 
    -- saldo insoluto de capital
    [44] = dbo.fn_formatea_texto(10,null,(
                convert(bigint,(round(isnull(ceiling(do_saldo_cap_total),0),@w_redondeo))*@w_multiplicador)
                ),null,'N','S'),
	saldo_cap = do_saldo_cap_total,
     -- monto del ultimo pago
    [45] = case when (do_valor_ult_pago is not null)
             then
	            dbo.fn_formatea_texto(9,null,
	            (convert(bigint,(round(isnull(do_valor_ult_pago,0),@w_redondeo))*@w_multiplicador)),null,'N','S')                         
             else                
                 '00'                    
             end ,
	[49] = (select dbo.fn_formatea_texto(4,null,(case when dias_maximo_ven < 1000 then dias_maximo_ven else 999 end),null,'N','S'))
from #sb_reporte_buro_cuentas,
     cob_cartera..ca_operacion,
     sb_dato_operacion,
     #operacion_min_fecha, #desembolso_pago
where rb_operacion = op_operacion
and   op_banco     = do_banco
and   do_fecha     = @w_fecha_rep   
AND   do_aplicativo = 7
and   rb_operacion = operacion
AND   op_operacion = op

--por default
update #sb_reporte_buro_cuentas set
[26] = '0202'
where convert(money,[24]) <> 0 -- saldo vencido
and [26] ='0201' -- forma de pago 

                     
--/////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////
UPDATE #sb_reporte_buro_cuentas SET [12] = [12]/4*3
from sb_dato_operacion,
     #dividendos2
where [04] = di_banco
and   di_banco     = do_banco
and   do_fecha     = @w_fecha_rep   
AND   di_vigente   = 13

UPDATE #sb_reporte_buro_cuentas SET [12] = convert(bigint,(round(isnull(do_saldo_total_Vencido,0)* 4,@w_redondeo))*@w_multiplicador)
from sb_dato_operacion,
     #dividendos2
where [04] = di_banco
and   di_banco     = do_banco
and   do_fecha     = @w_fecha_rep   
AND   do_num_cuotaven > 4


---ACTUALIZACION DE CLAVE 20 A LC DE ACUERDO A REQUERIMIENTO 154017 MODIFICACIONES PGAD

select s.* into #sb_reporte_buro_cuentas2
from  #sb_reporte_buro_cuentas s, #abonos_con
where [04] = banco 

CREATE CLUSTERED INDEX idx_reporte_buro ON #sb_reporte_buro_cuentas2(rb_operacion,[04])
CREATE INDEX idx_repor_cl ON #sb_reporte_buro_cuentas2(rb_ente)
CREATE INDEX idx_repor_lc ON #sb_reporte_buro_cuentas2([30])
---ACTUALIZACION A LOS VALORES PARA CUANDO ES CONDONADO EN LA COPIA DE BURO CUENTAS 

update #sb_reporte_buro_cuentas2 set 
[30] = '30'+ dbo.fn_formatea_texto(2,'LC',null,'N','S','S'),
[24] = convert(bigint,(round(isnull(ceiling(monto_con),0),@w_redondeo))*@w_multiplicador) ,
[26] = dbo.fn_formatea_texto(2,'97',null,null,'N','S'),
[12] = convert(bigint,(round(isnull(ceiling(0),0),@w_redondeo))*@w_multiplicador),
[16] ='16' + dbo.fn_formatea_texto(8,replace(convert(varchar(10),fecha_can,103),'/',''),null,'S','S','S'),
fecha_cierre = fecha_can_date,
[22] = convert(bigint,(round(isnull(ceiling(0),0),@w_redondeo))*@w_multiplicador) 
from #abonos_con where 
[04] = banco

---/////////////////////////////////////////////////////////////
---/////////////////////////////////////////////////////////////

--===================================================
-- Tomar Fecha de Primer Incumplimiento
--===================================================
select ' Fecha de Primer Incumplimiento 0', getdate()

select d_banco = banco, d_fecha = min(do_fecha)
into #operaciones_al_dia
from  @w_fecha_fin_mes,
#operacion_min_fecha,
sb_dato_operacion 
where do_fecha     = fecha
and  do_banco      = banco 
and  dias_maximo_ven = 0
and  do_dias_mora_365 > 0 
and do_aplicativo  = 7 
group by banco

select ' Fecha de Primer Incumplimiento 1', getdate()

update #operacion_min_fecha set 
vencidas = 'N',
fecha_min_ven   = case when do_dias_mora_365>= 1 then
                        dateadd(dd,1-do_dias_mora_365,do_fecha)
                  else 
                              '01/01/1900'
                  end
from #operaciones_al_dia,
sb_dato_operacion
where do_fecha = d_fecha
and   do_banco = d_banco 
and   banco    = d_banco

select ' Fecha de Primer Incumplimiento 2', getdate()

 -- fecha de primer incumplimiento
update #sb_reporte_buro_cuentas2 set 
[43] = case when (fecha_min_ven <> '01/01/1900')
            then 
                 dbo.fn_formatea_texto(8,
                  isnull(
                  (replace(convert(varchar(10),fecha_min_ven,103),'/','')
                  ),'01011900')
                  ,null,null,'N','S')
             else
                 dbo.fn_formatea_texto(8,'01011900',null,null,'N','S') 
             end
from #operacion_min_fecha
where banco = [04]

select ' Fecha de Primer Incumplimiento 3', getdate()

update #sb_reporte_buro_cuentas set 
[43] = case when (fecha_min_ven <> '01/01/1900')
            then 
                 dbo.fn_formatea_texto(8,
                  isnull(
                  (replace(convert(varchar(10),fecha_min_ven,103),'/','')
                  ),'01011900')
                  ,null,null,'N','S')
             else
                 dbo.fn_formatea_texto(8,'01011900',null,null,'N','S') 
             end
from #operacion_min_fecha
where banco = [04]

select ' Fecha de Primer Incumplimiento 4', getdate()

--===================================================
--===================================================
update #sb_reporte_buro_cuentas2 set 
[43] = case when (fecha_cierre <> '01/01/1900')
            then 
                 dbo.fn_formatea_texto(8,
                  isnull(
                  (replace(convert(varchar(10),fecha_cierre,103),'/','')
                  ),'01011900')
                  ,null,null,'N','S')             
             end
where fecha_cierre < fecha_primer_at
and   fecha_cierre <> '01/01/1900'
and   fecha_primer_at <> '01/01/1900'
and   fecha_cierre is not null

select ' Fecha de Primer Incumplimiento 5', getdate()

update #sb_reporte_buro_cuentas2 set 
[44] = dbo.fn_formatea_texto(10,null,(
                convert(bigint,(round(isnull(ceiling(saldo),0),@w_redondeo))*@w_multiplicador)
                ),null,'N','S')
where isnull(saldo,0) < isnull(saldo_cap,0)
and   isnull(saldo,0) > 0
and   isnull(saldo_cap,0) > 0

select ' Fecha de Primer Incumplimiento 6', getdate()

update #sb_reporte_buro_cuentas2 set 
[12 ] = dbo.fn_formatea_texto(10,null,(
                convert(bigint,(round(isnull(ceiling(saldo),0),@w_redondeo))*@w_multiplicador)
                ),null,'N','S')
where isnull(saldo,0) < isnull(monto_pagar,0)
and   isnull(saldo,0) > 0
and   isnull(monto_pagar,0) > 0

select ' Fecha de Primer Incumplimiento 7', getdate()

update #sb_reporte_buro_cuentas set 
[43] = case when (fecha_cierre <> '01/01/1900')
            then 
                 dbo.fn_formatea_texto(8,
                  isnull(
                  (replace(convert(varchar(10),fecha_cierre,103),'/','')
                  ),'01011900')
                  ,null,null,'N','S')             
             end
where fecha_cierre < fecha_primer_at
and   fecha_cierre <> '01/01/1900'
and   fecha_primer_at <> '01/01/1900'
and   fecha_cierre is not null

select ' Fecha de Primer Incumplimiento 8', getdate()

update #sb_reporte_buro_cuentas set 
[44] = dbo.fn_formatea_texto(10,null,(
                convert(bigint,(round(isnull(ceiling(saldo),0),@w_redondeo))*@w_multiplicador)
                ),null,'N','S')
where isnull(saldo,0) < isnull(saldo_cap,0)
and   isnull(saldo,0) > 0
and   isnull(saldo_cap,0) > 0

select ' Fecha de Primer Incumplimiento 9', getdate()

update #sb_reporte_buro_cuentas set 
[12 ] = dbo.fn_formatea_texto(10,null,(
                convert(bigint,(round(isnull(ceiling(saldo),0),@w_redondeo))*@w_multiplicador)
                ),null,'N','S')
where isnull(saldo,0) < isnull(monto_pagar,0)
and   isnull(saldo,0) > 0
and   isnull(monto_pagar,0) > 0

select ' Fecha de Primer Incumplimiento 10', getdate()

--/////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////

  -- ------------------------------------------------------------------------------------
  -- SECCION DE DATOS DE CLIENTE
  -- ------------------------------------------------------------------------------------
CREATE TABLE #sb_buro_cliente
(
	bc_en_ente       INT,
	bc_p_apellido    VARCHAR (31),
	bc_s_apellido    VARCHAR (31),
	bc_ad_apellido   VARCHAR (31),
	bc_en_nombre     VARCHAR (31),
	bc_s_nombre      VARCHAR (31),
	bc_fecha_nac     VARCHAR (13),
	bc_en_rfc        VARCHAR (18),
	bc_pref_pers     VARCHAR (9),
	bc_suf_pers      VARCHAR (9),
	bc_nacionalidad  VARCHAR (7),
	bc_tresidencia   VARCHAR (6),
	bc_lic_conducir  VARCHAR (25),
	bc_ecivil        VARCHAR (6),
	bc_sexo          VARCHAR (6),
	bc_seg_social    VARCHAR (25),
	bc_reg_electoral VARCHAR (25),
	bc_iden_unica    VARCHAR (25),
	bc_clave_pais    VARCHAR (7),
	bc_num_depend    VARCHAR (7),
	bc_edades_dep    VARCHAR (35),
	bc_fec_defuncion VARCHAR (13),
	bc_ind_defuncion VARCHAR (6)
)

CREATE CLUSTERED INDEX sb_buro_cliente_fk
ON #sb_buro_cliente (bc_en_ente)

insert into #sb_buro_cliente(
     --bc_ad_apellido, bc_fec_defuncion
     bc_en_ente      , bc_p_apellido  , bc_s_apellido     , bc_en_nombre  , bc_s_nombre      ,
     bc_fecha_nac    , bc_en_rfc        , --bc_pref_pers  , bc_suf_pers      , 
	 bc_nacionalidad , --bc_tresidencia   , bc_lic_conducir , 
	 bc_ecivil       , bc_sexo         , --bc_seg_social   , bc_reg_electoral, 
	 bc_iden_unica   , bc_clave_pais   , bc_num_depend     --, bc_edades_dep , bc_ind_defuncion
     )
     SELECT DISTINCT
            en_ente,
            -- PN - APELLIDO PATERNO
            'PN' + dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,replace(replace(replace(replace(replace(replace(p_p_apellido,' ','<>'),'><',''),'<>',' '), char(209), 'N'), char(241),'n'),'.',''),'AN'), null,'N','N','S'),
            -- 00 - APELLIDO MATERNO
            '00' + case isnull(p_s_apellido,'')
                   when '' then '16NO PROPORCIONADO'
                   else dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,replace(replace(replace(replace(replace(replace(p_s_apellido,' ','<>'),'><',''),'<>',' '), char(209), 'N'), char(241),'n'),'.',''),'A'), null,'N','N','S')
                   end,
            -- 01 - APELLIDO ADICIONAL(o) - PENDIENTE - Se comenta por ser campo Opcional
            --'01' + dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,'APELLIDO ADICIONAL','A'), null,'N','N'),
            -- 02 - PRIMER NOMBRE
            '02' + dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,replace(replace(replace(replace(replace(replace(en_nombre,' ','<>'),'><',''),'<>',' '), char(209), 'N'), char(241),'n'),'.',''),'AN'), null,'N','N','S'),
            -- 03 - SEGUNDO NOMBRE
            '03' + case p_s_nombre
                   when null then '00'
                   else dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,replace(replace(replace(replace(replace(replace(p_s_nombre,' ','<>'),'><',''),'<>',' '), char(209), 'N'), char(241),'n'),'.',''),'A'), null,'N','N','S')
                 end,
            -- 04 - FECHA DE NACIMIENTO (o)
            '04' + dbo.fn_formatea_texto(8, (replace(convert(varchar, p_fecha_nac, 103), '/', '')), null,'N','S','S'),
            -- 05 - RFC
            '05' + dbo.fn_formatea_texto(13, substring(ltrim(rtrim(en_rfc)),1,13), null,'N','N','S'),
            '08' + dbo.fn_formatea_texto(2,
                             isnull((select upper(eq_descripcion) from @w_CL_PAIS_A6 where eq_valor_cat = en_nacionalidad),'MX'),
                             null, 'N', 'S','S'),
            '11' + dbo.fn_formatea_texto(1,
                             (select upper(eq_valor_arch )
                               from @w_CL_ECIVIL where eq_valor_cat = p_estado_civil),
                             null, 'N', 'S','S'),
            -- 12 - SEXO
            '12' + dbo.fn_formatea_texto(1, p_sexo, null,'N','S','S'),
            -- 15 - CLAVE DE IDENTIFICACION UNICA (CURP EN MEXICO)
            '15' + dbo.fn_formatea_texto(20, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,en_ced_ruc,'AN'), null,'N','N','S'),
            -- 16 - CLAVE DE PAIS
            '16' + dbo.fn_formatea_texto(2,
                             (select upper(eq_descripcion) from @w_CL_PAIS_A6 where eq_valor_cat = en_nacionalidad),
                             null, 'N', 'S','S'),
            -- 17 - NUMERO DE DEPENDIENTES
            case
                    when p_num_cargas is null or p_num_cargas = 0 then ''
                    when p_num_cargas > 15     then '17' + dbo.fn_formatea_texto(2,null,15,'N','S','S')
                    else '17' + dbo.fn_formatea_texto(2,right('00' + convert(varchar,isnull(p_num_cargas,0)),2),null,'N','S','S')
            end
  from cobis..cl_ente, #sb_reporte_buro_cuentas
  where en_ente = rb_ente
  AND en_rfc IS NOT NULL
  ORDER BY en_ente
  
  if @@error <> 0
  begin
     select @w_msg = 'ERROR EN INSERCION SB_BURO_CLIENTE'
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '70011011',
     @i_descrp_error  = @w_msg
  end


  -- ------------------------------------------------------------------------------------
  -- FIN SECCION DE DATOS DE CLIENTE
  -- ------------------------------------------------------------------------------------

  -- ------------------------------------------------------------------------------------
  -- INICIO SECCION DIRECCION DE CLIENTE
  -- ------------------------------------------------------------------------------------
CREATE TABLE #sb_buro_direccion(
	bd_di_ente     INT,
	bd_pri_linea   VARCHAR (60),
	bd_seg_linea   VARCHAR (60),
	bd_colonia     VARCHAR (60),
	bd_delegacion  VARCHAR (60),
	bd_ciudad      VARCHAR (60),
	bd_estado      VARCHAR (20),
	bd_cod_postal  VARCHAR (20),
	bd_fec_reside  VARCHAR (23),
	bd_num_telf    VARCHAR (30),
	bd_ext_telf    VARCHAR (30),
	bd_num_fax     VARCHAR (30),
	bd_tdomicilio  VARCHAR (10),
	bd_ind_esp_dom VARCHAR (10),
	bd_org_dom     VARCHAR (10),
	bd_direccion   int 
)

CREATE CLUSTERED INDEX sb_buro_direccion_fk
ON #sb_buro_direccion (bd_di_ente)

  --MTA
  select 'max_fecha' = max(di_fecha_modificacion), 'ente' = di_ente, 'tipo' = di_tipo
  into #dir_max_tmp_1 
  from cobis..cl_direccion d2, #sb_buro_cliente
  WHERE di_ente = bc_en_ente
  AND di_tipo in('AE', 'RE')
  group by di_ente, di_tipo
  ORDER by di_ente, di_tipo
  
  CREATE CLUSTERED INDEX idx_dir_max ON #dir_max_tmp_1(ente)
  
  select di_ente, di_direccion, di_tipo, di_fecha_modificacion
  into #tmp_direccion_aux
  from cobis..cl_direccion d1, #dir_max_tmp_1, #sb_buro_cliente
  where d1.di_ente = bc_en_ente
  and d1.di_tipo = 'RE'
  and d1.di_fecha_modificacion = max_fecha
  and d1.di_ente = ente
  and d1.di_tipo = tipo
  ORDER BY di_ente
  
  CREATE CLUSTERED INDEX idx_dir_aux ON #tmp_direccion_aux(di_ente)
  
  -- DIRECCIONES FALTANTES - Clientes que no tienen direccion tipo RE -- Error.191254 
  select di_ente, di_direccion, di_tipo = 'RE', di_fecha_modificacion   
  into #tmp_direccion_aux_falt
  from cobis..cl_direccion d1, #dir_max_tmp_1, #sb_buro_cliente
  where d1.di_ente = bc_en_ente
  and d1.di_tipo = 'AE'
  and d1.di_fecha_modificacion = max_fecha
  and d1.di_ente = ente
  and d1.di_tipo = tipo
  and not exists (select 1 from #tmp_direccion_aux d2 where d1.di_ente = d2.di_ente)
  order by di_ente
  
  insert into #tmp_direccion_aux 
  select * from #tmp_direccion_aux_falt
  
  select @w_error = 70011020
  select @w_msg = mensaje from cobis..cl_errores where numero = @w_error -- CLIENTE NO CUENTA CON DIRECCION DE DOMICILIO
  insert into cob_conta_super..sb_errorlog
        (er_fecha,  er_fecha_proc, er_fuente,        er_origen_error, er_descrp_error)
  select @i_param1, getdate(),     'sp_genera_buro', @w_error,      convert(varchar,di_ente) + ' - ' + @w_msg
  from #tmp_direccion_aux_falt
  ---
   
  --MTA
  select 'max_fecha' = max(di_direccion), 'ente' = di_ente
  into #dir_max_tmp_2
  from #tmp_direccion_aux
  group by di_ente
  ORDER BY di_ente
  
  CREATE CLUSTERED INDEX idx_dir_max_t2 ON #dir_max_tmp_2(ente)
    
  select d1.*
  into #tmp_direccion
  from cobis..cl_direccion d1, #dir_max_tmp_2, #sb_buro_cliente
  where d1.di_ente = bc_en_ente
  and d1.di_direccion = max_fecha
  and d1.di_ente = ente
  ORDER BY ente
                      
  update  #tmp_direccion  
  set     di_nro = null                 
  where   di_nro = 0                  
                      
  update  #tmp_direccion  
  set     di_nro = null                 
  where   isnumeric (di_nro) = 0   
  
  update  #tmp_direccion
  set     di_calle=replace(replace(replace(di_calle,' ','<>'),'><',''),'<>',' ')
                       
  update  #tmp_direccion
  set     di_calle=replace(replace(replace(di_calle,' SN','<>'),'><',''),'<>',' ')
  
  CREATE CLUSTERED INDEX idx_tmp_dir ON #tmp_direccion(di_ente)
  


   
  insert into #sb_buro_direccion(
  bd_di_ente    , bd_pri_linea  , bd_seg_linea  , 
  bd_colonia    , bd_delegacion , bd_ciudad     ,
  bd_estado     , bd_cod_postal , bd_fec_reside , bd_num_telf   , bd_ext_telf   , bd_num_fax    ,
  bd_tdomicilio , bd_ind_esp_dom, bd_org_dom , bd_direccion
  )
  select  di_ente,-- @w_seg_dir_cli =
       -- PA - PRIMER LINEA DE DIRECCION   
       'PA' + dbo.fn_formatea_texto(40,
                 (  dbo.fn_formatea_ascii_ext_1(@w_equivalencias,
                       case
                          when len(rtrim(ltrim(isnull(ltrim(rtrim(di_calle)),'') + ' ' + isnull(ltrim(rtrim(convert(VARCHAR(255), di_nro ))),'SN')))) <= 40 then
                             rtrim(ltrim(isnull(ltrim(rtrim(di_calle)),''))) + ' ' + isnull(rtrim(ltrim(convert(VARCHAR(255),di_nro))),'SN')
                          else
                             substring(rtrim(ltrim(isnull(rtrim(ltrim(di_calle)),'') + ' ' + isnull(rtrim(ltrim(convert(VARCHAR(255),di_nro))),'SN'))),1,40)
                       end,'AN')),
                 null, 'N', 'N','S'),								
       -- 00 - SEGUNDA LINEA DE DIRECCION
        case when len(rtrim(ltrim(isnull(rtrim(ltrim(di_calle)),'') + ' ' +isnull(rtrim(ltrim(convert(VARCHAR(255),di_nro))),'SN')))) > 40 then
           '00' + dbo.fn_formatea_texto(40, (
                      dbo.fn_formatea_ascii_ext_1(@w_equivalencias,
                  substring(rtrim(ltrim(isnull(rtrim(ltrim(di_calle)),'') + ' ' +isnull(rtrim(ltrim(convert(VARCHAR(255),di_nro))),'SN'))),41,80),
                  'AN' )),
                  null, 'N', 'N','S')
                 ELSE ''
                 end,
       -- 01 - COLONIA O POBLACION
       '01' + dbo.fn_formatea_texto(40,
                 dbo.fn_formatea_ascii_ext_1(@w_equivalencias,(select replace(replace(substring(pq_descripcion,1,40),'( ','('),' )',')') from @w_cl_parroquia where pq_parroquia = di_parroquia), 'AN' ),
                 null, 'N', 'N','S'),
       -- 02 - DELEGACION O MUNICIPIO
       '02' + ltrim(rtrim(dbo.fn_formatea_texto(40,
                 dbo.fn_formatea_ascii_ext_1(@w_equivalencias,(select substring(ci_descripcion,1,40) from @w_cl_ciudad where ci_ciudad = di_ciudad),'AN' ),
                 null,'N', 'N','S'))),
       -- 03 - CIUDAD
       '03' + dbo.fn_formatea_texto(40,
                 dbo.fn_formatea_ascii_ext_1(@w_equivalencias,(''),'AN' ),
                 null,'N','N','S'),
       -- 04 - ESTADO
       '04' + dbo.fn_formatea_texto(4,
                 (select upper(rtrim(ltrim(eq_valor_arch)))
                    from @w_ESTADOS_A7 where  eq_valor_cat = di_provincia ),
                 null, 'N', 'N','S'),
       -- 05 - CODIGO POSTAL
       '05' + dbo.fn_formatea_texto(5,
                 (select case
                           when eq_descripcion != 'MX' and di_codpostal is null then '00000'
                           else di_codpostal
                         end
                    from @w_CL_PAIS_A6 where eq_valor_cat = di_pais),null,'N','S','S'),
        /*
       -- 06 - FECHA DE RESIDENCIA - PENDIENTE
       '06' + dbo.fn_formatea_texto(8, (replace(convert(varchar, (select fp_fecha from cobis..ba_fecha_proceso), 103), '/', '')), null,'N','S','S'),
       */-- 07 - NUMERO DE TELEFONO
   
      /* -- 08 - EXTENSION TELEFONICA - PENDIENTE
       '08' + dbo.fn_formatea_texto(8,
                 (select te_valor from cobis..cl_telefono
                   where te_tipo_telefono = @w_tipo_telef
                     and te_ente = di_ente and te_direccion = di_direccion
                     and te_secuencial = 1),
                 null, 'N', 'N','S'),
       -- 09 - NUMERO DE FAX EN ESTA DIRECCION - PENDIENTE
       '09' + dbo.fn_formatea_texto(8,
                 (select te_valor from cobis..cl_telefono
                   where te_tipo_telefono = @w_tipo_telef
                     and te_ente = di_ente
                     and te_direccion = di_direccion
                     and te_secuencial = 1 ),
                 null, 'N', 'N','S'),
       -- 10 - TIPO DE DOMICILIO - PENDIENTE
       '10' + dbo.fn_formatea_texto(1, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,'C','A'), null,'N','S','S'),
       -- 11 - INDICADOR ESPECIAL DE DOMICILIO - PENDIENTE
       '11' + dbo.fn_formatea_texto(1, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,'R','A'), null,'N','S','S'),
       */
       '', -- 06
	   ---TELEFONO CEL 
       '',--07
       '', -- 08
       '', -- 09
       '', -- 10
       '', -- 11
       -- 12 - ORIGEN DEL DOMICILIO (PAIS)
       '12' + dbo.fn_formatea_texto(2,
                 (select eq_descripcion from @w_CL_PAIS_A6 where eq_valor_cat = di_pais),
                 null, 'N', 'S','S'),
	   null 			 
  from #tmp_direccion
  ORDER BY di_ente
  
  if @@error <> 0
  begin
     select @w_msg = 'ERROR EN INSERCION SB_BURO_DIRECCION'
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '70011012',
     @i_descrp_error  = @w_msg
  end
  
  select 
  ente      = te_ente, 
  direccion = max(te_direccion) 
  into #max_direcciones_cel
  from cobis..cl_telefono, #sb_buro_direccion
  where te_tipo_telefono = 'C'
  and te_ente = bd_di_ente
  group by te_ente
  
  update #sb_buro_direccion set 
  bd_direccion =direccion
  from #max_direcciones_cel
  where bd_di_ente =ente 
  
  if @@error <> 0
  begin
     select @w_msg = 'ERROR EN INSERCION SB_BURO_DIRECCION'
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '70011012',
     @i_descrp_error  = @w_msg
  end
  
  
  update #sb_buro_direccion set 
  bd_num_telf = '07' + dbo.fn_formatea_texto(11,te_valor ,null, 'N', 'N','S')
  from cobis..cl_telefono ,#sb_buro_direccion 
  where te_tipo_telefono = 'C'
  and te_ente = bd_di_ente
  and te_direccion = bd_direccion
  
  if @@error <> 0
  begin
     select @w_msg = 'ERROR EN INSERCION SB_BURO_DIRECCION'
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '70011012',
     @i_descrp_error  = @w_msg
  end



  -- ------------------------------------------------------------------------------------
  -- FIN SECCION DIRECCION DE CLIENTE
  -- ------------------------------------------------------------------------------------

  -- ------------------------------------------------------------------------------------
  -- INICIO SECCION EMPLEO DE CLIENTE
  -- ------------------------------------------------------------------------------------
CREATE TABLE #sb_buro_empleo
(
	be_ente         INT,
	be_raz_social   VARCHAR (104),
	be_pri_linea    VARCHAR (60),
	be_seg_linea    VARCHAR (60),
	be_colonia      VARCHAR (60),
	be_delegacion   VARCHAR (60),
	be_ciudad       VARCHAR (60),
	be_estado       VARCHAR (20),
	be_cod_postal   VARCHAR (20),
	be_num_telf     VARCHAR (30),
	be_ext_telf     VARCHAR (30),
	be_num_fax      VARCHAR (30),
	be_ocupacion    VARCHAR (60),
	be_fecha_contra VARCHAR (20),
	be_moneda       VARCHAR (20),
	be_sueldo       VARCHAR (20),
	be_frec_pago    VARCHAR (10),
	be_num_empl     VARCHAR (20),
	be_ult_dia_empl VARCHAR (20),
	be_verif_empl   VARCHAR (20),
	be_origen       VARCHAR (20)
)

CREATE CLUSTERED INDEX sb_buro_direccion_fk
ON #sb_buro_empleo (be_ente)
   
  select di_ente, di_direccion, di_tipo, di_fecha_modificacion
  into #tmp_direccion_empleo_max
  from cobis..cl_direccion d1, #dir_max_tmp_1, #sb_buro_cliente
  where d1.di_ente = bc_en_ente
  and d1.di_tipo = 'AE'
  and di_fecha_modificacion = max_fecha
  and d1.di_ente = ente
  and d1.di_tipo = tipo
  ORDER BY di_ente
  
  CREATE CLUSTERED INDEX idx_tmp_dir_emp_max ON #tmp_direccion_empleo_max(di_ente)
  
  --MTA
  select 'max_fecha' = max(di_direccion), 'ente' = di_ente
  into #dir_max_tmp_3
  from #tmp_direccion_empleo_max
  group by di_ente
  ORDER BY di_ente
  
  CREATE CLUSTERED INDEX idx_dir_max_tmp3 ON #dir_max_tmp_3(ente)
  
  select d1.*
  into #tmp_direccion_empleo
  from cobis..cl_direccion d1, #dir_max_tmp_3, #sb_buro_cliente
  where d1.di_ente = bc_en_ente
  and d1.di_direccion = max_fecha 
  and d1.di_ente = ente
  ORDER BY d1.di_ente
  
  CREATE CLUSTERED INDEX idx_tmp_dir_emp ON #tmp_direccion_empleo(di_ente)
  
  update  #tmp_direccion_empleo  
  set     di_nro = null                 
  where   di_nro = 0                  
                      
  update  #tmp_direccion_empleo  
  set     di_nro = null                 
  where   isnumeric (di_nro) = 0                         
  
  update  #tmp_direccion_empleo
  set     di_calle=replace(replace(replace(di_calle,' ','<>'),'><',''),'<>',' ')
  
  update  #tmp_direccion_empleo
  set     di_calle=replace(replace(replace(di_calle,' SN','<>'),'><',''),'<>',' ')
   
  --SI NO TIENE DIRECCION DE EMPLEO LE COLOCO POR DEFECTO EL DEL DOMICILIO
  insert into #tmp_direccion_empleo
  select * from #tmp_direccion
  where di_ente not in (select di_ente from #tmp_direccion_empleo)
  ORDER BY di_ente

  insert into #sb_buro_empleo(
     be_ente     ,  be_raz_social     ,  be_pri_linea   ,  be_seg_linea   ,  be_colonia  ,  be_delegacion  ,
     --be_ciudad   ,  
     be_estado         ,  be_cod_postal, -- be_num_telf    ,  be_ext_telf ,  be_num_fax     ,
     --be_ocupacion,  be_fecha_contra   ,  be_moneda      ,  be_sueldo      ,  be_frec_pago,  be_num_empl    ,
     --be_ult_dia_empl,  be_verif_empl  ,  
	 be_origen)
  select  di_ente,
       -- PE - NOMBRE DEL EMPLEADOR
       'PE' + dbo.fn_formatea_texto(99, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,'TRABAJADOR INDEPENDIENTE','AN'), null,'N','N','S'),
       -- 00 - PRIMERA LINEA DE DIRECCION
       '00' + dbo.fn_formatea_texto(40,
                 (  dbo.fn_formatea_ascii_ext_1(@w_equivalencias,
                       case
                          when len(rtrim(ltrim(isnull(rtrim(ltrim(di_calle)),'') + ' ' + isnull(ltrim(rtrim(convert(VARCHAR(255),di_nro))),'SN')))) <= 40 then
                             rtrim(ltrim(isnull(rtrim(ltrim(di_calle)),''))) + ' ' + isnull(rtrim(ltrim(convert(VARCHAR(255),di_nro))),'SN')
                          else
                             substring(rtrim(ltrim(isnull(rtrim(ltrim(di_calle)),'') +' '+ isnull(rtrim(ltrim(convert(VARCHAR(255),di_nro))),'SN'))),1,40)
                       end,'AN')),
                 null, 'N', 'N','S'),								
       -- 01 - SEGUNDA LINEA DE DIRECCION
        case when len(rtrim(ltrim(isnull(ltrim(rtrim(di_calle)),'') + ' ' + isnull(convert(VARCHAR(255),di_nro),'SN')))) > 40 then
           '01' + dbo.fn_formatea_texto(40, (
                      dbo.fn_formatea_ascii_ext_1(@w_equivalencias,
                  substring(rtrim(ltrim(isnull(rtrim(ltrim(di_calle)),'') + ' ' + isnull(rtrim(ltrim(convert(VARCHAR(255),di_nro))),'SN'))),41,80),
                  'AN' )),
                  null, 'N', 'N','S')
                 ELSE ''
                 end,      
       -- 02 - COLONIA O POBLACION
       '02' + dbo.fn_formatea_texto(40,
                 dbo.fn_formatea_ascii_ext_1(@w_equivalencias,(select replace(replace(substring(pq_descripcion,1,40),'( ','('),' )',')') from @w_cl_parroquia where pq_parroquia = di_parroquia), 'AN' ),
                 null, 'N', 'N','S'),
	  
       -- 03 - DELEGACION O MUNICIPIO
       '03' + ltrim(rtrim(dbo.fn_formatea_texto(40,
                 dbo.fn_formatea_ascii_ext_1(@w_equivalencias,(select substring(ci_descripcion,1,40) from @w_cl_ciudad where ci_ciudad = di_ciudad),'AN' ),
                 null,'N', 'N','S'))),
       -- 04 - CIUDAD
      /* '04' + dbo.fn_formatea_texto(40,
                 dbo.fn_formatea_ascii_ext_1(@w_equivalencias,(select ci_descripcion from cobis..cl_ciudad where ci_ciudad = di_ciudad),'AN' ),
                 null,'N','N','S'),*/
       -- 05 - ESTADO
       '05' + dbo.fn_formatea_texto(4,
                 (select upper(rtrim(ltrim(eq_valor_arch)))
                    from @w_ESTADOS_A7 where eq_valor_cat = di_provincia ),
                 null, 'N', 'N','S'),
       -- 06 - CODIGO POSTAL
       '06' + dbo.fn_formatea_texto(5,
                 (select case
                           when eq_descripcion != 'MX' and di_codpostal is null then '00000'
                           else isnull(di_codpostal,'')
                         end
                    from @w_CL_PAIS_A6 WHERE eq_valor_cat = di_pais),
                 null,'N','S','S'),
       -- 07 - NUMERO DE TELEFONO AL 17
       --'' ,
       -- 08 - EXTENSION TELEFONICA
       --'' ,
       -- 09 - NUMERO DE FAX EN ESTA DIRECCION
       --'' ,
       -- 10 - CARGO U OCUPACION
       --'' ,
       -- 11 - FECHA CONTRATACION
       --'' ,
       -- 12 - CLAVE DE LA MONEDA DE PAGO
       --'' ,
       -- 13 - MONTO SUELDO
       --'' ,
       -- 14 -  PERIODO DE PAGO
       --'' ,
       -- 15 - NUMERO DE EMPLEADO
       --'' ,
       -- 16 - FECHA DE ULTIMO DIA DE EMPLEO
       --'' ,
       -- 17 - FECHA DE VERIFICACION DE EMPLEO
       --'' ,
       -- 18 - ORIGEN DE LA RAZON SOCIAL
       '18' + dbo.fn_formatea_texto(2,'MX', null, 'N', 'S','S')
  from #tmp_direccion_empleo d1
  ORDER BY di_ente
  
  if @@error <> 0
  begin
     select @w_msg = 'ERROR EN INSERCION SB_BURO_EMPLEO'
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '70011014',
     @i_descrp_error  = @w_msg
  end
  
  -- ------------------------------------------------------------------------------------
  -- FIN SECCION EMPLEO DE CLIENTE
  -- ------------------------------------------------------------------------------------

  -- ------------------------------------------------------------------------------------
  -- SECCION DE DATOS DE CLIENTE 2 -- Error.191254
  -- ------------------------------------------------------------------------------------
CREATE TABLE #sb_buro_cliente2
(
	bc_en_ente       INT,
	bc_p_apellido    VARCHAR (31),
	bc_s_apellido    VARCHAR (31),
	bc_ad_apellido   VARCHAR (31),
	bc_en_nombre     VARCHAR (31),
	bc_s_nombre      VARCHAR (31),
	bc_fecha_nac     VARCHAR (13),
	bc_en_rfc        VARCHAR (18),
	bc_pref_pers     VARCHAR (9),
	bc_suf_pers      VARCHAR (9),
	bc_nacionalidad  VARCHAR (7),
	bc_tresidencia   VARCHAR (6),
	bc_lic_conducir  VARCHAR (25),
	bc_ecivil        VARCHAR (6),
	bc_sexo          VARCHAR (6),
	bc_seg_social    VARCHAR (25),
	bc_reg_electoral VARCHAR (25),
	bc_iden_unica    VARCHAR (25),
	bc_clave_pais    VARCHAR (7),
	bc_num_depend    VARCHAR (7),
	bc_edades_dep    VARCHAR (35),
	bc_fec_defuncion VARCHAR (13),
	bc_ind_defuncion VARCHAR (6)
)

CREATE CLUSTERED INDEX sb_buro_cliente2_fk
ON #sb_buro_cliente2 (bc_en_ente)

insert into #sb_buro_cliente2(
     --bc_ad_apellido, bc_fec_defuncion
     bc_en_ente      , bc_p_apellido  , bc_s_apellido     , bc_en_nombre  , bc_s_nombre      ,
     bc_fecha_nac    , bc_en_rfc        , --bc_pref_pers  , bc_suf_pers      , 
	 bc_nacionalidad , --bc_tresidencia   , bc_lic_conducir , 
	 bc_ecivil       , bc_sexo         , --bc_seg_social   , bc_reg_electoral, 
	 bc_iden_unica   , bc_clave_pais   , bc_num_depend     --, bc_edades_dep , bc_ind_defuncion
     )
     SELECT DISTINCT
            en_ente,
            -- PN - APELLIDO PATERNO
            'PN' + dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,replace(replace(replace(replace(replace(replace(p_p_apellido,' ','<>'),'><',''),'<>',' '), char(209), 'N'), char(241),'n'),'.',''),'AN'), null,'N','N','S'),
            -- 00 - APELLIDO MATERNO
            '00' + case isnull(p_s_apellido,'')
                   when '' then '16NO PROPORCIONADO'
                   else dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,replace(replace(replace(replace(replace(replace(p_s_apellido,' ','<>'),'><',''),'<>',' '), char(209), 'N'), char(241),'n'),'.',''),'A'), null,'N','N','S')
                   end,
            -- 01 - APELLIDO ADICIONAL(o) - PENDIENTE - Se comenta por ser campo Opcional
            --'01' + dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,'APELLIDO ADICIONAL','A'), null,'N','N'),
            -- 02 - PRIMER NOMBRE
            '02' + dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,replace(replace(replace(replace(replace(replace(en_nombre,' ','<>'),'><',''),'<>',' '), char(209), 'N'), char(241),'n'),'.',''),'AN'), null,'N','N','S'),
            -- 03 - SEGUNDO NOMBRE
            '03' + case p_s_nombre
                   when null then '00'
                   else dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,replace(replace(replace(replace(replace(replace(p_s_nombre,' ','<>'),'><',''),'<>',' '), char(209), 'N'), char(241),'n'),'.',''),'A'), null,'N','N','S')
                 end,
            -- 04 - FECHA DE NACIMIENTO (o)
            '04' + dbo.fn_formatea_texto(8, (replace(convert(varchar, p_fecha_nac, 103), '/', '')), null,'N','S','S'),
            -- 05 - RFC
            '05' + dbo.fn_formatea_texto(13, substring(ltrim(rtrim(en_rfc)),1,13), null,'N','N','S'),
            '08' + dbo.fn_formatea_texto(2,
                             isnull((select upper(eq_descripcion) from @w_CL_PAIS_A6 where eq_valor_cat = en_nacionalidad),'MX'),
                             null, 'N', 'S','S'),
            '11' + dbo.fn_formatea_texto(1,
                             (select upper(eq_valor_arch )
                               from @w_CL_ECIVIL where eq_valor_cat = p_estado_civil),
                             null, 'N', 'S','S'),
            -- 12 - SEXO
            '12' + dbo.fn_formatea_texto(1, p_sexo, null,'N','S','S'),
            -- 15 - CLAVE DE IDENTIFICACION UNICA (CURP EN MEXICO)
            '15' + dbo.fn_formatea_texto(20, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,en_ced_ruc,'AN'), null,'N','N','S'),
            -- 16 - CLAVE DE PAIS
            '16' + dbo.fn_formatea_texto(2,
                             (select upper(eq_descripcion) from @w_CL_PAIS_A6 where eq_valor_cat = en_nacionalidad),
                             null, 'N', 'S','S'),
            -- 17 - NUMERO DE DEPENDIENTES
            case
                    when p_num_cargas is null or p_num_cargas = 0 then ''
                    when p_num_cargas > 15     then '17' + dbo.fn_formatea_texto(2,null,15,'N','S','S')
                    else '17' + dbo.fn_formatea_texto(2,right('00' + convert(varchar,isnull(p_num_cargas,0)),2),null,'N','S','S')
            end
  from cobis..cl_ente, #sb_reporte_buro_cuentas2
  where en_ente = rb_ente
  AND en_rfc IS NOT NULL
  ORDER BY en_ente
  
  if @@error <> 0
  begin
     select @w_msg = 'ERROR EN INSERCION SB_BURO_CLIENTE 2'
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '70011011',
     @i_descrp_error  = @w_msg
  end


  -- ------------------------------------------------------------------------------------
  -- FIN SECCION DE DATOS DE CLIENTE 2
  -- ------------------------------------------------------------------------------------

  -- ------------------------------------------------------------------------------------
  -- INICIO SECCION DIRECCION DE CLIENTE 2 -- Error.191254
  -- ------------------------------------------------------------------------------------
CREATE TABLE #sb_buro_direccion2(
	bd_di_ente     INT,
	bd_pri_linea   VARCHAR (60),
	bd_seg_linea   VARCHAR (60),
	bd_colonia     VARCHAR (60),
	bd_delegacion  VARCHAR (60),
	bd_ciudad      VARCHAR (60),
	bd_estado      VARCHAR (20),
	bd_cod_postal  VARCHAR (20),
	bd_fec_reside  VARCHAR (23),
	bd_num_telf    VARCHAR (30),
	bd_ext_telf    VARCHAR (30),
	bd_num_fax     VARCHAR (30),
	bd_tdomicilio  VARCHAR (10),
	bd_ind_esp_dom VARCHAR (10),
	bd_org_dom     VARCHAR (10),
	bd_direccion   int 
)

CREATE CLUSTERED INDEX sb_buro_direccion2_fk
ON #sb_buro_direccion2 (bd_di_ente)

  --MTA
  select 'max_fecha' = max(di_fecha_modificacion), 'ente' = di_ente, 'tipo' = di_tipo
  into #dir2_max_tmp_1 
  from cobis..cl_direccion d2, #sb_buro_cliente2
  WHERE di_ente = bc_en_ente
  AND di_tipo in('AE', 'RE')
  group by di_ente, di_tipo
  ORDER by di_ente, di_tipo
  
  CREATE CLUSTERED INDEX idx_dir_max2 ON #dir2_max_tmp_1(ente)
  
  select di_ente, di_direccion, di_tipo, di_fecha_modificacion
  into #tmp_direccion_aux2
  from cobis..cl_direccion d1, #dir2_max_tmp_1, #sb_buro_cliente2
  where d1.di_ente = bc_en_ente
  and d1.di_tipo = 'RE'
  and d1.di_fecha_modificacion = max_fecha
  and d1.di_ente = ente
  and d1.di_tipo = tipo
  ORDER BY di_ente
  
  CREATE CLUSTERED INDEX idx_dir_aux2 ON #tmp_direccion_aux2(di_ente)
  
  -- DIRECCIONES FALTANTES - Clientes que no tienen direccion tipo RE  
  select di_ente, di_direccion, di_tipo = 'RE', di_fecha_modificacion   
  into #tmp_direccion_aux_falt2
  from cobis..cl_direccion d1, #dir2_max_tmp_1, #sb_buro_cliente2
  where d1.di_ente = bc_en_ente
  and d1.di_tipo = 'AE'
  and d1.di_fecha_modificacion = max_fecha
  and d1.di_ente = ente
  and d1.di_tipo = tipo
  and not exists (select 1 from #tmp_direccion_aux2 d2 where d1.di_ente = d2.di_ente)
  order by di_ente
  
  insert into #tmp_direccion_aux2 
  select * from #tmp_direccion_aux_falt2
  
  select @w_error = 70011020
  select @w_msg = mensaje from cobis..cl_errores where numero = @w_error -- CLIENTE NO CUENTA CON DIRECCION DE DOMICILIO
  insert into cob_conta_super..sb_errorlog
        (er_fecha,  er_fecha_proc, er_fuente,        er_origen_error, er_descrp_error)
  select @i_param1, getdate(),     'sp_genera_buro', @w_error,      convert(varchar,di_ente) + ' - ' + @w_msg
  from #tmp_direccion_aux_falt2
  ---
  
  --MTA
  select 'max_fecha' = max(di_direccion), 'ente' = di_ente
  into #dir2_max_tmp_2
  from #tmp_direccion_aux2
  group by di_ente
  ORDER BY di_ente
  
  CREATE CLUSTERED INDEX idx_dir2_max_t2 ON #dir2_max_tmp_2(ente)
    
  select d1.*
  into #tmp_direccion2
  from cobis..cl_direccion d1, #dir2_max_tmp_2, #sb_buro_cliente2
  where d1.di_ente = bc_en_ente
  and d1.di_direccion = max_fecha
  and d1.di_ente = ente
  ORDER BY ente
                      
  update  #tmp_direccion2  
  set     di_nro = null                 
  where   di_nro = 0                  
                      
  update  #tmp_direccion2  
  set     di_nro = null                 
  where   isnumeric (di_nro) = 0   
  
  update  #tmp_direccion2
  set     di_calle=replace(replace(replace(di_calle,' ','<>'),'><',''),'<>',' ')
                       
  update  #tmp_direccion2
  set     di_calle=replace(replace(replace(di_calle,' SN','<>'),'><',''),'<>',' ')
  
  CREATE CLUSTERED INDEX idx_tmp_dir2 ON #tmp_direccion2(di_ente)
  


   
  insert into #sb_buro_direccion2(
  bd_di_ente    , bd_pri_linea  , bd_seg_linea  , 
  bd_colonia    , bd_delegacion , bd_ciudad     ,
  bd_estado     , bd_cod_postal , bd_fec_reside , bd_num_telf   , bd_ext_telf   , bd_num_fax    ,
  bd_tdomicilio , bd_ind_esp_dom, bd_org_dom , bd_direccion
  )
  select  di_ente,-- @w_seg_dir_cli =
       -- PA - PRIMER LINEA DE DIRECCION   
       'PA' + dbo.fn_formatea_texto(40,
                 (  dbo.fn_formatea_ascii_ext_1(@w_equivalencias,
                       case
                          when len(rtrim(ltrim(isnull(ltrim(rtrim(di_calle)),'') + ' ' + isnull(ltrim(rtrim(convert(VARCHAR(255), di_nro ))),'SN')))) <= 40 then
                             rtrim(ltrim(isnull(ltrim(rtrim(di_calle)),''))) + ' ' + isnull(rtrim(ltrim(convert(VARCHAR(255),di_nro))),'SN')
                          else
                             substring(rtrim(ltrim(isnull(rtrim(ltrim(di_calle)),'') + ' ' + isnull(rtrim(ltrim(convert(VARCHAR(255),di_nro))),'SN'))),1,40)
                       end,'AN')),
                 null, 'N', 'N','S'),								
       -- 00 - SEGUNDA LINEA DE DIRECCION
        case when len(rtrim(ltrim(isnull(rtrim(ltrim(di_calle)),'') + ' ' +isnull(rtrim(ltrim(convert(VARCHAR(255),di_nro))),'SN')))) > 40 then
           '00' + dbo.fn_formatea_texto(40, (
                      dbo.fn_formatea_ascii_ext_1(@w_equivalencias,
                  substring(rtrim(ltrim(isnull(rtrim(ltrim(di_calle)),'') + ' ' +isnull(rtrim(ltrim(convert(VARCHAR(255),di_nro))),'SN'))),41,80),
                  'AN' )),
                  null, 'N', 'N','S')
                 ELSE ''
                 end,
       -- 01 - COLONIA O POBLACION
       '01' + dbo.fn_formatea_texto(40,
                 dbo.fn_formatea_ascii_ext_1(@w_equivalencias,(select replace(replace(substring(pq_descripcion,1,40),'( ','('),' )',')') from @w_cl_parroquia where pq_parroquia = di_parroquia), 'AN' ),
                 null, 'N', 'N','S'),
       -- 02 - DELEGACION O MUNICIPIO
       '02' + ltrim(rtrim(dbo.fn_formatea_texto(40,
                 dbo.fn_formatea_ascii_ext_1(@w_equivalencias,(select substring(ci_descripcion,1,40) from @w_cl_ciudad where ci_ciudad = di_ciudad),'AN' ),
                 null,'N', 'N','S'))),
       -- 03 - CIUDAD
       '03' + dbo.fn_formatea_texto(40,
                 dbo.fn_formatea_ascii_ext_1(@w_equivalencias,(''),'AN' ),
                 null,'N','N','S'),
       -- 04 - ESTADO
       '04' + dbo.fn_formatea_texto(4,
                 (select upper(rtrim(ltrim(eq_valor_arch)))
                    from @w_ESTADOS_A7 where  eq_valor_cat = di_provincia ),
                 null, 'N', 'N','S'),
       -- 05 - CODIGO POSTAL
       '05' + dbo.fn_formatea_texto(5,
                 (select case
                           when eq_descripcion != 'MX' and di_codpostal is null then '00000'
                           else di_codpostal
                         end
                    from @w_CL_PAIS_A6 where eq_valor_cat = di_pais),null,'N','S','S'),
        /*
       -- 06 - FECHA DE RESIDENCIA - PENDIENTE
       '06' + dbo.fn_formatea_texto(8, (replace(convert(varchar, (select fp_fecha from cobis..ba_fecha_proceso), 103), '/', '')), null,'N','S','S'),
       */-- 07 - NUMERO DE TELEFONO
   
      /* -- 08 - EXTENSION TELEFONICA - PENDIENTE
       '08' + dbo.fn_formatea_texto(8,
                 (select te_valor from cobis..cl_telefono
                   where te_tipo_telefono = @w_tipo_telef
                     and te_ente = di_ente and te_direccion = di_direccion
                     and te_secuencial = 1),
                 null, 'N', 'N','S'),
       -- 09 - NUMERO DE FAX EN ESTA DIRECCION - PENDIENTE
       '09' + dbo.fn_formatea_texto(8,
                 (select te_valor from cobis..cl_telefono
                   where te_tipo_telefono = @w_tipo_telef
                     and te_ente = di_ente
                     and te_direccion = di_direccion
                     and te_secuencial = 1 ),
                 null, 'N', 'N','S'),
       -- 10 - TIPO DE DOMICILIO - PENDIENTE
       '10' + dbo.fn_formatea_texto(1, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,'C','A'), null,'N','S','S'),
       -- 11 - INDICADOR ESPECIAL DE DOMICILIO - PENDIENTE
       '11' + dbo.fn_formatea_texto(1, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,'R','A'), null,'N','S','S'),
       */
       '', -- 06
	   ---TELEFONO CEL 
       '',--07
       '', -- 08
       '', -- 09
       '', -- 10
       '', -- 11
       -- 12 - ORIGEN DEL DOMICILIO (PAIS)
       '12' + dbo.fn_formatea_texto(2,
                 (select eq_descripcion from @w_CL_PAIS_A6 where eq_valor_cat = di_pais),
                 null, 'N', 'S','S'),
	   null 			 
  from #tmp_direccion2
  ORDER BY di_ente
  
  if @@error <> 0
  begin
     select @w_msg = 'ERROR EN INSERCION SB_BURO_DIRECCION 2'
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '70011012',
     @i_descrp_error  = @w_msg
  end
  
  select 
  ente      = te_ente, 
  direccion = max(te_direccion) 
  into #max_direcciones_cel2
  from cobis..cl_telefono, #sb_buro_direccion2
  where te_tipo_telefono = 'C'
  and te_ente = bd_di_ente
  group by te_ente
  
  update #sb_buro_direccion2 set 
  bd_direccion =direccion
  from #max_direcciones_cel2
  where bd_di_ente =ente 
  
  if @@error <> 0
  begin
     select @w_msg = 'ERROR EN INSERCION SB_BURO_DIRECCION 2'
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '70011012',
     @i_descrp_error  = @w_msg
  end
  
  
  update #sb_buro_direccion2 set 
  bd_num_telf = '07' + dbo.fn_formatea_texto(11,te_valor ,null, 'N', 'N','S')
  from cobis..cl_telefono ,#sb_buro_direccion2 
  where te_tipo_telefono = 'C'
  and te_ente = bd_di_ente
  and te_direccion = bd_direccion
  
  if @@error <> 0
  begin
     select @w_msg = 'ERROR EN INSERCION SB_BURO_DIRECCION 2'
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '70011012',
     @i_descrp_error  = @w_msg
  end



  -- ------------------------------------------------------------------------------------
  -- FIN SECCION DIRECCION DE CLIENTE 2
  -- ------------------------------------------------------------------------------------

  -- ------------------------------------------------------------------------------------
  -- INICIO SECCION EMPLEO DE CLIENTE 2 -- Error.191254
  -- ------------------------------------------------------------------------------------
CREATE TABLE #sb_buro_empleo2
(
	be_ente         INT,
	be_raz_social   VARCHAR (104),
	be_pri_linea    VARCHAR (60),
	be_seg_linea    VARCHAR (60),
	be_colonia      VARCHAR (60),
	be_delegacion   VARCHAR (60),
	be_ciudad       VARCHAR (60),
	be_estado       VARCHAR (20),
	be_cod_postal   VARCHAR (20),
	be_num_telf     VARCHAR (30),
	be_ext_telf     VARCHAR (30),
	be_num_fax      VARCHAR (30),
	be_ocupacion    VARCHAR (60),
	be_fecha_contra VARCHAR (20),
	be_moneda       VARCHAR (20),
	be_sueldo       VARCHAR (20),
	be_frec_pago    VARCHAR (10),
	be_num_empl     VARCHAR (20),
	be_ult_dia_empl VARCHAR (20),
	be_verif_empl   VARCHAR (20),
	be_origen       VARCHAR (20)
)

CREATE CLUSTERED INDEX sb_buro_direccion2_fk
ON #sb_buro_empleo2 (be_ente)
   
  select di_ente, di_direccion, di_tipo, di_fecha_modificacion
  into #tmp_direccion_empleo_max2
  from cobis..cl_direccion d1, #dir2_max_tmp_1, #sb_buro_cliente2
  where d1.di_ente = bc_en_ente
  and d1.di_tipo = 'AE'
  and di_fecha_modificacion = max_fecha
  and d1.di_ente = ente
  and d1.di_tipo = tipo
  ORDER BY di_ente
  
  CREATE CLUSTERED INDEX idx_tmp_dir_emp_max2 ON #tmp_direccion_empleo_max2(di_ente)
  
  --MTA
  select 'max_fecha' = max(di_direccion), 'ente' = di_ente
  into #dir_max_tmp_3_2
  from #tmp_direccion_empleo_max2
  group by di_ente
  ORDER BY di_ente
  
  CREATE CLUSTERED INDEX idx_dir_max_tmp3_2 ON #dir_max_tmp_3_2(ente)
  
  select d1.*
  into #tmp_direccion_empleo2
  from cobis..cl_direccion d1, #dir_max_tmp_3_2, #sb_buro_cliente2
  where d1.di_ente = bc_en_ente
  and d1.di_direccion = max_fecha 
  and d1.di_ente = ente
  ORDER BY d1.di_ente
  
  CREATE CLUSTERED INDEX idx_tmp_dir_emp2 ON #tmp_direccion_empleo2(di_ente)
  
  update  #tmp_direccion_empleo2 
  set     di_nro = null                 
  where   di_nro = 0                  
                      
  update  #tmp_direccion_empleo2  
  set     di_nro = null                 
  where   isnumeric (di_nro) = 0                         
  
  update  #tmp_direccion_empleo2
  set     di_calle=replace(replace(replace(di_calle,' ','<>'),'><',''),'<>',' ')
  
  update  #tmp_direccion_empleo2
  set     di_calle=replace(replace(replace(di_calle,' SN','<>'),'><',''),'<>',' ')
   
  --SI NO TIENE DIRECCION DE EMPLEO LE COLOCO POR DEFECTO EL DEL DOMICILIO
  insert into #tmp_direccion_empleo2
  select * from #tmp_direccion2
  where di_ente not in (select di_ente from #tmp_direccion_empleo2)
  ORDER BY di_ente

  insert into #sb_buro_empleo2(
     be_ente     ,  be_raz_social     ,  be_pri_linea   ,  be_seg_linea   ,  be_colonia  ,  be_delegacion  ,
     --be_ciudad   ,  
     be_estado         ,  be_cod_postal, -- be_num_telf    ,  be_ext_telf ,  be_num_fax     ,
     --be_ocupacion,  be_fecha_contra   ,  be_moneda      ,  be_sueldo      ,  be_frec_pago,  be_num_empl    ,
     --be_ult_dia_empl,  be_verif_empl  ,  
	 be_origen)
  select  di_ente,
       -- PE - NOMBRE DEL EMPLEADOR
       'PE' + dbo.fn_formatea_texto(99, dbo.fn_formatea_ascii_ext_1(@w_equivalencias,'TRABAJADOR INDEPENDIENTE','AN'), null,'N','N','S'),
       -- 00 - PRIMERA LINEA DE DIRECCION
       '00' + dbo.fn_formatea_texto(40,
                 (  dbo.fn_formatea_ascii_ext_1(@w_equivalencias,
                       case
                          when len(rtrim(ltrim(isnull(rtrim(ltrim(di_calle)),'') + ' ' + isnull(ltrim(rtrim(convert(VARCHAR(255),di_nro))),'SN')))) <= 40 then
                             rtrim(ltrim(isnull(rtrim(ltrim(di_calle)),''))) + ' ' + isnull(rtrim(ltrim(convert(VARCHAR(255),di_nro))),'SN')
                          else
                             substring(rtrim(ltrim(isnull(rtrim(ltrim(di_calle)),'') +' '+ isnull(rtrim(ltrim(convert(VARCHAR(255),di_nro))),'SN'))),1,40)
                       end,'AN')),
                 null, 'N', 'N','S'),								
       -- 01 - SEGUNDA LINEA DE DIRECCION
        case when len(rtrim(ltrim(isnull(ltrim(rtrim(di_calle)),'') + ' ' + isnull(convert(VARCHAR(255),di_nro),'SN')))) > 40 then
           '01' + dbo.fn_formatea_texto(40, (
                      dbo.fn_formatea_ascii_ext_1(@w_equivalencias,
                  substring(rtrim(ltrim(isnull(rtrim(ltrim(di_calle)),'') + ' ' + isnull(rtrim(ltrim(convert(VARCHAR(255),di_nro))),'SN'))),41,80),
                  'AN' )),
                  null, 'N', 'N','S')
                 ELSE ''
                 end,      
       -- 02 - COLONIA O POBLACION
       '02' + dbo.fn_formatea_texto(40,
                 dbo.fn_formatea_ascii_ext_1(@w_equivalencias,(select replace(replace(substring(pq_descripcion,1,40),'( ','('),' )',')') from @w_cl_parroquia where pq_parroquia = di_parroquia), 'AN' ),
                 null, 'N', 'N','S'),
	  
       -- 03 - DELEGACION O MUNICIPIO
       '03' + ltrim(rtrim(dbo.fn_formatea_texto(40,
                 dbo.fn_formatea_ascii_ext_1(@w_equivalencias,(select substring(ci_descripcion,1,40) from @w_cl_ciudad where ci_ciudad = di_ciudad),'AN' ),
                 null,'N', 'N','S'))),
       -- 04 - CIUDAD
      /* '04' + dbo.fn_formatea_texto(40,
                 dbo.fn_formatea_ascii_ext_1(@w_equivalencias,(select ci_descripcion from cobis..cl_ciudad where ci_ciudad = di_ciudad),'AN' ),
                 null,'N','N','S'),*/
       -- 05 - ESTADO
       '05' + dbo.fn_formatea_texto(4,
                 (select upper(rtrim(ltrim(eq_valor_arch)))
                    from @w_ESTADOS_A7 where eq_valor_cat = di_provincia ),
                 null, 'N', 'N','S'),
       -- 06 - CODIGO POSTAL
       '06' + dbo.fn_formatea_texto(5,
                 (select case
                           when eq_descripcion != 'MX' and di_codpostal is null then '00000'
                           else isnull(di_codpostal,'')
                         end
                    from @w_CL_PAIS_A6 WHERE eq_valor_cat = di_pais),
                 null,'N','S','S'),
       -- 07 - NUMERO DE TELEFONO AL 17
       --'' ,
       -- 08 - EXTENSION TELEFONICA
       --'' ,
       -- 09 - NUMERO DE FAX EN ESTA DIRECCION
       --'' ,
       -- 10 - CARGO U OCUPACION
       --'' ,
       -- 11 - FECHA CONTRATACION
       --'' ,
       -- 12 - CLAVE DE LA MONEDA DE PAGO
       --'' ,
       -- 13 - MONTO SUELDO
       --'' ,
       -- 14 -  PERIODO DE PAGO
       --'' ,
       -- 15 - NUMERO DE EMPLEADO
       --'' ,
       -- 16 - FECHA DE ULTIMO DIA DE EMPLEO
       --'' ,
       -- 17 - FECHA DE VERIFICACION DE EMPLEO
       --'' ,
       -- 18 - ORIGEN DE LA RAZON SOCIAL
       '18' + dbo.fn_formatea_texto(2,'MX', null, 'N', 'S','S')
  from #tmp_direccion_empleo2 d1
  ORDER BY di_ente
  
  if @@error <> 0
  begin
     select @w_msg = 'ERROR EN INSERCION SB_BURO_EMPLEO 2'
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '70011014',
     @i_descrp_error  = @w_msg
  end
  
  -- ------------------------------------------------------------------------------------
  -- FIN SECCION EMPLEO DE CLIENTE 2
  -- ------------------------------------------------------------------------------------
  
  -- ------------------------------------------------------------------------------------
  -- INI - Segmento INTF Encabezado
  -- ------------------------------------------------------------------------------------
  SELECT @w_cadena =
           'INTF' +
           @w_version +
           @w_member_code +
           ltrim(rtrim(substring(@w_nombre_banco,1,16))) +
           replicate(' ',16 - len(ltrim(rtrim(substring(@w_nombre_banco,1,16))))) +
           replicate(' ',2) + -- reservado 2 caracteres en blanco
           replace(convert(VARCHAR, @w_fin_mes, 104), '.','') + -- ddmmyyyy  ULTMO DIA DEL MES***
           replicate('0',10) + -- 10 ceros
           replicate(' ',98)  -- 98 espacios
  -- ------------------------------------------------------------------------------------
  -- FIN - Segmento INTF Encabezado
  -- ------------------------------------------------------------------------------------
     truncate table sb_reporte_buro_final

     insert INTO sb_reporte_buro_final(rb_cadena)  values(@w_cadena) -- INTF


     --GENERO LAS LINEAS PARA EL ARCHIVO

     
	  
	 delete #sb_reporte_buro_cuentas 
     where [04]  in (select [04] from #sb_reporte_buro_cuentas2)
     and [30]  <> 'LC'
	 



     insert INTO sb_reporte_buro_final(rb_cadena)
     select --top 50
           -- INI - Segmento Datos de Cliente - PN
           isnull(bc_p_apellido,'')     + isnull(bc_s_apellido,'')     + isnull(bc_en_nombre,'')   + isnull(bc_s_nombre,'')    + isnull(bc_fecha_nac,'')     +
           isnull(bc_en_rfc,'')         + --isnull(bc_pref_pers,'')  + isnull(bc_suf_pers,'')       +
		   isnull(bc_nacionalidad,'')  + --isnull(bc_tresidencia,'') + isnull(bc_lic_conducir,'') +
           isnull(bc_ecivil,'')        + isnull(bc_sexo,'')          + --isnull(bc_seg_social,'')    + isnull(bc_reg_electoral,'') + 
		   isnull(bc_iden_unica,'')  + isnull(bc_clave_pais,'')     +
           isnull(bc_num_depend,'')     + --isnull(bc_edades_dep,'')     + isnull(bc_ind_defuncion,'') +
           -- FIN - Segmento Datos de Cliente - PN

           -- INI - Segmento Direccion de Cliente - PA
           isnull(bd_pri_linea  ,'') +  isnull(bd_seg_linea ,'') +   
		   isnull(bd_colonia ,'')   +   isnull(bd_delegacion,'')  +   isnull(bd_ciudad ,'')    +  isnull(bd_estado    ,'') +
           isnull(bd_cod_postal ,'') +  isnull(bd_fec_reside,'') +   isnull(bd_num_telf,'')   +    isnull(bd_ext_telf  ,'')  +   isnull(bd_num_fax,'')    +  isnull(bd_tdomicilio,'') +
           isnull(bd_ind_esp_dom,'') +  isnull(bd_org_dom   ,'') +
           -- FIN - Segmento Direccion de Cliente - PA

           -- INI - Segmento Empleo de Cliente - PE
           isnull(be_raz_social  ,'') +  isnull(be_pri_linea ,'')  +  isnull(be_seg_linea,'')   +  isnull(be_colonia  ,'')+  isnull(be_delegacion,'')  + -- isnull(be_ciudad      ,'') +
           isnull(be_estado      ,'') +  isnull(be_cod_postal,'')  +  --isnull(be_num_telf ,'')   +  isnull(be_ext_telf ,'')+  isnull(be_num_fax   ,'')  +  isnull(be_ocupacion   ,'') +
           --isnull(be_fecha_contra,'') +  isnull(be_moneda    ,'')  +  isnull(be_sueldo   ,'')   +  isnull(be_frec_pago,'')+  isnull(be_num_empl  ,'')  +  isnull(be_ult_dia_empl,'') +
           --isnull(be_verif_empl  ,'') +  
		   isnull(be_origen    ,'')  +
           -- FIN - Segmento Empleo de Cliente - PE
           'TL02TL' +
           '01' + dbo.fn_formatea_texto(10,@w_member_code,null,'S','S','S')+
           '02' + dbo.fn_formatea_texto(16,ltrim(rtrim(substring(@w_nombre_banco,1,16))),null,'S','N','S')+
           '04' + dbo.fn_formatea_texto(25,ltrim(rtrim([04])),null,'S','N','S') +
           '05' + dbo.fn_formatea_texto(1,[05],null,'S','S','S') +
		   '06' + [06] +
           '07' + [07] +
           '08' + [08] +
           --'09' + dbo.fn_formatea_texto(9,null,[09],null,'N','S') +
           '10' + [10] +
           '11' + [11] +		  			
           '12' + dbo.fn_formatea_texto(9,null,[12],null,'N','S') +		   
           '13' + [13] +
           '14' + [14] +
           '15' + [15] +
                  [16]+
           '17' + [17] +
           --'20'   + [20] +
           '21' + [21] +
           '22' + case when [22] is null then '00' else dbo.fn_formatea_texto(9,null,[22],null,'N','S') end +
           '23' + [23] +
           '24' + case when [24] is null then '00' else dbo.fn_formatea_texto(9,null,[24],null,'N','S') end +
           [25] +
           '26' + [26] +
           [30] +
           --'39'   + [39] +
           --'40'   + [40] +
           --'41'   + [41] +
           '43' + [43] +
           '44' + [44] +
           '45' + [45] +
           '46'   + [46] +
           --'47' + [47] +
           --'48' + [48] +
           '49' + [49] +
           '50' + [50] +
           '51' + [51] +
           '52' + [52] +
           '9903FIN'
     from #sb_reporte_buro_cuentas inner join #sb_buro_cliente on rb_ente = bc_en_ente
          left join #sb_buro_direccion on rb_ente = bd_di_ente
          left join #sb_buro_empleo on rb_ente = be_ente
     ORDER BY rb_ente
	 
	 
	 
	   ---INSERTA LA COPIA DE LA TABLA TEMPORAL DE BURO DE CUENTAS DONDE ESTAN LAS OPERACIONES CON PAGO CONDONADO 
	   -- EL REQUERIMIENTO EXIGE QUE PESAR QUE EXISTA UN REGISTRO DE UNA OPERACION CANCELADA, SE AÑADA OTRA CON LA MISMA 
	   --OPERACION PERO CON LAS NECESIDADES DEL RQ
	  insert INTO sb_reporte_buro_final(rb_cadena)
       select
           -- INI - Segmento Datos de Cliente - PN
           isnull(bc_p_apellido,'')     + isnull(bc_s_apellido,'')     + isnull(bc_en_nombre,'')   + isnull(bc_s_nombre,'')    + isnull(bc_fecha_nac,'')     +
           isnull(bc_en_rfc,'')         + --isnull(bc_pref_pers,'')  + isnull(bc_suf_pers,'')       +
		   isnull(bc_nacionalidad,'')  + --isnull(bc_tresidencia,'') + isnull(bc_lic_conducir,'') +
           isnull(bc_ecivil,'')        + isnull(bc_sexo,'')          + --isnull(bc_seg_social,'')    + isnull(bc_reg_electoral,'') + 
		   isnull(bc_iden_unica,'')  + isnull(bc_clave_pais,'')     +
           isnull(bc_num_depend,'')     + --isnull(bc_edades_dep,'')     + isnull(bc_ind_defuncion,'') +
           -- FIN - Segmento Datos de Cliente - PN

           -- INI - Segmento Direccion de Cliente - PA
           isnull(bd_pri_linea  ,'') +  isnull(bd_seg_linea ,'') +   
		   isnull(bd_colonia ,'')   +   isnull(bd_delegacion,'')  +   isnull(bd_ciudad ,'')    +  isnull(bd_estado    ,'') +
           isnull(bd_cod_postal ,'') +  isnull(bd_fec_reside,'') +   isnull(bd_num_telf,'')   +    isnull(bd_ext_telf  ,'')  +   isnull(bd_num_fax,'')    +  isnull(bd_tdomicilio,'') +
           isnull(bd_ind_esp_dom,'') +  isnull(bd_org_dom   ,'') +
           -- FIN - Segmento Direccion de Cliente - PA

           -- INI - Segmento Empleo de Cliente - PE
           isnull(be_raz_social  ,'') +  isnull(be_pri_linea ,'')  +  isnull(be_seg_linea,'')   +  isnull(be_colonia  ,'')+  isnull(be_delegacion,'')  + -- isnull(be_ciudad      ,'') +
           isnull(be_estado      ,'') +  isnull(be_cod_postal,'')  +  --isnull(be_num_telf ,'')   +  isnull(be_ext_telf ,'')+  isnull(be_num_fax   ,'')  +  isnull(be_ocupacion   ,'') +
           --isnull(be_fecha_contra,'') +  isnull(be_moneda    ,'')  +  isnull(be_sueldo   ,'')   +  isnull(be_frec_pago,'')+  isnull(be_num_empl  ,'')  +  isnull(be_ult_dia_empl,'') +
           --isnull(be_verif_empl  ,'') +  
		   isnull(be_origen    ,'')  +
           -- FIN - Segmento Empleo de Cliente - PE
           'TL02TL' +
           '01' + dbo.fn_formatea_texto(10,@w_member_code,null,'S','S','S')+
           '02' + dbo.fn_formatea_texto(16,ltrim(rtrim(substring(@w_nombre_banco,1,16))),null,'S','N','S')+
           '04' + dbo.fn_formatea_texto(25,ltrim(rtrim([04])),null,'S','N','S') +
           '05' + dbo.fn_formatea_texto(1,[05],null,'S','S','S') +
		   '06' + [06] +
           '07' + [07] +
           '08' + [08] +
           --'09' + dbo.fn_formatea_texto(9,null,[09],null,'N','S') +
           '10' + [10] +
           '11' + [11] +		  			
           '12' + dbo.fn_formatea_texto(9,null,[12],null,'N','S') +		   
           '13' + [13] +
           '14' + [14] +
           '15' + [15] +
                  [16]+
           '17' + [17] +
           --'20'   + [20] +
           '21' + [21] +
           '22' + case when [22] is null then '00' else dbo.fn_formatea_texto(9,null,[22],null,'N','S') end +
           '23' + [23] +
           '24' + case when [24] is null then '00' else dbo.fn_formatea_texto(9,null,[24],null,'N','S') end +
           [25] +
           '26' + [26] +
           [30] +
           --'39'   + [39] +
           --'40'   + [40] +
           --'41'   + [41] +
           '43' + [43] +
           '44' + [44] +
           '45' + [45] +
           '46'   + [46] +
           --'47' + [47] +
           --'48' + [48] +
           '49' + [49] +
           '50' + [50] +
           '51' + [51] +
           '52' + [52] +
           '9903FIN'
     from #sb_reporte_buro_cuentas2 inner join #sb_buro_cliente2 on rb_ente = bc_en_ente -- Error.191254 -cambio a #sb_buro_cliente2
          left join #sb_buro_direccion2 on rb_ente = bd_di_ente                          -- Error.191254 -cambio a #sb_buro_direccion2
          left join #sb_buro_empleo2 on rb_ente = be_ente                                -- Error.191254 -cambio a #sb_buro_empleo2
     ORDER BY rb_ente
	 


     --SECCION DE CIERRE Y CONTROL
	 -- Sumatoria Registros
	 select @w_num_reg_total = count([04])
	 from #sb_reporte_buro_cuentas2 inner join #sb_buro_cliente2 on rb_ente = bc_en_ente
	 select @w_num_reg_total = isnull(@w_num_reg_total,0)
	 
	 select @w_num_registros = count([04])
	 from #sb_reporte_buro_cuentas inner join #sb_buro_cliente on rb_ente = bc_en_ente
	 select @w_num_reg_total = @w_num_reg_total + isnull(@w_num_registros,0)
	 
    --Saldo Vencido -> [24]
	select @w_monto_ven_tot = sum(isnull([24],0))
	from #sb_reporte_buro_cuentas2 inner join #sb_buro_cliente2 on rb_ente = bc_en_ente
	
	select @w_monto_ven_tot = isnull(@w_monto_ven_tot,0)
	
	select @w_monto_vencido = sum(isnull([24],0))
	from #sb_reporte_buro_cuentas inner join #sb_buro_cliente on rb_ente = bc_en_ente
	
	select @w_monto_ven_tot = @w_monto_ven_tot + isnull(@w_monto_vencido,0)
	
	-- SALDO
	select @w_saldo_total = sum(isnull([22],0))
	from #sb_reporte_buro_cuentas2 inner join #sb_buro_cliente2 on rb_ente = bc_en_ente
	
	select @w_saldo_total = isnull(@w_saldo_total,0)
	
	select @w_saldo_reg = sum(isnull([22],0))
	from #sb_reporte_buro_cuentas inner join #sb_buro_cliente on rb_ente = bc_en_ente
	
	select @w_saldo_total = @w_saldo_total + isnull(@w_saldo_reg,0)
	
    -- Registros Buro Cliente -- Error.191254
	select @w_num_reg_cliente = count(bc_en_ente) 
	from #sb_reporte_buro_cuentas 
	inner join #sb_buro_cliente 
	on rb_ente = bc_en_ente
	
	select @w_num_reg_cliente2 = count(bc_en_ente) 
	from #sb_reporte_buro_cuentas2 
	inner join #sb_buro_cliente2 
	on rb_ente = bc_en_ente
	
	select @w_num_reg_cli_total = isnull(@w_num_reg_cliente,0) + isnull(@w_num_reg_cliente2,0)
	
    -- Registros Buro Direccion -- Error.191254
	select @w_num_reg_direccion = count(bd_di_ente) 
	from #sb_reporte_buro_cuentas 
	inner join #sb_buro_direccion 
	on rb_ente = bd_di_ente
	
	select @w_num_reg_direccion2 = count(bd_di_ente) 
	from #sb_reporte_buro_cuentas2 
	inner join #sb_buro_direccion2 
	on rb_ente = bd_di_ente
	
	select @w_num_reg_dir_total = isnull(@w_num_reg_direccion,0) + isnull(@w_num_reg_direccion2,0)
	
	-- Registros Buro Empleo -- Error.191254
	select @w_num_reg_empleo = count(be_ente) 
	from #sb_reporte_buro_cuentas 
	inner join #sb_buro_empleo 
	on rb_ente = be_ente
	
	select @w_num_reg_empleo2 = count(be_ente) 
	from #sb_reporte_buro_cuentas2 
	inner join #sb_buro_empleo2 
	on rb_ente = be_ente
	
	select @w_num_reg_emp_total = isnull(@w_num_reg_empleo,0) + isnull(@w_num_reg_empleo2,0)
	
	
	select 'SECCION DE CIERRE Y CONTROL', getdate()
		 
     insert into sb_reporte_buro_final(rb_cadena)
     select 'TRLR'+                                                                                  --1-4
           isnull(replicate('0',14-len(convert(varchar(14),@w_saldo_total))),'')+isnull(convert(varchar(14),@w_saldo_total),'')+    --5-18
           isnull(replicate('0',14-len(convert(varchar(14),@w_monto_ven_tot))),'')+isnull(convert(varchar(14),@w_monto_ven_tot),'')+    --19-32
           isnull(replicate('0',3),'') + -- 33-35 --Error.191254 --PDF 'Manual Buro Credito PDF v14' pag 63 'Total de segmentos INTF' 
           isnull(replicate('0',9 - len(convert(varchar(9),@w_num_reg_cli_total))),'')+ isnull(convert(varchar(9),@w_num_reg_cli_total),'') + -- 36-44 -- Error.191254
		   isnull(replicate('0',9 - len(convert(varchar(9),@w_num_reg_dir_total))),'')+ isnull(convert(varchar(9),@w_num_reg_dir_total),'') + -- 45-53 -- Error.191254
		   isnull(replicate('0',9 - len(convert(varchar(9),@w_num_reg_emp_total))),'')+ isnull(convert(varchar(9),@w_num_reg_emp_total),'') + -- 54-62 -- Error.191254
		   --isnull((select replicate('0',9 - len(convert(varchar(9),count(bc_en_ente))))+convert(varchar(9),count(bc_en_ente)) from #sb_buro_cliente),'')   + -- 36-44
           --isnull((select replicate('0',9 - len(convert(varchar(9),count(bd_di_ente))))+convert(varchar(9),count(bd_di_ente)) from #sb_buro_direccion),'') + -- 45-53
           --isnull((select replicate('0',9 - len(convert(varchar(9),count(bd_di_ente))))+convert(varchar(9),count(bd_di_ente)) from #sb_buro_direccion),'') + -- 54-62
           replicate('0',9-len(convert(varchar(9),@w_num_reg_total)))+convert(varchar(9),@w_num_reg_total)+   --63-71
           replicate('0',6) + --72-77
		   @w_nombre_usuario + --78-93
		   @w_direccion--94-253
     --from #sb_reporte_buro_cuentas
	 
   select 'INICIA EXPORTACION ', getdate()	 

  select @w_comando = 'bcp "select rb_cadena from cob_conta_super..sb_reporte_buro_final order by rb_id" queryout '
  select @w_destino  = @w_path + @w_nombre_repo +'_'+ replace(convert(varchar(11),@w_fin_mes,106),' ','_')+ '.txt',
         @w_errores  = @w_path + @w_nombre_repo +'_'+ replace(convert(varchar(11),@w_fin_mes,106),' ','_')+ '.err'
  select @w_comando = @w_comando + @w_destino + ' -b5000 -c' + @w_s_app + 's_app.ini -r0x7C -T -e' + @w_errores
  --Ejecucion para Generar Archivo Datos
  exec @w_error = xp_cmdshell @w_comando
  if @w_error <> 0 begin
     select @w_msg = 'ERROR EN EJECUCION ' + @w_comando
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '28016',
     @i_descrp_error  = @w_msg
     return 1
  end

   select 'INICIA JAVA ', getdate()	
  -- ------------------------------------------------------------------------------------
 select @w_comando = @w_path_obj + 'cloud-process-intf-1.0.0-jar-with-dependencies.jar ' +
                      @w_path + @w_nombre_repo +'_'+ replace(convert(varchar(11),@w_fin_mes,106),' ','_')+ '.txt'
  exec @w_error = xp_cmdshell @w_comando
  if @w_error <> 0 begin
     select @w_msg = 'ERROR EN EJECUCION ' + @w_comando
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '28016',
     @i_descrp_error  = @w_msg
     return 1
  end
  
  select  'FINALIZA', getdate()
  -- ------------------------------------------------------------------------------------

  -- ------------------------------------------------------------------------------------
  -- ACTUALIZACION DE LA FECHA DE PROCESADO - INI
  insert into sb_buro_fc_fecha_ult_proc(bf_fecha_proceso)values(@i_param1)
  if @@error <> 0
  begin
     select @w_msg = 'ERROR EN INGRESO DE LA FECHA PROCESO - INTF FORMATO CORTO'
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '70011015',
     @i_descrp_error  = @w_msg
  end
  -- ACTUALIZACION DE LA FECHA DE PROCESADO - FIN
  -- ------------------------------------------------------------------------------------

update cob_conta..cb_solicitud_reportes_reg
set   sr_status = 'P'
where sr_reporte = @w_reporte
and   sr_status = 'I'

if @@error != 0
begin
    select @w_error = 710002
    goto ERROR_PROCESO
end

SALIDA_PROCESO:
return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_msg, 'ERROR GENRAL DEL PROCESO')
     exec sp_errorlog
     @i_fecha_fin     = @i_param1,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = @w_error,
     @i_descrp_error  = @w_msg

GO

