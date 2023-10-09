USE cob_remesas 
GO

DELETE from cob_remesas..pe_capitaliza_profinal
WHERE cp_profinal in (SELECT pf_pro_final  FROM cob_remesas..pe_pro_final WHERE pf_pro_final IN ( 1,6,11,2,3,4,5,7,10))
and cp_tipo_capitalizacion = 'M'   
go

use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('ah_caulev_blqva','ah_causa_bloqueo_val')
  and codigo = cp_tabla

delete cl_catalogo  from cl_tabla
 where cl_tabla.tabla in ('ah_caulev_blqva','ah_causa_bloqueo_val')
   and cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
 where cl_tabla.tabla in ('ah_caulev_blqva','ah_causa_bloqueo_val')

declare @w_maxtabla smallint

select @w_maxtabla = isnull(max(codigo), 0) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'

select @w_codigo = @w_codigo + 1
print 'Causa lev blq valor AHO'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_caulev_blqva', 'Causa lev blq valor AHO')
insert into cl_catalogo_pro values ('AHO', @w_codigo)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '0', 'MIGRACION', 'C')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '18', 'LEVANTAMIENTO PIGNORACION DE CUENTA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '10', 'SECUESTRO/EMBARGO JUDICIAL', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '11', 'DEPTO COBROS', 'B')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '12', 'ORDEN SUPERINTENDENCIA DE BANCOS', 'B')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '13', 'POR ORDEN DEL CLIENTE', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '14', 'POR ORDEN DEL BANCO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '15', 'POR ORDEN DE AUTORIDAD COMPETENTE', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '2', 'POR CIERRE DE CUENTA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '3', 'ENTIDAD JUDICIAL', 'B')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '4', 'CARTA PROMESA DE PAGO/CARTA DE GARANTIA', 'E')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '5', 'LINEA DE SOBREGIRO', 'E')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '6', 'LINEA DE CREDITO', 'E')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '7', 'TARJETA CREDITO', 'E')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '8', 'PRESTAMO CORPORATIVO', 'B')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '9', 'PRESTAMO PERSONAL', 'B')


select @w_codigo = @w_codigo + 1
print 'Causa de Bloqueo  de Valores AH'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_causa_bloqueo_val', 'Causa de Bloqueo  de Valores AH')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '0', 'MIGRACION', 'C')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '18', 'PIGNORACION DE CUENTA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '10', 'PIGNORACION PRESTAMO PERSONAL', 'C')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '11', 'PIGNORACION PRESTAMO CORPORATIVO', 'C')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '12', 'DEPTO. COBROS', 'C')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '13', 'RESERVA PYME', 'C')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '14', 'RETENCION CONSUMO', 'C')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '15', 'ENTIDAD JUDICIAL', 'B')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '16', 'ORDEN SUPERINTENDENCIA DE BANCOS', 'B')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '17', 'CONGELAMIENTO DE FONDOS', 'B')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '2', 'DECISION DEL BANCO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '3', 'ORDEN AUTORIDAD COMPETENTE', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '4', 'SOLICITUD DE CLIENTE', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '5', 'PIGNORACION DE FONDOS', 'B')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '6', 'PIGNORACION LINEA DE CREDITO', 'C')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '7', 'PIGNORACION CARTA PROMESA DE PAGO/CARTA DE GARANTIA', 'C')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '8', 'PIGNORACION CARTA DE CREDITO', 'C')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '9', 'PIGNORACION TARJETA CREDITO', 'C')

update cl_seqnos
set siguiente = @w_codigo where tabla = 'cl_tabla'

go

