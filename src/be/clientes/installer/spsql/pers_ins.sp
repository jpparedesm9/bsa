/************************************************************************/
/*  Archivo:            pers_ins.sp                                     */
/*  Stored procedure:   sp_persona_ins                                  */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 05-Nov-1992                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este stored procedure procesa:                                      */
/*  Insercion de datos generales de persona en la tabla cl_ente         */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR         RAZON                                     */
/*  05/Nov/92   M. Davila     Emision Inicial                           */
/*  03/01/2012  G. Cuesta     Requerimiento 0309 bancamia CNB           */
/*  08/02/2013  Nini Salazar  validación identidad del cliente          */
/*  09/04/2013  A. Munoz      Requerimiento 0353 Alianzas Comerciales   */
/*  05/May/2016 T. Baidal     Migracion a CEN                           */
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
           where  name = 'sp_persona_ins')
    drop proc sp_persona_ins
go

create proc sp_persona_ins
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
  @i_persona            int = null,
  @i_nombre             varchar(32) = null,
  @i_p_apellido         varchar(16) = null,
  @i_s_apellido         varchar(16) = null,
  @i_sexo               char(1) = null,
  @i_fecha_nac          datetime = null,
  @i_tipo_ced           char(2) = null,
  @i_digito             char(1) = null,
  @i_cedula             numero = null,
  @i_pasaporte          varchar(20) = null,
  @i_pais               smallint = null,
  @i_ciudad_nac         int = null,
  @i_lugar_doc          int = null,
  @i_nivel_estudio      catalogo = null,
  @i_tipo_vivienda      catalogo = null,
  @i_calif_cliente      catalogo = null,
  @i_profesion          catalogo = null,
  @i_estado_civil       catalogo = null,
  @i_num_cargas         tinyint = null,
  @i_nivel_ing          money = null,
  @i_nivel_egr          money = null,
  @i_filial             tinyint = null,
  @i_oficina            smallint = null,
  @i_tipo               catalogo = null,
  @i_grupo              int = null,
  @i_oficial            smallint = null,
  @i_retencion          char(1) = null,
  @i_exc_sipla          char(1) = null,
  @i_exc_por2           char(1) = null,
  @i_asosciada          catalogo = null,
  @i_tipo_vinculacion   catalogo = null,
  @i_actividad          catalogo = null,
  @i_comentario         varchar(254) = null,
  @i_fecha_emision      datetime = null,
  @i_fecha_expira       datetime = null,
  @i_sector             catalogo = null,
  @i_referido           smallint = null,
  @i_nit                numero = null,
  @i_mala_referencia    char(1) = null,
  @i_gran_contribuyente char(1) = null,
  @i_situacion_cliente  catalogo ='NOR',
  @i_patrim_tec         money = null,
  @i_fecha_patrim_bruto datetime = null,
  @i_total_activos      money = null,
  @i_rep_superban       char(1) = null,
  @i_preferen           char(1) = null,
  @i_depa_nac           smallint = null,
  @i_pais_emi           smallint = null,
  @i_depa_emi           smallint = null,
  @i_categoria          catalogo = null,
  @i_pensionado         char(1) = null,
  @i_tipo_productor     catalogo = null,
  @i_regimen_fiscal     catalogo = null,
  @i_numempleados       smallint = null,
  @i_rioe               char(1) = null,
  @i_impuesto_vtas      char(1) = null,
  @i_pas_finan          money = null,
  @i_fpas_finan         datetime = null,
  @i_opInter            char(1) = null,
  @i_otringr            descripcion = null,
  @i_doctos_carpeta     char(1) = 'N',
  @i_exento_cobro       char(1) = null,
  @i_tipo_empleo        catalogo = null,
  @i_cod_central        varchar(10) = null,
  @i_doc_validado       char(1) = null,
  @o_dif_oficial        tinyint = null out,
  @i_ofiprod            smallint = null,
  @i_accion             varchar(10) = 'NIN',
  @i_procedencia        varchar(10) = null,
  @i_antiguedad         smallint = null,
  @i_estrato            varchar(10) = null,
  @i_num_hijos          smallint = null,

  /*campos nuevos requer 4 banca_mia --FSAP*/
  @i_recurso_pub        char(1) = null,
  @i_influencia         char(1) = null,
  @i_persona_pub        char(1) = null,
  @i_victima            char(1) = null,

  /* campos cca 353 alianzas bancamia --AAMG*/
  @i_crea_ext           char(1) = null,
  @o_msg_msv            varchar(255) = null out
)
as
  declare
    @w_today              datetime,
    @w_sp_name            varchar(32),
    @w_return             int,
    @w_dias_anio_nac      smallint,
    @w_dias_anio_act      smallint,
    @w_inic_anio_nac      datetime,
    @w_inic_anio_act      datetime,
    @w_anio_nac           char(4),
    @w_anio_act           char(4),
    @w_siguiente          int,
    @w_codigo             int,
    @w_nombre             varchar(32),
    @w_p_apellido         varchar(16),
    @w_s_apellido         varchar(16),
    @w_sexo               char(1),
    @w_paso               char(1),
    @w_tipo_ced           char(2),
    @w_cedula             numero,
    @w_pasaporte          varchar(20),
    @w_pais               smallint,
    @w_ciudad_nac         int,
    @w_lugar_doc          int,
    @w_nivel_estudio      catalogo,
    @w_tipo_vivienda      catalogo,
    @w_calif_cliente      catalogo,
    @w_profesion          catalogo,
    @w_estado_civil       catalogo,
    @w_num_cargas         tinyint,
    @w_nivel_ing          money,
    @w_nivel_egr          money,
    @w_filial             int,
    @w_oficina            smallint,
    @w_tipo               catalogo,
    @w_grupo              int,
    @w_fecha_nac          datetime,
    @w_es_mayor_edad      char(1),/* 'S' o 'N' */
    @w_mayoria_edad       smallint,/* expresada en a$os */
    @w_oficial            smallint,
    @w_retencion          char(1),
    @w_exc_sipla          char(1),
    @w_exc_por2           char(1),
    @w_asosciada          catalogo,
    @w_tipo_vinculacion   catalogo,
    @w_vinculacion        char(1),
    @w_mala_referencia    char(1),
    @w_actividad          catalogo,
    @w_comentario         varchar(254),
    @w_nombre_completo    varchar(64),
    @w_tipo_productor     catalogo,
    @v_nombre             varchar(32),
    @w_rep_superban       char(1),
    @w_num_empleados      smallint,
    @w_secuencial         int,
    @v_p_apellido         varchar(16),
    @v_s_apellido         varchar(16),
    @v_sexo               char(1),
    @v_tipo_ced           char(2),
    @v_cedula             numero,
    @v_pasaporte          varchar(20),
    @v_pais               smallint,
    @v_profesion          catalogo,
    @v_estado_civil       catalogo,
    @v_num_cargas         tinyint,
    @v_nivel_ing          money,
    @v_nivel_egr          money,
    @v_tipo               catalogo,
    @v_fecha_nac          datetime,
    @v_grupo              int,
    @v_oficial            smallint,
    @v_oficial_ant        smallint,
    @v_retencion          char(1),
    @v_exc_sipla          char(1),
    @v_exc_por2           char(1),
    @v_pensionado         char(1),
    @v_asosciada          catalogo,
    @v_tipo_vinculacion   catalogo,
    @v_actividad          catalogo,
    @v_comentario         varchar(254),
    @v_rep_superban       char(1),
    @v_tipo_productor     catalogo,
    @w_des_tipo_productor descripcion,
    @w_catalogo           catalogo,
    @w_sector             catalogo,
    @w_nit                numero,
    @w_referido           smallint,
    @w_cod_categoria      catalogo,
    @w_des_categoria      descripcion,
    @w_por_categoria      float,
    @w_pensionado         char(1),
    @w_tipo_compania      char(2),
    @w_regimen_fiscal     catalogo,
    @w_des_regimen_fiscal descripcion,
    @w_banca              catalogo,
    @w_mercado            catalogo,
    @w_subtipo            catalogo,
    @w_tip_doc            char(2),
    @w_fecha_negocio      datetime,
    @w_vigencia           catalogo,
    @w_nombre1            varchar(32),
    @w_apellido1          varchar(16),
    @w_apellido2          varchar(16),
    @w_marcapeps          tinyint,
    @w_origen             varchar(10),
    @w_estado             varchar(10),
    @w_malasref           smallint,
    @w_documento          varchar(20),
    @w_ced_ruc            char(13),
    @w_categoria          varchar(10),
    @w_subcategoria       varchar(20),
    @w_observacion        varchar(255),
    @w_fecha_mod          datetime,
    @w_nomlar             varchar(100),
    @w_usuario            varchar(20),
    @w_akas               varchar(37),
    @w_ced_r              char(13),
    @w_fuente             varchar(20),
    @w_otro_id            varchar(20),
    @w_concepto           varchar(100),
    @w_entid              varchar(50),
    @w_parlista           varchar(10),
    @w_fecha_ref          datetime,
    @w_parlistares        varchar(10),
    @w_restrictiva        varchar(10),
    @w_ofi_func           int,
    @w_tip_func           varchar(10),
    @w_ofi_prod           int,
    /* CAMPOS NUEVOR REQ_000309_CNB */
    @w_tipo_cl            varchar(10),
    @w_cod_rcnb           int,
    @w_cod_ccba           int,
    @w_commit             char(1),
    @w_mensaje            varchar(64),
    @w_estado_id          int,--REQ330
    @w_msg_valida         varchar(64) --REQ330 

  select
    @w_sp_name = 'sp_persona_ins'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()
  select
    @w_referido = @i_referido
  select
    @w_sector = @i_sector
  select
    @w_nit = @i_nit

  select
    @w_nombre1 = ltrim(rtrim(replace(@i_nombre,
                                     '  ',
                                     ' ')))
  select
    @w_apellido1 = ltrim(rtrim(replace(@i_p_apellido,
                                       '  ',
                                       ' ')))
  select
    @w_apellido2 = ltrim(rtrim(replace(@i_s_apellido,
                                       '  ',
                                       ' ')))
  select
    @w_origen = '029'
  select
    @w_estado = '308'
  select
    @w_commit = 'N'

  if @w_referido is null
  begin
    select
      @w_referido = fu_funcionario
    from   cobis..cl_funcionario
    where  fu_login = @s_user
  end

  --Lectura Parametro Oficina-Empleados
  select
    @w_ofi_func = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'OFIFUN'

  if @@rowcount = 0
  begin
    select
      @w_return = 101254
    goto ERROR_FIN
  end

  select
    @w_tip_func = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'TIPFUN'

  if @@rowcount = 0
  begin
    select
      @w_return = 101254
    goto ERROR_FIN
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
  if @w_apellido2 is null
      or @w_apellido2 = ' '
  begin
    select
      @w_nombre_completo = @w_apellido1 + ' ' + @w_nombre1
  end

  if @w_apellido2 is not null
      or @w_apellido2 <> ' '
  begin
    select
      @w_nombre_completo = @w_apellido1 + ' ' + @w_apellido2 + ' ' + @w_nombre1
  end

  select
    @w_nombre_completo = replace(@w_nombre_completo,
                                 '  ',
                                 ' ')
  select
    @w_nombre1 = replace(@w_nombre1,
                         '  ',
                         ' ')
  select
    @w_apellido1 = replace(@w_apellido1,
                           '  ',
                           ' ')
  select
    @w_apellido2 = replace(@w_apellido2,
                           '  ',
                           ' ')

  select
    @w_mayoria_edad = 18
  select
    @w_vinculacion = 'N'
  select
    @w_tipo_compania = 'PA'
  select
    @w_vigencia = 'S'
  select
    @w_nombre_completo = replace(@w_nombre_completo,
                                 '  ',
                                 ' ')

  if @i_operacion = 'V'
  begin
    /*** Validacion num. doc. existente ***/
    select
      @w_tip_doc = en_tipo_ced
    from   cl_ente
    where  en_ced_ruc = @i_cedula

    if @@rowcount > 0
    begin
      if @i_crea_ext is null
      begin
        print
'ERROR: El numero de documento que esta ingresando en la base de datos ya existe y corresponde a una: '
+ @w_tip_doc
  select
    @w_tip_doc
end
else
  select
    @o_msg_msv =
'ERROR: El numero de documento que esta ingresando en la base de datos ya existe y corresponde a una: '
             + @w_tip_doc + ', ' + @w_sp_name
  select
    @w_return = 101192
  return @w_return
end
else if @i_crea_ext is null
  select
    1
end

  /*********REQ330 VALIDACION IDENTIDAD CLIENTE**************/
  if @i_operacion = 'H'
  begin
    if @i_tipo in ('001', '010')
    begin
      -- [DS. 20-01-2014] Req 411 Validacion Huella en Creacion de Cliente
      if exists (select
                   1
                 from   cobis..cl_val_iden
                 where  vi_transaccion = @t_trn
                    and vi_estado      = 'V'
                    and vi_ind_causal  = 'N')
      begin
        -----------------------------------------------
        --inseta registro a validar la huella
        -----------------------------------------------
        exec @w_return = cobis..sp_consulta_homini
          @s_term        = @s_term,
          @s_ofi         = @s_ofi,
          @t_trn         = 1608,
          @i_operacion   = 'I',
          @i_titularidad = 'I',
          @i_tipo_ced    = @i_tipo_ced,
          @i_ced_ruc     = @i_cedula,
          @i_ref         = @i_cedula,
          @i_user        = @s_user,
          @i_id_caja     = 0,
          @i_trn         = @t_trn,
          --[DS. 20-01-2014] Req 411. Se envia transaccion de entrada
          @i_sec_cobis   = @s_ssn

        if @w_return <> 0
            or @@error <> 0
        begin
          goto ERROR_FIN
        end

        -----------------------------------------------
        --invocar al servicio de validacion de huella
        -----------------------------------------------
        exec @w_return = cobis..sp_consulta_homini
          @s_term        = @s_term,
          @s_ofi         = @s_ofi,
          @t_trn         = 1608,
          @i_operacion   = 'V',
          @i_titularidad = 'I',
          @i_ref         = @i_cedula,
          @i_user        = @s_user,
          @i_id_caja     = 0,
          @i_trn         = @t_trn,
          -- [DS. 20-01-2014] Req 411. Se envia transaccion de entrada
          @i_sec_cobis   = @s_ssn,
          @o_codigo      = @w_estado_id out,
          @o_mensaje     = @w_msg_valida out

        if @w_return <> 0
            or @@error <> 0
        begin
          goto ERROR_FIN
        end

        -- VALIDACION MENSAJES RESTRICTIVOS HOMINI 
        if @w_estado_id <> 0
        begin
          select
            @w_return = @w_estado_id,
            @w_mensaje = @w_msg_valida
          goto ERROR_FIN
        end
      end
    end

  end
/******************FIN REQ330****************************/
  /* ** Insert ** */
  if @i_operacion = 'I'
  begin
    if @t_trn = 103
    begin
      if @i_fecha_nac is not null
      begin /* EAL FEB/09 REQ.001*/
        if datediff(yy,
                    @i_fecha_nac,
                    getdate()) < @w_mayoria_edad
          select
            @w_es_mayor_edad = 'N'
        else if datediff(yy,
                    @i_fecha_nac,
                    getdate()) > @w_mayoria_edad
          select
            @w_es_mayor_edad = 'S'
        else
        begin
          /* Caso en que en el anio presente cumpliria la mayoria de edad */
          select
            @w_anio_nac = convert(char(4), datepart(yy,
                                                    @i_fecha_nac)),
            @w_anio_act = convert(char(4), datepart(yy,
                                                    getdate()))

          select
            @w_inic_anio_nac = convert(datetime, '01/01/' + @w_anio_nac, 101),
            @w_inic_anio_act = convert(datetime, '01/01/' + @w_anio_act, 101)

          select
            @w_dias_anio_nac = datediff(dd,
                                        @w_inic_anio_nac,
                                        @i_fecha_nac),
            @w_dias_anio_act = datediff(dd,
                                        @w_inic_anio_act,
                                        getdate())

          /* ya cumplio la mayoria de edad */
          if @w_dias_anio_act >= @w_dias_anio_nac
            select
              @w_es_mayor_edad = 'S'
          else
            select
              @w_es_mayor_edad = 'N'
        end
      end
      else
        select
          @w_es_mayor_edad = 'N'

      if (@i_pasaporte is null
          and @i_cedula is null)
         and @w_es_mayor_edad = 'S'
      begin
        select
          @w_return = 101114
        /* 'Falta Cedula de Identidad'*/
        goto ERROR_FIN
      end

      if exists (select
                   en_ente
                 from   cl_ente
                 where  en_tipo_ced = @i_tipo_ced
                    and en_ced_ruc  = @i_cedula)
         and @i_cedula is not null
         and @i_cedula <> '          '
      begin
        select
          @w_return = 101061
        /* Dato ya existe'*/
        goto ERROR_FIN
      end

      if @i_profesion is not null
      begin
        select
          @w_catalogo = convert(char(10), @i_profesion)
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_profesion',
          @i_codigo    = @w_catalogo

        if @w_return <> 0
        begin
          select
            @w_return = 101019
          goto ERROR_FIN
        end
      end

      /* Verificar que exista el pais indicado */
      if @i_pais is not null
      begin
        select
          @w_codigo = null
        from   cl_pais
        where  pa_pais = @i_pais
        if @@rowcount = 0
        begin
          select
            @w_return = 101018
          /* 'No existe pais'*/
          goto ERROR_FIN
        end
      end

      /* verificar que exista el estado civil */
      if @i_estado_civil is not null
      begin
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_ecivil',
          @i_codigo    = @i_estado_civil

        if @w_return <> 0
        begin
          /*'No existe estado civil'*/
          select
            @w_return = 101020
          goto ERROR_FIN
        end
      end

      /* verificar que exista el tipo de persona */
      if @i_tipo is not null
      begin
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_ptipo',
          @i_codigo    = @i_tipo

        if @w_return <> 0
        begin
          /* 'No existe tipo de persona'*/
          select
            @w_return = 101021
          goto ERROR_FIN
        end
      end

      /* verificar si el tipo es Empleado para colocar oficina segun parametro de empleados */
      if @i_tipo = @w_tip_func
        select
          @w_ofi_prod = @w_ofi_func
      else
        select
          @w_ofi_prod = null

      /* verificar que exista relacion con el banco */
      if @i_tipo_vinculacion is not null
      begin
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_relacion_banco',
          @i_codigo    = @i_tipo_vinculacion

        if @w_return <> 0
        begin
          /* 'No existe relacion con el banco'*/
          select
            @w_return = 101173
          goto ERROR_FIN
        end
        select
          @w_vinculacion = 'S'
      end

      /* verificar que exista situacion del cliente */
      if @i_situacion_cliente is not null
      begin
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_situacion_cliente',
          @i_codigo    = @i_situacion_cliente

        if @w_return <> 0
        begin
          /* 'No existe situacion del cliente'*/
          select
            @w_return = 101173
          goto ERROR_FIN
        end
      end

      /* verificar que exista el tipo de actividad  */
      if @i_actividad is not null
      begin
        select
          @w_catalogo = @i_actividad
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_actividad',
          @i_codigo    = @w_catalogo

        if @w_return <> 0
        begin
          select
            @w_return = 101027
          goto ERROR_FIN
        end
      end

      /*** Verificar que exista el sector  ***/
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
        end
      end

      /*** verificar tipo de cedula **/
      if @i_tipo_ced is not null
      begin
        if @i_tipo_ced = 'PA'
            or @i_tipo_ced = 'CE'
        begin
          if @i_pais_emi is not null
          begin
            if not exists (select
                             1
                           from   cl_pais
                           where  pa_pais = @i_pais_emi)
            begin
              select
                @w_return = 101018
              goto ERROR_FIN
            end
          end
        end
        else
        begin
          if @i_ciudad_nac is not null
          begin
            if not exists (select
                             1
                           from   cl_ciudad
                           where  ci_ciudad = @i_ciudad_nac)
            begin
              select
                @w_return = 101024
              /* No existe Ciudad */
              goto ERROR_FIN
            end
          end
        end

        if @i_tipo_ced = 'PA'
        begin
          if @i_pais_emi is not null
          begin
            if not exists (select
                             1
                           from   cl_pais
                           where  pa_pais = @i_pais_emi)
            begin
              select
                @w_return = 101018
              /* 'No existe pais'*/
              goto ERROR_FIN
            end
          end
        end
        else
        begin
          if @i_lugar_doc is not null
          begin
            if not exists (select
                             1
                           from   cl_ciudad
                           where  ci_ciudad = @i_lugar_doc)
            begin
              select
                @w_return = 101024
              /* No existe Ciudad */
              goto ERROR_FIN
            end
          end
        end
      end
    /*** verificar tipo de cedula fin **/
      /*** Verificar que exista nivel de estudio de la persona ***/
      if @w_nivel_estudio is not null
      begin
        select
          @w_catalogo = convert(char(10), @i_nivel_estudio)
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_nivel_estudio',
          @i_codigo    = @w_catalogo

        if @w_return <> 0
        begin
          /* 'No existe nivel de estudio'*/
          exec sp_cerror
          select
            @w_return = 101170
          goto ERROR_FIN
        end
      end
      /*** verificar tipo de vivienda **/
      if @i_tipo_vivienda is not null
      begin
        select
          @w_catalogo = convert(char(10), @i_tipo_vivienda)
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_tipo_vivienda',
          @i_codigo    = @w_catalogo

        if @w_return <> 0
        begin
          select
            @w_return = 101171
          goto ERROR_FIN
        end
      end

      if @i_calif_cliente is not null
      begin
        select
          @w_catalogo = convert(char(10), @i_calif_cliente)
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_calif_cliente',
          @i_codigo    = @w_catalogo

        if @w_return <> 0
        begin
          /* 'No existe Valoracion de Cliente'*/
          select
            @w_return = 101172
          goto ERROR_FIN
        end
      end

      if @i_categoria is not null
      begin
        select
          @w_catalogo = @i_categoria
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_tipo_cliente',
          @i_codigo    = @w_catalogo

        if @w_return <> 0
        begin
          select
            @w_return = 101048
          /* 'No existe categoria'*/
          goto ERROR_FIN
        end
      end

      if @i_depa_nac is not null
      begin
        select
          @w_catalogo = convert(char(10), @i_depa_nac)
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_provincia',
          @i_codigo    = @w_catalogo

        if @w_return <> 0
        begin
          select
            @w_return = 101010
          goto ERROR_FIN
        end
      end

      if @i_tipo_empleo is not null
      begin
        select
          @w_catalogo = convert(char(10), @i_tipo_empleo)
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_tipo_empleo',
          @i_codigo    = @w_catalogo

        if @w_return <> 0
        begin
          select
            @w_return = 105117
          goto ERROR_FIN
        end
      end

      if @i_pais_emi is not null
      begin
        select
          @w_catalogo = convert(char(10), @i_pais_emi)
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_pais',
          @i_codigo    = @w_catalogo

        if @w_return <> 0
        begin
          select
            @w_return = 901018
          goto ERROR_FIN
        end
      end

      if @i_depa_emi is not null
      begin
        select
          @w_catalogo = convert(char(10), @i_depa_emi)
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_operacion = 'E',
          @i_tabla     = 'cl_provincia',
          @i_codigo    = @w_catalogo

        if @w_return <> 0
        begin
          select
            @w_return = 101010
          goto ERROR_FIN
        end
      end

      if @i_exc_sipla <> 'N'
         and @i_exc_sipla <> 'S'
      begin
        select
          @w_return = 101114
        /* parametro invalido */
        goto ERROR_FIN
      end

      if @i_exc_por2 <> 'N'
         and @i_exc_por2 <> 'S'
      begin
        select
          @w_return = 101114
        /* parametro invalido */
        goto ERROR_FIN
      end

      if @i_pensionado <> 'N'
         and @i_pensionado <> 'S'
      begin
        select
          @w_return = 101114
        /* parametro invalido */
        goto ERROR_FIN
      end

      if @i_retencion <> 'N'
         and @i_retencion <> 'S'
      begin
        select
          @w_return = 101114
        /* parametro invalido */
        goto ERROR_FIN
      end

      if @i_impuesto_vtas <> 'N'
         and @i_impuesto_vtas <> 'S'
      begin
        select
          @w_return = 101114
        /* parametro invalido */
        goto ERROR_FIN
      end

      if @i_fecha_patrim_bruto is not null
      begin
        if datediff(yy,
                    @i_fecha_nac,
                    @i_fecha_patrim_bruto) <= 0
        begin
          select
            @w_return = 107078
          goto ERROR_FIN
        end
      end

      if isnull(@i_antiguedad,
                0) > 0
      begin
        select
          @w_fecha_negocio = dateadd (mm,
                                      ((-1) * @i_antiguedad),
                                      isnull(@s_date,
                                             convert(varchar(10), getdate(), 101
                             ))
                             )
      end

      exec @w_return = cobis..sp_funcionario_oficina
        @s_ssn         = @s_ssn,
        @s_date        = @s_date,
        @s_ofi         = @s_ofi,
        @t_debug       = @t_debug,
        @t_file        = @t_file,
        @t_trn         = null,
        @i_operacion   = 'Q',
        @i_tipo        = @i_tipo_vinculacion,
        @o_funcionario = @i_oficial out

      if @w_return <> 0
      begin
        goto ERROR_FIN
      end

      if @i_mala_referencia is null
        select
          isnull(@i_mala_referencia,
                 'N')

      if @@trancount = 0
      begin
        begin tran
        select
          @w_commit = 'S'
      end

      exec @w_return = sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_ente',
        @o_siguiente = @w_siguiente out

      if @w_return <> 0
      begin
        goto ERROR_FIN
      end

      if @i_recurso_pub = 'S'
          or @i_influencia = 'S'
          or @i_persona_pub = 'S'
      begin
        if @i_crea_ext is null
          print 'PERSONA PUBLICAMENTE EXPUESTA = PEP'

        select
          @w_marcapeps = count(0)
        from   cobis..cl_refinh
        where  in_ced_ruc  = @i_cedula
           and in_tipo_ced = @i_tipo_ced
           and in_origen   = @w_origen
           and in_estado   = @w_estado

        if @w_marcapeps = 0
        begin
          exec @w_return = sp_cseqnos
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            @i_tabla     = 'cl_refinh',
            @o_siguiente = @w_codigo out

          insert into cobis..cl_refinh
                      (in_codigo,in_documento,in_ced_ruc,in_nombre,in_fecha_ref,
                       in_origen,in_observacion,in_fecha_mod,in_subtipo,
                       in_p_p_apellido,
                       in_p_s_apellido,in_tipo_ced,in_nomlar,in_estado,in_sexo,
                       in_usuario,in_aka,in_categoria,in_subcategoria,in_fuente,
                       in_otroid,in_pasaporte,in_concepto,in_entid)
          values      ( @w_codigo,0,@i_cedula,@w_nombre1,@w_today,
                        '029','CREACION CLIENTE - MARCACION PEPS',@w_today,'P',
                        @w_apellido1,
                        @w_apellido2,@i_tipo_ced,@w_nombre_completo,'308',
                        @i_sexo,
                        @s_user,null,null,null,'oficina',
                        null,null,null,null )

          if @@error <> 0
          begin
            select
              @w_return = 105061
          /*'Error en creacion de cliente'*/
            /* Error al insertar mala referencia*/
            goto ERROR_FIN
          end

          insert into cobis..cl_autoriza_sarlaft_lista
                      (as_sec_refinh,as_tipo_id,as_nro_id,as_nombrelargo,
                       as_origen_refinh,
                       as_estado_refinh,as_fecha_refinh,as_aut_sarlaft,
                       as_obs_sarlaft,
                       as_usr_sarlaft,
                       as_fecha_sarlaft,as_aut_cial,as_obs_cial,as_usr_cial,
                       as_fecha_cial,
                       as_valida_total,as_oficina)
          values      ( @w_codigo,@i_tipo_ced,@i_cedula,@w_nombre_completo,'029'
                        ,
                        '308',@w_today,null,null,null,
                        null,null,null,null,null,
                        null,null )

          if @@error <> 0
          begin
            if @i_crea_ext is null
              print 'Error insert cl_refinh CC'
            else
              select
                @o_msg_msv = 'Error insert cl_autoriza_sarlaft_lista, ' +
                             @w_sp_name

            select
              @w_return = 105061
            /* Error al insertar mala referencia */
            goto ERROR_FIN
          end

          select
            @w_mala_referencia = 'S'
        end -- marcapeps 0 
      end
      else
      begin
        select
          @w_mala_referencia = @i_mala_referencia
      end

      insert into cl_ente
                  (en_ente,en_subtipo,en_nombre,p_p_apellido,p_s_apellido,
                   p_sexo,en_tipo_ced,en_ced_ruc,p_pasaporte,en_pais,
                   p_profesion,p_estado_civil,p_num_cargas,p_nivel_ing,
                   p_nivel_egr
                   ,
                   p_tipo_persona,en_fecha_crea,en_fecha_mod,
                   en_filial,en_oficina,
                   en_direccion,en_referencia,p_personal,p_propiedad,p_trabajo,
                   en_casilla,en_casilla_def,en_tipo_dp,p_fecha_nac,en_balance,
                   en_grupo,en_retencion,en_mala_referencia,en_comentario,
                   en_actividad
                   ,
                   en_oficial,p_fecha_emision,p_fecha_expira,
                   en_asosciada,en_referido,
                   en_sector,en_nit,p_ciudad_nac,p_lugar_doc,p_nivel_estudio,
                   p_tipo_vivienda,p_calif_cliente,en_doc_validado,
                   en_rep_superban
                   ,
                   en_nomlar,
                   en_gran_contribuyente,en_situacion_cliente,en_patrimonio_tec,
                   en_fecha_patri_bruto,c_total_activos,
                   en_tipo_vinculacion,en_vinculacion,en_preferen,en_exc_sipla,
                   en_exc_por2,
                   en_digito,p_depa_nac,p_pais_emi,p_depa_emi,en_categoria,
                   en_pensionado,c_tipo_compania,c_num_empleados,en_rep_sib,
                   en_reestructurado,
                   en_pas_finan,en_fpas_finan,en_relacint,en_otringr,
                   en_exento_cobro
                   ,
                   en_doctos_carpeta,en_concordato,en_oficina_prod,
                   en_accion,
                   en_procedencia,
                   en_fecha_negocio,en_estrato,p_num_hijos,en_banca,
                   en_recurso_pub
                   ,
                   en_influencia,en_persona_pub,en_victima,
                   c_vigencia)
      values      ( @w_siguiente,'P',@w_nombre1,@w_apellido1,@w_apellido2,
                    @i_sexo,@i_tipo_ced,@i_cedula,@i_pasaporte,@i_pais,
                    @i_profesion,@i_estado_civil,@i_num_cargas,@i_nivel_ing,
                    @i_nivel_egr,
                    @i_tipo,@w_today,@w_today,@i_filial,@i_oficina,
                    0,0,0,0,0,
                    0,@i_tipo_productor,'S',@i_fecha_nac,0,
                    @i_grupo,@i_retencion,@w_mala_referencia,@i_comentario,
                    @i_actividad,
                    @i_oficial,@i_fecha_emision,@i_fecha_expira,
                    @i_regimen_fiscal,
                    @w_referido,
                    @w_sector,@w_nit,@i_ciudad_nac,@i_lugar_doc,@i_nivel_estudio
                    ,
                    @i_tipo_vivienda,@i_calif_cliente,
                    @i_doc_validado,
                    @i_rep_superban,
                    @w_nombre_completo,
                    @i_gran_contribuyente,@i_situacion_cliente,@i_patrim_tec,
                    @i_fecha_patrim_bruto,@i_total_activos,
                    @i_tipo_vinculacion,@w_vinculacion,@i_preferen,@i_exc_sipla,
                    @i_exc_por2,
                    @i_digito,@i_depa_nac,@i_pais_emi,@i_depa_emi,@i_categoria,
                    @i_pensionado,@w_tipo_compania,@i_numempleados,@i_rioe,
                    @i_impuesto_vtas,
                    @i_pas_finan,@i_fpas_finan,@i_opInter,@i_otringr,
                    @i_exento_cobro
                    ,
                    @i_doctos_carpeta,@i_tipo_empleo,@w_ofi_prod,
                    @i_accion,
                    @i_procedencia,
                    @w_fecha_negocio,@i_estrato,@i_num_hijos,null,@i_recurso_pub
                    ,
                    @i_influencia,@i_persona_pub,@i_victima
                    ,@w_vigencia )
      if @@error <> 0
      begin
        select
          @w_return = 103001
        /*'Error en creacion de cliente'*/
        goto ERROR_FIN
      end

      if @i_doc_validado = 'S'
      begin
        insert into cl_entes_validados
                    (ev_ente,ev_fecha,ev_usuario,ev_central,ev_origen,
                     ev_estado)
        values      ( @w_siguiente,@w_today,@s_user,@i_cod_central,
                      'APERTURA PERSONA NATURAL',
                      'V' )

        if @@error <> 0
        begin
          select
            @w_return = 103095
          /* 'Error en insercion entes validados'*/
          goto ERROR_FIN
        end
      end --@i_doc_validado = 'S'

      /* transaccion de servicio - nuevo */
      insert into ts_persona
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,persona,nombre,
                   p_apellido,s_apellido,sexo,tipo_ced,cedula,
                   pasaporte,pais,profesion,estado_civil,num_cargas,
                   nivel_ing,nivel_egr,tipo,filial,oficina,
                   casilla_def,tipo_dp,fecha_nac,grupo,retencion,
                   mala_referencia,comentario,actividad,oficial,fecha_emision,
                   fecha_expira,asosciada,referido,sector,nit_per,
                   ciudad_nac,lugar_doc,nivel_estudio,tipo_vivienda,
                   calif_cliente,
                   rep_superban,doc_validado,tipo_vinculacion,vinculacion,
                   exc_sipla,
                   exc_por2,digito,depa_nac,pais_emi,depa_emi,
                   categoria,pensionado,num_empleados,pas_finan,fpas_finan,
                   tipo_empleo,ts_accion,ts_estrato,ts_fecha_negocio,
                   ts_procedencia,
                   ts_num_hijos,recur_pub,influencia,pers_pub,victima,
                   vigencia)
      values      ( @s_ssn,@t_trn,'N',getdate(),@s_user,
                    @s_term,@s_srv,@s_lsrv,@w_siguiente,@w_nombre1,
                    @w_apellido1,@w_apellido2,@i_sexo,@i_tipo_ced,@i_cedula,
                    @i_pasaporte,@i_pais,@i_profesion,@i_estado_civil,
                    @i_num_cargas,
                    @i_nivel_ing,@i_nivel_egr,@i_tipo,@i_filial,@i_oficina,
                    @i_tipo_productor,@i_rioe,@i_fecha_nac,@i_grupo,@i_retencion
                    ,
                    @i_mala_referencia,@i_comentario,
                    @i_actividad,@i_oficial,
                    @i_fecha_emision,
                    @i_fecha_expira,@i_regimen_fiscal,@w_referido,@w_sector,
                    @w_nit
                    ,
                    @i_ciudad_nac,@i_lugar_doc,@i_nivel_estudio
                    ,@i_tipo_vivienda,
                    @i_calif_cliente,
                    @i_rep_superban,@i_doc_validado,@i_tipo_vinculacion,
                    @w_vinculacion
                    ,@i_exc_sipla,
                    @i_exc_por2,@i_digito,@i_depa_nac,@i_pais_emi,@i_depa_emi,
                    @i_categoria,@i_pensionado,@i_numempleados,@i_pas_finan,
                    @i_fpas_finan,
                    @i_tipo_empleo,@i_accion,@i_estrato,@w_fecha_negocio,
                    @i_procedencia,
                    @i_num_hijos,@i_recurso_pub,@i_influencia,@i_persona_pub,
                    @i_victima,
                    @w_vigencia )

      if @@error <> 0
      begin
        select
          @w_return = 103005
        /* 'Error en creacion de transaccion de servicio'*/
        goto ERROR_FIN
      end

      /* Asignacion automatica de Oficial SIPLA */
      if @i_oficial is not null
      begin
        exec @w_return = cobis..sp_asesor_upd
          @s_ssn         = @s_ssn,
          @t_trn         = 1316,
          @i_tipo_cli    = 'P',
          @i_operacion   = 'U',
          @i_ente        = @w_siguiente,
          @i_filial      = @i_filial,
          @i_oficina     = @s_ofi,
          @i_oficial     = @i_oficial,
          @o_dif_oficial = @o_dif_oficial out
        if @w_return <> 0
        begin
          goto ERROR_FIN
        end
      end

    /*  ************************************* */
    /*  ************************************* */
    /*  ************************************* */
    /*  Cruce en linea para documento trn dia */
    /*  ************************************* */
    /*  ************************************* */
      /*  ************************************* */

      select
        @w_malasref = isnull(count(0),
                             0)
      from   cobis..cl_refinh,
             cobis..cl_ente
      where  in_ced_ruc         = en_ced_ruc
         and in_ced_ruc         = @i_cedula
         and en_mala_referencia <> 'S'

      if @w_malasref = 1
      begin
        select
          @w_documento = in_documento,
          @w_ced_ruc = in_ced_ruc,
          @w_nombre = in_nombre,
          @w_fecha_ref = in_fecha_ref,
          @w_categoria = in_origen,
          @w_observacion = in_observacion,
          @w_fecha_mod = in_fecha_mod,
          @w_subtipo = in_subtipo,
          @w_p_apellido = in_p_p_apellido,
          @w_s_apellido = in_p_s_apellido,
          @w_tipo_ced = in_tipo_ced,
          @w_nomlar = in_nomlar,
          @w_subcategoria = in_estado,
          @w_sexo = in_sexo,
          @w_usuario = in_usuario,
          @w_akas = in_aka,
          @w_ced_r = in_categoria,
          @w_fuente = in_fuente,
          @w_otro_id = in_otroid,
          @w_pasaporte = in_pasaporte,
          @w_concepto = in_concepto,
          @w_entid = in_entid
        from   cobis..cl_refinh,
               cobis..cl_ente
        where  in_ced_ruc         = en_ced_ruc
           and in_ced_ruc         = @i_cedula
           and en_mala_referencia <> 'S'
        -- and in_observacion = 'CARGUE WORLD COMPLIANCE'

        exec @w_return = sp_cseqnos
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_refinh',
          @o_siguiente = @w_codigo out

        if @w_return <> 0
        begin
          --insert into log (mensaje) values ('Error seqnos')
          goto ERROR_FIN
        end

        set rowcount 1

        if @w_codigo > 0
        begin
          select
            @w_observacion = 'NUMERO IDENTIFICACION - ' + cast(@w_ced_ruc as
                             varchar
                             )

          insert into cobis..cl_refinh
                      (in_codigo,in_documento,in_ced_ruc,in_nombre,in_fecha_ref,
                       in_origen,in_observacion,in_fecha_mod,in_subtipo,
                       in_p_p_apellido,
                       in_p_s_apellido,in_tipo_ced,in_nomlar,in_estado,in_sexo,
                       in_usuario,in_aka,in_categoria,in_subcategoria,in_fuente,
                       in_otroid,in_pasaporte,in_concepto,in_entid)
          values      ( @w_codigo,@w_documento,@w_ced_ruc,@w_nombre,@w_fecha_ref
                        ,
                        @w_categoria,@w_observacion,
                        @w_fecha_mod,@w_subtipo,
                        @w_p_apellido,
                        @w_s_apellido,@w_tipo_ced,@w_nomlar,@w_subcategoria,
                        @w_sexo,
                        @w_usuario,@w_akas,@w_ced_r,null,@w_fuente,
                        @w_otro_id,@w_pasaporte,@w_concepto,@w_entid )

          if @@error <> 0
          begin
            if @i_crea_ext is null
              print 'Error insert cl_refinh CC'
            else
              select
                @o_msg_msv = 'Error insert cl_refinh CC, ' + @w_sp_name

            select
              @w_return = 105061
            /* Error al insertar mala referencia */
            goto ERROR_FIN
          end

          select
            @w_parlista = ''
          select
            @w_restrictiva = ''

          select
            @w_restrictiva = ms_restrictiva
          from   cobis..cl_manejo_sarlaft
          where  ms_origen = @w_categoria
             and ms_estado = @w_subcategoria

          select
            @w_parlista = pa_char
          from   cobis..cl_parametro
          where  pa_producto = 'MIS'
             and pa_nemonico = 'LNRES'

          if (@w_restrictiva = @w_parlista)
             and @w_observacion not like 'NOMBRE HOMONIMO%'
          begin
            insert into cobis..cl_autoriza_sarlaft_lista
                        (as_sec_refinh,as_tipo_id,as_nro_id,as_nombrelargo,
                         as_origen_refinh,
                         as_estado_refinh,as_fecha_refinh,as_aut_sarlaft,
                         as_obs_sarlaft,
                         as_usr_sarlaft,
                         as_fecha_sarlaft,as_aut_cial,as_obs_cial,as_usr_cial,
                         as_fecha_cial,
                         as_valida_total,as_oficina)
            values      ( @w_codigo,@w_documento,@w_ced_ruc,@w_nomlar,
                          @w_categoria
                          ,
                          @w_subcategoria,@w_fecha_mod,
                          null,null,null,
                          null,null,null,null,null,
                          null,null )
          end -- restrictiva

          update cobis..cl_ente
          set    en_mala_referencia = 'S',
                 en_cont_malas = @w_malasref
          where  en_ced_ruc = @i_cedula

          if @@error <> 0
          begin
            select
              @w_return = 105061
            /* 'Error al insertar mala referencia    '*/
            goto ERROR_FIN
          end --if codigo > 0    
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
          @i_derecha   = @w_siguiente,
          @i_lado      = 'I',
          @t_trn       = 1367,
          @s_ssn       = @s_ssn

        if @w_return <> 0
        begin
          goto ERROR_FIN
        end

      end
      --fin mod req 309  

      if @w_commit = 'S'
      begin
        commit tran
        select
          @w_commit = 'N'
      end

      if @i_crea_ext is null
        select
          @w_siguiente

      return 0
    end
  end

  if @i_operacion <> 'V'
     and @i_operacion <> 'I'
     and @i_operacion <> 'H'
     and @i_operacion is not null
  begin
    select
      @w_return = 151051
    goto ERROR_FIN
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
      @i_num   = @w_return,
      @i_msg   = @w_mensaje
  /*  'No corresponde codigo de transaccion' */
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
  end

  return @w_return

go

