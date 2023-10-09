package cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto;

public class RegulatoryComplianceResponseDTO {
    private int id;
    private String idList;
    private String name;
    private String lastName;
    private String motherLastName;
    private String curp;
    private String rfc;
    private String birthDate;
    private String listType;
    private String status;
    private String dependency;
    private String position;
    private String iddispo;
    private String curpOk;
    private String idRelation;
    private String relationship;
    private String businessName;
    private String moralRfc;
    private String socialSecurityNumber;
    private String imss;
    private String incomes;
    private String largeName;
    private String completeLastName;
    private String entity;
    private String sex;
    private String area;


    public RegulatoryComplianceResponseDTO() {
        super();
        // TODO Auto-generated constructor stub
    }


    public RegulatoryComplianceResponseDTO(int id, String idList, String name, String lastName, String motherLastName, String curp,
                                           String rfc, String birthDate, String listType, String status, String dependency, String position,
                                           String iddispo, String curp_ok, String id_relation, String relationship, String businessName,
                                           String moralRfc, String socialSecurityNumber, String imss, String incomes, String largeName,
                                           String completeLastName, String entity, String sex, String area) {
        super();
        this.id = id;
        this.idList = idList;
        this.name = name;
        this.lastName = lastName;
        this.motherLastName = motherLastName;
        this.curp = curp;
        this.rfc = rfc;
        this.birthDate = birthDate;
        this.listType = listType;
        this.status = status;
        this.dependency = dependency;
        this.position = position;
        this.iddispo = iddispo;
        this.curpOk = curp_ok;
        this.idRelation = id_relation;
        this.relationship = relationship;
        this.businessName = businessName;
        this.moralRfc = moralRfc;
        this.socialSecurityNumber = socialSecurityNumber;
        this.imss = imss;
        this.incomes = incomes;
        this.largeName = largeName;
        this.completeLastName = completeLastName;
        this.entity = entity;
        this.sex = sex;
        this.area = area;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIdList() {
        return idList;
    }

    public void setIdList(String idList) {
        this.idList = idList;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getMotherLastName() {
        return motherLastName;
    }

    public void setMotherLastName(String motherLastName) {
        this.motherLastName = motherLastName;
    }

    public String getCurp() {
        return curp;
    }

    public void setCurp(String curp) {
        this.curp = curp;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    public String getListType() {
        return listType;
    }

    public void setListType(String listType) {
        this.listType = listType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDependency() {
        return dependency;
    }

    public void setDependency(String dependency) {
        this.dependency = dependency;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getIddispo() {
        return iddispo;
    }

    public void setIddispo(String iddispo) {
        this.iddispo = iddispo;
    }

    public String getCurpOk() {
        return curpOk;
    }

    public void setCurpOk(String curp_ok) {
        this.curpOk = curp_ok;
    }

    public String getIdRelation() {
        return idRelation;
    }

    public void setIdRelation(String id_relation) {
        this.idRelation = id_relation;
    }

    public String getRelationship() {
        return relationship;
    }

    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }

    public String getBusinessName() {
        return businessName;
    }

    public void setBusinessName(String businessName) {
        this.businessName = businessName;
    }

    public String getMoralRfc() {
        return moralRfc;
    }

    public void setMoralRfc(String moralRfc) {
        this.moralRfc = moralRfc;
    }

    public String getSocialSecurityNumber() {
        return socialSecurityNumber;
    }

    public void setSocialSecurityNumber(String socialSecurityNumber) {
        this.socialSecurityNumber = socialSecurityNumber;
    }

    public String getImss() {
        return imss;
    }

    public void setImss(String imss) {
        this.imss = imss;
    }

    public String getIncomes() {
        return incomes;
    }

    public void setIncomes(String incomes) {
        this.incomes = incomes;
    }

    public String getLargeName() {
        return largeName;
    }

    public void setLargeName(String largeName) {
        this.largeName = largeName;
    }

    public String getCompleteLastName() {
        return completeLastName;
    }

    public void setCompleteLastName(String completeLastName) {
        this.completeLastName = completeLastName;
    }

    public String getEntity() {
        return entity;
    }

    public void setEntity(String entity) {
        this.entity = entity;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    @Override
    public String toString() {
        return "BlackListResponse [idList=" + idList + ", name=" + name + ", lastName=" + lastName + ", motherLastName="
                + motherLastName + ", curp=" + curp + ", rfc=" + rfc + ", birthDate=" + birthDate + ", listType="
                + listType + ", status=" + status + ", dependency=" + dependency + ", position=" + position
                + ", iddispo=" + iddispo + ", curp_ok=" + curpOk + ", id_relation=" + idRelation + ", relationship="
                + relationship + ", businessName=" + businessName + ", moralRfc=" + moralRfc + ", socialSecurityNumber="
                + socialSecurityNumber + ", imss=" + imss + ", incomes=" + incomes + ", largeName=" + largeName
                + ", completeLastName=" + completeLastName + ", entity=" + entity + ", sex=" + sex + ", area=" + area
                + "]";
    }

}