use cobis
go

update cobis..cl_ente_aux set
ea_lista_negra = 'S'
from cl_alertas_riesgo
where ar_tipo_lista = 'LI'
and ar_tipo_alerta=  'LN'  
and ar_ente = ea_ente
and isnull(ea_lista_negra,'N') = 'N'
and ea_ente not in (select ar_ente from cobis..cl_alertas_riesgo where ar_status = 'NR')



