-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Creacion de parametros
use cobis
go

select * from cobis..cl_parametro
WHERE pa_producto = 'CCA' AND pa_nemonico = 'DAVCOU'

DELETE cobis..cl_parametro
WHERE pa_producto = 'CCA' AND pa_nemonico = 'DAVCOU'

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS ANTES PARA VENCIMIENTO DE CUOTAS', 'DAVCOU', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'CCA')
GO

select * from cobis..cl_parametro
WHERE pa_producto = 'CCA' AND pa_nemonico = 'DAVCOU'
GO

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Caso188497 tablas para proximo vencimiento de coutas
use cob_cartera
go

IF OBJECT_ID ('dbo.ca_prox_vencimiento_cuotas_det') IS NOT NULL
	DROP TABLE dbo.ca_prox_vencimiento_cuotas_det
GO

IF OBJECT_ID ('dbo.ca_prox_vencimiento_cuotas') IS NOT NULL
	DROP TABLE dbo.ca_prox_vencimiento_cuotas
GO

create table ca_prox_vencimiento_cuotas
    (
    vc_operacion     INT NOT NULL,
	vc_cliente       INT NOT NULL,
	vc_fecha_proceso DATETIME NOT NULL,
	vc_cliente_name  VARCHAR (100) NOT NULL,
	vc_op_fecha_liq  DATETIME NOT NULL,
	vc_op_moneda     TINYINT NOT NULL,
	vc_op_oficina    SMALLINT NOT NULL,
	vc_di_fecha_vig  DATETIME NOT NULL,
	vc_di_dividendo  INT NOT NULL,
	vc_di_monto      MONEY NOT NULL,
	vc_email         VARCHAR (255) NULL,
	CONSTRAINT PK_ca_prox_vencimiento_cuotas PRIMARY KEY(vc_operacion,vc_cliente) 
    )
go

CREATE TABLE dbo.ca_prox_vencimiento_cuotas_det(
   vcd_operacion             int not null,
   vcd_cliente               int not null,
   vcd_corresponsal          varchar(10) not null,
   vcd_institucion           varchar(20) not null,
   vcd_referencia            varchar(40) not null,
   vcd_convenio              varchar(30) null,
   FOREIGN KEY (vcd_operacion, vcd_cliente) REFERENCES ca_prox_vencimiento_cuotas(vc_operacion, vc_cliente),
   CONSTRAINT pk_ca_prox_vencimiento_cuotas_det PRIMARY KEY (vcd_referencia, vcd_corresponsal)
   )
GO

select * from ca_prox_vencimiento_cuotas_det
select * from ca_prox_vencimiento_cuotas

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--REGISTRO DE REPORTE PARA NOTIFICADOR
use cobis
go

declare @w_tabla_cod int

select @w_tabla_cod = codigo from cl_tabla where tabla = 'ca_param_notif'

SELECT * FROM cl_catalogo WHERE tabla = @w_tabla_cod AND codigo IN ('PPCVE_NJAS', 'PPCVE_NPDF', 'PPCVE_NXML')

DELETE cl_catalogo WHERE tabla = @w_tabla_cod AND codigo IN ('PPCVE_NJAS', 'PPCVE_NPDF', 'PPCVE_NXML')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla_cod, 'PPCVE_NJAS', 'ReferenciaDePago.jasper', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla_cod, 'PPCVE_NPDF', 'ReferenciaDePago_', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla_cod, 'PPCVE_NXML', 'referenciadepago.xml', 'V', NULL, NULL, NULL)

SELECT * FROM cl_catalogo WHERE tabla = @w_tabla_cod AND codigo IN ('PPCVE_NJAS', 'PPCVE_NPDF', 'PPCVE_NXML')
go

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--