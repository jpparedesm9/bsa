/* CARGA CATALOGOS CARTERA */

use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CCA'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla like 'ca_%'
go

delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CCA'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in ('cl_tipos_contratos_camp')
go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in 
   (
   'ca_toperacion',            
   'ca_tipo_prestamo',         
   'ca_tipo_linea',            
   'ca_subtipo_linea',         
   'ca_categoria_linea',       
   'ca_suspension_clase' ,     
   'ca_entidad_convenio',      
   'ca_especiales',            
   'ca_calificacion_causacion',
   'ca_causal_rechazo_prepago',
   'ca_control_lactivos',      
   'ca_rubros_catalogos',      
   'ca_concepto_dpg',          
   'ca_rubros_condonar',       
   'ca_estado_pago',           
   'ca_reduccion_pago',        
   'ca_convenio_recaudo',      
   'ca_dias_vencimiento',      
   'ca_otras_tasas',
   'ca_conceptos_exc',
   'ca_reajuste_especial','ca_desagio','ca_signo',
   'cl_tipos_contratos_camp',
   'ca_rubro_grupo',
   'ca_toper_sem',
   'ca_toper_quin',
   'ca_interciclo',
   'ca_grupal',
   'ca_toper_ren',
   'ca_tdividendo',
   'ca_estados_reg',
   'ca_param_notif',
   'ca_fuente_recurso',
   'ca_errores_santander_pagos',
   'cl_socio_comercial',
   'ns_plantilla_sms',
   'eli_reg_dia_pago'
   )                                              
and cl_tabla.codigo = cl_catalogo.tabla

go                                       
delete cl_tabla                          
 where cl_tabla.tabla in 
   (
   'ca_toperacion',            
   'ca_tipo_prestamo',         
   'ca_tipo_linea',            
   'ca_subtipo_linea',         
   'ca_categoria_linea',       
   'ca_suspension_clase',      
   'ca_entidad_convenio',      
   'ca_especiales',            
   'ca_calificacion_causacion',
   'ca_causal_rechazo_prepago',
   'ca_control_lactivos',      
   'ca_rubros_catalogos',      
   'ca_concepto_dpg',          
   'ca_rubros_condonar',       
   'ca_estado_pago',           
   'ca_reduccion_pago',        
   'ca_convenio_recaudo',      
   'ca_dias_vencimiento',      
   'ca_otras_tasas',
   'ca_conceptos_exc',
   'ca_reajuste_especial','ca_desagio','ca_signo',
   'cl_tipos_contratos_camp',
   'ca_rubro_grupo',
   'ca_toper_sem',
   'ca_toper_quin',
   'ca_interciclo',
   'ca_grupal',
   'ca_toper_ren',
   'ca_tdividendo',
   'ca_estados_reg',
   'ca_param_notif',
   'ca_fuente_recurso',
   'ca_errores_santander_pagos',
   'cl_socio_comercial',
   'ca_sub_producto_rep',
   'ns_plantilla_sms',
   'eli_reg_dia_pago'
   )                                    
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_grupal', 'TOperaciones para prestamos Grupales')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'CREGRP', 'CREDITO GRUPAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'GRUPAL', 'CREDITO GRUPAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'REVOLVENTE', 'Crédito Revolvente', 'V')

go


declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_interciclo', 'TOperaciones para Interciclo')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'INTCLGRP', 'CRÉDITO INTERCICLO GRUPAL', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_toperacion', 'Linea de Credito')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES(@w_tabla, 'GRUPAL', 'CREDITO GRUPAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES(@w_tabla, 'INDIVIDUAL', 'CREDITO INDIVIDUAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES(@w_tabla, 'INTERCICLO', 'CREDITO INTERCICLO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES(@w_tabla, 'REVOLVENTE', 'CREDITO REVOLVENTE', 'V')
insert into cobis..cl_catalogo values (@w_tabla,'RENOVACION','CREDITO GRUPAL RENOVACION','V',null,null,null)
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_tipo_prestamo', 'Clase de Linea de Credito')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'C', 'CON FINANCIAMIENTO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'D', 'DOCUMENTOS DESCONTADOS', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'G', 'RECONOCIMIENTO DE GARANTIA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'H', 'HIPOTECARIA', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'N', 'NORMAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'O', 'NORMAL', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'R', 'REDESCUENTO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'V', 'CONVENIOS', 'B')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_tipo_linea', 'Entidad Prestamista')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '221', 'BANCOLDEX - BANCO DE COMERCIO EXTERIOR DE COLOMBIA S.A.', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '222', 'FINDETER-FINANANCIERA DE DESARROLLO TERRITORIAL', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '224', 'FINAGRO-FONDO PARA EL FINANCIAMIENTO DEL SECTOR AGROPECUARIO', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '225', 'BANCO INTERAMERICANO DE DESARROLLO', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '240', 'PROGRAMAS PRESIDENCIA DE LA REPUBLICA', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '301', 'BANCO DE LA REPUBLICA', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '999', 'PROPIO', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_subtipo_linea', 'Programa de Credito')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '01', 'Quirografarias', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '02', 'Prendarias', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '03', 'Factoraje', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '04', 'Arrendamiento Capitalizable', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '05', 'Microcréditos', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '06', 'Otros', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '07', 'Liquidez a otras Cooperativas', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '99', 'N/A', 'V')

go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_categoria_linea', 'Origen de Los Recursos')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '1', 'FONDOS PROPIOS', 'V')
go


declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_suspension_clase', 'Dias para Suspension Causacion')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '1', '91', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '2', '61', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '3', '61', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '4', '31', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_entidad_convenio', 'Entidades de convenio')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_especiales', 'Operaciones por reconocimiento de garantias especiales')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'RECOFNG', 'CREDITO RECONOCIMIENTO GARANTIA FNG', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_calificacion_causacion', 'SUSPENSION POR CALIFICACION')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '1', 'C', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '2', 'C', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '3', 'B', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '4', 'B', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_causal_rechazo_prepago', 'CAUSALES DE RECHAZO DE PREPAGO')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '1', 'OBLIGACION VENCIDA TOTALMENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '2', 'OPERACION CON CUOTAS VENCIDAS HACER FV', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '3', 'SIN SALDO DE CAPITAL PARA PREPAGAR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '4', 'DIAS NEGATIVOS POR PAGOS POST AL PREPAG', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '5', 'POR VALIDACION DEL PARAMETRO ANTES DEL V', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '6', 'VALOR DEL PREPAGO MAYOR AL SALDO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '7', 'POR REVERSO DEL PAGO DE LA ACTIVA', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_control_lactivos', 'FORMAS DE PAGO CONTROL LAVADO DE ACTIVOS')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'CHPRO', 'CHEQUE PROPIO', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'EFEMN', 'EFECTIVO MONEDA NACIONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'NDAHO', 'NOTA DEBITO CTA AHORROS', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'NDCC', 'NOTA DEBITO CTA CORRIENTE', 'B')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_rubros_catalogos', 'RUBROS VENCIDOS DE CATALOGOS')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'CMIPYME', 'COMISION CMIPYME DIFERIDA', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_concepto_dpg', 'CONCEPTOS DEPOSITOS EN GARANTIA')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '216015DGO', 'DEPOSITOS EN GARANTIA OFICIALES', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '216015DGP', 'DEPOSITOS EN GARANTIA PARTICULARES', 'B')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_rubros_condonar', 'CCA rubros para condonar')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'IMO', 'INTERES MORA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'INT', 'INTERES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'SEGDEUVEN', 'SEGURO DEUDORES COBRO VENCIDO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'MIPYMES', 'COMISION MIPYMES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'IVAMIPYMES', 'IVA SOBRE LA COMISION MIPYMES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'HONABO', 'HONORARIOS DE ABOGADO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'IVAHONOABO', 'IVA HONORARIOS DEL ABOGADO', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_estado_pago', 'ESTADO DE LOS PAGOS')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'A', 'APLICADO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'ANU', 'ANULADO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'BOR', 'BORRADO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'E', 'ELIMINADO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'ING', 'INGRESADO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'NA', 'NO APLICADO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'RV', 'REVERSADO', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_reduccion_pago', 'TIPOS DE REDUCCION DE LOS PAGOS')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'C', 'REDUCCION CUOTA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'N', 'NORMAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'T', 'REDUCCION PLAZO', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_convenio_recaudo', 'ENTIDADES CONVENIO RECAUDO BANCAMIA')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '1', 'GTECH', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '2', 'EDATEL', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_dias_vencimiento', 'Dias permitidos para fechas de vencimiento')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '1', '2', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '2', '2', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '3', '3', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '4', '4', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '5', '5', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '6', '6', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '7', '7', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '8', '8', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '9', '9', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '10', '10', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '11', '11', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '12', '12', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '13', '13', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '14', '14', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '15', '15', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '16', '16', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '17', '17', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '18', '18', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '19', '19', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '20', '20', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '21', '2', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '22', '3', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '23', '4', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '24', '5', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '25', '6', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '26', '7', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '27', '8', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '28', '9', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '29', '10', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '30', '11', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '31', '12', 'V')

go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_conceptos_exc', 'CONCEPTOS A EXCLUIR EN SALDO')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'HONABO', 'HONORARIOS ABOGADOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'IVAHONOABO', 'IVA HONORARIOS ABOGADOS', 'V')

go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'ca_reajuste_especial', 'REAJUSTE ESPECIAL')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'S', 'SI', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'N', 'NO', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'ca_desagio', 'DESAGIO')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'B', 'Base', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'E', 'Efectivo', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'N', 'Nominal', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'ca_signo', 'SIGNO')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '+', '[+]', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '-', '[-]', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '*', '[*]', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '/', '[/]', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_otras_tasas', 'Otras Tasas Para Rubros')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla, 'cl_tipos_contratos_camp', 'Tipos de Contratos por Campana')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 1, 'apersimplecont', 'V')--Contraofertas
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 2, 'apersimple', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 3, 'aper_rotativo', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 4, 'pagare_a_la_orden', 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla, 'ca_rubro_grupo', 'Grupo de Rubros')

insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'A', 'Iva', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'C', 'Capital', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'D', 'Devoluciones', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'G', 'Gastos', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'H', 'Gastos Judiciales', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'I', 'Interes', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'M', 'Mora', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'O', 'Comisiones', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'R', 'Otros Cargos', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'S', 'Seguros', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'T', 'Impuestos', 'V', NULL, NULL, NULL)
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla, 'ca_toper_sem', 'Tipos de operaciones con dividendos semanales')

insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'CRESEMW', 'CREDITO SEMILLA SEMANAL', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'CREGRP'  , 'CREDITO GRUPAL', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'INTCLGRP', 'CREDITO INTERCICLO', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'GRUPAL', 'CREDITO GRUPAL', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'INDIVIDUAL', 'CREDITO INDIVIDUAL', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'INTERCICLO', 'CREDITO INTERCICLO', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'REVOLVENTE', 'CREDITO REVOLVENTE', 'V', NULL, NULL, NULL)
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla, 'ca_toper_quin', 'Tipos de operaciones con dividendos quincenales')

insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'CRESEMQ' , 'CREDITO SEMILLA QUINCENAL', 'V', NULL, NULL, NULL)
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'REVOLVENTE', 'CREDITO REVOLVENTE', 'V', NULL, NULL, NULL)
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla, 'ca_toper_ren', 'Tipo de operaciones para renovacion')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GRUPAL', 'GRUPAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'INDIVIDUAL', 'INDIVIDUAL'   , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'INTERCICLO', 'INTERCICLO'   , 'V')
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla, 'ca_fuente_recurso', 'FUENTES DE RECURSO')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'BANCO SANTANDER', 'V') 
go

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_errores_santander_pagos', 'Errores Santander Pagos')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '1', 'ERROR1', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '2', 'ERROR2', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, '3', 'ERROR3', 'V')
go

------------------------------------------------
-- catalogo ca_tdividendo
------------------------------------------------
print 'ca_tdividendo'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cobis..cl_tabla (codigo, tabla,descripcion) values (@w_tabla, 'ca_tdividendo', 'Tipo de Cuota' )

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'D', 'DIA(S)', 'V', NULL, NULL, NULL)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'A', 'A-O(S)', 'V', NULL, NULL, NULL)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'M', 'MES(ES)', 'V', NULL, NULL, NULL)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'T', 'TRIMESTRE(S)', 'V', NULL, NULL, NULL)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'S', 'SEMESTRE(S)', 'V', NULL, NULL, NULL)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'B', 'BIMESTRE(S)', 'V', NULL, NULL, NULL)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'W', 'SEMANAL', 'V', NULL, NULL, NULL)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'Q', 'QUINCENAL', 'V', NULL, NULL, NULL)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'BW', 'CATORCENAL', 'V', NULL, NULL, NULL)

GO

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_estados_reg', 'CCA Estados Registros')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'V', 'VIGENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'B', 'BLOQUEADO', 'V')

update cobis..cl_seqnos
   set siguiente = @w_tabla
 where tabla = 'cl_tabla'

go

declare @w_tabla int
select @w_tabla = isnull(max(codigo), 0) + 1 from cl_tabla

insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'ca_param_notif', 'PARAMETROS NOTIFICACIONES CARTERA')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCO_NXML', 'PagoCorresponsal.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCO_NJAS', 'PagoCorresponsal.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCO_NPDF', 'PagoCorresponsal_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVG_NXML', 'gruposvencigerent.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVG_NJAS', 'GrupoVenciGeren.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVG_NPDF', 'GrupoVenciGeren_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVC_NXML', 'gruposvencicoord.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVC_NJAS', 'GrupoVenciCoord.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVC_NPDF', 'GrupoVenciCoord_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFCVE_NXML', 'vencicuotas.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFCVE_NJAS', 'AvisoVencCuotas.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFCVE_NPDF', 'AvisoVencCuotas_', 'V')

--caso188497
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PPCVE_NXML', 'referenciadepago.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PPCVE_NJAS', 'ReferenciaDePago.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PPCVE_NPDF', 'ReferenciaDePago_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFIAV_NXML', 'IncumplimientoAval.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFIAV_NJAS', 'IncumplimientoAvalista.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFIAV_NPDF', 'IncumplimientoAvalista_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGLQ_NXML', 'pagogaraliq.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGLQ_NJAS', 'GarantiasLiquidas.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGLQ_NPDF', 'GarantiasLiquidas_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGLI_NXML', 'pagogaraliq.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGLI_NJAS', 'GarantiasLiquidas.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGLI_NPDF', 'GarantiasLiquidas_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NTGNR_NXML', 'NotificacionGeneral.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NTGNR_NJAS', 'NotificacionGeneral.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NTGNR_NPDF', 'NotificacionGeneral_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCV_NXML', 'PagoCorresponsal.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCV_NJAS', 'PagoCorresponsal.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCV_NPDF', 'PagoCorresponsal_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GRPCN_NXML', 'ReferenciaPreCancelacion.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GRPCN_NJAS', 'ReferenciaPreCancelacion.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GRPCN_NPDF', 'ReferenciaPreCancelacion', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETCUE_NXML', 'AccountStatus.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETCUE_NJAS', 'AccountStatus.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETCUE_NPDF', 'EstadoCuenta_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'RELCR_NXML', 'RechazoLCR.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'RELCR_NJAS', 'RechazoLCR.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'RELCR_NPDF', 'RechazoLCR_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CRLCR_NXML', 'CreacionLCR.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CRLCR_NJAS', 'CreacionLCR.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CRLCR_NPDF', 'CreacionLCR_', 'V')

insert into cobis..cl_catalogo(tabla,codigo,valor,estado) values(@w_tabla,'GRPCO_NJAS','PagoCorresponsal.jasper','V')
insert into cobis..cl_catalogo(tabla,codigo,valor,estado) values(@w_tabla,'GRPCO_NPDF','PagoCorresponsal_','V')
insert into cobis..cl_catalogo(tabla,codigo,valor,estado) values(@w_tabla,'GRPCO_NXML','PagoCorresponsal.xml','V')

insert into cobis..cl_catalogo(tabla,codigo,valor,estado) values(@w_tabla, 'NPDT_NJAS','DiscountNotification.jasper','V')
insert into cobis..cl_catalogo(tabla,codigo,valor,estado) values(@w_tabla, 'NPDT_NPDF','DiscountNotification_','V')
insert into cobis..cl_catalogo(tabla,codigo,valor,estado) values(@w_tabla, 'NPDT_NXML','DiscountNotification.xml','V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETLCR_NJAS', 'AccountStatus_LCR.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETLCR_NPDF', 'EstadoCtaLCR_', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETLCR_NXML', 'AccountStatus_LCR.xml', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETCIN_NJAS', 'AccountStatusIndividual.jasper', 'V') -- porCaso#174670
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETCIN_NPDF', 'EstadoCtaCREIND_', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETCIN_NXML', 'AccountStatusIndividual.xml', 'V')

update cobis..cl_seqnos set siguiente = @w_tabla where tabla = 'cl_tabla'


insert into cl_catalogo_pro
select 'CCA', codigo
  from cl_tabla 
 where cl_tabla.tabla like 'ca_%'

go

insert into cl_catalogo_pro
select 'CCA', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_tipos_contratos_camp')

go


------------------------------------------------
-- catalogo ca_razon_no_conciliacion
------------------------------------------------

declare @w_tabla int
delete from cl_catalogo where tabla in (select codigo from cl_tabla where tabla = 'ca_razon_no_conciliacion')
delete from cl_tabla where tabla = 'ca_razon_no_conciliacion'


select @w_tabla = isnull(max(codigo),0) + 1
  from cl_tabla
INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'ca_razon_no_conciliacion', 'Razón no conciliación')


INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'NE', 'No enviado', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'NR', 'No recibido', 'V', NULL, NULL, NULL)

go

------------------------------------------------
-- catalogo ca_tipo_pago
------------------------------------------------

declare @w_tabla int
delete from cl_catalogo where tabla in (select codigo from cl_tabla where tabla = 'ca_tipo_pago')
delete from cl_tabla where tabla = 'ca_tipo_pago'

select @w_tabla = isnull(max(codigo),0) + 1
  from cl_tabla
  
INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'ca_tipo_pago', 'Tipo de Pago Corresponsal')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'I', 'Préstamo Individual', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'P', 'Préstamo Grupal', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'G', 'Garantía', 'V', NULL, NULL, NULL)

go

------------------------------------------------
-- catalogo ca_estado_pago_corresponsal
------------------------------------------------

declare @w_tabla int
delete from cl_catalogo where tabla in (select codigo from cl_tabla where tabla = 'ca_estado_pago_corresponsal')
delete from cl_tabla where tabla = 'ca_estado_pago_corresponsal'

select @w_tabla = isnull(max(codigo),0) + 1
  from cl_tabla
  
INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'ca_estado_pago_corresponsal', 'Estado Pago Corresponsal')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'I', 'Ingresado', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'P', 'Procesado', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'E', 'Error', 'V', NULL, NULL, NULL)

go


------------------------------------------------
-- catalogo ca_corresponsales
------------------------------------------------
declare @w_tabla int
delete from cl_catalogo where tabla in (select codigo from cl_tabla where tabla = 'ca_corresponsales')
delete from cl_tabla where tabla = 'ca_corresponsales'

select @w_tabla = isnull(max(codigo),0) + 1
  from cl_tabla
  
INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'ca_corresponsales', 'Corresponsales no bancarios')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'OPEN_PAY', 'OPEN PAY', 'V', NULL, NULL, NULL)

go

------------------------------------------------
-- catalogo ca_estado_conciliacion
------------------------------------------------
declare @w_tabla int
delete from cl_catalogo where tabla in (select codigo from cl_tabla where tabla = 'ca_estado_conciliacion')
delete from cl_tabla where tabla = 'ca_estado_conciliacion'


select @w_tabla = isnull(max(codigo),0) + 1
  from cl_tabla
  
INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'ca_estado_conciliacion', 'Estado Conciliación')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'S', 'Conciliado', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'N', 'No Conciliado', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'T', 'Todos', 'V', NULL, NULL, NULL)
go

------------------------------------------------
-- catalogo ca_tipo_error
------------------------------------------------
declare @w_tabla int
delete cl_tabla where tabla = 'ca_tipo_error'

select @w_tabla = isnull(max(codigo),0) + 1
  from cl_tabla
insert into cl_tabla values (@w_tabla, 'ca_tipo_error', 'Tipo error log')


delete cl_catalogo where tabla = (select codigo from cl_tabla where tabla = 'ca_tipo_error')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'T', 'Todos', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'C', 'Cobis', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'S', 'Santander', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values(@w_tabla, 'P', 'Pagos Referenciados', 'V')
go


------------------------------------------------
-- catalogo ca_accion_disperciones
------------------------------------------------
-- Se agrega catalogo de Acción para Dispersiones Rechazadas
declare @w_codigo smallint
select @w_codigo = siguiente
  from cl_seqnos
 where tabla = 'cl_tabla'
 
select @w_codigo = @w_codigo + 1
print 'Codigos de Acción para Dispersiones Rechazadas'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ca_accion_disperciones', ' Tabla ca_accion_disperciones')
insert into cl_catalogo_pro values ('CCA', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '1',  'SIN ACCION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '2',  'REINTENTOS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '3',  'CANCELACIONES' , 'V')

update cl_seqnos
set siguiente = @w_codigo
where tabla = 'cl_tabla'

go

------------------------------------------------
-- catalogo ca_tipo_disperciones
------------------------------------------------
-- Se agrega catalogo de Tipo de dispersion
declare @w_codigo smallint
select @w_codigo = siguiente
  from cl_seqnos
 where tabla = 'cl_tabla'
 
select @w_codigo = @w_codigo + 1
print 'Codigos de Acción para Dispersiones Rechazadas'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ca_tipo_disperciones', ' Tabla ca_tipo_disperciones')
insert into cl_catalogo_pro values ('CCA', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'DES',  'DESEMBOLSO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'GAR',  'GARANTIAS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'SOB',  'SOBRANTES' , 'V')

update cl_seqnos
set siguiente = @w_codigo
where tabla = 'cl_tabla'

go

------------------------------------------------
-- catalogo ca_periodicidad_lcr
------------------------------------------------
-- Se agrega catalogo de Periodicidad para Línea de Crédito Revolvente
declare @w_codigo smallint
select @w_codigo = siguiente
  from cl_seqnos
 where tabla = 'cl_tabla'
 
select @w_codigo = @w_codigo + 1
print 'Periodicidad para Línea de Crédito Revolvente'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ca_periodicidad_lcr', ' Tabla ca_periodicidad_lcr')
insert into cl_catalogo_pro values ('CCA', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'M',  'MENSUAL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'W',  'SEMANAL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'BW',  'CATORCENAL' , 'V')

update cl_seqnos
set siguiente = @w_codigo
where tabla = 'cl_tabla'

go
use cobis
go

------------------------------------------------
-- catalogo ca_corresponsal
------------------------------------------------
delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='ca_corresponsal')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='ca_corresponsal')
delete from cl_tabla where tabla ='ca_corresponsal'

go
 
declare @w_id_catalogo int
 
select @w_id_catalogo = max(codigo) + 1 from cl_tabla
 
insert into cl_tabla (codigo, tabla, descripcion) 
values (@w_id_catalogo, 'ca_corresponsal', 'Corresponsal')
 
insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CCA', @w_id_catalogo)
 
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'SANTANDER', 'SANTANDER', 'V', NULL, NULL, NULL)

go

------------------------------------------------
-- catalogo ca_tipo_pago_corresponsal
------------------------------------------------
delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='ca_tipo_pago_corresponsal')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='ca_tipo_pago_corresponsal')
delete from cl_tabla where tabla ='ca_tipo_pago_corresponsal'
 
go
 
declare @w_id_catalogo int
 
select @w_id_catalogo = max(codigo) + 1 from cl_tabla
 
insert into cl_tabla (codigo, tabla, descripcion) 
values (@w_id_catalogo, 'ca_tipo_pago_corresponsal', 'Tipo de Pago Corresponsal')
 
insert into cl_catalogo_pro (cp_producto, cp_tabla) 
values ('CCA', @w_id_catalogo)
 
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'TO', 'Todos', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'PG', 'Pago Grupal', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'PI', 'Pago Individual', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'CG', 'Cancelación Grupal', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'CI', 'Cancelación Individual', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'GL', 'Pago de Garantias', 'V', NULL, NULL, NULL) 

go

------------------------------------------------
-- catalogo ca_no_concilia_corresponsal
------------------------------------------------
delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='ca_no_concilia_corresponsal')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='ca_no_concilia_corresponsal')
delete from cl_tabla where tabla ='ca_no_concilia_corresponsal'

go
 
declare @w_id_catalogo int
 
select @w_id_catalogo = max(codigo) + 1 from cl_tabla
 
insert into cl_tabla (codigo, tabla, descripcion) 
values (@w_id_catalogo, 'ca_no_concilia_corresponsal', 'Razón por la que no concilia corresponsal')
 
insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CCA', @w_id_catalogo)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'T', 'Todos', 'V', NULL, NULL, NULL)
 
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'C', 'Húerfano Cobis', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'A', 'Húerfano Archivo', 'V', NULL, NULL, NULL)

go

------------------------------------------------
-- catalogo ca_estado_pago_corresponsal
------------------------------------------------
delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='ca_estado_pago_corresponsal')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='ca_estado_pago_corresponsal')
delete from cl_tabla where tabla ='ca_estado_pago_corresponsal'

go
 
declare @w_id_catalogo int
 
select @w_id_catalogo = max(codigo) + 1 from cl_tabla
 
insert into cl_tabla (codigo, tabla, descripcion) 
values (@w_id_catalogo, 'ca_estado_pago_corresponsal', 'Estado de Pago en COBIS')
 
insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CCA', @w_id_catalogo)
 
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'T', 'Todos', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'A', 'Aplicados', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'I', 'Ingresados', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_id_catalogo, 'E', 'Error', 'V', NULL, NULL, NULL)

go

------------------------------------------------
-- catalogo sb_corresponsal_archivo
------------------------------------------------
use cobis
go

delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='sb_corresponsal_archivo')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='sb_corresponsal_archivo')
delete from cl_tabla where tabla ='sb_corresponsal_archivo'
go

declare @w_catalog_id int

select @w_catalog_id = max(codigo)+1 from cobis..cl_tabla

insert into cobis..cl_tabla
values(@w_catalog_id,'sb_corresponsal_archivo','Corresponsal Archivo')

insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CCA', @w_catalog_id)

insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'H2H_','SANTANDER','V')

go

------------------------------------------------
-- catalogo causa_rechazo
------------------------------------------------
use cobis
go

delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='causa_rechazo')
delete from cl_tabla where tabla ='causa_rechazo'
go

declare @w_catalog_id int

select @w_catalog_id = max(codigo)+1 from cobis..cl_tabla

insert into cobis..cl_tabla
values(@w_catalog_id,'causa_rechazo','causas de rechazo de transacciones en Santander')

insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id, '05', 'CUENTA CERRADA', 'V')

insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id, 'P6', 'OP. EXCEDE MONTO PERMITIDO POR BANXICO PARA DEPOSITAR', 'V')

insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id, 'X2', 'CUENTA BLOQUEADA', 'V')
go


----------------------------------------------------------
-- PARAMETRIZACION OFICINAS E INSTITUCIONES CODIGO DE BARRAS    
----------------------------------------------------------
use cobis
go


declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

SELECT @w_producto = pd_abreviatura FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla in ('cl_institution_barcodes','cl_offices_barcodes'))
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla in ('cl_institution_barcodes','cl_offices_barcodes'))
delete cl_tabla where tabla in ('cl_institution_barcodes','cl_offices_barcodes')

select @w_nom_tabla = 'cl_institution_barcodes'
select @w_id_tabla =  max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1
insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'Instituciones para codigo de barras')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'1','OXXO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'2','BANCO SANTANDER','B')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'3','ELAVON','B')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'4','OPENPAY','V')
-----

select @w_nom_tabla = 'cl_offices_barcodes'
select @w_id_tabla =  max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1
insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'Oficinas para codigo de barras')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado)  
select  @w_id_tabla as tabla,codigo,valor,estado from cl_catalogo where tabla in (9) 

go

---------------------------------------------------------------
-- RIESGOS CRED. EXTER. PERMITIDOS EN GENERACION CANDIDATOS LCR
-- RIESGOS PLD NO PERMITIDOS EN GENERACION CANDIDATOS LCR
---------------------------------------------------------------
use cobis
go

declare @w_catalog_id int


delete from cl_catalogo where tabla in (select codigo from cl_tabla where tabla in('ca_lcr_riesgo_cred_ext','ca_lcr_riesgo_pld'))
delete from cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla in('ca_lcr_riesgo_cred_ext','ca_lcr_riesgo_pld'))
delete from cl_tabla where tabla in('ca_lcr_riesgo_cred_ext','ca_lcr_riesgo_pld')

select @w_catalog_id = max(codigo)+1 from cobis..cl_tabla

insert into cobis..cl_tabla
values(@w_catalog_id,'ca_lcr_riesgo_cred_ext','RIESGOS CRED. EXTER. PERMITIDOS EN GENERACION CANDIDATOS LCR')

insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CCA', @w_catalog_id)

insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'1','A','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'2','B','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'3','C','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'4','D','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'5','E','V') --se agrega clientes amarillos Soporte #173886


-- Creacion de catalogo con las plantillas sms

use cobis
GO

declare @w_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'ns_plantilla_sms')
begin 
   delete from cobis..cl_tabla where tabla = 'ns_plantilla_sms'
   select @w_tabla = max(codigo) + 1 from cobis..cl_tabla
   INSERT INTO cobis..cl_tabla (codigo,tabla,descripcion) VALUES(@w_tabla,'ns_plantilla_sms','Plantillas SMS')
end
else
begin
   select @w_tabla = max(codigo) + 1 from cobis..cl_tabla
   INSERT INTO cobis..cl_tabla (codigo,tabla,descripcion) VALUES(@w_tabla,'ns_plantilla_sms','Plantillas SMS')
end

update cobis..cl_seqnos
set siguiente = @w_tabla + 1
where tabla = 'cl_tabla'
and bdatos = 'cobis'


delete from cl_catalogo where tabla = @w_tabla

INSERT INTO cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
VALUES(@w_tabla,'304162','Tuiio_Cuida_Situacion_Financiera','V',null,null,null)

INSERT INTO cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
VALUES(@w_tabla,'304837','Tuiio_Pago_Grupal_Proximo','V',null,null,null)

INSERT INTO cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
VALUES(@w_tabla,'304660','Tuiio_Autorizacion_Biometrica','V',null,null,null)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '50470', 'TUIIO_Descarga_la_APP_Tuiio_M+ovil_y_maneja_tu_crédito', 'V', null, null, null)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '50471', 'TUIIO_Clave_de_ingreso_Tuiio_Movil', 'V', null, null, null)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '50472', 'TUIIO_Se_Cambio_la_imagen_de_bienvenida', 'V', null, null, null)


use cobis
GO

declare @w_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'ns_bloque_sms')
begin 
   delete from cobis..cl_tabla where tabla = 'ns_bloque_sms'
   select @w_tabla = max(codigo) + 1 from cobis..cl_tabla
   INSERT INTO cobis..cl_tabla (codigo,tabla,descripcion) VALUES(@w_tabla,'ns_bloque_sms','Bloque de plantilla sms')
end
else
begin
   select @w_tabla = max(codigo) + 1 from cobis..cl_tabla
   INSERT INTO cobis..cl_tabla (codigo,tabla,descripcion) VALUES(@w_tabla,'ns_bloque_sms','Bloque de plantilla sms')
end

update cobis..cl_seqnos
set siguiente = @w_tabla + 1
where tabla = 'cl_tabla'
and bdatos = 'cobis'


delete from cl_catalogo where tabla = @w_tabla

INSERT INTO cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
VALUES(@w_tabla,'-1','NA','V',null,null,null)

INSERT INTO cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
VALUES(@w_tabla,'0','RECORDATORIO','V',null,null,null)

INSERT INTO cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
VALUES(@w_tabla,'1','COBRANZAS','V',null,null,null)

INSERT INTO cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
VALUES(@w_tabla,'2','BIOMETRICOS','V',null,null,null)

insert into cobis.dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '3', 'ENROLAMIENTO', 'V', NULL, NULL, NULL)

insert into cobis.dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '4', 'OTP', 'V', NULL, NULL, NULL)


select @w_catalog_id = max(codigo)+1 from cobis..cl_tabla

insert into cobis..cl_tabla
values(@w_catalog_id,'ca_lcr_riesgo_pld','RIESGOS PLD NO PERMITIDOS EN GENERACION CANDIDATOS LCR')

insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CCA', @w_catalog_id)

insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'1','A2','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'2','A3','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'3','CCC','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado)
values(@w_catalog_id,'4','A3 Bloqueante','V')

go

declare 
@w_tabla           int 

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cl_socio_comercial')
DELETE cl_tabla WHERE tabla = 'cl_socio_comercial'

select @w_tabla = isnull(max(codigo),0) + 1
from cl_tabla

INSERT INTO cl_tabla (codigo, tabla, descripcion) VALUES (@w_tabla, 'cl_socio_comercial', 'SOCIO COMERCIAL')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'SODI', 'SODIMAC', 'V', NULL, NULL, NULL)


update cobis..cl_seqnos
set siguiente = @w_tabla
where tabla = 'cl_tabla'


------------------------------------------------
-- catalogo para reportes
------------------------------------------------
print 'ca_sub_producto_rep'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cobis..cl_tabla (codigo, tabla,descripcion) values (@w_tabla, 'ca_sub_producto_rep', 'Sub producto para reportes' )

insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CCA', @w_catalog_id)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'GRUPAL', '0001;Grupal', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'INTERCICLO', '0003;Interciclo', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'INDIVIDUAL', '0004;Credito individual simple', 'V', NULL, NULL, NULL)

update cobis..cl_seqnos
   set siguiente = @w_tabla
 where tabla = 'cl_tabla'

---------->>>>>>>>>>REQ#194284 Dia de Pago
use cobis
GO

declare @w_tabla int

select @w_tabla = max(codigo) + 1 from cobis..cl_tabla
insert into cobis..cl_tabla (codigo,tabla,descripcion) VALUES(@w_tabla,'eli_reg_dia_pago','Pantallas donde se elimina registro día de Pago')

update cobis..cl_seqnos
set siguiente = @w_tabla + 1
where tabla = 'cl_tabla'
and bdatos = 'cobis'

insert into cl_catalogo_pro (cp_producto, cp_tabla) values ('CCA', @w_tabla)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'PANING', 'INGRESAR SOLICITUD', 'V', NULL, NULL, NULL)

go
