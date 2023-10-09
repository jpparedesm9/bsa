---------------
--CASO 109721
---------------
use cobis
go

UPDATE cobis..cl_direccion
SET di_calle = replace(replace(replace(di_calle,' ','<>'),'><',''),'<>',' ')

go

