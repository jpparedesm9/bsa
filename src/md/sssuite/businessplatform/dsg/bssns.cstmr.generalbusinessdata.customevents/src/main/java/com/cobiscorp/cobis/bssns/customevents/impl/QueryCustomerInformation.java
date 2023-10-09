package com.cobiscorp.cobis.bssns.customevents.impl;

import java.util.HashMap;

import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;

import com.cobiscorp.cobis.bssns.customevents.utils.Constants;
import com.cobiscorp.cobis.bssns.model.Customer;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;

public class QueryCustomerInformation extends BaseEvent implements IInitDataEvent {

	/**
	 * Instancia de Logger
	 */
	private static final ILogger LOGGER = LogFactory.getLogger(QueryCustomerInformation.class);

	private ICTSServiceIntegration serviceIntegration;

	public QueryCustomerInformation(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}

	@Override
	public void executeDataEvent(DynamicRequest arg0, IDataEventArgs arg1) {
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Inicia el evento QueryCustomerInformation");
			}

			DataEntity customer = arg0.getEntity(Customer.ENTITY_NAME);

			// Obtencion del id del cliente
			int customerId = getCustomerId(customer);

			if (customerId > 0) {
				getCustomerData(customerId, customer);
			} else {
				LOGGER.logError("No se pudo obtener el id del cliente");
			}

		} catch (Exception e) {
			LOGGER.logError("Error en la clase QueryCustomerInformation ---->", e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza el evento QueryCustomerInformation");
			}
		}

	}

	public int getCustomerId(DataEntity customer) {
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Inicia consulta del Id del Cliente");
			}
			// Obtencion de la instancia de proceso
			if (customer != null) {
				String processInstance = customer.get(Customer.PROCESSINSTANCE) != null
						? customer.get(Customer.PROCESSINSTANCE)
						: null;

				if (processInstance != null) {
					//Seteo de Request
					cobiscorp.ecobis.customerdatabusiness.dto.CustomerRequest customerRequest1 = new cobiscorp.ecobis.customerdatabusiness.dto.CustomerRequest();
					customerRequest1.setOperation(Constants.QUERY);
					customerRequest1.setProcessInstance(Integer.valueOf(processInstance));
					ServiceRequestTO request = new ServiceRequestTO();
					request.addValue(Constants.REQUEST_QUERY_CUSTOMER_ID, customerRequest1);
					
					//Ejecucion servicio
					ServiceResponse response = this.execute(LOGGER,
							Constants.GET_CUSTOMER_BY_PROCESS, request);
					//Obtencion del id del cliente
					ServiceResponseTO resultadoPep = (ServiceResponseTO) response.getData();
					HashMap<String, String> outputs = (HashMap<String, String>) resultadoPep
							.getValue("com.cobiscorp.cobis.cts.service.response.output");
					if (outputs != null) {
						LOGGER.logDebug("----->>@o_ente.."+outputs.get("@o_ente")+"----");
						 int customerId = Integer.parseInt(outputs.get("@o_ente"));	
						return customerId;
				       }
					
					
				} else {
					LOGGER.logError("Error al obtener la instancia de proceso: " + processInstance);
				}
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza consulta del Id del Cliente");
			}
		}catch(Exception e) {
			LOGGER.logError("Error en la ejecucion del servicio de consulta de Id de Cliente: ", e);
		}finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza consulta del Id del Cliente");
			}
		}
		

		return 0;
	}

	public void getCustomerData(int customerId, DataEntity customer) {
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Inicia consulta de informacion del Cliente");
			}
			
			CustomerRequest customerRequest = new CustomerRequest();
			customerRequest.setOperation(Constants.QUERY);
			customerRequest.setModo(0);
			customerRequest.setFormatDate(Constants.MM_DD_YYYY);
			customerRequest.setCustomerId(customerId);

			ServiceRequestTO request = new ServiceRequestTO();
			request.addValue(Constants.REQUEST_QUERY_CUSTOMER_ID, customerRequest);
			ServiceResponse response = this.execute(LOGGER,
					Constants.READ_DATA_CUSTOMER, request);

			if (response != null) {
				if (response.isResult()) {
					ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
					CustomerResponse customerResponseFirstPart = (CustomerResponse) resultado
							.getValue("returnCustomerResponse");
					customer.set(Customer.CUSTOMERID, customerId);
					customer.set(Customer.CUSTOMERIDENTIFICATION, customerResponseFirstPart.getCustomerIdentificaction());
					customer.set(Customer.CUSTOMERNAME, customerResponseFirstPart.getCustomerName());
					customer.set(Customer.CUSTOMERSECONDNAME, customerResponseFirstPart.getCustomerSecondName());
					customer.set(Customer.CUSTOMERLASTNAME, customerResponseFirstPart.getCustomerLastName());
					customer.set(Customer.CUSTOMERSECONDNAME, customerResponseFirstPart.getCustomerSecondName());
					customer.set(Customer.CUSTOMERSECONDLASTNAME, customerResponseFirstPart.getCustomerSecondLastName());
					customer.set(Customer.CUSTOMERFULLNAME, customerResponseFirstPart.getCustomerFullName());
					customer.set(Customer.CUSTOMERMARITALSTATUS, customerResponseFirstPart.getCustomerMaritalStatus());
					customer.set(Customer.IDENTIFICATIONTYPE, customerResponseFirstPart.getIdentificationtype());
					customer.set(Customer.GENDER, customerResponseFirstPart.getGender());
					customer.set(Customer.NATIONALITYCOUNTRY, customerResponseFirstPart.getNationalityCountry());
					customer.set(Customer.NATIONALITYDESCRIPTION, customerResponseFirstPart.getNationalityDescription());
					customer.set(Customer.OFFICIAL, customerResponseFirstPart.getOfficial());
					customer.set(Customer.OFFICIALDESCRIPTION, customerResponseFirstPart.getOfficialDescription());
					customer.set(Customer.SANTANDERCODE, customerResponseFirstPart.getSantanderCode());
				} else {
					LOGGER.logError("Error al consultar los datos del cliente" + response.getMessages());
				}
			}
		}catch(Exception e) {
			LOGGER.logError("Error en la consulta de la informacion del Cliente: ",e);
		}finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza consulta de informacion del Cliente");
			}
		}
	}

}
