use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('ah_causa_bloq_contb','ah_causa_desbloq_contb','re_plantillas')
  and codigo = cp_tabla

delete cl_catalogo  from cl_tabla
 where cl_tabla.tabla in ('ah_causa_bloq_contb','ah_causa_desbloq_contb','re_plantillas')
   and cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
 where cl_tabla.tabla in ('ah_causa_bloq_contb','ah_causa_desbloq_contb','re_plantillas')

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
  
select @w_codigo= @w_codigo + 1
insert into cl_tabla (codigo, tabla, descripcion) values(@w_codigo,'ah_causa_desbloq_contb','Causas de desbloqueos Contabilizables')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '18', 'DESBLOQUEO PIGNOCRACION DE CUENTA', 'V')


select @w_codigo= @w_codigo + 1
insert into cl_tabla (codigo, tabla, descripcion) values(@w_codigo,'ah_causa_bloq_contb','Causas de bloqueos Contabilizables')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '18', 'BLOQUEO PIGNOCRACION DE CUENTA', 'V')



select @w_codigo = @w_codigo + 1

print 're_plantillas'

insert into cobis..cl_tabla values(@w_codigo,'re_plantillas','Plantillas de Contratos')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CONAHO.RPT','CONTRATO AHORROS PERSONA'     ,'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CONAHJ.RPT','CONTRATO AHORROS JURIDICO'     ,'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CERASA.RPT','CERTIFICADO APORTACION PERSONA','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CERASJ.RPT','CERTIFICADO APORTACION JURIDICO'     ,'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'AHPROP.RPT','CONTRATO AHORROS CONTRACTUAL PERSONA','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'AHPROJ.RPT','CONTRATO AHORROS CONTRACTUAL JURIDICO','V')
insert into cobis..cl_catalogo_pro(cp_producto, cp_tabla) values('PER',@w_codigo)
select @w_codigo = @w_codigo + 1


update cl_seqnos
set siguiente = @w_codigo where tabla = 'cl_tabla'

go

use cob_remesas
go


UPDATE cob_remesas..re_concepto_contable 
SET cc_causa = 18 
WHERE cc_producto =4 
AND cc_tipo_tran IN (217, 218)

   
go