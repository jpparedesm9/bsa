/************************************************************************/
/*      Archivo:            ah_ddefau.sql                               */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Ignacio Yupa                                */
/*      Fecha de escritura: 09/Mayo/2016                                */
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
/*      Este programa realiza la eliminacion de default                 */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/
/*  Creacion de defaults para Cuentas Corrientes  */

use cob_ahorros
go

/********************** Default ah_ssn_branch_serv_def    ******************************/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ah_ssn_branch_serv_def')) 
    DROP DEFAULT ah_ssn_branch_serv_def
GO
/********************** Default ah_ssn_branch_def    ******************************/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ah_ssn_branch_def') )
    DROP DEFAULT ah_ssn_branch_def
GO
/********************** Default ah_patente_def    ******************************/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ah_patente_def') )
    DROP DEFAULT ah_patente_def
GO
/********************** Default ah_hoy_def    ******************************/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ah_hoy_def') )
    DROP DEFAULT ah_hoy_def
GO
/********************** Default ah_fil_servicio_def    ******************************/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ah_fil_servicio_def') )
    DROP DEFAULT ah_fil_servicio_def
GO
/********************** Default ah_fil_monet_def    ******************************/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ah_fil_monet_def') )
    DROP DEFAULT ah_fil_monet_def
GO
/********************** Default ah_fil_hora_def    ******************************/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ah_fil_hora_def') )
    DROP DEFAULT ah_fil_hora_def
GO
/********************** Default ah_canal_def    ******************************/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ah_canal_def') )
    DROP DEFAULT ah_canal_def
GO
/********************** Default ah_alt_servicio_def    ******************************/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ah_alt_servicio_def') )
    DROP DEFAULT ah_alt_servicio_def
GO
/********************** Default ah_alt_monet_def    ******************************/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ah_alt_monet_def') )
    DROP DEFAULT ah_alt_monet_def
GO