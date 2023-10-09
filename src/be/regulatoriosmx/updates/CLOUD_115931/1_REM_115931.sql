use cobis
go

declare
@w_codigo int 

select @w_codigo=codigo from cobis..cl_tabla
where tabla='ca_param_notif'

select @w_codigo


if not exists (select 1 from cobis..cl_catalogo where codigo='ETLCR_NJAS' and tabla=@w_codigo )
begin
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo, 'ETLCR_NJAS', 'AccountStatus_LCR.jasper', 'V', NULL, NULL, NULL)
end

if not exists (select 1 from cobis..cl_catalogo where codigo='ETLCR_NPDF' and tabla=@w_codigo )
begin
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo, 'ETLCR_NPDF', 'EstadoCtaLCR_', 'V', NULL, NULL, NULL)
end 

if not exists (select 1 from cobis..cl_catalogo where codigo='ETLCR_NXML' and tabla=@w_codigo )
begin
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo, 'ETLCR_NXML', 'AccountStatus_LCR.xml', 'V', NULL, NULL, NULL)
end

go


use cobis 
go

declare
@w_cod int 
   
select @w_cod=codigo  from cobis..cl_tabla 
   where tabla = 'ca_grupal'   

select @w_cod

if not exists(select * from cobis..cl_catalogo where codigo='REVOLVENTE' and tabla =@w_cod )
begin
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_cod, 'REVOLVENTE', 'Crédito Revolvente', 'V', NULL, NULL, NULL)
end 
go

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_info_cre_tmp_lcr') IS NOT NULL
	DROP table dbo.sb_info_cre_tmp_lcr
go

create table dbo.sb_info_cre_tmp_lcr
	(
	ic_secuencial          int,
	ic_fecha_inicio        datetime,
	ic_fecha_fin           datetime,
	ic_linea_credito       money,
	ic_linea_disponible    money,
	ic_capital             money,
	ic_interes_ordinario   money,
	ic_iva_int_ortdinario  money,
	ic_comision_gastos     money,
	ic_iva_comision_gastos money,
	ic_total               money,
	ic_frecuencia_pago     varchar (64),
	ic_plazo               int,
	ic_dia_pago            varchar (30),
	ic_tasa_ordinaria      float,
	ic_tasa_mensual        float,
	ic_base_calc_int       money,
	ic_cat                 float,
	ic_comisiones          money
	)
go

create clustered index idx_1
	on dbo.sb_info_cre_tmp_lcr (ic_secuencial)
go

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_resumen_pagos_tmp_lcr') IS NOT NULL
	DROP table dbo.sb_resumen_pagos_tmp_lcr
go

create table dbo.sb_resumen_pagos_tmp_lcr
	(
	rt_secuencial               int,
	rt_total_pagos              money,
	rt_capital                  money,
	rt_int_Ord                  money,
	rt_iva_Int_Ord              money,
	rt_gastos_cobranza          money,
	rt_iva_gastos_cobranza      money,
	rt_num_disposiciones        int,
	rt_importe_disposiciones    money,
	rt_importe_total_com        money,
	rt_fecha_cobro_cobranza     varchar(10),
	rt_importe_total_dispos     money,
	rt_fecha_cobro_dispos       varchar(10)
	)
go

create clustered index idx_1
	on dbo.sb_resumen_pagos_tmp_lcr (rt_secuencial)
go

USE cobis
go

if not exists (select 1 from cobis..cl_parametro
               where pa_nemonico='MECETC'
               and  pa_producto='REC')
begin
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MESES ELIMINACION ESTADO CUENTA', 'MECETC', 'I', NULL, NULL, NULL, 3, NULL, NULL, NULL, 'REC')
end 
go

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_dato_operacion_abono_temp_lcr') IS NOT NULL
	DROP table dbo.sb_dato_operacion_abono_temp_lcr
go

create table dbo.sb_dato_operacion_abono_temp_lcr
	(
	doa_sec                int identity (1,1) not null,
	doa_fecha_ope          varchar(10),
	doa_fecha_pac          varchar(10),
	doa_detalle_mov        varchar (100),
	doa_cap                money,
	doa_inte_ord           money,
	doa_iva_int            money,
	doa_comision_dis       money,
   doa_iva_comision_dis   money,
   doa_comision_cob       money,
   doa_iva_comision_cob   money, 
	doa_total              money,
	doa_saldo_cap          money,
	doa_banco              varchar (32),
	doa_fecha              datetime,
	doa_num_pago           int,
	doa_tipo_trn           varchar(10)
	 
	)
go

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_estcta_cab_tmp_lcr') IS NOT NULL
	DROP table dbo.sb_estcta_cab_tmp_lcr
go

create table dbo.sb_estcta_cab_tmp_lcr
	(
	ec_secuencial              int,
	ec_cod_sucursal            int,
	ec_sucursal                varchar (100),
	ec_producto                varchar (100),
	ec_nombre_cliente          varchar (100),
	ec_cod_grupo               int,
	ec_nom_grupo               varchar (100),
	ec_rfc                     varchar (30),
	ec_operacion               varchar (30),
	ec_calle                   varchar (70),
	ec_numero                  int,
	ec_parroquia               varchar (100),
	ec_delegacion              varchar (100),
	ec_codigo_postal           varchar (64),
	ec_estado                  varchar (64),
	ec_fecha_inicio            varchar (10),
	ec_fecha_reporte           varchar (10),
	ec_dia_habil               varchar (10),
	ec_importes                varchar (40),
	ec_folio_fiscal            varchar (1500),
	ec_certificado             varchar (1500),
	ec_sello_digital           varchar (1500),
	ec_sello_sat               varchar (1500),
	ec_no_de_serie_certificado varchar (1500),
	ec_fecha_certificacion     varchar (20),
	ec_cadena_origial_sat      varchar (1500),
	ec_estado_op               varchar(20) null
)
go

create clustered index idx_1
	on dbo.sb_estcta_cab_tmp_lcr (ec_secuencial)
go

USE cobis
go
if not exists (select 1 from cobis..cl_parametro
               where pa_nemonico='DPELCR'
               and  pa_producto='REC')
begin
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIA PROCESAMIENTO ECTLCR', 'DPELCR', 'I', NULL, NULL, NULL, 6, NULL, NULL, NULL, 'REC')
end 

if not exists (select 1 from cobis..cl_parametro
               where pa_nemonico='FPELCR'
               and  pa_producto='REC')
begin
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIA FIN PROCESAMIENTO ECTLCR', 'FPELCR', 'I', NULL, NULL, NULL, 28, NULL, NULL, NULL, 'REC')
end 
go




