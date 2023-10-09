/************************************************************************/
/*	Archivo: 		salcons.sp               	        */
/*	Stored procedure: 	sp_saldo_consolidado			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Fecha de escritura:     4-Noviembre 1997                        */
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa permite la consulta de saldos consolidados	*/
/*      desagregados por estructura de areas y oficinas			*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	04/Nov/1997	M.victoria Garay     Emision Inicia		*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_saldo_consolidado')
	drop proc sp_saldo_consolidado

go

create proc sp_saldo_consolidado   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1),
	@i_empresa		tinyint = null,
	@i_fecha		datetime = null ,
	@i_oficina		smallint  = null,
	@i_area			smallint = null,
	@i_cuenta       	cuenta = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_corte	int,
	@w_estado_corte	char(1),
	@w_periodo  	int,
	@w_area		smallint,
        @w_categoria    char(1),
        @w_saldo        money,
        @w_saldo1       money   

select @w_today = getdate()
select @w_sp_name = 'sp_saldo_consolidado'
if (@t_trn <> 6976 and @i_operacion = 'S')  or
   (@t_trn <> 6977 and @i_operacion = 'H')
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end

/*****************************************************************/
/*********** Busqueda de cuentas dado el padre de las cuentas ****/
/*****************************************************************/


select 	@w_corte = co_corte, 
	@w_periodo = co_periodo,
	@w_estado_corte = co_estado
  from 	cb_corte
where 	co_empresa = @i_empresa and
      	co_fecha_ini <= @i_fecha and
      	co_fecha_fin >= @i_fecha


/*****************************************************************/
/*********** Busqueda de catagoria de la cuenta               ****/
/*****************************************************************/
select @w_categoria = cu_categoria
from cb_cuenta
where
     cu_empresa = @i_empresa
     and cu_cuenta = @i_cuenta 
/*****************************************************************/

if @i_operacion = 'S'
begin
	if @w_estado_corte = 'A'
	begin
              select @w_saldo = 0 

              select  @w_saldo =  sum(sa_saldo) --+ sum (sa_saldo_me) 
               from  cb_saldo
                 where  sa_empresa  = @i_empresa                                
                   and  sa_periodo = @w_periodo
                   and  sa_corte   = @w_corte
		   and  sa_cuenta = @i_cuenta
                   and  sa_oficina in (
                          select je_oficina from cb_jerarquia
                          where je_empresa = @i_empresa
                          and   (je_oficina = @i_oficina or je_oficina_padre = @i_oficina)
                        )
                   and  sa_area    in (
                          select ja_area from cb_jerararea
                          where  ja_empresa = @i_empresa
                          and    (ja_area = @i_area or ja_area_padre = @i_area)
                        )


	/*	if @w_saldo = 0
		begin*/
		/* 'Cuenta consultada no existe  '*/
		/*	exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601029
			return 1
		end*/
 
           -- if @w_categoria = 'C'
            --  select  @w_saldo = @w_saldo * (-1)
            select  @w_saldo
            return 0

	end
	else
	begin
                select @w_saldo1 = 0 

		select  @w_saldo1 = sum(hi_saldo) --+ sum (hi_saldo_me)
	  	  from  cob_conta_his..cb_hist_saldo
                 where  hi_empresa = @i_empresa
                   and  hi_periodo = @w_periodo
                   and  hi_corte   = @w_corte
                   and  hi_cuenta  = @i_cuenta
                   and  hi_oficina in (
                          select je_oficina from cb_jerarquia
                          where je_empresa = @i_empresa
                          and   (je_oficina = @i_oficina or je_oficina_padre = @i_oficina)
                        )
                   and  hi_area    in (
                          select ja_area from cb_jerararea
                          where  ja_empresa = @i_empresa
                          and    (ja_area = @i_area or ja_area_padre = @i_area)
                        )

	/*	if @w_saldo1 = 0
		begin*/
		/* 'Cuenta consultada no existe  '*/
		/*	exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601029
			return 1
		end*/

             --   if @w_categoria = 'C'
               --   select  @w_saldo1 = @w_saldo1 * (-1)

                select  @w_saldo1 
                return 0

	end
end

if @i_operacion = 'H'
begin
        select of_oficina, of_descripcion
        from cb_oficina
        where   of_empresa = @i_empresa and
                of_oficina_padre = @i_oficina

        if @@rowcount = 0
        begin
                        /* 'No existen Oficinas ' */
                        exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 601171
                        return 1
        end

        return 0
end
go
