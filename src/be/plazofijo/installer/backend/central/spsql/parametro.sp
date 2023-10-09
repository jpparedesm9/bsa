/************************************************************************/
/*	Archivo:		paramet.sp				*/
/*	Stored procedure:	sp_parametro   				*/
/*	Base de datos: 	        cobis					*/
/*	Producto:               Clientes				*/
/*	Disenado por:           Mauricio Bayas/Sandra Ortiz		*/
/*	Fecha de escritura:     19/Ene/1994				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	'MACOSA', representantes  exclusivos  para el  Ecuador  de la 	*/
/*	'NCR CORPORATION'.						*/
/*	Su  uso no autorizado  queda expresamente  prohibido asi como	*/
/*	cualquier   alteracion  o  agregado  hecho por  alguno de sus	*/
/*	usuarios   sin el debido  consentimiento  por  escrito  de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa realiza busqueda de cl_parametro              	*/
/*	                        					*/
/*                           MODIFICACIONES                             */
/*	FECHA		AUTOR		RAZON				*/
/*	15/Dic/1998     D.Guerrero      Emision Inicial                 */ 
/*	                G.Estupinan                      		*/
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_parametro')
   drop proc sp_parametro
go

create proc sp_parametro (
@s_ssn			        int         = NULL,
@s_user			        login       = NULL,
@s_sesn			        int         = NULL,
@s_term			        varchar(30) = NULL,
@s_date			        datetime    = NULL,
@s_srv			        varchar(30) = NULL,
@s_lsrv			        varchar(30) = NULL, 
@s_rol			        smallint    = NULL,
@s_ofi			        smallint    = NULL,
@s_org_err		        char(1)     = NULL,
@s_error		        int         = NULL,
@s_sev			        tinyint     = NULL,
@s_msg			        descripcion = NULL,
@s_org			        char(1)     = NULL,
@t_debug		        char(1)     = 'N',
@t_file			        varchar(14) = NULL,
@t_from			        varchar(32) = NULL,
@t_trn			        smallint    = NULL,
@i_operacion            char(2),
@i_modo			        tinyint     = NULL,
@i_parametro   	        descripcion = NULL,
@i_nemonico    	        catalogo    = NULL,
@i_tipo        	        char(1)     = NULL,
@i_char                 varchar(30) = NULL,
@i_tinyint              tinyint     = NULL,
@i_smallint  	        smallint    = NULL,
@i_int         	        int         = NULL,
@i_money       	        money       = NULL,
@i_datetime             datetime    = NULL,
@i_float                float       = NULL,
@i_producto		        char(3)     = NULL)
with encryption
as
declare
@w_return               int,
@w_sp_name	            varchar(32),
@w_parametro            descripcion,
@w_nemonico             catalogo,
@w_tipo                 char(1),
@w_char                 char(1),
@w_tinyint              tinyint,
@w_smallint             smallint,
@w_int                  int,
@w_money                money,
@w_datetime             datetime,
@w_float                float,
@w_producto             char(3),
@v_parametro            descripcion,
@v_nemonico             catalogo,
@v_tipo                 char(1),
@v_char                 char(1),
@v_tinyint              tinyint,
@v_smallint             smallint,
@v_int                  int,
@v_money                money,
@v_datetime             datetime, 
@v_float                float,
@v_producto             char(3)

select @w_sp_name = 'sp_parametro'


if @i_operacion = 'Q'
begin
   if @t_trn = 14447
   begin
	select 'Nemonico' = pa_nemonico ,
	       'Parametro' = convert(varchar,pa_parametro),
         'Tipo' = pa_tipo,
	       'Valor Char' = isnull(pa_char,' '),
	       'ValorTinyint' = isnull(pa_tinyint,0),
         'Valor Smallint' = isnull(pa_smallint,0),
         'Valor Int' = isnull(pa_int,0),
	       'Valor Money' = isnull(pa_money,0.0), 
         'Valor Float' = isnull(pa_float,0.0),
         'Valor Datetime' = pa_datetime,
	       'Cod.Prod.' = pd_producto,
	       'Des.Prod.' = pd_descripcion,
	       'Producto' = pa_producto
	from  cobis..cl_parametro , cobis..cl_producto
  where pa_nemonico = @i_nemonico 
	  and (pa_producto = @i_producto or @i_producto is null)
 	  and pa_producto = pd_abreviatura
     return 0
   end
   else
   begin
	exec cobis..sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
   end
end
go
