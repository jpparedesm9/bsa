/************************************************************************/
/*  Archivo:            actualizacion_libreta.sp                        */
/*  Stored procedure:   sp_actualizacion_libreta                        */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 19-Feb-1993                                     */
/************************************************************************/
/*                      IMPORTANTE                                      */
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
/*                       PROPOSITO                                      */
/*  Este programa procesa las transacciones de:                         */
/*      Actualizacion de Lineas Pendientes.                             */
/************************************************************************/
/*                       MODIFICACIONES                                 */
/*  FECHA       AUTOR           RAZON                                   */
/*  19/Feb/1993 J Navarrete     emision inicial                         */
/*  20/Jun/2001 R. Penarreta    Branch II                               */
/*  10/May/2006 P. Coello       Ordenar por fecha y secuencial          */
/*  26/May/2006 P. Coello       No imprimir todos los registros         */
/*                              de golpe dado que esto llena el         */
/*                              buffer de 4k del kernel se devuelve     */
/*                              de 24 en 24                             */
/*  2006/11/Ago Pedro Coello R. Actualizacion de totales                */
/*  2006/13/Nov Pedro Coello R. Actualizar todas las lineas             */
/*                              pero solo devolver las 5 ultimas        */
/*  2006/14/Nov Anayansi Riggs  Correccion en el ordenamiento           */
/*                              de las lineas a imprimir                */
/*  21-Dic-2006 Pedro Coello    Enviar cant. lineas a                   */
/*                              imprimir                                */
/*  02/Ma/2016  Ignacio Yupa    Migración a CEN                         */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_actualizacion_libreta')
  drop proc sp_actualizacion_libreta
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_actualizacion_libreta
(
  @s_ssn          int,
  @s_ssn_branch   int = null,
  @s_srv          varchar(30),
  @s_user         varchar(30),
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_sev          tinyint,
  @s_org          char(1),
  @s_ofi          int,
  @s_rol          smallint,
  @p_sp           char(1),  
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          int,
  @t_ejec         char(1) = null,
  @t_corr         char(1) = 'N',
  @t_show_version bit = 0,
  @i_turno        smallint = null,
  @i_sld_caja     money = 0,
  @i_idcierre     int = 0,
  @i_filial       smallint = 1,
  @i_idcaja       int = 0,
  @i_primera_ejec char(1) = 'N',
  @i_cta          cuenta,
  @i_sld_lib      money,
  @i_nctrl        int,
  @i_mon          tinyint,
  @i_usateller    char(1)='N',
  @i_cant_lineas  int = 5,
  --PCOELLO EL USUARIO ESCOGE LA CANTIDAD DE LINEAS A IMPRIMIR
  @o_sldlib       money out,
  @o_num          int out,
  @o_nctrl        smallint out,
  @o_nombre       varchar(30) = null out
)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(30),
    @w_cuenta        int,
    @w_filial_p      tinyint,
    @w_oficina_p     smallint,
    @w_factor        int,
    @w_tmp           int,
    @w_linea         smallint,
    @w_sec           int,
    @w_sld_lib       money,
    @w_valor         money,
    @w_control       int,
    @w_enviada       char(1),
    @w_signo         char(1),
    @w_tipo_promedio char(1),
    @w_oficial       smallint,
    @w_nombre        varchar(30),
    @w_cont          int,
    @w_oficina_cta   int,
    @w_prod_banc     smallint,
    @w_categoria     char(1),
    @w_moneda        smallint,
    @w_tipocta_super char(1),
    @w_cant_act      int

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_actualizacion_libreta'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_sev = @s_sev,
      t_debug = @t_debug,
      t_from = @t_from,
      t_file = @t_file,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_sld_lib = @i_sld_lib,
      i_nctrl = @i_nctrl,
      i_mon = @i_mon
    exec cobis..sp_end_debug
  end

  /*  Determinacion de vigencia de cuenta  */
  exec @w_return = cob_ahorros..sp_ctah_vigente
    @t_debug         = @t_debug,
    @t_file          = @t_file,
    @t_from          = @w_sp_name,
    @i_cta_banco     = @i_cta,
    @i_moneda        = @i_mon,
    @o_cuenta        = @w_cuenta out,
    @o_filial        = @w_filial_p out,
    @o_oficina       = @w_oficina_p out,
    @o_tipo_promedio = @w_tipo_promedio out,
    @o_oficial       = @w_oficial out
  if @w_return <> 0
    return @w_return

  select
    @w_linea = ah_linea,
    @w_control = ah_control,
    @w_sld_lib = ah_saldo_libreta,
    @w_nombre = ah_nombre,
    @w_oficina_cta = ah_oficina,
    @w_prod_banc = ah_prod_banc,
    @w_categoria = ah_categoria,
    @w_moneda = ah_moneda,
    @w_tipocta_super = ah_tipocta_super
  from   cob_ahorros..ah_cuenta
  where  ah_cuenta = @w_cuenta

  if @i_cant_lineas <> 0
    --PCOELLO SI SOLO SE PIDE IMPRIMIR LAS 5 ULTIMAS ENTONCES SE ACTUALIZAN TODAS LAS LAS LINEAS COMO YA 
    --IMPRESAS
    select
      @w_cant_act = 500
  else
    select
      @w_cant_act = 24

  if @i_usateller = 'N'
    select
      @w_cont = @w_cant_act
  else
  begin
    if @t_trn = 265
      select
        @w_cont = @w_cant_act
    else
      select
        @w_cont = 7
  end

  if @i_turno is null
    select
      @i_turno = @s_rol

  if @w_linea = 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251006
    return 251006
  end
  else if @w_linea > @w_cont
     and @t_trn <> 265
     and @i_usateller <> 'N'
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251083
    return 251083
  end

  select
    @o_nombre = @w_nombre

  if @w_control <> @i_nctrl
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251004
    return 251004
  end

  if convert(char(30), @w_sld_lib) <> convert(char(30), @i_sld_lib)
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251005
    return 251005
  end

  begin tran

  select
    @w_tmp = 1

  while @w_tmp <= @w_linea
        and @w_tmp < (@w_cont + 1)
  begin
    set rowcount 1
    select
      @w_valor = lp_valor,
      @w_signo = lp_signo,
      @w_sec = lp_linea,
      @w_control = lp_control
    from   cob_ahorros..ah_linea_pendiente
    where  lp_cuenta  = @w_cuenta
       and lp_enviada = 'N'
    order  by lp_fecha,
              lp_linea --PCOELLO A-ADIR FECHA EN EL ORDENAMIENTO

    if @@rowcount <> 1
      if @w_tmp = 1
      --PCOELLO SOLO MANDA EL ERROR SI ES LA PRIMERA VEZ Y NO HAY LINEAS
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251035
        return 251035
      end
      else
        return 0

    set rowcount 0

    if @w_signo = 'C'
      select
        @w_sld_lib = @w_sld_lib + @w_valor
    else
      select
        @w_sld_lib = @w_sld_lib - @w_valor

    update cob_ahorros..ah_cuenta
    set    ah_saldo_libreta = @w_sld_lib,
           ah_control = @w_control,
           ah_linea = @w_linea - @w_tmp
    where  ah_cuenta = @w_cuenta

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255001
      return 255001
    end

    insert into #lpendiente
                (fecha,valor,saldo,control,nemonico,
                 signo,lp_linea)
      select
        convert(varchar(10), lp_fecha, 101),
        --convert(varchar(10), lp_fecha, 103)  ARiggs 11/14/06
        lp_valor,@w_sld_lib,lp_control,lp_nemonico,
        @w_signo,@w_sec
      from   cob_ahorros..ah_linea_pendiente
      where  lp_cuenta  = @w_cuenta
         and lp_linea   = @w_sec
         and lp_enviada = 'N'

    update cob_ahorros..ah_linea_pendiente
    set    lp_enviada = 'S'
    where  lp_cuenta  = @w_cuenta
       and lp_linea   = @w_sec
       and lp_enviada = 'N'

    if @@rowcount <> 1
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255002
      return 255002
    end

    select
      @w_tmp = @w_tmp + 1
    continue
  end

  commit tran

  /******PCOELLO INSERTAR EN UNA TABLA TEMPORAL SOLO LOS ULTIMOS 5 REGISTROS DE LAS LINEAS PENDIENTES *****/
  set rowcount @i_cant_lineas

  insert into #lpendiente_5ult
    select
      fecha,valor,saldo,control,nemonico,
      signo,lp_linea --into #lpendiente_5ult 
    from   #lpendiente
    order  by fecha desc,
              lp_linea desc

  insert into #lpendiente_def
    select
      fecha,valor,saldo,control,nemonico,
      signo -- into #lpendiente_def
    from   #lpendiente_5ult
    order  by fecha,
              lp_linea

  set rowcount 0
  /******PCOELLO INSERTAR EN UNA TABLA TEMPORAL SOLO LOS ULTIMOS 5 REGISTROS DE LAS LINEAS PENDIENTES *****/

  if @i_usateller = 'N'
    select
      convert(varchar(10), fecha, 101),
      valor,
      saldo,
      control,
      nemonico,
      signo --ARiggs 11/14/06
    from   #lpendiente_def

  if @p_sp = 'S'
     and @i_usateller = 'N'
  begin
    select
      @o_num = @w_linea - @w_tmp + 1,
      @o_sldlib = @w_sld_lib,
      @o_nctrl = @w_control

    return 2
  end
  else
  begin
    select
      @w_nombre
    select
      @o_sldlib = @w_sld_lib,
      @o_nctrl = @w_control,
      @o_num = @w_linea - @w_tmp + 1
  end

  if @w_tmp < (@w_cont + 1)
     and @i_usateller = 'N'
  begin
    select
      @o_sldlib = 0,
      @o_nctrl = 0
  end

  /*****PEDRO COELLO AFECTACION DE TOTALES ****/
  if @s_org = 'U'
     and isnull(@i_primera_ejec,
                'N') = 'N'
  begin
    insert into ah_tran_servicio
                (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                 ts_usuario,
                 ts_terminal,ts_ctacte,ts_filial,ts_valor,ts_oficina,
                 ts_oficina_cta,ts_prod_banc,ts_categoria,ts_moneda,
                 ts_tipocta_super
                 ,
                 ts_turno,ts_saldo,ts_cta_banco)
    values      (@s_ssn,@s_ssn,@t_trn,@s_date,@s_user,
                 @s_term,@w_cuenta,@i_filial,0,@s_ofi,
                 @w_oficina_cta,@w_prod_banc,@w_categoria,@w_moneda,
                 @w_tipocta_super
                 ,
                 @i_turno,@o_sldlib,@i_cta)
    --pcoello graba tambien el interes capitalizado solo como referencia

    if @@error <> 0
    begin
      /* Error en insercion de transaccion servicio */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253004
      return 253004
    end

    exec @w_return = cob_remesas..sp_upd_totales -- ELI 14/11/2002
      @i_ofi          = @s_ofi,
      @i_rol          = @i_turno,
      @i_user         = @s_user,
      @i_mon          = @i_mon,
      @i_trn          = @t_trn,
      @i_nodo         = @s_srv,
      @i_tipo         = 'L',
      @i_corr         = @t_corr,
      @i_efectivo     = 0,
      @i_cheque       = 0,
      @i_chq_locales  = 0,
      @i_chq_ot_plaza = 0,
      @i_ssn          = @s_ssn,
      @i_cta_banco    = @i_cta,
      @i_filial       = @i_filial,-- ELI 14/11/2002
      @i_idcaja       = @i_idcaja,
      @i_idcierre     = @i_idcierre,
      @i_saldo_caja   = @i_sld_caja -- FIN ELI 14/11/2002

    if @w_return <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 205000
      return 205000
    end
  end

  return 0

go

