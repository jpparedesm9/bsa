use cob_cartera
go

print 'Se ejecuta el script de rollback'

update  ca_garantia_liquida 
   set  gl_monto_garantia = GLRB.gl_monto_garantia , gl_pag_valor = GLRB.gl_pag_valor 
  from  ca_garantia_liquida GL, ca_garantia_liquida_98029 GLRB
 where  GL.gl_id      = GLRB.gl_id 
   and  GL.gl_grupo   = GLRB.gl_grupo  
   and  GL.gl_cliente = GLRB.gl_cliente 
   and  GL.gl_tramite = GLRB.gl_tramite
go
