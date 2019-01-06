package fnc.com.seeking_shelter.extensions

import android.support.v4.app.Fragment
import fnc.com.seeking_shelter.R

fun Fragment.changeFragment(fragment: Fragment) {
    this.fragmentManager.beginTransaction()
            .add(R.id.fragment_container, fragment)
            .addToBackStack(null)
            .commit()
}