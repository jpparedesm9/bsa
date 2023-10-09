
use cobis
go

declare 
@w_nombre varchar(255),
@w_ente   int

declare @w_operaciones table(
operacion int)

select 
@w_nombre = 'MA. LUISA SECUNDINO HIDALGO ',
@w_ente   = 21581

update cl_ente set
en_nomlar = @w_nombre,
en_nombre = 'MA. LUISA',
p_p_apellido = 'SECUNDINO',
p_s_apellido = 'HIDALGO'
where en_ente = @w_ente

insert into @w_operaciones
select tg_operacion 
from cob_credito..cr_tramite_grupal
where tg_cliente     = @w_ente

insert into @w_operaciones
select op_operacion
from cob_cartera..ca_operacion
where op_toperacion = 'REVOLVENTE'
and op_cliente      = @w_ente

update cob_cartera..ca_operacion set
op_nombre            = @w_nombre
where op_operacion in (select operacion 
from @w_operaciones)


update cob_cartera..ca_operacion_his set
oph_nombre        = @w_nombre
where oph_operacion in (select operacion 
from @w_operaciones)

go
