DECLARE @w_ente INT

SELECT @w_ente = 8257

DELETE FROM cobis..cl_ente
WHERE en_ente = @w_ente

DELETE FROM cobis..cl_ente_aux
WHERE ea_ente = @w_ente

DELETE FROM cobis..cl_direccion
WHERE di_ente = @w_ente

DELETE FROM cobis..cl_telefono
WHERE te_ente = @w_ente

DELETE FROM cobis..cl_instancia
WHERE in_ente_d = @w_ente
DELETE FROM cobis..cl_instancia
WHERE in_ente_i = @w_ente

DELETE FROM cobis..cl_negocio_cliente
WHERE nc_ente = @w_ente

DELETE FROM cobis..cl_actividad_economica
WHERE ae_ente = @w_ente

DELETE FROM cobis..cl_ref_personal
WHERE rp_persona = @w_ente

DELETE FROM cobis..cl_cliente_grupo
WHERE cg_ente = @w_ente

DELETE FROM cob_credito..cr_documento_digitalizado
WHERE dd_cliente = @w_ente

DELETE from cob_credito..cr_buro_cuenta 
WHERE bc_id_cliente = @w_ente

DELETE from cob_credito..cr_buro_resumen_reporte 
WHERE br_id_cliente = @w_ente

DELETE from cob_credito..cr_interface_buro 
WHERE ib_cliente = @w_ente



