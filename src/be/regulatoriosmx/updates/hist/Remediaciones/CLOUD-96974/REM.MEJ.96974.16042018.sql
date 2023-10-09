/*************************************************************************************/
--No Historia                : MEJ-96974
--Titulo de la Historia      : CORREGIR DATA INCONSISTENTE GRUPO 15
--Fecha                      : 16/04/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : CORREGIR DATA INCONSISTENTE GRUPO 15
--Autor                      : Jorge Salazar Andrade
--Instalador                 : N/A
--Ruta Instalador            : N/A
/*************************************************************************************/
print'Estructuras Respaldo Informacion'
select * into cob_cartera..ca_det_ciclo_96974
from cob_cartera..ca_det_ciclo
where 1 = 2

select * into cobis..cl_cliente_grupo_96974
from  cobis..cl_cliente_grupo
where 1 = 2

select * into cob_credito..cr_tramite_grupal_96974
from  cob_credito..cr_tramite_grupal
where 1 = 2

/*************************************************************************************/
--No Historia                : MEJ-96974
--Titulo de la Historia      : CORREGIR DATA INCONSISTENTE GRUPO 15
--Fecha                      : 16/04/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : CORREGIR DATA INCONSISTENTE GRUPO 15
--Autor                      : Jorge Salazar Andrade
--Instalador                 : N/A
--Ruta Instalador            : N/A
/*************************************************************************************/
declare @w_grupo     int,
        @w_banco     varchar(24),
        @w_operacion int,
        @w_cliente   int

select @w_grupo = 15

select distinct @w_banco = dc_referencia_grupal
from cob_cartera..ca_det_ciclo
where dc_grupo = @w_grupo

select @w_operacion = op_operacion
from cob_cartera..ca_operacion
where op_banco = @w_banco

select cliente = dc_cliente
into #cliente_det_ciclo
from cob_cartera..ca_det_ciclo
where dc_grupo     = @w_grupo
and   dc_operacion = @w_operacion


select 'Grupo'                    = cast(@w_grupo as varchar),
       'Referencia Grupal'        = @w_banco,
       'Cliente Operacion Grupal' = cast(@w_cliente as varchar)

print'Informacion Actual Grupo ' + cast(@w_grupo as varchar)
select *
from cob_cartera..ca_det_ciclo
where dc_grupo = @w_grupo

select *
from cobis..cl_cliente_grupo
where cg_grupo = @w_grupo

select *
from cob_credito..cr_tramite_grupal
where tg_grupo = @w_grupo

print'Respaldo Informacion Grupo ' + cast(@w_grupo as varchar)
insert into cob_cartera..ca_det_ciclo_96974
select * from cob_cartera..ca_det_ciclo
where dc_grupo     = @w_grupo
and   dc_operacion = @w_operacion

insert into cobis..cl_cliente_grupo_96974
select * from  cobis..cl_cliente_grupo
where cg_grupo = @w_grupo
and   cg_ente  in (select cliente from #cliente_det_ciclo)

insert into cob_credito..cr_tramite_grupal_96974
select * from  cob_credito..cr_tramite_grupal
where tg_grupo     = @w_grupo
and   tg_operacion = @w_operacion

print'Actualizacion Informacion Grupo ' + cast(@w_grupo as varchar)
delete cob_cartera..ca_det_ciclo
where dc_grupo     = @w_grupo
and   dc_operacion = @w_operacion

delete cobis..cl_cliente_grupo
where cg_grupo = @w_grupo
and   cg_ente  in (select cliente from #cliente_det_ciclo)

delete cob_credito..cr_tramite_grupal
where tg_grupo     = @w_grupo
and   tg_operacion = @w_operacion

print'Informacion Actualizada Grupo ' + cast(@w_grupo as varchar)
select *
from cob_cartera..ca_det_ciclo
where dc_grupo = @w_grupo

select *
from cobis..cl_cliente_grupo
where cg_grupo = @w_grupo

select *
from cob_credito..cr_tramite_grupal
where tg_grupo = @w_grupo

drop table #cliente_det_ciclo
go

/*************************************************************************************/
--No Historia                : MEJ-96974
--Titulo de la Historia      : CORREGIR DATA INCONSISTENTE GRUPO 153
--Fecha                      : 16/04/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : CORREGIR DATA INCONSISTENTE GRUPO 153
--Autor                      : Jorge Salazar Andrade
--Instalador                 : N/A
--Ruta Instalador            : N/A
/*************************************************************************************/
declare @w_grupo     int,
        @w_banco     varchar(24),
        @w_operacion int,
        @w_cliente   int

select @w_grupo = 153

select distinct @w_banco = dc_referencia_grupal
from cob_cartera..ca_det_ciclo
where dc_grupo = @w_grupo

select @w_operacion = op_operacion
from cob_cartera..ca_operacion
where op_banco = @w_banco

select cliente = dc_cliente
into #cliente_det_ciclo
from cob_cartera..ca_det_ciclo
where dc_grupo     = @w_grupo
and   dc_operacion = @w_operacion


select 'Grupo'                    = cast(@w_grupo as varchar),
       'Referencia Grupal'        = @w_banco,
       'Cliente Operacion Grupal' = cast(@w_cliente as varchar)

print'Informacion Actual Grupo ' + cast(@w_grupo as varchar)
select *
from cob_cartera..ca_det_ciclo
where dc_grupo = @w_grupo

select *
from cobis..cl_cliente_grupo
where cg_grupo = @w_grupo

select *
from cob_credito..cr_tramite_grupal
where tg_grupo = @w_grupo

print'Respaldo Informacion Grupo ' + cast(@w_grupo as varchar)
insert into cob_cartera..ca_det_ciclo_96974
select * from cob_cartera..ca_det_ciclo
where dc_grupo     = @w_grupo
and   dc_operacion = @w_operacion

insert into cobis..cl_cliente_grupo_96974
select * from  cobis..cl_cliente_grupo
where cg_grupo = @w_grupo
and   cg_ente  in (select cliente from #cliente_det_ciclo)

insert into cob_credito..cr_tramite_grupal_96974
select * from  cob_credito..cr_tramite_grupal
where tg_grupo     = @w_grupo
and   tg_operacion = @w_operacion

print'Actualizacion Informacion Grupo ' + cast(@w_grupo as varchar)
delete cob_cartera..ca_det_ciclo
where dc_grupo     = @w_grupo
and   dc_operacion = @w_operacion

delete cobis..cl_cliente_grupo
where cg_grupo = @w_grupo
and   cg_ente  in (select cliente from #cliente_det_ciclo)

delete cob_credito..cr_tramite_grupal
where tg_grupo     = @w_grupo
and   tg_operacion = @w_operacion

print'Informacion Actualizada Grupo ' + cast(@w_grupo as varchar)
select *
from cob_cartera..ca_det_ciclo
where dc_grupo = @w_grupo

select *
from cobis..cl_cliente_grupo
where cg_grupo = @w_grupo

select *
from cob_credito..cr_tramite_grupal
where tg_grupo = @w_grupo

drop table #cliente_det_ciclo
go

/*************************************************************************************/
--No Historia                : MEJ-96974
--Titulo de la Historia      : CORREGIR DATA INCONSISTENTE GRUPO 3
--Fecha                      : 16/04/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : CORREGIR DATA INCONSISTENTE GRUPO 3
--Autor                      : Jorge Salazar Andrade
--Instalador                 : N/A
--Ruta Instalador            : N/A
/*************************************************************************************/
declare @w_grupo     int,
        @w_banco     varchar(24),
        @w_operacion int,
        @w_cliente   int

select @w_grupo = 3

select distinct @w_banco = dc_referencia_grupal
from cob_cartera..ca_det_ciclo
where dc_grupo = @w_grupo

select @w_operacion = op_operacion
from cob_cartera..ca_operacion
where op_banco = @w_banco

select cliente = dc_cliente
into #cliente_det_ciclo
from cob_cartera..ca_det_ciclo
where dc_grupo     = @w_grupo
and   dc_operacion = @w_operacion


select 'Grupo'                    = cast(@w_grupo as varchar),
       'Referencia Grupal'        = @w_banco,
       'Cliente Operacion Grupal' = cast(@w_cliente as varchar)

print'Informacion Actual Grupo ' + cast(@w_grupo as varchar)
select *
from cob_cartera..ca_det_ciclo
where dc_grupo = @w_grupo

select *
from cobis..cl_cliente_grupo
where cg_grupo = @w_grupo

select *
from cob_credito..cr_tramite_grupal
where tg_grupo = @w_grupo

print'Respaldo Informacion Grupo ' + cast(@w_grupo as varchar)
insert into cob_cartera..ca_det_ciclo_96974
select * from cob_cartera..ca_det_ciclo
where dc_grupo     = @w_grupo
and   dc_operacion = @w_operacion

insert into cobis..cl_cliente_grupo_96974
select * from  cobis..cl_cliente_grupo
where cg_grupo = @w_grupo
and   cg_ente  in (select cliente from #cliente_det_ciclo)

insert into cob_credito..cr_tramite_grupal_96974
select * from  cob_credito..cr_tramite_grupal
where tg_grupo     = @w_grupo
and   tg_operacion = @w_operacion

print'Actualizacion Informacion Grupo ' + cast(@w_grupo as varchar)
delete cob_cartera..ca_det_ciclo
where dc_grupo     = @w_grupo
and   dc_operacion = @w_operacion

delete cobis..cl_cliente_grupo
where cg_grupo = @w_grupo
and   cg_ente  in (select cliente from #cliente_det_ciclo)

delete cob_credito..cr_tramite_grupal
where tg_grupo     = @w_grupo
and   tg_operacion = @w_operacion

print'Informacion Actualizada Grupo ' + cast(@w_grupo as varchar)
select *
from cob_cartera..ca_det_ciclo
where dc_grupo = @w_grupo

select *
from cobis..cl_cliente_grupo
where cg_grupo = @w_grupo

select *
from cob_credito..cr_tramite_grupal
where tg_grupo = @w_grupo

drop table #cliente_det_ciclo
go

