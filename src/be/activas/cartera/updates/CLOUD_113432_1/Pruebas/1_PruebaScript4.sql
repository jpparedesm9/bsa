use cob_cartera
go

SELECT getdate()

set statistics time on;
set statistics io on;

exec sp_creditos_grupales_vencidos
SELECT getdate()

go

/*set statistics time off;
set statistics io off;
*/