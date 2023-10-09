/************************************************************************/
/*  Archivo:            cl_parviable.sp                                 */
/*  Stored procedure:   sp_param_viable                                 */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Jose Julian Cortes                              */
/*  Fecha de escritura: 13-Abr-2011                                     */
/************************************************************************/
/*                      IMPORTANTE                                      */
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
/*                      PROPOSITO                                       */
/*  Este programa procesa las transacciones del stored procedure        */
/*  Insercion de Referenciacion / Viabilidad                            */
/*  Actualizacion de Referenciacion / Viabilidad                        */
/*  Busqueda de Referenciacion / Viabilidad                             */
/*  Ayuda de Referenciacion / Viabilidad                                */
/************************************************************************/
/*                   MODIFICACIONES                                     */
/*  FECHA       AUTOR         RAZON                                     */
/*  13/Abr/11   Jose Cortes   Emision Inicial                           */
/*  02/May/16   DFu           Migracion CEN                             */
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
           where  name = 'sp_param_viable')
  drop proc sp_param_viable
go

create proc sp_param_viable
(
  @s_ssn           int = null,
  @s_user          login = null,
  @s_term          varchar(30) = null,
  @s_date          datetime = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_ofi           smallint = null,
  @s_rol           smallint = null,
  @s_org_err       char(1) = null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           descripcion = null,
  @s_org           char(1) = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(10) = null,
  @t_from          varchar(32) = null,
  @t_trn           smallint = null,
  @t_show_version  bit = 0,
  @i_operacion     char(1),
  @i_tipo          char(1) = null,
  @i_modo          int = null,
  @i_reproducto    varchar(10) = null,
  @i_retip_persona char(1) = null,
  @i_regrupo_inf   varchar(10) = null,
  @i_reviabilidad  varchar(10) = null,
  @i_restado       varchar(10) = null,
  @i_visecuencial  int = null,
  @i_viresultado   varchar(10) = null,
  @i_viable        char(1) = null,
  @i_viestado      varchar(10) = null,
  @i_viponderacion int = null,
  @o_seq           int = null output
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(32),
    @w_codigo           int,
    @o_siguiente        tinyint,
    --@w_codigo                 int,

    @w_reproducto       varchar(10),
    @w_retip_persona    char(1),
    @w_regrupo_inf      varchar(10),
    @w_reviabilidad     varchar(10),
    @w_restado          varchar(10),
    @w_refecha_ingreso  datetime,
    @w_refecha_modifica datetime,
    @w_viresultado      varchar(10),
    @w_viable           char(1),
    @w_viestado         varchar(10),
    @w_viponderacion    int,
    @v_reproducto       varchar(10),
    @v_retip_persona    char(1),
    @v_regrupo_inf      varchar(10),
    @v_reviabilidad     varchar(10),
    @v_restado          varchar(10),
    @v_refecha_ingreso  datetime,
    @v_refecha_modifica datetime,
    @v_viresultado      varchar(10),
    @v_viable           char(1),
    @v_viestado         varchar(10),
    @v_viponderacion    int

  select
    @w_sp_name = 'sp_param_viable'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_operacion = 'I'
  begin
    if @t_trn = 1066
    begin
      /*Almacenar en variables*/
      select
        @w_reproducto = re_producto,
        @w_retip_persona = re_tipo_persona,
        @w_regrupo_inf = re_grupo_info,
        @w_reviabilidad = re_viabilidad,
        @w_restado = re_estado
      from   cl_referenciacion
      where  re_producto     = @i_reproducto
         and re_tipo_persona = @i_retip_persona
         and re_grupo_info   = @i_regrupo_inf

      --retorna error
      if @@rowcount > 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 2101002
        /* 'Registro ya existe'*/
        return 1
      end

    /******* Valida Catalogos *******/
      /* verificar que el producto exista */
      if @i_reproducto is not null
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  codigo = @i_reproducto
           and tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_producto')
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101032
          /* 'No existe producto' */
          return 1
        end
      end

      /* verificar el grupo de informacion verificacion */
      if @i_regrupo_inf is not null
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  codigo = @i_regrupo_inf
           and tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_grupos_informacion')
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101000
          /* 'No existe dato en Catalogo'*/
          return 1
        end
      end

      /* verificar la respuesta viable */
      if @i_reviabilidad is not null
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  codigo = @i_reviabilidad
           and tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_resultado_gestion')
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101000
          /* 'No existe dato en Catalogo'*/
          return 1
        end
      end

      /* verificar el estado */
      if @i_restado is not null
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  codigo = @i_restado
           and tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_estado_ser')
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101054
          /* 'No existe estado del servicio'*/
          return 1
        end
      end

      /*verificar  tipo de persona*/

      if @i_retip_persona not in ('P', 'C')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101114
        /* parametro invalido */
        return 1
      end

      begin tran

      insert into cl_referenciacion
                  (re_producto,re_tipo_persona,re_grupo_info,re_viabilidad,
                   re_estado
                   ,
                   re_fecha_ingreso)
      values      (@i_reproducto,@i_retip_persona,@i_regrupo_inf,@i_reviabilidad
                   ,
                   @i_restado,
                   getdate())

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103015
        /* Error en Creacion de Catalogo*/
        return 1
      end

      insert into ts_referenciacion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,producto,tipo_persona,
                   grupo_inf,viabilidad,estado,fecha_ing)
      values      ( @s_ssn,@t_trn,'I',@s_date,@s_user,
                    @s_term,@s_srv,@s_lsrv,@i_reproducto,@i_retip_persona,
                    @i_regrupo_inf,@i_reviabilidad,@i_restado,getdate() )

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 143005
        /*Error en insercion de transaccion de servicio*/
        return 1
      end

      commit tran
      return 0
    end
    else if @t_trn = 1070
    begin
    /*  Verificacion de Catalogos */
      /* verificar la respuesta viable */
      if @i_viresultado is not null
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  codigo = @i_viresultado
           and tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_resultado_gestion')

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101000
          /*No existe dato en catalogo*/
          return 1
        end
      end

      /* verificar el estado */
      if @i_viestado is not null
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  codigo = @i_viestado
           and tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_estado_ser')

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101054
          /* 'No existe estado del servicio'*/
          return 1
        end
      end

      /*verificar Viabilidad*/

      if @i_viable not in ('S', 'N')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101114
        /* parametro invalido */
        return 1
      end

      /*Verificar ponderacion*/
      if @i_viponderacion < 0
          or @i_viponderacion > 100
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101114
        /* parametro invalido */
        return 1
      end

      --Encontrar un nuevo secuencial 
      exec cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_viabilidad',
        @o_siguiente = @o_seq output

      begin tran

      insert into cl_viabilidad
                  (vi_secuencial,vi_resultado,vi_viable,vi_estado,vi_ponderacion
      )
      values      (@o_seq,@i_viresultado,@i_viable,@i_viestado,@i_viponderacion)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103015
      /* 'Error en creacion de Catalogo*/
        --rollback tran
        return 1
      end

      insert into ts_viabilidad
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,codigo,resultado,
                   viable,estado,ponderacion)
      values      ( @s_ssn,@t_trn,'I',@s_date,@s_user,
                    @s_term,@s_srv,@s_lsrv,@o_seq,@i_viresultado,
                    @i_viable,@i_viestado,@i_viponderacion )

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 143005
        /* 'Error en insercion de transaccion de servicio*/
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

  if @i_operacion = 'U'
  begin
    if @t_trn = 1067
    begin
      /*Almacenar en variables*/
      select
        @w_reproducto = re_producto,
        @w_retip_persona = re_tipo_persona,
        @w_regrupo_inf = re_grupo_info,
        @w_reviabilidad = re_viabilidad,
        @w_restado = re_estado
      from   cl_referenciacion
      where  re_producto     = @i_reproducto
         and re_tipo_persona = @i_retip_persona
         and re_grupo_info   = @i_regrupo_inf

      --retorna error
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

      /* verificar la respuesta viable */
      if @i_reviabilidad is not null
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  codigo = @i_reviabilidad
           and tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_resultado_gestion')
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101000
          /*No existe dato en catalogo*/
          return 1
        end
      end

      /* verificar el estado */
      if @i_restado is not null
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  codigo = @i_restado
           and tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_estado_ser')
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101054
          /* 'No existe estado del servicio'*/
          return 1
        end
      end

      /* capturar los datos que han cambiado */
      select
        @v_reproducto = @w_reproducto,
        @v_retip_persona = @w_retip_persona,
        @v_regrupo_inf = @w_regrupo_inf,
        @v_reviabilidad = @w_reviabilidad,
        @v_restado = @w_restado

      if @w_reviabilidad = @i_reviabilidad
        select
          @w_reviabilidad = null,
          @v_reviabilidad = null
      else
        select
          @w_reviabilidad = @i_reviabilidad

      if @w_restado = @i_restado
        select
          @w_restado = null,
          @v_restado = null
      else
        select
          @w_restado = @i_restado

      begin tran

      update cl_referenciacion
      set    re_viabilidad = @i_reviabilidad,
             re_estado = @i_restado,
             re_fecha_modifica = getdate()
      where  re_producto     = @i_reproducto
         and re_tipo_persona = @i_retip_persona
         and re_grupo_info   = @i_regrupo_inf

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105000
        /*'Error en actualizacion de catalogo'*/
        return 1
      end

      insert into ts_referenciacion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,producto,tipo_persona,
                   grupo_inf,viabilidad,estado,fecha_mod)
      values      ( @s_ssn,@t_trn,'A',@s_date,@s_user,
                    @s_term,@s_srv,@s_lsrv,@v_reproducto,@v_retip_persona,
                    @v_regrupo_inf,@v_reviabilidad,@v_restado,getdate() )

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 143005
        /*Error en insercion de transaccion de servicio*/
        return 1
      end

      insert into ts_referenciacion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,producto,tipo_persona,
                   grupo_inf,viabilidad,estado,fecha_mod)
      values      ( @s_ssn,@t_trn,'P',@s_date,@s_user,
                    @s_term,@s_srv,@s_lsrv,@w_reproducto,@w_retip_persona,
                    @w_regrupo_inf,@w_reviabilidad,@w_restado,getdate() )

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 143005
        /*Error en insercion de transaccion de servicio*/
        return 1
      end

      commit tran
      return 0
    end
    else if @t_trn = 1071
    begin
      /*Almacenar en variables*/
      select
        @w_viresultado = vi_resultado,
        @w_viable = vi_viable,
        @w_viestado = vi_estado,
        @w_viponderacion = vi_ponderacion
      from   cl_viabilidad
      where  vi_secuencial = @i_visecuencial
         and vi_resultado  = @i_viresultado
      --retorna error
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

    /*  Verificacion de Catalogos */
      /* verificar el estado */
      if @i_viestado is not null
      begin
        select
          @w_codigo = null
        from   cl_catalogo
        where  codigo = @i_viestado
           and tabla  = (select
                           codigo
                         from   cl_tabla
                         where  tabla = 'cl_estado_ser')
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101054
          /* 'No existe estado del servicio'*/
          return 1
        end
      end

      /*verificar Viabilidad*/

      if @i_viable not in ('S', 'N')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101114
        /* parametro invalido */
        return 1
      end

      /*Verificar ponderacion*/
      if @i_viponderacion < 0
          or @i_viponderacion > 100
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101114
        /* parametro invalido */
        return 1
      end
      /* capturar los datos que han cambiado */

      select
        @v_viresultado = @w_viresultado,
        @v_viable = @w_viable,
        @v_viestado = @w_viestado,
        @v_viponderacion = @w_viponderacion

      begin tran

      /*Modifica la tabla*/
      update cl_viabilidad
      set    vi_viable = @i_viable,
             vi_estado = @i_viestado,
             vi_ponderacion = @i_viponderacion
      where  vi_secuencial = @i_visecuencial
         and vi_resultado  = @i_viresultado

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105000
        /*'Error en actualizacion de catalogo'*/
        return 1
      end

      insert into ts_viabilidad
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,codigo,resultado,
                   viable,estado,ponderacion)
      values      ( @s_ssn,@t_trn,'A',@s_date,@s_user,
                    @s_term,@s_srv,@s_lsrv,@i_visecuencial,@v_viresultado,
                    @v_viable,@v_viestado,@v_viponderacion )

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 143005
        /* 'Error en insercion de transaccion de servicio*/
        return 1
      end

      insert into ts_viabilidad
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,codigo,resultado,
                   viable,estado,ponderacion)
      values      ( @s_ssn,@t_trn,'P',@s_date,@s_user,
                    @s_term,@s_srv,@s_lsrv,@i_visecuencial,@w_viresultado,
                    @w_viable,@w_viestado,@w_viponderacion )

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 143005
        /* 'Error en insercion de transaccion de servicio*/
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

  if @i_operacion = 'S'
  begin
    if @t_trn = 1068
    begin
      select
        'No. Producto' = re_producto,
        'Tipo Persona' = re_tipo_persona,
        'Grupo Informacion' = re_grupo_info,
        'Resultado Gestion' = re_viabilidad,
        'Estado Servicio' = re_estado,
        'Fecha Ingreso' = convert(varchar(10), re_fecha_ingreso, 101),
        'Fecha Modificacion'= convert(varchar(10), re_fecha_modifica, 101)
      from   cl_referenciacion
      return 0
      --retorna error
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

    end
    else if @t_trn = 1072
    begin
      set rowcount 20
      if @i_modo = 0
      begin
        select
          'No. Secuencial' = vi_secuencial,
          'Resultado Gestion' = vi_resultado,
          'Viable S/N' = vi_viable,
          'Estado Servicio' = vi_estado,
          'Ponderaci¾n' = vi_ponderacion
        from   cl_viabilidad
        order  by vi_secuencial
        return 0
      end
      if @i_modo = 1
      begin
        select
          'No. Secuencial' = vi_secuencial,
          'Resultado Gestion' = vi_resultado,
          'Viable S/N' = vi_viable,
          'Estado Servicio' = vi_estado,
          'Ponderaci¾n' = vi_ponderacion
        from   cl_viabilidad
        where  vi_secuencial > @i_visecuencial
        order  by vi_secuencial
        return 0
      end

      --retorna error
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
      set rowcount 0

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

  if @i_operacion = 'H'
  begin
    if @t_trn = 1069
    begin
      if @i_tipo = 'A'
      begin
        select
          'No. Producto' = re_producto,
          'Tipo Persona' = re_tipo_persona,
          'Grupo Informacion' = re_grupo_info
        from   cl_referenciacion

        --retorna error
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
      --return 0
      end
      if @i_tipo = 'V'
      begin
        select
          'No. Producto' = re_producto,
          'Tipo Persona' = re_tipo_persona,
          'Grupo Informacion' = re_grupo_info
        from   cl_referenciacion
        where  re_producto     = @i_reproducto
           and re_tipo_persona = @i_retip_persona
           and re_grupo_info   = @i_regrupo_inf

        --retorna error
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
      end
      return 0
    end
    else if @t_trn = 1073
    begin
      if @i_tipo = 'A'
      begin
        set rowcount 20
        if @i_modo = 0
        begin
          select
            'No. Secuencial' = vi_secuencial,
            'Resultado Gestion' = vi_resultado
          from   cl_viabilidad
          order  by vi_secuencial
          return 0
        end
        if @i_modo = 1
        begin
          select
            'No. Secuencial' = vi_secuencial,
            'Resultado Gestion' = vi_resultado
          from   cl_viabilidad
          where  vi_secuencial > @i_visecuencial
          order  by vi_secuencial
          return 0
        end
        --retorna error
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
      end
      if @i_tipo = 'V'
      begin
        select
          'No. Secuencial' = vi_secuencial,
          'Resultado Gestion' = vi_resultado
        from   cl_viabilidad
        where  vi_secuencial = @i_visecuencial
           and vi_resultado  = @i_viresultado
      end
      if @i_tipo = 'W'
      begin
        if @i_viresultado is null
        begin
          select
            vi_resultado,
            b.valor,
            vi_viable
          from   cobis..cl_tabla a,
                 cobis..cl_catalogo b,
                 cl_viabilidad
          where  a.tabla  = 'cl_resultado_gestion'
             and b.tabla  = a.codigo
             and b.codigo = vi_resultado
        end
        else
        begin
          select
            b.valor,
            vi_resultado,
            vi_viable
          from   cobis..cl_tabla a,
                 cobis..cl_catalogo b,
                 cl_viabilidad
          where  a.tabla      = 'cl_resultado_gestion'
             and b.tabla      = a.codigo
             and b.codigo     = vi_resultado
             and vi_resultado = @i_viresultado
        end
      end
      set rowcount 0
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

