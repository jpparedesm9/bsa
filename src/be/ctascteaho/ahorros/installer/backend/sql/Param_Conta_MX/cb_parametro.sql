Use cob_conta
go

declare @w_empresa    int,
        @w_modulo    int

IF exists (select 1 from cob_conta..sysobjects where name = 'cb_parametro')
begin
    select @w_modulo = 4
    select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'

    delete FROM cob_conta..cb_parametro WHERE pa_transaccion = @w_modulo

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'DEP_AHO', 'DEPOSITOS AHORROS', 'sp_ah01_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'AHO_EST', 'CAMBIO DE ESTADO-CAPITAL E INTERESES', 'sp_ah04_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'AH_RBM_TRN', 'COMPENSACION RBM', 'sp_ah02_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'AH_TRASDES', 'TRASLADO ENTRE OFICINAS-CAPITAL E INTERESES DESTINO', 'sp_ah04_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'AH_TRASOR', 'TRASLADO ENTRE OFICINAS-CAPITAL E INTERESES ORIGEN', 'sp_ah04_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'CAJA_AHO', 'DEPOSITOS EN CHEQUES OTRAS PLAZAS AHORROS RECIBIDOS POR CAJA', 'sp_ah02_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'COND_CXC', 'CXC CONDONACION VALORES EN SUSPENSO CTAS DE AHORROS', 'sp_ah02_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'COND_SUS', 'CONDONACION VALORES EN SUSPENSO CTAS DE AHORROS', 'sp_ah02_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'CON_CR_AHO', 'NOTAS CREDITOS AHORROS', 'sp_ah02_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'CON_CR_CUP', 'MOVIMIENTO CUPO CORRESPONSAL CREDITO', 'sp_ah02_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'CON_CR_SUS', 'CONTRA SUSPENSO AHORROS', 'sp_ah02_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'CON_DB_AHO', 'NOTAS DEBITOS AHORROS', 'sp_ah02_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'CON_DB_CUP', 'MOVIMIENTO CUPO CORRESPONSAL DEBITO', 'sp_ah02_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'CON_DB_SUS', 'CARGOS EN SUSPENSO AHORROS', 'sp_ah02_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'CON_GMFAHO', 'GMF A CARGO DEL BANCO EN NCR', 'sp_ah02_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'GASTO_AHO', 'GASTOS DEPOSITOS AHORROS', 'sp_ah05_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'GASTO_GMF', 'GASTO GMF A CARGO DEL BANCO EN NCR', 'sp_ah02_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'INTXP_AHO', 'PROVISION INTERESES DEPOSITOS AHORROS', 'sp_ah03_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'REM_AHO', 'DEPOSITOS EN CHEQUES OTRAS PLAZAS AHORROS RECIBIDOS POR CAJA', 'sp_ah02_pf', @w_modulo)
    
    INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'CON_APORTE', 'APORTE SOCIAL', 'sp_ah06_pf', @w_modulo)
    
    INSERT INTO dbo.cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'CON_DEU_AP', 'DEUDA POR APORTE SOCIAL', 'sp_ah06_pf', @w_modulo)

--Pignoracion
    
    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'PIGNORA', 'BLOQUEO PIGNORACION DE CUENTA', 'sp_ah06_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'CON_PIGNOR', 'PIGNORACION DE CUENTA', 'sp_ah06_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'LEVANT_BLO', 'LEVANTA BLOQUEO PIGNORACION DE CUENTA', 'sp_ah06_pf', @w_modulo)

    INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
    VALUES (@w_empresa, 'DESB_PIGNO', 'LEVANTAR PIGNORACION DE CUENTA', 'sp_ah06_pf', @w_modulo)

end
else
    print 'NO EXISTE TABLA cb_parametro'

go
