
use cobis 
go 

update cobis..ba_batch set 
ba_nombre           = 'PAGOS DE PRESTAMOS VENCIDOS CON DESC. A LA GAR. LIQUIDA',
ba_descripcion      = 'PAGOS DE PRESTAMOS VENCIDOS CON DESC. A LA GAR. LIQUIDA',
ba_tipo_batch       = 'P',
ba_ente_procesado   = 'CARTERA',
ba_arch_resultado   = null,
ba_arch_fuente      = 'cob_cartera..sp_pagos_ven_garliq_ej',
ba_impresora        = null
where ba_batch = 7190


update cobis..ba_sarta_batch set 
sb_habilitado = 'S'
where sb_sarta = 12 and sb_batch = 7190

delete cobis..ba_parametro 
where pa_batch = 7190

--------login_batch 

if exists (select 1 from cobis..ba_login_batch where lb_sarta = 12 and lb_batch = 7190 and lb_login in ('admuser','usrbatch'))begin 
   delete from cobis..ba_login_batch where lb_sarta = 12 and lb_batch = 7190 and lb_login in ('admuser','usrbatch')
end 

insert into cobis..ba_login_batch (lb_login,lb_sarta,lb_batch,lb_fecha_aut,lb_estado,lb_usuario,lb_fecha_ult_mod)
select  distinct 'admuser',sb_sarta, sb_batch,getdate(),'V','admuser',getdate() 
from cobis..ba_sarta_batch where sb_sarta = 12 and sb_batch = 7190

insert into cobis..ba_login_batch (lb_login,lb_sarta,lb_batch,lb_fecha_aut,lb_estado,lb_usuario,lb_fecha_ult_mod)
select  distinct 'usrbatch',sb_sarta, sb_batch,getdate(),'V','usrbatch',getdate() 
from cobis..ba_sarta_batch  where sb_sarta = 12 and sb_batch = 7190