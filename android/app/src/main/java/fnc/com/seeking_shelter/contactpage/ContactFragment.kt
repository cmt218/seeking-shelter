package fnc.com.seeking_shelter.contactpage

import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import fnc.com.seeking_shelter.R
import fnc.com.seeking_shelter.extensions.openBrowser
import fnc.com.seeking_shelter.extensions.openEmail
import kotlinx.android.synthetic.main.contact_fragment.*

class ContactFragment : Fragment() {
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? = inflater.inflate(R.layout.contact_fragment, container, false)

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        url.setOnClickListener { _ -> this.openBrowser(getString(R.string.site_url)) }
        email.setOnClickListener { _ -> this.openEmail() }
        facebook.setOnClickListener { _ -> this.openBrowser(getString(R.string.facebook_url)) }
        instagram.setOnClickListener { _ -> this.openBrowser(getString(R.string.instagram_url)) }
    }

    companion object {
        @JvmStatic
        fun newInstance(): ContactFragment {
            return ContactFragment()
        }
    }
}