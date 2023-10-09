/************************************************************************/
/*  Archivo:                  tplan.sp                                  */
/*  Stored procedure:         sp_tplan                                  */
/*  Base de datos:            cobis                                     */
/*  Producto:                 Clientes                                  */
/*  Disenado por:             Mauricio Bayas/Sandra Ortiz               */
/*  Fecha de escritura:       9-May-1994                                */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*  Permite crear y dar mantenimiento de las cuentas asignadas          */
/*  a un tipo de balance particular.                                    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  9-May-1994  S. Ortiz    Emision inicial                             */
/*     12/Mar/2003      E. Laguna       Ajustes Cuenta int              */
/*     18/Jun/2003      E. Laguna       Ajustes siguiente x secuencial  */
/*     04/Ags/2003      D. Duran    Ajuste siguiente                    */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
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
           where  name = 'sp_tplan')
           drop proc sp_tplan
go

create proc sp_tplan
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
  @i_operacion    char (1),
  @i_modo         tinyint = null,
  @i_tbalance     char (3) = null,
  @i_cuenta       int = null,
  @i_secuencial   int = null,
  @i_categoria    char (1) = null
)
as
  declare
    @w_sp_name varchar(30),
    @w_estado  estado

  select
    @w_sp_name = 'sp_tplan'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Insert  */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1145
    begin
      /*  Insertar en la tabla definitiva  */
      begin tran
      insert into cl_tplan
                  (tp_tbalance,tp_cuenta,tp_secuencial)
        /* Modificado 25/03/2003 GCastaneda*/
        select
          tpt_tbalance,tpt_cuenta,tpt_secuencial
        from   cl_tplan_tmp
        where  tpt_usuario  = @s_user
           and tpt_terminal = @s_term
      if @@error <> 0
      begin
        /*  Error en creacion de Tipo de Plan  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @t_from,
          @i_num  = 103066
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

  /*  Delete  */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1147
    begin
      if not exists (select
                       *
                     from   cl_tplan
                     where  tp_tbalance = @i_tbalance
                        and tp_cuenta   = @i_cuenta)
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
      delete cl_tplan
      where  tp_tbalance = @i_tbalance
         and tp_cuenta   = @i_cuenta
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
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_tbalance,@i_cuenta)
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
    if @t_trn = 149
    begin
      set rowcount 20
      if @i_modo = 0
        select
          'Cuenta' = tp_cuenta,
          'Nombre Cuenta' = ct_descripcion,--substring(ct_descripcion, 1, 30),
          'Categoria' = ct_categoria,
          'Secuencial' = tp_secuencial
        from   cl_tplan,
               cl_tbalance,
               cl_cuenta
        where  tp_tbalance = @i_tbalance
           and tb_tbalance = tp_tbalance
           and ct_cuenta   = tp_cuenta
        order  by ct_categoria,
                  tp_secuencial
      --,ct_categoria /* antes ordenaba por tp_cuenta GustavoC */
      else
        select
          'Cuenta' = tp_cuenta,
          'Nombre Cuenta' = ct_descripcion,--substring(ct_descripcion, 1, 30),
          'Categoria' = ct_categoria,
          'Secuencial' = tp_secuencial
        from   cl_tplan,
               cl_tbalance,
               cl_cuenta
        where  tb_tbalance   = tp_tbalance
           and tb_tbalance   = @i_tbalance
           and ct_cuenta     = tp_cuenta
           and (ct_categoria  > @i_categoria
                 or (ct_categoria  = @i_categoria
                     and tp_secuencial > @i_secuencial))
        --             and  tp_secuencial   >= @i_secuencial
        --                 and  ct_categoria >= @i_categoria
        order  by ct_categoria,
                  tp_secuencial
      --, ct_categoria /* antes ordenaba por tp_cuenta GustavoC */
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

  if @i_operacion = 'R'
  begin
    if @t_trn = 1145
    begin
      if not exists(select
                      *
                    from   cl_tbalance
                    where  tb_tbalance = @i_tbalance
                       and tb_estado   = 'V')
      begin
        /*  No existe Tipo de Balance  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101125
        return 1
      end

      if not exists(select
                      *
                    from   cl_cuenta
                    where  ct_cuenta = @i_cuenta
                       and ct_estado = 'V')
      begin
        /*  No existe Cuenta  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101127
        return 1
      end

      if exists(select
                  tp_tbalance
                from   cl_tplan
                where  tp_tbalance = @i_tbalance
                   and tp_cuenta   = @i_cuenta)
      begin
        /*  Ya existe cuenta  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101167
        return 1
      end

      begin tran
      insert into cobis..cl_tplan
      values      ( @i_tbalance,@i_cuenta,@s_ssn )
      /*  @s_ssn Un value mas para el nuevo campo */
      if @@error <> 0
      begin
        /*  Error en creacion de Tipo de Plan  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @t_from,
          @i_num  = 103066
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

