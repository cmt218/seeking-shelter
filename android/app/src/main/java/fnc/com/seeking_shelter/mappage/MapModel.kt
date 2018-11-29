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

    fun fetchPlaces(context: Context): List<LatLng> {
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

        val markers: MutableList<LatLng> = mutableListOf()
        listings?.let {
            for (listing in it) {
                markers.add(LatLng(listing.latitude.toDouble(), listing.longitude.toDouble()))
            }
        }
        return markers
    }

    companion object {
        val TAG = MapModel::class.qualifiedName
    }
}