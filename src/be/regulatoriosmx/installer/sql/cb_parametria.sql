use cob_conta
go

delete from cb_listado_reportes_reg
where lr_reporte in ('PROV', 'A0411', 'A0419', 'A0420', 'A0424', 'CE', 'BX','INTFBU', 'INTFFC',
                     'BUROM', 'BUROE', 'ESTCTA', 'ODS5IS', 'CIERRE')


--///////////////////////////////////////////
insert into cb_listado_reportes_reg (lr_reporte, lr_descripcion, lr_estado) 
values ('BUROM', 'Buro de Credito - Mensual', 'V')
insert into cb_listado_reportes_reg (lr_reporte, lr_descripcion, lr_estado) 
values ('BUROE', 'Buro de Credito - Actualizacion ', 'V')
insert into cb_listado_reportes_reg (lr_reporte, lr_descripcion, lr_estado) 
values ('ESTCTA', 'Estado de Cuenta Timbrado', 'V')
--///////////////////////////////////////////
insert into cb_listado_reportes_reg 
(lr_reporte, lr_descripcion, lr_estado) 
values 
('PROV', 'Provisiones', 'V')

insert into cb_listado_reportes_reg 
(lr_reporte, lr_descripcion, lr_estado, lr_depende_pro) 
values 
('A0411', 'Reporte Base para A-0411', 'V', 'S')

insert into cb_listado_reportes_reg 
(lr_reporte, lr_descripcion, lr_estado, lr_depende_pro) 
values 
('A0419', 'Reporte Base para A-0419', 'V', 'S')

insert into cb_listado_reportes_reg 
(lr_reporte, lr_descripcion, lr_estado) 
values 
('A0420', 'Reporte Base para A-0420', 'V')

insert into cb_listado_reportes_reg 
(lr_reporte, lr_descripcion, lr_estado) 
values 
('A0424', 'Reporte Base para A-0424', 'V')

insert into cb_listado_reportes_reg 
(lr_reporte, lr_descripcion, lr_estado) 
values 
('CE', 'Contabilidad Electrónica', 'V')

insert into cb_listado_reportes_reg 
(lr_reporte, lr_descripcion, lr_estado) 
values 
('BX', 'Banxico', 'N')

---interfaces ODS
insert into cb_listado_reportes_reg 
(lr_reporte, lr_descripcion, lr_estado, lr_depende_pro) 
values 
('ODS5IS', 'Archivo ODS-5 - Insolvencias', 'V', 'S')


insert into cb_listado_reportes_reg
(lr_reporte, lr_descripcion  , lr_estado, lr_depende_pro)
values
('CIERRE'   , 'Proceso de Cierre de Período Contable', 'V', 'N' )
go


use cobis
go

delete from cl_parametro
where pa_nemonico in ('PMSREP', 'PGPROV', 'CRFINP', 'MESFPE')
and pa_producto = 'CON'

insert into cl_parametro 
(pa_parametro, pa_nemonico, pa_tipo, pa_tinyint, pa_producto)
values 
('MAXIMO DE MESES PARA SOLICITAR REPORTES (PMSREP)', 'PMSREP', 'T', 3, 'CON')

insert into cl_parametro 
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values 
('NEMÓNICO DE REPORTE DE PROVISION', 'PGPROV', 'C', 'PROV', 'CON')

insert into cl_parametro 
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values 
('MES INGRESO COMPROBANTE FIN PERIODO CONTABLE', 'MESFPE', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'CON')

insert into cl_parametro 
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values
('CODIGO REP. FIN PERIODO', 'CRFINP'   , 'C'    , 'CIERRE', 'CON') 

go

delete from cobis..cl_parametro where pa_nemonico = 'CBMMC')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CODIGO BATCH MENSUAL MOV. CONT', 'CBMMC', 'I', NULL, NULL, NULL, 36429, NULL, NULL, NULL, 'CON')



