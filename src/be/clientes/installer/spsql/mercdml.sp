/************************************************************************/
/*  Archivo:            mercdml.sp                                      */
/*  Stored procedure:   sp_mercado_dml                                  */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Octavio Hoyos F.                                */
/*  Fecha de escritura: 27-Jun-1996                                     */
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
/*  Este stored procedure procesa:                                      */
/*  Insert y Update de datos de Ref. de Mercado Query nombre completo   */
/*  de persona                                                          */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  27/Jun/96   O.Hoyos.    Emision Inicial                             */
/*  09/Sep/99   R.AmarisRAAHPermitir ing. mas de una ref. para un ente  */
/*  23/Ene/2001 E.Laguna    Estado Ref. Inhibitorias/Mercado            */
/*  27/May/2001 J.Anaguano  Grabar el campo me_nomlar                   */
/*  13/Mar/2007 S. Lievano  DEFECTO 8012                                */
/*  04/May/2016 T. Baidal   Migracion a CEN                             */
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
           where  name = 'sp_mercado_dml')
    drop proc sp_mercado_dml
go

create proc sp_mercado_dml
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
  @i_ced_ruc      char(13) = null,
  @i_documento    int = null,
  @i_nombre       char(37) = null,
  @i_fecharef     datetime = null,
  @i_calificador  char(40) = null,
  @i_calificacion char(15) = null,
  @i_origen       char(40) = null,
  @i_observacion  char(80) = null,
  @i_subtipo      char(1) = null,
  @i_tipo_ced     char(2) = null,
  @i_p_apellido   varchar(16) = null,
  @i_s_apellido   varchar(16) = null,
  @i_estadorm     catalogo = null,
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
    @w_documento    int,
    @w_nombre       char(37),
    @w_fecharef     datetime,
    @w_calificador  char(40),
    @w_calificacion char(15),
    @w_origen       char(40),
    @w_estadorm     char(40),
    @w_observacion  char(80),
    @w_tipo_ced     char(2),
    @w_subtipo      char(1),
    @w_p_apellido   varchar(16),
    @w_s_apellido   varchar(16),
    @v_codigo       int,
    @v_ced_ruc      char(13),
    @v_documento    int,
    @v_nombre       char(37),
    @v_fecharef     datetime,
    @v_calificador  char(40),
    @v_calificacion char(15),
    @v_origen       char(40),
    @v_estadorm     char(40),
    @v_observacion  char(80),
    @v_tipo_ced     char(2),
    @v_subtipo      char(1),
    @v_p_apellido   varchar(16),
    @v_s_apellido   varchar(16),
    @w_nomlar       char(64),
    @w_sexo         char(1),
    @v_sexo         char(1),
    @w_fechamod     datetime

  select
    @w_sp_name = 'sp_mercado_dml'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

  if @i_subtipo != 'C'
     and @i_subtipo != 'P'
     and @i_operacion <> 'D'
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101114
    /* parametro invalido */
    return 1
  end

  if @i_subtipo = 'C'
    select
      @w_nomlar = ltrim (@i_nombre) + ' ' + @i_p_apellido
  else
    select
      @w_nomlar = @i_p_apellido + ' ' + @i_s_apellido + ' ' + @i_nombre

  /* Insert */
  if @i_operacion = 'I'
  begin
    --if exists ( select * from cl_mercado where me_codigo = @i_codigo )
    /* RAAH if exists ( select * from cl_mercado where me_ced_ruc = @i_ced_ruc
                                         and   me_tipo_ced = @i_tipo_ced)
    begin
        print ' YA EXISTE UN REGISTRO CON ESE CODIGO CON REFERENCIA DE MERCADO'
        return
    end
    */
    if @t_trn = 1285
    begin
      begin tran
      exec sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_mercado',
        @o_siguiente = @o_codigo_sig out

    /*   print 'doc %1!',@i_documento*/
      /* Insertar un nuevo registro */
      insert into cl_mercado
                  (me_codigo,me_ced_ruc,me_nombre,me_documento,me_fuente,
                   me_observacion,me_calificador,me_calificacion,me_fecha_ref,
                   me_subtipo,
                   me_tipo_ced,me_p_apellido,me_s_apellido,me_fecha_mod,
                   me_estado,
                   me_nomlar,me_sexo)
      values      ( @o_codigo_sig,@i_ced_ruc,@i_nombre,@i_documento,@i_origen,
                    @i_observacion,@i_calificador,@i_calificacion,@i_fecharef,
                    @i_subtipo,
                    @i_tipo_ced,@i_p_apellido,@i_s_apellido,@s_date,@i_estadorm,
                    @w_nomlar,@i_sexo)
      /* Si no se puede insertar enviar error */
      if @@error != 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103001
        return 1
      end

      /* actualizar en_mala_referencia de cl_ente NVR */
      update cl_ente
      set    en_mala_referencia = 'S',
             en_cont_malas = isnull(en_cont_malas, 0) + 1
      where  en_ced_ruc = @i_ced_ruc

      if @@rowcount = 0
      begin
        print 'CLIENTE AUN NO HA SIDO CREADO EN LA B.D.'
      end
    /*****/
      /* Transaccion de Servicio*/
      insert into ts_mercado
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ced_ruc,nombre,
                   fecha_ref,origen,calificador,calificacion,observacion,
                   codigo,documento,ref_estado)
      values     ( @s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ced_ruc,@i_nombre,
                   @i_fecharef,@i_origen,@i_calificador,@i_calificacion,
                   @i_observacion
                   ,
                   @i_codigo,@i_documento,@i_estadorm)

      /* Si no puede insertar , enviar el error*/
      if @@error != 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        return 1
      end
      commit tran
      return 0
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

  /* Update */
  if @i_operacion = 'U'
  begin
    if @t_trn != 1286
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
      /* Seleccionar campos de la tabla */
      select
        @w_codigo = me_codigo,
        @w_ced_ruc = me_ced_ruc,
        @w_documento = me_documento,
        @w_nombre = me_nombre,
        @w_fecharef = me_fecha_ref,
        @w_calificador = me_calificador,
        @w_calificacion = me_calificacion,
        @w_origen = me_fuente,
        @w_observacion = me_observacion,
        @w_subtipo = me_subtipo,
        @w_tipo_ced = me_tipo_ced,
        @w_p_apellido = me_p_apellido,
        @w_s_apellido = me_s_apellido,
        @w_estadorm = me_estado,
        @w_sexo = me_sexo
      from   cl_mercado
      where  me_codigo = @i_codigo

      if @@rowcount = 0
      begin
        /* No existe dato solicitado */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        return 1
      end

      select
        @v_codigo = @w_codigo,
        @v_ced_ruc = @w_ced_ruc,
        @v_documento = @w_documento,
        @v_nombre = @w_nombre,
        @v_fecharef = @w_fecharef,
        @v_calificador = @w_calificador,
        @v_calificacion = @w_calificacion,
        @v_origen = @w_origen,
        @v_observacion = @w_observacion,
        @v_tipo_ced = @w_tipo_ced,
        @v_subtipo = @w_subtipo,
        @v_p_apellido = @w_p_apellido,
        @v_s_apellido = @w_s_apellido,
        @v_estadorm = @w_estadorm,
        @v_sexo = @w_sexo

      if @w_codigo = @i_codigo
        select
          @w_codigo = null,
          @v_codigo = null
      else
        select
          @w_codigo = @i_codigo

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

      /*ELA ENE/2001*/

      if @w_estadorm = @i_estadorm
        select
          @w_estadorm = null,
          @v_estadorm = null
      else
        select
          @w_estadorm = @i_estadorm

      /*ELA ENE/2001*/

      if @w_observacion = @i_observacion
        select
          @w_observacion = null,
          @v_observacion = null
      else
        select
          @w_observacion = @i_observacion

      if @w_calificador = @i_calificador
        select
          @w_calificador = null,
          @v_calificador = null
      else
        select
          @w_calificador = @i_calificador

      if @w_calificacion = @i_calificacion
        select
          @w_calificacion = null,
          @v_calificacion = null
      else
        select
          @w_calificacion = @i_calificacion

      if @w_fecharef = @i_fecharef
        select
          @w_fecharef = null,
          @v_fecharef = null
      else
        select
          @w_fecharef = @i_fecharef

      if @w_tipo_ced = @i_tipo_ced
        select
          @w_tipo_ced = null,
          @v_tipo_ced = null
      else
        select
          @w_tipo_ced = @i_tipo_ced

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

      begin tran
      /* Actualizar el registro */
      update cl_mercado
      set    me_codigo = @i_codigo,
             --me_ced_ruc    =   @i_ced_ruc,
             me_documento = @i_documento,
             me_nombre = @i_nombre,
             me_fecha_ref = @i_fecharef,
             me_calificador = @i_calificador,
             me_calificacion = @i_calificacion,
             me_fuente = @i_origen,
             me_observacion = @i_observacion,
             me_tipo_ced = @i_tipo_ced,
             me_p_apellido = @i_p_apellido,
             me_s_apellido = @i_s_apellido,
             me_fecha_mod = @s_date,
             me_estado = @i_estadorm,
             me_nomlar = @w_nomlar,
             me_sexo = @i_sexo
      where  me_codigo = @i_codigo

      if @@rowcount != 1
      begin
        /* Error en actualizacion de registro covinco*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105067
        return 1
      end

      /* transaccion de servicios (registro previo) */
      insert into ts_mercado
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ced_ruc,nombre,
                   fecha_ref,origen,calificador,calificacion,observacion,
                   codigo,documento,ref_estado)
      values     ( @s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@v_ced_ruc,@v_nombre,
                   @v_fecharef,@v_origen,@v_calificador,@v_calificacion,
                   @v_observacion
                   ,
                   @i_codigo,@v_documento,@v_estadorm)

      if @@error != 0
      begin
        /* Error en creacion de transaccion de servicios  covinco*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        return 1
      end

      /* transaccion de servicios (registro actual) */
      insert into ts_mercado
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ced_ruc,nombre,
                   fecha_ref,origen,calificador,calificacion,observacion,
                   codigo,documento,ref_estado)
      values     ( @s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_ced_ruc,@w_nombre,
                   @w_fecharef,@w_origen,@w_calificador,@w_calificacion,
                   @w_observacion
                   ,
                   @i_codigo,@w_documento,@w_estadorm)

      if @@error != 0
      begin
        /* Error en creacion de transaccion de servicios  covinco*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        return 1
      end
      commit tran
      return 0
    end
  end

  /* Delete */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1287
    begin
      /* Valores para transaccion de Servicios */
      select
        @w_codigo = me_codigo,
        @w_ced_ruc = me_ced_ruc,
        @w_documento = me_documento,
        @w_nombre = me_nombre,
        @w_fecharef = me_fecha_ref,
        @w_calificador = me_calificador,
        @w_calificacion = me_calificacion,
        @w_origen = me_fuente,
        @w_observacion = me_observacion,
        @w_estadorm = me_estado,
        @w_sexo = me_sexo,
        /* REQ446 - PASO A HISTORICOS */
        @w_subtipo = me_subtipo,
        @w_tipo_ced = me_tipo_ced,
        @w_p_apellido = me_p_apellido,
        @w_s_apellido = me_s_apellido,
        @w_nomlar = me_nomlar,
        @w_fechamod = me_fecha_mod
      from   cl_mercado
      where  me_codigo = @i_codigo
      /* Si no existe registro a borrar, error */
      if @@rowcount = 0
      begin
        /* Error no existe registro  */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        return 1
      end

      begin tran
      /* Insertar en historico */
      insert into cl_mercado_his
                  (me_secuencial_his,me_fecha,me_codigo,me_ced_ruc,me_documento,
                   me_nombre,me_fecha_ref,me_calificador,me_calificacion,
                   me_fuente
                   ,
                   me_observacion,me_subtipo,me_tipo_ced,
                   me_p_apellido,me_s_apellido
                   ,
                   me_fecha_mod,me_estado,me_nomlar,me_sexo,
                   me_estado_mig,
                   me_data)
      values     ( @s_ssn,@w_today,@w_codigo,@w_ced_ruc,@w_documento,
                   @w_nombre,@w_fecharef,@w_calificador,@w_calificacion,
                   @w_origen,
                   @w_observacion,@w_subtipo,@w_tipo_ced,@w_p_apellido,
                   @w_s_apellido
                   ,
                   @w_fechamod,@w_estadorm,@w_nomlar,@w_sexo,null,
                   '')

      if @@error <> 0
      begin
        /*Error en paso a historicos */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 143006
        return 1
      end
      /* Eliminar el registro */
      delete from cl_mercado
      where  me_codigo = @i_codigo
      /* Si no se puede eliminar enviar error*/
      if @@error != 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107001
        return 1
      end
      /* desmarcar en_mala_referencia de cl_ente NVR */
      update cl_ente
      set    --en_mala_referencia = 'N',
      en_cont_malas = isnull(en_cont_malas,
                             1) - 1
      where  en_ced_ruc = @w_ced_ruc

      if @@rowcount = 0
      begin
        print 'CLIENTE AUN NO HA SIDO CREADO EN LA B.D.'
      end

      update cl_ente
      set    en_mala_referencia = 'N'
      where  en_ced_ruc    = @w_ced_ruc
         and en_cont_malas = 0
    /*****/
      /* transaccion de servicios (eliminacion )*/
      insert into ts_mercado
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ced_ruc,nombre,
                   fecha_ref,origen,calificador,calificacion,observacion,
                   codigo,documento,ref_estado)
      values     ( @s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_ced_ruc,@w_nombre,
                   @w_fecharef,@w_origen,@w_calificador,@w_calificacion,
                   @w_observacion
                   ,
                   @i_codigo,@w_documento,@w_estadorm)

      if @@error != 0
      begin
        /*Error en creacion de transaccion de servicios */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        return 1
      end
      commit tran
      return 0
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

go

