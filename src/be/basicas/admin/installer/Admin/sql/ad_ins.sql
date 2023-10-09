/************************************************************************/
/*	Archivo:		ad_ins.sql				                            */
/*	Base de datos:		cobis					                        */
/*	Producto:		Admin					                            */
/************************************************************************/
/*				IMPORTANTE				                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	'MACOSA', representantes exclusivos para el Ecuador de la 	        */
/*	'NCR CORPORATION'.						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/*				PROPOSITO				                                */
/*	Este script ingresa los datos iniciales del ADMIN		            */
/*				MODIFICACIONES				                            */
/*      FECHA           AUTOR                  RAZON                    */
/*      2014-03-24      Fernando Ortega V.     Ajustes                  */
/*      2016-04-12      BBO                    Migracion SYB-SQL FAL    */
/************************************************************************/

use cobis
go

/************************************************************************/
print 'cl_parametro'
/************************************************************************/
go

if exists (select * from cl_parametro where pa_producto='ADM')
        delete cl_parametro where pa_producto = 'ADM' and pa_nemonico != 'CULTDF'
go

insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_money, pa_producto)
values ('SMV', 'SALARIO MINIMO VITAL', 'M', $350.00 , 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_smallint, pa_producto)
values ('DIA', 'DIAS ANIO', 'S', 365, 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
values ('MDE', 'MAYORIA DE EDAD', 'T',20 , 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
values ('DVPW', 'DIAS DE VALIDEZ DEL PASSWORD', 'T', 30, 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
values ('AVPW', 'DIAS ANTES DEL AVISO DEL PASSWORD', 'T', 5, 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
values ('NINT', 'NUMERO DE INTENTOS DE CONEXION', 'T', 3, 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
values ('NMA', 'NIVEL MAXIMO DE AUTORIZACION', 'T', 8, 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto)
values ('IEAW', 'IDIOMA ETIQUETAS PARA ADMIN WEB', 'C', 'ESP' , 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_smallint, pa_producto)
values ('CP', 'CODIGO DE PAIS', 'S', 591, 'ADM')

insert into cl_parametro 
values ('CODIGO MONEDA NACIONAL','CMNAC','T',NULL,0,NULL,NULL,NULL,NULL,NULL,'ADM')

insert into cl_parametro 
values ('CODIGO MONEDA LOCAL','MLO','T',NULL,0,NULL,NULL,NULL,NULL,NULL,'ADM')

insert into cl_parametro 
values ('CODIGO DEL DOLAR NORTEAMERICANO','CDOLAR','T',NULL,2,NULL,NULL,NULL,NULL,NULL,'ADM')

insert into cl_parametro 
values ('NUMERO DE DECIMALES PARA MONEDA EXTRANJERA','DECME','T',NULL,2,NULL,NULL,NULL,NULL,NULL,'ADM')
insert into cl_parametro 
values ('NUMERO DE DECIMALES PARA MONEDA NACIONAL','DECMN','T',NULL,2,NULL,NULL,NULL,NULL,NULL,'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
values ('TMP', 'TAMANIO MINIMO DE PASSWORD', 'T', 8, 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
values ('NPCH', 'NUMERO DE PASSWORDS PARA CONTROL HISTORICO', 'T', 12, 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
values ('TML', 'TAMANIO MINIMO DE LOGIN', 'T', 6, 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
values ('ROB', 'ROL DE OPERADOR DE BATCH', 'T',2, 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_smallint, pa_producto)
values ('CFN', 'DISTRITO FERIADO NACIONAL', 'S', 9999, 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_smallint, pa_producto)
values ('DBP', 'DIAS PARA BLOQUEO DEL PASSWORD', 'S', 9, 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_tinyint, pa_producto)
values ('TLDC', 'TAMAÑO LONGITUD DE DESCRIPCION DEL CAMPO', 'T', 60, 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto)
values ('ABPAIS', 'ABREVIACION DEL PAIS', 'C', 'PA', 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto)
values ('CLIENT', 'NEMONICO DE CLIENTE', 'C', 'MIB', 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto)
values ('AMTSER', 'ACCESO A MENUS EN TRANS. DE SERVICIO', 'C', 'S', 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto) 
values ('TEDWH', 'TIPO EXTRACCION DATOS DWH', 'C', 'I',  'ADM') 
insert into cl_parametro (pa_nemonico, pa_parametro,  pa_tipo, pa_tinyint, pa_producto) 
values ('EMP', 'EMPRESA', 'T', 1, 'ADM') 
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto )
values ('PACMD', 'PATH DE ARCHIVOS CMD PARA EJECUCION DE SENTENCIAS', 'C', '/home/sybcts/binarios/s_app/', 'ADM') --'
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto )
values ('SRVR', 'SERVIDOR CENTRAL DE ADMINISTRADOR DE BRANCH', 'C', '$(TRANSERVER)', 'ADM')
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto )
values ('SRVDW', 'SERVIDOR BODEGA DE DATOS', 'C', ' DAVBGSRV', 'ADM' )
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto )
values ('SRVPR', 'SERVIDOR PORTAL REPORTES', 'C', ' CRSJCE010119VM', 'ADM' )
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto )
values ('PCP', 'COMPLEJIDAD DE PASSWORD', 'C', '100', 'ADM' )
-- Parametro TDT para controlar el tiempo de inactividad de CEN en comparacion 
-- con el valor campo ro_time_out de cada rol en la tabla cobis..ad_rol (en segundos).
-- Si el parametro es D, cierra la sesion, y si el valor es B, bloquea la estacion de trabajo Windows
insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto )
values ('TDT', 'TIPO DE DESCONEXION TIMEOUT FRONT END', 'C', 'D', 'ADM' )
go
insert into cl_parametro  (pa_parametro ,pa_nemonico,pa_tipo,pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto)
values ('NUMERO MÁXIMO DE FUNCIONALIDADES A AUTORIZAR', 'NUMFUN', 'I', null, null, null, 20, null, null, null, 'ADM')
go
insert into cl_parametro (pa_parametro, pa_nemonico , pa_tipo, pa_smallint, pa_producto)
values ('VALIDACION DE NODO', 'VALNOD', 'S',0,'ADM')
go
insert into cobis..cl_parametro 
      (pa_parametro                           ,pa_nemonico,pa_tipo, pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto)
values('CODIGO DE UNIDAD DE VALOR REFERENCIAL','CUVR'     ,'T'    ,    null,         2,       null,  null,    null,       null,    null,      'ADM')

insert into cobis..cl_parametro
      (pa_parametro                           ,pa_nemonico,pa_tipo, pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto)
values('CODIGO DE UNIDAD DE VALOR DAVIVIENDA','CUVD'     ,'T'    ,    null,          2,       null,  null,    null,       null,    null,      'ADM')
go

/************************************************************************/
print 'cl_seqnos'
/************************************************************************/
go

if exists (select * from cl_seqnos where tabla in ('cl_tabla',    'cl_pais',      'cl_ciudad',        'cl_filial',        'cl_funcionario', 
                                                   'cl_producto', 'cl_parroquia', 'ad_sis_operativo', 'ad_nodo',          'ad_nodo_oficina', 
												   'ad_rol',      'ad_procedure', 'cl_pro_oficina',   'ad_tipo_horario',  'ad_terminal', 
	                                               'te_pizarra',  'te_tasa_coap', 'te_tasa_divisas',  'te_divisa_futura', 'te_relacion_dolar', 
												   'ba_log_operador', 'cl_ofic_func', 'ts_conexion_login'))

  delete cl_seqnos where   tabla in ('cl_tabla',    'cl_pais',      'cl_ciudad',        'cl_filial',        'cl_funcionario', 
                                     'cl_producto', 'cl_parroquia', 'ad_sis_operativo', 'ad_nodo',          'ad_nodo_oficina', 
									 'ad_rol',      'ad_procedure', 'cl_pro_oficina',   'ad_tipo_horario',  'ad_terminal',
	                                 'te_pizarra',  'te_tasa_coap', 'te_tasa_divisas',  'te_divisa_futura', 'te_relacion_dolar', 
									 'ba_log_operador', 'cl_ofic_func', 'ts_conexion_login')
go

insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'cl_tabla', 0, 'codigo')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'cl_pais', 0, 'pa_pais')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'cl_ciudad', 0, 'ci_ciudad')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'cl_filial', 0, 'fi_filial')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'cl_funcionario', 0, 'fu_funcionario')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'cl_producto', 0, 'pd_producto')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'cl_parroquia', 0, 'pq_parroquia')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'ad_sis_operativo', 0, 'so_sis_operativo')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'ad_nodo', 0, 'no_nodo')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'ad_nodo_oficina', 0, 'nl_secuencial')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'ad_rol', 0, 'ro_rol')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'ad_procedure', 0, 'pd_procedure')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'cl_pro_oficina', 0, 'pl_secuencial')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'ad_tipo_horario', 0, 'th_tipo')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey)
		values	('cobis', 'ad_terminal', 0, 'te_terminal')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values  ('cobis', 'te_pizarra', 0, 'pi_cod_pizarra')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values  ('cobis', 'te_tasa_coap', 0, 'lc_num_tasa')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values  ('cobis', 'te_tasa_divisas', 0, 'td_num_tasa')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values  ('cobis', 'te_divisa_futura', 0, 'df_num_registro')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values  ('cobis', 'te_relacion_dolar', 0, 'rd_secuencial')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values	('cobis', 'ba_log_operador', 0, 'lo_sec')
insert into cl_seqnos 
        values ('cobis', 'cl_ofic_func', 0, 'of_secuencial')
--JMA CC-0006
insert into cl_seqnos 
        values ('cobis', 'ts_conexion_login', 0, 'secuencia')
go

/************************************************************************/
print 'Eliminacion de cl_catalogo'
/************************************************************************/
go
if exists (select * from cl_catalogo
  where   tabla in (select codigo
                    from cl_tabla
                   where tabla in ('cl_actividad',      'cl_cargo',           'cl_sexo',         'ad_dia_semana',        'cl_continente',
                                   'cl_estado_ser',     'cl_filial',          'cl_oficina',      'cl_moneda',            'cl_zona', 
                                   'cl_producto',       'cl_pais',            'cl_provincia',    'cl_ciudad',            'cl_parroquia', 
                                   'cl_tparroquia',     'cl_tproducto',       'cl_sector',       'cl_region_nat',        'cl_region_ope',
                                   'cl_suc_correo',     'cc_tipo_oficial',    'ad_protocolo',    'cc_sector',             
                                   'cl_tipo_ejecucion', 'cl_tipo_medio',      'te_periodos',     'te_tipo_servicio',     'te_mercado', 
                                   'ta_tipo',           'aw_prerequisitos',   'aw_idioma',       'cl_area_oficina',      'ad_tipo_tran',
                                   'cl_barrio',         'ad_windows_authentication_user',        'cl_nombre_banco',      'cl_producproc',
                                   'cl_depart_pais',    'cl_municip_seccion', 'cl_tipo_horario', 'cl_sector_geografico', 'cl_regional',
                                   'cl_tipo_punto_at',  'cl_canton',          'cl_rol_sup_agencia', 'cl_estado_ambito',  'te_grupos_tasas',
                                   'te_media_dolar',    'cl_tipo_oficina')))

delete  cl_catalogo
where   tabla in (select codigo
                    from cl_tabla
                   where tabla in ('cl_actividad',      'cl_cargo',           'cl_sexo',         'ad_dia_semana',        'cl_continente',
                                   'cl_estado_ser',     'cl_filial',          'cl_oficina',      'cl_moneda',            'cl_zona', 
                                   'cl_producto',       'cl_pais',            'cl_provincia',    'cl_ciudad',            'cl_parroquia', 
                                   'cl_tparroquia',     'cl_tproducto',       'cl_sector',       'cl_region_nat',        'cl_region_ope',
                                   'cl_suc_correo',     'cc_tipo_oficial ',   'ad_protocolo',    'cc_sector',             
                                   'cl_tipo_ejecucion', 'cl_tipo_medio',      'te_periodos',     'te_tipo_servicio',     'te_mercado', 
                                   'ta_tipo',           'aw_prerequisitos',   'aw_idioma',       'cl_area_oficina',      'ad_tipo_tran',
                                   'cl_barrio',         'ad_windows_authentication_user',        'cl_nombre_banco',      'cl_producproc',
                                   'cl_depart_pais',    'cl_municip_seccion', 'cl_tipo_horario', 'cl_sector_geografico', 'cl_regional',
                                   'cl_tipo_punto_at',  'cl_canton',          'cl_rol_sup_agencia', 'cl_estado_ambito',  'te_grupos_tasas',
                                   'te_media_dolar',    'cl_tipo_oficina'))
go

/************************************************************************/
print 'Eliminacion de cl_tabla'
/************************************************************************/
go

if exists (select * from cl_tabla 
            where tabla in ('cl_actividad',       'cl_cargo',           'cl_sexo',         'ad_dia_semana',        'cl_continente',
                            'cl_estado_ser',      'cl_filial',          'cl_oficina',      'cl_moneda',            'cl_zona', 
                            'cl_producto',        'cl_pais',            'cl_provincia',    'cl_ciudad',            'cl_parroquia', 
                            'cl_tparroquia',      'cl_tproducto',       'cl_sector',       'cl_region_nat',        'cl_region_ope',
                            'cl_suc_correo',      'cc_tipo_oficial',    'ad_protocolo',    'cc_sector',           
                            'cl_tipo_ejecucion',  'cl_tipo_medio',      'te_periodos',     'te_tipo_servicio',     'te_mercado', 
                            'ta_tipo',            'aw_prerequisitos',   'aw_idioma',       'cl_area_oficina',      'ad_tipo_tran',
                            'cl_barrio',          'ad_windows_authentication_user',        'cl_nombre_banco',      'cl_producproc',
                            'cl_depart_pais',     'cl_municip_seccion', 'cl_tipo_horario', 'cl_sector_geografico', 'cl_regional',
                            'cl_tipo_punto_at',   'cl_canton',          'cl_rol_sup_agencia', 'cl_estado_ambito',  'te_grupos_tasas',
                            'te_media_dolar',     'cl_tipo_oficina'))

delete  cl_tabla where tabla in ('cl_actividad',     'cl_cargo',           'cl_sexo',         'ad_dia_semana',        'cl_continente',
                                'cl_estado_ser',     'cl_filial',          'cl_oficina',      'cl_moneda',            'cl_zona', 
                                'cl_producto',       'cl_pais',            'cl_provincia',    'cl_ciudad',            'cl_parroquia', 
                                'cl_tparroquia',     'cl_tproducto',       'cl_sector',       'cl_region_nat',        'cl_region_ope',
                                'cl_suc_correo',     'cc_tipo_oficial',    'ad_protocolo',    'cc_sector',            
                                'cl_tipo_ejecucion', 'cl_tipo_medio',      'te_periodos',     'te_tipo_servicio',     'te_mercado',
                                'ta_tipo',           'aw_prerequisitos',   'aw_idioma',       'cl_area_oficina',      'ad_tipo_tran',
                                'cl_barrio',         'ad_windows_authentication_user',        'cl_nombre_banco',      'cl_producproc',
                                'cl_depart_pais',    'cl_municip_seccion', 'cl_tipo_horario', 'cl_sector_geografico', 'cl_regional',
                                'cl_tipo_punto_at',  'cl_canton',          'cl_rol_sup_agencia', 'cl_estado_ambito',  'te_grupos_tasas',
                                'te_media_dolar',    'cl_tipo_oficina')

go
/*'*/
/************************************************************************/
print 'cl_tabla'
/************************************************************************/

declare @w_codigo int

select @w_codigo = isnull(max(codigo),0) from cl_tabla

insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 1, 'cl_actividad', 'Actividad')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 2, 'cl_cargo', 'Cargo')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 3, 'cl_sexo', 'Sexo')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 4, 'ad_dia_semana', 'Dias de la Semana')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 5, 'cl_continente', 'Continentes')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 6, 'cl_estado_ser', 'Estado de Datos')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 7, 'cl_filial','Filiales')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 8, 'cl_oficina', 'Oficinas')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 9, 'cl_moneda', 'Monedas')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 10, 'cl_zona', 'Zonas de Direccion')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 11, 'cl_producto', 'Productos Cobis')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 12, 'cl_pais', 'Paises')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 13, 'cl_provincia', 'Departamentos')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 14, 'cl_ciudad', 'Localidad/Ciudad')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 15, 'cl_parroquia', 'Distritos')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 16, 'cl_tparroquia', 'Tipo de Corregimiento')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 17, 'cl_tproducto', 'Tipo de Producto')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 18, 'cl_sector', 'Sector')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 19, 'cl_region_nat', 'Region Natural')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 20, 'cl_region_ope', 'Region Operativa')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 21, 'cl_suc_correo', 'Sucursal de Correo')
insert into cl_tabla 	(codigo, tabla, descripcion)
		values  (@w_codigo + 22, 'cc_tipo_oficial','Tipo de oficial')
insert into cl_tabla 	(codigo, tabla, descripcion)
		values  (@w_codigo + 23, 'ad_protocolo','Tipos de protocolos')
insert into cl_tabla 	(codigo, tabla, descripcion)
		values  (@w_codigo + 24, 'cc_sector','Sector de Oficiales de Credito')
insert into cl_tabla 	(codigo, tabla, descripcion)
		values  (@w_codigo + 25, 'cl_tipo_ejecucion', 'Tipo de Ejecucion de Transacciones')
insert into cl_tabla	(codigo, tabla, descripcion)
		values  (@w_codigo + 26, 'cl_tipo_medio', 'Tipo de Medio Electrónico')
insert into cl_tabla	(codigo, tabla, descripcion)
		values  (@w_codigo + 27, 'te_periodos', 'Periodos para Tasas Referenciales')
insert into cl_tabla	(codigo, tabla, descripcion)
		values  (@w_codigo + 28, 'te_tipo_servicio', 'Tipos de servicios/productos con tasas de referencia')
insert into cl_tabla	(codigo, tabla, descripcion)
		values  (@w_codigo + 29, 'te_mercado', 'Mercados para la Negociacion de Divisas')
insert into cl_tabla	(codigo, tabla, descripcion)
		values  (@w_codigo + 30, 'aw_prerequisitos', 'Prerequisitos para Autocarga de Funcionalidades')
insert into cl_tabla	(codigo, tabla, descripcion)
		values  (@w_codigo + 31, 'aw_idioma', 'Idiomas')
insert into cl_tabla	(codigo, tabla, descripcion)
		values  (@w_codigo + 32, 'ta_tipo', 'Tipos de Atributos de Transacciones')
insert into cl_tabla	(codigo, tabla, descripcion)
		values  (@w_codigo + 33, 'cl_area_oficina', 'Area de la Oficina')
insert into cl_tabla	(codigo, tabla, descripcion)
		values  (@w_codigo + 34, 'ad_tipo_tran', 'Tipo Transacción de Servicio')
insert into cl_tabla	(codigo, tabla, descripcion)
		values	(@w_codigo + 35, 'cl_barrio', 'Barrios')
insert into cl_tabla	(codigo, tabla, descripcion)
		values  (@w_codigo + 36, 'ad_windows_authentication_user', 'Windows Authentication User')
insert into cl_tabla	(codigo, tabla, descripcion)
		values  (@w_codigo + 37, 'cl_nombre_banco', 'NOMBRE DEL BANCO PARA CAMBIO DE MARCA/NOMBRE')
insert into cl_tabla	(codigo, tabla, descripcion)
		values  (@w_codigo + 38, 'cl_producproc', 'Relacion de productos Cobis con su procedimiento almacenado')
insert into cl_tabla	(codigo, tabla, descripcion)
		values  (@w_codigo + 39, 'cl_depart_pais', 'Departamentos para paises')
insert into cl_tabla	(codigo, tabla, descripcion)
		values  (@w_codigo + 40, 'cl_municip_seccion', 'Municipio/Seccion')
insert into cl_tabla	(codigo, tabla, descripcion)
      values  (@w_codigo + 41, 'cl_tipo_horario', 'Tipo de Horario')
insert into cl_tabla	(codigo, tabla, descripcion)
      values  (@w_codigo + 42, 'cl_sector_geografico', 'Sector Geográfico')
insert into cl_tabla	(codigo, tabla, descripcion)
      values  (@w_codigo + 43, 'cl_regional', 'Regionales')
insert into cl_tabla	(codigo, tabla, descripcion)
      values  (@w_codigo + 44, 'cl_tipo_punto_at', 'Tipo Punto de Atencion')
insert into cl_tabla	(codigo, tabla, descripcion)
      values  (@w_codigo + 45, 'cl_canton', 'Cantones')
insert into cl_tabla	(codigo, tabla, descripcion)
      values  (@w_codigo + 46, 'cl_tipo_ambito', 'Tipo de Ambito')
insert into cl_tabla	(codigo, tabla, descripcion)
      values  (@w_codigo + 47, 'cl_ambito', 'Ambito')
insert into cl_tabla	(codigo, tabla, descripcion)
      values  (@w_codigo + 48, 'cl_causa_bloqueo', 'Causa de Bloqueo de Usuarios')
insert into cl_tabla 
      values (@w_codigo + 49,'cl_rol_sup_agencia','ROLES SUPERVISORES DE AGENCIA')
insert into cl_tabla 
      values (@w_codigo + 50,'cl_estado_ambito','Estados de Ambito')
insert into cl_tabla	(codigo, tabla, descripcion)
      values  (@w_codigo + 51, 'te_grupos_tasas', 'GRUPOS DE TASAS REFERENCIALES')
insert into cl_tabla	(codigo, tabla, descripcion)
      values  (@w_codigo + 52, 'cl_tipo_oficina', 'TIPOS DE OFICINA')

update	cl_seqnos
set	siguiente = @w_codigo + 52
where	tabla = 'cl_tabla'
go

/************************************************************************/
print 'cl_catalogo'
/************************************************************************/

delete  cl_catalogo
where   tabla in (select codigo
                    from cl_tabla
                   where tabla in ('cl_actividad',      'cl_cargo',           'cl_sexo',         'ad_dia_semana',        'cl_continente',
                                   'cl_estado_ser',     'cl_filial',          'cl_oficina',      'cl_moneda',            'cl_zona', 
                                   'cl_producto',       'cl_pais',            'cl_provincia',    'cl_ciudad',            'cl_parroquia', 
                                   'cl_tparroquia',     'cl_tproducto',       'cl_sector',       'cl_region_nat',        'cl_region_ope',
                                   'cl_suc_correo',     'cc_tipo_oficial',    'ad_protocolo',    'cc_sector',            
                                   'cl_tipo_ejecucion', 'cl_tipo_medio',      'te_periodos',     'te_tipo_servicio',     'te_mercado', 
                                   'ta_tipo',           'aw_prerequisitos',   'aw_idioma',       'cl_area_oficina',      'ad_tipo_tran',
                                   'cl_barrio',         'ad_windows_authentication_user',        'cl_nombre_banco',      'cl_producproc',
                                   'cl_depart_pais',    'cl_municip_seccion', 'cl_tipo_horario', 'cl_sector_geografico', 'cl_regional',
                                   'cl_tipo_punto_at',  'cl_canton',          'cl_rol_sup_agencia', 'cl_estado_ambito',  'te_grupos_tasas',
                                   'cl_tipo_oficina'))
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_actividad'
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '0', 'NO DEFINIDA', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '1', 'BANCA Y FINANZAS', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_rol_sup_agencia'
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '1', 'Jefe de Agencia', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '2', 'Supervisor Administrativo Operativo', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '3', 'Encargado PR', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '4', 'Jefe Regional', 'V')
go


declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_cargo'
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'ABOGADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'ABOGADO ASISTENTE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'ADMINISTRADOR BASE DE DATOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'ADMINISTRADOR DE PROYECTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'ADMINISTRADOR DE SEGUROS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'ANALISTA CREDITO Y RIESGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'ANALISTA PROCED PROC PROYECTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'ANALISTA PROGRAMADOR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'ANALISTA RH Y PLANILLA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'ANALISTA SEGURIDAD TI', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '11', 'ASESOR LEGAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '12', 'ASISTENTE  AUDITORIA  SISTEMAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '13', 'ASISTENTE ADMINISTRATIVA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '14', 'ASISTENTE ADMINISTRATIVA GGRAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '15', 'ASISTENTE ADMON DE CR Y RIESGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '16', 'ASISTENTE AUDITORIA INTERNA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '17', 'ASISTENTE AUTOMAT DE PRODUCTO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '18', 'ASISTENTE BANCA OFF SHORE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '19', 'ASISTENTE BANCA PRIVADA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20', 'ASISTENTE CONTABILIDAD', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '21', 'ASISTENTE CONTROL INTERNO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '22', 'ASISTENTE CREDITO BANCA CORP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '23', 'ASISTENTE CREDITO COMERCIAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '24', 'ASISTENTE CREDITO CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '25', 'ASISTENTE CREDITO CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26', 'ASISTENTE CREDITO PROB Y B REP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '27', 'ASISTENTE DE ADMINISTRACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '28', 'ASISTENTE FINANZAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '29', 'ASISTENTE FINANZAS Y PRESUP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30', 'ASISTENTE MERCADEO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '31', 'ASISTENTE NEGOCIOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '32', 'ASISTENTE OPER CONSUMO CONTROL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '33', 'ASISTENTE OPERACIONES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '34', 'ASISTENTE OPERACIONES SUC', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '35', 'ASISTENTE PLATAFORMA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '36', 'ASISTENTE PLATAFORMA CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '37', 'ASISTENTE PRESTAMOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '38', 'ASISTENTE PROCESA SEG FRAU CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '39', 'ASISTENTE PUESTO DE BOLSA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40', 'ASISTENTE RECLUT Y SELECCION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41', 'ASISTENTE RECURSOS HUMANOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '42', 'ASISTENTE RIESGO CUMPLIMIENTO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '43', 'ASISTENTE SEGURIDAD', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '44', 'ASISTENTE TESORERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '45', 'AUDITOR DE SISTEMAS ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '46', 'CAJERO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '47', 'CONTADOR - AUDITOR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '48', 'COORDINADOR ADMON Y OPER SIST', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '49', 'COORDINADOR CAPAC Y COMUN CORP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50', 'COORDINADOR DE COMUNICACIONES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '51', 'COORDINADOR DE VENTAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '52', 'COORDINADOR MERCADEO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '53', 'COORDINADOR PRODUCTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '54', 'COORDINADOR SOPORTE TECN Y COM', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '55', 'CUSTODIO DE VALORES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '56', 'EJECUTIVO DE VENTAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '57', 'EJECUTIVO MERCADEO Y VENTAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '58', 'GERENTE ADMINISTRACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '59', 'GERENTE BANCA DE INVERSION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60', 'GERENTE BANCA PRIVADA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '61', 'GERENTE CENTRO DE PRESTAMOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '62', 'GERENTE COBROS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '63', 'GERENTE CREDITO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '64', 'GERENTE CREDITO BANCA CORPORA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '65', 'GERENTE DE PLATAFORMA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '66', 'GERENTE DESARROLLO DE SISTEMAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '67', 'GERENTE GENERAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '68', 'GERENTE OPERACIONES CENTRALIZA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '69', 'GERENTE OPERACIONES CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70', 'GERENTE OPERACIONES PREST CORP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '71', 'GERENTE PROCED Y PROCESOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '72', 'GERENTE SEGURIDAD TI', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '73', 'GERENTE SUCURSAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '74', 'GERENTE TEGNOLOGIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '75', 'GERENTE TESORERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '76', 'GESTOR DE COBROS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '77', 'INSPECTOR DE PROYECTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '78', 'MENSAJERO COBRADOR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '79', 'MENSAJERO INTERNO - EXTERNO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80', 'OFICIAL ADMINISTRACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81', 'OFICIAL ADMON DE CR Y RIESGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '82', 'OFICIAL ARCHIVO Y MENSAJERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '83', 'OFICIAL ARRENDAMIENTO FINANC', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '84', 'OFICIAL AUDITORIA CR Y RIESGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '85', 'OFICIAL AUDITORIA INTERNA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '86', 'OFICIAL BANCA ELECTRONICA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '87', 'OFICIAL BANCA OFF SHORE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '88', 'OFICIAL BANCA POR TELEFONO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '89', 'OFICIAL BANCA PRIVADA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90', 'OFICIAL COBROS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91', 'OFICIAL COMERCIO INTERNACIONAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '92', 'OFICIAL CONTROL INTERNO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '93', 'OFICIAL CREDITO AGROPECUARIO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '94', 'OFICIAL CREDITO BCA CORP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '95', 'OFICIAL CREDITO BCA TRANSPORTE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '96', 'OFICIAL CREDITO COMERCIAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '97', 'OFICIAL CREDITO CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '98', 'OFICIAL CREDITO CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '99', 'OFICIAL CUMPLIMIENTO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '100', 'OFICIAL DE CREDITO HIPOTECAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '101', 'OFICIAL DIST PROD  INVERSION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '102', 'OFICIAL FACTORING', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '103', 'OFICIAL FIDEICOMISO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '104', 'OFICIAL MANTENIMIENTO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '105', 'OFICIAL NEGOCIOS CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '106', 'OFICIAL OPER TRANSF, TES E INV', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '107', 'OFICIAL OPERACIONES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '108', 'OFICIAL OPERACIONES CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '109', 'OFICIAL OPERACIONES CXP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '110', 'OFICIAL OPERACIONES DEPOSITOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '111', 'OFICIAL OPERACIONES PREST COR ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '112', 'OFICIAL OPERACIONES SUCURSALES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '113', 'OFICIAL PLATAFORMA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '114', 'OFICIAL PRESTAMOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '115', 'OFICIAL PROCESA SEG FRAU CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '116', 'OFICIAL PROGRAMACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '117', 'OFICIAL PROYECTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '118', 'OFICIAL RESERVA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '119', 'OFICIAL RH Y DESARROLLO ORG ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '120', 'OFICINISTA ADMINISTRACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '121', 'OFICINISTA ARCHIVO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '122', 'OFICINISTA ASESORIA LEGAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '123', 'OFICINISTA AUDIT CR Y RIESGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '124', 'OFICINISTA BANCA POR TELEFONO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '125', 'OFICINISTA BANCA TRANSPORTE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '126', 'OFICINISTA CR PROBL B REPOSEID', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '127', 'OFICINISTA CREDITO COMERCIAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '128', 'OFICINISTA CREDITO CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '129', 'OFICINISTA CREDITO CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '130', 'OFICINISTA FACTORING', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '131', 'OFICINISTA OPERACIONES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '132', 'OFICINISTA OPERACIONES C X P ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '133', 'OFICINISTA OPERACIONES CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '134', 'OFICINISTA OPERACIONES DEPOSI ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '135', 'OFICINISTA OPERACIONES PR CORP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '136', 'OFICINISTA OPERACIONES TES INV', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '137', 'OFICINISTA OPERACIONES TRANSFE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '138', 'OFICINISTA PLATAFORMA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '139', 'OFICINISTA PRESTAMOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '140', 'OFICINISTA PROCED PROC PROYECT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '141', 'OFICINISTA PROCESA SEG FRAU CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '142', 'OPERADOR DE SISTEMAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '143', 'PROMOTOR CREDITO COMERCIAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '144', 'RECEPCIONISTA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '145', 'SECRETARIA  EJECUTIVA VP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '146', 'SECRETARIA ASESORIA LEGAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '147', 'SECRETARIA EJECUTIVA BCA CORP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '148', 'SECRETARIA RECEPCIONISTA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '149', 'SERVICIOS GENERALES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '150', 'SOPORTE TECNICO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '151', 'SOPORTE TECNICO HELPDESK', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '152', 'SUBGERENTE BCA ELECTRONICA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '153', 'SUBGERENTE CALIDAD Y PROCESOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '154', 'SUBGERENTE CONTABILIDAD', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '155', 'SUBGERENTE CREDITO BCA CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '156', 'SUBGERENTE FIANZAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '157', 'SUBGERENTE MERCADEO ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '158', 'SUBGERENTE OPERACIONE TRANSITO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '159', 'SUBGERENTE PUESTO DE BOLSA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '160', 'SUBGERENTE RECURSOS HUMANOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '161', 'SUBGERENTE SEGURIDAD', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '162', 'SUBGERENTE SUCURSAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '163', 'SUPERVISOR ADMON CRED Y RIESGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '164', 'SUPERVISOR BANCA POR TELEFONO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '165', 'SUPERVISOR COBROS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '166', 'SUPERVISOR OPERACIONES CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '167', 'SUPERVISOR PLATAFORMA CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '168', 'SUPERVISOR PROCEDIMIENTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '169', 'VP AUDITORIA INTERNA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '170', 'VP BANCA CORPORATIVA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '171', 'VP EJECUTIVO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '172', 'VP OPERACIONES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '173', 'VP PYME Y REGION METRO 2 ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '174', 'VP TECNOLOGIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '175', 'VPA ADMON DE CREDITO Y COBROS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '176', 'VPA AUDITORIA DE CR Y RIESGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '177', 'VPA BANCA CORPORATIVA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '178', 'VPA BANCA DE TRANSPORTE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '179', 'VPA BANCA OFF SHORE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '180', 'VPA BANCA PRIVADA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '181', 'VPA CENTRO DE TARJETAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '182', 'VPA PRESTAMOS DE CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '183', 'VPA RECURSOS HUMANOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '184', 'VPA REGION OCCIDENTAL', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_sexo'
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'F', 'FEMENINO', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'M', 'MASCULINO', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'ad_dia_semana'
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '1', 'LUNES', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '2', 'MARTES', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '3', 'MIERCOLES', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '4', 'JUEVES', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '5', 'VIERNES', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '6', 'SABADO', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '7', 'DOMINGO', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_continente'
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo , 'AMN', 'AMERICA DEL NORTE', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo , 'AMS', 'AMERICA DEL SUR', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo , 'AMC', 'AMERICA CENTRAL', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo , 'AFR', 'AFRICA', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo , 'ASI', 'ASIA', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo , 'EUR', 'EUROPA', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo , 'OCE', 'OCEANIA', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_estado_ser'
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'V', 'VIGENTE', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'C', 'CANCELADO', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'E', 'ELIMINADO', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'B', 'BLOQUEADO', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'X', 'PRODUCTO DESHABILITADO', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_filial'
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '0', 'NO EXISTE FILIAL', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, '1', 'COBIS', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_oficina'
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '0', 'DIRECCION GENERAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'CASA MATRIZ','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'DAVID','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'SANTIAGO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'CENTRO DE TARJETAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'CORONADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'PENONOME','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'SAN FERNANDO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'AGUADULCE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'CHITRE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '12', 'CONCEPCION','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '13', 'CHANGUINOLA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '15', 'CHORRERA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '16', 'BOQUETE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '17', 'PLAZA MIRAGE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '18', 'LAS TABLAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '19', 'LOS PUEBLOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20', 'CENTRO DE PRESTAMOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '21', 'PAITILLA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '22', 'TORRE GLOBAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '23', 'COLON','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '24', 'PARQUE PORRAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '25', 'ALBROOK','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26', 'LOS ANDES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '27', 'PARQUE LEFEVRE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '28', 'BETHANIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '29', 'CAMPO LIMBERG','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30', 'SAN FRANCISCO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40', 'AVANCE GLOBAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '45', 'BANCA CORPORATIVA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '47', 'FACTOR GLOBAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '48', 'CAJA CENTRO DE COBROS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50', 'BANCA PRIVADA','V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_moneda'
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'0','BOLIVIANOS','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'1','DOLAR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'2','DOLARES ESTADOUNIDENSES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'3','BOLIVIANOS CON MANTENIMIENTO DE VALOR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'4','MN CON MV A LA UNIDAD DE FOMENTO A LA VIVIENDA ','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'5','YEN JAPONES','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'6','CORONA DANESA','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'7','LIBRA ESTERLINA','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'8','FRANCO SUIZO','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'9','DOLAR CAYMAN','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'10','PESO DOMINICANO','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'11','PESO MEXICANO','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'12','SHEGEL ISRAELI','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'13','DOLAR BELIZE','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'14','QUETZAL GUATEMALA','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'15','LEMPIRA HONDURAS','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'16','CORDOBA NICARAGUA','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'17','COLON COSTARICENSE','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'18','COLON EL SALVADOR','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'19','PESO ARGENTINO','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'20','BOLIVIANO','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'21','REAL BRASIL','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'22','PESO CHILENO','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'23','PESO COLOMBIANO','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'24','DOLAR ECUATORIANO','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'25','DOLAR GUYANA','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'26','GUARANI PARAGUAYO','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'27','NUEVO SOL PERUANO','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'28','DOLAR SURINAM','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'29','BOLIVAR VENEZOLANO','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'30','PESO URUGUAYO','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'31','RUBLO RUSO','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'32','DOLAR SINGAPUR','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'33','WON COREA DEL SUR','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'34','DOLAR TAIWAN','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'35','DOLAR HONG KONG','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'36','RUPIAH INDONESIO','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'37','DOLAR NUEVA ZELANDA','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'38','RUPEE INDIA','V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'39','PESO FILIPINAS','V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_zona'
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'C', 'CENTRO', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'N', 'NORTE', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'S', 'SUR', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'OC', 'OCCIDENTAL', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'OR', 'ORIENTE', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_pais'
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'4','AFGANISTAN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'8','ALBANIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'10','ANTARTIDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'12','ARGELIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'16','SAMOA AMERICANA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'20','ANDORRA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'24','ANGOLA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'28','ANTIGUA Y BARBUDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'31','AZERBAIYAN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'32','ARGENTINA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'36','AUSTRALIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'40','AUSTRIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'44','BAHAMAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'48','BAHRAIN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'50','BANGLADESH','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'51','ARMENIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'52','BARBADOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'56','BELGICA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'60','BERMUDAS (REINO UNIDO)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'64','BHUTAN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'68','BOLIVIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'70','BOSNIA Y HERZEGOVINA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'72','BOTSWANA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'74','ISLA BOUVET (NORUEGA)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'76','BRASIL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'84','BELIZE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'90','ISLAS SALOMON','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'92','ISLAS VIRGENES BRITANICAS (REINO UNIDO)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'96','BRUNEI DARUSSALAM','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'100','BULGARIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'104','MIANMAR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'108','BURUNDI','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'112','BIELORRUSIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'116','CAMBOYA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'120','CAMERUN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'124','CANADA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'132','CABO VERDE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'136','ISLAS CAIMAN (REINO UNIDO)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'140','REPUBLICA CENTROAFRICANA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'144','SRI LANKA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'148','CHAD','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'152','CHILE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'156','CHINA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'158','TAIWAN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'162','ISLA NAVIDAD','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'166','ISLAS COCOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'170','COLOMBIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'174','COMORAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'175','MAYOTTE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'178','CONGO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'180','CONGO, REPUBLICA DEMOCRATICA DEL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'184','ISLAS COOK','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'188','COSTA RICA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'191','CROACIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'192','CUBA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'196','CHIPRE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'203','REPUBLICA CHECA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'204','BENIN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'208','DINAMARCA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'212','DOMINICA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'214','REPUBLICA DOMINICANA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'218','ECUADOR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'222','EL SALVADOR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'226','GUINEA ECUATORIAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'231','ETIOPIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'232','ERITREA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'233','ESTONIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'234','ISLAS FEROE (DINAMARCA)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'238','ISLAS MALVINAS (REINO UNIDO)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'239','GEORGIA DEL SUR E ISLAS SANDWICH DEL SUR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'242','FIJI','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'246','FINLANDIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'250','FRANCIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'254','GUINEA FRANCESA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'258','POLINESIA FRANCESA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'260','TERRITORIOS AUSTRALES FRANCESES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'262','DJIBOUTI','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'266','GABON','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'268','GEORGIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'270','GAMBIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'275','PALESTINA (CISJORDANIA Y FRANJA DE GAZA)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'276','ALEMANIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'288','GHANA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'292','GIBRALTAR (REINO UNIDO)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'296','KIRIBATI','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'300','GRECIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'304','GROENLANDIA (DINAMARCA)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'308','GRANADA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'312','GUADALUPE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'316','GUAM (ESTADOS UNIDOS)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'320','GUATEMALA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'324','GUINEA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'328','GUAYANA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'332','HAITI','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'334','ISLAS HEARD Y MCDONALD (AUSTRALIA)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'336','ESTADO VATICANO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'340','HONDURAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'344','HONG KONG','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'348','HUNGRIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'352','ISLANDIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'356','INDIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'360','INDONESIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'364','IRAN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'368','IRAQ','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'372','IRLANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'376','ISRAEL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'380','ITALIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'384','COSTA DE MARFIL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'388','JAMAICA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'392','JAPON','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'398','KAZAJISTAN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'400','JORDANIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'404','KENIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'408','COREA DEL NORTE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'410','COREA DEL SUR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'414','KUWAIT','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'417','KIRGUIZISTAN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'418','LAOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'422','LIBANO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'426','LESOTO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'428','LETONIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'430','LIBERIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'434','LIBIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'438','LIECHTENSTEIN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'440','LITUANIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'442','LUXEMBURGO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'446','MACAO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'450','MADAGASCAR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'454','MALAWI','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'458','MALASIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'462','MALDIVAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'466','MALI','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'470','MALTA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'474','MARTINICA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'478','MAURITANIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'480','MAURICIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'484','MEXICO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'492','MONACO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'496','MONGOLIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'498','MOLDAVIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'500','MONTSERRAT (REINO UNIDO)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'504','MARRUECOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'508','MOZAMBIQUE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'512','OMAN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'516','NAMIBIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'520','NAURU','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'524','NEPAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'528','PAISES BAJOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'530','ANTILLAS NEERLANDESAS (PAISES BAJOS)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'533','ARUBA (PAISES BAJOS)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'540','NUEVA CALEDONIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'548','VANUATU','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'554','NUEVA ZELANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'558','NICARAGUA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'562','NIGER','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'566','NIGERIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'570','NIUE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'574','ISLAS NORFOLK','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'578','NORUEGA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'580','ISLAS MARIANAS DEL NORTE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'581','ISLAS ULTRAMARINAS DE ESTADOS UNIDOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'583','MICRONESIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'584','ISLAS MARSHALL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'585','PALAOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'586','PAKISTAN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'591','PANAMA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'598','PAPUA-NUEVA GUINEA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'600','PARAGUAY','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'604','PERU','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'608','FILIPINAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'612','PITCAIRN (REINO UNIDO)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'616','POLONIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'620','PORTUGAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'624','GUINEA-BISSAU','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'626','TIMOR ORIENTAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'630','PUERTO RICO (ESTADOS UNIDOS)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'634','QATAR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'638','REUNION','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'642','RUMANIA, RUMANIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'643','RUSIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'646','RUANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'654','SANTA HELENA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'659','SANTA KITTS Y NEVIS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'660','ANGUILA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'662','SANTA LUCIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'666','SAN PEDRO Y MIQUELON','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'670','SAN VINCENTE Y LAS GRANADINAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'674','SAN MARINO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'678','SANTO TOME Y PRINCIPE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'682','ARABIA SAUDI','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'686','SENEGAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'690','SEYCHELLES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'694','SIERRA LEONA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'702','SINGAPUR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'703','ESLOVAQUIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'704','VIETNAM','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'705','ESLOVENIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'706','SOMALIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'710','SUDAFRICA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'716','ZIMBABUE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'724','ESPAÑA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'732','SAHARA OCCIDENTAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'736','SUDAN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'740','SURINAM','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'744','ESVALBARD Y JAN MAYEN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'748','SUAZILANDIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'752','SUECIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'756','SUIZA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'760','SIRIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'762','TAJIKISTAN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'764','TAILANDIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'768','TOGO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'772','TOKELAU (NUEVA ZELANDA)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'776','TONGA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'780','TRINIDAD Y TOBAGO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'784','EMIRATOS ARABES UNIDOS (EAU)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'788','TUNEZ','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'792','TURQUIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'795','TURMENISTAN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'796','ISLAS TURKS Y CAICOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'798','TUVALU','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'800','UGANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'804','UCRANIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'807','MACEDONIA,ANTIGUA REPUBLICA YUGOSLAVA DE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'818','EGIPTO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'826','REINO UNIDO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'827','GUERNSEY','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'834','TANZANIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'840','ESTADOS UNIDOS (EE.UU.)','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'850','ISLAS VIRGENES DE ESTADOS UNIDOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'854','BURKINA FASO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'858','URUGUAY','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'860','UZBEKISTAN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'862','VENEZUELA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'876','WALLIS Y FUTUNA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'882','SAMOA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'887','YEMEN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'891','SERBIA Y MONTENEGRO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'894','ZAMBIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'895','JERSEY','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'896','BIRMANIS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'897','ISLE OF MAN','V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_provincia'
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'BOCAS DEL TORO',  'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'COCLE',  'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'COLON',  'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'CHIRIQUI',  'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'DARIEN',  'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'HERRERA',  'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'LOS SANTOS',  'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'PANAMA',  'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'VERAGUAS',  'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'COMARCA KUNA YALA',  'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '11', 'COMARCA DE MUNA',  'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '12', 'COMARCA DE UMANI',  'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_ciudad'
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '101', 'BOCAS DEL TORO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '102', 'CHANGUINOLA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '103', 'CHIRIQUI GRANDE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '104', 'KANKINTU/NGOBE BUGLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '105', 'KUSAPIN/NGOBE BUGLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '201', 'AGUADULCE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '202', 'ANTON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '203', 'LA PINTADA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '204', 'NATA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '205', 'OLA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '206', 'PENONOME', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '301', 'CHAGRES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '302', 'COLON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '303', 'DONOSO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '304', 'PORTOBELO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '305', 'SANTA ISABEL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '401', 'ALANJE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '402', 'BARU', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '403', 'BESIKO/NGOBE BUGLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '404', 'BOQUERON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '405', 'BOQUETE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '406', 'BUGABA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '407', 'DAVID', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '408', 'DOLEGA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '409', 'GUALACA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '410', 'MIRONO/NGOBE BUGLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '411', 'MUNA/NGOBE  BUGLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '412', 'NOLE DUIMA/NGOBE BUGLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '413', 'REMEDIOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '414', 'RENACIMIETO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '415', 'SAN FELIX', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '416', 'SAN LORENZO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '417', 'TOLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '501', 'CEMACO /EMBERA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '502', 'CHEPIGANA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '503', 'PINOGANA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '504', 'SAMBU / C. EMBERA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '601', 'CHITRE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '602', 'LAS MINAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '603', 'LOS POZOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '604', 'OCU', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '605', 'PARITA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '606', 'PESE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '607', 'SANTA MARÍA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '701', 'GUARARE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '702', 'LAS TABLAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '703', 'LOS SANTOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '704', 'MACARACAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '705', 'PEDASI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '706', 'POCRI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '707', 'TONOSI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '801', 'ARRAIJAN', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '802', 'BALBOA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '803', 'CAPIRA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '804', 'CHAME', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '805', 'CHEPO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '806', 'CHIMAN', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '807', 'LA CHORRERA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '808', 'PANAMA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '809', 'SAN CARLOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '810', 'SAN MIGUELITO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '811', 'TABOGA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '901', 'ATALAYA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '902', 'CALOBRE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '903', 'CANAZAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '904', 'LA MESA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '905', 'LAS PALMAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '906', 'MONTIJO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '907', 'NURUM/NGOBE BUGLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '908', 'RIO DE JESUS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '909', 'SAN FRANCISCO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '910', 'SANTA FE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '911', 'SANTIAGO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '912', 'SONA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1001', 'COMARCA KUNA YALA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1101', 'MUNA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1201', 'UMANI', 'V' )
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_parroquia'
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10101', 'BASTIMENTOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10102', 'BOCAS DEL TORO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10103', 'CAUCHERO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10104', 'PUNTA LAUREL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10105', 'TIERRA OSCURA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10201', 'ALMIRANTE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10202', 'CHANGUINOLA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10203', 'GUABITO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10204', 'TERIBE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10205', 'VALLE DEL RISCO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10301', 'CHIRIQUI GRANDE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10302', 'MIRAMAR', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10303', 'PUNTA PEÑA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10304', 'PUNTA ROBALO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10305', 'RAMBALA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10401', 'BISIRA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10402', 'BURI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10403', 'GUARIVIARA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10404', 'GUORONI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10405', 'KANKINTU', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10406', 'MUNUNI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10407', 'PIEDRA ROJA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10408', 'TUWAI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10501', 'BAHIA AZUL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10502', 'CALA VERORA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10503', 'KUSAPIN', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10504', 'LOMA YUCA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10505', 'RIO CHIRIQUI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10506', 'TOBOBE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10507', 'VALLE BONITO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20101', 'AGUADULCE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20102', 'BARRIOS UNIDOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20103', 'EL CRISTO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20104', 'EL ROBLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20105', 'POCRI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20201', 'ANTON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20202', 'CABALLERO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20203', 'CABUYA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20204', 'EL CHIRU', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20205', 'EL RETIRO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20206', 'EL VALLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20207', 'JUAN DIAZ', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20208', 'RIO HATO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20209', 'SAN JUAN DE DIOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20210', 'SANTA RITA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20301', 'EL HARINO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20302', 'EL POTRERO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20303', 'LA PINTADA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20304', 'LLANO GRANDE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20305', 'PIEDRAS GORDAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20401', 'CAPELLANIA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20402', 'EL CAÑO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20403', 'GUZMAN', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20404', 'LAS HUACAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20405', 'NATA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20406', 'TOZA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20501', 'EL COPE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20502', 'EL PALMAR', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20503', 'EL PICACHO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20504', 'LA PAVA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20505', 'OLA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20601', 'CAÑAVERAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20602', 'CHIGUIRI ARRIBA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20603', 'COCLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20604', 'EL COCO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20605', 'PAJONAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20606', 'PENONOME', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20607', 'RIO GRANDE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20608', 'RIO INDIO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20609', 'TOABRE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20610', 'TULU', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30101', 'ACHIOTE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30102', 'EL GUABO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30103', 'LA ENCANTADA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30104', 'NUEVO CHAGRES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30105', 'PALMAS BELLAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30106', 'PIÑA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30107', 'SALUD', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30201', 'BARRIO NORTE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30202', 'BARRIO SUR', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30203', 'BUENA VISTA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30204', 'CATIVA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30205', 'CIRICITO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30206', 'CRISTOBAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30207', 'ESCOBAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30208', 'LIMON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30209', 'NUEVA PROVIDENCIA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30210', 'PUERTO PILON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30211', 'SABANITAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30212', 'SALAMANCA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30213', 'SAN JUAN', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30214', 'SANTA ROSA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30301', 'COCLE DEL NORTE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30302', 'EL GUASMO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30303', 'GOBEA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30304', 'MIGUEL DE LA BORDA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30305', 'RIO INDIO (COLON)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30306', 'SAN JOSE DEL GENERAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30401', 'CACIQUE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30402', 'GARROTE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30403', 'ISLA GRANDE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30404', 'MARIA CHIQUITA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30405', 'PORTOBELO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30501', 'CUANGO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30502', 'MIRAMAR (COLON)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30503', 'NOMBRE DE DIOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30504', 'PALENQUE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30505', 'PALMIRA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30506', 'PLAYA CHIQUITA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30507', 'SANTA ISABEL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30508', 'VIENTO FRÍO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40101', 'ALANJE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40102', 'DIVALA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40103', 'EL TEJAR', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40104', 'GUARUMAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40105', 'PALO GRANDE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40106', 'QUEREVALO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40107', 'SANTO TOMAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40201', 'BACO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40202', 'LIMONES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40203', 'PROGRESO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40204', 'PUERTO ARMUELLES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40205', 'RODOLFO AGUILAR DELG', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40301', 'BOCA DE BALSA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40302', 'CAMARON ARRIBA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40303', 'CERRO BANCO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40304', 'CERRO DE PATENA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40305', 'EMPLANADA DE CHORCHA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40306', 'NAMNONI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40307', 'NIBA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40308', 'SOLOY', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40401', 'BAGALA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40402', 'BOQUERON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40403', 'CORDILLERA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40404', 'GUABAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40405', 'GUAYABAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40406', 'PARAISO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40407', 'PEDREGAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40408', 'TIJERAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40501', 'ALTO BOQUETE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40502', 'BAJO BOQUETE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40503', 'CALDERA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40504', 'JARAMILLO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40505', 'LOS NARANJOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40506', 'PALMIRA(BOQUETE)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40601', 'ASERRIO DE GARRICHE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40602', 'BUGABA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40603', 'CERRO PUNTA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40604', 'EL BONGO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40605', 'GOMEZ', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40606', 'LA CONCEPCION', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40607', 'LA ESTRELLA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40608', 'SAN ANDRES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40609', 'SANTA MARTA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40610', 'SANTA ROSA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40611', 'SANTO DOMINGO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40612', 'SORTOVA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40613', 'VOLCAN', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40701', 'BIJAGUAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40702', 'CHIRIQUI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40703', 'COCHEA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40704', 'DAVID', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40705', 'GUACA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40706', 'LAS LOMAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40707', 'PEDREGAL(DAVID)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40708', 'SAN CARLOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40709', 'SAN PABLO NUEVO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40710', 'SAN PABLO VIEJO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40801', 'DOLEGA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40802', 'DOS RIOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40803', 'LOS ANASTACIOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40804', 'POTRERILLOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40805', 'POTRERILLOS ABAJO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40806', 'ROVIRA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40807', 'TINAJAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40901', 'GUALACA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40902', 'HORNITO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40903', 'LOS ANGELES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40904', 'PAJA DE SOMBRERO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40905', 'RINCON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41001', 'CASCABEL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41002', 'HATO COROTU', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41003', 'HATO CULANTRO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41004', 'HATO JOBO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41005', 'HATO JULI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41006', 'HATO PILON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41007', 'QUEBRADA DE LORO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41008', 'SALTO DUPI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41101', 'ALTO CABALLERO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41102', 'BAKAMA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41103', 'CERRO CANA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41104', 'CERRO PUERCO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41105', 'CHICHICA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41106', 'KRUA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41107', 'MARACA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41108', 'NIBRA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41109', 'PEÑA BLANCA/N BUGLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41110', 'ROKA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41111', 'SITIO PRADO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41112', 'UMANI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41201', 'CERRO IGLESIAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41202', 'HATO CHAMI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41203', 'JADEBERI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41204', 'LAJERO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41205', 'SUSANA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41301', 'EL NANCITO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41302', 'EL PORVENIR', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41303', 'EL PUERTO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41304', 'REMEDIOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41305', 'SANTA LUCIA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41401', 'BREÑON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41402', 'CAÑAS GORDAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41403', 'MONTE LIRIO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41404', 'PLAZA CAISAN', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41405', 'RIO SERENO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41406', 'SANTA CRUZ', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41501', 'JUAY', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41502', 'LAJAS ADENTRO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41503', 'LAS LAJAS(CHIRIQUI)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41504', 'SAN FELIX', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41505', 'SANTA CRUZ(CHIRIQUI)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41601', 'BOCA CHICA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41602', 'BOCA DEL MONTE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41603', 'HORCONCITOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41604', 'SAN JUAN(DAVID)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41605', 'SAN LORENZO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41701', 'BELLA VISTA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41702', 'CERRO VIEJO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41703', 'EL CRISTO(DAVID)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41704', 'JUSTO FIDEL PALACIOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41705', 'LAJAS DE TOLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41706', 'POTRERO DE CAÑA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41707', 'QUEBRADA DE PIEDRA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41708', 'TOLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41709', 'VELADERO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50101', 'CIRILO GUAINORA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50102', 'LAJAS BLANCAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50103', 'MANUEL ORTEGA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50201', 'AGUA FRIA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50202', 'CAMOGANTI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50203', 'CHEPIGANA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50204', 'CUCUNATI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50205', 'GARACHINE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50206', 'JAQUE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50207', 'LA PALMA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50208', 'PUERTO PIÑA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50209', 'RIO CONGO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50210', 'RIO CONGO ARRIBA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50211', 'RIO IGLESIAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50212', 'SAMBU', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50213', 'SANTA FE (DARIEN)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50214', 'SETEGANTI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50215', 'TAIMATI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50216', 'TUCUTI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50301', 'BOCA DE CUPE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50302', 'COMARCA KUNA DE WARG', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50303', 'EL REAL DE STA MARIA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50304', 'METETI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50305', 'PAYA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50306', 'PINOGANA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50307', 'PUCURO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50308', 'YAPE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50309', 'YAVIZA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50401', 'JINGRUDO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50402', 'RIO SABALO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60101', 'CHITRE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60102', 'LA ARENA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60103', 'LLANO BONITO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60104', 'MONAGRILLO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60105', 'SAN JUAN BAUTISTA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60201', 'CHEPO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60202', 'CHUMUCAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60203', 'EL TORO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60204', 'LAS MINAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60205', 'LEONES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60206', 'QUEBRADA DEL ROSARIO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60301', 'CAPURI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60302', 'EL CALABACITO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60303', 'EL CEDRO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60304', 'LA ARENA(HERRERA)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60305', 'LA PITALOSA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60306', 'LOS CERRITOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60307', 'LOS CERROS DE PAJA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60308', 'LOS POZOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60401', 'CERRO LARGO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60402', 'EL TIJERA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60403', 'LLANO GRANDE(HERRERA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60404', 'LOS LLANOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60405', 'OCU', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60406', 'PENAS CHATAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60501', 'CABUYA(HERRERA)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60502', 'LLANO DE LA CRUZ', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60503', 'LOS CASTILLOS(HERRE)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60504', 'PARIS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60505', 'PARITA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60506', 'PORTOBELILLO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60507', 'POTUGA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60601', 'EL BARRERO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60602', 'EL CIRUELO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60603', 'EL PAJARO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60604', 'EL PEDREGOSO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60605', 'LAS CABRAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60606', 'PESE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60607', 'RINCON HONDO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60608', 'SABANAGRANDE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60701', 'CHUPAMPA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60702', 'EL LIMON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60703', 'EL RINCON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60704', 'LOS CANELOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60705', 'SANTA MARIA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70101', 'EL ESPINAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70102', 'EL HATO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70103', 'EL MACANO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70104', 'GUARARE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70105', 'GUARARE ARRIBA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70106', 'LA ENEA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70107', 'LA PASERA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70108', 'LAS TRANCAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70109', 'LLANO ABAJO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70110', 'PERALES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70201', 'BAJO CORRAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70202', 'BAYANO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70203', 'EL CARATE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70204', 'EL COCAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70205', 'EL MANATIAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70206', 'EL MUÑOZ', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70207', 'EL PEDREGOSO(L.SANTO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70208', 'LA LAJA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70209', 'LA MIEL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70210', 'LA PALMA(LOS SANTOS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70211', 'LA TIZA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70212', 'LAS PALMITAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70213', 'LAS TABLAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70214', 'LAS TABLAS ABAJO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70215', 'NUARIO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70216', 'PALMIRA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70217', 'PENA BLANCA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70218', 'RIO HONDO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70219', 'SAN JOSE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70220', 'SAN MIGUEL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70221', 'SANTO DOMINGO(L.S.)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70222', 'SESTEADERO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70223', 'VALLE RICO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70224', 'VALLERRIQUITO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70301', 'AGUA BUENA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70302', 'EL GUASMO (L.SANTOS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70303', 'LA COLORADA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70304', 'LA ESPIGADILLA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70305', 'LA VILLA DE LOS SANT', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70306', 'LAS CRUCES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70307', 'LAS GUABAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70308', 'LLANO LARGO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70309', 'LOS ANGELES (L.SANTOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70310', 'LOS OLIVOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70311', 'SABANA GRANDE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70312', 'SANTA ANA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70313', 'TRES QUEBRADAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70314', 'VILLA LOURDES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70401', 'BAHIA HONDA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70402', 'BAJOS DE GUERRA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70403', 'CHUPA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70404', 'COROZAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70405', 'EL CEDRO(LOS SANTOS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70406', 'ESPINO AMARILLO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70407', 'LA MESA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70408', 'LAS PALMAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70409', 'LLANO DE PIEDRA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70410', 'MACARACAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70411', 'MOGOLLON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70501', 'LOS ASIENTOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70502', 'MARIABE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70503', 'ORIA ARRIBA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70504', 'PEDASI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70505', 'PURIO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70601', 'EL CAÑAFÍSTULO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70602', 'LAJAMINA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70603', 'PARAISO(L.SANTOS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70604', 'PARITILLA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70605', 'POCRI(LOS SANTOS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70701', 'ALTOS DE GUERRA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70702', 'CAMBUTAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70703', 'CAÑAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70704', 'EL BEBEDERO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70705', 'EL CACAO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70706', 'EL CORTEZO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70707', 'FLORES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70708', 'GUANICO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70709', 'LA TRONOSA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70710', 'TONOSI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80101', 'ARRAIJAN', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80102', 'CERRO SILVESTRE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80103', 'EL LLANO(ARRAIJAN)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80104', 'JUAN D. AROSEMENA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80105', 'NUEVO EMPERADOR', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80106', 'SANTA CLARA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80107', 'VACAMONTE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80108', 'VERACRUZ', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80109', 'VISTA ALEGRE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80201', 'LA ENSENADA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80202', 'LA ESMERALDA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80203', 'LA GUINEA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80204', 'PEDRO GONZALEZ', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80205', 'SABOGA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80206', 'SAN MIGUEL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80301', 'CAIMITO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80302', 'CAMPANA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80303', 'CAPIRA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80304', 'CERMEÑO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80305', 'CIRI DE LOS SOTOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80306', 'CIRI GRANDE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80307', 'EL CACAO(PANAMA)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80308', 'LA TRINIDAD', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80309', 'LAS OLLAS ARRIBA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80310', 'LIDICE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80311', 'SANTA ROSA(PANAMA)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80312', 'VILLA CARMEN', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80313', 'VILLA ROSARIO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80401', 'BEJUCO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80402', 'BUENOS AIRES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80403', 'CABUYA(PANAMA)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80404', 'CHAME', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80405', 'CHICA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80406', 'EL LIBANO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80407', 'LAS LAJAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80408', 'NUEVA GORGONA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80409', 'PUNTA CHAME', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80410', 'SAJALICES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80411', 'SORA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80501', 'CAÑITA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80502', 'CHEPILLO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80503', 'CHEPO(PANAMA)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80504', 'CRCA KUNA MADUGANDI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80505', 'EL LLANO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80506', 'FELIPILLO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80507', 'LAS MARGARITAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80508', 'STA CRUZ DE CHININA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80509', 'TORTI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80601', 'BRUJAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80602', 'CHIMAN', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80603', 'GONZALO VASQUEZ', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80604', 'PASIGA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80605', 'UNION SANTEÑA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80701', 'AMADOR', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80702', 'AROSEMENA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80703', 'BARRIO BALBOA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80704', 'BARRIO COLON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80705', 'EL ARADO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80706', 'EL COCO(PANAMA)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80707', 'FEUILLET', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80708', 'GUADALUPE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80709', 'HERRERA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80710', 'HURTADO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80711', 'ITURRALDE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80712', 'LA HERRADURA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80713', 'LA REPRESA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80714', 'LOS DIAZ', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80715', 'MENDOZA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80716', 'OBALDIA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80717', 'PLAYA LEONA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80718', 'PUERTO CAIMITO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80719', 'SANTA RITA(PANAMA)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80801', 'ANCON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80802', 'BELLA VISTA(PANAMA)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80803', 'BETHANIA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80804', 'CALIDONIA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80805', 'CHILIBRE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80806', 'CURUNDU', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80807', 'EL CHORRILLO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80808', 'JUAN DIAZ(PANAMA)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80809', 'LAS CUMBRES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80810', 'PACORA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80811', 'PARQUE LEFEVRE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80812', 'PEDREGAL(PANAMA)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80813', 'PUEBLO NUEVO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80814', 'RIO ABAJO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80815', 'SAN FELIPE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80816', 'SAN FRANCISCO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80817', 'SAN MARTIN', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80818', 'SANTA ANA(PANAMA)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80819', 'TOCUMEN', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80901', 'EL ESPINO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80902', 'EL HIGO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80903', 'GUAYABITO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80904', 'LA ERMITA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80905', 'LA LAGUNA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80906', 'LAS UVAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80907', 'LOS LLANITOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80908', 'SAN CARLOS(PANAMA)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80909', 'SAN JOSE(PANAMA)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81001', 'AMELIA DENIS DE ICAZ', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81002', 'ARNULFO ARIAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81003', 'BELISARIO FRIAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81004', 'BELISARIO PORRAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81005', 'JOSE DOMINGO ESPINAR', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81006', 'MATEO ITURRALDE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81007', 'OMAR TORRIJOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81008', 'RUFINA ALFARO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81009', 'VICTORIANO LORENZO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81101', 'OTOQUE OCCIDENTE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81102', 'OTOQUE ORIENTE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81103', 'TABOGA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90101', 'ATALAYA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90102', 'EL BARRITO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90103', 'LA CARRILLO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90104', 'LA MONTAÑUELA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90105', 'SAN ANTONIO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90201', 'BARNIZAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90202', 'CALOBRE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90203', 'CHITRA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90204', 'EL COCLA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90205', 'EL POTRERO (VERAGUAS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90206', 'LA LAGUNA (VERAGUAS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90207', 'LA RAYA DE CALOBRE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90208', 'LA TETILLA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90209', 'LA YEGUADA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90210', 'LAS GUIAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90211', 'MONJARAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90212', 'SAN JOSE(VERAGUAS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90301', 'CANAZAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90302', 'CERRO DE PLATA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90303', 'EL PICADOR', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90304', 'LOS VALLES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90305', 'SAN JOSE(VERAGUAS9)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90306', 'SAN MARCELO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90401', 'BISVALLES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90402', 'BORO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90403', 'LA MESA(VERAGUAS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90404', 'LLANO GRANDE(VERAGUA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90405', 'SAN BARTOLO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90501', 'CERRO DE CASA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90502', 'COROZAL(VERAGUAS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90503', 'EL MARIA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90504', 'EL PRADO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90505', 'EL RINCON(VERAGUAS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90506', 'LAS PALMAS(VERAGUAS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90507', 'LOLA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90508', 'PIXVAE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90509', 'PUERTO VIDAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90510', 'SAN MARTIN DE PORRES', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90511', 'VIGUI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90512', 'ZAPOTILLO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90601', 'ARENAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90602', 'GOBERNADORA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90603', 'LA GARCEANA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90604', 'LEONES(VERAGUAS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90605', 'LLANO DE CATIVAL', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90606', 'MONTIJO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90607', 'PILON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90608', 'QUEBRO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90609', 'TEBARIO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90701', 'AGUA DE SALUD', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90702', 'ALTO DE JESUS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90703', 'BUENOS AIRES/N.BUGLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90704', 'CERRO PELADO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90705', 'EL BALE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90706', 'EL PAREDON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90707', 'EL PIRO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90708', 'GUAYABITO/N.BUGLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90709', 'GUIBABLE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90801', 'CATORCE DE NOVIEMBRE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90802', 'LAS HUACAS(VERAGUAS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90803', 'LOS CASTILLOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90804', 'RIO DE JESUS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90805', 'UTIRA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90901', 'CORRAL FALSO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90902', 'LOS HATILLOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90903', 'REMANCE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90904', 'SAN FRANCISCO(VERAGU', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90905', 'SAN JUAN(VERAGUAS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91001', 'CALOVEBORA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91002', 'EL ALTO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91003', 'EL CUAY', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91004', 'EL PANTANO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91005', 'GATU O GATUCITO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91006', 'RIO LUIS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91007', 'SANTA FE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91101', 'CANTO DEL LLANO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91102', 'LA COLORADA(VERAGUAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91103', 'LA PENA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91104', 'LA RAYA DE SANTA MAR', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91105', 'LOS ALGARROBOS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91106', 'PONUGA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91107', 'SAN PEDRO DEL ESPINO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91108', 'SANTIAGO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91201', 'BAHIA HONDA(VERAGUAS', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91202', 'CALIDONIA(VERAGUAS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91203', 'CATIVE', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91204', 'EL MARAÑON', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91205', 'GUARUMAL(VERAGUAS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91206', 'LA SOLEDAD', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91207', 'QUEBRADA DE ORO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91208', 'RIO GRANDE(VERAGUAS)', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91209', 'RODEO VIEJO', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91210', 'SONA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '100101', 'AILIGANDI', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '100102', 'NARGANA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '100103', 'PUERTO OBALDIA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '100104', 'TUBALA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '110101', 'MUNA', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '120101', 'UMANI 01', 'V' )
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_tparroquia'
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'C', 'CORREGIMIENTO', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_region_nat'
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'RC', 'REGION CENTRAL', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'OR', 'REGION ORIENTE', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'OC', 'REGION OCCIDENTE', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_region_ope'
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'ME1', 'METRO I', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'ME2', 'METRO II', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'CEN', 'CENTRAL', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'OCC', 'OCCIDENTAL', 'V')
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'SS', 'SIN SUCURSAL', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_suc_correo'
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'0','ESTAFETA ALMIRANTE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'1','ESTAFETA BOCAS DEL TORO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'2','ESTAFETA CHANGUINOLA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'3','ESTAFETA CHIRIQUÍ GRANDE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'4','ESTAFETA GUABITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'5','ESTAFETA DAVID','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'6','ESTAFETA DE ALANJE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'7','ESTAFETA DE BOQUERÓN','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'8','ESTAFETA DE BOQUETE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'9','ESTAFETA DE CERRO PUNTA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'10','ESTAFETA DE CONCEPCIÓN','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'11','ESTAFETA DE DOLEGA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'12','ESTAFETA DE HORCONCITOS','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'13','ESTAFETA DE POTRERILLO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'14','ESTAFETA DE PUERTOS ARMUELLES','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'15','ESTAFETA DE REMEDIOS','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'16','ESTAFETA DE TOLÉ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'17','ESTAFETA DE VOLCÁN','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'18','ESTAFETA DIVALA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'19','ESTAFETA EL PROGRESO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'20','ESTAFETA GUALACA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'21','ESTAFETA LAS LAJAS','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'22','ESTAFETA NANCITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'23','ESTAFETA PASO CANOA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'24','ESTAFETA RÍO SERENO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'25','ESTAFETA SAN FELIX','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'26','ESTAFETA SAN LORENZO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'27','ESTAFETA UNIVERSITARIA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'28','ESTAFETA  EL JAGUITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'29','ESTAFETA  EL ROBLE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'30','ESTAFETA ANTÓN','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'31','ESTAFETA DE AGUADULCE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'32','ESTAFETA DE OLÁ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'33','ESTAFETA DE PENONOMÉ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'34','ESTAFETA EL CAÑO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'35','ESTAFETA EL CRISTO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'36','ESTAFETA LA PINTADA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'37','ESTAFETA NATÁ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'38','ESTAFETA POCRÍ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'39','ESTAFETA RÍO GRANDE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'40','ESTAFETA RÍO HATO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'41','ESTAFETA CALLE 9','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'42','ESTAFETA SABANITAS','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'43','ESTAFETA ZONA LIBRE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'44','ESTAFETA DE EL REAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'45','ESTAFETA DE METETÍ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'46','ESTAFETA DE SANTA FÉ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'47','ESTAFETA DE YAVIZA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'48','ESTAFETA DE CHITRÉ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'49','ESTAFETA DE CHUPAMPA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'50','ESTAFETA DE DIVISA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'51','ESTAFETA DE LA ARENA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'52','ESTAFETA DE LAS MINAS','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'53','ESTAFETA DE MONAGRILLO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'54','ESTAFETA DE OCÚ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'55','ESTAFETA DE PARITA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'56','ESTAFETA DE PESÉ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'57','ESTAFETA DE SANTA MARÍA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'58','ESTAFETA LOS POZOS','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'59','ESTAFETA DE GUARARÉ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'60','ESTAFETA DE LA PALMA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'61','ESTAFETA DE LAS TABLAS','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'62','ESTAFETA DE LOS SANTOS','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'63','ESTAFETA DE MACARACAS','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'64','ESTAFETA DE PEDASÍ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'65','ESTAFETA DE POCRÍ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'66','ESTAFETA DE PURIO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'67','ESTAFETA DE SANTO DOMINGO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'68','ESTAFETA DE TONOSÍ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'69','ESTAFETA SABANA GRANDE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'70','ESTAFETA BALBOA - ANCÓN','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'71','ESTAFETA DE ARRAIJÁN','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'72','ESTAFETA DE BEJUCO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'73','ESTAFETA DE CAPIRA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'74','ESTAFETA DE CHAME','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'75','ESTAFETA DE GAMBOA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'76','ESTAFETA DE SAN CARLOS','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'77','ESTAFETA DE VISTA ALEGRE EL REY','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'78','ESTAFETA EL VALLE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'79','ESTAFETA LA CHORRERA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'80','ESTAFETA PAITILLA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'81','ESTAFETA PARAÍSO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'82','ESTAFETA PLAZA PANAMÁ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'83','ESTAFETA U . DE PANAMÁ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'84','ESTAFETA USMA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'85','ESTAFETA VILLA LUCRE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'86','ESTAFETA WORLD TRADE CENTER','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'87','ZONA 02 - CHORRILLO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'88','ZONA 03 - AVENIDA B','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'89','ZONA 04 - CALIDONIA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'90','ZONA 05 -  AVENIDA BALBOA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'91','ZONA 06 - BETANIA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'92','ZONA 06A - EL DORADO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'93','ZONA 07  -  PLAZA CONCORDIA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'94','ZONA 08  - PUEBLO NUEVO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'95','ZONA 09  -  SAN FRANCISCO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'96','ZONA 09A - CARRASQUILLA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'97','ZONA 10 - PARQUE LEFEVRE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'98','ZONA 11 - SAN MIGUELITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'99','ZONA 12 - LOS PUEBLOS','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'100','ZONA 13 - PLAZA TOCUMÉN','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'101','ZONA 14 - 24 DE DICIEMBRE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'102','ZONA 15 - LAS CUMBRES','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'103','ZONA 17 - PACORA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'104','ZONA 17A - CHEPO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'105','ZONA 18 - CHILIBRE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'106','ESTAFETA ATALAYA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'107','ESTAFETA CALOBRE','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'108','ESTAFETA CAÑAZAS','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'109','ESTAFETA DE SANTIAGO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'110','ESTAFETA LA MESA','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'111','ESTAFETA LA NORMAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'112','ESTAFETA LAS PALMAS','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'113','ESTAFETA MONTIJO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'114','ESTAFETA RÍO DE JESÚS','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'115','ESTAFETA SAN FRANCISCO','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'116','ESTAFETA SANTA FÉ','V')
insert into cl_catalogo(tabla,codigo,valor,estado)values(@w_codigo,'117','ESTAFETA SONÁ','V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cc_tipo_oficial'		
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '1', 'NIVEL 1','V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '2', 'NIVEL 2','V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '3', 'NIVEL 3','V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '4', 'NIVEL 4','V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '5', 'NIVEL 5','V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '6', 'NIVEL 6','V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '7', 'NIVEL 7','V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '8', 'NIVEL MAXIMO','V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'ad_protocolo'	
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'T', 'TCP/IP','V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cc_sector'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'P', 'CORPORATIVO','V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'C', 'CONSUMO','V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_tipo_ejecucion'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '0', 'LOCAL', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '1', 'CENTRAL', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '2', 'REEJECUCION LOCAL', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_tipo_medio'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '0', 'E-MAIL','V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '1', 'HELPDESK','V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '2', 'WEB SITE','V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'te_periodos'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '1', '360', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '3', 'TRIMESTRAL', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '6', 'SEMESTRAL', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '12', 'ANUAL', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'te_tipo_servicio'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '1', 'TIME DEPOSIT', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '2', 'CERTIFICADOS DE RENTA ANTICIPADA', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '3', 'CUENTAS CORRIENTES', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '4', 'CUENTAS DE AHORRO', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '5', 'DEPOSITOS A PLAZO MAYOR', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '6', 'OPERACIONES GENERALES DE CREDITO', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '7', 'POLIZAS DE ACUMULACION', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '8', 'TASAS EFECTIVAS', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '9', 'TASAS REFERENCIALES DE REVERSE REPOS', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '10', 'TASAS REFERENCIALES DE REPOS', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '11', 'TASAS REFERENCIALES DE INTERBANCARIOS', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '12', 'FORWARDS', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '13', 'MASTER CARD', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '14', 'PAPEL COMERCIAL (OBLIGACIONES)', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '15', 'DESCUENTO DE PAPELES', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '16', 'POOL', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '17', 'PAGARES', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '18', 'CERTIFICADO DE AHORRO', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'te_mercado'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '1', 'UNICO', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'te_grupos_tasas'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'GR1CARTE', 'GERENCIA DE OPERACIONES- CARTERA', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'GR1TESOR', 'GERENCIA DE TESORERIA - MESA DE DINERO', 'V')
go


declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'aw_idioma'
insert into cl_catalogo	(tabla, codigo, valor, estado) values (@w_codigo, 'ESP', 'ESPAÑOL', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'ta_tipo'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '1', 'FINANCIERA', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '2', 'ADMINISTRATIVA', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '3', 'DE SERVICIO', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_area_oficina'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'MET1', 'METROPOLITANA I', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'MET2', 'METROPOLITANA II', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'CEN', 'CENTRAL', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'OCC', 'OCCIDENTAL', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'DGE', 'DIRECCION GENERAL', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'BCO', 'BANCA CORPORATIVA', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'BPR', 'BANCA PRIVADA', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'ad_tipo_tran'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'N', 'NUEVO REGISTRO', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'P', 'REGISTRO ANTES DE MODIFICACION', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'A', 'REGISTRO DESPUES DE MODIFICACION', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'B', 'REGISTRO ELIMINADO', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'E', 'REGISTRO ELIMINADO', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'ad_windows_authentication_user'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'WAU', 'COBIS', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_nombre_banco'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '1', 'DAVIVIENDA', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '2', 'BANCO COBISCORP', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '3', 'cobis@macosa.com', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '4', 'www.macosa.com', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '5', 'COBIS NET', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '6', '0', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_producproc'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'sp_ca07_pf' , 'BUSQUEDA CALIFICACION GARANTIA CLASE CARTERA', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'sp_ca04_pf' , 'BUSQUEDA CALIFICACION GARANTIA CLASE CARTERA', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_tipo_horario'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'C', 'CONTINUO',    'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'D', 'DISCONTINUO', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_sector_geografico'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'R', 'RURAL',  'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'U', 'URBANO', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_regional'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'R1', 'REGIONAL 1', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'R2', 'REGIONAL 2', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'R3', 'REGIONAL 3', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'R4', 'REGIONAL 4', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_tipo_punto_at'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'SUC', 'SUCURSAL', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'AG',  'AGENCIA',  'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'TPA1','TIPOPUNTOATENCION 1', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'TPA2','TIPOPUNTOATENCION 2', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'TPA3','TIPOPUNTOATENCION 3', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'TPA4','TIPOPUNTOATENCION 4', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_canton'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '1', 'Canton 1', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '2', 'Canton 2', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_sector'
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'U', 'URBANO', 'V')
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'R', 'RURAL', 'V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_tipo_ambito'
insert into cl_catalogo values (@w_codigo, '1','Ambito 1','V', null, null, null)
insert into cl_catalogo values (@w_codigo, '2','Ambito 2','V', null, null, null)
insert into cl_catalogo values (@w_codigo, '3','Ambito 3','V', null, null, null)
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_ambito'
insert into cl_catalogo values (@w_codigo, 'NAC','Nacional','V', null, null, null)
insert into cl_catalogo values (@w_codigo, 'REG','Regional','V', null, null, null)
insert into cl_catalogo values (@w_codigo, 'SUB','Sub Regional','V', null, null, null)
insert into cl_catalogo values (@w_codigo, 'OFI','Oficina','V', null, null, null) 
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_causa_bloqueo'
insert into cl_catalogo values (@w_codigo, '1','CAUSA DE BLOQUEO 1','V', null, null, null)
insert into cl_catalogo values (@w_codigo, '2','CAUSA DE BLOQUEO 2','V', null, null, null)
insert into cl_catalogo values (@w_codigo, '3','CAUSA DE BLOQUEO 3','V', null, null, null)
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_estado_ambito'
insert into cl_catalogo values (@w_codigo, 'C','CANCELADO','V', null, null, null)
insert into cl_catalogo values (@w_codigo, 'V','VIGENTE','V', null, null, null)
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_tproducto'
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'R', 'REGIONAL','V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'te_media_dolar'
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', '*','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', '*','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', '*','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', '/','V')
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_tipo_oficina'
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'O', 'OFICINA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'R', 'REGIONAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'Z', 'SUCURSAL','V')
go

/************************************************************************/
print 'cl_moneda'
/************************************************************************/
go
truncate table cl_moneda
go
insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (0,'BOLIVIANOS',68,'V','S','BS','BOB')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (1,'DOLAR',840,'V','S','US$','USD')
insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (2,'DOLARES ESTADOUNIDENSES',49,'V','S','US$','USD')
insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (3,'BOLIVIANOS CON MANTENIMIENTO DE VALOR',68,'V','S','CMV','CMV')
insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (4,'MN CON MV A LA UNIDAD DE FOMENTO A LA VIVIENDA',68,'V','S','UFV','UFV')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (5,'YEN JAPONES',392,'V','S','¥','JPY')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (6,'CORONA DANESA',208,'V','S','kr.','DKK')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (7,'LIBRA ESTERLINA',826,'V','S','£','GBP')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (8,'FRANCO SUIZO',752,'V','S','CHF','CHF')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (9,'DOLAR CAYMAN',136,'V','S','$','KYD')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (10,'PESO DOMINICANO',214,'V','S','RD$','DOP')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (11,'PESO MEXICANO',484,'V','S','$','MXN')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (12,'SHEGEL ISRAELI',376,'V','S','ILS','ILS')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (13,'DOLAR BELIZE',84,'V','S','BZ$','BZD')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (14,'QUETZAL GUATEMALA',320,'V','S','Q','GTQ')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (15,'LEMPIRA HONDURAS',340,'V','S','L','HNL')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (16,'CORDOBA NICARAGUA',558,'V','S','C$','NIO')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (17,'COLON COSTARICENSE',188,'V','S','¢','CRC')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (18,'COLON EL SALVADOR',222,'V','S','¢','SVC')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (19,'PESO ARGENTINO',32,'V','S','$','ARS')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (20,'BOLIVIANO',68,'V','S','$b','BOB')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (21,'REAL BRASIL',76,'V','S','R$','BRL')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (22,'PESO CHILENO',152,'V','S','$','CLP')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (23,'PESO COLOMBIANO',170,'V','S','$','COP')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (24,'DOLAR ECUATORIANO',218,'V','S','$','ECS')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (25,'DOLAR GUYANA',328,'V','S','$','GYD')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (26,'GUARANI PARAGUAYO',600,'V','S','Gs','PYG')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (27,'NUEVO SOL PERUANO',604,'V','S','S/.','PEN')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (28,'DOLAR SURINAM',740,'V','S','$','SRG')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (29,'BOLIVAR VENEZOLANO',862,'V','S','Bs','VEF')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (30,'PESO URUGUAYO',858,'V','S','$U','UYU')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (31,'RUBLO RUSO',643,'V','S','$','RUB')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (32,'DOLAR SINGAPUR',702,'V','S','$','SGD')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (33,'WON COREA DEL SUR',410,'V','S','KRW','KRW')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (34,'DOLAR TAIWAN',158,'V','S','$','TWD')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (35,'DOLAR HONG KONG',344,'V','S','$','HKD')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (36,'RUPIAH INDONESIO',360,'V','S','Rp','IDR')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (37,'DOLAR NUEVA ZELANDA',554,'V','S','$','NZD')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (38,'RUPEE INDIA',356,'V','S','INR','INR')
--insert into cl_moneda (mo_moneda,mo_descripcion,mo_pais,mo_estado,mo_decimales,mo_simbolo,mo_nemonico) values (39,'PESO FILIPINAS',608,'V','S','PHP','PHP')
go


/************************************************************************/
print 'cl_pais'
/************************************************************************/
go
truncate table cl_pais
go
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(4,'AFGANISTAN','AF','AFGANO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(8,'ALBANIA','AL','ALBANES','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(276,'ALEMANIA','DE','ALEMAN','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(20,'ANDORRA','AD','ANDORRANO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(24,'ANGOLA','AO','ANGOLEÑO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(660,'ANGUILA','AI','DE ANGUILA','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(10,'ANTARTIDA','AQ','ANTARTICO','V','AMN')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(28,'ANTIGUA Y BARBUDA','AG','DE ANTIGUA Y BARBUDA','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(530,'ANTILLAS NEERLANDESAS (PAISES BAJOS)','AN','ANTILLANO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(682,'ARABIA SAUDI','SA','SAUDI','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(12,'ARGELIA','DZ','ARGELINO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(32,'ARGENTINA','AR','ARGENTINO','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(51,'ARMENIA','AM','ARMENIO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(533,'ARUBA (PAISES BAJOS)','AW','ARUBEÑO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(36,'AUSTRALIA','AU','AUSTRALIANO','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(40,'AUSTRIA','AT','AUSTRIACO, AUSTRIACO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(31,'AZERBAIYAN','AZ','AZERBAIYANO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(44,'BAHAMAS','BS','BAHAMEÑO, BAHAMES','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(48,'BAHRAIN','BH','BAHRINI','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(50,'BANGLADESH','BD','BANGLADESHI, DE BANGLADESH','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(52,'BARBADOS','BB','BARBADENSE','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(56,'BELGICA','BE','BELGA','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(84,'BELIZE','BZ','BELICEÑO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(204,'BENIN','BJ','BENINES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(60,'BERMUDAS (REINO UNIDO)','BM','BERMUDEÑO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(64,'BHUTAN','BT','BUTANES','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(112,'BIELORRUSIA','BY','BIELORRUSO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(896,'BIRMANIS','BIR','BIRMANO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(68,'BOLIVIA','BO','BOLIVIANO','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(70,'BOSNIA Y HERZEGOVINA','BA','BOSNIO-HERCEGOVINO,BOSNIO,BOSNIACO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(72,'BOTSWANA','BW','BOTSUANES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(76,'BRASIL','BR','BRASILEÑO','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(96,'BRUNEI DARUSSALAM','BN','DE BRUNEI','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(100,'BULGARIA','BG','BULGARO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(854,'BURKINA FASO','BF','BURKINES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(108,'BURUNDI','BI','BURUNDES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(132,'CABO VERDE','CV','CABOVERDIANO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(116,'CAMBOYA','KH','CAMBOYANO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(120,'CAMERUN','CM','CAMERUNES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(124,'CANADA','CA','CANADIENSE','V','AMN')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(148,'CHAD','TD','CHADIANO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(203,'REPUBLICA CHECA','CZ','CHECO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(152,'CHILE','CL','CHILENO','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(156,'CHINA','CN','CHINO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(196,'CHIPRE','CY','CHIPRIOTA','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(170,'COLOMBIA','CO','COLOMBIANO','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(174,'COMORAS','KM','COMORANO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(178,'CONGO','CG','CONGOLEÑO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(180,'CONGO, REPUBLICA DEMOCRATICA DEL' ,'CD','CONGOLEÑO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(408,'COREA DEL NORTE','KP','NORCOREANO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(410,'COREA DEL SUR','KR','SURCOREANO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(384,'COSTA DE MARFIL','CI','MARFILEÑO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(188,'COSTA RICA','CR','COSTARRICENSE','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(191,'CROACIA','HR','CROATA','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(192,'CUBA','CU','CUBANO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(208,'DINAMARCA','DK','DANES','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(262,'DJIBOUTI','DJ','DJIBUTIANO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(212,'DOMINICA','DM','DE DOMINICA','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(218,'ECUADOR','EC','ECUATORIANO','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(818,'EGIPTO','EG','EGIPCIO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(222,'EL SALVADOR','SV','SALVADOREÑO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(784,'EMIRATOS ARABES UNIDOS (EAU)','AE','DE LOS EMIRATOS ARABES UNIDOS','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(232,'ERITREA','ER','ERITREO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(703,'ESLOVAQUIA','SK','ESLOVACO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(705,'ESLOVENIA','SI','ESLOVENO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(724,'ESPAÑA','ES','ESPAÑOL','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(336,'ESTADO VATICANO','VA','DE LA SANTA SEDE','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(840,'ESTADOS UNIDOS (EE.UU.)','US','ESTADOUNIDENSE','V','AMN')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(233,'ESTONIA','EE','ESTONIO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(744,'ESVALBARD Y JAN MAYEN','SJ','DE SVALBARD Y JAN MAYEN','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(231,'ETIOPIA','ET','ETIOPE','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(242,'FIJI','FJ','DE LAS ISLAS FIJI','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(608,'FILIPINAS','PH','FILIPINO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(246,'FINLANDIA','FI','FINLANDES','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(250,'FRANCIA','FR','FRANCES','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(266,'GABON','GA','GABONES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(270,'GAMBIA','GM','GAMBIANO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(268,'GEORGIA','GE','GEORGIANO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(239,'GEORGIA DEL SUR E ISLAS SANDWICH DEL SUR','GS','DE LAS ISLAS GEORGIA DEL SUR Y SANDWICH DEL SUR','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(288,'GHANA','GH','GHANES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(292,'GIBRALTAR (REINO UNIDO)','GI','GIBRALTAREÑO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(308,'GRANADA','GD','GRANADINO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(300,'GRECIA','GR','GRIEGO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(304,'GROENLANDIA (DINAMARCA)','GL','GROENLANDES','V','AMN')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(312,'GUADALUPE','GP','GUADALUPEÑO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(316,'GUAM (ESTADOS UNIDOS)','GU','DE GUAM','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(320,'GUATEMALA','GT','GUATEMALTECO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(328,'GUAYANA','GY','GUYANES','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(827,'GUERNSEY','GUY','DE GUERNSEY','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(324,'GUINEA','GN','GUINEANO, DE GUINEA','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(226,'GUINEA ECUATORIAL','GQ','ECUATOGUINEANO, DE GUINEA ECUATORIAL','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(254,'GUINEA FRANCESA','GF','GUAYANES','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(624,'GUINEA-BISSAU','GW','DE GUINEA-BISSAU','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(332,'HAITI','HT','HAITIANO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(340,'HONDURAS','HN','HONDUREÑO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(344,'HONG KONG','HK', 'DE HONG KONG','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(348,'HUNGRIA','HU','HUNGARO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(356,'INDIA','IN','INDIO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(360,'INDONESIA','ID','INDONESIO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(364,'IRAN','IR','IRANI','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(368,'IRAQ','IQ','IRAQUI','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(372,'IRLANDA','IE','IRLANDES','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(74,'ISLA BOUVET (NORUEGA)','BV','DE LA ISLA BOUVET','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(162,'ISLA NAVIDAD','CX','DE LA ISLA NAVIDAD','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(352,'ISLANDIA','IS','ISLANDES','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(136,'ISLAS CAIMAN (REINO UNIDO)','KY','DE LAS ISLAS CAIMAN','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(166,'ISLAS COCOS','CC','DE LAS ISLAS COCOS','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(184,'ISLAS COOK','CK','DE LAS ISLAS COOK','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(234,'ISLAS FEROE (DINAMARCA)','FO','FEROES','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(334,'ISLAS HEARD Y MCDONALD (AUSTRALIA)','HM','DE LAS ISLAS HEARD Y MCDONALD','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(238,'ISLAS MALVINAS (REINO UNIDO)','FK','MALVINENSE','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(580,'ISLAS MARIANAS DEL NORTE','MP','DE LAS ISLAS MARIANAS','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(584,'ISLAS MARSHALL','MH','DE LAS ISLAS MARSHALL','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(574,'ISLAS NORFOLK','NF','DE LA ISLA NORFOLK','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(90,'ISLAS SALOMON','SB','DE LAS ISLAS SALOMON','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(796,'ISLAS TURKS Y CAICOS','TC','DE LAS ISLAS TURCAS Y CAICOS','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(581,'ISLAS ULTRAMARINAS DE ESTADOS UNIDOS','UM','-','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(850,'ISLAS VIRGENES DE ESTADOS UNIDOS','VI','DE LAS ISLAS VIRGENES','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(92,'ISLAS VIRGENES BRITANICAS (REINO UNIDO)','VG','DE LAS ISLAS VIRGENES','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(897,'ISLE OF MAN','IM','-','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(376,'ISRAEL','IL','ISRAELI','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(380,'ITALIA','IT','ITALIANO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(388,'JAMAICA','JM','JAMAICANO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(392,'JAPON','JP','JAPONES','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(895,'JERSEY','JE','JERSENIO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(400,'JORDANIA','JO','JORDANO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(398,'KAZAJISTAN','KZ','KAZAJO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(404,'KENIA','KE','KENIANO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(417,'KIRGUIZISTAN','KG','KIRGUIZO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(296,'KIRIBATI','KI','DE KIRIBATI','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(414,'KUWAIT','KW','KUWAITI','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(418,'LAOS','LA', 'DE LAOS','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(426,'LESOTO','LS','DE LESOTO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(428,'LETONIA','LV','LETON','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(422,'LIBANO','LB','LIBANES','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(430,'LIBERIA','LR','LIBERIANO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(434,'LIBIA','LY','LIBIO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(438,'LIECHTENSTEIN','LI','DE LIECHTENSTEIN','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(440,'LITUANIA','LT','LITUANO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(442,'LUXEMBURGO','LU','LUXEMBURGUES','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(446,'MACAO','MO','DE MACAO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(807,'MACEDONIA,ANTIGUA REPUBLICA YUGOSLAVA DE' ,'MK','MACEDONIO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(450,'MADAGASCAR','MG','MALGACHE','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(458,'MALASIA','MY','MALASIO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(454,'MALAWI','MW','MALAUI','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(462,'MALDIVAS','MV','MALDIVO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(466,'MALI','ML','MALIENSE','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(470,'MALTA','MT','MALTES','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(504,'MARRUECOS','MA','MARROQUI','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(474,'MARTINICA','MQ','MARTINIQUES','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(480,'MAURICIO','MU','MAURICIANO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(478,'MAURITANIA','MR','MAURITANO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(175,'MAYOTTE','YT','MAHORES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(484,'MEXICO','MX','MEXICANO','V','AMN')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(104,'MIANMAR','MM','MYANMA','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(583,'MICRONESIA','FM','MICRONESIO','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(498,'MOLDAVIA','MD','MOLDAVO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(492,'MONACO','MC','MONEGASCO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(496,'MONGOLIA','MN','MONGOL','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(500,'MONTSERRAT (REINO UNIDO)','MS','DE MONTSERRAT','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(508,'MOZAMBIQUE','MZ','MOZAMBIQUEÑO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(516,'NAMIBIA','NA','NAMIBIO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(520,'NAURU','NR','NAURUANO','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(524,'NEPAL','NP','NEPALI','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(558,'NICARAGUA','NI','NICARAGÜENSE','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(562,'NIGER','NE','NIGERINO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(566,'NIGERIA','NG','NIGERIANO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(570,'NIUE','NU','NIUENSE','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(578,'NORUEGA','NO','NORUEGO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(540,'NUEVA CALEDONIA','NC','NEOCALEDONIO, DE NUEVA CALEDONIA','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(554,'NUEVA ZELANDA','NZ','NEOZELANDES','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(512,'OMAN','OM','OMANI','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(528,'PAISES BAJOS','NL','NEERLANDES','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(586,'PAKISTAN','PK','PAQUISTANI','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(585,'PALAOS','PW','DE PALAOS','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(275,'PALESTINA (CISJORDANIA Y FRANJA DE GAZA)','PS','PALESTINO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(591,'PANAMA','PA','PANAMEÑO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(598,'PAPUA-NUEVA GUINEA','PG','DE PAPUA-NUEVA GUINEA','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(600,'PARAGUAY','PY','PARAGUAYO','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(604,'PERU','PE','PERUANO','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(612,'PITCAIRN (REINO UNIDO)','PN','DE LAS ISLAS PITCAIRN','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(258,'POLINESIA FRANCESA','PF','POLINESIO','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(616,'POLONIA','PL','POLACO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(620,'PORTUGAL','PT','PORTUGUES','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(630,'PUERTO RICO (ESTADOS UNIDOS)','PR','PORTORRIQUEÑO, PUERTORRIQUEÑO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(634,'QATAR','QA','DE QATAR','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(826,'REINO UNIDO','GB','BRITANICO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(140,'REPUBLICA CENTROAFRICANA','CF','CENTROAFRICANO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(214,'REPUBLICA DOMINICANA','DO','DOMINICANO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(638,'REUNION','RE','REUNIONES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(646,'RUANDA','RW','RUANDES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(642,'RUMANIA','RO','RUMANO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(643,'RUSIA','RU','RUSO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(732,'SAHARA OCCIDENTAL','EH','SAHARAUI','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(882,'SAMOA','WS','DE SAMOA, SAMOANO','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(16,'SAMOA AMERICANA','AS','DE SAMOA AMERICANA, SAMOANO','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(674,'SAN MARINO','SM','SANMARINENSE','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(666,'SAN PEDRO Y MIQUELON','PM','DE SAN PEDRO Y MIQUELON','V','AMN')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(670,'SAN VINCENTE Y LAS GRANADINAS','VC','DE SAN VICENTE Y LAS GRANADINAS','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(654,'SANTA HELENA','SH','DE SANTA ELENA','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(659,'SANTA KITTS Y NEVIS','KN','DE SANTA KITTS Y NEVIS','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(662,'SANTA LUCIA','LC','SANTALUCENSE','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(678,'SANTO TOME Y PRINCIPE','ST','DE SANTO TOME Y PRINCIPE','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(686,'SENEGAL','SN','SENEGALES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(891,'SERBIA Y MONTENEGRO','CS','DE SERBIA Y MONTENEGRO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(690,'SEYCHELLES','SC','DE SEYCHELLES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(694,'SIERRA LEONA','SL','SIERRALEONES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(702,'SINGAPUR','SG','SINGAPURENSE','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(760,'SIRIA','SY','SIRIO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(706,'SOMALIA','SO','SOMALI','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(144,'SRI LANKA','LK','CEILANDES','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(748,'SUAZILANDIA','SZ','SUAZILANDES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(710,'SUDAFRICA','ZA','SUDAFRICANO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(736,'SUDAN','SD','SUDANES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(752,'SUECIA','SE','SUECO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(756,'SUIZA','CH','SUIZO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(740,'SURINAM','SR','SURINAMES','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(764,'TAILANDIA','TH','TAILANDES','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(158,'TAIWAN','TW','TAIWANES','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(762,'TAJIKISTAN','TJ','TAYIKO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(834,'TANZANIA','TZ','TANZANO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(260,'TERRITORIOS AUSTRALES FRANCESES','TF','DE LOS TERRITORIOS AUSTRALES FRANCESES','V','AMN')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(626,'TIMOR ORIENTAL','TL','TIMORENSE','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(768,'TOGO','TG','TOGOLES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(772,'TOKELAU (NUEVA ZELANDA)','TK','TOKELAUES','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(776,'TONGA','TO','TONGANO','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(780,'TRINIDAD Y TOBAGO','TT','DE TRINIDAD Y TOBAGO','V','AMC')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(788,'TUNEZ','TN','TUNECINO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(795,'TURMENISTAN','TM','TURCOMANO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(792,'TURQUIA','TR','TURCO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(798,'TUVALU','TV','DE TUVALU, TUVALUANO','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(804,'UCRANIA','UA','UCRANIANO, UCRANIO','V','EUR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(800,'UGANDA','UG','UGANDES','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(858,'URUGUAY','UY','URUGUAYO','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(860,'UZBEKISTAN','UZ','UZBEKO','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(548,'VANUATU','VU','DE VANUATU','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(862,'VENEZUELA','VE','VENEZOLANO','V','AMS')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(704,'VIETNAM','VN','VIETNAMITA','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(876,'WALLIS Y FUTUNA','WF','DE WALLIS Y FUTUNA','V','OCE')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(887,'YEMEN','YE','YEMENI','V','ASI')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(894,'ZAMBIA','ZM','ZAMBIANO','V','AFR')
insert into cl_pais(pa_pais,pa_descripcion,pa_abreviatura,pa_nacionalidad,pa_estado,pa_continente)values(716,'ZIMBABUE','ZW','ZIMBABUENSE','V','AFR')
go

declare @w_siguiente int
select @w_siguiente = max(pa_pais) + 1 from cl_pais

update	cl_seqnos
set	siguiente = @w_siguiente
where	tabla = 'cl_pais'
go


/************************************************************************/
print 'cl_provincia'
/************************************************************************/
go
truncate table cl_provincia
go
insert into cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado)values (1, 'BOCAS DEL TORO', 'OC', 'OCC', 591, 'V' )
insert into cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado)values (2, 'COCLE', 'RC', 'CEN', 591, 'V' )
insert into cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado)values (3, 'COLON', 'OR', 'ME2', 591, 'V' )
insert into cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado)values (4, 'CHIRIQUI', 'OC', 'OCC', 591, 'V' )
insert into cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado)values (5, 'DARIEN', 'OR', 'SS', 591, 'V' )
insert into cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado)values (6, 'HERRERA', 'RC', 'CEN', 591, 'V' )
insert into cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado)values (7, 'LOS SANTOS', 'RC', 'CEN', 591, 'V' )
insert into cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado)values (8, 'PANAMA', 'OR', 'ME1', 591, 'V' )
insert into cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado)values (9, 'VERAGUAS', 'RC', 'CEN', 591, 'V' )
insert into cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado)values (10, 'COMARCA KUNA YALA', 'RC', 'CEN', 591, 'V' )
insert into cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado)values (11, 'COMARCA DE MUNA', 'RC', 'CEN', 591, 'V' )
insert into cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado)values (12, 'COMARCA DE UMANI', 'RC', 'CEN', 591, 'V' )
go

declare @w_siguiente int
select @w_siguiente = max(pv_provincia) + 1 from cl_provincia

update	cl_seqnos
set	siguiente = @w_siguiente
where	tabla = 'cl_provincia'
go


/************************************************************************/
print 'cl_suc_correo'
/************************************************************************/
go
truncate table cl_suc_correo
go 
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(1,0,'ESTAFETA ALMIRANTE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(1,1,'ESTAFETA BOCAS DEL TORO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(1,2,'ESTAFETA CHANGUINOLA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(1,3,'ESTAFETA CHIRIQUI GRANDE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(1,4,'ESTAFETA GUABITO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,5,'ESTAFETA DAVID','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,6,'ESTAFETA DE ALANJE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,7,'ESTAFETA DE BOQUERN','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,8,'ESTAFETA DE BOQUETE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,9,'ESTAFETA DE CERRO PUNTA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,10,'ESTAFETA DE CONCEPCIN','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,11,'ESTAFETA DE DOLEGA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,12,'ESTAFETA DE HORCONCITOS','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,13,'ESTAFETA DE POTRERILLO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,14,'ESTAFETA DE PUERTOS ARMUELLES','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,15,'ESTAFETA DE REMEDIOS','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,16,'ESTAFETA DE TOLE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,17,'ESTAFETA DE VOLCAN','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,18,'ESTAFETA DIVALA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,19,'ESTAFETA EL PROGRESO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,20,'ESTAFETA GUALACA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,21,'ESTAFETA LAS LAJAS','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,22,'ESTAFETA NANCITO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,23,'ESTAFETA PASO CANOA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,24,'ESTAFETA RIO SERENO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,25,'ESTAFETA SAN FELIX','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,26,'ESTAFETA SAN LORENZO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(4,27,'ESTAFETA UNIVERSITARIA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(2,28,'ESTAFETA  EL JAGUITO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(2,29,'ESTAFETA  EL ROBLE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(2,30,'ESTAFETA ANTN','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(2,31,'ESTAFETA DE AGUADULCE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(2,32,'ESTAFETA DE OLA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(2,33,'ESTAFETA DE PENONOME','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(2,34,'ESTAFETA EL CAÑO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(2,35,'ESTAFETA EL CRISTO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(2,36,'ESTAFETA LA PINTADA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(2,37,'ESTAFETA NATA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(2,38,'ESTAFETA POCRI','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(2,39,'ESTAFETA RIO GRANDE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(2,40,'ESTAFETA RIO HATO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(3,41,'ESTAFETA CALLE 9','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(3,42,'ESTAFETA SABANITAS','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(3,43,'ESTAFETA ZONA LIBRE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(5,44,'ESTAFETA DE EL REAL','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(5,45,'ESTAFETA DE METETI','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(5,46,'ESTAFETA DE SANTA FE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(5,47,'ESTAFETA DE YAVIZA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(6,48,'ESTAFETA DE CHITRE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(6,49,'ESTAFETA DE CHUPAMPA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(6,50,'ESTAFETA DE DIVISA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(6,51,'ESTAFETA DE LA ARENA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(6,52,'ESTAFETA DE LAS MINAS','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(6,53,'ESTAFETA DE MONAGRILLO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(6,54,'ESTAFETA DE OCU','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(6,55,'ESTAFETA DE PARITA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(6,56,'ESTAFETA DE PESE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(6,57,'ESTAFETA DE SANTA MARIA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(6,58,'ESTAFETA LOS POZOS','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(7,59,'ESTAFETA DE GUARARE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(7,60,'ESTAFETA DE LA PALMA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(7,61,'ESTAFETA DE LAS TABLAS','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(7,62,'ESTAFETA DE LOS SANTOS','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(7,63,'ESTAFETA DE MACARACAS','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(7,64,'ESTAFETA DE PEDASI','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(7,65,'ESTAFETA DE POCRI','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(7,66,'ESTAFETA DE PURIO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(7,67,'ESTAFETA DE SANTO DOMINGO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(7,68,'ESTAFETA DE TONOSI','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(7,69,'ESTAFETA SABANA GRANDE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,70,'ESTAFETA BALBOA - ANCN','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,71,'ESTAFETA DE ARRAIJAN','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,72,'ESTAFETA DE BEJUCO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,73,'ESTAFETA DE CAPIRA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,74,'ESTAFETA DE CHAME','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,75,'ESTAFETA DE GAMBOA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,76,'ESTAFETA DE SAN CARLOS','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,77,'ESTAFETA DE VISTA ALEGRE EL REY','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,78,'ESTAFETA EL VALLE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,79,'ESTAFETA LA CHORRERA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,80,'ESTAFETA PAITILLA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,81,'ESTAFETA PARAISO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,82,'ESTAFETA PLAZA PANAMA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,83,'ESTAFETA U . DE PANAMA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,84,'ESTAFETA USMA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,85,'ESTAFETA VILLA LUCRE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,86,'ESTAFETA WORLD TRADE CENTER','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,87,'ZONA 02 - CHORRILLO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,88,'ZONA 03 - AVENIDA B','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,89,'ZONA 04 - CALIDONIA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,90,'ZONA 05 -  AVENIDA BALBOA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,91,'ZONA 06 - BETANIA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,92,'ZONA 06A - EL DORADO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,93,'ZONA 07  -  PLAZA CONCORDIA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,94,'ZONA 08  - PUEBLO NUEVO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,95,'ZONA 09  -  SAN FRANCISCO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,96,'ZONA 09A - CARRASQUILLA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,97,'ZONA 10 - PARQUE LEFEVRE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,98,'ZONA 11 - SAN MIGUELITO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,99,'ZONA 12 - LOS PUEBLOS','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,100,'ZONA 13 - PLAZA TOCUMEN','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,101,'ZONA 14 - 24 DE DICIEMBRE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,102,'ZONA 15 - LAS CUMBRES','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,103,'ZONA 17 - PACORA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,104,'ZONA 17A - CHEPO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(8,105,'ZONA 18 - CHILIBRE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(9,106,'ESTAFETA ATALAYA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(9,107,'ESTAFETA CALOBRE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(9,108,'ESTAFETA CAÑAZAS','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(9,109,'ESTAFETA DE SANTIAGO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(9,110,'ESTAFETA LA MESA','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(9,111,'ESTAFETA LA NORMAL','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(9,112,'ESTAFETA LAS PALMAS','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(9,113,'ESTAFETA MONTIJO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(9,114,'ESTAFETA RIO DE JESUS','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(9,115,'ESTAFETA SAN FRANCISCO','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(9,116,'ESTAFETA SANTA FE','V')
insert into cl_suc_correo(sc_provincia,sc_sucursal,sc_descripcion,sc_estado)values(9,117,'ESTAFETA SONA','V')
go


/************************************************************************/
print 'cl_ciudad'
/************************************************************************/
go
truncate table cl_ciudad
go
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 101, 'BOCAS DEL TORO', 'V', 1, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 102, 'CHANGUINOLA', 'V', 1, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 103, 'CHIRIQUI GRANDE', 'V', 1, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 104, 'KANKINTU/NGOBE BUGLE', 'V', 1, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 105, 'KUSAPIN/NGOBE BUGLE', 'V', 1, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 201, 'AGUADULCE', 'V', 2, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 202, 'ANTON', 'V', 2, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 203, 'LA PINTADA', 'V', 2, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 204, 'NATA', 'V', 2, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 205, 'OLA', 'V', 2, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 206, 'PENONOME', 'V', 2, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 301, 'CHAGRES', 'V', 3, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 302, 'COLON', 'V', 3, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 303, 'DONOSO', 'V', 3, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 304, 'PORTOBELO', 'V', 3, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 305, 'SANTA ISABEL', 'V', 3, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 401, 'ALANJE', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 402, 'BARU', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 403, 'BESIKO/NGOBE BUGLE', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 404, 'BOQUERON', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 405, 'BOQUETE', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 406, 'BUGABA', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 407, 'DAVID', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 408, 'DOLEGA', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 409, 'GUALACA', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 410, 'MIRONO/NGOBE BUGLE', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 411, 'MUNA/NGOBE  BUGLE', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 412, 'NOLE DUIMA/NGOBE BUGLE', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 413, 'REMEDIOS', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 414, 'RENACIMIETO', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 415, 'SAN FELIX', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 416, 'SAN LORENZO', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 417, 'TOLE', 'V', 4, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 501, 'CEMACO /EMBERA', 'V', 5, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 502, 'CHEPIGANA', 'V', 5, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 503, 'PINOGANA', 'V', 5, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 504, 'SAMBU / C. EMBERA', 'V', 5, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 601, 'CHITRE', 'V', 6, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 602, 'LAS MINAS', 'V', 6, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 603, 'LOS POZOS', 'V', 6, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 604, 'OCU', 'V', 6, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 605, 'PARITA', 'V', 6, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 606, 'PESE', 'V', 6, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 607, 'SANTA MARÍA', 'V', 6, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 701, 'GUARARE', 'V', 7, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 702, 'LAS TABLAS', 'V', 7, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 703, 'LOS SANTOS', 'V', 7, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 704, 'MACARACAS', 'V', 7, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 705, 'PEDASI', 'V', 7, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 706, 'POCRI', 'V', 7, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 707, 'TONOSI', 'V', 7, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 801, 'ARRAIJAN', 'V', 8, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 802, 'BALBOA', 'V', 8, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 803, 'CAPIRA', 'V', 8, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 804, 'CHAME', 'V', 8, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 805, 'CHEPO', 'V', 8, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 806, 'CHIMAN', 'V', 8, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 807, 'LA CHORRERA', 'V', 8, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 808, 'PANAMA', 'V', 8, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 809, 'SAN CARLOS', 'V', 8, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 810, 'SAN MIGUELITO', 'V', 8, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 811, 'TABOGA', 'V', 8, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 901, 'ATALAYA', 'V', 9, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 902, 'CALOBRE', 'V', 9, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 903, 'CANAZAS', 'V', 9, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 904, 'LA MESA', 'V', 9, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 905, 'LAS PALMAS', 'V', 9, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 906, 'MONTIJO', 'V', 9, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 907, 'NURUM/NGOBE BUGLE', 'V', 9, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 908, 'RIO DE JESUS', 'V', 9, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 909, 'SAN FRANCISCO', 'V', 9, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 910, 'SANTA FE', 'V', 9, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 911, 'SANTIAGO', 'V', 9, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 912, 'SONA', 'V', 9, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 1001, 'COMARCA KUNA YALA', 'V', 10, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 1101, 'MUNA', 'V', 11, NULL, 591 )
insert into cl_ciudad (ci_ciudad, ci_descripcion, ci_estado, ci_provincia, ci_cod_remesas, ci_pais) values ( 1201, 'UMANI', 'V', 12, NULL, 591 )
go

declare @w_siguiente int
select @w_siguiente = max(ci_ciudad) + 1 from cl_ciudad

update	cl_seqnos
set	siguiente = @w_siguiente
where	tabla = 'cl_ciudad'
go


/************************************************************************/
print 'cl_parroquia'
/************************************************************************/
go
truncate table cl_parroquia
go
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10101, 'BASTIMENTOS', 101,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10102, 'BOCAS DEL TORO', 101,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10103, 'CAUCHERO', 101,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10104, 'PUNTA LAUREL', 101,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10105, 'TIERRA OSCURA', 101,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10201, 'ALMIRANTE', 102,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10202, 'CHANGUINOLA', 102,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10203, 'GUABITO', 102,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10204, 'TERIBE', 102,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10205, 'VALLE DEL RISCO', 102,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10301, 'CHIRIQUI GRANDE', 103,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10302, 'MIRAMAR', 103,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10303, 'PUNTA PEÑA', 103,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10304, 'PUNTA ROBALO', 103,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10305, 'RAMBALA', 103,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10401, 'BISIRA', 104,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10402, 'BURI', 104,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10403, 'GUARIVIARA', 104,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10404, 'GUORONI', 104,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10405, 'KANKINTU', 104,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10406, 'MUNUNI', 104,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10407, 'PIEDRA ROJA', 104,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10408, 'TUWAI', 104,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10501, 'BAHIA AZUL', 105,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10502, 'CALA VERORA', 105,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10503, 'KUSAPIN', 105,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10504, 'LOMA YUCA', 105,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10505, 'RIO CHIRIQUI', 105,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10506, 'TOBOBE', 105,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 10507, 'VALLE BONITO', 105,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20101, 'AGUADULCE', 201,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20102, 'BARRIOS UNIDOS', 201,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20103, 'EL CRISTO', 201,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20104, 'EL ROBLE', 201,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20105, 'POCRI', 201,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20201, 'ANTON', 202,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20202, 'CABALLERO', 202,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20203, 'CABUYA', 202,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20204, 'EL CHIRU', 202,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20205, 'EL RETIRO', 202,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20206, 'EL VALLE', 202,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20207, 'JUAN DIAZ', 202,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20208, 'RIO HATO', 202,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20209, 'SAN JUAN DE DIOS', 202,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20210, 'SANTA RITA', 202,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20301, 'EL HARINO', 203,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20302, 'EL POTRERO', 203,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20303, 'LA PINTADA', 203,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20304, 'LLANO GRANDE', 203,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20305, 'PIEDRAS GORDAS', 203,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20401, 'CAPELLANIA', 204,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20402, 'EL CAÑO', 204,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20403, 'GUZMAN', 204,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20404, 'LAS HUACAS', 204,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20405, 'NATA', 204,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20406, 'TOZA', 204,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20501, 'EL COPE', 205,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20502, 'EL PALMAR', 205,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20503, 'EL PICACHO', 205,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20504, 'LA PAVA', 205,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20505, 'OLA', 205,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20601, 'CAÑAVERAL', 206,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20602, 'CHIGUIRI ARRIBA', 206,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20603, 'COCLE', 206,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20604, 'EL COCO', 206,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20605, 'PAJONAL', 206,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20606, 'PENONOME', 206,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20607, 'RIO GRANDE', 206,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20608, 'RIO INDIO', 206,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20609, 'TOABRE', 206,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 20610, 'TULU', 206,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30101, 'ACHIOTE', 301,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30102, 'EL GUABO', 301,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30103, 'LA ENCANTADA', 301,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30104, 'NUEVO CHAGRES', 301,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30105, 'PALMAS BELLAS', 301,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30106, 'PIÑA', 301,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30107, 'SALUD', 301,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30201, 'BARRIO NORTE', 302,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30202, 'BARRIO SUR', 302,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30203, 'BUENA VISTA', 302,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30204, 'CATIVA', 302,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30205, 'CIRICITO', 302,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30206, 'CRISTOBAL', 302,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30207, 'ESCOBAL', 302,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30208, 'LIMON', 302,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30209, 'NUEVA PROVIDENCIA', 302,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30210, 'PUERTO PILON', 302,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30211, 'SABANITAS', 302,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30212, 'SALAMANCA', 302,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30213, 'SAN JUAN', 302,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30214, 'SANTA ROSA', 302,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30301, 'COCLE DEL NORTE', 303,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30302, 'EL GUASMO', 303,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30303, 'GOBEA', 303,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30304, 'MIGUEL DE LA BORDA', 303,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30305, 'RIO INDIO (COLON)', 303,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30306, 'SAN JOSE DEL GENERAL', 303,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30401, 'CACIQUE', 304,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30402, 'GARROTE', 304,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30403, 'ISLA GRANDE', 304,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30404, 'MARIA CHIQUITA', 304,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30405, 'PORTOBELO', 304,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30501, 'CUANGO', 305,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30502, 'MIRAMAR (COLON)', 305,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30503, 'NOMBRE DE DIOS', 305,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30504, 'PALENQUE', 305,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30505, 'PALMIRA', 305,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30506, 'PLAYA CHIQUITA', 305,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30507, 'SANTA ISABEL', 305,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 30508, 'VIENTO FRÍO', 305,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40101, 'ALANJE', 401,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40102, 'DIVALA', 401,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40103, 'EL TEJAR', 401,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40104, 'GUARUMAL', 401,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40105, 'PALO GRANDE', 401,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40106, 'QUEREVALO', 401,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40107, 'SANTO TOMAS', 401,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40201, 'BACO', 402,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40202, 'LIMONES', 402,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40203, 'PROGRESO', 402,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40204, 'PUERTO ARMUELLES', 402,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40205, 'RODOLFO AGUILAR DELG', 402,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40301, 'BOCA DE BALSA', 403,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40302, 'CAMARON ARRIBA', 403,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40303, 'CERRO BANCO', 403,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40304, 'CERRO DE PATENA', 403,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40305, 'EMPLANADA DE CHORCHA', 403,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40306, 'NAMNONI', 403,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40307, 'NIBA', 403,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40308, 'SOLOY', 403,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40401, 'BAGALA', 404,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40402, 'BOQUERON', 404,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40403, 'CORDILLERA', 404,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40404, 'GUABAL', 404,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40405, 'GUAYABAL', 404,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40406, 'PARAISO', 404,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40407, 'PEDREGAL', 404,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40408, 'TIJERAS', 404,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40501, 'ALTO BOQUETE', 405,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40502, 'BAJO BOQUETE', 405,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40503, 'CALDERA', 405,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40504, 'JARAMILLO', 405,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40505, 'LOS NARANJOS', 405,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40506, 'PALMIRA(BOQUETE)', 405,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40601, 'ASERRIO DE GARRICHE', 406,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40602, 'BUGABA', 406,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40603, 'CERRO PUNTA', 406,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40604, 'EL BONGO', 406,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40605, 'GOMEZ', 406,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40606, 'LA CONCEPCION', 406,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40607, 'LA ESTRELLA', 406,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40608, 'SAN ANDRES', 406,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40609, 'SANTA MARTA', 406,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40610, 'SANTA ROSA', 406,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40611, 'SANTO DOMINGO', 406,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40612, 'SORTOVA', 406,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40613, 'VOLCAN', 406,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40701, 'BIJAGUAL', 407,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40702, 'CHIRIQUI', 407,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40703, 'COCHEA', 407,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40704, 'DAVID', 407,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40705, 'GUACA', 407,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40706, 'LAS LOMAS', 407,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40707, 'PEDREGAL(DAVID)', 407,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40708, 'SAN CARLOS', 407,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40709, 'SAN PABLO NUEVO', 407,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40710, 'SAN PABLO VIEJO', 407,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40801, 'DOLEGA', 408,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40802, 'DOS RIOS', 408,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40803, 'LOS ANASTACIOS', 408,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40804, 'POTRERILLOS', 408,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40805, 'POTRERILLOS ABAJO', 408,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40806, 'ROVIRA', 408,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40807, 'TINAJAS', 408,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40901, 'GUALACA', 409,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40902, 'HORNITO', 409,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40903, 'LOS ANGELES', 409,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40904, 'PAJA DE SOMBRERO', 409,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 40905, 'RINCON', 409,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41001, 'CASCABEL', 410,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41002, 'HATO COROTU', 410,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41003, 'HATO CULANTRO', 410,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41004, 'HATO JOBO', 410,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41005, 'HATO JULI', 410,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41006, 'HATO PILON', 410,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41007, 'QUEBRADA DE LORO', 410,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41008, 'SALTO DUPI', 410,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41101, 'ALTO CABALLERO', 411,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41102, 'BAKAMA', 411,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41103, 'CERRO CANA', 411,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41104, 'CERRO PUERCO', 411,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41105, 'CHICHICA', 411,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41106, 'KRUA', 411,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41107, 'MARACA', 411,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41108, 'NIBRA', 411,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41109, 'PEÑA BLANCA/N BUGLE', 411,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41110, 'ROKA', 411,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41111, 'SITIO PRADO', 411,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41112, 'UMANI', 411,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41201, 'CERRO IGLESIAS', 412,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41202, 'HATO CHAMI', 412,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41203, 'JADEBERI', 412,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41204, 'LAJERO', 412,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41205, 'SUSANA', 412,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41301, 'EL NANCITO', 413,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41302, 'EL PORVENIR', 413,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41303, 'EL PUERTO', 413,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41304, 'REMEDIOS', 413,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41305, 'SANTA LUCIA', 413,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41401, 'BREÑON', 414,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41402, 'CAÑAS GORDAS', 414,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41403, 'MONTE LIRIO', 414,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41404, 'PLAZA CAISAN', 414,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41405, 'RIO SERENO', 414,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41406, 'SANTA CRUZ', 414,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41501, 'JUAY', 415,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41502, 'LAJAS ADENTRO', 415,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41503, 'LAS LAJAS(CHIRIQUI)', 415,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41504, 'SAN FELIX', 415,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41505, 'SANTA CRUZ(CHIRIQUI)', 415,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41601, 'BOCA CHICA', 416,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41602, 'BOCA DEL MONTE', 416,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41603, 'HORCONCITOS', 416,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41604, 'SAN JUAN(DAVID)', 416,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41605, 'SAN LORENZO', 416,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41701, 'BELLA VISTA', 417,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41702, 'CERRO VIEJO', 417,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41703, 'EL CRISTO(DAVID)', 417,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41704, 'JUSTO FIDEL PALACIOS', 417,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41705, 'LAJAS DE TOLE', 417,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41706, 'POTRERO DE CAÑA', 417,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41707, 'QUEBRADA DE PIEDRA', 417,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41708, 'TOLE', 417,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 41709, 'VELADERO', 417,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50101, 'CIRILO GUAINORA', 501,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50102, 'LAJAS BLANCAS', 501,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50103, 'MANUEL ORTEGA', 501,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50201, 'AGUA FRIA', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50202, 'CAMOGANTI', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50203, 'CHEPIGANA', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50204, 'CUCUNATI', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50205, 'GARACHINE', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50206, 'JAQUE', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50207, 'LA PALMA', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50208, 'PUERTO PIÑA', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50209, 'RIO CONGO', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50210, 'RIO CONGO ARRIBA', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50211, 'RIO IGLESIAS', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50212, 'SAMBU', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50213, 'SANTA FE (DARIEN)', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50214, 'SETEGANTI', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50215, 'TAIMATI', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50216, 'TUCUTI', 502,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50301, 'BOCA DE CUPE', 503,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50302, 'COMARCA KUNA DE WARG', 503,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50303, 'EL REAL DE STA MARIA', 503,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50304, 'METETI', 503,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50305, 'PAYA', 503,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50306, 'PINOGANA', 503,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50307, 'PUCURO', 503,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50308, 'YAPE', 503,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50309, 'YAVIZA', 503,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50401, 'JINGRUDO', 504,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 50402, 'RIO SABALO', 504,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60101, 'CHITRE', 601,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60102, 'LA ARENA', 601,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60103, 'LLANO BONITO', 601,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60104, 'MONAGRILLO', 601,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60105, 'SAN JUAN BAUTISTA', 601,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60201, 'CHEPO', 602,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60202, 'CHUMUCAL', 602,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60203, 'EL TORO', 602,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60204, 'LAS MINAS', 602,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60205, 'LEONES', 602,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60206, 'QUEBRADA DEL ROSARIO', 602,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60301, 'CAPURI', 603,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60302, 'EL CALABACITO', 603,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60303, 'EL CEDRO', 603,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60304, 'LA ARENA(HERRERA)', 603,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60305, 'LA PITALOSA', 603,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60306, 'LOS CERRITOS', 603,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60307, 'LOS CERROS DE PAJA', 603,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60308, 'LOS POZOS', 603,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60401, 'CERRO LARGO', 604,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60402, 'EL TIJERA', 604,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60403, 'LLANO GRANDE(HERRERA', 604,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60404, 'LOS LLANOS', 604,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60405, 'OCU', 604,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60406, 'PENAS CHATAS', 604,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60501, 'CABUYA(HERRERA)', 605,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60502, 'LLANO DE LA CRUZ', 605,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60503, 'LOS CASTILLOS(HERRE)', 605,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60504, 'PARIS', 605,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60505, 'PARITA', 605,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60506, 'PORTOBELILLO', 605,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60507, 'POTUGA', 605,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60601, 'EL BARRERO', 606,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60602, 'EL CIRUELO', 606,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60603, 'EL PAJARO', 606,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60604, 'EL PEDREGOSO', 606,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60605, 'LAS CABRAS', 606,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60606, 'PESE', 606,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60607, 'RINCON HONDO', 606,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60608, 'SABANAGRANDE', 606,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60701, 'CHUPAMPA', 607,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60702, 'EL LIMON', 607,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60703, 'EL RINCON', 607,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60704, 'LOS CANELOS', 607,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 60705, 'SANTA MARIA', 607,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70101, 'EL ESPINAL', 701,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70102, 'EL HATO', 701,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70103, 'EL MACANO', 701,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70104, 'GUARARE', 701,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70105, 'GUARARE ARRIBA', 701,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70106, 'LA ENEA', 701,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70107, 'LA PASERA', 701,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70108, 'LAS TRANCAS', 701,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70109, 'LLANO ABAJO', 701,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70110, 'PERALES', 701,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70201, 'BAJO CORRAL', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70202, 'BAYANO', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70203, 'EL CARATE', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70204, 'EL COCAL', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70205, 'EL MANATIAL', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70206, 'EL MUÑOZ', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70207, 'EL PEDREGOSO(L.SANTO', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70208, 'LA LAJA', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70209, 'LA MIEL', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70210, 'LA PALMA(LOS SANTOS)', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70211, 'LA TIZA', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70212, 'LAS PALMITAS', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70213, 'LAS TABLAS', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70214, 'LAS TABLAS ABAJO', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70215, 'NUARIO', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70216, 'PALMIRA', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70217, 'PENA BLANCA', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70218, 'RIO HONDO', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70219, 'SAN JOSE', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70220, 'SAN MIGUEL', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70221, 'SANTO DOMINGO(L.S.)', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70222, 'SESTEADERO', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70223, 'VALLE RICO', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70224, 'VALLERRIQUITO', 702,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70301, 'AGUA BUENA', 703,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70302, 'EL GUASMO (L.SANTOS)', 703,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70303, 'LA COLORADA', 703,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70304, 'LA ESPIGADILLA', 703,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70305, 'LA VILLA DE LOS SANT', 703,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70306, 'LAS CRUCES', 703,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70307, 'LAS GUABAS', 703,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70308, 'LLANO LARGO', 703,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70309, 'LOS ANGELES (L.SANTOS', 703,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70310, 'LOS OLIVOS', 703,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70311, 'SABANA GRANDE', 703,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70312, 'SANTA ANA', 703,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70313, 'TRES QUEBRADAS', 703,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70314, 'VILLA LOURDES', 703,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70401, 'BAHIA HONDA', 704,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70402, 'BAJOS DE GUERRA', 704,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70403, 'CHUPA', 704,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70404, 'COROZAL', 704,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70405, 'EL CEDRO(LOS SANTOS)', 704,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70406, 'ESPINO AMARILLO', 704,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70407, 'LA MESA', 704,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70408, 'LAS PALMAS', 704,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70409, 'LLANO DE PIEDRA', 704,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70410, 'MACARACAS', 704,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70411, 'MOGOLLON', 704,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70501, 'LOS ASIENTOS', 705,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70502, 'MARIABE', 705,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70503, 'ORIA ARRIBA', 705,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70504, 'PEDASI', 705,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70505, 'PURIO', 705,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70601, 'EL CAÑAFÍSTULO', 706,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70602, 'LAJAMINA', 706,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70603, 'PARAISO(L.SANTOS)', 706,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70604, 'PARITILLA', 706,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70605, 'POCRI(LOS SANTOS)', 706,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70701, 'ALTOS DE GUERRA', 707,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70702, 'CAMBUTAL', 707,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70703, 'CAÑAS', 707,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70704, 'EL BEBEDERO', 707,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70705, 'EL CACAO', 707,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70706, 'EL CORTEZO', 707,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70707, 'FLORES', 707,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70708, 'GUANICO', 707,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70709, 'LA TRONOSA', 707,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 70710, 'TONOSI', 707,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80101, 'ARRAIJAN', 801,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80102, 'CERRO SILVESTRE', 801,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80103, 'EL LLANO(ARRAIJAN)', 801,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80104, 'JUAN D. AROSEMENA', 801,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80105, 'NUEVO EMPERADOR', 801,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80106, 'SANTA CLARA', 801,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80107, 'VACAMONTE', 801,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80108, 'VERACRUZ', 801,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80109, 'VISTA ALEGRE', 801,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80201, 'LA ENSENADA', 802,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80202, 'LA ESMERALDA', 802,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80203, 'LA GUINEA', 802,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80204, 'PEDRO GONZALEZ', 802,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80205, 'SABOGA', 802,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80206, 'SAN MIGUEL', 802,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80301, 'CAIMITO', 803,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80302, 'CAMPANA', 803,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80303, 'CAPIRA', 803,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80304, 'CERMEÑO', 803,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80305, 'CIRI DE LOS SOTOS', 803,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80306, 'CIRI GRANDE', 803,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80307, 'EL CACAO(PANAMA)', 803,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80308, 'LA TRINIDAD', 803,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80309, 'LAS OLLAS ARRIBA', 803,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80310, 'LIDICE', 803,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80311, 'SANTA ROSA(PANAMA)', 803,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80312, 'VILLA CARMEN', 803,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80313, 'VILLA ROSARIO', 803,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80401, 'BEJUCO', 804,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80402, 'BUENOS AIRES', 804,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80403, 'CABUYA(PANAMA)', 804,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80404, 'CHAME', 804,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80405, 'CHICA', 804,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80406, 'EL LIBANO', 804,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80407, 'LAS LAJAS', 804,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80408, 'NUEVA GORGONA', 804,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80409, 'PUNTA CHAME', 804,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80410, 'SAJALICES', 804,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80411, 'SORA', 804,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80501, 'CAÑITA', 805,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80502, 'CHEPILLO', 805,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80503, 'CHEPO(PANAMA)', 805,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80504, 'CRCA KUNA MADUGANDI', 805,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80505, 'EL LLANO', 805,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80506, 'FELIPILLO', 805,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80507, 'LAS MARGARITAS', 805,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80508, 'STA CRUZ DE CHININA', 805,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80509, 'TORTI', 805,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80601, 'BRUJAS', 806,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80602, 'CHIMAN', 806,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80603, 'GONZALO VASQUEZ', 806,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80604, 'PASIGA', 806,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80605, 'UNION SANTEÑA', 806,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80701, 'AMADOR', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80702, 'AROSEMENA', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80703, 'BARRIO BALBOA', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80704, 'BARRIO COLON', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80705, 'EL ARADO', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80706, 'EL COCO(PANAMA)', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80707, 'FEUILLET', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80708, 'GUADALUPE', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80709, 'HERRERA', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80710, 'HURTADO', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80711, 'ITURRALDE', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80712, 'LA HERRADURA', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80713, 'LA REPRESA', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80714, 'LOS DIAZ', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80715, 'MENDOZA', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80716, 'OBALDIA', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80717, 'PLAYA LEONA', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80718, 'PUERTO CAIMITO', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80719, 'SANTA RITA(PANAMA)', 807,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80801, 'ANCON', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80802, 'BELLA VISTA(PANAMA)', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80803, 'BETHANIA', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80804, 'CALIDONIA', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80805, 'CHILIBRE', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80806, 'CURUNDU', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80807, 'EL CHORRILLO', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80808, 'JUAN DIAZ(PANAMA)', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80809, 'LAS CUMBRES', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80810, 'PACORA', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80811, 'PARQUE LEFEVRE', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80812, 'PEDREGAL(PANAMA)', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80813, 'PUEBLO NUEVO', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80814, 'RIO ABAJO', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80815, 'SAN FELIPE', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80816, 'SAN FRANCISCO', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80817, 'SAN MARTIN', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80818, 'SANTA ANA(PANAMA)', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80819, 'TOCUMEN', 808,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80901, 'EL ESPINO', 809,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80902, 'EL HIGO', 809,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80903, 'GUAYABITO', 809,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80904, 'LA ERMITA', 809,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80905, 'LA LAGUNA', 809,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80906, 'LAS UVAS', 809,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80907, 'LOS LLANITOS', 809,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80908, 'SAN CARLOS(PANAMA)', 809,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 80909, 'SAN JOSE(PANAMA)', 809,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 81001, 'AMELIA DENIS DE ICAZ', 810,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 81002, 'ARNULFO ARIAS', 810,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 81003, 'BELISARIO FRIAS', 810,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 81004, 'BELISARIO PORRAS', 810,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 81005, 'JOSE DOMINGO ESPINAR', 810,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 81006, 'MATEO ITURRALDE', 810,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 81007, 'OMAR TORRIJOS', 810,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 81008, 'RUFINA ALFARO', 810,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 81009, 'VICTORIANO LORENZO', 810,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 81101, 'OTOQUE OCCIDENTE', 811,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 81102, 'OTOQUE ORIENTE', 811,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 81103, 'TABOGA', 811,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90101, 'ATALAYA', 901,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90102, 'EL BARRITO', 901,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90103, 'LA CARRILLO', 901,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90104, 'LA MONTAÑUELA', 901,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90105, 'SAN ANTONIO', 901,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90201, 'BARNIZAL', 902,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90202, 'CALOBRE', 902,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90203, 'CHITRA', 902,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90204, 'EL COCLA', 902,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90205, 'EL POTRERO (VERAGUAS)', 902,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90206, 'LA LAGUNA (VERAGUAS)', 902,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90207, 'LA RAYA DE CALOBRE', 902,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90208, 'LA TETILLA', 902,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90209, 'LA YEGUADA', 902,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90210, 'LAS GUIAS', 902,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90211, 'MONJARAS', 902,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90212, 'SAN JOSE(VERAGUAS)', 902,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90301, 'CANAZAS', 903,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90302, 'CERRO DE PLATA', 903,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90303, 'EL PICADOR', 903,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90304, 'LOS VALLES', 903,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90305, 'SAN JOSE(VERAGUAS9)', 903,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90306, 'SAN MARCELO', 903,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90401, 'BISVALLES', 904,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90402, 'BORO', 904,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90403, 'LA MESA(VERAGUAS)', 904,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90404, 'LLANO GRANDE(VERAGUA', 904,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90405, 'SAN BARTOLO', 904,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90501, 'CERRO DE CASA', 905,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90502, 'COROZAL(VERAGUAS)', 905,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90503, 'EL MARIA', 905,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90504, 'EL PRADO', 905,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90505, 'EL RINCON(VERAGUAS)', 905,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90506, 'LAS PALMAS(VERAGUAS)', 905,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90507, 'LOLA', 905,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90508, 'PIXVAE', 905,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90509, 'PUERTO VIDAL', 905,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90510, 'SAN MARTIN DE PORRES', 905,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90511, 'VIGUI', 905,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90512, 'ZAPOTILLO', 905,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90601, 'ARENAS', 906,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90602, 'GOBERNADORA', 906,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90603, 'LA GARCEANA', 906,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90604, 'LEONES(VERAGUAS)', 906,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90605, 'LLANO DE CATIVAL', 906,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90606, 'MONTIJO', 906,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90607, 'PILON', 906,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90608, 'QUEBRO', 906,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90609, 'TEBARIO', 906,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90701, 'AGUA DE SALUD', 907,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90702, 'ALTO DE JESUS', 907,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90703, 'BUENOS AIRES/N.BUGLE', 907,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90704, 'CERRO PELADO', 907,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90705, 'EL BALE', 907,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90706, 'EL PAREDON', 907,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90707, 'EL PIRO', 907,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90708, 'GUAYABITO/N.BUGLE', 907,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90709, 'GUIBABLE', 907,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90801, 'CATORCE DE NOVIEMBRE', 908,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90802, 'LAS HUACAS(VERAGUAS)', 908,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90803, 'LOS CASTILLOS', 908,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90804, 'RIO DE JESUS', 908,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90805, 'UTIRA', 908,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90901, 'CORRAL FALSO', 909,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90902, 'LOS HATILLOS', 909,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90903, 'REMANCE', 909,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90904, 'SAN FRANCISCO(VERAGU', 909,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 90905, 'SAN JUAN(VERAGUAS)', 909,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91001, 'CALOVEBORA', 910,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91002, 'EL ALTO', 910,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91003, 'EL CUAY', 910,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91004, 'EL PANTANO', 910,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91005, 'GATU O GATUCITO', 910,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91006, 'RIO LUIS', 910,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91007, 'SANTA FE', 910,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91101, 'CANTO DEL LLANO', 911,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91102, 'LA COLORADA(VERAGUAS', 911,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91103, 'LA PENA', 911,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91104, 'LA RAYA DE SANTA MAR', 911,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91105, 'LOS ALGARROBOS', 911,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91106, 'PONUGA', 911,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91107, 'SAN PEDRO DEL ESPINO', 911,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91108, 'SANTIAGO', 911,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91201, 'BAHIA HONDA(VERAGUAS', 912,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91202, 'CALIDONIA(VERAGUAS)', 912,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91203, 'CATIVE', 912,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91204, 'EL MARAÑON', 912,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91205, 'GUARUMAL(VERAGUAS)', 912,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91206, 'LA SOLEDAD', 912,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91207, 'QUEBRADA DE ORO', 912,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91208, 'RIO GRANDE(VERAGUAS)', 912,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91209, 'RODEO VIEJO', 912,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 91210, 'SONA', 912,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 100101, 'AILIGANDI', 1001,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 100102, 'NARGANA', 1001,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 100103, 'PUERTO OBALDIA', 1001,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 100104, 'TUBALA', 1001,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 110101, 'MUNA', 1101,'C' , 'N', 'V' )
insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_ciudad, pq_tipo,  pq_zona, pq_estado) values ( 120101, 'UMANI 01', 1201,'C' , 'N', 'V' )
go

declare @w_siguiente int
select @w_siguiente = max(pq_parroquia) + 1 from cl_parroquia

update	cl_seqnos
set	siguiente = @w_siguiente
where	tabla = 'cl_parroquia'
go


/************************************************************************/
print 'cl_filial'
/************************************************************************/
go
truncate table cl_filial
go
insert into cl_filial	(fi_filial, fi_nombre, fi_direccion, fi_actividad, fi_estado, fi_abreviatura, fi_rep_nombre, fi_contador, fi_ruc, fi_cont_nivel)
		values	(0, 'NO EXISTE FILIAL', ' ', '7512016', 'V', 'NEF', null, null, null, null)
insert into cl_filial	(fi_filial, fi_nombre, fi_direccion, fi_actividad, fi_estado, fi_abreviatura, fi_rep_nombre, fi_contador, fi_ruc, fi_cont_nivel)
		values	(1, 'BANCO', 'Calle 50 y 56 Victoriano Lorenzo', '75120161', 'V', 'GBC', 'OTTO WOLFSCHOON', null, '4097925281810', null)
go

declare @w_siguiente int
select @w_siguiente = max(fi_filial) + 1 from cl_filial

update	cl_seqnos
set	siguiente = @w_siguiente
where	tabla = 'cl_filial'
go


/************************************************************************/
print 'cl_oficina'
/************************************************************************/
go
truncate table cl_oficina
go

insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,0,'DIRECCION GENERAL','CALLE 50 Y 56, VICTORIANO LORENZO',807,0,'S','DGE')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,1,'CASA MATRIZ','CALLE 50 Y 56, VICTORIANO LORENZO',807,0,'S','MET1')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,2,'DAVID','CALLE ARISTIDES ROMERO ENTRE AVE. 1RA. Y 2DA. ESTE',405,0,'S','OCC')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,3,'SANTIAGO','AVE. CENTRAL Y CI. 9A, FRENTE AL AUTO SERVICIO SANTIAGO',909,0,'S','CEN')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,4,'CENTRO DE TARJETAS','CALLE 50 Y 56, VICTORIANO LORENZO',807,0,'S','MET1')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,5,'CORONADO','VIA INTERAMERICANA, ENTRADA A CORONADO, EDIF. GLOBAL BANK',807,0,'S','MET2')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,6,'PENONOME','CARRETERA INTERAMERICANA A UN COSTADO DEL PASO ELEVADO',205,0,'S','CEN')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,7,'SAN FERNANDO','CENTRO COMERCIAL SAN FERNANDO, VIA ESPAÑA Y URB. LA LOMA',807,0,'S','MET2')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,8,'AGUADULCE','AVE. RODOLFO CHIARI AGUADULCE.',201,0,'S','CEN')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,9,'CHITRE','PASEO ENRIQUE GEENZIER',601,0,'S','CEN')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,12,'CONCEPCION','AVE. CINCUENTENARIO,GALERIAS DON FELIX',404,0,'S','OCC')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,13,'CHANGUINOLA','AVE. 17 DE ABRIL, ATLANTIC PLAZA',101,0,'S','OCC')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,15,'CHORRERA','CENTRO COMERCIAL SAAVEDRA, AVE. DE LAS AMERICAS Y CALLE NOVENA',806,0,'S','MET2')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,16,'BOQUETE','AVE. CENTRAL, EDIF. COOP. AGRICOLA',403,0,'S','OCC')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,17,'PLAZA MIRAGE','PLAZA MIRAGE, AL LADO DEL REST. POPEYE VIA RICARDO J. ALFARO',807,0,'S','MET1')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,18,'LAS TABLAS','CI. BOLIVAR, AL LADO DEL SALON PARROQUIAL',701,0,'S','CEN')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,19,'LOS PUEBLOS','CENTRO COMERCIAL LOS PUEBLOS, JUAN DIAZ',807,0,'S','MET2')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,20,'CENTRO DE PRESTAMOS','PLAZA MIRAGE, A UN COSTADO DE BELLSOUTH, VIA RICARDO J. ALFARO',807,0,'S','MET1')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,21,'PAITILLA','VIA ITALIA, CENTRO COMERCIAL BAL HARBOUR',807,0,'S','MET1')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,22,'TORRE GLOBAL','CALLE 50, EDIF. TORRE GLOBAL BANK',807,0,'S','MET1')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,23,'COLON','CRISTOBAL, CALLE 13, EDIF. 1108, LOCAL N°2',302,0,'S','MET2')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,24,'PARQUE PORRAS','AVE. JUSTO AROSEMENA, CALLE 34 BELLAVISTA, EDIF. VICTORIA',807,0,'S','MET1')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,25,'ALBROOK','BALBOA,ANCON, CALLE PEARSON, EDIF. 2362, DETRAS DEL 24 HORAS EN LAS ENTRADA DE AMADOR',807,0,'S','MET1')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,26,'LOS ANDES','CENTRO COMERCIAL LOS ANDES, MILLA7, TRANSISTMICA',807,0,'S','MET2')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,27,'PARQUE LEFEVRE','PARQUE LEFEVRE, CALLE NOVENA',807,0,'S','MET2')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,28,'BETHANIA','CALLE CAMINO REAL, AL LADO DEL SUPER 99',807,0,'S','MET1')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,29,'CAMPO LIMBERG','VIA JOSE AGUSTIN ARANGO, AVE. DE LAS MERCEDES',807,0,'S','MET2')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,30,'SAN FRANCISCO','VIA PORRAS, SAN FRANCISCO',807,0,'S','MET1')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,40,'AVANCE GLOBAL','TORRE HSBC',808,0,'S','DGE')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,45,'BANCA CORPORATIVA','CALLE 50 Y 56, VICTORIANO LORENZO',807,0,'S','BCO')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,47,'FACTOR GLOBAL','CALLE 50 Y 56, VICTORIANO LORENZO',807,0,'S','DGE')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,48,'CAJA CENTRO DE COBROS','EDIFICIO CENTRO DE DATOS',808,0,'S','DGE')
insert into cl_sucursal(filial,sucursal,nombre,direccion,ciudad,telefono,subtipo,area)values(1,50,'BANCA PRIVADA','CALLE 50, EDIF. TORRE GLOBAL BANK',807,0,'S','BPR')
go


declare @w_siguiente int
select @w_siguiente = max(of_oficina) + 1 from cl_oficina

update	cl_seqnos
set	siguiente = @w_siguiente
where	tabla = 'cl_oficina'
go


/************************************************************************/
print 'cl_departamento'
/************************************************************************/
go
truncate table cl_departamento
go

insert into cl_departamento	(de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel)
			values	(0, 1, 1, 'No existe departamento', null, 0)
insert into cl_departamento	(de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel)
			values	(1, 1, 1, 'COBIS', 0, 0)
go 

declare @w_siguiente int
select @w_siguiente = max(de_departamento) + 1 from cl_departamento

update	cl_seqnos
set	siguiente = @w_siguiente
where	tabla = 'cl_departamento'
go


/************************************************************************/
print 'cl_dis_seqnos'
/************************************************************************/
go
truncate table cl_dis_seqnos
go
insert into cl_dis_seqnos (dq_oficina,dq_departamento, dq_cargo, dq_siguiente) values (1,1, 1, 3)
go

/************************************************************************/
print 'cl_distributivo'
/************************************************************************/
go
truncate table cl_distributivo
go
insert into cl_distributivo	(ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
		values		(1, 1, 1, 1, 1, getdate(), 'V', 1, 'S')
insert into cl_distributivo	(ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
		values		(1, 1, 1, 1, 2, getdate(), 'V', 1, 'S')
insert into cl_distributivo	(ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
		values		(1, 1, 1, 1, 3, getdate(), 'V', 1, 'S')
go


/************************************************************************/
print 'cl_funcionario'
/************************************************************************/
go
truncate table cl_funcionario
go
insert into cl_funcionario	(fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_oficina, fu_departamento, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave)
		values		(0, 'No existe funcionario', 'M', 'N', 1, 1, 1, 1, null, null, getdate(), ' ', null, null,'V', '')
insert into cl_funcionario	(fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_oficina, fu_departamento, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave)
		values		(1, 'sa', 'M', 'N', 1, 1, 1, 1, 0, null, getdate(), 'sa', null, null,'V', 'sybase11')
insert into cl_funcionario	(fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_oficina, fu_departamento, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave)
		values		(2, 'reentry', 'M', 'N', 1, 1, 1, 2, 0, null, getdate(), 'reentry', null, null,'V', 'reentry')
insert into cl_funcionario	(fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_oficina, fu_departamento, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave)
		values		(3, 'admuser', 'M', 'N', 1, 1, 1, 3, 0, null, getdate(), 'admuser', null, null,'V', 'Z~if701')
insert into cl_funcionario	(fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_oficina, fu_departamento, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave)
		values		(4, 'usuariobv', 'M', 'N', 1, 1, 1, 3, 0, null, getdate(), 'usuariobv', null, null,'V', 'usuariobv')

go

insert into  cc_oficial (oc_oficial, oc_funcionario, oc_ofi_nsuperior, oc_tipo_oficial, oc_sector)
						values (1, 1, 32001, '8', 'P')
go

declare @w_siguiente int
select @w_siguiente = max(fu_funcionario) + 1 from cl_funcionario

update	cl_seqnos
set	siguiente = @w_siguiente
where	tabla = 'cl_funcionario'
go

update	cl_distributivo
set	ds_vacante = 'N'
where	ds_oficina = 0
and	ds_departamento = 1
and	ds_cargo = 1
and    	ds_secuencial = 1

update	cl_distributivo
set	ds_vacante = 'N'
where	ds_oficina = 0
and	ds_departamento = 1
and	ds_cargo = 1
and    	ds_secuencial = 2

update	cl_distributivo
set	ds_vacante = 'N'
where	ds_oficina = 0
and	ds_departamento = 1
and	ds_cargo = 1
and    	ds_secuencial = 3
go

/************************************************************************/
print 'ad_sis_operativo'
/************************************************************************/
go
truncate table ad_sis_operativo
go

insert into ad_sis_operativo	(so_sis_operativo, so_descripcion, so_version, so_release, so_propietario, so_estado, so_fecha_ult_mod)
			values	(1,'AIX', '5.2','1','COBIS','V',getdate())
insert into ad_sis_operativo	(so_sis_operativo, so_descripcion, so_version, so_release, so_propietario, so_estado, so_fecha_ult_mod)
			values	(2,'WINDOWS','98','1','COBIS','V',getdate())
insert into ad_sis_operativo	(so_sis_operativo, so_descripcion, so_version, so_release, so_propietario, so_estado, so_fecha_ult_mod)
			values	(3,'WINDOWS  2000','Proffesional','1','COBIS','V',getdate())
insert into ad_sis_operativo	(so_sis_operativo, so_descripcion, so_version, so_release, so_propietario, so_estado, so_fecha_ult_mod)
			values	(4,'WINDOWS  2000','Server','1','COBIS','V',getdate())
insert into ad_sis_operativo	(so_sis_operativo, so_descripcion, so_version, so_release, so_propietario, so_estado, so_fecha_ult_mod)
			values	(5,'WINDOWS  XP','Proffesional','1','COBIS','V',getdate())
insert into ad_sis_operativo	(so_sis_operativo, so_descripcion, so_version, so_release, so_propietario, so_estado,so_fecha_ult_mod)
			values	(6,'WINDOWS  2003','Server','1','COBIS','V',getdate())
insert into ad_sis_operativo	(so_sis_operativo, so_descripcion, so_version, so_release, so_propietario, so_estado, so_fecha_ult_mod)
			values	(7,'WINDOWS  NT 4.0','Server','1','COBIS','V',getdate())
insert into ad_sis_operativo	(so_sis_operativo, so_descripcion, so_version, so_release, so_propietario, so_estado, so_fecha_ult_mod)
			values	(8,'WINDOWS  NT 4.0','Workstation','1','COBIS','V',getdate())
insert into ad_sis_operativo	(so_sis_operativo, so_descripcion, so_version, so_release, so_propietario, so_estado, so_fecha_ult_mod)
			values	(9,'LINUX','7.0','1','COBIS','V',getdate())
go


declare @w_siguiente int
select @w_siguiente = max(so_sis_operativo) + 1 from ad_sis_operativo

update	cl_seqnos
set	siguiente = @w_siguiente
where	tabla = 'ad_sis_operativo'
go


/************************************************************************/
print 'ad_nodo'
/************************************************************************/
go
truncate table ad_nodo
go
insert into ad_nodo	(no_nodo, no_marca, no_modelo, no_tipo, no_num_serie, no_fecha_reg, no_fecha_habil, no_registrador, no_habilitante, no_estado, no_fecha_ult_mod)
		values	(1, 'IBM', 'REGATA', 'ARMRI', '1111111', getdate(), getdate(), 1, 1, 'V', getdate())
go

declare @w_siguiente int
select @w_siguiente = max(no_nodo) + 1 from ad_nodo

update	cl_seqnos
set	siguiente = @w_siguiente
where	tabla = 'ad_nodo'
go


/************************************************************************/
print 'ad_usuario'
/************************************************************************/
go
truncate table ad_usuario
go
insert into ad_usuario	(us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_estado, us_fecha_ult_mod, us_fecha_ult_pwd)
		values	(1, 1, 1, 'sa', getdate(), 1, 'V', getdate(), getdate())
insert into ad_usuario	(us_filial, us_oficina, us_nodo, us_login,  us_fecha_asig, us_creador, us_estado, us_fecha_ult_mod, us_fecha_ult_pwd)
		values	(1, 1, 1, 'reentry', getdate(), 1, 'V', getdate(), getdate())
insert into ad_usuario	(us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_estado, us_fecha_ult_mod, us_fecha_ult_pwd)
		values	(1, 1, 1, 'admuser', getdate(), 1, 'V', getdate(), getdate())
go

/************************************************************************/
print 'ad_rol '
/************************************************************************/
go
truncate table ad_rol
go
insert into ad_rol	(ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
		values	(1, 1, 'ADMINISTRADOR', getdate(), 1, 'V', getdate(),900)
insert into ad_rol	(ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
		values	(2, 1, 'OPERADOR DE BATCH COBIS', getdate(), 1, 'V', getdate(),900)
insert into ad_rol	(ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
		values	(3, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(),900)
go

declare @w_siguiente int
select @w_siguiente = max(ro_rol) + 1 from ad_rol

update	cl_seqnos
set	siguiente = @w_siguiente
where	tabla = 'ad_rol'
go


/************************************************************************/
print 'ad_tipo_horario'
/************************************************************************/
go
truncate table ad_tipo_horario
go
insert into ad_tipo_horario	(th_tipo, th_descripcion, th_ult_secuencial, th_fecha_ult_mod, th_creador, th_estado)
			values	(1, 'HORARIO COBIS', 0, getdate(), 1, 'V')
go

declare @w_siguiente int
select @w_siguiente = max(th_tipo) + 1 from ad_tipo_horario

update	cl_seqnos
set	siguiente = @w_siguiente
where	tabla = 'ad_tipo_horario'
go


/************************************************************************/
print 'ad_horario'
/************************************************************************/
go
truncate table ad_horario
go

insert into ad_horario	(ho_tipo_horario, ho_secuencial, ho_dia, ho_hr_inicio, ho_hr_fin, ho_fecha_crea, ho_creador, ho_estado, ho_fecha_ult_mod)
		values	(1, 1, '2', '0:00', '23:59', getdate(), 1, 'V', getdate())
insert into ad_horario	(ho_tipo_horario, ho_secuencial, ho_dia, ho_hr_inicio, ho_hr_fin, ho_fecha_crea, ho_creador, ho_estado, ho_fecha_ult_mod)
		values	(1, 2, '3', '0:00', '23:59', getdate(), 1, 'V', getdate())
insert into ad_horario	(ho_tipo_horario, ho_secuencial, ho_dia, ho_hr_inicio, ho_hr_fin, ho_fecha_crea, ho_creador, ho_estado, ho_fecha_ult_mod)
		values	(1, 3, '4', '0:00', '23:59', getdate(), 1, 'V', getdate())
insert into ad_horario	(ho_tipo_horario, ho_secuencial, ho_dia, ho_hr_inicio, ho_hr_fin, ho_fecha_crea, ho_creador, ho_estado, ho_fecha_ult_mod)
		values	(1, 4, '5', '0:00', '23:59', getdate(), 1, 'V', getdate())
insert into ad_horario	(ho_tipo_horario, ho_secuencial, ho_dia, ho_hr_inicio, ho_hr_fin, ho_fecha_crea, ho_creador, ho_estado, ho_fecha_ult_mod)
		values	(1, 5, '6', '0:00', '23:59', getdate(), 1, 'V', getdate())
insert into ad_horario	(ho_tipo_horario, ho_secuencial, ho_dia, ho_hr_inicio, ho_hr_fin, ho_fecha_crea, ho_creador, ho_estado, ho_fecha_ult_mod)
		values	(1, 6, '7', '0:00', '23:59', getdate(), 1, 'V', getdate())
insert into ad_horario	(ho_tipo_horario, ho_secuencial, ho_dia, ho_hr_inicio, ho_hr_fin, ho_fecha_crea, ho_creador, ho_estado, ho_fecha_ult_mod)
		values	(1, 7, '1', '0:00', '23:59', getdate(), 1, 'V', getdate())
go

update	ad_tipo_horario
set	th_ult_secuencial = 7
where 	th_tipo = 1
go

/************************************************************************/
print 'ad_usuario_rol'
/************************************************************************/
go
truncate table ad_usuario_rol
go
insert into ad_usuario_rol	(ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado, ur_fecha_ult_mod,ur_tipo_horario)
			values	('sa', 1, getdate(), 1, 'V', getdate(),1)
insert into ad_usuario_rol	(ur_login, ur_rol, ur_fecha_aut,ur_autorizante, ur_estado, ur_fecha_ult_mod,ur_tipo_horario)
			values	('reentry', 1, getdate(),1, 'V', getdate(),1)
insert into ad_usuario_rol	(ur_login, ur_rol, ur_fecha_aut,ur_autorizante, ur_estado, ur_fecha_ult_mod,ur_tipo_horario)
			values	('admuser', 1, getdate(),1, 'V', getdate(),1)
go


/************************************************************************/
print 'cl_producto'
/************************************************************************/
go
if exists (select * from cl_producto where pd_producto = 1)
	delete	cl_producto where pd_producto = 1
go
insert into cl_producto	(pd_producto, pd_tipo, pd_descripcion, pd_abreviatura, pd_fecha_apertura, pd_estado, pd_saldo_minimo, pd_costo)
		values	(1, 'R', 'ADMINISTRACION', 'ADM', getdate(), 'V', null, null)
go

declare @w_siguiente int
select @w_siguiente = max(pd_producto) + 1 from cl_producto

update	cl_seqnos
set	siguiente = @w_siguiente
where	tabla = 'cl_producto'
go

/************************************************************************/
print 'ad_pro_rol'
/************************************************************************/
go
if exists (select * from ad_pro_rol where pr_producto in (1, 3))
	delete ad_pro_rol where pr_producto in (1, 3)
go

declare @w_moneda int
select @w_moneda = pa_tinyint
from cl_parametro
where pa_nemonico = 'MLO' and pa_producto = 'ADM'


insert into ad_pro_rol	(pr_rol ,pr_producto, pr_tipo, pr_moneda, pr_fecha_crea, pr_autorizante, pr_estado, pr_fecha_ult_mod, pr_menu_inicial)
		values	(1, 1, 'R', @w_moneda, getdate(), 1, 'V', getdate(), null)
insert into ad_pro_rol	(pr_rol ,pr_producto, pr_tipo, pr_moneda, pr_fecha_crea, pr_autorizante, pr_estado, pr_fecha_ult_mod, pr_menu_inicial)
		values	(3, 1, 'R', @w_moneda, getdate(), 1, 'V', getdate(), null)
go

/************************************************************************/
print 'cl_pro_moneda'
/************************************************************************/
go
if exists (select * from cl_pro_moneda where pm_producto = 1)
	delete cl_pro_moneda where pm_producto = 1
go

declare @w_moneda int
select @w_moneda = pa_tinyint
from cl_parametro
where pa_nemonico = 'MLO' and pa_producto = 'ADM'

insert into cl_pro_moneda (pm_producto, pm_tipo, pm_moneda, pm_descripcion, pm_fecha_aper, pm_estado)
		values	(1, 'R',@w_moneda, 'ADMINISTRACION', getdate(), 'V')
go


/************************************************************************/
print 'cl_catalogo_pro'
/************************************************************************/
go
if exists (select * from cl_catalogo_pro where cp_producto = 'ADM')
	delete cl_catalogo_pro where cp_producto = 'ADM'
go

declare @w_codigo int
select @w_codigo = codigo from cl_tabla where tabla = 'cl_actividad'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_cargo'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_sexo'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'ad_dia_semana'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_continente'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_estado_ser'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_filial'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_oficina' 
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_moneda' 
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_zona' 
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_producto'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('TES', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_pais'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_provincia'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_ciudad'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_parroquia'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_tparroquia'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_tproducto'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_sector'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_region_nat'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_region_ope'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_suc_correo'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cc_tipo_oficial'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'ad_protocolo'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cc_sector'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_tipo_ejecucion'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_tipo_medio'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'te_periodos'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'te_tipo_servicio'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'te_mercado'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'aw_prerequisitos'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)
 
select @w_codigo = codigo from cl_tabla where tabla = 'aw_idioma'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'ta_tipo'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_area_oficina'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'ad_tipo_tran'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_barrio'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'ad_windows_authentication_user'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_nombre_banco'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_producproc'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

--select @w_codigo = codigo from cl_tabla where tabla = 'cl_depart_pais'
--insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

--select @w_codigo = codigo from cl_tabla where tabla = 'cl_municip_seccion'
--insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_tipo_horario'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_sector_geografico'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_regional'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'cl_tipo_punto_at'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

--select @w_codigo = codigo from cl_tabla where tabla = 'cl_canton'
--insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

--select @w_codigo = codigo from cl_tabla where tabla = 'cl_estado_ambito'
--insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)

select @w_codigo = codigo from cl_tabla where tabla = 'te_grupos_tasas'
insert into cl_catalogo_pro	(cp_producto, cp_tabla) values	('ADM', @w_codigo)
go

/************************************************************************/
print 'ad_base_datos'
/************************************************************************/
go

truncate table ad_base_datos
go

insert into ad_base_datos (bd_filial, bd_oficina, bd_nodo, bd_base,  bd_tamanio, bd_fecha_reg, bd_registrador, bd_estado, bd_fecha_ult_mod)
			values	(1, 1, 1, 'cobis', 15, getdate(), 1,  'V', getdate())
go

/************************************************************************/
print 'cl_pro_oficina'
/************************************************************************/
go

truncate table cl_pro_oficina
go
declare @w_moneda int
select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLO' and pa_producto = 'ADM'

insert into cl_pro_oficina (pl_filial, pl_oficina, pl_producto,pl_tipo, pl_moneda, pl_monto, pl_fecha_aper, pl_secuencial)
		    values (1, 1, 1, 'R', @w_moneda, NULL, getdate(), 1)  
go

update	cl_seqnos
set	siguiente = 1
where	tabla = 'cl_pro_oficina'
go

/************************************************************************/
print 'ad_server_logico'
/************************************************************************/
go

truncate table ad_server_logico
go

declare @w_moneda int
select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLO' and pa_producto = 'ADM'



insert into ad_server_logico (sg_filial_i, sg_oficina_i, sg_nodo_i, sg_filial_p, sg_oficina_p, sg_producto, sg_tipo, sg_moneda, sg_fecha_reg, sg_registrador, sg_estado, sg_fecha_ult_mod)
		    values (1, 1, 1, 1, 1, 1, 'R', @w_moneda, getdate(), 1, 'V', getdate())  
go

/************************************************************************/
print 'ad_pro_instalado'
/************************************************************************/
go

truncate table ad_pro_instalado
go

insert into ad_pro_instalado	(pi_producto, pi_bdd, pi_transaccion, pi_uso_firmas) values	('ADM', 'cobis', NULL, 'N')  
go


/************************************************************************/
print 'ad_protocolo'
/************************************************************************/
go

truncate table ad_protocolo
go

insert into ad_protocolo (pr_protocolo, pr_descripcion, pr_estado, pr_fecha_ult_mod)
			values	('T', 'TCP/IP', 'V', getdate())  
go


/************************************************************************/
print 'cc_oficial'
/************************************************************************/
go
/* COMENTADO FALABELLA
truncate table cc_oficial
go

insert into cc_oficial values(0,0,'A','0',null,null,'01')
go
*/
/*********************************************************************/
print 'te_tasas_referenciales'
/*********************************************************************/
go

truncate table te_tasas_referenciales
go
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TPPZ','TASA PROM. POLIZAS DE ACUMUL. DE 90-179 DIAS','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TPPR','TASA PROMEDIO PRIME','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('V091','VENC. DE BONOS DE ESTABIL. 91 DIAS','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('V119','VENC. DE BONOS DE ESTABIL. 119 DIAS','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('V182','VENC. DE BONOS DE ESTABIL. 182 DIAS','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('V273','VENC. DE BONOS DE ESTABIL. 273 DIAS','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('V357','VENC. DE BONOS DE ESTABIL. 357 DIAS','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TPRI','TASA PRIME','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TPSU','TASA POOL EN SUCRES','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TPUS','TASA POOL EN DOLARES','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TPUV','TASA POOL EN UVC','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TL30','TASA LIBOR A 30 DIAS','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TL60','TASA LIBOR A 60 DIAS','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TL90','TASA LIBOR A 90 DIAS','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TL18','TASA LIBOR A 180 DIAS','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TL36','TASA LIBOR A 360 DIAS','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TBAS','BASICA DEL BANCO CENTRAL','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TPBS','PASIVA REFERENCIA PARA OPER. EN SUCRES','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TABS','ACTIVA REFERENCIA PARA OPER. EN SUCRES','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TPBU','PASIVA REFERENCIA PARA OPER. EN UVC','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TABU','ACTIVA REFERENCIA PARA OPER. EN UVC','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TPBD','PASIVA REFERENCIA PARA OPER. EN DOLARES','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TABD','ACTIVA REFERENCIA PARA OPER. EN DOLARES','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TPRO','PASIVA REFERENCIA OTRAS MONEDAS','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TARO','ACTIVA REFERENCIA OTRAS MONEDAS','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TLE','LEGAL','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TMC','MAXIMA CONVENCIONAL','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('M091','MONTO OFERTADO 91-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('D091','MONTO DEMANDADO 91-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('A091','MONTO ADJUDICADO 91-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('P091','PRECIO PROM. PONDERADO 91-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('T091','TASA NOMI. PONDERADA 91-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('E091','TASA EFEC. PONDERADA 91-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('N091','PRECIO MIN. COMPETITIVAS 91-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('C091','PRECIO PROM.NO COMPETI. 91-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('M119','MONTO OFERTADO 119-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('D119','MONTO DEMANDADO 119-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('A119','MONTO ADJUDICADO 119-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('P119','PRECIO PROM. PONDERADO 119-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('T119','TASA NOMI. PONDERADA 119-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('E119','TASA EFEC. PONDERADA 119-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('N119','PRECIO MIN. COMPETITIVAS 119-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('C119','PRECIO PROM. NO COMPETI. 119-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('M182','MONTO OFERTADO 182-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('D182','MONTO DEMANDADO 182-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('A182','MONTO ADJUDICADO 182-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('P182','PRECIO PROM. PONDERADO 182-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('T182','TASA NOMI. PONDERADA 182-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('E182','TASA EFEC. PONDERADA 182-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('N182','PRECIO MIN. COMPETITIVAS 182-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('C182','PRECIO PROM. NO COMPETI. 182-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('M273','MONTO OFERTADO 273-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('D273','MONTO DEMANDADO 273-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('A273','MONTO ADJUDICADO 273-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('P273','PRECIO PROM. PONDERADO 273-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('T273','TASA NOMI. PONDERADA 273-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('E273','TASA EFEC. PONDERADA 273-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('N273','PRECIO MIN. COMPETITIVAS 273-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('C273','PRECIO PROM. NO COMPETI. 273-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('M357','MONTO OFERTADO 357-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('D357','MONTO DEMANDADO 357-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('A357','MONTO ADJUDICADO 357-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('P357','PRECIO PROM. PONDERADO 357-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('T357','TASA NOMI. PONDERADA 357-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('E357','TASA EFEC. PONDERADA 357-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('N357','PRECIO MIN. COMPETITIVAS 357-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('C357','PRECIO PROM. NO COMPETI. 357-BONOS DE ESTABIL.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TTND','TASA CFN TRIMESTRAL NOMI. DOLARES','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TSND','TASA CFN SEMESTRAL NOMINAL DOLARES','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TTNS','TASA CFN TRIMESTRAL NOMINAL SUCRES','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TSNS','TASA CFN SEMESTRAL NOMINAL SUCRES','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TN1','T.NOM. OPER.PASIVAS PARA BCOS PRIV.1 DIA','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TN30','T.NOM. OPER. PASIVAS PARA BCOS PRIV.A 30','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TN60','T.NOM. OPER. PASIVAS PARA BCOS PRIV.A 60','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TN90','T.NOM. OPER. PASIVAS PARA BCOS PRIV.A 90','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TN18','T.NOM. OPER. PASIVAS PARA BCOS PRIV.A 180','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TN36','T.NOM. OPER. PASIVAS PARA BCOS PRIV.A 360','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TNA1','T.NOM. OPER. ACTIVAS  PARA BCOS PRIV.1 DIA','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('DCPD','DOLAR INTERCAMBIARIO COMPRA PROMEDIO DEL DIA','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('DCA','DOLAR INTERCAMBIARIO COMPRA APERTURA','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('DCC','DOLAR INTERCAMBIARIO COMPRA CIERRE','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('DCMA','DOLAR INTERCAMBIARIO COMPRA COTIZACION MAX.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('DCMI','DOLAR INTERCAMBIARIO COMPRA COTIZACION MIN.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('DVPD','DOLAR INTERCAMBIARIO VENTA PROM. DEL DIA','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('DVA','DOLAR INTERCAMBIARIO VENTA APERTURA','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('DVC','DOLAR INTERCAMBIARIO VENTA CIERRE','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('DVMA','DOLAR INTERCAMBIARIO VENTA COTIZACION MAX.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('DVMI','DOLAR INTERCAMBIARIO VENTA COTIZACION MIN.','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TF15','TASA FOPINAR MAYOR A 30,000,000.00','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('F-15','TASA FOPINAR MENOR A 30,000,000.00','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('RUVC','VALOR DIARIO DEL UVC','V')
insert into te_tasas_referenciales (tr_tasa, tr_descripcion, tr_estado) values('TRBC','TASA REVALUACION BANCO CENTRAL','V')
go

/************************************************************************/
print 'cl_depart_pais'
/************************************************************************/
go
truncate table cl_depart_pais
go

/************************************************************************/
print 'cl_municipio'
/************************************************************************/
go
truncate table cl_municipio
go


 