use cobis
go
delete from cobis..cl_parametro
where pa_nemonico= 'EICRVI'
and pa_producto='CRE'
go

use cobis
go
if exists(select 1 from cobis..cl_errores
              where numero=103197
          )
              
 delete from cobis..cl_errores
 where numero= 103197            

go

use cobis
go
Update cobis..cl_errores
set mensaje='TIENE OperacióNES PENDIENTES'
where numero =149053
go