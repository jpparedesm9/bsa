package com.cobiscorp.mobile.model;

import java.util.Objects;

/**
 * BankGeolocation
 */
public class BankGeolocation {

	private String login = null;

	/**
	 * Get login
	 * 
	 * @return login
	 **/
	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	private String trxType = null;

	/**
	 * Get trxType
	 * 
	 * @return trxType
	 **/
	public String getTrxType() {
		return trxType;
	}

	public void setTrxType(String trxType) {
		this.trxType = trxType;
	}

	private String serviceType = null;

	/**
	 * Get serviceType
	 * 
	 * @return serviceType
	 **/
	public String getServiceType() {
		return serviceType;
	}

	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	private String appName = null;

	/**
	 * Get appName
	 * 
	 * @return appName
	 **/
	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	private String longitudePos = null;

	/**
	 * Get longitudePos
	 * 
	 * @return longitudePos
	 **/
	public String getLongitudePos() {
		return longitudePos;
	}

	public void setLongitudePos(String longitudePos) {
		this.longitudePos = longitudePos;
	}

	private String latitudePos = null;

	/**
	 * Get latitudePos
	 * 
	 * @return latitudePos
	 **/
	public String getLatitudePos() {
		return latitudePos;
	}

	public void setLatitudePos(String latitudePos) {
		this.latitudePos = latitudePos;
	}

	private String channel = null;

	/**
	 * Get latitudePos
	 * 
	 * @return latitudePos
	 **/

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}

	@Override
	public boolean equals(java.lang.Object o) {
		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}
		BankGeolocation aBankGeoloc = (BankGeolocation) o;
		return Objects.equals(this.login, aBankGeoloc.login) && Objects.equals(this.trxType, aBankGeoloc.trxType) && Objects.equals(this.serviceType, aBankGeoloc.serviceType)
				&& Objects.equals(this.appName, aBankGeoloc.appName) && Objects.equals(this.longitudePos, aBankGeoloc.longitudePos) && Objects.equals(this.latitudePos, aBankGeoloc.latitudePos)
				&& Objects.equals(this.channel, aBankGeoloc.channel);
	}

	@Override
	public int hashCode() {
		return Objects.hash(login, trxType, serviceType, appName, longitudePos, latitudePos, channel);
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("class BankGeolocation {\n");
		sb.append("    login: ").append(toIndentedString(login)).append("\n");
		sb.append("    trxType: ").append(toIndentedString(trxType)).append("\n");
		sb.append("    serviceType: ").append(toIndentedString(serviceType)).append("\n");
		sb.append("    appName: ").append(toIndentedString(appName)).append("\n");
		sb.append("    longitudePos: ").append(toIndentedString(longitudePos)).append("\n");
		sb.append("    latitudePos: ").append(toIndentedString(latitudePos)).append("\n");
		sb.append("    channel: ").append(toIndentedString(channel)).append("\n");
		sb.append("}");
		return sb.toString();
	}

	/**
	 * Convert the given object to string with each line indented by 4 spaces (except the first line).
	 */
	private String toIndentedString(java.lang.Object o) {
		if (o == null) {
			return "null";
		}
		return o.toString().replace("\n", "\n    ");
	}
}
