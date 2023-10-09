/************************************************************************/
/*   Archivo:             cl_cobdyn.sp                                  */
/*   Stored procedure:    sp_cobis_dynamics                             */
/*   Base de datos:       Cobis                                         */
/*   Producto:            Clientes                                      */
/*   Disenado por:        Mario Algarin                                 */
/*   Fecha:               21/Oct/2011                                   */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBISCORP'.                                                       */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBISCORP o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Interfaz de Clientes Proveedores hacia Dynamics                    */
/************************************************************************/
/*                            MODIFICACIONES                            */
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
           where  name = 'sp_cobis_dynamics')
  drop proc sp_cobis_dynamics
go

create proc sp_cobis_dynamics
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
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
  @i_crea_ext     char(1) = null,-- Req. 353 Alianzas Comerciales
  @i_ente         int,
  @i_ws           char(1) = 'N'
--REQ 428 Controlar eventos raiserror para no desplazar trama XML respuesta 
)
as
  declare
    @w_sp_name         varchar(30),
    @w_en_ced_ruc      varchar(30),
    @w_en_nomlar       varchar(254),
    @w_en_nombre       varchar(64),
    @w_di_descripcion  varchar(254),
    @w_ci_descripcion  varchar(64),
    @w_pv_descripcion  varchar(64),
    @w_rf_descripcion  varchar(160),
    @w_c_tipo_compania varchar(10),
    @w_en_tipo_ced     char(2),
    @w_en_actividad    varchar(255)

  select
    @w_sp_name = 'sp_cobis_dynamics'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* CAPTURA DEL DOCUMENTO DEL CLIENTE */
  select
    @w_en_ced_ruc = en_ced_ruc
  from   cl_ente
  where  en_ente = @i_ente

  if @@rowcount = 0
  begin
    /* No Existe Proveedor en la Base de Clientes */
    if @i_ws = 'S'
    begin
      return 105521
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105521
      return 1
    end
  end

  /* BORRADO DEL CLIENTE SI EXISTE EN LA TABLA DE DYNAMICS PARA ESE DIA */
  if exists (select
               1
             from   cob_externos..ex_cobis_dynamics
             where  cd_nit = @w_en_ced_ruc)
    delete cob_externos..ex_cobis_dynamics
    where  cd_nit = @w_en_ced_ruc

  /* CARGA Y VALIDACION DE VARIBLES REQUERIDAS POR DYNAMICS */
  select
    @w_en_ced_ruc = case
                      when en_tipo_ced in ('NI', 'N') then
                      substring(en_ced_ruc,
                                1,
                                datalength(
                                en_ced_ruc) - 1)
                      else en_ced_ruc
                    end,
    @w_en_nomlar = en_nomlar,
    @w_en_nombre = en_nombre,
    @w_di_descripcion = isnull((select top 1
                                  di_descripcion
                                from   cobis..cl_direccion
                                where  di_ente      = en_ente
                                   and di_principal = 'S'),
                               ''),
    @w_ci_descripcion = (select
                           ci_descripcion
                         from   cobis..cl_ciudad
                         where  ci_ciudad = (select
                                               di_ciudad
                                             from   cobis..cl_direccion
                                             where  di_ente      = en_ente
                                                and di_principal = 'S')),
    @w_pv_descripcion = (select
                           pv_descripcion
                         from   cobis..cl_provincia
                         where  pv_provincia = (select
                                                  ci_provincia
                                                from   cobis..cl_ciudad
                                                where  ci_ciudad =
                                (select
                                   di_ciudad
                                 from   cobis..cl_direccion
                                 where
                                               di_ente      = en_ente
                                                           and
                                               di_principal = 'S')
                                               )),
    @w_rf_descripcion = (select
                           rf_descripcion
                         from   cob_conta..cb_regimen_fiscal
                         where  rf_codigo = en_asosciada),
    @w_c_tipo_compania = case
                           when c_tipo_compania = 'PA' then 'P'
                           when c_tipo_compania = 'OF' then 'O'
                           else ''
                         end,
    @w_en_tipo_ced = en_tipo_ced,
    @w_en_actividad = (select
                         rtrim(en_actividad) + ' - ' + b.valor
                       from   cobis..cl_tabla a,
                              cobis..cl_catalogo b
                       where  a.tabla  = 'cl_actividad'
                          and a.codigo = b.tabla
                          and b.codigo = en_actividad)
  from   cobis..cl_ente
  where  en_ente = @i_ente

  /* VALIDACION DE EXISTENCIA DEL DOCUMENTO DE ID DEL PROVEEEDOR */
  if @w_en_ced_ruc is null
  begin
    /* Error Identificacion Nula Proveedor Interface Dynamics */
    if @i_ws = 'S'
    begin
      return 105523
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105523
      return 1
    end
  end

  /* VALIDACION DE LA EXISTENCIA DEL NOMBRE LARGO DEL PROVEEDOR */
  if @w_en_nomlar is null
  begin
    /* Error Nombre Largo Nulo Proveedor Interface Dynamics */
    if @i_ws = 'S'
    begin
      return 105524
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105524
      return 1
    end
  end

  /* VALIDACION DEL NOMBRE DEL PROVEEDOR */
  if @w_en_nombre is null
  begin
    /* Error Nombre Nulo Proveedor Interface Dynamics */
    if @i_ws = 'S'
    begin
      return 105525
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105525
      return 1
    end
  end

  /* VALIDACION EXISTENCIA DE LA DIRECCION PRINCIPAL DEL PROVEEDOR */
  if @w_di_descripcion is null
  begin
    /* Error Direccion Principal Nula Proveedor Interface Dynamics */
    if @i_ws = 'S'
    begin
      return 105526
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105526
      return 1
    end
  end

  /* VALIDACION DE LA EXISTENCIA DE LA CIUDAD DEL PROVEEDOR */
  if @w_ci_descripcion is null
  begin
    /* Error Ciudad Direccion Principal Nula Proveedor Interface Dynamics */
    if @i_ws = 'S'
    begin
      return 105527
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105527
      return 1
    end
  end

  /* VALIDACION DE LA EXISTENCIA DEL DEPARTAMENTO DEL PROVEEDOR */
  if @w_pv_descripcion is null
  begin
    /* Error Departamento Direccion Principal Nulo Proveedor Interface Dynamics */
    if @i_ws = 'S'
    begin
      return 105528
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105528
      return 1
    end
  end

  /* VALIDACION DEL PERFIL TRIBUTARIOO DEL PROVEEDOR */
  if @w_rf_descripcion is null
  begin
    /* Error Descripcion Perfil Tributario Nula Proveedor Interface Dynamics */
    if @i_ws = 'S'
    begin
      return 105529
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105529
      return 1
    end
  end

  /* VALIDACION DEL TIPO DE PROVEEDOR */
  if @w_c_tipo_compania is null
  begin
    /* Error Tipo de Compania Nula Proveedor Interface Dynamics */
    if @i_ws = 'S'
    begin
      return 105530
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105530
      return 1
    end
  end

  /* VALIDACION DEL TIPO DE DOCUMENTO DEL PROVEEDOR */
  if @w_en_tipo_ced is null
  begin
    /* Error Tipo de Documento de Identificacion Nulo Proveedor Interface Dynamics */
    if @i_ws = 'S'
    begin
      return 105531
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105531
      return 1
    end
  end

  /* VALIADACION ACTIVIDAD ECONOMICA DEL PROVEEDOR */
  if @w_en_actividad is null
  begin
    /* Error Actividad Economica Nula Proveedor Interface Dynamics */
    if @i_ws = 'S'
    begin
      return 105532
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105532
      return 1
    end
  end

  /* INSERCION DEL CLIENTE PROVEEDOR EN LAS ESTRUCTURAS DE DYNAMICS */
  if @i_crea_ext is null
    begin tran

  insert into cob_externos..ex_cobis_dynamics
    select
      case
        when en_tipo_ced in ('NI', 'N') then substring(en_ced_ruc,
                                                       1,
                                                       datalength(en_ced_ruc)
                                                       - 1)
        else en_ced_ruc
      end,en_nomlar,en_nombre,en_nomlar,'PRINCIPAL',
      isnull((select top 1
                di_descripcion
              from   cobis..cl_direccion
              where  di_ente      = en_ente
                 and di_principal = 'S'),
             ''),(select top 1
         di_descripcion
       from   cobis..cl_direccion
       where  di_ente      = en_ente
          and di_principal <> 'S'
          and di_tipo      <> '001'
          and di_direccion > 1),(select top 1
         di_descripcion
       from   cobis..cl_direccion
       where  di_ente      = en_ente
          and di_principal <> 'S'
          and di_tipo      <> '001'
          and di_direccion > 2),(select
         ci_descripcion
       from   cobis..cl_ciudad
       where  ci_ciudad = (select
                             di_ciudad
                           from   cobis..cl_direccion
                           where  di_ente      = en_ente
                              and di_principal = 'S')),(select
         pv_descripcion
       from   cobis..cl_provincia
       where  pv_provincia = (select
                                ci_provincia
                              from   cobis..cl_ciudad
                              where  ci_ciudad = (select
                                                    di_ciudad
                                                  from   cobis..cl_direccion
                                                  where  di_ente      = en_ente
                                                     and di_principal = 'S'))),
      '57',(select
         right(replicate('0', 2) + isnull(te_prefijo, 0), 3) + te_valor
       from   cobis..cl_telefono
       where  te_direccion  = (select
                                 di_direccion
                               from   cobis..cl_direccion
                               where  di_ente      = en_ente
                                  and di_principal = 'S')
          and te_ente       = en_ente
          and te_secuencial = 1),(select
         right(replicate('0', 2) + isnull(te_prefijo, 0), 3) + te_valor
       from   cobis..cl_telefono
       where  te_direccion     = (select top 1
                                    di_direccion
                                  from   cobis..cl_direccion
                                  where  di_ente      = en_ente
                                     and di_principal <> 'S'
                                     and di_tipo      <> '001'
                                     and di_direccion > 1)
          and te_ente          = en_ente
          and te_secuencial    = 1
          and te_tipo_telefono <> 'F'),(select
         right(replicate('0', 2) + isnull(te_prefijo, 0), 3) + te_valor
       from   cobis..cl_telefono
       where  te_direccion     = (select top 1
                                    di_direccion
                                  from   cobis..cl_direccion
                                  where  di_ente      = en_ente
                                     and di_principal <> 'S'
                                     and di_tipo      <> '001'
                                     and di_direccion > 2)
          and te_ente          = en_ente
          and te_secuencial    = 1
          and te_tipo_telefono <> 'F'),(select top 1
         right(replicate('0', 2) + isnull(te_prefijo, 0), 3) + te_valor
       from   cobis..cl_telefono
       where  te_ente          = en_ente
          and te_tipo_telefono = 'F'),
      (select
         rf_descripcion
       from   cob_conta..cb_regimen_fiscal
       where  rf_codigo = en_asosciada),case
        when c_tipo_compania = 'PA' then 'P'
        when c_tipo_compania = 'OF' then 'O'
        else ''
      end,en_tipo_ced,(select
         rtrim(en_actividad) + ' - ' + b.valor
       from   cobis..cl_tabla a,cobis..cl_catalogo b
       where  a.tabla  = 'cl_actividad'
          and a.codigo = b.tabla
          and b.codigo = en_actividad),en_ced_ruc,
      getdate() --,en_fecha_mod
      ,convert(varchar(10), getdate(), 108)
      --,convert(varchar(10),en_fecha_mod,108)
      ,null,'1'
    from   cobis..cl_ente
    where  en_ente = @i_ente

  if @@error <> 0
  begin
    /* Error en creacion del Proveedor en las estructuras de Dynamics */
    if @i_ws = 'S'
    begin
      return 105520
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105520
      return 1
    end
  end

  if @i_crea_ext is null
    commit tran

  return 0

go

