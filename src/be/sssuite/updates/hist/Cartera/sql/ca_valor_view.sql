use cob_cartera
go

if object_id('ca_valor_view') is not null
    drop view ca_valor_view
go

create view ca_valor_view
as select va_tipo, va_descripcion, va_clase, 'N' as va_prime FROM cob_cartera..ca_valor

go
