/************************************************************************/
/*      Archivo:                fendoso.sp  	                       	*/
/*      Stored procedure:       sp_fecha_endoso				*/
/*      Base de datos:          cobis                                 	*/
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Luis Angel Gaitan                       */
/*      Fecha de documentacion: 24-Mar-98                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa consulta las fechas de endoso de un titulo	*/
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_fecha_endoso')
   drop proc sp_fecha_endoso
go

create proc sp_fecha_endoso (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_sesn                 int             = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = NULL,
@i_num_banco	        cuenta,
@i_operacion	        char(1))
with encryption
as
declare
@w_sp_name	            varchar(32),
@w_operacion	        int,
@w_max_fecha	        datetime,
@o_ente		            int,							
@o_rol		            catalogo,
@o_condicion	        tinyint

select @w_sp_name = 'sp_fecha_endoso'



/**  VERIFICAR CODIGO DE TRANSACCION DE APERTURA  **/
if  (@t_trn <> 14451) or @i_operacion<>'S' /*codigo tran consulta fecha endoso*/
begin
   exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141112
          return 1
end 
/*LECTURA DE LA OPERACION DEL TITULO A BUSCAR*/
	select @w_operacion=op_operacion 
	from pf_operacion 
	where op_num_banco=@i_num_banco


/** LECTURA FECHA DEL ENDOSO DEL TITULO */

	select convert(varchar(50),en_fecha_crea ,13)
	from pf_endoso_prop 
	where en_operacion=@w_operacion 
	group by en_fecha_crea
	order by en_fecha_crea ASC
	
go
