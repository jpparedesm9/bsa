/************************************************************************/
/*    Archivo:              ahtcoblq.sp                                 */
/*    Stored procedure:     sp_cons_bloq_ah                             */
/*    Base de datos:        cob_ahorros                                 */
/*    Producto: Cuentas de Ahorros                                      */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*    Fecha de escritura: 01-Mar-1993                                   */
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
/*    Este programa realiza la transaccion de consulta de bloqueos      */
/*    contra valores de cuentas de ahorros.                             */
/*    231 = Consulta de bloqueos a valores de cuentas de ahorros.       */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*      FECHA           AUTOR           RAZON                           */
/*    01/Mar/1993    P Mena           Emision inicial                   */
/*    14/Dic/1994    J. Bucheli     Personalizacion para el Banco       */
/*                        de la Produccion                              */
/*    07/Jul/1995     A. Villarreal  Personalizacion B. de Prestamos    */
/*    21/Sep/1998     S.Gonzalez     Personalizacion Banco del Caribe   */
/*    23/Oct/2001     C. Vargas      Agregar param. @i_formato_fecha    */
/*    06/Jun/2002     A. Pazmiño     Personalizaci=n Agro Mercantil     */
/*    25/Feb/2005        L. Bernuil     Pignoraci¢n por Bloqueo         */
/*    02/May/2016     J. Calderon     Migración a CEN                   */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_cons_bloq_ah')
  drop proc sp_cons_bloq_ah
go
create proc sp_cons_bloq_ah
(
  @s_ssn           int,
  @s_srv           varchar(30) = null,
  @s_user          varchar(30) = null,
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_org           char(1),
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint = 1,
  @s_org_err       char(1) = null,/* Origen de error:[A], [S] */
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_mon           tinyint,
  @i_modo          tinyint,
  @i_sec           smallint = null,
  @i_tipo          char(1) = null,
  @i_fdesde        smalldatetime = null,
  @i_fhasta        smalldatetime = null,
  @i_ope           varchar(2) = '%',
  @i_formato_fecha int = 101,
  @i_flag          char(1) = null,
  @i_corresponsal  char(1) = 'N' --Req. 381 CB Red Posicionada    
)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(30),
    @w_cuenta        int,
    @w_estado        char(1),
    @w_moneda        tinyint,
    @w_prod_bancario varchar(50) --Req. 381 CB Red Posicionada    

  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_cons_bloq_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_mon = @i_mon,
      i_sec = @i_sec,
      i_tipo = @i_tipo,
      i_fdesde = @i_fdesde,
      i_fhasta = @i_fhasta,
      i_ope = @i_ope
    exec cobis..sp_end_debug
  end

  if @t_trn <> 216
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    select
      @w_cuenta = ah_cuenta,
      @w_estado = ah_estado
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_moneda    = @i_mon
       and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
    /* Chequeo de existencias */

    if @@rowcount <> 1
    begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251001
      return 1
    end
  end
  else
  begin
    select
      @w_cuenta = ah_cuenta,
      @w_estado = ah_estado
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_moneda    = @i_mon
    /* Chequeo de existencias */

    if @@rowcount <> 1
    begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251001
      return 1
    end
  end

/* Validaciones */
/* Permite la consulta de cuentas inactivas
if @w_estado <> 'A' 
begin
  /* Cuenta no activa o cancelada */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 251002
   return 1
end
*/
  /* Envio de resultados al Front End */

  set rowcount 20
  if @i_tipo = 'B'
  begin
    if @i_modo = 0
      select
        'FECHA   ' = convert(varchar(12), hb_fecha, @i_formato_fecha),
        'HORA   ' = convert(varchar(9), hb_hora, 8),
        --'LEVANTADO'           = hb_levantado,
        'LIBERADO' = hb_levantado,
        'VALOR BLOQUEADO' = hb_valor,
        'TOTAL BLOQUEADO' = hb_monto_bloq,
        'SALDO CUENTA   ' = hb_saldo,
        'FECHA VENC' = convert(varchar(12), hb_fecha_ven, @i_formato_fecha),
        --'USUARIO    '       = hb_autorizante,
        'USUARIO' = hb_autorizante,
        'SOLICITANTE    ' = substring(hb_solicitante,
                                      1,
                                      35),
        'CAUSA' = substring(valor,
                            1,
                            25),
        'SUCURSAL' = hb_oficina,
        'No.' = hb_secuencial,
        'OBSERVACION    ' = hb_observacion,
        'No. GARANTIA' = hb_ngarantia,
        'No. LINEA SOB.' = hb_nlinea_sob,
        'No. CTA.CTE ' = hb_numcte
      from   cob_ahorros..ah_his_bloqueo,
             cobis..cl_catalogo
      where  hb_cuenta = @w_cuenta
         and hb_accion = @i_tipo
         and hb_fecha  >= @i_fdesde
         and hb_fecha  <= @i_fhasta
         and hb_levantado like @i_ope
         and hb_causa  = codigo
         and tabla     = (select
                            codigo
                          from   cobis..cl_tabla
                          where  tabla   = 'ah_causa_bloqueo_val'
                             and ((@i_flag = '1'
                                   and estado  = 'V')
                                   or @i_flag is null))

    else if @i_modo = 1
      select
        'FECHA   ' = convert(varchar(12), hb_fecha, @i_formato_fecha),
        'HORA   ' = convert(varchar(9), hb_hora, 8),
        --'LEVANTADO'         = hb_levantado,
        'LIBERADO' = hb_levantado,
        'VALOR BLOQUEADO' = hb_valor,
        'TOTAL BLOQUEADO' = hb_monto_bloq,
        'SALDO CUENTA   ' = hb_saldo,
        'FECHA VENC' = convert(varchar(12), hb_fecha_ven, @i_formato_fecha),
        --'USUARIO    '   = hb_autorizante,
        'USUARIO' = hb_autorizante,
        'SOLICITANTE    ' = substring(hb_solicitante,
                                      1,
                                      35),
        'CAUSA' = substring(valor,
                            1,
                            25),
        'SUCURSAL' = hb_oficina,
        'No.' = hb_secuencial
      from   cob_ahorros..ah_his_bloqueo,
             cobis..cl_catalogo
      where  hb_cuenta     = @w_cuenta
         and hb_secuencial > @i_sec
         and hb_accion     = @i_tipo
         and hb_fecha      >= @i_fdesde
         and hb_fecha      <= @i_fhasta
         and hb_levantado like @i_ope
         and codigo        = hb_causa
         and tabla         = (select
                                codigo
                              from   cobis..cl_tabla
                              where  tabla   = 'ah_causa_bloqueo_val'
                                 and ((@i_flag = '1'
                                       and estado  = 'V')
                                       or @i_flag is null))
  end
  else
  begin
    if @i_modo = 0
      select
        'SUCURSAL BLOQUEO' = y.hb_oficina,
        --'AGENCIA PIGNORACION'   = y.hb_oficina,
        --'AGENCIA LEVANT.'   = x.hb_oficina,
        'SUCURSAL LIBERACION' = x.hb_oficina,
        'FECHA BLOQUEO' = convert(varchar(12), y.hb_fecha, @i_formato_fecha),
        --'FECHA PIGNORACION'     = convert(varchar(12),y.hb_fecha,@i_formato_fecha),
        'HORA BLOQUEO' = convert(varchar(9), y.hb_hora, 8),
        --'HORA PIGNORACION'      = convert(varchar(9),y.hb_hora,8),
        --'FECHA LEVANT.'     = convert(varchar(12),x.hb_fecha,@i_formato_fecha),
        'FECHA LIBERACION.' = convert(varchar(12), x.hb_fecha, @i_formato_fecha)
        ,
        --'HORA LEVANT.'      = convert(varchar(9),x.hb_hora,8),
        'HORA LIBERACION' = convert(varchar(9), x.hb_hora, 8),
        'CAUSA' = substring(valor,
                            1,
                            25),
        'VALOR BLOQUEADO' = y.hb_valor,
        --'VALOR PIGNORADO'   = y.hb_valor,    
        'FECHA VENC' = convert(varchar(12), y.hb_fecha_ven, @i_formato_fecha),
        'USUARIO BLOQUEO' = y.hb_autorizante,
        --'USUARIO PIGNORACION.'   = y.hb_autorizante,
        --'USUARIO LEVANT.'   = x.hb_autorizante,
        'USUARIO LIBERACION' = x.hb_autorizante,
        'No.' = y.hb_secuencial,
        'SOLICITANTE    ' = substring(x.hb_solicitante,
                                      1,
                                      35)
      /*,
                   --'LEVANTADO'         = hb_levantado,
               'LIBERADO'         = hb_levantado,
               'TOTAL BLOQUEADO'   = hb_monto_blq,
                -- 'TOTAL PIGNORADO'   = hb_monto_blq,
                   'SALDO CUENTA   '   = hb_saldo */
      from   cob_ahorros..ah_his_bloqueo x,
             cob_ahorros..ah_his_bloqueo y,
             cobis..cl_catalogo
      where  x.hb_cuenta   = @w_cuenta
         and x.hb_accion   = @i_tipo
         and x.hb_fecha    >= @i_fdesde
         and x.hb_fecha    <= @i_fhasta
         and x.hb_levantado like @i_ope
         and x.hb_sec_asoc = y.hb_secuencial
         and x.hb_causa    = codigo
         and tabla         = (select
                                codigo
                              from   cobis..cl_tabla
                              --                          where tabla = 'ah_causa_bloqueo_val')
                              where  tabla = 'ah_caulev_blqva')
    else if @i_modo = 1
      select
        'SUCURSAL BLOQUEO' = y.hb_oficina,
        --'AGENCIA PIGNORACION'   = y.hb_oficina,
        --'AGENCIA LEVANT.'   = x.hb_oficina,
        'SUCURSAL LIBERACION' = x.hb_oficina,
        'FECHA BLOQUEO' = convert(varchar(12), y.hb_fecha, @i_formato_fecha),
        --'FECHA PIGNORACION'     = convert(varchar(12),y.hb_fecha,@i_formato_fecha),
        'HORA BLOQUEO' = convert(varchar(9), y.hb_hora, 8),
        --'HORA PIGNORACION'      = convert(varchar(9),y.hb_hora,8),
        --'FECHA LEVANT.'     = convert(varchar(12),x.hb_fecha,@i_formato_fecha),
        'FECHA LIBERACION.' = convert(varchar(12), x.hb_fecha, @i_formato_fecha)
        ,
        --'HORA LEVANT.'      = convert(varchar(9),x.hb_hora,8),
        'HORA LIBERACION' = convert(varchar(9), x.hb_hora, 8),
        'CAUSA' = substring(valor,
                            1,
                            25),
        'VALOR BLOQUEADO' = y.hb_valor,
        --'VALOR PIGNORADO'   = y.hb_valor,    
        'FECHA VENC' = convert(varchar(12), y.hb_fecha_ven, @i_formato_fecha),
        'USUARIO BLOQUEO' = y.hb_autorizante,
        --'USUARIO PIGNORACION.'   = y.hb_autorizante,
        --'USUARIO LEVANT.'   = x.hb_autorizante,
        'USUARIO LIBERACION' = x.hb_autorizante,
        'No.' = y.hb_secuencial,
        'SOLICITANTE    ' = substring(x.hb_solicitante,
                                      1,
                                      35)
      /*,
                   --'LEVANTADO'         = hb_levantado,
               'LIBERADO'         = hb_levantado,
               'TOTAL BLOQUEADO'   = hb_monto_blq,
               --'TOTAL PIGNORADO'   = hb_monto_blq,
                   'SALDO CUENTA   '   = hb_saldo */
      from   cob_ahorros..ah_his_bloqueo x,
             cob_ahorros..ah_his_bloqueo y,
             cobis..cl_catalogo
      where  x.hb_cuenta     = @w_cuenta
         and x.hb_accion     = @i_tipo
         and x.hb_fecha      >= @i_fdesde
         and x.hb_fecha      <= @i_fhasta
         and x.hb_secuencial > @i_sec
         and x.hb_levantado like @i_ope
         and x.hb_sec_asoc   = y.hb_secuencial
         and x.hb_causa      = codigo
         and tabla           = (select
                                  codigo
                                from   cobis..cl_tabla
                                --                          where tabla = 'ah_causa_bloqueo_val')
                                where  tabla = 'ah_caulev_blqva')
  end

  set rowcount 0
  return 0

go

