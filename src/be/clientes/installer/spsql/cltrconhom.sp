/************************************************************************/
/*  Archivo:            cltrconhom.sp                                   */
/*  Stored procedure:   sp_tr_consulta_homini                           */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Igmar Berganza                                  */
/*  Fecha de escritura: 16-Sept-2013                                    */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/*   Stored Procedure para ejecutar el sp sp_consulta_homini            */
/*   de Validacion de Identidad de Clientes Homini                      */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*     FECHA             AUTOR           RAZON                          */
/*  OCTUBRE 2014      LIANA COTO       REQ465 - REACTIVACIÓN DE CUENTAS */
/*                                     CON BIOMETRÍA                    */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_consulta_homini')
  drop proc sp_tr_consulta_homini
go

create proc sp_tr_consulta_homini
(
  @s_ssn          int = null,
  @s_date         datetime = null,
  @s_ofi          smallint = null,
  @s_srv          varchar(30) = null,
  @s_user         varchar(30) = null,
  @s_term         varchar(10) = null,
  @s_rol          int = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_corr         char(1) = 'N',
  @t_ssn_corr     varchar(12) = null,
  @t_trn          int = null,
  @t_show_version bit = 0,
  @i_trn          int = null,
  @i_producto     int = 4,
  @i_operacion    char(1) = null,
  @i_user         varchar(12) = null,
  @i_id_caja      int = null,
  @i_tipo_ced     varchar(2) = null,
  @i_ced_ruc      varchar(13) = null,
  @i_ref          varchar(30) = null,
  @i_titularidad  char(1) = null,
  @i_sec_cobis    int = null,
  @i_cliente      int = null,
  @o_codigo       int = null out,
  @o_mensaje      varchar(254) = null out,
  @o_tipo_ced     varchar(3) = null out,
  @o_ced_ruc      varchar(13) = null out
)
as
  declare
    @w_sp_name     varchar(32),
    @w_mensaje     varchar(254),
    @w_return      int,
    @w_tipo_ced    varchar(10),
    @w_codigo      int = 0,
    @w_ced_ruc     varchar(30) = null,
    @w_titularidad char(1)

  select
    @w_sp_name = 'sp_tr_consulta_homini'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  -- Modificacion de t_trn 1609 a 1608 para poder transaccionar con el sp sp_consulta_homini
  if @t_trn <> 1610
     and @i_operacion = 'I'
  begin
    exec sp_cerror
      @t_from = @w_sp_name,
      @i_msg  = 'TRANSACCION PARA VALIDACION DE HUELLA NO AUTORIZADA',
      @i_sev  = 0,
      @i_num  = 103005

    return 103005
  end

  select
    @w_titularidad = ah_ctitularidad
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_ref

  if @i_operacion = 'I'
  begin
    exec @w_return = cobis..sp_consulta_homini
      @s_term        = @s_term,
      @s_ofi         = @s_ofi,
      @i_user        = @i_user,
      @i_sec_cobis   = @s_ssn,
      @i_trn         = @i_trn,
      @i_operacion   = @i_operacion,
      @i_titularidad = @w_titularidad,
      @i_tipo_ced    = @i_tipo_ced,
      @i_ced_ruc     = @i_ced_ruc,
      @i_id_caja     = @i_id_caja,
      @i_ref         = @i_ref,
      @t_trn         = 1608

    if @w_return <> 0
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_msg  = 'ERROR REGISTRANDO DOCUMENTO',
        @i_sev  = 0,
        @i_num  = @w_return

      return @w_return
    end
  end

  if @t_trn <> 1610
     and @i_operacion = 'V'
  begin
    exec sp_cerror
      @t_from = @w_sp_name,
      @i_msg  = 'TRANSACCION PARA VALIDACION DE HUELLA NO AUTORIZADA',
      @i_sev  = 0,
      @i_num  = 103005

    return 103005
  end

  if @i_operacion = 'V'
  begin
    --REQ465 OCTUBRE/2014
    if not exists(select
                    1
                  from   cobis..cl_val_iden
                  where  vi_transaccion = @i_trn
                     and vi_estado      = 'V'
                     and vi_ind_causal  = 'N')
       and @t_corr <> 'S'
    begin
      return 0
    end

    exec @w_return = cobis..sp_consulta_homini
      @s_term        = @s_term,
      @s_ofi         = @s_ofi,
      @t_trn         = 1608,
      @i_trn         = @i_trn,
      @i_operacion   = @i_operacion,
      @i_user        = @i_user,
      @i_id_caja     = @i_id_caja,
      @i_tipo_ced    = @i_tipo_ced,
      @i_ced_ruc     = @i_ced_ruc,
      @i_ref         = @i_ref,
      @i_titularidad = @w_titularidad,
      @i_sec_cobis   = @s_ssn,
      @o_codigo      = @w_codigo out,
      @o_mensaje     = @w_mensaje out,
      @o_tipo_ced    = @o_tipo_ced out,
      @o_ced_ruc     = @o_ced_ruc out

    if @w_return <> 0
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_msg  = 'ERROR VALIDANDO IDENTIDAD CLIENTE',
        @i_sev  = 0,
        @i_num  = @w_return

      return @w_return
    end

    if @w_codigo <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = @w_mensaje,
        @i_num   = @w_codigo

      return @w_codigo
    end
  end

go

