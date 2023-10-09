Use cob_conta
go

declare @w_empresa    int,
        @w_modulo    int
        
if exists (select 1 from cob_conta..sysobjects where name = 'cb_perfil')
begin
    select @w_modulo = 4
    select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
    
    delete from cob_conta..cb_perfil where pe_empresa = @w_empresa and pe_producto = @w_modulo
    
    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'AUM_CUPO', 'CUPO CORRESPONSALES POSICIONADOS (AHORROS)')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'BOC_AHO', 'BOC DEPOSITOS AHORROS (AHORROS)')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'CAU_AHO', 'CAUSACION DEPOSITOS AHORROS(AHORROS)')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'COB_SUS', 'COBRO CARGOS EN SUSPENSO (AHORROS)')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'COMCRBMAHO', 'COMPENSACION CREDITO RBM')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'COMPRBMAHO', 'COMPENSACION RBM')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'COND_AHO', 'CONDONACIONA VALORES EN SUSPENSO CTAS AHORROS')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'DIS_CUPO', 'CUPO CORRESPONSALES POSICIONADOS (AHORROS)')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'EST_AHO', 'CAMBIOS DE ESTADO DEPOSITOS AHORROS (AHORROS)')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'GMFBCOCAU', 'GMF A CARGO DEL BANCO CAUSAL (AHORROS)')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'GMFCARBCO', 'GMF A CARGO DEL BANCO (AHORROS)')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'ING_REM', 'REMESAS DEPOSITOS AHORROS (AHORROS)')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'NCR_AHO', 'NOTAS CREDITO DEPOSITOS AHORROS (AHORROS)')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'NDB_AHO', 'NOTAS DEBITO DEPOSITOS AHORROS (AHORROS)')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'REM_AHO', 'REMESAS DEPOSITOS AHORROS (AHORROS)')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'TRAS_AHO', 'TRASLADO ENTRE OFICINAS AHORROS (AHORROS)')

    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'VAL_SUS', 'CARGOS EN SUSPENSO (AHORROS)')
    
    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'APER_AHO', 'APERTURA CUENTAS AHORRO')
	
	INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'BLOQ_PIGNO', 'BLOQUEO PIGNORACION CTAS.')
	
    INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
    VALUES (@w_empresa, @w_modulo, 'LEVA_PIGNO', 'LEVANTAR PIGNORACION CTAS')
end
else
    print 'NO EXISTE TABLA cb_perfil'
go
