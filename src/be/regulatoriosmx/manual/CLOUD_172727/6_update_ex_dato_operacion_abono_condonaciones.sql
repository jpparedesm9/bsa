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
/*   Actualizacion de campo de condonaciones                            */
/************************************************************************/
/*                          MODIFICACIONES                              */
/* FECHA           AUTOR       DESCRICIPCION                            */
/* 03/03/2022      DEBM        Caso #172727                             */
/************************************************************************/

USE [cob_cartera]
GO

create table #condonados(
cop_banco varchar(24) ,
ab_secuencial_ing int
)


CREATE CLUSTERED INDEX idx1
	ON #condonados (cop_banco, ab_secuencial_ing)
GO


INSERT INTO #condonados (
cop_banco,
ab_secuencial_ing
)

SELECT op_banco,
ab_secuencial_ing
FROM cob_conta_super..sb_dato_operacion,
cob_cartera..ca_operacion,
cob_cartera..ca_abono,
cob_cartera..ca_abono_det
where do_fecha = '02/28/2022'
and do_banco = op_banco
and ab_operacion = op_operacion
and ab_operacion = abd_operacion
and ab_secuencial_ing = abd_secuencial_ing
and abd_tipo = 'CON'
and ab_estado not in ( 'RV', 'E')
group by op_banco, ab_secuencial_ing

UPDATE cob_conta_super..sb_dato_operacion_abono
SET doa_condonaciones = 'S'
FROM #condonados
WHERE doa_fecha = '02/28/2022'
and doa_aplicativo = 7
and doa_banco = cop_banco
AND doa_sec_ing = ab_secuencial_ing

DROP TABLE #condonados
