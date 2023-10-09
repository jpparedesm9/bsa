package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@IdClass(AffiliateId.class)
@Table(name = "bv_afiliados_bv", schema = "cobis")
@NamedQueries({ @NamedQuery(name = "Affiliate.getAllAffiliations", query = "select new com.cobiscorp.ecobis.clientviewer.dto.AffiliateDTO(a.entityMIS, a.login, a.loginName, a.affiliateDateRegistry, a.profile, a.alternateProfile, a.stateRegistry, a.channel)"
		+ " from Affiliate a left join a.summaryCustomerAffiliate sca"
		+ " where sca.user = :user and sca.sequence = :sequence and sca.processId = 0"
		+ " order by a.entityMIS, a.entity, a.login, a.channel") })
/**
 * Class used to access the database using JPA
 * related table: bv_afiliados_bv bdd: cobis
 * @author bbuendia
 *
 */
public class Affiliate {

	@Id
	@Column(name = "af_ente_mis")
	private Integer entityMIS;
	@Id
	@Column(name = "af_login")
	private String login;
	@Column(name = "af_ente")
	private Integer entity;
	@Column(name = "af_canal")
	private Integer channel;
	@Column(name = "af_nombre_login")
	private String loginName;

	@Transient
	private String affiliateDate;
	@Column(name = "af_fecha_afiliacion")
	private Date affiliateDateRegistry;

	@Column(name = "af_perfil")
	private Integer profile;
	@Column(name = "af_perfil_alterno")
	private String alternateProfile;

	@Transient
	private String state;
	@Column(name = "af_estado")
	private String stateRegistry;

	@ManyToOne
	@JoinColumns({ @JoinColumn(name = "af_ente_mis", referencedColumnName = "sc_cliente") })
	private SummaryCustomer summaryCustomerAffiliate;

	public Affiliate() {
	}

	public Affiliate(Integer entityMIS, String login, String loginName,
			Date affiliateDateRegistry, Integer profile, String alternateProfile, String stateRegistry) {
		this.entityMIS = entityMIS;
		this.login = login;
		this.loginName = loginName;

		SimpleDateFormat dateformat = new SimpleDateFormat("dd/mm/yy");
		this.affiliateDate = dateformat.format(affiliateDateRegistry);
		this.profile = profile;
		this.alternateProfile = alternateProfile;
		this.stateRegistry = stateRegistry;
	}

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

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public Date getAffiliateDate() {
		return affiliateDateRegistry;
	}

	public void setAffiliateDate(Date affiliateDate) {
		this.affiliateDateRegistry = affiliateDate;
	}

	public Integer getProfile() {
		return profile;
	}

	public void setProfile(Integer profile) {
		this.profile = profile;
	}

	public String getState() {
		return stateRegistry;
	}

	public void setState(String state) {
		this.stateRegistry = state;
	}

	public String getStateRegistry() {
		return stateRegistry;
	}

	public void setStateRegistry(String stateRegistry) {
		this.stateRegistry = stateRegistry;
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

	public SummaryCustomer getSummaryCustomerAffiliate() {
		return summaryCustomerAffiliate;
	}

	public void setSummaryCustomerAffiliate(
			SummaryCustomer summaryCustomerAffiliate) {
		this.summaryCustomerAffiliate = summaryCustomerAffiliate;
	}

	public Date getAffiliateDateRegistry() {
		return affiliateDateRegistry;
	}

	public void setAffiliateDateRegistry(Date affiliateDateRegistry) {
		this.affiliateDateRegistry = affiliateDateRegistry;
	}

	public String getAlternateProfile() {
		return alternateProfile;
	}

	public void setAlternateProfile(String alternateProfile) {
		this.alternateProfile = alternateProfile;
	}

	public void setAffiliateDate(String affiliateDate) {
		this.affiliateDate = affiliateDate;
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
		Affiliate other = (Affiliate) obj;
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
		return "Affiliate [entityMIS=" + entityMIS + ", login=" + login
				+ ", loginName=" + loginName + ", affiliateDate="
				+ affiliateDateRegistry + ", profile=" + profile + "]";
	}

	/*
	 * @Column(name="af_ente") private int entity;
	 * 
	 * @Column(name="af_canal") private int channel;
	 * 
	 * @Column(name="af_perfil_alterno") private String alternateProfile;
	 * 
	 * @Column(name="af_oficina") private int office;
	 */

}
