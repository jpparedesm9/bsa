package com.cobiscorp.cobis.busin.warrantiescreation.custonevents.events;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.collateral.dto.CustodyAllData;
import cobiscorp.ecobis.collateral.dto.FixedTermData;
import cobiscorp.ecobis.collateral.dto.PolicyData;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loanrequest.general.dto.CustomerData;

import com.cobiscorp.cobis.busin.customevents.utils.MapWarranty;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CollateralManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.GuaranteeManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Convert;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.CustomerSearch;
import com.cobiscorp.cobis.busin.model.WarrantyGeneral;
import com.cobiscorp.cobis.busin.model.WarrantyLocation;
import com.cobiscorp.cobis.busin.model.WarrantyPoliciy;
import com.cobiscorp.cobis.busin.model.WarrantySituation;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class InitDataWarranty extends BaseEvent implements IInitDataEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(InitDataWarranty.class);

	public InitDataWarranty(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Ingreso InitDataWarranty");
		int numeroTramite = 0;
		try {
			DataEntity warrantyGeneral = entities.getEntity(WarrantyGeneral.ENTITY_NAME);

			ApplicationResponse applicationResponseDTO = null;
			TransactionManagement tranManager = new TransactionManagement(super.getServiceIntegration());
			DataEntityList customerEntity = new DataEntityList();

			numeroTramite = warrantyGeneral.get(WarrantyGeneral.TRAMITNUMBER) == null ? 0 : Integer.parseInt(warrantyGeneral.get(WarrantyGeneral.TRAMITNUMBER));
			LOGGER.logDebug("numeroTramite" + numeroTramite);
			Map<String, Object> currentRow = (Map<String, Object>) arg1.getParameters().getCustomParameters().get("currentRow");
			if (numeroTramite != 0) {
				applicationResponseDTO = tranManager.getApplication(numeroTramite, arg1, new BehaviorOption(true));
				if (applicationResponseDTO == null) {
					MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_ONSDELIIM_67402", MessageLevel.ERROR, true));
					return;
				}

				if (currentRow == null) {
					DataEntity dataEntityCusto = new DataEntity();
					dataEntityCusto.set(CustomerSearch.OFFICERID, applicationResponseDTO.getOfficer());
					dataEntityCusto.set(CustomerSearch.OFFICER, applicationResponseDTO.getOfficerDescription().toString());
					dataEntityCusto.set(CustomerSearch.CUSTOMERID, 0);
					dataEntityCusto.set(CustomerSearch.CUSTOMER, "");
					customerEntity.add(dataEntityCusto);
					entities.setEntityList(CustomerSearch.ENTITY_NAME, customerEntity);
				}
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("-->arreglo de currentRow: " + currentRow);
			}
			/* Modificacion de Garantias Registradas */
			if (currentRow != null) {

				String codeWarranty = currentRow.get("CodeWarranty") == null ? null : currentRow.get("CodeWarranty").toString();
				String typeWarranty = currentRow.get("Type") == null ? null : currentRow.get("Type").toString();
				Integer office = currentRow.get("Office") == null ? null : Integer.valueOf(currentRow.get("Office").toString());

				if (codeWarranty != null && typeWarranty != null && office != null) {
					MapWarranty mapWaranty = new MapWarranty();
					mapWaranty.getWarranty(entities, arg1, getServiceIntegration(), codeWarranty, typeWarranty, office);
				}
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.WARRANTIES_INITDATA_WARRANTY, e, arg1, LOGGER);
		} finally {
			// FIN
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Salida InitDataWarranty");
		}
	}

}
