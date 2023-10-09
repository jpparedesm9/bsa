use cobis
go


if exists (select 1 FROM cobis..cl_errores WHERE numero = 357529)
begin
 delete from cobis..cl_errores where numero = 357529
end

INSERT INTO dbo.cl_errores (numero, severidad, mensaje)
VALUES (357529, 1, 'EL CONTRATO YA SE ENCUENTRA REGISTRADO PARA PRODUCTO BANCARIO')
GO



/*************/
/*   TABLA   */
/*************/
delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('re_plantillas','cl_est_plantillas_contratos')
   and codigo = cp_tabla
go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('re_plantillas','cl_est_plantillas_contratos')
   and cl_tabla.codigo = cl_catalogo.tabla
go

delete cl_tabla
 where cl_tabla.tabla in ('re_plantillas','cl_est_plantillas_contratos')
go

declare @w_codigo smallint

select @w_codigo = max(codigo) + 1
from cl_tabla

select @w_codigo = @w_codigo + 1

print 're_plantillas'

insert into cobis..cl_tabla values(@w_codigo,'re_plantillas','Plantillas de Contratos')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CONAHO.RPT','CONTRATO AHORROS - PER NAT'     ,'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CERASA.RPT','CERTIFICADO APORTACION(ANVERSO)','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CERASR.RPT','CERTIFICADO APORTACION(REVERSO)','V')
insert into cobis..cl_catalogo_pro(cp_producto, cp_tabla) values('PER',@w_codigo)
select @w_codigo = @w_codigo + 1


print 'cl_est_plantillas_contratos'

insert into cobis..cl_tabla values(@w_codigo,'cl_est_plantillas_contratos','Estados de Plantillas de Contratos')
insert into cobis..cl_catalogo(tabla,codigo,valor,estado)  values(@w_codigo,'V','VIGENTE','V')
insert into cobis..cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo,'I','INACTIVO','V')
insert into cobis..cl_catalogo_pro values('AHO',@w_codigo)
 
select @w_codigo = @w_codigo + 1


update cl_seqnos set siguiente = @w_codigo
where tabla='cl_tabla'
go

