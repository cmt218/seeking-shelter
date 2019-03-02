package fnc.com.seeking_shelter.webviewpage

import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import fnc.com.seeking_shelter.R
import kotlinx.android.synthetic.main.web_view.*

class WebviewFragment : Fragment() {
    private lateinit var url: String

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? = inflater.inflate(R.layout.web_view, container, false)

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) = webview.loadUrl(url)


    companion object {
        @JvmStatic
        fun newInstance(url: String): WebviewFragment {
            val fragment = WebviewFragment()
            fragment.url = url
            return fragment
        }
    }
}