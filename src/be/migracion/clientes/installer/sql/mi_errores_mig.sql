/************************************************************************/
/*    ARCHIVO:         mi_errores_mig.sql                                 */
/*    NOMBRE LOGICO:   mi_errores_mig.sql                                 */
/*    PRODUCTO:        CLIENTES                                         */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Script de insercion de codigos de errores generados                */
/*   en la migración                                                    */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/************************************************************************/

use cob_externos
go


if exists (select 1 from cl_errores_mig where er_cod between 0 and 200)
   delete cl_errores_mig where er_cod between 0 and 200
go

Insert into cl_errores_mig values(1,'tr_cod_actividad existe en el catalogo cl_actividad_asfi')
go
Insert into cl_errores_mig values(2,'te_area existe en el catalogo cl_formato_telefono')
go
Insert into cl_errores_mig values(3,'te_funcionario no es valido en la cl_funcionario')
go
Insert into cl_errores_mig values(4,'te_telf_cobro edebe ser N')
go
Insert into cl_errores_mig values(5,'di_fuente_verif existe en el catalogo cl_verificar_datos')
go
Insert into cl_errores_mig values(6,'di_tipo_prop existe en el catalogo cl_tpropiedad')
go
Insert into cl_errores_mig values(7,'di_departamento existe en el catalogo cl_depart_pais')
go
Insert into cl_errores_mig values(8,'di_rural_urbano existe en el catalogo cl_sector')
go
Insert into cl_errores_mig values(9,'di_codbarrio existe en el catalogo cl_barrio')
go
Insert into cl_errores_mig values(10,'El dato no existe en el catalogo cl_rol_empresa')
go
Insert into cl_errores_mig values(11,'El dato no existe en el catalogo cl_tipo_identificacion')
go
insert into cl_errores_mig values(12,'Codigo que se encuentra en di_pais no corresponde a la cl_pais')
go
insert into cl_errores_mig values(13,'Codigo que se encuentra en en_nacionalidad no corresponde a la cl_pais')
go
Insert into cl_errores_mig values(14,'El dato no existe en el catalogo cl_depart_pais')
go
Insert into cl_errores_mig values(15,'El dato no existe en el catalogo cl_nivel_egresos')
go
Insert into cl_errores_mig values(16,'El dato no existe en el catalogo cl_tipo_documento')
go
Insert into cl_errores_mig values(17,'El dato no existe en el catalogo cl_discapacidad')
go
Insert into cl_errores_mig values(18,'Valor debe ser igual a 68(Bolivia)')
go
Insert into cl_errores_mig values(19,'El dato no existe en el catalogo cl_estados_ente')
go
Insert into cl_errores_mig values(20,'El dato no existe en la tabla cl_ente')
go
Insert into cl_errores_mig values(21,'El dato no existe en la tabla cl_funcionario')
go
Insert into cl_errores_mig values(22,'El dato es invalido (A,D,S)')
go
Insert into cl_errores_mig values(23,'El dato es invalido (FI,GP)')
go
Insert into cl_errores_mig values(24,'El dato no existe en el catalogo cl_situacion_laboral')
go
Insert into cl_errores_mig values(25,'El dato no existe en la tabla cl_banco_rem')
go
Insert into cl_errores_mig values(26,'El dato no existe en la tabla cl_direccion')
go
Insert into cl_errores_mig values(27,'El dato no existe en la tabla cl_telefono')
go
Insert into cl_errores_mig values(28,'El dato no existe en el catalogo cl_tbalance')
go
Insert into cl_errores_mig values(29,'El dato no existe en la tabla cl_pais')
go
Insert into cl_errores_mig values(30,'Registro duplicado')
go
Insert into cl_errores_mig values(31,'El dato es invalido (B,C,T)')
go
Insert into cl_errores_mig values(32,'El dato no existe en el catalogo cl_tipo_vinculacion')
go
Insert into cl_errores_mig values(33,'El dato no existe en la tabla cl_oficina')
go
Insert into cl_errores_mig values(34,'El dato no existe en la tabla cl_ciudad')
go
Insert into cl_errores_mig values(35,'El dato no existe en la tabla cl_moneda')
go
Insert into cl_errores_mig values(36,'El numero de tarjeta es obligatorio')
go
Insert into cl_errores_mig values(37,'El dato no existe en la tabla cl_ente')
go
Insert into cl_errores_mig values(38,'El dato es invalido debe ser(BCA,BCC,DPF)')
go
Insert into cl_errores_mig values(39,'El dato no existe en el catalogo cl_tarjeta')
go
Insert into cl_errores_mig values(40,'El dato no existe en el catalogo cl_parentesco')
go
Insert into cl_errores_mig values(41,'El dato no existe en la tabla cl_balance')
go
Insert into cl_errores_mig values(42,'El dato es invalido (CTE,AHO,PFI)')
go
Insert into cl_errores_mig values(43,'El dato debe ser MAYOR QUE CERO')
go
Insert into cl_errores_mig values(44,'El dato no existe en la tabla cl_cuenta')
go
Insert into cl_errores_mig values(45,'El número de teléfono debe comenzar por 0 y debe tener por lo menos 9 dígitos')
go
Insert into cl_errores_mig values(46,'El dato es invalido debe ser (S,N)')
go
Insert into cl_errores_mig values(47,'El dato no existe en el catalogo cl_tipo_documento')
go
Insert into cl_errores_mig values(48,'Es necesario el Codigo o Nombre de la Empresa')
go
Insert into cl_errores_mig values(49,'El dato no existe en el catalogo cl_ttelefono')
go
Insert into cl_errores_mig values(50,'El dato no existe en el catalogo cl_sector')
go
Insert into cl_errores_mig values(51,'El dato no existe en el catalogo cl_relacion_banco')
go
Insert into cl_errores_mig values(52,'El dato es invalido (P,C)')
go
Insert into cl_errores_mig values(53,'El dato es invalido (SI,RU,CI,CR,PA)')
go
Insert into cl_errores_mig values(54,'El dato no existe en el catalogo cl_ingresos')
go
Insert into cl_errores_mig values(55,'El dato no existe en el catalogo cl_profesion')
go
Insert into cl_errores_mig values(56,'El dato no existe en el catalogo cl_sexo')
go
Insert into cl_errores_mig values(57,'El dato no existe en el catalogo cl_ecivil')
go
Insert into cl_errores_mig values(58,'El dato no existe en el catalogo cl_nivel_instruccion')
go
Insert into cl_errores_mig values(59,'El dato no existe en el catalogo cl_tipo_vivienda')
go
Insert into cl_errores_mig values(60,'El p_tipo_persona no existe en el catalogo cl_ptipo')
go
Insert into cl_errores_mig values(61,'El dato no existe en el catalogo cl_sector_eco')
go
Insert into cl_errores_mig values(62,'El dato no existe en la tabla cl_actividad_ec')
go
Insert into cl_errores_mig values(63,'El dato no existe en el catalogo cl_tipo_sociedad')
go
Insert into cl_errores_mig values(64,'El dato no existe en el catalogo cl_tipn_jur')
go
Insert into cl_errores_mig values(65,'El dato no existe en la tabla cl_sub_emp_niv2')
go
Insert into cl_errores_mig values(66,'El dato no existe en la tabla cl_sub_emp_niv1')
go
Insert into cl_errores_mig values(67,'El dato no existe en la tabla cl_tip_subemp')
go
Insert into cl_errores_mig values(68,'El dato no existe en el catalogo cl_tip_resd')
go
Insert into cl_errores_mig values(69,'El dato no existe en el catalogo cl_actividad_mark')
go
Insert into cl_errores_mig values(70,'El dato no existe en el catalogo cl_cod_super')
go
Insert into cl_errores_mig values(71,'El dato no existe en la tabla cl_activ_eco')
go
Insert into cl_errores_mig values(72,'El dato no existe en el catalogo cl_promotor')
go
Insert into cl_errores_mig values(73,'El dato no existe en el catalogo cl_situacion_cliente')
go
Insert into cl_errores_mig values(74,'El dato no existe en la tabla cl_parroquia')
go
Insert into cl_errores_mig values(75,'El dato no existe en el catalogo cl_tdireccion')
go
Insert into cl_errores_mig values(76,'Los datos no existen en la tabla cl_barrio')
go
Insert into cl_errores_mig values(77,'El dato no existe en la tabla cl_provincia')
go
Insert into cl_errores_mig values(78,'El dato es invalido (H,C)')
go
Insert into cl_errores_mig values(79,'El dato no existe en la tabla cl_det_producto')
go
Insert into cl_errores_mig values(80,'El dato no existe en la tabla cl_canton')
go
Insert into cl_errores_mig values(81,'El dato no existe en la tabla cl_tipo_documento')
go
Insert into cl_errores_mig values(82,'No existe el codigo de Representante Legal')
go
Insert into cl_errores_mig values(83,'El dato Cedula, RUC o Pasaporte es obligatorio')
go
insert into cl_errores_mig values(84,'Error en Cursor') --IBA  22/04/2009
go
insert into cl_errores_mig values(85,'El dato no existe en el catalogo cl_tmala_ref') --IBA  22/04/2009
go
insert into cl_errores_mig values(86,'El nombre de la institución es obligatorio')
go
insert into cl_errores_mig values(87,'La fecha de compra es obligatoria')
go
insert into cl_errores_mig values(88,'El teléfono de la referencia es obligatorio')
go
insert into cl_errores_mig values(89,'El número de cifras es obligatorio')
go
insert into cl_errores_mig values(90,'El dato no existe en el catálogo cl_tcifras')
go
insert into cl_errores_mig values(91,'Un cliente de Nacionalidad local debe ser registrado con Identificación')
go
insert into cl_errores_mig values(92,'El cliente se encuentra en la tabla definitiva')
go
insert into cl_errores_mig values(93,'El cliente debe encontrarse en el lado izquierdo de la relación')
go
insert into cl_errores_mig values(94,'Cédula de Identidad no válida')
go
insert into cl_errores_mig values(95,'RUC no válido')
go
insert into cl_errores_mig values(96,'Código de Cliente duplicado')
go
insert into cl_errores_mig values(97,'Contador de Teléfonos Incorrecto')
go
insert into cl_errores_mig values(98,'Contador de Direcciones Incorrecto')
go
insert into cl_errores_mig values(99,'Contador de Referencias Económicas Incorrecto')
go
insert into cl_errores_mig values(100,'Contador de Balances Incorrecto')
go
insert into cl_errores_mig values(101,'Contador de Malas Referencias Incorrecto')
go
insert into cl_errores_mig values(102,'Contador de Referencias Personales Incorrecto')
go
insert into cl_errores_mig values(103,'Contador de Empleos Incorrecto')
go
insert into cl_errores_mig values(104,'El valor del dato del campo en_mala_referencia es incorrecto')
go
insert into cl_errores_mig values(105,'El valor de la cuenta debe ser mayor a 0')
go
insert into cl_errores_mig values(106,'El cliente a actualizar no se encuentra en la tabla definitiva')
go
insert into cl_errores_mig values(107,'en_nomlar no es igual a en_nombre + p_apellido + s_apellido')
go
insert into cl_errores_mig values(108,'en_situacion_cliente no puede tener valor null')
go
insert into cl_errores_mig values(109,'Codigo que se encuentra en p_ciudad_nac no corresponde a la cl_pais')
go
insert into cl_errores_mig values(110,'Codigo que se encuentra en en_oficial no corresponde a la cl_funcionario')
go
insert into cl_errores_mig values(111,'La Fecha debe ser menor a la actual')
go
insert into cl_errores_mig values(112,'No se encuentra el valor en la tabla cl_campos_id')
go
insert into cl_errores_mig values(113,'Campos dg_lat_grad, dg_lat_min, dg_lat_seg, dg_long_grad, dg_long_min, dg_long_seg mayors o igual a cero')
go
insert into cl_errores_mig values(114,'Codigo que se encuentra en en_asosciada no corresponde a la cl_tipo_vinculacion')
go
Insert into cl_errores_mig values(115,'El dato no existe en el catalogo cl_tip_resd')
go
Insert into cl_errores_mig values(116,'El dato no existe en el catalogo cl_cliente_ente')
go
Insert into cl_errores_mig values(117,'tr_func_public debe ser S o N.')
go
insert into cl_errores_mig values(118,'ea_path_foto nombre de foto repetida.')
go
insert into cl_errores_mig values(119,'ea_path_foto diferente de en_codigo.')
go
insert into cl_errores_mig values(120,'ea_path_foto extensión de imagen diferente de jpg.')
go
insert into cl_errores_mig values(121,'en_tipo_vinculacion -> ente con ea_estado=P debe tener relación con el banco US .')
go

----------

insert into cl_errores_mig values(130,'ae_ente no existe en cl_ente')
go

insert into cl_errores_mig values(131,'ae_actividad no existe en cobis..cl_actividad_ec')
go

insert into cl_errores_mig values(132,'ae_sector no existe en cobis..cl_sector_economico')
go

insert into cl_errores_mig values(133,'ae_subactividad no existe en cobis..cl_subactividad_ec')
go

insert into cl_errores_mig values(134,'ae_subactividad no está relacionado con ae_actividad')
go

insert into cl_errores_mig values(135,'ae_subsector no existe en cobis..cl_subsector_ec')
go

insert into cl_errores_mig values(136,'ae_subsector no está relacionado con ae_sector')
go

insert into cl_errores_mig values(137,'ae_fuente_ing no existe en catálogo cl_fuente_ingreso')
go

insert into cl_errores_mig values(138,'ae_fuente_ing no tiene relación con cl_sector_economico')
go

insert into cl_errores_mig values(139,'ae_principal diferente de S/N')
go

insert into cl_errores_mig values(140,'ae_principal no posee actividad principal')
go

insert into cl_errores_mig values(141,'ae_principal cliente posees más de una actividad principal')
go

insert into cl_errores_mig values(142,'ae_dias_atencion no existe en catálogo cl_dias_atencion')
go

insert into cl_errores_mig values(143,'ae_dias_atencion con valor NULL.')
go

insert into cl_errores_mig values(144,'ae_fecha_inicio_act menor a fecha por defecto (01.01.1900)')
go

insert into cl_errores_mig values(145,'ae_antiguedad con valor negativo.')
go

insert into cl_errores_mig values(146,'ae_ambiente no existe en catálogo cl_ambiente')
go

insert into cl_errores_mig values(147,'ae_autorizado diferente de S/N')
go

insert into cl_errores_mig values(148,'')
go

insert into cl_errores_mig values(149,'ae_afiliado diferente de S/N')
go

insert into cl_errores_mig values(150,'')
go

insert into cl_errores_mig values(151,'ae_lugar_afiliacion con valor NULL.')
go

insert into cl_errores_mig values(152,'ae_num_empleados con valor negativo.')
go

insert into cl_errores_mig values(153,'ae_ubicacion no existe en catálogo cl_tpropiedad')
go

insert into cl_errores_mig values(154,'ae_horario_actividad con valor NULL.')
go

insert into cl_errores_mig values(155,'ae_estado con valor diferente de V.')
go

insert into cl_errores_mig values(156,'ae_verificado con valor diferente de V.')
go

insert into cl_errores_mig values(157,'ae_funcionario no existe en cobis..cl_funcionario')
go

insert into cl_errores_mig values(158,'Campo faltante para id_compuesto')
go

insert into cl_errores_mig values(159,'p_ciudad_nac no puede ser null')
go

insert into cl_errores_mig values(160,'p_num_cargas con valor null')
go


insert into cl_errores_mig values(161,'p_fecha_expira con valor null')
go

insert into cl_errores_mig values(162,'en_nacionalidad con valor null o 999')
go

insert into cl_errores_mig values(163,'di_ciudad con valor 99999')
go

insert into cl_errores_mig values(164,'di_provincia con valor 9999')
go

insert into cl_errores_mig values(165,'di_fact_serv_pu con valor null')
go

insert into cl_errores_mig values(166,'in_estado no existe en catálogo en cl_ereferencia')
go

insert into cl_errores_mig values(167,'in_ente_i, in_ente_d, in_relacion - Registro duplicado')
go

insert into cl_errores_mig values(168,'Error al momento de transferir dato a la cl_instancia')
go

insert into cl_errores_mig values(169,'NO TIENE NUEVO ENTE ASIGNADO')
go

insert into cl_errores_mig values(170,'in_ente_i - Dato no existe en la tabla cl_ente')
go

insert into cl_errores_mig values(171,'in_ente_d - Dato no existe en la tabla cl_ente')
go

insert into cl_errores_mig values(172,'Error al momento de transferir dato a la cl_instancia_mig')
go

insert into cl_errores_mig values(173,'Campo in_ente_i es igual al campo in_ente_d')
go

insert into cl_errores_mig values(174,'Error en Ejecucion de Validaciones cl_instancia')
go

insert into cl_errores_mig values(175,'Error al definir mala referencia en la cl_ente.en_mala_referencia')
go

