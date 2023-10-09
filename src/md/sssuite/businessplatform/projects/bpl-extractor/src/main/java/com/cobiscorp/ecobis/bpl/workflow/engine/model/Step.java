package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ApprovalException;

/**
 * The persistent class for the wf_paso database table.
 * 
 */
@Entity
@Table(name = "wf_paso", schema = "cob_workflow")
@NamedQueries({ @NamedQuery(name = "Step.findByProcessVersionAndActivity", query = "select s from Step s where s.activity.name=:name and s.processVersion.process.idProcess=:process and s.processVersion.versionProcess=:versionProcess") })
public class Step implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "pa_id_paso")
	private Integer idStep;

	@Column(name = "pa_codigo_proceso")
	private Integer idProcess;

	@Column(name = "pa_version_proceso")
	private Short version;

	@Column(name = "pa_alto")
	private Double height;

	@Column(name = "pa_ancho")
	private Double width;

	@Column(name = "pa_automatico")
	private int automatic;

	@Column(name = "pa_id_programa_tiempo_estandar")
	private int programStandarTime;

	@Column(name = "pa_posicion_x")
	private Double positionX;

	@Column(name = "pa_posicion_y")
	private Double positionY;

	@Column(name = "pa_tipo_paso")
	private String type;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "pa_codigo_actividad", insertable = false, updatable = false)
	private Activity activity;

	@Column(name = "pa_codigo_actividad")
	private Integer idActivity;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns(value = { @JoinColumn(name = "pa_codigo_proceso", referencedColumnName = "vp_codigo_proceso"),
			@JoinColumn(name = "pa_version_proceso", referencedColumnName = "vp_version_proceso") })
	private ProcessVersion processVersion;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "step", cascade = CascadeType.ALL)
	private List<PolicyStep> policyStepList = new ArrayList<PolicyStep>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "step", cascade = CascadeType.ALL)
	private List<ActivityRequirement> activityRequirementList = new ArrayList<ActivityRequirement>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "step", cascade = CascadeType.ALL)
	private List<ActivityResult> activityResultList = new ArrayList<ActivityResult>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "step", cascade = CascadeType.ALL)
	private List<ActivityObservation> activityObservationList = new ArrayList<ActivityObservation>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "step")
	private List<Receptor> receptorList = new ArrayList<Receptor>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "step", cascade = CascadeType.ALL)
	private List<HierarchyItem> hierarchyItemList;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "step")
	private List<InformationStep> informationStepList;

	@Transient
	private Activity trActivity;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "step", cascade = CascadeType.ALL)
	private List<ApprovalException> approvalException = new ArrayList<ApprovalException>();

	public List<ApprovalException> getApprovalException() {
		return approvalException;
	}

	public void setApprovalException(List<ApprovalException> approvalException) {
		this.approvalException = approvalException;
	}

	public Integer getIdStep() {
		return idStep;
	}

	public void setIdStep(Integer idStep) {
		this.idStep = idStep;
	}

	public Integer getIdProcess() {
		return idProcess;
	}

	public void setIdProcess(Integer idProcess) {
		this.idProcess = idProcess;
	}

	public Short getVersion() {
		return version;
	}

	public void setVersion(Short version) {
		this.version = version;
	}

	public Double getHeight() {
		return height;
	}

	public void setHeight(Double height) {
		this.height = height;
	}

	public Double getWidth() {
		return width;
	}

	public void setWidth(Double width) {
		this.width = width;
	}

	public int getAutomatic() {
		return automatic;
	}

	public void setAutomatic(int automatic) {
		this.automatic = automatic;
	}

	public int getProgramStandarTime() {
		return programStandarTime;
	}

	public void setProgramStandarTime(int programStandarTime) {
		this.programStandarTime = programStandarTime;
	}

	public Double getPositionX() {
		return positionX;
	}

	public void setPositionX(Double positionX) {
		this.positionX = positionX;
	}

	public Double getPositionY() {
		return positionY;
	}

	public void setPositionY(Double positionY) {
		this.positionY = positionY;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Activity getActivity() {
		return activity;
	}

	public void setActivity(Activity activity) {
		this.activity = activity;
	}

	public ProcessVersion getProcessVersion() {
		return processVersion;
	}

	public void setProcessVersion(ProcessVersion processVersion) {
		this.processVersion = processVersion;
	}

	public List<PolicyStep> getPolicyStepList() {
		return policyStepList;
	}

	public void setPolicyStepList(List<PolicyStep> policyStepList) {
		this.policyStepList = policyStepList;
	}

	public List<ActivityRequirement> getActivityRequirementList() {
		return activityRequirementList;
	}

	public void setActivityRequirementList(List<ActivityRequirement> activityRequirementList) {
		this.activityRequirementList = activityRequirementList;
	}

	public List<ActivityResult> getActivityResultList() {
		return activityResultList;
	}

	public void setActivityResultList(List<ActivityResult> activityResultList) {
		this.activityResultList = activityResultList;
	}

	public List<ActivityObservation> getActivityObservationList() {
		return activityObservationList;
	}

	public void setActivityObservationList(List<ActivityObservation> activityObservationList) {
		this.activityObservationList = activityObservationList;
	}

	public List<Receptor> getReceptorList() {
		return receptorList;
	}

	public void setReceptorList(List<Receptor> receptorList) {
		this.receptorList = receptorList;
	}

	public List<HierarchyItem> getHierarchyItemList() {
		return hierarchyItemList;
	}

	public void setHierarchyItemList(List<HierarchyItem> hierarchyItemList) {
		this.hierarchyItemList = hierarchyItemList;
	}

	public List<InformationStep> getInformationStepList() {
		return informationStepList;
	}

	public void setInformationStepList(List<InformationStep> informationStepList) {
		this.informationStepList = informationStepList;
	}

	public Integer getIdActivity() {
		return idActivity;
	}

	public void setIdActivity(Integer idActivity) {
		this.idActivity = idActivity;
	}

	public Activity getTrActivity() {
		return trActivity;
	}

	public void setTrActivity(Activity trActivity) {
		this.trActivity = trActivity;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idStep == null) ? 0 : idStep.hashCode());
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
		Step other = (Step) obj;
		if (idStep == null) {
			if (other.idStep != null)
				return false;
		} else if (!idStep.equals(other.idStep))
			return false;
		return true;
	}

}