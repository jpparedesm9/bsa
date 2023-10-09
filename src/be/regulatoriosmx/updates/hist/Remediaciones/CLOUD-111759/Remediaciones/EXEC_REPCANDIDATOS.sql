use cob_cartera 
go 

truncate table ca_lcr_candidatos 


exec cob_cartera..sp_lcr_generar_candidatos 
     @i_param1        =  '01/11/2019',
	 @i_forzar        = 'S'-- FECHA DE PROCESO
	 
go