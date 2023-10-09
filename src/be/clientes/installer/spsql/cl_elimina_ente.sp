/************************************************************************/
/*  Archivo:            cl_elimina_ente.sp                              */
/*  Stored procedure:   sp_elimina_ente                                 */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Diego Duran                                     */
/*  Fecha de escritura: 25-Sep-2003                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                          PROPOSITO                                   */
/*  Este programa procesa los clientes cargados por bcp en proceso      */
/*  batch a una tabla temporal, validando que existan y no tengan       */
/*  productos asociados, para poder eliminarlos de las tablas           */
/*  cl_ente, cl_direccion.cl_mercado.cl_telefono y dejar regristro      */
/*  en la tabla del log.                                                */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*  FECHA       AUTOR       RAZON                                       */
/*  25/Sep/2003 D.Duran     Emision Inicial                             */
/*  10/Nov/2003 D.Duran     Almacenar Informacion en Log.               */
/*  05/Ags/2004 D.Duran     Optimizacion                                */
/*  02/May/2016 DFu         Migracion CEN                               */
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
           where  name = 'sp_elimina_ente')
  drop proc sp_elimina_ente
go

create proc sp_elimina_ente
(
  @t_debug         char(1) = 'N',
  @t_file          varchar(10) = null,
  @t_show_version  bit = 0,
  @i_modulo        varchar(30) = null,
  @i_tabla         varchar(30)=null,
  @i_fecha_proceso datetime = null,
  @o_registros1    int = null output
)
as
  declare
    @w_sp_name       descripcion,
    @w_return        int,
    @w_error         int,
    @w_ente          int,
    @w_tipo_ced      varchar(2),
    @w_en_ced_ruc    numero,
    @w_ente_aux      int,
    @w_subtipo       char(1),
    @w_sigla         varchar(25),
    @w_nombre        varchar(64),
    @w_papell        varchar(16),
    @w_sapell        varchar(16),
    @w_fnac          datetime,
    @w_sexo          char(1),
    @w_fcrea         datetime,
    @w_fmod          datetime,
    @w_actividad     varchar(6),
    @w_sector        varchar(10),
    @w_oficial       smallint,
    @w_situacion     varchar(10),
    @w_tcompania     varchar(10),
    @w_tsoc          varchar(10),
    @w_retencion     char(1),
    @w_oficina       smallint,
    @w_tpersona      varchar(10),
    @w_regimen       varchar(10),
    @w_banca         varchar(10),
    @w_telefono      varchar(16),
    @w_tipo_tel      char(1),
    @w_dpto          smallint,
    @w_ciudad        int,
    @w_direccion     varchar(254),
    @w_tmercado      varchar(10),
    @w_submercado    varchar(10),
    @w_contador      int,
    @w_reg_procesado int,
    @w_valprod       int,
    @w_valtercero    int

  select
    @w_sp_name = 'sp_elimina_ente'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_contador = 0,
    @w_reg_procesado = 0

  print 'Procesando Clientes Tabla Temporal'

  /*  Obtiene los clientes de tabla temporal  */
  declare cursor_elimina_ente cursor for
    select
      en_tipo_ced,
      en_ced_ruc,
      en_ente
    from   cl_plano_ente_tmp

  open cursor_elimina_ente

  fetch cursor_elimina_ente into @w_tipo_ced, @w_en_ced_ruc, @w_ente

  while @@fetch_status <> -1
  begin
    if (@@fetch_status = -2)
    begin
      select
        @w_error = 105506

    end

    select
      @w_valprod = 0,
      @w_valtercero = 0

    /*  VALIDA QUE EXISTA EL ENTE */

    select
      @w_ente_aux = en_ente
    from   cobis..cl_ente
    where  en_ente     = @w_ente
       and en_tipo_ced = @w_tipo_ced
       and en_ced_ruc  = @w_en_ced_ruc

    if @@rowcount = 0
    begin
      insert cobis..cl_error_elimente_log
             (ente,tipo_doc,documento,eliminado,descripcion,
              fecha_proceso)
      values (@w_ente,@w_tipo_ced,@w_en_ced_ruc,'N','No Existe Cliente',
              @i_fecha_proceso)

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 148056
        /*  'Error insertando el cliente' */
        return 1
      end
      goto SIGUIENTE
    end

    else
    begin
      /* Selecciona informacion del Ente antes de ser Eliminado */

      select
        @w_subtipo = en_subtipo,
        @w_sigla = c_sigla,
        @w_nombre = en_nombre,
        @w_papell = p_p_apellido,
        @w_sapell = p_s_apellido,
        @w_fnac = p_fecha_nac,
        @w_sexo = p_sexo,
        @w_fcrea = en_fecha_crea,
        @w_fmod = en_fecha_mod,
        @w_actividad = en_actividad,
        @w_sector = en_sector,
        @w_oficial = en_oficial,
        @w_situacion = en_situacion_cliente,
        @w_tcompania = c_tipo_compania,
        @w_tsoc = c_tipo_soc,
        @w_retencion = en_retencion,
        @w_oficina = en_oficina,
        @w_tpersona = p_tipo_persona,
        @w_regimen = en_asosciada,
        @w_banca = en_banca
      from   cobis..cl_ente
      where  en_ente = @w_ente_aux

      select
        @w_dpto = di_provincia,
        @w_ciudad = di_ciudad,
        @w_direccion = di_descripcion
      from   cobis..cl_direccion
      where  di_ente      = @w_ente_aux
         and di_principal = 'S'

      select
        @w_telefono = te_valor,
        @w_tipo_tel = te_tipo_telefono
      from   cobis..cl_telefono,
             cl_direccion
      where  te_ente      = @w_ente_aux
         and di_ente      = te_ente
         and di_direccion = te_direccion

      select
        @w_tmercado = mo_mercado_objetivo,
        @w_submercado = mo_subtipo_mo
      from   cobis..cl_mercado_objetivo_cliente
      where  mo_ente = @w_ente_aux

      /* VALIDA PRODUCTOS DEL CLIENTE */

      if exists (select
                   1
                 from   cobis..cl_cliente
                 where  cl_cliente = @w_ente_aux)
      begin
        insert cobis..cl_error_elimente_log
               (ente,tipo_doc,documento,eliminado,descripcion,
                fecha_proceso)
        values (@w_ente_aux,@w_tipo_ced,@w_en_ced_ruc,'N',
                'Cliente con Productos',
                @i_fecha_proceso)

        select
          @w_valprod = 1

        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 148056
          /*  'Error insertando el cliente' */
          return 1
        end
        goto SIGUIENTE
      end

      /* VALIDA SI ES TERCERO EN CONTABILIDAD*/

      if exists (select
                   1
                 from   cob_conta_tercero..ct_saldo_tercero
                 where  st_empresa > 0
                    and st_periodo > 0
                    and st_corte   > 0
                    and st_cuenta  > '0'
                    and st_oficina > 0
                    and st_area    > 0
                    and st_ente    = @w_ente_aux)
      begin
        insert cobis..cl_error_elimente_log
               (ente,tipo_doc,documento,eliminado,descripcion,
                fecha_proceso)
        values (@w_ente_aux,@w_tipo_ced,@w_en_ced_ruc,'N',
                'Cliente-Tercero con registros en la contabilidad',
                @i_fecha_proceso)

        select
          @w_valtercero = 1

        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 148056
          /*  'Error insertando el cliente' */
          return 1
        end

        goto SIGUIENTE
      end

      if (@w_valprod = 0)
         and (@w_valtercero = 0)
      begin
        /* Inicia eliminacion del Ente */

        begin tran
        delete cl_ente
        where  en_ente = @w_ente_aux

        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107000
          /* 'Error en eliminacion de ente'*/
          goto SIGUIENTE
        end

        delete cl_direccion
        where  di_ente = @w_ente_aux

        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107000
          /* 'Error en eliminacion de ente'*/
          goto SIGUIENTE
        end

        delete cl_telefono
        where  te_ente = @w_ente_aux

        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107000
          /* 'Error en eliminacion de ente'*/
          goto SIGUIENTE
        end

        delete cl_mercado_objetivo_cliente
        where  mo_ente = @w_ente_aux

        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107000
          /* 'Error en eliminacion de ente'*/
          return 1
        end

        insert cobis..cl_elimina_ente_log
               (elm_codigo_ente,elm_subtipo,elm_tipo_doc,elm_num_doc,elm_sigla,
                elm_nombre,elm_p_apellido,elm_s_apellido,elm_fecha_nacim,
                elm_sexo,
                elm_fecha_ingreso,elm_fecha_modifica,elm_actividad_ciiu,
                elm_sector
                ,
                elm_gerente,
                elm_estado_emp,elm_tipo_compania,elm_tipo_sociedad,elm_retencion
                ,
                elm_oficina,
                elm_tipo_per,elm_regimen_fiscal,elm_tipo_banca,elm_telefono,
                elm_tipo
                ,
                elm_dpto_dir,elm_ciudad_dir,elm_direccion,
                elm_tipo_mercado,
                elm_subtipo_mercado,
                elm_descripcion,elm_fecha_proceso)
        values (@w_ente_aux,@w_subtipo,@w_tipo_ced,@w_en_ced_ruc,@w_sigla,
                @w_nombre,@w_papell,@w_sapell,@w_fnac,@w_sexo,
                @w_fcrea,@w_fmod,@w_actividad,@w_sector,@w_oficial,
                @w_situacion,@w_tcompania,@w_tsoc,@w_retencion,@w_oficina,
                @w_tpersona,@w_regimen,@w_banca,@w_telefono,@w_tipo_tel,
                @w_dpto,@w_ciudad,@w_direccion,@w_tmercado,@w_submercado,
                'Ente Eliminado',@i_fecha_proceso)

        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 148056
          /*  'Error insertando el cliente' */
          return 1
        end

        commit tran

        goto SIGUIENTE

        select
          @o_registros1 = @o_registros1 + 1

      end
    end

    select
      @w_contador = @w_contador + 1
    select
      @w_reg_procesado = @w_reg_procesado + 1

    if @w_contador = 5000
      print 'Registros Procesados: ' + @w_reg_procesado
    select
      @w_contador = 0

    SIGUIENTE:

    fetch cursor_elimina_ente into @w_tipo_ced, @w_en_ced_ruc, @w_ente

  end /** cursor_creaciones **/

  select
    @o_registros1

  close cursor_elimina_ente
  deallocate cursor_elimina_ente

  return 0

go

