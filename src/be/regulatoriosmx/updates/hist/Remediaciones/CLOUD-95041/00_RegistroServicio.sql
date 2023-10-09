
    /************************************************************/
    /*******************Service Operations Script*********************/
    /************************************************************/
    /*   This code was generated by CEN-SG.                     */
    /*   Changes to this file may cause incorrect behavior      */
    /*   and will be lost if the code is regenerated.           */
    /************************************************************/

    use cobis
    GO
    
	
    IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Loan.LoanMaintenance.UpdateLoanGroup')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', csc_method_name = 'updateLoanGroup', csc_description = '', csc_trn = 73904 WHERE csc_service_id = 'Loan.LoanMaintenance.UpdateLoanGroup'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('Loan.LoanMaintenance.UpdateLoanGroup', 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', 'updateLoanGroup', '', 73904)
      GO
    use cobis
    GO
	
	declare @w_moneda tinyint,
        @w_rol    tinyint
    
    select @w_moneda = pa_tinyint
    from cobis..cl_parametro
    where pa_nemonico = 'CMNAC'
    and pa_producto = 'ADM'
     
    if exists (SELECT 1 FROM ad_rol WHERE ro_descripcion = 'MENU POR PROCESOS')
    begin
         select @w_rol = ro_rol
         from cobis..ad_rol
         where ro_descripcion = 'MENU POR PROCESOS'
	end
	else
	begin
	     select @w_rol = ro_rol
         from cobis..ad_rol
         where ro_descripcion = 'ADMINISTRADOR'
  	end
  	
  	
  	
  	if not exists(select 1 from cobis..ad_servicio_autorizado where ts_servicio= 'Loan.LoanMaintenance.UpdateLoanGroup')
    begin     
          insert into cobis..ad_servicio_autorizado (ts_servicio                           , ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
                                             values ('Loan.LoanMaintenance.UpdateLoanGroup', @w_rol, 7         , 'R'    , @w_moneda, getdate()   , 'V'      , getdate())                                     
    end

