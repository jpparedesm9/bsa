use cob_bvirtual
go

delete from cob_bvirtual..bv_login
where lo_ente not in (select en_ente from cob_bvirtual..bv_ente)

update cob_bvirtual..bv_login 
set lo_estado = 'E'
where lo_ente in (117,121)
and lo_login = '5576070575'
go

delete from cobis..cl_errores  where numero in ( 1890015, 1890016)
insert into cobis..cl_errores values (1890015, 0, 'El login ya se encuentra asignado a otro cliente del banco')
go
insert into cobis..cl_errores values (1890016, 0, 'El teléfono ingresado no es válido ')
go