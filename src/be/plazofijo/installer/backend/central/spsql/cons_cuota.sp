/************************************************************************/
/*      Archivo:                b_cuota.sp                              */
/*      Stored procedure:       sp_cons_cuota                           */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           N. Silva                                */
/*      Fecha de documentacion: 16-May-2005                             */
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
/*      Este script crea los procedimientos para las consultas de las   */
/*      operaciones de plazos fijos.                                    */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cons_cuota')
   drop proc sp_cons_cuota
go

create proc sp_cons_cuota (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint,
@i_operacion            char(1),
@i_op_num_banco		    cuenta          = NULL,
@i_cuota                int             = 0,
@i_fecha		        datetime        = NULL,
@i_formato_fecha	    int             = 101,
@i_tipo                 smallint        = NULL,
@i_fecha_ini		    datetime        = NULL,
@i_fecha_fin		    datetime        = NULL,
@i_op_operacion		    int             = 0)
with encryption
as
declare
@w_sp_name              descripcion,
@w_return               int,
@w_operacion            int,
@w_fecha_labor        	datetime,
@w_td_dias_reales       char(1)
       
select @w_sp_name = 'sp_cons_cuota'


/*----------------------------------*/
/*  Verificar Codigo de Transaccion */
/*----------------------------------*/
if @t_trn <> 14463
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 149065
	return 1
end


if @i_operacion = 'S'
begin
	--------------------------
	--Obtengo Nro de Operacion
	--------------------------
	select @w_operacion = op_operacion
	  from cob_pfijo..pf_operacion
	 where op_num_banco = @i_op_num_banco

	-------------------------------
	-- Busqueda Periodos Cuotas
	-------------------------------
	set rowcount 15
	select  '14240' = cu_cuota,
	        '14241' = convert(varchar(10),cu_fecha_pago,@i_formato_fecha),
        	'14242' = cu_valor_cuota,
	        '14752' = cu_ente,
        	'12069' = op_descripcion,
	        '14517' = di_descripcion,
        	'12668' = of_nombre,
	        '14377' = op_num_banco,
        	'14378' = td_descripcion,
	        '11074' = cu_capital,
        	'11061' = cu_ppago,
	        '11062' = cu_moneda,
        	'11423' = op_tasa,
	        '12460' = convert(varchar(10),op_fecha_ven,@i_formato_fecha),
        	'14398' = cu_estado,
	        '11422' = op_num_dias,
        	'11370' = convert(varchar(10),op_fecha_ingreso,@i_formato_fecha),
	        '11307' = convert(varchar(10),op_fecha_valor,@i_formato_fecha),
        	'14456' = cu_num_dias,
		'15819' = convert(varchar(10),cu_fecha_ult_pago,@i_formato_fecha),
                '14399' = (select op_int_ganado from pf_operacion where op_operacion = a.op_operacion 
                              and op_fecha_ult_pg_int = b.cu_fecha_ult_pago)
	from cob_pfijo..pf_cuotas b
    inner join cob_pfijo..pf_operacion a on
       cu_operacion 	= op_operacion
       inner join cobis..cl_oficina on
          op_oficina 	= of_oficina
          inner join cob_pfijo..pf_tipo_deposito on
             op_toperacion 	= td_mnemonico
             left outer join cobis..cl_direccion on
                op_ente 		= di_ente and
                di_tipo 		= 'CO'
	where cu_operacion 	= @w_operacion 
    and cu_cuota 		> @i_cuota
	order by cu_cuota	

	set rowcount 0
	select 15
end

if @i_operacion = 'Q'
begin
	if @i_tipo = 1
	begin
		exec sp_primer_dia_labor
		@s_ofi = @s_ofi,
		@i_fecha = @i_fecha,
		@o_fecha_labor = @w_fecha_labor out
		select convert(varchar(10),@w_fecha_labor,@i_formato_fecha)
	end
	if @i_tipo = 2
	begin
		select @w_td_dias_reales = isnull(td_dias_reales,'N')
		from cob_pfijo..pf_tipo_deposito,  pf_operacion
		where op_toperacion = td_mnemonico
		and op_num_banco = @i_op_num_banco
		select @w_td_dias_reales
	end 
end


if @i_operacion = 'H'
begin
	if @i_tipo = 1
        begin
		-------------------------------
		-- Busqueda Periodos Cuotas
		-------------------------------
		set rowcount 20
		select  op_operacion,
			'14377' = op_num_banco,
                        '14240' = cu_cuota,
		        '14241' = convert(varchar(10),cu_fecha_pago,101),
        		'14242' = cu_valor_cuota,
        		'14398' = cu_estado
		 from cob_pfijo..pf_cuotas,
		      cob_pfijo..pf_operacion
		where cu_operacion   = op_operacion
		  and ((cu_operacion >= @i_op_operacion  and 
                        cu_cuota     >  @i_cuota) or cu_operacion > @i_op_operacion)
		  and cu_fecha_pago  >= @i_fecha_ini
		  and cu_fecha_pago  <= @i_fecha_fin
		  and op_oficina     =  @s_ofi
		  and cu_estado         =  'V'
		order by cu_operacion,cu_cuota
		set rowcount 0
		select 20
	end
	if @i_tipo = 2
        begin
		-------------------------------
		-- Busqueda Periodos Cuotas
		-------------------------------
		set rowcount 20
		select  op_operacion,
			'14377' = op_num_banco,
                        '14240' = cu_cuota,
		        '14241' = convert(varchar(10),cu_fecha_pago,101),
        		'14242' = cu_valor_cuota,
        		'14398' = cu_estado
		 from cob_pfijo..pf_cuotas,
		      cob_pfijo..pf_operacion
		where ((cu_operacion >= @i_op_operacion  and 
                        cu_cuota     >  @i_cuota) or cu_operacion > @i_op_operacion)
		  and cu_operacion   = op_operacion
		  and cu_fecha_pago >= @i_fecha_ini
		  and cu_fecha_pago <= @i_fecha_fin
                  and op_oficina     = @s_ofi
                  and cu_estado = 'P'
		order by cu_operacion,cu_cuota
		set rowcount 0
		select 20
	end
end

return 0
go
