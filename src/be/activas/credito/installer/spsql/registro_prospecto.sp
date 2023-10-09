/************************************************************************/
/*      Archivo:                sp_registro_prospecto.sp                */
/*      Stored procedure:       sp_registro_prospecto                   */
/*      Base de datos:          cob_credito                             */
/*      Producto:               Credito                                 */
/*      Disenado por:           Henry Muñoz                             */
/*      Fecha de escritura:     01/2012                                 */
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
/*								                                     	*/
/************************************************************************/
use cob_credito
go
if exists(select 1 from sysobjects where name = 'sp_registro_prospecto')
   drop proc sp_registro_prospecto
go

create  proc sp_registro_prospecto(
@i_cliente           int            ,
@i_operacionca       int            ,
@i_fecha             datetime =null ,
@o_msg               descripcion
)
as
declare
@w_error           int,
@w_msg             varchar(255)


/*INICIALIZAR VARIABLES*/


if  exists(select 1 
           from cr_prospecto_contraoferta 
           where pr_cliente = @i_cliente 
           and pr_operacion = @i_operacionca )
   return 0

insert into cr_prospecto_contraoferta(
pr_cliente,   pr_operacion,     pr_fecha_proceso)
values(
@i_cliente ,  @i_operacionca,   @i_fecha)
      
if @@error <> 0
begin
  select @o_msg = 'NO SE PUDO INSERTAR EL DATO'
  return 143001
end

return 0

go

     