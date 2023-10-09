use cobis
go

delete cl_errores
  where numero between 3107565 and 3107576
go

--Agregados por Sergio Hidalgo (28/02/2013) para Proyecto ICR
insert into cobis..cl_errores values (3107565,1,'NO ESTA ASOCIADA LA VARIABLE AL PROCESO')
insert into cobis..cl_errores values (3107566,1,'NO SE PUEDE CONVERTIR EL VALOR AL FORMATO INDICADO')
insert into cobis..cl_errores values (3107567,1,'NO EXISTE LA REGLA')
insert into cobis..cl_errores values (3107568,1,'LA REGLA NO ESTA EN PRODUCCION')
insert into cobis..cl_errores values (3107569,1,'NO EXISTE RESULTADO PARA LA REGLA INDICADA')
insert into cobis..cl_errores values (3107570,1,'EXISTE MAS DE UNA REGLA PARA LA FECHA INDICADA')
--Agregados por Byron Ron (19/09/2013) para Proyecto ICR
insert into cobis..cl_errores values (3107571,1,'NO EXISTE VERSION DE LA REGLA PARA LA FECHA REQUERIDA')
insert into cobis..cl_errores values (3107572,1,'VARIABLES RECIBIDAS NO COINCIDEN CON EL NUMERO DE VARIABLES DE LA REGLA')
insert into cobis..cl_errores values (3107573,1,'NO EXISTE LA VARIABLE REQUERIDA')
insert into cobis..cl_errores values (3107574,1,'NO EXISTE SP ASOCIADO A LA ACTIVIDAD REQUERIDA')
--Agregado por Sergio Hidalgo (16/05/2014) para Proyecto ICR
insert into cobis..cl_errores values (3107575,1,'EL USUARIO NO PUEDE INICIAR ESTE PROCESO, PORQUE NO ES UN USUARIO DE WORKFLOW')
insert into cobis..cl_errores values (3107576,1,'EL PROGRAMA ASOCIADO A LA TAREA AUTOMATICA NO EXISTE')
go

delete cobis..cl_tabla where tabla = 'bpl_bpm' 
go

delete cobis..cl_catalogo where codigo = 'WF'
go

declare @w_sig int
select @w_sig = max(codigo) + 1
from cobis..cl_tabla
 
insert into cobis..cl_tabla values (@w_sig, 'bpl_bpm','Types of BPM')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)  values(@w_sig,'WF','COBIS WORKFLOW','V') 
go
