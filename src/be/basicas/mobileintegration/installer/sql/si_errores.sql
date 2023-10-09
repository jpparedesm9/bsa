/**********************************************************************/
/*   Archivo:         si_errores.sql                                  */
/*   Data base:       cobis                                           */
/**********************************************************************/
/*                     IMPORTANTE                                     */
/*   Esta aplicacion es parte de los  paquetes bancarios              */
/*   propiedad de COBISCORP.                                          */
/*   Su uso no autorizado queda  expresamente  prohibido              */
/*   asi como cualquier alteracion o agregado hecho  por              */
/*   alguno de sus usuarios sin el debido consentimiento              */
/*   por escrito de COBISCORP.                                        */
/*   Este programa esta protegido por la ley de derechos              */
/*   de autor y por las convenciones  internacionales de              */
/*   propiedad intelectual.  Su uso  no  autorizado dara              */
/*   derecho a COBISCORP para obtener ordenes  de secuestro           */
/*   o  retencion  y  para  perseguir  penalmente a  los              */
/*   autores de cualquier infraccion.                                 */
/**********************************************************************/
/*                      PROPOSITO                                     */
/*           Creación de errores de MOVILEINTEGRATION                 */
/**********************************************************************/
/*                      MODIFICACIONES                                */
/*   FECHA              AUTOR                  RAZON                  */
/*   02-08-2017         Paúl Ortiz             Emision Inicial        */
/*   30-08-2017         Paúl Ortiz             Refactor Dispositivos  */
/*   30-08-2017         AINCA                  Actualización Errores  */
/**********************************************************************/

use cobis
go

/*Lo que estaba aqui se pasa al archivo:  $/ASP/CLOUD/Iss/CLOUD-102318/Activas/Credito/Backend/sql/cr_errores.sql*/

delete from cl_errores where numero in (103192, 103193, 103194,103195, 2109106, 70078)
insert into cobis..cl_errores (numero, severidad, mensaje)
values (103192, 1, 'Error el Parámetro NOMBRE DE LA ETAPA INGRESO DE SOLICITUD no existe')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103193, 1, 'Error el Parámetro NOMBRE DE LA ETAPA APLICAR CUESTIONARIO - GRUPAL no existe')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103194, 1, 'Error el Parámetro NOMBRE DE LA ETAPA REVISAR Y VALIDAR INFORMACIÓN no existe')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103195, 1, 'Error el Parámetro NOMBRE DE LA ETAPA CAPTURAR FIRMAS Y DOCUMENTOS no existe')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (2109106, 1, 'ERROR: El dispositivo está asignado a otro oficial y se encuentra activo.')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (70078, 0, 'Existe una sincronización en proceso.')
go