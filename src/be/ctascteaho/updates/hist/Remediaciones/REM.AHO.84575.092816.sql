/***********************************************************************************************************/
---No Bug  			        : 84575
---Título del Bug			: Errores en parametrización inicial person
---Fecha					: 28/Sep/2016 
--Descripción del Problema	: Falta agrega oficina 7020 en la tabla cl_default
--Descripción de la Solución: Se agrega oficina
--Autor						: Tania Baidal
/***********************************************************************************************************/


use cobis
go

declare @w_codigo integer,
        @w_server varchar(30)

select @w_server = pa_char
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'SRVR'

select @w_codigo = codigo from cobis..cl_tabla where tabla LIKE 'ah_capitalizacion'

delete from cobis..cl_default where tabla = @w_codigo and oficina = 1
INSERT INTO cobis..cl_default (tabla, oficina, codigo, valor, srv)
VALUES (@w_codigo, 1, 'M', 'MENSUAL', @w_server)

-- ---------------------------
select @w_codigo = codigo from cobis..cl_tabla where tabla LIKE 'cl_prefijo_telefono'

delete from cobis..cl_default where tabla = @w_codigo and oficina = 1
INSERT INTO cl_default (tabla, oficina, codigo, valor, srv)
VALUES (@w_codigo, 1, 'CC', 'OFICINA 1', @w_server)

-- ---------------------------
select @w_codigo = codigo from cobis..cl_tabla WHERE tabla='cl_oficina'

delete from cobis..cl_default where tabla = @w_codigo and oficina = 1
insert into cl_default (tabla, oficina, codigo, valor, srv)
values(@w_codigo,1,'1','CASA MATRIZ',@w_server)
insert into cl_default (tabla, oficina, codigo, valor, srv)
values(@w_codigo,1,'7020','MEJICANOS',@w_server)
-----------------------------------------------------------------------------------------------

go