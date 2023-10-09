--JULIAN BENJAMIN VALENCIA LOPEZ ID 1299
--CUENTA EN COBIS:025000267036
--CUENTA A VINCULAR: 60602432681
--CLIENTE: 44523514
--
--FRANCISCA MARTINEZ OLVERA ID 1416
--CUENTA EN COBIS: 025000267664
--CUENTA A VINCULAR: 60602412857
--CLIENTE: 44523945
--
--BEATRIZ HERRERA ESTRADA ID 1304
--CUENTA EN COBIS: 025000266638
--CUENTA A VINCULAR: 60602456118
--CLIENTE: 44523251
--
--ISABEL NAYELI ZUÑIGA MEDINA ID 1441
--CUENTA EN COBIS: 025000269054
--CUENTA A VINCULAR: 60602430862
--CLIENTE: 44530242
--
--ELIZABETH CASTILLO MARTINEZ ID 1422
--CUENTA EN COBIS: 025000279047
--CUENTA A VINCULAR: 60602410748
--CLIENTE: 44554427
--
--MARIA DE LOS MILAGROS MEDINA HERNANDEZ ID 1294
--CUENTA EN COBIS: 025000275807
--CUENTA A VINCULAR : 60602428856
--CLIENTE: 44547188
--
--MARIA DE LOS ANGELES SANCHEZ FUENTES ID 1307
--CUENTA EN COBIS: 025000266837
--CUENTA A VINCULAR: 60602408057
--CLIENTE:44523375
--
--MARIA TERESA SANCHEZ BELTRAN ID 1820
--CUENTA EN COBIS: 025000277808
--CUENTA A VINCULAR: 60602394589
--CLIENTE: 44548938
--
--Nombre MARIA DE LOURDES HERRERA AMARO ID 12976
--Cuenta en COBIS 025000657991
--Cuanta a Vincular 60605147660
--CLIENTE: 45167315

use cobis
go

declare @w_cliente int, @w_cuenta varchar(24), @w_buc varchar(20), @w_cuenta_act  varchar(24)

create table #cliente_cuenta(
cliente       int, 
cuenta        varchar(64), 
buc           varchar(64), 
cuenta_actual varchar(64))

insert into #cliente_cuenta values(1299, '60602432681', '44523514', '025000267036')
insert into #cliente_cuenta values(1416, '60602412857', '44523945', '025000267664')
insert into #cliente_cuenta values(1304, '60602456118', '44523251', '025000266638')
insert into #cliente_cuenta values(1441, '60602430862', '44530242', '025000269054')
insert into #cliente_cuenta values(1422, '60602410748', '44554427', '025000279047')
insert into #cliente_cuenta values(1294, '60602428856', '44547188', '025000275807')
insert into #cliente_cuenta values(1307, '60602408057', '44523375', '025000266837')
insert into #cliente_cuenta values(1820, '60602394589', '44548938', '025000277808')
insert into #cliente_cuenta values(12976, '60605147660', '45167315', '025000657991')


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
	    
    --select 'BUC' = en_banco, * from cobis..cl_ente where en_ente = @w_cliente
    /*update cobis..cl_ente
    set    en_banco = @w_buc
    where en_ente = @w_cliente
    */
    --select 'CUENTA' = ea_cta_banco, * from cobis..cl_ente_aux where ea_ente = @w_cliente
    update cobis..cl_ente_aux 
    set    ea_cta_banco = @w_cuenta
    where ea_ente = @w_cliente
    
    --select dm_cuenta, * from cob_cartera..ca_desembolso where dm_operacion in (select op_operacion from cob_cartera..ca_operacion where op_cliente = @w_cliente)
    update cob_cartera..ca_desembolso 
    set    dm_cuenta = @w_cuenta
    where  dm_operacion in (select op_operacion 
                            from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal 
                            where op_operacion = tg_operacion
                            and   op_estado in (8,9,4,1,2)
                            and   op_cliente = @w_cliente
							and   tg_monto > 0
							and   tg_prestamo <> tg_referencia_grupal)
	
    
    --select op_cuenta, * from cob_cartera..ca_operacion where op_cliente = @w_cliente
    --select op_cuenta, * from cob_cartera..ca_operacion where op_cliente = @w_cliente
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
