use cob_credito
go

print 'Select de tablas buro'

select * from cr_buro_cuenta
where bc_id_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

select * from cr_buro_resumen_reporte
where br_id_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

select * from cr_interface_buro
where ib_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

print 'insert de tablas buro a respaldo'

select * into cr_buro_cuenta_106366
from cr_buro_cuenta
where bc_id_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

select * into cr_buro_resumen_reporte_106366
from cr_buro_resumen_reporte
where br_id_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

select * into cr_interface_buro_106366
from cr_interface_buro
where ib_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

print 'eliminar registros del cliente en tablas buro'

delete from cr_buro_cuenta
where bc_id_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

delete from cr_buro_resumen_reporte
where br_id_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

delete from cr_interface_buro
where ib_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

print 'Select de tablas buro y respaldo'

select * from cr_buro_cuenta where bc_id_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente
select * from cr_buro_resumen_reporte where br_id_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente
select * from cr_interface_buro where ib_cliente in (13389,42542,42550,18114,18163,18173,18193, 18144,18163,18173,18193,18218,18360,18603,18618) --= @w_cliente

select * from cr_buro_cuenta_106366
select * from cr_buro_resumen_reporte_106366
select * from cr_interface_buro_106366

go
