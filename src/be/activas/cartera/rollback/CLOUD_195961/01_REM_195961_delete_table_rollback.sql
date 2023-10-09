--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
-- Registro temporal
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
	
	insert into cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
    values('TEMP','REGISTRO TEMPORAL POR BORRADO') --siempre debe ir al final temporalmente hasta encontrar el origen del borrado
	
	--Despues
    select * from cob_cartera..cl_catalogo_motv 
	where cm_codigo in ('TEMP')
end

go
