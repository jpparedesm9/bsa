--//////////////////////
-- LGU: CREACION DE TABLAS PARA LOS ABONOS
--//////////////////////

USE cob_externos
GO
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'ex_dato_operacion_abono')
	DROP TABLE ex_dato_operacion_abono
GO
CREATE TABLE ex_dato_operacion_abono (
doa_secuencial   INT IDENTITY ,
doa_aplicativo   SMALLINT,
doa_fecha        DATETIME,
doa_banco        VARCHAR(32),
doa_operacion    INT,
doa_sec_pag      INT,
doa_fecha_pag    DATETIME,
doa_di_fecha_ven DATETIME,
doa_dividendo    SMALLINT,
doa_dias_atraso  INT,
doa_fpago        VARCHAR(32),
doa_total        MONEY,
doa_capital      MONEY,
doa_int          MONEY,
doa_otro         MONEY,
doa_saldo_cap    MONEY,
doa_sec_ing      INT,
doa_oficina      SMALLINT,
doa_estado       VARCHAR(10),
doa_usuario      VARCHAR(20),
doa_moneda       SMALLINT 
)

GO
CREATE CLUSTERED INDEX idx_1 ON ex_dato_operacion_abono (doa_operacion,doa_sec_pag)
GO
CREATE           INDEX idx_2 ON ex_dato_operacion_abono (doa_banco)
GO
CREATE           INDEX idx_3 ON ex_dato_operacion_abono (doa_aplicativo)
GO



USE cob_conta_super
GO
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'sb_dato_operacion_abono')
	DROP TABLE sb_dato_operacion_abono
GO
CREATE TABLE sb_dato_operacion_abono (
doa_secuencial   INT IDENTITY ,
doa_aplicativo   SMALLINT,
doa_fecha        DATETIME,
doa_banco        VARCHAR(32),
doa_operacion    INT,
doa_sec_pag      INT,
doa_fecha_pag    DATETIME,
doa_di_fecha_ven DATETIME,
doa_dividendo    SMALLINT,
doa_dias_atraso  INT,
doa_fpago        VARCHAR(32),
doa_total        MONEY,
doa_capital      MONEY,
doa_int          MONEY,
doa_otro         MONEY,
doa_saldo_cap    MONEY,
doa_sec_ing      INT,
doa_oficina      SMALLINT,
doa_estado       VARCHAR(10),
doa_usuario      VARCHAR(20),
doa_moneda       SMALLINT 
)

GO
CREATE CLUSTERED INDEX idx_1 ON sb_dato_operacion_abono (doa_operacion,doa_sec_pag)
GO
CREATE           INDEX idx_2 ON sb_dato_operacion_abono (doa_banco)
GO
CREATE           INDEX idx_3 ON sb_dato_operacion_abono (doa_aplicativo)
GO

--//////////////////////////////////////////////////////////////////////////////



use cob_conta_super
go


alter table sb_rpt_buro_frmt_act_parc
alter column rf_limit_cred varchar(20) null
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'do_monto_aprobado'
              and  c1.table_name = 'sb_dato_operacion_tmp')
begin 
    alter table sb_dato_operacion_tmp
    add  do_monto_aprobado money null
end
go


if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'do_monto_aprobado'
              and  c1.table_name = 'sb_dato_operacion')
begin
    alter table sb_dato_operacion
    add  do_monto_aprobado money null
end
go

update sb_dato_operacion
set do_monto_aprobado = op_monto_aprobado
from cob_cartera..ca_operacion
where do_fecha >= '03/01/2019'
and   op_banco = do_banco
go

alter table sb_reporte_buro_cuentas
alter column [23] varchar(20) null
go

use cob_externos
go


if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'do_monto_aprobado'
              and  c1.table_name = 'ex_dato_operacion')
begin
    alter table ex_dato_operacion
    add  do_monto_aprobado money null
end
go

use cob_conta_super
go
if exists(select 1 from sysobjects where name = 'sb_dato_operacion_abono_temp ')
    drop table sb_dato_operacion_abono_temp
go

CREATE TABLE sb_dato_operacion_abono_temp
(
  doa_sec             INT IDENTITY (0,1),
  doa_fecha_ope       DATETIME,
  doa_fecha_pac       DATETIME,
  doa_num_pago        INT,
  doa_dias_atra       INT,
  doa_detalle_mov     VARCHAR(100),
  doa_total           MONEY,
  doa_cap             MONEY,
  doa_inte_ord        MONEY,
  doa_gasto_cobranza  MONEY,
  doa_saldo_cap       MONEY,
  doa_banco           VARCHAR(32),
  doa_fecha           DATETIME 
 
)
go

