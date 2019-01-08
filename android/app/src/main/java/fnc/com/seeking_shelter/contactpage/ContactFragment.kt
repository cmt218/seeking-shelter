package fnc.com.seeking_shelter.contactpage

import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import fnc.com.seeking_shelter.R
import fnc.com.seeking_shelter.extensions.openBrowser
import kotlinx.android.synthetic.main.contact_fragment.*

class ContactFragment : Fragment() {
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? = inflater.inflate(R.layout.contact_fragment, container, false)

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) = url.setOnClickListener { v -> this.openBrowser(url.text.toString())}

    companion object {
        @JvmStatic
        fun newInstance(): ContactFragment {
            return ContactFragment()
        }
    }
}