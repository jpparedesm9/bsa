/************************************************************************/
/*	Archivo: 		compastt.sp			        */
/*	Stored procedure: 	sp_tsasiento				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           M.Suarez I.                            	*/
/*	Fecha de escritura:     10/Oct/1995   				*/
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
/*	Inserta los asientos de un comprobante a la tabla temporal para */
/*	 las transacciones de perfiles contables.                       */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	10-Oct/1995	M.Suarez        Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_tsasiento')
	drop proc sp_tsasiento  
go

create proc sp_tsasiento   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1) = null,
	@i_fecha_tran	datetime = null,
        @i_comprobante	int = null,    
	@i_empresa 	tinyint = null,
	@i_producto 	tinyint = null,
	@i_asiento	smallint = null,
	@i_cuenta   	cuenta = null,
	@i_oficina_dest smallint = null,
	@i_area_dest    smallint  = null,
	@i_valor	money = null,
	@i_valor_me	money = null,
        @i_debcred      char(1)=null,
	@i_concepto	descripcion = null,
	@i_cotizacion	money = null,
	@i_tipo_doc	char(1) =null,
	@i_tipo_tran	char(1) = null,
	@i_moneda 	tinyint = 0,
        @i_param1       varchar(10) = null,
        @i_param2       varchar(10) = null,
        @i_param3       varchar(10) = null,
        @i_param4       varchar(10) = null,
        @i_param5       varchar(10) = null,
        @i_param6       varchar(10) = null,
        @i_param7       varchar(10) = null,
        @i_param8       varchar(10) = null,
        @i_param9       varchar(10) = null,
        @i_param10      varchar(10) = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_moneda	tinyint,	/* codigo de moneda de la cuenta */
	@w_cuenta	cuenta,
        @w_debito       money,
        @w_credito      money,
        @w_debito_me    money,
        @w_credito_me   money,
        @w_moneda_base  tinyint,
	@w_posini	tinyint,
        @w_posfin       tinyint,
        @w_count        tinyint,
        @w_clave        char(10),
        @w_string       char(10)

select @w_today = getdate()
select @w_sp_name = 'sp_tsasiento'


/************************************************/
/*  Tipo de Transaccion =  			*/

if @t_trn <> 6952
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
		i_fecha_tran	= @i_fecha_tran,
		i_comprobante	= @i_comprobante,
		i_empresa   	= @i_empresa,      
		i_asiento	= @i_asiento,
		i_cuenta     	= @i_cuenta ,
		i_oficina_dest	= @i_oficina_dest,
		i_area_dest	= @i_area_dest,
		i_concepto	= @i_concepto,
		i_cotizacion	= @i_cotizacion,
		i_tipo_doc	= @i_tipo_doc,
		i_tipo_tran	= @i_tipo_tran
	exec cobis..sp_end_debug
end

/**************** VALIDACIONES ***********************/

	if NOT EXISTS (select * from cb_empresa 
			where em_empresa = @i_empresa)
	begin
             -- Empresa especificada no existe  
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601018
		return 1
	end
        select @w_moneda_base = em_moneda_base
          from cb_empresa where em_empresa = @i_empresa
	if NOT EXISTS (select * from cobis..cl_producto 
			where pd_producto = @i_producto)
	begin
            --  Producto no existe
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 151011
		return 1
	end
        if NOT EXISTS (select * from cb_oficina where
                        of_empresa = @i_empresa and 
                        of_oficina = @i_oficina_dest and of_movimiento = 'S')
	begin
	        -- Oficina no existe o no es de movimiento
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601131
		return 1
	end
        if NOT EXISTS (select * from cb_area where
                        ar_empresa = @i_empresa and 
                        ar_area    = @i_area_dest and ar_movimiento = 'S')
	begin
	        -- Oficina no existe o no es de movimiento
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601132
		return 1
	end
     select @w_posini = 1, @w_posfin = 0, @w_count = 0
     while @w_posfin < len(@i_cuenta)  -- Reemplazar parametros
     begin
        select @w_string = substring(@i_cuenta,@w_posini,len(@i_cuenta))
        select @w_posfin = charindex('.',@w_string)
        if @w_posfin = 0
           select @w_posfin = len(@i_cuenta)
        else
           select @w_posfin = @w_posfin - 1 
        select @w_string = substring(@i_cuenta,@w_posini,@w_posfin)
        if ascii(@w_string) > 47 and ascii(@w_string) < 58 -- Es Parte numerica
        begin
           select @w_posini, @w_posfin
           select @w_cuenta = @w_cuenta + rtrim(@w_string)
           select @w_posini = @w_posini + @w_posfin + 1 --No considera el punto 
           continue
        end
        select @w_count = @w_count + 1
        if @w_count = 1
        begin 
           select @w_posini, @w_posfin
           select @w_cuenta = @w_cuenta + rtrim(re_substring)
             from cb_relparam where re_empresa = @i_empresa 
                                and re_parametro = @w_string
                                and re_clave = @i_param1
        end
        if @w_count = 2
        begin 
           select @w_posini, @w_posfin
           select @w_cuenta = @w_cuenta + rtrim(re_substring)
             from cb_relparam where re_empresa = @i_empresa 
                                and re_parametro = @w_string
                                and re_clave = @i_param2
        end
        if @w_count = 3
        begin 
           select @w_posini, @w_posfin
           select @w_cuenta = @w_cuenta + rtrim(re_substring)
             from cb_relparam where re_empresa = @i_empresa 
                                and re_parametro = @w_string
                                and re_clave = @i_param3
        end
        if @w_count = 4
        begin 
           select @w_posini, @w_posfin
           select @w_cuenta = @w_cuenta + rtrim(re_substring)
             from cb_relparam where re_empresa = @i_empresa 
                                and re_parametro = @w_string
                                and re_clave = @i_param4
        end
        if @w_count = 5
        begin 
           select @w_posini, @w_posfin
           select @w_cuenta = @w_cuenta + rtrim(re_substring)
             from cb_relparam where re_empresa = @i_empresa 
                                and re_parametro = @w_string
                                and re_clave = @i_param5
        end
        if @w_count = 6
        begin 
           select @w_posini, @w_posfin
           select @w_cuenta = @w_cuenta + rtrim(re_substring)
             from cb_relparam where re_empresa = @i_empresa 
                                and re_parametro = @w_string
                                and re_clave = @i_param6
        end
        if @w_count = 7
        begin 
           select @w_posini, @w_posfin
           select @w_cuenta = @w_cuenta + rtrim(re_substring)
             from cb_relparam where re_empresa = @i_empresa 
                                and re_parametro = @w_string
                                and re_clave = @i_param7
        end
        if @w_count = 8
        begin 
           select @w_posini, @w_posfin
           select @w_cuenta = @w_cuenta + rtrim(re_substring)
             from cb_relparam where re_empresa = @i_empresa 
                                and re_parametro = @w_string
                                and re_clave = @i_param8
        end
        if @w_count = 9
        begin 
           select @w_posini, @w_posfin
           select @w_cuenta = @w_cuenta + rtrim(re_substring)
             from cb_relparam where re_empresa = @i_empresa 
                                and re_parametro = @w_string
                                and re_clave = @i_param9
        end
        if @w_count = 10
        begin 
           select @w_posini, @w_posfin
           select @w_cuenta = @w_cuenta + rtrim(re_substring)
             from cb_relparam where re_empresa = @i_empresa 
                                and re_parametro = @w_string
                                and re_clave = @i_param10
        end
        select @w_posini = @w_posini + @w_posfin + 1 --No considera el punto 
   End -- fin del while
       if NOT EXISTS (select * from cb_cuenta
			where cu_empresa = @i_empresa and
			      cu_cuenta = @w_cuenta and cu_movimiento = 'S')
	begin
            --  Cuenta no existe o no es de movimiento
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601055
		return 1
	end 

	if NOT EXISTS (select * from cob_conta..cb_plan_general
			where 	pg_empresa = @i_empresa and
				pg_cuenta = @w_cuenta and
				pg_oficina = @i_oficina_dest and
				pg_area = @i_area_dest)
	begin
            --  Cuenta no esta relacionada a oficina area
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601158
		return 1
	end 

	select @w_moneda = cu_moneda
		from cob_conta..cb_cuenta
		where cu_empresa = @i_empresa and
		      cu_cuenta  = @w_cuenta  
       if @i_moneda <> @w_moneda
	begin
            --  Codigo de moneda no corresponde
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607122
		return 1
	end 

       if (@i_tipo_doc <> 'N' and @i_moneda = @w_moneda_base) or
          (@i_tipo_doc =  'C' and @i_debcred <> '1') or
          (@i_tipo_doc =  'V' and @i_debcred <> '2')
	begin
            --  Asientos de Compra o Venta solo afectan a ctas M.E
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607123
		return 1
	end 
       
       select @w_debito    = 0, @w_credito    = 0,
              @w_debito_me = 0, @w_credito_me = 0

       if @i_debcred = '1'
          begin
          select @w_debito    = @i_valor
          select @w_debito_me = @i_valor_me
          end
       else begin
          select @w_credito   = @i_valor
          select @w_credito_me = @i_valor_me
       end
       if @i_moneda <> @w_moneda_base and @i_valor_me <> 0
          select @i_cotizacion = round((@i_valor / @i_valor_me),2)
begin tran
	insert into cb_tasiento     (
		ta_fecha_tran,ta_comprobante,ta_empresa,
		ta_asiento,ta_cuenta,
		ta_oficina_dest,ta_area_dest,
		ta_credito,ta_debito,ta_concepto,
		ta_credito_me,ta_debito_me,ta_cotizacion,
		ta_tipo_doc,ta_tipo_tran,ta_mayorizado,ta_moneda,ta_opcion)

	values (@i_fecha_tran,@i_comprobante,@i_empresa,
		@i_asiento,@w_cuenta,
		@i_oficina_dest,@i_area_dest,
		@w_credito,@w_debito,@i_concepto,
		@w_credito_me,@w_debito_me,@i_cotizacion,
		@i_tipo_doc,@i_tipo_tran,'N',@w_moneda,@i_producto)

	if @@error <> 0  
	begin
		/* 'Error en insercion del detalle del comprobante en la tabla temporal' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603020

		delete cob_conta..cb_tasiento
		where   ta_fecha_tran = @i_fecha_tran and
			ta_comprobante = @i_comprobante and
			ta_empresa = @i_empresa 

		delete cob_conta..cb_tcomprobante
		where 	ct_fecha_tran = @i_fecha_tran and
			ct_comprobante = @i_comprobante and
			ct_empresa = @i_empresa 
		return 1
	end
commit tran
return 0

go
