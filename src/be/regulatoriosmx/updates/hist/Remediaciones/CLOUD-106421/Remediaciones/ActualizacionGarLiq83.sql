use cob_cartera 
go 

--GRUPO 48 

update ca_garantia_liquida set    gl_dev_estado = 'PD' where  gl_grupo = 83 and  gl_tramite = 5178 and  gl_pag_valor  != 0

