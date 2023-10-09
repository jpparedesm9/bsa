package com.cobis.gestionasesores.data.models.responses;

public class ValidateResponse extends GenericResponse {

    public ValidateResponse() {
    }

    private BuroResponse buroResponse;
    private CustomerCoreInfo customerCoreInfo;

    public BuroResponse getBuroResponse() {
        return buroResponse;
    }

    public void setBuroResponse(BuroResponse buroResponse) {
        this.buroResponse = buroResponse;
    }

    public CustomerCoreInfo getCustomerCoreInfo() {
        return customerCoreInfo;
    }

    public void setCustomerCoreInfo(CustomerCoreInfo customerCoreInfo) {
        this.customerCoreInfo = customerCoreInfo;
    }
}
