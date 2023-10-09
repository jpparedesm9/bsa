use cob_credito
go


set statistics time on;
set statistics io on;

/*set statistics time off;
set statistics io off;
*/

declare @w_ape_paterno   varchar(16) = 'CALLEJA             ',
@w_ape_materno   varchar(16) = 'MOYA                ',
@w_nombre        varchar(64) = 'ADAN                                    ',
@w_razon_social  varchar(128),
@w_n_conicidencias int = 2

select @w_n_conicidencias = count(*) 
from  cob_credito..cr_negative_file 
where lower(replace(isnull(nf_ape_paterno,''),' ', '')) = @w_ape_paterno
and   lower(replace(isnull(nf_ape_materno,''),' ', '')) = @w_ape_materno
and  (lower(replace(isnull(nf_nombre_razon_social,''),' ', '')) = @w_nombre or lower(replace(isnull(nf_nombre_razon_social,''),' ', '')) = @w_razon_social)

go


