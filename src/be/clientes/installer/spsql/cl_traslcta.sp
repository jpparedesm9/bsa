/************************************************************************/
/*   Archivo:            cltraslado.sp                                  */
/*   Stored procedure:   sp_traslado_cta                                */
/*   Base de datos:      cobis                                          */
/*   Producto:           Clientes                                       */
/*   Disenado por:       Diego Duran                                    */
/*   Fecha de escritura: 06-Sep-2004                                    */
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
/*                            PROPOSITO                                 */
/*   Este programa Realiza traslado de productos entre clientes         */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*   FECHA          AUTOR          RAZON                                */
/*   06/Sep/2004    D.Duran   Emision Inicial                           */
/*   20/Sep/2004    D.Duran        Optimizacion                         */
/*      13/Ene/2005 D.Duran        Adiciono Condicion Traslado          */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_traslado_cta')
  drop proc sp_traslado_cta
go

create proc sp_traslado_cta
(
  @s_ssn           int = null,
  @s_term          varchar(30) = null,
  @s_date          datetime = null,
  @s_srv           varchar(30) = null,
  @s_rol           smallint = null,
  @s_ofi           smallint = null,
  @s_org_err       char(1) = null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           descripcion = null,
  @s_org           char(1) = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(10) = null,
  @t_from          varchar(32) = null,
  @t_trn           smallint = null,
  @t_show_version  bit = 0,
  @i_user          login,
  @i_cliente_viejo int,
  @i_cliente_nuevo int,
  @i_producto      char(3),
  @i_cuenta        varchar(24)
)
as
  declare
    @w_sp_name       varchar(32),
    @w_lsrv          varchar(30),
    @w_sec           int,
    @w_anatjur       varchar(10),
    @w_pnatjur       varchar(10),
    @w_det_producto  int,
    @w_ced_nuevo     varchar(30),
    @w_ced_viejo     varchar(30),
    @w_cerror        int,
    @w_atipo_cliente varchar(10),
    @w_ptipo_cliente varchar(10),
    @w_atipo_persona char(1),
    @w_ptipo_persona char(1),
    @w_tipoced_viejo char(2),
    @w_tipoced_nuevo char(2)

  select
    @w_sp_name = 'sp_traslado_cta'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_lsrv = pa_char
  from   cl_parametro
  where  pa_nemonico = 'SRVR'
     and pa_producto = 'ADM'

  begin tran

  if @i_cliente_viejo = @i_cliente_nuevo
    print 'EL CLIENTE ORIGEN ES IGUAL AL DESTINO'

  /* Encuentra el SSN inicial */

  select
    @w_sec = se_numero
  from   cobis..ba_secuencial

  if @@rowcount <> 1
  begin
    /* Error en lectura de SSN */
    exec cobis..sp_cerror
      @i_num = 201163
    return 201163
  end

  update cobis..ba_secuencial
  set    se_numero = @w_sec + 1

  if @@rowcount <> 1
  begin
    /* Error en actualizacion de SSN */
    exec cobis..sp_cerror
      @i_num = 205031
    return 205031
  end

  select
    @w_anatjur = c_tipo_compania,
    @w_atipo_cliente = p_tipo_persona,
    @w_atipo_persona = en_subtipo,
    @w_ced_viejo = en_ced_ruc,
    @w_tipoced_viejo = en_tipo_ced
  from   cobis..cl_ente
  where  en_ente = @i_cliente_viejo

  if @@rowcount = 0
  begin
    print 'Cliente Viejo no Existe'
    exec cobis..sp_cerror
      @i_num = 101146
    return 101146
  end

  select
    @w_pnatjur = c_tipo_compania,
    @w_ptipo_cliente = p_tipo_persona,
    @w_ptipo_persona = en_subtipo,
    @w_ced_nuevo = en_ced_ruc,
    @w_tipoced_nuevo = en_tipo_ced
  from   cobis..cl_ente
  where  en_ente = @i_cliente_nuevo

  if @@rowcount = 0
  begin
    print 'Cliente Nuevo No existe'
    exec cobis..sp_cerror
      @i_num = 101146
    return 101146
  end

  select
    @w_det_producto = dp_det_producto
  from   cobis..cl_det_producto
  where  dp_cuenta = @i_cuenta

  if @@rowcount = 0
  begin
    print 'Cuenta No existe'
    exec cobis..sp_cerror
      @i_num = 201004
    return 201004
  end

  update cobis..cl_det_producto
  set    dp_cliente_ec = @i_cliente_nuevo
  where  dp_det_producto = @w_det_producto

  insert into ts_traslado_producto
              (secuencial,tipo_transaccion,clase,fecha,usuario,
               terminal,srv,lsrv,ente,det_producto,
               cod_producto,fecha_modificacion,subtipo,tipo_persona,
               tipo_sociedad)
  values      (@w_sec,1109,'A',getdate(),@i_user,
               'CORE',@w_lsrv,@w_lsrv,@i_cliente_viejo,@w_det_producto,
               @i_producto,getdate(),@w_atipo_persona,@w_atipo_cliente,
               @w_anatjur )

  update cobis..cl_cliente
  set    cl_cliente = @i_cliente_nuevo,
         cl_ced_ruc = @w_ced_nuevo
  where  cl_cliente      = @i_cliente_viejo
         /*** ADICIONO CONDICION TRASLADO DDU ENE/12/2005 ****/
         and cl_det_producto = @w_det_producto

  if @i_producto = 'AHO'
    update cob_ahorros..ah_cuenta
    set    ah_cliente = @i_cliente_nuevo,
           ah_cliente_ec = @i_cliente_nuevo,
           ah_ced_ruc = @w_ced_nuevo
    where  ah_cta_banco = @i_cuenta
           /*** ADICIONO CONDICION TRASLADO DDU ENE/12/2005 ****/
           and ah_cliente   = @i_cliente_viejo

  if @i_producto = 'CTE'
    update cob_cuentas..cc_ctacte
    set    cc_cliente = @i_cliente_nuevo,
           cc_cliente_ec = @i_cliente_nuevo,
           cc_ced_ruc = @w_ced_nuevo
    where  cc_cta_banco = @i_cuenta
           /*** ADICIONO CONDICION TRASLADO DDU ENE/12/2005 ****/
           and cc_cliente   = @i_cliente_viejo

  insert into ts_traslado_producto
              (secuencial,tipo_transaccion,clase,fecha,usuario,
               terminal,srv,lsrv,ente,det_producto,
               cod_producto,fecha_modificacion,subtipo,tipo_persona,
               tipo_sociedad)
  values      (@w_sec,1109,'P',getdate(),@i_user,
               'CORE',@w_lsrv,@w_lsrv,@i_cliente_nuevo,@w_det_producto,
               @i_producto,getdate(),@w_ptipo_persona,@w_ptipo_cliente,
               @w_pnatjur )

  commit tran

  return 0

go

