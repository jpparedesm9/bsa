/************************************************************************/
/*  Archivo:            ref_fin.sp                                      */
/*  Stored procedure:   sp_ref_fin                                      */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Carlos Rodriguez V.                             */
/*  Fecha de escritura: 03-Abr-1994                                     */
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
/*  Insercion de referencia de tarjeta                                  */
/*  Actualizacion de referencia de tarjeta                              */
/*  Borrado de referencia de tarjeta                                    */
/*  Busqueda de referencia de tarjeta general y especifica              */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  02/Jul/96   E. Gomez M. Insercion nuevos campos                     */
/*  06/Ene/97   N.Velasco   Fechas Expedi/Inicio no sean <              */
/*                  a la F.Nacimiento/Constituci NVR                    */
/*  06/Abr/2010 R.Altamirano Control de vigencia de datos del Ente      */
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
           where  name = 'sp_ref_fin')
    drop proc sp_ref_fin
go

create proc sp_ref_fin
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
  @i_treferencia        char(1) = null,
  @i_banco              int = null,
  @i_toperacion         char(1) = null,
  @i_tclase             descripcion = null,
  @i_tipo_cifras        catalogo = null,
  @i_numero_cifras      tinyint = null,
  @i_fec_inicio         datetime = null,
  @i_fec_vencimiento    datetime = null,
  @i_calificacion       catalogo = null,
  @i_vigencia           char(1) = null,
  @i_verificacion       char(1) = null,
  @i_fecha_ver          datetime = null,
  @i_fecha_modificacion datetime = null,
  @i_observacion        varchar(254) = null,
  @i_estatus            char(1) = null,
  @i_monto              money = null,
  @i_garantia           char(1) = null,
  @i_cupo_usado         money = null,
  @i_monto_vencido      money = 0,
  @i_fec_exp_ref        datetime = null,
  @i_resultado          catalogo = null
)
as
  declare
    @w_sp_name            varchar(32),
    @w_codigo             int,
    @w_return             int,
    @o_siguiente          tinyint,
    @w_banco              int,
    @w_toperacion         char(1),
    @w_tclase             descripcion,
    @w_tipo_cifras        catalogo,
    @w_numero_cifras      tinyint,
    @w_fec_inicio         datetime,
    @w_fec_vencimiento    datetime,
    @w_calificacion       catalogo,
    @w_vigencia           char(1),
    @w_verificacion       char(1),
    @w_fecha_ver          datetime,
    @w_fecha_modificacion datetime,
    @w_fecha_nac          datetime,
    @w_tipo               char(1),
    @w_observacion        varchar(254),
    @w_estatus            char(1),
    @w_monto              money,
    @w_garantia           char(1),
    @w_cupo_usado         money,
    @w_monto_vencido      money,
    @w_fec_exp_ref        datetime,
    @w_resultado          catalogo,
    @v_garantia           char(1),
    @v_cupo_usado         money,
    @v_monto_vencido      money,
    @v_fec_exp_ref        datetime,
    @v_banco              int,
    @v_toperacion         char(1),
    @v_tclase             descripcion,
    @v_tipo_cifras        catalogo,
    @v_numero_cifras      tinyint,
    @v_fec_inicio         datetime,
    @v_fec_vencimiento    datetime,
    @v_calificacion       catalogo,
    @v_vigencia           char(1),
    @v_verificacion       char(1),
    @v_fecha_ver          datetime,
    @v_fecha_modificacion datetime,
    @v_observacion        varchar(254),
    @v_estatus            char(1),
    @v_monto              money,
    @v_resultado          catalogo,
    @o_ente               int,
    @o_referencia         tinyint,
    @o_tipo               char(1),
    @o_banco              int,
    @o_toperacion         char(1),
    @o_tclase             descripcion,
    @o_tipo_cifras        catalogo,
    @o_numero_cifras      tinyint,
    @o_fec_inicio         datetime,
    @o_fec_vencimiento    datetime,
    @o_calificacion       catalogo,
    @o_vigencia           char(1),
    @o_verificacion       char(1),
    @o_fecha_ver          datetime,
    @o_fecha_modificacion datetime,
    @o_observacion        varchar(254),
    @o_estatus            char(1),
    @o_monto              money,
    @o_garantia           char(1),
    @o_cupo_usado         money,
    @o_monto_vencido      money,
    @o_fec_exp_ref        datetime,
    @w_data_vigente       catalogo,
    --ream 06.abr.2010 control vigencia de datos del ente
    @v_data_vigente       catalogo
  --ream 06.abr.2010 control vigencia de datos del ente

  select
    @w_sp_name = 'sp_ref_fin'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 115
    begin
      select
        @w_fecha_nac = case en_subtipo
                         when 'C' then c_fecha_const
                         else p_fecha_nac
                       end,
        @w_tipo = en_subtipo
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

      if ((select
             datediff(day,
                      @w_fecha_nac,
                      @i_fec_exp_ref)) <= 0)
         and (@w_tipo = 'P')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107083
        return 1
      end

      if (((select
              datediff(day,
                       @w_fecha_nac,
                       @i_fec_exp_ref)) <= 0)
          and (@w_tipo = 'C'))
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107080
        return 1
      end

      if @i_fec_inicio is not null
      begin
        if ((select
               datediff(day,
                        @w_fecha_nac,
                        @i_fec_inicio)) <= 0)
           and (@w_tipo = 'P')
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107085
          return 1
        end

        if ((select
               datediff(day,
                        @w_fecha_nac,
                        @i_fec_inicio)) <= 0)
           and (@w_tipo = 'C')
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107086
          return 1
        end
      end

      /* verificar que exista el tipo de referencia (F: de financiera) */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_rtipo',
        @i_operacion = 'E',
        @i_codigo    = 'F'

      /* si no existe el tipo, error */
      if @w_return <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101023
        /* 'No existe tipo de referencia financiera '*/
        return 1
      end

      /* verificar que exista el tipo de calificacion */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_posicion',
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

      /* verificar que exista el tipo de cifras */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_tcifras',
        @i_operacion = 'E',
        @i_codigo    = @i_tipo_cifras

    /* si no existe el tipo, error */
    /* if @w_return <> 0
      begin
       exec sp_cerror
           @t_debug    = @t_debug,
           @t_file     = @t_file,
           @t_from     = @w_sp_name,
           @i_num      = 101142*/
    /* 'No existe tipo de cifras'*/
      /*  return 1
          end*/

      if not exists (select
                       1
                     from   cl_banco_rem
                     where  ba_banco = @i_banco)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101144
        /* 'Falta nombre del banco '*/
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
      insert into cl_financiera
                  (cliente,referencia,treferencia,institucion,toperacion,
                   tclase,tipo_cifras,numero_cifras,fec_inicio,fec_vencimiento,
                   calificacion,vigencia,verificacion,fecha_ver,
                   fecha_modificacion
                   ,
                   observacion,estatus,fecha_registro,monto,
                   garantia,
                   cupo_usado,monto_vencido,fec_exp_ref,funcionario)
      /*M. Silva Bco Estado. Enero 29/98*/
      values      (@i_ente,@o_siguiente,'F',@i_banco,@i_toperacion,
                   @i_tclase,@i_tipo_cifras,@i_numero_cifras,@i_fec_inicio,
                   @i_fec_vencimiento,
                   @i_calificacion,'S','N',@i_fecha_ver,getdate(),
                   @i_observacion,@i_estatus,getdate(),@i_monto,@i_garantia,
                   @i_cupo_usado,@i_monto_vencido,@i_fec_exp_ref,@s_user)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103072
        /* 'Error en creacion de referencia financiera'*/
        return 1
      end

      /* Transaccion servicios - cl_referencia */
      insert into ts_referencia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,referencia,
                   tipo,bancoint,toperacion,tclase,tipo_cifras,
                   numero_cifras,fec_inicio,fec_vencimiento,calificacion,
                   vigencia,
                   verificacion,fecha_ver,fecha_modificacion,observacion,estatus
                   ,
                   monto,garantia,cupo_usado,monto_vencido,
                   fec_exp_ref)
      values      (@s_ssn,@t_trn,'N',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@o_siguiente,
                   'F',@i_banco,@i_toperacion,@i_tclase,@i_tipo_cifras,
                   @i_numero_cifras,@i_fec_inicio,@i_fec_vencimiento,
                   @i_calificacion
                   ,
                   'S',
                   'N',@i_fecha_ver,getdate(),@i_observacion,@i_estatus,
                   @i_monto,@i_garantia,@i_cupo_usado,@i_monto_vencido,
                   @i_fec_exp_ref)

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
    if @t_trn = 116
    begin
      select
        @w_fecha_nac = case en_subtipo
                         when 'C' then c_fecha_const
                         else p_fecha_nac
                       end,
        @w_tipo = en_subtipo
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

      if ((select
             datediff(day,
                      @w_fecha_nac,
                      @i_fec_exp_ref)) <= 0)
         and (@w_tipo = 'P')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107083
        return 1
      end

      if (((select
              datediff(day,
                       @w_fecha_nac,
                       @i_fec_exp_ref)) <= 0)
          and (@w_tipo = 'C'))
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107080
        return 1
      end

      if @i_fec_inicio is not null
      begin
        if ((select
               datediff(day,
                        @w_fecha_nac,
                        @i_fec_inicio)) <= 0)
           and (@w_tipo = 'P')
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107085
          return 1
        end

        if ((select
               datediff(day,
                        @w_fecha_nac,
                        @i_fec_inicio)) <= 0)
           and (@w_tipo = 'C')
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107086
          return 1
        end
      end

      /* verificar que exista el tipo de referencia */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_rtipo',
        @i_operacion = 'E',
        @i_codigo    = 'F'

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
        @i_tabla     = 'cl_posicion',
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

      /* verificar que exista el tipo de cifras
        exec @w_return = cobis..sp_catalogo
         @t_debug   = @t_debug,
         @t_file    = @t_file,
         @t_from    = @w_sp_name,
         @i_tabla   = 'cl_tcifras',
         @i_operacion   = 'E',
         @i_codigo  = @i_tipo_cifras
      
        ' si no existe el tipo, error'
       if @w_return <> 0
       begin
        exec sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 101142
             'No existe tipo de cifras'
        return 1
        end */

      if not exists (select
                       1
                     from   cl_banco_rem
                     where  ba_banco = @i_banco)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101144
        /* 'Falta nombre del banco '*/
        return 1
      end

      /* Control de campos a actualizar */
      select
        @w_banco = institucion,
        @w_toperacion = toperacion,
        @w_tclase = tclase,
        @w_tipo_cifras = tipo_cifras,
        @w_numero_cifras = numero_cifras,
        @w_fec_inicio = fec_inicio,
        @w_fec_vencimiento = fec_vencimiento,
        @w_calificacion = calificacion,
        @w_vigencia = verificacion,
        @w_fecha_ver = fecha_ver,
        @w_fecha_modificacion = fecha_modificacion,
        @w_observacion = observacion,
        @w_estatus = estatus,
        @w_monto = monto,
        @w_garantia = garantia,/*INNUCA */
        @w_cupo_usado = cupo_usado,/*INNUCA */
        @w_monto_vencido = monto_vencido,/*INNUCA */
        @w_fec_exp_ref = fec_exp_ref,/*INNUCA */
        @w_data_vigente = vigencia,
        --ream 06.abr.2010 control vigencia de datos del ente
        @w_resultado = resul_verif
      from   cl_financiera
      where  cliente    = @i_ente
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

      select
        @v_banco = @w_banco,
        @v_toperacion = @w_toperacion,
        @v_tclase = @w_tclase,
        @v_tipo_cifras = @w_tipo_cifras,
        @v_numero_cifras = @w_numero_cifras,
        @v_fec_inicio = @w_fec_inicio,
        @v_fec_vencimiento = @w_fec_vencimiento,
        @v_calificacion = @w_calificacion,
        @v_vigencia = @w_verificacion,
        @v_fecha_ver = @w_fecha_ver,
        @v_fecha_modificacion = @w_fecha_modificacion,
        @v_observacion = @w_observacion,
        @v_estatus = @w_estatus,
        @v_monto = @w_monto,
        @v_garantia = @w_garantia,/* INNUCA */
        @v_cupo_usado = @w_cupo_usado,/* INNUCA */
        @v_monto_vencido = @w_monto_vencido,/* INNUCA */
        @v_fec_exp_ref = @w_fec_exp_ref,/* INNUCA */
        @v_data_vigente = @w_data_vigente,
        --ream 06.abr.2010 control vigencia de datos del ente
        @v_resultado = @w_resultado
      /************************* INNUCA *******************/
      if @w_garantia = @i_garantia
        select
          @w_garantia = null,
          @v_garantia = null
      else
        select
          @w_garantia = @i_garantia

      if @w_cupo_usado = @i_cupo_usado
        select
          @w_cupo_usado = null,
          @v_cupo_usado = null
      else
        select
          @w_cupo_usado = @i_cupo_usado

      if @w_monto_vencido = @i_monto_vencido
        select
          @w_monto_vencido = null,
          @v_monto_vencido = null
      else
        select
          @w_monto_vencido = @i_monto_vencido

      if @w_fec_exp_ref = @i_fec_exp_ref
        select
          @w_fec_exp_ref = null,
          @v_fec_exp_ref = null
      else
        select
          @w_fec_exp_ref = @i_fec_exp_ref
      /***************************************************/
      if @w_banco = @i_banco
        select
          @w_banco = null,
          @v_banco = null
      else
        select
          @w_banco = @i_banco

      if @w_toperacion = @i_operacion
        select
          @w_toperacion = null,
          @v_toperacion = null

      else
        select
          @w_toperacion = @i_operacion

      if @w_tclase = @i_tclase
        select
          @w_tclase = null,
          @v_tclase = null

      else
        select
          @w_tclase = @i_tclase

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

      if @w_fec_inicio = @i_fec_inicio
        select
          @w_fec_inicio = null,
          @v_fec_inicio = null
      else
        select
          @w_fec_inicio = @i_fec_inicio

      if @w_fec_vencimiento = @i_fec_vencimiento
        select
          @w_fec_vencimiento = null,
          @v_fec_vencimiento = null
      else
        select
          @w_fec_vencimiento = @i_fec_vencimiento

      if @w_calificacion = @i_calificacion
        select
          @w_calificacion = null,
          @v_calificacion = null
      else
        select
          @w_calificacion = @i_calificacion

      if @w_vigencia = @i_vigencia
        select
          @w_vigencia = null,
          @v_vigencia = null
      else
        select
          @w_vigencia = @i_vigencia

      /**    if @w_verificacion = @i_verificacion
          select @w_verificacion = null, @v_verificacion = null
          else
          select @w_verificacion = @i_verificacion **/

      if @w_fecha_ver = @i_fecha_ver
        select
          @w_fecha_ver = null,
          @v_fecha_ver = null
      else
        select
          @w_fecha_ver = @i_fecha_ver

      if @w_fecha_modificacion = @i_fecha_modificacion
        select
          @w_fecha_modificacion = null,
          @v_fecha_modificacion = null
      else
        select
          @w_fecha_modificacion = @i_fecha_modificacion

      if @w_observacion = @i_observacion
        select
          @w_observacion = null,
          @v_observacion = null
      else
        select
          @w_observacion = @i_observacion

      if @w_estatus = @i_estatus
        select
          @w_estatus = null,
          @v_estatus = null
      else
        select
          @w_estatus = @i_estatus

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

      if @w_resultado = @i_resultado
        select
          @w_resultado = null,
          @v_resultado = null
      else
        select
          @w_resultado = @i_resultado

      if @w_data_vigente <> (select
                               vigencia
                             from   cl_financiera
                             where  cliente    = @i_ente
                                and referencia = @i_referencia)
      begin
        select
          @w_data_vigente = null,
          @v_data_vigente = null
        --ream 06.abr.2010 control vigencia de datos del ente
        select
          @w_data_vigente = (select
                               vigencia
                             from   cl_financiera
                             where  cliente    = @i_ente
                                and referencia = @i_referencia)
      end
      else
        select
          @w_data_vigente = (select
                               vigencia
                             from   cl_financiera
                             where  cliente    = @i_ente
                                and referencia = @i_referencia)

      begin tran
      /* modificar los datos actuales */
      update cl_financiera
      set    institucion = @i_banco,
             toperacion = @i_toperacion,
             tclase = @i_tclase,
             tipo_cifras = @i_tipo_cifras,
             numero_cifras = @i_numero_cifras,
             fec_inicio = @i_fec_inicio,
             fec_vencimiento = @i_fec_vencimiento,
             calificacion = @i_calificacion,
             vigencia = isnull(@w_data_vigente,
                               null),
             --ream 06.abr.2010 control vigencia de datos del ente
             verificacion = 'N',
             fecha_ver = @w_fecha_ver,
             fecha_modificacion = getdate(),
             observacion = @i_observacion,
             estatus = @i_estatus,
             monto = @i_monto,
             garantia = @i_garantia,/* INNUCA */
             cupo_usado = @i_cupo_usado,/* INNUCA */
             monto_vencido = @i_monto_vencido,/* INNUCA */
             fec_exp_ref = @i_fec_exp_ref,/* INNUCA */
             funcionario = @s_user,/*M. Silva. Bco. Estado Enero 29/98 */
             resul_verif = @i_resultado
      where  cliente    = @i_ente
         and referencia = @i_referencia

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105067
        /* 'Error en actualizacion de referencia financiera'*/
        return 1
      end

      if @i_verificacion = 'S'
      begin
        update cl_financiera
        set    verificacion = @i_verificacion,
               funcionario = @s_user
        where  cliente    = @i_ente
           and referencia = @i_referencia
        /* si no se puede modificar, error */
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105067
          /* 'Error en actualizacion de referencia financiera'*/
          return 1
        end
      end

      /* Transaccion servicios - cl_financiera */

      insert into ts_referencia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,referencia,
                   tipo,bancoint,toperacion,tclase,tipo_cifras,
                   numero_cifras,fec_inicio,fec_vencimiento,calificacion,
                   vigencia,
                   verificacion,fecha_ver,fecha_modificacion,observacion,estatus
                   ,
                   monto,garantia,cupo_usado,monto_vencido,
                   fec_exp_ref)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@o_siguiente,
                   'F',@v_banco,@v_toperacion,@v_tclase,@v_tipo_cifras,
                   @v_numero_cifras,@v_fec_inicio,@v_fec_vencimiento,
                   @v_calificacion
                   ,
                   @v_data_vigente,
                   @i_verificacion,@i_fecha_ver,
                   --ream 06.abr.2010 control vigencia de datos del ente
                   getdate(),@v_observacion,@v_estatus,
                   @v_monto,@v_garantia,@v_cupo_usado,@v_monto_vencido,
                   @v_fec_exp_ref)

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

      /* Transaccion servicios - cl_financiera */

      insert into ts_referencia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,referencia,
                   tipo,bancoint,toperacion,tclase,tipo_cifras,
                   numero_cifras,fec_inicio,fec_vencimiento,calificacion,
                   vigencia,
                   verificacion,fecha_ver,fecha_modificacion,observacion,estatus
                   ,
                   monto,garantia,cupo_usado,monto_vencido,
                   fec_exp_ref)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@o_siguiente,
                   'F',@w_banco,@w_toperacion,@w_tclase,@w_tipo_cifras,
                   @w_numero_cifras,@w_fec_inicio,@w_fec_vencimiento,
                   @w_calificacion
                   ,
                   @w_data_vigente,
                   @i_verificacion,@i_fecha_ver,
                   --ream 06.abr.2010 control vigencia de datos del ente
                   getdate(),@w_observacion,@w_estatus,
                   @w_monto,@w_garantia,@w_cupo_usado,@w_monto_vencido,
                   @w_fec_exp_ref)

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
    if @t_trn = 179
    begin
      /* Captura de campos para transaccion de servicios */
      select
        @w_banco = institucion,
        @w_toperacion = toperacion,
        @w_tclase = tclase,
        @w_tipo_cifras = tipo_cifras,
        @w_numero_cifras = numero_cifras,
        @w_fec_inicio = fec_inicio,
        @w_fec_vencimiento = fec_vencimiento,
        @w_calificacion = calificacion,
        @w_vigencia = verificacion,
        @w_fecha_ver = fecha_ver,
        @w_fecha_modificacion = fecha_modificacion,
        @w_observacion = observacion,
        @w_estatus = estatus,
        @w_monto = monto,
        @w_garantia = garantia,/* INNUCA */
        @w_cupo_usado = cupo_usado,/* INNUCA */
        @w_monto_vencido = monto_vencido,/* INNUCA */
        @w_fec_exp_ref = fec_exp_ref,/* INNUCA */
        @w_data_vigente = vigencia
      --ream 06.abr.2010 control vigencia de datos del ente

      from   cl_financiera
      where  cliente    = @i_ente
         and referencia = @i_referencia

      /* si no existe referencia financiera, error */
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
      delete from cl_financiera
      where  cliente    = @i_ente
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
                   tipo,bancoint,toperacion,tclase,tipo_cifras,
                   numero_cifras,fec_inicio,fec_vencimiento,calificacion,
                   vigencia,
                   verificacion,fecha_ver,fecha_modificacion,observacion,estatus
                   ,
                   monto,garantia,cupo_usado,monto_vencido,
                   fec_exp_ref)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@o_siguiente,
                   'F',@i_banco,@i_toperacion,@i_tclase,@i_tipo_cifras,
                   @i_numero_cifras,@i_fec_inicio,@i_fec_vencimiento,
                   @i_calificacion
                   ,
                   @w_data_vigente,
                   @i_verificacion,@i_fecha_ver,
                   --ream 06.abr.2010 control vigencia de datos del ente
                   getdate(),@i_observacion,@i_estatus,
                   @i_monto,@i_garantia,@i_cupo_usado,@i_monto_vencido,
                   @i_fec_exp_ref)

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

