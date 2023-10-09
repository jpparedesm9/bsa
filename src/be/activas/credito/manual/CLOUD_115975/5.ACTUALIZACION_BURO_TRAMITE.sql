--------------------------------------------------------------------------------------------------
-- ACTUALIZACION DE LA TABLA CR_TRAMITE CON EL FOLIO VIGENTE DESPUES DEL PASO A NUEVA ESTRUCTURA
--------------------------------------------------------------------------------------------------

update cob_credito..cr_tramite
set tr_folio_buro= ib_folio
from cob_credito..cr_interface_buro
where ib_cliente = tr_cliente
and ib_estado = 'V'