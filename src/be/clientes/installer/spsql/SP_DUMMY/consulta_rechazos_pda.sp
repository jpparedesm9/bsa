/************************************************************************/
/*      Archivo:                sp_consulta_rechazos_pda.sp              */
/*      Stored procedure:       sp_consulta_rechazos_pda                 */
/*      Base de datos:          cob_palm                                  */
/*      Producto:               cob_palm                                  */
/*      Disenado por:           Karen Meza                              */
/*      Fecha de escritura:     11-May-2016                             */
/************************************************************************/
/*                             IMPORTANTE                               */
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
/*                             PROPOSITO                                */
/*    Este no ejecuta alguna sentencia, se lo realiza para compilar     */
/*    sps que dependen de este.                                         */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    May/02/2016     K. Meza                Emisión inicial            */
/************************************************************************/
use cob_palm
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_consulta_rechazos_pda')
  drop proc sp_consulta_rechazos_pda
go

create proc sp_consulta_rechazos_pda

as

return 0

go

