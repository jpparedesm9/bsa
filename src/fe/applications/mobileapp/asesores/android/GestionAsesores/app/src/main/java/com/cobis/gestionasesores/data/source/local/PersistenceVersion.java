package com.cobis.gestionasesores.data.source.local;

import com.bayteq.libcore.persistence.EPersistenceConstraints;
import com.bayteq.libcore.persistence.EPersistenceFieldType;
import com.bayteq.libcore.persistence.PersistenceField;
import com.bayteq.libcore.persistence.PersistenceParameter;
import com.bayteq.libcore.persistence.PersistenceWhereParameter;
import com.cobis.gestionasesores.data.enums.VersionConcept;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Miguel on 18/06/2017.
 */

public class PersistenceVersion extends Database {
    private static final String TABLE_NAME = "version";
    private static final String FIELD_ID = "id";
    private static final String FIELD_CONCEPT = "concept";
    private static final String FIELD_VALUE = "value";

    public PersistenceVersion() {
        super();
        if(!getPersistenceDAO().checkIfTableExists(TABLE_NAME)){
            List<PersistenceField> fields = new ArrayList<>();
            fields.add(new PersistenceField(FIELD_ID, EPersistenceFieldType.PersistenceFieldTypeInteger, EPersistenceConstraints.PersistenceConstraintsPrimaryKey));
            fields.add(new PersistenceField(FIELD_CONCEPT, EPersistenceFieldType.PersistenceFieldTypeText,EPersistenceConstraints.PersistenceConstraintsUnique));
            fields.add(new PersistenceField(FIELD_VALUE, EPersistenceFieldType.PersistenceFieldTypeInteger));
            getPersistenceDAO().createTable(TABLE_NAME,fields);
        }
    }

    public void addVersion(@VersionConcept String concept, int value){
        List<PersistenceParameter> parameters = new ArrayList<>();
        parameters.add(new PersistenceParameter(FIELD_CONCEPT,concept));
        parameters.add(new PersistenceParameter(FIELD_VALUE,value));
        getPersistenceDAO().insertRecord(TABLE_NAME,parameters);
    }

    public void update(@VersionConcept String concept, int value){
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_CONCEPT,concept));

        List<PersistenceParameter> parameters = new ArrayList<>();
        parameters.add(new PersistenceParameter(FIELD_VALUE,value));
        getPersistenceDAO().updateRecord(TABLE_NAME,parameters,whereParameters);
    }

    public int getVersionValue(@VersionConcept String concept){
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_CONCEPT,concept));
        if(getPersistenceDAO().countRecords(TABLE_NAME)>0) {
            return getPersistenceDAO().queryScalar(TABLE_NAME, FIELD_VALUE, whereParameters);
        }
        else{
            return -1;
        }
    }

    public int count(@VersionConcept String concept){
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_CONCEPT,concept));
        return getPersistenceDAO().countRecords(TABLE_NAME,whereParameters);
    }
}
