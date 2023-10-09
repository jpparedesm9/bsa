/************************************************************************/
/*    ARCHIVO:         carga_cl_pais.sql                                */
/*    NOMBRE LOGICO:   carga_cl_pais.sql                                */
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
/*   Script de carga de paises                                          */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      26/08/2016     Karen Meza           Emision Inicial             */  
/************************************************************************/

use cobis
go

truncate table cl_pais

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (4, 'AFGANISTAN', 'AFG', 'Afganistan', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (8, 'ALBANIA', 'ALB', 'Albania', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (12, 'ARGELIA', 'AGL', 'Argelia', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (16, 'SAMOA AMERICANA', 'AS', 'SAMOA AMERICANA', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (20, 'ANDORRA', 'AND', 'Andorra', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (24, 'ANGOLA', 'AGO', 'Angola', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (28, 'ANTIGUA Y BARBUDA', 'ATH', 'Antillas Holandesas', 'V', 'AMC')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (31, 'AZERBAIYAN', 'AZE', 'Azerbaiyan', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (32, 'ARGENTINA', 'ARG', 'Argentina', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (36, 'AUSTRALIA', 'AUS', 'Australia', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (40, 'AUSTRIA', 'AST', 'Austria', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (44, 'BAHAMAS', 'BAH', 'Bahamas El', 'V', 'AMC')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (48, 'BAHREIN', 'BHR', 'Bahrain', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (50, 'BANGLADESH', 'BAN', 'Bangladesh', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (51, 'REPUBLICA DE ARMENIA', 'AM', 'REPUBLICA DE ARMENIA', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (52, 'BARBADOS', 'BAR', 'Barbados', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (56, 'BELGICA', 'BLG', 'B+lgica', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (60, 'BERMUDAS', 'BM', 'Bermudas', 'V', 'AME')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (64, 'BUTAN', 'BS', 'BUTAN', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (68, 'BOLIVIA', 'BOL', 'BOLIVIA', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (70, 'BOSNIA HERZEGOBINA', 'BIH', 'Bosnia', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (72, 'BOTSWANA', 'BW', 'Botswana', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (76, 'BRASIL', 'BRA', 'BRASILERO', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (84, 'BELICE', 'BLZ', 'BELICE', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (86, 'TERRITORIO BRITANICO DEL OCEANO INDICO', 'IO', 'TERRITORIO BRITANICO DEL OCEANO INDICO', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (90, 'ISLAS SALOMON', 'SB', 'ISLAS SALOMON', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (92, 'ISLAS VIRGENES BRITANICAS', 'VG', 'ISLAS VIRGENES BRITANICAS', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (96, 'BRUNEI DARUSSALAM', 'BN', 'BRUNEI DARUSSALAM', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (100, 'BULGARIA', 'BG', 'BULGARIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (104, 'MYANMAR', 'MY', 'MYANMAR', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (108, 'BURUNDI', 'BI', 'BURUNDI', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (112, 'BIELORRUSIA', 'BLR', 'Bielorrusia', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (116, 'CAMBOYA', 'KH', 'CAMBOYA', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (120, 'CAMERUN', 'CM', 'CAMERUN', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (124, 'CANADA', 'CAN', 'CANADA', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (132, 'CABO VERDE', 'CV', 'CABO VERDE', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (136, 'CAYMAN ISLANDS', 'KY', 'CAYMAN ISLANDS', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (140, 'REP. CENTRO AFRICANA', 'CF', 'REP. CENTRO AFRICANA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (144, 'SRI LANKA', 'LK', 'SRI LANKA', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (148, 'CHAD', 'TD', 'CHAD', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (152, 'CHILE', 'CHI', 'CHILE', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (156, 'CHINA', 'CHI', 'CHINO', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (158, 'TAIWAN', 'TW', 'TAIWAN', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (162, 'ISLA DE NAVIDAD', 'CK', 'ISLA DE NAVIDAD', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (166, 'ISLAS COCOS', 'CC', 'ISLAS COCOS', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (170, 'COLOMBIA', 'COL', 'COLOMBIANA', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (174, 'COMORAS', 'CM', 'COMORAS', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (175, 'MAYOTTE', 'YT', 'MAYOTTE', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (178, 'CONGO', 'CD', 'CONGO', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (180, 'REPUBLICA DEMOCRATICA DEL CONGO', 'CD', 'REPUBLICA DEMOCRATICA DEL CONGO', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (184, 'ISLAS COOK', 'CK', 'ISLAS COOK', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (188, 'COSTA RICA', 'CRI', 'COSTARICA', 'V', 'AMC')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (191, 'CROACIA', 'HR', 'CROACIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (192, 'CUBA', 'CUB', 'CUBA', 'V', 'AMC')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (196, 'CHIPRE', 'CY', 'CHIPRE', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (203, 'CHECOSLOVAQUIA', 'CS', 'CHECOSLOVAQUIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (204, 'BENIN', 'BEN', 'Benin', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (208, 'DINAMARCA', 'DK', 'DINAMARCA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (212, 'DOMINICA', 'DM', 'DOMINICA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (214, 'REPUBLICA DOMINICANA', 'RDO', 'REPUBLICADOMINICANA', 'V', 'AMC')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (218, 'ECUADOR', 'ECU', 'ECUATORIANO', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (222, 'EL SALVADOR', 'SAL', 'ELSALVADOR', 'V', 'AMC')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (226, 'GUINEA ECUATORIAL', 'GQ', 'GUINEA ECUATORIAL', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (231, 'ETIOPIA', 'ET', 'ETIOPIA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (232, 'ERITREA', 'ER', 'ERITREA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (233, 'ESTONIA', 'EE', 'ESTONIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (234, 'ISLAS FEROE', 'FO', 'ISLAS FEROE', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (238, 'ISLAS MALVINAS', 'FK', 'ISLAS MALVINAS', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (239, 'ISLAS GEORGIAS DEL SUR Y SANDWICH DEL SUR', 'GS', 'ISLAS GEORGIAS ', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (242, 'FIYI', 'FY', 'FIYI', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (246, 'FINLANDIA', 'FI', 'FINLANDIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (250, 'FRANCIA', 'FR', 'FRANCIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (254, 'GUAYANA FRANCESA', 'GF', 'GUAYANA FRANCESA', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (258, 'POLINESIA FRANCESA', 'PF', 'POLINESIA FRANCESA', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (260, 'TERRITORIOS AUSTRALES FRANCESES', 'TF', 'TERRITORIOS AUSTRALES FRANCESES', 'V', 'ANT')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (262, 'REPÚBLICA DE YIBUTI', 'YB', 'REPÚBLICA DE YIBUTI', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (266, 'GABON', 'GA', 'GABON', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (268, 'GEORGIA', 'GE', 'GEORGIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (270, 'GAMBIA', 'GM', 'GAMBIA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (276, 'ALEMANIA', 'ALE', 'Alemania', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (288, 'GHANA', 'GH', 'GHANA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (292, 'GIBRALTAR', 'GI', 'GIBRALTAR', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (296, 'KIRIBATI', 'KI', 'KIRIBATI', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (300, 'GRECIA', 'GR', 'GRECIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (304, 'GROENLANDIA', 'GL', 'GROENLANDIA', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (308, 'GRANADA', 'GD', 'GRANADA', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (312, 'GUADALUPE', 'GP', 'GUADALUPE', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (316, 'GUAM', 'GU', 'GUAM', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (320, 'GUATEMALA', 'GUA', 'GUATEMALA', 'V', 'AMC')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (324, 'GUINEA', 'GN', 'GUINEA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (328, 'GUYANA', 'GF', 'GUYANA', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (332, 'HAITI', 'HT', 'HAITI', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (336, 'ESTADO DE LA CIUDAD DEL VATICANO', 'VA', 'VATICANO', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (340, 'HONDURAS', 'HON', 'HONDURAS', 'V', 'AMC')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (348, 'HUNGRIA', 'HU', 'HUNGRIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (352, 'ISLANDIA', 'IS', 'ISLANDIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (356, 'INDIA', 'IN', 'INDIA', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (360, 'INDONESIA', 'ID', 'INDONESIA', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (364, 'IRAN', 'IR', 'IRAN', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (368, 'IRAK', 'IK', 'IRAK', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (372, 'IRLANDA', 'IE', 'IRLANDA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (376, 'ISRAEL', 'IL', 'ISRAEL', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (380, 'ITALIA', 'ITA', 'ITALIANA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (384, 'COSTA DE MARFIL', 'CI', 'COSTA DE MARFIL', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (388, 'JAMAICA', 'JM', 'JAMAICA', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (392, 'JAPON', 'JAP', 'JAPONESA', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (400, 'JORDANIA', 'JOR', 'JORDANA', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (404, 'KENIA', 'KE', 'KENIA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (408, 'KOREA DEL NORTE', 'KN', 'NORKOREANO', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (410, 'KOREA DEL SUR', 'KS', 'SURKOREANO', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (414, 'KUWAIT', 'KW', 'KUWAIT', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (417, 'KIRGUISTAN', 'KG', 'KIRGUISTAN', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (418, 'LAOS', 'LA', 'LAOS', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (422, 'LIBANO', 'LB', 'LIBANO', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (426, 'LESOTHO', 'LH', 'LESOTHO', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (428, 'LETONIA', 'LV', 'LETONIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (430, 'LIBERIA', 'LR', 'LIBERIA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (434, 'LIBIA', 'LY', 'LIBIA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (435, 'UCRANIA', 'UA', 'UCRANIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (438, 'LIECHTENSTEIN', 'LI', 'LIECHTENSTEIN', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (440, 'REPUBLICA DE LITUANIA', 'LT', 'REPUBLICA DE LITUANIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (442, 'LUXEMBURGO', 'LU', 'LUXEMBURGO', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (446, 'MACAO', 'MO', 'MACAO', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (447, 'KASAJISTAN', 'KJ', 'KASAJISTAN', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (450, 'MADAGASCAR', 'MG', 'MADAGASCAR', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (454, 'MALAWI', 'MW', 'MALAWI', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (458, 'MALASIA', 'MY', 'MALASIA', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (462, 'MALDIVAS', 'MV', 'MALDIVAS', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (466, 'MALI', 'ML', 'MALI', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (470, 'MALTA', 'MT', 'MALTA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (474, 'MARTINICA', 'MQ', 'MARTINICA', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (478, 'MAURITANIA', 'MR', 'MAURITANIA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (480, 'MAURICIO', 'MU', 'MAURICIO', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (484, 'MEXICO', 'MEX', 'MEXICO', 'V', 'AMC')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (492, 'MONACO', 'MC', 'MONACO', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (496, 'MONGOLIA', 'MN', 'MONGOLIA', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (498, 'MOLDAVIA', 'MD', 'MOLDAVIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (499, 'MONTENEGRO', 'MG', 'MONTENEGRO', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (500, 'MONTSERRAT', 'MS', 'MONTSERRAT', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (504, 'MARRUECOS', 'MA', 'MARRUECOS', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (508, 'MOZAMBIQUE', 'MZ', 'MOZAMBIQUE', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (512, 'OMAN', 'OM', 'OMAN', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (516, 'NAMIBIA', 'NA', 'NAMIBIA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (520, 'NAURU', 'NR', 'NAURU', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (524, 'NEPAL', 'NP', 'NEPAL', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (528, 'HOLANDA', 'HOL', 'HOLANDESA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (530, 'ANTILLAS NEERLANDESAS', 'AN', 'Antillas Neerlandesas', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (533, 'ARUBA', 'ARU', 'Aruba', 'V', 'AMC')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (540, 'NUEVA CALEDONIA', 'NC', 'NUEVA CALEDONIA', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (548, 'VANUATU', 'VU', 'VANUATU', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (554, 'NUEVA ZELANDA', 'NZ', 'NUEVA ZELANDA', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (558, 'NICARAGUA', 'NI', 'NICARAGUA', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (562, 'NIGER', 'NE', 'NIGER', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (566, 'NIGERIA', 'NG', 'NIGERIA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (570, 'ISLA NIUE', 'CN', 'ISLA NIUE', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (574, 'ISLA NORFOLK', 'NF', 'ISLA NORFOLK', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (578, 'NORUEGA', 'NO', 'NORUEGA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (580, 'ISLAS MARIANAS DEL NORTE', 'MP', 'ISLAS MARIANAS DEL NORTE', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (583, 'MICRONESIA', 'FM', 'MICRONESIA', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (584, 'ISLAS MARSHALL', 'MH', 'ISLAS MARSHALL', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (585, 'PALAOS', 'PL', 'PALAOS', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (586, 'PAKISTAN', 'PK', 'PAKISTAN', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (591, 'PANAMA', 'PAN', 'PANAMA', 'V', 'AMC')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (598, 'PAPUA NUEVA GUINEA', 'PG', 'PAPUA NUEVA GUINEA', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (600, 'PARAGUAY', 'PAR', 'PARAGUAY', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (604, 'PERU', 'PER', 'PERU', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (608, 'FILIPINAS', 'PH', 'FILIPINAS', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (612, 'ISLAS PITCAIRN', 'PN', 'ISLAS PITCAIRN', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (616, 'POLONIA', 'PL', 'POLONIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (620, 'PORTUGAL', 'PT', 'PORTUGAL', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (624, 'GUINEA BISSAU', 'GW', 'GUINEA BISSAU', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (626, 'TIMOR ORIENTAL', 'TP', 'TIMOR ORIENTAL', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (630, 'PUERTO RICO', 'PRI', 'PUERTORICO', 'V', 'AMC')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (631, 'TRINIDAD Y TOBAGO', 'TT', 'TRINIDAD Y TOBAGO', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (634, 'QATAR', 'QA', 'QATAR', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (638, 'REUNION', 'RE', 'REUNION', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (642, 'RUMANIA', 'RO', 'RUMANIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (643, 'FEDERACION RUSA', 'FR', 'RUSA', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (646, 'RUANDA', 'RW', 'RUANDA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (654, 'SANTA HELENA', 'SH', 'SANTA HELENA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (659, 'SAN CRISTOBAL Y NIEVES', 'SCN', 'SAN CRISTOBAL Y NIEVES', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (660, 'ANGUILA', 'AGU', 'Anguilla', 'V', 'AMC')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (662, 'SANTA LUCIA', 'LC', 'SANTA LUCIA', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (666, 'SAN PEDRO Y MIQUELON', 'PM', 'SAN PEDRO Y MIQUELON', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (670, 'SAN VICENTE Y LAS GRANADINAS', 'VC', 'SAN VICENTE Y LAS GRANADINAS', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (674, 'REPÚBLICA DE SAN MARINO', 'SM', 'REPÚBLICA DE SAN MARINO', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (678, 'SANTO TOME Y PRINCIPE', 'ST', 'SANTO TOME Y PRINCIPE', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (682, 'ARABIA', 'ARS', 'Arabia Saudita', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (686, 'SENEGAL', 'SN', 'SENEGAL', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (688, 'SERBIA', 'SB', 'SERBIA', 'V', 'AUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (690, 'SEYCHELLES', 'SC', 'SEYCHELLES', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (694, 'SIERRA LEONA', 'SL', 'SIERRA LEONA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (702, 'SINGAPUR', 'SG', 'SINGAPUR', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (703, 'ESLOVAQUIA', 'SK', 'ESLOVAQUIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (704, 'VIETNAM', 'VN', 'VIETNAM', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (705, 'ESLOVENIA', 'SI', 'ESLOVENIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (706, 'SOMALIA', 'SO', 'SOMALIA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (710, 'SUD AFRICA', 'SA', 'SUD AFRICA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (716, 'ZIMBABWE', 'ZW', 'ZIMBABWE', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (724, 'ESPAÑA', 'ES', 'ESPAÑA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (732, 'SAHARA OCCIDENTAL', 'EH', 'SAHARA OCCIDENTAL', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (736, 'SUDAN', 'SD', 'SUDAN', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (740, 'SURINAM', 'SR', 'SURINAM', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (744, 'ISLAS SVALBARD Y JAN MAYEN', 'SJ', 'ISLAS SVALBARD', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (748, 'SWAZILANDIA', 'SW', 'SWAZILANDIA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (752, 'SUECIA', 'SE', 'SUECIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (756, 'SUIZA', 'CH', 'SUIZA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (760, 'SIRIA', 'SY', 'SIRIA', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (762, 'TAYIKISTAN', 'TJ', 'TAYIKISTAN', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (764, 'TAILANDIA', 'TH', 'TAILANDIA', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (768, 'TOGO', 'TG', 'TOGO', 'V', 'ANT')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (772, 'TOKELAU', 'TK', 'TOKELAU', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (776, 'TONGA', 'TO', 'TONGA', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (784, 'EMIRATOS ARABES UNIDOS', 'AE', 'EMIRATOS ARABES UNIDOS', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (788, 'TUNEZ', 'TN', 'TUNEZ', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (792, 'TURQUIA', 'TR', 'TURQUIA', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (795, 'TURKMENISTAN', 'TM', 'TURKMENISTAN', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (796, 'ISLAS TURCAS Y CAICOS', 'TC', 'ISLAS TURCAS Y CAICOS', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (798, 'TUVALU', 'TV', 'TUVALU', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (800, 'UGANDA', 'UG', 'UGANDA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (807, 'MACEDONIA', 'MK', 'MACEDONIA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (818, 'EGIPTO', 'EG', 'EGIPTO', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (826, 'INGLATERRA', 'ING', 'INGLATERRA', 'V', 'EUR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (834, 'TANZANIA', 'TZ', 'TANZANIA', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (840, 'ESTADOS UNIDOS DE NORTEAMERICA', 'USA', 'ESTADO', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (850, 'ISLAS VIRGENES ESTADOUNIDENSES', 'VG', 'ISLAS VIRGENES ESTADOUNIDENSES', 'V', 'AMN')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (854, 'BURKINA FASO', 'BF', 'BURKINA FASO', 'V', 'AFR')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (858, 'URUGUAY', 'URU', 'URUGUAY', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (860, 'UZBEKISTAN', 'UZ', 'UZBEKISTAN', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (862, 'VENEZUELA', 'VEN', 'VENEZUELA', 'V', 'AMS')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (876, 'ISLAS WALLIS Y FUTUNA', 'WF', 'ISLAS WALLIS Y FUTUNA', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (882, 'SAMOA', 'WS', 'SAMOA', 'V', 'OCE')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (887, 'YEMEN', 'YE', 'YEMEN', 'V', 'ASI')
GO

INSERT INTO cl_pais (pa_pais, pa_descripcion, pa_abreviatura, pa_nacionalidad, pa_estado, pa_continente)
VALUES (894, 'ZAMBIA', 'ZM', 'ZAMBIA', 'V', 'AFR')
GO

