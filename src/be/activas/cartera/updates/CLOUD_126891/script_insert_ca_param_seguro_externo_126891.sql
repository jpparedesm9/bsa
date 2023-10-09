use cob_cartera
go

delete from ca_param_seguro_externo

insert into ca_param_seguro_externo (se_id, se_paquete , se_descripcion  , se_formato_consen, se_valor, se_edad_max, se_estado)
                             values (1    , 'BASICO'   , 'Seguro de vida', 'Seguro de vida' , 48      , 80         , 'V')


insert into ca_param_seguro_externo (se_id, se_paquete , se_descripcion                   , se_formato_consen      , se_valor, se_edad_max, se_estado)
                             values (2    , 'EXTENDIDO', 'Seguro de Vida y Complementario', 'Seguro Complementario', 228     , 80         , 'V')


insert into ca_param_seguro_externo (se_id, se_paquete , se_descripcion , se_formato_consen , se_valor, se_edad_max, se_estado)
                             values (3    , 'NINGUNO'  , 'Sin Seguro'   , 'Ninguno'         , 0       , 99         , 'V')


select * from ca_param_seguro_externo

go

