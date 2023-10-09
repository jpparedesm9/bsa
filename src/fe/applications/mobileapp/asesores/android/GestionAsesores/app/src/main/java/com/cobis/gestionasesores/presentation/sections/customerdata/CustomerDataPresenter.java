package com.cobis.gestionasesores.presentation.sections.customerdata;

import com.bayteq.generators.mx.GenerateCurp;
import com.bayteq.generators.mx.GenerateRfc;
import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.ConvertUtils;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.enums.Gender;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.CustomerData;
import com.cobis.gestionasesores.data.models.GeneralPersonData;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.repositories.CatalogRepository;
import com.cobis.gestionasesores.data.repositories.PostalCodeRepository;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.presentation.sections.SectionPresenter;
import com.cobis.gestionasesores.utils.DateUtils;
import com.cobis.gestionasesores.widgets.BooleanQuestionView;

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
 * Created by bqtdesa02 on 6/5/2017.
 */

public class CustomerDataPresenter extends SectionPresenter implements CustomerDataContract.CustomerDataPresenter {
    private CustomerDataContract.CustomerDataView mView;
    private final int mMinEconomicDependents;
    private final int mMaxEconomicDependents;

    private Section mSection;
    private Person mCustomer;

    public CustomerDataPresenter(CustomerDataContract.CustomerDataView view, Person customer,
                                 GetSectionDataUseCase getSectionDataUseCase,
                                 SaveSectionUseCase saveProspectUseCase) {
        super(view, saveProspectUseCase, getSectionDataUseCase);
        mView = view;
        mCustomer = customer;
        mMinEconomicDependents = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MIN_ECONOMIC_DEPENDENTS);
        mMaxEconomicDependents = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MAX_ECONOMIC_DEPENDENTS);
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        mSection = Person.getSection(SectionCode.CUSTOMER_DATA, mCustomer.getSections());
        loadSection(mCustomer.getId(), mSection);
    }

    @Override
    public void onClickFinish(CustomerData customerData) {
        if (validateCustomerData(customerData)) {
            //Only update when the values have not been calculated
            String rfc = customerData.getGeneralPersonData().getRfc();
            String curp = customerData.getCurp();
            if(StringUtils.isEmpty(rfc)) {
                customerData.getGeneralPersonData().setRfc(getRfc(customerData));
            }
            if(StringUtils.isEmpty(curp)) {
                customerData.setCurp(getCurp(customerData));
            }
            //END---
            mSection.setSectionData(customerData);
            saveSection(mCustomer, mSection);
        }
    }

    @Override
    public void onSectionLoaded(Section section) {
        mSection = section;
        loadStates();
        loadCatalogs();
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

    @Override
    public void onCheckHasOtherIncome(@BooleanQuestionView.CheckOption int option) {
        mView.toggleOtherIncomeFields(option == BooleanQuestionView.CheckOption.POSITIVE);
        if (option == BooleanQuestionView.CheckOption.NEGATIVE) {
            mView.clearOtherIncomeFields();
        }
    }

    @Override
    public void onCheckIsPoliticallyExposed(@BooleanQuestionView.CheckOption int option) {
        mView.togglePoliticallyExposedFields(option == BooleanQuestionView.CheckOption.POSITIVE);
        if (option == BooleanQuestionView.CheckOption.NEGATIVE) {
            mView.clearPoliticallyExposedFields();
        }
    }

    @Override
    public void onCheckHasPoliticallyExposedRelationship(@BooleanQuestionView.CheckOption int option) {
        mView.togglePoliticallyExposedRelationship(option == BooleanQuestionView.CheckOption.POSITIVE);
        if (option == BooleanQuestionView.CheckOption.NEGATIVE) {
            mView.clearPoliticallyExposedRelationship();
        }
    }

    private void handleCatalogItems(int code, List<CatalogItem> items) {
        switch (code) {
            case Catalog.CAT_SEX:
                mView.showSex(items);
                break;
            case Catalog.CAT_COUNTRY:
                // FIXME: 7/18/2017 This could be done in database query
                Collections.sort(items, new Comparator<CatalogItem>() {
                    @Override
                    public int compare(CatalogItem o1, CatalogItem o2) {
                        return o1.getValue().compareTo(o2.getValue());
                    }
                });
                mView.showBirthCountries(items, BankAdvisorApp.getInstance().getConfig().getString(Parameters.DEFAULT_COUNTRY));
                break;
            case Catalog.CAT_CIVIL_STATUS:
                mView.showCivilStatus(items);
                break;
            case Catalog.CAT_EDUCATION_LEVEL:
                mView.showEducationLevels(items);
                break;
            case Catalog.CAT_TECHNICAL_DEGREE:
                mView.showTechnicalLevels(items);
                break;
            case Catalog.CAT_INCOME_SOURCE:
                mView.showOtherIncomes(items);
                break;
            case Catalog.CAT_PEP_RELATIONSHIP:
                mView.showRelationships(items);
                break;
            case Catalog.CAT_NATIONALITY:
                mView.showNationalities(items);
                break;
            case Catalog.CAT_OCCUPATION:
                mView.showOccupations(items);
                break;
        }
    }

    private void loadCatalogs() {
        @Catalog int[] catalogs = new int[]{Catalog.CAT_SEX,
                Catalog.CAT_COUNTRY,
                Catalog.CAT_CIVIL_STATUS,
                Catalog.CAT_EDUCATION_LEVEL,
                Catalog.CAT_TECHNICAL_DEGREE,
                Catalog.CAT_INCOME_SOURCE,
                Catalog.CAT_PEP_RELATIONSHIP,
                Catalog.CAT_NATIONALITY,
                Catalog.CAT_OCCUPATION};
        CatalogRepository.getInstance().getCatalogItemsByCodes(catalogs)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<Map<Integer, List<CatalogItem>>>() {
                    @Override
                    public void onNext(@NonNull Map<Integer, List<CatalogItem>> integerListMap) {
                        for (Map.Entry<Integer, List<CatalogItem>> entry : integerListMap.entrySet()) {
                            handleCatalogItems(entry.getKey(), entry.getValue());
                        }
                        initCustomerData((CustomerData) mSection.getSectionData());
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Log.e("CustomerDataPresenter: Error getCatalogItemsByCodes! ", e);
                    }

                    @Override
                    public void onComplete() {
                    }
                });
    }

    private void loadStates() {
        PostalCodeRepository.getInstance().getStates()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<List<PostalCode>>() {
                    @Override
                    public void onNext(@NonNull List<PostalCode> postalCodes) {
                        CustomerData customerData = (CustomerData) mSection.getSectionData();
                        mView.showFederalEntities(postalCodes, customerData == null || customerData.getGeneralPersonData() == null ? null : customerData.getGeneralPersonData().getBirthEntityCode());
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

    private void initCustomerData(CustomerData customerData) {
        if (customerData != null && customerData.getGeneralPersonData() != null) {
            String countryCode = customerData.getGeneralPersonData().getBirthCountry();
            if (StringUtils.isEmpty(countryCode)) {
                customerData.getGeneralPersonData().setBirthCountry(BankAdvisorApp.getInstance().getConfig().getString(Parameters.DEFAULT_COUNTRY));
            }
            mView.togglePoliticallyExposedFields(customerData.isPoliticallyExposed() != null && customerData.isPoliticallyExposed());
            mView.toggleOtherIncomeFields(customerData.hasOtherIncomeSources() != null && customerData.hasOtherIncomeSources());
            mView.togglePoliticallyExposedRelationship(customerData.hasRelationshipPoliticallyExposed() != null && customerData.hasRelationshipPoliticallyExposed());
            mView.setCustomerData(customerData);

            if (mCustomer.getServerId() > 0) {
                mView.disableIdentificationFields();
            }

        } else {
            mView.toggleOtherIncomeFields(false);
            mView.togglePoliticallyExposedFields(false);
            mView.togglePoliticallyExposedRelationship(false);
            mView.toggleCurp(false);
            mView.toggleRfc(false);
            mView.togglePoliticallyExposed(false);
            mView.toggleTechnicalDegree(false);
        }
    }

    private boolean validateCustomerData(CustomerData customerData) {
        mView.clearErrors();

        boolean isValid = true;

        GeneralPersonData generalPersonData = customerData.getGeneralPersonData();

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

        if (generalPersonData.getBirthDate() == null) {
            mView.showBirthDateError();
            isValid = false;
        } else {
            int maxAge = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MAX_AGE);
            int minAge = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MIN_AGE);
            int age = DateUtils.getAge(generalPersonData.getBirthDate());
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

        String civilStatus = customerData.getCivilStatus();
        if (civilStatus == null || civilStatus.isEmpty()) {
            mView.showCivilStatusError();
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

        String economicDependents = customerData.getEconomicDependents();
        int numDependents = ConvertUtils.tryToInt(economicDependents, -1);
        if (numDependents < mMinEconomicDependents || numDependents > mMaxEconomicDependents) {
            mView.showEconomicDependentsError(mMinEconomicDependents, mMaxEconomicDependents);
            isValid = false;
        }

        Boolean hasOtherIncomes = customerData.hasOtherIncomeSources();
        if (hasOtherIncomes == null) {
            mView.showHasOtherIncomeSourcesError();
            isValid = false;
        } else if (hasOtherIncomes) {
            String otherIncomes = customerData.getOtherIncomeSources();
            if (otherIncomes == null || otherIncomes.isEmpty()) {
                mView.showOtherIncomeSourcesError();
                isValid = false;
            }
            if (customerData.getOtherIncomeSourcesAmount() == 0.0) {
                mView.showOtherIncomeSourcesAmountError();
                isValid = false;
            }
        }

        int cyclesOtherInstitutions = customerData.getNumCyclesOtherInstitutions();
        if (cyclesOtherInstitutions < 0) {
            mView.showNumCyclesOtherInstitutionsError();
            isValid = false;
        }

        Boolean hasPoliticallyExposedRelationship = customerData.hasRelationshipPoliticallyExposed();
        if (hasPoliticallyExposedRelationship == null) {
            mView.showHasRelationshipPoliticallyExposedError();
            isValid = false;
        } else if (hasPoliticallyExposedRelationship) {
            String relationship = customerData.getRelationship();
            if (relationship == null || relationship.isEmpty()) {
                mView.showRelationshipError();
                isValid = false;
            }
        }

        return isValid;
    }

    private String getRfc(CustomerData customerData) {
        try {
            String name = customerData.getGeneralPersonData().getName();
            String lastName = customerData.getGeneralPersonData().getLastName();
            String secondLastName = customerData.getGeneralPersonData().getSecondLastName();

            Date date = DateUtils.parseMillisecondsDate(customerData.getGeneralPersonData().getBirthDate());
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);

            int year = calendar.get(Calendar.YEAR);
            int month = calendar.get(Calendar.MONTH) + 1;
            int dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);

            return GenerateRfc.buildRfc(name, lastName, secondLastName, dayOfMonth, month, year);
        } catch (Exception e) {
            Log.e("CustomerDataPresenter::getRFC: Error generation rfc! ", e);
            return null;
        }
    }

    private String getCurp(CustomerData customerData) {
        try {
            String name = customerData.getGeneralPersonData().getName();
            String lastName = customerData.getGeneralPersonData().getLastName();
            String secondLastName = customerData.getGeneralPersonData().getSecondLastName();
            String sex = Gender.parseFromCodeServer(customerData.getGeneralPersonData().getSex()).getCodeCurp();
            String federalEntity = customerData.getGeneralPersonData().getBirthEntityAdditionalCode();

            Date date = DateUtils.parseMillisecondsDate(customerData.getGeneralPersonData().getBirthDate());
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);

            int year = calendar.get(Calendar.YEAR);
            int month = calendar.get(Calendar.MONTH) + 1;
            int dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);

            return GenerateCurp.buildCurp(name, lastName, secondLastName, sex, federalEntity, dayOfMonth, month, year);
        } catch (Exception e) {
            Log.e("CustomerDataPresenter::getCurp: Error generation curp! ", e);
            return null;
        }
    }
}