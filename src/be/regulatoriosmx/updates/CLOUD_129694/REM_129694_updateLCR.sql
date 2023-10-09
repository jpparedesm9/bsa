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
/*   Redemediaciones para todo los LCR  para el tipo amortizacion        */
/*   y la tasa 															 */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/* 01/Noviembre/2019         JCH               emision inicial           */
/* 07/noviembre/2019         JCH  optimizacion de caso 122487 a 129694   */
/*************************************************************************/
USE 
cob_conta_super
GO

UPDATE cob_conta_super..sb_dato_operacion SET
do_tasa             	= do_tasa_com,
do_tipo_amortizacion 	= 'ROTATIVA'
WHERE do_tipo_operacion = 'REVOLVENTE'

-----------------------------------
--creacion indece 
-----------------------------------	
IF EXISTS (SELECT 1 FROM sysindexes WHERE name = 'idx01' AND id=OBJECT_ID('sb_datos_lcr'))
begin
    DROP INDEX sb_datos_lcr.idx01
end 
CREATE CLUSTERED INDEX  idx01
    ON dbo.sb_datos_lcr (dl_fecha,dl_banco)
GO



