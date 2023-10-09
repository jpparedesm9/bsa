/*************************************************************************/
/*   Archivo:              sp_reporte_clientes_consultados.sp            */
/*   Stored procedure:     sp_reporte_clientes_consultados.sp            */
/*   Base de datos:        cobis		                               	 */
/*   Producto:             clientes                                  	 */
/*   Disenado por:         jlsdv                                         */
/*   Fecha de escritura:   Febrero 2019                                  */
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
/*   					Reporte de clientes consultados       		     */
/*                              CAMBIOS                                  */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA          AUTOR                       RAZON                   */
/*    05/Feb/2019    Jose Sánchez    Emision inicial                     */
/*    12/Mar/2019    Jose Sánchez    Creacion tabla fisica               */
/*    05/May/2019    ACH             Se aumenta condicion                */
/*                                   para nivel de riesgo                */
/*    10/May/2019    ACH             Se quita dobles y triples espacios  */
/*                                   en sel                              */
/*    08/Ago/2019    ACH             join cl_ente, interface_buro        */
/*    03/Oct/2019    SRO             Historicos Buro                     */
/*    02/Jun/2021    ACH             Caso#159312-usuario consulta        */
/*    07/Jun/2022    DCU             Caso#187215 - Tipo dato             */
/*************************************************************************/
use cobis
go

if exists(select 1 from sysobjects where name = 'sp_reporte_clientes_consultados')
    drop proc sp_reporte_clientes_consultados
go

create proc sp_reporte_clientes_consultados 
(
	@i_param1  DATETIME
)
AS

DECLARE
@w_sp_name          VARCHAR(64),
@w_msg              VARCHAR(255),
@w_fecha_desde      DATETIME,
@w_fecha_hasta      DATETIME,
@w_sep              CHAR(1)

DECLARE
@w_return            INT,
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
@w_anio              varchar(4)

SELECT @w_sp_name       = 'sp_reporte_clientes_consultados',
       @w_fecha_proceso = @i_param1

SELECT @w_sep = '|'

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

select @w_path_destino = pp_path_destino
from   cobis..ba_path_pro
where  pp_producto = 2 -- CLIENTES

/* DETERMINAR PRIMER DIA DE LA SEMANA PASADA */
select @w_fecha_desde = dateadd(wk,datediff(wk,7, @w_fecha_proceso),0)

/* DETERMINAR ULTIMO DIA DE LA SEMANA PASADA */
select @w_fecha_hasta = dateadd(wk,datediff(wk,7, @w_fecha_proceso),6)
select @w_fecha_hasta = convert(datetime, @w_fecha_hasta + ' 23:59:59')

/* DETERMINAR SI SE EJECUTA O NO EL REPORTE */

select @w_mes         = substring(convert(varchar,@w_fecha_proceso, 101),1,2)
select @w_dia         = substring(convert(varchar,@w_fecha_proceso, 101),4,2)
select @w_anio        = substring(convert(varchar,@w_fecha_proceso, 101),7,4)

--select @w_fecha_r = @w_dia + '_' + @w_mes + '_' + @w_anio
select @w_fecha_r = @w_anio + @w_mes + @w_dia 

select @w_file_rpt = 'REPORTE_CLIENTES'
select @w_file_rpt_1     = @w_path_destino + @w_file_rpt + '_' + @w_fecha_r + '.txt'
select @w_file_rpt_1_out = @w_path_destino + @w_file_rpt + '_' + @w_fecha_r + '.err'

-------------------------------------------
/* Reporte de clientes consultados */

-- Datos temporales de la consulta a buro 
IF OBJECT_ID('tempdb..#clientes_consultados_buro') 
	IS NOT NULL DROP TABLE #clientes_consultados_buro

-- Datos temporales de la tabla direcciones 
IF OBJECT_ID('tempdb..#direcciones') 
	IS NOT NULL DROP TABLE #direcciones

-- Datos temporales de la tabla negocio
IF OBJECT_ID('tempdb..#negocio') 
	IS NOT NULL DROP TABLE #negocio

/* Tabla temporal de trabajo para el reporte de clientes consultados a buro */	
select
ccb_region						= convert(varchar(64),null), -- Región de la oficina del  cliente 
ccb_oficina						= convert(varchar(64),null), -- Oficina del cliente
ccb_cc							= en_oficina, -- Centro de Costo de la Oficina del cliente
ccb_id_gerente					= convert(smallint, null), -- id del gerente
ccb_gerente						= convert(varchar(64),null), -- Nombre completo del gerente de la oficina del cliente
ccb_id_coordinador				= convert(smallint, null), -- id del corrdinador
ccb_coordinador					= convert(varchar(64),null),  -- Nombre completo del coordinador de la oficina del cliente
ccb_id_oficial					= en_oficial, -- 
ccb_asesor						= convert(varchar(64),null), -- Nombre completo del asesor
ccb_email_asesor				= convert(varchar(64),null), -- Email asesor actual del cliente 
ccb_telefono_asesor				= convert(varchar(16),null), -- Número de celular del asesor
ccb_estatus_asesor				= convert(varchar(64),null), -- Estado del funcionario Asesor
ccb_cliente_cobis				= en_ente, -- Código del Cliente
ccb_id_buc						= en_banco, -- Código del Cliente en Santander (BUC)
ccb_fecha_registro				= convert(varchar(20),en_fecha_crea,103), -- Fecha de captura del prospecto  
ccb_fecha_consulta_buro			= convert(varchar(30),null), -- Fecha última consulta al Buró
ccb_folio_consulta_buro			= convert(varchar(30),null), -- Folio de consulta buró
ccb_app_paterno					= upper(isnull(p_p_apellido,null)), -- Apellido Paterno del cliente
ccb_app_materno					= upper(isnull(p_s_apellido,null)), -- Apellido Materno del cliente
ccb_nombre1						= upper(isnull(en_nombre,null)), -- Primer Nombre
ccb_nombre2						= upper(isnull(p_s_nombre,null)), -- Segundo Nombre
ccb_entidad_nac					= convert(varchar(64),p_depa_nac), -- Entidad de nacimiento
ccb_estado_civil				= convert(varchar(64),p_estado_civil), -- Estado Civil
ccb_fecha_nacimiento			= convert(varchar,p_fecha_nac,103), -- Fecha de nacimiento (dd/mm/aaaa)
ccb_edad						= datediff(year, p_fecha_nac, getdate()), -- Edad en años
ccb_email_cliente				= convert(varchar(64),null), -- Email del cliente
ccb_calle						= convert(varchar(255),null), -- Calle de la dirección del Cliente
ccb_numero						= convert(int,0), -- Número externo de la dirección del Cliente
ccb_numero_interior				= convert(int,0), -- Número interno de la dirección del Cliente
ccb_colonia						= convert(varchar(64),null), -- Colonia de la dirección del cliente
ccb_codigo_postal				= convert(int,0), -- Código postal de la dirección del cliente
ccb_ciudad						= convert(varchar(64),null), -- Ciudad de la dirección del cliente, campo texto
ccb_estado						= convert(varchar(64),null), -- Estado de la dirección del cliente
ccb_municipio					= convert(varchar(64),null), -- Municipio de la dirección del cliente
ccb_dom_telefono				= convert(varchar(16),null), -- Teléfono tipo domicilio del cliente
ccb_dom_celular					= convert(varchar(16),null), -- Teléfono tipo celular del cliente
ccb_dom_actual_anios			= convert(int,0), -- Años de domicilio actual
ccb_dom_tipo_vivienda			= convert(varchar(64),null), -- Tipo de vivienda
ccb_dom_personas_viviendo		= convert(int,0), -- Número de personas viviendo en domicilio
ccb_pais_nacimiento				= convert(varchar(64),p_pais_emi), --  País nacimiento del Cliente
ccb_genero						= convert(varchar(64),p_sexo), -- Género del Cliente
ccb_nacionalidad				= convert(varchar(64),en_nacionalidad), -- Nacionalidad del Cliente
ccb_escolaridad					= convert(varchar(64),p_nivel_estudio), -- Nivel de Estudios del Cliente
ccb_ocupacion					= convert(varchar(64),p_profesion), -- Ocupación del Cliente
ccb_rfc							= en_rfc, -- RFC del Cliente
ccb_curp						= en_ced_ruc, -- CURP del Cliente
ccb_dg_dependientes_economicos	= convert(tinyint,p_num_cargas), -- Dependientes del cliente
ccb_dg_otros_ingresos			= case when en_ing_SN = 'S' then 'SI' else 'NO' end, -- SI/NO
ccb_dg_ciclos_en_otras_inst		= convert(int,0), -- Ciclos en otras instituciones 
ccb_dg_pep						= convert(varchar(2),case when en_persona_pep = 'S' then 'SI' else 'NO' end), -- SI/NO
ccb_dg_cuenta_ahorro			= convert(varchar(30),null), --  Cuenta del cliente en Santander
ccb_dn_nombre_negocio			= convert(varchar(64),null), -- Nombre de negocio del cliente
ccb_dn_destino_credito			= convert(varchar(64),null), -- Destino del crédito en Negocio del cliente
ccb_dn_tipo_local				= convert(varchar(64),null), -- Tipo de Local del negocio
ccb_dn_calle					= convert(varchar(255),null), -- Calle de la dirección del negocio
ccb_dn_numero					= convert(int,0), -- Número interno de la dirección del negocio				
ccb_dn_numero_interior			= convert(int,0), -- Número externo de la dirección del negocio
ccb_dn_colonia					= convert(varchar(64),null), -- Colonia de la dirección del negocio
ccb_dn_codigo_postal			= convert(int,0), -- Código postal de la dirección del negocio
ccb_dn_ciudad					= convert(varchar(64),null), -- Ciudad de la dirección del negocio 
ccb_dn_telefono					= convert(varchar(16),null), -- Teléfono del Negocio del cliente
ccb_dn_cve_act_economica		= convert(varchar(20),null), -- Código de la Actividad Económica
ccb_dn_nombre_corto_act			= convert(varchar(64),null), --  Nombre corto Actividad Económica
ccb_dn_tiempo_des_act			= convert(int,0), -- Tiempo desempeñando Actividad del negocio
ccb_dn_tiempo_arrigo			= convert(int,0), -- Tiempo arraigo del negocio
ccb_dn_fecha_apertura			= convert(varchar(20),null), --  Fecha apertura del negocio
ccb_dn_recursos					= convert(varchar(20),null), --  Con qué Recursos pagará el Crédito?
ccb_dn_ingresos_del_negocio		= convert(money,0), -- Ingresos mensuales del Negocio 
ccb_ingreso_mensual				= isnull(en_otros_ingresos,0), -- Ingresos mensuales 
ccb_gastos_mensuales_negocio	= convert(money, 0), -- Gastos Negocio
ccb_gastos_mensuales_familiares = convert(money, 0), -- Gastos Familiares 
ccb_otros_ingresos				= convert(money, 0), -- Monto otros ingresos 
ccb_capacidad_de_pago			= convert(money, 0), -- Capacidad de pago 
ccb_experiencia_crediticia		= convert(char(2),null), -- Con experiencia Crediticia? 
ccb_numero_ine					= convert(varchar(20),null),-- Número de INE 
ccb_pasaporte					= p_pasaporte, -- Número de Pasaporte 
ccb_telefono_recados			= convert(varchar(20),null), -- Teléfono Recados 
ccb_persona_recados				= convert(varchar(64),null), -- Persona recados 
ccb_antecedentes_buro			= convert(varchar(2),null), -- SI/NO 
ccb_calificacion_matriz_pld     = convert(varchar(50),null), -- Calificación matriz
--ccb_riesgo_individual			= convert(varchar(2),null), -- Calificación Riesgo Individual Externo
ccb_clave_respuesta_informe     = convert(varchar(64), concat('INTF13',concat(replicate(' ',25),concat('MX',concat(replicate('0', 4),'BY89250001') ) ) ) ), -- FALTA
ccb_exp_crediticia_comprobada   = convert(varchar(2),null), -- INTF13(25blancos)MX0000BY89250001C(1blanco) Para la C, si el cliente existe en la tabla cob_credito..cr_buro_cuenta colocar 1, caso contrario colocar 0.
ccb_tiene_credito               = convert(varchar(2),null), -- Tiene o no un crédito (vigente o cancelado) 
ccb_motivo_rechazo				= convert(varchar(20),null), -- B –Por buró de crédito -	LN – Listas negras-	NF – Negative File-	PLD – Matriz de evaluación PLD   
ccb_usuario_consulta_buro   	= isnull(ib_usuario,'')
into #clientes_consultados_buro
from cobis..cl_ente, cob_credito..cr_interface_buro
where en_ente = ib_cliente
and   ib_fecha between @w_fecha_desde and @w_fecha_hasta
and   ib_estado = 'V'

create index idx1 on #clientes_consultados_buro(ccb_cliente_cobis)

-- Oficina 
update #clientes_consultados_buro
set ccb_oficina = upper(of_nombre)
from cobis..cl_oficina
where  of_oficina = ccb_cc

-- Regional
update #clientes_consultados_buro
set ccb_region = upper((select A.of_nombre
                  from cobis..cl_oficina A, cobis..cl_oficina B
                  where A.of_oficina = B.of_regional
                  and   B.of_oficina = R.ccb_cc))
from  #clientes_consultados_buro R

-- Asesor que realiza la consulta de buro
update  #clientes_consultados_buro set 
ccb_id_coordinador	= fu_jefe,
ccb_asesor			= upper(fu_nombre),
ccb_estatus_asesor	= (select upper(valor) from cobis..cl_catalogo c, cobis..cl_tabla t  where t.tabla  = 'cl_estado_ser' and  t.codigo = c.tabla  and  c.codigo = f.fu_estado),                         
ccb_email_asesor	= (select top 1 mf_descripcion from cobis..cl_medios_funcio   where mf_funcionario = f.fu_funcionario and   mf_tipo = 0),
ccb_telefono_asesor = (select top 1 mf_descripcion from cobis..cl_medios_funcio   where mf_funcionario = f.fu_funcionario and   mf_tipo = 3)
from cobis..cl_funcionario f
where fu_login = ccb_usuario_consulta_buro
and ltrim(rtrim(ccb_usuario_consulta_buro)) <> ''

-- Si no tiene un asesor que realiza la consulta de buro, toma el oficial del cliente
update  #clientes_consultados_buro set 
ccb_id_coordinador	= fu_jefe,
ccb_asesor			= upper(fu_nombre),
ccb_estatus_asesor	= (select upper(valor) from cobis..cl_catalogo c, cobis..cl_tabla t  where t.tabla  = 'cl_estado_ser' and  t.codigo = c.tabla  and  c.codigo = f.fu_estado),                         
ccb_email_asesor	= (select top 1 mf_descripcion from cobis..cl_medios_funcio   where mf_funcionario = f.fu_funcionario and   mf_tipo = 0),
ccb_telefono_asesor = (select top 1 mf_descripcion from cobis..cl_medios_funcio   where mf_funcionario = f.fu_funcionario and   mf_tipo = 3)
from cobis..cl_funcionario f
where fu_funcionario = ccb_id_oficial 
and ltrim(rtrim(ccb_usuario_consulta_buro)) = ''

-- Coordinador
update  #clientes_consultados_buro set 
ccb_id_gerente  = fu_jefe ,
ccb_coordinador = upper(fu_nombre)
from cobis..cl_funcionario 
where fu_funcionario = ccb_id_coordinador  

-- Gerente
update  #clientes_consultados_buro set 
ccb_gerente = upper(fu_nombre)
from cobis..cl_funcionario 
where fu_funcionario = ccb_id_gerente  

-- Folio del cliente de la interfaz buro y Fecha ultima consulta al Buro
update #clientes_consultados_buro set 
ccb_folio_consulta_buro = ib_folio,
ccb_fecha_consulta_buro = convert(varchar(20),ib_fecha,103)
from cob_credito..cr_interface_buro 
where ib_cliente = ccb_cliente_cobis
and   ib_estado  = 'V'

-- Generar clave informe buro
update #clientes_consultados_buro set
ccb_clave_respuesta_informe = concat(ccb_clave_respuesta_informe,concat(case when ccb_fecha_consulta_buro is null then '0' else '1' end, replicate(' ',1) ) )

--- Direcciones
select distinct
di_cliente           = ccb_cliente_cobis,
di_dom_cod_tel       = convert(int,0),
di_dom_telefono      = convert(varchar(16),NULL),
di_dom_celular		 = convert(varchar(16),NULL),
di_dom_cod_dir       = convert(int,0),
di_dom_direccion     = convert(varchar(254),NULL),
di_dom_nro			 = convert(int,0),
di_dom_nro_interno   = convert(int,0),
di_dom_nro_residente = convert(int,0),
di_dom_tiempo_reside = convert(int,0), 
di_dom_cod_depar     = convert(int,-999),
di_dom_depar         = convert(varchar(64),NULL),
di_dom_cod_ciu       = convert(int,0),
di_dom_ciudad        = convert(varchar(64),NULL),
di_dom_cod_bar       = convert(int,0),
di_dom_barrio        = convert(varchar(64),NULL),
di_dom_cp            = convert(int,0),
di_dom_tipo_pro      = convert(varchar(64),NULL),
di_correo            = convert(varchar(255),NULL),
di_neg_telefono      = convert(varchar(16),NULL),
di_neg_cod_dir       = convert(int,0),
di_neg_direccion     = convert(varchar(254),NULL),
di_neg_nro			 = convert(int,0),
di_neg_nro_interno   = convert(int,0),
di_neg_cod_depar     = convert(int,-999),
di_neg_depar         = convert(varchar(64),NULL),
di_neg_cod_ciu       = convert(int,0),
di_neg_ciudad        = convert(varchar(64),NULL),
di_neg_cod_bar       = convert(int,0),
di_neg_barrio        = convert(varchar(64),NULL),
di_neg_cp            = convert(int,0)
into #direcciones
from #clientes_consultados_buro

create index idx1 on #direcciones(di_cliente)

--Datos domicilio cliente
update #direcciones set
di_dom_cod_dir		 = di_direccion,
di_dom_direccion	 = di_calle,
di_dom_nro			 = di_nro,
di_dom_nro_interno	 = di_nro_interno,
di_dom_nro_residente = di_nro_residentes,
di_dom_tiempo_reside = di_tiempo_reside,
di_dom_cod_tel       = di_telefono,
di_dom_cod_ciu       = di_ciudad,
di_dom_cod_bar       = di_parroquia,
di_dom_cod_depar     = di_provincia,
di_dom_cp            = di_codpostal,
di_dom_tipo_pro		 = di_tipo_prop
from cobis..cl_direccion
where di_ente = di_cliente
and di_tipo = 'RE'  
and di_direccion=(SELECT min(di_direccion) FROM cobis..cl_direccion where di_ente = di_cliente
and di_tipo = 'RE')--domicilio

-- Telefono Domicilio
update #direcciones set
di_dom_telefono = isnull(te_valor,0) 
from cobis..cl_telefono
where te_ente    = di_cliente
and te_direccion = di_dom_cod_dir --domicilio
and te_tipo_telefono = 'D' -- telefono domicilio

-- Telefono Celular Domicilio
update #direcciones set
di_dom_celular = isnull(te_valor,0) 
from cobis..cl_telefono
where te_ente        = di_cliente
and te_direccion     = di_dom_cod_dir
and te_tipo_telefono = 'C' --telefono celular

-- Municipio/Ciudad
update #direcciones set
di_dom_ciudad = upper(ci_descripcion)
from cobis..cl_ciudad
where ci_ciudad = di_dom_cod_ciu   --domicilio

-- Estado
update #direcciones set
di_dom_depar = upper(pv_descripcion)
from cobis..cl_provincia
where pv_provincia = di_dom_cod_depar   --domicilio

--Colonia/localidad
update #direcciones set
di_dom_barrio = upper(pq_descripcion)
from cobis..cl_parroquia
where pq_parroquia = di_dom_cod_bar   --domicilio

--Correo del cliente
update #direcciones set
di_correo   = di_descripcion
from cobis..cl_direccion
where di_ente  = di_cliente
and   di_tipo  = 'CE'

--Datos del negocio
update #direcciones set
di_neg_cod_dir		= di_direccion,
di_neg_direccion	= di_calle,
di_neg_nro			= di_nro,
di_neg_nro_interno	= di_nro_interno,
di_neg_cod_ciu		= di_ciudad,
di_neg_cod_bar		= di_parroquia,
di_neg_cod_depar	= di_provincia,
di_neg_cp			= di_codpostal
from cobis..cl_direccion
where di_ente = di_cliente
and di_tipo = 'AE' 
and di_direccion=(SELECT min(di_direccion) FROM cobis..cl_direccion where di_ente = di_cliente
and di_tipo = 'AE') --negocio

--Telefono del negocio
update #direcciones set
di_neg_telefono = te_valor
from cobis..cl_telefono
where te_ente    = di_cliente
and te_direccion = di_neg_cod_dir --negocio

-- Municipio/Ciudad
update #direcciones set
di_neg_ciudad = upper(ci_descripcion)
from cobis..cl_ciudad
where ci_ciudad = di_neg_cod_ciu   --negocio

/*ESTADO*/
update #direcciones set
di_neg_depar = upper(pv_descripcion)
from cobis..cl_provincia
where pv_provincia = di_neg_cod_depar   --negocio

/*COLONIA/LOCALIDAD*/
update #direcciones set
di_neg_barrio = upper(pq_descripcion)
from cobis..cl_parroquia
where pq_parroquia = di_neg_cod_bar --negocio

-- Datos de la entidad de nacimiento del cliente
update #clientes_consultados_buro set
ccb_entidad_nac = upper(pv_descripcion) 
from cobis..cl_provincia
where pv_provincia = ccb_entidad_nac

-- País nacimiento del Cliente
update #clientes_consultados_buro set
ccb_pais_nacimiento = upper(pa_descripcion)
from cobis..cl_pais
where ccb_pais_nacimiento = pa_pais

-- Nacionalidad
update #clientes_consultados_buro set
ccb_nacionalidad = upper(pa_descripcion)
from cobis..cl_pais
where ccb_nacionalidad = pa_pais

/* Actualizar descripciones de catalogos */
update #direcciones
set di_dom_tipo_pro = upper(c.valor)
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo      = c.tabla 
and t.tabla			= 'cl_tpropiedad'
and di_dom_tipo_pro = c.codigo

update #clientes_consultados_buro
set ccb_estado_civil = upper(c.valor)
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo       = c.tabla 
and t.tabla			 = 'cl_ecivil'
and ccb_estado_civil = c.codigo

update #clientes_consultados_buro
set ccb_genero = upper(c.valor)
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo = c.tabla 
and t.tabla    = 'cl_sexo'
and ccb_genero = c.codigo 

update #clientes_consultados_buro
set ccb_escolaridad = upper(c.valor)
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo      = c.tabla 
and t.tabla         = 'cl_nivel_estudio'
and ccb_escolaridad = c.codigo 

update #clientes_consultados_buro
set ccb_ocupacion = upper(c.valor)
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo    = c.tabla 
and t.tabla       = 'cl_profesion'
and ccb_ocupacion = c.codigo

/* Update para las direcciones de domicilio y negocio */
update #clientes_consultados_buro set
ccb_calle				  = di_dom_direccion,
ccb_numero				  = convert(varchar(10),di_dom_nro),
ccb_numero_interior		  = di_dom_nro_interno,
ccb_codigo_postal		  = di_dom_cp,
ccb_ciudad				  = di_dom_ciudad,
ccb_estado				  = di_dom_depar,
ccb_municipio			  = di_dom_ciudad,
ccb_colonia				  = di_dom_barrio,
ccb_dom_personas_viviendo = di_dom_nro_residente,
ccb_dom_actual_anios	  = di_dom_tiempo_reside,
ccb_email_cliente		  = di_correo,
ccb_dom_telefono		  = di_dom_telefono,
ccb_dom_celular			  = di_dom_celular,
ccb_dom_tipo_vivienda	  = di_dom_tipo_pro,
ccb_dn_calle			  = di_neg_direccion,
ccb_dn_numero			  = di_neg_nro,
ccb_dn_numero_interior    = di_neg_nro_interno,
ccb_dn_codigo_postal	  = di_neg_cp,
ccb_dn_ciudad			  = di_neg_ciudad,
ccb_dn_colonia			  = di_neg_barrio,
ccb_dn_telefono		      = di_neg_telefono
from #direcciones 
where di_cliente = ccb_cliente_cobis

/* Gastos Negocio y Familiares */
update #clientes_consultados_buro set 
ccb_dn_cve_act_economica		 = (select min(nc_actividad_ec) from  cobis..cl_negocio_cliente where nc_ente  = ccb_cliente_cobis and nc_estado_reg  ='V' and nc_actividad_ec is not null),
ccb_gastos_mensuales_negocio     = isnull(ea_ct_operativo,0),
ccb_gastos_mensuales_familiares  = isnull(ea_ct_ventas,0),
ccb_otros_ingresos				 = isnull(ea_ventas,0),
ccb_capacidad_de_pago			 = ea_ventas + ccb_ingreso_mensual - ea_ct_ventas - ea_ct_operativo,
ccb_dg_cuenta_ahorro			 = ea_cta_banco,
ccb_numero_ine					 = ea_numero_ife,
ccb_telefono_recados             = ea_telef_recados,
ccb_persona_recados			     = ea_persona_recados,
ccb_dg_ciclos_en_otras_inst      = isnull(ea_nro_ciclo_oi,0),
ccb_antecedentes_buro			 = case when ea_antecedente_buro = 'S' then 'SI' else 'NO' end,
ccb_calificacion_matriz_pld		 = ea_nivel_riesgo,
--ccb_riesgo_individual			 = isnull(ea_nivel_riesgo_cg,''), -- no existe en produccion ? 
ccb_motivo_rechazo				 = concat(case when ea_antecedente_buro = 'S' then 'B ' else '' end,
								   concat(case when ea_lista_negra = 'S' then 'LN ' else '' end,
								   concat(case when ea_negative_file = 'S' then 'NF ' else '' end,
--										 case when isnull(ea_nivel_riesgo,'') <> '' then 'PLD ' else '' end)))
										 case when upper(ea_nivel_riesgo)  in ( 'A3 BLOQUEANTE', 'A3 CCC','A3 DR') then 'PLD ' else '' end)))
from cobis..cl_ente_aux
where  ccb_cliente_cobis = ea_ente   

/* Nombre corto de la actividad economica */
update #clientes_consultados_buro set                                
ccb_dn_nombre_corto_act = c.valor
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.tabla                = 'cl_actividad'
and t.codigo				 = c.tabla
and ccb_dn_cve_act_economica = c.codigo

--- Datos del negocio
select distinct
ng_cliente           = ccb_cliente_cobis,
ng_neg_nombre        = convert(varchar(64),NULL),
ng_neg_dest_credito	 = convert(varchar(64),NULL),
ng_tipo_local_neg    = convert(varchar(64),NULL),
ng_tiempo_actividad  = convert(int,0),
ng_tiempo_arrigo     = convert(int,0),
ng_fecha_apertura	 = convert(varchar(64),NULL),
ng_recurso_apagar    = convert(varchar(20),NULL),
ng_ingresos_mensual  = convert(money,0)
into #negocio
from #clientes_consultados_buro

create index idx1 on #negocio(ng_cliente)

--Datos del Negocio
update #negocio set
ng_neg_nombre        = nc_nombre,
ng_neg_dest_credito	 = nc_destino_credito,
ng_tipo_local_neg    = nc_tipo_local,
ng_tiempo_actividad  = nc_tiempo_actividad,
ng_tiempo_arrigo     = nc_tiempo_dom_neg,
ng_fecha_apertura	 = convert(varchar,nc_fecha_apertura,103),
ng_recurso_apagar    = nc_recurso,
ng_ingresos_mensual  = nc_ingreso_mensual
from cobis..cl_negocio_cliente
where ng_cliente   = nc_ente
and nc_estado_reg  = 'V'

/* Tipo de local */
update #negocio set 
ng_tipo_local_neg = c.valor
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo        = c.tabla
and t.tabla           = 'cr_tipo_local'
and ng_tipo_local_neg = c.codigo

/* Destino credito */
update #negocio set
ng_neg_dest_credito	 = c.valor
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.codigo			= c.tabla
and t.tabla				= 'cl_destino_credito'
and ng_neg_dest_credito = c.codigo

/* Update datos del negocio */
update #clientes_consultados_buro set
ccb_dn_nombre_negocio       = ng_neg_nombre,
ccb_dn_destino_credito		= ng_neg_dest_credito,
ccb_dn_tipo_local			= ng_tipo_local_neg,
ccb_dn_tiempo_des_act       = ng_tiempo_actividad,
ccb_dn_tiempo_arrigo        = ng_tiempo_arrigo,
ccb_dn_fecha_apertura	    = ng_fecha_apertura,
ccb_dn_recursos				= ng_recurso_apagar,
ccb_dn_ingresos_del_negocio = ng_ingresos_mensual
from #negocio
where ng_cliente = ccb_cliente_cobis

/* Tiene credito */
update #clientes_consultados_buro set
ccb_tiene_credito = case when (select count(op_cliente) 
					 from cob_cartera..ca_operacion 
					 where op_cliente = ccb_cliente_cobis) > 0 then 'SI' else 'NO' end;

---consulta experiencia _creditica  se usa el programa de la variable Exp Crediticia
declare 
@w_ente_aux        int,
@w_exp_credit      char(1) 
select @w_ente_aux = 0
while (1=1) begin 
   select top 1 @w_ente_aux = ccb_cliente_cobis from #clientes_consultados_buro
   where ccb_cliente_cobis > @w_ente_aux
   order by ccb_cliente_cobis asc
   if @@rowcount = 0 break 
   
   exec cob_credito..sp_var_experiencia_crediticia
   @i_id_cliente   =   @w_ente_aux,
   @o_resultado    =   @w_exp_credit output
   
   update #clientes_consultados_buro set 
   ccb_experiencia_crediticia = (case @w_exp_credit when 'S' then 'SI' else 'NO' end ),
   ccb_exp_crediticia_comprobada = (case @w_exp_credit when 'S' then 'SI' else 'NO' end )
   where ccb_cliente_cobis = @w_ente_aux
end 

--Se elimina datos de la tabla
TRUNCATE TABLE reporte_clientes_consultados_buro_tmp

/* REGISTRA ENCABEZADOS EN LA TABLA*/
INSERT INTO reporte_clientes_consultados_buro_tmp
SELECT
	'REGION',
	'OFICINA',
	'CC',
	'GERENTE',
	'COORDINADOR',
	'ASESOR',
	'EMAIL ASESOR',
	'TELEFONO ASESOR',
	'ESTATUS ASESOR',
	'CLIENTE COBIS',

	'BUC',
	'FECHA REGISTRO',
	'FECHA BURO',
	'FOLIO BURO',
	'APELLIDO PATERNO',
	'APELLIDO MATERNO',
	'NOMBRE1',
	'NOMBRE2',
	'ENTIDAD NACIMIENTO',
	'ESTADO CIVIL',

	'FECHA NACIMIENTO',
	'EDAD',
	'EMAIL CLIENTE',
	'CALLE',
	'NUMERO',
	'NUMERO INTERIOR',
	'COLONIA',
	'CODIGO POSTAL',
	'CIUDAD',
	'ESTADO',

	'MUNICIPIO',
	'TELEFONO CLIENTE',
	'CELULAR CLIENTE',
	'AÑOS DOMICILIO',
	'TIPO VIVIENDA',
	'PERSONAS VIVIENDO',
	'PAIS NACIMIENTO',
	'GENERO',
	'NACIONALIDAD',
	'ESCOLARIDAD',

	'OCUPACION',
	'RFC',
	'CURP',
	'DEPENDIENTES ECONOMICOS',
	'OTROS INGRESOS',
	'CICLOS OTRAS INST',
	'PEP',
	'CUENTA AHORRO',
	'NOMBRE NEGOCIO',
	'DESTINO CREDITO',

	'TIPO LOCAL',
	'CALLE NEGOCIO',
	'NUMERO NEGOCIO',
	'NUMERO INTERIOR NEGOCIO',
	'COLONIA NEGOCIO',
	'CODIGO POSTAL NEGOCIO',
	'CIUDAD NEGOCIO',
	'TELEFONO NEGOCIO',
	'CVE ACTIVIDAD ECONOMICA',
	'NOMBRE CORTO ACTIVIDAD',

	'TIEMPO DESEMPEÑANDO ACT',
	'TIEMPO ARRIGO NEGOCIO',
	'FECHA APERTURA',
	'RECURSOS A PAGAR CREDITO',
	'INGRESOS DEL NEGOCIO',
	'INGRESO MENSUAL',
	'GASTOS MENSUALES NEGOCIO',
	'GASTOS MENSUALES FAMILIARES',
	'OTROS INGRESOS',
	'CAPACIDAD DE PAGO',

	'EXPERIENCIA CREDITICIA',
	'NUMERO INE',
	'PASAPORTE',
	'TELEFONO RECADOS',
	'PERSONA RECADOS',
	'ANTECEDENTES BURO',
	'CALIFICACION MATRIZ PLD',
	--'RIESGO INDIVIDUAL',
	'CLAVE RESPUESTA DE INFORME',
	'EXP CREDITICIA COMPROBADA',

	'TIENE CREDITO',
	'MOTIVO RECHAZO'
    
/* COPIA LOS DATOS A LA TABLA TMP PARA EL REPORTE */
INSERT INTO reporte_clientes_consultados_buro_tmp
SELECT
rct_region                = ltrim(ccb_region),
rct_oficna                = ltrim(ccb_oficina),
rct_cc                    = ltrim(ccb_cc),
rct_gerente               = ltrim(ccb_gerente),
rct_coordinador           = ltrim(ccb_coordinador),
rct_asesor                = ltrim(ccb_asesor),
rct_email_asesor          = ltrim(ccb_email_asesor),
rct_tel_asesor            = ltrim(ccb_telefono_asesor),
rct_status_asesor         = ltrim(ccb_estatus_asesor),
rct_cliente_cobis         = ccb_cliente_cobis,
rct_id_buc                = ltrim(ccb_id_buc),
rct_fecha_registro        = ltrim(ccb_fecha_registro), 
rct_fecha_consulta_buro   = ltrim(ccb_fecha_consulta_buro), 
rct_folio_consulta_buro   = ltrim(ccb_folio_consulta_buro),
rct_app_paterno           = ltrim(ccb_app_paterno),
rct_app_materno           = ltrim(ccb_app_materno),
rct_nombre1               = ltrim(ccb_nombre1),
rct_nombre2               = ltrim(ccb_nombre2),
rct_entidad_nac           = ltrim(ccb_entidad_nac),
rct_estado_civil          = ltrim(ccb_estado_civil),
rct_fecha_nacimiento      = ltrim(ccb_fecha_nacimiento),
rct_edad                  = ltrim(ccb_edad),
rct_email_cliente         = ltrim(ccb_email_cliente),
rct_calle                 = ltrim(ccb_calle),
rct_numero                = ltrim(ccb_numero),
rct_numero_interior       = ltrim(ccb_numero_interior),
rct_colonia               = ltrim(ccb_colonia),
rct_codigo_postal         = ltrim(ccb_codigo_postal),
rct_ciudad                = ltrim(ccb_ciudad),
rct_estado                = ltrim(ccb_estado),
rct_municipio             = ltrim(ccb_municipio),
rct_telefono_cliente      = ltrim(ccb_dom_telefono),
rct_celular_cliente       = ltrim(ccb_dom_celular),
rct_dom_actual_anios      = ltrim(ccb_dom_actual_anios),
rct_tipo_vivienda         = ltrim(ccb_dom_tipo_vivienda),
rct_personas_viviendo     = ltrim(ccb_dom_personas_viviendo),
rct_pais_nacimiento       = ltrim(ccb_pais_nacimiento),
rct_genero                = ltrim(ccb_genero),
rct_nacionalidad          = ltrim(ccb_nacionalidad),
rct_escolaridad           = ltrim(ccb_escolaridad),
rct_ocupacion             = ltrim(ccb_ocupacion),
rct_rfc                   = ltrim(ccb_rfc),
rct_curp                  = ltrim(ccb_curp),
rct_dependientes_econo    = ltrim(ccb_dg_dependientes_economicos),
rct_is_otros_ingresos     = ltrim(ccb_dg_otros_ingresos),
rct_ciclos_otras_inst     = ltrim(ccb_dg_ciclos_en_otras_inst),
rct_pep                   = ltrim(ccb_dg_pep),
rct_cuenta_ahorro         = ltrim(ccb_dg_cuenta_ahorro),
rct_nombre_negocio        = ltrim(ccb_dn_nombre_negocio),
rct_destino_credito       = ltrim(ccb_dn_destino_credito),
rct_tipo_local            = ltrim(ccb_dn_tipo_local),
rct_calle_neg             = ltrim(ccb_dn_calle),
rct_numero_neg            = ltrim(ccb_dn_numero),
rct_numero_neg_interior   = ltrim(ccb_dn_numero_interior),
rct_colonia_neg           = ltrim(ccb_dn_colonia),
rct_codigo_postal_neg     = ltrim(ccb_dn_codigo_postal),
rct_ciudad_neg            = ltrim(ccb_dn_ciudad),
rct_telefono_neg          = ltrim(ccb_dn_telefono),
rct_cve_act_economica     = ltrim(ccb_dn_cve_act_economica),
rct_nombre_corto_act      = ltrim(ccb_dn_nombre_corto_act),
rct_tiempo_des_act        = ltrim(ccb_dn_tiempo_des_act),
rct_tiempo_arrigo         = ltrim(ccb_dn_tiempo_arrigo),
rct_fecha_apertura        = ltrim(ccb_dn_fecha_apertura),
rct_recursos              = ltrim(ccb_dn_recursos),
rct_ingresos_negocio      = ltrim(ccb_dn_ingresos_del_negocio),
rct_ingreso_mensual       = ltrim(ccb_ingreso_mensual),
rct_gastos_men_negocio    = ltrim(ccb_gastos_mensuales_negocio),
rct_gastos_men_familia    = ltrim(ccb_gastos_mensuales_familiares),
rct_otros_ingresos        = ltrim(ccb_otros_ingresos),
rct_capacidad_pago        = ltrim(ccb_capacidad_de_pago),
rct_exp_crediticia        = ltrim(ccb_experiencia_crediticia),
rct_numero_ine            = ltrim(ccb_numero_ine),
rct_pasaporte             = ltrim(ccb_pasaporte),
rct_telefono_recados      = ltrim(ccb_telefono_recados),
rct_persona_recados       = ltrim(ccb_persona_recados),
rct_antecedentes_buro     = ltrim(ccb_antecedentes_buro), 
rct_calif_matriz_pld      = ltrim(ccb_calificacion_matriz_pld),
--rct_riesgo_individual   = rtrim(ccb_riesgo_individual)), -- NO EXISTE EN PREPDUCCION
rct_cve_resp_informe      = ltrim(ccb_clave_respuesta_informe),
rct_exp_cred_comprobada   = ltrim(ccb_exp_crediticia_comprobada),
rct_tiene_credito         = ltrim(ccb_tiene_credito),
rct_motivo_rechazo		  = case when ccb_motivo_rechazo <> '' then ccb_motivo_rechazo else NULL end
FROM #clientes_consultados_buro
-------------------------------------------

--SELECT @w_bcp = @w_s_app + 's_app bcp -auto -login ' + 'cobis..reporte_clientes_consultados_buro_tmp' + ' out ' + @w_file_rpt_1 + ' -c -t\t -b 5000 -e -config ' + @w_s_app + 's_app.ini'
SELECT @w_bcp = @w_s_app + 's_app bcp -auto -login ' + 'cobis..reporte_clientes_consultados_buro_tmp' + ' out ' + @w_file_rpt_1 + ' -w -t\t -b 5000 -e -config ' + @w_s_app + 's_app.ini'
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

return 0

ERROR_PROCESO:

exec @w_return     = cobis..sp_errorlog
    @i_fecha       = @w_fecha_proceso,
    @i_error       = @w_return,
    @i_usuario     = 'OPERADOR',
    @i_tran        = null,
    @i_tran_name   = @w_sp_name,
    @i_cuenta      = '',
    @i_rollback    = 'N',
    @i_descripcion = @w_msg

return @w_return

GO
