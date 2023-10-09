Use cob_conta
go

declare @w_empresa    int,
        @w_modulo    int

declare @w_cta_aso        int,
        @w_cta_asa        int,
        @w_cta_med        int,
        @w_cta_aho        int,
        @w_cta_pro        int

-- Producto Menor de Edad
select @w_cta_med = pa_int
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'PCAME'

-- Producto Final Aporte Social Ordinario
select @w_cta_aso  = pa_int
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'PCAASO'

-- Producto Final Aporte Social Adicional
select @w_cta_asa = pa_int
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'PCAASA'
    
-- Producto Ahorro Progresivo
select @w_cta_pro = pa_int
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'PAHCT'

-- Producto Ahorro NORMAL
select @w_cta_aho = pa_int
    from cobis..cl_parametro
    where pa_producto = 'AHO'
    and pa_nemonico = 'PCANOR'

if exists (select 1 from cob_conta..sysobjects where name = 'cb_relparam')
begin
    select @w_modulo = 4
    select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
    
    delete from cob_conta..cb_relparam where re_empresa = @w_empresa and re_producto = @w_modulo
    ----INICIO DEP_AHO----    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_med) + '.A', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_med) + '.C', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_med) + '.I', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_med) + '.T', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_aso) + '.G', '410101', @w_modulo, 'CTB_OF', 'D')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_aso) + '.A', '410101', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_aso) + '.C', '410101', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_aso) + '.I', '410101', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_aso) + '.T', '410101', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_asa) + '.G', '41010201', @w_modulo, 'CTB_OF', 'D')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_asa) + '.A', '41010201', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_asa) + '.C', '41010201', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_asa) + '.I', '41010201', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_asa) + '.T', '41010201', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_aho) + '.A', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_aho) + '.C', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_aho) + '.I', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_aho) + '.T', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_pro) + '.A', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_pro) + '.I', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.O.' + convert(varchar, @w_cta_pro) + '.C', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_med) + '.A', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_med) + '.C', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_med) + '.I', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_med) + '.T', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_aso) + '.G', '410101', @w_modulo, 'CTB_OF', 'D')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_aso) + '.A', '410101', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_aso) + '.C', '410101', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_aso) + '.I', '410101', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_aso) + '.T', '410101', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_asa) + '.G', '41010201', @w_modulo, 'CTB_OF', 'D')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_asa) + '.A', '41010201', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_asa) + '.C', '41010201', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_asa) + '.I', '41010201', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_asa) + '.T', '41010201', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_aho) + '.A', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_aho) + '.C', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_aho) + '.I', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_aho) + '.T', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_pro) + '.A', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_pro) + '.C', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DEP_AHO', '0.P.' + convert(varchar, @w_cta_pro) + '.I', '210101020100', @w_modulo, 'CTB_OF', 'D')
    ----FIN DEP_AHO----

    ----INICIO AHO_EST----    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_med) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_med) + '.A.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_med) + '.C.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_med) + '.I.CAP', '2161', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_med) + '.I.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_med) + '.T.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_med) + '.T.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_med) + '.X.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aso) + '.A.CAP', '241390', @w_modulo, 'CTB_OF', 'D')
    
    ----INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    ----VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aso) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'D')
    --
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aso) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'D')
    
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aso) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'D')
    
    ----INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    ----VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aso) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'D')
    
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aso) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'D')
    
    ----INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    ----VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aso) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'D')
    
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aso) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_asa) + '.A.CAP', '241390', @w_modulo, 'CTB_OF', 'D')
    
    ----INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    ----VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_asa) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'D')
    
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_asa) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'D')
    
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_asa) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'D')
    
    ----INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    ----VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_asa) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'D')
    
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_asa) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'D')
    
    ----INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    ----VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_asa) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'D')
    
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_asa) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aho) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aho) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aho) + '.C.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aho) + '.I.CAP', '2161', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aho) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aho) + '.T.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aho) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_aho) + '.X.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_pro) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_pro) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_pro) + '.C.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_pro) + '.I.CAP', '2161', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_pro) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_pro) + '.T.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_pro) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.O.' + convert(varchar, @w_cta_pro) + '.X.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_med) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_med) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_med) + '.C.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_med) + '.I.CAP', '2161', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_med) + '.I.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_med) + '.T.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_med) + '.T.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_med) + '.X.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aso) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    ----INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    ----VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aso) + '.A.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aso) + '.C.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aso) + '.I.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    ----INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    ----VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aso) + '.I.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')
    --
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aso) + '.T.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    ----INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    ----VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aso) + '.T.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aso) + '.X.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')
    --
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_asa) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    ----INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    ----VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_asa) + '.A.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_asa) + '.C.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_asa) + '.I.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')
    --
    ----INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    ----VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_asa) + '.I.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_asa) + '.T.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    ----INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    ----VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_asa) + '.T.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_asa) + '.X.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aho) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aho) + '.A.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aho) + '.C.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aho) + '.I.CAP', '2161', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aho) + '.I.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aho) + '.T.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aho) + '.T.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_aho) + '.X.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_pro) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_pro) + '.A.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_pro) + '.C.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_pro) + '.I.CAP', '2161', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_pro) + '.I.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_pro) + '.T.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    --INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    --VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_pro) + '.T.INT', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AHO_EST', '0.P.' + convert(varchar, @w_cta_pro) + '.X.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')
    ----FIN DEP_AHO----

    ----INICIO AH_RBM_TRN----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_RBM_TRN', '0.CMPANUPOSI', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_RBM_TRN', '0.CMPANUPOSN', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_RBM_TRN', '0.CMPRETATMI', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_RBM_TRN', '0.CMPRETATMN', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_RBM_TRN', '0.CMPRETPOSI', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_RBM_TRN', '0.CMPRETPOSN', '241390', @w_modulo, 'CTB_OF', 'O')
    ----FIN AH_RBM_TRN----

    ----INICIO AH_TRASDES----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aso) + '.A.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aso) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aso) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aso) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aso) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aso) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aso) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aso) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_asa) + '.A.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_asa) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_asa) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_asa) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_asa) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_asa) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_asa) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_asa) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aho) + '.A.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aho) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aho) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aho) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aho) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aho) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aho) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'D')
    
    

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_aho) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_pro) + '.A.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_pro) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_pro) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_pro) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_pro) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_pro) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_pro) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.O.' + convert(varchar, @w_cta_pro) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aso) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aso) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aso) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aso) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aso) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aso) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aso) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aso) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_asa) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_asa) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_asa) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_asa) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_asa) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_asa) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_asa) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_asa) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aho) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aho) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aho) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aho) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aho) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aho) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aho) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_aho) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_pro) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_pro) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_pro) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_pro) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_pro) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_pro) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_pro) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASDES', '0.P.' + convert(varchar, @w_cta_pro) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'D')
    ----FIN AH_TRASDES----

    ----INICIO AH_TRASOR----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aso) + '.A.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aso) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aso) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aso) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aso) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aso) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aso) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aso) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_asa) + '.A.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_asa) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_asa) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_asa) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_asa) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_asa) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_asa) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_asa) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aho) + '.A.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aho) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aho) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aho) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aho) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aho) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aho) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_aho) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_pro) + '.A.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_pro) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_pro) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_pro) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_pro) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_pro) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_pro) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.O.' + convert(varchar, @w_cta_pro) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aso) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aso) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aso) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aso) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aso) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aso) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aso) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aso) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_asa) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_asa) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_asa) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_asa) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_asa) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_asa) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_asa) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_asa) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aho) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aho) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aho) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aho) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aho) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aho) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aho) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_aho) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_pro) + '.A.CAP', '210101020100', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_pro) + '.A.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_pro) + '.C.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_pro) + '.I.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_pro) + '.I.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_pro) + '.T.CAP', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_pro) + '.T.INT', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'AH_TRASOR', '0.P.' + convert(varchar, @w_cta_pro) + '.X.CAP', '241390', @w_modulo, 'CTB_OF', 'O')
    ----FIN AH_TRASOR----

    ----INICIO CAJA_AHO----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CAJA_AHO', '0.CH_OTR', '110202', @w_modulo, 'CTB_OF', 'O')
    ----FIN CAJA_AHO----

    ----INICIO COND_CXC----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_CXC', '0.CNDCOMATMI', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_CXC', '0.CNDCOMATMN', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_CXC', '0.CNDCSAATMI', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_CXC', '0.CNDCSAATMN', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_CXC', '0.CNDCUOMAN', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_CXC', '0.CNDFINSU', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_CXC', '0.CNDPDTARJ', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_CXC', '0.CNDPININV', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_CXC', '0.CNDROTARJ', '13010506', @w_modulo, 'CTB_OF', 'D')
    ----FIN COND_CXC----

    ----INICIO COND_SUS----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_SUS', '0.CNDCOMATMI', '532101050600', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_SUS', '0.CNDCOMATMN', '532101050600', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_SUS', '0.CNDCSAATMI', '532101050600', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_SUS', '0.CNDCSAATMN', '532101050600', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_SUS', '0.CNDCUOMAN', '532101050600', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_SUS', '0.CNDFINSU', '532101050600', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_SUS', '0.CNDPDTARJ', '532101050600', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_SUS', '0.CNDPININV', '532101050600', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'COND_SUS', '0.CNDROTARJ', '532101050600', @w_modulo, 'CTB_OF', 'D')
    ----FIN COND_SUS----

    ----INICIO CON_CR_AHO----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.CCCUPOCB', '6491', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.CH_LOC', '110202', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.CH_PRO', '110202', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.CONCHREM', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.DEVCOMREM', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.DEVGMF', '6491', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.DEVRTEFTE', '240108', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.EFECTIVO', '1101', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.INT', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.INTA', '6101', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.INTI', '6101', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCABNOEM', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCABONOPAG', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCABPAVI', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCAJ50RBM', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCAJ56RBM', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCAJTRNATM', '6491', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCAJTRNPOS', '6491', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCDEVCMTD', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCDTN', '6491', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCPAGOINCE', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRACMMOV', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRCCCBP', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRCCMMOV', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRCOMCB', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRCORDEP', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRCTAEMP', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRDEPCB', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRDESPRE', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRDPF', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCREINPAGC', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRENTMMI', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRGMFCBCO', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRINTREC', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRMANOPE', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRPAGMOV', '6491', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRPAGPROV', '6491', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRRCMMOV', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRREACTA', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRRECMOV', '6491', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRREFERI', '6491', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRRETPOS', '6491', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRRETPOSI', '6491', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRRVAPDPF', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRTRANS', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRTRSMOV', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCRWU', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NCTRDCTOB', '6491', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.NDAJ57RBM', '6491', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_AHO', '0.REVCOMCHG', '6491', @w_modulo, 'CTB_OF', 'O')
        
    --Notas de creditos con causales
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.AUTRETINE', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.CAP', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.CH_OTR', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.CMPANUPOSN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CMPRETATMI', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CMPRETATMN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CMPRETPOSI', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.CMPRETPOSN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CNDCOMATMI', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CNDCOMATMN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CNDCSAATMI', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.CNDCSAATMN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CNDCUOMAN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CNDFINSU', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CNDPDTARJ', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CNDPININV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CNDROTARJ', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CORAUCCB', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CORDICCB', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CORRGCCB', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCAUMCB', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCCMRMOV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCCMUMOV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCCOMATMI', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCCOMATMN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCCSAATMI', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCCSAATMN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCCUOMAN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCDICCB', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCEXCMONT', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCEXCNUMU', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCFINSU', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCPDTARJ', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCPININV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.CXCROTARJ', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.GMFCARBCO', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCAJCOMATM', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCAJUSERRT', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCAJUSTGMF', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRACH', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRAUCCB', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRCAMREM', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRCONV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRDEPPCO', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRDEPRH', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRDEPTRA', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRDESEMB', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRDPTCON', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRDPTTES', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRINTMAN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRREICHG', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRRGCCB', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRTRNSLD', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDAJ51RBM', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDAJTRNATM', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDAJTRNPOS', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDCOMDISP', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEACMMOV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEAJUCHL', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEAJUCHP', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEAJUCHR', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEAJUEFE', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEAUMDPF', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEAUTFLI', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECANCIN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECCCBP', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECCMMOV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECCSMOV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECGAREM', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECHQGER', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECHQREM', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECIECHG', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECIECON', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECIECTA', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECIEEFE', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECMOMOV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECMRMOV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECMUMOV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECOMATMI', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECOMATMN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECOMCB', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest) 
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECOMCHD', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECOMCHGE', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECOMCIE', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECOMECT', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECOMGER', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECOMOFI', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECOMPOSI', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECOMPOSN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECOMREM', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECOMRETV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECOMTRF', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECONDPF', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECORDEP', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECSAATMI', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECSAATMN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDECUOMAN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEDEVCHEX', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEDEVEFE', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEDEVLOC', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEDICCB', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEDIFDEP', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEDPTCON', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEDPTTES', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEEMBARG', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEESTCTA', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEFINSU', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEGMF', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEIVA', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEMANOPE', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEPAGCAR', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEPAGMOV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEPCARMAS', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEPDTARJ', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEPININV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEPORREM', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEPORTDEV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEPROVEED', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDERCMMOV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDERECINT', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDERECMOV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEREFBAN', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEREIDES', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEREIDESC', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEREM', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDERETATMI', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDERETATMN', '6491', @w_modulo, 'CTB_OF', 'O')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDERETCB', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDERETCHGE', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDERETPOS', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDERETPOSI', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEREVCPF', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDEROTARJ', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDERTEFTE', '240108', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDERTEICA', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDESUSDOC', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDETRAEXT', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDETRANS', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDETRASLD', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDETRNNAL', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDETRSMOV', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDRVCANDPF', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NDTRACTOB', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.RET', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.REVCOMEX', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.REVMEMACH', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.REVPOS', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.REVTRACH', '6491', @w_modulo, 'CTB_OF', 'O')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_CR_AHO', '0.NCRINTMANT', '6491', @w_modulo, 'CTB_OF', 'O')
    ----FIN CON_CR_AHO----

    ----INICIO CON_CR_CUP----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_CUP', '0.CORAUCCB', '6491', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_CUP', '0.CORDICCB', '6491', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_CUP', '0.CORRGCCB', '6491', @w_modulo, 'CTB_OF', 'D')
    ----FIN CON_CR_CUP----

    ----INICIO CON_CR_SUS----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_SUS', '0.CXCAUMCB', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_SUS', '0.CXCCMRMOV', '241390', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_SUS', '0.CXCCMUMOV', '41010290', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_SUS', '0.CXCCOMATMI', '41010290', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_SUS', '0.CXCCOMATMN', '41010290', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_SUS', '0.CXCCSAATMI', '41010290', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_SUS', '0.CXCCSAATMN', '41010290', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_SUS', '0.CXCCUOMAN', '41010290', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_SUS', '0.CXCDICCB', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_SUS', '0.CXCFINSU', '41010290', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_SUS', '0.CXCPDTARJ', '41010290', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_SUS', '0.CXCPININV', '41010290', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_CR_SUS', '0.CXCROTARJ', '41010290', @w_modulo, 'CTB_OF', 'D')
    ----FIN CON_CR_SUS----

    ----INICIO CON_DB_AHO----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.AUTRETINE', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.CCCUPOCB', '5390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.CXCEXCMONT', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.CXCEXCNUMU', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.EFECTIVO', '1101', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDAJ51RBM', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDCOMDISP', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEACMMOV', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEAJUCHL', '110202', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEAUMDPF', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEAUTFLI', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECANCIN', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECCCBP', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECCMMOV', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECCSMOV', '5390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECHQGER', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECHQREM', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECIECHG', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECIECON', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECIECTA', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECIEEFE', '1101', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECMOMOV', '5390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECMRMOV', '5390', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECMUMOV', '5390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECOMATMI', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECOMATMN', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECOMCB', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECOMCHD', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECOMCHGE', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECOMECT', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECOMOFI', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECOMREM', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECOMRETV', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECOMTRF', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECONCTA', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECONDPF', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECORDEP', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECSAATMI', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECSAATMN', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDECUOMAN', '5390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEDEVEFE', '1101', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEDEVLOC', '110202', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEEMBARG', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEESTCTA', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEFINSU', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEGMF', '5390', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEIVA', '5390', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEMANOPE', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEPAGCAR', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEPAGMOV', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEPCARMAS', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEPDTARJ', '5390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEPININV', '5390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEPORREM', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEPORTDEV', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEPROVEED', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDERCMMOV', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDERECINT', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDERECMOV', '5390', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEREFBAN', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEREIDESC', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEREM', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDERETATMI', '5390', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDERETATMN', '5390', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDERETCB', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDERETCHGE', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDERETPOS', '5390', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDERETPOSI', '5390', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDEROTARJ', '5390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDERTEFTE', '240108', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDERTEICA', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDETRANS', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDETRASLD', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDETRNNAL', '5390', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDETRSMOV', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDRVCANDPF', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDTRACTOB', '5390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.RET', '1101', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_AHO', '0.NDAJ57RBM', '5390', @w_modulo, 'CTB_OF', 'D')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa,'CON_DB_AHO', '0.NDECOMCIE', '5390', @w_modulo, 'CTB_OF', 'O')
    ----FIN CON_DB_AHO----

    ----INICIO CON_DB_CUP----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_CUP', '0.CORAUCCB', '6491', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_CUP', '0.CORDICCB', '6491', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_CUP', '0.CORRGCCB', '6491', @w_modulo, 'CTB_OF', 'D')
    ----FIN CON_DB_CUP----

    ----INICIO CON_DB_SUS----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_SUS', '0.CXCAUMCB', '13010506', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_SUS', '0.CXCCMRMOV', '13010506', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_SUS', '0.CXCCMUMOV', '13010506', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_SUS', '0.CXCCOMATMI', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_SUS', '0.CXCCOMATMN', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_SUS', '0.CXCCSAATMI', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_SUS', '0.CXCCSAATMN', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_SUS', '0.CXCCUOMAN', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_SUS', '0.CXCDICCB', '13010506', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_SUS', '0.CXCFINSU', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_SUS', '0.CXCPDTARJ', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_SUS', '0.CXCPININV', '13010506', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DB_SUS', '0.CXCROTARJ', '13010506', @w_modulo, 'CTB_OF', 'D')
    ----FIN CON_DB_SUS----

    ----INICIO CON_GMFAHO----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_GMFAHO', '0.NCABNOEM', '241390', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_GMFAHO', '0.NCABONOPAG', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_GMFAHO', '0.NCABPAVI', '241390', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_GMFAHO', '0.NCDTN', '241390', @w_modulo, 'CTB_OF', 'C')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_GMFAHO', '0.NCPAGOINCE', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_GMFAHO', '0.NCRPAGPROV', '241390', @w_modulo, 'CTB_OF', 'C')
    ----FIN CON_GMFAHO----

    ----INICIO GASTO_AHO----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'GASTO_AHO', '0.O.A', '532101050600', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'GASTO_AHO', '0.O.C', '532101050600', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'GASTO_AHO', '0.O.I', '532101050600', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'GASTO_AHO', '0.O.T', '532101050600', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'GASTO_AHO', '0.P.A', '532101050600', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'GASTO_AHO', '0.P.C', '532101050600', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'GASTO_AHO', '0.P.I', '532101050600', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'GASTO_AHO', '0.P.T', '532101050600', @w_modulo, 'CTB_OF', 'O')
    ----FIN GASTO_AHO----

    ----INICIO GASTO_GMF----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'GASTO_GMF', '0.NCABNOEM', '532101050600', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'GASTO_GMF', '0.NCABONOPAG', '532101050600', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'GASTO_GMF', '0.NCABPAVI', '532101050600', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'GASTO_GMF', '0.NCDTN', '13010506', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'GASTO_GMF', '0.NCPAGOINCE', '532101050600', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'GASTO_GMF', '0.NCRPAGPROV', '532101050600', @w_modulo, 'CTB_OF', 'D')
    ----FIN GASTO_GMF----

    ----INICIO INTXP_AHO----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'INTXP_AHO', '0.A', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'INTXP_AHO', '0.C', '241390', @w_modulo, 'CTB_OF', 'O')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'INTXP_AHO', '0.I', '241390', @w_modulo, 'CTB_OF', 'D')

    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'INTXP_AHO', '0.T', '241390', @w_modulo, 'CTB_OF', 'O')
    ----FIN INTXP_AHO----

    ----INICIO REM_AHO----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'REM_AHO', '0.CH_OTR', '13010506', @w_modulo, 'CTB_OF', 'O')
    ----FIN REM_AHO----
    
    ----INICIO CON_APORTE----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_APORTE', '0.' + convert(varchar, @w_cta_aso) + '.G', '410201', @w_modulo, 'CTB_OF', 'D')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_APORTE', '0.' + convert(varchar, @w_cta_aso) + '.A', '410201', @w_modulo, 'CTB_OF', 'D')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_APORTE', '0.' + convert(varchar, @w_cta_aso) + '.C', '410201', @w_modulo, 'CTB_OF', 'D')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_APORTE', '0.' + convert(varchar, @w_cta_asa) +'.G', '410202', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_APORTE', '0.' + convert(varchar, @w_cta_asa) +'.A', '410202', @w_modulo, 'CTB_OF', 'D')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_APORTE', '0.' + convert(varchar, @w_cta_asa) +'.C', '410202', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_APORTE', '0.' + convert(varchar, @w_cta_asa) +'.I', '410202', @w_modulo, 'CTB_OF', 'D')
    ----FIN CON_APORTE----

    ----INICIO CON_DEU_AP----
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DEU_AP', '0.' + convert(varchar, @w_cta_aso) +'.G', '110301', @w_modulo, 'CTB_OF', 'D')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DEU_AP', '0.' + convert(varchar, @w_cta_aso) +'.A', '110301', @w_modulo, 'CTB_OF', 'D')
    
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DEU_AP', '0.' + convert(varchar, @w_cta_aso) +'.C', '110301', @w_modulo, 'CTB_OF', 'D')
   
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DEU_AP', '0.' + convert(varchar, @w_cta_asa) +'.G', '110301', @w_modulo, 'CTB_OF', 'D')
   
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DEU_AP', '0.' + convert(varchar, @w_cta_asa) +'.A', '110301', @w_modulo, 'CTB_OF', 'D')
   
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DEU_AP', '0.' + convert(varchar, @w_cta_asa) +'.C', '110301', @w_modulo, 'CTB_OF', 'D')
       
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_DEU_AP', '0.' + convert(varchar, @w_cta_asa) +'.I','110301', @w_modulo, 'CTB_OF', 'D')
    ----FIN CON_APORTE----

    --INICIO PIGNORACION 217
    --Producto Ahorro NORMAL
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'PIGNORA', '0.' + convert(varchar, @w_cta_aho) +'.A', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'PIGNORA', '0.' + convert(varchar, @w_cta_aho) +'.C', '210101020100', @w_modulo, 'CTB_OF', 'D')
       
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'PIGNORA', '0.' + convert(varchar, @w_cta_aho) +'.I', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'PIGNORA', '0.' + convert(varchar, @w_cta_aho) +'.T', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    --Producto Ahorro NORMAL
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_PIGNOR', '0.' + convert(varchar, @w_cta_aho) +'.A', '210101020200', @w_modulo, 'CTB_OF', 'O')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_PIGNOR', '0.' + convert(varchar, @w_cta_aho) +'.C', '210101020200', @w_modulo, 'CTB_OF', 'O')
       
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_PIGNOR', '0.' + convert(varchar, @w_cta_aho) +'.I', '210101020200', @w_modulo, 'CTB_OF', 'O')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_PIGNOR', '0.' + convert(varchar, @w_cta_aho) +'.T', '210101020200', @w_modulo, 'CTB_OF', 'O')
     
    --Producto Ahorro PROGRESIVO
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'PIGNORA','0.' + convert(varchar, @w_cta_pro) +'.A', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'PIGNORA', '0.' + convert(varchar, @w_cta_pro) +'.C', '210101020100', @w_modulo, 'CTB_OF', 'D')
     
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'PIGNORA', '0.' + convert(varchar, @w_cta_pro) +'.I', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'PIGNORA', '0.' + convert(varchar, @w_cta_pro) +'.T', '210101020100', @w_modulo, 'CTB_OF', 'D')

    --Producto Ahorro PROGRESIVO
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_PIGNOR','0.' + convert(varchar, @w_cta_pro) +'.A', '210101020200', @w_modulo, 'CTB_OF', 'O')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_PIGNOR', '0.' + convert(varchar, @w_cta_pro) +'.C', '210101020200', @w_modulo, 'CTB_OF', 'O')
     
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_PIGNOR', '0.' + convert(varchar, @w_cta_pro) +'.I', '210101020200', @w_modulo, 'CTB_OF', 'O')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_PIGNOR', '0.' + convert(varchar, @w_cta_pro) +'.T', '210101020200', @w_modulo, 'CTB_OF', 'O')
    
    --Producto Ahorro MENOR EDAD
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'PIGNORA', '0.' + convert(varchar, @w_cta_med) +'.A', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'PIGNORA', '0.' + convert(varchar, @w_cta_med) +'.C', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'PIGNORA', '0.' + convert(varchar, @w_cta_med) +'.I', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'PIGNORA', '0.' + convert(varchar, @w_cta_med) +'.T', '210101020100', @w_modulo, 'CTB_OF', 'D')

    --Producto Ahorro MENOR EDAD
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_PIGNOR', '0.' + convert(varchar, @w_cta_med) +'.A', '210101020200', @w_modulo, 'CTB_OF', 'O')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_PIGNOR', '0.' + convert(varchar, @w_cta_med) +'.C', '210101020200', @w_modulo, 'CTB_OF', 'O')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_PIGNOR', '0.' + convert(varchar, @w_cta_med) +'.I', '210101020200', @w_modulo, 'CTB_OF', 'O')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'CON_PIGNOR', '0.' + convert(varchar, @w_cta_med) +'.T', '210101020200', @w_modulo, 'CTB_OF', 'O')
          
    --Levantamiento PIGNORACION 218
     --Producto Ahorro NORMAL
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DESB_PIGNO', '0.' + convert(varchar, @w_cta_aho) +'.A', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DESB_PIGNO', '0.' + convert(varchar, @w_cta_aho) +'.C', '210101020100', @w_modulo, 'CTB_OF', 'D')
       
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DESB_PIGNO', '0.' + convert(varchar, @w_cta_aho) +'.I', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DESB_PIGNO', '0.' + convert(varchar, @w_cta_aho) +'.T', '210101020100', @w_modulo, 'CTB_OF', 'D')
	
	--Producto Ahorro NORMAL
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'LEVANT_BLO', '0.' + convert(varchar, @w_cta_aho) +'.A', '210101020200', @w_modulo, 'CTB_OF', 'O')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'LEVANT_BLO', '0.' + convert(varchar, @w_cta_aho) +'.C', '210101020200', @w_modulo, 'CTB_OF', 'O')
       
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'LEVANT_BLO', '0.' + convert(varchar, @w_cta_aho) +'.I', '210101020200', @w_modulo, 'CTB_OF', 'O')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'LEVANT_BLO', '0.' + convert(varchar, @w_cta_aho) +'.T', '210101020200', @w_modulo, 'CTB_OF', 'O')
     
	--Producto Ahorro PROGRESIVO 
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DESB_PIGNO','0.' + convert(varchar, @w_cta_pro) +'.A', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DESB_PIGNO', '0.' + convert(varchar, @w_cta_pro) +'.C', '210101020100', @w_modulo, 'CTB_OF', 'D')
                
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DESB_PIGNO', '0.' + convert(varchar, @w_cta_pro) +'.I', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DESB_PIGNO', '0.' + convert(varchar, @w_cta_pro) +'.T', '210101020100', @w_modulo, 'CTB_OF', 'D')    
	
    --Producto Ahorro PROGRESIVO 
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'LEVANT_BLO','0.' + convert(varchar, @w_cta_pro) +'.A', '210101020200', @w_modulo, 'CTB_OF', 'O')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'LEVANT_BLO', '0.' + convert(varchar, @w_cta_pro) +'.C', '210101020200', @w_modulo, 'CTB_OF', 'O')
                
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'LEVANT_BLO', '0.' + convert(varchar, @w_cta_pro) +'.I', '210101020200', @w_modulo, 'CTB_OF', 'O')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'LEVANT_BLO', '0.' + convert(varchar, @w_cta_pro) +'.T', '210101020200', @w_modulo, 'CTB_OF', 'O') 
    
        --Producto Ahorro MENOR EDAD
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DESB_PIGNO', '0.' + convert(varchar, @w_cta_med) +'.A', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DESB_PIGNO', '0.' + convert(varchar, @w_cta_med) +'.C', '210101020100', @w_modulo, 'CTB_OF', 'D')
       
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DESB_PIGNO', '0.' + convert(varchar, @w_cta_med) +'.I', '210101020100', @w_modulo, 'CTB_OF', 'D')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'DESB_PIGNO', '0.' + convert(varchar, @w_cta_med) +'.T', '210101020100', @w_modulo, 'CTB_OF', 'D')
    
    --Producto Ahorro MENOR EDAD
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'LEVANT_BLO', '0.' + convert(varchar, @w_cta_med) +'.A', '210101020200', @w_modulo, 'CTB_OF', 'O')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'LEVANT_BLO', '0.' + convert(varchar, @w_cta_med) +'.C', '210101020200', @w_modulo, 'CTB_OF', 'O')
       
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'LEVANT_BLO', '0.' + convert(varchar, @w_cta_med) +'.I', '210101020200', @w_modulo, 'CTB_OF', 'O')
        
    INSERT INTO cob_conta..cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
    VALUES (@w_empresa, 'LEVANT_BLO', '0.' + convert(varchar, @w_cta_med) +'.T', '210101020200', @w_modulo, 'CTB_OF', 'O')
   
end
else
    print 'NO EXISTE TABLA cb_relparam'
go
