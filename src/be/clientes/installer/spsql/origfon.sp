/************************************************************************/
/*  Archivo           :   origfon.sp                                    */
/*  Stored procedure  :   sp_origen_fondos                              */
/*  Base de datos     :   cobis                                         */
/*  Producto          :   Clientes                                      */
/*  Disenado por      :   Esmeralda Capera Patino                       */
/*  Fecha de escritura:   02-Dic-02                                     */
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
/*  Insercion de contacto                                               */
/*      Query general y especifico de contactos                         */
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*  03/Abr/2001     E. Capera        Emision Inicial                    */
/*  06/Dic/2006     R. Adames        Optimizacion                       */
/*  06/Abr/2010     R.Altamirano     Control de vigencia de datos del   */
/*                                   Ente                               */
/*  09/04/2013      A. Munoz         Requerimiento 0353 Alianzas        */
/*  04/May/2016     T. Baidal        Migracion a CEN                    */
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
           where  name = 'sp_origen_fondos')
    drop proc sp_origen_fondos
go

create proc sp_origen_fondos
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
  @i_origen_fondos mensaje = null,
  @i_producto      char(3) = null,
  @i_numero        cuenta = null,
  @i_numero_old    cuenta = null,

  /* campos cca 353 alianzas bancamia --AAMG*/
  @i_crea_ext      char(1) = null,
  @o_msg_msv       varchar(255) = null out
)
as
  declare
    @w_sp_name            varchar(32),
    @w_codigo             int,
    @w_return             int,
    @w_origen_fondos      mensaje,
    @w_producto           char(3),
    @w_numero             cuenta,
    @w_fecha_reg          datetime,
    @w_fecha_registro     datetime,
    @w_fecha_modificacion datetime,
    @w_funcionario        login,
    @o_ente               int,
    @o_origen_fondos      mensaje,
    @o_producto           char(3),
    @o_descprod           varchar(64),
    @o_numero             cuenta,
    @o_fecha_registro     datetime,
    @o_fecha_modificacion datetime,
    @o_funcionario        login,
    @w_vigencia           catalogo,
    --ream 06.abr.2010 control vigencia de datos del ente
    @v_vigencia           catalogo,
    --ream 06.abr.2010 control vigencia de datos del ente
    @o_vigencia           catalogo
  --ream 06.abr.2010 control vigencia de datos del ente

  select
    @w_sp_name = 'sp_origen_fondos'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 156
    begin
      select
        @w_vigencia = 'S' --ream 06.abr.2010 control vigencia de datos del ente

      begin tran
      /* Insercion cl_origen_fondos */
      insert into cl_origen_fondos
                  (of_ente,of_origen_fondos,of_producto,of_numero,
                   of_fecha_registro,
                   of_fecha_modificacion,of_funcionario,of_vigencia
      --ream 06.abr.2010 control vigencia de datos del ente
      )
      values      (@i_ente,@i_origen_fondos,@i_producto,@i_numero,@s_date,
                   null,@s_user,@w_vigencia
      --ream 06.abr.2010 control vigencia de datos del ente
      )

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        if @i_crea_ext is null
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105508
          /* 'Error en creacion de contacto */
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: Insercion Origen de Fondos, Cliente ' + @i_ente
                         +
                         ', '
                         +
                                @w_sp_name
          select
            @w_return = 105508
          return @w_return
        end
      end

      /*  Transaccion de Servicio  */
      insert into ts_origen_fondos
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,origen_fondos,
                   producto,numero,fecha_registro,fecha_modificacion,funcionario
                   ,
                   vigencia
      --ream 06.abr.2010 control vigencia de datos del ente
      )
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_origen_fondos,
                   @i_producto,@i_numero,@s_date,null,@s_user,
                   @w_vigencia
      --ream 06.abr.2010 control vigencia de datos del ente
      )

      if @@error <> 0
      begin
        if @i_crea_ext is null
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
        begin
          select
            @o_msg_msv = 'Error: Insercion TS Origen de Fondos, Cliente ' +
                         @i_ente
                         +
                         ', '
                         +
                                @w_sp_name
          select
            @w_return = 103005
          return @w_return
        end
      end
      commit tran
    end
    else
    begin
      if @i_crea_ext is null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105513
        /*  'No corresponde codigo de transaccion' */
        return 1
      end
      else
      begin
        select
          @o_msg_msv = 'Error: Numero de Transaccion No Corresponde, ' +
                       @w_sp_name
        select
          @w_return = 105513
        return @w_return
      end
    end
  end

  /** Update **/
  if @i_operacion = 'U'
  begin
    if @t_trn = 157
    begin
      select
        @w_origen_fondos = of_origen_fondos,
        @w_producto = of_producto,
        @w_numero = of_numero,
        @w_fecha_registro = of_fecha_registro,
        @w_fecha_modificacion = of_fecha_modificacion,
        @w_funcionario = of_funcionario,
        @w_vigencia = of_vigencia
      --ream 06.abr.2010 control vigencia de datos del ente
      from   cl_origen_fondos
      where  of_ente = @i_ente

      if @@rowcount = 0
      begin
        select
          @w_vigencia = 'S'
        --ream 06.abr.2010 control vigencia de datos del ente

        insert into cl_origen_fondos
                    (of_ente,of_origen_fondos,of_producto,of_numero,
                     of_fecha_registro,
                     of_fecha_modificacion,of_funcionario,of_vigencia
        --ream 06.abr.2010 control vigencia de datos del ente
        )
        values      (@i_ente,@i_origen_fondos,@i_producto,@i_numero,@s_date,
                     null,@s_user,@w_vigencia
        --ream 06.abr.2010 control vigencia de datos del ente
        )
        if @@error <> 0
        begin
          if @i_crea_ext is null
          begin
            /* Error en Insercion Origen de Fondos */
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 105508
            return 1
          end
          else
          begin
            select
              @o_msg_msv = 'Error: Insercion Origen de Fondos, Cliente ' +
                           @i_ente
                           +
                           ', '
                           +
                                  @w_sp_name
            select
              @w_return = 105508
            return @w_return
          end
        end
      end
      else
      begin
        select
          @v_vigencia = null,
          @w_vigencia = null
        --ream 06.abr.2010 control vigencia de datos del ente

        /* modificar, los datos */
        update cl_origen_fondos
        set    of_origen_fondos = @i_origen_fondos,
               of_producto = @i_producto,
               of_numero = @i_numero,
               of_fecha_modificacion = getdate(),
               of_funcionario = @s_user
        where  of_ente = @i_ente

        if @@error <> 0
        begin
          if @i_crea_ext is null
          begin
            /*'Error en actualizacion Origen de Fondos'*/
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 105509
            return 1
          end
          else
          begin
            select
              @o_msg_msv = 'Error: Actualizando Origen de Fondos, Cliente ' +
                           @i_ente
                           +
                           ', '
                           +
                                  @w_sp_name
            select
              @w_return = 105509
            return @w_return
          end
        end
        /*  Transaccion de Servicio Registro Previo  */
        insert into ts_origen_fondos
                    (secuencial,tipo_transaccion,clase,fecha,usuario,
                     terminal,srv,lsrv,ente,origen_fondos,
                     producto,numero,fecha_registro,fecha_modificacion,
                     funcionario
                     ,
                     vigencia
        --ream 06.abr.2010 control vigencia de datos del ente
        )
        values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                     @s_term,@s_srv,@s_lsrv,@i_ente,@w_origen_fondos,
                     @w_producto,@w_numero,@w_fecha_registro,
                     @w_fecha_modificacion
                     ,
                     @s_user,
                     @v_vigencia
        --ream 06.abr.2010 control vigencia de datos del ente
        )
        if @@error <> 0
        begin
          if @i_crea_ext is null
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
          begin
            select
              @o_msg_msv = 'Error: Insercion TS Origen de Fondos, Cliente ' +
                           @i_ente
                           +
                           ', '
                           +
                                  @w_sp_name
            select
              @w_return = 103005
            return @w_return
          end
        end

        /*  Transaccion de Servicio Registro Actual  */
        insert into ts_origen_fondos
                    (secuencial,tipo_transaccion,clase,fecha,usuario,
                     terminal,srv,lsrv,ente,origen_fondos,
                     producto,numero,fecha_registro,fecha_modificacion,
                     funcionario
                     ,
                     vigencia
        --ream 06.abr.2010 control vigencia de datos del ente
        )
        values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                     @s_term,@s_srv,@s_lsrv,@i_ente,@i_origen_fondos,
                     @i_producto,@i_numero,@w_fecha_registro,getdate(),
                     @w_funcionario,
                     @w_vigencia
        --ream 06.abr.2010 control vigencia de datos del ente
        )
        if @@error <> 0
        begin
          if @i_crea_ext is null
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
          begin
            select
              @o_msg_msv = 'Error: Insercion TS Origen de Fondos, Cliente ' +
                           @i_ente
                           +
                           ', '
                           +
                                  @w_sp_name
            select
              @w_return = 103005
            return @w_return
          end
        end
      end
    end
    else
    begin
      if @i_crea_ext is null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105513
        /*  'No corresponde codigo de transaccion' */
        return 1
      end
      else
      begin
        select
          @o_msg_msv = 'Error: Numero de Transaccion No Corresponde, ' +
                       @w_sp_name
        select
          @w_return = 105513
        return @w_return
      end
    end
  end

  /** Delete **/
  if @i_operacion = 'D'
  begin
    if @t_trn = 158
    begin
      select
        @w_origen_fondos = of_origen_fondos,
        @w_producto = of_producto,
        @w_numero = of_numero,
        @w_fecha_reg = of_fecha_registro,
        @w_vigencia = of_vigencia
      --ream 06.abr.2010 control vigencia de datos del ente
      from   cl_origen_fondos
      where  of_ente = @i_ente

      /* si no existe contacto */
      if @@rowcount = 0
      begin
        if @i_crea_ext is null
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /* 'No dato solicitado' */
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: No existe Origen de Fondos, Cliente ' + @i_ente
                         +
                         ', '
                         +
                                @w_sp_name
          select
            @w_return = 101001
          return @w_return
        end
      end

      begin tran

      /* borrar el origen de fondos */
      delete from cl_origen_fondos
      where  of_ente = @i_ente

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        if @i_crea_ext is null
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105510
          /* 'Error en eliminacion de origen de fondos'*/
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: Eliminando Origen de Fondos, Cliente ' +
                         @i_ente
                         +
                         ', '
                         +
                                @w_sp_name
          select
            @w_return = 105510
          return @w_return
        end
      end

      /*  Transaccion de Servicio  */
      insert into ts_origen_fondos
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,origen_fondos,
                   producto,numero,fecha_registro,fecha_modificacion,funcionario
                   ,
                   vigencia
      --ream 06.abr.2010 control vigencia de datos del ente
      )
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@w_origen_fondos,
                   @w_producto,@w_numero,@s_date,@w_fecha_reg,@s_user,
                   @w_vigencia
      --ream 06.abr.2010 control vigencia de datos del ente
      )

      if @@error <> 0
      begin
        if @i_crea_ext is null
        begin
          /*  Error en creacion de transaccion de servicio  */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103005
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: Insercion TS Origen de Fondos, Cliente ' +
                         @i_ente
                         +
                         ', '
                         +
                                @w_sp_name
          select
            @w_return = 103005
          return @w_return
        end
      end
      commit tran
      return 0
    end
    else
    begin
      if @i_crea_ext is null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105513
        /*  'No corresponde codigo de transaccion' */
        return 1
      end
      else
      begin
        select
          @o_msg_msv = 'Error: Numero de Transaccion No Corresponde, ' +
                       @w_sp_name
        select
          @w_return = 105513
        return @w_return
      end
    end
  end

  /** Search **/
  if @i_operacion = 'S'
  begin
    if @t_trn = 159
    begin
      select
        'ORIGEN DE FONDOS ' = of_origen_fondos,
        'PRODUCTO ' = of_producto,
        'DESCRIPCION ' = (select
                            pd_descripcion
                          from   cl_producto
                          where  pd_abreviatura = (select
                                                     pi_producto
                                                   from   ad_pro_instalado
                                                   where
                                 o.of_producto = pi_producto)
                         ),
        'NUMERO ' = of_numero,
        'FECHA REGISTRO ' = convert (char(10), of_fecha_registro, 101),
        'FECHA MODIF.' = convert(char(10), of_fecha_modificacion, 101),
        'FUNCIONARIO ' = of_funcionario,
        'VIGENTE' = of_vigencia
      --ream 06.abr.2010 control vigencia de datos del ente
      from   cl_origen_fondos o
      where  of_ente = @i_ente
      return 0
    end
    else
    begin
      if @i_crea_ext is null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105513
        /*  'No corresponde codigo de transaccion' */
        return 1
      end
      else
      begin
        select
          @o_msg_msv = 'Error: Numero de Transaccion No Corresponde, ' +
                       @w_sp_name
        select
          @w_return = 105513
        return @w_return
      end
    end
  end

/** Query **/
  /* Datos especificos de un origen de fondos */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 160
    begin
      select
        @o_ente = of_ente,
        @o_origen_fondos = of_origen_fondos,
        @o_producto = of_producto,
        @o_descprod = pd_descripcion,
        @o_numero = of_numero,
        @o_fecha_registro = of_fecha_registro,
        @o_fecha_modificacion = of_fecha_modificacion,
        @o_funcionario = of_funcionario,
        @o_vigencia = of_vigencia
      --ream 06.abr.2010 control vigencia de datos del ente
      from   cl_origen_fondos,
             ad_pro_instalado,
             cl_producto
      where  of_ente     = @i_ente
         and of_numero   = convert(varchar(24), @i_numero)
         and pi_producto = pd_abreviatura
         and pi_producto = of_producto

      if @@rowcount = 0
      begin
        if @i_crea_ext is null
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /* 'No existe dato solicitado'*/
          return 1
        end
        else
        begin
          select
            @o_msg_msv = 'Error: No existe Origen de Fondos, Cliente ' + @i_ente
                         +
                         ', '
                         +
                                @w_sp_name
          select
            @w_return = 101001
          return @w_return
        end
      end

      select
        @o_ente,
        @o_origen_fondos,
        @o_producto,
        @o_descprod,
        @o_numero,
        convert (char(10), @o_fecha_registro, 101),
        convert (char(10), @o_fecha_modificacion, 101),
        @o_funcionario,
        @o_vigencia --ream 06.abr.2010 control vigencia de datos del ente
      return 0
    end
    else
    begin
      if @i_crea_ext is null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105513
        /*  'No corresponde codigo de transaccion' */
        return 1
      end
      else
      begin
        select
          @o_msg_msv = 'Error: Numero de Transaccion No Corresponde, ' +
                       @w_sp_name
        select
          @w_return = 105513
        return @w_return
      end
    end
  end

go

