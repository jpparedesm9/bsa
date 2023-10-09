/************************************************************************/
/*  Archivo:            relinter.sp                                     */
/*  Stored procedure:   sp_relinter                                     */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Sara Meza                                       */
/*                      Jaime Loyo Holguin                              */
/*  Fecha de escritura: 15-Nov-1996                                     */
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
/*  Insercion de relaciones internacionales de un cliente               */
/*      Query general y especifico de relaciones internacionales        */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  15/Nov/96   S. Meza.    Emision Inicial                             */
/*              J. Loyo                                                 */
/*  09/Feb/2006 L. Nisperuza    Transacciones de servicio               */
/*  28/sept/08  FSAP            Requerimiento 4                         */
/*  06/Abr/2010 R.Altamirano    Control vigencia de datos del Ente      */
/*  05/May/2016 T. Baidal       Migracion a CEN                         */
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
           where  name = 'sp_relinter')
           drop proc sp_relinter
go

create proc sp_relinter
(
  @s_ssn           int = null,
  @s_user          login = null,
  @s_term          varchar(30) = null,
  @s_date          datetime = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_ofi           smallint = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(10) = null,
  @t_from          varchar(32) = null,
  @t_trn           smallint = null,
  @t_show_version  bit = 0,
  @i_operacion     char(1) = null,
  @i_ente          int = null,
  @i_relacion      int = null,
  @i_tipo_relacion catalogo = null,
  @i_descripcion   descripcion = null,
  @i_institucion   varchar(40) = null,
  @i_fecha_desde   datetime = null,
  @i_pais          smallint = null,
  @i_num_producto  varchar(40) = null,
  @i_moneda        varchar(10) = null,
  @i_ciudad        varchar(65) = null,
  @i_formato_f     tinyint = 103,
  @i_monto         money = null
)
as
  declare
    @w_sp_name            varchar(32),
    @w_codigo             int,
    @w_return             int,
    @o_siguiente          tinyint,
    @w_ente               int,
    @w_relacion           int,
    @w_tipo_relacion      catalogo,
    @w_pais               smallint,
    @w_descripcion        descripcion,
    @w_institucion        varchar(40),
    @w_fecha_desde        datetime,
    @w_fecha_nac          datetime,
    @w_tipo               char(1),
    @w_fecha_registro     datetime,
    @w_fecha_modificacion datetime,
    @w_fecha_ver          datetime,
    @w_vigencia           char(1),
    @w_verificado         char(1),
    @w_funcionario        login,
    @w_num_producto       varchar(40),
    @w_moneda             varchar(10),
    @w_ciudad             varchar(65),
    @w_monto              money,
    @v_tipo_relacion      catalogo,
    @v_pais               smallint,
    @v_descripcion        descripcion,
    @v_institucion        varchar(40),
    @v_fecha_desde        datetime,
    @v_num_producto       varchar(40),
    @v_moneda             varchar(10),
    @v_ciudad             varchar(65),
    @o_ente               int,
    @o_relacion           int,
    @o_tipo_relacion      catalogo,
    @o_desc_tipo          descripcion,
    @o_pais               smallint,
    @o_desc_pais          descripcion,
    @o_descripcion        descripcion,
    @o_institucion        varchar(40),
    @o_fecha_desde        varchar(10),
    @o_vigencia           char(1),
    @o_verificado         char(1),
    @o_funcionario        login,
    @o_fecha_ver          varchar(10),
    @o_fecha_registro     varchar(10),
    @o_fecha_modificacion varchar(10),
    @o_num_producto       varchar(40),
    @o_moneda             varchar(10),
    @o_ciudad             varchar(65),
    @o_desc_moneda        descripcion,
    @o_monto              money,
    @w_error              int,
    @v_monto              money,
    @v_vigencia           char(1)
  --ream 06.abr.2010 control vigencia de datos del ente

  select
    @w_sp_name = 'sp_relinter'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 1307
    begin
      /* Verificar que exista el ente */
      select
        @w_fecha_nac = case en_subtipo
                         when 'C' then c_fecha_const
                         else p_fecha_nac
                       end,
        @w_tipo = en_subtipo
      from   cl_ente
      where  en_ente = @i_ente

      /* si no existe, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101146
        /* 'No existe Cliente'*/
        return 101146
      end

      if @w_fecha_nac >= @i_fecha_desde
      begin
        if @w_tipo = 'C'
          select
            @w_error = 107096
        else
          select
            @w_error = 107081
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = @w_error
        return @w_error
      end

      if not exists (select
                       1
                     from   cl_catalogo c1,
                            cl_tabla t1
                     where  t1.tabla  = 'cl_rel_inter'
                        and t1.codigo = c1.tabla
                        and c1.codigo = @i_tipo_relacion)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101175
        /*'No existe esa relacion internacional '*/
        return 101175
      end
      if not exists (select
                       1
                     from   cl_pais
                     where  pa_pais = @i_pais)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101018
        /*'No existe ese pais'*/
        return 101018
      end

      begin tran
      /* seleccionar el nuevo secuencial para el hijo */
      select
        @o_siguiente = isnull(max(ri_relacion), 0) + 1
      from   cl_relacion_inter
      where  ri_ente = @i_ente

      /* Insercion cl_relacion_inter */
      insert into cl_relacion_inter
                  (ri_ente,ri_relacion,ri_tipo_relacion,ri_descripcion,
                   ri_institucion,
                   ri_fecha_desde,ri_pais,ri_fecha_registro,
                   ri_fecha_modificacion,
                   ri_vigencia,
                   ri_verificado,ri_funcionario,ri_num_producto,ri_moneda,
                   ri_ciudad,
                   ri_monto) --adicion campo monto FSAP
      values      (@i_ente,@o_siguiente,@i_tipo_relacion,@i_descripcion,
                   @i_institucion,
                   @i_fecha_desde,@i_pais,@s_date,@s_date,'S',
                   'N',@s_user,@i_num_producto,@i_moneda,@i_ciudad,
                   @i_monto) --FSAP

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103083
        /* 'Error en creacion de una relacion internacional */
        return 103083
      end
      /*  Transaccion de Servicio  */
      insert into ts_relacion_inter
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,ente,
                   institucion,tipo_relacionm,descripcion,fecha_desde,pais,
                   fecha_registro,fecha_modificacion,fecha_ver,vigencia,
                   verificado
                   ,
                   funcionario,monto)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@o_siguiente,@i_ente,
                   @i_institucion,@i_tipo_relacion,@i_descripcion,@i_fecha_desde
                   ,
                   @i_pais,
                   @s_date,@s_date,null,'S','N',
                   @s_user,@i_monto)
      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 103005
      end
      commit tran
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 151051
    end
  end
  /** Update **/
  if @i_operacion = 'U'
  begin
    if @t_trn = 1309
    begin
      select
        @w_fecha_nac = case en_subtipo
                         when 'C' then c_fecha_const
                         else p_fecha_nac
                       end,
        @w_tipo = en_subtipo
      from   cl_ente
      where  en_ente = @i_ente

      if @w_fecha_nac >= @i_fecha_desde
      begin
        if @w_tipo = 'C'
          select
            @w_error = 107096
        else
          select
            @w_error = 107081
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = @w_error
        return @w_error
      end

      if not exists (select
                       1
                     from   cl_catalogo c1,
                            cl_tabla t1
                     where  t1.tabla  = 'cl_rel_inter'
                        and t1.codigo = c1.tabla
                        and c1.codigo = @i_tipo_relacion)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101175
        /*'No existe esa relacion internacional '*/
        return 101175
      end
      if not exists (select
                       1
                     from   cl_pais
                     where  pa_pais = @i_pais)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101018
        /*'No existe pais'*/
        return 101018
      end
      select
        @w_relacion = ri_relacion,
        @w_tipo_relacion = ri_tipo_relacion,
        @w_ente = ri_ente,
        @w_descripcion = ri_descripcion,
        @w_institucion = ri_institucion,
        @w_fecha_desde = ri_fecha_desde,
        @w_pais = ri_pais,
        @w_num_producto = ri_num_producto,
        @w_moneda = ri_moneda,
        @w_ciudad = ri_ciudad,
        @w_monto = ri_monto,--FSAP
        @w_vigencia = ri_vigencia
      --ream 06.abr.2010 control vigencia de datos del ente
      from   cl_relacion_inter
      where  ri_ente     = @i_ente
         and ri_relacion = @i_relacion
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 101001
      end

      select
        @v_tipo_relacion = @w_tipo_relacion,
        @v_descripcion = @w_descripcion,
        @v_institucion = @w_institucion,
        @v_fecha_desde = @w_fecha_desde,
        @v_num_producto = @w_num_producto,
        @v_moneda = @w_moneda,
        @v_ciudad = @w_ciudad,
        @v_monto = @w_monto,
        @v_vigencia = @w_vigencia
      --ream 06.abr.2010 control vigencia de datos del ente

      if @w_tipo_relacion = @i_tipo_relacion
        select
          @w_tipo_relacion = null,
          @v_tipo_relacion = null
      else
        select
          @w_tipo_relacion = @i_tipo_relacion

      if @w_descripcion = @i_descripcion
        select
          @w_descripcion = null,
          @v_descripcion = null
      else
        select
          @w_descripcion = @i_descripcion

      if @w_institucion = @i_institucion
        select
          @w_institucion = null,
          @v_institucion = null
      else
        select
          @w_institucion = @i_institucion

      if @w_fecha_desde = @i_fecha_desde
        select
          @w_fecha_desde = null,
          @v_fecha_desde = null
      else
        select
          @w_fecha_desde = @i_fecha_desde

      if @w_pais = @i_pais
        select
          @w_pais = null,
          @v_pais = null
      else
        select
          @w_pais = @i_pais

      select
        @w_vigencia = null,
        @v_vigencia = null --ream 06.abr.2010 control vigencia de datos del ente

      begin tran

      /* modificar, los datos */
      update cl_relacion_inter
      set    ri_tipo_relacion = @i_tipo_relacion,
             ri_descripcion = @i_descripcion,
             ri_institucion = @i_institucion,
             ri_fecha_desde = @i_fecha_desde,
             ri_pais = @i_pais,
             ri_num_producto = @i_num_producto,
             ri_moneda = @i_moneda,
             ri_ciudad = @i_ciudad,
             ri_vigencia = isnull(@w_vigencia,
                                  ri_vigencia),
             --ream 06.abr.2010 control vigencia de datos del ente
             ri_verificado = 'N',
             ri_fecha_modificacion = @s_date,
             ri_funcionario = @s_user,
             ri_monto = @i_monto --FSAP
      where  ri_ente     = @i_ente
         and ri_relacion = @i_relacion

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105074
        /*'Error en actualizacion de relacion internacional'*/
        return 105074
      end

      /*  Transaccion de Servicio Registro Previo */
      insert into ts_relacion_inter
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,ente,
                   institucion,tipo_relacionm,descripcion,fecha_desde,pais,
                   fecha_registro,fecha_modificacion,fecha_ver,vigencia,
                   verificado
                   ,
                   funcionario,monto)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_relacion,@w_ente,
                   @w_institucion,@w_tipo_relacion,@w_descripcion,@w_fecha_desde
                   ,
                   @w_pais,
                   @w_fecha_registro,@w_fecha_modificacion,@w_fecha_ver,
                   @v_vigencia,
                   @w_verificado,
                   @w_funcionario,@w_monto)
      --ream 06.abr.2010 control vigencia de datos del ente

      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 103005
      end

      /*  Transaccion de Servicio Registro Actual */
      insert into ts_relacion_inter
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,ente,
                   institucion,tipo_relacionm,descripcion,fecha_desde,pais,
                   fecha_registro,fecha_modificacion,fecha_ver,vigencia,
                   verificado
                   ,
                   funcionario,monto)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_relacion,@w_ente,
                   @i_institucion,@i_tipo_relacion,@i_descripcion,@i_fecha_desde
                   ,
                   @i_pais,
                   @w_fecha_registro,@s_date,@w_fecha_ver,@w_vigencia,'N',
                   @s_user,@i_monto)
      --ream 06.abr.2010 control vigencia de datos del ente

      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 103005
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
      return 151051
    end
  end

  /** Delete **/
  if @i_operacion = 'D'
  begin
    if @t_trn = 1308
    begin
      select
        @w_descripcion = ri_descripcion,
        @w_ente = ri_ente,
        @w_institucion = ri_institucion,
        @w_tipo_relacion = ri_tipo_relacion,
        @w_fecha_desde = ri_fecha_desde,
        @w_monto = ri_monto,
        @w_vigencia = ri_vigencia
      --ream 06.abr.2010 control vigencia de datos del ente
      from   cl_relacion_inter
      where  ri_ente     = @i_ente
         and ri_relacion = @i_relacion

      /* si no existe relacion */
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

    /* borrar la relacion */ /*hom*/
      delete from cl_relacion_inter
      where  ri_ente     = @i_ente
         and ri_relacion = @i_relacion

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107070
        /* 'Error en eliminacion de la relacion de un cliente '*/
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_relacion_inter
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,relacion,ente,
                   institucion,tipo_relacionm,descripcion,fecha_desde,pais,
                   fecha_registro,fecha_modificacion,fecha_ver,vigencia,
                   verificado
                   ,
                   funcionario,monto)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_relacion,@i_ente,
                   @w_institucion,@w_tipo_relacion,@w_descripcion,@w_fecha_desde
                   ,
                   @w_pais,
                   @w_fecha_registro,@w_fecha_modificacion,@w_fecha_ver,
                   @w_vigencia,
                   @w_verificado,
                   @w_funcionario,@w_monto)

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
  /* referencias  de relaciones de un cliente no se controla de 20 en 20
     porque no se espera mas de 20 relaciones */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1310
    begin
      select
        'Consecutivo' = ri_relacion,/*hom*/
        'Cod Pais' = ri_pais,
        'Pais' = p1.pa_descripcion,
        'Relacion' = ri_tipo_relacion,
        'Tipo Relacion' = c1.valor,
        'Institucion' = ri_institucion,
        'Descripcion' = ri_descripcion,
        'Fecha desde' = convert (char(10), ri_fecha_desde, @i_formato_f),
        'Monto' = ri_monto --FSAP
      from   cl_relacion_inter,
             cl_tabla t1,
             cl_catalogo c1,
             cl_pais p1
      where  ri_ente   = @i_ente
         and c1.codigo = ri_tipo_relacion
         and t1.codigo = c1.tabla
         and t1.tabla  = 'cl_rel_inter'
         and ri_pais   = p1.pa_pais
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
  /* Datos especificos de las relaciones del cliente */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1311
    begin
      select
        @o_relacion = ri_relacion,
        @o_descripcion = rtrim(ri_descripcion),
        @o_institucion = rtrim(ri_institucion),
        @o_tipo_relacion = ri_tipo_relacion,
        @o_pais = ri_pais,
        @o_fecha_desde = convert(char(10), ri_fecha_desde, @i_formato_f),
        @o_vigencia = ri_vigencia,
        @o_verificado = ri_verificado,
        @o_funcionario = ri_funcionario,
        @o_fecha_ver = convert(char(10), ri_fecha_ver, @i_formato_f),
        @o_fecha_registro = convert(char(10), ri_fecha_registro, @i_formato_f),
        @o_fecha_modificacion = convert(char(10), ri_fecha_modificacion,
                                @i_formato_f)
        ,
        @o_num_producto = ri_num_producto,
        @o_moneda = ri_moneda,
        @o_ciudad = ri_ciudad,
        @o_monto = ri_monto
      from   cl_relacion_inter
      where  ri_ente     = @i_ente
         and ri_relacion = @i_relacion

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
      /* if exist tipo relacion */
      select
        @o_desc_tipo = c1.valor
      from   cl_catalogo c1,
             cl_tabla t1
      where  t1.tabla  = 'cl_rel_inter'
         and t1.codigo = c1.tabla
         and c1.codigo = @o_tipo_relacion
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101175
        /*'No existe esa relacion internacional '*/
        return 1
      end

      select
        @o_desc_pais = pa_descripcion
      from   cl_pais
      where  pa_pais = @o_pais
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101018
        /*'No existe pais'*/
        return 1
      end

      if @o_moneda is not null
      begin
        select
          @o_desc_moneda = c1.valor
        from   cl_catalogo c1,
               cl_tabla t1
        where  t1.tabla  = 'cl_moneda'
           and t1.codigo = c1.tabla
           and c1.codigo = @o_moneda
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101045
          /*'No existe moneda '*/
          return 1
        end
      end

      select
        @o_relacion,--1
        @o_tipo_relacion,--2
        @o_desc_tipo,--3
        @o_descripcion,--4
        @o_institucion,--5
        @o_fecha_desde,--6
        @o_pais,--7
        @o_desc_pais,--8
        @o_vigencia,--9
        @o_verificado,--10
        @o_funcionario,--11
        @o_fecha_ver,--12
        @o_fecha_registro,--13
        @o_fecha_modificacion,--14
        @o_num_producto,--15
        @o_moneda,--16
        @o_ciudad,--17
        @o_desc_moneda,--18
        @o_monto --19
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

