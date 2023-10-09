package com.cobis.cloud.sofom.operationsexecution.payments.service.openpay.dto;

/**
 * Created by pclavijo on 25/07/2017.
 */
public class PaymentMethod {
    private String type;
    private String reference;
    private String barcode_url;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getBarcode_url() {
        return barcode_url;
    }

    public void setBarcode_url(String barcode_url) {
        this.barcode_url = barcode_url;
    }

    @Override
    public String toString() {
        return "PaymentMethod{" +
                "type='" + type + '\'' +
                ", reference='" + reference + '\'' +
                ", barcode_url='" + barcode_url + '\'' +
                '}';
    }
}
