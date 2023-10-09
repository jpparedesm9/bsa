/******************************************************/
--Fecha Creación del Script: 2016/Jul/27              
--Actualizacion Error                                 
--Modulo :MIS CTA_AHO                                 
use cobis
go

update cobis..cl_ente set p_fecha_nac = '01/08/2010'
where en_ente in (select top 10 en_ente from cobis..cl_ente 
                    where en_ente not in (select cl_cliente from cobis..cl_cliente))
go

delete cl_catalogo_pro
  from cl_tabla
 where tabla = 'pe_categoria'
go 
 
delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla = 'pe_categoria'
   and cl_tabla.codigo = cl_catalogo.tabla
go
   
 delete cl_tabla
 where cl_tabla.tabla  = 'pe_categoria'                          
   go

declare @w_codigo smallint

select @w_codigo = max(codigo) + 1
from cl_tabla
print 'Categoria de Cuenta'
insert into cl_tabla values (@w_codigo, 'pe_categoria', 'Categoria de Cuenta')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C', 'TIPO CUATRO','E')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'D', 'LIBRE DESTINO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'E', 'EDUCACION','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'H', 'HOGAR','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'I', 'VIAJES','E')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'M', 'MICROEMPRESA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'N', 'NORMAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'O', 'OTROS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'P', 'PLAN FINALIZADO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'S', 'SALUD','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'T', 'TIPO TRES','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'U', 'TIPO UNO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'V', 'VIVIENDA','V')

update cobis..cl_seqnos set siguiente = @w_codigo where tabla = 'cl_tabla'