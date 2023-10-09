/************************************************************************/
/*	Archivo: 		cerror.sp				                            */
/*	Stored procedure: 	sp_cerror				                        */
/*	Base de datos:  	cobis					                        */
/*	Producto: 		Clientes				                            */
/*	Disenado por:  		Mauricio Bayas/Sandra Ortiz		                */
/*	Fecha de documentacion:	17/Nov/93			                        */
/************************************************************************/
/*				IMPORTANTE				                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	'MACOSA', representantes exclusivos para el Ecuador de la 	        */
/*	'NCR CORPORATION'.                                                  */
/*	Su uso no autorizado queda expresamente prohibido asi como          */
/*	cualquier alteracion o agregado hecho por alguno de sus             */
/*	usuarios sin el debido consentimiento por escrito de la             */
/*	Presidencia Ejecutiva de MACOSA o su representante.                 */
/*				PROPOSITO                                               */
/*      Despliega un mensaje de error de acuerdo al codigo ingresado    */
/*      o al mensaje ingresado por el usuario                           */
/*				MODIFICACIONES                                          */
/*	FECHA		AUTOR		RAZON                                       */
/*      17/Nov/93       R. Minga V.     Documentacion                   */
/************************************************************************/
use cobis
go
SET ANSI_NULLS OFF
go
if exists (select * from sysobjects where name = 'sp_cerror')
	drop proc sp_cerror
go

create proc sp_cerror (
	@t_debug	char(1) = 'N',
	@t_file		varchar(30) = null,
	@t_from		varchar(30) = null,
	@i_num		int,
	@i_sev 		int = null,
	@i_msg		varchar(1000) = null)
as
declare	@w_return		int,
	@w_sp_name		varchar(30),
	@w_msg		varchar(1000)

select @w_sp_name = 'sp_cerror'

if @t_debug = 'S'
begin
	exec @w_return = cobis..sp_begin_debug @t_file=@t_file
	select	'/** stored procedure **/' = @w_sp_name,
		t_from	= @w_sp_name,
		i_num	= @i_num,
		i_sev	= @i_sev,
		i_msg	= @i_msg
	exec @w_return = cobis..sp_end_debug
end

/* Si el usuario, no envia su propio mensaje, buscarlo en la tabla */
if (@i_msg = null)
begin
     select @i_sev = severidad,
	    @w_msg = '[' + convert(varchar,@i_num) + '] [' + @t_from + ']  ' + mensaje
     from   cl_errores
     where  numero = @i_num
     if @@rowcount != 1
     begin
	  select @w_msg = '[' + convert(varchar,@i_num) + '] [' + @t_from + ']  ' + 'No hay mensaje asociado'
	  select @i_sev = 0
     end
end
else
	select @w_msg = '[' + convert(varchar,@i_num) + '] ' + @i_msg

if @t_debug = 'S'
begin
	exec @w_return = cobis..sp_begin_debug @t_file=@t_file
	select	'/** stored procedure **/' = @w_sp_name,
		severity_bd	= @i_sev,
		i_msg_bd	= @i_msg
	exec @w_return = cobis..sp_end_debug
end

/* Desplegar el numero y el mensaje en pantalla, e indicar al sistema
   que un error a ocurrido */
raiserror (@w_msg, 16, 1)

/* si la severidad es cero, solo se despliega el mensaje, si es uno
   se realiza un rollback de las transacciones */

if @i_sev = 0
   return
else
   if @i_sev = 1
      rollback tran
return
go
