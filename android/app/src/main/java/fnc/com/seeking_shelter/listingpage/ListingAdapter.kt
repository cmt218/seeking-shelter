package fnc.com.seeking_shelter.listingpage

import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import fnc.com.seeking_shelter.R
import fnc.com.seeking_shelter.responses.ListingResponse
import kotlinx.android.synthetic.main.listing.view.*

class ListingAdapter(private val listings: List<ListingResponse>, val listener: (ListingResponse) -> Unit) : RecyclerView.Adapter<ListingAdapter.ListingViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup?, viewType: Int) = ListingViewHolder(LayoutInflater.from(parent?.context).inflate(R.layout.listing, parent, false))

    override fun getItemCount() = listings.size

    override fun onBindViewHolder(holder: ListingViewHolder, position: Int) = holder.bind(listings[position], listener)

    class ListingViewHolder(val view: View) : RecyclerView.ViewHolder(view) {
        val name: TextView = view.findViewById(R.id.name)

        fun bind(item: ListingResponse, listener: (ListingResponse) -> Unit) = with(itemView) {
            this.name.text = item.organizationName
            this.setOnClickListener { listener(item) }
        }
    }
}