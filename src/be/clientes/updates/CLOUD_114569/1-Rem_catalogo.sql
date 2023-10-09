
---------------------------
print 'Ingreso catalogo - Producto Reglas Negocio' -- TIPO DE SEGMENTOS DE RIESGO
---------------------------
use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CLI'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in ('cli_prod_reg_neg')
go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('cli_prod_reg_neg')                                              
and cl_tabla.codigo = cl_catalogo.tabla

go                                       
delete cl_tabla 
 where cl_tabla.tabla in ('cli_prod_reg_neg')                                    
go

--cli_prod_reg_neg
print 'cli_prod_reg_neg'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla,'cli_prod_reg_neg','PRODUCTO REGLA NEGOCIO')
insert into cl_catalogo_pro values ('CLI', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','GRUPAL','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','INDIVIDUAL REVOLVENTE','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'3','INDIVIDUAL SIMPLE','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'4','CUALQUIER VALOR','V')
update cobis..cl_seqnos set siguiente = @w_tabla where tabla = 'cl_tabla'
go

use cobis
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'reg_neg_cuenta_pagos'
                  AND Object_ID = Object_ID(N'cobis..cl_cat_reg_negocio'))
begin
   ALTER TABLE cobis..cl_cat_reg_negocio
   ADD reg_neg_cuenta_pagos CHAR(1) null
end
go

USE cobis 
GO

IF NOT EXISTS (SELECT * FROM cobis..cl_cat_reg_negocio WHERE reg_neg_etiqueta='AML_PAN_1'
                AND reg_neg_cuenta_pagos='S')
BEGIN                
    INSERT INTO cobis..cl_cat_reg_negocio (reg_neg_etiqueta, reg_neg_descripcion,reg_neg_cuenta_pagos)
    VALUES ('AML_PAN_1', 'No de Pagos del crédito individual/revolvente','S')
end

IF NOT EXISTS (SELECT * FROM cobis..cl_cat_reg_negocio WHERE reg_neg_etiqueta='AML_PAN_1'
                AND reg_neg_cuenta_pagos='N')
BEGIN
    INSERT INTO cobis..cl_cat_reg_negocio (reg_neg_etiqueta, reg_neg_descripcion,reg_neg_cuenta_pagos)
    VALUES ('AML_PAN_1', 'Pago del crédito individual revolvente','N')
end

GO


USE  cobis
GO

IF NOT EXISTS(SELECT 1 FROM cobis..cl_parametro 
               WHERE pa_nemonico='NPAMRE'
			   and pa_producto='REC')
 BEGIN
  INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
  VALUES ('NUMERO DE PAGOS REVOLVENTE MES', 'NPAMRE', 'I', NULL, NULL, NULL, 20, NULL, NULL, NULL, 'REC')
 end
GO

USE  cobis
GO

IF NOT EXISTS(SELECT 1 FROM cobis..cl_parametro 
               WHERE pa_nemonico ='NLICRE'
               AND pa_producto   ='REC')
 BEGIN
  INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
  VALUES ('NUMERO LIMITE CREDITO REVOLVENTE MES', 'NLICRE', 'I', NULL, NULL, NULL, 8, NULL, NULL, NULL, 'REC')
 end
GO
