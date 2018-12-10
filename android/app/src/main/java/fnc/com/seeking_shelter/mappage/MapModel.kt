package fnc.com.seeking_shelter.mappage

import android.util.Log
import com.google.firebase.firestore.FirebaseFirestore
import fnc.com.seeking_shelter.responses.ListingResponse

class MapModel (val fragment: MapFragment){

    val db = FirebaseFirestore.getInstance()

    fun fetchAllPlaces() {
        val listings: MutableList<ListingResponse> = mutableListOf()
        db.collection(COLLECTION_PATH)
                .get()
                .addOnSuccessListener { documents ->
                    Log.d("", documents.toString())
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
        val TAG = MapModel::class.qualifiedName
        const val COLLECTION_PATH = "data"
    }
}