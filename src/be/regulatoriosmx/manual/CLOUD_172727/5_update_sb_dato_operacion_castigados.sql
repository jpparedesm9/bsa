/************************************************************************/
/*   Archivo:              altert                                       */
/*   Stored procedure:                                                  */
/*   Base de datos:        cob_conta_super                              */
/*   Producto:             Regulatorios                                 */
/*   Disenado por:         Daniel Esteban Berrio                        */
/*   Fecha de escritura:   Marzo 2022                                   */
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
/*   Actualizacion de fecha de castigo para operaciones castigadas      */
/************************************************************************/
/*                          MODIFICACIONES                              */
/* FECHA           AUTOR       DESCRICIPCION                            */
/* 03/03/2022      DEBM        Caso #172727                             */
/************************************************************************/

USE [cob_conta_super]
GO

update cob_conta_super..sb_dato_operacion set
do_fecha_castigo = tr_fecha_ref
from cob_cartera..ca_transaccion with (nolock)
where tr_operacion = do_operacion
and   tr_tran      = 'ETM'
and   tr_estado   <> 'RV'
and   do_estado_cartera   = 4


update cob_conta_super..sb_dato_operacion set
do_fecha_castigo = tr_fecha_mov
from cob_cartera..ca_transaccion_bancamia with (nolock)
where tr_banco     = do_banco
and   tr_tran      = 'ETM'
and   tr_estado   <> 'RV'
and   do_estado_cartera   = 4

