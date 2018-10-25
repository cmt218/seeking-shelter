package fnc.com.seeking_shelter.responses

data class ListingResponse(
        val id: String,
        val timestamp: String,
        val isOpen: Boolean,
        val organizationName: String,
        val category: String,
        val tags: String,
        val website: String,
        val phone: String,
        val overview: String,
        val twitterUrl: String,
        val facebookUrl: String,
        val instagramUrl: String,
        val address: String,
        val city: String,
        val state: String,
        val zip: Int,
        val country: String,
        val fullAddress: String,
        val latitude: String,
        val longitude: String
)