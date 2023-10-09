/************************************************************************/
/*  Archivo:            REM AHO-H77223_2.sql                            */
/*  Base de datos:      cob_remesas                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Eduardo Williams                                */
/*  Fecha de escritura: 01-Ago-2016                                     */
/************************************************************************/
/*                       IMPORTANTE                                     */
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
/*                        PROPOSITO                                     */
/* Parametrizacion de la tabla re_accion_nd                             */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/************************************************************************/
/*  FECHA             AUTOR               RAZON                         */
/*  01/Ago/2016       Eduardo Williams    Emision inicial               */
/************************************************************************/
use cob_remesas
go

/****************************/
/*      re_accion_nd        */
/****************************/
delete from re_accion_nd where an_producto = 4
go
insert into re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
values 
(4, 10,  'E', 'S', 'N', 'N', null), 
(4, 11,  'E', 'S', 'N', 'N', null), 
(4, 139, 'E', 'N', 'N', 'N', 'S') , 
(4, 14,  'E', 'N', 'S', 'N', null), 
(4, 140, 'E', 'N', 'N', 'N', 'S') , 
(4, 141, 'E', 'N', 'N', 'N', null), 
(4, 142, 'E', 'N', 'N', 'N', null), 
(4, 143, 'E', 'N', 'N', 'N', 'S') , 
(4, 152, 'E', 'N', 'N', 'N', 'N') , 
(4, 156, 'V', 'N', 'N', 'N', 'N') , 
(4, 157, 'E', 'N', 'N', 'N', 'N') , 
(4, 158, 'E', 'N', 'N', 'N', 'N') , 
(4, 159, 'E', 'N', 'N', 'N', 'N') , 
(4, 160, 'E', 'N', 'N', 'N', 'N') , 
(4, 161, 'V', 'N', 'N', 'N', 'N') , 
(4, 162, 'E', 'N', 'N', 'N', 'N') , 
(4, 163, 'E', 'N', 'N', 'N', null), 
(4, 164, 'E', 'N', 'N', 'N', 'S') , 
(4, 165, 'V', 'N', 'N', 'N', 'N') , 
(4, 166, 'V', 'N', 'N', 'N', 'N') , 
(4, 167, 'V', 'N', 'N', 'N', 'N') , 
(4, 168, 'V', 'N', 'N', 'N', 'N') , 
(4, 182, 'E', 'N', 'S', 'N', null), 
(4, 183, 'E', 'S', 'N', 'N', null), 
(4, 184, 'E', 'N', 'N', 'N', null), 
(4, 185, 'E', 'S', 'N', 'N', null), 
(4, 205, 'E', 'N', 'N', 'N', null), 
(4, 213, 'E', 'N', 'N', 'N', null), 
(4, 233, 'V', 'N', 'N', 'N', 'N') , 
(4, 234, 'V', 'N', 'N', 'N', 'N') , 
(4, 236, 'E', 'N', 'N', 'N', null), 
(4, 237, 'E', 'N', 'N', 'N', null), 
(4, 238, 'V', 'N', 'N', 'N', 'N') , 
(4, 24,  'E', 'N', 'N', 'N', null), 
(4, 248, 'E', 'N', 'N', 'N', null), 
(4, 26,  'E', 'N', 'N', 'N', 'N') , 
(4, 260, 'V', 'N', 'S', 'N', 'N') , 
(4, 261, 'E', 'N', 'S', 'N', 'S') , 
(4, 27,  'E', 'S', 'N', 'N', null), 
(4, 28,  'E', 'S', 'N', 'N', null), 
(4, 30,  'E', 'S', 'N', 'N', null), 
(4, 31,  'E', 'S', 'N', 'N', null), 
(4, 32,  'E', 'N', 'S', 'N', null), 
(4, 33,  'E', 'N', 'S', 'N', null), 
(4, 34,  'E', 'N', 'S', 'N', null), 
(4, 35,  'E', 'S', 'N', 'N', null), 
(4, 36,  'V', 'S', 'N', 'N', null), 
(4, 37,  'E', 'N', 'N', 'N', null), 
(4, 38,  'E', 'N', 'N', 'N', null), 
(4, 39,  'V', 'N', 'N', 'N', 'S') , 
(4, 4,   'E', 'N', 'S', 'N', null), 
(4, 40,  'E', 'N', 'N', 'N', 'N') , 
(4, 41,  'E', 'N', 'N', 'N', 'N') , 
(4, 44,  'E', 'N', 'N', 'N', 'N') , 
(4, 46,  'V', 'N', 'N', 'N', 'S') , 
(4, 50,  'E', 'N', 'N', 'N', 'S') , 
(4, 57,  'E', 'S', 'N', 'N', null), 
(4, 58,  'E', 'S', 'N', 'N', null), 
(4, 75,  'E', 'N', 'N', 'N', 'S') , 
(4, 84,  'E', 'S', 'N', 'N', null), 
(4, 85,  'E', 'N', 'N', 'N', 'S') , 
(4, 86,  'E', 'N', 'N', 'N', 'S') , 
(4, 87,  'E', 'N', 'N', 'N', 'S') , 
(4, 88,  'E', 'N', 'N', 'N', 'S') , 
(4, 9,   'E', 'N', 'N', 'N', 'N') , 
(4, 91,  'E', 'N', 'S', 'N', null), 
(4, 92,  'V', 'S', 'N', 'N', 'N') , 
(4, 93,  'E', 'N', 'S', 'N', null)
go
print 're_accion_nd...OK'
go

/****************************/
/*      re_accion_nd        */
/****************************/
delete from re_concepto_imp where ci_producto = 4
go
insert into re_concepto_imp (ci_tran, ci_causal, ci_impuesto, ci_concepto, ci_producto, ci_base1, ci_base2, ci_contabiliza, ci_fecha)
values
(315, '108', 'R', '0210', 4, 'tm_valor'   , null, 'tm_valor'         , convert(varchar, getdate(), 101)), 
(264, '182', 'R', '0210', 4, 'tm_valor'   , null, 'tm_valor'         , convert(varchar, getdate(), 101)), 
(316, '182', 'R', '0210', 4, 'tm_valor'   , null, 'tm_valor'         , convert(varchar, getdate(), 101)), 
(308, '0'  , 'R', '0210', 4, 'tm_interes' , null, 'tm_valor'         , convert(varchar, getdate(), 101)), 
(309, '0'  , 'R', '0210', 4, 'tm_interes' , null, 'tm_valor'         , convert(varchar, getdate(), 101)), 
(334, '0'  , 'C', '4010', 4, 'tm_interes' , null, 'tm_valor'         , convert(varchar, getdate(), 101)), 
(379, '0'  , 'R', '1005', 4, 'ts_interes' , null, 'ts_valor'         , convert(varchar, getdate(), 101)), 
(213, '0'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(224, '59' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(237, '0'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(240, '0'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(261, '0'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(263, '0'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '0'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '1'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '10' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '11' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '12' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '13' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '14' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '16' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '17' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '182', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '183', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '184', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '185', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '20' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '205', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '213', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '23' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '236', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '237', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '238', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '24' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '244', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '246', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '25' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '26' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '27' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '28' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '30' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '31' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '32' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '33' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '34' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '4'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '7'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '8'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '84' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '9'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '90' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '91' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '92' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '93' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(300, '0'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(308, '0'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(309, '0'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '0'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '1'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '10' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '11' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '12' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '13' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '14' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '16' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '17' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '182', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '185', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '20' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '205', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '213', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '23' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '236', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '237', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '238', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '24' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '244', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '246', 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '25' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '26' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '27' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '28' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '30' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '32' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '33' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '34' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '4'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '7'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '8'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '84' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '9'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '90' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '91' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(316, '92' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(334, '0'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(371, '0'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(379, '0'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(392, '0'  , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101)), 
(264, '1'  , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '10' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '11' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '12' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '13' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '14' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '16' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '17' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '182', 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '183', 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '184', 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '185', 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '20' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '205', 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '213', 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '23' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '236', 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '237', 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '238', 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '24' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '244', 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '246', 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '25' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '26' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '27' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '28' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '30' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '31' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '32' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '33' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '34' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '4'  , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '7'  , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '8'  , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '84' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '9'  , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '90' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '91' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '92' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '93' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(264, '35' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(373, '19' , 'T', '5820', 4, 'ts_interes' , null, 'ts_valor'         , convert(varchar, getdate(), 101)), 
(373, '205', 'T', '5505', 4, 'ts_interes' , null, 'ts_valor'         , convert(varchar, getdate(), 101)), 
(373, '50' , 'T', '0705', 4, 'ts_interes' , null, 'ts_valor'         , convert(varchar, getdate(), 101)), 
(253, '20' , 'R', '0210', 4, 'tm_base_gmf', null, 'tm_valor'         , convert(varchar, getdate(), 101)), 
(264, '36' , 'V', '0200', 4, 'tm_valor'   , null, 'tm_valor_comision', convert(varchar, getdate(), 101)), 
(253, '107', 'T', '5790', 4, 'tm_valor'   , null, 'tm_valor'         , convert(varchar, getdate(), 101)), 
(373, '23' , 'T', '4505', 4, 'ts_interes' , null, 'ts_valor'         , convert(varchar, getdate(), 101)), 
(264, '36' , 'R', '1005', 4, 'tm_base_gmf', null, 'tm_monto_imp'     , convert(varchar, getdate(), 101))
go
print 're_concepto_imp...OK'
go
