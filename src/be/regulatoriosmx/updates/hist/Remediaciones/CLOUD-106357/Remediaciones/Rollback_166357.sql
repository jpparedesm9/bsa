use cob_cartera 
go 

--GRUPO 48 

update ca_garantia_liquida set    gl_dev_estado = 'CB' where  gl_grupo = 48 and  gl_tramite = 5589 and  gl_pag_valor  != 0

--61 - DARES LIQUIDO EL 15 DE SEPTIRMBRE
update ca_garantia_liquida set    gl_dev_estado = 'CB'where  gl_grupo  = 61 and   gl_tramite = 4266 and gl_pag_valor  != 0

--99 - MAGENTA LIQUIDO EL 25 DE SEPTIEMBRE
update ca_garantia_liquida set    gl_dev_estado = 'CB'where  gl_grupo  = 99 and   gl_tramite = 4939 and  gl_pag_valor  != 0