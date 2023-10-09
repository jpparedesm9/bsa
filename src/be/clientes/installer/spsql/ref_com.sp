/************************************************************************/
/*  Archivo:        ref_com.sp                                          */
/*  Stored procedure:   sp_ref_com                                      */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:       Carlos Rodriguez V.                             */
/*  Fecha de escritura:     03-May-1994                                 */
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
/*  Este programa procesa las transacciones del stored procedure        */
/*  Insercion de referencia comercial                                   */
/*  Actualizacion de referencia comercial                               */
/*  Borrado de referencia comercial                                     */
/*  Busqueda de referencia comercial general y especifica               */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  06-Abr-2010 R. Altamirano  Control de vigencia de datos del Ente    */
/*  05/May/2016 T. Baidal      Migracion a CEN                          */
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
           where  name = 'sp_ref_com')
    drop proc sp_ref_com
go

create proc sp_ref_com
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
  @i_ente               int = null,
  @i_referencia         tinyint = null,
  @i_institucion        descripcion = null,
  @i_fecha_ingr_en_inst datetime = null,
  @i_tipo_cifras        char(2) = null,
  @i_numero_cifras      tinyint = null,
  @i_calificacion       catalogo = null,
  @i_observacion        varchar(254) = null,
  @i_verificacion       char(1) = 'N',
  @i_monto              money = null,
  @i_nacional           char(1) = 'S',/* INNAC*/
  @i_sucursal           char(20) = null,/* INNAC*/
  @i_ciudad             int = null,
  @i_telefono           char(16) = null,/* INNAC*/
  @i_estado             catalogo = null,/* INNAC*/
  @i_fec_exp_ref        datetime = null,/*INFEEX*/
  @i_vinculo            catalogo = null,
  @i_Ciudad             catalogo = null,
  @i_Dpto               catalogo = null,
  @i_nit                varchar(20) = null,
  @i_resultado          catalogo = null
)
as
  declare
    @w_sp_name            varchar(32),
    @w_codigo             int,
    @w_return             int,
    @o_siguiente          tinyint,
    @w_institucion        descripcion,
    @w_fecha_ingr_en_inst datetime,
    @w_tipo_cifras        char(2),
    @w_numero_cifras      tinyint,
    @w_fecha_registro     datetime,
    @w_fecha_modificacion datetime,
    @w_fecha_ver          datetime,
    @w_verificacion       char(1),
    @w_calificacion       char(2),
    @w_vigencia           char(1),
    @w_observacion        varchar(254),
    @w_monto              money,
    @w_nacional           char(1),
    @w_sucursal           char(20),
    @w_ciudad             int,
    @w_telefono           char(16),
    @w_estado             catalogo,
    @w_fec_exp_ref        datetime,
    @w_fecha_nac          datetime,
    @w_tipo               char(1),
    @w_vinculo            char(1),
    @w_Ciudad             catalogo,
    @w_Dpto               catalogo,
    @w_nit                varchar(20),
    @w_resultado          catalogo,
    @v_fec_exp_ref        datetime,
    @v_institucion        descripcion,
    @v_fecha_ingr_en_inst datetime,
    @v_tipo_cifras        char(2),
    @v_numero_cifras      tinyint,
    @v_fecha_registro     datetime,
    @v_fecha_modificacion datetime,
    @v_fecha_ver          datetime,
    @v_verificacion       char(1),
    @v_calificacion       char(2),
    @v_vigencia           char(1),
    @v_observacion        varchar(254),
    @v_monto              money,
    @v_nacional           char(1),
    @v_sucursal           char(20),
    @v_ciudad             int,
    @v_telefono           char(16),
    @v_estado             catalogo,
    @v_vinculo            char(1),
    @v_Ciudad             catalogo,
    @v_Dpto               catalogo,
    @v_nit                varchar(20),
    @v_resultado          catalogo,
    @o_ente               int,
    @o_cedruc             numero,
    @o_ennombre           descripcion,
    @o_institucion        descripcion,
    @o_fecha_ingr_en_inst datetime,
    @o_tipo_cifras        char(2),
    @o_numero_cifras      tinyint,
    @o_fecha_registro     datetime,
    @o_fecha_modificacion datetime,
    @o_fecha_ver          datetime,
    @o_verificacion       char(1),
    @o_calificacion       char(2),
    @o_observacion        varchar(254),
    @o_vigencia           char(1),
    @o_monto              money,
    @o_nacional           char(1),
    @o_sucursal           char(20),
    @o_ciudad             int,
    @o_telefono           char(16),
    @o_estado             catalogo,
    @o_fec_exp_ref        datetime,
    @o_Ciudad             catalogo,
    @o_Dpto               catalogo,
    @o_nit                varchar(20)

  select
    @w_sp_name = 'sp_ref_com'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 1358
    begin
      /* Verificar que existe el ente */
      select
        @w_codigo = null
      from   cl_ente
      where  en_ente = @i_ente

      /* si no existe el ente, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101042
        /* 'No existe ente'*/
        return 1
      end

      /* verificar que exista el tipo de referencia (C: comercial) */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_rtipo',
        @i_operacion = 'E',
        @i_codigo    = 'C'

      /* si no existe el tipo, error */
      if @w_return <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101023
        /* 'No existe tipo de referencia comercial'*/
        return 1
      end

      /* verificar que exista el tipo de calificacion */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_vinculo',
        @i_operacion = 'E',
        @i_codigo    = @i_calificacion

      /* si no existe el tipo, error */
      if @w_return <> 0
         and @i_calificacion is not null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe tipo de calificacion '*/
        return 1
      end

      /*no se esta enviando de FrontEnd
          verificar que exista el tipo de cifras
          exec @w_return = cobis..sp_catalogo
           @t_debug   = @t_debug,
           @t_file    = @t_file,
           @t_from    = @w_sp_name,
           @i_tabla   = 'cl_tcifras',
           @i_operacion   = 'E',
           @i_codigo  = @i_tipo_cifras
      
          si no existe el tipo, error
         if @w_return <> 0
         begin
          exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 101142
               'No existe tipo de cifras'
          return 1
          end*/

      if @i_estado is not null
      begin
        /* verificar que exista el estado */
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_ereferencia',
          @i_operacion = 'E',
          @i_codigo    = @i_estado
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101179
          /* 'No existe tipo de estado '*/
          return @w_return
        end
      end

      if @i_ciudad is not null
      begin
        if @i_nacional = 'S'
        begin
          if not exists (select
                           *
                         from   cl_ciudad
                         where  ci_ciudad = @i_ciudad)
          begin
            /* verificar que exista la ciudad */
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101024
            /* 'No existe Ciudad '*/
            return @w_return
          end
        end
        else if @i_nacional = 'N'
        begin
          if not exists (select
                           1
                         from   cl_pais
                         where  pa_pais = @i_ciudad)
          begin
            /* verificar que exista el pais */
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101018
            /* 'No existe Pais ' */
            return @w_return
          end
        end
      end

      if @i_institucion is null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101143
        /* 'Falta nombre de la institucion '*/
        return 1
      end

      /* Verificar que la fecha de ingreso no sea menor que la fecha de
         nacimiento.  M. Silva.  27/03/1998.  Bco. del Estado  */

      select
        @w_fecha_nac = p_fecha_nac
      from   cl_ente
      where  en_ente = @i_ente

      if @w_fecha_nac >= @i_fecha_ingr_en_inst
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107089
        return 1
      end

      /* Verificar que la fecha de ingreso no sea menor que la fecha de
          nacimiento.  M. Silva.  27/03/1998.  Bco. del Estado  */

      select
        @w_fecha_nac = c_fecha_const,
        @w_tipo = en_subtipo
      from   cl_ente
      where  en_ente = @i_ente

      if (@w_fecha_nac >= @i_fecha_ingr_en_inst)
         and (@w_tipo = 'C')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107090
        return 1
      end

      /* Verificar que la fecha de expedicion no sea menor que la fecha de
         nacimiento.  M. Silva.  27/03/1998.  Bco. del Estado  */

      select
        @w_fecha_nac = p_fecha_nac
      from   cl_ente
      where  en_ente = @i_ente

      if @w_fecha_nac >= @i_fec_exp_ref
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107091
        return 1
      end

      /* Verificar que la fecha de ingreso no sea menor que la fecha de
          nacimiento.  M. Silva.  27/03/1998.  Bco. del Estado  */

      select
        @w_fecha_nac = c_fecha_const,
        @w_tipo = en_subtipo
      from   cl_ente
      where  en_ente = @i_ente

      if (@w_fecha_nac >= @i_fec_exp_ref)
         and (@w_tipo = 'C')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107092
        return 1
      end

      begin tran

      /* aumentar en uno el numero de referencias del ente */
      update cl_ente
      set    en_referencia = isnull(en_referencia, 0) + 1
      where  en_ente = @i_ente

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103044
        /* 'Error en creacion de referencia '*/
        return 1
      end

      /* encontrar el nuevo secuencial para la referencia */
      select
        @o_siguiente = en_referencia
      from   cl_ente
      where  en_ente = @i_ente

      /* insertar la nueva referencia */
      insert into cl_comercial
                  (ente,referencia,tipo,tipo_cifras,numero_cifras,
                   fecha_registro,fecha_modificacion,calificacion,verificacion,
                   vigencia,
                   observacion,institucion,fecha_ingr_en_inst,monto,nacional,
                   /* INNAC */
                   sucursal,/* INNAC */ciudad,/* INNAC */telefono,/* INNAC */
                   estado,
                   /* INNAC */fec_exp_ref,
                   funcionario,nit,dpto,ciudadeco)
      values      (@i_ente,@o_siguiente,'C',@i_tipo_cifras,@i_numero_cifras,
                   getdate(),getdate(),@i_calificacion,'N','S',
                   @i_observacion,@i_institucion,@i_fecha_ingr_en_inst,@i_monto,
                   @i_nacional,/* INNAC */
                   @i_sucursal,/* INNAC */@i_ciudad,/* INNAC */@i_telefono,
                   /* INNAC */
                   @i_estado,/* INNAC */@i_fec_exp_ref,
                   @s_user,@i_nit,@i_Dpto,@i_Ciudad )
      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103072
        /* 'Error en creacion de referencia comercial'*/
        return 1
      end

      /* Transaccion servicios - cl_referencia */
      insert into ts_referencia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,referencia,
                   tipo,tipo_cifras,numero_cifras,calificacion,verificacion,
                   vigencia,observacion,fecha_registro,institucion,
                   fecha_ingr_en_inst,
                   monto,fec_exp_ref,nacional,sucursal,ciudad,
                   telefono,estado)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@o_siguiente,
                   'C',@i_tipo_cifras,@i_numero_cifras,@i_calificacion,'N',
                   'S',@i_observacion,getdate(),@i_institucion,
                   @i_fecha_ingr_en_inst
                   ,
                   @i_monto,@i_fec_exp_ref,@i_nacional,@i_sucursal,
                   @i_ciudad,
                   @i_telefono,@i_estado)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /*'Error en creacion de transaccion de servicios'*/
        return 1
      end
      commit tran

      /* retornar el nuevo secuencial para la referencia */
      select
        @o_siguiente

      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

  /** Update **/
  if @i_operacion = 'U'
  begin
    if @t_trn = 1359
    begin
      /* verificar que exista el tipo de referencia */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_rtipo',
        @i_operacion = 'E',
        @i_codigo    = 'C'

      if @w_return <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe tipo de referencia '*/
        return 1
      end

      /* verificar que exista el tipo de calificacion */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_vinculo',--'cl_posicion',
        @i_operacion = 'E',
        @i_codigo    = @i_calificacion

      /* si no existe el tipo, error */
      if @w_return <> 0
         and @i_calificacion is not null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101141
        /* 'No existe tipo de calificacion '*/
        return 1
      end

    /*no se esta enviando el dato de frontend*/
      /* verificar que exista el tipo de cifras
        exec @w_return = cobis..sp_catalogo
         @t_debug   = @t_debug,
         @t_file    = @t_file,
         @t_from    = @w_sp_name,
         @i_tabla   = 'cl_tcifras',
         @i_operacion   = 'E',
         @i_codigo  = @i_tipo_cifras
      
             si no existe el tipo, error
       if @w_return <> 0
       begin
        exec sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 101142
              'No existe tipo de cifras'
        return 1
        end*/

      if @i_estado is not null
      begin
        /* verificar que exista el estado */
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_ereferencia',
          @i_operacion = 'E',
          @i_codigo    = @i_estado
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101179
          /* 'No existe tipo de estado '*/
          return @w_return
        end
      end

      if @i_ciudad is not null
      begin
        if @i_nacional = 'S'
        begin
          if not exists (select
                           *
                         from   cl_ciudad
                         where  ci_ciudad = @i_ciudad)
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101024
            /* 'No existe Ciudad '*/
            return @w_return
          end
        end
        else
        begin
          if not exists (select
                           1
                         from   cl_pais
                         where  pa_pais = @i_ciudad)
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101024
            /* 'No existe Ciudad '*/
            return @w_return
          end
        end
      end

      if @i_institucion is null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101143
        /* 'Falta nombre de la institucion '*/
        return 1
      end

      /* Control de campos a actualizar */
      select
        @w_institucion = institucion,
        @w_fecha_ingr_en_inst = fecha_ingr_en_inst,
        @w_tipo_cifras = tipo_cifras,
        @w_numero_cifras = numero_cifras,
        @w_calificacion = calificacion,
        @w_observacion = observacion,
        @w_verificacion = verificacion,
        @w_fecha_ver = fecha_ver,
        @w_fecha_modificacion = fecha_modificacion,
        @w_vigencia = vigencia,
        @w_monto = monto,
        @w_nacional = nacional,
        @w_sucursal = sucursal,
        @w_ciudad = ciudad,
        @w_telefono = telefono,
        @w_estado = estado,
        @w_fec_exp_ref = fec_exp_ref,
        @w_Ciudad = ciudadeco,
        @w_Dpto = dpto,
        @w_nit = nit,
        @w_resultado = resul_verif
      from   cl_comercial
      where  ente       = @i_ente
         and referencia = @i_referencia

      /* si no existe dato, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105046
        /* 'No existe referencia '*/
        return 1
      end

      /* Verificar que la fecha de ingreso no sea menor que la fecha de
         nacimiento.  M. Silva.  27/03/1998.  Bco. del Estado  */

      select
        @w_fecha_nac = p_fecha_nac
      from   cl_ente
      where  en_ente = @i_ente

      if @w_fecha_nac >= @i_fecha_ingr_en_inst
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107089
        return 1
      end

      /* Verificar que la fecha de ingreso no sea menor que la fecha de
          nacimiento.  M. Silva.  27/03/1998.  Bco. del Estado  */

      select
        @w_fecha_nac = c_fecha_const,
        @w_tipo = en_subtipo
      from   cl_ente
      where  en_ente = @i_ente

      if (@w_fecha_nac >= @i_fecha_ingr_en_inst)
         and (@w_tipo = 'C')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107090
        return 1
      end

      /* Verificar que la fecha de apertura no sea menor que la fecha de
         nacimiento.  M. Silva.  27/03/1998.  Bco. del Estado  */

      select
        @w_fecha_nac = p_fecha_nac
      from   cl_ente
      where  en_ente = @i_ente

      if @w_fecha_nac >= @i_fec_exp_ref
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107091
        return 1
      end

      /* Verificar que la fecha de ingreso no sea menor que la fecha de
          nacimiento.  M. Silva.  27/03/1998.  Bco. del Estado  */

      select
        @w_fecha_nac = c_fecha_const,
        @w_tipo = en_subtipo
      from   cl_ente
      where  en_ente = @i_ente

      if (@w_fecha_nac >= @i_fec_exp_ref)
         and (@w_tipo = 'C')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107092
        return 1
      end

      select
        @v_institucion = @w_institucion,
        @v_fecha_ingr_en_inst = @w_fecha_ingr_en_inst,
        @v_tipo_cifras = @w_tipo_cifras,
        @v_numero_cifras = @w_numero_cifras,
        @v_calificacion = @w_calificacion,
        @v_observacion = @w_observacion,
        @v_verificacion = @w_verificacion,
        @v_fecha_ver = @w_fecha_ver,
        @v_fecha_modificacion = @w_fecha_modificacion,
        @v_vigencia = @w_vigencia,
        @v_monto = @w_monto,
        @v_nacional = @w_nacional,
        @v_sucursal = @w_sucursal,
        @v_ciudad = @w_ciudad,
        @v_telefono = @w_telefono,
        @v_estado = @w_estado,
        @v_fec_exp_ref = @w_fec_exp_ref,
        @v_Ciudad = @w_Ciudad,
        @v_Dpto = @w_Dpto,
        @v_nit = @w_nit,
        @v_resultado = @w_resultado

      /************************ INFEEX ******************/

      if @w_fec_exp_ref = @i_fec_exp_ref
        select
          @w_fec_exp_ref = null,
          @v_fec_exp_ref = null
      else
        select
          @w_fec_exp_ref = @i_fec_exp_ref
      /************************ INNAC ******************/

      if @w_nacional = @i_nacional
        select
          @w_nacional = null,
          @v_nacional = null
      else
        select
          @w_nacional = @i_nacional

      if @w_sucursal = @i_sucursal
        select
          @w_sucursal = null,
          @v_sucursal = null
      else
        select
          @w_sucursal = @i_sucursal

      if @w_ciudad = @i_ciudad
        select
          @w_ciudad = null,
          @v_ciudad = null
      else
        select
          @w_ciudad = @i_ciudad

      if @w_telefono = @i_telefono
        select
          @w_telefono = null,
          @v_telefono = null
      else
        select
          @w_telefono = @i_telefono

      if @w_estado = @i_estado
        select
          @w_estado = null,
          @v_estado = null
      else
        select
          @w_estado = @i_estado
      /*************************************************/
      if @w_institucion = @i_institucion
        select
          @w_institucion = null,
          @v_institucion = null
      else
        select
          @w_institucion = @i_institucion

      if @w_fecha_ingr_en_inst = @i_fecha_ingr_en_inst
        select
          @w_fecha_ingr_en_inst = null,
          @v_fecha_ingr_en_inst = null
      else
        select
          @w_fecha_ingr_en_inst = @i_fecha_ingr_en_inst

      if @w_tipo_cifras = @i_tipo_cifras
        select
          @w_tipo_cifras = null,
          @v_tipo_cifras = null
      else
        select
          @w_tipo_cifras = @i_tipo_cifras

      if @w_numero_cifras = @i_numero_cifras
        select
          @w_numero_cifras = null,
          @v_numero_cifras = null
      else
        select
          @w_numero_cifras = @i_numero_cifras

      if @w_calificacion = @i_calificacion
        select
          @w_calificacion = null,
          @v_calificacion = null
      else
        select
          @w_calificacion = @i_calificacion

      if @w_observacion = @i_observacion
        select
          @w_observacion = null,
          @v_observacion = null
      else
        select
          @w_observacion = @i_observacion

      if @w_verificacion = @i_verificacion
        select
          @w_verificacion = null,
          @v_verificacion = null
      else
      begin
        select
          @w_verificacion = @i_verificacion
        if @i_verificacion = 'S'
          select
            @w_fecha_ver = getdate()
      end

      if @w_Ciudad = @i_Ciudad
        select
          @w_Ciudad = null,
          @v_Ciudad = null
      else
        select
          @w_Ciudad = @i_Ciudad

      if @w_Dpto = @i_Ciudad
        select
          @w_Dpto = null,
          @v_Dpto = null
      else
        select
          @w_Dpto = @i_Dpto

      if @w_nit = @i_nit
        select
          @w_nit = null,
          @v_nit = null
      else
        select
          @w_nit = @i_nit

      if @w_resultado = @i_resultado
        select
          @w_resultado = null,
          @v_resultado = null
      else
        select
          @w_resultado = @i_resultado

      select
        @w_vigencia = null,
        @v_vigencia = null --ream 06.abr.2010 control vigencia de datos del ente

      begin tran
      /* modificar los datos actuales */
      update cl_comercial
      set    institucion = @i_institucion,
             tipo_cifras = @i_tipo_cifras,
             numero_cifras = @i_numero_cifras,
             calificacion = @i_calificacion,
             verificacion = 'N',
             fecha_ver = @w_fecha_ver,
             fecha_modificacion = getdate(),
             vigencia = isnull(@w_vigencia,
                               vigencia),
             --ream 06.abr.2010 control vigencia de datos del ente
             observacion = @i_observacion,
             fecha_ingr_en_inst = @i_fecha_ingr_en_inst,
             monto = @i_monto,
             nacional = @i_nacional,
             sucursal = @i_sucursal,
             ciudad = @i_ciudad,
             telefono = @i_telefono,
             estado = @i_estado,
             fec_exp_ref = @i_fec_exp_ref,
             funcionario = @s_user,
             nit = @i_nit,
             dpto = @i_Dpto,
             ciudadeco = @i_Ciudad,
             resul_verif = @i_resultado
      where  ente       = @i_ente
         and referencia = @i_referencia
      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105067
        /* 'Error en actualizacion de referencia comercial'*/
        return 1
      end

      if @i_verificacion = 'S'
      begin
        update cl_comercial
        set    verificacion = @i_verificacion,
               funcionario = @s_user
        where  ente       = @i_ente
           and referencia = @i_referencia
        /* si no se puede modificar, error */
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105067
          /* 'Error en actualizacion de referencia comercial'*/
          return 1
        end
      end

      /* Transaccion servicios - cl_comercial */

      insert into ts_referencia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,referencia,
                   tipo,tipo_cifras,numero_cifras,calificacion,verificacion,
                   vigencia,observacion,fecha_modificacion,institucion,fecha_ver
                   ,
                   fecha_ingr_en_inst,monto,fec_exp_ref,
                   nacional,sucursal,
                   ciudad,telefono,estado)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_referencia,
                   'C',@v_tipo_cifras,@v_numero_cifras,@v_calificacion,
                   @v_verificacion
                   ,
                   @v_vigencia,@v_observacion,@v_fecha_modificacion,
                   @v_institucion,@v_fecha_ver,
                   @v_fecha_ingr_en_inst,@v_monto,@v_fec_exp_ref,@v_nacional,
                   @v_sucursal,
                   @v_ciudad,@v_telefono,@v_estado)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
        return 1
      end

      /* Transaccion servicios - cl_comercial */
      insert into ts_referencia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,referencia,
                   tipo,tipo_cifras,numero_cifras,calificacion,verificacion,
                   vigencia,observacion,institucion,fecha_ver,fecha_ingr_en_inst
                   ,
                   monto,fec_exp_ref,nacional,sucursal,
                   ciudad,
                   telefono,estado)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_referencia,
                   'C',@w_tipo_cifras,@w_numero_cifras,@w_calificacion,
                   @w_verificacion
                   ,
                   @w_vigencia,@w_observacion,
                   --ream 06.abr.2010 control vigencia de datos del ente
                   @w_institucion,@w_fecha_ver,@w_fecha_ingr_en_inst,
                   @w_monto,@w_fec_exp_ref,@w_nacional,@w_sucursal,@w_ciudad,
                   @w_telefono,@w_estado)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
        return 1
      end

      commit tran
      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

  /** Delete **/
  if @i_operacion = 'D'
  begin
    if @t_trn = 1360
    begin
      /* Captura de campos para transaccion de servicios */
      select
        @w_institucion = institucion,
        @w_fecha_ingr_en_inst = fecha_ingr_en_inst,
        @w_tipo_cifras = tipo_cifras,
        @w_numero_cifras = numero_cifras,
        @w_calificacion = calificacion,
        @w_observacion = observacion,
        @w_verificacion = verificacion,
        @w_fecha_registro = fecha_registro,
        @w_fecha_ver = fecha_ver,
        @w_fecha_modificacion = fecha_modificacion,
        @w_vigencia = vigencia,
        @w_monto = monto,
        @w_nacional = nacional,
        @w_sucursal = sucursal,
        @w_ciudad = ciudad,
        @w_telefono = telefono,
        @w_estado = estado,
        @w_fec_exp_ref = fec_exp_ref,
        @w_Ciudad = ciudadeco,
        @w_Dpto = dpto,
        @w_nit = nit
      from   cl_comercial
      where  ente       = @i_ente
         and referencia = @i_referencia

      /* si no existe referencia comercial, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No dato solicitado' */
        return 1
      end

      begin tran
      /* reducir en uno las referencias del ente */
      update cl_ente
      set    en_referencia = en_referencia - 1
      where  en_ente = @i_ente

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107044
        /* 'Error en disminucion de referencia '*/
        return 1
      end

      /* borrar la referencia */
      delete from cl_comercial
      where  ente       = @i_ente
         and referencia = @i_referencia

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107044
        /* 'Error en eliminacion de referencia '*/
        return 1
      end

      /* modificar en uno la secuencia de referencias */
      update cl_referencia
      set    re_referencia = re_referencia - 1
      where  re_ente       = @i_ente
         and re_referencia > @i_referencia

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107044
        /* 'Error en eliminacion de referencia '*/
        return 1
      end

      /* Transaccion servicios - cl_referencia */
      insert into ts_referencia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,referencia,
                   tipo,tipo_cifras,numero_cifras,calificacion,verificacion,
                   vigencia,observacion,fecha_registro,institucion,fecha_ver,
                   fecha_ingr_en_inst,fecha_modificacion,monto,fec_exp_ref,
                   nacional,
                   sucursal,ciudad,telefono,estado)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_referencia,
                   'C',@w_tipo_cifras,@w_numero_cifras,@w_calificacion,
                   @w_verificacion
                   ,
                   @w_vigencia,@w_observacion,@w_fecha_registro,
                   @w_institucion,@w_fecha_ver,
                   @w_fecha_ingr_en_inst,@w_fecha_modificacion,@w_monto,
                   @w_fec_exp_ref
                   ,@w_nacional,
                   @w_sucursal,@w_ciudad,@w_telefono,@w_estado)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
        return 1
      end
      commit tran
      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

go

