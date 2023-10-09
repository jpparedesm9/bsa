/************************************************************************/
/*  Archivo:                cons_valsus.sp                              */
/*  Stored procedure:       sp_cons_valsus                              */
/*  Base de datos:          cob_ahorros                                 */
/*  Producto:               Cuentas de Ahorros                          */
/*  Disenado por:           Mauricio Bayas/Sandra Ortiz                 */
/*  Fecha de escritura:     10-Feb-1995                                 */
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
/*                                  PROPOSITO                           */
/*  Este programa realiza la transaccion de consulta de valores en      */
/*  suspenso para una cuenta de ahorros.                                */
/************************************************************************/
/*                                MODIFICACIONES                        */
/*  FECHA           AUTOR           RAZON                               */
/*  10/Feb/1995     J. Bucheli      Personalizacion para Banco de       */
/*                                  la Produccion                       */
/*  06/Ene/1996     D. Villafuerte  Control de Calidad                  */
/*  17/Feb/2000     V. Molina       Revision B.Caribe                   */
/*  05/Jun/2002     A. Pazmiño      Personalizaci=n Agro Mercantil      */
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
           where  name = 'sp_cons_valsus')
  drop proc sp_cons_valsus
go

create proc sp_cons_valsus
(
  @s_user          varchar(30),
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_mon           tinyint,
  @i_sec           int = 0,
  @i_formato_fecha int = 101
)
as
  declare
    @w_return      int,
    @w_sp_name     varchar(30),
    @w_est         char(1),
    @w_cuenta      int,
    @w_pendientes  money,
    @w_cancelados  money,
    @w_filial      tinyint,
    @w_funcionario char(1)

  /* Captura del nombre del Store Procedure */

  select
    @w_sp_name = 'sp_cons_valsus'

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
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      i_cta = @i_cta,
      i_mon = @i_mon,
      i_sec = @i_sec
    exec cobis..sp_end_debug
  end

  select
    @w_cuenta = ah_cuenta,
    @w_est = ah_estado,
    @w_filial = ah_filial,
    @w_funcionario = ah_cta_funcionario
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
      @i_num   = 201004
    return 1
  end

  /* Validaciones */
  if @w_est <> 'A'
  begin
    /* Cuenta no activa o cancelada */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251002
    return 1
  end

  /* Verificacion de cuentas de funcionarios para oficiales autorizados */
  if @w_funcionario = 'S'
  begin
    if not exists (select
                     1
                   from   cob_remesas..re_ofi_personal,
                          cobis..cc_oficial,
                          cobis..cl_funcionario
                   where  fu_login       = @s_user
                      and fu_funcionario = oc_funcionario
                      and op_oficial     = oc_oficial)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201123
      return 1
    end
  end

  select
    @w_pendientes = isnull(sum(vs_valor),
                           0)
  from   cob_ahorros..ah_val_suspenso
  where  vs_cuenta    = @w_cuenta
     and vs_estado    = 'N'
     and vs_procesada = 'N'

  select
    @w_cancelados = isnull(sum(vs_valor),
                           0)
  from   cob_ahorros..ah_val_suspenso
  where  vs_cuenta    = @w_cuenta
     and (vs_estado    = 'C'
           or vs_procesada = 'S')
     and vs_estado    <> 'A'

  /* if @w_pendientes > 0
      select @w_cancelados = @w_cancelados -@w_pendientes */

  if @i_sec = 0
    select
      @w_pendientes,
      @w_cancelados

  set rowcount 20
  select
    'SEC' = vs_secuencial,
    'NUM OFI' = vs_oficina,
    'OFICINA' = substring(of_nombre,
                          1,
                          20),
    'FECHA' = convert(char(10), vs_fecha, @i_formato_fecha),
    'HORA' = convert(char(8), vs_hora, 8),
    'VALOR' = vs_valor,
    'CONCEPTO' = substring(valor,
                           1,
                           30),
    'ESTADO' = vs_estado,
    'PROCESADA' = vs_procesada
  from   cob_ahorros..ah_val_suspenso,
         cobis..cl_oficina,
         cobis..cl_tabla,
         cobis..cl_catalogo
  where  vs_cuenta              = @w_cuenta
     and vs_secuencial          > @i_sec
     and of_filial              = @w_filial
     and of_oficina             = vs_oficina
     and vs_estado              <> 'A'
     and cobis..cl_tabla.tabla  = 'ah_causa_nd'
     and cobis..cl_tabla.codigo = cobis..cl_catalogo.tabla
     and (cobis..cl_catalogo.codigo = vs_servicio)
  set rowcount 0

  return 0

go


