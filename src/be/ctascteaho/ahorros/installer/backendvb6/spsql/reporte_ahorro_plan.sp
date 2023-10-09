/************************************************************************/
/*      Archivo:                reporte_ahorro_plan.sp                  */
/*      Stored procedure:       sp_reporte_ahorro_plan                  */
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
/*      Reporte Ahorro Plan                                             */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_reporte_ahorro_plan')
   drop proc sp_reporte_ahorro_plan
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_reporte_ahorro_plan (
 @s_date            datetime,
 @i_fecha_proceso   datetime = null,  -- Fecha Inicial
 @i_fecha_desde     datetime = null,  -- Fecha Inicial
 @i_fecha_hasta     datetime = null,  -- Fecha Final
 @t_debug           char(1) = 'N',
 @t_file            varchar(14) = null,
 @t_from            varchar(32) = null,
 @t_show_version    bit = 0,
 @i_oficina         int = null,
 @i_opcion          char(1),
 @i_producto        int = null,
 @i_secuencial      int = null
)
as
declare @w_return               int,
        @w_sp_name              varchar(30),
        @w_oficina              smallint,
        @w_cuenta               int,
        @w_fecha_aper           datetime,
        @w_cta_banco            cuenta,
        @w_fecha_desde          datetime,
        @w_fecha_hasta          datetime,
        @w_fecha_proceso        datetime,
        @w_msg                  varchar(250),
        @w_fecha_sig            datetime,
        @w_ciudad_matriz        int,
        @w_fecha_min            varchar(12),
        @w_fecha_max            varchar(12),
        @w_total_pen            int,
        @w_total_des            int,
        @w_numdias              tinyint,
        @w_error                int

-- Captura nombre de Stored Procedure
select  @w_sp_name = 'sp_reporte_ahorro_plan'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

/*
select @w_error = 141195
if @i_secuencial > 0
   select @w_error = 710238*/

if @i_opcion = 'D' --Con Incumplimiento - Descubierta
begin

    set rowcount 10
    select 'SECUENCIAL'     = rp_secuencial,
           'NUMERO CUENTA'  = rp_cta_banco,
           'D.I.'           = rp_ced_ruc,
           'NOMBRE CLIENTE' = substring(rp_nomlar,1,33),
           'FECHA APERTURA' = convert(varchar(15),rp_fecha_aper,101),
           'CUOTA MENSUAL'  = rp_cuota,
           'MOVIMIENTO MES' = rp_mto_mes,
           'SALDO ACTUAL'   = rp_saldo_mes,
           'SALDO ESPERADO' = rp_saldo_esp,
           'DIFERENCIA' = rp_diferencia,
           'TELEFONO'= rp_telefono,
           'PROD_BANC' = pb_descripcion
    from ah_reporte_plan,cob_remesas..pe_pro_bancario
    where rp_estado = @i_opcion
    and   rp_oficina = @i_oficina
    and   rp_prod_banc  = pb_pro_bancario
    and   rp_fecha_aprox between @i_fecha_desde and @i_fecha_hasta
    and   rp_producto = @i_producto
    and   rp_secuencial > @i_secuencial
    order by rp_secuencial

    if (@@rowcount = 0)
    begin
       exec cobis..sp_cerror
              @t_debug   = @t_debug,
              @t_file    = @t_file,
              @t_from    = @w_sp_name,
              @i_num     = 141195
        return 141195
    end

    set rowcount 0

    select @w_total_des = count(*)
    from ah_reporte_plan
    where rp_estado = @i_opcion
    and   rp_oficina = @i_oficina
    and   rp_fecha_aprox between @i_fecha_desde and @i_fecha_hasta
    and   rp_producto = @i_producto

    --print 'total' + convert(varchar(10),@w_total_des)
    select @w_total_des
end

if @i_opcion = 'P' --Por vencer
begin
    set rowcount 20
    select 'SECUENCIAL'     = rp_secuencial,
           'NUMERO CUENTA'  = rp_cta_banco,
           'D.I.'           = rp_ced_ruc,
           'NOMBRE CLIENTE' = substring(rp_nomlar,1,33),
           'FECHA APERTURA' = convert(varchar(15),rp_fecha_aper,101),
           'CUOTA MENSUAL'  = rp_cuota,
           'MOVIMIENTO MES' = rp_mto_mes,
           'SALDO ACTUAL'   = rp_saldo_mes,
           'SALDO ESPERADO' = rp_saldo_esp,
           'DIFERENCIA' = rp_diferencia,
           'TELEFONO'= rp_telefono,
           'PROD_BANC' = pb_descripcion
    from ah_reporte_plan,cob_remesas..pe_pro_bancario
    where rp_estado = @i_opcion
    and   rp_oficina = @i_oficina
    and   rp_prod_banc = pb_pro_bancario
    and   rp_producto = @i_producto
    and   rp_secuencial > @i_secuencial
    order by rp_secuencial

    if (@@rowcount = 0)
    begin
     exec cobis..sp_cerror
          @t_debug   = @t_debug,
          @t_file    = @t_file,
          @t_from    = @w_sp_name,
          @i_num     = 141195
    return 141195
    end

    set rowcount 0

    select @w_fecha_min = convert(varchar(12),min(rp_fecha_aprox),103)
    from  ah_reporte_plan
    where rp_estado = @i_opcion
    and   rp_oficina = @i_oficina
    and   rp_producto = @i_producto

    select @w_fecha_max = convert(varchar(12),max(rp_fecha_aprox),103)
    from  ah_reporte_plan
    where rp_estado = @i_opcion
    and   rp_oficina = @i_oficina
    and   rp_producto = @i_producto

    select @w_total_pen = count(*)
    from  ah_reporte_plan
    where rp_estado = @i_opcion
    and   rp_oficina = @i_oficina
    and   rp_producto = @i_producto

    select @w_fecha_min
    select @w_fecha_max
    select @w_total_pen
end

if @i_opcion = 'S'
begin

   select @w_numdias = pa_tinyint
   from cobis..cl_parametro
   where pa_nemonico = 'DICO'

   if @@rowcount <> 1
   begin
      -- Error: no se han definido ciudad de feriados nacionales
      exec cobis..sp_cerror
      @i_num       = 252082 --@i_msg       = 'NO EXISTE NUMERO DE DIAS LIMITE DE CONSULTA FRONTEND'
      return 252082
   end

   select @w_numdias
end

return 0

go

