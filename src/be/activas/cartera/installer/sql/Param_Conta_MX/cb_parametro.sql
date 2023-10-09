Use cob_conta
go

declare  @w_empresa  int,
         @w_modulo   int

IF exists (select 1 from cob_conta..sysobjects where name = 'cb_parametro')
begin
   select @w_modulo = 7
   select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'

   delete FROM cob_conta..cb_parametro where pa_empresa = @w_empresa and pa_transaccion = @w_modulo
   
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'CAP_1311NE','CAPITAL VIGENTE','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'CAP_1311EX','CAPITAL VIGENTE','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'CAP_1361NE','CAPITAL VENCIDO','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'CAP_1361EX','CAPITAL VENCIDO','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'CAS_1391','CAPITAL (PROVISION)','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'COM_5321','CAPITAL (PROVISION)','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'QUI_1391','CAPITAL (PROVISION)','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'F_PAGO','FORMAS DE PAGO O DESEMBOLSO','sp_ca04_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'INT_1311NE','INTERES VIGENTE','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'INT_1311EX','INTERES VIGENTE','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'INT_1361','INTERESES VENCIDOS','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'INT_5102','INTERESES  VENCIDOS','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'INT_5105NE','INTERESES  VIGENTES','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'INT_5105EX','INTERESES  VIGENTES','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'INT_7711','INTERESES EN CUENTAS DE ORDEN','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'IVA_1401','IVA POR COBRAR AL CLIENTE','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'CAS_5050','Recuperación de cartera Castigada','sp_ca01_pf', @w_modulo)
   INSERT INTO cob_conta..cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion) values(@w_empresa,'PRO_1391','Provisión de Cartera','sp_ca05_pf ', @w_modulo)
   
end
else
    print 'NO EXISTE TABLA cb_parametro'

go
