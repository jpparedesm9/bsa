/************************************************************************/
/*  Archivo:            ah_menu.sql                                    */
/*  Base de datos:      cobis                                           */
/*  Producto:           Cuentas Ahorros                                 */
/*  Disenado por:       Javier Calderon                                 */
/*  Fecha de escritura: 02/May/2016                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Script de instalación de transacciones autorizadas pantallas menu   */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA           AUTOR             RAZON                             */
/*  02/May/2016     J. Calderon     Migración a CEN                     */
/************************************************************************/
use cobis
go

delete FROM cobis..ad_pro_transaccion WHERE pt_transaccion IN (80,90,99,201,202,203,204,205,211,212,214,216,217,218,220,223,230,232,
                                                         234,235,245,247,281,282,283,302,303,320,331,332, 343,352,354,357,367,
                                                         381,390,393,394,395,400,403,408,410,429,494,584,602,603,604,606,607,
                                                         672,697,702,707,708,710,714,717,720,722,738,743,2564,2581,2582,2583,
                                                         2584,2585,2586,2587,2588,2589,2590,2591,2592,2593,2594,2595,2596,2669,
                                                         2696,2700,2810,2879,2913,2938,4101,4102,4103,4104,4105,4106,4107,4108,
                                                         4133,4134,4144,4149,4150,4151,4152,4153,4154,4155,4163,
                                                         253,264,322,380,387,388,389,396,397,398,399,4130,4131,4132,4134,4135,
                                                         4142,4146,4148,4164,4165,4166,4167,452,475,696,698,741,29265,
                                                         2576,424,34,6907,2812,407,601,447,721,703,704,6906,719,16,3082,711,92,
                                                         3016,734,493,747,3016,700,2916,739,2811,689,699,701,2850,50,48)

go

/* *********************************/
print '---->>ad_pro_transaccion'
/* *********************************/


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 700, 'V', getdate(), 635, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2916, 'V', getdate(), 2687, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 739, 'V', getdate(), 717, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2811, 'V', getdate(), 2628, NULL)
GO


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (5, 'R', 0, 3016, 'V', getdate(), 3005, NULL)
GO
                                     

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 747, 'V', getdate(), 720, NULL)
GO
                                     
INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 493, 'V', getdate(), 458, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 734, 'V', getdate(), 716, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 92, 'V', getdate(), 49, NULL)
GO


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 711, 'V', getdate(), 636, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 714, 'V',  getdate(), 636, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 717, 'V',  getdate(), 637, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (2, 'R', 0, 2938, 'V', getdate(), 1998, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2812, 'V', getdate(), 75, NULL)
GO


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 16, 'V', getdate(), 75, NULL)
GO


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 719, 'V', getdate(), 708, NULL)
GO


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 452, 'V', getdate(), 440, NULL)
GO


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (6, 'R', 0, 6906, 'V', getdate(), 6436, NULL)
GO


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 703, 'V', getdate(), 703, NULL)
GO


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 704, 'V', getdate(), 704, NULL)
GO


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 34, 'V', getdate(), 40, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 223, 'V', getdate(), 238, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 407, 'V', getdate(), 406, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 424, 'V', getdate(), 420, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 447, 'V', getdate(), 436, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 601, 'V', getdate(), 633, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 721, 'V', getdate(), 709, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2576, 'V', getdate(), 2524, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (6, 'R', 0, 6907, 'V', getdate(), 6436, NULL)
GO


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (1, 'R', 0, 584, 'V', getdate(), 5006, NULL)
GO


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 80, 'V', getdate(), 99, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 90, 'V', getdate(), 94, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 99, 'V', getdate(), 2548, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2564, 'V', getdate(), 2514, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2581, 'V', getdate(), 2529, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2582, 'V', getdate(), 2529, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2583, 'V', getdate(), 2529, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2584, 'V', getdate(), 2529, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2585, 'V', getdate(), 2530, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2586, 'V', getdate(), 2530, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2587, 'V', getdate(), 2530, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2588, 'V', getdate(), 2530, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2589, 'V', getdate(), 2531, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2590, 'V', getdate(), 2531, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2591, 'V', getdate(), 2531, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2592, 'V', getdate(), 2531, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2593, 'V', getdate(), 2532, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2594, 'V', getdate(), 2532, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2595, 'V', getdate(), 2532, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2596, 'V', getdate(), 2532, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2669, 'V', getdate(), 2669, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2696, 'V', getdate(), 2576, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2700, 'V', getdate(), 2579, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2810, 'V', getdate(), 2627, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2879, 'V', getdate(), 2666, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', 0, 2913, 'V', getdate(), 2687, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 201, 'V', getdate(), 214, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 202, 'V', getdate(), 215, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 203, 'V', getdate(), 222, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 204, 'V', getdate(), 223, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 205, 'V', getdate(), 216, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 211, 'V', getdate(), 217, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 212, 'V', getdate(), 217, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 214, 'V', getdate(), 242, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 216, 'V', getdate(), 241, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 217, 'V', getdate(), 218, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 218, 'V', getdate(), 218, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 220, 'V', getdate(), 245, NULL)
GO


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 230, 'V', getdate(), 227, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 232, 'V', getdate(), 226, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 234, 'V', getdate(), 229, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 235, 'V', getdate(), 228, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 245, 'V', getdate(), 225, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 247, 'V', getdate(), 208, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 253, 'V', getdate(), 307, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 264, 'V', getdate(), 307, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 281, 'V', getdate(), 281, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 282, 'V', getdate(), 282, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 283, 'V', getdate(), 283, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 302, 'V', getdate(), 289, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 303, 'V', getdate(), 291, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 320, 'V', getdate(), 214, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 322, 'V', getdate(), 204, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 331, 'V', getdate(), 259, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 332, 'V', getdate(), 259, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 343, 'V', getdate(), 304, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 352, 'V', getdate(), 309, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 354, 'V', getdate(), 309, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 357, 'V', getdate(), 309, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 367, 'V', getdate(), 311, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 380, 'V', getdate(), 253, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 381, 'V', getdate(), 396, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 387, 'V', getdate(), 205, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 388, 'V', getdate(), 205, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 389, 'V', getdate(), 205, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 390, 'V', getdate(), 205, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 393, 'V', getdate(), 315, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 394, 'V', getdate(), 396, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 395, 'V', getdate(), 316, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 396, 'V', getdate(), 396, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 397, 'V', getdate(), 397, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 398, 'V', getdate(), 398, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 399, 'V', getdate(), 399, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 400, 'V', getdate(), 396, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4130, 'V', getdate(), 4052, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4131, 'V', getdate(), 4053, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4132, 'V', getdate(), 4053, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4133, 'V', getdate(), 4053, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4134, 'V', getdate(), 4053, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4135, 'V', getdate(), 4052, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4142, 'V', getdate(), 4049, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4144, 'V', getdate(), 719, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4146, 'V', getdate(), 4059, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4148, 'V', getdate(), 4049, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4149, 'V', getdate(), 396, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4150, 'V', getdate(), 396, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4151, 'V', getdate(), 396, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4152, 'V', getdate(), 396, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4153, 'V', getdate(), 396, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4154, 'V', getdate(), 396, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4155, 'V', getdate(), 396, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4163, 'V', getdate(), 312, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4164, 'V', getdate(), 312, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4165, 'V', getdate(), 312, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4166, 'V', getdate(), 312, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 4167, 'V', getdate(), 312, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (6, 'R', 0, 400, 'V', getdate(), 6539, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 253, 'V', getdate(), 308, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 264, 'V', getdate(), 308, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 403, 'V', getdate(), 402, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 408, 'V', getdate(), 407, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 410, 'V', getdate(), 405, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 429, 'V', getdate(), 423, NULL)
GO


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 475, 'V', getdate(), 460, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 494, 'V', getdate(), 459, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 602, 'V', getdate(), 472, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 603, 'V', getdate(), 631, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 604, 'V', getdate(), 633, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 606, 'V', getdate(), 630, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 607, 'V', getdate(), 630, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 672, 'V', getdate(), 414, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 696, 'V', getdate(), 614, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 697, 'V', getdate(), 614, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 698, 'V', getdate(), 635, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 702, 'V', getdate(), 700, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 707, 'V', getdate(), 707, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 708, 'V', getdate(), 708, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 710, 'V', getdate(), 708, NULL)
GO


INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 720, 'V', getdate(), 709, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 722, 'V', getdate(), 710, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 738, 'V', getdate(), 717, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 741, 'V', getdate(), 718, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 743, 'V', getdate(), 720, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (17, 'R', 0, 4101, 'V', getdate(), 4036, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (17, 'R', 0, 4102, 'V', getdate(), 4041, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (17, 'R', 0, 4103, 'V', getdate(), 4042, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (17, 'R', 0, 4104, 'V', getdate(), 4047, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (17, 'R', 0, 4105, 'V', getdate(), 4048, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (17, 'R', 0, 4106, 'V', getdate(), 4049, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (17, 'R', 0, 4107, 'V', getdate(), 4046, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (17, 'R', 0, 4108, 'V', getdate(), 4040, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (26, 'R', 0, 400, 'V', getdate(), 26248, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (42, 'R', 0, 29265, 'V', getdate(), 29265, NULL)
GO

INSERT INTO dbo.ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 689, 'V', getdate(), 458, NULL)
GO

INSERT INTO dbo.ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 48, 'V',  getdate(), 23, NULL)
GO

INSERT INTO dbo.ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 50, 'V',  getdate(), 2630, NULL)
GO

INSERT INTO dbo.ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 699, 'V',  getdate(), 635, NULL)
GO

INSERT INTO dbo.ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 701, 'V',  getdate(), 635, NULL)
GO

INSERT INTO dbo.ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4, 'R', 0, 2850, 'V',  getdate(), 2645, NULL)
GO






delete  from cobis..cl_ttransaccion where tn_trn_code IN (80,90,99,201,202,203,204,205,211,212,214,216,217,218,220,223,230,232,
                                                         234,235,245,247,281,282,283,302,303,320,331,332, 343,352,354,357,367,
                                                         381,390,393,394,395,400,403,408,410,429,494,584,602,603,604,606,607,
                                                         672,697,702,707,708,710,714,717,720,722,738,743,2564,2581,2582,2583,
                                                         2584,2585,2586,2587,2588,2589,2590,2591,2592,2593,2594,2595,2596,2669,
                                                         2696,2700,2810,2879,2913,2938,4101,4102,4103,4104,4105,4106,4107,4108,
                                                         4133,4134,4144,4149,4150,4151,4152,4153,4154,4155,4163,
                                                         253,264,322,380,387,388,389,396,397,398,399,4130,4131,4132,4134,4135,
                                                         4142,4146,4148,4164,4165,4166,4167,452,475,696,698,741,29265,
                                                         2576,424,34,6907,2812,407,601,447,721,703,704,6906,719,16,3082,711,92,
                                                         734,493,747,3016,700,2916,739,2811,689,699,701,2850,50,48)
go

/* *********************************/
print '---->>cl_ttransaccion'
/* *********************************/


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (700, 'CONSULTA DE ACCION NOTAS DEBITO', 'CAND', 'CONSULTA DE ACCION DE NOTAS DEBITO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2916, 'CONSULTA CAUSA ING-EGR VARIOS', 'COIE', 'CONSULTA CAUSALES INGRESOS-EGRESOS VARIOS')
GO


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (739, 'MANTENIMIENTO ND/NC POR OFICINA I', 'MNDCO', 'MANTENIMIENTO ND/NC POR OFICINA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2811, 'RELACION OFICINA - CENTRO DE CANJE', 'ROCC', ' RELACION OFICINA - CENTRO DE CANJE')
GO


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (3016, 'QUERY DE FIRMAS CANDIDATAS', 'QRFC', 'QUERY DE FIRMAS CANDIDATAS')
GO


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (747, 'BUSQUEDA DE RELACION CUENTA A CANAL', 'BRCC', 'BUSQUEDA DE RELACION CUENTA A CANAL')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (493, 'MANTENIMIENTO DE TRANSACCIONES A CONTABILIZAR', 'MCON', 'MANTENIMEINTO DE TRANSACCIONES A CONTABILIZAR')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (734, 'MANTENIMIENTO PRODUCTO AHORRO CONTRACTUAL', 'MAAH', 'MANTENIMIENTO PRODUCTO AHORRO CONTRACTUAL')
GO


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (92, 'CONSULTA DE CASILLA POR F5', 'CCAS', 'CONSULTA DE CASILLA POR F5')
GO


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (16, 'CONSULTA DEL NOMBRE DE LA CUENTA CORRIENTE', 'CONM', 'ESTA TRANSACCION CONSULTA DEL NOMBRE DE LA CUENTA CORRIENTE')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (711, 'BUSQUEDA DE DEFINICION TRANSFERENCIAS AUTOMATICAS', 'BETA', 'BUSQUEDA DE DEFINICION TRANSFERENCIAS AUTOMATICAS')
GO


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (714, 'INGRESO DE DEFINICION TRANSFERENCIAS AUTOMATICAS', 'BETA', 'INGRESO DE DEFINICION TRANSFERENCIAS AUTOMATICAS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (717, 'INGRESO DE DETALLE TRANSFERENCIAS AUTOMATICAS', 'BETA', 'INGRESO DE DETALLE TRANSFERENCIAS AUTOMATICAS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2938, 'INSERCION ORDEN DE COBRO CERTIFICACION', 'IOCC', 'INSERCION ORDEN DE COBRO CERTIFICACION')
GO



INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (719, 'CONSULTA CONCEPTO CONTABLE', 'CPCC', 'CONSULTA CONCEPTO CONTABLE')
GO


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (452, 'CONSULTA DE BANCOS PARA CAMARA', 'CBPC', 'CONSULTA DE LOS BANCOS EXISTENTES PARA CAMARA')
GO


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (703, 'CONSULTA DEVOLUCION VALORES RECAUDADOS CB', '703', 'CONSULTA DEVOLUCION VALORES RECAUDADOS CB')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (704, 'CONSULTA PUNTOS RED CB', '704', 'CONSULTA PUNTOS RED CB')
GO


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (34, 'CONSULTA DE AGENCIAS POR F5', 'COAG', 'CONSULTA DE AGENCIAS POR F5')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (223, 'SOLICITUD DE ESTADO DE CUENTA SIN COSTO AH', 'SECS', 'SOLICITUD DE ESTADO DE CUENTA SIN COSTO AH')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (407, 'CONSULTA GENERAL DE UNA CARTA', 'CGCA', 'CONSULTA GENERAL DE UNA CARTA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (424, 'CONSULTA DE PRODUCTOS BANCARIOS', 'COPB', 'CONSULTA DE PRODUCTOS BANCARIOS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (447, 'CONSULTA CARTAS Y BANCOS CORRESPONSALES', 'CCBC', 'CONSULTA CARTAS Y BANCOS CORRESPONSALES')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (601, 'ACUSE DE NOVEDADADES', 'ADNO', 'ACUSE DE NOVEDADADES')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (721, 'OPCIONES DE CONSULTA PARA PARAMETRIZACION DE PERFIL', 'CPPER', 'EJECUTA LAS CONSULTAS DE LOS DATOS PARA LA PARAMETRIZACION DE LAS TRANSACCIONES AL PERFIL CONTABLE')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2576, 'CONSULTA CATALOGO TRN MONET Y SERV', 'CTMS', 'CONSULTA CATALOGO DE TRANSACCIONES MONETARIAS Y DE SERVICIOS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2812, 'TRASALADO DE CAPITAL SOBREGIRO POR VIGENCIA', 'TCSV', 'TRASALADO DE CAPITAL SOBREGIRO POR VIGENCIA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (6907, 'SEARCH DE PERFIL CONTABLE', '6907', 'SEARCH DE PERFIL CONTABLE')
GO


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (6906, 'QUERY DE PERFIL CONTABLE', '6906', 'QUERY DE PERFIL CONTABLE')
GO

-- pRIMEROS

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (80, 'CONSULTA DE TOTALES POR OFICINA', 'CTOF', 'CONSULTA DE TOTALES POR OFICINA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (90, 'CONSULTA DE TOTALES POR CAJERO ADM', 'CTCA', 'CONSULTA LOS TOTALES DE CAJERO (ADMINISTRATIVA)')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (99, 'MENSAJES DE ESTADOS DE CUENTA', 'MEEC', 'INSERTA LOS MENSAJES PARA IMPRIMIR CON EL ESTADO DE CUENTA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (201, 'APERTURA DE CUENTA DE AHORROS', 'ACAH', 'APERTURA DE CUENTA DE AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (202, 'ACTUALIZACION DE CUENTA DE AHORROS', 'AAHO', 'ACTUALIZACION DE CUENTA DE AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (203, 'REACTIVACION DE CUENTAS DE AHORROS', 'RCAH', 'REACTIVACION DE CUENTAS DE AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (204, 'REAPERTURA DE CUENTAS DE AHORROS', 'RACA', 'REAPERTURA DE CUENTAS DE AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (205, 'ACTUALIZACION DE CUENTA DE AHORROS GENERAL', 'AAGN', 'ACTUALIZACION DE CUENTA DE AHORROS GENERAL')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (211, 'BLOQUEO DE MOVIMIENTOS DE AHORROS', 'BMAH', 'BLOQUEO DE MOVIMIENTOS DE AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (212, 'LEVANTAMIENTO DE MOVIMIENTOS AH', 'LMAH', 'LEVANTAMIENTO DE MOVIMIENTOS AH')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (214, 'CONSULTA DE CIERRE DE CUENTA', 'CCCA', 'CONSULTA DE CIERRE DE CUENTA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (216, 'CONSULTA DE BLOQUEOS DE VALORES PARA LEVANTAMIENTO AH', 'CBVL', 'CONSULTA DE BLOQUEO DE VALORES PARA LEVANTAMIENTO AH')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (217, 'BLOQUEO DE VALORES AH', 'BVAH', 'BLOQUEO DE VALORES DE AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (218, 'LEVANTAMIENTO DE BLOQUEO DE VALORES AH', 'SFS', 'LEVANTAMIENTO DE BLOQUEO DE VALORES AH')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (220, 'CONSULTA DE AHORROS MONETARIA', 'CNMA', 'CONSULTA DE AHORROS MONETARIA')
GO


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (230, 'CONSULTA DE SALDOS DE CUENTAS DE AHORROS', 'CSAH', 'CONSULTA DE SALDOS DE CUENTAS DE AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (232, 'CONSULTA DE ESTADO DE CUENTA DE AHORROS', 'CECA', 'CONSULTA DE ESTADO DE CUENTA DE AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (234, 'COBRO DE SOLICITUD DE ESTADO DE CUENTA AH', 'CSEC', 'SOLICITUD DE ESTADO DE CUENTA AH')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (235, 'CONSULTA NO MONETARIA DE AHORROS', 'CMAH', 'CONSULTA NO MONETARIA DE AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (245, 'CONSULTA DE BLOQUEO DE MOVIMIENTOS', 'CBMO', 'CONSULTA DE BLOQUEO DE MOVIMIENTOS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (247, 'CONSULTA DE VALORES EN SUSPENSO', 'CVAS', 'CONSULTA DE VALORES EN SUSPENSO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (253, 'N/C', 'NCSL', 'ESTA TRANSACCION PROCESA LAS NOTAS DE CREDITO DE AHORROS SIN LIBRETA Y SI HAY VALORES EN SUSPENSO LOS COBRA.')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (264, 'N/D', 'NDSL', 'ESTA TRANSACCION PROCESA LAS NOTAS DE DEBITO DE AHORROS SIN LIBRETA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (281, 'CONSULTA HISTORICO TRN MONETARIAS AHO', 'CHTM', 'CONSULTA HISTORICO TRANSACCIONES MONETARIAS AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (282, 'CONSULTA TRANSACCIONES DE SERVICIO AHO', 'CTRS', 'CONSULTA TRANSACCIONES DE SERVICIO AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (283, 'CONSULTA HISTORICO TRN SERVICIOS AHO', 'CHTS', 'CONSULTA HISTORICO TRANSACCIONES DE SERVICIOS AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (302, 'OPERACIONES SUPERIORES A UN MONTO', 'OSPA', 'OPERACIONES SUPERIORES A UN MONTO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (303, 'COBRO DE VALORES EN SUSPENSO EN LINEA PARA AHO', 'CVSA', 'COBRO DE VALORES EN SUSPENSO EN LINEA PARA AHO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (320, 'APERTURA DE CUENTAS CIFRADAS', 'APCI', 'APERTURA DE CUENTAS CIFRADAS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (322, 'CONSULTA DE COMISIONES POR TRANSACCION', 'CCPT', 'CONSULTA DE COMISIONES POR TRANSACCION')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (331, 'CONSULTA DE RETENCIONES LOCALES DE AHORROS', 'CRLA', 'CONSULTA DE RETENCIONES LOCALES DE AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (332, 'LIBERACION ANTICIPADA DE FONDOS', 'LARA', 'LIBERACION ANTICIPADA DE FONDOS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (343, 'CONSULTA DE DETALLE DE INTERES', '343', 'CONSULTA DE DETALLE DE INTERES')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (352, 'INSERCION DE SOLICITUD DE CTA.', '352', 'INSERCION DE SOLICITUD PARA UNA APERTURA DE CTA. AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (354, 'ACTUALIZACION DE SOLICITUD DE CTA.', '354', 'ACTUALIZACION DE SOLICITUD PARA UNA APERTURA DE CTA. AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (357, 'PANTALLA DE SOLICITUD DE CTA.', '357', 'PANTALLA DE CONSULTA DE SOLICITUD DE CTA. DE AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (367, 'INACTIVACION DE CUENTAS DE AHORROS', '367', 'INACTIVACION DE CUENTAS DE AHORROS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (380, 'RETIRO AHORROS EN CHEQUE', 'RACC', 'RETIRO AHORROS EN CHEQUE')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (381, 'LIBERACION DE CUPO CB POSICIONADO', 'LCCB', 'LIBERACION DE CUPO CB POSICIONADO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (387, 'ELIMINACION CODIGO DTN POR CATEGORIA Y PROFINAL', '387', 'ELIMINACION CODIGO DTN POR CATEGORIA Y PROFINAL')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (388, 'SEARCH CODIGO DTN POR CATEGORIA Y PROFINAL', '388', 'SEARCH CODIGO DTN POR CATEGORIA Y PROFINAL')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (389, 'QUERY CODIGO DTN POR CATEGORIA Y PROFINAL', '389', 'QUERY CODIGO DTN POR CATEGORIA Y PROFINAL')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (390, 'Tadmin/Administracion/Mantenimiento Codigos DTN', '390', 'Tadmin/Administracion/Mantenimiento Codigos DTN')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (393, 'IMPRESION PLAN DE PAGO CUENTAS ESPECIALES', 'IMPL', 'IMPRESION PLAN DE PAGO CUENTAS ESPECIALES')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (394, 'CANCELACION CUENTA CB POSICIONADO', 'CCCB', 'CANCELACION CUENTA CB POSICIONADO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (395, 'CONSULTA SEGUIMIENTO PLAN', 'COSE', 'CONSULTA SEGUIMIENTO PLAN')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (396, 'MANTENIMIENTO CB RED PROPIA', 'MCBRP', 'MANTENIMIENTO CB RED PROPIA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (397, 'MANTENIMIENTO CB PUNTOS', 'MCBPU', 'MANTENIMIENTO CB PUNTOS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (398, 'MANTENIMIENTO CUPO CB', 'MCUCB', 'MANTENIMIENTO CUPO CB')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (399, 'CONSULTA MOVIMIENTOS CB', 'CMOVCB', 'CONSULTA MOVIMIENTOS CB')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (400, 'CORRESPONSAL BANCARIO RED POSICIONADO', 'CBRP', 'CORRESPONSAL BANCARIO RED POSICIONADO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (403, 'CONFIRMA CARTA DE REMESAS MANUAL', 'CCMA', 'CONFIRMA CARTA DE REMESAS MANUAL')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (408, 'CONSULTA DE CHEQUES POR CUENTA', 'CHCU', 'CONSULTA DE CHEQUES POR CUENTA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (410, 'CONSULTA DE CARTA POR CORRESPONSAL', 'CACO', 'CONSULTA DE CARTA POR CORRESPONSAL')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (429, 'CONSULTA DE CHEQUES REMESA POR OFICINA', 'CRPO', 'CONSULTA DE CHEQUES REMESA POR OFICINA')
GO


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (475, 'CONSULTA DE PRODUCTOS COBIS', 'COPC', 'CONSULTA DE PRODUCTOS COBIS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (494, 'CONSULTA DE TRANSACCIONES A CONTABILIZAR', 'CCON', 'CONSULTA DE TRANSACCIONES A CONTABILIZAR')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (584, 'INSERCION DE CATALOGO', 'INCATA', 'DESCRIPCION')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (602, 'CONSULTA CARTAS DE REMESAS X OFICINA', 'CCRO', 'CONSULTA CARTAS DE REMESAS X OFICINA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (603, 'ACUSE DE REMESAS', 'ADRE', 'ACUSE DE REMESAS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (604, 'BLOQUEO DE CHEQUES', 'BDCH', 'BLOQUEO DE CHEQUES')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (606, 'CONSULTA CHEQUES REMESAS VIA BANCOS X OFICINA', 'CCBO', 'CONSULTA CHEQUES REMESAS VIA BANCOS X OFICINA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (607, 'CONSULTA TOTAL DE CHEQUES REMESAS VIA BANCOS X OFICINAS', 'CTCR', 'CONSULTA TOTAL DE CHEQUES REMESAS VIA BANCOS X OFICINAS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (672, 'INGRESO TIPO CANJE POR OFICINA', 'TDCO', 'INGRESO TIPO CANJE POR OFICINA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (696, 'CONSULTA CUENTA DE CONSIGNACION OFICINA', 'CCCO', 'CONSULTA CUENTA DE CONSIGNACION OFICINA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (697, 'ADMINISTRACION CUENTA DE CONSIGNACION OFICINA', 'ACCO', 'ADMINISTRACION CUENTA DE CONSIGNACION OFICINA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (698, 'CREACION DE ACCION NOTAS DEBITO', 'CAND', 'CREACION DE ACCION NOTAS DEBITO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (702, 'CONSULTA ARCHIVO DE ALIANZAS', 'CAAC', 'CONSULTA ARCHIVO DE ALIANZAS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (707, 'PERSONALIZACION DE NOTAS DE DEBITO/CREDITO', 'PNDC', 'PERSONALIZACION DE NOTAS DE DEBITO/CREDITO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (708, 'INGRESO CONCEPTO CONTABLE', 'IPCC', 'INGRESO CONCEPTO CONTABLE')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (710, 'ACTUALIZACION CONCEPTO CONTABLE', 'APCC', 'ACTUALIZACION CONCEPTO CONTABLE')
GO


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (720, 'MANTENIMIENTO OPCIONES DML PARA PARAMETRIZACION DE PERFIL', 'MPPER', 'REALIZA EL MANTENIMIENTO DE LOS DATOS PARA LA PARAMETRIZACION DE LAS TRANSACCIONES AL PERFIL CONTABLE')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (722, 'MARCACION DE SERVICIOS A CUENTAS', 'MASE', 'MARCACION DE SERVICIOS A CUENTAS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (738, 'MANTENIMIENTO ND/NC POR OFICINA', 'MNDCO', 'MANTENIMIENTO ND/NC POR OFICINA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (741, 'BUSQUEDA DE CAUSALES', 'BUCAU', 'BUSQUEDA DE CAUSALES')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (743, 'TADMIN/PROCESOS/RELACION CUENTA A CANALES', 'TPRCC', 'TADMIN/PROCESOS/RELACION CUENTA A CANALES')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2564, 'MANTENIMIENTO PLAZAS BANCO REPUBLICA', 'MPBR', 'MANTENIMIENTO PLAZAS BANCO REPUBLICA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2581, 'CREACION DE ACCION NOTAS DEBITO', 'CAND', 'CREACION ACCION NOTAS DEBITO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2582, 'ACTUALIZACION DE ACCION DE NOTAS DEBITO', 'AAND', 'ACTUALIZACION DE ACCION NOTAS DEBITO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2583, 'CONSULTA DE ACCION NOTAS DEBITO', 'CAND', 'CONSULTA DE ACCION DE NOTAS DEBITO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2584, 'ELIMINACION DE ACCION NOTAS DE DEBITO', 'EAND', 'ELIMINACION DE ACCION NOTAS DE DEBITO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2585, 'CREACION DE RUTA Y TRANSITO', 'CRYT', 'CREACION DE RUTA Y TRANSITO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2586, 'ACTUALIZACION DE RUTA Y TRANSITO', 'ARYT', 'ACTUALIZACION DE RUTA Y TRANSITO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2587, 'CONSULTA DE RUTA Y TRANSITO', 'CRYT', 'CONSULTA DE RUTA Y TRANSITO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2588, 'ELIMINACION DE RUTA Y TRANSITO', 'ERYT', 'ELIMINACION DE RUTA Y TRANSITO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2589, 'CREACION DE OFICINAS DEL BANCO', 'CODB', 'CREACION DE OFICINAS DEL BANCO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2590, 'ACTUALIZACION DE OFICINAS DEL BANCO', 'AODB', 'ACTUALIZACION DE OFICINAS DEL BANCO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2591, 'CONSULTA DE OFICINAS DEL BANCO', 'CODB', 'CONSULTA DE OFICINAS DEL BANCO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2592, 'ELIMINACION DE OFICINAS DEL BANCO', 'EODB', 'ELIMINACION DE OFICINAS DEL BANCO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2593, 'CREACION DE BANCOS', 'CBAN', 'CREACION DE BANCOS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2594, 'ACTUALIZACION DE BANCOS', 'ABAN', 'ACTUALIZACION DE BANCOS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2595, 'CONSULTA DE BANCOS', 'CBAN', 'CONSULTA DE BANCOS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2596, 'ELIMINACION DE BANCOS', 'EBAN', 'ELIMINACION DE BANCOS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2669, 'INGRESO FORM. CONTROL TRAN EFECTIVO', 'IFCT', 'INGRESO FORMULARIO CONTROL TRANS. EFECTIVO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2696, 'MANTENIMIENTO DE CAUSALES DE NOTAS DEBITO Y CREDITO PARA CAJA', 'MCDC', 'MANTENIMIENTO DE CAUSALES DE NOTAS DEBITO Y CREDITO PARA CAJA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2700, 'CONSULTA NACIONAL DE CAJA', 'CNAC', 'CONSULTA NACIONAL DE CAJA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2810, 'MANTENIMIENTO CENTROS DE CANJE', 'MCDC', 'MANTENIMIENTO CENTROS DE CANJE')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2879, 'CREACION DE PAQUETE DE PRODUCTOS', 'CRPA', 'CREACION DE PAQUETE DE PRODUCTOS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2913, 'CREACION CAUSA ING-EGR VARIOS', 'CCIE', 'CREACION CAUSALES INGRESOS EGRESOS VARIOS')
GO


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4101, 'CATEGORIA POR PRODUCTOS FINALES', '4101', 'CATEGORIA POR PRODUCTOS FINALES')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4102, 'INGRESO CONCEPTO GMF', 'IGMF', 'INGRESO CONCEPTO EXENCION GMF')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4103, 'ACTUALIZACION CONCEPTO GMF', 'AGMF', 'ACTUALIZACION CONCEPTO EXENCION GMF')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4104, 'ELIMINACION CONCEPTO GMF', 'EGMF', 'ELIMINACION CONCEPTO EXENCION GMF')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4105, 'CONSULTA DE CUENTAS EXENTAS', 'CCEX', 'CONSULTA DE CUENTAS EXENTAS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4106, 'ACTUALIZACION DE CUENTAS EXENTAS', 'ACEX', 'ACTUALIZACION DE CUENTAS EXENTAS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4107, 'MANTENIMIENTO DE CONCEPTOS PARA TRANSACCIONES', 'MCTRN', 'MANTENIMIENTO DE CONCEPTOS PARA TRANSACCIONES')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4108, 'CONSULTA CONCEPTO GMF', 'CGMF', 'CONSULTA CONCEPTO EXENCION GMF')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4130, 'CAMBIO DE CATEGORIA', '4130', 'CAMBIO DE CATEGORIA PARA UNA CUENTA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4131, 'INGRESO AUTORIZACION RETIRO POR OFICINA', '4131', 'INGRESO AUTORIZACION RETIRO POR OFICINA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4132, 'BLOQUEO AUTORIZACION RETIRO POR OFICINA', '4132', 'BLOQUEO AUTORIZACION RETIRO POR OFICINA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4133, 'CONSULTA AUTORIZACION RETIRO POR OFICINA', '4133', 'CONSULTA AUTORIZACION RETIRO POR OFICINA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4134, 'QUERY AUTORIZACION RETIRO POR OFICINA', '4134', 'QUERY AUTORIZACION RETIRO POR OFICINA')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4135, 'INCUMPLIMIENTOS AHO CONTRACTUAL', '4135', 'MARCA INCUMPLIMIENTO AHO CONTRACTUAL')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4142, 'TRANSACCION MARCACION GMF', 'MGMF', 'EJECUTA PROCESO MARCACION GMF')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4144, 'C. de Ahorros/Cuentas/Activacion Cuentas sin Deposito Inicial', '4144', 'C. de Ahorros/Cuentas/Activacion Cuentas sin Deposito Inicial')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4146, 'ANULACION DE CUENTAS SIN DEPOSITO INCIAL', '4146', 'ANULACION DE CUENTAS SIN DEPOSITO INCIAL')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4148, 'TRANSACCION DESMARCACION GMF', 'DGMF', 'EJECUTA PROCESO DESMARCACION GMF')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4149, 'MENU / MANTENIMIENTO CUPO CB', '4149', 'CORRESPONSAL BANCARIO RED POSICIONADO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4150, 'MENU / CONSULTA DE CUPO', '4150', 'CORRESPONSAL BANCARIO RED POSICIONADO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4151, 'MENU / CONSULTA DE MOVIMIENTOS', '4151', 'CORRESPONSAL BANCARIO RED POSICIONADO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4152, 'MENU / DEVOLUCION DE VALORES', '4152', 'CORRESPONSAL BANCARIO RED POSICIONADO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4153, 'MENU / GESTION DE CUENTAS', '4153', 'CORRESPONSAL BANCARIO RED POSICIONADO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4154, 'MENU / CONSOLIDADO DE REDES', '4154', 'CORRESPONSAL BANCARIO RED POSICIONADO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4155, 'MENU / MANTENIMIENTO CB', '4155', 'CORRESPONSAL BANCARIO RED POSICIONADO')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4163, 'MENU MANTENIMIENTO EQUIVALENCIAS', '4163', 'MENU MANTENIMIENTO EQUIVALENCIAS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4164, 'BUSQUEDA EQUIVALENCIAS', '4164', 'BUSQUEDA EQUIVALENCIAS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4165, 'INSERCION EQUIVALENCIAS', '4165', 'INSERCION EQUIVALENCIAS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4166, 'MODIFICACION EQUIVALENCIAS', '4166', 'MODIFICACION EQUIVALENCIAS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (4167, 'ELIMINACION EQUIVALENCIAS', '4167', 'ELIMINACION EQUIVALENCIAS')
GO

INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (29265, 'CONSULTA DE SUBTIPOS', 'CSTID', 'CONSULTA DE SUBTIPOS DE INSTRUMENTOS DISPONIBLES')
GO

INSERT INTO cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (689, 'ELIMINACION DE  TRANSACCIONES A CONTABILIZAR', 'ETCO', 'ELIMINACION DE  TRANSACCIONES A CONTABILIZAR')
GO

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (48, 'NOTA CREDITO', 'NCCO', 'ESTA TRANSACCION REALIZA LAS NOTAS DE CREDITO GENERALES')
GO

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (50, 'NOTA DEBITO', 'NDCO', 'ESTA TRANSACCION REALIZA LAS NOTAS DE DEBITO PONIENDO EN VALORES EN SUSPENSO SI NO EXISTIERA DISPONIBLE')
GO

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (699, 'ACTUALIZACION DE ACCION DE NOTAS DEBITO', 'AAND', 'ACTUALIZACION DE ACCION DE NOTAS DEBITO')
GO

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (701, 'ELIMINACION DE ACCION NOTAS DE DEBITO', 'EAND', 'ELIMINACION DE ACCION NOTAS DE DEBITO')
GO

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2850, 'ACTUALIZACION DE CUENTAS MAL CREADAS POR OLF-SAFE', 'CAMO', 'ACTUALIZACION DE CUENTAS MAL CREADAS POR OLF-SAFE')
GO



/* *********************************/
print '---->>ad_tr_autorizada'
/* *********************************/


delete  from cobis..ad_tr_autorizada WHERE ta_transaccion IN (80,90,99,201,202,203,204,205,211,212,214,216,217,218,220,223,230,232,
                                                         234,235,245,247,281,282,283,302,303,320,331,332, 343,352,354,357,367,
                                                         381,390,393,394,395,400,403,408,410,429,494,584,602,603,604,606,607,
                                                         672,697,702,707,708,710,714,717,720,722,738,743,2564,2581,2582,2583,
                                                         2584,2585,2586,2587,2588,2589,2590,2591,2592,2593,2594,2595,2596,2669,
                                                         2696,2700,2810,2879,2913,2938,4101,4102,4103,4104,4105,4106,4107,4108,
                                                         4133,4134,4144,4149,4150,4151,4152,4153,4154,4155,4163,
                                                         253,264,322,380,387,388,389,396,397,398,399,4130,4131,4132,4134,4135,
                                                         4142,4146,4148,4164,4165,4166,4167,452,475,696,698,741,29265,
                                                         2576,424,34,6907,2812,407,601,447,721,703,704,6906,719,16,3082,711,92,
                                                         734,493,747,3016,700,2916,739,2811,689,699,701,2850,50,48)
                                       AND ta_rol = 1                   
go


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2916, 1, getdate(), 1832, 'V', getdate())
GO



INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 700, 1, getdate(), 1, 'V', getdate())
GO


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2811, 1, getdate(), 1, 'V', getdate())
GO



INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 739, 1, getdate(), 1, 'V', getdate())
GO



INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (5, 'R', 0, 3016, 1,  getdate(), 1, 'V',  getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 747, 1,  getdate(), 3, 'V',  getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 493, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 734, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 92, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 711, 1, getdate(), 1, 'V', getdate())
GO


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 3082, 1, getdate(), 3044, 'V', getdate())
GO


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (2, 'R', 0, 2938, 1, getdate(), 3044, 'V', getdate())
GO



INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 223, 1, getdate(), 1, 'V', getdate())
GO



INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 714, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 717, 1, getdate(), 1, 'V', getdate())
GO


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 719, 1, getdate(), 1, 'V', getdate())
GO



INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 16, 1, getdate(), 1, 'V', getdate())
GO


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2576, 1, getdate(), 1, 'V', getdate())
GO


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 424, 1, getdate(), 1, 'V', getdate())
GO



INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 34, 1, getdate(), 1, 'V', getdate())
GO



INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 407, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 447, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 601, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 721, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (6, 'R', 0, 6907, 1, getdate(), 842, 'V', getdate())
GO


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 703, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 704, 1, getdate(), 1, 'V', getdate())
GO







INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 80, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 90, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 99, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 201, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 202, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 203, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 204, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 205, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 211, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 212, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 214, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 216, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 217, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 218, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 220, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 230, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 232, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 235, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 245, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 247, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 281, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 282, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 283, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 302, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 303, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 320, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 331, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 332, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 343, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 352, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 354, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 357, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 367, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 381, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 390, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 394, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 395, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 400, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 403, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 408, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 410, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 429, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 494, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (1, 'R', 0, 584, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 602, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 603, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 604, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 606, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 607, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 672, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 697, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 702, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 707, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 708, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 710, 1, getdate(), 1, 'V', getdate())
GO


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 720, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 722, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 738, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 743, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2564, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2581, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2582, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2583, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2584, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2585, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2586, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2587, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2588, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2589, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2590, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2591, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2592, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2593, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2594, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2595, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2596, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2669, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2696, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2700, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2810, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2879, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2913, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (17, 'R', 0, 4101, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (17, 'R', 0, 4102, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (17, 'R', 0, 4103, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (17, 'R', 0, 4104, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (17, 'R', 0, 4105, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (17, 'R', 0, 4106, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (17, 'R', 0, 4107, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (17, 'R', 0, 4108, 1, getdate(), 1, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4144, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4149, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4150, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4151, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4152, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4153, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4154, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4155, 1, getdate(), 3, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4163, 1, getdate(), 3, 'V', getdate())
GO


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 475, 1, getdate(), 1, 'V', getdate())
GO



INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 698, 1, getdate(), 1, 'V', getdate())
GO



INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 696, 1, getdate(), 1, 'V', getdate())
GO


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 741, 1, getdate(), 2396, 'V', getdate())
GO


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (42, 'R', 0, 29265, 1, getdate(), 1, 'V', getdate())
GO


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 234, 1, getdate(), 1860, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 253, 1, getdate(), 1860, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 264, 1, getdate(), 1860, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 322, 1, getdate(), 3044, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 393, 1, getdate(), 2396, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 396, 1, getdate(), 5088, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 397, 1, getdate(), 5088, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 398, 1, getdate(), 5088, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 399, 1, getdate(), 5088, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4131, 1, getdate(), 3044, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4132, 1, getdate(), 3044, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4133, 1, getdate(), 3044, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4134, 1, getdate(), 3044, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4142, 1, getdate(), 3044, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4164, 1, getdate(), 5088, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4165, 1, getdate(), 5088, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4166, 1, getdate(), 5088, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 4167, 1, getdate(), 5088, 'V', getdate())
GO

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 689, 1, getdate(), 5088, 'V', getdate())
GO

INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 6906, 1, getdate(), 5088, 'V', getdate())
GO

INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', 0, 388, 1, getdate(), 5088, 'V', getdate())
GO
--
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 48, 1, getdate(), 5088, 'V', getdate())
GO

INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 50, 1, getdate(), 5088, 'V', getdate())
GO

INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 699, 1, getdate(), 5088, 'V', getdate())
GO

INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (10, 'R', 0, 701, 1, getdate(), 5088, 'V', getdate())
GO

INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', 0, 2850, 1, getdate(), 5088, 'V', getdate())
GO

