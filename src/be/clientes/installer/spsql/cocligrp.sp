/************************************************************************/
/*   Archivo:       cocligrp.sp                                         */
/*   Stored procedure:   sp_cons_cli_grupo                              */
/*   Base de datos:      cobis                                          */
/*   Producto:           Clientes                                       */
/*   Disenado por:  Mauricio Bayas/Sandra Ortiz                         */
/*   Fecha de escritura: 14-Jun-1993                                    */
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
/*   cliente y lo(s) grupo(s) con lo(s) que tiene algun vinculo.        */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*   14-Jun-1993    S Ortiz        Emision inicial                      */
/*   06-Sep-1993    S Ortiz        Modificacion de cl_instancia y       */
/*                       y cl_relacion.                                 */
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
           where  name = 'sp_cons_cli_grupo')
  drop proc sp_cons_cli_grupo
go
create proc sp_cons_cli_grupo
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
  @i_ente         int = null,
  @i_oper         char(1),
  @i_grupo        int = null
)
as
  declare
    @w_sp_name varchar(30),
    @w_cliente int

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_cons_cli_grupo'

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
      i_ente = @i_ente,
      i_oper = @i_oper,
      i_grupo = @i_grupo
    exec cobis..sp_end_debug
  end

  if @t_trn = 1178
  begin
    /* Empresas relaciondas con un cliente */
    if @i_oper = 'A'
    begin
      select
        @w_cliente = en_ente
      from   cobis..cl_ente
      where  en_ente = @i_ente
      if @@rowcount = 0
      begin
        /* No existe cliente */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101146
        return 1
      end
      select distinct
        'Grupo' = gr_grupo,
        'Nombre' = gr_nombre
      from   cobis..cl_grupo
      where  gr_grupo in
             (select
                en_grupo
              from   cobis..cl_ente
              where  en_ente in
                     (select
                        in_ente_d
                      from   cl_instancia
                      where  in_ente_i = @i_ente))
      if @@rowcount = 0
      begin
        /* No existe relacion entre cliente y grupo */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101089
        return 1
      end
    end

    /* Existencia de relacion entre cliente y grupo */
    if @i_oper = 'V'
    begin
      if not exists (select
                       *
                     from   cobis..cl_ente
                     where  en_grupo = @i_grupo
                        and en_ente in
                            (select
                               in_ente_d
                             from   cobis..cl_instancia
                             where  in_ente_i = @i_ente))
      begin
        /* No existe relacion entre cliente y grupo */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101089
        return 1
      end
      select
        gr_nombre
      from   cobis..cl_grupo
      where  gr_grupo = @i_grupo
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

