use master
go

-- dump tran cobis with no_log
go

-- dump tran tempdb with no_log
go

use cobis
go

/****************************************************/
/*                                                  */
/* VERIFICAR ROL ADMINISTRADOR DE VISTA CONSOLIDADA */
/*                   DE CLIENTES                    */
/*                                                  */
/****************************************************/

declare @w_rol smallint
select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS' 

/***********************************************************/
/*                                                         */
/* AUTORIZAR TRNS A ROL ADMINISTRADOR DE PLATAFORMA        */
/*                                                         */
/***********************************************************/

delete ad_tr_autorizada
  where ta_rol = @w_rol
  and ta_transaccion between 73500 and 73554

insert into ad_tr_autorizada 
  select 73, 'R', 0, tn_trn_code, @w_rol, getdate(), 1, 'V', getdate()
  from cobis..cl_ttransaccion
  where tn_trn_code between 73500 and 73554   

go
