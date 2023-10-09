/************************************************************************/
/*      Archivo:            ah_dtype.sql                                */
/*      Base de datos:      cob_conta                                   */
/*      Producto:           Contabilidad                                */
/*      Disenado por:       Ignacio Yupa                                */
/*      Fecha de escritura: 06/Julio/2016                               */
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
/*      FECHA         AUTOR           RAZON                             */
/*  06/Julio/2016     Walther Toledo  Migración a CEN                   */
/************************************************************************/
USE cob_conta
GO

if not exists (select * from systypes where name = 'sexo')
   CREATE TYPE sexo FROM char(1) NULL

if not exists (select * from systypes where name = 'numero')
   CREATE TYPE numero FROM varchar(13) NULL

if not exists (select * from systypes where name = 'mensaje')
   CREATE TYPE mensaje FROM varchar(240) NULL

if not exists (select * from systypes where name = 'login')
   CREATE TYPE login FROM varchar(14) NULL

if not exists (select * from systypes where name = 'estado')
    CREATE TYPE estado FROM char(1) NULL

if not exists (select * from systypes where name = 'direccion')
    CREATE TYPE direccion FROM varchar(120) NULL

if not exists (select * from systypes where name = 'descripcion')
    CREATE TYPE descripcion FROM varchar(64) NULL

if not exists (select * from systypes where name = 'cuenta')
   CREATE TYPE cuenta FROM varchar(24) NULL

if not exists (select * from systypes where name = 'catalogo')
   CREATE TYPE catalogo FROM varchar(10) NULL
GO

