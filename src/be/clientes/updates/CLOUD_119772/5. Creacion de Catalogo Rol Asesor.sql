use cobis
go

DECLARE @w_id_catalogo INT

SELECT @w_id_catalogo = max(codigo) + 1 FROM cl_tabla

if not exists (select 1 from cl_tabla where tabla = 'cl_rol_asesor_colectivo')
begin
   INSERT INTO cl_tabla (codigo,tabla,descripcion)
   VALUES (@w_id_catalogo,'cl_rol_asesor_colectivo','Roles Asesores Colectivos')
end

SELECT @w_id_catalogo = codigo FROM cl_tabla WHERE tabla = 'cl_rol_asesor_colectivo'

if not exists (select 1 from cl_catalogo where tabla = @w_id_catalogo and codigo = 'ASE')
begin
   INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   VALUES (@w_id_catalogo, 'ASE', 'ASESOR', 'V', NULL, NULL, NULL)
end
else
begin
   delete from cl_catalogo where tabla = @w_id_catalogo and codigo = 'ASE'
   INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   VALUES (@w_id_catalogo, 'ASE', 'ASESOR', 'V', NULL, NULL, NULL)
end

if not exists (select 1 from cl_catalogo where tabla = @w_id_catalogo and codigo = 'GOF')
begin
   INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   VALUES (@w_id_catalogo, 'GOF', 'GERENTE OFICINA', 'V', NULL, NULL, NULL)
end
else
begin
   delete from cl_catalogo where tabla = @w_id_catalogo and codigo = 'GOF'
   INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   VALUES (@w_id_catalogo, 'GOF', 'GERENTE OFICINA', 'V', NULL, NULL, NULL)
end

if not exists (select 1 from cl_catalogo where tabla = @w_id_catalogo and codigo = 'COO')
begin
   INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   VALUES (@w_id_catalogo, 'COO', 'COORDINADOR', 'V', NULL, NULL, NULL)
end
else
begin
   delete from cl_catalogo where tabla = @w_id_catalogo and codigo = 'COO'
   INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   VALUES (@w_id_catalogo, 'COO', 'COORDINADOR', 'V', NULL, NULL, NULL)
end

if not exists (select 1 from cl_catalogo where tabla = @w_id_catalogo and codigo = 'AAD')
begin
   INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   VALUES (@w_id_catalogo, 'AAD', 'ANALISTA ADMINISTRATIVO', 'V', NULL, NULL, NULL)
end
else
begin
   delete from cl_catalogo where tabla = @w_id_catalogo and codigo = 'AAD'
   INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   VALUES (@w_id_catalogo, 'AAD', 'ANALISTA ADMINISTRATIVO', 'V', NULL, NULL, NULL)
end

go