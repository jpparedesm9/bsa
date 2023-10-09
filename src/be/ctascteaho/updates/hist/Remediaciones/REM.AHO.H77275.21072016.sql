/***************************************************************************/
--No Historia				 : H77275
--Título de la Historia		 : Manejo de Cuenta de Menor de Edad
--Fecha					     : 07/21/2016
--Descripción del Problema	 : Se requiere nuevo parametro del valor UDIS
--Descripción de la Solución : Creacion de parametro del valor UDIS
--Autor						 : Jorge Salazar Andrade
/***************************************************************************/
use cobis
go

delete cobis..cl_parametro 
 where pa_nemonico = 'UDIS'
   and pa_producto = 'AHO'
go

insert into cobis..cl_parametro
(pa_parametro,
 pa_nemonico,
 pa_tipo,
 pa_float,
 pa_producto)
values
('VALOR CONVERSION UDIS',
 'UDIS',
 'F',
 1500,
 'AHO'
)
go

/***************************************************************************/
--No Historia				 : H77275
--Título de la Historia		 : Manejo de Cuenta de Menor de Edad
--Fecha					     : 08/02/2016
--Descripción del Problema	 : Inserción de rol de catalogo U: TUTOR
--Descripción de la Solución : Creacion de rol de catalogo U: TUTOR
--Autor						 : Jorge Salazar Andrade
/***************************************************************************/
use cobis
go

declare @w_codigo int

select @w_codigo = codigo from cl_tabla
 where tabla = 'cl_rol'
 
delete cl_catalogo
 where tabla  = @w_codigo
   and codigo = 'U'
   
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_codigo, 'U', 'TUTOR', 'V')
go

