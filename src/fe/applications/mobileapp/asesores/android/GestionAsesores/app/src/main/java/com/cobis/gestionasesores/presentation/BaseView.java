package com.cobis.gestionasesores.presentation;

/**
 * This interface is the base for all Views in the project
 * Created by mnaunay on 02/06/2017.
 */

public interface BaseView<T> {
    void setPresenter(T presenter);
}