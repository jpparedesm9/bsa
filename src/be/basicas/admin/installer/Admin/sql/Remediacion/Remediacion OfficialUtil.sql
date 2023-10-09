use cobis
go

if exists (select * from an_module where mo_name = 'BVI.Official')
	update an_module
	set mo_name = 'ADM.Official'
	where mo_name = 'BVI.Official'
	
if exists (select * from an_label where la_label = 'BVI.Official')
	update an_label
	set la_label = 'ADM.Official', 
		la_prod_name = 'M-ADM.Util' 
	where la_label = 'BVI.Official'
	
go