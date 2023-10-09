package com.cobiscorp.cobis.cstmr.customevents.events;

import java.text.SimpleDateFormat;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.CustomerManager;
import com.cobiscorp.cobis.cstmr.commons.events.QueryBureauManager;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.busin.model.RenapoRequest;
import com.cobiscorp.ecobis.business.commons.platform.services.BiometricManager;
import com.cobiscorp.ecobis.business.commons.platform.services.ParameterManager;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoMessage;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoResponse;
import com.cobiscorp.ecobis.customer.prospect.commons.utils.MapEntities;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

/**
 * Created by ntrujillo on 05/07/2017.
 */
public class QueryBureau extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(QueryBureau.class);

	public QueryBureau(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest dynamicRequest, IExecuteCommandEventArgs iExecuteCommandEventArgs) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start executeCommand in QueryBureau");
		String INFO = "Prospect - QueryBureau - executeCommand -->> ";

		DataEntity naturalPerson = dynamicRequest.getEntity(NaturalPerson.ENTITY_NAME);
		String initialStatus = naturalPerson.get(NaturalPerson.BIORENAPORESULT);

		try {
			CustomerTotalRequest customerTotalRequest = new CustomerTotalRequest();
			CustomerManager customerManager = new CustomerManager(getServiceIntegration());
			QueryBureauManager queryBureauManager = new QueryBureauManager(getServiceIntegration());

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(INFO + "naturalPerson " + naturalPerson);
			}

			if (naturalPerson != null && naturalPerson.get(NaturalPerson.PERSONSECUENTIAL) != null) {

				ParameterManager parameterManager = new ParameterManager(getServiceIntegration());
				ParameterResponse renapo = parameterManager.getParameter(4, "RENAPO", "CLI", iExecuteCommandEventArgs);
				ParameterResponse paramActRENAPOQueryByCurp = parameterManager.getParameter(4, "ACRXCR", "CLI", iExecuteCommandEventArgs);

				LOGGER.logDebug(INFO + "Parametros: RENAPO: " + renapo.getParameterValue() + "-->>Activar consulta RENAPO por Curp: " + paramActRENAPOQueryByCurp.getParameterValue());

				if (Parameter.RENAPO_ACTIVE.equals(renapo.getParameterValue()) && Parameter.INACTIVE.equals(paramActRENAPOQueryByCurp.getParameterValue()) && !Parameter.RENAPO_VALIDATED.equals(naturalPerson.get(NaturalPerson.BIORENAPORESULT))) {

					BiometricManager biometricManager = new BiometricManager(getServiceIntegration());
					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
					customerTotalRequest = MapEntities.mapNaturalPersonForRenapo(naturalPerson, renapo.getParameterValue(), 1);

					StringBuilder name = new StringBuilder();
					name.append(naturalPerson.get(NaturalPerson.FIRSTNAME));
					name.append(naturalPerson.get(NaturalPerson.SECONDNAME) == null || naturalPerson.get(NaturalPerson.SECONDNAME).trim().equals("") ? "" : " " + naturalPerson.get(NaturalPerson.SECONDNAME));

					Character gender = naturalPerson.get(NaturalPerson.GENDERCODE) == null ? null : naturalPerson.get(NaturalPerson.GENDERCODE).charValue();

					RenapoRequest renapoRequest = new RenapoRequest();
					renapoRequest.setBirthDate(sdf.format(naturalPerson.get(NaturalPerson.BIRTHDATE)));
					renapoRequest.setBirthPlace(String.valueOf(naturalPerson.get(NaturalPerson.COUNTYOFBIRTH)));
					renapoRequest.setName(name.toString());
					renapoRequest.setLastName(naturalPerson.get(NaturalPerson.SURNAME));
					renapoRequest.setSecondLastName(naturalPerson.get(NaturalPerson.SECONDSURNAME));
					renapoRequest.setGender(String.valueOf(gender));

					LOGGER.logDebug("RenapoRequest [" + renapoRequest.toString() + "]");

					RenapoResponse renapoResponse = biometricManager.queryCurpFromRenapo(renapoRequest);

					String curp = renapoResponse.getCurp() == null || "".equals(renapoResponse.getCurp().trim()) ? naturalPerson.get(NaturalPerson.DOCUMENTNUMBER) : renapoResponse.getCurp().trim();
					String status = renapoResponse.getStatus() == null || "".equals(renapoResponse.getStatus().trim()) ? Parameter.RENAPO_PENDING : renapoResponse.getStatus().trim();
					customerTotalRequest.setIdentification(curp);
					customerTotalRequest.setCheckRenapo(status);

					// Se vuelve a enviar debido a que no actualizo
					LOGGER.logInfo("------->>>prospecto: Inicia caso#146875-status:" + status + "---");
					customerTotalRequest.setName(naturalPerson.get(NaturalPerson.FIRSTNAME));
					customerTotalRequest.setSecondName(naturalPerson.get(NaturalPerson.SECONDNAME));
					customerTotalRequest.setFirstSurname(naturalPerson.get(NaturalPerson.SURNAME));
					customerTotalRequest.setSecondSurname(naturalPerson.get(NaturalPerson.SECONDSURNAME));
					customerTotalRequest.setGender(naturalPerson.get(NaturalPerson.GENDERCODE));
					LOGGER.logInfo("------->>>prospecto: caso#146875-FIRSTNAME:" + customerTotalRequest.getName());
					LOGGER.logInfo("------->>>prospecto: caso#146875-SECONDNAME:" + customerTotalRequest.getSecondName());
					LOGGER.logInfo("------->>>prospecto: caso#146875-SURNAME:" + customerTotalRequest.getFirstSurname());
					LOGGER.logInfo("------->>>prospecto: caso#146875-SECONDSURNAME:" + customerTotalRequest.getSecondSurname());

					customerManager.updateCustomerRENAPO(customerTotalRequest, iExecuteCommandEventArgs);
					if (iExecuteCommandEventArgs.isSuccess()) {
						if (Parameter.RENAPO_VALIDATED.equals(status)) {
							queryBureauManager.queryBureau(dynamicRequest, iExecuteCommandEventArgs, "PROSPECT");
						} else {
							iExecuteCommandEventArgs.setSuccess(false);
							iExecuteCommandEventArgs.getMessageManager().showErrorMsg(Parameter.RENAPO_ERROR_MSG);
							for (RenapoMessage message : renapoResponse.getMessages()) {
								iExecuteCommandEventArgs.getMessageManager().showErrorMsg(message.getMessage());
							}
						}
						naturalPerson.set(NaturalPerson.DOCUMENTNUMBER, curp);
						naturalPerson.set(NaturalPerson.BIORENAPORESULT, status);
					}

				} else {
					LOGGER.logDebug(INFO + "El cliente: " + naturalPerson.get(NaturalPerson.PERSONSECUENTIAL) + " ya debio ser consultado a RENAPO o RENAPO esta desactivado");
					queryBureauManager.queryBureau(dynamicRequest, iExecuteCommandEventArgs, "PROSPECT");
				}
			} else {
				iExecuteCommandEventArgs.setSuccess(false);
				iExecuteCommandEventArgs.getMessageManager().showErrorMsg("PRIMERO DEBE GUARDAR LA INFORMACIÓN");
			}
		} catch (Exception e) {
			naturalPerson.set(NaturalPerson.BIORENAPORESULT, initialStatus);
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.LOAD_BURO, e, iExecuteCommandEventArgs, LOGGER);
		}
	}

}
