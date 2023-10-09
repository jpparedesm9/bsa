/*************************************************** VCC ***************************************************/
use cobis
go

declare @w_id_menu int,@w_moneda tinyint, @w_id_producto int,@w_tipo varchar(20)

select @w_id_menu 	= me_id from cobis..cew_menu where me_name = "MNU_VCC"
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura="VCC"
select @w_tipo		= "R"
select @w_moneda   	= 0

/************************************************************************************************************************************/
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura="BVI"  --18
insert into cew_menu_transaccion values(@w_id_menu,1850022, @w_id_producto,@w_tipo,@w_moneda)      

select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura="VCC"  --73                                                                                                 
insert into cew_menu_transaccion values(@w_id_menu,73000, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73001, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73002, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73003, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73004, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73005, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73006, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73007, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73008, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73009, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73010, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73011, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73012, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73013, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73014, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73015, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73016, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73017, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73018, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73019, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73020, @w_id_producto,@w_tipo,@w_moneda)   
insert into cew_menu_transaccion values(@w_id_menu,132, @w_id_producto,@w_tipo,@w_moneda)        
insert into cew_menu_transaccion values(@w_id_menu,136, @w_id_producto,@w_tipo,@w_moneda)        
insert into cew_menu_transaccion values(@w_id_menu,1312, @w_id_producto,@w_tipo,@w_moneda)       
insert into cew_menu_transaccion values(@w_id_menu,1315, @w_id_producto,@w_tipo,@w_moneda)       
insert into cew_menu_transaccion values(@w_id_menu,731001, @w_id_producto,@w_tipo,@w_moneda) 

select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura="REM"  --10
insert into cew_menu_transaccion values(@w_id_menu,644, @w_id_producto,@w_tipo,@w_moneda) 

select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura="CRE"  --16
insert into cew_menu_transaccion values(@w_id_menu,16979, @w_id_producto,@w_tipo,@w_moneda) 

go
