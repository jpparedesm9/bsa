use cobis
go

------------------------------------------------------------ Oficina AVON ---------------------------------------------------------------------
declare @w_descripcion  varchar (25),
        @w_cod_ofi      int,
        @w_cod_cargo    int,
		@w_counter      int
        

select @w_cod_ofi = of_oficina from cobis..cl_oficina where of_nombre = 'AVON'
select @w_descripcion = 'DEPARTAMENTO EXTERNO'


if exists ( select 1 from cobis..cl_departamento where de_descripcion = @w_descripcion and de_oficina = @w_cod_ofi)
begin
   delete from cobis..cl_departamento where de_descripcion = @w_descripcion and de_oficina = @w_cod_ofi
   INSERT INTO cobis..cl_departamento (de_departamento,de_filial,de_oficina,de_descripcion,de_o_oficina,de_o_departamento,de_nivel) 
   VALUES(6,1,@w_cod_ofi,@w_descripcion,null,null,0)
end
else
begin
   INSERT INTO cobis..cl_departamento (de_departamento,de_filial,de_oficina,de_descripcion,de_o_oficina,de_o_departamento,de_nivel) 
   VALUES(6,1,@w_cod_ofi,@w_descripcion,null,null,0)
end

-- Asociar el departamento al cargo
select @w_cod_cargo = codigo from cobis..cl_catalogo where valor = 'ASESOR EXTERNO'

if not exists (select 1 from cobis..cl_distributivo where ds_departamento = 6 and ds_oficina = @w_cod_ofi and ds_cargo = @w_cod_cargo)
begin
   select @w_counter = 1
   while (@w_counter <= 20) begin       
      INSERT INTO cobis..cl_distributivo (ds_filial,ds_oficina,ds_departamento,ds_cargo,ds_secuencial,ds_fecha,ds_estado,ds_numero,ds_vacante) 
      VALUES(1,@w_cod_ofi,6,@w_cod_cargo,@w_counter,getdate(),'V',null,'S')
	  select @w_counter = @w_counter + 1
   end
   
end
else
begin
   delete from cobis..cl_distributivo where ds_departamento = 6 and ds_oficina = @w_cod_ofi and ds_cargo = @w_cod_cargo
   select @w_counter = 1
   while (@w_counter <= 20) begin
      INSERT INTO cobis..cl_distributivo (ds_filial,ds_oficina,ds_departamento,ds_cargo,ds_secuencial,ds_fecha,ds_estado,ds_numero,ds_vacante) 
      VALUES(1,@w_cod_ofi,6,@w_cod_cargo,@w_counter,getdate(),'V',null,'S')
	  select @w_counter = @w_counter + 1
   end
end


------------------------------------------------------------ Oficina Independiente ---------------------------------------------------------------------



select @w_cod_ofi = of_oficina from cobis..cl_oficina where of_nombre = 'INDEPENDIENTE COLECTIVO'

if exists ( select 1 from cobis..cl_departamento where de_descripcion = @w_descripcion and de_oficina = @w_cod_ofi)
begin
   delete from cobis..cl_departamento where de_descripcion = @w_descripcion and de_oficina = @w_cod_ofi
   INSERT INTO cobis..cl_departamento (de_departamento,de_filial,de_oficina,de_descripcion,de_o_oficina,de_o_departamento,de_nivel) 
   VALUES(6,1,@w_cod_ofi,@w_descripcion,null,null,0)
end
else
begin
   INSERT INTO cobis..cl_departamento (de_departamento,de_filial,de_oficina,de_descripcion,de_o_oficina,de_o_departamento,de_nivel) 
   VALUES(6,1,@w_cod_ofi,@w_descripcion,null,null,0)
end

-- Asociar el departamento al cargo
select @w_cod_cargo = codigo from cobis..cl_catalogo where valor = 'ASESOR EXTERNO'

if not exists (select 1 from cobis..cl_distributivo where ds_departamento = 6 and ds_oficina = @w_cod_ofi and ds_cargo = @w_cod_cargo)
begin
   select @w_counter = 1
   while (@w_counter <= 20)  begin     
      INSERT INTO cobis..cl_distributivo (ds_filial,ds_oficina,ds_departamento,ds_cargo,ds_secuencial,ds_fecha,ds_estado,ds_numero,ds_vacante) 
      VALUES(1,@w_cod_ofi,6,@w_cod_cargo,@w_counter,getdate(),'V',null,'S')
	  select @w_counter = @w_counter + 1
   end
end
else
begin
   delete from cobis..cl_distributivo where ds_departamento = 6 and ds_oficina = @w_cod_ofi and ds_cargo = @w_cod_cargo
   select @w_counter = 1
   while (@w_counter <= 20)  begin     
      INSERT INTO cobis..cl_distributivo (ds_filial,ds_oficina,ds_departamento,ds_cargo,ds_secuencial,ds_fecha,ds_estado,ds_numero,ds_vacante) 
      VALUES(1,@w_cod_ofi,6,@w_cod_cargo,@w_counter,getdate(),'V',null,'S')
	  select @w_counter = @w_counter + 1
   end
end

select * from cobis..cl_departamento 
select * from cobis..cl_distributivo order by ds_fecha desc

go
