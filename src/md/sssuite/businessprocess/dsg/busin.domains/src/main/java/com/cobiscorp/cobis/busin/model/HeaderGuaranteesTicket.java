package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class HeaderGuaranteesTicket {

	public static final String EN_HAUTSICKE747 = "EN_HAUTSICKE747";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "HeaderGuaranteesTicket";
	
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("CustomerName", String.class, false);
	
	public static final Property<String> CUSTOMERADDRESS = new Property<String>("CustomerAddress", String.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("CustomerId", Integer.class, false);
	
	public static final Property<String> APPLICATIONTYPE = new Property<String>("ApplicationType", String.class, false);
	
	public static final Property<String> RENEWOPERATION = new Property<String>("RenewOperation", String.class, false);
	
	public static final Property<String> CREDITLINEDISTRIB = new Property<String>("CreditLineDistrib", String.class, false);
	
	public static final Property<BigDecimal> AMOUNTAVAILABLE = new Property<BigDecimal>("AmountAvailable", BigDecimal.class, false);
	
	public static final Property<String> WARRANTYCLASS = new Property<String>("WarrantyClass", String.class, false);
	
	public static final Property<String> WARRANTYTYPE = new Property<String>("WarrantyType", String.class, false);
	
	public static final Property<String> CURRENCYREQUESTED = new Property<String>("CurrencyRequested", String.class, false);
	
	public static final Property<BigDecimal> AMOUNTREQUESTED = new Property<BigDecimal>("AmountRequested", BigDecimal.class, false);
	
	public static final Property<Date> FROMDATE = new Property<Date>("FromDate", Date.class, false);
	
	public static final Property<Integer> REQUESTEDTERMINDAYS = new Property<Integer>("RequestedTermInDays", Integer.class, false);
	
	public static final Property<Date> EXPIRATIONDATE = new Property<Date>("ExpirationDate", Date.class, false);
	
	public static final Property<String> SECTOR = new Property<String>("Sector", String.class, false);
	
	public static final Property<String> BYACCOUNTNAME = new Property<String>("ByAccountName", String.class, false);
	
	public static final Property<String> BYACCOUNTADDRESS = new Property<String>("ByAccountAddress", String.class, false);
	
	public static final Property<Integer> BYACCOUNTID = new Property<Integer>("ByAccountId", Integer.class, false);
	
	public static final Property<String> BENEFICIARYNAME = new Property<String>("BeneficiaryName", String.class, false);
	
	public static final Property<String> BENEFICIARYADDRESS = new Property<String>("BeneficiaryAddress", String.class, false);
	
	public static final Property<Integer> BENEFICIARYID = new Property<Integer>("BeneficiaryId", Integer.class, false);
	
	public static final Property<String> OBJECTGUARANTEE = new Property<String>("ObjectGuarantee", String.class, false);
	
	public static final Property<String> OBJECTGUARANTEETWO = new Property<String>("ObjectGuaranteeTwo", String.class, false);
	
	public static final Property<String> ADDITIONALINSTRUCTION = new Property<String>("AdditionalInstruction", String.class, false);
	
	public static final Property<String> ADDITIONALINSTRUCTIONTWO = new Property<String>("AdditionalInstructionTwo", String.class, false);
	
	public static final Property<String> ADDITIONALINSTRUCTIONTHREE = new Property<String>("AdditionalInstructionThree", String.class, false);
	
	public static final Property<Date> DATEADMISSION = new Property<Date>("DateAdmission", Date.class, false);
	
	public static final Property<Date> DATEPROCESS = new Property<Date>("DateProcess", Date.class, false);
	
	public static final Property<String> USER = new Property<String>("User", String.class, false);
	
	public static final Property<Date> CREATIONDATE = new Property<Date>("CreationDate", Date.class, false);
	
	public static final Property<String> CUSTOMERTYPE = new Property<String>("CustomerType", String.class, false);
	
	public static final Property<String> CREDITSECTOR = new Property<String>("CreditSector", String.class, false);
	
	public static final Property<String> CREDITTYPE = new Property<String>("CreditType", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
