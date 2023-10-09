/************************************************************************/
/*   Archivo:       coclicom.sp                                         */
/*   Stored procedure:   sp_cons_cli_comp                               */
/*   Base de datos:      cobis                                          */
/*   Producto: Clientes                                                 */
/*   Disenado por:  Mauricio Bayas/Sandra Ortiz                         */
/*   Fecha de escritura: 26-May-1993                                    */
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
/*   Este programa realiza la consulta de la relacion entre un          */
/*   persona y la(s) empresa(s) con la(s) que tiene algun vinculo.      */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*   26-May-1993    P Mena         Emision inicial                      */
/*   03-Sep-1993    S Ortiz        Modificacion a las tablas de         */
/*                       relacion e instancias de                       */
/*                       relacion.                                      */
/*      12/Nov/93       R. Minga V.     Documentacion, verificacion de  */
/*                                      existencia.                     */
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
           where  name = 'sp_cons_cli_comp')
  drop proc sp_cons_cli_comp
go
create proc sp_cons_cli_comp
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
  @i_cli          int = null,
  @i_oper         char(1),
  @i_comp         int = null
)
as
  declare
    @w_sp_name varchar(30),
    @w_cliente int

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_cons_cli_comp'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
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
      i_cli = @i_cli,
      i_oper = @i_oper,
      i_comp = @i_comp
    exec cobis..sp_end_debug
  end

  if @t_trn = 1177
  begin
    /* Empresas relaciondas con una persona */
    if @i_oper = 'A'
    begin
      select
        @w_cliente = persona
      from   cobis..cl_persona
      where  persona = @i_cli
      if @@rowcount = 0
      begin
        /* No existe persona */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101043
        return 1
      end
      select
        'Codigo Compania' = in_ente_d,
        'Nombre' = en_nombre
      from   cobis..cl_instancia,
             cobis..cl_ente
      where  in_ente_i  = @i_cli
         and en_ente    = in_ente_d
         and en_subtipo = 'C'
      if @@rowcount = 0
      begin
        /* No existe relacion entre cliente y empresa */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101087
        return 1
      end
    end

    /* Existencia de relacion entre persona y empresa */
    if @i_oper = 'V'
    begin
      if not exists (select
                       *
                     from   cobis..cl_instancia
                     where  in_ente_i = @i_cli
                        and in_ente_d = @i_comp)
      begin
        /* No existe relacion entre cliente y empresa */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101087
        return 1
      end
      select
        en_nombre
      from   cobis..cl_ente
      where  en_ente = @i_comp
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

