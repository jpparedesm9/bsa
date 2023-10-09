/************************************************************************/
/*  Archivo:                sp_var_es_partner_int.sp                    */
/*  Stored procedure:       sp_var_es_partner_int                       */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Patricio Samueza                            */
/*  Fecha de Documentacion: 31/Jul/2017                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Procedure tipo Variable, Retorna SI si es partner de la solicitud    */
/* de credito individual                                                */
/************************************************************************/
/*                                                                      */
/*                                                                      */
/*                                                                      */
/* **********************************************************************/
USE cob_credito
GO
IF OBJECT_ID ('dbo.sp_var_es_partner_int') IS NOT NULL
	DROP PROCEDURE dbo.sp_var_es_partner_int
GO

CREATE PROC sp_var_es_partner_int
		(@i_ente    INT,
		 @o_resultado  VARCHAR(255) = NULL OUTPUT
		 )
AS
DECLARE @w_sp_name       	varchar(32),
        @w_return        	INT,
        ---var variables	
        @w_valor_nuevo    	varchar(255),
		@w_es_partner	    char(1),
        @w_ente            int
       

       

SELECT @w_sp_name='sp_var_es_partner_int'

SELECT @w_es_partner = 'N'

SELECT @w_es_partner = ea_partner
FROM cobis..cl_ente_aux, cobis..cl_ente 
WHERE en_ente = ea_ente
AND   en_ente   = @i_ente

select @w_es_partner = isnull(@w_es_partner,'N')


select @i_ente = isnull(@i_ente,0)

if @i_ente = 0 return 0
     
SELECT @w_ente = @i_ente

IF @w_es_partner = 'N'
begin
  select @w_valor_nuevo  = 'NO'  
end
ELSE
begin
  select @w_valor_nuevo  = 'SI'
END


SELECT @o_resultado = @w_valor_nuevo
return 0
GO



