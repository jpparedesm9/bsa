/************************************************************************/
/*   Archivo:               clcobban.sp                                 */
/*   Stored procedure:      sp_cobro_bandom                             */
/*   Base de datos:         cobis                                       */
/*   Producto:              Clientes                                    */
/*      Disenado por:       Jenniffer Anaguano                          */
/*   Fecha de escritura:    09-May-2001                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*   Este programa realiza la transaccion de cobro de servicio de       */
/*      Banca Domiciliaria en Cuentas Corrientes y Cuentas de Ahorros   */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*      FECHA           AUTOR           RAZON                           */
/*   09/May/2001    J Anaguano      Emision inicial                     */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_cobro_bandom')
  drop proc sp_cobro_bandom
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_cobro_bandom
(
  @s_ssn          int,
  @s_ssn_branch   int = 0,
  @s_srv          varchar(30),
  @s_lsrv         varchar(30),
  @s_user         varchar(30),
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,/* Localidad origen transaccion */
  @s_rol          smallint = 1,
  @s_org_err      char(1) = null,/* Origen de error:[A], [S] */
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_ejec         char(1) = null,
  @t_show_version bit = 0,
  @i_operacion    char(1) = null,
  @i_filial       tinyint = null,
  @i_oficina      smallint = null,
  @i_ente         int = null,
  @i_producto_cta tinyint = null,
  @i_producto_ser tinyint = null,
  @i_cta          cuenta = null,
  @i_mon          tinyint = null,
  @i_causal       catalogo = null,
  @i_servicio     catalogo = null,
  @i_valor        money = null
)
as
  declare
    @w_return  int,
    @w_sp_name varchar(30),
    @w_cuenta  int

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_cobro_bandom'

  /* Modo de debug */
  if @i_operacion = 'I'
  begin
    if @t_trn <> 1446
    begin
      /* Error en codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201048
      return 1
    end

    if @i_producto_cta = 3
    begin
      select
        @w_cuenta = cc_ctacte
      from   cob_cuentas..cc_ctacte
      where  cc_cta_banco = @i_cta
         and cc_moneda    = @i_mon

      if @@rowcount <> 1
      begin
        /* No existe cuenta de corriente */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201004
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
        /* No existe cuenta de ahorros */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251001
        return 1
      end
    end
    /* Grabar en cl_trn_bandom */
    begin tran

    insert into cl_trn_bandom
                (tb_ente,tb_secuencial,tb_fecha,tb_servicio,tb_cta_banco,
                 tb_producto,tb_usuario,tb_terminal,tb_filial,tb_oficina)
    values      (@i_ente,@s_ssn,@s_date,@i_servicio,@i_cta,
                 @i_producto_ser,@s_user,@s_term,@i_filial,@i_oficina)

    if @@error <> 0
    begin
      /* Error en inserción de registro en cl_trn_bandom */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105092
      return 1
    end

    /*  Transaccion de Servicio  */
    insert into ts_trn_bandom
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,ente,secuencial2,
                 fecha2,servicio,producto,cta_banco,moneda,
                 usuario2,terminal2,filial,oficina)
    values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                 @s_term,@s_srv,@s_lsrv,@i_ente,@s_ssn,
                 @s_date,@i_servicio,@i_producto_ser,@i_cta,null,
                 @s_user,@s_term,@i_filial,@i_oficina)

    if @@error <> 0
    begin
      /*  Error en creacion de transaccion de servicio  */
      exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 103005
      return 1
    end

    /* Llamada a sp de Cte y Aho */
    if @i_producto_cta = 3
    begin
      /*  Generar la nota de debito por la retencion */
      exec @w_return = cob_cuentas..sp_ccndc_automatica
        @s_srv    = @s_srv,
        @s_ofi    = @i_oficina,
        @s_ssn    = @s_ssn,
        @s_user   = @s_user,
        @t_trn    = 50,
        @i_cta    = @i_cta,
        @i_val    = @i_valor,
        @i_cau    = @i_causal,
        @i_mon    = @i_mon,
        @i_alt    = 1,
        @i_valida = 1,
        @i_fecha  = @s_date
      if @w_return <> 0
        return @w_return
    end
    else
    begin
      exec @w_return = cob_ahorros..sp_ahndc_automatica
        @s_srv   = @s_srv,
        @s_ofi   = @i_oficina,
        @s_ssn   = @s_ssn,
        @s_user  = @s_user,
        @t_trn   = 264,
        @i_cta   = @i_cta,
        @i_val   = @i_valor,
        @i_cau   = @i_causal,
        @i_mon   = @i_mon,
        @i_fecha = @s_date,
        @i_tsn   = @s_ssn,
        @i_alt   = 1
      if @w_return <> 0
        return @w_return
    end
    commit tran
  end
  return 0

go

