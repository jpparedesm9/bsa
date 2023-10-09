/***********************************************************************/
/*      Archivo:                  ah_consol.sp                         */
/*      Base de datos:            cob_ahorros                          */
/*      Producto:                 Cuentas de Ahorros                   */
/*      Disenado por:             Jaime Loyo                           */
/*      Fecha de escritura:       03/Ene/2012                          */
/***********************************************************************/
/*                              IMPORTANTE                             */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad      */
/*   de COBISCorp.                                                     */
/*   Su uso no autorizado queda expresamente prohibido asi como        */
/*   cualquier alteracion o agregado  hecho por alguno de sus          */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.   */
/*   Este programa esta protegido por la ley de derechos de autor      */
/*   y por las convenciones  internacionales   de  propiedad inte-     */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para  */
/*   obtener ordenes  de secuestro o retencion y para  perseguir       */
/*   penalmente a los autores de cualquier infraccion.                 */
/***********************************************************************/
/*                              PROPOSITO                              */
/*         Genera la consolidacion de Cuentas de Ahorros en la tabla   */
/*         ah_consolidado                                              */
/***********************************************************************/
/*                              MODIFICACIONES                         */
/*      FECHA           AUTOR             RAZON                        */
/*   03/Ene/2012        J. Loyo           Emision inicial              */
/*   02/May/2016        J. Calderon     Migración a CEN                */
/***********************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_consolida')
  drop procedure sp_consolida
GO

create proc sp_consolida
(
  @t_show_version bit = 0,
  @i_fecha        smalldatetime = null,
  @i_param1       datetime = null,-- Fecha de proceso
  @i_corresponsal char(1) = 'N' --Req. 381 CB Red Posicionada        
)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(30),
    @w_prod_bancario varchar(50) --Req. 381 CB Red Posicionada

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_consolida'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  set ansi_warnings off

  select
    @w_sp_name = 'sp_consolida'

  if @i_param1 is null
     and @i_fecha is null
  begin
    --Falta parametro obligatorio
    exec cobis..sp_cerror
      @i_num = 101114
    return 101114
  end

  if @i_fecha is null
    select
      @i_fecha = @i_param1

  begin tran

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  print ' Si existen registros los borra'
  delete cob_ahorros..ah_consolidado
  where  co_fecha = @i_fecha

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    print ' Insercion '
    /**** Insercion de la ah_consolidado  *******/
    insert into cob_ahorros..ah_consolidado
                (co_oficina,co_moneda,co_estado,co_tipo,co_numcuentas,
                 co_interes,co_acreedoras,co_total_acreedoras,co_deudoras,
                 co_total_deudoras,
                 co_saldo_neto,co_remesas,co_ret24h,co_debitos_hoy,
                 co_creditos_hoy
                 ,
                 co_interes_hoy,co_prod_banc,co_categoria,
                 co_errores,co_min_dispmes,
                 co_aperturadas,co_cerradas,co_tasa,co_cta_gobierno,co_fecha)
      select
        ah_oficina,ah_moneda,ah_estado,case ah_estado
          /**** co_tipo DESCRIPCION DEL ESTADO  ****/
          when 'A' then 'ACTIVA'
          when 'I' then 'INACTIVA'
          when 'C' then 'CANCELADA'
          when 'G' then 'INGRESADA'
          when 'N' then 'ANULADA'
        end,count(*),
        sum(ah_saldo_interes),/**** co_num_cuentas,  co_interes     ****/sum(
        case
              /**** co_acreedoras                   ****/
              when (ah_12h + ah_24h + ah_disponible) >= 0 then 1
              else 0
            end),sum(case /**** co_total_acreedoras             ****/
              when (ah_12h + ah_24h + ah_disponible) >= 0 then (
              ah_12h + ah_24h + ah_disponible)
              else 0
            end),sum(case /**** co_deudoras                     ****/
              when (ah_12h + ah_24h + ah_disponible) < 0 then 1
              else 0
            end),sum(case /****  co_total_deudoras              ****/
              when (ah_12h + ah_24h + ah_disponible) < 0 then (
              ah_12h + ah_24h + ah_disponible)
              else 0
            end),
        sum(ah_12h + ah_24h + ah_disponible),sum(ah_remesas),
        /****  co_saldo_neto, co_remesas      ****/ sum(ah_24h),sum(
        ah_debitos_hoy
        ),
        /**** co_ret24h,   co_debitos_hoy     ****/sum(ah_creditos_hoy),
        sum(ah_int_hoy),/**** co_creditos_hoy, co_interes_hoy ****/ah_prod_banc,
        ah_categoria,sum(case /**** co_errores                      ****/
              when (ah_saldo_ayer + ah_creditos_hoy - ah_debitos_hoy) <> (
                   ah_12h + ah_24h + ah_disponible) then 1
              else 0
            end),sum(ah_min_dispmes),
        sum(case /**** co_aperturadas_hoy             ****/
              when ah_fecha_aper = @i_fecha then 1
              else 0
            end),/**** co_cerradas_hoy                ****/sum(case
              when (ah_estado = 'C')
                   and ah_fecha_ult_mov = @i_fecha then 1
              else 0
            end),0,ah_tipocta_super,@i_fecha
      /**** co_tasa, co_gobierno, fecha    ****/
      from   cob_ahorros..ah_cuenta_tmp with (nolock)
      where  ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
      group  by ah_oficina,
                ah_moneda,
                ah_estado,
                ah_tipocta_super,
                ah_categoria,
                ah_prod_banc
      order  by ah_oficina,
                ah_moneda,
                ah_estado,
                ah_tipocta_super,
                ah_categoria,
                ah_prod_banc

    if @@error <> 0
    begin
      /** Error al insertar en transaccion de servicio de cuentas de ahorros***/
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 353005
      return 1
    end
    print 'Insercion ah_consolidado correcta'
  end
  else
  begin
    print ' Insercion '
    /**** Insercion de la ah_consolidado  *******/
    insert into cob_ahorros..ah_consolidado
                (co_oficina,co_moneda,co_estado,co_tipo,co_numcuentas,
                 co_interes,co_acreedoras,co_total_acreedoras,co_deudoras,
                 co_total_deudoras,
                 co_saldo_neto,co_remesas,co_ret24h,co_debitos_hoy,
                 co_creditos_hoy
                 ,
                 co_interes_hoy,co_prod_banc,co_categoria,
                 co_errores,co_min_dispmes,
                 co_aperturadas,co_cerradas,co_tasa,co_cta_gobierno,co_fecha)
      select
        ah_oficina,ah_moneda,ah_estado,case ah_estado
          /**** co_tipo DESCRIPCION DEL ESTADO  ****/
          when 'A' then 'ACTIVA'
          when 'I' then 'INACTIVA'
          when 'C' then 'CANCELADA'
          when 'G' then 'INGRESADA'
          when 'N' then 'ANULADA'
        end,count(*),
        sum(ah_saldo_interes),/**** co_num_cuentas,  co_interes     ****/sum(
        case
              /**** co_acreedoras                   ****/
              when (ah_12h + ah_24h + ah_disponible) >= 0 then 1
              else 0
            end),sum(case /**** co_total_acreedoras             ****/
              when (ah_12h + ah_24h + ah_disponible) >= 0 then (
              ah_12h + ah_24h + ah_disponible)
              else 0
            end),sum(case /**** co_deudoras                     ****/
              when (ah_12h + ah_24h + ah_disponible) < 0 then 1
              else 0
            end),sum(case /****  co_total_deudoras              ****/
              when (ah_12h + ah_24h + ah_disponible) < 0 then (
              ah_12h + ah_24h + ah_disponible)
              else 0
            end),
        sum(ah_12h + ah_24h + ah_disponible),sum(ah_remesas),
        /****  co_saldo_neto, co_remesas      ****/ sum(ah_24h),sum(
        ah_debitos_hoy
        ),
        /**** co_ret24h,   co_debitos_hoy     ****/sum(ah_creditos_hoy),
        sum(ah_int_hoy),/**** co_creditos_hoy, co_interes_hoy ****/ah_prod_banc,
        ah_categoria,sum(case /**** co_errores                      ****/
              when (ah_saldo_ayer + ah_creditos_hoy - ah_debitos_hoy) <> (
                   ah_12h + ah_24h + ah_disponible) then 1
              else 0
            end),sum(ah_min_dispmes),
        sum(case /**** co_aperturadas_hoy             ****/
              when ah_fecha_aper = @i_fecha then 1
              else 0
            end),/**** co_cerradas_hoy                ****/sum(case
              when (ah_estado = 'C')
                   and ah_fecha_ult_mov = @i_fecha then 1
              else 0
            end),0,ah_tipocta_super,@i_fecha
      /**** co_tasa, co_gobierno, fecha    ****/
      from   cob_ahorros..ah_cuenta_tmp with (nolock)
      group  by ah_oficina,
                ah_moneda,
                ah_estado,
                ah_tipocta_super,
                ah_categoria,
                ah_prod_banc
      order  by ah_oficina,
                ah_moneda,
                ah_estado,
                ah_tipocta_super,
                ah_categoria,
                ah_prod_banc

    if @@error <> 0
    begin
      /** Error al insertar en transaccion de servicio de cuentas de ahorros***/
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 353005
      return 1
    end
    print 'Insercion ah_consolidado correcta'
  end

  commit tran
  return 0

go

