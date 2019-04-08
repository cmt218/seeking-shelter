package fnc.com.seeking_shelter.mappage

import android.app.Activity
import android.os.Bundle
import android.support.v4.app.Fragment
import android.location.Location
import fnc.com.seeking_shelter.R
import com.google.android.gms.maps.model.MarkerOptions
import com.google.android.gms.maps.model.LatLng
import android.content.pm.PackageManager
import android.support.v4.content.ContextCompat
import android.view.*
import android.widget.TextView
import com.google.android.gms.location.*
import com.google.android.gms.maps.model.CameraPosition
import com.google.android.gms.maps.model.Marker
import com.google.android.gms.maps.*
import fnc.com.seeking_shelter.extensions.changeFragment
import fnc.com.seeking_shelter.model.ListingDataFragmentContract
import fnc.com.seeking_shelter.listingdetailspage.DetailsFragment
import fnc.com.seeking_shelter.model.Model
import fnc.com.seeking_shelter.responses.ListingResponse


class MapFragment : Fragment(),
        OnMapReadyCallback,
        ListingDataFragmentContract.CanGetListings,
        GoogleMap.OnInfoWindowClickListener,
        GoogleMap.InfoWindowAdapter {

    private lateinit var map: GoogleMap
    private var cameraPosition: CameraPosition? = null
    private var lastKnownLocation: Location? = null

    private lateinit var fusedLocationProviderClient: FusedLocationProviderClient

    private val locationRequest = LocationRequest.create()
            .setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY)
            .setInterval(1000L)

    private val locationCallback = object : LocationCallback() {
        override fun onLocationResult(locationResult: LocationResult?) {
            fusedLocationProviderClient.removeLocationUpdates(this)
            if (locationResult != null) {
                map.moveCamera(CameraUpdateFactory
                        .newLatLngZoom(LatLng(locationResult.lastLocation.latitude,
                                locationResult.lastLocation.longitude), DEFAULT_ZOOM))
            } else {
                map.moveCamera(CameraUpdateFactory
                        .newLatLngZoom(defaultLocation, DEFAULT_ZOOM))
            }
            super.onLocationResult(locationResult)
        }
    }

    private val mapModel = Model(this)

    override fun onCreateView(inflater: LayoutInflater,
                              container: ViewGroup?, savedInstanceState: Bundle?): View? {
        savedInstanceState?.let {
            lastKnownLocation = it.getParcelable(KEY_LOCATION)
            cameraPosition = it.getParcelable(KEY_CAMERA_POSITION)
        }

        val root = inflater.inflate(R.layout.map_fragment, container, false)

        fusedLocationProviderClient = LocationServices
                .getFusedLocationProviderClient(activity as Activity)

        val mapView: MapView = root.findViewById(R.id.map_view)
        mapView.onCreate(savedInstanceState)
        mapView.getMapAsync(this)
        mapView.onResume()

        super.onCreateView(inflater, container, savedInstanceState)

        return root
    }

    override fun onSaveInstanceState(outState: Bundle) {
        outState.let {
            it.putParcelable(KEY_CAMERA_POSITION, map.cameraPosition)
            it.putParcelable(KEY_LOCATION, lastKnownLocation)
        }
        super.onSaveInstanceState(outState)
    }

    override fun onListingsLoaded(listings: List<ListingResponse>) {
        val sanitizedListings = listings
                .filter { it.latitude.isNotEmpty() }.filter { it.longitude.isNotEmpty() }
        for (listing in sanitizedListings) {
            val marker = map.addMarker(MarkerOptions()
                    .position(LatLng(listing.latitude.toDouble(), listing.longitude.toDouble())))
            marker.tag = listing
        }
    }

    override fun onMapReady(map: GoogleMap) {
        this.map = map
        with(map) {
            setOnInfoWindowClickListener(this@MapFragment)
            setInfoWindowAdapter(this@MapFragment)
        }

        mapModel.fetchAllPlaces()
        getLocationPermission()
    }

    private fun getLocationPermission() {
        if (ContextCompat.checkSelfPermission(context!!,
                        android.Manifest.permission.ACCESS_FINE_LOCATION)
                == PackageManager.PERMISSION_GRANTED) {
            locationPermissionGranted = true
            updateLocationUI()
        } else {
            requestPermissions(arrayOf(android.Manifest.permission.ACCESS_FINE_LOCATION),
                    PERMISSIONS_REQUEST_ACCESS_FINE_LOCATION)
        }
    }

    private fun updateLocationUI() {
        try {
            if (locationPermissionGranted) {
                map.isMyLocationEnabled = true
                map.uiSettings.isMyLocationButtonEnabled = true
            } else {
                map.isMyLocationEnabled = false
                map.uiSettings.isMyLocationButtonEnabled = false
                getLocationPermission()
            }
            getDeviceLocation()
        } catch (e: SecurityException) {
        }
    }

    private fun getDeviceLocation() {
        try {
            if (locationPermissionGranted) {
                fusedLocationProviderClient
                        .requestLocationUpdates(locationRequest, locationCallback, null)
            } else {
                map.moveCamera(CameraUpdateFactory
                        .newLatLngZoom(defaultLocation, DEFAULT_ZOOM))
            }
        } catch (e: SecurityException) {
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        locationPermissionGranted = false
        when (requestCode) {
            PERMISSIONS_REQUEST_ACCESS_FINE_LOCATION -> {
                if (grantResults.size > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    locationPermissionGranted = true
                    updateLocationUI()
                }
            }
        }
    }

    override fun onInfoWindowClick(marker: Marker?) {
        this.changeFragment(DetailsFragment.newInstance(marker?.tag as ListingResponse))
    }

    override fun getInfoContents(marker: Marker?): View {
        val view = layoutInflater.inflate(R.layout.info_window, null)
        val listing = marker?.tag as ListingResponse
        val organizationName = view.findViewById<TextView>(R.id.organization_name)
        val organizationCategory = view.findViewById<TextView>(R.id.category)
        organizationName.text = listing.organizationName
        organizationCategory.text = listing.category
        return view
    }

    override fun getInfoWindow(marker: Marker?): View? = null

    companion object {
        private const val DEFAULT_ZOOM: Float = 15f
        private const val PERMISSIONS_REQUEST_ACCESS_FINE_LOCATION = 1
        private const val KEY_CAMERA_POSITION = "camera_position"
        private const val KEY_LOCATION = "location"
        private val defaultLocation = LatLng(42.3601, -71.0589)
        private var locationPermissionGranted = false

        @JvmStatic
        fun newInstance(): MapFragment {
            return MapFragment()
        }
    }
}