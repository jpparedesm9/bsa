--CREACION DEL CAMPO cg_ahorro_voluntario EN LA TABLA cl_cliente_grupo
ALTER TABLE cl_cliente_grupo ADD cg_ahorro_voluntario MONEY;
--CREACION DEL CAMPO cg_lugar_reunion EN LA TABLA cl_cliente_grupo
ALTER TABLE cl_cliente_grupo ADD cg_lugar_reunion CHAR(1);