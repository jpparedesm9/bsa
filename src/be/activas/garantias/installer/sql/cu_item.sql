use cob_custodia
go


delete from cob_custodia..cu_item

insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('DPF', 1, 'Número DPF', 'Número del plazo fijo', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('AHORRO', 1, 'Número', 'Número de Cuenta de Ahorro', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('PAGARE', 1, 'Número', 'Número Pagaré', 'N', 'S', NULL)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('PAGARE', 2, 'Valor', 'Valor', 'N', 'S', NULL)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VEHICULO', 1, 'Modelo', 'Modelo Vehículo', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VEHICULO', 2, 'Marca', 'Marca Vehículo', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VEHICULO', 3, 'Año', 'Año Vehículo', 'N', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VEHICULO', 4, 'Placa', 'Placa Vehículo', 'A', 'N', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVOTRAS', 1, 'Metros construcción', 'Metros construcción', 'N', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVOTRAS', 2, 'Metros terreno', 'Metros de terreno', 'N', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVOTRAS', 3, 'Año de construcción', 'Años de construcción', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVOTRAS', 4, 'Ubicación', 'Ubicación', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVOTRAS', 5, 'Linderos', 'Linderos', 'A', 'N', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVSOCIAL', 1, 'Metros de construcción', 'Metros de construcción', 'N', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVSOCIAL', 2, 'Metros de terreno', 'Metros de terreno', 'N', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVSOCIAL', 3, 'Año de construcción', 'Año de construcción', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVSOCIAL', 4, 'Ubicación', 'Ubicación', 'A', 'S', null)
insert into cob_custodia..cu_item(it_tipo_custodia,it_item,it_nombre,it_detalle,it_tipo_dato,it_mandatorio,it_numero_fisico) values('VIVSOCIAL', 5, 'Linderos', 'Linderos', 'A', 'N', null)
go

