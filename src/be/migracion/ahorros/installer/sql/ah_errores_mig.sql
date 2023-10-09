/**********************************************************/
/*    ARCHIVO:         ah_error_mig.sql                   */
/*    NOMBRE LOGICO:   ah_error_mig.sql                   */
/*    PRODUCTO:        CUENTAS                            */
/**********************************************************/
/*                     IMPORTANTE                         */
/*   Esta aplicacion es parte de los  paquetes bancarios  */
/*   propiedad de MACOSA S.A.                             */
/*   Su uso no autorizado queda  expresamente  prohibido  */ 
/*   asi como cualquier alteracion o agregado hecho  por  */
/*   alguno de sus usuarios sin el debido consentimiento  */ 
/*   por escrito de MACOSA.                               */
/*   Este programa esta protegido por la ley de derechos  */
/*   de autor y por las convenciones  internacionales de  */
/*   propiedad intelectual.  Su uso  no  autorizado dara  */
/*   derecho a MACOSA para obtener ordenes  de secuestro  */
/*   o  retencion  y  para  perseguir  penalmente a  los  */
/*   autores de cualquier infraccion.                     */
/**********************************************************/
/*                     PROPOSITO                          */
/*   Script de insercion de codigos de errores generados  */
/*   en la migración                                      */
/**********************************************************/
/*                     MODIFICACIONES                     */
/*   FECHA        AUTOR           RAZON                   */
/*   31/08/2016   RSA             Emision Inicial         */
/**********************************************************/

use cob_externos
go


if exists (select * from ah_errores_mig where er_cod between 1 and 279 )
   delete ah_errores_mig where er_cod between 1 and 300  
go

insert into ah_errores_mig values(1,' LA CUENTA YA EXISTE EN TABLA DE CUENTAS DE AHORROS')
go
insert into ah_errores_mig values(2,'ESTADO DE LA CUENTA INVALIDO')
go
insert into ah_errores_mig values(3,'El control es invalido (1)')
go
insert into ah_errores_mig values(4,'La filial es invalida (1)')
go
insert into ah_errores_mig values(5,'LA OFICINA NO EXISTE EN LA TABLA CL_OFICINA')
go
insert into ah_errores_mig values(6,'PRODUCTO BANCARIO NO EXISTE')
go
insert into ah_errores_mig values(7,'ESTADO DE LA CUENTA INVALIDO (R)')
go
insert into ah_errores_mig values(8,'MONEDA DEBE SER 0')
go
insert into ah_errores_mig values(9,'LA FECHA DE APERTURA NO PUEDE SER MAYOR QUE LA FECHA DE PROCESO')
go
insert into ah_errores_mig values(10,'OFICIAL NO PUEDE SER 0')
go
insert into ah_errores_mig values(11,'OFICIAL NO EXISTE')
go
insert into ah_errores_mig values(12,'LA CEDULA O RUC DEBE ESTAR EN LA CL_ENTE')
go
insert into ah_errores_mig values(13,'EL NOMBRE NO DEBE ESTAR VACIO')
go
insert into ah_errores_mig values(14,'NO EXISTE CATEGORIA')
go
insert into ah_errores_mig values(15,'NO EXISTE TIPO PROMEDIO')
go
insert into ah_errores_mig values(16,'NO EXISTE CAPITALIZACION')
go
insert into ah_errores_mig values(17,'CICLO DE LA CUENTA NO EXISTE')
go
insert into ah_errores_mig values(18,'NUMERO DE SUSPENSOS NO COINCIDE CON LO REGISTRADO EN AH_VAL_SUSPENSO')
go
insert into ah_errores_mig values(19,'NUM BLOQUEOS MOVIMIENTOS NO COINCIDE CON LO REGISTRADO EN AH_CTABLOQUEADA')
go
insert into ah_errores_mig values(20,'NUM CONDICIONES DE FIRMAS NO COINCIDE CON LO REGISTRADO EN AH_CUENTA')
go
insert into ah_errores_mig values(21,'MONTO DE BLOQUEOS VALORES NO COINCIDE CON LO REGISTRADO EN AH_HIS_BLOQUEO')
go
insert into ah_errores_mig values(22,'NUM BLOQUEOS VALORES NO PUEDE SER MENOR QUE CERO')
go
insert into ah_errores_mig values(23,'CREDITOS REMESAS NO PUEDE SER MENOR QUE CERO')
go
insert into ah_errores_mig values(24,'ROL ENTE DEBE SER D')
go
insert into ah_errores_mig values(25,'ROL ENTE DEBE SER 1')
go
insert into ah_errores_mig values(26,'DISPONIBLE ES MENOR QUE 0')
go
insert into ah_errores_mig values(27,'NO PUEDEN VENIR SALDOS NEGATIVOS')
go
insert into ah_errores_mig values(28,'NO PUEDEN VENIR SALDOS NEGATIVOS DIFERIDOS')
go
insert into ah_errores_mig values(29,'VALOR DE RETENCION NO COINCIDE CON LO REGISTRADO EN ah_24h')
go
insert into ah_errores_mig values(30,'VALOR DE CHEQUES OTRAS PLAZAS DEPOSITADAS ah_48h')
go
insert into ah_errores_mig values(31,'REMESAS NO PUEDE SER MENOR QUE 0')
go
insert into ah_errores_mig values(32,'REMESAS HOY NO PUEDE SER MENOR QUE 0')
go
insert into ah_errores_mig values(33,'INTERES NO PUEDE VENIR SALDOS NEGATIVOS NO CAPITALIZADOS')
go
insert into ah_errores_mig values(34,'INTERES PROV NO PUEDEN VENIR SALDOS NEGATIVOS NO CAPITALIZADOS')
go
insert into ah_errores_mig values(35,'NO PUEDEN VENIR SALDOS NEGATIVOS EL ULTIMO SALDO QUE TIENE LA LIBRETA IMPRESA')
go
insert into ah_errores_mig values(36,'SALDO INTERES NO DEBE SER NEGATIVO')
go
insert into ah_errores_mig values(37,'SALDO DE ÚLTIMO CORTE. NO PUEDEN VENIR SALDOS NEGATIVOS')
go
insert into ah_errores_mig values(38,'SALDO FINAL DEL ULTIMO CORTE. NO PUEDEN VENIR SALDOS NEGATIVOS')
go
insert into ah_errores_mig values(39,'EL SALDO CON EL Q SE TERMINO EL DIA DE AYER INCLUYENDO LOS CHEQUES.NO PUEDE VENIR VALORES NEGATIVOS')
go
insert into ah_errores_mig values(40,'SUMATORIA DE TODOS LOS CREDITOS DEL MES.NO PUEDEN VENIR VALORES NEGATIVOS')
go
insert into ah_errores_mig values(41,'SUMATORIA DE TODOS LOS DEBITOS DEL MES.NO PUEDEN VENIR VALORES NEGATIVOS')
go
insert into ah_errores_mig values(42,'CREDITOS HOY NO PUEDE SER MENOR A 0')
go
insert into ah_errores_mig values(43,'DEBITOS HOY NO PUEDEN SER MENOR A 0')
go
insert into ah_errores_mig values(44,'Fecha anterior al primer dia del nuevo sistema. No puede ser mayor q la fecha del proceso')
go
insert into ah_errores_mig values(45,'Fecha ultimo mov int No puede ser mayor q la fecha del proceso')
go
insert into ah_errores_mig values(46,'Fecha ultimo mov No puede ser mayor q la fecha del proceso')
go
insert into ah_errores_mig values(47,'ah_fecha_prx_corte No puede ser mayor q la fecha del proceso')
go
insert into ah_errores_mig values(48,'ah_fecha_ult_corte No puede ser mayor q la fecha del proceso')
go
insert into ah_errores_mig values(49,'LA FECHA DE ULTIMA CAPITALIZACION NO PUEDE SER MAYOR QUE LA FECHA DE PROCESO')
go
insert into ah_errores_mig values(50,'ah_fecha_prx_capita NO PUEDE SER MENOR QUE LA FECHA DE PROCESO')
go
insert into ah_errores_mig values(51,'ah_linea NO PUEDE SER MENOR QUE 0')
go
insert into ah_errores_mig values(52,'ah_ult_linea NO PUEDE SER DIFERENTE QUE 0')
go
insert into ah_errores_mig values(53,'ah_cliente_ec NO PUEDE SER DIFERENTE QUE 0')
go
insert into ah_errores_mig values(54,'ah_direccion_ec NO PUEDE SER DIFERENTE QUE 0')
go
insert into ah_errores_mig values(55,'ah_descripcion_ec NO PUEDE SER DIFERENTE QUE VACIO')
go
insert into ah_errores_mig values(56,'ah_tipo_dir NO PUEDE SER DIFERENTE QUE R')
go
insert into ah_errores_mig values(57,'ah_agen_ec AGENCIA EC. NO CORRESPONDE')
go
insert into ah_errores_mig values(58,'ah_tipo_dir PARROQUIA NO CORRESPONDE')
go
insert into ah_errores_mig values(59,'ah_tipo_dir ZONA NO CORRESPONDE')
go
insert into ah_errores_mig values(60,'ah_prom_disponible PROMEDIO DISPONIBLE NO PUEDE SER < 0')
go
insert into ah_errores_mig values(61,'PROMEDIO DISPONIBLE 1 NO PUEDE SER < 0')
go
insert into ah_errores_mig values(62,'PROMEDIO DISPONIBLE 2 NO PUEDE SER < 0')
go
insert into ah_errores_mig values(63,'PROMEDIO DISPONIBLE 3 NO PUEDE SER < 0')
go
insert into ah_errores_mig values(64,'PROMEDIO DISPONIBLE 4 NO PUEDE SER < 0')
go
insert into ah_errores_mig values(65,'PROMEDIO DISPONIBLE 5 NO PUEDE SER < 0')
go
insert into ah_errores_mig values(66,'PROMEDIO DISPONIBLE 6 NO PUEDE SER < 0')
go
insert into ah_errores_mig values(67,'PERSONALIZACION TIENE QUE SER S O N')
go
insert into ah_errores_mig values(68,'CONTADOR TRX NO CORRESPONDE')
go
insert into ah_errores_mig values(69,'CUENTA FUNCIONARIO TIENE QUE SER S O N')
go
insert into ah_errores_mig values(70,'ORIGEN DE CAPTACION DE LA CUENTA NO EXISTE')
go
insert into ah_errores_mig values(71,'DEPOSITO INICIAL TIENE QUE ESTAR ENTRE 0 Y 1')
go
insert into ah_errores_mig values(72,'CONTADOR FIRMA NO PUEDE SER < 0')
go
insert into ah_errores_mig values(73,'NUMERO DE TELEFONO INCORRECTO')
go
insert into ah_errores_mig values(74,'INTERESES PROVISIONADOS NO PUEDEN SER < 0')
go
insert into ah_errores_mig values(75,'TASA A LA QUE FUE CALCULADO EL INTERES NO PUEDE SER < 0')
go
insert into ah_errores_mig values(76,'SALDO MINIMO DISPONIBLE DEL MES NO PUEDE SER < 0')
go
insert into ah_errores_mig values(77,'LA FECHA DE APERTURA ah_fecha_ult_ret NO PUEDE SER MAYOR QUE LA FECHA DE PROCESO')
go
insert into ah_errores_mig values(78,'LA CEDULA O RUC DEL COTITULAR DEBE ESTAR EN LA CL_ENTE')
go
insert into ah_errores_mig values(79,'NOMBRE DE COTITULAR NO PUEDE SER VACIO')
go
insert into ah_errores_mig values(80,'LA CEDULA O RUC DEL COTITULAR DEBE ESTAR EN LA CL_ENTE')
go
insert into ah_errores_mig values(81,'SECTOR DE LA DIRECCION DE ENVIO ESTADO CUENTA NO ES CORRECTO')
go
insert into ah_errores_mig values(82,'MONTO DE IMPUESTOS NO PUEDE SER DIFERENTE DE 0')
go
insert into ah_errores_mig values(83,'MONTO DE CONSUMOS POR PUNTOS DE VENTA NO PUEDE SER DIFERENTE DE 0')
go
insert into ah_errores_mig values(84,'TITULARIDAD DE LA CUENTA NO EXISTE')
go
insert into ah_errores_mig values(85,'CODIGO DEL PROMOTOR NO ES CORRECTO')
go
insert into ah_errores_mig values(86,'INTERES ACUMULADO DEL MES NO PUEDE SER < 0')
go
insert into ah_errores_mig values(87,'EL CAMPO AH_TIPOCTA_SUPER NO ESTA DE ACUERDO AL CATALOGO AH_CLA_CLIENTE')
go
insert into ah_errores_mig values(88,'CODIGO DEL DIREC ENVIO DEV CHEQUES NO ESTA EN CL_DIRECCION')
go
insert into ah_errores_mig values(89,'TIPO DIRECC ENVÍO DEVO CHEQUES NO ESTA CL_DIRECCION_EC')
go
insert into ah_errores_mig values(90,'LA PARROQUIA DIRECC ENVIO DEV CHEQUES NO ES CORRECTO')
go
insert into ah_errores_mig values(91,'LA ZONA DE LA DIRECCION DEL CLIENTE NO ES CORRECTO')
go
insert into ah_errores_mig values(92,'LA AGENCIA DE LA DIRECCION DEL CLIENTE NO ES CORRECTO')
go
insert into ah_errores_mig values(93,'EL MONTO TOTAL EMBARGADO TIENE QUE SER > 0')
go
insert into ah_errores_mig values(94,'VALOR ULTIMO PAGO DE INTERESES TIENE QUE SER > 0')
go
insert into ah_errores_mig values(95,'SALDO DE MANTENIMIENTO VALORES TIENE QUE SER > 0')
go
insert into ah_errores_mig values(96,'CREDITOS EN CUENTA DE HACE 1 MES TIENE QUE SER > 0')
go
insert into ah_errores_mig values(97,'CREDITOS EN CUENTA DE HACE 2 MESES TIENE QUE SER > 0')
go
insert into ah_errores_mig values(98,'CREDITOS EN CUENTA DE HACE 3 MESES TIENE QUE SER > 0')
go
insert into ah_errores_mig values(99,'CREDITOS EN CUENTA DE HACE 4 MESES TIENE QUE SER > 0')
go
insert into ah_errores_mig values(100,'CREDITOS EN CUENTA DE HACE 5 MESES TIENE QUE SER > 0')
go
insert into ah_errores_mig values(101,'DEBITOS EN CUENTA DE HACE 1 MES TIENE QUE SER > 0')
go
insert into ah_errores_mig values(102,'DEBITOS EN CUENTA DE HACE 2 MESES TIENE QUE SER > 0')
go
insert into ah_errores_mig values(103,'DEBITOS EN CUENTA DE HACE 3 MESES TIENE QUE SER > 0')
go
insert into ah_errores_mig values(104,'DEBITOS EN CUENTA DE HACE 4 MESES TIENE QUE SER > 0')
go
insert into ah_errores_mig values(105,'DEBITOS EN CUENTA DE HACE 5 MESES TIENE QUE SER > 0')
go
insert into ah_errores_mig values(106,'TASA QUE FUE CALCULADO INTERES DIA ANTERIOR DEBE SER > 0')
go
insert into ah_errores_mig values(107,'ESTADO DE CUENTA NO CORRESPONDE (S,N)')
go
insert into ah_errores_mig values(108,'PERMITE SALDO CERO NO CORRESPONDE (S,N)')
go
insert into ah_errores_mig values(109,'VALOR DE REMESAS DEL DIA ANTERIOR DEBE SER > 0')
go
insert into ah_errores_mig values(110,'NUMERO DE SOLICITUD DEBE SER > 0')
go
insert into ah_errores_mig values(111,'NO EXISTE EL EJECUTIVO DE VENTA DEBE SER > 0')
go
insert into ah_errores_mig values(112,'NO EXISTE EL DIA DE CORTE (1,12,15,18,21,24,27,3,6,9)')
go
insert into ah_errores_mig values(113,'SALDO INT BON GENERADO AHORRO PROGRAMADO DEBE SER > 0')
go
insert into ah_errores_mig values(114,'INT HOY BON GENERADO AHORRO PROGRAMADO DEBE SER > 0')
go
insert into ah_errores_mig values(115,'INTERES BONO DE AHO PROG CAPIT CUENT FIN MES DEBE SER > 0')
go
insert into ah_errores_mig values(116,'TASA INTERES BONO DIA DE HOY AHORR PROG DEBE SER > 0')
go
insert into ah_errores_mig values(117,'TASA INTERES BONO DIA DE HOY AHORR PROG DEBE SER > 0')
go
insert into ah_errores_mig values(118,'INT BONO DIA HOY CTAS ESPECIALES DEBE SER > 0')
go
insert into ah_errores_mig values(119,'SALDO INT BONIF GENERADO CTAS ESPECIALES DEBE SER > 0')
go
insert into ah_errores_mig values(120,'INTERES BONO CTAS ESPEC CAPITALIZA CTA PROC FIN MES DEBE SER > 0')
go
insert into ah_errores_mig values(121,'INTERES BONO DIA HOY CTAS ESPECIALES DEBE SER > 0')
go
insert into ah_errores_mig values(122,'INTERES BONO DIA HOY CTAS ESPECIALES DEBE SER > 0')
go
insert into ah_errores_mig values(123,'NUMERO DE VECES CIENTE SOLICITA EXTRACTO CTA MES DEBE SER > 0')
go
insert into ah_errores_mig values(124,'Error en creacion de registro en ah_cuenta')
go
insert into ah_errores_mig values(125,'Error en creacion de registro en cl_det_producto')
go
insert into ah_errores_mig values(126,'Error en creacion de registro en cl_cliente')
go
insert into ah_errores_mig values(127,'Número Interno de Cuenta no corresponde al campo ah_cuenta de la tabla maestro')
go
insert into ah_errores_mig values(128,'EL SECUENCIAL DE LA TABLA ESTA INCORRECTO')
go
insert into ah_errores_mig values(129,'EL CAMPO cb_tipo_bloqueo NO ESTA DE ACUERDO AL CATALOGO ah_tbloqueo')
go
insert into ah_errores_mig values(130,'Fecha anterior al primer dia del nuevo sistema no puede ser mayor q la fecha del proceso')
go
insert into ah_errores_mig values(131,'HORA BLOQUEO NO CORRESPONDE')
go
insert into ah_errores_mig values(132,'AUTORIZANTE DEL BLOQUEO NO DEBE SER VACIO')
go
insert into ah_errores_mig values(133,'SOLICITANTE DEL BLOQUEO NO DEBE SER VACIO')
go
insert into ah_errores_mig values(134,'LA OFICINA NO EXISTE EN LA TABLA CL_OFICINA')
go
insert into ah_errores_mig values(135,'PRODUCTO BANCARIO NO EXISTE')
go
insert into ah_errores_mig values(136,'CAUSA DE BLOQUEO NO CORRESPONDE')
go
insert into ah_errores_mig values(137,'CTA BLOQUEADA NO INSERTADA')
go
insert into ah_errores_mig values(138,'Número Interno de Cuenta no corresponde al campo hb_cuenta de la tabla maestro')
go
insert into ah_errores_mig values(139,'EL SECUENCIAL DE LA TABLA ESTA INCORRECTO')
go
insert into ah_errores_mig values(140,'EL VALOR DE LA TABLA ESTA INCORRECTO')
go
insert into ah_errores_mig values(141,'EL TOTAL VALOR BLOQUEADO NO DEBE SER 0')
go
insert into ah_errores_mig values(142,'FECHA INICIO ES MAYOR A FECHA FIN')
go
insert into ah_errores_mig values(143,'AUTORIZANTE NO PUEDE SER 0')
go
insert into ah_errores_mig values(144,'OFICIAL NO EXISTE o NO ESTA VIGENTE')
go
insert into ah_errores_mig values(145,'LA OFICINA NO EXISTE EN LA TABLA CL_OFICINA')
go
insert into ah_errores_mig values(146,'LA CAUSA DEL BLOQUEO NO PUEDE ESTAR VACIO')
go
insert into ah_errores_mig values(147,'EL SALDO DE LA CUENTA DESPUES DEL BLOQUEO NO PUEDE SER 0')
go
insert into ah_errores_mig values(148,'ACCION DEL BLOQUEO NO CORRESPONDE')
go
insert into ah_errores_mig values(149,'TIPO DEL BLOQUEO TIENE QUE SER D O I')
go
insert into ah_errores_mig values(150,'AH_HIS_BLOQUEO_MIG NO INSERTADA')
go
insert into ah_errores_mig values(151,'Número Interno de Cuenta no corresponde al campo cd_cuenta de la tabla maestro')
go
insert into ah_errores_mig values(152,'LA CIUDAD DE COMPENSACION NO EXISTE EN LA CL_CIUDAD')
go
insert into ah_errores_mig values(153,'La Fecha del Depósito no puede ser mayor q la fecha del proceso')
go
insert into ah_errores_mig values(154,'La Fecha Efectivización Depósito no puede ser menor que la fecha del deposito')
go
insert into ah_errores_mig values(155,'El Valor del Depósito tiene no es correcto')
go
insert into ah_errores_mig values(156,'El efectivizado tiene que ser S o N')
go
insert into ah_errores_mig values(157,'El valor a efectivizar no tiene que ser menor que 0')
go
insert into ah_errores_mig values(158,'AH_CIUDAD_DEPOSITO_MIG NO INSERTADA')
go
insert into ah_errores_mig values(159,'Número Interno de Cuenta no corresponde al campo ah_cta_banco de la tabla maestro')
go
insert into ah_errores_mig values(160,'El saldo de la Cuenta al momento de la inmovilización no es correcto')
go
insert into ah_errores_mig values(161,'Estado de la cuenta tiene que ser I o J')
go
insert into ah_errores_mig values(162,'La Fecha de Inmovilización no puede ser mayor q la fecha del proceso')
go
insert into ah_errores_mig values(163,'AH_HIS_INMOVILIZADA_MIG NO INSERTADA')
go
insert into ah_errores_mig values(164,'EL SECUENCIAL DE LA TABLA ESTA INCORRECTO')
go
insert into ah_errores_mig values(165,'Número Interno de Cuenta no corresponde al campo ah_cta_banco de la tabla maestro')
go
insert into ah_errores_mig values(166,'EL CAMPO he_tipo_embargo NO ESTA DE ACUERDO AL CATALOGO cc_tipo_embargo')
go
insert into ah_errores_mig values(167,'La Fecha de los movimientos No puede ser mayor q la fecha del proceso')
go
insert into ah_errores_mig values(168,'El Valor del monto pendiente no puede ser menor que 0')
go
insert into ah_errores_mig values(169,'El Valor del monto pendiente no puede ser menor que 0')
go
insert into ah_errores_mig values(170,'Tipo de embargo no esta en la tabla cc_clase_embargo')
go
insert into ah_errores_mig values(171,'La Fecha del oficio tiene que ser igual a la fecha del embargo')
go
insert into ah_errores_mig values(172,'Nivel de autoridad no puede ser vacio')
go
insert into ah_errores_mig values(173,'Numero de expediente tiene que ser 0')
go
insert into ah_errores_mig values(174,'LA PROVINCIA DONDE SE REALIZA EL EMBARGO NO EXISTE EN LA CL_PROVINCIA')
go
insert into ah_errores_mig values(175,'LA CIUDAD DONDE SE REALIZA EL EMBARGO NO EXISTE EN LA CL_CIUDAD')
go
insert into ah_errores_mig values(176,'Nombre del demandante no puede ser vacio')
go
insert into ah_errores_mig values(177,'EMBARGO NO INSERTADO')
go
insert into ah_errores_mig values(178,'La Fecha de Creacion del Producto tiene que ser menor a la fecha de migracion')
go
insert into ah_errores_mig values(179,'El secuencial es incorrecto')
go
insert into ah_errores_mig values(180,'El esta incorrecto (V-Vigente, A-Anulado, C-Cancelado)')
go
insert into ah_errores_mig values(181,'El Numero de cuenta ahorro programado esta incorrecto')
go
insert into ah_errores_mig values(182,'El Plazo de Ahorro esta incorrecto')
go
insert into ah_errores_mig values(183,'PERIODICIDAD DE LA DEDUCCION DE LAS CUOTAS NO CORRESPONDE')
go
insert into ah_errores_mig values(184,'FECHA DE VENCIMIENTO DEL NO CORRESPONDE')
go
insert into ah_errores_mig values(185,'EL VALOR DE DEDUCCIÓN ESTA INCORRECTO')
go
insert into ah_errores_mig values(186,'TIPO DE PRODUCTO DE CUENTA DE DEDUCCIÓN NO CORRESPONDE')
go
insert into ah_errores_mig values(187,'MOTIVO DEL AHORRO NO CORRESPONDE ah_motivoah_programado')
go
insert into ah_errores_mig values(188,'El Login del usuario que creo el plan esta incorrecto')
go
insert into ah_errores_mig values(189,'AHORRO PROGRAMADO NO INSERTADO')
go
insert into ah_errores_mig values(190,'EL CODIGO SECUENCIAL DEL DETALLE ESTA INCORRECTO')
go
insert into ah_errores_mig values(191,'EL NUMERO DE CUENTA DE AHORRO PROGRAMADO ESTA INCORRECTO')
go
insert into ah_errores_mig values(192,'CODIGO IDENTIFICADOR DE PLAN DE AHORRO ESTA INCORRECTO')
go
insert into ah_errores_mig values(193,'FECHA DE PROXIMA DEDUCCION DE LA CUOTA NO CORRESPONDE')
go
insert into ah_errores_mig values(194,'ESTADO DEL PLAN NO CORRESPONDE')
go
insert into ah_errores_mig values(195,'DET AHORRO PROGRAMADO NO INSERTADO')
go
insert into ah_errores_mig values(195,'DET AHORRO PROGRAMADO NO INSERTADO')
go
insert into ah_errores_mig values(196,'LP_CUENTA DE LA TABLA LINEA_PENDIENTE NO COINCIDE CON AH_CUENTA DE LA TABLA AH_CUENTA_MIG')
go
insert into ah_errores_mig values(197,'EL NUMERO DE LA LINEA ESTA INCORRECTO')
go
insert into ah_errores_mig values(198,'NEMONICO DE LA TRANSACCION NO CORRESPONDE')
go
insert into ah_errores_mig values(199,'VALOR DE LA TRANSACCION NO CORRESPONDE')
go
insert into ah_errores_mig values(200,'FECHA DEL MOVIMIENTO NO CORRESPONDE')
go
insert into ah_errores_mig values(201,'CONTROL DE LA TRANSACCION NO CORRESPONDE')
go
insert into ah_errores_mig values(202,'SIGNO DE LA TRANSACCION NO CORRESPONDE')
go
insert into ah_errores_mig values(203,'EL INDICADOR DE REGISTRO NO CORRESPONDE')
go
insert into ah_errores_mig values(204,'LINEA PENDIENTE NO INSERTADA')
go
insert into ah_errores_mig values(205,'EL NUMERO DE BLOQUEOS DEL ARCHIVO CTACLOQUEADA NO ES IGUAL AH_BLOQUEOS DE AH_CUENTA')
go
insert into ah_errores_mig values(206,'EL VALOR DE BLOQUEOS DEL ARCHIVO CTACLOQUEADA NO ES IGUAL AH_MONTO_BLOQ DE AH_CUENTA')
go
insert into ah_errores_mig values(207,'EL VALOR DE LOS CHEQUES DEL ARCHIVO CIUDAD_DEPOSITO NO ES IGUAL AH_24H DE AH_CUENTA')
go
insert into ah_errores_mig values(208,'LA FECHA DE BLOQUEO TIENE QUE SER MENOR QUE LA FECHA DE PROCESO')
go
insert into ah_errores_mig values(209,'LA FECHA DE VENCIMIENTO TIENE QUE SER MENOR QUE LA FECHA DE PROCESO')
go
insert into ah_errores_mig values(210,'EN LA TABLA DE CUENTAS NO PUEDEN EXISTIR DOS CODIGOS IGUALES')
go
insert into ah_errores_mig values(211,'EL PRODUCTO AHORROS NO ES CORRECTO')
go
insert into ah_errores_mig values(212,'NO SE INSERTO EL CLIENTE EN LA TABLA CL_CLIENTE')
go
insert into ah_errores_mig values(213,'LA CUENTA NO EXISTE EN LA AH_CUENTA')
go
insert into ah_errores_mig values(214,'EL PRODUCTO BANCARIO NO TIENE PRODUCTO FINAL')
go
insert into ah_errores_mig values(215,'LA CEDULA DEL CLIENTE NO ESTA EN LA CL_ENTE')
go
insert into ah_errores_mig values(216,'EL CODIGO DEL CLIENTE NO ESTA EN LA CL_ENTE')
go
insert into ah_errores_mig values(217,'EL ROL DEL CLIENTE TIENE QUE SER F O T')
go
insert into ah_errores_mig values(218,'LA FECHA DE CEACION DEL PRODUCTO TIENE QUE SER MENOR QUE LA FECHA DEL PROCESO')
go
insert into ah_errores_mig values(219,'LA FECHA DEL BLOQUEO NO PUEDE SER MAYOY QUE LA FECHA DE PROCESO')
go
insert into ah_errores_mig values(220,'LA FECHA DE VENCIMIENTO TIENE QUE SER MAYOR DE LA FECHA DE PROCESO')
go
insert into ah_errores_mig values(221,'EL CAMPO AH_ULT_LINEA TIENE QUE SER 0')
go
insert into ah_errores_mig values(222,'EL CAMPO ro_cuenta_BANCO NO ESTA EN LA TABLA AH_CUENTA')
go
insert into ah_errores_mig values(223,'EL TIPO DE PRODUCTO DEBE ESTAR EN CATEGORIA N o E')
go
insert into ah_errores_mig values(224,'EL CLIENTE DEBE SER EXTRANGERO')
go
insert into ah_errores_mig values(225,'EL TIPO PERSONA DEBE SER JURIDICA')
go

insert into ah_errores_mig values(226,'EL TIPO DE LA CLASE DE LA CUENTA DEBE ESTAR EN P o O')
go
insert into ah_errores_mig values(227,'Estado de la cuenta tiene que ser C V o  L')
go
insert into ah_errores_mig values(228,'Indicador de si la transacción es o no reversa (S,N)')
go
insert into ah_errores_mig values(229,'S/N si la transacción ingreso por modulo Reentry ')
go
insert into ah_errores_mig values(230,'Estado de la transacción tiene que ser (A,I,C,R)')
go

insert into ah_errores_mig values(231,'Error en creacion de registro en ah_datos_adic')
go
insert into ah_errores_mig values(232,'Error en creacion de registro en cl_infocta')
go
insert into ah_errores_mig values(233,'Error en actualizacion de registro en cl_ente')
go
insert into ah_errores_mig values(234,'EL TIPO PERSONA DEBE SER NATURAL')
go
--Validaciones
insert into ah_errores_mig values(235,'EL saldo de ah_his_inmovilizadas no puede ser menor que ah_disponible de la cuenta')
go
--Validaciones Detalle de Cheque
insert into ah_errores_mig values(236,'LA FILIAL NO CORRESPONDE')
go
insert into ah_errores_mig values(237,'LA OFICINA NO CORRESPONDE')
go
insert into ah_errores_mig values(238,'El PRODUCTO NO CORRESPONDE')
go
insert into ah_errores_mig values(239,'MONEDA NO CORRESPONDE')
go
insert into ah_errores_mig values(240,'TIPO DE CHEQUE NO CORRESPONDE')
go
insert into ah_errores_mig values(241,'CUENTA DEL CHEQUE NO PUEDE SER VACIA')
go
insert into ah_errores_mig values(242,'EL NUMERO DEL CHEQUE NO PUEDE ESTAR VACIA')
go
insert into ah_errores_mig values(243,'CODIGO BANCO NO CORRESPONDE')
go
insert into ah_errores_mig values(244,'MONEDA DESTINO NO CORRESPONDE')
go
insert into ah_errores_mig values(245,'USUARIO NO CORRESPONDE')
go
insert into ah_errores_mig values(246,'CUENTA NO EXISTE')
go
insert into ah_errores_mig values(247,'MONEDA ORIGEN NO ES IGUAL A MONEDA DESTINO')
go
insert into ah_errores_mig values(250,'ERROR AL INSERTAR EL DETALLE DE CHEQUE')
go

insert into ah_errores_mig values(251,'ah_disponible menor a (ah_monto_bloq+ah_monto_emb) ')
go
insert into ah_errores_mig values(252,'ah_disponible menor a (ah_monto_bloq+ah_monto_emb) ')
go

insert into ah_errores_mig values(253,'hb_fecha_ven no debe ser null para ctas de ahorro programado')
go

insert into ah_errores_mig values(254,'hb_plazo no puede ser null o cero para hb_tipo_blq = D ') 
go

insert into ah_errores_mig values(255,'hb_causa debe ser 7 para ctas de ahorro programado.') 
go

insert into ah_errores_mig values(256,'La forma de Pago de la Transacción debe ser E.') 
go

insert into ah_errores_mig values(257,'ah_disponible no puede ser < 0') 
go

insert into ah_errores_mig values(258,'ah_prom_disponible no puede ser < 0') 
go

insert into ah_errores_mig values(259,'ah_prom_disponible no puede ser mayor que ah_disponible') 
go

insert into ah_errores_mig values(260,'El Saldo Contable de la transacción debe ser mayor a 0') 
go

insert into ah_errores_mig values(261,'LA CUENTA PERSONALIZADA DEBE SER 0') 
go

insert into ah_errores_mig values(262,'TIPO CREDITO DE LA CUENTA (N)') 
go

insert into ah_errores_mig values(263,'EL NUMERO DE LIBRETA NO PUEDE SER NEGATIVO') 
go

insert into ah_errores_mig values(264,'HORA DEL SUSPENSO NO CORRESPONDE') 
go

insert into ah_errores_mig values(265,'La clave de activación no sea < 0') 
go

insert into ah_errores_mig values(266,'Procesada del Suspenso (S,N)') 
go

insert into ah_errores_mig values(267,'Impuestos del Suspenso (S,N)') 
go

insert into ah_errores_mig values(268,'LA CAUSA DE LA REACCIÓN NO CORRESPONDE') 
go

insert into ah_errores_mig values(269,'La acción que se realiza para las Notas de Débitos') 
go

insert into ah_errores_mig values(270,'El cobro de comisión (S,N)') 
go

insert into ah_errores_mig values(271,'IMPUESTOS SI SE COBRAN O NO') 
go

insert into ah_errores_mig values(272,'Los Saldos Minimos si se cobran o no ') 
go

insert into ah_errores_mig values(273,'MODO INCORRECTO (S,N)') 
go

insert into ah_errores_mig values(274,'PRODUCTO FINAL NO EXISTE') 
go

insert into ah_errores_mig values(275,'LA CUOTA DE AHORRO DEBE SER MAYOR A 0') 
go

insert into ah_errores_mig values(276,'Periodicidad del ahorro contractual debe ser M') 
go

insert into ah_errores_mig values(277,'El resultado del valor de la cuota multiplicado por el plazo') 
go

insert into ah_errores_mig values(278,'El Estado del ahorro contractual') 
go

insert into ah_errores_mig values(279,'El Periodos de incumplimiento del ahorro') 
go

insert into ah_errores_mig values(280,'ERROR AL INSERTAR EL ACCION ND')
go

insert into ah_errores_mig values(281,'ERROR AL INSERTAR CUENTA CONTRACTUAL')
go

insert into ah_errores_mig values(282,'ERROR AL INSERTAR TRANSACCIONES MONETARIAS')
go

insert into ah_errores_mig values(283,'Error al momento de transferir datos a la tabla')
go

insert into ah_errores_mig values(284,'ERROR AL INSERTAR VALORES DE SUSPENSOS')
go

insert into ah_errores_mig values(285,'ERROR AL INSERTAR TRANSACCIONES MONETARIAS HISTORICAS')
go

insert into ah_errores_mig values(286,'NO EXISTEN CUENTAS VALIDAS PARA PROCESAR')
go

insert into ah_errores_mig values(287,'LAS TRANSACCIONES DE CREDITOS HOY SON DIFERENTES A LAS MONETARIAS')
go

insert into ah_errores_mig values(288,'LAS TRANSACCIONES DE DEBITOS HOY SON DIFERENTES A LAS MONETARIAS')
go

insert into ah_errores_mig values(289,'EL NUMERO DE CUENTA YA FUE MIGRADA')
go

insert into ah_errores_mig values(290,'NO SE PUEDE INGRESAR REGISTROS REPETIDAS EN LA TABLA')
go

insert into ah_errores_mig values(291,'NO EXISTE LA CUENTA RELACIONADA EN LA TABLA AH_CUENTA_MIG')
go

insert into ah_errores_mig values(292,'NO EXISTE EL TIPO DE CUENTA RELACIONADA EN EL MERCADO')
go

insert into ah_errores_mig values(293,'LA CATEGORIA NO ESTA ASOCIADA A UN PRODUCTO BANCARIO')
go