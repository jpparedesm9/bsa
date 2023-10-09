/************************************************************************/
/*    Archivo:              ciudad.sp                                   */
/*    Stored procedure:     sp_ciuxdept                                 */
/*    Base de datos:        cobis                                       */
/*    Producto:             MIS                                         */
/*    Disenado por:         Jaime Loyo Holguin                          */
/*    Fecha de escritura:   Octubre 15 de 1996                          */
/************************************************************************/
/*                IMPORTANTE                                            */
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
/*                PROPOSITO                                             */
/*    Este programa procesa las transacciones de:                       */
/*    Ayuda de ciudades pertenecientes a un mismo departamento          */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA             AUTOR        RAZON                              */
/*    Ago 30/2004     E. Laguna     Tunning                             */
/*    May/02/2016     DFu           Migracion CEN                       */
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
           where  name = 'sp_ciuxdept')
  drop proc sp_ciuxdept
go

create proc sp_ciuxdept
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_sesn         int = null,
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
  @t_trn          smallint =null,
  @t_show_version bit = 0,
  @i_operacion    varchar(2),
  @i_tipo         varchar(1) = null,
  @i_modo         tinyint = null,
  @i_ciudad       int = null,
  @i_provincia    smallint = null,
  @i_ultimo       descripcion = null,
  @i_valor        descripcion = null
)
as
  declare
    @w_today   datetime,
    @w_des     descripcion,
    @w_sp_name varchar(32)

  select
    @w_sp_name = 'sp_ciuxdept'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

  /* ** Help ** */
  if @i_operacion = 'H'
  begin
    if @t_trn = 1300
    begin
      if @i_tipo = 'A'
      begin
        set rowcount 20
        if @i_modo = 0
          select
            'Cod.' = ci_ciudad,
            'Nombre' = ci_descripcion,
            'Depto ' = pv_descripcion,
            'Pais' = pa_descripcion
          from   cl_provincia,
                 cl_pais,
                 cl_ciudad
          where  pv_provincia = @i_provincia
             and pv_provincia = ci_provincia
             and pa_pais      = ci_pais
             and ci_provincia = @i_provincia
             and ci_estado    = 'V'
          order  by ci_ciudad,
                    ci_descripcion
        else if @i_modo = 1
        begin
          select
            'Cod.' = ci_ciudad,
            'Nombre' = ci_descripcion,
            'Depto ' = pv_descripcion,
            'Pais' = pa_descripcion
          from   cl_provincia,
                 cl_pais,
                 cl_ciudad
          where  pv_provincia = @i_provincia
             and pv_provincia = ci_provincia
             and pa_pais      = ci_pais
             and ci_provincia = @i_provincia
             and ci_estado    = 'V'
             and ci_ciudad    > @i_ciudad
          order  by ci_ciudad,
                    ci_descripcion
          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 151121
            /* 'No existe dato solicitado'*/
            return 1
          end
        end
        set rowcount 0
      end
      if @i_tipo = 'V'
      begin
        select
          ci_descripcion
        from   cl_ciudad
        where  ci_ciudad    = @i_ciudad
           and ci_provincia = @i_provincia
           and ci_estado    = 'V'
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /*  'No existe dato Solicitado ' */
          return 1
        end
      end
      if @i_tipo = 'B'
      begin
        set rowcount 20
        if @i_modo = 0
          select
            'Cod.' = ci_ciudad,
            'Nombre' = ci_descripcion,
            'Depto ' = pv_descripcion,
            'Pais' = pa_descripcion
          from   cl_ciudad,
                 cl_provincia,
                 cl_pais
          where  ci_provincia = @i_provincia
             and pv_provincia = @i_provincia
             and pv_provincia = ci_provincia
             and pa_pais      = ci_pais
             and ci_estado    = 'V'
             and ci_descripcion like @i_valor
          order  by ci_descripcion
        else if @i_modo = 1
        begin
          select
            'Cod.' = ci_ciudad,
            'Nombre' = ci_descripcion,
            'Depto ' = pv_descripcion,
            'Pais' = pa_descripcion
          from   cl_ciudad,
                 cl_provincia,
                 cl_pais
          where  ci_provincia   = @i_provincia
             and pv_provincia   = @i_provincia
             and pv_provincia   = ci_provincia
             and pa_pais        = ci_pais
             and ci_estado      = 'V'
             and ci_descripcion like @i_valor
             and ci_descripcion > @i_ultimo
          order  by ci_descripcion
          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 151121
            /* 'No existe dato solicitado'*/
            return 1
          end
        end
        set rowcount 0
      end
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
  end

go

