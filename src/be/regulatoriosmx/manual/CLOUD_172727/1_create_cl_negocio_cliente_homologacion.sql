/************************************************************************/
/*   Archivo:              Create                                       */
/*   Stored procedure:                                                  */
/*   Base de datos:        cobis		                                */
/*   Producto:             Regulatorios                                 */
/*   Disenado por:         Juan Esteban Osorio                          */
/*   Fecha de escritura:   Enero 2022                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Cambio de actividad economica solo para el reporte de altas        */
/************************************************************************/
/*                          MODIFICACIONES                              */
/* FECHA           AUTOR       DESCRICIPCION                            */
/* 03/02/2022      JEOM        Caso #172727                             */
/************************************************************************/

USE [cobis]
GO

IF OBJECT_ID ('dbo.cl_negocio_cliente_homologacion') IS NOT NULL
	DROP TABLE dbo.cl_negocio_cliente_homologacion
GO

CREATE TABLE dbo.cl_negocio_cliente_homologacion
	(
	cobis               VARCHAR (12),
	actividad_economica VARCHAR (200),
	altas_banxico       VARCHAR (12)
	)
GO

CREATE CLUSTERED INDEX cl_neg_homo
	ON dbo.cl_negocio_cliente_homologacion (cobis, actividad_economica, altas_banxico)
GO
