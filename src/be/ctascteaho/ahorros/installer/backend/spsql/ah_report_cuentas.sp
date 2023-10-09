--**********************************************************************--
--      Archivo:            ah_report_cuentas.sp                        --
--      Stored procedure:   sp_reporte_cuenta_ah                        --
--      Base de datos:      cob_ahorros                                 --
--      Producto:           Cuentas de Ahorros                          --
--      Disenado por:       Javier Calderon                             --
--      Fecha de escritura: 09-Sep-2016                                 --
--**********************************************************************--
--                             IMPORTANTE                               --
--      Esta aplicacion es parte de los paquetes bancarios propiedad    --
--      de COBISCorp.                                                   --
--      Su uso no autorizado queda expresamente prohibido asi como      --
--      cualquier alteracion o agregado hecho por alguno  de sus        --
--      usuarios sin el debido consentimiento por escrito de COBISCorp. --
--      Este programa esta protegido por la ley de derechos de autor    --
--      y por las convenciones  internacionales de propiedad inte-      --
--      lectual. Su uso no  autorizado dara  derecho a COBISCorp para   --
--      obtener ordenes  de secuestro o  retencion y para  perseguir    --
--      penalmente a los autores de cualquier infraccion.               --
--**********************************************************************--
--              PROPOSITO                                               --
--      Este programa realiza lo SIGUIENTE:                             --
--      Realiza el Reporte Operativo de las cuentas de Ahorros          --
--**********************************************************************--
--                        MODIFICACIONES                                --
--      FECHA       AUTOR       RAZON                                   --
--      09/Sep/2016    J. Calderon  Migracion COBIS CLOUD MEXICO       --
--**********************************************************************--
use cob_ahorros
go


if exists (select
             1
           from   sysobjects
           where  name = 'sp_reporte_cuenta_ah')
  drop proc sp_reporte_cuenta_ah
GO

 
--***** Object:  StoredProcedure [dbo].[sp_reporte_cuenta_ah]    Script Date: 03/05/2016 9:52:01 *****--
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_reporte_cuenta_ah
(
  @t_show_version bit      = 0,
  @i_filial       tinyint  = 1,
  @i_fecha        datetime = null,
  @i_corresponsal char(1)  = 'N',--Req. 381 CB Red Posicionada 
  @i_param1       tinyint  = 1,--Filial
  @i_param2       datetime = '10/14/2016',
  @o_procesadas   int      = null out
)
as
  declare
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
    @w_tipocta              char(1),
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
    @w_prod_bancario        varchar(50), --Req. 381 CB Red Posicionada        
    @w_fecha_aux            DATETIME,
    @w_fecha                smalldatetime,
    @w_fecha1               SMALLDATETIME
    
  DECLARE @w_ah_cuenta      INT,
    @w_ah_cta_banco         CHAR (16),
    @w_ah_oficina           SMALLINT,
    @w_nomb_oficina         VARCHAR (64),
    @w_ah_moneda            TINYINT,
    @w_descp_moneda         VARCHAR (70),
    @w_ah_prod_banc         SMALLINT,
    @w_descp_prod           VARCHAR (64),
    @w_ah_origen            CHAR (3),
    @w_desc_origen          VARCHAR (70),
    @w_ah_categoria         CHAR (1),
    @w_desc_categoria       VARCHAR (70),
    @w_ah_titularidad       CHAR (1),
    @w_desc_titularidad     VARCHAR (70),
    @w_ah_oficial           SMALLINT,
    @w_nomb_oficial         VARCHAR (64),
    @w_ah_cliente           INT,
    @w_ah_nombre            CHAR (60),
    @w_ah_ced_ruc           CHAR (15),
    @w_ah_descripcion_dv    VARCHAR (64),
    @w_ah_fecha_ult_mov     VARCHAR (30),
    @w_ah_fecha_prx_capita  VARCHAR (30),
    @w_ah_numsol            INT,
    @w_ca_cta_banco_mig     CHAR (16),
    @w_ah_disponible        MONEY,
    @w_ah_12h               MONEY,
    @w_ah_24h               MONEY,
    @w_slado_contable       MONEY,
    @w_ah_saldo_interes     MONEY,
    @w_ah_tasa_hoy          FLOAT,
    @w_ah_creditos_hoy      MONEY,
    @w_ah_debitos_hoy       MONEY,
    @w_ah_num_deb_mes       INT,
    @w_ah_num_cred_mes      INT,
    @w_ah_prom_disponible   MONEY,
    @w_ah_promedio1         MONEY,
    @w_ah_promedio2         MONEY,
    @w_ah_promedio3         MONEY,
    @w_ah_promedio4         MONEY,
    @w_ah_promedio5         MONEY,
    @w_ah_promedio6         MONEY,
    @w_ah_monto_bloq        MONEY,
    @w_monto_bloq1          MONEY,
    @w_fecha_bloq1          VARCHAR (30),
    @w_monto_bloq2          MONEY,
    @w_fecha_bloq2          VARCHAR (30),
    @w_monto_bloq3          MONEY,
    @w_fecha_bloq3          VARCHAR (30),
    @w_existe_bloq1         VARCHAR (1),
    @w_fecha_bloqm1         VARCHAR (30),
    @w_existe_bloq2         VARCHAR (1),
    @w_fecha_bloqm2         VARCHAR (30),
    @w_existe_bloq3         VARCHAR (1),
    @w_fecha_bloqm3         VARCHAR (30),
    @w_ah_estado            CHAR (1),
    @w_descip_estado        VARCHAR (70),
    @w_ah_fecha_aper        VARCHAR (30),
    @w_ah_fecha_inacti      VARCHAR (30),
    @w_ah_fecha_reacti      VARCHAR (1),
    @w_ah_fecha_cierre      VARCHAR (30),
    @w_archivo               descripcion,
    @w_archivo_bcp           descripcion,
    @w_errores               descripcion,
    @w_tot_reg               int,
    @w_path_s_app            varchar(30),
    @w_path                  varchar(250),
    @w_s_app                 varchar(250),
    @w_cmd                   varchar(250),
    @w_error                 int,
    @w_comando               varchar(250),
    @w_path_sapp             varchar(250),
    @w_tab                   char(1),
    @w_aho_pro               INT,
    @w_aho_asa               INT,
    @w_aho_aso               INT,
    @w_fecha_pro             SMALLDATETIME,
    @w_fecha_ini            SMALLDATETIME,
    @w_nombre_banco          varchar(30)
   
  -- Captura nombre de stored procedure --
  select
    @w_sp_name = 'sp_estado_cuenta_ah',
    @i_fecha = @i_param2

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

 

  if @i_param2 is null
     and @i_fecha is null
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

  if @i_param2 is null
  begin
     select
     @w_msg   = case when @i_param2 is null then 'PARAMETRO FECHA ES OBLIGATORIO' end,
     @w_error = case when @i_param2 is null then 101114  end,
     @w_fecha = fp_fecha from cobis..ba_fecha_proceso
     goto ERROR
  end
  else
     select @w_fecha = convert(smalldatetime,@i_param2)

  
   select @w_fecha_pro = fp_fecha from cobis..ba_fecha_proceso
-- Obtencion del codigo de la ciudad de feriados nacionales para el --
-- calculo de la fecha de proximo corte                             --
   
    select @w_fecha_ini = convert(varchar, datepart(mm, @w_fecha)) + '/01/'+ convert(varchar, datepart(yy, @w_fecha))

   if @i_param2 > @w_fecha_pro
   begin
      select
      @w_msg   = 'FECHA INGRESADA ES MAYOR A LA FECHA DE PROCESO'
      goto ERROR
   end

  select @w_ciudad_matriz = pa_int
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
  END
  
 -- PRINT '@w_ciudad_matriz' + convert(VARCHAR,@w_ciudad_matriz)
  -- Codigo de moneda local
  select @w_moneda = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'CMNAC'

  if @@rowcount <> 1
  begin
    select
      @w_msg = 'ERROR EN PARAMETRO DE MONEDA NACIONAL'
    goto ERROR
  end
 
  -- Encuentra parametro de decimales --
  select @w_usadeci = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @w_moneda

  select @w_numdeci = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'DCI'

  if @@rowcount <> 1
  begin
    -- Grabar en la tabla de errores --
    insert cob_ahorros..re_error_batch
    values ('0','ERROR AL BUSCAR PARAMETRO DECIMALES')

    if @@error <> 0
    begin
      select
        @w_msg = 'HUBO ERROR EN LA GRABACION DE ARCHIVO DE ERRORES'
      goto ERROR
    end
  end

   --Almacena las ctas reacticadas
   CREATE TABLE #ctas_reactivadas
    (   fecha_reactiva DATETIME,
        cuenta_react   VARCHAR(20)           

     )

  -- Encuentra parametro oficina --
  select  @w_ofi = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'OMAT'

  if @@rowcount <> 1
  begin
    select
      @w_msg = 'ERROR NO EXISTE PARAMETRO OFICINA OMAT'
    goto ERROR
  end

  select @w_aho_pro = pa_int 
  from cobis..cl_parametro 
  where pa_producto = 'AHO' 
  and pa_nemonico = 'PAHCT' 
  
   if @@rowcount <> 1
  begin
    select
      @w_msg = 'ERROR NO EXISTE PARAMETRO AHORRO PROGRAMADO'
    goto ERROR
  end
     
  SELECT @w_aho_aso = pa_int
  from cobis..cl_parametro 
  where pa_producto = 'AHO'
    and pa_nemonico = 'PCAASO'
    
     if @@rowcount <> 1
  begin
    select
      @w_msg = 'ERROR NO EXISTE PARAMETRO AHORRO ORDINARIO'
    goto ERROR
  end
 
  
  SELECT @w_prod_bancario = pa_smallint
  from cobis..cl_parametro 
  where pa_producto = 'AHO'
    and pa_nemonico like 'PBCB'  
   
      if @@rowcount <> 1
  begin
    select
      @w_msg = 'ERROR NO EXISTE PRODUCTO BANCARIO CORRESPONSAL'
    goto ERROR
  end
      
    
  SELECT @w_aho_asa = pa_int
  from cobis..cl_parametro 
  where pa_producto = 'AHO'
    and pa_nemonico = 'PCAASA'  
    
     if @@rowcount <> 1
  begin
    select
      @w_msg = 'ERROR NO EXISTE PARAMETRO AHORRO ORDINARIO ADICIONAL'
    goto ERROR
  end

  SELECT @w_nombre_banco = replace(pa_char,' ','_')
  from cobis..cl_parametro 
  where pa_producto = 'REC'
    and pa_nemonico = 'NOBA'  
    
  if @@rowcount <> 1
  begin
    select
      @w_msg = 'ERROR NO EXISTE PARAMETRO NOMBRE BANCO'
    goto ERROR
  end
 
  -- Proxima fecha laborable 
  select @w_prx_fec_lab = min(dl_fecha)
  from   cob_ahorros..ah_dias_laborables
  where  dl_ciudad   = @w_ciudad_matriz
    and dl_num_dias = 0
 
  exec @w_return = cob_remesas..sp_fecha_habil
    @i_val_dif       = 'N',
    @i_efec_dia      = 'S',
    @i_fecha         = @w_dia_pri,
    @i_oficina       = @w_ofi,
    @i_dif           = 'N',-- Ingreso en  horario normal  
    @i_finsemana     = 'N',
    @w_dias_ret      = -1,-- Dia anterior habil          
    @o_ciudad_matriz = @w_ciudad_matriz out,
    @o_fecha_sig     = @w_fecha_prx_ec out

  if @w_return <> 0
  begin
    select
      @w_msg = 'HUBO ERROR EN LA BUSQUEDA DEL DIA ANT. LABORAL'
    goto ERROR
  END

 -- PRINT 'Producto Corresponsal -->'  + convert(varchar,@w_prod_bancario)  --jca
  select @w_contador = 0
   
   
CREATE TABLE #ah_cuenta_rpt
    (
    ah_cuenta            INT NOT NULL,
    ah_cta_banco         CHAR (16) COLLATE Latin1_General_BIN NOT NULL,
    ah_estado            CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_control           INT NOT NULL,
    ah_filial            TINYINT NOT NULL,
    ah_oficina           SMALLINT NOT NULL,
    ah_producto          TINYINT NOT NULL,
    ah_tipo              CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_moneda            TINYINT NOT NULL,
    ah_fecha_aper        SMALLDATETIME NOT NULL,
    ah_oficial           SMALLINT NOT NULL,
    ah_cliente           INT NOT NULL,
    ah_ced_ruc           CHAR (15) COLLATE Latin1_General_BIN NOT NULL,
    ah_nombre            CHAR (60) COLLATE Latin1_General_BIN NOT NULL,
    ah_categoria         CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_tipo_promedio     CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_capitalizacion    CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_ciclo             CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_suspensos         SMALLINT NOT NULL,
    ah_bloqueos          SMALLINT NOT NULL,
    ah_condiciones       SMALLINT NOT NULL,
    ah_monto_bloq        MONEY NOT NULL,
    ah_num_blqmonto      SMALLINT NOT NULL,
    ah_cred_24           CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_cred_rem          CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_tipo_def          CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_default           INT NOT NULL,
    ah_rol_ente          CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_disponible        MONEY NOT NULL,
    ah_12h               MONEY NOT NULL,
    ah_12h_dif           MONEY NOT NULL,
    ah_24h               MONEY NOT NULL,
    ah_48h               MONEY NOT NULL,
    ah_remesas           MONEY NOT NULL,
    ah_rem_hoy           MONEY NOT NULL,
    ah_interes           MONEY NOT NULL,
    ah_interes_ganado    MONEY NOT NULL,
    ah_saldo_libreta     MONEY NOT NULL,
    ah_saldo_interes     MONEY NOT NULL,
    ah_saldo_anterior    MONEY NOT NULL,
    ah_saldo_ult_corte   MONEY NOT NULL,
    ah_saldo_ayer        MONEY NOT NULL,
    ah_creditos          MONEY NOT NULL,
    ah_debitos           MONEY NOT NULL,
    ah_creditos_hoy      MONEY NOT NULL,
    ah_debitos_hoy       MONEY NOT NULL,
    ah_fecha_ult_mov     SMALLDATETIME NOT NULL,
    ah_fecha_ult_mov_int SMALLDATETIME NOT NULL,
    ah_fecha_ult_upd     SMALLDATETIME NOT NULL,
    ah_fecha_prx_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_corte   SMALLDATETIME NOT NULL,
    ah_fecha_ult_capi    SMALLDATETIME NOT NULL,
    ah_fecha_prx_capita  SMALLDATETIME NOT NULL,
    ah_linea             SMALLINT NOT NULL,
    ah_ult_linea         SMALLINT NOT NULL,
    ah_cliente_ec        INT NOT NULL,
    ah_direccion_ec      TINYINT NOT NULL,
    ah_descripcion_ec    CHAR (120) COLLATE Latin1_General_BIN NOT NULL,
    ah_tipo_dir          CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_agen_ec           SMALLINT NOT NULL,
    ah_parroquia         INT NOT NULL,
    ah_zona              SMALLINT NOT NULL,
    ah_prom_disponible   MONEY NOT NULL,
    ah_promedio1         MONEY NOT NULL,
    ah_promedio2         MONEY NOT NULL,
    ah_promedio3         MONEY NOT NULL,
    ah_promedio4         MONEY NOT NULL,
    ah_promedio5         MONEY NOT NULL,
    ah_promedio6         MONEY NOT NULL,
    ah_personalizada     CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_contador_trx      INT NOT NULL,
    ah_cta_funcionario   CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_tipocta           CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_prod_banc         SMALLINT NOT NULL,
    ah_origen            CHAR (3) COLLATE Latin1_General_BIN NOT NULL,
    ah_numlib            INT NOT NULL,
    ah_dep_ini           TINYINT NOT NULL,
    ah_contador_firma    INT NOT NULL,
    ah_telefono          CHAR (12) COLLATE Latin1_General_BIN NOT NULL,
    ah_int_hoy           MONEY NOT NULL,
    ah_tasa_hoy          REAL NOT NULL,
    ah_min_dispmes       MONEY NOT NULL,
    ah_fecha_ult_ret     SMALLDATETIME NOT NULL,
    ah_cliente1          INT NOT NULL,
    ah_nombre1           CHAR (64) COLLATE Latin1_General_BIN NOT NULL,
    ah_cedruc1           CHAR (13) COLLATE Latin1_General_BIN NOT NULL,
    ah_sector            SMALLINT NOT NULL,
    ah_monto_imp         MONEY NOT NULL,
    ah_monto_consumos    MONEY NOT NULL,
    ah_ctitularidad      CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_promotor          SMALLINT NOT NULL,
    ah_int_mes           MONEY NOT NULL,
    ah_tipocta_super     CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_direccion_dv      TINYINT NOT NULL,
    ah_descripcion_dv    VARCHAR (64) COLLATE Latin1_General_BIN NOT NULL,
    ah_tipodir_dv        CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_parroquia_dv      INT NOT NULL,
    ah_zona_dv           SMALLINT NOT NULL,
    ah_agen_dv           SMALLINT NOT NULL,
    ah_cliente_dv        INT NOT NULL,
    ah_traslado          CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_aplica_tasacorp   CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_monto_emb         MONEY NOT NULL,
    ah_monto_ult_capi    MONEY NOT NULL,
    ah_saldo_mantval     MONEY NOT NULL,
    ah_cuota             MONEY NOT NULL,
    ah_creditos2         MONEY NOT NULL,
    ah_creditos3         MONEY NOT NULL,
    ah_creditos4         MONEY NOT NULL,
    ah_creditos5         MONEY NOT NULL,
    ah_creditos6         MONEY NOT NULL,
    ah_debitos2          MONEY NOT NULL,
    ah_debitos3          MONEY NOT NULL,
    ah_debitos4          MONEY NOT NULL,
    ah_debitos5          MONEY NOT NULL,
    ah_debitos6          MONEY NOT NULL,
    ah_tasa_ayer         REAL NOT NULL,
    ah_estado_cuenta     CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_permite_sldcero   CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ah_rem_ayer          MONEY NOT NULL,
    ah_numsol            INT NOT NULL,
    ah_patente           CHAR (40) COLLATE Latin1_General_BIN NOT NULL,
    ah_fideicomiso       VARCHAR (15) COLLATE Latin1_General_BIN NULL,
    ah_nxmil             CHAR (1) COLLATE Latin1_General_BIN NULL,
    ah_clase_clte        CHAR (1) COLLATE Latin1_General_BIN NULL,
    ah_deb_mes_ant       MONEY NULL,
    ah_cred_mes_ant      MONEY NULL,
    ah_num_deb_mes       INT NULL,
    ah_num_cred_mes      INT NULL,
    ah_num_con_mes       INT NULL,
    ah_num_deb_mes_ant   INT NULL,
    ah_num_cred_mes_ant  INT NULL,
    ah_num_con_mes_ant   INT NULL,
    ah_fecha_ult_proceso DATETIME NULL
    )


    INSERT INTO #ah_cuenta_rpt
    SELECT     ah_cuenta,    ah_cta_banco,    ah_estado,    ah_control,    ah_filial,    ah_oficina,    ah_producto,    ah_tipo,    ah_moneda,    ah_fecha_aper,
    ah_oficial,    ah_cliente,    ah_ced_ruc,    ah_nombre,    ah_categoria,    ah_tipo_promedio,    ah_capitalizacion,    ah_ciclo,    ah_suspensos,
    ah_bloqueos,    ah_condiciones,    ah_monto_bloq,    ah_num_blqmonto,    ah_cred_24,    ah_cred_rem,    ah_tipo_def,    ah_default,
    ah_rol_ente,    ah_disponible,    ah_12h,    ah_12h_dif,    ah_24h,    ah_48h,    ah_remesas,    ah_rem_hoy,    ah_interes,    ah_interes_ganado,
    ah_saldo_libreta,    ah_saldo_interes,    ah_saldo_anterior,    ah_saldo_ult_corte,    ah_saldo_ayer,    ah_creditos,    ah_debitos,
    ah_creditos_hoy,    ah_debitos_hoy,    ah_fecha_ult_mov,    ah_fecha_ult_mov_int,    ah_fecha_ult_upd,    ah_fecha_prx_corte,
    ah_fecha_ult_corte,    ah_fecha_ult_capi,    ah_fecha_prx_capita,    ah_linea,    ah_ult_linea,    ah_cliente_ec,    ah_direccion_ec,
    ah_descripcion_ec,    ah_tipo_dir,    ah_agen_ec,    ah_parroquia,    ah_zona,    ah_prom_disponible,    ah_promedio1,    ah_promedio2,
    ah_promedio3,    ah_promedio4,    ah_promedio5,    ah_promedio6,    ah_personalizada,    ah_contador_trx,    ah_cta_funcionario,
    ah_tipocta,    ah_prod_banc,    ah_origen,    ah_numlib,    ah_dep_ini,    ah_contador_firma,    ah_telefono,    ah_int_hoy,    ah_tasa_hoy,
    ah_min_dispmes,    ah_fecha_ult_ret,    ah_cliente1,    ah_nombre1,    ah_cedruc1,    ah_sector,    ah_monto_imp,    ah_monto_consumos,
    ah_ctitularidad,    ah_promotor,    ah_int_mes,    ah_tipocta_super,    ah_direccion_dv,    ah_descripcion_dv,    ah_tipodir_dv,
    ah_parroquia_dv,    ah_zona_dv,    ah_agen_dv,    ah_cliente_dv,    ah_traslado,    ah_aplica_tasacorp,    ah_monto_emb,    ah_monto_ult_capi,
    ah_saldo_mantval,    ah_cuota,    ah_creditos2,    ah_creditos3,    ah_creditos4,    ah_creditos5,    ah_creditos6,    ah_debitos2,
    ah_debitos3,    ah_debitos4,    ah_debitos5,    ah_debitos6,    ah_tasa_ayer,    ah_estado_cuenta,    ah_permite_sldcero,
    ah_rem_ayer,    ah_numsol,    ah_patente,    ah_fideicomiso,    ah_nxmil,    ah_clase_clte,    ah_deb_mes_ant,    ah_cred_mes_ant,    ah_num_deb_mes,
    ah_num_cred_mes,    ah_num_con_mes,    ah_num_deb_mes_ant,    ah_num_cred_mes_ant,    ah_num_con_mes_ant,    ah_fecha_ult_proceso 
    FROM cob_ahorros..ah_cuenta a
    WHERE ah_cuenta > 0
    AND a.ah_estado <> 'C'
    Union
    SELECT ah_cuenta,    ah_cta_banco,    ah_estado,    ah_control,    ah_filial,    ah_oficina,    ah_producto,    ah_tipo,    ah_moneda,    ah_fecha_aper,
    ah_oficial,    ah_cliente,    ah_ced_ruc,    ah_nombre,    ah_categoria,    ah_tipo_promedio,    ah_capitalizacion,    ah_ciclo,    ah_suspensos,
    ah_bloqueos,    ah_condiciones,    ah_monto_bloq,    ah_num_blqmonto,    ah_cred_24,    ah_cred_rem,    ah_tipo_def,    ah_default,
    ah_rol_ente,    ah_disponible,    ah_12h,    ah_12h_dif,    ah_24h,    ah_48h,    ah_remesas,    ah_rem_hoy,    ah_interes,    ah_interes_ganado,
    ah_saldo_libreta,    ah_saldo_interes,    ah_saldo_anterior,    ah_saldo_ult_corte,    ah_saldo_ayer,    ah_creditos,    ah_debitos,
    ah_creditos_hoy,    ah_debitos_hoy,    ah_fecha_ult_mov,    ah_fecha_ult_mov_int,    ah_fecha_ult_upd,    ah_fecha_prx_corte,
    ah_fecha_ult_corte,    ah_fecha_ult_capi,    ah_fecha_prx_capita,    ah_linea,    ah_ult_linea,    ah_cliente_ec,    ah_direccion_ec,
    ah_descripcion_ec,    ah_tipo_dir,    ah_agen_ec,    ah_parroquia,    ah_zona,    ah_prom_disponible,    ah_promedio1,    ah_promedio2,
    ah_promedio3,    ah_promedio4,    ah_promedio5,    ah_promedio6,    ah_personalizada,    ah_contador_trx,    ah_cta_funcionario,
    ah_tipocta,    ah_prod_banc,    ah_origen,    ah_numlib,    ah_dep_ini,    ah_contador_firma,    ah_telefono,    ah_int_hoy,    ah_tasa_hoy,
    ah_min_dispmes,    ah_fecha_ult_ret,    ah_cliente1,    ah_nombre1,    ah_cedruc1,    ah_sector,    ah_monto_imp,    ah_monto_consumos,
    ah_ctitularidad,    ah_promotor,    ah_int_mes,    ah_tipocta_super,    ah_direccion_dv,    ah_descripcion_dv,    ah_tipodir_dv,
    ah_parroquia_dv,    ah_zona_dv,    ah_agen_dv,    ah_cliente_dv,    ah_traslado,    ah_aplica_tasacorp,    ah_monto_emb,    ah_monto_ult_capi,
    ah_saldo_mantval,    ah_cuota,    ah_creditos2,    ah_creditos3,    ah_creditos4,    ah_creditos5,    ah_creditos6,    ah_debitos2,
    ah_debitos3,    ah_debitos4,    ah_debitos5,    ah_debitos6,    ah_tasa_ayer,    ah_estado_cuenta,    ah_permite_sldcero,
    ah_rem_ayer,    ah_numsol,    ah_patente,    ah_fideicomiso,    ah_nxmil,    ah_clase_clte,    ah_deb_mes_ant,    ah_cred_mes_ant,    ah_num_deb_mes,
    ah_num_cred_mes,    ah_num_con_mes,    ah_num_deb_mes_ant,    ah_num_cred_mes_ant,    ah_num_con_mes_ant,    ah_fecha_ult_proceso
    FROM ah_his_cierre c,cob_ahorros..ah_cuenta b
    WHERE c.hc_cuenta = b.ah_cuenta 
    AND b.ah_estado = 'C'
    AND hc_fecha BETWEEN @w_fecha_ini AND  @w_fecha
    
     IF @@ERROR <> 0
      BEGIN
      select
      @w_msg = 'ERROR INSERTAR REGISTRO EN LA TABLA #ah_cuenta_rpt'
       goto ERROR
      END 
     

   
     create table #ah_plazo_cta
     (
       cc_fecha_crea SMALLDATETIME,
       cc_cta_banco  VARCHAR(30),
       cc_plazo      int,
      
     )
     
      INSERT INTO #ah_plazo_cta
      SELECT max(cc_fecha_crea),cc_cta_banco,convert(INT,isnull(cc_plazo,0)) FROM cob_remesas..re_cuenta_contractual, cob_ahorros..ah_cuenta
      WHERE cc_cta_banco = ah_cta_banco
      AND cc_prodbanc = @w_aho_pro
      GROUP BY cc_cta_banco,cc_plazo
      UNION
      SELECT max(ah_fecha_aper),ca_cta_banco,convert(INT,isnull(ca_dias_plazo,0))  FROM cob_ahorros..ah_cuenta_aux, cob_ahorros..ah_cuenta
      WHERE ca_cta_banco = ah_cta_banco 
      AND ah_prod_banc = @w_aho_asa OR ah_prod_banc = @w_aho_aso
      GROUP BY ca_cta_banco,ca_dias_plazo
      
        
     create table #ah_plazo_cta_sin_rep
     (
       csp_fecha_crea SMALLDATETIME,
       csp_cta_banco  VARCHAR(30),
       csp_plazo      int,
      
     )
     INSERT INTO #ah_plazo_cta_sin_rep
     SELECT cc_fecha_crea,cc_cta_banco,cc_plazo
     FROM #ah_plazo_cta a
     WHERE cc_fecha_crea = (SELECT max(cc_fecha_crea) from  #ah_plazo_cta b
                                                      WHERE b.cc_cta_banco = a.cc_cta_banco)
     
      IF @@ERROR <> 0
      BEGIN
      select
      @w_msg = 'ERROR INSERTAR REGISTRO EN LA TABLA #ah_plazo_cta_sin_rep'
       goto ERROR
      END 
      
    
      INSERT INTO #ctas_reactivadas
      SELECT max(DISTINCT hs_tsfecha),hs_cta_banco  FROM cob_ahorros_his..ah_his_servicio,cob_ahorros..ah_cuenta 
      where  hs_cta_banco = ah_cta_banco
      AND hs_tipo_transaccion in (203)
      AND hs_causa in ('A')
      GROUP BY hs_cta_banco
      UNION
      SELECT max(DISTINCT tsfecha), cta_banco  FROM  cob_ahorros..ah_tscambia_estado,cob_ahorros..ah_cuenta 
      WHERE  cta_banco = ah_cta_banco
      AND  tipo_transaccion IN(203)
      AND  causa in ('A') 
      GROUP BY cta_banco                                             
      
      
      IF @@ERROR <> 0
      BEGIN
      select
      @w_msg = 'ERROR INSERTAR REGISTRO EN LA TABLA #ctas_reactivadas'
       goto ERROR
      END 
     
  
      TRUNCATE TABLE ah_report_ctas 
  
 if @i_corresponsal = 'N'
  BEGIN
  INSERT INTO ah_report_ctas
  SELECT
     'FECHA',
	 'CUENTA',
     'CTA.BANCO',
     'OFICINA',
     'DESC.OFICINA',
     'MONEDA',
     'DESC.MONEDA',
     'PROD.BANCARIO',
     'DESC.PROD.BANCARIO',
     'ORIGEN',
     'DESC.ORIGEN',                        
     'CATEGORIA',
     'DESC.CATEGORIA',                        
     'TITULARIDAD',
     'DESC.TITULARIDAD',
     'OFICIAL',
     'DESC.OFICIAL',
     'CLIENTE',
     'NOM.CLIENTE',
     'CURP/RFC',                                                                        
     'DIRECCION',
     'FECHA ULT.MOVIM.',
     'FECHA PROX.CAPIT.',
     'NUM.SOLICITUD',
     'PLAZO',  
     'PERFIL',
     'CTA.BANCO MIGRADA',
     'SALDO DISPONIBLE',
     'SALDO 12H',
     'SALDO 24H',
     'SALDO CONTABLE',
     'SALDO INTERES',
     'TASA',
     'CREDITOS',
     'DEBITOS',
     'NUM.DEB.MES',
     'NUM.CRED.MES',
     'SALDO PROM.DISP.',
     'SALDO PROM.1',
     'SALDO PROM.2',
     'SALDO PROM.3',
     'SALDO PROM.4',
     'SALDO PROM.5',
     'SALDO PROM.6',
     'MONTO BLOQUEO',
     'BLOQUEO VALOR 1',
     'FECHA BLOQ.VALOR 1',
     'BLOQUEO VALOR 2',                         
     'FECHA BLOQ.VALOR 2',                         
     'BLOQUEO VALOR 3',
     'FECHA BLOQ.VALOR 3',
     'BLOQ.CREDITO',
     'FECHA ULT.BLOQ.CREDITO',                     
     'BLOQ.DEBITO',
     'FECHA ULT.BLOQ.DEBITO',
     'BLOQ.CRED.DEB',
     'FECHA ULT.BLOQ.CRED.DEB',
     'ESTADO',
     'DESC.ESTADO',
     'FECHA APERTURA',
     'FECHA INACTIVACION',
     'FECHA CIERRE',
     'FECHA REACTIVACION'
	 
  IF @@ERROR <> 0
  BEGIN
  select
  @w_msg = 'ERROR INSERTAR CABECERA EN LA TABLA ah_report_ctas'
   goto ERROR
  END      

  INSERT INTO ah_report_ctas
  SELECT
     isnull(convert(CHAR(14),@w_fecha,101),''),
	 convert(CHAR(12),ah_cuenta),
     convert(CHAR(20),ah_cta_banco),
     convert(CHAR(7), ah_oficina),
     convert(CHAR(40),substring((SELECT of_nombre from  cobis..cl_oficina WHERE of_oficina = c.ah_oficina),1,40)),  
     convert(CHAR(6),ah_moneda),
     substring((SELECT convert(CHAR(35),valor) from cobis..cl_catalogo, cobis..cl_tabla
                   where cl_catalogo.tabla  = cl_tabla.codigo 
                   AND   cl_tabla.tabla     = 'cl_moneda'
                   and   cl_catalogo.estado = 'V' 
                   AND   cl_catalogo.codigo = convert(VARCHAR(10),c.ah_moneda)),1,64),
     convert(CHAR(13),ah_prod_banc),
     (SELECT convert(CHAR(50),pb_descripcion) FROM cob_remesas..pe_pro_bancario WHERE pb_pro_bancario = c.ah_prod_banc),
     convert(CHAR(6),ah_origen),
     isnull((SELECT convert(CHAR(50),valor) from cobis..cl_catalogo , cobis..cl_tabla 
                          where cl_catalogo.tabla  = cl_tabla.codigo 
                          AND   cl_tabla.tabla     = 'ah_tipocta'
                          and   cl_catalogo.estado = 'V'
                          AND   cl_catalogo.codigo = c.ah_origen),''),                        
     convert(CHAR(9),ah_categoria),
     isnull((SELECT convert(CHAR(50),valor) from cobis..cl_catalogo , cobis..cl_tabla 
                          where cl_catalogo.tabla  = cl_tabla.codigo 
                          AND   cl_tabla.tabla     = 'pe_categoria'
                          and   cl_catalogo.estado = 'V'
                          AND   cl_catalogo.codigo = c.ah_categoria),''),                        
     convert(CHAR(11),ah_ctitularidad),
     isnull((SELECT convert(CHAR(50),valor) from cobis..cl_catalogo , cobis..cl_tabla 
                          where cl_catalogo.tabla  = cl_tabla.codigo 
                          AND   cl_tabla.tabla     = 're_titularidad'
                          and   cl_catalogo.estado = 'V'
                          AND   cl_catalogo.codigo = c.ah_ctitularidad),''),
     convert(CHAR(7),ah_oficial),
     (SELECT convert(CHAR(64),fu_nombre) FROM cobis..cc_oficial, cobis..cl_funcionario
                       WHERE oc_funcionario = fu_funcionario
                       AND   oc_oficial  = c.ah_oficial),
     convert(CHAR(10),ah_cliente),
     convert(CHAR(80),ah_nombre) ,
     convert(CHAR(20),ah_ced_ruc),                                                                        
     convert(CHAR(64),ah_descripcion_dv),
     isnull(convert(CHAR(16),ah_fecha_ult_mov,101),''),
     isnull(convert(CHAR(17),ah_fecha_prx_capita,101),''),
     convert(CHAR(13),ah_numsol),
     isnull(convert(CHAR(6),(SELECT csp_plazo FROM #ah_plazo_cta_sin_rep WHERE csp_cta_banco = c.ah_cta_banco)),0),  
     convert(CHAR(10),'     ') ,--perfil
     isnull(convert(CHAR(18),(SELECT ca_cta_banco_mig FROM ah_cuenta_aux WHERE ca_cta_banco = c.ah_cta_banco)),''),
     isnull(convert(CHAR(18),round(ah_disponible,2)), 0.00),
     isnull(convert(CHAR(18),round(ah_12h,2)) , 0.00),  
     isnull(convert(CHAR(18),round(ah_24h,2)), 0.00),
     isnull(convert(CHAR(18),round(ah_12h +  ah_24h  +  ah_48h + ah_disponible,2)) , 0.00),
     isnull(convert(CHAR(18),round(ah_saldo_interes,2)),0.00),
     isnull(convert(CHAR(6),round(ah_tasa_hoy,2)),0.00), 
     isnull(convert(CHAR(18),round(ah_creditos_hoy,2)),0.00),  
     isnull(convert(CHAR(18),round(ah_debitos_hoy,2)),0.00), 
     isnull(convert(CHAR(11),ah_num_deb_mes),0),    
     isnull(convert(CHAR(12),ah_num_cred_mes),0),
     isnull(convert(CHAR(18),round(ah_prom_disponible,2)),0.00),
     isnull(convert(CHAR(18),round(ah_promedio1,2)),0.00),  
     isnull(convert(CHAR(18),round(ah_promedio2,2)),0.00),  
     isnull(convert(CHAR(18),round(ah_promedio3,2)),0.00),  
     isnull(convert(CHAR(18),round(ah_promedio4,2)),0.00),  
     isnull(convert(CHAR(18),round(ah_promedio5,2)),0.00),  
     isnull(convert(CHAR(18),round(ah_promedio6,2)),0.00),  
     isnull(convert(CHAR(18),round(ah_monto_bloq,2)),0.00),
     isnull((SELECT convert(CHAR(18),round(isnull(hb_valor,0.00),2))  
               FROM (SELECT ROW_NUMBER() OVER (ORDER BY hb_secuencial desc) AS orden, hb_fecha, hb_secuencial, hb_valor,hb_cuenta
                       FROM ah_his_bloqueo
                      where hb_accion = 'B'
                        AND hb_levantado = 'NO'
                        AND hb_cuenta = c.ah_cuenta) T1
              WHERE orden = 1),0.00),
     isnull(convert(CHAR(18),(SELECT hb_fecha 
                                FROM (SELECT ROW_NUMBER() OVER (ORDER BY hb_secuencial desc) AS orden, hb_fecha, hb_secuencial, hb_valor,hb_cuenta
                                        FROM ah_his_bloqueo
                                       where hb_accion = 'B'
                                         AND hb_levantado = 'NO'
                                         AND hb_cuenta = c.ah_cuenta) T1
                               WHERE orden = 1 ),101),''),
     isnull((SELECT convert(CHAR(18),round(isnull(hb_valor,0.00),2))  
               FROM (SELECT ROW_NUMBER() OVER (ORDER BY hb_secuencial desc) AS orden, hb_fecha, hb_secuencial, hb_valor,hb_cuenta
                       FROM ah_his_bloqueo
                      where hb_accion = 'B'
                        AND hb_levantado = 'NO'
                        AND hb_cuenta = c.ah_cuenta) T2
                      WHERE orden = 2 ),0.00),                         
     isnull(convert(CHAR(18),(SELECT hb_fecha 
                                FROM (SELECT ROW_NUMBER() OVER (ORDER BY hb_secuencial desc) AS orden, hb_fecha, hb_secuencial, hb_valor,hb_cuenta
                                        FROM ah_his_bloqueo
                                       where hb_accion = 'B'
                                         AND hb_levantado = 'NO'
                                         AND hb_cuenta = c.ah_cuenta) T2
                               WHERE orden = 2 ),101),''),                         
     isnull((SELECT convert(CHAR(18),round(isnull(hb_valor,0.00),2))  
               FROM (SELECT ROW_NUMBER() OVER (ORDER BY hb_secuencial desc) AS orden, hb_fecha, hb_secuencial, hb_valor,hb_cuenta
                       FROM ah_his_bloqueo
                      where hb_accion = 'B'
                        AND hb_levantado = 'NO'
                        AND hb_cuenta = c.ah_cuenta) T3
              WHERE orden = 3 ),0.00),
                         
     isnull(convert(CHAR(18),(SELECT hb_fecha 
                                FROM (SELECT ROW_NUMBER() OVER (ORDER BY hb_secuencial desc) AS orden, hb_fecha, hb_secuencial, hb_valor,hb_cuenta
                                        FROM ah_his_bloqueo
                                       where hb_accion = 'B'
                                         AND hb_levantado = 'NO'
                                         AND hb_cuenta = c.ah_cuenta) T3
                               WHERE orden = 3 ),101),''),
     isnull(substring((SELECT  DISTINCT CASE 
                                       WHEN cb_tipo_bloqueo = '1' THEN 'S'
                                       ELSE 'N'
                                       END
                                       FROM ah_ctabloqueada
                                       WHERE cb_cuenta = c.ah_cuenta),1,1),'N'),
     isnull(convert(CHAR(18),(SELECT max(cb_fecha) FROM ah_ctabloqueada
                                      WHERE cb_cuenta = c.ah_cuenta
                                      AND cb_tipo_bloqueo  = '1'),101),''),                     
     isnull(substring((SELECT DISTINCT CASE 
                                      WHEN cb_tipo_bloqueo = '2' THEN 'S'
                                      ELSE 'N'
                                      END
                                      FROM ah_ctabloqueada
                                      WHERE cb_cuenta = c.ah_cuenta),1,1),'N'),
     isnull(convert(CHAR(18),(SELECT max(cb_fecha)
                                      FROM ah_ctabloqueada
                                      WHERE cb_cuenta = c.ah_cuenta
                                      AND cb_tipo_bloqueo  = '2'),101),''),
     isnull(substring((SELECT DISTINCT CASE 
                                      WHEN cb_tipo_bloqueo = '3' THEN 'S'
                                      ELSE 'N'
                                      END
                                      FROM ah_ctabloqueada
                                      WHERE cb_cuenta = c.ah_cuenta),1,1),'N'),
     isnull(convert(CHAR(19),(SELECT max(cb_fecha) FROM ah_ctabloqueada
                                      WHERE cb_cuenta = c.ah_cuenta
                                      AND cb_tipo_bloqueo  = '3'),101),''),
     convert(CHAR(6),ah_estado),
     isnull((SELECT valor from cobis..cl_catalogo, cobis..cl_tabla
                          where cl_catalogo.tabla  = cl_tabla.codigo 
                          AND   cl_tabla.tabla     = 'ah_estado_cta'
                          and   cl_catalogo.estado = 'V' 
                          AND   cl_catalogo.codigo = convert(CHAR(10),c.ah_estado)),''),
     isnull(convert(CHAR(14),ah_fecha_aper,101),''),
     isnull(convert(CHAR(17),(SELECT max(hi_fecha) FROM ah_his_inmovilizadas WHERE hi_cuenta = c.ah_cta_banco),101),''),
     isnull(convert(CHAR(12),(SELECT max(hc_fecha) FROM ah_his_cierre WHERE hc_cuenta = c.ah_cuenta),101),''),
     isnull(convert(CHAR(18),(SELECT max(fecha_reactiva) FROM #ctas_reactivadas where  cuenta_react = c.ah_cta_banco),101),'')
    
     FROM #ah_cuenta_rpt c                    
     where c.ah_cuenta > 0
     AND c.ah_prod_banc <> @w_prod_bancario
     ORDER BY c.ah_prod_banc,c.ah_oficina
  
  
      IF @@ERROR <> 0
      BEGIN
      select
      @w_msg = 'ERROR INSERTAR REGISTRO EN LA TABLA ah_report_ctas'
       goto ERROR
      END      
  end
  else
  begin
  INSERT INTO ah_report_ctas
  SELECT
     'FECHA',
	 'CUENTA',
     'CTA.BANCO',
     'OFICINA',
     'DESC.OFICINA',
     'MONEDA',
     'DESC.MONEDA',
     'PROD.BANCARIO',
     'DESC.PROD.BANCARIO',
     'ORIGEN',
     'DESC.ORIGEN',                        
     'CATEGORIA',
     'DESC.CATEGORIA',                        
     'TITULARIDAD',
     'DESC.TITULARIDAD',
     'OFICIAL',
     'DESC.OFICIAL',
     'CLIENTE',
     'NOM.CLIENTE',
     'CURP/RFC',                                                                        
     'DIRECCION',
     'FECHA ULT.MOVIM.',
     'FECHA PROX.CAPIT.',
     'NUM.SOLICITUD',
     'PLAZO',  
     'PERFIL',
     'CTA.BANCO MIGRADA',
     'SALDO DISPONIBLE',
     'SALDO 12H',
     'SALDO 24H',
     'SALDO CONTABLE',
     'SALDO INTERES',
     'TASA',
     'CREDITOS',
     'DEBITOS',
     'NUM.DEB.MES',
     'NUM.CRED.MES',
     'SALDO PROM.DISP.',
     'SALDO PROM.1',
     'SALDO PROM.2',
     'SALDO PROM.3',
     'SALDO PROM.4',
     'SALDO PROM.5',
     'SALDO PROM.6',
     'MONTO BLOQUEO',
     'BLOQUEO VALOR 1',
     'FECHA BLOQ.VALOR 1',
     'BLOQUEO VALOR 2',                         
     'FECHA BLOQ.VALOR 2',                         
     'BLOQUEO VALOR 3',
     'FECHA BLOQ.VALOR 3',
     'BLOQ.CREDITO',
     'FECHA ULT.BLOQ.CREDITO',                     
     'BLOQ.DEBITO',
     'FECHA ULT.BLOQ.DEBITO',
     'BLOQ.CRED.DEB',
     'FECHA ULT.BLOQ.CRED.DEB',
     'ESTADO',
     'DESC.ESTADO',
     'FECHA APERTURA',
     'FECHA INACTIVACION',
     'FECHA CIERRE',
     'FECHA REACTIVACION'

  IF @@ERROR <> 0
  BEGIN
  select
  @w_msg = 'ERROR INSERTAR CABECERA EN LA TABLA ah_report_ctas'
   goto ERROR
  END        
  
  INSERT INTO ah_report_ctas
  SELECT
     isnull(convert(CHAR(14),@w_fecha,101),''),
	 convert(CHAR(12),ah_cuenta),
     convert(CHAR(20),ah_cta_banco),
     convert(CHAR(7), ah_oficina),
     convert(CHAR(40),substring((SELECT of_nombre from  cobis..cl_oficina WHERE of_oficina = c.ah_oficina),1,40)),  
     convert(CHAR(6),ah_moneda),
     substring((SELECT convert(CHAR(35),valor) from cobis..cl_catalogo, cobis..cl_tabla
                   where cl_catalogo.tabla  = cl_tabla.codigo 
                   AND   cl_tabla.tabla     = 'cl_moneda'
                   and   cl_catalogo.estado = 'V' 
                   AND   cl_catalogo.codigo = convert(VARCHAR(10),c.ah_moneda)),1,64),
     convert(CHAR(13),ah_prod_banc),
     (SELECT convert(CHAR(50),pb_descripcion) FROM cob_remesas..pe_pro_bancario WHERE pb_pro_bancario = c.ah_prod_banc),
     convert(CHAR(6),ah_origen),
     isnull((SELECT convert(CHAR(50),valor) from cobis..cl_catalogo , cobis..cl_tabla 
                          where cl_catalogo.tabla  = cl_tabla.codigo 
                          AND   cl_tabla.tabla     = 'ah_tipocta'
                          and   cl_catalogo.estado = 'V'
                          AND   cl_catalogo.codigo = c.ah_origen),''),                        
     convert(CHAR(9),ah_categoria),
     isnull((SELECT convert(CHAR(50),valor) from cobis..cl_catalogo , cobis..cl_tabla 
                          where cl_catalogo.tabla  = cl_tabla.codigo 
                          AND   cl_tabla.tabla     = 'pe_categoria'
                          and   cl_catalogo.estado = 'V'
                          AND   cl_catalogo.codigo = c.ah_categoria),''),                        
     convert(CHAR(11),ah_ctitularidad),
     isnull((SELECT convert(CHAR(50),valor) from cobis..cl_catalogo , cobis..cl_tabla 
                          where cl_catalogo.tabla  = cl_tabla.codigo 
                          AND   cl_tabla.tabla     = 're_titularidad'
                          and   cl_catalogo.estado = 'V'
                          AND   cl_catalogo.codigo = c.ah_ctitularidad),''),
     convert(CHAR(7),ah_oficial),
     (SELECT convert(CHAR(64),fu_nombre) FROM cobis..cc_oficial, cobis..cl_funcionario
                       WHERE oc_funcionario = fu_funcionario
                       AND   oc_oficial  = c.ah_oficial),
     convert(CHAR(10),ah_cliente),
     convert(CHAR(80),ah_nombre) ,
     convert(CHAR(20),ah_ced_ruc),                                                                        
     convert(CHAR(64),ah_descripcion_dv),
     isnull(convert(CHAR(16),ah_fecha_ult_mov,101),''),
     isnull(convert(CHAR(17),ah_fecha_prx_capita,101),''),
     convert(CHAR(13),ah_numsol),
     isnull(convert(CHAR(6),(SELECT csp_plazo FROM #ah_plazo_cta_sin_rep WHERE csp_cta_banco = c.ah_cta_banco)),0),  
     convert(CHAR(10),'     ') ,--perfil
     isnull(convert(CHAR(18),(SELECT ca_cta_banco_mig FROM ah_cuenta_aux WHERE ca_cta_banco = c.ah_cta_banco)),''),
     isnull(convert(CHAR(18),round(ah_disponible,2)), 0.00),
     isnull(convert(CHAR(18),round(ah_12h,2)) , 0.00),  
     isnull(convert(CHAR(18),round(ah_24h,2)), 0.00),
     isnull(convert(CHAR(18),round(ah_12h +  ah_24h  +  ah_48h + ah_disponible,2)) , 0.00),
     isnull(convert(CHAR(18),round(ah_saldo_interes,2)),0.00),
     isnull(convert(CHAR(6),round(ah_tasa_hoy,2)),0.00), 
     isnull(convert(CHAR(18),round(ah_creditos_hoy,2)),0.00),  
     isnull(convert(CHAR(18),round(ah_debitos_hoy,2)),0.00), 
     isnull(convert(CHAR(11),ah_num_deb_mes),0),    
     isnull(convert(CHAR(12),ah_num_cred_mes),0),
     isnull(convert(CHAR(18),round(ah_prom_disponible,2)),0.00),
     isnull(convert(CHAR(18),round(ah_promedio1,2)),0.00),  
     isnull(convert(CHAR(18),round(ah_promedio2,2)),0.00),  
     isnull(convert(CHAR(18),round(ah_promedio3,2)),0.00),  
     isnull(convert(CHAR(18),round(ah_promedio4,2)),0.00),  
     isnull(convert(CHAR(18),round(ah_promedio5,2)),0.00),  
     isnull(convert(CHAR(18),round(ah_promedio6,2)),0.00),  
     isnull(convert(CHAR(18),round(ah_monto_bloq,2)),0.00),
     isnull((SELECT convert(CHAR(18),round(isnull(hb_valor,0.00),2))  
               FROM (SELECT ROW_NUMBER() OVER (ORDER BY hb_secuencial desc) AS orden, hb_fecha, hb_secuencial, hb_valor,hb_cuenta
                       FROM ah_his_bloqueo
                      where hb_accion = 'B'
                        AND hb_levantado = 'NO'
                        AND hb_cuenta = c.ah_cuenta) T1
              WHERE orden = 1),0.00),
     isnull(convert(CHAR(18),(SELECT hb_fecha 
                                FROM (SELECT ROW_NUMBER() OVER (ORDER BY hb_secuencial desc) AS orden, hb_fecha, hb_secuencial, hb_valor,hb_cuenta
                                        FROM ah_his_bloqueo
                                       where hb_accion = 'B'
                                         AND hb_levantado = 'NO'
                                         AND hb_cuenta = c.ah_cuenta) T1
                               WHERE orden = 1 ),101),''),
     isnull((SELECT convert(CHAR(18),round(isnull(hb_valor,0.00),2))  
               FROM (SELECT ROW_NUMBER() OVER (ORDER BY hb_secuencial desc) AS orden, hb_fecha, hb_secuencial, hb_valor,hb_cuenta
                       FROM ah_his_bloqueo
                      where hb_accion = 'B'
                        AND hb_levantado = 'NO'
                        AND hb_cuenta = c.ah_cuenta) T2
              WHERE orden = 2 ),0.00),                         
     isnull(convert(CHAR(18),(SELECT hb_fecha 
                                FROM (SELECT ROW_NUMBER() OVER (ORDER BY hb_secuencial desc) AS orden, hb_fecha, hb_secuencial, hb_valor,hb_cuenta
                                        FROM ah_his_bloqueo
                                       where hb_accion = 'B'
                                         AND hb_levantado = 'NO'
                                         AND hb_cuenta = c.ah_cuenta) T2
                               WHERE orden = 2 ),101),''),                         
     isnull((SELECT convert(CHAR(18),round(isnull(hb_valor,0.00),2))  
               FROM (SELECT ROW_NUMBER() OVER (ORDER BY hb_secuencial desc) AS orden, hb_fecha, hb_secuencial, hb_valor,hb_cuenta
                       FROM ah_his_bloqueo
                      where hb_accion = 'B'
                        AND hb_levantado = 'NO'
                        AND hb_cuenta = c.ah_cuenta) T3
              WHERE orden = 3 ),0.00),
                         
     isnull(convert(CHAR(18),(SELECT hb_fecha 
                                FROM (SELECT ROW_NUMBER() OVER (ORDER BY hb_secuencial desc) AS orden, hb_fecha, hb_secuencial, hb_valor,hb_cuenta
                                        FROM ah_his_bloqueo
                                       where hb_accion = 'B'
                                         AND hb_levantado = 'NO'
                                         AND hb_cuenta = c.ah_cuenta) T3
                               WHERE orden = 3 ),101),''),
     isnull(substring((SELECT  DISTINCT CASE 
                                       WHEN cb_tipo_bloqueo = '1' THEN 'S'
                                       ELSE 'N'
                                       END
                                       FROM ah_ctabloqueada
                                       WHERE cb_cuenta = c.ah_cuenta),1,1),'N'),
     isnull(convert(CHAR(18),(SELECT max(cb_fecha) FROM ah_ctabloqueada
                                      WHERE cb_cuenta = c.ah_cuenta
                                      AND cb_tipo_bloqueo  = '1'),101),''),                     
     isnull(substring((SELECT DISTINCT CASE 
                                      WHEN cb_tipo_bloqueo = '2' THEN 'S'
                                      ELSE 'N'
                                      END
                                      FROM ah_ctabloqueada
                                      WHERE cb_cuenta = c.ah_cuenta),1,1),'N'),
     isnull(convert(CHAR(18),(SELECT max(cb_fecha)
                                      FROM ah_ctabloqueada
                                      WHERE cb_cuenta = c.ah_cuenta
                                      AND cb_tipo_bloqueo  = '2'),101),''),
     isnull(substring((SELECT DISTINCT CASE 
                                      WHEN cb_tipo_bloqueo = '3' THEN 'S'
                                      ELSE 'N'
                                      END
                                      FROM ah_ctabloqueada
                                      WHERE cb_cuenta = c.ah_cuenta),1,1),'N'),
     isnull(convert(CHAR(19),(SELECT max(cb_fecha) FROM ah_ctabloqueada
                                      WHERE cb_cuenta = c.ah_cuenta
                                      AND cb_tipo_bloqueo  = '3'),101),''),
     convert(CHAR(6),ah_estado),
     isnull((SELECT valor from cobis..cl_catalogo, cobis..cl_tabla
                          where cl_catalogo.tabla  = cl_tabla.codigo 
                          AND   cl_tabla.tabla     = 'ah_estado_cta'
                          and   cl_catalogo.estado = 'V' 
                          AND   cl_catalogo.codigo = convert(CHAR(10),c.ah_estado)),''),
     isnull(convert(CHAR(14),ah_fecha_aper,101),''),
     isnull(convert(CHAR(17),(SELECT max(hi_fecha) FROM ah_his_inmovilizadas WHERE hi_cuenta = c.ah_cta_banco),101),''),
     isnull(convert(CHAR(12),(SELECT max(hc_fecha) FROM ah_his_cierre WHERE hc_cuenta = c.ah_cuenta),101),''),
     isnull(convert(CHAR(18),(SELECT max(fecha_reactiva) FROM #ctas_reactivadas where  cuenta_react = c.ah_cta_banco),101),'')
    
     FROM #ah_cuenta_rpt c                    
     where c.ah_cuenta > 0
     ORDER BY c.ah_prod_banc,c.ah_oficina
     
      IF @@ERROR <> 0
      BEGIN
      select
      @w_msg = 'ERROR INSERTAR REGISTRO EN LA TABLA ah_report_ctas'
       goto ERROR
      END 
     
 end

  -- Se valida de que hayan registros para poder generar BCP, del archivo de Extractos Masivos 
  select @w_tot_reg = count(1)
  from   cob_ahorros..ah_report_ctas

  if @w_tot_reg > 1
  begin
    /* Se Realiza BCP */
    
    select @w_path_sapp = pa_char 
    from cobis..cl_parametro 
    where pa_producto = 'ADM' 
    and pa_nemonico = 'S_APP'
    
    if @w_path_sapp is null
    begin
          select
            @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
          goto ERROR
    end
        
     
   select @w_path = ba_path_destino
    from   cobis..ba_batch
    where  ba_batch = 4389 --OJO CAMBIAR CUANDO SE GENERE LA SARTA
    
        if @w_path is null
        begin
          select
            @w_msg = 'NO EXISTE PARAMETRO ba_path_destino'
          goto ERROR
        end
    
    select @w_archivo = 'ah_report_ctas_' + @w_nombre_banco + '_' + convert(varchar, @i_fecha, 112) + '.txt',
           @w_errores = 'err_ah_report_ctas_' + @w_nombre_banco + '_' + convert(varchar, @i_fecha, 112) + '.txt'

    select @w_archivo_bcp = @w_path + @w_archivo,
               @w_errores = @w_path + @w_errores

   -- select @w_tab = ''

    select @w_comando  = @w_path_sapp + 's_app' + ' bcp -auto -login cob_ahorros..ah_report_ctas out ' 
                     + @w_path + @w_archivo +  ' -b5000 -c'
                     + ' -config ' + @w_path_sapp + 's_app.ini'

    -- select @w_comando

     execute @w_error = master..xp_cmdshell @w_comando
    

    if @w_error <> 0
    begin
      select
        @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_archivo + ' ' + convert( varchar , @w_error)
      goto ERROR
    end

  end
  else
  begin
    select
      @w_msg = 'No Existen datos Para Generar Archivo de Cuentas'
    goto ERROR
  end


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

