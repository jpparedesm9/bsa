/************************************************************************/
/*      Archivo:                cl_cacliext.sp                          */
/*      Stored procedure:       sp_carga_masivo_cliext                  */
/*      Base de datos:          cobis                                   */
/*      Producto:               Clientes                                */
/*      Disenado por:           Saira Molano                            */
/*      Fecha de escritura:     20/Dic/2011                             */
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
/*      BATCH:  Cursor que lee las tablas ex_ente y ex_instancia de la  */
/*              BD cob_externo y carga en cl_ente y cl_instancia        */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      20/12/2011      SMolano         Emision Inicial                 */
/*      May/02/2016     DFu             Migracion CEN                   */
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
           where  name = 'sp_carga_masivo_cliext')
  drop proc sp_carga_masivo_cliext
go

create proc sp_carga_masivo_cliext
(
  @i_param1       varchar(255),-- Fecha Inicio
  @i_param2       char(3),-- Tipo Cliente 
  @i_param3       char(1),-- Tipo Persona
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_trn          smallint = 103,
  @t_show_version bit = 0
)
as
  declare
    @i_fecha         datetime,
    @i_tipo_per      char(3),
    @i_tipo          char(1),
    @i_operacion     char(1),
    @i_tipo_obj      char(1),
    @w_sp_name       varchar(64),
    @w_return        int,
    @w_contador      int,
    @w_total         int,
    @w_sec           int,
    @w_query1        varchar(255),
    @w_valor         varchar(15),
    @w_query2        varchar(255),
    @w_update        varchar(60),
    @w_query3        varchar(60),
    @w_valido        int,
    @w_siguiente     int,
    @w_ssn           money,
    @w_persona       numero,
    @w_oficial       smallint,
    @w_ciudad        int,
    @w_actividad     char(10),
    @w_sectoreco     char(10),
    @w_tipo_vivienda char(10),
    @w_pais          catalogo,
    @w_tipo_compania char(10),
    @w_tip_soc       char(10),
    @w_profesion     char(10),
    @w_ptipo         char(10),
    @w_salida        char(1),
    @w_error         int,
    @w_servidor      descripcion,
    @w_msg           varchar(255),
    @w_path_destino  varchar(100),
    @w_cmd           varchar(255),
    @w_comando       varchar(255),
    @w_path_s_app    varchar(100),
    @w_s_app         varchar(250),
    @w_sqr           varchar(100),
    @w_archivo       varchar(255),
    @w_archivo_bcp   varchar(255),
    @w_nom_archivo   varchar(100),
    @w_path          varchar(250),
    @w_anio          int,
    @w_mes           int,
    @w_dia           int,
    @w_fecha_reporte varchar(10),
    @w_oficina       int

  select
    @w_sp_name = 'sp_carga_masivo_cliext'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  -- Captura del nombre del Stored Procedure
  select
    @i_fecha = convert(datetime, @i_param1),
    @i_tipo_per = @i_param2,
    @i_tipo = @i_param3

  select
    @w_salida = 'S'
  --PARAMETRO GENERAL PARA SERVIDOR
  select
    @w_servidor = nl_nombre
  from   cobis..ad_nodo_oficina
  where  nl_nodo = 1

  --PARAMETROS OFICINA DEFAULT PARA CREACION DE BENEFICIARIOS
  select
    @w_oficina = pa_int --OFICINA DEFAULT
  from   cl_parametro
  where  pa_nemonico = 'ODB'
     and pa_producto = 'MIS'

  if @@rowcount = 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105144
    -- No existe oficina default para beneficiarios
    return 1
  end

  --PARAMETROS DEFAULT PARA CAMPOS NO NULL DE LA CL_ENTE
  select
    @w_oficial = pa_smallint --OFICIAL DEFAULT
  from   cl_parametro
  where  pa_nemonico = 'OPD'
     and pa_producto = 'MIS'

  if @@rowcount = 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105135
    -- no existe parametro OPD Oficial
    return 1
  end

  select
    @w_actividad = d.codigo --APLICA PARA PERSONA NATURAL Y JURIDICA
  from   cl_tabla t,
         cl_default d
  where  t.tabla   = 'cl_actividad'
     and t.codigo  = d.tabla
     and d.oficina = @w_oficina
     and d.srv     = @w_servidor

  if @@rowcount = 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105136
    -- No existe Actividad Default para la oficina
    return 1
  end

  select
    @w_pais = pa_pais
  from   cl_tabla x,
         cl_default y,
         cl_pais
  where  x.tabla   = 'cl_pais'
     and x.codigo  = y.tabla
     and y.oficina = @w_oficina
     and y.srv     = @w_servidor
     and y.codigo  = convert(char(10), pa_pais)

  if @@rowcount = 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105137
    -- No existe Pais Default para la oficina
    return 1
  end

  select
    @w_tipo_compania = d.codigo
  from   cl_tabla t,
         cl_default d
  where  t.tabla   = 'cl_nat_jur'
     and t.codigo  = d.tabla
     and d.oficina = @w_oficina
     and d.srv     = @w_servidor

  if @@rowcount = 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105138
    -- No existe Tipo de Compa±ia Default para la oficina
    return 1
  end

  select
    @w_sectoreco = d.codigo --APLICA PARA PERSONA NATURAL Y JURIDICA
  from   cl_tabla t,
         cl_default d
  where  t.tabla   = 'cl_sectoreco'
     and t.codigo  = d.tabla
     and d.oficina = @w_oficina
     and d.srv     = @w_servidor

  if @@rowcount = 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105139
    -- No existe Sector Economico Default para la oficina
    return 1
  end

  select
    @w_tip_soc = d.codigo
  from   cl_tabla t,
         cl_default d
  where  t.tabla   = 'cl_tip_soc'
     and t.codigo  = d.tabla
     and d.oficina = @w_oficina
     and d.srv     = @w_servidor

  if @@rowcount = 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105140
    -- No existe Tipo Sociedad Default para la oficina
    return 1
  end

  select
    @w_ciudad = convert(int, d.codigo) --APLICA PARA PERSONA NATURAL Y JURIDICA
  from   cl_tabla t,
         cl_default d
  where  t.tabla   = 'cl_ciudad'
     and t.codigo  = d.tabla
     and d.oficina = @w_oficina
     and d.srv     = @w_servidor

  if @@rowcount = 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105141
    -- No existe Ciudad Default para la oficina
    return 1
  end

  select
    @w_profesion = d.codigo --DEFAULT PROFESION PARA TIPO PERSONA NATURAL
  from   cl_tabla t,
         cl_default d
  where  t.tabla   = 'cl_profesion'
     and t.codigo  = d.tabla
     and d.oficina = @w_oficina
     and d.srv     = @w_servidor

  if @@rowcount = 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105142
    -- No existe Profesion Default para la oficina
    return 1
  end

  select
    @w_tipo_vivienda = d.codigo --DEFAULT PARA PERSONA NATURAL
  from   cl_tabla t,
         cl_default d
  where  t.tabla   = 'cl_tipo_vivienda'
     and t.codigo  = d.tabla
     and d.oficina = @w_oficina
     and d.srv     = @w_servidor

  if @@rowcount = 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105143
    -- No existe Tipo de vivienda Default para la oficina
    return 1
  end

  if @i_tipo = 'C'
  begin
    --Arma query dinamico para validar la parametrizacion. Los campos parametrizados deben tener valor
    select
      @w_total = max(atp_secuencia) + 1
    from   cobis..cl_homo_tipo_persona
    where  atp_tipo     = @i_tipo
       and atp_tpersona = @i_tipo_per

    select
      @w_query1 = ''
    select
      @w_query2 = ''
    select
      @w_query3 = ' and en_subtipo = ''' + @i_tipo +
                  ''' and p_tipo_persona = '''
                  +
                                            @i_tipo_per +
                                            ''''

    set rowcount 1
    select
      @w_sec = atp_secuencia
    from   cobis..cl_homo_tipo_persona
    where  atp_tipo     = @i_tipo
       and atp_tpersona = @i_tipo_per
    order  by atp_secuencia

    if @@rowcount = 0
    begin
      print
'sp_carga_masivo_cliext   No hay parametrizacion en cobis..cl_homo_tipo_persona para el tipo de persona y tipo de cliente'
  return 1
end

  while @w_sec < @w_total
  begin
    select
      @w_valor = atp_nom_obj_bac
    from   cobis..cl_homo_tipo_persona
    where  atp_tipo      = @i_tipo
       and atp_tpersona  = @i_tipo_per
       and atp_secuencia = @w_sec

    set rowcount 1
    select
      @w_sec = atp_secuencia
    from   cobis..cl_homo_tipo_persona
    where  atp_tipo      = @i_tipo
       and atp_tpersona  = @i_tipo_per
       and atp_secuencia > @w_sec
    order  by atp_secuencia

    if @@rowcount = 0
    begin
      select
        @w_sec = @w_total + 1
      select
        @w_query1 = @w_valor + ' ' + 'is not null '
      select
        @w_query2 = @w_query2 + @w_query1
    end
    else
    begin
      select
        @w_query1 = @w_valor + ' ' + 'is not null and ' + ' '
      select
        @w_query2 = @w_query2 + @w_query1
    end

    set rowcount 0

  end

  -- Los registros que tengan la informacion parametrizada los actualiza en vinculacion = 'E'.  'E' Significa vinculacion Externa, los registros incorrectos quedan en null
  select
    @w_update = 'update cob_externos..ex_ente set en_vinculacion =' + '''E''' +
                ' '
                       + 'where ' +
                       ' '
  --print 'select1 ' +  @w_query2 + @w_query3
  exec (@w_update + @w_query2 + @w_query3)

end
else
begin
  --Arma query dinamico para validar la parametrizacion. Los campos parametrizados deben tener valor
  select
    @w_total = max(atp_secuencia) + 1
  from   cobis..cl_homo_tipo_persona
  where  atp_tipo     = @i_tipo
     and atp_tpersona = @i_tipo_per

  select
    @w_query1 = ''
  select
    @w_query2 = ''
  select
    @w_query3 = ' and en_subtipo = ''' + @i_tipo + ''' and p_tipo_persona = '''
                +
                                          @i_tipo_per +
                                          ''''

  set rowcount 1
  select
    @w_sec = atp_secuencia
  from   cobis..cl_homo_tipo_persona
  where  atp_tipo     = @i_tipo
     and atp_tpersona = @i_tipo_per
  order  by atp_secuencia

  if @@rowcount = 0
  begin
    print
'sp_carga_masivo_cliext   No hay parametrizacion en cobis..cl_homo_tipo_persona para el tipo de persona y tipo de cliente'
  return 1
end

  while @w_sec < @w_total
  begin
    select
      @w_valor = atp_nom_obj_bac
    from   cobis..cl_homo_tipo_persona
    where  atp_tipo      = @i_tipo
       and atp_tpersona  = @i_tipo_per
       and atp_secuencia = @w_sec

    set rowcount 1
    select
      @w_sec = atp_secuencia
    from   cobis..cl_homo_tipo_persona
    where  atp_tipo      = @i_tipo
       and atp_tpersona  = @i_tipo_per
       and atp_secuencia > @w_sec
    order  by atp_secuencia

    if @@rowcount = 0
    begin
      select
        @w_sec = @w_total + 1
      select
        @w_query1 = @w_valor + ' ' + 'is not null '
      select
        @w_query2 = @w_query2 + @w_query1
    end
    else
    begin
      select
        @w_query1 = @w_valor + ' ' + 'is not null and ' + ' '
      select
        @w_query2 = @w_query2 + @w_query1
    end

    set rowcount 0

  end

  -- Los registros que tengan la informacion parametrizada los actualiza en vinculacion = 'E'.  'E' Significa vinculacion Externa, los registros incorrectos quedan en null
  select
    @w_update = 'update cob_externos..ex_ente set en_vinculacion =' + '''E''' +
                ' '
                       + 'where ' +
                       ' '
  --print 'select1 ' +  @w_query2 + @w_query3
  exec (@w_update + @w_query2 + @w_query3)

end

  --Actualiza en null los clientes con el mismo numero de documento, para no crearlo nuevamente.
  update cob_externos..ex_ente
  set    en_vinculacion = null,
         en_comentario = 'CLIENTE YA EXISTE EN BD'
  from   cob_externos..ex_ente a,
         cobis..cl_ente b
  where  a.en_ced_ruc = b.en_ced_ruc

  --Actualiza en null los clientes con tipo de documento no valido.
  update cob_externos..ex_ente
  set    en_vinculacion = null,
         en_comentario = en_comentario + ' ' + '; TIPO DE DOCUMENTO NO VALIDO'
  where  en_tipo_ced not in (select
                               ct_codigo
                             from   cobis..cl_tipo_documento
                             where  ct_subtipo = 'P'
                                and ct_estado  = 'V')
     and en_subtipo = 'P'

  update cob_externos..ex_ente
  set    en_vinculacion = null,
         en_comentario = en_comentario + ' ' + '; TIPO DE DOCUMENTO NO VALIDO'
  where  en_tipo_ced not in (select
                               ct_codigo
                             from   cobis..cl_tipo_documento
                             where  ct_subtipo = 'C'
                                and ct_estado  = 'V')
     and en_subtipo = 'C'

  update cob_externos..ex_ente
  set    en_actividad = @w_actividad,
         c_tipo_compania = @w_tipo_compania,
         en_pais = @w_pais,
         en_oficial = @w_oficial,
         en_sector = @w_sectoreco,
         c_tipo_soc = @w_tip_soc
  where  en_subtipo     = 'C'
     and en_vinculacion = 'E'

  update cob_externos..ex_ente
  set    en_actividad = @w_actividad,
         p_profesion = @w_profesion,
         en_pais = @w_pais,
         en_oficial = @w_oficial,
         en_sector = @w_sectoreco,
         p_tipo_vivienda = @w_tipo_vivienda,
         en_situacion_cliente = 'NOR'
  where  en_subtipo     = 'P'
     and en_vinculacion = 'E'

  exec @w_ssn = ADMIN...rp_ssn

  --Valida data del cliente cargada en la tabla ex_ente, registro a registro.
  declare valida_data cursor for
    select
      en_ced_ruc
    from   cob_externos..ex_ente
    where  en_vinculacion = 'E'
       and en_ente        = null

  open valida_data

  fetch valida_data into @w_persona

  while @@fetch_status = 0
  begin
    if (@@fetch_status = -1)
    begin
      print 'sp_carga_masivo_cliext  Error en lectura cursor valida_data'
      return 1
    end

    exec @w_error = cob_externos..sp_persona_consext
      @i_operacion = 'Q',
      @i_persona   = @w_persona,
      @t_trn       = 132

    if @w_error <> 0
        or @@error <> 0
    begin
      exec sp_errorlog
        @i_fecha     = @i_fecha,
        @i_error     = @w_error,
        @i_usuario   = 'batch',
        @i_tran      = 132,
        @i_tran_name = @w_sp_name,
        @i_cuenta    = @w_persona,
        @i_rollback  = 'N'

      update cob_externos..ex_ente
      set    en_vinculacion = null
      where  en_ced_ruc = @w_persona

      if @@error <> 0
      begin
        select
          @w_error = 105131,
          @w_msg = 'ERROR EN ACTUALIZACION cob_externos..ex_ente'
      --goto ERROR
      end
    end
    else
    begin
      exec sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_ente',
        @o_siguiente = @w_siguiente out

      update cob_externos..ex_ente
      set    en_ente = @w_siguiente
      where  en_vinculacion = 'E'
         and en_ced_ruc     = @w_persona

      if @@error <> 0
      begin
        select
          @w_error = 105131,
          @w_msg = 'ERROR EN ACTUALIZACION cob_externos..ex_ente'
        goto ERROR
      end

      --Crea relacion con bancamia
      insert into cobis..cl_instancia
      values      ('208',@w_siguiente,345785,'I',getdate())

      if @@error <> 0
      begin
        select
          @w_error = 105132,
          @w_msg = 'ERROR EN LA INSERCION cobis..cl_instancia'
        goto ERROR
      end

      /* transaccion de servicio - nuevo */
      insert into cobis..ts_persona
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   persona,nombre,p_apellido,s_apellido,sexo,
                   tipo_ced,cedula,pasaporte,pais,profesion,
                   estado_civil,num_cargas,nivel_ing,nivel_egr,tipo,
                   filial,oficina,casilla_def,tipo_dp,fecha_nac,
                   grupo,retencion,mala_referencia,comentario,actividad,
                   oficial,fecha_emision,fecha_expira,asosciada,referido,
                   sector,nit_per,ciudad_nac,lugar_doc,nivel_estudio,
                   tipo_vivienda,calif_cliente,rep_superban,doc_validado,
                   tipo_vinculacion,
                   vinculacion,exc_sipla,exc_por2,digito,depa_nac,
                   pais_emi,depa_emi,categoria,pensionado,num_empleados,
                   pas_finan,fpas_finan,ts_accion,ts_estrato,ts_fecha_negocio,
                   ts_procedencia,ts_num_hijos,recur_pub,influencia,pers_pub,
                   victima,vigencia)
        select
          @w_ssn,@t_trn,'N',getdate(),'externo',
          @w_siguiente,en_nombre,p_p_apellido,p_s_apellido,p_sexo,
          en_tipo_ced,en_ced_ruc,p_pasaporte,p_pais_emi,p_profesion,
          p_estado_civil,p_num_cargas,p_nivel_ing,p_nivel_egr,p_tipo_persona,
          en_filial,en_oficina,en_casilla_def,en_tipo_dp,p_fecha_nac,
          en_grupo,en_retencion,en_mala_referencia,en_comentario,en_actividad,
          en_oficial,p_fecha_emision,p_fecha_expira,en_asosciada,en_referido,
          en_sector,en_nit,p_ciudad_nac,p_lugar_doc,p_nivel_estudio,
          p_tipo_vivienda,p_calif_cliente,en_rep_superban,en_doc_validado,
          en_tipo_vinculacion,
          en_vinculacion,en_exc_sipla,en_exc_por2,en_digito,p_depa_nac,
          p_pais_emi,p_depa_emi,en_categoria,en_pensionado,c_num_empleados,
          en_pas_finan,en_fpas_finan,en_accion,en_estrato,en_fecha_negocio,
          en_procedencia,p_num_hijos,en_recurso_pub,en_influencia,en_persona_pub
          ,
          en_victima,c_vigencia
        from   cob_externos..ex_ente
        where  en_ced_ruc = @w_persona

      if @@error != 0
      begin
        select
          @w_error = 105131,
          @w_msg = 'ERROR EN LA INSERCION cobis..cl_instancia'
        goto ERROR
      end
    end

    fetch valida_data into @w_persona
  end
  close valida_data
  deallocate valida_data

  --Crear la relacion con la cl_instancia, que los 2 entes existan

  print 'Inserta los clientes en la cl_ente'
  insert into cobis..cl_ente
              (en_ente,en_nombre,en_subtipo,en_filial,en_oficina,
               en_ced_ruc,en_fecha_crea,en_fecha_mod,en_direccion,en_referencia,
               en_casilla,en_casilla_def,en_tipo_dp,en_balance,en_grupo,
               en_pais,en_oficial,en_actividad,en_retencion,en_mala_referencia,
               en_comentario,en_cont_malas,s_tipo_soc_hecho,en_tipo_ced,
               en_sector,
               en_referido,en_nit,en_doc_validado,en_rep_superban,p_p_apellido,
               p_s_apellido,p_sexo,p_fecha_nac,p_ciudad_nac,p_lugar_doc,
               p_profesion,p_pasaporte,p_estado_civil,p_num_cargas,p_num_hijos,
               p_nivel_ing,p_nivel_egr,p_nivel_estudio,p_tipo_persona,
               p_tipo_vivienda,
               p_calif_cliente,p_personal,p_propiedad,p_trabajo,p_soc_hecho,
               p_fecha_emision,p_fecha_expira,c_cap_suscrito,en_asosciada,
               c_posicion,
               c_tipo_compania,c_rep_legal,c_activo,c_pasivo,c_es_grupo,
               c_capital_social,c_reserva_legal,c_fecha_const,en_nomlar,c_plazo,
               c_direccion_domicilio,c_fecha_inscrp,c_fecha_aum_capital,
               c_cap_pagado,c_tipo_nit,
               c_tipo_soc,c_total_activos,c_num_empleados,c_sigla,c_escritura,
               c_notaria,c_ciudad,c_fecha_exp,c_fecha_vcto,c_camara,
               c_registro,c_grado_soc,c_fecha_registro,c_fecha_modif,
               c_fecha_verif
               ,
               c_vigencia,c_verificado,c_funcionario,
               en_situacion_cliente,en_patrimonio_tec,
               en_fecha_patri_bruto,en_gran_contribuyente,en_calificacion,
               en_reestructurado,en_concurso_acreedores,
               en_concordato,en_vinculacion,en_tipo_vinculacion,en_oficial_sup,
               en_cliente,
               en_preferen,c_edad_laboral_promedio,c_empleados_ley_50,
               en_exc_sipla
               ,en_exc_por2,
               en_digito,p_depa_nac,p_pais_emi,p_depa_emi,en_categoria,
               en_emala_referencia,en_banca,c_total_pasivos,en_pensionado,
               en_rep_sib,
               en_max_riesgo,en_riesgo,en_mries_ant,en_fmod_ries,en_user_ries,
               en_reservado,en_pas_finan,en_fpas_finan,en_fbalance,en_relacint,
               en_otringr,en_exento_cobro,en_doctos_carpeta,en_oficina_prod,
               en_accion,
               en_procedencia,en_fecha_negocio,en_estrato,en_recurso_pub,
               en_influencia,
               en_persona_pub,en_victima)
    select
      en_ente,en_nombre,en_subtipo,en_filial,en_oficina,
      en_ced_ruc,en_fecha_crea,en_fecha_mod,en_direccion,en_referencia,
      en_casilla,en_casilla_def,en_tipo_dp,en_balance,en_grupo,
      en_pais,en_oficial,en_actividad,en_retencion,en_mala_referencia,
      en_comentario,en_cont_malas,s_tipo_soc_hecho,en_tipo_ced,en_sector,
      en_referido,en_nit,en_doc_validado,en_rep_superban,p_p_apellido,
      p_s_apellido,p_sexo,p_fecha_nac,p_ciudad_nac,p_lugar_doc,
      p_profesion,p_pasaporte,p_estado_civil,p_num_cargas,p_num_hijos,
      p_nivel_ing,p_nivel_egr,p_nivel_estudio,p_tipo_persona,p_tipo_vivienda,
      p_calif_cliente,p_personal,p_propiedad,p_trabajo,p_soc_hecho,
      p_fecha_emision,p_fecha_expira,c_cap_suscrito,en_asosciada,c_posicion,
      c_tipo_compania,c_rep_legal,c_activo,c_pasivo,c_es_grupo,
      c_capital_social,c_reserva_legal,c_fecha_const,en_nomlar,c_plazo,
      c_direccion_domicilio,c_fecha_inscrp,c_fecha_aum_capital,c_cap_pagado,
      c_tipo_nit,
      c_tipo_soc,c_total_activos,c_num_empleados,c_sigla,c_escritura,
      c_notaria,c_ciudad,c_fecha_exp,c_fecha_vcto,c_camara,
      c_registro,c_grado_soc,c_fecha_registro,c_fecha_modif,c_fecha_verif,
      c_vigencia,c_verificado,c_funcionario,en_situacion_cliente,
      en_patrimonio_tec
      ,
      en_fecha_patri_bruto,en_gran_contribuyente,en_calificacion,
      en_reestructurado,
      en_concurso_acreedores,
      en_concordato,en_vinculacion,en_tipo_vinculacion,en_oficial_sup,en_cliente
      ,
      en_preferen,c_edad_laboral_promedio,c_empleados_ley_50,en_exc_sipla
      ,
      en_exc_por2,
      en_digito,p_depa_nac,p_pais_emi,p_depa_emi,en_categoria,
      en_emala_referencia,en_banca,c_total_pasivos,en_pensionado,en_rep_sib,
      en_max_riesgo,en_riesgo,en_mries_ant,en_fmod_ries,en_user_ries,
      en_reservado,en_pas_finan,en_fpas_finan,en_fbalance,en_relacint,
      en_otringr,en_exento_cobro,en_doctos_carpeta,en_oficina_prod,en_accion,
      en_procedencia,en_fecha_negocio,en_estrato,en_recurso_pub,en_influencia,
      en_persona_pub,en_victima
    from   cob_externos..ex_ente
    where  en_vinculacion = 'E'

  if @@error <> 0
  begin
    select
      @w_error = 105133,
      @w_msg = 'ERROR EN LA INSERCION cobis..cl_ente'
    goto ERROR
  end

  print 'Borra los clientes en la ex_ente'
  delete from cob_externos..ex_ente
  where  en_vinculacion = 'E'

  if @@error <> 0
  begin
    select
      @w_error = 105134,
      @w_msg = 'ERROR EN LA ELIMINACION cob_externos..ex_ente'
    goto ERROR
  end

  --Bcp de los registros que no cumplen
  --********************* **********************--
  ---> GENERAR BCP 
  --*******************************************--
  select
    @w_path_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'S_APP'

  if @w_path_s_app is null
  begin
    select
      @w_error = 999999,
      @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
    goto ERROR
  end

  select
    @w_path = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 2

  if @@rowcount = 0
  begin
    select
      @w_msg =
      'ERROR 1: NO EXISTE RUTA DE LISTADOS PARA EL BATCH sp_carga_masivo_cliext'
    print @w_msg
    return 1
  end

  exec cobis..sp_datepart
    @i_fecha = @i_fecha,
    @o_dia   = @w_dia out,
    @o_mes   = @w_mes out,
    @o_anio  = @w_anio out
  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR 3: ERROR EN EL SP_DATEPART'
    print @w_msg
    return 1
  end

  select
    @w_fecha_reporte = convert(varchar, @w_anio) + right((replicate('0', 2) +
                                    convert(varchar, @w_mes))
                                    , 2)
                       + right((replicate('0', 2) + convert(varchar, @w_dia)), 2
                       )

  --GENERA BCP
  select
    @w_nom_archivo = 'crea_cliente_' + convert(varchar(2), datepart(dd,
                            @w_fecha_reporte)) + '_'
                     + convert(varchar(2), datepart(mm, @w_fecha_reporte)) + '_'
                     + convert(varchar(4), datepart(yyyy, @w_fecha_reporte)) +
                            '.txt'
  select
    @w_archivo = @w_path + @w_nom_archivo

  select
    @w_cmd = @w_path_s_app + 's_app bcp -auto -login cob_externos..ex_ente out '

  select
       @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e' + @w_archivo + '.err'
                    +
                    ' -t"|" -config '
                    + @w_path_s_app
                 + 's_app.ini'
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR: ' + @w_error + ' ERROR GENERANDO BCP ' + @w_comando
    print @w_msg
    return 1
  end

  return 0

  ERROR:
  exec cobis..sp_cerror
    @i_num = @w_error,
    @i_sev = 0,
    @i_msg = @w_msg
  return @w_error

go

