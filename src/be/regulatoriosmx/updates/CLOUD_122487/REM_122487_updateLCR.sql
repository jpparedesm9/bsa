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
/*************************************************************************/
use 
cob_conta_super
go

update cob_conta_super..sb_dato_operacion set
do_tasa             	= do_tasa_com,
do_tipo_amortizacion 	= 'ROTATIVA'
where do_tipo_operacion = 'REVOLVENTE'














