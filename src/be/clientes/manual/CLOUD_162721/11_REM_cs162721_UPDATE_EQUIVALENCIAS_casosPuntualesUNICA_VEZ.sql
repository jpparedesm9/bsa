
use cobis 
GO

declare @w_codigo_parroquia INT

---------------inicio 1------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0097' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
AND eq_valor_cat       = '148736'
  
insert into cobis..cl_parroquia (
            pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Santa Catarina', 'U'    , 12, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
           eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0072'   , 'Santa Catarina', 'V') 

UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '22789'      
AND cp_estado      = 2
AND cp_colonia_h  = '0072'
---------------fin 1------------
      

---------------inicio 2------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0104' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
AND eq_valor_cat       = '148737'
  
insert into cobis..cl_parroquia (
            pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Santa Juquila', 'U'    , 12, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
           eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0065'   , 'Santa Juquila', 'V') 

UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '22796'      
AND cp_estado      = 2
AND cp_colonia_h  = '0065'
---------------fin 2------------


---------------inicio 3------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0102' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
AND eq_valor_cat       = '148997'
  
insert into cobis..cl_parroquia (
            pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Los Pirules', 'U'    , 12, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
           eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0086'   , 'Los Pirules', 'V') 

UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '22770'      
AND cp_estado      = 2
AND cp_colonia_h  = '0086'
---------------fin 3------------
      

---------------inicio 4------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
from cobis..cl_parroquia
  
insert into cobis..cl_parroquia (
            pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Pocitos (Valle de la Trinidad)', 'U'    , 12, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
           eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0101'   , 'Pocitos (Valle de la Trinidad)', 'V') 

UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '22797'      
AND cp_estado      = 2
AND cp_colonia_h  = '0101'
---------------fin 4------------
      

---------------inicio 5------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
from cobis..cl_parroquia
  
insert into cobis..cl_parroquia (
            pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'El Morro', 'U'    , 12, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
           eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0113'   , 'El Morro', 'V') 

UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '22906'      
AND cp_estado      = 2
AND cp_colonia_h  = '0113'
---------------fin 5------------


---------------inicio 6------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0453' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
AND eq_valor_cat       = '148690'
  
insert into cobis..cl_parroquia (
            pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'San José del Alamito', 'U'    , 62, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
           eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0444'   , 'San José del Alamito', 'V') 

UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '25329'      
AND cp_estado      = 5
AND cp_colonia_h  = '0444'
---------------fin 6------------
      

---------------inicio 7------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
from cobis..cl_parroquia
  
insert into cobis..cl_parroquia (
            pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Llanos de la Unión', 'U'    , 62, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
           eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0451'   , 'Llanos de la Unión', 'V') 

UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '25317'      
AND cp_estado      = 5
AND cp_colonia_h  = '0451'
---------------fin 7------------
      

---------------inicio 8------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0015' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
AND eq_valor_cat       = '148297'
  
insert into cobis..cl_parroquia (
            pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Nueva Jerusalén', 'U'    , 34, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
           eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0012'   , 'Nueva Jerusalén', 'V') 

UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '26237'      
AND cp_estado      = 5
AND cp_colonia_h  = '0012'
---------------fin 8------------
      

---------------inicio 9------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
from cobis..cl_parroquia
  
insert into cobis..cl_parroquia (
            pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Tres Marías', 'U'    , 217, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
           eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0091'   , 'Tres Marías', 'V') 

UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '31065'      
AND cp_estado      = 8
AND cp_colonia_h  = '0091'
---------------fin 9------------
      

---------------inicio 10------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
from cobis..cl_parroquia
  
insert into cobis..cl_parroquia (
            pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'El Fresno', 'U'    , 217, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
           eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0092'   , 'El Fresno', 'V') 

UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '31625'      
AND cp_estado      = 8
AND cp_colonia_h  = '0092'
---------------fin 10------------



--CASO 11------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'San Ramiro', 'U'    , 288, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0075'   , 'San Ramiro', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '35105'   
  AND cp_estado	  = 10
  AND cp_colonia_h  = '0075'

--CASO 12------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0086' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
  AND eq_valor_cat 	  = '148712'  --dependiendo si no corresponde

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Torremolinos Cerrada Sevilla', 'U'    , 288, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0045'   , 'Torremolinos Cerrada Sevilla', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '35073'   
  AND cp_estado	  = 10
  AND cp_colonia_h  = '0045'


--CASO 13------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Campestre Santuario de Santa Rita', 'U'    , 351, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0050'   , 'Campestre Santuario de Santa Rita
', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '36468'   
  AND cp_estado	  = 11
  AND cp_colonia_h  = '0050'


--CASO 14------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0085' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
  AND eq_valor_cat 	  = '149343'  --dependiendo si no corresponde

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Segunda de Estrada (San Pablo)', 'U'    , 327, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0069'   , 'Segunda de Estrada (San Pablo)', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '38115'   
  AND cp_estado	  = 11
  AND cp_colonia_h  = '0069'



--CASO 15------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0085' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
  AND eq_valor_cat 	  = '148601'  --dependiendo si no corresponde

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Palma Diamante', 'U'    , 367, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0009'   , 'Palma Diamante', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '39890'   
  AND cp_estado	  = 12
  AND cp_colonia_h  = '0009'


--CASO 16------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Las Chanecas', 'U'    , 367, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0082'   , 'Las Chanecas', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '39931'   
  AND cp_estado	  = 12
  AND cp_colonia_h  = '0082'


--CASO 17------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0083' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
  AND eq_valor_cat 	  = '148742'  --dependiendo si no corresponde

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Residencial La Isla', 'U'    , 367, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0049'   , 'Residencial La Isla', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '39897'   
  AND cp_estado	  = 12
  AND cp_colonia_h  = '0049'



--CASO 18------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Finca Real', 'U'    , 710, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0006'   , 'Finca Real', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '52148'   
  AND cp_estado	  = 15
  AND cp_colonia_h  = '0006'
  
 
--CASO 19------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Santa Julia', 'U'    , 965, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0094'   , 'Santa Julia', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '66012'   
  AND cp_estado	  = 19
  AND cp_colonia_h  = '0094'
  
  
--CASO 20------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0085' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
  AND eq_valor_cat 	  = '149179'  --dependiendo si no corresponde

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Montebello Huinal', 'U'    , 953, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0079'   , 'Montebello Huinal', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '66646'   
  AND cp_estado	  = 19
  AND cp_colonia_h  = '0079'

--CASO 21------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0011' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
  AND eq_valor_cat 	  = '149394'  --dependiendo si no corresponde

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Barranca', 'U'    , 1846, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0006'   , 'Barranca', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '79565'    
  AND cp_estado	  = 24
  AND cp_colonia_h  = '0006'
  


--CASO 22------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'La Ordeña', 'U'    , 1846, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0016'   , 'La Ordeña', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '79570'    
  AND cp_estado	  = 24
  AND cp_colonia_h  = '0016'
  



--CASO 23------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0010' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
  AND eq_valor_cat 	  = '149615'  --dependiendo si no corresponde

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'La Cruz de Cantera', 'U'    , 1857, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0006'   , 'La Cruz de Cantera', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '79595'    
  AND cp_estado	  = 24
  AND cp_colonia_h  = '0006'
  


--CASO 24------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia


insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'El Camarón', 'U'    , 1857, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0009'   , 'El Camarón', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '79597'    
  AND cp_estado	  = 24
  AND cp_colonia_h  = '0009'
  

--CASO 25------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0025' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
  AND eq_valor_cat 	  = '149236'  --dependiendo si no corresponde

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'El Sótano', 'U'    , 1850, 'DM'   , 'V')

insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0004'   , 'El Sótano', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '79717'    
  AND cp_estado	  = 24
  AND cp_colonia_h  = '0004'
  


--CASO 26------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'San Andrés de los Limones', 'U'    , 1850, 'DM'   , 'V')



insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0023'   , 'San Andrés de los Limones', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '79708'    
  AND cp_estado	  = 24
  AND cp_colonia_h  = '0023'

--CASO 27------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0013' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
  AND eq_valor_cat 	  = '149330'  --dependiendo si no corresponde

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Gardenias', 'U'    , 1850, 'DM'   , 'V')



insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0005'   , 'Gardenias', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '79717'    
  AND cp_estado	  = 24
  AND cp_colonia_h  = '0005'
  

--CASO 28------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'La Esperanza', 'U'    , 1850, 'DM'   , 'V')



insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0038'   , 'La Esperanza', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '79734'    
  AND cp_estado	  = 24
  AND cp_colonia_h  = '0038'



--CASO 29------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Tres Pozos', 'U'    , 1868, 'DM'   , 'V')



insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0029'   , 'Tres Pozos', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '79923'    
  AND cp_estado	  = 24
  AND cp_colonia_h  = '0029'



--CASO 30------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Doctor Salvador Nava Mart¡nez (Nuevo Santa Rita)', 'U'    , 1852, 'DM'   , 'V')



insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0026'   , 'Doctor Salvador Nava Mart¡nez (Nuevo Santa Rita)', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '79942'      
  AND cp_estado	  = 24
  AND cp_colonia_h  = '0026'


--CASO 31------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia


insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'La Mata', 'U'    , 1852, 'DM'   , 'V')
--   values (@w_codigo_parroquia, @w_nombre_colonia, 'U'    , @w_codigo_municipio, 'DM'   , 'V')


insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0010'   , 'La Mata', 'V')
--   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), @w_colonia   , @w_nombre_colonia, 'V')

UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '79942'      
  AND cp_estado	  = 24
  AND cp_colonia_h  = '0010'

--CASO 32------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0007' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
  AND eq_valor_cat 	  = '149282'  --dependiendo si no corresponde

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Nexcuayo II', 'U'    , 1871, 'DM'   , 'V')



insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0005'   , 'Nexcuayo II', 'V')


UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '79974'      
  AND cp_estado	  = 24
  AND cp_colonia_h  = '0005'



--CASO 33------------------------------------------------------------------------------

select @w_codigo_parroquia = max(pq_parroquia) + 1
    from cobis..cl_parroquia

UPDATE cob_conta_super..sb_equivalencias SET eq_valor_arch ='0014' 
WHERE eq_catalogo   = 'ENT_PARROQ'      
  AND eq_valor_cat 	  = '149609'

insert into cobis..cl_parroquia (
			pq_parroquia       , pq_descripcion   , pq_tipo, pq_ciudad          , pq_zona, pq_estado)
   values (@w_codigo_parroquia, 'Rancho del Cristo', 'U'    , 2163, 'DM'   , 'V')


insert into cob_conta_super..sb_equivalencias (
		   eq_catalogo , eq_valor_cat                            , eq_valor_arch, eq_descripcion   , eq_estado)
   values ('ENT_PARROQ', convert(varchar(10),@w_codigo_parroquia), '0011'   , 'Rancho del Cristo', 'V')

UPDATE cobis..cl_codigo_postal SET cp_colonia = @w_codigo_parroquia
WHERE cp_codigo   = '94430'      
  AND cp_estado	  = 30
  AND cp_colonia_h  = '0011'

--------------------------------------------------------------------------------

go