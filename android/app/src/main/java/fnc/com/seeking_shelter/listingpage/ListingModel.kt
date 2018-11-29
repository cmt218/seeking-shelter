package fnc.com.seeking_shelter.listingpage


import android.util.Log
import com.squareup.moshi.JsonAdapter
import com.squareup.moshi.Moshi
import com.squareup.moshi.Types
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import fnc.com.seeking_shelter.responses.ListingResponse

class ListingModel constructor(private val listingPresenter: ListingPresenter) {

    val moshi = Moshi.Builder()
            .add(KotlinJsonAdapterFactory())
            .build()

    fun doThing() {
        val listType = Types.newParameterizedType(List::class.java, ListingResponse::class.java)
        val listingAdapter: JsonAdapter<List<ListingResponse>> = moshi.adapter(listType)
        val listing = listingAdapter.fromJson(resJson)

        Log.e("RESPONSE", listing.toString())
    }

    val resJson = """
    [
        {
            "ID":1,
            "Timestamp":"",
            "Open":true,
            "Organization Name":"Y2Y Harvard Square",
            "Category":"Youth Shelter",
            "Tags":"Youth, Teens, Warming Center, Cooling Center, Case Management",
            "Website":"https://www.y2yharvardsquare.org",
            "Phone":"(617) 864-0795",
            "Overview":"Y2Y Harvard Square (Y2Y), a student-run overnight shelter, employs a youth-to-youth model to provide a safe and affirming environment for young adults experiencing homelessness. Y2Y offers two kinds of stays, 30-night stays and 1-night stays. They only give away beds by lottery.",
            "Twitter URL":"@Y2YNetwork",
            "Facebook URL":"https://www.facebook.com/Y2Ynetwork/",
            "Instagram URL":"",
            "Address":"1 Church Street",
            "City":"Cambridge",
            "State":"MA",
            "Zip Code":"02138",
            "Country":"USA",
            "Full Address":"1 Church Street Cambridge MA 02138 USA ",
            "Latitude":42.3745722,
            "Longitude":-71.1193263999999
        },
        {
            "ID":2,
            "Timestamp":"",
            "Open":true,
            "Organization Name":"Bridge Home",
            "Category":"Youth Shelter",
            "Tags":"Youth, Children",
            "Website":"http://stmaryscenterma.org/about/home/bridge-home/",
            "Phone":"(617) 436-8600",
            "Overview":"Bridge Home is a family-focused short-term crisis intervention and stabilization residence for children who have experienced trauma. the program serves 12 children, ages newborn to 12 years old. Many of the children who come to Bridge Home have witnessed violence and have experienced trauma. Bridge Home provides a thorough children and family assessment that provides the team with recommendations and services that will enable children to remain with their family, school and neighborhood whenever possible.",
            "Twitter URL":"",
            "Facebook URL":"",
            "Instagram URL":"",
            "Address":"90 Cushing Avenue",
            "City":"Dorchester",
            "State":"MA ",
            "Zip Code":"02125",
            "Country":"USA",
            "Full Address":"90 Cushing Avenue Dorchester MA  02125 USA ",
            "Latitude":42.3139038,
            "Longitude":-71.0634264
        },
        {
            "ID":3,
            "Timestamp":"",
            "Open":true,
            "Organization Name":"Bridge Over Troubled Waters",
            "Category":"Youth Shelter",
            "Tags":"Youth, Teens, Warming Center, Cooling Center, Case Management, Mental Health, Transitional Living Program",
            "Website":"https://www.bridgeotw.org",
            "Phone":"(617) 423-9575",
            "Overview":"Emergency residence program is a short-term transitional residential program for homeless youth who are able to commit to intensive counseling, maintain employment, save 70% of their income, continue their education, and work with case managers to obtain long-term transitional or permanent housing. The transitional living program (TLP) is for 12 young men and women, ages 18-24. Residents are required to maintain employment, continue their education, meet weekly with a Bridge counselor, and work with case managers on reaching their goals. Residents have access to all of the services at Bridge; and may stay in the TLP for up to two years. Also offers an open-intake, voluntary transitional living program for pregnant and parenting homeless young women and their children- serves eleven families at any given time and they may stay for up to two years.",
            "Twitter URL":"@BridgeOTW",
            "Facebook URL":"https://www.facebook.com/bridgeotw/",
            "Instagram URL":"@bridgeotw",
            "Address":"47 West Street",
            "City":"Boston",
            "State":"MA ",
            "Zip Code":"02111",
            "Country":"USA",
            "Full Address":"47 West Street Boston MA  02111 USA ",
            "Latitude":42.3551429,
            "Longitude":-71.0630011
        },
        {
            "ID":4,
            "Timestamp":"",
            "Open":true,
            "Organization Name":"Mary Eliza Mahoney House Emergency Family Shelter",
            "Category":"Emergency Shelter",
            "Tags":"Family, Case Management, Mental Health",
            "Website":"https://www.dimock.org/behavioral-health/emergency-shelter/",
            "Phone":"(617) 442-8800 ",
            "Overview":"The Mary Eliza Mahoney House Emergency Family Shelter (MEMH), is a family shelter that accepts boys up to age 18 and male head-of-households. Residents may stay for up to 120 days. This housing program provides food, shelter for 26 families, health care, youth services, substance abuse and mental health services, along with referral services for education, training and housing, through pro-active case management for residents to regain their self-sufficiency.",
            "Twitter URL":"",
            "Facebook URL":"",
            "Instagram URL":"",
            "Address":"55 Dimock Street",
            "City":"Roxbury",
            "State":"MA ",
            "Zip Code":"02119 ",
            "Country":"USA",
            "Full Address":"55 Dimock Street Roxbury MA  02119  USA ",
            "Latitude":42.3197955,
            "Longitude":-71.0976419
        },
        {
            "ID":5,
            "Timestamp":"",
            "Open":false,
            "Organization Name":"Shattuck Shelter",
            "Category":"Emergency Shelter",
            "Tags":"Case Management, Mental Health",
            "Website":"",
            "Phone":"",
            "Overview":"",
            "Twitter URL":"",
            "Facebook URL":"",
            "Instagram URL":"",
            "Address":"",
            "City":"",
            "State":"",
            "Zip Code":"",
            "Country":"",
            "Full Address":"     ",
            "Latitude":0,
            "Longitude":0
        },
        {
            "ID":6,
            "Timestamp":"",
            "Open":true,
            "Organization Name":"Headed Home: Cambridge Shelter",
            "Category":"Emergency Shelter",
            "Tags":"",
            "Website":"http://www.headinghomeinc.org/programs/new-draft-shelter-emergency-services",
            "Phone":"(617) 864-8140",
            "Overview":"An emergency shelter with capacity for 21 individuals that serves more than 85 men and women annually in a sober living environment.",
            "Twitter URL":"@HeadingHomeInc",
            "Facebook URL":"",
            "Instagram URL":"",
            "Address":"479 Concord Avenue",
            "City":"Cambridge",
            "State":"MA",
            "Zip Code":"02138",
            "Country":"USA",
            "Full Address":"479 Concord Avenue Cambridge MA 02138 USA ",
            "Latitude":42.3867842,
            "Longitude":-71.1403258
        },
        {
            "ID":7,
            "Timestamp":"",
            "Open":true,
            "Organization Name":"Caspar Emergency Service Center and Shelter",
            "Category":"Emergency Shelter",
            "Tags":"Case Management, Mental Health",
            "Website":"http://casparinc.org/emergency-services-center-and-shelter.html",
            "Phone":"(617) 661-0600",
            "Overview":"Clients receive medical and mental health care, nutritional food, personal hygiene supplies, clean clothes, counseling, case management, and employment, housing, and treatment referrals in an environment that is welcoming and safe. The ESC provides 24-hour shelter, 365 days a year to residents of Cambridge and Somerville.",
            "Twitter URL":"@CASPARCamSom",
            "Facebook URL":"https://www.facebook.com/CasparIncNonprofit/",
            "Instagram URL":"",
            "Address":"240 Albany Street",
            "City":"Cambridge",
            "State":"MA",
            "Zip Code":"02139",
            "Country":"USA",
            "Full Address":"240 Albany Street Cambridge MA 02139 USA ",
            "Latitude":42.3582809,
            "Longitude":-71.1007991
        },
        {
            "ID":8,
            "Timestamp":"",
            "Open":true,
            "Organization Name":"Harvard Square Homeless Shelter",
            "Category":"Emergency Shelter",
            "Tags":"",
            "Website":"https://hshshelter.org",
            "Phone":"(617) 547-2841",
            "Overview":"The shelter is open from 7PM to 8AM, except on Saturday mornings when it is open until 9AM. They lottery all 14-night beds. Callers may call in between 7:30am and 8:00am to put their name in the lottery at which point the caller will receive a lottery number. The lottery will be run between 8:00am and 8:05am. People may call back between 8:05am and 8:30am as well as between 7pm and 9pm to find out if their lottery number was picked.",
            "Twitter URL":"",
            "Facebook URL":"https://www.facebook.com/pages/Harvard-Square-Homeless-Shelter/214395528642799",
            "Instagram URL":"",
            "Address":"66 Winthrop Street ",
            "City":"Cambridge",
            "State":"MA",
            "Zip Code":"02138",
            "Country":"USA",
            "Full Address":"66 Winthrop Street  Cambridge MA 02138 USA ",
            "Latitude":42.3717532,
            "Longitude":-71.1200405
        },
        {
            "ID":9,
            "Timestamp":"",
            "Open":true,
            "Organization Name":"College Avenue Adult Shelter",
            "Category":"Emergency Shelter",
            "Tags":"",
            "Website":"https://www.somervillehomelesscoalition.org/programs/shelters/",
            "Phone":"(617) 623-2546",
            "Overview":"Serves 4 men and 4 women from the hours of 6PM to 9AM. The length of stay is 6 weeks with extensions available.",
            "Twitter URL":"",
            "Facebook URL":"",
            "Instagram URL":"",
            "Address":"14 Chapel Street",
            "City":"Somerville",
            "State":"MA",
            "Zip Code":"02144",
            "Country":"USA",
            "Full Address":"14 Chapel Street Somerville MA 02144 USA ",
            "Latitude":42.3987852,
            "Longitude":-71.1211314
        }
    ]
    """
}