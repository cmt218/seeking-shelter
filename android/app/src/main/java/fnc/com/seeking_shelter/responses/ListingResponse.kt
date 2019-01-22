package fnc.com.seeking_shelter.responses

import com.google.firebase.firestore.PropertyName

data class ListingResponse(
        @PropertyName("Category") var category: String = "",
        @PropertyName("organizationname") val organizationName: String = "",
        @PropertyName("Website") val website: String = "",
        @PropertyName("Phone") val phone: String = "",
        @PropertyName("Overview") val overview: String = "",
        @PropertyName("Address") val address: String = "",
        @PropertyName("City") val city: String = "",
        @PropertyName("fulladdress") val fullAddress: String = "",
        @PropertyName("Latitude") val latitude: String = "",
        @PropertyName("Longitude") val longitude: String = ""
)