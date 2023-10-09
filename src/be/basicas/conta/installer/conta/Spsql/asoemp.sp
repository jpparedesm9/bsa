/************************************************************************/
/*	Archivo: 		asoemp.sp			        */
/*	Stored procedure: 	sp_asoemp  				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     30-julio-1993 				*/
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
/*	insercion y actualizacion de registros en tablas asociadas	*/
/*	al catalogo de empresas						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_asoemp ')
	drop proc sp_asoemp    
go
create proc sp_asoemp     (
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
	@i_empresa	tinyint = null,
	@i_descripcion  descripcion = null 
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_flag1	int,
	@w_menor	smallint,
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_asoemp'

if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa  	= @i_empresa,     
		i_descripcion	= @i_descripcion 
	exec cobis..sp_end_debug
end


/************************************************/
/*  Tipo de Transaccion =     			*/

if (@t_trn <> 6261 and @i_operacion = 'I') or
   (@t_trn <> 6262 and @i_operacion = 'U') 
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

begin tran

if @i_operacion = 'I'
begin
	/****************************************/
	/* TRANSACCION DE SERVICIO		*/

	insert into ts_asoemp
	values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
		@i_empresa)

	if @@error <> 0
	begin
		/* 'Error en insercion de transaccion de servicio' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603032
		return 1
	end
	/****************************************/
	/***** insercion en ORGANIZACION ****/
	
	insert into cob_conta..cb_organizacion
		(or_empresa,or_organizacion,or_descripcion)
	values ( @i_empresa,1,'EMPRESA')

	if @@error <> 0
	begin
		/* 'Error en Insercion automatica de Organizacion' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603013
		return 1
	end
	/*** Insercion en Oficina ****/

	insert into cob_conta..cb_oficina
		(of_empresa,of_oficina,of_descripcion,of_oficina_padre,
		of_estado,of_organizacion,of_consolida,of_movimiento)
	values	(@i_empresa,255,@i_descripcion,NULL,'V',1,'S','N')
	if @@error <> 0
	begin
		/* 'Error en Insercion automatica de Oficina' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603013
		return 1
	end
	/*** Insercion en Nivel Areas ***/

	insert into cob_conta..cb_nivel_area
		(na_empresa,na_nivel_area,na_descripcion)
	values (@i_empresa,1,'EMPRESA')

	/*** Insercion de Areas ***/

	insert into cob_conta..cb_area
		(ar_empresa,ar_area,ar_area_padre,ar_descripcion,ar_estado,
		 ar_nivel_area,ar_consolida,ar_movimiento)
	values	(@i_empresa,255,NULL,@i_descripcion,'V',1,'S','N')
end

commit tran

begin tran
if @i_operacion = 'U'
begin
	/****************************************/
	/* TRANSACCION DE SERVICIO		*/

	insert into ts_asoemp
	values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
		@i_empresa)

	if @@error <> 0
	begin
		/* 'Error en insercion de transaccion de servicio' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603032
		return 1
	end
	/****************************************/
	/*** Actualizacion de Oficina ****/
        update cob_conta..cb_oficina
               set of_descripcion = @i_descripcion
               from cob_conta..cb_oficina
               where (of_empresa = @i_empresa) and
                     (of_oficina = 255)
	if @@error <> 0
	begin
		/* 'Error en Insercion automatica de Oficina' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603013
		return 1
	end
	/*** Insercion de Areas ***/
        update cob_conta..cb_area
        set ar_descripcion = @i_descripcion
        from cob_conta..cb_area
        where (ar_empresa = @i_empresa) and
              (ar_area = 255)
end

commit tran

return 0

go

