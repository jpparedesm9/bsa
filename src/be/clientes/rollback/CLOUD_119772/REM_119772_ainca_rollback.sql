----------------------------------------------------------------------------------------------------------
-- 1. Eliminacion de roles
----------------------------------------------------------------------------------------------------------

declare @w_descripcion varchar (25)

SELECT  @w_ro_descripcion  = 'ASESOR EXTERNO'
DELETE FROM cobis..ad_rol WHERE ro_descripcion = @w_ro_descripcion

select @w_ro_descripcion = 'PERFIL MOVIL'
DELETE FROM cobis..ad_rol WHERE ro_descripcion = @w_ro_descripcion

----------------------------------------------------------------------------------------------------------
--- 2. Eliminacion de CARGO ASESOR EXTERNO
----------------------------------------------------------------------------------------------------------

declare 
@w_cod_cargo int

select @w_cod_cargo = codigo from cobis..cl_tabla where tabla = 'cl_cargo'
print 'Codigo de la tabla:  ' + convert(varchar(3),@w_cod_cargo)

delete from cobis..cl_catalogo where tabla = @w_cod_cargo and valor = 'ASESOR EXTERNO'

----------------------------------------------------------------------------------------------------------
--- 3. Eliminacion de DISTRIBUTIVO Y DEPARTAMENTO
----------------------------------------------------------------------------------------------------------
declare @w_descripcion varchar (25),
        @w_cod_ofi     int,
        @w_cod_cargo    int
        

select @w_cod_ofi = of_oficina from cobis..cl_oficina where of_nombre = 'COLECTIVO AVON'
select @w_descripcion = 'DEPARTAMENTO EXTERNO'
select @w_cod_cargo = codigo from cobis..cl_catalogo where valor = 'ASESOR EXTERNO'

delete from cobis..cl_departamento where de_descripcion = @w_descripcion and de_oficina = @w_cod_ofi
delete from cobis..cl_distributivo where ds_departamento = 6 and ds_oficina = @w_cod_ofi and ds_cargo = @w_cod_cargo

select @w_cod_ofi = of_oficina from cobis..cl_oficina where of_nombre = 'COLECTIVO INDEPENDIENTE'
delete from cobis..cl_departamento where de_descripcion = @w_descripcion and de_oficina = @w_cod_ofi
delete from cobis..cl_distributivo where ds_departamento = 6 and ds_oficina = @w_cod_ofi and ds_cargo = @w_cod_cargo

----------------------------------------------------------------------------------------------------------
--- 4. Eliminacion de catalogo oficina 
----------------------------------------------------------------------------------------------------------
declare @w_tabla int,
        @w_codigo varchar(10),
        @w_nombre varchar(25)

select @w_tabla=codigo from cobis..cl_tabla where tabla = 'cl_oficina'
select @w_codigo = of_oficina,@w_nombre = of_nombre from cobis..cl_oficina where of_nombre = 'COLECTIVO AVON'
delete from cobis..cl_catalogo where tabla = @w_tabla and codigo = @w_codigo

select @w_tabla=codigo from cobis..cl_tabla where tabla = 'cl_oficina'
select @w_codigo = of_oficina,@w_nombre = of_nombre from cobis..cl_oficina where of_nombre = 'COLECTIVO INDEPENDIENTE'
delete from cobis..cl_catalogo where tabla = @w_tabla and codigo = @w_codigo

