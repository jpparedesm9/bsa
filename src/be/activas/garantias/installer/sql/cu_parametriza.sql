use cob_custodia
go


/* CREACION DE ESTADO DE GARANTIAS */

print '--> cu_estados_garantia'
truncate table cu_estados_garantia
go

insert into cu_estados_garantia values ('F','Vigente Futuros Creditos',0)
insert into cu_estados_garantia values ('V','Vigente con Obligacion',1)
insert into cu_estados_garantia values ('X','Vigente por Cancelar',2)
insert into cu_estados_garantia values ('C','CANCELADO',3)
insert into cu_estados_garantia values ('P','Propuesta',6)
insert into cu_estados_garantia values ('A','Anulado',7)
insert into cu_estados_garantia values ('K','Castigado',8)
go


/* CREACION DE CAMBIOS DE ESTADO DE GARANTIAS */

print '--> cu_cambios_estado'
truncate table cu_cambios_estado
go

insert into cu_cambios_estado (ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo)
values ('F', 'V', 'S', 'EST', 'A')
insert into cu_cambios_estado (ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo)
values ('V', 'F', 'S', 'EST', 'A')
insert into cu_cambios_estado (ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo)
values ('V', 'X', 'S', 'EST', 'A')
insert into cu_cambios_estado (ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo)
values ('X', 'V', 'S', 'EST', 'A')
insert into cu_cambios_estado (ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo)
values ('P', 'A', 'S', 'EST', 'A')
insert into cu_cambios_estado (ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo)
values ('F', 'A', 'S', 'EST', 'A')
insert into cu_cambios_estado (ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo)
values ('P', 'F', 'S', 'EST', 'M')
insert into cu_cambios_estado (ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo)
values ('F', 'X', 'S', 'EST', 'M')
insert into cu_cambios_estado (ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo)
values ('X', 'F', 'S', 'EST', 'M')
insert into cu_cambios_estado (ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo)
values ('X', 'V', 'S', 'EST', 'M')
insert into cu_cambios_estado (ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo)
values ('F', 'P', 'S', 'EST', 'M')
insert into cu_cambios_estado (ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo)
values ('V', 'C', 'N', 'EST', 'A')
insert into cu_cambios_estado (ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo)
values ('C', 'A', 'N', 'EST', 'A')
go


/* CREACION DE CODIGOS VALOR */

print '--> cu_codigo_valor'
truncate table cu_codigo_valor
go

insert into cu_codigo_valor values (11,'COLATERAL FINANCIERO ADMISIBLE - F','2000','F')
insert into cu_codigo_valor values (11,'FONDO AGROPECUARIO DE GARANTIAS - FAG - F','2100','F')
insert into cu_codigo_valor values (11,'FONDO NACIONAL DE GARANTIAS - FNG - F','2200','F')
insert into cu_codigo_valor values (11,'MAYOR A 25 SMLMV - F','2210','F')
insert into cu_codigo_valor values (11,'BOGOTA EMPRENDEDORA - F','2220','F')
insert into cu_codigo_valor values (11,'FORTALECIMIENTO SHD - F','2230','F')
insert into cu_codigo_valor values (11,'PRENDA SOBRE TITULOS VALORES EMIT - F','2300','F')
insert into cu_codigo_valor values (11,'DERECHOS DE COBRO - F','3000','F')
insert into cu_codigo_valor values (11,'BIENES RAICES Y RESIDENCIALES - F','4000','F')
insert into cu_codigo_valor values (11,'INMUEBLES URBANOS - F','4100','F')
insert into cu_codigo_valor values (11,'INMUEBLES RURALES - F','4200','F')
insert into cu_codigo_valor values (11,'FIDUCIAS HIPOTECARIAS - F','4300','F')
insert into cu_codigo_valor values (11,'BIENES DADOS EN LEASING INMOBILIARIO - F','5000','F')
insert into cu_codigo_valor values (11,'LEASING DE INMUEBLES - F','5100','F')
insert into cu_codigo_valor values (11,'LEASING HABITACIONAL - F','5200','F')
insert into cu_codigo_valor values (11,'BIENES DADOS EN LEASING DIFERENTE A INMOBILIARIO - F','6000','F')
insert into cu_codigo_valor values (11,'LEASING DE MAQUINARIA Y EQUIPO - F','6100','F')
insert into cu_codigo_valor values (11,'LEASING DE VEHICULOS - F','6200','F')
insert into cu_codigo_valor values (11,'LEASING MUEBLES Y ENSERES - F','6300','F')
insert into cu_codigo_valor values (11,'LEASING EQUIPOS DE COMPUTO - F','6400','F')
insert into cu_codigo_valor values (11,'LEASING SEMOVIENTES - F','6500','F')
insert into cu_codigo_valor values (11,'OTROS COLATERALES - F','7000','F')
insert into cu_codigo_valor values (11,'PRENDAS SIN TENENCIA - F','7100','F')
insert into cu_codigo_valor values (11,'VEHICULOS NUEVOS - F','7110','F')
insert into cu_codigo_valor values (11,'VEHICULOS USADOS - F','7120','F')
insert into cu_codigo_valor values (11,'MAQUINARIA Y EQUIPO - F','7130','F')
insert into cu_codigo_valor values (11,'PRENDA SOBRE INVENTARIOS PROCESADOS - F','7200','F')
insert into cu_codigo_valor values (12,'COLATERAL FINANCIERO ADMISIBLE  - X','2000','X')
insert into cu_codigo_valor values (12,'FONDO AGROPECUARIO DE GARANTIAS - FAG  - X','2100','X')
insert into cu_codigo_valor values (12,'FONDO NACIONAL DE GARANTIAS - FNG  - X','2200','X')
insert into cu_codigo_valor values (12,'MAYOR A 25 SMLMV  - X','2210','X')
insert into cu_codigo_valor values (12,'BOGOTA EMPRENDEDORA  - X','2220','X')
insert into cu_codigo_valor values (12,'FORTALECIMIENTO SHD  - X','2230','X')
insert into cu_codigo_valor values (12,'PRENDA SOBRE TITULOS VALORES EMIT  - X','2300','X')
insert into cu_codigo_valor values (12,'DERECHOS DE COBRO  - X','3000','X')
insert into cu_codigo_valor values (12,'BIENES RAICES Y RESIDENCIALES  - X','4000','X')
insert into cu_codigo_valor values (12,'INMUEBLES URBANOS  - X','4100','X')
insert into cu_codigo_valor values (12,'INMUEBLES RURALES  - X','4200','X')
insert into cu_codigo_valor values (12,'FIDUCIAS HIPOTECARIAS  - X','4300','X')
insert into cu_codigo_valor values (12,'BIENES DADOS EN LEASING INMOBILIARIO  - X','5000','X')
insert into cu_codigo_valor values (12,'LEASING DE INMUEBLES  - X','5100','X')
insert into cu_codigo_valor values (12,'LEASING HABITACIONAL  - X','5200','X')
insert into cu_codigo_valor values (12,'BIENES DADOS EN LEASING DIFERENTE A INMOBILIARIO  - X','6000','X')
insert into cu_codigo_valor values (12,'LEASING DE MAQUINARIA Y EQUIPO  - X','6100','X')
insert into cu_codigo_valor values (12,'LEASING DE VEHICULOS  - X','6200','X')
insert into cu_codigo_valor values (12,'LEASING MUEBLES Y ENSERES  - X','6300','X')
insert into cu_codigo_valor values (12,'LEASING EQUIPOS DE COMPUTO  - X','6400','X')
insert into cu_codigo_valor values (12,'LEASING SEMOVIENTES  - X','6500','X')
insert into cu_codigo_valor values (12,'OTROS COLATERALES  - X','7000','X')
insert into cu_codigo_valor values (12,'PRENDAS SIN TENENCIA  - X','7100','X')
insert into cu_codigo_valor values (12,'VEHICULOS NUEVOS  - X','7110','X')
go
insert into cu_codigo_valor values (12,'VEHICULOS USADOS  - X','7120','X')
insert into cu_codigo_valor values (12,'MAQUINARIA Y EQUIPO  - X','7130','X')
insert into cu_codigo_valor values (12,'PRENDA SOBRE INVENTARIOS PROCESADOS  - X','7200','X')
insert into cu_codigo_valor values (1314,'COLATERAL FINANCIERO ADMISIBLE  - V','2000','V')
insert into cu_codigo_valor values (1314,'FONDO AGROPECUARIO DE GARANTIAS - FAG  - V','2100','V')
insert into cu_codigo_valor values (1314,'FONDO NACIONAL DE GARANTIAS - FNG  - V','2200','V')
insert into cu_codigo_valor values (1314,'MAYOR A 25 SMLMV  - V','2210','V')
insert into cu_codigo_valor values (1314,'BOGOTA EMPRENDEDORA  - V','2220','V')
insert into cu_codigo_valor values (1314,'FORTALECIMIENTO SHD  - V','2230','V')
insert into cu_codigo_valor values (1314,'PRENDA SOBRE TITULOS VALORES EMIT  - V','2300','V')
insert into cu_codigo_valor values (1314,'DERECHOS DE COBRO  - V','3000','V')
insert into cu_codigo_valor values (1314,'BIENES RAICES Y RESIDENCIALES  - V','4000','V')
insert into cu_codigo_valor values (1314,'INMUEBLES URBANOS  - V','4100','V')
insert into cu_codigo_valor values (1314,'INMUEBLES RURALES  - V','4200','V')
insert into cu_codigo_valor values (1314,'FIDUCIAS HIPOTECARIAS  - V','4300','V')
insert into cu_codigo_valor values (1314,'BIENES DADOS EN LEASING INMOBILIARIO  - V','5000','V')
insert into cu_codigo_valor values (1314,'LEASING DE INMUEBLES  - V','5100','V')
insert into cu_codigo_valor values (1314,'LEASING HABITACIONAL  - V','5200','V')
insert into cu_codigo_valor values (1314,'BIENES DADOS EN LEASING DIFERENTE A INMOBILIARIO  - V','6000','V')
insert into cu_codigo_valor values (1314,'LEASING DE MAQUINARIA Y EQUIPO  - V','6100','V')
insert into cu_codigo_valor values (1314,'LEASING DE VEHICULOS  - V','6200','V')
insert into cu_codigo_valor values (1314,'LEASING MUEBLES Y ENSERES  - V','6300','V')
insert into cu_codigo_valor values (1314,'LEASING EQUIPOS DE COMPUTO  - V','6400','V')
insert into cu_codigo_valor values (1314,'LEASING SEMOVIENTES  - V','6500','V')
insert into cu_codigo_valor values (1314,'OTROS COLATERALES  - V','7000','V')
insert into cu_codigo_valor values (1314,'PRENDAS SIN TENENCIA  - V','7100','V')
insert into cu_codigo_valor values (1314,'VEHICULOS NUEVOS  - V','7110','V')
insert into cu_codigo_valor values (1314,'VEHICULOS USADOS  - V','7120','V')
insert into cu_codigo_valor values (1314,'MAQUINARIA Y EQUIPO  - V','7130','V')
insert into cu_codigo_valor values (1314,'PRENDA SOBRE INVENTARIOS PROCESADOS  - V','7200','V')
insert into cu_codigo_valor values (95,'COLATERAL FINANCIERO ADMISIBLE  - K','2000','K')
insert into cu_codigo_valor values (95,'FONDO AGROPECUARIO DE GARANTIAS - FAG  - K','2100','K')
insert into cu_codigo_valor values (95,'FONDO NACIONAL DE GARANTIAS - FNG  - K','2200','K')
insert into cu_codigo_valor values (95,'MAYOR A 25 SMLMV  - K','2210','K')
insert into cu_codigo_valor values (95,'BOGOTA EMPRENDEDORA  - K','2220','K')
insert into cu_codigo_valor values (95,'FORTALECIMIENTO SHD  - K','2230','K')
insert into cu_codigo_valor values (95,'PRENDA SOBRE TITULOS VALORES EMIT  - K','2300','K')
insert into cu_codigo_valor values (95,'DERECHOS DE COBRO  - K','3000','K')
insert into cu_codigo_valor values (95,'BIENES RAICES Y RESIDENCIALES  - K','4000','K')
insert into cu_codigo_valor values (95,'INMUEBLES URBANOS  - K','4100','K')
insert into cu_codigo_valor values (95,'INMUEBLES RURALES  - K','4200','K')
insert into cu_codigo_valor values (95,'FIDUCIAS HIPOTECARIAS  - K','4300','K')
insert into cu_codigo_valor values (95,'BIENES DADOS EN LEASING INMOBILIARIO  - K','5000','K')
insert into cu_codigo_valor values (95,'LEASING DE INMUEBLES  - K','5100','K')
insert into cu_codigo_valor values (95,'LEASING HABITACIONAL  - K','5200','K')
insert into cu_codigo_valor values (95,'BIENES DADOS EN LEASING DIFERENTE A INMOBILIARIO  - K','6000','K')
insert into cu_codigo_valor values (95,'LEASING DE MAQUINARIA Y EQUIPO  - K','6100','K')
insert into cu_codigo_valor values (95,'LEASING DE VEHICULOS  - K','6200','K')
insert into cu_codigo_valor values (95,'LEASING MUEBLES Y ENSERES  - K','6300','K')
insert into cu_codigo_valor values (95,'LEASING EQUIPOS DE COMPUTO  - K','6400','K')
insert into cu_codigo_valor values (95,'LEASING SEMOVIENTES  - K','6500','K')
insert into cu_codigo_valor values (95,'OTROS COLATERALES  - K','7000','K')
insert into cu_codigo_valor values (95,'PRENDAS SIN TENENCIA  - K','7100','K')
insert into cu_codigo_valor values (95,'VEHICULOS NUEVOS  - K','7110','K')
insert into cu_codigo_valor values (95,'VEHICULOS USADOS  - K','7120','K')
insert into cu_codigo_valor values (95,'MAQUINARIA Y EQUIPO  - K','7130','K')
insert into cu_codigo_valor values (95,'PRENDA SOBRE INVENTARIOS PROCESADOS  - K','7200','K')
insert into cu_codigo_valor values (2500,'ERROR CONTABLE  GARANTIAS FUTUROS CREDITOS','ERRCO','F')
insert into cu_codigo_valor values (2501,'ERRORES CONTABLES GARANTIAS VIGENTES CON OBLIGACION','ERRCO','V')
insert into cu_codigo_valor values (2502,'ERRORES CONTABLES GARANTIAS VIGENTES POR CANCELAR','ERRCO','X')
insert into cu_codigo_valor values (2503,'ERRORES CONTABLES GARANTIAS CASTIGADAS','ERRCO','K')
go



/* CREACION DE TIPOS DE CUSTODIA */

print '--> cu_tipo_custodia'
truncate table cu_tipo_custodia
go

insert into cu_tipo_custodia 
       (tc_tipo,tc_tipo_superior,tc_descripcion,tc_periodicidad,tc_contabilizar,tc_porcentaje,tc_adecuada,
        tc_porcen_cobertura,tc_monetaria,tc_tipo_bien,tc_garan_empleado,tc_clase,tc_estado,tc_multimoneda,
        tc_agotada,tc_ctr_vencimiento)
values ('LIQ',NULL,'GARANTIAS LIQUIDAS','A','N',NULL,'A',0,'N','E',NULL,'I','V','N','N','N')
insert into cu_tipo_custodia 
       (tc_tipo,tc_tipo_superior,tc_descripcion,tc_periodicidad,tc_contabilizar,tc_porcentaje,tc_adecuada,
        tc_porcen_cobertura,tc_monetaria,tc_tipo_bien,tc_garan_empleado,tc_clase,tc_estado,tc_multimoneda,
        tc_agotada,tc_ctr_vencimiento)
values ('AHORRO','LIQ','AHORROS','A','N',NULL,'A',0,'N','E',NULL,'I','V','N','N','N')
insert into cu_tipo_custodia 
       (tc_tipo,tc_tipo_superior,tc_descripcion,tc_periodicidad,tc_contabilizar,tc_porcentaje,tc_adecuada,
        tc_porcen_cobertura,tc_monetaria,tc_tipo_bien,tc_garan_empleado,tc_clase,tc_estado,tc_multimoneda,
        tc_agotada,tc_ctr_vencimiento)
values ('DPF','LIQ','DEPOSITOS A PLAZO FIJO','A','N',NULL,'A',0,'N','E',NULL,'I','V','N','N','N')

insert into cu_tipo_custodia 
       (tc_tipo,tc_tipo_superior,tc_descripcion,tc_periodicidad,tc_contabilizar,tc_porcentaje,tc_adecuada,
        tc_porcen_cobertura,tc_monetaria,tc_tipo_bien,tc_garan_empleado,tc_clase,tc_estado,tc_multimoneda,
        tc_agotada,tc_ctr_vencimiento)
values ('HIP',NULL,'GARANTIAS HIPOTECARIAS','A','S',NULL,'A',0,'S','I',NULL,'I','V','N','N','N')
insert into cu_tipo_custodia 
       (tc_tipo,tc_tipo_superior,tc_descripcion,tc_periodicidad,tc_contabilizar,tc_porcentaje,tc_adecuada,
        tc_porcen_cobertura,tc_monetaria,tc_tipo_bien,tc_garan_empleado,tc_clase,tc_estado,tc_multimoneda,
        tc_agotada,tc_ctr_vencimiento)
values ('VIVSOCIAL','HIP','VIVIENDA SOCIAL','A','S',100,'A',100,'S','I',NULL,'I','V','N','N','S')
insert into cu_tipo_custodia 
       (tc_tipo,tc_tipo_superior,tc_descripcion,tc_periodicidad,tc_contabilizar,tc_porcentaje,tc_adecuada,
        tc_porcen_cobertura,tc_monetaria,tc_tipo_bien,tc_garan_empleado,tc_clase,tc_estado,tc_multimoneda,
        tc_agotada,tc_ctr_vencimiento)
values ('VIVOTRAS','HIP','OTROS BIENES INMUEBLES','A','S',100,'A',100,'S','I',NULL,'I','V','N','N','S')

insert into cu_tipo_custodia 
       (tc_tipo,tc_tipo_superior,tc_descripcion,tc_periodicidad,tc_contabilizar,tc_porcentaje,tc_adecuada,
        tc_porcen_cobertura,tc_monetaria,tc_tipo_bien,tc_garan_empleado,tc_clase,tc_estado,tc_multimoneda,
        tc_agotada,tc_ctr_vencimiento)
values ('AVAL',NULL,'AVALES','A','S',100,'A',100,'S','N',NULL,'I','V','N','N','N')
insert into cu_tipo_custodia 
       (tc_tipo,tc_tipo_superior,tc_descripcion,tc_periodicidad,tc_contabilizar,tc_porcentaje,tc_adecuada,
        tc_porcen_cobertura,tc_monetaria,tc_tipo_bien,tc_garan_empleado,tc_clase,tc_estado,tc_multimoneda,
        tc_agotada,tc_ctr_vencimiento)
values ('PAGARE','AVAL','PAGARE','A','S',100,'A',100,'S','N',NULL,'I','V','N','N','N')

insert into cu_tipo_custodia 
       (tc_tipo,tc_tipo_superior,tc_descripcion,tc_periodicidad,tc_contabilizar,tc_porcentaje,tc_adecuada,
        tc_porcen_cobertura,tc_monetaria,tc_tipo_bien,tc_garan_empleado,tc_clase,tc_estado,tc_multimoneda,
        tc_agotada,tc_ctr_vencimiento)
values ('PREN',NULL,'GARANTIAS PRENDARIAS','A','S',70,'C',70,'S','O',NULL,'I','V','N','N','N')
insert into cu_tipo_custodia 
       (tc_tipo,tc_tipo_superior,tc_descripcion,tc_periodicidad,tc_contabilizar,tc_porcentaje,tc_adecuada,
        tc_porcen_cobertura,tc_monetaria,tc_tipo_bien,tc_garan_empleado,tc_clase,tc_estado,tc_multimoneda,
        tc_agotada,tc_ctr_vencimiento)
values ('VEHICULO','PREN','VEHICULO','A','S',70,'C',70,'S','O',NULL,'I','V','N','N','S')

insert into cu_tipo_custodia 
       (tc_tipo,tc_tipo_superior,tc_descripcion,tc_periodicidad,tc_contabilizar,tc_porcentaje,tc_adecuada,
        tc_porcen_cobertura,tc_monetaria,tc_tipo_bien,tc_garan_empleado,tc_clase,tc_estado,tc_multimoneda,
        tc_agotada,tc_ctr_vencimiento)
values ('PERS',NULL,'GARANTIAS PERSONALES','A','N',NULL,'C',0,'N','N',NULL,'I','V','N','N','N')
insert into cu_tipo_custodia 
       (tc_tipo,tc_tipo_superior,tc_descripcion,tc_periodicidad,tc_contabilizar,tc_porcentaje,tc_adecuada,
        tc_porcen_cobertura,tc_monetaria,tc_tipo_bien,tc_garan_empleado,tc_clase,tc_estado,tc_multimoneda,
        tc_agotada,tc_ctr_vencimiento)
values ('PERSONAL','PERS','PERSONALES','A','N',NULL,'C',0,'N','N',NULL,'I','V','N','N','N')
go

