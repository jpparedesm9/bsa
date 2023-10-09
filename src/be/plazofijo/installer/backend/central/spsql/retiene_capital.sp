/************************************************************************/
/*	Archivo:		retcapi.sp				*/
/*	Stored procedure:	sp_retiene_capital 	        	*/ 
/*	Base de datos: 	        cob_pfijo	                        */ 
/*	Producto:               Plazo fijo                      	*/
/*	Disenado por:           Gabriela Estupinan              	*/
/*	Fecha de escritura:     28/Dic/1998				*/
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
/*	Este define si se necesita realizar la retencion del 1% de      */
/*      de acuerdo al tipo de transaccion que se va a realizar,  antes  */
/*      de aplicar el mov_monet para enviar la variable @i_retener = 'S'*/
/*      a cuentas de inversion para que se retenga el impuesto en el    */
/*      credito automatico.                                             */
/*	                        					*/
/*                           MODIFICACIONES                             */
/*	FECHA		AUTOR		RAZON				*/
/*	28/Dic/1998     G.Estupinan     Emision Inicial                 */ 
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

if exists (select 1 from sysobjects where name = 'sp_retiene_capital')
   drop proc sp_retiene_capital
go

create proc sp_retiene_capital (
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
@t_trn			        smallint    =NULL,
@i_operacion		    int,
@o_retiene_capital      char(1) out     
)
with encryption
as
declare
@w_return               int,
@w_sp_name	            varchar(32),
@w_ente                 int,
@w_retencion            char(1)

select @w_sp_name = 'sp_retiene_capital'

select @w_ente = op_ente
from pf_operacion
where op_operacion = @i_operacion

if @@rowcount = 0
begin 
   exec cobis..sp_cerror
      @t_debug	 = @t_debug,
      @t_file	 = @t_file,
      @t_from	 = @w_sp_name,
      @i_num	 = 141004
   return 141004
end

select @w_retencion = en_retencion
from  cobis..cl_ente
where en_ente = @w_ente

if @@rowcount = 0
begin
   exec cobis..sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 141044
   return 141044
end                                
if @w_retencion = 'S' and 
   (@t_trn = 14903 or @t_trn = 14905 or @t_trn = 14919 or @t_trn = 14913
   or @t_trn = 14914  or @t_trn = 14929)
begin
  select @o_retiene_capital = 'S'
end
else
begin
  select @o_retiene_capital = 'N'
end
go
