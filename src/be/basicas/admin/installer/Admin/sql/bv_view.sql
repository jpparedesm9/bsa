/******************************************************************************/
/* Archivo:            REQ_0004b_bv_view.sql                                  */
/* Producto:           VIRTUAL BANKING                                        */
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
/* 07-Mar-2012  4.0.0.0  PCL     Internacionalizacion (CIB4.1.0.5)            */
/* 19-Mar-2012  4.0.0.1  PCL     Actualizacion                                */
/* 21-Mar-2012  4.0.0.2  FJI     Actualizacion                                */
/* 22-Mar-2012  4.0.0.3  DRO     Actualizacion                                */
/* 26-Mar-2012  4.0.0.4  DME     Actualizacion                                */
/* 26-Abr-2012  4.0.0.5  GQU     Vistas ah_causa_nc_i18n, ah_causa_nd_i18n    */
/* 08-May-2012  4.0.0.6  PCL     Eliminacion de i18n comun                    */
/*                               Modificacion vistas                          */
/* 15-Nov-2012  4.0.0.7  GQU     Creacion vista cl_pais_i18n                  */
/* 14-Dic-2012  4.0.0.8  EOR     Creacion vista ca_estado_i18n                */
/* 12-Abr-2016  4.0.0.9  BBO     Migracion SYBASE-SQLServer FAL               */
/******************************************************************************/

use cobis
GO

SET NOCOUNT ON
GO

/****************************************************************************/
/*  Tabla bv_oper_simulador_prestamo                                        */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA bv_oper_simu_prestamo_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'bv_oper_simu_prestamo_i18n')
DROP VIEW bv_oper_simu_prestamo_i18n
GO

PRINT 'CREACION DE VISTA bv_oper_simu_prestamo_i18n'
go
CREATE VIEW bv_oper_simu_prestamo_i18n
AS
    SELECT pc_id, pc_tipo, pc_identificador, pc_codigo, re_cultura, re_valor
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
        ON pc_id = re_pc_id
    WHERE pc_tipo = 'T'
    AND pc_identificador = 'c-cob_bvirtual-bv_oper_simulador_prestamo'
GO
/****************************************************************************/
/*  Catalogo  bv_moneda                                                     */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA bv_moneda_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'bv_moneda_i18n')
DROP VIEW bv_moneda_i18n
GO

PRINT 'CREACION DE VISTA bv_moneda_i18n'
GO
CREATE VIEW bv_moneda_i18n
AS
    SELECT pc_codigo, re_cultura, re_valor
    FROM ad_catalogo_i18n
    WHERE pc_identificador = 'bv_moneda'
GO

/****************************************************************************/
/*  Tabla  cl_producto                                                      */
/****************************************************************************/

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

/****************************************************************************/
/*  Tabla  pf_ppago                                                         */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA pf_ppago_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'pf_ppago_i18n')
DROP VIEW pf_ppago_i18n
GO

PRINT 'CREACION DE VISTA pf_ppago_i18n'
go
CREATE VIEW pf_ppago_i18n
AS
    SELECT pc_id, pc_tipo, pc_identificador, pc_codigo, re_cultura, re_valor
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
        ON pc_id = re_pc_id
    WHERE pc_tipo = 'T'
    AND pc_identificador = 'c-cob_pfijo-pf_ppago'

GO

/****************************************************************************/
/*  Tabla  bv_oper_simulador_ahorro                                         */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA bv_oper_simulador_ahorro_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'bv_oper_simulador_ahorro_i18n')
DROP VIEW bv_oper_simulador_ahorro_i18n
GO

PRINT 'CREACION DE VISTA bv_oper_simulador_ahorro_i18n'
go
CREATE VIEW bv_oper_simulador_ahorro_i18n
AS
    SELECT pc_id, pc_tipo, pc_identificador, pc_codigo_int, re_cultura, re_valor
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
        ON pc_id = re_pc_id
    WHERE pc_tipo = 'T'
    AND pc_identificador = 'c-cobis-bv_oper_simulador_ahorro'

GO


/****************************************************************************/
/*  Catalogo  cc_estado_cta                                                 */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA cc_estado_cta_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'cc_estado_cta_i18n')
DROP VIEW cc_estado_cta_i18n
GO

PRINT 'CREACION DE VISTA cc_estado_cta_i18n'
GO
CREATE VIEW cc_estado_cta_i18n
AS
    SELECT pc_codigo, re_cultura, re_valor
    FROM ad_catalogo_i18n
    WHERE pc_identificador = 'cc_estado_cta'
GO


/****************************************************************************/
/*  Tabla  cc_tchequera                                                     */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA cc_tchequera_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'cc_tchequera_i18n')
DROP VIEW cc_tchequera_i18n
GO

PRINT 'CREACION DE VISTA cc_tchequera_i18n'
go
CREATE VIEW cc_tchequera_i18n
AS
    SELECT pc_id, pc_tipo, pc_identificador, pc_codigo, re_cultura, re_valor
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
        ON pc_id = re_pc_id
    WHERE pc_tipo = 'T'
    AND pc_identificador = 'c-cob_cuentas-cc_tchequera'

GO

/****************************************************************************/
/*  Catalogo  cc_causa_nc                                                   */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA cc_causa_nc_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'cc_causa_nc_i18n')
DROP VIEW cc_causa_nc_i18n
GO

PRINT 'CREACION DE VISTA cc_causa_nc_i18n'
GO
CREATE VIEW cc_causa_nc_i18n
AS
    SELECT pc_codigo, re_cultura, re_valor
    FROM ad_catalogo_i18n
    WHERE pc_identificador = 'cc_causa_nc'
GO

/****************************************************************************/
/*  Catalogo  cc_causa_nd                                                   */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA cc_causa_nd_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'cc_causa_nd_i18n')
DROP VIEW cc_causa_nd_i18n
GO

PRINT 'CREACION DE VISTA cc_causa_nd_i18n'
GO
CREATE VIEW cc_causa_nd_i18n
AS
    SELECT pc_codigo, re_cultura, re_valor
    FROM ad_catalogo_i18n
    WHERE pc_identificador = 'cc_causa_nd'
GO

/****************************************************************************/
/*  Catalogo  cl_oficina                                                    */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA cl_oficina_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'cl_oficina_i18n')
DROP VIEW cl_oficina_i18n
GO

PRINT 'CREACION DE VISTA cl_oficina_i18n'
GO
CREATE VIEW cl_oficina_i18n
AS
    SELECT pc_codigo, re_cultura, re_valor
    FROM ad_catalogo_i18n
    WHERE pc_identificador = 'cl_oficina'
GO

/****************************************************************************/
/*  Catalogo  ca_toperacion                                                 */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA ca_toperacion_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'ca_toperacion_i18n')
DROP VIEW ca_toperacion_i18n
GO

PRINT 'CREACION DE VISTA ca_toperacion_i18n'
GO
CREATE VIEW ca_toperacion_i18n
AS
    SELECT pc_codigo, re_cultura, re_valor
    FROM ad_catalogo_i18n
    WHERE pc_identificador = 'ca_toperacion'
GO

/****************************************************************************/
/*  Catalogo  bv_estado_pago                                                */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA bv_estado_pago_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'bv_estado_pago_i18n')
DROP VIEW bv_estado_pago_i18n
GO

PRINT 'CREACION DE VISTA bv_estado_pago_i18n'
GO
CREATE VIEW bv_estado_pago_i18n
AS
    SELECT pc_codigo, re_cultura, re_valor
    FROM ad_catalogo_i18n
    WHERE pc_identificador = 'bv_estado_pago'
GO

/****************************************************************************/
/*  Catalogo  ah_causa_nc                                                   */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA ah_causa_nc_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'ah_causa_nc_i18n')
DROP VIEW ah_causa_nc_i18n
GO

PRINT 'CREACION DE VISTA ah_causa_nc_i18n'
GO
CREATE VIEW ah_causa_nc_i18n
AS
    SELECT pc_codigo, re_cultura, re_valor
    FROM ad_catalogo_i18n
    WHERE pc_identificador = 'ah_causa_nc'
GO

/****************************************************************************/
/*  Catalogo  ah_causa_nd                                                   */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA ah_causa_nd_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'ah_causa_nd_i18n')
DROP VIEW ah_causa_nd_i18n
GO

PRINT 'CREACION DE VISTA ah_causa_nd_i18n'
GO
CREATE VIEW ah_causa_nd_i18n
AS
    SELECT pc_codigo, re_cultura, re_valor
    FROM ad_catalogo_i18n
    WHERE pc_identificador = 'ah_causa_nd'
GO

/****************************************************************************/
/*  Catalogo  cl_pais                                                       */
/****************************************************************************/
PRINT 'ELIMINACION DE VISTA cl_pais_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'cl_pais_i18n')
DROP VIEW cl_pais_i18n
GO

PRINT 'CREACION DE VISTA cl_pais_i18n'
go
CREATE VIEW cl_pais_i18n
AS
    SELECT pc_codigo_int, re_cultura, re_valor
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
        ON pc_id = re_pc_id
    WHERE pc_tipo = 'T'
    AND pc_identificador = 'cl_pais'
GO


/****************************************************************************/
/*  Catalogo  ca_estado                                                     */
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
    select
        pc_codigo_int,
		pc_identificador,
        re_cultura,
        re_valor
    from
      ad_pseudo_catalogo,
      ad_recurso
    where
      pc_identificador = 'ca_estado'
      and pc_tipo = 'T'
      and pc_id = re_pc_id
GO

SET NOCOUNT OFF
GO
