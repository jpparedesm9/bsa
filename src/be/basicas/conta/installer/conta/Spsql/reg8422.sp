/************************************************************************/
/*      Archivo           :  reg8422.sqr				*/
/*      Base de datos     :  cob_conta                                  */
/*      Producto          :  Contabilidad                               */
/*      Disenado por      :  Jorge Rivera Farino                        */
/*      Fecha de escritura:  19/Abr/95                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Permite recuperar los saldos de las cuentas que intervienen     */
/*      en el proceso de saldo de fondos financieros                    */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR           RAZON                           */
/*      08/Nov/94     J. Rivera         Emision Inicial                 */ 
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_reg8422') 
	drop proc sp_reg8422  
go 

create proc sp_reg8422 (
	@s_ssn			int = null,
	@s_date			datetime = null,
	@s_user			login = null,
	@s_term			descripcion = null,
	@s_corr			char(1) = null,
	@s_ssn_corr		int = null,
        @s_ofi	        	smallint = null,
	@t_rty			char(1) = null,
        @t_trn			smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1) = null,
	@i_modo			smallint = null,
	@i_proceso		smallint = null,
	@i_empresa  		tinyint	 = null, 
	@i_organizacion		tinyint	 = null, 
	@i_oficina		smallint = null,
	@i_fecha		datetime = null,
	@i_condicion		char(3)  = null,
	@i_cuenta		cuenta = null,
	@i_cta_asoc		cuenta = null
)
as
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_numero_actual int,
	@w_estado	char(1),
	@w_corte	int,
	@w_siguiente	int,
	@w_periodo	int,
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_reg8422'

if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_modo		= @i_modo,
		i_empresa  	= @i_empresa, 
		i_oficina	= @i_oficina,
		i_fecha		= @i_fecha		
	exec cobis..sp_end_debug
end

/************************************************/
/*  Tipo de Transaccion =     			*/

if @t_trn <> 6610
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end
/************************************************/
	exec @w_return = cob_conta..sp_pericort @i_empresa 	= @i_empresa,
                                                @i_fecha_tran 	= @i_fecha,
						@o_corte 	= @w_corte out,
						@o_periodo 	= @w_periodo out
	if @w_return <> 0
	begin
		return @w_return
	end

if @i_operacion = 'S'
begin
  if @i_modo = 0
     begin
	set rowcount 15
	select  cp_condicion,		cp_cuenta,	
      		bl_saldo_mna,   	bl_saldo_dol,  
      		bl_saldo_uvc, 		bl_saldo_mna_s, 
      		bl_saldo_dol_s, 	bl_saldo_uvc_s, 
		ca_condicion,		ca_cta_asoc,
		ca_debcred
	from 	cb_oficina,		cb_balsuper,	
		cb_cuenta_proceso,	cb_cuenta_asociada
	where of_empresa   	= @i_empresa
  	and of_oficina  	= @i_oficina
  	and cp_empresa   	= @i_empresa
  	and cp_proceso   	= @i_proceso
  	and bl_empresa   	= @i_empresa
  	and bl_oficina   	= of_oficina 
  	and bl_cuenta    	= ca_cta_asoc
  	and bl_periodo   	= @w_periodo
  	and bl_corte     	= @w_corte
	and ca_empresa   	= @i_empresa
	and ca_cuenta   	= cp_cuenta
	and ca_proceso   	= cp_proceso
	order by cp_condicion,	cp_cuenta,	ca_cta_asoc
     end
  else
     begin
	select  cp_condicion,		cp_cuenta,	
      		bl_saldo_mna,   	bl_saldo_dol,  
      		bl_saldo_uvc, 		bl_saldo_mna_s, 
      		bl_saldo_dol_s, 	bl_saldo_uvc_s, 
		ca_condicion,		ca_cta_asoc,
		ca_debcred
	from 	cb_oficina,		cb_balsuper,	
		cb_cuenta_proceso,	cb_cuenta_asociada
	where 	of_empresa   		= @i_empresa
  		and of_oficina 		= @i_oficina 
  		and cp_empresa   	= @i_empresa
  		and cp_proceso   	= @i_proceso 
		and ca_empresa   	= @i_empresa
		and ca_cuenta   	= cp_cuenta
		and ca_proceso   	= cp_proceso and
	       (
  		(convert(int,cp_condicion)   	= convert(int,@i_condicion)
  	        and cp_cuenta    	= @i_cuenta 
		and ca_cta_asoc         > @i_cta_asoc)  or
  		(convert(int,cp_condicion)   	= convert(int,@i_condicion)
  	        and cp_cuenta    	> @i_cuenta)  or
  		(convert(int,cp_condicion)   	> convert(int,@i_condicion)))
  		and bl_empresa   	= @i_empresa
  		and bl_periodo   	= @w_periodo
  		and bl_corte     	= @w_corte
  		and bl_oficina   	= of_oficina
  		and bl_cuenta    	= ca_cta_asoc 
	order by cp_condicion,	cp_cuenta, 	ca_cta_asoc
      end
end
go
