use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'REM'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in ('fp_tipo_rubro')
go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('fp_tipo_rubro')
and cl_tabla.codigo = cl_catalogo.tabla
go                                     
  
delete cl_tabla                          
 where cl_tabla.tabla in ('fp_tipo_rubro')
go

declare @w_tabla smallint

select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'fp_tipo_rubro', 'Tipos de valor de Rubros')
insert into cl_catalogo_pro values ('REM', @w_tabla )

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'C', 'CAPITAL', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'I', 'INTERES', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'M', 'MORA', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'O', 'PORCENTAJE', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'Q', 'CALCULADO', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'V', 'TIPO VALOR FIJO', 'V', NULL, NULL, NULL)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_tabla, 'S', 'SEGURO', 'V', NULL, NULL, NULL)

go

