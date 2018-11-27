package fnc.com.seeking_shelter.listingpage

import android.util.Log
import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import fnc.com.seeking_shelter.responses.ListingResponse

class ListingModel constructor(private val listingPresenter: ListingPresenter) {
    val resJson = """
    {
       "id": "",
       "timestamp": "",
       "isOpen": true,
       "organizationName": "Y2Y Harvard Square",
       "category": "Youth Shelter",
       "tags": "Youth, Teens, Warming Center, Cooling Center, Case Management",
       "website": "https://www.y2yharvardsquare.org",
       "phone": "(617) 864-0795",
       "overview": "Y2Y Harvard Square (Y2Y), a student-run overnight shelter, employs a youth-to-youth model to provide a safe and affirming environment for young adults experiencing homelessness. Y2Y offers two kinds of stays, 30-night stays and 1-night stays. They only give away beds by lottery.\r",
       "twitterUrl": "@Y2YNetwork",
       "facebookUrl": "https://www.facebook.com/Y2Ynetwork/",
       "instagramUrl": "",
       "address": "1 Church Street",
       "city": "Cambridge",
       "state": "MA ",
       "zip": 2138,
       "country": "USA",
       "fullAddress": "1 Church Street Cambridge MA  02138 USA",
       "latitude": "42.3745722",
       "longitude": "-71.1193263999999"
    }
    """

    val moshi = Moshi.Builder()
            .add(KotlinJsonAdapterFactory())
            .build()

    fun doThing() {
        val listingAdapter = moshi.adapter(ListingResponse::class.java)
        val listing = listingAdapter.fromJson(resJson)

        Log.e("RESPONSE", listing.toString())
    }

}