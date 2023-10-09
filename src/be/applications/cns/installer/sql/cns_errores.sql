/************************************************************************/
/*  Archivo:            ns_errores_upd.sql                              */
/*  Base de datos:      cobis                                    		*/
/*  Producto:           Banca Virtual                                   */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "Cobiscorp".                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Tablas para notifiaciones de banca en l¡nea                         */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       VERSION AUTOR           RAZON                           */
/*  2010-11-24  1.0.0   NES             Emisi¢n inicial                 */
/************************************************************************/

use cobis
go

update
cl_errores
set mensaje = 'PROBLEMA EN LA CONEXION, POR FAVOR, NOTIFIQUE A SU OFICIAL DE CUENTA'                                                                     
where numero = 1875000 
go

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (1850155, 1, 'Error en la actualizacion en mensaje a despachar')
GO
