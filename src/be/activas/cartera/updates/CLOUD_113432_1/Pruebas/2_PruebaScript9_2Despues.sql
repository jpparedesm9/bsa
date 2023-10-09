use cob_cartera
go

set statistics time on;
set statistics io on;

/*set statistics time off;
set statistics io off;
*/

declare @i_banco varchar(20) = '456'

select H.op_operacion, di_dividendo, 'desplazar' = di_dividendo -1, tg_grupal
     into #tmp1
     from cob_cartera..ca_dividendo, cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion H, cob_cartera..ca_operacion P
     where tg_referencia_grupal = @i_banco     --papa
	 and convert(int, tg_prestamo ) <> tg_operacion
	 and tg_monto > 0
	 and tg_participa_ciclo = 'S'
     and tg_referencia_grupal  = P.op_banco
     and di_operacion = P.op_operacion
     and tg_operacion = H.op_operacion
     and tg_grupal = 'N'
     and H.op_fecha_ini between di_fecha_ini and di_fecha_ven




