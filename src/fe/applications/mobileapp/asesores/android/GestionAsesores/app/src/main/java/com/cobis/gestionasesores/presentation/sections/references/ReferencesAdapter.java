package com.cobis.gestionasesores.presentation.sections.references;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Reference;
import com.cobis.gestionasesores.utils.ResourcesUtil;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by mnaunay on 09/06/2017.
 */

public class ReferencesAdapter extends RecyclerView.Adapter<ReferencesAdapter.ViewHolder> {
    private List<Reference> mData;
    private final OnItemClickListener mListener;

    public ReferencesAdapter(List<Reference> data, OnItemClickListener listener) {
        mData = data;
        mListener = listener;
    }


    public void replaceAll(List<Reference> references) {
        mData = references;
        if (mData.size() > 1) {
            Collections.sort(mData, new Comparator<Reference>() {
                @Override
                public int compare(Reference reference, Reference t1) {
                    return reference.getName().compareToIgnoreCase(t1.getName());
                }
            });
        }
        notifyDataSetChanged();
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.holder_section_references, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        holder.bind(mData.get(position), position, mListener);
    }

    @Override
    public int getItemCount() {
        return mData.size();
    }

    public static class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.text_name)
        TextView mNameText;
        @BindView(R.id.image_status)
        ImageView mStatusImage;

        public ViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }

        public void bind(final Reference reference, final int position, final OnItemClickListener listener) {
            mStatusImage.setImageResource(ResourcesUtil.getSyncStatusResource(reference.getStatus()));
            mNameText.setText(reference.toString());
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(position, reference);
                }
            });
        }
    }

    public interface OnItemClickListener {
        void onItemClick(int position, Reference reference);
    }
}
