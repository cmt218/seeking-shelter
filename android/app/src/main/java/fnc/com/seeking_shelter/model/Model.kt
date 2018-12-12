package fnc.com.seeking_shelter.model

import android.util.Log
import com.google.firebase.firestore.FirebaseFirestore
import fnc.com.seeking_shelter.ListingDataFragmentContract
import fnc.com.seeking_shelter.mappage.MapFragment
import fnc.com.seeking_shelter.responses.ListingResponse

class Model (val fragment: ListingDataFragmentContract.CanGetListings){

    val db = FirebaseFirestore.getInstance()

    fun fetchAllPlaces() {
        val listings: MutableList<ListingResponse> = mutableListOf()
        db.collection(COLLECTION_PATH)
                .get()
                .addOnSuccessListener { documents ->
                    for (document in documents) {
                        listings.add(document.toObject(ListingResponse::class.java))
                    }
                    fragment.onListingsLoaded(listings)
                }
                .addOnFailureListener { e ->
                    Log.d(TAG, e.toString())
                }
    }

    companion object {
        val TAG = Model::class.qualifiedName
        const val COLLECTION_PATH = "data"
    }
}