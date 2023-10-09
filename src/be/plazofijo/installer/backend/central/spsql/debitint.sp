/************************************************************************/
/*      Archivo:                debitint.sp                             */
/*      Stored procedure:       sp_debita_int                           */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Ricardo Alvarez                         */
/*      Fecha de documentacion: 22/MAY-2009                             */
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
/*      Procedimiento que realiza los pagos de intereses                */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA         AUTOR                RAZON                        */
/*      22/MAY-2009   Ericka Rodriguez     Ajustes Version Unica        */
/*      22/Jul-2009   Y. Martinez	NYM DPF00015 ICA		*/
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_debita_int' and type = 'P')
   drop proc sp_debita_int  
go

create proc sp_debita_int(
     @s_ssn                                  int             = NULL,
     @s_user                                 login           = NULL,
     @s_term                                 varchar(30)     = NULL,
     @s_date                                 datetime        = NULL,
     @s_srv                                  varchar(30)     = NULL,
     @s_lsrv                                 varchar(30)     = NULL,
     @s_ofi                                  smallint        = NULL,
     @s_rol                                  smallint        = NULL,
     @t_debug                                char(1)         = 'N',
     @t_file                                 varchar(10)     = NULL,
     @t_from                                 varchar(32)     = NULL,
     @t_trn                                  int             = 14905,
     
     @i_fecha_proceso                        datetime,
     @i_en_linea                             char(1)         = 'S',
     @i_secuencia                            int,
     @i_sub_secuencia                        tinyint,
     @i_num_banco                            cuenta,
     @i_monto                                money,
     @i_impuesto                             money	     = 0,	-- NYM DPF00015 ICA    
     @i_ica				     money	     = 0,	-- NYM DPF00015 ICA
     @i_beneficiario                         int             = NULL,
     @i_producto                             catalogo        = NULL,
     @i_cuenta                               cuenta          = NULL,
     @i_benef_chq	               varchar(255) = NULL,
     @i_moneda_pago                          smallint        = NULL, 
     @i_paga_int                             char(1)         = 'N',  -- Control para procesos de pago de interes
     @i_empresa                              tinyint         = 1,
     @i_tipo_cliente                         char(1)         = NULL, 
     @i_oficina                              int             = NULL, 
     @i_penaliza                             money           = NULL,
     @i_fecha_ult_pg_int                     datetime        = NULL, --CVA Oct-27-05
     @i_cod_banco_ach                        smallint        = NULL,  --CVA Jun-12-06     
     @i_tipo_cuenta_ach                      char(1)         = NULL, --CVA Jun-12-06 
     
     @o_mensaje                              descripcion     = NULL out) 
with encryption
as
declare @w_sp_name              descripcion,
        @w_return               int,
        @w_fecha_hoy            datetime,
        @w_error                int,
        @w_moneda               int,
        @w_numdeci              tinyint,
        @w_usadeci              char(1),               
        -- VARIABLES PARA PF_OPERACION 
        @w_oficina              smallint,
        @w_ofi_ing              smallint,
        @w_num_banco            cuenta,
        @w_fpago                catalogo,
        @w_operacionpf          int,
        @w_monto_pg_int         money,
        @w_monto                money,
        @w_impuesto             money,
	@w_ica			money,	 -- NYM DPF00015 ICA
        @w_op_int_ganado        money,   -- contiene valor de arrastre */
        @w_int_pagados          money,
        @w_total_int_acumulado  money,
        @w_total_int_pagados    money,
        @w_fecha_pg_int         datetime, 
        @w_fecha_ult_pg_int     datetime,
        @w_fecha_vencimiento    datetime,
        @w_tcapitalizacion      char(1),
        @w_retiene_capital      char(1),
        @w_tipo_cotiza          char(1),
        @w_cotizacion           money,  
        @w_cotizacion_conta     money,  
        @w_cotizacion_compra_b  money,  
        @w_cotizacion_venta_b   money,  
        @w_monto_mn             money,  
        @w_monto_me             money,  
        @w_moneda_cotiz         smallint,
        @w_valor_pago           money,   
        @w_moneda_base          tinyint,  
        @w_tipo_cliente         char(1),   -- gap DP00008
        @w_dp_oficina           int,       -- gap DP00008
        @w_erpgint              char(1),
        @w_mensaje              descripcion,  --CVA Oct-13-05
        @w_cta_pagrec           varchar(24),   --CVA Oct-21-05
        @w_par_pago      varchar(10)

select @w_sp_name = 'sp_debita_int',
       @i_en_linea= isnull(@i_en_linea,'S'),
       @w_mensaje = NULL, @w_cta_pagrec = NULL

select @w_erpgint = 'N'


--print 'debitin i_oficina ' + cast(@i_oficina as varchar )

-------------------------------------------
--Asignar el tipo de cliente gap DP00008
-------------------------------------------
if @i_tipo_cliente is null
     select @w_tipo_cliente = 'M'
else
     select @w_tipo_cliente = @i_tipo_cliente
------------------------------------------------
-- Asignar oficina para pago cheque gap DP00008
------------------------------------------------

--if @i_oficina IS  NULL
   select @w_dp_oficina = @i_oficina


select @w_fecha_hoy = convert(datetime,convert(varchar,isnull(@i_fecha_proceso,@s_date),101)),
       @w_ofi_ing   = @s_ofi

select @w_moneda_base = em_moneda_base
  from cob_conta..cb_empresa
 where em_empresa = @i_empresa
if @@rowcount = 0
   return 601018   

---------------------------------
-- Obtener datos de pf_operacion
---------------------------------
select @w_num_banco          = op_num_banco,  
       @w_operacionpf        = op_operacion,       
       @w_monto_pg_int       = op_monto_pg_int,
       @w_int_pagados        = op_int_pagados,
       @w_moneda             = op_moneda,
       @w_fpago              = op_fpago,
       @w_oficina            = op_oficina,
       @w_total_int_acumulado = op_total_int_acumulado,
       @w_tcapitalizacion    = op_tcapitalizacion,
       @w_fecha_vencimiento  = convert(datetime,convert(varchar,op_fecha_ven,101)),
       @w_fecha_pg_int       = convert(datetime,convert(varchar,op_fecha_pg_int,101)),
       @w_fecha_ult_pg_int   = convert(datetime,convert(varchar,op_fecha_ult_pg_int,101)), -- PRA
       @w_total_int_pagados  = op_total_int_pagados
from pf_operacion 
where op_num_banco = @i_num_banco 

if @@rowcount = 0
begin
     return 141004
end

-- Busca el parametro

select @w_par_pago = pa_char
  from cobis..cl_parametro
 where pa_producto = 'PFI'
and pa_nemonico = 'NVXP'

-- Encuentra parametro de decimales
select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @w_moneda

if @w_usadeci = 'S'
begin
     select @w_numdeci = isnull (pa_tinyint,0)
     from cobis..cl_parametro
     where pa_nemonico = 'DCI'
     and pa_producto = 'PFI'
end
else
     select @w_numdeci = 0   

          select @w_monto    	= round(@i_monto, @w_numdeci) --@i_monto registro leido de pf_det_pago
          select @w_impuesto 	= round(@i_impuesto, @w_numdeci)
          select @w_ica		= round(@i_ica, @w_numdeci)	-- NYM DPF00015 ICA 

/*if (@w_fecha_vencimiento <> @w_fecha_pg_int) and (@w_fpago = 'PER')
begin
       if @w_tcapitalizacion = 'N' --CVA Jun-29-06 Para periodicios pagos esta bien asi
          select    @w_total_int_pagados = @w_total_int_pagados + @i_monto + @i_impuesto,         
               @w_fecha_ult_pg_int  = @w_fecha_hoy
       else  --Para periodicos capitalizables hay que sumarle el interes pagados por anticipado ya que @i_monto es el (op_int_estimado - op_int_pagados)               
          select    @w_total_int_pagados = @w_total_int_pagados + @i_monto + @w_int_pagados,         
               @w_fecha_ult_pg_int  = @w_fecha_hoy
     
end*/

      ----------------------------------------------------------------------------------------------------------------------
      -- Se graba el valor en moneda nacional de acuerdo a la cotiz. pero el impuesto se mantiene en la moneda del deposito
      ----------------------------------------------------------------------------------------------------------------------
select @i_moneda_pago = isnull(@i_moneda_pago, @w_moneda)

if @i_moneda_pago <> @w_moneda_base or @w_moneda <> @w_moneda_base
begin
     if @i_moneda_pago <> @w_moneda_base
          select @w_moneda_cotiz = @i_moneda_pago
     else
          select @w_moneda_cotiz = @w_moneda

     set rowcount 1
     select @w_cotizacion_conta = co_conta,
          @w_cotizacion_compra_b = co_compra_billete,
          @w_cotizacion_venta_b = co_venta_billete
     from cob_pfijo..pf_cotizacion
     where co_moneda = @w_moneda_cotiz
          and co_fecha = @i_fecha_proceso
     order by co_hora desc
     set rowcount 0 

     if @w_moneda = @i_moneda_pago
     begin
          select @w_cotizacion = @w_cotizacion_conta, @w_tipo_cotiza = 'N'
          select    @w_monto_mn = @w_monto * @w_cotizacion, 
                    @w_monto_me = @w_monto,
                    @w_valor_pago = @w_monto
     end
     else
     begin
          if @w_moneda = @w_moneda_base    
          begin
               select @w_cotizacion = @w_cotizacion_venta_b, @w_tipo_cotiza = 'V'
               select    @w_monto_me = @w_monto / @w_cotizacion,
                         @w_monto_mn = @w_monto,
                         @w_valor_pago = @w_monto/ @w_cotizacion
                
          end
          else
          begin
               select    @w_cotizacion = @w_cotizacion_compra_b, @w_tipo_cotiza = 'C'
               select    @w_monto_mn = @w_monto * @w_cotizacion,
                         @w_monto_me = 0,
                         @w_valor_pago = @w_monto * @w_cotizacion
          end
     end
end
else
     select    @w_monto_mn = @w_monto,
               @w_monto_me = 0

--CVA Oct-12-05 por Capitalizacion
if @i_beneficiario is null  
     select @i_beneficiario = 0

--CVA Mar-30-06 Para las demas formas de pago tomar la oficina del deposito.
if @i_producto not in (select pa_char  from cobis..cl_parametro 
                        where pa_producto = 'PFI'
                        and pa_nemonico  in ('NCHG', 'NGIRO','PTCHCO'))

   select @w_dp_oficina = @w_oficina


--print 'debitin w_dp_oficina ' + cast(@w_dp_oficina as varchar )


begin tran     --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*


insert pf_mov_monet 
       (mm_operacion   , mm_tran       , mm_secuencia   , mm_sub_secuencia,
        mm_producto    , mm_cuenta     , mm_valor       , mm_valor_ext,
        mm_fecha_crea  , mm_fecha_mod  , mm_tipo        , mm_secuencial,
        mm_beneficiario, mm_moneda     , mm_estado      , mm_fecha_aplicacion,
        mm_impuesto    , mm_user       , mm_tipo_cliente, mm_cotizacion, mm_benef_corresp,
        mm_tipo_cotiza , mm_oficina    , mm_usuario     , mm_penaliza,
        mm_fecha_valor , mm_cod_banco_ach, mm_tipo_cuenta_ach, mm_ica) -- NYM DPF00015 ICA  --CVA Oct-13-05
values (@w_operacionpf , @t_trn        , @i_secuencia   , @i_sub_secuencia,
        @i_producto    , @i_cuenta     , @w_monto_mn    , @w_monto_me,
        @s_date        , @s_date       , 'C'            , 0,
        @i_beneficiario, @i_moneda_pago, null           , null,
        @w_impuesto    , @s_user       , @w_tipo_cliente, @w_cotizacion, @i_beneficiario,
        @w_tipo_cotiza , @w_dp_oficina , @s_user        , @i_penaliza,
        @w_fecha_pg_int, @i_cod_banco_ach, @i_tipo_cuenta_ach,  @w_ica) -- NYM DPF00015 ICA --CVA Oct-13-05
	
if @@error <> 0
begin
     print 'error en movmonet duplicados'
     select @w_mensaje = 'DEBITINT.SP ERROR INSERCION EN PF_MOV_MONET '
     select @w_error = 143020
     goto ERROR
end

select @w_retiene_capital = 'N'

exec @w_return=sp_aplica_mov
     @s_ssn             = @s_ssn,
     @s_user            = @s_user,
     @s_ofi             = @s_ofi,
     @s_date            = @s_date,
     @s_srv             = @s_srv, 
     @s_term            = @s_term,
     @t_file            = @t_file,
     @t_from            = @w_sp_name, 
     @t_debug           = @t_debug,
     @t_trn             = @t_trn,
     @i_operacionpf     = @w_operacionpf,
     @i_fecha_proceso   = @w_fecha_hoy,
     @i_secuencia       = @i_secuencia,
     @i_en_linea        = @i_en_linea,
     @i_fecha_inicial   = @i_fecha_ult_pg_int, --CVA Oct-21-05
     @i_tipo            = 'N',
     @i_sub_secuencia   = @i_sub_secuencia,
     @i_retiene_capital = @w_retiene_capital,
     @i_benefi          = @i_benef_chq        
if @w_return <> 0
begin
     --CVA Jun-29-06 Si el cliente no existe entonces no debe seguir con el pago
     if @w_return = 141044 --Error porque el cliente del detalle de pago no existe en cl_ente o pf_cliente_externo
        select @i_paga_int = 'N'

     if @i_paga_int = 'N'
     begin
          select @w_mensaje    = 'debitint.sp Error recibido de sp_aplica_mov' --CVA Oct-21-05
          select @w_cta_pagrec = @i_producto  --CVA Oct-21-05

          if @w_return = 141044
             select @w_mensaje    = 'aplicmov.sp ERROR CLIENTE COBIS/EXTERNO NO EXISTE'

          select @w_error      = @w_return
          goto ERROR
     end
     
     -----------------------------------------------------
     -- Control por falla de pago de intereses automatico
     -----------------------------------------------------
     if @i_paga_int = 'S' 
     begin

          select @w_error      = @w_return
          select @w_erpgint    = 'S'
                            
          update pf_mov_monet
          set  mm_producto = @w_par_pago,
               mm_usuario  = @s_user
          where mm_operacion     = @w_operacionpf
               and mm_tran          = @t_trn
               and mm_fecha_crea    = @s_date
               and mm_secuencia     = @i_secuencia
               and mm_sub_secuencia = @i_sub_secuencia
               and mm_estado        is null
          if @@rowcount  > 0
          begin
               select @w_retiene_capital = 'N'

               exec @w_return=sp_aplica_mov
                    @s_ssn             = @s_ssn,
                    @s_user            = @s_user,
                    @s_ofi             = @s_ofi,
                    @s_date            = @s_date,
                    @s_srv             = @s_srv, 
                    @s_term            = @s_term,
                    @t_file            = @t_file,
                    @t_from            = @w_sp_name, 
                    @t_debug           = @t_debug,
                    @t_trn             = @t_trn,
                    @i_operacionpf     = @w_operacionpf,
                    @i_fecha_proceso   = @w_fecha_hoy,
                    @i_secuencia       = @i_secuencia,
                    @i_en_linea        = @i_en_linea,
                    @i_fecha_inicial   = @i_fecha_ult_pg_int, --CVA Oct-21-05
                    @i_tipo            = 'N',
                    @i_sub_secuencia   = @i_sub_secuencia,
                    @i_retiene_capital = @w_retiene_capital,
                    @i_benefi          = @i_benef_chq        
               if @w_return <> 0
               begin
                    select @w_cta_pagrec = @w_par_pago  --CVA Oct-21-05
                    select @w_mensaje    = 'debitint.sp Error sp_aplica_mov' --CVA Oct-21-05
                    select @w_error      = @w_return
                    goto ERROR
               end
          end      
     end
end 

/*  
if @w_fpago = 'PER' or  @w_fpago = 'VEN'   
begin   
     update pf_operacion 
     set  op_monto_pg_int        = round(@w_monto_pg_int,@w_numdeci),
          op_total_int_pagados   = round(@w_total_int_pagados,@w_numdeci),
          op_fecha_ult_pg_int    = @w_fecha_ult_pg_int,
          op_total_int_acumulado = round(@w_total_int_acumulado,@w_numdeci),
          op_fecha_mod           = @s_date,
          op_tasa                = @i_tasa_nominal, 
          op_tasa_efectiva       = @i_tasa_efectiva 
     where op_operacion = @w_operacionpf
    
     select @o_flag_arrastre = 1
     select @o_op_int_ganado = @w_op_int_ganado
     
     if @@error <> 0
     begin
          select @w_error = 145001
          goto ERROR
     end
end             */
    
select @o_mensaje = @w_mensaje

if @w_erpgint = 'S'
begin
     select @w_erpgint = 'N'

     exec sp_errorlog 
          @i_fecha   = @s_date,
          @i_error   = @w_error, 
          @i_usuario = @s_user,
          @i_tran    = @t_trn,
          @i_cuenta  = @w_num_banco,
             @i_cta_pagrec  = @w_cta_pagrec, --CVA Jun-29-06
             @i_descripcion = @w_mensaje     --CVA Jun-29-06
end

commit tran    --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

return  0

ERROR:
     print 'debitint.sp Registra bloque error ' + convert(varchar(30), @w_error )

     exec sp_errorlog 
             @i_fecha   = @s_date,
             @i_error   = @w_error, 
             @i_usuario = @s_user,
             @i_tran    = @t_trn,
             @i_cuenta  = @w_num_banco,
             @i_cta_pagrec  = @w_cta_pagrec, 
             @i_descripcion = @w_mensaje       --CVA Oct-13-05

     select @o_mensaje = @w_mensaje

     return @w_error

go


