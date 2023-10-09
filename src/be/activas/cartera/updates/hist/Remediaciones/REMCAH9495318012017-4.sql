use cobis
go

declare @id_parent int
select  @id_parent = me_id from cobis..cew_menu where me_name = 'MNU_ASSETS_TRNSC'
UPDATE  cobis..cew_menu set me_id_parent = @id_parent where me_name= 'MNU_ASSETS_PAYMENTS'

go


