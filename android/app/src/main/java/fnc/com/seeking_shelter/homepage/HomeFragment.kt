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
import fnc.com.seeking_shelter.extensions.openBrowser
import fnc.com.seeking_shelter.mappage.MapFragment
import kotlinx.android.synthetic.main.home_fragment.*

class HomeFragment : Fragment() {

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?, savedInstanceState: Bundle?):
            View? = inflater.inflate(R.layout.home_fragment, container, false)

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        navigate_donate.setOnClickListener {
            _ -> this.openBrowser(getString(R.string.donate_url))}
        navigate_contact.setOnClickListener {
            _ -> this.changeFragment(ContactFragment.newInstance()) }
        navigate_list.setOnClickListener {
            _ -> this.changeFragment(CitiesListingFragment.newInstance()) }
        navigate_map.setOnClickListener {
            _ -> this.changeFragment(MapFragment.newInstance()) }

        super.onViewCreated(view, savedInstanceState)
    }
}