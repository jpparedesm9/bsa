/**********************************************************************/
/*   Archivo:         si_seqnos.sql                                   */
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
/*   Insertar secuenciales en la tabla seqnos de MOVILEINTEGRATION    */
/**********************************************************************/
/*                      MODIFICACIONES                                */
/*   FECHA              AUTOR                  RAZON                  */
/*   02-08-2017         Paúl Ortiz             Emision Inicial        */
/**********************************************************************/


use cobis
go

delete cl_seqnos where tabla in ('si_dispositivo')
go

print 'cob_sincroniza..si_dispositivo'
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cob_sincroniza','si_dispositivo',0, 'di_codigo')
go

