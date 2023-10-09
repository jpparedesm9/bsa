/************************************************************************/
/*   Stored procedure:     sp_clientes_grupo                           */
/*   Base de datos:        cob_cartera                                  */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/*  consulta los miembro que estan en un grupo del SANTANDER			*/
/************************************************************************/
/*                            CAMBIOS                                   */
/************************************************************************/
/*   13/DEC/2019    JCH		  EMISION INICIAL 		                    */
/*   09-Oct-2020    ACH       ERR. 147494                               */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_clientes_grupo')
   drop proc sp_clientes_grupo
go

create proc sp_clientes_grupo
(  @s_ssn              int          = null,
   @s_sesn             int          = null,
   @s_srv              varchar (30) = null,
   @s_lsrv             varchar (30) = null,
   @s_user             login        = null,
   @s_date             datetime     = null,
   @s_ofi              int          = null,
   @s_rol              tinyint      = null,
   @s_org              char(1)      = null,
   @s_term             varchar (30) = null,  
   @i_tramite   	   int          = null,
   @i_operacion        char(1)      = 'Q'
)
as
declare 
@w_sp_name                  varchar(30),
@w_fecha_proceso            datetime,
@w_rowcount					int

select @w_sp_name = 'sp_clientes_grupo'
select @w_fecha_proceso = fp_fecha 
from cobis..ba_fecha_proceso


-----------------------------------
--informacion  titular asegurado---
-----------------------------------
if(@i_operacion='Q' and (@i_tramite <> 0)) 
begin
	select 
	 se_operacion		  ,     
	 se_banco    		  ,
	 se_cliente  		  ,
	 se_fecha_ini		  ,
	 se_fecha_ult_intento ,
	 se_monto			  ,	
     se_estado            ,
	 se_fecha_reporte     ,
	 se_tramite           ,
	 se_grupo             ,
	 se_monto_pagado      ,
	 se_monto_devuelto    ,
     se_forma_pago        ,
	 ltrim(rtrim(se_tipo_seguro))
	 from  cob_cartera..ca_seguro_externo
	 where se_tramite     = @i_tramite	
	 and   se_monto       > 0
	 and   se_monto       >= (isnull(se_monto_pagado,0) - isnull(se_monto_devuelto,0))
	 and   se_tipo_seguro = 'EXTENDIDO'
	 
	if @w_rowcount = 0
	begin
		exec cobis..sp_cerror
			@t_debug  = 'N',
			@t_from   = @w_sp_name,
			@i_num    = 151172 --   No existen registros     
		return 151172  	
	end
end
else 
begin
	exec cobis..sp_cerror
		 @t_debug  = 'N',
		 @t_from   = @w_sp_name,
		 @i_num    = 708150 --  CAMPO REQUERIDO ESTA CON VALOR NULO         
	return 708150   
end 



return 0

go