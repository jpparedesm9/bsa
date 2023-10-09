/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Vistas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  07/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_interfase
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

print '********************************'
print '*****  CREACION DE VISTAS ******'
print '********************************'
print ''
print 'Inicio Ejecucion Creacion de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Vista: iaho_ah_cuenta'
if exists (select 1 from sysobjects where name = 'iaho_ah_cuenta' and type = 'V')
   drop view iaho_ah_cuenta
go

create view iaho_ah_cuenta as
select
ah_cuenta            = ah_cuenta,
ah_cta_banco         = ah_cta_banco,
ah_estado            = ah_estado,
ah_moneda            = ah_moneda,
ah_cliente           = ah_cliente 
from  cob_ahorros..ah_cuenta
go

print '-->Vista: icte_cc_ctacte'
if exists (select 1 from sysobjects where name = 'icte_cc_ctacte' and type = 'V')
   drop view icte_cc_ctacte
go

create view icte_cc_ctacte as
select
cc_ctacte            = in_int_01,
cc_cta_banco         = in_char16_01,
cc_estado            = in_char1_01,
cc_moneda            = in_tinyint_01,
cc_cliente           = in_int_02
from cob_interfase..in_interfases
go

print '-->Vista: iaho_ah_ctabloqueada'
if exists (select 1 from sysobjects where name = 'iaho_ah_ctabloqueada' and type = 'V')
   drop view iaho_ah_ctabloqueada
go

create view iaho_ah_ctabloqueada as
select
cb_cuenta		     = cb_cuenta,
cb_secuencial	     = cb_secuencial, 
cb_tipo_bloqueo	     = cb_tipo_bloqueo,
cb_fecha		     = cb_fecha,
cb_hora			     = cb_hora, 
cb_autorizante	     = cb_autorizante,
cb_solicitante	     = cb_solicitante,
cb_oficina    	     = cb_oficina,    
cb_estado     	     = cb_estado,     
cb_causa		     = cb_causa,
cb_sec_asoc		     = cb_sec_asoc,   
cb_observacion       = cb_observacion
from cob_ahorros..ah_ctabloqueada
go

print '-->Vista: icar_ca_operacion'
if exists (select 1 from sysobjects where name = 'icar_ca_operacion' and type = 'V')
   drop view icar_ca_operacion
go

create view icar_ca_operacion as
select
op_banco  	          = in_cuenta_01,
op_operacion          = in_int_01,
op_estado	          = in_tinyint_01,
op_cliente            = in_int_02,
op_toperacion         = in_catalogo_01,
op_moneda             = in_tinyint_02
from cob_interfase..in_interfases
go

print '-->Vista: icex_ce_banco'
if exists (select 1 from sysobjects where name = 'icex_ce_banco' and type = 'V')
   drop view icex_ce_banco
go

create view icex_ce_banco as
select
bc_banco             = in_smallint_01,
bc_descripcion       = in_descripcion_01,
bc_convenio 	     = in_char1_01,
bc_sec_oficina       = in_smallint_02,
bc_estado  	         = in_estado_01,
bc_banco_ente        = in_int_01
from cob_interfase..in_interfases
go

print '-->Vista: icex_ce_oficina'
if exists (select 1 from sysobjects where name = 'icex_ce_oficina' and type = 'V')
   drop view icex_ce_oficina
go

create view icex_ce_oficina as
select
of_continente        = in_varchar3_01,
of_pais              = in_smallint_01,
of_ciudad            = in_int_01,
of_banco             = in_smallint_02,
of_oficina           = in_smallint_03,
of_nombre            = in_descripcion_01,
of_dir_swift         = in_varchar12_01
from cob_interfase..in_interfases
go 

print '-->Vista: icex_ce_operacion'
if exists (select 1 from sysobjects where name = 'icex_ce_operacion' and type = 'V')
   drop view icex_ce_operacion
go

create view icex_ce_operacion as 
select
op_operacion_banco   = in_cuenta_01,
op_etapa             = in_varchar3_01
from cob_interfase..in_interfases
go

print '-->Vista: icex_ce_relacion_sba_cex'
if exists (select 1 from sysobjects where name = 'icex_ce_relacion_sba_cex' and type = 'V')
   drop view icex_ce_relacion_sba_cex
go

create view icex_ce_relacion_sba_cex as
select
rv_operacion_cex     = in_int_01,
rv_banco_cex  	     = in_cuenta_01,
rv_operacion_sba     = in_int_02,
rv_secuencial_sba    = in_int_03,
rv_monto 		     = in_money_01,
rv_moneda		     = in_tinyint_01,
rv_fecha		     = in_datetime_01,
rv_estado		     = in_char1_01,
rv_modulo		     = in_tinyint_02
from cob_interfase..in_interfases
go

print '-->Vista: irem_re_banco_org_ach'
if exists (select 1 from sysobjects where name = 'irem_re_banco_org_ach' and type = 'V')
   drop view irem_re_banco_org_ach
go

create view irem_re_banco_org_ach as
select
br_desc              = in_descripcion_01,
br_banco             = in_smallint_01,
br_filial            = in_tinyint_01
from cob_interfase..in_interfases
go

print '-->Vista: icte_cc_ctabloqueada'
if exists (select 1 from sysobjects where name = 'icte_cc_ctabloqueada' and type = 'V')
   drop view icte_cc_ctabloqueada
go

create view icte_cc_ctabloqueada as
select 
cb_cuenta            = in_int_01,
cb_secuencial        = in_int_02,
cb_tipo_bloqueo      = in_varchar3_01,
cb_fecha             = in_smalldatetime_01,
cb_hora              = in_smalldatetime_02,
cb_autorizante       = in_login_01,
cb_solicitante       = in_descripcion_01,
cb_oficina           = in_smallint_01,
cb_estado            = in_estado_01,
cb_causa             = in_varchar3_02,
cb_sec_asoc          = in_int_03,    	
cb_observacion       = in_varchar120_01
from cob_interfase..in_interfases
go  

print ''
print 'Fin Ejecucion Creacion de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''