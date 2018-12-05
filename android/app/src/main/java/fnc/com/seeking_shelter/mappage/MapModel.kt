package fnc.com.seeking_shelter.mappage

import android.content.Context
import android.util.Log
import com.google.android.gms.maps.model.LatLng
import com.squareup.moshi.JsonAdapter
import com.squareup.moshi.Moshi
import com.squareup.moshi.Types
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import fnc.com.seeking_shelter.responses.ListingResponse
import java.io.InputStream

class MapModel {

    val moshi = Moshi.Builder()
            .add(KotlinJsonAdapterFactory())
            .build()

    fun fetchPlaces(context: Context): List<ListingResponse> {
        var inputString = ""
        try {
            val inputStream: InputStream = context.assets.open("compressed_locations.json")
            inputString = inputStream.bufferedReader().use { it.readText() }
            Log.d(TAG, inputString)
        } catch (e: Exception) {
            Log.d(TAG, e.toString())
        }

        val listType = Types.newParameterizedType(List::class.java, ListingResponse::class.java)
        val listingAdapter: JsonAdapter<List<ListingResponse>> = moshi.adapter(listType)
        val listings = listingAdapter.fromJson(inputString)
        listings?.let {
            return it
        }
        return mutableListOf()
    }

    companion object {
        val TAG = MapModel::class.qualifiedName
    }
}