
use cob_cartera 
go 

--GRUPO 61


--gl_grupo	gl_cliente	gl_tramite	gl_dev_estado	gl_dev_valor
--61	1672	4266	PD	500
--61	1676	4266	PD	500
--61	1679	4266	PD	500
--61	1769	4266	PD	1000
--61	1772	4266	PD	1000
--61	1774	4266	PD	600
--61	1912	4266	PD	500
--61	1917	4266	PD	700
--61	1918	4266	PD	500



update ca_garantia_liquida set gl_dev_estado = 'PD' , gl_pag_valor=500	where  gl_grupo  = 61 and   gl_tramite = 4266 and gl_cliente=1672
update ca_garantia_liquida set gl_dev_estado = 'PD' , gl_pag_valor=500	where  gl_grupo  = 61 and   gl_tramite = 4266 and gl_cliente=1676
update ca_garantia_liquida set gl_dev_estado = 'PD' , gl_pag_valor=500	where  gl_grupo  = 61 and   gl_tramite = 4266 and gl_cliente=1679
update ca_garantia_liquida set gl_dev_estado = 'PD' , gl_pag_valor=1000 where  gl_grupo  = 61 and   gl_tramite = 4266 and gl_cliente=1769
update ca_garantia_liquida set gl_dev_estado = 'PD' , gl_pag_valor=1000 where  gl_grupo  = 61 and   gl_tramite = 4266 and gl_cliente=1772
update ca_garantia_liquida set gl_dev_estado = 'PD' , gl_pag_valor=600	where  gl_grupo  = 61 and   gl_tramite = 4266 and gl_cliente=1774
update ca_garantia_liquida set gl_dev_estado = 'PD' , gl_pag_valor=500	where  gl_grupo  = 61 and   gl_tramite = 4266 and gl_cliente=1912
update ca_garantia_liquida set gl_dev_estado = 'PD' , gl_pag_valor=700	where  gl_grupo  = 61 and   gl_tramite = 4266 and gl_cliente=1917
update ca_garantia_liquida set gl_dev_estado = 'PD' , gl_pag_valor=500	where  gl_grupo  = 61 and   gl_tramite = 4266 and gl_cliente=1918
                                                       

go