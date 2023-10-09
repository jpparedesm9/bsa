package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.io.Serializable;

import javax.persistence.*;

import java.sql.Date;
import java.util.List;
import java.math.BigDecimal;

/**
 * The persistent class for the cl_ente database table.
 * 
 */
@Entity
@Table(name = "cl_ente", schema = "cobis")
@NamedQueries({
		@NamedQuery(name = "Ente.getAsfiByClientId", query = " SELECT new com.cobiscorp.ecobis.clientviewer.dto.AsfiViewDTO(vcc.branchDepartCod, vcc.entityCode, vcc.obligatedCode, vcc.correlativeNumber, vcc.ente, "
				+ " vcc.badDebtBalance, vcc.contingentDebtBalance, vcc.executionDebtBalance, vcc.expiredDebtBalance, vcc.currentDebtBalance, "
				+ " vcc.totalBalance, vcc.debtType, vcc.calificacion) from AsfiView vcc where vcc.ente=:ente and (vcc.totalBalance > 0 or vcc.contingentDebtBalance>0)"),
		@NamedQuery(name = "Ente.getInfoCredByClientId", query = " "
				+ " SELECT new com.cobiscorp.ecobis.clientviewer.dto.InfoCredDTO(i.entity, i.currentStatus, i.dateActDebt, i.dateCreaDebt, i.birthday, "
				+ " i.cId, i.currentAmount, i.largeName, i.loanType, i.idType, i.obligationType, e.ente) " + " FROM Ente e, InfoCred i "
				+ " WHERE e.cedRuc = i.cId and e.ente=:customer " + " "),
		@NamedQuery(name = "Ente.getPortfolioRate", query = " "
				+ " SELECT new com.cobiscorp.ecobis.clientviewer.dto.EnteDTO(e.ente, e.portfolioRating) " + " FROM Ente e WHERE e.ente=:customer "
				+ " ") })
public class Ente implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name = "c_activ_mark")
	private String activeMark;

	@Column(name = "c_activo")
	private BigDecimal active;

	@Column(name = "c_camara")
	private String chamber;

	@Column(name = "c_cap_pagado")
	private BigDecimal paymentCap;

	@Column(name = "c_cap_suscrito")
	private BigDecimal subscribeCap;

	@Column(name = "c_capital_social")
	private BigDecimal capitalSocial;

	@Column(name = "c_ciudad")
	private Integer city;

	@Column(name = "c_codsuper")
	private String codSuper;

	@Column(name = "c_direccion_domicilio")
	private Integer homeAddress;

	@Column(name = "c_edad_laboral_promedio")
	private double averageWorkingAge;

	@Column(name = "c_empleados_ley_50")
	private double lawEmployee50;

	@Column(name = "c_es_grupo")
	private String isGroup;

	@Column(name = "c_escritura")
	private String writing;

	@Column(name = "c_fecha_aum_capital")
	private Date dateCapitalIncreased;

	@Column(name = "c_fecha_const")
	private Date dateConst;

	@Column(name = "c_fecha_exp")
	private Date expDate;

	@Column(name = "c_fecha_inscrp")
	private Date inscripDate;

	@Column(name = "c_fecha_modif")
	private Date modifDate;

	@Column(name = "c_fecha_registro")
	private Date registerDate;

	@Column(name = "c_fecha_vcto")
	private Date vctoDate;

	@Column(name = "c_fecha_verif")
	private Date verifDate;

	@Column(name = "c_folio_patc")
	private String patcFolio;

	private String c_Folio_PatC;

	@Column(name = "c_folio_pats")
	private String patsFolio;

	@Column(name = "c_funcionario")
	private String functionary;

	@Column(name = "c_grado_soc")
	private String socGrade;

	@Column(name = "c_libro_patc")
	private String patcBook;

	@Column(name = "c_libro_pats")
	private String patsBook;

	@Column(name = "c_nicho")
	private String niche;

	@Column(name = "c_no_exp_patc")
	private String noExpPatc;

	@Column(name = "c_no_exp_pats")
	private String noExpPats;

	@Column(name = "c_no_patc")
	private String noPatc;

	@Column(name = "c_no_pats")
	private String noPats;

	@Column(name = "c_notaria")
	private short notary;

	@Column(name = "c_num_empleados")
	private short employeeNumber;

	@Column(name = "c_pasivo")
	private BigDecimal pasive;

	@Column(name = "c_plazo")
	private short term;

	@Column(name = "c_posicion")
	private String position;

	@Column(name = "c_prop_int")
	private Integer propInt;

	@Column(name = "c_razon_social")
	private String businessName;

	@Column(name = "c_registro")
	private Integer register;

	@Column(name = "c_rep_legal")
	private Integer legalRepresentative;

	@Column(name = "c_reserva_legal")
	private BigDecimal legalReserve;

	@Column(name = "c_segmento")
	private String segment;

	@Column(name = "c_sigla")
	private String acronym;

	@Column(name = "c_subemp")
	private String subEmp;

	@Column(name = "c_subemp1")
	private String subEmp1;

	@Column(name = "c_subemp2")
	private String subEmp2;

	@Column(name = "c_subspub")
	private String subsPub;

	@Column(name = "c_tiempo")
	private String time;

	@Column(name = "c_tipo_compania")
	private String companyType;

	@Column(name = "c_tipo_nit")
	private String nitType;

	@Column(name = "c_tipo_soc")
	private String socType;

	@Column(name = "c_tipspub")
	private String pubTips;

	@Column(name = "c_total_activos")
	private BigDecimal totalAssets;

	@Column(name = "c_verificado")
	private String verified;

	@Column(name = "c_vigencia")
	private String validity;

	@Column(name = "en_actividad")
	private String activity;

	@Column(name = "en_asosciada")
	private String associated;

	@Column(name = "en_balance")
	private short balance;

	@Column(name = "en_calif_cartera")
	private String portfolioRating;

	@Column(name = "en_calif_sistema")
	private String ratingSystem;

	@Column(name = "en_calificacion")
	private String rate;

	@Column(name = "en_casilla")
	private short box;

	@Column(name = "en_casilla_def")
	private String defBox;

	@Column(name = "en_ced_ruc")
	private String cedRuc;

	@Column(name = "en_cem")
	private BigDecimal cem;

	@Column(name = "en_cliente")
	private String cliente;

	@Column(name = "en_cobertura")
	private String coverage;

	@Column(name = "en_cod_otro_pais")
	private String otherCountryCode;

	@Column(name = "en_comentario")
	private String commentary;

	@Column(name = "en_concordato")
	private String concordat;

	@Column(name = "en_concurso_acreedores")
	private String bankruptcy;

	@Column(name = "en_cont_malas")
	private short contMalas;

	@Column(name = "en_digito")
	private String digit;

	@Column(name = "en_direccion")
	private short address;

	@Column(name = "en_doc_validado")
	private String validatedDoc;

	@Column(name = "en_ente")
	private Integer ente;

	@OneToMany(mappedBy = "enteAsfi")
	private List<Asfi> asfi;

	@Column(name = "en_estado")
	private String status;

	@Column(name = "en_exc_por2")
	private String excPor2;

	@Column(name = "en_exc_sipla")
	private String excSipla;

	@Column(name = "en_fecha_crea")
	private Date creationDate;

	@Column(name = "en_fecha_mod")
	private Date modificationDate;

	@Column(name = "en_fecha_patri_bruto")
	private Date datePatriBruto;

	@Column(name = "en_filial")
	private short subsidiary;

	@Column(name = "en_gran_contribuyente")
	private String granContributor;

	@Column(name = "en_grupo")
	private Integer group;

	@Column(name = "en_id_tutor")
	private String tutorId;

	@Column(name = "en_ingre")
	private String ingre;

	@Column(name = "en_inss")
	private String inss;

	@Column(name = "en_licencia")
	private String license;

	@Column(name = "en_mala_referencia")
	private String badReference;

	@Column(name = "en_nacionalidad")
	private Integer nationality;

	@Column(name = "en_nit")
	private String nit;

	@Column(name = "en_nom_tutor")
	private String tutorName;

	@Column(name = "en_nombre")
	private String name;

	@Column(name = "en_nomlar")
	private String largeName;

	@Column(name = "en_oficial")
	private short official;

	@Column(name = "en_oficial_sup")
	private short officialSup;

	@Column(name = "en_oficina")
	private short office;

	@Column(name = "en_origen_ingresos")
	private String sourceFunds;

	@Column(name = "en_otros_ingresos")
	private BigDecimal otherFunds;

	@Column(name = "en_pais")
	private short country;

	@Column(name = "en_patrimonio_tec")
	private BigDecimal heritageTec;

	@Column(name = "en_preferen")
	private String preference;

	@Column(name = "en_promotor")
	private String promoter;

	@Column(name = "en_reestructurado")
	private String restructured;

	@Column(name = "en_referencia")
	private short reference;

	@Column(name = "en_referido")
	private short referred;

	@Column(name = "en_referidor_ecu")
	private Integer referrerEcu;

	@Column(name = "en_rep_superban")
	private String superBanRep;

	@Column(name = "en_retencion")
	private String retention;

	@Column(name = "en_sector")
	private String sector;

	@Column(name = "en_situacion_cliente")
	private String clientSituation;

	@Column(name = "en_subtipo")
	private String subtype;

	@Column(name = "en_suplidores")
	private String suppliers;

	@Column(name = "en_tipo_ced")
	private String typeCed;

	@Column(name = "en_tipo_dp")
	private String typeDp;

	@Column(name = "en_tipo_vinculacion")
	private String vinculationType;

	@Column(name = "en_vinculacion")
	private String vinculation;

	@Column(name = "p_bienes")
	private String possessions;

	@Column(name = "p_c_apellido")
	private String cLastName;

	@Column(name = "p_calif_cliente")
	private String clientRate;

	@Column(name = "p_carg_pub")
	private String cargPub;

	@Column(name = "p_ciudad_nac")
	private Integer cityBirth;

	@Column(name = "p_dep_doc")
	private Integer depDoc;

	@Column(name = "p_estado_civil")
	private String maritalStatus;

	@Column(name = "p_fecha_emision")
	private Date releaseDate;

	@Column(name = "p_fecha_expira")
	private Date expirationDate;

	@Column(name = "p_fecha_nac")
	private Date birthDay;

	@Column(name = "p_infcta")
	private Integer infAcc;

	@Column(name = "p_lugar_doc")
	private Integer placeDoc;

	@Column(name = "p_nivel_egr")
	private BigDecimal expensesLevel;

	@Column(name = "p_nivel_estudio")
	private String educationLevel;

	@Column(name = "p_nivel_ing")
	private BigDecimal incomeLevel;

	@Column(name = "p_num_cargas")
	private short pNumCargas;

	@Column(name = "p_num_hijos")
	private short childrenNumber;

	@Column(name = "p_numord")
	private String numOrd;

	@Column(name = "p_p_apellido")
	private String pLastName;

	@Column(name = "p_pasaporte")
	private String passport;

	@Column(name = "p_personal")
	private short personal;

	@Column(name = "p_profesion")
	private String profession;

	@Column(name = "p_propiedad")
	private short propiety;

	@Column(name = "p_rel_carg_pub")
	private String relPubPos;

	@Column(name = "p_s_apellido")
	private String sLastName;

	@Column(name = "p_s_nombre")
	private String sName;

	@Column(name = "p_sexo")
	private String genre;

	@Column(name = "p_situacion_laboral")
	private String workingStatus;

	@Column(name = "p_soc_hecho")
	private short socAct;

	@Column(name = "p_tipo_persona")
	private String typePerson;

	@Column(name = "p_tipo_vivienda")
	private String propertyType;

	@Column(name = "p_trabajo")
	private short job;

	@Column(name = "s_tipo_soc_hecho")
	private String typeSocAct;

	public Ente() {
	}

	public String getActiveMark() {
		return activeMark;
	}

	public void setActiveMark(String activeMark) {
		this.activeMark = activeMark;
	}

	public BigDecimal getActive() {
		return active;
	}

	public void setActive(BigDecimal active) {
		this.active = active;
	}

	public String getChamber() {
		return chamber;
	}

	public void setChamber(String chamber) {
		this.chamber = chamber;
	}

	public BigDecimal getPaymentCap() {
		return paymentCap;
	}

	public void setPaymentCap(BigDecimal paymentCap) {
		this.paymentCap = paymentCap;
	}

	public BigDecimal getSubscribeCap() {
		return subscribeCap;
	}

	public void setSubscribeCap(BigDecimal subscribeCap) {
		this.subscribeCap = subscribeCap;
	}

	public BigDecimal getCapitalSocial() {
		return capitalSocial;
	}

	public void setCapitalSocial(BigDecimal capitalSocial) {
		this.capitalSocial = capitalSocial;
	}

	public Integer getCity() {
		return city;
	}

	public void setCity(Integer city) {
		this.city = city;
	}

	public String getCodSuper() {
		return codSuper;
	}

	public void setCodSuper(String codSuper) {
		this.codSuper = codSuper;
	}

	public Integer getHomeAddress() {
		return homeAddress;
	}

	public void setHomeAddress(Integer homeAddress) {
		this.homeAddress = homeAddress;
	}

	public double getAverageWorkingAge() {
		return averageWorkingAge;
	}

	public void setAverageWorkingAge(double averageWorkingAge) {
		this.averageWorkingAge = averageWorkingAge;
	}

	public double getLawEmployee50() {
		return lawEmployee50;
	}

	public void setLawEmployee50(double lawEmployee50) {
		this.lawEmployee50 = lawEmployee50;
	}

	public String getIsGroup() {
		return isGroup;
	}

	public void setIsGroup(String isGroup) {
		this.isGroup = isGroup;
	}

	public String getWriting() {
		return writing;
	}

	public void setWriting(String writing) {
		this.writing = writing;
	}

	public Date getDateCapitalIncreased() {
		return dateCapitalIncreased;
	}

	public void setDateCapitalIncreased(Date dateCapitalIncreased) {
		this.dateCapitalIncreased = dateCapitalIncreased;
	}

	public Date getDateConst() {
		return dateConst;
	}

	public void setDateConst(Date dateConst) {
		this.dateConst = dateConst;
	}

	public Date getExpDate() {
		return expDate;
	}

	public void setExpDate(Date expDate) {
		this.expDate = expDate;
	}

	public Date getInscripDate() {
		return inscripDate;
	}

	public void setInscripDate(Date inscripDate) {
		this.inscripDate = inscripDate;
	}

	public Date getModifDate() {
		return modifDate;
	}

	public void setModifDate(Date modifDate) {
		this.modifDate = modifDate;
	}

	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	public Date getVctoDate() {
		return vctoDate;
	}

	public void setVctoDate(Date vctoDate) {
		this.vctoDate = vctoDate;
	}

	public Date getVerifDate() {
		return verifDate;
	}

	public void setVerifDate(Date verifDate) {
		this.verifDate = verifDate;
	}

	public String getPatcFolio() {
		return patcFolio;
	}

	public void setPatcFolio(String patcFolio) {
		this.patcFolio = patcFolio;
	}

	public String getC_Folio_PatC() {
		return c_Folio_PatC;
	}

	public void setC_Folio_PatC(String c_Folio_PatC) {
		this.c_Folio_PatC = c_Folio_PatC;
	}

	public String getPatsFolio() {
		return patsFolio;
	}

	public void setPatsFolio(String patsFolio) {
		this.patsFolio = patsFolio;
	}

	public String getFunctionary() {
		return functionary;
	}

	public void setFunctionary(String functionary) {
		this.functionary = functionary;
	}

	public String getSocGrade() {
		return socGrade;
	}

	public void setSocGrade(String socGrade) {
		this.socGrade = socGrade;
	}

	public String getPatcBook() {
		return patcBook;
	}

	public void setPatcBook(String patcBook) {
		this.patcBook = patcBook;
	}

	public String getPatsBook() {
		return patsBook;
	}

	public void setPatsBook(String patsBook) {
		this.patsBook = patsBook;
	}

	public String getNiche() {
		return niche;
	}

	public void setNiche(String niche) {
		this.niche = niche;
	}

	public String getNoExpPatc() {
		return noExpPatc;
	}

	public void setNoExpPatc(String noExpPatc) {
		this.noExpPatc = noExpPatc;
	}

	public String getNoExpPats() {
		return noExpPats;
	}

	public void setNoExpPats(String noExpPats) {
		this.noExpPats = noExpPats;
	}

	public String getNoPatc() {
		return noPatc;
	}

	public void setNoPatc(String noPatc) {
		this.noPatc = noPatc;
	}

	public String getNoPats() {
		return noPats;
	}

	public void setNoPats(String noPats) {
		this.noPats = noPats;
	}

	public short getNotary() {
		return notary;
	}

	public void setNotary(short notary) {
		this.notary = notary;
	}

	public short getEmployeeNumber() {
		return employeeNumber;
	}

	public void setEmployeeNumber(short employeeNumber) {
		this.employeeNumber = employeeNumber;
	}

	public BigDecimal getPasive() {
		return pasive;
	}

	public void setPasive(BigDecimal pasive) {
		this.pasive = pasive;
	}

	public short getTerm() {
		return term;
	}

	public void setTerm(short term) {
		this.term = term;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public Integer getPropInt() {
		return propInt;
	}

	public void setPropInt(Integer propInt) {
		this.propInt = propInt;
	}

	public String getBusinessName() {
		return businessName;
	}

	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}

	public Integer getRegister() {
		return register;
	}

	public void setRegister(Integer register) {
		this.register = register;
	}

	public Integer getLegalRepresentative() {
		return legalRepresentative;
	}

	public void setLegalRepresentative(Integer legalRepresentative) {
		this.legalRepresentative = legalRepresentative;
	}

	public BigDecimal getLegalReserve() {
		return legalReserve;
	}

	public void setLegalReserve(BigDecimal legalReserve) {
		this.legalReserve = legalReserve;
	}

	public String getSegment() {
		return segment;
	}

	public void setSegment(String segment) {
		this.segment = segment;
	}

	public String getAcronym() {
		return acronym;
	}

	public void setAcronym(String acronym) {
		this.acronym = acronym;
	}

	public String getSubEmp() {
		return subEmp;
	}

	public void setSubEmp(String subEmp) {
		this.subEmp = subEmp;
	}

	public String getSubEmp1() {
		return subEmp1;
	}

	public void setSubEmp1(String subEmp1) {
		this.subEmp1 = subEmp1;
	}

	public String getSubEmp2() {
		return subEmp2;
	}

	public void setSubEmp2(String subEmp2) {
		this.subEmp2 = subEmp2;
	}

	public String getSubsPub() {
		return subsPub;
	}

	public void setSubsPub(String subsPub) {
		this.subsPub = subsPub;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getCompanyType() {
		return companyType;
	}

	public void setCompanyType(String companyType) {
		this.companyType = companyType;
	}

	public String getNitType() {
		return nitType;
	}

	public void setNitType(String nitType) {
		this.nitType = nitType;
	}

	public String getSocType() {
		return socType;
	}

	public void setSocType(String socType) {
		this.socType = socType;
	}

	public String getPubTips() {
		return pubTips;
	}

	public void setPubTips(String pubTips) {
		this.pubTips = pubTips;
	}

	public BigDecimal getTotalAssets() {
		return totalAssets;
	}

	public void setTotalAssets(BigDecimal totalAssets) {
		this.totalAssets = totalAssets;
	}

	public String getVerified() {
		return verified;
	}

	public void setVerified(String verified) {
		this.verified = verified;
	}

	public String getValidity() {
		return validity;
	}

	public void setValidity(String validity) {
		this.validity = validity;
	}

	public String getActivity() {
		return activity;
	}

	public void setActivity(String activity) {
		this.activity = activity;
	}

	public String getAssociated() {
		return associated;
	}

	public void setAssociated(String associated) {
		this.associated = associated;
	}

	public short getBalance() {
		return balance;
	}

	public void setBalance(short balance) {
		this.balance = balance;
	}

	public String getPortfolioRating() {
		return portfolioRating;
	}

	public void setPortfolioRating(String portfolioRating) {
		this.portfolioRating = portfolioRating;
	}

	public String getRatingSystem() {
		return ratingSystem;
	}

	public void setRatingSystem(String ratingSystem) {
		this.ratingSystem = ratingSystem;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public short getBox() {
		return box;
	}

	public void setBox(short box) {
		this.box = box;
	}

	public String getDefBox() {
		return defBox;
	}

	public void setDefBox(String defBox) {
		this.defBox = defBox;
	}

	public String getCedRuc() {
		return cedRuc;
	}

	public void setCedRuc(String cedRuc) {
		this.cedRuc = cedRuc;
	}

	public BigDecimal getCem() {
		return cem;
	}

	public void setCem(BigDecimal cem) {
		this.cem = cem;
	}

	public String getCliente() {
		return cliente;
	}

	public void setCliente(String cliente) {
		this.cliente = cliente;
	}

	public String getCoverage() {
		return coverage;
	}

	public void setCoverage(String coverage) {
		this.coverage = coverage;
	}

	public String getOtherCountryCode() {
		return otherCountryCode;
	}

	public void setOtherCountryCode(String otherCountryCode) {
		this.otherCountryCode = otherCountryCode;
	}

	public String getCommentary() {
		return commentary;
	}

	public void setCommentary(String commentary) {
		this.commentary = commentary;
	}

	public String getConcordat() {
		return concordat;
	}

	public void setConcordat(String concordat) {
		this.concordat = concordat;
	}

	public String getBankruptcy() {
		return bankruptcy;
	}

	public void setBankruptcy(String bankruptcy) {
		this.bankruptcy = bankruptcy;
	}

	public short getContMalas() {
		return contMalas;
	}

	public void setContMalas(short contMalas) {
		this.contMalas = contMalas;
	}

	public String getDigit() {
		return digit;
	}

	public void setDigit(String digit) {
		this.digit = digit;
	}

	public short getAddress() {
		return address;
	}

	public void setAddress(short address) {
		this.address = address;
	}

	public String getValidatedDoc() {
		return validatedDoc;
	}

	public void setValidatedDoc(String validatedDoc) {
		this.validatedDoc = validatedDoc;
	}

	public Integer getEnte() {
		return ente;
	}

	public void setEnte(Integer ente) {
		this.ente = ente;
	}

	public List<Asfi> getAsfi() {
		return asfi;
	}

	public void setAsfi(List<Asfi> asfi) {
		this.asfi = asfi;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getExcPor2() {
		return excPor2;
	}

	public void setExcPor2(String excPor2) {
		this.excPor2 = excPor2;
	}

	public String getExcSipla() {
		return excSipla;
	}

	public void setExcSipla(String excSipla) {
		this.excSipla = excSipla;
	}

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	public Date getModificationDate() {
		return modificationDate;
	}

	public void setModificationDate(Date modificationDate) {
		this.modificationDate = modificationDate;
	}

	public Date getDatePatriBruto() {
		return datePatriBruto;
	}

	public void setDatePatriBruto(Date datePatriBruto) {
		this.datePatriBruto = datePatriBruto;
	}

	public short getSubsidiary() {
		return subsidiary;
	}

	public void setSubsidiary(short subsidiary) {
		this.subsidiary = subsidiary;
	}

	public String getGranContributor() {
		return granContributor;
	}

	public void setGranContributor(String granContributor) {
		this.granContributor = granContributor;
	}

	public Integer getGroup() {
		return group;
	}

	public void setGroup(Integer group) {
		this.group = group;
	}

	public String getTutorId() {
		return tutorId;
	}

	public void setTutorId(String tutorId) {
		this.tutorId = tutorId;
	}

	public String getIngre() {
		return ingre;
	}

	public void setIngre(String ingre) {
		this.ingre = ingre;
	}

	public String getInss() {
		return inss;
	}

	public void setInss(String inss) {
		this.inss = inss;
	}

	public String getLicense() {
		return license;
	}

	public void setLicense(String license) {
		this.license = license;
	}

	public String getBadReference() {
		return badReference;
	}

	public void setBadReference(String badReference) {
		this.badReference = badReference;
	}

	public Integer getNationality() {
		return nationality;
	}

	public void setNationality(Integer nationality) {
		this.nationality = nationality;
	}

	public String getNit() {
		return nit;
	}

	public void setNit(String nit) {
		this.nit = nit;
	}

	public String getTutorName() {
		return tutorName;
	}

	public void setTutorName(String tutorName) {
		this.tutorName = tutorName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLargeName() {
		return largeName;
	}

	public void setLargeName(String largeName) {
		this.largeName = largeName;
	}

	public short getOfficial() {
		return official;
	}

	public void setOfficial(short official) {
		this.official = official;
	}

	public short getOfficialSup() {
		return officialSup;
	}

	public void setOfficialSup(short officialSup) {
		this.officialSup = officialSup;
	}

	public short getOffice() {
		return office;
	}

	public void setOffice(short office) {
		this.office = office;
	}

	public String getSourceFunds() {
		return sourceFunds;
	}

	public void setSourceFunds(String sourceFunds) {
		this.sourceFunds = sourceFunds;
	}

	public BigDecimal getOtherFunds() {
		return otherFunds;
	}

	public void setOtherFunds(BigDecimal otherFunds) {
		this.otherFunds = otherFunds;
	}

	public short getCountry() {
		return country;
	}

	public void setCountry(short country) {
		this.country = country;
	}

	public BigDecimal getHeritageTec() {
		return heritageTec;
	}

	public void setHeritageTec(BigDecimal heritageTec) {
		this.heritageTec = heritageTec;
	}

	public String getPreference() {
		return preference;
	}

	public void setPreference(String preference) {
		this.preference = preference;
	}

	public String getPromoter() {
		return promoter;
	}

	public void setPromoter(String promoter) {
		this.promoter = promoter;
	}

	public String getRestructured() {
		return restructured;
	}

	public void setRestructured(String restructured) {
		this.restructured = restructured;
	}

	public short getReference() {
		return reference;
	}

	public void setReference(short reference) {
		this.reference = reference;
	}

	public short getReferred() {
		return referred;
	}

	public void setReferred(short referred) {
		this.referred = referred;
	}

	public Integer getReferrerEcu() {
		return referrerEcu;
	}

	public void setReferrerEcu(Integer referrerEcu) {
		this.referrerEcu = referrerEcu;
	}

	public String getSuperBanRep() {
		return superBanRep;
	}

	public void setSuperBanRep(String superBanRep) {
		this.superBanRep = superBanRep;
	}

	public String getRetention() {
		return retention;
	}

	public void setRetention(String retention) {
		this.retention = retention;
	}

	public String getSector() {
		return sector;
	}

	public void setSector(String sector) {
		this.sector = sector;
	}

	public String getClientSituation() {
		return clientSituation;
	}

	public void setClientSituation(String clientSituation) {
		this.clientSituation = clientSituation;
	}

	public String getSubtype() {
		return subtype;
	}

	public void setSubtype(String subtype) {
		this.subtype = subtype;
	}

	public String getSuppliers() {
		return suppliers;
	}

	public void setSuppliers(String suppliers) {
		this.suppliers = suppliers;
	}

	public String getTypeCed() {
		return typeCed;
	}

	public void setTypeCed(String typeCed) {
		this.typeCed = typeCed;
	}

	public String getTypeDp() {
		return typeDp;
	}

	public void setTypeDp(String typeDp) {
		this.typeDp = typeDp;
	}

	public String getVinculationType() {
		return vinculationType;
	}

	public void setVinculationType(String vinculationType) {
		this.vinculationType = vinculationType;
	}

	public String getVinculation() {
		return vinculation;
	}

	public void setVinculation(String vinculation) {
		this.vinculation = vinculation;
	}

	public String getPossessions() {
		return possessions;
	}

	public void setPossessions(String possessions) {
		this.possessions = possessions;
	}

	public String getcLastName() {
		return cLastName;
	}

	public void setcLastName(String cLastName) {
		this.cLastName = cLastName;
	}

	public String getClientRate() {
		return clientRate;
	}

	public void setClientRate(String clientRate) {
		this.clientRate = clientRate;
	}

	public String getCargPub() {
		return cargPub;
	}

	public void setCargPub(String cargPub) {
		this.cargPub = cargPub;
	}

	public Integer getCityBirth() {
		return cityBirth;
	}

	public void setCityBirth(Integer cityBirth) {
		this.cityBirth = cityBirth;
	}

	public Integer getDepDoc() {
		return depDoc;
	}

	public void setDepDoc(Integer depDoc) {
		this.depDoc = depDoc;
	}

	public String getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public Date getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}

	public Date getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}

	public Date getBirthDay() {
		return birthDay;
	}

	public void setBirthDay(Date birthDay) {
		this.birthDay = birthDay;
	}

	public Integer getInfAcc() {
		return infAcc;
	}

	public void setInfAcc(Integer infAcc) {
		this.infAcc = infAcc;
	}

	public Integer getPlaceDoc() {
		return placeDoc;
	}

	public void setPlaceDoc(Integer placeDoc) {
		this.placeDoc = placeDoc;
	}

	public BigDecimal getExpensesLevel() {
		return expensesLevel;
	}

	public void setExpensesLevel(BigDecimal expensesLevel) {
		this.expensesLevel = expensesLevel;
	}

	public String getEducationLevel() {
		return educationLevel;
	}

	public void setEducationLevel(String educationLevel) {
		this.educationLevel = educationLevel;
	}

	public BigDecimal getIncomeLevel() {
		return incomeLevel;
	}

	public void setIncomeLevel(BigDecimal incomeLevel) {
		this.incomeLevel = incomeLevel;
	}

	public short getpNumCargas() {
		return pNumCargas;
	}

	public void setpNumCargas(short pNumCargas) {
		this.pNumCargas = pNumCargas;
	}

	public short getChildrenNumber() {
		return childrenNumber;
	}

	public void setChildrenNumber(short childrenNumber) {
		this.childrenNumber = childrenNumber;
	}

	public String getNumOrd() {
		return numOrd;
	}

	public void setNumOrd(String numOrd) {
		this.numOrd = numOrd;
	}

	public String getpLastName() {
		return pLastName;
	}

	public void setpLastName(String pLastName) {
		this.pLastName = pLastName;
	}

	public String getPassport() {
		return passport;
	}

	public void setPassport(String passport) {
		this.passport = passport;
	}

	public short getPersonal() {
		return personal;
	}

	public void setPersonal(short personal) {
		this.personal = personal;
	}

	public String getProfession() {
		return profession;
	}

	public void setProfession(String profession) {
		this.profession = profession;
	}

	public short getPropiety() {
		return propiety;
	}

	public void setPropiety(short propiety) {
		this.propiety = propiety;
	}

	public String getRelPubPos() {
		return relPubPos;
	}

	public void setRelPubPos(String relPubPos) {
		this.relPubPos = relPubPos;
	}

	public String getsLastName() {
		return sLastName;
	}

	public void setsLastName(String sLastName) {
		this.sLastName = sLastName;
	}

	public String getsName() {
		return sName;
	}

	public void setsName(String sName) {
		this.sName = sName;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getWorkingStatus() {
		return workingStatus;
	}

	public void setWorkingStatus(String workingStatus) {
		this.workingStatus = workingStatus;
	}

	public short getSocAct() {
		return socAct;
	}

	public void setSocAct(short socAct) {
		this.socAct = socAct;
	}

	public String getTypePerson() {
		return typePerson;
	}

	public void setTypePerson(String typePerson) {
		this.typePerson = typePerson;
	}

	public String getPropertyType() {
		return propertyType;
	}

	public void setPropertyType(String propertyType) {
		this.propertyType = propertyType;
	}

	public short getJob() {
		return job;
	}

	public void setJob(short job) {
		this.job = job;
	}

	public String getTypeSocAct() {
		return typeSocAct;
	}

	public void setTypeSocAct(String typeSocAct) {
		this.typeSocAct = typeSocAct;
	}

}