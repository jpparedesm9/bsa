/************************************************************************/
/*	Archivo: 		saldomil.sp    		                */
/*	Stored procedure: 	sp_saldo_miles				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Juan Carlos Gomez R.                  	*/
/*	Fecha de escritura:     24/Nov./1997				*/
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
/*	Este programa reporta los saldos a excell para emitir el        */
/*	reporte de saldos diarios de captaciones y encaje interno       */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	10/Dic/1997	Juan Carlos Gomez Presentacion de saldos	*/
/*			JCG20						*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_saldo_miles')
	drop proc sp_saldo_miles
go

create proc sp_saldo_miles  (
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
	@i_oficina 	smallint = null,
	@i_area		smallint = null,
	@i_fecha	datetime = null,
	@i_fecha_ant    datetime = null
)

as
declare
        @w_today        datetime,       /* fecha del dia */
        @w_return       int,            /* valor que retorna */
        @w_sp_name      varchar(32),    /* nombre del stored procedure*/
        @w_siguiente    tinyint,
        @w_empresa      tinyint,
        @w_cuenta       cuenta,
        @w_secuencial   smallint,
        @w_operador     int,
        @w_tipo_dinamica char(1),
        @w_naturaleza1    char(1), /* JCG20 */
        @w_naturaleza2    char(1), /* JCG20 */
        @w_signo        smallint,
        @w_nombre       descripcion,
        @w_disp_legal   char(255),
        @w_periodo      int,
        @w_periodo1     int,
        @w_periodo2     int,
        @w_corte        int,
        @w_corte1       int,
        @w_corte2       int,
        @w_moneda       smallint,
        @w_fecha1       datetime, /* fecha de un mes atras */
 	@w_fecha2       datetime, /* fecha de dos mes atras */
        @w_existe       tinyint,        /* codigo existe = 1
                                               no existe = 0 */
        @w_valor1       money,
        @w_cotiz1       money,
        @w_valor2       money,
        @w_cotiz2       money,
        @w_valor3       money,
        @w_cotiz3       money 

select @w_today = getdate()
select @w_sp_name = 'sp_saldo_miles'

/*  Modo de debug  */
if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa	= @i_empresa,
		i_cuenta     	= @i_cuenta,
		i_oficina	= @i_oficina
	exec cobis..sp_end_debug
end

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6284 and @i_operacion = 'Q') /* Consulta */

begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1
end   


/* Calcula los periodos y cortes */
select @w_corte = co_corte,
	@w_periodo = co_periodo
from cob_conta..cb_corte
where @i_fecha between co_fecha_ini and co_fecha_fin and
	co_empresa = @i_empresa

select @w_corte1 = co_corte,
	@w_periodo1 = co_periodo
from cob_conta..cb_corte
where @i_fecha_ant between co_fecha_ini and co_fecha_fin and
	co_empresa = @i_empresa


if @i_operacion = 'Q'
begin
	select @w_nombre = cu_nombre,         
               @w_naturaleza1 = cu_categoria,
               @w_valor1 =(sum(bl_saldo_mna))           
       	from   cb_balsuper,                    
               cb_cuenta,
               cb_jerararea ,
               cb_jerarquia                   
      	where  bl_empresa = @i_empresa and   
               bl_periodo = @w_periodo and  
               bl_corte   = @w_corte  and   
               cu_empresa = @i_empresa and  
               cu_cuenta  = @i_cuenta   
               and bl_cuenta  = cu_cuenta 
               and je_empresa = @i_empresa      
               and je_oficina_padre = @i_oficina
               and je_oficina = bl_oficina      
	       and ja_area_padre = @i_area
   	group by cu_cuenta, cu_nombre, cu_categoria

	if @@rowcount = 0
	begin
		select @w_nombre = ''	
		select @w_valor1 = 0	
	end	

	select @w_nombre = cu_nombre,
               @w_naturaleza2 = cu_categoria,
               @w_valor2 =(sum(bl_saldo_mna))
        from   cb_balsuper,
               cb_cuenta,
               cb_jerararea ,
               cb_jerarquia
        where  bl_empresa = @i_empresa and
               bl_periodo = @w_periodo1 and
               bl_corte   = @w_corte1  and
               cu_empresa = @i_empresa and
               cu_cuenta  = @i_cuenta
               and bl_cuenta  = cu_cuenta
               and je_empresa = @i_empresa
               and je_oficina_padre = @i_oficina
               and je_oficina = bl_oficina
               and ja_area_padre = @i_area
        group by cu_cuenta, cu_nombre, cu_categoria

	/* JCG20 */
	if @@rowcount = 0
	begin
		select @w_valor2 = 0	
	end	

	/* JCG20 */
	if @w_naturaleza1 = 'C'
	begin
    		 select @w_valor1 = @w_valor1 * -1	 
	end

	if @w_naturaleza2 = 'C'
	begin
    		 select @w_valor2 = @w_valor2 * -1	 
	end

  	select @w_nombre , @w_valor1 , @w_valor2 

	return 0
end
go
