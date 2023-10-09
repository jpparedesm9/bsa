USE cobis
GO

--cr_doc_digitalizado_flujo_ind
print 'cr_doc_digitalizado_flujo_ind'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
SELECT @w_tabla = codigo FROM cobis..cl_tabla  WHERE tabla = 'cr_doc_digitalizado_flujo_ind'


SELECT c.codigo, c.valor, c.estado, t.tabla, t.descripcion FROM cobis..cl_catalogo c, cobis..cl_tabla t 
WHERE c.tabla = t.codigo 
AND t.codigo = @w_tabla
ORDER BY t.tabla, c.codigo



update cobis..cl_catalogo set valor = 'IDENTIFICACION FRONTAL INDIVIDUAL' where tabla = @w_tabla and codigo = '001'
update cobis..cl_catalogo set valor = 'IDENTIFICACION TRASERA INDIVIDUAL' where tabla = @w_tabla and codigo = '002'
update cobis..cl_catalogo set valor = 'COMPROBANTE DOMICILIO INDIVIDUAL'  where tabla = @w_tabla and codigo = '003'
update cobis..cl_catalogo set valor = 'AVISO DE PRIVACIDAD INDIVIDUAL'    where tabla = @w_tabla and codigo = '004'
update cobis..cl_catalogo set valor = 'AUTORIZACION BURO INDIVIDUAL'      where tabla = @w_tabla and codigo = '005'
update cobis..cl_catalogo set valor = 'AVISO DE PRIVACIDAD AVAL'          where tabla = @w_tabla and codigo = '006'
update cobis..cl_catalogo set valor = 'AUTORIZACION BURO AVAL'            where tabla = @w_tabla and codigo = '007'
update cobis..cl_catalogo set valor = 'IDENTIFICACION FRONTAL AVAL'       where tabla = @w_tabla and codigo = '008'
update cobis..cl_catalogo set valor = 'IDENTIFICACION TRASERA AVAL'       where tabla = @w_tabla and codigo = '009'
update cobis..cl_catalogo set valor = 'COMPROBANTE DOMICILIO AVAL'        where tabla = @w_tabla and codigo = '010'


SELECT c.codigo, c.valor, c.estado, t.tabla, t.descripcion FROM cobis..cl_catalogo c, cobis..cl_tabla t 
WHERE c.tabla = t.codigo 
AND t.codigo = @w_tabla
ORDER BY t.tabla, c.codigo


GO
--//////////////////////////////////////////////////////////////

print 'cr_destino'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
SELECT @w_tabla = codigo FROM cobis..cl_tabla  WHERE tabla = 'cr_destino'


SELECT c.codigo, c.valor, c.estado, t.tabla, t.descripcion FROM cobis..cl_catalogo c, cobis..cl_tabla t 
WHERE c.tabla = t.codigo 
AND t.codigo = @w_tabla
ORDER BY t.tabla, c.codigo


update cobis..cl_catalogo set valor = 'COMPRA DE ACTIVO' where tabla = @w_tabla and codigo = '02'

DELETE cobis..cl_catalogo WHERE tabla = @w_tabla AND  codigo NOT IN ('01','02')


SELECT c.codigo, c.valor, c.estado, t.tabla, t.descripcion FROM cobis..cl_catalogo c, cobis..cl_tabla t 
WHERE c.tabla = t.codigo 
AND t.codigo = @w_tabla
ORDER BY t.tabla, c.codigo


GO
--//////////////////////////////////////////////////////////////


print 'cl_estado_ser'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
SELECT @w_tabla = codigo FROM cobis..cl_tabla  WHERE tabla = 'cl_estado_ser'


SELECT c.codigo, c.valor, c.estado, t.tabla, t.descripcion FROM cobis..cl_catalogo c, cobis..cl_tabla t 
WHERE c.tabla = t.codigo 
AND t.codigo = @w_tabla
ORDER BY t.tabla, c.codigo



update cobis..cl_tabla set descripcion = 'Estados de Registros' where codigo = @w_tabla 
DELETE cobis..cl_catalogo WHERE tabla = @w_tabla AND  codigo = 'X'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'X','Producto Deshabilitado','V')

SELECT c.codigo, c.valor, c.estado, t.tabla, t.descripcion FROM cobis..cl_catalogo c, cobis..cl_tabla t 
WHERE c.tabla = t.codigo 
AND t.codigo = @w_tabla
ORDER BY t.tabla, c.codigo


GO
--//////////////////////////////////////////////////////////////

print 'cl_moneda'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
SELECT @w_tabla = codigo FROM cobis..cl_tabla  WHERE tabla = 'cl_moneda'


SELECT c.codigo, c.valor, c.estado, t.tabla, t.descripcion FROM cobis..cl_catalogo c, cobis..cl_tabla t 
WHERE c.tabla = t.codigo 
AND t.codigo = @w_tabla
ORDER BY t.tabla, c.codigo



update cobis..cl_catalogo set valor = 'PESOS MEXICANOS' where tabla = @w_tabla and codigo = '0'

SELECT c.codigo, c.valor, c.estado, t.tabla, t.descripcion FROM cobis..cl_catalogo c, cobis..cl_tabla t 
WHERE c.tabla = t.codigo 
AND t.codigo = @w_tabla
ORDER BY t.tabla, c.codigo


GO
--//////////////////////////////////////////////////////////////


print 'cl_tipo_documento'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
SELECT @w_tabla = codigo FROM cobis..cl_tabla  WHERE tabla = 'cl_tipo_documento'


SELECT c.codigo, c.valor, c.estado, t.tabla, t.descripcion FROM cobis..cl_catalogo c, cobis..cl_tabla t 
WHERE c.tabla = t.codigo 
AND t.codigo = @w_tabla
ORDER BY t.tabla, c.codigo



DELETE cobis..cl_catalogo where tabla = @w_tabla and codigo <> 'CURP'

SELECT c.codigo, c.valor, c.estado, t.tabla, t.descripcion FROM cobis..cl_catalogo c, cobis..cl_tabla t 
WHERE c.tabla = t.codigo 
AND t.codigo = @w_tabla
ORDER BY t.tabla, c.codigo


GO
--//////////////////////////////////////////////////////////////


