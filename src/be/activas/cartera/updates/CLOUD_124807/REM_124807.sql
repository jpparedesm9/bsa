
use cob_cartera
go

IF OBJECT_ID ('dbo.ca_param_seguro_externo') IS NOT NULL
	DROP table dbo.ca_param_seguro_externo
go

create table cob_cartera..ca_param_seguro_externo
	(
	se_id                   int,
	se_paquete              varchar (16),
	se_descripcion          varchar (64),
	se_formato_consen       varchar (24),
	se_valor                money,
	se_edad_max             int,
	se_estado               char (1)
	)
go

use cob_cartera
go
insert into cob_cartera..ca_param_seguro_externo (se_id,    se_paquete,     se_descripcion,  se_formato_consen,

                                     se_valor,  se_edad_max,   se_estado
                                     )
values                               (1   ,   'BASICO',        'Seguro de vida', 'Seguro de vida',
                                      48.00,     75,           'V' 
                                     )                
go

use cob_cartera
go

IF NOT EXISTS(
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'se_tramite' AND TABLE_NAME = 'ca_seguro_externo'
)

BEGIN
ALTER TABLE cob_cartera..ca_seguro_externo ADD se_tramite int NULL; 
END
go

use cob_cartera
go
IF NOT EXISTS(
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'se_grupo' AND TABLE_NAME = 'ca_seguro_externo'
)

BEGIN
ALTER TABLE cob_cartera..ca_seguro_externo ADD se_grupo int NULL; 
END
go

use cobis
go
declare 
@w_id_tabla int

select @w_id_tabla=codigo from cobis..cl_tabla
where tabla='cl_institution_barcodes'
select @w_id_tabla

delete  from cobis..cl_catalogo
where tabla=@w_id_tabla
and valor in ('BANCO SANTANDER','ELAVON','OPENPAY')

insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'2','BANCO SANTANDER','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'3','ELAVON','V')
insert into cobis..cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'4','OPENPAY','V')

go