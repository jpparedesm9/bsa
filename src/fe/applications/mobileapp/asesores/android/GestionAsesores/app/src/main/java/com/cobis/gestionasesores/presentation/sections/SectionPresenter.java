package com.cobis.gestionasesores.presentation.sections;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.models.SectionData;
import com.cobis.gestionasesores.data.models.Synchronizable;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.presentation.error.ErrorPresenter;
import com.cobis.gestionasesores.utils.Util;

import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;

public abstract class SectionPresenter extends ErrorPresenter {
    private SectionViewBase mView;
    private SaveSectionUseCase mSaveSectionUseCase;
    private GetSectionDataUseCase mGetSectionDataUseCase;

    public SectionPresenter(SectionViewBase view, SaveSectionUseCase saveSectionUseCase, GetSectionDataUseCase getSectionDataUseCase) {
        super(view);
        mView = view;
        mSaveSectionUseCase = saveSectionUseCase;
        mGetSectionDataUseCase = getSectionDataUseCase;
    }

    public void saveSection(Person person, Section section) {
        saveSectionImpl(person, -1, section);
    }

    public void saveSection(int personId, Section section) {
        saveSectionImpl(null, personId, section);
    }

    /**
     * Allows load section information from local or remote sources
     *
     * @param personId Person identifier (Local iD)
     * @param section  Section
     */
    public void loadSection(int personId, final Section section) {
        loadSection(personId, section, true);
    }

    /**
     * Allows load section information
     *
     * @param personId  Person identifier (Local iD)
     * @param section   Section
     * @param tryOnline Flag to try to fetch section information from remoter
     */
    public void loadSection(int personId, final Section section, boolean tryOnline) {
        if (personId > 0) {
            //only try to get section data when exist in database or remote
            mView.showLoadSectionProgress();
            mGetSectionDataUseCase.execute(new GetSectionDataUseCase.GetSectionRequest(personId, section.getCode(), tryOnline), new DisposableObserver<SectionData>() {
                @Override
                public void onNext(@NonNull SectionData sectionData) {
                    section.setSectionData(sectionData);
                    checkError(section);
                }

                @Override
                public void onError(@NonNull Throwable e) {
                    mView.hideProgress();
                    Log.e("Section Datas is NULL: ", e);
                    checkError(section);
                }

                @Override
                public void onComplete() {
                    mView.hideProgress();
                }
            });
        } else {
            checkError(section);
        }
    }

    @Override
    public void checkError(Synchronizable section) {
        super.checkError(section);
        onSectionLoaded((Section) section);
    }

    public abstract void onSectionLoaded(Section section);

    private void saveSectionImpl(Person person, final int personId, final Section section) {
        mView.showSaveProgress();
        mSaveSectionUseCase.execute(new SaveSectionUseCase.SectionRequest(person, section, personId), new DisposableObserver<ResultData>() {
            @Override
            public void onNext(@NonNull ResultData resultData) {
                if (resultData.getType() == ResultType.SUCCESS) {
                    mView.showFinishedMessage(true, (int) resultData.getData(), resultData.getErrorMessage());

                    if (resultData.getErrorMessage() == null) {
                        mView.sendResult(true, (int) resultData.getData());
                    }
                } else {
                    mView.showSaveError(resultData.getErrorMessage());
                }
            }

            @Override
            public void onError(@NonNull Throwable e) {
                Log.e("SectionPresenter: saveSection: Error! ", e);
                mView.hideProgress();
                if (Util.isNetworkError(e)) {
                    mView.showNetworkError();
                } else {
                    mView.showSaveError(null);
                }
            }

            @Override
            public void onComplete() {
                mView.hideProgress();
            }
        });
    }
}
