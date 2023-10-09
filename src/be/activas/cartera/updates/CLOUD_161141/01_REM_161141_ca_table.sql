use cob_cartera
go
-- Alta Masiva de Prospectos
IF OBJECT_ID ('dbo.ca_alta_masiva_prosp') IS NOT NULL
    DROP TABLE dbo.ca_alta_masiva_prosp
go

CREATE TABLE dbo.ca_alta_masiva_prosp
(
    am_nombre_archivo   varchar(255) not null,
    am_fecha_carga      datetime     null,
    am_login            login        null,
    am_cant_reg_exito   int          null,
    am_total            int          null,
	am_estado           char(1)      not null -- C=Pendiente; P=Procesado
)
go
CREATE UNIQUE INDEX idx_ca_alta_mas_prosp_1 ON ca_alta_masiva_prosp(am_nombre_archivo)
go

