
-- PARAMETRO SENSIBILIDAD PARA LIMITES EN DISTRIBUCION DE PAGOS 
update cobis..cl_parametro  
set    pa_float = 150.0
where  pa_nemonico = 'SENSI'
and    pa_producto = 'CCA'