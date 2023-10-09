PRINT 'ree_ien_integration_server'
GO

if exists(select 1 from cob_ien..ree_ien_integration_server where ins_name IN ('TUIIO INTERNET'))
begin
print 'DELETE-ree_ien_integration_server'
delete from cob_ien..ree_ien_integration_server where ins_name IN ('TUIIO INTERNET')
END

declare
@w_ins_id     int

EXEC cobis..sp_cseqnos
    @i_tabla = 'ree_ien_integration_server',
    @o_siguiente = @w_ins_id out

INSERT INTO cob_ien..ree_ien_integration_server (ins_id, ins_name, ins_description, ins_login, ins_password, ins_server, ins_type_server, ins_port_number, ins_key_store_file, ins_key_store_password, ins_private_key, ins_private_key_pass)
VALUES (@w_ins_id, 'TUIIO INTERNET', 'TUIIO INTERNET', NULL, NULL, 'LOCAL', 'LOCAL', NULL, NULL, NULL, NULL, NULL)
GO
