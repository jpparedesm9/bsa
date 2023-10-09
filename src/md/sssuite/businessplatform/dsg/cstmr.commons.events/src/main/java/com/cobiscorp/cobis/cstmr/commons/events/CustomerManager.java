package com.cobiscorp.cobis.cstmr.commons.events;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter.MODECUSTOMER;
import com.cobiscorp.cobis.cstmr.model.ComplementaryRequestData;
import com.cobiscorp.cobis.cstmr.model.Context;
import com.cobiscorp.cobis.cstmr.model.DemographicData;
import com.cobiscorp.cobis.cstmr.model.EconomicInformation;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.cstmr.model.Person;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.busin.model.RenapoRequest;
import com.cobiscorp.ecobis.business.commons.platform.services.BiometricManager;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Outputs;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class CustomerManager extends BaseEvent {
	private static final String CANTIDAD_MAYOR_255 = "CSTMR.LBL_CSTMR_CARGASFAD_55543";
	private static final String DEBE_INGRESAR_DISCAPACIDAD = "CSTMR.LBL_CSTMR_DEBEINGDR_35944";
	private static final String DEBE_ELEGIR_CLIENTE = "CSTMR.LBL_CSTMR_DEBEELEUT_20357";
	private static final String ESPECIFICAR_EXISTENCIA_DISCAPACIDAD = "CSTMR.LBL_CSTMR_DEBEESPDD_57429";
	private static final String FECHA_NACIMIENTO_OBLIGATORIA = "CSTMR.LBL_CSTMR_FECHADETI_59418";
	private static final String PRIMER_NOMBRE_OBLIGATORIO = "CSTMR.LBL_CSTMR_PRIMERNOI_20577";
	private static final String PRIMER_APELLIDO_OBLIGATORIO = "CSTMR.LBL_CSTMR_PRIMERAOR_86765";
	private static final String IDENTIFICACION_OBLIGATORIA = "CSTMR.LBL_CSTMR_IDENTIFAO_64197";
	private static final String SEXO_OBLIGATORIO = "CSTMR.LBL_CSTMR_SEXOESOBL_78874";
	private static final String ESTADO_CIVIL_OBLIGATORIO = "CSTMR.LBL_CSTMR_ESTADOCSO_51774";
	private static final String NACIONALIDAD_OBLIGATORIA = "CSTMR.LBL_CSTMR_NACIONAAT_59128";
	private static final String TIPO_IDENTIFICACION_OBLIGATORIA = "CSTMR.MSG_CSTMR_TIPODEIIS_18036";
	private static final String CIC_OBLIGATORIO = "CSTMR.MSG_CSTMR_CICESOBIT_15951";
	private static final String OCR_OBLIGATORIO = "CSTMR.MSG_CSTMR_OCRESOBIT_95215";
	private static final String NUMERO_EMISION_OBLIGATORIO = "CSTMR.MSG_CSTMR_NUMERODGS_28759";
	private static final String CLAVE_ELECTOR_OBLIGATORIO = "CSTMR.MSG_CSTMR_CLAVEDERR_16854";

	private static final ILogger LOGGER = LogFactory.getLogger(CustomerManager.class);
	private Parameter.MODECUSTOMER typeSaveCustomer;

	public CustomerManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public CustomerManager(ICTSServiceIntegration serviceIntegration, Parameter.MODECUSTOMER typeSaveCustomer) {
		super(serviceIntegration);
		this.typeSaveCustomer = typeSaveCustomer;
	}

	public Map<String, Object> updateTotalCustomer(DynamicRequest entities) throws BusinessException, Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("INICIO EVENTO (updateTotalCustomer)");
		}

		Map<String, Object> result = new HashMap<String, Object>();
		CustomerTotalRequest customer = new CustomerTotalRequest();

		DataEntity natural = entities.getEntity(NaturalPerson.ENTITY_NAME);
		DataEntity person = entities.getEntity(Person.ENTITY_NAME);
		DataEntity demographic = entities.getEntity(DemographicData.ENTITY_NAME);
		DataEntity economic = entities.getEntity(EconomicInformation.ENTITY_NAME);
		DataEntity context = entities.getEntity(Context.ENTITY_NAME);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(result);
		}

		result = this.evalueSaveCustomer(customer, person, natural, economic, demographic);

		if (!validateResultError(result)) {
			result = this.updateCustomer(customer);
			if (result.get(Parameter.STATE) != null) {
				String valor = (String) result.get(Parameter.STATE);

				LOGGER.logDebug("IMPRIMO ESTATUS CODE RECUPERADO " + result.get(Parameter.STATE));

				natural.set(NaturalPerson.STATUSCODE, valor);

				person.set(Person.STATUSCODE, valor.charAt(0));

				LOGGER.logDebug("ESTATUS CODE RECUPERADO NATURAL" + natural.get(NaturalPerson.STATUSCODE));
				LOGGER.logDebug("ESTATUS CODE RECUPERADO PERSON" + person.get(Person.STATUSCODE));
			}
			if (result.get(Parameter.LINKED) != null) {
				String valor = (String) result.get(Parameter.LINKED);

				LOGGER.logDebug("IMPRIMO SI ES VINCULADO O NO " + result.get(Parameter.LINKED));

				boolean isLinked = "S".equals(valor) ? true : false;
				economic.set(EconomicInformation.ISLINKED, isLinked);

				LOGGER.logDebug("ES VINCULADO ECONOMIC" + economic.get(EconomicInformation.ISLINKED));
			}
			if (result.get(Parameter.RFC) != null) {
				natural.set(NaturalPerson.IDENTIFICATIONRFC, (String) result.get(Parameter.RFC));
			}
			if (result.get(Parameter.CURP) != null) {
				natural.set(NaturalPerson.DOCUMENTNUMBER, (String) result.get(Parameter.CURP));
			}
			if (result.get(Parameter.LISTBLACK) != null) {
				natural.set(NaturalPerson.HASLISTBLACK, result.get(Parameter.LISTBLACK) == null ? false : ("N".equals((String) result.get(Parameter.LISTBLACK))) ? false : true);
			}
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("FIN EVENTO (updateTotalCustomer)");
		}

		return result;
	}

	private void writeGeneralData(CustomerTotalRequest customer) {
		customer.setOperation('U');
	}

	private Map<String, Object> evalueSaveCustomer(CustomerTotalRequest customer, DataEntity person, DataEntity natural, DataEntity economic, DataEntity demographic) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("INICIO EVENTO (evalueSaveCustomer)");
			LOGGER.logDebug(this.typeSaveCustomer.toString());
		}

		Map<String, Object> resultTemp = new HashMap<String, Object>();
		Boolean retorno = false;

		if (this.typeSaveCustomer == MODECUSTOMER.INFOGENERAL || this.typeSaveCustomer == MODECUSTOMER.TOTAL) {
			resultTemp = this.updateDataGenericCustomer(customer, person, natural);
			retorno = this.validateResultError(resultTemp);
		}

		if (!retorno && (this.typeSaveCustomer == MODECUSTOMER.ECONOMIC || this.typeSaveCustomer == MODECUSTOMER.TOTAL)) {
			resultTemp = this.updateEconomicInformation(customer, economic);
			retorno = this.validateResultError(resultTemp);
		}

		if (!retorno && (this.typeSaveCustomer == MODECUSTOMER.DEMOGRAPHIC || this.typeSaveCustomer == MODECUSTOMER.TOTAL)) {
			resultTemp = this.updateDemographic(customer, demographic);
			retorno = this.validateResultError(resultTemp);
		}

		return resultTemp;
	}

	private Boolean validateResultError(Map<String, Object> result) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("INICIO EVENTO (validateResultError)");
		}
		Boolean retorno = false;

		String mensaje = GeneralFunction.getMessageError((List<Message>) result.get(Parameter.MESSAGESERVERLIST), (List<String>) result.get(Parameter.MESSAGEVALIDATIONLIST));

		if (!Parameter.EMPTY_VALUE.equals(mensaje)) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("mensaje-->");
				LOGGER.logDebug(mensaje);
			}
			retorno = true;
		}

		return retorno;
	}

	private void writeDemographic(CustomerTotalRequest customer, DataEntity demographic) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicio EVENTO executeDataEvent (writeDemographic)");
		}

		this.writeGeneralData(customer);

		customer.setCodePerson(demographic.get(DemographicData.PERSONSECUENTIAL));
		customer.setCityBirth(demographic.get(DemographicData.RESIDENCECOUNTRY));
		customer.setLevelStudy(demographic.get(DemographicData.STUDIESLEVEL));
		customer.setProfession(demographic.get(DemographicData.PROFESSION));
		String otherProfession = demographic.get(DemographicData.WHICHPROFESSION);
		customer.setOtherProfession(otherProfession == null || "".equals(otherProfession.trim()) ? "":otherProfession);		
		customer.setHousingType(demographic.get(DemographicData.HOUSINGTYPE));
		customer.setDependents(demographic.get(DemographicData.DEPENDENTS));
		customer.setEaCustomerForm(demographic.get(DemographicData.TEMPLATE));
		customer.setEaDisability(demographic.get(DemographicData.HASDISABILITY));
		customer.setEaTypeDisability(demographic.get(DemographicData.DISABILITYTYPE));

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("fin EVENTO executeDataEvent (writeDemographic)");
		}
	}

	private void writeDataGenericCustomer(CustomerTotalRequest customer, DataEntity person, DataEntity generalInfo) {
		this.writeGeneralData(customer);

		customer.setCodePerson(generalInfo.get(NaturalPerson.PERSONSECUENTIAL));
		customer.setName(generalInfo.get(NaturalPerson.FIRSTNAME));
		customer.setSecondName(generalInfo.get(NaturalPerson.SECONDNAME));
		customer.setFirstSurname(generalInfo.get(NaturalPerson.SURNAME));
		customer.setSecondSurname(generalInfo.get(NaturalPerson.SECONDSURNAME));
		customer.setEaKnownAs(generalInfo.get(NaturalPerson.KNOWNAS));
		customer.setMarriedSurname(generalInfo.get(NaturalPerson.MARRIEDSURNAME));
		if (generalInfo.get(NaturalPerson.BIRTHDATE) != null) {
			customer.setBirthDate(GeneralFunction.convertDateToCalendar(generalInfo.get(NaturalPerson.BIRTHDATE)));
		}
		customer.setGender(generalInfo.get(NaturalPerson.GENDERCODE));
		customer.setCivilStatus(generalInfo.get(NaturalPerson.MARITALSTATUSCODE));
		customer.setIdentificationType(generalInfo.get(NaturalPerson.DOCUMENTTYPE));
		customer.setIdentification(generalInfo.get(NaturalPerson.DOCUMENTNUMBER));
		customer.setEmail(generalInfo.get(NaturalPerson.EMAIL));

		if (generalInfo.get(NaturalPerson.INDEFINITE) == false) {
			if (generalInfo.get(NaturalPerson.EXPIRATIONDATE) != null) {
				customer.setExpirationDate(GeneralFunction.convertDateToCalendar(generalInfo.get(NaturalPerson.EXPIRATIONDATE)));
			}
		} else if (generalInfo.get(NaturalPerson.INDEFINITE) == true) {
			customer.setExpirationDate(null);
		}

		customer.setOfficial(generalInfo.get(NaturalPerson.OFFICERCODE));
		customer.setOffice(generalInfo.get(NaturalPerson.BRANCHCODE));
		customer.setNationality(generalInfo.get(NaturalPerson.NATIONALITYCODE));
		if (person.get(Person.STATUSCODE) != null) {
			customer.setEaState(person.get(Person.STATUSCODE).toString());
		}

		LOGGER.logDebug("Campos para Santander>>>");
		/**** Nuevos campos Santander **********/
		LOGGER.logDebug("Valor de hasProblems" + generalInfo.get(NaturalPerson.HASPROBLEMS));
		LOGGER.logDebug("Valor de PersonPep" + generalInfo.get(NaturalPerson.PERSONPEP));
		if (generalInfo.get(NaturalPerson.HASPROBLEMS) != null) {
			String hasProblems = generalInfo.get(NaturalPerson.HASPROBLEMS) ? "S" : "N";
			customer.setHasProblems(hasProblems);
		}
		if (generalInfo.get(NaturalPerson.PERSONPEP) != null) {
			String personPEP = generalInfo.get(NaturalPerson.PERSONPEP) ? "S" : "N";
			customer.setPersonPEP(personPEP);
		}

		LOGGER.logDebug("Nuevos valores NaturalPerson RFC");
		customer.setCustomerRFC(generalInfo.get(NaturalPerson.IDENTIFICATIONRFC));
		LOGGER.logDebug("Valor de getCustomerRFC: " + customer.getCustomerRFC());

		if (generalInfo.get(NaturalPerson.PUBLICPERSON) != null) {
			String publicPerson = generalInfo.get(NaturalPerson.PUBLICPERSON) ? "S" : "N";
			customer.setPublicPerson(publicPerson);
		}

		LOGGER.logDebug("Valor de generalInfo COUNTRYCODE : " + generalInfo.get(NaturalPerson.NATIONALITYCODE));
		customer.setCountryCode(generalInfo.get(NaturalPerson.NATIONALITYCODE));
		LOGGER.logDebug("Valor de setCountyOfBirth: " + customer.getCountryCode());

		LOGGER.logDebug("Valor de generalInfo NATIONALITYCODEAUX : " + generalInfo.get(NaturalPerson.NATIONALITYCODEAUX));
		if (generalInfo.get(NaturalPerson.NATIONALITYCODEAUX) != null) {
			customer.setNationalityCodeAux(generalInfo.get(NaturalPerson.NATIONALITYCODEAUX));
		}
		LOGGER.logDebug("Valor de setNationalityCodeAux: " + customer.getNationalityCodeAux());

		LOGGER.logDebug("Valor de generalInfo COUNTYOFBIRTH : " + generalInfo.get(NaturalPerson.COUNTYOFBIRTH));
		customer.setCountyOfBirth(generalInfo.get(NaturalPerson.COUNTYOFBIRTH));
		LOGGER.logDebug("Valor de setCountyOfBirth: " + customer.getCountyOfBirth());

		LOGGER.logDebug("Valor de generalInfo CHARGEPUB : " + generalInfo.get(NaturalPerson.CHARGEPUB));
		customer.setChargePub(generalInfo.get(NaturalPerson.CHARGEPUB));
		LOGGER.logDebug("Valor de setChargePub: " + customer.getChargePub());

		LOGGER.logDebug("Valor de generalInfo RELCHARGEPUB" + generalInfo.get(NaturalPerson.RELCHARGEPUB));
		customer.setRelChargePub(generalInfo.get(NaturalPerson.RELCHARGEPUB));
		LOGGER.logDebug("Valor de setRelChargePub: " + customer.getRelChargePub());

		LOGGER.logDebug("Valor de generalInfo ACCOUNTINDIVIDUAL" + generalInfo.get(NaturalPerson.ACCOUNTINDIVIDUAL));
		customer.setAccountIndividual(generalInfo.get(NaturalPerson.ACCOUNTINDIVIDUAL));
		LOGGER.logDebug("Valor de setAccountIndividual: " + customer.getAccountIndividual());

		LOGGER.logDebug("Valor de generalInfo SANTANDERCODE" + generalInfo.get(NaturalPerson.SANTANDERCODE));
		customer.setSantanderCode(generalInfo.get(NaturalPerson.SANTANDERCODE));
		LOGGER.logDebug("Valor de setSantanderCode: " + customer.getSantanderCode());

		if (generalInfo.get(NaturalPerson.NUMCYCLES) != null) {
			customer.setNumCycles(generalInfo.get(NaturalPerson.NUMCYCLES));
		}
		LOGGER.logDebug("Numero de Ciclos: " + customer.getNumCycles());

		LOGGER.logDebug("Valor de parent" + generalInfo.get(NaturalPerson.HASPARTNER));
		if (generalInfo.get(NaturalPerson.HASPARTNER) != null) {
			String hasParent = ((Boolean) generalInfo.get(NaturalPerson.HASPARTNER)).booleanValue() ? "S" : "N";

			customer.setPartner(hasParent);
		}
		LOGGER.logDebug("Valor de listas negras" + generalInfo.get(NaturalPerson.HASLISTBLACK));
		if (generalInfo.get(NaturalPerson.HASLISTBLACK) != null) {
			String haslistBlack = ((Boolean) generalInfo.get(NaturalPerson.HASLISTBLACK)).booleanValue() ? "S" : "N";

			customer.setListBlack(haslistBlack);
		}

		// Biometrico
		customer.setBioIdentificationType(generalInfo.get(NaturalPerson.BIOIDENTIFICATIONTYPE));
		customer.setBioCIC(generalInfo.get(NaturalPerson.BIOCIC));
		customer.setBioOCR(generalInfo.get(NaturalPerson.BIOOCR));
		customer.setBioEmissionNumber(generalInfo.get(NaturalPerson.BIOEMISSIONNUMBER));
		customer.setBioReaderKey(generalInfo.get(NaturalPerson.BIOREADERKEY));
		customer.setBioHasFingerprinter(String.valueOf(generalInfo.get(NaturalPerson.BIOHASFINGERPRINT)));
		customer.setCheckRenapo(generalInfo.get(NaturalPerson.BIORENAPORESULT));		
	       
        //Colectivo
        customer.setCollective(generalInfo.get(NaturalPerson.COLECTIVO));
        customer.setCollectiveLevel(generalInfo.get(NaturalPerson.NIVELCOLECTIVO));
	}

	private void writeEconomicInformation(CustomerTotalRequest customer, DataEntity economicInformation) {
		this.writeGeneralData(customer);

		customer.setCodePerson(economicInformation.get(EconomicInformation.PERSONSECUENTIAL));
		customer.setEaCategoryAML(economicInformation.get(EconomicInformation.CATEGORYALM));
		customer.setExpenditures(economicInformation.get(EconomicInformation.EXPENSELEVEL));
		customer.setCustomerRating(economicInformation.get(EconomicInformation.INTERNALQUALIFICATION));
		customer.setIncome(economicInformation.get(EconomicInformation.MONTHLYINCOME));
		customer.setLinkingType(economicInformation.get(EconomicInformation.RELATIONID));
		customer.setRetention(economicInformation.get(EconomicInformation.RETENTIONSUBJECT));
		customer.setCodeTutor(economicInformation.get(EconomicInformation.TUTORID));
		customer.setNameTutor(economicInformation.get(EconomicInformation.TUTORNAME));
		LOGGER.logDebug("Campos Económicos para Santander>>>");
		/** Nuevos campos Santander */
		if (economicInformation.get(EconomicInformation.LIABILITIES) != null) {
			customer.setLiabilities(BigDecimal.valueOf(economicInformation.get(EconomicInformation.LIABILITIES)));
		}
		if (economicInformation.get(EconomicInformation.BUSINESSYEARS) != null) {
			customer.setBusinessYears(economicInformation.get(EconomicInformation.BUSINESSYEARS));
		}

		if (economicInformation.get(EconomicInformation.SALES) != null) {
			customer.setSales(BigDecimal.valueOf(economicInformation.get(EconomicInformation.SALES)));
		}
		if (economicInformation.get(EconomicInformation.OTHERINCOMES) != null) {
			customer.setOtherIncome(BigDecimal.valueOf(economicInformation.get(EconomicInformation.OTHERINCOMES)));
		}
		if (economicInformation.get(EconomicInformation.ASSETS) != null) {
			customer.setTotalAssets(BigDecimal.valueOf(economicInformation.get(EconomicInformation.ASSETS)));
		}
		if (economicInformation.get(EconomicInformation.SALESCOST) != null) {
			customer.setSalesCost(BigDecimal.valueOf(economicInformation.get(EconomicInformation.SALESCOST)));
		}
		if (economicInformation.get(EconomicInformation.OPERATINGCOST) != null) {
			customer.setOperatingCost(BigDecimal.valueOf(economicInformation.get(EconomicInformation.OPERATINGCOST)));
		}
		if (economicInformation.get(EconomicInformation.MONTHLYTRXAMOUNT) != null) {
			customer.setMonthlyTrxAmount(BigDecimal.valueOf(economicInformation.get(EconomicInformation.MONTHLYTRXAMOUNT)));
		}

		String isLinked = economicInformation.get(EconomicInformation.ISLINKED) ? "S" : "N";
		customer.setIsLinked(isLinked);

		LOGGER.logDebug(" Nuevos valores EconomicInformation ");

		if (economicInformation.get(EconomicInformation.HASOTHERINCOME) != null) {
			String hasOtherIncome = economicInformation.get(EconomicInformation.HASOTHERINCOME) ? "S" : "N";
			customer.setHasOtherIncome(hasOtherIncome);
		}

		LOGGER.logDebug("Valor de getHasOtherIncome" + customer.getHasOtherIncome());
		customer.setOtherIncomeSource(economicInformation.get(EconomicInformation.OTHERINCOMESOURCE));
		LOGGER.logDebug("Valor de getOtherIncomeSource" + customer.getOtherIncomeSource());

		if (economicInformation.get(EconomicInformation.BUSINESSINCOME) != null) {
			customer.setBussIncome(BigDecimal.valueOf(economicInformation.get(EconomicInformation.BUSINESSINCOME)));
		}
		LOGGER.logDebug("Valor de Ingresos Negocio " + customer.getBussIncome());

	}

	private Map<String, Object> updateCustomer(CustomerTotalRequest customer) {
		Map<String, Object> result = new HashMap<String, Object>();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("FIN EVENTO executeDataEvent (queryCountry)");
		}

		LOGGER.logDebug("Identification Type:" + customer.getBioIdentificationType());
		LOGGER.logDebug("CIC:" + customer.getBioCIC());
		LOGGER.logDebug("OCR:" + customer.getBioOCR());
		LOGGER.logDebug("Emission Number:" + customer.getBioEmissionNumber());
		LOGGER.logDebug("Reader Key:" + customer.getBioReaderKey());
		LOGGER.logDebug("Fingerprint:" + customer.getBioHasFingerprinter());

		serviceRequestTO.addValue("inCustomerTotalRequest", customer);
		serviceResponse = this.execute(LOGGER, Parameter.PROCESSUPDATECUSTOMERS, serviceRequestTO);

		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (!serviceResponseTO.isSuccess()) {
				result.put(Parameter.MESSAGESERVERLIST, serviceResponse.getMessages());
			}
			HashMap<String, String> outputs = (HashMap<String, String>) serviceResponseTO.getValue(Outputs.OUTPUT);

			result.put(Parameter.STATE, outputs.get("@o_estado"));
			result.put(Parameter.LINKED, outputs.get("@o_vinculado"));
			result.put(Parameter.RFC, outputs.get("@o_rfc"));
			result.put(Parameter.CURP, outputs.get("@o_curp"));
			result.put(Parameter.LISTBLACK, outputs.get("@o_lista_negra"));
		} else {
			result.put(Parameter.MESSAGESERVERLIST, serviceResponse.getMessages());
		}
		return result;
	}

	private Map<String, Object> updateDataGenericCustomer(CustomerTotalRequest customer, DataEntity person, DataEntity generalInfo) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("INICIO EVENTO executeDataEvent (updateDataGenericCustomer)");
		}

		Map<String, Object> result = new HashMap<String, Object>();
		List<String> listMessages;

		listMessages = validationDataGenericCustomer(generalInfo);

		if (listMessages != null && !listMessages.isEmpty()) {
			result.put(Parameter.MESSAGEVALIDATIONLIST, listMessages);
		} else {
			writeDataGenericCustomer(customer, person, generalInfo);
		}

		return result;
	}

	private Map<String, Object> updateEconomicInformation(CustomerTotalRequest customer, DataEntity economicInformation) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("INICIO EVENTO executeDataEvent (updateEconomicInformation)");
		}

		Map<String, Object> result = new HashMap<String, Object>();
		List<String> listMessages;

		listMessages = validationEconomicInformation(economicInformation);

		if (listMessages != null && !listMessages.isEmpty()) {
			result.put(Parameter.MESSAGEVALIDATIONLIST, listMessages);
		} else {
			writeEconomicInformation(customer, economicInformation);
		}

		return result;
	}

	private Map<String, Object> updateDemographic(CustomerTotalRequest customer, DataEntity demographic) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("INICIO EVENTO executeDataEvent (updateDemographic)");
		}

		Map<String, Object> result = new HashMap<String, Object>();
		List<String> listMessages;

		listMessages = validationDemographic(demographic);

		if (listMessages != null && !listMessages.isEmpty()) {
			result.put(Parameter.MESSAGEVALIDATIONLIST, listMessages);
		} else {
			writeDemographic(customer, demographic);
		}

		return result;
	}

	private static List<String> validationDemographic(DataEntity demographic) {
		List<String> listMessages = new ArrayList<String>();

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ingresa al validationDemographic--> ");
		}

		try {
			if (demographic.get(DemographicData.PERSONSECUENTIAL) == null || demographic.get(DemographicData.PERSONSECUENTIAL) == 0) {
				GeneralFunction.setMessage(listMessages, DEBE_ELEGIR_CLIENTE);
				return listMessages;
			}

			if (demographic.get(DemographicData.DEPENDENTS) != null && demographic.get(DemographicData.DEPENDENTS) > 255) {
				GeneralFunction.setMessage(listMessages, CANTIDAD_MAYOR_255);
				return listMessages;
			}

			listMessages = validationDisability(demographic);

		} catch (Exception ex) {
			GeneralFunction.setMessage(listMessages, ex.getMessage());
			LOGGER.logError(ex);
		}

		return listMessages;
	}

	private static List<String> validationDisability(DataEntity demographic) {
		List<String> listMessages = new ArrayList<String>();

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ingresa al validationDisability--> ");
		}
		/*
		 * try { if (demographic.get(DemographicData.HASDISABILITY) == null) {
		 * GeneralFunction.setMessage(listMessages,
		 * ESPECIFICAR_EXISTENCIA_DISCAPACIDAD); return listMessages; } else { if
		 * (("S").equals(demographic.get(DemographicData.HASDISABILITY) .toString()) &&
		 * (demographic.get(DemographicData.DISABILITYTYPE) == null || demographic
		 * .get(DemographicData.DISABILITYTYPE).isEmpty())) {
		 * GeneralFunction.setMessage(listMessages, DEBE_INGRESAR_DISCAPACIDAD); return
		 * listMessages; } }
		 * 
		 * } catch (Exception ex) { GeneralFunction.setMessage(listMessages,
		 * ex.getMessage()); LOGGER.logError(ex); }
		 */
		return listMessages;
	}

	private static List<String> validationDataGenericCustomer(DataEntity generalInfo) {
		List<String> listMessages = new ArrayList<String>();

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ingresa al validationDataGenericCustomer--> ");
		}

		try {
			if (generalInfo.get(NaturalPerson.PERSONSECUENTIAL) == null || generalInfo.get(NaturalPerson.PERSONSECUENTIAL) == 0) {
				GeneralFunction.setMessage(listMessages, DEBE_ELEGIR_CLIENTE);
				return listMessages;
			}

			if (generalInfo.get(NaturalPerson.FIRSTNAME) == null || generalInfo.get(NaturalPerson.FIRSTNAME).isEmpty()) {
				GeneralFunction.setMessage(listMessages, PRIMER_NOMBRE_OBLIGATORIO);
				return listMessages;
			}

			if (generalInfo.get(NaturalPerson.SURNAME) == null || generalInfo.get(NaturalPerson.SURNAME).isEmpty()) {
				GeneralFunction.setMessage(listMessages, PRIMER_APELLIDO_OBLIGATORIO);
				return listMessages;
			}

			if (generalInfo.get(NaturalPerson.DOCUMENTNUMBER) == null || generalInfo.get(NaturalPerson.DOCUMENTNUMBER).isEmpty()) {
				GeneralFunction.setMessage(listMessages, IDENTIFICACION_OBLIGATORIA);
				return listMessages;
			}

			if (generalInfo.get(NaturalPerson.GENDERCODE) == null) {
				GeneralFunction.setMessage(listMessages, SEXO_OBLIGATORIO);
				return listMessages;
			}

			if (generalInfo.get(NaturalPerson.BIRTHDATE) == null) {
				GeneralFunction.setMessage(listMessages, FECHA_NACIMIENTO_OBLIGATORIA);
				return listMessages;
			}

			if (generalInfo.get(NaturalPerson.NATIONALITYCODE) == null) {
				GeneralFunction.setMessage(listMessages, NACIONALIDAD_OBLIGATORIA);
				return listMessages;
			}

			if (generalInfo.get(NaturalPerson.NATIONALITYCODE) <= 0) {
				GeneralFunction.setMessage(listMessages, NACIONALIDAD_OBLIGATORIA);
				return listMessages;
			}

			if (generalInfo.get(NaturalPerson.MARITALSTATUSCODE) == null || generalInfo.get(NaturalPerson.MARITALSTATUSCODE).isEmpty()) {
				GeneralFunction.setMessage(listMessages, ESTADO_CIVIL_OBLIGATORIO);
				return listMessages;
			}

			/*if (generalInfo.get(NaturalPerson.BIOIDENTIFICATIONTYPE) == null || generalInfo.get(NaturalPerson.BIOIDENTIFICATIONTYPE).isEmpty()) {
				GeneralFunction.setMessage(listMessages, TIPO_IDENTIFICACION_OBLIGATORIA);
				return listMessages;
			} else if ("INE".equals(generalInfo.get(NaturalPerson.BIOIDENTIFICATIONTYPE))) {
				if (generalInfo.get(NaturalPerson.BIOCIC) == null || generalInfo.get(NaturalPerson.BIOCIC).isEmpty()) {
					GeneralFunction.setMessage(listMessages, CIC_OBLIGATORIO);
					return listMessages;
				}
			} else if ("IFE".equals(generalInfo.get(NaturalPerson.BIOIDENTIFICATIONTYPE))) {
				if (generalInfo.get(NaturalPerson.BIOREADERKEY) == null || generalInfo.get(NaturalPerson.BIOREADERKEY).isEmpty())
					GeneralFunction.setMessage(listMessages, CLAVE_ELECTOR_OBLIGATORIO);
				if (generalInfo.get(NaturalPerson.BIOEMISSIONNUMBER) == null || generalInfo.get(NaturalPerson.BIOEMISSIONNUMBER).isEmpty())
					GeneralFunction.setMessage(listMessages, NUMERO_EMISION_OBLIGATORIO);
				if (generalInfo.get(NaturalPerson.BIOOCR) == null || generalInfo.get(NaturalPerson.BIOOCR).isEmpty())
					GeneralFunction.setMessage(listMessages, OCR_OBLIGATORIO);

				return listMessages;
			}*/
		} catch (Exception ex) {
			GeneralFunction.setMessage(listMessages, ex.getMessage());
			LOGGER.logError(ex);
		}

		return listMessages;
	}

	private static List<String> validationEconomicInformation(DataEntity economicInformation) {
		List<String> listMessages = new ArrayList<String>();

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ingresa al validationEconomicInformation--> ");
		}

		try {
			if (economicInformation.get(EconomicInformation.PERSONSECUENTIAL) == null || economicInformation.get(EconomicInformation.PERSONSECUENTIAL) == 0) {
				GeneralFunction.setMessage(listMessages, DEBE_ELEGIR_CLIENTE);
				return listMessages;
			}

		} catch (Exception ex) {
			GeneralFunction.setMessage(listMessages, ex.getMessage());
			LOGGER.logError(ex);
		}

		return listMessages;
	}

	public boolean updateCustomerRFCRUC(CustomerTotalRequest customer, IExecuteCommandEventArgs eventArgs) {
		Boolean result = false;
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Inicio updateCustomerRFCRUCccs");
		}
		serviceRequestTO.addValue("inCustomerTotalRequest", customer);
		ServiceResponse serviceResponse = this.execute(LOGGER, Parameter.PROCESSUPDATECUSTOMERS_CURPRFC, serviceRequestTO);

		if (serviceResponse != null && serviceResponse.isResult()) {
			LOGGER.logDebug("updateCustomerRFCRUC result" + serviceResponse.isResult());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				result = true;
				LOGGER.logDebug("updateCustomerRFCRUC serviceResponseTo success");
				eventArgs.getMessageManager().showSuccessMsg("La transacción se realizó exitosamente");
			} else {
				eventArgs.setSuccess(false);
				eventArgs.getMessageManager().showErrorMsg(getSpsMessages(serviceResponse.getMessages()));
			}
		} else {
			eventArgs.setSuccess(false);
			eventArgs.getMessageManager().showErrorMsg(getSpsMessages(serviceResponse.getMessages()));
		}
		return result;
	}

	public String getSpsMessages(List<Message> messages) {
		if (messages != null) {
			String messagesString = Parameter.EMPTY_VALUE;
			for (Message message : messages) {
				messagesString = messagesString.concat(" ").concat(message.getMessage());
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(" MENSAJES: " + messagesString);
			}
			return messagesString;
		}
		return null;
	}

	public Map<String, Object> updateComplementarDataCustomer(DynamicRequest entities) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("INICIO EVENTO (updateComplementarDataCustomer)");
		}
		Map<String, Object> result = new HashMap<String, Object>();
		CustomerTotalRequest customer = new CustomerTotalRequest();
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		DataEntity complementary = entities.getEntity(ComplementaryRequestData.ENTITY_NAME);
		DataEntity natural = entities.getEntity(NaturalPerson.ENTITY_NAME);

		try {
			writeComplementarDataCustomer(customer, complementary, natural);
			serviceRequestTO.addValue("inCustomerTotalRequest", customer);
			ServiceResponse serviceResponse;
			serviceResponse = this.execute(LOGGER, Parameter.PROCESSUPDATECUSTOMERS_COMPLEMENTARYDATA, serviceRequestTO);

			if (serviceResponse != null && serviceResponse.isResult()) {
				LOGGER.logDebug("updateComplementarDataCustomer result" + serviceResponse.isResult());
				ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
				if (serviceResponseTo.isSuccess()) {
					HashMap<String, String> outputs = (HashMap<String, String>) serviceResponseTo.getValue(Outputs.OUTPUT);
					
					if (outputs != null) {
						LOGGER.logDebug("@o_lista_negra: " + outputs.get("@o_lista_negra"));
						result.put(Parameter.LISTBLACK, outputs.get("@o_lista_negra"));
					}
					LOGGER.logDebug("updateComplementarDataCustomer serviceResponseTo success");
				} else {
					LOGGER.logDebug("updateComplementarDataCustomer serviceResponseTo Not Success");
				}
			} else {
				LOGGER.logDebug("updateComplementarDataCustomer serviceResponseTo Not Success");
			}
		} catch (Exception ex) {
			LOGGER.logError("Error", ex);
		}
		return result;
	}

	private void writeComplementarDataCustomer(CustomerTotalRequest customer, DataEntity complementaryData, DataEntity generalInfo) {
		LOGGER.logDebug("Datos Complementarios para Santander>>>");

		customer.setOperation('C');

		if (generalInfo.get(NaturalPerson.PERSONSECUENTIAL) != null) {
			customer.setCodePerson(generalInfo.get(NaturalPerson.PERSONSECUENTIAL));
		}

		if (complementaryData.get(ComplementaryRequestData.PASSPORTNUMBER) != null) {
			customer.setPassport(complementaryData.get(ComplementaryRequestData.PASSPORTNUMBER));
		}

		if (complementaryData.get(ComplementaryRequestData.PHONEERRANDS) != null) {
			customer.setPhoneErrands(complementaryData.get(ComplementaryRequestData.PHONEERRANDS));
		}

		if (complementaryData.get(ComplementaryRequestData.IFENUMBER) != null) {
			customer.setIfeNumber(complementaryData.get(ComplementaryRequestData.IFENUMBER));
		}

		if (complementaryData.get(ComplementaryRequestData.ELECTRONICSIGNATURE) != null) {
			customer.setElectronicSignature(complementaryData.get(ComplementaryRequestData.ELECTRONICSIGNATURE));
		}

		if (complementaryData.get(ComplementaryRequestData.PERSONNAMEMESSAGES) != null) {
			customer.setPersonNameMessages(complementaryData.get(ComplementaryRequestData.PERSONNAMEMESSAGES));
		}

		if (complementaryData.get(ComplementaryRequestData.BUREAUBACKGROUND) != null) {
			customer.setBureauBackground(complementaryData.get(ComplementaryRequestData.BUREAUBACKGROUND));
		}
		
		if (complementaryData.get(ComplementaryRequestData.PROFESSIONALACTIVITY) != null) {
			customer.setProfessionalActivity(complementaryData.get(ComplementaryRequestData.PROFESSIONALACTIVITY));
		}
		
		if (complementaryData.get(ComplementaryRequestData.ISCRYPTOUSED) != null) {
			customer.setIsCryptoUsed(complementaryData.get(ComplementaryRequestData.ISCRYPTOUSED));
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("****Datos Complementarios*****" + customer.getOperation() + " Passport: " + customer.getPassport());
			LOGGER.logDebug("****NaturalPerson.PERSONSECUENTIAL*****" + generalInfo.get(NaturalPerson.PERSONSECUENTIAL));
			LOGGER.logDebug("****ComplementaryRequestData.PASSPORTNUMBER*****" + complementaryData.get(ComplementaryRequestData.PASSPORTNUMBER));
			LOGGER.logDebug("****ComplementaryRequestData.BUREAUBACKGROUND*****" + complementaryData.get(ComplementaryRequestData.BUREAUBACKGROUND));
			LOGGER.logDebug("Finaliza Datos Complementarios para Santander>>>");
		}

	}

	public HashMap<String, String> updateCustomerRENAPO(CustomerTotalRequest customerTotalRequest, ICommonEventArgs arg1) throws BusinessException {

		CallServices callService = new CallServices(getServiceIntegration());
		Map<String, Object> requests = new HashMap<String, Object>();
		requests.put(RequestName.CUSTOMER_TOTAL_REQUEST, customerTotalRequest);
		return callService.callServiceWithInputMapAndOutputMap(requests, ServiceId.UPDATE_RENAPO_CUSTOMER, arg1);

	}

}
