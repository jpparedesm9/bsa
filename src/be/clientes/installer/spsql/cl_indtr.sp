/***********************************************************************/
/*      Archivo:                cl_indtr.sp                            */
/*      Stored procedure:       sp_indicadores_tributarios             */
/*      Base de datos:          cobis                                  */
/*      Producto:               Clientes                               */
/*      Disenado por:           Felipe Rivera                          */
/*      Fecha de escritura:     22-Ene-2007                            */
/***********************************************************************/
/*                          IMPORTANTE                                 */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*  de COBISCorp.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como   */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus   */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.  */
/*  Este programa esta protegido por la ley de   derechos de autor     */
/*  y por las    convenciones  internacionales   de  propiedad inte-   */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para*/
/*  obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*  penalmente a los autores de cualquier   infraccion.                */
/***********************************************************************/
/*                          PROPOSITO                                  */
/*  Permite crear y dar mantenimiento de los datos de Balances de  los */
/*      clientes                                                       */
/***********************************************************************/
/*                        MODIFICACIONES                               */
/*  FECHA                   AUTOR             RAZON                    */
/*  10/04/2007           Sandra Lievano SLI   Defecto 8098             */
/*  02/05/2016           DFu                  Migracion CEN            */
/***********************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_indicadores_tributarios')
  drop proc sp_indicadores_tributarios
go

create proc sp_indicadores_tributarios
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
  @t_trn                int,
  @t_show_version       bit = 0,
  @i_operacion          char(1),
  @i_retencion          char(1) = null,
  @i_regimen_fiscal     catalogo = null,
  @i_gran_contribuyente char(1) = null,
  @i_impuesto_vtas      char(1) = null,
  @i_ente               int
)
as
  declare
    @w_return                int,
    @w_sp_name               varchar(32),
    @w_en_subtipo            char(1),
    @v_en_retencion          char(1),
    @v_en_asosciada          catalogo,
    @v_en_gran_contribuyente char(1),
    @v_en_reestructurado     char(1),
    @w_secuencial            int --defecto 8098 sli 10/04/2007

  select
    @w_sp_name = 'sp_indicadores_tributarios'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn not in (169, 170, 171)
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    /*  'No corresponde codigo de transaccion' */
    return 1
  end

  if @i_operacion = 'Q'
  begin
    select
      a.en_retencion,
      a.en_reestructurado,
      a.en_gran_contribuyente,
      a.en_asosciada,
      (select
         rf_descripcion
       from   cob_conta..cb_regimen_fiscal
       where  rf_codigo = a.en_asosciada),
      a.en_subtipo
    from   cl_ente a
    where  en_ente = @i_ente

    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103001
      return 1 /*'Error en creacion de cliente'*/
    end
  end

  if @i_operacion = 'U'
  begin
    begin tran
    select
      @v_en_retencion = en_retencion,--Valores anteriores
      @v_en_asosciada = en_asosciada,
      @v_en_gran_contribuyente = en_gran_contribuyente,
      @v_en_reestructurado = en_reestructurado
    from   cl_ente
    where  en_ente = @i_ente

    update cl_ente --update a la cl_ente
    set    en_retencion = @i_retencion,
           en_asosciada = @i_regimen_fiscal,
           en_gran_contribuyente = @i_gran_contribuyente,
           en_reestructurado = @i_impuesto_vtas,
           en_fecha_mod = getdate() --sli  defecto8098  10/04/2007

    where  en_ente = @i_ente
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 3255007
      rollback tran
      return 1 /*'Error al Actualizar el Ente Relacionado'*/
    end
    if @v_en_retencion <> @i_retencion
    begin
      insert into cl_actualiza
                  (ac_ente,ac_fecha,ac_tabla,--auditoria del update
                   ac_campo,ac_valor_ant,
                   ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
      values      (@i_ente,getdate(),'cl_ente','en_retencion',@v_en_retencion,
                   @i_retencion,'U',null,null)
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103001
        rollback tran
        return 1 /*'Error en creacion de cliente'*/
      end
    end
    if @v_en_asosciada <> @i_regimen_fiscal
    begin
      insert into cl_actualiza
                  (ac_ente,ac_fecha,ac_tabla,--auditoria del update
                   ac_campo,ac_valor_ant,
                   ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
      values      (@i_ente,getdate(),'cl_ente','en_asosciada',@v_en_asosciada,
                   @i_regimen_fiscal,'U',null,null)
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103001
        rollback tran
        return 1 /*'Error en creacion de cliente'*/
      end

      --sli  defecto8098  10/04/2007
      select
        @w_secuencial = isnull((select max(lf_secuencial) from cl_log_fiscal), 0
                        )
                        +
                        1

      insert into cobis..cl_log_fiscal
                  (lf_secuencial,lf_ente,lf_fecha_modifica,lf_regimenf_ant,
                   lf_regimenf_nue,
                   lf_usuario,lf_terminal)
      values      (@w_secuencial,@i_ente,getdate(),@v_en_asosciada,
                   @i_regimen_fiscal
                   ,
                   @s_user,@s_term)

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 15100032
        return 1 --'Error en insercion del registro a cl_log_fiscal'
      end
    --fin defecto 8098
    end
    if @v_en_gran_contribuyente <> @i_gran_contribuyente
    begin
      insert into cl_actualiza
                  (ac_ente,ac_fecha,ac_tabla,--auditoria del update
                   ac_campo,ac_valor_ant,
                   ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
      values      (@i_ente,getdate(),'cl_ente','en_gran_contribuyente',
                   @v_en_gran_contribuyente,
                   @i_gran_contribuyente,'U',null,null)
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103001
        rollback tran
        return 1 /*'Error en creacion de cliente'*/
      end
    end
    if @v_en_reestructurado <> @i_impuesto_vtas
    begin
      insert into cl_actualiza
                  (ac_ente,ac_fecha,ac_tabla,--auditoria del update
                   ac_campo,ac_valor_ant,
                   ac_valor_nue,ac_transaccion,ac_secuencial1,ac_secuencial2)
      values      (@i_ente,getdate(),'cl_ente','en_reestructurado',
                   @v_en_reestructurado,
                   @i_impuesto_vtas,'U',null,null)
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103001
        rollback tran
        return 1 /*'Error en creacion de cliente'*/
      end
    end

    select
      @w_en_subtipo = en_subtipo
    from   cl_ente
    where  en_ente = @i_ente

    if @w_en_subtipo = 'P'
    begin
      /*antes*/
      insert into ts_persona
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,persona,retencion,
                   asosciada)
      values      (@s_ssn,@t_trn,'A',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@v_en_retencion,
                   @v_en_asosciada)
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicio'*/
        rollback tran
        return 1
      end
      /*despues*/
      insert into ts_persona
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,persona,retencion,
                   asosciada)
      values      (@s_ssn,@t_trn,'D',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_retencion,
                   @i_regimen_fiscal)
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        rollback tran
        /* 'Error en creacion de transaccion de servicio'*/
        return 1
      end
    end --persona natural
    else
    begin --persona juridica
      /*antes*/
      insert into ts_compania
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,compania,retencion,
                   asosciada)
      values      (@s_ssn,@t_trn,'A',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@v_en_retencion,
                   @v_en_asosciada)
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        rollback tran
        /* 'Error en la creacion de transaccion de servicio'*/
        return 1
      end
      /*despues*/
      insert into ts_compania
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,compania,retencion,
                   asosciada)
      values      (@s_ssn,@t_trn,'D',@s_date,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_retencion,
                   @i_regimen_fiscal)
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        rollback tran
        /* 'Error en la creacion de transaccion de servicio'*/
        return 1
      end
    end --persona juridica
    commit tran
  end

  return 0

go

