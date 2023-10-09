/************************************************************************/
/*      Archivo:            param_pf_equivalencias,sql.sql              */
/*      Base de datos:      cob_pfijo                                   */
/*      Producto:           Plazo Fijo                                  */
/*      Disenado por:       Karen Meza                                  */
/*      Fecha de escritura: 22/Sept/2016                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa realiza la creación de la parametrización contable    */
/*  en la tabla pf_equivalencias para el módulo de plazo fijo.          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR        RAZON                              */
/*  22/Sept/2016      Karen Meza     Emision Inicial                    */
/************************************************************************/
use cob_pfijo
go
truncate table pf_equivalencias
go

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'CATPRODUCT', NULL, '30', '999999999', 'CDT', 'CERTIFICADO DE DEPOSITO A TERMINO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'CATPRODUCT', NULL, '1', '29', 'CDAT', 'CERTIFICADO DE DEPOSITO A TERMINO FIJO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPCONCEPT', 'CAP', NULL, NULL, 'CAP', 'CAPITAL')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPCONCEPT', 'INT', NULL, NULL, 'INT', 'INTERES')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPCONCEPT', 'RET', NULL, NULL, 'RET', 'RETENCION')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPCONCEPT', 'GMF', NULL, NULL, 'GMF', 'GRAVAMEN MOVIMIENTO FINANCIERO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPCONCEPT', 'CHC', NULL, NULL, 'CHCOMER', 'CHEQUE LOCAL')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPCONCEPT', 'CHQL', NULL, NULL, 'CHLOCAL', 'CHEQUE LOCAL')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPCONCEPT', 'CHG', NULL, NULL, 'CHGEREN', 'CHEQUE LOCAL')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPCONCEPT', 'PCHC', NULL, NULL, 'CTAPTE', 'CHEQUE LOCAL')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPCONCEPT', 'CTRL', NULL, NULL, 'CTAPTE', 'EFECTIVO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPCONCEPT', 'EFEC', NULL, NULL, 'EFMN', 'EFECTIVO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPCONCEPT', 'OTROS', NULL, NULL, 'CTAPTE', 'EFECTIVO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPCONCEPT', 'VXP', NULL, NULL, 'CTAPTE', 'EFECTIVO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPCONCEPT', 'SEBRA', NULL, NULL, 'SEBRA', 'EFECTIVO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPESTPRY', 'ING', NULL, NULL, '0', 'NO VIGENTE')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPESTPRY', 'ACT', NULL, NULL, '1', 'VIGENTE')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPESTPRY', 'VEN', NULL, NULL, '2', 'VENCIDO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPESTPRY', 'CAN', NULL, NULL, '4', 'CANCELADO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (36, 'TIPESTPRY', 'XACT', NULL, NULL, '0', 'NO VIGENTE')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVTASA', 'DTFTA', NULL, NULL, '1', 'DEPOSITO A TERMINO FIJO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVTDOC', 'CC', NULL, NULL, 'CC', 'CEDULA CIUDADANIA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVTDOC', 'CE', NULL, NULL, 'CE', 'CEDULA DE EXTRANJERIA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVTDOC', 'N', NULL, NULL, 'NIT', 'NIT PERSONAS JURIDICAS')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVTDOC', 'NI', NULL, NULL, 'NIT', 'NIT PERSONA NATURAL')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVTDOC', 'NU', NULL, NULL, 'NIP', 'NUMERO UNICO DE IDENTIFICACION PERSONAL')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVTDOC', 'PA', NULL, NULL, 'PAP', 'PASAPORTE')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVTDOC', 'TI', NULL, NULL, 'TI', 'TARJETA DE IDENTIDAD')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5001', NULL, NULL, '1', 'MEDELLIN')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5002', NULL, NULL, '2', 'ABEJORRAL')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5004', NULL, NULL, '4', 'ABRIAQUI')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5021', NULL, NULL, '21', 'ALEJANDRIA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5030', NULL, NULL, '30', 'AMAGA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5031', NULL, NULL, '31', 'AMALFI')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5034', NULL, NULL, '34', 'ANDES')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5036', NULL, NULL, '36', 'ANGELOPOLIS')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5038', NULL, NULL, '38', 'ANGOSTURA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5040', NULL, NULL, '40', 'ANORI')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5042', NULL, NULL, '42', 'SANTAFE DE ANTIOQUIA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5044', NULL, NULL, '44', 'ANZA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5045', NULL, NULL, '45', 'APARTADO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5051', NULL, NULL, '51', 'ARBOLETES')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5055', NULL, NULL, '55', 'ARGELIA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5059', NULL, NULL, '59', 'ARMENIA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5079', NULL, NULL, '79', 'BARBOSA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5086', NULL, NULL, '86', 'BELMIRA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5088', NULL, NULL, '88', 'BELLO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5091', NULL, NULL, '91', 'BETANIA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5093', NULL, NULL, '93', 'BETULIA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5101', NULL, NULL, '101', 'BOLIVAR')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5107', NULL, NULL, '107', 'BRICE¥O')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5113', NULL, NULL, '113', 'BURITICA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5120', NULL, NULL, '120', 'CACERES')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5125', NULL, NULL, '125', 'CAICEDO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5129', NULL, NULL, '129', 'CALDAS')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5134', NULL, NULL, '134', 'CAMPAMENTO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5138', NULL, NULL, '138', 'CA¥ASGORDAS')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5142', NULL, NULL, '142', 'CARACOLI')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5145', NULL, NULL, '145', 'CARAMANTA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5147', NULL, NULL, '147', 'CAREPA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5148', NULL, NULL, '148', 'CARMEN DE VIBORAL')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5150', NULL, NULL, '150', 'CAROLINA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5154', NULL, NULL, '154', 'CAUCASIA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5172', NULL, NULL, '172', 'CHIGORODO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5190', NULL, NULL, '190', 'CISNEROS')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5197', NULL, NULL, '197', 'COCORNA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5206', NULL, NULL, '206', 'CONCEPCION')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5209', NULL, NULL, '209', 'CONCORDIA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5212', NULL, NULL, '212', 'COPACABANA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5234', NULL, NULL, '234', 'DABEIBA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5237', NULL, NULL, '237', 'DON MATIAS')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5240', NULL, NULL, '240', 'EBEJICO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5250', NULL, NULL, '250', 'EL BAGRE')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5264', NULL, NULL, '264', 'ENTRERRIOS')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5266', NULL, NULL, '266', 'ENVIGADO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5282', NULL, NULL, '282', 'FREDONIA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5284', NULL, NULL, '284', 'FRONTINO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5306', NULL, NULL, '306', 'GIRALDO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5308', NULL, NULL, '308', 'GIRARDOTA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5310', NULL, NULL, '310', 'GOMEZ PLATA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5313', NULL, NULL, '313', 'GRANADA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5315', NULL, NULL, '315', 'GUADALUPE')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5318', NULL, NULL, '318', 'GUARNE')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5321', NULL, NULL, '321', 'GUATAPE')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5347', NULL, NULL, '347', 'HELICONIA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5353', NULL, NULL, '353', 'HISPANIA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5360', NULL, NULL, '360', 'ITAGUI')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5361', NULL, NULL, '361', 'ITUANGO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5364', NULL, NULL, '364', 'JARDIN')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5368', NULL, NULL, '368', 'JERICO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5376', NULL, NULL, '376', 'LA CEJA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5380', NULL, NULL, '380', 'LA ESTRELLA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5390', NULL, NULL, '390', 'LA PINTADA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5400', NULL, NULL, '400', 'LA UNION')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5411', NULL, NULL, '411', 'LIBORINA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5425', NULL, NULL, '425', 'MACEO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5440', NULL, NULL, '440', 'MARINILLA')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5467', NULL, NULL, '467', 'MONTEBELLO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5475', NULL, NULL, '475', 'MURINDO')

INSERT INTO pf_equivalencias (eq_modulo, eq_tabla, eq_val_pfijo, eq_val_pfi_ini, eq_val_pfi_fin, eq_val_interfaz, eq_descripcion)
VALUES (99, 'DCVCIUD', '5480', NULL, NULL, '480', 'MUTATA')

go

