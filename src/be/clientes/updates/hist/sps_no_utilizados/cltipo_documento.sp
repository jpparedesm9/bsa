/************************************************************************/
/*   Archivo:          cltipodocumento.sp                               */
/*   Stored procedure:       sp_tipo_documento                          */
/*   Base de datos:      cobis                                          */
/*   Producto:           Clientes                                       */
/*   Disenado por:           Dario Latorre                              */
/*   Fecha de escritura:      06-Sep-2004                               */
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
/*                  PROPOSITO                                           */
/*   Este programa Realiza el mantenimiento a la tabla                  */
/*      cl_tipo_documento,cl_rango_tipo_doc,cl_rango_tipo_doc           */
/************************************************************************/
/*                       MODIFICACIONES                                 */
/*   FECHA              AUTOR          RAZON                            */
/*   06/Sep/2004      D.Latorre    Emision Inicial                      */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/

use cobis
go

if exists(select
            *
          from   sysobjects
          where  name = 'sp_tipo_documento')
  drop proc sp_tipo_documento
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_tipo_documento
(
  @s_ssn                    int = null,
  @s_sesn                   int = null,
  @s_date                   datetime = null,
  @s_srv                    varchar(30) = null,
  @s_lsrv                   varchar(30) = null,
  @s_user                   login = null,
  @s_term                   descripcion = null,
  @s_corr                   char(1) = null,
  @s_ssn_corr               int = null,
  @s_ofi                    smallint = null,
  @s_rol                    smallint = null,
  @s_org_err                char(1) = null,
  @s_error                  int = null,
  @s_sev                    tinyint = null,
  @s_msg                    descripcion = null,
  @s_org                    char(1) = null,
  @t_rty                    char(1) = null,
  @t_trn                    smallint = null,
  @t_debug                  char(1) = 'N',
  @t_file                   varchar(14) = null,
  @t_from                   varchar(30) = null,
  @t_show_version           bit = 0,
  @i_operacion              char(1) = null,
  @i_tipo                   char (1) = null,
  @i_modo                   tinyint = 0,
  @i_codigo                 catalogo = null,
  @i_descripcion            descripcion = null,
  @i_aux                    char (1) = null,
  @i_aux1                   char (1) = null,
  @i_sexo                   char (1) = 'O',
  @i_co                     char (1) = null,
  @i_estado                 char(1) = null,
  @i_subtipo                char(1) = null,
  @i_mascara                varchar (30) = null,
  @i_valida_fecha_exp       char(1) = null,
  @i_valor_exp              int = null,
  @i_num_dijitos_docu       int = null,
  @i_campo_incluido         char(1) = null,
  @i_formato_fecha          varchar(20) = null,
  @i_rango_campo_inclu      varchar(10) = null,
  @i_valor_cade_campo_inclu varchar(15) = null,
  @i_tipo_dato              char(1) = null,
  @i_longitud_unica         char(1) = null,
  @i_num_dijitos_docu_max   int = null,
  @i_valida_nit             char(1) = null,
  @i_valida_nui             char(1) = null,
  @i_feccha_exp             datetime = null,
  @i_rango_nui              numero = null,
  @i_signo                  varchar(4) = null,
  @i_valor                  int = null,
  @i_tipo_tabla             char(1) = null,
  @i_rango_ini              numero = null,
  @i_rango_fin              numero = null
)
as
  declare
    @w_return                 int,
    @w_sp_name                varchar(32),
    @w_existe                 tinyint,
    @w_existe1                tinyint,
    @w_existe2                tinyint,
    @w_codigo                 char(4),
    @w_descripcion            varchar(255),
    @w_porcentaje             tinyint,
    @w_estado                 char(1),
    @w_bandera                varchar(1),
    @v_descripcion            varchar(255),
    @v_porcentaje             tinyint,
    @v_estado                 char(1),
    @w_categoria              catalogo,
    @v_categoria              catalogo,
    @w_subtipo                char(1),
    @w_mascara                varchar(30),
    @w_valida_fecha_exp       char(1),
    @w_valor_exp              int,
    @w_num_dijitos_docu       int,
    @w_campo_incluido         char(1),
    @w_formato_fecha          varchar(20),
    @w_rango_campo_inclu      varchar(10),
    @w_valor_cade_campo_inclu varchar(15),
    @w_tipo_dato              char(1),
    @w_longitud_unica         char(1),
    @w_num_dijitos_docu_max   int,
    @w_valida_nit             char(1)

  /*Asignaciones*/

  select
    @w_sp_name = 'sp_tipo_documento'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Codigos de Transacciones*/
  if (@t_trn <> 1110
      and @i_operacion = 'I')
      or /* Insercion 1113 */
     (@t_trn <> 1110
      and @i_operacion = 'U')
      or /* Update */
     (@t_trn <> 1110
      and @i_operacion = 'D')
      or /* Eliminacion */
     (@t_trn <> 1110
      and (@i_operacion = 'A'
            or @i_operacion = 'X')) --or /* Search */
  begin
    /* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 601077
    return 1
  end

  /* Chequeo de Existencias de la tabla tipo de documento*/

  if @i_operacion = 'U'
      or @i_operacion = 'I'
      or @i_operacion = 'D'
  begin
    select
      1
    from   cl_tipo_documento
    where  ct_codigo = @i_codigo
       and ct_sexo   = @i_sexo

    if @@rowcount = 0
      select
        @w_existe = 0
    else
      select
        @w_existe = 1

    select
      1
    from   cl_fecha_tipo_doc
    where  ct_codigo = @i_codigo
       and ct_sexo   = @i_sexo
       and ct_signo  = @i_signo
       and ct_valor  = @i_valor
    if @@rowcount = 0
      select
        @w_existe1 = 0
    else
      select
        @w_existe1 = 1

    select
      1
    from   cl_rango_tipo_doc
    where  ct_codigo    = @i_codigo
       and ct_sexo      = @i_sexo
       and ct_rango_ini = @i_rango_ini
       and ct_rango_fin = @i_rango_fin
    if @@rowcount = 0
      select
        @w_existe2 = 0
    else
      select
        @w_existe2 = 1

    if @i_codigo is null
        or @i_descripcion is null
        or @i_estado is null
    begin
      /* Campos NOT NULL con valores nulos */

      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 601001
      return 1
    end

  end --if @i_operacion = 'U' or  @i_operacion = 'I' or @i_operacion = 'D'

  if @i_operacion = 'I'
  begin
    if @i_tipo_tabla = 'P' --cl_tipo_documento
    begin
      if @w_existe = 1
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 601160
        return 1
      end

      begin tran

      /* insertar los datos de entrada */
      insert into cl_tipo_documento
                  (ct_codigo,ct_sexo,ct_subtipo,ct_descripcion,ct_mascara,
                   ct_estado,ct_valida_fecha_exp,ct_valor_exp,
                   ct_num_dijitos_docu,
                   ct_campo_incluido,
                   ct_formato_fecha,ct_rango_campo_inclu,
                   ct_valor_cade_campo_inclu
                   ,
                   ct_tipo_dato,ct_longitud_unica,
                   ct_num_dijitos_docu_max,ct_valida_nit,ct_valida_nui,
                   ct_rango_nui,
                   ct_feccha_exp)
      values      (@i_codigo,@i_sexo,@i_subtipo,@i_descripcion,@i_mascara,
                   @i_estado,@i_valida_fecha_exp,@i_valor_exp,
                   @i_num_dijitos_docu,
                   @i_campo_incluido,
                   @i_formato_fecha,@i_rango_campo_inclu,
                   @i_valor_cade_campo_inclu
                   ,
                   @i_tipo_dato,@i_longitud_unica,
                   @i_num_dijitos_docu_max,@i_valida_nit,@i_valida_nui,
                   @i_rango_nui,
                   @i_feccha_exp)
      if @@error != 0
      begin
        /*  Error en creacion */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105505
        return 1
      end

      /* transaccion de servicio - nuevo */
      insert into ts_tipos_de_documentos
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,codigo,sexo,
                   subtipo,descripcion,mascara,estado,valida_fecha_exp,
                   valor_exp,num_dijitos_docu,campo_incluido,formato_fecha,
                   rango_campo_inclu,
                   valor_cade_campo_inclu,tipo_dato,longitud_unica,
                   num_dijitos_docu_max,valida_nit,
                   valida_nui,rango_nui,fecha_exp)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_codigo,@i_sexo,
                   @i_subtipo,@i_descripcion,@i_mascara,@i_estado,
                   @i_valida_fecha_exp,
                   @i_valor_exp,@i_num_dijitos_docu,@i_campo_incluido,
                   @i_formato_fecha
                   ,@i_rango_campo_inclu,
                   @i_valor_cade_campo_inclu,@i_tipo_dato,@i_longitud_unica,
                   @i_num_dijitos_docu_max,@i_valida_nit,
                   @i_valida_nui,@i_rango_nui,@i_feccha_exp)
      if @@error != 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005

        return 1
      end
      commit tran
    end --@i_tipo_tabla = 'P'

    if @i_tipo_tabla = 'F'
    begin
      if @w_existe1 = 1
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 601160
        return 1
      end
      begin tran

      /* insertar los datos de entrada */
      insert into cl_fecha_tipo_doc
                  (ct_codigo,ct_sexo,ct_signo,ct_valor)
      values      (@i_codigo,@i_sexo,@i_signo,@i_valor)
      if @@error != 0
      begin
        /*  Error en creacion de   */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105505
        return 1
      end

      /* transaccion de servicio - nuevo */
      insert into ts_fecha_tipo_doc
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,codigo,sexo,
                   signo,valor)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_codigo,@i_sexo,
                   @i_signo,@i_valor )
      if @@error != 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicio'*/
        return 1
      end

      commit tran
    end --if @i_tipo_tabla = 'F'

    if @i_tipo_tabla = 'R'
    begin
      if @w_existe2 = 1
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 601160
        return 1
      end

      begin tran

      /* insertar los datos de entrada */
      insert into cl_rango_tipo_doc
                  (ct_codigo,ct_sexo,ct_rango_ini,ct_rango_fin)
      values      (@i_codigo,@i_sexo,@i_rango_ini,@i_rango_fin)
      if @@error != 0
      begin
        /*  Error en creacion  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105505
        return 1
      end

      /* transaccion de servicio - nuevo */
      insert into ts_rango_tipo_doc
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,codigo,sexo,
                   rangoini,rangofi)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_codigo,@i_sexo,
                   @i_rango_ini,@i_rango_fin )
      if @@error != 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicio'*/
        return 1
      end

      commit tran

    end

  end --@i_operacion = 'I'

  /* Actualizacion de registro */

  if @i_operacion = 'U'
  begin
    if @w_existe = 0
    begin
      /* REGISTRO A ACTUALIZAR NO EXISTE */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2105002
      return 1
    end
    begin tran
    update cl_tipo_documento
    set    ct_subtipo = @i_subtipo,
           ct_descripcion = @i_descripcion,
           ct_mascara = @i_mascara,
           ct_estado = @i_estado,
           ct_valida_fecha_exp = @i_valida_fecha_exp,
           ct_valor_exp = @i_valor_exp,
           ct_num_dijitos_docu = @i_num_dijitos_docu,
           ct_campo_incluido = @i_campo_incluido,
           ct_formato_fecha = @i_formato_fecha,
           ct_rango_campo_inclu = @i_rango_campo_inclu,
           ct_valor_cade_campo_inclu = @i_valor_cade_campo_inclu,
           ct_tipo_dato = @i_tipo_dato,
           ct_longitud_unica = @i_longitud_unica,
           ct_num_dijitos_docu_max = @i_num_dijitos_docu_max,
           ct_valida_nit = @i_valida_nit,
           ct_valida_nui = @i_valida_nui,
           ct_rango_nui = @i_rango_nui,
           ct_feccha_exp = @i_feccha_exp
    where  ct_codigo = @i_codigo
       and ct_sexo   = @i_sexo

    if @@error <> 0
    begin
      /*Error en la actualizacion de registro*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2105001
      return 1
    end
    /* transaccion de servicio - nuevo */
    insert into ts_tipos_de_documentos
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,codigo,sexo,
                 subtipo,descripcion,mascara,estado,valida_fecha_exp,
                 valor_exp,num_dijitos_docu,campo_incluido,formato_fecha,
                 rango_campo_inclu,
                 valor_cade_campo_inclu,tipo_dato,longitud_unica,
                 num_dijitos_docu_max,valida_nit,
                 valida_nui,rango_nui,fecha_exp)
    values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                 @s_term,@s_srv,@s_lsrv,@i_codigo,@i_sexo,
                 @i_subtipo,@i_descripcion,@i_mascara,@i_estado,
                 @i_valida_fecha_exp,
                 @i_valor_exp,@i_num_dijitos_docu,@i_campo_incluido,
                 @i_formato_fecha
                 ,@i_rango_campo_inclu,
                 @i_valor_cade_campo_inclu,@i_tipo_dato,@i_longitud_unica,
                 @i_num_dijitos_docu_max,@i_valida_nit,
                 @i_valida_nui,@i_rango_nui,@i_feccha_exp)
    if @@error != 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103005
      /* 'Error en creacion de transaccion de servicio'*/
      return 1
    end

    commit tran
  end

  /* delete del registro en la tabla hijo  (cl_fecha_tipo_doc) */

  if @i_operacion = 'D'
  begin
    if @i_tipo_tabla = 'F'
    begin
      begin tran

      /*delete de los datos actuales*/

      delete cl_fecha_tipo_doc
      where  ct_codigo = @i_codigo
      --          and   ct_sexo   = @i_sexo

      if @@error != 0
      begin
        /*  Error en creacion  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105505
        return 1
      end
      commit tran
      return 0

    end --@i_tipo_tabla = 'F'

    if @i_tipo_tabla = 'R'
    begin
      begin tran

      /*delete de los datos actuales*/
      delete cl_rango_tipo_doc
      where  ct_codigo = @i_codigo
      --                             and   ct_sexo   = @i_sexo
      if @@error != 0
      begin
        /*  Error en creacion de categoria  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105505
        return 1
      end
      commit tran
      return 0

    end --@i_tipo_tabla = 'R'

  end --@i_operacion = 'D'

  /* Consulta opcion Search */

  if @i_operacion = 'S'
  begin
    if @i_modo = 0
    begin
      select
        'CODIGO'= ct_codigo,
        'SEXO'=ct_sexo,
        'DESCRIPCION' =ct_descripcion,
        'TIPO' =ct_subtipo,
        'MASCARA'=ct_mascara,
        'ESTADO' =ct_estado,
        'VALIDA FECHA EXP'= ct_valida_fecha_exp,
        'VALOR EXP'=ct_valor_exp,
        'DIJ'=ct_num_dijitos_docu,
        'CAMPO'=ct_campo_incluido,
        'FORMATO'=ct_formato_fecha,
        'RANGO'=ct_rango_campo_inclu,
        'VALOR CADE'=ct_valor_cade_campo_inclu,
        'TIPO DATO'=ct_tipo_dato,
        'TIPO LONGITUD'=ct_longitud_unica,
        'DIJ MAX'=ct_num_dijitos_docu_max,
        'VALIDA NIT'=ct_valida_nit,
        'VALIDA NUI'=ct_valida_nui,
        'RANGO NUI'=ct_rango_nui,
        'FECHA NUI'=convert(varchar(10), ct_feccha_exp, 103)
      from   cl_tipo_documento
      order  by ct_codigo

      if @@rowcount = 0
      begin
        if @@error <> 0
        begin
          /*No existen registros */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105506
          return 1
        end

      end

      return 0

    end /*end del modo 0*/
    if @i_modo = 1
    begin
      select
        'CODIGO'= ct_codigo,
        'SEXO'=ct_sexo,
        'DESCRIPCION' =ct_descripcion,
        'TIPO' =ct_subtipo,
        'MASCARA'=ct_mascara,
        'ESTADO' =ct_estado,
        'VALIDA FECHA EXP'= ct_valida_fecha_exp,
        'VALOR EXP'=ct_valor_exp,
        'DIJ'=ct_num_dijitos_docu,
        'CAMPO'=ct_campo_incluido,
        'FORMATO'=ct_formato_fecha,
        'RANGO'=ct_rango_campo_inclu,
        'VALOR CADE'=ct_valor_cade_campo_inclu,
        'TIPO DATO'=ct_tipo_dato,
        'TIPO LONGITUD'=ct_longitud_unica,
        'DIJ MAX'=ct_num_dijitos_docu_max,
        'VALIDA NIT'=ct_valida_nit,
        'VALIDA NUI'=ct_valida_nui,
        'RANGO NUI'=ct_rango_nui,
        'FECHA NUI'=convert(varchar(10), ct_feccha_exp, 103)
      from   cl_tipo_documento
      where  ct_subtipo = 'P'
         and ct_sexo in ('F', 'M')
      order  by ct_codigo

      if @@rowcount = 0
      begin
        if @@error <> 0
        begin
          /*No existen registros */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105506
          return 1
        end

      end

      return 0

    end /*end del modo 0*/

  end

  /* Consulta opcion espacifica */

  if @i_operacion = 'X'
  begin
    if @i_modo = 0
    begin
      select
        *
      from   cl_tipo_documento
      where  ct_codigo = @i_codigo
      order  by ct_codigo

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 601159
        return 1
      end
      return 0
    end

    if @i_modo = 1
    begin
      select
        'CODIGO'=ct_codigo,
        'SEXO'=ct_sexo,
        'FECHA'= 'dd/mm/yyyy',--'FECHA NAC',
        'SIGNO'=ct_signo,
        'VALOR'=ct_valor
      from   cl_fecha_tipo_doc
      where  ct_codigo = @i_codigo

    end

    if @i_modo = 2
    begin
      select
        'CODIGO'=ct_codigo,
        'SEXO'=ct_sexo,
        'VALOR'='NUMERO',
        'RANGO INICIAL'=ct_rango_ini,
        'RANGO FINAL'=ct_rango_fin
      from   cl_rango_tipo_doc
      where  ct_codigo = @i_codigo

    end

  end

go

