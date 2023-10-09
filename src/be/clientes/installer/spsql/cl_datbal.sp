/* ***********************************************************************/
/*  Archivo           :  cl_datbal.sp                                    */
/*  Stored procedure  :  sp_datos_balance                                */
/*  Base de datos     :  cobis                                           */
/*  Producto          :  Clientes                                        */
/*  Disenado por      :  Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura:  08-Nov-1992                                     */
/* ***********************************************************************/
/*              IMPORTANTE                                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de COBISCorp.                                                        */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/* ***********************************************************************/
/*              PROPOSITO                                                */
/*  Permite crear y dar mantenimiento de los datos de Balances de un     */
/*  cliente                                                              */
/* ***********************************************************************/
/*              MODIFICACIONES                                           */
/*  FECHA         AUTOR         RAZON                                    */
/*  9-May-1994    S. Ortiz      Emision inicial                          */
/*  7-Ago-2003    E. Laguna     Personalizacion tipos balance BAC        */
/*  8-Ago-2003    E. Laguna     Ajuste parametrizacion balances          */
/*  23-Jun-2004   E. Laguna     Cambios afectacion campos entes          */
/*  11-Jul-2006   E. Laguna     Correccion defecto 6814                  */
/*  15-Abr-2008   JGU           Requerimiento 18                         */
/*  09-Oct-2008   L.Alvarez     Controlde Cambio para la Palm            */
/*  02-May-2016   DFu           Migracion CEN                            */
/* ***********************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_datos_balance')
  drop proc sp_datos_balance
go

create proc sp_datos_balance
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
  @i_cliente      int = null,
  @i_tbalance     char(3) = null,
  @i_tipo_entrada char(1) = 'C',
  @i_ejecutivo    login = null,
  @i_secuencial   int = null,
  @i_trn_ext      char(1) = 'N'
)
as
  declare
    @w_return      int,
    @w_sp_name     varchar(32),
    @w_balance     smallint,
    @w_tbalance_1  char(3),
    @w_tbalance_2  char(3),
    @w_activo      money,
    @w_pasivo      money,
    @w_patrimonio  money,
    @w_ingreso     money,
    @w_egreso      money,
    @w_fecha_corte datetime,
    @w_error       int,
    @w_mensaje     varchar(255)

  select
    @w_sp_name = 'sp_datos_balance'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_patrimonio = null

  if @t_trn = 1420
  begin
    select
      @w_fecha_corte = max(ba_fecha_corte)
    from   cl_balance,
           cl_tbalance
    where  ba_cliente  = @i_cliente
       and ba_tbalance = tb_tbalance
       and tb_tcliente = 'D'

    if @w_fecha_corte is not null
    begin
      select
        @w_tbalance_1 = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = '001'

      if @w_tbalance_1 is null
      begin
        if @i_tipo_entrada = 'P'
        begin
          select
            @w_mensaje = 'ERROR EN LA ACTUALIZACIÊN DE DATOS BALANCE'
          insert cob_palm..pda_rechazos
                 (re_secuencial,re_ejecutivo,re_tabla,re_ente,re_mensaje,
                  re_fecha)
          values( @i_secuencial,@i_ejecutivo,'cl_ente',@i_cliente,@w_mensaje,
                  getdate())
        end
        else
        begin
          select
            @w_error = 105082,
            @w_mensaje = null
          goto ERROR
        /* 'Error en actualizacion de Datos Balance'*/
        end
      end

      select
        @w_tbalance_2 = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = '002'

      if @w_tbalance_2 is null
      begin
        if @i_tipo_entrada = 'P'
        begin
          select
            @w_mensaje = 'ERROR EN LA ACTUALIZACIÊN DE DATOS BALANCE'
          insert cob_palm..pda_rechazos
                 (re_secuencial,re_ejecutivo,re_tabla,re_ente,re_mensaje,
                  re_fecha)
          values( @i_secuencial,@i_ejecutivo,'cl_ente',@i_cliente,@w_mensaje,
                  getdate())
        end
        else
        begin
          select
            @w_error = 105082,
            @w_mensaje = null
          goto ERROR
        /* 'Error en actualizacion de Datos Balance'*/
        end
      end
    end

    if @w_fecha_corte is null
    begin
      select
        @w_fecha_corte = max(ba_fecha_corte)
      from   cl_balance,
             cl_tbalance
      where  ba_cliente  = @i_cliente
         and ba_tbalance = tb_tbalance
         and tb_tcliente = 'O'

      if @w_fecha_corte is not null
      begin
        select
          @w_tbalance_1 = pa_char
        from   cobis..cl_parametro
        where  pa_producto = 'MIS'
           and pa_nemonico = '005'

        if @w_tbalance_1 is null
        begin
          if @i_tipo_entrada = 'P'
          begin
            select
              @w_mensaje = 'ERROR EN LA ACTUALIZACIÊN DE DATOS BALANCE'
            insert cob_palm..pda_rechazos
                   (re_secuencial,re_ejecutivo,re_tabla,re_ente,re_mensaje,
                    re_fecha)
            values( @i_secuencial,@i_ejecutivo,'cl_ente',@i_cliente,@w_mensaje,
                    getdate())
          end
          else
          begin
            select
              @w_error = 105082,
              @w_mensaje = null
            goto ERROR
          /* 'Error en actualizacion de Datos Balance'*/
          end
        end

        select
          @w_tbalance_2 = pa_char
        from   cobis..cl_parametro
        where  pa_producto = 'MIS'
           and pa_nemonico = '006'

        if @w_tbalance_2 is null
        begin
          if @i_tipo_entrada = 'P'
          begin
            select
              @w_mensaje = 'ERROR EN LA ACTUALIZACIÊN DE DATOS BALANCE'
            insert cob_palm..pda_rechazos
                   (re_secuencial,re_ejecutivo,re_tabla,re_ente,re_mensaje,
                    re_fecha)
            values( @i_secuencial,@i_ejecutivo,'cl_ente',@i_cliente,@w_mensaje,
                    getdate())
          end
          else
          begin
            select
              @w_error = 105082,
              @w_mensaje = null
            goto ERROR
          /* 'Error en actualizacion de Datos Balance'*/
          end
        end
      end
    end

    if @w_fecha_corte is null
    begin
      select
        @w_fecha_corte = max(ba_fecha_corte)
      from   cl_balance,
             cl_tbalance
      where  ba_cliente  = @i_cliente
         and ba_tbalance = tb_tbalance
         and tb_tcliente = 'C'

      if @w_fecha_corte is not null
      begin
        select
          @w_tbalance_1 = pa_char
        from   cobis..cl_parametro
        where  pa_producto = 'MIS'
           and pa_nemonico = '003'

        if @w_tbalance_1 is null
        begin
          if @i_tipo_entrada = 'P'
          begin
            select
              @w_mensaje = 'ERROR EN LA ACTUALIZACIÊN DE DATOS BALANCE'
            insert cob_palm..pda_rechazos
                   (re_secuencial,re_ejecutivo,re_tabla,re_ente,re_mensaje,
                    re_fecha)
            values( @i_secuencial,@i_ejecutivo,'cl_ente',@i_cliente,@w_mensaje,
                    getdate())
          end
          else
          begin
            select
              @w_error = 105082,
              @w_mensaje = null
            goto ERROR
          /* 'Error en actualizacion de Datos Balance'*/
          end
        end

        select
          @w_tbalance_2 = pa_char
        from   cobis..cl_parametro
        where  pa_producto = 'MIS'
           and pa_nemonico = '004'

        if @w_tbalance_2 is null
        begin
          if @i_tipo_entrada = 'P'
          begin
            select
              @w_mensaje = 'ERROR EN LA ACTUALIZACIÊN DE DATOS BALANCE'
            insert cob_palm..pda_rechazos
                   (re_secuencial,re_ejecutivo,re_tabla,re_ente,re_mensaje,
                    re_fecha)
            values( @i_secuencial,@i_ejecutivo,'cl_ente',@i_cliente,@w_mensaje,
                    getdate())
          end
          else
          begin
            select
              @w_error = 105082,
              @w_mensaje = null
            goto ERROR
          /* 'Error en actualizacion de Datos Balance'*/
          end
        end
      end
    end

    if @w_fecha_corte <> ''
    begin
      select
        @w_activo = sum(pl_valor)
      from   cl_plan,
             cl_cuenta,
             cl_balance
      where  pl_cliente     = @i_cliente
         and pl_cliente     = ba_cliente
         and ct_categoria   = 'A'
         and pl_cuenta      = ct_cuenta
         and pl_balance     = ba_balance
         and ba_fecha_corte = @w_fecha_corte
         and ba_tbalance    = @w_tbalance_1

      select
        @w_pasivo = sum(pl_valor)
      from   cl_plan,
             cl_cuenta,
             cl_balance
      where  pl_cliente     = @i_cliente
         and pl_cliente     = ba_cliente
         and ct_categoria   = 'P'
         and pl_cuenta      = ct_cuenta
         and pl_balance     = ba_balance
         and ba_fecha_corte = @w_fecha_corte
         and ba_tbalance    = @w_tbalance_1

      select
        @w_patrimonio = sum(pl_valor)
      from   cl_plan,
             cl_cuenta,
             cl_balance
      where  pl_cliente     = @i_cliente
         and pl_cliente     = ba_cliente
         and ct_categoria   = 'T'
         and pl_cuenta      = ct_cuenta
         and pl_balance     = ba_balance
         and ba_fecha_corte = @w_fecha_corte
         and ba_tbalance    = @w_tbalance_1

      if @w_patrimonio is null
        select
          @w_patrimonio = isnull(@w_activo,
                                 0) - isnull(@w_pasivo,
                                             0)

      select
        @w_ingreso = sum(pl_valor)
      from   cl_plan,
             cl_cuenta,
             cl_balance
      where  pl_cliente     = @i_cliente
         and pl_cliente     = ba_cliente
         and ct_categoria   = 'I'
         and pl_cuenta      = ct_cuenta
         and pl_balance     = ba_balance
         and ba_fecha_corte = @w_fecha_corte
         and ba_tbalance    = @w_tbalance_2

      select
        @w_egreso = sum(pl_valor)
      from   cl_plan,
             cl_cuenta,
             cl_balance
      where  pl_cliente     = @i_cliente
         and pl_cliente     = ba_cliente
         and ct_categoria   = 'E'
         and pl_cuenta      = ct_cuenta
         and pl_balance     = ba_balance
         and ba_fecha_corte = @w_fecha_corte
         and ba_tbalance    = @w_tbalance_2

      update cl_ente
      set    p_nivel_ing = isnull(@w_ingreso,
                                  0),
             p_nivel_egr = isnull(@w_egreso,
                                  0),
             c_total_activos = isnull(@w_activo,
                                      0),
             c_total_pasivos = isnull(@w_pasivo,
                                      0),
             en_patrimonio_tec = isnull(@w_patrimonio,
                                        0),
             en_fecha_patri_bruto = @w_fecha_corte,
             en_fbalance = @w_fecha_corte
      where  en_ente = @i_cliente

      if @@error <> 0
      begin
        if @i_tipo_entrada = 'P'
        begin
          select
            @w_mensaje = 'ERROR EN LA ACTUALIZACIÊN DE DATOS BALANCE'
          insert cob_palm..pda_rechazos
                 (re_secuencial,re_ejecutivo,re_tabla,re_ente,re_mensaje,
                  re_fecha)
          values( @i_secuencial,@i_ejecutivo,'cl_ente',@i_cliente,@w_mensaje,
                  getdate())
        end
        else
        begin
          select
            @w_error = 105082,
            @w_mensaje = null
          goto ERROR
        /* 'Error en actualizacion de Datos Balance'*/
        end
      end
      return 0
    end
  end
  else
  begin
    if @i_tipo_entrada = 'P'
    begin
      select
        @w_mensaje = 'TRANSACCION NO CORRESPONDE'
      insert cob_palm..pda_rechazos
             (re_secuencial,re_ejecutivo,re_tabla,re_ente,re_mensaje,
              re_fecha)
      values( @i_secuencial,@i_ejecutivo,'cl_ente',@i_cliente,@w_mensaje,
              getdate())
    end
    else
    begin
      /*  'No corresponde codigo de transaccion' */
      select
        @w_error = 151051,
        @w_mensaje = null
      goto ERROR
    end
  end

  ERROR:
  if @i_trn_ext = 'N'
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_error
  end
  else
    return @w_error

go

