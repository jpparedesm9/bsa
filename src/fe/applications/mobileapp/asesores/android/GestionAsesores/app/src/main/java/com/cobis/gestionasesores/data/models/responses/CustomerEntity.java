package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.ComplementaryDataRemote;
import com.cobis.gestionasesores.data.models.requests.CustomerAddressRequest;
import com.cobis.gestionasesores.data.models.requests.CustomerBusinessRemote;
import com.cobis.gestionasesores.data.models.requests.CustomerDocumentsRemote;
import com.cobis.gestionasesores.data.models.requests.CustomerReferencesRemote;
import com.cobis.gestionasesores.data.models.requests.PartnerDataRemote;
import com.cobis.gestionasesores.data.models.requests.PartnerWorkRemote;

public class CustomerEntity {
    private CustomerDataResponse customer;
    private CustomerAddressRequest address;
    private CustomerBusinessRemote business;
    private PaymentCapacityResponse paymentCapacity;
    private CustomerReferencesRemote references;
    private PartnerDataRemote spouse;
    private PartnerWorkRemote spouseAddressData;
    private CustomerDocumentsRemote documents;
    private ComplementaryDataRemote complementaryRequest;

    public ComplementaryDataRemote getComplementaryRequest() {
        return complementaryRequest;
    }

    public void setComplementaryRequest(ComplementaryDataRemote complementaryRequest) {
        this.complementaryRequest = complementaryRequest;
    }

    public CustomerDataResponse getCustomer() {
        return customer;
    }

    public void setCustomer(CustomerDataResponse customer) {
        this.customer = customer;
    }

    public CustomerAddressRequest getAddress() {
        return address;
    }

    public void setAddress(CustomerAddressRequest address) {
        this.address = address;
    }

    public CustomerBusinessRemote getBusiness() {
        return business;
    }

    public void setBusiness(CustomerBusinessRemote business) {
        this.business = business;
    }

    public PaymentCapacityResponse getPaymentCapacity() {
        return paymentCapacity;
    }

    public void setPaymentCapacity(PaymentCapacityResponse paymentCapacity) {
        this.paymentCapacity = paymentCapacity;
    }

    public PartnerDataRemote getSpouse() {
        return spouse;
    }

    public void setSpouse(PartnerDataRemote spouse) {
        this.spouse = spouse;
    }

    public PartnerWorkRemote getSpouseAddressData() {
        return spouseAddressData;
    }

    public void setSpouseAddressData(PartnerWorkRemote spouseAddressData) {
        this.spouseAddressData = spouseAddressData;
    }

    public CustomerDocumentsRemote getDocuments() {
        return documents;
    }

    public void setDocuments(CustomerDocumentsRemote documents) {
        this.documents = documents;
    }

    public CustomerReferencesRemote getReferences() {
        return references;
    }

    public void setReferences(CustomerReferencesRemote references) {
        this.references = references;
    }
}
