
use cob_remesas
go

print 'ALTER TABLA ====> pe_pro_rango_edad'
if not exists(select * from syscolumns a, sysobjects b
  where b.name = 'pe_pro_rango_edad' and
        a.id = b.id and
        a.name = 're_estado')
begin
 alter table pe_pro_rango_edad add re_estado  char(1) null
end

print 're_codigo_Key'
if exists (select i.name from sysindexes i, sysobjects o
    where i.id = o.id and i.name = 're_codigo_Key' and o.name = 'pe_pro_rango_edad')
drop index pe_pro_rango_edad.re_codigo_Key
go

print 're_codigo_Key on pe_mercado'
CREATE UNIQUE INDEX re_codigo_Key on pe_pro_rango_edad(
                re_codigo)
go
        
Declare @w_maximo int

SELECT @w_maximo = re_codigo from cob_remesas..pe_pro_rango_edad

if not exists (select 1 from cobis..cl_seqnos where tabla = 'pe_pro_rango_edad' and bdatos = 'cob_remesas')
begin
INSERT into cobis..cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_remesas', 'pe_pro_rango_edad',@w_maximo,'re_codigo')           
end

DELETE FROM cobis..cl_errores where numero in(357580,357581,357582,357583,357584)

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (357580, 0, 'RANGO DE FECHA YA EXISTE')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (357581, 0, 'ERROR AL OBTENER SECUENCIAL PE_PRO_RANGO_EDAD')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (357582, 0, 'ERROR AL INGRESAR RANGO EDAD')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (357583, 0, 'ERROR AL ACTUALIZAR RANGO EDAD')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (357584, 0, 'ERROR AL ELIMINAR RANGO EDAD')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (357585, 0, 'RANGO EDAD ESTA SIENDO USANDO EN UN PRODUCTO FINAL')
GO

update cob_remesas..pe_pro_rango_edad set re_estado = 'V' where re_estado is null
GO
