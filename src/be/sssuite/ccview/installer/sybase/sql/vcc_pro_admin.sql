use cob_pac
go

declare @w_rol int, @w_rol_name varchar(100)
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_rol_name = ro_descripcion from cobis..ad_rol where ro_rol=@w_rol

delete from cob_pac..vcc_product_admin where pr_rol_id = @w_rol

insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,0,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,1,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,2,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,3,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,4,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,5,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,6,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,7,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,8,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,9,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,10,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,11,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,12,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,13,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,14,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,15,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,16,1,0,@w_rol_name)
--insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,17,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,18,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,19,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,20,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,21,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,22,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,23,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,24,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,25,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,42,1,0,@w_rol_name)
insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,52,1,0,@w_rol_name)
--insert into cob_pac..vcc_product_admin(pr_rol_id, prd_id, pr_isvisible, pr_isencrypted, pr_rol_name) values (@w_rol,53,1,0,@w_rol_name)
go
