package com.cobiscorp.ecobis.cloud.service.dto.business;

import cobiscorp.ecobis.customerdatamanagement.dto.CustomerBusinessRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerBusinessResp;
import com.cobiscorp.ecobis.cloud.service.util.CalendarUtil;

import java.math.BigDecimal;

import static com.cobiscorp.ecobis.cloud.service.util.DataTypeUtil.isNullOrEmpty;

public class Business {

    private static final String DATE_FORMAT_OPEN_DATE = "dd/MM/yyyy";
    private int businessId;
    private String name;
    private String transfer;
    private String creditPurpose;
    private String industry;
    private int yearsInBusiness;
    private int yearsAtAddress;
    private String ownershipType;
    private String openDate;//Calendar
    private String withWhatResourceWillPayForCredit;
    private BigDecimal monthlyRevenue;
    private String phone;
    private int phoneId;
    private String otherWithWhatResourceWillPayForCredit;

    public CustomerBusinessRequest toRequest(int customerId) {
        CustomerBusinessRequest request = new CustomerBusinessRequest();
	
        request.setCustomerCode(customerId);
        request.setCode(businessId);
        request.setName(name);
        request.setTurnaround(transfer);
        request.setCreditDestination(creditPurpose);
        request.setPhone(phone);
        request.setPhoneId(phoneId);
        request.setEconomicActivity(industry);
        request.setTimeActivity(yearsInBusiness);
        request.setTimeBusinessAddress(yearsAtAddress);
        request.setTypeLocal(ownershipType);
        if (!isNullOrEmpty(openDate)) {
            request.setDateBusiness(CalendarUtil.fromISOTime(openDate));
        }
        request.setResources(withWhatResourceWillPayForCredit);
        if (monthlyRevenue != null) {
            request.setMountlyIncomes(monthlyRevenue.doubleValue());
        }
        request.setWhichResource(otherWithWhatResourceWillPayForCredit);
        return request;
    }

    public static Business fromResponse(CustomerBusinessResp response) {
        if (response == null) {
            return null;
        }
        Business business = new Business();
        business.businessId = response.getCode();
        business.name = response.getName();
        business.transfer = response.getTurnaround();
        business.creditPurpose = response.getCreditDestination();
        business.phone = response.getPhone();
        business.phoneId = response.getPhoneId();
        business.industry = response.getEconomicActivity();
        business.yearsInBusiness = response.getTimeActivity();
        business.yearsAtAddress = response.getTimeBusinessAddress();
        business.ownershipType = response.getTypeLocal();
        if (response.getDateBusiness() != null) {
            business.openDate = CalendarUtil.toISOTime(response.getDateBusiness(), DATE_FORMAT_OPEN_DATE);
        }
        business.withWhatResourceWillPayForCredit = response.getResources();
        business.otherWithWhatResourceWillPayForCredit = response.getWhichResource();
        business.monthlyRevenue = new BigDecimal(response.getMountlyIncomes());
        return business;
    }

    public int getBusinessId() {
        return businessId;
    }

    public void setBusinessId(int businessId) {
        this.businessId = businessId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTransfer() {
        return transfer;
    }

    public void setTransfer(String transfer) {
        this.transfer = transfer;
    }

    public String getCreditPurpose() {
        return creditPurpose;
    }

    public void setCreditPurpose(String creditPurpose) {
        this.creditPurpose = creditPurpose;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public int getYearsInBusiness() {
        return yearsInBusiness;
    }

    public void setYearsInBusiness(int yearsInBusiness) {
        this.yearsInBusiness = yearsInBusiness;
    }

    public int getYearsAtAddress() {
        return yearsAtAddress;
    }

    public void setYearsAtAddress(int yearsAtAddress) {
        this.yearsAtAddress = yearsAtAddress;
    }

    public String getOwnershipType() {
        return ownershipType;
    }

    public void setOwnershipType(String ownershipType) {
        this.ownershipType = ownershipType;
    }

    public String getOpenDate() {
        return openDate;
    }

    public void setOpenDate(String openDate) {
        this.openDate = openDate;
    }

    public String getWithWhatResourceWillPayForCredit() {
        return withWhatResourceWillPayForCredit;
    }

    public void setWithWhatResourceWillPayForCredit(String withWhatResourceWillPayForCredit) {
        this.withWhatResourceWillPayForCredit = withWhatResourceWillPayForCredit;
    }

    public BigDecimal getMonthlyRevenue() {
        return monthlyRevenue;
    }

    public void setMonthlyRevenue(BigDecimal monthlyRevenue) {
        this.monthlyRevenue = monthlyRevenue;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public int getPhoneId() {
        return phoneId;
    }
    
    public void setPhoneId(int phoneId) {
        this.phoneId = phoneId;
    }

	public String getOtherWithWhatResourceWillPayForCredit() {
		return otherWithWhatResourceWillPayForCredit;
	}

	public void setOtherWithWhatResourceWillPayForCredit(String otherWithWhatResourceWillPayForCredit) {
		this.otherWithWhatResourceWillPayForCredit = otherWithWhatResourceWillPayForCredit;
	}
}
