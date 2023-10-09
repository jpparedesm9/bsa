USE cobis
go

---------------------------------
EXEC sp_cambio_oficial_borrar  
	@i_caso   = 103843,
	@i_ente   = 27758  ,
	@i_grupo  = 0,
	@i_login_asesor_ini = 'amaguirre',
	@i_login_asesor_fin = 'sperezte'


-----------------------------
---------------------------------
EXEC sp_cambio_oficial_borrar  
	@i_caso   = 103843,
	@i_ente   = 3831  ,
	@i_grupo  = 0,
	@i_login_asesor_ini = 'jlozadace',
	@i_login_asesor_fin = 'sperezte'


-----------------------------
