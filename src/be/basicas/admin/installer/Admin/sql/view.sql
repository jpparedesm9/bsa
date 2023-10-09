/******************************************************************************/
/* Archivo:            view.sql                                               */
/* Producto:           COBIS                                                  */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                                PROPOSITO                                   */
/* Creacion de vistas para internacionalizacion                               */
/******************************************************************************/
/*                                MODIFICACIONES                              */
/******************************************************************************/
/* FECHA        VERSION  AUTOR   RAZON                                        */
/******************************************************************************/
/* 27-Abr-2012  4.0.0.0  PCL     Internacionalizacion                         */
/* 12-ABR-2016  4.0.0.1  BBO     Migracion SYBASE-SQLServer FAL               */
/******************************************************************************/

use cobis
GO

SET NOCOUNT ON
GO

/****************************************************************************/
/*  Vista General de Catalogos                                              */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA ad_catalogo_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'ad_catalogo_i18n')
DROP VIEW ad_catalogo_i18n
GO

PRINT 'CREACION DE VISTA ad_catalogo_i18n'
go
CREATE VIEW ad_catalogo_i18n
AS
    SELECT pc_id, pc_tipo, pc_identificador, pc_codigo, re_cultura, re_valor
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
        ON pc_id = re_pc_id
    WHERE pc_tipo = 'C'
GO

/****************************************************************************/
/*  Vista General de Etiquetas                                              */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA ad_etiqueta_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'ad_etiqueta_i18n')
DROP VIEW ad_etiqueta_i18n
GO

PRINT 'CREACION DE VISTA ad_etiqueta_i18n'
go
CREATE VIEW ad_etiqueta_i18n
AS
    SELECT pc_id, pc_tipo, pc_identificador, pc_codigo, re_cultura, re_valor
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
        ON pc_id = re_pc_id
    WHERE pc_tipo = 'L'
GO

/****************************************************************************/
/*  Vista General de Errores                                                */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA ad_error_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'ad_error_i18n')
DROP VIEW ad_error_i18n
GO

PRINT 'CREACION DE VISTA ad_error_i18n'
go
CREATE VIEW ad_error_i18n
AS
    SELECT pc_id, pc_tipo, pc_identificador, pc_codigo_int, re_cultura, re_valor
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
        ON pc_id = re_pc_id
    WHERE pc_tipo = 'E'
    AND pc_identificador = 'c-cobis-cl_errores'
GO

/****************************************************************************/
/*  Vista General de Defaults                                               */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA cl_default_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'cl_default_i18n')
DROP VIEW cl_default_i18n
GO

PRINT 'CREACION DE VISTA cl_default_i18n'
go
CREATE VIEW cl_default_i18n
AS
    SELECT pc_id, pc_tipo, pc_identificador, pc_codigo, pc_codigo_int, re_cultura, re_valor
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
        ON pc_id = re_pc_id
    WHERE pc_tipo = 'D'
GO

/****************************************************************************/
/*  Tabla  cl_ttransaccion                                                  */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA cl_ttransaccion_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'cl_ttransaccion_i18n')
DROP VIEW cl_ttransaccion_i18n
GO

PRINT 'CREACION DE VISTA cl_ttransaccion_i18n'
GO
CREATE VIEW cl_ttransaccion_i18n
AS
    SELECT pc_id, pc_tipo, pc_identificador, pc_codigo_int, re_cultura, re_valor
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
        ON pc_id = re_pc_id
    WHERE pc_tipo = 'T'
    AND pc_identificador = 'c-cobis-cl_ttransaccion'
GO

/********************************************************************************/
/*                               Vista-Tabla  cl_producto                       */ 
/*                              sp_bc_get_payment_accounts                      */
/********************************************************************************/
use cobis
go

PRINT 'ELIMINACION DE VISTA cl_producto_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'cl_producto_i18n')
DROP VIEW cl_producto_i18n
GO

PRINT 'CREACION DE VISTA cl_producto_i18n'
go
CREATE VIEW cl_producto_i18n
AS
    SELECT pc_id, pc_tipo, pc_identificador, pc_codigo_int, re_cultura, re_valor
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
    ON pc_id = re_pc_id
    WHERE pc_tipo = 'T'
    AND pc_identificador = 'c-cobis-cl_producto'

GO


/********************************************************************************/
/*                         Vista para Tabla cl_moneda                      */
/********************************************************************************/

use cobis
go

PRINT 'ELIMINACION DE VISTA cl_moneda_t_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'cl_moneda_t_i18n')
DROP VIEW cl_moneda_t_i18n
GO

PRINT 'CREACION DE VISTA cl_moneda_t_i18n'
go
CREATE VIEW cl_moneda_t_i18n
AS
    SELECT pc_codigo_int, re_cultura, re_valor
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
        ON pc_id = re_pc_id
    WHERE pc_tipo = 'T'
    AND pc_identificador = 'c-cobis-cl_moneda'

GO

use cobis
go

PRINT 'ELIMINACION DE VISTA cl_moneda_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'cl_moneda_i18n')
DROP VIEW cl_moneda_i18n
GO

PRINT 'CREACION DE VISTA cl_moneda_i18n'
go
CREATE VIEW cl_moneda_i18n
AS
    SELECT pc_id, pc_tipo, pc_identificador, pc_codigo_int, re_cultura, re_valor
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
        ON pc_id = re_pc_id
    WHERE pc_tipo = 'T'
    AND pc_identificador = 'c-cobis-cl_moneda'

GO


/****************************************************************************/
/*  Catalogo  bv_nem_producto_bv                                            */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA bv_nem_producto_bv_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'bv_nem_producto_bv_i18n')
DROP VIEW bv_nem_producto_bv_i18n
GO

PRINT 'CREACION DE VISTA bv_nem_producto_bv_i18n'
GO
CREATE VIEW bv_nem_producto_bv_i18n
AS
    SELECT pc_codigo, re_cultura, re_valor
    FROM ad_catalogo_i18n
    WHERE pc_identificador = 'bv_nem_producto_bv'
GO

/****************************************************************************/
/*  Tabla cob_cartera..ca_estado (central)                                  */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA ca_estado_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'ca_estado_i18n')
DROP VIEW ca_estado_i18n
GO

PRINT 'CREACION DE VISTA ca_estado_i18n'
go
CREATE VIEW ca_estado_i18n
AS
    SELECT pc_codigo_int, re_cultura, re_valor, pc_identificador --EAN002 - 16/10/2013
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
        ON pc_id = re_pc_id
    WHERE pc_tipo = 'T'
    AND pc_identificador = 'c-cob_cartera-ca_estado'
GO


/****************************************************************************/
/*  Vista con valores randomicos			                               */
/****************************************************************************/
--SRO
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'random_val_view')
DROP VIEW random_val_view
GO

PRINT 'CREACION DE VISTA ca_estado_i18n'
go

CREATE VIEW random_val_view
AS
SELECT RAND() as  random_value

go

/********************************************************************************/
/*                 Vista para ree_ien_file_transfer_def                  */
/********************************************************************************/
  --COMENTADO VERSION FALABELLA
--Use cob_remesas_ext
--go

--PRINT 'ELIMINACION DE VISTA ree_ien_file_transfer_def_i18n'
--IF EXISTS (SELECT 1 FROM sysobjects
--           WHERE name = 'ree_ien_file_transfer_def_i18n')
--DROP VIEW ree_ien_file_transfer_def_i18n
--GO

--PRINT 'CREACION DE VISTA ree_ien_file_transfer_def_i18n'
--go
--CREATE VIEW ree_ien_file_transfer_def_i18n
--AS
--    select
--        pc_codigo_int,
--        re_cultura,
--        re_valor
--    from
--      ad_pseudo_catalogo,
--      ad_recurso
--    where
--      pc_identificador = 'c-cob_remesas_ext-ree_ien_file_transfer_def'
--      and pc_tipo = 'T'
--      and pc_id = re_pc_id
--GO
 
/********************************************************************************/
/*               Eliminar trigger en caso de reinstalacion                      */
/********************************************************************************/
use cobis
go

IF EXISTS (SELECT 1 FROM sysobjects  WHERE name = 'tgd_ad_pseudo_catalogo')
DROP TRIGGER tgd_ad_pseudo_catalogo
GO
IF EXISTS (SELECT 1 FROM sysobjects  WHERE name = 'tgi_ad_pseudo_catalogo')
DROP TRIGGER tgi_ad_pseudo_catalogo
GO
IF EXISTS (SELECT 1 FROM sysobjects  WHERE name = 'tgu_ad_pseudo_catalogo')
DROP TRIGGER tgu_ad_pseudo_catalogo
GO
IF EXISTS (SELECT 1 FROM sysobjects  WHERE name = 'tgd_ad_recurso')
DROP TRIGGER tgd_ad_recurso
GO
IF EXISTS (SELECT 1 FROM sysobjects  WHERE name = 'tgi_ad_recurso')
DROP TRIGGER tgi_ad_recurso
GO
IF EXISTS (SELECT 1 FROM sysobjects  WHERE name = 'tgu_ad_recurso')
DROP TRIGGER tgu_ad_recurso
GO
if exists (select * from sysobjects where name = 'tgd_cl_catalogo')
    drop trigger tgd_cl_catalogo
go
if exists (select * from sysobjects where name = 'tgi_cl_catalogo')
    drop trigger tgi_cl_catalogo
go
if exists (select * from sysobjects where name = 'tgu_cl_catalogo')
    drop trigger tgu_cl_catalogo
go
if exists (select * from sysobjects where name = 'tgd_cl_ttransaccion')
    drop trigger tgd_cl_ttransaccion
go
if exists (select * from sysobjects where name = 'tgi_cl_ttransaccion')
    drop trigger tgi_cl_ttransaccion
go
if exists (select * from sysobjects where name = 'tgu_cl_ttransaccion')
    drop trigger tgu_cl_ttransaccion
go
if exists (select * from sysobjects where name = 'tgd_cl_default')
    drop trigger tgd_cl_default
go
if exists (select * from sysobjects where name = 'tgi_cl_default')
    drop trigger tgi_cl_default
go
if exists (select * from sysobjects where name = 'tgu_cl_default')
    drop trigger tgu_cl_default
go
if exists (select * from sysobjects where name = 'tgd_cl_errores')
    drop trigger tgd_cl_errores
go
if exists (select * from sysobjects where name = 'tgi_cl_errores')
    drop trigger tgi_cl_errores
go
if exists (select * from sysobjects where name = 'tgu_cl_errores')
    drop trigger tgu_cl_errores
go


SET NOCOUNT OFF
GO



