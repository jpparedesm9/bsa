
use cobis 
go 



--BORRADO DE PROCESO BATCH 
PRINT 'BORRADO DE PROCESO 7221'
if exists (select 1 from cobis..ba_sarta_batch  where sb_sarta = 22 and sb_batch = 7221) begin 
   delete from cobis..ba_sarta_batch  where sb_sarta = 22 and sb_batch = 7221
end 



if exists (select 1 from cobis..ba_enlace where en_batch_inicio = 7221 and en_sarta = 22) begin 
   delete from cobis..ba_enlace where en_batch_inicio = 7221 and en_sarta = 22  
end 



if exists (select 1 from cobis..ba_batch where ba_batch = 7221)begin
   delete from cobis..ba_batch where ba_batch = 7221
end 


--------login_batch 

if exists (select 1 from cobis..ba_login_batch where lb_sarta = 22 and lb_batch = 7221 and lb_login in ('admuser','usrbatch'))begin 
   delete from cobis..ba_login_batch where lb_sarta = 22 and lb_batch = 7221 and lb_login in ('admuser','usrbatch')
end 



