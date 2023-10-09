print 'Registro tabla negative file carga inicial'
use cob_credito
go
if exists(select 1 from sysobjects where name = 'cr_negative_file_carg_ini')
    drop table cr_negative_file_carg_ini
go

create table cr_negative_file_carg_ini
	(
        nfi_tipo_documento        varchar(300),
        nfi_rfc_pasaporte         varchar(300),
        nfi_genero                varchar(300),
        nfi_ape_paterno           varchar(300),
        nfi_ape_materno           varchar(300),
        nfi_apellidos             varchar(300),
        nfi_nombre_razon_social   varchar(300),
        nfi_fecha_nac             varchar(300),
        nfi_alias                 varchar(300),
        nfi_relacionado_con       varchar(300),
        nfi_codigo_negative       varchar(300),
        nfi_tipologia_operacion   varchar(300),
        nfi_vinculacion_operacion varchar(300),
        nfi_entidad_reportada     varchar(300),
        nfi_fuente_nf             varchar(300),
        nfi_zona_geografica       varchar(300),
        nfi_fecha_inclusion       varchar(300),
        nfi_fecha_vencimiento     varchar(300),
        nfi_fecha_inhabilitación  varchar(300),
        nfi_fecha_rehabilitación  varchar(300),
        nfi_fecha_veredicto       varchar(300),
        nfi_fecha_envio           varchar(300),
        nfi_datos_identificacion  varchar(300),
        nfi_acciones              varchar(300)	
	)
GO

print 'Registro tabla negative file'

use cob_credito
go
if exists(select 1 from sysobjects where name = 'cr_negative_file')
    drop table cr_negative_file
go

CREATE TABLE cr_negative_file
	(
		nf_secuencial            int identity not null,
		nf_fecha_ultima_carga    datetime,
        nf_tipo_documento        varchar(300),
        nf_rfc_pasaporte         varchar(300),
        nf_genero                varchar(300),
        nf_ape_paterno           varchar(300),
        nf_ape_materno           varchar(300),
        nf_apellidos             varchar(300),
        nf_nombre_razon_social   varchar(300),
        nf_fecha_nac             varchar(300),
        nf_alias                 varchar(300),
        nf_relacionado_con       varchar(300),
        nf_codigo_negative       varchar(300),
        nf_tipologia_operacion   varchar(300),
        nf_vinculacion_operacion varchar(300),
        nf_entidad_reportada     varchar(300),
        nf_fuente_nf             varchar(300),
        nf_zona_geografica       varchar(300),
        nf_fecha_inclusion       varchar(300),
        nf_fecha_vencimiento     varchar(300),
        nf_fecha_inhabilitación  varchar(300),
        nf_fecha_rehabilitación  varchar(300),
        nf_fecha_veredicto       varchar(300),
        nf_fecha_envio           varchar(300),
        nf_datos_identificacion  varchar(300),
        nf_acciones              varchar(300)

		PRIMARY KEY (nf_secuencial)			
	)
GO

use cobis
go

print 'Registro de Parametro PATH NEGATIVE FILE'
if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'PHNFDE' and pa_producto = 'CRE')
begin
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
    VALUES ('PATH NEGATIVE FILE', 'PHNFDE', 'C', 'C:\NegativeFile\', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')		
end 
go
