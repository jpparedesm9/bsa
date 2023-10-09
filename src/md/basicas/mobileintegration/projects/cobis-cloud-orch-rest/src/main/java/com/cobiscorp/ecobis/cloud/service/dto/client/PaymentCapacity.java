package com.cobiscorp.ecobis.cloud.service.dto.client;

import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;

import java.math.BigDecimal;

/**
 * @author Cesar Loachamin
 */
public class PaymentCapacity {

    private BigDecimal monthlyIncome;
    private BigDecimal monthlyBusinessExpenses;
    private BigDecimal monthlyFamilyExpense;
    private BigDecimal monthlyOtherIncome;
    private String monthlyOtherIncomeSource;
    private String hasOtherIncome;

    public BigDecimal getMonthlyIncome() {
        return monthlyIncome;
    }

    public void setMonthlyIncome(BigDecimal monthlyIncome) {
        this.monthlyIncome = monthlyIncome;
    }

    public BigDecimal getMonthlyBusinessExpenses() {
        return monthlyBusinessExpenses;
    }

    public void setMonthlyBusinessExpenses(BigDecimal monthlyBusinessExpenses) {
        this.monthlyBusinessExpenses = monthlyBusinessExpenses;
    }

    public BigDecimal getMonthlyFamilyExpense() {
        return monthlyFamilyExpense;
    }

    public void setMonthlyFamilyExpense(BigDecimal monthlyFamilyExpense) {
        this.monthlyFamilyExpense = monthlyFamilyExpense;
    }

    public BigDecimal getMonthlyOtherIncome() {
		return monthlyOtherIncome;
	}

	public void setMonthlyOtherIncome(BigDecimal monthlyOtherIncome) {
		this.monthlyOtherIncome = monthlyOtherIncome;
	}
	
	

	public String getMonthlyOtherIncomeSource() {
		return monthlyOtherIncomeSource;
	}

	public void setMonthlyOtherIncomeSource(String monthlyOtherIncomeSource) {
		this.monthlyOtherIncomeSource = monthlyOtherIncomeSource;
	}

	public String getHasOtherIncome() {
		return hasOtherIncome;
	}

	public void setHasOtherIncome(String hasOtherIncome) {
		this.hasOtherIncome = hasOtherIncome;
	}

	public static PaymentCapacity fromResponse(CustomerResponse response) {
        PaymentCapacity obj = new PaymentCapacity();
        obj.setMonthlyIncome(new BigDecimal(response.getOtherIncomes()));
        obj.setMonthlyBusinessExpenses(new BigDecimal(response.getOperativeCost()));
        obj.setMonthlyFamilyExpense(new BigDecimal(response.getSalesCost()));
        obj.setMonthlyOtherIncome(new BigDecimal(response.getSales()));
        obj.setMonthlyOtherIncomeSource(response.getOtherIncomeSource());
        obj.setHasOtherIncome(response.getHasOtherIncome());
        return obj;
    }

    public CustomerTotalRequest toRequest(int customerId, Customer customer) {
        CustomerTotalRequest request = customer.toRequest();
        request.setCodePerson(customerId);
        request.setOtherIncome(monthlyIncome);
        request.setOperatingCost(monthlyBusinessExpenses);
        request.setSalesCost(monthlyFamilyExpense);
        
        request.setSales(monthlyOtherIncome); //otros ingresos
        request.setHasOtherIncome(hasOtherIncome);//tiene otros ingresos
        request.setOtherIncomeSource(monthlyOtherIncomeSource);//default fuente de ingresos
        return request;
    }
}
