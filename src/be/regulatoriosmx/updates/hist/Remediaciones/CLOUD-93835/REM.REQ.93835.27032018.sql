/*************************************************************************************/
--No Historia                : 93835
--Titulo de la Historia      : Interfaz Cobis - Riesgos parte 2
--Fecha                      : 27/03/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : Modificacion estructuras cob_externos
--                             cob_externos..ex_dato_cuota_pry
--Autor                      : Jorge Salazar Andrade
--Instalador                 : cobex_table.sql
--Ruta Instalador            : $/ASP/CLOUD/Main/CLOUD/Activas/Dependencias/sql
/*************************************************************************************/
use cob_externos
go
---------------------------------------------------------------------------------
----------------------------EX_DATO_CUOTA_PRY------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
----------------------------EX_DATO_OPERACION------------------------------------
---------------------------------------------------------------------------------
USE cob_externos
GO
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_valor_cat')
begin
	ALTER TABLE ex_dato_operacion ADD do_valor_cat            FLOAT NULL
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_orig')
begin
	ALTER TABLE ex_dato_operacion ADD do_gar_liq_orig    MONEY NULL
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_fpago')
begin
	ALTER TABLE ex_dato_operacion ADD do_gar_liq_fpago  DATETIME NULL
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_dev') 
begin
	ALTER TABLE ex_dato_operacion ADD do_gar_liq_dev    MONEY NULL
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_fdev') 
begin
	ALTER TABLE ex_dato_operacion ADD do_gar_liq_fdev  DATETIME NULL
end
go

---------------------------------------------------------------------------------
----------------------------EX_DATO_OPERACION_RUBRO------------------------------
---------------------------------------------------------------------------------
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion_rubro'
          and   obj.id = col.id
          and   col.name = 'dr_cuota')
begin
	ALTER TABLE ex_dato_operacion_rubro ADD dr_cuota  MONEY NULL
end
go


if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion_rubro'
          and   obj.id = col.id
          and   col.name = 'dr_acumulado')
begin
	ALTER TABLE ex_dato_operacion_rubro ADD dr_acumulado  MONEY NULL
end
go


if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion_rubro'
          and   obj.id = col.id
          and   col.name = 'dr_pagado')
begin
	ALTER TABLE ex_dato_operacion_rubro ADD dr_pagado  MONEY NULL
end
go

-------------------FECHA DE ULTIMO PAGO CUOTA-------------------
---------------------------------------------------------------------------------
----------------------------EX_DATO_CUOTA_PRY------------------------------------
---------------------------------------------------------------------------------

-------------------CAMPOS  CUOTA-------------------
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_cap_cuota')
begin
	alter table ex_dato_cuota_pry add dc_cap_cuota     money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_int_cuota')
begin
	alter table ex_dato_cuota_pry add dc_int_cuota     money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_imo_cuota')
begin
	alter table ex_dato_cuota_pry add dc_imo_cuota     money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_pre_cuota')
begin
	alter table ex_dato_cuota_pry add dc_pre_cuota     money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_int_cuota')
begin
	alter table ex_dato_cuota_pry add dc_iva_int_cuota money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_imo_cuota')
begin
	alter table ex_dato_cuota_pry add dc_iva_imo_cuota money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_pre_cuota')
begin
	alter table ex_dato_cuota_pry add dc_iva_pre_cuota money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_otros_cuota')
begin
	alter table ex_dato_cuota_pry add dc_otros_cuota   money null
end
go
-------------------CAMPOS  ACUMULADO-------------------
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_int_acum')
begin
	alter table ex_dato_cuota_pry add dc_int_acum      money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_int_acum')
begin
	alter table ex_dato_cuota_pry add dc_iva_int_acum      money null
end
go
-------------------CAMPOS  PAGADO-------------------
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_cap_pag')
begin
	alter table ex_dato_cuota_pry add dc_cap_pag       money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_int_pag')
begin
	alter table ex_dato_cuota_pry add dc_int_pag       money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_imo_pag')
begin
	alter table ex_dato_cuota_pry add dc_imo_pag       money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_pre_pag')
begin
	alter table ex_dato_cuota_pry add dc_pre_pag       money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_int_pag')
begin
	alter table ex_dato_cuota_pry add dc_iva_int_pag   money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_imo_pag')
begin
	alter table ex_dato_cuota_pry add dc_iva_imo_pag   money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_pre_pag')
begin
	alter table ex_dato_cuota_pry add dc_iva_pre_pag   money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_otros_pag')
begin
	alter table ex_dato_cuota_pry add dc_otros_pag     money NULL
end
go
-------------------FECHA DE CANCELACION DE LA CUOTA-------------------
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_fecha_can')
begin
	alter table ex_dato_cuota_pry add dc_fecha_can     SMALLDATETIME NULL
end
go
if not exists(select 1
              from sysobjects obj, syscolumns col
              where obj.name = 'ex_dato_cuota_pry'
              and   obj.id   = col.id
              and   col.name = 'dc_fecha_upago')
begin
   alter table ex_dato_cuota_pry add dc_fecha_upago smalldatetime null
end
go

/*************************************************************************************/
--No Historia                : 93835
--Titulo de la Historia      : Interfaz Cobis - Riesgos parte 2
--Fecha                      : 27/03/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : Modificacion estructuras cob_conta_super
--                             cob_conta_super..sb_dato_cuota_pry
--                             Creacion de estructura cob_conta_super..sb_riesgo_provision
--Autor                      : Jorge Salazar Andrade
--Instalador                 : cbsup_table.sql
--Ruta Instalador            : $/ASP/CLOUD/Main/CLOUD/RegulatoriosMX/BackEnd/sql
/*************************************************************************************/
use cob_conta_super
go
---------------------------------------------------------------------------------
----------------------------SB_DATO_CUOTA_PRY------------------------------------
---------------------------------------------------------------------------------
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_tmp'
          and   obj.id = col.id
          and   col.name = 'do_valor_cat')
begin
	ALTER TABLE sb_dato_operacion_tmp ADD do_valor_cat            FLOAT NULL
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_tmp'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_orig')
begin
	ALTER TABLE sb_dato_operacion_tmp ADD do_gar_liq_orig    MONEY NULL
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_tmp'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_fpago')
begin
	ALTER TABLE sb_dato_operacion_tmp ADD do_gar_liq_fpago  DATETIME NULL
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_tmp'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_dev') 
begin
	ALTER TABLE sb_dato_operacion_tmp ADD do_gar_liq_dev    MONEY NULL
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_tmp'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_fdev') 
begin
	ALTER TABLE sb_dato_operacion_tmp ADD do_gar_liq_fdev  DATETIME NULL
end
go

---------------------
---------------------
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_rubro'
          and   obj.id = col.id
          and   col.name = 'dr_cuota')
begin
	ALTER TABLE sb_dato_operacion_rubro ADD dr_cuota  MONEY NULL
end
go


if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_rubro'
          and   obj.id = col.id
          and   col.name = 'dr_acumulado')
begin
	ALTER TABLE sb_dato_operacion_rubro ADD dr_acumulado  MONEY NULL
end
go


if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_rubro'
          and   obj.id = col.id
          and   col.name = 'dr_pagado')
begin
	ALTER TABLE sb_dato_operacion_rubro ADD dr_pagado  MONEY NULL
end
go

-------------------------

---------------------
---------------------

--//////////////////////////////////////////////
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_valor_cat')
begin
	ALTER TABLE sb_dato_operacion ADD do_valor_cat            FLOAT NULL
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_orig')
begin
	ALTER TABLE sb_dato_operacion ADD do_gar_liq_orig    MONEY NULL
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_fpago')
begin
	ALTER TABLE sb_dato_operacion ADD do_gar_liq_fpago  DATETIME NULL
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_dev') 
begin
	ALTER TABLE sb_dato_operacion ADD do_gar_liq_dev    MONEY NULL
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_fdev') 
begin
	ALTER TABLE sb_dato_operacion ADD do_gar_liq_fdev  DATETIME NULL
end
go

if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_cap_cuota')
begin
	alter table sb_dato_cuota_pry add dc_cap_cuota     money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_int_cuota')
begin
	alter table sb_dato_cuota_pry add dc_int_cuota     money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_imo_cuota')
begin
	alter table sb_dato_cuota_pry add dc_imo_cuota     money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_pre_cuota')
begin
	alter table sb_dato_cuota_pry add dc_pre_cuota     money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_int_cuota')
begin
	alter table sb_dato_cuota_pry add dc_iva_int_cuota money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_imo_cuota')
begin
	alter table sb_dato_cuota_pry add dc_iva_imo_cuota money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_pre_cuota')
begin
	alter table sb_dato_cuota_pry add dc_iva_pre_cuota money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_otros_cuota')
begin
	alter table sb_dato_cuota_pry add dc_otros_cuota   money null
end
go
-------------------CAMPOS  ACUMULADO-------------------
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_int_acum')
begin
	alter table sb_dato_cuota_pry add dc_int_acum      money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_int_acum')
begin
	alter table sb_dato_cuota_pry add dc_iva_int_acum      money null
end
go
-------------------CAMPOS  PAGADO-------------------
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_cap_pag')
begin
	alter table sb_dato_cuota_pry add dc_cap_pag       money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_int_pag')
begin
	alter table sb_dato_cuota_pry add dc_int_pag       money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_imo_pag')
begin
	alter table sb_dato_cuota_pry add dc_imo_pag       money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_pre_pag')
begin
	alter table sb_dato_cuota_pry add dc_pre_pag       money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_int_pag')
begin
	alter table sb_dato_cuota_pry add dc_iva_int_pag   money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_imo_pag')
begin
	alter table sb_dato_cuota_pry add dc_iva_imo_pag   money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_pre_pag')
begin
	alter table sb_dato_cuota_pry add dc_iva_pre_pag   money null
end
go
if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_otros_pag')
begin
	alter table sb_dato_cuota_pry add dc_otros_pag     money NULL
end
go

if not exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_fecha_can')
begin
	alter table sb_dato_cuota_pry add dc_fecha_can     SMALLDATETIME NULL
end
go
if not exists(select 1
              from sysobjects obj, syscolumns col
              where obj.name = 'sb_dato_cuota_pry'
              and   obj.id   = col.id
              and   col.name = 'dc_fecha_upago')
begin
   alter table sb_dato_cuota_pry add dc_fecha_upago smalldatetime null
end
go

---------------------------------------------------------------------------------
----------------------------SB_RIESGO_PROVISION----------------------------------
---------------------------------------------------------------------------------
if exists(select 1 from sysobjects where name = 'sb_riesgo_provision ')
   drop table sb_riesgo_provision
go
create table sb_riesgo_provision(
Num_cred                varchar(24) null,
Num_cliente             varchar(20) null,
Num_grupo               varchar(4)  null,
Cod_producto            varchar(2)  null,
Cod_subproducto         varchar(4)  null,
Cod_periodo_capital     varchar(1)  null,
Cod_periodo_intereses   varchar(1)  null,
Exig_T1                 varchar(20) null,
Pago_T1                 varchar(20) null,
Fec_Exig_T1             varchar(20) null,
Fec_Pago_T1             varchar(20) null,
Exig_T2                 varchar(20) null,
Pago_T2                 varchar(20) null,
Fec_Exig_T2             varchar(20) null,
Fec_Pago_T2             varchar(20) null,
Exig_T3                 varchar(20) null,
Pago_T3                 varchar(20) null,
Fec_Exig_T3             varchar(20) null,
Fec_Pago_T3             varchar(20) null,
Exig_T4                 varchar(20) null,
Pago_T4                 varchar(20) null,
Fec_Exig_T4             varchar(20) null,
Fec_Pago_T4             varchar(20) null,
Exig_T5                 varchar(20) null,
Pago_T5                 varchar(20) null,
Fec_Exig_T5             varchar(20) null,
Fec_Pago_T5             varchar(20) null,
Exig_T6                 varchar(20) null,
Pago_T6                 varchar(20) null,
Fec_Exig_T6             varchar(20) null,
Fec_Pago_T6             varchar(20) null,
Exig_T7                 varchar(20) null,
Pago_T7                 varchar(20) null,
Fec_Exig_T7             varchar(20) null,
Fec_Pago_T7             varchar(20) null,
Exig_T8                 varchar(20) null,
Pago_T8                 varchar(20) null,
Fec_Exig_T8             varchar(20) null,
Fec_Pago_T8             varchar(20) null,
Exig_T9                 varchar(20) null,
Pago_T9                 varchar(20) null,
Fec_Exig_T9             varchar(20) null,
Fec_Pago_T9             varchar(20) null,
Exig_T10                varchar(20) null,
Pago_T10                varchar(20) null,
Fec_Exig_T10            varchar(20) null,
Fec_Pago_T10            varchar(20) null,
Exig_T11                varchar(20) null,
Pago_T11                varchar(20) null,
Fec_Exig_T11            varchar(20) null,
Fec_Pago_T11            varchar(20) null,
Exig_T12                varchar(20) null,
Pago_T12                varchar(20) null,
Fec_Exig_T12            varchar(20) null,
Fec_Pago_T12            varchar(20) null,
Exig_T13                varchar(20) null,
Pago_T13                varchar(20) null,
Fec_Exig_T13            varchar(20) null,
Fec_Pago_T13            varchar(20) null,
Exig_T14                varchar(20) null,
Pago_T14                varchar(20) null,
Fec_Exig_T14            varchar(20) null,
Fec_Pago_T14            varchar(20) null,
Exig_T15                varchar(20) null,
Pago_T15                varchar(20) null,
Fec_Exig_T15            varchar(20) null,
Fec_Pago_T15            varchar(20) null,
Exig_T16                varchar(20) null,
Pago_T16                varchar(20) null,
Fec_Exig_T16            varchar(20) null,
Fec_Pago_T16            varchar(20) null,
Imp_total_riesgo        varchar(20) null,
Integrantes             varchar(4)  null,
Ciclos                  varchar(4)  null
)
go

CREATE INDEX idx1 on sb_riesgo_provision(Num_cred)
CREATE INDEX idx2 on sb_riesgo_provision(Num_cliente)
GO

