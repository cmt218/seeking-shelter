package fnc.com.seeking_shelter.homepage

import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import fnc.com.seeking_shelter.R
import fnc.com.seeking_shelter.citieslistingpage.CitiesListingFragment
import fnc.com.seeking_shelter.contactpage.ContactFragment
import fnc.com.seeking_shelter.extensions.changeFragment
import fnc.com.seeking_shelter.mappage.MapFragment
import fnc.com.seeking_shelter.webviewpage.WebviewFragment
import kotlinx.android.synthetic.main.home_fragment.*

class HomeFragment : Fragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? = inflater.inflate(R.layout.home_fragment, container, false)

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        navigate_donate.setOnClickListener { v -> this.changeFragment(WebviewFragment.newInstance(getString(R.string.donate_url))) }
        navigate_contact.setOnClickListener { v -> this.changeFragment(ContactFragment.newInstance()) }
        navigate_list.setOnClickListener { v -> this.changeFragment(CitiesListingFragment.newInstance()) }
        navigate_map.setOnClickListener { v -> this.changeFragment(MapFragment.newInstance()) }

        super.onViewCreated(view, savedInstanceState)
    }
}