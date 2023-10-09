/************************************************************************/
/*  Archivo:                sp_var_porc_atra_ind_int.sp                */
/*  Stored procedure:       sp_var_porc_atra_ind_int                    */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Patricio Samueza                            */
/*  Fecha de Documentacion: 31/Jul/2017                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Procedure tipo Variable, Retorna SI si es partner de la solicitud    */
/* de credito individual                                                */
/************************************************************************/
/*  FECHA       AUTOR                   RAZON                           */
/*14/11/2019   P. Ortiz         Corregir calculo de porcentaje de atraso*/
/* **********************************************************************/
USE cob_credito
GO
IF OBJECT_ID ('dbo.sp_var_porc_atra_ind_int') IS NOT NULL
	DROP PROCEDURE dbo.sp_var_porc_atra_ind_int
GO

CREATE PROC dbo.sp_var_porc_atra_ind_int(
    @i_ente         INT = null,    
    @o_resultado    VARCHAR(255) = NULL OUT
)
as
declare @w_sp_name          varchar(64),
        @w_error               int,
        @w_return              int,
        @w_resultado           float,
        @w_cod_est_canc        int,
        @w_est_cancelado       tinyint,
        @w_operacion           int,
        @w_plazo               smallint,
        @w_diferencia_dia      FLOAT ,
        @w_diferencia_dia_op   FLOAT 
        
select @w_sp_name = 'sp_var_porc_atra_ind_int'

exec @w_error = cob_cartera..sp_estados_cca
@o_est_cancelado = @w_est_cancelado out

select top 1 
   @w_operacion = op_operacion, 
   @w_plazo     = op_plazo
from     cob_cartera..ca_operacion, cob_credito..cr_tramite
where op_estado = @w_est_cancelado
and tr_cliente = op_cliente
and tr_tramite = op_tramite
and op_cliente = @i_ente
and tr_grupal is null
order by op_fecha_liq desc

select @w_diferencia_dia = isnull(sum(abs(datediff(dd, di_fecha_can,di_fecha_ven))),0)
from cob_cartera..ca_dividendo
where di_operacion = @w_operacion
and di_estado = @w_est_cancelado
and di_fecha_can > di_fecha_ven

select @w_diferencia_dia_op = sum(abs(di_dias_cuota))
from cob_cartera..ca_dividendo 
where di_operacion = @w_operacion

select @w_resultado = (@w_diferencia_dia / @w_diferencia_dia_op )*100 

print 'Dias atraso: ' + convert(varchar,@w_diferencia_dia) + ' Total dias: ' + convert(varchar,@w_diferencia_dia_op) 
      + ' Resultado: ' + convert(varchar,@w_resultado)

if @w_resultado is null
	select @w_resultado = 0  


select @o_resultado = convert(varchar, @w_resultado)


return 0
go