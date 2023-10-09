
use cobis
go
declare @w_cod INT

select  @w_cod=codigo from cobis..cl_tabla where tabla    = 'cl_sector_economico'  

UPDATE cobis..cl_tabla SET descripcion = 'SECTOR ECONOMICO'   WHERE tabla    = 'cl_sector_economico'     AND codigo = @w_cod

if exists (select 1 from cobis..cl_catalogo WHERE tabla = @w_cod AND codigo='III' )
BEGIN
     delete cobis..cl_catalogo WHERE tabla = @w_cod  AND codigo='III'
   
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, 'III', 'COMERCIO', 'V', NULL, NULL, NULL)
END


select  @w_cod=codigo from cobis..cl_tabla where tabla    = 'cl_subsector_ec'  

UPDATE cobis..cl_tabla SET descripcion = 'Subsector Economico'   WHERE tabla    = 'cl_subsector_ec'     AND codigo = @w_cod

if exists (select 1 from cobis..cl_catalogo WHERE tabla = @w_cod AND codigo='U' )
BEGIN
     delete cobis..cl_catalogo WHERE tabla = @w_cod  AND codigo='U'
END 

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
 VALUES (@w_cod, 'U', 'COMERCIO', 'V', NULL, NULL, NULL)   

IF(NOT EXISTS(SELECT 1 FROM cobis..cl_subsector_ec WHERE se_codigo='U'))
	INSERT INTO dbo.cl_subsector_ec (se_codigo, se_descripcion, se_estado, se_codSector)
	VALUES ('U', 'COMERCIO', 'V', 'III')


select  @w_cod=codigo from cobis..cl_tabla where tabla= 'cl_actividad_ec'  

UPDATE cobis..cl_tabla SET descripcion = 'Actividad Economica'   WHERE tabla    = 'cl_actividad_ec'  AND codigo = @w_cod

if exists (select 1 from cobis..cl_catalogo WHERE tabla = @w_cod)
BEGIN
     delete cobis..cl_catalogo WHERE tabla = @w_cod  AND codigo IN (1001,1002,1003,1004,1005,1005,1006,1007,1008,1009,1010,1011,
     1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030,1031,1032,1033)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1001', 'ALQUILER DE MOBILIARIO Y/O EQUIPO', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1002', 'PAPELERIA Y MERCERIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1003', 'PARTES Y REFACCIONES PARA AUTOMOVILES', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1004', 'ROPA Y ACCESORIOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1005', 'ZAPATERIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1006', 'VENTA DE ALIMENTOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1007', 'ANTOJITOS Y PREPARACION DE ALIMENTOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1008', 'VENTA DE CATALOGOS (ZAPATOS,ROPA,MAQUILLAJE,BLANCOS,ETC)', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1009', 'MUEBLES PARA HOGAR', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1010', 'TELEFONIA Y ELECTRONICA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1011', 'ARTICULOS USUADOS Y RECICLAJE', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1012', 'FERRETERIA, TLAPALERIA Y VIDRIERIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1013', 'FARMACIAS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1014', 'ABARROTES Y CREMERIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1015', 'CARNICERIA, PESCADERIA Y POLLERIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1016', 'TALLER MECANICO', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1017', 'TALLER DE REPARACION APARATOS ELECTRICOS Y ELECTRONICOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1018', 'LAVANDERIA, TINTORERIA Y PLANCHADURIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1019', 'AUTOLAVADO', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1020', 'PROFESIONES Y OFICIOS', 'V', NULL, NULL, NULL)


INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1021', 'DULCERIA Y ARTICULO PARA FIESTAS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1022', 'VENTA DE HELADOS Y PALETAS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1023', 'PAN Y PASTELES', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1024', 'TORTILLERIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1025', 'ARTESANIAS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1026', 'JOYERIA Y BISUTERIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1027', 'FRUTAS Y VERDURAS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1028', 'COSTURA Y BORDADO', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1029', 'VENTA DE ARTICULOS DE HOGAR Y LIMPIEZA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1030', 'FLORES Y REGALOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1031', 'CULTIVOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1032', 'SERVICIOS DE INTERNET', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1033', 'PLASTICOS Y DESECHABLES', 'V', NULL, NULL, NULL)
  
END 
---



delete cobis..cl_actividad_ec WHERE ac_codSubsector='U'  
  
INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1001', 'ALQUILER DE MOBILIARIO Y/O EQUIPO', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1002', 'PAPELERIA Y MERCERIA', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1003', 'PARTES Y REFACCIONES PARA AUTOMOVILES', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1004', 'ROPA Y ACCESORIOS', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1005', 'ZAPATERIA', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1006', 'VENTA DE ALIMENTOS', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1007', 'ANTOJITOS Y PREPARACION DE ALIMENTOS', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1008', 'VENTA DE CATALOGOS (ZAPATOS,ROPA,MAQUILLAJE,BLANCOS,ETC)', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1009', 'MUEBLES PARA HOGAR', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1010', 'TELEFONIA Y ELECTRONICA', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1011','ARTICULOS USUADOS Y RECICLAJE', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1012', 'FERRETERIA, TLAPALERIA Y VIDRIERIA', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1013', 'FARMACIAS', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1014', 'ABARROTES Y CREMERIA', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1015', 'CARNICERIA, PESCADERIA Y POLLERIA', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1016', 'TALLER MECANICO', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1017', 'TALLER DE REPARACION APARATOS ELECTRICOS Y ELECTRONICOS', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1018', 'LAVANDERIA, TINTORERIA Y PLANCHADURIA', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1019', 'AUTOLAVADO', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1020', 'PROFESIONES Y OFICIOS', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1021', 'DULCERIA Y ARTICULO PARA FIESTAS', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1022', 'VENTA DE HELADOS Y PALETAS', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1023', 'PAN Y PASTELES', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1024', 'TORTILLERIA', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1025', 'ARTESANIAS', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1026', 'JOYERIA Y BISUTERIA', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1027', 'FRUTAS Y VERDURAS', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1028', 'COSTURA Y BORDADO', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1029', 'VENTA DE ARTICULOS DE HOGAR Y LIMPIEZA', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1030', 'FLORES Y REGALOS', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1031', 'CULTIVOS', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1032', 'SERVICIOS DE INTERNET', 'n', 'null', 'V', 'U', '27', '6')

INSERT INTO cobis..cl_actividad_ec (ac_codigo, ac_descripcion, ac_sensitiva, ac_industria, ac_estado, ac_codSubsector, ac_homolog_pn, ac_homolog_pj)
VALUES ('1033', 'PLASTICOS Y DESECHABLES', 'n', 'null', 'V', 'U', '27', '6')



select  @w_cod=codigo from cobis..cl_tabla where tabla= 'cl_actividad'  

UPDATE cobis..cl_tabla SET descripcion = 'ACTIVIDAD'   WHERE tabla    = 'cl_actividad'  AND codigo = @w_cod

if exists (select 1 from cobis..cl_catalogo WHERE tabla = @w_cod )
BEGIN
     delete cobis..cl_catalogo WHERE tabla = @w_cod
   
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1001', 'ALQUILER DE MOBILIARIO Y/O EQUIPO', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1002', 'PAPELERIA Y MERCERIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1003', 'PARTES Y REFACCIONES PARA AUTOMOVILES', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1004', 'ROPA Y ACCESORIOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1005', 'ZAPATERIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1006', 'VENTA DE ALIMENTOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1007', 'ANTOJITOS Y PREPARACION DE ALIMENTOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1008', 'VENTA DE CATALOGOS (ZAPATOS,ROPA,MAQUILLAJE,BLANCOS,ETC)', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1009', 'MUEBLES PARA HOGAR', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1010', 'TELEFONIA Y ELECTRONICA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1011', 'ARTICULOS USUADOS Y RECICLAJE', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1012', 'FERRETERIA, TLAPALERIA Y VIDRIERIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1013', 'FARMACIAS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1014', 'ABARROTES Y CREMERIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1015', 'CARNICERIA, PESCADERIA Y POLLERIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1016', 'TALLER MECANICO', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1017', 'TALLER DE REPARACION APARATOS ELECTRICOS Y ELECTRONICOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1018', 'LAVANDERIA, TINTORERIA Y PLANCHADURIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1019', 'AUTOLAVADO', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1020', 'PROFESIONES Y OFICIOS', 'V', NULL, NULL, NULL)


INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1021', 'DULCERIA Y ARTICULO PARA FIESTAS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1022', 'VENTA DE HELADOS Y PALETAS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1023', 'PAN Y PASTELES', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1024', 'TORTILLERIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1025', 'ARTESANIAS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1026', 'JOYERIA Y BISUTERIA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1027', 'FRUTAS Y VERDURAS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1028', 'COSTURA Y BORDADO', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1029', 'VENTA DE ARTICULOS DE HOGAR Y LIMPIEZA', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1030', 'FLORES Y REGALOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1031', 'CULTIVOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1032', 'SERVICIOS DE INTERNET', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod, '1033', 'PLASTICOS Y DESECHABLES', 'V', NULL, NULL, NULL)


END



   

