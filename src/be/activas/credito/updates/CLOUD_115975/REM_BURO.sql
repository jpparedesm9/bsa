-----------------------------------------------------------------------------------
-- REMEDIACIONES BURO - 
-----------------------------------------------------------------------------------

use cobis
go
 
delete cobis..cl_errores where numero in (2108056)
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108056,0,'ERROR: NO EXISTE REGISTRO EN EL BURO PARA EL CLIENTE.')
go


use cob_credito
go

if not exists (SELECT 1 FROM sys.columns WHERE Name = 'tr_folio_buro'
               AND Object_ID = Object_ID('cob_credito..cr_tramite')) begin
   alter table cr_tramite
   add tr_folio_buro VARCHAR(64) null
end
go