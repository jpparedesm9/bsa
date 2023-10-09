----------------------------------------------------------------------------------------------------------
--- CREACION CARGO ASESOR EXTERNO
----------------------------------------------------------------------------------------------------------
declare 
@w_cod_cargo int,
@w_cod_max   int

select @w_cod_cargo = codigo from cobis..cl_tabla where tabla = 'cl_cargo'
print 'Codigo de la tabla:  ' + convert(varchar(3),@w_cod_cargo)

if not exists (select top 1 * from cobis..cl_catalogo where tabla = @w_cod_cargo and valor = 'ASESOR EXTERNO')
begin
   
   select @w_cod_max  = max(convert(int,codigo))+1 from cobis..cl_catalogo where tabla = @w_cod_cargo
   print 'Codigo maximo de agencia: ' + convert(varchar(3),@w_cod_max)  
   
   INSERT INTO cobis..cl_catalogo (tabla,codigo,valor,estado,culture,equiv_code,type) 
   VALUES(@w_cod_cargo,@w_cod_max,'ASESOR EXTERNO','V',null,null,null)
   print 'Inserccion exitosa'
end
else begin
  print 'El registro ya existe'
end

go
