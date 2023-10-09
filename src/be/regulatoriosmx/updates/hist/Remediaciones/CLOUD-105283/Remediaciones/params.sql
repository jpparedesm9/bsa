	use cobis
	go

	if exists (select 1 from cobis..cl_parametro  where pa_nemonico = 'DISMAX' and pa_producto = 'CLI')begin
	   delete from cobis..cl_parametro  where pa_nemonico = 'DISMAX' and pa_producto = 'CLI'  
	end 

	INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
	VALUES ('DISTANCIA MAXIMA PARA GEOLOCALIZACION (DISMAX)', 'DISMAX', 'I', NULL, NULL, NULL, 250, NULL, NULL, NULL, 'CLI')