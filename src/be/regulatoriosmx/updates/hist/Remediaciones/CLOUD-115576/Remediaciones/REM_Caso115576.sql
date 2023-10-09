--Se solicita realizar UPDATE al campo FechaActualizacion de 
--la cuentas con fecha de apertura "6122018" ya que el sistema no 
--toma las cuentas correctamente debido al error detectado en el caso 115570
--
--El update queda de la siguiente forma:
--
--ACTUAL fecha de apertura "6122018" = "fecha actualizacion = 15032019" 
--UPDATE fecha de apertura "6122018" = " "fecha actualizacion = 27032019"
--
--para los clientes
--
--ClienteId
--100341
--101067
--101069
--101072

update cob_credito..cr_buro_cuenta
set    bc_fecha_actualizacion = '27032019' 
where  bc_id_cliente in (100341,101067,101069,101072)
and    bc_fecha_apertura_cuenta = '06122018'
and    bc_fecha_actualizacion = '15032019'

select bc_fecha_actualizacion, bc_fecha_apertura_cuenta, * 
from cob_credito..cr_buro_cuenta
where bc_id_cliente in (100341,101067,101069,101072)
go



