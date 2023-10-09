/************************************************************************/
/*   Archivo         :   climasi.sp                                     */
/*   Stored procedure:   sp_cli_masiva                                  */
/*   Base de datos   :   cobis                                          */
/*   Producto        :   MIS                                            */
/************************************************************************/
/*                  IMPORTANTE                                          */
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
/*                  PROPOSITO                                           */
/*   Este stored procedure permite crear clientes en forma masiva       */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*      03/may/2000     C. Espinel      Emision Inicial                 */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_cli_masiva')
  drop proc sp_cli_masiva
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_cli_masiva
  @t_show_version bit = 0
as
  declare
    @w_sp_name    varchar(32),
    @w_return     int,
    @w_ente       int,
    @w_tipo       char(1),
    @w_nombre     varchar(64),
    @w_p_apellido varchar(25),
    @w_s_apellido varchar(25),
    @w_c_apellido varchar(25),
    @w_cedula     varchar(25),
    @w_nit        varchar(25),
    @w_sexo       catalogo,
    @w_direccion  descripcion,
    @w_telefono   varchar(25),
    @w_nomlar     varchar(120),
    @w_nomape     varchar(120),
    @w_pais       smallint,
    @w_cont_dir   tinyint,
    @w_cont_tel   tinyint,
    @w_proceso    char(1),
    @w_error      varchar(25)

  select
    @w_sp_name = 'sp_cli_masiva'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_pais = convert(smallint, b.codigo)
  from   cl_default b,
         cl_tabla a
  where  a.tabla  = 'cl_pais'
     and a.codigo = b.tabla

  -- Cursor sobre la tabla cl_cli_masiva
  declare climasiva cursor for
    select
      cm_tipo,
      cm_nombre,
      cm_p_apellido,
      cm_s_apellido,
      cm_c_apellido,
      cm_cedula,
      cm_nit,
      cm_sexo,
      cm_direccion,
      cm_telefono,
      cm_proceso,
      cm_error
    from   cobis..cl_cli_masiva
    for update of cm_proceso, cm_error

  -- Abre cursor
  open climasiva

  -- Ubica primer registro del cursor
  fetch climasiva into @w_tipo,
                       @w_nombre,
                       @w_p_apellido,
                       @w_s_apellido,
                       @w_c_apellido,
                       @w_cedula,
                       @w_nit,
                       @w_sexo,
                       @w_direccion,
                       @w_telefono,
                       @w_proceso,
                       @w_error

  -- Control del estado del cursor
  if @@fetch_status = -2
  begin
    close climasiva
    deallocate climasiva
    exec cobis..sp_cerror
      @i_num = 201157
    return 201157
  end
  else if @@fetch_status = -1
  begin
    close climasiva
    deallocate climasiva
    return 0
  end

  -- Proceso de informacion
  while @@fetch_status = 0
  begin
    /*Valida tipo de persona*/
    if @w_tipo <> 'P'
       and @w_tipo <> 'C'
    begin
      update cl_cli_masiva
      set    cm_proceso = 'N',
             cm_error = 'TIPO DE PERSONA'
      where  current of climasiva

      goto LEER
    end

    /*Valida nombre*/
    if @w_nombre is null
    begin
      update cl_cli_masiva
      set    cm_proceso = 'N',
             cm_error = 'NO EXISTE NOMBRE'
      where  current of climasiva

      goto LEER
    end

    /*Valida apellido*/
    if @w_tipo = 'P'
       and @w_p_apellido is null
    begin
      update cl_cli_masiva
      set    cm_proceso = 'N',
             cm_error = 'NO EXISTE PRIMER APELLIDO'
      where  current of climasiva

      goto LEER
    end

    /*Valida cedula */
    if @w_tipo = 'P'
       and datalength(@w_cedula) <> 11
    begin
      update cl_cli_masiva
      set    cm_proceso = 'N',
             cm_error = 'CEDULA INCORRECTA'
      where  current of climasiva

      goto LEER
    end

    /*Valida existencia de persona*/
    if exists(select
                cedula
              from   cl_persona
              where  cedula = @w_cedula)
    begin
      update cl_cli_masiva
      set    cm_proceso = 'N',
             cm_error = 'YA EXISTE CLIENTE'
      where  current of climasiva

      goto LEER
    end

    /*Valida nit */
    if @w_tipo = 'C'
       and datalength(@w_cedula) <> 14
    begin
      update cl_cli_masiva
      set    cm_proceso = 'N',
             cm_error = 'NIT INCORRECTO'
      where  current of climasiva

      goto LEER
    end

    /*Valida existencia de compania*/
    if exists(select
                ruc
              from   cl_compania
              where  ruc = @w_nit)
    begin
      update cl_cli_masiva
      set    cm_proceso = 'N',
             cm_error = 'YA EXISTE CLIENTE'
      where  current of climasiva

      goto LEER
    end

    /* Verificar el sexo de la persona */
    if @w_tipo = 'P'
    begin
      exec @w_return = cobis..sp_catalogo
        --@t_debug        = @t_debug,
        --@t_file         = @t_file,
        @t_from      = @w_sp_name,
        @i_operacion = 'E',
        @i_tabla     = 'cl_sexo',
        @i_codigo    = @w_sexo
      if @w_return <> 0
      begin
        update cl_cli_masiva
        set    cm_proceso = 'N',
               cm_error = 'VALOR SEXO INCORRECTO'
        where  current of climasiva

        goto LEER
      end
    end

    if @w_tipo = 'P'
    begin
      if @w_s_apellido is null
        if @w_c_apellido is not null
        begin
          select
            @w_nomlar = @w_p_apellido + ' ' + @w_c_apellido + ' ' + @w_nombre
          select
            @w_nomape = @w_nombre + ' ' + @w_p_apellido + ' ' + @w_c_apellido
        end
        else
        begin
          select
            @w_nomlar = @w_p_apellido + ' ' + @w_nombre
          select
            @w_nomape = @w_nombre + ' ' + @w_p_apellido
        end
      else if @w_c_apellido is not null
      begin
        select
          @w_nomlar = @w_p_apellido + ' ' + @w_s_apellido + ' ' + @w_c_apellido
                      +
                      ' '
                      +
                             @w_nombre
        select
          @w_nomape = @w_nombre + ' ' + @w_p_apellido + ' ' + @w_s_apellido +
                      ' '
                      +
                                                              @w_c_apellido
      end
      else
      begin
        select
          @w_nomlar = @w_p_apellido + ' ' + @w_s_apellido + ' ' + @w_nombre
        select
          @w_nomape = @w_nombre + ' ' + @w_p_apellido + ' ' + @w_s_apellido
      end
    end

    if @w_direccion is not null
      select
        @w_cont_dir = 1
    else
      select
        @w_cont_dir = 0

    if @w_telefono is not null
      select
        @w_cont_tel = 1
    else
      select
        @w_cont_tel = 0

    begin tran
    /* encontrar un secuencial para la nueva persona */
    select
      @w_ente = siguiente + 1
    from   cobis..cl_seqnos
    where  tabla = 'cl_ente'

    update cl_seqnos
    set    siguiente = @w_ente
    where  tabla = 'cl_ente'

    if @w_tipo = 'P'
    begin
      insert into cl_ente
                  (en_ente,en_nombre,en_subtipo,en_filial,en_oficina,
                   en_fecha_mod,en_pais,en_retencion,en_mala_referencia,
                   en_direccion
                   ,
                   en_casilla,en_referencia,en_balance,en_actividad,
                   en_cont_malas,
                   p_p_apellido,p_s_apellido,p_sexo,p_fecha_nac,p_profesion,
                   p_pasaporte,p_estado_civil,p_tipo_persona,p_personal,
                   p_propiedad,
                   p_trabajo,p_soc_hecho,en_ced_ruc,en_oficial,en_nomlar,
                   en_fecha_crea)--,
      --JAN ENE/01   en_nombre_largo, p_c_apellido,en_exento_iva,p_nit)
      values      (@w_ente,@w_nombre,'P',1,1,
                   getdate(),isnull(@w_pais,
                          0),'N','N',@w_cont_dir,
                   0,0,0,'0',0,
                   @w_p_apellido,@w_s_apellido,@w_sexo,'01/01/2000','0',
                   null,'ND','ND',0,0,
                   0,0,@w_cedula,0,@w_nomlar,
                   getdate())--,
      --JAN ENE/01   @w_c_apellido,'S',@w_nit)
      --        @w_nit)
      if @@error <> 0
      begin
        update cl_cli_masiva
        set    cm_proceso = 'N',
               cm_error = 'ERROR EN INSERCION'
        where  current of climasiva

        goto LEER
      end
    end
    else
    begin
      insert into cl_ente
                  (en_ente,en_nombre,en_subtipo,en_filial,en_oficina,
                   en_fecha_mod,en_pais,en_retencion,en_mala_referencia,
                   en_direccion
                   ,
                   en_casilla,en_referencia,en_balance,en_actividad,
                   en_cont_malas,
                   c_posicion,c_tipo_compania,c_rep_legal,en_oficial,
                   en_fecha_crea
                   ,
                   en_nomlar)--,
      --en_exento_iva)
      values      (@w_ente,@w_nombre,'C',1,1,
                   getdate(),isnull(@w_pais,
                          0),'S','N',@w_cont_dir,
                   0,0,0,'0',0,
                   null,'P',0,0,getdate(),
                   @w_nombre)--,'N')
      if @@error <> 0
      begin
        update cl_cli_masiva
        set    cm_proceso = 'N',
               cm_error = 'ERROR EN INSERCION'
        where  current of climasiva

        goto LEER
      end
    end

    if @w_direccion is not null
    begin
      insert into cl_direccion
                  (di_ente,di_direccion,di_descripcion,di_tipo,di_telefono,
                   di_vigencia,di_fecha_registro,di_fecha_modificacion,di_sector
                   ,
                   di_zona,
                   di_parroquia,di_ciudad,di_oficina,di_verificado)
      values      (@w_ente,1,@w_direccion,'D',@w_cont_tel,
                   'S',getdate(),getdate(),'ND','ND',
                   0,0,1,'N')

      if @@error <> 0
      begin
        update cl_cli_masiva
        set    cm_proceso = 'N',
               cm_error = 'ERROR EN INSERCION DE DIRECCION'
        where  current of climasiva

        goto LEER
      end

      if @w_telefono is not null
      begin
        insert into cl_telefono
                    (te_ente,te_direccion,te_secuencial,te_valor,
                     te_tipo_telefono)
        values      (@w_ente,1,1,@w_telefono,'T')

        if @@error <> 0
        begin
          update cl_cli_masiva
          set    cm_proceso = 'N',
                 cm_error = 'ERROR EN INSERCION TELEFONO'
          where  current of climasiva

          goto LEER
        end
      end
    end

    commit tran

    LEER:
    -- Ubica siguiente registro del cursor
    fetch climasiva into @w_tipo,
                         @w_nombre,
                         @w_p_apellido,
                         @w_s_apellido,
                         @w_c_apellido,
                         @w_cedula,
                         @w_nit,
                         @w_sexo,
                         @w_direccion,
                         @w_telefono,
                         @w_proceso,
                         @w_error

    -- Control del estado del cursor
    if @@fetch_status = -2
    begin
      close climasiva
      deallocate climasiva
      exec cobis..sp_cerror
        @i_num = 201157
      return 201157
    end
  end

  -- Cierra cursor y libera memoria
  close climasiva
  deallocate climasiva

  return 0

go

