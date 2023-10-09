package com.cobis.gestionasesores.presentation.sections.documents;

import android.graphics.Bitmap;
import android.graphics.drawable.Drawable;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bayteq.libcore.util.StringUtils;
import com.bayteq.thridparty.ScalingUtilities;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.models.Document;
import com.cobis.gestionasesores.utils.ResourcesUtil;
import com.cobis.gestionasesores.utils.Util;
import com.squareup.picasso.Picasso;
import com.squareup.picasso.Target;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by Miguel on 15/06/2017.
 */

public class DocumentListAdapter extends RecyclerView.Adapter<DocumentListAdapter.ViewHolder> {
    private List<Document> mData;
    private OnItemClickListener mListener;
    int mMaxImageHeight;
    int mMaxImageWidth;

    public DocumentListAdapter(List<Document> mData, OnItemClickListener mListener) {
        this.mData = mData;
        this.mListener = mListener;
        mMaxImageHeight = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MAX_DOCUMENT_HEIGHT);
        mMaxImageWidth = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MAX_DOCUMENT_WIDTH);
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.holder_document, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        holder.bind(mData.get(position), mListener);
    }

    @Override
    public int getItemCount() {
        return mData.size();
    }

    public void updateAll(List<Document> documents) {
        mData = documents;
        notifyDataSetChanged();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.image_document)
        ImageView mDocumentImage;
        @BindView(R.id.text_name)
        TextView mNameText;
        @BindView(R.id.image_status)
        ImageView mImageStatus;

        public ViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }

        public void bind(final Document document, final OnItemClickListener listener) {
            mImageStatus.setVisibility(StringUtils.isNotEmpty(document.getImage()) ? View.VISIBLE : View.GONE);
            mImageStatus.setImageResource(ResourcesUtil.getDocumentStatusResource(document.getStatus()));

            Target target = new Target() {
                @Override
                public void onBitmapLoaded(Bitmap bitmap, Picasso.LoadedFrom from) {
                    mDocumentImage.setImageBitmap(ScalingUtilities.createScaledBitmap(bitmap, mMaxImageWidth, mMaxImageHeight, ScalingUtilities.ScalingLogic.FIT));
                }

                @Override
                public void onBitmapFailed(Drawable errorDrawable) {
                    mDocumentImage.setImageDrawable(errorDrawable);
                }

                @Override
                public void onPrepareLoad(Drawable placeHolderDrawable) {
                    mDocumentImage.setImageDrawable(placeHolderDrawable);
                }
            };
            mDocumentImage.setTag(target);
            Picasso.with(itemView.getContext())
                    .load(Util.createUri(document.getImage()))
                    .error(R.drawable.ic_document_picture)
                    .placeholder(R.drawable.ic_document_picture)
                    .into(target);
            int text = ResourcesUtil.getDocumentName(document.getType());
            if(text > 0) {
                mNameText.setText(text);
            }
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    listener.onItemClick(document);
                }
            });
        }
    }

    public interface OnItemClickListener {
        void onItemClick(Document document);
    }
}
