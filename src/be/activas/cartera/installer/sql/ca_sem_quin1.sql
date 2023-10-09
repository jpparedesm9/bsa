
use cobis
go

print 'Eliminar informacion anterior: Parametros'

delete from cobis..cl_parametro
from   cobis..cl_parametro
where  pa_nemonico = 'QUIN'
and    pa_producto   = 'CCA'

delete from cobis..cl_parametro
from   cobis..cl_parametro
where  pa_nemonico = 'DQUIN'
and    pa_producto   = 'CCA'

GO


print 'Parametro: TIPO DE DIVIDENDO CREDITOS QUINCENALES'

insert into cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values
('TIPO DE DIVIDENDO CREDITOS QUINCENALES', 'QUIN', 'C', 'Q', 'CCA')


print 'Parametro: DIAS MINIMOS PARA DIVIDENDOS QUINCENALES'

insert into cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_smallint, pa_producto)
values
('DIAS MINIMOS PARA DIVIDENDOS QUINCENALES', 'DQUIN', 'S', 15, 'CCA')
GO



print 'Eliminar informacion anterior: Catalogos'

delete from cl_catalogo_pro
where cp_tabla in (select codigo from cobis..cl_tabla
                   where tabla in ('ca_toper_sem', 'ca_toper_quin'))
and cp_producto = 'CCA'

GO

delete from cl_catalogo
where tabla in (select codigo from cobis..cl_tabla
                where tabla in ('ca_toper_sem', 'ca_toper_quin'))
GO

delete from cl_tabla
where tabla in ('ca_toper_sem', 'ca_toper_quin')
GO

delete from cl_catalogo
where tabla = (select codigo from cobis..cl_tabla where tabla = 'ca_toperacion')
and codigo in ('CRESEMW', 'CRESEMQ') 

GO

--CREAR CATALOGO PARA OPERACIONES CON PERIODICIDAD SEMANAL
declare @w_codigo smallint
 
select @w_codigo = max(codigo) + 1 from cl_tabla
 
print 'Tabla de tipos de prestamos semanales'

insert into cl_tabla (codigo, tabla, descripcion) 
values (@w_codigo, 'ca_toper_sem', 'Tipos de operaciones con dividendos semanales')

insert into cl_catalogo_pro values ('CCA', @w_codigo)

insert into cl_catalogo (tabla, codigo, valor, estado) 
values (@w_codigo, 'CRESEMW', 'CREDITO SEMILLA SEMANAL', 'V')

select @w_codigo = @w_codigo + 1
 
update cl_seqnos
set siguiente = @w_codigo
where tabla = 'cl_tabla'

GO

--CREAR CATALOGO PARA OPERACIONES CON PERIODICIDAD QUINCENAL
declare @w_codigo smallint
 
select @w_codigo = max(codigo) + 1 from cl_tabla
 
print 'Tabla de tipos de prestamos quincenales'

insert into cl_tabla (codigo, tabla, descripcion) 
values (@w_codigo, 'ca_toper_quin', 'Tipos de operaciones con dividendos quincenales')

insert into cl_catalogo_pro values ('CCA', @w_codigo)

insert into cl_catalogo (tabla, codigo, valor, estado) 
values (@w_codigo, 'CRESEMQ', 'CREDITO SEMILLA QUINCENAL', 'V')

select @w_codigo = @w_codigo + 1
 
update cl_seqnos
set siguiente = @w_codigo
where tabla = 'cl_tabla'

GO

--INCLUIR OPERACIONES SEMANALES Y QUINCENALES EN CATALOGO DE TIPOS
declare @w_codigo smallint
 
select @w_codigo = codigo from cobis..cl_tabla where tabla = 'ca_toperacion'

insert into cobis..cl_catalogo
(tabla, codigo, valor, estado)
select @w_codigo, 'CRESEMW', 'CREDITO SEMILLA SEMANAL', 'V'


insert into cobis..cl_catalogo
(tabla, codigo, valor, estado)
select @w_codigo, 'CRESEMQ', 'CREDITO SEMILLA QUINCENAL', 'V'

GO