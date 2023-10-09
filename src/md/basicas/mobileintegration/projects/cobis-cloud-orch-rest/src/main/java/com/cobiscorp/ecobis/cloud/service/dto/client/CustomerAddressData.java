package com.cobiscorp.ecobis.cloud.service.dto.client;

import com.cobiscorp.ecobis.cloud.service.dto.address.EmailAddress;
import com.cobiscorp.ecobis.cloud.service.dto.geolocation.GeoReference;
import com.cobiscorp.ecobis.cloud.service.dto.address.Phone;

/**
 * @author Cesar Loachamin
 */
public class CustomerAddressData {

	private int customerId;
	private String completeClientName;
    private int addressId;
    private CustomerAddress address;
    private EmailAddress emailAddress;
    private Phone phone;
    private Phone cellphone;
    private GeoReference geoReference;
    private GeoReference officialGeoReference;

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public CustomerAddress getAddress() {
        return address;
    }

    public void setAddress(CustomerAddress address) {
        this.address = address;
    }

    public Phone getPhone() {
        return phone;
    }

    public void setPhone(Phone phone) {
        this.phone = phone;
    }

    public Phone getCellphone() {
        return cellphone;
    }

    public void setCellphone(Phone cellphone) {
        this.cellphone = cellphone;
    }

    public GeoReference getGeoReference() {
        return geoReference;
    }

    public void setGeoReference(GeoReference geoReference) {
        this.geoReference = geoReference;
    }

    public EmailAddress getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(EmailAddress emailAddress) {
        this.emailAddress = emailAddress;
    }

	public GeoReference getOfficialGeoReference() {
		return officialGeoReference;
	}

	public void setOfficialGeoReference(GeoReference officialGeoReference) {
		this.officialGeoReference = officialGeoReference;
	}
        public String getCompleteClientName() {
		return completeClientName;
	}

	public void setCompleteClientName(String completeClientName) {
		this.completeClientName = completeClientName;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

}