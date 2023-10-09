/*************************************************************************/  
/*   Archivo:              banxico.sp			                         */
/*   Stored procedure:     sp_banxico                                    */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Fecha de escritura:   Noviembre 2019                                */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   Tabla fisica hacer rollback para almacenamiento de 				 */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/* 01/Noviembre/2019         JCH               emision inicial           */
/* 07/noviembre/2019         JCH  optimizacion de caso 122487 a 129694   */
/*************************************************************************/
use 
cob_conta_super
go

IF EXISTS (SELECT 1 FROM sysindexes WHERE name = 'index01' AND id=OBJECT_ID('sb_banxico_lcr'))
begin
    DROP INDEX sb_banxico_lcr.index01
end 


IF OBJECT_ID ('dbo.sb_banxico_lcr') IS NOT NULL
    DROP TABLE dbo.sb_banxico_lcr
GO
	
