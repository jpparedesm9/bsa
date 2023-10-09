package com.cobis.gestionasesores;

import android.support.test.runner.AndroidJUnit4;

import com.bayteq.generators.mx.GenerateCurp;
import com.bayteq.generators.mx.GenerateRfc;
import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.data.enums.Gender;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.models.AddressData;
import com.cobis.gestionasesores.data.models.CustomerData;
import com.cobis.gestionasesores.data.models.LocationData;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ProspectData;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.utils.DateUtils;

import org.junit.Test;
import org.junit.runner.RunWith;

import java.security.SecureRandom;
import java.util.Calendar;
import java.util.Date;

import io.reactivex.observers.DisposableObserver;

/**
 * Created by mnaunay on 30/08/2017.
 */

@RunWith(AndroidJUnit4.class)
public class PersonTestCase {

    @Test
    public void shouldProspectData() {
        ProspectData data = new ProspectData.Builder()
                .setFirstName("Usuario "+randomString(3))
                //.setSecondName(randomString())
                .setLastName(randomString(4))
                .setSecondLastName(randomString(4))
                .setEmail(randomString(10) + "@demo.com")
                .setSex("M")
                .setCivilStatus("SO")
                .setBirthEntityCode("7")
                .setBirthEntityAdditionalCode("DF")
                .setBirthDate(getDate())
                .setAddressData(buidlAddressData())
                .build();
        data.setCurp(getCurp(data));
        data.setRfc(getRfc(data));

       final Person person = new Person.Builder()
                .setType(PersonType.PROSPECT)
                .build();
        Section section = Person.getSection(SectionCode.PROSPECT_DATA, person.getSections());
        section.setSectionData(data);
        SaveSectionUseCase useCase = new SaveSectionUseCase(PersonRepository.getInstance());
        useCase.execute(new SaveSectionUseCase.SectionRequest(person, section, -1), new DisposableObserver<ResultData>() {
            @Override
            public void onNext(ResultData resultData) {
                if(resultData.getType() == ResultType.SUCCESS){
                    Log.d("Prospect created!");
                }
            }

            @Override
            public void onError(Throwable e) {
                Log.e("Result: ",e);
            }

            @Override
            public void onComplete() {

            }
        });
    }


    public Long getDate(){
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.YEAR,1999);
        calendar.set(Calendar.MONTH,3);
        return calendar.getTimeInMillis();
    }

    public AddressData buidlAddressData() {
        AddressData addressData = new AddressData();
        addressData.setStreet("Avenida siempre viva");
        addressData.setCity("Ciudad");
        addressData.setPostalCode("10000");
        addressData.setNumber(2123);
        addressData.setInternalNumber(12132);
        addressData.setStateName("Ciudad de Mexico");
        addressData.setStateCode("9");
        addressData.setTownName("Algo");
        addressData.setTownCode("272");
        addressData.setVillageName("Colonia");
        addressData.setVillageCode("28397");
        addressData.setCountryCode("484");

        LocationData reference = new LocationData(19.3145421,-99.24114589999999);
        return addressData;
    }

    static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    static SecureRandom rnd = new SecureRandom();

    static String randomString(int len) {
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++)
            sb.append(AB.charAt(rnd.nextInt(AB.length())));
        return sb.toString();
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
