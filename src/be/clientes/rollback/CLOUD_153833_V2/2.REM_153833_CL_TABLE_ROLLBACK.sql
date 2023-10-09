use cobis
go
-- ========= REQ 153833 - Cambios Json biometricos =========
-- \\bsa_153833_V2\src\be\clientes\installer\sql\cl_table.sql
IF OBJECT_ID ('cl_log_error_biometricos') IS NOT NULL
    DROP TABLE cl_log_error_biometricos
go
