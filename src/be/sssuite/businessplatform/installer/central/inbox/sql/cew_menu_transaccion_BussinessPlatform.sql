/*************************************************** BussinessPlatform Inbox ***************************************************/
use cobis
go

declare @w_id_menu int,@w_moneda tinyint, @w_id_producto int,@w_tipo varchar(20)

select @w_id_menu 	= me_id from cobis..cew_menu where me_name = 'MNU_CONTAINER_INBOX_FF'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='CWF' --43
select @w_tipo		= 'R'
select @w_moneda   	= 0

/************************************************************************************************************************************/
/*********************************************************************Inbox***************************************************************/
print 'transacciones Inbox'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='VCC'  --73
insert into cew_menu_transaccion values(@w_id_menu,73500, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73501, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73503, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73504, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73505, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73506, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73507, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73508, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73509, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73510, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73511, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73512, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73513, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73514, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73515, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73516, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73517, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73518, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73519, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73520, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73521, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73522, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73523, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73524, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73525, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73526, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73527, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73528, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73529, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73530, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73531, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73532, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73533, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73534, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73535, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73536, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73537, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73538, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73539, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73540, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73541, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73542, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73543, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73544, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73545, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73546, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73547, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73548, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73549, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73550, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73551, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73552, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73553, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73554, @w_id_producto,@w_tipo,@w_moneda)    
insert into cew_menu_transaccion values(@w_id_menu,7005, @w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_transaccion values(@w_id_menu,73911, @w_id_producto,@w_tipo,@w_moneda) -- Generación Tabla de amortización
insert into cew_menu_transaccion values(@w_id_menu,7462, @w_id_producto,@w_tipo,@w_moneda) 
insert into cew_menu_transaccion values(@w_id_menu,31829, @w_id_producto,@w_tipo,@w_moneda) -- realizar la regla
insert into cew_menu_transaccion values(@w_id_menu,7008, @w_id_producto,@w_tipo,@w_moneda) -- cob_cartera-sp_consulta_rubro
insert into cew_menu_transaccion values(@w_id_menu,7125, @w_id_producto,@w_tipo,@w_moneda) -- cob_cartera-sp_valor
insert into cew_menu_transaccion values(@w_id_menu,7128, @w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_transaccion values(@w_id_menu,537, @w_id_producto,@w_tipo,@w_moneda) -- sp_feriados_tamortizacion

/*********************************************************************Workflow***************************************************************/
print 'transacciones Workflow ADM'

select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='CWF'  --1
insert into cew_menu_transaccion values(@w_id_menu,15001, @w_id_producto,@w_tipo,@w_moneda)     
insert into cew_menu_transaccion values(@w_id_menu,15165, @w_id_producto,@w_tipo,@w_moneda)     

insert into cew_menu_transaccion values(@w_id_menu,1502, @w_id_producto,@w_tipo,@w_moneda)     
insert into cew_menu_transaccion values(@w_id_menu,15168, @w_id_producto,@w_tipo,@w_moneda)     

insert into cew_menu_transaccion values(@w_id_menu,15227, @w_id_producto,@w_tipo,@w_moneda)     
insert into cew_menu_transaccion values(@w_id_menu,15235, @w_id_producto,@w_tipo,@w_moneda)    
insert into cew_menu_transaccion values(@w_id_menu,15240, @w_id_producto,@w_tipo,@w_moneda)     
insert into cew_menu_transaccion values(@w_id_menu,15244, @w_id_producto,@w_tipo,@w_moneda)    
insert into cew_menu_transaccion values(@w_id_menu,15279, @w_id_producto,@w_tipo,@w_moneda)     
insert into cew_menu_transaccion values(@w_id_menu,15282, @w_id_producto,@w_tipo,@w_moneda)    

print 'transacciones Workflow CWF'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='CWF'  --43
insert into cew_menu_transaccion values(@w_id_menu,15283, @w_id_producto,@w_tipo,@w_moneda)     
insert into cew_menu_transaccion values(@w_id_menu,15284, @w_id_producto,@w_tipo,@w_moneda)    
insert into cew_menu_transaccion values(@w_id_menu,15295, @w_id_producto,@w_tipo,@w_moneda)     

print 'transacciones Workflow ADM'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='CWF'  --1
insert into cew_menu_transaccion values(@w_id_menu,15300, @w_id_producto,@w_tipo,@w_moneda)    
insert into cew_menu_transaccion values(@w_id_menu,15301, @w_id_producto,@w_tipo,@w_moneda)     
insert into cew_menu_transaccion values(@w_id_menu,15302, @w_id_producto,@w_tipo,@w_moneda)    

insert into cew_menu_transaccion values(@w_id_menu,15305, @w_id_producto,@w_tipo,@w_moneda)    
insert into cew_menu_transaccion values(@w_id_menu,15306, @w_id_producto,@w_tipo,@w_moneda)     
insert into cew_menu_transaccion values(@w_id_menu,15307, @w_id_producto,@w_tipo,@w_moneda)    
insert into cew_menu_transaccion values(@w_id_menu,15308, @w_id_producto,@w_tipo,@w_moneda)    
insert into cew_menu_transaccion values(@w_id_menu,15310, @w_id_producto,@w_tipo,@w_moneda)     
insert into cew_menu_transaccion values(@w_id_menu,15311, @w_id_producto,@w_tipo,@w_moneda)    
insert into cew_menu_transaccion values(@w_id_menu,15312, @w_id_producto,@w_tipo,@w_moneda)    
insert into cew_menu_transaccion values(@w_id_menu,15315, @w_id_producto,@w_tipo,@w_moneda)     
insert into cew_menu_transaccion values(@w_id_menu,15316, @w_id_producto,@w_tipo,@w_moneda)    
insert into cew_menu_transaccion values(@w_id_menu,15317, @w_id_producto,@w_tipo,@w_moneda)    
insert into cew_menu_transaccion values(@w_id_menu,15318, @w_id_producto,@w_tipo,@w_moneda)     
insert into cew_menu_transaccion values(@w_id_menu,15319, @w_id_producto,@w_tipo,@w_moneda)    
insert into cew_menu_transaccion values(@w_id_menu,15320, @w_id_producto,@w_tipo,@w_moneda)    
insert into cew_menu_transaccion values(@w_id_menu,15321, @w_id_producto,@w_tipo,@w_moneda)     
insert into cew_menu_transaccion values(@w_id_menu,15322, @w_id_producto,@w_tipo,@w_moneda)    

print 'transacciones Worklfow CWF 1'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='CWF'  --43
insert into cew_menu_transaccion values(@w_id_menu,31751, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31752, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31753, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31754, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31755, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31756, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31757, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31758, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31759, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31760, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31761, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31762, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31763, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31764, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31765, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31766, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31767, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31768, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31769, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31770, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31771, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31772, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31773, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31774, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31775, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31776, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31777, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31778, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31779, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31780, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31781, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31782, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31783, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31784, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31785, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31786, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31787, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31788, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31789, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31790, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31791, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31792, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31793, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31794, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31795, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31796, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31797, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31798, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31799, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31800, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31801, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31802, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31803, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31804, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31805, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31806, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31807, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31808, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31809, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31810, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31811, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31812, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31813, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31814, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31815, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31816, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31817, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31818, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31819, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31820, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31821, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31822, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31823, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31824, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31825, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31826, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31827, @w_id_producto,@w_tipo,@w_moneda)  
insert into cew_menu_transaccion values(@w_id_menu,31901, @w_id_producto,@w_tipo,@w_moneda)  
insert into cew_menu_transaccion values(@w_id_menu,31903, @w_id_producto,@w_tipo,@w_moneda)  
insert into cew_menu_transaccion values(@w_id_menu,32001, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32002, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32003, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32004, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32005, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32006, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32007, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32008, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32009, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32010, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32011, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32012, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32013, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32014, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32015, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32016, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32017, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32018, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32251, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32252, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32253, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32254, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32255, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32256, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32257, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32258, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32259, @w_id_producto,@w_tipo,@w_moneda)  
insert into cew_menu_transaccion values(@w_id_menu,32279, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32280, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32281, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32282, @w_id_producto,@w_tipo,@w_moneda) 
insert into cew_menu_transaccion values(@w_id_menu,32283, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32284, @w_id_producto,@w_tipo,@w_moneda)      

print 'transacciones Worklfow CWF 2'
insert into cew_menu_transaccion values(@w_id_menu,31750, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31831, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31832, @w_id_producto,@w_tipo,@w_moneda)      

print 'transacciones Worklfow CWF 3'
insert into cew_menu_transaccion values(@w_id_menu,32285, @w_id_producto,@w_tipo,@w_moneda)  

print 'transacciones Workflow VCC'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='VCC'  --73
insert into cew_menu_transaccion values(@w_id_menu,73800, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73801, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73802, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73803, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73804, @w_id_producto,@w_tipo,@w_moneda)   
insert into cew_menu_transaccion values(@w_id_menu,73805, @w_id_producto,@w_tipo,@w_moneda)   

insert into cew_menu_transaccion values(@w_id_menu,73914, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73915, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73920, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73921, @w_id_producto,@w_tipo,@w_moneda)   

insert into cew_menu_transaccion values(@w_id_menu,32284, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,32285, @w_id_producto,@w_tipo,@w_moneda)  
insert into cew_menu_transaccion values(@w_id_menu,31900, @w_id_producto,@w_tipo,@w_moneda)      


/*********************************************************************Simulator***************************************************************/
print 'transacciones Simulator VCC'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='VCC'  --73
insert into cew_menu_transaccion values(@w_id_menu,7002, @w_id_producto,@w_tipo,@w_moneda)       
insert into cew_menu_transaccion values(@w_id_menu,7061, @w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_transaccion values(@w_id_menu,7010, @w_id_producto,@w_tipo,@w_moneda)       
insert into cew_menu_transaccion values(@w_id_menu,7027, @w_id_producto,@w_tipo,@w_moneda)       
insert into cew_menu_transaccion values(@w_id_menu,21610, @w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_transaccion values(@w_id_menu,73700, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73701, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73702, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73703, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73704, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73705, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73706, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73707, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73708, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73709, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73710, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73711, @w_id_producto,@w_tipo,@w_moneda)   


/*********************************************************************Rules_Dependencies***************************************************************/
print 'transacciones Rules_Dependencies VCC'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='VCC'  --73
insert into cew_menu_transaccion values(@w_id_menu,73930, @w_id_producto,@w_tipo,@w_moneda)      

--43
print 'transacciones Rules_Dependencies CWF'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='CWF'  --73
insert into cew_menu_transaccion values(@w_id_menu,31829, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,21690, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,31830, @w_id_producto,@w_tipo,@w_moneda)      


/*********************************************************************Workflow Estadisticas***************************************************************/
print 'transacciones Workflow Statisctics CWF'
select @w_id_menu 	= me_id from cobis..cew_menu where me_name = 'MNU_WORKFLOW_STATISTICS'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='CWF'  --43

insert into cew_menu_transaccion values(@w_id_menu,73800, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73801, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73802, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73803, @w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_transaccion values(@w_id_menu,73804, @w_id_producto,@w_tipo,@w_moneda)   
insert into cew_menu_transaccion values(@w_id_menu,73805, @w_id_producto,@w_tipo,@w_moneda)   

