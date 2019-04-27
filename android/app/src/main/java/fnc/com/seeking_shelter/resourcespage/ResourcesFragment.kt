package fnc.com.seeking_shelter.resourcespage

import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import fnc.com.seeking_shelter.R
import fnc.com.seeking_shelter.extensions.openDialer
import kotlinx.android.synthetic.main.resources_fragment.*

class ResourcesFragment : Fragment() {
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? = inflater.inflate(R.layout.resources_fragment, container, false)

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        domesticViolenceButton.setOnClickListener { _ -> this.openDialer("1-800-799-SAFE")}
        sexualAssaultButton.setOnClickListener { _ -> this.openDialer("1-800-656-HOPE")}
        childAbuseButton.setOnClickListener { _ -> this.openDialer("1-800-4-A-CHILD")}
        trevorHotlineButton.setOnClickListener { _ -> this.openDialer("1-866-4-U-TREVOR")}
        missingChildButton.setOnClickListener { _ -> this.openDialer("1-800-235-3535")}
        drugAbuseButton.setOnClickListener { _ -> this.openDialer("1-800-662-4357")}
        runawayButton.setOnClickListener { _ -> this.openDialer("1-800-621-4000")}
        youthCrisisButton.setOnClickListener { _ -> this.openDialer("1-800-448-4663")}
        suicideButton.setOnClickListener { _ -> this.openDialer("1-800-SUICIDE")}
        elderAbuseButton.setOnClickListener { _ -> this.openDialer("1-800-252-8966")}
    }

    companion object {
        @JvmStatic
        fun newInstance(): ResourcesFragment {
            return ResourcesFragment()
        }
    }
}