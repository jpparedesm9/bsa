package com.cobis.gestionasesores.presentation.settings;

/**
 * Created by jescudero on 01/09/2017.
 */

public class SettingsPresenter implements SettingsContract.SettingsPresenter {
    private SettingsContract.SettingsView mView;

    public SettingsPresenter(SettingsContract.SettingsView view) {
        mView = view;
    }

    @Override
    public void start() {

    }
}
