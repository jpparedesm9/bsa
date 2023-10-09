--Solicito de su apoyo para el cambio de cuenta de la clienta María Luisa Ordoñez Peralta con ID 45435 y código de cliente 46045242 
--Cuenta COBIS 25001480047
--Cuenta CORRECTA 60605473838
--
--Solicito de su apoyo para el cambio de cuenta de la clienta ANTONIA MARTINEZ MORO con ID 1761 y código de cliente 44547259
--Cuenta COBIS 25000275855
--Cuenta CORRECTA 60605399884

use cobis
go

declare @w_cliente int, @w_cuenta varchar(24), @w_buc varchar(20), @w_cuenta_act  varchar(24)

create table #cliente_cuenta(
cliente       int, 
cuenta        varchar(64), 
buc           varchar(64), 
cuenta_actual varchar(64))

insert into #cliente_cuenta values(45435, '25001480047', '46045242', '60605473838')
insert into #cliente_cuenta values(1761, '25000275855', '44547259', '60605399884')

select @w_cliente = 0

while (exists(select 1 from #cliente_cuenta where cliente > @w_cliente))
begin
    
	select top 1
	@w_cliente       = cliente,
	@w_cuenta        = cuenta,
	@w_buc           = buc,
	@w_cuenta_act = cuenta_actual
	from #cliente_cuenta
	where cliente > @w_cliente
	order by cliente

    update cobis..cl_ente_aux 
    set    ea_cta_banco = @w_cuenta
    where ea_ente = @w_cliente
    
    update cob_cartera..ca_desembolso 
    set    dm_cuenta = @w_cuenta
    where  dm_operacion in (select op_operacion 
                            from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal 
                            where op_operacion = tg_operacion
                            and   op_estado in (8,9,4,1,2)
                            and   op_cliente = @w_cliente
							and   tg_monto > 0
							and   tg_prestamo <> tg_referencia_grupal)
	


    update cob_cartera..ca_operacion 
    set    op_cuenta    = @w_cuenta
    where  op_operacion in (select op_operacion 
                            from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal 
                            where op_operacion = tg_operacion
                            and   op_estado in (8,9,4,1,2)
                            and   op_cliente = @w_cliente
							and   tg_monto > 0
							and   tg_prestamo <> tg_referencia_grupal)
    
    update cob_cartera..ca_operacion_his
    set    oph_cuenta    = @w_cuenta
    where  oph_operacion in (select op_operacion 
                            from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal 
                            where op_operacion = tg_operacion
                            and   op_estado in (8,9,4,1,2)
                            and   op_cliente = @w_cliente
							and   tg_monto > 0
							and   tg_prestamo <> tg_referencia_grupal)
    
    update cob_cartera_his..ca_operacion
    set    op_cuenta    = @w_cuenta
    where  op_operacion in (select op_operacion 
                            from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal 
                            where op_operacion = tg_operacion
                            and   op_estado in (8,9,4,1,2)
                            and   op_cliente = @w_cliente
							and   tg_monto > 0
							and   tg_prestamo <> tg_referencia_grupal)
    
    update cob_cartera_his..ca_operacion_his
    set    oph_cuenta    = @w_cuenta
    where  oph_operacion in (select op_operacion 
                            from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal 
                            where op_operacion = tg_operacion
                            and   op_estado in (8,9,4,1,2)
                            and   op_cliente = @w_cliente
							and   tg_monto > 0
							and   tg_prestamo <> tg_referencia_grupal)
    
    update cob_cartera..ca_det_trn
    set    dtr_cuenta = @w_cuenta
    where  dtr_secuencial in (1)
    and    dtr_operacion  in (select op_operacion 
                            from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal 
                            where op_operacion = tg_operacion
                            and   op_estado in (8,9,4,1,2)
                            and   op_cliente = @w_cliente
							and   tg_monto > 0
							and   tg_prestamo <> tg_referencia_grupal)
    and    dtr_cuenta     = @w_cuenta_act

end

drop table #cliente_cuenta


go
