use cobis

go

delete from cobis..cl_errores where numero in (70068,70069,70070,70071,70072,70073)

insert into cobis..cl_errores values (70068, 0,'NO ES LCR')
insert into cobis..cl_errores values (70069, 0,'LCR ya está vencida')
insert into cobis..cl_errores values (70070, 0,'No se permite cancelar anticipadamente una LCR con saldo pendiente de cobro')
insert into cobis..cl_errores values (70071, 0,'No se permite cancelar una LCR con transacciones pendientes de aplicación')
insert into cobis..cl_errores values (70072, 0,'ERROR AL CREAR LA TRANSACCION CLC')
insert into cobis..cl_errores values (70073, 0,'No se actualizo la fecha de vencimiento')

go
