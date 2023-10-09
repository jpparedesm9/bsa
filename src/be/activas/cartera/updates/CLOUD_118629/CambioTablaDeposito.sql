
use cob_cartera
go

if not exists ( select  1 from    syscolumns where id = OBJECT_ID('ca_santander_orden_deposito_fallido')
                and name = 'odf_estado' ) 
   alter table ca_santander_orden_deposito_fallido add  odf_estado varchar(1) null
