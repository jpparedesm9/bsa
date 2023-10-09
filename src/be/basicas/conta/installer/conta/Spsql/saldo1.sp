/************************************************************************/
/*	Archivo: 		saldo1.sp	    		        */
/*	Stored procedure: 	sp_saldo1   				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     28-octubre-1997				*/
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
/*	Consulta de Saldos segon corte solicitado                       */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	28/10/1997	Martha Gil      Emision Inicial			*/
/*      18/12/1997      Martha Gil      eliminar validacion de existen- */
/*                                      cia en cb_plan_general          */
/*	15-Feb-1999	Juan C. G¢mez	Nuevos par metro JCG10		*/
/*	09-Mar-1999	Juan C. G¢mez	Se comentarea campo del select  */
/*					JCG20				*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_saldo1')
	drop proc sp_saldo1    

go
create proc sp_saldo1    (
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
	@i_mes		tinyint = null,		
	@i_anio		tinyint = null,
 	@i_fecha	datetime = null,	
	@i_fecha_fin	datetime = null,
	@i_formato_fecha	tinyint = 1,
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
	@w_saldochar	char(30),	
	@w_texto	char(255),
	@w_disp_legal	char(255),
	@w_periodo	int,
	@w_corte	int,
	@w_existe	tinyint	,	/* codigo existe = 1 
				               no existe = 0 */
        @w_saldo         money, 
	@w_saldoacum	 money,
	@w_saldoacum1	 money,
        @w_credito       money,
        @w_credito1      money,
        @w_debito        money,
        @w_debito1       money, 
        @w_nombre        descripcion ,
	@w_estado        char(1),
   @fecha_s        char(10),
	@w_estado_corte	 char(1)

select @w_today = getdate()
select @w_sp_name = 'sp_saldo1'

/************************************************/
/*  Tipo de Transaccion =     			*/
if (@t_trn <> 6328 and @i_operacion = 'A') 
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

select 	@w_corte = co_corte, 
	@w_periodo = co_periodo,
	@w_estado_corte = co_estado
  from 	cb_corte
where 	co_empresa = @i_empresa and
      	co_fecha_ini <= @i_fecha and
      	co_fecha_fin >= @i_fecha

if @i_operacion = 'A'
    
   begin
        if NOT EXISTS (select * from cb_plan_general
		where pg_empresa = @i_empresa and
		      pg_oficina = @i_oficina and
		      pg_area = @i_area       and
		      pg_cuenta  = @i_cuenta)
        begin  
	    /* 'Cuenta consultada no existe    ' */
	    exec cobis..sp_cerror
	    @t_debug = @t_debug,
	    @t_file	 = @t_file,
	    @t_from	 = @w_sp_name,
	    @i_num	 = 609129

	    return 1
        end

        set rowcount 20

	if @i_modo = 0
	begin

	       exec @w_return = cob_conta..sp_corte1
               @s_ssn,@s_date,@s_user,@s_term,@s_corr,
               @s_ssn_corr,@s_ofi,@t_rty,6329,
               'N',NULL,NULL,'I',@i_modo,
                @i_periodo,
                @i_empresa,
                @i_fecha,
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


		select  'Corte' = convert(char(10),co_fecha_fin,
                                  @i_formato_fecha),
                        --'Saldo en pesos' = hi_saldo + hi_saldo_me , cu_categoria,JCG20
			'Saldo en moneda nacional' = hi_saldo / @i_escala,	--JCG10
			'Saldo en moneda extranjera' = hi_saldo_me / @i_escala	--JCG10
                from cob_conta_his..cb_hist_saldo,cob_conta..cb_corte, 
		     cob_conta..corte_tmp,cob_conta..cb_cuenta
                where
			tmp_empresa = @i_empresa and
			tmp_periodo = @i_periodo and
                        tmp_tipo_corte  = @i_frecuencia and
                        co_empresa = tmp_empresa and
                        co_periodo = tmp_periodo and
			co_fecha_fin = tmp_fecha_fin and
                        hi_empresa = @i_empresa and
                        hi_periodo = @i_periodo and
                        hi_corte = co_corte and
                        hi_oficina = @i_oficina and
                        hi_area    = @i_area and
                        hi_cuenta = @i_cuenta and
			cu_empresa = hi_empresa and
                   	cu_cuenta = hi_cuenta   
                order by co_fecha_fin

                if @@rowcount = 0
                begin
                   return 1
                   set rowcount 0
                end
                set rowcount 0
	end
	if @i_modo = 1
        begin

		select  'Corte' = convert(char(10),co_fecha_fin,
                                  @i_formato_fecha),
                        --'Saldo en pesos' = hi_saldo + hi_saldo_me, cu_categoria,JCG20
			'Saldo en moneda nacional' = hi_saldo / @i_escala,	--JCG10
			'Saldo en moneda extranjera' = hi_saldo_me / @i_escala	--JCG10  
                from cob_conta_his..cb_hist_saldo, cob_conta..cb_corte, 
		     cob_conta..corte_tmp,cob_conta..cb_cuenta
                where
			tmp_empresa = @i_empresa and
			tmp_periodo = @i_periodo and
                        tmp_tipo_corte  = @i_frecuencia and
                        co_empresa = tmp_empresa and
                        co_periodo = tmp_periodo and
			co_fecha_fin >= @i_fecha_fin and
                        co_fecha_fin = tmp_fecha_fin and            
                        hi_empresa = @i_empresa and
                        hi_periodo = @i_periodo and
                        hi_corte = co_corte and
                        hi_oficina = @i_oficina and
                        hi_area    = @i_area and
                        hi_cuenta = @i_cuenta and
			cu_empresa = hi_empresa and
                   	cu_cuenta = hi_cuenta   
                order by co_fecha_fin

                if @@rowcount = 0
                begin
                    return 1
                    set rowcount 0
                end
                set rowcount 0
	
        end
	if @i_modo = 2
        begin

                select  'Corte' = convert(char(10),co_fecha_fin,
                                  @i_formato_fecha),
                        --'Saldo en pesos' = sa_saldo + sa_saldo_me, cu_categoria,JCG20
			'Saldo en moneda nacional' = sa_saldo / @i_escala,	--JCG10
			'Saldo en moneda extranjera' = sa_saldo_me / @i_escala  --JCG10  
                from cob_conta..cb_saldo,cob_conta..cb_corte,
		     cob_conta..corte_tmp,cob_conta..cb_cuenta 
                where
			tmp_empresa = @i_empresa and
			tmp_periodo = @i_periodo and
                        tmp_tipo_corte  = @i_frecuencia and
                        co_empresa = tmp_empresa and
                        co_periodo = tmp_periodo and
                        co_fecha_fin = tmp_fecha_fin and            
                        sa_empresa = @i_empresa and
                        sa_periodo = @i_periodo and
                        sa_corte = co_corte and
                        sa_oficina = @i_oficina and
                        sa_area    = @i_area and
                        sa_cuenta = @i_cuenta and
			cu_empresa = sa_empresa and
                   	cu_cuenta = sa_cuenta
                 order by co_fecha_fin

                if @@rowcount = 0
                begin
 		/*'No existen Saldos para Cuenta Especificada'*/
                           exec cobis..sp_cerror
                           @t_debug = @t_debug,
                           @t_file       = @t_file,
                           @t_from       = @w_sp_name,
                           @i_num        = 601065
                           return 1

                       set rowcount 0
                end
                set rowcount 0
        end
        if @i_modo = 3
        begin

                select  'Corte' = convert(char(10),co_fecha_fin,
                                  @i_formato_fecha),
                        --'Saldo en pesos' = sa_saldo + sa_saldo_me, cu_categoria,JCG20
			'Saldo en moneda nacional' = sa_saldo / @i_escala,	--JCG10
			'Saldo en moneda extranjera' = sa_saldo_me / @i_escala  --JCG10  
                from cob_conta..cb_saldo,cob_conta..cb_corte,
		     cob_conta..corte_tmp,cob_conta..cb_cuenta 
                where
			tmp_empresa = @i_empresa and
			tmp_periodo = @i_periodo and
                        tmp_tipo_corte  = @i_frecuencia and
                        co_empresa = tmp_empresa and
                        co_periodo = tmp_periodo and
                        co_fecha_fin = tmp_fecha_fin and            
                        co_fecha_fin > @i_fecha_fin and
                        sa_empresa = @i_empresa and
                        sa_periodo = @i_periodo and
                        sa_corte = co_corte and
                        sa_oficina = @i_oficina and
                        sa_area    = @i_area and
                        sa_cuenta = @i_cuenta and
			cu_empresa = sa_empresa and
                   	cu_cuenta = sa_cuenta
                 order by co_fecha_fin

                 if @@rowcount = 0
                 begin
 		 /*'No existen Saldos para Cuenta Especificada'*/
                           exec cobis..sp_cerror
                           @t_debug = @t_debug,
                           @t_file       = @t_file,
                           @t_from       = @w_sp_name,
                           @i_num        = 601065
                           return 1
                       set rowcount 0
                 end
                 set rowcount 0

        end

return 0
end

go

