use cob_pac
go

declare
	@pa_id int,
	@la_id int
	
/****************************************************/
/*                                                  */
/* Clientes					*/
/*                                                  */
/****************************************************/

/**************** Naturales *****************/
select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.NAT.CreaciónActualización'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(1, 0, @la_id, 2, 'Clientes', 'ACTIVE',1, 1, 'CUSTOMERSN')
insert into bpl_an_page_view values (1, 1, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.NAT.Creación Normal'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(2, 1, @la_id, 2, 'Clientes', 'ACTIVE',1, 1, 'CUSTOMERSN')
insert into bpl_an_page_view values (2, 2, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.NAT.Datos del cliente'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(3, 2, @la_id, 2, 'Clientes', 'ACTIVE',1, 0, 'CUSTOMERSN')
insert into bpl_an_page_view values (3, 3, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.NAT.Direcciones'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(4, 2, @la_id, 2, 'Clientes', 'ACTIVE',1, 0, 'CUSTOMERSN')
insert into bpl_an_page_view values (4, 4, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.NAT.Apartados'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(5, 2, @la_id, 2, 'Clientes', 'ACTIVE',1, 0, 'CUSTOMERSN')
insert into bpl_an_page_view values (5, 5, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.NAT.Bienes'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(6, 2, @la_id, 2, 'Clientes', 'ACTIVE',1, 0, 'CUSTOMERSN')
insert into bpl_an_page_view values (6, 6, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.NAT.Referencias Económicas'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(7, 2, @la_id, 2, 'Clientes', 'ACTIVE',1, 1, 'CUSTOMERSN')
insert into bpl_an_page_view values (7, 7, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.NAT.Bancaria'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(8, 7, @la_id, 2, 'Clientes', 'ACTIVE',1, 0, 'CUSTOMERSN')
insert into bpl_an_page_view values (8, 8, @pa_id)

--REVISADO: OK


/**************** Jurídicos *****************/ 
select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.JUR.CreacionActualizacion'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(9, 0, @la_id, 2, 'Clientes', 'ACTIVE',1, 1, 'CUSTOMERSL')
insert into bpl_an_page_view values (9, 9, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.JUR.Datos del cliente'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(10, 9, @la_id, 2, 'Clientes', 'ACTIVE',1, 0, 'CUSTOMERSL')
insert into bpl_an_page_view values (10, 10, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.JUR.Creacion.Direcciones'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(11, 9, @la_id, 2, 'Clientes', 'ACTIVE',1, 0, 'CUSTOMERSL')
insert into bpl_an_page_view values (11, 11, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.JUR.Apartados'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(12, 9, @la_id, 2, 'Clientes', 'ACTIVE',1, 0, 'CUSTOMERSL')
insert into bpl_an_page_view values (12, 12, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.JUR.Creacion.Bienes'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(13, 9, @la_id, 2, 'Clientes', 'ACTIVE',1, 0, 'CUSTOMERSL')
insert into bpl_an_page_view values (13, 13, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.JUR.Referencias Economicas'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(14, 9, @la_id, 2, 'Clientes', 'ACTIVE',1, 1, 'CUSTOMERSL')
insert into bpl_an_page_view values (14, 14, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUST.JUR.Creacion.Bancaria'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(15, 14, @la_id, 2, 'Clientes', 'ACTIVE',1, 0, 'CUSTOMERSL')
insert into bpl_an_page_view values (15, 15, @pa_id)

/****************************************************/
/*                                                  */
/* Firmas									        */
/*                                                  */
/****************************************************/
select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'Firmas'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(16, 0, @la_id, 5, 'Firmas', 'ACTIVE',2, 1, 'ADMFIR')
insert into bpl_an_page_view values (16, 16, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'ADMFIR.Management'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(17, 16, @la_id, 5, 'Firmas', 'ACTIVE',2, 1, 'ADMFIR')
insert into bpl_an_page_view values (17, 17, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'ADMFIR.Management.RelacionFirmaProdu'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(18, 17, @la_id, 5, 'Firmas', 'ACTIVE',2, 0, 'ADMFIR')
insert into bpl_an_page_view values (18, 18, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'ADMFIR.Query'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(19, 16, @la_id, 5, 'Firmas', 'ACTIVE',2, 1, 'ADMFIR')
insert into bpl_an_page_view values (19, 19, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'ADMFIR.Query.FirmasSellosCondiciones'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(20, 19, @la_id, 5, 'Firmas', 'ACTIVE',2, 0, 'ADMFIR')
insert into bpl_an_page_view values (20, 20, @pa_id)

-- REVISADO OK

/****************************************************/
/*                                                  */
/* Cuentas corrientes						        */
/*                                                  */
/****************************************************/
select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.C.  Corrientes'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(21, 0, @la_id, 3, 'C.  Corrientes', 'ACTIVE',1, 1, 'CTA')
insert into bpl_an_page_view values (21, 21, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.Ctes.Chequeras'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(22, 21, @la_id, 3, 'C.  Corrientes', 'ACTIVE',8, 1, 'CTA')
insert into bpl_an_page_view values (22, 22, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.FTran003Corriente'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(23, 22, @la_id, 3, 'C.  Corrientes', 'ACTIVE',5, 0, 'CTA')
insert into bpl_an_page_view values (23, 23, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.Ctes.Consultas'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(24, 21, @la_id, 3, 'C.  Corrientes', 'ACTIVE',8, 1, 'CTA')
insert into bpl_an_page_view values (24, 24, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.ChequesConsultas'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(25, 24, @la_id, 3, 'C.  Corrientes', 'ACTIVE',2, 1, 'CTA')
insert into bpl_an_page_view values (25, 25, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.FTran079'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(26, 24, @la_id, 3, 'C.  Corrientes', 'ACTIVE',4, 0, 'CTA')
insert into bpl_an_page_view values (26, 26, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.FTran038'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(27, 25, @la_id, 3, 'C.  Corrientes', 'ACTIVE',1, 0, 'CTA')
insert into bpl_an_page_view values (27, 27, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.FTran076'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(28, 24, @la_id, 3, 'C.  Corrientes', 'ACTIVE', 1, 0, 'CTA')
insert into bpl_an_page_view values (28, 28, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.FTran075'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(29, 24, @la_id, 3, 'C.  Corrientes', 'ACTIVE',16, 0, 'CTA')
insert into bpl_an_page_view values (29, 29, @pa_id)

/****************************************************/
/*                                                  */
/* Cuentas de ahorros						        */
/*                                                  */
/****************************************************/
select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.C. de  Ahorros'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(30, 0, @la_id, 4, 'C. de Ahorros', 'ACTIVE',2, 1, 'AHO')
insert into bpl_an_page_view values (30, 30, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.FTran280'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(31, 30, @la_id, 4, 'C. de Ahorros', 'ACTIVE',9, 0, 'AHO')
insert into bpl_an_page_view values (31, 31, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.Ahos.Consultas'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(32, 30, @la_id, 4, 'C. de Ahorros', 'ACTIVE',6, 1, 'AHO')
insert into bpl_an_page_view values (32, 32, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.FTran220'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(33, 32, @la_id, 4, 'C. de Ahorros', 'ACTIVE',8, 0, 'AHO')
insert into bpl_an_page_view values (33, 33, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.FTran232'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(34, 32, @la_id, 4, 'C. de Ahorros', 'ACTIVE',6, 0, 'AHO')
insert into bpl_an_page_view values (34, 34, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.FTran343'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(35, 32, @la_id, 4, 'C. de Ahorros', 'ACTIVE',6, 0, 'AHO')
insert into bpl_an_page_view values (35, 35, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CTA.FTran234'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(36, 32, @la_id, 4, 'C. de Ahorros', 'ACTIVE',10, 0, 'AHO')
insert into bpl_an_page_view values (36, 36, @pa_id)

/****************************************************/
/*                                                  */
/* Depósitos a plazo fijo					        */
/*                                                  */
/****************************************************/
select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'PFIOpe'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(37, 0, @la_id, 14, 'Depósitos a plazo fijo', 'ACTIVE',1, 1, 'PFI')
insert into bpl_an_page_view values (37, 37, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'PFIOpe.Deposito'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(38, 37, @la_id, 14, 'Depósitos a plazo fijo', 'ACTIVE',1, 1, 'PFI')
insert into bpl_an_page_view values (38, 38, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'PFIOpe.Deposito.FModificaAct'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(39, 38, @la_id, 14, 'Depósitos a plazo fijo', 'ACTIVE',8, 0, 'PFI')
insert into bpl_an_page_view values (39, 39, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'PFIOpe.Deposito.TranEsp'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(40, 38, @la_id, 14, 'Depósitos a plazo fijo', 'ACTIVE',3, 1, 'PFI')
insert into bpl_an_page_view values (40, 40, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'PFIOpe.Deposito.TranEsp.FIncre'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(41, 40, @la_id, 14, 'Depósitos a plazo fijo', 'ACTIVE',7, 0, 'PFI')
insert into bpl_an_page_view values (41, 41, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'PFIOpe.Deposito.FCancelacionNormal'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(42, 38, @la_id, 14, 'Depósitos a plazo fijo', 'ACTIVE',3, 0, 'PFI')
insert into bpl_an_page_view values (42, 42, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'PFIOpe.Deposito.FRenovaOp'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(43, 38, @la_id, 14, 'Depósitos a plazo fijo', 'ACTIVE',11, 0, 'PFI')
insert into bpl_an_page_view values (43, 43, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'PFIOpe.Consultas.FConsultaOp'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(44, 38, @la_id, 14, 'Depósitos a plazo fijo', 'ACTIVE',11, 0, 'PFI')
insert into bpl_an_page_view values (44, 44, @pa_id)

-- REVISADO OK
/****************************************************/
/*                                                  */
/* Cartera									        */
/*                                                  */
/****************************************************/
select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CCA.Consultas y Reportes'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(45, 0, @la_id, 7, 'CCA', 'ACTIVE',2, 1, 'CCA')
insert into bpl_an_page_view values (45, 45, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CCA.FBusDatPre'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(46, 45, @la_id, 7, 'CCA', 'ACTIVE',1, 0, 'CCA')
insert into bpl_an_page_view values (46, 46, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CCA.FBusProCuoPag'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(47, 45, @la_id, 7, 'CCA', 'ACTIVE',5, 0, 'CCA')
insert into bpl_an_page_view values (47, 47, @pa_id)


/****************************************************/
/*                                                  */
/* Garantías								        */
/*                                                  */
/****************************************************/
select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUS.CUS.Garantia'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(48, 0, @la_id, 19, 'CCA', 'ACTIVE',1, 1, 'CUS')
insert into bpl_an_page_view values (48, 48, @pa_id)

select @pa_id = pa_id, @la_id = pa_la_id from cobis..an_page where pa_name = 'CUS.FTransaccion'
print '@pa_id %1!', @pa_id
print '@la_id %1!', @la_id 
insert into bpl_view values(49, 48, @la_id, 19, 'CCA', 'ACTIVE',5, 0, 'CUS')
insert into bpl_an_page_view values (49, 49, @pa_id)

go
