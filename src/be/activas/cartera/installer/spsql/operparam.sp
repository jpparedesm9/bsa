/************************************************************************/
/*      Archivo:                operparam.sp                            */
/*      Stored procedure:       sp_crear_operacion                      */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Lorena Regalado                         */
/*      Fecha de escritura:     Ene. 2017                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA"							*/
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                              PROPOSITO                               */
/*      Inserta Operaciones asociadas a un parametro                    */
/************************************************************************/  

use cob_cartera
go


IF OBJECT_ID ('dbo.sp_operacion_param') IS NOT NULL
	DROP PROCEDURE dbo.sp_operacion_param
GO

create proc sp_operacion_param (
    @i_operacion    char(1),
    @i_operacionca  INT ,
    @i_columna      varchar(30),
    @i_grupal       char(1)

)
as

declare
@w_sp_name               varchar(30),
@w_return                int

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name   = 'sp_operacion_param'


if @i_operacion = 'I' 
begin

   /*  Creacion de Registros de tabla de parametros de Cartera  */
   
      IF @i_operacionca is NULL 
      BEGIN
         PRINT 'Error debe enviar operacion de Cartera'
         return 724600
   
      END
   
      IF @i_columna is NULL 
      BEGIN
         PRINT 'Error debe enviar columna de parametro'
         return 724601
   
      END
   

      insert into cob_cartera..ca_operacion_ext_tmp (
      oet_operacion, 	oet_columna,	oet_char,	oet_tinyint,
      oet_smallint, 	oet_int, 	oet_money, 	oet_datetime,
      oet_estado, 	oet_tinyInteger, oet_smallInteger,
      oet_integer, 	oet_float)
      values (
      @i_operacionca,      @i_columna,     @i_grupal, NULL,    
      NULL, NULL, NULL,
      NULL, NULL, NULL, NULL,
      NULL, NULL
      )
  
      if @@error != 0 return 724602
 


END

if @i_operacion = 'U' 
begin
PRINT 'entro por update'
   /*  Creacion de Registros de tabla de parametros de Cartera  */
   
      IF @i_operacionca is NULL 
      BEGIN
         PRINT 'Error debe enviar operacion de Cartera'
         return 724600
   
      END
   
      IF @i_columna is NULL 
      BEGIN
         PRINT 'Error debe enviar columna de parametro'
         return 724601
   
      END
   
   
      update cob_cartera..ca_operacion_ext_tmp 
      SET oet_char = @i_grupal
      WHERE oet_operacion = @i_operacionca
      AND oet_columna = @i_columna
      
        
      if @@error != 0 return 724602
 


END


return 0 


GO

