package fnc.com.seeking_shelter.listingdetailspage

import android.support.v4.app.Fragment
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import fnc.com.seeking_shelter.R

class DetailsFragment : Fragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        val root = inflater.inflate(R.layout.listing_details, container, false)
        return root
    }

    companion object {
        @JvmStatic
        fun newInstance(): DetailsFragment {
            return DetailsFragment()
        }
    }
}