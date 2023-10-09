/************************************************************************/
/*    Archivo:                ahtcomov.sp                               */
/*    Stored procedure:        sp_consulta_movimientos_ah               */
/*  Base de datos:          cob_ahorros                                 */
/*  Producto:               Cuentas de Ahorros                          */
/*  Disenado por:           Mauricio Bayas/Sandra Ortiz                 */
/*    Fecha de escritura:     03-JUN-1994                               */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*    Este programa realiza la transaccion de consulta de               */
/*    bloqueos de movimientos en ahorros                                */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA       AUTOR           RAZON                               */
/*  03/Mar/1995     J. Bucheli      Emision inicial para Banco de       */
/*                                  la Produccion                       */
/*  07/Jul/1995     A. Villarreal   Personalizacion B. de Prestamos     */
/*  21/Sep/1998     S.Gonzalez      Personalizacion Banco del Caribe    */
/*  26/Oct/2001     C. Vargas       Agregar param. @i_formato_fecha     */
/*  06/jun/2002     A. Pazmiño      Personalización Agro Mercantil      */
/*  02/May/2016     J. Calderon     Migración a CEN                     */
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
           where  name = 'sp_consulta_movimientos_ah')
  drop proc sp_consulta_movimientos_ah
go

create proc sp_consulta_movimientos_ah
(
  @s_ssn           int,
  @s_srv           varchar(30),
  @s_user          varchar(30),
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
  @i_sec           int = 0,
  @i_mon           tinyint,
  @i_est           char(1),
  @i_fdesde        smalldatetime = null,
  @i_fhasta        smalldatetime = null,
  @i_formato_fecha int = null,
  @i_corresponsal  char(1) = 'N' --Req. 381 CB Red Posicionada     
)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(30),
    @w_cuenta        int,
    @w_prod_bancario varchar(50) --Req. 381 CB Red Posicionada

  /* Captura del nombre del Store Procedure */
  select  @w_sp_name = 'sp_consulta_movimientos_ah'

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
      i_est = @i_est,
      i_fdesde = @i_fdesde,
      i_fhasta = @i_fhasta
    exec cobis..sp_end_debug
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
      @w_cuenta = ah_cuenta
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_moneda    = @i_mon
       and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

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
      @w_cuenta = ah_cuenta
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_moneda    = @i_mon

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

/* No se valida que la cuenta se encuentre activa */
  /* Bloqueo de movimientos */

  set rowcount 20
  if @i_est <> 'L'
    select
      'TIPO DE BLOQUEO' = substring(y.valor,
                                    1,
                                    26),
      'CAUSA' = substring(x.valor,
                          1,
                          35),
      'FECHA' = convert(char(12), cb_fecha, @i_formato_fecha),
      'HORA' = convert(char(9), cb_hora, 8),
      'SOLICITANTE' = substring(cb_solicitante,
                                1,
                                30),
      'USUARIO' = cb_autorizante,
      'OFICINA' = cb_oficina,
      'SEC' = cb_secuencial,
      'OBSERVACION' = cb_observacion
    from   cob_ahorros..ah_ctabloqueada,
           cobis..cl_catalogo x,
           cobis..cl_catalogo y
    where  cb_cuenta     = @w_cuenta
       and cb_secuencial > @i_sec
       and cb_estado     = @i_est
       and cb_fecha      >= @i_fdesde
       and cb_fecha      <= @i_fhasta
       and y.codigo      = cb_tipo_bloqueo
       and y.tabla       = (select
                              codigo
                            from   cobis..cl_tabla
                            where  tabla = 'ah_tbloqueo')
       and x.codigo      = cb_causa
       and x.tabla       = (select
                              codigo
                            from   cobis..cl_tabla
                            where  tabla = 'ah_causa_bloqueo_mov')
  else
    select
      'OFICINA BLOQUEO' = z.cb_oficina,
      'OFICINA LEVANT.' = w.cb_oficina,
      'FECHA BLOQUEO' = convert(char(12), z.cb_fecha, @i_formato_fecha),
      'FECHA LEVANT.' = convert(char(12), w.cb_fecha, @i_formato_fecha),
      'HORA BLOQUEO' = convert(char(9), z.cb_hora, 8),
      'HORA LEVANT.' = convert(char(9), w.cb_hora, 8),
      'TIPO LEVANTAM.' = substring(y.valor,
                                   1,
                                   25),
      'SOLICITADO POR' = substring(w.cb_solicitante,
                                   1,
                                   30),
      'CAUSA LEVANT.' = substring(x.valor,
                                  1,
                                  30),
      'USUARIO BLOQUEO' = z.cb_autorizante,
      'USUARIO LEVANT.' = w.cb_autorizante
    from   cob_ahorros..ah_ctabloqueada w,
           cob_ahorros..ah_ctabloqueada z,
           cobis..cl_catalogo x,
           cobis..cl_catalogo y
    where  w.cb_cuenta     = @w_cuenta
       and w.cb_secuencial > @i_sec
       and w.cb_estado     = @i_est
       and w.cb_sec_asoc   = z.cb_secuencial
       and w.cb_fecha      >= @i_fdesde
       and w.cb_fecha      <= @i_fhasta
       and y.codigo        = w.cb_tipo_bloqueo
       and z.cb_estado     = 'C'
       and y.tabla         = (select
                                codigo
                              from   cobis..cl_tabla
                              where  tabla = 'ah_tbloqueo')
       and x.codigo        = w.cb_causa
       and x.tabla         = (select
                                codigo
                              from   cobis..cl_tabla
                              where  tabla = 'ah_motivo_levbloq_mov')
  set rowcount 0

  return 0

go

