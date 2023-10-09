use cob_cartera
go 

declare 
@w_ctr_id     int,
@w_co_id      varchar(4)

delete ca_corresponsal_tipo_ref where ctr_descripcion = 'GARANTIA LIQUIDA INDIVIDUAL'
select @w_ctr_id = max(ctr_id)+1 from ca_corresponsal_tipo_ref
select @w_co_id = co_id from ca_corresponsal where co_nombre = 'SANTANDER'

INSERT INTO ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES(@w_ctr_id, '11', 'GI', 'GARANTIA LIQUIDA INDIVIDUAL', @w_co_id, '9742')

select @w_ctr_id = max(ctr_id)+1 from ca_corresponsal_tipo_ref
select @w_co_id = co_id from ca_corresponsal where co_nombre = 'ELAVON'
INSERT INTO ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES(@w_ctr_id, '11', 'GI', 'GARANTIA LIQUIDA INDIVIDUAL', @w_co_id, NULL)

select @w_ctr_id = max(ctr_id)+1 from ca_corresponsal_tipo_ref
select @w_co_id = co_id from ca_corresponsal where co_nombre = 'OXXO'
INSERT INTO ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES(@w_ctr_id, '11', 'GI', 'GARANTIA LIQUIDA INDIVIDUAL', @w_co_id, NULL)

go
