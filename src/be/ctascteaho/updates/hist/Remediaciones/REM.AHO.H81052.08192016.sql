/*************************************************/
-- No Bug: Historia AHO-H81052
-- Título de la Historia: Refactorizacion de proceso de verificacion de clientes con malas referencias
-- Fecha: 17/08/2016
-- Descripción del la Historia:  Como usuario del modulo de Ahorros, se requiere de la refactorizacion 
--                               del sp_ente_bloqueado, para que via un parametros, permita o no continuar 
--                               con la validacion del cliente en las estrucuturas de listas inhibitorias. 
-- Descripción de la Solución: Se crea el parametro VAREIN y catalogo CL_RIESGO
-- Autor: Walther Toledo
/*************************************************/

use cobis
go

declare @w_sgte int

select @w_sgte = siguiente 
 from cobis..cl_seqnos 
where tabla = 'cl_tabla' 
  and bdatos = 'cobis'
-- mis_catlgo.sql
delete from cl_tabla where tabla = 'cl_riesgo'
insert into cl_tabla (codigo, tabla, descripcion)
values (@w_sgte, 'cl_riesgo', 'Nivel de riesgo del cliente')

insert into cl_catalogo_pro values ('AHO', @w_sgte)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_sgte, 'A', 'ALTO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_sgte, 'M', 'MEDIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_sgte, 'B', 'BAJO', 'V')

update cobis..cl_seqnos 
   set siguiente = siguiente +  1 
 where tabla = 'cl_tabla' 
   and bdatos = 'cobis'


-------------------------------------------------------------------------------
-- mis_param.sql
delete from cl_parametro where pa_nemonico = 'VAREIN' and pa_producto = 'MIS'
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char,  pa_producto)
values ('REF. INH. - VALIDACION DEL CLIENTE', 'VAREIN', 'C', 'S',  'MIS')
go

----------------------------------------------------------------------

--Para dejar consistente la data y realizar las pruebas. No se encuentra en ningun script de instalacion
UPDATE cobis..cl_refinh SET in_ced_ruc='1036603717',in_codigo=1001,in_origen='003' WHERE in_codigo = 25751596 --59054
UPDATE cobis..cl_refinh SET in_ced_ruc='79324186',in_codigo=59054,in_origen='003' WHERE in_codigo = 25751589 --59054
