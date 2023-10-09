Use cob_conta
go

declare  @w_empresa  int,
         @w_modulo   int
        
if exists (select 1 from cob_conta..sysobjects where name = 'cb_perfil')
begin
   select @w_modulo = 7
   select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'

   delete from cob_conta..cb_perfil where pe_empresa = @w_empresa and pe_producto = @w_modulo
   
   INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion) values (@w_empresa, @w_modulo, 'BOC_ACT', 'BALANCE OPERATIVO CONTABLE')
   INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion) values (@w_empresa, @w_modulo, 'CCA_RPA', 'REGISTRO DEL PAGO')
   INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion) values (@w_empresa, @w_modulo, 'CCA_PAG', 'PAGO DE PRESTAMO')
   INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion) values (@w_empresa, @w_modulo, 'CCA_IOC', 'INGRESO OTROS CARGOS')
   INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion) values (@w_empresa, @w_modulo, 'CCA_PRV', 'DEVENGAMIENTO DIARIO')
   INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion) values (@w_empresa, @w_modulo, 'CCA_DES', 'DESEMBOLSO DE PRESTAMOS')
   INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion) values (@w_empresa, @w_modulo, 'CCA_EST', 'CAMBIO DE ESTADO')
   INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion) values (@w_empresa, @w_modulo, 'CCA_FND', 'ADMINISTRACION DE FONDOS')
   INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion) values (@w_empresa, @w_modulo, 'CCA_GAR', 'CONTABILIZACION DE GARANTIAS LIQUIDAS')
   INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion) values (@w_empresa, @w_modulo, 'CCA_CAS', 'CASTIGO DE PRESTAMOS')
   INSERT INTO cob_conta..cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion) values (@w_empresa, @w_modulo, 'CCA_VEN', 'VENCIMIENTO DE CUOTAS')

end
else
    print 'NO EXISTE TABLA cb_perfil'
go
