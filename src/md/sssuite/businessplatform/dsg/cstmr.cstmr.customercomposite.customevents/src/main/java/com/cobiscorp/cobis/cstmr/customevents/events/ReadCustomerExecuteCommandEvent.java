package com.cobiscorp.cobis.cstmr.customevents.events;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.CustomerManagerQuery;
import com.cobiscorp.cobis.cstmr.commons.events.GeneralFunction;
import com.cobiscorp.cobis.cstmr.commons.events.SearchAddressesByCustomer;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.commons.services.QueryCatalogStoredProcedureManagement;
import com.cobiscorp.cobis.cstmr.model.Context;
import com.cobiscorp.cobis.cstmr.model.CustomerTmp;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.cstmr.model.Parameters;
import com.cobiscorp.cobis.cstmr.model.Person;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.util.SessionUtil;

import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.ParameterManager;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ParameterReques;
import cobiscorp.ecobis.customerdatamanagement.dto.ParameterResponse;

public class ReadCustomerExecuteCommandEvent extends BaseEvent implements IExecuteCommand {
	private static final String RENAPO_STATE_VALIDATE = "S";
	private static final ILogger LOGGER = LogFactory.getLogger(ReadCustomerExecuteCommandEvent.class);

	public ReadCustomerExecuteCommandEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		Map<String, Object> result = new HashMap();
		String mesage = "";

		LOGGER.logDebug("Start ReadCustomerExecuteCommandEvent in executeCommand>>");
		
		ParameterManager parameterManagement = new ParameterManager(getServiceIntegration());
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse parameterDto;
		String paraVPMAIL = "N";

        try {
        	LOGGER.logInfo("consulta de parametro: VPMAIL");
			parameterDto = parameterManagement.getParameter(4, "VPMAIL", "CLI", args);
			LOGGER.logInfo("valor de parametro VPMAIL: " + parameterDto.getParameterValue());
			paraVPMAIL = parameterDto.getParameterValue();
			
			DataEntity addressEntity = entities
					.getEntity(CustomerTmp.ENTITY_NAME);
			
			addressEntity.set(CustomerTmp.PARAMVAMAIL, paraVPMAIL);
        } catch (Exception e) {
			ExceptionUtils.showError("Error al consultar parámetro VPMAIL", e, args, LOGGER);
		}

		CustomerManagerQuery customerManagerQuery = new CustomerManagerQuery(getServiceIntegration(), Parameter.MODECUSTOMER.TOTAL);
		try {
			result = customerManagerQuery.getCustomerInfo(entities);
			mesage = GeneralFunction.getMessageError((List) result.get("MESSAGESERVERLIST"), (List) result.get("MESSAGEVALIDATIONLIST"));
			if (!"".equals(mesage)) {
				args.getMessageManager().showErrorMsg(mesage);
			} else {
				LOGGER.logDebug("entro>>");
				LoadEconomicActivities loadEconomicActivitiesList = new LoadEconomicActivities(getServiceIntegration());
				loadEconomicActivitiesList.loadEconomicActivities(entities);
				// Carga de Direcciones
				SearchAddressesByCustomer searchAddresses = new SearchAddressesByCustomer(getServiceIntegration());
				searchAddresses.searchAddressesByCustomer(entities, args);

				// Ejecutar consulta de mensajes de Activacion del Cliente
				QueryActivationClients queryActivationClients = new QueryActivationClients(getServiceIntegration());
				queryActivationClients.activationClients(entities, args);
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.READ_CUSTOMER, e, args, LOGGER);
		}
		// readMinimumAgeParameter(entities);
		// readIDExpirationParameter(entities);
		readParameters(entities, args);
	}

	public void readMinimumAgeParameter(DynamicRequest entities) {
		ServiceRequestTO request = new ServiceRequestTO();
		LOGGER.logDebug("Start ReadMinimumAgeParameter>>>");

		DataEntity naturalPerson = entities.getEntity("Parameters");
		naturalPerson.set(Parameters.MINIMUMAGE, null);

		ParameterReques parameterRequest = new ParameterReques();
		parameterRequest.setOperation('Q');
		parameterRequest.setProduct("CLI");
		parameterRequest.setNemonic("EMRCLI");

		parameterRequest.setDateFormat(Integer.valueOf(101));
		request.addValue("inParameterReques", parameterRequest);

		ServiceResponse response = execute(LOGGER, "CustomerDataManagementService.Queries.ReadMinimumAgeParameter", request);
		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
			if (resultado.isSuccess()) {
				ParameterResponse[] parameterList = (ParameterResponse[]) resultado.getValue("returnParameterResponse");
				for (ParameterResponse item : parameterList) {
					naturalPerson.set(Parameters.MINIMUMAGE, item.getIntTypeParameter());
				}
			}
		}
	}

	public void readIDExpirationParameter(DynamicRequest entities) {
		ServiceRequestTO request = new ServiceRequestTO();

		DataEntity parameters = entities.getEntity("Parameters");
		parameters.set(Parameters.IDEXPIRATION, null);

		ParameterReques parameterRequest = new ParameterReques();
		parameterRequest.setOperation('Q');
		parameterRequest.setProduct("CLI");
		parameterRequest.setNemonic("FVDI");
		parameterRequest.setDateFormat(Integer.valueOf(101));
		request.addValue("inParameterReques", parameterRequest);

		ServiceResponse response = execute(LOGGER, "CustomerDataManagementService.Queries.ReadIdExpirationParameter", request);
		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
			if (resultado.isSuccess()) {
				ParameterResponse[] parameterList = (ParameterResponse[]) resultado.getValue("returnParameterResponse");
				for (ParameterResponse item : parameterList) {
					LOGGER.logDebug("item.getDateTypeParameter() --> ");
					LOGGER.logDebug(item.getDateTypeParameter());
					parameters.set(Parameters.IDEXPIRATION, item.getDateTypeParameter().getTime());
				}
			}
		}
	}

	public String ifRol(DynamicRequest entities, IExecuteCommandEventArgs args) {
		String roleEnabledQueryAccount = "N";
		try {
			DataEntity context = entities.getEntity(Context.ENTITY_NAME);
			String role;
			role = SessionUtil.getRol();
			LOGGER.logDebug("rol1 ---> " + role);

			/*CatalogManagement catalogManagement = new CatalogManagement(super.getServiceIntegration());
			CatalogResponse[] allItemsByTable = catalogManagement.getAllItemsByTable("cl_hab_func_consulta_cuenta", args, new BehaviorOption());

			LOGGER.logDebug("------>>>>------>>>>XXXXBandera:");
			for (CatalogResponse catalogResponse : allItemsByTable) {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("rol:" + catalogResponse.getCode().trim() + ", " + catalogResponse.getValue());
				if (catalogResponse.getCode().trim().equals(role)) {
					LOGGER.logDebug("------>>>>------>>>>Bandera, encontro igual y sale");
					roleEnabledQueryAccount = "S";
					break;

				}
			}*/

			QueryCatalogStoredProcedureManagement qcspm = new QueryCatalogStoredProcedureManagement(getServiceIntegration());
			List<CatalogDto> listCatalogDto = qcspm.getCatalogQuery("cl_hab_func_consulta_cuenta", "C", "0", args, new BehaviorOption(true));

			LOGGER.logDebug("------>>>>------>>>>XXXXBandera:");
			if (listCatalogDto != null) {
				for (CatalogDto catalogDto : listCatalogDto) {
					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("rol:" + catalogDto.getCode().trim() + ", " + catalogDto.getName());
					if (catalogDto.getCode().trim().equals(role)) {
						LOGGER.logDebug("------>>>>------>>>>Bandera, encontro igual y sale");
						roleEnabledQueryAccount = "S";
						break;
					}
				}
			}

			LOGGER.logDebug("------>>>>------>>>>Bandera que va: " + roleEnabledQueryAccount);
			LOGGER.logDebug("------>>>>------>>>>Rol que viene de pantalla: " + role);

			return roleEnabledQueryAccount;

		} catch (Exception e) {
			ExceptionUtils.showError("Problemas al encontrar el Rol", e, args, LOGGER);
		}
		return roleEnabledQueryAccount;
	}

	public String rolTrue(String catalogue,String type,String mode, IExecuteCommandEventArgs args) {
		String roleEnabled = "N";
		try {
			String role = SessionUtil.getRol();
			LOGGER.logDebug("rol pantalla---> " + role);

			QueryCatalogStoredProcedureManagement qcspm = new QueryCatalogStoredProcedureManagement(getServiceIntegration());
			List<CatalogDto> listCatalogDto = qcspm.getCatalogQuery(catalogue, type,mode, args, new BehaviorOption(true));

			LOGGER.logDebug("------>>>>------>>>>XXXXBandera Rol:");
			if (listCatalogDto != null) {
				for (CatalogDto catalogDto : listCatalogDto) {
					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("rol:" + catalogDto.getCode().trim() + ", " + catalogDto.getName());
					if (catalogDto.getCode().trim().equals(role)) {
						LOGGER.logDebug("------>>>>------>>>>Bandera Rol, encontro igual y sale");
						roleEnabled= "S";
						break;
					}
				}
			}

			LOGGER.logDebug("------>>>>------>>>>Bandera Rol que va: " + roleEnabled);
			LOGGER.logDebug("------>>>>------>>>>Rol que viene de pantalla: " + role);

			return roleEnabled;

		} catch (Exception e) {
			ExceptionUtils.showError("Problemas al encontrar el Rol", e, args, LOGGER);
		}
		return roleEnabled;
	}

	public String[] searchState(DynamicRequest entities, IExecuteCommandEventArgs args) {
		LOGGER.logDebug("****Inicia searchState*****");
		String[] states = null;
		try {
			Integer enteId = entities.getEntity(Person.ENTITY_NAME).get(Person.PERSONSECUENTIAL);
			LOGGER.logDebug("****enteId*****" + enteId);

			CustomerRequest customerRequest = new CustomerRequest();
			customerRequest.setOperation('Q');
			customerRequest.setModo(0);
			customerRequest.setType('C');
			customerRequest.setCustomerId(enteId);
			customerRequest.setFormatDate(101);

			ServiceRequestTO request = new ServiceRequestTO();
			request.addValue("inCustomerRequest", customerRequest);

			ServiceResponse response = this.execute(LOGGER, "CustomerDataManagementService.CustomerManagement.SearchState", request);
			
			if (response != null) {
				LOGGER.logDebug("------>>>>------>>>>XXXXEstados:");
				if (response.isResult()) {
					states = new String[2];
					ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
					CustomerResponse customerResponse = (CustomerResponse) resultado.getValue("returnCustomerResponse");
					LOGGER.logDebug("****response*****" + customerResponse);
					states[0] = customerResponse.getAddressState();
					LOGGER.logDebug("****AddressState*****" + customerResponse.getAddressState());
					states[1] = customerResponse.getMailState();
					LOGGER.logDebug("****MailState*****" + customerResponse.getMailState());
				}
			}
			LOGGER.logDebug("****States*****"+states);
			LOGGER.logDebug("****Finaliza searchState*****");

			return states;

		} catch (Exception e) {
			ExceptionUtils.showError("Problemas al encontrar el Rol", e, args, LOGGER);
		}
		return states;
	}

	public void readParameters(DynamicRequest entities, IExecuteCommandEventArgs args) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start ReadCustomerExecuteCommandEvent in readParameters");
		}
		// No se puede usar el import porque existe un ParameterResponse de otra clase
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse edadMax;
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse edadMin;
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse padre;
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse hijo;
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse conyugue;
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse unionLibre;
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse casado;
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse paisMx;

		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse edadMinima;
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse fechaExpiracion;

		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse dirResidencia;
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse dirNegocio;
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse RENAPO;
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse RENAPOBYCURP;
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse roleToUpdate;
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse collectiveDefault;
		cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse collectiveLevelDefault;

		ParameterManager parameterManagement = new ParameterManager(getServiceIntegration());
		DataEntity parameters = entities.getEntity("Parameters");
		// parameters.set(Parameters.IDEXPIRATION, null);
		// parameters.set(Parameters.MINIMUMAGE, null);
		DataEntity contextEntity = new DataEntity();

		Date dateTmp = null;
		SimpleDateFormat formatDate = new SimpleDateFormat("MM/dd/yyyy");

		try {

			edadMinima = parameterManagement.getParameter(4, "EMRCLI", "CLI", args);
			LOGGER.logDebug("edad minima Customer " + edadMinima.getParameterValue());
			fechaExpiracion = parameterManagement.getParameter(4, "FVDI", "CLI", args);
			LOGGER.logDebug("fecha expiracion>> " + fechaExpiracion.getParameterValue());

			edadMax = parameterManagement.getParameter(4, "EMAX", "CLI", args);
			LOGGER.logDebug("edad maxima Customer " + edadMax.getParameterValue());

			edadMin = parameterManagement.getParameter(4, "MDE", "ADM", args);
			padre = parameterManagement.getParameter(4, "PAD", "CLI", args);
			LOGGER.logDebug("padre Customer " + padre.getParameterValue());
			hijo = parameterManagement.getParameter(4, "HIJ", "CLI", args);
			conyugue = parameterManagement.getParameter(4, "CONY", "CLI", args);
			unionLibre = parameterManagement.getParameter(4, "UNL", "CLI", args);
			casado = parameterManagement.getParameter(4, "CDA", "CLI", args);
			paisMx = parameterManagement.getParameter(4, "CP", "ADM", args);

			dirResidencia = parameterManagement.getParameter(4, "TDRE", "CLI", args);
			dirNegocio = parameterManagement.getParameter(4, "TDNE", "CLI", args);
			RENAPO = parameterManagement.getParameter(4, "RENAPO", "CLI", args);
			roleToUpdate = parameterManagement.getParameter(4, "RMCRF", "CLI", args);
			collectiveDefault = parameterManagement.getParameter(4, "CDDFCL", "CLI", args);
			collectiveLevelDefault = parameterManagement.getParameter(4, "CDDFNC", "CLI", args);

			RENAPOBYCURP = parameterManagement.getParameter(4, "ACRXCR", "CLI", args);
			
			if (edadMinima != null) {
				LOGGER.logError("si hay  parametro - EMRCLI");
				parameters.set(Parameters.MINIMUMAGE, Integer.parseInt(edadMinima.getParameterValue()));

			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - EMRCLI");
				parameters.set(Parameters.MINIMUMAGE, 0);
			}

			LOGGER.logDebug("fechaExpiracion  date>>>" + fechaExpiracion.getParameterValue());
			dateTmp = formatDate.parse(fechaExpiracion.getParameterValue());

			if (fechaExpiracion != null) {
				parameters.set(Parameters.IDEXPIRATION, dateTmp);
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - FVDI");
				parameters.set(Parameters.IDEXPIRATION, null);
			}

			if (edadMax != null) {
				LOGGER.logDebug("parametro edad max >>>" + Integer.parseInt(edadMax.getParameterValue()));
				contextEntity.set(Context.MAXIMUMAGE, Integer.parseInt(edadMax.getParameterValue()));
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - EMAX");
				contextEntity.set(Context.MAXIMUMAGE, 0);
			}
			if (edadMin != null) {
				contextEntity.set(Context.MINIMUMAGE, Integer.parseInt(edadMin.getParameterValue()));
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro -MDE ");
				contextEntity.set(Context.MINIMUMAGE, 0);
			}
			if (padre != null) {
				contextEntity.set(Context.PARENTS, Integer.parseInt(padre.getParameterValue()));
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - 211");
				contextEntity.set(Context.PARENTS, 0);
			}
			if (hijo != null) {
				contextEntity.set(Context.SON, Integer.parseInt(hijo.getParameterValue()));
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - 210");
				contextEntity.set(Context.SON, 0);
			}
			if (conyugue != null) {
				contextEntity.set(Context.COUPLE, conyugue.getParameterValue());
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - 209");
				contextEntity.set(Context.COUPLE, "0");
			}
			if (unionLibre != null) {
				contextEntity.set(Context.FREEUNION, unionLibre.getParameterValue());
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - UNL");
				contextEntity.set(Context.FREEUNION, "0");
			}
			if (casado != null) {
				contextEntity.set(Context.MARRIED, casado.getParameterValue());
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - CDA");
				contextEntity.set(Context.MARRIED, "0");
			}
			if (paisMx != null) {
				contextEntity.set(Context.FLAG1, Integer.parseInt(paisMx.getParameterValue()));
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - CP");
				contextEntity.set(Context.FLAG1, 0);
			}

			if (dirResidencia != null) {
				contextEntity.set(Context.FLAG2, dirResidencia.getParameterValue());
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - TDRE");
				contextEntity.set(Context.FLAG2, "0");
			}
			if (dirNegocio != null) {
				contextEntity.set(Context.FLAG3, dirNegocio.getParameterValue());
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - TDNE");
				contextEntity.set(Context.FLAG3, "0");
			}

			if (RENAPO == null) {
				LOGGER.logError("----->>>No hay informacion para el parametro - RENAPO");
				contextEntity.set(Context.RENAPO, "N");
			} else {
				contextEntity.set(Context.RENAPO, RENAPO.getParameterValue());
			}

			if (RENAPOBYCURP == null) {
				LOGGER.logError("----->>>No hay informacion para el parametro - ACRXCR");
				contextEntity.set(Context.RENAPOBYCURP, "N");
			} else {
				contextEntity.set(Context.RENAPOBYCURP, RENAPOBYCURP.getParameterValue());
			}
			
			if (roleToUpdate != null) {
				DataEntity customer = entities.getEntity(NaturalPerson.ENTITY_NAME);
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("ROL DEL USUARIO: " + SessionUtil.getRol());
					LOGGER.logDebug("ROL DEL PARAMETRO: " + roleToUpdate.getParameterValue());
					LOGGER.logDebug("ESTADO RENAPO: " + customer.get(NaturalPerson.BIORENAPORESULT));
				}

				if (!RENAPO_STATE_VALIDATE.equals(customer.get(NaturalPerson.BIORENAPORESULT)) && SessionUtil.getRol().equals(roleToUpdate.getParameterValue())) {
					parameters.set(Parameters.ALLOWUPDATENAMES, true);
				} else {
					parameters.set(Parameters.ALLOWUPDATENAMES, false);
				}
			}

			if (collectiveDefault != null) {
				contextEntity.set(Context.COLLECTIVE, collectiveDefault.getParameterValue());
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - CDDFCL");
				contextEntity.set(Context.COLLECTIVE, "I");
			}
			
			if (collectiveLevelDefault != null) {
				contextEntity.set(Context.COLLECTIVELEVEL, collectiveLevelDefault.getParameterValue());
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - CDDFNC");
				contextEntity.set(Context.COLLECTIVELEVEL, "O");
			}
			
			String roleEnabledQueryAccount = ifRol(entities, args);
			contextEntity.set(Context.ROLEENABLEDQUERYACCOUNT, roleEnabledQueryAccount);

			String roleEnabledDataModRequest = rolTrue("cr_rol_sol_mod_dat", "C", "0", args);
			contextEntity.set(Context.ROLEENABLEDDATAMODREQUEST, roleEnabledDataModRequest);
	                
                        String[] states = searchState(entities, args);
			if (states != null) {
				contextEntity.set(Context.ADDRESSSTATE, states[0]);
				contextEntity.set(Context.MAILSTATE, states[1]);
			} else {
				LOGGER.logError("----->>>No hay informacion para estados de direccion y mail");
				contextEntity.set(Context.ADDRESSSTATE, "N");
				contextEntity.set(Context.MAILSTATE, "N");
			}
			entities.setEntity(Context.ENTITY_NAME, contextEntity);
			entities.setEntity(Parameters.ENTITY_NAME, parameters);

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.READ_PARAMETERS, e, args, LOGGER);
		}
	}
}
