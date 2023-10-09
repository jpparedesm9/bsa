

use
cobis
go


if exists (SELECT * FROM  cobis..cl_depart_pais WHERE dp_departamento = '1')
begin
    UPDATE cl_depart_pais 
    SET dp_departamento = '1',
	dp_estado = 'V'
    WHERE dp_departamento = '1'
end
else
begin
    INSERT INTO cl_depart_pais (dp_departamento, dp_mnemonico, dp_descripcion, dp_pais, dp_estado)
    VALUES ('1', 'DEP1', 'DEP1', 1, 'V')
end
GO