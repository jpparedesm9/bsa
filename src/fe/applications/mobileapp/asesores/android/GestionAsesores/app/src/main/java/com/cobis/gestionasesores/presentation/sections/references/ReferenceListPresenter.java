package com.cobis.gestionasesores.presentation.sections.references;

import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.models.Reference;
import com.cobis.gestionasesores.data.models.ReferencesData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.presentation.sections.SectionPresenter;

import java.util.List;

/**
 * Created by mnaunay on 09/06/2017.
 */

public class ReferenceListPresenter extends SectionPresenter implements ReferenceListContract.Presenter {
    private ReferenceListContract.View mView;
    private Section mSection;
    private int mMaxReferences;
    private int mPersonId;

    public ReferenceListPresenter(ReferenceListContract.View view, int personId, Section section, GetSectionDataUseCase getSectionDataUseCase) {
        super(view, null, getSectionDataUseCase);
        mView = view;
        mPersonId = personId;
        mSection = section;
        mView.setPresenter(this);
        if (section.getSectionData() == null) {
            ReferencesData data = new ReferencesData();
            section.setSectionData(data);
        }
        mMaxReferences = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MAX_REFERENCES);
    }

    @Override
    public void start() {
        mView.showCaption(mMaxReferences);
        loadSection(mPersonId, mSection);
    }


    @Override
    public void onSectionLoaded(Section section) {
        mSection = section;
        loadReferences();
    }

    @Override
    public void loadReferences() {
        mView.showReferences(getReferences());
        mView.showButtonAdd(getReferences().size() < mMaxReferences);
    }

    @Override
    public void updateReferences() {
        loadSection(mPersonId, mSection,false);
    }


    @Override
    public void onAddNewReference() {
        mView.startReference(mPersonId,null,getReferences());
    }

    @Override
    public void onEditReference(Reference reference) {
        mView.startReference(mPersonId,reference,getReferences());
    }

    @Override
    public void onTryToExit() {
        mView.sendResult(true,mPersonId);
    }

    private List<Reference> getReferences() {
        return ((ReferencesData) mSection.getSectionData()).getReferences();
    }
}
