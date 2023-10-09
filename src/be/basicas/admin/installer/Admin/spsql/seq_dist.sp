/************************************************************************/
/*	Archivo:		seq_dist.sp				*/
/*	Stored procedure:	sp_seq_dist				*/
/*	Base de datos:		cobis					*/
/*	Producto: 		Administracion				*/
/*	Disenado por:  		Alexis Rodr¡guez			*/
/*	Fecha de escritura: 25-Abr-2000					*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA". 							*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*									*/
/*				PROPOSITO				*/
/*	Este programa consulta el valor del secuencial correspondiente	*/
/*	a una tabla de la tabla di_seqnos				*/
/*									*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	2003-02-05	A. Duque	Cambio de secuencial 		*/
/************************************************************************/

use cob_distrib
go

if exists (select * from sysobjects where name = 'sp_seq_dist')
   drop proc sp_seq_dist
go

create proc sp_seq_dist (
	@s_ssn			int 		= NULL,
	@s_user			login 		= NULL,
	@s_sesn			int 		= NULL,
	@s_term			varchar(30) 	= NULL,
	@s_date			datetime 	= NULL,
	@s_srv			varchar(30) 	= NULL,
	@s_lsrv			varchar(30) 	= NULL, 
	@s_rol			smallint 	= NULL,
	@s_ofi			smallint 	= NULL,
	@s_org_err		char(1) 	= NULL,
	@s_error		int 		= NULL,
	@s_sev			tinyint 	= NULL,
	@s_msg			descripcion 	= NULL,
	@s_org			char(1) 	= NULL,
	@t_debug		char(1) 	= 'N',
	@t_file			varchar(14) 	= null,
	@t_from			varchar(32) 	= null,
	@t_trn			smallint 	= NULL,
	@i_en_linea		char(1)		='N',
	@i_tabla		varchar(30),
	@o_siguiente		int		= NULL OUTPUT
)
as
declare
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_servidor		varchar(30),
	@w_tabla		varchar(30),
	@w_seq			int

select @w_sp_name = 'sp_seq_dist'
select @w_tabla	= @i_tabla


if @t_trn=15172
begin

	/*** VERIFICAR EXISTENCIA DE LA TABLA *****/

	if exists (select * from di_log)
	Begin

		/**** CONSULTA DEL SECUENCIAL CORRESPONDIENTE A LA TABLA ****/

		select @w_seq=max(lg_id) + 1
		from di_log

		if @i_en_linea<>'N' 
		Begin
			select @w_seq
		End
		Else
		Begin
			select @o_siguiente=@w_seq
		End

		return 0
	End
	else
	Begin
		select @w_seq = 1
		if @i_en_linea<>'N' 
			select @w_seq
		else
			select @o_siguiente=@w_seq
		return 0
	End

end
else
begin
	if @i_en_linea<>'N'
	Begin
		exec cobis..sp_cerror
		@t_debug	 = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 141018

		return 1
	End
	else
		return 1
end




go


