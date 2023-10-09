use cob_conta_super
go
/************************************************************/
/*   ARCHIVO:         sp_apctas_n4.sp                       */
/*   NOMBRE LOGICO:   sp_rpt_apertura_cuentas               */
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
/*  Genera los datos para el "Reporte de Apertura           */
/*  de Cuentas N4".											*/
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR         RAZON                      */
/* 16/AGO/2019    MDiaz          Emision inicial            */
/************************************************************/

if exists(select 1 from sysobjects where name = 'sp_rpt_apertura_cuentas')
    drop proc sp_rpt_apertura_cuentas
go
create proc sp_rpt_apertura_cuentas (
    @i_show_version     bit       = 0,
    @i_param1           int       = 0
)as
declare
   @w_sp_name       varchar(20),
   @w_s_app         varchar(50),
   @w_path          varchar(100),
   @w_destino       varchar(2500),
   @w_msg           varchar(200),
   @w_error         int,
   @w_errores       varchar(1500),
   @w_comando       varchar(2500),
   -- ----------------------------
   @w_member_code   varchar(20),
   -- ----------------------------
   @w_dia           varchar(2),
   @w_mes           varchar(2),
   @w_ano           varchar(4),
   @w_ext_arch      varchar(6),
   @w_nom_arch      varchar(50),
   @w_nom_log       varchar(50),
   @w_fecha_default datetime,
   @w_hora            varchar(2),
   @w_fecha_proceso   datetime,
   @w_fecha_corte     datetime,
   @w_ciudad_nacional int,
   @w_contador        int =0,
   @w_fecha_proc     datetime,
   @w_fecha_fin          varchar(10)
   
 print '@i_param1'+ convert(varchar(10),@i_param1)

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = 36432

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

select @w_fecha_proceso=fp_fecha 
from cobis..ba_fecha_proceso
--Ingresa borrando la tabla temporal
truncate table cob_conta_super..sb_cuentas_N4_tmp

if(@i_param1 =1)
begin

 select @w_fecha_corte  = dateadd(dd,-1,@w_fecha_proceso)
 
 while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_corte)
 begin
    if datepart(dd, @w_fecha_corte) != 1 select @w_fecha_corte = dateadd(dd, -1, @w_fecha_corte) else break
 end
 
 select 
 @w_dia = right('00'+convert(varchar(2),datepart(dd, @w_fecha_corte)  ),2),
 @w_mes = right('00'+convert(varchar(2),datepart(mm, @w_fecha_corte)  ),2),
 @w_ano = convert(varchar(4),datepart(yyyy, @w_fecha_corte))

end
else 
begin

	select 
	@w_dia = right('00'+convert(varchar(2),datepart(dd, @w_fecha_proceso)  ),2),
	@w_mes = right('00'+convert(varchar(2),datepart(mm, @w_fecha_proceso)  ),2),
	@w_ano = convert(varchar(4),datepart(yyyy, @w_fecha_proceso))

end

select @w_hora = convert(varchar(2),datepart(hh, getdate()))

----------------------- Inicio Poblar data -----------------------
declare @entes table (
	cn_ente		 			varchar(20),
	cn_p_apellido			varchar(50),
	cn_s_apellido 			varchar(50),
	cn_nombres				varchar(50),
	cn_num_sucursal			varchar(10),
	cn_rfc					varchar(20),
	cn_sexo					varchar(10),
	cn_nacionalidad_id     catalogo,	
	cn_edo_civil			varchar(20),
	cn_celular				varchar(20),
	cn_correo_electronico	varchar(100),
	cn_fecha_ingreso		varchar(20),
	cn_oficina_id     		catalogo,
	cn_colonia				varchar(100),
	cn_cod_postal			varchar(10),
	cn_ingreso_men_neto		varchar(50),
	cn_procesado			varchar(1) default 'N',
	cn_nacionalidad			varchar(100),
	cn_oficina				varchar(100)
)

insert into @entes
select
	en_ente,		    															-- Número de Empleado
	p_p_apellido,       															-- Primer Apellido
	p_s_apellido,       															-- Segundo Apellido
	en_nombre,	        															-- Nombre (s)
	'0398' as sucursal, 															-- Número de Sucursal
	en_nit,--en_rfc,																			-- RFC
	case p_sexo when 'M' then 'MASCULINO' else 'FEMENINO' end as sexo, 				-- Sexo
	en_nacionalidad, 										-- Nacionalidad
	case p_estado_civil 
		when 'CA' then case p_sexo when 'M' then 'CASADO' else 'CASADA' end
		when 'DI' then case p_sexo when 'M' then 'DIVORCIADO' else 'DIVORCIADA' end
		when 'SO' then case p_sexo when 'M' then 'SOLTERO' else 'SOLTERA' end
		when 'VI' then case p_sexo when 'M' then 'VIUDO' else 'VIUDA' end
		else 'UNION LIBRE' 															-- Estado Civil
	end as estado_civil, 															-- Sexo
	'' as celular, 																	-- Celular
	'' as correo, 																	-- Correo Electrónico
	CONVERT(VARCHAR(10), en_fecha_crea, 103)as fecha_ingreso, 												-- Fecha de Ingreso a la Empresa
	en_oficina, 																	-- Domicilio de Oficina
	'' as colonia, 																	-- Colonia
	'' as codigo_postal, 															-- Código Postal
	'$17,000.00' as ingreso_men_neto, 												-- Ingreso Mensual Neto
	'N',
	'MEXICO',
	'0'
from cobis..cl_ente_aux 
inner join cobis..cl_ente on ea_ente = en_ente
where ea_cta_banco is null 
and isnull(ea_nivel_riesgo_cg, 'F') <> 'F'

delete from @entes
from sb_cuentas_N4 n, @entes e
where n.cn_ente = e.cn_ente

update @entes set
cn_nacionalidad = isnull(pa_descripcion, 'MEXICO')
from cobis..cl_pais
where cn_nacionalidad_id = pa_pais

update @entes set
cn_oficina = of_nombre
from cobis..cl_oficina
where cn_oficina_id = of_oficina

insert into sb_cuentas_N4 (
cn_ente,				cn_p_apellido,			cn_s_apellido,
cn_nombres,				cn_num_sucursal,		cn_rfc,
cn_sexo,				cn_edo_civil,			cn_celular,
cn_correo_electronico,	cn_fecha_ingreso,		cn_colonia,
cn_cod_postal,			cn_ingreso_men_neto,	cn_nacionalidad,
cn_oficina
)
select 
cn_ente,				cn_p_apellido,			cn_s_apellido,
cn_nombres,				cn_num_sucursal,		cn_rfc,
cn_sexo,				cn_edo_civil,			cn_celular,
cn_correo_electronico,	cn_fecha_ingreso,		cn_colonia,
cn_cod_postal,			cn_ingreso_men_neto,	cn_nacionalidad,
cn_oficina
from @entes

--Se insertan registros en blanco del reporte
while (@w_contador<5)
begin
insert into cob_conta_super..sb_cuentas_N4_tmp
select '' as cn_ente, '' as cn_p_apellido, 
'' as cn_s_apellido, '' as cn_nombres, '' 
as cn_num_sucursal, '' as cn_rfc, '' as cn_sexo, '' as cn_nacionalidad, 
'' as cn_edo_civil, '' as cn_celular,  '' as cn_correo_electronico, 
'' as cn_fecha_ingreso,  '' as cn_oficina, 
'' as cn_colonia,  '' as cn_cod_postal, '' as cn_ingreso_men_neto 

set @w_contador=@w_contador+1
end
--Se insertan el Registro de de AlTA DE EMPLEADOS
insert into cob_conta_super..sb_cuentas_N4_tmp
select 'ALTA DE EMPLEADOS  NOMINA SANTANDER' as cn_ente, '' as cn_p_apellido, 
'' as cn_s_apellido, '' as cn_nombres, '' 
as cn_num_sucursal, '' as cn_rfc, '' as cn_sexo, '' as cn_nacionalidad, 
'' as cn_edo_civil, '' as cn_celular,  '' as cn_correo_electronico, 
'' as cn_fecha_ingreso,  '' as cn_oficina, 
'' as cn_colonia,  '' as cn_cod_postal, '' as cn_ingreso_men_neto 

--Se insertan la data cabecera
insert into cob_conta_super..sb_cuentas_N4_tmp
select 'NUMERO DE EMPLEADO' as cn_ente,         'PRIMER APELLIDO' as cn_p_apellido, 
       'SEGUNDO APELLIDO' as cn_s_apellido,     'NOMBRE (S)' as cn_nombres, 
       'NUMERO DE SUCURSAL' as cn_num_sucursal, 'RFC' as cn_rfc, 
       'SEXO' as cn_sexo,                       'NACIONALIDAD' as cn_nacionalidad, 
       'ESTADO CIVIL' as cn_edo_civil, 'CELULAR' as cn_celular, 
       'CORREO ELECTRONICO' as cn_correo_electronico,  'FECHA DE INGRESO A LA EMPRESA' as cn_fecha_ingreso, 
       'DOMICILIO DE OFICINA' as cn_oficina, 'COLONIA' as cn_colonia, 
       'CODIGO POSTAL' as cn_cod_postal, 'INGRESO MENSUAL NETO' as cn_ingreso_men_neto 
--Se insertan registros nuevos       
insert into cob_conta_super..sb_cuentas_N4_tmp
     select cn_ente,isnull(cn_p_apellido,''),
       isnull(cn_s_apellido,''),isnull(cn_nombres,''),
       char(61)+char(34)+cast(cn_num_sucursal as varchar(20))+char(34),
       isnull(cn_rfc,''),
       isnull(cn_sexo,''),isnull(cn_nacionalidad,''),
       isnull(cn_edo_civil,''),isnull(cn_celular,''),
       isnull(cn_correo_electronico,''),isnull(cn_fecha_ingreso,''),
       isnull(cn_oficina,''),isnull(cn_colonia,''),
       isnull(cn_cod_postal,''),isnull(cn_ingreso_men_neto,'')
       from cob_conta_super..sb_cuentas_N4 where cn_procesado = 'N'order by cn_ente desc
       
--select * from cob_conta_super..sb_cuentas_N4_tmp


----------------------- Fin Poblar data -----------------------


-- FECHA POR DEFECTO
select @w_fecha_default = '01/01/1900'
-- -------------------------------------------------------------------------------
-- NOMBRE DEL ARCHIVO - INI
select @w_member_code = pa_char
from cobis..cl_parametro
where pa_nemonico='APERN4'--='BCCU'
and pa_producto='REC'--='CRE'

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

--select 
--@w_dia = right('00'+convert(varchar(2),datepart(dd, getdate())  ),2),
--@w_mes = right('00'+convert(varchar(2),datepart(mm, getdate())  ),2),
--@w_ano = convert(varchar(4),datepart(yyyy, getdate())),
--@w_hora = convert(varchar(2),datepart(hh, getdate()))

select @w_nom_arch = @w_member_code + '_' + @w_ano + @w_mes + @w_dia + @w_hora + '.xls'
select @w_nom_log  = @w_member_code + '_' + @w_ano + @w_mes + @w_dia + @w_hora +'.err'

declare @cn_sql varchar(max)
select @cn_sql = 'select cn_ente_tmp,cn_p_apellido_tmp,cn_s_apellido_tmp,cn_nombres_tmp,cn_num_sucursal_tmp,cn_rfc_tmp,cn_sexo_tmp,cn_nacionalidad_tmp,cn_edo_civil_tmp,cn_celular_tmp,cn_correo_electronico_tmp,cn_fecha_ingreso_tmp,cn_oficina_tmp,cn_colonia_tmp,cn_cod_postal_tmp,cn_ingreso_men_neto_tmp from cob_conta_super..sb_cuentas_N4_tmp'

select @w_destino = @w_path + @w_nom_arch, 
       @w_errores = @w_path + @w_nom_log 

select @w_comando = 'bcp "' + @cn_sql + '" queryout "'
select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'

exec @w_error = xp_cmdshell @w_comando

if @@error != 0
begin
    select @w_error = 710002
    goto ERROR_PROCESO
end
else
begin

select @w_fecha_fin=convert(varchar(20),@w_mes)+'/'+convert(varchar(20),@w_dia)+'/'+convert(varchar(20),@w_ano)
select @w_fecha_proc=convert (datetime ,@w_fecha_fin)

	update sb_cuentas_N4 set
	cn_procesado = 'S',
	cn_fecha_pro = isnull(@w_fecha_proc,getdate()),
	cn_fecha_real=getdate()
	where cn_procesado = 'N'
end

if @w_error <> 0 begin
   print 'Error generando Reporte Apertura de Cuentas N4'
   print @w_comando
   return 1
end

SALIDA_PROCESO:
return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_msg, 'ERROR GENERAL DEL PROCESO')
     exec cob_conta_super..sp_errorlog
     @i_fuente        = @w_sp_name,
     @i_origen_error  = @w_error,
     @i_descrp_error  = @w_msg
go