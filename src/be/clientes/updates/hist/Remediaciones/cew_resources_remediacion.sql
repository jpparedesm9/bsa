use
cobis
go

DECLARE @w_maximo INT = 0

SELECT @w_maximo = max(re_id)+1 FROM cew_resource

if exists (SELECT * FROM  cobis..cew_resource WHERE re_pattern='/cobis/web/views/maps/.*')
begin
    UPDATE cew_resource 
    SET re_pattern = '/cobis/web/views/maps/.*'
    WHERE re_pattern = '/cobis/web/views/maps/.*'
end
else
begin
    INSERT INTO dbo.cew_resource (re_id, re_pattern)
    VALUES (@w_maximo, '/cobis/web/views/maps/.*')
    
    INSERT INTO dbo.cew_resource_rol (rro_id_resource, rro_id_rol)
	VALUES (@w_maximo, 3)
end
GO