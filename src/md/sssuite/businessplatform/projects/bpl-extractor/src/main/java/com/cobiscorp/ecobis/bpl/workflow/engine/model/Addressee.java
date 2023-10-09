package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Programa;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;

/**
 * The persistent class for the wf_destinatario database table.
 * 
 */
@Entity
@Table(name = "wf_destinatario", schema = "cob_workflow")
public class Addressee implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdAddressee idAddressee;

	@Column(name = "de_id_destinatario")
	// IdUsuario, IdRol, IdJerarquia
	private Integer idAddressees;

	@Column(name = "de_id_rol_destinatario")
	// Por defecto null
	private Integer idRoleAddressee;

	@Column(name = "de_requiere_usr_log")
	private byte requirementLogUser;

	@Column(name = "de_tipo_destinatario")
	// ROL,JEU,JER Catalog
	private String type;

	@Column(name = "de_tipo_distribucion_carga")
	// ESP,MCN Catalog
	private String loadBalanceType;

	@Column(name = "de_tipo_oficina_dist_carga")
	// OFN por defecto
	private String loadBalanceOfficeType;

	@Column(name = "de_version_subpr")
	// por defecto nulo
	private Short threadVersion;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "de_rol_cobis")
	// ROL
	private Role roleWF;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "de_codigo_dist_carga", referencedColumnName = "dc_cod_dist_car", insertable = false, updatable = false)
	private LoadBalance loadBalance;

	@Column(name = "de_codigo_dist_carga")
	private Integer idLoadBalance;

	@Column(name = "de_codigo_proceso")
	private Integer idProcess;

	@Column(name = "de_version_proceso")
	private Short versionProcess;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "de_codigo_actividad", insertable = false, updatable = false)
	private Activity activity;

	@Column(name = "de_codigo_actividad")
	private Integer idActivity;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns(value = { @JoinColumn(name = "de_codigo_proceso", referencedColumnName = "vp_codigo_proceso"),
			@JoinColumn(name = "de_version_proceso", referencedColumnName = "vp_version_proceso") })
	private ProcessVersion processVersion;

	@Transient
	private Programa programa;

	@Transient
	private Role role;

	@Transient
	private HierarchyTypeTpl hierarchyTypeTpl;

	@Transient
	private User user;

	@Transient
	private Rule rule;

	@Transient
	private Role comite;

	@Transient
	private Hierarchy hierarchy;

	public Addressee() {
	}

	/**
	 * @return the idAddressee
	 */
	public IdAddressee getIdAddressee() {
		return idAddressee;
	}

	/**
	 * @param idAddressee
	 *            the idAddressee to set
	 */
	public void setIdAddressee(IdAddressee idAddressee) {
		this.idAddressee = idAddressee;
	}

	/**
	 * @return the idAddressees
	 */
	public Integer getIdAddressees() {
		return idAddressees;
	}

	/**
	 * @param idAddressees
	 *            the idAddressees to set
	 */
	public void setIdAddressees(Integer idAddressees) {
		this.idAddressees = idAddressees;
	}

	/**
	 * @return the idRoleAddressee
	 */
	public Integer getIdRoleAddressee() {
		return idRoleAddressee;
	}

	/**
	 * @param idRoleAddressee
	 *            the idRoleAddressee to set
	 */
	public void setIdRoleAddressee(Integer idRoleAddressee) {
		this.idRoleAddressee = idRoleAddressee;
	}

	/**
	 * @return the requirementLogUser
	 */
	public byte getRequirementLogUser() {
		return requirementLogUser;
	}

	/**
	 * @param requirementLogUser
	 *            the requirementLogUser to set
	 */
	public void setRequirementLogUser(byte requirementLogUser) {
		this.requirementLogUser = requirementLogUser;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the loadBalanceType
	 */
	public String getLoadBalanceType() {
		return loadBalanceType;
	}

	/**
	 * @param loadBalanceType
	 *            the loadBalanceType to set
	 */
	public void setLoadBalanceType(String loadBalanceType) {
		this.loadBalanceType = loadBalanceType;
	}

	/**
	 * @return the loadBalanceOfficeType
	 */
	public String getLoadBalanceOfficeType() {
		return loadBalanceOfficeType;
	}

	/**
	 * @param loadBalanceOfficeType
	 *            the loadBalanceOfficeType to set
	 */
	public void setLoadBalanceOfficeType(String loadBalanceOfficeType) {
		this.loadBalanceOfficeType = loadBalanceOfficeType;
	}

	/**
	 * @return the threadVersion
	 */
	public Short getThreadVersion() {
		return threadVersion;
	}

	/**
	 * @param threadVersion
	 *            the threadVersion to set
	 */
	public void setThreadVersion(Short threadVersion) {
		this.threadVersion = threadVersion;
	}

	/**
	 * @return the role
	 */
	public Role getRole() {
		return role;
	}

	/**
	 * @param role
	 *            the role to set
	 */
	public void setRole(Role role) {
		this.role = role;
	}

	/**
	 * @return the loadBalance
	 */
	public LoadBalance getLoadBalance() {
		return loadBalance;
	}

	/**
	 * @param loadBalance
	 *            the loadBalance to set
	 */
	public void setLoadBalance(LoadBalance loadBalance) {
		this.loadBalance = loadBalance;
	}

	/**
	 * @return the idProcess
	 */
	public Integer getIdProcess() {
		return idProcess;
	}

	/**
	 * @param idProcess
	 *            the idProcess to set
	 */
	public void setIdProcess(Integer idProcess) {
		this.idProcess = idProcess;
	}

	/**
	 * @return the versionProcess
	 */
	public Short getVersionProcess() {
		return versionProcess;
	}

	/**
	 * @param versionProcess
	 *            the versionProcess to set
	 */
	public void setVersionProcess(Short versionProcess) {
		this.versionProcess = versionProcess;
	}

	/**
	 * @return the activity
	 */
	public Activity getActivity() {
		return activity;
	}

	/**
	 * @param activity
	 *            the activity to set
	 */
	public void setActivity(Activity activity) {
		this.activity = activity;
	}

	/**
	 * @return the roleWF
	 */
	public Role getRoleWF() {
		return roleWF;
	}

	/**
	 * @param roleWF
	 *            the roleWF to set
	 */
	public void setRoleWF(Role roleWF) {
		this.roleWF = roleWF;
	}

	/**
	 * @return the programa
	 */
	public Programa getPrograma() {
		return programa;
	}

	/**
	 * @param programa
	 *            the programa to set
	 */
	public void setPrograma(Programa programa) {
		this.programa = programa;
	}

	/**
	 * @return the hierarchyTypeTpl
	 */
	public HierarchyTypeTpl getHierarchyTypeTpl() {
		return hierarchyTypeTpl;
	}

	/**
	 * @param hierarchyTypeTpl
	 *            the hierarchyTypeTpl to set
	 */
	public void setHierarchyTypeTpl(HierarchyTypeTpl hierarchyTypeTpl) {
		this.hierarchyTypeTpl = hierarchyTypeTpl;
	}

	/**
	 * @return the user
	 */
	public User getUser() {
		return user;
	}

	/**
	 * @param user
	 *            the user to set
	 */
	public void setUser(User user) {
		this.user = user;
	}

	/**
	 * @return the rule
	 */
	public Rule getRule() {
		return rule;
	}

	/**
	 * @param rule
	 *            the rule to set
	 */
	public void setRule(Rule rule) {
		this.rule = rule;
	}

	/**
	 * @return the comite
	 */
	public Role getComite() {
		return comite;
	}

	/**
	 * @param comite
	 *            the comite to set
	 */
	public void setComite(Role comite) {
		this.comite = comite;
	}

	/**
	 * @return the processVersion
	 */
	public ProcessVersion getProcessVersion() {
		return processVersion;
	}

	/**
	 * @param processVersion
	 *            the processVersion to set
	 */
	public void setProcessVersion(ProcessVersion processVersion) {
		this.processVersion = processVersion;
	}

	/**
	 * @return the hierarchy
	 */
	public Hierarchy getHierarchy() {
		return hierarchy;
	}

	/**
	 * @param hierarchy
	 *            the hierarchy to set
	 */
	public void setHierarchy(Hierarchy hierarchy) {
		this.hierarchy = hierarchy;
	}

	/**
	 * @return the idActivity
	 */
	public Integer getIdActivity() {
		return idActivity;
	}

	/**
	 * @param idActivity
	 *            the idActivity to set
	 */
	public void setIdActivity(Integer idActivity) {
		this.idActivity = idActivity;
	}

	/**
	 * @return the idLoadBalance
	 */
	public Integer getIdLoadBalance() {
		return idLoadBalance;
	}

	/**
	 * @param idLoadBalance
	 *            the idLoadBalance to set
	 */
	public void setIdLoadBalance(Integer idLoadBalance) {
		this.idLoadBalance = idLoadBalance;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idAddressee == null) ? 0 : idAddressee.hashCode());
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Addressee other = (Addressee) obj;
		if (idAddressee == null) {
			if (other.idAddressee != null)
				return false;
		} else if (!idAddressee.equals(other.idAddressee))
			return false;
		return true;
	}

}