/************************************************************************/
/*	Archivo: 		buscons1.sp	    		        */
/*	Stored procedure: 	sp_busca_cons1				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     24-octubre-1997				*/
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
/*      Consulta a saldos consolidados segun corte seleccionado         */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	24/Oct/1997	Martha Gil     Emision Inicial			*/
/*      18/Dic/1997     Martha Gil     Eliminar validacion de existen-  */
/*                                     en cb_plan_general               */
/*	15-Feb-1999	Juan C. G¢mez	Nuevo par metro JCG10		*/
/*	08-Mar-1999	Juan C. G¢mez	Se comentarean campos del query */
/*					JCG20				*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_busca_cons1')
	drop proc sp_busca_cons1     
go
create proc sp_busca_cons1    (
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
	@i_operacion	char(1),
	@i_modo		smallint = null,
	@i_empresa	tinyint  = null,
	@i_cuenta     	cuenta = null,
	@i_cuenta1    	cuenta = null,
	@i_oficina 	smallint = null,
	@i_area		smallint = null,
	@i_periodo      int  = null,
	@i_corte	smallint = null,
        @i_fecha_inicio    datetime = null,   
	@i_fecha_fin	datetime = null,
	@i_formato_fecha smallint = null,
        @i_frecuencia   char(1)   = null,
        @i_factor       tinyint = null, 
	@i_escala	int	--JCG10
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_empresa	tinyint,
	@w_cuenta  	cuenta,
	@w_secuencial	smallint,
	@w_operador	int,
	@w_tipo_dinamica	char(1),
	@w_categoria	char(10),
	@w_texto	char(255),
	@w_disp_legal	char(255),
	@w_periodo	int,
	@w_corte	smallint,
	@w_estado       char(1),
        @num_registros  int,
	@w_existe	tinyint		/* codigo existe = 1 
				               no existe = 0 */
select @w_today = getdate()
select @w_sp_name = 'sp_busca_cons1'


/************************************************/
/*  Tipo de Transaccion =     			*/

if (@t_trn <> 6578 and @i_operacion = 'A') or (@t_trn <> 6579 and @i_operacion = 'S') 
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
		i_empresa	= @i_empresa,
		i_cuenta     	= @i_cuenta,
		i_oficina	= @i_oficina,
		i_periodo    	= @i_periodo
	exec cobis..sp_end_debug
end


if @i_operacion = 'A'
   begin
        set rowcount 20

	if @i_modo = 0
	begin
                exec @w_return = cob_conta..sp_corte1
                @s_ssn,@s_date,@s_user,@s_term,@s_corr,
                @s_ssn_corr,@s_ofi,@t_rty,6329,
                'N',NULL,NULL,'I',@i_modo,
                @i_periodo,
                @i_empresa,
                @i_fecha_inicio,
                @i_fecha_fin,
                @i_frecuencia ,null,null,null,
                'N',@i_formato_fecha,@i_factor

                if @w_return <> 0
                begin
                        /* 'Error en insercion de cortes' */
                        exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 603018
                        return 1
                end

                select 'Corte'=convert(char(10),tmp_fecha_fin,@i_formato_fecha),
			'Saldo en moneda nacional' = sum(hi_saldo) / @i_escala,
			'Saldo en moneda extranjera' = sum(hi_saldo_me) / @i_escala
                from cob_conta_his..cb_hist_saldo, cob_conta..cb_cuenta, cob_conta..corte_tmp
                where   hi_empresa = @i_empresa and
                	hi_periodo = @i_periodo and
                	hi_corte   = tmp_corte and
                        hi_oficina in (select je_oficina
                	               from cb_jerarquia
        	                       where je_empresa = @i_empresa and
                        	       (je_oficina_padre = @i_oficina or
                                	je_oficina = @i_oficina)) and
                        hi_area in (select ja_area 
	                               from cb_jerararea
        	                       where ja_empresa = @i_empresa and
                	               (ja_area_padre = @i_area or
                        	        ja_area = @i_area)) and
			hi_cuenta =  @i_cuenta and
                        cu_empresa = @i_empresa and
                        cu_cuenta  = @i_cuenta and
                        tmp_periodo = @i_periodo and
                        tmp_empresa = @i_empresa and
                        tmp_tipo_corte  = @i_frecuencia
                group by tmp_fecha_fin, cu_categoria,  hi_saldo, hi_saldo_me


		if @@rowcount = 0
		begin
			/* 'No existen Saldos para la Cuenta Especificada' */
		/*	exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601065 */
			set rowcount 0
			return 1
		end
                set rowcount 0
	end

	if @i_modo = 1
	begin
		select 'corte' = convert(char(10),tmp_fecha_fin,@i_formato_fecha),
			'Saldo en moneda nacional' = sum(hi_saldo) / @i_escala,
			'Saldo en moneda extranjera' = sum(hi_saldo_me) / @i_escala
                from cob_conta_his..cb_hist_saldo, cob_conta..cb_cuenta, cob_conta..corte_tmp
                where   hi_empresa = @i_empresa and
                        hi_periodo = @i_periodo  and
                        hi_corte = tmp_corte and
                        hi_oficina in (select je_oficina
                	               from cb_jerarquia
        	                       where je_empresa = @i_empresa and
                        	       (je_oficina_padre = @i_oficina or
                                	je_oficina = @i_oficina)) and
                        hi_area in (select ja_area 
	                               from cb_jerararea
        	                       where ja_empresa = @i_empresa and
                	               (ja_area_padre = @i_area or
                        	        ja_area = @i_area)) and
			hi_cuenta =  @i_cuenta and
                        cu_empresa = @i_empresa and
                        cu_cuenta  = hi_cuenta and
                        tmp_periodo = @i_periodo and
			tmp_empresa = @i_empresa and
                        tmp_tipo_corte  = @i_frecuencia and
                        tmp_fecha_fin > @i_fecha_fin
                group by tmp_fecha_fin, cu_categoria, hi_saldo, hi_saldo_me

		if @@rowcount = 0
		begin
			/* 'No existen Saldos para la Cuenta Especificada' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601065
			set rowcount 0
			return 1
		end
                set rowcount 0
	end

        if @i_modo = 2
	begin
		select 'Corte' = convert(char(10),tmp_fecha_fin,@i_formato_fecha),
			'Saldo en moneda nacional' = sum(sa_saldo) / @i_escala,
			'Saldo en moneda extranjera' = sum(sa_saldo_me) / @i_escala
                from cob_conta..corte_tmp, cob_conta..cb_saldo, cob_conta..cb_cuenta
                where   tmp_periodo = @i_periodo and
                	tmp_empresa = @i_empresa and
                        tmp_tipo_corte = @i_frecuencia and
                        sa_empresa = @i_empresa and
                        sa_periodo = @i_periodo and
                        sa_corte = tmp_corte and
                        sa_oficina in (select je_oficina
                	               from cb_jerarquia
        	                       where je_empresa = @i_empresa and
                        	       (je_oficina_padre = @i_oficina or
                                	je_oficina = @i_oficina)) and
                        sa_area in (select ja_area 
	                               from cb_jerararea
        	                       where ja_empresa = @i_empresa and
                	               (ja_area_padre = @i_area or
                        	        ja_area = @i_area)) and
                        sa_cuenta =  @i_cuenta and
			cu_empresa = @i_empresa and
                        cu_cuenta  = sa_cuenta
                group by tmp_fecha_fin, cu_categoria, sa_saldo, sa_saldo_me
 
		if @@rowcount = 0
		begin
			   /*'No existen Saldos para Cuenta Especificada'*/
		   	exec cobis..sp_cerror
			   @t_debug = @t_debug,
			   @t_file	 = @t_file,
			   @t_from	 = @w_sp_name,
			   @i_num	 = 601065
			   set rowcount 0
			   return 1
		end
                set rowcount 0
	end

        if @i_modo = 3
        begin

	   select 'Corte' = convert(char(10),tmp_fecha_fin,@i_formato_fecha),
			'Saldo en moneda nacional' = sa_saldo / @i_escala,
			'Saldo en moneda extranjera' = sa_saldo_me / @i_escala
                from cob_conta..corte_tmp, cob_conta..cb_saldo, cob_conta..cb_cuenta
                where   tmp_periodo = @i_periodo and
                	tmp_empresa = @i_empresa and
                        tmp_tipo_corte  = @i_frecuencia and
                        sa_empresa = @i_empresa and
                        sa_periodo = @i_periodo and
                        sa_corte = tmp_corte and
                        sa_oficina in (select je_oficina
                	               from cb_jerarquia
        	                       where je_empresa = @i_empresa and
                        	       (je_oficina_padre = @i_oficina or
                                	je_oficina = @i_oficina)) and
                        sa_area in (select ja_area 
	                               from cb_jerararea
        	                       where ja_empresa = @i_empresa and
                	               (ja_area_padre = @i_area or
                        	        ja_area = @i_area)) and
                        sa_cuenta = @i_cuenta  and
                        tmp_fecha_fin > @i_fecha_fin and
			cu_empresa = @i_empresa and
                        cu_cuenta  = sa_cuenta
                group by tmp_fecha_fin, cu_categoria , sa_saldo, sa_saldo_me
 
		if @@rowcount = 0
		begin
			/*'No existen Saldos para Cuenta Especificada'*/
		   	exec cobis..sp_cerror
			   @t_debug = @t_debug,
			   @t_file	 = @t_file,
			   @t_from	 = @w_sp_name,
			   @i_num	 = 601065
			   set rowcount 0
			   return 1
		end
                set rowcount 0
        end
return 0
end

if @i_operacion = 'S'
begin
	select @num_registros = count(1)
 	from cob_conta..corte_tmp, cob_conta..cb_saldo
        where   tmp_periodo = @i_periodo and
        	tmp_empresa = @i_empresa and
                tmp_tipo_corte  = @i_frecuencia and
                sa_empresa = @i_empresa and
                sa_periodo = @i_periodo  and
                sa_corte   = tmp_corte and
                sa_oficina in (select je_oficina
        	               from cb_jerarquia
	                       where je_empresa = @i_empresa and
                	       (je_oficina_padre = @i_oficina or
                        	je_oficina = @i_oficina)) and
                sa_area in (select ja_area 
                               from cb_jerararea
	                       where ja_empresa = @i_empresa and
        	               (ja_area_padre = @i_area or
                	        ja_area = @i_area)) and
		sa_cuenta =  @i_cuenta
	if @@rowcount = 0
	begin
		select @num_registros = 0
		select @num_registros
	end
	else
		select @num_registros

return 0
end

go
