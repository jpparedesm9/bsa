/************************************************************************/
/*      Archivo:                rep_cta_progresivo.sp                   */
/*      Stored procedure:       sp_rep_cta_progresivo                   */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:                                                   */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                               IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por  escrito de COBISCorp.    */
/*  Este programa esta  protegido  por la ley de   derechos de autor    */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Reporte de Cuentas Progresivo                                   */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_rep_cta_progresivo')
   drop proc sp_rep_cta_progresivo
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_rep_cta_progresivo (
   @t_show_version  bit = 0
)
as
declare
    @w_sp_name   varchar(30),
    @w_fecha datetime,
    @w_fin_mes_ant datetime,
    @w_error int,
    @w_prodbanc int

/* Captura del nombre del stored procedure */
select @w_sp_name = 'sp_rep_cta_progresivo'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end


/* Fecha de Proceso */
select @w_fecha = fp_fecha
from cobis..ba_fecha_proceso

/*** Fecha para el mes anterior ****/
select  @w_fin_mes_ant = dateadd(dd,(1 - datepart(dd,@w_fecha)),@w_fecha)  --inicio del mes actual
select  @w_fin_mes_ant = dateadd(dd,-1,@w_fin_mes_ant )

/* CODIGO PRODUCTO AHORRO PROGRESIVO */
select @w_prodbanc = pa_int
from  cobis..cl_parametro
where pa_producto = 'AHO'
and   pa_nemonico = 'PAHPR'
if @@rowcount <> 1
begin
   exec cobis..sp_cerror
   @i_num       = 101032,
   @i_msg       = 'ERROR EN PARAMETRO PRODUCTO AHORRO PROGRESIVO'
   return 101032
end

/* Truncar tabla para reproceso */
truncate table cob_ahorros..ah_resumen_ctacontrac

/* UNIVERSO DE CUENTAS DE AHORRO CONTRACTUAL - REPORTE UNO */
insert into cob_ahorros..ah_resumen_ctacontrac
(rc_tipo_reporte, rc_regional, rc_zona, rc_oficina, rc_prod_banc,
 rc_categoria, rc_cliente, rc_nombre, rc_cuenta,
 rc_cta_banco, rc_saldo_mes_ant, rc_debitos, rc_creditos,
 rc_mvto_mes, rc_saldo_mes, rc_num_cuota, rc_vlr_cuota,
 rc_saldo_esp, rc_diferencia)
select
 1, of_regional, of_zona, of_oficina, ah_prod_banc,
 ah_categoria, ah_cliente, ah_nombre, ah_cuenta,
 ah_cta_banco, 0, ah_debitos, ah_creditos,
 isnull(ah_creditos - ah_debitos,0), 0, datediff(mm, cc_fecha_crea, @w_fecha) +1, cc_cuota,
 (datediff(mm, cc_fecha_crea, @w_fecha) +1) * cc_cuota, 0
from cob_ahorros..ah_cuenta,
     cob_remesas..re_cuenta_contractual,
     cobis..cl_oficina
where ah_cta_banco = cc_cta_banco
and   ah_prod_banc = @w_prodbanc
and   ah_estado    = 'A'
and   ah_oficina   = of_oficina
if @@error <> 0
begin
   --print 'ERROR EN UNIVERSO DE CUENTAS DE AHORRO CONTRACTUAL - REPORTE UNO'
   exec cobis..sp_cerror
   @i_num       = 150000,
   @i_msg       = 'ERROR EN UNIVERSO DE CUENTAS DE AHORRO CONTRACTUAL - REPORTE UNO'
   return 150000
end

/*** BUSCAR SALDO MES ANTERIOR ***/

/* Fecha Mes Ant con Informacion */
select top 1
@w_fin_mes_ant = sd_fecha
from cob_ahorros_his..ah_saldo_diario,
     cob_ahorros..ah_resumen_ctacontrac
where sd_cuenta = rc_cuenta
and   sd_fecha <= @w_fin_mes_ant
order by sd_fecha desc

/* ACTUALIZAR SALDO DISPONIBLE MES ANTERIOR */
update cob_ahorros..ah_resumen_ctacontrac set
rc_saldo_mes_ant = sd_saldo_disponible
from cob_ahorros_his..ah_saldo_diario,
     cob_ahorros..ah_resumen_ctacontrac
where sd_cuenta = rc_cuenta
and   sd_fecha = @w_fin_mes_ant
if @@error <> 0
begin
   --print 'ERROR EN ACTUALIZACION SALDO DISPONIBLE MES ANTERIOR'
   exec cobis..sp_cerror
   @i_num       = 150001,
   @i_msg       = 'ERROR EN ACTUALIZACION SALDO DISPONIBLE MES ANTERIOR'
   return 150001
end

/* ACTUALIZAR SALDO DISPONIBLE MES */
update cob_ahorros..ah_resumen_ctacontrac set
rc_saldo_mes = isnull(rc_saldo_mes_ant,0) + isnull(rc_mvto_mes,0)
from cob_ahorros..ah_resumen_ctacontrac
if @@error <> 0
begin
   --print 'ERROR EN ACTUALIZACION SALDO DISPONIBLE MES'
   exec cobis..sp_cerror
   @i_num       = 150001,
   @i_msg       = 'ERROR EN ACTUALIZACION SALDO DISPONIBLE MES ACTUAL'
   return 150001
end

/* ACTUALIZAR DIFERENCIA ENTRE SALDOS */
update cob_ahorros..ah_resumen_ctacontrac set
rc_diferencia = isnull(rc_saldo_mes,0) - isnull(rc_saldo_esp,0)
from cob_ahorros..ah_resumen_ctacontrac
if @@error <> 0
begin
   exec cobis..sp_cerror
   @i_num       = 150001,
   @i_msg       = 'ERROR EN ACTUALIZACION DIFERENCIA ENTRE SALDOS'
   return 150001
end

/* UNIVERSO DE CUENTAS DE AHORRO CONTRACTUAL - REPORTE DOS */
insert into cob_ahorros..ah_resumen_ctacontrac
(rc_tipo_reporte, rc_regional, rc_zona, rc_oficina, rc_prod_banc,
 rc_categoria, rc_cliente, rc_nombre, rc_cuenta,
 rc_cta_banco, rc_saldo_mes_ant, rc_debitos, rc_creditos,
 rc_mvto_mes, rc_saldo_mes, rc_num_cuota, rc_vlr_cuota,
 rc_saldo_esp, rc_diferencia)
select
 2, rc_regional, rc_zona,  rc_oficina, rc_prod_banc,
 rc_categoria, 0,
(select c.valor from cobis..cl_catalogo c
where c.tabla = (select t.codigo from cobis..cl_tabla t where t.tabla = 'cl_oficina')
and   c.codigo = convert(varchar,rc_oficina)), count(isnull(rc_cta_banco,0)),
'',sum(isnull(rc_saldo_mes_ant,0)), 0, 0,
sum(isnull(rc_mvto_mes,0)), sum(isnull(rc_saldo_mes,0)), 0 , 0,
sum(isnull(rc_saldo_esp,0)), sum(isnull(rc_diferencia,0))
from cob_ahorros..ah_resumen_ctacontrac
group by rc_regional, rc_zona, rc_oficina, rc_prod_banc, rc_categoria
order by rc_regional, rc_zona, rc_oficina, rc_prod_banc, rc_categoria
if @@error <> 0
begin
   --print 'ERROR EN UNIVERSO DE CUENTAS DE AHORRO CONTRACTUAL - REPORTE DOS'
   exec cobis..sp_cerror
   @i_num       = 150000,
   @i_msg       = 'ERROR EN UNIVERSO DE CUENTAS DE AHORRO CONTRACTUAL - REPORTE DOS'
   return 150000
end

go

