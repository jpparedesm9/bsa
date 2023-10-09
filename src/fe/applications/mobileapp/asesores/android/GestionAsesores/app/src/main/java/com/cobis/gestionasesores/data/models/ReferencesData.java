package com.cobis.gestionasesores.data.models;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Parameters;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class ReferencesData extends SectionData<ReferencesData> {
    private List<Reference> references;

    public ReferencesData() {
        references = new ArrayList<>();
    }

    @Override
    public ReferencesData merge(ReferencesData data) {
        if (data != null) {
            //local
            List<Reference> part1 = data.getReferences();
            //remote, override
            List<Reference> part2 = references;

            final Map<String, Reference> referenceMap = new LinkedHashMap<>();
            for (final Reference defReference : part1) {
                referenceMap.put(defReference.toString().toLowerCase().trim(), defReference);
            }

            for (final Reference ovrdReference : part2) {
                int indexLocal = existReferenceIn(ovrdReference, part1);
                if (indexLocal >= 0) {
                    ovrdReference.setId(part1.get(indexLocal).getId());
                }
                referenceMap.put(ovrdReference.toString().trim(), ovrdReference);
            }

            //unique by server identifier
            List<Reference> tmp = new ArrayList<>(referenceMap.values());
            List<Reference> result = new ArrayList<>();
            for (Reference ref : tmp) {
                if (existReferenceIn(ref, result) == -1) {
                    result.add(ref);
                }
            }

            //create ID for new reference from server
            for (Reference reference : result) {
                if (reference.getId() == null || reference.getId().length() == 0) {
                    reference.setId(UUID.randomUUID().toString());
                }
            }
            references = result;
        }
        return this;
    }

    @Override
    public boolean isComplete() {
        boolean isComplete = true;

        if (references == null || references.isEmpty()) {
            isComplete = false;
        } else if (references.size() < BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MIN_REFERENCES)) {
            isComplete = false;
        } else {
            for (Reference reference : references) {
                if (!reference.isComplete()) {
                    isComplete = false;
                }
            }
        }
        
        return isComplete;
    }

    private int existReferenceIn(Reference reference, List<Reference> references) {
        for (int i = 0; i < references.size(); i++) {
            if (reference.getServerId() > 0 && reference.getServerId() == references.get(i).getServerId()) {
                return i;
            }
        }
        return -1;
    }

    public List<Reference> getReferences() {
        return references;
    }

    public void setReferences(List<Reference> references) {
        this.references = references;
    }

    public int indexOf(String id) {
        if (id == null) return -1;
        for (int i = 0; i < references.size(); i++) {
            if (references.get(i).getId().equals(id)) {
                return i;
            }
        }
        return -1;
    }
}
