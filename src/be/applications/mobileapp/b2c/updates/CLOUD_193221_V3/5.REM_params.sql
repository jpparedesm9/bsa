-- -------------------------
-- CLOUD_191122_707383_vulnerabilidades\src\be\applications\mobileapp\b2c\updates\CLOUD_191122_688882\02.REM_PARAMETROS.sql
use cobis
go

delete from cobis..cl_parametro where pa_nemonico in ('TOVCO','TOVSM') and pa_producto='BVI'

insert into cobis..cl_parametro (pa_parametro,pa_nemonico, pa_tipo,pa_smallint, pa_producto)
values('TIEMPO DE VIGENCIA OTP CORREO','TOVCO','S',120,'BVI')
insert into cobis..cl_parametro (pa_parametro,pa_nemonico, pa_tipo,pa_smallint, pa_producto)
values('TIEMPO DE VIGENCIA OTP SMS','TOVSM','S',120,'BVI')
go
