package fnc.com.seeking_shelter.listingdetailspage

import android.support.v4.app.Fragment
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import fnc.com.seeking_shelter.R
import fnc.com.seeking_shelter.extensions.openBrowser
import fnc.com.seeking_shelter.extensions.openDialer
import fnc.com.seeking_shelter.extensions.openNavigation
import fnc.com.seeking_shelter.responses.ListingResponse
import kotlinx.android.synthetic.main.listing_details.*

class DetailsFragment : Fragment() {

    private lateinit var listingResponse: ListingResponse
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View = inflater.inflate(R.layout.listing_details, container, false)

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        listingResponse.let {
            title.text = it.organizationName
            description.text = it.overview
            category.text = it.category
        }

        if (listingResponse.phone.isNotEmpty()) {
            phonenum.setOnClickListener { _ -> this.openDialer(listingResponse.phone) }
        } else {
            phonenum.visibility = View.GONE
        }

        if (listingResponse.website.isNotEmpty()) {
            website.setOnClickListener { _ -> this.openBrowser(listingResponse.website) }
        } else {
            website.visibility = View.GONE
        }

        if (listingResponse.address.isNotEmpty()) {
            address.setOnClickListener { _ -> this.openNavigation(listingResponse) }
        } else {
            address.visibility = View.GONE
        }

        super.onViewCreated(view, savedInstanceState)
    }

    companion object {
        @JvmStatic
        fun newInstance(listingResponse: ListingResponse): DetailsFragment {
            val fragment = DetailsFragment()
            fragment.listingResponse = listingResponse
            return fragment
        }
    }
}