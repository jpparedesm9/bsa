/************************************************************************/
/*	Archivo: 		ctaperfi.sp 			        */
/*	Stored procedure: 	sp_cuenta_perfiles			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Fabio C Cardona                       	*/
/*	Fecha de escritura:     12-Mar-1999 				*/
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
/*      Este sp es llamado recursivamente por el                        */
/* 	sp -> sp_consulta_cuenta_perfil			                */
/*									*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/*	12-Marzo-1999	Fabio C Cardona     Emision Inicial		*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cuenta_perfiles')
   drop proc sp_cuenta_perfiles
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_cuenta_perfiles(			/*Este sp es llamado por sp_padre_perfil*/
	@i_empresa		tinyint = null,
	@i_cuenta		cuenta = null,
	@i_cta_perfil		varchar(20) = null,
	@i_paso			tinyint
)
as 

declare @w_param		varchar(20),
	@w_string       	varchar(20),
	@w_today 		datetime,  	/* fecha del dia */
	@w_sp_name		varchar(32),	/* descripcion del stored procedure*/
	@w_variable		varchar(10),
	@w_mensaje		varchar(70),
	@w_posini		smallint,
	@w_lenparam		smallint,
	@w_long			smallint,
	@w_num			smallint,
	@w_paso			smallint,
	@w_leftpart		varchar(20),
	@w_rightpart		varchar(20),
	@w_cta_perfil		varchar(40),
	@w_cuenta		varchar(40)
	


select @w_today = getdate()
select @w_sp_name = 'sp_cuenta_perfiles'


/*************/
truncate table cb_temp_cuenta
truncate table cb_temp_cuenta2
/************/


/********Verificamos existencias**********/

if @i_paso = 0
begin

	if NOT EXISTS (select * from cb_det_perfil
		       where dp_empresa = @i_empresa and
        		     dp_cuenta = @i_cuenta)
	begin
		print 'La cuenta no existe'
		return 1
	end
end


declare param_cursor cursor
for select  distinct re_parametro, re_substring
from cb_relparam

open  param_cursor
fetch param_cursor
into  @w_param,@w_string


while(@@fetch_status = 0)
begin

	if @i_paso = 0	
	begin
		select @w_posini = charindex(@w_param, @i_cuenta)

		if @w_posini > 0 
		begin
			if NOT EXISTS (select * from cb_temp_cuenta
			       where cuenta=@i_cuenta and
			             param=@w_param and
				     posini=@w_posini)
			begin
				insert into cb_temp_cuenta (cuenta,param,posini)
				values(@i_cuenta,@w_param,@w_posini)
			end
		end
	end
	else
	begin
		select @w_posini = charindex(@w_param, @i_cta_perfil)

		if @w_posini > 0 
		begin
			if NOT EXISTS (select * from cb_temp_cuenta
				       where cuenta=@i_cta_perfil and
				             param=@w_param and
					     posini=@w_posini)
			begin
				insert into cb_temp_cuenta (cuenta,param,posini)
				values(@i_cta_perfil,@w_param,@w_posini)
			end
		end
	end

	fetch param_cursor
	into @w_param,@w_string
	
end

close param_cursor
deallocate param_cursor


/******************************************************************************************************/

truncate table cb_temp_cuenta2

insert into cb_temp_cuenta2 				/*Pasamos la informaciona otra tabla igual*/
select cuenta,param,posini from cb_temp_cuenta

truncate table cb_temp_cuenta			/*Borramos la tabla original para guardar las nuevas cuentas*/


declare cuentas_cursor cursor
for select  * 
from cb_temp_cuenta2

open  cuentas_cursor
fetch cuentas_cursor
into  @w_cuenta, @w_param, @w_posini


while(@@fetch_status = 0 and @w_param is not null)
begin

	select @w_lenparam = len(@w_param)
	select @w_long = len(@w_cuenta)
	select @w_num = (@w_long - (@w_posini + @w_lenparam)) + 1
	select @w_leftpart = substring(@w_cuenta,1,(@w_posini-1))
	select @w_rightpart = right(@w_cuenta,@w_num)
	
	declare temp_cursor cursor
	for select distinct re_parametro,re_substring
	from cb_relparam
	where re_parametro = @w_param

	open temp_cursor
	fetch temp_cursor
	into @w_param,@w_string
				
	while(@@fetch_status = 0)
	begin
		select @w_cta_perfil = @w_leftpart + @w_string + @w_rightpart
		insert into cb_consulta_perfil (cp_cuenta, cp_cuenta_perfil)
		values (@i_cuenta, @w_cta_perfil)

		fetch temp_cursor
		into @w_param,@w_string
	end

	close temp_cursor
	deallocate temp_cursor

	fetch cuentas_cursor
	into  @w_cuenta, @w_param, @w_posini
	
				
end

close cuentas_cursor
deallocate cuentas_cursor

return 0

go
