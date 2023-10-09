/************************************************************************/
/*  Archivo:        rangoempl.sp                                        */
/*  Stored procedure:   sp_rango_empleo                                 */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Catty Espinel/Carlos Alvarez                         */
/*  Fecha de escritura: 30-Mar-2001                                     */
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
/*      Insercion, Borrado, Modificacion de rangos de empleo para Sipla */
/*  Query de empleo generico y especifico                               */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  30/Mar/2001 C. Alvarez  Emision Inicial                             */
/*  16/Abr/2001 C. Herrera  Validacion de No superposición              */
/*                  de rangos de tipos de empleos                       */
/*  16/May/2003 E. Laguna   Ampliando tamano de rangos                  */
/*  21/Feb/2006 E. Laguna   Req 507 criterios de busqueda               */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
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
           where  name = 'sp_rango_empleo')
       drop proc sp_rango_empleo
go

create proc sp_rango_empleo
(
  @s_ssn                int = null,
  @s_user               login = null,
  @s_term               varchar(30) = null,
  @s_date               datetime = null,
  @s_srv                varchar(30) = null,
  @s_lsrv               varchar(30) = null,
  @s_ofi                smallint = null,
  @s_rol                smallint = null,
  @t_debug              char(1) = 'N',
  @t_file               varchar(10) = null,
  @t_from               varchar(32) = null,
  @t_trn                smallint = null,
  @t_show_version       bit = 0,
  @i_operacion          char(1),
  @i_tipo_empleo        catalogo = null,
  @i_rango_min          smallint = null,
  @i_rango_max          smallint = null,
  @i_parametro_mul      smallint = null,
  @i_rango_nor_min      smallint = null,
  @i_rango_nor_max      smallint = null,
  @i_fecha_registro     datetime = null,
  @i_fecha_modificacion datetime = null,
  @i_formato_fecha      int = null,

  --Variables Adicionales
  @i_rango_min_ant      smallint = null,
  @i_rango_max_ant      smallint = null,
  @i_tipo               char(1) = null,
  @i_modo               tinyint = null,
  @i_nombre             descripcion = null
)
as
  declare
    @w_sp_name             varchar(32),
    @w_return              int,
    @w_codigo              int,
    @o_siguiente           int,
    @w_today               datetime,
    /*sipla*/
    @w_rango_min           smallint,
    @w_rango_max           smallint,
    @w_parametro_mul       smallint,
    @w_rango_nor_min       smallint,
    @w_rango_nor_max       smallint,
    @w_fecha_registro      datetime,
    @w_fecha_modificacion  datetime,
    @w_funcionario         login,
    /*Variables aumentadas para evitar la superposicion de rangos */
    @w_rinferior           smallint,
    @w_rsuperior           smallint,
    @w_comparasup          smallint,
    @w_comparainf          smallint,
    @w_comparacion         smallint,
    @w_compsupmed          smallint,
    @w_compinfmed          smallint,
    @w_aux1                smallint,
    @w_aux2                smallint,
    @w_bandera1            int,
    @w_bandera2            int,
    @w_bandera3            int,
    /*sipla*/
    @v_rango_min           smallint,
    @v_rango_max           smallint,
    @v_parametro_mul       smallint,
    @v_rango_nor_min       smallint,
    @v_rango_nor_max       smallint,
    @v_fecha_registro      datetime,
    @v_fecha_modificacion  datetime,
    @v_funcionario         login,
    @o_fecha_registro      datetime,
    @o_fecha_modificacion  datetime,
    @o_funcionario         login,
    /*sipla*/
    @o_tipo_empleo         catalogo,
    @o_rango_min           smallint,
    @o_rango_max           smallint,
    @o_parametro_mul       smallint,
    @o_rango_nor_min       smallint,
    @o_rango_nor_max       smallint,
    @o_descripcion_templeo descripcion

  select
    @w_sp_name = 'sp_rango_empleo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 1451
    begin
      if @i_tipo_empleo is not null
      begin
        /*'Verificar que exista tipo de empleo'*/
        exec @w_return = cobis..sp_catalogo
          @t_debug    = @t_debug,
          @t_file     = @t_file,
          @t_from     = @w_sp_name,
          @i_tabla    = 'cl_tipo_empleo',
          @i_operacion= 'E',
          @i_codigo   = @i_tipo_empleo

        /* 'si no existe tipo de empleo, error' */
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105117
          /* 'No existe tipo de empleo'*/
          return 1
        end
      end

      /*Calculo automatico de Rangos normalizadoos*/

      if @i_rango_nor_min is null
         and @i_rango_min is not null
         and @i_parametro_mul is not null
        select
          @i_rango_nor_min = @i_rango_min

      if @i_rango_nor_max is null
         and @i_rango_max is not null
         and @i_parametro_mul is not null
        select
          @i_rango_nor_max = @i_rango_max * @i_parametro_mul

      select
        @w_comparacion = 0

      /*Verificar la no superposicion de rangos*/

      select
        @w_aux1 = max(re_rango_max)
      from   cl_rango_empleo
      where  re_tipo_empleo = @i_tipo_empleo
         and re_rango_max   <= @i_rango_max

      /*Seleccionar el minimo rango inferior existente*/

      select
        @w_aux2 = max(re_rango_min)
      from   cl_rango_empleo
      where  re_tipo_empleo = @i_tipo_empleo
         and re_rango_min   <= @i_rango_min

      if @w_aux1 > @w_aux2
        select
          @w_comparacion = 1

      /*Seleccionar el maximo rango superior existente*/

      select
        @w_rsuperior = max(re_rango_max)
      from   cl_rango_empleo
      where  re_tipo_empleo = @i_tipo_empleo

      /*Seleccionar el minimo rango inferior existente*/

      select
        @w_rinferior = min(re_rango_min)
      from   cl_rango_empleo
      where  re_tipo_empleo = @i_tipo_empleo

    /*Comparar con rango ingresante para verificar que podemos insertar */
      /*if @w_comparacion = 0
      begin
      */

      if (@w_rsuperior is not null
          and @w_rinferior is not null)
      begin
        select
          @w_comparasup = 0
        select
          @w_comparainf = 0

        /*Ver si el nuevo rango es mayor que todos... */

        if @i_rango_min >= @w_rsuperior
          select
            @w_comparasup = 1

        /*Ver si el nuevo rango es menor que todos... */

        if @i_rango_max <= @w_rinferior
          select
            @w_comparainf = 1

        /*Verificar ahora los rangos intermedios*/

        if @w_comparainf = 0
           and @w_comparasup = 0
        begin
          /*comparar los rangos intermedios*/
          select
            @w_compsupmed = max(re_rango_max)
          from   cl_rango_empleo
          where  re_tipo_empleo = @i_tipo_empleo
             and re_rango_max   <= @i_rango_min
          select
            @w_compinfmed = min(re_rango_min)
          from   cl_rango_empleo
          where  re_tipo_empleo = @i_tipo_empleo
             and re_rango_min   >= @i_rango_min

          if @w_compsupmed is null
             and @w_compinfmed is null
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 105101 /*Se debe cambiar*/
            /* 'Error en creacion de rango de tipo de empleo'*/
            return 1
          end

          if @w_compsupmed is null
            select
              @w_compsupmed = 0

          if @w_compinfmed is null
            select
              @w_compinfmed = 0

          /*Verificar que podemos insertar */
          if @w_compsupmed <= @i_rango_min
             and @w_compinfmed >= @i_rango_max
          begin
            select
              @w_comparacion = 1
          /*Podemos Insertar*/
          end

          else
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 105101 /*Se debe cambiar*/
            /* 'Error en creacion de rango de tipo de empleo'*/
            return 1
          end

          if @w_compsupmed >= @w_compinfmed
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 105101 /*Se debe cambiar*/
            /* 'Error en creacion de rango de tipo de empleo'*/
            return 1
          end
        end

      end
      /*
      end
      */

      begin tran
      /*insertar datos de rangos de un empleo*/
      insert into cl_rango_empleo
                  (re_tipo_empleo,re_rango_min,re_rango_max,re_parametro_mul,
                   re_rango_nor_min,
                   re_rango_nor_max,re_fecha_registro,re_fecha_modificacion,
                   re_funcionario)
      values     (@i_tipo_empleo,@i_rango_min,@i_rango_max,@i_parametro_mul,
                  @i_rango_nor_min,
                  @i_rango_nor_max,@w_today,@i_fecha_modificacion,@s_user)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105101
        /* 'Error en creacion de rango de tipo de empleo'*/
        return 1
      end

      /*Transacciones de servicio*/

      insert into ts_rango_empleo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,tipo_empleo,rango_min,
                   rango_max,parametro_mul,rango_nor_min,rango_nor_max,
                   fecha_registro,
                   fecha_modificacion)
      values     (@s_ssn,@t_trn,'N',@s_date,@s_user,
                  @s_term,@s_srv,@s_lsrv,@i_tipo_empleo,@i_rango_min,
                  @i_rango_max,@i_parametro_mul,@i_rango_nor_min,
                  @i_rango_nor_max,
                  @i_fecha_registro,
                  @i_fecha_modificacion)

      /* si no se puede insertar, error */

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105106
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

  /** Update **/
  if @i_operacion = 'U'
  begin
    if @t_trn = 1452
    begin
      if @i_tipo_empleo is not null
      begin
        /*'Verificar que exista tipo de empleo'*/
        exec @w_return = cobis..sp_catalogo
          @t_debug    = @t_debug,
          @t_file     = @t_file,
          @t_from     = @w_sp_name,
          @i_tabla    = 'cl_tipo_empleo',
          @i_operacion= 'E',
          @i_codigo   = @i_tipo_empleo

        /* 'si no existe tipo de empleo, error' */
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105117
          /* 'No existe tipo de empleo'*/
          return 1
        end
      end

      /*Calculo automatico de Rangos normalizadoos*/

      if @i_rango_nor_min is null
         and @i_rango_min is not null
         and @i_parametro_mul is not null
        select
          @i_rango_nor_min = @i_rango_min

      if @i_rango_nor_max is null
         and @i_rango_max is not null
         and @i_parametro_mul is not null
        select
          @i_rango_nor_max = @i_rango_max * @i_parametro_mul

      /* Control de campos a actualizar */
      select
        @w_rango_min = re_rango_min,
        @w_rango_max = re_rango_max,
        @w_parametro_mul = re_parametro_mul,
        @w_rango_nor_min = re_rango_nor_min,
        @w_rango_nor_max = re_rango_nor_max,
        @w_fecha_registro = re_fecha_registro,
        @w_fecha_modificacion = re_fecha_modificacion,
        @w_funcionario = re_funcionario
      from   cl_rango_empleo
      where  re_tipo_empleo = @i_tipo_empleo
         and re_rango_min   = @i_rango_min_ant
         and re_rango_max   = @i_rango_max_ant

      if @@rowcount <> 1
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105102

        return 1
      end

      select
        @v_rango_min = @w_rango_min,
        @v_rango_max = @w_rango_max,
        @v_parametro_mul = @w_parametro_mul,
        @v_rango_nor_min = @w_rango_nor_min,
        @v_rango_nor_max = @w_rango_nor_max,
        @v_fecha_registro = @w_fecha_registro,
        @v_fecha_modificacion = @w_fecha_modificacion,
        @v_funcionario = @w_funcionario

      if @w_rango_min = @i_rango_min
        select
          @w_rango_min = null,
          @v_rango_min = null
      else
        select
          @w_rango_min = @i_rango_min

      if @w_rango_max = @i_rango_max
        select
          @w_rango_max = null,
          @v_rango_max = null
      else
        select
          @w_rango_max = @i_rango_max

      if @w_parametro_mul = @i_parametro_mul
        select
          @w_parametro_mul = null,
          @v_parametro_mul = null
      else
        select
          @w_parametro_mul = @i_parametro_mul

      if @w_rango_nor_min = @i_rango_nor_min
        select
          @w_rango_nor_min = null,
          @v_rango_nor_min = null
      else
        select
          @w_rango_nor_min = @i_rango_nor_min

      if @w_rango_nor_max = @i_rango_nor_max
        select
          @w_rango_nor_max = null,
          @v_rango_nor_max = null
      else
        select
          @w_rango_nor_max = @i_rango_nor_max

      if @w_fecha_registro = @i_fecha_registro
        select
          @w_fecha_registro = null,
          @v_fecha_registro = null
      else
        select
          @w_fecha_registro = @i_fecha_registro

      if @w_fecha_modificacion = @i_fecha_modificacion
        select
          @w_fecha_modificacion = null,
          @v_fecha_modificacion = null
      else
        select
          @w_fecha_modificacion = @i_fecha_modificacion

      if @w_funcionario = @s_user
        select
          @w_funcionario = null,
          @v_funcionario = null
      else
        select
          @w_funcionario = @s_user

      /*Calculo automatico de Rangos normalizadoos*/

      if @i_rango_nor_min is null
         and @i_rango_min is not null
         and @i_parametro_mul is not null
        select
          @i_rango_nor_min = @i_rango_min

      if @i_rango_nor_max is null
         and @i_rango_max is not null
         and @i_parametro_mul is not null
        select
          @i_rango_nor_max = @i_rango_max * @i_parametro_mul

      /*Verificar la no superposicion de rangos*/

      select
        @w_comparacion = 0

      select
        @w_aux1 = max(re_rango_max)
      from   cl_rango_empleo
      where  re_tipo_empleo = @i_tipo_empleo

      if @w_aux1 = @i_rango_max_ant
        select
          @w_comparacion = 1

      /*Seleccionar el maximo rango superior existente*/

      select
        @w_rsuperior = max(re_rango_max)
      from   cl_rango_empleo
      where  re_tipo_empleo = @i_tipo_empleo

      /*Seleccionar el minimo rango inferior existente*/

      select
        @w_rinferior = min(re_rango_min)
      from   cl_rango_empleo
      where  re_tipo_empleo = @i_tipo_empleo

    /*Comparar con rango ingresante para verificar que podemos insertar */
      /*
      if @w_comparacion =0
      begin
      */
      if (@w_rsuperior is not null
          and @w_rinferior is not null)
      begin
        select
          @w_comparasup = 0
        select
          @w_comparainf = 0

        /*Ver si el nuevo rango es mayor que todos... */

        if @i_rango_min >= @w_rsuperior
          select
            @w_comparasup = 1

        /*Ver si el nuevo rango es menor que todos... */

        if @i_rango_max <= @w_rinferior
          select
            @w_comparainf = 1

        /*Verificar ahora los rangos intermedios*/

        if @w_comparainf = 0
           and @w_comparasup = 0
        begin
          /*comparar los rangos intermedios*/
          select
            @w_compsupmed = max(re_rango_max)
          from   cl_rango_empleo
          where  re_tipo_empleo = @i_tipo_empleo
             and re_rango_max   <= @i_rango_min

          select
            @w_compinfmed = min(re_rango_min)
          from   cl_rango_empleo
          where  re_tipo_empleo = @i_tipo_empleo
             and re_rango_min   >= @i_rango_min

        /*  if @w_compsupmed is null and @w_compinfmed is null
              begin
                 exec sp_cerror
                 @t_debug    = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 105102       /*Se debe cambiar*/
                /* 'Error en actualizacion de rango de tipo de empleo'*/
                return 1
            end
        
        if @w_compsupmed is null
            select @w_compsupmed = 0
        
        if @w_compinfmed is null
            select @w_compinfmed = 0
        
        
        /*Verificar que podemos insertar */
          if @w_compsupmed <= @i_rango_min and @w_compinfmed >= @i_rango_max
            begin
                select @w_comparacion=1
                /*Podemos Insertar*/
            end
        
            else
                begin
             exec sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 105102       /*Se debe cambiar*/
             /* 'Error en actualizacion de rango de tipo de empleo'*/
            return 1
            end
        
        
        
         if @w_compsupmed >=  @w_compinfmed
            begin
             exec sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 105102       /*Se debe cambiar*/
             /* 'Error en actualizacion de rango de tipo de empleo'*/
            return 1
            end
        end
        
        end
        
        /*
        end
        */
           ELA  */
          /*En la actualizacion establecer la comparacion pero con los rangos anteriores*/

          if ((@i_rango_min >= @i_rango_min_ant)
              and (@i_rango_min < @i_rango_max_ant))
            select
              @w_bandera1 = 1

          if ((@i_rango_max <= @i_rango_max_ant)
              and (@i_rango_max > @i_rango_min_ant))
            select
              @w_bandera2 = 1

          --Modificacion en el caso de que se trate de la modificacion del ultimo rango
          if ((@i_rango_max >= @w_rsuperior)
              and (@i_rango_max > @i_rango_min_ant))
            select
              @w_bandera2 = 1

          --Ambos deben ser 1 para que se pueda actualizar

          if @w_bandera1 = 1
             and @w_bandera2 = 1
          begin
            select
              @w_bandera3 = 1
          end
          else
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 105108
            return 1
          --No se puede actualizar
          end

        end
      end

      begin tran
      update cl_rango_empleo
      set    /*re_tipo_empleo    = @i_tipo_empleo,*/
      re_rango_min = @i_rango_min,
      re_rango_max = @i_rango_max,
      re_parametro_mul = @i_parametro_mul,
      re_rango_nor_min = @i_rango_nor_min,
      re_rango_nor_max = @i_rango_nor_max,
      re_fecha_modificacion = @w_today,
      re_funcionario = @s_user
      where  re_tipo_empleo = @i_tipo_empleo
             /*para no borrar varios rangos*/
             and re_rango_min   = @i_rango_min_ant
             and re_rango_max   = @i_rango_max_ant

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105102
        /* 'Error en actualizacion de empleo'*/
        return 1
      end

      /* Transaccion servicios - cl_rango_empleo */

      insert into ts_rango_empleo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,tipo_empleo,rango_min,
                   rango_max,parametro_mul,rango_nor_min,rango_nor_max,
                   fecha_registro,
                   fecha_modificacion)
      values     (@s_ssn,@t_trn,'P',@s_date,@s_user,
                  @s_term,@s_srv,@s_lsrv,@i_tipo_empleo,@v_rango_min,
                  @v_rango_max,@v_parametro_mul,@v_rango_nor_min,
                  @v_rango_nor_max,
                  @v_fecha_registro,
                  @v_fecha_modificacion)

      /* si no se puede insertar, error */

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105106
        /* 'Error en creacion de transaccion de servicios'*/

        return 1
      end

      insert into ts_rango_empleo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,tipo_empleo,rango_min,
                   rango_max,parametro_mul,rango_nor_min,rango_nor_max,
                   fecha_registro,
                   fecha_modificacion)
      values     (@s_ssn,@t_trn,'A',@s_date,@s_user,
                  @s_term,@s_srv,@s_lsrv,@i_tipo_empleo,@w_rango_min,
                  @w_rango_max,@w_parametro_mul,@w_rango_nor_min,
                  @w_rango_nor_max,
                  @w_fecha_registro,
                  @i_fecha_modificacion)

      /* si no se puede insertar, error */

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105106
        /*'Error en creacion de transaccion de servicios'*/
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
    if @t_trn = 1453
    begin
      /*Campos para la transaccion de Servicios*/
      select
        @w_rango_min = re_rango_min,
        @w_rango_max = re_rango_max,
        @w_parametro_mul = re_parametro_mul,
        @w_rango_nor_min = re_rango_nor_min,
        @w_rango_nor_max = re_rango_nor_max,
        @w_fecha_registro = re_fecha_registro,
        @w_fecha_modificacion = re_fecha_modificacion,
        @w_funcionario = re_funcionario
      from   cl_rango_empleo
      where  re_tipo_empleo = @i_tipo_empleo
         and re_rango_min   = @i_rango_min
         and re_rango_max   = @i_rango_max

      if @@rowcount <> 1
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105103
        /* 'No existe empleo' */
        return 1
      end

      begin tran

      /*Borrar el tipo de rango*/

      delete from cl_rango_empleo
      where  re_tipo_empleo = @i_tipo_empleo
         and re_rango_min   = @i_rango_min
         and re_rango_max   = @i_rango_max

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105103
        /*'Error en eliminacion de rango de empleo'*/
        return 1
      end

      insert into ts_rango_empleo
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,tipo_empleo,rango_min,
                   rango_max,parametro_mul,rango_nor_min,rango_nor_max,
                   fecha_registro,
                   fecha_modificacion)
      values     (@s_ssn,@t_trn,'B',@s_date,@s_user,
                  @s_term,@s_srv,@s_lsrv,@i_tipo_empleo,@w_rango_min,
                  @w_rango_max,@w_parametro_mul,@w_rango_nor_min,
                  @w_rango_nor_max,
                  @w_fecha_registro,
                  @i_fecha_modificacion)

      /* si no se puede insertar, error */

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105106

        /*'Error en creacion de transaccion de servicios'*/

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
        @i_num   = 151051 /*Se debe cambiar*/
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

/** Search **/
/* datos de empleos de una persona no se controla de 20 en 20
   se espera menos de 20 empleos por persona  */
  /* Search */

  if @i_operacion = 'S'
  begin
    if @t_trn <> 1454
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

    set rowcount 20
    if @i_tipo = 'C' /*BUSQUEDA POR CODIGO*/
    begin
      if @i_modo = 0
      begin
        select
          'Codigo Tipo' = re_tipo_empleo,
          'Tipo Empleo' = valor,
          'Rango Minino' = re_rango_min,
          'Rango Maximo' = re_rango_max,
          'Parametro Mult.'= re_parametro_mul,
          'Rango Nor. Min' = re_rango_nor_min,
          'Rango Nor. Max' = re_rango_nor_max,
          'Fecha Registro' = convert(char(10), re_fecha_registro,
                             @i_formato_fecha
                             ),
          'Fecha ult Mofic.'= convert(char(10), re_fecha_modificacion,
                              @i_formato_fecha)
          ,
          'Funcionario' = re_funcionario
        from   cl_rango_empleo,
               cl_catalogo x,
               cl_tabla y
        where  re_tipo_empleo = x.codigo
           and re_tipo_empleo >= @i_tipo_empleo
           and x.tabla        = y.codigo
           and y.tabla        = 'cl_tipo_empleo'
        order  by re_tipo_empleo
      end
      else
      begin
        if @i_modo = 1
          select
            'Codigo Tipo' = re_tipo_empleo,
            'Tipo Empleo' = valor,
            'Rango Minino' = re_rango_min,
            'Rango Maximo' = re_rango_max,
            'Parametro Mult.'= re_parametro_mul,
            'Rango Nor. Min' = re_rango_nor_min,
            'Rango Nor. Max' = re_rango_nor_max,
            'Fecha Registro' = convert(char(10), re_fecha_registro,
                               @i_formato_fecha
                               ),
            'Fecha ult Mofic.'= convert(char(10), re_fecha_modificacion,
                                @i_formato_fecha)
            ,
            'Funcionario' = re_funcionario
          from   cl_rango_empleo,
                 cl_catalogo x,
                 cl_tabla y
          where  re_tipo_empleo = x.codigo
             and re_tipo_empleo > @i_tipo_empleo
             and x.tabla        = y.codigo
             and y.tabla        = 'cl_tipo_empleo'
          order  by re_tipo_empleo
        else
          select
            'Codigo Tipo' = re_tipo_empleo,
            'Tipo Empleo' = valor,
            'Rango Minino' = re_rango_min,
            'Rango Maximo' = re_rango_max,
            'Parametro Mult.'= re_parametro_mul,
            'Rango Nor. Min' = re_rango_nor_min,
            'Rango Nor. Max' = re_rango_nor_max,
            'Fecha Registro' = convert(char(10), re_fecha_registro,
                               @i_formato_fecha
                               ),
            'Fecha ult Mofic.'= convert(char(10), re_fecha_modificacion,
                                @i_formato_fecha)
            ,
            'Funcionario' = re_funcionario
          from   cl_rango_empleo,
                 cl_catalogo x,
                 cl_tabla y
          where  re_tipo_empleo = x.codigo
             and re_tipo_empleo = @i_tipo_empleo
             and x.tabla        = y.codigo
             and y.tabla        = 'cl_tipo_empleo'
          order  by re_tipo_empleo
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151121
          return 1
        end
      end
    end

    if @i_tipo = 'N'
    begin --tipo N /*BUSQUEDA POR DESCRIPCION*/
      if @i_modo = 0
      begin
        select
          'Codigo Tipo' = re_tipo_empleo,
          'Tipo Empleo' = valor,
          'Rango Minino' = re_rango_min,
          'Rango Maximo' = re_rango_max,
          'Parametro Mult.'= re_parametro_mul,
          'Rango Nor. Min' = re_rango_nor_min,
          'Rango Nor. Max' = re_rango_nor_max,
          'Fecha Registro' = convert(char(10), re_fecha_registro,
                             @i_formato_fecha
                             ),
          'Fecha ult Mofic.'= convert(char(10), re_fecha_modificacion,
                              @i_formato_fecha)
          ,
          'Funcionario' = re_funcionario
        from   cl_rango_empleo,
               cl_catalogo x,
               cl_tabla y
        where  re_tipo_empleo = x.codigo
           and valor          >= @i_nombre
           and x.tabla        = y.codigo
           and y.tabla        = 'cl_tipo_empleo'
        order  by valor
      end
      else if @i_modo = 1
      begin
        select
          'Codigo Tipo' = re_tipo_empleo,
          'Tipo Empleo' = valor,
          'Rango Minino' = re_rango_min,
          'Rango Maximo' = re_rango_max,
          'Parametro Mult.'= re_parametro_mul,
          'Rango Nor. Min' = re_rango_nor_min,
          'Rango Nor. Max' = re_rango_nor_max,
          'Fecha Registro' = convert(char(10), re_fecha_registro,
                             @i_formato_fecha
                             ),
          'Fecha ult Mofic.'= convert(char(10), re_fecha_modificacion,
                              @i_formato_fecha)
          ,
          'Funcionario' = re_funcionario
        from   cl_rango_empleo,
               cl_catalogo x,
               cl_tabla y
        where  re_tipo_empleo = x.codigo
           and valor          > @i_nombre
           and x.tabla        = y.codigo
           and y.tabla        = 'cl_tipo_empleo'
        order  by valor
      end
      else
      begin
        select
          'Codigo Tipo' = re_tipo_empleo,
          'Tipo Empleo' = valor,
          'Rango Minino' = re_rango_min,
          'Rango Maximo' = re_rango_max,
          'Parametro Mult.'= re_parametro_mul,
          'Rango Nor. Min' = re_rango_nor_min,
          'Rango Nor. Max' = re_rango_nor_max,
          'Fecha Registro' = convert(char(10), re_fecha_registro,
                             @i_formato_fecha
                             ),
          'Fecha ult Mofic.'= convert(char(10), re_fecha_modificacion,
                              @i_formato_fecha)
          ,
          'Funcionario' = re_funcionario
        from   cl_rango_empleo,
               cl_catalogo x,
               cl_tabla y
        where  re_tipo_empleo = x.codigo
           and valor          = @i_nombre
           and x.tabla        = y.codigo
           and y.tabla        = 'cl_tipo_empleo'
        order  by valor

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151121
          return 1
        end
      end
      set rowcount 0
    end
    return 0
  end

/** Query **/
  /* Busqueda de trabajos especificos de un ente */

  if @i_operacion = 'Q'
  begin
    if @t_trn = 1455
    begin
      select
        @o_tipo_empleo = re_tipo_empleo,
        @o_descripcion_templeo = valor,
        @o_rango_min = re_rango_min,
        @o_rango_max = re_rango_max,
        @o_parametro_mul = re_parametro_mul,
        @o_rango_nor_min = re_rango_nor_min,
        @o_rango_nor_max = re_rango_nor_max,
        @o_fecha_registro = re_fecha_registro,
        @o_fecha_modificacion = re_fecha_modificacion,
        @o_funcionario = re_funcionario
      from   cl_rango_empleo,
             cl_catalogo x,
             cl_tabla y
      where  re_tipo_empleo = @i_tipo_empleo
         and re_tipo_empleo = x.codigo
         and x.tabla        = y.codigo
         and y.tabla        = 'cl_tipo_empleo'

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001 /*Se debe revisar*/
        /*'No existe dato solicitado'*/
        return 1
      end

      select
        @o_tipo_empleo,
        @o_descripcion_templeo,
        @o_rango_min,
        @o_rango_max,
        @o_parametro_mul,
        @o_rango_nor_min,
        @o_rango_nor_max,
        convert(char(10), @o_fecha_registro, @i_formato_fecha),
        convert(char(10), @o_fecha_modificacion, @i_formato_fecha),
        @o_funcionario

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

