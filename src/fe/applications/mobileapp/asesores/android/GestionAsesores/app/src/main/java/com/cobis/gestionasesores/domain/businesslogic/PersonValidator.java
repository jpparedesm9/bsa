package com.cobis.gestionasesores.domain.businesslogic;

import android.support.annotation.NonNull;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.CivilStatus;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.CustomerData;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ProspectData;
import com.cobis.gestionasesores.data.models.Section;

import java.util.List;

public final class PersonValidator {
    @SyncStatus
    public static int checkPersonStatus(Person person) {
        List<Section> sections = person.getSections();
        int draft = 0, completed = 0, pending = 0, unknown = 0, error = 0;
        for (Section section : sections) {
            switch (section.getStatus()) {
                case SyncStatus.SYNCED:
                    completed++;
                    break;
                case SyncStatus.PENDING:
                    pending++;
                    break;
                case SyncStatus.ERROR:
                    error++;
                    break;
                case SyncStatus.DRAFT:
                    draft++;
                    break;
                case SyncStatus.UNKNOWN:
                    if (!section.isMandatory()) {
                        //if section is optional this added to sync!
                        completed++;
                    } else {
                        unknown++;
                    }
                    break;
            }
        }

        if (completed == sections.size()) {
            return SyncStatus.SYNCED;
        } else if ((pending + completed) == sections.size()) {
            return SyncStatus.PENDING;
        } else if (error > 0) {
            return SyncStatus.ERROR;
        } else {
            return SyncStatus.DRAFT;
        }
    }

    public static Person convertToToCustomer(Person prospect) {
        return new Person.Builder()
                .setId(prospect.getId())
                .setServerId(prospect.getServerId())
                .setName(prospect.getName())
                .setType(PersonType.CUSTOMER)
                .setStatus(SyncStatus.DRAFT)
                .setRiskLevel(prospect.getRiskLevel())
                .setValidated(prospect.isValidated())
                .setSpouseId(prospect.getSpouseId())
                .convert(prospect);
    }

    public static boolean isSingle(Person person) {
        Section section = null;
        if (person.getType() == PersonType.CUSTOMER) {
            section = Person.getSection(SectionCode.CUSTOMER_DATA, person.getSections());
        } else if (person.getType() == PersonType.PROSPECT) {
            section = Person.getSection(SectionCode.PROSPECT_DATA, person.getSections());
        }

        return section == null || isSingle(section);

    }

    public static boolean isSingle(@NonNull Section section) {
        String civilStatus = "";
        if (SectionCode.CUSTOMER_DATA.equals(section.getCode())) {
            CustomerData customerData = (CustomerData) section.getSectionData();
            civilStatus = StringUtils.nullToString(customerData.getCivilStatus());
        } else if (SectionCode.PROSPECT_DATA.equals(section.getCode())) {
            ProspectData prospectData = (ProspectData) section.getSectionData();
            civilStatus = StringUtils.nullToString(prospectData.getCivilStatus());
        }

        return !civilStatus.equals(CivilStatus.MARRIED) && !civilStatus.equals(CivilStatus.COMMON_LAW_MARRIAGE);
    }
}
