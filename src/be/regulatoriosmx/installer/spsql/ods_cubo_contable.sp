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
@w_dp_area           VARCHAR(255),
@w_member_code       varchar(255),
@w_return            INT,
@w_empresa           TINYINT,
@w_fecha_proceso     DATETIME,
@w_file_rpt          varchar(100),
@w_file_rpt_1        varchar(140),
@w_file_rpt_1_out    varchar(140),
@w_bcp               varchar(2000),
@w_path_destino      varchar(200),
@w_s_app             varchar(40),
@w_fecha_r           varchar(10),
@w_mes               varchar(2),
@w_dia               varchar(2),
@w_anio              varchar(4),
@w_ciudad_nacional   int,
@w_fecha_piv         datetime,
@w_cont              int,
@w_reporte           VARCHAR(10),
@w_fecha_fin         datetime,
@w_re_area           smallint,
@w_corte_fin         int,
@w_periodo_fin       int,
@w_fecha_ini         datetime


SELECT @w_sp_name       = 'sp_ods_9_cubo_contable',
       @w_fecha_proceso = @i_param1

select @w_empresa = pa_tinyint 
from   cobis..cl_parametro
where  pa_nemonico = 'EMP' 
and pa_producto    = 'ADM'

if @@rowcount <> 1 
begin
   select 
		@w_return = 101254,
	    @w_msg = 'NO ESTA DEFINIDA LA EMPRESA CONTABLE'
   goto ERROR_PROCESO
end

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

SELECT @w_reporte = 'ODS09'

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

select @w_path_destino = pp_path_destino
from   cobis..ba_path_pro
where  pp_producto = 36 -- REGULATORIOS


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

select @w_fecha_fin   = dateadd(dd,0-datepart(dd,@w_fecha_proceso),@w_fecha_proceso),
       @w_fecha_ini   = dateadd(dd,1-datepart(dd,@w_fecha_proceso),@w_fecha_proceso),
       @w_cont        = 0
select
       @w_corte_fin   = ( select co_corte  from cob_conta..cb_corte where co_fecha_fin = @w_fecha_fin ),
       @w_periodo_fin = ( select co_periodo  from cob_conta..cb_corte where co_fecha_fin = @w_fecha_fin ),
       @w_fecha_piv   = @w_fecha_ini

while @w_fecha_piv <= @i_param1 
begin 
   if not exists ( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_piv) 
      select @w_cont = @w_cont +1

   select @w_fecha_piv = dateadd (dd,+1 ,@w_fecha_piv) 
end 


if @w_cont < 4 
BEGIN
   PRINT ' Aun no debe generar archivo, dias = ' + convert(VARCHAR, @w_cont)
   return 0 
END

select @w_file_rpt = 'BMXP_DIM_CUB'

--Si ya esta generado el archivo ,no se genera
if exists (select 1 from sb_ods_ult_ejec where ou_archivo = @w_file_rpt and ou_fecha = @w_fecha_fin) 
BEGIN
   PRINT ' El archivo ya fue generado para esta fecha ' + convert(VARCHAR, @w_fecha_fin)
   return 0 
END

select @w_mes         = substring(convert(varchar,@w_fecha_fin, 101),1,2)
select @w_dia         = substring(convert(varchar,@w_fecha_fin, 101),4,2)
select @w_anio        = substring(convert(varchar,@w_fecha_fin, 101),7,4)

select @w_fecha_r = @w_anio + @w_mes + @w_dia


select @w_file_rpt_1     = @w_path_destino + @w_file_rpt + '_' + @w_fecha_r + '.txt'
select @w_file_rpt_1_out = @w_path_destino + @w_file_rpt + '_' + @w_fecha_r + '.err'


TRUNCATE TABLE sb_ods09_tmp
  
INSERT INTO sb_ods09_tmp
SELECT @w_anio,
       '14',
       @w_mes,
       'MXN',
       hi_cuenta,
       convert(VARCHAR,hi_oficina),
       '+',
       convert(VARCHAR,sum(isnull(hi_debito,0))),
       '+',
       convert(VARCHAR,sum(isnull(hi_credito,0))),
       CASE WHEN sum(isnull(hi_debito,0)) >= sum(isnull(hi_credito,0)) THEN '+' ELSE '-' END,
       convert(VARCHAR,abs(sum(isnull(hi_debito,0)) - sum(isnull(hi_credito,0))))
from cob_conta_his..cb_hist_saldo, cob_conta..cb_cuenta 
where cu_cuenta     = hi_cuenta 
and   cu_empresa    = hi_empresa
and   cu_empresa    = @w_empresa
and   cu_movimiento = 'S'
and   hi_periodo    =  @w_periodo_fin 
and   hi_corte      =  @w_corte_fin
group by  hi_cuenta,hi_oficina,hi_periodo,hi_corte

SELECT @w_bcp = @w_s_app + 's_app bcp -auto -login ' + 'cob_conta_super..sb_ods09_tmp' + ' out ' + @w_file_rpt_1 + ' -c -t"|" -b 5000 -e' + @w_file_rpt_1_out + ' -config ' + @w_s_app + 's_app.ini'
PRINT '===> ' + @w_bcp 

--Ejecucion para Generar Archivo Datos
exec @w_return = xp_cmdshell @w_bcp

if @w_return <> 0 
begin
  select @w_return = 70146,
  @w_msg = 'Fallo el BCP'
  goto ERROR_PROCESO
end

-- marcar la generacion del archivo
insert into sb_ods_ult_ejec values (@w_file_rpt, @w_fecha_fin)
  

SALIDA_PROCESO:

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

