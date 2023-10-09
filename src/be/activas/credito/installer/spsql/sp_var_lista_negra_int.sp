/************************************************************************/
/*  Archivo:                sp_var_lista_negra_int.sp                   */
/*  Stored procedure:       sp_var_lista_negra_int                      */
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

IF OBJECT_ID ('dbo.sp_var_lista_negra_int') IS NOT NULL
	DROP PROCEDURE dbo.sp_var_lista_negra_int
GO

CREATE PROC sp_var_lista_negra_int
		(@i_ente    INT,
		 @i_valida  char(1) = 'N',
		 @o_resultado  VARCHAR(255) = NULL OUTPUT,
		 @o_dictamen_nf   varchar(255) = null OUTPUT,
		 @o_dictamen_ln  varchar(255) = null OUTPUT,
		 @o_es_ln	     char(1)= null OUTPUT,
		 @o_es_nf		 char(1)= null OUTPUT
		 )
AS
DECLARE @w_sp_name       	varchar(32),
        @w_return        	INT,
        ---var variables	
        @w_valor_nuevo    	varchar(255),
        @w_ente             int,
		@w_lista_negra	    char(1),
		@w_lista_negative   char(1),
		@w_tipo_dictamen	varchar(10)
		
       

SELECT @w_sp_name='sp_var_lista_negra_int'

SELECT @w_lista_negra='N'
SELECT @w_lista_negative='N'

select @o_dictamen_ln='NR',
		@o_dictamen_nf='NR'

--Listas negra
SELECT @w_lista_negra = ea_lista_negra
FROM  cobis..cl_ente_aux, cobis..cl_ente 
WHERE en_ente = ea_ente
AND   en_ente   = @i_ente
select @w_lista_negra = isnull(@w_lista_negra,'N')

--Listas negative
SELECT @w_lista_negative = ea_negative_file
FROM  cobis..cl_ente_aux, cobis..cl_ente 
WHERE en_ente = ea_ente
AND   en_ente   = @i_ente

select @w_lista_negative = isnull(@w_lista_negative,'N')

select @i_ente = isnull(@i_ente,0)

if @i_ente = 0 return 0

if(@i_valida ='S')
begin
	if(@w_lista_negative='S')
	begin
		select @o_dictamen_nf=ar_status from cobis..cl_alertas_riesgo where ar_ente=@i_ente and ar_tipo_lista='NF'		
	end
	if(@w_lista_negra='S')
	begin
		select @o_dictamen_ln=ar_status from cobis..cl_alertas_riesgo where ar_ente=@i_ente and ar_tipo_lista='LI'		
	end
end

if(@i_valida='N')
begin
	IF @w_lista_negra = 'N'
	begin
	  select @w_valor_nuevo  = 'NO'  
	end
	ELSE
	begin
	  select @w_valor_nuevo  = 'SI'
	end
end
else if(@i_valida ='S')
begin
	IF @w_lista_negra = 'N' AND @w_lista_negative = 'N'
	begin
	  select @w_valor_nuevo  = 'NO'  
	end
	ELSE
	begin
	  if(@w_lista_negra ='S')
		select @o_es_ln = 'S'
	  
	  if(@w_lista_negative='N')
	    select @o_es_nf = 'S'
	  
	  select @w_valor_nuevo  = 'SI'
	end
end


SELECT @o_resultado = @w_valor_nuevo
return 0
GO
