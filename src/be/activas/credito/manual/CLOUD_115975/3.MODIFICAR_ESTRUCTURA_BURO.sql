use cob_credito
go

truncate table cr_empleo_buro
truncate table cr_direccion_buro
truncate table cr_buro_cuenta
truncate table cr_consultas_buro
truncate table cr_buro_resumen_reporte
truncate table cr_score_buro
delete cr_interface_buro

--Creación de Tablas
IF OBJECT_ID ('dbo.cr_buro_encabezado') IS NOT NULL
	DROP TABLE dbo.cr_buro_encabezado
GO

CREATE TABLE cr_buro_encabezado
(
  be_secuencial INT NOT NULL IDENTITY,
  be_ib_secuencial INT NOT NULL ,  
  be_nro_referencia_operador VARCHAR(25),
  be_clave_pais VARCHAR(2),
  be_identificador_buro INT,
  be_clave_otorgante VARCHAR(10),
  be_clave_retorno_consumidor_principal VARCHAR(1),
  be_clave_retorno_consumidor_secundario VARCHAR(1),
  be_numero_control_consulta VARCHAR(9),
  CONSTRAINT pk_buro_encabezado PRIMARY KEY (be_secuencial)
)

go
--Creación de columnas

if not exists (SELECT 1 FROM sys.columns WHERE Name = 'ib_secuencial'
               AND Object_ID = Object_ID('cob_credito..cr_interface_buro')) begin
   alter table cr_interface_buro
   add ib_secuencial int identity

end

if not exists (SELECT 1 FROM sys.columns WHERE Name = 'ib_estado'
               AND Object_ID = Object_ID('cob_credito..cr_interface_buro')) begin
   alter table cr_interface_buro
   add ib_estado varchar(4) null
end

if not exists (SELECT 1 FROM sys.columns WHERE Name = 'eb_secuencial'
               AND Object_ID = Object_ID('cob_credito..cr_empleo_buro')) begin
   alter table cr_empleo_buro
   add eb_secuencial int identity
end

if not exists (SELECT 1 FROM sys.columns WHERE Name = 'eb_ib_secuencial'
               AND Object_ID = Object_ID('cob_credito..cr_empleo_buro')) begin
   alter table cr_empleo_buro
   add eb_ib_secuencial int

end

if not exists (SELECT 1 FROM sys.columns WHERE Name = 'db_secuencial'
               AND Object_ID = Object_ID('cob_credito..cr_direccion_buro')) begin
   alter table cr_direccion_buro
   add db_secuencial int identity
end


if not exists (SELECT 1 FROM sys.columns WHERE Name = 'db_ib_secuencial'
               AND Object_ID = Object_ID('cob_credito..cr_direccion_buro')) begin
   alter table cr_direccion_buro
   add db_ib_secuencial int

end

if not exists (SELECT 1 FROM sys.columns WHERE Name = 'ce_secuencial'
               AND Object_ID = Object_ID('cob_credito..cr_consultas_buro')) begin
   alter table cr_consultas_buro
   add ce_secuencial int identity
end

if not exists (SELECT 1 FROM sys.columns WHERE Name = 'ce_ib_secuencial'
               AND Object_ID = Object_ID('cob_credito..cr_consultas_buro')) begin
   alter table cr_consultas_buro
   add ce_ib_secuencial int

end


if not exists (SELECT 1 FROM sys.columns WHERE Name = 'br_secuencial'
               AND Object_ID = Object_ID('cob_credito..cr_buro_resumen_reporte')) begin
   alter table cr_buro_resumen_reporte
   add br_secuencial int identity

end

if not exists (SELECT 1 FROM sys.columns WHERE Name = 'br_ib_secuencial'
               AND Object_ID = Object_ID('cob_credito..cr_buro_resumen_reporte')) begin
   alter table cr_buro_resumen_reporte
   add br_ib_secuencial int

end

if not exists (SELECT 1 FROM sys.columns WHERE Name = 'sb_secuencial'
               AND Object_ID = Object_ID('cob_credito..cr_score_buro')) begin
   alter table cr_score_buro
   add sb_secuencial int identity
end


if not exists (SELECT 1 FROM sys.columns WHERE Name = 'sb_ib_secuencial'
               AND Object_ID = Object_ID('cob_credito..cr_score_buro')) begin
   alter table cr_score_buro
   add sb_ib_secuencial int 
end

if not exists (SELECT 1 FROM sys.columns WHERE Name = 'bc_secuencial'
               AND Object_ID = Object_ID('cob_credito..cr_buro_cuenta')) begin
   alter table cr_buro_cuenta
   add bc_secuencial int identity
end


if not exists (SELECT 1 FROM sys.columns WHERE Name = 'bc_ib_secuencial'
               AND Object_ID = Object_ID('cob_credito..cr_buro_cuenta')) begin
   alter table cr_buro_cuenta
   add bc_ib_secuencial int 
end

go

--Borrar índices
if exists (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_cr_buro_resumen_reporte_cr_interface_buro' AND type = 'F') begin 
   ALTER TABLE cr_buro_resumen_reporte
   DROP CONSTRAINT  FK_cr_buro_resumen_reporte_cr_interface_buro 
end 

if exists (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_cr_buro_cuenta_cr_interface_buro' AND type = 'F') begin 
   ALTER TABLE cr_buro_cuenta
   DROP CONSTRAINT  FK_cr_buro_cuenta_cr_interface_buro 
end 

if exists (SELECT 1 FROM sys.objects WHERE name ='PK__cr_inter__5A8B04BAEC30852D' AND type = 'PK') begin 
   ALTER TABLE cr_interface_buro
   DROP CONSTRAINT  PK__cr_inter__5A8B04BAEC30852D 
end																									 

if exists (SELECT 1 FROM sys.indexes WHERE Name = N'IX_cr_empleo_buro' AND object_id = OBJECT_ID(N'cr_empleo_buro')) begin 
   DROP INDEX  cr_empleo_buro.IX_cr_empleo_buro 
end 

if exists (SELECT 1 FROM sys.indexes WHERE Name = N'IX_cr_buro_cuenta'  AND object_id = OBJECT_ID(N'cr_buro_cuenta')) begin 
   DROP INDEX  cr_buro_cuenta.IX_cr_buro_cuenta 
end 

if exists (SELECT 1 FROM sys.indexes WHERE Name = N'IX_cr_direccion_buro' AND object_id = OBJECT_ID(N'cr_direccion_buro')) begin 
   DROP INDEX  cr_direccion_buro.IX_cr_direccion_buro 
end 

if exists (SELECT 1 FROM sys.indexes WHERE Name = N'IX_cr_score_buro' AND object_id = OBJECT_ID(N'cr_score_buro')) begin 
   DROP INDEX  cr_score_buro.IX_cr_score_buro 
end 

if exists (SELECT 1 FROM sys.indexes WHERE Name = N'IX_cr_consultas_buro' AND object_id = OBJECT_ID(N'cr_consultas_buro')) begin 
   DROP INDEX  cr_consultas_buro.IX_cr_consultas_buro 
end 

if exists (SELECT 1 FROM sys.indexes WHERE Name = N'IX_cr_buro_resumen_reporte' AND object_id = OBJECT_ID(N'cr_buro_resumen_reporte')) begin 
   DROP INDEX  cr_buro_resumen_reporte.IX_cr_buro_resumen_reporte 
end 
go

--Borrar columnas
if exists (SELECT 1 FROM sys.columns WHERE Name = 'ib_xml'
           AND Object_ID = Object_ID('cob_credito..cr_interface_buro')) begin
   alter table cr_interface_buro
   drop column ib_xml 
end

if exists (SELECT 1 FROM sys.columns WHERE Name = 'eb_cliente'
           AND Object_ID = Object_ID('cob_credito..cr_empleo_buro')) begin
   alter table cr_empleo_buro
   drop column eb_cliente 
end

if exists (SELECT 1 FROM sys.columns WHERE Name = 'eb_fecha'
           AND Object_ID = Object_ID('cob_credito..cr_empleo_buro')) begin
   alter table cr_empleo_buro
   drop column eb_fecha 
end

if exists (SELECT 1 FROM sys.columns WHERE Name = 'db_cliente'
           AND Object_ID = Object_ID('cob_credito..cr_direccion_buro')) begin
   alter table cr_direccion_buro
   drop column db_cliente 
end

if exists (SELECT 1 FROM sys.columns WHERE Name = 'db_fecha'
           AND Object_ID = Object_ID('cob_credito..cr_direccion_buro')) begin
   alter table cr_direccion_buro
   drop column db_fecha 
end

if exists (SELECT 1 FROM sys.columns WHERE Name = 'ce_cliente'
           AND Object_ID = Object_ID('cob_credito..cr_consultas_buro')) begin
   alter table cr_consultas_buro
   drop column ce_cliente 
end

if exists (SELECT 1 FROM sys.columns WHERE Name = 'ce_fecha'
           AND Object_ID = Object_ID('cob_credito..cr_consultas_buro')) begin
   alter table cr_consultas_buro
   drop column ce_fecha 
end

if exists (SELECT 1 FROM sys.columns WHERE Name = 'br_id_cliente'
           AND Object_ID = Object_ID('cob_credito..cr_buro_resumen_reporte')) begin
   alter table cr_buro_resumen_reporte
   drop column br_id_cliente 
end

if exists (SELECT 1 FROM sys.columns WHERE Name = 'sb_fecha'
           AND Object_ID = Object_ID('cob_credito..cr_score_buro')) begin
   alter table cr_score_buro
   drop column sb_fecha 
end

if exists (SELECT 1 FROM sys.columns WHERE Name = 'sb_cliente'
           AND Object_ID = Object_ID('cob_credito..cr_score_buro')) begin
   alter table cr_score_buro
   drop column sb_cliente 
end


if exists (SELECT 1 FROM sys.columns WHERE Name = 'bc_id_cliente'
           AND Object_ID = Object_ID('cob_credito..cr_buro_cuenta')) begin
   alter table cr_buro_cuenta
   drop column bc_id_cliente 
end

go

--Creación de índices y contraints
if not exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx_secuencial' AND object_id = OBJECT_ID(N'cr_interface_buro')) begin 
   CREATE NONCLUSTERED INDEX idx_secuencial
   ON dbo.cr_interface_buro (ib_secuencial)
end

if not exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx_ib_secuencial' AND object_id = OBJECT_ID(N'cr_buro_cuenta')) begin 
   CREATE NONCLUSTERED INDEX idx_ib_secuencial
   ON dbo.cr_buro_cuenta (bc_ib_secuencial)
end

if not exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx_cr_interface_buro' AND object_id = OBJECT_ID(N'cr_interface_buro')) begin 
   CREATE INDEX  idx_cr_interface_buro 
   on cr_interface_buro (ib_cliente)
end 

if not exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx_cliente' AND object_id = OBJECT_ID(N'cr_interface_buro')) begin
   CREATE INDEX idx_cliente
   ON cr_interface_buro (ib_cliente)
end

if not exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx_estado' AND object_id = OBJECT_ID(N'cr_interface_buro')) begin
   CREATE INDEX idx_estado
   ON cr_interface_buro (ib_estado)
end

--Primary keys
if not exists (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'pk_interface_buro') AND type in (N'PK')) begin 
   ALTER TABLE cr_interface_buro
   ADD CONSTRAINT  pk_interface_buro PRIMARY KEY (ib_secuencial)
end 

if not exists (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'pk_empleo_buro') AND type in (N'PK')) begin 
   ALTER TABLE cr_empleo_buro
   ADD CONSTRAINT  pk_empleo_buro PRIMARY KEY (eb_secuencial)
end 

if not exists (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'pk_direccion_buro') AND type in (N'PK')) begin 
   ALTER TABLE cr_direccion_buro
   ADD CONSTRAINT  pk_direccion_buro PRIMARY KEY (db_secuencial)
end 

if not exists (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'pk_consultas_buro') AND type in (N'PK')) begin 
   ALTER TABLE cr_consultas_buro
   ADD CONSTRAINT  pk_consultas_buro PRIMARY KEY (ce_secuencial)
end 

if not exists (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'pk_buro_resumen_reporte') AND type in (N'PK')) begin 
   ALTER TABLE cr_buro_resumen_reporte
   ADD CONSTRAINT pk_buro_resumen_reporte PRIMARY KEY (br_secuencial)
end 

if not exists (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'pk_score_buro') AND type in (N'PK')) begin 
   ALTER TABLE cr_score_buro
   ADD CONSTRAINT pk_score_buro PRIMARY KEY (sb_secuencial)
end 

--Foreign Keys
IF (OBJECT_ID('dbo.fk_empleo_buro_interface_buro', 'F') IS NOT NULL) begin
   ALTER TABLE cr_empleo_buro
   ADD  CONSTRAINT fk_empleo_buro_interface_buro  FOREIGN KEY (eb_ib_secuencial)
   REFERENCES cr_interface_buro(ib_secuencial)
end 

IF (OBJECT_ID('dbo.fk_direccion_buro_interface_buro', 'F') IS NOT NULL) begin
   ALTER TABLE cr_direccion_buro
   ADD CONSTRAINT fk_direccion_buro_interface_buro  FOREIGN KEY (db_ib_secuencial)
   REFERENCES cr_interface_buro(ib_secuencial)
end

IF (OBJECT_ID('dbo.fk_consultas_buro_interface_buro', 'F') IS NOT NULL) begin
   ALTER TABLE cr_consultas_buro
   ADD CONSTRAINT fk_consultas_buro_interface_buro  FOREIGN KEY (ce_ib_secuencial)
   REFERENCES cr_interface_buro(ib_secuencial)
end

IF (OBJECT_ID('dbo.fk_buro_resumen_reporte_interface_buro', 'F') IS NOT NULL) begin
   ALTER TABLE cr_buro_resumen_reporte
   ADD  CONSTRAINT fk_buro_resumen_reporte_interface_buro  FOREIGN KEY (br_ib_secuencial)
   REFERENCES cr_interface_buro(ib_secuencial)
end

IF (OBJECT_ID('dbo.fk_score_buro_interface_buro', 'F') IS NOT NULL) begin
   ALTER TABLE cr_score_buro
   ADD  CONSTRAINT fk_score_buro_interface_buro  FOREIGN KEY (sb_ib_secuencial)
   REFERENCES cr_interface_buro(ib_secuencial)
end   


IF (OBJECT_ID('dbo.fk_buro_encabezado_interface_buro', 'F') IS NOT NULL) begin
  ALTER TABLE cr_buro_encabezado
  ADD CONSTRAINT fk_buro_encabezado_interface_buro 
  FOREIGN KEY (be_ib_secuencial) REFERENCES cr_interface_buro(ib_secuencial)
END
GO
