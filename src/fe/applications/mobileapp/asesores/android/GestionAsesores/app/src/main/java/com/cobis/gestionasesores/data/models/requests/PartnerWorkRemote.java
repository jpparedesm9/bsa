package com.cobis.gestionasesores.data.models.requests;

public class PartnerWorkRemote {

    private int addressId;
    private PartnerWorkAddress address;
    private PhoneInfo workphone;
    private PhoneInfo cellphone;

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public PartnerWorkAddress getAddress() {
        return address;
    }

    public void setAddress(PartnerWorkAddress address) {
        this.address = address;
    }

    public PhoneInfo getWorkphone() {
        return workphone;
    }

    public void setWorkphone(PhoneInfo workphone) {
        this.workphone = workphone;
    }

    public PhoneInfo getCellphone() {
        return cellphone;
    }

    public void setCellphone(PhoneInfo cellphone) {
        this.cellphone = cellphone;
    }
}
