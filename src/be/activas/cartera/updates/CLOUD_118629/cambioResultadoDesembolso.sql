
use cob_cartera
go

if not exists ( select  1 from    syscolumns where id = OBJECT_ID('ca_santander_resultado_desembolso')
                and name = 'rd_estado_mail' ) 
   alter table ca_santander_resultado_desembolso add  rd_estado_mail varchar(1) null