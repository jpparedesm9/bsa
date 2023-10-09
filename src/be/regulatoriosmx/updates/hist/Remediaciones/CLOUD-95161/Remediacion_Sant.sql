-------------------------
-- CAMBIOS A ESTRUCTURAS
-------------------------

use cobis
go

print '=====> te_relacion_dolar'
go

drop table te_relacion_dolar
go


create table te_relacion_dolar
       (rd_cod_moneda         tinyint    not null,
        rd_fecha_inicial      datetime   not null,
        rd_fecha_final        datetime   not null,
        rd_estado             char       null,
        rd_valor              float      not null,
        rd_secuencial         int        not null,
        rd_valor_v            float      not null,
        rd_operador           char       null,
        rd_cot_comp           float      null,  
        rd_cot_vent           float      null,
        rd_cod_mercado        tinyint    null
)
go

alter table te_tasa_divisas add td_autorizado char(1) null
go

print '=====> cl_estructura_pais'
go

declare @w_codigo int

select @w_codigo = max(codigo) + 1
from   cobis..cl_tabla

if exists (select 1 from cobis..cl_tabla where tabla = 'cl_estructura_pais')
begin
   delete cobis..cl_catalogo where tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_estructura_pais' )
   delete cobis..cl_catalogo_pro where cp_tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_estructura_pais' )
   delete cobis..cl_tabla where tabla = 'cl_estructura_pais'

end

insert into cl_tabla  (codigo, tabla, descripcion)
      values  (@w_codigo, 'cl_estructura_pais', 'Definicion inicial de Estructura Geografica')

insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'D', 'N', 'V')  -- depart_pais
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'P', 'S', 'V')  -- Provincia
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'B', 'S', 'V')  -- Barrio/Parroquia
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, 'A', 'N', 'V')  -- Canton

insert into cl_catalogo_pro (cp_producto, cp_tabla) values  ('ADM', @w_codigo)

select @w_codigo = @w_codigo + 1
insert into cl_tabla  (codigo, tabla, descripcion)
      values  (@w_codigo, 'cl_homologa_departpais', 'Codigos alternos de Departamentos')

insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '0', '1628', 'V')  -- depart_pais
insert into cl_catalogo (tabla,codigo,valor,estado) values (@w_codigo, '1', '1678', 'V')  -- Provincia

insert into cl_catalogo_pro (cp_producto, cp_tabla) values  ('ADM', @w_codigo)

update cobis..cl_seqnos
set    siguiente = @w_codigo 
where  tabla     = 'cl_tabla'
go

update cobis..cl_catalogo set type = type

go
