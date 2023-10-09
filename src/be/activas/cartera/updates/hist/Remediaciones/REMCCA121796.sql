use cobis
go
   
   delete from cobis..cl_errores where numero in (724641)
   insert into cobis..cl_errores (numero, severidad, mensaje) values (724641, 0, 'NO SE PERMITEN CONSULTAS MENOS A LA FECHA DE ACTUAL')