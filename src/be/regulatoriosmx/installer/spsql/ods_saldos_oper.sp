
/* ********************************************************************* */
/*      Archivo:                sp_ods_saldos_oper.sp                    */
/*      Stored procedure:       sp_ods_saldos_oper                       */
/*      Base de datos:          cob_cartera                              */
/*      Producto:               Cartera                                  */
/*      Disenado por:           Luis Guachamin                           */
/*      Fecha de escritura:     04-Dic-2017                              */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/* ********************************************************************* */
/*                              PROPOSITO                                */
/*      extraer los datos de una operacion activa, excepto castigada     */
/*      para enviarlo a la interfase ODS                                 */
/* ********************************************************************* */
/*                             MODIFICACION                              */
/*    FECHA           AUTOR         RAZON                                */
/*    04/Dic/17       LGU      emision inicial                           */
/*    02/Jul/19       MTA      Caso 119704                               */
/*    12/Jul/19       MD       Caso 117956                               */
/*    11/Sep/19       MTA      CC caso 117956                            */
/*    17/Sep/19       AGO      Req 121717 ODS Rev.                       */
/*    10/Oct/19       AGO      CORRECCION ULT PAGO                       */
/*    14/Ene/2020     MTA      Caso 131766, agregar campos               */
/*                             al reporte ODS Saldos cartera             */
/*   25/09/2020       ACH      Caso: 146729                              */
/*   29/11/2021       ACH      Caso #173628 Catalogos HRC simple reportes*/
/* ********************************************************************* */

use cob_conta_super
go
if exists (select 1 from sysobjects where name = 'sp_ods_saldos_oper')
    drop proc sp_ods_saldos_oper
go
create proc sp_ods_saldos_oper
	@i_param1   DATETIME
as

DECLARE
@w_cod_centro        VARCHAR(255),
@w_cod_subprodu      VARCHAR(255),
@w_num_cuente        VARCHAR(255),
@w_idf_pers_ods      VARCHAR(255),
@w_cod_mod_pago      VARCHAR(255),
@w_cod_tip_tas       VARCHAR(255),
@w_tas_int           VARCHAR(255),
@w_fec_alta_cto      VARCHAR(255),
@w_plz_amrt          VARCHAR(255),
@w_cod_uni_plz_amrt  VARCHAR(255),
@w_imp_ini_mo        VARCHAR(255),
@w_dp_area           VARCHAR(255),
@w_re_area			 VARCHAR(255),
@w_cod_centro_cont   VARCHAR(255),
@w_member_code       varchar(255),
@w_return            INT,
@w_empresa           smallint


DECLARE
@w_file_rpt     varchar(100),
@w_file_rpt_1   varchar(140),
@w_file_rpt_1_out varchar(140),
@w_comando      varchar(2000),
@w_path_destino varchar(200),
@w_origen       VARCHAR(32),
@w_s_app        varchar(40),
@w_fecha_r      varchar(10),
@w_mes          varchar(2),
@w_dia          varchar(2),
@w_anio         varchar(4),
@w_query        VARCHAR(100),
@w_fecha_reporte  datetime


--HASTA ENCONTRAR EL HABIL ANTERIOR


select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

select
   @w_path_destino = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 36 -- REGULATORIOS

select @w_file_rpt = ba_arch_resultado
from cobis..ba_batch
WHERE ba_batch = 7511

SELECT @i_param1 = max(do_fecha) 
FROM cob_conta_super..sb_dato_operacion with (index (idx3) ) 
WHERE do_aplicativo = 7
AND do_fecha < @i_param1


IF @i_param1 IS NULL 
BEGIN
	PRINT 'no existen datos en el consolidador'
	RETURN 0
END

PRINT 'datos al ' + convert(VARCHAR, @i_param1 )

select @w_mes         = substring(convert(varchar,@i_param1, 101),1,2)
select @w_dia         = substring(convert(varchar,@i_param1, 101),4,2)
select @w_anio        = right(substring(convert(varchar,@i_param1, 101),7,4),4) -- caso#146729



select @w_fecha_r = @w_anio + @w_mes + @w_dia

select @w_file_rpt = isnull(@w_file_rpt,'BMXP_SAL_CAR')  --nombre temporal
select @w_file_rpt_1     = @w_path_destino + @w_file_rpt + '_' + @w_fecha_r + '.txt'
select @w_file_rpt_1_out = @w_path_destino + @w_file_rpt + '_' + @w_fecha_r + '.err'

select @w_empresa = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'EMP' and pa_producto = 'ADM'

select @w_empresa = isnull(@w_empresa ,1)

SELECT TOP 1 @w_dp_area = dp_area
from cob_conta..cb_det_perfil with (nolock)
where dp_empresa     = @w_empresa
and   dp_producto    = 7

select @w_re_area = ta_area
from cob_conta..cb_tipo_area
where ta_tiparea  = @w_dp_area
and   ta_empresa  = @w_empresa
and   ta_producto = 7


select @w_member_code = pa_char
from cobis..cl_parametro
where pa_nemonico='MNBRCD'
and pa_producto='REC'

TRUNCATE TABLE sb_ods01_tmp

select *, tipo_amort = convert(varchar(20),null) into #sb_ods01 from sb_ods01_tmp where 1 = 2 



INSERT INTO #sb_ods01
SELECT  
--	do_banco,
	[campo 1] = replace(convert(VARCHAR(12), @i_param1, 111), '/','') ,
	[campo 2] = '52' ,
	[campo 3] = '0078' ,
	[campo 4] = convert(VARCHAR,do_oficina) ,
	[campo 5] = '96' ,
	[campo 6] = CASE do_tipo_operacion
					WHEN 'GRUPAL'     THEN '1'
					WHEN 'REVOLVENTE' THEN '2'
					WHEN 'INTERCICLO' THEN '3'
					WHEN 'INDIVIDUAL' THEN '4'--Caso#173628 
					ELSE '99'
				END ,
	[campo 7] =	convert(VARCHAR, do_banco) ,
	[campo 8] = '0' ,
	[campo 9] = 'MXP' ,
	[campo 10] = isnull((SELECT en_banco FROM cobis..cl_ente WHERE en_ente = do_codigo_cliente),'N/A') ,
	[campo 11] = @w_re_area ,
	[campo 12] = '360' ,
	[campo 13] = '2' ,
	[campo 14] = 'L' ,
	[campo 15] = isnull(do_modalidad, 'V') ,
	[campo 16] = case do_tipo_amortizacion when 'FRANCESA'  then 1 
	                                       when 'ALEMANA'   then 2 
										   when 'ROTATIVA'  then 2 
                                           else 3 end,
	[campo 17] = isnull((SELECT TOP 1 'V' FROM cob_conta_super..sb_dato_reajuste WHERE dr_operacion = do_banco AND dr_fecha = do_fecha), 'F') ,
	[campo 18] = convert(VARCHAR,do_tasa) ,
	[campo 19] = replace(convert(VARCHAR, do_fecha_concesion, 111), '/','') ,
	[campo 20] = replace(convert(VARCHAR, do_fecha_concesion, 111), '/','') ,
	[campo 21] = replace(convert(VARCHAR, do_fecha_ini_mora, 111), '/',''),
	[campo 22] = replace(convert(VARCHAR, isnull(do_fecha_ult_vto,''), 111), '/','') ,
	[campo 23] = case WHEN (do_estado_cartera =3 and do_tipo_amortizacion <> 'ROTATIVA')  OR  do_fecha_proceso >=  do_fecha_vencimiento THEN 	''  
            	 else replace(convert(VARCHAR, isnull(do_fecha_prox_vto,''), 111), '/','') end,
	[campo 24] = convert(VARCHAR, datediff (dd, do_fecha_concesion, do_fecha_ven_orig )) ,
	[campo 25] = case do_periodicidad_cuota 
	                   when 07  then 'W'
					   when 14  then 'F'
					   when 30  then 'M'
					   else 'A' end, 
	[campo 26] = convert(VARCHAR,do_cupo_original),
	[campo 27] = do_monto_aprobado ,
	[campo 28] = do_monto_aprobado ,
	[campo 29] = 'P' ,	
	[campo 30] = replace(convert(VARCHAR, do_fecha_vencimiento, 111), '/',''),	
	[campo 31] = do_grupo,
	[campo 32] =
			case do_estado_cartera 
				when 4 then '50'
				when 2 then '30'
				when 3 then '00'
				when 1 then case isnull(do_dias_mora_365, 0)
					when 0 then '00' 				    
				    else '20' 
				end				
			end,
	[campo 33] = do_periodicidad_cuota,
	[campo 34] = 'D',
	[campo 35] =  case when do_tipo_amortizacion <> 'ROTATIVA' then do_valor_cuota else isnull(do_importe_ult_vto ,0) end,
	[campo 36] =  case when do_tipo_amortizacion <> 'ROTATIVA' then do_valor_cuota else isnull(do_importe_pri_vto ,0)end,
	[campo 37] =  do_num_cuotas,
	[campo 38] =  case when do_tipo_amortizacion <> 'ROTATIVA' then do_num_cuotas -do_cuota_ult_vto else 
						case do_periodicidad_cuota 
						when '7'  then  datediff(ww,do_fecha_prox_vto,do_fecha_vencimiento)   +1
						when '14' then  datediff(ww,do_fecha_prox_vto,do_fecha_vencimiento)/2 +1
						when '30' then  datediff(mm,do_fecha_prox_vto,do_fecha_vencimiento)   +1
						end 
					end ,
	[campo 39] =  isnull(replace(convert(VARCHAR, do_fecha_ven_orig, 111), '/',''), replace(convert(VARCHAR, do_fecha_vencimiento, 111), '/','')),
	[campo 40] = replace(convert(VARCHAR, do_fecha_can_ant, 111), '/',''),				
	tipo_amort = do_tipo_amortizacion
FROM cob_conta_super..sb_dato_operacion  --with (index (idx3) )
WHERE do_estado_cartera IN (1,2,3) --(1,2,3,4)  creditos con atraso de pago igual o menor a 90 días
AND do_fecha = @i_param1
AND do_aplicativo = 7
AND do_dias_mora_365 < 90
--AND do_tipo_operacion not in ('REVOLVENTE')

select 
fecha      = dt_fecha,
banco      = dt_banco,
secuencial = dt_secuencial 
into #pagos_total
from sb_dato_transaccion 
where  dt_reversa    = 'N'
and dt_tipo_trans = 'PAG'
and dt_fecha      <= @i_param1

delete #pagos_total  from sb_dato_transaccion 
where banco     =  dt_banco  
and  secuencial = -1*dt_secuencial 
and  dt_reversa = 'S'
and  dt_fecha   <= @i_param1        --se agrega delete 


--PARA PRESTAMOS ROTATIVO CAMPO 22 ES EL ULTIMO PAGO 
select 
banco = banco, 
fecha = max(fecha)
into #pagos
from #pagos_total 
group by banco


update #sb_ods01 set 
campo22 =  replace(convert(VARCHAR, isnull(fecha,''), 111), '/','')   
from #pagos
where campo07= banco


alter table #sb_ods01   drop column tipo_amort

insert into    sb_ods01_tmp
select * from  #sb_ods01 


select @w_query   = 'select * from cob_conta_super..sb_ods01_tmp order by campo07'
				 
	   
select @w_comando = 'bcp "' + @w_query + '" queryout "'	   
select @w_comando = @w_comando + @w_file_rpt_1 + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_file_rpt_1_out + '"'+ ' -t"|" '

SELECT @w_comando

--Ejecucion para Generar Archivo Datos
exec @w_return = xp_cmdshell @w_comando

RETURN 0

GO 

