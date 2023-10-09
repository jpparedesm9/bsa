
select ab_estado, ab_operacion, ab_secuencial_ing, ab_fecha_ing, ab_fecha_pag  
from cob_cartera..ca_abono,cob_credito..cr_tramite_grupal
where tg_grupo = 1967
and   tg_operacion = ab_operacion
and   ab_estado not in ('RV', 'E')
order by ab_operacion, ab_secuencial_ing