
/***********************************************************************************************************/
---Fecha					: 21/09/2016 
--Autor						: Karen Meza
/***********************************************************************************************************/

------------------------------------------------------------------------


use cob_conta
go

DECLARE  @w_id_mon_dolar tinyint
select @w_id_mon_dolar = mo_moneda 
from  cobis..cl_moneda
WHERE  mo_nemonico ='USD' 

if exists (select 1 from cob_conta..cb_cotizacion where  ct_moneda= @w_id_mon_dolar)
delete cob_conta..cb_cotizacion where  ct_moneda= @w_id_mon_dolar  AND ct_fecha=(select max(ct_fecha)
                      FROM cob_conta..cb_cotizacion
            where ct_moneda = @w_id_mon_dolar)


INSERT INTO cob_conta..cb_cotizacion (ct_moneda, ct_fecha, ct_valor, ct_compra, ct_venta, ct_factor1, ct_factor2)
VALUES (@w_id_mon_dolar, getdate(), 18.1488203, 1, 1, 1, 1)
GO