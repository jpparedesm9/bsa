use cobis
go

delete  cl_catalogo
where   tabla in (select codigo
                    from cl_tabla
                   where tabla in ('cl_cargo'))
go

declare @w_codigo smallint
select @w_codigo = codigo from cl_tabla where tabla = 'cl_cargo'

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'ABOGADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'ABOGADO ASISTENTE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'ADMINISTRADOR BASE DE DATOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'ADMINISTRADOR DE PROYECTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'ADMINISTRADOR DE SEGUROS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'ANALISTA ADMINISTRATIVO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'ANALISTA PROCED PROC PROYECTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'ANALISTA PROGRAMADOR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'ANALISTA RH Y PLANILLA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'ANALISTA SEGURIDAD TI', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '11', 'ASESOR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '12', 'ASISTENTE  AUDITORIA  SISTEMAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '13', 'ASISTENTE ADMINISTRATIVA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '14', 'ASISTENTE ADMINISTRATIVA GGRAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '15', 'ASISTENTE ADMON DE CR Y RIESGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '16', 'ASISTENTE AUDITORIA INTERNA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '17', 'ASISTENTE AUTOMAT DE PRODUCTO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '18', 'ASISTENTE BANCA OFF SHORE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '19', 'ASISTENTE BANCA PRIVADA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20', 'ASISTENTE CONTABILIDAD', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '21', 'ASISTENTE CONTROL INTERNO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '22', 'ASISTENTE CREDITO BANCA CORP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '23', 'ASISTENTE CREDITO COMERCIAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '24', 'ASISTENTE CREDITO CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '25', 'ASISTENTE CREDITO CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26', 'ASISTENTE CREDITO PROB Y B REP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '27', 'ASISTENTE DE ADMINISTRACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '28', 'ASISTENTE FINANZAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '29', 'ASISTENTE FINANZAS Y PRESUP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30', 'ASISTENTE MERCADEO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '31', 'ASISTENTE NEGOCIOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '32', 'ASISTENTE OPER CONSUMO CONTROL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '33', 'ASISTENTE OPERACIONES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '34', 'ASISTENTE OPERACIONES SUC', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '35', 'ASISTENTE PLATAFORMA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '36', 'ASISTENTE PLATAFORMA CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '37', 'ASISTENTE PRESTAMOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '38', 'ASISTENTE PROCESA SEG FRAU CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '39', 'ASISTENTE PUESTO DE BOLSA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40', 'ASISTENTE RECLUT Y SELECCION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41', 'ASISTENTE RECURSOS HUMANOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '42', 'ASISTENTE RIESGO CUMPLIMIENTO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '43', 'ASISTENTE SEGURIDAD', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '44', 'ASISTENTE TESORERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '45', 'AUDITOR DE SISTEMAS ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '46', 'CAJERO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '47', 'CONTADOR - AUDITOR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '48', 'COORDINADOR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '49', 'COORDINADOR CAPAC Y COMUN CORP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50', 'COORDINADOR DE COMUNICACIONES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '51', 'COORDINADOR DE VENTAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '52', 'COORDINADOR MERCADEO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '53', 'COORDINADOR PRODUCTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '54', 'COORDINADOR SOPORTE TECN Y COM', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '55', 'CUSTODIO DE VALORES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '56', 'EJECUTIVO DE VENTAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '57', 'EJECUTIVO MERCADEO Y VENTAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '58', 'GERENTE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '59', 'GERENTE BANCA DE INVERSION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60', 'GERENTE BANCA PRIVADA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '61', 'GERENTE CENTRO DE PRESTAMOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '62', 'GERENTE COBROS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '63', 'GERENTE CREDITO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '64', 'GERENTE CREDITO BANCA CORPORA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '65', 'GERENTE DE PLATAFORMA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '66', 'GERENTE DESARROLLO DE SISTEMAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '67', 'GERENTE GENERAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '68', 'GERENTE OPERACIONES CENTRALIZA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '69', 'GERENTE OPERACIONES CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70', 'GERENTE OPERACIONES PREST CORP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '71', 'GERENTE PROCED Y PROCESOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '72', 'GERENTE SEGURIDAD TI', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '73', 'GERENTE SUCURSAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '74', 'GERENTE TEGNOLOGIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '75', 'GERENTE TESORERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '76', 'GESTOR DE COBROS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '77', 'INSPECTOR DE PROYECTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '78', 'MENSAJERO COBRADOR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '79', 'MENSAJERO INTERNO - EXTERNO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80', 'OFICIAL ADMINISTRACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81', 'OFICIAL ADMON DE CR Y RIESGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '82', 'OFICIAL ARCHIVO Y MENSAJERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '83', 'OFICIAL ARRENDAMIENTO FINANC', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '84', 'OFICIAL AUDITORIA CR Y RIESGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '85', 'OFICIAL AUDITORIA INTERNA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '86', 'OFICIAL BANCA ELECTRONICA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '87', 'OFICIAL BANCA OFF SHORE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '88', 'OFICIAL BANCA POR TELEFONO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '89', 'OFICIAL BANCA PRIVADA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90', 'OFICIAL COBROS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91', 'OFICIAL COMERCIO INTERNACIONAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '92', 'OFICIAL CONTROL INTERNO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '93', 'OFICIAL CREDITO AGROPECUARIO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '94', 'OFICIAL CREDITO BCA CORP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '95', 'OFICIAL CREDITO BCA TRANSPORTE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '96', 'OFICIAL CREDITO COMERCIAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '97', 'OFICIAL CREDITO CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '98', 'OFICIAL CREDITO CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '99', 'OFICIAL CUMPLIMIENTO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '100', 'OFICIAL DE CREDITO HIPOTECAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '101', 'OFICIAL DIST PROD  INVERSION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '102', 'OFICIAL FACTORING', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '103', 'OFICIAL FIDEICOMISO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '104', 'OFICIAL MANTENIMIENTO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '105', 'OFICIAL NEGOCIOS CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '106', 'OFICIAL OPER TRANSF, TES E INV', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '107', 'OFICIAL OPERACIONES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '108', 'OFICIAL OPERACIONES CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '109', 'OFICIAL OPERACIONES CXP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '110', 'OFICIAL OPERACIONES DEPOSITOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '111', 'OFICIAL OPERACIONES PREST COR ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '112', 'OFICIAL OPERACIONES SUCURSALES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '113', 'OFICIAL PLATAFORMA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '114', 'OFICIAL PRESTAMOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '115', 'OFICIAL PROCESA SEG FRAU CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '116', 'OFICIAL PROGRAMACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '117', 'OFICIAL PROYECTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '118', 'OFICIAL RESERVA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '119', 'OFICIAL RH Y DESARROLLO ORG ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '120', 'OFICINISTA ADMINISTRACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '121', 'OFICINISTA ARCHIVO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '122', 'OFICINISTA ASESORIA LEGAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '123', 'OFICINISTA AUDIT CR Y RIESGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '124', 'OFICINISTA BANCA POR TELEFONO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '125', 'OFICINISTA BANCA TRANSPORTE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '126', 'OFICINISTA CR PROBL B REPOSEID', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '127', 'OFICINISTA CREDITO COMERCIAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '128', 'OFICINISTA CREDITO CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '129', 'OFICINISTA CREDITO CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '130', 'OFICINISTA FACTORING', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '131', 'OFICINISTA OPERACIONES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '132', 'OFICINISTA OPERACIONES C X P ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '133', 'OFICINISTA OPERACIONES CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '134', 'OFICINISTA OPERACIONES DEPOSI ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '135', 'OFICINISTA OPERACIONES PR CORP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '136', 'OFICINISTA OPERACIONES TES INV', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '137', 'OFICINISTA OPERACIONES TRANSFE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '138', 'OFICINISTA PLATAFORMA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '139', 'OFICINISTA PRESTAMOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '140', 'OFICINISTA PROCED PROC PROYECT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '141', 'OFICINISTA PROCESA SEG FRAU CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '142', 'OPERADOR DE SISTEMAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '143', 'PROMOTOR CREDITO COMERCIAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '144', 'RECEPCIONISTA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '145', 'SECRETARIA  EJECUTIVA VP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '146', 'SECRETARIA ASESORIA LEGAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '147', 'SECRETARIA EJECUTIVA BCA CORP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '148', 'SECRETARIA RECEPCIONISTA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '149', 'SERVICIOS GENERALES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '150', 'SOPORTE TECNICO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '151', 'SOPORTE TECNICO HELPDESK', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '152', 'SUBGERENTE BCA ELECTRONICA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '153', 'SUBGERENTE CALIDAD Y PROCESOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '154', 'SUBGERENTE CONTABILIDAD', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '155', 'SUBGERENTE CREDITO BCA CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '156', 'SUBGERENTE FIANZAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '157', 'SUBGERENTE MERCADEO ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '158', 'SUBGERENTE OPERACIONE TRANSITO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '159', 'SUBGERENTE PUESTO DE BOLSA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '160', 'SUBGERENTE RECURSOS HUMANOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '161', 'SUBGERENTE SEGURIDAD', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '162', 'SUBGERENTE SUCURSAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '163', 'SUPERVISOR ADMON CRED Y RIESGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '164', 'SUPERVISOR BANCA POR TELEFONO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '165', 'SUPERVISOR COBROS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '166', 'SUPERVISOR OPERACIONES CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '167', 'SUPERVISOR PLATAFORMA CT', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '168', 'SUPERVISOR PROCEDIMIENTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '169', 'VP AUDITORIA INTERNA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '170', 'VP BANCA CORPORATIVA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '171', 'VP EJECUTIVO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '172', 'VP OPERACIONES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '173', 'VP PYME Y REGION METRO 2 ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '174', 'VP TECNOLOGIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '175', 'VPA ADMON DE CREDITO Y COBROS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '176', 'VPA AUDITORIA DE CR Y RIESGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '177', 'VPA BANCA CORPORATIVA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '178', 'VPA BANCA DE TRANSPORTE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '179', 'VPA BANCA OFF SHORE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '180', 'VPA BANCA PRIVADA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '181', 'VPA CENTRO DE TARJETAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '182', 'VPA PRESTAMOS DE CONSUMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '183', 'VPA RECURSOS HUMANOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '184', 'VPA REGION OCCIDENTAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '185', 'ASESOR EXTERNO','V')
go

use cobis
go


delete cobis..cl_oficina
where of_oficina not in (select of_oficina from cob_conta..cb_oficina where of_movimiento = 'S')
go


delete cl_oficina
where of_nombre in ('CENTRO', 'REGIONAL CENTRO 1', 'CHALCO', 'TLALPAN', 'CENTRALIZADORA')
go

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 1000, 'CENTRO', 'CENTRO', 266, 0, 'R', 'BCO', NULL, NULL, NULL, NULL, NULL, NULL, 1, 'C', NULL, NULL, NULL, 'U', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 'N')

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 1100, 'REGIONAL CENTRO 1', 'REGIONAL CENTRO 1', 266, 0, 'Z', 'BCO', NULL, 1000, NULL, NULL, NULL, NULL, 1, 'C', NULL, NULL, NULL, 'U', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 'N')

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 1101, 'CHALCO', 'OFICINA CHALCO', 681, 0, 'O', 'BCO', 1100, 1000, NULL, NULL, NULL, NULL, 1, 'C', NULL, NULL, NULL, 'U', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 'N')

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 1102, 'TLALPAN', 'OFICINA TLALPAN', 276, 0, 'O', 'BCO', 1100, 1000, NULL, NULL, NULL, NULL, 1, 'C', NULL, NULL, NULL, 'U', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 'N')

INSERT INTO dbo.cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_telefono, of_subtipo, of_area, a_sucursal, of_regional, of_tip_punt_at, of_cir_comunic, of_nomb_encarg, of_ci_encarg, of_horario, of_tipo_horar, of_jefe_agenc, of_cod_fie_asf, of_fec_aut_asf, of_sector, of_depart_pais, of_provincia, of_barrio, of_relac_ofic, of_lat_coord, of_lat_grad, of_lat_min, of_lat_seg, of_long_coord, of_long_grad, of_long_min, of_long_seg, of_subregional, of_obs_horario, of_sucursal, of_zona, of_cob, of_bloqueada)
VALUES (1, 9001, 'CENTRALIZADORA', 'CENTRALIZADORA', 276, 0, 'R', 'SOF', NULL, NULL, NULL, NULL, NULL, NULL, 1, 'C', NULL, NULL, NULL, 'U', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 'N')

GO


declare @w_tabla int

select @w_tabla = codigo
from cobis..cl_tabla
where tabla = 'cl_oficina'

delete cl_catalogo where tabla = @w_tabla

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '1000', 'CENTRO', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '1100', 'REGIONAL CENTRO 1', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '1101', 'CHALCO', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '1102', 'TLALPAN', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '9001', 'CENTRALIZADORA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
   VALUES(@w_tabla,@w_codigo,@w_nombre,'V',null,null,null)
go

declare @w_tabla int,
        @w_codigo varchar(10),
        @w_nombre varchar(25)

select @w_tabla=codigo from cobis..cl_tabla where tabla = 'cl_oficina'
select @w_codigo = of_oficina,@w_nombre = of_nombre from cobis..cl_oficina where of_nombre = 'COLECTIVO AVON'

if exists (select 1 from cobis..cl_catalogo where tabla = @w_tabla and codigo = @w_codigo)
begin
   delete from cobis..cl_catalogo where tabla = @w_tabla and codigo = @w_codigo
   INSERT INTO cobis..cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
   VALUES(@w_tabla,@w_codigo,@w_nombre,'V',null,null,null)
  print 'Si existe'
end
else begin
   INSERT INTO cobis..cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
   VALUES(@w_tabla,@w_codigo,@w_nombre,'V',null,null,null)
   print 'No existe'
end

select @w_tabla=codigo from cobis..cl_tabla where tabla = 'cl_oficina'
select @w_codigo = of_oficina,@w_nombre = of_nombre from cobis..cl_oficina where of_nombre = 'COLECTIVO INDEPENDIENTE'

if exists (select 1 from cobis..cl_catalogo where tabla = @w_tabla and codigo = @w_codigo)
begin
   delete from cobis..cl_catalogo where tabla = @w_tabla and codigo = @w_codigo
   INSERT INTO cobis..cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
   VALUES(@w_tabla,@w_codigo,@w_nombre,'V',null,null,null)
  print 'Si existe'
end
else begin
   INSERT INTO cobis..cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
   VALUES(@w_tabla,@w_codigo,@w_nombre,'V',null,null,null)
   print 'No existe'
end


delete cl_departamento
where de_departamento = 7

insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_oficina, de_o_departamento, de_nivel)
values (7, 1, 1101, 'CARTERA', NULL, NULL, 0)


INSERT INTO cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_oficina, de_o_departamento, de_nivel)
VALUES (7, 1, 1102, 'CARTERA', NULL, NULL, 0)

INSERT INTO cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_oficina, de_o_departamento, de_nivel)
VALUES (7, 1, 9001, 'CARTERA', NULL, NULL, 0)
go

------------------------------------------------------------ Oficina AVON ---------------------------------------------------------------------
declare @w_descripcion varchar (25),
        @w_cod_ofi     int,
        @w_cod_cargo    int
        

select @w_cod_ofi = of_oficina from cobis..cl_oficina where of_nombre = 'COLECTIVO AVON'
select @w_descripcion = 'DEPARTAMENTO EXTERNO'

if exists ( select 1 from cobis..cl_departamento where de_descripcion = 'DEPARTAMENTO EXTERNO' and de_oficina = @w_cod_ofi)
begin
   delete from cobis..cl_departamento where de_descripcion = @w_descripcion and de_oficina = @w_cod_ofi
   INSERT INTO cobis..cl_departamento (de_departamento,de_filial,de_oficina,de_descripcion,de_o_oficina,de_o_departamento,de_nivel) 
   VALUES(6,1,@w_cod_ofi,@w_descripcion,null,null,0)
end
else
begin
   INSERT INTO cobis..cl_departamento (de_departamento,de_filial,de_oficina,de_descripcion,de_o_oficina,de_o_departamento,de_nivel) 
   VALUES(6,1,@w_cod_ofi,@w_descripcion,null,null,0)
end

-- Asociar el departamento al cargo
select @w_cod_cargo = codigo from cobis..cl_catalogo where valor = 'ASESOR EXTERNO'

if not exists (select 1 from cl_distributivo where ds_departamento = 6 and ds_oficina = @w_cod_ofi and ds_cargo = @w_cod_cargo)
begin
   INSERT INTO cobis..cl_distributivo (ds_filial,ds_oficina,ds_departamento,ds_cargo,ds_secuencial,ds_fecha,ds_estado,ds_numero,ds_vacante) 
   VALUES(1,@w_cod_ofi,6,@w_cod_cargo,2,getdate(),'V',null,'S')
end
else
begin
   delete from cl_distributivo where ds_departamento = 6 and ds_oficina = @w_cod_ofi and ds_cargo = @w_cod_cargo
   INSERT INTO cobis..cl_distributivo (ds_filial,ds_oficina,ds_departamento,ds_cargo,ds_secuencial,ds_fecha,ds_estado,ds_numero,ds_vacante) 
   VALUES(1,@w_cod_ofi,6,@w_cod_cargo,2,getdate(),'V',null,'S')
end


------------------------------------------------------------ Oficina Independiente ---------------------------------------------------------------------



select @w_cod_ofi = of_oficina from cobis..cl_oficina where of_nombre = 'COLECTIVO INDEPENDIENTE'

if exists ( select 1 from cobis..cl_departamento where de_descripcion = 'DEPARTAMENTO EXTERNO' and de_oficina = @w_cod_ofi)
begin
   delete from cobis..cl_departamento where de_descripcion = @w_descripcion and de_oficina = @w_cod_ofi
   INSERT INTO cobis..cl_departamento (de_departamento,de_filial,de_oficina,de_descripcion,de_o_oficina,de_o_departamento,de_nivel) 
   VALUES(6,1,@w_cod_ofi,@w_descripcion,null,null,0)
end
else
begin
   INSERT INTO cobis..cl_departamento (de_departamento,de_filial,de_oficina,de_descripcion,de_o_oficina,de_o_departamento,de_nivel) 
   VALUES(6,1,@w_cod_ofi,@w_descripcion,null,null,0)
end

-- Asociar el departamento al cargo
select @w_cod_cargo = codigo from cobis..cl_catalogo where valor = 'ASESOR EXTERNO'

if not exists (select 1 from cl_distributivo where ds_departamento = 6 and ds_oficina = @w_cod_ofi and ds_cargo = @w_cod_cargo)
begin
   INSERT INTO cobis..cl_distributivo (ds_filial,ds_oficina,ds_departamento,ds_cargo,ds_secuencial,ds_fecha,ds_estado,ds_numero,ds_vacante) 
   VALUES(1,@w_cod_ofi,6,@w_cod_cargo,2,getdate(),'V',null,'S')
end
else
begin
   delete from cl_distributivo where ds_departamento = 6 and ds_oficina = @w_cod_ofi and ds_cargo = @w_cod_cargo
   INSERT INTO cobis..cl_distributivo (ds_filial,ds_oficina,ds_departamento,ds_cargo,ds_secuencial,ds_fecha,ds_estado,ds_numero,ds_vacante) 
   VALUES(1,@w_cod_ofi,6,@w_cod_cargo,2,getdate(),'V',null,'S')
end



------------------------------------------------------------ Oficina SUPER RED ---------------------------------------------------------------------
declare @w_descripcion  varchar (25),
        @w_cod_ofi      int,
        @w_cod_cargo    int,
		@w_counter      int
        

select @w_cod_ofi = of_oficina from cobis..cl_oficina where of_nombre = 'SUPER RED'
select @w_descripcion = 'DEPARTAMENTO EXTERNO'


if exists ( select 1 from cobis..cl_departamento where de_descripcion = @w_descripcion and de_oficina = @w_cod_ofi)
begin
   delete from cobis..cl_departamento where de_descripcion = @w_descripcion and de_oficina = @w_cod_ofi
   INSERT INTO cobis..cl_departamento (de_departamento,de_filial,de_oficina,de_descripcion,de_o_oficina,de_o_departamento,de_nivel) 
   VALUES(6,1,@w_cod_ofi,@w_descripcion,null,null,0)
end
else
begin
   INSERT INTO cobis..cl_departamento (de_departamento,de_filial,de_oficina,de_descripcion,de_o_oficina,de_o_departamento,de_nivel) 
   VALUES(6,1,@w_cod_ofi,@w_descripcion,null,null,0)
end

-- Asociar el departamento al cargo
select @w_cod_cargo = codigo from cobis..cl_catalogo where valor = 'ASESOR EXTERNO'

if not exists (select 1 from cobis..cl_distributivo where ds_departamento = 6 and ds_oficina = @w_cod_ofi and ds_cargo = @w_cod_cargo)
begin
   select @w_counter = 1
   while (@w_counter <= 20)  begin     
      INSERT INTO cobis..cl_distributivo (ds_filial,ds_oficina,ds_departamento,ds_cargo,ds_secuencial,ds_fecha,ds_estado,ds_numero,ds_vacante) 
      VALUES(1,@w_cod_ofi,6,@w_cod_cargo,@w_counter,getdate(),'V',null,'S')
	  select @w_counter = @w_counter + 1
   end
end
else
begin
   delete from cobis..cl_distributivo where ds_departamento = 6 and ds_oficina = @w_cod_ofi and ds_cargo = @w_cod_cargo
   select @w_counter = 1
   while (@w_counter <= 20)  begin     
      INSERT INTO cobis..cl_distributivo (ds_filial,ds_oficina,ds_departamento,ds_cargo,ds_secuencial,ds_fecha,ds_estado,ds_numero,ds_vacante) 
      VALUES(1,@w_cod_ofi,6,@w_cod_cargo,@w_counter,getdate(),'V',null,'S')
	  select @w_counter = @w_counter + 1
   end
end


delete from cl_distributivo
where ds_filial = 1
and ds_oficina in(1101,1102)
AND ds_departamento = 7

INSERT INTO cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
VALUES (1, 1101, 7, 6, 1, getdate(), 'V', NULL, 'S')
GO

INSERT INTO cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
VALUES (1, 1101, 7, 6, 2, getdate(), 'V', NULL, 'S')
GO

INSERT INTO cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
VALUES (1, 1101, 7, 48, 1, getdate(), 'V', NULL, 'S')
GO

INSERT INTO cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
VALUES (1, 1101, 7, 58, 1, getdate(), 'V', NULL, 'S')
GO

INSERT INTO cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
VALUES (1, 1101, 7, 11, 1, getdate(), 'V', NULL, 'S')
GO

INSERT INTO cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
VALUES (1, 1101, 7, 11, 2, getdate(), 'V', NULL, 'S')
GO

INSERT INTO cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
VALUES (1, 1102, 7, 6, 1, getdate(), 'V', NULL, 'S')
GO

INSERT INTO cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
VALUES (1, 1102, 7, 6, 2, getdate(), 'V', NULL, 'S')
GO

INSERT INTO cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
VALUES (1, 1102, 7, 48, 1, getdate(), 'V', NULL, 'S')
GO

INSERT INTO cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
VALUES (1, 1102, 7, 58, 1, getdate(), 'V', NULL, 'S')
GO

INSERT INTO cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
VALUES (1, 1102, 7, 11, 1, getdate(), 'V', NULL, 'S')
GO

INSERT INTO cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_numero, ds_vacante)
VALUES (1, 1102, 7, 11, 2, getdate(), 'V', NULL, 'S')
GO



delete ad_nodo
WHERE no_nodo in (4, 5, 6)

INSERT INTO ad_nodo (no_nodo, no_marca, no_modelo, no_tipo, no_num_serie, no_fecha_reg, no_fecha_habil, no_registrador, no_habilitante, no_estado, no_fecha_ult_mod)
VALUES (4, 'GENERICO CH', 'GENERICO CH', 'GEN', '0', '2017-06-20', getdate(), 3, NULL, 'V', '2017-06-20')
GO
INSERT INTO ad_nodo (no_nodo, no_marca, no_modelo, no_tipo, no_num_serie, no_fecha_reg, no_fecha_habil, no_registrador, no_habilitante, no_estado, no_fecha_ult_mod)
VALUES (5, 'GENERICO TL', 'GENERICO TL', 'GEN', '0', '2017-06-20', getdate(), 3, NULL, 'V', '2017-06-20')
GO
INSERT INTO ad_nodo (no_nodo, no_marca, no_modelo, no_tipo, no_num_serie, no_fecha_reg, no_fecha_habil, no_registrador, no_habilitante, no_estado, no_fecha_ult_mod)
VALUES (6, 'GENERICO CE', 'GENERICO CE', 'GEN', '0', '2017-06-20', getdate(), 3, NULL, 'V', '2017-06-20')
GO

delete from cobis..ad_nodo_oficina
WHERE nl_oficina NOT IN (select of_oficina from cob_conta..cb_oficina where of_movimiento = 'S')

delete ad_nodo_oficina
where nl_filial = 1
and nl_oficina in (1101,1102, 9001)

declare @w_server varchar(10)

select @w_server = pa_char
from cobis..cl_parametro
where pa_nemonico = 'SRVR'

INSERT INTO ad_nodo_oficina (nl_filial, nl_oficina, nl_nodo, nl_sis_operativo, nl_nombre, nl_fecha_reg, nl_registrador, nl_fecha_habil, nl_habilitante, nl_terminal, nl_estado, nl_secuencial, nl_fecha_ult_mod, nl_x, nl_y)
VALUES (1, 1101, 4, 2, @w_server, getdate(), 3, getdate(), 3, 0, 'V', 1, getdate(), 0, 0)

INSERT INTO ad_nodo_oficina (nl_filial, nl_oficina, nl_nodo, nl_sis_operativo, nl_nombre, nl_fecha_reg, nl_registrador, nl_fecha_habil, nl_habilitante, nl_terminal, nl_estado, nl_secuencial, nl_fecha_ult_mod, nl_x, nl_y)
VALUES (1, 1102, 5, 2, @w_server, getdate(), 3, getdate(), 3, 0, 'V', 1, getdate(), 0, 0)

INSERT INTO ad_nodo_oficina (nl_filial, nl_oficina, nl_nodo, nl_sis_operativo, nl_nombre, nl_fecha_reg, nl_registrador, nl_fecha_habil, nl_habilitante, nl_terminal, nl_estado, nl_secuencial, nl_fecha_ult_mod, nl_x, nl_y)
VALUES (1, 9001, 6, 2, @w_server, getdate(), 3, getdate(), 3, 0, 'V', 1, getdate(), 0, 0)
GO

--cl_funcionario
delete cl_funcionario
where fu_login in ('getech','coorch','admich','asecha','asechb','getetl','coortl','admitl','admitldos','asetla','asetlb')

DECLARE @w_cod_funcionario int

SELECT @w_cod_funcionario = isnull(max(fu_funcionario),0)+1 FROM cl_funcionario


INSERT INTO cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_nomina, fu_departamento, fu_oficina, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_fec_inicio, fu_fec_final, fu_clave, fu_estado, fu_offset, fu_cedruc, fu_causa_bloqueo, fu_fecha_cargo)
VALUES (@w_cod_funcionario, 'ANALISTA ADMINISTRATIVO', 'M', 'N', 3, 7, 1101, 6, 1, 0, 0, '2017-06-20', 'admich', NULL, '2017-07-13 09:43:42.75', NULL, NULL, 'V', 0xA7EC79A9070981E8F9B591139FEA0E14, '33333', NULL, '2017-06-20')

select @w_cod_funcionario = @w_cod_funcionario + 1
INSERT INTO cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_nomina, fu_departamento, fu_oficina, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_fec_inicio, fu_fec_final, fu_clave, fu_estado, fu_offset, fu_cedruc, fu_causa_bloqueo, fu_fecha_cargo)
VALUES (@w_cod_funcionario, 'ASESOR UNO CHALCO', 'M', 'N', 4, 7, 1101, 11, 1, 0, 0, '2017-06-20', 'asecha', NULL, '2017-07-13 10:17:28.993', NULL, NULL, 'V', 0xF862475B48E1CD57736A317747AF28A8, '44444', NULL, '2017-06-20')

select @w_cod_funcionario = @w_cod_funcionario + 1
INSERT INTO cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_nomina, fu_departamento, fu_oficina, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_fec_inicio, fu_fec_final, fu_clave, fu_estado, fu_offset, fu_cedruc, fu_causa_bloqueo, fu_fecha_cargo)
VALUES (@w_cod_funcionario, 'ASESOR DOS CHALCO', 'M', 'N', 5, 7, 1101, 11, 2, 0, 0, '2017-06-20', 'asechb', NULL, '2017-07-12 16:59:54.997', NULL, NULL, 'V', 0x6877618AB7B80E51E3AF3CCC10CA0046, '55555', NULL, '2017-06-20')

select @w_cod_funcionario = @w_cod_funcionario + 1
INSERT INTO cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_nomina, fu_departamento, fu_oficina, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_fec_inicio, fu_fec_final, fu_clave, fu_estado, fu_offset, fu_cedruc, fu_causa_bloqueo, fu_fecha_cargo)
VALUES (@w_cod_funcionario, 'COORDINADOR CHALCO', 'M', 'N', 2, 7, 1101, 53, 2, 0, 0, getdate(), 'coorch', NULL, '2017-07-13 09:43:01.17', NULL, NULL, 'V', 0x3FEFAC3D482B26DDE891935C6E5A38E4, '22222', NULL, getdate())

select @w_cod_funcionario = @w_cod_funcionario + 1
INSERT INTO cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_nomina, fu_departamento, fu_oficina, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_fec_inicio, fu_fec_final, fu_clave, fu_estado, fu_offset, fu_cedruc, fu_causa_bloqueo, fu_fecha_cargo)
VALUES (@w_cod_funcionario, 'GERENTE CHALCO', 'M', 'N', 1, 7, 1101, 58, 4, 4, NULL, '2017-07-06', 'getech', NULL, '2017-07-13 09:41:16.727', NULL, NULL, 'V', 0x37365C88DCCB013C2BEFF1572CC458AA, '11111', NULL, '2017-07-06')

select @w_cod_funcionario = @w_cod_funcionario + 1
INSERT INTO cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_nomina, fu_departamento, fu_oficina, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_fec_inicio, fu_fec_final, fu_clave, fu_estado, fu_offset, fu_cedruc, fu_causa_bloqueo, fu_fecha_cargo)
VALUES (@w_cod_funcionario, 'ANALISTA ADMINISTRATIVO TLALPAN', 'M', 'N', 2, 7, 1102, 6, 1, 0, 0, '2017-06-20', 'admitl', NULL, '2017-07-12 17:17:34.957', NULL, NULL, 'V', 0x57FB500A8DCE11875433E5ACFF595CB7, '88888', NULL, '2017-06-20')

select @w_cod_funcionario = @w_cod_funcionario + 1
INSERT INTO cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_nomina, fu_departamento, fu_oficina, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_fec_inicio, fu_fec_final, fu_clave, fu_estado, fu_offset, fu_cedruc, fu_causa_bloqueo, fu_fecha_cargo)
VALUES (@w_cod_funcionario, 'ANALISTA ADMINISTRATIVO TLALPAN', 'M', 'N', 2, 7, 1102, 6, 1, 0, 0, '2017-06-20', 'admitldos', NULL, '2017-07-12 17:17:34.957', NULL, NULL, 'V', 0x57FB500A8DCE11875433E5ACFF595CB7, '88888', NULL, '2017-06-20')

select @w_cod_funcionario = @w_cod_funcionario + 1
INSERT INTO cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_nomina, fu_departamento, fu_oficina, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_fec_inicio, fu_fec_final, fu_clave, fu_estado, fu_offset, fu_cedruc, fu_causa_bloqueo, fu_fecha_cargo)
VALUES (@w_cod_funcionario, 'ASESOR UNO TLALPAN', 'M', 'N', 4, 7, 1102, 11, 1, 0, 0, '2017-06-20', 'asetla', NULL, '2017-07-13 09:54:06.797', NULL, NULL, 'V', 0x89E3074AF111562A084404CB5A084EF8, '99999', NULL, '2017-06-20')

select @w_cod_funcionario = @w_cod_funcionario + 1
INSERT INTO cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_nomina, fu_departamento, fu_oficina, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_fec_inicio, fu_fec_final, fu_clave, fu_estado, fu_offset, fu_cedruc, fu_causa_bloqueo, fu_fecha_cargo)
VALUES (@w_cod_funcionario, 'ASESOR DOS TLALPAN', 'M', 'N', 5, 7, 1102, 11, 2, 0, 0, '2017-06-20', 'asetlb', NULL, '2017-07-12 17:23:58.08', NULL, NULL, 'V', 0xDF42899240194850D016AC2815C7A30F, '10101', NULL, '2017-06-20')

select @w_cod_funcionario = @w_cod_funcionario + 1
INSERT INTO cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_nomina, fu_departamento, fu_oficina, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_fec_inicio, fu_fec_final, fu_clave, fu_estado, fu_offset, fu_cedruc, fu_causa_bloqueo, fu_fecha_cargo)
VALUES (@w_cod_funcionario, 'COORDINADOR TLALPAN', 'M', 'N', 2, 7, 1102, 48, 1, 0, 0, '2017-06-20', 'coortl', NULL, '2017-07-12 17:16:58.423', NULL, NULL, 'V', 0x012DE9C49C6312E97ED5A6FA89D1DB1F, '77777', NULL, '2017-06-20')

select @w_cod_funcionario = @w_cod_funcionario + 1
INSERT INTO cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_nomina, fu_departamento, fu_oficina, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_fec_inicio, fu_fec_final, fu_clave, fu_estado, fu_offset, fu_cedruc, fu_causa_bloqueo, fu_fecha_cargo)
VALUES (@w_cod_funcionario, 'GERENTE TLALPAN', 'M', 'N', 1, 7, 1102, 58, 1, 0, 0, '2017-06-20', 'getetl', NULL, '2017-07-12 17:16:24.067', NULL, NULL, 'V', 0xB390E3BEF8CB07686DE61CED5164DF6C, '66666', NULL, '2017-06-20')
GO

--ad_usuario

delete FROM cobis..ad_usuario WHERE us_login IN ('getech','coorch','admich','asecha','asechb','getetl','coortl','admitl','admitldos','asetla','asetlb')

INSERT INTO ad_usuario (us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_fecha_ult_mod, us_fecha_ult_pwd, us_estado)
VALUES (1, 1101, 4, 'admich', getdate(), 3, getdate(), NULL, 'V')


INSERT INTO ad_usuario (us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_fecha_ult_mod, us_fecha_ult_pwd, us_estado)
VALUES (1, 1101, 4, 'asecha', getdate(), 3, getdate(), NULL, 'V')


INSERT INTO ad_usuario (us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_fecha_ult_mod, us_fecha_ult_pwd, us_estado)
VALUES (1, 1101, 4, 'asechb', getdate(), 3, getdate(), NULL, 'V')


INSERT INTO ad_usuario (us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_fecha_ult_mod, us_fecha_ult_pwd, us_estado)
VALUES (1, 1101, 4, 'coorch', getdate(), 3, getdate(), NULL, 'V')


INSERT INTO ad_usuario (us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_fecha_ult_mod, us_fecha_ult_pwd, us_estado)
VALUES (1, 1101, 4, 'getech', getdate(), 3, getdate(), NULL, 'V')


INSERT INTO ad_usuario (us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_fecha_ult_mod, us_fecha_ult_pwd, us_estado)
VALUES (1, 1102, 5, 'admitl', getdate(), 3, getdate(), NULL, 'V')

INSERT INTO ad_usuario (us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_fecha_ult_mod, us_fecha_ult_pwd, us_estado)
VALUES (1, 1102, 5, 'admitldos', getdate(), 3, getdate(), NULL, 'V')

INSERT INTO ad_usuario (us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_fecha_ult_mod, us_fecha_ult_pwd, us_estado)
VALUES (1, 1102, 5, 'asetla', getdate(), 3, getdate(), NULL, 'V')


INSERT INTO ad_usuario (us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_fecha_ult_mod, us_fecha_ult_pwd, us_estado)
VALUES (1, 1102, 5, 'asetlb', getdate(), 3, getdate(), NULL, 'V')


INSERT INTO ad_usuario (us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_fecha_ult_mod, us_fecha_ult_pwd, us_estado)
VALUES (1, 1102, 5, 'coortl', getdate(), 3, getdate(), NULL, 'V')


INSERT INTO ad_usuario (us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_fecha_ult_mod, us_fecha_ult_pwd, us_estado)
VALUES (1, 1102, 5, 'getetl', getdate(), 3, getdate(), NULL, 'V')
GO



--ad_usuario_rol
delete ad_usuario_rol where ur_login IN ('getech','coorch','admich','asecha','asechb','getetl','coortl','admitl','admitldos','asetla','asetlb')
go

declare @w_rol int

select @w_rol = ro_rol from ad_rol
where ro_descripcion = 'FUNCIONARIO OFICINA'


INSERT INTO ad_usuario_rol (ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado, ur_fecha_ult_mod, ur_tipo_horario, ur_fec_cad_rol, ur_fecha_ini_rol)
VALUES ('admich', @w_rol, getdate(), 3, 'V', getdate(), 1, NULL, NULL)

INSERT INTO ad_usuario_rol (ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado, ur_fecha_ult_mod, ur_tipo_horario, ur_fec_cad_rol, ur_fecha_ini_rol)
VALUES ('admitl', @w_rol, getdate(), 3, 'V', getdate(), 1, NULL, NULL)

INSERT INTO ad_usuario_rol (ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado, ur_fecha_ult_mod, ur_tipo_horario, ur_fec_cad_rol, ur_fecha_ini_rol)
VALUES ('admitldos', @w_rol, getdate(), 3, 'V', getdate(), 1, NULL, NULL)

select @w_rol = ro_rol from ad_rol
where ro_descripcion = 'ASESOR'

INSERT INTO ad_usuario_rol (ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado, ur_fecha_ult_mod, ur_tipo_horario, ur_fec_cad_rol, ur_fecha_ini_rol)
VALUES ('asecha', @w_rol, getdate(), 3, 'V', getdate(), 1, NULL, NULL)

INSERT INTO ad_usuario_rol (ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado, ur_fecha_ult_mod, ur_tipo_horario, ur_fec_cad_rol, ur_fecha_ini_rol)
VALUES ('asechb', @w_rol, getdate(), 3, 'V', getdate(), 1, NULL, NULL)

INSERT INTO ad_usuario_rol (ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado, ur_fecha_ult_mod, ur_tipo_horario, ur_fec_cad_rol, ur_fecha_ini_rol)
VALUES ('asetla', @w_rol, getdate(), 3, 'V', getdate(), 1, NULL, NULL)

INSERT INTO ad_usuario_rol (ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado, ur_fecha_ult_mod, ur_tipo_horario, ur_fec_cad_rol, ur_fecha_ini_rol)
VALUES ('asetlb', @w_rol, getdate(), 3, 'V', getdate(), 1, NULL, NULL)

select @w_rol = ro_rol from ad_rol
where ro_descripcion = 'CONSULTA'

INSERT INTO ad_usuario_rol (ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado, ur_fecha_ult_mod, ur_tipo_horario, ur_fec_cad_rol, ur_fecha_ini_rol)
VALUES ('coorch', @w_rol, getdate(), 3, 'V', getdate(), 1, NULL, NULL)

INSERT INTO ad_usuario_rol (ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado, ur_fecha_ult_mod, ur_tipo_horario, ur_fec_cad_rol, ur_fecha_ini_rol)
VALUES ('coortl', @w_rol, '2017-06-20', 3, 'V', '2017-06-20', 1, NULL, '2017-06-20')

INSERT INTO ad_usuario_rol (ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado, ur_fecha_ult_mod, ur_tipo_horario, ur_fec_cad_rol, ur_fecha_ini_rol)
VALUES ('getech', @w_rol, getdate(), 3, 'V', getdate(), 1, NULL, NULL)

INSERT INTO ad_usuario_rol (ur_login, ur_rol, ur_fecha_aut, ur_autorizante, ur_estado, ur_fecha_ult_mod, ur_tipo_horario, ur_fec_cad_rol, ur_fecha_ini_rol)
VALUES ('getetl', @w_rol, getdate(), 3, 'V', getdate(), 1, NULL, '2017-06-20')
GO


delete cc_oficial
from cobis..cl_funcionario
where fu_login in ('getech','coorch','admich','asecha','asechb','getetl','coortl','admitl','admitldos','asetla','asetlb')
and oc_funcionario = fu_funcionario

declare @w_funcionario int, @w_of_sup int

select @w_funcionario = fu_funcionario from cobis..cl_funcionario
where fu_login = 'getech'

select @w_of_sup = oc_oficial from cc_oficial
where oc_funcionario = (select fu_funcionario from cl_funcionario where fu_login = 'admuser')

INSERT INTO cc_oficial (oc_oficial, oc_funcionario, oc_sector, oc_actividad, oc_ofi_nsuperior, oc_ofi_sustituto, oc_tipo_oficial, oc_nivel, oc_categoria, oc_mail)
VALUES (@w_funcionario, @w_funcionario, 'P', NULL, @w_of_sup, NULL, '3', NULL, NULL, NULL)

select @w_funcionario = fu_funcionario from cobis..cl_funcionario
where fu_login = 'coorch'

select @w_of_sup = oc_oficial from cc_oficial
where oc_funcionario = (select fu_funcionario from cl_funcionario where fu_login = 'getech')

INSERT INTO cc_oficial (oc_oficial, oc_funcionario, oc_sector, oc_actividad, oc_ofi_nsuperior, oc_ofi_sustituto, oc_tipo_oficial, oc_nivel, oc_categoria, oc_mail)
VALUES (@w_funcionario, @w_funcionario, 'P', NULL, @w_of_sup, NULL, '2', NULL, NULL, NULL)

select @w_funcionario = fu_funcionario from cobis..cl_funcionario
where fu_login = 'admich'

select @w_of_sup = oc_oficial from cc_oficial
where oc_funcionario = (select fu_funcionario from cl_funcionario where fu_login = 'getech')

INSERT INTO cc_oficial (oc_oficial, oc_funcionario, oc_sector, oc_actividad, oc_ofi_nsuperior, oc_ofi_sustituto, oc_tipo_oficial, oc_nivel, oc_categoria, oc_mail)
VALUES (@w_funcionario, @w_funcionario, 'P', NULL, @w_of_sup, NULL, '2', NULL, NULL, NULL)

select @w_funcionario = fu_funcionario from cobis..cl_funcionario
where fu_login = 'asecha'

select @w_of_sup = oc_oficial from cc_oficial
where oc_funcionario = (select fu_funcionario from cl_funcionario where fu_login = 'coorch')

INSERT INTO cc_oficial (oc_oficial, oc_funcionario, oc_sector, oc_actividad, oc_ofi_nsuperior, oc_ofi_sustituto, oc_tipo_oficial, oc_nivel, oc_categoria, oc_mail)
VALUES (@w_funcionario, @w_funcionario, 'P', NULL, @w_of_sup, NULL, '1', NULL, NULL, NULL)

select @w_funcionario = fu_funcionario from cobis..cl_funcionario
where fu_login = 'asechb'

select @w_of_sup = oc_oficial from cc_oficial
where oc_funcionario = (select fu_funcionario from cl_funcionario where fu_login = 'coorch')

INSERT INTO cc_oficial (oc_oficial, oc_funcionario, oc_sector, oc_actividad, oc_ofi_nsuperior, oc_ofi_sustituto, oc_tipo_oficial, oc_nivel, oc_categoria, oc_mail)
VALUES (@w_funcionario, @w_funcionario, 'P', NULL, @w_of_sup, NULL, '1', NULL, NULL, NULL)

select @w_funcionario = fu_funcionario from cobis..cl_funcionario
where fu_login = 'getetl'

select @w_of_sup = oc_oficial from cc_oficial
where oc_funcionario = (select fu_funcionario from cl_funcionario where fu_login = 'admuser')

INSERT INTO cc_oficial (oc_oficial, oc_funcionario, oc_sector, oc_actividad, oc_ofi_nsuperior, oc_ofi_sustituto, oc_tipo_oficial, oc_nivel, oc_categoria, oc_mail)
VALUES (@w_funcionario, @w_funcionario, 'P', NULL, @w_of_sup, NULL, '3', NULL, NULL, NULL)

select @w_funcionario = fu_funcionario from cobis..cl_funcionario
where fu_login = 'coortl'

select @w_of_sup = oc_oficial from cc_oficial
where oc_funcionario = (select fu_funcionario from cl_funcionario where fu_login = 'getetl')

INSERT INTO cc_oficial (oc_oficial, oc_funcionario, oc_sector, oc_actividad, oc_ofi_nsuperior, oc_ofi_sustituto, oc_tipo_oficial, oc_nivel, oc_categoria, oc_mail)
VALUES (@w_funcionario, @w_funcionario, 'P', NULL, @w_of_sup, NULL, '2', NULL, NULL, NULL)

select @w_funcionario = fu_funcionario from cobis..cl_funcionario
where fu_login = 'admitl'

select @w_of_sup = oc_oficial from cc_oficial
where oc_funcionario = (select fu_funcionario from cl_funcionario where fu_login = 'getetl')

INSERT INTO cc_oficial (oc_oficial, oc_funcionario, oc_sector, oc_actividad, oc_ofi_nsuperior, oc_ofi_sustituto, oc_tipo_oficial, oc_nivel, oc_categoria, oc_mail)
VALUES (@w_funcionario, @w_funcionario, 'P', NULL, @w_of_sup, NULL, '2', NULL, NULL, NULL)

select @w_funcionario = fu_funcionario from cobis..cl_funcionario
where fu_login = 'admitldos'

select @w_of_sup = oc_oficial from cc_oficial
where oc_funcionario = (select fu_funcionario from cl_funcionario where fu_login = 'getetl')

INSERT INTO cc_oficial (oc_oficial, oc_funcionario, oc_sector, oc_actividad, oc_ofi_nsuperior, oc_ofi_sustituto, oc_tipo_oficial, oc_nivel, oc_categoria, oc_mail)
VALUES (@w_funcionario, @w_funcionario, 'P', NULL, @w_of_sup, NULL, '2', NULL, NULL, NULL)

select @w_funcionario = fu_funcionario from cobis..cl_funcionario
where fu_login = 'asetla'

select @w_of_sup = oc_oficial from cc_oficial
where oc_funcionario = (select fu_funcionario from cl_funcionario where fu_login = 'coortl')

INSERT INTO cc_oficial (oc_oficial, oc_funcionario, oc_sector, oc_actividad, oc_ofi_nsuperior, oc_ofi_sustituto, oc_tipo_oficial, oc_nivel, oc_categoria, oc_mail)
VALUES (@w_funcionario, @w_funcionario, 'P', NULL, @w_of_sup, NULL, '1', NULL, NULL, NULL)

select @w_funcionario = fu_funcionario from cobis..cl_funcionario
where fu_login = 'asetlb'

select @w_of_sup = oc_oficial from cc_oficial
where oc_funcionario = (select fu_funcionario from cl_funcionario where fu_login = 'coortl')

INSERT INTO cc_oficial (oc_oficial, oc_funcionario, oc_sector, oc_actividad, oc_ofi_nsuperior, oc_ofi_sustituto, oc_tipo_oficial, oc_nivel, oc_categoria, oc_mail)
VALUES (@w_funcionario, @w_funcionario, 'P', NULL, @w_of_sup, NULL, '1', NULL, NULL, NULL)

go

