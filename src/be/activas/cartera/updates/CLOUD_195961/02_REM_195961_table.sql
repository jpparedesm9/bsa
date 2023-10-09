--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
-- Inserts Req.195961 - Interfaz interfaz BMXP_MOVIMIENTOS_COB_DAAAAMMDD Numero de Recibo
-- Tabla: cl_catalogo_motv

use cob_cartera
go

if object_id ('cl_catalogo_motv') is not null
begin
    --Antes
    select * from cob_cartera..cl_catalogo_motv 
	where cm_codigo in ('PAG24','PAG25')
	
    delete from cob_cartera..cl_catalogo_motv 
	where cm_codigo in ('PAG24','PAG25')
	
	insert into cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
    values('PAG24','PAGOS (Cancelar)-Mora de la Comision')
    
    insert into cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
    values('PAG25','PAGOS (Cancelar)-Iva Mora de la Comision')
	
	--Despues
    select * from cob_cartera..cl_catalogo_motv 
	where cm_codigo in ('PAG24','PAG25')
end

go
