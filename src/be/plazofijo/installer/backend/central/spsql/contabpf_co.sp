/*****************************************************************************/
/*  ARCHIVO:         aplica_conta_co.sp                                      */
/*  NOMBRE LOGICO:   sp_aplica_conta                                         */
/*  PRODUCTO:        Depositos a Plazo Fijo                                  */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                               PROPOSITO                                   */
/* Ingresar las transacciones a contabilizar y reportar (REC) para Colombia  */
/*****************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where type = 'P' and name = 'sp_aplica_conta')
   drop proc sp_aplica_conta
go

create proc sp_aplica_conta
@s_user                 login           = 'reentry',
@s_ofi                  int             = null,
@s_date                 datetime        = null,
@s_term                 varchar(30)     = null,

@s_ssn                  int             = null, --A ELIMINAR
@s_srv                  varchar(30)     = null, --A ELIMINAR
@t_file                 varchar(10)     = null, --A ELIMINAR
@t_from                 varchar(32)     = null, --A ELIMINAR
@t_debug                char(1)         = 'N',  --A ELIMINAR
@t_rty                  char(1)         = 'N',  --A ELIMINAR

@t_trn                  int             = null,
@i_fecha                datetime,
@i_tran                 int             = null,
@i_operacionpf          int,
@i_afectacion           char(1)         = 'N',
@i_anulacion            char(1)         = 'N',
@i_tipo_trn             catalogo        = null,
@i_oficina_oper         smallint        = null,
@i_oficina_new          smallint        = null,     -- Para matenimiento de depositos
@i_tplazo               catalogo        = null,
@i_tplazo_old           catalogo        = null,     -- Para caso cambio de tipo de plazo en prorrogas ral 05/07/2003
@i_secuencia            int             = null,
@i_valor                money           = 0,
@i_incremento           money           = 0,
@i_monto                money           = 0,
@i_intvenc              money           = 0,
@i_impuesto             money           = 0,
@i_ica                  money           = 0,        -- NYM DPF00015 ICA
@i_ente_endoso          int             = null,
@i_fusfra               char(3)         = 'NNN',    -- Valores:FUS, FRA, NNN
@i_impuesto_emerg_eco   money           = 0,        -- NYM PF00013 IEECOLBM
@i_ente                 int             = null,     -- 05-Jul-2001 xca
@i_descripcion          descripcion     = null,

/* A ELIMINAR */
@i_sub_secuencia        tinyint         = null,     -- por cambio de perfiles
@i_en_linea             char(1)         = 'S',
@i_empresa              tinyint         = 1,
@i_fecha_cotiz          datetime        = null,
@i_producto             tinyint         = null,
@i_oficina              int             = null,
@i_toperacion_new       catalogo        = null,     --+-+ Para matenimiento de depositos
@i_toperacion           catalogo        = null,
@i_operacionpf_old      int             = null,
@i_decremento           money           = 0,
@i_incr_ext             money           = 0,
@i_valor_cap            money           = 0,        -- valor a capitalizar
@i_vuelto               char(1)         = 'N',
@i_fp_compen            catalogo        = null,
@i_monto_problema       money           = 0,        --
@i_penal                money           = 0,        -- Penalizacion de Interes
@i_penaliza_capital     money           = 0,        -- Penalizacion de Capital
@i_forma_pago           catalogo        = null,
@i_cont                 smallint        = null,
@i_fecha_tran           datetime        = null,
@i_conta_prov_dia       char(1)         = 'S',          -- NYM 04-Ene-2001 paramtetriacion contabilizacion de provision
@i_intven_pesos         money           = 0,
@i_fpago                catalogo        = null,
@i_estado               catalogo        = null,     -- GAL 22/AGO/2009 - CSQL
@i_codval               varchar(20)     = null,     -- GAL 22/AGO/2009 - CSQL
@i_movmonet             char(1)         = null,     -- GAL 22/AGO/2009 - CSQL
@i_debcred              char(1)         = null,     -- GAL 22/AGO/2009 - CSQL
@i_vuelto_act           money           = null,     -- GAL 22/AGO/2009 - CSQL
@i_retieneimp           char(1)         = null,     -- GAL 22/AGO/2009 - CSQL
@i_tipo                 char(1)         = null,     -- GAL 22/AGO/2009 - CSQL
@i_vuelto_ren           money           = null,     -- GAL 22/AGO/2009 - CSQL
@i_intren               money           = null,     -- GAL 22/AGO/2009 - CSQL
@i_tot_tran             money           = null,     -- GAL 22/AGO/2009 - CSQL
@i_total_pagar          money           = null,     -- GAL 22/AGO/2009 - CSQL
@i_estado_act           catalogo        = null,     -- GAL 22/AGO/2009 - CSQL
@i_con_movmonet         char(1)         = null,     -- GAL 22/AGO/2009 - CSQL
@i_flag_pgdo_blq        tinyint         = null,     -- GAL 22/AGO/2009 - CSQL
@i_moneda               tinyint         = null,     -- GAL 22/AGO/2009 - CSQL
@i_moneda_pg            tinyint         = null,     -- GAL 22/AGO/2009 - CSQL
@i_moneda_pago          tinyint         = null,     -- GAL 22/AGO/2009 - CSQL
@i_batch                char(1)         = null,     -- GAL 22/AGO/2009 - CSQL
@i_valor_pago           money           = null,     -- GAL 22/AGO/2009 - CSQL
@i_inicio               int             = null,     -- GAL 22/AGO/2009 - CSQL
@i_fin                  int             = null,     -- GAL 22/AGO/2009 - CSQL
@i_valor_eop_chlo       money           = null,     -- PRM 25/MAR/2015 - REQ 432 se recibe el valor por EOP por pago mixto en apertura CDT
@i_valor_eop_cdt_can    money           = null,     -- PRM 25/MAR/2015 - REQ 432 se recibe el valor por EOP por cancelacion de CDT
@i_valor_eop_decre      money           = null,     -- PRM 25/MAR/2015 - REQ 432 se recibe el valor por EOP por decremento

@o_msg                  descripcion     = null  out,
@o_comprobante          int             = null  out -- Comprobante de salida
with encryption
as
declare
@w_commit               char(1),
@w_error                int,
@w_msg                  descripcion,
@w_codvalor             int,
@w_gmf                  varchar(10),
@w_forma_pago           varchar(10),
@w_tasa_gmf             float,
@w_numdeci              tinyint,
@w_ica                  varchar(10),
@w_capitalizacion       varchar(10),
@w_retfuente            varchar(10),
@w_tipo_trn             varchar(10),
@w_op_num_banco         cuenta,
@w_op_num_dias          smallint,
@w_op_oficina           int,
@w_op_moneda            tinyint,
@w_ente                 int,
@w_rubro                catalogo,
@w_valor                money,
@w_secuencial           int,
@w_aux_new              varchar(24),
@w_aux_old              varchar(24),
@w_operacionpf          int,
@w_valor_cap            money,
@w_valor_int            money,
@w_valor_gmf            money,
@w_op_ente              int,
@w_comprobante          int,
@w_op_tcapitalizacion	varchar(5),
@w_aux_cod_val		int,
@w_op_padre             int,--DFNIETOP REQ329
@w_ente_padre           int, --DFNIETOP REQ329
@w_operacion_new        int,
@w_monto_excento        money, -- NYM NR 309 
@w_op_ente_pa           int,
@w_count_benef_papa     int,
@w_cliente              int,    --DESACOPLE LAZ
@w_cuenta               cuenta  --DESACOPLE LAZ


set rowcount 0

select @w_commit  = 'N'

   
select @w_gmf = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'GMF'
and    pa_producto = 'PFI'

if @@rowcount = 0 begin
   select @w_error = 141140, @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL GMF'
   goto ERROR
end

select @w_ica = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'ICA'
and    pa_producto = 'PFI'

if @@rowcount = 0 begin
   select @w_error = 141140, @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL ICA'
   goto ERROR
end

select @w_capitalizacion = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'CAPIT'
and    pa_producto = 'PFI'

if @@rowcount = 0 begin
   select @w_error = 141140, @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL CAPIT'
   goto ERROR
end

select @w_retfuente = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'RETFUE'
and    pa_producto = 'PFI'

if @@rowcount = 0 begin
   select @w_error = 141140, @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL RETFUE'
   goto ERROR
end

/* TASA DEL IMPUESTO */
select @w_tasa_gmf =  pa_float
from   cobis..cl_parametro
where  pa_nemonico  = 'IMDB'
and    pa_producto  = 'PFI'

if @@rowcount = 0 begin
   select @w_error = 141140, @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL IMDB'
   goto ERROR
end

select @w_forma_pago  = pa_char
from   cobis..cl_parametro
where  pa_nemonico    = 'VXP'
and    pa_producto = 'PFI'

if @@rowcount = 0 begin
   select @w_error = 141140, @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL VXP'
   goto ERROR
end

/* NUMERO DE DECIMALES */
select @w_numdeci = isnull (pa_tinyint,0)
from cobis..cl_parametro
where pa_nemonico = 'DCI'
and   pa_producto = 'PFI'

if @@rowcount = 0 begin
   select @w_error = 141140, @w_msg = 'NO SE ENCUENTRA EL PARAMETRO GENERAL DCI'
   goto ERROR
end


if @i_tipo_trn is null begin 
   /* SE OBTIENE EL CODIGO DEL TIPO DE TRANSACCION */
   select @w_tipo_trn = tp_tipo_trn
   from   pf_tranperfil
   where  tp_tran   = @i_tran
   and    tp_estado = @i_afectacion

   if @@rowcount = 0 begin
      select
      @w_error = 149050,
      @w_msg   = 'NO EXISTE TIPO TRN. ASOCIADO A: '+ convert(varchar, @i_tran)

      goto ERROR
   end
end else begin
   select @w_tipo_trn = @i_tipo_trn
end

select
@w_op_num_banco = op_num_banco,
@w_op_num_dias  = op_num_dias,
@w_op_oficina   = op_oficina,
@w_op_moneda    = op_moneda,
@w_op_tcapitalizacion = op_tcapitalizacion
from   pf_operacion
where  op_operacion = @i_operacionpf

if @@rowcount = 0 begin
   select
   @w_error = 141051,
   @w_msg   = 'NO EXISTE OPERACION '+convert(varchar, @i_operacionpf)
end

/* LLENO LOS DATOS DEL SISTEMA QUE CORRESPONDEN AL BATCH */
select
@s_user         = isnull(@s_user, 'sa'),
@s_ofi          = isnull(@s_ofi , @w_op_oficina),
@s_term         = isnull(@s_term, 'CONSOLA'),
@i_oficina_oper = isnull(@i_oficina_oper, @w_op_oficina)

/* EN LA PROVISION SIEMPRE LA OFICINA DE LA TRANSACCION DEBE SER LA DE LA OPERACION */
if @i_tipo_trn = 'CAU' or @w_tipo_trn = 'CAU' begin
   select
   @s_user         = 'sa',
   @s_ofi          =  @w_op_oficina,
   @s_term         = 'CONSOLA',
   @i_oficina_oper = @w_op_oficina
end

if @i_anulacion = 'S' begin

set rowcount 1

   
   if @i_tipo_trn = 'EOP' begin
      /* OBTENGO EL SECUENCIAL DE LA OPERACION A REVERSAR  para EOP */
      select @w_secuencial = tr_secuencial
      from   pf_transaccion
      where  tr_operacion = @i_operacionpf
      and    tr_tipo_trn  = @i_tipo_trn
      and    tr_fecha_mov = @i_fecha
      and    tr_estado    = 'ING' --INGRESADO
      and    tr_secuencia = @i_secuencia
   end
   else begin
      /* OBTENGO EL SECUENCIAL DE LA OPERACION A REVERSAR */
      select @w_secuencial = max(tr_secuencial)
      from   pf_transaccion
      where  tr_operacion = @i_operacionpf
      and    tr_tipo_trn  = @i_tipo_trn
      and    tr_fecha_mov = @i_fecha
      and    tr_estado    = 'ING' --INGRESADO
   end

   if @@rowcount = 0 begin --NO HAY TRANSACCIONES CONTABLES A REVERSAR
      select
      @w_error = 141000,
      @w_msg   = 'No existe transaccion contable a reversar o ya fue contabilizada.'
      goto ERROR
   end


   update pf_transaccion set
   tr_estado = 'RV'
   where  tr_operacion  = @i_operacionpf
   and    tr_secuencial = @w_secuencial

   if @@error <> 0  begin
      select
      @w_error = 145042,
      @w_msg   = 'Error al reversar contablemente la transaccion '+@i_tran
      goto ERROR
   end

set rowcount 0

   goto FIN
end --REVERSA

/* GENERO EL SECUENCIAL DE LA TRANSACCION */
exec @w_secuencial = sp_secuencial
@i_operacionpf = @i_operacionpf

if @w_secuencial is null begin
   select
   @w_error = 145042,
   @w_msg   = 'Error al obtener secuencial para operacion '+@w_op_num_banco
   goto ERROR
end

/* SI NO ESTAMOS DENTRO DE UNA TRANSACCION INICIAMOS UNA */
if @@trancount > 0 begin
   begin tran
   select @w_commit = 'S'
end

if @w_tipo_trn <> 'FFR' begin
   insert into pf_transaccion(
   tr_operacion,     tr_secuencial,    tr_fecha_real,
   tr_fecha_mov,     tr_fecha_ref,     tr_ofi_usu,
   tr_tran,          tr_tipo_trn,      tr_reverso,
   tr_secuencia,     tr_comprobante,   tr_fecha_cont,
   tr_usuario,       tr_terminal,      tr_banco,
   tr_ofi_oper,      tr_descripcion,   tr_estado)
   values(
   @i_operacionpf,   @w_secuencial,    getdate(),
   @s_date,          @i_fecha,         @s_ofi,
   @i_tran,          @w_tipo_trn,      case @i_afectacion when 'R' then 'S' else 'N' end,
   @i_secuencia,     0,                null,
   @s_user,          @s_term,          @w_op_num_banco,
   @i_oficina_oper,  @i_descripcion,   'ING')

   if @@error <> 0 begin
     select
     @w_error = 143041,
     @w_msg   = 'ERROR INSERCION DE TRANSACCION ' + @w_tipo_trn
     goto ERROR
   end
end


/* TIPO DE TRANSACCION APERTURA */
if @w_tipo_trn in ('APE') begin

   /* CAPITAL */
   if isnull(@i_monto, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    'CAP',
      @w_op_moneda,     @i_monto,         10,
      null)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end

   /* INTERES */
   if isnull(@i_valor, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    'INT',
      @w_op_moneda,     @i_valor,         20,
      null)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end

   --DESACOPLE LAZ
   select @w_cuenta = mm_cuenta
   from  pf_mov_monet M
   where mm_operacion        = @i_operacionpf
   and   mm_tran             = @i_tran
   and   mm_secuencia        = @i_secuencia
   and   mm_fecha_aplicacion = @i_fecha
   and   mm_tipo             = 'B' --RECEPCION
   and   mm_estado          <> 'R'
   and   isnull(mm_valor, 0) <> 0

   exec @w_error = cob_interfase..sp_iahorros
        @i_operacion    = 'A',
        @i_cuenta_banco = @w_cuenta,
        @o_cliente      = @w_cliente out

   if @w_error <> 0
   begin
      select
      @w_error = 143041,
      @w_msg   = 'ERROR EJECUTANDO INTERFASE DE AHORROS <sp_iahorros> ' + @w_tipo_trn
      goto ERROR
   end


   /* REGISTRO LAS FORMAS DE PAGO */
   insert into pf_transaccion_det(
   td_operacion,   td_secuencial,  td_concepto,
   td_moneda,      td_monto,       td_codvalor,
   td_aux)
   select
   @i_operacionpf,   @w_secuencial,    mm_producto,
   mm_moneda,        mm_valor,         1000,
   @w_cliente
   from  pf_mov_monet M
   where mm_operacion        = @i_operacionpf
   and   mm_tran             = @i_tran
   and   mm_secuencia        = @i_secuencia
   and   mm_fecha_aplicacion = @i_fecha
   and   mm_tipo             = 'B' --RECEPCION
   and   mm_estado          <> 'R'
   and   isnull(mm_valor, 0) <> 0
   order by mm_sub_secuencia

   if @@error <> 0 begin
      select
      @w_error = 143041,
      @w_msg   = 'ERROR INSERCION DE DETALLE TRANSACCION ' + @w_tipo_trn
      goto ERROR
   end

   if @i_fusfra in ('FUS','FRA') begin

      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,     'FFR',
      @w_op_moneda,     @i_monto+@i_valor,  1000,
      @w_aux_old)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end

   end

   goto FIN
end

/* TIPO DE TRANSACCION CAUSACION */
if @w_tipo_trn = 'CAU' begin

   if @i_afectacion = 'R' 
   	select @w_aux_cod_val = 25
   else
   	select @w_aux_cod_val = 20
   
   /* INTERES */
   if isnull(@i_valor, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    'INT',
      @w_op_moneda,     @i_valor,         @w_aux_cod_val ,
      null)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end
   goto FIN
end

/* EJECUCION ORDEN DE PAGO */
if @w_tipo_trn = 'EOP' begin
   /* REGISTRO LAS FORMAS DE PAGO */
   insert into pf_transaccion_det(
   td_operacion,   td_secuencial,  td_concepto,
   td_moneda,      td_codvalor,    td_monto,
   td_aux)
   select
   @i_operacionpf,   @w_secuencial,    mm_producto,
   mm_moneda,        1000,             case mm_tipo when 'C' then mm_valor else mm_valor * -1 end,
   convert(varchar,mm_sub_secuencia)
   from  pf_mov_monet
   where mm_operacion         = @i_operacionpf
   and   mm_tran              = @i_tran
   and   mm_secuencia         = @i_secuencia
   and   mm_fecha_aplicacion  = @i_fecha
   and   mm_estado           <> 'R'
   and   isnull(mm_valor, 0) <> 0
   order by mm_sub_secuencia

   if @@error <> 0 begin
      select
      @w_error = 143041,
      @w_msg   = 'ERROR INSERCION DE DETALLE TRANSACCION ' + @w_tipo_trn
      goto ERROR
   end
   
   /* GRAVAMEN MOVIMIENTO FINACIERO */
   if isnull(@i_impuesto_emerg_eco, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf, @w_secuencial,         @w_gmf,
      @w_op_moneda,   @i_impuesto_emerg_eco, 40,
      @w_aux_old)
      
      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end
   goto FIN
end


/* ENAJENACION*/
if @w_tipo_trn in ('ENJ') begin

   /* RETENCION */
   if isnull(@i_impuesto, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    @w_retfuente,
      @w_op_moneda,     @i_impuesto,      30,
      @w_aux_old)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end


   if @i_tran in (14168) begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_moneda,      
      td_concepto,
      td_codvalor,
      td_monto,
      td_aux)
      select
      @i_operacionpf,   @w_secuencial,    mm_moneda,        
      case when mm_producto = @w_capitalizacion then 'CAP' 
           when mm_producto <> 'OTROS' and  mm_producto <> 'SEBRA' then @w_forma_pago 
      	   else mm_producto 
      	   end,
      case when mm_producto = @w_capitalizacion then 10 else 1000 end,
      case mm_tipo when 'C' then mm_valor else mm_valor * -1 end,
      convert(varchar,mm_sub_secuencia)
      from  pf_mov_monet
      where mm_operacion         = @i_operacionpf
      and   mm_tran              = @i_tran 
      and   mm_secuencia         = @i_secuencia
      and   mm_fecha_aplicacion  = @i_fecha
      and   mm_estado           <> 'R'
      and   isnull(mm_valor, 0) <> 0
      order by mm_sub_secuencia
   
      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end
end



/* TIPO DE TRANSACCION CANCELACION / REVERSION CONSTITUCION CERTIFICADOS */
if @w_tipo_trn in ('CAN', 'RCC', 'REN') begin

   select
   @w_aux_old = '',
   @w_aux_new = ''

   /* DETERMINAR CUALES SON LOS DATOS VIEJOS Y NUEVOS */
   if @w_tipo_trn = 'REN' begin
      select @w_aux_old = @i_tplazo_old, @w_aux_new=@i_tplazo
   end


   /* CAPITAL */
   if isnull(@i_monto , 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,          'CAP',
      @w_op_moneda,     @i_monto,                10,
      @w_aux_old)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end

   /* INTERES */
   if isnull(@i_valor, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    'INT',
      @w_op_moneda,     @i_valor,         20,
      @w_aux_old)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end



   /* RETENCION */
   if isnull(@i_impuesto, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    @w_retfuente,
      @w_op_moneda,     @i_impuesto,      30,
      @w_aux_old)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end


   /* GRAVAMEN MOVIMIENTO FINACIERO */
   if isnull(@i_impuesto_emerg_eco, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf, @w_secuencial,         @w_gmf,
      @w_op_moneda,   @i_impuesto_emerg_eco, 40,
      @w_aux_old)
      
      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end

   /* ICA */
   if isnull(@i_ica, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf, @w_secuencial,         @w_ica,
      @w_op_moneda,   @i_ica,                50,
      @w_aux_old)
      
      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end


--print 'YEC CONTABPF @i_tran ' + cast(@i_tran as varchar)
--print 'YEC CONTABPF @i_incremento ' + cast(@i_incremento as varchar)
  
   /* REGISTRO LAS FORMAS DE PAGO */
   /* SI ES ORDEN DE PAGO (PAGO CAP, PAGO INT O DECREMENTO DE CAPITAL EN REN) */
   if @i_tran in (14903, 14905) or (@i_tran = 14919 and @i_incremento < 0) begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_moneda,      
      td_concepto,
      td_codvalor,
      td_monto,
      td_aux)
      select
      @i_operacionpf,   @w_secuencial,    mm_moneda,        
      case when mm_producto = @w_capitalizacion then 'CAP' 
           when mm_producto not in ('OTROS', 'SEBRA','CHG','AHO')  then @w_forma_pago 
      	   else mm_producto 
      	   end,
      case when mm_producto = @w_capitalizacion then 10 
           when mm_producto in ('AHO', 'CTE','CHG') then 1000
           else 1001 end,
      sum(case  when mm_tipo = 'C' and  mm_producto <> @w_capitalizacion then mm_valor else mm_valor * -1 end),
      case when mm_producto in ('AHO', 'CTE', 'CHG') then mm_beneficiario else null end
--      else 1001 end
      from  pf_mov_monet
      where mm_operacion         = @i_operacionpf
      and   mm_tran              = case when @i_tran = 14919 then 14904 else @i_tran end --DECREMENTO
      and   mm_secuencia         = @i_secuencia
      and   mm_fecha_aplicacion  = @i_fecha
      and   mm_estado           <> 'R'
      and   isnull(mm_valor, 0) <> 0
      group by  mm_moneda,        
      case when mm_producto = @w_capitalizacion then 'CAP' 
           when mm_producto not in ('OTROS', 'SEBRA','CHG','AHO')  then @w_forma_pago 
      	   else mm_producto 
      	   end,
      case when mm_producto = @w_capitalizacion then 10 
           when mm_producto in ('AHO', 'CTE','CHG') then 1000
           else 1001 end,
      case when mm_producto in ('AHO', 'CTE', 'CHG') then mm_beneficiario else null end

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end else begin

--print 'YEC CONTABPF @i_operacionpf ' + cast(@i_operacionpf as varchar)
--print 'YEC CONTABPF @i_tran ' + cast(@i_tran as varchar)
--print 'YEC CONTABPF @i_secuencia ' + cast(@i_secuencia as varchar)
--print 'YEC CONTABPF @i_fecha ' + cast(@i_fecha as varchar)

      if @i_tran <> 14947 begin
         insert into pf_transaccion_det(
         td_operacion,   td_secuencial,  td_moneda,      
         td_concepto,
         td_codvalor,
         td_monto,
         td_aux)
         select
         @i_operacionpf,   @w_secuencial,    mm_moneda,        
         case when mm_producto = @w_capitalizacion then 'CAP' else mm_producto end,
         case when mm_producto = @w_capitalizacion then 10 else 1000 end,
         case  when mm_tipo = 'C' and  mm_producto  <> @w_capitalizacion then mm_valor else mm_valor * -1 end,
         convert(varchar,mm_sub_secuencia)
         from  pf_mov_monet
         where mm_operacion         = @i_operacionpf
         and   mm_tran              = case when @i_tran = 14919 then 14904 else @i_tran end --INCREMENTO
         and   mm_secuencia         = @i_secuencia
         and   mm_fecha_aplicacion  = @i_fecha
         and   mm_estado           <> 'R'
         and   isnull(mm_valor, 0) <> 0
         order by mm_sub_secuencia
   
         if @@error <> 0 begin
            select
            @w_error = 143041,
            @w_msg   = 'ERROR INSERCION DE DETALLE TRANSACCION ' + @w_tipo_trn
            goto ERROR
         end
      end
   end
   
   /* INTERES POR DIAS VENCIDOS */
   if isnull(@i_intvenc, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    'INT',
      @w_op_moneda,     @i_intvenc,         21,  --interes (pero vencido)
      @w_aux_old)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end

   /* MONTO CON PROBLEMAS POR CHEQUE DEVUELTO */
   if isnull(@i_monto_problema, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,     @w_forma_pago,
      @w_op_moneda,     @i_monto_problema, 1002,  
      null)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end

   --PENALIZACION DE INTERES
   if isnull(@i_penal, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,     'PIN',
      @w_op_moneda,     @i_penal,          60,  
      null)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end
   
   --PENALIZACION DE CAPITAL
   if isnull(@i_penaliza_capital, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,       'PCA',
      @w_op_moneda,     @i_penaliza_capital, 61,  
      null)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end

   /* DETALLE SOLO PARA RCC */
   if @w_tipo_trn = 'RCC' and isnull(@i_valor, 0) <> 0 begin

      /* REVERSO DE LA CUENTA DE CONTRAPARTIDA DE LOS INTERESES POR PAGAR */
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    'INT',
      @w_op_moneda,     @i_valor,         1000,
      null)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end

   end

   /* TIPO DE TRANSACCION RENOVACION */
   if @w_tipo_trn in ('REN') and isnull(@i_monto, 0) + isnull(@i_incremento, 0) <> 0 begin

      /* DOY DE ALTA LA 'NUEVA' OPERACION */
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,                  'CAP',
      @w_op_moneda,     (-1)*(@i_monto+@i_incremento),  10,
      @w_aux_new)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end

   end

   /* SI ME ENVIAN NUEVO CLIENTE REALIZO UN 'ENDOSO CONTABLE' */
   if @w_tipo_trn = 'REN' and @i_ente_endoso <> @i_ente begin
      select @w_valor_cap = @i_monto+@i_incremento
      exec @w_error = sp_aplica_conta
      @s_user          = @s_user,
      @s_ofi           = @s_ofi,
      @s_date          = @s_date,
      @s_term          = @s_term,
      @i_fecha         = @i_fecha,
      @i_tran          = 14149,--ENDOSO
      @i_operacionpf   = @i_operacionpf,
      @i_afectacion    = @i_afectacion,
      @i_monto         = @w_valor_cap,
      @i_ente          = @i_ente,
      @i_ente_endoso   = @i_ente_endoso,
      @i_descripcion   = 'CAMBIO DE CLIENTE EN LA RENOVACION',
      @o_msg           = @w_msg         out,
      @o_comprobante   = @w_comprobante out

      if @w_error <> 0 goto ERROR

   end

   if @i_fusfra in ('FUS','FRA') and isnull(@i_monto, 0) + isnull(@i_valor, 0) <> 0 begin

      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,     'FFR',
      @w_op_moneda,     @i_monto+@i_valor,  1000,
      @w_aux_old)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end

   end


   goto FIN
end

/* ENDOSO / CAMBIO OFICINA */
if @w_tipo_trn in ('END','COF') begin

   if @w_tipo_trn = 'END' and @i_ente_endoso = @i_ente        goto FIN
   if @w_tipo_trn = 'COF' and @w_op_oficina  = @i_oficina_new goto FIN

   /* DETERMINAR CUALES SON LOS DATOS VIEJOS Y NUEVOS */
   if @w_tipo_trn = 'END' select @w_aux_old=convert(varchar,@i_ente),      @w_aux_new=convert(varchar,@i_ente_endoso)
   if @w_tipo_trn = 'COF' select @w_aux_old=convert(varchar,@w_op_oficina),@w_aux_new=convert(varchar,@i_oficina_new)

   /* CAPITAL */
   if isnull(@i_monto, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    'CAP',
      @w_op_moneda,     @i_monto,         10,
      @w_aux_new)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end

      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    'CAP',
      @w_op_moneda,     (-1)*@i_monto,    10,
      @w_aux_old)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end

   /* INTERES */
   if isnull(@i_valor, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    'INT',
      @w_op_moneda,     @i_valor,         20,
      @w_aux_new)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end

      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    'INT',
      @w_op_moneda,     (-1)*@i_valor,    20,
      @w_aux_old)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end

   goto FIN
end

if @w_tipo_trn in ('DEV') begin
   /* RETENCION */
   if isnull(@i_impuesto, 0) <> 0 begin
      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    @w_retfuente,
      @w_op_moneda,     @i_impuesto,         30,
      @w_aux_old)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end

   /* REGISTRO LAS FORMAS DE PAGO */
   insert into pf_transaccion_det(
   td_operacion,   td_secuencial,  td_concepto,
   td_moneda,      td_monto,       td_codvalor,
   td_aux)
   select
   @i_operacionpf,   @w_secuencial,    mm_producto,
   mm_moneda,        mm_valor,         1000,
   null
   from  pf_mov_monet
   where mm_operacion        = @i_operacionpf
   and   mm_tran             = @i_tran
   and   mm_secuencia        = @i_secuencia
   and   mm_fecha_aplicacion = @i_fecha
   and   mm_tipo             = 'C' --PAGO
   and   mm_estado          <> 'R'
   and   isnull(mm_valor, 0) <> 0
   order by mm_sub_secuencia

   if @@error <> 0 begin
      select
      @w_error = 143041,
      @w_msg   = 'ERROR INSERCION DE DETALLE TRANSACCION ' + @w_tipo_trn
      goto ERROR
   end

   goto FIN
end

if @w_tipo_trn in ('TOP') begin
   
   /* CAPITAL */
   if isnull(@i_monto, 0) <> 0 begin

      insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    'CAP',
      @w_op_moneda,     @i_monto,         10,
      null)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end

   end

   /* ORDE DE PAGO INTERESES PENDIENTES */ 
   if isnull(@i_valor_pago, 0) <> 0 begin

     insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    'INT',
      @w_op_moneda,     @i_valor_pago,     1001,
      null)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
   end

   /* CAUSACION*/

   if isnull(@i_valor, 0) <> 0 begin

     insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,    'INT',
      @w_op_moneda,     @i_valor,         20,
      null)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
      
   end
   
   /* EOP X CHEQUE DEVUELTO */

   if isnull(@i_valor_eop_chlo, 0) <> 0 begin

     insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,     'VXP',
      @w_op_moneda,     @i_valor_eop_chlo, 1000,
      null)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
      
   end
      
   /* EOP X CDT CANCELADO */
   
   if isnull(@i_valor_eop_cdt_can, 0) <> 0 begin

     insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,        'VXP',
      @w_op_moneda,     @i_valor_eop_cdt_can, 1001,
      null)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
      
   end
   
   /* EOP X DECREMENTO */
   if isnull(@i_valor_eop_decre, 0) <> 0 begin

     insert into pf_transaccion_det(
      td_operacion,   td_secuencial,  td_concepto,
      td_moneda,      td_monto,       td_codvalor,
      td_aux)
      values(
      @i_operacionpf,   @w_secuencial,      'VXP',
      @w_op_moneda,     @i_valor_eop_decre, 1003,
      null)

      if @@error <> 0 begin
         select
         @w_error = 143041,
         @w_msg   = 'ERROR INSERCION DE DETALLE DE TRANSACCION ' + @w_tipo_trn
         goto ERROR
      end
      
   end
      
   
end --FIN @w_tipo_trn = TOP

/* TIPO DE TRANSACCION FUSION / FRAGMENTACION */
if @w_tipo_trn in ('FFR') begin

   if @i_fusfra = 'FRA' begin
   
   select
   @w_valor_cap = op_monto_pg_int,
   @w_valor_int = op_total_int_ganados - op_total_int_pagados,
   @w_op_ente   = op_ente
   from  pf_operacion
   where op_operacion = @i_operacionpf
      
   select @w_count_benef_papa = isnull(count(1),0)
   from cob_pfijo..pf_beneficiario
   where be_operacion = @i_operacionpf
   and   be_rol in( 'T','A')
   and   be_tipo in ('T')
   and   be_estado      = 'I'
   and   be_estado_xren = 'N'   
   
   if  @w_count_benef_papa <> 1 
       select @w_valor_gmf = isnull(round(@w_valor_cap * @w_tasa_gmf, @w_numdeci),0)
   else begin
      
      select 'op'   = fu_operacion_new, 
             'cont' = count(1)
      into #fra_unico_tit 
      from cob_pfijo..pf_fusfra, cob_pfijo..pf_beneficiario
      where fu_operacion_new = be_operacion 
        and fu_operacion = @i_operacionpf
	and be_rol in( 'T','A')
	and be_tipo in ('T')
	and be_estado = 'I'
	and be_estado_xren = 'N'
       group by fu_operacion_new
       having count(1) = 1

       select @w_monto_excento = isnull(sum(op_monto),0)
         from pf_operacion,
	      #fra_unico_tit 
	 where op_ente = @w_op_ente 
	   and op_operacion = op				 

	select @w_valor_gmf = isnull(round( (@w_valor_cap  - @w_monto_excento) * @w_tasa_gmf, @w_numdeci),0)
   end    
      
   if @w_valor_gmf > 0  begin

	 update pf_mov_monet set	
	 mm_emerg_eco 	= @w_valor_gmf
	 where mm_operacion 	    = @i_operacionpf
         --and   mm_operacion        not in (@w_operacion_new)  
	 and mm_tran 		 = 14952 
	 and mm_fecha_aplicacion = @s_date
	 and mm_producto 	 = 'CFRA' 
	 and mm_estado 		 = 'A'
      
   end

      /* CANCELACION DE LA OPERACION ORIGINAL */
      exec @w_error = sp_aplica_conta
      @s_user               = @s_user,
      @s_ofi                = @s_ofi,
      @s_date               = @s_date,
      @s_term               = @s_term,
      @i_fecha              = @i_fecha,
      @i_tran               = 14903,--CANCELA DE DPF
      @i_operacionpf        = @i_operacionpf,
      @i_afectacion         = @i_afectacion,
      @i_valor              = @w_valor_int,
      @i_monto              = @w_valor_cap,
      @i_impuesto_emerg_eco = @w_valor_gmf,
      @i_ente               = @w_op_ente,
      @i_fusfra             = @i_fusfra,
      @i_descripcion        = 'CANCELACION POR FRACCIONAMIENTO',
      @o_msg                = @w_msg         out,
      @o_comprobante        = @w_comprobante out

      if @w_error <> 0 goto ERROR

      /* LAZO DE APERTURA DE LAS OPERACIONES FRACCIONADAS */
      declare cursor_fra cursor for select
      fu_operacion_new
      from pf_fusfra
      where fu_operacion = @i_operacionpf
      and   fu_estado   <> 'R'

      open cursor_fra

      fetch cursor_fra into @w_operacionpf

      while @@fetch_status = 0 begin

         select
         @w_valor_cap = op_monto_pg_int,
         @w_valor_int = op_total_int_ganados - op_total_int_pagados,
         @w_op_ente   = op_ente
         from  pf_operacion
         where op_operacion = @w_operacionpf


         /* CANCELACION DE LA OPERACION ORIGINAL */
         exec @w_error = sp_aplica_conta
         @s_user          = @s_user,
         @s_ofi           = @s_ofi,
         @s_date          = @s_date,
         @s_term          = @s_term,
         @i_fecha         = @i_fecha,
         @i_tran          = 14901,--APERTURA DE DPF
         @i_operacionpf   = @w_operacionpf,
         @i_afectacion    = @i_afectacion,
         @i_valor         = @w_valor_int,
         @i_monto         = @w_valor_cap,
         @i_ente          = @w_op_ente,
         @i_fusfra        = @i_fusfra,
         @i_descripcion   = 'APERTURA POR FRACCIONAMIENTO',
         @o_msg           = @w_msg         out,
         @o_comprobante   = @w_comprobante out

         if @w_error <> 0 goto ERROR

         fetch cursor_fra into @w_operacionpf
      end

      close cursor_fra
      deallocate cursor_fra

   end else begin --ES UNA FUSION

      select
      @w_valor_cap = op_monto_pg_int,
      @w_valor_int = op_total_int_ganados - op_total_int_pagados,
      @w_op_ente   = op_ente
      from  pf_operacion
      where op_operacion = @i_operacionpf

      select @w_op_ente_pa    = @w_op_ente   

      /* CREACION DE LA OPERACION ORIGINAL */
      exec @w_error = sp_aplica_conta
      @s_user          = @s_user,
      @s_ofi           = @s_ofi,
      @s_date          = @s_date,
      @s_term          = @s_term,
      @i_fecha         = @i_fecha,
      @i_tran          = 14901,--APERTURA DE DPF
      @i_operacionpf   = @i_operacionpf,
      @i_afectacion    = @i_afectacion,
      @i_valor         = @w_valor_int,
      @i_monto         = @w_valor_cap,
      @i_ente          = @w_op_ente,
      @i_fusfra        = @i_fusfra,
      @i_descripcion   = 'APERTURA POR FUSION', 
      @o_msg           = @w_msg         out,
      @o_comprobante   = @w_comprobante out

      if @w_error <> 0 goto ERROR

      /* LAZO DE APERTURA DE LAS OPERACIONES FRACCIONADAS */
      declare cursor_fus cursor for select
      fu_operacion
      from pf_fusfra
      where fu_operacion_new = @i_operacionpf
      and   fu_estado   <> 'R'

      open cursor_fus

      fetch cursor_fus into @w_operacionpf

      while @@fetch_status = 0 begin
      
       select @w_count_benef_papa = isnull(count(1),0)
  	     from cob_pfijo..pf_beneficiario
  	    where be_operacion = @w_operacionpf
  	      and be_rol in( 'T','A')
  	      and be_tipo in ('T')
  	      and be_estado = 'I'
  	      and be_estado_xren = 'N'
          
      if  @w_count_benef_papa <> 1 
  	  select @w_valor_gmf = isnull(round(@w_valor_cap * @w_tasa_gmf, @w_numdeci),0)
       else begin      
         
         select
         @w_valor_cap = op_monto_pg_int,
         @w_valor_gmf = round(op_monto_pg_int*@w_tasa_gmf, @w_numdeci),
         @w_valor_int = op_total_int_ganados - op_total_int_pagados,
         @w_op_ente   = op_ente
         from  pf_operacion
         where op_operacion = @w_operacionpf

	 select	'op'= fu_operacion_new, 
		'cont' = count(1)
	 into	#fusi_unico_tit 
	 from	cob_pfijo..pf_fusfra, 
		cob_pfijo..pf_beneficiario
	 where	fu_operacion_new = be_operacion 
	 and 	fu_operacion = @w_operacionpf
	 and    fu_operacion_new = @i_operacionpf
	 and	be_rol in( 'T','A')
	 and	be_tipo in ('T')
	 and	be_estado = 'I'
	 and	be_estado_xren = 'N'
	 group by fu_operacion_new
	 having count(1) = 1

	 select @w_valor_gmf = 0

	 select	@w_monto_excento = isnull(sum(op_monto),0)
	 from	pf_operacion,
		#fusi_unico_tit 
	 where	op_ente		= @w_op_ente
	 and	op_operacion	= op				 
        
	 if @w_monto_excento > 0 
	    select @w_valor_gmf = 0
	 else
	    select @w_valor_gmf = isnull(round(@w_valor_cap * @w_tasa_gmf, @w_numdeci),0)
		
	 drop table #fusi_unico_tit     
      end

      if @w_valor_gmf > 0  begin

         update	pf_mov_monet 
         set	mm_emerg_eco 	= @w_valor_gmf
         where 	mm_operacion 	= @i_operacionpf
         and 	mm_tran 		= 14952 
         and 	mm_fecha_aplicacion 	= @s_date
         and 	mm_producto 		= 'CFRA' 
         and 	mm_estado 		= 'A'
      end
     
       

         /* CANCELACION DE LA OPERACION ORIGINAL */
         exec @w_error = sp_aplica_conta
         @s_user               = @s_user,
         @s_ofi                = @s_ofi,
         @s_date               = @s_date,
         @s_term               = @s_term,
         @i_fecha              = @i_fecha,
         @i_tran               = 14903,--CANCELACION DE DPF
         @i_operacionpf        = @w_operacionpf,
         @i_afectacion         = @i_afectacion,
         @i_valor              = @w_valor_int,
         @i_monto              = @w_valor_cap,
         @i_impuesto_emerg_eco = @w_valor_gmf,
         @i_ente               = @w_op_ente,
         @i_fusfra             = @i_fusfra,
         @i_descripcion        = 'CANCELACION POR FUSION',
         @o_msg                = @w_msg         out,
         @o_comprobante        = @w_comprobante out

         if @w_error <> 0 goto ERROR

         fetch cursor_fus into @w_operacionpf
      end

      close cursor_fus
      deallocate cursor_fus

   end

end


FIN:

if @w_commit = 'S' begin
   commit tran
   select @w_commit = 'N'
end

select
@o_msg         = @w_msg,
@o_comprobante = @w_secuencial

return 0

ERROR:
if @w_commit = 'S' rollback tran
select
@o_msg         = @w_msg,
@o_comprobante = @w_secuencial

print 'ERR TRAN: '+@w_msg
return  @w_error --SIEMPRE ES INTERNO
go