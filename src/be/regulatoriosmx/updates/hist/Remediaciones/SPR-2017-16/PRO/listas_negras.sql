use cob_credito
go

IF OBJECT_ID ('dbo.cr_lista_negra') IS NOT NULL
    DROP TABLE dbo.cr_lista_negra
GO

create table cr_lista_negra
(
    ln_id                   int             not null,
    ln_fecha_reg            datetime        not null,
    ln_id_lista             varchar(25)     not null,
    ln_nombre               varchar(100),
    ln_apellido_paterno     varchar(100),
    ln_apellido_materno     varchar(100),
    ln_curp                 varchar(20),
    ln_rfc                  varchar(15),
    ln_fecha_nac            datetime,
    ln_tipo_lista           varchar(10),
    ln_estado               varchar(20),
    ln_dependencia          varchar(200),
    ln_puesto               varchar(200),
    ln_iddispo              varchar(10),
    ln_curp_ok              varchar(8),
    ln_id_rel               varchar(25),
    ln_parentesco           varchar(20),
    ln_razon_social         varchar(250),
    ln_rfc_moral            varchar(15),
    ln_num_seg_social       varchar(50),
    ln_imss                 varchar(50),
    ln_ingresos             varchar(20),
    ln_nom_completo         varchar(300),
    ln_apellidos            varchar(200),
    ln_entidad              varchar(50),
    ln_sexo                 varchar(10),
    ln_area                 varchar(100)
)
go

CREATE nonclustered INDEX cr_lista_negra_key
	ON dbo.cr_lista_negra (ln_id)
go
CREATE nonclustered INDEX cr_lista_negra_iden_key
	ON dbo.cr_lista_negra (ln_curp,ln_rfc)
go
CREATE nonclustered INDEX cr_lista_negra_nom_key
	ON dbo.cr_lista_negra (ln_nombre,ln_apellido_paterno,ln_apellido_materno)

GO
if not exists(select 1 from cobis..cl_seqnos where tabla = 'cr_lista_negra')
begin
	insert into cobis..cl_seqnos
	values('cob_credito','cr_lista_negra',0,'cr_lista_negra_key')
end
go
