/***************************************************************************/
/*   Archivo:                 cr_rep_buro_batch.sp                         */ 
/*   Stored procedure:        sp_reporte_buro_batch                        */
/*   Base de Datos:           cob_credito                                  */
/*   Producto:                Credito                                      */
/*   Disenado por:            Maria Jose Taco                              */
/*   Fecha de Documentacion:  01/29/2020                                   */
/***************************************************************************/
/*                            IMPORTANTE                                   */
/*   Este programa es parte de los paquetes bancario s propiedad de        */
/*   'COBIS'.                                                              */
/*   Su uso no autorizado queda expresamente prohibido asi como            */
/*   cualquier autorizacion o agregado hecho por alguno de sus             */
/*   usuario sin el debido consentimiento por escrito de la                */
/*   Presidencia Ejecutiva de COBIS o su representante                     */
/***************************************************************************/
/*                         PROPOSITO                                       */
/*                     Reporte de Cobranza                                 */
/*	 Reporte de las consultas de los clientes en buro de credito           */
/***************************************************************************/
/*                     MODIFICACIONES                                      */
/* FECHA                AUTOR                DETALLE                       */
/*13-02-2020			ALD				135235 Se agregan campos a reporte */
/***************************************************************************/

use cob_credito
go 

if exists(select 1 from sysobjects where name = 'sp_reporte_buro_batch')
    drop proc sp_reporte_buro_batch
go

create proc sp_reporte_buro_batch  
(
    @i_param1           datetime   =   null ,
	@i_param2           datetime   =   null 
)as

DECLARE
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
  @t_show_version   int,
  @w_fecha_desde    datetime,
  @w_fecha_hasta    datetime,
  @w_cmd            varchar(1000),
  @w_destino        varchar(1000),
  @w_comando        varchar(1000),
  @w_errores        varchar(1000),
  @w_ciudad_nacional       int
  
select @w_sp_name = 'sp_reporte_buro_batch'

--Versionamiento del Programa
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.1.0.0'
  return 0
end

truncate table cr_buro_diario

-- -------------------------------------------------------------------------------
-- DIRECCION DEL ARCHIVO A GENERAR
-- -------------------------------------------------------------------------------
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

if (@i_param1 = @i_param2)
begin
  
   select @w_fecha_desde = dateadd(dd,-1,@i_param1),
          @w_fecha_hasta = @i_param2
          
   while exists(select 1 from cobis..cl_dias_feriados where df_ciudad=@w_ciudad_nacional and df_fecha=@w_fecha_desde) 
   begin
      select @w_fecha_desde = dateadd(dd,-1,@w_fecha_desde) 
   end       

   select @w_fecha_hasta = dateadd(dd,1,@w_fecha_desde)      
end
else
begin
   select @w_fecha_desde = @i_param1,
          @w_fecha_hasta = @i_param2

   select @w_fecha_hasta = dateadd(dd,1,@w_fecha_hasta)      

   --print 'desde'+convert(varchar(10),@w_fecha_desde,103)
   --print 'hasta'+convert(varchar(10),@w_fecha_hasta,103)
end
             
--DETERMINAR UNIVERSO DE REGISTROS A REPORTAR 
SELECT 
ib_cliente AS 'aa1',
CASE WHEN ea_estado='A'THEN 'CLIENTE' ELSE 'PROSPECTO' END  AS 'aa2',
en_nomlar as 'aa3',
en_banco as 'aa4',
ib_fecha AS 'aa5',
bc_forma_pago_actual as 'aa6',
bc_historico_pagos as 'aa7',
bc_saldo_vencido as 'aa8',
bc_tipo_contrato as 'aa9',
SUBSTRING(bc_fecha_cierre_cuenta,1,2) + '/' +SUBSTRING(bc_fecha_cierre_cuenta,3,2) + '/' + SUBSTRING(bc_fecha_cierre_cuenta,5,4) as 'aa10',
bc_clave_observacion as 'aa11', 
bc_clave_otorgante as 'aa12',
bc_tipo_cuenta as 'aa13', 
bc_indicador_tipo_responsabilidad as 'aa14',
SUBSTRING(bc_fecha_apertura_cuenta,1,2) + '/' +SUBSTRING(bc_fecha_apertura_cuenta,3,2) + '/' + SUBSTRING(bc_fecha_apertura_cuenta,5,4) as 'aa15' ,
bc_credito_maximo as 'aa16',
bc_saldo_actual as 'aa17',
bc_frecuencia_pagos as 'aa18',
bc_nombre_otorgante as 'aa19',
--------------------
bc_fecha_cierre_cuenta as 'aa20',
datediff(mm,(convert(datetime,
             SUBSTRING(bc_fecha_cierre_cuenta,1,2) + '/' 
            +SUBSTRING(bc_fecha_cierre_cuenta,3,2) + '/' + 
			 SUBSTRING(bc_fecha_cierre_cuenta,5,4),103)),GETDATE()) as 'aa21',
p_calif_cliente as 'aa22',
ea_nivel_riesgo_cg as 'aa23'
INTO #reporte_buro_diario_tmp
FROM cob_credito..cr_interface_buro inner join cobis..cl_ente on ib_cliente = en_ente
LEFT join cob_credito..cr_buro_cuenta on ib_secuencial = bc_ib_secuencial
inner join cobis..cl_ente_aux ON en_ente = ea_ente
WHERE ib_estado     = 'V'
and ib_fecha BETWEEN @w_fecha_desde AND @w_fecha_hasta


select * 
into #reporte_buro_diario
from #reporte_buro_diario_tmp
where (aa20 is null or aa21 <=12 or aa6 = '99')


insert into cr_buro_diario(
bd_cod_cliente,      bd_tipo_cliente,          bd_nombre,
bd_buc,              bd_fecha_act,             bd_forma_pago,
bd_hist_pagos,       bd_saldo_vencido,         bd_tipo_contrato,
bd_fecha_cierre,     bd_clave_obs,             bd_clave_otorgante,
bd_tipo_cuenta,      bd_tipo_respon,           bd_fecha_apert_cta,
bd_credito_max,      bd_saldo_act,             bd_frec_pago,
bd_nombre_otorgante, bd_nivel_riesgo,		   bd_riesgo_individual)
select 
'COD_CLIENTE',       'TIPO_CLIENTE',           'NOMBRE',
'BUC',               'FECHA_ACT',              'FORMA_PAGO',	
'HIST_PAGOS',	     'SALDO_VENCIDO',	       'TIPO_CONTRATO',	
'FECHA_CIERRE',      'CLAVE_OBSERVACION',      'CLAVE_OTORGANTE',
'TIPO_CUENTA',       'TIPO_RESPONSABILIDAD',   'FECHA_DE_APERTURA_CTA',
'CREDITO_MAXIMO',    'SALDO_ACTUAL',           'FRECUENCIA_DE_PAGOS',
'NOMBRE_OTORGANTE',	 'NIVEL RIESGO',		   'RIESGO INDIVIDUAL'


if @@error != 0 begin
   select 
   @w_error = 141080,
   @w_msg_error = 'No se pudo insertar cabecera'
   goto ERROR_PROCESO
end

insert into cr_buro_diario(
bd_cod_cliente,      bd_tipo_cliente,          bd_nombre,
bd_buc,              bd_fecha_act,             bd_forma_pago,
bd_hist_pagos,       bd_saldo_vencido,         bd_tipo_contrato,
bd_fecha_cierre,     bd_clave_obs,             bd_clave_otorgante,
bd_tipo_cuenta,      bd_tipo_respon,           bd_fecha_apert_cta,
bd_credito_max,      bd_saldo_act,             bd_frec_pago,
bd_nombre_otorgante, bd_nivel_riesgo,		   bd_riesgo_individual
)													   
select
convert(varchar,a.aa1),
convert(varchar,a.aa2),
convert(varchar,a.aa3),
convert(varchar,a.aa4),
convert(varchar,a.aa5),
convert(varchar,a.aa6),
convert(varchar,a.aa7),
convert(varchar,a.aa8),
convert(varchar,a.aa9),
convert(varchar,a.aa10),
convert(varchar,a.aa11),
convert(varchar,a.aa12),
convert(varchar,a.aa13),
convert(varchar,a.aa14),
convert(varchar,a.aa15),
convert(varchar,a.aa16),
convert(varchar,a.aa17),
convert(varchar,a.aa18),
convert(varchar,a.aa19),
convert(varchar,a.aa22),
convert(varchar,a.aa23)
from  #reporte_buro_diario a

if @@error != 0 begin
   select 
   @w_error = 17049,
   @w_msg_error = 'ERROR AL INSERTAR REGISTRO EN TABLA CR_BURO_DIARIO'
   goto ERROR_PROCESO
end
--

--GENERACION DEL REPORTE 
--FORMATO DE HORAS 
select 
@w_mes   = substring(convert(varchar,@w_fecha_desde, 101),1,2),
@w_dia   = substring(convert(varchar,@w_fecha_desde, 101),4,2),
@w_anio  = substring(convert(varchar,@w_fecha_desde, 101),9,2)


--DATOS DEL ARCHIVO
select 
@w_file_rpt =  ba_arch_resultado,
@w_path     =  ba_path_destino,
@w_fecha_r  =  @w_dia + @w_mes + @w_anio 
from cobis..ba_batch 
where ba_batch = 21008

--ARMADA DEL NOMBRE DEL REPORTE 
select 
@w_file_rpt       = isnull(@w_file_rpt, 'BURO_CREDITO_'),
@w_file_rpt_1     = @w_path + @w_file_rpt + @w_fecha_r + '_' +'.txt',
@w_file_rpt_1_out = @w_path + @w_file_rpt + @w_fecha_r + '_' +'.err'

select @w_cmd     = @w_s_app + 's_app bcp -auto -login cob_credito..cr_buro_diario out '

select @w_comando = @w_cmd  +  @w_file_rpt_1  + ' -b5000 -c -T -e ' + @w_file_rpt_1_out+ ' -t"\t" ' + '-config ' + @w_s_app + 's_app.ini'


exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
  select 
  @w_return = 70146,
  @w_msg    = 'ERROR: GENERAR LISTADO'
  goto ERROR_PROCESO
end


--ERROR GENERAL DEL PROCESO 
return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_msg, 'ERROR GENERAL DEL PROCESO')
	 
     exec cob_cartera..sp_errorlog
	 @i_error         = @w_error,
	 @i_usuario       = 'usrbatch',
	 @i_tran          = 26004,
	 @i_tran_name     = null,
	 @i_rollback      = 'S'

     return @w_error

GO

