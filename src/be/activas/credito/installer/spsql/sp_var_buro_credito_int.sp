/****************************************************************/
/*   ARCHIVO:           sp_var_buro_credito_int.sp              */
/*   NOMBRE LOGICO:     sp_var_buro_credito_int                 */
/*   PRODUCTO:              CARTERA                             */
/****************************************************************/
/*                     IMPORTANTE                               */
/*   Esta aplicacion es parte de los  paquetes bancarios        */
/*   propiedad de MACOSA S.A.                                   */
/*   Su uso no autorizado queda  expresamente  prohibido        */
/*   asi como cualquier alteracion o agregado hecho  por        */
/*   alguno de sus usuarios sin el debido consentimiento        */
/*   por escrito de MACOSA.                                     */
/*   Este programa esta protegido por la ley de derechos        */
/*   de autor y por las convenciones  internacionales de        */
/*   propiedad intelectual.  Su uso  no  autorizado dara        */
/*   derecho a MACOSA para obtener ordenes  de secuestro        */
/*   o  retencion  y  para  perseguir  penalmente a  los        */
/*   autores de cualquier infraccion.                           */
/****************************************************************/
/*                     PROPOSITO                                */
/*  Corresponde al lo contestado por el cliente en el formato   */
/*  de Solicitud de Crédito Grupal en la pregunta ¿Es Promoción?*/
/*  Por defecto, la respuesta de esta variable será NO.         */
/*                                                              */
/****************************************************************/
/*                     MODIFICACIONES                           */
/*   FECHA         AUTOR               RAZON                    */
/*   17-May-2017   Sonia Rojas        Emision Inicial.          */
/****************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_var_buro_credito_int')
   drop proc sp_var_buro_credito_int
go

create proc [dbo].[sp_var_buro_credito_int](
         @i_grupo      int,
         @i_tramite    INT,
		 @o_resultado  VARCHAR(255) = NULL OUTPUT
		 
)
as
declare @w_sp_name                          varchar(64),
        @w_error                            int,
        @w_grupo                            int,
        @w_tramite                          int,
        @w_num_miembros                     int,
        @w_resultado                        varchar(10),
        @w_asig_actividad                   int,        
        @w_valor_ant                        varchar(255),
        @w_valor_nuevo                      varchar(255),
        @w_tg_ente                          int,
        @w_tg_grupo                         int
        
select @w_sp_name = 'sp_var_buro_credito_int',
@w_resultado = 'BUENO'


SELECT tg_cliente,tg_grupo
into #cliente_grupo_buro
FROM cob_credito..cr_tramite_grupal
WHERE tg_grupo = @i_grupo
and tg_tramite = @i_tramite
  
   
declare cursor_calif_buro_cliente cursor for SELECT 
tg_cliente,tg_grupo
FROM #cliente_grupo_buro
for read only

OPEN cursor_calif_buro_cliente

fetch cursor_calif_buro_cliente into @w_tg_ente,@w_tg_grupo

while @@fetch_status = 0  begin
   
              
   EXEC @w_error  = cob_credito..sp_var_buro_credito_grupal
   @i_grupo       = @w_tg_grupo,
   @i_cliente     = @w_tg_ente,
   @o_resultado   = @w_valor_nuevo OUTPUT
   
   if @w_error  <> 0
   BEGIN
   
      exec cobis..sp_cerror
      @t_debug  = 'N',
      @t_file   = '',
      @t_from   = @w_sp_name,
      @i_num = 2101002
      return 1
   END
   
   if @w_valor_nuevo = 'MALO'
   begin 
         
     break
     
   end
     
   fetch cursor_calif_buro_cliente into @w_tg_ente,@w_tg_grupo
         
end
   
      
close cursor_calif_buro_cliente
deallocate cursor_calif_buro_cliente

PRINT 'CALIFICACION GRUPAL: ' +  convert(VARCHAR,@w_tg_grupo) + ' --->'+ @w_valor_nuevo

select @o_resultado = @w_valor_nuevo


return 0


ERROR:
select @w_error = 6904007 --No existieron resultados asociados a la operacion indicada   
EXEC @w_error= cobis..sp_cerror
@t_debug  = 'N',
@t_file   = '',
@t_from   = @w_sp_name,
@i_num    = @w_error

return @w_error




GO

