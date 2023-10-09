/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de COBISCORP.                                */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de COBISCORP.                              */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor  y por las convenciones internacionales de    */
/*   propiedad intelectual.   Su  uso no autorizado dara    */
/*   derecho  a   COBISCORP   para  obtener  ordenes  de    */
/*   secuestro o retencion  y  para perseguir penalmente    */
/*   a los autores de cualquier infraccion.                 */
/************************************************************/
/*   This code was generated by CEN-SG.                     */
/*   Changes to this file may cause incorrect behavior      */
/*   and will be lost if the code is regenerated.           */
/************************************************************/

package com.cobiscorp.mobile.model;

import java.io.Serializable;

public class Task{
	private int activityIdentifier;
	private String administrator;
	private java.util.Calendar arrivalDate;
	private String bussinessInformationStringTwo;
	private java.math.BigDecimal charge;
	private String clientId;
	private String clientName;
	private Integer cobisAssignAct;
	private Integer cobisStepId;
	private java.util.Calendar creationDate;
	private String decision;
	private String detailPageUrl;
	private int duration;
	private java.util.Calendar expireDate;
	private java.util.Calendar lastClaimedDate;
	private String lastClaimedUser;
	private java.util.Calendar lastModifiedDate;
	private String nameDestination;
	private String opened;
	private String originator;
	private String owner;
	private int ownerIdentifier;
	private Integer priority;
	private String processIdentifier;
	private String processInstanceIdentifier;
	private String[] processObjects;
	private String processSubject;
	private String rolName;
	private String state;
	private String stateDescription;
	private String stateAct;
	private String taskDescription;
	private String taskIdentifier;
	private String taskInstanceIdentifier;
	private String taskSubject;
	private int timeEstandar;
	private String typeViewAssociated;
	private String version;
	private String bussinessInformationStringOne;
	private String taskReturn;
	private String alternateCode;
	private String clientType;
	private int idReceiver;
	private String receiver;
	private int late;
	private int historicWkf;
	private int numReturn;

	public int getActivityIdentifier() {
		return this.activityIdentifier;
	}

	public void setActivityIdentifier(int activityIdentifier) {
		this.activityIdentifier = activityIdentifier;
	}

	public String getAdministrator() {
		return this.administrator;
	}

	public void setAdministrator(String administrator) {
		this.administrator = administrator;
	}

	public java.util.Calendar getArrivalDate() {
		return this.arrivalDate;
	}

	public void setArrivalDate(java.util.Calendar arrivalDate) {
		this.arrivalDate = arrivalDate;
	}

	public String getBussinessInformationStringTwo() {
		return this.bussinessInformationStringTwo;
	}

	public void setBussinessInformationStringTwo(
			String bussinessInformationStringTwo) {
		this.bussinessInformationStringTwo = bussinessInformationStringTwo;
	}

	public java.math.BigDecimal getCharge() {
		return this.charge;
	}

	public void setCharge(java.math.BigDecimal charge) {
		this.charge = charge;
	}

	public String getClientId() {
		return this.clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getClientName() {
		return this.clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public Integer getCobisAssignAct() {
		return this.cobisAssignAct;
	}

	public void setCobisAssignAct(Integer cobisAssignAct) {
		this.cobisAssignAct = cobisAssignAct;
	}

	public Integer getCobisStepId() {
		return this.cobisStepId;
	}

	public void setCobisStepId(Integer cobisStepId) {
		this.cobisStepId = cobisStepId;
	}

	public java.util.Calendar getCreationDate() {
		return this.creationDate;
	}

	public void setCreationDate(java.util.Calendar creationDate) {
		this.creationDate = creationDate;
	}

	public String getDecision() {
		return this.decision;
	}

	public void setDecision(String decision) {
		this.decision = decision;
	}

	public String getDetailPageUrl() {
		return this.detailPageUrl;
	}

	public void setDetailPageUrl(String detailPageUrl) {
		this.detailPageUrl = detailPageUrl;
	}

	public int getDuration() {
		return this.duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public java.util.Calendar getExpireDate() {
		return this.expireDate;
	}

	public void setExpireDate(java.util.Calendar expireDate) {
		this.expireDate = expireDate;
	}

	public java.util.Calendar getLastClaimedDate() {
		return this.lastClaimedDate;
	}

	public void setLastClaimedDate(java.util.Calendar lastClaimedDate) {
		this.lastClaimedDate = lastClaimedDate;
	}

	public String getLastClaimedUser() {
		return this.lastClaimedUser;
	}

	public void setLastClaimedUser(String lastClaimedUser) {
		this.lastClaimedUser = lastClaimedUser;
	}

	public java.util.Calendar getLastModifiedDate() {
		return this.lastModifiedDate;
	}

	public void setLastModifiedDate(java.util.Calendar lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}

	public String getNameDestination() {
		return this.nameDestination;
	}

	public void setNameDestination(String nameDestination) {
		this.nameDestination = nameDestination;
	}

	public String getOpened() {
		return this.opened;
	}

	public void setOpened(String opened) {
		this.opened = opened;
	}

	public String getOriginator() {
		return this.originator;
	}

	public void setOriginator(String originator) {
		this.originator = originator;
	}

	public String getOwner() {
		return this.owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public int getOwnerIdentifier() {
		return this.ownerIdentifier;
	}

	public void setOwnerIdentifier(int ownerIdentifier) {
		this.ownerIdentifier = ownerIdentifier;
	}

	public Integer getPriority() {
		return this.priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	public String getProcessIdentifier() {
		return this.processIdentifier;
	}

	public void setProcessIdentifier(String processIdentifier) {
		this.processIdentifier = processIdentifier;
	}

	public String getProcessInstanceIdentifier() {
		return this.processInstanceIdentifier;
	}

	public void setProcessInstanceIdentifier(String processInstanceIdentifier) {
		this.processInstanceIdentifier = processInstanceIdentifier;
	}

	public String[] getProcessObjects() {
		return this.processObjects;
	}

	public void setProcessObjects(String[] processObjects) {
		this.processObjects = processObjects;
	}

	public String getProcessSubject() {
		return this.processSubject;
	}

	public void setProcessSubject(String processSubject) {
		this.processSubject = processSubject;
	}

	public String getRolName() {
		return this.rolName;
	}

	public void setRolName(String rolName) {
		this.rolName = rolName;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	public String getStateDescription() {
		return this.stateDescription;
	}

	public void setStateDescription(String stateDescription) {
		this.stateDescription = stateDescription;
	}

	
	
	public String getStateAct() {
		return stateAct;
	}
	
	public void setStateAct(String stateAct) {
		this.stateAct = stateAct;
	}

	public String getTaskDescription() {
		return this.taskDescription;
	}

	public void setTaskDescription(String taskDescription) {
		this.taskDescription = taskDescription;
	}

	public String getTaskIdentifier() {
		return this.taskIdentifier;
	}

	public void setTaskIdentifier(String taskIdentifier) {
		this.taskIdentifier = taskIdentifier;
	}

	public String getTaskInstanceIdentifier() {
		return this.taskInstanceIdentifier;
	}

	public void setTaskInstanceIdentifier(String taskInstanceIdentifier) {
		this.taskInstanceIdentifier = taskInstanceIdentifier;
	}

	public String getTaskSubject() {
		return this.taskSubject;
	}

	public void setTaskSubject(String taskSubject) {
		this.taskSubject = taskSubject;
	}

	public int getTimeEstandar() {
		return this.timeEstandar;
	}

	public void setTimeEstandar(int timeEstandar) {
		this.timeEstandar = timeEstandar;
	}

	public String getTypeViewAssociated() {
		return this.typeViewAssociated;
	}

	public void setTypeViewAssociated(String typeViewAssociated) {
		this.typeViewAssociated = typeViewAssociated;
	}

	public String getVersion() {
		return this.version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getBussinessInformationStringOne() {
		return this.bussinessInformationStringOne;
	}

	public void setBussinessInformationStringOne(
			String bussinessInformationStringOne) {
		this.bussinessInformationStringOne = bussinessInformationStringOne;
	}

	public String getTaskReturn() {
		return this.taskReturn;
	}

	public void setTaskReturn(String taskReturn) {
		this.taskReturn = taskReturn;
	}

	public String getAlternateCode() {
		return this.alternateCode;
	}

	public void setAlternateCode(String alternateCode) {
		this.alternateCode = alternateCode;
	}

	public String getClientType() {
		return this.clientType;
	}

	public void setClientType(String clientType) {
		this.clientType = clientType;
	}

	public int getIdReceiver() {
		return idReceiver;
	}

	public void setIdReceiver(int idReceiver) {
		this.idReceiver = idReceiver;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public int getLate() {
		return late;
	}

	public void setLate(int late) {
		this.late = late;
	}

	public int getHistoricWkf() {
		return historicWkf;
	}

	public void setHistoricWkf(int historicWkf) {
		this.historicWkf = historicWkf;
	}
	
	public int getNumReturn() {
		return numReturn;
	}

	public void setNumReturn(int numReturn) {
		this.numReturn = numReturn;
	}
	

}