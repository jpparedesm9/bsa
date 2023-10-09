/**************************************************************************/
/*  Archivo:            cl_restri.sp                                      */
/*  Stored procedure:   sp_restrictivas                                   */
/*  Base de datos:      cobis                                             */
/*  Producto:       Clientes                                              */
/*  Disenado por:   Lorena Regalado.                                      */
/*  Fecha de escritura: 28-Dic-2009                                       */
/**************************************************************************/
/*              IMPORTANTE                                                */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*  de 'COBISCorp'.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*  Este programa esta protegido por la ley de   derechos de autor        */
/*  y por las    convenciones  internacionales   de  propiedad inte-      */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*  penalmente a los autores de cualquier   infraccion.                   */
/**************************************************************************/
/*              PROPOSITO                                                 */
/*  Este stored procedure procesa:                                        */
/*  Insert y Update de datos de Ref. Inhibitorias Sarlaft                 */
/*  Query de nombre completo de persona                                   */
/**************************************************************************/
/*              MODIFICACIONES                                            */
/*  FECHA       AUTOR       RAZON                                         */
/*  28/Dic/09   L.Regalado.    Emision Inicial                            */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/**************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_restrictivas')
  drop proc sp_restrictivas
go

create proc sp_restrictivas
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_modo         tinyint = null,
  @i_tipo         char(1) = 'N',
  @i_codigo       int = null,
  @i_codigolis    int = null,
  @i_ced_ruc      char(13) = null,
  @i_nombre       char(37) = null,
  @i_documento    int = null,
  @i_origen       catalogo = null,
  @i_observacion  varchar(255) = null,
  @i_fechamod     datetime = null,
  @i_fecharef     datetime = null,
  @i_p_apellido   varchar(16) = null,
  @i_s_apellido   varchar(16) = null,
  @i_tipo_ced     char(2) = null,
  @i_tipo_cli     char(1) = null,
  @i_estadori     catalogo = null,
  @i_sexo         char(1) = null,
  @o_codigo_sig   int = null out
)
as
  declare
    @w_today        datetime,
    @w_sp_name      varchar(32),
    @w_return       int,
    @w_estado       char(1),
    @w_codigo       int,
    @w_ced_ruc      char(13),
    @w_catalogo     char(10),
    @w_nombre       varchar(37),
    @w_documento    int,
    @w_origen       catalogo,
    @w_estadori     catalogo,
    @w_observacion  varchar(255),
    @w_fechamod     datetime,
    @w_fecharef     datetime,
    @w_p_apellido   varchar(16),
    @w_s_apellido   varchar(16),
    @w_tipo_ced     char(2),
    @w_tipo_cli     char(1),
    @v_codigo       int,
    @v_ced_ruc      char(13),
    @v_nombre       varchar(37),
    @v_documento    int,
    @v_origen       catalogo,
    @v_estadori     catalogo,
    @v_observacion  char(80),
    @v_fechamod     datetime,
    @v_fecharef     datetime,
    @v_p_apellido   varchar(16),
    @v_s_apellido   varchar(16),
    @v_tipo_ced     char(2),
    @v_tipo_cli     char(1),
    @w_nomlar       char (64),
    @w_contador     int,
    @w_sexo         char(1),
    @v_sexo         char(1),
    @w_descripcion  varchar(37),
    @w_parlista     varchar(10),
    @w_cod_tabla    smallint,
    @w_cod_tablaes  smallint,
    @w_cathom       varchar(25),
    @w_contador_doc int,
    @w_contador_nom int,
    @w_ente         int

  select
    @w_today = getdate()
  select
    @w_sp_name = 'sp_restrictivas'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_operacion in ('I', 'U', 'D')
    if @i_tipo_cli != 'C'
       and @i_tipo_cli != 'P'
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101114
      /* parametro invalido */
      return 1
    end

  if @i_tipo_cli = 'C'
    select
      @w_nomlar = ltrim (@i_nombre)
  else
    select
      @w_nomlar = @i_p_apellido + ' ' + @i_s_apellido + ' ' + @i_nombre

  --identificar parametro listas restrictivas
  select
    @w_parlista = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'LRES'

  select
    @w_cod_tabla = codigo
  from   cl_tabla
  where  tabla = 'cl_refinh_sarlaft'
  select
    @w_cod_tablaes = codigo
  from   cl_tabla
  where  tabla = 'cl_estado_refinh_sarlaft'

  /* Insert */
  if @i_operacion = 'I'
  begin
    begin tran
    if @t_trn = 1036
    begin
      select
        @w_codigo = in_codigo
      from   cobis..cl_refinh
      where  in_entid = @i_codigolis

      if @@rowcount > 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101168
        --   Ya existe mala referencia
        return 1
      end

      exec sp_cseqnos
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_tabla    = 'cl_refinh',
        @o_siguiente= @o_codigo_sig out
      /* verificar el origen de la referencia */
      select
        @w_catalogo = convert(char(10), @i_origen)
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_operacion = 'E',
        @i_tabla     = 'cl_refinh_sarlaft',
        @i_codigo    = @w_catalogo
      if @w_return != 0
      begin
        /* 'No existe Referencia Inhibitoria'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101131
        return 1
      end
      /* verificar el estado de la referencia */
      select
        @w_catalogo = convert(char(10), @i_estadori)

      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_operacion = 'E',
        @i_tabla     = 'cl_estado_refinh_sarlaft',
        @i_codigo    = @w_catalogo
      if @w_return != 0
      begin
        /* 'No existe Referencia Inhibitoria'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101131
        return 1
      end

      /* Insertar un nuevo registro */
      insert into cl_refinh
                  (in_codigo,in_ced_ruc,in_nombre,in_documento,in_origen,
                   in_observacion,in_fecha_mod,in_fecha_ref,in_subtipo,
                   in_p_p_apellido
                   ,
                   in_p_s_apellido,in_tipo_ced,in_nomlar,in_estado,
                   in_sexo,
                   in_entid)
      values      (@o_codigo_sig,@i_ced_ruc,@i_nombre,@i_documento,@i_origen,
                   @i_observacion,@w_today,@i_fecharef,@i_tipo_cli,@i_p_apellido
                   ,
                   @i_s_apellido,@i_tipo_ced,@w_nomlar,
                   @i_estadori,@i_sexo,
                   @i_codigolis)
      /* Si no se puede insertar enviar error*/
      if @@error != 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 903001
        return 1
      end

      select
        @w_contador = isnull(count(0),
                             0)
      from   cobis..cl_refinh
      where  in_tipo_ced = @i_tipo_ced
         and in_ced_ruc  = @i_ced_ruc

      update cl_ente
      set    en_mala_referencia = 'S',
             en_cont_malas = @w_contador
      where  en_tipo_ced = @i_tipo_ced
         and en_ced_ruc  = @i_ced_ruc

      if @@rowcount = 0
      begin
        print 'CLIENTE NO SE ENCUENTRA EN LA B.D.'
      end

      /*Transaccion de Servicio*/
      insert into ts_refinh
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ced_ruc,nombre,
                   fecha_ref,origen,observacion,codigo,documento,
                   fecha_mod,p_apellido,s_apellido,tipo_ced,ref_estado)
      values      ( @s_ssn,@t_trn,'N',getdate(),@s_user,
                    @s_term,@s_srv,@s_lsrv,@i_ced_ruc,@i_nombre,
                    @i_fecharef,@i_origen,@i_observacion,@o_codigo_sig,
                    @i_documento,
                    @w_today,@i_p_apellido,@i_s_apellido,@i_tipo_ced,@i_estadori
      )

      /* Si no puede insertar , enviar el error*/
      if @@error != 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 903002
        return 1
      end
    end
    else
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
    commit tran
  end

  /* Update */
  if @i_operacion = 'U'
  begin
    if @t_trn != 1037
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
    else
    begin
      /* verificar el origen de la referencia */
      select
        @w_catalogo = convert(char(10), @i_origen)
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_operacion = 'E',
        @i_tabla     = 'cl_refinh_sarlaft',
        @i_codigo    = @w_catalogo
      if @w_return != 0
      begin
        /* 'No existe Referencia Inhibitoria'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101131
        return 1
      end

      /* verificar el estado de la referencia */

      select
        @w_catalogo = convert(char(10), @i_estadori)

      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_operacion = 'E',
        @i_tabla     = 'cl_estado_refinh_sarlaft',
        @i_codigo    = @w_catalogo
      if @w_return != 0
      begin
        /* 'No existe Referencia Inhibitoria'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101131
        return 1
      end

      /* Seleccionar campos de la tabla */
      select
        @w_codigo = in_codigo,
        @w_ced_ruc = in_ced_ruc,
        @w_nombre = in_nombre,
        @w_documento = in_documento,
        @w_origen = in_origen,
        @w_observacion = in_observacion,
        @w_fechamod = in_fecha_mod,
        @w_fecharef = convert (char(10), in_fecha_ref, 101),
        @w_p_apellido = in_p_p_apellido,
        @w_s_apellido = in_p_s_apellido,
        @w_tipo_ced = in_tipo_ced,
        @w_tipo_cli = in_subtipo,
        @w_estadori = in_estado,
        @w_sexo = in_sexo
      from   cl_refinh,
             cobis..cl_tabla x,
             cobis..cl_catalogo y --LRE 05/Ene/2010
      where  in_codigo = @i_codigo
         and x.tabla   = 'cl_refinh_sarlaft' --LRE 05/Ene/2010
         and x.codigo  = y.tabla --LRE 05/Ene/2010
         and y.estado  = 'V' --LRE 05/Ene/2010
         and in_origen = y.codigo --LRE 05/Ene/2010

      if @@rowcount = 0
      begin
        /* No existe dato solicitado */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101130 -- No existe mala referencia
        return 1
      end
      select
        @v_codigo = @w_codigo,
        @v_ced_ruc = @w_ced_ruc,
        @v_nombre = @w_nombre,
        @v_documento = @w_documento,
        @v_origen = @w_origen,
        @v_observacion = @w_observacion,
        @v_fechamod = @w_fechamod,
        @v_fecharef = @w_fecharef,
        @v_p_apellido = @w_p_apellido,
        @v_s_apellido = @w_s_apellido,
        @v_tipo_ced = @w_tipo_ced,
        @v_tipo_cli = @w_tipo_cli,
        @v_estadori = @w_estadori,
        @v_sexo = @w_sexo

      if @w_ced_ruc = @i_ced_ruc
        select
          @w_ced_ruc = null,
          @v_ced_ruc = null
      else
        select
          @w_ced_ruc = @i_ced_ruc

      if @w_nombre = @i_nombre
        select
          @w_nombre = null,
          @v_nombre = null
      else
        select
          @w_nombre = @i_nombre

      if @w_documento = @i_documento
        select
          @w_documento = null,
          @v_documento = null
      else
        select
          @w_documento = @i_documento

      if @w_origen = @i_origen
        select
          @w_origen = null,
          @v_origen = null
      else
        select
          @w_origen = @i_origen

      if @w_estadori = @i_estadori
        select
          @w_estadori = null,
          @v_estadori = null
      else
        select
          @w_estadori = @i_estadori

      if @w_observacion = @i_observacion
        select
          @w_observacion = null,
          @v_observacion = null
      else
        select
          @w_observacion = @i_observacion
      if @w_fechamod = @w_today
        select
          @w_fechamod = null,
          @v_fechamod = null
      else
        select
          @w_fechamod = @w_today

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
      if @w_tipo_ced = @i_tipo_ced
        select
          @w_tipo_ced = null,
          @v_tipo_ced = null
      else
        select
          @w_tipo_ced = @i_tipo_ced

      begin tran
      /* Actualizar el registro */
      update cl_refinh
      set    in_documento = @i_documento,
             in_ced_ruc = @i_ced_ruc,
             in_nombre = @i_nombre,
             in_origen = @i_origen,
             in_observacion = @i_observacion,
             in_fecha_mod = @w_today,
             in_fecha_ref = @i_fecharef,
             in_p_p_apellido = @i_p_apellido,
             in_p_s_apellido = @i_s_apellido,
             in_tipo_ced = @i_tipo_ced,
             in_nomlar = @w_nomlar,
             in_estado = @i_estadori,
             in_sexo = @i_sexo
      where  in_codigo = @i_codigo

      if @@rowcount != 1
      begin
        /* Error en actualizacion de registro covinco*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 905001
        return 1
      end

      /*transaccion de servicios (registro previo*/
      insert into ts_refinh
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ced_ruc,nombre,
                   fecha_ref,origen,observacion,codigo,documento,
                   fecha_mod,p_apellido,s_apellido,tipo_ced,ref_estado)
      values      ( @s_ssn,@t_trn,'P',getdate(),@s_user,
                    @s_term,@s_srv,@s_lsrv,@v_ced_ruc,@v_nombre,
                    null,@v_origen,@v_observacion,@i_codigo,@v_documento,
                    @v_fechamod,@v_p_apellido,@v_s_apellido,@v_tipo_ced,
                    @v_estadori
      )

      if @@error != 0
      begin
        /* Error en creacion de transaccion de servicios  covinco*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 903002
        return 1
      end

      /*transaccion de servicios (registro actual)*/
      insert into ts_refinh
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ced_ruc,nombre,
                   fecha_ref,origen,observacion,codigo,documento,
                   fecha_mod,p_apellido,s_apellido,tipo_ced,ref_estado)
      values      ( @s_ssn,@t_trn,'A',getdate(),@s_user,
                    @s_term,@s_srv,@s_lsrv,@w_ced_ruc,@w_nombre,
                    null,@w_origen,@w_observacion,@i_codigo,@w_documento,
                    @w_fechamod,@w_p_apellido,@w_s_apellido,@w_tipo_ced,
                    @w_estadori
      )

      if @@error != 0
      begin
        /* Error en creacion de transaccion de servicios  covinco*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 903002
        return 1
      end
      commit tran
      return 0
    end
  end

  /* Delete */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1038
    begin
      /* Valores para transaccion de Servicios*/
      select
        @w_codigo = in_codigo,
        @w_ced_ruc = in_ced_ruc,
        @w_nombre = in_nombre,
        @w_documento = in_documento,
        @w_origen = in_origen,
        @w_observacion = in_observacion,
        @w_fechamod = in_fecha_mod,
        @w_fecharef = in_fecha_ref,
        @w_p_apellido = in_p_p_apellido,
        @w_s_apellido = in_p_s_apellido,
        @w_tipo_ced = in_tipo_ced,
        @w_estadori = in_estado,
        @w_sexo = in_sexo,
        @w_nomlar = in_nomlar,
        @w_cathom = isnull(in_categoria,
                           in_ced_ruc)
      from   cl_refinh,
             cobis..cl_tabla x,
             cobis..cl_catalogo y --LRE 05/Ene/2010
      where  in_codigo = @i_codigo
         and x.tabla   = 'cl_refinh_sarlaft'
         and x.codigo  = y.tabla
         and y.estado  = 'V'
         and in_origen = y.codigo

      /* Si no existe registro a borrar, error */
      if @@rowcount = 0
      begin
        /* Error no existe registro  */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101130 --No existe mala referencia
        return 1
      end

      if @w_documento = 99
      begin
        /* Error no existe registro  */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 208107 --NO SE PUEDE ELIMINAR REGISTRO
        return 1
      end

      begin tran

      select
        @w_ente = isnull(en_ente,
                         0)
      from   cobis..cl_ente
      where  en_ced_ruc = @w_cathom

      if @w_ente > 0
      begin
        if not exists (select
                         1
                       from   cobis..cl_lista_exonerados
                       where  le_ente = @w_ente)
        begin
          /*si no xiste un rgistro vigente ingresar el actul clienete*/

          insert into cobis..cl_lista_exonerados
                      (le_ente,le_tipo_ced,le_ced_ruc,le_nombre,le_fecha_marc,
                       le_fecha_desm,le_estado,le_observacion,le_modo_origen,
                       le_obs_exoneracion)
          values      ( @w_ente,@w_tipo_ced,@w_cathom,@w_nomlar,getdate(),
                        getdate(),'E','EXONERACION POR HOMONIMIA',@w_codigo,
                        @s_user
          )

          if @@error != 0
          begin
            /* Error inserci«n de regisros */
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 203042
            return 1
          end

        end --exist
      end --ente > 0

      /* Eliminar el registro */
      delete from cl_refinh
      where  in_codigo = @i_codigo

      /* Si no se puede eliminar enviar error*/
      if @@error != 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 907001
        return 1
      end

      select
        @w_contador_nom = 0
      select
        @w_contador_nom = isnull(count(0),
                                 0)
      from   cobis..cl_refinh
      where  in_categoria = @w_cathom

      select
        @w_contador_doc = 0
      select
        @w_contador_doc = isnull(count(0),
                                 0)
      from   cobis..cl_refinh
      where  in_ced_ruc = @w_cathom

      select
        @w_contador = @w_contador_nom + @w_contador_doc

      if @w_contador_nom > 0
      begin
        update cobis..cl_ente
        set    en_mala_referencia = 'S',
               en_cont_malas = @w_contador
        where  en_ced_ruc = @w_cathom
      end

      if @w_contador_nom = 0
         and @w_contador_doc = 0
      begin
        update cobis..cl_ente
        set    en_mala_referencia = 'N',
               en_cont_malas = @w_contador_nom
        where  en_ced_ruc = @w_cathom
      end

    /***desmarcar en cl_ente en_mala_referencia ****/
      /*transaccion de servicios (eliminacion )*/

      insert into ts_refinh
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ced_ruc,nombre,
                   fecha_ref,origen,observacion,codigo,documento,
                   fecha_mod,p_apellido,s_apellido,tipo_ced,ref_estado)
      values      ( @s_ssn,@t_trn,'B',getdate(),@s_user,
                    @s_term,@s_srv,@s_lsrv,@w_ced_ruc,@w_nombre,
                    @w_fecharef,@w_origen,@w_observacion,@i_codigo,@w_documento,
                    @w_fechamod,@w_p_apellido,@w_s_apellido,@w_tipo_ced,
                    @w_estadori
      )

      if @@error != 0
      begin
        /*Error en creacion de transaccion de servicios */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 903002
        return 1
      end
      commit tran
    end
    else
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  /* Search */
  if @i_operacion = 'S'
  begin
    if @t_trn != 1039
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
    if @i_tipo = 'C' /*BUSQUEDA POR NUMERO DE DOCUMENTO*/
    begin
      if @i_modo = 0
      begin
        select
          'Tipo Doc. ' = in_tipo_ced,
          'No. Documento ID/NIT' = in_ced_ruc,
          'Nombre o Razon Social' = substring(in_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(in_p_s_apellido,
                                   1,
                                   25),
          'Fecha Ref' = convert (varchar(10), in_fecha_ref, 101),
          'Origen' = in_origen,
          'Fecha Mod' = convert(varchar (10), in_fecha_mod, 101),
          'Observacion' = in_observacion,
          'Codigo' = in_codigo,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.in_origen
                                     and tabla  = @w_cod_tabla)
        from   cl_refinh a,
               cobis..cl_tabla x,
               cobis..cl_catalogo y
        where  in_ced_ruc like ltrim(rtrim( @i_ced_ruc)) + '%'
           and x.tabla     = 'cl_refinh_sarlaft'
           and x.codigo    = y.tabla
           and y.estado    = 'V'
           and a.in_origen = y.codigo
           and a.in_origen in
               (select
                  ms_origen
                from   cobis..cl_manejo_sarlaft
                where  ms_restrictiva = @w_parlista)
        order  by in_ced_ruc
      end
      else
      begin
        if @i_modo = 1
          select
            'Tipo Doc. ' = in_tipo_ced,
            'No. Documento ID/NIT' = in_ced_ruc,
            'Nombre o Razon Social' = substring(in_nombre,
                                                1,
                                                25),
            'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                               1,
                                               25),
            'S.Apellido' = substring(in_p_s_apellido,
                                     1,
                                     25),
            'Fecha Ref' = convert(char(10), in_fecha_ref, 101),
            'Origen' = in_origen,
            'Fecha Mod' = convert(char(10), in_fecha_mod, 101),
            'Observacion' = in_observacion,
            'Codigo' = in_codigo,
            'Descripcion Origen' = (select
                                      valor
                                    from   cl_catalogo
                                    where  codigo = a.in_origen
                                       and tabla  = @w_cod_tabla)
          from   cl_refinh a,
                 cobis..cl_tabla x,
                 cobis..cl_catalogo y
          where  in_ced_ruc  > @i_ced_ruc
             and x.tabla     = 'cl_refinh_sarlaft'
             and x.codigo    = y.tabla
             and y.estado    = 'V'
             and a.in_origen = y.codigo
             and a.in_origen in
                 (select
                    ms_origen
                  from   cobis..cl_manejo_sarlaft
                  where  ms_restrictiva = @w_parlista)
          order  by in_ced_ruc
        else
          select
            'Tipo Doc. ' = in_tipo_ced,
            'No. Documento ID/NIT' = in_ced_ruc,
            'Nombre o Razon Social' = substring(in_nombre,
                                                1,
                                                25),
            'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                               1,
                                               25),
            'S.Apellido' = substring(in_p_s_apellido,
                                     1,
                                     25),
            'Fecha Ref' = convert (varchar(10), in_fecha_ref, 101),
            'Origen' = in_origen,
            'Fecha Mod' = convert(varchar (10), in_fecha_mod, 101),
            'Observacion' = in_observacion,
            'Codigo' = in_codigo,
            'Descripcion Origen' = (select
                                      valor
                                    from   cl_catalogo
                                    where  codigo = a.in_origen
                                       and tabla  = @w_cod_tabla)
          from   cl_refinh a,
                 cobis..cl_tabla x,
                 cobis..cl_catalogo y
          where  in_ced_ruc  = @i_ced_ruc
             and x.tabla     = 'cl_refinh_sarlaft'
             and x.codigo    = y.tabla
             and y.estado    = 'V'
             and a.in_origen = y.codigo
             and a.in_origen in
                 (select
                    ms_origen
                  from   cobis..cl_manejo_sarlaft
                  where  ms_restrictiva = @w_parlista)--y.codigo
          order  by in_ced_ruc --, in_codigo

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

    if @i_tipo = 'L'
    begin --tipo R /*BUSQUEDA POR CODIGO LISTA */
      if @i_modo = 0
      begin
        select
          'Tipo Doc. ' = in_tipo_ced,
          'No. Documento ID/NIT' = in_ced_ruc,
          'Nombre o Razon Social' = substring(in_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(in_p_s_apellido,
                                   1,
                                   25),
          'Fecha Ref' = convert(varchar(10), in_fecha_ref, 101),
          'Origen' = in_origen,
          'Fecha Mod' = convert(varchar(10), in_fecha_mod, 101),
          'Observacion' = in_observacion,
          'Codigo' = in_codigo,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.in_origen
                                     and tabla  = @w_cod_tabla),
          'Codigo Lista' = in_entid
        from   cl_refinh a,
               cobis..cl_tabla x,
               cobis..cl_catalogo y
        where  in_entid    >= isnull(@i_codigolis,
                                     0)
           and x.tabla     = 'cl_refinh_sarlaft'
           and x.codigo    = y.tabla
           and y.estado    = 'V'
           and a.in_origen = y.codigo
           and a.in_origen in
               (select
                  ms_origen
                from   cobis..cl_manejo_sarlaft
                where  ms_restrictiva = @w_parlista)--y.codigo
        order  by in_entid
      end
      else if @i_modo = 1
      begin
        select
          'Tipo Doc. ' = in_tipo_ced,
          'No. Documento ID/NIT' = in_ced_ruc,
          'Nombre o Razon Social' = substring(in_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(in_p_s_apellido,
                                   1,
                                   25),
          'Fecha Ref' = convert(varchar(10), in_fecha_ref, 101),
          'Origen' = in_origen,
          'Fecha Mod' = convert(varchar(10), in_fecha_mod, 101),
          'Observacion' = in_observacion,
          'Codigo' = in_codigo,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.in_origen
                                     and tabla  = @w_cod_tabla),
          'Codigo Lista' = in_entid
        from   cl_refinh a,
               cobis..cl_tabla x,
               cobis..cl_catalogo y
        where  in_entid    > @i_codigolis
           and x.tabla     = 'cl_refinh_sarlaft'
           and x.codigo    = y.tabla
           and y.estado    = 'V'
           and a.in_origen = y.codigo
           and a.in_origen in
               (select
                  ms_origen
                from   cobis..cl_manejo_sarlaft
                where  ms_restrictiva = @w_parlista)--y.codigo
        order  by in_entid
      end
      else
      begin
        select
          'Tipo Doc. ' = in_tipo_ced,
          'No. Documento ID/NIT' = in_ced_ruc,
          'Nombre o Razon Social' = substring(in_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(in_p_s_apellido,
                                   1,
                                   25),
          'Fecha Ref' = convert(varchar(10), in_fecha_ref, 101),
          'Origen' = in_origen,
          'Fecha Mod' = convert(varchar(10), in_fecha_mod, 101),
          'Observacion' = in_observacion,
          'Codigo' = in_codigo,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.in_origen
                                     and tabla  = @w_cod_tabla),
          'Codigo Lista' = in_entid
        from   cl_refinh a,
               cobis..cl_tabla x,
               cobis..cl_catalogo y
        where  in_entid    = @i_codigolis
           and x.tabla     = 'cl_refinh_sarlaft'
           and x.codigo    = y.tabla
           and y.estado    = 'V'
           and a.in_origen = y.codigo
           and a.in_origen in
               (select
                  ms_origen
                from   cobis..cl_manejo_sarlaft
                where  ms_restrictiva = @w_parlista)--y.codigo
        order  by in_entid

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
    begin --tipo N /*BUSQUEDA POR NOMBRE */
      if @i_modo = 0
      begin
        select
          'Tipo Doc. ' = in_tipo_ced,
          'No. Documento ID/NIT' = in_ced_ruc,
          'Nombre o Razon Social' = substring(in_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(in_p_s_apellido,
                                   1,
                                   25),
          'Fecha Ref' = convert(varchar(10), in_fecha_ref, 101),
          'Origen' = in_origen,
          'Fecha Mod' = convert(varchar(10), in_fecha_mod, 101),
          'Observacion' = in_observacion,
          'Codigo' = in_codigo,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.in_origen
                                     and tabla  = @w_cod_tabla)
        from   cl_refinh a,
               cobis..cl_tabla x,
               cobis..cl_catalogo y
        where  in_nomlar like ltrim(rtrim(@i_nombre)) + '%'
           and x.tabla     = 'cl_refinh_sarlaft'
           and x.codigo    = y.tabla
           and y.estado    = 'V'
           and a.in_origen = y.codigo
           and a.in_origen = y.codigo
           and a.in_origen in
               (select
                  ms_origen
                from   cobis..cl_manejo_sarlaft
                where  ms_restrictiva = @w_parlista)--y.codigo
        order  by in_nomlar --, in_codigo
      end
      else if @i_modo = 1
      begin
        select
          'Tipo Doc. ' = in_tipo_ced,
          'No. Documento ID/NIT' = in_ced_ruc,
          'Nombre o Razon Social' = substring(in_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(in_p_s_apellido,
                                   1,
                                   25),
          'Fecha Ref' = convert(varchar(10), in_fecha_ref, 101),
          'Origen' = in_origen,
          'Fecha Mod' = convert(varchar(10), in_fecha_mod, 101),
          'Observacion' = in_observacion,
          'Codigo' = in_codigo,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.in_origen
                                     and tabla  = @w_cod_tabla)
        from   cl_refinh a,
               cobis..cl_tabla x,
               cobis..cl_catalogo y
        where  in_nomlar   > @i_nombre
           and x.tabla     = 'cl_refinh_sarlaft'
           and x.codigo    = y.tabla
           and y.estado    = 'V'
           and a.in_origen = y.codigo
           and a.in_origen in
               (select
                  ms_origen
                from   cobis..cl_manejo_sarlaft
                where  ms_restrictiva = @w_parlista)--y.codigo
        order  by in_nomlar
      end
      else
      begin
        select
          'Tipo Doc. ' = in_tipo_ced,
          'No. Documento ID/NIT' = in_ced_ruc,
          'Nombre o Razon Social' = substring(in_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(in_p_s_apellido,
                                   1,
                                   25),
          'Fecha Ref' = convert(varchar(10), in_fecha_ref, 101),
          'Origen' = in_origen,
          'Fecha Mod' = convert(varchar(10), in_fecha_mod, 101),
          'Observacion' = in_observacion,
          'Codigo' = in_codigo,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.in_origen
                                     and tabla  = @w_cod_tabla)
        from   cl_refinh a,
               cobis..cl_tabla x,
               cobis..cl_catalogo y
        where  in_nomlar   = @i_nombre
           and x.tabla     = 'cl_refinh_sarlaft'
           and x.codigo    = y.tabla
           and y.estado    = 'V'
           and a.in_origen = y.codigo
           and a.in_origen in
               (select
                  ms_origen
                from   cobis..cl_manejo_sarlaft
                where  ms_restrictiva = @w_parlista)--y.codigo
        order  by in_nomlar

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

/** QUERY **/
  /*Consulta para actualizar archivo de Referencias Inhibitorias */

  if @i_operacion = 'Q'
  begin
    if @t_trn != 1040
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
    else
    begin
      select distinct
        @w_descripcion = cl_catalogo.valor
      from   cl_catalogo,
             cl_tabla,
             cl_refinh
      where  cl_tabla.tabla      = 'cl_estado_refinh_sarlaft'
         and cl_catalogo.tabla   = cl_tabla.codigo
         and cl_catalogo.codigo  = cl_refinh.in_estado
         and cl_refinh.in_codigo = @i_codigo

      select
        'No. Documento ID/NIT' = isnull(in_ced_ruc,
                                        ''),
        'Nombre o Razon Social' = substring(in_nombre,
                                            1,
                                            25),
        'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                           1,
                                           25),
        'S.Apellido' = substring(in_p_s_apellido,
                                 1,
                                 25),
        'Fecha_Ref' = convert(varchar(10), in_fecha_ref, 101),
        'Origen' = in_origen,
        'Fecha_Mod' = convert(varchar(10), in_fecha_mod, 101),
        'Observacion' = in_observacion,
        'Codigo' = in_codigo,
        'Tipo Cliente' = in_subtipo,
        'Tipo D.I.' = isnull(in_tipo_ced,
                             ''),
        'Descripcion Origen' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.in_origen
                                   and tabla  = @w_cod_tabla),
        'Estado ' = in_estado,
        'Descripcion Estado' = @w_descripcion,
        'Sexo' = in_sexo,
        'Codigo Lista' = in_entid
      from   cl_refinh a,
             cobis..cl_tabla x,
             cobis..cl_catalogo y
      where  in_codigo   = @i_codigo
         and x.tabla     = 'cl_refinh_sarlaft'
         and x.codigo    = y.tabla
         and y.estado    = 'V'
         and a.in_origen = y.codigo
         and a.in_origen in
             (select
                ms_origen
              from   cobis..cl_manejo_sarlaft
              where  ms_restrictiva = @w_parlista)--y.codigo
      return 0
    end
  end

  --catalogo origen F5
  if @i_operacion = 'A'
  begin
    if @t_trn != 1039
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
    if @i_modo = 0
    begin
      select distinct
        'CODIGO' = ms_origen,
        'DESCRIPCION' = (select
                           valor
                         from   cl_catalogo
                         where  codigo = a.ms_origen
                            and tabla  = @w_cod_tabla)
      from   cobis..cl_manejo_sarlaft a,
             cobis..cl_tabla x,
             cobis..cl_catalogo y
      where  ms_restrictiva = @w_parlista
         and x.tabla        = 'cl_refinh_sarlaft'
         and x.codigo       = y.tabla
         and y.estado       = 'V'
         and a.ms_origen    = y.codigo
    end
    else
    begin
      select
        'CODIGO' = ms_origen,
        'DESCRIPCION' = (select
                           valor
                         from   cl_catalogo
                         where  codigo = a.ms_origen
                            and tabla  = @w_cod_tabla),
        'ESTADO' = ms_estado,
        'SEC INTERNO' = ms_secuencial
      from   cobis..cl_manejo_sarlaft a,
             cobis..cl_tabla x,
             cobis..cl_catalogo y
      where  ms_restrictiva = @w_parlista
         and ms_secuencial  = @i_codigo
         and ms_restrictiva = @w_parlista
         and x.tabla        = 'cl_refinh_sarlaft'
         and x.codigo       = y.tabla
         and y.estado       = 'V'
      order  by ms_secuencial
    end
    set rowcount 0
    return 0
  end

  --catalogo estado F5
  if @i_operacion = 'B'
  begin
    if @t_trn != 1039
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
    if @i_modo = 0
    begin
      select
        'CODIGO' = ms_estado,
        'DESCRIPCION' = (select
                           valor
                         from   cl_catalogo
                         where  codigo = a.ms_estado
                            and tabla  = @w_cod_tablaes)
      from   cobis..cl_manejo_sarlaft a,
             cobis..cl_tabla x,
             cobis..cl_catalogo y
      where  ms_restrictiva = @w_parlista
         and ms_origen      = @i_origen
         and x.tabla        = 'cl_estado_refinh_sarlaft'
         and x.codigo       = y.tabla
         and y.estado       = 'V'
         and a.ms_origen    = y.codigo
    end
    else
    begin
      select
        'CODIGO' = ms_estado,
        'DESCRIPCION' = (select
                           valor
                         from   cl_catalogo
                         where  codigo = a.ms_estado
                            and tabla  = @w_cod_tablaes)
      from   cobis..cl_manejo_sarlaft a,
             cobis..cl_tabla x,
             cobis..cl_catalogo y
      where  ms_restrictiva = @w_parlista
         and x.tabla        = 'cl_estado_refinh_sarlaft'
         and x.codigo       = y.tabla
         and y.estado       = 'V'
         and ms_secuencial  = @i_codigo
         and ms_origen      = @i_origen
      order  by ms_secuencial
    end
    set rowcount 0
    return 0
  end

  --descripcion lost focus de estado
  if @i_operacion = 'V'
  begin
    if @t_trn != 1039
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

    select
      'DESCRIPCION' = (select
                         valor
                       from   cl_catalogo
                       where  codigo = a.ms_estado
                          and tabla  = @w_cod_tablaes)
    from   cobis..cl_manejo_sarlaft a,
           cobis..cl_tabla x,
           cobis..cl_catalogo y
    where  ms_restrictiva = @w_parlista
       and ms_origen      = @i_origen
       and ms_estado      = @i_estadori
       and x.tabla        = 'cl_estado_refinh_sarlaft'
       and x.codigo       = y.tabla
       and y.estado       = 'V'
       and a.ms_origen    = y.codigo

    return 0
  end

  --descripcion lost focus de origen
  if @i_operacion = 'W'
  begin
    if @t_trn != 1039
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

    select
      'DESCRIPCION' = (select
                         valor
                       from   cl_catalogo
                       where  codigo = a.ms_origen
                          and tabla  = @w_cod_tabla)
    from   cobis..cl_manejo_sarlaft a,
           cobis..cl_tabla x,
           cobis..cl_catalogo y
    where  ms_restrictiva = @w_parlista
       and ms_origen      = @i_origen
       and x.tabla        = 'cl_refinh_sarlaft'
       and x.codigo       = y.tabla
       and y.estado       = 'V'
       and a.ms_origen    = y.codigo

    return 0
  end

go

