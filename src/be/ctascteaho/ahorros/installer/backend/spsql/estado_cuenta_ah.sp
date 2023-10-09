/************************************************************************/
/*      Archivo:        estado_cuenta_ah.sp                             */
/*      Stored procedure:   sp_estado_cuenta_ah                         */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:       Cuentas de Ahorros                              */
/*      Disenado por:       Boris Mosquera                              */
/*      Fecha de escritura:     28-Jun-1995                             */
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
/*              PROPOSITO                                               */
/*      Este programa realiza lo SIGUIENTE:                             */
/*  Unicamente para cuentas de Traslado Automatico                      */
/*      1. Pasa los datos de la cabecera del estado de cuenta a la      */
/*         tabla ah_estado_cta a las cuentas que tienen transacciones   */
/*      2. Calcula la fecha de proximo corte                            */
/*      3. Actualiza la tabla ah_cuenta con fechas de ultimo y proximo  */
/*         corte, etc. de todas las cuentas                             */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*      FECHA       AUTOR       RAZON                                   */
/*      29/Jun/2006     P. Coello   Aumentar tamao de descripcin        */
/*                                  de estado de cuenta                 */
/*      02/Feb/2007 P.  Coello      GENERAR CABECERAS PARA AQUELLAS     */
/*                                  CUENTAS CUYA FECHA DE PROXIMO       */
/*                                  CORTE ORIGINALMENTE CALCULADA       */
/*                                  HAYA SIDO CAMBIADO A DIA FERIADO    */
/*      17/Feb/2010     J. Loyo     Manejo de la fecha de efectivizacion*/
/*                                  teniendo el sabado como habil       */
/*      15/Marzo/2012   A. Munoz    Optimizacion de Proceso Batch Sarta */
/*                                  4131 LLS 051794                     */
/*      04/May/2016     J. Salazar  Migracion COBIS CLOUD MEXICO        */
/*      08/Sep/2016     R. Sánchez  Modificación                        */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_estado_cuenta_ah')
  drop proc sp_estado_cuenta_ah
go

/****** Object:  StoredProcedure [dbo].[sp_estado_cuenta_ah]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_estado_cuenta_ah
(
  @t_show_version bit = 0,
  @i_filial       tinyint = 1,
  @i_fecha        datetime = null,
  @i_param1       tinyint = 1,--Filial
  @i_param2       datetime = null,

  --Fecha Previo al cambio de Fecha del Proceso Batch de Fin de Dia
  @i_corresponsal char(1) = 'N',--Req. 381 CB Red Posicionada     
  @o_procesadas   int = null out
)
as
  declare
    @w_ah_ciclo             char(1),
    @w_ah_fecha_ult_corte   smalldatetime,
    @w_ah_12h               money,
    @w_ah_cta_banco         cuenta,
    @w_ah_24h               money,
    @w_ah_remesas           money,
    @w_ah_disponible        money,
    @w_ah_promedio1         money,
    @w_ah_prom_disponible   money,
    @w_ah_saldo_ult_corte   money,
    @w_ah_fecha_prx_corte   smalldatetime,
    @w_ah_fecha_ult_mov     smalldatetime,
    @w_ah_fecha_ult_mov_int smalldatetime,
    @w_ah_oficina           smallint,
    @w_ah_contador_trx      int,
    @w_ret_bancos           money,
    @w_contable             money,
    @w_mes_sigc             varchar(10),
    @w_dia_pri              varchar(10),
    @w_dia_ciclo            varchar(2),
    @w_fecha_prx_ec         datetime,
    @w_ciudad_matriz        int,
    @w_dia_hoy              smallint,
    @w_ofi                  smallint,
    @w_prx_mes              varchar(10),
    @w_sp_name              varchar(30),
    @w_ah_moneda            int,
    @w_ah_tipo_dir          char(1),
    @w_ah_cliente           int,
    @w_tipocta              char(1),
    @w_ah_prod_banc         smallint,
    @w_contador             int,
    @w_ced                  varchar(13),
    @w_oficial              smallint,
    @w_telefono             varchar(12),
    @w_nombre               varchar(55),
    @w_descripcion_ec       varchar(120),
    @w_cliente_ec           int,
    @w_cuenta               int,
    @w_direccion_ec         tinyint,
    @w_nombre1              varchar(64),
    @w_zona                 smallint,
    @w_parroquia            int,
    @w_sector               smallint,
    @w_consumos             money,
    @w_monto_imp            money,
    @w_semestral            money,
    @w_prm1                 money,
    @w_prm2                 money,
    @w_prm3                 money,
    @w_prm4                 money,
    @w_prm5                 money,
    @w_prm6                 money,
    @w_usadeci              char(1),
    @w_numdeci              tinyint,
    @w_moneda               tinyint,
    @w_codeudor1            varchar(64),
    @w_codeudor2            varchar(64),
    @w_producto             smallint,
    @w_return               int,
    @w_prx_fec_lab          smalldatetime,
    @w_nombre_co            varchar(30),
    @w_tasa_hoy             real,
    @w_msg                  descripcion,
    @w_no_apartado        smallint,
    @w_prod_bancario        varchar(50) --Req. 381 CB Red Posicionada        

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_estado_cuenta_ah'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  if @i_param2 is null and @i_fecha is null
  begin
    --Falta parametro obligatorio
    exec cobis..sp_cerror
      @i_num = 101114
    return 101114
  end

  if @i_fecha is null
  begin
    select
      @i_fecha = @i_param2,
      @i_filial = @i_param1
  end

/* Obtencion del codigo de la ciudad de feriados nacionales para el */
  /* calculo de la fecha de proximo corte                             */

  select
    @w_ciudad_matriz = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CMA'

  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 201196
    select
      @o_procesadas = @w_contador
    return 1
  end

  -- Codigo de moneda local
  select
    @w_moneda = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'CMNAC'

  if @@rowcount <> 1
  begin
    select
      @w_msg = 'ERROR EN PARAMETRO DE MONEDA NACIONAL'
    goto ERROR
  end

  /* Encuentra parametro de decimales */
  select
    @w_usadeci = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @w_moneda

  select
    @w_numdeci = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'DCI'

  if @@rowcount <> 1
  begin
    /* Grabar en la tabla de errores */
    insert cob_ahorros..re_error_batch
    values ('0','ERROR AL BUSCAR PARAMETRO DECIMALES')

    if @@error <> 0
    begin
      select
        @w_msg = 'HUBO ERROR EN LA GRABACION DE ARCHIVO DE ERRORES'
      goto ERROR
    end
  end

  /* Encuentra parametro oficina */
  select
    @w_ofi = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'OMAT'

/*** GENERAR CABECERAS PARA AQUELLAS CUENTAS CUYA FECHA DE PROXIMO CORTE ORIGINALMENTE ***/
/*** CALCULADA HAYA SIDO CAMBIADO A DIA FERIADO ***/
  -- Proxima fecha laborable 
  select
    @w_prx_fec_lab = max(dateadd(dd, 1,dl_fecha))
  from   cob_ahorros..ah_dias_laborables
  where  dl_ciudad   = @w_ciudad_matriz
     and dl_num_dias = 0

  /*** CALCULA EL DIA ANTERIOR LABORAL ***/
  select
    @w_mes_sigc = convert(varchar(10), dateadd(mm,
                                               2,
                                               @i_fecha), 101)
  select
    @w_dia_pri = substring(@w_mes_sigc, 1, 3) + '01' + substring(@w_mes_sigc, 6,
                 5
                 )

/*** La determinacion del anterior dia laboral  se           ****/
  /*** hace mediante el llamado al siguiente sp  - JLOYO           ****/
  exec @w_return = cob_remesas..sp_fecha_habil
    @i_val_dif       = 'N',
    @i_efec_dia      = 'S',
    @i_fecha         = @w_dia_pri,
    @i_oficina       = @w_ofi,
    @i_dif           = 'N',/**** Ingreso en  horario normal  ***/
    @i_finsemana     = 'N',
    @w_dias_ret      = -1,/*** Dia anterior habil          ***/
    @o_ciudad_matriz = @w_ciudad_matriz out,
    @o_fecha_sig     = @w_fecha_prx_ec out

  if @w_return <> 0
  begin
    select
      @w_msg = 'HUBO ERROR EN LA BUSQUEDA DEL DIA ANT. LABORAL'
    goto ERROR
  end

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

/*** GENERAR CABECERAS PARA AQUELLAS CUENTAS CUYA FECHA DE PROXIMO CORTE ORIGINALMENTE ***/
  /*** CALCULADA HAYA SIDO CAMBIADO A DIA FERIADO ***/

  select
    @w_contador = 0

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    declare cursor_cuentas cursor for
      select
        ah_cuenta,
        ah_cta_banco,
        ah_ciclo,
        ah_fecha_ult_corte,
        ah_12h,
        ah_24h,
        ah_remesas,
        ah_disponible,
        ah_48h,
        ah_promedio1,
        ah_prom_disponible,
        ah_saldo_ult_corte,
        ah_fecha_prx_corte,
        ah_fecha_ult_mov,
        ah_nombre,
        ah_fecha_ult_mov_int,
        ah_oficina,
        ah_contador_trx,
        ah_moneda,
        ah_tipo_dir,
        ah_cliente,
        ah_prod_banc,
        ah_ced_ruc,
        ah_oficial,
        ah_descripcion_ec,
        ah_cliente_ec,
        ah_direccion_ec,
        ah_telefono,
        ah_tipocta,
        ah_nombre1,
        ah_zona,
        ah_parroquia,
        ah_sector,
        ah_monto_imp,
        ah_promedio1,
        ah_promedio2,
        ah_promedio3,
        ah_promedio4,
        ah_promedio5,
        ah_promedio6,
        ah_producto,
        ah_nombre1,
        isnull(ah_tasa_hoy,
               0)
      from   cob_ahorros..ah_cuenta_tmp
      where  ah_fecha_prx_corte >= @i_fecha
         and ah_prod_banc       <> @w_prod_bancario
         -- Req. 381 CB Red Posicionada
         and ah_fecha_prx_corte < @w_prx_fec_lab
         and ah_filial          = @i_filial
         and ah_estado_cuenta = 'S'
         and (ah_estado not in ('C')
               or (ah_estado          = 'C'
                   and ah_fecha_ult_mov   > ah_fecha_ult_corte))
      for update of ah_fecha_ult_corte, ah_saldo_ult_corte, ah_contador_trx,
      ah_fecha_prx_corte
  end
  else
  begin
    declare cursor_cuentas cursor for
      select
        ah_cuenta,
        ah_cta_banco,
        ah_ciclo,
        ah_fecha_ult_corte,
        ah_12h,
        ah_24h,
        ah_remesas,
        ah_disponible,
        ah_48h,
        ah_promedio1,
        ah_prom_disponible,
        ah_saldo_ult_corte,
        ah_fecha_prx_corte,
        ah_fecha_ult_mov,
        ah_nombre,
        ah_fecha_ult_mov_int,
        ah_oficina,
        ah_contador_trx,
        ah_moneda,
        ah_tipo_dir,
        ah_cliente,
        ah_prod_banc,
        ah_ced_ruc,
        ah_oficial,
        ah_descripcion_ec,
        ah_cliente_ec,
        ah_direccion_ec,
        ah_telefono,
        ah_tipocta,
        ah_nombre1,
        ah_zona,
        ah_parroquia,
        ah_sector,
        ah_monto_imp,
        ah_promedio1,
        ah_promedio2,
        ah_promedio3,
        ah_promedio4,
        ah_promedio5,
        ah_promedio6,
        ah_producto,
        ah_nombre1,
        isnull(ah_tasa_hoy,
               0)
      from   cob_ahorros..ah_cuenta_tmp
      where  ah_fecha_prx_corte >= @i_fecha
         and ah_fecha_prx_corte < @w_prx_fec_lab
         and ah_filial          = @i_filial
         and ah_estado_cuenta = 'S'
         and (ah_estado not in ('C')
               or (ah_estado          = 'C'
                   and ah_fecha_ult_mov   > ah_fecha_ult_corte))
      for update of ah_fecha_ult_corte, ah_saldo_ult_corte, ah_contador_trx,
      ah_fecha_prx_corte
  end

  open cursor_cuentas
  fetch cursor_cuentas into @w_cuenta,
                            @w_ah_cta_banco,
                            @w_ah_ciclo,
                            @w_ah_fecha_ult_corte,
                            @w_ah_12h,
                            @w_ah_24h,
                            @w_ah_remesas,
                            @w_ah_disponible,
                            @w_consumos,
                            @w_ah_promedio1,
                            @w_ah_prom_disponible,
                            @w_ah_saldo_ult_corte,
                            @w_ah_fecha_prx_corte,
                            @w_ah_fecha_ult_mov,
                            @w_nombre,
                            @w_ah_fecha_ult_mov_int,
                            @w_ah_oficina,
                            @w_ah_contador_trx,
                            @w_ah_moneda,
                            @w_ah_tipo_dir,
                            @w_ah_cliente,
                            @w_ah_prod_banc,
                            @w_ced,
                            @w_oficial,
                            @w_descripcion_ec,
                            @w_cliente_ec,
                            @w_direccion_ec,
                            @w_telefono,
                            @w_tipocta,
                            @w_nombre1,
                            @w_zona,
                            @w_parroquia,
                            @w_sector,
                            @w_monto_imp,
                            @w_prm1,
                            @w_prm2,
                            @w_prm3,
                            @w_prm4,
                            @w_prm5,
                            @w_prm6,
                            @w_producto,
                            @w_nombre_co,
                            @w_tasa_hoy

  if @@fetch_status = -1
  begin
    print ' No encontro registros '
    close cursor_cuentas
    deallocate cursor_cuentas
    goto FIN
  end
  else if @@fetch_status = -2
  begin
    print ' Error al Abrir el Cursor '
    close cursor_cuentas
    deallocate cursor_cuentas
    select
      @o_procesadas
    select
      @w_msg = 'HUBO ERROR EN LA LECTURA DE LOS REGISTROS'
    goto ERROR
  end

  while @@fetch_status = 0
  begin
    if @w_contador % 300 = 0
      begin tran

    select
      @w_numdeci = 0

    select
      @w_ret_bancos = @w_ah_12h + @w_ah_24h
    select
      @w_contable = @w_ret_bancos + @w_ah_disponible + @w_consumos
    select
      @w_semestral = round((@w_prm1 + @w_prm2 + @w_prm3 + @w_prm4 + @w_prm5 +
                            @w_prm6)
                           / 6,
                           @w_numdeci)

    --  BUSCA COTITULARES
    exec cob_interfase..sp_icte_sp_cotitulares
      @i_cta      = @w_ah_cta_banco,
      @i_mon      = @w_ah_moneda,
      @i_producto = @w_producto,
      @o_nombre1  = @w_codeudor1 out,
      @o_nombre2  = @w_codeudor2 out

    if @w_codeudor2 is null
      select
        @w_codeudor2 = ' '
        
     -- si la direccion es tipo Casilla    
    if @w_ah_tipo_dir = 'C'
    begin
      select
          @w_cliente_ec = ah_cliente_ec,
          @w_no_apartado = ah_direccion_ec
        from   cob_ahorros..ah_cuenta
        where  ah_cta_banco = @w_ah_cta_banco
        
        select
        @w_descripcion_ec = cs_emp_postal + ' - ' + cs_valor + char(13) +
                            pv_descripcion
                                   + ' REP. ' +
                                   pa_descripcion
      from   cobis..cl_casilla,
             cobis..cl_provincia,
             cobis..cl_pais
      where  cs_ente      = @w_cliente_ec
         and cs_casilla   = @w_no_apartado
         and cs_provincia = pv_provincia
         and pv_pais      = pa_pais
    end
    -- si la direccion es tipo Domicilio
    if @w_ah_tipo_dir = 'D'
    begin
      if @w_direccion_ec <> 0
      begin
        select
          @w_descripcion_ec = isnull(di_descripcion,
                                  ''),
          @w_zona = 0,
          @w_parroquia = isnull(di_ciudad,
                                0),
          @w_sector = 0
        from   cobis..cl_direccion
        where  di_ente      = @w_cliente_ec
           and di_direccion = @w_direccion_ec
      end
     end    
        
    /* Insercion de la cabecera en ah_estado_cta */
    insert into ah_estado_cta
                (ec_cuenta,ec_cta_banco,ec_fecha_prx_corte,ec_fecha_ult_corte,
                 ec_fecha_ult_mov,
                 ec_fecha_ult_mov_int,ec_oficina,ec_oficial,ec_moneda,ec_nombre,
                 ec_ced_ruc,ec_cliente,ec_cliente_ec,ec_direccion_ec,
                 ec_descripcion_ec,
                 ec_tipo_dir,ec_disponible,ec_saldo_contable,ec_saldo_ult_corte,
                 ec_saldo_promedio,
                 ec_ret_locales,ec_ret_plazas,ec_telefono,ec_tipocta,ec_nombre1,
                 ec_zona,ec_parroquia,ec_sector,ec_prod_banc,ec_consumos,
                 ec_monto_imp,ec_prom_semestral,ec_nombre2,ec_tasa_hoy)
    values      (@w_cuenta,@w_ah_cta_banco,@w_ah_fecha_prx_corte,
                 @w_ah_fecha_ult_corte,
                 @w_ah_fecha_ult_mov,
                 @w_ah_fecha_ult_mov_int,@w_ah_oficina,@w_oficial,@w_ah_moneda,
                 @w_nombre,
                 @w_ced,@w_ah_cliente,@w_cliente_ec,@w_direccion_ec,
                 @w_descripcion_ec,
                 @w_ah_tipo_dir,@w_ah_disponible,@w_contable,
                 @w_ah_saldo_ult_corte
                 ,
                 @w_ah_promedio1,
                 @w_ret_bancos,@w_ah_remesas,@w_telefono,@w_tipocta,@w_nombre_co
                 ,
                 @w_zona,@w_parroquia,@w_sector,
                 -- @w_codeudor1 Se cambio por el campo de ah_nombre1
                 @w_ah_prod_banc,@w_consumos,
                 @w_monto_imp,@w_semestral,@w_codeudor2,@w_tasa_hoy)

    if @@error <> 0
    begin
      rollback tran
      /* Error de insercion - Grabar en la tabla de errores */
      insert cob_ahorros..re_error_batch
      values (@w_ah_cta_banco,'ERROR EN LA INSERCION DEL ESTADO DE CUENTA')

      if @@error <> 0
      begin
        /* Cerrar y liberar cursor */
        close cursor_cuentas
        deallocate cursor_cuentas

        select
          @o_procesadas = @w_contador

      /* Error en grabacion de archivo de errores */
        /*exec cobis..sp_cerror
             @i_num       = 203035
        
        return 203035*/

        select
          @w_msg = 'HUBO ERROR EN LA GRABACION DE ARCHIVO DE ERRORES'
        goto ERROR

      end
      goto CUENTAS_CUR
    end

    /* Calculo de la fecha del proximo corte de estado de cuenta */
    if @w_ah_ciclo <> '3'
    begin
      select
        @w_dia_ciclo = substring(valor,
                                 1,
                                 2)
      from   cobis..cl_catalogo
      where  tabla  = (select
                         codigo
                       from   cobis..cl_tabla
                       where  tabla = 'ah_ciclo')
         and codigo = @w_ah_ciclo

      select
        @w_prx_mes = convert(varchar(10), dateadd(mm,
                                                  1,
                                                  @i_fecha), 101)
      select
        @w_fecha_prx_ec = convert(datetime, substring(@w_prx_mes, 1, 2) + '/' +
        @w_dia_ciclo
        + '/' +
        substring
        (@w_prx_mes,
        7
        , 4))

    /*** La determinacion del anterior dia laboral  se           ****/
      /*** hace mediante el llamado al siguiente sp  - JLOYO           ****/
      exec @w_return = cob_remesas..sp_fecha_habil
        @i_val_dif       = 'N',
        @i_efec_dia      = 'S',
        @i_fecha         = @w_fecha_prx_ec,
        @i_oficina       = @w_ah_oficina,
        @i_finsemana     = 'N',
        @i_dif           = 'N',/**** Ingreso en  horario normal  ***/
        @w_dias_ret      = -1,/*** Dia anterior habil          ***/
        @o_ciudad_matriz = @w_ciudad_matriz out,
        @o_fecha_sig     = @w_fecha_prx_ec out

      if @w_return <> 0
      begin
        select
          @w_msg = 'HUBO ERROR EN LA BUSQUEDA DEL DIA ANT. LABORAL'
        goto ERROR
      end
    end

    /* Actualizacion de la cuenta con los nuevos valores encontrados */
    update cob_ahorros..ah_cuenta
    set    ah_fecha_ult_corte = convert(datetime, @i_fecha),
           ah_saldo_ult_corte = isnull(@w_contable,
                                       0),
           ah_contador_trx = 0,
           ah_fecha_prx_corte = @w_fecha_prx_ec
    where  ah_cuenta = @w_cuenta

    /* Actualizacion de la cuenta temporal con los nuevos valores encontrados */
    update cob_ahorros..ah_cuenta_tmp
    set    ah_fecha_ult_corte = convert(datetime, @i_fecha),
           ah_saldo_ult_corte = isnull(@w_contable,
                                       0),
           ah_contador_trx = 0,
           ah_fecha_prx_corte = @w_fecha_prx_ec
    where  ah_cuenta = @w_cuenta

    select
      @w_contador = @w_contador + 1

    if @w_contador % 300 = 0
      commit tran

    CUENTAS_CUR:
    fetch cursor_cuentas into @w_cuenta,
                              @w_ah_cta_banco,
                              @w_ah_ciclo,
                              @w_ah_fecha_ult_corte,
                              @w_ah_12h,
                              @w_ah_24h,
                              @w_ah_remesas,
                              @w_ah_disponible,
                              @w_consumos,
                              @w_ah_promedio1,
                              @w_ah_prom_disponible,
                              @w_ah_saldo_ult_corte,
                              @w_ah_fecha_prx_corte,
                              @w_ah_fecha_ult_mov,
                              @w_nombre,
                              @w_ah_fecha_ult_mov_int,
                              @w_ah_oficina,
                              @w_ah_contador_trx,
                              @w_ah_moneda,
                              @w_ah_tipo_dir,
                              @w_ah_cliente,
                              @w_ah_prod_banc,
                              @w_ced,
                              @w_oficial,
                              @w_descripcion_ec,
                              @w_cliente_ec,
                              @w_direccion_ec,
                              @w_telefono,
                              @w_tipocta,
                              @w_nombre1,
                              @w_zona,
                              @w_parroquia,
                              @w_sector,
                              @w_monto_imp,
                              @w_prm1,
                              @w_prm2,
                              @w_prm3,
                              @w_prm4,
                              @w_prm5,
                              @w_prm6,
                              @w_producto,
                              @w_nombre_co,
                              @w_tasa_hoy

    /* Validar el Status del Cursor */
    if @@fetch_status = -2
    begin
      print 'ERROR EN LECTURA DE CUENTAS DE AHORROS 1'
      rollback tran

      insert into re_error_batch
      values      ('0','ERROR EN LECTURA DE CUENTAS DE AHORROS 1')

      close cursor_cuentas
      deallocate cursor_cuentas
      select
        @o_procesadas

      --return 251061
      select
        @w_msg = 'HUBO ERROR EN LA LECTURA DE LOS REGISTROS'
      goto ERROR

    end
    if @@fetch_status = -1
    begin
      close cursor_cuentas
      deallocate cursor_cuentas
      if @@trancount >= 1
        commit tran
      select
        @o_procesadas
      goto FIN
    end
  end

  if @@trancount >= 1
    commit tran

  close cursor_cuentas
  deallocate cursor_cuentas
  select
    @o_procesadas = @w_contador

  FIN:
  return 0

  ERROR:
  exec sp_errorlog
    @i_fecha       = @i_fecha,
    @i_error       = 1,
    @i_usuario     = 'Operador',
    @i_tran        = 0,
    @i_cuenta      = '',
    @i_descripcion = @w_msg

  return 1

go

