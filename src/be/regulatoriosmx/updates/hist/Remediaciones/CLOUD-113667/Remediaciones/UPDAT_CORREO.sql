use cob_credito 
go 



--13173 ANASTACIA CRUZ SOTELO, El correo es anacruz4523@gmail.com
--19045 TERESA PEREZ GUIJOSA , El correo es teresa196105@gmail.com

update  cob_credito..cr_ns_creacion_lcr set 
nc_correo = 'anacruz4523@gmail.com',
nc_estado = 'P'
where nc_cliente = 13173 
go

update  cob_credito..cr_ns_creacion_lcr set 
nc_correo = 'teresa196105@gmail.com',
nc_estado = 'P'
where nc_cliente = 19045
go 
