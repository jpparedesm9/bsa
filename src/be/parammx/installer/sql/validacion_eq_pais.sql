/************************************************************************/
/*    ARCHIVO:         validacion_eq_pais.sql                           */
/*    NOMBRE LOGICO:   validacion_eq_pais.sql                           */
/*    PRODUCTO:        AHORROS                                          */
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
/*   Script de validación de equivalencias codigos cobis,               */
/*  con los codigos del documento entregado                             */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      26/08/2016     Karen Meza           Emision Inicial             */  
/************************************************************************/



use cob_conta_super
GO
if exists(SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico ='IUDI' AND pa_producto = 'AHO')
begin

IF EXISTS (select 1 from cob_conta_super..sb_equivalencias WHERE eq_catalogo = 'CODPAIS')
DELETE cob_conta_super..sb_equivalencias  WHERE eq_catalogo = 'CODPAIS'

INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '100', '100', 'BULGARIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '104', '104', 'MYANMAR', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '108', '108', 'BURUNDI', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '112', '112', 'BIELORRUSIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '116', '116', 'CAMBOYA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '12', '12', 'ARGELIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '120', '120', 'CAMERUN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '124', '124', 'CANADA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '132', '132', 'CABO VERDE', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '136', '136', 'CAYMAN ISLANDS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '140', '140', 'REP. CENTRO AFRICANA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '144', '144', 'SRI LANKA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '148', '148', 'CHAD', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '152', '152', 'CHILE', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '156', '156', 'CHINA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '158', '158', 'TAIWAN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '16', '16', 'SAMOA AMERICANA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '162', '162', 'ISLA DE NAVIDAD', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '166', '166', 'ISLAS COCOS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '170', '170', 'COLOMBIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '174', '174', 'COMORAS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '175', '175', 'MAYOTTE', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '178', '178', 'CONGO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '180', '180', 'REPUBLICA DEMOCRATICA DEL CONGO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '184', '184', 'ISLAS COOK', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '188', '188', 'COSTA RICA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '191', '191', 'CROACIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '192', '192', 'CUBA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '196', '196', 'CHIPRE', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '20', '20', 'ANDORRA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '203', '203', 'CHECOSLOVAQUIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '204', '204', 'BENIN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '208', '208', 'DINAMARCA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '212', '212', 'DOMINICA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '214', '214', 'REPUBLICA DOMINICANA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '218', '218', 'ECUADOR', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '222', '222', 'EL SALVADOR', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '226', '226', 'GUINEA ECUATORIAL', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '231', '231', 'ETIOPIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '232', '232', 'ERITREA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '233', '233', 'ESTONIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '234', '234', 'ISLAS FEROE', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '238', '238', 'ISLAS MALVINAS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '239', '239', 'ISLAS GEORGIAS DEL SUR Y SANDWICH DEL SUR', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '24', '24', 'ANGOLA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '242', '242', 'FIYI', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '246', '246', 'FINLANDIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '250', '250', 'FRANCIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '254', '254', 'GUAYANA FRANCESA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '258', '258', 'POLINESIA FRANCESA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '260', '260', 'TERRITORIOS AUSTRALES FRANCESES', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '262', '262', 'REPÚBLICA DE YIBUTI', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '266', '266', 'GABON', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '268', '268', 'GEORGIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '270', '270', 'GAMBIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '276', '276', 'ALEMANIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '28', '28', 'ANTIGUA Y BARBUDA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '288', '288', 'GHANA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '292', '292', 'GIBRALTAR', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '296', '296', 'KIRIBATI', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '300', '300', 'GRECIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '304', '304', 'GROENLANDIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '308', '308', 'GRANADA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '31', '31', 'AZERBAIYAN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '312', '312', 'GUADALUPE', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '316', '316', 'GUAM', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '32', '32', 'ARGENTINA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '320', '320', 'GUATEMALA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '324', '324', 'GUINEA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '328', '328', 'GUYANA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '332', '332', 'HAITI', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '336', '336', 'ESTADO DE LA CIUDAD DEL VATICANO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '340', '340', 'HONDURAS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '348', '348', 'HUNGRIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '352', '352', 'ISLANDIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '356', '356', 'INDIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '36', '36', 'AUSTRALIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '360', '360', 'INDONESIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '364', '364', 'IRAN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '368', '368', 'IRAK', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '372', '372', 'IRLANDA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '376', '376', 'ISRAEL', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '380', '380', 'ITALIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '384', '384', 'COSTA DE MARFIL', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '388', '388', 'JAMAICA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '392', '392', 'JAPON', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '4', '4', 'AFGANISTAN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '40', '40', 'AUSTRIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '400', '400', 'JORDANIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '404', '404', 'KENIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '408', '408', 'KOREA DEL NORTE', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '410', '410', 'KOREA DEL SUR', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '414', '414', 'KUWAIT', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '417', '417', 'KIRGUISTAN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '418', '418', 'LAOS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '422', '422', 'LIBANO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '426', '426', 'LESOTHO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '428', '428', 'LETONIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '430', '430', 'LIBERIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '434', '434', 'LIBIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '435', '435', 'UCRANIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '438', '438', 'LIECHTENSTEIN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '44', '44', 'BAHAMAS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '440', '440', 'REPUBLICA DE LITUANIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '442', '442', 'LUXEMBURGO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '446', '446', 'MACAO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '447', '447', 'KASAJISTAN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '450', '450', 'MADAGASCAR', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '454', '454', 'MALAWI', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '458', '458', 'MALASIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '462', '462', 'MALDIVAS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '466', '466', 'MALI', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '470', '470', 'MALTA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '474', '474', 'MARTINICA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '478', '478', 'MAURITANIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '48', '48', 'BAHREIN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '480', '480', 'MAURICIO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '484', '484', 'MEXICO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '492', '492', 'MONACO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '496', '496', 'MONGOLIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '498', '498', 'MOLDAVIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '499', '499', 'MONTENEGRO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '50', '50', 'BANGLADESH', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '500', '500', 'MONTSERRAT', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '504', '504', 'MARRUECOS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '508', '508', 'MOZAMBIQUE', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '51', '51', 'REPUBLICA DE ARMENIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '512', '512', 'OMAN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '516', '516', 'NAMIBIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '52', '52', 'BARBADOS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '520', '520', 'NAURU', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '524', '524', 'NEPAL', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '528', '528', 'HOLANDA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '530', '530', 'ANTILLAS NEERLANDESAS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '533', '533', 'ARUBA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '540', '540', 'NUEVA CALEDONIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '548', '548', 'VANUATU', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '554', '554', 'NUEVA ZELANDA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '558', '558', 'NICARAGUA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '56', '56', 'BELGICA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '562', '562', 'NIGER', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '566', '566', 'NIGERIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '570', '570', 'ISLA NIUE', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '574', '574', 'ISLA NORFOLK', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '578', '578', 'NORUEGA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '580', '580', 'ISLAS MARIANAS DEL NORTE', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '583', '583', 'MICRONESIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '584', '584', 'ISLAS MARSHALL', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '585', '585', 'PALAOS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '586', '586', 'PAKISTAN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '591', '591', 'PANAMA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '598', '598', 'PAPUA NUEVA GUINEA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '60', '60', 'BERMUDAS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '600', '600', 'PARAGUAY', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '604', '604', 'PERU', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '608', '608', 'FILIPINAS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '612', '612', 'ISLAS PITCAIRN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '616', '616', 'POLONIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '620', '620', 'PORTUGAL', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '624', '624', 'GUINEA BISSAU', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '626', '626', 'TIMOR ORIENTAL', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '630', '630', 'PUERTO RICO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '631', '631', 'TRINIDAD Y TOBAGO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '634', '634', 'QATAR', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '638', '638', 'REUNION', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '64', '64', 'BUTAN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '642', '642', 'RUMANIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '643', '643', 'FEDERACION RUSA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '646', '646', 'RUANDA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '654', '654', 'SANTA HELENA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '659', '659', 'SAN CRISTOBAL Y NIEVES', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '660', '660', 'ANGUILA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '662', '662', 'SANTA LUCIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '666', '666', 'SAN PEDRO Y MIQUELON', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '670', '670', 'SAN VICENTE Y LAS GRANADINAS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '674', '674', 'REPÚBLICA DE SAN MARINO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '678', '678', 'SANTO TOME Y PRINCIPE', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '68', '68', 'BOLIVIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '682', '682', 'ARABIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '686', '686', 'SENEGAL', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '688', '688', 'SERBIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '690', '690', 'SEYCHELLES', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '694', '694', 'SIERRA LEONA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '70', '70', 'BOSNIA HERZEGOBINA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '702', '702', 'SINGAPUR', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '703', '703', 'ESLOVAQUIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '704', '704', 'VIETNAM', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '705', '705', 'ESLOVENIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '706', '706', 'SOMALIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '710', '710', 'SUD AFRICA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '716', '716', 'ZIMBABWE', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '72', '72', 'BOTSWANA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '724', '724', 'ESPAÑA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '732', '732', 'SAHARA OCCIDENTAL', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '736', '736', 'SUDAN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '740', '740', 'SURINAM', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '744', '744', 'ISLAS SVALBARD Y JAN MAYEN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '748', '748', 'SWAZILANDIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '752', '752', 'SUECIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '756', '756', 'SUIZA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '76', '76', 'BRASIL', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '760', '760', 'SIRIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '762', '762', 'TAYIKISTAN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '764', '764', 'TAILANDIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '768', '768', 'TOGO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '772', '772', 'TOKELAU', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '776', '776', 'TONGA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '784', '784', 'EMIRATOS ARABES UNIDOS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '788', '788', 'TUNEZ', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '792', '792', 'TURQUIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '795', '795', 'TURKMENISTAN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '796', '796', 'ISLAS TURCAS Y CAICOS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '798', '798', 'TUVALU', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '8', '8', 'ALBANIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '800', '800', 'UGANDA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '807', '807', 'MACEDONIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '818', '818', 'EGIPTO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '826', '826', 'INGLATERRA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '834', '834', 'TANZANIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '84', '84', 'BELICE', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '840', '840', 'ESTADOS UNIDOS DE NORTEAMERICA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '850', '850', 'ISLAS VIRGENES ESTADOUNIDENSES', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '854', '854', 'BURKINA FASO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '858', '858', 'URUGUAY', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '86', '86', 'TERRITORIO BRITANICO DEL OCEANO INDICO', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '860', '860', 'UZBEKISTAN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '862', '862', 'VENEZUELA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '876', '876', 'ISLAS WALLIS Y FUTUNA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '882', '882', 'SAMOA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '887', '887', 'YEMEN', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '894', '894', 'ZAMBIA', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '90', '90', 'ISLAS SALOMON', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '92', '92', 'ISLAS VIRGENES BRITANICAS', 'V')


INSERT INTO sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('CODPAIS', '96', '96', 'BRUNEI DARUSSALAM', 'V')

end
GO





