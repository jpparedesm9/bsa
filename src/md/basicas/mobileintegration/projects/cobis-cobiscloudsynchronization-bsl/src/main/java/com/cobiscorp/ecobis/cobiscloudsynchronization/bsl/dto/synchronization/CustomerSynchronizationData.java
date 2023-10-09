package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization;

import com.cobiscorp.ecobis.cloud.service.dto.business.BusinessData;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerAddressData;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerData;
import com.cobiscorp.ecobis.cloud.service.dto.client.PaymentCapacityData;
import com.cobiscorp.ecobis.cloud.service.dto.complementaryrequest.ComplementaryRequestData;
import com.cobiscorp.ecobis.cloud.service.dto.spouse.SpouseAddressData;
import com.cobiscorp.ecobis.cloud.service.dto.spouse.SpouseData;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Created by farid on 7/20/2017.
 */
@XmlRootElement(name = "customerSynchronizedData")
@XmlAccessorType(XmlAccessType.FIELD)
public class CustomerSynchronizationData {
    private CustomerData customer;
    private CustomerAddressData address;
    private BusinessData business;
    private PaymentCapacityData paymentCapacity;
    @XmlElement(name = "referenceList")
    private ReferenceSynchronizationData references;
    private SpouseData spouse;
    private SpouseAddressData spouseAddressData;
    @XmlElement(name = "documentList")
    private DocumentSynchronizationData documents;
	private ComplementaryRequestData complementaryRequest;

    public CustomerSynchronizationData() {
    }

    public SpouseData getSpouse() {
        return spouse;
    }

    public void setSpouse(SpouseData spouse) {
        this.spouse = spouse;
    }

    public SpouseAddressData getSpouseAddressData() {
        return spouseAddressData;
    }

    public void setSpouseAddressData(SpouseAddressData spouseAddressData) {
        this.spouseAddressData = spouseAddressData;
    }

    public CustomerData getCustomer() {
        return customer;
    }

    public void setCustomer(CustomerData customer) {
        this.customer = customer;
    }

    public CustomerAddressData getAddress() {
        return address;
    }

    public void setAddress(CustomerAddressData address) {
        this.address = address;
    }

    public BusinessData getBusiness() {
        return business;
    }

    public void setBusiness(BusinessData business) {
        this.business = business;
    }

    public PaymentCapacityData getPaymentCapacity() {
        return paymentCapacity;
    }

    public void setPaymentCapacity(PaymentCapacityData paymentCapacity) {
        this.paymentCapacity = paymentCapacity;
    }

    public ReferenceSynchronizationData getReferences() {
        return references;
    }

    public void setReferences(ReferenceSynchronizationData references) {
        this.references = references;
    }

    public DocumentSynchronizationData getDocuments() {
        return documents;
    }

    public void setDocuments(DocumentSynchronizationData documents) {
        this.documents = documents;
    }

	public ComplementaryRequestData getComplementaryRequest() {
		return complementaryRequest;
	}

	public void setComplementaryRequest(
			ComplementaryRequestData complementaryRequest) {
		this.complementaryRequest = complementaryRequest;
	}

	@Override
	public String toString() {
		return "CustomerSynchronizationData{" + "customer=" + customer
				+ ", address=" + address + ", business=" + business
				+ ", paymentCapacity=" + paymentCapacity + ", complementaryRequest=" + complementaryRequest + '}';
	}
}
