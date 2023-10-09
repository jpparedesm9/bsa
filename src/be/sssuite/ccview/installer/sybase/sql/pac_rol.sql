use cobis
go

/****************************************************/
/*                                                  */
/* VERIFICAR ROL ADMINISTRADOR DE VISTA CONSOLIDADA */
/*                   DE CLIENTES                    */
/*                                                  */
/****************************************************/

declare @w_rol smallint
--select @w_rol = inst_rol from cobis..platform_installer
select 	@w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

/***********************************************************/
/*                                                         */
/* AUTORIZAR TRNS A ROL ADMINISTRADOR DE PLATAFORMA        */
/*                                                         */
/***********************************************************/

delete ad_tr_autorizada
  where ta_rol = @w_rol
  and ta_transaccion between 73000 and 73020
  
delete ad_tr_autorizada
  where ta_rol = @w_rol
  and ta_transaccion in (132,136,1312,1315,21084,731001)

insert into ad_tr_autorizada 
  select 73, 'R', 0, tn_trn_code, @w_rol, getdate(), 1, 'V', getdate()
  from cobis..cl_ttransaccion
  where tn_trn_code between 73000 and 73020

insert into ad_tr_autorizada 
  select 73, 'R', 0, tn_trn_code, @w_rol, getdate(), 1, 'V', getdate()
  from cobis..cl_ttransaccion
  where tn_trn_code in (132,136,1312,1315,21084,731001)
go   
