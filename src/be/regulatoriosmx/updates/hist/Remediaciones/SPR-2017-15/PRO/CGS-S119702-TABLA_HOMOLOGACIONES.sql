
-- -------------------------------------------------------------------------------------------------
-- ---------- SCRIPTS CREACION TABLAS --------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------
USE cob_conta_super
go

if object_id ('sb_reporte_buro_cuentas') is not null
    drop table sb_reporte_buro_cuentas
go
CREATE TABLE sb_reporte_buro_cuentas
(	
	rb_fecha_report datetime NOT NULL,
	rb_operacion	int NOT NULL,
	rb_ente			int NOT NULL,
    [04] varchar(255)  NOT NULL,
    [05] varchar(255)  NULL,
    [06] varchar(255)  NULL,
    [07] varchar(255)  NULL,
    [08] varchar(255)  NULL,
    [09] bigint		   NULL,
    [10] varchar(255)  NULL,
    [11] varchar(255)  NULL,
    [12] varchar(255)  NULL,
    [13] varchar(255)  NULL,
    [14] varchar(255)  NULL,
    [15] varchar(255)  NULL,
    [16] varchar(255)  NULL,
    [17] varchar(255)  NULL,
    [20] varchar(1)    NULL,
    [21] varchar(255)  NULL,
    [22] bigint  		   NULL,
    [23] varchar(1)    NULL,
    [24] bigint           NULL,
    [25] varchar(255)  NULL,
    [26] varchar(255)  NULL,
    [30] varchar(1)    NULL,
    [39] varchar(1)    NULL,
    [40] varchar(1)    NULL,
    [41] varchar(1)    NULL,
    [43] varchar(255)  NULL,
    [44] varchar(255)  NULL,
    [45] varchar(255)  NULL,
    [46] varchar(1)    NULL,
    [47] varchar(255)  NULL,
    [48] varchar(255)  NULL,
    [49] varchar(255)  NULL,
    [50] varchar(255)  NULL,
    [51] varchar(255)  NULL,
    [52] varchar(255)  NULL
)
go
CREATE CLUSTERED INDEX sb_reporte_buro_cuentas_fk
	ON sb_reporte_buro_cuentas (rb_fecha_report,rb_operacion,rb_ente)
GO

if object_id ('sb_buro_cliente') is not null
    drop table sb_buro_cliente
go
create table sb_buro_cliente(
bc_en_ente	     int,
bc_p_apellido	  varchar(31) null,
bc_s_apellido	  varchar(31) null,
bc_ad_apellido	  varchar(31) null,
bc_en_nombre	  varchar(31) null,
bc_s_nombre	     varchar(31) null,
bc_fecha_nac	  varchar(13) null,
bc_en_rfc    	  varchar(18) null,
bc_pref_pers	  varchar(9)  null,
bc_suf_pers	     varchar(9)  null,
bc_nacionalidad  varchar(7)  null,
bc_tresidencia	  varchar(6)  null,
bc_lic_conducir  varchar(25) null,
bc_ecivil	     varchar(6)  null,
bc_sexo	        varchar(6)  null,
bc_seg_social	  varchar(25) null,
bc_reg_electoral varchar(25) null,
bc_iden_unica	  varchar(25) null,
bc_clave_pais	  varchar(7) null,
bc_num_depend	  varchar(7) null,
bc_edades_dep	  varchar(35) null,
bc_fec_defuncion varchar(13) null,
bc_ind_defuncion varchar(6) null
)
CREATE CLUSTERED INDEX sb_buro_cliente_fk
	ON sb_buro_cliente (bc_en_ente)
GO


if object_id ('sb_buro_direccion') is not null
    drop table sb_buro_direccion
go
create table sb_buro_direccion(
   bd_di_ente     int null,
   bd_pri_linea   varchar(50) null,
   bd_seg_linea   varchar(50) null,
   bd_colonia     varchar(50) null,
   bd_delegacion  varchar(50) null,
   bd_ciudad      varchar(50) null,
   bd_estado      varchar(9) null, 
   bd_cod_postal  varchar(10) null,
   bd_fec_reside  varchar(13) null,
   bd_num_telf    varchar(21) null,
   bd_ext_telf    varchar(18) null,
   bd_num_fax     varchar(21) null,
   bd_tdomicilio  varchar(6) null,
   bd_ind_esp_dom varchar(6) null,
   bd_org_dom     varchar(7) null
)
CREATE CLUSTERED INDEX sb_buro_direccion_fk
	ON dbo.sb_buro_direccion (bd_di_ente)
GO

if exists (select 1 from sysobjects where name = 'sb_reporte_buro_final' and type = 'U')
   drop table sb_reporte_buro_final
 go
CREATE TABLE sb_reporte_buro_final
(  
   rb_id int IDENTITY (1, 1) NOT NULL,
   rb_cadena varchar(max) --COLLATE Latin1_General_BIN NULL
)
go


-- -------------------------------------------------------------------------------------------------
-- ---------- SCRIPTS BATCH ------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------

use cobis
go
delete from cl_parametro where pa_nemonico in ('CURB','NURB')
insert into cl_parametro values ('CLAVE USUARIO REPORTE BURO','CURB','C','0329',null,null,null,null,null,null,'REC')
insert into cl_parametro values ('NOMBRE USUARIO REPORTE BURO','NURB','C','BANCO COBIS',null,null,null,null,null,null,'REC')
insert into cl_parametro values ('TIPO TELEFONO BURO CREDITO','TTBC','C','D',null,null,null,null,null,null,'REC')
go

-- -------------
use cob_conta_super
go
-- -------------
delete from sb_equivalencias where eq_catalogo in ('CL_MONEDA','CR_TCRED')
go

insert into sb_equivalencias values ('CL_MONEDA','0','MX','PESOS MEXICANOS','V')
insert into sb_equivalencias values ('CL_MONEDA','2','US','DOLARES AMERICANOS','V')

insert into sb_equivalencias values ('CR_TCRED','INDIVIDUAL','I','INDIVIDUAL','V')
insert into sb_equivalencias values ('CR_TCRED','GRUPAL','J','MANCOMUNADO','V')
insert into sb_equivalencias values ('CR_TCRED','INTERCICLO','J','MANCOMUNADO','V')

-- ------
delete from sb_equivalencias where eq_catalogo = 'CL_PAIS_A6'

create table #temp_cat_equiv(
   codigo char(10) null,
   abrv varchar(4) null,
   descrip varchar(60) null
)
insert into #temp_cat_equiv values ('1','AF','Afganistan')
insert into #temp_cat_equiv values ('2','AL','Albania')
insert into #temp_cat_equiv values ('3','DE','Alemania')
insert into #temp_cat_equiv values ('4','AD','Andorra')
insert into #temp_cat_equiv values ('5','AO','Angola')
insert into #temp_cat_equiv values ('6','AI','Anguila')
insert into #temp_cat_equiv values ('7','AQ','Antartida')
insert into #temp_cat_equiv values ('8','AG','Antigua y Barbuda')
insert into #temp_cat_equiv values ('9','SA','Arabia Saudita')
insert into #temp_cat_equiv values ('10','DZ','Argelia')
insert into #temp_cat_equiv values ('11','AR','Argentina')
insert into #temp_cat_equiv values ('12','AM','Armenia')
insert into #temp_cat_equiv values ('13','AW','Aruba')
insert into #temp_cat_equiv values ('14','AU','Australia')
insert into #temp_cat_equiv values ('15','AT','Austria')
insert into #temp_cat_equiv values ('16','AZ','Azerbaiyan')
insert into #temp_cat_equiv values ('17','BS','Bahamas')
insert into #temp_cat_equiv values ('18','BH','Bahrein')
insert into #temp_cat_equiv values ('19','BD','Bangladesh')
insert into #temp_cat_equiv values ('20','BB','Barbados')
insert into #temp_cat_equiv values ('21','BE','Belgica')
insert into #temp_cat_equiv values ('22','BZ','Belice')
insert into #temp_cat_equiv values ('23','BJ','Benin')
insert into #temp_cat_equiv values ('24','BM','Bermudas')
insert into #temp_cat_equiv values ('25','BY','Bielorrusia')
insert into #temp_cat_equiv values ('26','BO','Bolivia')
insert into #temp_cat_equiv values ('27','BQ','Bonaire, San Eustaquio y Saba')
insert into #temp_cat_equiv values ('28','BA','Bosnia y Herzegovina (Republica de Bosnia)')
insert into #temp_cat_equiv values ('29','BW','Botsuana')
insert into #temp_cat_equiv values ('30','BR','Brasil')
insert into #temp_cat_equiv values ('31','BN','Brunei Darussalam')
insert into #temp_cat_equiv values ('32','BG','Bulgaria')
insert into #temp_cat_equiv values ('33','BF','Burkina Faso')
insert into #temp_cat_equiv values ('34','BI','Burundi')
insert into #temp_cat_equiv values ('35','BT','Butan')
insert into #temp_cat_equiv values ('36','CV','Cabo Verde')
insert into #temp_cat_equiv values ('37','KH','Camboya')
insert into #temp_cat_equiv values ('38','CM','Camerun')
insert into #temp_cat_equiv values ('39','CA','Canada')
insert into #temp_cat_equiv values ('40','CL','Chile')
insert into #temp_cat_equiv values ('41','CN','China')
insert into #temp_cat_equiv values ('42','CY','Chipre')
insert into #temp_cat_equiv values ('43','CO','Colombia')
insert into #temp_cat_equiv values ('44','CI','Costa de Marfil (Cote d Ivoire)')
insert into #temp_cat_equiv values ('45','CR','Costa Rica')
insert into #temp_cat_equiv values ('46','HR','Croacia')
insert into #temp_cat_equiv values ('47','CU','Cuba')
insert into #temp_cat_equiv values ('48','CW','Curaçao')
insert into #temp_cat_equiv values ('49','DK','Dinamarca')
insert into #temp_cat_equiv values ('50','DJ','Djibouti')
insert into #temp_cat_equiv values ('51','DM','Dominica')
insert into #temp_cat_equiv values ('52','EC','Ecuador')
insert into #temp_cat_equiv values ('53','EG','Egipto')
insert into #temp_cat_equiv values ('54','SV','El Salvador')
insert into #temp_cat_equiv values ('55','ER','Eritrea')
insert into #temp_cat_equiv values ('56','SK','Eslovaquia')
insert into #temp_cat_equiv values ('57','SI','Eslovenia')
insert into #temp_cat_equiv values ('58','ES','España')
insert into #temp_cat_equiv values ('59','US','Estados Unidos')
insert into #temp_cat_equiv values ('60','EE','Estonia')
insert into #temp_cat_equiv values ('61','ET','Ethiopia')
insert into #temp_cat_equiv values ('62','FJ','Fiji')
insert into #temp_cat_equiv values ('63','PH','Filipinas')
insert into #temp_cat_equiv values ('64','FI','Finlandia')
insert into #temp_cat_equiv values ('65','FR','Francia')
insert into #temp_cat_equiv values ('66','GA','Gabon')
insert into #temp_cat_equiv values ('67','GM','Gambia')
insert into #temp_cat_equiv values ('68','GS','Georgia del sur y las islas sandwich del sur')
insert into #temp_cat_equiv values ('69','GH','Ghana')
insert into #temp_cat_equiv values ('70','GI','Gibraltar')
insert into #temp_cat_equiv values ('71','GD','Granada')
insert into #temp_cat_equiv values ('72','GR','Grecia')
insert into #temp_cat_equiv values ('73','GL','Groenlandia')
insert into #temp_cat_equiv values ('74','GP','Guadalupe')
insert into #temp_cat_equiv values ('75','GU','Guam')
insert into #temp_cat_equiv values ('76','GT','Guatemala')
insert into #temp_cat_equiv values ('77','GY','Guayana')
insert into #temp_cat_equiv values ('78','GF','Guayana Francesa')
insert into #temp_cat_equiv values ('79','GG','Guernsey')
insert into #temp_cat_equiv values ('80','GN','Guinea')
insert into #temp_cat_equiv values ('81','GQ','Guinea Ecuatorial')
insert into #temp_cat_equiv values ('82','GW','Guinea-Bissau')
insert into #temp_cat_equiv values ('83','HT','Haiti')
insert into #temp_cat_equiv values ('84','HN','Honduras')
insert into #temp_cat_equiv values ('85','HK','Hong Kong')
insert into #temp_cat_equiv values ('86','HU','Hungria')
insert into #temp_cat_equiv values ('87','IN','India')
insert into #temp_cat_equiv values ('88','ID','Indonesia')
insert into #temp_cat_equiv values ('89','IQ','Irak')
insert into #temp_cat_equiv values ('90','IR','Iran')
insert into #temp_cat_equiv values ('91','IE','Irlanda')
insert into #temp_cat_equiv values ('92','BV','Isla Bouvet')
insert into #temp_cat_equiv values ('93','IM','Isla de Man')
insert into #temp_cat_equiv values ('94','CX','Isla de Navidad')
insert into #temp_cat_equiv values ('95','HM','Isla Heard e Islas McDonald')
insert into #temp_cat_equiv values ('96','NF','Isla Norfolk')
insert into #temp_cat_equiv values ('97','IS','Islandia')
insert into #temp_cat_equiv values ('98','AX','Islas Åland')
insert into #temp_cat_equiv values ('99','KY','Islas Caiman')
insert into #temp_cat_equiv values ('100','CK','Islas Cook (las)')
insert into #temp_cat_equiv values ('101','FK','Islas Falkland (Malvinas)')
insert into #temp_cat_equiv values ('102','FO','Islas Faroe')
insert into #temp_cat_equiv values ('103','MP','Islas Marianas del Norte (las)')
insert into #temp_cat_equiv values ('104','MH','Islas Marshall (las)')
insert into #temp_cat_equiv values ('105','PN','Islas Pitcairn')
insert into #temp_cat_equiv values ('106','RE','Islas Reunion')
insert into #temp_cat_equiv values ('107','SB','Islas Salomon (las)')
insert into #temp_cat_equiv values ('108','VI','Islas Virgenes (EE.UU.)')
insert into #temp_cat_equiv values ('109','VG','Islas Virgenes Inglesas')
insert into #temp_cat_equiv values ('110','IL','Israel')
insert into #temp_cat_equiv values ('111','IT','Italia')
insert into #temp_cat_equiv values ('112','JM','Jamaica')
insert into #temp_cat_equiv values ('113','JP','Japon')
insert into #temp_cat_equiv values ('114','JE','Jersey')
insert into #temp_cat_equiv values ('115','JO','Jordania')
insert into #temp_cat_equiv values ('116','QA','Katar')
insert into #temp_cat_equiv values ('117','KZ','Kazajistan')
insert into #temp_cat_equiv values ('118','KE','Kenya')
insert into #temp_cat_equiv values ('119','KG','Kirguistan')
insert into #temp_cat_equiv values ('120','KI','Kiribati')
insert into #temp_cat_equiv values ('121','KW','Kuwait')
insert into #temp_cat_equiv values ('122','SY','La Republica arabe de Siria')
insert into #temp_cat_equiv values ('123','KR','La Republica de Corea del Sur')
insert into #temp_cat_equiv values ('124','CD','La Republica Democratica del Congo (Zaire)')
insert into #temp_cat_equiv values ('125','KP','La Republica Democratica Popular de Corea')
insert into #temp_cat_equiv values ('126','LA','La Republica Democratica Popular Lao')
insert into #temp_cat_equiv values ('127','UM','Las Islas de Ultramar Menores de Estados Unidos')
insert into #temp_cat_equiv values ('128','TC','Las Islas Turcas y Caicos')
insert into #temp_cat_equiv values ('129','LS','Lesotho')
insert into #temp_cat_equiv values ('130','LV','Letonia')
insert into #temp_cat_equiv values ('131','LB','Libano')
insert into #temp_cat_equiv values ('132','LR','Liberia')
insert into #temp_cat_equiv values ('133','LY','Libia')
insert into #temp_cat_equiv values ('134','LI','Liechtenstein')
insert into #temp_cat_equiv values ('135','LT','Lituania')
insert into #temp_cat_equiv values ('136','AE','Los Emiratos arabes Unidos')
insert into #temp_cat_equiv values ('137','NL','Los Paises Bajos (Holanda)')
insert into #temp_cat_equiv values ('138','LU','Luxemburgo')
insert into #temp_cat_equiv values ('139','MO','Macao')
insert into #temp_cat_equiv values ('140','MK','Macedonia (la antigua Republica Yugoslava de)')
insert into #temp_cat_equiv values ('141','MG','Madagascar')
insert into #temp_cat_equiv values ('142','MY','Malasia')
insert into #temp_cat_equiv values ('143','MW','Malawi')
insert into #temp_cat_equiv values ('144','MV','Maldivias')
insert into #temp_cat_equiv values ('145','ML','Mali')
insert into #temp_cat_equiv values ('146','MT','Malta')
insert into #temp_cat_equiv values ('147','MA','Marruecos')
insert into #temp_cat_equiv values ('148','MQ','Martinica')
insert into #temp_cat_equiv values ('149','MU','Mauricio')
insert into #temp_cat_equiv values ('150','MR','Mauritania')
insert into #temp_cat_equiv values ('151','YT','Mayotte')
insert into #temp_cat_equiv values ('152','MX','Mexico')
insert into #temp_cat_equiv values ('153','FM','Micronesia (los Estados Federados de)')
insert into #temp_cat_equiv values ('154','MD','Moldavia (la Republica de)')
insert into #temp_cat_equiv values ('155','MC','Monaco')
insert into #temp_cat_equiv values ('156','MN','Mongolia')
insert into #temp_cat_equiv values ('157','ME','Montenegro')
insert into #temp_cat_equiv values ('158','MS','Montserrat')
insert into #temp_cat_equiv values ('159','MZ','Mozambique')
insert into #temp_cat_equiv values ('160','NA','Namibia')
insert into #temp_cat_equiv values ('161','NR','Nauru')
insert into #temp_cat_equiv values ('162','NP','Nepal')
insert into #temp_cat_equiv values ('163','NI','Nicaragua')
insert into #temp_cat_equiv values ('164','NE','Niger (el)')
insert into #temp_cat_equiv values ('165','NG','Nigeria')
insert into #temp_cat_equiv values ('166','NU','Niue')
insert into #temp_cat_equiv values ('167','NO','Noruega')
insert into #temp_cat_equiv values ('168','NC','Nueva Caledonia')
insert into #temp_cat_equiv values ('169','NZ','Nueva Zelandia')
insert into #temp_cat_equiv values ('170','OM','Oman')
insert into #temp_cat_equiv values ('171','PK','Pakistan')
insert into #temp_cat_equiv values ('172','PW','Palaos')
insert into #temp_cat_equiv values ('173','PS','Palestina, Estado de')
insert into #temp_cat_equiv values ('174','PA','Panama')
insert into #temp_cat_equiv values ('175','PG','Papua Nueva Guinea')
insert into #temp_cat_equiv values ('176','PY','Paraguay')
insert into #temp_cat_equiv values ('177','PE','Peru')
insert into #temp_cat_equiv values ('178','PF','Polinesia Francesa')
insert into #temp_cat_equiv values ('179','PL','Polonia')
insert into #temp_cat_equiv values ('180','PT','Portugal')
insert into #temp_cat_equiv values ('181','PR','Puerto Rico')
insert into #temp_cat_equiv values ('182','GB','Reino Unido')
insert into #temp_cat_equiv values ('183','CF','Rep. Central Africana')
insert into #temp_cat_equiv values ('184','CZ','Republica Checa (la)')
insert into #temp_cat_equiv values ('185','GE','Republica de Georgia')
insert into #temp_cat_equiv values ('186','MM','Republica de la Union de Myanmar (Birmania)')
insert into #temp_cat_equiv values ('187','TD','Republica del Chad')
insert into #temp_cat_equiv values ('188','CG','Republica del Congo')
insert into #temp_cat_equiv values ('189','ST','Republica Democratica de Santo Tome y Principe')
insert into #temp_cat_equiv values ('190','TL','Republica Democratica de Timor Oriental')
insert into #temp_cat_equiv values ('191','DO','Republica Dominicana')
insert into #temp_cat_equiv values ('192','TZ','Republica Unida de Tanzania')
insert into #temp_cat_equiv values ('193','RW','Ruanda')
insert into #temp_cat_equiv values ('194','RO','Rumania')
insert into #temp_cat_equiv values ('195','RU','Rusia')
insert into #temp_cat_equiv values ('196','EH','Sahara Occidental')
insert into #temp_cat_equiv values ('197','AS','Samoa Americana')
insert into #temp_cat_equiv values ('198','WS','Samoa Oeste')
insert into #temp_cat_equiv values ('199','BL','San Bartolome')
insert into #temp_cat_equiv values ('200','KN','San Cristobal y Nieves')
insert into #temp_cat_equiv values ('201','SM','San Marino')
insert into #temp_cat_equiv values ('202','MF','San Martin (parte francesa)')
insert into #temp_cat_equiv values ('203','PM','San Pedro y Miquelon')
insert into #temp_cat_equiv values ('204','VC','San Vicente y las Granadinas')
insert into #temp_cat_equiv values ('205','SH','Santa Helena (Santa Helena, Ascension y Tristan de Acuña)')
insert into #temp_cat_equiv values ('206','LC','Santa Lucia')
insert into #temp_cat_equiv values ('207','SN','Senegal')
insert into #temp_cat_equiv values ('208','RS','Serbia')
insert into #temp_cat_equiv values ('209','SC','Seychelles')
insert into #temp_cat_equiv values ('210','SL','Sierra leona')
insert into #temp_cat_equiv values ('211','SG','Singapur')
insert into #temp_cat_equiv values ('212','SX','Sint Maarten (parte holandesa)')
insert into #temp_cat_equiv values ('213','SO','Somalia')
insert into #temp_cat_equiv values ('214','LK','Sri Lanka')
insert into #temp_cat_equiv values ('215','ZA','Sudafrica')
insert into #temp_cat_equiv values ('216','SD','Sudan')
insert into #temp_cat_equiv values ('217','SS','Sudan del Sur')
insert into #temp_cat_equiv values ('218','SE','Suecia')
insert into #temp_cat_equiv values ('219','CH','Suiza')
insert into #temp_cat_equiv values ('220','SR','Surinam')
insert into #temp_cat_equiv values ('221','SJ','Svalbard y Jan Mayen')
insert into #temp_cat_equiv values ('222','SZ','Swazilandia')
insert into #temp_cat_equiv values ('223','TH','Tailandia')
insert into #temp_cat_equiv values ('224','TW','Taiwan (Provincia de China)')
insert into #temp_cat_equiv values ('225','TJ','Tayikistan')
insert into #temp_cat_equiv values ('226','IO','Territorio Britanico del Oceano indico (el)')
insert into #temp_cat_equiv values ('227','CC','Territorio de las Islas Cocos (Keeling)')
insert into #temp_cat_equiv values ('228','TF','Territorios Australes Franceses (los)')
insert into #temp_cat_equiv values ('229','TG','Togo')
insert into #temp_cat_equiv values ('230','TK','Tokelau')
insert into #temp_cat_equiv values ('231','TO','Tonga')
insert into #temp_cat_equiv values ('232','TT','Trinidad y Tobago')
insert into #temp_cat_equiv values ('233','TN','Tunez')
insert into #temp_cat_equiv values ('234','TM','Turkmenistan')
insert into #temp_cat_equiv values ('235','TR','Turquia')
insert into #temp_cat_equiv values ('236','TV','Tuvalu')
insert into #temp_cat_equiv values ('237','UA','Ucrania')
insert into #temp_cat_equiv values ('238','UG','Uganda')
insert into #temp_cat_equiv values ('239','KM','Union de las Comoras (Comoras o Comores)')
insert into #temp_cat_equiv values ('240','UY','Uruguay')
insert into #temp_cat_equiv values ('241','UZ','Uzbekistan')
insert into #temp_cat_equiv values ('242','VU','Vanuatu')
insert into #temp_cat_equiv values ('243','VA','Vaticano Santa Sede [Estado de la Ciudad del Vaticano]')
insert into #temp_cat_equiv values ('244','VE','Venezuela, Republica Bolivariana de')
insert into #temp_cat_equiv values ('245','VN','Viet Nam')
insert into #temp_cat_equiv values ('246','WF','Wallis y Futuna')
insert into #temp_cat_equiv values ('247','YE','Yemen')
insert into #temp_cat_equiv values ('248','ZM','Zambia')
insert into #temp_cat_equiv values ('249','ZW','Zimbabue')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
select 'CL_PAIS_A6', c.codigo, tp.codigo, tp.abrv, 'V'
  from cobis..cl_catalogo c , #temp_cat_equiv tp
 where tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_pais')
   and upper(descrip) like upper(valor)
go
delete from #temp_cat_equiv
go
-- ------
-- TIPO DE MONEDA cobis..cl_moneda
delete from sb_equivalencias where eq_catalogo = 'CL_MONEDA'
insert into sb_equivalencias values ('CL_MONEDA','0' ,'MX', 'Pesos mexicanos','V')
insert into sb_equivalencias values ('CL_MONEDA','5' ,'UD', 'Unidades de Inversión','V')
insert into sb_equivalencias values ('CL_MONEDA','2' ,'US', 'Dólar estadounidense','V')
go

-- TIPO DE VIVIENDA
delete from sb_equivalencias where eq_catalogo = 'CL_TVIVIEN'
insert into sb_equivalencias values ('CL_TVIVIEN','001','1','Propietario','V')
insert into sb_equivalencias values ('CL_TVIVIEN','002','2','Renta','V')
insert into sb_equivalencias values ('CL_TVIVIEN','003','3','Pensión / Vive con familiares','V')
insert into sb_equivalencias values ('CL_TVIVIEN','004','2','Renta','V')
go

-- ESTADO CIVIL		cl_ecivil
delete from sb_equivalencias where eq_catalogo = 'CL_ECIVIL'
insert into sb_equivalencias values ('CL_ECIVIL','DI','D','Divorciado','V')
insert into sb_equivalencias values ('CL_ECIVIL','UN','F','Unión Libre','V')
insert into sb_equivalencias values ('CL_ECIVIL','CA','M','Casado','V')
insert into sb_equivalencias values ('CL_ECIVIL','SO','S','Soltero','V')
insert into sb_equivalencias values ('CL_ECIVIL','VI','W','Viudo','V')
go
-- TABLA ASCII --> (CHAR_a_Reemplazar, ValorAlfabético, ValorAlfaNumérico)
delete from sb_equivalencias where eq_catalogo = 'CHAR_ASCII'
-- eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado
insert into sb_equivalencias values('CHAR_ASCII','á','A','A','V')
insert into sb_equivalencias values('CHAR_ASCII','é','E','E','V')
insert into sb_equivalencias values('CHAR_ASCII','í','I','I','V')
insert into sb_equivalencias values('CHAR_ASCII','ó','O','O','V')
insert into sb_equivalencias values('CHAR_ASCII','ú','U','U','V')
insert into sb_equivalencias values('CHAR_ASCII','Á','A','A','V')
insert into sb_equivalencias values('CHAR_ASCII','É','E','E','V')
insert into sb_equivalencias values('CHAR_ASCII','Í','I','I','V')
insert into sb_equivalencias values('CHAR_ASCII','Ó','O','O','V')
insert into sb_equivalencias values('CHAR_ASCII','Ú','U','U','V')

insert into sb_equivalencias values('CHAR_ASCII','#','','N','V')
insert into sb_equivalencias values('CHAR_ASCII','$','','N','V')
insert into sb_equivalencias values('CHAR_ASCII','%','','N','V')
insert into sb_equivalencias values('CHAR_ASCII','>','','#','V')
insert into sb_equivalencias values('CHAR_ASCII','@','','N','V')
insert into sb_equivalencias values('CHAR_ASCII','ñ','N','N','V')
insert into sb_equivalencias values('CHAR_ASCII','Ñ','N','N','V')
insert into sb_equivalencias values('CHAR_ASCII',' ',' ',' ','V')

insert into sb_equivalencias values('CHAR_ASCII','A','A','A','V')
insert into sb_equivalencias values('CHAR_ASCII','B','B','B','V')
insert into sb_equivalencias values('CHAR_ASCII','C','C','C','V')
insert into sb_equivalencias values('CHAR_ASCII','D','D','D','V')
insert into sb_equivalencias values('CHAR_ASCII','E','E','E','V')
insert into sb_equivalencias values('CHAR_ASCII','F','F','F','V')
insert into sb_equivalencias values('CHAR_ASCII','G','G','G','V')
insert into sb_equivalencias values('CHAR_ASCII','H','H','H','V')
insert into sb_equivalencias values('CHAR_ASCII','I','I','I','V')
insert into sb_equivalencias values('CHAR_ASCII','J','J','J','V')
insert into sb_equivalencias values('CHAR_ASCII','K','K','K','V')
insert into sb_equivalencias values('CHAR_ASCII','L','L','L','V')
insert into sb_equivalencias values('CHAR_ASCII','M','M','M','V')
insert into sb_equivalencias values('CHAR_ASCII','N','N','N','V')
insert into sb_equivalencias values('CHAR_ASCII','O','O','O','V')
insert into sb_equivalencias values('CHAR_ASCII','P','P','P','V')
insert into sb_equivalencias values('CHAR_ASCII','Q','Q','Q','V')
insert into sb_equivalencias values('CHAR_ASCII','R','R','R','V')
insert into sb_equivalencias values('CHAR_ASCII','S','S','S','V')
insert into sb_equivalencias values('CHAR_ASCII','T','T','T','V')
insert into sb_equivalencias values('CHAR_ASCII','U','U','U','V')
insert into sb_equivalencias values('CHAR_ASCII','V','V','V','V')
insert into sb_equivalencias values('CHAR_ASCII','W','W','W','V')
insert into sb_equivalencias values('CHAR_ASCII','X','X','X','V')
insert into sb_equivalencias values('CHAR_ASCII','Y','Y','Y','V')
insert into sb_equivalencias values('CHAR_ASCII','Z','Z','Z','V')

insert into sb_equivalencias values('CHAR_ASCII','a','A','A','V')
insert into sb_equivalencias values('CHAR_ASCII','b','B','B','V')
insert into sb_equivalencias values('CHAR_ASCII','c','C','C','V')
insert into sb_equivalencias values('CHAR_ASCII','d','D','D','V')
insert into sb_equivalencias values('CHAR_ASCII','e','E','E','V')
insert into sb_equivalencias values('CHAR_ASCII','f','F','F','V')
insert into sb_equivalencias values('CHAR_ASCII','g','G','G','V')
insert into sb_equivalencias values('CHAR_ASCII','h','H','H','V')
insert into sb_equivalencias values('CHAR_ASCII','i','I','I','V')
insert into sb_equivalencias values('CHAR_ASCII','j','J','J','V')
insert into sb_equivalencias values('CHAR_ASCII','k','K','K','V')
insert into sb_equivalencias values('CHAR_ASCII','l','L','L','V')
insert into sb_equivalencias values('CHAR_ASCII','m','M','M','V')
insert into sb_equivalencias values('CHAR_ASCII','n','N','N','V')
insert into sb_equivalencias values('CHAR_ASCII','o','O','O','V')
insert into sb_equivalencias values('CHAR_ASCII','p','P','P','V')
insert into sb_equivalencias values('CHAR_ASCII','q','Q','Q','V')
insert into sb_equivalencias values('CHAR_ASCII','r','R','R','V')
insert into sb_equivalencias values('CHAR_ASCII','s','S','S','V')
insert into sb_equivalencias values('CHAR_ASCII','t','T','T','V')
insert into sb_equivalencias values('CHAR_ASCII','u','U','U','V')
insert into sb_equivalencias values('CHAR_ASCII','v','V','V','V')
insert into sb_equivalencias values('CHAR_ASCII','w','W','W','V')
insert into sb_equivalencias values('CHAR_ASCII','x','X','X','V')
insert into sb_equivalencias values('CHAR_ASCII','y','Y','Y','V')
insert into sb_equivalencias values('CHAR_ASCII','z','Z','Z','V')

insert into sb_equivalencias values('CHAR_ASCII','0','','0','V')
insert into sb_equivalencias values('CHAR_ASCII','1','','1','V')
insert into sb_equivalencias values('CHAR_ASCII','2','','2','V')
insert into sb_equivalencias values('CHAR_ASCII','3','','3','V')
insert into sb_equivalencias values('CHAR_ASCII','4','','4','V')
insert into sb_equivalencias values('CHAR_ASCII','5','','5','V')
insert into sb_equivalencias values('CHAR_ASCII','6','','6','V')
insert into sb_equivalencias values('CHAR_ASCII','7','','7','V')
insert into sb_equivalencias values('CHAR_ASCII','8','','8','V')
insert into sb_equivalencias values('CHAR_ASCII','9','','9','V')

go

-- ESTADO DE LA REPUBLICA
delete from sb_equivalencias where eq_catalogo = 'ESTADOS_A7'
insert into #temp_cat_equiv(codigo, descrip) values ('AGS','Aguascalientes')
insert into #temp_cat_equiv(codigo, descrip) values ('BCN','Baja California Norte')
insert into #temp_cat_equiv(codigo, descrip) values ('BCS','Baja California Sur')
insert into #temp_cat_equiv(codigo, descrip) values ('CAM','Campeche')
insert into #temp_cat_equiv(codigo, descrip) values ('CHS','Chiapas')
insert into #temp_cat_equiv(codigo, descrip) values ('CHI','Chihuahua')
insert into #temp_cat_equiv(codigo, descrip) values ('COA','Coahuila')
insert into #temp_cat_equiv(codigo, descrip) values ('COL','Colima')
insert into #temp_cat_equiv(codigo, descrip) values ('DF','Distrito Federal')
insert into #temp_cat_equiv(codigo, descrip) values ('DGO','Durango')
insert into #temp_cat_equiv(codigo, descrip) values ('EM','Estado de México')
insert into #temp_cat_equiv(codigo, descrip) values ('GTO','Guanajuato')
insert into #temp_cat_equiv(codigo, descrip) values ('GRO','Guerrero')
insert into #temp_cat_equiv(codigo, descrip) values ('HGO','Hidalgo')
insert into #temp_cat_equiv(codigo, descrip) values ('JAL','Jalisco')
insert into #temp_cat_equiv(codigo, descrip) values ('MICH','Michoacán')
insert into #temp_cat_equiv(codigo, descrip) values ('MOR','Morelos')
insert into #temp_cat_equiv(codigo, descrip) values ('NAY','Nayarit')
insert into #temp_cat_equiv(codigo, descrip) values ('NL','Nuevo León')
insert into #temp_cat_equiv(codigo, descrip) values ('OAX','Oaxaca')
insert into #temp_cat_equiv(codigo, descrip) values ('PUE','Puebla')
insert into #temp_cat_equiv(codigo, descrip) values ('QRO','Querétaro')
insert into #temp_cat_equiv(codigo, descrip) values ('QR','Quintana Roo')
insert into #temp_cat_equiv(codigo, descrip) values ('SLP','San Luis Potosí')
insert into #temp_cat_equiv(codigo, descrip) values ('SIN','Sinaloa')
insert into #temp_cat_equiv(codigo, descrip) values ('SON','Sonora')
insert into #temp_cat_equiv(codigo, descrip) values ('TAB','Tabasco')
insert into #temp_cat_equiv(codigo, descrip) values ('TAM','Tamaulipas')
insert into #temp_cat_equiv(codigo, descrip) values ('TLA','Tlaxcala')
insert into #temp_cat_equiv(codigo, descrip) values ('VER','Veracruz')
insert into #temp_cat_equiv(codigo, descrip) values ('YUC','Yucatán')
insert into #temp_cat_equiv(codigo, descrip) values ('ZAC','Zacatecas')
   
insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
select 'ESTADOS_A7',pv_provincia, codigo, descrip, 'V'
  from cobis..cl_provincia, #temp_cat_equiv
where upper(descrip) like upper(pv_descripcion)
go
delete from #temp_cat_equiv
go

-- -------------
use cob_credito
go
-- -------------
delete from cr_corresp_sib where tabla = 'ca_forma_pago_mop'
go
insert into cr_corresp_sib values('UR','ca_forma_pago_mop','UR','Cuenta si informacion',null,null,null,null)
insert into cr_corresp_sib values('00','ca_forma_pago_mop','00','Muy reciente para ser calificada',-1,-1,null,null)
insert into cr_corresp_sib values('01','ca_forma_pago_mop','01','Cuenta al corriente',0,0,null,null)
insert into cr_corresp_sib values('02','ca_forma_pago_mop','02','Cuenta con atraso de 1 a 29',1,29,null,null)
insert into cr_corresp_sib values('03','ca_forma_pago_mop','03','Cuenta con atraso de 30 a 59',30,59,null,null)
insert into cr_corresp_sib values('04','ca_forma_pago_mop','04','Cuenta con atraso de 60 a 89',60,89,null,null)
insert into cr_corresp_sib values('05','ca_forma_pago_mop','05','Cuenta con atraso de 90 a 119',90,119,null,null)
insert into cr_corresp_sib values('06','ca_forma_pago_mop','06','Cuenta con atraso de 120 a 149',120,149,null,null)
insert into cr_corresp_sib values('07','ca_forma_pago_mop','07','Cuenta con atraso de 150 días hasta 12 meses',150,360,null,null)
insert into cr_corresp_sib values('96','ca_forma_pago_mop','96','Cuenta con atraso de más de 12 meses',361,1000,null,null)
insert into cr_corresp_sib values('97','ca_forma_pago_mop','97','Cuenta con deuda parcial o total sin recuperar',1001,2000,null,null)
insert into cr_corresp_sib values('98','ca_forma_pago_mop','97','Fraude cometido por el Cliente',2001,10000,null,null)
go


