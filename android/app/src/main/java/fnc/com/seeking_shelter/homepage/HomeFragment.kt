package fnc.com.seeking_shelter.homepage

import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import fnc.com.seeking_shelter.R
import fnc.com.seeking_shelter.mappage.MapFragment
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.home_fragment.*

class HomeFragment : Fragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val root = inflater.inflate(R.layout.home_fragment, container, false)
        return root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        navigate_donate.text = getString(R.string.donate)
        navigate_contact.text = getString(R.string.contact)
        navigate_list.text = getString(R.string.listings)
        navigate_map.text = getString(R.string.map)
        navigate_map.setOnClickListener( View.OnClickListener {
            fragmentManager
                    ?.beginTransaction()
                    ?.hide(this)
                    ?.add(MapFragment.newInstance(), "Map")
                    ?.commit() })
        super.onViewCreated(view, savedInstanceState)
    }
}