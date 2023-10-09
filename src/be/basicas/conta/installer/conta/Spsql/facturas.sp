/************************************************************************/
/*	Archivo: 		facturas.sp			        */
/*	Stored procedure: 	sp_facturas				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Rafael Villota C                      	*/
/*	Fecha de escritura:     03-Abril-1997				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*      Busqueda, captura y proceso de facturas				*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	03-Abr-1997	Rafael Villota  Emision Inicial			*/
/*	03-May-1997	Ileana Michaels Actualizacion cb_retencion	*/
/*	15/Dic/1997	Juan Carlos Gomez Ingreso de nuevos parametros  */
/*			JCG10						*/ 
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_facturas')
	drop proc sp_facturas
go
create proc sp_facturas   (
		@s_ssn			int = null,
		@s_date			datetime = null,
		@s_user			login = null,
		@s_term			descripcion = null,
		@s_corr			char(1) = null,
		@s_ssn_corr		int = null,
        	@s_ofi			smallint = null,
		@t_rty			char(1) = null,
        	@t_trn			smallint = null,
		@t_debug		char(1) = 'N',
		@t_file			varchar(14) = null,
		@t_from			varchar(30) = null,
		@i_operacion		char(1) = null,
		@i_cond			char(3) = null,
		@i_modo			smallint = null,
		@i_valor		money = null,
        	@i_empresa		tinyint = null,   /* JCG10 */
		@i_ciudad             	int = null,       /* JCG10 */
		@i_cuenta		cuenta = null,
		@i_actividad		varchar(20) = null,
		@i_tipo_ter		varchar(3) = null,
		@i_retencion		char(3) = null,
		@i_codigo		char(4) = null,/* JCG10 */
	        @i_comprob		int = null, /*IMM*/
	        @i_val_iva		money = null, 
	        @i_val_ica		money = null,
	        @i_val_iva_ret		money = null
		
	)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_numerror	int,
	@w_siguiente	int,
	@w_porcentaje	money,
	@w_valor_iva	money,
	@w_valor_ica	money,
	@w_valor_ret	money,
	@w_valor_iva_desc money,
	@w_iva 		char,
	@w_ica		char,
	@w_ret		char,
	@w_desc		char,
	@w_iva_cod	char(2),
	@w_codigo	char(4),	/* JCG10 */
	@w_cuenta       cuenta
	
	


/*select @w_today = convert(char(12),getdate(),@i_formato_fecha)*/
select @w_sp_name = 'sp_facturas' , @w_numerror = 0
-- temporal error del kernel select @s_user =@i_usuario


/************************************************/
if (@t_trn <> 6997 and @i_operacion = 'Q') or
   (@t_trn <> 6615 and @i_operacion = 'B') or 
   (@t_trn <> 6616 and @i_operacion = 'U')  
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
if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa	= @i_empresa,  /* JCG10 */
		i_cuenta	= @i_cuenta,
		i_valor		= @i_valor,
		i_tipo_ter	= @i_tipo_ter,
		i_cond		= @i_cond,
		i_actividad	= @i_actividad,
		i_retencion	= @i_retencion
	exec cobis..sp_end_debug
end


if @i_operacion = 'B'
begin
     select @w_cuenta = cp_cuenta
     from cb_cuenta_proceso
     where cp_proceso = 6995
       and cp_condicion = @i_cond
     select @w_cuenta
end  

if @i_operacion = 'Q'
begin
	select @w_valor_iva = 0
	select @w_valor_ica = 0
	select @w_valor_iva_desc = 0
	select @w_valor_ret = 0
	
 
/*	select @w_tipo_ter = te_reg_fiscal,
	       @w_actividad = te_actividad
	from cb_retencion,cb_tercero
	where re_cuenta = @i_cuenta
	and   re_identifica  =  te_identifica */

	select @w_iva = im_iva,
	       @w_ica = im_ica,
	       @w_ret = im_retencion,
               @w_desc= im_descontado
     	from cb_impuestos
	where im_tipoter = @i_tipo_ter

        if @w_iva = 'S' 
	begin
 		select @w_porcentaje = iva_porcentaje
		from cb_iva
		where iva_empresa = @i_empresa and   /* JCG10 */
		      iva_codigo =  @i_codigo        /* JCG10 */

		select @w_valor_iva = @i_valor * @w_porcentaje/100
        end

        if @w_ica = 'S'
        begin
                select @w_porcentaje = ic_porcentaje
                from cb_ica,cb_tercero
		where	ic_empresa = @i_empresa and  /* JCG10 */ 
  			ic_ciudad = @i_ciudad   and  /* JCG10 */
			ic_codigo = @i_actividad 

                select @w_valor_ica = (@i_valor / 1000) * @w_porcentaje
        end      

        if @w_desc = 'S'
        begin
                select @w_porcentaje = iva_des_porcen
                from cb_iva
		where iva_empresa = @i_empresa and   /* JCG10 */
                      iva_codigo =  @i_codigo        /* JCG10 */

                select @w_valor_iva_desc = @i_valor * @w_porcentaje/100
        end  

        if @w_ret = 'S'
        begin
                select @w_porcentaje = cr_porcentaje
                from cb_conc_retencion
		where	cr_empresa = @i_empresa and /* JCG10 */
			cr_codigo = @i_retencion

                select @w_valor_ret = @i_valor * @w_porcentaje/100
        end  

	select  @w_valor_iva,
		@w_valor_ica,
		@w_valor_iva_desc,
		@w_valor_ret,
		@i_valor
	
end

/* Actualizacion de cb_retencion - IMM */
if @i_operacion = 'U'
begin
	select @w_iva_cod = iva_codigo
	  from cb_iva
	  where iva_empresa = @i_empresa and   /* JCG10 */
                iva_codigo =  @i_codigo        /* JCG10 */

	update 	cb_retencion 
    	set 	re_valor_asiento = @i_valor,
		re_valor_iva = @i_val_iva,
		re_valor_ica = @i_val_ica,
		re_iva_retenido = @i_val_iva_ret,
		re_con_iva = @w_iva_cod
	where 	re_comprobante = @i_comprob
end
go
