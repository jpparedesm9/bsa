--Elimino el catalogo creado para la regla de negocio
use cobis
go
delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CLI'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in ('cli_prod_reg_neg')

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('cli_prod_reg_neg')                                              
and cl_tabla.codigo = cl_catalogo.tabla
                                      
delete cl_tabla 
 where cl_tabla.tabla in ('cli_prod_reg_neg')                                    
go

USE cobis 
go

IF  EXISTS (SELECT * FROM cobis..cl_cat_reg_negocio WHERE reg_neg_etiqueta='AML_PAN_1'
                AND reg_neg_cuenta_pagos='S')
BEGIN                
    DELETE FROM cobis..cl_cat_reg_negocio
    WHERE reg_neg_etiqueta='AML_PAN_1'
    AND reg_neg_cuenta_pagos='S'
end

IF  EXISTS (SELECT * FROM cobis..cl_cat_reg_negocio WHERE reg_neg_etiqueta='AML_PAN_1'
                AND reg_neg_cuenta_pagos='N')
BEGIN
    DELETE FROM cobis..cl_cat_reg_negocio
    WHERE reg_neg_etiqueta='AML_PAN_1'
    AND reg_neg_cuenta_pagos='N'
END
go
--Elimino la nueva columna creada cuenta con numero de pagos
use cobis
go
if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'reg_neg_cuenta_pagos'
                  AND Object_ID = Object_ID(N'cobis..cl_cat_reg_negocio'))
begin
   ALTER TABLE cobis..cl_cat_reg_negocio
   drop reg_neg_cuenta_pagos 
end
GO
--Elimino los parametros creados para el numero de gagos 
USE  cobis
GO

IF  EXISTS(SELECT 1 FROM cobis..cl_parametro 
               WHERE pa_nemonico='NPAMRE' AND pa_producto='REC')
 BEGIN
 
 DELETE FROM cobis..cl_parametro 
 WHERE pa_nemonico='NPAMRE' AND pa_producto='REC'
 end
GO
--Elimino el parametro numero de limite de pagos de limite de credito revolvente mesual
USE  cobis
GO

IF NOT EXISTS(SELECT 1 FROM cobis..cl_parametro 
               WHERE pa_nemonico ='NLICRE'
               AND pa_producto   ='REC')
 BEGIN
 
 DELETE FROM cobis..cl_parametro 
 WHERE pa_nemonico='NLICRE' AND pa_producto='REC'
 end
GO