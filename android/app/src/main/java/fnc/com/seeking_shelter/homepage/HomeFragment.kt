package fnc.com.seeking_shelter.homepage

import android.os.Bundle
import android.support.v4.app.Fragment
import android.support.v4.app.ListFragment
import android.support.v4.app.NavUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import fnc.com.seeking_shelter.R
import fnc.com.seeking_shelter.contactpage.ContactFragment
import fnc.com.seeking_shelter.donatepage.DonateFragment
import fnc.com.seeking_shelter.listingpage.ListingFragment
import fnc.com.seeking_shelter.mappage.MapFragment
import kotlinx.android.synthetic.main.home_fragment.*

class HomeFragment : Fragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val root = inflater.inflate(R.layout.home_fragment, container, false)
        return root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {

        navigate_donate.setOnClickListener(changeFragment(DonateFragment.newInstance()))
        navigate_contact.setOnClickListener(changeFragment(ContactFragment.newInstance()))
        navigate_list.setOnClickListener(changeFragment(ListingFragment.newInstance()))
        navigate_map.setOnClickListener(changeFragment(MapFragment.newInstance()))

        super.onViewCreated(view, savedInstanceState)
    }

    fun changeFragment(fragment: Fragment): View.OnClickListener = View.OnClickListener {
        fragmentManager?.let {
            it.beginTransaction()
                    .replace(R.id.fragment_container, fragment)
                    .addToBackStack(null)
                    .commit()
        }
    }
}