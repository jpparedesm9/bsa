
use cobis
go


truncate table cobis..cl_parroquia 

truncate table cobis..cl_ciudad  



insert into cobis..cl_parroquia
select *
from borrar_cl_parroquia_106577


insert into cobis..cl_ciudad 
select * 
from borrar_cl_ciudad_106577