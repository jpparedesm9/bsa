package com.cobiscorp.ecobis.customer.dal.entities;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@NamedQueries({
@NamedQuery(name = "Customer.getDebtorCustomerData", query = "select new com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse (c.id, c.typeDocumentId, c.documentId, c.nameComplete, c.name, c.subtype, c.typePersonId, c.sector) "
		+ " from Customer c where c.id = :id"),
@NamedQuery(name = "Customer.getAllData", query = "select c from Customer c where c.id = :id"),
@NamedQuery(name = "Customer.getIdSearch", query = "select new com.cobiscorp.ecobis.customer.services.dtos.IdSearchRequest (c.documentId) from Customer c where c.documentId = :docId")
})
@Entity
@Table(name = "cl_ente", schema = "cobis")
public class Customer {

	@Id
	@Column(name = "en_ente")
	Integer id;

	@Column(name = "en_nombre")
	String name;

	@Column(name = "p_p_apellido")
	String lastName;

	@Column(name = "en_nomlar")
	String nameComplete;

	@Column(name = "en_subtipo")
	String subtype;

	@Column(name = "en_ced_ruc")
	String documentId;

	@Column(name = "en_tipo_ced")
	String typeDocumentId;

	@Column(name = "p_tipo_persona")
	String typePersonId;

	@Column(name = "en_sector")
	String sector;
	
	//ATRIBUTOS SPRINT 2 PRO 22/07/2014
	@Column(name = "en_oficina")
	Integer office;
	
	@Column(name = "en_fecha_crea")
	Date creationDate;
	
	@Column(name = "en_fecha_mod")
	Date updateDate;
	
	@Column(name = "en_direccion")
	Integer nAddress;
	
	@Column(name = "en_referencia")
	Integer nReferences;
	
	@Column(name = "en_casilla")
	Integer nPobxs;
	
	@Column(name = "en_balance")
	Integer balance;
	
	@Column(name = "en_grupo")
	Integer group;
	
	@Column(name = "en_pais")
	Integer country;
	
	@Column(name = "en_oficial")
	Integer executive;
	
	@Column(name = "en_actividad")
	String activity;
	
	@Column(name = "en_retencion")
	String retention;
	
	@Column(name = "p_trabajo")
	Integer nJobs;	
	
	@Column(name = "en_mala_referencia")
	String badReference;
	
	@Column(name = "p_s_apellido")
	String secondLastName;
	
	@Column(name = "p_sexo")
	String sex;
	
	@Column(name = "p_fecha_nac")
	Date birthDate;

	@Column(name = "p_ciudad_nac")
	String birthCity;
	
	@Column(name = "p_profesion")
	String profesion;
	
	@Column(name = "p_num_cargas")
	Integer nDependents;
	
	@Column(name = "p_num_hijos")
	Integer nChildren;
	
	@Column(name = "p_nivel_estudio")
	String studyLevel;
	
	@Column(name = "p_tipo_vivienda")
	String housingType;
	
	@Column(name = "p_nivel_ing")
	BigDecimal incomeLevel;

	@Column(name = "p_nivel_egr")
	BigDecimal expendLevel;
	
	@Column(name = "p_calif_cliente")
	String customerRating;
	
	@Column(name = "c_cap_suscrito")
	BigDecimal stockInTrade;
	
	@Column(name = "en_asosciada")
	String associated;
	
	@Column(name = "c_posicion")
	String position;
	
	@Column(name = "c_tipo_compania")
	String companyType;
	
	@Column(name = "c_rep_legal")
	Integer legalRepresentative;
	
	@Column(name = "c_activo")
	BigDecimal assets;
	
	@Column(name = "c_pasivo")
	BigDecimal liabilities;
	
	@Column(name = "c_es_grupo")
	String isGroup;
	
	@Column(name = "c_capital_social")
	BigDecimal socialCapital;

	@Column(name = "c_fecha_const")
	Date constitutionDate;
	
	@Column(name = "c_plazo")
	Integer term;
	
	@Column(name = "c_tipo_soc")
	String societyType;
	
	@Column(name = "c_total_activos")
	BigDecimal totalAssets;
	
	@Column(name = "c_num_empleados")
	Integer nStaff;
	
	@Column(name = "c_sigla")
	Integer initials;
	
	@Column(name = "c_ciudad")
	Integer city;
	
	@Column(name = "c_fecha_exp")
	Date expirationDate;
	
	@Column(name = "c_fecha_registro")
	Date registrationDate;
	
	@Column(name = "p_fecha_emision")
	Date issueDate;
	
	@Column(name = "c_fecha_verif")
	Date verificationDate;
	
	@Column(name = "c_verificado")
	String verified;
	
	@Column(name = "c_funcionario")
	String official;
	
	@Column(name = "en_situacion_cliente")
	String customerSituation;
	
	@Column(name = "en_calificacion")
	String rating;
	
	@Column(name = "en_vinculacion")
	String vinculation;
	
	@Column(name = "en_tipo_vinculacion")
	String vinculationType;
	
	@Column(name = "en_oficial_sup")
	Integer substituteExecutive;
	
	@Column(name = "en_cliente")
	String isCustomer;
	
	@Column(name = "p_s_nombre")
	String middleName;
	
	@Column(name = "c_codsuper")
	String superCode;
	
	@Column(name = "c_segmento")
	String segment;
	
	@Column(name = "c_razon_social")
	String socialReason;
	
	@Column(name = "en_nacionalidad")
	Integer nationality;
	
	@Column(name = "en_id_tutor")
	String idTutor;
	
	@Column(name = "en_nom_tutor")
	String nomTutor;
	
	@Column(name = "en_otros_ingresos")
	BigDecimal otherIcomes;
	
	@Column(name = "en_origen_ingresos")
	String originIcomes;
	
	@Column(name = "p_estado_civil")
	String maritalStatus;

	public Customer() {

	}

	public Integer getOffice() {
		return office;
	}

	public void setOffice(Integer office) {
		this.office = office;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public Integer getnJobs() {
		return nJobs;
	}

	public void setnJobs(Integer nJobs) {
		this.nJobs = nJobs;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getNameComplete() {
		return nameComplete;
	}

	public void setNameComplete(String nameComplete) {
		this.nameComplete = nameComplete;
	}


	public Integer getBalance() {
		return balance;
	}

	public void setBalance(Integer balance) {
		this.balance = balance;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getSubtype() {
		return subtype;
	}

	public void setSubtype(String subtype) {
		this.subtype = subtype;
	}

	public String getDocumentId() {
		return documentId;
	}

	public void setDocumentId(String documentId) {
		this.documentId = documentId;
	}

	public String getTypeDocumentId() {
		return typeDocumentId;
	}

	public void setTypeDocumentId(String typeDocumentId) {
		this.typeDocumentId = typeDocumentId;
	}

	public String getTypePersonId() {
		return typePersonId;
	}

	public void setTypePersonId(String typePersonId) {
		this.typePersonId = typePersonId;
	}

	public String getSector() {
		return sector;
	}

	public void setSector(String sector) {
		this.sector = sector;
	}

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public Integer getnAddress() {
		return nAddress;
	}

	public void setnAddress(Integer nAddress) {
		this.nAddress = nAddress;
	}

	public Integer getnReferences() {
		return nReferences;
	}

	public void setnReferences(Integer nReferences) {
		this.nReferences = nReferences;
	}

	public Integer getnPobxs() {
		return nPobxs;
	}

	public void setnPobxs(Integer nPobxs) {
		this.nPobxs = nPobxs;
	}

	public Integer getGroup() {
		return group;
	}

	public void setGroup(Integer group) {
		this.group = group;
	}

	public Integer getCountry() {
		return country;
	}

	public void setCountry(Integer country) {
		this.country = country;
	}

	public Integer getExecutive() {
		return executive;
	}

	public void setExecutive(Integer executive) {
		this.executive = executive;
	}

	public String getActivity() {
		return activity;
	}

	public void setActivity(String activity) {
		this.activity = activity;
	}

	public String getRetention() {
		return retention;
	}

	public void setRetention(String retention) {
		this.retention = retention;
	}

	public String getBadReference() {
		return badReference;
	}

	public void setBadReference(String badReference) {
		this.badReference = badReference;
	}

	public String getSecondLastName() {
		return secondLastName;
	}

	public void setSecondLastName(String secondLastName) {
		this.secondLastName = secondLastName;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}	

	public Date getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}

	public void setLegalRepresentative(Integer legalRepresentative) {
		this.legalRepresentative = legalRepresentative;
	}
	
	public String getBirthCity() {
		return birthCity;
	}

	public void setBirthCity(String birthCity) {
		this.birthCity = birthCity;
	}

	public String getProfesion() {
		return profesion;
	}

	public void setProfesion(String profesion) {
		this.profesion = profesion;
	}

	public Integer getnDependents() {
		return nDependents;
	}

	public void setnDependents(Integer nDependents) {
		this.nDependents = nDependents;
	}

	public Integer getnChildren() {
		return nChildren;
	}

	public void setnChildren(Integer nChildren) {
		this.nChildren = nChildren;
	}

	public String getStudyLevel() {
		return studyLevel;
	}

	public void setStudyLevel(String studyLevel) {
		this.studyLevel = studyLevel;
	}

	public String getHousingType() {
		return housingType;
	}

	public void setHousingType(String housingType) {
		this.housingType = housingType;
	}

	public BigDecimal getIncomeLevel() {
		return incomeLevel;
	}

	public void setIncomeLevel(BigDecimal incomeLevel) {
		this.incomeLevel = incomeLevel;
	}

	public BigDecimal getExpendLevel() {
		return expendLevel;
	}

	public void setExpendLevel(BigDecimal expendLevel) {
		this.expendLevel = expendLevel;
	}

	public String getCustomerRating() {
		return customerRating;
	}

	public void setCustomerRating(String customerRating) {
		this.customerRating = customerRating;
	}

	public BigDecimal getStockInTrade() {
		return stockInTrade;
	}

	public void setStockInTrade(BigDecimal stockInTrade) {
		this.stockInTrade = stockInTrade;
	}

	public String getAssociated() {
		return associated;
	}

	public void setAssociated(String associated) {
		this.associated = associated;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getCompanyType() {
		return companyType;
	}

	public void setCompanyType(String companyType) {
		this.companyType = companyType;
	}

	public int getLegalRepresentative() {
		return legalRepresentative;
	}

	public void setLegalRepresentative(int legalRepresentative) {
		this.legalRepresentative = legalRepresentative;
	}

	public BigDecimal getAssets() {
		return assets;
	}

	public void setAssets(BigDecimal assets) {
		this.assets = assets;
	}

	public BigDecimal getLiabilities() {
		return liabilities;
	}

	public void setLiabilities(BigDecimal liabilities) {
		this.liabilities = liabilities;
	}

	public String getIsGroup() {
		return isGroup;
	}

	public void setIsGroup(String isGroup) {
		this.isGroup = isGroup;
	}

	public BigDecimal getSocialCapital() {
		return socialCapital;
	}

	public void setSocialCapital(BigDecimal socialCapital) {
		this.socialCapital = socialCapital;
	}

	public Date getConstitutionDate() {
		return constitutionDate;
	}

	public void setConstitutionDate(Date constitutionDate) {
		this.constitutionDate = constitutionDate;
	}

	public Integer getTerm() {
		return term;
	}

	public void setTerm(Integer term) {
		this.term = term;
	}

	public String getSocietyType() {
		return societyType;
	}

	public void setSocietyType(String societyType) {
		this.societyType = societyType;
	}

	public BigDecimal getTotalAssets() {
		return totalAssets;
	}

	public void setTotalAssets(BigDecimal totalAssets) {
		this.totalAssets = totalAssets;
	}

	public Integer getnStaff() {
		return nStaff;
	}

	public Date getIssueDate() {
		return issueDate;
	}

	public void setIssueDate(Date issueDate) {
		this.issueDate = issueDate;
	}

	public void setnStaff(Integer nStaff) {
		this.nStaff = nStaff;
	}

	public Integer getInitials() {
		return initials;
	}

	public void setInitials(Integer initials) {
		this.initials = initials;
	}

	public Integer getCity() {
		return city;
	}

	public void setCity(Integer city) {
		this.city = city;
	}

	public Date getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}

	public Date getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}

	public Date getVerificationDate() {
		return verificationDate;
	}

	public void setVerificationDate(Date verificationDate) {
		this.verificationDate = verificationDate;
	}

	public String getVerified() {
		return verified;
	}

	public void setVerified(String verified) {
		this.verified = verified;
	}

	public String getOfficial() {
		return official;
	}

	public void setOfficial(String official) {
		this.official = official;
	}

	public String getCustomerSituation() {
		return customerSituation;
	}

	public void setCustomerSituation(String customerSituation) {
		this.customerSituation = customerSituation;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getVinculation() {
		return vinculation;
	}

	public void setVinculation(String vinculation) {
		this.vinculation = vinculation;
	}

	public String getVinculationType() {
		return vinculationType;
	}

	public void setVinculationType(String vinculationType) {
		this.vinculationType = vinculationType;
	}

	public Integer getSubstituteExecutive() {
		return substituteExecutive;
	}

	public void setSubstituteExecutive(Integer substituteExecutive) {
		this.substituteExecutive = substituteExecutive;
	}

	public String getIsCustomer() {
		return isCustomer;
	}

	public void setIsCustomer(String isCustomer) {
		this.isCustomer = isCustomer;
	}

	public String getMiddleName() {
		return middleName;
	}

	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}

	public String getSuperCode() {
		return superCode;
	}

	public void setSuperCode(String superCode) {
		this.superCode = superCode;
	}

	public String getSegment() {
		return segment;
	}

	public void setSegment(String segment) {
		this.segment = segment;
	}

	public String getSocialReason() {
		return socialReason;
	}

	public void setSocialReason(String socialReason) {
		this.socialReason = socialReason;
	}

	public Integer getNationality() {
		return nationality;
	}

	public void setNationality(Integer nationality) {
		this.nationality = nationality;
	}

	public String getIdTutor() {
		return idTutor;
	}

	public void setIdTutor(String idTutor) {
		this.idTutor = idTutor;
	}

	public String getNomTutor() {
		return nomTutor;
	}

	public void setNomTutor(String nomTutor) {
		this.nomTutor = nomTutor;
	}

	public BigDecimal getOtherIcomes() {
		return otherIcomes;
	}

	public void setOtherIcomes(BigDecimal otherIcomes) {
		this.otherIcomes = otherIcomes;
	}

	public String getOriginIcomes() {
		return originIcomes;
	}

	public void setOriginIcomes(String originIcomes) {
		this.originIcomes = originIcomes;
	}

	public String getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}
	
}
