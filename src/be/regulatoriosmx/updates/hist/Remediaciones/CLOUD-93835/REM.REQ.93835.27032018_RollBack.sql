/*************************************************************************************/
--No Historia                : 93835
--Titulo de la Historia      : Interfaz Cobis - Riesgos parte 2
--Fecha                      : 27/03/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : Modificacion estructuras cob_externos (RollBack)
--                             cob_externos..ex_dato_cuota_pry
--Autor                      : Jorge Salazar Andrade
--Instalador                 : cobex_table.sql
--Ruta Instalador            : $/ASP/CLOUD/Main/CLOUD/Activas/Dependencias/sql
/*************************************************************************************/
use cob_externos
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_valor_cat')
begin
	ALTER TABLE ex_dato_operacion DROP COLUMN do_valor_cat
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_orig')
begin
	ALTER TABLE ex_dato_operacion DROP COLUMN do_gar_liq_orig
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_fpago')
begin
	ALTER TABLE ex_dato_operacion DROP COLUMN do_gar_liq_fpago
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_dev') 
begin
	ALTER TABLE ex_dato_operacion DROP COLUMN do_gar_liq_dev
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_fdev') 
begin
	ALTER TABLE ex_dato_operacion DROP COLUMN do_gar_liq_fdev
end
go
---------------------
---------------------
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion_rubro'
          and   obj.id = col.id
          and   col.name = 'dr_cuota')
begin
	ALTER TABLE ex_dato_operacion_rubro DROP COLUMN dr_cuota
end
go


if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion_rubro'
          and   obj.id = col.id
          and   col.name = 'dr_acumulado')
begin
	ALTER TABLE ex_dato_operacion_rubro DROP COLUMN dr_acumulado
end
go


if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_operacion_rubro'
          and   obj.id = col.id
          and   col.name = 'dr_pagado')
begin
	ALTER TABLE ex_dato_operacion_rubro DROP COLUMN dr_pagado
end
go


---------------------------------------------------------------------------------
----------------------------EX_DATO_CUOTA_PRY------------------------------------
---------------------------------------------------------------------------------

-------------------FECHA DE ULTIMO PAGO CUOTA-------------------
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_cap_cuota')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_cap_cuota 
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_int_cuota')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_int_cuota   
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_imo_cuota')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_imo_cuota   
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_pre_cuota')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_pre_cuota  
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_int_cuota')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_iva_int_cuota 
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_imo_cuota')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_iva_imo_cuota 
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_pre_cuota')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_iva_pre_cuota 
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_otros_cuota')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_otros_cuota   
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_int_acum')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_int_acum     
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_int_acum')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_iva_int_acum      
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_cap_pag')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_cap_pag      
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_int_pag')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_int_pag      
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_imo_pag')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_imo_pag     
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_pre_pag')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_pre_pag     
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_int_pag')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_iva_int_pag  
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_imo_pag')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_iva_imo_pag   
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_pre_pag')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_iva_pre_pag  
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_otros_pag')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_otros_pag    
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_fecha_can')
begin
	alter table ex_dato_cuota_pry DROP COLUMN dc_fecha_can     
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'ex_dato_cuota_pry'
          and   obj.id   = col.id
          and   col.name = 'dc_fecha_upago')
begin
   alter table ex_dato_cuota_pry drop column dc_fecha_upago
end
go

/*************************************************************************************/
--No Historia                : 93835
--Titulo de la Historia      : Interfaz Cobis - Riesgos parte 2
--Fecha                      : 27/03/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : Modificacion estructuras cob_conta_super (RollBack)
--                             Creacion de estructura cob_conta_super..sb_riesgo_provision (RollBack)
--                             cob_conta_super..sb_dato_cuota_pry
--Autor                      : Jorge Salazar Andrade
--Instalador                 : cbsup_table.sql
--Ruta Instalador            : $/ASP/CLOUD/Main/CLOUD/Activas/Dependencias/sql
/*************************************************************************************/
use cob_conta_super
go
--//////////////////////////////////////////////
USE cob_conta_super
GO
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_tmp'
          and   obj.id = col.id
          and   col.name = 'do_valor_cat')
begin
	ALTER TABLE sb_dato_operacion_tmp DROP COLUMN do_valor_cat
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_tmp'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_orig')
begin
	ALTER TABLE sb_dato_operacion_tmp DROP COLUMN do_gar_liq_orig
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_tmp'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_fpago')
begin
	ALTER TABLE sb_dato_operacion_tmp DROP COLUMN do_gar_liq_fpago
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_tmp'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_dev') 
begin
	ALTER TABLE sb_dato_operacion_tmp DROP COLUMN do_gar_liq_dev
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_tmp'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_fdev') 
begin
	ALTER TABLE sb_dato_operacion_tmp DROP COLUMN do_gar_liq_fdev
end
go
---------------------
---------------------
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_rubro'
          and   obj.id = col.id
          and   col.name = 'dr_cuota')
begin
	ALTER TABLE sb_dato_operacion_rubro DROP COLUMN dr_cuota
end
go


if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_rubro'
          and   obj.id = col.id
          and   col.name = 'dr_acumulado')
begin
	ALTER TABLE sb_dato_operacion_rubro DROP COLUMN dr_acumulado
end
go


if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion_rubro'
          and   obj.id = col.id
          and   col.name = 'dr_pagado')
begin
	ALTER TABLE sb_dato_operacion_rubro DROP COLUMN dr_pagado
end
go

-------------------------

---------------------
---------------------

--//////////////////////////////////////////////
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_valor_cat')
begin
	ALTER TABLE sb_dato_operacion DROP COLUMN do_valor_cat
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_orig')
begin
	ALTER TABLE sb_dato_operacion DROP COLUMN do_gar_liq_orig
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_fpago')
begin
	ALTER TABLE sb_dato_operacion DROP COLUMN do_gar_liq_fpago
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_dev') 
begin
	ALTER TABLE sb_dato_operacion DROP COLUMN do_gar_liq_dev
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_operacion'
          and   obj.id = col.id
          and   col.name = 'do_gar_liq_fdev') 
begin
	ALTER TABLE sb_dato_operacion DROP COLUMN do_gar_liq_fdev
end
---------------------------------------------------------------------------------
----------------------------SB_DATO_CUOTA_PRY------------------------------------
---------------------------------------------------------------------------------
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_cap_cuota')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_cap_cuota    
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_int_cuota')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_int_cuota    
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_imo_cuota')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_imo_cuota     
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_pre_cuota')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_pre_cuota     
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_int_cuota')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_iva_int_cuota 
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_imo_cuota')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_iva_imo_cuota 
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_pre_cuota')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_iva_pre_cuota 
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_otros_cuota')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_otros_cuota   
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_int_acum')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_int_acum      
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_int_acum')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_iva_int_acum      
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_cap_pag')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_cap_pag      
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_int_pag')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_int_pag       
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_imo_pag')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_imo_pag      
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_pre_pag')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_pre_pag       
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_int_pag')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_iva_int_pag   
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_imo_pag')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_iva_imo_pag   
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_iva_pre_pag')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_iva_pre_pag   
end
go
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_otros_pag')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_otros_pag     
end
go

if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id = col.id
          and   col.name = 'dc_fecha_can')
begin
	alter table sb_dato_cuota_pry DROP COLUMN dc_fecha_can     
end
if exists(select 1
          from sysobjects obj, syscolumns col
          where obj.name = 'sb_dato_cuota_pry'
          and   obj.id   = col.id
          and   col.name = 'dc_fecha_upago')
begin
   alter table sb_dato_cuota_pry drop column dc_fecha_upago
end
go

---------------------------------------------------------------------------------
----------------------------SB_RIESGO_PROVISION------------------------------------
---------------------------------------------------------------------------------
if exists(select 1 from sysobjects where name = 'sb_riesgo_provision ')
   drop table sb_riesgo_provision
go

---------------------------------------------------------------------------------
----------------------------SP_RIESGO_PROVISION------------------------------------
---------------------------------------------------------------------------------
if exists (select 1 from sysobjects where name = 'sp_riesgo_provision')
   drop proc sp_riesgo_provision
go

