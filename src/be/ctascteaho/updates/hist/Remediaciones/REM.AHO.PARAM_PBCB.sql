use cobis
go

if exists (select 1 from  cobis..cl_parametro   where  pa_producto = 'AHO' and pa_nemonico = 'PBCB' )
begin
delete from  cobis..cl_parametro 
  where  pa_producto = 'AHO' 
     and pa_nemonico = 'PBCB'     
     
end
     
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PRODUCTO BANCARIO PARA LAS REDES', 'PBCB', 'S', NULL, NULL, 0, NULL, NULL, NULL, NULL, 'AHO')
go


print '--> Catalogo: re_pro_banc_cb'

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('re_pro_banc_cb')
  and codigo = cp_tabla


delete cl_catalogo  from cl_tabla
 where cl_tabla.tabla in ('re_pro_banc_cb')
   and cl_tabla.codigo = cl_catalogo.tabla


delete cl_tabla
 where cl_tabla.tabla in ('re_pro_banc_cb')


declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'


select @w_codigo= @w_codigo + 1
insert into cl_tabla (codigo, tabla, descripcion) values(@w_codigo,'re_pro_banc_cb','Catalogo de Productos bancarios Cuenta Corresponsalia')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '0', 'CUENTA CORRESPONSALIA', 'V')

update cl_seqnos
   set siguiente = @w_codigo where tabla = 'cl_tabla'

go

use cod_remesas
go

delete from cod_remesas..re_accion_nd where an_producto = 4

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '10', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '11', 'E', 'S', NULL, 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '139', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '14', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '140', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '141', 'E', 'N', NULL, 'N', 'S')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '143', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '152', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '156', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '157', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '158', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '159', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '160', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '161', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '162', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '164', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '165', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '166', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '167', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '168', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '182', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '183', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '184', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '185', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '205', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '213', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '233', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '234', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '236', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '237', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '238', 'V', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '24', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '248', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '26', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '260', 'V', 'N', 'S', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '261', 'E', 'N', 'S', 'N', 'S')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '27', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '28', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '30', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '31', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '32', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '33', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '34', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '35', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '36', 'V', 'S', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '37', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '38', 'E', 'N', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '39', 'V', 'N', 'N', 'N', 'S')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '4', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '40', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '41', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '44', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '46', 'V', 'N', 'N', 'N', 'S')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '50', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '57', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '58', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '75', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '84', 'E', 'S', 'N', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '85', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '86', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '87', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '88', 'E', 'N', 'N', 'N', 'S')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '9', 'E', 'N', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '91', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '92', 'V', 'S', 'N', 'N', 'N')

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '93', 'E', 'N', 'S', 'N', NULL)

INSERT INTO cod_remesas..re_accion_nd (an_producto, an_causa, an_accion, an_comision, an_impuesto, an_modo, an_saldomin)
VALUES (4, '7', 'V', 'S', NULL, 'S', 'S')

go
