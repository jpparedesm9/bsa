/************************************************************************/
/*        Archivo:                ahconplan.sp                          */
/*        Stored procedure:        sp_consulta_ahorro_plan              */
/*        Base de datos:            cob_ahorros                         */
/*        Producto:                Cuentas de Ahorros                   */
/*        Disenado por:            Saira Molano                         */
/*        Fecha de escritura:     25-Ago-2011                           */
/************************************************************************/
/*                                IMPORTANTE                            */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                                PROPOSITO                             */
/*        Este programa procesa la transaccion de:                      */
/*        Mto plan de ahorro cuentas especiales para evaluar Cumplimiento*/
/*        y/o incumplimiento por cuenta para consulta por frontend      */
/************************************************************************/
/*                                MODIFICACIONES                        */
/*        FECHA            AUTOR            RAZON                       */
/*        25/Ago/2011     S.Molano       Emision Inicial                */
/*      02/May/2016     J. Calderon    Migración a CEN                  */
/************************************************************************/

USE cob_ahorros
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_consulta_ahorro_plan')
   drop proc sp_consulta_ahorro_plan
go

create proc sp_consulta_ahorro_plan (
 @t_show_version    bit = 0,
 @i_fecha_proceso    datetime = null,  -- Fecha Inicial
 --@i_fecha_hasta datetime = null,  -- Fecha Final
 --@i_oficina     int = null,
   @i_opcion      char(1)   
)
as
declare @w_return                int,
        @w_sp_name                varchar(30),
        @w_oficina                smallint,
        @w_cuenta                int,
        @w_fecha_aper            datetime,
        @w_cta_banco            cuenta,
        @w_fecha_desde            datetime,
        @w_fecha_hasta            datetime,
        @w_fecha_proceso        datetime,
        @w_error                varchar(10),
        @w_msg                    varchar(250),
        @w_fecha_sig            datetime,
        @w_ciudad_matriz          int

-- Captura nombre de Stored Procedure
select    @w_sp_name = 'sp_consulta_ahorro_plan'


---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure = '+ @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
end

--select @w_fecha_proceso = fp_fecha
--from cobis..ba_fecha_proceso

select @w_ciudad_matriz = pa_int
  from cobis..cl_parametro
 where pa_nemonico = 'CMA'
   and pa_producto = 'CTE'

print 'fecha ConPlan' + convert(varchar(25),@i_fecha_proceso)

if @i_opcion = 'D' --Con Incumplimiento - Descubierta
begin
    truncate table ah_reporte_plan_incump

    delete from ah_reporte_plan
    where rp_fecha_aprox = @i_fecha_proceso
      and rp_estado = 'D'

    insert into ah_reporte_plan
    select ah_oficina,
           ah_cliente,
           ah_cta_banco,
           en_ced_ruc,
           en_nomlar,
           ah_fecha_aper,
           im_cuota,
           im_mto_mes,
           ah_disponible,
           im_sldo_esp,
          (ah_disponible-im_sldo_esp),
           null,
           im_estado,
           im_fecha_aprox,
           ah_producto,
           ah_prod_banc
    from ah_imprime_plan, ah_cuenta,cobis..cl_ente
    where im_cuenta     = ah_cuenta
    and   ah_cliente    = en_ente
    and   im_fecha_aprox = @i_fecha_proceso
    and   im_estado = 'D'

    update ah_reporte_plan 
    set rp_telefono = te_valor 
    from cob_ahorros..ah_reporte_plan,
         cobis..cl_direccion, 
         cobis..cl_telefono 
    where  di_principal  = 'S' 
    and di_direccion = te_direccion 
    and te_ente = di_ente 
    and te_secuencial = di_telefono
    and te_ente = rp_cliente 

    --Genera Totales Incumplimiento
    insert into ah_reporte_plan_incump
    select rp_oficina,
           'cuentas' = count(*),
           'Disponible' = isnull(round(sum(rp_saldo_mes), 2),0),
           'Esperado'= isnull(round(sum(rp_saldo_esp),2),0),
            rp_prod_banc
    from ah_reporte_plan 
    where rp_estado = 'D' -- descubierta
    and   rp_fecha_aprox = @i_fecha_proceso
    group by rp_oficina,rp_prod_banc
end

if @i_opcion = 'P' --Por vencer
begin

select @w_fecha_sig = dateadd(dd,1,@i_fecha_proceso)
print '@w_fecha_sig con plan opcion P' + ' ' +  convert(varchar(25),@i_fecha_proceso)

--Busca dia habil siguiente
      exec @w_return = cob_remesas..sp_fecha_habil
         @i_val_dif       = 'N',
         @i_efec_dia      = 'S',
         @i_fecha         = @w_fecha_sig,         
         @i_oficina       = 1,                      
         @i_dif           = 'N',               --Horario Normal
         @w_dias_ret      =  1,                --Dia siguiente habil 
         @i_finsemana     = 'N',               --No tiene en cuenta el sabado como festivo 
         @o_ciudad_matriz = @w_ciudad_matriz  out,
         @o_fecha_sig     = @w_fecha_sig out

         if @w_return <> 0 
            print @w_return

    truncate table ah_reporte_plan_venc

    print 'Opcion XP ' + convert(varchar(25),@w_fecha_sig)

    delete from ah_reporte_plan
    where rp_estado = 'P'

    insert into ah_reporte_plan
    select ah_oficina,
           ah_cliente,
           ah_cta_banco,
           en_ced_ruc,
           en_nomlar,
           ah_fecha_aper,
           isnull(im_cuota,0),
           isnull(im_mto_mes,0),
           isnull(ah_disponible,0),
           isnull(im_sldo_esp,0),
           isnull((ah_disponible-im_sldo_esp),0),
           null,
           im_estado,
           im_fecha_aprox,
           ah_producto,
           ah_prod_banc
    from ah_imprime_plan, ah_cuenta,cobis..cl_ente
    where im_cuenta     = ah_cuenta
    and   ah_cliente    = en_ente
    and   im_fecha_aprox between @i_fecha_proceso and @w_fecha_sig
    and   im_estado = 'P'
    --and   ah_oficina = @i_oficina

    update ah_reporte_plan 
    set rp_telefono = te_valor 
    from cob_ahorros..ah_reporte_plan,
         cobis..cl_direccion, 
         cobis..cl_telefono 
    where  di_principal  = 'S' 
    and di_direccion = te_direccion 
    and te_ente = di_ente 
    and te_secuencial = di_telefono
    and te_ente = rp_cliente 

    insert into ah_reporte_plan_venc
    select rp_oficina,
           'cuentas' = count(*),
           'Disponible' = isnull(round(sum(rp_saldo_mes), 2),0),
           'Esperado'= isnull(round(sum(rp_saldo_esp),2),0),
            rp_prod_banc
    from ah_reporte_plan 
    where rp_estado = 'P' -- Pendiente
    and   rp_fecha_aprox between @i_fecha_proceso and @w_fecha_sig
    group by rp_oficina,rp_prod_banc
end

return 0


go

