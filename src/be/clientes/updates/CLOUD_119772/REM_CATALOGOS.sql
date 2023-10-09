USE cobis
GO

DECLARE
@w_tabla          int,
@w_codigo         int

SELECT @w_tabla = codigo
FROM cobis..cl_tabla 
WHERE tabla = 'cl_tipo_mercado'


IF @w_tabla IS NOT NULL BEGIN

   DELETE cl_catalogo WHERE tabla = @w_tabla AND codigo IN ( 'ID', 'AV', 'MA')

   INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   VALUES (@w_tabla, 'ID', 'INDEPENDIENTE COLECTIVO', 'V', NULL, NULL, NULL)
   
   INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   VALUES (@w_tabla, 'AV', 'AVON', 'V', NULL, NULL, NULL)
   
   INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   VALUES (@w_tabla, 'I', 'INDEPENDIENTE', 'V', NULL, NULL, NULL)

end

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cl_colectivo')
DELETE cl_tabla WHERE tabla = 'cl_colectivo'

SELECT @w_tabla = max(isnull(codigo,0)) +1
FROM cl_tabla 

INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'cl_colectivo', 'Colectivos')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'ID', 'INDEPENDIENTE COLECTIVO', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'AV', 'AVON', 'V', NULL, NULL, NULL)



DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cl_nivel_cliente_colectivo')
DELETE cl_tabla WHERE tabla = 'cl_nivel_cliente_colectivo'

SELECT @w_tabla = max(isnull(codigo,0)) +1
FROM cl_tabla 

INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'cl_nivel_cliente_colectivo', 'Nivel Cliente Colectivo')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'O', 'ORO', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'P', 'PLATA', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'B', 'BRONCE', 'V', NULL, NULL, NULL)


DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cl_cuenta_dispersion_lcr')
DELETE cl_tabla WHERE tabla = 'cl_cuenta_dispersion_lcr'

SELECT @w_tabla = max(isnull(codigo,0)) +1
FROM cl_tabla 

INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'cl_cuenta_dispersion_lcr', 'Cuenta Dispersión LCR')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'CL', 'Cliente', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'CO', 'Colectivo', 'V', NULL, NULL, NULL)



select @w_tabla = codigo from cobis..cl_tabla where tabla = 'si_sincroniza'
if @w_tabla is not null begin
   print 'EMPIEZA FIRMAS Y CUESTIONARIO COLECTIVO'
   delete  cl_catalogo where tabla = @w_tabla and valor = 'FIRMAS Y CUESTIONARIO COLECTIVO'
   select  @w_codigo = isnull(max(codigo),0) + 1
   from cobis..cl_catalogo
   where tabla= @w_tabla
   
   insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   values (@w_tabla, isnull(@w_codigo,1), 'FIRMAS Y CUESTIONARIO COLECTIVO', 'V', NULL, NULL, NULL)
   
   print 'TERMINA FIRMAS Y CUESTIONARIO COLECTIVO'
   
   print 'EMPIEZA CUESTIONARIO COLECTIVO'
   delete  cl_catalogo where tabla = @w_tabla and valor = 'CUESTIONARIO COLECTIVO'
   select  @w_codigo = @w_codigo + 1
   
   insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   values (@w_tabla, isnull(@w_codigo,1), 'CUESTIONARIO COLECTIVO', 'V', NULL, NULL, NULL)
   print 'TERMINA CUESTIONARIO COLECTIVO'
end
GO