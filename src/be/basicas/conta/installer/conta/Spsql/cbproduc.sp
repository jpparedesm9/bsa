/************************************************************************/
/*      Archivo:                cbproduc.sp                             */
/*      Stored procedure:       sp_cob_producto                         */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           M.Suarez                                */
/*      Fecha de escritura:     27-julio-1995                           */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*         Mantenimiento a la tabla de productos para perfile          	*/
/*	   contable.                          				*/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      27/Sep/1995   E.Mogro     	Emision Inicial                 */
/*      23/Jul/1996   S. de la Cruz     Correspondencia mensajes error	*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cob_producto')
	drop proc sp_cob_producto  

go
create proc sp_cob_producto   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = 602,
	@t_debug        char(1) = 'N',
	@t_file         varchar(14) = null,
	@t_from         varchar(30) = null,
	@i_operacion    char(1) = null,
	@i_empresa      tinyint = null,
	@i_producto     tinyint = null,
	@i_online       char(1) = null,
	@i_estado       char(1) = null,
	@i_resumen      char(1) = null,
	@i_modo         smallint = null
)
as 
declare
	@w_hoy          datetime,
	@w_return       int,
	@w_sp_name      varchar(32),
	@w_existe       int,
	@w_parametro    varchar(10),
        @w_estado       char(1),
        @w_online       char(1),
        @w_resumen      char(1),
	@w_producto 	tinyint
	

select @w_hoy = getdate()
select @w_sp_name = 'sp_cob_producto'


/*  Tipo de Transaccion = 			*/

if (@t_trn <> 6041 or @i_operacion <> 'I') and
   (@t_trn <> 6042 or @i_operacion <> 'U') and
   (@t_trn <> 6099 or @i_operacion <> 'S') and 
   (@t_trn <> 6043 or @i_operacion <> 'D') 
   
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file          = @t_file,
		t_from          = @t_from,
		i_operacion     = @i_operacion,
		i_producto      = @i_producto,
		i_online	= @i_online,
		i_resumen	= @i_resumen,
		i_estado	= @i_estado
	exec cobis..sp_end_debug
end

if @i_operacion = 'S'
begin
 	if @i_modo = 0
		select  'Producto'    = substring(pd_descripcion,1,32),
			'Oper.OnLine' = pr_online,
                        'Estado '     = pr_estado,
			'Resumen'     = pr_resumen,
			'Codigo'      = pr_producto, 
                        'Empresa'     = pr_empresa 
		from cobis..cl_producto, cb_producto
		where pd_producto = pr_producto
		  -- and pr_estado   = @i_estado

	else
		select  'Producto'    = substring(pd_descripcion,1,32),
			'Oper.OnLine' = pr_online,
                        'Estado '     = pr_estado,
			'Resumen'     = pr_resumen,
			'Codigo'      = pr_producto
		from cobis..cl_producto, cb_producto
	        where pd_producto > @i_producto
		  -- and pr_estado   = @i_estado
end

/* Insercion */
/*************************/

if @i_operacion = 'I'
begin
	if exists (select * from cb_producto 
			where pr_empresa = @i_empresa
                          and pr_producto = @i_producto
			  and pr_estado   = "V")
	begin
		/* 'Codigo ya existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601155
		return 1
	end
	
	/* Insercion del registro */
	/**************************/
	begin tran
		insert into cb_producto
		       (pr_producto,pr_estado,pr_online,
                        pr_resumen,pr_fecha_mod,pr_empresa)
		values (@i_producto,@i_estado,@i_online,
                        @i_resumen,@w_hoy,@i_empresa)
		if @@error <> 0 
		begin
			/* 'Error en insercion de registro ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 603059
			return 1
		end

	commit tran
	return 0
end

/* Actualizacion (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'Registro NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
	end
	/*  Actualizacion del registro  */
	/********************************/

	begin tran
		update cb_producto
		   set pr_online = @i_online,
		       pr_estado = @i_estado,
		       pr_resumen= @i_resumen,
		       pr_fecha_mod = @w_hoy
		where pr_empresa  = @i_empresa
		and   pr_producto = @i_producto
		if @@error <> 0
		begin
			/* 'Error en Actualizacion de Registro '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 605081
			return 1
		end

	commit tran
	return 0
end

if @i_operacion = 'D'
   begin 
   select *
   from cb_producto
   where pr_empresa = @i_empresa and 
 	pr_producto = @i_producto 

   if @@rowcount = 0
	begin
		/* 'Registro NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
	end
	/*  Eliminacion del registro  */
	/********************************/
        begin tran
        delete cb_producto
	where pr_empresa = @i_empresa 
	and   pr_producto = @i_producto 

        commit tran 
       return 0
  end    
go
