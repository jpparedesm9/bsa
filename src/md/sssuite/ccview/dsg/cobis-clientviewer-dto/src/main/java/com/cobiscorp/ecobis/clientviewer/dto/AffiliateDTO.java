package com.cobiscorp.ecobis.clientviewer.dto;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * DTO that obtains information from Affiliation
 * 
 * @author bbuendia
 * 
 */
public class AffiliateDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer entityMIS;
	private String login;
	private Integer entity;
	private Integer channel;
	private String loginName;
	private String affiliateDate;
	private Date affiliateDateRegistry;
	private Integer profile;
	private String alternateProfile;
	private String state;
	private String stateRegistry;

	public Integer getEntityMIS() {
		return entityMIS;
	}

	public void setEntityMIS(Integer entityMIS) {
		this.entityMIS = entityMIS;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public Integer getEntity() {
		return entity;
	}

	public void setEntity(Integer entity) {
		this.entity = entity;
	}

	public Integer getChannel() {
		return channel;
	}

	public void setChannel(Integer channel) {
		this.channel = channel;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getAffiliateDate() {
		return affiliateDate;
	}

	public void setAffiliateDate(String affiliateDate) {
		this.affiliateDate = affiliateDate;
	}

	public Date getAffiliateDateRegistry() {
		return affiliateDateRegistry;
	}

	public void setAffiliateDateRegistry(Date affiliateDateRegistry) {
		this.affiliateDateRegistry = affiliateDateRegistry;
	}

	public Integer getProfile() {
		return profile;
	}

	public void setProfile(Integer profile) {
		this.profile = profile;
	}

	public String getAlternateProfile() {
		return alternateProfile;
	}

	public void setAlternateProfile(String alternateProfile) {
		this.alternateProfile = alternateProfile;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getStateRegistry() {
		return stateRegistry;
	}

	public void setStateRegistry(String stateRegistry) {
		this.stateRegistry = stateRegistry;
	}

	public AffiliateDTO() {
	}

	public AffiliateDTO(Integer entityMIS, String login, String loginName,
			Date affiliateDateRegistry, Integer profile,
			String alternateProfile, String stateRegistry) {
		this.entityMIS = entityMIS;
		this.login = login;
		this.loginName = loginName;

		SimpleDateFormat dateformat = new SimpleDateFormat("dd/mm/yy");
		this.affiliateDate = dateformat.format(affiliateDateRegistry);
		this.profile = profile;
		this.alternateProfile = alternateProfile;
		this.stateRegistry = stateRegistry;
	}


	public AffiliateDTO(Integer entityMIS, String login, String loginName,
			Date affiliateDateRegistry, Integer profile,
			String alternateProfile, String stateRegistry, Integer channel) {
		this.entityMIS = entityMIS;
		this.login = login;
		this.loginName = loginName;

		SimpleDateFormat dateformat = new SimpleDateFormat("dd/mm/yy");
		this.affiliateDate = dateformat.format(affiliateDateRegistry);
		this.profile = profile;
		this.alternateProfile = alternateProfile;
		this.stateRegistry = stateRegistry;
		this.channel = channel;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((entityMIS == null) ? 0 : entityMIS.hashCode());
		result = prime * result + ((login == null) ? 0 : login.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AffiliateDTO other = (AffiliateDTO) obj;
		if (entityMIS == null) {
			if (other.entityMIS != null)
				return false;
		} else if (!entityMIS.equals(other.entityMIS))
			return false;
		if (login == null) {
			if (other.login != null)
				return false;
		} else if (!login.equals(other.login))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "AffiliateDTO [entityMIS=" + entityMIS + ", login=" + login
				+ ", entity=" + entity + ", channel=" + channel
				+ ", loginName=" + loginName + ", affiliateDate="
				+ affiliateDate + ", affiliateDateRegistry="
				+ affiliateDateRegistry + ", profile=" + profile
				+ ", alternateProfile=" + alternateProfile + ", state=" + state
				+ ", stateRegistry=" + stateRegistry + "]";
	}

}
