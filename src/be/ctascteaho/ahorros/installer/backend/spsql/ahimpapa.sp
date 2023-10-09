/************************************************************************/
/*      Archivo:                ahimpapa.sp                             */
/*      Stored procedure:       sp_imprime_plan_pago                    */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Saira Molano                            */
/*      Fecha de escritura:     12-May-2011                             */
/************************************************************************/
/*                             IMPORTANTE                               */
/*      Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*      de COBISCorp.                                                   */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno  de sus        */
/*      usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*      Este programa esta protegido por la ley de derechos de autor    */
/*      y por las convenciones  internacionales de propiedad inte-      */
/*      lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*      obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*      penalmente a los autores de cualquier infraccion.               */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa procesa la transaccion de:                        */
/*      Consulta de estado de cuenta para impresion Plan de Pago        */
/*      para cuentas especiales                                         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      12/May/2011     S.Molano       Emision Inicial                  */
/*      04/May/2016     J. Salazar     Migracion COBIS CLOUD MEXICO     */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_imprime_plan_pago')
  drop proc sp_imprime_plan_pago
go

/****** Object:  StoredProcedure [dbo].[sp_imprime_plan_pago]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_imprime_plan_pago
(
  @s_ssn          int,
  @s_srv          varchar(30),
  @s_user         varchar(30),
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_ofi          smallint,/* Localidad origen transaccion */
  @s_rol          smallint,
  @s_sev          tinyint = null,
  @p_lssn         int = null,
  @t_corr         char(1) = 'N',
  @t_ssn_corr     int = null,
  @p_rssn_corr    int = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_show_version bit = 0,
  @s_org          char(1),
  @t_trn          int,
  @i_cta          cuenta,
  @i_sec          int,
  @i_mon          tinyint = 0,
  @i_frontn       char(1) = 'N',
  @i_escliente    char(1) = 'N',
  @o_planpago     char(1) = null out
)
as
  declare
    @w_return             int,
    @w_sp_name            varchar(30),
    @w_oficina            smallint,
    @w_ttran              smallint,
    @w_cuenta             int,
    @w_rcount             tinyint,
    @w_fchtmp             varchar(8),
    @w_fecha              datetime,
    @w_fecha_ini          datetime,
    @w_moneda             varchar(20),
    @w_saldo_para_girar   money,
    @w_saldo_contable     money,
    @w_disponible         money,
    @w_sec                int,
    @w_ssn                int,
    @w_contador           tinyint,
    @w_funcionario        char(1),
    @w_producto           tinyint,
    @w_det_producto       int,
    @w_tipo_dir           char(1),
    @w_prod_banc          int,
    @w_desc_prod_banc     varchar(64),
    @w_cliente            int,
    @w_nombre_titulares   varchar (255),
    @w_nombre_conca       varchar (255),
    @w_docu_conca         varchar(70),
    @w_tipo_conca         varchar(10),
    @w_maximo_titulares   smallint,
    @w_cantidad_titulares smallint,
    @w_of_nombre          varchar(25),
    @w_rol                char(1),
    @w_ced_ruc            varchar(20),
    @w_fecha_sig          datetime,
    @w_fecha_imp          datetime,
    @w_cuota              money,
    @w_num_cuotas         int,
    @w_cont               int,
    @w_fila               int,
    @w_saldo_esp          money,
    @w_saldo              money,
    @w_apertura           char(1),
    @w_estado             varchar(11),
    @w_fecha_batch        datetime,
    @w_diferencia         money,
    @w_estado_cta         char(1),
    @w_ciudad_matriz      int

  -- Captura nombre de Stored Procedure
  select
    @w_sp_name = 'sp_imprime_plan_pago'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  --Maximo de filas de la cabecera del titular
  select
    @w_maximo_titulares = 4

  select
    @w_fecha_batch = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_ciudad_matriz = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'CMA'
     and pa_producto = 'CTE'

  -- Determinacion de los datos de la cuenta
  select
    @w_cuenta = ah_cuenta,
    @w_funcionario = ah_cta_funcionario,
    @w_producto = ah_producto,
    @w_prod_banc = ah_prod_banc,
    @w_oficina = ah_oficina,
    @w_cuota = cc_cuota,
    @w_num_cuotas = cc_plazo,
    @w_fecha = ah_fecha_aper,
    @w_estado_cta = ah_estado
  from   cob_ahorros..ah_cuenta,
         cob_remesas..re_cuenta_contractual
  where  ah_cta_banco = cc_cta_banco
     and ah_cta_banco = @i_cta

  if (@@rowcount <> 1)
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141127,
      @i_msg   = 'Cuenta no Aperturada en ese Rango de fechas.'
    return 141127
  end

  select
    @w_desc_prod_banc = pb_descripcion
  from   cob_remesas..pe_pro_bancario
  where  pb_pro_bancario = @w_prod_banc

  -- Verificacion de cuentas de funcionarios para oficiales autorizados
  if (@w_funcionario = 'S')
     and (@t_trn <> 370)
  begin
    if not exists (select
                     1
                   from   cob_remesas..re_ofi_personal,
                          cobis..cc_oficial,
                          cobis..cl_funcionario
                   where  fu_login       = @s_user
                      and fu_funcionario = oc_funcionario
                      and op_oficial     = oc_oficial)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201123
      return 201123
    end
  end

  if @i_sec = 0
  --Para enviar la cabecera y la variable de plan de pago(s) o extracto (N)
  begin
    if @w_fecha = @w_fecha_batch
      select
        @o_planpago = 'S'
    else
      select
        @o_planpago = 'N'

    --Cantidad total de titular/cotitulares J. Artola   
    select
      @w_cantidad_titulares = count(1)
    from   cobis..cl_det_producto,
           cobis..cl_cliente
    where  dp_cuenta       = @i_cta
       and cl_det_producto = dp_det_producto
       and cl_rol in ('T', 'C')

    --Nombre del titular/cotitulares J. Artola
    select
      'NOMBRE' = en_nomlar,
      'DOCUMENTO' = cl_ced_ruc,
      'ROL' = isnull(c.valor,
                     '-'),
      'PROD' = @w_desc_prod_banc,
      'APER' = convert(varchar(10), @w_fecha, 103),
      'ESTADO' = @w_estado_cta
    from   cobis..cl_det_producto,
           cobis..cl_cliente,
           cobis..cl_ente,
           cobis..cl_tabla t,
           cobis..cl_catalogo c
    where  dp_cuenta       = @i_cta
       and cl_det_producto = dp_det_producto
       and cl_rol in ('T', 'C')
       and cl_cliente      = en_ente
       and t.tabla         = 'cl_rol'
       and t.codigo        = c.tabla
       and c.codigo        = cl_rol
    order  by cl_rol desc

    select
      @o_planpago --  Si es la fecha de apertura el campo ira en 'S'  
  end

  select
    @w_fecha_sig = dateadd(mm,
                           1,
                           @w_fecha) --Inicio del mes siguiente

  select
    @w_cont = 1,
    @w_saldo_esp = @w_cuota

  if exists(select
              1
            from   ah_imprime_plan
            where  im_cuenta = @w_cuenta)
    select
      @w_cont = @w_num_cuotas + 1

  while @w_cont <= @w_num_cuotas
  -- Arma las cuotas totales en la tabla temporal 
  begin
    select top 1
      @w_fecha_imp = sd_fecha,
      @w_saldo = isnull(sd_saldo_disponible,
                        0),
      @w_estado = case
                    when (@w_saldo_esp - @w_saldo) <= 0 then 'C'
                    when (@w_saldo_esp - @w_saldo) > 0 then 'D'
                  end
    from   cob_ahorros_his..ah_saldo_diario
    where  sd_cuenta = @w_cuenta
       and sd_fecha  < @w_fecha_sig
    order  by sd_fecha desc

    select
      @w_diferencia = (@w_saldo - @w_saldo_esp)

    --if @w_fecha_sig >=  @w_fecha_batch 
    --begin
    if exists (select
                 1
               from   cobis..cl_dias_feriados
               where  df_ciudad = @w_ciudad_matriz
                  and df_fecha  = @w_fecha_sig)
    begin
      --Busca dia habil 
      exec @w_return = cob_remesas..sp_fecha_habil
        @i_val_dif       = 'N',
        @i_efec_dia      = 'S',
        @i_fecha         = @w_fecha_sig,
        @i_oficina       = @s_ofi,
        @i_dif           = 'S',--Horario Normal
        @w_dias_ret      = -1,--Dia anterior habil 
        @i_finsemana     = 'N',--No tiene en cuenta el sabado como festivo 
        @o_ciudad_matriz = @w_ciudad_matriz out,
        @o_fecha_sig     = @w_fecha_sig out

      if @w_return <> 0
        print @w_return

    end
    select
      @w_estado = 'P',
      @w_saldo = 0,
      @w_fecha_imp = @w_fecha_sig,
      @w_diferencia = 0
    --end  

    insert into ah_imprime_plan
                (im_cuenta,im_numero,im_fecha,im_cuota,im_sldo_esp,
                 im_saldo_hoy,im_diferencia,im_estado,im_fecha_aprox)
    values      (@w_cuenta,@w_cont,convert(varchar(10), @w_fecha_imp, 103),
                 @w_cuota,@w_saldo_esp,
                 @w_saldo,@w_diferencia,@w_estado,@w_fecha_sig)

    select
      @w_cont = @w_cont + 1,
      @w_saldo_esp = @w_saldo_esp + @w_cuota,
      @w_fecha_sig = dateadd(mm,
                             @w_cont,
                             @w_fecha)
  end

  set rowcount 0

  select top 48
    'CUOTA' = im_numero,
    'MES DE AHORRO' = im_fecha,
    'MONTO ' = im_cuota,
    'SALDO ESPERADO' = im_sldo_esp,
    'SALDO MES' = im_saldo_hoy,
    'DIFERENCIA' = case
                     when im_estado = 'C'
                           or im_estado = 'D' then (im_saldo_hoy - im_sldo_esp)
                     when im_estado = 'P' then (0)
                   end,
    'ESTADO' = case
                 when im_estado = 'C' then 'CUBIERTA'
                 when im_estado = 'D' then 'DESCUBIERTA'
                 when im_estado = 'P' then 'PENDIENTE'
               end
  from   ah_imprime_plan
  where  im_numero > @i_sec -- @w_fila
     and im_cuenta = @w_cuenta
  order  by im_numero

  if @w_sec = 0
  begin
    insert into cob_ahorros..ah_tran_servicio
                (ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_usuario,
                 ts_terminal,
                 ts_oficina,ts_reentry,ts_origen,ts_cta_banco,ts_moneda,
                 ts_oficina_cta,ts_hora,ts_saldo,ts_interes,ts_valor,
                 ts_prod_banc,ts_estado,ts_numero,ts_fecha,ts_accion)
    values      ( @s_ssn,@t_trn,@s_date,@s_user,@s_term,
                  @s_ofi,@t_rty,@s_org,@i_cta,@i_mon,
                  @w_oficina,getdate(),@w_saldo_esp,(@w_saldo_esp - @w_saldo),
                  @w_saldo,
                  @w_prod_banc,@w_estado,@w_cont,@w_fecha_imp,@w_estado_cta)

    if @@error <> 0
    begin
      -- error en la insercion de la transaccion de servicio 
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 203005
      return 203005
    end

  end
  return 0

go

