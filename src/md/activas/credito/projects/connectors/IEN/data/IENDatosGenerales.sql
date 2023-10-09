use cob_ien
go

SET NOCOUNT ON
GO

---------------------------------------------------------------------------------
print '---------ELIMINACION OBJETOS COMUNES ---------------'
---------------------------------------------------------------------------------

if exists(select 1 from cob_ien..ree_ien_entities_groups where en_name = 'SANTANDER')
begin
print 'DELETE-ree_ien_entities_groups'
delete from cob_ien..ree_ien_entities_groups where en_name = 'SANTANDER'
end

if exists(select 1 from cob_ien..ree_ien_conf_group where co_name = 'SANTANDER')
begin
print 'DELETE-ree_ien_conf_group'
delete from cob_ien..ree_ien_conf_group where co_name = 'SANTANDER'
END

if exists(select 1 from cob_ien..ree_ien_integration_server where ins_name IN ('SANTANDER H2H', 'TUIIO INTERNET'))
begin
print 'DELETE-ree_ien_integration_server'
delete from cob_ien..ree_ien_integration_server where ins_name IN ('SANTANDER H2H', 'TUIIO INTERNET')
END



declare
@w_ins_id     int,
@w_co_id      int,
@w_anc_id     int


---------------------------------------------------------------------------------
print '------------------ACTUALIZACION SEQNOS-----------------------------'
---------------------------------------------------------------------------------
----------------------------------
Print 'ree_ien_integration_server'
----------------------------------

select @w_ins_id = max(ins_id)
from cob_ien..ree_ien_integration_server

select @w_ins_id = isnull (@w_ins_id,0)

update cobis..cl_seqnos
set siguiente = @w_ins_id
where tabla = 'ree_ien_integration_server'

if @@rowcount = 0
  Print 'Error al actualizar cl_seqnos para tabla ree_ien_integration_server'


--------------------------
Print 'ree_ien_conf_group'
--------------------------

select @w_co_id = max(co_id)
from cob_ien..ree_ien_conf_group

select @w_co_id = isnull (@w_co_id,0)

update cobis..cl_seqnos
set siguiente = @w_co_id
where tabla = 'ree_ien_conf_group'

if @@rowcount = 0
  Print 'Error al actualizar cl_seqnos para tabla ree_ien_conf_group'


--------------------------
PRINT 'ree_ien_agent_notif_config'
--------------------------

SELECT @w_anc_id = ISNULL (MAX (anc_id), 0)
FROM ree_ien_agent_notif_config

UPDATE cobis..cl_seqnos
SET siguiente = @w_anc_id
WHERE tabla = 'ree_ien_agent_notif_config'

IF @@ROWCOUNT = 0
    PRINT 'Error al actualizar cl_seqnos para tabla ree_ien_agent_notif_config'

GO



---------------------------------------------------------------------------------
print '------------------CREACIÓN DE REGISTROS-----------------------'
---------------------------------------------------------------------------------

declare
@w_ins_id     int,
@w_co_id      int,
@w_ente       int,
@w_anc_id     int

---------------------------------------------------------------------------------
print '------------------CREACION DE CLIENTE-----------------------'
---------------------------------------------------------------------------------

if exists (Select 1 from cobis..cl_ente where en_nombre = 'SANTANDER')
 begin
    select @w_ente = en_ente from cobis..cl_ente where en_nombre = 'SANTANDER'
 end
 else
 begin
    declare @w_secuencial int

    exec cobis..sp_cseqnos
    @i_tabla = 'cl_ente',
    @o_siguiente = @w_ente out

    insert into cobis.dbo.cl_ente (en_ente,en_nombre,en_subtipo,en_filial,en_oficina,en_fecha_mod,en_retencion,en_mala_referencia,en_tipo_ced)
    values (@w_ente,'SANTANDER','C',1,1,getdate(),'S','N','CI')
 end


-------------------------------
print 'ree_ien_integration_server'
-------------------------------
--PREREQUISITO
--

if exists (select 1 from cob_ien..ree_ien_integration_server where ins_name = 'SANTANDER H2H')
begin
  print 'YA EXISTE SERVIDOR DE FTP >>SANTANDER H2H<<'
end
else
begin
    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_integration_server',
        @o_siguiente = @w_ins_id out

    INSERT INTO ree_ien_integration_server (ins_id, ins_name, ins_description, ins_login, ins_password, ins_server, ins_type_server, ins_port_number, ins_key_store_file, ins_key_store_password, ins_private_key, ins_private_key_pass)
    VALUES (@w_ins_id, 'SANTANDER H2H', 'SANTANDER H2H', '089000001952', 'exFerKNNILhWwP/GWZ8Dfg==', '192.240.110.98', 'SFTP_ACT', 22, NULL, NULL, '201711245santander-tuiio', NULL)
end

if exists (select 1 from cob_ien..ree_ien_integration_server where ins_name = 'TUIIO INTERNET')
begin
  print 'YA EXISTE SERVIDOR DE FTP >>TUIIO INTERNET<<'
end
else
begin
    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_integration_server',
        @o_siguiente = @w_ins_id out

    INSERT INTO ree_ien_integration_server (ins_id, ins_name, ins_description, ins_login, ins_password, ins_server, ins_type_server, ins_port_number, ins_key_store_file, ins_key_store_password, ins_private_key, ins_private_key_pass)
    VALUES (@w_ins_id, 'TUIIO INTERNET', 'TUIIO INTERNET', NULL, NULL, 'LOCAL', 'LOCAL', NULL, NULL, NULL, NULL, NULL)
end


--------------------------------
print 'ree_ien_conf_group'
--------------------------------
--PREREQUISITO
--

if exists (select 1 from cob_ien..ree_ien_conf_group
               where co_name = 'SANTANDER')
begin
  print 'YA EXISTE GRUPO >>SANTANDER<<'
end
else
begin
    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_conf_group',
        @o_siguiente = @w_co_id out

    INSERT INTO ree_ien_conf_group (co_id, co_is_group, co_name, co_value_entity)
    VALUES (@w_co_id, 0, 'SANTANDER', @w_ente)
end

--------------------------------
print 'ree_ien_entities_groups'
--------------------------------

if exists (select 1 from cob_ien..ree_ien_entities_groups
               where en_name = 'SANTANDER')
begin
  print 'YA EXISTE GRUPO >>SANTANDER<<'
end
else
begin
    select @w_co_id = (select co_id from ree_ien_conf_group where co_name = 'SANTANDER')

    INSERT INTO ree_ien_entities_groups (en_code, en_name, group_id, server)
    VALUES (@w_ente, 'SANTANDER', @w_co_id, NULL)

end


--------------------------------
PRINT 'ree_ien_agent_notif_config'
--------------------------------

IF EXISTS (
            SELECT 1
            FROM ree_ien_agent_notif_config
            WHERE ag_code = @w_ente
          )
BEGIN
    DELETE ree_ien_agent_notif_config
    WHERE ag_code = @w_ente
END

EXEC cobis..sp_cseqnos
    @i_tabla = 'ree_ien_agent_notif_config',
    @o_siguiente = @w_anc_id out

INSERT INTO ree_ien_agent_notif_config
    (anc_id, ag_code, anc_retry_number, anc_email_address, anc_sms_address, anc_send_email, anc_send_sms, anc_priority)
VALUES
    (@w_anc_id, @w_ente, 2, 'ejprado@santander.com.mx;erumoroso@santander.com.mx', NULL, 1, 0, 1)


SET NOCOUNT OFF
GO
