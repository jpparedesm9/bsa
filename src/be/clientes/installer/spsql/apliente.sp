/************************************************************************/
/*    Archivo:             apliente.sp                                  */
/*    Stored procedure:    sp_aplicar_ente_cl                           */
/*    Base de datos:       cobis                                        */
/*    Producto:            MIS                                          */
/*    Disenado por:        Patricia Garzon Rojas                        */
/*    Fecha de escritura:  Nov 1999                                     */
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
/*  Toma los datos de la tabla cl_ente_mig e ingresa los datos a        */
/*  las tablas cl_ente siempre y cuando en el proceso de carga no       */
/*  hayan existido errores.                                             */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA             AUTOR         RAZON                             */
/*    10Nov99         Patricia Garzon Emision Inicial                   */
/*    Dic 15/2000     E. Laguna       Creacion Masiva - Bantequendama   */
/*    FEB 19/2001     E. Laguna       Actualizacion Masiva-Btequendama  */
/*    Feb 27/2002     J.Andrade       Actualiza campos Prioritarios     */
/*    Abr/05/2002     J.Andrade       Actualiza banca                   */
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
           where  name = 'sp_aplicar_ente_cl')
  drop proc sp_aplicar_ente_cl
go

create proc sp_aplicar_ente_cl
(
  @s_ssn             int = null,
  @s_date            datetime = null,
  @s_user            login = null,
  @s_term            descripcion = null,
  @s_corr            char(1) = null,
  @s_ssn_corr        int = null,
  @s_ofi             smallint = null,
  @s_sesn            int = null,
  @s_srv             varchar(30) = null,
  @s_lsrv            varchar(30) = null,
  @t_rty             char(1) = null,
  @t_trn             smallint = null,
  @t_debug           char(1) = 'N',
  @t_file            varchar(14) = null,
  @t_from            varchar(30) = null,
  @t_show_version    bit = 0,
  @i_archivo         varchar(30) = null,
  @i_archivo_entes   varchar(30) = null,
  @i_filial          tinyint = null,
  @i_sucursal        smallint = null,
  @i_operacion       char(1) = null,
  @i_comentario      varchar(30) = null,
  @o_archivo_cargado char(1) = 'N' out,
  @o_ente            int = null out
)
as
  declare
    @w_sp_name               char(30),
    @w_num_ente              int,
    @w_subtipo               char(1),
    @w_c_nombre_completo     varchar(254),
    @w_nombrelargo           varchar(96),
    @w_nombre                varchar(64),
    @w_ntelefonos            tinyint,
    @w_fecha                 datetime,
    @w_archivo_ente          varchar(30),
    @w_p_p_apellido          varchar(16),
    @w_p_s_apellido          varchar(16),
    @w_malasref              char(1),
    @w_archivo               varchar(30),
    @w_secuencia             int,
    @w_ente                  int,
    @w_p_fecha_nac           datetime,
    @w_p_fecha_ing           datetime,
    @w_p_fecha_mod           datetime,
    @w_ced_ruc               numero,
    @w_sigla                 varchar(25),
    @w_actividad             catalogo,
    @w_oficial               smallint,
    @w_nat_jur               catalogo,
    @w_retencion             char(1),
    @w_oficina               smallint,
    @w_comentario            smallint,
    @w_departamento          smallint,
    @w_ciudad                int,--catalogo,
    @w_casilla               varchar(30),
    @w_direccion             varchar(254),
    @w_telefono1             varchar(16),
    @w_telefono2             varchar(16),
    @w_auxcom                varchar(16),
    @w_origen                catalogo,
    @w_p_sexo                sexo,
    @w_p_tipo_ced            char(2),
    @w_sector                catalogo,
    @w_estado_emp            catalogo,
    @w_tipo_soc              catalogo,
    @w_en_pais               smallint,
    @w_p_pais_emi            smallint,
    @w_p_depa_emi            smallint,
    @w_p_depa_nac            smallint,
    @w_p_ciudad_nac          int,
    @w_p_lugar_doc           int,
    @w_dm_direccion          tinyint,
    @w_num_direccion         tinyint,
    @w_num_telefono          tinyint,
    @w_dm_descripcion        varchar(254),
    @w_dm_parroquia          int,
    @w_dire                  tinyint,
    @w_dm_ciudad             int,
    @w_dm_tipo               catalogo,
    @w_dm_telefono           tinyint,
    @w_dm_sector             catalogo,
    @w_dm_zona               catalogo,
    @w_tm_secuencial         tinyint,
    @w_tm_valor              varchar(12),
    @w_tm_tipo_telefono      catalogo,
    @w_en_categoria          catalogo,
    @w_retorno               tinyint,
    /* JAL Feb 2002 */
    @w_en_exc_sipla          char(1),
    @w_en_exc_por2           char(1),
    @w_en_pensionado         char(1),
    @w_en_gran_contribuyente char(1),
    @w_en_retencion          char(1),
    @w_p_profesion           catalogo,
    /* JAL Feb 2002 */
    @o_msj_error             varchar(50),
    @o_producto_error        int,
    @w_referido              smallint

  select
    @w_sp_name = 'sp_aplicar_ente_cl'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_dm_parroquia = 1
  select
    @w_dm_direccion = 1
  select
    @w_ntelefonos = 0
  select
    @w_malasref = 'N'
  select
    @w_dm_sector = '1'

  select
    @w_en_exc_sipla = 'N'
  select
    @w_en_exc_por2 = 'N'
  select
    @w_en_pensionado = 'N'
  select
    @w_en_categoria = '001'
  select
    @w_en_gran_contribuyente = 'N'
  select
    @w_en_retencion = 'S'
  select
    @w_p_profesion = '000'

  if (@t_trn not in(1393, 1404))
  begin
    /* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 107101
    return 1
  end

  -- Verificar que el archivo no haya sido aplicado anteriormente

  if exists (select
               *
             from   cl_archivos_cargados_mig
             where  ac_archivo = @i_archivo)
  begin
    select
      @o_archivo_cargado = 'S'
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 107098
    return 1
  end

  /* ---------------------------------- INSERCION ---                            */

  if @i_operacion = 'I'
  begin
    select
      @w_num_ente = siguiente
    from   cl_seqnos
    where  bdatos = 'cobis'
       and tabla  = 'cl_ente'

    -- Crear un cursor para leer la tabla cargada desde diskette
    declare cursor_ente_mig cursor for
      select
        em_user,
        em_sesn,
        em_archivo,
        em_secuencia,
        em_ente,
        em_nombre,
        em_p_p_apellido,
        em_p_s_apellido,
        em_p_fecha_nac,
        em_p_fecha_ing,
        em_p_fecha_mod,
        em_subtipo,
        em_ced_ruc,
        em_sigla,
        em_actividad,
        em_oficial,
        em_nat_jur,
        em_retencion,
        em_oficina,
        em_comentario,
        em_departamento,
        em_ciudad,
        em_casilla,
        em_telefono1,
        em_telefono2,
        em_origen,
        em_p_sexo,
        em_p_tipo_ced,
        em_sector,
        em_estado_emp,
        em_tipo_soc,
        em_en_pais,
        em_p_pais_emi,
        em_p_depa_emi,
        em_p_depa_nac,
        em_p_ciudad_nac,
        em_p_lugar_doc,
        em_direccion,
        em_direccion,
        dm_ciudad,
        dm_tipo,
        dm_telefono,
        dm_sector,
        dm_zona,
        tm_secuencial,
        tm_valor,
        tm_tipo_telefono
      from   cl_ente_mig
      where  em_user    = @s_user
         and em_sesn    = @s_sesn
         and em_archivo = @i_archivo

    open cursor_ente_mig
    fetch cursor_ente_mig into @s_user,
                               @s_sesn,
                               @i_archivo,
                               @w_secuencia,
                               @w_ente,
                               @w_nombre,
                               @w_p_p_apellido,
                               @w_p_s_apellido,
                               @w_p_fecha_nac,
                               @w_p_fecha_ing,
                               @w_p_fecha_mod,
                               @w_subtipo,
                               @w_ced_ruc,
                               @w_sigla,
                               @w_actividad,
                               @w_oficial,
                               @w_nat_jur,
                               @w_retencion,
                               @w_oficina,
                               @w_comentario,
                               @w_departamento,
                               @w_ciudad,
                               @w_casilla,
                               @w_telefono1,
                               @w_telefono2,
                               @w_origen,
                               @w_p_sexo,
                               @w_p_tipo_ced,
                               @w_sector,
                               @w_estado_emp,
                               @w_tipo_soc,
                               @w_en_pais,
                               @w_p_pais_emi,
                               @w_p_depa_emi,
                               @w_p_depa_nac,
                               @w_p_ciudad_nac,
                               @w_p_lugar_doc,
                               @w_direccion,
                               @w_dm_descripcion,
                               @w_dm_ciudad,
                               @w_dm_tipo,
                               @w_ntelefonos,
                               @w_dm_sector,
                               @w_dm_zona,
                               @w_tm_secuencial,
                               @w_tm_valor,
                               @w_tm_tipo_telefono

    -- Para cada uno de los datos hasta que no hayan datos en la tabla
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

      -- Comenzar una transaccion
      begin tran

      select
        @w_num_ente = @w_num_ente + 1
      -- quitar espacios en blanco del nombre
      select
        @w_nombre = ltrim(rtrim(@w_nombre))
      select
        @w_nombrelargo = ''
      -- Crear un nuevo numero de ente
      --      select @w_num_ente = null

      select
        @w_fecha = @s_date

      select
        @w_auxcom = convert(varchar(10), @w_comentario)

      /*if @w_casilla = null
         begin
          select @w_casilla = null
         end */

      if @w_subtipo = 'P'
      begin
        select
          @w_nombrelargo = @w_p_p_apellido + ' ' + @w_p_s_apellido + ' ' +
                           @w_nombre
      --         select @w_c_nombre_completo = null
      end

      if @w_subtipo = 'C'
      begin
        --         select @w_c_nombre_completo = @w_nombre 
        select
          @w_nombrelargo = @w_nombre
      end

      select
        @w_referido = fu_funcionario
      from   cobis..cl_funcionario
      where  fu_login = @s_user

      -- Insertar los datos en cl_ente
      insert into cl_ente
                  (en_ente,en_nombre,p_p_apellido,p_s_apellido,p_sexo,
                   p_fecha_nac,en_fecha_crea,en_fecha_mod,en_subtipo,en_ced_ruc,
                   c_sigla,en_actividad,en_oficial,en_oficina,en_comentario,
                   en_tipo_ced,en_sector,en_situacion_cliente,c_tipo_compania,
                   en_mala_referencia,
                   en_retencion,en_filial,en_pais,p_pais_emi,p_depa_nac,
                   p_ciudad_nac,p_lugar_doc,p_depa_emi,en_direccion,
                   en_referencia,
                   en_balance,en_doc_validado,en_rep_superban,p_nivel_ing,
                   p_nivel_egr,
                   c_tipo_soc,en_tipo_vinculacion,en_nomlar,en_exc_sipla,
                   en_exc_por2
                   ,
                   en_pensionado,en_categoria,en_gran_contribuyente,
                   p_profesion,
                   en_referido)
      values      (@w_num_ente,@w_nombre,@w_p_p_apellido,@w_p_s_apellido,
                   @w_p_sexo
                   ,
                   @w_p_fecha_nac,@w_p_fecha_ing,@w_p_fecha_mod,
                   @w_subtipo,
                   @w_ced_ruc,
                   @w_sigla,@w_actividad,@w_oficial,@w_oficina,@w_auxcom,
                   @w_p_tipo_ced,@w_sector,@w_estado_emp,@w_nat_jur,@w_malasref,
                   @w_en_retencion,@i_filial,@w_en_pais,@w_p_pais_emi,
                   @w_p_depa_nac,
                   @w_p_ciudad_nac,@w_p_lugar_doc,@w_p_depa_emi,@w_dm_direccion,
                   0,
                   --              0,'N','N',0.00,0.00,@w_tipo_soc,@w_origen,@w_en_categoria,@w_nombrelargo)
                   0,'N','N',0.00,0.00,
                   @w_tipo_soc,@w_origen,@w_nombrelargo,@w_en_exc_sipla,
                   @w_en_exc_por2
                   ,
                   @w_en_pensionado,@w_en_categoria,
                   @w_en_gran_contribuyente,@w_p_profesion,@w_referido)

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

      insert into cl_direccion
                  (di_ente,di_direccion,di_descripcion,di_parroquia,di_ciudad,
                   di_tipo,di_telefono,di_sector,di_zona,di_oficina,
                   di_fecha_registro,di_fecha_modificacion,di_vigencia,
                   di_verificado
                   ,
                   di_funcionario,
                   di_fecha_ver,di_provincia,di_principal)
      values      (@w_num_ente,1,@w_dm_descripcion,@w_dm_parroquia,@w_ciudad,
                   @w_dm_tipo,@w_dm_telefono,@w_dm_sector,@w_dm_zona,1,
                   @w_fecha,@w_fecha,'S','N',@s_user,
                   null,@w_departamento,'S')
      if @@error <> 0
      begin
        /* Error en insercion de registro */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103007
        return 1
      end

      /*  Transaccion de Servicio Registro */
      insert into ts_direccion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,direccion,
                   descripcion,vigencia,sector,zona,parroquia,
                   ciudad,tipo,oficina,verificado,barrio,
                   provincia)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_num_ente,1,
                   @w_dm_descripcion,'S',@w_dm_sector,@w_dm_zona,@w_dm_parroquia
                   ,
                   @w_ciudad,@w_dm_tipo,1,'N',null,
                   @w_departamento)

      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end
      else
        select
          @w_num_direccion = 1

    /*****  Inserta Apartados Aereos  *************/
      --if @w_casilla <> null and 

      if @w_casilla not in('1', '0', null)
      begin
        insert into cl_direccion
                    (di_ente,di_direccion,di_descripcion,di_parroquia,di_ciudad,
                     di_tipo,di_telefono,di_sector,di_zona,di_oficina,
                     di_fecha_registro,di_fecha_modificacion,di_vigencia,
                     di_verificado
                     ,
                     di_funcionario,
                     di_fecha_ver,di_provincia,di_principal)
        values      (@w_num_ente,2,@w_casilla,@w_dm_parroquia,@w_ciudad,
                     '001',@w_dm_telefono,@w_dm_sector,@w_dm_zona,1,
                     @w_fecha,@w_fecha,'S','N',@s_user,
                     null,@w_departamento,'N')
        if @@error <> 0
        begin
          /* Error en insercion de registro */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103007
          return 1

          /*  Transaccion de Servicio Registro */
          insert into ts_direccion
                      (secuencial,tipo_transaccion,clase,fecha,usuario,
                       terminal,srv,lsrv,ente,direccion,
                       descripcion,vigencia,sector,zona,parroquia,
                       ciudad,tipo,oficina,verificado,barrio,
                       provincia)
          values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                       @s_term,@s_srv,@s_lsrv,@w_num_ente,2,
                       @w_casilla,'S',@w_dm_sector,@w_dm_zona,@w_dm_parroquia,
                       @w_ciudad,'001',1,'N',null,
                       @w_departamento)

          if @@error <> 0
          begin
            /*  Error en creacion de transaccion de servicio  */
            exec cobis..sp_cerror
              @t_debug= @t_debug,
              @t_file = @t_file,
              @t_from = @w_sp_name,
              @i_num  = 103005
            return 1
          end

        end
        else
          select
            @w_num_direccion = @w_num_direccion + 1

      end

      --insercion de telefonos del ente
      if @w_telefono1 not in ('0', '1')
      begin
        select
          @w_tm_secuencial = 1,
          @w_dm_direccion = 1

        insert into cl_telefono
                    (te_ente,te_direccion,te_secuencial,te_valor,
                     te_tipo_telefono)
        values      (@w_num_ente,@w_dm_direccion,@w_tm_secuencial,@w_telefono1,
                     @w_tm_tipo_telefono)
        if @@error <> 0
        begin
          /* Error en insercion de registro */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103038
          return 1
        end

        /*  Transaccion de Servicio Registro */
        insert into ts_telefono
                    (secuencial,tipo_transaccion,clase,fecha,usuario,
                     terminal,srv,lsrv,ente,direccion,
                     telefono,valor,tipo)
        values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                     @s_term,@s_srv,@s_lsrv,@w_num_ente,@w_dm_direccion,
                     @w_tm_secuencial,@w_telefono1,@w_tm_tipo_telefono)

        if @@error <> 0
        begin
          /*  Error en creacion de transaccion de servicio  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 103005
          return 1
        end

      end

      if @w_telefono2 not in ('1', '0')
      begin
        select
          @w_tm_secuencial = @w_tm_secuencial + 1

        insert into cl_telefono
                    (te_ente,te_direccion,te_secuencial,te_valor,
                     te_tipo_telefono)
        values      (@w_num_ente,@w_dm_direccion,@w_tm_secuencial,@w_telefono2,
                     @w_tm_tipo_telefono)
        if @@error <> 0
        begin
          /* Error en insercion de registro */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103038
          return 1
        end

        /*  Transaccion de Servicio Registro */
        insert into ts_telefono
                    (secuencial,tipo_transaccion,clase,fecha,usuario,
                     terminal,srv,lsrv,ente,direccion,
                     telefono,valor,tipo)
        values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                     @s_term,@s_srv,@s_lsrv,@w_num_ente,@w_dm_direccion,
                     @w_tm_secuencial,@w_telefono2,@w_tm_tipo_telefono)

        if @@error <> 0
        begin
          /*  Error en creacion de transaccion de servicio  */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103005
          return 1
        end

      end

      -- actualizo el numero de direcciones en la tabla de entes

      /*     select @w_num_direccion = count(*) 
             from cl_direccion 
            where di_ente = @w_num_ente*/

      update cl_ente
      set    en_direccion = @w_num_direccion
      where  en_ente = @w_num_ente

      -- actualizo el numero de telefonos en la tabla de direcciones

      /*     select  @w_num_telefono = (select max(te_secuencial)
             from cl_telefono 
            where te_ente = @w_num_ente )
      
           if @w_num_telefono is null
              select @w_num_telefono = 0*/

      update cl_direccion
      --        set di_telefono = @w_num_telefono
      set    di_telefono = @w_tm_secuencial
      where  di_ente = @w_num_ente

      select
        @w_archivo_ente = @i_archivo

      -- Finalizar una transaccion
      commit tran

      fetch cursor_ente_mig into @s_user,
                                 @s_sesn,
                                 @w_archivo,
                                 @w_secuencia,
                                 @w_ente,
                                 @w_nombre,
                                 @w_p_p_apellido,
                                 @w_p_s_apellido,
                                 @w_p_fecha_nac,
                                 @w_p_fecha_ing,
                                 @w_p_fecha_mod,
                                 @w_subtipo,
                                 @w_ced_ruc,
                                 @w_sigla,
                                 @w_actividad,
                                 @w_oficial,
                                 @w_nat_jur,
                                 @w_retencion,
                                 @w_oficina,
                                 @w_comentario,
                                 @w_departamento,
                                 @w_ciudad,
                                 @w_casilla,
                                 @w_telefono1,
                                 @w_telefono2,
                                 @w_origen,
                                 @w_p_sexo,
                                 @w_p_tipo_ced,
                                 @w_sector,
                                 @w_estado_emp,
                                 @w_tipo_soc,
                                 @w_en_pais,
                                 @w_p_pais_emi,
                                 @w_p_depa_emi,
                                 @w_p_depa_nac,
                                 @w_p_ciudad_nac,
                                 @w_p_lugar_doc,
                                 @w_direccion,
                                 @w_dm_descripcion,
                                 @w_dm_ciudad,
                                 @w_dm_tipo,
                                 @w_ntelefonos,
                                 @w_dm_sector,
                                 @w_dm_zona,
                                 @w_tm_secuencial,
                                 @w_tm_valor,
                                 @w_tm_tipo_telefono

    end
    close cursor_ente_mig
    deallocate cursor_ente_mig

    update cl_seqnos
    set    siguiente = @w_num_ente
    where  bdatos = 'cobis'
       and tabla  = 'cl_ente'

  --RMI25Abr00 Actualizacion del nombre largo para las busquedas
  /*    update cl_ente
         set en_nomlar = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre
       where p_p_apellido <> null
  
      update cl_ente
         set en_nomlar = en_nombre
       where p_p_apellido = null */

  end
  else
  begin
  /******* aqui se hace el codigo de actualizacion .............*/
    -- Crear un cursor para leer la tabla cargada desde diskette
    declare cursor_ente_migUp cursor for
      select
        em_user,
        em_sesn,
        em_archivo,
        em_secuencia,
        em_ente,
        em_nombre,
        em_p_p_apellido,
        em_p_s_apellido,
        em_p_fecha_nac,
        em_p_fecha_ing,
        em_p_fecha_mod,
        em_subtipo,
        em_ced_ruc,
        em_sigla,
        em_actividad,
        em_oficial,
        em_nat_jur,
        em_retencion,
        em_oficina,
        em_comentario,
        em_departamento,
        em_ciudad,
        em_casilla,
        em_telefono1,
        em_telefono2,
        em_origen,
        em_p_sexo,
        em_p_tipo_ced,
        em_sector,
        em_estado_emp,
        em_tipo_soc,
        em_en_pais,
        em_p_pais_emi,
        em_p_depa_emi,
        em_p_depa_nac,
        em_p_ciudad_nac,
        em_p_lugar_doc,
        em_direccion,
        em_direccion,
        dm_ciudad,
        dm_tipo,
        dm_telefono,
        dm_sector,
        dm_zona,
        tm_secuencial,
        tm_valor,
        tm_tipo_telefono
      from   cl_ente_mig
      where  em_user    = @s_user
         and em_sesn    = @s_sesn
         and em_archivo = @i_archivo

    open cursor_ente_migUp
    fetch cursor_ente_migUp into @s_user,
                                 @s_sesn,
                                 @i_archivo,
                                 @w_secuencia,
                                 @w_ente,
                                 @w_nombre,
                                 @w_p_p_apellido,
                                 @w_p_s_apellido,
                                 @w_p_fecha_nac,
                                 @w_p_fecha_ing,
                                 @w_p_fecha_mod,
                                 @w_subtipo,
                                 @w_ced_ruc,
                                 @w_sigla,
                                 @w_actividad,
                                 @w_oficial,
                                 @w_nat_jur,
                                 @w_retencion,
                                 @w_oficina,
                                 @w_comentario,
                                 @w_departamento,
                                 @w_ciudad,
                                 @w_casilla,
                                 @w_telefono1,
                                 @w_telefono2,
                                 @w_origen,
                                 @w_p_sexo,
                                 @w_p_tipo_ced,
                                 @w_sector,
                                 @w_estado_emp,
                                 @w_tipo_soc,
                                 @w_en_pais,
                                 @w_p_pais_emi,
                                 @w_p_depa_emi,
                                 @w_p_depa_nac,
                                 @w_p_ciudad_nac,
                                 @w_p_lugar_doc,
                                 @w_direccion,
                                 @w_dm_descripcion,
                                 @w_dm_ciudad,
                                 @w_dm_tipo,
                                 @w_ntelefonos,
                                 @w_dm_sector,
                                 @w_dm_zona,
                                 @w_tm_secuencial,
                                 @w_tm_valor,
                                 @w_tm_tipo_telefono

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
      begin tran

      select
        @w_num_ente = @w_num_ente + 1
      -- quitar espacios en blanco del nombre
      select
        @w_nombre = ltrim(rtrim(@w_nombre))
      select
        @w_nombrelargo = ''

      select
        @w_fecha = @s_date
      select
        @w_auxcom = convert(varchar(10), @w_comentario)

      select
        @w_ente = en_ente
      from   cl_ente
      where  en_ced_ruc  = @w_ced_ruc
         and en_tipo_ced = @w_p_tipo_ced

      if @w_subtipo = 'P'
      begin
        select
          @w_nombrelargo = @w_nombre + ' ' + @w_p_p_apellido + ' ' +
                           @w_p_s_apellido
        select
          @s_ssn = @s_ssn + 1
        exec @w_retorno = cobis..sp_persona_upd
          @s_ssn               = @s_ssn,
          @s_user              = @s_user,
          @s_term              = @s_term,
          @s_date              = @s_date,
          @s_ofi               = @s_ofi,
          @t_debug             = 'N',
          @t_file              = @t_file,
          @t_from              = @t_from,
          @t_trn               = 104,
          @i_operacion         = 'U',
          @i_comentario        = 'ACTUALIZACION MASIVA',
          @i_persona           = @w_ente,
          @i_nombre            = @w_nombre,
          @i_p_apellido        = @w_p_p_apellido,
          @i_s_apellido        = @w_p_s_apellido,
          @i_sexo              = @w_p_sexo,
          @i_fecha_nac         = @w_p_fecha_nac,
          @i_tipo_ced          = @w_p_tipo_ced,
          @i_cedula            = @w_ced_ruc,
          @i_pais              = @w_en_pais,
          @i_oficina           = @w_oficina,
          @i_oficial           = @w_oficial,
          @i_actividad         = @w_actividad,
          @i_sector            = @w_sector,
          @i_ciudad_nac        = @w_p_ciudad_nac,
          @i_lugar_doc         = @w_p_lugar_doc,
          @i_depa_nac          = @w_p_depa_nac,
          @i_pais_emi          = @w_p_pais_emi,
          @i_depa_emi          = @w_p_depa_emi,
          @i_retencion         = @w_retencion,
          @i_situacion_cliente = @w_estado_emp,
          @i_exc_sipla         = 'N',
          @i_exc_por2          = 'N',
          --        @i_tipo       = @w_tipo_soc,
          @i_tipo_vinculacion  = @w_origen,--@w_tipo_soc,
          @o_ente              = @o_ente
        if @w_retorno <> 0
        begin
          select
            @o_msj_error = 'No se Actualizo el ente',
            @o_producto_error = 2
          return 1
        end
      end

      if @w_subtipo = 'C'
      begin
        select
          @w_nombrelargo = @w_nombre

        exec @w_retorno = cobis..sp_compania_upd
          @s_ssn               = @s_ssn,
          @s_user              = @s_user,
          @s_term              = @s_term,
          @s_date              = @s_date,
          @s_ofi               = @s_ofi,
          @t_debug             = @t_debug,
          @t_file              = @t_file,
          @t_from              = @t_from,
          @t_trn               = 106,
          @i_operacion         = 'U',
          @i_comentario        = 'ACTUALIZACION MASIVA',
          @i_compania          = @w_ente,
          @i_nombre            = @w_nombre,
          @i_actividad         = @w_actividad,
          @i_ruc               = @w_ced_ruc,
          @i_pais              = @w_en_pais,
          @i_oficina           = @w_oficina,
          @i_oficial           = @w_oficial,
          @i_tipo_vinculacion  = @w_origen,
          @i_tipo_nit          = @w_p_tipo_ced,
          @i_sector            = @w_sector,
          @i_tipo_soc          = @w_tipo_soc,
          @i_lugar_doc         = @w_p_lugar_doc,
          @i_sigla             = @w_sigla,
          @i_filial            = @i_filial,
          @i_tipo              = @w_nat_jur,
          @i_rep_superban      = 'N',
          @i_exc_sipla         = 'N',
          @i_exc_por2          = 'N',
          @i_doc_validado      = 'N',
          @i_retencion         = @w_retencion,
          @i_situacion_cliente = @w_estado_emp

        if @w_retorno <> 0
        begin
          select
            @o_msj_error = 'No se Actualizo la compania',
            @o_producto_error = 2
          return 1
        end
      end

      /* Se comenta la Actualizacion de Telefonos y Direcciones a peticion de Banco ELA JUL/2001
      
             delete from cl_direccion 
             where di_ente = @w_ente
      
             delete from cl_telefono
             where te_ente = @w_ente
      
      
      --end /*if Actualizacion*/
      
      
      
      
      
      /*************direcciones ......................!!*/
      
            insert into cl_direccion(
                   di_ente, di_direccion, di_descripcion, di_parroquia,
                   di_ciudad, di_tipo, di_telefono, di_sector,
                   di_zona, di_oficina, di_fecha_registro, di_fecha_modificacion,
                   di_vigencia, di_verificado, di_funcionario, 
                   di_fecha_ver,di_provincia,di_principal)
            values (@w_ente,1,@w_dm_descripcion, @w_dm_parroquia,
                   @w_ciudad,@w_dm_tipo, @w_dm_telefono, @w_dm_sector, 
                   @w_dm_zona, 1, @w_fecha, @w_fecha,
                   'S', 'N', @s_user, null,@w_departamento,'S')
            if @@error <> 0 
            begin
               /* Error en insercion de registro */
                exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file, 
                   @t_from  = @w_sp_name,
                   @i_num   = 103007
                   return 1 
            end
                  /*  Transaccion de Servicio Registro */
                  insert into ts_direccion (secuencial, tipo_transaccion, clase, fecha,
                              usuario, terminal, srv, lsrv, 
                              ente, direccion, descripcion,
                              vigencia,
                              sector, zona, parroquia, ciudad, tipo,
                              oficina,verificado,barrio, provincia)
                             values  (@s_ssn, @t_trn, 'P', getdate(),
                                     @s_user, @s_term, @s_srv, @s_lsrv,
                                  @w_ente,1,@w_dm_descripcion, 
                                  'S',
                                  @w_dm_sector, @w_dm_zona, @w_dm_parroquia, @w_ciudad, @w_dm_tipo,
                                  1, 'N', null, @w_departamento)
      
                  if @@error <> 0
                  begin
                      /*  Error en creacion de transaccion de servicio  */
                      exec cobis..sp_cerror
                          @t_debug    = @t_debug,
                          @t_file     = @t_file,
                          @t_from     = @w_sp_name,
                          @i_num      = 103005
                      return 1
                  end                             
            else
          select @w_num_direccion = 1
      
      
      /*****  Inserta Apartados Aereos  *************/
      --if @w_casilla <> null and 
      
      if @w_casilla not in('1','0',null)
      begin
            insert into cl_direccion(
                   di_ente, di_direccion, di_descripcion, di_parroquia,
                   di_ciudad, di_tipo, di_telefono, di_sector,
                   di_zona, di_oficina, di_fecha_registro, di_fecha_modificacion,
                   di_vigencia, di_verificado, di_funcionario, 
                   di_fecha_ver,di_provincia,di_principal)
            values (@w_ente,2,@w_casilla, @w_dm_parroquia,
                   @w_ciudad,'001',@w_dm_telefono, @w_dm_sector, 
                   @w_dm_zona, 1, @w_fecha, @w_fecha,
                   'S', 'N', @s_user, null,@w_departamento,'N')
            if @@error <> 0 
            begin
               /* Error en insercion de registro */
                exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file, 
                   @t_from  = @w_sp_name,
                   @i_num   = 103007
                   return 1 
            end
                  /*  Transaccion de Servicio Registro */
                  insert into ts_direccion (secuencial, tipo_transaccion, clase, fecha,
                              usuario, terminal, srv, lsrv, 
                              ente, direccion, descripcion,
                              vigencia,
                              sector, zona, parroquia, ciudad, tipo,
                              oficina,verificado,barrio, provincia)
                             values  (@s_ssn, @t_trn, 'P', getdate(),
                                     @s_user, @s_term, @s_srv, @s_lsrv,
                                  @w_ente,2,@w_casilla, 
                                  'S',
                                  @w_dm_sector, @w_dm_zona, @w_dm_parroquia, @w_ciudad, '001',
                                  1, 'N', null, @w_departamento)
      
                  if @@error <> 0
                  begin
                      /*  Error en creacion de transaccion de servicio  */
                      exec cobis..sp_cerror
                          @t_debug    = @t_debug,
                          @t_file     = @t_file,
                          @t_from     = @w_sp_name,
                          @i_num      = 103005
                      return 1
                  end                    
      
            else
          select @w_num_direccion = @w_num_direccion + 1
      
      end
      
      
          --insercion de telefonos del ente
           if @w_telefono1 not in ('0','1')
            begin
            select @w_tm_secuencial = 1,
                   @w_dm_direccion = 1
        
          insert into cl_telefono(
                   te_ente, te_direccion, te_secuencial,
                   te_valor, te_tipo_telefono)
          values   (@w_ente,@w_dm_direccion,@w_tm_secuencial,
                   @w_telefono1,@w_tm_tipo_telefono)
            if @@error <> 0 
            begin
               /* Error en insercion de registro */
                exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file, 
                   @t_from  = @w_sp_name,
                   @i_num   = 103038
                   return 1 
            end
                  /*  Transaccion de Servicio Registro */
                  insert into ts_telefono (secuencial, tipo_transaccion, clase, fecha,
                               usuario, terminal, srv, lsrv, 
                               ente, direccion, telefono, valor, tipo)
                             values  (@s_ssn, @t_trn, 'P', getdate(),
                                     @s_user, @s_term, @s_srv, @s_lsrv,
                                  @w_ente,@w_dm_direccion,@w_tm_secuencial,@w_telefono1,@w_tm_tipo_telefono)
      
                  if @@error <> 0
                  begin
                      /*  Error en creacion de transaccion de servicio  */
                      exec cobis..sp_cerror
                          @t_debug= @t_debug,
                          @t_file    = @t_file,
                          @t_from    = @w_sp_name,
                          @i_num    = 103005
                      return 1
                  end                         
            end
       
            if @w_telefono2 not in ('1','0') 
            begin
            select @w_tm_secuencial = @w_tm_secuencial + 1
      
          insert into cl_telefono(
                   te_ente, te_direccion, te_secuencial,
                   te_valor, te_tipo_telefono)
          values   (@w_ente,@w_dm_direccion,@w_tm_secuencial,
                   @w_telefono2,@w_tm_tipo_telefono)
            if @@error <> 0 
            begin
               /* Error en insercion de registro */
                exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file, 
                   @t_from  = @w_sp_name,
                   @i_num   = 103038
                   return 1 
            end
                  /*  Transaccion de Servicio Registro */
                  insert into ts_telefono (secuencial, tipo_transaccion, clase, fecha,
                               usuario, terminal, srv, lsrv, 
                               ente, direccion, telefono, valor, tipo)
                             values  (@s_ssn, @t_trn, 'P', getdate(),
                                     @s_user, @s_term, @s_srv, @s_lsrv,
                                  @w_ente,@w_dm_direccion,@w_tm_secuencial,@w_telefono2,@w_tm_tipo_telefono)
      
                  if @@error <> 0
                  begin
                      /*  Error en creacion de transaccion de servicio  */
                      exec cobis..sp_cerror
                          @t_debug    = @t_debug,
                          @t_file     = @t_file,
                          @t_from     = @w_sp_name,
                          @i_num      = 103005
                      return 1
                  end                    
            
          end
      
        -- actualizo el numero de direcciones en la tabla de entes
      
           update cl_ente
              set en_direccion = @w_num_direccion                 
            where en_ente = @w_ente
      
           update cl_direccion
              set di_telefono = @w_tm_secuencial
           where di_ente = @w_ente 
      
      fIN COMENTARIO DIRECCIONES Y TELEFONOS */

      commit tran

      fetch cursor_ente_migUp into @s_user,
                                   @s_sesn,
                                   @w_archivo,
                                   @w_secuencia,
                                   @w_ente,
                                   @w_nombre,
                                   @w_p_p_apellido,
                                   @w_p_s_apellido,
                                   @w_p_fecha_nac,
                                   @w_p_fecha_ing,
                                   @w_p_fecha_mod,
                                   @w_subtipo,
                                   @w_ced_ruc,
                                   @w_sigla,
                                   @w_actividad,
                                   @w_oficial,
                                   @w_nat_jur,
                                   @w_retencion,
                                   @w_oficina,
                                   @w_comentario,
                                   @w_departamento,
                                   @w_ciudad,
                                   @w_casilla,
                                   @w_telefono1,
                                   @w_telefono2,
                                   @w_origen,
                                   @w_p_sexo,
                                   @w_p_tipo_ced,
                                   @w_sector,
                                   @w_estado_emp,
                                   @w_tipo_soc,
                                   @w_en_pais,
                                   @w_p_pais_emi,
                                   @w_p_depa_emi,
                                   @w_p_depa_nac,
                                   @w_p_ciudad_nac,
                                   @w_p_lugar_doc,
                                   @w_direccion,
                                   @w_dm_descripcion,
                                   @w_dm_ciudad,
                                   @w_dm_tipo,
                                   @w_ntelefonos,
                                   @w_dm_sector,
                                   @w_dm_zona,
                                   @w_tm_secuencial,
                                   @w_tm_valor,
                                   @w_tm_tipo_telefono

    end

    close cursor_ente_migUp
    deallocate cursor_ente_migUp

    /* Actualiza la banca    JAL */
    exec sp_actualiza_banca

  end

  return 0

go

