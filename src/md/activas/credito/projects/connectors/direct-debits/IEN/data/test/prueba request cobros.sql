declare @retorno INT
exec @retorno = cob_cartera.dbo.sp_santander_gen_orden_ret
SELECT @retorno

SELECT * from cob_cartera.dbo.ca_santander_orden_retiro

truncate table cob_cartera.dbo.ca_santander_orden_retiro