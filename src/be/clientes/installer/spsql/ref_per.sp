/************************************************************************/
/*  Archivo:            refper.sp                                       */
/*  Stored procedure:   sp_refpersonal                                  */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 06-Nov-1992                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                          PROPOSITO                                   */
/*  Este programa procesa las transacciones del stored procedure        */
/*  Insercion de referencia personal                                    */
/*  Actualizacion de referencia personal                                */
/*  Borrado de referencia personal                                      */
/*      Query general y especifico e referencias personales             */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR               RAZON                               */
/*  06/Nov/92   M. Davila     Emision Inicial                           */
/*  06/Abr/2010 R.Altamirano  Control vigencia de datos del Ente        */
/*  05/May/2016 T. Baidal     Migracion a CEN                           */
/*  25/Abr/2016 M. Custode    Aumento de campos en la tabla             */
/*  04/Jun/2016 P. Ortiz      Aumento de email a la tabla y correccionSP*/
/*  17/Ago/2016 P. Ortiz      Actualización a Clientes                  */
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
           where  name = 'sp_refpersonal')
    drop proc sp_refpersonal
go

create proc sp_refpersonal
(
  @s_ssn                int         = null,
  @s_user               login       = null,
  @s_term               varchar(30) = null,
  @s_date               datetime    = null,
  @s_srv                varchar(30) = null,
  @s_lsrv               varchar(30) = null,
  @s_ofi                smallint    = null,
  @t_debug              char(1)     = 'N',
  @t_file               varchar(10) = null,
  @t_from               varchar(32) = null,
  @t_trn                smallint    = null,
  @t_show_version       bit         = 0,
  @i_operacion          char(1),
  @i_ente               int         = null,
  @i_referencia         tinyint     = null,
  @i_nombre             varchar(60) = null,
  @i_p_apellido         varchar(32) = null,
  @i_s_apellido         varchar(20) = null,
  @i_direccion          direccion   = null,
  @i_telefono_d         char(12)    = null,
  @i_telefono_e         char(12)    = null,
  @i_telefono_o         char(12)    = null,
  @i_parentesco         catalogo    = null,
  @i_verificacion       char(1)     = null,
  @i_descripcion        varchar(64) = null,
  @i_fecha_ver          datetime    = null,
  @i_formato            tinyint     = 101,
  @i_departamento       varchar(10) = null,
  @i_ciudad             varchar(10) = null,
  @i_barrio             varchar(10) = null,
  @i_resultado          catalogo    = null,
  @i_calle              varchar(80) = null,
  @i_nro                int         = null,
  @i_colonia            varchar(10) = null,
  @i_localidad          varchar(10) = null,
  @i_municipio          varchar(10) = null,
  @i_estado             varchar(10) = null,
  @i_codpostal          varchar(30) = null,
  @i_pais               varchar(10) = null,
  @i_tiempo_conocido    int         = null,
  @o_siguiente          tinyint     = null  OUTPUT,
  @i_direccion_e        varchar(40) = null
)
as
  declare
    @w_sp_name            varchar(32),
    @w_codigo             int,
    @w_return             int,
    @w_nombre             varchar(20),
    @w_p_apellido         varchar(20),
    @w_s_apellido         varchar(20),
    @w_direccion          direccion,
    @w_telefono_d         char(12),
    @w_telefono_e         char(12),
    @w_telefono_o         char(12),
    @w_parentesco         catalogo,
    @w_vigencia           char(1),
    @w_verificacion       char(1),
    @w_descripcion        varchar(64),
    @w_tra                varchar(10),
    @w_tva                varchar(10),
    @w_tva_ente           varchar(10),
    @w_departamento       varchar(10),
    @w_ciudad             varchar(10),
    @w_barrio             varchar(10),
    @w_resultado          catalogo,
    @w_calle              varchar(80),
    @w_nro                int,
    @w_colonia            varchar(10),
    @w_localidad          varchar(10),
    @w_municipio          varchar(10),
    @w_estado             varchar(10),
    @w_codpostal          varchar(30),
    @w_pais               varchar(10),
    @w_tiempo_conocido    int,
    @v_nombre             varchar(60),
    @v_p_apellido         varchar(60),
    @v_s_apellido         varchar(20),
    @v_direccion          direccion,
    @v_telefono_d         char(12),
    @v_telefono_e         char(12),
    @v_telefono_o         char(12),
    @v_parentesco         catalogo,
    @v_vigencia           char(1),
    @v_verificacion       char(1),
    @v_descripcion        varchar(64),
    @v_departamento       varchar(10),
    @v_ciudad             varchar(10),
    @v_barrio             varchar(10),
    @v_resultado          catalogo,
    @v_calle              varchar(80),
    @v_nro                int,
    @v_colonia            varchar(10),
    @v_localidad          varchar(10),
    @v_municipio          varchar(10),
    @v_estado             varchar(10),
    @v_codpostal          varchar(30),
    @v_pais               varchar(10),
    @v_tiempo_conocido    int,
    @o_ente               int,
    @o_ennombre        descripcion,
    @o_cedula             numero,
    @o_referencia         tinyint,
    @o_ref_nombre         varchar(60),
    @o_ref_p_apellido     varchar(60),
    @o_ref_s_apellido     varchar(20),
    @o_direccion          direccion,
    @o_telefono_d         char(12),
    @o_telefono_e         char(12),
    @o_telefono_o         char(12),
    @o_parentesco         catalogo,
    @o_parnombre          descripcion,
    @o_fecha_registro     datetime,
    @o_fecha_modificacion datetime,
    @o_vigencia           char(1),
    @o_verificacion       char(1),
    @o_funcionario        login,
    @o_descripcion        varchar(64),
    @o_fecha_ver          datetime,
    @o_departamento       varchar(10),
    @o_ciudad             varchar(10),
    @o_barrio             varchar(10),
    @o_parTV              varchar(10),
    @o_tipov              varchar(10),
    @o_vivienda           tinyint,
    @o_calle              varchar(80),
    @o_nro                int,
    @o_colonia            varchar(10),
    @o_localidad          varchar(10),
    @o_municipio          varchar(10),
    @o_estado             varchar(10),
    @o_codpostal          varchar(30),
    @o_pais               varchar(10),
    @o_tiempo_conocido    int,
    @w_direccion_e        varchar(30),
    @v_direccion_e        varchar(30),
    @o_direccion_e        varchar(40)

  select
    @w_sp_name = 'sp_refpersonal'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 177
    begin
      /* Verificar que exista el ente */
      select
        @w_codigo = null
      from   cl_ente
      where  en_ente = @i_ente

      /* si no existe, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101043
        /* 'No existe persona'*/
        return 1
      end

      /* verificar que exista el tipo de referencia */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_parentesco',
        @i_operacion = 'E',
        @i_codigo    = @i_parentesco

      /* si no existe tipo de referencia, error */
      if @w_return <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101044
        /* 'No existe parentesco'*/
        return 1
      end

      begin tran

      /* aumentar en uno el numero de referencias personales del ente */
      update cl_persona
      set    personal = isnull(personal, 0) + 1
      where  persona = @i_ente

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103048
        /* 'Error en incremento de referencia personal'*/
        return 1
      end

      /* seleccionar el nuevo secuencial para la referencia personal */
      select
        @o_siguiente = personal
      from   cl_persona
      where  persona = @i_ente

      /* Insercion cl_ref_personal */
      insert into cl_ref_personal
      (rp_persona,      rp_referencia,      rp_nombre,          rp_p_apellido,
       rp_s_apellido,   rp_direccion,       rp_telefono_d,      rp_telefono_e,
       rp_telefono_o,   rp_parentesco,      rp_fecha_registro,  rp_fecha_modificacion,
       rp_vigencia,     rp_verificacion,    rp_descripcion,     rp_funcionario,
       rp_departamento, rp_ciudad,          rp_barrio,          rp_calle,
       rp_nro,          rp_colonia,         rp_localidad,       rp_municipio,
       rp_estado,       rp_codpostal,       rp_pais,            rp_tiempo_conocido,
       rp_direccion_e)
      values     
      (@i_ente,         @o_siguiente,       @i_nombre,          @i_p_apellido,
       @i_s_apellido,   @i_direccion,       @i_telefono_d,      @i_telefono_e,
       @i_telefono_o,   @i_parentesco,      getdate(),          getdate(),
       'S',             'N',                @i_descripcion,     @s_user,
       @i_departamento, @i_ciudad,          @i_barrio,          @i_calle,
       @i_nro,          @i_colonia,         @i_localidad,       @i_municipio,
       @i_estado,       @i_codpostal,       @i_pais,            @i_tiempo_conocido,
       @i_direccion_e)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103048
        /* 'Error en creacion de referencia personal'*/
        return 1
      end

      /* Transaccion servicio - cl_ref_personal */
      insert into ts_ref_personal
      (secuencial,      tipo_transaccion,   clase,              fecha,
       usuario,         terminal,           srv,                lsrv,
       persona,         referencia,         nombre,             p_apellido,
       s_apellido,      direccion,          telefono_d,         telefono_e,
       telefono_o,      parentesco,         vigencia,           verificacion,
       descripcion,     departamento,       ciudad,             barrio,
       calle,           numero,             colonia,            localidad,
       municipio,       estado,             codpostal,          pais,
       tiempo,          correo)
      values
      (@s_ssn,          @t_trn,             'N',                getdate(),
       @s_user,         @s_term,            @s_srv,             @s_lsrv,
       @i_ente,         @o_siguiente,       @i_nombre,          @i_p_apellido,
       @i_s_apellido,   @i_direccion,       @i_telefono_d,      @i_telefono_e,
       @i_telefono_o,   @i_parentesco,      'S',                'N',
       @i_descripcion,  @i_departamento,    @i_ciudad,          @i_barrio,
       @i_calle,        @i_nro,             @i_colonia,         @i_localidad,
       @i_municipio,    @i_estado,          @i_codpostal,       @i_pais,
       @i_tiempo_conocido,   @i_direccion_e)

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
		
      -- Actualizacion Automatica de Prospecto a Cliente
		exec cobis..sp_seccion_validar
			@i_ente			= @i_ente,
			@i_operacion 	= 'V',
			@i_seccion 		= '4', --4 es Referencias Personales
			@i_completado 	= 'S'
		
      /* retornar el nuevo secuencial para la referencia personal */
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
    if @t_trn = 178
        or @t_trn = 1350
    begin
      /* verificar que exista el tipo de referencia */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_parentesco',
        @i_operacion = 'E',
        @i_codigo    = @i_parentesco

      /* si no existe tipo de referencia, error */
      if @w_return <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101044
        /* 'No existe parentesco'*/
        return 1
      end

      /* Valores para transaccion de servicios */
      select
        @w_nombre           = rp_nombre,
        @w_p_apellido       = rp_p_apellido,
        @w_s_apellido       = rp_s_apellido,
        @w_direccion        = rp_direccion,
        @w_telefono_d       = rp_telefono_d,
        @w_telefono_e       = rp_telefono_e,
        @w_telefono_o       = rp_telefono_o,
        @w_parentesco       = rp_parentesco,
        @w_vigencia         = rp_vigencia,
        @w_descripcion      = rp_descripcion,
        @w_verificacion     = rp_verificacion,
        @w_departamento     = rp_departamento,
        @w_ciudad           = rp_ciudad,
        @w_barrio           = rp_barrio,
        @w_resultado        = rp_obs_verificado,
        @w_calle            = rp_calle,
        @w_nro              = rp_nro,
        @w_colonia          = rp_colonia,
        @w_localidad        = rp_localidad,
        @w_municipio        = rp_municipio,
        @w_estado           = rp_estado,
        @w_codpostal        = rp_codpostal,
        @w_pais             = rp_pais,
        @w_tiempo_conocido  = rp_tiempo_conocido,
        @w_direccion_e      = rp_direccion_e
      from   cl_ref_personal
      where  rp_persona    = @i_ente
         and rp_referencia = @i_referencia

      /* si no existe referencia personal, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end

      select
        @v_nombre           = @w_nombre,
        @v_p_apellido       = @w_p_apellido,
        @v_s_apellido       = @w_s_apellido,
        @v_direccion        = @w_direccion,
        @v_telefono_d       = @w_telefono_d,
        @v_telefono_e       = @w_telefono_e,
        @v_telefono_o       = @w_telefono_o,
        @v_parentesco       = @w_parentesco,
        @v_vigencia         = @w_vigencia,
        @v_descripcion      = @w_descripcion,
        @v_verificacion     = @w_verificacion,
        @v_departamento     = @w_departamento,
        @v_ciudad           = @w_ciudad,
        @v_barrio           = @w_barrio,
        @v_resultado        = @w_resultado,
        @v_calle            = @w_calle,
        @v_nro              = @w_nro,
        @v_colonia          = @w_colonia,
        @v_localidad        = @w_localidad,
        @v_municipio        = @w_municipio,
        @v_estado           = @w_estado,
        @v_codpostal        = @w_codpostal,
        @v_pais             = @w_pais,
        @v_tiempo_conocido  = @w_tiempo_conocido,
        @v_direccion_e      = @w_direccion_e
        
      if @w_nombre = @i_nombre
        select
          @w_nombre = null,
          @v_nombre = null
      else
        select
          @w_nombre = @i_nombre

      if @w_p_apellido = @i_p_apellido
        select
          @w_p_apellido = null,
          @v_p_apellido = null
      else
        select
          @w_p_apellido = @i_p_apellido

      if @w_s_apellido = @i_s_apellido
        select
          @w_s_apellido = null,
          @v_s_apellido = null
      else
        select
          @w_s_apellido = @i_s_apellido

      if @w_verificacion = @i_verificacion
        select
          @w_verificacion = null,
          @v_verificacion = null
      else
        select
          @w_verificacion = @i_verificacion

      if @w_direccion = @i_direccion
        select
          @w_direccion = null,
          @v_direccion = null
      else
        select
          @w_direccion = @i_direccion

      if @w_telefono_d = @i_telefono_d
        select
          @w_telefono_d = null,
          @v_telefono_d = null
      else
        select
          @w_telefono_d = @i_telefono_d

      if @w_telefono_e = @i_telefono_e
        select
          @w_telefono_e = null,
          @v_telefono_e = null
      else
        select
          @w_telefono_e = @i_telefono_e

      if @w_telefono_o = @i_telefono_o
        select
          @w_telefono_o = null,
          @v_telefono_o = null
      else
        select
          @w_telefono_o = @i_telefono_o

      if @w_parentesco = @i_parentesco
        select
          @w_parentesco = null,
          @v_parentesco = null
      else
        select
          @w_parentesco = @i_parentesco

      if @w_descripcion = @i_descripcion
        select
          @w_descripcion = null,
          @v_descripcion = null
      else
        select
          @w_descripcion = @i_descripcion

      if @w_departamento = @i_departamento
        select
          @w_departamento = null,
          @v_departamento = null
      else
        select
          @w_departamento = @i_departamento

      if @w_ciudad = @i_ciudad
        select
          @w_ciudad = null,
          @v_ciudad = null
      else
        select
          @w_ciudad = @i_ciudad

      if @w_barrio = @i_barrio
        select
          @w_barrio = null,
          @v_barrio = null
      else
        select
          @w_barrio = @i_barrio

      select
        @w_vigencia = null,
        @v_vigencia = null --ream 06.abr.2010 control vigencia de datos del ente

      if @w_resultado = @i_resultado
        select
          @w_resultado = null,
          @v_resultado = null
      else
        select
          @w_resultado = @i_resultado
          
      if @w_calle = @i_calle
        select
         @w_calle = null,
         @v_calle = null
      else
        select
          @w_calle = @i_calle
      
      if @w_nro = @i_nro
        select
         @w_nro = null,
         @v_nro = null
      else
        select
          @w_nro = @i_nro
      
      if @w_colonia = @i_colonia
        select
         @w_colonia = null,
         @v_colonia = null
      else
        select
          @w_colonia = @i_colonia

      if @w_localidad = @i_localidad
        select
         @w_localidad = null,
         @v_localidad = null
      else
        select
          @w_localidad = @i_localidad
                  
      if @w_municipio = @i_municipio
        select
         @w_municipio = null,
         @v_municipio = null
      else
        select
          @w_municipio = @i_municipio

      if @w_estado = @i_estado
        select
         @w_estado = null,
         @v_estado = null
      else
        select
          @w_estado = @i_estado
          
      if @w_codpostal = @i_codpostal
        select
         @w_codpostal = null,
         @v_codpostal = null
      else
        select
          @w_codpostal = @i_codpostal
         
      if @w_pais = @i_pais
        select
         @w_pais = null,
         @v_pais = null
      else
        select
          @w_pais = @i_pais
          

      if @w_tiempo_conocido = @i_tiempo_conocido
        select
         @w_tiempo_conocido = null,
         @v_tiempo_conocido = null
      else
        select
          @w_tiempo_conocido = @i_tiempo_conocido
      
      
      if @w_direccion_e = @i_direccion_e
        select
         @w_direccion_e = null,
         @v_direccion_e = null
      else
        select
          @w_direccion_e = @i_direccion_e

      begin tran

      /* modificar, los datos */
      update cl_ref_personal
      set    rp_nombre              = @i_nombre,
             rp_p_apellido          = @i_p_apellido,
             rp_s_apellido          = @i_s_apellido,
             rp_direccion           = @i_direccion,
             rp_telefono_d          = @i_telefono_d,
             rp_telefono_e          = @i_telefono_e,
             rp_telefono_o          = @i_telefono_o,
             rp_parentesco          = @i_parentesco,
             rp_fecha_modificacion  = getdate(),
             rp_vigencia            = isnull(@w_vigencia,rp_vigencia),
             rp_verificacion        = isnull(@i_verificacion,rp_verificacion),
             rp_descripcion         = @i_descripcion,
             rp_fecha_ver           = @i_fecha_ver,
             rp_funcionario         = @s_user,
             rp_departamento        = @i_departamento,
             rp_ciudad              = @i_ciudad,
             rp_barrio              = @i_barrio,
             rp_obs_verificado      = @i_resultado,
             rp_calle               = @i_calle,
             rp_nro                 = @i_nro,
             rp_colonia             = @i_colonia,
             rp_localidad           = @i_localidad,
             rp_municipio           = @i_municipio,
             rp_estado              = @i_estado,
             rp_codpostal           = @i_codpostal,
             rp_pais                = @i_pais,
             rp_tiempo_conocido     = @i_tiempo_conocido,
             rp_direccion_e			= @i_direccion_e
      where  rp_persona    = @i_ente
         and rp_referencia = @i_referencia

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105048
        /*'Error en actualizacion de referencia personal'*/
        return 1
      end

      if @i_verificacion = 'S'
      begin
        update cl_ref_personal
        set    rp_verificacion = 'S',
               rp_funcionario = @s_user
        where  rp_persona    = @i_ente
           and rp_referencia = @i_referencia
        /* si no se puede modificar, error */
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105048
          /*'Error en actualizacion de referencia personal'*/
          return 1
        end
      end
      /* Transaccion servicio - cl_ref_personal */
      insert into ts_ref_personal
      (secuencial,      tipo_transaccion,  clase,               fecha,          usuario,
       terminal,        srv,               lsrv,                persona,        referencia,
       nombre,          p_apellido,        s_apellido,          direccion,      telefono_d,
       telefono_e,      telefono_o,        parentesco,          vigencia,       verificacion,
       descripcion,     departamento,      ciudad,              barrio,         calle,
       numero,          colonia,           localidad,           municipio,      estado,
       codpostal,       pais,              tiempo,              correo)     
      values
      (@s_ssn,          @t_trn,            'P',                 getdate(),      @s_user,
       @s_term,         @s_srv,            @s_lsrv,             @i_ente,        @i_referencia,
       @v_nombre,       @v_p_apellido,     @v_s_apellido,       @v_direccion,   @v_telefono_d,
       @v_telefono_e,   @v_telefono_o,     @v_parentesco,       @v_vigencia,    @v_verificacion,
       @v_descripcion,  @v_departamento,   @v_ciudad,           @v_barrio,      @v_calle,
       @v_nro,          @v_colonia,        @v_localidad,        @v_municipio,   @v_estado,
       @v_codpostal,    @v_pais,           @i_tiempo_conocido,  @v_direccion_e)

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

      /* Transaccion servicio - cl_ref_personal */
      insert into ts_ref_personal
      (secuencial,      tipo_transaccion,  clase,               fecha,              usuario,
       terminal,        srv,               lsrv,                persona,            referencia,
       nombre,          p_apellido,        s_apellido,          direccion,          telefono_d,
       telefono_e,      telefono_o,        parentesco,          vigencia,           verificacion,
       descripcion,     departamento,      ciudad,              barrio,             calle,
       numero,          colonia,           localidad,           municipio,          estado,
       codpostal,       pais,              tiempo,              correo)
      values      
      (@s_ssn,          @t_trn,            'A',                 getdate(),          @s_user,
       @s_term,         @s_srv,             @s_lsrv,            @i_ente,            @i_referencia,
       @w_nombre,       @w_p_apellido,      @w_s_apellido,      @w_direccion,       @w_telefono_d,
       @w_telefono_e,   @w_telefono_o,      @w_parentesco,      @w_vigencia,        @w_verificacion,
       @w_descripcion,  @w_departamento,    @w_ciudad,          @w_barrio,          @w_calle,
       @w_nro,          @w_colonia,         @w_localidad,       @w_municipio,       @w_estado,
       @w_codpostal,    @w_pais,            @w_tiempo_conocido, @w_direccion_e)

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
      
      -- Actualizacion Automatica de Prospecto a Cliente
		exec cobis..sp_seccion_validar
			@i_ente			= @i_ente,
			@i_operacion 	= 'V',
			@i_seccion 		= '4', --4 es Referencias Personales
			@i_completado 	= 'S'
      
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
    if @t_trn = 1130
    begin
      /* Valores para transaccion de servicios */
      select
        @w_nombre           = rp_nombre,
        @w_p_apellido       = rp_p_apellido,
        @w_s_apellido       = rp_s_apellido,
        @w_direccion        = rp_direccion,
        @w_telefono_d       = rp_telefono_d,
        @w_telefono_e       = rp_telefono_e,
        @w_telefono_o       = rp_telefono_o,
        @w_parentesco       = rp_parentesco,
        @w_vigencia         = rp_vigencia,
        @w_descripcion      = rp_descripcion,
        @w_verificacion     = rp_verificacion,
        @w_departamento     = rp_departamento,
        @w_ciudad           = rp_ciudad,
        @w_barrio           = rp_barrio,
        @w_resultado        = rp_obs_verificado,
        @w_calle            = rp_calle,
        @w_nro              = rp_nro,
        @w_colonia          = rp_colonia,
        @w_localidad        = rp_localidad,
        @w_municipio        = rp_municipio,
        @w_estado           = rp_estado,
        @w_codpostal        = rp_codpostal,
        @w_pais             = rp_pais,
        @w_tiempo_conocido  = rp_tiempo_conocido,
        @w_direccion_e      = rp_direccion_e
      from   cl_ref_personal
      where  rp_persona    = @i_ente
         and rp_referencia = @i_referencia

      /* si no existe referencia personal, error */
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
      /* eliminar un numero de referencia personal */
      update cl_ente
      set    p_personal = p_personal - 1
      where  en_ente = @i_ente

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107048
        /* 'Error en disminucion de referencia personal'*/
        return 1
      end

      /* borrar la referencia personal */
      delete from cl_ref_personal
      where  rp_persona    = @i_ente
         and rp_referencia = @i_referencia

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107048
        /* 'Error en eliminacion de referencia personal'*/
        return 1
      end

      /* modificar en uno la secuencia de referencias */
      update cl_ref_personal
      set    rp_referencia = rp_referencia - 1
      where  rp_persona    = @i_ente
         and rp_referencia > @i_referencia

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107048
        /*'Error en eliminacion de referencia personal'*/
        return 1
      end

      /* Transacion servicios - cl_ref_personal */
      insert into ts_ref_personal
      (secuencial,      tipo_transaccion,  clase,               fecha,              usuario,
       terminal,        srv,               lsrv,                persona,            referencia,
       nombre,          p_apellido,        s_apellido,          direccion,          telefono_d,
       telefono_e,      telefono_o,        parentesco,          vigencia,           verificacion,
       descripcion,     departamento,      ciudad,              barrio,             calle,
       numero,          colonia,           localidad,           municipio,          estado,
       codpostal,       pais,              tiempo,              correo)
      values      
      (@s_ssn,          @t_trn,            'B',                 getdate(),          @s_user,
       @s_term,         @s_srv,            @s_lsrv,             @i_ente,            @i_referencia,
       @w_nombre,       @w_p_apellido,     @w_s_apellido,       @w_direccion,       @w_telefono_d,
       @w_telefono_e,   @w_telefono_o,     @w_parentesco,       @w_vigencia,        @w_verificacion,
       @w_descripcion,  @w_departamento,   @w_ciudad,           @w_barrio,          @w_calle,
       @w_nro,          @w_colonia,        @w_localidad,        @w_municipio,       @w_estado,
       @w_codpostal,    @w_pais,           @w_tiempo_conocido,  @w_direccion_e)

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

/** Search **/
  /* referencias personales de una persona no se controla de 20 en 20
     porque no se espera mas de 20 referencias personales */
  if @i_operacion = 'S'
  begin
    if @t_trn = 136
    begin
      select
        'NUMERO'                = rp_referencia,
        'NOMBRE'                = rp_nombre,
        'PRIMER_APELLIDO'       = rp_p_apellido,
        'SEGUNDO_APELLIDO'      = rp_s_apellido,
        'DIRECCION'             = substring(rp_direccion,1,32),
        'NEXO_CON_EL_CLIENTE'   = '',
        'TELEFONO_DOMICILIO'    = RTRIM(rp_telefono_d),
        'TELEFONO_EMPRESA'      = rp_telefono_e,
        'TELEFONO_OTRO'         = rp_telefono_o,
        'OBSERVACIONES'         = rp_descripcion,--MZS012
        'FECHA_REGISTRO'        = convert(varchar(10), rp_fecha_registro,@i_formato),
        'FECHA_ULT_MODIF'       = convert(varchar(10), rp_fecha_modificacion,@i_formato),
        'VIGENTE'               = rp_vigencia,
        'VERIF.'                = rp_verificacion,
        'DEPARTAMENTO'          = rp_departamento,
        'CIUDAD'                = rp_ciudad,
        'BARRIO'                = rp_barrio,
        'OBS.VERIFICADO'        = rp_obs_verificado,
        'CALLE'                 = rp_calle,
        'NRO'                   = rp_nro,
        'COLONIA'               = rp_colonia,
        'LOCALIDAD'             = rp_localidad,
        'MUNICIPIO'             = rp_municipio,
        'CODESTADO'             = rp_estado,
        'CODPOSTAL'             = rp_codpostal,
        'CODPAIS'               = rp_pais,
        'TIEMPO_CONOCI'         = rp_tiempo_conocido,
        'CORREO'                = rp_direccion_e
      from   cl_ref_personal
      where  rp_persona = @i_ente

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

/** Query **/
  /* Datos especificos de una referencia personal */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 137
    begin
      select
        @o_ente                 = rp_persona,
        @o_ennombre             = en_nomlar,
        @o_cedula               = en_ced_ruc,
        @o_referencia           = rp_referencia,
        @o_ref_nombre           = rtrim(rp_nombre),
        @o_ref_p_apellido       = rtrim(rp_p_apellido),
        @o_ref_s_apellido       = rtrim(rp_s_apellido),
        @o_direccion            = rp_direccion,
        @o_telefono_d           = rp_telefono_d,
        @o_telefono_e           = rp_telefono_e,
        @o_telefono_o           = rp_telefono_o,
        @o_parentesco           = rp_parentesco,
        @o_parnombre            = a.valor,
        @o_fecha_registro       = rp_fecha_registro,
        @o_fecha_modificacion   = rp_fecha_modificacion,
        @o_vigencia             = rp_vigencia,
        @o_verificacion         = rp_verificacion,
        @o_funcionario          = rp_funcionario,
        @o_descripcion          = rp_descripcion,
        @o_fecha_ver            = rp_fecha_ver,
        @o_departamento         = rp_departamento,
        @o_ciudad               = rp_ciudad,
        @o_barrio               = rp_barrio,
        @o_calle                = rp_calle,
        @o_nro                  = rp_nro,
        @o_colonia              = rp_colonia,
        @o_localidad            = rp_localidad,
        @o_municipio            = rp_municipio,
        @o_estado               = rp_estado,
        @o_codpostal            = rp_codpostal,
        @o_pais                 = rp_pais,
        @o_tiempo_conocido      = rp_tiempo_conocido,
        @o_direccion_e          = rp_direccion_e
      from   cl_ref_personal,
             cl_ente,
             cl_catalogo a,
             cl_tabla m
      where  rp_persona    = @i_ente
         and rp_referencia = @i_referencia
         and en_ente       = rp_persona
         and a.codigo      = rp_parentesco
         and a.tabla       = m.codigo
         and m.tabla       = 'cl_parentesco'

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end

      select
        @o_referencia,
        @o_ref_nombre,
        @o_ref_p_apellido,
        @o_ref_s_apellido,
        @o_direccion,
        @o_telefono_d,
        @o_telefono_e,
        @o_telefono_o,
        @o_parentesco,
        @o_parnombre,
        convert(char(10), @o_fecha_registro, @i_formato),
        convert(char(10), @o_fecha_modificacion, @i_formato),
        @o_vigencia,
        @o_verificacion,
        @o_funcionario,
        @o_descripcion,
        convert(char(10), @o_fecha_ver, 101),
        @o_departamento,
        @o_ciudad,
        @o_barrio,
        @o_calle,
        @o_nro,
        @o_colonia,
        @o_localidad,
        @o_municipio,
        @o_estado,
        @o_codpostal,
        @o_pais,
        @o_tiempo_conocido,
        @o_direccion_e
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

  /* ** Validacion **/
  if @i_operacion = 'V'
  begin
    if @t_trn = 136
    begin
      select
        @w_tra = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'TRA'

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101077
        /* No existe parametro */
        return 1
      end

      select
        @w_tva = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'TVA'

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101077
        /* No existe parametro */
        return 1
      end

      select
        @w_tva_ente = p_tipo_vivienda
      from   cobis..cl_ente
      where  en_ente = @i_ente

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101043
        /* No existe persona */
        return 1
      end

      if (@w_tva_ente = @w_tva)
      begin
        select
          @i_ente = rp_persona
        from   cobis..cl_ref_personal
        where  rp_persona    = @i_ente
           and rp_parentesco = @w_tra

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101224
          /* Datos del arrendador son obligatorios */
          return 1
        end
      end
      return 0
    end
  end

  if @i_operacion = 'X'
  begin
    if @t_trn = 137
    begin
      select
        @o_parTV = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'TVAR'

      if @@rowcount <> 1
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001,
          @i_msg   = 'NO EXISTE PARAMETRO TIPO VIVIENDA '
        return 101001
      end

      select
        @o_tipov = p_tipo_vivienda
      from   cobis..cl_ente
      where  en_ente = @i_ente

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end

      select
        @o_vivienda = count(0)
      from   cobis..cl_ref_personal
      where  rp_persona    = @i_ente
         and rp_parentesco = 'AR'

      select
        'parametro ' = @o_parTV,
        'ocuapacion' = @o_tipov,
        'trabajo' = @o_vivienda

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

  return 0


GO

