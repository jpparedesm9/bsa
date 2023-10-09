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
import com.cobis.gestionasesores.data.models.Group;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import org.json.JSONException;

import java.util.ArrayList;
import java.util.List;

/**
 * Persistence group table
 * Created by mnaunay on 16/06/2017.
 */

public class PersistenceGroup extends EncryptedDatabase {
    private static final String TABLE_NAME = "groups";
    private static final String FIELD_NAME = "name";

    public PersistenceGroup() {
        super();
        if (!this.getPersistenceDAO().checkIfTableExists(TABLE_NAME)) {
            List<PersistenceField> fields = new ArrayList<>();
            fields.add(new PersistenceField(FIELD_ID, EPersistenceFieldType.PersistenceFieldTypeInteger, EPersistenceConstraints.PersistenceConstraintsPrimaryKey));
            fields.add(new PersistenceField(FIELD_SERVER_ID, EPersistenceFieldType.PersistenceFieldTypeInteger));
            fields.add(new PersistenceField(FIELD_DATA, EPersistenceFieldType.PersistenceFieldTypeText));
            fields.add(new PersistenceField(FIELD_NAME, EPersistenceFieldType.PersistenceFieldTypeText));
            fields.add(new PersistenceField(FIELD_STATUS, EPersistenceFieldType.PersistenceFieldTypeInteger));
            fields.add(new PersistenceField(FIELD_TIMESTAMP, EPersistenceFieldType.PersistenceFieldTypeInteger));
            if (this.getPersistenceDAO().createTable(TABLE_NAME, fields)) {
                this.getPersistenceDAO().createIndex(TABLE_NAME, FIELD_NAME, EPersistenceOrderBy.PersistenceOrderByASC);
            }
        }
    }

    /**
     * Insert a new group row
     *
     * @param group Group entity
     * @return Row Identifier.
     */
    public int addGroup(Group group) {
        try {
            List<PersistenceParameter> parameters = new ArrayList<>();
            Gson gson = new Gson();
            parameters.add(new PersistenceParameter(FIELD_SERVER_ID, group.getServerId()));
            parameters.add(new PersistenceParameter(FIELD_DATA, gson.toJson(group)));
            parameters.add(new PersistenceParameter(FIELD_NAME, group.getName()));
            parameters.add(new PersistenceParameter(FIELD_STATUS, group.getStatus()));
            parameters.add(new PersistenceParameter(FIELD_TIMESTAMP, SystemClock.currentThreadTimeMillis()));
            return (int) getPersistenceDAO().insertRecord(TABLE_NAME, parameters);
        } catch (Exception ex) {
            Log.d("PersistenceGroup::addGroup: ", ex);
            throw ex;
        }
    }

    /**
     * Update a row group
     *
     * @param group Group entity
     * @return true if the entity was updated, false otherwise.
     */
    public boolean updateGroup(Group group) {
        try {
            List<PersistenceParameter> parameters = new ArrayList<>();
            Gson gson = new Gson();
            parameters.add(new PersistenceParameter(FIELD_SERVER_ID, group.getServerId()));
            parameters.add(new PersistenceParameter(FIELD_DATA, gson.toJson(group)));
            parameters.add(new PersistenceParameter(FIELD_NAME, group.getName()));
            parameters.add(new PersistenceParameter(FIELD_STATUS, group.getStatus()));
            parameters.add(new PersistenceParameter(FIELD_TIMESTAMP, SystemClock.currentThreadTimeMillis()));

            List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
            whereParameters.add(new PersistenceWhereParameter(FIELD_ID, group.getId()));

            getPersistenceDAO().updateRecord(TABLE_NAME, parameters, whereParameters);
        } catch (Exception ex) {
            Log.d("PersistenceGroup::updateGroup: ", ex);
            throw ex;
        }
        return true;
    }

    /**
     * Allow add or update a group row
     *
     * @param group Group
     * @return Row Id of the group to add or update
     */
    public int saveOrUpdate(Group group) {
        if (group.getId() > 0) {
            updateGroup(group);
            return group.getId();
        } else {
            return addGroup(group);
        }
    }

    /**
     * Delete a row group
     *
     * @param id Group identifier
     * @return true if the entity was deleted, false otherwise.
     */
    public boolean deleteGroup(int id) {
        try {
            List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
            whereParameters.add(new PersistenceWhereParameter(FIELD_ID, id));
            getPersistenceDAO().deleteRecord(TABLE_NAME, whereParameters);
            return true;
        } catch (Exception ex) {
            Log.d("PersistenceGroup::deleteGroup: ", ex);
            throw ex;
        }
    }


    /**
     * Allows to get groups
     *
     * @param keyword keyword
     * @param status  Status
     * @return List of {@link Group}
     */
    public List<Group> getGroups(String keyword, int status) {
        final Gson gson = new GsonBuilder().create();
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        if (status != SyncStatus.UNKNOWN) {
            whereParameters.add(new PersistenceWhereParameter(FIELD_STATUS, status));
        }
        if (StringUtils.isNotEmpty(keyword)) {
            whereParameters.add(new PersistenceWhereParameter(FIELD_NAME, PersistenceWhereParameter.LIKE_OPERATOR, keyword, StringUtils.EMPTY));
        }
        final List<Group> groups = new ArrayList<>();
        getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, FIELD_NAME, EPersistenceOrderBy.PersistenceOrderByASCNoCase, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                try {
                    groups.add(parseToEntity(gson, cursor));
                } catch (JSONException e) {
                    Log.e("Error parsing Group entity! ", e);
                }
            }
        });
        return groups;
    }


    public List<Group> getAllWithoutCredit() {
        final List<Group> result = new ArrayList<>();
        final Gson gson = new GsonBuilder().create();
        String sql = (new StringBuffer())
                .append("SELECT GP.* FROM ").append(TABLE_NAME).append(" GP")
                .append(" LEFT OUTER JOIN ").append(PersistenceCreditApp.TABLE_NAME).append(" CA ON CA.applicant_id = GP.").append(FIELD_ID)
                .append(" AND CA.type = '").append(CreditAppType.GROUP).append("'")
                .append(" WHERE")
                .append(" GP.").append(FIELD_STATUS).append(" = ").append(SyncStatus.SYNCED).append(" AND")
                .append(" GP.").append(FIELD_SERVER_ID).append(">").append("0 AND")
                .append(" (CA.").append(PersistenceCreditApp.FIELD_STATUS).append(" = ").append(SyncStatus.SYNCED).append(" OR")
                .append(" CA.").append(PersistenceCreditApp.FIELD_ID).append(" ISNULL)")
                .append(" ORDER BY GP.NAME ")
                .append(EPersistenceOrderBy.PersistenceOrderByASCNoCase).toString();
        this.getPersistenceDAO().queryNativeRecords(sql, null, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                try {
                    result.add(parseToEntity(gson, cursor));
                } catch (JSONException e) {
                    Log.e("Error parsing person entity: ", e);
                }
            }
        });
        return result;
    }

    /**
     * Allows get group by identifier
     *
     * @param id Identifier
     * @return
     */
    public Group getById(int id) {
        final Gson gson = new GsonBuilder().create();
        final List<Group> result = new ArrayList<>();
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_ID, id));
        getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                try {
                    result.add(parseToEntity(gson, cursor));
                } catch (JSONException e) {
                    Log.e("PersistenceGroup::getById:Error parsing Group entity! ", e);
                }
            }
        });
        return result.isEmpty() ? null : result.get(0);

    }

    /**
     * Allows get group by server identifier
     *
     * @param serverId Server Identifier
     * @return
     */
    public Group getByServerId(int serverId) {
        final Gson gson = new GsonBuilder().create();
        final List<Group> result = new ArrayList<>();
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_SERVER_ID, serverId));
        getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                try {
                    result.add(parseToEntity(gson, cursor));
                } catch (JSONException e) {
                    Log.e("PersistenceGroup::getById:Error parsing Group entity! ", e);
                }
            }
        });
        return result.isEmpty() ? null : result.get(0);
    }

    public int getIdByServerId(int serverId) throws Exception {
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_SERVER_ID, serverId));
        return getPersistenceDAO().queryScalar(TABLE_NAME, FIELD_ID, whereParameters);
    }

    private Group parseToEntity(Gson gson, Cursor cursor) throws JSONException {
        Group group = gson.fromJson(cursor.getString(cursor.getColumnIndex(FIELD_DATA)), Group.class);
        group.setId(cursor.getInt(cursor.getColumnIndex(FIELD_ID)));
        group.setStatus(cursor.getInt(cursor.getColumnIndex(FIELD_STATUS)));
        return group;
    }

    public int countByStatus(@SyncStatus int status) {
        final int[] count = {0};
        String sql = (new StringBuffer())
                .append("SELECT COUNT(*) FROM ").append(TABLE_NAME)
                .append(" WHERE ")
                .append(FIELD_STATUS).append("=").append(status).toString();
        this.getPersistenceDAO().queryNativeRecords(sql, null, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                count[0] = cursor.getInt(0);
            }
        });
        return count[0];
    }
}
