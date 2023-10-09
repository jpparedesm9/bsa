use cobis
go

/*************/
/*   TABLA   */
/*************/

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('cc_plazas_bco_rep')
  and codigo = cp_tabla

go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('cc_plazas_bco_rep')
   and cl_tabla.codigo = cl_catalogo.tabla

go

delete cl_tabla
 where cl_tabla.tabla in ('cc_plazas_bco_rep')
go
----------------------------------------------------------
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
-------------------------------------------------

select @w_codigo= @w_codigo + 1
print 'Catálogo cc_plazas_bco_rep'
INSERT INTO cl_tabla (codigo, tabla, descripcion) VALUES (@w_codigo, 'cc_plazas_bco_rep', 'Plazas Banco de la Republica')

insert into cl_catalogo_pro values ('CTA', @w_codigo)
 
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1000', 'CANJE DIRECTO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1240', 'MAGANGUE', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1352', 'APARTADO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1503', 'TUNJA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1507', 'DUITAMA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1516', 'SOGAMOSO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1530', 'CHIQUINQUIRA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '1803', 'MANIZALES', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2000', 'CANJE DELEGADO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2401', 'AGUACHICA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2403', 'VALLEDUPAR', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '2703', 'MONTERIA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '3000', 'CANJE REPUBLICA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '3164', 'LA DORADA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '3303', 'QUIBDO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '3603', 'RIOHACHA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '3905', 'NEIVA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '4209', 'CIENAGA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '4210', 'SANTA MARTHA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '4212', 'FUNDACION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '4501', 'VILLAVICENCIO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '4801', 'PASTO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '4806', 'IPIALES', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '5101', 'CUCUTA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '5120', 'OCANA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '5401', 'ARMENIA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '5703', 'PEREIRA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6020', 'BARRANCABERMEJA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6042', 'SAN GIL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6044', 'SOCORRO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6303', 'SINCELEJO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6601', 'IBAGUE', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6635', 'ESPINAL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6918', 'POPAYAN', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6950', 'SEVILLA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6955', 'TULUA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '6963', 'BUENAVENTURA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '7103', 'LETICIA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '7303', 'ARAUCA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '7503', 'FLORENCIA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '8103', 'SAN ANDRES', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '8603', 'YOPAL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
VALUES (@w_codigo, '9000', 'NACIONAL CEDEC', 'V')

update cl_seqnos 
   set siguiente = @w_codigo 
 where tabla = 'cl_tabla'   

go


GO
