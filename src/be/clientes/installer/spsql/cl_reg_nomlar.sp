/************************************************************************/
/*    Archivo:             cl_reg_nomlar.sp                             */
/*    Stored procedure:    sp_reg_nomlar                                */
/*    Base de datos:       cobis                                        */
/*    Producto:            MIS                                          */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*                                                                      */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA             AUTOR         RAZON                             */
/*    May/02/2016     DFu             Migracion CEN                     */
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
           where  name = 'sp_reg_nomlar')
  drop proc sp_reg_nomlar
go

create proc sp_reg_nomlar
(
  @t_show_version bit = 0,
  @i_bandera      int = 1
)
as
  declare
    @w_sp_name         char(30),
    @w_ente            int,
    @w_nombre          varchar(32),
    @w_p_apellido      varchar(16),
    @w_s_apellido      varchar(16),
    @w_nombre_completo varchar(64),
    @w_reg             int,
    @w_nombre1         varchar(32),
    @w_apellido1       varchar(16),
    @w_apellido2       varchar(16),
    @w_error           int,
    @w_cont            int

  select
    @w_sp_name = 'sp_reg_nomlar'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  update cobis..cl_ente
  set    en_nomlar = ltrim(rtrim(en_nombre))
  where  en_subtipo = 'C'
     and en_nomlar like '%  %'

  if exists (select
               1
             from   sysobjects
             where  name = 'cl_ente_nomlar')
    drop table cl_ente_nomlar

  create table cl_ente_nomlar
  (
    en_ente      int,
    en_nombre    varchar(32),
    p_p_apellido varchar(16),
    p_s_apellido varchar(16) null,
    en_nomlar    varchar(64)
  )

  insert into cl_ente_nomlar
              (en_ente,en_nombre,p_p_apellido,p_s_apellido,en_nomlar)
    select
      en_ente,en_nombre,p_p_apellido,p_s_apellido,en_nomlar
    from   cobis..cl_ente
    where  en_subtipo = 'P'
       and en_nomlar like '%  %'

  select
    @w_reg = count(0)
  from   cobis..cl_ente_nomlar

  while 1 = 1
  begin
    set rowcount 1

    select
      @w_ente = en_ente,
      @w_nombre = en_nombre,
      @w_p_apellido = p_p_apellido,
      @w_s_apellido = p_s_apellido
    from   cobis..cl_ente_nomlar

    if @@rowcount = 0
    begin
      set rowcount 0
      break
    end

    select
      @w_nombre1 = @w_nombre
    select
      @w_apellido1 = ltrim(rtrim(@w_p_apellido))
    select
      @w_apellido2 = ltrim(rtrim(isnull(@w_s_apellido,
                                        ' ')))

    if @w_apellido2 in(null, ' ')
    begin
      select
        @w_nombre_completo = @w_apellido1 + ' ' + ltrim(rtrim(@w_nombre1))
    end
    if @w_apellido2 not in(null, ' ')
    begin
      select
        @w_nombre_completo = @w_apellido1 + ' ' + @w_apellido2 + ' ' + ltrim(
                             rtrim
                             (
                                    @w_nombre1))
    end

    set rowcount 0

    begin tran

    print 'Ente ' + cast(@w_ente as varchar)

    update cobis..cl_ente
    set    en_nomlar = @w_nombre_completo,
           en_nombre = ltrim(rtrim(@w_nombre1))
    where  en_ente = @w_ente

    if @@error <> 0
    begin
      set rowcount 0
      rollback tran
      print 'ERROR EN BORRADO DE REFINH'
      return 1
    end

    delete cobis..cl_ente_nomlar
    where  en_ente = @w_ente

    select
      @w_error = @@error,
      @w_cont = @@rowcount

    if @w_error <> 0
    begin
      set rowcount 0
      rollback tran
      print 'ERROR EN BORRADO DE cl_autoriza_sarlaft_lista'
      return 1
    end

    commit tran
    siguiente_d:
  end

  return 0

go

