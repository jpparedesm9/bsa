/************************************************************************/
/*      Archivo:                disbono.sp                            	*/
/*      Stored procedure:       sp_disminucion_bono               	*/
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Clotide Vargas                          */
/*      Fecha de documentacion: 07-Ago-2006                             */
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
/*      Este programa realiza la disminucion de capital de los bonos    */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */
/*      Ago-07-06    Clotilde Vargas    Emision Inicial                 */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_disminucion_bono') IS NOT NULL
		drop proc sp_disminucion_bono
go
create proc sp_disminucion_bono (          
@s_ssn			            int             = NULL,
@s_user                 	login	        = NULL,
@s_term                 	varchar(30)     = NULL,
@s_date                 	datetime        = NULL,  
@s_sesn                 	int             = NULL,
@s_srv                  	varchar(30)     = NULL,
@s_lsrv                 	varchar(30)     = NULL,
@s_ofi                  	smallint        = NULL,
@s_rol                  	smallint        = NULL,
@t_debug                	char(1)         = 'N',
@t_file                 	varchar(10)     = NULL,
@t_from                 	varchar(32)     = NULL,
@t_trn                  	smallint        = NULL,
@i_num_banco                cuenta		    = NULL,
@i_en_linea                 char(1)         = 'N',
@i_formato_fecha	    	int		        = 101)
with encryption
as
declare @w_sp_name                      varchar(32),
        @w_return                       int,
	@w_error			int,
	@w_trn				int,
	@w_usadeci			char(1),
	@w_numdeci			tinyint,
	@w_siguiente			int,
	@w_op_sec_incre			int,
	@w_op_operacion			int,
	@w_op_ente			int,
	@w_num_banco			cuenta,
	@w_op_monto			money,
	@w_monto_act                    money,
	@w_monto_inicial		money,
	@w_op_moneda			tinyint,
	@w_tipo_deposito		int,
	@w_op_toperacion		catalogo,
	@w_op_num_dias 			int,
	@w_op_secuencia			int,
       	@w_op_tcapitalizacion   	char(1), 
	@w_op_historia			int,
	@w_op_oficina			smallint,
	@w_op_int_estimado		money,
	@w_op_total_int_estimado	money,
	@w_op_amortiza_periodo 		money,
	@w_op_total_amortiza            money,
	@w_monto_amortizar              money,
	@w_op_tipo_monto		catalogo,
	@w_tipo_monto			catalogo,
	@w_op_ppago			catalogo,		
	@w_op_fpago			catalogo,
	@w_op_dia_pago			tinyint,		
	@w_op_base_calculo		smallint,	
	@w_op_fecha_valor		datetime,	
	@w_op_dias_reales		char(1),	
	@w_op_tasa			float,		
	@w_op_int_ganado		money,
	@w_op_total_int_ganado		money,
	@w_inc_conta			money,
	@w_dec_conta			money,
	@w_descripcion			varchar(64),
	@o_comprobante			int,
	@w_secuencial			int,
	@w_moneda_base			tinyint,
	@w_op_fecha_ven			datetime,
	@w_op_fecha_pg_int		datetime,
	@w_fecha_pg_int_new		datetime,
	@w_int_ganado_new		money,
	@w_int_estimado_new		money,
	@w_total_int_estimado_new	money,
	@w_total_int_ganado_new	        money,
	@w_impuesto			money,
	@w_total_amortiza		money,
	@w_mensaje			varchar(64),

	/*Variables para movimiento monetario*/
	@w_valor_ext			money,
	@w_valor			money,
	@w_cotizacion_conta		float,
	@w_cotizacion			float,
	@w_tipo_cotiza			char(1),

	/* Variables para pf_det_pago */
	@w_dp_ente                int,
	@w_dp_secuencia 		  int,
	@w_sec1                           int,
	@w_dp_tipo			  catalogo,
	@w_dp_forma_pago	          catalogo,
	@w_dp_cuenta    	          cuenta,   
	@w_dp_monto			  money,
	@w_dp_monto_act                   money,
	@w_dp_porcentaje                  float,
	@w_dp_fecha_crea		  datetime, 
	@w_dp_fecha_mod			  datetime,
        @w_dp_moneda_pago                 smallint,
	@w_dp_descripcion                 varchar(255),	
	@w_dp_oficina                     int,		
	@w_dp_tipo_cliente                char(1),       
        @w_dp_tipo_cuenta_ach             char(1),
        @w_dp_banco_ach                   smallint,
        @w_dp_cuenta_aho                  cuenta,
        @w_dp_debcred                     char(1),
	@w_forma_pago_bono		  catalogo,
        @w_cuenta_pago_bono               cuenta

create table #ca_operacion_aux (
op_operacion         int,
op_banco             varchar(24), 
op_toperacion        varchar(10),
op_moneda            tinyint,
op_oficina           int,
op_fecha_ult_proceso datetime ,
op_dias_anio         int,
op_estado            int,
op_sector            varchar(10),
op_cliente           int,
op_fecha_liq         datetime,
op_fecha_ini         datetime ,
op_cuota_menor       char(1),
op_tipo              char(1),
op_saldo             money,     -- LuisG 04.06.2001
op_fecha_fin         datetime,   -- LuisG 04.06.2001
op_base_calculo      char(1) , --lre version estandar 05/06/2001
op_periodo_int       smallint, --lre version estandar 05/06/2001
op_tdividendo        varchar(10)  --lre version estandar 05/06/2001
)



create table #ca_abonos (
ab_secuencial_ing    int,
ab_dias_retencion    int         null,
ab_estado            varchar(10) null,
ab_cuota_completa    char(1)     null
)


/* ALMACENA LAS DIFERENCIAS DE INTERES EN LOS REAJUSTES */

create table #interes_proyectado (
concepto        varchar(10),
valor           money
)




/*----------------------------------*/
/*  Verificar codigo de Transaccion */
/*----------------------------------*/
if  @t_trn <> 14990
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 141112
        return 141112
end 

-------------------------------
-- Inicializacion de variables
-------------------------------
select @w_sp_name 	= 'sp_disminucion_bono',        
       @w_secuencial 	= @s_ssn,
       @w_impuesto	= 0,
       @w_total_amortiza= 0

select @w_moneda_base = em_moneda_base
    from cob_conta..cb_empresa where em_empresa = 1

--Parametro de forma de pago Disminucion Bonos
select @w_forma_pago_bono = pa_char 
from cobis..cl_parametro 
where pa_nemonico = 'FPDB' 
and pa_producto='PFI' 
if @@rowcount = 0
   select @w_forma_pago_bono = 'INSTRUC' --Si no existiere el catalogo entonces tomar la forma de pago INSTRUC


--Parametro de cuenta de pago Disminucion Bonos
select @w_cuenta_pago_bono = pa_char 
from cobis..cl_parametro 
where pa_nemonico = 'CADB' 
and pa_producto='PFI' 
if @@rowcount = 0
   select @w_cuenta_pago_bono = NULL

        

------------------------------------ 
-- Lectura de la tabla pf_operacion
------------------------------------
select 	@w_op_operacion		= op_operacion,	
	@w_op_ente		= op_ente,
       	@w_op_monto		= op_monto,
       	@w_op_toperacion	= op_toperacion,
	@w_op_num_dias          = op_num_dias,
       	@w_op_tcapitalizacion   = op_tcapitalizacion, 
	@w_op_tipo_monto	= op_tipo_monto,
 	@w_op_secuencia 	= op_mon_sgte,
       	@w_op_oficina           = op_oficina,
       	@w_op_historia		= op_historia,
       	@w_op_moneda            = op_moneda,
	@w_op_fecha_ven		= op_fecha_ven,
	@w_op_fecha_pg_int	= op_fecha_pg_int,
	@w_op_ppago		= op_ppago,		
	@w_op_fpago		= op_fpago,
	@w_op_dia_pago		= op_dia_pago,		
	@w_op_base_calculo	= op_base_calculo,	
	@w_op_fecha_valor	= op_fecha_valor,	
	@w_op_dias_reales	= op_dias_reales,	
	@w_op_tasa		= op_tasa,		
       	@w_op_int_ganado        = op_int_ganado,
	@w_op_total_int_ganado  = op_total_int_ganados,
       	@w_op_int_estimado      = op_int_estimado,
       	@w_op_total_int_estimado = isnull(op_total_int_estimado,0),
       	@w_op_sec_incre         = isnull(op_sec_incre,0),
     	@w_op_amortiza_periodo  = op_amortiza_periodo,
	@w_op_total_amortiza    = isnull(op_total_amortizado,0)
from pf_operacion
where op_num_banco = @i_num_banco
and   op_estado    = 'ACT'
if @@rowcount = 0
begin
	exec cobis..sp_cerror 
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 141051

	select @w_error =  141051
	goto ERROR
end

select @w_trn = 14990

select @s_ofi = @w_op_oficina --CVA Oct-17-06

------------------------------------
-- Encuentra parametro de decimales
------------------------------------
select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_op_moneda
if @w_usadeci = 'S'
begin
	select @w_numdeci = isnull (pa_tinyint,0)     
	from cobis..cl_parametro
	where pa_nemonico = 'DCI'
	and pa_producto = 'PFI'
end
else
	select @w_numdeci = 0  

select @w_monto_act      = 0

--I. CVA Abr-03-07 Disminuci¢n en su fecha de vencimiento y por algun proceso o procedimiento
--                 operativo el monto del ultimo trimeste no es igual al monto de amortizacion
--                 por periodo entonces que se amortice lo ultimo que queda de capital
--print '@w_op_fecha_ven %1!,  @s_date %2!, @w_op_monto %3!, @w_op_amortiza_periodo %4!, @i_num_banco %5!', @w_op_fecha_ven,  @s_date, @w_op_monto, @w_op_amortiza_periodo, @i_num_banco

if @w_op_fecha_ven = @s_date
   select @w_op_amortiza_periodo = @w_op_monto

Select @w_monto_act = @w_op_monto - @w_op_amortiza_periodo   

select @w_monto_amortizar = @w_op_amortiza_periodo * -1

--Obtener el nuevo nemonico del tipo de monto de acuerdo al nuevo monto:
select @w_tipo_deposito = td_tipo_deposito
from pf_tipo_deposito
where td_mnemonico = @w_op_toperacion
 
select  @w_tipo_monto = mo_mnemonico 
from cob_pfijo..pf_monto, pf_auxiliar_tip 
where   @w_monto_act 		>= mo_monto_min
	and   @w_monto_act 	<= mo_monto_max
	and   mo_mnemonico 	= at_valor
	and   at_tipo 		= 'MOT'
	and   at_tipo_deposito 	= @w_tipo_deposito
	and   at_estado 	= 'A'
	and   at_moneda 	= @w_op_moneda
if @@rowcount = 0 --Para la £ltima cuota
     select @w_tipo_monto = @w_op_tipo_monto


	select @w_monto_inicial = 0

	Select @w_monto_inicial =  isnull(hi_valor, 0)
 	from   pf_historia
     	where  hi_operacion = @w_op_operacion
       	  and  hi_trn_code  = 14901    

	--si ya amortizo todo, este control es por si existiesen bonos capitalizables
	if @w_monto_inicial =  @w_op_total_amortiza
	begin     
		goto FINAL
	end


if @w_op_monto > 0
begin
	if @w_op_fecha_ven > @s_date
	begin
		
		exec @w_return = sp_calcula_mod
		@s_ofi			= @s_ofi,
		@s_date			= @s_date,
		@i_num_dias		= @w_op_num_dias,	--Nuevo plazo
		@i_monto		= @w_monto_act,		--Monto aplicado el incremento o decremento
		@i_ppago		= @w_op_ppago,		--Nuevo periodo de pago 
		@i_fpago		= @w_op_fpago,		--Nueva forma de pago
		@i_dia_pago		= @w_op_dia_pago,	--Dia de pago modificado
		@i_tcapitalizacion	= @w_op_tcapitalizacion,--Condicion de capitalizacion
		@i_fecha_ven		= @w_op_fecha_ven,	--Nueva Fecha de Vencimiento
		@i_fecha_valor		= @w_op_fecha_valor,	--Nueva Fecha Valor de la operacion
		@i_dias_reales		= @w_op_dias_reales,	--Manejo de fechas comerciales o calendario 		
		@i_man_inc		= 'M',			
		@i_fecha_valor_cambio	= @s_date,              --Fecha valor de aplicacion del cambio de condiciones(INC/DEC/TASA)
		@i_tasa			= @w_op_tasa,		--Tasa
		@i_num_banco		= @i_num_banco,
		@i_formato_fecha	= @i_formato_fecha,
		@i_moneda		= @w_op_moneda, 	

		@o_fecha_pg_int		= @w_fecha_pg_int_new		out,
		@o_int_ganado		= @w_int_ganado_new		out,
		@o_int_estimado		= @w_int_estimado_new		out,
		@o_total_int_estimado	= @w_total_int_estimado_new	out,
		@o_total_int_ganado	= @w_total_int_ganado_new	out
		if @w_return <> 0
		begin
                         select @w_error = @w_return
                         GOTO  ERROR
		end 	    
	end
       	ELSE    --(contrario de  @s_date <> op_fecha_ven)
	begin

		select  @w_fecha_pg_int_new	  = @w_op_fecha_pg_int,
			@w_int_ganado_new	  = @w_op_int_ganado,
			@w_int_estimado_new	  = @w_op_int_estimado,
			@w_total_int_estimado_new = @w_op_total_int_estimado,
			@w_total_int_ganado_new	  = @w_op_total_int_ganado
	end		

	--print '@w_fecha_pg_int_new %1!, @w_int_ganado_new %2!, @w_int_estimado_new %3!, @w_total_int_estimado_new %4!, @w_total_int_ganado_new %5!', @w_fecha_pg_int_new, @w_int_ganado_new, @w_int_estimado_new, @w_total_int_estimado_new, @w_total_int_ganado_new


	begin tran	--***********************************************************

	/*****************************************************************/
	--Registrar movimiento monetario por la disminucion.
	/*****************************************************************/

        -------------------------------------------------------------------
        -- Calculo del valor en moneda nacional de acuerdo a la cotizacion
        -------------------------------------------------------------------
        if @w_op_moneda <> @w_moneda_base
        begin
            set rowcount 1
            select @w_cotizacion_conta = co_conta
              from cob_pfijo..pf_cotizacion
             where co_moneda = @w_op_moneda
               and co_fecha  = (select max(co_fecha)
                                 from cob_pfijo..pf_cotizacion
                                where co_moneda = @w_op_moneda)
         
            select @w_cotizacion  = @w_cotizacion_conta
                 
            select @w_valor       = @w_op_amortiza_periodo * @w_cotizacion,
                   @w_valor_ext   = @w_op_amortiza_periodo,
                   @w_tipo_cotiza = 'V'

            set rowcount 0
        end
        else
        begin
         	select 	@w_valor_ext = 0,
                	@w_valor     = @w_op_amortiza_periodo
        end

        insert pf_mov_monet_tmp
                (mt_usuario         , mt_sesion     	, mt_operacion	, 
		 mt_sub_secuencia   , mt_producto   	, mt_cuenta         , 
		 mt_valor      	    , 
		 mt_beneficiario    , mt_moneda     	, mt_valor_ext      , 
                 mt_tipo            , mt_fecha_crea 	, mt_fecha_mod      , 
		 mt_tipo_cliente    , mt_cotizacion 	, mt_tipo_cotiza    , 
                 mt_fecha_valor     , mt_tran       	, mt_secuencia)   
        values  (@s_user            , @s_sesn       	, @w_op_operacion   , 
		 1		    , @w_forma_pago_bono, @w_cuenta_pago_bono,
		 @w_valor           , 
                 @w_op_ente         , @w_op_moneda  	, @w_valor_ext      , 
                 'C'                , @s_date       	, @s_date           , 
                 'M'                , @w_cotizacion 	, @w_tipo_cotiza    , 
                 @s_date            , @t_trn        	, 1)                                   
      	if @@error <> 0
      	begin
             select @w_error = 143022
             GOTO ERROR
      	end


	/*****************************************************************/
	--Registrar nuevo monto a pagar para el proximo pago de intereses
	/*****************************************************************/
	select @w_dp_ente = 0, @w_dp_forma_pago = ''
	while 1=1
        begin
	set rowcount 1 
	select 	@w_dp_ente    	      = dp_ente,
		@w_dp_secuencia       = dp_secuencia,
		@w_dp_tipo            = dp_tipo,
		@w_dp_forma_pago      = dp_forma_pago,
		@w_dp_cuenta          = dp_cuenta,
		@w_dp_monto           = round(dp_monto, @w_numdeci),
		@w_dp_porcentaje      = dp_porcentaje,
		@w_dp_moneda_pago     = dp_moneda_pago,
		@w_dp_descripcion     = dp_descripcion,      
		@w_dp_oficina         = dp_oficina,	     
		@w_dp_tipo_cliente    = dp_tipo_cliente,
		@w_dp_tipo_cuenta_ach = dp_tipo_cuenta_ach,
		@w_dp_banco_ach       = dp_cod_banco_ach
	from pf_det_pago
	where dp_operacion 	= @w_op_operacion
	  and dp_estado_xren    = 'N'
          and dp_estado         = 'I'
	  and (dp_ente   > @w_dp_ente or 
              (dp_ente   = @w_dp_ente and dp_forma_pago <> @w_dp_forma_pago)) 		
	order by dp_ente
	if @@rowcount = 0
		break

		select @w_dp_monto_act = round(((@w_int_estimado_new * @w_dp_porcentaje) /100),@w_numdeci)

        	insert pf_det_pago_tmp     
            		(dt_operacion  , 	dt_usuario   ,	  	dt_sesion,    
             		dt_beneficiario, 	dt_tipo      ,	  	dt_forma_pago,  
             		dt_monto       , 	dt_porcentaje,	  	dt_fecha_crea, 
             		dt_fecha_mod   , 	dt_cuenta    ,	  	dt_moneda_pago,
             		dt_descripcion , 	dt_oficina,	  	dt_tipo_cliente,
	     		dt_secuencia   , 	dt_tipo_cuenta_ach,     dt_cod_banco_ach)	
        	values (@w_op_operacion, 	@s_user      ,		@s_sesn,      
             		@w_dp_ente, 		@w_dp_tipo   ,		@w_dp_forma_pago,  
             		@w_dp_monto_act, 	@w_dp_porcentaje,	@s_date,
             		@s_date        , 	@w_dp_cuenta,		@w_dp_moneda_pago,
            		@w_dp_descripcion, 	@w_dp_oficina,	        @w_dp_tipo_cliente,
             		@w_dp_secuencia, 	@w_dp_tipo_cuenta_ach,  @w_dp_banco_ach)		
        	if @@error <> 0
        	begin
             		select @w_error = 143037
             		GOTO ERROR
        	end
        end


	--Invocar incredef.sp  para que realice la disminucion del dpf.
        exec @w_return = sp_incremento_decremento
        	@s_ssn           	= @s_ssn,
        	@s_sesn		 	= @s_ssn,
        	@s_user     	 	= @s_user,
        	@s_term          	= @s_term,
        	@s_date          	= @s_date,
        	@s_srv           	= @s_srv,
        	@s_lsrv          	= @s_lsrv,
        	@s_ofi           	= @s_ofi,
        	@s_rol           	= @s_rol,
        	@t_debug         	= @t_debug,
        	@t_file          	= @t_file, 
        	@t_from          	= @w_sp_name,
                @t_trn		  	= 14965,
                @i_en_linea             = 'N',
                @i_cuenta               = @i_num_banco,
                @i_int_ganado_n         = @w_int_ganado_new,
                @i_monto_n              = @w_monto_act,
                @i_int_estimado_n       = @w_int_estimado_new,
                @i_total_int_ganados_n  = @w_total_int_ganado_new,
                @i_total_int_estimado_n = @w_total_int_estimado_new,
                @i_tipo_monto_n         = @w_tipo_monto,
                @i_fecha_valor_cambio   = @s_date, 
                @i_incremento           = @w_monto_amortizar
	if @w_return <> 0
	begin
            select @w_error = @w_return
            GOTO  ERROR
        end 	        

	--Acumular el total que se va amortizando
         select @w_total_amortiza = @w_op_total_amortiza + @w_op_amortiza_periodo

          Update pf_operacion
             Set op_total_amortizado = isnull(@w_total_amortiza,0)
          Where op_num_banco = @i_num_banco
	  if @@error <> 0
	  begin
		select @w_error = 145001
		goto ERROR
	  end
end


select @w_error = 0

commit tran	         --***********************************************************


FINAL:

return 0
		
ERROR:
  
  rollback tran

  if @i_en_linea = 'N'
  begin
      exec sp_errorlog @i_fecha   = @s_date,
                       @i_error   = @w_error,
                       @i_usuario = @s_user,
		       @i_tran    = @t_trn,
                       @i_cuenta  = @i_num_banco,
                       @i_descripcion = @w_mensaje
  end
  else
  begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = @w_error
  end

  return @w_error

go

