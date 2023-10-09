use cob_credito
go

print 'Borrar info de tablas buro'

delete from cr_buro_cuenta
where bc_id_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

delete from cr_buro_resumen_reporte
where br_id_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

delete from cr_interface_buro
where ib_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

print 'Insertar registros del respaldo'

insert into cr_interface_buro
select * from cr_interface_buro_106366
where ib_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

insert into cr_buro_cuenta
select * from cr_buro_cuenta_106366
where bc_id_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

insert into cr_buro_resumen_reporte
select * from cr_buro_resumen_reporte_106366
where br_id_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

go
