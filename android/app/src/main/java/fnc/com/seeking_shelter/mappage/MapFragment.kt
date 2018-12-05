package fnc.com.seeking_shelter.mappage

import android.os.Bundle
import android.support.v4.app.Fragment
import android.location.Location;
import android.support.v7.app.AlertDialog
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.MapView
import com.google.android.gms.maps.OnMapReadyCallback
import fnc.com.seeking_shelter.R
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.model.MarkerOptions
import com.google.android.gms.maps.model.LatLng
import android.content.DialogInterface
import com.google.android.gms.tasks.OnCompleteListener
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
import fnc.com.seeking_shelter.listingdetailspage.DetailsFragment
import fnc.com.seeking_shelter.responses.ListingResponse


class MapFragment : Fragment(), OnMapReadyCallback, GoogleMap.OnMarkerClickListener {


    val TAG = MapFragment::class.java.name
    private lateinit var mMap: GoogleMap
    private lateinit var mCameraPosition: CameraPosition

    // The entry points to the Places API.
    private lateinit var mGeoDataClient: GeoDataClient
    private lateinit var mPlaceDetectionClient: PlaceDetectionClient

    // The entry point to the Fused Location Provider.
    private lateinit var mFusedLocationProviderClient: FusedLocationProviderClient

    // A default location (Sydney, Australia) and default zoom to use when location permission is
    // not granted.
    private val mDefaultLocation = LatLng(42.3601, 71.0589)
    private val DEFAULT_ZOOM: Float = 15f
    private val PERMISSIONS_REQUEST_ACCESS_FINE_LOCATION = 1
    private var mLocationPermissionGranted = false

    // The geographical location where the device is currently located. That is, the last-known
    // location retrieved by the Fused Location Provider.
    private var mLastKnownLocation: Location? = null

    // Keys for storing activity state.
    private val KEY_CAMERA_POSITION = "camera_position"
    private val KEY_LOCATION = "location"

    // Used for selecting the current place.
    private val M_MAX_ENTRIES = 5
    private lateinit var mLikelyPlaceNames: Array<String?>
    private lateinit var mLikelyPlaceAddresses: Array<String?>
    private lateinit var mLikelyPlaceAttributions: Array<String?>
    private lateinit var mLikelyPlaceLatLngs: Array<LatLng?>

    private val mapModel = MapModel()

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {

        super.onCreateView(inflater, container, savedInstanceState);

        // Retrieve location and camera position from saved instance state.
        if (savedInstanceState != null) {
            mLastKnownLocation = savedInstanceState.getParcelable(KEY_LOCATION)
            mCameraPosition = savedInstanceState.getParcelable(KEY_CAMERA_POSITION)
        }

        // Retrieve the content view that renders the map.
        val root = inflater.inflate(R.layout.map_fragment, container, false)

        // Construct a GeoDataClient.
        mGeoDataClient = Places.getGeoDataClient(activity, null)

        // Construct a PlaceDetectionClient.
        mPlaceDetectionClient = Places.getPlaceDetectionClient(activity, null)

        // Construct a FusedLocationProviderClient.
        mFusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(activity)

        val mapView: MapView = root.findViewById(R.id.map_view)
        mapView.onCreate(savedInstanceState)
        mapView.getMapAsync(this)
        mapView.onResume()

        return root
    }

    /**
     * Saves the state of the map when the activity is paused.
     */
    override fun onSaveInstanceState(outState: Bundle?) {
        if (mMap != null) {
            outState!!.putParcelable(KEY_CAMERA_POSITION, mMap.getCameraPosition())
            outState.putParcelable(KEY_LOCATION, mLastKnownLocation)
            super.onSaveInstanceState(outState)
        }
    }

    /**
     * Sets up the options menu.
     * @param menu The options menu.
     * @return Boolean.
     */

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.current_place_menu, menu);
        super.onCreateOptionsMenu(menu, inflater)
    }

    /**
     * Handles a click on the menu option to get a place.
     * @param item The menu item to handle.
     * @return Boolean.
     */
    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        if (item.getItemId() == R.id.option_get_place) {
            showCurrentPlace()
        }
        return true
    }

    override fun onMapReady(map: GoogleMap?) {
        mMap = map!!

        mMap.setOnMarkerClickListener(this)
        val markers = mapModel.fetchPlaces(context)
        for (marker in markers) {
            val cur = mMap.addMarker(MarkerOptions().position(LatLng(marker.latitude.toDouble(), marker.longitude.toDouble())))
            cur.setTag(marker)
        }

        // Use a custom info window adapter to handle multiple lines of text in the
        // info window contents.
//        mMap.setInfoWindowAdapter(object : GoogleMap.InfoWindowAdapter {
//
//            override// Return null here, so that getInfoContents() is called next.
//            fun getInfoWindow(arg0: Marker): View? {
//                return null
//            }
//
//            override fun getInfoContents(marker: Marker): View {
//                // Inflate the layouts for the info window, title and snippet.
//                val infoWindow = layoutInflater.inflate(R.layout.custom_info_contents,
//                        map as FrameLayout, false)
//
//                val title = infoWindow.findViewById(R.id.title) as TextView
//                title.text = marker.title
//
//                val snippet = infoWindow.findViewById(R.id.snippet) as TextView
//                snippet.text = marker.snippet
//
//                return infoWindow
//            }
//        })

        // Prompt the user for permission.
        getLocationPermission()

        // Turn on the My Location layer and the related control on the map.
        updateLocationUI()

        // Get the current location of the device and set the position of the map.
        getDeviceLocation()
    }


    /**
     * Gets the current location of the device, and positions the map's camera.
     */
    private fun getDeviceLocation() {
        /*
         * Get the best and most recent location of the device, which may be null in rare
         * cases when a location is not available.
         */
        try {
            if (mLocationPermissionGranted) {
                val locationResult = mFusedLocationProviderClient.getLastLocation()
                locationResult.addOnCompleteListener(activity, OnCompleteListener<Location> { task ->
                    if (task.isSuccessful) {
                        // Set the map's camera position to the current location of the device.
                        mLastKnownLocation = task.result as Location
                        mLastKnownLocation?.let { mMap.moveCamera(CameraUpdateFactory.newLatLngZoom(
                                LatLng(it.getLatitude(),
                                        it.getLongitude()), DEFAULT_ZOOM)) }

                    } else {
                        Log.d(TAG, "Current location is null. Using defaults.")
                        Log.e(TAG, "Exception: %s", task.exception)
                        mMap.moveCamera(CameraUpdateFactory
                                .newLatLngZoom(mDefaultLocation, DEFAULT_ZOOM))
                        mMap.getUiSettings().setMyLocationButtonEnabled(false)
                    }
                })
            }
        } catch (e: SecurityException) {
            Log.e("Exception: %s", e.message)
        }

    }

    /**
     * Prompts the user for permission to use the device location.
     */
    private fun getLocationPermission() {
        /*
         * Request location permission, so that we can get the location of the
         * device. The result of the permission request is handled by a callback,
         * onRequestPermissionsResult.
         */
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


    /**
     * Handles the result of the request for location permissions.
     */
    override fun onRequestPermissionsResult(requestCode: Int,
                                            permissions: Array<String>,
                                            grantResults: IntArray) {
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

    /**
     * Prompts the user to select the current place from a list of likely places, and shows the
     * current place on the map - provided the user has granted location permission.
     */
    private fun showCurrentPlace() {
        if (mMap == null) {
            return
        }

        if (mLocationPermissionGranted) {
            // Get the likely places - that is, the businesses and other points of interest that
            // are the best match for the device's current location.
            val placeResult = mPlaceDetectionClient.getCurrentPlace(null)
            placeResult.addOnCompleteListener(OnCompleteListener<PlaceLikelihoodBufferResponse> { task ->
                if (task.isSuccessful && task.result != null) {
                    val likelyPlaces = task.result

                    // Set the count, handling cases where less than 5 entries are returned.
                    val count: Int
                    if (likelyPlaces!!.count < M_MAX_ENTRIES) {
                        count = likelyPlaces.count
                    } else {
                        count = M_MAX_ENTRIES
                    }

                    var i = 0
                    mLikelyPlaceNames = arrayOfNulls<String>(count)
                    mLikelyPlaceNames = arrayOfNulls<String>(count)
                    mLikelyPlaceAddresses = arrayOfNulls<String>(count)
                    mLikelyPlaceAttributions = arrayOfNulls<String>(count)
                    mLikelyPlaceLatLngs = arrayOfNulls<LatLng>(count)

                    for (placeLikelihood in likelyPlaces) {
                        // Build a list of likely places to show the user.
                        mLikelyPlaceNames[i] = placeLikelihood.place.name as String
                        mLikelyPlaceAddresses[i] = placeLikelihood.place
                                .address as String?
                        mLikelyPlaceAttributions[i] = placeLikelihood.place
                                .attributions as String?
                        mLikelyPlaceLatLngs[i] = placeLikelihood.place.latLng

                        i++
                        if (i > count - 1) {
                            break
                        }
                    }

                    // Release the place likelihood buffer, to avoid memory leaks.
                    likelyPlaces.release()

                    // Show a dialog offering the user the list of likely places, and add a
                    // marker at the selected place.
                    openPlacesDialog()

                } else {
                    Log.e(TAG, "Exception: %s", task.exception)
                }
            })
        } else {
            // The user has not granted permission.
            Log.i(TAG, "The user did not grant location permission.")

            // Add a default marker, because the user hasn't selected a place.
            mMap.addMarker(MarkerOptions()
                    .title("title")
                    .position(mDefaultLocation)
                    .snippet("info snippet"))

            // Prompt the user for permission.
            getLocationPermission()
        }
    }

    /**
     * Displays a form allowing the user to select a place from a list of likely places.
     */
    private fun openPlacesDialog() {
        // Ask the user to choose the place where they are now.
        val listener = DialogInterface.OnClickListener { dialog, which ->
            // The "which" argument contains the position of the selected item.
            val markerLatLng = mLikelyPlaceLatLngs[which]
            var markerSnippet = mLikelyPlaceAddresses[which]
            if (mLikelyPlaceAttributions[which] != null) {
                markerSnippet = markerSnippet + "\n" + mLikelyPlaceAttributions[which]
            }

            // Add a marker for the selected place, with an info window
            // showing information about that place.
            mMap.addMarker(MarkerOptions()
                    .title(mLikelyPlaceNames[which])
                    .position(markerLatLng!!)
                    .snippet(markerSnippet))

            // Position the map's camera at the location of the marker.
            mMap.moveCamera(CameraUpdateFactory.newLatLngZoom(markerLatLng,
                    DEFAULT_ZOOM))
        }

        // Display the dialog.
        val dialog = AlertDialog.Builder(context)
                .setTitle("pick place")
                .setItems(mLikelyPlaceNames, listener)
                .show()
    }

    /**
     * Updates the map's UI settings based on whether the user has granted location permission.
     */
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

    override fun onMarkerClick(marker: Marker?): Boolean {
        changeFragment(DetailsFragment.newInstance(marker?.tag as ListingResponse))
        return true
    }

    fun changeFragment(fragment: Fragment) {
        fragmentManager.beginTransaction()
                    .replace(R.id.fragment_container, fragment)
                    .addToBackStack(null)
                    .commit()

    }

    companion object {
        @JvmStatic
        fun newInstance(): MapFragment {
            return MapFragment()
        }
    }
}