/************************************************************************/
/*   Archivo:            clixtipo.sp                                    */
/*   Stored procedure:   sp_cliente_tipo_doc                            */
/*   Base de datos:      cobis                                          */
/*   Producto:           Clientes                                       */
/*   Disenado por:       Sara E. Meza                                   */
/*   Fecha de documentacion: 04-Dic-1996                                */
/************************************************************************/
/*                  IMPORTANTE                                          */
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
/*                  PROPOSITO                                           */
/*      Selecciona el numero del cliente y su nombre dado un tipo       */
/*      de cliente, un numero de ruc y un tipo de documento             */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*      04/Dic/96       S. Meza C.      Emsion Inicial                  */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
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
           where  name = 'sp_cliente_tipo_doc')
  drop proc sp_cliente_tipo_doc
go

create proc sp_cliente_tipo_doc
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_rol          smallint = null,
  @s_ofi          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_ruc          numero = null,
  @i_tipo_ced     char (2) = null,
  @i_tipo_cli     char (1) = null
)
as
  declare
    @w_sp_name  varchar(32),
    @w_tipo_ced char (2)

  select
    @w_sp_name = 'sp_cliente_tipo_doc'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/** Stored Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      s_org = @s_org,
      t_trn = @t_trn,
      t_file = @t_file,
      t_from = @t_from,
      i_ruc = @i_ruc,
      i_tipo_ced = @i_tipo_ced
    exec cobis..sp_end_debug
  end

  if @t_trn = 1314
  begin
    if @i_tipo_cli = 'P'
    begin
      select
        en_ente,
        p_p_apellido,
        p_s_apellido,
        en_nombre
      from   cl_ente
      where  en_ced_ruc  = @i_ruc
         and en_tipo_ced = @i_tipo_ced
         and en_subtipo  = 'P'

      if @@rowcount = 0
      begin
        select
          @@rowcount
      end
    end
    else
    begin
      --select @w_tipo_ced = substring(@i_tipo_ced, 1, 1)

      select
        en_ente,
        en_nombre
      from   cl_ente
      where  en_ced_ruc  = @i_ruc
             --and  c_tipo_nit = @w_tipo_ced
             and en_tipo_ced = @i_tipo_ced /*M. Silva.  Bco Estado. */
             and en_subtipo  = 'C'
      if @@rowcount = 0
      begin
        select
          @@rowcount
      end

    end
    return 0

  end
  else
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    /*  'No corresponde codigo de transaccion' */
    return 1
  end

go

