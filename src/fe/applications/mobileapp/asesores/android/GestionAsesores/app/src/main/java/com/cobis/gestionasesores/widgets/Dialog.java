package com.cobis.gestionasesores.widgets;

import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.ArrayRes;
import android.support.annotation.NonNull;
import android.support.annotation.StringRes;
import android.support.v4.app.DialogFragment;
import android.support.v4.app.FragmentManager;
import android.support.v7.app.AlertDialog;
import android.view.KeyEvent;

public class Dialog extends DialogFragment {

    private boolean backCancellable;
    private String strTitle, strMessage, strPositiveBtn, strNegativeBtn;
    private DialogInterface.OnClickListener posBtnListener, negBtnListener;
    private CharSequence[] mItems;
    private DialogInterface.OnMultiChoiceClickListener mOnCheckboxClickListener;
    private boolean[] mCheckedItems;
    private boolean mIsMultiChoice;
    private Context context;

    public static Dialog newInstance(Context context) {
        Dialog fragment = new Dialog();
        fragment.setContext(context);
        return fragment;
    }

    @Override
    public void onCreate(Bundle arg0) {
        setRetainInstance(true);
        super.onCreate(arg0);
    }

    @NonNull
    @Override
    public android.app.Dialog onCreateDialog(Bundle savedInstanceState) {
        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
        //Set title
        if (strTitle != null) {
            builder.setTitle(strTitle);
        }
        //Set message
        if (strMessage != null) {
            builder.setMessage(strMessage);
        }
        //Set positive button
        if (strPositiveBtn != null && strPositiveBtn.trim().length() > 0) {
            builder.setPositiveButton(strPositiveBtn, posBtnListener);
        }
        //Set negative button
        if (strNegativeBtn != null && strNegativeBtn.trim().length() > 0) {
            builder.setNegativeButton(strNegativeBtn, negBtnListener);
        }
        // Set multiple choice items
        if (mIsMultiChoice && mItems != null) {
            builder.setMultiChoiceItems(mItems, mCheckedItems, mOnCheckboxClickListener);
        }

        builder.setOnKeyListener(backKeyListener);
        builder.setCancelable(true);

        return builder.create();
    }

    @Override
    public void onDestroyView() {
        if (getDialog() != null && getRetainInstance()) {
            getDialog().setDismissMessage(null);
            getDialog().setOnDismissListener(null);
        }
        super.onDestroyView();
    }

    @Override
    public void dismiss() {
        if (isShowing()) {
            try {
                super.dismiss();
            } catch (Exception ignored) {
            }
        }
    }

    public boolean isShowing() {
        return (getDialog() != null && getDialog().isShowing()) && isAdded();
    }

    @Override
    public void show(FragmentManager manager, String tag) {
        try {
            manager.executePendingTransactions();
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (isAdded() && !isShowing()) {
            try {
                manager.beginTransaction().remove(this).commit();
                manager.executePendingTransactions();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (!isAdded()) {
            super.show(manager, tag);
        }
    }

    DialogInterface.OnKeyListener backKeyListener = new DialogInterface.OnKeyListener() {

        @Override
        public boolean onKey(DialogInterface dialog, int keyCode, KeyEvent event) {
            if (keyCode == KeyEvent.KEYCODE_BACK) {
                if (backCancellable) {
                    dismiss();
                }
                return true;
            }
            return false;
        }
    };

    public Dialog setTitle(String title) {
        this.strTitle = title;
        return this;
    }

    public Dialog setMessage(String message) {
        this.strMessage = message;
        return this;
    }

    public Dialog setTitle(@StringRes int title) {
        this.strTitle = context.getString(title);
        return this;
    }

    public Dialog setTitle(@StringRes int title, Object... formatArgs) {
        this.strTitle = context.getString(title, formatArgs);
        return this;
    }

    public Dialog setMessage(@StringRes int message) {
        this.strMessage = context.getString(message);
        return this;
    }

    public Dialog setMessage(@StringRes int message, Object... formatArgs) {
        this.strMessage = context.getString(message, formatArgs);
        return this;
    }

    public Dialog setPositiveButton(@StringRes int textId, DialogInterface.OnClickListener listener) {
        this.strPositiveBtn = context.getString(textId);
        this.posBtnListener = listener;
        return this;
    }

    public Dialog setPositiveButton(String text, DialogInterface.OnClickListener listener) {
        this.strPositiveBtn = text;
        this.posBtnListener = listener;
        return this;
    }

    public Dialog setNegativeButton(@StringRes int textId, DialogInterface.OnClickListener listener) {
        this.strNegativeBtn = context.getString(textId);
        this.negBtnListener = listener;
        return this;
    }

    public Dialog setNegativeButton(String text, DialogInterface.OnClickListener listener) {
        this.strNegativeBtn = text;
        this.negBtnListener = listener;
        return this;
    }

    public Dialog setBackCancellable(boolean backCancellable) {
        this.backCancellable = backCancellable;
        return this;
    }

    /**
     * Set a list of items to be displayed in the dialog as the content,
     * you will be notified of the selected item via the supplied listener.
     * This should be an array type, e.g. R.array.foo. The list will have
     * a check mark displayed to the right of the text for each checked
     * item. Clicking on an item in the list will not dismiss the dialog.
     * Clicking on a button will dismiss the dialog.
     *
     * @param itemsId      the resource id of an array i.e. R.array.foo
     * @param checkedItems specifies which items are checked. It should be null in which case no
     *                     items are checked. If non null it must be exactly the same length as the array of
     *                     items.
     * @param listener     notified when an item on the list is clicked. The dialog will not be
     *                     dismissed when an item is clicked. It will only be dismissed if clicked on a
     *                     button, if no buttons are supplied it's up to the user to dismiss the dialog.
     * @return This Builder object to allow for chaining of calls to set methods
     */
    public Dialog setMultiChoiceItems(@ArrayRes int itemsId, boolean[] checkedItems, final DialogInterface.OnMultiChoiceClickListener listener) {
        mItems = context.getResources().getTextArray(itemsId);
        mOnCheckboxClickListener = listener;
        mCheckedItems = checkedItems;
        mIsMultiChoice = true;
        return this;
    }

    /**
     * Set a list of items to be displayed in the dialog as the content,
     * you will be notified of the selected item via the supplied listener.
     * The list will have a check mark displayed to the right of the text
     * for each checked item. Clicking on an item in the list will not
     * dismiss the dialog. Clicking on a button will dismiss the dialog.
     *
     * @param items        the text of the items to be displayed in the list.
     * @param checkedItems specifies which items are checked. It should be null in which case no
     *                     items are checked. If non null it must be exactly the same length as the array of
     *                     items.
     * @param listener     notified when an item on the list is clicked. The dialog will not be
     *                     dismissed when an item is clicked. It will only be dismissed if clicked on a
     *                     button, if no buttons are supplied it's up to the user to dismiss the dialog.
     * @return This Builder object to allow for chaining of calls to set methods
     */
    public Dialog setMultiChoiceItems(CharSequence[] items, boolean[] checkedItems, final DialogInterface.OnMultiChoiceClickListener listener) {
        mItems = items;
        mOnCheckboxClickListener = listener;
        mCheckedItems = checkedItems;
        mIsMultiChoice = true;
        return this;
    }

    private void setContext(Context context) {
        this.context = context;
    }
}
