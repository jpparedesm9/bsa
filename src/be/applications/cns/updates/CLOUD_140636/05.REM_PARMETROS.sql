use cobis
GO

delete from cobis..cl_parametro where pa_nemonico in ('TRESC')
INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto) 
VALUES('TOTAL DE REGISTROS PARA ENVIO DE SMS COBRANZAS','TRESC','T',null,30,null,null,null,null,null,'CCA')
GO


delete from cobis..cl_parametro where pa_nemonico in ('TRESR')
INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto) 
VALUES('TOTAL DE REGISTROS PARA ENVIO DE SMS RECORDATORIOS','TRESR','T',null,30,null,null,null,null,null,'CCA')
GO


delete from cobis..cl_parametro where pa_nemonico in ('TPERSC')
INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto) 
VALUES('TIEMPO PARA ELIMINAR REGISTROS DE SMS COBRANZAS','TPERSC','T',null,null,3,null,null,null,null,'CCA')
GO

delete from cobis..cl_parametro where pa_nemonico in ('TPERSR')
INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto) 
VALUES('TIEMPO PARA ELIMINAR REGISTROS DE SMS RECORDATORIOS','TPERSR','T',null,null,3,null,null,null,null,'CCA')
GO