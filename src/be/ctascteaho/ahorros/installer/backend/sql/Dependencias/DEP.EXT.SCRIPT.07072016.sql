use cobis
go
/**********************************************************/
/* Fecha Creación del Script: 2016/07/06                  */
/* Historial Dependencias:                                */
/* 01/07/28  J.Salazar  Autorizacion sp_consulta_prod     */
/* Modulo :  REM - AHO                                    */
/**********************************************************/
declare @w_producto tinyint,
        @w_rol      tinyint,
        @w_moneda   tinyint

select @w_producto = 10

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete from ad_tr_autorizada
 where ta_transaccion = 475
   and ta_rol         = @w_rol
   and ta_producto    = @w_producto

insert into ad_tr_autorizada values(@w_producto,'R',@w_moneda,475,@w_rol,getdate(),1,'V',getdate())

delete from ad_pro_transaccion
 where pt_producto    = @w_producto
   and pt_transaccion = 475
   and pt_procedure   = 460

insert into ad_pro_transaccion values(@w_producto,'R',@w_moneda,475,'V',getdate(),460,null)
go

delete from ad_procedure
 where pd_procedure = 460
go
insert into ad_procedure values (460,'sp_consulta_prod','cob_remesas','V',getdate(),'reprocob.sp')
go

delete from cl_ttransaccion
 where tn_trn_code = 475
go

insert into cl_ttransaccion values (475,'CONSULTA DE PRODUCTOS COBIS','COPC','CONSULTA DE PRODUCTOS COBIS')
go


use cobis
go
/**************************************************************/
/* Fecha Creación del Script: 2016/07/06                      */
/* Historial Dependencias:                                    */
/* 01/07/28  J.Salazar  Autorizacion sp_help_trn_contabilizar */
/* Modulo :  REM - AHO                                        */
/**************************************************************/
declare @w_producto tinyint,
        @w_rol      tinyint,
        @w_moneda   tinyint

select @w_producto = 10

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete from ad_tr_autorizada
 where ta_transaccion = 494
   and ta_rol         = @w_rol
   and ta_producto    = @w_producto

insert into ad_tr_autorizada values(@w_producto,'R',@w_moneda,494,@w_rol,getdate(),1,'V',getdate())

delete from ad_pro_transaccion
 where pt_producto    = @w_producto
   and pt_transaccion = 494
   and pt_procedure   = 459

insert into ad_pro_transaccion values(@w_producto,'R',@w_moneda,494,'V',getdate(),459,null)
go

delete from ad_procedure
 where pd_procedure = 459
go
insert into ad_procedure values (459,'sp_help_trn_contabilizar','cob_remesas','V',getdate(),'rehecont.sp')
go

delete from cl_ttransaccion
 where tn_trn_code = 494
go

insert into cl_ttransaccion values (494,'CONSULTA DE TRANSACCIONES A CONTABILIZAR','CCON','CONSULTA DE TRANSACCIONES A CONTABILIZAR')
go


use cobis
go
/**********************************************************/
/* Fecha Creación del Script: 2016/07/06                  */
/* Historial Dependencias:                                */
/* 01/07/28  J.Salazar  Autorizacion sp_perfil            */
/* Modulo :  CONTA - AHO                                  */
/**********************************************************/
declare @w_producto tinyint,
        @w_rol      tinyint,
        @w_moneda   tinyint

select @w_producto = 6

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete from ad_tr_autorizada
 where ta_transaccion = 6907
   and ta_rol         = @w_rol
   and ta_producto    = @w_producto

insert into ad_tr_autorizada values(@w_producto,'R',@w_moneda,6907,@w_rol,getdate(),1,'V',getdate())

delete from ad_pro_transaccion
 where pt_producto    = @w_producto
   and pt_transaccion = 6907
   and pt_procedure   = 6436

insert into ad_pro_transaccion values(@w_producto,'R',@w_moneda,6907,'V',getdate(),6436,null)
go

delete from ad_procedure
 where pd_procedure = 6436
go
insert into ad_procedure values (6436,'sp_perfil','cob_conta','V',getdate(),'perfil.sp')
go

delete from cl_ttransaccion
 where tn_trn_code = 6907
go

insert into cl_ttransaccion values (6907,'SEARCH DE PERFIL CONTABLE','6907','SEARCH DE PERFIL CONTABLE')
go


use cobis
go
/**********************************************************/
/* Fecha Creación del Script: 2016/07/06                  */
/* Historial Dependencias:                                */
/* 01/07/28  J.Salazar  Autorizacion sp_par_perfil        */
/* Modulo :  REM - AHO                                    */
/**********************************************************/
declare @w_producto tinyint,
        @w_rol      tinyint,
        @w_moneda   tinyint

select @w_producto = 10

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

delete from ad_tr_autorizada
 where ta_transaccion in (720,721)
   and ta_rol         = @w_rol
   and ta_producto    = @w_producto

insert into ad_tr_autorizada values(@w_producto,'R',@w_moneda,720,@w_rol,getdate(),1,'V',getdate())
insert into ad_tr_autorizada values(@w_producto,'R',@w_moneda,721,@w_rol,getdate(),1,'V',getdate())

delete from ad_pro_transaccion
 where pt_producto    = @w_producto
   and pt_transaccion in (720,721)
   and pt_procedure   = 709

insert into ad_pro_transaccion values(@w_producto,'R',@w_moneda,720,'V',getdate(),709,null)
insert into ad_pro_transaccion values(@w_producto,'R',@w_moneda,721,'V',getdate(),709,null)
go

delete from ad_procedure
 where pd_procedure = 709
go
insert into ad_procedure values(709,'sp_par_perfil','cob_remesas','V',getdate(),'reparperfil.sp')
go

delete from cl_ttransaccion
 where tn_trn_code in (720,721)
go

insert into cl_ttransaccion values (720,'MANTENIMIENTO OPCIONES DML PARA PARAMETRIZACION DE PERFIL','MPPER','REALIZA EL MANTENIMIENTO DE LOS DATOS PARA LA PARAMETRIZACION DE LAS TRANSACCIONES AL PERFIL CONTABLE')
insert into cl_ttransaccion values (721,'OPCIONES DE CONSULTA PARA PARAMETRIZACION DE PERFIL','CPPER','EJECUTA LAS CONSULTAS DE LOS DATOS PARA LA PARAMETRIZACION DE LAS TRANSACCIONES AL PERFIL CONTABLE')
go


use cobis
go
/**********************************************************/
/* Fecha Creación del Script: 2016/07/06                  */
/* Historial Dependencias:                                */
/* 01/07/28  J.Salazar  Seqnos re_trn_perfil              */
/* Modulo :  REM - AHO                                    */
/**********************************************************/

delete from cobis..cl_seqnos
 where tabla  = 're_trn_perfil'
   and bdatos = 'cob_remesas'
go

insert into cobis..cl_seqnos values ('cob_remesas','re_trn_perfil',0,'tp_secuencial')
go
