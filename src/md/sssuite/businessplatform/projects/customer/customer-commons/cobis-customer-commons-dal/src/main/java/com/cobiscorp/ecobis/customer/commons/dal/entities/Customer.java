package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "cl_ente", schema = "cobis")
@NamedQueries({
		@NamedQuery(name = "Customer.getCustomerType", query = "SELECT new com.cobiscorp.ecobis.customer.commons.dto.CustomerDTO(e.code, e.documentId, e.fullName, e.subtype, e.documentType)"
				+ " FROM  Customer e  WHERE  e.code  = :customercode"),

		@NamedQuery(name = "Customer.getCustomer", query = "select new com.cobiscorp.ecobis.customer.commons.dto.CustomerDTO(c.firstSurname, c.secondSurname, c.name, c.documentId, c.birthdate, "
				+ "c.joinDate, c.documentType, c.linkUpType, c.codeGender, c.profession, c.activity, c.civilStatus, c.personType,  c.studyLevel, c.groupOrg, c.official, c.superBancariaReported,"
				+ "c.customerSituation, c.preferredClient, c.maxDebtQuota, c.secondName, c.departmentDocuments, c.IdNationality, c.concordat, c.nit, o.officeName, c.expirationDate)"
				+ " from Customer c inner join c.office o where c.subtype = 'P' and c.code = :code "),

		@NamedQuery(name = "Customer.countCustomer", query = "SELECT count(1) from Customer e where e.code = :customercode "),

		@NamedQuery(name = "Customer.getAllLegalClient", query = "SELECT new com.cobiscorp.ecobis.customer.commons.dto.CustomerDTO"
				+ "(c.joinDate,c.documentType,c.documentId,c.fullName, c.totalAssets, c.numberEmployees, c.superBancariaReported, g.groupName, c.customerSituation,"
				+ " c.heritage, c.dateHeritage, c.preferredClient, c.maxDebtQuota, dt.descriptionDocument, c.official, c.typeCompanyId, c.linkUpType,c.segmentId, "
				+ " c.coverageId,c.groupOrg, c.activityMark, caux.status, c.entailment, caux.legalRepresentative.fullName, o.officeName, n.descriptionCountry, c.incomeLevel, c.outcomesLevel)"
				+ " from Customer c left join c.customerAux caux left join c.economicGroup g join c.documentT dt " + " left join c.office o left join c.nationality n"
				+ " where c.code = :code and c.subtype = 'C'"),

		@NamedQuery(name = "Customer.countCustomerGroup", query = "SELECT count(1) from Customer c where c.code = :customercode and c.groupOrg = :groupcode") })
/**
 * Class used to access the database using JPA
 * related table: cl_ente, bdd: cobis.
 * @author bbuendia
 *
 */
public class Customer {
	@Id
	@Column(name = "en_ente")
	private Integer code;

	@Column(name = "en_ced_ruc")
	private String documentId;

	@Column(name = "en_nombre")
	private String name;

	@Column(name = "en_nomlar")
	private String fullName;

	@Column(name = "p_p_apellido")
	private String firstSurname;

	@Column(name = "p_s_apellido")
	private String secondSurname;

	@Column(name = "en_subtipo")
	private String subtype;

	@Column(name = "en_tipo_ced")
	private String documentType;

	@Transient
	private String documentTypeDescription;

	@Column(name = "p_pasaporte")
	private String passport;

	@Column(name = "en_vinculacion")
	private String entailment;

	@Column(name = "p_fecha_nac")
	private Date birthdate;

	@Column(name = "en_fecha_crea")
	private Date joinDate;

	@Column(name = "en_tipo_vinculacion")
	private String linkUpType;

	@Transient
	private String linkUpTypeDescription;

	@Column(name = "p_sexo")
	private String codeGender;

	@Transient
	private String gender;

	@Column(name = "p_profesion")
	private String profession;

	@Transient
	private String professionDescription;

	@Column(name = "en_actividad")
	private String activity;

	@Transient
	private String activityDescription;

	@Column(name = "p_estado_civil")
	private String civilStatus;

	@Transient
	private String civilStatusDescription;

	@Column(name = "p_tipo_persona")
	private String personType;

	@Transient
	private String personTypeDescription;

	@Column(name = "p_nivel_estudio")
	private String studyLevel;

	@Transient
	private String studyLevelDescription;

	@Column(name = "en_grupo")
	private Integer groupOrg;

	@Transient
	private String groupDescription;

	@Column(name = "en_oficial")
	private Integer official;

	@Transient
	private String descriptionOfficial;

	@Transient
	private String mainLogin;

	@Column(name = "en_rep_superban")
	private String superBancariaReported;

	@Column(name = "en_situacion_cliente")
	private String customerSituation;

	@Transient
	private String customerSituationDescription;

	@Column(name = "en_preferen")
	private String preferredClient;

	@Column(name = "en_cem")
	private Double maxDebtQuota;

	@Column(name = "p_s_nombre")
	private String secondName;

	@Column(name = "p_dep_doc")
	private Integer departmentDocuments;

	@Column(name = "en_concordato")
	private String concordat;

	@Transient
	private String composedName;

	@Column(name = "p_ciudad_nac")
	private Integer cityOfBirth;

	@Transient
	private String cityOfBirthDescription;

	@Column(name = "p_lugar_doc")
	private Integer placeDoc;

	@Transient
	private String placeDocDescription;

	@ManyToOne
	@JoinColumns({ @JoinColumn(name = "en_ente", referencedColumnName = "cg_ente") })
	private CustomerGroup groupCustomer;

	@Column(name = "c_total_activos")
	private Double totalAssets;

	@Column(name = "c_num_empleados")
	private Integer numberEmployees;

	@Column(name = "en_patrimonio_tec")
	private Double heritage;

	@Column(name = "en_fecha_patri_bruto")
	private Date dateHeritage;

	@Column(name = "c_tipo_compania")
	private String typeCompanyId;

	@Column(name = "c_segmento")
	private String segmentId;

	@Column(name = "en_cobertura")
	private String coverageId;

	@Column(name = "c_activ_mark")
	private String activityMark;

	@Column(name = "en_nro_ciclo")
	private Integer cycleNumber;

	@OneToOne
	@JoinColumn(name = "en_ente", referencedColumnName = "ea_ente")
	private CustomerAux customerAux;

	@OneToOne
	@JoinColumn(name = "en_ente", referencedColumnName = "gr_representante")
	private EconomicGroup economicGroup;

	/*
	 * @ManyToOne
	 * 
	 * @JoinColumn(name = "c_activ_mark", referencedColumnName = "ac_codigo")
	 * private Activity activityEc;
	 */

	@OneToMany(mappedBy = "entity")
	private List<EconomicActivity> economyActivity;

	@ManyToOne
	@JoinColumn(name = "en_tipo_ced", referencedColumnName = "td_codigo")
	private DocumentType documentT;

	@Transient
	private String typeCompany;

	@Transient
	private String relationCorp;

	@Transient
	private String descriptionSegment;

	@Transient
	private String descriptionCoverage;

	@Transient
	private String functionaryName;

	@Column(name = "p_c_apellido")
	private String marriedLastName;

	@Column(name = "en_estado")
	private String blocked;

	@Column(name = "en_cliente")
	private String isClient;

	@Transient
	private String descriptionStatus;

	@Column(name = "c_razon_social")
	private String commercialName;

	@Column(name = "en_oficina")
	private Integer IdOffice;

	@ManyToOne
	@JoinColumn(name = "en_oficina", referencedColumnName = "of_oficina")
	private Office office;

	@Column(name = "c_rep_legal")
	private Integer IdLegalRepres;

	@Column(name = "en_nacionalidad")
	private Integer IdNationality;

	@ManyToOne
	@JoinColumn(name = "en_nacionalidad", referencedColumnName = "pa_pais")
	private Country nationality;

	@Column(name = "p_nivel_ing")
	private Double incomeLevel;

	@Column(name = "p_nivel_egr")
	private Double outcomesLevel;

	@Column(name = "en_nit")
	private String nit;

	@Column(name = "p_fecha_expira")
	private Date expirationDate;

	/** Default constructor */
	public Customer() {
	}

	public Customer(Integer code, String documentId, String fullName, String subtype, String documentType) {
		this.code = code;
		this.documentId = documentId;
		this.fullName = fullName;
		this.subtype = subtype;
		this.documentType = documentType;
	}

	public Customer(Integer code, String documentId, String name, String firstSurname, String secondSurname, String subtype, String passport, String entailment) {
		this.code = code;
		this.documentId = documentId;
		this.name = name;
		this.firstSurname = firstSurname;
		this.secondSurname = secondSurname;
		this.subtype = subtype;
		this.passport = passport;
		this.entailment = entailment;
		this.composedName = firstSurname + ' ' + secondSurname + ' ' + name;
	}

	public Customer(String firstSurname, String secondSurname, String name, String documentId, Date birthdate, Date joinDate, String documentType, String linkUpType,
			String codeGender, String profession, String activity, String civilStatus, String personType, String studyLevel, Integer groupOrg, Integer official,
			String superBancariaReported, String customerSituation, String preferredClient, Double maxDebtQuota, String secondName, Integer departmentDocuments,
			Integer idNationality, String concordat) {

		this.firstSurname = firstSurname;
		this.secondSurname = secondSurname;
		this.name = name;
		this.documentId = documentId;
		this.birthdate = birthdate;
		this.joinDate = joinDate;
		this.documentType = documentType;
		this.linkUpType = linkUpType;
		this.codeGender = codeGender;
		this.profession = profession;
		this.activity = activity;
		this.civilStatus = civilStatus;
		this.personType = personType;
		this.studyLevel = studyLevel;
		this.groupOrg = groupOrg;
		this.official = official;
		this.superBancariaReported = superBancariaReported;
		this.customerSituation = customerSituation;
		this.preferredClient = preferredClient;
		this.maxDebtQuota = maxDebtQuota;
		this.secondName = secondName;
		this.departmentDocuments = departmentDocuments;
		this.IdNationality = idNationality;
		this.concordat = concordat;
	}

	public Customer(Date joinDate, String documentType, String documentId, String fullName, Double totalAssets, Integer numberEmployees, String superBancariaReported,
			String groupName, String customerSituation, Double heritage, Date dateHeritage, String preferredClient, Double maxDebtQuota,/*
																																		 * String
																																		 * description
																																		 * ,
																																		 */
			String descriptionDocument, Integer official, String typeCompanyId, String linkUpType, String segmentId, String coverageId, Integer groupOrg, String activityMark) {

		this.joinDate = joinDate;
		this.documentType = documentType;
		this.documentId = documentId;
		this.fullName = fullName;
		this.totalAssets = totalAssets;
		this.numberEmployees = numberEmployees;
		this.superBancariaReported = superBancariaReported;
		this.customerSituation = customerSituation;
		this.heritage = heritage;
		this.dateHeritage = dateHeritage;
		this.preferredClient = preferredClient;
		this.maxDebtQuota = maxDebtQuota;
		this.economicGroup = new EconomicGroup();
		economicGroup.setGroupName(groupName);
		/*
		 * this.activityEc = new Activity();
		 * activityEc.setDescription(description);
		 */
		this.documentT = new DocumentType();
		documentT.setDescriptionDocument(descriptionDocument);
		this.official = official;
		this.typeCompanyId = typeCompanyId;
		this.linkUpType = linkUpType;
		this.segmentId = segmentId;
		this.coverageId = coverageId;
		this.groupOrg = groupOrg;
		this.activityMark = activityMark;

	}

	public Customer(Integer code, String firstSurname, String secondSurname, String marriedLastName, String name, String secondName, String documentId, String documentType,
			Integer official, String descriptionOfficial, String blocked, String status, String isClient, String descriptionStatus, String type) {

		this.code = code;
		if (type.equals("C")) {
			this.commercialName = firstSurname;
			this.marriedLastName = null;
			this.name = name;
			this.secondName = null;

		}
		if (type.equals("P")) {
			this.firstSurname = firstSurname;
			this.secondSurname = secondSurname;
			this.marriedLastName = marriedLastName;
			this.name = name;
			this.secondName = secondName;
		}

		this.documentId = documentId;
		this.documentType = documentType;
		this.official = official;
		this.descriptionOfficial = descriptionOfficial;
		this.blocked = blocked;

		this.customerAux = new CustomerAux();
		this.customerAux.setStatus(status);

		this.isClient = isClient;
		this.descriptionStatus = descriptionStatus;

	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getFirstSurname() {
		return firstSurname;
	}

	public void setFirstSurname(String firstSurname) {
		this.firstSurname = firstSurname;
	}

	public String getSecondSurname() {
		return secondSurname;
	}

	public void setSecondSurname(String secondSurname) {
		this.secondSurname = secondSurname;
	}

	public String getPassport() {
		return passport;
	}

	public void setPassport(String passport) {
		this.passport = passport;
	}

	public String getEntailment() {
		return entailment;
	}

	public void setEntailment(String entailment) {
		this.entailment = entailment;
	}

	public String getComposedName() {
		return composedName;
	}

	public void setComposedName(String composedName) {
		this.composedName = composedName;
	}

	public CustomerGroup getGroupCustomer() {
		return groupCustomer;
	}

	public void setGroupCustomer(CustomerGroup groupCustomer) {
		this.groupCustomer = groupCustomer;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getDocumentId() {
		return documentId;
	}

	public void setDocumentId(String documentId) {
		this.documentId = documentId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSubtype() {
		return subtype;
	}

	public void setSubtype(String subtype) {
		this.subtype = subtype;
	}

	public String getDocumentType() {
		return documentType;
	}

	public void setDocumentType(String documentType) {
		this.documentType = documentType;
	}

	public Double getTotalAssets() {
		return totalAssets;
	}

	public void setTotalAssets(Double totalAssets) {
		this.totalAssets = totalAssets;
	}

	public Integer getNumberEmployees() {
		return numberEmployees;
	}

	public void setNumberEmployees(Integer numberEmployees) {
		this.numberEmployees = numberEmployees;
	}

	public Double getHeritage() {
		return heritage;
	}

	public void setHeritage(Double heritage) {
		this.heritage = heritage;
	}

	public Date getDateHeritage() {
		return dateHeritage;
	}

	public void setDateHeritage(Date dateHeritage) {
		this.dateHeritage = dateHeritage;
	}

	public String getTypeCompany() {
		return typeCompany;
	}

	public void setTypeCompany(String typeCompany) {
		this.typeCompany = typeCompany;
	}

	public String getRelationCorp() {
		return relationCorp;
	}

	public void setRelationCorp(String relationCorp) {
		this.relationCorp = relationCorp;
	}

	public String getDescriptionSegment() {
		return descriptionSegment;
	}

	public void setDescriptionSegment(String descriptionSegment) {
		this.descriptionSegment = descriptionSegment;
	}

	public String getDescriptionCoverage() {
		return descriptionCoverage;
	}

	public void setDescriptionCoverage(String descriptionCoverage) {
		this.descriptionCoverage = descriptionCoverage;
	}

	public String getTypeCompanyId() {
		return typeCompanyId;
	}

	public void setTypeCompanyId(String typeCompanyId) {
		this.typeCompanyId = typeCompanyId;
	}

	public String getSegmentId() {
		return segmentId;
	}

	public void setSegmentId(String segmentId) {
		this.segmentId = segmentId;
	}

	public String getCoverageId() {
		return coverageId;
	}

	public void setCoverageId(String coverageId) {
		this.coverageId = coverageId;
	}

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	public String getLinkUpType() {
		return linkUpType;
	}

	public void setLinkUpType(String linkUpType) {
		this.linkUpType = linkUpType;
	}

	public String getCodeGender() {
		return codeGender;
	}

	public void setCodeGender(String gender) {
		this.codeGender = gender;
	}

	public String getProfession() {
		return profession;
	}

	public void setProfession(String profession) {
		this.profession = profession;
	}

	public String getActivity() {
		return activity;
	}

	public void setActivity(String activity) {
		this.activity = activity;
	}

	public String getCivilStatus() {
		return civilStatus;
	}

	public void setCivilStatus(String civilStatus) {
		this.civilStatus = civilStatus;
	}

	public String getPersonType() {
		return personType;
	}

	public void setPersonType(String personType) {
		this.personType = personType;
	}

	public String getStudyLevel() {
		return studyLevel;
	}

	public void setStudyLevel(String studyLevel) {
		this.studyLevel = studyLevel;
	}

	public Integer getGroupOrg() {
		return groupOrg;
	}

	public void setGroupOrg(Integer groupOrg) {
		this.groupOrg = groupOrg;
	}

	public Integer getOfficial() {
		return official;
	}

	public void setOfficial(Integer official) {
		this.official = official;
	}

	public String getSuperBancariaReported() {
		return superBancariaReported;
	}

	public void setSuperBancariaReported(String superBancariaReported) {
		this.superBancariaReported = superBancariaReported;
	}

	public String getCustomerSituation() {
		return customerSituation;
	}

	public void setCustomerSituation(String customerSituation) {
		this.customerSituation = customerSituation;
	}

	public String getPreferredClient() {
		return preferredClient;
	}

	public void setPreferredClient(String preferredClient) {
		this.preferredClient = preferredClient;
	}

	public Double getMaxDebtQuota() {
		return maxDebtQuota;
	}

	public void setMaxDebtQuota(Double maxDebtQuota) {
		this.maxDebtQuota = maxDebtQuota;
	}

	public String getSecondName() {
		return secondName;
	}

	public void setSecondName(String secondName) {
		this.secondName = secondName;
	}

	public Integer getDepartmentDocuments() {
		return departmentDocuments;
	}

	public void setDepartmentDocuments(Integer departmentDocuments) {
		this.departmentDocuments = departmentDocuments;
	}

	public Country getNationality() {
		return nationality;
	}

	public void setNationality(Country nationality) {
		this.nationality = nationality;
	}

	public String getConcordat() {
		return concordat;
	}

	public void setConcordat(String concordat) {
		this.concordat = concordat;
	}

	public String getGroupDescription() {
		return groupDescription;
	}

	public void setGroupDescription(String groupDescription) {
		this.groupDescription = groupDescription;
	}

	public String getDescriptionOfficial() {
		return descriptionOfficial;
	}

	public void setDescriptionOfficial(String temporalName) {
		this.descriptionOfficial = temporalName;
	}

	public String getMainLogin() {
		return mainLogin;
	}

	public void setMainLogin(String mainLogin) {
		this.mainLogin = mainLogin;
	}

	public String getCustomerSituationDescription() {
		return customerSituationDescription;
	}

	public void setCustomerSituationDescription(String customerSituationDescription) {
		this.customerSituationDescription = customerSituationDescription;
	}

	public String getLinkUpTypeDescription() {
		return linkUpTypeDescription;
	}

	public void setLinkUpTypeDescription(String linkUpTypeDescription) {
		this.linkUpTypeDescription = linkUpTypeDescription;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getProfessionDescription() {
		return professionDescription;
	}

	public void setProfessionDescription(String professionDescription) {
		this.professionDescription = professionDescription;
	}

	public String getActivityDescription() {
		return activityDescription;
	}

	public void setActivityDescription(String activityDescription) {
		this.activityDescription = activityDescription;
	}

	public String getCivilStatusDescription() {
		return civilStatusDescription;
	}

	public void setCivilStatusDescription(String civilStatusDescription) {
		this.civilStatusDescription = civilStatusDescription;
	}

	public String getPersonTypeDescription() {
		return personTypeDescription;
	}

	public void setPersonTypeDescription(String personTypeDescription) {
		this.personTypeDescription = personTypeDescription;
	}

	public String getStudyLevelDescription() {
		return studyLevelDescription;
	}

	public void setStudyLevelDescription(String studyLevelDescription) {
		this.studyLevelDescription = studyLevelDescription;
	}

	public Integer getCityOfBirth() {
		return cityOfBirth;
	}

	public void setCityOfBirth(Integer cityOfBirth) {
		this.cityOfBirth = cityOfBirth;
	}

	public String getCityOfBirthDescription() {
		return cityOfBirthDescription;
	}

	public void setCityOfBirthDescription(String cityOfBirthDescription) {
		this.cityOfBirthDescription = cityOfBirthDescription;
	}

	public Integer getPlaceDoc() {
		return placeDoc;
	}

	public void setPlaceDoc(Integer placeDoc) {
		this.placeDoc = placeDoc;
	}

	public String getPlaceDocDescription() {
		return placeDocDescription;
	}

	public void setPlaceDocDescription(String placeDocDescription) {
		this.placeDocDescription = placeDocDescription;
	}

	public String getDocumentTypeDescription() {
		return documentTypeDescription;
	}

	public void setDocumentTypeDescription(String documentTypeDescription) {
		this.documentTypeDescription = documentTypeDescription;
	}

	public String getFunctionaryName() {
		return functionaryName;
	}

	public void setFunctionaryName(String functionaryName) {
		this.functionaryName = functionaryName;
	}

	public String getActivityMark() {
		return activityMark;
	}

	public void setActivityMark(String activityMark) {
		this.activityMark = activityMark;
	}

	public CustomerAux getCustomerAux() {
		return customerAux;
	}

	public void setCustomerAux(CustomerAux customerAux) {
		this.customerAux = customerAux;
	}

	public String getMarriedLastName() {
		return marriedLastName;
	}

	public void setMarriedLastName(String marriedLastName) {
		this.marriedLastName = marriedLastName;
	}

	public String getBlocked() {
		return blocked;
	}

	public void setBlocked(String blocked) {
		this.blocked = blocked;
	}

	public EconomicGroup getEconomicGroup() {
		return economicGroup;
	}

	public void setEconomicGroup(EconomicGroup economicGroup) {
		this.economicGroup = economicGroup;
	}

	/*
	 * public Activity getActivityEc() { return activityEc; }
	 * 
	 * public void setActivityEc(Activity activityEc) { this.activityEc =
	 * activityEc; }
	 */

	public DocumentType getDocumentT() {
		return documentT;
	}

	public void setDocumentT(DocumentType documentT) {
		this.documentT = documentT;
	}

	public String getIsClient() {
		return isClient;
	}

	public String getCommercialName() {
		return commercialName;
	}

	public void setCommercialName(String commercialName) {
		this.commercialName = commercialName;
	}

	public void setIsClient(String isClient) {
		this.isClient = isClient;
	}

	public String getDescriptionStatus() {
		return descriptionStatus;
	}

	public void setDescriptionStatus(String descriptionStatus) {
		this.descriptionStatus = descriptionStatus;
	}

	public List<EconomicActivity> getEconomyActivity() {
		return economyActivity;
	}

	public void setEconomyActivity(List<EconomicActivity> economyActivity) {
		this.economyActivity = economyActivity;
	}

	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	public Integer getIdOffice() {
		return IdOffice;
	}

	public void setIdOffice(Integer idOffice) {
		IdOffice = idOffice;
	}

	public Integer getIdLegalRepres() {
		return IdLegalRepres;
	}

	public void setIdLegalRepres(Integer idLegalRepres) {
		IdLegalRepres = idLegalRepres;
	}

	public Integer getIdNationality() {
		return IdNationality;
	}

	public void setIdNationality(Integer idNationality) {
		IdNationality = idNationality;
	}

	public Double getIncomeLevel() {
		return incomeLevel;
	}

	public void setIncomeLevel(Double incomeLevel) {
		this.incomeLevel = incomeLevel;
	}

	public Double getOutcomesLevel() {
		return outcomesLevel;
	}

	public void setOutcomesLevel(Double outcomesLevel) {
		this.outcomesLevel = outcomesLevel;
	}

	/**
	 * @return the nit
	 */
	public String getNit() {
		return nit;
	}

	/**
	 * @param nit
	 *            the nit to set
	 */
	public void setNit(String nit) {
		this.nit = nit;
	}

	/**
	 * @return the expirationDate
	 */
	public Date getExpirationDate() {
		return expirationDate;
	}

	/**
	 * @param expirationDate
	 *            the expirationDate to set
	 */
	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}

	public Integer getCycleNumber() {
		return cycleNumber;
	}

	public void setCycleNumber(Integer cycleNumber) {
		this.cycleNumber = cycleNumber;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
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
		Customer other = (Customer) obj;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Customer [code=" + code + ", documentId=" + documentId + ", name=" + name + ", fullName=" + fullName + ", firstSurname=" + firstSurname + ", secondSurname="
				+ secondSurname + ", subtype=" + subtype + ", documentType=" + documentType + ", documentTypeDescription=" + documentTypeDescription + ", passport=" + passport
				+ ", entailment=" + entailment + ", birthdate=" + birthdate + ", joinDate=" + joinDate + ", linkUpType=" + linkUpType + ", linkUpTypeDescription="
				+ linkUpTypeDescription + ", codeGender=" + codeGender + ", gender=" + gender + ", profession=" + profession + ", professionDescription=" + professionDescription
				+ ", activity=" + activity + ", activityDescription=" + activityDescription + ", civilStatus=" + civilStatus + ", civilStatusDescription=" + civilStatusDescription
				+ ", personType=" + personType + ", personTypeDescription=" + personTypeDescription + ", studyLevel=" + studyLevel + ", studyLevelDescription="
				+ studyLevelDescription + ", groupOrg=" + groupOrg + ", groupDescription=" + groupDescription + ", official=" + official + ", descriptionOfficial="
				+ descriptionOfficial + ", mainLogin=" + mainLogin + ", superBancariaReported=" + superBancariaReported + ", customerSituation=" + customerSituation
				+ ", customerSituationDescription=" + customerSituationDescription + ", preferredClient=" + preferredClient + ", maxDebtQuota=" + maxDebtQuota + ", secondName="
				+ secondName + ", departmentDocuments=" + departmentDocuments + ", nationality=" + nationality + ", concordat=" + concordat + ", composedName=" + composedName
				+ ", cityOfBirth=" + cityOfBirth + ", cityOfBirthDescription=" + cityOfBirthDescription + ", placeDoc=" + placeDoc + ", placeDocDescription=" + placeDocDescription
				+ ", groupCustomer=" + groupCustomer + ", totalAssets=" + totalAssets + ", numberEmployees=" + numberEmployees + ", heritage=" + heritage + ", dateHeritage="
				+ dateHeritage + ", typeCompanyId=" + typeCompanyId + ", segmentId=" + segmentId + ", coverageId=" + coverageId + ", activityMark=" + activityMark
				+ ", customerAux=" + customerAux + ", economicGroup=" + economicGroup + ", documentT=" + documentT + ", typeCompany=" + typeCompany + ", relationCorp="
				+ relationCorp + ", descriptionSegment=" + descriptionSegment + ", descriptionCoverage=" + descriptionCoverage + ", FunctionaryName=" + functionaryName
				+ ", marriedLastName=" + marriedLastName + ", blocked=" + blocked + ", isClient=" + isClient + ", descriptionStatus=" + descriptionStatus + ", commercialName="
				+ commercialName + "]";
	}

}
