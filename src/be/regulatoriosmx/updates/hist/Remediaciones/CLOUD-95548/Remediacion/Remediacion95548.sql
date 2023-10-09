----------------
--REDMINE 95548
----------------
use cob_cartera
go


IF OBJECT_ID ('ca_gen_ref_cuota_vigente') IS NOT NULL
	DROP TABLE ca_gen_ref_cuota_vigente
go

create table ca_gen_ref_cuota_vigente
(
    grv_grupo_id        int,
    grv_fecha_proceso   datetime,
    grv_grupo_name      varchar(64) null,
    grv_tramite         int null,
    grv_op_fecha_liq    datetime,
    grv_op_moneda       tinyint,
    grv_op_oficina      smallint,
    grv_di_fecha_vig    datetime,
    grv_di_dividendo    int,
    grv_di_monto        money,
    grv_institucion1    varchar(20) null,
    grv_referencia1     varchar(255) null,
    grv_institucion2    varchar(20) null,
    grv_referencia2     varchar(255) null,
    grv_institucion3    varchar(20) null,
    grv_referencia3     varchar(255) null,
    grv_institucion4    varchar(20) null,
    grv_referencia4     varchar(255) null,
    grv_dest_nombre1    varchar(60) null,
    grv_dest_cargo1     varchar(100) null,
    grv_dest_email1     varchar(255) null,
    grv_dest_nombre2    varchar(60) null,
    grv_dest_cargo2     varchar(100) null,
    grv_dest_email2     varchar(255) null,
    grv_dest_nombre3    varchar(60) null,
    grv_dest_cargo3     varchar(100) null,
    grv_dest_email3     varchar(255) null,
    grv_dest_nombre4    varchar(60) null,
    grv_dest_cargo4     varchar(100) null,
    grv_dest_email4     varchar(255) null,
	grv_convenio        varchar(30)  null
)
go
create clustered index ca_gen_ref_cuota_vigente1
    on ca_gen_ref_cuota_vigente (grv_grupo_id, grv_fecha_proceso)
go


if exists (select 1 from sysobjects 
    where name = 'ca_pago_en_corresponsal' 
    and type = 'U')
drop table ca_pago_en_corresponsal
go

create table ca_pago_en_corresponsal
(
    pc_grupo_id int,
    pc_fecha_proceso datetime,
    pc_grupo_name varchar(64) null,
    pc_op_fecha_liq datetime,
    pc_op_moneda tinyint,
    pc_op_oficina smallint,
    pc_di_fecha_vig datetime,
    pc_di_dividendo int,
    pc_di_monto money,
    pc_institucion1 varchar(20) null,
    pc_referencia1 varchar(255) null,
    pc_institucion2 varchar(20) null,
    pc_referencia2 varchar(255) null,
    pc_institucion3 varchar(20) null,
    pc_referencia3 varchar(255) null,
    pc_institucion4 varchar(20) null,
    pc_referencia4 varchar(255) null,
    pc_dest_nombre1 varchar(60) null,
    pc_dest_cargo1 varchar(100) null,
    pc_dest_email1 varchar(255) null,
    pc_dest_nombre2 varchar(60) null,
    pc_dest_cargo2 varchar(100) null,
    pc_dest_email2 varchar(255) null,
    pc_dest_nombre3 varchar(60) null,
    pc_dest_cargo3 varchar(100) null,
    pc_dest_email3 varchar(255) null
)
go

create clustered index ca_pago_en_corresponsal1
    on ca_pago_en_corresponsal (pc_grupo_id, pc_fecha_proceso)
go