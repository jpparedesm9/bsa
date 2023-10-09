/************************************************************************/
/*  Archivo:                ases_creaupd.sp                             */
/*  Stored procedure:       sp_asesor_creacion_upd                      */
/*  Base de datos:          cobis                                       */
/*  Producto:               Clientes                                    */
/*  Disenado por:           Mauricio Bayas/Sandra Ortiz                 */
/*  Fecha de escritura:     05-Nov-1992                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/************************************************************************/
/*  Este stored procedure procesa:                                      */
/*  Actualizacion del asesor comercial de un cliente o grupo            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA           AUTOR       RAZON           NEMONICO                */
/*  10/Ene/96       S. Meza     Considerar oficial del cliente o grupo  */
/*  21/Oct/2002     D.Duran     Comentar Banca  Gerente/Oficial         */
/*  18/Mar/2004     E.Laguna    Tunning afectacion historicos           */
/*  May/02/2016     DFu         Migracion CEN                           */
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
           where  name = 'sp_asesor_creacion_upd')
  drop proc sp_asesor_creacion_upd
go

create proc sp_asesor_creacion_upd
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
  @i_ente         int = null,
  @i_tipo_cli     char(1) = null,
  @i_filial       tinyint = null,
  @i_oficina      smallint = null,
  @i_oficial      smallint = null,
  @o_dif_oficial  tinyint = null out,
  @i_oficial_sup  smallint = null
)
as
  declare
    @w_today           datetime,
    @w_sp_name         varchar(32),
    @w_return          int,
    @w_siguiente       int,
    @w_codigo          int,
    @w_tipo_cli        char(1),
    @w_filial          int,
    @w_fecha_asig      datetime,
    @w_cg_cliente      int,
    @w_oficina         smallint,
    @ww_oficial        varchar(64),
    @vw_oficial        varchar(64),
    @w_oficiald        smallint,
    @w_oficial         smallint,
    @v_oficial         smallint,
    @v_oficial_ant     smallint,
    @w_oficial_sup     smallint,
    @v_oficial_sup     smallint,
    @v_oficial_sup_ant smallint

  select
    @w_sp_name = 'sp_asesor_creacion_upd'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = @s_date /* getdate() */

  /* Update */

  if @i_operacion = 'U'
  begin
    if @t_trn = 1494
    begin
      /* seleccionar los datos anteriores del cliente */

      if @i_tipo_cli <> 'G'
      begin
        select
          @w_oficial = en_oficial,
          @w_oficial_sup = en_oficial_sup
        from   cl_ente
        where  en_ente    = @i_ente
           and en_subtipo = @i_tipo_cli
      end
      else
      begin
        select
          @w_oficial = gr_oficial
        from   cl_grupo
        where  gr_grupo = @i_ente
      end
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101129
        /*  'No existe cliente indicado'*/
        return 1
      end

      select
        @w_codigo = oc_oficial
      from   cc_oficial
      where  oc_oficial = @i_oficial

      if @@rowcount = 0
         and @i_oficial is not null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101036
        /* 'No existe oficial'*/
        return 1
      end

      if @w_oficial is not null
      begin
        select
          @v_oficial = @w_oficial

        /* capturar los datos que han cambiado */

        select
          @v_oficial_ant = @w_oficial,
          @v_oficial_sup_ant = @w_oficial_sup

        if @w_oficial = @i_oficial
          select
            @w_oficial = null,
            @v_oficial = null
        else
          select
            @w_oficial = @i_oficial

        if @w_oficial_sup = @i_oficial_sup
          select
            @w_oficial_sup = null,
            @v_oficial_sup = null
        else
          select
            @w_oficial_sup = @i_oficial_sup
      end

      begin tran
      /******* actualizacion de asesor **********/
      if @i_tipo_cli <> 'G'
      begin
        update cl_ente
        set    en_oficial = @i_oficial,
               en_oficial_sup = @i_oficial_sup
        where  en_ente    = @i_ente
           and en_subtipo = @i_tipo_cli
      end
      else
      begin
        update cl_grupo
        set    gr_oficial = @i_oficial
        where  gr_grupo = @i_ente

      end
      if @@error != 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105026
      /* CAMBIAR CODIGO ERROR */
        /* 'Error en actualizacion de Cliente'*/
        return 1
      end

      if @i_tipo_cli <> 'G'
      begin
        if exists (select
                     cg_ente
                   from   cl_cliente_grupo
                   where  cg_ente = @i_ente)
        begin
          update cl_cliente_grupo
          set    cg_oficial = @i_oficial
          where  cg_ente = @i_ente

          if @@error != 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 155020
            /* 'Error en actualizacion '*/
            return 1
          end
        end

        select
          @vw_oficial = convert(varchar(64), @v_oficial)
        select
          @ww_oficial = convert(varchar(64), @w_oficial)

        if @vw_oficial <> @ww_oficial
        begin
          insert into cl_actualiza
                      (ac_ente,ac_fecha,ac_tabla,ac_campo,ac_valor_ant,
                       ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2
          )
          values      (@i_ente,@s_date,'cl_ente','en_oficial',@vw_oficial,
                       @ww_oficial,'U',null,null)
          if @@error != 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 103001
            return 1 /*'Error en creacion de cliente'*/
          end
        end

      end

      if @w_oficial is not null
      begin
        select
          @w_fecha_asig = ej_fecha_asig
        from   cl_ejecutivo
        where  ej_ente     = @i_ente
           and ej_toficial = @i_tipo_cli

        if @w_fecha_asig is null
        begin
          select
            @w_fecha_asig = getdate()
        end
        insert into cl_his_ejecutivo
                    (ej_ente,ej_funcionario,ej_toficial,ej_fecha_asig,
                     ej_fecha_registro)
        values      (@i_ente,@v_oficial_ant,@i_tipo_cli,getdate(),@w_fecha_asig)

        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101117
        /* 'Error en insercion a historico'*/
          /* 'de ejecutivo'*/

          return 1
        end

        /*** actualizar la tabla de cl_ejecutivo ****/
        update cl_ejecutivo
        set    ej_funcionario = @i_oficial,
               ej_fecha_asig = @w_fecha_asig
        where  ej_ente     = @i_ente
           and ej_toficial = @i_tipo_cli

        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101116
          /* 'Error en insercion de ejecutivo del ente'*/
          return 1
        end

        /* transaccion de servicio - datos previos */
        insert into ts_persona
                    (secuencial,tipo_transaccion,clase,fecha,usuario,
                     terminal,srv,lsrv,persona,filial,
                     oficina,oficial)
        values      (@s_ssn,@t_trn,@i_tipo_cli,@s_date,@s_user,
                     @s_term,@s_srv,@s_lsrv,@i_ente,@w_filial,
                     @w_oficina,@v_oficial)
        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103005
          /*'Error en creacion transaccion de servicio'*/
          return 1
        end

        /* transaccion de servicio - datos anteriores  */
        insert into ts_persona
                    (secuencial,tipo_transaccion,clase,fecha,usuario,
                     terminal,srv,lsrv,persona,filial,
                     oficina,oficial)
        values      (@s_ssn,@t_trn,'A',@w_fecha_asig,@s_user,
                     @s_term,@s_srv,@s_lsrv,@i_ente,@w_filial,
                     @w_oficina,@w_oficial)
        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103005
          /*'Error creacion de transaccion de servicio'*/
          return 1
        end
      end
      else
      begin
        insert into cl_ejecutivo
                    (ej_ente,ej_funcionario,ej_toficial,ej_fecha_asig)
        values      ( @i_ente,@i_oficial,@i_tipo_cli,getdate())

        if @@error != 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101116
          /* 'Error en insercion de ejecutivo del ente'*/

          return 1
        end
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
      /*  'No corresponde */
      return 1
    end
  end

go

