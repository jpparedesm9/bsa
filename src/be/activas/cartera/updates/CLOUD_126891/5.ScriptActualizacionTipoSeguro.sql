
select *
from cob_cartera..ca_seguro_externo
where se_monto_pagado > 0

update cob_cartera..ca_seguro_externo set
se_tipo_seguro = 'BASICO'
where se_monto_pagado > 0
and   se_tipo_seguro is null

select *
from cob_cartera..ca_seguro_externo
where se_monto_pagado > 0