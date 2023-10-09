/************************************************************************/
/*  Archivo:        masiva.sp                                           */
/*  Stored procedure:   sp_creacion_masiva                              */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:       Jaime Loyo Holguin                              */
/*  Fecha de escritura:     06-May-1998                                 */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones del stored procedure        */
/*  Es la creacion masiva de personas o companias desde la  tabla       */
/*  re_masiva de cob_remesasa                                           */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  25/Oct/96   J. Loyo.    Emision Inicial                             */
/*  04/May/2016 T. Baidal   Migracion a CEN                             */
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
           where  name = 'sp_creacion_masiva')
    drop proc sp_creacion_masiva
go

create proc sp_creacion_masiva
(
  @s_ssn            int = null,
  @s_user           login = null,
  @s_term           varchar(30) = null,
  @s_date           datetime = null,
  @s_srv            varchar(30) = null,
  @s_lsrv           varchar(30) = null,
  @s_ofi            smallint = null,
  @t_debug          char(1) = 'N',
  @t_file           varchar(10) = null,
  @t_from           varchar(32) = null,
  @t_show_version   bit = 0,
  @i_operacion      char(1) = null,
  @i_filial         tinyint = null,
  @i_oficina        smallint,
  @i_oficial        smallint,
  @i_tipo_doc       char(2),
  @i_subtipo        char(1),
  @i_cedula         varchar(30),
  @i_nombre         descripcion,
  @i_papellido      varchar(32) = null,
  @i_sapellido      varchar(32) = null,
  @i_depto_dir      smallint = null,
  @i_ciudad_dir     int = null,
  @i_desc_dir       varchar(255)= null,
  @i_tipo_dir       catalogo = null,
  @i_secuencial     int,
  @o_ente           int = null out,
  @o_dir            smallint = null out,
  @o_msj_error      varchar(64) = null out,
  @o_producto_error tinyint = null out
)
as
  declare
    @w_sp_name varchar(32),
    @w_ente    int,
    @w_return  int,
    @w_retorno int

  select
    @w_sp_name = 'sp_creacion_masiva'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_operacion = 'I'
  begin
    begin tran
    if @i_subtipo = 'P'
    begin
      exec @w_retorno = cobis..sp_persona_no_ruc
        @t_file = @t_file
      select
        '/**Stored Procedure**/ ' = @w_sp_name,
        s_ssn = @s_ssn,
        s_user = @s_user,
        s_term = @s_term,
        s_date = @s_date,
        s_srv = @s_srv,
        s_lsrv = @s_lsrv,
        s_ofi = @s_ofi,
        t_debug = @t_debug,
        t_from = @t_from,
        t_trn = 1288,
        i_operacion = 'I',
        i_oficina = @i_oficina,
        i_filial = 1,/*@i_filial,*/
        i_oficial = @i_oficial,
        i_tipo_ced = @i_tipo_doc,
        i_cedula = @i_cedula,
        i_nombre = @i_nombre,
        i_papellido = @i_papellido,
        i_sapellido = @i_sapellido,
        o_ente = @o_ente

      if @w_retorno <> 0
      begin
        select
          @o_msj_error = 'No se inserto el cliente',
          @o_producto_error = 2
        return 1
      end
    end
    else if @i_subtipo = 'C'
    begin
      exec @w_retorno = cobis..sp_compania_no_ruc
        @t_file = @t_file
      select
        '/**Stored Procedure**/ ' = @w_sp_name,
        s_ssn = @s_ssn,
        s_user = @s_user,
        s_term = @s_term,
        s_date = @s_date,
        s_srv = @s_srv,
        s_lsrv = @s_lsrv,
        s_ofi = @s_ofi,
        t_debug = @t_debug,
        t_from = @t_from,
        t_trn = 1240,
        i_operacion = 'I',
        i_oficina = @i_oficina,
        i_filial = 1,/*@i_filial,*/
        i_oficial = @i_oficial,
        i_tipo_nit = @i_tipo_doc,
        i_ruc = @i_cedula,
        i_nombre = @i_nombre,
        o_ente = @o_ente
      if @w_retorno <> 0
      begin
        select
          @o_msj_error = 'No se inserto la compania',
          @o_producto_error = 2
        return 1
      end
    end
    else
    begin
      select
        @o_msj_error = 'Tipo de cliente no contemplado',
        @o_producto_error = 2
      return 1
    end
    /************   Creacion de direcciones ****************/
    if (@i_depto_dir is null
        and @i_ciudad_dir is null
        and @i_desc_dir is null
        and @i_tipo_dir is null)
    begin
      select
        @o_msj_error = 'Cliente sin Direccion ',
        @o_producto_error = 2
      return 0
    end
    else
    begin
      exec @w_retorno = cobis..sp_direccion_dml
        @t_file = @t_file
      select
        '/**Stored Procedure**/ ' = @w_sp_name,
        s_ssn = @s_ssn,
        s_user = @i_oficial,
        s_term = @s_term,
        s_date = @s_date,
        s_srv = @s_srv,
        s_lsrv = @s_lsrv,
        s_ofi = @s_ofi,
        t_debug = @t_debug,
        t_from = @t_from,
        t_trn = 109,
        i_operacion = 'I',
        i_oficina = @i_oficina,
        i_ente = @o_ente,
        i_descripcion = @i_desc_dir,
        i_tipo = @i_tipo_dir,
        i_ciudad = @i_ciudad_dir,
        --i_sector         = @i_depto_dir,
        i_provincia = @i_depto_dir,
        i_principal = 'S'
      if @w_retorno <> 0
      begin
        select
          @o_msj_error = 'No se inserto la direccion',
          @o_producto_error = 2
        return 1
      end
      else
      begin
        select
          @o_dir = 1
        return 0
      end
    end

    commit
    return 0

  end
  else
  begin
    print 'Tipo de Operacion no valida'
    return 0
  end

go

