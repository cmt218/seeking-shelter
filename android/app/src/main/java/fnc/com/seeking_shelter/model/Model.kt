package fnc.com.seeking_shelter.model

import com.google.firebase.firestore.FirebaseFirestore
import fnc.com.seeking_shelter.responses.ListingResponse

class Model(val fragment: ListingDataFragmentContract.CanGetListings) {

    private val db = FirebaseFirestore.getInstance()
    private val listings: MutableList<ListingResponse> = mutableListOf()

    fun fetchAllPlaces() {
        if (listings.size == 0) {
            db.collection(COLLECTION_PATH)
                    .addSnapshotListener { documents, e ->
                        if (e == null) {
                            documents?.let {
                                for (document in it) {
                                    listings.add(document.toObject(ListingResponse::class.java))
                                }
                                val sanitizedListings = listings.filter { it.overview.isNotEmpty() }.toMutableList()
                                for (listing in sanitizedListings) {
                                    when (listing.category.toLowerCase()) {
                                        "veterans" -> listing.category = "Veterans' Aid"
                                        "substance abuse" -> listing.category = "Substance Abuse Resources"
                                        "domestic violence" -> listing.category = "Domestic Violence Resources"
                                        "medical" -> listing.category = "Medical Resources"
                                        "food banks" -> listing.category = "Food Bank"
                                        "women shelter" -> listing.category = "Women's Shelter"
                                        "mens shelter" -> listing.category = "Men's Shelter"
                                        else -> listing.category = "Other Resources"
                                    }
                                }
                                fragment.onListingsLoaded(sanitizedListings)
                            }
                        }
                    }
        } else {
            fragment.onListingsLoaded(listings)
        }
    }

    companion object {
        val TAG = Model::class.qualifiedName
        const val COLLECTION_PATH = "locations"
    }
}