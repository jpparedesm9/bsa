----------->>>>>>>>>>>COLUMNAS
use cob_cartera
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'se_mes_inicial'
              and  c1.table_name = 'ca_param_seguro_externo')
begin 
    alter table ca_param_seguro_externo
    add se_mes_inicial int
end 

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'se_mes_final'
              and  c1.table_name = 'ca_param_seguro_externo')
begin 
    alter table ca_param_seguro_externo
    add se_mes_final int
end 
GO

----------->>>>>>>>>>>PARAMETRIZACION SEGURO
use cob_cartera
go

declare @w_id int, @w_producto varchar(256)

select @w_producto = 'INDIVIDUAL'
select * from ca_param_seguro_externo where se_producto = @w_producto
delete ca_param_seguro_externo where se_producto = @w_producto
--12 por un mes
select @w_id = max (se_id) + 1 from ca_param_seguro_externo
insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto, se_mes_inicial, se_mes_final)
values (@w_id, 'BASICO', 'Seguro de vida', 'Seguro de vida', 12.00, 80, 'V', 0.5, @w_producto, 1, 9)

select @w_id = max (se_id) + 1 from ca_param_seguro_externo
insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto, se_mes_inicial, se_mes_final)
values (@w_id, 'BASICO', 'Seguro de vida', 'Seguro de vida', 15.00, 80, 'V', 0.5, @w_producto, 10, 10)

select @w_id = max (se_id) + 1 from ca_param_seguro_externo
insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto, se_mes_inicial, se_mes_final)
values (@w_id, 'BASICO', 'Seguro de vida', 'Seguro de vida', 15.00, 80, 'V', 0.5, @w_producto, 11, 11)

select @w_id = max (se_id) + 1 from ca_param_seguro_externo
insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto, se_mes_inicial, se_mes_final)
values (@w_id, 'BASICO', 'Seguro de vida', 'Seguro de vida', 15.00, 80, 'V', 0.5, @w_producto, 12, 12)
    
select @w_id = max (se_id) + 1 from ca_param_seguro_externo
insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto, se_mes_inicial, se_mes_final)
values (@w_id, 'EXTENDIDO', 'Seguro de Vida y Complementario', 'Seguro Complementario', 180, 80, 'V', 0, @w_producto, 1, 1)

select @w_id = max (se_id) + 1 from ca_param_seguro_externo
insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto, se_mes_inicial, se_mes_final)
values (@w_id, 'NINGUNO', 'Sin Seguro', 'Ninguno', 0, 99, 'V', 0, @w_producto, 1, 1)

select * from  ca_param_seguro_externo where se_producto = @w_producto
go
--4 basicos por lps valores de la tabla y extendido va el valor más el seguro medico

----------->>>>>>>>>>>REGISTRO EN CATALOGO -- VALIDAR CODIGO
--CATALOGOS ACTIVIDADES DEPUES DE ESPERA DE GARANTIAS
use cobis
go

declare @w_id_tabla int, @w_tabla char(30)
select  @w_tabla = 'cr_activ_desp_gar_liq'

select @w_id_tabla = codigo from cl_tabla where tabla = @w_tabla

select * from cl_catalogo where tabla = @w_id_tabla and codigo = 'INDIVIDUAL'

delete cl_catalogo where tabla = @w_id_tabla and codigo = 'INDIVIDUAL'
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_id_tabla, 'INDIVIDUAL', '9', 'V', NULL, NULL, NULL)

select * from cl_catalogo where tabla = @w_id_tabla and codigo = 'INDIVIDUAL'

go

----------->>>>>>>>>>>COLUMNA FICHA DE PAGO
use cob_cartera
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'ind_tramite'
              and  c1.table_name = 'ca_infogaragrupo_det')
begin 
    alter table ca_infogaragrupo_det
    add ind_tramite int
end 
go

----------->>>>>>>>>>>NUEVAS TABLAS PARA REPORTES FICHA DE PAGO
IF OBJECT_ID ('dbo.ca_infogaracliente_det') IS not null
	DROP TABLE dbo.ca_infogaracliente_det
GO

create table dbo.ca_infogaracliente_det
	(
	ind_cliente_id     int not null,
	ind_corresponsal   varchar (10) not null,
	ind_institucion    varchar (20) not null,
	ind_referencia     varchar (40) not null,
	ind_convenio       varchar (30) null,
    ind_tramite        int null
	)
GO

CREATE INDEX idx_ind_cliente_id
	ON dbo.ca_infogaracliente_det (ind_cliente_id)
GO
------->>>>
IF OBJECT_ID ('dbo.ca_infosegurocliente_det') IS not null
	DROP TABLE dbo.ca_infosegurocliente_det
GO

create table dbo.ca_infosegurocliente_det
	(
	isd_cliente            int,
	isd_nombre_cliente     varchar (500),
	isd_monto_seguro       money,
	isd_monto_asist_medica money,
	isd_monto_garantia     money,
	isd_grupo              int,
	isd_tramite            int
	)
GO

CREATE INDEX idx_isd_cliente
	ON dbo.ca_infosegurocliente_det (isd_cliente)
GO

CREATE INDEX idx_isd_tramite
	ON dbo.ca_infosegurocliente_det (isd_tramite)
GO

------>>>
IF OBJECT_ID ('dbo.ca_infogaracliente') IS not null
	DROP TABLE dbo.ca_infogaracliente
GO

create table dbo.ca_infogaracliente
	(
	in_cliente_id      int not null,
	in_nombre_cliente  varchar (64),
	in_fecha_proceso   datetime not null,
	in_fecha_liq       datetime not null,
	in_fecha_venc      datetime not null,
	in_moneda          tinyint not null,
	in_oficina_id      smallint not null,
	in_num_pago        tinyint not null,
	in_monto           money not null,
	in_dest_nombre1    varchar (64),
	in_dest_cargo1     varchar (100),
	in_dest_email1     varchar (255),
	in_dest_nombre2    varchar (64),
	in_dest_cargo2     varchar (100),
	in_dest_email2     varchar (255),
	in_dest_nombre3    varchar (64),
	in_dest_cargo3     varchar (100),
	in_dest_email3     varchar (255),
	in_tramite         int
	)
GO

CREATE INDEX idx_tramite
	ON dbo.ca_infogaracliente (in_tramite)
GO

CREATE INDEX idxin_cliente_id
	ON dbo.ca_infogaracliente (in_cliente_id)
GO

----------->>>>>>>>>>>COLUMNA OPERACION en garantias liquidas
use cob_cartera
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'ngl_operacion'
              and  c1.table_name = 'ca_ns_garantia_liquida')
begin 
    alter table ca_ns_garantia_liquida
    add ngl_operacion varchar(10)
end 
go

----------->>>>>>>>>>>SE AGREGA PARAMETROS
use cobis
go

declare @w_cod_tabla int

select @w_cod_tabla = codigo from cobis..cl_tabla where tabla = 'ca_param_notif'

select * from cobis..cl_catalogo where tabla = @w_cod_tabla and codigo like 'PFGLI_%'
delete cobis..cl_catalogo where tabla = @w_cod_tabla and codigo like 'PFGLI_%'

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod_tabla, 'PFGLI_NJAS', 'GarantiasLiquidas.jasper', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod_tabla, 'PFGLI_NPDF', 'GarantiasLiquidas_', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod_tabla, 'PFGLI_NXML', 'pagogaraliq.xml', 'V', NULL, NULL, NULL)

select * from cobis..cl_catalogo where tabla = @w_cod_tabla and codigo like 'PFGLI_%'
go
