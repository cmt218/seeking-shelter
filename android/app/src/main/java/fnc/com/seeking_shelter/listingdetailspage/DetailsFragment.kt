package fnc.com.seeking_shelter.listingdetailspage

import android.support.v4.app.Fragment
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import fnc.com.seeking_shelter.R
import fnc.com.seeking_shelter.responses.ListingResponse
import kotlinx.android.synthetic.main.listing_details.*

class DetailsFragment : Fragment() {

    private lateinit var listingResponse: ListingResponse
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        val root = inflater.inflate(R.layout.listing_details, container, false)
        return root
    }

    override fun onViewCreated(view: View?, savedInstanceState: Bundle?) {
        title.text = listingResponse.organizationName
        overview.text = listingResponse.overview
        phone.text = listingResponse.phone
        city.text = listingResponse.city
        full_address.text = listingResponse.fullAddress
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