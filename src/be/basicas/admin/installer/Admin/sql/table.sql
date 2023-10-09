/******************************************************************************/
/* Archivo:            table.sql                                              */
/* Producto:           ADMINISTRACION                                         */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                                PROPOSITO                                   */
/* Creacion de tablas para internacionalizacion                               */
/******************************************************************************/
/*                                MODIFICACIONES                              */
/******************************************************************************/
/* FECHA        VERSION  AUTOR   RAZON                                        */
/******************************************************************************/
/* 27-Abr-2012  4.0.0.0  PCL     Internacionalizacion                         */
/******************************************************************************/

use cobis
GO

IF EXISTS (SELECT name FROM sysindexes WHERE name = 'pk_ad_recurso')
    DROP INDEX ad_recurso.pk_ad_recurso
GO

PRINT 'ELIMINACION DE TABLA ad_recurso'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'ad_recurso')
DROP TABLE ad_recurso
GO


IF EXISTS (SELECT name FROM sysindexes WHERE name = 'pk_ad_pseudo_catalogo')
    DROP INDEX ad_pseudo_catalogo.pk_ad_pseudo_catalogo
GO

IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ix_pc_tipo')
    DROP INDEX ad_pseudo_catalogo.ix_pc_tipo
GO

IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ix_pc_identificador')
    DROP INDEX ad_pseudo_catalogo.ix_pc_identificador
GO

IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ix_pc_codigo')
    DROP INDEX ad_pseudo_catalogo.ix_pc_codigo
GO

IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ix_pc_codigo_int')
    DROP INDEX ad_pseudo_catalogo.ix_pc_codigo_int
GO

PRINT 'ELIMINACION DE TABLA ad_pseudo_catalogo'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'ad_pseudo_catalogo')
DROP TABLE ad_pseudo_catalogo
GO


PRINT 'CREACION DE TABLA ad_pseudo_catalogo'
CREATE TABLE ad_pseudo_catalogo
(
    pc_id               INT         NOT NULL,
    pc_tipo             CHAR(1)     NOT NULL,
    pc_identificador    VARCHAR(64) NOT NULL,
    pc_codigo           VARCHAR(64) NULL,
    pc_codigo_int       INT         NULL
)


PRINT 'INDEX ad_pseudo_catalogo.pk_ad_pseudo_catalogo'
CREATE UNIQUE CLUSTERED INDEX pk_ad_pseudo_catalogo
ON ad_pseudo_catalogo (pc_id)
GO


PRINT 'INDEX ad_pseudo_catalogo.ix_pc_tipo'
CREATE NONCLUSTERED INDEX ix_pc_tipo
ON ad_pseudo_catalogo (pc_tipo)
GO


PRINT 'INDEX ad_pseudo_catalogo.ix_pc_identificador'
CREATE NONCLUSTERED INDEX ix_pc_identificador
ON ad_pseudo_catalogo (pc_tipo, pc_identificador)
GO


PRINT 'INDEX ad_pseudo_catalogo.ix_pc_codigo'
CREATE NONCLUSTERED INDEX ix_pc_codigo
ON ad_pseudo_catalogo (pc_tipo, pc_identificador, pc_codigo)
GO


PRINT 'INDEX ad_pseudo_catalogo.ix_pc_codigo_int'
CREATE NONCLUSTERED INDEX ix_pc_codigo_int
ON ad_pseudo_catalogo (pc_tipo, pc_identificador, pc_codigo_int)
GO


PRINT 'CREACION DE TABLA ad_recurso'
CREATE TABLE ad_recurso
(
    re_pc_id    INT             NOT NULL,
    re_cultura  VARCHAR(10)     NOT NULL,
    re_valor    VARCHAR(255)    NOT NULL
)

PRINT 'INDEX ad_recurso.pk_ad_recurso'
CREATE UNIQUE CLUSTERED INDEX pk_ad_recurso
ON ad_recurso (re_pc_id, re_cultura)
GO


PRINT 'CONSTRAINT ad_recurso.fk_ad_recurso'
ALTER TABLE ad_recurso
ADD CONSTRAINT fk_ad_recurso FOREIGN KEY(re_pc_id)
REFERENCES ad_pseudo_catalogo (pc_id)

GO
