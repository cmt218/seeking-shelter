package fnc.com.seeking_shelter.adapters

import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import fnc.com.seeking_shelter.R
import fnc.com.seeking_shelter.responses.ListingResponse
import kotlinx.android.synthetic.main.listing.view.*

class ListingAdapter(private val listings: List<ListingResponse>, val type: Int, val listener: (ListingResponse) -> Unit) : RecyclerView.Adapter<ListingAdapter.ListingViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup?, viewType: Int) = ListingViewHolder(LayoutInflater.from(parent?.context).inflate(R.layout.listing, parent, false))

    override fun getItemCount() = listings.size

    override fun onBindViewHolder(holder: ListingViewHolder, position: Int) {
        when(type){
            ORGANIZATION_NAME -> holder.bindOrganizationName(listings[position], listener)
            else -> holder.bindCity(listings[position], listener)
        }
    }

    class ListingViewHolder(val view: View) : RecyclerView.ViewHolder(view) {
        val name: TextView = view.findViewById(R.id.name)

        fun bindOrganizationName(item: ListingResponse, listener: (ListingResponse) -> Unit) = with(itemView) {
            name.text = item.organizationName
            setOnClickListener { listener(item) }
        }

        fun bindCity(item: ListingResponse, listener: (ListingResponse) -> Unit) = with(itemView) {
            name.text = item.city
            setOnClickListener { listener(item) }
        }
    }

    companion object {
        const val ORGANIZATION_NAME = 1
        const val CITY = 2
    }
}