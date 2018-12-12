package fnc.com.seeking_shelter.listingpage

import android.support.v4.app.Fragment
import android.os.Bundle
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import fnc.com.seeking_shelter.ListingDataFragmentContract
import fnc.com.seeking_shelter.R
import fnc.com.seeking_shelter.model.Model
import fnc.com.seeking_shelter.responses.ListingResponse
import kotlinx.android.synthetic.main.listing_fragment.*

class ListingFragment : Fragment(), ListingDataFragmentContract.CanGetListings {

    private lateinit var recyclerView: RecyclerView
    private lateinit var viewAdapter: RecyclerView.Adapter<*>
    private lateinit var viewManager: RecyclerView.LayoutManager
    private val listingModel = Model(this)

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val root = inflater.inflate(R.layout.listing_fragment, container, false)
        listingModel.fetchAllPlaces()
        return root
    }

    override fun onListingsLoaded(listings: List<ListingResponse>) {
        viewManager = LinearLayoutManager(context)
        viewAdapter = ListingAdapter(listings)

        recyclerView = listing_recycler.apply {
            setHasFixedSize(true)
            layoutManager = viewManager
            adapter = viewAdapter
        }
    }

    companion object {
        @JvmStatic
        fun newInstance(): ListingFragment {
            return ListingFragment()
        }
    }
}