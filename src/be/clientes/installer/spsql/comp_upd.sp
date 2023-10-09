/*************************************************************************/
/*  Archivo:         comp_upd.sp                                         */
/*  Stored procedure:   sp_compania_upd                                  */
/*  Base de datos:      cobis                                            */
/*  Producto: Clientes                                                   */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                           */
/*  Fecha de documentacion: 10/Nov/1993                                  */
/*************************************************************************/
/*              IMPORTANTE                                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de 'COBISCorp'.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/*************************************************************************/
/*              PROPOSITO                                                */
/*  Este stored procedure procesa:                                       */
/*  Actualizacion de los datos generales de entes tipo compania          */
/*  si ya es cliente actualiza en la cl_cliente                          */
/*************************************************************************/
/*              MODIFICACIONES                                           */
/*  FECHA       AUTOR         RAZON                                      */
/*  05/Abr/2010 R. Altamirano Control de vigencia de datos del Ente      */
/*  24/Ene/12   L. Moreno     Se cambia fecha proceso por fecha sistema  */
/*  02/Feb/2012 G. Cuesta     requerimiento 0309 Bancamia                */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/*************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_compania_upd')
  drop proc sp_compania_upd
go

create proc sp_compania_upd
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
  @i_vinculacion        char(1) = null,
  @i_tipo_vinculacion   catalogo = null,
  @i_tipo_nit           char(2),
  @i_referido           smallint = null,
  @i_sector             catalogo = null,
  @i_tipo_soc           catalogo,
  @i_fecha_emision      datetime = null,
  @i_lugar_doc          int = null,
  @i_total_activos      money = null,
  @i_num_empleados      smallint = null,
  @i_sigla              varchar(25) = null,
  @i_doc_validado       char(1) = null,
  @i_gran_contribuyente char(1) = null,
  @i_preferen           char(1) = null,
  @i_situacion_cliente  catalogo = null,
  @i_patrim_tec         money = null,
  @i_fecha_patrim_bruto datetime = null,
  @i_rep_superban       char(1),
  @i_exc_sipla          char(1) = null,
  @i_exc_por2           char(1) = null,
  @i_nivel_ing          money = null,
  @i_nivel_egr          money = null,
  @i_categoria          catalogo = null,
  @i_tipo_productor     catalogo = null,
  @i_regimen_fiscal     catalogo = null,
  @i_rioe               char(1) = null,
  @i_impuesto_vtas      char(1) = null,
  @i_pas_finan          money = null,--Valor de deuda del sector financiero
  @i_fpas_finan         datetime = null,

  --Fecha de corte de deuda del sector financiero
  @i_opInter            char(1) = null,--GustavoC
  @i_otringr            descripcion = null,
  @i_doctos_carpeta     char(1) = 'N',-- FCP 20/NOV/2005 REQ 445
  @i_exento_cobro       char(1) = null,--Req. 880 Exento de Cobro
  @i_sgp                catalogo = null,-- Req credito mallas
  @i_tipo_persona       catalogo = null,
  @i_crea_ext           char(1) = null,-- Req 428
  @o_msg_msv            varchar(255) = null out,--Req 428
  @o_siguiente          int = null out,
  @o_dif_oficial        tinyint = null out
)
as
  declare
    @w_today              datetime,
    @w_sp_name            varchar(32),
    @w_return             int,
    @w_es_grupo           char(1),
    @w_era_grupo          char(1),
    @w_codigo             int,
    @w_nombre             varchar(50),
    @w_actividad          catalogo,
    @w_posicion           catalogo,
    @w_ruc                numero,
    @w_cambio             char(1),
    @w_fecha_mod          datetime,
    @w_grupo              int,
    @w_grupo_aso          int,
    @w_activo             money,
    @w_pasivo             money,
    @w_tipo               catalogo,
    @w_pais               smallint,
    @w_filial             tinyint,
    @w_oficina            smallint,
    @w_comentario         varchar(254),
    @w_nombre_completo    varchar(64),
    @w_oficial            smallint,
    @w_retencion          char(1),
    @w_asosciada          catalogo,
    @w_tipo_vinculacion   catalogo,
    @w_mala_referencia    char(1),
    @w_tipo_nit           char(2),
    @w_referido           smallint,
    @w_sector             catalogo,
    @w_tipo_soc           catalogo,
    @w_catalogo           catalogo,
    @w_fecha_emision      datetime,
    @w_lugar_doc          int,
    @w_total_activos      money,
    @w_num_empleados      smallint,
    @w_sigla              varchar(25),
    @w_doc_validado       char(1),
    @w_gran_contribuyente char(1),
    @w_situacion_cliente  catalogo,
    @w_patrim_tec         money,
    @w_fecha_patrim_bruto char(10),
    @w_rep_superban       char(1),
    @w_vinculacion        char(1),
    @w_rioe               char(1),
    @w_impuesto_vtas      char(1),
    @w_secuencial         int,
    @w_tipo_persona       catalogo,
    @v_nombre             varchar(50),
    @v_actividad          catalogo,
    @v_posicion           catalogo,
    @v_ruc                numero,
    @v_grupo              int,
    @v_es_grupo           char(1),
    @v_activo             money,
    @v_pasivo             money,
    @v_tipo               catalogo,
    @v_pais               smallint,
    @v_filial             tinyint,
    @v_oficina            smallint,
    @v_comentario         varchar(254),
    @v_oficial            smallint,
    @v_oficial_ant        smallint,
    @v_retencion          char(1),
    @v_asosciada          catalogo,
    @v_tipo_vinculacion   catalogo,
    @v_mala_referencia    char(1),
    @v_tipo_nit           char(2),
    @v_referido           smallint,
    @v_sector             catalogo,
    @v_tipo_soc           catalogo,
    @v_fecha_emision      datetime,
    @v_lugar_doc          int,
    @v_total_activos      money,
    @v_num_empleados      smallint,
    @v_doc_validado       char(1),
    @v_sigla              varchar(25),
    @v_rep_superban       char(1),
    @v_situacion_cliente  catalogo,
    @w_preferen           char(1),
    @v_preferen           char(1),
    @v_vinculacion        char(1),
    @w_exc_sipla          char(1),
    @v_exc_sipla          char(1),
    @w_exc_por2           char(1),
    @v_exc_por2           char(1),
    @w_nivel_ing          money,
    @v_nivel_ing          money,
    @w_nivel_egr          money,
    @v_nivel_egr          money,
    @w_nomlar             varchar(64),
    @v_nomlar             varchar(64),
    @v_categoria          catalogo,
    @w_categoria          catalogo,
    @v_tipo_productor     catalogo,
    @w_tipo_productor     catalogo,
    @v_regimen_fiscal     catalogo,
    @w_regimen_fiscal     catalogo,
    @v_rioe               char(1),
    @v_impuesto_vtas      char(1),
    @v_pas_finan          money,--Valor de deuda del sector financiero
    @v_fpas_finan         datetime,
    --Fecha de corte de deuda del sector financiero
    @w_pas_finan          money,--Valor de deuda del sector financiero
    @w_fpas_finan         datetime,
    --Fecha de corte de deuda del sector financiero
    @w_relinter           char(1),--GustavoC
    @v_relinter           char(1),--GustavoC
    @w_otringr            descripcion,
    @v_otringr            descripcion,
    @w_doctos_carpeta     char(1),-- FCP 20/NOV/2005 REQ 445
    @v_doctos_carpeta     char(1),-- FCP 20/NOV/2005 REQ 445
    @w_banca              catalogo,-- IFJ - Ivan Jimenez
    @w_mercado            catalogo,-- IFJ - Ivan Jimenez
    @w_subtipo            catalogo,-- IFJ - Ivan Jimenez
    @w_sgp                catalogo,-- Req credito mallas
    @v_sgp                catalogo,-- Req credito mallas
    @w_bloqueado          char(1),
    @v_tipo_persona       catalogo,
    @w_vigencia           catalogo,
    --ream 05.abr.2010 control vigencia de datos del ente
    @v_vigencia           catalogo,
    --ream 05.abr.2010 control vigencia de datos del ente
    /* CAMPOS NUEVOR REQ_000309_CNB */
    @w_tipo_cl            varchar(10),
    @w_cod_rcnb           int,
    @w_cod_ccba           int,
    @w_commit             char(1)

  select
    @w_today = getdate()
  select
    @w_sp_name = 'sp_compania_upd'

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
    @w_commit = 'N'

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

  /* Update */
  if @i_operacion = 'U'
  begin
    if @t_trn = 106
    begin
      if @i_tipo_nit is null
          or @i_ruc is null
      begin
        if @i_crea_ext is null
        begin
          print
      'Número de Identificación o Tipo de Identificación con valores nulos'
          select
            @w_return = 601001
          goto ERROR_FIN
        end
        else
        begin
          select
            @o_msg_msv =
        'Número de Identificación o Tipo de Identificación con valores nulos'
          select
            @w_return = 601001
          goto ERROR_FIN
        end
      end

      /* capturar los datos grabados anteriormente */
      select
        @w_nombre = en_nombre,
        @w_actividad = en_actividad,
        @w_posicion = c_posicion,
        @w_fecha_mod = en_fecha_mod,
        @w_ruc = en_ced_ruc,
        @w_grupo = en_grupo,
        @w_activo = c_activo,
        @w_pasivo = c_pasivo,
        @w_tipo = c_tipo_compania,
        @w_pais = en_pais,
        @w_era_grupo = c_es_grupo,
        @w_es_grupo = c_es_grupo,
        @w_oficial = en_oficial,
        @w_oficina = en_oficina,
        @w_retencion = en_retencion,
        @w_comentario = en_comentario,
        @w_tipo_vinculacion = en_tipo_vinculacion,
        @w_vinculacion = en_vinculacion,
        --@w_tipo_nit           = c_tipo_nit,
        @w_tipo_nit = en_tipo_ced,
        @w_referido = en_referido,
        @w_sector = en_sector,
        @w_tipo_soc = c_tipo_soc,
        @w_fecha_emision = p_fecha_emision,
        @w_lugar_doc = p_lugar_doc,
        @w_total_activos = c_total_activos,
        @w_num_empleados = c_num_empleados,
        @w_doc_validado = en_doc_validado,
        @w_sigla = c_sigla,
        @w_gran_contribuyente = en_gran_contribuyente,
        @w_situacion_cliente = en_situacion_cliente,
        @w_patrim_tec = en_patrimonio_tec,
        @w_fecha_patrim_bruto = convert(char(10), en_fecha_patri_bruto, 103),
        @w_rep_superban = en_rep_superban,
        @w_preferen = en_preferen,
        @w_exc_sipla = en_exc_sipla,
        @w_exc_por2 = en_exc_por2,
        @w_nivel_ing = p_nivel_ing,
        @w_nivel_egr = p_nivel_egr,
        @w_nomlar = en_nomlar,
        @w_categoria = en_categoria,
        @w_tipo_productor = en_casilla_def,
        @w_regimen_fiscal = en_asosciada,
        @w_rioe = en_rep_sib,
        @w_impuesto_vtas = en_reestructurado,
        @w_pas_finan = en_pas_finan,
        @w_fpas_finan = en_fpas_finan,
        @w_relinter = en_relacint,--gustavoc
        @w_doctos_carpeta = en_doctos_carpeta,-- FCP 20/NOV/2005 REQ 445
        @w_otringr = en_otringr,
        @w_sgp = s_tipo_soc_hecho,
        @w_tipo_persona = p_tipo_persona,
        @w_vigencia = c_vigencia
      --ream 05.abr.2010 control vigencia de datos del ente
      from   cl_ente
      where  en_ente    = @i_compania
         and en_subtipo = 'C'

      if @@rowcount = 0
      begin
        select
          @w_return = 151030
        goto ERROR_FIN /*'No existe compania'*/
      end
      /* comprobar que no se trate de ingresar el ruc de otra compania que ya existe */
      if exists (select
                   ruc
                 from   cl_compania
                 where  ruc      = @i_ruc
                    and tipo_doc = @i_tipo_nit
                    and compania <> @i_compania)
      begin
        select
          @w_return = 101061
        goto ERROR_FIN /* 'Dato ya existe'*/
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
          goto ERROR_FIN /*'No existe posicion de compania'*/
        end
      end

      if not exists (select
                       pa_pais
                     from   cl_pais
                     where  pa_pais = @i_pais)
      begin
        select
          @w_return = 101018
        goto ERROR_FIN /*'No existe el pais indicado'*/
      end

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
          goto ERROR_FIN /*'No existe actividad de compania'*/

        end
      end

      /* verificar que exista el sector  */
      if @i_sector is not null
      begin
        select
          *
        from   cl_catalogo c1,
               cl_tabla t1
        where  t1.codigo = c1.tabla
           and t1.tabla  = 'cl_sectoreco'
           and c1.codigo = @i_sector

        if @@rowcount = 0
        begin
          select
            @w_return = 101048
          goto ERROR_FIN /*'No existe sector economico'*/
        end
      end

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
          goto ERROR_FIN /*    'No existe tipo de compania'*/
        end
      end

      select
        @w_codigo = null
      from   cc_oficial
      where  oc_oficial = @i_oficial

      if @@rowcount = 0
         and @i_oficial is not null
      begin
        select
          @w_return = 101036
        goto ERROR_FIN /* 'No existe oficial'*/
      end

      /* Verificar que exista la ciudad  --se comenta ya q no aplica para compa¤ias
      select @w_codigo = null
      from cl_ciudad
      where ci_ciudad = @i_lugar_doc
      if @@rowcount = 0 and @i_lugar_doc is not null
      begin
         select @w_return  = 101024
         goto ERROR_FIN   'No existe ciudad'
      end*/

      if @i_tipo_vinculacion is not null
      /* verificar que exista relacion con el banco  */
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_relacion_banco')
           and codigo = @i_tipo_vinculacion

        if @@rowcount = 0
        begin
          select
            @w_return = 101173
          goto ERROR_FIN /*'No existe tipo de Vinculacion'*/
        end
      end

      if @i_tipo_vinculacion is not null
      begin
        select
          @w_vinculacion = 'S'
      end
      else
      begin
        select
          @w_vinculacion = 'N'
      end

      if @i_grupo is not null
      begin
        if not exists (select
                         1
                       from   cl_grupo
                       where  gr_grupo = @i_grupo)
        begin
          select
            @w_return = 151029
          goto ERROR_FIN /*'No existe grupo'*/
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
            @o_dif_oficial = 1
        end
      end

      if @i_retencion not in ('N', 'S')
      begin
        /* parametro invalido */
        select
          @w_return = 101114
        goto ERROR_FIN
      end

      if @i_exc_sipla not in ('N', 'S')
      begin
        /* parametro invalido */
        select
          @w_return = 101114
        goto ERROR_FIN
      end

      if @i_exc_por2 not in ('N', 'S')
      begin
        /* parametro invalido */
        select
          @w_return = 101114
        goto ERROR_FIN
      end

      /* guardar solo los datos que han cambiado */
      select
        @v_nombre = @w_nombre,
        @v_actividad = @w_actividad,
        @v_posicion = @w_posicion,
        @v_ruc = @w_ruc,
        @v_grupo = @w_grupo,
        @v_activo = @w_activo,
        @v_pasivo = @w_pasivo,
        @v_tipo = @w_tipo,
        @v_pais = @w_pais,
        @v_es_grupo = @w_es_grupo,
        @v_oficial = @w_oficial,
        @v_oficial_ant = @w_oficial,
        @v_retencion = @w_retencion,
        @v_comentario = @w_comentario,
        @v_tipo_vinculacion = @w_tipo_vinculacion,
        @v_tipo_nit = @w_tipo_nit,
        @v_referido = @w_referido,
        @v_sector = @w_sector,
        @v_tipo_soc = @w_tipo_soc,
        @v_fecha_emision = @w_fecha_emision,
        @v_lugar_doc = @w_lugar_doc,
        @v_total_activos = @w_total_activos,
        @v_num_empleados = @w_num_empleados,
        @v_doc_validado = @w_doc_validado,
        @v_sigla = @w_sigla,
        @v_rep_superban = @w_rep_superban,
        @v_preferen = @w_preferen,
        @v_exc_sipla = @w_exc_sipla,
        @v_exc_por2 = @w_exc_por2,
        @v_nivel_ing = @w_nivel_ing,
        @v_nivel_egr = @w_nivel_egr,
        @v_nomlar = @w_nomlar,
        @v_situacion_cliente = @w_situacion_cliente,
        @v_categoria = @w_categoria,
        @v_tipo_productor = @w_tipo_productor,
        @v_regimen_fiscal = @w_regimen_fiscal,
        @v_rioe = @w_rioe,
        @v_impuesto_vtas = @w_impuesto_vtas,
        @v_pas_finan = @w_pas_finan,
        @v_fpas_finan = @w_fpas_finan,
        @v_relinter = @w_relinter,--gustavoc
        @v_doctos_carpeta = @w_doctos_carpeta,-- FCP 20/NOV/2005 REQ 445
        @v_otringr = @w_otringr,
        @v_sgp = @w_sgp,
        @v_tipo_persona = @w_tipo_persona,
        @v_vigencia = @w_vigencia
      --ream 05.abr.2010 control vigencia de datos del ente

      select
        @w_nombre_completo = @i_nombre + ' ' + @i_sigla

      if @w_nombre = @i_nombre
        select
          @w_nombre = null,
          @v_nombre = null
      else
        select
          @w_nombre = @i_nombre,
          @w_cambio = 'S'

      if @w_nomlar = @w_nombre_completo
        select
          @w_nomlar = null,
          @v_nomlar = null
      else
        select
          @w_nomlar = @w_nombre_completo

      if @w_comentario = @i_comentario
        select
          @w_comentario = null,
          @v_comentario = null
      else
        select
          @w_comentario = @i_comentario

      if @w_retencion = @i_retencion
        select
          @w_retencion = null,
          @v_retencion = null
      else
        select
          @w_retencion = @i_retencion

      if @w_exc_sipla = @i_exc_sipla
        select
          @w_exc_sipla = null,
          @v_exc_sipla = null
      else
        select
          @w_exc_sipla = @i_exc_sipla

      if @w_exc_por2 = @i_exc_por2
        select
          @w_exc_por2 = null,
          @v_exc_por2 = null
      else
        select
          @w_exc_por2 = @i_exc_por2

      if @w_pais = @i_pais
        select
          @w_pais = null,
          @v_pais = null
      else
        select
          @w_pais = @i_pais

      if @w_actividad = @i_actividad
        select
          @w_actividad = null,
          @v_actividad = null
      else
        select
          @w_actividad = @i_actividad

      if @w_situacion_cliente = @i_situacion_cliente
        select
          @w_situacion_cliente = null,
          @v_situacion_cliente = null
      else
        select
          @w_situacion_cliente = @i_situacion_cliente

      if @w_posicion = @i_posicion
        select
          @w_posicion = null,
          @v_posicion = null
      else
        select
          @w_posicion = @i_posicion

      if @w_ruc = @i_ruc
        select
          @w_ruc = null,
          @v_ruc = null
      else
        select
          @w_ruc = @i_ruc

      if @w_grupo = @i_grupo
        select
          @w_grupo = null,
          @v_grupo = null
      else
        select
          @w_grupo = @i_grupo

      if @w_es_grupo = @i_es_grupo
        select
          @w_es_grupo = null,
          @v_es_grupo = null
      else
        select
          @w_es_grupo = @i_es_grupo

      if @w_activo = @i_activo
        select
          @w_activo = null,
          @v_activo = null
      else
        select
          @w_activo = @i_activo

      if @w_pasivo = @i_pasivo
        select
          @w_pasivo = null,
          @v_pasivo = null
      else
        select
          @w_pasivo = @i_pasivo

      if @w_tipo = @i_tipo
        select
          @w_tipo = null,
          @v_tipo = null
      else
        select
          @w_tipo = @i_tipo

      if @w_oficial = @i_oficial
        select
          @w_oficial = null,
          @v_oficial = null
      else
        select
          @w_oficial = @i_oficial

      if @w_asosciada = @i_asosciada
        select
          @w_asosciada = null,
          @v_asosciada = null
      else
        select
          @w_asosciada = @i_asosciada

      if @w_tipo_vinculacion = @i_tipo_vinculacion
        select
          @w_tipo_vinculacion = null,
          @v_tipo_vinculacion = null
      else
        select
          @w_tipo_vinculacion = @i_tipo_vinculacion

      if @w_vinculacion = @v_vinculacion
        select
          @v_vinculacion = null

      if @w_tipo_nit = @i_tipo_nit
        select
          @w_tipo_nit = null,
          @v_tipo_nit = null
      else
        select
          @w_tipo_nit = @i_tipo_nit

      if @w_referido = @i_referido
        select
          @w_referido = null,
          @v_referido = null
      else
        select
          @w_referido = @i_referido

      if @w_sector = @i_sector
        select
          @w_sector = null,
          @v_sector = null
      else
        select
          @w_sector = @i_sector

      if @w_tipo_soc = @i_tipo_soc
        select
          @w_tipo_soc = null,
          @v_tipo_soc = null
      else
        select
          @w_tipo_soc = @i_tipo_soc

      if @w_fecha_emision = @i_fecha_emision
        select
          @w_fecha_emision = null,
          @v_fecha_emision = null
      else
        select
          @w_fecha_emision = @i_fecha_emision

      if @w_lugar_doc = @i_lugar_doc
        select
          @w_lugar_doc = null,
          @v_lugar_doc = null
      else
        select
          @w_lugar_doc = @i_lugar_doc

      if @w_total_activos = @i_total_activos
        select
          @w_total_activos = null,
          @v_total_activos = null
      else
        select
          @w_total_activos = @i_total_activos

      if @w_nivel_ing = @i_nivel_ing
        select
          @w_nivel_ing = null,
          @v_nivel_ing = null
      else
        select
          @w_nivel_ing = @i_nivel_ing

      if @w_nivel_egr = @i_nivel_egr
        select
          @w_nivel_egr = null,
          @v_nivel_egr = null
      else
        select
          @w_nivel_egr = @i_nivel_egr

      if @w_num_empleados = @i_num_empleados
        select
          @w_num_empleados = null,
          @v_num_empleados = null
      else
        select
          @w_num_empleados = @i_num_empleados

      if @w_sigla = @i_sigla
        select
          @w_sigla = null,
          @v_sigla = null
      else
        select
          @w_sigla = @i_sigla

      if @w_doc_validado = @i_doc_validado
        select
          @w_doc_validado = null,
          @v_doc_validado = null
      else
        select
          @w_doc_validado = @i_doc_validado

      if @w_rep_superban = @i_rep_superban
        select
          @w_rep_superban = null,
          @v_rep_superban = null
      else
        select
          @w_rep_superban = @i_rep_superban

      if @w_preferen = @i_preferen
        select
          @w_preferen = null,
          @v_preferen = null
      else
        select
          @w_preferen = @i_preferen

      if @w_categoria = @i_categoria
        select
          @w_categoria = null,
          @v_categoria = null
      else
        select
          @w_categoria = @i_categoria

      if @w_tipo_productor = @i_tipo_productor
        select
          @w_tipo_productor = null,
          @v_tipo_productor = null
      else
        select
          @w_tipo_productor = @i_tipo_productor

      if @w_regimen_fiscal = @i_regimen_fiscal
        select
          @w_regimen_fiscal = null,
          @v_regimen_fiscal = null
      else
        select
          @w_regimen_fiscal = @i_regimen_fiscal

      if @w_rioe = @i_rioe
        select
          @w_rioe = null,
          @v_rioe = null
      else
        select
          @w_rioe = @i_rioe

      if @w_impuesto_vtas = @i_impuesto_vtas
        select
          @w_impuesto_vtas = null,
          @v_impuesto_vtas = null
      else
        select
          @w_impuesto_vtas = @i_impuesto_vtas
      --REQ 230
      if @w_pas_finan = @i_pas_finan
        select
          @w_pas_finan = null,
          @v_pas_finan = null
      else
        select
          @w_pas_finan = @i_pas_finan

      if @w_relinter = @i_opInter --gustavoc
        select
          @w_relinter = null,
          @v_relinter = null
      else
        select
          @w_relinter = @i_opInter

      if @w_sgp = @i_sgp
        select
          @w_sgp = null,
          @v_sgp = null
      else
        select
          @w_sgp = @i_sgp

      select
        @w_vigencia = null,
        @v_vigencia = null --ream 05.abr.2010 control vigencia de datos del ente

      /*MGV Buscar estado de bloqueo del ente por informacion incompleta       */
      exec @w_return = sp_ente_bloqueado
        @s_ssn       = @s_ssn,
        @s_user      = @s_user,
        @s_term      = @s_term,
        @s_date      = @s_date,
        @s_srv       = @s_srv,
        @s_lsrv      = @s_lsrv,
        @s_ofi       = @s_ofi,
        @s_rol       = @s_rol,
        @s_org_err   = @s_org_err,
        @s_error     = @s_error,
        @s_sev       = @s_sev,
        @s_msg       = @s_msg,
        @s_org       = @s_org,
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @t_from,
        @t_trn       = 176,
        @i_operacion = 'U',
        @i_ente      = @i_compania,
        @o_retorno   = @w_bloqueado output

      if @w_return <> 0
      begin
        goto ERROR_FIN
      end
      /* MGV Fin Buscar       */
      if @@trancount = 0
      begin
        begin tran
        select
          @w_commit = 'S'
      end

      if @i_doc_validado <> 'S'
      --sli NR702 Validacion en linea de inform. cliente
      begin
        update cl_ente
        set    en_nombre = @i_nombre,
               en_actividad = @i_actividad,
               --c_posicion          = @i_posicion,
               en_ced_ruc = @i_ruc,
               en_grupo = @i_grupo,
               c_es_grupo = @i_es_grupo,
               en_pais = @i_pais,
               c_activo = @i_activo,
               c_pasivo = @i_pasivo,
               c_tipo_compania = @i_tipo,
               en_comentario = @i_comentario,
               en_oficial = @i_oficial,
               en_fecha_mod = @w_today,
               en_tipo_vinculacion = @i_tipo_vinculacion,
               en_vinculacion = @w_vinculacion,
               en_tipo_ced = @i_tipo_nit,
               en_referido = @i_referido,
               en_sector = @i_sector,
               c_tipo_soc = @i_tipo_soc,
               p_fecha_emision = @i_fecha_emision,
               p_lugar_doc = @i_lugar_doc,
               c_total_activos = @i_total_activos,
               c_num_empleados = @i_num_empleados,
               en_doc_validado = isnull(@i_doc_validado,
                                        en_doc_validado),
               en_nomlar = @w_nombre_completo,
               c_sigla = @i_sigla,
               en_situacion_cliente = @i_situacion_cliente,
               --            en_gran_contribuyente = @i_gran_contribuyente,  FRI - 01/22/2007 NR566
               en_patrimonio_tec = @i_patrim_tec,
               en_fecha_patri_bruto = @i_fecha_patrim_bruto,
               en_rep_superban = @i_rep_superban,
               en_preferen = @i_preferen,
               en_exc_sipla = @i_exc_sipla,
               en_exc_por2 = @i_exc_por2,
               p_nivel_ing = @i_nivel_ing,
               p_nivel_egr = @i_nivel_egr,
               en_categoria = @i_categoria,
               en_casilla_def = @i_tipo_productor,
               --            en_asosciada          = @i_regimen_fiscal, FRI - 01/22/2007 NR566
               en_rep_sib = @i_rioe,
               --            en_reestructurado     = @i_impuesto_vtas, FRI - 01/22/2007 NR566
               en_pas_finan = @i_pas_finan,
               en_fpas_finan = @i_fpas_finan,
               en_relacint = @i_opInter,--gustavoc
               en_otringr = @i_otringr,
               en_doctos_carpeta = @i_doctos_carpeta,--FCP 20/NOV/2005 REQ 445
               en_exento_cobro = @i_exento_cobro,
               s_tipo_soc_hecho = @i_sgp,--Req credito mallas
               en_tipo_dp = @w_bloqueado,
               -- en_tipo_dp estado de bloqueo información incompleta MGV 04/07/2006
               p_tipo_persona = @i_tipo_persona,
               c_vigencia = isnull(@w_vigencia,
                                   c_vigencia)
        --ream 05.abr.2010 control vigencia de datos del ente
        where  en_ente    = @i_compania
           and en_subtipo = 'C'

        if @@error <> 0
        begin
          select
            @w_return = 105006
          goto ERROR_FIN /* 'Error en actualizacion de compania'*/
        end
      end
      else
      begin
        update cl_ente
        set    en_actividad = @i_actividad,
               --c_posicion              = @i_posicion,
               en_grupo = @i_grupo,
               c_es_grupo = @i_es_grupo,
               en_pais = @i_pais,
               c_activo = @i_activo,
               c_pasivo = @i_pasivo,
               c_tipo_compania = @i_tipo,
               en_comentario = @i_comentario,
               en_oficial = @i_oficial,
               en_fecha_mod = @w_today,
               en_tipo_vinculacion = @i_tipo_vinculacion,
               en_vinculacion = @w_vinculacion,
               en_referido = @i_referido,
               en_sector = @i_sector,
               c_tipo_soc = @i_tipo_soc,
               p_fecha_emision = @i_fecha_emision,
               p_lugar_doc = @i_lugar_doc,
               c_total_activos = @i_total_activos,
               c_num_empleados = @i_num_empleados,
               en_doc_validado = isnull(@i_doc_validado,
                                        en_doc_validado),
               c_sigla = @i_sigla,
               en_situacion_cliente = @i_situacion_cliente,
               en_patrimonio_tec = @i_patrim_tec,
               en_fecha_patri_bruto = @i_fecha_patrim_bruto,
               en_rep_superban = @i_rep_superban,
               en_preferen = @i_preferen,
               en_exc_sipla = @i_exc_sipla,
               en_exc_por2 = @i_exc_por2,
               p_nivel_ing = @i_nivel_ing,
               p_nivel_egr = @i_nivel_egr,
               en_categoria = @i_categoria,
               en_casilla_def = @i_tipo_productor,
               en_rep_sib = @i_rioe,
               en_pas_finan = @i_pas_finan,
               en_fpas_finan = @i_fpas_finan,
               en_relacint = @i_opInter,--gustavoc
               en_otringr = @i_otringr,
               en_doctos_carpeta = @i_doctos_carpeta,--FCP 20/NOV/2005 REQ 445
               en_exento_cobro = @i_exento_cobro,
               s_tipo_soc_hecho = @i_sgp,--Req credito mallas
               en_tipo_dp = @w_bloqueado,
               -- en_tipo_dp estado de bloqueo información incompleta MGV 04/07/2006
               p_tipo_persona = @i_tipo_persona,
               c_vigencia = isnull(@w_vigencia,
                                   c_vigencia)
        --ream 05.abr.2010 control vigencia de datos del ente
        where  en_ente    = @i_compania
           and en_subtipo = 'C'

        if @@error <> 0
        begin
          select
            @w_return = 105006
          goto ERROR_FIN /* 'Error en actualizacion de compania'*/
        end
      end --validacion en_doc_validado sli

      /* transaccion de servicio - previo */
      insert into ts_compania
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,compania,nombre,
                   ruc,actividad,posicion,grupo,activo,
                   pasivo,tipo,pais,filial,oficina,
                   casilla_def,tipo_dp,retencion,comentario,es_grupo,
                   oficial,fecha_mod,asosciada,tipo_nit,referido,
                   sector,tipo_soc,fecha_emision,lugar_doc,total_activos,
                   num_empleados,sigla,doc_validado,rep_superban,
                   tipo_vinculacion,
                   vinculacion,exc_sipla,nivel_ing,nivel_egr,exc_por2,
                   categoria,pas_finan,fpas_finan,opinternac,vigencia)
      --ream 05.abr.2010 control vigencia de datos del ente
      values      ( @s_ssn,@t_trn,'P',@s_date,@s_user,
                    @s_term,@s_srv,@s_lsrv,@i_compania,@v_nombre,
                    @v_ruc,@v_actividad,@v_posicion,@v_grupo,@v_activo,
                    @v_pasivo,@v_tipo,@v_pais,@w_filial,@w_oficina,
                    @v_tipo_productor,@v_rioe,@v_retencion,@v_comentario,
                    @v_es_grupo
                    ,
                    @v_oficial,@w_fecha_mod,@v_regimen_fiscal,
                    @v_tipo_nit,@v_referido,
                    @v_sector,@v_tipo_soc,@v_fecha_emision,@v_lugar_doc,
                    @v_total_activos,
                    @v_num_empleados,@v_sigla,@v_doc_validado,@v_rep_superban,
                    @v_tipo_vinculacion,
                    @v_vinculacion,@v_exc_sipla,@v_nivel_ing,@v_nivel_egr,
                    @v_exc_por2,
                    @v_categoria,@v_pas_finan,@v_fpas_finan,@v_relinter,
                    @v_vigencia
      )
      --ream 05.abr.2010 control vigencia de datos del ente
      if @@error <> 0
      begin
        select
          @w_return = 103005
        goto ERROR_FIN /* 'Error en la creacion de transaccion de servicio'*/
      end

      /* transaccion de servicio - actual */
      insert into ts_compania
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,compania,nombre,
                   ruc,actividad,posicion,grupo,activo,
                   pasivo,tipo,pais,filial,oficina,
                   casilla_def,tipo_dp,retencion,comentario,es_grupo,
                   oficial,fecha_mod,asosciada,tipo_nit,referido,
                   sector,tipo_soc,fecha_emision,lugar_doc,total_activos,
                   num_empleados,sigla,doc_validado,rep_superban,
                   tipo_vinculacion,
                   vinculacion,exc_sipla,nivel_ing,nivel_egr,exc_por2,
                   categoria,pas_finan,fpas_finan,vigencia)
      --ream 05.abr.2010 control vigencia de datos del ente
      values      ( @s_ssn,@t_trn,'A',@s_date,@s_user,
                    @s_term,@s_srv,@s_lsrv,@i_compania,@w_nombre,
                    @w_ruc,@w_actividad,@w_posicion,@w_grupo,@w_activo,
                    @w_pasivo,@w_tipo,@w_pais,@w_filial,@w_oficina,
                    @w_tipo_productor,@w_rioe,@w_retencion,@w_comentario,
                    @w_es_grupo
                    ,
                    @w_oficial,@w_today,@w_regimen_fiscal,
                    @w_tipo_nit,@w_referido,
                    @w_sector,@w_tipo_soc,@w_fecha_emision,@w_lugar_doc,
                    @w_total_activos,
                    @w_num_empleados,@w_sigla,@w_doc_validado,@w_rep_superban,
                    @w_tipo_vinculacion,
                    @w_vinculacion,@w_exc_sipla,@w_nivel_ing,@w_nivel_egr,
                    @w_exc_por2,
                    @w_categoria,@w_pas_finan,@w_fpas_finan,@w_vigencia )
      --ream 05.abr.2010 control vigencia de datos del ente
      if @@error <> 0
      begin
        select
          @w_return = 103005
        goto ERROR_FIN /* 'Error en la creacion de transaccion de servicio'*/
      end

      if (@i_es_grupo = 'S')
         and (@w_era_grupo = 'S')
      begin
        select
          @w_grupo_aso = gr_grupo
        from   cl_grupo
        where  gr_compania = @i_compania

        exec @w_return = cobis..sp_grupo
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
          @t_trn       = 108,
          @i_operacion = 'U',
          @i_modo      = null,
          @i_tipo      = null,
          @i_ente      = null,
          @i_grupo     = @w_grupo_aso,
          @i_nombre    = @i_nombre,
          @i_ruc       = @i_ruc,
          @i_compania  = @i_compania,
          @i_oficial   = @i_oficial

        if @w_return <> 0
        begin
          /* 'Error en actualizacion de grupo'*/
          select
            @w_return = 105007
          goto ERROR_FIN
        end
      end

      /* Si no era grupo y ahora lo es hay que insertar instancia en cl_grupo */
      if (@i_es_grupo = 'S')
         and (@w_era_grupo = 'N')
      begin
        exec @w_return = cobis..sp_grupo
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
          @i_compania  = @i_compania,
          @i_oficial   = @i_oficial

        if @w_return <> 0
        begin
          /* 'Error en actualizacion de grupo'*/
          select
            @w_return = 105007
          goto ERROR_FIN
        end
      end

      /* si era grupo y ahora se afirma lo contrario, se envia mensaje indicando que no se pueden deshacer los grupos desde aqui */
      if (@i_es_grupo = 'N')
         and (@w_era_grupo = 'S')
      begin
        /* 'No puede deshacer el grupo desde esta aplicacion'*/
        select
          @w_return = 105065
        goto ERROR_FIN
      end

      /** modificacion req 0309 bancamia ini **/
      if @w_categoria <> @v_categoria
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','en_categoria',
                      @v_categoria,
                      @w_categoria,'U',null,null )
        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end

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

        if @w_categoria = @w_tipo_cl
        begin
          exec @w_return = cobis..sp_instancia
            @i_operacion = 'I',
            @i_relacion  = @w_cod_rcnb,
            @i_izquierda = @w_cod_ccba,
            @i_derecha   = @i_compania,
            @i_lado      = 'I',
            @t_trn       = 1367,
            @s_ssn       = @s_ssn

          if @w_return <> 0
          begin
            goto ERROR_FIN
          end
        end
        else
        begin
          if @v_categoria = @w_tipo_cl
          begin
            exec @w_return = cobis..sp_instancia
              @i_operacion ='D',
              @i_relacion  = @w_cod_rcnb,
              @i_izquierda = @w_cod_ccba,
              @i_derecha   = @i_compania,
              @t_trn       = 1368,
              @s_ssn       = @s_ssn

            if @w_return <> 0
            begin
              goto ERROR_FIN
            end
          end
        end
      end
      /** modificacion req 0309 bancamia fin **/

      if @v_nombre <> @w_nombre
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','en_nombre',@v_nombre,
                      @w_nombre,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end
      if @v_nomlar <> @w_nomlar
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','en_nomlar',@v_nomlar,
                      @w_nomlar,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end
      if @v_retencion <> @w_retencion
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','en_retencion',
                      @v_retencion,
                      @w_retencion,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end
      if @v_actividad <> @w_actividad
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','en_actividad',
                      @v_actividad,
                      @w_actividad,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end
      if @v_situacion_cliente <> @w_situacion_cliente
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','en_situacion_cliente',
                      @v_situacion_cliente,
                      @w_situacion_cliente,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end
      if @v_ruc <> @w_ruc
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','en_ced_ruc',@v_ruc,
                      @w_ruc,'U',null,null)

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end

        update cl_cliente
        set    cl_ced_ruc = @w_ruc
        where  cl_cliente = @i_compania

        if @@error <> 0
        begin
          select
            @w_return = 105006
          goto ERROR_FIN /* 'Error en actualizacion de compania'*/
        end
      end

      if @v_tipo <> @w_tipo
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','c_tipo_compania',@v_tipo,
                      @w_tipo,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end

      if @v_tipo_nit <> @w_tipo_nit
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','en_tipo_ced',@v_tipo_nit,
                      @w_tipo_nit,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end

      if @v_tipo_soc <> @w_tipo_soc
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','c_tipo_soc',@v_tipo_soc,
                      @w_tipo_soc,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end

      if @v_tipo_productor <> @w_tipo_productor
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','en_casilla_def',
                      @v_tipo_productor,
                      @w_tipo_productor,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end

      /*if @v_regimen_fiscal <> @w_regimen_fiscal
        begin
           insert into cl_actualiza
           (
           ac_ente,        ac_fecha,       ac_tabla,
           ac_campo,       ac_valor_ant,   ac_valor_nue,
           ac_transaccion, ac_secuencial1, ac_secuencial2)
           values
           (
           @i_compania,    getdate(),         'cl_ente',
           'en_asosciada', @v_regimen_fiscal, @w_regimen_fiscal,
           'U',            null,              null
           )
           if @@error <> 0
           begin
              select @w_return  = 103001
              goto ERROR_FIN  'Error en creacion de cliente'
           end
        end*/

      if @v_rioe <> @w_rioe
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','en_rep_sib',@v_rioe,
                      @w_rioe,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end

      if @v_impuesto_vtas <> @w_impuesto_vtas
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','en_reestructurado',
                      @v_impuesto_vtas,
                      @w_impuesto_vtas,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end

      if @v_exc_sipla <> @w_exc_sipla
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','en_exc_sipla',
                      @v_exc_sipla,
                      @w_exc_sipla,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end

      if @v_pas_finan <> @w_pas_finan
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','pas_finan',@v_pas_finan,
                      @w_pas_finan,'U',null,null)

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end

      if @v_sgp <> @w_sgp
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','s_tipo_soc_hecho',@v_sgp,
                      @w_sgp,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end

      if @v_fpas_finan <> @w_fpas_finan
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','pas_finan',@v_fpas_finan,
                      @w_fpas_finan,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end

      if @v_tipo_persona <> @w_tipo_persona
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
        values      ( @i_compania,getdate(),'cl_ente','p_tipo_persona',
                      @v_tipo_persona
                      ,
                      @w_tipo_persona,'U',null,null )

        if @@error <> 0
        begin
          select
            @w_return = 103001
          goto ERROR_FIN /*'Error en creacion de cliente'*/
        end
      end

      select
        @w_secuencial = isnull((select max(lf_secuencial) from cl_log_fiscal), 0
                        )
                        +
                        1

      insert into cobis..cl_log_fiscal
                  (lf_secuencial,lf_ente,lf_fecha_modifica,lf_regimenf_ant,
                   lf_regimenf_nue,
                   lf_usuario,lf_terminal)
      values      ( @w_secuencial,@i_compania,@w_today,@v_regimen_fiscal,
                    @i_regimen_fiscal,
                    @s_user,@s_term )
      -- Smora. Por defecto 7706, se modificó @w_regimen_fiscal por @i_regimen_fiscal segun instrucciones de Etna Laguna
      if @@error <> 0
      begin
        select
          @w_return = 15100032
        goto ERROR_FIN /*'Error en insercion del registro a cl_log_fiscal'*/
      end

      /*CARGA DE INFORMACION DEL CLIENTE PROVEEDORES HACIA DYNAMICS */
      if @i_tipo_persona is not null
         and @i_tipo_persona <> @w_tipo_persona
        select
          @w_tipo_persona = @i_tipo_persona

      if @w_tipo_persona in ('002', '004', '005')
      begin
        exec @w_return = cobis..sp_cobis_dynamics
          @s_ssn   = @s_ssn,
          @s_user  = @s_user,
          @s_term  = @s_term,
          @s_date  = @s_date,
          @s_srv   = @s_srv,
          @s_lsrv  = @s_lsrv,
          @s_ofi   = @s_ofi,
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @t_from,
          @i_ente  = @i_compania

        if @w_return <> 0
          --error
          goto ERROR_FIN
      end
      if @w_commit = 'S'
      begin
        commit tran
        select
          @w_commit = 'N'
      end

      return 0
    end
  end

  if @i_operacion <> 'U'
     and @i_operacion is not null
  begin
    select
      @w_return = 151051
    goto ERROR_FIN /*  'No corresponde */
  end
  return 0

  ERROR_FIN:

  if @w_commit = 'S'
  begin
    rollback tran
    select
      @w_commit = 'N'
  end

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
          @o_msg_msv = 'Error: En Actualizacion de Cliente Invocacion, ' +
                       @w_sp_name
      else
        select
          @o_msg_msv = @o_msg_msv + ', ' + @w_sp_name
    end
    return @w_return
  end

go

