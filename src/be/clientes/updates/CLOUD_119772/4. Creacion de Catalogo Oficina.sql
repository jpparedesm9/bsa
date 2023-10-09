declare @w_tabla int,
        @w_codigo varchar(10),
        @w_nombre varchar(25)

select @w_tabla=codigo from cobis..cl_tabla where tabla = 'cl_oficina'
select @w_codigo = of_oficina,@w_nombre = of_nombre from cobis..cl_oficina where of_nombre = 'AVON'

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
select @w_codigo = of_oficina,@w_nombre = of_nombre from cobis..cl_oficina where of_nombre = 'INDEPENDIENTE'

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

go
