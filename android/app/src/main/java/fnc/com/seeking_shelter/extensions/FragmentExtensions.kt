package fnc.com.seeking_shelter.extensions

import android.content.Intent
import android.net.Uri
import android.support.v4.app.Fragment
import fnc.com.seeking_shelter.R
import fnc.com.seeking_shelter.responses.ListingResponse

fun Fragment.changeFragment(fragment: Fragment) {
    this.fragmentManager?.beginTransaction()
            ?.add(R.id.fragment_container, fragment)
            ?.addToBackStack(null)
            ?.commit()
}

fun Fragment.openBrowser(url: String) {
    Intent().run {
        action = Intent.ACTION_VIEW
        data = Uri.parse(url)
        context?.packageManager?.let {
            this.resolveActivity(it)?.let {
                startActivity(this)
            }
        }
    }
}

fun Fragment.openDialer(number: String) {
    Intent().run {
        action = Intent.ACTION_DIAL
        data = Uri.parse("tel:${number}")
        context?.packageManager?.let {
            this.resolveActivity(it)?.let {
                startActivity(this)
            }
        }
    }
}

fun Fragment.openEmail() {
    Intent().run {
        action = Intent.ACTION_SENDTO
        data = Uri.parse("mailto:${getString(R.string.site_email)}?subject=${Uri.encode(getString(R.string.email_subject))}")
        context?.packageManager?.let {
            this.resolveActivity(it)?.let {
                startActivity(this)
            }
        }
    }
}

fun Fragment.openNavigation(listing: ListingResponse) {
    Intent().run {
        action = Intent.ACTION_VIEW
        data = if (listing.latitude.isNotEmpty() && listing.longitude.isNotEmpty()) {
            Uri.parse("geo:${listing.latitude},${listing.longitude}?q=${listing.fullAddress}")
        } else {
            Uri.parse("geo:0,0?q=${listing.fullAddress}")
        }
        context?.packageManager?.let {
            this.resolveActivity(it)?.let {
                startActivity(this)
            }
        }
    }
}
