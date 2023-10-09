package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class RefinancingOperations {

	public static final String EN_RNANCOPAI459 = "EN_RNANCOPAI459";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "RefinancingOperations";
	
	
	public static final Property<String> IDOPERATION = new Property<String>("IdOperation", String.class, false);
	
	public static final Property<String> REFINANCINGOPTION = new Property<String>("RefinancingOption", String.class, false);
	
	public static final Property<BigDecimal> BALANCE = new Property<BigDecimal>("Balance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ORIGINALAMOUNT = new Property<BigDecimal>("OriginalAmount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> LOCALCURRENCYAMOUNT = new Property<BigDecimal>("LocalCurrencyAmount", BigDecimal.class, false);
	
	public static final Property<String> CREDITTYPE = new Property<String>("CreditType", String.class, false);
	
	public static final Property<String> INTERNALCUSTOMERCLASSIFICATION = new Property<String>("InternalCustomerClassification", String.class, false);
	
	public static final Property<String> DATEGRANTING = new Property<String>("DateGranting", String.class, false);
	
	public static final Property<String> IDREQUESTEDOPERATION = new Property<String>("IdRequestedOperation", String.class, false);
	
	public static final Property<String> OPERATIONBANK = new Property<String>("OperationBank", String.class, false);
	
	public static final Property<BigDecimal> LOCALCURRENCYBALANCE = new Property<BigDecimal>("LocalCurrencyBalance", BigDecimal.class, false);
	
	public static final Property<Integer> CURRENCYOPERATION = new Property<Integer>("CurrencyOperation", Integer.class, false);
	
	public static final Property<Boolean> ISBASE = new Property<Boolean>("IsBase", Boolean.class, false);
	
	public static final Property<Integer> OFICIALOPERATION = new Property<Integer>("oficialOperation", Integer.class, false);
	
	public static final Property<String> OPERATIONQUALIFICATION = new Property<String>("OperationQualification", String.class, false);
	
	public static final Property<Integer> PAYOUTPERCENTAGE = new Property<Integer>("PayoutPercentage", Integer.class, false);
	
	public static final Property<Double> RATE = new Property<Double>("Rate", Double.class, false);
	
	public static final Property<String> SECTOR = new Property<String>("Sector", String.class, false);
	
	public static final Property<BigDecimal> PAYMENT = new Property<BigDecimal>("Payment", BigDecimal.class, false);
	
	public static final Property<Boolean> CAPITALIZE = new Property<Boolean>("Capitalize", Boolean.class, false);
	
	public static final Property<String> STATE = new Property<String>("State", String.class, false);
	
	public static final Property<String> EXPIRATIONDATE = new Property<String>("ExpirationDate", String.class, false);
	
	public static final Property<Integer> MORATORY = new Property<Integer>("Moratory", Integer.class, false);
	
	public static final Property<String> TYPEOPERATION = new Property<String>("TypeOperation", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
