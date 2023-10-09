package com.cobis.gestionasesores.presentation.sections.prospectdata;

import com.bayteq.generators.mx.GenerateCurp;
import com.bayteq.generators.mx.GenerateRfc;
import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.CommonUtils;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.enums.Gender;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.data.models.ProspectData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.repositories.CatalogRepository;
import com.cobis.gestionasesores.data.repositories.PostalCodeRepository;
import com.cobis.gestionasesores.domain.usecases.GetAddressNameUseCase;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.presentation.sections.SectionPresenter;
import com.cobis.gestionasesores.utils.DateUtils;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class ProspectDataPresenter extends SectionPresenter implements ProspectDataContract.Presenter {
    private ProspectDataContract.View mView;
    private GetAddressNameUseCase mAddressUseCase;
    private Section mSection;
    private Person mProspect;
    private AddressData mAddressData;

    public ProspectDataPresenter(ProspectDataContract.View view, Person prospect,
                                 GetSectionDataUseCase getSectionDataUseCase,
                                 SaveSectionUseCase saveProspectUseCase,
                                 GetAddressNameUseCase addressUseCase) {
        super(view, saveProspectUseCase, getSectionDataUseCase);
        mView = view;
        mProspect = prospect;
        mAddressUseCase = addressUseCase;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        mSection = Person.getSection(SectionCode.PROSPECT_DATA, mProspect.getSections());
        loadSection(mProspect.getId(), mSection);
    }

    @Override
    public void onClickFinish(ProspectData prospectData) {
        if (mSection != null) {
            ProspectData oldData = (ProspectData) mSection.getSectionData();
            if (oldData != null && oldData.getEmailAddressId() > 0) {
                prospectData.setEmailAddressId(oldData.getEmailAddressId());
            }
        }

        prospectData.setAddressData(mAddressData);
        if (validateProspectData(prospectData)) {

            if (StringUtils.isEmpty(prospectData.getRfc())) {
                prospectData.setRfc(getRfc(prospectData));
            }

            if (StringUtils.isEmpty(prospectData.getCurp())) {
                prospectData.setCurp(getCurp(prospectData));
            }

            mSection.setSectionData(prospectData);
            saveSection(mProspect, mSection);
        }
    }

    @Override
    public void onBirthDateSet(int year, int month, int dayOfMonth) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month, dayOfMonth);
        mView.setBirthDate(calendar.getTimeInMillis());
    }

    @Override
    public void onAddressDataResult(AddressData addressData) {
        mAddressData = addressData;
        if (mAddressData != null) {
            mAddressUseCase.execute(mAddressData, new DisposableObserver<String>() {
                @Override
                public void onNext(@NonNull String result) {
                    mView.setAddressData(result);
                }

                @Override
                public void onError(@NonNull Throwable e) {

                }

                @Override
                public void onComplete() {

                }
            });
        }
    }

    @Override
    public void onClickBirthDate() {
        mView.showBirthDatePicker(Calendar.getInstance().getTimeInMillis());
    }

    @Override
    public void onClickAddressData() {
        mView.startAddressData(mAddressData);
    }

    private void loadStates() {
        PostalCodeRepository.getInstance().getStates()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<List<PostalCode>>() {
                    @Override
                    public void onNext(@NonNull List<PostalCode> postalCodes) {
                        ProspectData prospectData = (ProspectData) mSection.getSectionData();
                        mView.showBirthEntities(postalCodes, prospectData == null ? null : prospectData.getBirthEntityCode());
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
                Catalog.CAT_CIVIL_STATUS};
        CatalogRepository.getInstance().getCatalogItemsByCodes(catalogs)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<Map<Integer, List<CatalogItem>>>() {
                    @Override
                    public void onNext(@NonNull Map<Integer, List<CatalogItem>> integerListMap) {
                        for (Map.Entry<Integer, List<CatalogItem>> entry : integerListMap.entrySet()) {
                            handleCatalogItems(entry.getKey(), entry.getValue());
                        }
                        initProspectData((ProspectData) mSection.getSectionData());
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Log.e("ProspectDataPresenter: Error getCatalogItemsByCodes! ", e);
                    }

                    @Override
                    public void onComplete() {
                    }
                });
    }


    @Override
    public void onSectionLoaded(Section section) {
        mSection = section;
        loadStates();
        loadCatalogs();
    }

    private void handleCatalogItems(int code, List<CatalogItem> items) {
        switch (code) {
            case Catalog.CAT_SEX:
                mView.showSex(items);
                break;
            case Catalog.CAT_CIVIL_STATUS:
                mView.showCivilStatus(items);
                break;
        }
    }

    private void initProspectData(ProspectData prospectData) {
        if (prospectData != null) {
            mView.setProspectData(prospectData);
            onAddressDataResult(prospectData.getAddressData());

            String curp = prospectData.getCurp();
            String rfc = prospectData.getRfc();
            mView.toggleRfc(StringUtils.isNotEmpty(rfc));
            mView.toggleCurp(StringUtils.isNotEmpty(curp));

            if (mProspect.getServerId() > 0) {
                mView.disableIdentificationFields();
            }
        } else {
            mView.toggleCurp(false);
            mView.toggleRfc(false);
        }
    }

    private boolean validateProspectData(ProspectData prospectData) {
        boolean isValid = true;

        mView.clearErrors();

        String firstName = prospectData.getFirstName();
        if (StringUtils.isEmpty(firstName)) {
            isValid = false;
            mView.showFirstNameError();
        }

        String lastName = prospectData.getLastName();
        if (StringUtils.isEmpty(lastName)) {
            isValid = false;
            mView.showLastNameError();
        }

        String email = prospectData.getEmail();
        if (!CommonUtils.isValidEmail(email)) {
            isValid = false;
            mView.showEmailError();
        }

        String civilStatus = prospectData.getCivilStatus();
        if (StringUtils.isEmpty(civilStatus)) {
            isValid = false;
            mView.showCivilStatusError();
        }

        String birthEntity = prospectData.getBirthEntityAdditionalCode();
        if (StringUtils.isEmpty(birthEntity)) {
            isValid = false;
            mView.showBirthEntityError();
        }

        String sex = prospectData.getSex();
        if (StringUtils.isEmpty(sex)) {
            isValid = false;
            mView.showSexError();
        }

        if (prospectData.getAddressData() == null) {
            isValid = false;
            mView.showAddressError();
        }

        if (prospectData.getBirthDate() == null) {
            isValid = false;
            mView.showBirthDateError();
        } else {
            int maxAge = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MAX_AGE);
            int minAge = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MIN_AGE);
            int age = DateUtils.getAge(prospectData.getBirthDate());
            if (age < minAge || age > maxAge) {
                isValid = false;
                mView.showAdultAgeError(minAge, maxAge);
            }
        }
        return isValid;
    }

    private String getRfc(ProspectData prospectData) {
        try {
            String name = prospectData.getName();
            String lastName = prospectData.getLastName();
            String secondLastName = prospectData.getSecondLastName();

            long birthDate = prospectData.getBirthDate();
            Date date = new Date(birthDate);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);

            int year = calendar.get(Calendar.YEAR);
            int month = calendar.get(Calendar.MONTH) + 1;
            int dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);

            return GenerateRfc.buildRfc(name, lastName, secondLastName, dayOfMonth, month, year);
        } catch (Exception e) {
            Log.e("ProspectDataPresenter::getRFC: Error generation rfc! ", e);
            return null;
        }
    }

    private String getCurp(ProspectData prospectData) {
        try {
            String name = prospectData.getName();
            String lastName = prospectData.getLastName();
            String secondLastName = prospectData.getSecondLastName();
            String sex = Gender.parseFromCodeServer(prospectData.getSex()).getCodeCurp();
            String federalEntity = prospectData.getBirthEntityAdditionalCode();

            long birthDate = prospectData.getBirthDate();
            Date date = new Date(birthDate);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);

            int year = calendar.get(Calendar.YEAR);
            int month = calendar.get(Calendar.MONTH) + 1;
            int dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);

            return GenerateCurp.buildCurp(name, lastName, secondLastName, sex, federalEntity, dayOfMonth, month, year);
        } catch (Exception e) {
            Log.e("ProspectDataPresenter::getCurp: Error generation curp! ", e);
            return null;
        }
    }
}