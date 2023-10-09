select * from cob_credito..cr_buro_cuenta 
where bc_id_cliente in (91909,91956) 

update cob_credito..cr_buro_cuenta 
set bc_fecha_apertura_cuenta = '27122018'
where bc_id_cliente in (91909,91956)
and bc_fecha_apertura_cuenta = '27122017'

select * from cob_credito..cr_buro_cuenta 
where bc_id_cliente in (91909,91956)
go