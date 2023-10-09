use cobis  
go
              
IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_barrio')
			BEGIN
			   ALTER TABLE cl_oficina  ADD of_barrio int NULL 
			   print 'Se añadio la columna of_barrio'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_subregional')
			BEGIN
			   ALTER TABLE cl_oficina  ADD of_subregional char(10) NULL 
			   print 'Se añadio la columna of_subregional'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_tip_punt_at')
			BEGIN
			   ALTER TABLE cl_oficina  ADD of_tip_punt_at varchar(10) NULL 
			   print 'Se añadio la columna of_tip_punt_at'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_obs_horario')
		    BEGIN
			   ALTER TABLE cl_oficina  ADD of_obs_horario varchar(255) NULL 
			   print 'Se añadio la columna of_obs_horario'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_cir_comunic')
		    BEGIN
				ALTER TABLE cl_oficina  ADD of_cir_comunic varchar(20) NULL 
				print 'Se añadio la columna of_cir_comunic'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_nomb_encarg')
		    BEGIN
				ALTER TABLE cl_oficina  ADD of_nomb_encarg varchar(64) NULL 
				print 'Se añadio la columna of_nomb_encarg'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_ci_encarg')
		    BEGIN
				ALTER TABLE cl_oficina  ADD of_ci_encarg varchar(20) NULL 
				print 'Se añadio la columna of_ci_encarg'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_horario')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_horario tinyint NULL 
				print 'Se añadio la columna of_horario'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_tipo_horar')
		    BEGIN
				ALTER TABLE cl_oficina  ADD of_tipo_horar varchar(10) NULL 
				print 'Se añadio la columna of_tipo_horar'
		    END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_jefe_agenc')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_jefe_agenc int NULL 
				print 'Se añadio la columna of_jefe_agenc'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_cod_fie_asf')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_cod_fie_asf varchar(10) NULL 
				print 'Se añadio la columna of_cod_fie_asf'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_fec_aut_asf')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_fec_aut_asf datetime NULL 
				print 'Se añadio la columna of_fec_aut_asf'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_sector')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_sector varchar(10) NULL 
				print 'Se añadio la columna of_sector'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_lat_coord')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_lat_coord char(1) NULL 
				print 'Se añadio la columna of_lat_coord'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_lat_grad')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_lat_grad tinyint NULL 
				print 'Se añadio la columna of_lat_grad'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_lat_min')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_lat_min tinyint NULL 
				print 'Se añadio la columna of_lat_min'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_lat_seg')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_lat_seg tinyint NULL 
				print 'Se añadio la columna of_lat_seg'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_long_coord')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_long_coord char(1) NULL 
				print 'Se añadio la columna of_long_coord'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_long_grad')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_long_grad tinyint NULL 
				print 'Se añadio la columna of_long_grad'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_long_min')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_long_min tinyint NULL 
				print 'Se añadio la columna of_long_min'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_long_seg')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_long_seg tinyint NULL 
				print 'Se añadio la columna of_long_seg'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_depart_pais')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_depart_pais catalogo NULL 
				print 'Se añadio la columna of_depart_pais'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_provincia')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_provincia int NULL 
				print 'Se añadio la columna of_provincia'
			END
go

IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'cl_oficina' 
           AND  COLUMN_NAME = 'of_relac_ofic')
			BEGIN
				ALTER TABLE cl_oficina  ADD of_relac_ofic smallint NULL 
				print 'Se añadio la columna of_relac_ofic'
			END
go