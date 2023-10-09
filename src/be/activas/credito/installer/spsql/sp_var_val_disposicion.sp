/************************************************************************/
/*      Archivo           :  sp_var_val_disposicion.sp                  */
/*      Base de datos     :  cob_credito                                */
/*      Producto          :  Cuentas de Ahorros                         */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "COBIS", representantes exclusivos para el Ecuador.             */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBIS o su representante.              */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Procedimiento para la integración con el motor de reglas de SSS */
/*      y el sp de validacion_alertas                               	*/
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR           RAZON                           */
/*  19/Abr/2019         SRO          Emision inicial                    */
/************************************************************************/
use cob_credito
go

if object_id('sp_var_val_disposicion') is not null
begin
   drop proc sp_var_val_disposicion
   if object_id('sp_var_val_disposicion') is not null
      print 'FALLO BORRADO DE PROCEDIMIENTO sp_var_val_disposicion'
end
go
create proc sp_var_val_disposicion
(	
@t_trn       		int          = null,
@i_code_var       	int          = null,
@i_id_inst_proceso  int          = null,
@i_param1           int          = null,
@i_param2           varchar(50)  = null,
@i_param3           int          = null,
@i_param4           varchar(50)  = null,
@o_real_value       varchar(255) = null out
)
as


select @o_real_value = @i_param2
	
return 0
go