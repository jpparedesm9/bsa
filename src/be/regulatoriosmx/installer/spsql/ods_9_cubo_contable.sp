/*************************************************************************/
/*   Archivo:              ods_9_cubo_contable.sp                        */
/*   Stored procedure:     sp_ods_9_cubo_contable                        */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         LGU                                           */
/*   Fecha de escritura:   Diciembre 2017                                */
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
/*   Extraccion de datos para la generacion de archivo de interface ODS 9*/
/*   Dimensiones cubo contale                                            */
/*                              CAMBIOS                                  */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    04/Dic/17             LGU              emision inicial             */
/*                                                                       */
/*************************************************************************/

use cob_conta_super
go

if exists(select 1 from sysobjects where name = 'sp_ods_9_cubo_contable')
    drop proc sp_ods_9_cubo_contable
go

         
create proc sp_ods_9_cubo_contable 
(
	@i_param1   DATETIME
)
as

DECLARE
@w_sp_name           VARCHAR(64),
@w_msg               VARCHAR(255),
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
@w_sep               VARCHAR(255),
@w_return            INT,
@w_empresa           TINYINT,
@w_fecha_proceso     DATETIME

DECLARE
@w_file_rpt     varchar(40),
@w_file_rpt_1   varchar(140),
@w_file_rpt_1_out varchar(140),
@w_bcp          varchar(2000),
@w_path_destino varchar(200),
@w_origen       VARCHAR(32),
@w_s_app        varchar(40),
@w_fecha_r      varchar(10),
@w_mes          varchar(2),
@w_dia          varchar(2),
@w_anio         varchar(4)


SELECT @w_sp_name = 'sp_ods_9_cubo_contable'

select @w_empresa = pa_tinyint 
from   cobis..cl_parametro
where  pa_nemonico = 'EMP' and pa_producto = 'ADM'

if @@rowcount <> 1 
begin
   select 
		@w_return = 101254,
	    @w_msg = 'NO ESTA DEFINIDA LA EMPRESA CONTABLE'
   goto ERROR_PROCESO
end


--///////////////////////////////
-- validar si se procesa o no
DECLARE
@w_reporte          VARCHAR(10),
@w_existe_solicitud char (1) ,
@w_ini_mes          datetime ,
@w_fin_mes          datetime ,
@w_fin_mes_hab      datetime ,
@w_fin_mes_ant      datetime ,
@w_fin_mes_ant_hab  datetime

SELECT @w_reporte = 'ODS09'
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
BEGIN

    select @w_return = @w_return
    select @w_msg   = 'Fallo ejecucion cob_conta..sp_calcula_ultima_fecha_habil'
    goto ERROR_PROCESO
end

if @w_existe_solicitud = 'N' goto SALIDA_PROCESO

select @i_param1   = @w_fin_mes

--///////////////////////////////
SELECT
    '@o_ini_mes        '  = @w_ini_mes ,
    '@o_fin_mes        '  = @w_fin_mes ,
    '@o_fin_mes_hab    '  = @w_fin_mes_hab ,
    '@o_fin_mes_ant    '  = @w_fin_mes_ant ,
    '@o_fin_mes_ant_hab'  = @w_fin_mes_ant_hab ,
    '@i_param1         '  = @i_param1
--///////////////////////////////


select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

select
   @w_path_destino = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 36 -- REGULATORIOS

select @w_mes         = substring(convert(varchar,@i_param1, 101),1,2)
select @w_dia         = substring(convert(varchar,@i_param1, 101),4,2)
select @w_anio        = substring(convert(varchar,@i_param1, 101),7,4)

select @w_fecha_r = @w_anio + @w_mes + @w_dia

select @w_file_rpt = 'COB_ODS_09'
select @w_file_rpt_1     = @w_path_destino + @w_file_rpt + '_' + @w_fecha_r + '.txt'
select @w_file_rpt_1_out = @w_path_destino + @w_file_rpt + '_' + @w_fecha_r + '.err'


SELECT @w_sep = '|'

TRUNCATE TABLE sb_ods09_tmp

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


INSERT INTO sb_ods09_tmp
SELECT  
	@w_anio 
	+ @w_sep + '14'
	+ @w_sep + @w_mes
	+ @w_sep + 'MXN'
	+ @w_sep + as_cuenta
	+ @w_sep + convert(VARCHAR,as_oficina_dest)
	+ @w_sep + '+'
	+ @w_sep + convert(VARCHAR,sum(isnull(as_debito,0)))
	+ @w_sep + '+'
	+ @w_sep + convert(VARCHAR,sum(isnull(as_credito,0)))
	+ @w_sep + CASE WHEN sum(isnull(as_debito,0)) >= sum(isnull(as_credito,0)) THEN
				'+'
				ELSE
				'-'
				END
	+ @w_sep + convert(VARCHAR,abs(sum(isnull(as_debito,0)) - sum(isnull(as_credito,0))))
from cob_conta..cb_asiento, cob_conta..cb_cuenta
where as_empresa	= @w_empresa
and as_fecha_tran	between @w_ini_mes and @w_fin_mes 
AND as_empresa    = cu_empresa
AND as_cuenta     = cu_cuenta
AND cu_movimiento = 'S'
GROUP BY as_cuenta, as_oficina_dest


SELECT @w_bcp = @w_s_app + 's_app bcp -auto -login ' + 'cob_conta_super..sb_ods09_tmp' + ' out ' + @w_file_rpt_1 + ' -c -t"|" -b 5000 -e' + @w_file_rpt_1_out	+ ' -config ' + @w_s_app + 's_app.ini'
PRINT '===> ' + @w_bcp 

--Ejecucion para Generar Archivo Datos
exec @w_return = xp_cmdshell @w_bcp
	
if @w_return <> 0 
begin
  select @w_return = 70146,
  @w_msg = 'Fallo el BCP'
  goto ERROR_PROCESO
end


SALIDA_PROCESO:



update cob_conta..cb_solicitud_reportes_reg
set   sr_status = 'P' 
where sr_reporte = @w_reporte
and   sr_status = 'I'

if @@error != 0
begin
    select @w_return = 710002
    goto ERROR_PROCESO
end

return 0

ERROR_PROCESO:
set transaction isolation level read uncommitted

exec @w_return       = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @i_param1,
     @i_origen_error = @w_return,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

return @w_return

go

