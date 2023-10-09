/****************************************************************/
/*   ARCHIVO:         	sp_var_buro_credito_grupal.sp	  	    */
/*   NOMBRE LOGICO:   	sp_var_buro_credito_grupal              */
/*   PRODUCTO:        		CARTERA                             */
/****************************************************************/
/*                     IMPORTANTE                           	*/
/*   Esta aplicacion es parte de los  paquetes bancarios    	*/
/*   propiedad de MACOSA S.A.                               	*/
/*   Su uso no autorizado queda  expresamente  prohibido    	*/
/*   asi como cualquier alteracion o agregado hecho  por    	*/
/*   alguno de sus usuarios sin el debido consentimiento    	*/
/*   por escrito de MACOSA.                                 	*/
/*   Este programa esta protegido por la ley de derechos    	*/
/*   de autor y por las convenciones  internacionales de    	*/
/*   propiedad intelectual.  Su uso  no  autorizado dara    	*/
/*   derecho a MACOSA para obtener ordenes  de secuestro    	*/
/*   o  retencion  y  para  perseguir  penalmente a  los    	*/
/*   autores de cualquier infraccion.                       	*/
/****************************************************************/
/*                     PROPOSITO                            	*/
/*                                                              */
/*	Se la Calificacion del buro de Credito:                     */
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                	*/
/*   05-Jul-2017   Javier Calderon        Emision Inicial.      */
/****************************************************************/

use cob_credito
go
IF OBJECT_ID ('dbo.sp_var_buro_credito_grupal') IS NOT NULL
	DROP PROCEDURE dbo.sp_var_buro_credito_grupal
GO

CREATE PROC sp_var_buro_credito_grupal(
   @i_grupo         int = null,
   @i_cliente       int = null,
   @o_resultado     VARCHAR(255) = NULL OUTPUT
)
AS
DECLARE @w_sp_name          varchar(32),
        @w_return           INT,
        @w_error            INT,
        @w_msg              VARCHAR(255),
        ---var variables    
        @w_valor_nuevo      varchar(255),
        @w_ente             int,
        @w_calif_buro       char(255),
        @w_grupo            INT,
        @w_tipo_operacion   INT,
        @w_nro_ciclo_grupal INT,
        @w_cg_ente          int,
        @w_cg_grupo         int,
        @w_cg_estado        CHAR(1),
        @w_cg_nro_ciclo     int,
        @w_cg_calif_buro    varchar(64),
        @w_nro_ciclo        INT,
        @w_fecha_ult_consulta DATETIME,
        @w_resultado        varchar(64),
        @w_valor_ant        varchar(255),
        @w_resp_buro        varchar(500), 
        @w_integrantes      varchar(500),
        @w_grupos_ante      int

     
SELECT 
@w_sp_name ='sp_var_buro_credito_grupal',
@w_cg_calif_buro = 'BUENO',
@w_resultado  = 'BUENO'

SELECT @i_grupo, '----', @i_cliente

PRINT 'NUMERO CICLO GRUPAL: ' + convert(VARCHAR,@w_nro_ciclo_grupal)

exec sp_var_calif_buro_cred_int
@i_ente = @i_cliente,
@o_resultado = @o_resultado out

ACTUALIZAR:
--print '@w_resultado: ' + convert(varchar, @w_resultado)      
--select @o_resultado = convert(varchar,@w_cg_calif_buro)
select @o_resultado
PRINT '------------->>>>GRUPAL-RESULTADO:'+CONVERT(VARCHAR(30),@o_resultado) + '--CLIENTE:'+CONVERT(VARCHAR(30),@i_cliente)        
return 0

ERROR:
EXEC @w_error= cobis..sp_cerror
@t_debug  = 'N',
@t_file   = '',
@t_from   = @w_sp_name,
@i_num    = @w_error

return @w_error
GO
