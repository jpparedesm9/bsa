/************************************************************************/
/*      Archivo:                calif_interna_cliente.sp                */
/*      Stored procedure:       sp_calif_interna_cliente                */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Credito y Cartera                       */
/*      Disenado por:           Daniel Nieto                            */
/*      Fecha de escritura:     11/2011                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA".                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                              PROPOSITO                               */
/************************************************************************/


use cob_credito
go



if exists (select 1 from sysobjects where name = 'sp_calif_interna_cliente')
   drop proc sp_calif_interna_cliente
go


create proc sp_calif_interna_cliente
@i_cliente       int,
@o_calificacion  int out ,
@o_msg           descripcion out
as 
declare
@w_est_novigente              tinyint     ,
@w_est_vigente                tinyint     ,
@w_est_vencido                tinyint     ,
@w_est_cancelado              tinyint     ,
@w_est_castigado              tinyint     ,
@w_est_anulado                tinyint     ,
@w_est_credito                tinyint     ,
@w_error                      int         ,
@w_msg                        descripcion ,
@w_commit                     char(1)     ,
@w_sp_name                    varchar(30) 


exec @w_error = cob_cartera..sp_estados_cca
@o_est_novigente  = @w_est_novigente out,
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_anulado    = @w_est_anulado   out,
@o_est_credito    = @w_est_credito  out

if @w_error <> 0 begin
   select @o_msg = 'ERROR AL EJECUTAR EL sp_estados_cca'
   return @w_error
end

/*Inicio de variables */
select 
@w_sp_name = 'sp_calif_interna_cliente',
@w_commit = 'N'


/*Retorna la calificacion minima del cliente*/
select @o_calificacion = isnull ( MIN(ci_nota),0) 
from cr_califica_int_mod, cob_cartera..ca_operacion 
where ci_banco = op_banco 
and ci_cliente = @i_cliente 
and op_estado <> @w_est_novigente 
and op_estado <> @w_est_cancelado 
and op_estado <> @w_est_castigado 
and op_estado <> @w_est_anulado 
and op_estado <> @w_est_credito




return 0
go