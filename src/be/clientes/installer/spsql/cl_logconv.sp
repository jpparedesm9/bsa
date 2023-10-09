/************************************************************************/
/*  Archivo:                cl_logconv.sp                               */
/*  Stored procedure:       sp_pasalogconv                              */
/*  Base de datos:          cobis                                       */
/*  Producto:               MIS                                         */
/*  Fecha de escritura:     Julio 30/2003                               */
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
/*                               PROPOSITO                              */
/*  Toma los datos de la tabla cl_tran_servicio_conv y tablas log       */
/*  direcciones, telefonos y mercado del proceso de convivencia y       */
/*  lo pasa a la cl_tran_sercicio para que sea tomado por cl_actdat     */
/************************************************************************/
/*                             MODIFICACIONES                           */
/*  FECHA           AUTOR           RAZON                               */
/*  Abr/21/2004     E. Laguna       Tunning                             */
/*  May/02/2016     DFu             Migracion CEN                       */
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
           where  name = 'sp_pasalogconv')
  drop proc sp_pasalogconv
go

create proc sp_pasalogconv
(
  @s_ssn          int = null,
  @s_date         datetime = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_show_version bit = 0,
  @i_fecha        datetime = null,
  @o_regispasalog int = null output
)
as
  declare
    @w_tabla             varchar(20),
    @w_sp_name           char(30),
    @w_descripcion       descripcion,
    @w_mercado_objetivo  catalogo,
    @w_subtipo_mo        catalogo,
    @w_valor             descripcion,
    @w_campo             descripcion,
    @w_fecha             datetime,
    @w_valor_ant         descripcion,
    @w_valor_nue         descripcion,
    @w_secuencial1       tinyint,
    @w_secuencial2       tinyint,
    @v_mercado_objetivo  catalogo,
    @v_subtipo_mo        catalogo,
    @w_ente              int,
    @w_subtipo           char(1),
    @w_tipo_ced          char(2),
    @w_ced_ruc           numero,
    @w_sigla             varchar(25),
    @w_nombre            descripcion,
    @w_p_apellido        varchar(16),
    @w_s_apellido        varchar(16),
    @w_fecha_nac         datetime,
    @w_sexo              sexo,
    @w_fecha_crea        datetime,
    @w_fecha_mod         datetime,
    @w_actividad         catalogo,
    @w_sector            catalogo,
    @w_oficial           smallint,
    @w_tipo_compania     catalogo,
    @w_retencion         char(1),
    @w_oficina           smallint,
    @w_filial            tinyint,
    @w_mala_referencia   char(1),
    @w_direccion         tinyint,
    @w_tipo_soc          catalogo,
    @w_tipo_persona      catalogo,
    @w_asosciada         catalogo,
    @w_banca             catalogo,
    @w_depa_nac          smallint,
    @w_depa_emi          smallint,
    @w_ciudad_nac        int,
    @w_lugar_doc         int,
    @w_exc_sipla         char(1),
    @w_exc_por2          char(1),
    @w_situacion_cliente catalogo,
    @w_nomlar            varchar(254),
    @w_pais              smallint,
    @w_pais_emi          smallint,
    @w_digito            char(1),
    @w_fecha_upd         datetime,
    @w_operacion         char(1),
    @v_ente              int,
    @v_subtipo           char(1),
    @v_tipo_ced          char(2),
    @v_ced_ruc           varchar(15),
    @v_sigla             varchar(25),
    @v_nombre            descripcion,
    @v_p_apellido        varchar(16),
    @v_s_apellido        varchar(16),
    @v_fecha_nac         datetime,
    @v_sexo              sexo,
    @v_fecha_crea        datetime,
    @v_fecha_mod         datetime,
    @v_actividad         catalogo,
    @v_sector            catalogo,
    @v_oficial           smallint,
    @v_tipo_compania     catalogo,
    @v_retencion         char(1),
    @v_oficina           smallint,
    @v_filial            tinyint,
    @v_mala_referencia   char(1),
    @v_direccion         tinyint,
    @v_descripcion       varchar(254),
    @v_tipo_soc          catalogo,
    @v_tipo_persona      catalogo,
    @v_asosciada         catalogo,
    @v_banca             catalogo,
    @v_depa_nac          smallint,
    @v_depa_emi          smallint,
    @v_ciudad_nac        int,
    @v_lugar_doc         int,
    @v_exc_sipla         char(1),
    @v_exc_por2          char(1),
    @v_situacion_cliente catalogo,
    @v_nomlar            varchar(254),
    @v_pais              smallint,
    @v_pais_emi          smallint,
    @v_digito            char(1),
    @v_fecha_upd         datetime,
    @v_valor             varchar(16),
    @v_operacion         char(1),
    @w_registro          tinyint

  select
    @w_sp_name = 'sp_pasalogconv'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @o_regispasalog = 0

  select
    'inicia el cargue de la tabla %1!',
    getdate()

  create table #cl_actualiza_tmp
  (
    en_ente              int not null,
    en_subtipo           char (1) not null,
    en_tipo_ced          char(2) null,
    en_ced_ruc           varchar(30) null,
    c_sigla              varchar(25) null,
    en_nombre            varchar(64) not null,
    p_p_apellido         varchar (16) null,
    p_s_apellido         varchar (16) null,
    p_fecha_nac          datetime null,
    p_sexo               char(1) null,
    en_fecha_crea        datetime null,
    en_actividad         varchar(10) null,
    en_sector            varchar(10) null,
    en_oficial           smallint null,
    c_tipo_compania      varchar(10) null,
    en_retencion         char(1) not null,
    en_oficina           smallint not null,
    en_filial            tinyint not null,
    en_mala_referencia   char(1) not null,
    c_tipo_soc           varchar(10) null,
    p_tipo_persona       varchar(10) null,
    en_asosciada         varchar(10) null,
    en_banca             varchar(10) null,
    p_depa_nac           smallint null,
    p_depa_emi           smallint null,
    p_ciudad_nac         int null,
    en_exc_sipla         char(1) null,
    en_exc_por2          char(1) null,
    en_situacion_cliente varchar(10) null,
    en_nomlar            varchar(254) null,
    en_digito            char(1) null,
    di_descripcion       varchar(254) null,
    mo_mercado_objetivo  varchar(10) null,
    mo_subtipo_mo        varchar(10) null,
    te_valor             varchar(16) null,
    operacion            char(1) null
  )
  -- lock datarows

  --insert into #cb_relparam

  insert into #cl_actualiza_tmp
    select
      en_ente,en_subtipo,en_tipo_ced,en_ced_ruc,c_sigla,
      en_nombre,p_p_apellido,p_s_apellido,p_fecha_nac,p_sexo,
      en_fecha_crea,en_actividad,en_sector,en_oficial,c_tipo_compania,
      en_retencion,en_oficina,en_filial,en_mala_referencia,c_tipo_soc,
      p_tipo_persona,en_asosciada,en_banca,p_depa_nac,p_depa_emi,
      p_ciudad_nac,en_exc_sipla,en_exc_por2,en_situacion_cliente,en_nomlar,
      en_digito,di_descripcion,mo_mercado_objetivo,mo_subtipo_mo,te_valor,
      d.operacion
    from   cobis..cl_tran_servicio_conv_dir c,
           cobis..cl_tran_servicio_conv d,
           cobis..cl_tran_servicio_conv_tel a
           right outer join cobis..cl_tran_servicio_conv_mer b
                         on a.te_ente = b.mo_ente
                            and a.operacion = b.operacion
                            and a.fecha_upd = b.fecha_upd
    where  b.fecha_upd >= @i_fecha
       and b.fecha_upd < dateadd(dd,
                                 1,
                                 @i_fecha)
       and b.mo_ente   = c.di_ente
       and b.operacion = c.operacion
       and b.fecha_upd = c.fecha_upd
       and c.di_ente   = d.en_ente
       and c.operacion = d.operacion
       and c.fecha_upd = d.fecha_upd
       and b.mo_ente   > 0--c.di_ente
       and b.operacion = c.operacion
       and b.fecha_upd = c.fecha_upd

  select
    'termina el cargue de la tabla %1!',
    getdate()

  create index #cl_actualiza_tmp_Key
    on #cl_actualiza_tmp (operacion, en_ente)

  select
    'Termina la creacion del indice%1!',
    getdate()

  if @i_fecha <> ''
  begin
    -- Crear un cursor para leer la tabla cargada desde diskette

    declare cursor_ente_mig cursor for
      select
        en_ente,
        en_subtipo,
        en_tipo_ced,
        en_ced_ruc,
        c_sigla,
        en_nombre,
        p_p_apellido,
        p_s_apellido,
        p_fecha_nac,
        p_sexo,
        en_fecha_crea,
        en_actividad,
        en_sector,
        en_oficial,
        c_tipo_compania,
        en_retencion,
        en_oficina,
        en_filial,
        en_mala_referencia,
        c_tipo_soc,
        p_tipo_persona,
        en_asosciada,
        en_banca,
        p_depa_nac,
        p_depa_emi,
        p_ciudad_nac,
        en_exc_sipla,
        en_exc_por2,
        en_situacion_cliente,
        en_nomlar,
        en_digito,
        di_descripcion,
        mo_mercado_objetivo,
        mo_subtipo_mo,
        te_valor
      from   #cl_actualiza_tmp
      where  operacion = 'A'

    open cursor_ente_mig

    fetch cursor_ente_mig into @w_ente,
                               @w_subtipo,
                               @w_tipo_ced,
                               @w_ced_ruc,
                               @w_sigla,
                               @w_nombre,
                               @w_p_apellido,
                               @w_s_apellido,
                               @w_fecha_nac,
                               @w_sexo,
                               @w_fecha_crea,
                               @w_actividad,
                               @w_sector,
                               @w_oficial,
                               @w_tipo_compania,
                               @w_retencion,
                               @w_oficina,
                               @w_filial,
                               @w_mala_referencia,
                               @w_tipo_soc,
                               @w_tipo_persona,
                               @w_asosciada,
                               @w_banca,
                               @w_depa_nac,
                               @w_depa_emi,
                               @w_ciudad_nac,
                               @w_exc_sipla,
                               @w_exc_por2,
                               @w_situacion_cliente,
                               @w_nomlar,
                               @w_digito,
                               @w_descripcion,
                               @w_mercado_objetivo,
                               @w_subtipo_mo,
                               @w_valor

    while @@fetch_status <> -1
    begin
      if @@fetch_status = -2
      begin
        close cursor_ente_mig
        deallocate cursor_ente_mig
        /* Error en recuperacion de datos del cursor */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107099
        return 1
      end

      -- Crear un cursor para leer la tabla cargada desde diskette

      declare cursor_ente_migUp cursor for
        select
          en_ente,
          en_subtipo,
          en_tipo_ced,
          en_ced_ruc,
          c_sigla,
          en_nombre,
          p_p_apellido,
          p_s_apellido,
          p_fecha_nac,
          p_sexo,
          en_fecha_crea,
          en_actividad,
          en_sector,
          en_oficial,
          c_tipo_compania,
          en_retencion,
          en_oficina,
          en_filial,
          en_mala_referencia,
          c_tipo_soc,
          p_tipo_persona,
          en_asosciada,
          en_banca,
          p_depa_nac,
          p_depa_emi,
          p_ciudad_nac,
          en_exc_sipla,
          en_exc_por2,
          en_situacion_cliente,
          en_nomlar,
          en_digito,
          di_descripcion,
          mo_mercado_objetivo,
          mo_subtipo_mo,
          te_valor
        from   #cl_actualiza_tmp
        where  operacion = 'D'
           and en_ente   = @w_ente

      open cursor_ente_migUp

      fetch cursor_ente_migUp into @v_ente,
                                   @v_subtipo,
                                   @v_tipo_ced,
                                   @v_ced_ruc,
                                   @v_sigla,
                                   @v_nombre,
                                   @v_p_apellido,
                                   @v_s_apellido,
                                   @v_fecha_nac,
                                   @v_sexo,
                                   @v_fecha_crea,
                                   @v_actividad,
                                   @v_sector,
                                   @v_oficial,
                                   @v_tipo_compania,
                                   @v_retencion,
                                   @v_oficina,
                                   @v_filial,
                                   @v_mala_referencia,
                                   @v_tipo_soc,
                                   @v_tipo_persona,
                                   @v_asosciada,
                                   @v_banca,
                                   @v_depa_nac,
                                   @v_depa_emi,
                                   @v_ciudad_nac,
                                   @v_exc_sipla,
                                   @v_exc_por2,
                                   @v_situacion_cliente,
                                   @v_nomlar,
                                   @v_digito,
                                   @v_descripcion,
                                   @v_mercado_objetivo,
                                   @v_subtipo_mo,
                                   @v_valor

      -- Para cada uno de los datos hasta que no hayan datos en la tabla
      while @@fetch_status <> -1
      begin
        if @@fetch_status = -2
        begin
          close cursor_ente_migUp
          deallocate cursor_ente_migUp
          /* Error en recuperacion de datos del cursor */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107099
          return 1
        end

        -- Comenzar una transaccion

        if @w_ente = @v_ente
        begin
          if @w_tipo_ced <> @v_tipo_ced
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_tipo_ced',
              @w_valor_ant = @v_tipo_ced,
              @w_valor_nue = @w_tipo_ced,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_ced_ruc <> @v_ced_ruc
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_ced_ruc',
              @w_valor_ant = @v_ced_ruc,
              @w_valor_nue = @w_ced_ruc,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_sigla <> @v_sigla
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'c_sigla',
              @w_valor_ant = @v_sigla,
              @w_valor_nue = @w_sigla,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_nombre <> @v_nombre
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_nombre',
              @w_valor_ant = @v_nombre,
              @w_valor_nue = @w_nombre,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_p_apellido <> @v_p_apellido
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'p_p_apellido',
              @w_valor_ant = @v_p_apellido,
              @w_valor_nue = @w_p_apellido,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_s_apellido <> @v_s_apellido
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'p_s_apellido',
              @w_valor_ant = @v_s_apellido,
              @w_valor_nue = @w_s_apellido,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_fecha_nac <> @v_fecha_nac
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_fecha_nac',
              @w_valor_ant = @v_fecha_nac,
              @w_valor_nue = @w_fecha_nac,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_fecha_crea <> @v_fecha_crea
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_fecha_crea',
              @w_valor_ant = @v_fecha_crea,
              @w_valor_nue = @w_fecha_crea,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_actividad <> @v_actividad
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_actividad',
              @w_valor_ant = @v_actividad,
              @w_valor_nue = @w_actividad,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_sector <> @v_sector
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_sector',
              @w_valor_ant = @v_sector,
              @w_valor_nue = @w_sector,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_oficial <> @v_oficial
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_oficial',
              @w_valor_ant = convert (varchar, @v_oficial),
              @w_valor_nue = convert (varchar, @w_oficial),
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_tipo_compania <> @v_tipo_compania
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'c_tipo_compania',
              @w_valor_ant = @v_tipo_compania,
              @w_valor_nue = @w_tipo_compania,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_retencion <> @v_retencion
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_retencion',
              @w_valor_ant = @v_retencion,
              @w_valor_nue = @w_retencion,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_oficina <> @v_oficina
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_oficina',
              @w_valor_ant = convert (varchar, @v_oficina),
              @w_valor_nue = convert (varchar, @w_oficina),
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_tipo_soc <> @v_tipo_soc
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'c_tipo_soc',
              @w_valor_ant = @v_tipo_soc,
              @w_valor_nue = @w_tipo_soc,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_tipo_persona <> @v_tipo_persona
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'p_tipo_persona',
              @w_valor_ant = @v_tipo_persona,
              @w_valor_nue = @w_tipo_persona,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_asosciada <> @v_asosciada
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_asosciada',
              @w_valor_ant = @v_asosciada,
              @w_valor_nue = @w_asosciada,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_banca <> @v_banca
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_banca',
              @w_valor_ant = @v_banca,
              @w_valor_nue = @w_banca,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2
            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_depa_nac <> @v_depa_nac
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'p_depa_nac',
              @w_valor_ant = convert (varchar, @v_depa_nac),
              @w_valor_nue = convert (varchar, @w_depa_nac),
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_exc_sipla <> @v_exc_sipla
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_exc_sipla',
              @w_valor_ant = @v_exc_sipla,
              @w_valor_nue = @w_exc_sipla,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_exc_por2 <> @v_exc_por2
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_exc_por2',
              @w_valor_ant = @v_exc_por2,
              @w_valor_nue = @w_exc_por2,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_situacion_cliente <> @v_situacion_cliente
          begin
            select
              @w_tabla = 'cl_ente',
              @w_campo = 'en_situacion_cliente',
              @w_valor_ant = @v_situacion_cliente,
              @w_valor_nue = @w_situacion_cliente,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_descripcion <> @v_descripcion
          begin
            select
              @w_tabla = 'cl_direccion',
              @w_campo = 'di_descripcion',
              @w_valor_ant = @v_descripcion,
              @w_valor_nue = @w_descripcion,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_mercado_objetivo <> @v_mercado_objetivo
          begin
            select
              @w_tabla = 'cl_mercado_objetivo',
              @w_campo = 'me_mercado_objetivo',
              @w_valor_ant = @v_mercado_objetivo,
              @w_valor_nue = @w_mercado_objetivo,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_subtipo_mo <> @v_subtipo_mo
          begin
            select
              @w_tabla = 'cl_mercado_objetivo',
              @w_campo = 'me_subtipo_mo',
              @w_valor_ant = @v_subtipo_mo,
              @w_valor_nue = @w_subtipo_mo,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end

          if @w_valor <> @v_valor
          begin
            select
              @w_tabla = 'cl_telefono',
              @w_campo = 'te_valor',
              @w_valor_ant = @v_valor,
              @w_valor_nue = @w_valor,
              @w_secuencial1 = 1,
              @w_secuencial2 = 2

            insert into cl_actualiza
                        (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                         ac_valor_nue,ac_transaccion,ac_secuencial1,
                         ac_secuencial2
            )
            values      (@w_ente,@w_fecha,@w_tabla,@w_campo,@w_valor_ant,
                         @w_valor_nue,'U',@w_secuencial1,@w_secuencial2 )

            if @@error <> 0
            begin
              /* Error en insercion de registro */
              exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 107100
              return 1
            end
          end
        end

        select
          @o_regispasalog = @o_regispasalog + 1

        fetch cursor_ente_migUp into @v_ente,
                                     @v_subtipo,
                                     @v_tipo_ced,
                                     @v_ced_ruc,
                                     @v_sigla,
                                     @v_nombre,
                                     @v_p_apellido,
                                     @v_s_apellido,
                                     @v_fecha_nac,
                                     @v_sexo,
                                     @v_fecha_crea,
                                     @v_actividad,
                                     @v_sector,
                                     @v_oficial,
                                     @v_tipo_compania,
                                     @v_retencion,
                                     @v_oficina,
                                     @v_filial,
                                     @v_mala_referencia,
                                     @v_tipo_soc,
                                     @v_tipo_persona,
                                     @v_asosciada,
                                     @v_banca,
                                     @v_depa_nac,
                                     @v_depa_emi,
                                     @v_ciudad_nac,
                                     @v_exc_sipla,
                                     @v_exc_por2,
                                     @v_situacion_cliente,
                                     @v_nomlar,
                                     @v_digito,
                                     @v_descripcion,
                                     @v_mercado_objetivo,
                                     @v_subtipo_mo,
                                     @v_valor

      end

      close cursor_ente_migUp
      deallocate cursor_ente_migUp

      fetch cursor_ente_mig into @w_ente,
                                 @w_subtipo,
                                 @w_tipo_ced,
                                 @w_ced_ruc,
                                 @w_sigla,
                                 @w_nombre,
                                 @w_p_apellido,
                                 @w_s_apellido,
                                 @w_fecha_nac,
                                 @w_sexo,
                                 @w_fecha_crea,
                                 @w_actividad,
                                 @w_sector,
                                 @w_oficial,
                                 @w_tipo_compania,
                                 @w_retencion,
                                 @w_oficina,
                                 @w_filial,
                                 @w_mala_referencia,
                                 @w_tipo_soc,
                                 @w_tipo_persona,
                                 @w_asosciada,
                                 @w_banca,
                                 @w_depa_nac,
                                 @w_depa_emi,
                                 @w_ciudad_nac,
                                 @w_exc_sipla,
                                 @w_exc_por2,
                                 @w_situacion_cliente,
                                 @w_nomlar,
                                 @w_digito,
                                 @w_descripcion,
                                 @w_mercado_objetivo,
                                 @w_subtipo_mo,
                                 @w_valor

    end

    close cursor_ente_mig
    deallocate cursor_ente_mig

  end

  return 0

go

