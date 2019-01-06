package fnc.com.seeking_shelter.mappage

import android.os.Bundle
import android.support.v4.app.Fragment
import android.location.Location;
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.MapView
import com.google.android.gms.maps.OnMapReadyCallback
import fnc.com.seeking_shelter.R
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.model.MarkerOptions
import com.google.android.gms.maps.model.LatLng
import android.content.pm.PackageManager
import android.support.v4.app.ActivityCompat
import android.support.v4.content.ContextCompat
import android.util.Log
import android.view.*
import com.google.android.gms.maps.model.CameraPosition
import com.google.android.gms.maps.model.Marker
import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.places.*
import fnc.com.seeking_shelter.extensions.changeFragment
import fnc.com.seeking_shelter.model.ListingDataFragmentContract
import fnc.com.seeking_shelter.listingdetailspage.DetailsFragment
import fnc.com.seeking_shelter.model.Model
import fnc.com.seeking_shelter.responses.ListingResponse


class MapFragment : Fragment(), OnMapReadyCallback, GoogleMap.OnMarkerClickListener, ListingDataFragmentContract.CanGetListings {
    private lateinit var mMap: GoogleMap
    private lateinit var mCameraPosition: CameraPosition
    private var mLastKnownLocation: Location? = null

    private lateinit var mGeoDataClient: GeoDataClient
    private lateinit var mPlaceDetectionClient: PlaceDetectionClient
    private lateinit var mFusedLocationProviderClient: FusedLocationProviderClient

    private val mapModel = Model(this)

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        savedInstanceState?.run {
            mLastKnownLocation = getParcelable(KEY_LOCATION)
            mCameraPosition = getParcelable(KEY_CAMERA_POSITION)
        }

        val root = inflater.inflate(R.layout.map_fragment, container, false)

        mGeoDataClient = Places.getGeoDataClient(activity, null)
        mPlaceDetectionClient = Places.getPlaceDetectionClient(activity, null)
        mFusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(activity)

        val mapView: MapView = root.findViewById(R.id.map_view)
        mapView.onCreate(savedInstanceState)
        mapView.getMapAsync(this)
        mapView.onResume()

        super.onCreateView(inflater, container, savedInstanceState)

        return root
    }

    override fun onSaveInstanceState(outState: Bundle?) {
        outState?.run {
            putParcelable(KEY_CAMERA_POSITION, mMap.getCameraPosition())
            putParcelable(KEY_LOCATION, mLastKnownLocation)
        }
        super.onSaveInstanceState(outState)
    }

    override fun onListingsLoaded(listings: List<ListingResponse>) {
        for (listing in listings) {
            mMap.addMarker(MarkerOptions().position(LatLng(listing.latitude, listing.longitude))).run { setTag(listing) }
        }
    }

    override fun onMapReady(map: GoogleMap) {
        mMap = map.also { it.setOnMarkerClickListener(this) }
        mapModel.fetchAllPlaces()

        getLocationPermission()
        updateLocationUI()
        getDeviceLocation()
    }

    private fun getDeviceLocation() {
        try {
            if (mLocationPermissionGranted) {
                val locationResult = mFusedLocationProviderClient.getLastLocation()
                locationResult.addOnCompleteListener { task ->
                    if (task.isSuccessful) {
                        mLastKnownLocation = task.result as Location
                        mLastKnownLocation?.let {
                            mMap.moveCamera(CameraUpdateFactory.newLatLngZoom(
                                    LatLng(it.latitude, it.longitude), DEFAULT_ZOOM))
                        }
                    } else {
                        Log.d(TAG, "Current location is null. Using defaults.")
                        Log.e(TAG, "Exception: %s", task.exception)
                        mMap.moveCamera(CameraUpdateFactory
                                .newLatLngZoom(mDefaultLocation, DEFAULT_ZOOM))
                        mMap.getUiSettings().setMyLocationButtonEnabled(false)
                    }
                }
            }
        } catch (e: SecurityException) {
            Log.e("Exception: %s", e.message)
        }
    }

    private fun getLocationPermission() {
        if (ContextCompat.checkSelfPermission(context,
                        android.Manifest.permission.ACCESS_FINE_LOCATION)
                == PackageManager.PERMISSION_GRANTED) {
            mLocationPermissionGranted = true;
        } else {

            ActivityCompat.requestPermissions(activity,
                    arrayOf(android.Manifest.permission.ACCESS_FINE_LOCATION),
                    PERMISSIONS_REQUEST_ACCESS_FINE_LOCATION);
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        mLocationPermissionGranted = false
        when (requestCode) {
            PERMISSIONS_REQUEST_ACCESS_FINE_LOCATION -> {
                // If request is cancelled, the result arrays are empty.
                if (grantResults.size > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    mLocationPermissionGranted = true
                }
            }
        }
        updateLocationUI()
    }

    private fun updateLocationUI() {
        try {
            if (mLocationPermissionGranted) {
                mMap.setMyLocationEnabled(true)
                mMap.getUiSettings().setMyLocationButtonEnabled(true)
            } else {
                mMap.setMyLocationEnabled(false)
                mMap.getUiSettings().setMyLocationButtonEnabled(false)
                getLocationPermission()
            }
        } catch (e: SecurityException) {
            Log.e("Exception: %s", e.message)
        }
    }

    override fun onMarkerClick(marker: Marker): Boolean {
        this.changeFragment(DetailsFragment.newInstance(marker.tag as ListingResponse))
        return true
    }

    companion object {
        private val TAG = MapFragment::class.java.name
        private const val DEFAULT_ZOOM: Float = 15f
        private const val PERMISSIONS_REQUEST_ACCESS_FINE_LOCATION = 1
        private const val KEY_CAMERA_POSITION = "camera_position"
        private const val KEY_LOCATION = "location"
        private val mDefaultLocation = LatLng(42.3601, 71.0589)
        private var mLocationPermissionGranted = false

        @JvmStatic
        fun newInstance(): MapFragment {
            return MapFragment()
        }
    }
}