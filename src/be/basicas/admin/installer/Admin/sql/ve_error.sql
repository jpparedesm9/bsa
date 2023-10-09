use cobis
go

if exists (select * from cl_errores
	   where numero between 2874900 and 2874902)
delete cl_errores where numero between 2874900 and 2874902
go


insert into cl_errores VALUES (2874900,0,'NO CORRESPONDE TRANSACCION')
GO
insert into cl_errores VALUES (2874901,0,'NO EXISTE ARCHIVO CATALOGADO')
GO
insert into cl_errores VALUES (2874902,0,'NO CORRESPONDE A LA VERSION CATALOGADA')
go


