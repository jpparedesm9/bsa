/************************************************************************/
/*   Archivo:                 sp_lcr_cancelacion_ba.sp					*/
/*   Stored procedure:        sp_lcr_cancel_ba							*/
/*   Base de Datos:           cob_cartera                               */
/*   Producto:                Cartera                                   */
/*   Disenado por:                                                      */
/*   Fecha de Documentacion:  Agosto 30 de 2017                         */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancario s propiedad de     */
/*   'COBISCorp'.                                                       */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Permitir la cancelación anticipada automatica por inactividad de 	*/
/*	 una Linea de Credito.												*/
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha      Nombre          Proposito                               */
/*   30/08/2019 Ariana Larios   Emision Inicial                         */
/************************************************************************/


use cob_cartera 
go

if not object_id('sp_lcr_cancelacion_ba') is null
   drop proc sp_lcr_cancelacion_ba
go

create proc sp_lcr_cancelacion_ba
@i_param1				datetime    = null -- fecha
as
declare 
@w_return				int,
@w_sp_name				varchar(32),
@w_banco				varchar(30),
@w_dias_cancelar_lcr	varchar(10),
@w_count				int

select @w_sp_name	=	'sp_lcr_cancelacion_ba'

select @w_dias_cancelar_lcr	=	pa_int
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'DIASCA'


select 
op_banco,	op_operacion,	op_fecha_ult_mov
into #cancelacion_lcr
from ca_operacion
where DATEDIFF(day,isnull(op_fecha_ult_mov,op_fecha_ini),@i_param1)>@w_dias_cancelar_lcr 
and op_toperacion='REVOLVENTE'
and op_fecha_fin>@i_param1


select @w_count	=	count(*) from #cancelacion_lcr

WHILE @w_count > 0
BEGIN
	(SELECT TOP(1) @w_banco = op_banco FROM #cancelacion_lcr);
	
	execute @w_return = cob_cartera..sp_lcr_cancelacion_ant
	@s_user		=	'usrbatch',
	@s_term		=	'batch',
	@s_date 	=	@i_param1,
	@i_banco	=	@w_banco
	
	if @w_return <> 0 
	begin
		exec sp_errorlog
		@i_fecha     = @i_param1,
		@i_error     = @w_return,
		@i_usuario   = 'usrbatch',
		@i_tran      = 7091,
		@i_tran_name = @w_sp_name,
		@i_cuenta    = @w_banco,
		--@i_anexo     = 'CANCELACION ANTICIPADA POR INACTIVIDAD',
		@i_rollback  = 'N'
    end 
	
	delete from #cancelacion_lcr 
	where  op_banco =	@w_banco 
	
	select @w_count	=	count(*) 
	from #cancelacion_lcr
END

DROP TABLE #cancelacion_lcr

return 0