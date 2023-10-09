/************************************************************************/
/*	Archivo:		constot1.sp				*/
/*	Stored procedure:	sp_consulta_totales01			*/
/*	Base de datos:		cob_pfijo				*/
/*	Producto: 		PLAZO FIJO				*/
/*	Disenado por:           Dolores Guerrero/Ximena Cartagena       */
/*	Fecha de escritura:     04-Sep-1997				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	'MACOSA', representantes exclusivos para el Ecuador de la 	*/
/*	'NCR CORPORATION'.						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/* 	Este programa se encarga de realizar las consultas de las       */
/* 	Estadisticas del front-end Administrativo a partir de  la       */
/* 	tabla pf_estadistica                                            */
/************************************************************************/
/*				MODIFICACIONES				*/
/*			                                                */ 
/*	FECHA		AUTOR		         RAZON			*/
/*	04/Sep/1997	D.Guerrero/X.Cartagena   Emision Inicial	*/
/*      09/Sep/2005     Clotilde Vargas          Correcciones varias    */
/*      11/Oct/2006     Clotilde Vargas          Agregar nuevo criterio */
/*                                               para consultar por     */
/*                                               meses                  */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_consulta_totales01')
   drop proc sp_consulta_totales01
go

create proc sp_consulta_totales01(
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err  char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) =     NULL,
	@t_debug		char(1) =     'N',
	@t_file			varchar(14)  = NULL,
	@t_from			varchar(32)  = NULL,
	@t_trn			smallint     = NULL,
	@i_tipo			varchar(1)   = NULL,
	@i_mes   		int          = NULL,
	@i_moneda		smallint     = NULL,
	@i_nivel		catalogo     = NULL,
	@i_valor_nivel		varchar(10)  = NULL,
	@i_tipo_deposito	varchar(10)  = NULL,
	@i_operacion            char(1)      = null
)
with encryption
as
declare
	@w_today		datetime,
	@w_error		int,
	@w_sp_name  		varchar(32),
	@w_factor		int,
	@w_year			smallint,
	@w_anio			smallint,
	@w_month		tinyint,
	@w_week			tinyint,
	@w_day			smallint,
	@w_max 			smallint,
	@w_cont 		smallint,
	@w_interno_max		smallint,
	@w_fecha_inicio		varchar(10),
	@w_fecha_fin            varchar(10),
	@w_fecha		datetime

select @w_today   = @s_date
select @w_sp_name = 'sp_graba_totales01'


if @i_operacion = 'C'
begin
  if @i_tipo = 'D' /*** Detallado ***/
  begin
	    select es_valor_nivel,
	       es_tipo_deposito,
	       es_monto,
	       es_cantidad,
	       convert(float,es_tasa_pponderada),
	       es_plazo_pponderado
	    from pf_estadistica
	    where es_nivel 	 = @i_nivel
	      and es_valor_nivel = @i_valor_nivel
	      and es_mes         = @i_mes
	      and es_moneda      = @i_moneda
  end

  if @i_tipo = 'R'  /*** Resumido ***/
  begin
	  if @i_nivel = 'T'
	  begin
	      select 	es_tipo_deposito,
		     	es_tipo_deposito,
			es_monto,				
		        es_cantidad,				
              		convert(float,es_tasa_pponderada),	
              		es_plazo_pponderado			
	      from pf_estadistica
	      where es_mes    = @i_mes
	        and es_moneda = @i_moneda 
                and es_nivel  = @i_nivel		
                and ((es_tipo_deposito = @i_tipo_deposito and @i_tipo_deposito is not null) or
                    (es_tipo_deposito <> @i_tipo_deposito and @i_tipo_deposito is null))
	  end
	  else
	  begin
	      select  es_valor_nivel,
        	      es_tipo_deposito,
	              es_monto,
	              es_cantidad,
	              convert(float,es_tasa_pponderada),
        	      convert(varchar(30),es_plazo_pponderado)
	      from pf_estadistica
	      where es_nivel  = @i_nivel
	        and es_mes    = @i_mes
        	and es_moneda = @i_moneda
                and es_valor_nivel = @i_valor_nivel
                and ((es_tipo_deposito = @i_tipo_deposito and @i_tipo_deposito is not null) or
                    (es_tipo_deposito <> @i_tipo_deposito and @i_tipo_deposito is null))
	  end
  end
end

if @i_operacion = 'M'
begin
	select @w_year		= datepart(yy,@w_today)
	select @w_month		= @i_mes
	select @w_fecha_inicio  = convert(varchar(2),@w_month) + '/' + '01' + '/' + convert(varchar(4),@w_year)	

	if @i_nivel <> 'T'
		select @w_fecha         = dateadd(mm,-6,convert(datetime, @w_fecha_inicio))
	else
		select @w_fecha         = dateadd(mm,-1,convert(datetime, @w_fecha_inicio))

	select @w_month 	= datepart(mm,@w_fecha)
	select @w_anio		= datepart(yy,@w_fecha)

  	if @i_nivel = 'T'
	begin
	      select 	convert(varchar(2),es_mes) + '-' +  (select c.valor from cobis..cl_catalogo c ,cobis..cl_tabla t
				where t. tabla = 'tm_mes'
				and   c.tabla  = t.codigo
				and   c.codigo = convert(varchar(2),e.es_mes)), 
		     	es_valor_nivel,
			sum(es_monto),				
		        sum(es_cantidad),				
              		sum(convert(float,es_tasa_pponderada)),	
              		sum(es_plazo_pponderado)			
	      from pf_estadistica e
	      where ((es_mes  >= @w_month and es_anio = @w_year) and (es_mes <= @i_mes and es_anio = @w_anio))                 
	        and es_moneda = @i_moneda 
                and es_nivel  = @i_nivel	
	      group by es_mes, es_valor_nivel

	end
	else
	begin
	      select 	      
		      convert(varchar(2),es_mes) + '-' + (select c.valor from cobis..cl_catalogo c ,cobis..cl_tabla t
				where t. tabla = 'tm_mes'
				and   c.tabla  = t.codigo
				and   c.codigo = convert(varchar(2),e.es_mes)), 
		      es_valor_nivel,	
	              sum(es_monto),
	              sum(es_cantidad),
	              sum(convert(float,es_tasa_pponderada)),
        	      sum(es_plazo_pponderado)
	      from pf_estadistica e
	      where es_nivel  		= @i_nivel
	        and ((es_mes  		>= @w_month and es_anio = @w_year) and (es_mes <= @i_mes and es_anio = @w_anio))                 
        	and es_moneda 		= @i_moneda
                and es_valor_nivel 	= @i_valor_nivel
	      group by es_mes,  es_valor_nivel
	end
end

go

