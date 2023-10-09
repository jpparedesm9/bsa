use cob_pac
go

-- Valores iniciales para bpl_product

ALTER TABLE bpl_product ALTER COLUMN pr_code_cen VARCHAR(16)
ALTER TABLE bpl_product ALTER COLUMN pr_type VARCHAR(16)



--SELECT * FROM  bpl_product

insert into bpl_product values (2,'CLI','CUSTOMERSNAT','CLIENTES')
insert into bpl_product values (2,'CLI','CUSTOMERSJUR','CLIENTES')
insert into bpl_product values (3,'CTE','CTA','ACTIVOS')
insert into bpl_product values (4,'AHO','AHO','ACTIVOS')
insert into bpl_product values (7,'CCA','CCA','PASIVOS')
insert into bpl_product values (9,'CCI','CEXCCI','CONTINGENTES')
insert into bpl_product values (9,'CCE','CEXCCE','CONTINGENTES')
insert into bpl_product values (9,'CDI','CEXCDI','CONTINGENTES')
insert into bpl_product values (9,'CDE','CEXCDE','CONTINGENTES')
insert into bpl_product values (9,'AVB','CEXAVB','CONTINGENTES')
insert into bpl_product values (9,'CCD','CEXCCD','CONTINGENTES')
insert into bpl_product values (9,'TRL','CEXTRL','CONTINGENTES')
insert into bpl_product values (9,'COR','CEXCOR','CONTINGENTES')
insert into bpl_product values (14,'PFI','PFI','ACTIVOS')
insert into bpl_product values (19,'GAR','CUS','GARANTIAS')
insert into bpl_product values (21,'CRE','CRE','PASIVOS')
insert into bpl_product values (5,'FIR','ADMFIR','FIRMAS')

-- Valores iniciales para bpl_view y bpl_an_page_view

if exists (SELECT 1
           FROM  INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'view_parameter_fk1')
   alter table bpl_view_parameter
      drop constraint view_parameter_fk1
GO
if exists (SELECT 1
           FROM  INFORMATION_SCHEMA.TABLE_CONSTRAINTS
           WHERE CONSTRAINT_NAME = 'parameter_value_fk1')
   alter table bpl_parameter_value
      drop constraint parameter_value_fk1
go


--sp_help bpl_an_page_view

-- TRUNCATE TABLE bpl_view
-- TRUNCATE TABLE bpl_an_page_view

-- Valores iniciales para bpl_view y bpl_an_page_view
IF NOT EXISTS (SELECT 1 FROM bpl_view WHERE vi_id = 0 AND vi_name_description = 'ROOT' AND vi_status = 'ACTIVE')
	insert into bpl_view values (0,null,0,null,'ROOT','ACTIVE',0,1,'ROOT')

IF NOT EXISTS (SELECT 1 FROM bpl_an_page_view WHERE pvi_id = 0 AND pvi_view_id = 0 AND pvi_page_id = 0)	
	insert into bpl_an_page_view values (0,0,0)
go

go


