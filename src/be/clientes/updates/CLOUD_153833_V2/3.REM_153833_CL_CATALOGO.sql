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

insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table    ,   'TG_000'    , 'Operación exitosa', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table    ,   'TG_001'    , 'Error en los datos de entrada', 'V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_table    ,   'TG_002'    , 'Error de conexión', 'V')
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