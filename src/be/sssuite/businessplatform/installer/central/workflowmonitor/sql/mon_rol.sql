use cobis
go

-- dump tran cobis with no_log
-- go
-- 
-- dump tran tempdb with no_log
-- go

/****************************************************/
/*                                                  */
/*					 	Monitor						 */
/*                                                  */
/****************************************************/

declare @w_rol smallint

select @w_rol = inst_rol from cobis..platform_installer
/***********************************************************/
/*                                                         */
/* AUTORIZAR TRNS A ROL MONITOR     */
/*                                                         */
/***********************************************************/

delete ad_tr_autorizada
  where ta_rol = @w_rol
  and ta_transaccion between 73800 and 73804

insert into ad_tr_autorizada 
  select 73, 'R', 0, tn_trn_code, @w_rol, getdate(), 1, 'V', getdate()
  from cobis..cl_ttransaccion
  where tn_trn_code between 73800 and 73804 
  
  

go
