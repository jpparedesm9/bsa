use cobis
go

declare @w_label_id 	int,
		@w_page_id		int,
		@w_parent_page	int,
		@w_page_order	int

update an_page 
   set pa_visible = 0
 where pa_name in ('PagAdmin','AC.Atención al Cliente','PP.Parametrización de Productos','Simulador','PFI','PI.Contabilidad', 'PI.Procesos Internos',  'PI.Mantenimiento', 'PI.Ejecución', 'PI.Consultas-5',
                   'PI.CON.FCtaTercerosClass', 'PI.CON.FNitpadecClass', 'PI.CON.FCtrlcpdClass', 'PI.ConsultasExcel','PI.TablaTrib')

 
delete an_page where pa_prod_name = 'M-CCA'
delete an_label where la_prod_name = 'M-CCA'


--Label Operaciones

select @w_label_id = isnull(max(la_id),0) + 1 FROM an_label

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'EN_EC', 'Operations', 'M-CCA')

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'EN_US', 'Operations', 'M-CCA')

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'ES_EC', 'Operaciones', 'M-CCA')


--Label Administración

select @w_label_id = isnull(max(la_id),0) + 1 FROM an_label

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'EN_EC', 'Administración', 'M-CCA')

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'EN_US', 'Administration', 'M-CCA')

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'ES_EC', 'Administración', 'M-CCA')


--Labels Operaciones y Administración para submenús

select @w_label_id = isnull(max(la_id),0) + 1 FROM an_label

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'EN_EC', 'Accounting', 'M-CCA')

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'EN_US', 'Accounting', 'M-CCA')

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'ES_EC', 'Contabilidad', 'M-CCA')



select @w_label_id = isnull(max(la_id),0) + 1 FROM an_label

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'EN_EC', 'Savings', 'M-CCA')

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'EN_US', 'Savings', 'M-CCA')

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'ES_EC', 'Ahorros', 'M-CCA')



select @w_label_id = isnull(max(la_id),0) + 1 FROM an_label

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'ES_EC', 'Plazo Fijo', 'M-CCA')

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'EN_EC', 'Fixed Term', 'M-CCA')

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'EN_US', 'Fixed Term', 'M-CCA')


select @w_label_id = isnull(max(la_id),0) + 1 FROM an_label

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'EN_US', 'Visual Batch', 'M-CCA')

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'EN_EC', 'Visual Batch', 'M-CCA')

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'ES_EC', 'Visual Batch', 'M-CCA')



select @w_label_id = isnull(max(la_id),0) + 1 FROM an_label

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'ES_EC', 'Consultas', 'M-CCA')

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'EN_EC', 'Queries', 'M-CCA')

insert into an_label (la_id, la_cod, la_label, la_prod_name)
values (@w_label_id, 'EN_US', 'Queries', 'M-CCA')


------------------------------- ADMINISTRACIÓN ----------------------------

--Administración
select @w_parent_page = 0
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Administración' and la_prod_name = 'M-CCA'
select @w_page_order = max(pa_order) + 1 FROM an_page

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.Administration', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 1)

select @w_parent_page = @w_page_id 

--Administración: Administración del Sistema
update an_page 
   set pa_id_parent = @w_parent_page, 
	   pa_order 	= 1
 where pa_name 		=  'AS.Administración del Sistema'

--Administración: Contabilidad
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Contabilidad' and la_prod_name = 'M-CCA'
select @w_page_order = 1

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.ADM.Accounting', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 1)

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 1
 where pa_name 		=  'PI.Empresas'

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 2
 where pa_name 		=  'PI.PlanCuentas'

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 3
 where pa_name 		=  'PI.ConsolidaComp'

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 4
 where pa_name 		=  'PI.TablaTrib'

 update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 5
 where pa_name 		=  'PI.InterfazCont'

--Administración: Ahorros
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Ahorros' and la_prod_name = 'M-CCA'
select @w_page_order = 2

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.ADM.SavingAccounts', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 0)

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 1
 where pa_name 		=  'PP.Personalizacion   Productos'
 
 
update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 1
 where pa_name 		=  'PP.Administración'
 
--Administración: Depósitos a Plazo
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Plazo Fijo' and la_prod_name = 'M-CCA'
select @w_page_order = 3

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.ADM.TermDeposits', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 0)

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 1
 where pa_name 		=  'PFI.Administracion'
 
--Administración: Visual Batch
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Visual Batch' and la_prod_name = 'M-CCA'
select @w_page_order = 4

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.ADM.VisualBatch', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 1)

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 1
 where pa_name 		= 'PI.ADMVBA.FPathProcClass'

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 2
 where pa_name 		= 'PI.ADMVBA.FManteniClass'
 
update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 3
 where pa_name 		= 'PI.ADMVBA.FLotesClass'
						
update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 4
 where pa_name 		= 'PI.ADMVBA.FFCierreClass'

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 5
 where pa_name 		= 'PI.ADMVBA.FAutorizacionClass'
						
update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 6
 where pa_name 		='PI.ADMVBA.FAutBatchClass'  


------------------------------- OPERACIONES ----------------------------

--Creación de Menú y reasignación de páginas

--Operaciones
select @w_parent_page = 0
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Operaciones' and la_prod_name = 'M-CCA'
select @w_page_order = max(pa_order) + 1 FROM an_page

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.Operations', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 1)

--Operaciones: Contabilidad
select @w_parent_page = @w_page_id 
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Contabilidad' and la_prod_name = 'M-CCA'
select @w_page_order = 1

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.OP.Accounting', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 1)

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 1
 where pa_name 	= 'PI.Transaccion'
 

--Operaciones: Cuentas de Ahorro
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Ahorros' and la_prod_name = 'M-CCA'
select @w_page_order = 2

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.OP.SavingAccounts', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 0)

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order		= 1
 where pa_name 		= 'PI.Aho.Cuentas'
 
update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 		= 2
 where pa_name 		= 'PI.CTA.CobroValoresSus'
 

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 		= 3
 where pa_name 		= 'PI.CTA.Excepciones'
 
update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 4
 where pa_name 		=  'PI.CTA.Cheques'
 
 
 update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 5
 where pa_name 		= 'PI.Aho.Procesos'

--Operaciones: Depósitos a Plazo y submenús
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Plazo Fijo' and la_prod_name = 'M-CCA'
select @w_page_order = 3

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.OP.TermDeposits', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 0)

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 1
 where pa_name 		=  'PFI.Operacion'

--Operaciones: Visual Batch y submenús
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Visual Batch' and la_prod_name = 'M-CCA'
select @w_page_order = 4

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.OP.VisualBatch', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 1)

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 1
 where pa_name 		=  'PI.ADMVBA.FAprobacionParamClass'

 
 update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 2
 where pa_name 		= 'PI.ADMVBA.FEjecLotesClass'
 


 
-------------------------------CONSULTAS ---------------------------------
--Consulta y submenús
select @w_parent_page = 0
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Consultas' and la_prod_name = 'M-CCA'
select @w_page_order = 5

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.Queries', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 1)

--Consultas Contabilidad
select @w_parent_page = @w_page_id
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Contabilidad' and la_prod_name = 'M-CCA'
select @w_page_order = 1

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.QRY.AccountingQueries', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 1)

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 1
 where pa_name 		=  'PI.ConsultaLin'
 
update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 2
 where pa_name 		=  'PI.TablaTrib'
 
update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 3
 where pa_name 		=  'PI.ConsultasExcel'

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 4
 where pa_name 		=  'PI.ConsultaAux'
 
update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 5
 where pa_name 		=  'PI.Aho.Consultas'

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 6
 where pa_name 		=  'PI.Reporte'
 

--Consultas Cuentas de Ahorros
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Ahorros' and la_prod_name = 'M-CCA'
select @w_page_order = 2

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.QRY.SavingAccountQueries', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 0)

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 1
 where pa_name 		=  'PI.Aho.Consultas'

--Consultas Depósitos a Plazo
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Plazo Fijo' and la_prod_name = 'M-CCA'
select @w_page_order = 3

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.QRY.TermDepositsQueries', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 0)

update an_page
   set pa_id_parent = @w_page_id,
	   pa_order 	= 1
 where pa_name 		=  'PFI.Query'

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 2
 where pa_name 		=  'PFI.Reportes'

--Consultas Visual Batch
select @w_page_id = isnull(max(pa_id),0) + 1 FROM an_page
select @w_label_id = la_id from an_label where la_label = 'Visual Batch' and la_prod_name = 'M-CCA'
select @w_page_order = 4

insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible)
values (@w_page_id, @w_label_id, 'CCA.QRY.VisualBatchQueries', 'icono pagina', @w_parent_page, @w_page_order, 'horizontal', 'Nemonic', 'M-CCA', null, null, 1)

update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 1
 where pa_name 		= 'PI.ADMVBA.FConsTiemClass'

 update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 2
 where pa_name 		= 'PI.ADMVBA.FConsTiemExcClass'
 
update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 3
 where pa_name 		= 'PI.ADMVBA.FErroresClass'
 
update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 4
 where pa_name 		= 'PI.ADMVBA.FBuscaEstatusClass'
 
update an_page 
   set pa_id_parent = @w_page_id, 
	   pa_order 	= 5
 where pa_name 		= 'ADMVBA.FErrProcClass'
go






