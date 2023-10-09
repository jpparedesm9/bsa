/************************************************************************/
/*      Archivo:                fendoso.sp  	                       	*/
/*      Stored procedure:       sp_primer_endoso			*/
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

if exists (select 1 from sysobjects where name = 'sp_primer_endoso')
   drop proc sp_primer_endoso
go

create proc sp_primer_endoso (
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
      @i_num_banco					  cuenta,
      @i_operacion				    char(1)
 )
with encryption
as
declare @w_sp_name          varchar(32),
		@w_operacion		int,
	    @o_ente				int,							
		@o_condicion		tinyint

select @w_sp_name = 'sp_primer_endoso'


/**  VERIFICAR CODIGO DE TRANSACCION DE APERTURA  **/
if  (@t_trn <> 14147) or @i_operacion<>'I' /*codigo tran consulta fecha endoso*/
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
select en_operacion, en_ente, en_rol, en_fecha_crea 
from pf_endoso_prop
where en_operacion= @w_operacion

if @@rowcount=0
begin

	insert into pf_endoso_prop (en_operacion, en_ente, en_rol, en_fecha_crea)
	select be_operacion, be_ente, be_rol, be_fecha_mod
	from   pf_beneficiario
	where  be_operacion = @w_operacion

	insert into pf_endoso_cond
	select dc_operacion,
       dc_ente,
       dc_fecha_mod,
       dc_condicion
	from dbo.pf_det_condicion
	where dc_operacion= @w_operacion
end
return 0

go
