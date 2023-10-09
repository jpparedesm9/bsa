Use cob_conta
go

declare @w_empresa    int,
        @w_modulo    int

if exists (select 1 from cob_conta..sysobjects where name = 'cb_det_perfil')
begin
    select @w_modulo = 4
    select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
    
    delete from cob_conta..cb_det_perfil where dp_empresa = @w_empresa and dp_producto = @w_modulo
    
    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'AUM_CUPO', 1, 'CON_DB_CUP', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'AUM_CUPO', 2, 'CON_CR_CUP', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'BOC_AHO', 1, 'DEP_AHO', 'CTB_OF', '2', 10, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'BOC_AHO', 2, 'INTXP_AHO', 'CTB_OF', '2', 20, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'CAU_AHO', 1, 'INTXP_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'CAU_AHO', 3, 'GASTO_AHO', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'COB_SUS', 1, 'CON_CR_SUS', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'COB_SUS', 2, 'CON_DB_SUS', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'COMCRBMAHO', 1, '25959500115', 'CTB_OF', '1', 1, 'N', 'C', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'COMCRBMAHO', 2, 'AH_RBM_TRN', 'CTB_OF', '2', 1, 'N', 'O', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'COMPRBMAHO', 1, '25959500115', 'CTB_OF', '2', 1, 'N', 'C', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'COMPRBMAHO', 2, 'AH_RBM_TRN', 'CTB_OF', '1', 1, 'N', 'O', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'COND_AHO', 1, 'COND_SUS', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'COND_AHO', 2, 'COND_CXC', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'DIS_CUPO', 1, 'CON_DB_CUP', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'DIS_CUPO', 2, 'CON_CR_CUP', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'EST_AHO', 1, 'AHO_EST', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'GMFBCOCAU', 1, 'GASTO_GMF', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'GMFBCOCAU', 2, 'CON_GMFAHO', 'CTB_IMP', '2', 1, 'N', 'C', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'GMFCARBCO', 1, '51403500020', 'CTB_OF', '1', 1, 'N', 'O', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'GMFCARBCO', 2, '25301500005', 'CTB_OF', '2', 1, 'N', 'C', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'ING_REM', 3, 'CAJA_AHO', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'ING_REM', 4, 'REM_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'NCR_AHO', 1, 'CON_CR_AHO', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'NCR_AHO', 2, 'DEP_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')
    
    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'NCR_AHO', 3, 'CON_APORTE', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')
    
    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'NCR_AHO', 4, 'CON_DEU_AP', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'NDB_AHO', 1, 'CON_DB_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'NDB_AHO', 2, 'DEP_AHO', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')	
	
    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'NDB_AHO', 3, 'CON_APORTE', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'NDB_AHO', 4, 'CON_DEU_AP', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'REM_AHO', 1, 'CAJA_AHO', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'TRAS_AHO', 1, 'AH_TRASDES', 'CTB_OF', '2', 1, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'TRAS_AHO', 2, 'AH_TRASOR', 'CTB_OF', '1', 1, 'N', 'O', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'VAL_SUS', 1, 'CON_CR_SUS', 'CTB_OF', '2', 1, 'N', 'D', NULL, 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'VAL_SUS', 2, 'CON_DB_SUS', 'CTB_OF', '1', 1, 'N', 'D', NULL, 'L')
    
    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'APER_AHO', 1, 'CON_DEU_AP', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')
    
    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'APER_AHO', 2, 'CON_APORTE', 'CTB_OF', '2', 2, 'N', 'C', '', 'L')
    
	  --PIGNORACION
    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'BLOQ_PIGNO', 1, 'PIGNORA', 'CTB_OF', '1', 1, 'N', 'D', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'BLOQ_PIGNO', 2, 'CON_PIGNOR', 'CTB_OF', '2', 2, 'N', 'C', '', 'L')

    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'LEVA_PIGNO', 1, 'LEVANT_BLO', 'CTB_OF', '2', 1, 'N', 'C', '', 'L')
    
    INSERT INTO cob_conta..cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
    VALUES (@w_empresa, @w_modulo, 'LEVA_PIGNO', 2, 'DESB_PIGNO', 'CTB_OF', '1', 2, 'N', 'D', '', 'L')    
end

else
    print 'NO EXISTE TABLA cb_det_perfil'

go
