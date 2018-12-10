package fnc.com.seeking_shelter.responses

import com.google.firebase.firestore.PropertyName

data class ListingResponse(
        @PropertyName("ID") val id: Long = 0L,
        @PropertyName("Timestamp") val timestamp: String = "",
        @PropertyName("Open") val isOpen: Boolean = false,
        @PropertyName("organizationname") val organizationName: String = "",
        @PropertyName("Category") val category: String = "",
        @PropertyName("Tags") val tags: String = "",
        @PropertyName("Website") val website: String = "",
        @PropertyName("Phone") val phone: String = "",
        @PropertyName("Overview") val overview: String = "",
        @PropertyName("twitterurl") val twitterUrl: String = "",
        @PropertyName("facebookurl") val facebookUrl: String = "",
        @PropertyName("instagramurl") val instagramUrl: String = "",
        @PropertyName("Address") val address: String = "",
        @PropertyName("City") val city: String = "",
        @PropertyName("State") val state: String = "",
        @PropertyName("zipcode") val zip: String = "",
        @PropertyName("Country") val country: String = "",
        @PropertyName("fulladdress") val fullAddress: String = "",
        @PropertyName("Latitude") val latitude: Double = 0.0,
        @PropertyName("Longitude") val longitude: Double = 0.0
)