package com.cobiscorp.cobis.busin.queryview.events;

import java.util.HashMap;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.DebtorManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.RevolvingManagment;
import com.cobiscorp.cobis.busin.flcre.commons.services.RuleExecutionManagement;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.RefinancingOperations;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.IGridCommand;
import com.cobiscorp.designer.api.customization.arguments.IGridExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class QV_ITRIC1523_63_GridCommandDeleting extends BaseEvent implements IGridCommand {
	private static ILogger LOGGER = LogFactory.getLogger(QV_ITRIC1523_63_GridCommandDeleting.class);

	public QV_ITRIC1523_63_GridCommandDeleting(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeGridCommad(DataEntityList operations, IGridExecuteCommandEventArgs arg1) {
		
		try{
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Ingreso -> QV_ITRIC1523_63_GridCommandDeleting");

			LOGGER.logDebug("Declaro servicio que va a ejecutar la eliminacion de la operacion");
			RevolvingManagment revolvingManagment = new RevolvingManagment(getServiceIntegration());
			RuleExecutionManagement ruleExecutionManagement = new RuleExecutionManagement(getServiceIntegration());
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
			DebtorManagement debManagement = new DebtorManagement(super.getServiceIntegration());

			LOGGER.logDebug("Recupero entidades desde el front end");
			DynamicRequest dynamicRequest = arg1.getDynamicRequest();
			DataEntity originalHeader = dynamicRequest.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntityList selectedOperations = dynamicRequest.getEntityList("SelectedOperations");
			DataEntity generalParameters = dynamicRequest.getEntity("GeneralParameters");
			DataEntityList debtors = dynamicRequest.getEntityList(DebtorGeneral.ENTITY_NAME);
			DataEntityList newOperations = new DataEntityList();
			DataEntityList deleteDebtors = new DataEntityList();
			DataEntityList newDebtors = new DataEntityList();

			LOGGER.logDebug("Declaracion de variables");
			String idRequested = originalHeader.get(OriginalHeader.IDREQUESTED) == null ? "" : originalHeader.get(OriginalHeader.IDREQUESTED);
			String operationNumber = originalHeader.get(OriginalHeader.OPNUMBERBANK) == null ? "" : originalHeader.get(OriginalHeader.OPNUMBERBANK);

			String acronymRule = generalParameters.get(new Property<String>("acronymRule", String.class, false));
			String idInstanceProcess = generalParameters.get(new Property<String>("idInstanceProcess", String.class, false));
			String idAsigActividad = generalParameters.get(new Property<String>("idAsigActividad", String.class, false));
			Integer idClient = generalParameters.get(new Property<Integer>("idClient", Integer.class, false));

			LOGGER.logDebug("Guardo en un mapa las operaciones seleccionadas");
			HashMap<String, DataEntity> hmOperationsSelected = new HashMap<String, DataEntity>();

			if (selectedOperations != null && !selectedOperations.isEmpty()) {
				for (DataEntity operation : selectedOperations) {
					if (!operationNumber.trim().equals(operation.get(RefinancingOperations.OPERATIONBANK).trim())) {
						LOGGER.logDebug("operationNumber_1--->" + operationNumber);
						LOGGER.logDebug("operationNumber_2--->" + operation.get(RefinancingOperations.OPERATIONBANK));
						hmOperationsSelected.put(operation.get(RefinancingOperations.OPERATIONBANK), operation);

						// Recupero los deudores a eliminar
						String idRequestedOperation = operation.get(new Property<String>("IdRequestedOperation", String.class, false));
						DataEntityList dataEntityList = debManagement.getDebtorsEntityList(Integer.valueOf(idRequestedOperation), arg1,
								new BehaviorOption(true));
						deleteDebtors.addAll(dataEntityList);

					} else {
						arg1.getMessageManager().showInfoMsg("BUSIN.DLB_BUSIN_MELETREEE_45019", null, 6000);
					}
				}
			}

			// Elimina las operaciones del tramite
			if (!idRequested.equals("")) {
				for (DataEntity operation : hmOperationsSelected.values()) {
					String bank = operation.get(RefinancingOperations.OPERATIONBANK);
					String creditType = operation.get(RefinancingOperations.CREDITTYPE);
					int idRequest = Integer.valueOf(idRequested);
					LOGGER.logDebug("Ejecuto el servicio");
					if (!revolvingManagment.deleteRenewDataByRequest(idRequest, bank, creditType, arg1, new BehaviorOption(false, false))) {
						arg1.getMessageManager().showSuccessMsg("DSGNR.SYS_DSGNR_LBLEXECOK_00003");
					}

					if (acronymRule != null && !acronymRule.equals("")) {
						RuleVersion ruleVersion = ruleExecutionManagement.readVersion(acronymRule, arg1, new BehaviorOption(true));
						queryStoredProcedureManagement.deleteExceptionToApprobal(arg1, new BehaviorOption(true),
								String.valueOf(ruleVersion.getRule().getId()), String.valueOf(ruleVersion.getId()), idInstanceProcess, idAsigActividad);
					}

					// arg1.getMessageManager().showSuccessMsg("BUSIN.DLB_BUSIN_SGCSLERER_06336", null, 6000);
				}
			}

			// Set de la entidad del listado de operaciones
			for (DataEntity operation : operations) {
				if (!hmOperationsSelected.containsKey(operation.get(RefinancingOperations.OPERATIONBANK))) {
					LOGGER.logDebug("operationNumber_3--->" + operation.get(RefinancingOperations.OPERATIONBANK));
					newOperations.add(operation);
				}
			}

			// Almaceno en mapa los deudores a eliminar excepto el deudor principal
			HashMap<Integer, DataEntity> hmDebtor = new HashMap<Integer, DataEntity>();
			for (DataEntity debtor : deleteDebtors) {
				if (!idClient.equals(debtor.get(DebtorGeneral.CUSTOMERCODE))) {
					hmDebtor.put(debtor.get(DebtorGeneral.CUSTOMERCODE), debtor);
				}
			}

			// Añado en una nueva lista los deudores
			for (DataEntity debtor : debtors) {
				if (!hmDebtor.containsKey(debtor.get(DebtorGeneral.CUSTOMERCODE))) {
					newDebtors.add(debtor);
				}
			}

			dynamicRequest.setEntityList(RefinancingOperations.ENTITY_NAME, newOperations);
			dynamicRequest.setEntityList(DebtorGeneral.ENTITY_NAME, newDebtors);
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.DELETE_GENERIC_63, e, arg1, LOGGER);
		}
		
		

	}
}
