use cobis  
go

declare @w_label_id int 

select @w_label_id= pa_la_id from an_page where pa_name = 'AS.Transacciones' and pa_prod_name = 'M-ADM.Prod'

if not exists (select * from an_label where la_prod_name = 'M-ADM.Prod' and la_label = 'Transacciones')
begin
	insert into an_label values (@w_label_id, 'ES_EC', 'Transacciones', 'M-ADM.Prod')
end
go
 