USE cob_ien
GO

UPDATE cob_ien..ree_ien_agent_file_def
SET afd_allow_encription = 1, afd_encryption_type = 'CUSTOM'
WHERE afd_app IN ('PGRFR', 'COBRO', 'DSMBL', 'DSBCK')

GO
