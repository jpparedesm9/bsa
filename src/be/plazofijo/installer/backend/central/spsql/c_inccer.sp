/*sp_incremento_cero*/
/************************************************************************/
/*      Archivo:                c_inccer.sp                             */
/*      Stored procedure:       sp_incremento_cero                      */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           N. Silva                                */
/*      Fecha de documentacion: 17-Dic-2002                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/************************************************************************/
/*      Este programa mueve realiza todas las operaciones sobre el      */
/*      deposito actual , si es incremento o Fijar una nueva Tasa.      */
/************************************************************************/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */  
/*      17-Dic-2002  N. Silva           Emision Inicial                 */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_incremento_cero')
   drop proc sp_incremento_cero
go

create proc sp_incremento_cero (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_sesn                 int             = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = NULL,
@t_rty                  char(1)         = null,

@i_fecha_proceso        datetime,
@i_camb_bascalc         char(1)         = 'N',
@i_op_operacion         int,
@i_cuenta               cuenta,
@i_en_linea             char(1)         = 'S',
@i_tasa_efectiva        float           = 0,
@i_flag_tasaefec        char(1)         = 'N',
@i_camb_tasa            char(1)         = 'N',    -- Control para cambio de Base de calculo o Tasa
@i_camb_datos           char(1)         = 'N',    -- Control para el cambio de fecha valor
@i_camb_fecv            char(1)         = 'N',    -- Cambio de fecha Valor
@i_op_moneda            int,
@i_op_monto             money,
@i_tasa                 float,
@i_fecha_valor          datetime,
@i_fecha_ven            datetime,
@i_op_ente              int,
@i_op_oficina           int,
@i_op_dias_reales       char(1)         = 'S',
@i_op_toperacion        catalogo,
@i_op_fecha_valor       datetime,
@i_op_tipo_plazo        catalogo,
@i_op_fecha_pg_int      datetime,
@i_op_ppago             catalogo,
@i_op_fpago             catalogo,
@i_op_base_calculo      int,
@i_int_ganado           money, 
@i_new_int_ganado       money, --Interes ganado nuevo
@i_new_total_int_gan    money, --Total Ganado Nuevo
@i_dia_pago             smallint,
@i_num_dias_ant         smallint,
@i_fecha_pg_int_ant     datetime,
@i_int_estimado         money,
@i_fpago_ant            catalogo,
@i_fecha_cambio         datetime,  --CVA Ene-17-06 
@i_fecha_ult_pg_int     datetime,
@i_modifica             char(1) = 'N' --CVA Jun-29-06
)
with encryption
as
declare @w_sp_name                      varchar(32),
        @w_return                       int,
	@w_dias                         int,
        @w_descripcion                  descripcion,
        @w_siguiente                    int,
        @w_error                        int,
        @w_secuencial                   int,
        @w_secuencia                    int,
        @w_num_oficial                  int,
        @w_fecha_proceso                datetime,
	@w_fecha_hoy			datetime,
        @w_numdeci                      tinyint,
        @w_usadeci                      char(1),
        @w_cotizacion                   float,
        @w_tasa_act                     float,
        @w_ajuste                       money,
        @w_fecha_ven1                   datetime,
        @w_tipo                         char(1),
	@w_acumulado_int_gan            money,

/*  Variables para la operacion anterior en Renovacion */
	@w_num_dias			int,
	@w_dif      			smallint,
	@w_fecha_valor			datetime,
	@w_fecha_ven    		datetime,
	@w_int_estimado			money,
	@w_fecha_mod			datetime,
	@w_tasa				float,
	@w_tasa_efectiva		float ,
        @w_funcionario                  login,
	@w_anio_comercial		char(1),
        /* Otras Variables */
        @w_en_oficial                   int,
        @w_contador                     int,
        @w_comprobante                  int,
        @w_debcred                      char(1),
        @w_codval                       catalogo,
        @w_ajuste_mn                    money,
        @w_ajuste_me                    money,
        @w_asiento                      smallint,
        @w_afectacion                   char(1),
        @w_trn                          int,
        @w_oficial                      int,
        @w_area_contable                int,
	@w_codval2                      smallint,	--LIM 03/ENE/2005
        @o_comprobante                  int,
	@w_cu_cuota    			int,
        @w_dias_cuota                   int

select @w_sp_name = 'sp_incremento_cero',
       @w_secuencial = @s_ssn,
       @w_acumulado_int_gan = 0,
	@w_dias = 0

-------------------------------
-- Obtener la fecha de proceso
-------------------------------
select @w_fecha_hoy = @i_fecha_proceso

------------------------------------
-- Encuentra parametro de decimales
------------------------------------
select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @i_op_moneda
if @w_usadeci = 'S'
begin
   select @w_numdeci = isnull (pa_tinyint,0)
     from cobis..cl_parametro
    where pa_nemonico = 'DCI'
      and pa_producto = 'PFI'
end
else
   select @w_numdeci = 0

begin tran

   ------------------------------------------------------------------------
   -- Contabilizacion de ajuste para cambio tasa o Base calculo Back-Value
   ------------------------------------------------------------------------
   select @w_ajuste = @i_new_int_ganado - @i_int_ganado

   if @w_ajuste <> 0 
   begin
	if @w_ajuste < 0
            select @w_tipo = 'R'
	else	
            select @w_tipo = 'N' 

	select @w_ajuste = abs(@w_ajuste)           

	if @w_ajuste > 0
	begin
	    select @w_descripcion = 'AJUSTE POR MANTENIMIENTO (' + @i_cuenta + ')'

	    if @i_camb_tasa = 'S'
	         select @w_descripcion = 'AJUSTE POR CAMBIO DE TASA (' + @i_cuenta + ')'	

	    if @i_camb_bascalc = 'S'
	         select @w_descripcion = 'AJUSTE POR CAMBIO DE BASE CALCULO (' + @i_cuenta + ')'

	    if @i_camb_datos = 'S'
	         select @w_descripcion = 'AJUSTE POR CAMBIO DE FECHA VALOR (' + @i_cuenta + ')'   


            exec @w_return = cob_pfijo..sp_aplica_conta
                        @s_ssn		= @s_ssn,
                        @s_date         = @s_date,
                        @s_user         = @s_user,
                        @s_term         = @s_term,
                        @s_ofi          = @s_ofi,
                        @t_debug        = @t_debug,
                        @t_file         = @t_file,
                        @t_from         = @t_from,
                        @t_trn          = 14937,
                        @i_empresa      = 1,
                        @i_fecha        = @s_date,
                        @i_tran         = 14926,
                        @i_producto     = 14,   /* op_producto de pf_operacion */
                        @i_oficina_oper   = @i_op_oficina,
                        @i_oficina        = @i_op_oficina, 
                        @i_toperacion     = @i_op_toperacion,/*op_toperacion de pf_operacion */
                        @i_tplazo         = null, /* Nemonico del tipo de plazo */ 
                        @i_operacionpf    = @i_op_operacion,
                        @i_valor          = @w_ajuste, 
                        @i_moneda         = @i_op_moneda, 
                        @i_afectacion     = @w_tipo,  /* N=Normal,  R=Reverso  */
                        @i_descripcion    = @w_descripcion,
                        @o_comprobante    = @o_comprobante out
            if @w_return <> 0
            begin
               exec cobis..sp_cerror
                    @t_debug       = @t_debug,
                    @t_file        = @t_file,
                    @t_from        = @w_sp_name,
                    @i_num         = @w_return

               goto ERROR
            end

	--CVA Jul-10-06 para que inserte los registros en pf_prov_dia cuando se cambia fecha valor
	if @i_camb_datos = 'S'
	begin
		--borra registros de provision para reinsertarlos
		delete pf_prov_dia
		where pd_fecha_proceso  >= @i_fecha_valor    --I.CVA Abr-09-07 Elimina solo la provision calculada desde el ultimo periodo de renovaci¢n
                  and pd_operacion 	 = @i_op_operacion

		--calcula dias provisionados
		if @i_op_base_calculo = 365
		begin
		   select @w_dias = datediff(dd,@i_fecha_valor,@s_date)
		end
		else
		begin
		   exec sp_funcion_1 @i_operacion = 'DIFE30',
                        @i_fechai   = @i_fecha_valor,
                        @i_fechaf   = @s_date,
                        @i_dia_pago  = @i_dia_pago, --*-*
                        @o_dias     = @w_dias out
		end    

		exec @w_return = sp_calc_diario_int
			@s_ssn           = @s_ssn,
			@s_user          = @s_user,
			@s_ofi           = @s_ofi,
			@s_date          = @s_date,
			@s_srv           = @s_srv,
			@s_lsrv          = @s_lsrv,
			@s_term          = @s_term, 
			@s_ofi           = @s_ofi,
			@s_rol           = @s_rol,
			@t_debug         = @t_debug,
			@t_file          = @t_file, 
			@t_from          = @t_from,
			@t_trn           = 14926,  
			@i_ejecuta_contable = 'N', 
			@i_fecha_proceso = @i_fecha_valor,  
			@i_num_banco     = @i_cuenta,
			@i_dias_interes  = @w_dias
		if @w_return <> 0
		begin
	               exec cobis..sp_cerror
	                    @t_debug       = @t_debug,
        	            @t_file        = @t_file,
                	    @t_from        = @w_sp_name,
	                    @i_num         = @w_return

			goto ERROR
		end 
	end

	--*-* Calcula los nuevos registros de provision de pf_prov_dia
	if @i_fecha_cambio < @s_date	
	begin
		--borra registros de provision para reinsertarlos
		delete pf_prov_dia
		where pd_fecha_proceso >= @i_fecha_cambio 
		  and pd_operacion 	= @i_op_operacion
	
		--calcula dias provisionados
		
		if @i_op_base_calculo = 365
		begin
		   select @w_dias = datediff(dd,@i_fecha_cambio,@s_date)
		end   
		else
		begin
		   exec sp_funcion_1 @i_operacion = 'DIFE30',
                        @i_fechai   = @i_fecha_valor,
                        @i_fechaf   = @s_date,
                        @i_dia_pago  = @i_dia_pago, --*-*
                        @o_dias     = @w_dias out
                end         

		exec @w_return = sp_calc_diario_int
			@s_ssn           = @s_ssn,
			@s_user          = @s_user,
			@s_ofi           = @s_ofi,
			@s_date          = @s_date,
			@s_srv           = @s_srv,
			@s_lsrv          = @s_lsrv,
			@s_term          = @s_term, 
			@s_ofi           = @s_ofi,
			@s_rol           = @s_rol,
			@t_debug         = @t_debug,
			@t_file          = @t_file, 
			@t_from          = @t_from,
			@t_trn           = 14926,  
			@i_ejecuta_contable = 'N', --+-+
			@i_fecha_proceso = @i_fecha_cambio,  
			@i_num_banco     = @i_cuenta,
			@i_dias_interes  = @w_dias
		if @w_return <> 0
		begin
	               exec cobis..sp_cerror
	                    @t_debug       = @t_debug,
        	            @t_file        = @t_file,
                	    @t_from        = @w_sp_name,
	                    @i_num         = @w_return

			goto ERROR
		end 
		
		--ajusta en caso de ser necesario el primer dia 
		select @w_acumulado_int_gan = sum(isnull(pd_valor,0))
		from pf_prov_dia 
		where pd_operacion = @i_op_operacion
		and pd_fecha_proceso between @i_fecha_ult_pg_int and @s_date 
	
		--print '@i_int_ganado_n:%1!,@w_acumulado_int_gan:%2!',@i_int_ganado_n,@w_acumulado_int_gan
	
		if @i_new_int_ganado <> @w_acumulado_int_gan
		begin
			update pf_prov_dia
			set pd_valor = pd_valor + (@i_new_int_ganado - @w_acumulado_int_gan)
			where pd_operacion = @i_op_operacion
			and pd_fecha_proceso = @i_fecha_cambio
		end
	end --update pf_prov_dia

	end --ajuste > 0

   end /* Contabilizacion de ajuste de Intereses */

   -----------------------------------------------
   -- Actualizacion de cuotas segun nuevo calculo
   -----------------------------------------------
   if @i_op_fpago = 'PER' 
   begin
      --------------------------------------------------------------------
      -- Actualizacion de la cuota por cambio de fecha valor
      --------------------------------------------------------------------
      if @i_camb_datos = 'S' 
      begin
--         print 'actualiza fecha valor en pf_cuotas'

         select @w_fecha_proceso = @i_fecha_valor
         
         
         if @i_op_base_calculo = 365
	 begin
	    select @w_dias_cuota = datediff(dd,@i_fecha_valor,@i_op_fecha_pg_int)
	 end
	 else
	 begin
	    exec sp_funcion_1 @i_operacion = 'DIFE30',
               @i_fechai   = @i_fecha_valor,
               @i_fechaf   = @i_op_fecha_pg_int,
               @i_dia_pago  = @i_dia_pago, --*-*
               @o_dias     = @w_dias_cuota out
	 end    

         Update pf_cuotas
            set cu_fecha_ult_pago  = @i_fecha_valor,
                cu_fecha_pago      = @i_op_fecha_pg_int,
                cu_num_dias        = @w_dias_cuota,
                cu_valor_cuota     = @i_int_estimado,
                cu_valor_neto      = @i_int_estimado,
                cu_tasa            = @i_tasa,
                cu_base_calculo    = @i_op_base_calculo,
                cu_ppago           = @i_op_ppago,
                cu_fecha_mod       = @s_date
          where cu_operacion = @i_op_operacion
            and cu_cuota     = 1

         select @i_op_fecha_pg_int = @i_fecha_valor
         
	--I. CVA Jul-12-06 para que en sp_actualiza_cuota_dp borre todas las cuotas y regenere el sp_cuotas
	 select @w_cu_cuota = 1 
	--F. CVA Jul-12-06
   
      end
      else
         select @w_fecha_proceso = @s_date



      ---------------------------------
      -- Borrado de la tabla historica
      ---------------------------------
      set rowcount 0
      delete cob_pfijo..pf_cuotas_his   where ch_operacion = @i_op_operacion      
      
      --------------------------------------------------------------------
      -- Generacion de nuevo archivo de cuotas por operacion 
      --------------------------------------------------------------------      
      exec @w_return = sp_actualiza_cuota_dp
           @s_ssn                 = @s_ssn,
           @s_user                = @s_user,
           @s_sesn                = @s_sesn,
           @s_ofi                 = @s_ofi,
           @s_date                = @s_date,
           @s_srv                 = @s_srv,
           @s_term                = @s_term,
           @t_trn                 = 14146,
           @t_file                = @t_file,
           @t_from                = @w_sp_name,
           @t_debug               = @t_debug,

           @i_dia_pago            = @i_dia_pago,
           @i_fecha_proceso       = @w_fecha_proceso,
           @i_op_operacion        = @i_op_operacion,
           @i_plazo_ant           = @i_num_dias_ant,
           @i_fecha_pg_int_ant    = @i_fecha_pg_int_ant,
           @i_fpago_ant           = @i_fpago_ant,
	   @i_modifica            = @i_modifica,  --CVA Jun-29-06
	   @i_cuota               = @w_cu_cuota   --CVA Jul-12-06
      if @w_return <> 0
      begin
               exec cobis..sp_cerror
                    @t_debug       = @t_debug,
                    @t_file        = @t_file,
                    @t_from        = @w_sp_name,
                    @i_num         = 145052
               select @w_return = 145052
               goto ERROR
      end

   end --fpago = 'PER'

   
commit tran
return 0

------------------------------
-- Manejo de mensaje de error
------------------------------
ERROR:
  rollback tran

  if @i_en_linea = 'N'
  begin
     exec sp_errorlog @i_fecha   = @s_date,
                      @i_error   = @w_error,
                      @i_usuario = @s_user,
                      @i_tran    = @t_trn,
                      @i_cuenta  = @i_cuenta
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
