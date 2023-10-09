package com.cobis.gestionasesores.data.source.local;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.persistence.EPersistenceConstraints;
import com.bayteq.libcore.persistence.EPersistenceFieldType;
import com.bayteq.libcore.persistence.PersistenceField;
import com.bayteq.libcore.persistence.PersistenceParameter;
import com.bayteq.libcore.persistence.internal.Cursor;
import com.bayteq.libcore.persistence.internal.PersistenceQueryListener;
import com.cobis.gestionasesores.data.models.Parameter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Persistence parameter table
 * Created by mnaunay on 26/06/2017.
 */

public class PersistenceParameters extends Database {
    private static final String TABLE_NAME = "parameters";
    private static final String FIELD_CODE = "code";
    private static final String FIELD_VALUE = "value";


    public PersistenceParameters() {
        super();
        if(!getPersistenceDAO().checkIfTableExists(TABLE_NAME)){
            List<PersistenceField> fields = new ArrayList<>();
            fields.add(new PersistenceField(FIELD_CODE, EPersistenceFieldType.PersistenceFieldTypeText, EPersistenceConstraints.PersistenceConstraintsPrimaryKey|EPersistenceConstraints.PersistenceConstraintsUnique));
            fields.add(new PersistenceField(FIELD_VALUE,EPersistenceFieldType.PersistenceFieldTypeText));
            getPersistenceDAO().createTable(TABLE_NAME,fields);
        }
    }

    /**
     * Gets all parameters
     * @return Map of parameters
     */
    public Map<String,String> getAll(){
        final Map<String,String> params = new HashMap<>();
        getPersistenceDAO().queryRecords(TABLE_NAME, null, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                params.put(cursor.getString(cursor.getColumnIndex(FIELD_CODE)),cursor.getString(cursor.getColumnIndex(FIELD_VALUE)));
            }
        });
        return params;
    }

    /**
     * Insert Remote Paramter
     * @return void
     */
    public void saveRemoteParameter(Parameter parameter){
        try {
            List<PersistenceParameter> parameters = new ArrayList<>();
            parameters.add(new PersistenceParameter(FIELD_CODE, parameter.getKey()));
            parameters.add(new PersistenceParameter(FIELD_VALUE, parameter.getValue()));
            this.getPersistenceDAO().insertRecord(TABLE_NAME, parameters);
        } catch (Exception ex) {
            Log.e("PersistencePerson::addRemoteParamter: ", ex);
            throw ex;
        }
    }

    /**
     * Clear values for remote paramters
     * @return void
     */
    public void clearValuesRemoteParameters(){
        try {
            this.getPersistenceDAO().deleteRecords(TABLE_NAME);
        } catch (Exception ex) {
            Log.e("PersistencePerson::addRemoteParamter: ", ex);
            throw ex;
        }
    }
}
