USE cob_cartera_his
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


