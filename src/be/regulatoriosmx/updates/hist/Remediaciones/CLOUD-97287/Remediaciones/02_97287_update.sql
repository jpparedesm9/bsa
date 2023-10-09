-- Facturación en día inhábil
use cob_fpm
go


IF OBJECT_ID ('dbo.fp_generalparametershistory_97287') IS NULL
begin
    
    select * , fecha=convert(datetime,null)
    into cob_fpm..fp_generalparametershistory_97287 
    from cob_fpm..fp_generalparametershistory
    where 1 = 2     
end  
ELSE
    TRUNCATE TABLE cob_fpm..fp_generalparametershistory_97287 

go

USE cob_cartera
GO


IF OBJECT_ID ('dbo.ca_default_toperacion_97287') IS NULL
begin
    
    select * , fecha=convert(datetime,null)
    into cob_cartera..ca_default_toperacion_97287 
    from cob_cartera..ca_default_toperacion
    where 1 = 2     
end  
ELSE
    TRUNCATE TABLE cob_cartera..ca_default_toperacion_97287 

--///////////////////////////////////////////////////////////
DECLARE @w_field INT 
SELECT @w_field = dc_fields_id FROM cob_fpm..fp_dictionaryfields WHERE dc_description = 'Base de cálculo'


insert into cob_fpm..fp_generalparametershistory_97287
select *, getdate() 
from cob_fpm..fp_generalparametershistory 
WHERE gph_inheritedfrom = 'GRUPAL' AND dc_fields_idfk = @w_field 


UPDATE cob_fpm..fp_generalparametershistory
SET gph_description = 'Real', gph_value = 'R' WHERE dc_fields_idfk = @w_field AND gph_inheritedfrom = 'GRUPAL'

insert into ca_default_toperacion_97287
SELECT *, getdate()
FROM ca_default_toperacion

UPDATE cob_cartera..ca_default_toperacion 
set dt_base_calculo = 'R' WHERE dt_toperacion = 'GRUPAL'



--///////////////////////////////////////////////////////////////


DECLARE @w_field2 INT 
SELECT @w_field2 = dc_fields_id FROM cob_fpm..fp_dictionaryfields WHERE dc_description = 'Generar evitando feriados'


insert into cob_fpm..fp_generalparametershistory_97287
select *, getdate() 
from cob_fpm..fp_generalparametershistory 
WHERE gph_inheritedfrom = 'GRUPAL' AND dc_fields_idfk = @w_field2 


UPDATE cob_fpm..fp_generalparametershistory
SET gph_description = 'Si', gph_value = 'S' WHERE dc_fields_idfk = @w_field2 AND gph_inheritedfrom = 'GRUPAL'

insert into ca_default_toperacion_97287
SELECT *, getdate()
FROM ca_default_toperacion

UPDATE cob_cartera..ca_default_toperacion 
set dt_evitar_feriados = 'S' WHERE dt_toperacion = 'GRUPAL'


SELECT gph_description , gph_value , *
FROM cob_fpm..fp_generalparametershistory
WHERE dc_fields_idfk IN ( @w_field , @w_field2) AND gph_inheritedfrom = 'GRUPAL'
ORDER BY dc_fields_idfk
GO

SELECT dt_evitar_feriados, dt_base_calculo,* FROM cob_cartera..ca_default_toperacion
WHERE dt_toperacion = 'GRUPAL' 

GO

