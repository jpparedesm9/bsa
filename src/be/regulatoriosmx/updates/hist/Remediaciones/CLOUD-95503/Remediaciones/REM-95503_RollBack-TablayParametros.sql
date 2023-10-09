print 'Registro tabla negative file carga inicial'
use cob_credito
go
if exists(select 1 from sysobjects where name = 'cr_negative_file_carg_ini')
    drop table cr_negative_file_carg_ini
go

use cob_credito
go
if exists(select 1 from sysobjects where name = 'cr_negative_file')
    drop table cr_negative_file
go


use cobis
go

print 'Registro de Parametro PATH NEGATIVE FILE'
if exists (select 1 from cobis..cl_parametro where pa_nemonico = 'PHNFDE' and pa_producto = 'CRE')
begin
    delete from cobis..cl_parametro where pa_nemonico = 'PHNFDE' and pa_producto = 'CRE'	
end 
go
