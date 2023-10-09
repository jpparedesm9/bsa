package com.cobis.gestionasesores.data.models;

import android.annotation.SuppressLint;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.CivilStatus;
import com.cobis.gestionasesores.data.enums.MeetingLocation;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.enums.SyncStatus;

import java.util.ArrayList;
import java.util.List;

/**
 * Represent a person
 * Created by mnaunay on 28/06/2017.
 */
public class Person extends Synchronizable {
    private int id;
    private int spouseId;
    private int groupId;
    private String name;
    private String document;
    @PersonType
    private int type;
    private String riskLevel;
    private boolean isValidated;
    private List<Section> sections;

    private Person(Builder build) {
        this.id = build.id;
        this.spouseId = build.spouseId;
        this.groupId = build.groupId;
        this.name = build.name;
        this.document = build.document;
        this.type = build.type;
        this.sections = build.sections;
        this.status = build.status;
        this.serverId = build.serverId;
        this.riskLevel = build.riskLevel;
        this.isValidated = build.isValidated;
    }

    public static Section getSection(@SectionCode String code, List<Section> sections) {
        if (sections != null && sections.size() > 0) {
            for (Section section : sections) {
                if (section.getCode().equals(code)) {
                    return section;
                }
            }
        }
        return null;
    }

    public void setSpouseId(int spouseId) {
        this.spouseId = spouseId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    @PersonType
    public int getType() {
        return type;
    }

    public List<Section> getSections() {
        return sections;
    }

    public String getDocument() {
        String rfc = "";
        try {
            if (type == PersonType.CUSTOMER) {
                Section section = getSection(SectionCode.CUSTOMER_DATA, sections);
                CustomerData data = (CustomerData) section.getSectionData();
                rfc = data.getGeneralPersonData().getRfc();
            } else if (type == PersonType.PROSPECT) {
                Section section = getSection(SectionCode.PROSPECT_DATA, sections);
                ProspectData data = (ProspectData) section.getSectionData();
                rfc = data.getRfc();
            } else {
                throw new RuntimeException("PersonType not supported: " + type);
            }
        } catch (Exception ex) {
            Log.e("Person::getDocument: ", ex);
        }
        return rfc;
    }

    public AddressData getLocation(String meetingLocation) {
        AddressData location = null;
        try {
            if (meetingLocation.equals(MeetingLocation.HOME)) {
                CustomerAddress customerAddress = (CustomerAddress) getSection(SectionCode.CUSTOMER_ADDRESS, sections).getSectionData();
                location = customerAddress.getAddressData();
            } else if (meetingLocation.equals(MeetingLocation.WORK)) {
                CustomerBusiness customerBusiness = (CustomerBusiness) getSection(SectionCode.CUSTOMER_BUSINESS, sections).getSectionData();
                location = customerBusiness.getAddressData();
            }
        } catch (Exception ex) {
            Log.e("Customer::getLocation: ", ex);
        }
        return location;
    }

    public void replaceSection(Section section) {
        refresh(section);

        if (getSection(section.getCode(), sections) == null) {
            //detect if section is new
            sections.add(section);
        } else {
            //replace exists
            for (int i = 0; i < sections.size(); i++) {
                if (sections.get(i).getCode().equals(section.getCode())) {
                    sections.set(i, section);
                    return;
                }
            }
        }
    }

    /**
     * Allows refresh person data
     * <p>Name, CURP, RFC</p>
     *
     * @param section
     */
    private void refresh(Section section) {
        //person name
        if (SectionCode.CUSTOMER_DATA.equals(section.getCode()) || SectionCode.PROSPECT_DATA.equals(section.getCode())) {
            refreshPersonName(section.getSectionData());
        }

        //here other fields refresh
    }

    private void refreshPersonName(SectionData sectionData) {
        switch (type) {
            case PersonType.CUSTOMER:
                CustomerData customerData = (CustomerData) sectionData;
                name = customerData != null ? customerData.getGeneralPersonData().getFullName() : "";
                break;
            case PersonType.PROSPECT:
                ProspectData prospectData = (ProspectData) sectionData;
                name = prospectData != null ? prospectData.getFullName() : "";
                break;
            default:
                //Here implement name setter for other types of person
                break;
        }
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getSpouseId() {
        return spouseId;
    }

    public String getRiskLevel() {
        return riskLevel;
    }

    public void setRiskLevel(String riskLevel) {
        this.riskLevel = riskLevel;
    }

    public boolean isValidated() {
        return isValidated;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setValidated(boolean validated) {
        isValidated = validated;
    }

    public void setSections(List<Section> sections) {
        this.sections = sections;
    }

    public void setId(int id) {
        this.id = id;
    }

    public static class Builder {
        private int id = -1;
        private int spouseId = -1;
        private int groupId = -1;
        private String name;
        private String document;
        @PersonType
        private int type;
        @SyncStatus
        private int status = SyncStatus.DRAFT;
        private String riskLevel;
        private List<Section> sections;
        private boolean isValidated;
        private int serverId;

        public Builder() {
        }

        private static Person convertToCustomer(Person personFrom, Person personTo) {
            Section prospectDataSection = getSection(SectionCode.PROSPECT_DATA, personFrom.getSections());
            ProspectData prospectData = (ProspectData) prospectDataSection.getSectionData();

            for (Section section : personTo.getSections()) {
                switch (section.getCode()) {
                    case SectionCode.CUSTOMER_DATA:
                        section.setStatus(SyncStatus.DRAFT);
                        GeneralPersonData generalPersonData = new GeneralPersonData.Builder()
                                .setFirstName(prospectData.getFirstName())
                                .setSecondName(prospectData.getSecondName())
                                .setLastName(prospectData.getLastName())
                                .setSecondLastName(prospectData.getSecondLastName())
                                .setSex(prospectData.getSex())
                                .setRfc(prospectData.getRfc())
                                .setBirthDate(prospectData.getBirthDate())
                                .setBirthEntityCode(prospectData.getBirthEntityCode())
                                .setBirthEntityAdditionalCode(prospectData.getBirthEntityAdditionalCode())
                                .build();

                        CustomerData customerData = new CustomerData.Builder()
                                .addGeneralPersonData(generalPersonData)
                                .addCurp(prospectData.getCurp())
                                .addCivilStatus(prospectData.getCivilStatus())
                                .addCustomerNumber(prospectData.getNumber())
                                .addCustomerAccountNumber(prospectData.getAccountNumber())
                                .build();
                        section.setSectionData(customerData);
                        break;
                    case SectionCode.CUSTOMER_ADDRESS:
                        section.setStatus(SyncStatus.DRAFT);
                        section.setSectionData(new CustomerAddress.Builder()
                                .addAddressData(prospectData.getAddressData())
                                .addEmail(prospectData.getEmail())
                                .addEmailServerId(prospectData.getEmailAddressId())
                                .build());
                        break;
                    case SectionCode.CUSTOMER_DOCUMENTS:
                        Section documentSection = getSection(SectionCode.CUSTOMER_DOCUMENTS, personFrom.getSections());
                        section.setStatus(documentSection.getStatus());
                        section.setSectionData(documentSection.getSectionData());
                        break;
                }
            }
            return personTo;
        }

        public Builder setRiskLevel(String riskLevel) {
            this.riskLevel = riskLevel;
            return this;
        }

        public Builder setType(int type) {
            this.type = type;
            return this;
        }

        public Builder setId(int id) {
            this.id = id;
            return this;
        }

        public Builder setSections(List<Section> sections) {
            this.sections = sections;
            return this;
        }

        public Builder setStatus(int status) {
            this.status = status;
            return this;
        }

        public Builder setName(String name) {
            this.name = name;
            return this;
        }

        public Builder setDocument(String document) {
            this.document = document;
            return this;
        }

        public Builder setServerId(int serverId) {
            this.serverId = serverId;
            return this;
        }

        public Builder setValidated(boolean validated) {
            isValidated = validated;
            return this;
        }

        public Builder setSpouseId(int spouseId) {
            this.spouseId = spouseId;
            return this;
        }

        public Builder setGroupId(int groupId) {
            this.groupId = groupId;
            return this;
        }

        public Person build(Person originalPerson) {
            if (originalPerson != null) {
                id = originalPerson.id;
                spouseId = originalPerson.spouseId;
                groupId = originalPerson.groupId;
                name = originalPerson.name;
                document = originalPerson.document;
                type = originalPerson.type;
                status = originalPerson.status;
                sections = originalPerson.sections;
                serverId = originalPerson.serverId;
                riskLevel = originalPerson.riskLevel;
                isValidated = originalPerson.isValidated;

                //refresh sections by civil status
                Section section = Person.getSection(SectionCode.CUSTOMER_DATA, sections);
                if (section != null && section.getSectionData() != null) {
                    CustomerData customerData = (CustomerData) section.getSectionData();
                    String civilStatus = StringUtils.nullToString(customerData.getCivilStatus());
                    if (civilStatus.equals(CivilStatus.MARRIED) || civilStatus.equals(CivilStatus.COMMON_LAW_MARRIAGE)) {
                        //add partner sections
                        if (Person.getSection(SectionCode.PARTNER_DATA, sections) == null) {
                            sections.add(new Section(SectionCode.PARTNER_DATA, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                        }
                        if (Person.getSection(SectionCode.PARTNER_WORK, sections) == null) {
                            sections.add(new Section(SectionCode.PARTNER_WORK, SectionCode.PARTNER_DATA, SyncStatus.UNKNOWN, false));
                        }
                    } else {
                        spouseId = -1;
                        //remote partner sections
                        if (Person.getSection(SectionCode.PARTNER_DATA, sections) != null) {
                            sections.remove(Person.getSection(SectionCode.PARTNER_DATA, sections));
                        }
                        if (Person.getSection(SectionCode.PARTNER_WORK, sections) != null) {
                            sections.remove(Person.getSection(SectionCode.PARTNER_WORK, sections));
                        }
                    }
                }
            }

            if (sections == null) {
                sections = new ArrayList<>();
                if (type == PersonType.CUSTOMER) {
                    sections.add(new Section(SectionCode.CUSTOMER_DATA, null, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.CUSTOMER_ADDRESS, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.PARTNER_DATA, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.PARTNER_WORK, SectionCode.PARTNER_DATA, SyncStatus.UNKNOWN, false));
                    sections.add(new Section(SectionCode.CUSTOMER_BUSINESS, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.CUSTOMER_REFERENCES, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.CUSTOMER_PAYMENTS, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.CUSTOMER_DOCUMENTS, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.COMPLEMENTARY_DATA, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                } else if (type == PersonType.PROSPECT) {
                    sections.add(new Section(SectionCode.PROSPECT_DATA, null, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.CUSTOMER_DOCUMENTS, SectionCode.PROSPECT_DATA, SyncStatus.UNKNOWN, false));
                } else {
                    throw new RuntimeException("Person Types is not available!!");
                }
            }
            return new Person(this);
        }

        public Person build() {
            return build(null);
        }

        @SuppressLint("WrongConstant")
        public Person convert(Person person) {
            if (sections == null) {
                sections = new ArrayList<>();
                if (type == PersonType.CUSTOMER) {
                    sections.add(new Section(SectionCode.CUSTOMER_DATA, null, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.CUSTOMER_ADDRESS, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.PARTNER_DATA, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.PARTNER_WORK, SectionCode.PARTNER_DATA, SyncStatus.UNKNOWN, false));
                    sections.add(new Section(SectionCode.CUSTOMER_BUSINESS, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.CUSTOMER_REFERENCES, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.CUSTOMER_PAYMENTS, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.CUSTOMER_DOCUMENTS, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.COMPLEMENTARY_DATA, SectionCode.CUSTOMER_DATA, SyncStatus.UNKNOWN, true));
                } else if (type == PersonType.PROSPECT) {
                    sections.add(new Section(SectionCode.PROSPECT_DATA, null, SyncStatus.UNKNOWN, true));
                    sections.add(new Section(SectionCode.CUSTOMER_DOCUMENTS, SectionCode.PROSPECT_DATA, SyncStatus.UNKNOWN, false));
                } else {
                    throw new RuntimeException("Person Types is not available!!");
                }
            }

            if (person != null) {
                if (person.getType() == PersonType.PROSPECT) {
                    return convertToCustomer(person, new Person(this));
                } else {
                    throw new UnsupportedOperationException("Not possible to convert from " + person.getType());
                }
            } else {
                return new Person(this);
            }
        }
    }
}