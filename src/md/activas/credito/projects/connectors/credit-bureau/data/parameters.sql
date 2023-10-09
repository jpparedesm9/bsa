USE cobis
GO

select * from cobis..cl_parametro
where pa_nemonico in ('BCVR', 'BCNO', 'BCPR', 'BCCP', 'BCCU', 'BCPW', 'BCTQ', 'BCTC', 'BCUM', 'BCIC', 'BCID', 'BCTS', 'BCPC', 'BCIP', 'BCPO', 'OBCDS')

DELETE FROM cobis..cl_parametro
where pa_nemonico in ('BCVR', 'BCNO', 'BCPR', 'BCCP', 'BCCU', 'BCPW', 'BCTQ', 'BCTC', 'BCUM', 'BCIC', 'BCID', 'BCTS', 'BCPC', 'BCIP', 'BCPO', 'OBCDS')


PRINT '<<<<< INFORMACION DE BURO DE CREDITO" >>>>>'
PRINT '==========================================='
PRINT '<<<<< PARAMETRO "BURO DE CREDITO VERSION" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCVR' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO VERSION','BCVR','C', '13', 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = '13'
    WHERE pa_nemonico = 'BCVR' and pa_producto = 'CRE'

PRINT '<<<<< PARAMETRO "BURO DE CREDITO NUMERO DE REFERENCIA OPERDADOR" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCNO' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO NUMERO DE REFERENCIA OPERDADOR','BCNO','C', '                         ', 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = '                         '
    WHERE pa_nemonico = 'BCNO' and pa_producto = 'CRE'

PRINT '<<<<< PARAMETRO "BURO DE CREDITO PRODUCTO REQUERIDO" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCPR' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO PRODUCTO REQUERIDO','BCPR','C', '548', 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = '548'
    WHERE pa_nemonico = 'BCPR' and pa_producto = 'CRE'

PRINT '<<<<< PARAMETRO "BURO DE CREDITO CLAVE PAIS" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCCP' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO CLAVE PAIS','BCCP','C', 'MX', 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = 'MX'
    WHERE pa_nemonico = 'BCCP' and pa_producto = 'CRE'

PRINT '<<<<< PARAMETRO "BURO DE CREDITO CLAVE USUARIO" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCCU' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO CLAVE USUARIO','BCCU','C', 'ZM11001029', 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = 'ZM11001029'
    WHERE pa_nemonico = 'BCCU' and pa_producto = 'CRE'

PRINT '<<<<< PARAMETRO "BURO DE CREDITO PASSWORD" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCPW' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO PASSWORD','BCPW','C', '7w8ic2ZF', 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = '7w8ic2ZF'
    WHERE pa_nemonico = 'BCPW' and pa_producto = 'CRE'

PRINT '<<<<< PARAMETRO "BURO DE CREDITO TIPO CONSULTA" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCTQ' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO TIPO CONSULTA','BCTQ','C', 'I', 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = 'I'
    WHERE pa_nemonico = 'BCTQ' and pa_producto = 'CRE'

PRINT '<<<<< PARAMETRO "BURO DE CREDITO TIPO CONTRATO" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCTC' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO TIPO CONTRATO','BCTC','C', 'SE', 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = 'SE'
    WHERE pa_nemonico = 'BCTC' and pa_producto = 'CRE'

PRINT '<<<<< PARAMETRO "BURO DE CREDITO CLAVE UNIDAD MONETARIA" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCUM' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO CLAVE UNIDAD MONETARIA','BCUM','C', 'MX', 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = 'MX'
    WHERE pa_nemonico = 'BCUM' and pa_producto = 'CRE'

PRINT '<<<<< PARAMETRO "BURO DE CREDITO IMPORTE CONTRATO" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCIC' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO IMPORTE CONTRATO','BCIC','C', '000000000', 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = '000000000'
    WHERE pa_nemonico = 'BCIC' and pa_producto = 'CRE'

PRINT '<<<<< PARAMETRO "BURO DE CREDITO IDIOMA" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCID' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO IDIOMA','BCID','C','SP', 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = 'SP'
    WHERE pa_nemonico = 'BCID' and pa_producto = 'CRE'

PRINT '<<<<< PARAMETRO "BURO DE CREDITO TIPO SALIDA" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCTS' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO TIPO SALIDA','BCTS','C', '01', 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = '01'
    WHERE pa_nemonico = 'BCTS' and pa_producto = 'CRE'

PRINT '<<<<< PARAMETRO "BURO DE CREDITO PARAMETRO CADUCIDAD" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCPC' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_int, pa_producto)
    values ('BURO DE CREDITO PARAMETRO CADUCIDAD','BCPC','I', 60, 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'I', pa_int = 60
    WHERE pa_nemonico = 'BCPC' and pa_producto = 'CRE'

PRINT '<<<<< PARAMETRO "BURO DE CREDITO IP" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCIP' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO IP','BCIP','C', '128.9.55.102', 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = '128.9.55.102'
    WHERE pa_nemonico = 'BCIP' and pa_producto = 'CRE'

PRINT '<<<<< PARAMETRO "BURO DE CREDITO PUERTO" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCPO' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO PUERTO','BCPO','C', '45000', 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = '45000'
    WHERE pa_nemonico = 'BCPO' and pa_producto = 'CRE'

PRINT '<<<<< OBTENER BURO DE CREDITO DESDE SERVICIO >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'OBCDS' and pa_producto = 'CRE')    
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_int, pa_producto)
    values ('OBTENER BURO DE CREDITO DESDE SERVICIO','OBCDS','I', 1, 'CRE')
else
    UPDATE cobis..cl_parametro SET pa_tipo = 'I', pa_int = 1
    WHERE pa_nemonico = 'OBCDS' and pa_producto = 'CRE'
GO

select * from cobis..cl_parametro
where pa_nemonico in ('BCVR', 'BCNO', 'BCPR', 'BCCP', 'BCCU', 'BCPW', 'BCTQ', 'BCTC', 'BCUM', 'BCIC', 'BCID', 'BCTS', 'BCPC', 'BCIP', 'BCPO', 'OBCDS')
