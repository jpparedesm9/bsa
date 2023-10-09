USE cob_cartera
GO

set statistics time on;
set statistics io on;

/*set statistics time off;
set statistics io off;
*/

declare @w_operacionca int  = 100

DELETE ca_dividendo WHERE di_operacion = @w_operacionca
go

