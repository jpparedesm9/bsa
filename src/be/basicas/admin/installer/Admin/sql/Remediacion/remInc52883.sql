use cobis
go 
	update cobis..ad_vistas_trnser
	set vt_campo_secuencial  ='secuencia'
	where vt_tabla =  'ts_conexion_login'
go