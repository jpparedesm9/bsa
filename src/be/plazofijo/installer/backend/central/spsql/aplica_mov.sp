/*LIM 23/ENE/2006 Creacion Tablas Temporales*/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

/*
drop table #ca_operacion_aux
drop table #ca_abonos
drop table #interes_proyectado
*/

create table #ca_operacion_aux (
op_operacion          int,
op_banco              varchar(24),
op_toperacion         varchar(10),
op_moneda             tinyint,
op_oficina            int,
op_fecha_ult_proceso  datetime ,
op_dias_anio          int,
op_estado             int,
op_sector             varchar(10),
op_cliente            int,
op_fecha_liq          datetime,
op_fecha_ini          datetime ,
op_cuota_menor        char(1),
op_tipo               char(1),
op_saldo              money,       -- LuisG 04.06.2001
op_fecha_fin          datetime,    -- LuisG 04.06.2001
op_base_calculo       char(1) ,    --lre version estandar 05/06/2001
op_periodo_int        smallint,    --lre version estandar 05/06/2001
op_tdividendo         varchar(10)  --lre version estandar 05/06/2001
)

create table #ca_abonos (
ab_secuencial_ing    int,
ab_dias_retencion    int          null,
ab_estado            varchar(10)  null,
ab_cuota_completa    char(1)      null,
)
/* ALMACENA LAS DIFERENCIAS DE INTERES EN LOS REAJUSTES */
create table #interes_proyectado (
concepto        varchar(10),
valor           money
)
go
/************************************************************************/
/*      Archivo:                aplicmov.sp                             */
/*      Stored procedure:       sp_aplica_mov                           */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este script crea el procedimiento para la aplicacion de los     */
/*      movimientos monetarios, en el parametro i_tipo se le asigna     */
/*      el tipo de movimiento 'N' = normal; 'R' = reversion y los       */
/*      otros parametros necesarios son para identificar el movimiento  */
/*      monetario.                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      23-Nov-94  Juan Lam           Creacion                          */
/*      20-Oct-05  Luis Im            Grabacion fecha valor en movmonet */
/*     21-Feb-2007 H.Ayarza     Aumento @i_ref_opc varchar(34).         */
/*      12/Jul/2009  Y.Martinez  NYM DPF00015 ICA                       */
/*  20-ABR-2010     RICADO MARTINEZ Interfase de plazo fijo con ahorros */
/*      05/12/2016  A.Zuluaga         Desacople                         */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select name  from sysobjects where
            name = 'sp_aplica_mov' and type = 'P')
   drop proc sp_aplica_mov
go

create proc sp_aplica_mov (
   @s_ssn                  int             = 0,
   @s_rol                  smallint        = 1,
   @s_user                 login           = NULL,
   @s_ofi                  smallint        = NULL,
   @s_date                 datetime        = NULL,
   @s_srv                  varchar(30)     = NULL,
   @s_org                  char(1)         = NULL,
   @s_term                 varchar(30)     = NULL,
   @s_sesn                 int             = NULL,
   @s_lsrv                 varchar(30)     = null,
   @s_ssn_branch           int             = null,          --LIM 04/OCT/2005
   @t_corr                 char(1)         = 'N',
   @t_ssn_corr             int             = null,
   @t_filial               smallint        = 1,
   @t_file                 varchar(10)     = NULL,
   @t_from                 varchar(32)     = NULL,
   @t_debug                char(1)         = 'N',
   @t_trn                  int,
   @i_fecha_proceso        datetime        = NULL,
   @i_tipo                 char(1)         = 'N',               -- N Normal R Reverso
   @i_en_linea             char(1)         = 'S',
   @i_trn                  int             = null,
   @i_operacionpf          int,
   @i_secuencia            int,
   @i_sub_secuencia        tinyint,
   @i_retiene_capital      char(1)         = 'N',
   @i_empresa              tinyint         = 1,
   @i_emite_orden        char(1)           = 'S',
   @i_transferencia        char(1)         = 'N',
   @i_fecha_valor          datetime        = NULL,
   @i_refconcep            varchar(255)    = NULL,
   @i_tr_cod_transf        int             = NULL,
   @i_dirord               tinyint         = NULL,         -- Direccion del ordenante
   @i_tdirben              char(1)         = NULL,         -- Direccion ABA / 'S' Direccion SWIFT. MANDATORIO
   @i_nomben               descripcion     = NULL,         -- Nombre del Banco Beneficiario.
   @i_conben               varchar(3)      = NULL,         -- Continente del beneficiario
   @i_paiben               smallint        = NULL,         -- Pais del beneficiario
   @i_ciuben               smallint        = NULL,         -- Ciudad del beneficiario
   @i_tdirint              char(1)         = NULL,         -- Direccion ABA / 'S' Direccion SWIFT del Banco intemediario
   @i_nomint               descripcion     = NULL,         -- Nombre del Banco intermediario.
   @i_dp_secuencia         int             = NULL,         -- Campo pf_det_pago..dp_secuencia de registro con nueva forma de pago
   @i_dp_sec_orig          int             = NULL,         -- Campo pf_det_pago..dp_secuencia del registro que origina nueva forma de pago
   @i_benefi               varchar(255)    = NULL,         -- Nombre del beneficiario
   @i_dirben               varchar(255)    = NULL,         -- Direccion del beneficiario
   @i_ref_opc              varchar(34)     = NULL,         -- Numero de cuenta del beneficiario
   @i_bcoben               smallint        = NULL,         -- Codigo del Banco Beneficiario
   @i_ofiben               smallint        = NULL,         -- Codigo de oficina del Banco beneficiario
   @i_bcoint               smallint        = NULL,         -- Codigo del Banco Intermediario
   @i_ofiint               smallint        = NULL,         -- Oficina del Banco Intermediario
   @i_instruccion          varchar(255)    = NULL,         -- Instruccion de pago
   @i_fecha_inicial        datetime        = NULL,         --LIM 17/OCT/2005
   @i_fecha_final          datetime        = NULL,         --LIM 17/OCT/2005
   @i_impuesto             money           = NULL,         -- GAL 22/AGO/2009 - CSQL
   @i_capital              char(1)         = NULL,         -- GAL 22/AGO/2009 - CSQL
   @i_normal               char(1)         = NULL,         -- GAL 22/AGO/2009 - CSQL
   @i_mm_secuencial        int             = NULL,         -- GAL 22/AGO/2009 - CSQL
   @i_op_num_banco         cuenta          = NULL,         -- GAL 22/AGO/2009 - CSQL
   @i_reversobanco         char(1)         = NULL,         -- GAL 22/AGO/2009 - CSQL
   @i_alt                  int             = NULL,         -- GAL 22/AGO/2009 - CSQL
   @o_secuencial           int             = NULL out
)
as
declare @w_sp_name                   descripcion,
        @w_return                    int,
        @w_empresa                   tinyint,
        @w_filial                    tinyint,
        @w_area_des                  int,
        @w_ofi_des                   int,
        @w_ofi_org                   int,
        @w_ofi_ing                   int,
        @w_ofi                       smallint,
        @w_ofi1                      smallint,
        @w_ind                       tinyint,
        @w_afectacion                char(1),
        @w_fecha_mov                 datetime,
        @w_coti                      money,
        @w_tran                      int,
        @w_error                     int,
       /** VARIABLES PARA PF_OPERACION **/
        @w_cuenta                    cuenta,
        @w_oficina                   smallint,
        @w_op_monto                  money,
        @w_op_tasa                   float,
        @w_save_tran                 varchar(20),

       /** VARIABLES PARA PF_TRAN **/
        @w_tr_afectacion             tinyint,
        @w_tr_causa                  varchar(30),
        @w_tcorr                     char(1),
       /** VARIABLES PARA PF_MOV_MONET **/
        @w_mm_fecha_aplicacion       datetime,
        @w_fecha_aplicacion          datetime,
        @w_mm_secuencial             int,
        @w_mm_moneda                 smallint,
        @w_moneda_posicion           smallint,
        @w_op_moneda                 smallint,
        @w_op_ente                   int,
        @w_op_descripcion            varchar(255),
        @w_sec                       int,
        @w_mm_beneficiario           int,
        @w_mm_tipo_cliente           char(1),
        @w_beneficiario              varchar(255), --gap DP00008 se cambia la longitud para SB
        @w_mm_producto               catalogo,
        @w_cheque_bcr                catalogo,
        @w_cheque_pbf                catalogo,
        @w_cheque_ger                catalogo,
        @w_cheque_pro                catalogo,
        @w_cheque_ibarra             catalogo,
        @w_efectivo                  catalogo,
        @w_cheque_remesa             catalogo,
        @w_renovacion                catalogo,
        @w_int_cex                   catalogo,
        @w_mm_tipo                   char(1),
        @w_mm_cuenta                 cuenta,
        @w_mm_valor                  money,
        @w_mm_valor_ext              money,
        @w_mm_impuesto               money,
        @w_mm_impuesto_capital_me    money,
        @w_mm_estado                 catalogo,
        @w_mm_autorizado             char(1),
        @w_mm_cotizacion             money,
        @w_mm_tipo_cotiza            char(1),
        @w_producto                  tinyint,
        @w_msg                       varchar(50),
        @w_mm_valor_completo         money,
        @w_ec_valor                  money,
        @w_plfijo                    char(1),
        @w_ctas_concepto             varchar(64),
        @w_moneda_base               tinyint,
        @w_codigo_alterno            int,
        @w_mm_tran                   int,               --gap DP00008
        @w_mm_oficina                int,               --gap DP00008 oficina para pago cheque
        @w_prod_cobis                tinyint,           --gap DP00008
        @w_mensaje                   mensaje,
        @w_canal                     tinyint,
        @w_en_direccion              int,
        @w_di_descripcion            varchar(264),
        @w_cedruc                    varchar(30),
        @w_fecha_pg_int              datetime, --LIM 17/OCT/2005
        @w_fecha_ult_pg_int          datetime, --LIM 17/OCT/2005
        @w_fecha_inicial             varchar(10),   --LIM 17/OCT/2005
        @w_fecha_final               varchar(10),    --LIM 17/OCT/2005
        @w_fecha_ult_pg_int_ant      datetime,     --LIM 17/OCT/2005
        @w_op_num_banco              cuenta,
        @w_fecha_movimiento          datetime,
        @w_estcex                    char(1),
        @w_opecex                    varchar(24),
        @w_ruta_trans                varchar(10),      --+-+
        @w_mm_tipo_cuenta_ach        char(1),    --+-+
        @w_mm_cod_banco_ach          smallint,      --+-+
        @w_op_telefono               varchar(16),      --+-+
        @w_ssn_trace                 varchar(15),      --+-+
        @w_concepto                  varchar(20),      --+-+
        @w_fecha_aplica              varchar(10),
        @w_mm_ica                    money,       -- NYM DPF00015 ICA
        @w_mm_subtipo_ins            int,
        @w_ec_numero                 int,
        @w_ssn_central               int,
        @w_snn_reverso               int,
        @w_snn                       int,
        @w_inmovi                    varchar(2),
        @w_activar_cta               varchar(2),
        @w_num_tit                   smallint,
        @w_caja                      char(1) ,
        @w_fecha_caja                datetime,
        @w_titularidad_prods         char(1),
        -- REQ 306: VALIDACION MONTO DEPOSITO INICIAL
        @w_deposito_min              money,
        @w_tipo_def                  char(1),
        @w_rolente                   char(1),
        @w_categoria                 char(1),
        @w_estado                    char(1),
        @w_tipocta                   char(1),
        @w_prod_banc                 smallint,
        @w_moneda                    tinyint,
        @w_existe_relacion_sba_cex   int


-------------------------------
-- Inicializacion de variables
-------------------------------
select   @i_tipo = isnull(@i_tipo, 'N'),
         @w_sp_name  = 'sp_aplica_mov',
         @w_empresa  = 1,
         @w_filial   = 1,
         @w_area_des = 6100,
         @w_fecha_movimiento = @s_date

--I.CVA Ago-18-06 Para disminucion bonos
if @i_fecha_proceso is null
   select @i_fecha_proceso = @s_date

select @w_fecha_aplica = convert(varchar(10),@i_fecha_proceso,103)

--I. CVA Jul-25-06
if @s_sesn is null
   select @s_sesn = @s_ssn

--F. CVA Jul-25-06

--------------------------------------
-- Lectura de valores de pf_operacion
--------------------------------------
if @i_tipo <> 'N' and @i_tipo <> 'R' and @i_tipo <> 'C'
begin
   return 141112
end

select @w_moneda_base = em_moneda_base
  from cob_conta..cb_empresa
 where em_empresa = @i_empresa

if @@rowcount = 0
begin
   select @w_error = 601018
   goto ERROR
end

----------------------------------------------------
-- Lectura y creacion del concepto de la aplicacion
----------------------------------------------------
select @w_ctas_concepto        = op_num_banco,
       @w_op_moneda            = op_moneda,
       @w_op_ente              = op_ente,
       @w_op_telefono          = op_telefono,         --+-+
       @w_op_descripcion       = op_descripcion,
       @w_fecha_pg_int         = op_fecha_pg_int,        --LIM 17/OCT/2005
       @w_fecha_ult_pg_int     = op_fecha_ult_pg_int,    --LIM 17/OCT/2005
       @w_fecha_ult_pg_int_ant = op_fecha_ult_pago_int_ant,    --LIM 17/OCT/2005
       @w_op_monto             = op_monto,
       @w_op_tasa              = op_tasa
  from pf_operacion
 where op_operacion = @i_operacionpf

select @w_op_num_banco = @w_ctas_concepto --CVA Oct-21-05


--------------------------------------
-- Lectura de valores de pf_mov_monet
--------------------------------------
select @w_mm_fecha_aplicacion        = mm_fecha_aplicacion,
       @w_mm_secuencial              = mm_secuencial,
       @w_mm_valor                   = mm_valor,
       @w_mm_valor_ext               = mm_valor_ext,
       @w_mm_producto                = mm_producto,
       @w_mm_cuenta                  = mm_cuenta,
       @w_mm_beneficiario            = isnull(mm_beneficiario,0),
       @w_mm_tipo                    = mm_tipo,
       @w_mm_estado                  = mm_estado,
       @w_mm_moneda                  = mm_moneda,
       @w_mm_ica                     = mm_ica,       -- NYM DPF00015 ICA
       @w_mm_impuesto                = mm_impuesto,
       @w_mm_impuesto_capital_me     = mm_impuesto_capital_me,
       @w_mm_tipo_cliente            = mm_tipo_cliente,
       @w_mm_autorizado              = mm_autorizado,
       @w_mm_cotizacion              = mm_cotizacion,
       @w_mm_tipo_cotiza             = mm_tipo_cotiza,
       @w_mm_cod_banco_ach           = mm_cod_banco_ach,   --+-+
       @w_mm_tipo_cuenta_ach         = mm_tipo_cuenta_ach, --+-+
       @w_mm_tran                    = mm_tran,    --gap DP00008
       @w_mm_oficina                 = mm_oficina, --gap DP00008 oficina para cheque es dif. de null
       @w_mm_subtipo_ins             = mm_subtipo_ins,
       @w_ssn_central                = mm_snn_central       
  from pf_mov_monet
 where mm_operacion     = @i_operacionpf
   and mm_tran          = @t_trn
   and mm_secuencia     = @i_secuencia
   and mm_sub_secuencia = @i_sub_secuencia
if @@rowcount = 0
begin
   select @w_mensaje = '[sp_aplica_mov] No existe movimiento monetario'
   if @i_en_linea = 'S'
      return 141075
   else
   begin
      select @w_mensaje = '[sp_aplica_mov] No existe movimiento'
      select @w_error = 141075
      goto ERROR
   end
end

   -------------------------------
   -- Pago periodico de intereses
   -------------------------------
   if @t_trn = 14905
   begin
      if @w_mm_oficina is not null
      begin
         select @w_oficina = @w_mm_oficina
    select @s_ofi     = @w_oficina --I. CVA May-05-06
      end
      else
      begin
        select @w_oficina = op_oficina from pf_operacion where op_operacion = @i_operacionpf
    select @s_ofi     = @w_oficina --I. CVA May-05-06
      end
   end
   else
      if @w_mm_oficina is not null
      begin
         select @w_oficina = @w_mm_oficina
    if @i_en_linea = 'N' --I. CVA May-05-06 solo para batch
      select @s_ofi     = @w_oficina --I. CVA May-05-06
      end
      else
      begin
        select @w_oficina = @s_ofi
   if @i_en_linea = 'N'  --I. CVA May-05-06 solo para batch
      select @s_ofi     = @w_oficina --I. CVA May-05-06
      end

  --print 'Transaccion %1!, @s_ofi %2!, @w_oficina %3!', @t_trn, @s_ofi, @w_oficina


if @i_tipo = 'R'
begin
   if @t_trn = 14904
   begin
      if @w_mm_tipo = 'B' --Ingresos al Banco
         select @w_ctas_concepto = @w_ctas_concepto + '-' + 'REVERSO INCREMENTO RENOVACION'
      else
      begin
         if @w_mm_tipo = 'C' --Ingresos al cliente
            select @w_ctas_concepto = @w_ctas_concepto + '-' + 'REVERSO DISMINUCION RENOVACION'
         else
            select @w_ctas_concepto = @w_ctas_concepto + '-' + rtrim(tn_descripcion)
            from cobis..cl_ttransaccion
            where tn_trn_code = @t_trn
      end
   end
   else
      if @t_trn = 14901 --LIM 31/DIC/2005
         select @w_ctas_concepto = @w_ctas_concepto + '-' + 'REVERSO DE ' + rtrim(tn_descripcion)
         from cobis..cl_ttransaccion
         where tn_trn_code = @t_trn
                else
         select @w_ctas_concepto = @w_ctas_concepto + '-' + rtrim(tn_descripcion)
         from cobis..cl_ttransaccion
         where tn_trn_code = @t_trn
end
else
begin
   if @t_trn = 14904
   begin
      if @w_mm_tipo = 'B' --Ingresos al Banco
         select @w_ctas_concepto = @w_ctas_concepto + '-' + ' INCREMENTO RENOVACION'
      else
      begin
         if @w_mm_tipo = 'C' --Ingresos al cliente
            select @w_ctas_concepto = @w_ctas_concepto + '-' + ' DISMINUCION RENOVACION'
         else
            select @w_ctas_concepto = @w_ctas_concepto + '-' + rtrim(tn_descripcion)
            from cobis..cl_ttransaccion
            where tn_trn_code = @t_trn
      end
   end
   else
      select @w_ctas_concepto = @w_ctas_concepto + '-' + rtrim(tn_descripcion) + '-' + 'FECHA' + convert(varchar(10),@w_fecha_aplica)
        from cobis..cl_ttransaccion
       where tn_trn_code = @t_trn
end

select @w_cheque_ger = pa_char
  from cobis..cl_parametro
 where pa_nemonico='NCHG'
   and pa_producto='PFI'
if @@error <> 0
begin
   select @w_mensaje = '[sp_aplica_mov] No existe parametro NCHG'
   select @w_error = 141111
   goto ERROR
end

select @w_cheque_pro = pa_char
  from cobis..cl_parametro
 where pa_nemonico='NCHP'
   and pa_producto='PFI'
if @@error <> 0
begin
   select @w_mensaje = '[sp_aplica_mov] No existe parametro NCHP'
   select @w_error = 141111
   goto ERROR
end

select @w_cheque_pbf = pa_char
  from cobis..cl_parametro
 where pa_nemonico='NPBF'
   and pa_producto='PFI'
if @@error <> 0
begin
   select @w_mensaje = '[sp_aplica_mov] No existe parametro NPBF'
  select @w_error = 141111
  goto ERROR
end

select @w_cheque_bcr = pa_char
  from cobis..cl_parametro
 where pa_nemonico='NCHB'
   and pa_producto='PFI'
if @@error <> 0
begin
   select @w_mensaje = '[sp_aplica_mov] No existe parametro NCHB'
   select @w_error = 141111
   goto ERROR
end

select @w_efectivo  = pa_char
  from cobis..cl_parametro
 where pa_nemonico='NEFE'
   and pa_producto='PFI'
if @@error <> 0
begin
   select @w_mensaje = '[sp_aplica_mov] No existe parametro NEFE'
   select @w_error = 141111
   goto ERROR
end

select @w_cheque_remesa  = pa_char
  from cobis..cl_parametro
 where pa_nemonico='NCHR'
   and pa_producto='PFI'
if @@error <> 0
begin
   select @w_mensaje = '[sp_aplica_mov] No existe parametro NCHR'
   select @w_error = 141111
   goto ERROR
end

select @w_int_cex  = pa_char
  from cobis..cl_parametro
 where pa_nemonico='CEX'
   and pa_producto='PFI'
if @@error <> 0
begin
   select @w_mensaje = '[sp_aplica_mov] No existe parametro CEX'
   select @w_error = 141111
   goto ERROR
end

select @w_producto = fp_producto
from pf_fpago
where fp_mnemonico = @w_mm_producto
--and fp_automatico = 'S'
and fp_estado = 'A'  -- MCA 12-Oct-99 solo las activas
if @@error <> 0
begin
   select @w_mensaje = '[sp_aplica_mov] No existe Producto cobis de mm_producto'
   select @w_error = 141111
   goto ERROR
end


------------------------------------------------------
-- Clientes externo en caso de cliente = 'E' DP00065
------------------------------------------------------
if @w_mm_tipo = 'C'
begin   /** OBTENGO LA DESCRIPCION DEL BENEFICIARIO **/
   --print '@w_mm_tipo_cliente %1!, @w_mm_beneficiario %2!', @w_mm_tipo_cliente, @w_mm_beneficiario

   if isnull(@w_mm_tipo_cliente, 'M') = 'M' and @w_mm_beneficiario is not null and @w_mm_beneficiario <> 0 --CVA OCT-12
   begin
      select @w_beneficiario =  @i_benefi, --en_nomlar,
           @w_en_direccion = en_direccion,
           @w_cedruc       = en_ced_ruc
      from cobis..cl_ente
      where en_ente = @w_mm_beneficiario
      if @@rowcount = 0
      begin
         select @w_mensaje = '[sp_aplica_mov] ERROR EN BUSQUEDA CLIENTE COBIS'
         if @i_en_linea = 'S'
            return  141044
         else
         begin
            select @w_mensaje = '[sp_aplica_mov] ERROR EN BUSQUEDA CLIENTE COBIS'
            select @w_error = 141044
            goto ERROR
         end
      end

   end
   else --if isnull(@w_mm_tipo_cliente, 'M') = 'M'
   begin
      if @w_mm_beneficiario is not null and @w_mm_beneficiario <> 0  --CVA Oct-12
      begin
         select   @w_beneficiario = @i_benefi, --ce_nombre,
            @w_cedruc       = ce_cedula
         from pf_cliente_externo
         where ce_secuencial = @w_mm_beneficiario
         if @@rowcount = 0
         begin
            select @w_mensaje = '[sp_aplica_mov] ERROR EN BUSQUEDA CLIENTE EXTERNO'
            if @i_en_linea = 'S'
               return 141044
            else
            begin
               select @w_mensaje = '[sp_aplica_mov] ERROR EN BUSQUEDA CLIENTE EXTERNO'
               select @w_error = 141044
               goto ERROR
            end
         end
      end
      if @w_mm_beneficiario = 0 --Por migracion
         select @w_beneficiario = dp_descripcion
         from pf_det_pago
         where dp_operacion = @i_operacionpf
         and dp_estado_xren = 'N'
         and dp_estado      = 'I'
   end
end


if @w_mm_tipo = 'B' or @w_mm_tipo='T'
   select @w_afectacion = 'D'

if @w_mm_tipo= 'C' or @w_mm_tipo = 'I'
   select @w_afectacion = 'C'

-------------------------------------
-- Transaccion normal o de reversion
-------------------------------------
/* Transaccion normal */
if @i_tipo = 'N'
begin
   if @w_mm_estado is not null or @w_mm_fecha_aplicacion is not null or @w_mm_secuencial <> 0
   begin
      if @i_en_linea = 'S'
      begin
         return 141084
      end
      else
      begin
         select @w_mensaje = '[sp_aplica_mov] Movimiento en estado diferente a por aplicar'
         select @w_error = 141084
         goto ERROR
      end
   end

   select   @w_mm_estado = 'A',@w_sec = @s_ssn,
      @w_fecha_aplicacion = convert(datetime,convert(varchar,@s_date,101))
end

/* Transaccion de reverso */
if @i_tipo = 'R'
begin
   if @w_mm_estado is null or @w_mm_fecha_aplicacion is null or @w_mm_secuencial = 0
      return 141085

   if @w_mm_estado is null or @w_mm_estado='R'
      if @i_en_linea = 'S'
         return 141087
      else
      begin
         select @w_mensaje = '[sp_aplica_mov] ERROR estado no esta aplicado'
         select @w_error = 141087
         goto ERROR
      end

   if @w_afectacion = 'C'
      select @w_afectacion = 'D'
   else
      select @w_afectacion = 'C'

   ------------------------------------------------------------------
   -- Solo los movimientos del cliente no se pueden volver a aplicar
   ------------------------------------------------------------------
   if @w_mm_tipo='C' or @w_mm_tipo = 'I' or @w_mm_tipo = 'T'
      select @w_mm_estado='R'
   else
      if @w_mm_tipo='B' -- or @w_mm_tipo = 'T'
         select @w_mm_estado=null

   select @w_fecha_aplicacion=NULL,@w_sec = 0
end

if @i_tipo = 'C'
begin
   if @w_afectacion = 'C'
      select @w_afectacion = 'D'
   else
      select @w_afectacion = 'C'
end

select @w_mm_producto = isnull(@w_mm_producto,'CHG')
select @w_fecha_mov = convert(datetime,convert(varchar,@s_date,101))

select @i_fecha_proceso = isnull(@i_fecha_proceso,@w_fecha_mov)

  -----------------------------------------------
  -- Control para ingreso de posicion de Divisas
  -----------------------------------------------
  if @w_mm_moneda <> @w_op_moneda and @w_mm_tipo_cotiza <> 'N'
  begin
     if @w_mm_tipo_cotiza = 'V' or @w_mm_tipo_cotiza = 'C'
        select @w_moneda_posicion = 2
     else
        select @w_moneda_posicion = @w_mm_moneda

      if @w_mm_tipo_cotiza = 'C'
         if @i_tipo = 'R'
            select @w_mm_tipo_cotiza = 'R', @w_tcorr = 'S'
         else
       select @w_mm_tipo_cotiza = 'R', @w_tcorr = 'N'
      else
         if @i_tipo = 'R'
            select @w_mm_tipo_cotiza = 'E', @w_tcorr = 'S'
         else
            select @w_mm_tipo_cotiza = 'E', @w_tcorr = 'N'

      if isnull(@w_mm_valor_ext,0) = 0
       select @w_mm_valor_ext = (@w_mm_valor / @w_mm_cotizacion)
   end

----------------------------------------
-- Evaluar si existe el producto Comext
----------------------------------------
if @w_producto = 9 and @i_transferencia = 'S'
begin
   if @w_int_cex = 'S'
   begin

      if @w_mm_moneda = @w_moneda_base
         select @w_mm_valor_completo = @w_mm_valor + isnull(@w_mm_impuesto,0)
      else
         select @w_mm_valor_completo = @w_mm_valor_ext + isnull(@w_mm_impuesto_capital_me,0)


      if @i_tipo = 'N'
      begin
         select @w_di_descripcion = di_descripcion
         from cobis..cl_direccion
         where di_ente = @w_op_ente
            and di_direccion = @i_dirord

         exec @w_return = cob_interfase..sp_icomext     -- BRO: 15/07/09  cob_comext..sp_apertura_tre_sba
              @i_operacion    = 'A',
              @s_ssn          = @s_ssn,
              @s_rol          = @s_rol,
              @s_user         = @s_user,
              @s_ofi          = @s_ofi,
              @s_date         = @s_date,
              @s_srv          = @s_srv,
              @s_org          = @s_org,
              @s_term         = @s_term,
              @s_sesn         = @s_sesn,
              @s_lsrv         = @s_lsrv,
              @s_ssn_branch   = @s_ssn_branch,
              @t_trn          = 9700,
              @i_tipo         = 'I' ,
              @i_tope         = 'TRE',
              @i_concep       = 'PFI',              -- Transferencias enviadas Plazo Fijo
              @i_opesba       = @i_operacionpf,     -- Numero de la operacion en plazo fijo
              @i_secsba       = @i_tr_cod_transf,       -- Secuencia del movimeinto monetario
              @i_modulo       = 14,
              @i_catego       = 'N',
              @i_oforig       = @s_ofi,
              @i_notifi       = @i_refconcep,       -- Motivo de la transferencia
              @i_fechem       = @i_fecha_valor,     -- Fecha de creacion
              @i_fechac       = @i_fecha_valor,
              @i_ordena       = @w_op_ente,        -- Ordenante
              @i_nomord       = @w_op_descripcion,  -- Nombre del ordenante
              @i_porcde       = @w_op_descripcion,  -- Nombre del ordenante
              @i_dirpcd       = @w_di_descripcion,  -- Direccion del ordenante
              @i_dirord       = @i_dirord,          -- Direccion del ordenante
              @i_cedruc       = @w_cedruc,         -- Identificacion del ordenante
              @i_import       = @w_mm_valor_completo,  -- Valor de la transferencia
              @i_moneda       = @w_mm_moneda,    -- Moneda de la transferenca
              @i_benefi       = @i_benefi,          -- Nombre del Beneficiario
              @i_dirben       = @i_dirben,          -- Direccion del beneficiario
              @i_ref_opc      = @i_ref_opc,         -- Numero de cuenta del beneficiario
              @i_conben       = @i_conben,          -- Continente del beneficiario
              @i_paiben       = @i_paiben,          -- Pais del beneficiario
              @i_ciuben       = @i_ciuben,          -- Ciudad del beneficiario
              @i_bcoben       = @i_bcoben,          -- Codigo del Banco Beneficiario
              @i_ofiben       = @i_ofiben,          -- Codigo de oficina del Banco Beneficiario
              @i_tdirben      = @i_tdirben,         -- Direccion ABA / 'S' Direccion SWIFT del Banco Beneficiario
              @i_instruccion1 = @i_instruccion,     -- Instruccion de pago
              @i_nomben       = @i_nomben,          -- Nombre del Banco Beneficiario.
              @i_bcoint       = @i_bcoint,          -- Codigo del banco intemediario
              @i_ofiint       = @i_ofiint,          -- Codigo de oficina del banco intemediario
              @i_tdirint      = @i_tdirint,         -- Direccion ABA / 'S' Direccion SWIFT del Banco Intemediario
              @i_nomint       = @i_nomint           -- Nombre del Banco intermediario. (corresponsal)

         if @w_return <> 0
         begin
            select @w_mensaje = '[sp_aplica_mov] Error en envio de transferencia comext'
            select @w_error = 143005
            goto ERROR
         end

         -- Verificar si se trata de un incremento entonces se debe inhabilitar la transferencia
         update pf_transferencias_tmp
         set   tr_estado = 'C',
            tr_cod_corresp = convert(varchar(10),@i_bcoben),
            tr_ofic_corresp = @i_ofiben,
            tr_cta_corresp = @i_ref_opc,
            tr_benef_corresp = @i_benefi
         where tr_cod_operacion = @i_operacionpf
            and tr_cod_transf    = @i_tr_cod_transf
      end

      if @i_tipo = 'R'
      begin
         exec @w_return = cob_interfase..sp_icomext
              @i_operacion               = 'B',
              @i_operacionpf             = @i_operacionpf,
              @i_tr_cod_transf           = @i_tr_cod_transf,
              @o_existe_relacion_sba_cex = @w_existe_relacion_sba_cex out,
              @o_estcex                  = @w_estcex                  out,
              @o_opecex                  = @w_opecex                  out
        
         if @w_return <> 0
            return @w_return

         if @w_existe_relacion_sba_cex > 0
         begin
            if @w_estcex <> 'P'
            begin
               select @w_mensaje = '[sp_aplica_mov] La operacion ya estÿ cancelada en comext'
               select @w_error = 143005
               goto ERROR
            end

            exec @w_return = cob_interfase..sp_icomext      -- BRO: 15/07/09   cob_comext..sp_anulacion_operacion
                 @i_operacion  = 'C',
                 @t_trn        = 9072,
                 @i_opeban     = @w_opecex,
                 @i_feceta     = @s_date,
                 @i_opesba     = @i_operacionpf,
                 @i_secsba     = @i_tr_cod_transf,
                 @s_ssn        = @s_ssn,
                 @s_srv        = @s_srv,
                 @s_lsrv       = @s_lsrv,
                 @s_user       = @s_user,
                 @s_sesn       = @s_sesn,
                 @s_term       = @s_term,
                 @s_date       = @s_date,
                 @s_org        = @s_org,
                 @s_ofi        = @s_ofi,
                 @s_rol        = @s_rol
                 
            if @w_return <> 0
            begin
               select @w_mensaje = '[sp_aplica_mov] Error en la anulacion en comext'
               select @w_error = 143005
               goto ERROR
            end
         end
      end
   end
end

   -----------------------------------------------------------------------------------------
   -- A la condicion se agrega control para productos con capitalizacion de intereses 'CAP'
   -----------------------------------------------------------------------------------------

   if (@w_producto <> 3 and @w_producto <> 4) and (@w_mm_producto <> 'CAP') and (@w_mm_producto <> 'SEBRA') and (@w_mm_producto <> 'OTROS') and @w_producto is not null
   begin
      if @i_tipo = 'N' and @w_afectacion = 'C'
      begin
         -----------------------------------------------
    -- Control de moneda para la emision de cheque
         -----------------------------------------------
         if @w_mm_moneda = @w_moneda_base
            select @w_ec_valor = @w_mm_valor
          else
            select @w_ec_valor = @w_mm_valor_ext

         if @i_emite_orden = 'S'
       begin
         if @t_trn = 14905                   --LIM 17/OCT/2005
         begin
            if (@w_fecha_ult_pg_int_ant is not null) and
                                   (@w_fecha_ult_pg_int_ant >= @i_fecha_inicial and @w_fecha_ult_pg_int_ant <= @w_fecha_pg_int)
               select @w_fecha_inicial = convert(varchar(10),@w_fecha_ult_pg_int_ant,103),
                      @w_fecha_final   = convert(varchar(10),@w_fecha_pg_int,103)
            else
               select @w_fecha_inicial = convert(varchar(10),@i_fecha_inicial,103),
                      @w_fecha_final   = convert(varchar(10),@w_fecha_pg_int,103)
         end
                        else
         if @t_trn = 14155
         begin
                             if @w_fecha_ult_pg_int_ant is not null
                select @w_fecha_inicial = convert(varchar(10),@w_fecha_ult_pg_int_ant,103)
                             else
                select @w_fecha_inicial = convert(varchar(10),@w_fecha_ult_pg_int,103)

              select @w_fecha_final   = convert(varchar(10),@i_fecha_proceso,103)
         end
         else
         if @t_trn = 14943
         begin
            select @w_fecha_inicial = convert(varchar(10),@i_fecha_inicial,103),
                   @w_fecha_final   = convert(varchar(10),@i_fecha_final,103)
         end
         else
            select @w_fecha_inicial = null,
                   @w_fecha_final   = null

             select @w_cuenta = NULL      

select @t_debug = 'N' 
if @t_debug = 'S' print '@w_mm_producto  ' + cast (  @w_mm_producto  as varchar)
if @t_debug = 'S' print '@w_mm_cuenta  ' + cast (  @w_mm_cuenta  as varchar)
if @t_debug = 'S' print '@t_trn  ' + cast (  @t_trn   as varchar)


             if @w_mm_producto = 'EFEC'
                select @w_ec_numero = @w_mm_cuenta
             select @w_caja       = null,
                    @w_fecha_caja = null
             
             if @w_mm_producto = 'CHC' Begin
                select @w_caja = 'S',
                       @w_fecha_caja = @s_date
             end  
                            
                   
            insert pf_emision_cheque ( ec_fecha_mov    , ec_secuencial, ec_secuencia,      ec_sub_secuencia,
                                       ec_fpago        , ec_estado    , ec_tran     ,      ec_operacion,
                                       ec_numero       , ec_moneda    , ec_valor    ,      ec_tipo,
                                       ec_fecha_emision, ec_fecha_crea, ec_fecha_mod,      ec_descripcion,
                                       ec_fecha_inicial, ec_fecha_final,                       --LIM 17/OCT/2005
                                       ec_monto_cal    , ec_tasa_cal, ec_subtipo_ins,      ec_caja,
                                       ec_fecha_caja)                                      
                               values (@w_fecha_mov    , @s_ssn       , @i_secuencia,      @i_sub_secuencia,
                                       @w_mm_producto  , null         , @t_trn      ,      @i_operacionpf,
                                       @w_ec_numero    , @w_mm_moneda , @w_ec_valor ,      'C',
                                       null            , @s_date      , @s_date     ,      @w_beneficiario,
                                       @w_fecha_inicial, @w_fecha_final,
                                       @w_op_monto,      @w_op_tasa,    @w_mm_subtipo_ins, @w_caja,
                                       @w_fecha_caja  )                --LIM 17/OCT/2005
            if @@error <> 0
         begin
                     select @w_mensaje = '[sp_aplica_mov] Error insercion emision cheque'
                     select @w_error = 143031
                     goto ERROR
               end
         select @o_secuencial = @s_ssn         --LIM 14/Oct/2005   Asignacion secuencial
         end
      end
   end

   if @w_producto = 3  or @w_producto = 4    -- GES 01/08/02 CUZ-054-003
   begin
      --print 'va a aplicar cuentas corrientes o ahorros'

      if @i_en_linea = 'N'
      begin
        select @w_save_tran = 'aplicacion'
        save tran aplicacion
      end
      else
        select @w_save_tran = null

      if @w_mm_moneda = @w_moneda_base
         select @w_mm_valor_completo = @w_mm_valor -- NYM DPF00015 ICA
      else
         select @w_mm_valor_completo = @w_mm_valor_ext + isnull(@w_mm_impuesto_capital_me,0)
   end

   if @w_producto = 3   -- CUENTAS CORRIENTES
   begin
      if @w_afectacion = 'C'
         select @w_tran = 48, @w_tr_causa = '61' -- Nota de CrTdito
      else
         select @w_tran = 50, @w_tr_causa = '36' -- Nota de DTbito


   /*******************************************************************************************/
   --CVA Ene-16-06 Para aplicar los movimientos a los otros modulos Cobis con
   --                   fecha laborable pero solo para Cuentas Corrientes/Ahorros
   if @i_en_linea = 'N'
   begin

      exec sp_fecha_contable
           @i_fecha_proceso  = @s_date,
                @o_fecha_contable = @w_fecha_movimiento out

      --print '@s_date %1!, @w_fecha_movimiento %2!', @s_date, @w_fecha_movimiento

      if @w_fecha_movimiento is null
         select @w_fecha_movimiento = @s_date
   end
   /*******************************************************************************************/


      -------------------------------------------------------------------------------------------
      -- Proceso para disparar el sp de Debitos y Creditos a automaticos con afectacion a la cte
      -------------------------------------------------------------------------------------------
      exec @w_return = cob_interfase..sp_icuentas     -- BRO: 15/07/09   cob_cuentas..sp_ccndc_automatica 
           @i_operacion      = 'P',
           @s_srv            = @s_srv,
           @s_ofi            = @s_ofi,
           @s_ssn            = @s_ssn,
           @s_user           = @s_user,
           @s_date           = @w_fecha_movimiento,
           @t_trn            = @w_tran,
           @i_nomtrn         = @w_save_tran,
           @i_cta_ger        = @w_mm_cuenta,
           @i_val            = @w_mm_valor_completo,
           @i_cau            = @w_tr_causa,
           @i_monto          = @w_mm_moneda,
           @i_fecha          = @w_fecha_movimiento,
           @i_concepto       = @w_ctas_concepto,
           @i_autorizado     = @w_mm_autorizado,
           @i_codigo_alterno = @i_sub_secuencia,
           @i_fecha_valor_a  = @i_fecha_valor,
           @i_is_batch       = @i_en_linea

      if @w_return <> 0
      begin
         select @w_mensaje = '[sp_aplica_mov] Error aplicacion ND/NC Cuentas Corrientes ' + @w_mm_producto
         select @w_error = @w_return
         goto ERROR
      end
   end

   if @w_producto  = 4  --CUENTAS DE AHORROS
   begin


      select @w_inmovi= 'N'
      select @w_activar_cta = 'N'

      if @i_tipo ='N'
      begin
         if @w_afectacion = 'C' begin
            select @w_tran = 253, @w_ind  = 1, @w_tr_causa =  '12' -- Nota de CrTdito
            select @w_inmovi= 'S'
         end
         else
            select @w_tran = 264, @w_ind  = 1, @w_tr_causa = '24' -- Nota de DTbito
         select  @t_corr = 'N'  
      end 
      else
      begin
         if @w_afectacion = 'C'
            select @w_tran = 264, @w_ind  = 1, @w_tr_causa = '24' -- Nota de DTbito            
         else begin
            select @w_tran = 253, @w_ind  = 1, @w_tr_causa =  '12' -- Nota de CrTdito
            select @w_inmovi= 'S'
         end
         select @t_corr = 'S' 
      end    

    
      if @i_trn = 14905 and @i_en_linea = 'N'
         select @w_plfijo = 'S'
      else
         select @w_plfijo = 'N'

      /* REQ 306 - SI CUENTA EN ESTADO INGRESADA, VALIDAR MONTO PRIMER DEPOSITO */
      exec @w_return = cob_interfase..sp_iahorros
           @i_operacion     = 'A',
           @i_cuenta_banco  = @w_mm_cuenta,
           @o_categoria     = @w_categoria out,
           @o_tipocta       = @w_tipocta   out,
           @o_rolente       = @w_rolente   out,
           @o_tipo_def      = @w_tipo_def  out,
           @o_prod_banc     = @w_prod_banc out,
           @o_producto      = @w_producto  out,
           @o_moneda        = @w_moneda    out,
           @o_estado        = @w_estado    out

      if @w_return <> 0
         return @w_return
      
      if @w_estado = 'G' and @t_corr = 'N'
      begin
      
         exec @w_return = cob_interfase..sp_iremesas   --exec @w_return = cob_remesas..sp_genera_costos 
              @i_operacion    = 'A',
              @i_categoria    = @w_categoria,
              @i_tipo_ente    = @w_tipocta,
              @i_rol_ente     = @w_rolente,
              @i_tipo_def     = @w_tipo_def,
              @i_prod_banc    = @w_prod_banc,
              @i_producto     = @w_producto,
              @i_moneda       = @w_moneda,
              @i_tipo         = 'R',
              @i_codigo       = 0,
              @i_servicio     = 'MMAP',
              @i_rubro        = '39',
              @i_disponible   = $0,
              @i_contable     = $0,
              @i_promedio     = $0,
              @i_personaliza  = 'N',
              @i_filial       = @t_filial,
              @i_oficina      = @s_ofi,
              @i_fecha        = @s_date,
              @o_valor_total  = @w_deposito_min out

         if @w_return <> 0
         begin
            select @w_mensaje = '[sp_aplica_mov] Error hallando valor monto minimo de apertura'
            select @w_error = 251096
            goto ERROR           
         end
         
         if @w_deposito_min is null
         begin
           select @w_mensaje = '[sp_aplica_mov] Monto deposito inicial no existe'
           select @w_error = 251097
           goto ERROR           
         end
      
         if @w_mm_valor_completo < @w_deposito_min
         begin
           select @w_mensaje = '[sp_aplica_mov] Monto depositado inferior al monto minimo establecido'
           select @w_error = 251098
           goto ERROR
         end
      end
   /*******************************************************************************************/
   --CVA Ene-16-06 Para aplicar los movimientos a los otros modulos Cobis con
   --                   fecha laborable pero solo para Cuentas Corrientes/Ahorros
   if @i_en_linea = 'N'
   begin
      exec sp_fecha_contable
           @i_fecha_proceso  = @s_date,
                @o_fecha_contable = @w_fecha_movimiento out

      if @w_fecha_movimiento is null
         select @w_fecha_movimiento = @s_date
   end
   /*******************************************************************************************/


     select @w_num_tit = isnull(count(1),0)
     from   pf_beneficiario
     where  be_operacion    = @i_operacionpf
     and    be_estado_xren  = 'N'
     and    be_estado       = 'I'
     and    be_tipo         = 'T'

if @t_debug = 'S' print '  nym aplic i_operacionpf ' + cast(@i_operacionpf as varchar  )
if @t_debug = 'S' print '  nym aplic w_num_tit ' + cast(@w_num_tit as varchar  )

     select @w_titularidad_prods = ''
     if @w_num_tit = 1 -- Individual
        select @w_titularidad_prods = 'I'

if @t_debug = 'S' print '  nym aplic w_titularidad_prods  ' + cast(@w_titularidad_prods as varchar  )

      --------------------------------------------------------
      -- JSA Ingreso del concepto de la aplicacion autom_tica
      --------------------------------------------------------
      exec @w_return = cob_interfase..sp_iahorros     -- BRON: 15/07/09   cob_ahorros..sp_ahndc_automatica
           @i_operacion         = 'F',
           @s_srv               = @s_srv,
           @s_ofi               = @s_ofi,
           @s_ssn               = @s_ssn,
           @s_user              = @s_user,           
           @s_date              = @w_fecha_movimiento,
           @t_corr              = @t_corr,
           @t_ssn_corr          = @w_ssn_central,
           @t_trn               = @w_tran,
           @i_nomtrn            = @w_save_tran,
           @i_cta               = @w_mm_cuenta,
           @i_val               = @w_mm_valor_completo,
           @i_cau               = @w_tr_causa,
           @i_moneda            = @w_mm_moneda,
           @i_fecha             = @w_fecha_movimiento,
           @i_concepto          = @w_ctas_concepto,
           @i_alt               = @i_sub_secuencia,
           @i_fecha_valor_a     = @i_fecha_valor,
           @i_is_batch          = @i_en_linea,
           @i_inmovi            = @w_inmovi, 
           @i_activar_cta       = @w_activar_cta, 
           @i_titular_prods     = @w_op_ente, 
           @i_titularidad_prods = @w_titularidad_prods

      if @w_return <> 0
      begin
         select @w_mensaje = '[sp_aplica_mov]  Error aplicacion ND/NC Cuentas Ahorros' + @w_mm_producto
         select @w_error = @w_return
         goto ERROR
      end
   end



----------------------------------------------------
-- APLICACION A TARJETAS DE CREDITO
----------------------------------------------------
if @w_producto = 165
begin
   if exists(select 1
                  from cobis..cl_producto
                 where pd_producto = @w_producto)
   begin
      if @w_mm_moneda = @w_moneda_base
         select @w_mm_valor_completo = @w_mm_valor + isnull(@w_mm_impuesto,0)
      else
         select @w_mm_valor_completo = @w_mm_valor_ext + isnull(@w_mm_impuesto_capital_me,0)

      /*******************************************************************************************/
      --CVA Ene-16-06 Para aplicar los movimientos a los otros modulos Cobis con
      --                   fecha laborable pero solo para Cuentas Corrientes/Ahorros
      if @i_en_linea = 'N'
      begin

      exec sp_fecha_contable
           @i_fecha_proceso  = @s_date,
                @o_fecha_contable = @w_fecha_movimiento out

      --print '@s_date %1!, @w_fecha_movimiento %2!', @s_date, @w_fecha_movimiento

      if @w_fecha_movimiento is null
         select @w_fecha_movimiento = @s_date

      end
      /*******************************************************************************************/

      if @i_tipo = 'N'
         select @w_tcorr = @t_corr
      else
         select @w_tcorr = 'R'

      exec @w_return = cob_interfase..sp_icuentas     -- BRON: 15/07/09  cob_cuentas..sp_tr_tarjvisa
           @i_operacion    = 'K',      
           @s_ssn          = @s_ssn,
           @s_lsrv         = @s_lsrv,
           @s_date         = @w_fecha_movimiento,
           @s_org          = 'R',
           @s_user         = @s_user,
           @s_ofi          = @s_ofi,
           @s_srv          = @s_srv,
           @s_ssn_branch   = @s_ssn_branch,
           @s_term         = @s_term,
           @s_rol          = @s_rol,
           @t_corr         = @w_tcorr,
           @t_ssn_corr     = @t_ssn_corr,
           @t_trn          = 2785,
           @t_ejec         = 'N',
           @i_ActTot       = 'N',
           @i_acredita     = 'N',        --CVA May-12-06
           @i_total        = @w_mm_valor_completo,
           @i_tarjeta      = @w_mm_cuenta,
           @i_filial       = @t_filial,
           @i_moneda       = @w_mm_moneda,
           @i_mon_tarjeta  = @w_mm_moneda,
           @i_cod_alterno  = @i_sub_secuencia, --+-+
           @i_val          = @w_mm_valor_completo,
           @i_canal        = 37 --DPF CVA May-22-06

      if @w_return <> 0
      begin
         select @w_mensaje = '[sp_aplica_mov] Error pago TC '
         select @w_error = 143005
         goto ERROR
      end
   end
end


--------------------------------------------
-- Evaluar si existe el producto de Cartera
--------------------------------------------
if @w_producto = 7
begin
   if exists(select 1
                  from cobis..cl_producto
                 where pd_producto = @w_producto)
   begin
      -----------------------------------------------
      -- Obtener el canal de afectacion para Cartera
      -----------------------------------------------
      select @w_canal = pa_tinyint
      from cobis..cl_parametro
      where pa_nemonico = 'CANR'
         and pa_producto = 'PFI'
      if @@rowcount = 0
         select @w_canal = 3

      if @w_mm_moneda = @w_moneda_base
         select @w_mm_valor_completo = @w_mm_valor + isnull(@w_mm_impuesto,0)
      else

         select @w_mm_valor_completo = @w_mm_valor_ext + isnull(@w_mm_impuesto_capital_me,0)


         --print '@i_fecha_valor %1!, @t_trn %2!, @i_tipo %3!, @i_en_linea %4!', @i_fecha_valor, @t_trn, @i_tipo, @i_en_linea


         if @i_tipo = 'N'
         begin
            if @i_fecha_valor is not null       --LIM 20/ENE/2006
            begin
      --print 'lo lleva a fecha valor %1!', @i_fecha_valor
               set rowcount 0

               exec @w_return = cob_interfase..sp_icartera     -- BRON: 16/07/09   cob_cartera..sp_fecha_valor  --LIM 20/ENE/2006
                    @i_operacion   = 'A',
                    @s_date        = @s_date,
                    @s_lsrv        = @s_lsrv,
                    @s_ofi         = @s_ofi,
                    @s_org         = @s_org,
                    @s_rol         = @s_rol,
                    @s_sesn        = @s_sesn,
                    @s_ssn         = @s_ssn,
                    @s_srv         = @s_srv,
                    @s_term        = @s_term,
                    @s_user        = @s_user,
                    @t_trn         = 7049,
                    @i_en_linea    = @i_en_linea,
                    @i_fecha_valor = @i_fecha_valor, --fecha a la cual se quiere llevar la operacion
                    @i_banco       = @w_mm_cuenta, --Numero de operacion
                    @i_tipo        = 'F',
                    @i_externo     = 'N' --Para que no ejecute begin tran

              if @w_return <> 0
      begin
         --CVA Jul-26-06 para evitar que el batch se cancele por un error devuelto en cartera
                   if @i_en_linea = 'N'
         begin
                      select @w_error = 149099
            select @w_mensaje =  mensaje from cobis..cl_errores where numero = @w_return
         end
                   else
                      select @w_error = @w_return

         goto ERROR
      end

      --print 'aplica el pago a fecha valor %1!',  @i_fecha_valor

                exec @w_return = cob_interfase..sp_icartera         --BRON: 16/07/09  cob_cartera..sp_abono_bv_cca
                     @i_operacion      = 'B',
                     @s_user           = @s_user,
                     @s_term           = @s_term,
                     @s_date           = @s_date,
                     @s_sesn           = @s_sesn,
                     @s_ofi            = @s_ofi,
                     @s_srv            = @s_srv,
                     @s_ssn            = @s_ssn,
                     @s_lsrv           = @s_lsrv,
                     @i_cta            = @w_op_num_banco,
                     @i_banco          = @w_mm_cuenta,             -- > Numero del prestamo
                     @i_mon            = @w_mm_moneda,             -- > Moneda en la cual se efectua el pago
                     @i_monto_mpg      = @w_mm_valor_completo,     -- > monto del pago.
                     @i_canal          = @w_canal,                 -- > enviar 3 para el caso de DPF.
                     @i_fecha_vig      = @i_fecha_valor,           -- > Fecha de vigencia
                     @i_en_linea       = @i_en_linea,
                     @o_secuencial_pag = @w_sec out                -- > devuelve el No. del pago en
 

               if @w_return <> 0
               begin
                  select @w_mensaje = '[sp_aplica_mov] Error en abono a prestamo ' + @w_mm_cuenta
         --CVA Jul-26-06 para evitar que el batch se cancele por un error devuelto en cartera
                   if @i_en_linea = 'N'
         begin
                      select @w_error = 149098
            select @w_mensaje =  mensaje from cobis..cl_errores where numero = @w_return
         end
                   else
                      select @w_error = @w_return

                  goto ERROR
               end


               exec @w_return = cob_interfase..sp_icartera     -- BRON: 16/07/09  cob_cartera..sp_fecha_valor   --LIM 20/ENE/2006
                    @i_operacion   = 'A',
                    @s_date        = @s_date,
                    @s_lsrv        = @s_lsrv,
                    @s_ofi         = @s_ofi,
                    @s_org         = @s_org,
                    @s_rol         = @s_rol,
                    @s_sesn        = @s_sesn,
                    @s_ssn         = @s_ssn,
                    @s_srv         = @s_srv,
                    @s_term        = @s_term,
                    @s_user        = @s_user,
                    @t_trn         = 7049,
                    @i_en_linea    = @i_en_linea,
                    @i_fecha_valor = @i_fecha_proceso, --fecha a la cual se quiere llevar la operacion
                    @i_banco       = @w_mm_cuenta, --Numero de operacion
                    @i_tipo        = 'F',
                    @i_externo     = 'N' --Para que no ejecute begin tran

             if @w_return <> 0
          begin
         --CVA Jul-26-06 para evitar que el batch se cancele por un error devuelto en cartera
                   if @i_en_linea = 'N'
         begin
                      select @w_error = 149099
            select @w_mensaje =  mensaje from cobis..cl_errores where numero = @w_return
         end
                   else
                      select @w_error = @w_return

        goto ERROR
               end
       end
       else
            if @i_fecha_valor is null
            begin
               set rowcount 0

      /*******************************************************************************************/
      --CVA Dic-04-06 Para aplicar los movimientos a los otros modulos Cobis con
      --                   fecha laborable pero solo para Cuentas Corrientes/Ahorros
      if @i_en_linea = 'N'
      begin
         exec sp_fecha_contable
               @i_fecha_proceso  = @s_date,
                     @o_fecha_contable = @w_fecha_movimiento out

         select @i_fecha_valor = @w_fecha_movimiento

         if @w_fecha_movimiento is null
            select @w_fecha_movimiento = @s_date,
                   @i_fecha_valor      = @w_fecha_movimiento
      end
      /*******************************************************************************************/


               exec @w_return = cob_interfase..sp_icartera         --BRON: 16/07/09  cob_cartera..sp_abono_bv_cca
                    @i_operacion      = 'B',
                    @s_user           = @s_user,
                    @s_term           = @s_term,
                    @s_date           = @s_date,
                    @s_sesn           = @s_sesn,
                    @s_ofi            = @s_ofi,
                    @s_srv            = @s_srv,
                    @s_ssn            = @s_ssn,
                    @s_lsrv           = @s_lsrv,
                    @i_cta            = @w_op_num_banco,
                    @i_banco          = @w_mm_cuenta,             -- > Numero del prestamo
                    @i_mon            = @w_mm_moneda,             -- > Moneda en la cual se efectua el pago
                    @i_monto_mpg      = @w_mm_valor_completo,     -- > monto del pago.
                    @i_canal          = @w_canal,                 -- > enviar 3 para el caso de DPF.
                    @i_fecha_vig      = @i_fecha_valor,           -- > Fecha de vigencia
                    @i_en_linea       = @i_en_linea,
                    @o_secuencial_pag = @w_sec out            -- > devuelve el No. del pago en

               if @w_return <> 0
               begin
                  select @w_mensaje = '[sp_aplica_mov] Error en abono a prestamo ' + @w_mm_cuenta
         --CVA Jul-26-06 para evitar que el batch se cancele por un error devuelto en cartera
                   if @i_en_linea = 'N'
         begin
                      select @w_error = 149098
            select @w_mensaje =  mensaje from cobis..cl_errores where numero = @w_return
         end
                   else
                      select @w_error = @w_return

                  goto ERROR
               end
            end
         end
         else
         if @i_tipo = 'R'        --LIM 20/ENE/2006
         begin
              set rowcount 0

              exec @w_return = cob_interfase..sp_icartera     -- BRON: 16/07/09  cob_cartera..sp_fecha_valor       --LIM 20/ENE/2006
                   @i_operacion  = 'A',
                   @s_date       = @s_date,
                   @s_ofi        = @s_ofi,
                   @s_rol        = @s_rol,
                   @s_sesn       = @s_sesn,
                   @s_ssn        = @s_ssn,
                   @s_srv        = @s_srv,
                   @s_term       = @s_term,
                   @s_user       = @s_user,
                   @t_trn        = 7049,
                   @i_banco      = @w_mm_cuenta, --Numero de operacion
                   @i_secuencial = @w_mm_secuencial, --Secuencial de la transaccion del pago
                   @i_tipo       = 'R',
                   @i_externo    = 'N'
             
             if @w_return <> 0
             begin
                select @w_error = @w_return
                goto ERROR
             end
         end

   end
end

--print ' actiop @s_ssn_branch '+ cast( @s_ssn_branch as varchar)
if @i_tipo = 'N'
begin
   select @w_snn = @s_ssn
   select @w_snn_reverso = null
end
else
begin
   select @w_snn = @w_ssn_central
   select @w_snn_reverso = @s_ssn
end

   update pf_mov_monet
      set mm_fecha_aplicacion = @w_fecha_aplicacion,
          mm_secuencial       = @w_sec,
          mm_oficina          = @w_oficina,
          mm_estado           = @w_mm_estado,
          mm_fecha_real       = getdate(),
    mm_ssn_branch       = @s_ssn_branch,
          mm_snn_central      = @w_snn,
          mm_snn_rev_central  = @w_snn_reverso
    where mm_operacion     = @i_operacionpf
      and mm_tran          = @t_trn
      and mm_secuencia     = @i_secuencia
      and mm_sub_secuencia = @i_sub_secuencia
      --and (@s_ssn_branch is null or mm_ssn_branch = @s_ssn_branch)       --LIM 04/OCT/2005
   if @@error <> 0
   begin
      if @i_en_linea = 'S'
         return 145020
      else
      begin
         select @w_mensaje = 'Error en actualizacion de pf_mov_monet'
         select @w_error = 145020
         goto ERROR
      end
   end

return 0

-------------------------------
-- Rutina para manejo de error
-------------------------------
ERROR:

   --------------------------------------
   -- Encontrar la descripcion del error
   --------------------------------------
   if @w_mensaje is null
   begin
   select @w_mensaje = mensaje
     from cobis..cl_errores
    where numero = @w_return
   end

   if @i_en_linea = 'N'
   begin
      select @w_cuenta    =  convert(varchar(10),@i_operacionpf)

      --I.CVA Dic-13-06 Eliminar el registro de pf_emision_cheque, si la forma de pago da algun error.
      delete from pf_emision_cheque
      where ec_fecha_mov     = @w_fecha_mov
        and ec_secuencial    = @s_ssn
   and ec_operacion     = @i_operacionpf
   and ec_secuencia     = @i_secuencia
   and ec_sub_secuencia = @i_sub_secuencia
   and ec_tran          = @t_trn
      --F.CVA Dic-13-06 Eliminar el registro de pf_emision_cheque, si la forma de pago da algun error.

      exec sp_errorlog
           @i_fecha       = @s_date,
           @i_error       = @w_error,
           @i_usuario     = @s_user,
           @i_tran        = @t_trn,
           @i_cuenta      = @w_op_num_banco,
           @i_descripcion = @w_mensaje,
           @i_cta_pagrec  = @w_mm_cuenta
   end
   else
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = @w_error,
           @i_msg   = @w_mensaje

   end

   return @w_error
go
