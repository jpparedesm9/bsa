	
USE cob_credito
go

IF EXISTS (SELECT 1 FROM sysobjects WHERE name='ts_imp_documento')
BEGIN
	DROP view  ts_imp_documento

END
go

CREATE VIEW ts_imp_documento 
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      documento,
      toperacion,    
      producto,
      moneda,
	  descripcion,
      template,
      mnemonico,
      tipo) AS   
 SELECT cr_tran_servicio.ts_secuencial, 
    cr_tran_servicio.ts_tipo_transaccion, 
    cr_tran_servicio.ts_clase, 
    cr_tran_servicio.ts_fecha,
    cr_tran_servicio.ts_usuario, 
    cr_tran_servicio.ts_terminal, 
    cr_tran_servicio.ts_oficina, 
    cr_tran_servicio.ts_tabla, 
    cr_tran_servicio.ts_lsrv, 
    cr_tran_servicio.ts_srv,
    cr_tran_servicio.ts_smallint01,   
    cr_tran_servicio.ts_catalogo01,     
    cr_tran_servicio.ts_catalogo02,
    cr_tran_servicio.ts_tinyint01,
    cr_tran_servicio.ts_descripcion01,
    cr_tran_servicio.ts_descripcion02,
    cr_tran_servicio.ts_catalogo03,
    cr_tran_servicio.ts_char101    --SAL 04/07/1999
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21033 ) OR ( cr_tran_servicio.ts_tipo_transaccion = 21133 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21233 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21433 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21533 )	

GO
		 
IF EXISTS (SELECT 1 FROM sysobjects WHERE name='ts_documento')
BEGIN
	DROP view  ts_documento

END
GO   
         
 CREATE VIEW ts_documento 
    ( secuencial, 
      tipo_transaccion, 
      clase, 
      fecha,
      usuario, 
      terminal, 
      oficina,
      tabla,
      lsrv, 
      srv,
      tramite,
      documento,    
      numero,
      fecha_impresion,
	  usuario_doc ) AS
 SELECT cr_tran_servicio.ts_secuencial, 
    cr_tran_servicio.ts_tipo_transaccion, 
    cr_tran_servicio.ts_clase, 
    cr_tran_servicio.ts_fecha,
    cr_tran_servicio.ts_usuario, 
    cr_tran_servicio.ts_terminal, 
    cr_tran_servicio.ts_oficina, 
    cr_tran_servicio.ts_tabla, 
    cr_tran_servicio.ts_lsrv, 
    cr_tran_servicio.ts_srv,
      cr_tran_servicio.ts_int01,   
    cr_tran_servicio.ts_smallint01,     
    cr_tran_servicio.ts_tinyint01,
    cr_tran_servicio.ts_fecha01,
    cr_tran_servicio.ts_login01
    FROM cr_tran_servicio 
   WHERE ( cr_tran_servicio.ts_tipo_transaccion = 21034 ) OR  
         ( cr_tran_servicio.ts_tipo_transaccion = 21434 )
GO		 

--SRO. Se comenta para instalador
--IF EXISTS ( SELECT 1 FROM syscolumns a , sysobjects b	WHERE a.name ='id_tipo_tramite' AND  a.id =b.id)
--begin
--	ALTER TABLE cr_imp_documento DROP COLUMN id_tipo_tramite 
--end
--GO
--	
--ALTER TABLE cr_imp_documento
--ADD  id_tipo_tramite CHAR(4)
--
--GO
--IF EXISTS ( SELECT 1 FROM syscolumns a , sysobjects b	WHERE a.name ='id_template' AND  a.id =b.id)
--begin
--	ALTER TABLE cr_imp_documento DROP COLUMN id_template 
--end
--GO
--
--ALTER TABLE cr_imp_documento
--ADD id_template varchar(64)
--GO
--
--IF EXISTS ( SELECT 1 FROM syscolumns a , sysobjects b	WHERE a.name ='id_estado' AND  a.id =b.id)
--begin
--	ALTER TABLE cr_imp_documento DROP COLUMN id_estado 
--end
--GO
--
--ALTER TABLE cr_imp_documento
--ADD  id_estado CHAR(4)
--GO
--
--IF EXISTS ( SELECT 1 FROM syscolumns a , sysobjects b	WHERE a.name ='id_dato' AND  a.id =b.id)
--begin
--	ALTER TABLE cr_imp_documento DROP COLUMN id_dato 
--end
--GO
--
--ALTER TABLE cr_imp_documento
--ADD  id_dato varchar(64)
--GO
--
--IF EXISTS ( SELECT 1 FROM syscolumns a , sysobjects b	WHERE a.name ='id_medio' AND  a.id =b.id)
--begin
--	ALTER TABLE cr_imp_documento DROP COLUMN id_medio 
--end
--GO
--
--ALTER TABLE cr_imp_documento
--ADD  id_medio CHAR(4)
--GO

IF EXISTS ( SELECT 1 FROM syscolumns a , sysobjects b	WHERE a.name ='tr_expromision' AND  a.id =b.id)
begin
	ALTER TABLE cr_tramite DROP COLUMN tr_expromision 
END
GO
ALTER TABLE cr_tramite ADD tr_expromision VARCHAR(10)
GO