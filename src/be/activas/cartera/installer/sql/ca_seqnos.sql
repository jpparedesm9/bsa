/************************************************************************/
/*      Archivo:            ca_seqnos.sql                               */
/*      Base de datos:      cob_cartera                                 */
/*      Producto:           Cartera                                     */
/*      Disenado por:       Tania Baidal                                */
/*      Fecha de escritura: 21/Junio/2017                               */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*      Este programa realiza la creacion de secuenciales               */
/*      para el modulo de Cartera                                       */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    21/Junio/2017     Tania Baidal    Emisión inicial                 */
/************************************************************************/
use cobis
go

/************/
/*  SEQNOS  */
/************/

delete cl_seqnos
where bdatos = 'cob_cartera'
go


print 'Insercion:  cl_seqnos'

insert into cobis..cl_seqnos(bdatos, tabla, siguiente, pkey)
values ('cob_cartera', 'ca_fuente_recurso', 0, 'fr_fondo_id')

insert into cobis..cl_seqnos(bdatos, tabla, siguiente, pkey)
values ('cob_cartera', 'ca_arch_cli_emproblemado', 0, 'ace_archivo')

go
