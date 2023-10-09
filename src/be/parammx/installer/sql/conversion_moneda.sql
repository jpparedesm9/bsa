/************************************************************************/
/*      Archivo:            conversion_moneda.sql                       */
/*      Base de datos:      cob_conta                                   */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:        Karen Meza                                 */
/*      Fecha de escritura: 12/Julio/2016                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*     Conversión de moneda local a dolar                               */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*     FECHA         AUTOR                RAZON                         */
/* 12/Julio/2016    KMEZA                 Migracion a CEN               */
/************************************************************************/


use cob_conta
go
DECLARE  @w_id_moneda tinyint
select @w_id_moneda = mo_moneda 
from  cobis..cl_moneda
WHERE  mo_nemonico ='USD'

if exists (select 1 from cob_conta..cb_cotizacion where  ct_moneda= @w_id_moneda)
delete cob_conta..cb_cotizacion where  ct_moneda= @w_id_moneda  AND ct_fecha=(select max(ct_fecha)
                      FROM cob_conta..cb_cotizacion
             where ct_moneda = @w_id_moneda)

INSERT INTO cob_conta..cb_cotizacion (ct_moneda, ct_fecha, ct_valor, ct_compra, ct_venta, ct_factor1, ct_factor2)
VALUES (@w_id_moneda, getdate(), 18.1488203, 1, 1, 1, 1)

------------------------------------COTIZACION UDI----------------------------------------
select @w_id_moneda = mo_moneda 
  from cobis..cl_parametro, cobis..cl_moneda
 where pa_nemonico = 'IUDI' 
   and pa_char = mo_nemonico 
   and pa_producto = 'AHO'

INSERT INTO cob_conta..cb_cotizacion (ct_moneda, ct_fecha, ct_valor, ct_compra, ct_venta, ct_factor1, ct_factor2)
VALUES (@w_id_moneda, getdate(), 1, 1, 1,  5.42305400, 1)

GO

--COTIZACION MONEDA MXN: MEXICANOS
declare @w_moneda tinyint

select @w_moneda = mo_moneda 
  from cobis..cl_moneda
 where mo_nemonico = 'MXN' 

if exists (select 1 from cob_conta..cb_cotizacion 
            where ct_moneda = @w_moneda)
   delete cob_conta..cb_cotizacion 
    where ct_moneda = @w_moneda 
      and ct_fecha  = (select max(ct_fecha)
                         from cob_conta..cb_cotizacion
                        where ct_moneda = @w_moneda)

insert into cob_conta..cb_cotizacion (ct_moneda, ct_fecha, ct_valor, ct_compra, ct_venta, ct_factor1, ct_factor2)
values (@w_moneda, getdate(), 1, 1, 1, 1, 1)
go

