package com.cobis.gestionasesores.data.source.local;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.persistence.EPersistenceConstraints;
import com.bayteq.libcore.persistence.EPersistenceFieldType;
import com.bayteq.libcore.persistence.EPersistenceOrderBy;
import com.bayteq.libcore.persistence.PersistenceField;
import com.bayteq.libcore.persistence.PersistenceParameter;
import com.bayteq.libcore.persistence.PersistenceWhereParameter;
import com.bayteq.libcore.persistence.internal.Cursor;
import com.bayteq.libcore.persistence.internal.PersistenceQueryListener;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.ComplementaryData;
import com.cobis.gestionasesores.data.models.CustomerAddress;
import com.cobis.gestionasesores.data.models.CustomerBusiness;
import com.cobis.gestionasesores.data.models.CustomerData;
import com.cobis.gestionasesores.data.models.CustomerPayment;
import com.cobis.gestionasesores.data.models.DocumentsData;
import com.cobis.gestionasesores.data.models.PartnerData;
import com.cobis.gestionasesores.data.models.PartnerWork;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ProspectData;
import com.cobis.gestionasesores.data.models.ReferencesData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.utils.GsonHelper;
import com.google.gson.Gson;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Persistence for Person table
 * Created by mnaunay on 28/06/2017.
 */

public class PersistencePerson extends EncryptedDatabase {
    private static final String TABLE_NAME = "person";
    private static final String FIELD_NAME = "name";
    private static final String FIELD_DOCUMENT = "document";
    private static final String FIELD_TYPE = "type";
    private static final String FIELD_IS_VALIDATED = "is_validated";
    private static final String FIELD_SPOUSE = "spouse";
    private static final String FIELD_GROUP = "group_id";

    public PersistencePerson() {
        super();
        if (!this.getPersistenceDAO().checkIfTableExists(TABLE_NAME)) {
            if (this.getPersistenceDAO().createTable(TABLE_NAME, createFields())) {
                this.getPersistenceDAO().createIndex(TABLE_NAME, FIELD_NAME, EPersistenceOrderBy.PersistenceOrderByASC);
            }
        }
    }

    static List<PersistenceField> createFields() {
        List<PersistenceField> fields = new ArrayList<>();
        fields.add(new PersistenceField(FIELD_ID, EPersistenceFieldType.PersistenceFieldTypeInteger, EPersistenceConstraints.PersistenceConstraintsPrimaryKey));
        fields.add(new PersistenceField(FIELD_NAME, EPersistenceFieldType.PersistenceFieldTypeText));
        fields.add(new PersistenceField(FIELD_SERVER_ID, EPersistenceFieldType.PersistenceFieldTypeInteger));
        fields.add(new PersistenceField(FIELD_DOCUMENT, EPersistenceFieldType.PersistenceFieldTypeText));
        fields.add(new PersistenceField(FIELD_DATA, EPersistenceFieldType.PersistenceFieldTypeText));
        fields.add(new PersistenceField(FIELD_TYPE, EPersistenceFieldType.PersistenceFieldTypeInteger));
        fields.add(new PersistenceField(FIELD_IS_VALIDATED, EPersistenceFieldType.PersistenceFieldTypeInteger));
        fields.add(new PersistenceField(FIELD_STATUS, EPersistenceFieldType.PersistenceFieldTypeInteger));
        fields.add(new PersistenceField(FIELD_TIMESTAMP, EPersistenceFieldType.PersistenceFieldTypeInteger));
        fields.add(new PersistenceField(FIELD_SPOUSE, EPersistenceFieldType.PersistenceFieldTypeInteger));
        fields.add(new PersistenceField(FIELD_GROUP, EPersistenceFieldType.PersistenceFieldTypeInteger));
        return fields;
    }

    @Override
    protected void onUpgrade(int oldVersion, int newVersion) {
        Log.d("onUpgrade: oldVersion: " + oldVersion + " newVersion" + newVersion);
        switch (oldVersion) {
            case 0:
            case 1: {
                if (alterTableSchema(TABLE_NAME, createFields())) {
                    this.getPersistenceDAO().setVersion(newVersion);
                    Log.d("Database updated!");
                }
            }
        }
    }

    private static String formatStatus(int[] status) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("(");
        for (int i = 0; i < status.length; i++) {
            stringBuilder.append(status[i]);
            if (i + 1 < status.length) {
                stringBuilder.append(",");
            }
        }
        stringBuilder.append(")");
        return stringBuilder.toString();
    }

    /**
     * Insert a new person row
     *
     * @param person Person entity
     * @return true if the entity was inserted, false otherwise.
     */
    public int addPerson(Person person) {
        try {
            List<PersistenceParameter> parameters = new ArrayList<>();
            parameters.add(new PersistenceParameter(FIELD_NAME, person.getName()));
            parameters.add(new PersistenceParameter(FIELD_SERVER_ID, person.getServerId()));
            parameters.add(new PersistenceParameter(FIELD_DOCUMENT, person.getDocument()));
            parameters.add(new PersistenceParameter(FIELD_DATA, GsonHelper.getGson().toJson(person)));
            parameters.add(new PersistenceParameter(FIELD_TYPE, person.getType()));
            parameters.add(new PersistenceParameter(FIELD_IS_VALIDATED, person.isValidated() ? 1 : 0));
            parameters.add(new PersistenceParameter(FIELD_STATUS, person.getStatus()));
            parameters.add(new PersistenceParameter(FIELD_TIMESTAMP, System.currentTimeMillis()));
            parameters.add(new PersistenceParameter(FIELD_SPOUSE, person.getSpouseId()));
            parameters.add(new PersistenceParameter(FIELD_GROUP, person.getGroupId()));
            return (int) this.getPersistenceDAO().insertRecord(TABLE_NAME, parameters);
        } catch (Exception ex) {
            Log.e("PersistencePerson::addPerson: ", ex);
            throw ex;
        }
    }

    /**
     * Update a person row
     *
     * @param id     Person identifier
     * @param person Person entity
     * @return true if the entity was updated, false otherwise.
     */
    public boolean updatePerson(int id, Person person) {
        try {
            List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
            whereParameters.add(new PersistenceWhereParameter(FIELD_ID, id));
            List<PersistenceParameter> parameters = new ArrayList<>();
            parameters.add(new PersistenceParameter(FIELD_NAME, person.getName()));
            parameters.add(new PersistenceParameter(FIELD_SERVER_ID, person.getServerId()));
            parameters.add(new PersistenceParameter(FIELD_DOCUMENT, person.getDocument()));
            parameters.add(new PersistenceParameter(FIELD_DATA, GsonHelper.getGson().toJson(person)));
            parameters.add(new PersistenceParameter(FIELD_TYPE, person.getType()));
            parameters.add(new PersistenceParameter(FIELD_STATUS, person.getStatus()));
            parameters.add(new PersistenceParameter(FIELD_IS_VALIDATED, person.isValidated() ? 1 : 0));
            parameters.add(new PersistenceParameter(FIELD_TIMESTAMP, System.currentTimeMillis()));
            parameters.add(new PersistenceParameter(FIELD_SPOUSE, person.getSpouseId()));
            parameters.add(new PersistenceParameter(FIELD_GROUP, person.getGroupId()));
            this.getPersistenceDAO().updateRecord(TABLE_NAME, parameters, whereParameters);
            return true;
        } catch (Exception ex) {
            Log.e("PersistencePerson::updatePerson: ", ex);
            throw ex;
        }
    }

    /**
     * Allow add or update a person row
     *
     * @param person Person
     * @return Row Id of the person added or updated
     */
    public int saveOrUpdate(Person person) {
        if (person.getId() > 0) {
            updatePerson(person.getId(), person);
            return person.getId();
        } else {
            return addPerson(person);
        }
    }

    /**
     * Get a person by the server identifier
     *
     * @param serverId Server identifier
     * @return If exits return the person found, otherwise return NULL
     */
    public Person getByServerId(int serverId) {
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_SERVER_ID, serverId));
        final List<Person> result = new ArrayList<>();
        this.getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                try {
                    result.add(parseToEntity(cursor));
                } catch (JSONException e) {
                    Log.e("Error parsing person entity: ", e);
                }
            }
        });
        return result.isEmpty() ? null : result.get(0);
    }

    public List<Person> getByGroupId(int groupId) {
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_GROUP, groupId));
        final List<Person> result = new ArrayList<>();
        this.getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                try {
                    result.add(parseToEntity(cursor));
                } catch (JSONException e) {
                    Log.e("Error parsing person entity: ", e);
                }
            }
        });
        return result;
    }

    public int getStatus(int serverId) {
        final int[] status = {SyncStatus.UNKNOWN};
        String sql = (new StringBuffer())
                .append("SELECT ").append(FIELD_STATUS).append(" FROM ").append(TABLE_NAME)
                .append(" WHERE ")
                .append(FIELD_SERVER_ID).append("= ?").toString();
        this.getPersistenceDAO().queryNativeRecords(sql, new String[]{String.valueOf(serverId)}, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                status[0] = cursor.getInt(cursor.getColumnIndex(FIELD_STATUS));
            }
        });
        return status[0];
    }

    /**
     * Delete a person row
     *
     * @param id Person identifier
     * @return true if the entity was deleted, false otherwise.
     */
    public boolean deletePerson(int id) {
        try {
            List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
            whereParameters.add(new PersistenceWhereParameter(FIELD_ID, id));
            this.getPersistenceDAO().deleteRecord(TABLE_NAME, whereParameters);
            return true;
        } catch (Exception ex) {
            Log.e("PersistencePerson::deletePerson: ", ex);
            throw ex;
        }
    }

    /**
     * Allow search person by personal document (RFC,CUrp, Passport, etc)
     *
     * @param document Personal document
     * @return {{@link Person}}
     */
    public Person searchByDocument(String document) {
        final List<Person> result = new ArrayList<>();
        try {
            List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
            whereParameters.add(new PersistenceWhereParameter(FIELD_DOCUMENT, document));
            this.getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, new PersistenceQueryListener() {
                @Override
                public void didReadRow(Cursor cursor, int i) {
                    try {
                        result.add(parseToEntity(cursor));
                    } catch (JSONException e) {
                        Log.e("Error parsing person entity: ", e);
                    }
                }
            });
        } catch (Exception ex) {
            Log.e("PersistencePerson::searchByDocument: ", ex);
            throw ex;
        }
        return result.size() > 0 ? result.get(0) : null;
    }

    /**
     * Allows get all rows person
     * The arguments for this method are added to the WHERE clause as needed.
     * If the argument is empty or unknown, this method returns all records in the table
     *
     * @param type   Type of person
     * @param status Sync status
     * @return List of {@link Person}}
     */
    public List<Person> getAll(String keyword, int type, int[] status, String creditType, Boolean isValidated, Boolean inGroup, Boolean hasPartner) {
        StringBuilder stringBuilder = new StringBuilder()
                .append("SELECT PE.* FROM ").append(TABLE_NAME).append(" PE");

        if (StringUtils.isNotEmpty(keyword) || type != PersonType.UNKNOWN || (status != null && status.length > 0) || StringUtils.isNotEmpty(creditType) || isValidated != null) {
            stringBuilder.append(" WHERE ");
            boolean addJoin = false;
            if (status != null && status.length > 0) {
                stringBuilder.append("PE.").append(FIELD_STATUS).append(" IN ").append(formatStatus(status));
                addJoin = true;
            }
            if (type != PersonType.UNKNOWN) {
                stringBuilder.append(addJoin ? " AND " : "");
                stringBuilder.append("PE.").append(FIELD_TYPE).append(" = ").append(type);
                addJoin = true;
            }
            if (StringUtils.isNotEmpty(keyword)) {
                stringBuilder.append(addJoin ? " AND " : "");
                stringBuilder.append("PE.").append(FIELD_NAME).append(" like '%").append(keyword).append("%'");
                addJoin = true;
            }
            if (StringUtils.isNotEmpty(creditType)) {
                stringBuilder.append(addJoin ? " AND " : "");
                stringBuilder.append("PE.").append(FIELD_ID)
                        .append(" NOT IN (SELECT CA.APPLICANT_ID FROM ").append(PersistenceCreditApp.TABLE_NAME).append(" CA WHERE CA.type = '").append(creditType).append("')");
                addJoin = true;
            }
            if (isValidated != null) {
                stringBuilder.append(addJoin ? " AND " : "");
                stringBuilder.append("PE.").append(FIELD_IS_VALIDATED).append(" = ").append((isValidated ? 1 : 0));
                addJoin = true;
            }
            if (inGroup != null) {
                stringBuilder.append(addJoin ? " AND " : "");
                stringBuilder.append("PE.").append(FIELD_GROUP).append(inGroup ? ">" : "<=").append("0");
                addJoin = true;
            }

            if(hasPartner != null){
                stringBuilder.append(addJoin ? " AND " : "");
                stringBuilder.append("PE.").append(FIELD_SPOUSE).append(hasPartner ? ">" : "<=").append("0");
            }
        }
        stringBuilder.append(" ORDER BY NAME ")
                .append(EPersistenceOrderBy.PersistenceOrderByASCNoCase);

        final List<Person> result = new ArrayList<>();
        this.getPersistenceDAO().queryNativeRecords(stringBuilder.toString(), null, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                try {
                    result.add(parseToEntity(cursor));
                } catch (JSONException e) {
                    Log.e("Error parsing person entity: ", e);
                }
            }
        });
        return result;
    }

    public Person get(int id) {
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_ID, id));
        final List<Person> result = new ArrayList<>();
        this.getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                try {
                    result.add(parseToEntity(cursor));
                } catch (JSONException e) {
                    Log.e("Error parsing person entity: ", e);
                }
            }
        });
        return result.isEmpty() ? null : result.get(0);
    }

    public int countByStatus(@PersonType int type, @SyncStatus int[] status) {
        final int[] count = {0};
        String sql = (new StringBuffer())
                .append("SELECT COUNT(*) FROM ").append(TABLE_NAME)
                .append(" WHERE ")
                .append(FIELD_TYPE).append("=").append(type)
                .append(" AND ").append(FIELD_STATUS).append(" IN ").append(formatStatus(status)).toString();
        this.getPersistenceDAO().queryNativeRecords(sql, null, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                count[0] = cursor.getInt(0);
            }
        });
        return count[0];
    }

    /**
     * Allows delete all group references
     *
     * @param groupId Group Identifier
     */
    public void deleteRelationGroup(int groupId) {
        try {
            List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
            whereParameters.add(new PersistenceWhereParameter(FIELD_GROUP, groupId));

            List<PersistenceParameter> parameters = new ArrayList<>();
            parameters.add(new PersistenceParameter(FIELD_GROUP, -1));
            this.getPersistenceDAO().updateRecord(TABLE_NAME, parameters, whereParameters);
        } catch (Exception ex) {
            Log.e("PersistencePerson::deleteRelationGroup: ", ex);
            throw ex;
        }
    }

    public void updateRelationGroup(int[] serverId, int groupId) throws SQLException {
        try {
            StringBuilder sql = new StringBuilder();
            sql.append("UPDATE ").append(TABLE_NAME).append(" SET ").append(FIELD_GROUP).append(" = ").append(groupId)
                    .append(" WHERE ").append(FIELD_SERVER_ID).append(" IN (");

            for (int i= 0; i < serverId.length; i++){
                sql.append(serverId[i]);
                if(i + 1 != serverId.length) {
                    sql.append(",");
                }
            }
            sql.append(")");

            this.getPersistenceDAO().execSQL(sql.toString());
        } catch (Exception ex) {
            Log.e("PersistencePerson::updateRelationGroup: ", ex);
            throw ex;
        }
    }

    /**
     * Allows parse a row to entity person
     *
     * @param cursor Row
     * @return Person object
     * @throws JSONException
     */
    private Person parseToEntity(Cursor cursor) throws JSONException {
        String data = cursor.getString(cursor.getColumnIndex(FIELD_DATA));
        Gson gson = GsonHelper.getGson();
        JSONObject content = new JSONObject(data);
        JSONArray list = content.getJSONArray("sections");
        List<Section> sections = new ArrayList<>();
        for (int i = 0; i < list.length(); i++) {
            JSONObject item = list.getJSONObject(i);
            Section section = gson.fromJson(item.toString(), Section.class);
            String sectionData = item.optString("sectionData");
            if (sectionData != null && sectionData.length() > 0) {
                if (section.getCode().equals(SectionCode.CUSTOMER_DATA)) {
                    section.setSectionData(gson.fromJson(sectionData, CustomerData.class));
                } else if (section.getCode().equals(SectionCode.CUSTOMER_BUSINESS)) {
                    section.setSectionData(gson.fromJson(sectionData, CustomerBusiness.class));
                } else if (section.getCode().equals(SectionCode.PARTNER_DATA)) {
                    section.setSectionData(gson.fromJson(sectionData, PartnerData.class));
                } else if (section.getCode().equals(SectionCode.CUSTOMER_REFERENCES)) {
                    section.setSectionData(gson.fromJson(sectionData, ReferencesData.class));
                } else if (section.getCode().equals(SectionCode.CUSTOMER_DOCUMENTS)) {
                    section.setSectionData(gson.fromJson(sectionData, DocumentsData.class));
                } else if (section.getCode().equals(SectionCode.CUSTOMER_ADDRESS)) {
                    section.setSectionData(gson.fromJson(sectionData, CustomerAddress.class));
                } else if (section.getCode().equals(SectionCode.PARTNER_WORK)) {
                    section.setSectionData(gson.fromJson(sectionData, PartnerWork.class));
                } else if (section.getCode().equals(SectionCode.CUSTOMER_PAYMENTS)) {
                    section.setSectionData(gson.fromJson(sectionData, CustomerPayment.class));
                } else if (section.getCode().equals(SectionCode.PROSPECT_DATA)) {
                    section.setSectionData(gson.fromJson(sectionData, ProspectData.class));
                } else if (section.getCode().equals(SectionCode.COMPLEMENTARY_DATA)) {
                    section.setSectionData(gson.fromJson(sectionData, ComplementaryData.class));
                }
            }
            sections.add(section);
        }
        Person person = new Person.Builder()
                .setId(cursor.getInt(cursor.getColumnIndex(FIELD_ID)))
                .setServerId(cursor.getInt(cursor.getColumnIndex(FIELD_SERVER_ID)))
                .setName(cursor.getString(cursor.getColumnIndex(FIELD_NAME)))
                .setDocument(cursor.getString(cursor.getColumnIndex(FIELD_DOCUMENT)))
                .setType(cursor.getInt(cursor.getColumnIndex(FIELD_TYPE)))
                .setSections(sections).setStatus(cursor.getInt(cursor.getColumnIndex(FIELD_STATUS)))
                .setValidated(cursor.getInt(cursor.getColumnIndex(FIELD_IS_VALIDATED)) == 1)
                .setSpouseId(cursor.getInt(cursor.getColumnIndex(FIELD_SPOUSE)))
                .setGroupId(cursor.getInt(cursor.getColumnIndex(FIELD_GROUP)))
                .setRiskLevel(content.optString("riskLevel"))
                .build();
        return person;
    }
}
