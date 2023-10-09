/* ***********************************************************************/
/*      Archivo:                cl_alianza.sp                            */
/*      Base de datos:          cobis                                    */
/*      Producto:               Clientes                                 */
/*      Disenado por:           D.Lozano                                 */
/*      Fecha de escritura:     26-Mar-2013                              */
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
/*  Permite consultar las alianzas comerciales existentes                */
/* ***********************************************************************/
/*                 MODIFICACIONES                                        */
/*  FECHA          AUTOR            RAZON                                */
/*  26-Mar-2013    D.Lozano        Emision inicial                       */
/*  02-May-2016    DFu             Migracion CEN                         */
/*************************************************************************/
use cobis
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_alianzas')
  drop proc sp_alianzas
go

create proc sp_alianzas
(
  @s_ssn                  int,
  @t_trn                  smallint = null,
  @t_debug                char(1) = 'N',
  @t_file                 varchar(10) = null,
  @t_from                 varchar(32) = null,
  @t_show_version         bit = 0,
  @s_user                 login = null,
  @s_term                 varchar(30) = null,
  @s_date                 datetime = null,
  @s_srv                  varchar(30) = null,
  @s_lsrv                 varchar(30) = null,
  @s_rol                  smallint = null,
  @s_ofi                  smallint = null,
  @s_org_err              char(1) = null,
  @s_error                int = null,
  @s_sev                  tinyint = null,
  @s_msg                  descripcion = null,
  @s_org                  char(1) = null,
  @i_alianza              int = null,
  @i_operacion            char(1) = null,
  @i_modo                 tinyint = 0,
  @i_ente                 int = null,
  @i_nemonico             catalogo = null,
  @i_nom_alianza          varchar(255) = null,
  @i_tipo                 catalogo = null,
  @i_fecha_creacion       datetime = null,
  @i_fecha_fija           char(1) = null,
  @i_fecha_inicio         datetime = null,
  @i_fecha_fin            datetime = null,
  @i_estado               char(1) = null,
  @i_tipo_credito         char(1) = null,
  @i_restringue_uso       char(1) = null,
  @i_num_uso              int = null,
  @i_monto_promedio       money = null,
  @i_tipo_recaudador      char(1) = null,
  @i_aplica_mora          char(1) = null,
  @i_dias_gracia          int = null,
  @i_tasa_mora            catalogo = null,
  @i_signo_spread         char(1) = null,
  @i_valor_spread         int = null,
  @i_cuenta_bancaria      char(16) = '',
  @i_debito_aut           char(1) = null,
  @i_dispersion_fondos    char(1) = null,
  @i_forma_des            catalogo = null,
  @i_des_cta_afi          char(1) = null,
  @i_gmf_banco            char(1) = null,
  @i_porcentaje_gmfbanco  float = null,
  @i_fecha_pago           char(1) = null,
  @i_dia_pago             int = null,
  @i_exonera_estudio      char(1) = null,
  @i_porcentaje_exonera   float = null,
  @i_mantiene_condiciones char(1) = null,
  @i_observaciones        varchar (255) = null,
  @i_fecha_cancelacion    datetime = null,
  @i_linea                varchar(30) = null,
  @i_formato              int = null,
  @w_codigo_tlu           char(10) = null,
  @w_destlu               varchar(50) = null,
  @i_tipo_cre             int = null,
  @i_cupo_glb             money = null,
  @i_email                char(1) = null,
  @i_email_env            char(1) = null
)
as
  declare
    @w_sp_name           varchar(64),
    @w_alianza           int,
    @w_existe            tinyint,
    @w_cant_alianza      int,
    @w_estado            char(1),
    @w_fecha_cancelacion datetime,
    @w_linea             int,
    @w_num               int,
    @w_msg               varchar(132),
    @w_pa_dimive         tinyint,
    @w_pa_dimave         tinyint,
    @w_param_alia        char(1)

  select
    @w_sp_name = 'sp_alianzas'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* CONTROLAR DIA MINIMO DEL MES PARA FECHAS DE VENCIMIENTO */
  select
    @w_pa_dimive = pa_tinyint
  from   cobis..cl_parametro
  where  pa_nemonico = 'DIMIVE'
     and pa_producto = 'CCA'

  if @@rowcount = 0
  begin
    select
      @w_num = 150006,
      @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL DIMIVE DE CARTERA'
    goto ERROR
  end

  -- Validacion de estado
  if @i_operacion = 'E'
  begin
    -- INGRESO
    if @i_estado = 'V'
       and isnull(@i_alianza,
                  0) = 0
    begin
      if exists (select
                   '1'
                 from   cobis..cl_alianza
                 where  al_ente   = @i_ente
                    and al_estado = 'V')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'SOLO SE PERMITE UNA ALIANZA VIGENTE POR CLIENTE',
          @i_num   = 101001
        -- select * from cobis..cl_errores where numero = 101001    -- No existe dato solicitado 
        return 101001
      end
    end

    -- MODIFICACION
    if @i_estado = 'V'
       and isnull(@i_alianza,
                  0) > 0
    begin
      if exists (select
                   '1'
                 from   cobis..cl_alianza
                 where  al_alianza <> @i_alianza
                    and al_ente    = @i_ente
                    and al_estado  = 'V')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'SOLO SE PERMITE UNA ALIANZA VIGENTE POR CLIENTE.',
          @i_num   = 101001
        -- select * from cobis..cl_errores where numero = 101001    -- No existe dato solicitado 
        return 101001
      end
    end
  end

  /* CONTROLAR DIA MAXIMO DEL MES PARA FECHAS DE VENCIMIENTO */
  select
    @w_pa_dimave = pa_tinyint
  from   cobis..cl_parametro
  where  pa_nemonico = 'DIMAVE'
     and pa_producto = 'CCA'

  if @@rowcount = 0
  begin
    select
      @w_num = 150006,
      @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL DIMAVE DE CARTERA'
    goto ERROR
  end

  if @i_operacion = 'P'
  begin
    select
      @w_pa_dimive,
      @w_pa_dimave
    return 0
  end

  if @i_dia_pago < @w_pa_dimive
      or @i_dia_pago > @w_pa_dimave
  begin
    select
      @w_num = 101001,
      @w_msg = 'DIA DE PAGO NO ESTA EN EL RANGO DE DIAS DEFINIDO ENTRE '
               + cast(@w_pa_dimive as varchar) + '-' + cast(@w_pa_dimave as
               varchar)
    goto ERROR
  end

  if @i_operacion = 'Q'
  begin -- Consulta el nombre y codigo de la alianza para front end
    select
      'Codigo' = al_alianza,
      'Nombre' = al_nemonico + ' - ' + al_nom_alianza
    from   cobis..cl_alianza
    order  by al_alianza

    if @@rowcount = 0
    begin
      exec sp_cerror -- sp_helpcode sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = 'NO HAY ALIANZAS CREADAS.',
        @i_num   = 101001
      return 101001
    -- select * from cobis..cl_errores where numero = 101001    -- No existe dato solicitado 
    end
  end

  if @i_operacion = 'V'
  begin --Para el lost focus de front end
    select
      'Nombre' = al_nemonico + ' - ' + al_nom_alianza
    from   cobis..cl_alianza
    where  al_alianza = @i_alianza

    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = 'ALIANZA NO EXISTE.',
        @i_num   = 101001
      return 101001
    -- select * from cobis..cl_errores where numero = 101001    -- No existe dato solicitado 
    end
  end

  if @i_operacion = 'I'
  begin
    select
      @w_existe = 0

    select
      @w_existe = 1
    from   cobis..cl_alianza
    where  al_alianza  = @i_alianza
       and al_nemonico = @i_nemonico

    if isnull(@w_existe,
              0) = 1
      select
        @i_operacion = 'U'
  end

  if @i_operacion = 'S'
  begin --Consulta para grilla de frontend las alianzas existentes
    if @i_modo = 0
    begin
      select top 100
        'Codigo' = al_alianza,
        'Nemonico' = al_nemonico,
        'Tipo de Alianza' = (select
                               b.valor
                             from   cl_tabla a,
                                    cl_catalogo b
                             where  a.tabla  = 'cl_tipo_alianza'
                                and a.codigo = b.tabla
                                and b.codigo = al_tipo),
        'Fecha Creacion' = convert(varchar(10), al_fecha_creacion, @i_formato),
        'Fecha Inicio' = convert(varchar(10), al_fecha_inicio, @i_formato),
        'Fecha Fin' = convert(varchar(10), al_fecha_fin, @i_formato),
        'Estado' = (select
                      b.valor
                    from   cl_tabla a,
                           cl_catalogo b
                    where  a.tabla  = 'cl_estado_alianza'
                       and a.codigo = b.tabla
                       and b.codigo = al_estado),
        'Nombre' = al_nemonico + ' - ' + al_nom_alianza
      from   cobis..cl_alianza
      order  by al_alianza

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'NO HAY ALIANZAS CREADAS.',
          @i_num   = 101001
        -- select * from cobis..cl_errores where numero = 101001    -- No existe dato solicitado 
        return 101001

      end
    end
    else
    begin
      select top 100
        'Codigo' = al_alianza,
        'Nemonico' = al_nemonico,
        'Tipo de Alianza' = (select
                               b.valor
                             from   cl_tabla a,
                                    cl_catalogo b
                             where  a.tabla  = 'cl_tipo_alianza'
                                and a.codigo = b.tabla
                                and b.codigo = al_tipo),
        'Fecha Creacion' = convert(varchar(10), al_fecha_creacion, @i_formato),
        'Fecha Inicio' = convert(varchar(10), al_fecha_inicio, @i_formato),
        'Fecha Fin' = convert(varchar(10), al_fecha_fin, @i_formato),
        'Estado' = (select
                      b.valor
                    from   cl_tabla a,
                           cl_catalogo b
                    where  a.tabla  = 'cl_estado_alianza'
                       and a.codigo = b.tabla
                       and b.codigo = al_estado),
        'Nombre' = al_nemonico + ' - ' + al_nom_alianza
      from   cobis..cl_alianza
      where  al_alianza > @i_alianza
      order  by al_alianza
    end
  end

  if @i_operacion = 'T'
  begin --Para el lost focus de front end
    select
      al_alianza,
      al_ente,
      al_nemonico,
      al_nom_alianza,
      (select
         b.valor
       from   cl_tabla a,
              cl_catalogo b
       where  a.tabla  = 'cl_tipo_alianza'
          and a.codigo = b.tabla
          and b.codigo = al_tipo),--5
      convert(varchar(10), al_fecha_creacion, 101),
      al_fecha_fija,
      convert(varchar(10), al_fecha_inicio, 101),
      convert(varchar(10), al_fecha_fin, 101),
      (select
         b.valor
       from   cl_tabla a,
              cl_catalogo b
       where  a.tabla  = 'cl_estado_alianza'
          and a.codigo = b.tabla
          and b.codigo = al_estado),--10
      al_tipo_credito,
      al_restringue_uso,
      al_num_uso,
      al_monto_promedio,
      al_tipo_recaudador,--15
      al_aplica_mora,
      al_dias_gracia,
      al_tasa_mora,
      al_signo_spread,
      al_valor_spread,--20
      al_cuenta_bancaria,
      al_debito_aut,
      al_dispersion_fondos,
      al_forma_des,
      al_des_cta_afi,--25
      al_gmf_banco,
      al_porcentaje_gmfbanco,
      al_fecha_pago,
      al_dia_pago,
      al_exonera_estudio,--30
      al_porcentaje_exonera,
      al_mantiene_condiciones,
      al_observaciones,
      al_fecha_cancelacion,
      al_tipo,--35
      al_monto_alianza,
      al_envia_mail,
      al_mail_alianza
    from   cobis..cl_alianza
    where  al_alianza = @i_alianza

    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = 'ALIANZA NO EXISTE.',
        @i_num   = 101001
      -- select * from cobis..cl_errores where numero = 101001    -- No existe dato solicitado 
      return 101001
    end

    select
      @w_cant_alianza = count(1)
    from   cobis..cl_alianza_cliente
    where  ac_alianza = @i_alianza
       and ac_estado  = 'V'

    select
      isnull(@w_cant_alianza,
             0)
  end

  if @i_operacion = 'I'
  begin
    if @i_estado = 'V'
    begin
      if exists (select
                   '1'
                 from   cobis..cl_alianza
                 where  al_ente   = @i_ente
                    and al_estado = 'V')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'YA EXISTE ALIANZA CON ESTE CLIENTE ES ESTADO VIGENTE.',
          @i_num   = 101001
        -- select * from cobis..cl_errores where numero = 101001    -- No existe dato solicitado 
        return 101001
      end
    end

    if not exists (select
                     al_alianza
                   from   cobis..cl_alianza_linea_tmp)
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = 'DEBE ASOCIAR UNA LINEA A LA CARACTERIZACION DE LA ALIANZA',
        @i_num   = 101001 -- No existe dato solicitado 
      return 101001
    end

    if exists (select
                 1
               from   cobis..cl_alianza
               where  al_nom_alianza = al_nom_alianza
                  and al_nemonico    = @i_nemonico)
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = 'NEMONICO DE ALIANZA A CREAR, YA EXISTE.',
        @i_num   = 101001
      -- select * from cobis..cl_errores where numero = 101001    -- No existe dato solicitado 
      return 101001

    end
    else
    begin
      select
        @w_alianza = siguiente + 1
      from   cobis..cl_seqnos
      where  bdatos = 'cobis'
         and tabla  = 'cl_alianzas'

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'INCONSISTENCIA CON SECUENCIAL PARA CREACION DE ALIANZA.',
          @i_num   = 101001
        -- select * from cobis..cl_errores where numero = 101001    -- No existe dato solicitado 
        return 101001
      end

      begin tran
      update cobis..cl_seqnos
      set    siguiente = @w_alianza
      where  bdatos = 'cobis'
         and tabla  = 'cl_alianzas'

      if @@error <> 0
      begin
        rollback tran
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   =
        'INCONSISTENCIA CON ACTUALIZACION DE SECUENCIAL DE ALIANZA.',
          @i_num   = 150001
        -- select * from cobis..cl_errores where numero = 150001   -- ERROR EN ACTUALIZACION 
        return 150001
      end

      if @i_fecha_creacion is null
      begin
        select
          @i_fecha_creacion = getdate()
      end

      insert into cobis..cl_alianza
                  (al_alianza,al_ente,al_nemonico,al_nom_alianza,al_tipo,
                   al_fecha_creacion,al_fecha_fija,al_fecha_inicio,al_fecha_fin,
                   al_estado,
                   al_tipo_credito,al_restringue_uso,al_num_uso,
                   al_monto_promedio,
                   al_tipo_recaudador,
                   al_aplica_mora,al_dias_gracia,al_tasa_mora,al_signo_spread,
                   al_valor_spread,
                   al_cuenta_bancaria,al_debito_aut,al_dispersion_fondos,
                   al_forma_des,
                   al_des_cta_afi,
                   al_gmf_banco,al_porcentaje_gmfbanco,al_fecha_pago,al_dia_pago
                   ,
                   al_exonera_estudio,
                   al_porcentaje_exonera,al_mantiene_condiciones,
                   al_observaciones,
                   al_fecha_cancelacion,al_monto_alianza,
                   al_envia_mail,al_mail_alianza)
      values      ( @w_alianza,@i_ente,@i_nemonico,@i_nom_alianza,@i_tipo,
                    @i_fecha_creacion,@i_fecha_fija,@i_fecha_inicio,@i_fecha_fin
                    ,
                    @i_estado,
                    @i_tipo_credito,@i_restringue_uso,@i_num_uso,
                    @i_monto_promedio
                    ,
                    @i_tipo_recaudador,
                    @i_aplica_mora,@i_dias_gracia,@i_tasa_mora,@i_signo_spread,
                    @i_valor_spread,
                    isnull(@i_cuenta_bancaria,
                           ''),@i_debito_aut,@i_dispersion_fondos,@i_forma_des,
                    @i_debito_aut,
                    @i_gmf_banco,@i_porcentaje_gmfbanco,@i_fecha_pago,
                    @i_dia_pago,
                    @i_exonera_estudio,
                    @i_porcentaje_exonera,@i_mantiene_condiciones,
                    @i_observaciones
                    ,
                    @i_fecha_cancelacion,@i_cupo_glb,
                    @i_email,@i_email_env)

      if @@error <> 0
      begin
        rollback tran
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'INCONSISTENCIA AL CREAR LA ALIANZA.',
          @i_num   = 150000
        -- select * from cobis..cl_errores where numero = 150000   -- ERROR EN INSERCION
        return 150000
      end

      insert into cobis..cl_alianza_linea
                  (al_alianza,al_linea)
        select
          al_alianza,al_linea
        from   cobis..cl_alianza_linea_tmp

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'INCONSISTENCIA AL COPIAR EN cl_alianza_linea_tmp.',
          @i_num   = 150000
        -- select * from cobis..cl_errores where numero = 150000   -- ERROR EN INSERCION
        return 150000

      end

      insert into cobis..cl_alianza_banco
                  (ab_alianza,ab_banco,ab_cuenta,ab_estado)
        select
          ab_alianza,ab_banco,ab_cuenta,ab_estado
        from   cobis..cl_alianza_banco_tmp

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 150000
        return 150000
      end

      delete cobis..cl_alianza_linea_tmp

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'INCONSISTENCIA AL ELIMINAR cl_alianza_linea_tmp.',
          @i_num   = 150004
        -- select * from cobis..cl_errores where numero = 150004   -- ERROR EN ELIMINACION
        return 150004
      end

      delete cobis..cl_alianza_banco_tmp

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'INCONSISTENCIA AL ELIMINAR cl_alianza_banco_tmp.',
          @i_num   = 150004
        -- select * from cobis..cl_errores where numero = 150004   -- ERROR EN ELIMINACION
        return 150004
      end

      insert into cobis..ts_alianza
                  (secuencial,tipo_transaccion,cod_alterno,clase,fecha,
                   usuario,terminal,srv,lsrv,ente,
                   nemonico,tipo_alianza,fecha_creacion,fecha_fija,fecha_inicio,
                   fecha_fin,estado_alianza,tipo_credito,restringue_uso,num_uso,
                   monto_promedio,tipo_recaudador,aplica_mora,dias_gracia,
                   tasa_mora,
                   signo_spread,valor_spread,cuenta_bancaria,debito_aut,
                   dispersion_fondos,
                   forma_des,des_cta_afi,gmf_banco,porcentaje_gmfbanco,
                   fecha_pago,
                   dia_pago,exonera_estudio,porcentaje_exonera,
                   mantiene_condiciones,
                   observacion_alianza)
      values      ( @s_ssn,@t_trn,@w_alianza,'P',getdate(),
                    @s_user,@s_term,@s_srv,@s_lsrv,@i_ente,
                    @i_nemonico,@i_tipo,@i_fecha_creacion,@i_fecha_fija,
                    @i_fecha_inicio,
                    @i_fecha_fin,@i_estado,@i_tipo_credito,@i_restringue_uso,
                    @i_num_uso,
                    @i_monto_promedio,@i_tipo_recaudador,@i_aplica_mora,
                    @i_dias_gracia
                    ,@i_tasa_mora,
                    @i_signo_spread,@i_valor_spread,isnull(@i_cuenta_bancaria,
                           ''),@i_debito_aut,@i_dispersion_fondos,
                    @i_forma_des,@i_des_cta_afi,@i_gmf_banco,
                    @i_porcentaje_gmfbanco,
                    @i_fecha_pago,
                    @i_dia_pago,@i_exonera_estudio,@i_porcentaje_exonera,
                    @i_mantiene_condiciones,@i_observaciones)

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   =
        'INCONSISTENCIA COPIAR EN TRANSACCION DE SERVICIO ts_alianza.',
          @i_num   = 150000
        -- select * from cobis..cl_errores where numero = 150000   -- ERROR EN INSERCION
        return 150000
      end
      commit tran
    end
  end

  if @i_operacion = 'U'
  begin
    if @i_estado = 'V'
    begin
      if exists (select
                   '1'
                 from   cobis..cl_alianza
                 where  al_alianza <> @i_alianza
                    and al_ente    = @i_ente
                    and al_estado  = 'V')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'YA EXISTE ALIANZA CON ESTE CLIENTE ES ESTADO VIGENTE ',
          @i_num   = 101001
        -- select * from cobis..cl_errores where numero = 101001    -- No existe dato solicitado 
        return 101001
      end
    end

    if not exists (select
                     al_alianza
                   from   cobis..cl_alianza_linea
                   where  al_alianza = @i_alianza
                   union
                   select
                     al_alianza
                   from   cobis..cl_alianza_linea_tmp
                   where  al_alianza = @i_alianza)
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_msg   = 'DEBE ASOCIAR UNA LINEA A LA CARACTERIZACION DE LA ALIANZA',
        @i_num   = 101001 -- No existe dato solicitado 
      return 101001
    end

    if @i_modo = 0
    begin
      /* SE VALIDA QUE LA ALIANZA NO TENGA NINGUN CLIENTE ASOCIADO PARA PODERSE MODIFICAR */

      if exists (select
                   1
                 from   cobis..cl_alianza_cliente
                 where  ac_alianza = @i_alianza
                    and ac_estado  = 'V')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103123
        -- select * from cobis..cl_errores where numero = 103123   -- LA ALIANZA TIENE CLIENTES ASOCIADOS Y NO PERMITE MODIFICACION
        return 103123
      end

      begin tran

      select
        @w_estado = al_estado
      from   cobis..cl_alianza
      where  al_alianza = @i_alianza

      insert into cobis..ts_alianza
                  (secuencial,tipo_transaccion,cod_alterno,clase,fecha,
                   usuario,terminal,srv,lsrv,ente,
                   nemonico,tipo_alianza,fecha_creacion,fecha_fija,fecha_inicio,
                   fecha_fin,estado_alianza,tipo_credito,restringue_uso,num_uso,
                   monto_promedio,tipo_recaudador,aplica_mora,dias_gracia,
                   tasa_mora,
                   signo_spread,valor_spread,cuenta_bancaria,debito_aut,
                   dispersion_fondos,
                   forma_des,des_cta_afi,gmf_banco,porcentaje_gmfbanco,
                   fecha_pago,
                   dia_pago,exonera_estudio,porcentaje_exonera,
                   mantiene_condiciones,
                   observacion_alianza)
        select
          @s_ssn,@t_trn,@i_alianza,'A',getdate(),
          @s_user,@s_term,@s_srv,@s_lsrv,al_ente,
          al_nemonico,al_tipo,al_fecha_creacion,al_fecha_fija,al_fecha_inicio,
          al_fecha_fin,al_estado,al_tipo_credito,al_restringue_uso,al_num_uso,
          al_monto_promedio,al_tipo_recaudador,al_aplica_mora,al_dias_gracia,
          al_tasa_mora,
          al_signo_spread,al_valor_spread,al_cuenta_bancaria,al_debito_aut,
          al_dispersion_fondos,
          al_forma_des,al_des_cta_afi,al_gmf_banco,al_porcentaje_gmfbanco,
          al_fecha_pago,
          al_dia_pago,al_exonera_estudio,al_porcentaje_exonera,
          al_mantiene_condiciones
          ,
          al_observaciones
        from   cobis..cl_alianza
        where  al_alianza = @i_alianza

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   =
        'INCONSISTENCIA COPIAR EN TRANSACCION DE SERVICIO ts_alianza..'
        ,
          @i_num   = 150000
        -- select * from cobis..cl_errores where numero = 150000   -- ERROR EN INSERCION
        return 150000
      end

      if @i_estado <> @w_estado
      begin
        if @i_estado = 'C'
        begin
          select
            @w_fecha_cancelacion = getdate()

          update cobis..cl_alianza
          set    al_fecha_cancelacion = @w_fecha_cancelacion
          where  al_alianza = @i_alianza
        end
        if @i_estado = 'V'
        begin
          update cobis..cl_alianza
          set    al_fecha_cancelacion = @w_fecha_cancelacion
          where  al_alianza = @i_alianza
        end
      end

      update cobis..cl_alianza
      set    al_ente = @i_ente,
             al_nemonico = @i_nemonico,
             al_nom_alianza = @i_nom_alianza,
             al_tipo = @i_tipo,
             al_fecha_fija = @i_fecha_fija,
             al_fecha_inicio = @i_fecha_inicio,
             al_fecha_fin = @i_fecha_fin,
             al_estado = @i_estado,
             al_tipo_credito = @i_tipo_credito,
             al_restringue_uso = @i_restringue_uso,
             al_num_uso = @i_num_uso,
             al_monto_promedio = @i_monto_promedio,
             al_tipo_recaudador = @i_tipo_recaudador,
             al_aplica_mora = @i_aplica_mora,
             al_dias_gracia = @i_dias_gracia,
             al_tasa_mora = @i_tasa_mora,
             al_signo_spread = @i_signo_spread,
             al_valor_spread = @i_valor_spread,
             al_cuenta_bancaria = isnull(@i_cuenta_bancaria,
                                         ''),
             al_debito_aut = @i_debito_aut,
             al_dispersion_fondos = @i_dispersion_fondos,
             al_forma_des = @i_forma_des,
             al_des_cta_afi = @i_debito_aut,
             al_gmf_banco = @i_gmf_banco,
             al_porcentaje_gmfbanco = @i_porcentaje_gmfbanco,
             al_fecha_pago = @i_fecha_pago,
             al_dia_pago = @i_dia_pago,
             al_exonera_estudio = @i_exonera_estudio,
             al_porcentaje_exonera = @i_porcentaje_exonera,
             al_mantiene_condiciones = @i_mantiene_condiciones,
             al_observaciones = @i_observaciones,
             al_monto_alianza = @i_cupo_glb,
             al_envia_mail = @i_email,
             al_mail_alianza = @i_email_env
      where  al_alianza = @i_alianza

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'INCONSISTENCIA AL ACTUALIZAR LA ALIANZA.',
          @i_num   = 150001
        -- select * from cobis..cl_errores where numero = 150001    -- ERROR EN ACTUALIZACION 
        return 150001
      end

      insert into cobis..cl_alianza_linea
        select
          *
        from   cobis..cl_alianza_linea_tmp

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'INCONSISTENCIA AL ACTUALIZAR cl_alianza_linea.',
          @i_num   = 150000
        -- select * from cobis..cl_errores where numero = 150000    -- ERROR EN ACTUALIZACION 
        return 150000
      end

      insert into cobis..cl_alianza_banco
        select
          *
        from   cobis..cl_alianza_banco_tmp

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'INCONSISTENCIA AL ACTUALIZAR cl_alianza_banco.',
          @i_num   = 150000
        -- select * from cobis..cl_errores where numero = 150000    -- ERROR EN ACTUALIZACION 
        return 150000
      end

      delete cobis..cl_alianza_linea_tmp

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'INCONSISTENCIA AL ELIMINAR cl_alianza_linea_tmp.',
          @i_num   = 150004
        -- select * from cobis..cl_errores where numero = 150004    -- ERROR EN ELIMINACION
        return 150004
      end

      delete cobis..cl_alianza_banco_tmp

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'INCONSISTENCIA AL ELIMINAR cl_alianza_banco_tmp.',
          @i_num   = 150004
        -- select * from cobis..cl_errores where numero = 150004    -- ERROR EN ELIMINACION
        return 150004
      end

      insert into cobis..ts_alianza
                  (secuencial,tipo_transaccion,cod_alterno,clase,fecha,
                   usuario,terminal,srv,lsrv,ente,
                   nemonico,tipo_alianza,fecha_creacion,fecha_fija,fecha_inicio,
                   fecha_fin,estado_alianza,tipo_credito,restringue_uso,num_uso,
                   monto_promedio,tipo_recaudador,aplica_mora,dias_gracia,
                   tasa_mora,
                   signo_spread,valor_spread,cuenta_bancaria,debito_aut,
                   dispersion_fondos,
                   forma_des,des_cta_afi,gmf_banco,porcentaje_gmfbanco,
                   fecha_pago,
                   dia_pago,exonera_estudio,porcentaje_exonera,
                   mantiene_condiciones,
                   observacion_alianza)
      values      ( @s_ssn,@t_trn,@i_alianza,'P',getdate(),
                    @s_user,@s_term,@s_srv,@s_lsrv,@i_ente,
                    @i_nemonico,@i_tipo,@i_fecha_creacion,@i_fecha_fija,
                    @i_fecha_inicio,
                    @i_fecha_fin,@i_estado,@i_tipo_credito,@i_restringue_uso,
                    @i_num_uso,
                    @i_monto_promedio,@i_tipo_recaudador,@i_aplica_mora,
                    @i_dias_gracia
                    ,@i_tasa_mora,
                    @i_signo_spread,@i_valor_spread,isnull(@i_cuenta_bancaria,
                           ''),@i_debito_aut,@i_dispersion_fondos,
                    @i_forma_des,@i_des_cta_afi,@i_gmf_banco,
                    @i_porcentaje_gmfbanco,
                    @i_fecha_pago,
                    @i_dia_pago,@i_exonera_estudio,@i_porcentaje_exonera,
                    @i_mantiene_condiciones,@i_observaciones)

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   =
        'INCONSISTENCIA COPIAR EN TRANSACCION DE SERVICIO ts_alianza ',
          @i_num   = 150000
        -- select * from cobis..cl_errores where numero = 150000   -- ERROR EN INSERCION
        return 150000
      end
      commit tran
    end
  end

  if @i_operacion = 'C'
  begin
    if @i_modo = 0
    begin
      select
        'Cuenta' = ah_cta_banco
      from   cob_ahorros..ah_cuenta
      where  ah_cliente = @i_ente
         and ah_estado in ('A', 'G')

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 141048
        return 141048
      end
    end
    if @i_modo = 1
    begin
      select
        ah_cta_banco
      from   cob_ahorros..ah_cuenta
      where  ah_cliente   = @i_ente
         and ah_estado in ('A', 'G')
         and ah_cta_banco = @i_cuenta_bancaria
    end
  end

  if @i_operacion = 'A'
  begin
    /* SE VALIDA QUE LA ALIANZA NO TENGA NINGUN CLIENTE ASOCIADO PARA PODERSE MODIFICAR */

    if exists (select
                 1
               from   cobis..cl_alianza_cliente
               where  ac_alianza = @i_alianza
                  and ac_estado  = 'V')
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103123
      -- select * from cobis..cl_errores where numero = 103123   -- LA ALIANZA TIENE CLIENTES ASOCIADOS Y NO PERMITE MODIFICACION
      return 103123
    end

    if @i_alianza = 0
    begin
      select
        @w_alianza = siguiente + 1
      from   cobis..cl_seqnos
      where  bdatos = 'cobis'
         and tabla  = 'cl_alianzas'
    end

    if @i_modo = 0
    begin
      if @i_alianza = 0
      begin
        if not exists(select
                        1
                      from   cobis..cl_alianza_linea
                      where  al_alianza = @i_alianza
                         and al_linea   = @i_linea)
        begin
          insert into cobis..cl_alianza_linea_tmp
                      (al_alianza,al_linea)
          values      (@w_alianza,@i_linea)
          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 103117
            -- select * from cobis..cl_errores where numero = 103117   -- NO EXISTE DATO SOLICITADO
            return 103117

          end
        end
      end
      else
      begin
        insert into cobis..cl_alianza_linea
                    (al_alianza,al_linea)
        values      (@i_alianza,@i_linea)
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103117
          -- select * from cobis..cl_errores where numero = 103117   -- NO EXISTE DATO SOLICITADO
          return 103117
        end
      end
    end
    if @i_modo = 1
    begin
      if @i_alianza = 0
      begin
        select
          @w_alianza = siguiente + 1
        from   cobis..cl_seqnos
        where  bdatos = 'cobis'
           and tabla  = 'cl_alianzas'

        delete cobis..cl_alianza_linea_tmp
        where  al_alianza = @w_alianza
           and al_linea   = @i_linea
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103117
          -- select * from cobis..cl_errores where numero = 103117   -- NO EXISTE DATO SOLICITADO
          return 103117
        end
      end
      else
      begin
        delete cobis..cl_alianza_linea
        where  al_alianza = @i_alianza
           and al_linea   = @i_linea
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103117
          -- select * from cobis..cl_errores where numero = 103117   -- NO EXISTE DATO SOLICITADO
          return 103117
        end
      end
    end
  end

  if @i_operacion = 'N'
  begin
    create table #lineas
    (
      codigo varchar(10)
    )

    if @i_alianza = 0
    begin
      select
        @w_alianza = siguiente + 1
      from   cobis..cl_seqnos
      where  bdatos = 'cobis'
         and tabla  = 'cl_alianzas'
    end

  /* OBTIENE LAS LINEAS PROPIAS PARA CUPOS */
    --   select eq_valor_cat
    --   into #lineas_cupo
    --   from cob_conta_super..sb_equivalencias
    --   where eq_catalogo = 'LINALICUP' 
    --   and   eq_estado = 'V'
    --   
    --   if @@rowcount = 0
    --   begin
    --      exec sp_cerror
    --           @t_debug = @t_debug,
    --           @t_file  = @t_file,
    --           @t_from  = @w_sp_name,
    --           @i_num   = 103117,
    --           @i_msg   = 'LINEAS NO DEFINIDAS PARA ALIANZAS DE CUPO'
    --           return 103117
    --   end

    if @i_tipo_cre = 1 -- Cupos
      insert into #lineas
                  (codigo)
        select
          eq_valor_cat
        from   cob_conta_super..sb_equivalencias
        where  eq_catalogo = 'LINALICUP'
           and eq_estado   = 'V'
    else -- Individual
      insert into #lineas
                  (codigo)
        select
          codigo = to_toperacion
        from   cob_credito..cr_toperacion
        where  to_estado = 'V'
           and to_toperacion not in (select
                                       eq_valor_cat
                                     from   cob_conta_super..sb_equivalencias
                                     where  eq_catalogo = 'LINALICUP'
                                        and eq_estado   = 'V')
    if @i_modo = 0
    begin
      delete cobis..cl_alianza_linea_tmp
      where  al_alianza = @w_alianza
         and al_linea not in (select
                                codigo
                              from   #lineas)

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'INCONSISTENCIA AL ELIMINAR cl_alianza_banco_tmp.',
          @i_num   = 150004
        -- select * from cobis..cl_errores where numero = 150004    -- ERROR EN ELIMINACION
        return 150004
      end
    end

    if @i_modo = 1
    begin
      delete cobis..cl_alianza_linea
      where  al_alianza = @i_alianza
         and al_linea not in (select
                                codigo
                              from   #lineas)

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'INCONSISTENCIA AL ELIMINAR cl_alianza_banco_tmp.',
          @i_num   = 150004
        -- select * from cobis..cl_errores where numero = 150004    -- ERROR EN ELIMINACION
        return 150004
      end
    end

    if @i_modo = 0
    begin
      if @i_alianza = 0
      begin
        select
          codigo
        from   #lineas
        where  codigo not in (select
                                al_linea
                              from   cobis..cl_alianza_linea_tmp
                              where  al_alianza = @w_alianza)
      end
      else
      begin
        select
          codigo
        from   #lineas
        where  codigo not in (select
                                al_linea
                              from   cobis..cl_alianza_linea
                              where  al_alianza = @i_alianza)
      end
    end
    if @i_modo = 1
    begin
      select
        @w_param_alia = pa_char
      from   cobis..cl_parametro with (nolock)
      where  pa_nemonico = 'RESLIA'
         and pa_producto = 'MIS'

      if @w_param_alia is null
        select
          @w_param_alia = 'N'

      if @i_alianza = 0
      begin
        select
          @w_alianza = siguiente + 1
        from   cobis..cl_seqnos
        where  bdatos = 'cobis'
           and tabla  = 'cl_alianzas'

        select
          al_linea
        from   cobis..cl_alianza_linea_tmp
        where  al_alianza = @w_alianza

        --Mapea nuevo parametro al FE de clientes
        select
          @w_param_alia

      end
      else
      begin
        select
          al_linea
        from   cobis..cl_alianza_linea
        where  al_alianza = @i_alianza

        --Mapea nuevo parametro al FE de clientes
        select
          @w_param_alia
      end
    end
  end

  if @i_operacion = 'M'
  begin
    if @i_modo = 0
    begin
      select
        eq_valor_cat,
        eq_descripcion
      from   cob_conta_super..sb_equivalencias
      where  eq_catalogo = 'FORDESALI'
         and eq_estado   = 'V'
    end
    if @i_modo = 1
    begin
      select
        @w_codigo_tlu = pa_char,
        @w_destlu = pa_parametro
      from   cobis..cl_parametro with (nolock)
      where  pa_producto = 'CCA'
         and pa_nemonico = 'TLU'

      select
        'Tipo' = vr_tipo,
        'Descripci¾n' = @w_destlu
      from   cob_cartera..ca_valor_referencial
      where  vr_tipo like rtrim(ltrim(@w_codigo_tlu)) + '%'
         and vr_fecha_vig = (select
                               max(vr_fecha_vig)
                             from   cob_cartera..ca_valor_referencial
                             where  vr_tipo like rtrim(ltrim(@w_codigo_tlu)) +
                                                 '%'
                            )
    end
    if @i_modo = 2
    begin
      select
        @w_destlu = pa_parametro
      from   cobis..cl_parametro with (nolock)
      where  pa_producto = 'CCA'
         and pa_nemonico = 'TLU'

      select
        @w_destlu
      from   cob_cartera..ca_valor_referencial
      where  vr_tipo      = rtrim(ltrim(@w_codigo_tlu))
         and vr_fecha_vig = (select
                               max(vr_fecha_vig)
                             from   cob_cartera..ca_valor_referencial
                             where  vr_tipo = rtrim(ltrim(@w_codigo_tlu)))

    end
    if @i_modo = 3
    begin
      select
        cp_producto,
        cp_descripcion
      from   cob_cartera..ca_producto
      where  cp_desembolso = 'S'
         and cp_producto   = @i_forma_des
    end
  end

  if @i_operacion = 'D'
  begin
    delete cobis..cl_alianza_linea_tmp
    delete cobis..cl_alianza_banco_tmp
  end
  return 0

  ERROR:

  exec sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_num,
    @i_msg   = @w_msg
  return @w_num

go

