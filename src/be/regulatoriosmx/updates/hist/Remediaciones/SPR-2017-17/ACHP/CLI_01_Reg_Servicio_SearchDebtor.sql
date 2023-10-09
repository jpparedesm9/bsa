-- Se compia del archivo: $/COB/Desarrollos/DEV_SaaSMX/Remediaciones/SPR-2017-14/POV
-- Solo el ingreso lo de mas si esta ejecutado
-- Problema: No se muesta el deudor en el  cuestionario
use cobis
go
      IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'LoanGroup.MemberMaintenance.SearchDebtor')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.loangroup.service.IMemberMaintenance', csc_method_name = 'searchDebtor', csc_description = '', csc_trn = 810 WHERE csc_service_id = 'LoanGroup.MemberMaintenance.SearchDebtor'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('LoanGroup.MemberMaintenance.SearchDebtor', 'cobiscorp.ecobis.loangroup.service.IMemberMaintenance', 'searchDebtor', '', 810)
      go
    print 'insert en cts_serv_catalog'
	
use cobis
go
declare @w_rol int, @w_producto int	  
    select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
    select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
        
    DELETE cobis..ad_servicio_autorizado where ts_servicio = 'LoanGroup.MemberMaintenance.SearchDebtor' and ts_producto = @w_producto 
    INSERT INTO cobis..ad_servicio_autorizado values('LoanGroup.MemberMaintenance.SearchDebtor', @w_rol, @w_producto, 'R', 0, getdate(), 'V',getdate())
    print 'insert en ad_servicio_autorizado'
go
	