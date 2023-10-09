/************************************************************************/
/*  Archivo           :  ente_validado.sp                               */
/*  Stored procedure  :  sp_ente_validado                               */
/*  Base de datos     :  cobis                                          */
/*  Producto          :  Clientes                                       */
/*  Disenado por      :  M.Bernal                                       */
/*  Fecha de escritura:                                                 */
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
/*  Este programa procesa las transacciones  Insercion,                 */
/*  Borrado, Modificacion de empleo                                     */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*   FECHA            AUTOR                  RAZON                      */
/*   09/Oct/08        M.Bernal               Emisión inicial            */
/*   04/May/2016      T. Baidal     Migracion a CEN                     */
/************************************************************************/
use cobis
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_ente_validado')
           drop proc sp_ente_validado
go

create proc sp_ente_validado
(
  @s_date          datetime,
  @s_ssn           int,
  @t_trn           int,
  @t_show_version  bit = 0,
  @s_user          login,
  @s_term          varchar(30),
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
  @i_col1          int = null,--Tipo Id
  @i_col2          varchar(30) = null,--Numero Id
  @i_col3          varchar(30) = null,--Nombre
  @i_col4          datetime = null,--Fecha de expedicion
  @i_col5          varchar(30) = null,--Municipio
  @i_col6          varchar(30) = null,--Departamento
  @i_col7          varchar(30) = null,--Estado
  @i_col8          varchar(30) = null,--Genero
  @i_col9          int = null,--Edad aproximada
  @i_col10         varchar(30) = null,--Rango de edad
  @i_col11         int = null,--Tipo Id
  @i_col12         varchar(30) = null,--Numero Id
  @i_col13         varchar(30) = null,--Nombre a Validar
  @i_col14         varchar(30) = null,--Nombre Registraduria
  @i_col15         datetime = null,--Fecha expedicion
  @i_col16         varchar(30) = null,--Municipio expidicion
  @i_col17         varchar(30) = null,--Departamento
  @i_col18         int = null,--Estado
  @i_col19         varchar(30) = null,--Causal de rechazo
  @i_operacion     varchar(1) = null,--Operacion entrante
  @i_num           int = null
)
as
  declare
    @w_sp_name varchar(32),
    @w_return  int,
    @w_codigo  int,
    @w_dep     smallint,
    @w_ciu     smallint

  select
    @w_sp_name = 'sp_ente_validado'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  -- select '@i_col1 ' =   @i_col1 ,
  --    '@i_col2 ' =   @i_col2 ,
  --    '@i_col3 ' =   @i_col3 ,
  --    '@i_col4 ' =   @i_col4 ,
  --    '@i_col5 ' =   @i_col5 ,
  --    '@i_col6 ' =   @i_col6 ,
  --    '@i_col7 ' =   @i_col7 ,
  --    '@i_col8 ' =   @i_col8 ,
  --    '@i_col9 ' =   @i_col9 ,
  --    '@i_col10' =   @i_col10

  if @i_operacion = 'E' ---Entes validados Contra central de Riesgo
  begin --1
    ------* Camibio de estado en cobis..cl_ente *--------------
    if exists (select
                 1
               from   cobis..cl_ente
               where  en_ced_ruc = @i_col2
                  and en_nombre  = @i_col3)
    begin --1.1
      update cobis..cl_ente
      set    en_doc_validado = 'S'
      where  en_ced_ruc = @i_col2
    end --1.1

    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 130000 -- Pendiente definir tipo error
      /*'Error no exite el ente seleccionado'*/
      return 1
    end

    if exists (select
                 1
               from   cobis..cl_ente
               where  en_ced_ruc = @i_col2
                  and en_nombre  = @i_col3)
      ------* Insercion en cobis..cl_entes_validados *---------------

      if exists (select
                   1
                 from   cobis..cl_entes_validados
                 where  ev_ente = @i_col2)
      begin --1.2
        update cobis..cl_entes_validados
        set    ev_ente = @i_col2,
               ev_fecha = getdate(),
               ev_usuario = 'BATCH',
               ev_central = 2,
               ev_origen = 'PROCESO MASIVO',
               ev_estado = 'OK',
               ev_causa = null
        where  ev_ente = @i_col2

        if @@error <> 0
        begin
          exec cobis..sp_cerror
            @t_from = @w_sp_name,
            @i_num  = 140000
          /* 'Error en la actualizacion de Datos en cobis..cl_entes_validados'*/
          return 1
        end

      end --1.2
      else
        insert into cobis..cl_entes_validados
                    (ev_ente,ev_fecha,ev_usuario,ev_central,ev_origen,
                     ev_estado,ev_causa)
        values      (@i_col2,getdate(),'BATCH',2,'PROCESO MASIVO',
                     'E',null)

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 150000
      /* 'Error en la insercion de Datos en cobis..cl_entes_validados'*/
      return 1
    end

    --------* Insercion en cobis..cl_mod_central_riesgo *-------------

    --Insert cl_mod_central_riesgo cr_estado 'I' cr_tipo_regis 'A'

    insert into cobis..cl_mod_central_riesgo
      select
        getdate(),@s_ssn,'I','A',@i_col2,
        en_tipo_ced,en_ced_ruc,p_tipo_persona,en_nombre,p_p_apellido,
        p_s_apellido,p_sexo,p_estado_civil,p_depa_nac,p_ciudad_nac,
        p_depa_emi,p_ciudad_nac,p_fecha_emision
      from   cobis..cl_ente
      where  en_ced_ruc = @i_col2

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 150000
      /* 'Error en la insercion de Datos antiguos en la cobis..cl_mod_central_riesgo'*/
      return 1
    end

    --Insert cl_mod_central_riesgo cr_estado 'I' cr_tipo_regis 'N' --> Datos Nuevos(@w)

    if @i_col6 is null
    begin
      select
        @i_col6 = 0

      if @i_col5 is null
      begin
        select
          @i_col5 = 0
      end
    end

    else if @i_col5 = 'BOGOTA'
      select
        @w_ciu = 1101,
        @w_dep = 11
    else
      select
        @i_col5 = @i_col5 + '%'
    select
      @w_dep = pv_provincia
    from   cobis..cl_provincia
    where  pv_descripcion = @i_col5

    select
      @i_col6 = @i_col6 + '%'
    select
      @w_ciu = ci_ciudad
    from   cobis..cl_ciudad
    where  ci_provincia   = @w_dep
       and ci_estado      = 'V'
       and ci_descripcion = @i_col6

    insert into cobis..cl_mod_central_riesgo
      select
        @s_date,@s_ssn,'I','N',@i_col2,
        @i_col1,@i_col2,'P',@i_col3,p_p_apellido,
        p_s_apellido,p_tipo_persona,p_estado_civil,@w_ciu,@w_dep,
        @w_ciu,@w_dep,p_fecha_emision
      from   cobis..cl_ente
      where  en_ced_ruc = @i_col2

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 160000
      /* 'Error en la insercion de Datos nuevos en la cobis..cl_mod_central_riesgo'*/
      return 1
    end

    /* transaccion de servicio - datos previos */

    insert into cobis..ts_persona
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,persona,nombre,
                 p_apellido,s_apellido,sexo,tipo_ced,cedula,
                 pasaporte,pais,profesion,estado_civil,num_cargas,
                 nivel_ing,nivel_egr,tipo,filial,oficina,
                 casilla_def,tipo_dp,fecha_nac,grupo,retencion,
                 comentario,actividad,oficial,fecha_emision,fecha_expira,
                 asosciada,nit_per,referido,sector,ciudad_nac,
                 lugar_doc,nivel_estudio,tipo_vivienda,calif_cliente,
                 doc_validado,
                 rep_superban,tipo_vinculacion,vinculacion,exc_sipla,exc_por2,
                 digito,depa_nac,pais_emi,depa_emi,categoria,
                 pensionado,num_empleados,pas_finan,fpas_finan,opinternac,
                 tipo_empleo)
      --,       recur_pub,         influencia,          pers_pub,
      --victima)

      --      values (@s_ssn,           @t_trn,            'P',                 @s_date,
      --              @s_user,          @s_term,           @s_srv,              @s_lsrv,
      --              en_ente,          en_nombre,         p_p_apellido,        p_s_apellido,
      --              p_sexo,           en_tipo_ced,       en_ced_ruc,          p_pasaporte,
      --              en_pais,          p_profesion,       p_estado_civil,      p_num_cargas,
      --              p_nivel_ing,      p_nivel_egr,       en_subtipo,          en_filial,
      --              en_oficina,       en_casilla_def,    en_tipo_dp,          p_fecha_nac,
      --              c_es_grupo,       en_retencion,      en_comentario,       en_actividad,
      --              en_oficial,       p_fecha_emision,   p_fecha_expira,      en_asosciada,
      --              en_nit,           en_referido,       en_sector,           p_ciudad_nac,
      --              p_lugar_doc,      p_nivel_estudio,   p_tipo_vivienda,     p_calif_cliente,
      --              en_doc_validado,  en_rep_superban,   en_tipo_vinculacion, en_vinculacion,
      --              en_exc_sipla,     en_exc_por2,       en_digito,           p_depa_nac,
      --              p_pais_emi,       d_depa_emi,        en_categoria,        en_pensionado,
      --              c_num_empleados,  en_pas_finan ,     en_fpas_finan,     en_relacint,
      --              p_trabajo,        en_recurso_pub,    en_influencia,       en_persona_pub,
      --              en_victima)

      select
        @s_ssn,@t_trn,'P',@s_date,@s_user,
        @s_term,@s_srv,@s_lsrv,en_ente,en_nombre,
        p_p_apellido,p_s_apellido,p_sexo,en_tipo_ced,en_ced_ruc,
        p_pasaporte,en_pais,p_profesion,p_estado_civil,p_num_cargas,
        p_nivel_ing,p_nivel_egr,en_subtipo,en_filial,en_oficina,
        en_casilla_def,en_tipo_dp,p_fecha_nac,c_es_grupo,en_retencion,
        en_comentario,en_actividad,en_oficial,p_fecha_emision,p_fecha_expira,
        en_asosciada,en_nit,en_referido,en_sector,p_ciudad_nac,
        p_lugar_doc,p_nivel_estudio,p_tipo_vivienda,p_calif_cliente,
        en_doc_validado,
        en_rep_superban,en_tipo_vinculacion,en_vinculacion,en_exc_sipla,
        en_exc_por2,
        en_digito,p_depa_nac,p_pais_emi,p_depa_emi,en_categoria,
        en_pensionado,c_num_empleados,en_pas_finan,en_fpas_finan,en_relacint,
        p_trabajo
      --,        en_recurso_pub,    en_influencia,       en_persona_pub,
      --en_victima

      from   cobis..cl_ente
      where  en_ced_ruc = @i_col2

    if @@error <> 0
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 103005
      /*'Error en creacion de transaccion de servicio'*/
      return 1
    end

    --         /* transaccion de servicio - datos anteriores  */
    insert into cobis..ts_persona
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,persona,nombre,
                 p_apellido,s_apellido,sexo,tipo_ced,cedula,
                 pasaporte,pais,profesion,estado_civil,num_cargas,
                 nivel_ing,nivel_egr,tipo,filial,oficina,
                 casilla_def,tipo_dp,fecha_nac,grupo,retencion,
                 comentario,actividad,oficial,fecha_emision,fecha_expira,
                 asosciada,nit_per,referido,sector,ciudad_nac,
                 lugar_doc,nivel_estudio,tipo_vivienda,calif_cliente,
                 doc_validado,
                 rep_superban,tipo_vinculacion,vinculacion,exc_sipla,exc_por2,
                 digito,depa_nac,pais_emi,depa_emi,categoria,
                 pensionado,num_empleados,pas_finan,fpas_finan,opinternac,
                 tipo_empleo)
      --,       recur_pub,         influencia,          pers_pub,
      --victima)

      select
        @s_ssn,@t_trn,'A',@s_date,@s_user,
        @s_term,@s_srv,@s_lsrv,en_ente,en_nombre,
        p_p_apellido,p_s_apellido,p_sexo,en_tipo_ced,en_ced_ruc,
        p_pasaporte,en_pais,p_profesion,p_estado_civil,p_num_cargas,
        p_nivel_ing,p_nivel_egr,en_subtipo,en_filial,en_oficina,
        en_casilla_def,en_tipo_dp,p_fecha_nac,c_es_grupo,en_retencion,
        en_comentario,en_actividad,en_oficial,p_fecha_emision,p_fecha_expira,
        en_asosciada,en_nit,en_referido,en_sector,p_ciudad_nac,
        p_lugar_doc,p_nivel_estudio,p_tipo_vivienda,p_calif_cliente,
        en_doc_validado,
        en_rep_superban,en_tipo_vinculacion,en_vinculacion,en_exc_sipla,
        en_exc_por2,
        en_digito,p_depa_nac,p_pais_emi,p_depa_emi,en_categoria,
        en_pensionado,c_num_empleados,en_pas_finan,en_fpas_finan,en_relacint,
        p_trabajo
      --,        en_recurso_pub,    en_influencia,       en_persona_pub,
      --en_victima

      from   cobis..cl_ente
      where  en_ced_ruc = @i_col2

    if @@error <> 0
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 103005
      /*'Error en creacion de transaccion de servicio'*/
      return 1
    end
  end --1

  if @i_operacion = 'N' ----Entes no validados contra Central de Riesgo

  begin --2
    ------* Camibio de estado en cobis..cl_ente *--------------
    if exists (select
                 1
               from   cobis..cl_ente
               where  en_ced_ruc = @i_col2
                  and en_nombre  = @i_col3)
    begin --1.1
      update cobis..cl_ente
      set    en_doc_validado = 'N'
      where  en_ced_ruc = @i_col2
    end --1.1

    if @@rowcount = 0
    begin
      exec sp_cerror
        --@t_file     = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 170000 -- Pendiente definir tipo error
      /*'Error no exite el ente seleccionado'*/
      return 1
    end

    ------* Insercion en cobis..cl_entes_validados *---------------

    if exists (select
                 1
               from   cobis..cl_entes_validados
               where  ev_ente = @i_col2)
    begin --1.2
      update cobis..cl_entes_validados
      set    ev_ente = @i_col12,
             ev_fecha = getdate(),
             ev_usuario = 'BATCH',
             ev_central = 2,
             ev_origen = 'PROCESO MASIVO',
             ev_estado = 'ERR',
             ev_causa = @i_col19
      where  ev_ente = @i_col12

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_from = @w_sp_name,
          @i_num  = 180000
        /* 'Error en la actualizacion de Datos en cobis..cl_entes_validados'*/
        return 1
      end

    end --1.2
    else
      insert into cobis..cl_entes_validados
                  (ev_ente,ev_fecha,ev_usuario,ev_central,ev_origen,
                   ev_estado,ev_causa)
      values      (@i_col12,getdate(),'BATCH',2,'PROCESO MASIVO',
                   'N',@i_col12)

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 190000
      /* 'Error en la insercion de Datos en cobis..cl_entes_validados'*/
      return 1
    end

    --------* Insercion en cobis..cl_mod_central_riesgo *-------------

    --Insert cl_mod_central_riesgo cr_estado 'I' cr_tipo_regis 'A'

    insert into cobis..cl_mod_central_riesgo
      select
        getdate(),@s_ssn,'I','A',@i_col12,
        en_tipo_ced,en_ced_ruc,p_tipo_persona,en_nombre,p_p_apellido,
        p_s_apellido,p_sexo,p_estado_civil,p_depa_nac,p_ciudad_nac,
        p_depa_emi,p_ciudad_nac,p_fecha_emision
      from   cobis..cl_ente
      where  en_ced_ruc = @i_col12

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 200000
      /* 'Error en la insercion de Datos antiguos en la cobis..cl_mod_central_riesgo'*/
      return 1
    end

    --Insert cl_mod_central_riesgo cr_estado 'I' cr_tipo_regis 'N' --> Datos Nuevos(@w)
    if @i_col17 is null
    begin
      select
        @i_col17 = 0

      if @i_col16 is null
      begin
        select
          @i_col16 = 0
      end
    end

    else if @i_col16 = 'BOGOTA'
      select
        @w_ciu = 1101,
        @w_dep = 11
    else
      select
        @i_col16 = @i_col16 + '%'
    select
      @w_dep = pv_provincia
    from   cobis..cl_provincia
    where  pv_descripcion = @i_col16

    select
      @i_col17 = @i_col17 + '%'
    select
      @w_ciu = ci_ciudad
    from   cobis..cl_ciudad
    where  ci_provincia   = @w_dep
       and ci_estado      = 'V'
       and ci_descripcion = @i_col17

    insert into cobis..cl_mod_central_riesgo
      select
        @s_date,@s_ssn,'I','N',@i_col12,
        @i_col11,@i_col12,'P',@i_col3,p_p_apellido,
        p_s_apellido,p_sexo,p_estado_civil,@w_ciu,@w_dep,
        @w_ciu,@w_dep,p_fecha_emision
      from   cobis..cl_ente
      where  en_ced_ruc = @i_col12

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 210000
      /* 'Error en la insercion de Datos nuevos en la cobis..cl_mod_central_riesgo'*/
      return 1
    end

    /* transaccion de servicio - datos previos */

    insert into cobis..ts_persona
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,persona,nombre,
                 p_apellido,s_apellido,sexo,tipo_ced,cedula,
                 pasaporte,pais,profesion,estado_civil,num_cargas,
                 nivel_ing,nivel_egr,tipo,filial,oficina,
                 casilla_def,tipo_dp,fecha_nac,grupo,retencion,
                 comentario,actividad,oficial,fecha_emision,fecha_expira,
                 asosciada,nit_per,referido,sector,ciudad_nac,
                 lugar_doc,nivel_estudio,tipo_vivienda,calif_cliente,
                 doc_validado,
                 rep_superban,tipo_vinculacion,vinculacion,exc_sipla,exc_por2,
                 digito,depa_nac,pais_emi,depa_emi,categoria,
                 pensionado,num_empleados,pas_finan,fpas_finan,opinternac,
                 tipo_empleo)
      --,       recur_pub,         influencia,          pers_pub,
      --victima)

      select
        @s_ssn,@t_trn,'P',@s_date,@s_user,
        @s_term,@s_srv,@s_lsrv,en_ente,en_nombre,
        p_p_apellido,p_s_apellido,p_sexo,en_tipo_ced,en_ced_ruc,
        p_pasaporte,en_pais,p_profesion,p_estado_civil,p_num_cargas,
        p_nivel_ing,p_nivel_egr,en_subtipo,en_filial,en_oficina,
        en_casilla_def,en_tipo_dp,p_fecha_nac,c_es_grupo,en_retencion,
        en_comentario,en_actividad,en_oficial,p_fecha_emision,p_fecha_expira,
        en_asosciada,en_nit,en_referido,en_sector,p_ciudad_nac,
        p_lugar_doc,p_nivel_estudio,p_tipo_vivienda,p_calif_cliente,
        en_doc_validado,
        en_rep_superban,en_tipo_vinculacion,en_vinculacion,en_exc_sipla,
        en_exc_por2,
        en_digito,p_depa_nac,p_pais_emi,p_depa_emi,en_categoria,
        en_pensionado,c_num_empleados,en_pas_finan,en_fpas_finan,en_relacint,
        p_trabajo
      --,        en_recurso_pub,    en_influencia,       en_persona_pub,
      --en_victima

      from   cobis..cl_ente
      where  en_ced_ruc = @i_col2

    if @@error <> 0
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 103005
      /*'Error en creacion de transaccion de servicio'*/
      return 1
    end

    --         /* transaccion de servicio - datos anteriores  */
    insert into cobis..ts_persona
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,persona,nombre,
                 p_apellido,s_apellido,sexo,tipo_ced,cedula,
                 pasaporte,pais,profesion,estado_civil,num_cargas,
                 nivel_ing,nivel_egr,tipo,filial,oficina,
                 casilla_def,tipo_dp,fecha_nac,grupo,retencion,
                 comentario,actividad,oficial,fecha_emision,fecha_expira,
                 asosciada,nit_per,referido,sector,ciudad_nac,
                 lugar_doc,nivel_estudio,tipo_vivienda,calif_cliente,
                 doc_validado,
                 rep_superban,tipo_vinculacion,vinculacion,exc_sipla,exc_por2,
                 digito,depa_nac,pais_emi,depa_emi,categoria,
                 pensionado,num_empleados,pas_finan,fpas_finan,opinternac,
                 tipo_empleo)
      --,       recur_pub,         influencia,          pers_pub,
      --victima)

      select
        @s_ssn,@t_trn,'A',@s_date,@s_user,
        @s_term,@s_srv,@s_lsrv,en_ente,en_nombre,
        p_p_apellido,p_s_apellido,p_sexo,en_tipo_ced,en_ced_ruc,
        p_pasaporte,en_pais,p_profesion,p_estado_civil,p_num_cargas,
        p_nivel_ing,p_nivel_egr,en_subtipo,en_filial,en_oficina,
        en_casilla_def,en_tipo_dp,p_fecha_nac,c_es_grupo,en_retencion,
        en_comentario,en_actividad,en_oficial,p_fecha_emision,p_fecha_expira,
        en_asosciada,en_nit,en_referido,en_sector,p_ciudad_nac,
        p_lugar_doc,p_nivel_estudio,p_tipo_vivienda,p_calif_cliente,
        en_doc_validado,
        en_rep_superban,en_tipo_vinculacion,en_vinculacion,en_exc_sipla,
        en_exc_por2,
        en_digito,p_depa_nac,p_pais_emi,p_depa_emi,en_categoria,
        en_pensionado,c_num_empleados,en_pas_finan,en_fpas_finan,en_relacint,
        p_trabajo
      --,        en_recurso_pub,    en_influencia,       en_persona_pub,
      --en_victima

      from   cobis..cl_ente
      where  en_ced_ruc = @i_col2

    if @@error <> 0
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 103005
      /*'Error en creacion de transaccion de servicio'*/
      return 1
    end
  end --2

go

