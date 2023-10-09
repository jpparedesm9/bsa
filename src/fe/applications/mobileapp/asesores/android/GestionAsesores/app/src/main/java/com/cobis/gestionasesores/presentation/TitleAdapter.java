package com.cobis.gestionasesores.presentation;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.SingleItem;

import java.util.List;

/**
 * Created by Miguel on 24/06/2017.
 */

public class TitleAdapter extends ArrayAdapter<SingleItem> {
    @StringRes
    private int mTitle;

    public TitleAdapter(@NonNull Context context, @StringRes int title, List<SingleItem> items) {
        super(context, android.R.layout.simple_spinner_dropdown_item, items);
        mTitle = title;
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        ViewHolder viewHolder;
        if (convertView == null) {
            viewHolder = new ViewHolder();
            convertView = LayoutInflater.from(getContext()).inflate(R.layout.row_title_lines2, parent, false);
            viewHolder.title = (TextView) convertView.findViewById(R.id.text_title);
            viewHolder.subTitle = (TextView) convertView.findViewById(R.id.text_subtitle);
            convertView.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) convertView.getTag();
        }

        SingleItem item = getItem(position);
        viewHolder.title.setText(mTitle);
        viewHolder.subTitle.setText(item.getValue());
        return convertView;
    }

    static class ViewHolder {
        TextView title;
        TextView subTitle;
    }
}
