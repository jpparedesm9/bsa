/*************************************************************************/
/*   Archivo           : cl_tbalance.sp                                  */
/*   Stored procedure  : sp_tbalance                                     */
/*   Base de datos     : cobis                                           */
/*   Producto          : Clientes                                        */
/*   Disenado por      : Mauricio Bayas/Sandra Ortiz                     */
/*   Fecha de escritura: 9-May-1994                                      */
/* ***********************************************************************/
/*                    IMPORTANTE                                         */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de 'COBISCorp'.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/*************************************************************************/
/*                       PROPOSITO                                       */
/*   Este programa permite la creacion y mantenimiento de las            */
/*   instancias de tipo de balances que puede tener un ente.             */
/*************************************************************************/
/*                       MODIFICACIONES                                  */
/*       FECHA        AUTOR           RAZON                              */
/*    9-May-1994   S. Ortiz        Emision inicial                       */
/*    30-Mar-1994  Bco. Prestamos  Requerimientos Banco                  */
/*    15-Abr-2008  JGU             Requerimiento 18                      */
/*    02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/* ***********************************************************************/
use cobis
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_tbalance')
  drop proc sp_tbalance
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_tbalance
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
  @i_operacion     char (1),
  @i_modo          tinyint = null,
  @i_tipo          char (1) = null,
  @i_tbalance      char (3) = null,
  @i_descripcion   descripcion = null,
  @i_estado        estado = null,
  @i_col_izquierda descripcion = null,
  @i_col_derecha   descripcion = null,
  @i_automatico    char(1) = null,
  @i_tcliente      char(1) = null,
  @i_totaliza      char(1) = null
)
as
  declare
    @w_sp_name       varchar(30),
    @w_descripcion   descripcion,
    @w_estado        estado,
    @w_col_izquierda descripcion,
    @w_col_derecha   descripcion,
    @v_descripcion   descripcion,
    @v_estado        estado,
    @v_col_izquierda descripcion,
    @v_col_derecha   descripcion,
    @w_automatico    char(1),
    @w_tcliente      char(1),
    @v_automatico    char(1),
    @v_tcliente      char(1)

  select
    @w_sp_name = 'sp_tbalance'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Insert  */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1142
    begin
      if exists (select
                   tb_tbalance
                 from   cl_tbalance
                 where  tb_tbalance = @i_tbalance)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101169
        /*  'Ya existe tipo de balance ' */
        return 1
      end

      begin tran
      insert into cl_tbalance
                  (tb_tbalance,tb_descripcion,tb_estado,tb_col_izquierda,
                   tb_col_derecha,
                   tb_automatico,tb_tcliente,tb_totaliza)
      values      (@i_tbalance,@i_descripcion,'V',@i_col_izquierda,
                   @i_col_derecha,
                   @i_automatico,@i_tcliente,@i_totaliza)
      if @@error <> 0
      begin
        /*  Error en creacion de Tipo de Balance  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 1
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_tbalance
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,tbalance,descripcion,
                   estado,col_izquierda,col_derecha,automatico,tcliente,
                   totaliza)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_tbalance,@i_descripcion,
                   'V',@i_col_izquierda,@i_col_derecha,@i_automatico,@i_tcliente
                   ,
                   @i_totaliza)
      if @@error <> 0
      begin
        /*  Error en creacion de la Transaccion de Servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end

      delete cl_tplan_tmp
      where  tpt_usuario  = @s_user
         and tpt_terminal = @s_term
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

  /*  Update  */
  if @i_operacion = 'U'
  begin
    if @t_trn = 1143
    begin
      select
        @w_descripcion = tb_descripcion,
        @w_estado = tb_estado,
        @w_col_izquierda = tb_col_izquierda,
        @w_col_derecha = tb_col_derecha,
        @w_automatico = tb_automatico,
        @w_tcliente = tb_tcliente
      from   cl_tbalance
      where  tb_tbalance = @i_tbalance

      if @@rowcount <> 1
      begin
        /*  No existe Tipo de Balance  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101125
        return 1
      end

      select
        @v_descripcion = @w_descripcion,
        @v_estado = @w_estado,
        @v_col_izquierda = @w_col_izquierda,
        @v_col_derecha = @w_col_derecha,
        @v_automatico = @w_automatico,
        @v_tcliente = @w_tcliente

      if @w_descripcion = @i_descripcion
        select
          @w_descripcion = null,
          @v_descripcion = null
      else
        select
          @w_descripcion = @i_descripcion
      if @w_estado = @i_estado
        select
          @w_estado = null,
          @v_estado = null
      else
        select
          @w_estado = @i_estado
      if @w_col_izquierda = @i_col_izquierda
        select
          @w_col_izquierda = null,
          @v_col_izquierda = null
      else
        select
          @w_col_izquierda = @i_col_izquierda
      if @w_col_derecha = @i_col_derecha
        select
          @w_col_derecha = null,
          @v_col_derecha = null
      else
        select
          @w_col_derecha = @i_col_derecha
      if @w_automatico = @i_automatico
        select
          @w_automatico = null,
          @v_automatico = null
      else
        select
          @w_automatico = @i_automatico
      if @w_tcliente = @i_tcliente
        select
          @w_tcliente = null,
          @v_tcliente = null
      else
        select
          @w_tcliente = @i_tcliente

      begin tran
      update cl_tbalance
      set    tb_descripcion = @i_descripcion,
             tb_estado = @i_estado,
             tb_col_izquierda = @i_col_izquierda,
             tb_col_derecha = @i_col_derecha,
             tb_automatico = @i_automatico,
             tb_tcliente = @i_tcliente,
             tb_totaliza = @i_totaliza
      where  tb_tbalance = @i_tbalance
      if @@error <> 0
      begin
        /*  Error en la actualizacion de Tipo de Balance  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105058
        return 1
      end
      /*  Transaccion de Servicios  */
      insert into ts_tbalance
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,tbalance,descripcion,
                   estado,col_izquierda,col_derecha,automatico,tcliente)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_tbalance,@v_descripcion,
                   @v_estado,@v_col_izquierda,@v_col_derecha,@v_automatico,
                   @v_tcliente)

      if @@error <> 0
      begin
        /*  Error en creacion de la Transaccion de Servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end
      insert into ts_tbalance
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,tbalance,descripcion,
                   estado,col_izquierda,col_derecha,automatico,tcliente)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_tbalance,@w_descripcion,
                   @w_estado,@w_col_izquierda,@w_col_derecha,@w_automatico,
                   @w_tcliente)
      if @@error <> 0
      begin
        /*  Error en creacion de la Transaccion de Servicio  */
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

  /*  Delete  */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1144
    begin
      select
        @w_descripcion = tb_descripcion,
        @w_estado = tb_estado,
        @w_col_izquierda = tb_col_izquierda,
        @w_col_derecha = tb_col_derecha,
        @w_automatico = tb_automatico,
        @w_tcliente = tb_tcliente
      from   cl_tbalance
      where  tb_tbalance = @i_tbalance
      if @@rowcount <> 1
      begin
        /*  No existe Tipo de Balance  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101125
        return 1
      end

      /* Validar la existencia de la asociaci¢n de cuentas al plan */
      if not exists (select
                       1
                     from   cl_tplan
                     where  tp_tbalance = @i_tbalance)
        if @@rowcount <> 1
        begin
          /*  No existe Tipo de Plan  */
          exec cobis..sp_cerror
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 101127
          return 1
        end

      begin tran
      delete cl_tbalance
      where  tb_tbalance = @i_tbalance
      if @@error <> 0
      begin
        /*  Error en la eliminacion de Tipo de Balance  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 107057
        return 1
      end
      /*  Transaccion de Servicios  */
      insert into ts_tbalance
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,tbalance,descripcion,
                   estado,col_izquierda,col_derecha,automatico,tcliente)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_tbalance,@w_descripcion,
                   @w_estado,@w_col_izquierda,@w_col_derecha,@w_automatico,
                   @w_tcliente)
      if @@error <> 0
      begin
        /*  Error en creacion de la Transaccion de Servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end

      /* Eliminar la asociaci¢n de cuentas al plan */
      delete cl_tplan
      where  tp_tbalance = @i_tbalance

      if @@error <> 0
      begin
        /*  Error en la eliminacion de Tipo de Plan  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 107058
        return 1
      end
      /*  Transaccion de Servicios  */
      insert into ts_tplan
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,tbalance,cuenta)
      values      (@s_ssn,1147,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_tbalance,null)
      if @@error <> 0
      begin
        /*  Error en creacion de la Transaccion de Servicio  */
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

  /*  SEARCH  */
  if @i_operacion = 'S'
  begin
    if @t_trn = 144
    begin
      set rowcount 20
      if @i_modo = 0
        select
          'Codigo' = tb_tbalance,
          'T.Balance' = tb_descripcion,
          'Col. Izquierda' = tb_col_izquierda,
          'Col. Derecha' = tb_col_derecha,
          'Estado' = tb_estado,
          'Automático' = tb_automatico,
          'T. Cliente' = tb_tcliente,
          'Totaliza' = tb_totaliza
        from   cl_tbalance
      else
        select
          'Codigo' = tb_tbalance,
          'T.Balance' = tb_descripcion,
          'Col. Izquierda' = tb_col_izquierda,
          'Col. Derecha' = tb_col_derecha,
          'Estado' = tb_estado,
          'Automático' = tb_automatico,
          'T. Cliente' = tb_tcliente,
          'Totaliza' = tb_totaliza
        from   cl_tbalance
        where  @i_tbalance > @i_tbalance
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

  /*  QUERY  */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 145
    begin
      select
        tb_tbalance,
        tb_descripcion,
        tb_estado,
        tb_col_izquierda,
        tb_col_derecha,
        tb_automatico,
        tb_tcliente,
        tb_totaliza
      from   cl_tbalance
      where  tb_tbalance = @i_tbalance

      if @@rowcount <> 0
      begin
        /*  No existe Tipo de Balance  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101169
        return 1
      end
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

  /*  HELP  */
  if @i_operacion = 'H'
  begin
    if @t_trn = 146
    begin
      if @i_tipo = 'A'
      begin
        set rowcount 20
        if @i_modo = 0
          select
            'Cod.' = tb_tbalance,
            'Descripcion' = tb_descripcion,
            'Columna.Izquierda'= tb_col_izquierda,
            'Columna.Derecha' = tb_col_derecha,
            'Automático' = tb_automatico,
            'T. Cliente' = tb_tcliente,
            'Totaliza' = tb_totaliza
          from   cl_tbalance
          where  tb_estado = 'V'
        else
          select
            'Cod.' = tb_tbalance,
            'Descripcion'= tb_descripcion,
            'Col.Izq.' = tb_col_izquierda,
            'Col.Der.' = tb_col_derecha,
            'Automático' = tb_automatico,
            'T. Cliente' = tb_tcliente,
            'Totaliza' = tb_totaliza
          from   cl_tbalance
          where  tb_tbalance > @i_tbalance
             and tb_estado   = 'V'
        set rowcount 0
      end
      if @i_tipo = 'V'
      begin
        select
          tb_tbalance,
          tb_descripcion,
          tb_col_izquierda,
          tb_col_derecha,
          tb_automatico,
          tb_tcliente,
          tb_totaliza
        from   cl_tbalance
        where  tb_tbalance = @i_tbalance
           and tb_estado   = 'V'

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101125
          /*  'No Existe tipo de balance' */
          return 1
        end
      end
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

go

