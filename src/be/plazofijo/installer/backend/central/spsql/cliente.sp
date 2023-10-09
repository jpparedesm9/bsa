/************************************************************************/
/*	Archivo:		        cliente.sp                                  */
/*	Stored procedure:	    sp_cliente                                  */
/*	Base de datos: 	        cob_pfijo 	                                */
/*	Producto:               Plazo Fijo                                  */
/*	Disenado por:           Dolores Guerrero/Gabriela Estupinan         */  
/*	Fecha de escritura:     16/Dic/1998                                 */
/************************************************************************/
/*	IMPORTANTE                                                          */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	'MACOSA', representantes  exclusivos  para el  Ecuador  de la 	    */
/*	'NCR CORPORATION'.						                            */
/*	Su  uso no autorizado  queda expresamente  prohibido asi como	    */
/*	cualquier   alteracion  o  agregado  hecho por  alguno de sus	    */
/*	usuarios   sin el debido  consentimiento  por  escrito  de la 	    */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/************************************************************************/
/*  PROPOSITO                                                           */
/*	Este programa busca si un cliente es susceptible de retencion       */
/*  de impuestos (sobre el capital)                                     */
/************************************************************************/
/*  MODIFICACIONES                                                      */
/*	FECHA           AUTOR           RAZON				                */
/*	15/Dic/1998     D.Guerrero      Emision Inicial                     */
/*	26/Ago/2016     O.Saavedra      Porting SQL 2012                    */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cliente')
   drop proc sp_cliente
go

create proc sp_cliente (
@s_ssn			int         = NULL,
@s_user			login       = NULL,
@s_sesn			int         = NULL,
@s_term			varchar(30) = NULL,
@s_date			datetime    = NULL,
@s_srv			varchar(30) = NULL,
@s_lsrv			varchar(30) = NULL, 
@s_rol			smallint    = NULL,
@s_ofi			smallint    = NULL,
@s_org_err      char(1)     = NULL,
@s_error		int         = NULL,
@s_sev			tinyint     = NULL,
@s_msg			descripcion = NULL,
@s_org			char(1)     = NULL,
@t_debug		char(1)     = 'N',
@t_file			varchar(14) = NULL,
@t_from			varchar(32) = NULL,
@t_trn			smallint    = NULL,
@i_operacion	char(2),
@i_ente         int         = NULL)
with encryption
as
declare
@w_return       int,
@w_sp_name      varchar(32),
@w_nombre       varchar(60)

select @w_sp_name = 'sp_cliente'

if (@t_trn <> 14812 and @i_operacion = 'Q') begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 141112
   return 1
end                     

if @i_operacion = 'Q' begin
   select 'Retencion'  = 'N'
end

if @i_operacion = 'V' begin
   select en_nomlar, en_subtipo, en_ced_ruc
   from   cobis..cl_ente
   where  en_ente = @i_ente
   
   select @w_nombre = rtrim(ltrim(en_nomlar))
   from   cobis..cl_ente
   where  en_ente   = @i_ente
  					    
   if @@rowcount = 0 begin
      exec cobis..sp_cerror
	  @t_debug = @t_debug,
	  @t_file  = @t_file,
	  @t_from  = @w_sp_name,
	  @i_num   = 141044,
	  @i_msg   = 'Cliente no encontrado'
	  return 1
   end
   
   select @w_nombre	
end
return 0
go
