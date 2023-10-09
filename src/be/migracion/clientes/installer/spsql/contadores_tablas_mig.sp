/***********************************************************************/
/*      Archivo:                        sp_princ_clientes.sp           */
/*      Stored procedure:               sp_princ_clientes              */
/*      Base de Datos:                  cobis                          */
/*      Producto:                       Clientes                       */
/*      Disenado por:                   Alejandro Fernandez            */
/*      Fecha de Documentacion:         22/Jul/2015                    */
/***********************************************************************/
/*                      IMPORTANTE                                     */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/***********************************************************************/
/*                      PROPOSITO                                      */
/* Registra todos los registros que van a ser procesados de cada tabla    */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/***********************************************************************/
----------------------------------------
-- VERIFICACION DE REGISTROS MIGRADOS --
----------------------------------------

use cob_externos
go

if exists(select * from sysobjects where name = 'contadores_tablas_mig')
   drop proc contadores_tablas_mig
go
create proc contadores_tablas_mig
as

declare @w_conteo int

--select 'cl_ente ->',COUNT(*) from cl_ente_mig
select @w_conteo = COUNT(1) from cl_ente_mig
insert into cl_rango_mig (rm_tabla,        rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val, rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('cl_ente_mig',   'MIS',          0,              0,                 0, 
                          0,               null,           null,           0,                 @w_conteo)

                          
--select 'cl_direccion ->',COUNT(*) from cl_direccion_mig
select @w_conteo = COUNT(1) from cl_direccion_mig
insert into cl_rango_mig (rm_tabla,           rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,    rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('cl_direccion_mig', 'MIS',          0,              0,                 0, 
                          0,                  null,           null,           0,                 @w_conteo)
                          
--select 'cl_telefono ->',COUNT(*) from cl_telefono_mig
select @w_conteo = COUNT(1) from cl_telefono_mig
insert into cl_rango_mig (rm_tabla,           rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,    rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('cl_telefono_mig',  'MIS',          0,              0,                 0, 
                          0,                  null,           null,           0,                 @w_conteo)
                          
--select 'cl_ref_personal ->',COUNT(*) from cl_ref_personal_mig
select @w_conteo = COUNT(1) from cl_ref_personal_mig
insert into cl_rango_mig (rm_tabla,              rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,       rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('cl_ref_personal_mig', 'MIS',          0,              0,                 0, 
                          0,                     null,           null,           0,                 @w_conteo)
                          
--select 'cl_trabajo ->',COUNT(*) from cl_trabajo_mig
select @w_conteo = COUNT(1) from cl_trabajo_mig
insert into cl_rango_mig (rm_tabla,              rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,       rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('cl_trabajo_mig',      'MIS',          0,              0,                 0, 
                          0,                     null,           null,           0,                 @w_conteo)

--select 'cl_trabajo ->',COUNT(*) from cl_refinh_mig
select @w_conteo = COUNT(1) from cl_refinh_mig
insert into cl_rango_mig (rm_tabla,              rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,       rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('cl_refinh_mig',      'MIS',          0,              0,                 0, 
                          0,                     null,           null,           0,                 @w_conteo)

--select 'cl_instancia_mig ->',COUNT(*) from cl_refinh_mig
select @w_conteo = COUNT(1) from cl_instancia_mig
insert into cl_rango_mig (rm_tabla,              rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,       rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('cl_instancia_mig',    'MIS',          0,              0,                 0, 
                          0,                     null,           null,           0,                 @w_conteo)

--select 'Definitivas ->',COUNT(*) from cl_ente_mig
select @w_conteo = COUNT(*) from cl_ente_mig
insert into cl_rango_mig (rm_tabla,               rm_modulo,      rm_ciclos,      rm_valor_rango,    rm_valor_regis, 
                          rm_cant_reg_val,        rm_fec_ini_val, rm_fec_fin_val, rm_cant_reg_cobis, rm_total)
                  values ('Definitivas',         'MIS',          0,              0,                 0, 
                          0,                      null,           null,           0,                 @w_conteo)

return 0
go

