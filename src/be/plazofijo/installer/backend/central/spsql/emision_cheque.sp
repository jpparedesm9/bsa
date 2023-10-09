/*sp_emision_cheque*/
/************************************************************************/
/*      Stored procedure:       sp_emision_cheque                       */
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
/*      Procedimiento que realiza la emision de cheques de Gerencia     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*    21-Feb-2007  H.Ayarza     Aumento @i_ref_opc varchar(34).         */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_emision_cheque')
   drop proc sp_emision_cheque
go

create proc sp_emision_cheque (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_sesn                 int             = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  int             = NULL,
@s_org                  char(1)         = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = NULL,
@i_operacion            char(1),
@i_en_linea             char(1)         = 'S',
@i_tipo                 char(1)         = 'C',
@i_operacionpf          int             = NULL,
@i_fecha_mov            datetime        = NULL,
@i_secuencial           int             = 0,
@i_secuencia            int             = 0,
@i_sub_secuencia        int             = 0,
@i_numero               int             = 99999999,
@i_descripcion          descripcion     = '',
@i_producto             catalogo        = NULL,
@i_idlote               int             = 0,
@i_formato_fecha        int             = 103,
@i_forma_pago           catalogo        = NULL,
@i_forma_pago_inicial   catalogo        = NULL,
@i_producto_pago        tinyint         = NULL,
@i_tr_cod_transf        int             = NULL,
@i_empresa              tinyint         = 1,
@i_flag_sbancarios      tinyint         = 0,
@i_flag_divide          tinyint         = 0,
@i_dp_secuencia_orig    int             = 0,            -- Campo pf_det_pago..dp_secuencia del registro que origina nueva forma de pago
@i_num_banco            cuenta          = NULL,
@i_refconcep            varchar(255)    = NULL,         -- Motivo de la transferencia
@i_dirord               tinyint         = NULL,         -- Direcci¢n del ordenante
@i_benefi               varchar(64)     = NULL,         -- Beneficiario
@i_dirben               varchar(255)    = NULL,         -- Direcci¢n del beneficiario
@i_ref_opc              varchar(34)     = NULL,         -- Cuenta del beneficiario
@i_conben               varchar(3)      = NULL,         -- Continente del beneficiario
@i_paiben               smallint        = NULL,         -- Pa¡s del beneficiario
@i_ciuben               smallint        = NULL,         -- Ciudad del beneficiario
@i_bcoben               smallint        = NULL,         -- C¢digo del banco beneficiario
@i_ofiben               smallint        = NULL,         -- C¢digo de la oficina del banco beneficiario
@i_tdirben              char(1)         = NULL,         -- Direccion ABA / 'S' Direccion SWIFT. MANDATORIO
@i_nomben               descripcion     = NULL,         -- Nombre del Banco Beneficiario.
@i_instruccion          varchar(255)    = NULL,         -- Instrucciones de pago
@i_bcoint               smallint        = NULL,         -- C¢digo del banco intemediario
@i_ofiint               smallint        = NULL,         -- C¢digo de la oficina del banco intemediario
@i_tdirint              char(1)         = NULL,         -- Direccion ABA / 'S' Direccion SWIFT
@i_nomint               descripcion     = NULL,         -- Nombre del Banco intermediario.
@i_transferencia        char(1)         = 'N',          -- Indica si se est  emitiendo una transferencia
@i_contabiliza          char(1)         = 'S'           -- Par metro que indica si/no genera comprobante contable por emision de orden
)
with encryption
as
declare
@w_sp_name              descripcion,
@w_return               int,

/** VARIABLES CC_CTA_GERENCIA **/
        @w_cg_cuenta                    cuenta,

/** VARIABLES PF_EMISION_CHEQUE **/
        @w_mt_tipo_cuenta_ach           char(1),
        @w_mt_banco_ach                 smallint,
        @w_moneda                       tinyint,
        @w_numero                       int,
        @w_descripcion                  descripcion,
        @w_descripbenef                 varchar(255), -- se cambia longitud para SB
        @w_fecha_mod                    datetime,
        @w_valor                        money,
        @w_fecha_emision                datetime,
        @w_ec_secuencial                int,
        @w_ec_secuencia                 int,
        @w_ec_numero                    int,
        @w_ec_fecha_mov                 datetime,
        @w_cheque_pro                   catalogo,
        @w_cheque_ger                   catalogo,
        @w_efectivo                     catalogo,
        @w_fpago                        catalogo,
        @w_cupon                        catalogo,
        @w_camara                       catalogo,
        @w_conceptosb                   tinyint,
        @w_valor_contabiliza            money,
        @w_estado_update                char(1),
        @w_sec_lote                     int,          --LIM
        @w_fecha_inicial                varchar(10),  --LIM   17/OCT/2005
        @w_fecha_final                  varchar(10),  --LIM  17/OCT/2005
        @w_fecha_inicial_d              datetime,     --LIM   17/OCT/2005
        @w_fecha_final_d                datetime,     --LIM  17/OCT/2005

        @w_op_tasa                      float,
        @w_op_monto                     money,
        @w_monto_var                    varchar(30),
        @w_tasa_var                     varchar(20), --LIM 20/DIC se aumenta de 10 a 20


/* VARIABLES NECESARIAS PARA PF_MOV_MONET */
        @w_mt_sub_secuencia             tinyint,
        @w_mt_producto                  catalogo,
        @w_mt_cuenta                    cuenta,
        @w_mt_tipo                      char(1),
        @w_mt_beneficiario              int,
        @w_mm_beneficiario              int,
        @w_mt_impuesto                  money,
        @w_mt_moneda                    int,
        @w_op_moneda                    int,
        @w_moneda_posicion              smallint,
        @w_mt_valor_ext                 money,
        @w_mt_fecha_crea                datetime,
        @w_mt_fecha_mod                 datetime,
        @w_mt_valor                     money,
        @w_mt_tipo_cliente              char(1),
        @w_mt_cotizacion                money,
        @w_mt_tipo_cotiza               char(1),
        @w_envio_posme                  char(1),
        @w_op_ente                      int,
        @w_cont                         tinyint,
        @w_producto_pago                tinyint,
        @w_mm_oficina                   int,
        @w_mt_oficina                   int,    --LIM 11/NOV/2005
/** VARIABLES PARA PF_OPERACION **/
        @w_producto                     tinyint,
        @w_oficina                      int,
        @w_oficina_emision              int,     --+-+
        @w_toperacion                   catalogo,
        @w_tplazo                       catalogo,
        @w_operacionpf                  int,
        @w_estado                       catalogo,
        @w_tcapitalizacion              char(1),
        @w_ofi_ing                      smallint,
        @w_fecha                        datetime,
        @w_string                       varchar(30),
        @w_num_banco                    cuenta,
        @w_mon_sgte                     int,
        @w_retieneimp                   char(1),
        @w_mon_sgte_conta               int,
        @w_numdeci                      tinyint,
        @w_usadeci                      char(1),
        @w_sec                          int,
        @w_tran                         int,
        @w_ec_tran                      int,
        @w_historia                     smallint,
        @w_rowcount                     int,
/**   VARIABLES PARA EL GAP DP-000015      **/
        @w_concepto                     descripcion,
        @w_caja                         char(1),
        @w_error                        int,
        @w_campo1                       varchar(20),
        @w_campo47                      descripcion,
        @w_campo48                      descripcion,
        @w_fecha_ult_pg_int             datetime,
        @w_fecha_anterior               datetime,
        @w_fecha_valor                  datetime,
        @w_idlote                       int,
        @w_num_meses                    tinyint,
        @w_dias                         smallint,
        @w_ppago                        catalogo,
        @w_giro                         catalogo,
        @w_campo40                      char(1),
        @w_archivo                      varchar(12),
        @w_subtipo                      tinyint,
        @w_cuenta                       cuenta,
        @w_cu_fecha_caja                datetime,
        @w_ec_fecha_caja                datetime,
        @w_tran_conta                   int,
        @w_cu_retenido                  char(1),
        @w_cu_estado                    catalogo,
        @w_cu_cuota                     tinyint,
        @w_cu_forma_pago                catalogo,
        @w_moneda_base                  tinyint,
        @w_parametro                    char(6),
        @w_secuencial_cheque            int,
        @w_producto_fpago               tinyint,
        @w_area_contable                int,
        @w_letra_internacional_CIB      catalogo,
        @w_letra_internacional_1013     catalogo,
        @w_filial                       tinyint,
        @w_cheque_compensacion          catalogo,
        @w_tasa1                        float,
        @w_valor_completo               money,
        @w_mm_valor                     money,
        @w_mm_valor_ext                 money,
        @w_mm_impuesto                  money,
        @w_op_operacion                 int,
/** VARIABLES PARA PF_DET_PAGO  **/
        @w_pt_beneficiario              int,
        @w_pt_secuencia                 int,
        @w_pt_tipo                      catalogo,
        @w_pt_forma_pago                catalogo,
        @w_secuencial                   int,
        @w_pt_cuenta                    cuenta,
        @w_pt_monto                     money,
        @w_pt_porcentaje                float,
        @w_pt_fecha_crea                fecha,
        @w_pt_moneda_pago               smallint,
        @w_estado_xren                  char(1),
        @w_pt_fecha_mod                 datetime,
        @w_pt_descripcion               varchar(255),
        @w_pt_oficina                   int,
        @w_pt_tipo_cliente              char(1),
        @w_pt_tipo_cuenta_ach           char(1),
        @w_pt_banco_ach                 descripcion,
        @w_benef_chq                    varchar(255),
/** VARIABLES PARA QUERY DINAMICO **/
        @w_afectacion                   char(1),
        @w_codval                       varchar(20),
        @w_debcred                      char(1),
        @w_movmonet                     char(1),
        @w_contador                     int,
        @w_count                        int,
/** Seccion Variables output **/
        @o_comprobante                  int,
        @o_secuencial                   int,
        @w_mensaje                      descripcion,
        @w_ec_sub_secuencia             int,       --LIM 02/NOV/2005
        @w_campo2                       varchar(20),    -- GAL 07/SEP/2009 - INTERFAZ - CHQCOM
        @w_campo3                       varchar(20),    -- GAL 07/SEP/2009 - INTERFAZ - CHQCOM
        @w_campo4                       varchar(20),    -- GAL 07/SEP/2009 - INTERFAZ - CHQCOM
        @w_campo5                       varchar(20),    -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
        @w_campo6                       varchar(20),    -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
        @w_campo7                       varchar(20),    -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
        @w_tipo_benef                   catalogo,       -- GAL 07/SEP/2009 - INTERFAZ - CHQCOM
        @w_desc_conc_emision            descripcion,    -- GAL 07/SEP/2009 - INTERFAZ - CHQCOM
        @w_mpago_chqcom                 varchar(30),    -- GAL 07/SEP/2009 - INTERFAZ - CHQCOM
        @w_mm_producto                  catalogo,       -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_mt_subtipo_ins               int,            -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_cod_conc_emision             varchar(30),    -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_instr_chqcom                 tinyint,        -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
        @w_instrumento                  tinyint,        -- GAL 22/SEP/2009 - INTERFAZ - CHQCOM
        @w_subtipo_ins                  int,            -- GAL 22/SEP/2009 - INTERFAZ - CHQCOM
        @w_beneficiario                 varchar(255),   -- GAL 22/SEP/2009 - INTERFAZ - CHQCOM
        @w_referencia                   cuenta,         -- GAL 22/SEP/2009 - INTERFAZ - CHQCOM
        @w_area_origen                  smallint,       -- GAL 23/SEP/2009 - INTERFAZ - CHQCOM
        @w_total_gmf                    money,          -- MVG 25/SEP/2009
        @w_instrumento_chger            tinyint,        -- MAL 26/OCT/2009
        @w_subtipo_ins_chger            int,             -- MAL 26/OCT/2009
        @w_embargo						money

select @w_sp_name  = 'sp_emision_cheque',
       @i_en_linea = isnull(@i_en_linea,'S'),
       @w_ofi_ing  = @s_ofi

/**  VERIFICAR CODIGO DE TRANSACCION PARA UPDATE  **/

if ( @i_operacion <> 'U' or  @t_trn <> 14231) and
   ( @i_operacion <> 'Q' or  @t_trn <> 14431) and
   ( @i_operacion <> 'S' or  @t_trn <> 14531) and
   ( @i_operacion <> 'H' or  @t_trn <> 14631)
begin
  exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 141043
  return 141043
end

-------------------------------------
-- Obtener codigo de moneda nacional
-------------------------------------
select @w_moneda_base = em_moneda_base
  from cob_conta..cb_empresa
 where em_empresa = @i_empresa

if @@rowcount = 0
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 601018
   return  601018
end

------------------------------------
-- Busqueda de parametros iniciales
------------------------------------
select @w_filial = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico='FILI'
   and pa_producto='PFI'

select @w_cheque_ger = pa_char
  from cobis..cl_parametro
 where pa_nemonico='NCHG'
   and pa_producto='PFI'

select @w_cheque_pro= pa_char
  from cobis..cl_parametro
 where pa_nemonico='NCHP'
   and pa_producto='PFI'

select @w_efectivo    = pa_char
  from cobis..cl_parametro
 where pa_nemonico='NEFE'
   and pa_producto='PFI'

-------------------------
-- Forma de pago cupones
-------------------------
select @w_cupon = pa_char
  from cobis..cl_parametro
 where pa_nemonico='NCUP'
   and pa_producto='PFI'

select @w_camara = pa_char
  from cobis..cl_parametro
 where pa_nemonico='NCAM'
   and pa_producto='PFI'

--Forma de Pago GIRO
select @w_letra_internacional_1013 = pa_char
  from cobis..cl_parametro
 where pa_nemonico = 'NLI1'
   and pa_producto = 'PFI'

select @w_letra_internacional_CIB = pa_char
  from cobis..cl_parametro
 where pa_nemonico = 'NLIC'
   and pa_producto = 'PFI'

select @w_cheque_compensacion = pa_char
  from cobis..cl_parametro
 where pa_nemonico = 'NGCO'
   and pa_producto = 'PFI'

-- MEDIO DE PAGO CHEQUE COMERCIAL - GAL 07/SEP/2009 - INTERFAZ - CHQCOM
select @w_mpago_chqcom = pa_char
from cobis..cl_parametro
where pa_nemonico = 'CHQCOM'
and   pa_producto = 'PFI'

-- CODIGO DE CONCEPTO DE EMISION DE PAGO PENDIENTE - GAL 05/SEP/2009 - INTERFAZ - CHQCOM
select @w_cod_conc_emision = pa_char
from cobis..cl_parametro
where pa_nemonico = 'EMPAPE'
and   pa_producto = 'PFI'

-- INSTRUMENTO DE SERVICIOS BANCARIOS ASOCIADO CHEQUES COMERCIALES - GAL 05/SEP/2009 - INTERFAZ - CHQCOM
select @w_instr_chqcom = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'INCHCO'
and   pa_producto = 'PFI'

-- INSTRUMENTO CHEQUES DE GERENCIA - MAL 26/OCT/2009
select @w_instrumento_chger = pa_int
from cobis..cl_parametro
where pa_nemonico = 'ICHDG'
and   pa_producto = 'PFI'

-- SUBTIPO INSTRUMENTO CHEQUES DE GERENCIA - MAL 26/OCT/2009
select @w_subtipo_ins_chger = pa_int
from cobis..cl_parametro
where pa_nemonico = 'SICHDG'
and   pa_producto = 'PFI'


------------------------------------------------
-- Seccion para envio de datos de una operacion
------------------------------------------------
if @i_operacion = 'Q'
begin
   select o_fecha_mov       = ec_fecha_mov,              --1
   o_tran            = ec_tran,
   o_operacion       = ec_operacion,
   o_num_banco       = op_num_banco,
   o_beneficiario    = ec_descripcion,               --5
   o_numero          = ec_numero,
   o_valor           = ec_valor,
   o_fecha_emision   = convert(varchar,ec_fecha_emision,@i_formato_fecha),
   o_fecha_crea      = convert(varchar,ec_fecha_crea,@i_formato_fecha),
   o_fecha_mod       = convert(varchar,ec_fecha_mod,@i_formato_fecha), --10
   o_pago            = ec_fpago,                 --11
   o_cod_ente        = op_ente,
   o_fpago           = ec_fpago,
   o_moneda          = ec_moneda,
   o_mm_ente         = mm_beneficiario,              --15
   o_mm_oficina      = mm_oficina,
   o_mm_tipo_cliente = mm_tipo_cliente,               --17
   o_embargo         = case when mm.mm_tipo_cliente = 'E' then (select isnull(substring(ce_direccion,1,5),'') 
                                                                from cob_pfijo..pf_cliente_externo 
                                                                where ce_secuencial =  mm.mm_beneficiario) end     
   from pf_emision_cheque
   inner join  pf_mov_monet mm on
       mm_operacion       = ec_operacion
       and mm_secuencial      = ec_secuencial
       and mm_secuencia       = ec_secuencia
       and mm_sub_secuencia   = ec_sub_secuencia
       left outer join pf_operacion on
          op_operacion    = ec_operacion
   where ec_sub_secuencia = @i_sub_secuencia
   and ec_secuencia       = @i_secuencia
   and ec_operacion       = @i_operacionpf
   and ec_fecha_emision   is null      
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141095
      return 1
   end
   return 0
end

-----------------------
-- Seccion de Busqueda
-----------------------
if @i_operacion = 'S'
begin
   set rowcount 20
   if @i_tipo = 'C'
   begin
      select 'NUM. DEPOSITO' = substring(op_num_banco,1,20),
           'TRANSACCION'     = substring(tn_descripcion,1,25),
           'BENEFICIARIO'    = substring(ltrim(ec_descripcion),1,30),
           'INTERESES A PAGAR' = ec_valor,
           'FECHA SOLICITUD' = rtrim(convert(varchar,ec_fecha_mod,@i_formato_fecha)),
           'OP'              =  ec_operacion,
           'MONEDA'          = ec_moneda,
           'SEC'             =  ec_secuencia,
           'SSEC'            =  ec_sub_secuencia
      from pf_emision_cheque 
      inner join pf_operacion on
         op_operacion    = ec_operacion
         inner join pf_mov_monet on
            ec_operacion = mm_operacion
            and ec_secuencia = mm_secuencia
            and ec_sub_secuencia = mm_sub_secuencia
            and ec_tran = mm_tran
            inner join pf_fpago on
               ec_fpago = fp_mnemonico
               left outer join cobis..cl_ttransaccion on
                  ec_tran = tn_trn_code             
      where datediff(dd,ec_fecha_mov,@i_fecha_mov) >= 0
      and ec_fecha_emision is null
      and fp_automatico = 'C'
      and rtrim(substring(ltrim(ec_descripcion),patindex('[^a-zA-Z]%',ec_descripcion)+1,30)) + ltrim(convert(char(6),mm_operacion+100000)) + ltrim(convert(char(5),mm_secuencia+10000)) > substring(@i_descripcion,patindex('[^a-zA-Z]%', @i_descripcion)+1,30) +
          ltrim(convert(char(6),@i_operacionpf + 100000)) + ltrim(convert(char(5),@i_secuencia + 10000))
      and ec_tipo = 'C'
      and tn_trn_code >14000
      and ec_estado IS NULL
      and fp_estado = 'A'
      and rtrim(ltrim(mm_producto)) not in ('TRANS','SUSP')
      order by    convert(char(6),mm_operacion+100000) + convert(char(5),mm_secuencia + 10000)      
   end

   --------------------------------------------------------
   -- Tomar n·mero de operacion a partir de op_num_banco --
   --------------------------------------------------------
   if @i_num_banco is not null
   begin
       select @w_op_operacion = op_operacion
         from pf_operacion
        where op_num_banco = @i_num_banco

       select @i_operacionpf = @w_op_operacion
   end

   ----------------------------------------------------------------------------
   -- Query Dinamico para desplegar por una operacion especifica o por todas --
   ----------------------------------------------------------------------------
   if @i_tipo = 'E'
   begin

      --print 'w_op_operacion' + cast(@w_op_operacion as varchar(100))
      --print 'i_num_banco' + cast(@i_num_banco as varchar(100))
      --print 'i_operacionpf' + cast(@i_operacionpf as varchar(100))
      --print 'i_secuencia' + cast(@i_secuencia as varchar(100))
      --print 'i_descripcion' + cast(@i_descripcion as varchar(100))


      select 
      'NUM. DEPOSITO'     = substring(op_num_banco,1,20),
      'TRANSACCION'       = substring(tn_descripcion,1,25),
      'BENEFICIARIO'      = substring(ltrim(ec_descripcion),1,30),
      'INTERESES A PAGAR' = ec_valor,
      'FECHA SOLICITUD'   = rtrim(convert(varchar,ec_fecha_mod,@i_formato_fecha)),
      'OP'                = ec_operacion,
      'MONEDA '           = ec_moneda,
      'SEC'               = ec_secuencia,
      'SSEC'              = ec_sub_secuencia,
      'COD. OFICINA'      = mm_oficina,
      'COD. TRANSACCION'  = ec_tran
      from pf_emision_cheque
      inner join pf_operacion on
         op_operacion    = ec_operacion
         inner join pf_mov_monet on
            ec_operacion = mm_operacion
            and ec_secuencia = mm_secuencia
            and ec_sub_secuencia = mm_sub_secuencia
            and ec_tran = mm_tran
            left outer join cobis..cl_ttransaccion on
               ec_tran = tn_trn_code
      where datediff(dd,ec_fecha_mov,@i_fecha_mov) >= 0
      and ec_fecha_emision is null
      and (ec_fpago = @i_forma_pago_inicial or isnull(@i_forma_pago_inicial ,'1') = '1')
       and rtrim(substring(ltrim(ec_descripcion),patindex('[^a-zA-Z]%', ec_descripcion)+1,30)) + ltrim(convert(char(6),mm_operacion+100000)) + ltrim(convert(char(5),mm_secuencia+10000)) > substring(@i_descripcion,patindex('[^a-zA-Z]%', @i_descripcion)+1,30) +
          ltrim(convert(char(6),@i_operacionpf + 100000)) + ltrim(convert(char(5),@i_secuencia + 10000))
      and ec_tipo = 'C'
      and tn_trn_code >14000
      and ec_estado IS NULL
      and mm_estado = 'A'
      and rtrim(ltrim(mm_producto)) not in('TRANS', 'SUSP')
      and ((ec_operacion = @w_op_operacion) or (@w_op_operacion IS NULL))
       order by substring(ec_descripcion,patindex('[^a-zA-Z]%', ec_descripcion)+1,30), convert(char(6),mm_operacion+100000) + convert(char(5),mm_secuencia + 10000)
       
   end

   -----------------------
   -- Busqueda de cupones
   -----------------------
   if @i_tipo = 'U'
   begin
      select 'NUM. DEPOSITO'   = substring(op_num_banco,1,20),
             'TRANSACCION'     = substring(tn_descripcion,1,25) + '-' + isnull(convert(varchar, cu_cuota),'*'),
             'BENEFICIARIO'    = substring(ltrim(ec_descripcion),1,30),
             'VALOR'           = ec_valor,
             'FECHA SOLICITUD' = rtrim(convert(varchar,ec_fecha_mod, @i_formato_fecha)),
             'OP'              =  ec_operacion,
             'MONEDA '         = ec_moneda,
             'SEC'             =  ec_secuencia,
             'SSEC'            =  ec_sub_secuencia
        from pf_emision_cheque 
        inner join pf_mov_monet on
         ec_secuencia = mm_secuencia
         and ec_sub_secuencia = mm_sub_secuencia
         and ec_operacion = mm_operacion
         and ec_tran = mm_tran
         inner join pf_operacion on
            op_operacion    = ec_operacion
            left outer join cobis..cl_ttransaccion on
               ec_tran = tn_trn_code
               left outer join pf_cuotas on
                  cu_operacion = mm_operacion and 
                  cu_fecha_pago = mm_fecha_aplicacion
       where datediff(dd,ec_fecha_mov,@i_fecha_mov) >= 0
         and ec_fecha_emision is null
         and ec_fpago = @w_cupon
         and rtrim(substring(ltrim(ec_descripcion),1,30)) + convert(char(6),mm_operacion+100000) + convert(char(5),mm_secuencia + 10000) >
             substring(@i_descripcion,patindex('[^a-zA-Z]%', @i_descripcion)+1,30) + convert(char(6),@i_operacionpf + 100000) + convert(char(5), @i_secuencia + 10000)
         and ec_tipo = 'C'
         and tn_trn_code >14000
         and ec_estado IS NULL
         and mm_estado = 'A'  --gap DP00008 correccion de error
       order by convert(char(6),mm_operacion+100000) + convert(char(5),mm_secuencia + 10000)            
   end

   set rowcount 0
   return 0
end

----------------
-- Seccion Help
----------------
if @i_operacion = 'H'
begin
   select @i_secuencial = isnull(@i_secuencial,0)
   set rowcount 20
   if @i_tipo = 'C'
   begin
      select Secuencial = ec_secuencial,
             'Num. Deposito' = op_num_banco,
             Numero = ec_numero,
             Valor = ec_valor
      from pf_emision_cheque
      inner join pf_fpago on 
          ec_fpago = fp_mnemonico
          left outer join pf_operacion on
             op_operacion = ec_operacion
       where ec_fecha_mov = @i_fecha_mov
       and ec_secuencial   > @i_secuencial
       and fp_automatico = 'C'          
   end

   if @i_tipo = 'E'
   begin
      select Secuencial = ec_secuencial,
             'Num. Deposito' = op_num_banco,
             Numero = ec_numero,
             Valor = ec_valor
      from pf_emision_cheque
      left outer join pf_operacion on
         op_operacion  = ec_operacion
      where ec_fecha_mov = @i_fecha_mov
      and ec_secuencial  > @i_secuencial
      and ec_fpago       = @w_efectivo          
   end
   if @i_tipo = 'U'
   begin
      select Secuencial = ec_secuencial,
             'Num. Deposito'   = op_num_banco,
             Numero            = ec_numero,
             Valor = ec_valor
      from pf_emision_cheque
      left outer join pf_operacion on
         op_operacion = ec_operacion
      where ec_fecha_mov    = @i_fecha_mov
      and ec_secuencial > @i_secuencial
      and ec_fpago      = @w_cupon
          
   end
   set rowcount 0
   return 0
end

------------------------------
-- Seccion de actualizaciones
------------------------------
if @i_operacion = 'U'
begin
   ----------------------------------------------
   -- Verificar que el cheque no ha sido emitido
   ----------------------------------------------
   if @w_fecha_emision is not null or @w_numero is not null
   begin
      select @w_error = 141096
      exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141096

      select @w_mensaje = 'emitchqueq.sp Error Orden de Pago ya esta emitida'
      select @w_error = 141096
      goto borra
      return 141096
   end

   -------------------------------------------------------------
   -- Seleccion de datos de operacion que origina orden de pago.
   -------------------------------------------------------------
   if @i_en_linea = 'S'
   begin
      select
      @w_producto           = op_producto,
      @w_oficina            = op_oficina,
      @w_toperacion         = op_toperacion,
      @w_tplazo             = op_tipo_plazo,
      @w_operacionpf        = op_operacion,
      @w_estado             = op_estado,
      @w_tcapitalizacion    = op_tcapitalizacion,
      @w_num_banco          = op_num_banco,
      @w_mon_sgte           = op_mon_sgte,
      @w_retieneimp         = op_retienimp,
      @w_historia           = op_historia,
      @w_ppago              = op_ppago,
      @w_fecha_ult_pg_int   = op_fecha_ult_pg_int,
      @w_valor              = ec_valor,
      @w_fpago              = ec_fpago,
      @w_moneda             = ec_moneda,
      @w_op_monto           = ec_monto_cal,
      @w_op_tasa            = ec_tasa_cal,
      @w_op_ente            = op_ente,
      @w_fecha_inicial      = ec_fecha_inicial,    --LIM 17/OCT/2005
      @w_fecha_final        = ec_fecha_final,      --LIM 17/OCT/2005
      @w_ec_tran            = ec_tran,
      @w_embargo            = isnull(op_monto_blq, 0) + isnull(op_monto_blqlegal, 0) + isnull(op_monto_pgdo, 0) + isnull(op_monto_int_blqlegal, 0)
      from pf_emision_cheque
      left outer join pf_operacion on
         op_operacion   = ec_operacion
      where ec_sub_secuencia  = @i_sub_secuencia
      and ec_secuencia        = @i_secuencia
      and ec_operacion        = @i_operacionpf
      and ec_fecha_emision    is null      

      if @@rowcount = 0
      begin
         select @w_mensaje = 'emitcheq.sp NO EXISTE PARA OPERACION '
         select @w_error = 141095
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num = 141095
         goto borra
         return 141095
      end

		/*Validar que el titulo no tenga ningun Valor Bloqueado*/
		if @w_embargo > 0 
		begin
		   select @w_mensaje = 'emision_cheque.sp TRANSACCION NO PERMITRIDA. LA OPERACION TIENE BLOQUEOS '
           select @w_error = 141200
		   exec cobis..sp_cerror 
		        @t_from  = @w_sp_name, 
		        @i_num   = 141200
		   goto borra     
		   return 141200
		end  
		      
      
      if @w_fpago = @w_cheque_ger or @w_fpago = @w_letra_internacional_1013 or @w_fpago =  @w_mpago_chqcom--(GIRO)
         select @w_oficina_emision = isnull(mm_oficina,@w_oficina)   --+-+
         from pf_mov_monet,pf_emision_cheque
         where mm_operacion      = ec_operacion
         and mm_operacion  = @i_operacionpf
         and mm_secuencia  = ec_secuencia
         and mm_sub_secuencia    = ec_sub_secuencia
         and mm_secuencia  = @i_secuencia
         and mm_sub_secuencia    = @i_sub_secuencia
         and ec_fecha_emision    IS NULL
      else
         select @w_oficina_emision = @w_oficina



      --I. CVA Dic/20/05
      if @w_ec_tran not in (14905,14155)
         select @w_op_tasa = 0
      if @w_ec_tran = 14904
         select @w_op_monto = 0
      --F. CVA Dic/20/05

      ------------------------------------------------------
      -- Verificar existencia de operacion que genera emision
      -- orden de pago.
      ------------------------------------------------------
      select
      @w_numero        = ec_numero,
      @w_moneda        = ec_moneda,
      @w_fecha_mod     = ec_fecha_mod,
      @w_descripbenef  = ec_descripcion,
      @w_fpago         = ec_fpago,
      @w_valor         = ec_valor,
      @w_fecha_emision = ec_fecha_emision,
      @w_tran          = ec_tran,
      @w_concepto      = Substring(tn_descripcion,1,25),
      @w_ec_secuencial = ec_secuencial,
      @w_ec_fecha_mov  = ec_fecha_mov
      from pf_emision_cheque
      left outer join cobis..cl_ttransaccion on
         ec_tran = tn_trn_code
      where ec_secuencia    = @i_secuencia
      and ec_sub_secuencia  = @i_sub_secuencia
      and ec_operacion      = @i_operacionpf
      and ec_tipo           = 'C'
      and ec_estado        is null
      if @@rowcount = 0
      begin
         select @w_mensaje = 'emitcheq.sp NO EXISTE PARA OPERACION '
         select @w_error = 141095
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 141095
         goto borra
         return 141095
      end
   end   -- @i_en_linea = 'S'
   else  -- @i_en_linea = 'N'
   begin
   ------------------------------------------------------
   -- Verificar existencia de operacion que genera emision
   -- orden de pago.
   ------------------------------------------------------
      select 
      @w_numero             = ec_numero,
      @w_moneda             = ec_moneda,
      @w_fecha_mod          = ec_fecha_mod,
      @w_descripbenef       = ec_descripcion,
      @w_fpago              = ec_fpago,
      @w_valor              = ec_valor,
      @w_fecha_emision      = ec_fecha_emision,
      @w_tran               = ec_tran,
      @w_concepto           = substring(tn_descripcion,1,25),
      @w_ec_secuencial      = ec_secuencial,
      @w_ec_fecha_mov       = ec_fecha_mov,
      @w_producto           = op_producto,
      @w_oficina            = op_oficina,
      @w_toperacion         = op_toperacion,
      @w_tplazo             = op_tipo_plazo,
      @w_operacionpf        = op_operacion,
      @w_estado             = op_estado,
      @w_tcapitalizacion    = op_tcapitalizacion,
      @w_num_banco          = op_num_banco,
      @w_mon_sgte           = op_mon_sgte,
      @w_retieneimp         = op_retienimp,
      @w_historia           = op_historia,
      @w_ppago              = op_ppago,
      @w_op_monto           = ec_monto_cal,
      @w_op_tasa            = ec_tasa_cal,
      @w_fecha_ult_pg_int   = op_fecha_ult_pg_int,
      @w_op_ente            = op_ente,               -- GAL 07/SEP/2009 - INTERFAZ - CHQCOM
      @w_fecha_inicial      = ec_fecha_inicial,      --LIM 17/OCT/2005
      @w_fecha_final        = ec_fecha_final         --LIM 17/OCT/2005
      from pf_emision_cheque with ( index = pf_emision_cheque_Key)
      inner join pf_operacion on
         ec_operacion  = op_operacion
         left outer join cobis..cl_ttransaccion on
            ec_tran  = tn_trn_code
      where op_operacion      = @i_operacionpf
      and   ec_secuencia      = @i_secuencia
      and   ec_sub_secuencia  = @i_sub_secuencia
      and   ec_tipo           = 'C'
      and   ec_estado        is null      
   end

   select @w_monto_var = convert(varchar(30),@w_op_monto),
          @w_tasa_var  = convert(varchar(20),@w_op_tasa) --LIM

   begin tran

   ---------------------------------------------------------------------------------
   -- Cambiar el estado de los registros que genera la(s) nueva(s) forma(s) de pago
   -- en las tablas respectivas.
   ---------------------------------------------------------------------------------
   if @i_en_linea = 'S'
      select @w_estado_update = 'E'
   else
      select @w_estado_update = 'A'   --Aplicado

   update pf_emision_cheque
   set    ec_estado         = @w_estado_update,
          ec_fecha_emision  = @s_date
   where ec_operacion     = @w_operacionpf
   and   ec_secuencial    = @w_ec_secuencial
   and   ec_secuencia     = @i_secuencia
   and   ec_sub_secuencia = @i_sub_secuencia

   if @@error <> 0
   begin
   --print '@w_ec_secuencial %1!, @i_secuencia %2!, @i_sub_secuencia %3!', @w_ec_secuencial, @i_secuencia, @i_sub_secuencia
      select @w_mensaje = 'emitcheq.sp error en actualizacion pf_emision_cheque '
      select @w_error = 145031
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 145031
      goto borra
      return 145031
   end

   if @i_en_linea = 'S' --CVA Feb-14-06 Solo para en Linea
   begin
      select @w_ofi_ing = isnull(mm_oficina,@s_ofi)
      from pf_mov_monet
      where mm_operacion     = @w_operacionpf
      and   mm_secuencial    = @w_ec_secuencial
      and   mm_sub_secuencia = @i_sub_secuencia
   end

   update pf_mov_monet
   set    mm_estado        = @w_estado_update,
          mm_usuario       = @s_user
   where mm_operacion     = @w_operacionpf
   and   mm_secuencia     = @w_ec_secuencial
   and   mm_sub_secuencia = @i_sub_secuencia

   if @@error <> 0
   begin
      select @w_mensaje = 'emitcheq.sp error en actualizacion pf_mov_monet '
      select @w_error = 145020
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 145020
      goto borra
      return 145020
   end

   ----------------------------------------
   -- Insercion de movimientos monetarios
   ----------------------------------------
   select @w_usadeci = mo_decimales
   from cobis..cl_moneda
   where mo_moneda = @w_moneda
   if @w_usadeci = 'S'
   begin
      select @w_numdeci = isnull (pa_tinyint,0)
      from cobis..cl_parametro
      where pa_nemonico = 'DCI'
      and   pa_producto = 'PFI'
   end
   else
      select @w_numdeci = 0

   ----------------------------------
   -- Para el bloque de pf_mov_monet
   ----------------------------------
   select @w_cont = 0

   if @i_flag_divide = 0
      select @w_mt_sub_secuencia = 0
   else
      select @w_mt_sub_secuencia = @i_secuencia

   ----------------------------------------------------------------
   -- Proceso para ingresar el nuevo detalle de pago en pf_de_pago
   ----------------------------------------------------------------
   select @w_pt_beneficiario = 0,
          @w_pt_secuencia    = 0,
          @w_valor_contabiliza  = @w_valor,
          @w_mt_producto     = ''


if @t_debug = 'S' print '@i_en_linea ' + cast (@i_en_linea as varchar)


   if @i_en_linea = 'S'
   begin
      while 1 = 1
      begin

      
      
         ----------------------------------------------------------------------
         -- Leer nuevos registros que se generan al desglosar la orden de pago
         ----------------------------------------------------------------------
         set rowcount 1
         select @w_mt_producto         = mt_producto,
                @w_mt_sub_secuencia    = mt_sub_secuencia,
                @w_mt_tipo             = mt_tipo,
                @w_mt_beneficiario     = mt_beneficiario,
                @w_mt_impuesto         = mt_impuesto,
                @w_mt_cuenta           = mt_cuenta,
                @w_mt_valor            = mt_valor,
                @w_mt_valor_ext        = mt_valor_ext,
                @w_mt_moneda           = mt_moneda,
                @w_mt_fecha_crea       = mt_fecha_crea,
                @w_mt_fecha_mod        = mt_fecha_mod,
                @w_mt_tipo_cliente     = mt_tipo_cliente,
                @w_mt_cotizacion       = mt_cotizacion,
                @w_mt_tipo_cotiza      = mt_tipo_cotiza,
                @w_mt_oficina          = mt_oficina,         -- LIM 11/NOV/2005
                @w_mt_tipo_cuenta_ach  = mt_tipo_cuenta_ach, -- CVA May-02-06
                @w_mt_banco_ach        = mt_cod_banco_ach,   -- CVA May-02-06
                @w_benef_chq           = mt_benef_corresp,
                @w_mt_subtipo_ins      = mt_subtipo_ins      -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
         from pf_mov_monet_tmp
         where mt_usuario        = @s_user
         and   mt_sesion         = @s_sesn
         and   mt_operacion      = @w_operacionpf
         and   mt_sub_secuencia >= @w_mt_sub_secuencia
         order by mt_sub_secuencia

         select @w_rowcount = @@rowcount
         --select @w_mt_sub_secuencia = @w_mt_sub_secuencia + 1                  --LIM Comentado

         if @w_rowcount = 1
         begin
            select @w_cont = @w_cont + 1
            select @w_mt_valor = round(@w_mt_valor, @w_numdeci)
            select @w_mt_impuesto = round(@w_mt_impuesto, @w_numdeci)
            select @w_mt_valor_ext = round(@w_mt_valor_ext, @w_numdeci)
            select @w_mon_sgte_conta = @w_mon_sgte

            if @w_mt_oficina is null
               select @w_mm_oficina = @s_ofi
            else
               select @w_mm_oficina = @w_mt_oficina

            -----------------------------------------------
            -- Inserta en la tabla definitiva pf_mov_monet
            -----------------------------------------------
            --print '@w_mt_producto %1!', @w_mt_producto

		--print '@w_mt_subtipo_ins = ' + cast(@w_mt_subtipo_ins as varchar)

		
		    if  @w_mt_producto = 'EFEC'
      			select @w_mt_cuenta = @w_ec_secuencial 

		
            insert into  pf_mov_monet (mm_operacion,          mm_tran,            mm_secuencia      , mm_secuencial,
                                       mm_sub_secuencia,      mm_producto,        mm_cuenta         , mm_valor,
                                       mm_tipo,               mm_beneficiario,    mm_impuesto       , mm_moneda,
                                       mm_valor_ext,          mm_fecha_crea,      mm_fecha_mod      , mm_fecha_aplicacion,
                                       mm_estado,             mm_oficina,         mm_fecha_real     , mm_user,
                                       mm_tipo_cliente,       mm_cotizacion,      mm_tipo_cotiza    , mm_usuario,
                                       mm_tipo_cuenta_ach,    mm_cod_banco_ach,   mm_benef_corresp  , mm_subtipo_ins) --CVA May-02-06
                               values (@w_operacionpf,        14943,              @w_mon_sgte       , @i_secuencial,
                                       @w_mt_sub_secuencia,   @w_mt_producto,     @w_mt_cuenta      , @w_mt_valor,
                                       @w_mt_tipo,            @w_mt_beneficiario, @w_mt_impuesto    , @w_mt_moneda,
                                       @w_mt_valor_ext,       @s_date,            @s_date           , null,
                                       null,                  @w_mt_oficina,      getdate()         , @s_user,  --LIM 11/NOV/2005
                                       @w_mt_tipo_cliente,    @w_mt_cotizacion,   @w_mt_tipo_cotiza , @s_user,
                                       @w_mt_tipo_cuenta_ach, @w_mt_banco_ach,    @w_benef_chq      , @w_mt_subtipo_ins) --CVA May-02-06

            /* Si no se puede insertar, error */
            if @@error <> 0
            begin
                exec cobis..sp_cerror
                   @t_debug        = @t_debug,
                   @t_file         = @t_file,
                   @i_num          = 143022

                return 143022
            end

            select @w_producto_pago = fp_producto
            from   pf_fpago
            where  fp_mnemonico = @w_mt_producto


            if @w_producto_pago in (0, 3, 4, 7, 9, 42, 165,14) --CVA May-12-06 Faltaba TC
            begin

               select @w_fecha_inicial_d = convert(datetime,@w_fecha_inicial,103),
                      @w_fecha_final_d   = convert(datetime,@w_fecha_final,103)

               exec @w_return = sp_aplica_mov
                    @s_ssn           = @s_ssn,
                    @s_user          = @s_user,
                    @s_ofi           = @s_ofi,
                    @s_date          = @s_date,
                    @s_srv           = @s_srv,
                    @s_term          = @s_term,
                    @t_file          = @t_file,
                    @t_from          = @w_sp_name,
                    @t_debug         = @t_debug,
                    @i_fecha_proceso = @s_date, --CVA Oct-19-05
                    @t_trn           = 14943, --@w_tran,
                    @i_tipo          = 'N',
                    @i_operacionpf   = @w_operacionpf,
                    @i_secuencia     = @w_mon_sgte,
                    @i_sub_secuencia = @w_mt_sub_secuencia,
                    @i_en_linea      = @i_en_linea,
                    @i_transferencia = @i_transferencia, -- Indica si se est  emitiendo una transferencia
                    @i_refconcep     = @i_refconcep,
                    @i_fecha_valor   = @s_date,
                    @i_dirord        = @i_dirord,
                    @i_benefi        = @w_benef_chq,
                    @i_dirben        = @i_dirben,
                    @i_ref_opc       = @i_ref_opc,
                    @i_conben        = @i_conben,
                    @i_paiben        = @i_paiben,
                    @i_ciuben        = @i_ciuben,
                    @i_bcoben        = @i_bcoben,
                    @i_ofiben        = @i_ofiben,
                    @i_tdirben       = @i_tdirben, -- Direccion ABA / 'S' Direccion SWIFT. MANDATORIO
                    @i_nomben        = @i_nomben,  -- Nombre del Banco Beneficiario.
                    @i_instruccion   = @i_instruccion,
                    @i_bcoint        = @i_bcoint,
                    @i_ofiint        = @i_ofiint,
                    @i_tdirint       = @i_tdirint, -- Direccion ABA / 'S' Direccion SWIFT (corresponsal)
                    @i_nomint        = @i_nomint,
                    @i_tr_cod_transf = @i_tr_cod_transf,
                    @i_dp_sec_orig   = 0,          -- Marca que permite identificar los registros nuevos generados
                    @i_fecha_inicial = @w_fecha_inicial_d,   --LIM 17/OCT/2005
                    @i_fecha_final   = @w_fecha_final_d,      --LIM 17/OCT/2005
                    @o_secuencial    = @o_secuencial out      -- Nuevo secuencial asignado a registros nuevos

               if @w_return <> 0
               begin
                  exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = @w_return

                  return @w_return
               end

               select @w_ec_fecha_caja = @s_date,
                      @w_caja = 'S'
            end    -- @w_producto_pago in(0, 3, 4, 7, 9, 42)

            if @w_mt_cotizacion = 0     --LIM 17/NOV/2005
               select @w_mt_cotizacion = 1
            if isnull(@w_mt_valor_ext ,0) = 0
               select @w_mt_valor_ext = @w_mt_valor / @w_mt_cotizacion

            ----------------------------------------------------------------------------------------------
            -- Se coloca la secuencia de pf_emision_cheque para reversos en caja y se graba mm_fecha_real
            ----------------------------------------------------------------------------------------------
            update pf_mov_monet set
               mm_secuencia_emis_che = @i_secuencia,
               mm_estado             = 'A',
               mm_fecha_aplicacion   = @s_date,
               mm_sec_mov	     = @i_sub_secuencia
            where mm_operacion     = @w_operacionpf
            and   mm_tran          = 14943 --@w_tran
            and   mm_secuencia     = @w_mon_sgte
            and   mm_sub_secuencia = @w_mt_sub_secuencia

            exec @w_sec = sp_gen_sec

            insert into ts_mov_monet (secuencial        , tipo_transaccion, clase       , fecha,
                                      usuario           , terminal        , srv         , lsrv,
                                      operacion         , transaccion     , secuencia   , sub_secuencia,
                                      producto          , cuenta          , valor       , tipo,
                                      beneficiario      , impuesto        , moneda      , valor_ext,
                                      fecha_crea        , fecha_mod       , estado)
                             values  (@w_sec            , @t_trn          , 'N'         , @s_date,
                                      @s_user           , @s_term         , @s_srv      , @s_lsrv,
                                      @w_operacionpf    , @t_trn          , @w_mon_sgte , @w_mt_sub_secuencia,
                                      @w_mt_producto    , @w_mt_cuenta    , @w_mt_valor , @w_mt_tipo,
                                      @w_mt_beneficiario, @w_mt_impuesto  , @w_mt_moneda, @w_mt_valor_ext,
                                      @s_date           , @s_date         , null)

            if @@error <> 0
            begin
               exec cobis..sp_cerror
                  @t_debug       = @t_debug,
                  @t_file        = @t_file,
                  @t_from        = @w_sp_name,
                  @i_num         = 143005

               return 143005
            end
         end -- Fin de If @@rowcount = 1
         else -- caso contrario de if rowcount = 1
         begin
            if @w_cont = 0
            begin
               exec cobis..sp_cerror
                  @t_debug  = @t_debug,
                  @t_file   = @t_file,
                  @t_from   = @w_sp_name,
                  @i_num    = 141036

               return 141036
            end
            else -- caso contrario de @w_cont = 0
            begin
               set rowcount 0
               break
            end
         end --fin caso contrario (else rowcount = 1)

         -------------------------------------------------
         -- Verificar si hubo cambio de moneda en el pago
         -------------------------------------------------
         if @w_mt_moneda = @w_moneda_base
            select @w_valor = @w_mt_valor
         else
            select @w_valor = @w_mt_valor_ext

         select @w_op_moneda = @w_moneda
         select @w_moneda = @w_mt_moneda

         -------------------------------------------------------------------------
         -- Interface para emision de cheque de gerencia con Servicios bancarios
         -- Se envia a SBA de acuerdo al producto de la forma de pago
         -------------------------------------------------------------------------
         select @w_producto_fpago = fp_producto,
                @w_area_contable  = fp_area_contable
         from   pf_fpago
         where  fp_mnemonico = @w_mt_producto

         if @@error <> 0
         begin
            exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 141111

            return 141111
         end

	--print '@w_producto_fpago = ' + cast (@w_producto_fpago as varchar)
	--print '@i_flag_sbancarios = ' + cast (@i_flag_sbancarios as varchar)

         if @w_producto_fpago = 42 and (@i_flag_sbancarios = 0)
         begin
            if @w_area_contable is null
            begin
               select @w_area_contable = td_area_contable
               from pf_tipo_deposito
               where td_mnemonico = @w_toperacion

               if @@error <> 0
               begin
                  exec cobis..sp_cerror
                     @t_debug        = @t_debug,
                     @t_file         = @t_file,
                     @t_from         = @w_sp_name,
                     @i_num          = 141115

                  return 141115
               end
            end

            if @i_idlote = 0
            begin
               exec   @w_idlote    = cob_interfase..sp_isba_cseqnos    -- BRON: 15/07/09  cob_sbancarios..sp_cseqnos
                      @i_tabla     = 'sb_identificador_lotes',
                      @o_siguiente = @w_numero out

               select @i_idlote    = @w_numero --xca

            end
            else
            begin
               select @w_idlote = @i_idlote
            end

            ----------------------------------
            -- Informacion de parametrizacion
            ----------------------------------
            if @w_mt_producto = @w_cheque_ger
               if @w_moneda = @w_moneda_base and @w_filial = 1
                  select @w_parametro = 'CHQML'
               else
                  select @w_parametro = 'CHQME'

            if @w_mt_producto = @w_mpago_chqcom                -- GAL 08/SEP/2009 - RVVUNICA
               select @w_parametro = 'CHQCOM'

            if @w_parametro IS NULL
            begin
               exec cobis..sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 141169

               return 141169
            end

            select @w_campo47 = tn_descripcion
            from   cobis..cl_ttransaccion
            where  tn_trn_code = @w_tran

            select @w_campo48 = 'DEPOSITO A PLAZO ' + @w_num_banco

            select @w_campo1 = 'PFI'

            if @w_mt_producto = @w_cheque_ger
               select @w_campo40 = 'E'

            ------------------------------------------------------------------
            -- Tomar el codigo del concepto asignado a DPF en catalogo se SBA
            ------------------------------------------------------------------

            select @w_conceptosb = convert(tinyint,codigo)
            from   cobis..cl_catalogo
            where  tabla in (select codigo
                             from   cobis..cl_tabla
                             where  tabla = 'sb_conceptos_implot')
            and    valor = 'DPF'


            select @w_descripbenef =  @w_benef_chq

            -- INICIO - GAL 07/SEP/2009 - INTERFAZ - CHQCOM

            if @w_mt_producto in (@w_mpago_chqcom , @w_cheque_ger)
            begin
               -- OBTENER DATOS DEL TITULAR DEL CREDITO
               select @w_campo1 = en_tipo_ced + '-' + en_ced_ruc,             -- TIPO Y NUMERO DEL TITULAR EJ. CC-79876543
                      @w_campo2 = en_nomlar                                   -- NOMBRE TITULAR
               from   cobis..cl_ente
               where  en_ente = @w_op_ente

               -- OBTENER DATOS DEL BENEFICIARIO
               if @w_mt_tipo_cliente = 'M' begin                              -- ESTA EN COBIS..CL_ENTE
                  select @w_campo3     		= en_tipo_ced + '-' + en_ced_ruc,         -- TIPO Y NUMERO DEL BENEFICIARIO EJ. CC-79876545
                         @w_beneficiario     	= en_nomlar,                              -- NOMBRE BENEFICIARIO
                         @w_tipo_benef = c_tipo_compania
                  from   cobis..cl_ente
                  where  en_ente = @w_mt_beneficiario
               end else begin
                  select @w_campo3     		= ce_cedula,                              -- NUMERO DEL BENEFICIARIO 
                         @w_beneficiario 	= ce_nombre                               -- NOMBRE BENEFICIARIO
                  from   pf_cliente_externo
                  where  ce_secuencial = @w_mt_beneficiario
               end
   
               select @w_tipo_benef = isnull(nullif(ltrim(rtrim(@w_tipo_benef)), ''), 'PA')

               select @w_desc_conc_emision = valor
               from cobis..cl_tabla T, cobis..cl_catalogo C
               where T.tabla  = 'cc_concepto_emision'
               and   C.tabla  = T.codigo
               and   C.codigo = @w_cod_conc_emision

              if @w_mt_producto = @w_mpago_chqcom
              begin
                  select
                     @w_instrumento  = @w_instr_chqcom,
                     @w_subtipo_ins  = @w_mt_subtipo_ins 
              end

              if @w_mt_producto = @w_cheque_ger
              begin
                  select
                     @w_instrumento  = @w_instrumento_chger,
                     @w_subtipo_ins  = @w_subtipo_ins_chger
              end

		if @t_debug = 'S' print '@w_mt_producto ' + cast (@w_mt_producto as varchar)
		if @t_debug = 'S' print '@w_mpago_chqcom ' + cast (@w_mpago_chqcom as varchar)
		if @t_debug = 'S' print '@w_instrumento ' + cast (@w_instrumento as varchar)
		if @t_debug = 'S' print '@w_subtipo_ins ' + cast (@w_subtipo_ins as varchar)
		if @t_debug = 'S' print '@w_mt_subtipo_ins ' + cast (@w_mt_subtipo_ins as varchar)




               select
                  @w_campo5       = @w_num_banco,                               -- NUMERO PLAZO FIJO (CONOCIDO POR EL CLIENTE)
                  @w_campo6       = @w_cod_conc_emision,                        -- CÓDIGO CONCEPTO DE EMISION
                  @w_campo7       = @w_desc_conc_emision,                       -- DESCRIPCION CONCEPTO DE EMISION
                  @w_campo4	  = @w_beneficiario,
                  @w_referencia   = cast(@w_operacionpf as varchar),
                  @w_area_origen  = 99

		if @t_debug = 'S' print '@w_campo5 ' + cast (@w_campo5 as varchar)
		if @t_debug = 'S' print '@w_campo6 ' + cast (@w_campo6 as varchar)
		if @t_debug = 'S' print '@w_campo7 ' + cast (@w_campo7 as varchar)
		if @t_debug = 'S' print '@w_beneficiario ' + cast (@w_beneficiario as varchar)
		if @t_debug = 'S' print '@w_referencia ' + cast (@w_referencia as varchar)

            end
            else
            begin
               select
                  @w_beneficiario = @w_descripbenef,
                  @w_referencia   = @w_num_banco,
                  @w_campo2       = @w_concepto,          -- descripcion de la transaccion
                  @w_campo4       = @w_fecha_inicial,     -- PCOELLO CAMBIA CAMPO 3 POR 4
                  @w_campo5       = @w_fecha_final,       -- PCOELLO CAMBIA CAMPO 4 POR 5
                  @w_campo6       = @w_tasa_var,          -- Tasa
                  @w_campo7       = @w_monto_var,         -- Monto
                  @w_area_origen  = 90
            end

            exec @w_return = cob_interfase..sp_isba_imprimir_lotes     -- BRON: 15/07/09  cob_sbancarios..sp_imprimir_lotes
                 @s_ssn              = @s_ssn,
                 @s_user             = @s_user,
                 @s_term             = @s_term,
                 @s_date             = @s_date,
                 @s_srv              = @s_srv,
                 @s_lsrv             = @s_lsrv,
                 @s_ofi              = @s_ofi,
                 @t_debug            = @t_debug,
                 @t_trn              = 29334,
                 @i_oficina_origen   = @w_oficina_emision,  --+-+ @s_ofi, --CVA Ene-19-06 Oficina de sistema
                 @i_ofi_destino      = @w_mt_oficina,       -- LIM 14/NOV/2005
                 @i_area_origen      = @w_area_origen,
                 @i_func_solicitante = 0,
                 @i_fecha_solicitud  = @s_date,
                 @i_producto         = 4,
                 @i_instrumento      = @w_instrumento,
                 @i_subtipo          = @w_subtipo_ins,
                 @i_valor            = @w_valor,
                 @i_beneficiario     = @w_beneficiario,
                 @i_referencia       = @w_referencia,
                 @i_tipo_benef       = @w_tipo_benef,
                 @i_campo1           = @w_campo1,
                 @i_campo2           = @w_campo2,
                 @i_campo3           = @w_campo3,
                 @i_campo4           = @w_campo4,
                 @i_campo5           = @w_campo5,
                 @i_campo6           = @w_campo6,
                 @i_campo7           = @w_campo7,
                 @i_campo8           = @w_campo48,          -- 'DEPOSITO A PLAZO ' + @w_num_banco
                 @i_observaciones    = @w_campo47,          -- PAGO DE INTERESES PERIODICOS
                 @i_llamada_ext      = 'S',
                 @i_concepto         = @w_conceptosb,       -- CATALOGO DE SERVICIOS BANCARIOS (3)
                 @i_fpago            = @w_mt_producto,      -- NUEVO REQUERIMIENTO SBA (NEMONICO DE LA FORMA DE PAGO)
                 @i_moneda           = @w_mt_moneda,
                 @i_origen_ing       = '3',
                 @i_idlote           = @w_numero,           -- SECUENCIAL DEL SEQNOS DE SERVICIOS BANCARIOS
                 @i_estado           = 'D',
                 @i_campo21          = 'PFI',
                 @i_campo22          = 'D',
                 @i_campo40          = @w_campo40,
                 @o_idlote           = @w_idlote out,
                 @o_secuencial       = @w_secuencial_cheque out

            if @w_return <>0
            begin
               exec cobis..sp_cerror
                    @t_debug        = @t_debug,
                    @t_file         = @t_file,
                    @t_from         = @w_sp_name,
                    @i_num          = 141168

               return 141168
            end

            -- FIN - GAL 23/SEP/2009 - INTERFAZ - CHQCOM

            --print 'emitcheq.sp IDLOTE %1! SEC_CHEQU %2! NUMERO %3! ',@w_idlote, @w_secuencial_cheque, @w_numero
            select @w_caja          = 'S',
                   @w_ec_fecha_caja = @s_date

         end  --    If (@w_producto_fpago = 42) and @i_flag_sbancarios = 0
         else
         begin
            select @w_caja              = NULL,
                   @w_ec_fecha_caja     = NULL,
                   @w_secuencial_cheque = @i_numero  -- GES 09/05/01 DP-000054
         end

         if @w_mt_moneda <> @w_moneda_base
         begin
            -------------------------------------------
            -- Actualizar el ultimo registro insertado
            -------------------------------------------
            update pf_emision_cheque set
               ec_numero          = @w_idlote,
               ec_estado          = 'A',
               ec_fecha_emision   = @s_date,
               ec_fecha_mod       = @s_date,
               ec_fecha_real      = getdate(),
               ec_caja            = @w_caja,
               ec_fecha_caja      = @w_ec_fecha_caja,
               ec_fpago           = @w_mt_producto,
               ec_valor           = @w_mt_valor_ext,
               ec_moneda          = @w_mt_moneda,
               ec_secuencial_lote = @w_secuencial_cheque,     --LIM 14/OCT/2005
               ec_subtipo_ins     = @w_subtipo_ins         -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
            where ec_secuencia     = @w_mon_sgte_conta
            and   ec_sub_secuencia = @w_mt_sub_secuencia
            and   ec_operacion     = @w_operacionpf
            and   ec_tipo         is not null

            if @@rowcount = 0
            begin
--print '@w_mon_sgte_conta %1!, @w_mt_sub_secuencia %2!, @w_operacionpf %3!', @w_mon_sgte_conta, @w_mt_sub_secuencia, @w_operacionpf
--print 'emitcheq.sp ENTRA ERROR2'
               select @w_error = 145031

               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 145031

               goto borra
               return 145031
            end
         end
         else
         begin
            if (@w_producto_pago <> 3 and @w_producto_pago <> 4 and @w_producto_pago <> 165)   --LIM 25/NOV/2005
            begin


		if @t_debug = 'S' print ' @w_producto_pago ' +  cast( @w_producto_pago as varchar)

	 	if (@w_producto_pago = 42)
		begin
               		update pf_emision_cheque set
                  		ec_numero          = @w_idlote
               		where ec_secuencia       = @w_mon_sgte_conta
               		and   ec_sub_secuencia   = @w_mt_sub_secuencia
               		and   ec_operacion       = @w_operacionpf
               		and   ec_tipo           is not null

               		if @@error <> 0
               		begin
                  		--print 'emitcheq.sp ENTRA ERROR3'
                  		select @w_error = 145031

                  		exec cobis..sp_cerror
                     			@t_debug = @t_debug,
                     			@t_file  = @t_file,
                     			@t_from  = @w_sp_name,
                     			@i_num   = 145031
                  		goto borra

                  		return 145031
               		end
		end

               -------------------------------------------
               -- Actualizar el ultimo registro insertado
               -------------------------------------------
               --print 'emitcheq.sp SECUENCIA %1! SUB_SEC %2! OPERACION %3! ',@w_mon_sgte_conta, @w_mt_sub_secuencia, @w_operacionpf

               update pf_emision_cheque set
                  ec_estado          = 'A',
                  ec_fecha_emision   = @s_date,
                  ec_fecha_mod       = @s_date,
                  ec_fecha_real      = getdate(),
                  ec_caja            = @w_caja,
                  ec_fecha_caja      = @w_ec_fecha_caja,
                  ec_fpago           = @w_mt_producto,
                  ec_valor           = @w_mt_valor,
                  ec_moneda          = @w_mt_moneda,
                  ec_secuencial_lote = @w_secuencial_cheque,        --LIM  14/OCT/2005
                  ec_subtipo_ins     = @w_subtipo_ins         -- GAL 08/SEP/2009 - INTERFAZ - CHQCOM
               where ec_secuencia       = @w_mon_sgte_conta
               and   ec_sub_secuencia   = @w_mt_sub_secuencia
               and   ec_operacion       = @w_operacionpf
               and   ec_tipo           is not null

               if @@error <> 0
               begin
                  --print 'emitcheq.sp ENTRA ERROR3'
                  select @w_error = 145031

                  exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = 145031
                  goto borra

                  return 145031
               end
            end
         end

         ----------------------------------------
         -- Insercion de transaccion de servicio
         ----------------------------------------
         insert ts_emision_cheque (secuencial    , tipo_transaccion, clase         , usuario,
                                   terminal      , srv             , lsrv          , fecha,
                                   operacion     , numero          , descripcion   , fecha_emision,
                                   fecha_mod     , fpago)
                           values (@s_ssn        , @t_trn          , 'P'           , @s_user,
                                   @s_term       , @s_srv          , @s_lsrv       , @s_date,
                                   @i_operacionpf, @w_numero       , @w_descripcion, @w_fecha_emision,
                                   @w_fecha_mod  , @w_mt_producto)
         if @@error <> 0
         begin
             select @w_error = 143005
             exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 143005
             goto borra
             return 143005
         end

         insert ts_emision_cheque (secuencial    , tipo_transaccion, clase         , usuario,
                                   terminal      , srv             , lsrv          , fecha,
                                   operacion     , numero          , descripcion   , fecha_emision,
                                  fecha_mod)
                           values (@s_ssn        , @t_trn          , 'A'           , @s_user,
                                   @s_term       , @s_srv          , @s_lsrv       , @s_date,
                                   @i_operacionpf, @i_numero       , @i_descripcion, @s_date,
                                   @s_date)

         if @@error <> 0
         begin
            select @w_error = 143005
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 143005
            goto borra
            return 143005
         end

         -------------------------------------
         -- Ingreso de datos a la pf_historia
         -------------------------------------
         select @w_historia = op_historia
         from   pf_operacion
         where  op_operacion = @i_operacionpf

         insert pf_historia (hi_operacion,   hi_secuencial,  hi_fecha,   hi_trn_code,
                             hi_valor,       hi_funcionario, hi_oficina, hi_observacion,
                             hi_fecha_crea,  hi_fecha_mod,   hi_cupon)
                      values(@i_operacionpf, @w_historia,    @s_date,    14759,
                             @w_valor,       @s_user,        @s_ofi,     'CREAR ORDEN DE PAGO',
                             @s_date,        @s_date,        @w_cu_cuota)
         if @@error <> 0
         begin
            select @w_error = 143006
            exec cobis..sp_cerror
               @t_debug= @t_debug,
               @t_file = @t_file,
               @t_from = @w_sp_name,
               @i_num  = 143006
            goto borra
            return 143006
         end

         update pf_operacion
         set    op_historia  = op_historia + 1
         where  op_operacion = @i_operacionpf

         if @@error <> 0
         begin
             --print 'emitcheq.sp ERROR AL ACTUALIZAR PF_OPERACION'
             select @w_error = 145001
             exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 145001
             goto borra
             return 145001
         end

         select @w_historia = op_historia
         from   pf_operacion
         where  op_operacion = @i_operacionpf

         ------------------------------------------------
         -- Actualizacion de cupon si se realizo el pago
         ------------------------------------------------
         if @w_fpago = @w_cupon and (@w_mt_producto = @w_camara or @i_producto_pago = 3 or @i_producto_pago = 4 or @w_mt_producto = @w_cheque_ger)
         begin
            insert ts_cuotas (secuencial      , tipo_transaccion, clase       , usuario,
                              terminal        , srv             , lsrv        , fecha,
                              operacion       , cuota           , fecha_mod   , fecha_caja,
                              forma_pago      , estado)
                      values (@s_ssn          , 14146           , 'A'         , @s_user,
                              @s_term         , @s_srv          , @s_lsrv     , @s_date,
                              @i_operacionpf  , @w_cu_cuota     , @w_fecha_mod, @w_cu_fecha_caja,
                              @w_cu_forma_pago, @w_cu_estado)
            if @@error <> 0
            begin
               select @w_error = 143005
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 143005
               goto borra
               return 143005
            end

            update pf_cuotas
            set    cu_fecha_caja = @s_date,
                   cu_estado_ant = @w_cu_estado,
                   cu_estado     = 'P',
                   cu_fecha_mod  = @s_date,
                   cu_forma_pago = @w_mt_producto
            where  cu_operacion = @i_operacionpf
            and  cu_fecha_pago = @w_ec_fecha_mov

            if @@error <> 0
            begin
               select @w_error = 145043
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 145043
               goto borra
               return 145043
            end

            insert ts_cuotas (secuencial    , tipo_transaccion, clase    , usuario,
                              terminal      , srv             , lsrv     , fecha,
                              operacion     , cuota           , fecha_mod, fecha_caja,
                              forma_pago    , estado)
                      values (@s_ssn        , 14146           , 'A'      , @s_user,
                              @s_term       , @s_srv          , @s_lsrv  , @s_date,
                              @i_operacionpf, @w_cu_cuota     , @s_date  , @s_date,
                              @w_mt_producto , 'CAN')

            if @@error <> 0
            begin
               select @w_error = 143005
               exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 143005
               goto borra
               return 143005
            end
         end  --@w_fpago = @w_cupon

         if @w_caja = 'S'
         begin
            insert pf_historia (hi_operacion  , hi_secuencial , hi_fecha  , hi_trn_code,
                                hi_valor      , hi_funcionario, hi_oficina, hi_observacion,
                                hi_fecha_crea , hi_fecha_mod  , hi_cupon)
                        values (@i_operacionpf, @w_historia   , @s_date   , @t_trn,
                                @w_valor      , @s_user       , @s_ofi    , 'FORMA DE PAGO ENVIADA',
                                @s_date       , @s_date       , @w_cu_cuota)

            if @@error <> 0
            begin
               select @w_error = 143006
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 143006
               goto borra
               return 143006
            end

            select @w_historia = @w_historia + 1

            update pf_operacion
            set    op_historia = @w_historia
            where  op_operacion = @i_operacionpf

            if @@error <> 0
            begin
               --print 'emitcheq.sp ERROR AL ACTUALIZAR PF_OPERACION_2'
               select @w_error = 145001
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 145001
               goto borra
               return 145001
            end
         end

         select @w_mt_sub_secuencia = @w_mt_sub_secuencia + 1        --LIM 02/NOV/2005
      end --while 1=1 insertar a pf_det_pago
   end -- @i_en_linea = 'S'
   else   -- SE DISPARA DESDE EL BATCH
   begin
      select @w_op_moneda = @w_moneda
      -------------------------------------------------------------------------
      -- Interface para emision de cheque de gerencia con Servicios bancarios
      -- Se envia a SBA de acuerdo al producto de la forma de pago
      -------------------------------------------------------------------------
      select @w_producto_fpago = fp_producto,
             @w_area_contable  = fp_area_contable
      from   pf_fpago
      where  fp_mnemonico = @w_fpago

      if @@error <> 0
      begin
         select @w_mensaje = 'emitcheq.sp Forma de pago no tiene interfaz con SBA '
         select @w_error = 141111
         exec cobis..sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @w_sp_name,
              @i_num          = 141111
         goto borra
         return 141111
      end

      if (@w_producto_fpago = 42) and (@i_flag_sbancarios = 0)
      begin
         if @w_area_contable IS NULL
         begin
            select @w_area_contable = td_area_contable
            from   pf_tipo_deposito
            where  td_mnemonico = @w_toperacion

            if @@error <> 0
            begin
               select @w_error = 141115
               exec cobis..sp_cerror
                    @t_debug        = @t_debug,
                    @t_file         = @t_file,
                    @t_from         = @w_sp_name,
                    @i_num          = 141115
               goto borra
               return 141115
            end
         end

         if @i_idlote = 0
         begin
            exec @w_idlote = cob_interfase..sp_isba_cseqnos    -- BRON: 15/07/09  cob_sbancarios..sp_cseqnos
               @i_tabla     = 'sb_identificador_lotes',
               @o_siguiente = @w_numero out

            select @w_idlote    = @w_numero --xca
         end
         else
         begin
            select @w_idlote = @i_idlote
         end

         ----------------------------------
         -- Informacion de parametrizacion
         ----------------------------------
--print 'emitcheq.sp FPAGO_BATCH %1! ',@w_fpago
         if @w_fpago = @w_cheque_ger
            if @w_moneda = @w_moneda_base and @w_filial = 1
               select @w_parametro = 'CHQML'
            else
               select @w_parametro = 'CHQME'

         if @w_fpago = @w_letra_internacional_1013
            select @w_parametro = 'CGBCDI'

         if @w_fpago = @w_letra_internacional_CIB
            select @w_parametro = 'EMGCID'

         if @w_parametro IS NULL
         begin
            select @w_error = 141169
            exec cobis..sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = 141169
            goto borra
            return 141169
         end

         -----------------------------------------------
         -- Inserta en la tabla definitiva pf_mov_monet
         -----------------------------------------------
         select @w_mm_oficina      = mm_oficina,
                @w_mt_tipo_cliente = mm_tipo_cliente,
                @w_pt_beneficiario = mm_beneficiario,
                @w_mt_producto      = mm_producto,
                @w_benef_chq       = mm_benef_corresp,
                @w_mt_subtipo_ins  = mm_subtipo_ins
         from   pf_mov_monet
         where mm_operacion     = @w_operacionpf
         and   mm_secuencial    = @w_ec_secuencial
         and   mm_secuencia     = @i_secuencia
         and   mm_sub_secuencia = @i_sub_secuencia
         and   mm_tran          = 14905



if @t_debug = 'S' print 'OFF lINE w_mt_tipo_cliente ' + cast ( @w_mt_tipo_cliente as varchar)
if @t_debug = 'S' print 'OFF lINE @w_mt_beneficiario' + cast ( @w_mt_beneficiario as varchar)
if @t_debug = 'S' print 'OFF lINE @w_tipo_benef ' + cast ( @w_tipo_benef as varchar)



         insert into  pf_mov_monet (mm_operacion,        mm_tran,            mm_secuencia      , mm_secuencial,
                                    mm_sub_secuencia,    mm_producto,        mm_cuenta         , mm_valor,
                                    mm_tipo,             mm_beneficiario,    mm_impuesto       , mm_moneda,
                                    mm_valor_ext,        mm_fecha_crea,      mm_fecha_mod      , mm_fecha_aplicacion,
                                    mm_estado,           mm_oficina,         mm_fecha_real     , mm_user,
                                    mm_tipo_cliente,     mm_cotizacion,      mm_tipo_cotiza    , mm_usuario, mm_benef_corresp)
                            values (@w_operacionpf,      14943,              @w_mon_sgte       , @s_ssn,
                                    0,                   @w_fpago,           null              , @w_valor,
                                    'C',                 @w_pt_beneficiario, 0                 , @w_moneda,
                                    0,                   @s_date,            @s_date           , @s_date,
                                    'A',                 @w_mm_oficina,      getdate()         , @s_user,
                                    @w_mt_tipo_cliente,  1,                  'N'               , @s_user, @w_benef_chq)

         /* Si no se puede insertar, error */
         if @@error <> 0
         begin
            select @w_error = 143022
            exec cobis..sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @i_num          = 143022
            goto borra
            return 143022
         end

         select @w_campo47 = tn_descripcion
         from   cobis..cl_ttransaccion
         where  tn_trn_code = @w_tran

         select @w_campo48 = 'DEPOSITO A PLAZO ' + @w_num_banco

         select @w_campo1 = 'PFI'

         if @w_fpago = @w_cheque_ger
            select @w_campo40 = 'E'

         ------------------------------------------------------------------
         -- Tomar el codigo del concepto asignado a DPF en catalogo se SBA
         ------------------------------------------------------------------

         select @w_conceptosb = convert(tinyint,codigo)
         from   cobis..cl_catalogo
         where  tabla in (select codigo
                          from   cobis..cl_tabla
                          where  tabla = 'sb_conceptos_implot')
         and    valor  = 'DPF'

         select @w_descripbenef =  @w_benef_chq

         -- INICIO - MAL - 28/OCT/2009 INTERFACE CHEQUES DE GERENCIA

         if @w_mt_producto in (@w_mpago_chqcom , @w_cheque_ger)
         begin
            -- OBTENER DATOS DEL TITULAR DEL CREDITO
            select @w_campo1 = en_tipo_ced + '-' + en_ced_ruc,             -- TIPO Y NUMERO DEL TITULAR
                   @w_campo2 = en_nomlar                                   -- NOMBRE TITULAR
            from   cobis..cl_ente
            where  en_ente = @w_op_ente


if @t_debug = 'S' print 'OFF lINE w_mt_tipo_cliente ' + cast ( @w_mt_tipo_cliente as varchar)
if @t_debug = 'S' print 'OFF lINE @w_mt_beneficiario' + cast ( @w_mt_beneficiario as varchar)
if @t_debug = 'S' print 'OFF lINE @w_tipo_benef ' + cast ( @w_tipo_benef as varchar)


            -- OBTENER DATOS DEL BENEFICIARIO
            if @w_mt_tipo_cliente = 'M' begin                              -- ESTA EN COBIS..CL_ENTE
               select @w_campo3     	= en_tipo_ced + '-' + en_ced_ruc,         -- TIPO Y NUMERO DEL BENEFICIARIO EJ. CC-79876545
                      @w_beneficiario   = en_nomlar,                              -- NOMBRE BENEFICIARIO
                      @w_tipo_benef = c_tipo_compania
               from   cobis..cl_ente
               where  en_ente = @w_pt_beneficiario
            end else begin
               select @w_campo3     	= ce_cedula,                              -- NUMERO DEL BENEFICIARIO 
                      @w_beneficiario	= ce_nombre                               -- NOMBRE BENEFICIARIO
               from   pf_cliente_externo
               where  ce_secuencial = @w_pt_beneficiario
            end
            select @w_tipo_benef = isnull(nullif(ltrim(rtrim(@w_tipo_benef)), ''), 'PA')

            select @w_desc_conc_emision = valor
            from   cobis..cl_tabla T, cobis..cl_catalogo C
            where  T.tabla  = 'cc_concepto_emision'
            and    C.tabla  = T.codigo
            and    C.codigo = @w_cod_conc_emision


           if @w_mt_producto = @w_mpago_chqcom
           begin
               select
               @w_instrumento  = @w_instr_chqcom,
               @w_subtipo_ins  = @w_mt_subtipo_ins
           end

           if @w_mt_producto = @w_cheque_ger
           begin
               select
               @w_instrumento  = @w_instrumento_chger,
               @w_subtipo_ins  = @w_subtipo_ins_chger
           end

            select
            @w_campo5       = @w_num_banco,                               -- NUMERO PLAZO FIJO (CONOCIDO POR EL CLIENTE)
            @w_campo6       = @w_cod_conc_emision,                        -- CÓDIGO CONCEPTO DE EMISION
            @w_campo7       = @w_desc_conc_emision,                       -- DESCRIPCION CONCEPTO DE EMISION
            @w_campo4 	    = @w_beneficiario ,
            @w_referencia   = cast(@w_operacionpf as varchar),
            @w_area_origen  = 99
         end --@w_mt_producto in (@w_mpago_chqcom , @w_cheque_ger)
         else
         begin
            select
            @w_beneficiario = @w_descripbenef,
            @w_referencia   = @w_num_banco,
            @w_campo2       = @w_concepto,          -- descripcion de la transaccion
            @w_campo4       = @w_fecha_inicial,     -- PCOELLO CAMBIA CAMPO 3 POR 4
            @w_campo5       = @w_fecha_final,       -- PCOELLO CAMBIA CAMPO 4 POR 5
            @w_campo6       = @w_tasa_var,          -- Tasa
            @w_campo7       = @w_monto_var,         -- Monto
            @w_area_origen  = 90
         end


if @t_debug = 'S' print 'OFF lINE @w_beneficiario ' + cast (@w_beneficiario as varchar)
if @t_debug = 'S' print 'OFF lINE @w_campo4 ' + cast ( @w_campo4 as varchar)
if @t_debug = 'S' print 'OFF lINE @w_tipo_benef ' + cast ( @w_tipo_benef as varchar)



         exec @w_return = cob_interfase..sp_isba_imprimir_lotes
         @s_ssn              = @s_ssn,
         @s_user             = @s_user,
         @s_term             = @s_term,
         @s_date             = @s_date,
         @s_srv              = @s_srv,
         @s_lsrv             = @s_lsrv,
         @s_ofi              = @s_ofi,
         @t_debug            = @t_debug,
         @t_trn              = 29334,
         @i_oficina_origen   = @w_oficina,       --@w_oficina_emision,
         @i_ofi_destino      = @w_mm_oficina,
         @i_area_origen      = @w_area_origen,
         @i_func_solicitante = 0,
         @i_fecha_solicitud  = @s_date,
         @i_producto         = 4,
         @i_instrumento      = @w_instrumento,
         @i_subtipo          = @w_subtipo_ins,
         @i_valor            = @w_valor,
         @i_beneficiario     = @w_beneficiario,
         @i_referencia       = @w_referencia,
         @i_tipo_benef       = @w_tipo_benef,
         @i_campo1           = @w_campo1,
         @i_campo2           = @w_campo2,
         @i_campo3           = @w_campo3,
         @i_campo4           = @w_campo4,
         @i_campo5           = @w_campo5,
         @i_campo6           = @w_campo6,
         @i_campo7           = @w_campo7,
         @i_campo8           = @w_campo48,          -- 'DEPOSITO A PLAZO ' + @w_num_banco
         @i_observaciones    = @w_campo47,          -- PAGO DE INTERESES PERIODICOS
         @i_llamada_ext      = 'S',
         @i_concepto         = @w_conceptosb,       -- CATALOGO DE SERVICIOS BANCARIOS (3)
         @i_fpago            = @w_mt_producto,      -- NUEVO REQUERIMIENTO SBA (NEMONICO DE LA FORMA DE PAGO)
         @i_moneda           = @w_moneda, --@w_mt_moneda,
         @i_origen_ing       = '3',
         @i_idlote           = @w_numero,           -- SECUENCIAL DEL SEQNOS DE SERVICIOS BANCARIOS
         @i_estado           = 'D',
         @i_campo21          = 'PFI',
         @i_campo22          = 'D',
         @i_campo40          = @w_campo40,
         @o_idlote           = @w_idlote out,
         @o_secuencial       = @w_secuencial_cheque out

         if @w_return <>0
         begin
            exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 141168
            
            return 141168
         end

         -- FIN - MAL - 28/OCT/2009 INTERFACE CHEQUES DE GERENCIA


--print 'emitcheq.sp IDLOTE %1! SEC_CHEQU %2! NUMERO %3! ',@w_idlote, @w_secuencial_cheque, @w_numero
         select @w_caja          = 'S',
                @w_ec_fecha_caja = @s_date

      end  --    If (@w_producto_fpago = 42) and @i_flag_sbancarios = 0
      else
      begin
         select @w_caja              = NULL,
                @w_ec_fecha_caja     = NULL,
                @w_secuencial_cheque = @i_numero  -- GES 09/05/01 DP-000054
      end
	-------------------------------------------------
	--	Actualizo Mov Monet con lotes de SB
	-------------------------------------------------
if @t_debug = 'S' print 'EMITCH OFF lINE @w_secuencial_cheque ' + cast (@w_secuencial_cheque as varchar)
if @t_debug = 'S' print 'EMITCH OFF lINE @w_mon_sgte ' + cast ( @w_mon_sgte as varchar)
if @t_debug = 'S' print 'EMITCH OFF lINE @s_ssn ' + cast ( @s_ssn as varchar)


	update	pf_mov_monet
	set	mm_secuencial_lote 	= @w_secuencial_cheque ,
		mm_subtipo_ins 		= @w_subtipo_ins 
	where	mm_operacion		= @w_operacionpf
	and	mm_tran 		= 14943
	and	mm_secuencia		= @w_mon_sgte
	and	mm_secuencial		= @s_ssn
	and	mm_sub_secuencia	= 0

      	if @@error <> 0
      	begin
         	select @w_error = 143006
         	exec cobis..sp_cerror
              		@t_debug= @t_debug,
              		@t_file = @t_file,
              		@t_from = @w_sp_name,
              		@i_num  = 145000
         	goto borra
         	return 145000
      	end

      -------------------------------------
      -- Ingreso de datos a la pf_historia ?????
      -------------------------------------
      select @w_historia = op_historia
      from   pf_operacion
      where  op_operacion = @i_operacionpf

      insert pf_historia (hi_operacion,   hi_secuencial,  hi_fecha,   hi_trn_code,
                          hi_valor,       hi_funcionario, hi_oficina, hi_observacion,
                          hi_fecha_crea,  hi_fecha_mod,   hi_cupon)
                   values(@i_operacionpf, @w_historia,    @s_date,    14759,
                          @w_valor,       @s_user,        @s_ofi,     'CREAR ORDEN DE PAGO',
                          @s_date,        @s_date,        @w_cu_cuota)
      if @@error <> 0
      begin
         select @w_error = 143006
         exec cobis..sp_cerror
              @t_debug= @t_debug,
              @t_file = @t_file,
              @t_from = @w_sp_name,
              @i_num  = 143006
         goto borra
         return 143006
      end

      update pf_operacion
      set    op_historia  = op_historia + 1
      where  op_operacion = @i_operacionpf

      if @@error <> 0
      begin
         select @w_error = 145001
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 145001
         goto borra
         return 145001
      end

      select @w_historia = op_historia
      from   pf_operacion
      where  op_operacion = @i_operacionpf

      ------------------------------------------------
      -- Actualizacion de cupon si se realizo el pago
      ------------------------------------------------
      if @w_fpago = @w_cupon and (@w_mt_producto = @w_camara or @i_producto_pago = 3 or @i_producto_pago = 4 or @w_mt_producto = @w_cheque_ger)
      begin
         insert ts_cuotas (secuencial      , tipo_transaccion, clase       , usuario,
                           terminal        , srv             , lsrv        , fecha,
                           operacion       , cuota           , fecha_mod   , fecha_caja,
                           forma_pago      , estado)
                   values (@s_ssn          , 14146           , 'A'         , @s_user,
                           @s_term         , @s_srv          , @s_lsrv     , @s_date,
                           @i_operacionpf  , @w_cu_cuota     , @w_fecha_mod, @w_cu_fecha_caja,
                           @w_cu_forma_pago, @w_cu_estado)
         if @@error <> 0
         begin
            select @w_error = 143005
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 143005
            goto borra
            return 143005
         end

         update pf_cuotas
         set    cu_fecha_caja = @s_date,
                cu_estado_ant = @w_cu_estado,
                cu_estado     = 'P',
                cu_fecha_mod  = @s_date,
                cu_forma_pago = @w_fpago
         where cu_operacion  = @i_operacionpf
         and   cu_fecha_pago = @w_ec_fecha_mov

         if @@error <> 0
         begin
            select @w_error = 145043
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 145043
            goto borra
            return 145043
         end

         insert ts_cuotas (secuencial    , tipo_transaccion, clase    , usuario,
                           terminal      , srv             , lsrv     , fecha,
                           operacion     , cuota           , fecha_mod, fecha_caja,
                           forma_pago    , estado)
                   values (@s_ssn        , 14146           , 'A'      , @s_user,
                           @s_term       , @s_srv          , @s_lsrv  , @s_date,
                           @i_operacionpf, @w_cu_cuota     , @s_date  , @s_date,
                           @w_fpago      , 'CAN')

         if @@error <> 0
         begin
            select @w_error = 143005
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 143005
            goto borra
            return 143005
         end
      end  --@w_fpago = @w_cupon

      if @w_caja = 'S'
      begin
         insert pf_historia (hi_operacion  , hi_secuencial , hi_fecha  , hi_trn_code,
                             hi_valor      , hi_funcionario, hi_oficina, hi_observacion,
                             hi_fecha_crea , hi_fecha_mod  , hi_cupon)
                     values (@i_operacionpf, @w_historia   , @s_date   , @t_trn,
                             @w_valor      , @s_user       , @s_ofi    , 'FORMA DE PAGO ENVIADA',
                             @s_date       , @s_date       , @w_cu_cuota)

         if @@error <> 0
         begin
            select @w_error = 143006
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 143006
            goto borra
            return 143006
         end

         select @w_historia = @w_historia + 1

         update pf_operacion
         set    op_historia = @w_historia
         where  op_operacion = @i_operacionpf

         if @@error <> 0
         begin
            select @w_error = 145001
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 145001
            goto borra
            return 145001
         end
      end
   end  -- SE DISPARA DESDE EL BATCH

   --------------------------------------------------------------------------------------------------------
   -- Actualizacion del secuencial (op_mon_sgte) que sirve como bandera para el secuencial de pf_mov_monet
   --------------------------------------------------------------------------------------------------------
   update pf_operacion
   set op_mon_sgte   =  op_mon_sgte + 1,
       op_fecha_mod  =  @s_date
   where  op_operacion  =  @w_operacionpf

   /* Si no se puede modificar, error */
   if @@rowcount <> 1
   begin
      select @w_error = 145001
      exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 145001
      goto borra
      return 145001
   end

   -----------------------------------
   -- Contabilizacion de la operacion
   -----------------------------------


--  print 'NYM OJO @i_contabiliza %1! @w_tran %2! @w_fpago %3! @w_cheque_ger %4! w_mon_sgte_conta %5! ', @i_contabiliza, @w_tran, @w_fpago, @w_cheque_ger, @w_mon_sgte_conta

   if  @i_contabiliza = 'S'
   begin
      --print '@w_tran = ' + cast(@w_tran as varchar(6))
      --print '@w_mon_sgte = ' + cast(@w_mon_sgte as varchar(6))
      select
      @w_descripcion    = 'EMISION ORDEN DE PAGO ('+ @w_num_banco + ')',
      @w_tran_conta     = 14943,
      @w_afectacion     = 'N',
      @w_codval         = '27',
      @w_debcred        = '1',
      @w_movmonet       = '1'

      select @w_fecha = @s_date
      select @w_string = 'Antes de Aplica_conta'

      if @w_tran in (14903,14904,14905)
        begin

                     
         /* CALCULO EL VALOR A CONTABILIZAR POR EMERGENCIA ECONOMICA GMF */
         exec @w_return = sp_valor_gmf
         @t_trn          = 14943,
         @s_date         = @s_date,
         @i_tran         = @w_tran, --14905. 14904,14903,
         @i_operacionpf  = @w_operacionpf,
         @i_secuencia    = @w_mon_sgte,
         @o_valor_iee    = @w_total_gmf out

         if @w_return <> 0 begin
            exec cobis..sp_cerror
            @t_from          = @w_sp_name,
            @i_num           = @w_return

            goto borra
         end
      end
   
      --print '@w_total_gmf = '  + cast(@w_total_gmf as varchar(10)) 
      
      exec @w_return = cob_pfijo..sp_aplica_conta
      @s_date               = @s_date,
      @s_user               = @s_user,
      @s_term               = @s_term,
      @s_ofi                = @s_ofi,
      @i_fecha              = @w_fecha,
      @i_tran               = 14943,
      @i_oficina_oper       = @w_ofi_ing,
      @i_operacionpf        = @w_operacionpf,
      @i_oficina            = @w_oficina,
      @i_afectacion         = @w_afectacion,  --'N',               -- N=Normal,  R=Reverso
      @i_descripcion        = @w_descripcion,
      @i_valor              = @w_valor_contabiliza,             -- Valor total del registro desglosado
      @i_secuencia          = @w_mon_sgte, -- Toma reg. de sec. adec
      @i_impuesto_emerg_eco = @w_total_gmf,
      @o_comprobante        = @o_comprobante out

      if @w_return <> 0
      begin
         /* Error en contabilizacion de la operacion */
         exec cobis..sp_cerror
         @t_from          = @w_sp_name,
         @i_num           = @w_return

         goto borra

         return @w_return
      end

      --------------------------------
      -- Insertar en pf_relacion_comp
      --------------------------------
      insert into pf_relacion_comp values (@w_num_banco, @o_comprobante, @w_tran_conta, 'PGINT', 'N', @w_mon_sgte, 0, @w_fecha)
   end --contabiliza = 'S'

   commit tran

   ---------------------------------------------------------
   -- Actualizo dp_secuencial de nuevos registros generados
   ---------------------------------------------------------
   set rowcount 0
   update pf_det_pago set dp_secuencial = @o_secuencial
   where dp_operacion  = @i_operacionpf
   and   dp_secuencial = 0

   ----------------------------------------------
   -- Actualizo el numero del cheque al registro
   ----------------------------------------------

if @t_debug = 'S' print 'EMITCH OFF lINE @i_en_linea ' + cast ( @i_en_linea as varchar)


if @i_en_linea = 'S'
begin

   select @w_count = count(*)
   from   pf_emision_cheque
   where ec_secuencial = @o_secuencial
   and   ec_operacion  = @w_operacionpf

   if @w_count > 0
   begin
      select
         @w_ec_secuencia     = 0,
         @w_contador         = 1,
         @w_ec_sub_secuencia = 0


      while @w_contador <= @w_count
      begin
         set rowcount 1

         select @w_ec_numero        = ec_numero,
                @w_ec_secuencia     = ec_secuencia,
                @w_sec_lote         = ec_secuencial_lote,
                @w_ec_sub_secuencia = ec_sub_secuencia,    --LIM 02/NOV/2005
                @w_mt_subtipo_ins   = ec_subtipo_ins
         from   pf_emision_cheque
         where  ec_secuencial    = @o_secuencial
         and    ec_operacion     = @w_operacionpf
         and    ec_sub_secuencia > @w_ec_sub_secuencia      --LIM 02/NOV/2005

         -- INICIO - GAL 08/SEP/2009 - RVVUNICA
         select @w_mm_producto = mm_producto
         from pf_mov_monet
         where mm_operacion     = @w_operacionpf
         and   mm_secuencial    = @o_secuencial
         and   mm_secuencia     = @w_ec_secuencia
         and   mm_sub_secuencia = @w_ec_sub_secuencia
         -- FIN - GAL 08/SEP/2009 - RVVUNICA


         if @w_mm_producto in( @w_mpago_chqcom,@w_cheque_ger)                -- GAL 08/SEP/2009 - RVVUNICA
         begin
            update pf_mov_monet set
               mm_subtipo_ins     = @w_mt_subtipo_ins,
               mm_secuencial_lote = @w_sec_lote
            where mm_operacion     = @w_operacionpf
            and   mm_secuencial    = @o_secuencial
            and   mm_secuencia     = @w_ec_secuencia
            and   mm_sub_secuencia = @w_ec_sub_secuencia     --LIM 02/NOV/2005
         end
         else                                                -- GAL 08/SEP/2009 - RVVUNICA
         begin
            update pf_mov_monet
            set mm_num_cheque  = @w_sec_lote
            where mm_operacion     = @w_operacionpf
            and   mm_secuencial    = @o_secuencial
            and   mm_secuencia     = @w_ec_secuencia
            and   mm_sub_secuencia = @w_ec_sub_secuencia     --LIM 02/NOV/2005
         end

         select @w_contador = @w_contador + 1
      end
      set rowcount 0
   end
end

end /* fin de update */

set rowcount 0

delete pf_det_pago_tmp
where dt_usuario      = @s_user
and   dt_operacion    = @w_operacionpf

delete from pf_mov_monet_tmp
where mt_usuario       = @s_user
and   mt_operacion     = @w_operacionpf

return 0  --CVA Oct-13-05

----------------------------
-- Elminacion de Temporales
----------------------------
borra:
   ----------------------------------------------
   -- Borra el registro de las tablas temporales
   ----------------------------------------------

   delete pf_det_pago_tmp
   where dt_usuario      = @s_user
   and   dt_operacion    = @w_operacionpf

   delete from pf_mov_monet_tmp
   where mt_usuario       = @s_user
   and   mt_operacion     = @w_operacionpf

      
   if @@error <> 0
   begin
      rollback
      exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 147022
      return 147022
   end
 
   if @i_en_linea = 'N'
   begin
      if @w_mensaje is null
         select @w_mensaje = mensaje from cobis..cl_errores where numero = @w_error

   exec sp_errorlog
      @i_fecha       = @s_date,
      @s_date        = @s_date,
      @i_error       = @w_error,
      @i_usuario     = @s_user,
      @i_tran        = @t_trn,
      @i_cuenta      = @w_num_banco,
      @i_descripcion = @w_mensaje
   end

   set rowcount 0


return 0
go
