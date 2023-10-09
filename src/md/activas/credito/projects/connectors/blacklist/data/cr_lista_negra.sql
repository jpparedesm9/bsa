USE cob_credito
GO

IF OBJECT_ID ('dbo.cr_lista_negra') IS NOT NULL
    DROP TABLE dbo.cr_lista_negra
GO

create table cr_lista_negra
(
    ln_id                   int             IDENTITY(1,1) not null,
    ln_fecha_reg            datetime        not null,
    ln_id_lista             varchar(25)     not null,
    ln_nombre               varchar(100)	NULL,
    ln_apellido_paterno     varchar(100)	NULL,
    ln_apellido_materno     varchar(100)	NULL,
    ln_curp                 varchar(20)		NULL,
    ln_rfc                  varchar(15)		NULL,
    ln_fecha_nac            varchar(10)		NULL,
    ln_tipo_lista           varchar(10)		NULL,
    ln_estado               varchar(20)		NULL,
    ln_dependencia          varchar(200)	NULL,
    ln_puesto               varchar(200)	NULL,
    ln_iddispo              varchar(10)		NULL,
    ln_curp_ok              varchar(8)		NULL,
    ln_id_rel               varchar(25)		NULL,
    ln_parentesco           varchar(20)		NULL,
    ln_razon_social         varchar(250)	NULL,
    ln_rfc_moral            varchar(15)		NULL,
    ln_num_seg_social       varchar(50)		NULL,
    ln_imss                 varchar(50)		NULL,
    ln_ingresos             varchar(20)		NULL,
    ln_nom_completo         varchar(300)	NULL,
    ln_apellidos            varchar(200)	NULL,
    ln_entidad              varchar(50)		NULL,
    ln_sexo                 varchar(10)		NULL,
    ln_area                 varchar(200)	NULL
)
go

CREATE nonclustered INDEX cr_lista_negra_key
	ON dbo.cr_lista_negra (ln_id)
go
CREATE nonclustered INDEX cr_lista_negra_iden_key
	ON dbo.cr_lista_negra (ln_curp, ln_rfc)
go
CREATE nonclustered INDEX cr_lista_negra_nom_key
	ON dbo.cr_lista_negra (ln_nombre, ln_apellido_paterno, ln_apellido_materno)
go
ALTER TABLE dbo.cr_lista_negra ADD  CONSTRAINT [DF_cr_lista_negra_ln_fecha_reg]  DEFAULT (getdate()) FOR [ln_fecha_reg]
GO
