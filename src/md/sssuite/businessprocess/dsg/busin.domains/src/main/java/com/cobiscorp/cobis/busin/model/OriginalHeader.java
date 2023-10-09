package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class OriginalHeader {

	public static final String EN_RIGNLEADE477 = "EN_RIGNLEADE477";

	public static final String VERSION = "1.0.0";

	public static final String ENTITY_NAME = "OriginalHeader";

	public static final Property<BigDecimal> MAXIMUMAMOUNT = new Property<BigDecimal>("maximumAmount", BigDecimal.class, false);

	public static final Property<BigDecimal> AMOUNTREQUESTEDORIGINAL = new Property<BigDecimal>("amountRequestedOriginal", BigDecimal.class, false);

	public static final Property<String> FREQUENCY = new Property<String>("frequency", String.class, false);

	public static final Property<String> FREQUENCYREVOLVING = new Property<String>("frequencyRevolving", String.class, false);

	public static final Property<String> BCBLACKLISTSCLIENT = new Property<String>("bCBlackListsClient", String.class, false);

	public static final Property<BigDecimal> PREVIOUSCREDITAMOUNT = new Property<BigDecimal>("previousCreditAmount", BigDecimal.class, false);

	public static final Property<String> IDREQUESTED = new Property<String>("IDRequested", String.class, false);

	public static final Property<String> TERMIND = new Property<String>("termInd", String.class, false);

	public static final Property<Integer> OFFICE = new Property<Integer>("Office", Integer.class, false);

	public static final Property<Integer> CITYCODE = new Property<Integer>("CityCode", Integer.class, false);

	public static final Property<BigDecimal> AMOUNTREQUESTED = new Property<BigDecimal>("AmountRequested", BigDecimal.class, false);

	public static final Property<String> CURRENCYREQUESTED = new Property<String>("CurrencyRequested", String.class, false);

	public static final Property<BigDecimal> QUOTA = new Property<BigDecimal>("Quota", BigDecimal.class, false);

	public static final Property<String> PAYMENTFREQUENCY = new Property<String>("PaymentFrequency", String.class, false);

	public static final Property<String> CREDITTARGET = new Property<String>("CreditTarget", String.class, false);

	public static final Property<Date> INITIALDATE = new Property<Date>("InitialDate", Date.class, false);

	public static final Property<Integer> APPLICATIONNUMBER = new Property<Integer>("ApplicationNumber", Integer.class, false);

	public static final Property<String> USERL = new Property<String>("UserL", String.class, false);

	public static final Property<String> COUNTRY = new Property<String>("Country", String.class, false);

	public static final Property<Integer> PROVINCE = new Property<Integer>("Province", Integer.class, false);

	public static final Property<String> TERM = new Property<String>("Term", String.class, false);

	public static final Property<String> TYPEREQUEST = new Property<String>("TypeRequest", String.class, false);

	public static final Property<String> OFFICERNAME = new Property<String>("OfficerName", String.class, false);

	public static final Property<String> NUMBERLINE = new Property<String>("NumberLine", String.class, false);

	public static final Property<BigDecimal> AMOUNTAPPROVED = new Property<BigDecimal>("AmountApproved", BigDecimal.class, false);

	public static final Property<String> OPNUMBERBANK = new Property<String>("OpNumberBank", String.class, false);

	public static final Property<String> STATUSREQUESTED = new Property<String>("StatusRequested", String.class, false);

	public static final Property<String> EXPROMISSION = new Property<String>("Expromission", String.class, false);

	public static final Property<String> REASONREFINANCING = new Property<String>("ReasonRefinancing", String.class, false);

	public static final Property<Integer> CITYCREDIT = new Property<Integer>("CityCredit", Integer.class, false);

	public static final Property<String> CREDITSECTOR = new Property<String>("CreditSector", String.class, false);

	public static final Property<String> CLIENTSECTOR = new Property<String>("ClientSector", String.class, false);

	public static final Property<String> OFFICERID = new Property<String>("OfficerId", String.class, false);

	public static final Property<BigDecimal> AMOUNTREQUESTEDML = new Property<BigDecimal>("AmountRequestedML", BigDecimal.class, false);

	public static final Property<String> STAGEFLUX = new Property<String>("stageflux", String.class, false);

	public static final Property<String> PRODUCTTYPE = new Property<String>("ProductType", String.class, false);

	public static final Property<String> TYPE = new Property<String>("Type", String.class, false);

	public static final Property<String> CREDITLINEVALID = new Property<String>("CreditLineValid", String.class, false);

	public static final Property<Character> AGREEMENT = new Property<Character>("Agreement", Character.class, false);

	public static final Property<String> CODEAGREEMENT = new Property<String>("CodeAgreement", String.class, false);

	public static final Property<Integer> REJECTIONREASON = new Property<Integer>("RejectionReason", Integer.class, false);

	public static final Property<Integer> REQUESTLINE = new Property<Integer>("RequestLine", Integer.class, false);

	public static final Property<String> PRODUCTFIE = new Property<String>("ProductFIE", String.class, false);

	public static final Property<Integer> HOUSINGCOUNT = new Property<Integer>("HousingCount", Integer.class, false);

	public static final Property<String> SCORETYPE = new Property<String>("ScoreType", String.class, false);

	public static final Property<String> SCORE = new Property<String>("Score", String.class, false);

	public static final Property<Character> ISWARRANTYDESTINATION = new Property<Character>("IsWarrantyDestination", Character.class, false);

	public static final Property<Character> ISDEBTOROWNER = new Property<Character>("IsDebtorOwner", Character.class, false);

	public static final Property<BigDecimal> AMOUNTAPROBED = new Property<BigDecimal>("AmountAprobed", BigDecimal.class, false);

	public static final Property<Integer> TERMLIMIT = new Property<Integer>("TermLimit", Integer.class, false);

	public static final Property<String> ACTIVITYNUMBER = new Property<String>("ActivityNumber", String.class, false);

	public static final Property<String> REJECTIONEXCUSE = new Property<String>("RejectionExcuse", String.class, false);

	public static final Property<String> PORTFOLIOTYPE = new Property<String>("PortfolioType", String.class, false);

	public static final Property<String> ACTIVITYDESTINATION = new Property<String>("ActivityDestination", String.class, false);

	public static final Property<String> CATEGORY = new Property<String>("category", String.class, false);

	public static final Property<String> SUBTYPE = new Property<String>("subType", String.class, false);

	public static final Property<String> SUBTYPEID = new Property<String>("subTypeId", String.class, false);

	public static final Property<Integer> OPERATIONNUMBER = new Property<Integer>("operationNumber", Integer.class, false);

	public static final Property<BigDecimal> AMOUNTDISBURSED = new Property<BigDecimal>("amountDisbursed", BigDecimal.class, false);

	public static final Property<String> DISPLACEMENT = new Property<String>("displacement", String.class, false);
	public static final Property<String> ISCANDIDATE = new Property<String>("isCandidate", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}


}
