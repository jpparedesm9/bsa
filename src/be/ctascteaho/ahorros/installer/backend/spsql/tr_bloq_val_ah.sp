use cob_ahorros
go

/************************************************************************/
/*   Archivo:            tr_bloq_val_ah.sp                              */
/*   Stored procedure:   sp_tr_bloq_val_ah                              */
/*   Base de datos:      cob_ahorros                                    */
/*   Producto:           Cuentas de Ahorros                             */
/*   Disenado por:       Mauricio Bayas/Sandra Ortiz                    */
/*   Fecha de escritura: 02-Mar-1993                                    */
/************************************************************************/
/*                           IMPORTANTE                                 */
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
/*                            PROPOSITO                                 */
/*   Este programa realiza la transaccion de bloqueos a valores y       */
/*   levantamiento de bloqueos de valores de cuentas de ahorros.        */
/*   217 = Bloqueos de valores a la cuenta                              */
/*   218 = Levantamiento de bloqueos de valores                         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR           RAZON                              */
/*   02/Mar/1993    P Mena          Emision inicial                     */
/*   04/Dic/1994    J. Bucheli      Personalizacion para Banco de       */
/*                                  la Produccion                       */
/*   06/Jul/1995    A. Villarreal   Personalizacion B. de Prestamos     */
/*   06/Set/1998    G. George       Aumento del parametro @i_observacion*/
/*   02/Nov/1999    V.Molina E.     Aumento de prod_banc y Categoria    */
/*   19/Oct/2000    Cruz Quiaro     Agregar parametro @o_siguiente      */
/*                                  para Conexion Bancaribe             */
/*   10/Feb/2010    O. Usiña        Agrega Embargos                     */
/*   02/Mayo/2016   Walther Toledo  Migración a CEN                     */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_bloq_val_ah')
  drop proc sp_tr_bloq_val_ah
go

create proc sp_tr_bloq_val_ah
(
  @s_ssn          int,
  @s_ssn_branch   int= null,
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
  @i_accion       char(1),
  @i_causa        char(3) = '1',
  @i_valor        money,
  @i_sec          int = null,
  @i_aut          descripcion,
  @i_solicit      descripcion = null,
  @i_plazo        smallint = null,
  @i_observacion  varchar(120) = null,
  @i_automatico   char(1) = 'N',
  @o_fecha_ven    smalldatetime = null out,
  @i_turno        smallint = null,
  @i_ngarantia    char(25) = null,
  @i_nlinea_sob   varchar(24) = null,
  @i_valida_saldo char(1) = 'N',
  @i_numcte       varchar(24) = null,
  @o_siguiente    int = null out,
  @o_prod_banc    tinyint = null OUT,
  @o_no_bloq      char(1) = null OUT
)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(30),
    @w_rpc           descripcion,
    @w_filial        tinyint,
    @w_oficina       smallint,
    @w_producto      tinyint,
    @w_srv_rem       descripcion,
    @w_srv_local     descripcion,
    @w_tipo          char(1),
    @w_fecha_ven     smalldatetime,
    @w_oficina_cta   smallint,
    @w_prod_banc     tinyint,
    @w_categoria     char(1),
    @w_tipocta_super char(1),
    @w_prod_banc_pcaasa int,     
    @w_prod_banc_pcaaso INT,
    @w_o_no_bloq     CHAR(1)

  /*Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_tr_bloq_val_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  select
    @s_ssn_branch = isnull(@s_ssn_branch,
                           @s_ssn)

  if @i_turno is null
    select
      @i_turno = @s_rol

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
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
      i_accion = @i_accion,
      i_valor = @i_valor,
      i_aut = @i_aut,
      i_solicit = @i_solicit,
      i_plazo = @i_plazo,
      i_observa = @i_observacion
    exec cobis..sp_end_debug
  end

  /* Chequeo de errores generados remotamente */
  if @s_org_err is not null /* Error del Sistema */
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @s_error,
      @i_sev   = @s_sev,
      @i_msg   = @s_msg
    return 1
  end

  /*Captura de parametros de la oficina  */
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
    @w_rpc = 'sp_bloq_val_ah'

  if @w_tipo = 'L'
    select
      @w_rpc = 'cob_ahorros..' + @w_rpc
  else
    select
      @w_rpc = @w_srv_local + '.' + @w_srv_rem + '.' + 'cob_ahorros.' + @w_rpc

  select
    @w_fecha_ven = dateadd(day,
                           @i_plazo,
                           @s_date)
  SELECT @w_o_no_bloq = 'N'
  begin tran
  exec @w_return = @w_rpc
    @s_ssn           = @s_ssn,
    @s_ssn_branch    = @s_ssn_branch,
    @s_date          = @s_date,
    @s_sesn          = @s_sesn,
    @s_org           = @s_org,
    @s_srv           = @s_srv,
    @s_lsrv          = @s_lsrv,
    @s_user          = @s_user,
    @s_term          = @s_term,
    @s_ofi           = @s_ofi,
    @s_rol           = @s_rol,
    @s_org_err       = @s_org_err,
    @s_error         = @s_error,
    @s_sev           = @s_sev,
    @s_msg           = @s_msg,
    @t_debug         = @t_debug,
    @t_file          = @t_file,
    @t_from          = @t_from,
    @t_rty           = @t_rty,
    @t_trn           = @t_trn,
    @i_cta           = @i_cta,
    @i_mon           = @i_mon,
    @i_accion        = @i_accion,
    @i_causa         = @i_causa,
    @i_valor         = @i_valor,
    @i_sec           = @i_sec,
    @i_aut           = @i_aut,
    @i_solicit       = @i_solicit,
    @i_plazo         = @i_plazo,
    @i_observacion   = @i_observacion,
    @i_automatico    = @i_automatico,
    @i_turno         = @i_turno,
    @i_ngarantia     = @i_ngarantia,
    @i_nlinea_sob    = @i_nlinea_sob,
    @i_valida_saldo  = @i_valida_saldo,
    @i_numcte        = @i_numcte,
    @o_fecha_ven     = @o_fecha_ven out,
    @o_oficina_cta   = @w_oficina_cta out,
    @o_prod_banc     = @w_prod_banc out,
    @o_categoria     = @w_categoria out,
    @o_siguiente     = @o_siguiente out,
    @o_tipocta_super = @w_tipocta_super out,
    @o_no_bloq       = @o_no_bloq out

  if @w_return <> 0
  BEGIN
    rollback tran
    return @w_return
  end
  select
    @o_prod_banc = @w_prod_banc
    
  select  @o_no_bloq   = @o_no_bloq
  
  select @w_prod_banc_pcaasa = pa_int 
  from  cobis..cl_parametro 
  where  pa_producto = 'AHO' 
     and pa_nemonico = 'PCAASA' 
  
  select @w_prod_banc_pcaaso = pa_int 
  from  cobis..cl_parametro 
  where  pa_producto = 'AHO' 
     and pa_nemonico = 'PCAASO'

  if @w_tipo = 'R'
  BEGIN
  
    /* Grabar transaccion de servicio local */
    if @t_trn = 217
    BEGIN
   
      /* Creacion de transaccion de servicio */
      insert into cob_ahorros..ah_tsbloqueo
                  (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
                   terminal,oficina,reentry,origen,cta_banco,
                   fecha,valor,accion,causa,autorizante,
                   moneda,hora,solicitante,fecha_vencim,oficina_cta,
                   observacion,prod_banc,categoria,tipocta_super,turno)
      values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
                   @s_term,@s_ofi,@t_rty,@s_org,@i_cta,
                   @s_date,@i_valor,'B',@i_causa,@i_aut,
                   @i_mon,getdate(),@i_solicit,@w_fecha_ven,@w_oficina_cta,
                   @i_observacion,@w_prod_banc,@w_categoria,@w_tipocta_super,
                   @i_turno)
      if @@error <> 0
      begin
        /* Error en creacion de transaccion de servicio */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 203005
        return 1
      end
    end
    else if @t_trn = 218
    begin
      /* Creacion de transaccion de servicio */
      insert into cob_ahorros..ah_tsbloqueo
                  (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
                   terminal,oficina,reentry,origen,cta_banco,
                   fecha,valor,accion,causa,autorizante,
                   moneda,hora,solicitante,fecha_vencim,oficina_cta,
                   prod_banc,categoria,tipocta_super,turno)
      values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
                   @s_term,@s_ofi,@t_rty,@s_org,@i_cta,
                   @s_date,@i_valor,'L',@i_causa,@i_aut,
                   @i_mon,getdate(),@i_solicit,@w_fecha_ven,@w_oficina_cta,
                   @w_prod_banc,@w_categoria,@w_tipocta_super,@i_turno)

      if @@error <> 0
      begin
        /*Error en creacion de transaccion de servicio */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 203005
        return 1
      end
    end
  end
  commit tran

go

