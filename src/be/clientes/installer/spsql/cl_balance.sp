/****************************************************************************/
/*      Archivo:                cl_balance.sp                               */
/*      Stored procedure:       sp_balance                                  */
/*      Base de datos:          cobis                                       */
/*      Producto:               Clientes                                    */
/*      Disenado por:           Sandra Ortiz                                */
/*      Fecha de escritura:     09-Sep-1993                                 */
/****************************************************************************/
/*                              IMPORTANTE                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de COBISCorp.                                                           */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*                              PROPOSITO                                   */
/*      Realiza la creacion, modificacion y eliminacion de estados          */
/*      financieros de empresas clientes del banco.                         */
/*      los datos de insercion los toma de tabla temporal                   */
/****************************************************************************/
/*                              MODIFICACIONES                              */
/*      FECHA           AUTOR           RAZON                               */
/*      09-Sep-1993     S Ortiz         Emision inicial                     */
/*      02-May-2016     DFu             Migracion CEN                       */
/****************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_balance')
  drop proc sp_balance
go

create proc sp_balance
(
  @s_ssn          int,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime,
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
  @t_file         varchar(30) = null,
  @t_from         varchar(30) = null,
  @t_trn          int = null,
  @t_show_version bit = 0,
  @i_operacion    char (1),
  @i_modo         tinyint = null,
  @i_cliente      int = null,
  @i_balance      smallint = null,
  @i_tbalance     char(3) = null,
  @i_anio         smallint = null,
  @i_clase_ba     char(1) = null,
  @i_fecha_corte  datetime = null,
  @i_secuencial   int = null,
  @i_trn_ext      char(1) = 'N'
)
as
  declare
    @w_today       datetime,-- FCP 05/Ago/2005
    @w_sp_name     varchar(30),
    @w_return      int,
    @w_balance     smallint,
    @w_cliente     int,
    @w_tbalance    char(3),
    @w_anio        smallint,
    @w_clase_ba    char(1),
    @w_fecha_corte datetime,
    @w_fecha_nac   datetime,
    @w_fecha_cons  datetime,
    @w_tipo        char(1),
    @v_tbalance    char(3),
    @v_anio        smallint,
    @v_clase_ba    char(1),
    @v_fecha_corte datetime,
    @w_bloqueado   char(1),
    @w_plantilla   descripcion,
    @w_parBPACT    varchar(10),
    @w_parBPING    varchar(10),
    @w_parTCPAS    varchar(10),
    @w_act         smallint,
    @w_ing         smallint,
    @w_salir       char(1),
    @w_tipoP       varchar(10),
    @w_total       smallint,
    @o_salir       char(1)

  /*  Inicializacion de Variables  */
  select
    @w_sp_name = 'sp_balance'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate() -- FCP 05/Ago/2005

  /*  Insert  */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1159
    begin
      /* seleccionar los datos almacenados en la tabla temporal */
      select
        @w_tbalance = ba_tbalance,
        @w_cliente = ba_cliente,
        @w_anio = ba_anio,
        @w_clase_ba = ba_clase,
        @w_fecha_corte = ba_fecha_corte
      from   cl_balance_tmp
      where  ba_user = @s_user
         and ba_term = @s_term

      if @@rowcount <> 1
      begin
        /*  Error en insercion de Balance temporal  */
        if @i_trn_ext = 'N'
        begin
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 103075
          return 1
        end
        else
          return 103075
      end

      --select @i_balance     = ba_balance,
      --       @i_anio        = @w_anio,
      --       @i_clase_ba    = @w_clase_ba,
      --       @i_fecha_corte = @w_fecha_corte
      --from   cobis..cl_balance
      --where  ba_cliente     = @w_cliente
      --and    ba_tbalance    = @w_tbalance
      --and    ba_fecha_corte = @w_fecha_corte
      --
      --if @@rowcount > 0
      --begin
      --   select @i_operacion = 'U',
      --          @t_trn       = 1212
      --   goto ACTUALIZAR
      --end

      select
        @w_balance = isnull(max(ba_balance), 0) + 1
      from   cobis..cl_balance
      where  ba_cliente = @w_cliente

      if @@rowcount <> 1
      begin
        /*  No existe cliente  */
        if @i_trn_ext = 'N'
        begin
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 101146
          return 1
        end
        else
          return 101146
      end

      begin tran
      insert into cl_balance
                  (ba_tbalance,ba_fecha_reg,ba_funcionario,ba_oficina,ba_cliente
                   ,
                   ba_balance,ba_anio,ba_clase,
                   ba_fecha_corte)
      values      (@w_tbalance,getdate(),@s_user,@s_ofi,@w_cliente,
                   @w_balance,@w_anio,@w_clase_ba,@w_fecha_corte)
      if @@error <> 0
      begin
        if @i_trn_ext = 'N'
        begin
          /*  Error en insercion de Balance  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 103076
          return 1
        end
        else
          select
            103076
      end

      /*  Actualizacion de Numero de Balances  */
      update cobis..cl_ente
      set    en_balance = @w_balance,
             en_fbalance = @w_today -- FCP 05/Ago/2005
      where  en_ente = @w_cliente

      if @@error <> 0
      begin
        /*  Error en modificacion de ente  */
        if @i_trn_ext = 'N'
        begin
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 105051
          return 105051
        end
        else
          return 105051
      end

      /*  Transaccion de Servicio  */
      insert into ts_balance
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,oficina,cliente,
                   balance,tbalance,anio,clase_ba,fecha_corte,
                   alterno)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@s_ofi,@w_cliente,
                   @w_balance,@w_tbalance,@w_anio,@w_clase_ba,@w_fecha_corte,
                   @i_secuencial)
      if @@error <> 0
      begin
        /*  Error en insercion de Transaccion de Servicio  */
        if @i_trn_ext = 'N'
        begin
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 103005
          return 1
        end
        else
          return 103005
      end

      /* insertar las cuentas que corresponden al presente balance */
      insert into cl_plan
                  (pl_cliente,pl_balance,pl_cuenta,pl_valor)
        select
          @w_cliente,@w_balance,pl_cuenta,pl_valor
        from   cl_plan_tmp
        where  pl_user = @s_user
           and pl_term = @s_term

      if @@error <> 0
      begin
        if @i_trn_ext = 'N'
        begin
          /*  Error en insercion de Estado financiero */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 103076
          return 1
        end
        else
          return 103076
      end

      exec @w_return = sp_datos_balance
        @s_ssn      = @s_ssn,
        @s_user     = @s_user,
        @s_term     = @s_term,
        @s_date     = @s_date,
        @s_srv      = @s_srv,
        @s_lsrv     = @s_lsrv,
        @s_ofi      = @s_ofi,
        @s_rol      = @s_rol,
        @s_org_err  = @s_org_err,
        @s_error    = @s_error,
        @s_sev      = @s_sev,
        @s_msg      = @s_msg,
        @s_org      = @s_org,
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @t_from,
        @t_trn      = 1420,
        @i_cliente  = @w_cliente,
        @i_tbalance = @i_tbalance

      if @w_return <> 0
      begin
        if @i_trn_ext = 'N'
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105082
          /* 'Error en actualizacion de Datos Balance'*/
          return 1
        end
        else
          return 105082
      end
      /* retornar el nuevo secuencial de balance */
      if @i_trn_ext = 'N'
        select
          @w_balance,
          convert(varchar(10), @w_today, 101) -- FCP 05/Ago/2005

      commit tran--FRI 06/28/2007 Def.8370
      /*MGV Buscar estado de bloqueo del ente por informacion incompleta       */
      exec sp_ente_bloqueado
        @s_ssn       = @s_ssn,
        @s_user      = @s_user,
        @s_term      = @s_term,
        @s_date      = @s_date,
        @s_srv       = @s_srv,
        @s_lsrv      = @s_lsrv,
        @s_ofi       = @s_ofi,
        @s_rol       = @s_rol,
        @s_org_err   = @s_org_err,
        @s_error     = @s_error,
        @s_sev       = @s_sev,
        @s_msg       = @s_msg,
        @s_org       = @s_org,
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @t_from,
        @t_trn       = 176,
        @i_operacion = 'U',
        @i_ente      = @w_cliente,
        @o_retorno   = @w_bloqueado output
      return 0
    end
    else
    begin
      if @i_trn_ext = 'N'
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
        return 151051
    end
  end

  --ACTUALIZAR:
  /*  Update  */
  if @i_operacion = 'U'
  begin
    if @t_trn = 1212
    begin
      select
        @w_fecha_nac = p_fecha_nac,
        @w_fecha_cons = c_fecha_const,
        @w_tipo = en_subtipo
      from   cl_ente
      where  en_ente = @i_cliente

      if @w_tipo = 'P'
      begin
        if @w_fecha_nac >= @i_fecha_corte
        begin
          if @i_trn_ext = 'N'
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 107093
            return 1
          end
          else
            return 107093
        end
      end

      if @w_tipo = 'C'
      begin
        if @w_fecha_cons >= @i_fecha_corte
        begin
          if @i_trn_ext = 'N'
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 107079
            return 1
          end
          else
            return 107079
        end
      end

      /* Capturar los datos anteriores */
      select
        @w_anio = ba_anio,
        @w_clase_ba = ba_clase,
        @w_fecha_corte = ba_fecha_corte
      from   cl_balance
      where  ba_cliente = @i_cliente
         and ba_balance = @i_balance

      if @@rowcount = 0
      begin
        if @i_balance is null --Llega por interfaz
        begin
          select
            @w_anio = ba_anio,
            @w_clase_ba = ba_clase,
            @w_fecha_corte = ba_fecha_corte,
            @i_balance = ba_balance
          from   cl_balance
          where  ba_cliente     = @i_cliente
             and ba_fecha_corte = @i_fecha_corte

          if @@rowcount = 0
          begin
            if @i_trn_ext = 'N'
            begin
              /*  No existe Estado Financiero  */
              exec cobis..sp_cerror
                @t_debug= @t_debug,
                @t_file = @t_file,
                @t_from = @w_sp_name,
                @i_num  = 101160
              return 1
            end
            else
              return 101160
          end
        end
      end

      select
        @v_anio = @w_anio,
        @v_clase_ba = @w_clase_ba

      if @w_anio = @i_anio
        select
          @w_anio = null,
          @v_anio = null
      else
        select
          @w_anio = @i_anio

      if @w_clase_ba = @i_clase_ba
        select
          @w_clase_ba = null,
          @v_clase_ba = null
      else
        select
          @w_clase_ba = @i_clase_ba

      if @w_fecha_corte = @i_fecha_corte
        select
          @w_fecha_corte = null,
          @v_fecha_corte = null
      else
        select
          @w_fecha_corte = @i_fecha_corte

      begin tran
      update cl_balance
      set    ba_anio = @i_anio,
             ba_clase = @i_clase_ba,
             ba_fecha_corte = @i_fecha_corte
      where  ba_cliente = @i_cliente
         and ba_balance = @i_balance
      if @@rowcount <> 1
      begin
        if @i_trn_ext = 'N'
        begin
          /*  Error en actualizacion de Estado Financiero  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 105069
          return 1
        end
        else
          return 105069
      end

      /*  Transaccion de Servicio  */
      insert into ts_balance
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,oficina,cliente,
                   balance,tbalance,anio,clase_ba,fecha_corte,
                   alterno)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@s_ofi,@i_cliente,
                   @i_balance,@i_tbalance,@v_anio,@v_clase_ba,@v_fecha_corte,
                   @i_secuencial)
      if @@error <> 0
      begin
        if @i_trn_ext = 'N'
        begin
          /*  Error en insercion de Transaccion de Servicio  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 103005
          return 1
        end
        else
          select
            103005
      end

      insert into ts_balance
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,oficina,cliente,
                   balance,tbalance,anio,clase_ba,fecha_corte,
                   alterno)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@s_ofi,@i_cliente,
                   @i_balance,@i_tbalance,@w_anio,@w_clase_ba,@w_fecha_corte,
                   @i_secuencial)
      if @@error <> 0
      begin
        if @i_trn_ext = 'N'
        begin
          /*  Error en insercion de Transaccion de Servicio  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 103005
          return 1
        end
        else
          return 103005
      end

      /* INICIO RIA01 */
      exec @w_return = sp_datos_balance
        @s_ssn      = @s_ssn,
        @s_user     = @s_user,
        @s_term     = @s_term,
        @s_date     = @s_date,
        @s_srv      = @s_srv,
        @s_lsrv     = @s_lsrv,
        @s_ofi      = @s_ofi,
        @s_rol      = @s_rol,
        @s_org_err  = @s_org_err,
        @s_error    = @s_error,
        @s_sev      = @s_sev,
        @s_msg      = @s_msg,
        @s_org      = @s_org,
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @t_from,
        @t_trn      = 1420,
        @i_cliente  = @i_cliente,
        @i_tbalance = @i_tbalance

      if @w_return <> 0
      begin
        if @i_trn_ext = 'N'
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105082
          /* 'Error en creacion del grupo'*/
          return 1
        end
        else
          return 105082
      end

    /** FCP 05/AGO/2005 INICIO **/
    /*  Actualizacion de Fecha de Actualizacion de Balance */
      --ELA Se agrega porque la data de cl_ente esta en nulo, para balances viejos

      select
        @w_balance = isnull(max(ba_balance),
                            0)
      from   cobis..cl_balance
      where  ba_cliente = @i_cliente

      if @@rowcount <> 1
      begin
        if @i_trn_ext = 'N'
        begin
          /*  No existe cliente  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 101146
          return 1
        end
        else
          return 101146
      end

      update cobis..cl_ente
      set    en_fbalance = @w_today,-- FCP 05/Ago/2005
             en_balance = @w_balance
      where  en_ente = @i_cliente

      if @@error <> 0
      begin
        if @i_trn_ext = 'N'
        begin
          /*  Error en modificacion de ente  */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105051
          return 105051
        end
        else
          return 105051
      end
      /** FCP 05/AGO/2005 FIN **/
      commit tran
      /*MGV Buscar estado de bloqueo del ente por informacion incompleta       */
      exec sp_ente_bloqueado
        @s_ssn       = @s_ssn,
        @s_user      = @s_user,
        @s_term      = @s_term,
        @s_date      = @s_date,
        @s_srv       = @s_srv,
        @s_lsrv      = @s_lsrv,
        @s_ofi       = @s_ofi,
        @s_rol       = @s_rol,
        @s_org_err   = @s_org_err,
        @s_error     = @s_error,
        @s_sev       = @s_sev,
        @s_msg       = @s_msg,
        @s_org       = @s_org,
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @t_from,
        @t_trn       = 176,
        @i_operacion = 'U',
        @i_ente      = @i_cliente,
        @o_retorno   = @w_bloqueado output

      /* MGV Fin Buscar       */
      return 0
    end
    else
    begin
      if @i_trn_ext = 'N'
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
        return 151051
    end
  end

  /*  Delete  */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1213
    begin
      /* Verificar que existe los datos anteriores */
      select
        @w_anio = ba_anio,
        @w_tbalance = ba_tbalance
      from   cl_balance
      where  ba_cliente = @i_cliente
         and ba_balance = @i_balance

      if @@rowcount <> 1
      begin
        if @i_trn_ext = 'N'
        begin
          /*  No existe Estado Financiero  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 101160
          return 1
        end
        else
          return 101160
      end

      begin tran

      /* Borrar el registro correspondiente */
      delete cl_balance
      where  ba_cliente = @i_cliente
         and ba_balance = @i_balance

      if @@error <> 0
      begin
        if @i_trn_ext = 'N'
        begin
          /*  Error en eliminacion de Estado Financiero  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 107064
          return 1
        end
        else
          return 107064
      end

      /*  Transaccion de servicio  */
      insert into ts_balance
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,oficina,cliente,
                   balance,tbalance,anio,clase_ba,fecha_corte,
                   alterno)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@s_ofi,@i_cliente,
                   @i_balance,@w_tbalance,@w_anio,@w_clase_ba,@w_fecha_corte,
                   @i_secuencial)
      if @@error <> 0
      begin
        if @i_trn_ext = 'N'
        begin
          /*  Error en insercion de Transaccion de Servicio  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 103005
          return 1
        end
        else
          return 103005
      end

      /* borrar los datos relacionados que estan en cl_plan
         (borrado en cascada) */
      delete cl_plan
      where  pl_cliente = @i_cliente
         and pl_balance = @i_balance

      if @@error <> 0
      begin
        if @i_trn_ext = 'N'
        begin
          /*  Error en  eliminacion de cuenta de estado financiero */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 107065
          return 1
        end
        else
          return 107065
      end

      /* INICIO RIA01 */
      exec @w_return = sp_datos_balance
        @s_ssn      = @s_ssn,
        @s_user     = @s_user,
        @s_term     = @s_term,
        @s_date     = @s_date,
        @s_srv      = @s_srv,
        @s_lsrv     = @s_lsrv,
        @s_ofi      = @s_ofi,
        @s_rol      = @s_rol,
        @s_org_err  = @s_org_err,
        @s_error    = @s_error,
        @s_sev      = @s_sev,
        @s_msg      = @s_msg,
        @s_org      = @s_org,
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @t_from,
        @t_trn      = 1420,
        @i_cliente  = @i_cliente,
        @i_tbalance = @i_tbalance

      if @w_return <> 0
      begin
        if @i_trn_ext = 'N'
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105082
          /* 'Error en creacion del grupo'*/
          return 1
        end
        else
          return 105082
      end
    /* FIN RIA01 */
    /** FCP 05/AGO/2005 INICIO **/
      /*  Actualizacion de Fecha de Actualizacion de Balance */

      select
        @w_balance = isnull(max(ba_balance), 0) + 1
      from   cobis..cl_balance
      where  ba_cliente = @w_cliente

      if @@rowcount <> 1
      begin
        if @i_trn_ext = 'N'
        begin
          /*  No existe cliente  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 101146
          return 1
        end
        else
          return 101146
      end

      update cobis..cl_ente
      set    en_fbalance = @w_today,-- FCP 05/Ago/2005
             en_balance = @w_balance
      where  en_ente = @i_cliente

      if @@error <> 0
      begin
        if @i_trn_ext = 'N'
        begin
          /*  Error en modificacion de ente  */
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105051
          return 105051
        end
        else
          return 105051
      end
      /** FCP 05/AGO/2005 FIN **/
      commit tran

      /*MGV Buscar estado de bloqueo del ente por informacion incompleta       */
      exec sp_ente_bloqueado
        @s_ssn       = @s_ssn,
        @s_user      = @s_user,
        @s_term      = @s_term,
        @s_date      = @s_date,
        @s_srv       = @s_srv,
        @s_lsrv      = @s_lsrv,
        @s_ofi       = @s_ofi,
        @s_rol       = @s_rol,
        @s_org_err   = @s_org_err,
        @s_error     = @s_error,
        @s_sev       = @s_sev,
        @s_msg       = @s_msg,
        @s_org       = @s_org,
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @t_from,
        @t_trn       = 176,
        @i_operacion = 'U',
        @i_ente      = @i_cliente,
        @o_retorno   = @w_bloqueado output

      /* MGV Fin Buscar       */
      return 0
    end
    else
    begin
      if @i_trn_ext = 'N'
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
        return 151051
    end
  end

  if @i_operacion = 'H'
  begin
    if @t_trn = 1214
    begin
      --verificar a que grupo corresponde el balance
      --SLI NR 663 10/11/2006
      select
        @w_plantilla = tb_col_izquierda
      from   cobis..cl_tbalance
      where  tb_tbalance = @i_tbalance

      if @w_plantilla <> ''
      begin
        --verificar la existencia de la fecha de corte
        if exists (select
                     1
                   from   cobis..cl_balance,
                          cobis..cl_tbalance
                   where  ba_tbalance      = tb_tbalance
                      and ba_cliente       = @i_cliente
                      and ba_fecha_corte   = @i_fecha_corte
                      and tb_col_izquierda = @w_plantilla)
        begin
          if @i_trn_ext = 'N'
          begin
            exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 15100031
            return 0
          end
          else
            return 15100031
        end
        --fin sli NR 663 10/11/2006

        select
          'Balance' = ba_balance,
          'Cliente' = ba_cliente,
          'Cod. tipo' = ba_tbalance,
          'Anio' = ba_anio,
          'Fec Reg' = ba_fecha_reg,
          'Funcionario' = ba_funcionario,
          'Clase ' = ba_clase,
          'Oficina' = ba_oficina,
          'Fecha_Corte' = convert(char(10), ba_fecha_corte, 103)
        from   cl_balance
        where  ba_cliente     = @i_cliente
           and ba_tbalance    = @i_tbalance
           and ba_fecha_corte = @i_fecha_corte
      end
    end
  end

  /*  Search  */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1214
    begin
      set rowcount 20

      if @i_modo = 0
        select
          'Balance' = ba_balance,
          'Cliente' = ba_cliente,
          'Nombre' = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
          'Cod. tipo' = tb_tbalance,
          'Tipo' = convert(char(60), tb_descripcion),--sli 14/11/06
          'Anio' = ba_anio,
          'Izquierda' = tb_col_izquierda,
          'Derecha' = tb_col_derecha,
          'clase ' = ba_clase,
          'Fecha_Corte' = convert(char(10), ba_fecha_corte, 101),
          'Fecha_Modif' = convert(char(10), en_fbalance, 101),-- FCP 05/Ago/2005
          'Automatico' = tb_automatico,
          'T. Cliente' = tb_tcliente,
          'Totaliza' = tb_totaliza
        from   cl_balance,
               cl_ente,
               cl_tbalance
        where  ba_cliente  = @i_cliente
           and en_ente     = ba_cliente
           and en_ente     = @i_cliente
           and tb_tbalance = ba_tbalance
      else if @i_modo = 1
        select
          'Balance' = ba_balance,
          'Cliente' = ba_cliente,
          'Nombre' = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
          'Cod. tipo' = tb_tbalance,
          'Tipo' = convert(char(60), tb_descripcion),
          'Anio' = ba_anio,
          'Izquierda' = tb_col_izquierda,
          'Derecha' = tb_col_derecha,
          'Clase ' = ba_clase,
          'Fecha_Corte' = convert(char(10), ba_fecha_corte, 101),
          'Fecha_Modif' = convert(char(10), en_fbalance, 101),
          'Automatico' = tb_automatico,
          'T. Cliente' = tb_tcliente,
          'Totaliza' = tb_totaliza
        from   cl_balance,
               cl_ente,
               cl_tbalance
        where  ba_cliente  = @i_cliente
           and en_ente     = ba_cliente
           and en_ente     = @i_cliente
           and ba_balance  > @i_balance
           and tb_tbalance = ba_tbalance
      return 0
    end
    else
    begin
      if @i_trn_ext = 'N'
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
        return 151051
    end

    set rowcount 0
  end

  if @i_operacion = 'X'
  begin
    if @t_trn = 1214
    begin
      select
        @w_salir = 'N'

      select
        @w_parBPACT = pa_char --BALANCE PASIVAS ACTIVOS
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'BPACT'

      if @@rowcount <> 1
      begin
        if @i_trn_ext = 'N'
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001,
            @i_msg   = 'NO EXISTE PARAMETRO DE BPACT '
          return 101001
        end
        else
          return 101001
      end

      select
        @w_parBPING = pa_char --BALANCE PASIVAS INGRESOS
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'BPING'

      if @@rowcount <> 1
      begin
        if @i_trn_ext = 'N'
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001,
            @i_msg   = 'NO EXISTE PARAMETRO DE BPING '
          return 101002
        end
        else
          return 101002
      end

      select
        @w_parTCPAS = pa_char --TIPO CLIENTE PASIVAS
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'TCPAS'

      if @@rowcount <> 1
      begin
        if @i_trn_ext = 'N'
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001,
            @i_msg   = 'NO EXISTE PARAMETRO DE BPING '
          return 101003
        end
        else
          return 101003
      end

      select
        @w_tipoP = p_tipo_persona
      from   cobis..cl_ente
      where  en_ente = @i_cliente

      if @@rowcount = 0
      begin
        if @i_trn_ext = 'N'
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101004
          /* 'No existe dato solicitado'*/
          return 1
        end
        else
          return 101004
      end
      select
        @w_total = 0
      select
        @w_act = isnull(count(0),
                        0)
      from   cobis..cl_balance
      where  ba_cliente  = @i_cliente
         and ba_tbalance = @w_parBPACT

      select
        @w_ing = isnull(count(0),
                        0)
      from   cobis..cl_balance
      where  ba_cliente  = @i_cliente
         and ba_tbalance = @w_parBPING

      select
        @w_salir = 'S'
      if @w_parTCPAS = @w_tipoP
      begin
        if @w_act = 0
        begin
          select
            @w_salir = 'N'
        end
        else
        begin
          select
            @w_salir = 'S'
        end

        if @w_ing = 0
        begin
          select
            @w_salir = 'N'
        end
        else
        begin
          select
            @w_salir = 'S'
        end
      end
      select
        @o_salir = @w_salir
      select
        'parametro ' = @o_salir
      return 0
    end
    else
    begin
      if @i_trn_ext = 'N'
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
        return 151051
    end
  end

go

