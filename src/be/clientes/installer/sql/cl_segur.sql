
/*********************************************************************/
/*      Script de seguridades para CLIENTES                  */
/*********************************************************************/
use cobis
go

/************************************************************************/
/*                              ad_pro_rol                             */
/************************************************************************/

print '----->  ad_pro_rol'
go
if exists (select pr_rol from ad_pro_rol where pr_producto = 2 and pr_rol = 1)
    delete ad_pro_rol where pr_producto = 2 and pr_rol = 1
go
declare @w_moneda tinyint

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
insert into ad_pro_rol  (pr_rol, pr_producto, pr_tipo, pr_moneda,pr_fecha_crea, pr_autorizante, pr_estado,pr_fecha_ult_mod, pr_menu_inicial)
        values  (1, 2, 'R', @w_moneda, getdate(),1, 'V', getdate(), null)
go

/************************************************************************/
/*                              cl_pro_moneda                           */
/************************************************************************/
print '----->  cl_pro_moneda'
go
if exists (select pm_producto from cl_pro_moneda where pm_producto = 2)
    delete cl_pro_moneda where pm_producto = 2
go
declare @w_moneda tinyint

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
insert into cl_pro_moneda (pm_producto, pm_tipo, pm_moneda, pm_descripcion,pm_fecha_aper, pm_estado)
        values  (2, 'R', @w_moneda, 'CLIENTES',getdate(), 'V')
go

/************************************************************************/
/*                              ba_fecha_cierre                         */
/************************************************************************/
print '----->  Insercion de fecha de cierre'
go

if not exists (select * from ba_fecha_cierre where fc_producto = 2)
begin
    insert into ba_fecha_cierre values (2,getdate(),getdate())
end
go
/*****************************************************************************/
/*                      cl_ttransaccion                                      */
/*****************************************************************************/
print '-----> cl_ttransaccion'
go
if exists (select * from cl_ttransaccion
        where tn_trn_code between   100 and   199
           or tn_trn_code between  1000 and  1499
           or tn_trn_code in (1600 ,1601 ,1602,1603,1604,1605,1606,1607,1609 ,1615,1617,1618 ,1619,
                              1621 ,1700 ,1701,1702,1703,1704,1705,1706,1708, 1709, 1710, 1711, 1712,
                              3017,3022,18323,18324,
                              18325,29432,1635,1632,1626,2937,1629,2938,1610 ,1633,1630,1624,2935,
                              1627 ,1616 ,2936,1622,1628,1636,1625,1608,15188,1634,1631,1623,7067120 , 610,611,612)
        )
      delete cl_ttransaccion
       where tn_trn_code between   100 and   199
          or tn_trn_code between  1000 and  1499
          or tn_trn_code in (1600 ,1601 ,1602,1603,1604,1605,1606,1607,1609,1615,1617,1618 ,1619,
                             1621 ,1700 ,1701,1702,1703,1704,1705,1706,1708, 1709, 1710, 1711, 1712,
                             3017,3022,18323,18324,
                             18325,29432,1635,1632,1626,2937,1629,2938,1610,1633,1630,1624,2935,
                             1627 ,1616 ,2936,1622,1628,1636,1625,1608,15188,1634,1631,1623,7067120, 1718, 610,611,612)
go


insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (100,'INSERTAR RELACION CB','IRCNB ','INSERTA REGISTRO DE RELACION DE CLIENTE CON CNS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (101,'HISTORIA DE RELACION','HIRE  ','HISTORIA DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (102,'ACTUALIZACION DE INFORMACION LEGAL DE COMPANIA','ACIL  ','ACTUALIZACION DE INFORMACION LEGAL DE COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (103,'INSERCION DE PERSONA','INPE  ','INSERCION DE PERSONA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (104,'ACTUALIZACION DE PERSONA','CPE   ','ACTUALIZACION DE PERSONA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (105,'INSERCION DE COMPANIA','ICOM  ','INSERCION DE COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (106,'ACTUALIZACION DE COMPANIA','ACCO  ','ACTUALIZACION DE COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (107,'INSERCION DE GRUPO','INGR  ','INSERCION DE GRUPO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (108,'ACTUALIZACION DE GRUPO','ACGR  ','ACTUALIZACION DE GRUPO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (109,'INSERCION DE DIRECCION','INDI  ','INSERCION DE DIRECCION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (110,'ACTUALIZACION DE DIRECCION','ACDI  ','ACTUALIZACION DE DIRECCION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (111,'INSERCION DE TELEFONO DE ENTE','INTE  ','INSERCION DE TELEFONO DE ENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (112,'ACTUALIZACION DE TELEFONO DE ENTE','ACTE  ','ACTUALIZACION DE TELEFONO DE ENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (113,'INSERCION DE PROPIEDAD','INPR  ','INSERCION DE PROPIEDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (114,'ACTUALIZACION DE PROPIEDAD','ACPR  ','ACTUALIZACION DE PROPIEDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (115,'INSERCION DE REFERENCIA','INRF  ','INSERCION DE REFERENCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (116,'ACTUALIZACION DE REFERENCIAS','ACTR  ','ACTUALIZACIN DE REFERENCIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (117,'INSERCION DE INSTANCIA DE RELACION','ININ  ','INSERCION DE INSTANCIA DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (118,'ELIMINACION DE INSTANCIA DE RELACION','ELIN  ','ELIMINACION DE INSTANCIA DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (119,'SEARCH DE MALA REFERENCIA','SRMR  ','SEARCH DE MALA REFERENCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (120,'QUERY DE MALA REFERENCIA','QRMR  ','QUERY DE MALA REFERENCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (121,'ELIMINACION DE OBJETO TEMPORAL','ELOT  ','ELIMINACION DE OBJETO SOCIAL DE COMPANIA TEMPORAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (122,'SEARCH DE OBJETO SOCIAL','SROB  ','SEARCH DE OBJETO SOCIAL DE COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (123,'INSERCION DE PERFIL','INPF  ','INSERCION DE PERFIL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (124,'ACTUALIZACION DE PERFIL','ACPF  ','ACTUALIZACION DE PERFIL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (125,'SEARCH DE PERFIL','SRPI  ','SEARCH DE PERFIL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (126,'HELP DE PERFIL','HPPF  ','HELP DE PERFIL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (127,'QUERY DE PERFIL','QRPF  ','QUERY DE PERFIL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (128,'INSERCION DE PLAN','INPL  ','INSERCION DE PLAN PREDEFINIDO PARA CLIENTES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (129,'ACTUALIZACION DE PLAN','ACPL  ','ACTUALIZACION DE PLAN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (130,'ELIMINACION DE PLAN','ELPL  ','ELIMINACION DE PLAN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (131,'SEARCH DE PLAN','SRPL  ','SEARCH DE PLAN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (132,'QUERY DE PERSONA','QRPE  ','QUERY DE PERSONA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (133,'HELP DE PERSONA','HEPP  ','HELP DE PERSONA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (134,'SEARCH DE PROPIEDAD','SRPR  ','SEARCH DE PROPIEDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (135,'QUERY DE PROPIEDAD','QRPR  ','QUERY DE PROPIEDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (136,'SEARCH DE REFERENCIA PERSONAL','SRRF  ','SEARCH DE REFERENCIA PERSONAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (137,'QUERY DE REFERENCIA PERSONAL','QRRF  ','QUERY DE REFERENCIA PERSONAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (138,'QUERY DE RELACION','QRRE  ','QUERY DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (139,'HELP DE RELACION','HLRE  ','HELP DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (140,'CONSULTA DE RELACION','CONR  ','CONSULTA DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (141,'QUERY DE SECTOR','QRST  ','QUERY DE SECTOR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (142,'SEARCH DE SECTOR','SRSE  ','SEARCH DE SECTOR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (143,'HELP DE SECTOR','HPSE  ','HELP DE SECTOR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (144,'SEARCH DE TIPO DE BALANCE','SETB  ','SEARCH DE TIPO DE BALANCE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (145,'QUERY DE TIPO DE BALANCE','QRTB  ','QUERY DE TIPO DE BALANCE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (146,'HELP DE TIPO DE BALANCE','HPTB  ','HELP DE TIPO DE BALANCE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (147,'SEARCH DE TELEFONO DE ENTE','SETE  ','SEARCH DE TELEFONO DE ENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (148,'ELIMINACION DE TELEFONO DE ENTE','ELTE  ','ELIMINACION DE TELEFONO DE ENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (149,'SEARCH DE TIPO DE PLAN','SETP  ','SEARCH DE TIPO DE PLAN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (150,'CONSULTA GENERAL DE GRUPO','CONG  ','CONSULTA GENERAL DE GRUPO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (151,'INSERCION DE SUBTIPO MERCADO OBJETIVO','INSUMO','INSERCION DE SUBTIPO MERCADO OBJETIVO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (152,'ACTUALIZACION DE SUBTIPO MERCADO OBJETIVO','ACSUMO','ACTUALIZACION DE SUBTIPO MERCADO OBJETIVO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (153,'ELIMINACION DE SUBTIPO MERCADO OBJETIVO','ELSUMO','ELIMINACION DE SUBTIPO MERCADO OBJETIVO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (154,'CONSULTA DE SUBTIPO MERCADO OBJETIVO','COSUMO','CONSULTA DE SUBTIPO MERCADO OBJETIVO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (155,'AYUDA DE SUBTIPO MERCADO OBJETIVO','HESUMO','HELP DE SUBTIPO MERCADO OBJETIVO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (156,'INSERCION ORIGEN DE FONDOS','INSORF','INSERCION ORIGEN DE FONDOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (157,'ACTUALIZACION ORIGEN DE FONDOS','ACTORF','ACTUALIZACION ORIGEN DE FONDOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (158,'ELIMINACION ORIGEN DE FONDOS','ELNORF','ELIMINACION ORIGEN DE FONDOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (159,'BUSQUEDA ORIGEN DE FONDOS','BUSORF','BUSQUEDA ORIGEN DE FONDOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (160,'CONSULTA ORIGEN DE FONDOS','CONORF','CONSULTA ORIGEN DE FONDOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (161,'AYUDA ORIGEN DE FONDOS','AYORFO','AYUDA ORIGEN DE FONDOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (162,'B?queda de Parametrizaci=n Solicitud Productos','162   ','B?queda de Parametrizaci=n Solicitud Productos')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (163,'Transmisi=n de Parametrizaci=n Solicitud Productos','163   ','Transmisi=n de Parametrizaci=n Solicitud Productos')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (164,'Impresi=n de Solicitud de Productos Bancarios','164   ','Impresi=n de Solicitud de Productos Bancarios')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (165,'Administraci=n\Parametrizaci=n Solicitud Prod. Bancari','161   ','Administraci=n\Parametrizaci=n Solicitud Prod. Bancari')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (166,'ACTUALIZACION DE INSTANCIA DE RELACION','AIRE  ','ACTUALIZACION DE INSTANCIA DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (167,'ACTUALIZAR RELACION CB','ARCNB ','ACTUALIZA REGISTRO DE RELACION ENTRE CLIENTES Y CNS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (168,'BUSQUEDA CAMBIOS REG FISCAL CLIENTE','BCRF  ','BUSQUEDA CAMBIOS REG FISCAL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (169,'CREACION DE INDICADORES TRIBUTARIOS','CDIT  ','CREACION DE INDICADORES TRIBUTARIOS DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (170,'ACTUALIZACION DE INDICADORES TRIBUTARIOS','ADIT  ','ACTUALIZACION DE INDICADORES TRIBUTARIOS DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (171,'QUERY DE INDICADORES TRIBUTARIOS','QDIT  ','QUERY DE INDICADORES TRIBUTARIOS DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (172,'ELIMINAR RELACION CB','ERCNB ','ELIMINA REGISTRO DE RELACION DE CLIENTE CON CNS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (173,'INSERCION DE CASILLA','INCA  ','INSERCION DE CASILLA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (174,'ACTUALIZACION DE CASILLA','ACCA  ','ACTUALIZACION DE CASILLA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (175,'CONSULTA ENTE INFORMACION INCOMPLETA','175   ','CONSULTA ENTE INFORMACION INCOMPLETA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (176,'SEARCH ENTE INFORMACION INCOMPLETA','CEIE  ','SEARCH ENTE INFORMACION INCOMPLETA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (177,'INSERCION DE REFERENCIA PERSONAL','INRP  ','INSERCION DE REFERENCIA PERSONAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (178,'ACTUALIZACION DE REFERENCIA PERSONAL','ACRP  ','ACTUALIZACION DE REFERENCIA PERSONAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (179,'ELIMINACION DE REFERENCIA','ELRE  ','ELIMINACION DE REFERENCIA ECONOMICA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (180,'CONSULTA DE REFERENCIAS','CORE  ','CONSULTA DE REFERENCIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (181,'INSERCION DE EMPLEO','INEM  ','INSERCION DE EMPLEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (182,'ACTUALIZACION DE EMPLEO','ACEM  ','ACTUALIZACION DE EMPLEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (183,'QUERY DE REFERENCIA','QRFR  ','QUERY DE REFERENCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (184,'INSERCION TRASLADO ALERTAS ENTRE OFICIALES','ITAEO ','INSERCION TRASLADO ALERTAS ENTYRE OFICIALES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (185,'BUSQUEDA DE ALERTAS A TRASLADAR','BDAAT ','BUSQUEDA DE ALERTAS A TRASLADAR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (186,'ACTUALIZACION INFORMACION CRITICA DE CLIENTES','ACICC ','ACTUALIZACION A INFORMACION CRITICA DE CLIENTES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (187,'QUERY DE INFORMACION CRITICA DE CLIENTES','QICC  ','QUERY DE INFORMACION CRITICA DE CLIENTES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (188,'CONSULTA PROMEDIOS POR PRODUCTO','COPP  ','CONSULTA PROMEDIOS POR PRODUCTO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (189,'INSERCION PROMEDIOS POR PRODUCTO','IPPP  ','INSERCION PROMEDIOS POR PRODUCTO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (190,'ACTUALIZACION PROMEDIOS POR PRODUCTO','ACPP  ','ACTUALIZACION PROMEDIOS POR PRODUCTO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (191,'ELIMINACION PROMEDIOS POR PRODUCTO','ELPP  ','ELIMINACION PROMEDIOS POR PRODUCTO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (192,'ELIMINACION DE PERSONA','ELPERS','ELIMINACION DE PERSONA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (193,'ELIMINACION DE COMPANIA','ELCIA ','ELIMINACION DE COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (194,'ELIMINACION DE GRUPO','ELGRP ','ELIMINACION DE GRUPO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (195,'AUTORIZACION MODIFICACION SEGMENTACION CLIENTE','AMSC  ','AUTORIZACION MODIFICACION SEGMENTACION CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (196,'Consulta Actualizacion Critica Clientes','196   ','Consulta Actualizacion Critica Clientes')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (197,'ELIMINACION DE PROPIEDAD','ELPR  ','ELIMINACION DE PROPIEDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (198,'TRANSACCION MENU APERTURA FUERA LINEA PERS','TRMFLP','TRANSACCION MENU PERTURA FUERA LINEA PERS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (199,'TRANSACCION MENU APERTURA FUERA LINEA COMP','TRMFLP','TRANSACCION MENU PERTURA FUERA LINEA COMP')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1000,'TRANSACCION MENU DE CONSULTA INDICADORES','TRMNCI','TRANSACCION MENU DE CONSULTA INDICADORES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1001,'TRANSACCION MENU DE CONSULTA BANCA DE PERSONAS','TRMNBP','TRANSACCION MENU DE CONSULTA BANCA DE PERSONAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1002,'TRANSACCION MENU DE CONSULTA BANCA DE EMPRESAS','TRMNBE','TRANSACCION MENU DE CONSULTA BANCA DE EMPRESAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1003,'TRANSACCION MENU DE CONSULTA GRUPOS ECONOMICOS','TRMNGE','TRANSACCION MENU DE CONSULTA GRUPOS ECONOMICOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1004,'TRANSACCION MENU DE CONSULTA INTEGRANTES GRUPOS ECONOMICOS','TRMCIG','TRANSACCION MENU DE CONSULTA INTEGRANTES GRUPOS ECONOMICOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1005,'TRANSACCION MENU DE CONSULTA GENERICA DE RELACIONES','TRMCGR','TRANSACCION MENU DE CONSULTA GENERICA DE RELACIONES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1006,'TRANSACCION MENU DE CONSULTA HISTOTICA DE RELACIONES','TRMCHR','TRANSACCION MENU DE CONSULTA HISTOTICA DE RELACIONES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1007,'TRANSACCION MENU DE CONSULTA CLIENTES Y PROSPECTOS','TRMCCP','TRANSACCION MENU DE CONSULTA CLIENTES Y PROSPECTOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1008,'BUSQUEDA DE OFICINA','BUOF  ','BUSQUEDA DE OFICINA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1009,'TRANSLADO DE OFICINAS','TRANOF','TRANSLADO DE OFICINAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1010,'INGRESO DE CARACTERISTICAS CLIENTE-PRODUCTO','ICCP  ','INGRESO DE CARACTERISTICAS CLIENTE-PRODUCTO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1011,'BUSCAR CARACTERISTICAS CLIENTE-PRODUCTO','BCCP  ','BUSCAR CARACTERISTICAS CLIENTE-PRODUCTO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1012,'INGRESO CARACTERISTICAS POR OBSEQUIO','ICPO  ','INGRESO CARACTERISTICAS POR OBSEQUIO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1013,'BUSCAR CARACTERISTICAS POR OBSEQUIO','BCPO  ','BUSCAR CARACTERISTICAS POR OBSEQUIO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1014,'EVALUAR ENTREGA OBSEQUIO','EEO   ','EVALUAR ENTREGA OBSEQUIO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1015,'CONSULTA TIPO DOC WS','QTDIWS','CONSULTA TIPO DOC WS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1016,'INSERTA PARAMETRIZACION CENTRALES DE RIESGO','INSPWS','INSERTA PARAMETRIZACION CENTRALES DE RIESGO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1017,'ACTUALIZACION PARAMETRIZACION CENTRALES DE RIESGO','ACPWS ','ACTUALIZACION PARAMETRIZACION CENTRALES DE RIESGO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1018,'CONSULTA PARAMETRIZACION CENTRALES DE RIESGO','CONPWS','CONSULTA PARAMETRIZACION CENTRALES DE RIESGO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1019,'CONSULTA DE CLIENTES CON CARTERA ACTIVA','CCCA  ','CONSULTA CLIENTES CARTERA ACTIVA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1020,'CONSULTA DATOS CLIENTE','CDC   ','CONSULTA DATOS CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1021,'CONSULTA RECHAZOS SINCRONIZACION','CRS   ','CONSULTA RECHAZOS SINCRONIZACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1022,'CONSULTA INFORMACION MODIFICADA WS CENTRAL RIESGO','CIMCR ','CONSULTA INFORMACION MODIFICADA WS CENTRAL RIESGO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1023,'ACTUALIZACION REGISTRO INFORMACION MODIFICADA WS CENTRAL RIESGO','AIMCR ','ACTUALIZACION REGISTRO INFORMACION MODIFICADA WS CENTRAL RIESGO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1024,'CONSULTA DATOS BASICOS CLIENTE WS CENTRAL RIESGO','CDBCR ','CONSULTA DATOS BASICOS CLIENTE WS CENTRAL RIESGO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1025,'CONSULTA DATOS BASICOS CLIENTE WS CENTRAL RIESGO 1','CDBCR1','CONSULTA DATOS BASICOS CLIENTE WS CENTRAL RIESGO 1')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1026,'BUSQ. POR CLIENTE','BCCNB ','BUSCA RELACIONES ENTRE CLIENTES Y CNBS POR CODIGO DE CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1027,'CONSULTA CLIENTES EXONERADOS HOMONIMIA','CCLEXH','CONSULTA CLIENTES EXONERADOS HOMONIMIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1028,'INSERCION CLIENTES EXONERADOS HOMONIMIA','CCLEXH','INSERCION CLIENTES EXONERADOS HOMONIMIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1029,'CONSULTA PARAMETIZACION TIPO DE PERSONA','CPTP  ','CONSULTA PARAMETIZACION TIPO DE PERSONA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1030,'INSERTA PARAMETRIZACION AREAS DE INFLUENCIA','IPAI  ','INSERTA PARAMETRIZACION AREAS DE INFLUENCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1031,'ELIMINA PARAMETRIZACION AREAS DE INFLUENCIA','EPAI  ','ELIMINA PARAMETRIZACION AREAS DE INFLUENCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1032,'INSERTA PARAMETRIZACION DE ACTIVIDAD','IPAC  ','INSERTA PARAMETRIZACION DE ACTIVIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1033,'ACTUALIZA PARAMETRIZACION DE ACTIVIDAD','APAC  ','ACTUALIZA PARAMETRIZACION DE ACTIVIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1034,'ELIMINA PARAMETRIZACION DE ACTIVIDAD','EPAC  ','ELIMINA PARAMETRIZACION DE ACTIVIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1035,'TRANSACCION DE CONSULTA DATACREDITO','TDCDC ','TRANSACCION DE CONSULTA DATACREDITO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1036,'INSERCION REFERENCIAS RESTRICTIVAS SARLAFT','IRRS  ','INSERCION REFERENCIAS RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1037,'MODIFICACION REFERENCIAS RESTRICTIVAS SARLAFT','MRRS  ','MODIFICACION REFERENCIAS RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1038,'ELIMINACION  REFERENCIAS RESTRICTIVAS SARLAFT','ERRS  ','ELIMINACION  REFERENCIAS RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1039,'SEARCH  REFERENCIAS RESTRICTIVAS SARLAFT','ERRS  ','SEARCH  REFERENCIAS RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1040,'QUERY  REFERENCIAS RESTRICTIVAS SARLAFT','QRRS  ','QUERY  REFERENCIAS RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1041,'INSERCION REFERENCIAS NO RESTRICTIVAS SARLAFT','IRNS  ','INSERCION REFERENCIAS NO RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1042,'MODIFICACION REFERENCIAS NO RESTRICTIVAS SARLAFT','MRNS  ','MODIFICACION REFERENCIAS NO RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1043,'ELIMINACION  REFERENCIAS NO RESTRICTIVAS SARLAFT','ERNS  ','ELIMINACION  REFERENCIAS NO RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1044,'SEARCH  REFERENCIAS NO RESTRICTIVAS SARLAFT','ERNS  ','SEARCH  REFERENCIAS NO RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1045,'QUERY  REFERENCIAS NO RESTRICTIVAS SARLAFT','QRNS  ','QUERY  REFERENCIAS NO RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1046,'AUTORIZACION APROBACION  NR SARLAFT','IAPNR ','AUTORIZACION APROBACION  NO RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1047,'RECHAZO APROBACION  NR SARLAFT','MAPNR ','RECHAZO APROBACION  NO RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1048,'IMPRESION APROBACION  NR SARLAFT','EAPNR ','IMPRESION APROBACION  NO RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1049,'SEARCH  APROBACION  NR SARLAFT','EAPNR ','SEARCH  APROBACION  NO RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1050,'QUERY  APROBACION  NR SARLAFT','QAPNR ','QUERY  APROBACION  NO RESTRICTIVAS SARLAFT')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1051,'BUSQ. OFICINAS','BOCNB ','LISTA LAS OFICINAS QUE NO HAN SIDO ASOCIADAS AUN A UNA RELACION CLIENTE - CB')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1052,'VALIDAR OCURRENCIAS','VOCNB ','VALIDA LA RELACION / OCURRENCIA DE UN CLIENTE CON UN CB')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1053,'CONSULTAR NOMBRE OFICINA','CNOCNB','RETORNA EL NOMBRE DE LA OFICINA A VALIDAR, VERIFICA SI CUMPLE CON LOS REQ PARA SER ASIGNADA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1054,'Clientes/Operaciones Especiales/Rel. Clte-CNB/Buscar','CORB  ','Clientes/Operaciones Especiales/Rel. Clte-CB/Buscar')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1055,'Clientes/Operaciones Especiales/Rel. Clte-CNB/Eliminar','CORE  ','Clientes/Operaciones Especiales/Rel. Clte-CB/Eliminar')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1056,'Clientes/Operaciones Especiales/Rel. Clte-CNB/Habilitar','CORH  ','Clientes/Operaciones Especiales/Rel. Clte-CB/Habilitar')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1057,'Clientes/Operaciones Especiales/Rel. Clte-CNB/Transmitir','CORT  ','Clientes/Operaciones Especiales/Rel. Clte-CB/Transmitir')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1058,'Clientes/Operaciones Especiales/Rel. Clte-CNB/Siguiente','CORS  ','Clientes/Operaciones Especiales/Rel. Clte-CB/Siguiente')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1059,'Clientes/Operaciones Especiales/Rel. Clte-CNB/','COR   ','Clientes/Operaciones Especiales/Rel. Clte-CB/')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1060,'COPIA DE INFORMACION DE TRAMA XML A TEMPORALES','1060  ','COPIA DE INFORMACION DE TRAMA XML A TEMPORALES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1061,'CONSULTA DE TEMPORALES CON INFORMACION EXTERNA','1061  ','CONSULTA DE TEMPORALES CON INFORMACION EXTERNA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1062,'COPIA DE INFORMACION TRAMA XML A TEMP CIFIN','1062  ','COPIA DE INFORMACION TRAMA XML A TEMPORALES CIFIN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1063,'CONSULTA DE INFO EXTERNA CIFIN','1063  ','CONSULTA DE INFORMACION EXTERNA CIFIN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1064,'CONSULTA DE RELACIONES PARA VALIDACION','COREVA','CONSULTA DE RELACIONES PARA VALIDACION CON CENTRALES DE RIESGO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1065,'CONSULTA DE TAREAS','CONTAR','CONSULTA DE TAREAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1066,'INSERCION PARAMETRIZACION REFERENCIACION','INSPRE','INSERCION PARAMETRIZACION REFERENCIACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1067,'ACTUALIZACION PARAMETRIZACION REFERENCIACION','ACTPRE','ACTUALIZACION PARAMETRIZACION REFERENCIACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1068,'CONSULTA PARAMETRIZACION REFERENCIACION','CONPRE','CONSULTA PARAMETRIZACION REFERENCIACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1069,'AYUDA PARAMETRIZACION REFERENCIACION','INSVIA','AYUDA PARAMETRIZACION REFERENCIACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1070,'INSERCION PARAMETRIZACION VIABILIDAD','HELVIA','INSERCION PARAMETRIZACION VIABILIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1071,'ACTUALIZACION PARAMETRIZACION VIABILIDAD','ACTVIA','ACTUALIZACION PARAMETRIZACION VIABILIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1072,'CONSULTA PARAMETRIZACION VIABILIDAD','CONVIA','CONSULTA PARAMETRIZACION VIABILIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1073,'AYUDA PARAMETRIZACION VIABILIDAD','HELVIA','AYUDA PARAMETRIZACION VIABILIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1074,'CONSULTA DATOS REFERENCIACION SERVICIO','SERREF','CONSULTA DATOS REFERENCIACION SERVICIO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1075,'ALERTAS DE TAREAS PENDIENTES','ALETAR','ALERTAS DE TAREAS PENDIENTES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1083,'ALMACENAMIENTO DE TRAMA XML','1083  ','ALMACENAMIENTO TRAMA XML DESDE CONECTOR CIS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1100,'EXENCION REPORTE SIPLA','EXRESI','EXENCION REPORTE SIPLA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1101,'EXENCION 31000','EX310 ','EXENCION 31000')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1102,'CONSULTA EN LINEA MASIVA CENTRALIZADA','COLIMC','CONSULTA EN LINEA MASIVA CENTRALIZADA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1103,'CONSULTA REVERSO EMBARGOS','COREEM','CONSULTA REVERSO EMBARGOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1104,'INSERCION REVERSO EMBARGOS','INREEM','INSERCION REVERSO EMBARGOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1105,'SEARCH ORIGEN DE FONDOS','SORFON','SEARCH ORIGEN DE FONDOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1106,'BUSQUEDA ORIGEN DE FONDOS','BORFON','BUSQUEDA ORIGEN DE FONDOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1108,'CONSULTA PRODUCTOS ENTRE CLIENTES A TRASLADAR','CPCLI ','CONSULTA PRODUCTOS ENTRE CLIENTES A TRASLADAR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1109,'TRASLADA PRODUCTOS ENTRE CLIENTES','TPCLI ','TRASLADA PRODUCTOS ENTRE CLIENTES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1110,'CONSULTA DE TIPOS DE DOCUMENTOS DE CLIENTES','CTDC  ','CONSULTA DE TIPOS DE DOCUMENTOS DE CLIENTES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1111,'ELIMINACION DE TIPOS DE DOCUMENTOS','ETD   ','ELIMINACION DE TIPOS DE DOCUMENTOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1112,'ACTUALIZACION DE TIPOS DE DOCUMENTOS','ATD   ','ACTUALIZACION DE TIPOS DE DOCUMENTOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1113,'INSERCION DE TIPOS DE DOCUMENTOS','ITD   ','INSERCION DE TIPOS DE DOCUMENTOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1115,'CONSULTA TIPOS DE DOCUMENTOS','CTDOC ','CONSULTA TIPOS DE DOCUMENTOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1116,'VALIDA DOCUMENTOS','VALDOC','VALIDA DOCUMENTOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1117,'MANTENIMIENTO PARAMETROS CATEGORIA CLIENTES VIP','CAVIP ','MANTENIMIENTO PARAMETROS CATEGORIA CLIENTES VIP')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1118,'PARAMETRIZACION CATEGORIZACION CLIENTES VIP','MEVIP ','PARAMETRIZACION CATEGORIZACION CLIENTES VIP')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1119,'INSERTAR PARAMETRIZACION CATEG CLIENTES VIP','IPVIP ','INSERTAR PARAMETRIZACION CATEG CLIENTES VIP')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1120,'CONSULTAR PARAMETRIZACION CATEG. ASOCIACION DE ACTIVIDAD','MAA   ','CONSULTAR PARAMETRIZACION CATEG. ASOCIACION DE ACTIVIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1121,'INSERTAR PARAMETRIZACION CATEG. ASOCIACION DE ACTIVIDAD','MAA   ','INSERTAR PARAMETRIZACION CATEG. ASOCIACION DE ACTIVIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1122,'ELIMINAR PARAMETRIZACION CATEG. ASOCIACION DE ACTIVIDAD','MAA   ','ELIMINAR PARAMETRIZACION CATEG. ASOCIACION DE ACTIVIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1123,'VALIDACION DE PARAMETRIZACION CATEG. ASOCIACION DE ACTIVIDAD','MAA   ','VALIDACION DE PARAMETRIZACION CATEG. ASOCIACION DE ACTIVIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1124,'MENU PARAMETROS DE LA ASOCIACION DE ACTIVIDAD','MAA   ','MANTENIMIENTO PARAMETROS DE LA ASOCIACION DE ACTIVIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1128,'ELIMINACION DE CASILLA','ELCS  ','ELIMINACION DE CASILLA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1130,'ELIMINACION DE REFERENCIA PERSONAL','ELRP  ','ELIMINACION DE REFERENCIA PERSONAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1131,'INSERTAR PARAMETRIZACION BLOQUEO','IPB   ','INSERTAR PARAMETRIZACION BLOQUEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1132,'ACTUALIZAR PARAMETRIZACION BLOQUEO','APB   ','ACTUALIZAR PARAMETRIZACION BLOQUEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1133,'CONSULTAR PARAMETRIZACION BLOQUEO','CPB   ','CONSULTAR PARAMETRIZACION BLOQUEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1134,'ELIMINAR PARAMETRIZACION BLOQUEO','EPB   ','ELIMINAR PARAMETRIZACION BLOQUEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1137,'ELIMINACION DE RELACION','ELRL  ','ELIMINACION DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1138,'INSERCION DE RELACION','INRL  ','INSERCION DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1139,'ACTUALIZACION DE RELACION','ACRL  ','ACTUALIZACION DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1140,'CONSULTA DE OFICINAS POR CIUDAD','COXC  ','CONSULTA DE OFICINAS POR CIUDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1141,'CONSULTA DE FUNCIONARIOS POR OFICINA','CFXO  ','CONSULTA DE FUNCIONARIOS POR OFICINA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1142,'INSERCION DE TIPO DE BALANCE','INTB  ','INSERCION DE TIPO DE BALANCE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1143,'ACTUALIZACION DE TIPO DE BALANCE','ACTB  ','ACTUALIZACION DE TIPO DE BALANCE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1144,'ELIMINACION DE TIPO DE BALANCE','1144  ','ELIMINACION DE TIPO DE BALANCE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1145,'INSERCION DE TIPO DE PLAN','INTP  ','INSERCION DE TIPO DE PLAN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1146,'ACTUALIZACION DE TIPO DE PLAN','ACTP  ','ACTUALIZACION DE TIPO DE PLAN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1147,'ELIMINACION DE TIPO DE PLAN','ELTP  ','ELIMINACION DE TIPO DE PLAN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1148,'INSERCION DE MALA REFERENCIA','INMLR ','INSERCION DE MALA REFERENCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1149,'ELIMINACION DE MALA REFERENCIA','ELMLR ','ELIMINACION DE MALA REFERENCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1150,'INSERCION DE SECTOR','INSCT ','INSERCION DE SECTOR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1151,'ACTUALIZACION DE SECTOR','ACSCT ','ACTUALIZACION DE SECTOR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1152,'ELIMINACION DE SECTOR','ELSCT ','ELIMINACION DE SECTOR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1155,'INSERCION DE ESTATUTOS DE COMPANIA','INSTT ','INSERCION DE ESTATUTOS DE COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1156,'ELIMINACION DE ESTATUTOS DE COMPANIA','ELSTT ','ELIMINACION DE ESTATUTOS DE COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1157,'INSERCION DE OBJETO SOCIAL DE COMPANIA','INOSC ','INSERCION DE OBJETO SOCIAL DE COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1158,'ELIMINACION DE OBJETO SOCIAL DE COMPANIA','ELOSC ','ELIMINACION DE OBJETO SOCIAL DE COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1159,'CREACION DE BALANCE','CRBA  ','CREACION DE BALANCE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1160,'DESASIGNACION DE GRUPO','DEGRP ','DESASIGNACION DE GRUPO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1161,'INSERCION DE ATRIBUTOS DE INSTANCIA','INATIN','INSERCION DE ATRIBUTOS DE INSTANCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1162,'ELIMINACION DE ATRIBUTOS DE INSTANCIA','ELATIN','ELIMINACION DE ATRIBUTOS DE INSTANCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1163,'ACTUALIZACION DE ATRIBUTOS DE INSTANCIA','ACATIN','ACTUALIZACION DE ATRIBUTOS DE INSTANCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1164,'INSERCION DE ATRIBUTOS DE RELACION','INATRE','INSERCION DE ATRIBUTOS DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1165,'INSERCION DE ATRIBUTOS','INATR ','INSERCION DE ATRIBUTOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1166,'INSERCION DE BALANCE TEMPORAL','INBTMP','INSERCION DE BALANCE TEMPORAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1167,'CONSULTA DE OFICIALES DE CUENTA','COFCTA','CONSULTA DE OFICIALES DE CUENTA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1168,'CONSULTA DE CLIENTES POR CIUDAD','CCLCIU','CONSULTA DE CLIENTES POR CIUDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1169,'CONSULTA DE CLIENTES POR PARROQUIA','CCLPAR','CONSULTA DE CLIENTES POR PARROQUIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1170,'CONSULTA DE CLIENTES POR PROVINCIA','CCLPRV','CONSULTA DE CLIENTES POR PROVINCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1171,'CONSULTA DE CLIENTES POR PROVINCIA DE REGION NATURAL','CCLPRN','CONSULTA DE CLIENTES POR PROVINCIA DE REGION NATURAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1172,'CONSULTA DE CLIENTES POR PROVINCIA DE REGION OPERATIVA','CCLPRO','CONSULTA DE CLIENTES POR PROVINCIA DE REGION OPERATIVA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1173,'CONSULTA DE CLIENTES POR REGION NATURAL','CCLRN ','CONSULTA DE CLIENTES POR REGION NATURAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1174,'CONSULTA DE CLIENTES POR REGION OPERATIVA','CCLRO ','CONSULTA DE CLIENTES POR REGION OPERATIVA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1175,'CONSULTA DE CLIENTES POR REGION NATURAL/REGION OPERATIVA','CLRNRO','CONSULTA DE CLIENTES POR REGION NATURAL/REGION OPERATIVA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1176,'CONSULTA DE CUENTAS CORRIENTES Y AHORROS','COCCCA','CONSULTA DE CUENTAS CORRIENTES Y AHORROS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1177,'CONSULTA DE PERSONAS ASOCIADAS A COMPANIAS','CPEACO','CONSULTA DE PERSONAS ASOCIADAS A COMPANIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1178,'CONSULTA DE PERSONAS ASOCIADAS A GRUPOS','CPEAGR','CONSULTA DE PERSONAS ASOCIADAS A GRUPOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1179,'ROL DE PERSONA EN COMPANIA','RPECO ','ROL DE PERSONA EN COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1180,'INSERCION DE CUENTA','INCUE ','INSERCION DE CUENTA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1181,'CONSULTA DE CEDULA O RUC','1181  ','CONSULTA DE CEDULA O RUC')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1182,'CONSULTA CLIENTES','COCLI ','CONSULTA DE CLIENTES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1183,'INSERCION DE ESTATUTO TEMPORAL','INETMP','INSERCION DE ESTATUTO TEMPORAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1184,'CONSULTA ESPECIFICA DE GRUPO','QUGRP ','CONSULTA ESPECIFICA DE GRUPO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1185,'CONSULTA DE INFORMACION LEGAL','CINFLE','CONSULTA DE INFORMACION LEGAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1186,'CONSULTA ESPECIFICA DE INSTANCIAS','QUINS ','CONSULTA ESPECIFICA DE INSTANCIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1187,'INSERCION DE OBJETO SOCIAL TEMPORAL','INOTMP','INSERCION DE OBJETO SOCIAL TEMPORAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1188,'INSERCION DE PLAN','INPLAN','INSERCION DE PLAN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1189,'CONSULTA DE POSICION DEL CLIENTE','POSCLI','CONSULTA DE POSICION DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1190,'CONSULTA DEL NOMBRE DE UN CLIENTE','CNOM  ','CONSULTA DEL NOMBRE DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1191,'CONSULTA DE GRUPOS ECONOMICOS','COGRP ','CONSULTA DE GRUPOS ECONOMICOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1192,'CONSULTA DE DIRECCIONES POR CIUDAD','CDIR  ','CONSULTA DE DIRECCIONES POR CIUDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1194,'CONSULTA DE RELACIONES','COREL ','CONSULTA DE RELACIONES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1195,'CONSULTA DE PRODUCTOS POR CLIENTE','PROCLI','CONSULTA DE PRODUCTOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1196,'INSERCION DE TIPO DE PLAN TEMPORAL','ITPTMP','INSERCION DE TIPO DE PLAN TEMPORAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1197,'CONSULTA DE ATRIBUTOS DE INSTANCIA','COATIN','CONSULTA DE ATRIBUTOS DE INSTANCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1198,'CONSULTA ESPECIFICA DE ATRIBUTO DE INSTANCIA','QUATIN','CONSULTA ESPECIFICA DE ATRIBUTOS DE INSTANCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1199,'ACTUALIZACION DE ATRIBUTOS DE RELACION','ACATRE','ACTUALIZACION DE ATRIBUTOS DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1200,'ELIMINACION DE ATRIBUTOS DE RELACION','ELATRE','ELIMINACION DE ATRIBUTOS DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1201,'CONSULTA DE ATRIBUTOS DE RELACION','COATRE','CONSULTA DE ATRIBUTOS DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1202,'CONSULTA ESPECIFICA DE ATRIBUTOS DE RELACION','QUATRE','CONSULTA ESPECIFICA DE ATRIBUTOS DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1203,'AYUDA DE ATRIBUTOS DE RELACION','HEATRE','AYUDA DE ATRIBUTOS DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1204,'ACTUALIZACION DE ATRIBUTO','ACATR ','ACTUALIZACION DE ATRIBUTO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1205,'CONSULTA DE ATRIBUTOS DE UN PERFIL','CATPER','CONSULTA DE ATRIBUTOS DE UN PERFIL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1206,'INSERCION DE BANCOS','INBANC','INSERCION DE BANCOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1207,'ACTUALIZACION DE BANCOS','ACBANC','ACTUALIZACION DE BANCOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1208,'ELIMINACION DE BANCOS','ELBANC','ELIMINACION DE BANCOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1209,'CONSULTA DE BANCOS','COBANC','CONSULTA DE BANCOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1210,'CONSULTA ESPECIFICA DE BANCO','QUBANC','CONSULTA ESPECIFICA DE BANCO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1211,'AYUDA DE BANCO','HEBANC','AYUDA DE BANCOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1212,'ACTUALIZACION DE BALANCE','ACBAL ','ACTUALIZACION DE BALANCE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1213,'ELIMINACION DE BALANCE','ELBAL ','ELIMINACION DE BALANCE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1214,'CONSULTA DE BALANCE','COBAL ','CONSULTA DE BALANCE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1215,'CONSULTA DE CASILLA','COCAS ','CONSULTA DE CASILLA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1216,'CONSULTA ESPECIFICA DE CASILLA','QUCAS ','CONSULTA ESPECIFICA DE CASILLA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1218,'CONSULTA ESPECIFICA DE COMPANIA','QUCOM ','CONSULTA ESPECIFICA DE COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1219,'AYUDA DE COMPANIA','HECOMP','AYUDA DE COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1220,'ACTUALIZACION DE CUENTA','ACCUEN','ACTUALIZACION DE CUENTA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1221,'ELIMINACION DE CUENTA','ELCUEN','ELIMINACION DE CUENTA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1222,'CONSULTA DE CUENTA','COCUEN','CONSULTA DE CUENTA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1223,'CONSULTA ESPECIFICA DE CUENTA','QUCUEN','CONSULTA ESPECIFICA DE CUENTA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1224,'AYUDA DE CUENTA','HECUEN','AYUDA DE CUENTA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1225,'CONSULTA DE NOMBRE DEL CLIENTE','NOMCLI','CONSULTA DE NOMBRE DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1226,'ELIMINACION DE DIRECCION','ELDIR ','ELIMINACION DE DIRECCION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1227,'CONSULTA DE DIRECCIONES','CODIR ','CONSULTA DE DIRECCIONES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1228,'CONSULTA ESPECIFICA DE DIRECCION','QUDIR ','CONSULTA ESPECIFICA DE DIRECCIONES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1229,'AYUDA DE DIRECCION','HEDIR ','AYUDA DE DIRECCION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1230,'ELIMINACION DE EMPLEO','ELEMP ','ELIMINACION DE EMPLEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1231,'CONSULTA DE EMPLEOS','COEMP ','CONSULTA DE EMPLEOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1232,'CONSULTA ESPECIFICA DE EMPLEO','QUEMP ','CONSULTA ESPECIFICA DE EMPLEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1233,'ELIMINACION DE ESTATUTO TEMPORAL','EETTMP','ELIMINACION DE ESTATUTO TEMPORAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1234,'CONSULTA DE ESTATUTOS DE COMPANIA','COSTT ','CONSULTA DE ESTATUTOS DE COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1235,'CONSULTA DE MIEMBROS DE UN GRUPO','MIEGRP','CONSULTA DE MIEMBROS DE GRUPO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1236,'CONSULTA DE GRUPOS QUE SON COMPANIAS','GRPCIA','CONSULTA DE GRUPOS QUE SON COMPANIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1237,'CONSULTA DE PRODUCTOS CONTRATADOS POR UN GRUPO','PROGRP','PRODUCTOS CONTRATADOS POR GRUPO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1238,'AYUDA DE GRUPO','HEGRP ','AYUDA DE GRUPO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1239,'IMPRESION DE DATOS PERSONALES','IMPR  ','IMPRESION DE DATOS PERSONALES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1240,'INSERCION DE COMPANIAS SIN RUC','ICSR  ','INSERCION DE COMPANIAS SINRUC')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1241,'CONSULTA DE ENTES POR OFICINA','CEOF  ','CONSULTA DE ENTES POR OFICINA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1242,'CONSULTA DE ENTES POR PRODUCTO','CEPR  ','CONSULTA DE ENTES POR PRODUCTO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1243,'INSERCION DE SOCIEDAD DE HECHO','ISOH  ','INSERCION DE SOCIEDAD DE HECHO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1244,'ACTUALIZACION DE SOCIEDAD DE HECHO','ASOH  ','ACTUALIZACION DE SOCIEDAD DE HECHO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1245,'CONSULTA DE SOCIEDAD DE HECHO','CSOH  ','CONSULTA DE SOCIEDAD DE HECHO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1246,'HELP DE SOCIEDAD DE HECHO','HSOH  ','HELP DE SOCIEDAD DE HECHO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1247,'BUSQUEDAS DE SOCIEDADES DE HECHO POR CRITERIOS','BSOH  ','BUSQUEDAS DE SOCIEDADES DE HECHO POR CRITERIO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1248,'ELIMINACION DE ENTE','ELEN  ','ELIMINACION DE ENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1249,'ELIMINACION DE SOCIEDAD DE HECHO','ELSH  ','ELIMINACION DE SOCIEDAD DE HECHO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1250,'CONSULTA PARA TIPO DE BALANCES EXCEL','CBEX  ','CONSULTA PARA TIPO DE BALANCES EXCEL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1251,'CONSULTA DE PLAN DE CUENTAS DE BALANCES EXCEL','CBEX  ','CONSULTA DE CUENTAS DE A CUENTAS DE BALANCES EXCEL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1252,'CONSULTA DE VALORES PARA CUENTAS DE BALANCES EXCEL','CBEX  ','CONSULTA DE VALORES PARA CUENTAS DE BALANCES EXCEL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1253,'CONSULTA DE EMPRESAS QUE PERTENECEN A UN GRUPO','EMGR  ','CONSULTA DE EMPRESAS QUE PERTENECEN A UN GRUPO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1254,'CONSULTA DE EMPRESAS EN LAS QUE TRABAJA UNA PERSONA','EMPE  ','CONSULTA DE EMPRESAS EN LAS QUE TRABAJA UNA PERSONA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1255,'CONSULTA DE PERSONAS QUE TRABAJAN EN UNA EMPRESA','PEEM  ','CONSULTA DE PERSONAS QUE TRABAJAN EN UNA EMPRESA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1256,'CONSULTA DE DATOS DE COVINCO','SRCV  ','CONSULTA DE DATOS DE COVINCO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1257,'QUERY DE DATOS DE COVINCO','QRCV  ','QUERY DE DATOS DE COVINCO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1258,'INSERCION DE DATOS DE COVINCO','INCV  ','INSERCION DE DATOS DE COVINCO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1259,'ACTUALIZACION DE DATOS DE COVINCO','ACCV  ','ACTUALIZACION DE DATOS DE COVINCO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1260,'ELIMINACION DE DATOS DE COVINCO','ELCV  ','ELIMINACION DE DATOS DE COVINCO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1261,'CONSULTA DE DATOS DE NARCOTRAFICO','SRNF  ','CONSULTA DE DATOS DE NARCOTRAFICO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1262,'QUERY DE DATOS DE NARCOTRAFICO','QRNF  ','QUERY DE DATOS DE NARCOTRAFICO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1263,'INSERCION DE DATOS DE NARCOTRAFICO','INNF  ','INSERCION DE DATOS DE NARCOTRAFICO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1264,'ACTUALIZACION DE DATOS DE NARCOTRAFICO','ACNF  ','ACTUALIZACION DE DATOS DE NARCOTRAFICO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1265,'ELIMINACION DE DATOS DE NARCOTRAFICO','ELNF  ','ELIMINACION DE DATOS DE NARCOTRAFICO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1266,'CREACION RAPIDA DE PERSONAS','CRPE  ','CREACION RAPIDA DE PERSONAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1267,'ACTUALIZACION DE MALAS REFERENCIAS','AMRF  ','ACTUALIZACION DE MALAS REFERENCIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1268,'CONSULTA DE DATOS DE CIAS LIQUIDACION','CCLQ  ','CONSULTA DE DATOS DE CIAS LIQUIDACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1269,'QUERY DE DATOS DE CIAS LIQUIDACION','QRCL  ','QUERY DE DATOS DE CIAS LIQUIDACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1270,'INSERCION DE DATOS DE CIAS LIQUIDACION','INDL  ','INSERCION DE DATOS DE CIAS LIQUIDACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1271,'ACTUALIZACION DE DATOS DE CIAS LIQUIDACION','ACCQ  ','ACTUALIZACION DE DATOS DE CIAS LIQUIDACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1272,'ELIMINACION DE DATOS DE CIAS LIQUIDACION','ELCQ  ','ELIMINACION DE DATOS DE CIAS LIQUIDACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1273,'SUMA DE PROPIEDADES PARA BALANCE','SPBL  ','SUMA DE PROPIEDADES PARA BALANCE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1274,'CONSULTA DE ENTES POR OFICINA','ENOF  ','CONSULTA DE ENTES POR OFICINA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1275,'CONSULTA DE CLIENTES POR OFICINA','CLOF  ','CONSULTA DE CLIENTES POR OFICINA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1276,'CONSULTA DE CLIENTES POR PRODUCTO','CLPR  ','CONSULTA DE CLIENTES POR PRODUCTO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1277,'CONSULTA DE CLIENTES POR PRODUCTO DADA UNA OFICINA','CLPRO ','CONSULTA DE CLIENTES POR PRODUCTO DADA UNA OFICINA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1278,'CONSULTA DE DATOS DE REF. INHIBITORIAS','SRIH  ','CONSULTA DE DATOS DE REF. INHIBITORIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1279,'QUERY DE DATOS DE REF. INHIBITORIAS','QRIH  ','QUERY DE DATOS DE REF. INHIBITORIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1280,'INSERCION DE DATOS DE REF. INHIBITORIAS','INIH  ','INSERCION DE DATOS DE REF. INHIBITORIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1281,'ACTUALIZACION DE DATOS DE REF. INHIBITORIAS','ACIH  ','ACTUALIZACION DE DATOS DE REF. INHIBITORIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1282,'ELIMINACION DE DATOS DE REF. INHIBITORIAS','ELIH  ','ELIMINACION DE DATOS DE REF. INHIBITORIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1283,'CONSULTA DE DATOS DE REF. DE MERCADO','SRME  ','CONSULTA DE DATOS DE REF. DE MERCADO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1284,'QUERY DE DATOS DE REF. DE MERCADO','QRME  ','QUERY DE DATOS DE REF. DE MERCADO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1285,'INSERCION DE DATOS DE REF. DE MERCADO','INME  ','INSERCION DE DATOS DE MERCADO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1286,'ACTUALIZACION DE DATOS DE REF. DE MERCADO','ACME  ','ACTUALIZACION DE DATOS DE MERCADO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1287,'ELIMINACION DE DATOS DE MERCADO','ELME  ','ELIMINACION DE DATOS DE MERCADO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1288,'INSERCION DE CLIENTES TIPO PERSONA CON DATOS INCOMPLETOS','CLIDIN','INSERCION DE CLIENTES TIPO PERSONA CON DATOS INCOMPLETOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1289,'INSERCION DE CONTACTOS','INSCON','INSERCION DE CONTACTOS PARA COMPANIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1290,'ACTUALIZACION DE CONTACTOS','ACTCON','ACTUALIZACION DE CONTACTOS PARA COMPANIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1291,'ELIMINACION DE CONTACTOS','ELICON','ELIMINACION DE CONTACTOS PARA COMPANIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1292,'BUSQUEDA DE CONTACTOS','BUSCON','BUSQUEDA DE CONTACTOS PARA COMPANIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1293,'QUERY DE CONTACTOS','QUECON','QUERY DE CONTACTOS PARA COMPANIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1294,'CONSULTA CLIENTES POR SECTOR','CNCLSE','CONSULTA DE CLIENTES POR SECTOR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1295,'CONSULTA CLIENTES POR ACTIVIDAD','CNCLAC','CONSULTA DE CLIENTES POR ACTIVIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1296,'SEARCH CONSOLIDADO GRUPO ECONOMICO','SCGE  ','SEARCH CONSOLIDADO GRUPO ECONOMICO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1297,'CONSULTA CONSOLIDADO GRUPO ECONOMICO','CCGE  ','CONSULTA CONSOLIDADO GRUPO ECONOMICO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1298,'CONSULTA A ENTIDADES EXTERNAS','CEE   ','CONSULTA DE ENTIDADES EXTERNAS (CIFIN, DATACREDITO)')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1299,'CREACION RAPIDA DE COMPA?AS','CRCI  ','CREACION RAPIDA DE COMPA?AS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1300,'CONSULTA DE CIUDADES DE UN MISMO DEPARTAMENTO','CCXDEP','CONSULTA DE CIUDADES POR DEPARTAMENTO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1301,'INSERCION DE HIJOS DE UN CLIENTE','IHCL  ','INSERCION DE LOS HIJOS DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1302,'ACTUALIZACION DE HIJOS DE UN CLIENTE','AHCL  ','ACTUALIZACION DE LOS HIJOS DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1303,'BORRADO DE HIJOS DE UN CLIENTE','BHCL  ','BORRADO DE LOS HIJOS DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1304,'SEARCH DE HIJOS DE UN CLIENTE','SHCL  ','SEARCH DE LOS HIJOS DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1305,'QUERY DE HIJOS DE UN CLIENTE','QHCL  ','QUERY DE LOS HIJOS DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1306,'ACTUALIZACION DE PRESENTADO POR EN CLIENTE','APPC  ','ACTUALIZACION DEL CAMPO PRESENTADO POR (TRANSAC. ESPECIAL)')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1307,'INSERCION DE RELACIONES INTERNACIONALES','IRIC  ','INSERCION DE LAS RELACIONES INTERNACIONALES DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1308,'ELIMINACION DE RELACIONES INTERNACIONALES','ERIC  ','ELIMINACION DE LAS RELACIONES INTERNACIONALES DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1309,'ACTUALIZACION DE RELACIONES INTERNACIONALES','ARIC  ','ACTUALIZACION DE LAS RELACIONES INTERNACIONALES DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1310,'SEARCH DE RELACIONES INTERNACIONALES','SRIC  ','SEARCH DE LAS RELACIONES INTERNACIONALES DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1311,'CONSULTA DE RELACIONES INTERNACIONALES','CRIC  ','CONSULTA DE LAS RELACIONES INTERNACIONALES DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1312,'SEARCH DE RELACIONES LEGALES','SRLC  ','SEARCH DE LAS RELACIONES LEGALES DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1313,'QUERY DE RELACIONES LEGALES','QRLC  ','QUERY DE LAS RELACIONES LEGALES DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1314,'CONSULTA DE CLIENTES POR TIPO Y NUMERO DE DOC.','CCTN  ','CONSULTA DE CLIENTES POR TIPO Y NUMERO DE DOCUMENTO DE IDENTIFICACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1315,'HELP DE RELACIONES LEGALES','HRLC  ','HELP DE ATRIBUTOS DE LAS RELACIONES LEGALES DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1316,'ACTUALIZACION DE ASESOR COMERCIAL DE CLIENTES','AACC  ','ACTUALIZACION DE ASESOR COMERCIAL DE UN CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1317,'ASIGNAR MIEMBRO A GRUPOS ECONOMICOS','AMGE  ','ASIGNAR UN MIEMBRO A UNO O MAS GRUPOS ECONOMICOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1318,'CONSULTA DE PROSPECTOS POR OFICINA','CPOF  ','CONSULTA DE PROSPECTOS POR OFICINA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1319,'INSERTAR OTROS INGRESOS','INSOI ','INSERTAR OTROS INGRESOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1320,'ACTUALIZAR OTROS INGRESOS','UPDOI ','ACTUALIZAR OTROS INGRESOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1321,'CONSULTAR OTROS INGRESOS','CONOI ','CONSULTAR OTROS INGRESOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1322,'INSERTAR TABLAS MERCADEO','INSTM ','INSERTAR TABLAS MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1323,'ACTUALIZAR TABLAS MERCADEO','UPDTM ','ACTUALIZAR TABLAS MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1324,'CONSULTAR TABLAS MERCADEO','CONTM ','CONSULTAR TABLAS MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1325,'BUSQUEDA TABLAS MERCADEO','BUSTM ','BUSCAR TABLAS MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1326,'INSERTAR ATRIBUTOS MERCADEO','INSAM ','INSERTAR ATRIBUTOS MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1327,'ACTUALIZAR ATRIBUTOS MERCADEO','ACAME ','ACTUALIZAR ATRIBUTOS MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1328,'CONSULTA ATRIBUTOS MERCADEO','CONAM ','CONSULTA ATRIBUTOS MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1329,'CONSULTA ATRIBUTOS MERCADEO','CONAM ','CONSULTA ATRIBUTOS MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1330,'BORRAR ATRIBUTOS MERCADEO','DELAM ','BORRAR ATRIBUTOS MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1331,'ELIMINAR TABLA DE MERCADEO','ELTAM ','ELIMINAR TABLA DE MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1332,'INSERTAR DATOS DE MERCADEO','INDAM ','INSERTAR DATOS DE MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1333,'ACTUALIZAR DATOS DE MERCADEO','ACDAM ','ACTUALIZAR DATOS DE MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1334,'ELIMINAR DATOS DE MERCADEO','ELDAM ','ELIMINAR DATOS DE MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1335,'CONSULTA DATOS DE MERCADEO','CODAM ','CONSULTA DATOS DE MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1336,'CONSULTA DATOS DE MERCADEO','CODAM ','CONSULTA DATOS DE MERCADEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1338,'CONSULTA ALIANZAS','COAL  ','TRANSACCION PARA CONSULTA DE ALIANZAS DESDE FRONTEND')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1339,'INSERCION DE ALIANZAS','INAL  ','TRANSACCION PARA INSERTAR NUEVAS ALIANZAS DESDE FRONTEND')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1340,'CANCELACION ALIANZAS','CAAL  ','TRANSACCION PARA CANCELACION DE ALIANZAS DESDE FRONTEND')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1341,'CONSULTA CLIENTES ALIANZAS','CCAL  ','TRANSACCION PARA CONSULTA DE CLIENTES ASOCIADOS A ALIANZAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1342,'CONSULTA HISTORICO DE VINCULOS','CONHV ','CONSULTAR HISTORICO DE VINCULACION DE CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1343,'CONSULTA POSICION CLIENTE','CONPC ','CONSULTAR POSICION CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1344,'CONSULTA POSICION CLIENTE','CONPC ','CONSULTAR POSICION CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1345,'CONSULTA TELEFONOS CLIENTE','CONTC ','CONSULTAR TELEFONOS CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1346,'SEARCH RELACIONES LEGALES RL3 y RL4','RL3-4 ','SEARCH REL.LEGAL RL3y RL4')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1347,'VERIF.ACTUALIZACION DE INFORMACION LEGAL DE COMPANIA','ACIL  ','VERIF.ACTUALIZACION DE INFORMACION LEGAL DE COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1349,'VERIF.ACTUALIZACION DE INFORMACION LEGAL DE COMPANIA','ACIL  ','VERIF.ACTUALIZACION DE INFORMACION LEGAL DE COMPANIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1350,'VERIF.ACTUALIZACION DE REFERENCIA PERSONAL','ACRP  ','VERIF.ACTUALIZACION DE REFERENCIA PERSONAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1351,'VERIF.ACTUALIZACION DE CASILLA','ACCA  ','VERIF.ACTUALIZACION DE CASILLA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1352,'VERIF.ACTUALIZACION DE EMPLEO','ACEM  ','VERIF.ACTUALIZACION DE EMPLEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1353,'VERIF.ACTUALIZACION DE PROPIEDAD','ACPR  ','VERIF.ACTUALIZACION DE PROPIEDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1354,'VERIF.ACTUALIZACION DE CONTACTOS','ACTCON','VERIF.ACTUALIZACION DE CONTACTOS PARA COMPANIAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1355,'INSERCION DE REFERENCIAS ECONOMICAS','IREFEC','INSERCION DE REFERENCIAS ECONOMICAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1356,'ACTUALIZACION DE REFERENCIAS ECONOMICAS','AREFEC','ACTUALIZACION DE REFERENCIAS ECONOMICAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1357,'ELIMINACION DE REFERENCIAS ECONOMICAS','EREFEC','ELIMINACION DE REFERENCIAS ECONOMICAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1358,'INSERCION DE REFERENCIAS COMERCIALES','IREFCO','INSERCION DE REFERENCIAS COMERCIALES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1359,'ACTUALIZACION DE REFERENCIAS COMERCIALES','AREFCO','ACTUALIZACION DE REFERENCIAS COMERCIALES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1360,'ELIMINACION DE REFERENCIAS COMERCIALES','EREFCO','ELIMINACION DE REFERENCIAS COMERCIALES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1361,'INSERCION DE REFERENCIAS DE TARJETAS','IREFTA','INSERCION DE REFERENCIAS DE TARJETAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1362,'ACTUALIZACION DE REFERENCIAS DE TARJETAS','AREFTA','ACTUALIZACION DE REFERENCIAS DE TARJETAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1363,'ELIMINACION DE REFERENCIAS DE TARJETAS','EREFTA','ELIMINACION DE REFERENCIAS DE TARJETAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1364,'ACTUALIZACION DE REPORTADO SUPER BANCARIA','ARSB  ','ACTUALIZACION DEL CAMPO REPORTADO SUPER BANCARIA (TRANSAC. ESPECIAL)')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1365,'ASOCIACION CLIENTE/ALIANZAS','ASOCLI','ASOCIACION CLIENTE/ALIANZAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1367,'INSERCION DE INSTANCIA','INIS  ','INSERCION DE INSTANCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1368,'ELIMINACION DE INSTANCIA','ELIS  ','ELIMINACION DE INSTANCIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1369,'QUERY DE GENERICO RELACION','QGRE  ','QUERY GENERICO DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1370,'HELP GENERICO  DE RELACION','HLRE  ','HELP GENERICO  DE RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1371,'CONSULTA DE OCURRENCIAS DE RELACIONES','COOREL','CONSULTA DE OCURRENCIAS DE RELACIONES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1372,'IMPRESION DE DIRECCIONES','IMPDIR','IMPRESION DE DIRECCIONES EN LINEA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1373,'IMPRESION DE APARTADOS','IMPAPA','IMPRESION DE APARTADOS POSTALES EN LINEA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1374,'IMPRESION DE PROPIEDADES','IMPPRO','IMPRESION DE PROPIEDADES EN LINEA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1375,'IMPRESION DE REF. PERSONALES','IMPRPE','IMPRESION DE REF. PERSONALES EN LINEA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1376,'IMPRESION DE EMPLEOS','IMPEMP','IMPRESION DE EMPLEOS EN LINEA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1377,'IMPRESION DE REF. ECONOMICAS','IMPREC','IMPRESION DE REF. ECONOMICAS EN LINEA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1378,'BUSQUEDA POR NOMBRE EN LA LISTA CLINTON','LISTCL','BUSQUEDA POR NOMBRE EN LA LISTA CLINTON')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1379,'BANCOS ALIANZAS','COBAL ','TRANSACCION PARA CONSULTA DE ALIANZAS DESDE FRONTEND')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1380,'ACTUALIZAR ALIANZAS','ACAL  ','TRANSACCION PARA ACTUALIZAR ALIANZAS DESDE FRONTEND')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1381,'INSERCION REGISTRO DE CIFIN','IRC   ','INSERCION REGISTRO DE CIFIN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1382,'MODIFICACION REGISTRO DE CIFIN','MRC   ','MODIFICACION REGISTRO DE CIFIN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1383,'ELIMINACION REGISTRO DE CIFIN','ERC   ','ELIMINACION REGISTRO DE CIFIN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1384,'SEARCH REGISTRO DE CIFIN','ERC   ','SEARCH REGISTRO DE CIFIN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1385,'QUERY REGISTRO DE CIFIN','QRC   ','QUERY REGISTRO DE CIFIN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1386,'INSERCION DE NATURALEZA JURIDICA','INNAJU','INSERCION DE NATURALEZA JURIDICA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1387,'ACTUALIZACION DE NATURALEZA JURIDICA','ACNAJU','ACTUALIZACION DE NATURALEZA JURIDICA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1388,'ELIMINACION DE NATURALEZA JURIDICA','ELNAJU','ELIMINACION DE NATURALEZA JURIDICA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1389,'CONSULTA DE NATURALEZA JURIDICA','CONAJU','CONSULTA DE NATURALEZA JURIDICA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1390,'AYUDA DE NATURALEZA JURIDICA','HENAJU','HELP DE NATURALEZA JURIDICA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1391,'INSERTA ERRORES','1391  ','INSERTA ERRORES EN MIGRACION DE ENTES DIRECCIONES TELEFONOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1392,'VALIDACION DATOS MIGRACION DE ENTES','1392  ','VALIDACION DATOS MIGRACION DE ENTES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1393,'INSERTA ENTES DIRECCIONES TELEFONOS','1393  ','INSERTA ENTES DIRECCIONES TELEFONOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1394,'BUSCA ARCHIVOS CARGADOS','1394  ','BUSCA ARCHIVOS CARGADOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1395,'INSERTA ARCHIVOS CARGADOS','1395  ','INSERTA ARCHIVOS CARGADOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1396,'ELIMINA ARCHIVOS CARGADOS','1396  ','ELIMINA ARCHIVOS CARGADOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1397,'CONSULTA DE CATEGORIA DE CLIENTES (HELP)','1397  ','CONSULTA DE CATEGORIA DE CLIENTES (HELP)')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1398,'CONSULTA DE CATEGORIA DE CLIENTES (VALUE)','1398  ','CONSULTA DE CATEGORIA DE CLIENTES (VALUE)')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1399,'TRANSACCION MENU DE CONSULTA MERCADO','TRMNCM','TRANSACCION MENU DE CONSULTA MERCADO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1400,'INSERCION DE SECTOR ECONOMICO','INSECO','INSERCION DE SECTOR ECONOMICO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1401,'ACTUALIZACION SECTOR ECONOMICO','UPSECO','ACTUALIZACION SECTOR ECONOMICO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1402,'HELP ALFABETICO DE CATALOGO','HPALCA','HELP ALFABETICO DE CATALOGO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1403,'ELIMINACION SECTOR ECONOMICO','DESECO','ELIMINACION SECTOR ECONOMICO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1404,'ACTUALIZACION MASIVA DE ENTES DIRECCIONES TELEFONOS','1404  ','ACTUALIZACION MASIVA DE ENTES DIRECCIONES TELEFONOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1405,'INSERCION DE PARAMETRIZACION PANTALLA','INPAPA','INSERCION DE PARAMETRIZACION PANTALLA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1406,'ACTUALIZACION DE PARAMETRIZACION PANTALLA','ACPAPA','ACTUALIZACION DE PARAMETRIZACION PANTALLA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1407,'ELIMINACION DE PARAMETRIZACION PANTALLA','ELPAPA','ELIMINACION DE PARAMETRIZACION PANTALLA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1408,'CONSULTA DE PARAMETRIZACION PANTALLA','COPAPA','CONSULTA DE PARAMETRIZACION PANTALLA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1409,'AYUDA DE PARAMETRIZACION PANTALLA','HEPAPA','HELP DE PARAMETRIZACION PANTALLA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1410,'INSERCION DE CATEGORIAS','INCA  ','INSERCION DE CATEGORIAS DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1411,'ACTUALIZACION DE CATEGORIAS','ACME  ','ACTUALIZACION DE CATEGORIAS DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1412,'ELIMINACION DE  CATEGORIAS','ELCA  ','ELIMINACION DE CATEGORIAS DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1413,'ASIGNACION MASIVA DE OFICIALES','EMDO  ','ASIGNACION MASIVA DE OFICIALES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1414,'CONSULTA DIRECCION Y TELEFONO DEL ENTE','QRDITE','CONSULTA DIRECCION Y TELEFONO DEL ENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1415,'INSERCION DE CATALOGO BANCA DOMICILIARIA DEL CLIENTE','IBDOM ','INSERCION DE BANCA DOMICILIARIA DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1416,'ACTUALIZACION DE CATALOGO BANCA DOMICILIARIA DEL CLIENTE','ABDOM ','ACTUALIZACION DE BANCA DOMICILIARIA DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1417,'ELIMINACION DE CATALOGO BANCA DOMICILIARIA DEL CLIENTE','EBDOM ','ELIMINACION DE BANCA DOMICILIARIA DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1418,'CONSULTA DE CATALOGO BANCA DOMICILIARIA DEL CLIENTE','CBDOM ','CONSULTA DE BANCA DOMICILIARIA DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1419,'SEARCH DE CATALOGO BANCA DOMICILIARIA DEL CLIENTE','SBDOM ','SEARCH DE BANCA DOMICILIARIA DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1420,'CONSULTA DE DATOS BALANCE','CDBAL ','CONSULTA DE DATOS BALANCE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1421,'CONSULTA DE EMBARGOS POR CLIENTE','CDEXC ','CONSULTA DE EMBARGOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1422,'QUERY DE EMBARGOS POR CLIENTE','QDEXC ','CONSULTA DE EMBARGOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1423,'INSERCION CABECERA DE EMBARGOS POR CLIENTE','ICEXC ','INSERCION CABECERA DE EMBARGOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1424,'QUERY CABECERA DE EMBARGOS POR CLIENTE','QCEXC ','QUERY CABECERA DE EMBARGOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1425,'ELIMINA CABECERA DE EMBARGOS POR CLIENTE','ECEXC ','ELIMINA CABECERA DE EMBARGOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1426,'CONSULTA DE CLIENTES POR ZONA','CCLZON','CONSULTA DE CLIENTES POR ZONA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1427,'CONSULTA DE CLIENTES POR BANCA','CCLBAN','CONSULTA DE CLIENTES POR BANCA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1428,'CONSULTA DE CLIENTES POR GERENTE DE BANCA','CCLGBA','CONSULTA DE CLIENTES POR GERENTE DE BANCA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1429,'CONSULTA DE CLIENTES POR BANCA DE OFICINA','CCLBOF','CONSULTA DE CLIENTES POR BANCA DE OFICINA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1430,'INSERCION DETALLE DE EMBARGOS POR CLIENTE','IDEXC ','INSERCION DETALLE DE EMBARGOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1431,'ACTUALIZACION DE DEFAULT ECONOMICOS','ACDEEC','ACTUALIZACION DE DEFAULT ECONOMICOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1432,'INSERCION LEVANTAMIENTO DE EMBARGOS POR CLIENTE','ILEXC ','INSERCION LEVANTAMIENTO DE EMBARGOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1433,'CONSULTA LEVANTAMIENTO DE EMBARGOS POR CLIENTE','CLEXC ','CONSULTA LEVANTAMIENTO DE EMBARGOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1434,'QUERY LEVANTAMIENTO DE EMBARGOS POR CLIENTE','QLEXC ','QUERY LEVANTAMIENTO DE EMBARGOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1435,'ELIMINA LEVANTAMIENTO DE EMBARGOS POR CLIENTE','ELEXC ','ELIMINA LEVANTAMIENTO DE EMBARGOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1436,'QUERY DE PRODUCTOS CONGELAMIENTOS POR CLIENTE','QDPXC ','QUERY DE PRODUCTOS CONGELAMIENTOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1437,'INSERCION DE BANCA DOMICILIARIA DEL CLIENTE','IBDOM ','INSERCION DE BANCA DOMICILIARIA DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1438,'ACTUALIZACION DE BANCA DOMICILIARIA DEL CLIENTE','ABDOM ','ACTUALIZACION DE BANCA DOMICILIARIA DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1439,'ELIMINACION DE BANCA DOMICILIARIA DEL CLIENTE','EBDOM ','ELIMINACION DE BANCA DOMICILIARIA DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1440,'CONSULTA DE BANCA DOMICILIARIA DEL CLIENTE','CBDOM ','CONSULTA DE BANCA DOMICILIARIA DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1441,'SEARCH DE BANCA DOMICILIARIA DEL CLIENTE','SBDOM ','SEARCH DE BANCA DOMICILIARIA DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1442,'INSERCION CONGELAMIENTO DE CUENTA POR CLIENTE','ICCXC ','INSERCION CONGELAMIENTO DE CUENTA POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1443,'SEARCH CONGELAMIENTOS DE CUENTA POR CLIENTE','SCCXC ','SEARCH CONGELAMIENTOS DE CUENTA POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1444,'QUERY CONGELAMIENTOS DE CUENTA POR CLIENTE','QCCXC ','QUERY CONGELAMIENTOS DE CUENTA POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1445,'ELIMINACION CONGELAMIENTOS DE CUENTA POR CLIENTE','ECCXC ','ELIMINACION CONGELAMIENTOS DE CUENTA POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1446,'COBRO DE BANCA DOMICILIARIA','COBADO','COBRO DE BANCA DOMICILIARIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1447,'INSERCION LEVANTAMIENTO DE CONGELAMIENTO POR CLIENTE','ILCXC ','INSERCION LEVANTAMIENTO DE CONGELAMIENTO POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1448,'CONSULTA LEVANTAMIENTO DE CONGELAMIENTO POR CLIENTE','CLCXC ','CONSULTA LEVANTAMIENTO DE CONGELAMIENTO POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1449,'QUERY LEVANTAMIENTO DE CONGELAMIENTO POR CLIENTE','QLCXC ','QUERY LEVANTAMIENTO DE CONGELAMIENTO POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1450,'ACTUALIZACION DE TRANSACCION VALIDA IDENTIDAD','1450  ','ACTUALIZACION DE TRANSACCION VALIDA IDENTIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1451,'INSERCION RANGO EMPLEO','IRE   ','INSERCION REGISTRO DE RANGO DE EMPLEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1452,'MODIFICACION RANGO EMPLEO','MRE   ','MODIFICACION REGISTRO RANGO DE EMPLEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1453,'ELIMINACION RANGO EMPLEO','ERE   ','ELIMINACION REGISTRO RANGO DE EMPLEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1454,'SEARCH RANGO EMPLEO','ERE   ','SEARCH REGISTRO DE RANGO DE EMPLEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1455,'QUERY RANGO EMPLEO','QRE   ','QUERY REGISTRO DE RANGO DE EMPLEO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1456,'INSERCION RANGO ACTIVIDAD','IRAE  ','INSERCION REGISTRO DE RANGO DE ACTIVIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1457,'MODIFICACION RANGO ACTIVIDAD','MRAE  ','MODIFICACION REGISTRO RANGO DE ACTIVIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1458,'ELIMINACION RANGO ACTIVIDAD','ERAE  ','ELIMINACION REGISTRO RANGO DE ACTIVIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1459,'SEARCH RANGO ACTIVIDAD','ERAE  ','SEARCH REGISTRO DE RANGO DE ACTIVIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1460,'QUERY RANGO ACTIVIDAD','QRAE  ','QUERY REGISTRO DE RANGO DE ACTIVIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1461,'MODIFICACION ALERTAS','MRAS  ','MODIFICACION REGISTRO ALERTAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1462,'ELIMINACION ALERTAS','ERAS  ','ELIMINACION REGISTRO ALERTAS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1463,'SEARCH ALERTA','SRAC  ','SEARCH REGISTRO ALERTAS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1464,'CREACION FORMA HOMOLOGA','MFHO  ','CREACION DE FORMA HOMOLOGA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1465,'ACTUALIZACION FORMA HOMOLOGA','AFHOO ','ACTUALIZACION DE FORMA HOMOLOGA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1466,'ELIMINACION FORMA HOMOLOGA','AFHOO ','ELIMINACION DE FORMA HOMOLOGA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1467,'SEARCH FORMA HOMOLOGA','SRAC  ','SEARCH REGISTRO FORMA HOMOLOGA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1468,'CONSULTA MARCACION CIFIN','CMCF  ','CONSULTA MARCACION CIFIN')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1469,'BUSQUEDA DE TRANSACCION VALIDA IDENTIDAD','1469  ','BUSQUEDA DE TRANSACCION VALIDA IDENTIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1470,'INSERCION DE TRANSACCION VALIDA IDENTIDAD','1470  ','INSERCION DE TRANSACCION VALIDA IDENTIDAD')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1471,'ELIMINA LEVANTAMIENTO DE CONGELAMIENTO POR CLIENTE','ELCXC ','ELIMINA LEVANTAMIENTO DE CONGELAMIENTO POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1472,'TRANSACCION DEL CALLCENTER-DETALLE','TRCCDE','TRANSACCION CALLCENTER-DETALLE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1473,'TRANSACCION MENU DE CALLCENTER','TRMNCC','TRANSACCION MENU CALLCENTER')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1474,'TRANSACCION DEL SCORING-ENVIAR DATOS','TRMNCC','TRANSACCION DEL SCORING-ENVIAR DATOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1475,'TRANSACCION MENU DE SCORING','TRMNSC','TRANSACCION MENU SCORING')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1476,'TRANSACCION MENU DE APERTURA FUERA LINEA','TRMNFL','TRANSACCION MENU DE APERTURA FUERA LINEA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1477,'TRANSACCION MENU DE MANTENIMIENTO DE MERCADO','TRMNMM','TRANSACCION MENU DE MANTENIMIENTO DE MERCADO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1478,'TRANSACCION MENU DE PRODUCTO POR CLIENTE','TRMNPC','TRANSACCION MENU DE PRODUCTO POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1479,'TRANSACCION MENU DE PRODUCTO POR GRUPO','TRMNPG','TRANSACCION MENU DE PRODUCTO POR GRUPO')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1480,'TRANSACCION MENU DE MANTENIMIENTO RELACION','TRMNMR','TRANSACCION MENU DE MANTENIMIENTO RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1481,'TRANSACCION MENU DE ELIMINACION RELACION','TRMNER','TRANSACCION MENU DE ELIMINACION RELACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1482,'CAMBIO DE OFICIAL - ASIGNACION MASIVA DE OFICIALES','COAMO ','CAMBIO DE OFICIAL - ASIGNACION MASIVA DE OFICIALES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1483,'CONSULTA LEVANTAMIENTO DE CONGELAMIENTOS POR CLIENTE','CLCXC ','CONSULTA LEVANTAMIENTO DE CONGELAMIENTOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1484,'TRANSACCION MENU DE BANCA DOMICILIARIA','TRMNBD','TRANSACCION MENU DE BANCA DOMICILIARIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1485,'TRANSACCION MENU DE ASIGNACION MASIVA OFICIAL','TRMAMO','TRANSACCION MENU DE ASIGNACION MASIVA OFICIAL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1486,'TRANSACCION MENU COBRO BANCA DOMICILIARIA','TRMCBD','TRANSACCION MENU COBRO BANCA DOMICILIARIA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1487,'TRANSACCION MENU EMBARGOS','TRMNEM','TRANSACCION MENU EMBARGOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1488,'TRANSACCION MENU DESEMBARGOS','TRMNDM','TRANSACCION MENU DESEMBARGOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1489,'TRANSACCION MENU CONGELAMIENTOS','TRMNCM','TRANSACCION MENU CONGELAMIENTOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1490,'TRANSACCION MENU DESCONGELAMIENTOS','TRMNDM','TRANSACCION MENU DESCONGELAMIENTOS')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1491,'TRANSACCION MENU SITUACION DEL CLIENTE','TRMNSC','TRANSACCION MENU SITUACION DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1492,'QUERY TRSN EMBARGOS CONGELAMIENTOS POR CLIENTE','QTEDXC','QUERY TRSN EMBARGOS CONGELAMIENTOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1493,'SEARCH TRSN EMBARGOS CONGELAMIENTOS POR CLIENTE','STEDXC','SEARCH TRSN EMBARGOS CONGELAMIENTOS POR CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1494,'ASIGNACION OFICIAL POR CREACION DE CLIENTE','AOPCDC','ASIGNACION OFICIAL POR CREACION DE CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1495,'INSERCION DE MERCADO OBJETIVO DEL CLIENTE','IMOBB ','INSERCION DE MERCADO OBJETIVO DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1496,'ACTUALIZACION DE MERCADO OBJETIVO DEL CLIENTE','AMOBB ','ACTUALIZACION DE MERCADO OBJETIVO DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1497,'CONSULTA DE MERCADO OBJETIVO DEL CLIENTE','CMOBB ','CONSULTA DE MERCADO OBJETIVO DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1498,'SEARCH DE MERCADO OBJETIVO DEL CLIENTE','SMOBB ','SEARCH DE MERCADO OBJETIVO DEL CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1499,'CONSULTA REGIMENES FISCALES OPCION ALL','CRFA  ','CONSULTA REGIMENES FISCALES OPCION ALL')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1600,'INSERTA SOSTENIBILIDAD DE CLIENTE','ISDC  ','INSERTA LOS DATOS DE SOSTENIBILIDAD DE CLIENTE' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1601,'MODIFICA SOSTENIBILIDAD DE CLIENTE','MSDC  ','MODIFICA LOS DATOS DE SOSTENIBILIDAD DE CLIENTE' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1602,'CONSULTA SOSTENIBILIDAD DE CLIENTE','CSDC  ','CONSULTA LOS DATOS DE SOSTENIBILIDAD DE CLIENTE' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1603,'INSERTA ESCOLARIDAD DE CLIENTE','IEDC  ','INSERTA LOS DATOS DE ESCOLARIDAD DE CLIENTE' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1604,'MODIFICA ESCOLARIDAD DE CLIENTE','MEDC  ','MODIFICA LOS DATOS DE ESCOLARIDAD DE CLIENTE' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1605,'CONSULTA ESCOLARIDAD DE CLIENTE','CEDC  ','CONSULTA LOS DATOS DE ESCOLARIDAD DE CLIENTE' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1606,'EXTRACTO INDIVIDUAL COSTOS FINANCIEROS CIRCULAR 012','1606  ','EXTRACTO INDIVIDUAL COSTOS FINANCIEROS CIRCULAR 012' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1607,'IMPRIME EXTRACTOS FINANCIEROS CIRCULAR 012','1607  ','IMPRIME EXTRACTOS FINANCIEROS CIRCULAR 012' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1609,'INSERCION DE PERSONA LOCAL','INPEL ','INSERCION DE PERSONA LOCAL' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1615,'CONSULTA DE ALIANZAS','CONALI','CONSULTA DE ALIANZAS' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1617,'CARACTERIZACION ALIANZAS','CAAL  ','TRANSACCION PARA HABILITAR MENU DE CARACTERIZACION DE ALIANZAS DESDE FRONTEND' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1618,'ASOCIADOS ALIANZAS','ASAL  ','TRANSACCION PARA HABILITAR MENU DE ASOCIADOS DE ALIANZAS DESDE FRONTEND' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1619,'ALIANZAS DEFAULTS','1619  ','ALIANZAS DEFAULTS' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1621,'BUSQUEDA FATCA','1621  ','BUSQUEDA FATCA' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1700,'CERTIFICACIONES Y REFERENCIAS','CYR   ','CERTIFICACIONES Y REFERENCIAS' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1701,'CERTIFICACIONES Y REFERENCIAS','CYR   ','CERTIFICACIONES Y REFERENCIAS' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1702,'CERTIFICACIONES Y REFERENCIAS','CYR   ','CERTIFICACIONES Y REFERENCIAS' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1703,'CERTIFICACIONES Y REFERENCIAS','CYR   ','CERTIFICACIONES Y REFERENCIAS' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1704,'CERTIFICACIONES Y REFERENCIAS','CYR   ','CERTIFICACIONES Y REFERENCIAS' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1705,'CERTIFICACIONES Y REFERENCIAS','CYR   ','CERTIFICACIONES Y REFERENCIAS' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1706,'CERTIFICACIONES Y REFERENCIAS','CYR   ','CERTIFICACIONES Y REFERENCIAS' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1708,'CERTIFICACIONES Y REFERENCIAS','CYR   ','CERTIFICACIONES Y REFERENCIAS' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1709,'INSERTAR NEGOCIO CLIENTE','INGC','INSERTAR NEGOCIO CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1710,'ACTUALIZAR NEGOCIO CLIENTE','ANGC','ACTUALIZAR NEGOCIO CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1711,'ELIMINAR NEGOCIO CLIENTE','ENGC','ELIMINAR NEGOCIO CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1712,'LISTAR Y OBTIENE NEGOCIO CLIENTE','LONGC ','LISTAR Y OBTIENE NEGOCIO CLIENTE')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (3017,'DETERMINACION DE PARAMETROS PARA FIRMAS','DPFI  ','DETERMINACION DE PARAMETROS PARA PRODUCTOS QUE USAN FIRMAS' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (3022,'CONSULTA PRODUCTOS INSTALALADOS USAN FIRMAS','QPIF  ','CONSULTA DE PRODUCTOS INSTALADOS QUE USAN FIRMAS' )

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (29432,'FORMAS COBRO DEPOJU','FCDJ  ','FORMAS COBRO DEPOJU' )

---x
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1608, 'CONSULTA VALIDACION DE HUELLA', '1608', 'CONSULTA VALIDACION DE HUELLA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1610, 'TRANSACCION CONSULTA HOMINI VALIDA', 'TRCHV', 'TRANSACCION CONSULTA HOMINI VALIDA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1616, 'CONSULTA ESTADISTICA CIRCULAR 012', '1616', 'CONSULTA ESTADISTICA CIRCULAR 012')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1622, 'CLIENTES/PERSONA NATURAL/FATCA', '1622', 'CLIENTES/PERSONA NATURA/FATCA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1623, 'CLIENTES/PERSONA JURIDICA/FATCA', '1623', 'CLIENTES/PERSONA JURIDICA/FATCA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1624, 'MODIFICAR INFORMACION FATCA', '1624', 'MODIFICAR INFORMACION FATCA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1625, 'TRANSMITIR INFORMACION FATCA', '1625', 'TRANSMITIR INFORMACION FATCA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1626, 'IMPRIMIR INFORMACION FATCA', '1626', 'IMPRIMIR INFORMACION FATCA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1627, 'CAMPO NUM IDENT - TRASLADO CLIENTES', '1627', 'CAMPO NUM IDENT - TRASLADO CLIENTES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1628, 'CAMPO FECHA - TRASLADO CLIENTES', '1628', 'CAMPO FECHA - TRASLADO CLIENTES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1629, 'CAMPO NOMBRE CLIENTE - TRASLADO CLIENTES', '1629', 'CAMPO NOMBRE CLIENTE - TRASLADO CLIENTES')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1630, 'TRASLADO CLIENTES - BUSCAR', '1630', 'TRASLADO CLIENTES - BUSCAR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1631, 'TRASLADO CLIENTES - INGRESAR', '1631', 'TRASLADO CLIENTES - INGRESAR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1632, 'TRASLADO CLIENTES - AUTORIZAR', '1632', 'TRASLADO CLIENTES - AUTORIZAR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1633, 'TRASLADO CLIENTES - RECHAZAR', '1633', 'TRASLADO CLIENTES - RECHAZAR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1634, 'MENU TRASLADO - SOLICITUD', '1634', 'TRASLADO CLIENTES - RECHAZAR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1635, 'MENU TRASLADO - RECHAZAR', '1635', 'TRASLADO CLIENTES - RECHAZAR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1636, 'MENU TRASLADO - CONSULTA', '1636', 'TRASLADO CLIENTES - CONSULTA')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (2935, 'ACTUALIZACION ORDEN DE COBRO CERTIFICACION', 'MOCC', 'ACTUALIZACION ORDEN DE COBRO CERTIFICACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (2936, 'BUSQUEDA ORDENES DE COBRO CERTIFICACION', 'BOCC', 'BUSQUEDA ORDENES DE COBRO CERTIFICACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (2937, 'BUSQUEDA ORDENES DE COBRO CERTIFICACION', 'BOCC', 'BUSQUEDA ORDENES DE COBRO CERTIFICACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (2938, 'INSERCION ORDEN DE COBRO CERTIFICACION', 'IOCC', 'INSERCION ORDEN DE COBRO CERTIFICACION')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15188, 'HELP ALFABETICO DE CATALO', 'HPALCA', 'HELP ALFABETICO DE CATALO')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga)
values (7067120, 'OBTIENE RFC', 'ORFCRL', 'OBTIENE RFC')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga)
values (1718, 'REPORTE KYC', '1718', 'ENVIAR INFORMACION PARA GENERAR REPORTE KYC')

--Exclusion de Clientes
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,	tn_desc_larga)
values(610,'INSERCION DE CLIENTE EN LISTA DE EXCLUSION','ICLE','INSERTAR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,	tn_desc_larga)
values(611,'ELIMINACION DE CLIENTE EN LISTA DE EXCLUSION','ECLE','ELIMINAR')

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,	tn_desc_larga)
values(612,'CONSULTA DE CLIENTES EN LISTA DE EXCLUSION','CCLE','CONSULTAR')

---

----------------- Script Loand Group ----------------------

delete cobis..cl_ttransaccion where tn_trn_code in (800, 810)

insert into cobis..cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (800, 'ADMINISTRACION GRUPOS', '800', 'ADMINISTRACION GRUPOS')
go

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (810, 'ADMINISTRACION MIEMBROS DE GRUPO', 810, 'ADMINISTRACION MIEMBROS DE GRUPO')

go
/************************************************************************/
/*                              ad_procedure                            */
/************************************************************************/
print '----->  ad_procedure'
go
if exists (select pd_procedure from ad_procedure where (pd_procedure between 1000 and 1999) or pd_procedure = 152051 or pd_procedure=7067120 or pd_procedure=2173)
    delete ad_procedure where (pd_procedure between 1000 and 1999) or pd_procedure = 152051 or pd_procedure=7067120 or pd_procedure=2173
go

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1000,'sp_desasignar_grupo','cobis','V', getdate(),'asigrupo.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1001,'sp_at_instancia','cobis','V', getdate(),'atinstan.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1002,'sp_at_relacion','cobis','V', getdate(),'atrelaci.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1003,'sp_atributo','cobis','V', getdate(),'atrib.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1004,'sp_banco_rem','cobis','V', getdate(),'banco_re.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1005,'sp_balance','cobis','V', getdate(),'blncedml.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1006,'sp_balance_tmp','cobis','V', getdate(),'blncetmp.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1007,'sp_cargo_funcionario','cobis','V', getdate(),'cargofun.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1008,'sp_casilla','cobis','V', getdate(),'casilla.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1009,'sp_cliente_ciudad','cobis','V', getdate(),'clixciud.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1010,'sp_cliente_parroquia','cobis','V', getdate(),'clixpar.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1011,'sp_cliente_prov','cobis','V', getdate(),'clixprov.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1012,'sp_cliente_prov_rn','cobis','V', getdate(),'clixpvrn.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1013,'sp_cliente_prov_ro','cobis','V', getdate(),'clixpvro.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1014,'sp_cliente_regnat','cobis','V', getdate(),'clixrn.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1015,'sp_cliente_rn_ro','cobis','V', getdate(),'clixrnro.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1016,'sp_cliente_regope','cobis','V', getdate(),'clixro.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1017,'sp_cli_posicion','cobis','V', getdate(),'clposi.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1018,'sp_cons_cli_comp','cobis','V', getdate(),'coclicom.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1019,'sp_cons_cli_grupo','cobis','V', getdate(),'cocligrp.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1020,'sp_compania_ins','cobis','V', getdate(),'comp_ins.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1021,'sp_compania_cons','cobis','V', getdate(),'comp_con.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1022,'sp_cons_rol','cobis','V', getdate(),'corol.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1023,'sp_cuenta','cobis','V', getdate(),'cuenta.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1024,'sp_desc_cliente','cobis','V', getdate(),'desclien.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1025,'sp_direccion_dml','cobis','V', getdate(),'dir_dml.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1026,'sp_empleo','cobis','V', getdate(),'empleo.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1027,'sp_se_ente','cobis','V', getdate(),'ente.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1028,'sp_estatuto_tmp','cobis','V', getdate(),'esta_tmp.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1029,'sp_estatuto','cobis','V', getdate(),'estatuto.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1030,'sp_fecha_posterior','cobis','V', getdate(),'fchpost.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1031,'sp_grdorada','cobis','V', getdate(),'grdorada.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1032,'sp_grupo','cobis','V', getdate(),'grupo.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1033,'sp_grupo_qry','cobis','V', getdate(),'grupoqry.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1034,'sp_his_relacion','cobis','V', getdate(),'his_rela.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1035,'sp_inf_legal','cobis','V', getdate(),'inf_lega.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1036,'sp_instancia','cobis','V', getdate(),'instan.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1037,'sp_mala_ref','cobis','V', getdate(),'mala_ref.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1038,'sp_num_personas','cobis','V', getdate(),'numper.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1039,'sp_obj_social_tmp','cobis','V', getdate(),'obje_tmp.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1040,'sp_obj_social','cobis','V', getdate(),'objeto.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1041,'sp_perfil','cobis','V', getdate(),'perfil.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1042,'sp_plan','cobis','V', getdate(),'plan.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1043,'sp_posicion_cliente_qry','cobis','V', getdate(),'posclien.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1044,'sp_persona_ins','cobis','V', getdate(),'pers_ins.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1045,'sp_persona_cons','cobis','V', getdate(),'pers_con.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1046,'sp_propiedad','cobis','V', getdate(),'propied.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1047,'sp_qrente','cobis','V', getdate(),'qrente.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1048,'sp_qr_grupo','cobis','V', getdate(),'qrgrupo.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1049,'sp_ref_com','cobis','V', getdate(),'ref_com.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1050,'sp_ref_eco','cobis','V', getdate(),'ref_eco.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1051,'sp_refpersonal','cobis','V', getdate(),'ref_per.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1052,'sp_ref_tar','cobis','V', getdate(),'ref_tar.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1053,'sp_relacion','cobis','V', getdate(),'relacion.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1054,'sp_relacion_qry','cobis','V', getdate(),'relacqry.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1055,'sp_reset','cobis','V', getdate(),'reset.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1056,'sp_se_cliente','cobis','V', getdate(),'seclient.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1057,'sp_sector','cobis','V', getdate(),'sector.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1058,'sp_servicio_cl','cobis','V', getdate(),'servicio.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1059,'sp_tbalance','cobis','V', getdate(),'tbalance.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1060,'sp_telefono','cobis','V', getdate(),'telef.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1061,'sp_tplan','cobis','V', getdate(),'tplan.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1062,'sp_tplan_tmp','cobis','V', getdate(),'tplantmp.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1063,'sp_pr_ente','cobis','V', getdate(),'prente.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1064,'sp_compania_no_ruc','cobis','V', getdate(),'cianoruc.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1065,'sp_se_ente_ofi','cobis','V', getdate(),'ente_ofi.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1066,'sp_se_ente_prod','cobis','V', getdate(),'ente_pro.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1067,'sp_direccion_cons','cobis','V', getdate(),'dir_cons.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1068,'sp_soc_hecho_dml','cobis','V', getdate(),'s_h_dml.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1069,'sp_soc_hecho_cons','cobis','V', getdate(),'s_h_cons.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1070,'sp_soc_hecho_busq','cobis','V', getdate(),'s_h_bus.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1071,'sp_persona_upd','cobis','V', getdate(),'pers_upd.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1072,'sp_compania_upd','cobis','V', getdate(),'comp_upd.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1073,'sp_elim_ente','cobis','V', getdate(),'elim_ent.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1074,'sp_ref_eco2','cobis','V', getdate(),'ref_eco2.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1075,'sp_balance_excel','cobis','V', getdate(),'balexcel.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1076,'sp_laboral','cobis','V', getdate(),'laboral.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1077,'sp_ref_fin','cobis','V', getdate(),'ref_fin.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1078,'sp_covinco_dml','cobis','V', getdate(),'covdml.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1079,'sp_covinco_con','cobis','V', getdate(),'covinco.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1080,'sp_narcos_con','cobis','V', getdate(),'narcos.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1081,'sp_narcos_dml','cobis','V', getdate(),'nardml.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1082,'sp_crea_persona','cobis','V', getdate(),'creaper.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1083,'sp_liquidacion_dml','cobis','V', getdate(),'comliq.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1084,'sp_liquidacion_con','cobis','V', getdate(),'comliqr.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1085,'sp_sum_propiedad','cobis','V', getdate(),'sumprop.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1086,'sp_ente_oficina_count','cobis','V', getdate(),'entxofi.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1087,'sp_cliente_oficina_count','cobis','V', getdate(),'clixofi.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1088,'sp_cliente_producto_count','cobis','V', getdate(),'clixpro.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1089,'sp_cli_pro_ofi_count','cobis','V', getdate(),'clixprof.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1090,'sp_refinh_dml','cobis','V', getdate(),'refindml.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1091,'sp_refinh_con','cobis','V', getdate(),'refinh.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1092,'sp_mercado_con','cobis','V', getdate(),'mercado.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1093,'sp_mercado_dml','cobis','V', getdate(),'mercdml.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1094,'sp_parametriza_sol','cobis','V', getdate(),'cl_solpa.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1095,'sp_persona_no_ruc','cobis','V', getdate(),'clinoruc.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1096,'sp_contacto','cobis','V', getdate(),'contac.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1097,'sp_cli_actividad','cobis','V', getdate(),'clixsec.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1098,'sp_clixact_sector','cobis','V', getdate(),'clixact.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1099,'sp_ciuxdept','cobis','V', getdate(),'ciuxdept.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1100,'sp_hijos','cobis','V', getdate(),'hijos.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1101,'sp_falso_upd_presentado_por','cobis','V', getdate(),'falprese.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1102,'sp_relinter','cobis','V', getdate(),'relinter.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1103,'sp_rel_lega','cobis','V', getdate(),'rel_lega.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1104,'sp_cliente_tipo_doc','cobis','V', getdate(),'clixtipo.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1105,'sp_asesor_upd','cobis','V', getdate(),'ases_upd.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1106,'sp_prospectos_ofi','cobis','V', getdate(),'prospectos.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1107,'sp_otros_ingresos','cobis','V', getdate(),'oingreso.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1108,'sp_def_tablas','cobis','V', getdate(),'def_tablas.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1109,'sp_def_campos','cobis','V', getdate(),'def_campos.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1110,'sp_dat_mercadeo','cobis','V', getdate(),'dat_mercadeo.s')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1111,'sp_ente_bloqueado','cobis','V', getdate(),'cl_bloqueo.')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1112,'sp_his_vinculos','cobis','V', getdate(),'his_vinculos.s')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1113,'sp_poscliente','cobis','V', getdate(),'poscliente.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1114,'sp_desasignar_grupo','cobis','V', getdate(),'asigrupo.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1115,'sp_direccion_cons','cobis','V', getdate(),'dir_cons.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1116,'sp_grupoeco','cobis','V', getdate(),'grupoeco.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1117,'sp_falso_upd_reportado_super','cobis','V', getdate(),'falrepban.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1118,'sp_impresion_direcciones','cobis','V', getdate(),'dir_imp.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1119,'sp_impresion_casillas','cobis','V', getdate(),'cas_imp.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1120,'sp_impresion_propiedades','cobis','V', getdate(),'prop_imp.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1121,'sp_impresion_ref_personales','cobis','V', getdate(),'rper_imp.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1122,'sp_impresion_empleos','cobis','V', getdate(),'emp_imp.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1123,'sp_impresion_ref_economicas','cobis','V', getdate(),'reco_imp.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1124,'sp_busqueda_entidades_externas','cobis','V', getdate(),'busent.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1125,'sp_compara_nombres','cobis','V', getdate(),'compnomb.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1126,'sp_clasoser','cobis','V', getdate(),'clasoser.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1127,'sp_param_bloqueado','cobis','V', getdate(),'cl_parbl.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1128,'sp_cifin','cobis','V', getdate(),'cifin.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1129,'sp_sectoreco','cobis','V', getdate(),'sectorec.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1130,'sp_natjur','cobis','V', getdate(),'clnatjur.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1131,'sp_cerror_mig_cl','cobis','V', getdate(),'errormic.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1132,'sp_ente_mig_cl','cobis','V', getdate(),'entemic.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1133,'sp_aplicar_ente_cl','cobis','V', getdate(),'apliente.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1134,'sp_archivos_cargados','cobis','V', getdate(),'archcarg.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1135,'sp_categoria','cobis','V', getdate(),'categor.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1136,'sp_hp_alf_catalogo','cobis','V', getdate(),'hpalfcat.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1137,'sp_asig_masiva_ofi','cobis','V', getdate(),'clasigmofi.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1138,'sp_dir_tel_cons','cobis','V', getdate(),'clditeco.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1139,'sp_bandom','cobis','V', getdate(),'clbandom.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1140,'sp_datos_balance','cobis','V', getdate(),'cldatbal.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1141,'sp_embargo','cobis','V', getdate(),'clembargo.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1142,'sp_con_gral_producto','cobis','V', getdate(),'clcrgpro.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1143,'sp_cliente_ciudad_zona','cobis','V', getdate(),'clixzona.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1144,'sp_cliente_banca','cobis','V', getdate(),'clixba.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1145,'sp_cliente_oficial_banca','cobis','V', getdate(),'clixofba.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1146,'sp_cliente_banca_oficina','cobis','V', getdate(),'clixbaof.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1147,'sp_falso_upd_default_eco','cobis','V', getdate(),'faldefec.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1148,'sp_desembargo','cobis','V', getdate(),'cldesemba.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1149,'sp_serbdom','cobis','V', getdate(),'clserbdom.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1150,'sp_cliente_oficina','cobis','V', getdate(),'cl_cli_ofi.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1151,'sp_rango_empleo','cobis','V', getdate(),'rangoempl.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1152,'sp_rango_actividad','cobis','V', getdate(),'rangoacti.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1153,'sp_alerta','cobis','V', getdate(),'alerta.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1154,'sp_forma_homologa','cobis','V', getdate(),'formahomologa.')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1155,'sp_cons_regfiscal','cobis','V', getdate(),'cl_conrfis.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1156,'sp_actualizacion_critica','cobis','V', getdate(),'cl_actcr.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1157,'sp_promedio_producto','cobis','V', getdate(),'cl_prom_pro')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1158,'sp_consulta_rta_cifin','cobis','V', getdate(),'rtacifin.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1160,'sp_parametros_cr','cobis','V', getdate(),'paramcr.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1161,'sp_con_gral_producto_con','cobis','V', getdate(),'clcrgprocon.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1162,'sp_congela','cobis','V', getdate(),'clcongela.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1163,'sp_cobro_bandom','cobis','V', getdate(),'clcobban.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1164,'sp_descongela','cobis','V', getdate(),'cldescongela.s')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1165,'sp_consulta_embargo','cobis','V', getdate(),'cembargo.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1166,'sp_falso_tran_menu','cobis','V', getdate(),'faltramn.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1167,'sp_llenasipla','cobis','V', getdate(),'llenasipla.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1168,'sp_asesor_creacion_upd','cobis','V', getdate(),'ases_creaupd.s')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1169,'sp_banmer','cobis','V', getdate(),'clbanmer.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1170,'sp_mercado_objetivo','cobis','V', getdate(),'clmerobj.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1171,'sp_origen_fondos','cobis','V', getdate(),'origfon.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1172,'sp_consulta_masiva','cobis','V', getdate(),'cl_conmasiva.s')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1173,'sp_reverso_embargos','cobis','V', getdate(),'clrevembargo.s')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1174,'sp_con_orifondos','cobis','V', getdate(),'clconorfon.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1175,'sp_crea_compania','cobis','V', getdate(),'creaperc.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1176,'sp_regimen_fiscal','cobis','V', getdate(),'regimen.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1177,'sp_traslado_productos','cobis','V', getdate(),'cltraslado.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1178,'sp_tipo_documento','cobis','V', getdate(),'cltipo_docu')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1179,'sp_consultar_xml','cobis','V', getdate(),'sp_cons_xml.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1180,'sp_tipodoc','cobis','V', getdate(),'cltipodoc.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1181,'sp_val_doc','cobis','V', getdate(),'cltipodoc.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1182,'sp_parametrizacion_cl_vip','cobis','V', getdate(),'parclvip.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1183,'sp_asociacion_actividad','cobis','V', getdate(),'cl_asact.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1184,'sp_traslado_alerta','cobis','V', getdate(),'cl_trasaler')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1185,'sp_indicadores_tributarios','cobis','V', getdate(),'cl_indtr.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1190,'sp_saldos_req_880','cobis','V', getdate(),'saldos_cli.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1191,'sp_funcionario_oficina','cobis','V', getdate(),'clfunofi.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1192,'sp_direccion','cobis','V', getdate(),'direccio.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1193,'sp_cons_cli_ccaact','cobis','V', getdate(),'cl_cons_cli_cc')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1194,'sp_datos_cliente','cobis','V', getdate(),'cldatcli.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1195,'sp_oficinaciudad','cobis','V', getdate(),'dir_oficiu.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1196,'sp_consulta_rechazos_pda','cob_palm','V', getdate(),'pda_conrec.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1197,'sp_orden_consulta_ext','cobis','V', getdate(),'clordenex.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1198,'sp_consultar','master','V', getdate(),'consultar.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1199,'sp_consultar1','master','V', getdate(),'consultar1.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1201,'sp_cent_riesgo','cobis','V', getdate(),'sp_criesgo.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1202,'sp_restrictivas','cobis','V', getdate(),'cl_restri.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1203,'sp_norestrictivas','cobis','V', getdate(),'cl_norestri.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1204,'sp_autoriza_norestrictivas','cobis','V', getdate(),' cl_autnr.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1205,'sp_cons_inf_xml','cobis','V', getdate(),'clconxml.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1206,'sp_extraer_inf_xml','cobis','V', getdate(),'clinfxml.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1207,'sp_extraer_inf_xml_cf','cobis','V', getdate(),'clinfxmlcf.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1208,'sp_cons_inf_xml_cf','cobis','V', getdate(),'clconxmlcf.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1209,'sp_relacion_validar','cobis','V', getdate(),'clrelval.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1210,'sp_tarea','cobis','V', getdate(),'cltarea.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1211,'sp_param_viable','cobis','V', getdate(),'cl_parv.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1212,'sp_serv_referenciacion','cobis','V', getdate(),'cl_sref.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1213,'sp_alerta_tarea','cobis','V', getdate(),'cl_alertar.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1220,'sp_almacenar_xml','cobis','V', getdate(),'clalmaxml.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1226,'sp_sostenibilidad','cobis','V', getdate(),'cl_sostenib.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1227,'sp_escolaridad','cobis','V', getdate(),'cl_escolari.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1228,'sp_valida_identidad','cobis','V', getdate(),'cl_valid.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1229,'sp_log_ext012','cobis','V', getdate(),'cl_logext12.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1230,'sp_consulta_homini','cobis','V', getdate(),'clconhom.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1231,'sp_consulta_extracto_c12','cobis','V', getdate(),'cl_consextc.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1232,'sp_alianzas','cobis','V', getdate(),'cl_alianza.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1233,'sp_forma_extracto','cobis','V', getdate(),'cl_formext.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1234,'sp_asociacion_alianza','cobis','V', getdate(),'cl_asocali.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1235,'sp_alianza_banco','cobis','V', getdate(),'ali_banco.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1236,'sp_alianza_cliente','cobis','V', getdate(),'ali_cliente.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1238,'sp_alianzas_defaults_ente','cobis','V', getdate(),'cl_ali_def.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1239,'sp_mantenimiento_fatca','cobis','V', getdate(),'cl_fatca.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1240,'sp_traslado_pasivo','cobis','V', getdate(),'cltraspas.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1500,'sp_operador_batch','cobis','V', getdate(),'opbatch.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1991,'sp_query_ente_int','cobis','V', getdate(),'b_qryent.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1992,'sp_cliente_producto','cobis','V', getdate(),'carclipro.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1993,'sp_caract_obsequio','cobis','V', getdate(),'caracobs.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1994,'sp_evaluar_obsequio','cobis','V', getdate(),'evaobs.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1995,'sp_exonera_ente','cobis','V', getdate(),'cl_exoente.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1996,'sp_aplica_tpersona','cobis','V', getdate(),'claptper.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1997,'sp_par_tipersona','cobis','V', getdate(),'claptiper.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1998,'sp_orden_cobro_cer_ref','cobis','V', getdate(),'cl_ordcobcr.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1999,'sp_negocio_cliente','cobis','V', getdate(),'negocente.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (152051,'sp_persona_ins_local','cobis','V', getdate(),'perinsloc.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1718,'sp_reporte_kyc','cobis','V', getdate(),'sp_rep_kyc.sp')

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2173,'sp_lista_exclusion_dml','cobis','V',getdate(),'cl_listexc.sp')


----------------- Script Loand Group ----------------------
-- Elimina registros
delete cobis..ad_procedure where pd_base_datos = 'cob_pac' and pd_procedure in (800, 810)
go

-- Ingreso registros
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values (800,'sp_grupo_busin','cob_pac','V',getdate(),'sp_grp_bus.sp') -- no mas de 14 caracteres
go

insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (810,'sp_miembro_grupo_busin','cob_pac','V',getdate(),'sp_mgrp_bus.sp')  -- no mas de 14 caracteres
go

insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (7067120,'sp_relacion_cliente_cons','cobis','V',getdate(),'sp_re_clien.sp')
go

/************************************************************************/
/*                              ad_pro_transaccion                      */
/************************************************************************/
print '----->  ad_pro_transaccion'
go

if exists (select * from ad_pro_transaccion where pt_producto = 2 or (pt_producto = 1 and pt_transaccion = 1609))
    delete ad_pro_transaccion where pt_producto = 2 or (pt_producto = 1 and pt_transaccion = 1609)
go

declare @w_moneda tinyint

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,100,'V',getdate(),1126)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,101,'V',getdate(),1034)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,102,'V',getdate(),1035)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,103,'V',getdate(),1044)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,104,'V',getdate(),1071)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,105,'V',getdate(),1020)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,106,'V',getdate(),1072)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,107,'V',getdate(),1032)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,108,'V',getdate(),1032)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,109,'V',getdate(),1025)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,110,'V',getdate(),1025)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,111,'V',getdate(),1060)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,112,'V',getdate(),1060)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,113,'V',getdate(),1046)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,114,'V',getdate(),1046)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,115,'V',getdate(),1077)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,116,'V',getdate(),1077)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,117,'V',getdate(),1103)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,118,'V',getdate(),1103)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,119,'V',getdate(),1037)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,120,'V',getdate(),1037)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,121,'V',getdate(),1039)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,122,'V',getdate(),1040)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,123,'V',getdate(),1041)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,124,'V',getdate(),1041)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,125,'V',getdate(),1041)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,126,'V',getdate(),1041)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,127,'V',getdate(),1041)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,128,'V',getdate(),1042)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,129,'V',getdate(),1042)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,130,'V',getdate(),1042)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,131,'V',getdate(),1042)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,132,'V',getdate(),1045)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,133,'V',getdate(),1045)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,134,'V',getdate(),1046)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,135,'V',getdate(),1046)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,136,'V',getdate(),1051)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,137,'V',getdate(),1051)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,138,'V',getdate(),1054)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,139,'V',getdate(),1054)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,140,'V',getdate(),1054)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,141,'V',getdate(),1057)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,142,'V',getdate(),1057)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,143,'V',getdate(),1057)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,144,'V',getdate(),1059)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,145,'V',getdate(),1059)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,146,'V',getdate(),1059)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,147,'V',getdate(),1060)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,148,'V',getdate(),1060)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,149,'V',getdate(),1061)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,150,'V',getdate(),1048)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,151,'V',getdate(),1170)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,152,'V',getdate(),1170)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,153,'V',getdate(),1170)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,154,'V',getdate(),1170)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,155,'V',getdate(),1170)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,156,'V',getdate(),1171)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,157,'V',getdate(),1171)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,158,'V',getdate(),1171)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,159,'V',getdate(),1171)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,160,'V',getdate(),1171)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,161,'V',getdate(),1171)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,162,'V',getdate(),1094)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,163,'V',getdate(),1094)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,164,'V',getdate(),1094)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,165,'V',getdate(),1094)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,166,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,167,'V',getdate(),1126)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,168,'V',getdate(),1155)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,169,'V',getdate(),1185)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,170,'V',getdate(),1185)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,171,'V',getdate(),1185)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,172,'V',getdate(),1126)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,173,'V',getdate(),1008)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,174,'V',getdate(),1008)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,175,'V',getdate(),1111)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,176,'V',getdate(),1111)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,177,'V',getdate(),1051)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,178,'V',getdate(),1051)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,179,'V',getdate(),1077)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,180,'V',getdate(),1074)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,181,'V',getdate(),1026)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,182,'V',getdate(),1026)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,183,'V',getdate(),1050)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,184,'V',getdate(),1184)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,185,'V',getdate(),1184)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,186,'V',getdate(),1156)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,187,'V',getdate(),1156)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,188,'V',getdate(),1157)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,189,'V',getdate(),1157)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,190,'V',getdate(),1157)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,191,'V',getdate(),1157)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,195,'V',getdate(),1169)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,196,'V',getdate(),280)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,197,'V',getdate(),1046)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,198,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,199,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1000,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1001,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1002,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1003,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1004,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1005,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1006,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1007,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1008,'V',getdate(),1150)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1009,'V',getdate(),1150)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1010,'V',getdate(),1992)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1011,'V',getdate(),1992)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1012,'V',getdate(),1993)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1013,'V',getdate(),1993)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1014,'V',getdate(),1994)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1015,'V',getdate(),1179)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1016,'V',getdate(),1160)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1017,'V',getdate(),1160)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1018,'V',getdate(),1160)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1019,'V',getdate(),1193)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1020,'V',getdate(),1194)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1021,'V',getdate(),1196)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1022,'V',getdate(),1197)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1023,'V',getdate(),1197)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1024,'V',getdate(),1198)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1025,'V',getdate(),1199)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1026,'V',getdate(),1126)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1027,'V',getdate(),1995)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1028,'V',getdate(),1995)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1029,'V',getdate(),1996)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1030,'V',getdate(),1191)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1031,'V',getdate(),1191)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1035,'V',getdate(),1201)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1036,'V',getdate(),1202)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1037,'V',getdate(),1202)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1038,'V',getdate(),1202)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1039,'V',getdate(),1202)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1040,'V',getdate(),1202)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1041,'V',getdate(),1203)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1042,'V',getdate(),1203)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1043,'V',getdate(),1203)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1044,'V',getdate(),1203)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1045,'V',getdate(),1203)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1046,'V',getdate(),1204)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1047,'V',getdate(),1204)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1048,'V',getdate(),1204)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1049,'V',getdate(),1204)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1050,'V',getdate(),1204)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1051,'V',getdate(),1126)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1052,'V',getdate(),1126)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1053,'V',getdate(),1126)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1054,'V',getdate(),1126)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1055,'V',getdate(),1126)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1056,'V',getdate(),1126)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1057,'V',getdate(),1126)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1058,'V',getdate(),1126)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1059,'V',getdate(),1126)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1060,'V',getdate(),1206)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1061,'V',getdate(),1205)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1062,'V',getdate(),1207)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1063,'V',getdate(),1208)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1064,'V',getdate(),1209)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1065,'V',getdate(),1210)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1066,'V',getdate(),1211)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1067,'V',getdate(),1211)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1068,'V',getdate(),1211)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1069,'V',getdate(),1211)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1070,'V',getdate(),1211)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1071,'V',getdate(),1211)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1072,'V',getdate(),1211)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1073,'V',getdate(),1211)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1074,'V',getdate(),1212)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1075,'V',getdate(),1213)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1083,'V',getdate(),1220)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1100,'V',getdate(),1101)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1101,'V',getdate(),1101)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1102,'V',getdate(),1172)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1103,'V',getdate(),1173)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1104,'V',getdate(),1173)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1105,'V',getdate(),1174)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1106,'V',getdate(),1174)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1108,'V',getdate(),1177)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1109,'V',getdate(),1177)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1110,'V',getdate(),1178)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1111,'V',getdate(),1178)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1112,'V',getdate(),1178)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1113,'V',getdate(),1178)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1115,'V',getdate(),1180)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1116,'V',getdate(),1181)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1117,'V',getdate(),1182)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1119,'V',getdate(),1182)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1120,'V',getdate(),1183)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1121,'V',getdate(),1183)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1122,'V',getdate(),1183)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1123,'V',getdate(),1183)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1124,'V',getdate(),1183)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1128,'V',getdate(),1008)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1130,'V',getdate(),1051)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1131,'V',getdate(),1127)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1132,'V',getdate(),1127)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1133,'V',getdate(),1127)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1134,'V',getdate(),1127)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1137,'V',getdate(),1053)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1138,'V',getdate(),1053)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1139,'V',getdate(),1053)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1140,'V',getdate(),1195)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1141,'V',getdate(),1191)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1142,'V',getdate(),1059)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1143,'V',getdate(),1059)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1144,'V',getdate(),1059)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1145,'V',getdate(),1061)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1147,'V',getdate(),1061)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1148,'V',getdate(),1037)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1149,'V',getdate(),1037)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1150,'V',getdate(),1057)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1151,'V',getdate(),1057)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1152,'V',getdate(),1057)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1155,'V',getdate(),1029)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1156,'V',getdate(),1029)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1157,'V',getdate(),1040)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1158,'V',getdate(),1040)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1159,'V',getdate(),1005)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1160,'V',getdate(),1000)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1161,'V',getdate(),1001)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1162,'V',getdate(),1001)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1163,'V',getdate(),1001)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1164,'V',getdate(),1002)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1165,'V',getdate(),1003)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1166,'V',getdate(),1006)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1167,'V',getdate(),1007)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1168,'V',getdate(),1009)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1169,'V',getdate(),1010)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1170,'V',getdate(),1011)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1171,'V',getdate(),1012)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1172,'V',getdate(),1013)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1173,'V',getdate(),1014)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1174,'V',getdate(),1016)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1175,'V',getdate(),1015)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1176,'V',getdate(),1017)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1177,'V',getdate(),1018)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1178,'V',getdate(),1019)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1179,'V',getdate(),1022)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1180,'V',getdate(),1023)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1181,'V',getdate(),1024)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1182,'V',getdate(),1027)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1183,'V',getdate(),1028)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1184,'V',getdate(),1032)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1185,'V',getdate(),1035)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1186,'V',getdate(),1036)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1187,'V',getdate(),1039)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1188,'V',getdate(),1042)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1189,'V',getdate(),1043)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1190,'V',getdate(),1047)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1191,'V',getdate(),1032)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1192,'V',getdate(),1192)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1194,'V',getdate(),1053)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1195,'V',getdate(),1056)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1196,'V',getdate(),1062)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1197,'V',getdate(),1001)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1198,'V',getdate(),1001)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1199,'V',getdate(),1002)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1200,'V',getdate(),1002)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1201,'V',getdate(),1002)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1202,'V',getdate(),1002)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1203,'V',getdate(),1002)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1204,'V',getdate(),1003)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1205,'V',getdate(),1003)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1206,'V',getdate(),1004)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1207,'V',getdate(),1004)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1208,'V',getdate(),1004)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1209,'V',getdate(),1004)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1210,'V',getdate(),1004)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1211,'V',getdate(),1004)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1212,'V',getdate(),1005)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1213,'V',getdate(),1005)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1214,'V',getdate(),1005)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1215,'V',getdate(),1008)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1216,'V',getdate(),1008)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1218,'V',getdate(),1021)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1219,'V',getdate(),1021)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1220,'V',getdate(),1023)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1221,'V',getdate(),1023)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1222,'V',getdate(),1023)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1223,'V',getdate(),1023)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1224,'V',getdate(),1023)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1225,'V',getdate(),1024)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1226,'V',getdate(),1025)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1227,'V',getdate(),1067)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1228,'V',getdate(),1067)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1229,'V',getdate(),1067)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1230,'V',getdate(),1026)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1231,'V',getdate(),1026)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1232,'V',getdate(),1026)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1233,'V',getdate(),1028)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1234,'V',getdate(),1029)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1235,'V',getdate(),1033)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1236,'V',getdate(),1033)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1237,'V',getdate(),1033)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1238,'V',getdate(),1032)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1239,'V',getdate(),1063)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1240,'V',getdate(),1064)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1241,'V',getdate(),1065)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1242,'V',getdate(),1066)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1243,'V',getdate(),1068)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1244,'V',getdate(),1068)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1245,'V',getdate(),1069)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1246,'V',getdate(),1069)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1247,'V',getdate(),1070)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1248,'V',getdate(),1073)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1249,'V',getdate(),1068)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1250,'V',getdate(),1075)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1251,'V',getdate(),1075)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1252,'V',getdate(),1075)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1253,'V',getdate(),1076)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1254,'V',getdate(),1076)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1255,'V',getdate(),1076)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1256,'V',getdate(),1079)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1257,'V',getdate(),1079)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1258,'V',getdate(),1078)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1259,'V',getdate(),1078)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1260,'V',getdate(),1078)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1261,'V',getdate(),1080)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1262,'V',getdate(),1080)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1263,'V',getdate(),1081)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1264,'V',getdate(),1081)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1265,'V',getdate(),1081)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1266,'V',getdate(),1082)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1267,'V',getdate(),1037)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1268,'V',getdate(),1084)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1269,'V',getdate(),1084)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1270,'V',getdate(),1083)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1271,'V',getdate(),1083)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1272,'V',getdate(),1083)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1273,'V',getdate(),1085)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1274,'V',getdate(),1086)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1275,'V',getdate(),1087)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1276,'V',getdate(),1088)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1277,'V',getdate(),1089)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1278,'V',getdate(),1091)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1279,'V',getdate(),1091)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1280,'V',getdate(),1090)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1281,'V',getdate(),1090)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1282,'V',getdate(),1090)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1283,'V',getdate(),1092)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1284,'V',getdate(),1092)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1285,'V',getdate(),1093)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1286,'V',getdate(),1093)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1287,'V',getdate(),1093)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1288,'V',getdate(),1095)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1289,'V',getdate(),1096)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1290,'V',getdate(),1096)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1291,'V',getdate(),1096)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1292,'V',getdate(),1096)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1293,'V',getdate(),1096)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1294,'V',getdate(),1097)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1295,'V',getdate(),1098)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1296,'V',getdate(),1116)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1297,'V',getdate(),1116)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1298,'V',getdate(),1124)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1299,'V',getdate(),1175)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1300,'V',getdate(),1099)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1301,'V',getdate(),1100)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1302,'V',getdate(),1100)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1303,'V',getdate(),1100)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1304,'V',getdate(),1100)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1305,'V',getdate(),1100)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1306,'V',getdate(),1101)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1307,'V',getdate(),1102)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1308,'V',getdate(),1102)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1309,'V',getdate(),1102)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1310,'V',getdate(),1102)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1311,'V',getdate(),1102)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1312,'V',getdate(),1103)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1313,'V',getdate(),1103)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1314,'V',getdate(),1104)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1315,'V',getdate(),1103)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1316,'V',getdate(),1105)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1317,'V',getdate(),1000)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1318,'V',getdate(),1106)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1319,'V',getdate(),1107)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1320,'V',getdate(),1107)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1321,'V',getdate(),1107)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1322,'V',getdate(),1108)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1323,'V',getdate(),1108)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1324,'V',getdate(),1108)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1325,'V',getdate(),1108)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1326,'V',getdate(),1109)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1327,'V',getdate(),1109)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1328,'V',getdate(),1109)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1329,'V',getdate(),1109)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1330,'V',getdate(),1109)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1331,'V',getdate(),1108)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1332,'V',getdate(),1110)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1333,'V',getdate(),1110)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1334,'V',getdate(),1110)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1335,'V',getdate(),1110)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1336,'V',getdate(),1110)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1338,'V',getdate(),1232)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1339,'V',getdate(),1232)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1340,'V',getdate(),1232)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1341,'V',getdate(),1236)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1342,'V',getdate(),1112)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1343,'V',getdate(),1113)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1344,'V',getdate(),1114)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1345,'V',getdate(),1115)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1346,'V',getdate(),1103)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1347,'V',getdate(),1025)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1349,'V',getdate(),1035)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1350,'V',getdate(),1051)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1351,'V',getdate(),1008)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1352,'V',getdate(),1026)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1353,'V',getdate(),1046)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1354,'V',getdate(),1096)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1355,'V',getdate(),1050)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1356,'V',getdate(),1050)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1357,'V',getdate(),1050)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1358,'V',getdate(),1049)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1359,'V',getdate(),1049)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1360,'V',getdate(),1049)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1361,'V',getdate(),1052)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1362,'V',getdate(),1052)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1363,'V',getdate(),1052)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1364,'V',getdate(),1117)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1365,'V',getdate(),1234)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1367,'V',getdate(),1036)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1368,'V',getdate(),1036)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1369,'V',getdate(),1053)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1370,'V',getdate(),1053)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1371,'V',getdate(),1054)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1372,'V',getdate(),1118)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1373,'V',getdate(),1119)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1374,'V',getdate(),1120)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1375,'V',getdate(),1121)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1376,'V',getdate(),1122)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1377,'V',getdate(),1123)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1378,'V',getdate(),1125)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1379,'V',getdate(),1235)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1380,'V',getdate(),1232)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1381,'V',getdate(),1128)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1382,'V',getdate(),1128)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1383,'V',getdate(),1128)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1384,'V',getdate(),1128)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1385,'V',getdate(),1128)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1386,'V',getdate(),1130)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1387,'V',getdate(),1130)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1388,'V',getdate(),1130)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1389,'V',getdate(),1130)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1390,'V',getdate(),1130)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1391,'V',getdate(),1131)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1392,'V',getdate(),1132)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1393,'V',getdate(),1133)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1394,'V',getdate(),1134)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1395,'V',getdate(),1134)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1396,'V',getdate(),1134)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1397,'V',getdate(),1135)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1398,'V',getdate(),1136)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1399,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1400,'V',getdate(),1129)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1401,'V',getdate(),1129)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1402,'V',getdate(),1136)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1403,'V',getdate(),1129)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1404,'V',getdate(),1133)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1405,'V',getdate(),1997)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1406,'V',getdate(),1997)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1407,'V',getdate(),1997)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1408,'V',getdate(),1997)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1409,'V',getdate(),1997)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1410,'V',getdate(),1135)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1411,'V',getdate(),1135)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1412,'V',getdate(),1135)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1413,'V',getdate(),1137)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1414,'V',getdate(),1138)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1415,'V',getdate(),1149)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1416,'V',getdate(),1149)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1417,'V',getdate(),1149)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1418,'V',getdate(),1149)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1419,'V',getdate(),1149)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1420,'V',getdate(),1140)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1421,'V',getdate(),1141)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1422,'V',getdate(),1142)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1423,'V',getdate(),1141)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1424,'V',getdate(),1141)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1425,'V',getdate(),1141)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1426,'V',getdate(),1143)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1427,'V',getdate(),1144)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1428,'V',getdate(),1145)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1429,'V',getdate(),1146)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1430,'V',getdate(),1141)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1431,'V',getdate(),1147)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1432,'V',getdate(),1148)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1433,'V',getdate(),1148)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1434,'V',getdate(),1148)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1435,'V',getdate(),1148)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1436,'V',getdate(),1161)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1437,'V',getdate(),1139)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1438,'V',getdate(),1139)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1439,'V',getdate(),1139)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1440,'V',getdate(),1139)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1441,'V',getdate(),1139)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1442,'V',getdate(),1162)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1443,'V',getdate(),1162)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1444,'V',getdate(),1162)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1445,'V',getdate(),1162)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1446,'V',getdate(),1163)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1447,'V',getdate(),1164)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1448,'V',getdate(),1164)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1449,'V',getdate(),1164)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1450,'V',getdate(),1228)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1451,'V',getdate(),1151)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1452,'V',getdate(),1151)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1453,'V',getdate(),1151)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1454,'V',getdate(),1151)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1455,'V',getdate(),1151)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1456,'V',getdate(),1152)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1457,'V',getdate(),1152)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1458,'V',getdate(),1152)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1459,'V',getdate(),1152)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1460,'V',getdate(),1152)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1461,'V',getdate(),1153)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1462,'V',getdate(),1153)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1463,'V',getdate(),1153)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1464,'V',getdate(),1154)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1465,'V',getdate(),1154)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1466,'V',getdate(),1154)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1467,'V',getdate(),1154)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1469,'V',getdate(),1228)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1470,'V',getdate(),1228)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1471,'V',getdate(),1164)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1472,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1473,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1474,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1475,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1476,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1477,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1478,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1479,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1480,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1481,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1482,'V',getdate(),1137)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1483,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1484,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1485,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1486,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1487,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1488,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1489,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1490,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1491,'V',getdate(),1166)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1492,'V',getdate(),1165)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1493,'V',getdate(),1165)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1494,'V',getdate(),1168)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1495,'V',getdate(),1169)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1496,'V',getdate(),1169)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1497,'V',getdate(),1169)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1498,'V',getdate(),1169)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1499,'V',getdate(),1176)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1600,'V',getdate(),1226)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1601,'V',getdate(),1226)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1602,'V',getdate(),1226)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1603,'V',getdate(),1227)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1604,'V',getdate(),1227)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1605,'V',getdate(),1227)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1606,'V',getdate(),1229)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1607,'V',getdate(),1231)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1608,'V',getdate(),1230)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1609,'V',getdate(),1233)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1610,'V',getdate(),7067105)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1615,'V',getdate(),1232)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1616,'V',getdate(),1233)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1617,'V',getdate(),1232)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1618,'V',getdate(),1232)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1619,'V',getdate(),1238)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1621,'V',getdate(),1239)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1622,'V',getdate(),1239)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1623,'V',getdate(),1239)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1624,'V',getdate(),1239)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1625,'V',getdate(),1239)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1626,'V',getdate(),1239)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1627,'V',getdate(),1240)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1628,'V',getdate(),1240)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1629,'V',getdate(),1240)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1630,'V',getdate(),1240)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1631,'V',getdate(),1240)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1632,'V',getdate(),1240)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1633,'V',getdate(),1240)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1634,'V',getdate(),1240)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1635,'V',getdate(),1240)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1636,'V',getdate(),1240)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1700,'V',getdate(),1190)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1701,'V',getdate(),1190)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1702,'V',getdate(),1190)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1703,'V',getdate(),1190)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1704,'V',getdate(),1190)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1705,'V',getdate(),1190)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1706,'V',getdate(),1190)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1708,'V',getdate(),1991)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,2935,'V',getdate(),1998)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,2936,'V',getdate(),1998)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,2937,'V',getdate(),1998)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,2938,'V',getdate(),1998)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1709,'V',getdate(),1999)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1710,'V',getdate(),1999)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1711,'V',getdate(),1999)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,1712,'V',getdate(),1999)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (2,'R',@w_moneda,15188,'V',getdate(),1136)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (1,'R',@w_moneda,1609,'V',getdate(),152051)
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (1,'R',@w_moneda,1718,'V',getdate(),1718)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda,
	   pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (2,'R',@w_moneda,7067120,'V',getdate(),7067120)


--Exlusion de Clientes
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda, pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (2,'R',@w_moneda,610,'V',getdate(),2173)--insertar
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda, pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (2,'R',@w_moneda,611,'V',getdate(),2173)--eliminar
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda, pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (2,'R',@w_moneda,612,'V',getdate(),2173)--consultar

----------------- Script Loand Group ----------------------
-- Borra informacion
delete cobis..ad_pro_transaccion where  pt_producto = 2 
and    pt_transaccion in (800, 810)
and    pt_procedure   in (800, 810)

-- Registro en ad_pro_transaccion
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (2, 'R', @w_moneda, 800, 'V', getdate(), 800)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (2, 'R', @w_moneda, 810, 'V', getdate(), 810)

go

/*****************************************************************************/
/*                      ad_tr_autorizada                                     */
/*****************************************************************************/
use cobis
go

print '----->  ad_tr_autorizada'
go
/*
declare @w_rol smallint
select @w_rol = ro_rol
from   ad_rol
where  ro_descripcion = 'ADMINISTRADOR' and
      ro_filial = 1
*/

declare @w_rol smallint
select @w_rol = ro_rol
from ad_rol
where ro_descripcion = 'MENU POR PROCESOS' and
      ro_filial = 1

print '***  ad_rol .....(Creacion de rol MENU POR PROCESOS)'

/*
if NOT EXISTS (select * from ad_rol where
               ro_descripcion = 'ADMINISTRADOR'
                and ro_filial = 1)
begin
        select @w_rol = max(ro_rol) + 1
        from ad_rol
        where ro_filial = 1

        update cl_seqnos
        set siguiente = @w_rol
        where tabla = 'ad_rol'

        insert into ad_rol
        (ro_rol,ro_filial,ro_descripcion,ro_fecha_crea,ro_creador,
        ro_estado,ro_fecha_ult_mod)
       values  (@w_rol,1,'ADMINISTRADOR',getdate(),1,'V',getdate())
end
else begin
        print 'YA EXISTE EL ROL ADMINISTRADOR'
end
*/

if NOT EXISTS (select * from ad_rol where
               ro_descripcion = 'MENU POR PROCESOS'
                and ro_filial = 1)
begin
        select @w_rol = max(ro_rol) + 1
        from ad_rol
        where ro_filial = 1

        update cl_seqnos
        set siguiente = @w_rol
        where tabla = 'ad_rol'

        insert into ad_rol
        (ro_rol,ro_filial,ro_descripcion,ro_fecha_crea,ro_creador,
        ro_estado,ro_fecha_ult_mod)
       values  (@w_rol,1,'MENU POR PROCESOS',getdate(),1,'V',getdate())
end
else begin
        print 'YA EXISTE EL ROL MENU POR PROCESOS'
end




print '***** ASIGNACION DE PRODUCTOS AL ROL MENU POR PROCESOS --ADMINISTRADOR ****'
go

declare @w_rol smallint
select @w_rol = ro_rol
from ad_rol
where ro_descripcion = 'MENU POR PROCESOS' and ro_filial = 1

if exists (select * from ad_pro_rol where pr_rol = @w_rol)
  delete ad_pro_rol
  where pr_rol = @w_rol
go

declare @w_rol smallint
select @w_rol = ro_rol
from ad_rol
where ro_descripcion = 'MENU POR PROCESOS' and ro_filial = 1

/*  Asignacion del producto firmas al rol MENU POR PROCESOS  */

insert into ad_pro_rol  (pr_rol ,pr_producto, pr_tipo, pr_moneda,
                         pr_fecha_crea, pr_autorizante, pr_estado,
                         pr_fecha_ult_mod, pr_menu_inicial)
                values  (@w_rol, 2, 'R', 0, getdate(),1, 'V', getdate(), null)


declare @w_moneda tinyint
select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

print '----->  Insertando transacciones autorizadas'

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 100
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,100,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 101
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,101,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 102
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,102,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 103
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,103,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 104
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,104,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 105
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,105,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 106
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,106,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 107
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,107,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 108
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,108,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 109
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,109,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 110
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,110,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 111
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,111,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 112
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,112,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 113
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,113,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 114
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,114,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 115
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,115,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 116
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,116,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 117
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,117,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 118
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,118,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 119
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,119,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 120
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,120,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 121
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,121,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 122
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,122,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 123
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,123,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 124
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,124,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 125
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,125,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 126
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,126,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 127
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,127,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 128
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,128,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 129
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,129,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 130
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,130,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 131
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,131,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 132
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,132,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 133
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,133,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 134
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,134,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 135
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,135,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 136
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,136,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 137
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,137,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 138
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,138,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 139
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,139,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 140
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,140,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 141
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,141,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 142
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,142,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 143
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,143,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 144
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,144,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 145
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,145,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 146
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,146,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 147
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,147,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 148
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,148,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 149
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,149,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 150
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,150,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 151
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,151,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 152
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,152,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 153
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,153,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 154
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,154,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 155
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,155,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 156
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,156,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 157
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,157,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 158
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,158,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 159
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,159,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 160
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,160,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 161
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,161,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 162
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,162,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 163
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,163,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 164
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,164,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 165
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,165,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 166
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,166,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 167
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,167,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 168
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,168,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 169
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,169,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 170
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,170,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 171
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,171,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 172
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,172,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 173
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,173,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 174
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,174,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 175
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,175,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 176
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,176,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 177
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,177,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 178
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,178,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 179
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,179,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 180
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,180,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 181
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,181,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 182
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,182,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 183
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,183,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 184
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,184,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 185
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,185,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 186
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,186,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 187
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,187,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 188
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,188,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 189
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,189,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 190
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,190,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 191
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,191,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 195
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,195,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 196
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,196,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 197
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,197,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 198
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,198,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 199
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,199,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1000
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1000,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1001
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1001,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1002
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1002,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1003
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1003,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1004
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1004,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1005
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1005,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1006
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1006,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1007
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1007,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1008
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1008,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1009
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1009,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1010
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1010,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1011
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1011,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1012
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1012,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1013
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1013,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1014
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1014,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1015
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1015,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1016
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1016,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1017
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1017,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1018
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1018,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1019
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1019,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1020
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1020,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1021
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1021,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1022
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1022,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1023
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1023,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1024
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1024,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1025
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1025,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1026
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1026,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1027
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1027,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1028
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1028,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1029
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1029,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1030
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1030,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1031
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1031,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1035
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1035,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1036
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1036,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1037
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1037,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1038
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1038,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1039
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1039,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1040
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1040,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1041
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1041,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1042
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1042,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1043
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1043,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1044
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1044,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1045
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1045,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1046
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1046,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1047
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1047,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1048
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1048,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1049
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1049,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1050
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1050,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1051
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1051,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1052
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1052,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1053
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1053,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1054
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1054,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1055
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1055,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1056
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1056,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1057
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1057,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1058
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1058,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1059
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1059,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1060
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1060,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1061
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1061,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1065
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1065,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1066
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1066,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1067
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1067,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1068
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1068,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1069
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1069,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1070
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1070,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1071
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1071,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1072
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1072,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1073
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1073,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1074
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1074,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1075
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1075,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1100
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1100,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1101
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1101,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1102
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1102,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1103
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1103,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1104
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1104,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1105
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1105,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1106
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1106,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1108
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1108,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1109
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1109,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1110
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1110,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1111
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1111,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1112
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1112,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1113
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1113,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1115
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1115,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1116
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1116,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1117
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1117,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1119
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1119,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1120
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1120,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1121
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1121,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1122
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1122,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1123
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1123,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1124
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1124,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1128
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1128,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1130
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1130,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1131
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1131,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1132
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1132,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1133
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1133,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1134
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1134,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1137
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1137,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1138
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1138,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1139
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1139,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1140
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1140,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1141
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1141,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1142
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1142,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1143
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1143,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1144
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1144,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1145
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1145,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1147
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1147,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1148
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1148,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1149
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1149,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1150
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1150,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1151
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1151,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1152
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1152,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1155
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1155,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1156
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1156,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1157
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1157,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1158
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1158,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1159
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1159,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1160
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1160,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1161
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1161,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1162
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1162,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1163
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1163,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1164
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1164,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1165
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1165,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1166
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1166,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1167
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1167,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1168
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1168,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1169
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1169,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1170
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1170,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1171
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1171,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1172
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1172,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1173
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1173,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1174
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1174,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1175
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1175,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1176
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1176,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1177
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1177,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1178
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1178,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1179
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1179,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1180
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1180,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1181
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1181,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1182
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1182,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1183
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1183,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1184
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1184,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1185
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1185,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1186
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1186,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1187
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1187,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1188
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1188,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1189
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1189,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1190
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1190,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1191
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1191,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1192
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1192,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1194
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1194,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1195
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1195,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1196
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1196,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1197
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1197,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1198
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1198,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1199
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1199,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1200
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1200,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1201
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1201,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1202
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1202,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1203
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1203,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1204
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1204,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1205
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1205,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1206
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1206,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1207
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1207,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1208
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1208,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1209
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1209,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1210
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1210,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1211
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1211,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1212
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1212,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1213
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1213,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1214
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1214,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1215
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1215,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1216
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1216,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1218
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1218,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1219
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1219,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1220
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1220,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1221
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1221,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1222
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1222,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1223
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1223,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1224
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1224,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1225
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1225,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1226
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1226,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1227
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1227,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1228
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1228,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1229
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1229,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1230
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1230,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1231
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1231,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1232
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1232,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1233
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1233,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1234
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1234,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1235
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1235,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1236
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1236,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1237
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1237,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1238
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1238,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1239
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1239,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1240
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1240,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1241
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1241,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1242
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1242,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1243
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1243,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1244
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1244,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1245
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1245,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1246
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1246,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1247
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1247,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1248
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1248,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1249
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1249,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1250
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1250,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1251
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1251,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1252
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1252,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1253
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1253,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1254
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1254,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1255
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1255,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1256
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1256,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1257
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1257,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1258
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1258,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1259
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1259,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1260
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1260,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1261
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1261,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1262
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1262,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1263
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1263,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1264
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1264,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1265
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1265,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1266
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1266,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1267
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1267,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1268
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1268,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1269
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1269,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1270
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1270,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1271
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1271,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1272
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1272,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1273
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1273,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1274
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1274,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1275
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1275,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1276
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1276,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1277
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1277,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1278
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1278,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1279
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1279,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1280
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1280,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1281
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1281,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1282
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1282,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1283
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1283,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1284
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1284,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1285
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1285,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1286
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1286,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1287
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1287,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1288
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1288,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1289
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1289,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1290
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1290,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1291
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1291,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1292
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1292,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1293
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1293,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1294
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1294,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1295
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1295,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1296
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1296,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1297
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1297,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1298
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1298,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1299
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1299,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1300
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1300,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1301
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1301,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1302
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1302,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1303
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1303,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1304
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1304,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1305
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1305,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1306
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1306,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1307
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1307,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1308
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1308,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1309
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1309,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1310
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1310,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1311
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1311,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1312
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1312,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1313
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1313,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1314
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1314,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1315
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1315,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1316
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1316,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1317
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1317,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1318
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1318,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1319
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1319,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1320
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1320,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1321
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1321,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1322
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1322,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1323
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1323,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1324
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1324,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1325
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1325,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1326
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1326,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1327
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1327,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1328
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1328,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1329
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1329,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1330
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1330,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1331
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1331,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1332
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1332,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1333
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1333,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1334
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1334,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1335
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1335,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1336
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1336,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1338
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1338,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1339
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1339,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1340
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1340,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1341
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1341,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1342
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1342,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1343
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1343,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1344
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1344,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1345
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1345,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1346
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1346,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1347
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1347,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1349
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1349,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1350
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1350,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1351
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1351,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1352
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1352,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1353
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1353,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1354
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1354,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1355
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1355,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1356
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1356,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1357
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1357,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1358
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1358,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1359
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1359,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1360
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1360,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1361
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1361,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1362
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1362,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1363
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1363,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1364
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1364,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1365
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1365,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1367
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1367,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1368
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1368,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1369
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1369,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1370
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1370,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1371
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1371,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1372
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1372,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1373
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1373,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1374
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1374,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1375
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1375,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1376
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1376,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1377
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1377,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1378
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1378,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1379
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1379,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1381
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1381,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1382
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1382,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1383
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1383,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1384
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1384,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1385
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1385,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1386
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1386,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1387
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1387,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1388
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1388,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1389
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1389,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1390
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1390,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1391
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1391,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1392
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1392,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1393
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1393,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1394
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1394,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1395
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1395,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1396
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1396,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1397
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1397,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1398
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1398,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1399
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1399,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1400
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1400,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1401
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1401,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1402
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1402,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1403
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1403,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1404
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1404,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1405
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1405,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1406
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1406,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1407
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1407,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1408
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1408,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1409
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1409,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1410
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1410,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1411
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1411,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1412
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1412,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1413
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1413,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1414
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1414,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1415
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1415,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1416
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1416,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1417
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1417,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1418
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1418,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1419
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1419,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1420
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1420,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1421
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1421,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1422
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1422,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1423
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1423,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1424
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1424,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1425
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1425,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1426
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1426,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1427
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1427,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1428
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1428,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1429
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1429,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1430
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1430,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1431
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1431,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1432
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1432,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1433
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1433,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1434
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1434,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1435
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1435,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1436
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1436,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1437
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1437,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1438
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1438,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1439
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1439,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1440
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1440,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1441
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1441,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1442
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1442,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1443
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1443,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1444
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1444,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1445
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1445,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1446
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1446,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1447
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1447,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1448
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1448,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1449
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1449,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1450
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1450,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1451
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1451,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1452
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1452,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1453
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1453,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1454
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1454,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1455
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1455,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1456
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1456,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1457
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1457,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1458
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1458,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1459
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1459,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1460
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1460,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1461
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1461,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1462
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1462,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1463
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1463,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1464
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1464,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1465
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1465,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1466
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1466,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1467
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1467,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1471
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1471,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1472
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1472,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1473
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1473,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1474
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1474,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1475
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1475,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1476
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1476,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1477
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1477,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1478
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1478,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1479
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1479,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1480
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1480,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1481
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1481,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1482
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1482,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1483
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1483,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1484
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1484,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1485
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1485,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1486
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1486,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1487
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1487,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1488
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1488,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1489
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1489,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1490
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1490,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1491
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1491,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1492
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1492,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1493
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1493,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1494
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1494,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1495
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1495,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1496
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1496,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1497
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1497,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1498
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1498,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1499
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1499,@w_rol,getdate(),1,'V',getdate())
end
go

/* Transacciones de conexion y cambio de password */

declare @w_rol smallint
select @w_rol = ro_rol
from ad_rol
where ro_descripcion = 'ADMINISTRADOR' and
      ro_filial = 1

declare @w_moneda tinyint
select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 568
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,568,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 584
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,584,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 585
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,585,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 599
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,599,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1501
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1501,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1502
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1502,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1503
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1503,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1504
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1504,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1528
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1528,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1529
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1529,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1549
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1549,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1550
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1550,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1552
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1552,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1553
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1553,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1555
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1555,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1556
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1556,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1558
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1558,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1559
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1559,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1561
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1561,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1562
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1562,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1564
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1564,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1565
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1565,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1567
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1567,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1571
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1571,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1574
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1574,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1577
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1577,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1578
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1578,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1579
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1579,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1609
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,1609,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 15000
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,15000,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 15001
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,15001,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 15029
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,15029,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 15031
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,15031,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 15062
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,15062,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 15093
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,15093,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 15098
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,15098,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 15103
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,15103,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 15153
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,15153,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 15168
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,15168,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 15222
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,15222,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 15244
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,15244,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 22967
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,22967,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 28744
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,28744,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 28745
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (1,'R',@w_moneda,28745,@w_rol,getdate(),1,'V',getdate())
end
go

/* Transacciones de otros modulos */

declare @w_rol smallint
select @w_rol = ro_rol
from ad_rol
where ro_descripcion = 'ADMINISTRADOR' and
      ro_filial = 1

declare @w_moneda tinyint
select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'


if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1278
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (3,'R',@w_moneda,1278,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1503
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (3,'R',@w_moneda,1503,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 220
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (4,'R',@w_moneda,220,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1503
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (4,'R',@w_moneda,1503,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 3010
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (5,'R',@w_moneda,3010,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 3016
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (5,'R',@w_moneda,3016,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 3017
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (5,'R',@w_moneda,3017,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 3022
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (5,'R',@w_moneda,3022,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 6532
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (6,'R',@w_moneda,6532,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 6533
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (6,'R',@w_moneda,6533,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7001
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7001,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7002
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7002,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7003
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7003,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7004
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7004,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7005
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7005,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7014
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7014,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7015
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7015,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7017
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7017,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7018
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7018,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7019
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7019,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7020
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7020,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7021
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7021,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7022
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7022,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7023
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7023,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7024
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7024,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7037
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7037,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7145
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7145,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 7212
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (7,'R',@w_moneda,7212,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1502
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (8,'R',@w_moneda,1502,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1503
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (10,'R',@w_moneda,1503,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1501
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (13,'R',@w_moneda,1501,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1501
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,1501,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1502
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,1502,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1503
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,1503,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1579
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,1579,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14150
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14150,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14238
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14238,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14401
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14401,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14452
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14452,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14464
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14464,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14502
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14502,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14507
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14507,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14508
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14508,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14539
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14539,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14551
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14551,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14559
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14559,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14637
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14637,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14638
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14638,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14639
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14639,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14640
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14640,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14641
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14641,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14643
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14643,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 14805
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (14,'R',@w_moneda,14805,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 19054
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (19,'R',@w_moneda,19054,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 19056
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (19,'R',@w_moneda,19056,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 19245
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (19,'R',@w_moneda,19245,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 19384
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (19,'R',@w_moneda,19384,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 19455
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (19,'R',@w_moneda,19455,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 19475
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (19,'R',@w_moneda,19475,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 19504
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (19,'R',@w_moneda,19504,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 19514
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (19,'R',@w_moneda,19514,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1503
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,1503,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21016
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21016,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21250
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21250,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21301
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21301,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21326
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21326,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21413
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21413,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21414
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21414,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21415
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21415,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21416
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21416,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21428
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21428,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21432
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21432,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21520
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21520,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21526
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21526,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21601
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21601,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21613
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21613,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21623
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21623,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21731
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21731,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21736
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21736,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21795
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21795,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21797
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21797,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21811
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21811,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21815
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21815,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21819
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21819,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21823
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21823,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21839
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21839,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21863
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21863,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21895
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21895,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21897
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21897,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21951
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21951,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21953
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21953,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 21998
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (21,'R',@w_moneda,21998,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 26228
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (26,'R',@w_moneda,26228,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 29322
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (42,'R',@w_moneda,29322,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 29334
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (42,'R',@w_moneda,29334,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 29387
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (42,'R',@w_moneda,29387,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 29388
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (42,'R',@w_moneda,29388,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 29392
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (42,'R',@w_moneda,29392,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 29402
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (42,'R',@w_moneda,29402,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 15168
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (60,'R',@w_moneda,15168,@w_rol,getdate(),1,'V',getdate())
end

-------1600 - 29432
if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1600
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1600,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1601
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1601,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1602
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1602,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1603
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1603,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1604
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1604,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1605
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1605,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1606
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1606,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1607
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1607,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1609
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1609,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1615
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1615,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1617
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1617,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1618
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1618,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1619
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1619,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1621
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1621,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1700
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1700,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1701
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1701,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1702
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1702,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1703
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1703,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1704
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1704,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1705
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1705,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1706
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1706,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 1708
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1708,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 3017
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,3017,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 3022
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,3022,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 18323
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,18323,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 18324
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,18324,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 18325
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,18325,@w_rol,getdate(),1,'V',getdate())
end

if exists(select 1
           from ad_tr_autorizada
           where ta_transaccion = 29432
           and ta_moneda        = @w_moneda
           and ta_rol           = @w_rol)
begin
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,29432,@w_rol,getdate(),1,'V',getdate())
end

-------1600 - 29432

---x
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1062
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1062,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1063
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1063,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1064
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1064,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1083
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1083,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1380
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1380,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1469
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1469,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1470
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1470,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1608
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1608,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1610
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1610,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1616
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1616,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1622
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1622,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1623
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1623,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1624
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1624,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1625
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1625,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1626
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1626,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1627
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1627,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1628
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1628,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1629
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1629,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1630
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1630,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1631
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1631,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1632
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1632,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1633
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1633,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1634
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1634,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1635
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1635,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1636
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,1636,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 2935
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,2935,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 2936
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,2936,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 2937
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,2937,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 2938
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,2938,@w_rol,getdate(),1,'V',getdate())
end
  
if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 15188
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,
       ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,
       ta_estado,ta_fecha_ult_mod)
values (2,'R',@w_moneda,15188,@w_rol,getdate(),1,'V',getdate())
end

----------------- Script Loand Group ----------------------

if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 800
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
	insert into cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	values (2, 'R',@w_moneda, 800, @w_rol, getdate(), 1, 'V', getdate())
end

if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 810
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
	insert into cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	values (2, 'R',@w_moneda, 810, @w_rol, getdate(), 1, 'V', getdate())
end

if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1709
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
	insert into cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	values (2, 'R',@w_moneda, 1709, @w_rol, getdate(), 1, 'V', getdate())
end

if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1710
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
	insert into cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	values (2, 'R',@w_moneda, 1710, @w_rol, getdate(), 1, 'V', getdate())
end

if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1711
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
	insert into cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	values (2, 'R',@w_moneda, 1711, @w_rol, getdate(), 1, 'V', getdate())
end

if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1712
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
	insert into cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	values (2, 'R',@w_moneda, 1712, @w_rol, getdate(), 1, 'V', getdate())
end

if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 7067120
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
	INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (2, 'R',@w_moneda,7067120, @w_rol, getdate(), 1, 'V', getdate())
end


if exists(select 1  
           from ad_tr_autorizada 
           where ta_transaccion = 1718
           and ta_moneda        = @w_moneda 
           and ta_rol           = @w_rol) 
begin 
        print '----->  ya existe la trn ok'
end
else
begin
	INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (2, 'R',@w_moneda,1718, @w_rol, getdate(), 1, 'V', getdate())
end

GO


---------------------------------------------------
------ ACTUALIZACION CLIENTE COLECTIVO ------------
---------------------------------------------------
use cobis
go

declare 
@w_tn_trn_code     int,
@w_pd_procedure    int,
@w_producto        int,
@w_rol             int

select
@w_tn_trn_code  = 1720,
@w_pd_procedure = 1720


select @w_producto = pd_producto 
from  cl_producto 
where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'ASESOR MOVIL' 

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code and tn_descripcion ='ACTUALIZACION CLIENTE COLECTIVO'
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_tn_trn_code, 'ACTUALIZACION CLIENTE COLECTIVO', @w_tn_trn_code, 'ACTUALIZACION CLIENTE COLECTIVO')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure and pd_stored_procedure ='sp_cliente_col_upd' 
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_pd_procedure, 'sp_cliente_col_upd', 'cobis', 'V', getdate(), 'clicolupd.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code and ta_rol=@w_rol
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_producto, 'R', 0, @w_tn_trn_code, @w_rol, getdate(), 1, 'V', getdate())
                    

--Exclusion de Clientes
if exists (select 1 from ad_tr_autorizada where ta_producto = 2 and ta_rol = @w_rol and ta_transaccion in(610,611,612))
	delete ad_tr_autorizada where ta_producto = 2 and ta_rol = @w_rol and ta_transaccion in(610,611,612)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (2, 'R', @w_moneda, 610, @w_rol, getdate(), 1, 'V', getdate())

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (2, 'R', @w_moneda, 611, @w_rol, getdate(), 1, 'V', getdate())

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (2, 'R', @w_moneda, 612, @w_rol, getdate(), 1, 'V', getdate())

-----------------------------------------------
----   OBTENER CLIENTE LCR BIOMETRICO ---------
-----------------------------------------------

use cobis
go

declare 
@w_producto              int,
@w_tn_trn_code           int,
@w_pd_procedure          int

declare @w_roles table (
   rol       int
)

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

select 
@w_tn_trn_code  = 18001,
@w_pd_procedure = 18001

insert into @w_roles
select ro_rol
from ad_rol
where ro_descripcion in (
'ADMINISTRADOR',
'FUNCIONARIO OFICINA',
'CONSULTA',
'ASESOR',
'GERENTE REGIONAL',
'MESA DE OPERACIONES',
'NORMATIVO',
'GERENTE OFICINA',
'AUDITORIA'
)

delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code 
insert into cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
values(@w_tn_trn_code, 'OBTENER CLIENTE LCR BIOMETRICO', convert(char(6), @w_tn_trn_code), 'OBTENER CLIENTE LCR BIOMETRICO')

delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure 
insert into cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values(@w_pd_procedure, 'sp_lcr_consulta_bio', 'cobis', 'V', getdate(), 'lcr_consbio.sp')

delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
insert into cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code 
insert into cobis..ad_tr_autorizada
select @w_producto, 'R', 0, @w_tn_trn_code, rol, getdate(), 1, 'V', getdate()
from @w_roles


-----------------------------------------------
----  OBTENER CATALOGO REGISTROS VIGENTES -----
-----------------------------------------------
use cobis
go

declare 
@w_producto           int,
@w_tn_trn_code        int,
@w_pd_procedure       int

declare @w_roles table (
   rol       int
)

select @w_producto = pd_producto 
from cobis..cl_producto 
where pd_descripcion = 'CLIENTES' -- Obtiene el codigo del producto

select 
@w_tn_trn_code = 21744, -- Se inicializa el codigo de la transacción
@w_pd_procedure  = 21744

insert into @w_roles
select ro_rol
from ad_rol
where ro_descripcion in (
'ADMINISTRADOR',
'FUNCIONARIO OFICINA',
'ASESOR',
'MESA DE OPERACIONES'
)

-- SE INSERTA EN LA TABLA DE TRANSACCIONES CON EL SECUENCIAL DE TRANSACCIONES
delete from cobis..cl_ttransaccion where tn_trn_code = @w_tn_trn_code
insert into cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values(@w_tn_trn_code, 'OBTENER CATALOGO REGISTROS VIGENTES', convert(char(6), @w_tn_trn_code), 'OBTENER CATALOGO REGISTROS VIGENTES')

-- SE INSERTA EN LA TABLA AD_PROCEDURE EL SP CON EL SECUENCUAL DE PROCEDURE
delete from cobis..ad_procedure where pd_procedure = @w_pd_procedure
insert into cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values(@w_pd_procedure, 'sp_obtener_catalogo', 'cob_credito', 'V', getdate(), 'sp_obt_cat.sp')

-- ASOCIACION DE LA TRANSACCION CON EL SP POR LA TRANSACCION SECUENCIAL
delete from cobis..ad_pro_transaccion where pt_transaccion=@w_tn_trn_code and pt_procedure = @w_pd_procedure
insert into cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
values(@w_producto, 'R', 0, @w_tn_trn_code, 'V', getdate(), @w_pd_procedure, NULL)

-- AUTORIZACION DE LA TRANSACCION EN EL ROL CON EL SECUENCIAL DEL DE LA TRANSACCION
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_tn_trn_code
insert into cobis..ad_tr_autorizada
select @w_producto, 'R', 0, @w_tn_trn_code, rol, getdate(), 1, 'V', getdate()
from @w_roles

go

