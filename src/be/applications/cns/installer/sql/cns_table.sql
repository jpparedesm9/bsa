USE cobis
GO

truncate table ns_plantilla_sms
   CREATE TABLE ns_plantilla_sms 
   (
      ps_id_plantilla           VARCHAR(10)   NOT NULL PRIMARY KEY, 
      ps_descripcion_plantilla  VARCHAR(255) NOT NULL, 
      ps_id_customer_vendor     INT          , 
      ps_id_subtp_evento        INT          , 
      ps_id_notificacion        INT          
   )



truncate table ns_datos_mensaje
   CREATE TABLE ns_datos_mensaje 
   (
      dm_codigo           VARCHAR(2)   NOT NULL PRIMARY KEY, 
      dm_item             VARCHAR(30) NOT NULL 
   )



truncate table ns_detalle_plantilla
   CREATE TABLE ns_detalle_plantilla 
   (
      dp_id_plantilla           VARCHAR(10)  NOT NULL , 
      dp_id_mensaje             VARCHAR(30) NOT NULL, 
      dp_codigo                 VARCHAR(10)  NOT NULL
   )

truncate table ns_datos_mensaje_detalle
   CREATE TABLE [dbo].[ns_datos_mensaje_detalle]  ( 
	[dmd_codigo]   	varchar(2) NULL,
	[dmd_id_tabla] 	int NULL,
	[dmd_base]     	varchar(20) NULL,
	[dmd_tabla]    	varchar(20) NULL,
	[dmd_columna]  	varchar(20) NULL,
	[dmd_condicion]	varchar(20) NULL,
	[dmd_relacion] 	varchar(20) NULL,
	[dmd_eliminar]  char(1)     NULL
	)
   
   ALTER TABLE [dbo].[ns_datos_mensaje_detalle]
   	ADD CONSTRAINT [UK_datos_detalle]
   	UNIQUE CLUSTERED ([dmd_codigo], [dmd_id_tabla])
   	WITH (
   		DATA_COMPRESSION = NONE
   	) ON [PRIMARY]

GO
