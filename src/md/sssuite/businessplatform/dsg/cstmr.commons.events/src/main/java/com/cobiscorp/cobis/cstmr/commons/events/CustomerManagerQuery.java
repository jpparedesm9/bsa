package com.cobiscorp.cobis.cstmr.commons.events;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.model.ComplementaryRequestData;
import com.cobiscorp.cobis.cstmr.model.DemographicData;
import com.cobiscorp.cobis.cstmr.model.EconomicInformation;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.cstmr.model.Person;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class CustomerManagerQuery extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(CustomerManagerQuery.class);

	private Parameter.MODECUSTOMER typeSaveCustomer;

	public CustomerManagerQuery(ICTSServiceIntegration serviceIntegration, Parameter.MODECUSTOMER modeCustomer) {
		super(serviceIntegration);
		this.typeSaveCustomer = modeCustomer;
	}

	public Map<String, Object> getCustomerInfo(DynamicRequest entities) {
		Map<String, Object> result = new HashMap<String, Object>();

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(" INICIO GETCUSTOMERINFO==> ");
		}

		Integer personCode = 0;
		// try {
		switch (this.typeSaveCustomer) {
		case DEMOGRAPHIC:
			personCode = entities.getEntity(DemographicData.ENTITY_NAME).get(DemographicData.PERSONSECUENTIAL);
			break;
		case ECONOMIC:
			personCode = entities.getEntity(EconomicInformation.ENTITY_NAME).get(EconomicInformation.PERSONSECUENTIAL);
			break;
		case INFOGENERAL:
		case TOTAL:
			// LOGGER.logDebug("Entidad==> "+ personCode);
			personCode = entities.getEntity(NaturalPerson.ENTITY_NAME).get(NaturalPerson.PERSONSECUENTIAL);

			entities.getEntity(Person.ENTITY_NAME).set(Person.PERSONSECUENTIAL, personCode);
			break;
		default:
			break;
		}

		// First-Part
		CustomerRequest customerRequest = new CustomerRequest();
		customerRequest.setOperation('Q');
		customerRequest.setModo(0);
		customerRequest.setFormatDate(101);
		customerRequest.setCustomerId(personCode);

		result = getCustomerInfoFirstPart(entities, customerRequest);

		// Second-Part
		customerRequest.setModo(1);
		result = getCustomerInfoSecondPart(entities, customerRequest);

		LOGGER.logDebug("resultExecution" + result);
		/*
		 * } catch (Exception e) { LOGGER.logDebug(
		 * "CustomerQueryBaseEvent.getCustomerInfo(..) -> Exception = " +
		 * e.getStackTrace());
		 * 
		 * resultExecution=false; }
		 */
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(" FIN GETCUSTOMERINFO==> ");
		}
		return result;

	}

	private Map<String, Object> getCustomerInfoFirstPart(DynamicRequest entities, CustomerRequest customerRequest) {

		Map<String, Object> result = new HashMap<String, Object>();

		ServiceRequestTO request = new ServiceRequestTO();
		request.addValue("inCustomerRequest", customerRequest);

		ServiceResponse response = this.execute(LOGGER, "CustomerDataManagementService.CustomerManagement.ReadDataCustomer", request);
		ServiceResponse response1 = this.execute(LOGGER, "CustomerDataManagementService.CustomerManagement.SearchPepPerson", request);
		String esPep = null;
		String chargePep = null;
		if (response1 != null) {
			if (response1.isResult()) {
				ServiceResponseTO resultadoPep = (ServiceResponseTO) response1.getData();
				HashMap<String, String> outputs = (HashMap<String, String>) resultadoPep.getValue("com.cobiscorp.cobis.cts.service.response.output");
				if (outputs != null) {
					esPep = outputs.get("@o_es_pep").trim();
					chargePep = outputs.get("@o_puesto").trim();
					LOGGER.logDebug("----->>esPep.." + esPep + "----");
					LOGGER.logDebug("----->>chargePep.." + chargePep + "----");

			       }

		  }
		}
		if (response != null) {
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
				CustomerResponse customerResponseFirstPart = (CustomerResponse) resultado.getValue("returnCustomerResponse");
				customerResponseFirstPart.setCustomerId(customerRequest.getCustomerId());
				customerResponseFirstPart.setPepPerson(esPep);
				customerResponseFirstPart.setChargePub(chargePep == null ? "N" : chargePep);
				LOGGER.logDebug("----->>customerResponseFirstPart.getPepPerson().." + customerResponseFirstPart.getPepPerson() + "----");
				LOGGER.logDebug("----->>customerResponseFirstPart.getChargePub().." + customerResponseFirstPart.getChargePub() + "----");

				loadCustomerInfo(entities, customerResponseFirstPart, '1');
			} else {
				result.put(Parameter.MESSAGESERVERLIST, response.getMessages());
			}
		}
		return result;
	}

	private Map<String, Object> getCustomerInfoSecondPart(DynamicRequest entities, CustomerRequest customerRequest) {
		Map<String, Object> result = new HashMap<String, Object>();
		ServiceRequestTO request = new ServiceRequestTO();

		request.addValue("inCustomerRequest", customerRequest);

		ServiceResponse response = this.execute(LOGGER, "CustomerDataManagementService.CustomerManagement.ReadCustomerInfo", request);
		ServiceResponse response1 = this.execute(LOGGER, "CustomerDataManagementService.CustomerManagement.SearchPepPerson", request);
		String esPep = null;
		String chargePep = null;
		if (response1 != null) {
			if (response1.isResult()) {
				ServiceResponseTO resultadoPep = (ServiceResponseTO) response1.getData();
				HashMap<String, String> outputs = (HashMap<String, String>) resultadoPep.getValue("com.cobiscorp.cobis.cts.service.response.output");
				if (outputs != null) {
					esPep = outputs.get("@o_es_pep").trim();
					chargePep = outputs.get("@o_puesto").trim();
					LOGGER.logDebug("----->>esPep2.." + esPep + "----");
					LOGGER.logDebug("----->>chargePep2.." + chargePep + "----");

			       }

		  }
		}

		if (response != null) {
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();

				CustomerResponse customerResponseSecondPart = (CustomerResponse) resultado.getValue("returnCustomerResponse");
				customerResponseSecondPart.setPepPerson(esPep);
				customerResponseSecondPart.setChargePub(chargePep);
				LOGGER.logDebug("----->>customerResponseSecondPart.getPepPerson().." + customerResponseSecondPart.getPepPerson() + "----");
				LOGGER.logDebug("----->>customerResponseSecondPart.getChargePub().." + customerResponseSecondPart.getChargePub() + "----");

				loadCustomerInfo(entities, customerResponseSecondPart, '2');
			} else {
				result.put(Parameter.MESSAGESERVERLIST, response.getMessages());
			}
		}
		return result;
	}

	private void loadCustomerInfo(DynamicRequest entities, CustomerResponse customerResponse, char part) {

		DataEntity naturalPerson = entities.getEntity(NaturalPerson.ENTITY_NAME);
		DataEntity demographicData = entities.getEntity(DemographicData.ENTITY_NAME);
		DataEntity economicInformation = entities.getEntity(EconomicInformation.ENTITY_NAME);
		DataEntity complementaryData = entities.getEntity(ComplementaryRequestData.ENTITY_NAME);

		DataEntity person = entities.getEntity(Person.ENTITY_NAME);

		switch (this.typeSaveCustomer) {
		case INFOGENERAL:
			setGeneralInfo(customerResponse, naturalPerson, person, part);
			break;
		case DEMOGRAPHIC:
			setDemographicData(customerResponse, demographicData, part);
			break;
		case ECONOMIC:
			setEconomicInfo(customerResponse, economicInformation, part);
			break;

		case TOTAL:
			setGeneralInfo(customerResponse, naturalPerson, person, part);
			setDemographicData(customerResponse, demographicData, part);
			setEconomicInfo(customerResponse, economicInformation, part);
			setComplementaryData(customerResponse, complementaryData, part);

			break;
		default:
			break;
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("****fin de loadCustomerInfo*****");
		}

	}

	private void setGeneralInfo(CustomerResponse customerResponse, DataEntity naturalPerson, DataEntity person, char part) {
		try {
		if (part == '1') {
			SimpleDateFormat formatDate = new SimpleDateFormat("MM/dd/yyyy");
			Date birthDate = null;
			Date expirationDate = null;

				if (customerResponse.getCustomerBirthdate() != null) {
					birthDate = formatDate.parse(customerResponse.getCustomerBirthdate());
				}
				if (customerResponse.getExpirationDate() != null) {
					naturalPerson.set(NaturalPerson.INDEFINITE, false);
					expirationDate = formatDate.parse(customerResponse.getExpirationDate());
				} else {
					naturalPerson.set(NaturalPerson.INDEFINITE, true);
				}

			person.set(Person.TYPEPERSON, 'P');
			naturalPerson.set(NaturalPerson.PERSONSECUENTIAL, customerResponse.getCustomerId());
			naturalPerson.set(NaturalPerson.BIRTHDATE, birthDate);
			naturalPerson.set(NaturalPerson.DOCUMENTTYPE, customerResponse.getIdentificationtype());
			naturalPerson.set(NaturalPerson.SPOUSE, customerResponse.getCustomerFullName());

			naturalPerson.set(NaturalPerson.DOCUMENTNUMBER, customerResponse.getCustomerIdentificaction());
			naturalPerson.set(NaturalPerson.EXPIRATIONDATE, expirationDate);

			naturalPerson.set(NaturalPerson.FIRSTNAME, customerResponse.getCustomerName());
			naturalPerson.set(NaturalPerson.SECONDSURNAME, customerResponse.getCustomerSecondLastName());
			naturalPerson.set(NaturalPerson.SURNAME, customerResponse.getCustomerLastName());
			if (customerResponse.getGender() != null) {
				naturalPerson.set(NaturalPerson.GENDERCODE, customerResponse.getGender().charAt(0));
				}

				naturalPerson.set(NaturalPerson.MARITALSTATUSCODE, customerResponse.getCustomerMaritalStatus() != null ? customerResponse.getCustomerMaritalStatus().trim() : null);
			naturalPerson.set(NaturalPerson.OFFICERCODE, customerResponse.getOfficial());
			naturalPerson.set(NaturalPerson.BRANCHCODE, customerResponse.getOfficeOrigin());
				naturalPerson.set(NaturalPerson.SECONDNAME, customerResponse.getCustomerSecondName());
			naturalPerson.set(NaturalPerson.MARRIEDSURNAME, customerResponse.getMarriedLastName());
			naturalPerson.set(NaturalPerson.NATIONALITYCODE, customerResponse.getNationalityCountry());

				/* Mostrando nuevos valores */
			naturalPerson.set(NaturalPerson.IDENTIFICATIONRFC, customerResponse.getCustomerRFC());

			LOGGER.logDebug("Valor de getCustomerRFC: " + customerResponse.getCustomerRFC());
			LOGGER.logDebug("Numero de ciclos: " + customerResponse.getNumCycles());
			naturalPerson.set(NaturalPerson.CHARGEPUB, customerResponse.getChargePub());
			naturalPerson.set(NaturalPerson.RELCHARGEPUB, customerResponse.getRelChargePub());
			naturalPerson.set(NaturalPerson.COUNTYOFBIRTH, customerResponse.getCountyOfBirth());
			naturalPerson.set(NaturalPerson.NATIONALITYCODE, customerResponse.getCountryCode());
			naturalPerson.set(NaturalPerson.NATIONALITYCODEAUX, customerResponse.getNationalityCodeAux());
				naturalPerson.set(NaturalPerson.NUMCYCLES, customerResponse.getNumCycles());
				naturalPerson.set(NaturalPerson.MONTHSINFORCE, customerResponse.getMonthsInForce());
			LOGGER.logDebug("MONTHSINFORCE: " + customerResponse.getMonthsInForce());
				if (customerResponse.getMonthsInForce() == 1) {
				LOGGER.logDebug("Información No Vigente, por favor actualizar datos del cliente");
			}
				boolean publicPerson = "S".equals(customerResponse.getPublicPerson()) ? true : false;
				naturalPerson.set(NaturalPerson.PUBLICPERSON, publicPerson);

				LOGGER.logDebug("{88} >>" + customerResponse.getHasProblems());
				LOGGER.logDebug("{89} >>" + customerResponse.getMonthlyTrxAmount());
				LOGGER.logDebug("{90} >>" + customerResponse.getPepPerson());
			LOGGER.logDebug("RELCHARGEPUB: " + customerResponse.getRelChargePub());
			LOGGER.logDebug("PUBLICPERSON: " + customerResponse.getPublicPerson());

				boolean hasProblems = "S".equals(customerResponse.getHasProblems()) ? true : false;
				naturalPerson.set(NaturalPerson.HASPROBLEMS, hasProblems);

				boolean pepPerson = "S".equals(customerResponse.getPepPerson()) ? true : false;
				naturalPerson.set(NaturalPerson.PERSONPEP, pepPerson);

				LOGGER.logDebug(" se obtiene cuenta individual >>" + customerResponse.getAccountIndividual());

				naturalPerson.set(NaturalPerson.ACCOUNTINDIVIDUAL, customerResponse.getAccountIndividual());

				LOGGER.logDebug(" se obtiene el codigo santander >>" + customerResponse.getAccountIndividual());

			naturalPerson.set(NaturalPerson.SANTANDERCODE, customerResponse.getSantanderCode());
				// Para cambio de anadir el nombre e id del grupo
	        naturalPerson.set(NaturalPerson.IDGROUP, customerResponse.getIdGroup());
	        naturalPerson.set(NaturalPerson.NAMEGROUP, customerResponse.getNameGroup());
				LOGGER.logDebug(" Se obtiene customerResponse.getIdGroup()>>***" + customerResponse.getIdGroup());

				LOGGER.logDebug(" Se obtiene TecnologicalDegree >>" + customerResponse.getTechnologicalDegree());
			naturalPerson.set(NaturalPerson.TECHNOLOGICALDEGREE, customerResponse.getTechnologicalDegree());
			boolean hasPartner = "S".equals(customerResponse.getPartner());
	        naturalPerson.set(NaturalPerson.HASPARTNER, Boolean.valueOf(hasPartner));
	        boolean hasListBlack = "S".equals(customerResponse.getListBlack());
				naturalPerson.set(NaturalPerson.HASLISTBLACK, Boolean.valueOf(hasListBlack));
	        LOGGER.logDebug(" Se obtiene alert Staus" + customerResponse.getHasAlert());
	        naturalPerson.set(NaturalPerson.HASALERT, customerResponse.getHasAlert());
	        naturalPerson.set(NaturalPerson.EMAIL, customerResponse.getEmail());
naturalPerson.set(NaturalPerson.COLECTIVO, customerResponse.getColectivo());
	        naturalPerson.set(NaturalPerson.NIVELCOLECTIVO, customerResponse.getNivelColectivo());
	        

				// BIOMETRICO
				naturalPerson.set(NaturalPerson.BIOIDENTIFICATIONTYPE, customerResponse.getBioIdentificationType());
				naturalPerson.set(NaturalPerson.BIOCIC, customerResponse.getBioCIC());
				naturalPerson.set(NaturalPerson.BIOEMISSIONNUMBER, customerResponse.getBioEmissionNumber());
				naturalPerson.set(NaturalPerson.BIOOCR, customerResponse.getBioOCR());
				naturalPerson.set(NaturalPerson.BIOREADERKEY, customerResponse.getBioReaderKey());
				naturalPerson.set(NaturalPerson.BIOHASFINGERPRINT, customerResponse.getBioHasFingerprint() == null ? 'N' : customerResponse.getBioHasFingerprint().charAt(0));
				naturalPerson.set(NaturalPerson.BIORENAPORESULT, customerResponse.getCheckRenapo());
		} else if (part == '2') {

			naturalPerson.set(NaturalPerson.STATUSCODE, customerResponse.getStatus());
				if (customerResponse.getStatus() != null) {
				person.set(Person.STATUSCODE, customerResponse.getStatus().charAt(0));
				}
			naturalPerson.set(NaturalPerson.KNOWNAS, customerResponse.getKnownAs());

			LOGGER.logDebug("RISKLEVEL: " + customerResponse.getRiskLevel());
			LOGGER.logDebug("CREDITBUREAU: " + customerResponse.getCreditBureau());
				naturalPerson.set(NaturalPerson.RISKLEVEL, customerResponse.getRiskLevel());
			naturalPerson.set(NaturalPerson.INDIVIDUALRISK, customerResponse.getIndividualRisk());
				naturalPerson.set(NaturalPerson.CREDITBUREAU, customerResponse.getCreditBureau());

				LOGGER.logDebug("part2 {88} >>" + customerResponse.getHasProblems());
				LOGGER.logDebug("part2 {89} >>" + customerResponse.getMonthlyTrxAmount());
				LOGGER.logDebug("part2 {90} >>" + customerResponse.getPepPerson());

				boolean hasProblems = "S".equals(customerResponse.getHasProblems()) ? true : false;
				naturalPerson.set(NaturalPerson.HASPROBLEMS, hasProblems);

				boolean pepPerson = "S".equals(customerResponse.getPepPerson()) ? true : false;
				naturalPerson.set(NaturalPerson.PERSONPEP, pepPerson);

		}

		} catch (ParseException e) {
			LOGGER.logDebug("Error en setGeneralInfo" + e);
		}
	}

	private void setDemographicData(CustomerResponse customerResponse, DataEntity demographicData, char part) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("****inicio de setDemographicData *****");
		}
		if (part == '1') {

			demographicData.set(DemographicData.PERSONSECUENTIAL, customerResponse.getCustomerId());
			demographicData.set(DemographicData.PROFESSION, customerResponse.getProfession());
			demographicData.set(DemographicData.WHICHPROFESSION, customerResponse.getOtherProfession());
			demographicData.set(DemographicData.RESIDENCECOUNTRY, customerResponse.getCityBirth());
			demographicData.set(DemographicData.STUDIESLEVEL, customerResponse.getAcademicLevel());
			demographicData.set(DemographicData.HOUSINGTYPE, customerResponse.getCustomerHomeTypeId());
			// demographicData.set(DemographicData.HOUSINGTYPE,
			// customerResponse.getCustomerHomeType() == null ||
			// customerResponse.getCustomerHomeType().trim().isEmpty() ? "NA" :
			// customerResponse.getCustomerHomeType());
			demographicData.set(DemographicData.DEPENDENTS, customerResponse.getDependentsNum());

			/*
			 * if(customerResponse.getCustomerPayroll()!=null){
			 * demographicData.set(DemographicData.TEMPLATE,
			 * customerResponse.getCustomerPayroll().charAt(0)); } if
			 * (customerResponse.getHasDishability() != null &&
			 * !customerResponse.getHasDishability().isEmpty()) {
			 * demographicData.set(DemographicData.HASDISABILITY,
			 * customerResponse.getHasDishability().charAt(0)); }
			 */
			// LOGGER.logDebug("Tipo de discapacidad
			// 1>>>"+customerResponse.getDisabilityType());
			// demographicData.set(DemographicData.DISABILITYTYPE,
			// customerResponse.getDisabilityType());

		} else if (part == '2') {
			if (customerResponse.getCustomerPayroll() != null && !customerResponse.getCustomerPayroll().isEmpty()) {
				demographicData.set(DemographicData.TEMPLATE, customerResponse.getCustomerPayroll().charAt(0));
			}
			if (customerResponse.getHasDishability() != null && !customerResponse.getHasDishability().isEmpty()) {
				demographicData.set(DemographicData.HASDISABILITY, customerResponse.getHasDishability().charAt(0));
			}
			LOGGER.logDebug("Tipo de discapacidad 2>>>" + customerResponse.getDisabilityType());
			demographicData.set(DemographicData.DISABILITYTYPE, customerResponse.getDisabilityType());
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("****fin de setDemographicData *****");
			LOGGER.logDebug(demographicData.get(DemographicData.HOUSINGTYPE));
		}
	}

	private void setEconomicInfo(CustomerResponse customerResponse, DataEntity economicInfo, char part) {

		if (part == '1') {
			economicInfo.set(EconomicInformation.PERSONSECUENTIAL, customerResponse.getCustomerId());

			if (customerResponse.getRetention() != null) {
				economicInfo.set(EconomicInformation.RETENTIONSUBJECT, customerResponse.getRetention().charAt(0));
			}
			economicInfo.set(EconomicInformation.RELATIONID, customerResponse.getVinculationType());
			economicInfo.set(EconomicInformation.INTERNALQUALIFICATION, customerResponse.getQualifiedCustomer());

			/* Nuevos Valores */
			boolean hasOtherIncome = "S".equals(customerResponse.getHasOtherIncome()) ? true : false;
			economicInfo.set(EconomicInformation.HASOTHERINCOME, hasOtherIncome);

			economicInfo.set(EconomicInformation.OTHERINCOMESOURCE, customerResponse.getOtherIncomeSource());

		} else if (part == '2') {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("****economicInfo case 2*****");
			}
			economicInfo.set(EconomicInformation.MONTHLYINCOME, customerResponse.getIncomes());
			economicInfo.set(EconomicInformation.EXPENSELEVEL, customerResponse.getExpenses());// Cambiar
																								// nombre
																								// a
			// expenses

			economicInfo.set(EconomicInformation.TUTORID, customerResponse.getTutor());
			economicInfo.set(EconomicInformation.TUTORNAME, customerResponse.getTutorName());
			economicInfo.set(EconomicInformation.CATEGORYALM, customerResponse.getAmlCategory());// validar
																									// si
																				// es
																									// AMl
																									// o
																									// ALM
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("****MONTHLY INCOME*****" + economicInfo.get(EconomicInformation.MONTHLYINCOME));
				LOGGER.logDebug("****EconomicInformation.EXPENSELEVEL*****" + economicInfo.get(EconomicInformation.EXPENSELEVEL));
				LOGGER.logDebug("****EconomicInformation.CATEGORYALM*****" + economicInfo.get(EconomicInformation.CATEGORYALM));

			}

			LOGGER.logDebug(">>> Getting Economic Information Santander");
			LOGGER.logDebug("ASSETS>>>>" + customerResponse.getAssets());
			LOGGER.logDebug("LIABILITIES>>>>" + customerResponse.getLiabilities());
			economicInfo.set(EconomicInformation.ASSETS, customerResponse.getAssets());
			economicInfo.set(EconomicInformation.LIABILITIES, customerResponse.getLiabilities());
			economicInfo.set(EconomicInformation.OTHERINCOMES, customerResponse.getOtherIncomes());
			economicInfo.set(EconomicInformation.SALES, customerResponse.getSales());
			economicInfo.set(EconomicInformation.SALESCOST, customerResponse.getSalesCost());
			economicInfo.set(EconomicInformation.OPERATINGCOST, customerResponse.getOperativeCost());
			economicInfo.set(EconomicInformation.BUSINESSYEARS, customerResponse.getBusinessYears());
			economicInfo.set(EconomicInformation.BUSINESSINCOME, customerResponse.getBusinessIncome());
			LOGGER.logDebug("BusinessIncome>>>>" + customerResponse.getBusinessIncome());

			if (customerResponse.getMonthlyTrxAmount() != null) {
				economicInfo.set(EconomicInformation.MONTHLYTRXAMOUNT, customerResponse.getMonthlyTrxAmount().doubleValue());
			} else {
				LOGGER.logDebug("Transacciones mensuales es null");
			}

			boolean isLinked = "S".equals(customerResponse.getIsLinked()) ? true : false;

			economicInfo.set(EconomicInformation.ISLINKED, isLinked);

		}

	}

	private void setComplementaryData(CustomerResponse customerResponse, DataEntity complementaryData, char part) {

		try {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("****inicio de setComplementaryData *****");
				LOGGER.logDebug("****Pasaporte *****" + customerResponse.getCustomerPassport());
			}

			if (customerResponse.getIfeNumber() != null) {
				complementaryData.set(ComplementaryRequestData.IFENUMBER, customerResponse.getIfeNumber());
			}

			if (customerResponse.getCustomerPassport() != null) {
				complementaryData.set(ComplementaryRequestData.PASSPORTNUMBER, customerResponse.getCustomerPassport());
			}

			if (customerResponse.getElectronicSignature() != null) {
				complementaryData.set(ComplementaryRequestData.ELECTRONICSIGNATURE, customerResponse.getElectronicSignature());
			}

			if (customerResponse.getPhoneErrands() != null) {
				complementaryData.set(ComplementaryRequestData.PHONEERRANDS, customerResponse.getPhoneErrands());
			}

			if (customerResponse.getPersonNameMessages() != null) {
				complementaryData.set(ComplementaryRequestData.PERSONNAMEMESSAGES, customerResponse.getPersonNameMessages());
			}

			if (customerResponse.getBureauBackground() != null) {
				complementaryData.set(ComplementaryRequestData.BUREAUBACKGROUND, customerResponse.getBureauBackground());
			}

			if (customerResponse.getLandlineOne() != null) {
				complementaryData.set(ComplementaryRequestData.LANDLINEONE, customerResponse.getLandlineOne());
			}

			if (customerResponse.getLandlineTwo() != null) {
				complementaryData.set(ComplementaryRequestData.LANDLINETWO, customerResponse.getLandlineTwo());
			}
			
			if (customerResponse.getProfessionalActivity() != null) {
				complementaryData.set(ComplementaryRequestData.PROFESSIONALACTIVITY, customerResponse.getProfessionalActivity());
			} else if ((customerResponse.getProfessionalActivity() == null || "".equals(customerResponse.getProfessionalActivity())) && 
					(complementaryData.get(ComplementaryRequestData.PROFESSIONALACTIVITY) == null ||
					"".equals(complementaryData.get(ComplementaryRequestData.PROFESSIONALACTIVITY)))) {
				complementaryData.set(ComplementaryRequestData.PROFESSIONALACTIVITY, "000"); // "Ninguno" por default
			}
			
			if (customerResponse.getIsCryptoUsed() != null) {
				complementaryData.set(ComplementaryRequestData.ISCRYPTOUSED, customerResponse.getIsCryptoUsed());
			}

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("****MONTHLY INCOME*****" + complementaryData.get(ComplementaryRequestData.PASSPORTNUMBER));
				LOGGER.logDebug("****ComplementaryRequestData.PERSONNAMEMESSAGES*****" + complementaryData.get(ComplementaryRequestData.PERSONNAMEMESSAGES));
				LOGGER.logDebug("****ComplementaryRequestData.LANDLINEONE*****" + complementaryData.get(ComplementaryRequestData.LANDLINEONE));
			}

		} catch (Exception ex) {
			LOGGER.logError("Error", ex);

		}
	}
}
