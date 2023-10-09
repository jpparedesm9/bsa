package com.cobis.gestionasesores.presentation.sections.partnerdata;

import com.bayteq.generators.mx.GenerateRfc;
import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.GeneralPersonData;
import com.cobis.gestionasesores.data.models.PartnerData;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.repositories.CatalogRepository;
import com.cobis.gestionasesores.data.repositories.PostalCodeRepository;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.presentation.sections.SectionPresenter;
import com.cobis.gestionasesores.utils.DateUtils;

import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 6/8/2017.
 */

public class PartnerDataPresenter extends SectionPresenter implements PartnerDataContract.PartnerDataPresenter {
    private PartnerDataContract.PartnerDataView mView;
    private Section mSection;
    private int mPersonId;

    public PartnerDataPresenter(PartnerDataContract.PartnerDataView view, int personId, Section section, GetSectionDataUseCase getSectionDataUseCase, SaveSectionUseCase saveSectionUseCase) {
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
        loadStates();
        loadCatalogs();
    }

    @Override
    public void onClickFinish(PartnerData partnerData) {
        if (validatePartnerData(partnerData)) {
            //Only update when the values have not been calculated
            String rfc = partnerData.getGeneralPersonData().getRfc();
            if(StringUtils.isEmpty(rfc)) {
                partnerData.getGeneralPersonData().setRfc(getRfc(partnerData));
            }
            PartnerData old = (PartnerData) mSection.getSectionData();
            if (old != null) {
                partnerData.setServerId(old.getServerId());
            }
            mSection.setSectionData(partnerData);
            saveSection(mPersonId, mSection);
        }
    }


    @Override
    public void onClickBirthDate() {
        mView.showDateDialog(Calendar.getInstance().getTimeInMillis());
    }

    @Override
    public void onBirthDateSet(int year, int month, int dayOfMonth) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month, dayOfMonth);
        mView.setBirthDate(calendar.getTimeInMillis());
    }

    private void loadStates() {
        PostalCodeRepository.getInstance().getStates()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<List<PostalCode>>() {
                    @Override
                    public void onNext(@NonNull List<PostalCode> postalCodes) {
                        PartnerData partnerData = (PartnerData) mSection.getSectionData();
                        mView.showFederalEntities(postalCodes, partnerData == null || partnerData.getGeneralPersonData() == null ? null : partnerData.getGeneralPersonData().getBirthEntityCode());
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Log.e("ProspectDataPresenter: Error getStates! ", e);
                    }

                    @Override
                    public void onComplete() {
                    }
                });
    }

    private void loadCatalogs() {
        @Catalog int[] catalogs = new int[]{Catalog.CAT_SEX,
                Catalog.CAT_COUNTRY,
                Catalog.CAT_EDUCATION_LEVEL,
                Catalog.CAT_NATIONALITY,
                Catalog.CAT_OCCUPATION,
                Catalog.CAT_ACTIVITY};
        CatalogRepository.getInstance().getCatalogItemsByCodes(catalogs)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<Map<Integer, List<CatalogItem>>>() {
                    @Override
                    public void onNext(@NonNull Map<Integer, List<CatalogItem>> integerListMap) {
                        for (Map.Entry<Integer, List<CatalogItem>> entry : integerListMap.entrySet()) {
                            handleCatalogItems(entry.getKey(), entry.getValue());
                        }
                        initPartnerData((PartnerData) mSection.getSectionData());
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Log.e("PartnerDataPresenter: Error getCatalogItemsByCodes! ", e);
                    }

                    @Override
                    public void onComplete() {
                    }
                });
    }

    private void handleCatalogItems(int code, List<CatalogItem> items) {
        switch (code) {
            case Catalog.CAT_SEX:
                mView.showSex(items);
                break;
            case Catalog.CAT_COUNTRY:
                // TODO: 7/18/2017 this could be done in database query
                Collections.sort(items, new Comparator<CatalogItem>() {
                    @Override
                    public int compare(CatalogItem o1, CatalogItem o2) {
                        return o1.getValue().compareTo(o2.getValue());
                    }
                });
                mView.showBirthCountries(items, BankAdvisorApp.getInstance().getConfig().getString(Parameters.DEFAULT_COUNTRY));
                break;
            case Catalog.CAT_EDUCATION_LEVEL:
                mView.showEducationLevels(items);
                break;
            case Catalog.CAT_NATIONALITY:
                mView.showNationalities(items);
                break;
            case Catalog.CAT_OCCUPATION:
                mView.showOccupations(items);
                break;
            case Catalog.CAT_ACTIVITY:
                mView.showActivities(items);
                break;
        }
    }

    private void initPartnerData(PartnerData partnerData) {
        if (partnerData != null && partnerData.getGeneralPersonData() != null) {
            mView.setPartnerData(partnerData);

            if(partnerData.getServerId() > 0){
                mView.disableIdentificationFields();
            }
        }
    }


    private boolean validatePartnerData(PartnerData partnerData) {
        boolean isValid = true;

        mView.clearErrors();

        GeneralPersonData generalPersonData = partnerData.getGeneralPersonData();

        String firstName = generalPersonData.getFirstName();
        if (firstName == null || firstName.isEmpty()) {
            mView.showFirstNameError();
            isValid = false;
        }

        String lastName = generalPersonData.getLastName();
        if (lastName == null || lastName.isEmpty()) {
            mView.showLastNameError();
            isValid = false;
        }

        String sex = generalPersonData.getSex();
        if (sex == null || sex.isEmpty()) {
            mView.showSexError();
            isValid = false;
        }

        Long birthDate = generalPersonData.getBirthDate();
        if (birthDate == null) {
            mView.showBirthDateError();
            isValid = false;
        } else {
            int maxAge = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MAX_AGE);
            int minAge = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MIN_AGE);
            int age = DateUtils.getAge(birthDate);
            if (age < minAge || age > maxAge) {
                isValid = false;
                mView.showAdultAgeError(minAge, maxAge);
            }
        }

        String birthEntity = generalPersonData.getBirthEntityCode();
        if (birthEntity == null || birthEntity.isEmpty()) {
            mView.showBirthEntityError();
            isValid = false;
        }

        String birthCountry = generalPersonData.getBirthCountry();
        if (birthCountry == null || birthCountry.isEmpty()) {
            mView.showBirthCountryError();
            isValid = false;
        }

        String nationality = generalPersonData.getNationality();
        if (nationality == null || nationality.isEmpty()) {
            mView.showNationalityError();
            isValid = false;
        }

        String educationLevel = generalPersonData.getEducationLevel();
        if (educationLevel == null || educationLevel.isEmpty()) {
            mView.showEducationLevelError();
            isValid = false;
        }

        String occupation = generalPersonData.getOccupation();
        if (occupation == null || occupation.isEmpty()) {
            mView.showOccupationError();
            isValid = false;
        }

        return isValid;
    }

    private String getRfc(PartnerData partnerData) {
        try {
            String name = partnerData.getGeneralPersonData().getName();
            String lastName = partnerData.getGeneralPersonData().getLastName();
            String secondLastName = partnerData.getGeneralPersonData().getSecondLastName();

            Long birthDate = partnerData.getGeneralPersonData().getBirthDate();
            Date date = DateUtils.parseMillisecondsDate(birthDate);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);

            int year = calendar.get(Calendar.YEAR);
            int month = calendar.get(Calendar.MONTH) + 1;
            int dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);

            return GenerateRfc.buildRfc(name, lastName, secondLastName, dayOfMonth, month, year);
        } catch (Exception e) {
            Log.e("PartnerDataPresenter::getRFC: Error generation rfc! ", e);
            return null;
        }
    }
}
