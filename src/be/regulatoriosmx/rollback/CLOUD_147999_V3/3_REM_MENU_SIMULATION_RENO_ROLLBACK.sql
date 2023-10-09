use cobis
go
--CREACION DE MENU
declare @w_me_id int

select @w_me_id= me_id from cew_menu where me_name = 'MNU_SIMUL_RENOV_FIN'    

DELETE cew_menu_role where mro_id_menu = @w_me_id

DELETE FROM dbo.cew_menu WHERE me_id = @w_me_id