/************************************************************************/
/*      Archivo:            sb_dtype.sql                                */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Karen Meza                                  */
/*      Fecha de escritura: 01/09/2016                                  */
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
/*      Este programa realiza la eliminacion de tipos de datos          */
/*      para el modulo de cuentas de corrientes                         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    01/09/2016    KMEZA           Migración a CEN                 */
/************************************************************************/
use cob_conta_super
go

drop type sexo

   create type sexo from char(1) null

drop type numero
   create type numero from varchar(13) null

drop type mensaje
   create type mensaje from varchar(240) null

drop type login
   create type login from varchar(14) null

drop type estado
    create type estado from char(1) null

drop type direccion
    create type direccion from varchar(160) null

drop type descripcion
    create type descripcion from varchar(160) null

drop type cuenta
   create type cuenta from varchar(24) null

drop type catalogo
   create type catalogo from varchar(10) null
go

