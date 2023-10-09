use cobis
go

-----------------------------------------------------
--------------- cl_ente_bio   -----------------------
-----------------------------------------------------

IF OBJECT_ID ('dbo.cl_ente_bio') IS NOT NULL
	DROP TABLE dbo.cl_ente_bio
GO


CREATE TABLE cl_ente_bio  ( 
   eb_secuencial         	int NOT NULL,
   eb_ente               	int NOT NULL,
   eb_tipo_identificacion	varchar(10) NULL,
   eb_cic                	varchar(9) NULL,
   eb_ocr                	varchar(13) NULL,
   eb_nro_emision        	varchar(2) NULL,
   eb_clave_elector      	varchar(18) NULL,
   eb_sin_huella_dactilar	char(1) NULL,
   eb_fecha_registro     	datetime NOT NULL,
   eb_fecha_vencimiento  	datetime NULL,
   eb_anio_registro      	varchar(5) NULL,
   eb_anio_emision       	varchar(5) NULL,
	CONSTRAINT cl_ente_bio_pk PRIMARY KEY CLUSTERED(eb_secuencial)
)
GO
ALTER TABLE dbo.cl_ente_bio
	ADD CONSTRAINT UQ_eb_ente
	UNIQUE (eb_ente)
GO

if exists (select 1 from sys.indexes where name = 'IDX_eb_ente')
begin	
   drop index IDX_eb_ente on cl_ente_bio
end

create index IDX_eb_ente ON cl_ente_bio(eb_ente)
go

-----------------------------------------------------
--------------- cl_ente_bio_his ---------------------
-----------------------------------------------------

IF OBJECT_ID ('dbo.cl_ente_bio_his') IS NOT NULL
	DROP TABLE dbo.cl_ente_bio_his
GO


CREATE TABLE dbo.cl_ente_bio_his  ( 
	ebh_ssn                	int NOT NULL,
	ebh_ente               	int NULL,
	ebh_tipo_identificacion	varchar(10) NULL,
	ebh_cic                	varchar(9) NULL,
	ebh_ocr                	varchar(13) NULL,
	ebh_nro_emision        	varchar(2) NULL,
	ebh_clave_elector      	varchar(18) NULL,
	ebh_sin_huella_dactilar	char(1) NULL,
	ebh_fecha_registro     	datetime NOT NULL,
	ebh_fecha_vencimiento  	datetime NULL,
	ebh_anio_registro      	varchar(5) NULL,
	ebh_anio_emision       	varchar(5) NULL,
	ebh_fecha_modificacion 	datetime NULL,
	ebh_transaccion        	char(1) NOT NULL,
	ebh_usuario            	varchar(20) NOT NULL,
	ebh_terminal           	varchar(20) NOT NULL,
	ebh_srv                	varchar(10) NULL,
	ebh_lsrv               	varchar(10) NULL 
	)
GO

if exists (select 1 from sys.indexes where name = 'IDX_ebh_ente')
begin	
   drop index IDX_ebh_ente on cl_ente_bio_his
end

create index IDX_ebh_ente ON cl_ente_bio_his(ebh_ente)
go

if not exists (SELECT 1 FROM sys.columns 
               WHERE Name = N'ea_consulto_renapo'
               AND object_id = Object_ID(N'cl_ente_aux'))
   alter table cl_ente_aux
   add ea_consulto_renapo char(2) null
 

use cobis 
go

if object_id('cl_respuesta_bio') is not null 
begin
	drop table cobis..cl_respuesta_bio
end
else
	begin
		create table cobis..cl_respuesta_bio
		(
			rb_secuencia int not null,
			rb_ente int not null,
			rb_fecha_registro datetime not null,
			rb_tipo_situacion_registral varchar(20),
			rb_tipo_reporte_robo_extravio varchar(20) ,
			rb_ano_registro varchar(10),
			rb_clave_elector varchar(10),
			rb_apellido_paterno varchar(10),
			rb_ano_emision varchar(10),
			rb_numero_emision_credencial varchar(10),
			rb_nombre varchar(10),
			rb_apellido_materno varchar(10),
			rb_indice_izquierdo int,
			rb_indice_derecho int,
			rb_hash	varchar(255) null,
			rb_sequential	varchar(50),
			rb_inst_proc	int not null,
			rb_resultado	varchar(20),
			rb_valida_huella char(1) null
		)
	end

if exists (select 1 from sys.indexes where name = 'IDX_RESPUESTA_BIO_SECUENCIA')
begin	
   drop index IDX_RESPUESTA_BIO_SECUENCIA on cl_respuesta_bio
end
	create unique index IDX_RESPUESTA_BIO_SECUENCIA ON cl_respuesta_bio(rb_secuencia)
go

if exists (select 1 from sys.indexes where name = 'IDX_RESPUESTA_BIO_ENTE')
begin	
   drop index IDX_RESPUESTA_BIO_ENTE on cl_respuesta_bio
end
	create index IDX_RESPUESTA_BIO_ENTE ON cl_respuesta_bio(rb_ente)
go

if exists (select 1 from sys.indexes where name = 'IDX_RESPUESTA_BIO_INST_PROC')
begin	
   drop index IDX_RESPUESTA_BIO_INST_PROC on cl_respuesta_bio
end
	create index IDX_RESPUESTA_BIO_INST_PROC ON cl_respuesta_bio(rb_inst_proc)
go

DELETE FROM cobis..cl_seqnos WHERE tabla ='cl_respuesta_bio' AND bdatos = 'cobis';
INSERT INTO cobis..cl_seqnos (bdatos,tabla,siguiente,pkey) VALUES ('cobis','cl_respuesta_bio',1,'rb_secuencia');

go



use cobis
go


delete from cobis..cl_seqnos where bdatos = 'cobis' and tabla = 'cl_ente_bio'

insert into cobis..cl_seqnos values ('cobis', 'cl_ente_bio', 0, 'eb_secuencial')

go

