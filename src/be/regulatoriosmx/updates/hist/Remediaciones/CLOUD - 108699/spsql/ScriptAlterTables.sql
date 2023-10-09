
use cob_conta
go


if not exists(select 1 from sysobjects a,syscolumns b where a.name = 'cb_libromov_mayba' and b.name='lm_secuencial')
begin
	alter table cb_libromov_mayba add  lm_secuencial int null
end

