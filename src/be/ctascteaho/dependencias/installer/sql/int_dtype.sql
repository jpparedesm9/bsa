/************************************************************************/
/*      Archivo:            int_dtype.sql                                */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Walther Toledo                              */
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
/*      Este programa realiza la creacion de tipos de datos             */
/*      para la base de datos cob_interfase                             */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    22/Julio/2016     Tania Baidal    Migración a CEN                 */
/************************************************************************/

use cob_interfase
go

if not exists (select * from systypes where name = 'sexo')
   create type sexo from char(1) null

if not exists (select * from systypes where name = 'numero')
   create type numero from varchar(13) null

if not exists (select * from systypes where name = 'mensaje')
   create type mensaje from varchar(240) null

if not exists (select * from systypes where name = 'login')
   create type login from varchar(14) null

if not exists (select * from systypes where name = 'estado')
    create type estado from char(1) null

if not exists (select * from systypes where name = 'direccion')
    create type direccion from varchar(120) null

if not exists (select * from systypes where name = 'descripcion')
    create type descripcion from varchar(64) null

if not exists (select * from systypes where name = 'cuenta')
   create type cuenta from varchar(24) null

if not exists (select * from systypes where name = 'catalogo')
   create type catalogo from varchar(10) null
go

