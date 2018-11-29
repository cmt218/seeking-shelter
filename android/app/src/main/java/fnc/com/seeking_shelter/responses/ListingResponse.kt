package fnc.com.seeking_shelter.responses

import com.squareup.moshi.Json

data class ListingResponse(
        @Json(name="ID") val id: String,
        @Json(name="Timestamp") val timestamp: String,
        @Json(name="Open") val isOpen: Boolean,
        @Json(name="Organization Name") val organizationName: String,
        @Json(name="Category") val category: String,
        @Json(name="Tags") val tags: String,
        @Json(name="Website") val website: String,
        @Json(name="Phone") val phone: String,
        @Json(name="Overview") val overview: String,
        @Json(name="Twitter URL") val twitterUrl: String,
        @Json(name="Facebook URL") val facebookUrl: String,
        @Json(name="Instagram URL") val instagramUrl: String,
        @Json(name="Address") val address: String,
        @Json(name="City") val city: String,
        @Json(name="State") val state: String,
        @Json(name="Zip Code") val zip: String,
        @Json(name="Country") val country: String,
        @Json(name="Full Address") val fullAddress: String,
        @Json(name="Latitude") val latitude: String,
        @Json(name="Longitude") val longitude: String
)