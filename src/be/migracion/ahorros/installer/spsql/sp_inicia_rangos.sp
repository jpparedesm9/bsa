/************************************************************************/
/*      Archivo:                sp_inicia_rangos.sp                     */
/*      Stored procedure:       sp_inicia_rangos                        */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           RSA                                     */
/*      Fecha de escritura:     30-Agos-2016                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la migracion de apertura de cuenta        */
/*      de ahorros.                                                     */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA            AUTOR               RAZON                          */
/*  26/Ago/2016      Roxana Sánchez      Validacion Categorias          */
/************************************************************************/

use cob_externos
go

if exists (select * from sysobjects where name = 'sp_inicia_rangos')
   drop proc sp_inicia_rangos
go

create proc sp_inicia_rangos
(  
  @t_debug            char(1) = 'N'
)
as

declare @w_conteo int
delete from ah_rango_mig

select 'ah_cuenta ->',COUNT(*) from ah_cuenta_mig
select @w_conteo = COUNT(*) from ah_cuenta_mig
insert into ah_rango_mig (rm_tabla,        rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val, rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('ah_cuenta_mig',   'PASIVAS',       0,           0,                 0, 
				          0,               null,           null,           0,                 @w_conteo)

select 'ah_ctabloqueada ->',COUNT(*) from ah_ctabloqueada_mig
select @w_conteo = COUNT(*) from ah_ctabloqueada_mig
insert into ah_rango_mig (rm_tabla,          rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,   rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('ah_ctabloqueada_mig', 'PASIVAS',          0,              0,                 0, 
				          0,                 null,           null,           0,                 @w_conteo)
						  
select 'ah_his_bloqueo ->',COUNT(*) from ah_his_bloqueo_mig
select @w_conteo = COUNT(*) from ah_his_bloqueo_mig
insert into ah_rango_mig (rm_tabla,           rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,    rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('ah_his_bloqueo_mig', 'PASIVAS',          0,              0,                 0, 
				          0,                  null,           null,           0,                 @w_conteo)
						  
select 'ah_ciudad_deposito ->',COUNT(*) from ah_ciudad_deposito_mig
select @w_conteo = COUNT(*) from ah_ciudad_deposito_mig
insert into ah_rango_mig (rm_tabla,           rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,    rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('ah_ciudad_deposito_mig',  'PASIVAS',          0,              0,                 0, 
				          0,                  null,           null,           0,                 @w_conteo)
						  
select 'ah_his_inmovilizadas ->',COUNT(*) from ah_his_inmovilizadas_mig
select @w_conteo = COUNT(*) from ah_his_inmovilizadas_mig
insert into ah_rango_mig (rm_tabla,           rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,    rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('ah_his_inmovilizadas_mig',     'PASIVAS',          0,              0,                 0, 
				          0,                  null,           null,           0,                 @w_conteo)
						  
select 'ah_tran_monet ->',COUNT(*) from ah_tran_monet_mig
select @w_conteo = COUNT(*) from ah_tran_monet_mig
insert into ah_rango_mig (rm_tabla,               rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,        rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('ah_tran_monet_mig', 'PASIVAS',          0,              0,                 0, 
				          0,                      null,           null,           0,                 @w_conteo)
						  
select 'ah_his_movimiento ->',COUNT(*) from ah_his_movimiento_mig
select @w_conteo = COUNT(*) from ah_his_movimiento_mig
insert into ah_rango_mig (rm_tabla,              rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,       rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('ah_his_movimiento_mig', 'PASIVAS',          0,              0,                 0, 
				          0,                     null,           null,           0,                 @w_conteo)
						  
select 'ah_val_suspenso ->',COUNT(*) from ah_val_suspenso_mig
select @w_conteo = COUNT(*) from ah_val_suspenso_mig
insert into ah_rango_mig (rm_tabla,              rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,       rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('ah_val_suspenso_mig',   'PASIVAS',          0,              0,                 0, 
				          0,                     null,           null,           0,                 @w_conteo)
						  
select 'ah_linea_pendiente ->',COUNT(*) from ah_linea_pendiente_mig
select @w_conteo = COUNT(*) from ah_linea_pendiente_mig
insert into ah_rango_mig (rm_tabla,              rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,       rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('ah_linea_pendiente_mig', 'PASIVAS',          0,              0,                 0, 
				          0,                     null,           null,           0,                 @w_conteo)

select 're_accion_nd ->',COUNT(*) from re_accion_nd_mig
select @w_conteo = COUNT(*) from re_accion_nd_mig
insert into ah_rango_mig (rm_tabla,              rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,       rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('re_accion_nd_mig',      'PASIVAS',          0,              0,                 0, 
				          0,                     null,           null,           0,                 @w_conteo)
						  
select 're_cuenta_contractual ->',COUNT(*) from re_cuenta_contractual_mig
select @w_conteo = COUNT(*) from re_cuenta_contractual_mig
insert into ah_rango_mig (rm_tabla,              rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,       rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('re_cuenta_contractual_mig',      'PASIVAS',          0,              0,                 0, 
				          0,                     null,           null,           0,                 @w_conteo)
                              
select 're_detalle_cheque ->',COUNT(*) from re_detalle_cheque_mig
select @w_conteo = COUNT(*) from re_detalle_cheque_mig
insert into ah_rango_mig (rm_tabla,              rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,       rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('re_detalle_cheque_mig',      'PASIVAS',          0,              0,                 0, 
				          0,                     null,           null,           0,                 @w_conteo)
                          
go

set nocount off
go