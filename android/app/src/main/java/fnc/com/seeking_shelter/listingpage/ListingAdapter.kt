package fnc.com.seeking_shelter.listingpage

import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import fnc.com.seeking_shelter.R
import fnc.com.seeking_shelter.responses.ListingResponse

class ListingAdapter(private val listings: List<ListingResponse>) : RecyclerView.Adapter<ListingAdapter.ListingViewHolder>() {

    class ListingViewHolder(val view: View) : RecyclerView.ViewHolder(view) {
        val name: TextView = view.findViewById(R.id.name)
    }

    override fun onCreateViewHolder(parent: ViewGroup?, viewType: Int): ListingViewHolder {
        val view = LayoutInflater.from(parent?.context).inflate(R.layout.listing, parent, false)
        return ListingViewHolder(view)
    }

    override fun onBindViewHolder(holder: ListingViewHolder?, position: Int) {
        holder?.name?.text = listings[position].organizationName
    }

    override fun getItemCount(): Int {
        return listings.size
    }
}