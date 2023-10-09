use cobis
go

declare @w_secuencial int

delete cl_errores where numero in (2108087)
--ERRORES SINCRONIZACION
insert into cl_errores(numero, severidad, mensaje) 
values (2108087,0,'ERROR: YA EXISTE UNA SINCRONIZACION CON ESTE SECUENCIAL')


select @w_secuencial = max(si_secuencial) from cob_sincroniza..si_sincroniza
select @w_secuencial = isnull(@w_secuencial, 1)

update cobis..cl_seqnos set siguiente = @w_secuencial where tabla = 'si_sincroniza'

go