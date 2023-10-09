use cobis
go
--
-- TABLE INSERT cl_tipo_documento
--
truncate table cl_tipo_documento


insert into cl_tipo_documento ( td_secuencial, td_codigo, td_descripcion, td_mascara, td_tipoper, td_provincia, td_aperrapida, td_bloquea, td_nacionalidad, td_digito, td_estado, td_desc_corta, td_compuesto, td_nro_compuesto, td_adicional, td_creacion, td_habilitado_mis, td_habilitado_usu, td_prefijo, td_subfijo ) 
        values ( 0, 'CURP', 'CLAVE UNICA DE REGISTRO DE POBLACION', null, 'P', 'N', 'S', 'N', '68', 'N', 'V', 'CURP', 'S', 0, 0, 'S', 'S', 'S', null, 'CURP' )
go


--
-- TABLE INSERT cl_actividad_principal
--
truncate table cl_actividad_principal
insert into cl_actividad_principal ( ap_codigo, ap_descripcion, ap_activ_comer, ap_estado ) 
        values ( '01', 'COMERCIANTE', 'E', 'V' )
go

--
-- TABLE INSERT cl_subsector_ec
--
truncate table cl_subsector_ec

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('A', 'AGRICULTURA Y GANADERIA', 'V', 'I')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('B', 'CAZA, SILVICULTURA Y PESCA', 'V', 'I')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('C', 'EXTRACCION DE PETROLEO CRUDO Y GAS NATURAL', 'V', 'II')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('D', 'MINERALES METALICOS Y NO METALICOS', 'V', 'II')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('E', 'INDUSTRIA MANUFACTURERA', 'V', 'II')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('F', 'PRODUCCION Y DISTRIBUCION DE ENERGIA ELECTRICA, GAS Y AGUA', 'V', 'II')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('G', 'CONSTRUCCION', 'V', 'II')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('H', 'VENTA AL POR MAYOR', 'V', 'III')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('I', 'HOTELES Y RESTAURANTES', 'V', 'IV')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('J', 'TRANSPORTE, ALMACENAMIENTO Y COMUNICACIONES', 'V', 'IV')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('K', 'INTERMEDIACION FINANCIERA', 'V', 'IV')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('L', 'SERVICIOS INMOBILIARIOS, EMPRESARIALES Y DE ALQUILER', 'V', 'IV')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('M', 'ADMINISTRACION PUBLICA, DEFENSA Y SEGURIDAD SOCIAL OBLIGATORIA', 'V', 'IV')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('N', 'EDUCACION', 'V', 'IV')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('ND', 'NO DETERMINADO', 'V', 'VII')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('O', 'SERVICIOS SOCIALES, COMUNALES Y PERSONALES', 'V', 'IV')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('Q', 'SERVICIO DE ORGANIZACIONES Y ORGANOS EXTRATERRITORIALES', 'V', 'IV')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('S', 'VENTA AL POR MENOR', 'V', 'III')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('W', 'INGRESOS FIJOS', 'V', 'V')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('Z', 'ACTIVIDADES ATIPICAS', 'V', 'VI')
go

insert into cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
values ('U', 'COMERCIO', 'V', 'III')
go

--
-- TABLE INSERT cl_actividad_ec
--

truncate table cl_actividad_ec
go

/* Insertar registros */

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('7512016', 'AGENCIA DE TURISMO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6992011', 'AGENCIAS DE RIFAS Y SORTEOS (QUINIELAS Y LOTERIA)')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8711013', 'CAFETERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8831019', 'CENTRO NOCTURNO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6911029', 'COMPRA DE CASA HABITACION')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6991013', 'COMPRAVENTA DE ARMAS DE FUEGO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6622022', 'COMPRAVENTA DE ARTICULOS DE FERRETERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6211015', 'COMPRAVENTA DE ARTICULOS DE LENCERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6215017', 'COMPRAVENTA DE ARTICULOS DE MERCERIA Y CEDERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6325030', 'COMPRAVENTA DE ARTICULOS PARA REGALO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6325048', 'COMPRAVENTA DE ARTICULOS REGIONALES CURIOSIDADES Y ARTESANIAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6811013', 'COMPRAVENTA DE AUTOMOVILES Y CAMIONES NUEVOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6812011', 'COMPRAVENTA DE AUTOMOVILES Y CAMIONES USADOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6212013', 'COMPRAVENTA DE CALZADO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6124010', 'COMPRAVENTA DE CARNE DE AVES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6911045', 'COMPRAVENTA DE CASAS Y OTROS INMUEBLES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6999017', 'COMPRAVENTA DE DIAMANTES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6323018', 'COMPRAVENTA DE DISCOS Y CASSETTES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6132013', 'COMPRAVENTA DE DULCES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6721036', 'COMPRAVENTA DE EQUIPO DE PROCESAMIENTO ELECTRONICO DE DATOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6326020', 'COMPRAVENTA DE FLORES Y ADORNOS FLORALES NATURALES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6112015', 'COMPRAVENTA DE FRUTAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6223010', 'COMPRAVENTA DE JUGUETES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6132039', 'COMPRAVENTA DE LECHE')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6112023', 'COMPRAVENTA DE LEGUMBRES Y HORTALIZAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6629010', 'COMPRAVENTA DE MATERIALES PARA CONSTRUCCION')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6231013', 'COMPRAVENTA DE MEDICINAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6312011', 'COMPRAVENTA DE MUEBLES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6225024', 'COMPRAVENTA DE OTRAS JOYAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6419015', 'COMPRAVENTA DE OTROS APARATOS ELECTRICOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6329016', 'COMPRAVENTA DE OTROS ARTICULOS PARA EL HOGAR')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6119011', 'COMPRAVENTA DE OTROS PRODUCTOS ALIMENTICIOS AGRICOLAS EN ESTADO NATURAL')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6132047', 'COMPRAVENTA DE OTROS PRODUCTOS LACTEOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6216023', 'COMPRAVENTA DE OTROS PRODUCTOS TEXTILES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6132055', 'COMPRAVENTA DE PAN Y PASTELES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6233019', 'COMPRAVENTA DE PAPELERIA Y ARTICULOS DE ESCRITORIO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6231021', 'COMPRAVENTA DE PERFUMES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6126032', 'COMPRAVENTA DE PESCADOS Y MARISCOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6623020', 'COMPRAVENTA DE PINTURAS BARNICES Y BROCHAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6815015', 'COMPRAVENTA DE REFACCIONES Y ACCESORIOS NUEVOS PARA AUTOS Y CAMIONES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6134019', 'COMPRAVENTA DE REFRESCOS AGUAS GASEOSAS Y AGUAS PURIFICADAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6225032', 'COMPRAVENTA DE RELOJES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6211023', 'COMPRAVENTA DE ROPA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6111017', 'COMPRAVENTA DE SEMILLAS Y GRANOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6911053', 'COMPRAVENTA DE TERRENOS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3319010', 'ELABORACION DE OBJETOS ARTISTICOS DE ALFARERIA Y CERAMICA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('9501009', 'EMPLEADO DEL SECTOR PRIVADO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('9502007', 'EMPLEADO DEL SECTOR PUBLICO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8429046', 'EMPRESAS TRANSPORTADORAS DE VALORES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3997014', 'FABRICACION DE ARMAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3932010', 'FABRICACION DE ARTICULOS DE JOYERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3933018', 'FABRICACION DE ARTICULOS DE QUINCALLERIA Y BISUTERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3921013', 'FABRICACION DE RELOJES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8800002', 'JUEGOS DE FERIA Y APUESTAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8934011', 'LAVANDERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('2023018', 'MOLINO DE NIXTAMAL')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8200001', 'MONTEPÍO Ó CASAS DE EMPEÑO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('9504003', 'NEGOCIOS RELACIONADOS CON INTERNET')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8714017', 'NEVERIA Y REFRESQUERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8400003', 'NOTARÍAS PÚBLICAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8711021', 'RESTAURANTE')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8933013', 'SALON DE BELLEZA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6800003', 'SERVICIOS DE BLINDAJE')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8411019', 'SERVICIOS DE NOTARIAS PUBLICAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8719017', 'SERVICIOS EN MERENDEROS CENADURIAS Y PREPARACION DE ANTOJITOS Y PLATILLOS REGIONALES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('04200002', 'SERVICIOS ESPECIALES PRESTADOS POR SUBCONTRATISTAS (DEMOLICIONES, CARPINTERIA, IMPERMIABILIZACIÓN, INST ESLECTRICAS, PINTURA, PLOMERIA)')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3932036', 'TALLADO DE PIEDRAS PRECIOSAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3516054', 'TALLER DE HERRERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3591022', 'TALLER DE HOJALATERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('4221016', 'TALLER DE PLOMERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8921018', 'TALLER DE REPARACION DE CALZADO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8929020', 'TALLER DE REPARACION DE ROPA Y MEDIAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8911019', 'TALLER DE REPARACION GENERAL DE AUTOMOVILES Y CAMIONES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('2412039', 'TALLER DE SASTRERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6131023', 'TIENDA DE ABARROTES Y MISCELANEA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('8934029', 'TINTORERIA Y PLANCHADURIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('2093011', 'TORTILLERIA')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('7113012', 'TRANSPORTE EN AUTOMOVIL DE RULETEO')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('3212024', 'VULCANIZACION DE LLANTAS Y CAMARAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('2413011', 'FABRICACION DE UNIFORMES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6512017', 'COMPRAVENTA DE GAS PARA USO DOMESTICO O COMERCIAL')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6216031', 'COMPRAVENTA DE TELAS')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6133029', 'COMPRAVENTA DE ALIMENTOS PARA AVES Y OTROS ANIMALES')

insert into cl_actividad_ec (ac_codigo, ac_descripcion)
values('6122014', 'COMPRAVENTA DE CARNE DE RES Y OTRAS ESPECIES DE GANADO')

--
-- TABLE INSERT cl_depart_pais
--
truncate table cl_depart_pais 

INSERT INTO cl_depart_pais (dp_departamento, dp_mnemonico, dp_descripcion, dp_pais, dp_estado)
VALUES ('1', 'DEP1', 'DEP1', 1, 'V')

go


--////////////////////////////////////////////////

use cobis
go
delete cl_seqnos where tabla in ('cl_direccion_geo')
go

print 'ff_pregunta.pr_id_pregunta'
insert into cl_seqnos (bdatos, tabla, siguiente, pkey) values ('cobis','cl_direccion_geo',0, 'dg_secuencial')
go

--
-- TABLE INSERT cl_actividad_generica
--

truncate table cl_actividad_generica
go

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '7512016', 'AGENCIA DE TURISMO', 'AGENCIA DE TURISMO', 'MEDIO', 1.045)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '6992011', 'AGENCIAS DE RIFAS Y SORTEOS (QUINIELAS Y LOTERIA)', 'C/V DE LOTERIA', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8711013', 'CAFETERIA', 'CAFETERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8831019', 'CENTRO NOCTURNO', 'CENTRO NOCTURNO', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6911029', 'COMPRA DE CASA HABITACION', 'C/V DE CASAS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6991013', 'COMPRAVENTA DE ARMAS DE FUEGO', 'C/V DE ARMAS DE FUEGO', 'ACT. BLOQUEANTE', 21.096)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6622022', 'COMPRAVENTA DE ARTICULOS DE FERRETERIA', 'C/V ART FERRETERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6211015', 'COMPRAVENTA DE ARTICULOS DE LENCERIA', 'C/V LENCERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6215017', 'COMPRAVENTA DE ARTICULOS DE MERCERIA Y CEDERIA', 'MERCERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6325030', 'COMPRAVENTA DE ARTICULOS PARA REGALO', 'C/V ART PARA REGALO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6325048', 'COMPRAVENTA DE ARTICULOS REGIONALES CURIOSIDADES Y ARTESANIAS', 'C/V ARTESANIAS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6811013', 'COMPRAVENTA DE AUTOMOVILES Y CAMIONES NUEVOS', 'C/V DE AUTOS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6812011', 'COMPRAVENTA DE AUTOMOVILES Y CAMIONES USADOS', 'C/V DE AUTOS USADOS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6212013', 'COMPRAVENTA DE CALZADO', 'C/V CALZADO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6124010', 'COMPRAVENTA DE CARNE DE AVES', 'POLLERIA', 'MEDIO', 1.045)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6911045', 'COMPRAVENTA DE CASAS Y OTROS INMUEBLES', 'C/V DE CASAS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6999017', 'COMPRAVENTA DE DIAMANTES', 'C/V DE DIAMANTES', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6323018', 'COMPRAVENTA DE DISCOS Y CASSETTES', 'C/V DISCOS Y CASSETTES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6132013', 'COMPRAVENTA DE DULCES', 'C/V DE DULCES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6721036', 'COMPRAVENTA DE EQUIPO DE PROCESAMIENTO ELECTRONICO DE DATOS', 'C/V ART DE COMPUTACION', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6326020', 'COMPRAVENTA DE FLORES Y ADORNOS FLORALES NATURALES', 'FLORERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6112015', 'COMPRAVENTA DE FRUTAS', 'C/V DE FRUTAS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6223010', 'COMPRAVENTA DE JUGUETES', 'C/V DE JUGUETES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6132039', 'COMPRAVENTA DE LECHE', 'C/V DE LECHE', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6112023', 'COMPRAVENTA DE LEGUMBRES Y HORTALIZAS', 'C/V DE VERDURAS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6629010', 'COMPRAVENTA DE MATERIALES PARA CONSTRUCCION', 'C/V MATERIALES PARA CONSTRUCCIÓN', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6231013', 'COMPRAVENTA DE MEDICINAS', 'COMPRAVENTA DE MEDICINAS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6312011', 'COMPRAVENTA DE MUEBLES', 'COMPRAVENTA DE MUEBLES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6225024', 'COMPRAVENTA DE OTRAS JOYAS', 'C/V DE JOYAS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6419015', 'COMPRAVENTA DE OTROS APARATOS ELECTRICOS', 'C/V APARATOS ELECTRÓNICOS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6329016', 'COMPRAVENTA DE OTROS ARTICULOS PARA EL HOGAR', 'C/V ARTICULOS PARA EL HOGAR', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6119011', 'COMPRAVENTA DE OTROS PRODUCTOS ALIMENTICIOS AGRICOLAS EN ESTADO NATURAL', 'VENTA DE PRODUCTOS NATURALES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6132047', 'COMPRAVENTA DE OTROS PRODUCTOS LACTEOS', 'C/V DE LACTEOS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6216023', 'COMPRAVENTA DE OTROS PRODUCTOS TEXTILES', 'C/VPRODUCTOS TEXTILES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6132055', 'COMPRAVENTA DE PAN Y PASTELES', 'PANADERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6233019', 'COMPRAVENTA DE PAPELERIA Y ARTICULOS DE ESCRITORIO', 'PAPELERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6231021', 'COMPRAVENTA DE PERFUMES', 'C/V DE PERFUES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6126032', 'COMPRAVENTA DE PESCADOS Y MARISCOS', 'C/V DE PESCADO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6623020', 'COMPRAVENTA DE PINTURAS BARNICES Y BROCHAS', 'C/V DE PINTURAS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6815015', 'COMPRAVENTA DE REFACCIONES Y ACCESORIOS NUEVOS PARA AUTOS Y CAMIONES', 'C/V REFACCIONES DE AUTO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6134019', 'COMPRAVENTA DE REFRESCOS AGUAS GASEOSAS Y AGUAS PURIFICADAS', 'C/V DE REFRESCOS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6225032', 'COMPRAVENTA DE RELOJES', 'C/V RELOJES', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6211023', 'COMPRAVENTA DE ROPA', 'C/V DE ROPA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6111017', 'COMPRAVENTA DE SEMILLAS Y GRANOS', 'C/V DE SEMILLAS Y GRANOS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6911053', 'COMPRAVENTA DE TERRENOS', 'C/V DE TERRENOS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '3319010', 'ELABORACION DE OBJETOS ARTISTICOS DE ALFARERIA Y CERAMICA', 'ALFARERIA Y CERAMICA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '9501009', 'EMPLEADO DEL SECTOR PRIVADO', 'EMPLEADO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '9502007', 'EMPLEADO DEL SECTOR PUBLICO', 'EMPLEADO GOBIERNO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8429046', 'EMPRESAS TRANSPORTADORAS DE VALORES', 'TRANSPORTE DE VALORES', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '3997014', 'FABRICACION DE ARMAS', 'FABRICACIÓN DE ARMAS', 'ACT. BLOQUEANTE', 21.096)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '3932010', 'FABRICACION DE ARTICULOS DE JOYERIA', 'FABRICACION ART DE JOYERIA', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '3933018', 'FABRICACION DE ARTICULOS DE QUINCALLERIA Y BISUTERIA', 'C/V BISUTERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '3921013', 'FABRICACION DE RELOJES', 'FABRICACION REFLOJES', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8800002', 'JUEGOS DE FERIA Y APUESTAS', 'JUEGOS DE FERIA Y APUESTAS', 'ACT. BLOQUEANTE', 21.096)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8934011', 'LAVANDERIA', 'LAVANDERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '2023018', 'MOLINO DE NIXTAMAL', 'MOLINO DE NIXTAMAL', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8200001', 'MONTEPÍO Ó CASAS DE EMPEÑO', 'CASA DE EMPEÑO', 'PREVIO CCC', 9.991)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '9504003', 'NEGOCIOS RELACIONADOS CON INTERNET', 'CYBERCAFE', 'MEDIO', 1.045)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '8714017', 'NEVERIA Y REFRESQUERIA', 'NEVERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8400003', 'NOTARÍAS PÚBLICAS', 'NOTARÍAS PÚBLICAS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8711021', 'RESTAURANTE', 'RESTAURANTE', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8933013', 'SALON DE BELLEZA', 'SALON DE BELLEZA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '6800003', 'SERVICIOS DE BLINDAJE', 'BLINDAJE', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8411019', 'SERVICIOS DE NOTARIAS PUBLICAS', 'NOTARÍAS PÚBLICAS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8719017', 'SERVICIOS EN MERENDEROS CENADURIAS Y PREPARACION DE ANTOJITOS Y PLATILLOS REGIONALES', 'C/V DE ANTOJITOS', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '04200002', 'SERVICIOS ESPECIALES PRESTADOS POR SUBCONTRATISTAS (DEMOLICIONES, CARPINTERIA, IMPERMIABILIZACIÓN, INST ESLECTRICAS, PINTURA, PLOMERIA)', 'CARPINTERO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '3932036', 'TALLADO DE PIEDRAS PRECIOSAS', 'PIEDRAS PRECIOSAS', 'ALTO', 3.500)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '3516054', 'TALLER DE HERRERIA', 'HERRERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '3591022', 'TALLER DE HOJALATERIA', 'HOJALATERÍA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '4221016', 'TALLER DE PLOMERIA', 'PROMERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8921018', 'TALLER DE REPARACION DE CALZADO', 'REPARACIÓN DE CALZADO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8929020', 'TALLER DE REPARACION DE ROPA Y MEDIAS', 'SASTRE', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8911019', 'TALLER DE REPARACION GENERAL DE AUTOMOVILES Y CAMIONES', 'MECANICO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '2412039', 'TALLER DE SASTRERIA', 'SASTRE', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6131023', 'TIENDA DE ABARROTES Y MISCELANEA', 'ABARROTES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '8934029', 'TINTORERIA Y PLANCHADURIA', 'TINTORERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '2093011', 'TORTILLERIA', 'TORTILLERIA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '7113012', 'TRANSPORTE EN AUTOMOVIL DE RULETEO', 'TAXISTA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('SERVICIO', '3212024', 'VULCANIZACION DE LLANTAS Y CAMARAS', 'VULCANIZADORA', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('INDUSTRIA', '2413011', 'FABRICACION DE UNIFORMES', 'UNIFORMES Y ROPA DE TRABAJO', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6512017', 'COMPRAVENTA DE GAS PARA USO DOMESTICO O COMERCIAL', 'C/V DE GAS', 'MEDIO', 1.045)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6216031', 'COMPRAVENTA DE TELAS', 'C/V TELAS Y CASIMIRES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6133029', 'COMPRAVENTA DE ALIMENTOS PARA AVES Y OTROS ANIMALES', 'C/V ALIMENTO PARA ANIMALES', 'BAJO', 380)

insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
values('COMERCIO', '6122014', 'COMPRAVENTA DE CARNE DE RES Y OTRAS ESPECIES DE GANADO', 'CARNICERIA', 'MEDIO', 1.045)

--insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
--values('COMERCIO', '6325030', 'COMPRAVENTA DE ARTICULOS PARA REGALO', 'TIENDA DE REGALOS', 'BAJO', 380)

--insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
--values('COMERCIO', '6132047', 'COMPRAVENTA DE OTROS PRODUCTOS LACTEOS', 'CREMERIA', 'BAJO', 380)

--insert into cl_actividad_generica (acg_actividad_generica,acg_codigo_actividad,acg_actividad_especifica,acg_nombre_corto,acg_nivel_riesgo,acg_valor)
--values('COMERCIO', '6231021', 'COMPRAVENTA DE PERFUMES', 'C/V PERFUMES Y COSMETICOS', 'BAJO', 380)


