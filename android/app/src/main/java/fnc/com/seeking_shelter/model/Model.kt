package fnc.com.seeking_shelter.model

import android.util.Log
import com.google.firebase.firestore.FirebaseFirestore
import fnc.com.seeking_shelter.responses.ListingResponse

class Model(val fragment: ListingDataFragmentContract.CanGetListings) {

    private val db = FirebaseFirestore.getInstance()
    private val listings: MutableList<ListingResponse> = mutableListOf()

    fun fetchAllPlaces() {
        if(listings.size == 0){
            db.collection(COLLECTION_PATH)
                    .addSnapshotListener { documents, e ->
                        if (e == null) {
                            documents?.let {
                                for (document in it) {
                                    listings.add(document.toObject(ListingResponse::class.java))
                                }
                                fragment.onListingsLoaded(listings)
                            }
                        } else {
                            Log.e(TAG, "error")
                        }
                    }
        }
        else {
            fragment.onListingsLoaded(listings)
        }
    }

    companion object {
        val TAG = Model::class.qualifiedName
        const val COLLECTION_PATH = "data"
    }
}