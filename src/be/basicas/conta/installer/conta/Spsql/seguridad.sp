/************************************************************************/
/*	Archivo: 		segurida.sp				*/
/*	Stored procedure: 	sp_seguridad				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:           	contabilidad            		*/
/*	Disenado por:       	J. Jiménez              		*/
/*	Fecha de escritura: 	21-Abril-1998				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CorPorATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Realiza Transacciones de Insercion, Eliminacion y Consulta      */
/*      sobre la tabla cb_seguridad.				        */
/*				MODifICACIONES				*/
/*	FECHA		AUTOR		        RAZON			*/
/*	21/Abr/1998	J. Jiménez          Emisión Inicial		*/
/*      22/Feb/1999     Fabio C Cardona     Converci¢n a Sybase         */
/*      14/Abr/1999     Fabio C Cardona     Se adiciono la trn -> 'E'   */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_seguridad')
	drop proc sp_seguridad  

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_seguridad   (
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
	@i_empresa      tinyint = null,
	@i_cuenta   	cuenta= null,
	@i_oficina	smallint = null,
	@i_area		smallint = null,
	@i_transer   	char(1)= 'S',
	@i_cuenta1   	cuenta= null,
	@i_cuenta2   	cuenta= null,
	@i_oficina1	smallint = null,
	@i_area1	smallint = null,
	@i_sinonimo	char(20) = null
)
as 
declare
	@w_today 		datetime,  	/* fecha del dia */
	@w_return		int,		/* valor que retorna */
	@w_sp_name		varchar(32),	/* nombre del stored procedure*/
	@w_empresa		tinyint,
	@w_cuenta		cuenta,
	@w_oficina		smallint,
	@w_flag1		int,
	@w_area			smallint,
	@w_padre_cta		cuenta,
	@w_existe		int,
    @w_batch        int,
	@z_cuenta		cuenta



select @z_cuenta = @i_cuenta
select @w_today = getdate()
select @w_sp_name = 'sp_seguridad'

	
/******************************************************/
/*   Tipo de Transaccion = 6736(I),6737(D),6738(Q)    */

if (@t_trn <> 6736 and @i_operacion = 'I') or
   (@t_trn <> 6737 and @i_operacion = 'D') or
   (@t_trn <> 6738 and @i_operacion = 'Q') or
   (@t_trn <> 6738 and @i_operacion = 'W') or
   (@t_trn <> 6764 and @i_operacion = 'E') 

begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end
/*******************************************************/


/***********Chequeo de Existencias*********************/

if @i_operacion <> 'I' and @i_operacion <> 'D'
begin
	select 	@w_empresa = se_empresa,
		@w_cuenta = se_cuenta,
		@w_oficina = se_oficina,
		@w_area = se_area
	from cob_conta..cb_seguridad
	where 	se_cuenta = @i_cuenta

	if @@rowcount > 0
	        select @w_existe = 1
	else
		select @w_existe = 0
end


if @i_operacion = 'E' 
begin

		if exists (select se_cuenta from cob_conta..cb_seguridad 
		   	   where se_empresa = @i_empresa 
		           and se_oficina = @i_oficina1 
		           and se_area = @i_area1
                           and se_cuenta = @i_cuenta1)
			select "1"
		else
			select "0"

end


/*********** Insertar nueva Relación *******************/

if @i_operacion = 'I' 
begin

	select @w_flag1 = 1
	
	select @w_cuenta = se_cuenta
	from cob_conta..cb_seguridad 
	where se_empresa = @i_empresa 
	and se_oficina = @i_oficina 
	and se_area = @i_area 
	and se_cuenta = @z_cuenta
			
	if @@error <> 0 
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603007
		return 1
	end

        if @@rowcount > 0
        begin
		/* 'Ya existe la Relación Cuenta-Oficina-Area Autorizada' */
	   	exec cobis..sp_cerror
	   	@t_debug = @t_debug,
	   	@t_file  = @t_file,
	   	@t_from  = @w_sp_name,
	   	@i_num   = 601054 
	   	return 1
        end

	begin tran
		if @i_transer = 'S' 
		begin
			insert into ts_seguridad 
			values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,@i_empresa,@z_cuenta,@i_oficina,@i_area)

			if @@error <> 0 
			begin
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 603032
				return 1
			end

		
			/* Insertar nueva Relación Cuenta-Oficina-Area Autorizada */

			--while @w_flag1 > 0
			--begin
				if @z_cuenta is not NULL 
				begin
					if not exists(select  * from cb_seguridad 
						where se_empresa = @i_empresa 
						and se_oficina = @i_oficina 
						and se_area = @i_area 
						and se_cuenta = @z_cuenta)
	                	        begin
						insert into cb_seguridad (se_empresa,se_cuenta,se_oficina,se_area)
						values (@i_empresa,@z_cuenta,@i_oficina,@i_area)
					end
					
					--select  @w_padre_cta = cu_cuenta_padre from cb_cuenta 
					--where cu_empresa = @i_empresa 
					--and cu_cuenta = @z_cuenta
					
					if @@error <> 0 
					begin
						exec cobis..sp_cerror
						@t_debug = @t_debug,
						@t_file	 = @t_file,
						@t_from	 = @w_sp_name,
						@i_num	 = 601054
						return 1
					end
					--select @z_cuenta =  @w_padre_cta
				end
				--else
				--begin
				--	select @w_flag1 = 0
				--end
			--end
		end
	commit tran
	return 0
end

/******* Eliminaci¢n de datos de la tabla cb_seguridad*************/


if @i_operacion = 'D' 
begin

	/* Verificamos la relacion con saldos */
	if exists (select sa_cuenta 
		   from cob_conta..cb_saldo
		   where sa_empresa = @i_empresa
		   and sa_oficina = @i_oficina
		   and sa_area = @i_area
		   and sa_cuenta = @i_cuenta)

	begin
		/* Cuenta de Movimiento relacionada con Saldos y no se puede Eliminar */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607049
		return 1
	end  

	/* Verificamos la relacion con Asientos */
	if exists (select as_cuenta from cob_conta..cb_asiento 
		   where as_empresa = @i_empresa 
		   and as_oficina_dest = @i_oficina 
		   and as_area_dest = @i_area 
		   and as_cuenta = @i_cuenta)
	begin
		/* Cuenta de Movimiento relacionada con Asientos y no se puede Eliminar */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607050
		return 1
	end

	/* Eliminar Relación Cuenta-Oficina-Area Autorizada */

	begin tran

	if @i_cuenta is not NULL 
	begin
		if exists (select  * from cb_seguridad 
			   where se_empresa = @i_empresa 
			   and se_oficina = @i_oficina 
			   and se_area = @i_area 
			   and se_cuenta = @i_cuenta)
		begin
			delete  cob_conta..cb_seguridad 
			where se_empresa = @i_empresa 
			and se_oficina = @i_oficina 
			and se_area = @i_area 
			and se_cuenta = @i_cuenta

			if @@error <> 0
			begin
			/*	'Error en Eliminacion de Cuenta          ' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,                 
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 607052
				return 1
			end
		end   
	end
        
	commit tran
	return 0
end


/********************* Consulta ************************/


if @i_operacion = 'Q' 
begin
	set rowcount 100 -- MVG se cambio el rowconut de 500 a 80  
	if @i_modo = 0
	begin
--	print 'modo 0'
		if @w_existe = 1
		begin
			select 	se_oficina,se_area
			from cob_conta..cb_seguridad, cb_area, cb_oficina
			where 	se_cuenta = @i_cuenta and
		 	se_empresa = @i_empresa and
			of_empresa = @i_empresa and
                        of_oficina > 0 and
			of_oficina  = se_oficina and 
			ar_empresa = @i_empresa and
                        ar_area > 0 and
			ar_area = se_area  and
                 	of_movimiento = 'S' and
			ar_movimiento = 'S' 
                order by se_oficina,se_area
		end
		else
		begin
			/* La cuenta no posee areas autorizadas */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 609150
			return 1
		end
	end
	if @i_modo = 1
	begin
		if @w_existe = 1
		begin

			select 	se_oficina,se_area
			from cob_conta..cb_seguridad, cb_area, cb_oficina
			where 	se_cuenta = @i_cuenta and
		 	se_empresa = @i_empresa and
			of_empresa = @i_empresa and
                        ((of_oficina = @i_oficina and ar_area > @i_area) or 
                        (of_oficina > @i_oficina)) and
			of_oficina  = se_oficina and 
			ar_empresa = @i_empresa and
                        ar_area > 0 and
			ar_area = se_area  and
                 	of_movimiento = 'S' and
			ar_movimiento = 'S' 
                order by se_oficina,se_area
		end
		else
		begin
			/* La cuenta no posee areas autorizadas */
		--	exec cobis..sp_cerror
		--	@t_debug = @t_debug,
		--	@t_file	 = @t_file,
		--	@t_from	 = @w_sp_name,
		--	@i_num	 = 609150
			return 1
		end
	end

end

if @i_operacion = 'W' 
begin
    select @w_batch = ba_batch --'ANEXO DETALLE DE INFORMACION DE MOVIMIENTOS DE PROVISION'
    from cobis..ba_batch
    where ba_batch = 6079
    if @@rowcount = 0
        begin
            exec cobis..sp_cerror @t_debug = @t_debug,
                                  @t_file  = @t_file,
                                  @t_from  = @w_sp_name, 
                                  @i_num = 601159
            return  1
        end
    select cp_cuenta
    from cob_conta..cb_cuenta_proceso
    where cp_proceso = @w_batch
    and   @i_cuenta1  like rtrim(cp_cuenta) + '%'

end
go

