-- cob_bvirtual.dbo.bv_geolocaliza_operacion definition

-- Drop table

-- DROP TABLE cob_bvirtual.dbo.bv_geolocaliza_operacion;

use cob_bvirtual
go
if (OBJECT_ID('bv_geolocaliza_operacion')) IS NOT NULL
    drop table bv_geolocaliza_operacion
go

CREATE TABLE bv_geolocaliza_operacion (
	go_ssn int NOT NULL,
	go_login varchar(14) NOT NULL,
	go_tipo_tran varchar(10) NOT NULL,
	go_tipo_serv varchar(10) NOT NULL,
	go_aplicativo varchar(11) NOT NULL,
	go_longitud varchar(20) NOT NULL,
	go_latitud varchar(20) NOT NULL,
	go_ente int NULL,
	go_fecha datetime NULL, 
	go_fecha_proceso datetime NULL
)

CREATE NONCLUSTERED INDEX idx_geoloc_oper_main ON bv_geolocaliza_operacion (go_login);
CREATE NONCLUSTERED INDEX idx_geoloc_oper_ssn ON bv_geolocaliza_operacion (go_ssn);