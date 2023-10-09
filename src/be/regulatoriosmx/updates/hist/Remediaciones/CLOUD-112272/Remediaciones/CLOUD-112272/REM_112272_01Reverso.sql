use cob_cartera
GO

DROP TABLE #universo
GO
DROP TABLE #grupos
GO
DROP TABLE #pagos_cabecera
GO
DROP TABLE #saldos
go
DROP TABLE #pagos_realizados
GO
DROP TABLE #valida
GO

---------------------------------
--PROCESO DE OPERACIONES CON IOC
---------------------------------
select distinct 
       operacion  = oc_operacion , 
       secuencial = oc_secuencial,
       dividendo  = oc_div_desde,
       oficina    = op_oficina,
       cuota      = op_cuota,
       banco      = op_banco
  INTO #universo
  FROM ca_otro_cargo,
       ca_operacion a
 WHERE a.op_operacion = oc_operacion
   AND a.op_estado IN (1,2)
   and a.op_operacion > 0
 

select amh_operacion,
       amh_secuencial,
       saldo_ioc = sum(amh_cuota - amh_pagado)
  into #saldos
  from ca_amortizacion_his,
       #universo
 where amh_operacion  = operacion
   and amh_dividendo  = dividendo
   and amh_secuencial = secuencial
   and amh_concepto   = 'CAP'
 group by amh_operacion, amh_secuencial
having sum(amh_cuota - amh_pagado) < 10

insert into #saldos
select amh_operacion, 
       amh_secuencial, 
       saldo_ioc = sum(amh_cuota - amh_pagado)
  from cob_cartera_his..ca_amortizacion_his,
       #universo
 where amh_operacion  = operacion
   and amh_dividendo  = dividendo
   and amh_secuencial = secuencial
   and amh_concepto   = 'CAP'
 group by amh_operacion, amh_secuencial
having sum(amh_cuota - amh_pagado) < 10


select tg_grupo,        
       operacion_padre =  op_operacion,
       monto_total     = sum(cuota)
  into #grupos
  from #saldos,
       #universo,
       cob_credito..cr_tramite_grupal,
       ca_operacion a  --operacion padre   
 where tg_operacion         = amh_operacion
   and tg_referencia_grupal = a.op_banco 
   AND tg_participa_ciclo   = 'S' 
   AND tg_monto > 0   
   AND operacion            = amh_operacion
  group BY tg_grupo, op_operacion
  order by tg_grupo

select *
  into #pagos_cabecera
  from #grupos, 
       ca_corresponsal_trn 
 where co_codigo_interno = operacion_padre
   and co_estado         = 'P'
   and co_accion         = 'I'
   AND co_tipo           = 'PG'


select cd_secuencial, 
       tg_grupo, 
       operacion_padre, 
       cd_operacion,  
       abd_monto_mn, 
       monto_total, 
       ab_secuencial_ing, 
       ab_secuencial_pag, 
       ab_fecha_pag, 
       ab_estado
  into #pagos_realizados
  from #pagos_cabecera,
       ca_corresponsal_det,
       ca_abono,
       ca_abono_det
 where cd_secuencial = co_secuencial
   and cd_sec_ing    = ab_secuencial_ing
   and ab_operacion  = cd_operacion
   and ab_operacion  = abd_operacion
   AND ab_estado     IN ('A', 'NA')
   and abd_secuencial_ing = ab_secuencial_ing
 ORDER BY ab_operacion, ab_fecha_pag DESC, ab_secuencial_pag DESC


TRUNCATE TABLE mta_112580_total
 
INSERT INTO mta_112580_total
select t1.cd_secuencial, 
	   t1.tg_grupo, 
 	   t1.operacion_padre, 
 	   t1.cd_operacion, 
 	   t1.abd_monto_mn, 
 	   t1.monto_total, 	   
 	   t2.op_cuota,  	   
 	   t2.op_banco,
 	   t2.op_oficina,
 	   t1.ab_secuencial_ing, 
 	   t1.ab_secuencial_pag, 
 	   t1.ab_fecha_pag,  
 	   t1.ab_estado,	
 	   'N'
  from #pagos_realizados t1, 
       ca_operacion t2     
 where cd_operacion = op_operacion 
 ORDER BY cd_operacion, ab_fecha_pag DESC, ab_secuencial_pag DESC

--Validar que no existan pagos individuales
SELECT cd_secuencial, 
       tg_grupo,operacion_padre, 
       pagos = count(1), 
       num_opera = (SELECT count(1)
                      FROM cob_credito..cr_tramite_grupal, 
                           ca_operacion  
                     WHERE op_operacion = t.operacion_padre 
                       AND op_banco = tg_referencia_grupal)
  INTO #valida
  FROM #pagos_realizados t
 GROUP BY cd_secuencial, tg_grupo, operacion_padre

SELECT 'pagos individuales'
SELECT *
  FROM #valida
 WHERE pagos <> num_opera


SELECT 'OPERACIONES A PROCESAR'
SELECT * 
  FROM mta_112580_total
 ORDER BY to_operacion_padre DESC, to_operacion DESC, to_sec_corresponsal


GO


--SELECT DISTINCT to_grupo FROM mta_112580_total















