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
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.enums.TaskType;
import com.cobis.gestionasesores.data.models.GroupVerification;
import com.cobis.gestionasesores.data.models.IndividualVerification;
import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.data.models.Task;
import com.cobis.gestionasesores.utils.GsonHelper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.typeadapters.RuntimeTypeAdapterFactory;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by bqtdesa02 on 8/14/2017.
 */

public class PersistenceTask extends EncryptedDatabase {
    private static final String TABLE_NAME = "task";
    private static final String FIELD_NAME = "name";
    private static final String FIELD_TYPE = "type";

    public PersistenceTask() {
        super();
        if (!this.getPersistenceDAO().checkIfTableExists(TABLE_NAME)) {
            List<PersistenceField> fields = new ArrayList<>();
            fields.add(new PersistenceField(FIELD_ID, EPersistenceFieldType.PersistenceFieldTypeInteger, EPersistenceConstraints.PersistenceConstraintsPrimaryKey));
            fields.add(new PersistenceField(FIELD_SERVER_ID, EPersistenceFieldType.PersistenceFieldTypeInteger));
            fields.add(new PersistenceField(FIELD_DATA, EPersistenceFieldType.PersistenceFieldTypeText));
            fields.add(new PersistenceField(FIELD_NAME, EPersistenceFieldType.PersistenceFieldTypeText));
            fields.add(new PersistenceField(FIELD_TYPE, EPersistenceFieldType.PersistenceFieldTypeText));
            fields.add(new PersistenceField(FIELD_STATUS, EPersistenceFieldType.PersistenceFieldTypeInteger));
            fields.add(new PersistenceField(FIELD_TIMESTAMP, EPersistenceFieldType.PersistenceFieldTypeInteger));
            if(this.getPersistenceDAO().createTable(TABLE_NAME, fields)) {
                this.getPersistenceDAO().createIndex(TABLE_NAME, FIELD_NAME, EPersistenceOrderBy.PersistenceOrderByASC);
            }
        }
    }

    /**
     * Insert a new task row
     *
     * @param task Task entity
     * @return Row Identifier.
     */
    public int addTask(Task task) {
        try {
            List<PersistenceParameter> parameters = new ArrayList<>();
            parameters.add(new PersistenceParameter(FIELD_SERVER_ID, task.getServerId()));
            parameters.add(new PersistenceParameter(FIELD_DATA, GsonHelper.getGson().toJson(task)));
            parameters.add(new PersistenceParameter(FIELD_NAME, task.getName()));
            parameters.add(new PersistenceParameter(FIELD_TYPE, task.getType()));
            parameters.add(new PersistenceParameter(FIELD_STATUS, task.getStatus()));
            parameters.add(new PersistenceParameter(FIELD_TIMESTAMP, SystemClock.currentThreadTimeMillis()));
            return (int) getPersistenceDAO().insertRecord(TABLE_NAME, parameters);
        } catch (Exception ex) {
            Log.d("PersistenceTask::addTask: ", ex);
            throw ex;
        }
    }

    /**
     * Update task row
     *
     * @param id   Task identifier
     * @param task Task entity
     * @return true if task is updated, false otherwise.
     */
    public boolean updateTask(int id, Task task) {
        try {
            List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
            whereParameters.add(new PersistenceWhereParameter(FIELD_ID, id));

            List<PersistenceParameter> parameters = new ArrayList<>();
            parameters.add(new PersistenceParameter(FIELD_SERVER_ID, task.getServerId()));
            parameters.add(new PersistenceParameter(FIELD_DATA, GsonHelper.getGson().toJson(task)));
            parameters.add(new PersistenceParameter(FIELD_NAME, task.getName()));
            parameters.add(new PersistenceParameter(FIELD_TYPE, task.getType()));
            parameters.add(new PersistenceParameter(FIELD_STATUS, task.getStatus()));
            parameters.add(new PersistenceParameter(FIELD_TIMESTAMP, SystemClock.currentThreadTimeMillis()));
            getPersistenceDAO().updateRecord(TABLE_NAME, parameters, whereParameters);
            return true;
        } catch (Exception ex) {
            Log.d("PersistenceTask::updateTask: ", ex);
            throw ex;
        }
    }


    /**
     * Allow add or update a task row
     *
     * @param task Task
     * @return Row Id of the task added or updated
     */
    public int saveOrUpdate(Task task) {
        if(task.getId()>0){
            updateTask(task.getId(),task);
            return task.getId();
        }else{
            return addTask(task);
        }
    }

    /**
     * Delete a task row
     *
     * @param id Task identifier
     * @return true if the entity was deleted, false otherwise.
     */
    public boolean deleteTask(int id) {
        try {
            List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
            whereParameters.add(new PersistenceWhereParameter(FIELD_ID, id));
            this.getPersistenceDAO().deleteRecord(TABLE_NAME, whereParameters);
            return true;
        } catch (Exception ex) {
            Log.e("PersistenceTask::deleteTask: ", ex);
            throw ex;
        }
    }

    /**
     * Allows get all rows task
     *
     * @param type   Type of task
     * @param status Sync status
     * @return List of {@link Task}}
     */
    public List<Task> getAll(String keyword, @TaskType String type, @SyncStatus int status) {
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        if (status != SyncStatus.UNKNOWN) {
            whereParameters.add(new PersistenceWhereParameter(FIELD_STATUS, status));
        }
        if (!TaskType.UNKNOWN.equals(type)) {
            whereParameters.add(new PersistenceWhereParameter(FIELD_TYPE, type));
        }
        if (StringUtils.isNotEmpty(keyword)) {
            whereParameters.add(new PersistenceWhereParameter(FIELD_NAME, PersistenceWhereParameter.LIKE_OPERATOR, keyword, StringUtils.EMPTY));
        }
        final List<Task> result = new ArrayList<>();
        this.getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, FIELD_NAME, EPersistenceOrderBy.PersistenceOrderByASCNoCase, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                result.add(parse(cursor));
            }
        });
        return result;
    }

    public Task get(int id) {
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_ID, id));
        final List<Task> result = new ArrayList<>();
        this.getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                result.add(parse(cursor));
            }
        });
        return result.isEmpty() ? null : result.get(0);
    }

    public Task getByServerId(int serverId) {
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_SERVER_ID, serverId));
        final List<Task> result = new ArrayList<>();
        this.getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                result.add(parse(cursor));
            }
        });
        return result.isEmpty() ? null : result.get(0);
    }

    private Task parse(Cursor cursor) {
        String json = cursor.getString(cursor.getColumnIndex(FIELD_DATA));
        Task task = getGson().fromJson(json, Task.class);
        task.setId(cursor.getInt(cursor.getColumnIndex(FIELD_ID)));
        task.setStatus(cursor.getInt(cursor.getColumnIndex(FIELD_STATUS)));
        return task;
    }

    /**
     * Gson access
     *
     * @return Gson
     */
    private Gson getGson() {
        RuntimeTypeAdapterFactory<Task> adapter = RuntimeTypeAdapterFactory
                .of(Task.class, "type")
                .registerSubtype(GroupVerification.class, TaskType.GROUP_VERIFICATION)
                .registerSubtype(IndividualVerification.class, TaskType.INDIVIDUAL_VERIFICATION)
                .registerSubtype(SolidarityPayment.class, TaskType.SOLIDARITY_PAYMENT);
        return new GsonBuilder().registerTypeAdapterFactory(adapter).create();
    }


    public int countByStatus(@TaskType String type, @SyncStatus int status) {
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
