--------------------
--REMEDIACION 96957
--------------------
use cob_cartera
go

--ca_seguros_nuevos
alter table ca_seguros_nuevos
ALTER COLUMN  sn_sucursal            varchar (70)
alter table ca_seguros_nuevos
ALTER COLUMN  sn_nro_prestamo        varchar (24)
alter table ca_seguros_nuevos
ALTER COLUMN  sn_nombre_1            varchar (64)
alter table ca_seguros_nuevos
ALTER COLUMN  sn_rfc_1               varchar (30)
alter table ca_seguros_nuevos
ALTER COLUMN  sn_fecha_nac_1         varchar (10)
alter table ca_seguros_nuevos
ALTER COLUMN  sn_sexo_1              varchar (1) 
alter table ca_seguros_nuevos
ALTER COLUMN  sn_nombre_2            varchar (64)
alter table ca_seguros_nuevos
ALTER COLUMN  sn_rfc_2               varchar (30)
alter table ca_seguros_nuevos
ALTER COLUMN  sn_fecha_nac_2         varchar (10)
alter table ca_seguros_nuevos
ALTER COLUMN  sn_sexo_2              varchar (1) 
alter table ca_seguros_nuevos
ALTER COLUMN  sn_nombre_3            varchar (64)
alter table ca_seguros_nuevos
ALTER COLUMN  sn_rfc_3               varchar (30)
alter table ca_seguros_nuevos
ALTER COLUMN  sn_fecha_nac_3         varchar (10)
alter table ca_seguros_nuevos
ALTER COLUMN  sn_sexo_3              varchar (1)
GO


--ca_seguro_externo
alter table ca_seguro_externo
ALTER COLUMN  se_banco varchar(24)

go