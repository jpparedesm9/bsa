--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
-- Borrado de registro temporal
-- Req.195961 - Interfaz interfaz BMXP_MOVIMIENTOS_COB_DAAAAMMDD Numero de Recibo
-- Tabla: cl_catalogo_motv

use cob_cartera
go

if object_id ('cl_catalogo_motv') is not null
begin
    --Antes
    select * from cob_cartera..cl_catalogo_motv 
	where cm_codigo in ('TEMP')
	
    delete from cob_cartera..cl_catalogo_motv 
	where cm_codigo in ('TEMP')
	
	--Despues
    select * from cob_cartera..cl_catalogo_motv 
	where cm_codigo in ('TEMP')
end

go
