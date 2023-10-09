package com.cobiscorp.cobis.cstmr.customevents.events;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
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
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoResponse;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

/**
 * Created by ntrujillo on 05/07/2017.
 */
public class QueryRenapo extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(QueryRenapo.class);

	public QueryRenapo(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest dynamicRequest, IExecuteCommandEventArgs iExecuteCommandEventArgs) {
		String INFO = "QueryRenapo - executeCommand -->> ";

		DataEntity naturalPerson = dynamicRequest.getEntity(NaturalPerson.ENTITY_NAME);
		String initialStatus = naturalPerson.get(NaturalPerson.BIORENAPORESULT);

		try {

			RenapoResponse renapoResponse = null;
			BiometricManager biometricManager = new BiometricManager(getServiceIntegration());
			String status = "";

			LOGGER.logDebug(INFO + "Entidad naturalPerson: " + naturalPerson);

			ParameterManager parameterManager = new ParameterManager(getServiceIntegration());

			if (naturalPerson != null && naturalPerson.get(NaturalPerson.DOCUMENTNUMBER) != null) {

				ParameterResponse actRENAPOQueryByCurp = parameterManager.getParameter(4, "ACRXCR", "CLI", iExecuteCommandEventArgs);
				LOGGER.logDebug(INFO + "Parametro Por Curp ACRXCR: " + actRENAPOQueryByCurp.getParameterValue());

				if (Parameter.ACTIVE.contentEquals(actRENAPOQueryByCurp.getParameterValue())) {
					if (naturalPerson.get(NaturalPerson.PERSONSECUENTIAL) == null || naturalPerson.get(NaturalPerson.PERSONSECUENTIAL) == 0) {
						RenapoRequest renapoRequest = new RenapoRequest();
						renapoRequest.setCurp(naturalPerson.get(NaturalPerson.DOCUMENTNUMBER));
						renapoResponse = biometricManager.queryRenapoByCurp(renapoRequest);

						LOGGER.logDebug(INFO + "renapoResponse: " + renapoResponse.toString());

						if (renapoResponse.getCurp() == null || "".equals(renapoResponse.getCurp().trim())) {
							iExecuteCommandEventArgs.setSuccess(false);
							// Movil: La CURP indicada no muestra ningún resultado. Por favor revisar la
							// información capturada y reintenta nuevamente
							iExecuteCommandEventArgs.getMessageManager().showErrorMsg("No se encontro información para: " + renapoRequest.getCurp());
							// iExecuteCommandEventArgs.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_IEJTAITMT_92625");
							// iExecuteCommandEventArgs.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_IEJTAITMT_92625",
							// null, true);
							naturalPerson.set(NaturalPerson.FIRSTNAME, "");
							naturalPerson.set(NaturalPerson.SECONDNAME, "");
							naturalPerson.set(NaturalPerson.SURNAME, "");
							naturalPerson.set(NaturalPerson.SECONDSURNAME, "");
							naturalPerson.set(NaturalPerson.GENDERCODE, ' ');
							naturalPerson.set(NaturalPerson.BIRTHDATE, null);
							naturalPerson.set(NaturalPerson.COUNTYOFBIRTH, null);
							naturalPerson.set(NaturalPerson.BIORENAPORESULT, "");

						} else {
							SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");
							Date birthDate = null;
							if (renapoResponse.getBirthDate() != null)
								birthDate = formatDate.parse(renapoResponse.getBirthDate());
							
							char sex = ' ';
							if (renapoResponse.getSex() != null)
								sex = renapoResponse.getSex().charAt(0);

							// Mapeo de Datos
							naturalPerson.set(NaturalPerson.FIRSTNAME, renapoResponse.getName());
							naturalPerson.set(NaturalPerson.SECONDNAME, renapoResponse.getSecondName());
							naturalPerson.set(NaturalPerson.SURNAME, renapoResponse.getLastName());
							naturalPerson.set(NaturalPerson.SECONDSURNAME, renapoResponse.getSecondLastName());

							naturalPerson.set(NaturalPerson.GENDERCODE, sex);
							naturalPerson.set(NaturalPerson.BIRTHDATE, birthDate);
							naturalPerson.set(NaturalPerson.COUNTYOFBIRTH, Integer.parseInt(renapoResponse.getBirthPlace()));

							status = renapoResponse.getStatus() == null || "".equals(renapoResponse.getStatus().trim()) ? Parameter.RENAPO_PENDING : renapoResponse.getStatus().trim();
							naturalPerson.set(NaturalPerson.BIORENAPORESULT, status);
							LOGGER.logDebug(INFO + "naturalPerson: " + naturalPerson.getData());
						}
					} else
						iExecuteCommandEventArgs.getMessageManager().showInfoMsg("No se puede consultar a RENAPO, secuencial generado");
				} else {
					iExecuteCommandEventArgs.setSuccess(false);
					iExecuteCommandEventArgs.getMessageManager().showErrorMsg("Consulta RENAPO por CURP, desactivado");
				}
			} else {
				iExecuteCommandEventArgs.setSuccess(false);
				iExecuteCommandEventArgs.getMessageManager().showErrorMsg("Ingrese el número de documento");
			}

		} catch (Exception e) {
			naturalPerson.set(NaturalPerson.BIORENAPORESULT, initialStatus);
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.LOAD_BURO, e, iExecuteCommandEventArgs, LOGGER);
		}
	}

}
