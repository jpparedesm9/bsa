/************************************************************************/
/*   Archivo:              altert                                       */
/*   Stored procedure:                                                  */
/*   Base de datos:        cob_externos                                 */
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
/*   Ajustar las tablas para el correcto reporte de condonaciones       */
/************************************************************************/
/*                          MODIFICACIONES                              */
/* FECHA           AUTOR       DESCRICIPCION                            */
/* 13/12/2021      JEOM        Caso #172727                             */
/************************************************************************/

USE [cob_externos]
GO

if not exists(select 1
              from sysobjects,
                   syscolumns
             where sysobjects.id   = syscolumns.id
               and syscolumns.name = 'doa_condonaciones')
BEGIN
    ALTER TABLE cob_externos..ex_dato_operacion_abono
    ADD doa_condonaciones VARCHAR(1);
END

USE [cob_conta_super]
GO

if not exists(select 1
              from sysobjects,
                   syscolumns
             where sysobjects.id   = syscolumns.id
               and syscolumns.name = 'doa_condonaciones')
BEGIN
    ALTER TABLE cob_conta_super..sb_dato_operacion_abono
    ADD doa_condonaciones VARCHAR(1);
END

