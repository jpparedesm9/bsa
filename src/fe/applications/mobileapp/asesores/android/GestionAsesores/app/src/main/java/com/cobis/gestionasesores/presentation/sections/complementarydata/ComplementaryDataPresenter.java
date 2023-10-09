package com.cobis.gestionasesores.presentation.sections.complementarydata;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.models.ComplementaryData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.presentation.sections.SectionPresenter;
import com.cobis.gestionasesores.utils.ValidationUtils;

/**
 * Created by bqtdesa02 on 6/8/2017.
 */

public class ComplementaryDataPresenter extends SectionPresenter implements ComplementaryDataContract.ComplementaryDataPresenter {
    private ComplementaryDataContract.ComplementaryDataView mView;
    private Section mSection;
    private int mPersonId;

    public ComplementaryDataPresenter(ComplementaryDataContract.ComplementaryDataView view, int personId, Section section, GetSectionDataUseCase getSectionDataUseCase, SaveSectionUseCase saveSectionUseCase) {
        super(view, saveSectionUseCase, getSectionDataUseCase);
        mView = view;
        mSection = section;
        mPersonId = personId;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        loadSection(mPersonId, mSection);
    }

    @Override
    public void onSectionLoaded(Section section) {
        mSection = section;
        if (mSection.getSectionData() != null) {
            mView.setComplementaryData((ComplementaryData) mSection.getSectionData());
        }
    }

    @Override
    public void onClickFinish(ComplementaryData complementaryData) {
        if (validateComplementaryData(complementaryData)) {
            mSection.setSectionData(complementaryData);
            saveSection(mPersonId, mSection);
        }
    }

    private boolean validateComplementaryData(ComplementaryData complementaryData) {
        boolean isValid = true;
        mView.clearErrors();
        if (complementaryData.hasAntecedentsBureau() == null) {
            mView.showHasBureauAntecedentsError();
            isValid = false;
        }

        String telephone = complementaryData.getMsgPhoneNumber();
        if (StringUtils.isNotEmpty(telephone) && !ValidationUtils.isValidTelephone(telephone)) {
            isValid = false;
            mView.showTelephoneError();
        }
        return isValid;
    }
}
