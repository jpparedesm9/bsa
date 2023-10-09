--================ BSA ================================================
--======= Caso 158406 - Geolocalización B2C - AutoOnboarding 168293 F2 
--=====================================================================
use cob_conta_super
go

if object_id ('sb_rpt_geolocaliza_b2c') is not null
	drop table sb_rpt_geolocaliza_b2c
go

create table sb_rpt_geolocaliza_b2c(
	FECHA				         varchar(10) null, 		
	TIPO_DE_TRANSACCION          varchar(64) null,
	BUC    				         varchar(20) null,
	NUMERO_DE_OPERACION          varchar(20) null,
	CUENTA    			         varchar(24) null,
	PRODUCTO    		         varchar(15) null,
	SUBPRODUCTO    		         varchar(15) null,
	APLICATIVO    		         varchar(11) null,
	LONGITUD    		         varchar(21) null,
	LATITUD    			         varchar(21) null,
	MONTO                        varchar(8)  null,
	HORA                         varchar(8)  null,
	ID_SESION                    varchar(10) null,
	CLASIFICACION_DE_OPERACIONES varchar(29) null,
	ESTATUS_DE_OPERACION         varchar(21) null,
	ID_OPERACION                 varchar(20) null
)
go
create index idx_rpt_geolocaliza_b2c
	on sb_rpt_geolocaliza_b2c(FECHA)
go

