USE cobis
GO

IF OBJECT_ID('ns_plantilla_sms') IS NOT NULL 
BEGIN 
   print 'La tabla ns_plantilla_sms existe' 
END 
ELSE 
BEGIN 
   CREATE TABLE ns_plantilla_sms 
   (
      ps_id_plantilla           VARCHAR(10)   NOT NULL PRIMARY KEY, 
      ps_descripcion_plantilla  VARCHAR(255) NOT NULL, 
      ps_id_customer_vendor     INT          , 
      ps_id_subtp_evento        INT          , 
      ps_id_notificacion        INT          
   )
END


IF OBJECT_ID('ns_datos_mensaje') IS NOT NULL 
BEGIN 
   print 'La tabla ns_datos_mensaje existe' 
END 
ELSE 
BEGIN 
   CREATE TABLE ns_datos_mensaje 
   (
      dm_codigo           VARCHAR(2)   NOT NULL PRIMARY KEY, 
      dm_item             VARCHAR(30) NOT NULL,
	  dm_descripcion      VARCHAR(150) NULL,
	  dm_tipo             VARCHAR(50)
   )
END


IF OBJECT_ID('ns_detalle_plantilla') IS NOT NULL 
BEGIN 
   print 'La tabla ns_detalle_plantilla existe' 
END 
ELSE 
BEGIN 
   CREATE TABLE ns_detalle_plantilla 
   (
      dp_id_plantilla           VARCHAR(2)  NOT NULL , 
      dp_id_mensaje             VARCHAR(30) NOT NULL, 
      dp_codigo                 VARCHAR(2)  NOT NULL,
	  dp_id_bloque              INT         NOT NULL
   )
END

if OBJECT_ID ('ns_datos_mensaje_detalle') is not NULL
BEGIN
    print 'La tabla ns_datos_mensaje_detalle existe' 
END
ELSE
BEGIN
   CREATE TABLE [dbo].[ns_datos_mensaje_detalle]  ( 
	[dmd_codigo]   	varchar(2) NULL,
	[dmd_id_tabla] 	int NULL,
	[dmd_base]     	varchar(20) NULL,
	[dmd_tabla]    	varchar(20) NULL,
	[dmd_columna]  	varchar(20) NULL,
	[dmd_condicion]	varchar(20) NULL,
	[dmd_relacion] 	varchar(20) NULL 
	)
   
   ALTER TABLE [dbo].[ns_datos_mensaje_detalle]
   	ADD CONSTRAINT [UK_datos_detalle]
   	UNIQUE CLUSTERED ([dmd_codigo], [dmd_id_tabla])
   	WITH (
   		DATA_COMPRESSION = NONE
   	) ON [PRIMARY]
   
END
GO
