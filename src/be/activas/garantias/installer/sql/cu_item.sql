use cob_custodia
go


delete from cob_custodia..cu_item

insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('DPF', 1, 'N�mero DPF', 'N�mero del plazo fijo', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('AHORRO', 1, 'N�mero', 'N�mero de Cuenta de Ahorro', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('PAGARE', 1, 'N�mero', 'N�mero Pagar�', 'N', 'S', NULL)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('PAGARE', 2, 'Valor', 'Valor', 'N', 'S', NULL)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VEHICULO', 1, 'Modelo', 'Modelo Veh�culo', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VEHICULO', 2, 'Marca', 'Marca Veh�culo', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VEHICULO', 3, 'A�o', 'A�o Veh�culo', 'N', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VEHICULO', 4, 'Placa', 'Placa Veh�culo', 'A', 'N', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVOTRAS', 1, 'Metros construcci�n', 'Metros construcci�n', 'N', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVOTRAS', 2, 'Metros terreno', 'Metros de terreno', 'N', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVOTRAS', 3, 'A�o de construcci�n', 'A�os de construcci�n', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVOTRAS', 4, 'Ubicaci�n', 'Ubicaci�n', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVOTRAS', 5, 'Linderos', 'Linderos', 'A', 'N', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVSOCIAL', 1, 'Metros de construcci�n', 'Metros de construcci�n', 'N', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVSOCIAL', 2, 'Metros de terreno', 'Metros de terreno', 'N', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVSOCIAL', 3, 'A�o de construcci�n', 'A�o de construcci�n', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVSOCIAL', 4, 'Ubicaci�n', 'Ubicaci�n', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVSOCIAL', 5, 'Linderos', 'Linderos', 'A', 'N', null)
go

