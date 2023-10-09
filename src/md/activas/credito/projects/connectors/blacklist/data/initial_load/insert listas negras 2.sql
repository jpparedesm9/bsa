USE cob_credito;
GO

TRUNCATE TABLE cr_lista_negra
GO

DBCC CHECKIDENT ('cr_lista_negra', RESEED, 0);
GO

CREATE VIEW v_ListaNegra AS  
    SELECT
		ln_id_lista        ,
		ln_nombre          ,
		ln_apellido_paterno,
		ln_apellido_materno,
		ln_curp            ,
		ln_rfc             ,
		ln_fecha_nac       ,
		ln_tipo_lista      ,
		ln_estado          ,
		ln_dependencia     ,
		ln_puesto          ,
		ln_iddispo         ,
		ln_curp_ok         ,
		ln_id_rel          ,
		ln_parentesco      ,
		ln_razon_social    ,
		ln_rfc_moral       ,
		ln_num_seg_social  ,
		ln_imss            ,
		ln_ingresos        ,
		ln_nom_completo    ,
		ln_apellidos       ,
		ln_entidad         ,
		ln_sexo            ,
		ln_area            
    FROM cr_lista_negra;  
GO  

BULK INSERT v_ListaNegra
FROM 'C:\Temp\LN\BasesV09.txt'  
WITH (FORMATFILE='C:\Temp\LN\lista_negra_format.xml');  
GO  

DROP VIEW v_ListaNegra;
GO
