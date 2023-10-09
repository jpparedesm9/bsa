package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.creditfacility.dto.DistributionLineRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.DataCreditLine;
import com.cobiscorp.cobis.busin.model.DistributionEntity;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class DistributionLineManagement extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(DistributionLineManagement.class);

	public DistributionLineManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public void deleteDistributionLine(DataEntity row, IGridRowActionEventArgs arg1, BehaviorOption options) {

		if (logger.isDebugEnabled())
			logger.logDebug("Start deleteDistributionLine");
		DataEntity dataCreditLine = arg1.getDynamicRequest().getEntity(DataCreditLine.ENTITY_NAME);

		logger.logDebug("dataCreditLine-------->" + dataCreditLine);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();

		if (dataCreditLine != null && dataCreditLine.get(DataCreditLine.LINEA) != null && row != null) {
			DistributionLineRequest distributionLine = new DistributionLineRequest();
			distributionLine.setLinea(dataCreditLine.get(DataCreditLine.LINEA));
			distributionLine.setMoneda(row.get(DistributionEntity.MONEDA) == null ? 0 : Integer.valueOf(row.get(DistributionEntity.MONEDA)));
			distributionLine.setToperacion(row.get(DistributionEntity.TIPOOPERACION));
			distributionLine.setProducto(row.get(DistributionEntity.PRODUCTO));
			serviceRequestTO.addValue("inDistributionLineRequest", distributionLine);
			ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEDELETEDISTIBUTIONLINE, serviceRequestTO);

			if (serviceResponse != null) {
				if (!serviceResponse.isResult()) {
					MessageManagement.show(serviceResponse, arg1, options);

				}
			}
		}

		if (logger.isDebugEnabled())
			logger.logDebug("Finish deleteDistributionLine");
	}

	public void updateDistributionLine(DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		DataEntity distributionEntity = entities.getEntity(DistributionEntity.ENTITY_NAME);
		DataEntity dataCreditLine = entities.getEntity(DataCreditLine.ENTITY_NAME);

		DistributionLineRequest distributionLine = new DistributionLineRequest();
		distributionLine.setLinea(dataCreditLine.get(DataCreditLine.LINEA));
		distributionLine.setMonto(distributionEntity.get(DistributionEntity.MONTO) == null ? 0.0 : distributionEntity.get(DistributionEntity.MONTO).doubleValue());
		distributionLine.setMoneda(distributionEntity.get(DistributionEntity.MONEDA) == null ? 0 : Integer.valueOf(distributionEntity.get(DistributionEntity.MONEDA)));
		distributionLine.setToperacion(distributionEntity.get(DistributionEntity.TIPOOPERACION));
		distributionLine.setProducto(distributionEntity.get(DistributionEntity.PRODUCTO));
		distributionLine.setCondicionEspecial(distributionEntity.get(DistributionEntity.OBSERVACION));
		serviceRequestTO.addValue("inDistributionLineRequest", distributionLine);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATEDISTRIBUTIONLINE, serviceRequestTO);
		if (serviceResponse != null) {
			if (!serviceResponse.isResult()) {
				MessageManagement.show(serviceResponse, arg1, options);

			}
		}
	}

	public void insertDistributionLine(DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		DataEntity distributionEntity = entities.getEntity(DistributionEntity.ENTITY_NAME);
		DataEntity dataCreditLine = entities.getEntity(DataCreditLine.ENTITY_NAME);

		DistributionLineRequest distributionLine = new DistributionLineRequest();
		distributionLine.setLinea(dataCreditLine.get(DataCreditLine.LINEA));
		distributionLine.setMonto(distributionEntity.get(DistributionEntity.MONTO) == null ? 0.0 : distributionEntity.get(DistributionEntity.MONTO).doubleValue());
		distributionLine.setMoneda(distributionEntity.get(DistributionEntity.MONEDA) == null ? 0 : Integer.valueOf(distributionEntity.get(DistributionEntity.MONEDA)));
		distributionLine.setToperacion(distributionEntity.get(DistributionEntity.TIPOOPERACION));
		distributionLine.setProducto(distributionEntity.get(DistributionEntity.PRODUCTO));
		distributionLine.setCondicionEspecial(distributionEntity.get(DistributionEntity.OBSERVACION));
		serviceRequestTO.addValue("inDistributionLineRequest", distributionLine);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICECREATEDISTRIBUTIONLINE, serviceRequestTO);
		if (serviceResponse != null) {
			if (!serviceResponse.isResult()) {
				MessageManagement.show(serviceResponse, arg1, options);

			}
		}
	}
}
