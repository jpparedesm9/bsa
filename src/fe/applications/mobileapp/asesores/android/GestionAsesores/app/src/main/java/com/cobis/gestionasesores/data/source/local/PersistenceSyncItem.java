package com.cobis.gestionasesores.data.source.local;

import android.os.SystemClock;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.persistence.EPersistenceConstraints;
import com.bayteq.libcore.persistence.EPersistenceFieldType;
import com.bayteq.libcore.persistence.PersistenceField;
import com.bayteq.libcore.persistence.PersistenceParameter;
import com.bayteq.libcore.persistence.PersistenceWhereParameter;
import com.bayteq.libcore.persistence.internal.Cursor;
import com.bayteq.libcore.persistence.internal.PersistenceQueryListener;
import com.cobis.gestionasesores.data.models.SyncItem;

import java.util.ArrayList;
import java.util.List;

/**
 * Persistence Synchronization Items
 * Created by mnaunay on 15/08/2017.
 */

public final class PersistenceSyncItem extends EncryptedDatabase {
    private static final String TABLE_NAME = "sync_item";
    private static final String FIELD_SERVER_ID = "server_id";
    private static final String FIELD_TYPE = "type";
    private static final String FIELD_ITEM_COUNT = "items_count";
    private static final String FIELD_CREATED = "created";

    public PersistenceSyncItem() {
        super();
        if (!getPersistenceDAO().checkIfTableExists(TABLE_NAME)) {
            List<PersistenceField> fields = new ArrayList<>();
            fields.add(new PersistenceField(FIELD_ID, EPersistenceFieldType.PersistenceFieldTypeInteger, EPersistenceConstraints.PersistenceConstraintsPrimaryKey));
            fields.add(new PersistenceField(FIELD_SERVER_ID, EPersistenceFieldType.PersistenceFieldTypeInteger, EPersistenceConstraints.PersistenceConstraintsUnique));
            fields.add(new PersistenceField(FIELD_TYPE, EPersistenceFieldType.PersistenceFieldTypeInteger));
            fields.add(new PersistenceField(FIELD_STATUS, EPersistenceFieldType.PersistenceFieldTypeText));
            fields.add(new PersistenceField(FIELD_ITEM_COUNT, EPersistenceFieldType.PersistenceFieldTypeInteger));
            fields.add(new PersistenceField(FIELD_CREATED, EPersistenceFieldType.PersistenceFieldTypeInteger));
            fields.add(new PersistenceField(FIELD_TIMESTAMP, EPersistenceFieldType.PersistenceFieldTypeNumeric));
            this.getPersistenceDAO().createTable(TABLE_NAME, fields);
        }
    }

    /**
     * Add a new item sync row
     *
     * @param item Synchronization Item
     * @return New row Identifier
     */
    public int addItem(SyncItem item) {
        try {
            List<PersistenceParameter> parameters = new ArrayList<>();
            parameters.add(new PersistenceParameter(FIELD_SERVER_ID, item.getServerId()));
            parameters.add(new PersistenceParameter(FIELD_TYPE, item.getType()));
            parameters.add(new PersistenceParameter(FIELD_STATUS, item.getStatus()));
            parameters.add(new PersistenceParameter(FIELD_ITEM_COUNT, item.getItemCount()));
            parameters.add(new PersistenceParameter(FIELD_CREATED, item.getCreated())); //created from server
            parameters.add(new PersistenceParameter(FIELD_TIMESTAMP, SystemClock.currentThreadTimeMillis()));
            return (int) getPersistenceDAO().insertRecord(TABLE_NAME, parameters);
        } catch (Exception ex) {
            Log.e("PersistenceSyncItem::addItem: ", ex);
            throw ex;
        }
    }

    /**
     * Update synchronization items
     *
     * @param serverId   Identifier
     * @param item Items
     * @return
     */
    public boolean updateItem(int serverId, SyncItem item) {
        try {
            List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
            whereParameters.add(new PersistenceWhereParameter(FIELD_SERVER_ID, serverId));

            List<PersistenceParameter> parameters = new ArrayList<>();
            parameters.add(new PersistenceParameter(FIELD_TYPE, item.getType()));
            parameters.add(new PersistenceParameter(FIELD_STATUS, item.getStatus()));
            parameters.add(new PersistenceParameter(FIELD_ITEM_COUNT, item.getItemCount()));
            parameters.add(new PersistenceParameter(FIELD_CREATED, item.getCreated())); //created from server
            parameters.add(new PersistenceParameter(FIELD_TIMESTAMP, SystemClock.currentThreadTimeMillis()));
            getPersistenceDAO().updateRecord(TABLE_NAME, parameters, whereParameters);
            return true;
        } catch (Exception ex) {
            Log.e("PersistenceSyncItem::updateItem: ", ex);
            throw ex;
        }
    }

    public boolean exists(int serverId) {
        try {
            List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
            whereParameters.add(new PersistenceWhereParameter(FIELD_SERVER_ID, serverId));

            return getPersistenceDAO().countRecords(TABLE_NAME, whereParameters) > 0;
        } catch (Exception ex) {
            Log.e("PersistenceSyncItem::exists: ", ex);
            throw ex;
        }
    }

    /**
     * Gets items by synchronization status
     *
     * @param status Synchronization item status
     * @return List if items
     */
    public List<SyncItem> getByStatus(String status) {
        final List<SyncItem> items = new ArrayList<>();

        StringBuilder sql = new StringBuilder()
                .append("SELECT * FROM ").append(TABLE_NAME)
                .append(" WHERE ").append(FIELD_STATUS).append(" = '").append(status).append("'")
                .append(" ORDER BY ").append(FIELD_TYPE).append(", ").append(FIELD_SERVER_ID).append(" ASC");

        this.getPersistenceDAO().queryNativeRecords(sql.toString(), null, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                try {
                    items.add(parseToEntity(cursor));
                } catch (Exception ex) {
                    Log.e("PersistenceSyncItem::getByStatus: ", ex);
                }
            }
        });
        return items;
    }

    private SyncItem parseToEntity(Cursor cursor) {
        SyncItem item = new SyncItem();
        item.setId(cursor.getInt(cursor.getColumnIndex(FIELD_ID)));
        item.setServerId(cursor.getInt(cursor.getColumnIndex(FIELD_SERVER_ID)));
        item.setType(cursor.getInt(cursor.getColumnIndex(FIELD_TYPE)));
        item.setStatus(cursor.getString(cursor.getColumnIndex(FIELD_STATUS)));
        item.setItemCount(cursor.getInt(cursor.getColumnIndex(FIELD_ITEM_COUNT)));
        item.setCreated(cursor.getLong(cursor.getColumnIndex(FIELD_CREATED)));
        item.setUpdated(cursor.getLong(cursor.getColumnIndex(FIELD_TIMESTAMP)));
        return item;
    }
}
