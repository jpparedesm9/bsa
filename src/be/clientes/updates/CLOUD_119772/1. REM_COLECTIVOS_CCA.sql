use cobis
go

declare 
@w_of_regional       int,
@w_of_avon           int, 
@w_of_independiente  int ,
@w_fecha_proceso     datetime,
@w_sis_operativo     int,
@w_secuencial        int

select 
@w_of_regional       = 9100,
@w_of_avon           = 9101,
@w_of_independiente  = 9102

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso


--actualizado en cl_table.sql
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'i_d_descripcion' AND object_id = OBJECT_ID('dbo.cl_direccion'))
begin
   create nonclustered index i_d_descripcion on dbo.cl_direccion (di_descripcion,di_tipo)
end


--actualizado en instalador cl_parametros.sql
if exists ( select 1 from cobis..cl_parametro where pa_nemonico in ('VENMIN','VENMAX')) 
   delete cobis..cl_parametro where pa_nemonico in ('VENMIN','VENMAX')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('VENTAS MENSUALES MINIMAS COLECTIVO', 'VENMIN', 'M', NULL, NULL, NULL, NULL, 1000, NULL, NULL, 'CLI')


insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('VENTAS MENSUALES MAXIMA COLECTIVO', 'VENMAX', 'M', NULL, NULL, NULL, NULL, 300000, NULL, NULL, 'CLI')



--CREACION DE LAS REGIONALES
--actualizdo en src/be/activas/cartera/installer/sql/Param_Conta_MX/cb_oficina.sql

select * into #cl_regional from cobis..cl_oficina     where  of_oficina = 1300
select * into #cb_regional from cob_conta..cb_oficina where  of_oficina = 1900


update #cl_regional set 
of_oficina   = @w_of_regional,
of_nombre    = 'REGION COLECTIVO',
of_direccion = 'REGION VIRTUAL',
of_ciudad    = 271,
of_telefono  = null,
of_provincia = 9,
of_barrio    = 28340,
of_sucursal  = 1,
of_bloqueada = 'N'


update #cb_regional set 
of_oficina       = @w_of_regional,
of_oficina_padre = 9000,
of_descripcion   = 'REGIONAL COLECTIVO'


delete cobis..cl_oficina     where of_oficina = @w_of_regional 
delete cob_conta..cb_oficina where of_oficina = @w_of_regional 

insert into cobis..cl_oficina     select * from #cl_regional
insert into cob_conta..cb_oficina select * from #cb_regional


--CREACION DE LAS OFICINA AVON E INDEPENDIENTE

select * into #cl_oficina_av   from  cobis..cl_oficina        where of_oficina = 1037
select * into #cb_oficina_av   from  cob_conta..cb_oficina    where of_oficina = 9001
select * into #cl_oficina_ind  from  cobis..cl_oficina        where of_oficina = 1037
select * into #cb_oficina_ind  from  cob_conta..cb_oficina    where of_oficina = 9001
select * into #ad_nodo_oficina from  cobis..ad_nodo_oficina   where nl_oficina = 9001


update #cl_oficina_av set 
of_oficina = @w_of_avon,
of_nombre    = 'AVON',
of_direccion = 'OFICINA VIRTUAL',
of_ciudad    = 271,
of_telefono  = null,
of_provincia = 9,
of_barrio    = 28340,
of_sucursal  = 1,
of_bloqueada = 'N',
of_regional  = 8000

update #cl_oficina_ind set 
of_oficina   = @w_of_independiente,
of_nombre    = 'INDEPENDIENTE COLECTIVO',
of_direccion = 'OFICINA VIRTUAL',
of_ciudad    = 271,
of_telefono  = null,
of_provincia = 9,
of_barrio    = 28340,
of_sucursal  = 1,
of_bloqueada = 'N',
of_regional  = 8000


update #cb_oficina_av set 
of_oficina      =  @w_of_avon,
of_descripcion  = 'AVON',
of_oficina_padre = @w_of_regional

update #cb_oficina_ind set 
of_oficina      =  @w_of_independiente,
of_descripcion  = 'INDEPENDIENTE COLECTIVO',
of_oficina_padre = @w_of_regional

select @w_sis_operativo = max(so_sis_operativo)
from ad_sis_operativo

select @w_secuencial = max(nl_secuencial)
from cobis..ad_nodo_oficina

select @w_secuencial = @w_secuencial + 1

update #ad_nodo_oficina set 
nl_oficina        = @w_of_avon,
nl_filial         = 1,
nl_sis_operativo  = @w_sis_operativo,
nl_nombre         = 'NODO AVON',
nl_fecha_reg      = @w_fecha_proceso,
nl_fecha_habil    = @w_fecha_proceso,
nl_fecha_ult_mod  = @w_fecha_proceso,
nl_secuencial     = @w_secuencial
where nl_oficina = 9001

insert into #ad_nodo_oficina 
select * from  
cobis..ad_nodo_oficina   where nl_oficina = 9001

select @w_secuencial = @w_secuencial + 1

update #ad_nodo_oficina set 
nl_oficina        = @w_of_independiente,
nl_filial         = 1,
nl_sis_operativo  = @w_sis_operativo,
nl_nombre         = 'NODO INDEPENDIENTE',
nl_fecha_reg      = @w_fecha_proceso,
nl_fecha_habil    = @w_fecha_proceso,
nl_fecha_ult_mod  = @w_fecha_proceso,
nl_secuencial     = @w_secuencial
where nl_oficina = 9001

update cobis..cl_seqnos set
siguiente   = @w_secuencial + 1
where tabla = 'ad_nodo_oficina'
and bdatos  = 'cobis'

delete  cobis..cl_oficina      where of_oficina = @w_of_avon
delete  cob_conta..cb_oficina  where of_oficina = @w_of_avon
delete  cobis..cl_oficina      where of_oficina = @w_of_independiente
delete  cob_conta..cb_oficina  where of_oficina = @w_of_independiente
delete  cobis..ad_nodo_oficina where nl_oficina = @w_of_avon
delete  cobis..ad_nodo_oficina where nl_oficina = @w_of_independiente


insert into cobis..cl_oficina select * from  #cl_oficina_av
insert into cobis..cl_oficina select * from  #cl_oficina_ind
insert into cob_conta..cb_oficina select * from  #cb_oficina_av
insert into cob_conta..cb_oficina select * from  #cb_oficina_ind
insert into cobis..ad_nodo_oficina select * from #ad_nodo_oficina



---REL OFI --se actualiza dinamicamenete en el instalador src/be/activas/cartera/installer/sql/Param_Conta_MX/cb_relofi.sql

delete  cob_conta..cb_relofi  where re_ofadmin in ( @w_of_regional, @w_of_avon,@w_of_independiente) 
insert into cob_conta..cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta) values (1, 1, @w_of_regional, @w_of_regional)   --REG
insert into cob_conta..cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta) values (1, 1, @w_of_avon, @w_of_avon)
insert into cob_conta..cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta) values (1, 1, @w_of_independiente, @w_of_independiente)


--jerarquia --se actualiza dinamicameen src/be/activas/cartera/installer/sql/Param_Conta_MX/cb_oficina.sql

delete cob_conta..cb_jerarquia where je_oficina in ( @w_of_avon,@w_of_independiente)

insert into cob_conta..cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)values (1, @w_of_avon, 255, 1)
insert into cob_conta..cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)values (1, @w_of_avon, 9000, 2)
insert into cob_conta..cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)values (1, @w_of_avon, @w_of_regional, 3)
insert into cob_conta..cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)values (1, @w_of_avon, @w_of_avon, 4)


insert into cob_conta..cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)values (1, @w_of_independiente, 255, 1)
insert into cob_conta..cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)values (1, @w_of_independiente, 9000, 2)
insert into cob_conta..cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)values (1, @w_of_independiente, @w_of_regional, 3)
insert into cob_conta..cb_jerarquia (je_empresa, je_oficina, je_oficina_padre, je_nivel)values (1, @w_of_independiente, @w_of_independiente, 4)



select * from cobis..cl_oficina       where of_oficina in ( @w_of_regional,@w_of_avon,@w_of_independiente)
select * from cob_conta..cb_oficina   where of_oficina in ( @w_of_regional,@w_of_avon,@w_of_independiente)
select * from cob_conta..cb_relofi    where re_ofadmin in ( @w_of_regional, @w_of_avon,@w_of_independiente) 
select * from cob_conta..cb_jerarquia where je_oficina in ( @w_of_avon,@w_of_independiente)

go





use cob_cartera 
go 

--ACTUALIZADO EN src/be/activas/cartera/installer/sql/ca_table.sql
if object_id ('dbo.ca_qry_asesor_colectivo') is not null
	drop table dbo.ca_qry_asesor_colectivo
go

create table dbo.ca_qry_asesor_colectivo
	(
	co_id        int identity not null,
	co_colectivo varchar (255) null,
	co_nombre    varchar (255) null,
	co_cliente   varchar (255) null,
	co_direccion varchar (255) null,
	co_celular   varchar (255) null,
	co_email     varchar (255) null,
	co_asesor    varchar (255) null,
	co_user      login null
	)
go

IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'ca_qry_asesor_colectivo_1' AND object_id = OBJECT_ID('ca_qry_asesor_colectivo'))
   create clustered index ca_qry_asesor_colectivo_1
   on dbo.ca_qry_asesor_colectivo (co_id,co_user)
go



if object_id ('dbo.ca_asesor_colectivo') is not null
	drop table dbo.ca_asesor_colectivo
go

create table dbo.ca_asesor_colectivo
	(
	co_id        int identity not null,
	co_colectivo varchar (255) null,
	co_nombre    varchar (255) null,
	co_cliente   varchar (255) null,
	co_direccion varchar (255) null,
	co_celular   varchar (255) null,
	co_email     varchar (255) null,
	co_asesor    varchar (255) null,
	co_user      login null
	)
go

IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'ca_asesor_colectivo_1' AND object_id = OBJECT_ID('ca_asesor_colectivo'))
   create clustered index ca_asesor_colectivo_1
   on dbo.ca_asesor_colectivo (co_id,co_user)
go


if object_id ('dbo.ca_colectivo_cargo') is not null
	drop table dbo.ca_colectivo_cargo
go

create table dbo.ca_colectivo_cargo
(
   cc_colectivo     varchar (255),
   cc_oficina       int          ,
   cc_rol           varchar (255),
   cc_funcionario   varchar (255)   
)
go

IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'idx_ca_asesor_colectivo_1' AND object_id = OBJECT_ID('ca_colectivo_cargo'))
    create index idx_ca_asesor_colectivo_1
    on dbo.ca_colectivo_cargo (cc_colectivo,cc_rol)
go

IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'idx_ca_asesor_colectivo_2' AND object_id = OBJECT_ID('ca_colectivo_cargo'))
   create index idx_ca_asesor_colectivo_2
   on dbo.ca_colectivo_cargo (cc_funcionario)
go



drop table  #cl_regional
drop table  #cb_regional
drop table  #cl_oficina_av
drop table  #cb_oficina_av 
drop table  #cl_oficina_ind
drop table  #cb_oficina_ind
drop table  #ad_nodo_oficina

