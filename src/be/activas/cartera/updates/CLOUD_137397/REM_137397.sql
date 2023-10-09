use cobis
go


delete from cl_parametro where pa_nemonico in ('DESCUO', 'CUODES')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DESPLAZAMIENTO DE CUOTAS', 'DESCUO', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO CUOTAS DE DESPLAZAMIENTO', 'CUODES', 'I', NULL, NULL, NULL, 8, NULL, NULL, NULL, 'CCA')
go


use cobis
go
delete from cobis..ba_batch where ba_batch = 7093

if not exists(select 1 from cobis..ba_batch where ba_batch = 7093)
begin
    insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (7093, 'APLICACION MASIVA DE DESPLAZAMIENTOS', 'APLICACION MASIVA DE DESPLAZAMIENTOS', 'SP', getdate(), 36, 'P', 1, NULL, 'DSP_.txt', 'cob_cartera..sp_desplazamiento_carga', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Cartera\Objetos\', 'C:\Cobis\VBatch\Cartera\listados\Desplazamientos\')
end
go

select * from cobis..ba_batch where ba_batch = 7093
use cob_cartera
go

IF OBJECT_ID ('dbo.ca_desplazamiento_archivo') IS NOT NULL
	DROP table dbo.ca_desplazamiento_archivo
go
create table cob_cartera..ca_desplazamiento_archivo(
da_banco    varchar(24),
da_cliente  int,
da_cuotas   int,
da_mensaje  varchar(255)
)

create index idx1 on ca_desplazamiento_archivo(da_banco) 

go

use cob_cartera
go

IF OBJECT_ID ('dbo.ca_desplazamiento_archivo_tmp') IS NOT NULL
	DROP table dbo.ca_desplazamiento_archivo_tmp
go
create table cob_cartera..ca_desplazamiento_archivo_tmp(
da_banco_tmp    varchar(24),
da_cliente_tmp  varchar(24),
da_cuotas_tmp   varchar(24),
da_mensaje_tmp  varchar(255)
)

create index idx1 on ca_desplazamiento_archivo_tmp(da_banco_tmp) 

go




use cobis
go

if not exists(select  1 from cobis..cl_errores
		        where numero=720330)	
begin	 

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720330, 1, 'NO SE ENCONTRO EL ARCHIVO')

end

use cobis
go

if not exists(select  1 from cobis..cl_errores
		        where numero=720331)	
begin	 

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720331, 1, 'PROCESADO ANTERIORMENTE')

end

use cobis
go
if not exists(select  1 from cobis..cl_errores
		        where numero=720332)	
begin	 

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720332, 1, 'NO EXISTE LA RUTA DEL ARCHIVO')

end

--Andy

use cob_cartera 
go 


if object_id ('dbo.ca_desplazamiento') is not null
	drop table dbo.ca_desplazamiento
go


create table ca_desplazamiento ( 

de_operacion	int       not null, 
de_banco	    cuenta    not null, 
de_cuotas	    int       not null,
de_fecha_ini	datetime  not null,
de_fecha_fin	datetime  not null,
de_archivo      varchar(255) not null,
de_int_dsp	    money      null,
de_fecha_real	datetime   not null,
de_estado	    char(1)    not null,
de_secuencial	int        null 

)


create  unique index idx1 on ca_desplazamiento (de_operacion,de_secuencial)
go

create  index idx2 on ca_desplazamiento (de_banco,de_estado)
go

--drop index  idx1 on ca_desplazamiento

delete ca_tipo_trn where tt_codigo = 'DSP'


INSERT INTO dbo.ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable)
VALUES ('DSP', 'DESPLAZAMIENTO DE CUOTAS', 'S', 'N')
GO
