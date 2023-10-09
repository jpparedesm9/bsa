/************************************************************************/
/*  Archivo:            clconhom.sp                                     */
/*  Stored procedure:   sp_consulta_homini                              */
/*  Base de datos:      COBIS                                           */
/*  Producto:                                                           */
/*  Disenado por:       Diana Alfonso                                   */
/*  Fecha de escritura: 07/Feb/2012                                     */
/************************************************************************/
/*                       IMPORTANTE                                     */
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
/*                       PROPOSITO                                      */
/*   Stored Procedure para ejecutar el WS de Validacion de Identidad    */
/*   de Clientes Homini                                                 */
/************************************************************************/
/*                       MODIFICACIONES                                 */
/*   FECHA             AUTOR                    RAZON                   */
/*   07/Feb/2013       Diana  Alfonso           Emision Inicial         */
/*   03/Jul/2015       Andres Diab              OTRS 0227697 Timeout Hom*/
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
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
           where  name = 'sp_consulta_homini')
  drop proc sp_consulta_homini
go

create proc sp_consulta_homini
(
  @s_term         varchar(30) = null,
  @s_ofi          smallint = null,
  @t_trn          int = null,
  @t_show_version bit = 0,
  @i_trn          varchar(5) = null,
  @i_operacion    char(1),

  --OPERACION I - INSERTA REGISTRO, V - VALIDACION HUELLA
  @i_user         varchar(12) = null,
  @i_id_caja      int = null,
  @i_tipo_ced     varchar(2) = null,
  @i_ced_ruc      varchar(13) = null,
  @i_ref          varchar(30) = null,
  @i_titularidad  char(1) = null,
  @i_sec_cobis    int = null,-- SOLO APLICA PARA OPERACION V
  @o_codigo       int = 0 out,
  @o_mensaje      varchar(254) = null out,
  @o_tipo_ced     char(2) = null out,-- Req. 371 Tarjeta Debito
  @o_ced_ruc      varchar(13) = null out -- Req. 371 Tarjeta Debito
)
as
  declare
    @w_respuesta        varchar(10),
    @w_estado           varchar(10),
    @w_estado_act       varchar(10),--OTRS 0227697
    @w_sec_homini       varchar(9),--PENDIENTE DEFINIR TAMAÑO
    @w_msg_error        varchar(254),
    @w_par_valhom       char(3),
    @w_par_reshom       char(3),
    @w_val_ofi          char(3),
    @w_return           int,
    @w_sp_name          varchar(64),
    @w_tipo_ced         char(2),
    @w_ced_ruc          varchar(13),
    @w_titularidad      char(1),
    @w_msg_valida       varchar(64),
    @w_fecha            datetime,
    @w_usuario          varchar(10),
    @w_rol              int,
    @w_es_error         char(1),
    @w_alt              int,
    @w_ofi_val          int,
    @w_version_cts_trn  varchar(30),
    @w_version_cts_base varchar(30)

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* INICIALIZACION DE VARIABLES*/
  select
    @w_respuesta = 0,
    @w_estado = '7',
    @w_sec_homini = replicate('0',
                              9),
    @w_msg_error = replicate('X',
                             254),
    @w_sp_name = 'sp_consulta_homini',
    @w_es_error = 'N'

  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  /* SE DEBE OBTENER PARAMETROS GENERALES PARA PRUEBAS*/

  select
    @w_par_valhom = isnull (pa_char,
                            'N')
  from   cobis..cl_parametro
  where  pa_nemonico = 'VALHOM'
     and pa_producto = 'MIS'

  if @w_par_valhom is null
  begin
    exec sp_cerror
      @t_from = @w_sp_name,
      @i_msg  = 'No existe parametro VALHOM',
      @i_sev  = 0,
      @i_num  = 101077
    return 101077
  end

  select
    @w_par_reshom = isnull (pa_char,
                            '1')
  from   cobis..cl_parametro
  where  pa_nemonico = 'RESHOM'
     and pa_producto = 'MIS'

  /* OBTENER PARAMETRO GENERALES ROLLOUT PARA OFICINAS*/

  select
    @w_val_ofi = isnull (pa_char,
                         'N')
  from   cobis..cl_parametro
  where  pa_nemonico = 'VALOFI'
     and pa_producto = 'MIS'

  if @w_val_ofi is null
  begin
    exec sp_cerror
      @t_from = @w_sp_name,
      @i_msg  = 'No existe parametro VALOFI',
      @i_sev  = 0,
      @i_num  = 101077

    return 101077
  end

  select
    @w_ofi_val = codigo
  from   cobis..cl_catalogo
  where  tabla in
         (select
            codigo
          from   cobis..cl_tabla
          where  tabla = 'cl_val_ofi')
         and codigo = @s_ofi
         and estado = 'V'

  select
    @w_ofi_val = isnull(@w_ofi_val,
                        0)

  select
    @w_usuario = pa_char,
    @w_rol = convert(int, pa_tinyint)
  from   cobis..cl_parametro
  where  pa_nemonico = 'URGEO'
     and pa_producto = 'MIS'

  if @w_usuario is null
      or @w_rol is null
  begin
    exec sp_cerror
      @t_from = @w_sp_name,
      @i_msg  = 'USUARIO Y/O ROL PARA SERVICIO NO PARAMETRIZADO',
      @i_sev  = 0,
      @i_num  = 103005

    return 103005
  end

  if @t_trn <> 1608
     and @i_operacion = 'I'
  begin
    exec sp_cerror
      @t_from = @w_sp_name,
      @i_msg  = 'TRANSACCION DE CONSULTA DE HUELLA NO AUTORIZADA',
      @i_sev  = 0,
      @i_num  = 103005

    return 103005
  end

  if @i_operacion = 'I'
  begin
    /* INSERTO REGISTRO DE VALIDACION DE HUELLA */
    insert into cobis..cl_validacion_huella
                (vh_tipo_tran,vh_tipo_ced,vh_ced_ruc,vh_ref,vh_estado,
                 vh_titularidad,vh_usuario,vh_id_caja,vh_fecha)
    values      (@i_trn,@i_tipo_ced,@i_ced_ruc,@i_ref,'I',
                 @i_titularidad,@i_user,@i_id_caja,@w_fecha)

    if @@error <> 0
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_msg  = 'ERROR INSERTANDO REGISTRO DE VALIDACION DE HUELLA',
        @i_sev  = 0,
        @i_num  = 103005

      return 103005
    end

  end

  if @i_operacion = 'V'
  begin
    /* MARCA DE REGISTROS A VALIDAR POR TRANSACCION */
    select
      vh_tipo_ced,
      vh_ced_ruc,
      vh_titularidad
    into   #reg_a_validar
    from   cobis..cl_validacion_huella
    where  vh_ref       = @i_ref
       and vh_tipo_tran = @i_trn
       and vh_id_caja   = @i_id_caja
       and vh_usuario   = @i_user
       and vh_estado    = 'I'

    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_msg  =
      'VERSION DE COMPONENTE DE FIRMAS DESACTUALIZADO, POR FAVOR VALIDAR.',
        @i_sev  = 0,
        @i_num  = 103006

      return 103006
    end

    delete from cobis..cl_validacion_huella
    where  vh_ref       = @i_ref
       and vh_tipo_tran = @i_trn
       and vh_id_caja   = @i_id_caja
       and vh_usuario   = @i_user
       and vh_estado    = 'I'
    if @@error <> 0
    begin
      exec sp_cerror
        @t_from = @w_sp_name,
        @i_msg  = 'ERROR ELIMINANDO REGISTRO DE VALIDACION DE HUELLA',
        @i_sev  = 0,
        @i_num  = 103005

      return 103005
    end

    select
      @w_alt = 1

    while 1 = 1
    begin
      select top 1
        @w_tipo_ced = vh_tipo_ced,
        @w_ced_ruc = vh_ced_ruc,
        @w_titularidad = vh_titularidad
      from   #reg_a_validar
      order  by vh_tipo_ced,
                vh_ced_ruc

      if @@rowcount = 0
        break

      -- LIMPIO VARIABLES DE TRABAJO POR CADA CONSULTA
      select
        @w_msg_valida = null,
        @w_es_error = 'N'

      /*INICIO*/
      if @w_par_valhom = 'S'
      begin
        if @w_val_ofi = 'S'
        begin
          if @s_ofi <> @w_ofi_val
            goto SIGUIENTE
        end

        --Pasos: Ejecucion WS consultaVerificacion
        --Parametro de version base
        select
          @w_version_cts_base = pa_char
        from   cobis..cl_parametro
        where  pa_producto = 'ADM'
           and pa_nemonico = 'VCTSB'

        if @w_version_cts_base is null
        begin
          exec sp_cerror
            @t_from = @w_sp_name,
            @i_msg  = 'No existe parametro VCTSB',
            @i_sev  = 0,
            @i_num  = 101077

          return 101077
        end

        select
          @w_version_cts_trn = valor
        from   cobis..cl_catalogo c,
               cobis..cl_tabla t
        where  c.tabla  = t.codigo
           and t.tabla  = 'ws_version_cts'
           and c.codigo = 26516
           and c.estado = 'V'

        if @@rowcount = 0
          select
            @w_version_cts_trn = @w_version_cts_base --Valor por defecto

        if @w_version_cts_trn = @w_version_cts_base
        begin
          exec @w_return = CTSXPSERVER.cob_procesador..sp_cons_homini_ws
            @t_trn        = 26516,
            @s_user       = @w_usuario,
            @s_rol        = @w_rol,
            @s_ofi        = @s_ofi,
            @i_tipo_ced   = @w_tipo_ced,
            @i_ced_ruc    = @w_ced_ruc,
            @i_user       = @i_user,
            @i_sec_cobis  = @i_sec_cobis,
            @i_esconsulta = 'S',
            @o_respuesta  = @w_respuesta out,
            @o_estado     = @w_estado out,
            @o_sec_homini = @w_sec_homini out,
            @o_msg_error  = @w_msg_error out
        end
        else
        begin
          exec @w_return = CTSXPSERVER2.cob_procesador..sp_cons_homini_ws
            @t_trn        = 26516,
            @s_user       = @w_usuario,
            @s_rol        = @w_rol,
            @s_ofi        = @s_ofi,
            @i_tipo_ced   = @w_tipo_ced,
            @i_ced_ruc    = @w_ced_ruc,
            @i_user       = @i_user,
            @i_sec_cobis  = @i_sec_cobis,
            @i_esconsulta = 'S',
            @o_respuesta  = @w_respuesta out,
            @o_estado     = @w_estado out,
            @o_sec_homini = @w_sec_homini out,
            @o_msg_error  = @w_msg_error out
        end
        /* CODIGO DE TIMEOUT ESTABLECIDO A NIVEL DE CONECTOR */
        if @w_estado = '2609938'
        begin
          select
            @w_return = convert(int, @w_estado)

          exec cobis..sp_cerror
            @t_from = @w_sp_name,
            @i_num  = @w_return,
            @i_msg  = @w_msg_error,
            @i_sev  = 0

          return @w_return
        end

        if @w_return <> 0
            or @w_sec_homini = replicate('0',
                                         9)
        begin
          if @w_return = 0
            select
              @w_return = 101235

          exec cobis..sp_cerror
            @t_from = @w_sp_name,
            @i_num  = @w_return,
            @i_msg  =
'Error en el proceso de validacion de identidad. Favor contactese con la mesa de ayuda.'
  ,
@i_sev  = 0

  return @w_return
end

  if substring(@w_msg_error,
               1,
               2) = 'XX'
    select
      @w_msg_error = null

  /* TRANSACCION DE SERVICIO*/
  select
    @w_alt = @w_alt + 1
  insert into cobis..ws_tran_servicio
              (ts_tipo_tran,ts_ssn,ts_sec_ext,ts_campo3,ts_fecha,
               ts_hora,ts_usuario,ts_terminal,ts_oficina,ts_campo2,
               ts_campo1,ts_campo5,ts_campo4,ts_campo10,ts_estado,
               ts_retorno,ts_conciliado,ts_cod_alterno)
  values      (26516,@i_sec_cobis,convert(varchar(12), @w_sec_homini),'S',
               @w_fecha,
               getdate(),@i_user,@s_term,@s_ofi,@w_ced_ruc,
               @w_tipo_ced,@w_respuesta,@w_estado,@w_msg_error,@w_estado,
               @w_return,'S',@w_alt)
  if @@error <> 0
  begin
    /* 'Error en creacion de transaccion de servicio'*/
    exec sp_cerror
      @t_from = @w_sp_name,
      @i_msg  = 'ERROR INSERTANDO CONSULTA TRANSACCION DE SERVICIO WS',
      @i_sev  = 0,
      @i_num  = 103005

    return 103005
  end

  if @w_msg_error = 'null'
    select
      @w_msg_error = null

  if @i_trn = 2
     and @w_estado = 7
    select
      @w_estado = 1,
      @w_msg_error = null

  if @w_msg_error is not null
     and @w_estado = 1
  begin
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 103006,
      @i_msg  =
'Error en el proceso de validacion de identidad. Favor contactese con la mesa de ayuda..'
  ,
@i_sev  = 0
  return 103006
end

  -- Ejecucion WS actualizacionVerificacion
  select
    @w_version_cts_trn = valor
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'ws_version_cts'
     and c.codigo = 26517
     and c.estado = 'V'

  if @@rowcount = 0
    select
      @w_version_cts_trn = @w_version_cts_base --Valor por defecto

  if @w_version_cts_trn = @w_version_cts_base
  begin
    exec @w_return = CTSXPSERVER.cob_procesador..sp_cons_homini_ws
      @t_trn        = 26517,
      @s_user       = @w_usuario,
      @s_rol        = @w_rol,
      @s_ofi        = @s_ofi,
      @i_tipo_ced   = @w_tipo_ced,
      @i_ced_ruc    = @w_ced_ruc,
      @i_user       = @i_user,
      @i_sec_cobis  = @i_sec_cobis,
      @i_sec_homini = @w_sec_homini,
      @i_esconsulta = 'N',
      @o_respuesta  = @w_respuesta out,
      @o_msg_error  = @w_msg_error out,
      @o_estado     = @w_estado_act out
  end
  else
  begin
    exec @w_return = CTSXPSERVER2.cob_procesador..sp_cons_homini_ws
      @t_trn        = 26517,
      @s_user       = @w_usuario,
      @s_rol        = @w_rol,
      @s_ofi        = @s_ofi,
      @i_tipo_ced   = @w_tipo_ced,
      @i_ced_ruc    = @w_ced_ruc,
      @i_user       = @i_user,
      @i_sec_cobis  = @i_sec_cobis,
      @i_sec_homini = @w_sec_homini,
      @i_esconsulta = 'N',
      @o_respuesta  = @w_respuesta out,
      @o_msg_error  = @w_msg_error out,
      @o_estado     = @w_estado_act out
  end

  /* CODIGO DE TIMEOUT ESTABLECIDO A NIVEL DE CONECTOR */
  if @w_estado_act = '2609938'
  begin
    select
      @w_return = convert(int, @w_estado_act)

    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = @w_return,
      @i_msg  = @w_msg_error,
      @i_sev  = 0

    return @w_return
  end

  if @w_return <> 0
      or @w_respuesta = replicate('X',
                                  254)
  begin
    if @w_return = 0
      select
        @w_return = 101235

    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = @w_return,
      @i_msg  = 'ERROR ACTUALIZANDO VERIFICACION DE HUELLA WS',
      @i_sev  = 0

    return @w_return
  end
  select
    @w_alt = @w_alt + 1
  insert into cobis..ws_tran_servicio
              (ts_tipo_tran,ts_ssn,ts_sec_ext,ts_campo3,ts_fecha,
               ts_hora,ts_usuario,ts_terminal,ts_oficina,ts_campo2,
               ts_campo1,ts_campo4,ts_campo10,ts_estado,ts_retorno,
               ts_conciliado,ts_cod_alterno,ts_campo5)
  values      (26517,@i_sec_cobis,convert(varchar(12), @w_sec_homini),'N',
               @w_fecha,
               getdate(),@i_user,@s_term,@s_ofi,@w_ced_ruc,
               @w_tipo_ced,@w_estado,@w_msg_error,@w_estado,@w_return,
               'S',@w_alt,@w_respuesta)
  if @@error <> 0
  begin
    /* 'Error en creacion de transaccion de servicio'*/
    exec sp_cerror
      @t_from = @w_sp_name,
      @i_msg  = 'ERROR INSERTANDO ACTUALIZACION TRANSACCION DE SERVICIO WS',
      @i_sev  = 0,
      @i_num  = 103005

    return 103005
  end
end -- END PARAM VALHOM
else
begin
  SIGUIENTE:
  select
    @w_respuesta = 0,
    @w_estado = @w_par_reshom,
    @w_sec_homini = @i_sec_cobis,
    @w_msg_error = null
end

  -- VERIFICACION RESPUESTA OBTENIDA PARA EL CLIENTE VALIDADO
  select
    @w_msg_valida = c.valor
  from   cl_tabla t,
         cl_catalogo c
  where  t.codigo = c.tabla
     and t.tabla  = 'cl_aprob_valida'
     and c.estado = 'V'
     and c.codigo = @w_estado

  if @w_msg_valida is not null
  begin
    if @w_titularidad in ('S', 'I')
    -- SI TITULARIDAD ALTERNA o INDIVIDUAL CON FIRMANTE O TUTOR, RETORNAR AL PRIMER CASO DE EXITO.
    begin
      select
        @o_codigo = 0,
        @o_mensaje = null
      break
    end
    if @w_titularidad = 'M'
    begin
      select
        @o_codigo = 0,
        @o_mensaje = null
    end
  end
  else
    select
      @w_es_error = 'S'

  if @w_es_error = 'S'
  begin
    -- VERIFICACION RESPUESTA OBTENIDA PARA EL CLIENTE VALIDADO
    select
      @w_msg_valida = c.valor
    from   cl_tabla t,
           cl_catalogo c
    where  t.codigo = c.tabla
       and t.tabla  = 'cl_iden_valida'
       and c.estado = 'V'
       and c.codigo = @w_estado

    if @w_msg_valida is not null
    begin
      if @w_titularidad = 'M'
      -- NO ES TITULARIDAD ALTERNA, DEBE RETORNAR AL PRIMERO QUE VALIDE CON ERROR.
      begin
        select
          @o_codigo = 101235,
          @o_mensaje = @w_msg_valida
        break
      end
      if @w_titularidad in ('S', 'I')
      -- SI ES TITULARIDAD ALTERNA Y NO HAY VALIDACIONES EXITOSAS RETORNA ULTIMO MENSAJE DE ERROR.
      begin
        select
          @o_codigo = 101235,
          @o_mensaje = @w_msg_valida
      end
    end
    else
    begin
      if @w_titularidad = 'M'
      -- NO ES TITULARIDAD ALTERNA, DEBE RETORNAR AL PRIMERO QUE VALIDE CON ERROR.
      begin
        select
          @o_codigo = 101235,
          @o_mensaje = null
        break
      end
      if @w_titularidad in ('S', 'I')
      -- SI TITULARIDAD ALTERNA, RETORNAR AL PRIMER CASO DE EXITO.
      begin
        select
          @o_codigo = 101235,
          @o_mensaje = @w_msg_valida
      end
    end
  end
  -- FIN DE VERIFICACION RESPUESTA OBTENIDA PARA EL CLIENTE VALIDADO

  delete from #reg_a_validar
  where  vh_tipo_ced = @w_tipo_ced
     and vh_ced_ruc  = @w_ced_ruc

end --END WHILE
  -- Req. 371 Tarjetas Debito
  if @o_codigo = 0
  begin
    select
      @o_tipo_ced = @w_tipo_ced,
      @o_ced_ruc = @w_ced_ruc
  end

end

  fin:

  return 0

go

