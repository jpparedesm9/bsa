use cob_sbancarios
go

truncate table sb_instrumentos

insert into sb_instrumentos
(in_cod_instrumento,in_nombre,in_estado,in_cod_producto,in_moneda,in_tipo_cotizacion)
values(1,'CHEQUES DE GERENCIA','A',4,0,'O')

insert into sb_instrumentos
(in_cod_instrumento,in_nombre,in_estado,in_cod_producto,in_moneda,in_tipo_cotizacion)
values(2,'CDTS','A',4,0,'E')

insert into sb_instrumentos
(in_cod_instrumento,in_nombre,in_estado,in_cod_producto,in_moneda,in_tipo_cotizacion)
values(3,'CDATS','A',4,0,'E')

insert into sb_instrumentos
(in_cod_instrumento,in_nombre,in_estado,in_cod_producto,in_moneda,in_tipo_cotizacion)
values(4,'DEPOSITOS JUDICIALES','A',4,0,'E')

insert into sb_instrumentos
(in_cod_instrumento,in_nombre,in_estado,in_cod_producto,in_moneda,in_tipo_cotizacion)
values(5,'CHEQUES OTROS BANCOS','A',4,0,'E')

insert into sb_instrumentos
(in_cod_instrumento,in_nombre,in_estado,in_cod_producto,in_moneda,in_tipo_cotizacion)
values(6,'CDT','A',4,0,'E')
go

if exists (select 1 from cobis..cl_seqnos
            where bdatos = 'cob_sbancarios'
              and tabla = 'sb_instrumentos')
begin
   update cobis..cl_seqnos
      set siguiente = 7
    where bdatos = 'cob_sbancarios'
      and tabla = 'sb_instrumentos'
end
else
begin
   insert into cobis..cl_seqnos
   values ('cob_sbancarios','sb_instrumentos',7,'in_cod_instrumento')
end
go

