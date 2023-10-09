use cob_ahorros
go

/************************************************************************/
/*  Archivo:            tr_bloqueo_mov_ah.sp                            */
/*  Stored procedure:   sp_tr_bloqueo_mov_ah                            */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 24-Feb-1993                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/************************************************************************/
/*                               PROPOSITO                              */
/*  Este programa realiza la transaccion de bloqueos movimientos        */
/*  y levantamiento de bloqueos de cuentas de ahorros.                  */
/*  211 = Bloqueos de movimientos a la cuenta                           */
/*  212 = Levantamiento de bloqueos de movimientos                      */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*   FECHA           AUTOR           RAZON                              */
/*  24/Feb/1993     P Mena          Emision inicial                     */
/*  03/Dic/1994     J. Bucheli      Personalizacion para Banco de       */
/*                                  la Produccion                       */
/*  06/Jul/1995     A. Villarreal   Personalizacion B. de Prestamos     */
/*  16/Set/1998     G. George       Aumento del parametro               */
/*                                  @i_observacion                      */
/*  18/Ene/2010     O. Usina        Embargos Cta. Ahorros               */
/*  02/Mayo/2016    Walther Toledo  Migración a CEN                     */
/*  22/Sep/2016     T. Baidal       Validacion si es batch y se inicio  */
/*                                  una transaccion se hace commit para */
/*                                  no inconsistencia de num de transac */  
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_bloqueo_mov_ah')
  drop proc sp_tr_bloqueo_mov_ah
go

create proc sp_tr_bloqueo_mov_ah
(
  @s_ssn          int,
  @s_ssn_branch   int = null,
  @s_srv          varchar(30),
  @s_lsrv         varchar(30),
  @s_user         varchar(30),
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_ofi          smallint,/* Localidad origen transaccion */
  @s_rol          smallint = 1,
  @s_org_err      char(1) = null,/* Origen de ERROR: [A], [S] */
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @s_org          char(1),
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_cta          cuenta,
  @i_mon          tinyint,
  @i_tbloq        char(3) = null,
  @i_aut          descripcion,
  @i_causa        char(3),
  @i_solicit      descripcion,
  @i_observacion  varchar(120) = null,
  @i_turno        smallint = null,
  @i_batch        char(1) = 'N',
  @o_secuencial   int = null out,
  @o_prod_banc    smallint = null out
)
as
  declare
    @w_return      int,
    @w_sp_name     varchar(30),
    @w_rpc         descripcion,
    @w_secuencial  int,
    @w_cuenta      int,
    @w_filial      tinyint,
    @w_oficina     smallint,
    @w_producto    tinyint,
    @w_srv_rem     descripcion,
    @w_srv_local   descripcion,
    @w_tipo        char(1),
    @w_oficina_cta smallint,
    @w_pais        varchar(10),
    @w_cont_lev    int,
    @w_debug       char(1),
	@w_error      int,
    @w_mensaje    varchar(132),
	@w_sev        tinyint,
	@w_tran_local char(1)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_tr_bloqueo_mov_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  select
    @s_ssn_branch = isnull(@s_ssn_branch,
                           @s_ssn)

  select
    @w_debug = 'N'

  if @w_debug = 'S'
  begin
    print '@i_cta: ' + @i_cta + ' @i_tbloq: ' + @i_tbloq + ' @i_causa: ' +
          @i_causa +
          ' @t_trn: '
          + cast(@t_trn as varchar)
  end

  if @i_turno is null
    select
      @i_turno = @s_rol

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
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
      s_ori = @s_org,
      t_from = @t_from,
      t_file = @t_file,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_mon = @i_mon,
      i_tbloq = @i_tbloq,
      i_aut = @i_aut,
      i_observa = @i_observacion
    exec cobis..sp_end_debug
  end

  /* Chequeo de errores generados remotamente */
  if @s_org_err is not null /* Error del Sistema */
  begin
    select @w_error     = @s_error,
	       @w_sev       = @s_sev,
		   @w_mensaje   = @s_msg
    goto ERROR
  end

  /*  Captura de parametros de la oficina  */
  exec @w_return = cobis..sp_parametros
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @s_lsrv         = @s_lsrv,
    @i_nom_producto = 'CUENTA%AHORROS',
    @o_oficina      = @w_oficina out,
    @o_producto     = @w_producto out

  if @w_return <> 0
    return @w_return

  /* Consulta el Pais*/
  select
    @w_pais = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'ABPAIS'

  /*  Determinacion de condicion de local o remoto  */
  exec @w_return = cob_ahorros..sp_cta_origen
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_cta       = @i_cta,
    @i_producto  = @w_producto,
    @i_mon       = @i_mon,
    @i_oficina   = @w_oficina,
    @o_tipo      = @w_tipo out,
    @o_srv_local = @w_srv_local out,
    @o_srv_rem   = @w_srv_rem out
  
  if @w_return <> 0
    return @w_return

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      origen = @s_org,
      tipo = @w_tipo,
      srv_loc = @w_srv_local,
      srv_rem = @w_srv_rem
    exec cobis..sp_end_debug
  end

  select
    @w_srv_local = @s_lsrv

  select
    @w_rpc = 'sp_bloqueo_mov_ah'
  if @w_tipo = 'L'
    select
      @w_rpc = 'cob_ahorros..' + @w_rpc
  else
    select
      @w_rpc = @w_srv_local + '.' + @w_srv_rem + '.' + 'cob_ahorros.' + @w_rpc

  begin tran
  select @w_tran_local = 'S' --Es S cuando se realiza begin tran
  
  exec @w_return = @w_rpc
    @s_ssn         = @s_ssn,
    @s_ssn_branch  = @s_ssn_branch,
    @s_date        = @s_date,
    @s_sesn        = @s_sesn,
    @s_org         = @s_org,
    @s_srv         = @s_srv,
    @s_user        = @s_user,
    @s_term        = @s_term,
    @s_ofi         = @s_ofi,
    @s_rol         = @s_rol,
    @s_org_err     = @s_org_err,
    @s_error       = @s_error,
    @s_sev         = @s_sev,
    @s_msg         = @s_msg,
    @t_debug       = @t_debug,
    @t_file        = @t_file,
    @t_from        = @t_from,
    @t_rty         = @t_rty,
    @t_trn         = @t_trn,
    @i_cta         = @i_cta,
    @i_mon         = @i_mon,
    @i_tbloq       = @i_tbloq,
    @i_aut         = @i_aut,
    @i_causa       = @i_causa,
    @i_solicit     = @i_solicit,
    @i_turno       = @i_turno,
    @o_oficina_cta = @w_oficina_cta out,
    @i_observacion = @i_observacion,
    @o_secuencial  = @o_secuencial out,
    @i_cod_pais    = @w_pais,
    @o_prod_banc   = @o_prod_banc
   
  if @w_return <> 0
  begin
    if @i_batch = 'N'
	begin
	    rollback tran
	end
	else if @i_batch = 'S' and @w_tran_local = 'S'
	    commit tran
		
    return @w_return
  end

  if @w_tipo = 'R'
  begin
    /* Grabar transaccion de servicio local */
    if @t_trn = 211
    begin
      /* Creacion de transaccion de servicio */
      insert into cob_ahorros..ah_tsbloqueo
                  (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
                   terminal,oficina,reentry,origen,cta_banco,
                   tipo_bloqueo,fecha,moneda,autorizante,estado,
                   causa,hora,solicitante,oficina_cta,observacion,
                   turno)
      values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
                   @s_term,@s_ofi,@t_rty,@s_org,@i_cta,
                   @i_tbloq,@s_date,@i_mon,@i_aut,'V',
                   @i_causa,getdate(),@i_solicit,@w_oficina_cta,@i_observacion,
                   @i_turno)
      if @@error <> 0
      begin
        /* Error en creacion de transaccion de servicio */
		select @w_error = 203005
		goto ERROR
      end
    end
    else if @t_trn = 212
    begin
      /* Creacion de transaccion de servicio */
      insert into cob_ahorros..ah_tsbloqueo
                  (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
                   terminal,oficina,reentry,origen,cta_banco,
                   tipo_bloqueo,fecha,moneda,autorizante,estado,
                   causa,hora,solicitante,oficina_cta,turno)
      values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
                   @s_term,@s_ofi,@t_rty,@s_org,@i_cta,
                   @i_tbloq,@s_date,@i_mon,@i_aut,'C',
                   @i_causa,getdate(),@i_solicit,@w_oficina_cta,@i_turno)
      if @@error <> 0
      begin
        /* Error en creacion de transaccion de servicio */
		select @w_error = 203005
		goto ERROR
      end
    end
  end
  commit tran

return 0

ERROR:
if @i_batch = 'N'
begin
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_error,
    @i_msg   = @w_mensaje,
	@i_sev   = @w_sev
end
return @w_error


go

