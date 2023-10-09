/************************************************************************/
/*	Archivo:		func.sp					*/
/*	Stored procedure:	sp_funcionalidad			*/
/*	Base de datos:		cobis					*/
/*	Producto: 		ADMIN-Seguridades			*/
/*	Disenado por:  							*/
/*	Fecha de escritura: 	25-MAY-2001				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	'MACOSA'. 							*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa realiza consultas de las funcionalidades hijas	*/
/*	COBIS WEB							*/
/************************************************************************/
/*				MODIFICACIONES				*/
/************************************************************************/
/*  28/Ene/2009    A.Tabarez       Porting SQLServer2005                */
/************************************************************************/

use cobis
go
SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_fn_hijas')
   drop proc sp_fn_hijas
go

create procedure sp_fn_hijas
(
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
	
	@i_operacion		varchar(1),
	@i_modo 		smallint 	= 0,
	
	/* Clave del nodo cuyos hijos quieren obtenerse. Si no se especifica se traen los nodos raices */
	@i_padre		char(12)	= NULL,
	@i_idioma		catalogo	= 'ESP',
	@i_etiqueta descripcion = NULL,
	@i_rol			tinyint		= NULL
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32)
                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                              
select @w_today = @s_date
select @w_sp_name = 'sp_fn_hijas'

/********* QUERY ***********/
if @i_operacion = 'Q'
begin
                                                                                                                                                                                                                                                         
	/******** CONTROL DE TRANSACCION ********/
	if @t_trn = 15295
	begin
    if @i_modo = 0
    begin
     	set rowcount 20


				/***** CONTROL NULOS ********/
				if (
				    @i_rol is null
		   	    )
				Begin
					exec cobis..sp_cerror
		   			@t_debug = @t_debug,
		   			@t_file	 = @t_file,
		   			@t_from	 = @w_sp_name,
		   			@i_num	 = 151001
					return 1
				end
				                                                                                                                                                                                                                                                          
				/***** QUERY DEL SERVIDOR *******/

				select
					'Etiqueta'=ef_etiqueta,
					fn_func,
					fn_tipo,
					fn_visible,
					fn_ref,  
					fn_nemonico,
					fn_bold,
					fn_reload,
					fn_captura,
					af_ayuda,
					'CodIdioma'=ef_idioma,
					'Idioma'=substring(C.valor,1,20),
					'Orden' = fn_orden
				from 	aw_funcionalidad LEFT OUTER JOIN aw_ayuda_funcionalidad
			                                ON (fn_func =af_func),
					aw_func_rol,
					aw_etiqueta_funcionalidad,
					cl_catalogo C,
					cl_tabla T
				where ef_func=fn_func
 			                  and fr_rol=@i_rol
        	                                                  and fr_func=fn_func
					and T.tabla='aw_idioma'
					and C.tabla=T.codigo
					and ef_idioma=C.codigo
					and ef_idioma=@i_idioma
					and (af_idioma=@i_idioma or af_idioma is null)  /** sustituido en reemplazo  C.codigo*=af_idioma  */
					and (fn_padre=@i_padre or ((rtrim(fn_padre) is null or rtrim(fn_padre) = '') and (@i_padre is NULL)))
				order by ef_etiqueta
                                                                                                                                                                                                                                  
   		set rowcount 0
   		return 0
   	end  /* @i_modo=0 */
                                                                                                                                                                                                                                                
    if @i_modo = 1
		begin

			/***** CONTROL NULOS ********/
			if (
					@i_etiqueta is null or
					@i_rol is null
					)
			Begin
				exec cobis..sp_cerror
	   			@t_debug = @t_debug,
	   			@t_file	 = @t_file,
	   			@t_from	 = @w_sp_name,
	   			@i_num	 = 151001
				return 1
			end

     	set rowcount 20

				select
					'Etiqueta'=ef_etiqueta,
					fn_func,
					fn_tipo,
					fn_visible,
					fn_ref,  
					fn_nemonico,
					fn_bold,
					fn_reload,
					fn_captura,
					af_ayuda,
					'CodIdioma'=ef_idioma,
					'Idioma'=substring(C.valor,1,20),
					'Orden' = fn_orden
				from 	aw_funcionalidad LEFT OUTER JOIN aw_ayuda_funcionalidad
			                                ON (fn_func =af_func),
					aw_func_rol,
					aw_etiqueta_funcionalidad,
					cl_catalogo C,
					cl_tabla T
				where       ef_func=fn_func
		  		                and fr_rol=@i_rol
	                                                                and fr_func=fn_func
					and T.tabla='aw_idioma'
					and C.tabla=T.codigo
					and C.codigo=ef_idioma
					and ef_idioma=@i_idioma
					and (af_idioma=@i_idioma or af_idioma is null)  /** sustituido en reemplazo  C.codigo*=af_idioma  */
					and (fn_padre=@i_padre or ((rtrim(fn_padre) is null or rtrim(fn_padre) = '') and (@i_padre is NULL)))
					and ef_etiqueta>@i_etiqueta
				order by ef_etiqueta

 			set rowcount 0
			return 0
		end /* @i_modo=1 */
	end  /* @t_trn = 15295 */
	else 
                                                                                                                                                                                                                                                        
	/******* ERROR TRANSACCION *********/
                                                                                                                                                                                                                        
	begin
		exec cobis..sp_cerror
	   	@t_debug = @t_debug,
	   	@t_file	 = @t_file,
	   	@t_from	 = @w_sp_name,
	   	@i_num	 = 141018
		return 1
	end
end  
                                                                                                                                                                                                                                                         
/********* FIN QUERY *********/
go
