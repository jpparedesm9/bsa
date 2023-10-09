package com.cobis.gestionasesores.data.source.local;

import android.os.SystemClock;

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
import com.cobis.gestionasesores.data.enums.CreditAppType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.CreditApp;
import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.models.IndividualCreditApp;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.typeadapters.RuntimeTypeAdapterFactory;

import java.util.ArrayList;
import java.util.List;

/**
 * Persistence Credit Application
 * Created by mnaunay on 22/06/2017.
 */

public class PersistenceCreditApp extends EncryptedDatabase {
    public static final String TABLE_NAME = "credit_application";
    private static final String FIELD_APPLICANT_NAME = "applicant_name";
    private static final String FIELD_APPLICANT_ID = "applicant_id";
    private static final String FIELD_TYPE = "type";

    private static Gson sGson;

    public PersistenceCreditApp() {
        super();
        if(!this.getPersistenceDAO().checkIfTableExists(TABLE_NAME)) {
            List<PersistenceField> fields = new ArrayList<>();
            fields.add(new PersistenceField(FIELD_ID, EPersistenceFieldType.PersistenceFieldTypeInteger, EPersistenceConstraints.PersistenceConstraintsPrimaryKey));
            fields.add(new PersistenceField(FIELD_SERVER_ID, EPersistenceFieldType.PersistenceFieldTypeInteger));
            fields.add(new PersistenceField(FIELD_APPLICANT_NAME, EPersistenceFieldType.PersistenceFieldTypeText));
            fields.add(new PersistenceField(FIELD_APPLICANT_ID, EPersistenceFieldType.PersistenceFieldTypeInteger));
            fields.add(new PersistenceField(FIELD_DATA, EPersistenceFieldType.PersistenceFieldTypeText));
            fields.add(new PersistenceField(FIELD_TYPE, EPersistenceFieldType.PersistenceFieldTypeChar));
            fields.add(new PersistenceField(FIELD_STATUS, EPersistenceFieldType.PersistenceFieldTypeInteger));
            fields.add(new PersistenceField(FIELD_TIMESTAMP, EPersistenceFieldType.PersistenceFieldTypeInteger));
            if(this.getPersistenceDAO().createTable(TABLE_NAME,fields)){
                this.getPersistenceDAO().createIndex(TABLE_NAME,FIELD_APPLICANT_NAME,EPersistenceOrderBy.PersistenceOrderByASC);
            }
        }
    }


    /**
     * Insert credit application row
     * @param creditApp Credit application
     * @return Row Identifier
     */
    public int addCreditApp(CreditApp creditApp) {
        try {
            List<PersistenceParameter> parameters = new ArrayList<>();
            parameters.add(new PersistenceParameter(FIELD_SERVER_ID,creditApp.getServerId()));
            parameters.add(new PersistenceParameter(FIELD_APPLICANT_NAME, creditApp.getApplicantName()));
            parameters.add(new PersistenceParameter(FIELD_APPLICANT_ID, creditApp.getApplicantId()));
            parameters.add(new PersistenceParameter(FIELD_DATA, getGson().toJson(creditApp)));
            parameters.add(new PersistenceParameter(FIELD_TYPE, creditApp.getType()));
            parameters.add(new PersistenceParameter(FIELD_STATUS, creditApp.getStatus()));
            parameters.add(new PersistenceParameter(FIELD_TIMESTAMP, SystemClock.currentThreadTimeMillis()));
            return (int) getPersistenceDAO().insertRecord(TABLE_NAME, parameters);
        } catch (Exception ex) {
            Log.e("PersistenceCreditApp::addCreditApp: ", ex);
            throw ex;
        }
    }

    /**
     * Update credit application row
     *
     * @param id        Credit application identifier
     * @param creditApp Credit application to update
     * @return Row Identifier
     */
    public boolean updateCreditApp(int id, CreditApp creditApp) {
        try {

            List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
            whereParameters.add(new PersistenceWhereParameter(FIELD_ID, id));

            List<PersistenceParameter> parameters = new ArrayList<>();
            parameters.add(new PersistenceParameter(FIELD_SERVER_ID,creditApp.getServerId()));
            parameters.add(new PersistenceParameter(FIELD_APPLICANT_NAME, creditApp.getApplicantName()));
            parameters.add(new PersistenceParameter(FIELD_APPLICANT_ID, creditApp.getApplicantId()));
            parameters.add(new PersistenceParameter(FIELD_DATA, getGson().toJson(creditApp)));
            parameters.add(new PersistenceParameter(FIELD_TYPE, creditApp.getType()));
            parameters.add(new PersistenceParameter(FIELD_STATUS, creditApp.getStatus()));
            parameters.add(new PersistenceParameter(FIELD_TIMESTAMP, SystemClock.currentThreadTimeMillis()));
            getPersistenceDAO().updateRecord(TABLE_NAME, parameters, whereParameters);
            return true;
        } catch (Exception ex) {
            Log.e("PersistenceCreditApp::updateCreditApp: ", ex);
            throw ex;
        }
    }

    /**
     * Allow add or update a credit application row
     * @param app Credit APP
     * @return Row Id of the credit app added or updated
     */
    public int saveOrUpdate(CreditApp app){
        if(app.getId()>0){
            updateCreditApp(app.getId(),app);
            return app.getId();
        }else{
            return addCreditApp(app);
        }
    }

    /**
     * Delete a credit application row
     * @param id Credit application indentifier
     * @return true if the entity was deleted, false otherwise.
     */
    public boolean deleteCreditApp(int id) {
        try {
            List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
            whereParameters.add(new PersistenceWhereParameter(FIELD_ID, id));
            getPersistenceDAO().deleteRecord(TABLE_NAME, whereParameters);
            return true;
        } catch (Exception ex) {
            Log.e("PersistenceCreditApp::deleteCreditApp: ", ex);
            throw ex;
        }
    }

    /**
     * Get all credit applications
     * @param type Credit App Type
     * @param status Status
     * @return
     */
    public synchronized List<CreditApp> getAll(@CreditAppType String type, @SyncStatus int status) {
        final List<CreditApp> result = new ArrayList<>();
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        if(status != SyncStatus.UNKNOWN) {
            whereParameters.add(new PersistenceWhereParameter(FIELD_STATUS, status));
        }
        if(StringUtils.isNotEmpty(type)){
            whereParameters.add(new PersistenceWhereParameter(FIELD_TYPE,type));
        }
        getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, FIELD_APPLICANT_NAME, EPersistenceOrderBy.PersistenceOrderByASCNoCase, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                result.add(parseToEntity(cursor));
            }
        });
        return result;
    }

    /**
     * Search credit applications
     * @param keyword keyword
     * @param type  Type
     * @param status Status
     * @return List of @{{@link CreditApp}}
     */
    public synchronized List<CreditApp> search(String keyword, String type, @SyncStatus int status) {
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        if(status != SyncStatus.UNKNOWN) {
            whereParameters.add(new PersistenceWhereParameter(FIELD_STATUS, status));
        }
        if(StringUtils.isNotEmpty(type)){
            whereParameters.add(new PersistenceWhereParameter(FIELD_TYPE,type));
        }
        if(StringUtils.isNotEmpty(keyword)){
            whereParameters.add(new PersistenceWhereParameter(FIELD_APPLICANT_NAME, PersistenceWhereParameter.LIKE_OPERATOR, keyword, StringUtils.EMPTY));
        }
        final List<CreditApp> result = new ArrayList<>();
        getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, FIELD_APPLICANT_NAME, EPersistenceOrderBy.PersistenceOrderByASCNoCase, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                result.add(parseToEntity(cursor));
            }
        });
        return result;
    }

    /**
     * Get a application credit by the server identifier
     * @param serverId Server identifier
     * @return Credit application
     */
    public CreditApp getByServerId(int serverId) {
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_SERVER_ID, serverId));
        final List<CreditApp> result = new ArrayList<>();
        this.getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                result.add(parseToEntity(cursor));
            }
        });
        return result.isEmpty() ? null : result.get(0);
    }

    public List<CreditApp> findGroupCreditApp(int applicantId,@CreditAppType String type,@SyncStatus int status){
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_APPLICANT_ID,applicantId));
        whereParameters.add(new PersistenceWhereParameter(FIELD_TYPE,type));
        whereParameters.add(new PersistenceWhereParameter(FIELD_STATUS,"!=",status));

        final List<CreditApp> creditApps = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_APPLICANT_ID,applicantId,PersistenceWhereParameter.DEFAULT_OPERATOR));
        getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                creditApps.add(parseToEntity(cursor));
            }
        });
        return creditApps;
    }

    /**
     *  Delete all rows
     */
    public void deleteRows(){
        getPersistenceDAO().deleteRecords(TABLE_NAME);
    }

    /**
     * Allows parse row table to entity
     * @param cursor Row
     * @return @{{@link CreditApp}} Entity
     */
    private CreditApp parseToEntity(Cursor cursor) {
        String data = cursor.getString(cursor.getColumnIndex(FIELD_DATA));
        CreditApp creditApp = getGson().fromJson(data,CreditApp.class);
        creditApp.setId(cursor.getInt(cursor.getColumnIndex(FIELD_ID)));
        creditApp.setStatus(cursor.getInt(cursor.getColumnIndex(FIELD_STATUS)));
        return creditApp;
    }

    /**
     * Gson access
     * @return Gson
     */
    private Gson getGson(){
        if(sGson == null){
            RuntimeTypeAdapterFactory<CreditApp> adapter = RuntimeTypeAdapterFactory
                    .of(CreditApp.class,"type")
                    .registerSubtype(GroupCreditApp.class,CreditAppType.GROUP)
                    .registerSubtype(IndividualCreditApp.class,CreditAppType.INDIVIDUAL);
            sGson = new GsonBuilder().registerTypeAdapterFactory(adapter).create();
        }
        return sGson;
    }

    public int countByStatus(@CreditAppType String type, @SyncStatus int status) {
        final int[] count = {0};
        String sql = (new StringBuffer())
                .append("SELECT COUNT(*) FROM ").append(TABLE_NAME)
                .append(" WHERE ")
                .append(FIELD_TYPE).append("='").append(type)
                .append("' AND ").append(FIELD_STATUS).append("=").append(status).toString();
        this.getPersistenceDAO().queryNativeRecords(sql, null, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                count[0] =cursor.getInt(0);
            }
        });
        return count[0];
    }
}
