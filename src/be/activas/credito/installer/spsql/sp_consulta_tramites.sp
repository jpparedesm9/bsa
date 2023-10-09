/************************************************************************/
/*  Archivo:                sp_consulta_tramites.sp                     */
/*  Stored procedure:       sp_reporte_tramites                         */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           --------                                    */
/*  Fecha de Documentacion: 19/03/2021                                  */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Realiza consultas de los clientes para generar la reimpresión de     */
/* documentos                                                           */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  19/03/2021 O. Hernandez          Emision Inicial                    */
/* **********************************************************************/
use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_reporte_tramites')
    drop proc sp_reporte_tramites
go

create proc sp_reporte_tramites
  @i_param1     datetime   =   null -- FECHA DE PROCESO

as

declare 
@w_fecha                   smalldatetime,
@w_fecha_ini               datetime,
@w_sp_name                 varchar(30),
@w_return                  int,
@w_s_app                   varchar(255),
@w_path                    varchar(255),
@w_nombre                  varchar(255),
@w_nombre_cab              varchar(255),
@w_destino                 varchar(2500),
@w_destino_detalle         varchar(2500),
@w_destino_cabecera        varchar(2500),
@w_errores                 varchar(1500),
@w_error                   int,
@w_comando                 varchar(3500),
@w_nombre_plano            varchar(2500),
@w_mensaje                 varchar(255),
@w_msg                     varchar(255),
@w_columna                 varchar(50),
@w_col_id                  int,
@w_cabecera                varchar(5000),
@w_cont                    int,
@w_fecha_piv               datetime,
@w_fecha_ini_mes           datetime,
@w_fecha_fin_mes           datetime,
@w_dia_primero             datetime,
@w_dia_segundo             datetime,
@w_dia_tercero             datetime


/* Captura del nombre del Stored Procedure */
select @w_sp_name = 'sp_reporte_tramites'


print 'Start proces'


if @i_param1 is null 
begin
	select @i_param1 = fp_fecha from cobis..ba_fecha_proceso
end

IF OBJECT_ID('info_rango_tmp') is not null
       drop table cob_credito..info_rango_tmp


IF OBJECT_ID('reporte_mensual_tram') is not null
       drop table cob_credito..reporte_mensual_tram

select @w_fecha = @i_param1

SELECT @w_cont = 0
SELECT @w_fecha_ini_mes = convert(datetime, right('00' + convert(varchar, datepart(MM, @w_fecha)), 2) + '/01/' + convert(varchar, datepart(yyyy, @w_fecha)))
SELECT @w_fecha_piv = @w_fecha_ini_mes

while @w_cont < 3
begin
   if not exists (select 1 from cobis..cl_dias_feriados where df_ciudad = 1  and df_fecha = @w_fecha_piv)
   begin
	  select @w_cont = @w_cont + 1
   end
   if @w_cont = 1
   begin
      select @w_dia_primero = @w_fecha_piv
   end
   if @w_cont = 2 
   begin
      select @w_dia_segundo = @w_fecha_piv
   end
   if @w_cont = 3 
   begin
      select @w_dia_tercero = @w_fecha_piv
   end
   select @w_fecha_piv = dateadd(dd,1,@w_fecha_piv)
end 

if @w_fecha != @w_dia_primero and @w_fecha != @w_dia_segundo and @w_fecha != @w_dia_tercero
begin
   print' SALE porque solo debe ejecutarse los 3 primeros dias habiles.'
   return 0
end

SELECT @w_fecha_fin_mes = dateadd(dd,-1,@w_fecha_ini_mes)  
SELECT @w_fecha_ini_mes = dateadd(MM,-1,@w_fecha_ini_mes)

SELECT cliente = vd_cliente,                                      tramite = vd_tramite,
       respuesta_bs = vd_respuesta,                               --len = len(replace(vd_respuesta,';','')),
       respuesta_sin = replace(vd_respuesta,';',''),              respuesta = convert(varchar (255),''),  
       fecha_elaboracion = convert(VARCHAR(30),vd_fecha,103),     tipo = convert(varchar(1),''),
       grupo = convert(INT,0),                                    banco_ind = convert(varchar(255),''),
       rfc = convert(varchar(255),''),                            curp = convert(varchar(255),''),                      
       pregunta_01 = convert(varchar (255),''),                   pregunta_02 = convert(varchar (255),''),
       pregunta_03 = convert(varchar (255),''),                   pregunta_04 = convert(varchar (255),''),
       pregunta_05 = convert(varchar (255),''),                   pregunta_06 = convert(varchar (255),''),
       pregunta_07 = convert(varchar (255),''),                   pregunta_08 = convert(varchar (255),''),
       pregunta_09 = convert(varchar (255),''),                   pregunta_10 = convert(varchar (255),''),
       pregunta_11 = convert(varchar (255),''),                   pregunta_12 = convert(varchar (255),''),
       pregunta_13 = convert(varchar (255),''),                   pregunta_14 = convert(varchar (255),''),
       pregunta_15 = convert(varchar (255),''),                   pregunta_16 = convert(varchar (255),''),
       pregunta_17 = convert(varchar (255),''),                   pregunta_18 = convert(varchar (255),''),
       pregunta_19 = convert(varchar (255),''),                   pregunta_20 = convert(varchar (255),''),    
       pregunta_21 = convert(varchar (255),''),                   pregunta_22 = convert(varchar (255),''),
       pregunta_23 = convert(varchar (255),''),                   pregunta_24 = convert(varchar (255),''),
       ESTATUS_TECNOLOGICO = convert(varchar (255),''),           COORDENADAS_DOMICILIO = convert(varchar (255),''),
       INGRESO_MENSUAL = convert(money,0),                        GASTOS_MENSUALES_NEGOCIO = convert(varchar (255),''),
       GASTOS_MENSUALES_FAMILIARES = convert(varchar (255),''),   OTROS_INGRESOS = convert(varchar (255),''),
       CAPACIDAD_DE_PAGO = convert(varchar (255),''),             LIMITE_DE_CREDITO_ACTUAL = convert(money,''),
       INDICADOR_DE_REUNION = convert(varchar (255),''),          COORDENADAS_NEGOCIO = convert(varchar (255),'')
INTO cob_credito..info_rango_tmp
from cob_credito..cr_verifica_datos
WHERE vd_fecha BETWEEN @w_fecha_ini_mes AND @w_fecha_fin_mes
ORDER BY tramite, cliente

update cob_credito..info_rango_tmp
set tipo = 'G',
    banco_ind = tg_prestamo,
    grupo = tg_grupo
from cob_credito..cr_tramite_grupal
where tg_tramite = tramite

update cob_credito..info_rango_tmp
set tipo = 'I',
    banco_ind = op_banco
from cob_cartera..ca_operacion
where tipo <> 'G'
AND tramite = op_tramite

--ESTATUS_TECNOLOGICO varchar (255),
--GASTOS_MENSUALES NEGOCIO varchar (255), 
--GASTOS_MENSUALES FAMILIARES varchar (255),
--OTROS_INGRESOS varchar (255),
--CAPACIDAD_DE_PAGO varchar (255),
update cob_credito..info_rango_tmp
set ESTATUS_TECNOLOGICO = case upper(ea_tecnologico) when 'ALTO' then 'ALTAMENTE TECNOLOGICO' 
                                                     when 'MEDIO' then 'TECNOLOGICO' else 'NO TECNOLOGICO' END,
    GASTOS_MENSUALES_NEGOCIO = ea_ct_operativo,
    GASTOS_MENSUALES_FAMILIARES = ea_ct_ventas,    
    OTROS_INGRESOS = ea_ventas,
    CAPACIDAD_DE_PAGO = (ea_ventas + en_otros_ingresos - ea_ct_ventas - ea_ct_operativo)
from cobis..cl_ente_aux, cobis..cl_ente
where cliente = ea_ente
and ea_ente = en_ente

--COORDENADAS_DOMICILIO
update cob_credito..info_rango_tmp
set COORDENADAS_DOMICILIO = 'Latitud: '+ convert(nvarchar(32),str(dg_lat_seg , 15,10 )) +
                            ' Longitud: '+convert(nvarchar(32),str(dg_long_seg, 15,10 ))
from cobis..cl_direccion, cobis..cl_direccion_geo
where di_ente = cliente
and  di_ente = dg_ente
and di_direccion = dg_direccion
and  di_tipo = 'RE'

--COORDENADAS_NEGOCIO varchar (255),
update cob_credito..info_rango_tmp
set COORDENADAS_NEGOCIO = 'Latitud: '+ convert(nVARCHAR(32),str(dg_lat_seg , 15,10 )) +
                          ' Longitud: '+convert(nVARCHAR(32),str(dg_long_seg, 15,10 ))
from cobis..cl_direccion, cobis..cl_direccion_geo
where di_ente = cliente
and  di_ente = dg_ente
and di_direccion = dg_direccion
and  di_tipo = 'AE'

update cob_credito..info_rango_tmp
set rfc = en_rfc,
    curp = en_ced_ruc,
    INGRESO_MENSUAL = isnull(en_otros_ingresos,0)
from cobis..cl_ente
where cliente = en_ente


update cob_credito..info_rango_tmp
set LIMITE_DE_CREDITO_ACTUAL = do_monto_aprobado
from cob_conta_super..sb_dato_operacion
where do_banco = banco_ind
and do_tipo_operacion = 'REVOLVENTE'
and do_fecha = @w_fecha

--INDICADOR_DE_REUNION varchar (255),
update cob_credito..info_rango_tmp
set INDICADOR_DE_REUNION  =  gr_dir_reunion
from cobis..cl_grupo
where gr_grupo = grupo


UPDATE cob_credito..info_rango_tmp
SET respuesta = case when substring(respuesta_sin,13,1) = 'N' 
then (substring(respuesta_sin,1,13) + '_'+ substring(respuesta_sin,14,len(respuesta_sin))) else respuesta_sin end
--WHERE tipo = 'G'

UPDATE cob_credito..info_rango_tmp
SET respuesta = case when substring(respuesta_sin,14,1) NOT in (SELECT C.codigo FROM cobis..cl_tabla T, cobis..cl_catalogo C 
                                                            WHERE T.tabla = 'cr_frecuencia' AND T.codigo = C.tabla)
                then (substring(respuesta_sin,1,13) + '_'+ substring(respuesta_sin,14,len(respuesta_sin))) else respuesta end

    
UPDATE cob_credito..info_rango_tmp
SET respuesta = case when substring(respuesta,19,1) IN ('D','M','S','F','N','W','O','P','R') 
                     then (substring(respuesta,1,17) + '_' + substring(respuesta,18,LEN(respuesta))) ELSE respuesta END
WHERE LEN(respuesta) > 17 

UPDATE cob_credito..info_rango_tmp
SET respuesta = case when substring(respuesta,21,1) = 'N' 
                          then (substring(respuesta,1,21) + '_'+ substring(respuesta,21,len(respuesta))) else respuesta end
WHERE LEN(respuesta) > 17 



UPDATE cob_credito..info_rango_tmp
SET respuesta = case when substring(respuesta,23,1) = 'N' 
               then (substring(respuesta,1,23) + '_'+ substring(respuesta,24,len(respuesta))) else respuesta end


update cob_credito..info_rango_tmp
set pregunta_01 = substring(respuesta,1,1),
    pregunta_02 = substring(respuesta,2,1),
    pregunta_03 = substring(respuesta,3,1),
    pregunta_04 = substring(respuesta,4,1),
    pregunta_05 = substring(respuesta,5,1),
    pregunta_06 = substring(respuesta,6,1),
    pregunta_07 = substring(respuesta,7,1),
    pregunta_08 = substring(respuesta,8,1),
    pregunta_09 = substring(respuesta,9,1),
    pregunta_10 = substring(respuesta,10,1),
    pregunta_11 = substring(respuesta,11,1),
    pregunta_12 = substring(respuesta,12,1),
    pregunta_13 = substring(respuesta,13,1),
    pregunta_14 = substring(respuesta,14,1),
    pregunta_15 = substring(respuesta,15,1),
    pregunta_16 = substring(respuesta,16,1),
    pregunta_17 = substring(respuesta,17,1),
    pregunta_18 = substring(respuesta,18,2),
    pregunta_19 = substring(respuesta,20,1),
    pregunta_20 = substring(respuesta,21,1),
    pregunta_21 = substring(respuesta,22,1),
    pregunta_22 = substring(respuesta,23,1),
    pregunta_23 = substring(respuesta,24,1),
    pregunta_24 = substring(respuesta,25,1)
--WHERE tipo = 'G'

update cob_credito..info_rango_tmp
set pregunta_14 = pregunta_14 + ' - ' + valor 
FROM cobis..cl_tabla T, cobis..cl_catalogo C WHERE T.tabla = 'cr_frecuencia' AND T.codigo = C.tabla AND ltrim(C.codigo) = ltrim(pregunta_14)
--and tipo = 'G'

update cob_credito..info_rango_tmp
set pregunta_15 = pregunta_15 + ' - ' + valor 
FROM cobis..cl_tabla T, cobis..cl_catalogo C WHERE T.tabla = 'cr_redes_sociales' AND T.codigo = C.tabla AND ltrim(C.codigo) = ltrim(pregunta_15)
--and tipo = 'G'

update cob_credito..info_rango_tmp
set pregunta_16 = pregunta_16 + ' - ' + valor 
FROM cobis..cl_tabla T, cobis..cl_catalogo C WHERE T.tabla = 'cr_tipo_telefono' AND T.codigo = C.tabla AND ltrim(C.codigo) = ltrim(pregunta_16)
--and tipo = 'G'

update cob_credito..info_rango_tmp
set pregunta_17 = pregunta_17 + ' - ' + valor 
FROM cobis..cl_tabla T, cobis..cl_catalogo C WHERE T.tabla = 'cr_tipo_pago_telefono' AND T.codigo = C.tabla AND ltrim(C.codigo) = ltrim(pregunta_17)
--and tipo = 'G'

update cob_credito..info_rango_tmp
set pregunta_21 = pregunta_21 + CASE WHEN ltrim(pregunta_21) = 'R' THEN ' - ' + 'RETIRO DE EFECTIVO'-- 306697
                                     WHEN ltrim(pregunta_21) = 'C' THEN ' - ' + 'CONSULTA DE SALDO'--                                             
                                     WHEN ltrim(pregunta_21) = 'P' THEN ' - ' + 'PAGO DE SERVICIOS'--306704 
                                     ELSE '' END                                                                                                
--WHERE tipo = 'G'

update cob_credito..info_rango_tmp
set pregunta_23 = pregunta_23 + CASE WHEN ltrim(pregunta_23) = 'R' THEN ' - ' + 'RETIRO DE EFECTIVO'-- 306697
                                     WHEN ltrim(pregunta_23) = 'C' THEN ' - ' + 'CONSULTA DE SALDO'--
                                     WHEN ltrim(pregunta_23) = 'D' THEN ' - ' + 'DEPOSITO'
                                     WHEN ltrim(pregunta_23) = 'P' THEN ' - ' + 'PAGO DE SERVICIOS'--306704
                                     ELSE '' END  

UPDATE cob_credito..info_rango_tmp
SET pregunta_14 = replace(pregunta_14,'_',''),
    pregunta_15 = replace(pregunta_15,'_',''),
    pregunta_16 = replace(pregunta_16,'_',''),
    pregunta_17 = replace(pregunta_17,'_',''),
    pregunta_18 = replace(pregunta_18,'_',0),
    pregunta_19 = replace(pregunta_19,'_',''),
    pregunta_20 = replace(pregunta_20,'_',''),
    pregunta_21 = replace(pregunta_21,'_',''),
    pregunta_22 = replace(pregunta_22,'_',''),
    pregunta_23 = replace(pregunta_23,'_',''),
    pregunta_24 = replace(pregunta_24,'_','')


SELECT 'RFC' = rfc,                               
       'CURP' = curp,                    
       'CLIENTE' = cliente,                                      
       'TRAMITE'  = tramite,
       'GRUPO' = grupo,                             
	   'BANCO' = banco_ind,
       'FECHA_ELABORACION' = fecha_elaboracion,	   
       --respuesta_bs,    
       pregunta_01,                       pregunta_02,
       pregunta_03,                       pregunta_04,
       pregunta_05,                       pregunta_06,
       pregunta_07,                       pregunta_08,
       pregunta_09,                       pregunta_10,
       pregunta_11,                       pregunta_12,
       pregunta_13,                       pregunta_14,
       pregunta_15,                       pregunta_16,
       pregunta_17,                       pregunta_18,
       pregunta_19,                       pregunta_20,   
       pregunta_21,                       pregunta_22,
       pregunta_23,                       pregunta_24,
       ESTATUS_TECNOLOGICO,               COORDENADAS_DOMICILIO,
       INGRESO_MENSUAL,                   GASTOS_MENSUALES_NEGOCIO,
       GASTOS_MENSUALES_FAMILIARES,       OTROS_INGRESOS,
       CAPACIDAD_DE_PAGO,                 LIMITE_DE_CREDITO_ACTUAL,
       INDICADOR_DE_REUNION,              COORDENADAS_NEGOCIO

INTO cob_credito..reporte_mensual_tram
FROM info_rango_tmp ORDER BY fecha_elaboracion


	--Tabla temporal para filtrar clientes con grupo 0
	
	IF OBJECT_ID('reporte_mensual_tram_2') is not null
		   drop table cob_credito..reporte_mensual_tram_2

	select * into cob_credito..reporte_mensual_tram_2 from cob_credito..reporte_mensual_tram
	delete   from cob_credito..reporte_mensual_tram_2 where GRUPO = 0
	delete   from cob_credito..reporte_mensual_tram where GRUPO = 0


print ' Finalizo el proceso'
/*** GENERAR BCP ***/
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 21

select @w_comando = @w_s_app + 's_app bcp -auto -login cob_credito..reporte_mensual_tram_2 out '
select 
@w_destino_detalle  = @w_path + 'reporte_tramites_detalle' + replace(CONVERT(varchar(10), @w_fecha_ini_mes,103),'/', '')+ '.txt',
@w_destino_cabecera = @w_path + 'reporte_tramites_cabecera'   + REPLACE(CONVERT(VARCHAR(10), @w_fecha_ini_mes, 103),'/', '')+ '.txt',	
@w_destino  = @w_path + 'repcuest-' + right('00' + convert(varchar,datepart(mm,@w_fecha_ini_mes)),2) + right('00' + convert(varchar,datepart(yy,@w_fecha_ini_mes)),2) + '.txt',
@w_errores  = @w_path + 'repcuest-' + right('00' + convert(varchar,datepart(mm,@w_fecha_ini_mes)),2) + right('00' + convert(varchar,datepart(yy,@w_fecha_ini_mes)),2) + '.err'

select @w_comando = @w_comando + @w_destino_detalle + ' -b5000 -c -e' + @w_errores + ' -t"\t" ' + '-config '+ @w_s_app + 's_app.ini'

PRINT ' CMD: ' + @w_comando 

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 
begin
   select
   @w_error = 70171,
   @w_mensaje = 'Error generando Archivo de Consulta de tramites Mensual'
   goto ERROR_PROCESO
end

--------------------
--CABECERA
--------------------
select
    @w_col_id   = 0,
    @w_columna='',
    @w_cabecera=''

	while 1 = 1 begin
	   set rowcount 1
	    select @w_columna = c.name,
	         @w_col_id  = c.colid
	  	 from cob_credito..sysobjects o, cob_credito..syscolumns c
	  	 where o.id    = c.id
	  	 and   o.name  = 'reporte_mensual_tram'
	  	 and   c.colid > @w_col_id
	  	 order by c.colid
	    
	   if @@rowcount = 0 begin
	      set rowcount 0
	      break
	   end
	
	   select @w_cabecera = @w_cabecera +'   '+@w_columna 
	end

  select @w_cabecera = substring(@w_cabecera,4,LEN(@w_cabecera))  

    --Escribir Cabecera
	select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_destino_cabecera
	
	exec @w_error = xp_cmdshell @w_comando
	
	if @w_error <> 0 begin
	   select
	   @w_error = 141080,
	   @w_mensaje = 'Error generando Archivo de Cabeceras Reporte mensual de tramites'
	   goto ERROR_PROCESO
	end
	
	select @w_comando = 'copy ' + @w_destino_cabecera + ' + ' + @w_destino_detalle + ' ' + @w_destino
	select  '@w_comando3>> '+ convert(VARCHAR(300),@w_comando)
	
	exec @w_error = xp_cmdshell @w_comando
	
	if @w_error <> 0 begin
	   select
	   @w_error = 70171,
	   @w_mensaje = 'Error generando Archivo Completo de Reporte Mensual de tramites'
	   goto ERROR_PROCESO
	end
    
	--Tabla Temporal sin Clientes en Grupo 0	
	drop table cob_credito..reporte_mensual_tram_2
	
----------------------------------------
--Borrar Archivo de Cabeceras
----------------------------------------
select @w_comando = 'del /F ' + @w_destino_cabecera

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724679,
   @w_mensaje = 'Error eliminando archivo temporal de cabeceras'
   goto ERROR_PROCESO
END  

----------------------------------------
--Borrar Archivo de Detalle
----------------------------------------
select @w_comando = 'del /F ' + @w_destino_detalle

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724679,
   @w_mensaje = 'Error eliminando archivo temporal de detalles'
   goto ERROR_PROCESO
END  


--ERROR GENERAL DEL PROCESO 
return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_mensaje, 'ERROR GENERAL DEL PROCESO')
	 
     exec cob_cartera..sp_errorlog
	 @i_error         = @w_error,
     @i_fecha         = @w_fecha,  
	 @i_usuario       = 'usrbatch',
	 @i_tran          = 26004,
	 @i_tran_name     = @w_sp_name,
     @i_rollback    = 'N',
     @i_descripcion = @w_msg   

return @w_error

