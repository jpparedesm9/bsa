
USE cob_cartera
GO
IF EXISTS(SELECT 1 FROM sysobjects o, syscolumns c WHERE o.name = 'ca_operacion_his'
   AND o.id = c.id
   AND c.name = 'oph_valor_cat')
BEGIN   
   PRINT 'campo ya existe'
END    
ELSE
BEGIN
   PRINT 'crear campo'
   ALTER TABLE ca_operacion_his ADD  oph_valor_cat FLOAT NULL
END
   
GO

IF EXISTS(SELECT 1 FROM sysobjects o, syscolumns c WHERE o.name = 'ca_operacion_ts'
   AND o.id = c.id
   AND c.name = 'ops_valor_cat')
BEGIN   
   PRINT 'campo ya existe'
END    
ELSE
BEGIN
   PRINT 'crear campo'
   ALTER TABLE ca_operacion_ts ADD  ops_valor_cat FLOAT NULL
END
   
GO


IF EXISTS(SELECT 1 FROM sysobjects o, syscolumns c WHERE o.name = 'ca_operacion'
   AND o.id = c.id
   AND c.name = 'op_valor_cat')
BEGIN   
   PRINT 'campo ya existe'
END    
ELSE
BEGIN
   PRINT 'crear campo'
   ALTER TABLE ca_operacion ADD  op_valor_cat FLOAT NULL
END
   
GO



IF EXISTS(SELECT 1 FROM sysobjects o, syscolumns c WHERE o.name = 'ca_operacion_tmp'
   AND o.id = c.id
   AND c.name = 'opt_valor_cat')
BEGIN   
   PRINT 'campo ya existe'
END    
ELSE
BEGIN
   PRINT 'crear campo'
   ALTER TABLE ca_operacion_tmp ADD  opt_valor_cat FLOAT NULL
END
   
GO



USE cob_cartera
go
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'tasas_periodos')
	DROP TABLE tasas_periodos
GO
CREATE TABLE tasas_periodos (
tdivi   FLOAT,
periodo FLOAT  
)
GO

insert into tasas_periodos values (7      ,51.43)
insert into tasas_periodos values (14     ,25.71)
insert into tasas_periodos values (15     ,24.00)
insert into tasas_periodos values (30     ,12.00)
insert into tasas_periodos values (90     ,4.00 )
insert into tasas_periodos values (180    ,2.00 )
insert into tasas_periodos values (360    ,1.00 )
insert into tasas_periodos values (28     ,12.86)




GO




