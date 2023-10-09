
--SELECT TABLA cl_grupo
SELECT * FROM cl_grupo;
--CREACION DEL CAMPO gr_tipo EN LA TABLA cl_grupo
ALTER TABLE cl_grupo ADD gr_tipo  CHAR(1);
--CREACION DEL CAMPO gr_cta_grupal EN LA TABLA cl_grupo
ALTER TABLE cl_grupo ADD gr_cta_grupal  VARCHAR(30);
--CREACION DEL CAMPO gr_sucursal EN LA TABLA cl_grupo
ALTER TABLE cl_grupo ADD gr_sucursal  INT;