use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CLI'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in (
   'cl_giro_negocio',
   'cl_discapacidad',
   'cl_ingresos',
   'cl_nivel_egresos',
   'cl_categoria_AML',
   'cl_sector_economico',
   'cl_ambiente',
   'cl_tpropiedad',
   'cl_estados_ente',
   'cl_actividad_ec',
   'cl_tipo_persona',
   'cl_subsector_ec',
   'cl_depart_pais',
   'cl_carg_pub',
   'cl_fuente_ingreso',
   'cl_nacionalidad',
   'cl_rol_grupo',
   'cl_referencia_tiempo',
   'cl_recursos_credito',
   'cl_destino_credito',
   'cl_parentesco_1er',
   'cl_parentesco_2er',
   'cl_actividad',
   'cl_modulo_cliente',
   'cl_actividad_lcr',
   'cl_calificacion_riesgo_ext',
   'cl_tipo_mercado',
   'cr_segmento_riesgo',
   'cre_des_riesgo',
   'cli_eti_reg_neg',
   'cl_operaciones_inusuales',
   'cl_tipo_alerta',
   'cl_estado_alerta',
   'cl_correos_normativo',
   'cl_alertas_tlista',
   'cl_codigo_postal_suc',
   'cli_prod_reg_neg',
   'cl_correo_activar',
   'cl_respuesta_biometricos',
   'cl_actividad_profesional'
   )
go

--/////////////////////////////
delete cl_catalogo
  from cl_tabla
 where cl_tabla.codigo = cl_catalogo.tabla
  and cl_tabla.tabla in  (
   'cl_giro_negocio',
   'cl_discapacidad',
   'cl_ingresos',
   'cl_nivel_egresos',
   'cl_categoria_AML',
   'cl_sector_economico',
   'cl_ambiente',
   'cl_tpropiedad',
   'cl_estados_ente',
   'cl_actividad_ec',
   'cl_tipo_persona',
   'cl_subsector_ec',
   'cl_depart_pais',
   'cl_carg_pub',
   'cl_fuente_ingreso',
   'cl_nacionalidad',
   'cl_rol_grupo',
   'cl_referencia_tiempo',
   'cl_recursos_credito',
   'cl_destino_credito',
   'cl_parentesco_1er',
   'cl_parentesco_2er',
   'cl_actividad',
   'cl_modulo_cliente',
   'cl_actividad_lcr',
   'cl_calificacion_riesgo_ext',
   'cl_tipo_mercado',
   'cr_segmento_riesgo',
   'cre_des_riesgo',
   'cli_eti_reg_neg',
   'cl_operaciones_inusuales',
   'cl_tipo_alerta',
   'cl_estado_alerta',
   'cl_correos_normativo',
   'cl_alertas_tlista',
   'cl_codigo_postal_suc',
   'cli_prod_reg_neg',
   'cl_correo_activar',
   'cl_respuesta_biometricos',
   'cl_actividad_profesional'
   )
--/////////////////////////////
delete cl_tabla                          
 where cl_tabla.tabla in    (
   'cl_giro_negocio',
   'cl_discapacidad',
   'cl_ingresos',
   'cl_nivel_egresos',
   'cl_categoria_AML',
   'cl_sector_economico',
   'cl_ambiente',
   'cl_tpropiedad',
   'cl_estados_ente',
   'cl_actividad_ec',
   'cl_tipo_persona',
   'cl_subsector_ec',
   'cl_depart_pais',
   'cl_carg_pub',
   'cl_fuente_ingreso',
   'cl_nacionalidad',
   'cl_rol_grupo',
   'cl_referencia_tiempo',
   'cl_recursos_credito',
   'cl_destino_credito',
   'cl_parentesco_1er',
   'cl_parentesco_2er',
   'cl_actividad',
   'cl_modulo_cliente',
   'cl_actividad_lcr',
   'cl_calificacion_riesgo_ext',
   'cl_tipo_mercado',
   'cr_segmento_riesgo',
   'cre_des_riesgo',
   'cli_eti_reg_neg',
   'cl_codigo_postal_suc',
   'cli_prod_reg_neg',
   'cl_correo_activar',
   'cl_respuesta_biometricos',
   'cl_actividad_profesional'
   )
go

------------------------------------------------
-- giros de negocio
------------------------------------------------
print 'cl_giro_negocio'

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'cl_giro_negocio', 'Giros de Negocio')

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'S', 'SERVICIO', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'P', 'PRODUCCION', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'A', 'ALIMENTOS', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'E', 'EDUCACION', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'T', 'TURISMO', 'V', NULL, NULL, NULL)
GO

--/////////////////////////////////////////////////////////

------------------------------------
-- catalogo: cl_discapacidad
------------------------------------  
print 'cl_discapacidad'

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_discapacidad','Tipos de Discapacidad')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'A','AUDITIVA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'AM','AUDITIVA - MOTORA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'AMV','AUDITIVA - MOTORA - VISUAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'AV','AUDITIVA - VISUAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'M','MOTORA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'MV','MOTORA - VISUAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'V','VISUAL','V')
go
------------------------------------
-- catalogo: cl_ingresos
------------------------------------  
print 'cl_ingresos'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla,'cl_ingresos','Ingresos')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','MENOR A 2.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','2.001 A 4.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'3','4.001 A 6.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'4','6.001 A 8.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'5','8.001 A 10.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'6','10.001 A 12.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'7','12.001 A 15.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'8','15.001 A 17.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'9','17.001 A 22.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'10','22.001 A 35.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'11','MAYOR A 35.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'12','NO DETERMINADO','E')
go
------------------------------------
-- catalogo: cl_nivel_egresos
------------------------------------  
print 'cl_nivel_egresos'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_nivel_egresos','Nivel de Egresos del Cliente')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','MENOR A 2.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','2.001 A 4.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'3','4.001 A 6.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'4','6.001 A 8.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'5','8.001 A 10.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'6','10.001 A 12.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'7','12.001 A 15.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'8','15.001 A 17.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'9','17.001 A 22.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'10','22.001 A 35.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'11','MAYOR A 35.000','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'12','NO DETERMINADO','E')

go
------------------------------------
-- catalogo: cl_categoria_AML
------------------------------------  
print 'cl_categoria_AML'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_categoria_AML','CATEGORIA AML')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'A','CATEGORIA AML 1','V')

go

------------------------------------
-- catalogo: cl_sector_economico
------------------------------------  
print 'cl_sector_economico'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_sector_economico','SECTOR ECONOMICO')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'I','AGROPECUARIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'II','PRODUCCION','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'III','COMERCIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'IV','SERVICIOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'V','INGRESO FIJO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'VI','OTRAS OCUPACIONES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'VII','NO DETERMINADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'VIII','INDUSTRIA','V')
go

------------------------------------
-- catalogo: cl_ambiente
------------------------------------  
print 'cl_ambiente'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_ambiente','SECTOR ECONOMICO')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','TIENDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','ALMACEN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'3','TALLER','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'4','OFICINA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'5','PUESTO EN LA CALLE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'6','MERCADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'7','FERIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'8','AMBULANTE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'9','OTROS','V')

go
------------------------------------
-- catalogo: cl_tpropiedad
------------------------------------  
print 'cl_tpropiedad'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_tpropiedad','Tipo de Propiedad')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PRO','PROPIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'REN','RENTADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'FAM','DE FAMILIARES','V')

go
------------------------------------
-- catalogo: cl_estados_ente
------------------------------------  
print 'cl_estados_ente'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_estados_ente','ESTADOS DE CLIENTES')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'A','ACTIVO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'B','BLOQUEADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'E','ELIMINADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'I','INACTIVO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'P','PROSPECTO','V')
go

------------------------------------
-- catalogo: cl_actividad_ec
------------------------------------  
print 'cl_actividad_ec'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_actividad_ec','Actividad Economica')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01111','CULTIVO DE CEREALES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01112','CULTIVO DE OLEAGINOSAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01113','CULTIVOS SACARINOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01114','CULTIVO DE PLANTAS PARA LA OBTENCION DE FIBRAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01115','CULTIVO FORRAJERO (PARA EL PASTOREO O LA HENIFICACION, FORRAJE V',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01119','OTROS CULTIVOS NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01121','CULTIVO DE HORTALIZAS DE RAIZ Y TUBERCULO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01122','CULTIVO DE HORTALIZAS DE FLOR Y FRUTO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01123','CULTIVO DE HORTALIZAS DE HOJA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01124','CULTIVO DE HORTALIZAS DE BULBO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01125','CULTIVO DE LEGUMBRES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01126','CULTIVO DE FLORES Y PLANTAS ORNAMENTALES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01127','PRODUCCION DE SEMILLAS Y OTRAS FORMAS DE PROPAGACION DE CULTIVOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01131','CULTIVO DE FRUTAS DE CAROZO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01132','CULTIVO DE FRUTAS CITRICAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01133','CULTIVO DE FRUTAS DE PEPITA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01134','CULTIVO DE FRUTAS SECAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01135','CULTIVOS DE PLANTAS PARA BEBIDAS Y ESTIMULANTES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01136','CULTIVO DE ESPECIAS Y DE PLANTAS AROMATICAS Y MEDICINALES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01139','OTRAS FRUTAS CULTIVADAS NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01211','CRIA DE GANADO VACUNO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01212','CRIA DE GANADO OVINO, CAPRINO, Y EQUINOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01213','CRIA DE GANADO CAMELIDO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01214','PRODUCCION DE LECHE CRUDA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01221','CRIA DE AVES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01222','CRIA DE GANADO PORCINO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01223','PRODUCCION DE HUEVOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01224','APICULTURA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01229','CRIA DE ANIMALES Y OBTENCION DE PRODUCTOS DE ORIGEN ANIMAL NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'01401','ACTIVIDADES DE SERVICIOS AGRICOLAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'03002','EXTRACCION DE PRODUCTOS FORESTALES DE BOSQUES NATIVOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'03003','RECOLECCION DE PRODUCTOS FORESTALES SILVESTRES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'03004','SERVICIOS FORESTALES DE EXTRACCION DE MADERA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'05001','PESCA  LACUSTRE',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'05002','PESCA FLUVIAL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'05003','EXPLOTACION DE CRIADEROS DE PECES Y GRANJAS PISCICOLAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'11100','EXTRACCION DE PETROLEO CRUDO Y GAS NATURAL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'11200','ACTIVIDADES DE SERVICIOS RELACIONADAS CON LA EXTRACCION DE PETRO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'13201','EXTRACCION DE MINERALES METALICOS NO FERROSOS, EXCEPTO LOS MINER',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'13202','EXTRACCION DE METALES PRECIOSOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'14101','EXTRACCION DE PIEDRAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'14102','EXTRACCION DE ARENAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'14104','EXTRACCION DE PIEDRAS ORNAMENTALES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'14220','EXTRACCION DE SAL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15111','MATANZA DE GANADO BOVINO Y PROCESAMIENTO DE SU CARNE',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15112','PRODUCCION Y PROCESAMIENTO DE CARNE DE AVES DE CORRAL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15113','ELABORACION DE FIAMBRES Y EMBUTIDOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15114','MATANZA DE GANADO EXCEPTO EL BOVINO Y PROCESAMIENTO DE SU CARNE',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15131','PREPARACION DE CONSERVAS DE FRUTAS, HORTALIZAS Y LEGUMBRES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15132','ELABORACION DE JUGOS NATURALES Y SUS CONCENTRADOS, DE FRUTAS, HO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15142','ELABORACION DE ACEITES Y GRASAS VEGETALES REFINADAS Y SUBPRODUCT',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15201','ELABORACION DE LECHES Y PRODUCTOS LACTEOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15202','ELABORACION DE HELADOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15203','ELABORACION DE QUESOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15311','PREPARACION Y MOLIENDA DE TRIGO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15312','PREPARACION DE ARROZ',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15314','ELABORACION DE ALIMENTOS MEDIANTE  EL TOSTADO O INSUFLACION DE G',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15330','ELABORACION DE ALIMENTOS PREPARADOS PARA ANIMALES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15411','ELABORACION DE PAN',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15412','ELABORACION DE GALLETAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15419','ELABORACION DE OTROS PRODUCTOS DE PANADERIA Y PASTELERIA NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15420','ELABORACION DE AZUCAR',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15431','ELABORACION DE CACAO Y PRODUCTOS DE CACAO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15432','ELABORACION DE CHOCOLATES Y PRODUCTOS DE CHOCOLATE',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15433','ELABORACION DE PRODUCTOS DE CONFITERIA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15441','ELABORACION DE PASTAS ALIMENTICIAS SECAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15491','TOSTADO, TORRADO Y MOLIENDA DE CAFE',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15492','ELABORACION DE TE, HIERBAS AROMATICAS Y ESPECIAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15499','ELABORACION DE PRODUCTOS ALIMENTICIOS NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15511','DESTILACION DE ALCOHOL ETILICO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15512','DESTILACION, RECTIFICACION Y MEZCLAS DE BEBIDAS ESPIRITUOSAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15521','ELABORACION DE VINOS, BEBIDAS FERMENTADAS PERO NO DESTILADAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15530','ELABORACION DE BEBIDAS MALTEADAS Y DE MALTA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15541','ELABORACION DE BEBIDAS GASEOSAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15542','ELABORACION DE AGUAS MINERALES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15543','ELABORACION DE HIELO Y OTRAS BEBIDAS NO ALCOHOLICAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'17113','FABRICACION DE TEJIDOS DE FIBRAS TEXTILES INCLUSO SUS MEZCLAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'17120','ACABADO DE PRODUCTOS TEXTILES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'17210','FABRICACION DE ARTICULOS CONFECCIONADOS DE MATERIALES TEXTILES,',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'17220','FABRICACION DE TAPICES Y ALFOMBRAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'17230','FABRICACION DE CUERDAS, CORDELES, BRAMANTES Y REDES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'17301','FABRICACION DE MEDIAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'17302','FABRICACION DE CHOMPAS Y ARTICULOS SIMILARES DE PUNTO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'18101','FABRICACION DE PRENDAS DE VESTIR CONFECCIONADAS PARA HOMBRES, MU',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'18102','FABRICACION DE ROPA DE TRABAJO, UNIFORMES Y GUARDAPOLVOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'18103','FABRICACION DE ROPA DEPORTIVA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'18109','FABRICACION DE PRENDAS DE VESTIR DE CUERO Y OTRAS PRENDAS NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'18200','ADOBO Y TENIDO DE PIELES; FABRICACION DE ARTICULOS DE PIEL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'19110','CURTIDO DE CUEROS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'19120','FABRICACION DE ARTICULOS DE MARROQUINERIA, TALABARTERIA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'19201','FABRICACION DE CALZADO DE CUERO, EXCEPTO ORTOPEDICO Y DE ASBESTO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'19203','FABRICACION DE PARTES DE CALZADO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'20100','ASERRADO Y CEPILLADO DE MADERA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'20210','FABRICACION DE HOJAS DE MADERA PARA ENCHAPADO; DE TABLEROS CONTR',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'20220','FABRICACION DE PARTES Y PIEZAS DE CARPINTERIA PARA EDIFICIOS Y C',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'20290','FABRICACION DE OTROS PRODUCTOS DE MADERA; DE ARTICULOS DE CORCHO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'21020','FABRICACION DE PAPEL Y CARTON ONDULADO Y DE ENVASES DE PAPEL Y C',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'21091','FABRICACION DE ARTICULOS DE PAPEL DE USO DOMESTICO E HIGIENICO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'22110','EDICION DE LIBROS, FOLLETOS, PARTITURAS Y OTRAS PUBLICACIONES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'22120','EDICION DE PERIODICOS, REVISTAS Y PUBLICACIONES PERIODICAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'22190','OTRAS ACTIVIDADES DE EDICION',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'22210','ACTIVIDADES DE IMPRESION',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'22300','REPRODUCCION DE GRABACIONES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'23200','FABRICACION DE PRODUCTOS DE LA REFINACION DEL PETROLEO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'24111','FABRICACION DE GASES INDUSTRIALES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'24112','FABRICACION DE SUSTANCIAS QUIMICAS BASICAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'24220','FABRICACION DE PINTURAS, BARNICES Y PRODUCTOS DE REVESTIMIENTO S',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'24230','FABRICACION DE PRODUCTOS FARMACEUTICOS, SUSTANCIAS QUIMICAS MEDI',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'24241','FABRICACION DE JABONES Y DETERGENTES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'24242','FABRICACION DE COSMETICOS, PERFUMES, PRODUCTOS DE HIGIENE Y TOCA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'24243','FABRICACION DE PREPARADOS PARA LIMPIAR Y PULIR',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'25190','FABRICACION DE OTROS PRODUCTOS DE CAUCHO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'25201','FABRICACION DE ENVASES PLASTICOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'26101','FABRICACION DE ENVASES DE VIDRIO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'26102','FABRICACION DE VIDRIO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'26109','FABRICACION DE PRODUCTOS DE VIDRIO NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'26911','FABRICACION DE ARTICULOS DE CERAMICA DE USO DOMESTICO, SANITARIO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'26930','FABRICACION DE PRODUCTOS DE ARCILLA Y CERAMICA NO REFRACTARIAS P',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'26941','FABRICACION DE CEMENTO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'26942','FABRICACION DE CAL Y YESO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'26990','FABRICACION DE OTROS PRODUCTOS MINERALES NO METALICOS NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'27201','PRODUCCION DE METALES COMUNES NO FERROSOS EN FORMAS PRIMARIAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'28920','TRATAMIENTO Y REVESTIMIENTO DE METALES; OBRAS DE INGENIERIA MECA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'28930','FABRICACION DE ARTICULOS DE CUCHILLERIA, HERRAMIENTAS DE MANO Y',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'28999','FABRICACION DE PRODUCTOS METALICOS NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'29190','FABRICACION DE OTROS TIPOS DE MAQUINARIA DE USO GENERAL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'31300','FABRICACION DE HILOS Y CABLES AISLADOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'31500','FABRICACION DE LAMPARAS ELECTRICAS Y EQUIPO DE ILUMINACION',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'33110','FABRICACION DE EQUIPO MEDICO Y QUIRURGICO Y DE APARATOS ORTOPEDI',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'34200','FABRICACION DE CARROCERIAS PARA VEHICULOS AUTOMOTORES; FABRICACI',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'34300','FABRICACION DE PARTES, PIEZAS Y ACCESORIOS PARA VEHICULOS AUTOMO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'35920','FABRICACION DE BICICLETAS Y DE SILLONES DE RUEDAS PARA INVALIDOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'35990','FABRICACION DE OTROS TIPOS DE EQUIPO DE TRANSPORTE NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'36101','FABRICACION DE MUEBLES Y PARTES DE MUEBLES, PRINCIPALMENTE DE MA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'36102','FABRICACION DE MUEBLES Y PARTES DE MUEBLES, PRINCIPALMENTE DE ME',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'36103','FABRICACION DE MUEBLES, EXCEPTO LOS QUE SON PRINCIPALMENTE DE MA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'36104','FABRICACION DE SOMIERES Y COLCHONES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'36910','FABRICACION DE JOYAS Y ARTICULOS CONEXOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'36920','FABRICACION DE INSTRUMENTOS DE MUSICA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'36930','FABRICACION DE ARTICULOS DE DEPORTE',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'36940','FABRICACION DE JUEGOS Y JUGUETES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'36990','OTRAS INDUSTRIAS MANUFACTURERAS NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'37100','RECICLAMIENTO DE DESPERDICIOS Y DESECHOS METALICOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'37200','RECICLAMIENTO DE DESPERDICIOS Y DESECHOS NO METALICOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'40101','PRODUCCION DE ENERGIA HIDRAULICA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'40103','TRANSPORTE DE ENERGIA ELECTRICA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'40104','DISTRIBUCION DE ENERGIA ELECTRICA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'41001','CAPTACION, DEPURACION Y DISTRIBUCION DE AGUA DE FUENTES SUBTERRA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'41002','CAPTACION, DEPURACION Y DISTRIBUCION DE AGUA DE FUENTES SUPERFIC',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'45109','MOVIMIENTO DE SUELOS Y PREPARACION DE TERRENO RELLENO Y DESMONTE',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'45201','CONSTRUCCION, REFORMA Y REPARACION DE EDIFICIOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'45202','CONSTRUCCION, REFORMA Y REPARACION DE OBRAS DE INFRAESTRUCTURA D',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'45209','CONSTRUCCION DE OBRAS DE INGENIERIA CIVIL NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'45301','INSTALACION DE ASCENSORES, MONTACARGAS Y ESCALERAS MECANICAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'45302','INSTALACIONES Y MANTENIMIENTO ELECTRICO Y ELECTRONICOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'45306','INSTALACIONES DE PLOMERIA, DESAG+œES, GAS, AGUA, SANITARIOS, CON',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'45401','INSTALACIONES DE CARPINTERIA, HERRERIA DE OBRA ARTISTICA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'45402','TRABAJOS DE REVESTIMIENTO, PULIMENTO DE PAREDES Y PISOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'45403','COLOCACION DE VIDRIOS Y CRISTALES EN OBRA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'45404','PINTURA Y TRABAJOS DE DECORACION',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'45500','ALQUILER DE EQUIPO DE CONSTRUCCION Y DEMOLICION DOTADO DE OPERAR',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'50101','VENTA DE VEHICULOS AUTOMOTORES, NUEVOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'50102','VENTA DE VEHICULOS AUTOMOTORES, USADOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'50201','MANTENIMIENTO Y REPARACION DEL MOTOR; MECANICA INTEGRAL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'50202','LAVADO DE AUTOMOTORES AUTOMATICO Y MANUAL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'50203','REPARACION DE CAMARAS DE CUBIERTAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'50204','TAPIZADO Y RETAPIZADO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'50205','REPARACIONES ELECTRICAS, DEL TABLERO E INSTRUMENTAL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'50206','REPARACION, COLOCACION Y PINTADO DE CARROCERIAS; GUARDABARROS Y',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'50300','VENTA DE PARTES, PIEZAS Y ACCESORIOS DE VEHICULOS AUTOMOTORES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'50401','VENTA DE MOTOCICLETAS Y DE SUS PARTES, PIEZAS Y ACCESORIOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'50501','VENTA AL POR MENOR DE COMBUSTIBLE PARA AUTOMOTORES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'50502','VENTA AL POR MENOR DE LUBRICANTES, GRASAS Y REFRIGERANTES PARA A',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51109','VENTA AL POR MAYOR DE INTERMEDIARIOS EN COMISION O CONSIGNACION',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51211','VENTA AL POR MAYOR DE MATERIAS PRIMAS AGROPECUARIAS Y DE LA SILV',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51212','VENTA AL POR MAYOR DE ANIMALES VIVOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51222','VENTA AL POR MAYOR DE PRODUCTOS LACTEOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51223','VENTA AL POR MAYOR DE HUEVOS, ACEITES Y GRASAS COMESTIBLES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51224','VENTA AL POR MAYOR DE CARNES ROJAS, MENUDENCIAS; PRODUCTOS DE GR',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51226','VENTA AL POR MAYOR DE CAFE, TE, CACAO Y ESPECIAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51227','VENTA AL POR MAYOR DE BEBIDAS, CIGARRILLOS Y  TABACO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51228','VENTA AL POR MAYOR DE AZUCAR, DULCES, CHOCOLATES, GOLOSINAS  Y O',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51229','VENTA AL POR MAYOR DE PRODUCTOS ALIMENTICIOS NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51311','VENTA AL POR MAYOR DE PRODUCTOS TEXTILES EXCEPTO PRENDAS DE VEST',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51313','VENTA AL POR MAYOR DE PRENDAS Y ACCESORIOS DE VESTIR',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51334','VENTA AL POR MAYOR DE ARTEFACTOS PARA EL HOGAR, ELECTRICOS, A GA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51341','VENTA AL POR MAYOR DE PRODUCTOS FARMACEUTICOS Y MEDICINALES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51342','VENTA AL POR MAYOR DE PRODUCTOS DE PERFUMERIA Y DE BELLEZA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51351','VENTA AL POR MAYOR DE ARTICULOS DE OPTICA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51391','VENTA AL POR MAYOR DE MATERIALES Y PRODUCTOS DE LIMPIEZA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51411','VENTA AL POR MAYOR DE COMBUSTIBLES Y LUBRICANTES PARA AUTOMOTORE',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51412','VENTA AL POR MAYOR DE COMBUSTIBLES Y LUBRICANTES EXCEPTO PARA AU',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51431','VENTA AL POR MAYOR DE MATERIALES DE CONSTRUCCION',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51491','VENTA AL POR MAYOR DE PRODUCTOS QUIMICOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51501','VENTA AL POR MAYOR DE MAQUINAS, EQUIPOS E IMPLEMENTOS DE USO  AG',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51900','VENTA AL POR MAYOR DE OTROS PRODUCTOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52111','VENTA AL POR MENOR EN SUPERMERCADOS CON SURTIDO COMPUESTO Y PRED',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52112','VENTA AL POR MENOR EN ALMACENES CON SURTIDO COMPUESTO Y PREDOMIN',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52113','VENTA AL POR MENOR EN TIENDAS DE BARRIO  CON SURTIDO COMPUESTO Y',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52190','VENTA AL POR MENOR DE OTROS PRODUCTOS EN ALMACENES NO ESPECIALIZ',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52201','VENTA AL POR MENOR Y EMPAQUE DE FRUTAS, LEGUMBRES Y HORTALIZAS F',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52202','VENTA AL POR MENOR DE PRODUCTOS LACTEOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52203','VENTA AL POR MENOR DE HUEVOS, ACEITES Y GRASAS COMESTIBLES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52204','VENTA AL POR MENOR DE CARNES ROJAS, MENUDENCIAS; PRODUCTOS DE GR',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52205','VENTA AL POR MENOR DE PAN, PRODUCTOS DE CONFITERIA, PASTAS FRESC',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52206','VENTA AL POR MENOR DE CAFE, TE, CACAO Y ESPECIAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52207','VENTA AL POR MENOR DE BEBIDAS, CIGARRILLOS Y  TABACO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52208','VENTA AL POR MENOR DE AZUCAR, DULCES, CHOCOLATES, GOLOSINAS Y OT',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52311','VENTA AL POR MENOR DE PRODUCTOS FARMACEUTICOS Y MEDICINALES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52312','VENTA AL POR MENOR DE COSMETICOS, ARTICULOS DE TOCADOR Y PERFUME',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52313','VENTA AL POR MENOR DE ARTICULOS MEDICOS, ODONTOLOGICOS Y APARATO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52321','VENTA AL POR MENOR DE PRODUCTOS TEXTILES, EXCEPTO PRENDAS DE VES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52322','VENTA AL POR MENOR DE CONFECCIONES PARA EL HOGAR',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52323','VENTA AL POR MENOR DE PRENDAS Y ACCESORIOS DE VESTIR',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52324','VENTA AL POR MENOR DE CALZADO, EXCEPTO EL ORTOPEDICO, ARTICULOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52331','VENTA AL POR MENOR DE MUEBLES, ARTICULOS DE MIMBRE Y CORCHO; COL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52333','VENTA AL POR MENOR DE ARTICULOS DE BAZAR Y MENAJE',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52334','VENTA AL POR MENOR DE ARTEFACTOS PARA EL HOGAR, ELECTRICOS, A GA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52335','VENTA AL POR MENOR DE INSTRUMENTOS MUSICALES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52336','VENTA AL POR MENOR DE EQUIPOS DE SONIDO, CASETES DE AUDIO, VIDEO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52339','VENTA AL POR MENOR DE ARTICULOS PARA EL HOGAR NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52341','VENTA AL POR MENOR DE MATERIALES DE CONSTRUCCION',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52342','VENTA AL POR MENOR DE ARTICULOS DE FERRETERIA, FONTANERIA Y CALE',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52343','VENTA AL POR MENOR DE PINTURA Y PRODUCTOS CONEXOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52344','VENTA AL POR MENOR DE CRISTALES, ESPEJOS Y MAMPARAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52351','VENTA AL POR MENOR DE LIBROS, REVISTAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52352','VENTA AL POR MENOR DE PERIODICOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52359','VENTA AL POR MENOR DE PAPEL, CARTON, MATERIALES DE EMBALAJE Y AR',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52362','VENTA AL POR MENOR DE EQUIPOS INFORMATICOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52363','VENTA AL POR MENOR DE MAQUINAS Y EQUIPOS DE COMUNICACIONES, CONT',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52371','VENTA AL POR MENOR DE FLORES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52381','VENTA AL POR MENOR DE ARTICULOS DE OPTICA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52384','VENTA AL POR MENOR DE ARTICULOS DE JOYERIA Y FANTASIAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52391','VENTA AL POR MENOR DE MATERIALES Y PRODUCTOS DE LIMPIEZA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52392','VENTA AL POR MENOR DE JUGUETES Y ARTICULOS DE COTILLON',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52393','VENTA AL POR MENOR DE ARTICULOS DE ESPARCIMIENTO Y DEPORTES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52394','VENTA AL POR MENOR DE BICICLETAS Y RODADOS SIMILARES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52396','VENTA AL POR MENOR DE ARTICULOS ARTESANALES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52399','VENTA AL POR MENOR DE OTROS PRODUCTOS EN ALMACENES ESPECIALIZADO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52401','VENTA AL POR MENOR DE MUEBLES USADOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52403','VENTA AL POR MENOR DE PRENDAS DE VESTIR Y PRODUCTOS  TEXTILES US',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52409','VENTA AL POR MENOR EN ALMACENES DE ARTICULOS USADOS NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52520','VENTA AL POR MENOR EN PUESTOS DE VENTA Y MERCADOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52601','REPARACION DE CALZADOS Y ARTICULOS DE MARROQUINERIA Y OTROS ARTI',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52602','REPARACION DE ARTICULOS ELECTRICOS DE USO DOMESTICO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52603','REPARACION Y TAPIZADO DE MUEBLES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52609','REPARACION DE EFECTOS PERSONALES Y ENSERES DOMESTICOS NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55101','SERVICIOS DE ALOJAMIENTO EN HOTELES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55102','SERVICIOS DE ALOJAMIENTO EN RESIDENCIAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55103','SERVICIOS DE ALOJAMIENTO EN HOSPEDAJES Y OTROS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55104','SERVICIOS DE ALOJAMIENTO EN MOTELES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55201','SERVICIOS DE EXPENDIO DE COMIDAS EN ESTABLECIMIENTOS CON SERVICI',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55202','SERVICIO DE EXPENDIO DE COMIDAS EXCLUSIVO EN CHURRASQUERIAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55203','SERVICIO DE EXPENDIO DE COMIDAS EXCLUSIVO EN POLLOS BROASTER',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55204','SERVICIO DE EXPENDIO DE COMIDAS EXCLUSIVO EN PESCADO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55205','SERVICIO, PREPARACION Y VENTA DE COMIDAS RAPIDAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55206','SERVICIOS DE EXPENDIO DE COMIDAS EN ESTABLECIMIENTOS FIJOS O MOV',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55209','OTROS SERVICIOS DE EXPENDIO DE COMIDAS NCP.',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55212','SERVICIOS DE EXPENDIO DE BEBIDAS ALCOHOLICAS EN WHISKERIAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55215','SERVICIO DE HELADERIAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55216','SERVICIO DE EXPENDIO DE JUGOS, ZUMOS Y ENSALADAS DE FRUTAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'60100','SERVICIO DE TRANSPORTE FERROVIARIO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'60211','SERVICIO DE TRANSPORTE AUTOMOTOR URBANO DE PASAJEROS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'60212','SERVICIO DE TRANSPORTE AUTOMOTOR SUBURBANO DE PASAJEROS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'60221','SERVICIOS DE ALQUILER DE AUTOMOTORES CON CONDUCTOR',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'60222','OTROS SERVICIOS DE TRANSPORTE NO REGULAR DE PASAJEROS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'60230','SERVICIO DE TRANSPORTE AUTOMOTOR DE CARGA POR CARRETERA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'60300','SERVICIO DE TRANSPORTE POR TUBERIAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'61200','TRANSPORTE POR VIAS DE NAVEGACION INTERIORES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'62101','SERVICIO DE TRANSPORTE AEREO REGULAR DE PASAJEROS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'62102','SERVICIO DE TRANSPORTE AEREO REGULAR DE CARGA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'63010','SERVICIOS DE MANIPULACION DE LA CARGA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'63031','SERVICIOS DE EXPLOTACION DE INFRAESTRUCTURA; PEAJES Y OTROS DERE',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'63041','SERVICIOS DE AGENCIAS DE VIAJES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'63042','SERVICIOS COMPLEMENTARIOS DE APOYO TURISTICO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'64120','SERVICIOS DE CORREO DISTINTA A LAS ACTIVIDADES DE CORREO NACIONA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'64201','SERVICIOS DE TRANSMISION DE DATOS Y MENSAJES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'64202','SERVICIO DE TRANSMISION DE RADIO Y TELEVISION',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'64209','SERVICIOS DE TRANSMISION DE SONIDO, IMAGENES, DATOS U OTRA INFOR',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'65191','SERVICIOS DE LAS ENTIDADES BANCARIAS (SERVICIO)',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'651919','SERVICIOS DE LAS ENTIDADES BANCARIAS (INGRESOS FIJOS)',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'65193','SERVICIOS DE LAS COOPERATIVAS DE AHORRO Y CREDITO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'65910','ARRENDAMIENTO FINANCIERO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'65920','OTROS SERVICIOS DE CREDITO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'65990','OTRO TIPO DE SERVICIOS DE INTERMEDIACION FINANCIERA NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'66010','SERVICIO DE PLANES DE SEGUROS DE VIDA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'66020','ADMINISTRACION DE FONDOS DE JUBILACIONES Y PENSIONES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'66030','SERVICIOS DE OTROS PLANES DE SEGUROS EXCEPTO DE VIDA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'67120','SERVICIOS BURSATILES DE MEDIACION O POR CUENTA DE TERCEROS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'67191','SERVICIOS DE CASAS Y AGENCIAS DE CAMBIO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'67199','OTROS SERVICIOS AUXILIARES DE LA INTERMEDIACION FINANCIERA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'67201','SERVICIOS AUXILIARES A LOS SERVICIOS DE SEGUROS Y DE ADMINISTRAC',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'70100','SERVICIOS INMOBILIARIOS DE COMPRA, VENTA Y ALQUILER',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'70201','SERVICIOS DE ADMINISTRACION INMOBILIARIA DE BIENES INMUEBLES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'71110','ALQUILER DE EQUIPO DE TRANSPORTE POR VIA TERRESTRE SIN PERSONAL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'71120','ALQUILER DE EQUIPO DE TRANSPORTE POR VIA ACUATICA SIN PERSONAL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'71210','ALQUILER DE MAQUINARIA Y EQUIPO AGROPECUARIO SIN PERSONAL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'71290','ALQUILER DE OTROS TIPOS DE MAQUINARIA Y EQUIPO SIN PERSONAL NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'71300','ALQUILER DE EFECTOS PERSONALES Y ENSERES DOMESTICOS NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'72200','SERVICIOS DE CONSULTORES EN INFORMATICA Y SUMINISTRO DE PROGRAMA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'72900','OTRAS ACTIVIDADES DE INFORMATICA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'73101','SERVICIO DE INVESTIGACION Y DESARROLLO EN CIENCIAS NATURALES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'73102','SERVICIO DE INVESTIGACION Y DESARROLLO EN INGENIERIA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'73200','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LAS CIE',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'74110','SERVICIOS JURIDICOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'74120','SERVICIOS DE CONTABILIDAD, TENEDURIA DE LIBROS Y AUDITORIA; ASES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'74211','SERVICIOS DE ARQUITECTURA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'74212','SERVICIOS DE INGENIERIA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'74219','OTROS SERVICIOS DE ACTIVIDADES TECNICAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'74300','SERVICIOS DE PUBLICIDAD',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'74910','OBTENCION Y DOTACION DE PERSONAL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'74930','SERVICIOS DE LIMPIEZA DE EDIFICIOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'74940','SERVICIOS DE FOTOGRAFIA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'74960','SERVICIOS DE FOTOCOPIAS, IMPRESION HELIOGRAFICA Y OTRAS FORMAS D',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'74990','OTROS SERVICIOS EMPRESARIALES NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'75110','ADMINISTRACION PUBLICA (SERVICIOS)',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'751109','ADMINISTRACION PUBLICA  (INGRESO FIJO)',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'75232','ACTIVIDADES DE SERVICIOS DE ORDEN PUBLICO Y DE SEGURIDAD (SERVIC',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'752329','ACTIVIDADES DE SERVICIOS DE ORDEN PUBLICO Y DE SEGURIDAD  (INGRE',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'75300','ACTIVIDADES DE PLANES DE SEGURIDAD SOCIAL DE AFILIACION OBLIGATO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'80101','EDUCACION INICIAL  (SERVICIOS)',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'801018','EDUCACION INICIAL PUBLICA (INGRESO FIJO)',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'801019','EDUCACION INICIAL PRIVADA (INGRESO FIJO)',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'80301','FORMACION SUPERIOR NO UNIVERSITARIA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'80302','EDUCACION SUPERIOR UNIVERSITARIA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'80303','EDUCACION SUPERIOR DE ESPECIALIZACION Y POSTGRADO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'85110','SERVICIOS HOSPITALARIOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'85121','SERVICIO DE ATENCION MEDICA EN CLINICAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'85122','SERVICIOS DE CONSULTAS MEDICAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'85123','SERVICIOS DE ODONTOLOGIA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'85199','OTROS SERVICIOS RELACIONADOS CON LA SALUD HUMANA NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'85200','SERVICIOS VETERINARIOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'85319','OTROS SERVICIOS DE ASISTENCIA SOCIAL CON ALOJAMIENTO NCP',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'90002','SERVICIOS DE LIMPIEZA DE VIAS PUBLICAS Y TRATAMIENTO DE DESECHOS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'91110','SERVICIOS DE ORGANIZACIONES EMPRESARIALES Y DE EMPLEADORES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'91120','SERVICIOS DE ORGANIZACIONES PROFESIONALES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'91200','SERVICIOS DE SINDICATOS (SERVICIOS)',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'912008','SERVICIOS DE SINDICATOS (PRIVADAS INGRESOS FIJOS)',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'912009','SERVICIOS DE SINDICATOS  (INDUSTRIALES INGRESOS FIJOS)',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'91910','SERVICIOS DE ORGANIZACIONES RELIGIOSAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'92110','PRODUCCION Y DISTRIBUCION DE FILMES Y CINTAS DE VIDEO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'92120','EXHIBICION DE FILMES Y VIDEOCINTAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'92132','SERVICIOS DE PROGRAMAS DE TELEVISION',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'92141','CREACION E INTERPRETACION ARTISTICA Y LITERARIA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'92143','OTRAS ACTIVIDADES RELACIONADAS CON EL ESPECTACULO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'92191','SERVICIOS DE SALONES DE BAILE, DISCOTECAS Y SIMILARES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'92320','SERVICIOS DE MUSEOS Y PRESERVACION DE LUGARES Y EDIFICIOS HISTOR',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'92330','SERVICIOS DE JARDINES BOTANICOS Y ZOOLOGICOS Y DE PARQUES NACION',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'92412','SERVICIOS PRESTADOS POR ESCUELAS, PROFESIONALES Y TECNICOS, PARA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'93010','SERVICIOS DE LAVADO Y LIMPIEZA DE PRENDAS DE TELA Y DE PIEL, INC',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'93020','SERVICIOS DE PELUQUERIA Y OTROS TRATAMIENTOS DE BELLEZA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'93030','SERVICIOS FUNERARIOS Y ACTIVIDADES CONEXAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'93091','SERVICIO PARA EL MANTENIMIENTO FISICO-CORPORAL',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'95000','SERVICIO DE HOGARES PRIVADOS QUE CONTRATAN SERVICIO DOMESTICO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'98000','SERVICIO DE ORGANIZACIONES Y ORGANOS EXTRATERRITORIALES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'99001','JUBILADOS O RENTISTAS',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'99002','ESTUDIANTES',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'99003','AMAS DE CASA',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'99999','OTRAS ACTIVIDADES DE DESTINO',	'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1001', 'ALQUILER DE MOBILIARIO Y/O EQUIPO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1002', 'PAPELERIA Y MERCERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1003', 'PARTES Y REFACCIONES PARA AUTOMOVILES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1004', 'ROPA Y ACCESORIOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1005', 'ZAPATERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1006', 'VENTA DE ALIMENTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1007', 'ANTOJITOS Y PREPARACION DE ALIMENTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1008', 'VENTA DE CATALOGOS (ZAPATOS,ROPA,MAQUILLAJE,BLANCOS,ETC)', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1009', 'MUEBLES PARA HOGAR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1010', 'TELEFONIA Y ELECTRONICA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1011', 'ARTICULOS USUADOS Y RECICLAJE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1012', 'FERRETERIA, TLAPALERIA Y VIDRIERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1013', 'FARMACIAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1014', 'ABARROTES Y CREMERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1015', 'CARNICERIA, PESCADERIA Y POLLERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1016', 'TALLER MECANICO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1017', 'TALLER DE REPARACION APARATOS ELECTRICOS Y ELECTRONICOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1018', 'LAVANDERIA, TINTORERIA Y PLANCHADURIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1019', 'AUTOLAVADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1020', 'PROFESIONES Y OFICIOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1021', 'DULCERIA Y ARTICULO PARA FIESTAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1022', 'VENTA DE HELADOS Y PALETAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1023', 'PAN Y PASTELES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1024', 'TORTILLERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1025', 'ARTESANIAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1026', 'JOYERIA Y BISUTERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1027', 'FRUTAS Y VERDURAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1028', 'COSTURA Y BORDADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1029', 'VENTA DE ARTICULOS DE HOGAR Y LIMPIEZA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1030', 'FLORES Y REGALOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1031', 'CULTIVOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1032', 'SERVICIOS DE INTERNET', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1033', 'PLASTICOS Y DESECHABLES', 'V')

go


------------------------------------
-- catalogo: cl_tipo_persona
------------------------------------  
print 'cl_tipo_persona'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_tipo_persona','Tipos Persona')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'C','PERSONA JURIDICA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'P','PERSONA NATURAL','V')
go

------------------------------------
-- catalogo: cl_subsector_ec
------------------------------------  
print 'cl_subsector_ec'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_subsector_ec','Subsector Economico')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'A','AGRICULTURA Y GANADERIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'B','CAZA, SILVICULTURA Y PESCA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'C','EXTRACCION DE PETROLEO CRUDO Y GAS NATURAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'D','MINERALES METALICOS Y NO METALICOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'E','INDUSTRIA MANUFACTURERA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'F','PRODUCCION Y DISTRIBUCION DE ENERGIA ELECTRICA, GAS Y AGUA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'G','CONSTRUCCION','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'H','VENTA AL POR MAYOR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'I','TRANSPORTE, ALMACENAMIENTO Y COMUNICACIONES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'J','INTERMEDIACION FINANCIERA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'K','SERVICIOS INMOBILIARIOS, EMPRESARIALES Y DE ALQUILER','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'L','ADMINISTRACION PUBLICA, DEFENSA Y SEGURIDAD SOCIAL OBLIGATORIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'M','HOTELES Y RESTAURANTES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'N','EDUCACION','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ND','NO DETERMINADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'O','SERVICIOS SOCIALES, COMUNALES Y PERSONALES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'Q','SERVICIO DE ORGANIZACIONES Y ORGANOS EXTRATERRITORIALES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'S','VENTA AL POR MENOR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'W','INGRESOS FIJOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'Z','ACTIVIDADES ATIPICAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'U', 'COMERCIO', 'V')
go

------------------------------------
-- catalogo: cl_depart_pais
------------------------------------  
print 'cl_depart_pais'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_depart_pais','Departamentos para paises')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','FLORIDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'10','CORDOVA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'100','BARCELONA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','NEW YORK','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'3','WASHINGTON DC','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'BE','BENI','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'CB','COCHABAMBA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'CH','CHUQUISACA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'EE','EMITIDO EXTRANJERO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'LP','LA PAZ','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'OR','ORURO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PA','PANDO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PO','POTOSI','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'SC','SANTA CRUZ','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'TJ','TARIJA','V')
go

------------------------------------
-- catalogo: cl_carg_pub
------------------------------------  
print 'cl_carg_pub'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_carg_pub','Cargo publico')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','SERVIDOR PUBLICO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','EMBAJADOR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'3','OTROS','V')
go

------------------------------------
-- catalogo: cl_fuente_ingreso
------------------------------------  
print 'cl_fuente_ingreso'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla,'cl_fuente_ingreso','Fuentes de Ingreso')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'EM','EMPLEO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'TE','TERCEROS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'RE','REMESAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'OT','OTROS','V')
go

------------------------------------
-- catalogo: cl_nacionalidad
------------------------------------  
print 'cl_nacionalidad'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_nacionalidad','Nacionalidad')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','MEXICANA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','EXTRANJERA','V')
go
------------------------------------
-- catalogo: cl_parentesco_1er
------------------------------------ 
print 'cl_parentesco_1er'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_parentesco_1er','Parentesco Primer Grado')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'209','CONYUGUE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'210','HIJO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'211','PADRE','V')
go
------------------------------------
-- catalogo: cl_parentesco_2er
------------------------------------ 
print 'cl_parentesco_2er'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_parentesco_2er','Parentesco Segundo Grado')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'212','HERMANO','V')
go
------------------------------------------------
-- catalogo cl_actividad
------------------------------------------------
print 'cl_actividad'

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'cl_actividad', 'ACTIVIDAD')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7512016', 'AGENCIA DE TURISMO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6992011', 'C/V DE LOTERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8711013', 'CAFETERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8831019', 'CENTRO NOCTURNO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6911029', 'C/V DE CASAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6991013', 'C/V DE ARMAS DE FUEGO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6622022', 'C/V ART FERRETERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6211015', 'C/V LENCERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6215017', 'MERCERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6325030', 'C/V ART PARA REGALO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6325048', 'C/V ARTESANIAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6811013', 'C/V DE AUTOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6812011', 'C/V DE AUTOS USADOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6212013', 'C/V CALZADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6124010', 'POLLERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6911045', 'C/V DE CASAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6999017', 'C/V DE DIAMANTES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6323018', 'C/V DISCOS Y CASSETTES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6132013', 'C/V DE DULCES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6721036', 'C/V ART DE COMPUTACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6326020', 'FLORERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6112015', 'C/V DE FRUTAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6223010', 'C/V DE JUGUETES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6132039', 'C/V DE LECHE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6112023', 'C/V DE VERDURAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6629010', 'C/V MATERIALES PARA CONSTRUCCIÓN', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6231013', 'COMPRAVENTA DE MEDICINAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6312011', 'COMPRAVENTA DE MUEBLES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6225024', 'C/V DE JOYAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6419015', 'C/V APARATOS ELECTRÓNICOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6329016', 'C/V ARTICULOS PARA EL HOGAR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6119011', 'VENTA DE PRODUCTOS NATURALES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6132047', 'C/V DE LACTEOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6216023', 'C/VPRODUCTOS TEXTILES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6132055', 'PANADERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6233019', 'PAPELERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6231021', 'C/V DE PERFUES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6126032', 'C/V DE PESCADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6623020', 'C/V DE PINTURAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6815015', 'C/V REFACCIONES DE AUTO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6134019', 'C/V DE REFRESCOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6225032', 'C/V RELOJES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6211023', 'C/V DE ROPA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6111017', 'C/V DE SEMILLAS Y GRANOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6911053', 'C/V DE TERRENOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3319010', 'ALFARERIA Y CERAMICA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9501009', 'EMPLEADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9502007', 'EMPLEADO GOBIERNO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8429046', 'TRANSPORTE DE VALORES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3997014', 'FABRICACIÓN DE ARMAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3932010', 'FABRICACION ART DE JOYERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3933018', 'C/V BISUTERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3921013', 'FABRICACION REFLOJES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8800002', 'JUEGOS DE FERIA Y APUESTAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8934011', 'LAVANDERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2023018', 'MOLINO DE NIXTAMAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8200001', 'CASA DE EMPEÑO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9504003', 'CYBERCAFE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8714017', 'NEVERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8400003', 'NOTARÍAS PÚBLICAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8711021', 'RESTAURANTE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8933013', 'SALON DE BELLEZA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6800003', 'BLINDAJE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8411019', 'NOTARÍAS PÚBLICAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8719017', 'C/V DE ANTOJITOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '04200002', 'CARPINTERO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3932036', 'PIEDRAS PRECIOSAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3516054', 'HERRERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3591022', 'HOJALATERÍA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4221016', 'PROMERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8921018', 'REPARACIÓN DE CALZADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8929020', 'SASTRE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8911019', 'MECANICO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2412039', 'SASTRE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6131023', 'ABARROTES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8934029', 'TINTORERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2093011', 'TORTILLERIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7113012', 'TAXISTA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3212024', 'VULCANIZADORA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2413011', 'UNIFORMES Y ROPA DE TRABAJO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6512017', 'C/V DE GAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6216031', 'C/V TELAS Y CASIMIRES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6133029', 'C/V ALIMENTO PARA ANIMALES', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6122014', 'CARNICERIA', 'V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6325030', 'TIENDA DE REGALOS', 'V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6132047', 'CREMERIA', 'V')
--insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6231021', 'C/V PERFUMES Y COSMETICOS', 'V')
go

------------------------------------------------
-- roles del grupo
------------------------------------------------
print 'cl_rol_grupo'

declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'cl_rol_grupo', 'Roles del Grupo')

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'M', 'INTEGRANTE', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'P', 'PRESIDENTE', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'T', 'TESORERO', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'S', 'SECRETARIO', 'V', NULL, NULL, NULL)
go

------------------------------------
-- catalogo: cl_referencia_tiempo
------------------------------------  
print 'cl_referencia_tiempo'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_referencia_tiempo','TIEMPO REFERENCIAL')


insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1', '1', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '2', '2', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '3', '3', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '4', '4', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '5', '5 O MAS', 'V')
go


------------------------------------
-- catalogo: cl_recursos_credito
------------------------------------  
print 'cl_recursos_credito'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla,'cl_recursos_credito','Recursos Pago Credito')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'NP','NEGOCIO PROPIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'SP','SALARIO O PENSIÓN','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'AS','BECA O APOYO SOCIAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'AI','AHORRO E INVERSIONES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PR','PRÉSTAMOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'RT','RECURSOS DE TERCERO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'RF','RECURSOS DE FAMILIARES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'RB','RENTA DE BIENES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'VB','VENTA DE BIENES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'HE','HERENCIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PS','PREMIOS O SORTEOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'OT','OTROS','V')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'TE','TERCEROS','E')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'AF','APOYO FAMILIAR','E')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ED','ENVIO DE DINERO','E')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PE','PENSION','E')
go


------------------------------------
-- catalogo: cl_destino_credito
------------------------------------  
print 'cl_destino_credito'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_destino_credito','Destino del Credito')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'CA','COMPRA DE ACTIVO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'CT','CAPITAL DE TRABAJO','V')

go
------------------------------------
-- catalogo: cl_modulo_cliente
------------------------------------  

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla values (@w_tabla, 'cl_modulo_cliente', 'Modulos de Clientes')

--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'INFORMACION GENERAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'DIRECCIONES Y CORREO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'NEGOCIOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'REFERENCIAS', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'DOCUMENTOS DIGITALIZADOS', 'V')

------------------------------------
-- catalogo: cl_actividad_lcr
------------------------------------  

select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_actividad_lcr', 'Actividades no permitidas para LCR')
--Insertando Catalogos

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '7512016', 'AGENCIA DE TURISMO', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '6800003', 'BLINDAJE', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '6811013', 'C/V DE AUTOS', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '6812011', 'C/V DE AUTOS USADOS', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '6911045', 'C/V DE CASAS', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '6999017', 'C/V DE DIAMANTES', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '6992011', 'C/V DE LOTERIA', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '9501009', 'EMPLEADO', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '3921013', 'FABRICACION REFLOJES', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '8400003', 'NOTARÍAS PÚBLICAS', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '8411019', 'NOTARÍAS PÚBLICAS', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '3932036', 'PIEDRAS PRECIOSAS', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '7113012', 'TAXISTA', 'V', null, null, null)

------------------------------------
-- catalogo: cr_segmento_riesgo
------------------------------------
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla,'cr_segmento_riesgo','TIPO DE SEGMENTOS DE RIESGO')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0018', 'Premier MSP Premier - Membresía Santander Premier', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0051', 'Premier Premier', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0070', 'Select Select', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0071', 'Select Red Select Red', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0012', 'Select Patrimonial Select Patrimonial', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0004', 'RME Renta Media', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0017', 'RME Renta Media', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0027', 'RME Renta Media', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0022', 'RME Renta Media', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0054', 'RME Renta Media', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0053', 'RME Renta Media', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0019', 'RME Renta Media', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0050', 'RMA N Renta Masiva - Cliente Nuevo', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0007', 'RMA A Renta Masiva - Cliente Nuevo Altas Masivas', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0020', 'RMA RA Renta Masiva - Rentabilidad Alta', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0055', 'RMA RM Renta Masiva - Rentabilidad Media', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0056', 'RMA RS Renta Masiva - Rentabilidad Baja', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0067', 'Select Nuevo Select Nuevo', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0068', 'Premier Nuevo Premier Nuevo', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0025', 'SuperDigital Cuenta digital', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1060', 'Supercuenta con Débito', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1760', 'Supercuenta Blindada', 'V')

------------------------------------
-- catalogo: cre_des_riesgo
------------------------------------  
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla,'cre_des_riesgo','DESCRIPCION MATRIZ RIESGO')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','Actividad económica','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','Zona geográfica','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','Nacionalidad','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'004','Segmento','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'005','Producto','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'006','PEP','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'007','Origen de Recursos','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'008','Destino de Recursos','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'009','Transferencias Internacionales','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'010','Compra-venta divisas','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'011','Transaccionalidad','V') 

------------------------------------------------
-- Actualizacion secuencial tabla de catalogos
------------------------------------------------
update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in (
   'cl_giro_negocio',
   'cl_discapacidad',
   'cl_ingresos',
   'cl_nivel_egresos',
   'cl_categoria_AML',
   'cl_sector_economico',
   'cl_ambiente',
   'cl_tpropiedad',
   'cl_estados_ente',
   'cl_actividad_ec',
   'cl_tipo_persona',
   'cl_subsector_ec',
   'cl_depart_pais',
   'cl_carg_pub',
   'cl_fuente_ingreso',
   'cl_nacionalidad',
   'cl_rol_grupo',
   'cl_referencia_tiempo',
   'cl_recursos_credito',
   'cl_destino_credito',
   'cl_parentesco_1er',
   'cl_parentesco_2er',
   'cl_actividad',
   'cl_modulo_cliente',
   'cl_actividad_lcr',
   'cr_segmento_riesgo',
   'cre_des_riesgo'
   
   )
go






------------------------------------------------
-- observaciones del workflow
------------------------------------------------

delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CWF'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in ('wf_observacion')
go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in  
   ('wf_observacion')
and cl_tabla.codigo = cl_catalogo.tabla


go

delete cl_tabla                          
 where cl_tabla.tabla in 
   ('wf_observacion')
go

PRINT 'wf_observacion'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla, 'wf_observacion', 'OBSERVACIONES WORKFLOW')

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, '4', 'Observaciones del Asesor', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, '5', 'Observaciones del Oficial', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, '6', 'Observaciones de Riesgo', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, '7', 'Observaciones de Dpto Legal', 'V', NULL, NULL, NULL)

insert into cl_catalogo_pro
select 'CWF', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('wf_observacion')
 
go
------------------------------------
-- catalogo: cr_doc_digitalizado
------------------------------------  
print 'cr_doc_digitalizado'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla,'cr_doc_digitalizado','Documentos digitalizados')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','CONTRATO INDIVIDUAL PARA CREDITOS INDIVIDUALES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','PAGARES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','AVISOS DE PRIVACIDAD','V')
go

------------------------------------------------
-- CATALOGO Riesgo Individual externo
------------------------------------------------
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_calificacion_riesgo_ext', 'Calificacion Riesgo Individual Externo')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'A', 'A', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'B', 'B', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'C', 'C', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'D', 'D', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'E', 'E', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'F', 'F', 'V', null, null, null)


-------------------------------
--CATALOGO DE cl_tipo_mercado--
-------------------------------
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_tipo_mercado', 'Tipo de Mercado')

--Insertando Catalogos
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'AV', 'AVON', 'X', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'CC', 'MERCADO CERRADO', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'GOB', 'GOBIERNO', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'I', 'MERCADO ABIERTO', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'ID', 'INDEPENDIENTE COLECTIVO', 'X', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'MAG', 'MAGNUS', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'SODI', 'SODIMAC', 'X', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'SR', 'SUPER RED', 'X', NULL, NULL, NULL)

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_calificacion_riesgo_ext', 'cl_tipo_mercado')
go
------------------------------------
-- catalogo: cli_eti_reg_neg
------------------------------------ 
print 'cli_eti_reg_neg'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla,'cli_eti_reg_neg','ETIQUETA REGLA NEGOCIO')
insert into cl_catalogo_pro values ('CLI', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','AML_MXN_300','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','AML_PAN_1','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'3','AML_MXN_1000+','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'4','AML_USD_100','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'5','TIF_MXN_100','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'6','AML_MOEXT_500','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'7','AML_PETRA','V')  

go

------------------------------------
-- catalogo: cl_operaciones_inusuales
------------------------------------ 

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'cl_operaciones_inusuales', 'Tipos de Operaciones Inusuales')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'IP', 'INTERNA PREOCUPANTE', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'I', 'INUSUAL', 'V', NULL, NULL, NULL)

------------------------------------
-- catalogo: cl_tipo_alerta
------------------------------------ 
select @w_tabla = @w_tabla + 1
--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'cl_tipo_alerta', 'Tipos de Alertas')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'LN', 'LISTAS NEGRAS', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'NF', 'NEGATIVE FILE', 'V', NULL, NULL, NULL)

go

------------------------------------
-- catalogo: cl_estado_alerta
------------------------------------ 

select @w_tabla = @w_tabla + 1
--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_estado_alerta', 'Estado de Alertas')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'EI', 'EN INVESTIGACION', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'NR', 'DICTAMINADO NO REPORTAR', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'SR', 'DICTAMINADO SI REPORTAR', 'V', NULL, NULL, NULL)

go

------------------------------------
-- catalogo: cl_correos_normativo
------------------------------------ 

select @w_tabla = @w_tabla + 1
--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_correos_normativo', 'Correos del rol Normativo')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, '3', 'adriana.chiluisa@cobiscorp.com', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, '4', 'adriana.chiluisa@cobiscorp.com', 'V', NULL, NULL, NULL)

go
------------------------------------
-- catalogo: cl_alertas_tlista
------------------------------------ 

select @w_tabla = @w_tabla + 1
--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_alertas_tlista', 'Correos del rol Normativo')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'R',  'Relevante', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'I',  'Inusual', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'IP', 'Internas preocupantes', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'LI', 'Lista negra', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'NF', 'Negative file', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'NR', 'Nivel de Riesgo', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'C',  'Condicionado', 'V', NULL, NULL, NULL)

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_operaciones_inusuales',   'cl_tipo_alerta',   'cl_estado_alerta',
                          'cl_correos_normativo',       'cl_alertas_tlista')
-----------------------
--catalogo:cl_codigo_postal_suc
-----------------------						  
select @w_tabla = @w_tabla + 1
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla,'cl_codigo_postal_suc', 'CODIGO POSTAL SUCURSAL')	
--insertando catalogos
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '99'  , '001', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1000', '002', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1001', '003', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1032', '004', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1100', '005', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1101', '006', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1102', '007', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1103', '008', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1104', '009', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1111', '010', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '2479', '011', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '2480', '012', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '2481', '013', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '2482', '014', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '6898', '015', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '9001', '016', 'V' )	

insert into cl_catalogo_pro
select 'ADM', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_codigo_postal_suc')
	  
-----------------------------
--catalogo:cli_prod_reg_neg
-----------------------------		
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla,'cli_prod_reg_neg','PRODUCTO REGLA NEGOCIO')
insert into cl_catalogo_pro values ('CLI', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','GRUPAL','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','INDIVIDUAL REVOLVENTE','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'3','INDIVIDUAL SIMPLE','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'4','CUALQUIER VALOR','V')
-----------------------
--catalogo:cl_correo_activar
-----------------------
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_correo_activar', 'Listado de Correo para activiar o desactivarlos')

--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'NOTACTINFO', 'NOTIFICACION DE ACTUALIZACION DE INFORMACION', 'B', NULL, NULL, NULL)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'CREDISPONI', 'TU CREDITO YA ESTA DISPONIBLE', 'B', NULL, NULL, NULL)

insert into cobis..dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'NOTAUTSDC', 'NOTIFICACION AUTOMATICA - SOLICITUD DE CREDITO', 'B', NULL, NULL, NULL)

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_correo_activar')

------------------------------------------------
-- Actualizacion secuencial tabla de catalogos
------------------------------------------------
update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 

--CATALOGOS TU NEGOCIOS
delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='cl_sit_version')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='cl_sit_version')
delete from cl_tabla where tabla ='cl_sit_version'

declare @w_id_catalogo int

select @w_id_catalogo = isnull(max(codigo),0)+1 from cobis..cl_tabla 
insert into cobis..cl_tabla values(@w_id_catalogo,'cl_sit_version','Situacion de la version')
		
insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CLI', @w_id_catalogo)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalogo,'P','PRODUCTIVO','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalogo,'D','DESARROLLO','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalogo,'H','HISTORICO','V',null,null,null)

go
--===============================
declare 		@w_id_catalog int

delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='cl_tipo_respuesta_form')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='cl_tipo_respuesta_form')
delete from cl_tabla where tabla ='cl_tipo_respuesta_form'

select @w_id_catalog = isnull(max(codigo),0)+1 from cobis..cl_tabla 
insert into cobis..cl_tabla values(@w_id_catalog,'cl_tipo_respuesta_form','Tipos de respuesta')

insert into cl_catalogo_pro (cp_producto, cp_tabla)
values ('CLI', @w_id_catalog)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'C','CATALOGO','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'D','FECHA','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'I','ENTERO','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'M','DINERO','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'T','TABLA','V',null,null,null)

go

---
declare @w_id_catalog int
delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='cl_estado_tu_negocio')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='cl_estado_tu_negocio')
delete from cl_tabla where tabla ='cl_estado_tu_negocio'

select @w_id_catalog = isnull(max(codigo),0)+1 from cobis..cl_tabla 
insert into cobis..cl_tabla values(@w_id_catalog,'cl_estado_tu_negocio','Tipos de respuesta')

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'AN','ACEPTADO NO VALIDADO','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'A','ACEPTADO','V',null,null,null)

insert into cobis..cl_catalogo(tabla,codigo,valor,estado,culture,equiv_code,type) 
values (@w_id_catalog,'R','RECHAZADO','V',null,null,null)

update cobis..cl_seqnos 
set siguiente = @w_id_catalog
where tabla  = 'cl_tabla' 
go
--------------------------------------------------------------------------------------------
-- CATALOGO MATRIZ - WEB APP AUDITORIA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go

delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_calificacion_riesgo_ext')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_calificacion_riesgo_ext', 'Calificacion Riesgo Individual Externo')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'A', 'A', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'B', 'B', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'C', 'C', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'D', 'D', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'E', 'E', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'F', 'F', 'V', null, null, null)

-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go


--------------------------------------------------------------------------------------------
-- CATALOGO MATRIZ - WEB APP AUDITORIA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go

delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_calificacion_riesgo_ext')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_calificacion_riesgo_ext', 'Calificacion Riesgo Individual Externo')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'A', 'A', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'B', 'B', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'C', 'C', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'D', 'D', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'E', 'E', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'F', 'F', 'V', null, null, null)

-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go



--------------------------------------------------------------------------------------------
-- CATALOGO MATRIZ - WEB APP AUDITORIA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go

delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_calificacion_riesgo_ext')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_calificacion_riesgo_ext', 'Calificacion Riesgo Individual Externo')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'A', 'A', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'B', 'B', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'C', 'C', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'D', 'D', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'E', 'E', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'F', 'F', 'V', null, null, null)

-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go

--------------------------------------------------------------------------------------------
-- CATALOGO MATRIZ - WEB APP AUDITORIA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go

delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_calificacion_riesgo_ext')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_calificacion_riesgo_ext', 'Calificacion Riesgo Individual Externo')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'A', 'A', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'B', 'B', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'C', 'C', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'D', 'D', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'E', 'E', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'F', 'F', 'V', null, null, null)

-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go




--------------------------------------------------------------------------------------------
-- CATALOGO MATRIZ - WEB APP AUDITORIA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go

delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_calificacion_riesgo_ext')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_calificacion_riesgo_ext', 'Calificacion Riesgo Individual Externo')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'A', 'A', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'B', 'B', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'C', 'C', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'D', 'D', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'E', 'E', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'F', 'F', 'V', null, null, null)

-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go




--------------------------------------------------------------------------------------------
-- CATALOGO MATRIZ - WEB APP AUDITORIA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go

delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_calificacion_riesgo_ext')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_calificacion_riesgo_ext', 'Calificacion Riesgo Individual Externo')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'A', 'A', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'B', 'B', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'C', 'C', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'D', 'D', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'E', 'E', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'F', 'F', 'V', null, null, null)

-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go




--------------------------------------------------------------------------------------------
-- CATALOGO MATRIZ - WEB APP AUDITORIA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go

delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_calificacion_riesgo_ext')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_calificacion_riesgo_ext', 'Calificacion Riesgo Individual Externo')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'A', 'A', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'B', 'B', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'C', 'C', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'D', 'D', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'E', 'E', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'F', 'F', 'V', null, null, null)

-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go

------------------------------------
-- catalogo: cl_colectivo
------------------------------------ 
select @w_tabla = @w_tabla + 1
--Creando Tabla
insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_colectivo', 'Nivel Cliente Colectivo')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'ID', 'INDEPENDIENTE COLECTIVO', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'AV', 'AVON', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'SR', 'SUPER RED', 'V', NULL, NULL, NULL)

------------------------------------
-- catalogo: cl_nivel_cliente_colectivo
------------------------------------ 
select @w_tabla = @w_tabla + 1

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_nivel_cliente_colectivo', 'Nivel Cliente Colectivo')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'O', 'ORO', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'P', 'PLATA', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'B', 'BRONCE', 'V', NULL, NULL, NULL)

------------------------------------
-- catalogo: cl_rol_asesor_colectivo
------------------------------------  
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla,'cl_rol_asesor_colectivo','Roles Asesores Colectivos')

--Insertando Catalogos
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'ASE', 'ASESOR', 'V', NULL, NULL, NULL)


INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'GOF', 'GERENTE OFICINA', 'V', NULL, NULL, NULL)


INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'COO', 'COORDINADOR', 'V', NULL, NULL, NULL)


INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'AAD', 'ANALISTA ADMINISTRATIVO', 'V', NULL, NULL, NULL)

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_rol_asesor_colectivo')

go
--------------------------------------------------------------------------------------------
-- BIOMETRICOS
--------------------------------------------------------------------------------------------
use cobis
go


DECLARE
@w_tabla          int,
@w_codigo         int


delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_tipo_identif_bio')
and codigo = cp_tabla
  
delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_tipo_identif_bio')
and cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
where cl_tabla.tabla in ('cl_tipo_identif_bio')


SELECT @w_tabla = max(isnull(codigo,0)) +1
FROM cl_tabla 

INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'cl_tipo_identif_bio', 'Tipo de Identificación Biométrico')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'INE', 'INE', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'IFE', 'IFE', 'V', NULL, NULL, NULL)

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_tipo_identif_bio')


delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_respuesta_renapo')
and codigo = cp_tabla
  
delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_respuesta_renapo')
and cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
where cl_tabla.tabla in ('cl_respuesta_renapo')


SELECT @w_tabla = max(isnull(codigo,0)) +1
FROM cl_tabla 

INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'cl_respuesta_renapo', 'Respuesta Renapo')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'N', 'PENDIENTE', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'I', 'NO EXISTEN DATOS', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'E', 'ERROR CONEXIÓN', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'S', 'VALIDADO', 'V', NULL, NULL, NULL)


insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_respuesta_renapo')
go

declare @w_id int 

delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='cl_ofi_biocheck')
delete from cl_catalogo_pro where cp_tabla = (select codigo from cl_tabla where tabla ='cl_ofi_biocheck')
delete from cl_tabla where tabla ='cl_ofi_biocheck'

select @w_id= max(codigo) +1 from cl_tabla 

insert into cl_tabla values(@w_id,'cl_ofi_biocheck','OFICINAS PARA VALIDAR BIOCHECK')
insert into cl_catalogo_pro values('ADM',@w_id)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_id, '0', 'OFICINA 0', 'V', NULL, NULL, NULL)


----------------------------------------------------------
-- PARAMETRIZACION OFICINAS ACTIVAS TOKEN CRE GRUPAL
----------------------------------------------------------
use cobis
go


declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

SELECT @w_producto = pd_abreviatura FROM cobis..cl_producto 
WHERE pd_descripcion = 'CLIENTES'

select @w_nom_tabla = 'cl_ofc_activa_gen_tkn'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla =  max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1
insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'OFICINAS ACTIVAS TOKEN CRE GRUPAL')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'2381','Oficina Ixtapaluca','V')


----------------------------------------------------------
-- CATALOGO DE ROLES PARA HABILITAR BOTON CONSULTA CUENTA
----------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30),
@w_producto2 varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CLIENTES'
select @w_producto2 = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'ADMINISTRACION'

select @w_nom_tabla = 'cl_hab_func_consulta_cuenta'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'HABILITAR BOTON CONSULTA CUENTA')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto2,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'10','FUNCIONARIO OFICINA','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'29','MESA DE OPERACIONES','V')


--------------------------------------------------------------
-- CATALOGO DE PREGUNTAS - FORMULARIO KYC - AUTO-ONBOARDING --
--------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CLIENTES'

select @w_nom_tabla = 'cl_preg_form_kyc_auto_onboard'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'PREGUNTAS - FORMULARIO KYC - AUTO-ONBOARDING')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'OPA','OCUPACION, PROFESION, ACTIVIDAD','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'AEG','ACTIVIDAD ECONOMICA GENERICA','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'AEE','ACTIVIDAD ECONOMICA ESPECIFICA','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'ORE','ORIGEN DE LOS RECURSOS','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'DRE','DESTINO DE LOS RECURSOS','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'FEA','FIRMA ELECTRONICA AVANZADA','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'FPU','FUNCIONES PUBLICAS','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'TIN','TRANSFERENCIAS INTERNACIONALES','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'CVD','COMPRA VENTA DIVISAS','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'TNEN','TRANSFERENCIAS NACIONALES ENVIADAS NUMERO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'TNEM','TRANSFERENCIAS NACIONALES ENVIADAS MONTO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'TNRN','TRANSFERENCIAS NACIONALES RECIBIDAS NUMERO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'TNRM','TRANSFERENCIAS NACIONALES RECIBIDAS MONTO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'DEN','DEPOSITOS EN EFECTIVO NUMERO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'DEM','DEPOSITOS EN EFECTIVO MONTO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'DNEN','DEPOSITOS NO EFECTIVO NUMERO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'DNEM','DEPOSITOS NO EFECTIVO MONTO','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go

-- Catalogos para respuestas biocheck
use cobis
go
declare @w_id_table int, @w_catalog_name varchar(64)
select @w_catalog_name = 'cl_respuesta_biometricos'
-- delete
delete cl_catalogo_pro from cl_tabla 
 where cp_producto = 'CLI' and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla = @w_catalog_name and codigo = cp_tabla
delete cl_catalogo from cl_tabla 
 where cl_tabla.tabla = @w_catalog_name 
   and cl_tabla.codigo = cl_catalogo.tabla
delete cl_tabla where cl_tabla.tabla = @w_catalog_name
-- Insert
select @w_id_table = isnull(max(codigo), 0) + 1 from cl_tabla

insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@w_id_table, @w_catalog_name, 'Respuesta Biometricos')
insert into cl_catalogo_pro (cp_producto, cp_tabla) values ('CLI', @w_id_table)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, 'TG_000', 'Operación exitosa', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, 'TG_001', 'Error en los datos de entrada', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, 'TG_002', 'Error de conexión', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EBC00'   ,   'No hay comunicación con el Biocheck Window Service'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'CA00'   ,   'Se cancelo el proceso.'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'ECC00'   ,   'Error en Consulta Biométrica Inesperado'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'ECC01'   ,   'No hay conexión con servicio de consulta Biometrica'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EAC01'   ,   'Error inesperado en API Customers'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EAC02'   ,   'No hay conexión con servicio de consulta en API Customers'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EAC03'   ,   'El número de cliente no es válido'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'ELB00'   ,   'Error inesperado en la lectura de licencias'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'ETO00'   ,   'Error inesperado en la validación del Token'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'ETO01'   ,   'Error de Token Opaco por ser inválido'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'ETO06'   ,   'No se recibió token opaco.'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EOB00'   ,   'Se terminaron los intentos de captura de huellas.'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EOB05'   ,   'Credencial del INE  No vigente'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EOB07'   ,   'No coincide el nombre y fecha de nacimiento de la identifica'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EVD01'   ,   'CURP no válido en la RENAPO'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EVD02'   ,   'OCR/CIC no válido en INE'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EVD03'   ,   'Huellas no válidas en INE'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EVB00'   ,   'Error de Verificación Inesperado'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EVB02'   ,   'Error de conexión con el servicio de verificación de API'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EPE6802'   ,   'Error en la consulta EP68'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EP6800'   ,   'Campos faltantes en la consulta'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'ETOK00'   ,   'Campos faltantes para completar la operación de Token Opaco'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'ETOG01'   ,   'No se pudo conseguir el OAUTH'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'ETOG02'   ,   'Error inespeerado en Token'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EHTT204'   ,   'HTTP: NO CONTENT'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EHTT401'   ,   'HTTP: UNAUTHORIZED'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EHTT403'   ,   'HTTP: FORBIDDEN'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EHTT404'   ,   'HTTP: NOT FOUND'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EHTT405'   ,   'HTTP: METHOD NOT ALLOWED'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EHTT406'   ,   'HTTP: NOT ACCEPTABLE'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EHTT409'   ,   'HTTP: CONFLICT'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EHTT415'   ,   'HTTP: UNSUPPORTED MEDIA TYPE'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EHTT500'   ,   'HTTP: INTERNAL SERVER ERROR'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EHTT503'   ,   'HTTP: SERVICE TEMPORARILY UNAVAILABLE'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EEXG00'   ,   'Ocurrió un error en la operación, favor de volver a intentar'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EAPC00'   ,   'Campos faltantes para completar la operación'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EAPC01'   ,   'Error inesperado en API Customers'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EAPC02'   ,   'El número de cliente no es válido, favor de verificarlo'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   'EAPC03'   ,   'Error inesperado en API Customers por deserialización'   ,   'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values (@w_id_table   ,   '0'   ,   'El cliente no cumple con las validaciones'   ,   'V')


update cobis..cl_seqnos set siguiente = @w_id_table where tabla = 'cl_tabla'
go






-- =========================================================================================================================================
-- Catalogos para Actividad Profesional
use cobis
go
declare @w_id_table int, @w_catalog_name varchar(64)
select @w_catalog_name = 'cl_actividad_profesional'

-- Insert
select @w_id_table = isnull(max(codigo), 0) + 1 from cl_tabla

insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@w_id_table, @w_catalog_name, 'Actividad Profesional')
insert into cl_catalogo_pro (cp_producto, cp_tabla) values ('CLI', @w_id_table)

insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '001', 'JUEGOS CON APUESTA, CONCURSOS Y SORTEOS', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '002', 'COMPRAVENTA DE INMUEBLES', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '003', 'SERVICIOS DE FE PÚBLICA (NOTARIOS Y CORREDORES)', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '004', 'INTERCAMBIO DE ACTIVOS VIRTUALES', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '005', 'BLINDAJE DE VEHÍCULOS', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '006', 'PRÉSTAMOS NO FINANCIEROS', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '007', 'JOYERÍA, METALES, PIEDRAS PRECIOSAS', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '008', 'ARRENDAMIENTO DE INMUEBLES', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '009', 'TARJETAS DE SERVICIOS, CRÉDITO O PREPAGADAS', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '010', 'PRESTACIÓN DE SERVICIOS PROFESIONALES', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '011', 'RECEPCIÓN DE DONATIVOS', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '012', 'COMERCIALIZACIÓN DE VEHÍCULOS', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '013', 'TRASLADO DE VALORES', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '014', 'EMISIÓN DE CHEQUES DE VIAJERO', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '015', 'COMERCIALIZACIÓN Y SUBASTA DE OBRAS DE ARTE', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '016', 'SERVICIOS DE AGENTES O APODERADOS ADUANALES', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table, '017', 'NINGUNA', 'V')


update cobis..cl_seqnos set siguiente = @w_id_table where tabla = 'cl_tabla'
go


------------------------------------------------------------------
-- CATALOGO DE TIPOS DE ACEPTACION - R193221 - B2B Grupal Digital
------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CLIENTES'

select @w_nom_tabla = 'cl_tipos_aceptacion'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'TIPOS DE ACEPTACION')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'AVPRI','AVISO DE PRIVACIDAD','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'REDOC','RESPONSABILIDAD DE DOCUMENTOS','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'CCDOM','CAPTURA COMPROBANTE DOMICILIARIO','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go
