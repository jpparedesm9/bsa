use cobis
go

declare 
@w_id int

if not exists (select * from an_page where pa_name = 'AS.ADM.RED.FNodosClass1')
begin
	select @w_id = max (pa_id)+1 from an_page 
	insert into an_page values (@w_id,25,'AS.ADM.RED.FNodosClass1', 'icono pagina',9,2,'horizontal', 'Nemonic','M-ADM.RED','Operacion=1',null,0)
	insert into an_role_page values (@w_id,1)
	insert into an_role_page values (@w_id,3)
end
else
	print 'Ya existe'

if not exists (select * from an_page where pa_name = 'AS.ADM.RED.FNodosClass2')
begin	
	select @w_id = max (pa_id)+1 from an_page 
	insert into an_page values (@w_id,25,'AS.ADM.RED.FNodosClass2', 'icono pagina',9,2,'horizontal', 'Nemonic','M-ADM.RED','Operacion=4',null,0)
	insert into an_role_page values (@w_id,1)
	insert into an_role_page values (@w_id,3)
end
else
	print 'Ya existe'
go