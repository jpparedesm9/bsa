/************************************************************************/
/*  Archivo:            compnom.sp                                      */
/*  Stored procedure:   sp_compara_nombre                               */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:   Ferrinson Franco. CORFINSURA.                       */
/*  Fecha de escritura: 10-Nov-1998                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*                             PROPOSITO                                */
/*  Realiza la verificacion de Nombres contra Referencias Inhibitorias  */
/*  e inserta en la tabla cl_lista_clinton                              */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA       AUTOR             RAZON                                 */
/*  10/Nov/98   Ferrinson Franco  Emision Inicial. CORFINSURA.          */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_compara_nombre')
  drop proc sp_compara_nombre
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_compara_nombre
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_modo         tinyint = null,
  @i_cod_ente     int = null,
  @i_cod_ref      int = null,
  @i_nomlar       varchar(64) = null,
  @i_nombre       varchar(37) = null,
  @i_p_apellido   varchar(16) = null,
  @i_tipo_cli     char(1) = null,
  @i_s_apellido   varchar(16) = null
)
as
  declare
    @w_today    datetime,
    @w_sp_name  varchar(32),
    @w_return   int,
    @w_nomlar   varchar (64),
    @w_p_nombre varchar(16),
    @w_s_nombre varchar(16),
    @w_codigo   int

  select
    @w_today = getdate()
  select
    @w_sp_name = 'sp_compara_nombre'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1378
  begin
    if @i_tipo_cli <> 'C'
       and @i_tipo_cli <> 'P'
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101114
      /* parametro invalido */
      return 1
    end

    set rowcount 1

    if @i_modo = 1 /** EVALUA CLIENTES CONTRA REFERENCIAS INHIBITORIAS **/
    begin
      if @i_tipo_cli = 'C'
      begin
        if @i_p_apellido <> ''
        begin
          select
            @w_nomlar = ltrim(rtrim(@i_p_apellido)) + '%'
          if @w_nomlar <> '%'
          begin
            insert into cl_lista_clinton
              select
                @i_cod_ente,@i_nombre,in_codigo,in_nomlar,'SIGLA'
              from   cl_refinh
              where  in_p_p_apellido like @w_nomlar
          end
        end

        select
          @w_nomlar = @i_nombre + '%'
        insert into cl_lista_clinton
          select
            @i_cod_ente,@i_nombre,in_codigo,in_nomlar,'RAZON SOCIAL '
          from   cl_refinh
          where  (in_nombre like @w_nomlar
               or in_nombre like @w_nomlar)
      end
      else
      begin
        select
          @w_nomlar = @i_p_apellido + ' ' + @i_s_apellido + ' ' + @i_nombre
        select
          @w_nomlar = ltrim( rtrim( @w_nomlar) ) + '%'
        insert into cl_lista_clinton
          select
            @i_cod_ente,@i_nomlar,in_codigo,in_nomlar,'NOMBRE COMPLETO'
          from   cl_refinh
          where  (in_nombre like @w_nomlar
               or in_nombre like @w_nomlar)

        select
          @w_nomlar = @i_p_apellido + ' ' + @i_nombre
        select
          @w_nomlar = ltrim( rtrim( @w_nomlar) ) + '%'
        insert into cl_lista_clinton
          select
            @i_cod_ente,@i_nomlar,in_codigo,in_nomlar,'PRIMER APELLIDO + NOMBRE'
          from   cl_refinh
          where  (in_nombre like @w_nomlar
               or in_nombre like @w_nomlar)
      end

    end
    if @i_modo = 2 /** EVALUA REFERENCIAS INHIBITORIAS CONTRA CLIENTES**/
    begin
      if @i_tipo_cli = 'C'
      begin
        if @i_p_apellido = ''
        begin
          select
            @w_nomlar = ltrim(rtrim(@i_p_apellido)) + '%'
          if @w_nomlar <> '%'
          begin
            insert into cl_lista_clinton
              select
                en_ente,en_nomlar,@i_cod_ref,@i_nomlar,'SIGLA'
              from   cl_ente
              where  c_sigla like @w_nomlar
          end
        end

        select
          @w_nomlar = @i_nombre + '%'
        insert into cl_lista_clinton
          select
            en_ente,en_nomlar,@i_cod_ref,@i_nomlar,'RAZON SOCIAL'
          from   cl_ente
          where  en_nomlar like @w_nomlar
      end
      else
      begin
        select
          @w_nomlar = @i_p_apellido + ' ' + @i_s_apellido + ' ' + @i_nombre
        select
          @w_nomlar = ltrim( rtrim( @w_nomlar) ) + '%'
        insert into cl_lista_clinton
          select
            en_ente,en_nomlar,@i_cod_ref,@i_nomlar,'NOMBRE COMPLETO'
          from   cl_ente
          where  en_nomlar like @w_nomlar

        select
          @w_nomlar = @i_p_apellido + ' ' + @i_nombre
        select
          @w_nomlar = ltrim( rtrim( @w_nomlar) ) + '%'
        insert into cl_lista_clinton
          select
            en_ente,en_nomlar,@i_cod_ref,@i_nomlar,'PRIMER APELLIDO + NOMBRE'
          from   cl_ente
          where  en_nomlar like @w_nomlar
      end
    end
  end

  return -1

go

