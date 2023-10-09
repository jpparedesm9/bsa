USE cobis 
GO

UPDATE cobis..cl_direccion SET di_descripcion='ejprado@santander.com.mx'
WHERE di_tipo = 'CE'
AND di_ente IN (34021,
34022,
36344,
36597,
14742,
15050,
14806,
12321,
12323,
12328,
12329,
12335,
11629,
12319,
12771,
4110,
7479
)
go


