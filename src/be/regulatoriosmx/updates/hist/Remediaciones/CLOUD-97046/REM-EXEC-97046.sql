
--11 abril	

EXEC cob_cartera..sp_gen_ref_cuota_vigente

    @i_param1        = '04/11/2018'   --- mm/dd/yyyy********************************

    ,@i_param2       = 0

 

 

EXEC cob_cartera..sp_ca_ejecuta_notificacion_jar

    @i_param1        = 'PFPCO'	