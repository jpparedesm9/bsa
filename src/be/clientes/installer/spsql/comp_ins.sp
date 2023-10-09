/************************************************************************/
/*  Archivo:         comp_ins.sp                                        */
/*  Stored procedure:   sp_compania_ins                                 */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de documentacion: 10/Nov/1993                                 */
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
/*              PROPOSITO                                               */
/*  Este stored procedure procesa:                                      */
/*  Insercion de entes tipo Compa¤ia, inserta registro en la cl_ente    */
/*  y en la vista ts_compania                                           */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR            RAZON                                  */
/* 02/01/2012  German Cuesta    REQ 0309 Bancamia                       */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_compania_ins')
  drop proc sp_compania_ins
go

create proc sp_compania_ins
(
  @s_ssn                int = null,
  @s_user               login = null,
  @s_term               varchar(30) = null,
  @s_date               datetime = null,
  @s_srv                varchar(30) = null,
  @s_lsrv               varchar(30) = null,
  @s_ofi                smallint = null,
  @s_rol                smallint = null,
  @s_org_err            char(1) = null,
  @s_error              int = null,
  @s_sev                tinyint = null,
  @s_msg                descripcion = null,
  @s_org                char(1) = null,
  @t_debug              char(1) = 'N',
  @t_file               varchar(10) = null,
  @t_from               varchar(32) = null,
  @t_trn                smallint = null,
  @t_show_version       bit = 0,
  @i_operacion          char(1),
  @i_compania           int = null,
  @i_nombre             descripcion = null,
  @i_actividad          catalogo = null,
  @i_posicion           catalogo = null,
  @i_ruc                numero = null,
  @i_grupo              int = null,
  @i_activo             money = null,
  @i_pasivo             money = null,
  @i_pais               smallint = null,
  @i_filial             tinyint = null,
  @i_oficina            smallint = null,
  @i_tipo               catalogo = null,
  @i_oficial            smallint = null,
  @i_es_grupo           char(1) = 'N',
  @i_comentario         varchar(254) = null,
  @i_retencion          char(1) = null,
  @i_asosciada          catalogo = null,
  @i_tipo_vinculacion   catalogo = null,
  @i_tipo_nit           char(2),
  @i_referido           smallint = null,
  @i_sector             catalogo = null,
  @i_tipo_soc           catalogo = null,
  @i_fecha_emision      datetime = null,
  @i_lugar_doc          int = null,
  @i_total_activos      money = null,
  @i_num_empleados      smallint = null,
  @i_sigla              varchar(25) = null,
  @i_mala_referencia    char(1) = null,
  @i_situacion_cliente  catalogo = 'NOR',
  @i_gran_contribuyente char(1) = null,
  @i_patrim_tec         money = null,
  @i_fecha_patrim_bruto datetime = null,
  @i_rep_superban       char(1) = null,
  @i_preferen           char(1) = null,
  @i_exc_sipla          char(1) = null,
  @i_exc_por2           char(1) = null,
  @i_nivel_ing          money = null,
  @i_nivel_egr          money = null,
  @i_categoria          catalogo = null,
  @i_tipo_productor     catalogo = null,
  @i_regimen_fiscal     catalogo = null,
  @i_rioe               char(1) = null,
  @i_impuesto_vtas      char(1) = null,
  @i_pas_finan          money = null,
  @i_fpas_finan         datetime = null,
  @i_opInter            char(1) = null,
  @i_otringr            descripcion = null,
  @i_doctos_carpeta     char(1) = 'N',
  @i_exento_cobro       char(1) = null,
  @i_sgp                catalogo = null,
  @i_cod_central        varchar(10) = null,
  @i_doc_validado       char(1) = null,
  @i_tipo_persona       char(3) = null,

  /* req 428 */
  @i_crea_ext           char(1) = null,
  @o_msg_msv            varchar(255) = null out,

  /* fin req 428 */

  @o_siguiente          int = null out,
  @o_dif_oficial        tinyint = null out
)
as
  declare
    @w_today            datetime,
    @w_sp_name          varchar(32),
    @w_return           int,
    @w_es_grupo         char(1),
    @w_era_grupo        char(1),
    @w_codigo           int,
    @w_nombre           varchar(50),
    @w_actividad        catalogo,
    @w_catalogo         catalogo,
    @w_posicion         catalogo,
    @w_ruc              numero,
    @w_cambio           char(1),
    @w_fecha_mod        datetime,
    @w_grupo            int,
    @w_grupo_aso        int,
    @w_activo           money,
    @w_pasivo           money,
    @w_tipo             catalogo,
    @w_pais             smallint,
    @w_filial           tinyint,
    @w_oficina          smallint,
    @w_comentario       varchar(254),
    @w_oficial          smallint,
    @w_retencion        char(1),
    @w_asosciada        catalogo,
    @w_tipo_vinculacion catalogo,
    @w_vinculacion      char(1),
    @w_mala_referencia  char(1),
    @w_tipo_nit         char(2),
    @w_sector           catalogo,
    @w_tipo_soc         catalogo,
    @w_fecha_emision    datetime,
    @w_lugar_doc        int,
    @w_total_activos    money,
    @w_num_empleados    smallint,
    @w_sigla            varchar(25),
    @w_rep_superban     char(1),
    @w_exc_sipla        char(1),
    @w_exc_por2         char(1),
    @w_nivel_ing        money,
    @w_nivel_egr        money,
    @w_categoria        catalogo,
    @w_tipo_productor   catalogo,
    @w_regimen_fiscal   catalogo,
    @w_secuencial       int,
    @v_nombre           varchar(50),
    @v_actividad        catalogo,
    @v_posicion         catalogo,
    @v_ruc              numero,
    @v_grupo            int,
    @v_es_grupo         char(1),
    @v_activo           money,
    @v_pasivo           money,
    @v_tipo             catalogo,
    @v_pais             smallint,
    @v_filial           tinyint,
    @v_oficina          smallint,
    @v_comentario       varchar(254),
    @v_oficial          smallint,
    @v_oficial_ant      smallint,
    @v_retencion        char(1),
    @v_exc_sipla        char(1),
    @v_exc_por2         char(1),
    @v_asosciada        catalogo,
    @v_tipo_vinculacion catalogo,
    @v_tipo_nit         char(2),
    @v_referido         smallint,
    @v_sector           catalogo,
    @v_tipo_soc         catalogo,
    @v_fecha_emision    datetime,
    @v_lugar_doc        int,
    @v_total_activos    money,
    @v_num_empleados    smallint,
    @v_sigla            varchar(25),
    @v_mala_referencia  char(1),
    @v_rep_superban     char(1),
    @v_categoria        catalogo,
    @w_banca            catalogo,
    @w_mercado          catalogo,
    @w_subtipo          catalogo,
    @w_tip_doc          char(2),
    @w_vigencia         catalogo,
    @w_fecha_negocio    datetime,
    @w_referido         smallint,
    /* CAMPOS NUEVOR REQ_000309_CNB */
    @w_tipo_cl          varchar(10),
    @w_cod_rcnb         int,
    @w_cod_ccba         int

  select
    @w_sp_name = 'sp_compania_ins'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  -- inicio modificacion req 309
  select
    @w_cod_rcnb = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'CRCNB'

  if @@rowcount = 0
  begin
    select
      @w_return = 101254
    goto ERROR_FIN
  end

  select
    @w_tipo_cl = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'TCCNB'

  if @@rowcount = 0
  begin
    select
      @w_return = 101254
    goto ERROR_FIN
  end

  -- fin modificacion req 309

  select
    @w_today = getdate()
  select
    @w_vigencia = 'S'

  select
    @w_fecha_negocio = dateadd(mm,
                               -6,
                               @w_today)

  select
    @w_referido = fu_funcionario
  from   cobis..cl_funcionario
  where  fu_login = @s_user

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/** Stored Procedure **/' = @w_sp_name,
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
      i_operacion = @i_operacion,
      i_compania = @i_compania,
      i_nombre = @i_nombre,
      i_actividad = @i_actividad,
      i_posicion = @i_posicion,
      i_ruc = @i_ruc,
      i_grupo = @i_grupo,
      i_activo = @i_activo,
      i_pasivo = @i_pasivo,
      i_pais = @i_pais,
      i_filial = @i_filial,
      i_oficina = @i_oficina,
      i_tipo = @i_tipo,
      i_es_grupo = @i_es_grupo,
      i_comentario = @i_comentario,
      i_oficial = @i_oficial,
      i_retencion = @i_retencion,
      i_tipo_vinculacion = @i_tipo_vinculacion,
      i_tipo_nit = @i_tipo_nit,
      i_referido = @i_referido,
      i_tipo_soc = @i_tipo_soc,
      i_sector = @i_sector,
      i_fecha_emision = @i_fecha_emision,
      i_lugar_doc = @i_lugar_doc,
      i_total_activos = @i_total_activos,
      i_num_empleados = @i_num_empleados,
      i_sigla = @i_sigla,
      i_situacion_cliente = @i_situacion_cliente,
      i_gran_contribuyente = @i_gran_contribuyente,
      i_patrim_tec = @i_patrim_tec,
      i_fecha_patrim_bruto = @i_fecha_patrim_bruto,
      i_rep_superban = @i_rep_superban,
      i_exc_sipla = @i_exc_sipla,
      i_nivel_ing = @i_nivel_ing,
      i_nivel_egr = @i_nivel_egr

    exec cobis..sp_end_debug
  end
  if @i_operacion = 'V'
  begin
    if exists (select
                 1
               from   cl_ente
               where  en_ced_ruc = @i_ruc)
    begin
      select
        @w_tip_doc = en_tipo_ced
      from   cl_ente
      where  en_ced_ruc = @i_ruc

      if @i_crea_ext is null
      begin
        select
          @w_tip_doc
        print
'ERROR: El número de documento que está ingresando en la base de datos ya existe y corresponde a una:  '
      + @w_tip_doc
end
else
begin
  select
    @o_msg_msv =
'ERROR: El número de documento que está ingresando en la base de datos ya existe y corresponde a una:  '
             + @w_tip_doc
end
end
else
begin
  select
    1
end
end
  /* **** Insert *** */
  if @i_operacion = 'I'
  begin
    if @t_trn = 105
    begin
      /* comprobar que no existan datos duplicados */
      if exists (select
                   ruc
                 from   cl_compania
                 where  ruc      = @i_ruc
                    and tipo_doc = @i_tipo_nit)
      begin
        select
          @w_return = 101061
        goto ERROR_FIN
      /* 'Dato ya existe'*/
      end

      /* verificar que exista la posicion de la compania */
      if @i_posicion is not null
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_calif_cliente')
           and codigo = @i_posicion
        if @@rowcount = 0
        begin
          select
            @w_return = 101172
          goto ERROR_FIN
        /*'No existe valoracion  de compania'*/
        end
      end

      /* verificar que exista la actividad de compania */
      if @i_actividad is not null
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_actividad')
           and codigo = @i_actividad
        if @@rowcount = 0
        begin
          select
            @w_return = 101027
          goto ERROR_FIN
        /*'No existe actividad de compania'*/
        end
      end

      if @i_sector is not null
      begin
        select
          @w_catalogo = @i_sector
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_sectoreco',
          @i_codigo    = @w_catalogo
        if @w_return <> 0
        begin
          select
            @w_return = 101048
          goto ERROR_FIN
        /* 'No existe sector'*/
        end
      end

      if @i_tipo_soc is not null
      begin
        select
          @w_catalogo = @i_tipo_soc
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_tip_soc',
          @i_codigo    = @w_catalogo
        if @w_return <> 0
        begin
          select
            @w_return = 101004
          goto ERROR_FIN
        /* 'No existe tipo de sociedad'*/
        end
      end

      /* verificar que exista el tipo de compania */
      if @i_tipo is not null
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_nat_jur')
           and codigo = @i_tipo
        if @@rowcount = 0
        begin
          select
            @w_return = 101015
          goto ERROR_FIN
        /*'No existe tipo de compania'*/
        end
      end

      if @w_lugar_doc is not null
      begin
        if not exists (select
                         1
                       from   cl_ciudad
                       where  ci_ciudad = @i_lugar_doc)
        begin
          select
            @w_return = 101024
          goto ERROR_FIN
        /*'No existe esa ciudad '*/
        end
      end

      if @i_tipo_vinculacion is not null
      begin
        if not exists (select
                         1
                       from   cl_catalogo c1,
                              cl_tabla t1
                       where  t1.tabla  = 'cl_relacion_banco'
                          and t1.codigo = c1.tabla
                          and c1.codigo = @i_tipo_vinculacion)
        begin
          select
            @w_return = 101173
          goto ERROR_FIN
        /*'No existe esa relacion con el banco '*/
        end
        select
          @w_vinculacion = 'S'
      end
      else
        select
          @w_vinculacion = 'N'

      /* Verificar que exista el oficial indicado */
      select
        @w_codigo = null
      from   cc_oficial
      where  oc_oficial = @i_oficial
      if @@rowcount = 0
         and @i_oficial is not null
      begin
        select
          @w_return = 101036
        goto ERROR_FIN
      /* 'No existe oficial'*/
      end

      /* si existe codigo de grupo, asegurarse de que exista */
      if @i_grupo is not null
      begin
        if not exists (select
                         *
                       from   cl_grupo
                       where  gr_grupo = @i_grupo)
        begin
          select
            @w_return = 151029
          goto ERROR_FIN
        /*'No existe grupo'*/
        end

        /* Verificar que el oficial sea el mismo del grupo*/
        select
          @w_codigo = null
        from   cl_grupo
        where  gr_grupo   = @i_grupo
           and gr_oficial = @i_oficial

        if @@rowcount = 0
           and @i_oficial is not null
        begin
          select
            @w_return = 101115
          goto ERROR_FIN
        /* 'Oficial no corresponde al del grupo'*/
        end
      end

      if @i_retencion <> 'N'
         and @i_retencion <> 'S'
      begin
        select
          @w_return = 101114
        goto ERROR_FIN
      /* parametro invalido */
      end

      if @i_exc_sipla <> 'N'
         and @i_exc_sipla <> 'S'
      begin
        select
          @w_return = 101114
        goto ERROR_FIN
      /* parametro invalido */
      end

      if @i_exc_por2 <> 'N'
         and @i_exc_por2 <> 'S'
      begin
        select
          @w_return = 101114
        goto ERROR_FIN
      /* parametro invalido */
      end

      begin tran
      /* encontrar un nuevo secuencial para compania */
      exec sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_ente',
        @o_siguiente = @o_siguiente out

      /* validacion de no existencia de cedula y tipo de documento */
      if exists (select
                   1
                 from   cl_ente
                 where  en_tipo_ced = @i_tipo_nit
                    and en_ced_ruc  = @i_ruc)
      begin
        select
          @w_return = 101192
        goto ERROR_FIN
      end

      if @i_referido is null
        select
          @i_referido = @w_referido

      insert into cl_ente
                  (en_ente,en_subtipo,en_nombre,en_actividad,c_posicion,
                   en_ced_ruc,en_grupo,c_activo,c_pasivo,c_tipo_compania,
                   en_fecha_crea,en_fecha_mod,en_pais,en_filial,en_oficina,
                   en_direccion,en_referencia,en_casilla_def,en_tipo_dp,
                   en_casilla
                   ,
                   en_balance,c_es_grupo,p_propiedad,
                   en_comentario,en_retencion,
                   en_mala_referencia,en_oficial,en_asosciada,en_referido,
                   en_sector,
                   en_tipo_ced,c_tipo_soc,p_tipo_persona,p_fecha_emision,
                   p_lugar_doc
                   ,
                   c_total_activos,c_num_empleados,c_sigla,
                   en_rep_superban,
                   en_doc_validado,
                   en_nomlar,en_situacion_cliente,en_gran_contribuyente,
                   en_patrimonio_tec,en_fecha_patri_bruto,
                   en_tipo_vinculacion,en_vinculacion,en_preferen,en_exc_sipla,
                   p_nivel_ing,
                   p_nivel_egr,en_exc_por2,en_categoria,en_rep_sib,
                   en_reestructurado
                   ,
                   en_pas_finan,en_fpas_finan,en_relacint,en_otringr
                   ,en_exento_cobro,
                   en_doctos_carpeta,s_tipo_soc_hecho,c_vigencia,
                   en_fecha_negocio)
      values      ( @o_siguiente,'C',@i_nombre,@i_actividad,@i_posicion,
                    @i_ruc,@i_grupo,@i_activo,@i_pasivo,@i_tipo,
                    @w_today,@w_today,@i_pais,@i_filial,@i_oficina,
                    0,0,@i_tipo_productor,'S',0,
                    0,@i_es_grupo,0,@i_comentario,@i_retencion,
                    'N',@i_oficial,@i_regimen_fiscal,@i_referido,@i_sector,
                    @i_tipo_nit,@i_tipo_soc,@i_tipo_persona,@i_fecha_emision,
                    @i_lugar_doc,
                    @i_total_activos,@i_num_empleados,@i_sigla,@i_rep_superban,
                    @i_doc_validado,
                    @i_nombre + ' ' + @i_sigla,@i_situacion_cliente,
                    @i_gran_contribuyente,@i_patrim_tec,@i_fecha_patrim_bruto,
                    @i_tipo_vinculacion,@w_vinculacion,@i_preferen,@i_exc_sipla,
                    @i_nivel_ing,
                    @i_nivel_egr,@i_exc_por2,@i_categoria,@i_rioe,
                    @i_impuesto_vtas
                    ,
                    @i_pas_finan,@i_fpas_finan,@i_opInter,
                    @i_otringr,@i_exento_cobro
                    ,
                    @i_doctos_carpeta,@i_sgp,@w_vigencia,
                    @w_fecha_negocio )

      if @@error <> 0
      begin
        select
          @w_return = 103002
        goto ERROR_FIN
      /* 'Error en creacion de compania'*/
      end

      /*SLI NR702 INSERCION EN LA cl_entes_validados*/
      if @i_doc_validado = 'S'
      begin
        insert into cl_entes_validados
                    (ev_ente,ev_fecha,ev_usuario,ev_central,ev_origen)
        values      ( @o_siguiente,@w_today,@s_user,@i_cod_central,
                      'APERTURA PERSONA JURIDICA' )

        if @@error <> 0
        begin
          select
            @w_return = 103095
          goto ERROR_FIN
        /* 'Error en creacion de compania'*/
        end
      end

      if @i_mala_referencia = 'S'
      begin
        update cl_ente
        set    en_mala_referencia = 'S'
        where  en_ced_ruc = @i_ruc
      end

      /* transaccion de servicio - nuevo */
      insert into ts_compania
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,compania,nombre,
                   ruc,actividad,posicion,grupo,activo,
                   pasivo,tipo,pais,filial,oficina,
                   casilla_def,tipo_dp,retencion,mala_referencia,comentario,
                   oficial,asosciada,referido,tipo_nit,sector,
                   tipo_soc,fecha_emision,lugar_doc,total_activos,num_empleados,
                   sigla,rep_superban,doc_validado,tipo_vinculacion,vinculacion,
                   exc_sipla,nivel_ing,nivel_egr,exc_por2,categoria,
                   pas_finan,fpas_finan,opinternac,vigencia)
      values      ( @s_ssn,@t_trn,'N',getdate(),@s_user,
                    @s_term,@s_srv,@s_lsrv,@o_siguiente,@i_nombre,
                    @i_ruc,@i_actividad,@i_posicion,@i_grupo,@i_activo,
                    @i_pasivo,@i_tipo,@i_pais,@i_filial,@i_oficina,
                    @i_tipo_productor,@i_rioe,@i_retencion,'N',@i_comentario,
                    @i_oficial,@i_regimen_fiscal,@i_referido,@i_tipo_nit,
                    @i_sector
                    ,
                    @i_tipo_soc,@i_fecha_emision,@i_lugar_doc,
                    @i_total_activos,
                    @i_num_empleados,
                    @i_sigla,@i_rep_superban,'N',@i_tipo_vinculacion,
                    @w_vinculacion,
                    @w_exc_sipla,@w_nivel_ing,@w_nivel_egr,@w_exc_por2,
                    @i_categoria,
                    @i_pas_finan,@i_fpas_finan,@i_opInter,@w_vigencia )

      if @@error <> 0
      begin
        select
          @w_return = 103005
        goto ERROR_FIN
      /* 'Error en creacion de transaccion de servicio'*/
      end

    /* Si es grupo se llama a sp_grupo para crear la instancia */
      /* de grupo economico   */
      if @i_es_grupo = 'S'
      begin
        exec @w_return=cobis..sp_grupo
          @s_ssn       = @s_ssn,
          @s_user      = @s_user,
          @s_term      = @s_term,
          @s_date      = @s_date,
          @s_srv       = @s_srv,
          @s_lsrv      = @s_lsrv,
          @s_ofi       = @s_ofi,
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @t_from,
          @t_trn       = 107,
          @i_operacion = 'I',
          @i_modo      = null,
          @i_tipo      = null,
          @i_ente      = null,
          @i_grupo     = null,
          @i_nombre    = @i_nombre,
          @i_activo    = @i_activo,
          @i_pasivo    = @i_pasivo,
          @i_filial    = @i_filial,
          @i_oficina   = @i_oficina,
          @i_ruc       = @i_ruc,
          @i_compania  = @o_siguiente,
          @i_oficial   = @i_oficial,
          @i_posicion  = @i_posicion,
          @i_actividad = @i_actividad

        if @w_return <> 0
        begin
          select
            @w_return = 103066
          goto ERROR_FIN
        /* 'Error en creacion del grupo'*/
        end
      end

      if @i_regimen_fiscal is not null
      begin
        select
          @w_secuencial = isnull((select max(lf_secuencial) from cl_log_fiscal),
                          0
                          )
                          +
                          1

        insert into cobis..cl_log_fiscal
                    (lf_secuencial,lf_ente,lf_fecha_modifica,lf_regimenf_ant,
                     lf_regimenf_nue,
                     lf_usuario,lf_terminal)
        values      ( @w_secuencial,@o_siguiente,@w_today,null,@i_regimen_fiscal
                      ,
                      @s_user,@s_term )

        if @@error <> 0
        begin
          select
            @w_return = 15100032
          goto ERROR_FIN/*'Error en insercion del registro a cl_log_fiscal'*/
        end
      end
      --ini mod req 309
      if @i_categoria = @w_tipo_cl
      begin
        select
          @w_cod_ccba = pa_int
        from   cl_parametro
        where  pa_nemonico = 'CCBA'
           and pa_producto = 'CTE'

        if @@rowcount = 0
        begin
          select
            @w_return = 101254
          goto ERROR_FIN
        end

        exec @w_return = cobis..sp_instancia
          @i_operacion ='I',
          @i_relacion  = @w_cod_rcnb,
          @i_izquierda = @w_cod_ccba,
          @i_derecha   = @o_siguiente,
          @i_lado      = 'I',
          @t_trn       = 1367,
          @s_ssn       = @s_ssn
        if @w_return <> 0
        begin
          goto ERROR_FIN
        end
      end
      --fin mod req 309
      commit tran

      /* retorna el nuevo secuencial para compania */
      select
        @o_siguiente
      return 0
    end
  end

  if @i_operacion <> 'V'
     and @i_operacion <> 'I'
     and @i_operacion is not null
  begin
    select
      @w_return = 151051
    goto ERROR_FIN
  end
  return 0
  ERROR_FIN:

  if @i_crea_ext is null
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_return
    /*  'No corresponde codigo de transaccion' */
    return @w_return
  end
  else
  begin
    if @o_msg_msv is null
    begin
      select
        @o_msg_msv = mensaje
      from   cobis..cl_errores
      where  numero = @w_return

      if @@rowcount = 0
        select
          @o_msg_msv = 'Error: En Creacion de Cliente Invocacion, ' + @w_sp_name
      else
        select
          @o_msg_msv = @o_msg_msv + ', ' + @w_sp_name
    end

    return @w_return
  end

go

