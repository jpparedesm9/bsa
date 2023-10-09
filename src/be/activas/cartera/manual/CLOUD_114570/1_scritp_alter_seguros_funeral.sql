
use cob_cartera
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'ra_rfc'
              and  c1.table_name = 'seguros_funeral_net_altas_tmp')
begin 
alter table seguros_funeral_net_altas_tmp
add ra_rfc varchar(30) null
end 
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'ra_operacion'
              and  c1.table_name = 'seguros_funeral_net_altas_tmp')
begin 
alter table seguros_funeral_net_altas_tmp
add ra_operacion varchar(10) null
end     
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'ra_tipo_plan'
              and  c1.table_name = 'seguros_funeral_net_altas_tmp')
begin 
alter table seguros_funeral_net_altas_tmp
add ra_tipo_plan varchar(10) null
end  
go




use cob_cartera
go

IF OBJECT_ID ('ca_vigencia_funeral_net') IS NOT NULL
	DROP TABLE ca_vigencia_funeral_net
GO


create table ca_vigencia_funeral_net
(
 vfn_ente            int              ,
 vfn_buc             varchar(64)  null,
 vfn_operacion       int          null,
 vfn_fecha_inicio    datetime     null,
 vfn_fecha_baja      datetime     null,
 vfn_fecha_vigencia  datetime     null,
 vfn_fecha_pro_baja  datetime     null
)

create index ca_vigencia_funeral_net_key on ca_vigencia_funeral_net(vfn_ente)
go
create index ca_vigencia_funeral_net_key2 on ca_vigencia_funeral_net(vfn_fecha_baja) 
go
