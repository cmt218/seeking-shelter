package fnc.com.seeking_shelter.listingdetailspage

import android.support.v4.app.Fragment
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import fnc.com.seeking_shelter.R
import fnc.com.seeking_shelter.extensions.openBrowser
import fnc.com.seeking_shelter.responses.ListingResponse
import kotlinx.android.synthetic.main.listing_details.*

class DetailsFragment : Fragment() {

    private lateinit var listingResponse: ListingResponse
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View = inflater.inflate(R.layout.listing_details, container, false)

    override fun onViewCreated(view: View?, savedInstanceState: Bundle?) {
        listingResponse.run {
            title.text = organizationName
            description.text = overview
            phonenum.text = phone
            orgcity.text = city
            full_address.text = fullAddress
            url.text = website
        }

        url.setOnClickListener { v -> this.openBrowser(url.text.toString()) }
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