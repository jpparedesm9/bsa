/********************************************************************/
/*  Archivo:            datos_adic_aho.sp                           */
/*  Stored procedure:   sp_datos_adic_aho                           */
/*  Base de datos:      cob_ahorros                                 */
/*  Producto:           Cuentas Corrientes                          */
/*  Disenado por:       Jaime Hidalgo                               */
/*  Fecha de escritura: 24-Marzo-2005                               */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                         PROPOSITO                                */
/*  Este programa procesa las transacciones de:                     */
/*  Mantenimiento de Datos Adicionales de Cuentas de Ahorro         */
/********************************************************************/
/*                      MODIFICACIONES                              */
/*  FECHA           AUTOR           RAZON                           */
/*  24/Mar/2005     J.Hidalgo       Emision Inicial                 */
/*  03/May/2016     J. Salazar      Migracion COBIS CLOUD MEXICO    */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_datos_adic_aho')
  drop proc sp_datos_adic_aho
go

/****** Object:  StoredProcedure [dbo].[sp_datos_adic_aho]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_datos_adic_aho
(
  @s_ssn                 int = null,
  @s_date                datetime = null,
  @s_user                login = null,
  @s_term                descripcion = null,
  @s_corr                char(1) = null,
  @s_ssn_corr            int = null,
  @s_ofi                 smallint = null,
  @t_rty                 char(1) = null,
  @t_trn                 smallint = null,
  @t_debug               char(1) = 'N',
  @t_file                varchar(14) = null,
  @t_from                varchar(30) = null,
  @t_show_version        bit = 0,
  @i_operacion           char(1) = null,
  @i_modo                smallint = null,
  @i_mon                 tinyint,
  @i_fecha_ingreso       datetime = null,
  @i_fecha_modif         datetime = null,
  @i_cta_banco           cuenta,
  @i_dep_inicial         money = null,
  @i_forma_dep_inicial   varchar(10) = null,
  @i_proposito_cuenta    varchar(10) = null,
  @i_origen_fondos       varchar(10) = null,
  @i_prod_cobis1         varchar(10) = null,
  @i_prod_cobis2         varchar(10) = null,
  @i_monto_ext           money = null,
  @i_trx_ext             int = null,
  @i_frecuencia_ext      varchar(10) = null,
  @i_monto_efec          money = null,
  @i_trx_efec            int = null,
  @i_frecuencia_efec     varchar(10) = null,
  @i_monto_refec         money = null,
  @i_trx_refec           int = null,
  @i_frecuencia_refec    varchar(10) = null,
  @i_monto_giro          money = null,
  @i_trx_giro            int = null,
  @i_frecuencia_giro     varchar(10) = null,
  @i_monto_gerencia      money = null,
  @i_trx_gerencia        int = null,
  @i_frecuencia_gerencia varchar(10) = null,
  @i_monto_transfer      money = null,
  @i_trx_transfer        int = null,
  @i_frecuencia_transfer varchar(10) = null,
  @i_monto_recib         money = null,
  @i_trx_recib           int = null,
  @i_frecuencia_recib    varchar(10) = null,
  @i_oficina             smallint = null,
  @i_filial              tinyint  = null

)

as
  declare
    @w_return                   int,/* valor que retorna */
    @w_sp_name                  varchar(32),/* nombre del stored procedure*/
    @w_siguiente                tinyint,/* siguiente codigo de periodo */
    @w_cta_banco                cuenta,
    @w_ctahorro                 int,
    @w_existe                   int,/* 1= existe, 0 = no existe */
    @w_dep_inicial              money,
    @w_forma_dep_inicial        varchar(10),
    @w_proposito_cuenta         varchar(10),
    @w_origen_fondos            varchar(10),
    @w_prod_cobis1              varchar(10),
    @w_prod_cobis2              varchar(10),
    @w_monto_ext                money,
    @w_trx_ext                  int,
    @w_frecuencia_ext           varchar(10),
    @w_monto_efec               money,
    @w_trx_efec                 int,
    @w_frecuencia_efec          varchar(10),
    @w_monto_refec              money,
    @w_trx_refec                int,
    @w_frecuencia_refec         varchar(10),
    @w_monto_giro               money,
    @w_trx_giro                 int,
    @w_frecuencia_giro          varchar(10),
    @w_monto_gerencia           money,
    @w_trx_gerencia             int,
    @w_frecuencia_gerencia      varchar(10),
    @w_monto_transfer           money,
    @w_trx_transfer             int,
    @w_frecuencia_transfer      varchar(10),
    @w_monto_recib              money,
    @w_trx_recib                int,
    @w_frecuencia_recib         varchar(10),
    @w_desc_forma_dep_inicial   varchar(64),
    @w_desc_proposito_cuenta    varchar(64),
    @w_desc_origen_fondos       varchar(64),
    @w_desc_prod_cobis1         varchar(64),
    @w_desc_prod_cobis2         varchar(64),
    @w_desc_frecuencia_ext      varchar(64),
    @w_desc_frecuencia_efec     varchar(64),
    @w_desc_frecuencia_refec    varchar(64),
    @w_desc_frecuencia_giro     varchar(64),
    @w_desc_frecuencia_gerencia varchar(64),
    @w_desc_frecuencia_transfer varchar(64),
    @w_desc_frecuencia_recib    varchar(64),
    @w_sucursal                 smallint,
    @w_subtipo                  char(1),
    @w_aporte_social            money

  select
    @w_sp_name = 'sp_datos_adic_aho'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

/************************************************/
  /*  Tipo de Transaccion = 34X  */
  if (@t_trn <> 345
      and @i_operacion = 'I')
      or (@t_trn <> 347
          and @i_operacion = 'Q')
      or (@t_trn <> 346
          and @i_operacion = 'U')
      or (@t_trn <> 348
          and @i_operacion = 'S')
  begin
    /* 'Tipo de transaccion no corresponde' */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  /* Chequeo de existencias */

  select
    @w_ctahorro = ah_cuenta
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta_banco
     and ah_moneda    = @i_mon

  /* No existe Cuenta */
  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251001
    return 251001
  end

  /* Inicializar variables de trabajo */

  select
    @w_dep_inicial = 0.00,
    @w_monto_ext = 0.00,
    @w_monto_efec = 0.00,
    @w_monto_refec = 0.00,
    @w_monto_giro = 0.00,
    @w_monto_gerencia = 0.00,
    @w_monto_transfer = 0.00,
    @w_monto_recib = 0.00,
    @w_aporte_social = 0.00

  if @i_operacion <> 'Q'
  begin
    select
      @w_cta_banco = da_cta_banco,
      @w_dep_inicial = isnull(da_dep_inicial, 0.00),
      @w_forma_dep_inicial = da_forma_dep_inicial,
      @w_proposito_cuenta = da_proposito_cuenta,
      @w_origen_fondos = da_origen_fondos,
      @w_prod_cobis1 = da_prod_cobis1,
      @w_prod_cobis2 = da_prod_cobis2,
      @w_monto_ext = isnull(da_monto_ext,0.00),
      @w_trx_ext = da_trx_ext,
      @w_frecuencia_ext = da_frecuencia_ext,
      @w_monto_efec = isnull(da_monto_efec,0.00),
      @w_trx_efec = da_trx_efec,
      @w_frecuencia_efec = da_frecuencia_efec,
      @w_monto_refec = isnull(da_monto_refec,0.00),
      @w_trx_refec = da_trx_refec,
      @w_frecuencia_refec = da_frecuencia_refec,
      @w_monto_giro = isnull(da_monto_giro,0.00),
      @w_trx_giro = da_trx_giro,
      @w_frecuencia_giro = da_frecuencia_giro,
      @w_monto_gerencia = isnull(da_monto_gerencia,0.00),
      @w_trx_gerencia = da_trx_gerencia,
      @w_frecuencia_gerencia = da_frecuencia_gerencia,
      @w_monto_transfer = isnull(da_monto_transfer,0.00),
      @w_trx_transfer = da_trx_transfer,
      @w_frecuencia_transfer = da_frecuencia_transfer,
      @w_monto_recib = isnull(da_monto_recib,0.00),
      @w_trx_recib = da_trx_recib,
      @w_frecuencia_recib = da_frecuencia_recib
    from   cob_ahorros..ah_datos_adic
    where  da_cta_banco = @i_cta_banco

    if @@rowcount = 1
      select
        @w_existe = 1
    else
      select
        @w_existe = 0
  end

  if @i_operacion = 'I'
  begin
    if @w_existe = 1
    begin
      /* 'Registro ya existe' */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201312
      return 1
    end

    begin tran
    insert into cob_ahorros..ah_datos_adic
                (da_cta_banco,da_fecha_ingreso,da_fecha_ult_modif,da_usuario,
                 da_dep_inicial,
                 da_forma_dep_inicial,da_origen_fondos,da_proposito_cuenta,
                 da_prod_cobis1,da_prod_cobis2,
                 da_monto_ext,da_trx_ext,da_frecuencia_ext,da_monto_efec,
                 da_trx_efec,
                 da_frecuencia_efec,da_monto_refec,da_trx_refec,
                 da_frecuencia_refec,da_monto_giro,
                 da_trx_giro,da_frecuencia_giro,da_monto_gerencia,
                 da_trx_gerencia,
                 da_frecuencia_gerencia,
                 da_monto_transfer,da_trx_transfer,da_frecuencia_transfer,
                 da_monto_recib,da_trx_recib,
                 da_frecuencia_recib)
    values      (@i_cta_banco,@i_fecha_ingreso,@i_fecha_modif,@s_user,
                 @i_dep_inicial,
                 @i_forma_dep_inicial,@i_origen_fondos,@i_proposito_cuenta,
                 @i_prod_cobis1,@i_prod_cobis2,
                 @i_monto_ext,@i_trx_ext,@i_frecuencia_ext,@i_monto_efec,
                 @i_trx_efec,
                 @i_frecuencia_efec,@i_monto_refec,@i_trx_refec,
                 @i_frecuencia_refec,@i_monto_giro,
                 @i_trx_giro,@i_frecuencia_giro,@i_monto_gerencia,
                 @i_trx_gerencia,
                 @i_frecuencia_gerencia,
                 @i_monto_transfer,@i_trx_transfer,@i_frecuencia_transfer,
                 @i_monto_recib,@i_trx_recib,
                 @i_frecuencia_recib)
    if @@error <> 0
    begin
      /* 'Error en insercion de registro' */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 203079
      return 1
    end
    commit tran
  end /* operacion 'I' */

  if @i_operacion = 'U'
  begin
    if @w_existe = 0
    begin
      /* 'No existe registro a actualizar' */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201313
      return 1
    end

    begin tran
    update cob_ahorros..ah_datos_adic
    set    da_fecha_ult_modif = @i_fecha_modif,
           da_dep_inicial = @i_dep_inicial,
           da_forma_dep_inicial = @i_forma_dep_inicial,
           da_proposito_cuenta = @i_proposito_cuenta,
           da_prod_cobis1 = @i_prod_cobis1,
           da_prod_cobis2 = @i_prod_cobis2,
           da_monto_ext = @i_monto_ext,
           da_trx_ext = @i_trx_ext,
           da_frecuencia_ext = @i_frecuencia_ext,
           da_monto_efec = @i_monto_efec,
           da_trx_efec = @i_trx_efec,
           da_frecuencia_efec = @i_frecuencia_efec,
           da_monto_refec = @i_monto_refec,
           da_trx_refec = @i_trx_refec,
           da_frecuencia_refec = @i_frecuencia_refec,
           da_monto_giro = @i_monto_giro,
           da_trx_giro = @i_trx_giro,
           da_frecuencia_giro = @i_frecuencia_giro,
           da_monto_gerencia = @i_monto_gerencia,
           da_trx_gerencia = @i_trx_gerencia,
           da_frecuencia_gerencia = @i_frecuencia_gerencia,
           da_monto_transfer = @i_monto_transfer,
           da_trx_transfer = @i_trx_transfer,
           da_frecuencia_transfer = @i_frecuencia_transfer,
           da_monto_recib = @i_monto_recib,
           da_trx_recib = @i_trx_recib,
           da_frecuencia_recib = @i_frecuencia_recib,
           da_origen_fondos = @i_origen_fondos
    where  da_cta_banco = @i_cta_banco

    if @@error <> 0
    begin
      /* 'Error en actualizacion de registro' */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 205067
      return 1
    end
    commit tran
  end

  if @i_operacion = 'Q'
  begin
    select
      da_dep_inicial,
      da_forma_dep_inicial,
      da_proposito_cuenta,
      da_prod_cobis1,
      da_prod_cobis2,
      da_monto_ext,
      da_trx_ext,
      da_frecuencia_ext,
      da_monto_efec,
      da_trx_efec,
      da_frecuencia_efec,
      da_monto_refec,
      da_trx_refec,
      da_frecuencia_refec,
      da_monto_giro,
      da_trx_giro,
      da_frecuencia_giro,
      da_monto_gerencia,
      da_trx_gerencia,
      da_frecuencia_gerencia,
      da_monto_transfer,
      da_trx_transfer,
      da_frecuencia_transfer,
      da_monto_recib,
      da_trx_recib,
      da_frecuencia_recib,
      da_origen_fondos
    from   cob_ahorros..ah_datos_adic
    where  da_cta_banco = @i_cta_banco

  /*  if @@rowcount = 0
      begin
          -- 'No existen registros'--
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201311
          return 1
      end
  */
  end

  if @i_operacion = 'S'
  begin
    select
      @w_desc_proposito_cuenta = b.valor
    from   cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  a.tabla  = 'cl_pro_cta'
       and a.codigo = b.tabla
       and b.codigo = @w_proposito_cuenta

    select
      @w_desc_forma_dep_inicial = b.valor
    from   cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  a.tabla  = 'cl_forma_depini'
       and a.codigo = b.tabla
       and b.codigo = @w_forma_dep_inicial

   select
      @w_desc_origen_fondos = b.valor
    from   cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  a.tabla  = 'cl_orig_fond'
       and a.codigo = b.tabla
       and b.codigo = @w_origen_fondos

    select
      @w_desc_prod_cobis1 = b.valor
    from   cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  a.tabla  = 'cl_producto'
       and a.codigo = b.tabla
       and b.codigo = @w_prod_cobis1

    select
      @w_desc_prod_cobis2 = b.valor
    from   cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  a.tabla  = 'cl_producto'
       and a.codigo = b.tabla
       and b.codigo = @w_prod_cobis2

    select
      @w_desc_frecuencia_ext = b.valor
    from   cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  a.tabla  = 'cl_frecuencia'
       and a.codigo = b.tabla
       and b.codigo = @w_frecuencia_ext

    select
      @w_desc_frecuencia_efec = b.valor
    from   cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  a.tabla  = 'cl_frecuencia'
       and a.codigo = b.tabla
       and b.codigo = @w_frecuencia_efec

    select
      @w_desc_frecuencia_refec = b.valor
    from   cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  a.tabla  = 'cl_frecuencia'
       and a.codigo = b.tabla
       and b.codigo = @w_frecuencia_refec

    select
      @w_desc_frecuencia_giro = b.valor
    from   cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  a.tabla  = 'cl_frecuencia'
       and a.codigo = b.tabla
       and b.codigo = @w_frecuencia_giro

    select
      @w_desc_frecuencia_gerencia = b.valor
    from   cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  a.tabla  = 'cl_frecuencia'
       and a.codigo = b.tabla
       and b.codigo = @w_frecuencia_gerencia

    select
      @w_desc_frecuencia_transfer = b.valor
    from   cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  a.tabla  = 'cl_frecuencia'
       and a.codigo = b.tabla
       and b.codigo = @w_frecuencia_transfer

    select
      @w_desc_frecuencia_recib = b.valor
    from   cobis..cl_tabla a,
           cobis..cl_catalogo b
    where  a.tabla  = 'cl_frecuencia'
       and a.codigo = b.tabla
       and b.codigo = @w_frecuencia_recib

    /* Obtencion de la sucursal */
    select @w_subtipo = of_subtipo from cobis..cl_oficina where of_oficina = @i_oficina
    if @w_subtipo = 'O'
        select @w_sucursal = of_regional
        from   cobis..cl_oficina
        where  of_oficina = @i_oficina
    else
        select @w_sucursal = @i_oficina

    select @w_aporte_social = co.co_val_medio 
    from   cob_ahorros..ah_cuenta,
           cobis..cl_ente,
           cob_remesas..pe_pro_bancario,
           cob_remesas..pe_mercado,
           cob_remesas..pe_pro_final,
           cob_remesas..pe_servicio_per,
           cob_remesas..pe_costo co
    where  ah_prod_banc      = pb_pro_bancario
    and    ah_cliente        = en_ente 
    and    pb_pro_bancario   = me_pro_bancario 
    and    me_tipo_ente      = en_subtipo  
    and    me_mercado        = pf_mercado 
    and    pf_sucursal       = @w_sucursal
    and    pf_producto       = ah_producto     
    and    pf_moneda         = @i_mon
    and    pf_filial         = @i_filial
    and    pf_pro_final      = sp_pro_final
    and    sp_rubro          = 'SMA'
    and    sp_servicio_per   = co_servicio_per
    and    sp_grupo_rango    = co_grupo_rango
    and    co_fecha_vigencia = (SELECT max(x.co_fecha_vigencia) FROM cob_remesas..pe_costo AS x WHERE x.co_servicio_per = sp_servicio_per AND x.co_grupo_rango = sp_grupo_rango)
    and    ah_cta_banco      = @i_cta_banco    

    select
      @w_cta_banco,
      @w_dep_inicial,
      @w_desc_forma_dep_inicial,
      @w_desc_proposito_cuenta,
      @w_desc_origen_fondos,
      @w_desc_prod_cobis1,
      @w_desc_prod_cobis2,
      @w_monto_ext,
      @w_trx_ext,
      @w_desc_frecuencia_ext,
      @w_monto_efec,
      @w_trx_efec,
      @w_desc_frecuencia_efec,
      @w_monto_refec,
      @w_trx_refec,
      @w_desc_frecuencia_refec,
      @w_monto_giro,
      @w_trx_giro,
      @w_desc_frecuencia_giro,
      @w_monto_gerencia,
      @w_trx_gerencia,
      @w_desc_frecuencia_gerencia,
      @w_monto_transfer,
      @w_trx_transfer,
      @w_desc_frecuencia_transfer,
      @w_monto_recib,
      @w_trx_recib,
      @w_desc_frecuencia_recib,
      @w_aporte_social
  end

  return 0

go
