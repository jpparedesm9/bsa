USE cobis
GO

INSERT INTO cl_producto (pd_producto, pd_tipo, pd_descripcion, pd_abreviatura, pd_fecha_apertura, pd_estado, pd_saldo_minimo, pd_costo)
VALUES (5, 'R', 'CLIENTES', 'CLI', getdate(), 'V', NULL, NULL)
GO
