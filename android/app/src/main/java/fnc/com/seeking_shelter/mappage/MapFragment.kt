package fnc.com.seeking_shelter.mappage

import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.api.GoogleApiClient.OnConnectionFailedListener;
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.MapView
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import fnc.com.seeking_shelter.R
import kotlinx.android.synthetic.main.map_fragment.*

class MapFragment :  Fragment(), OnMapReadyCallback, OnConnectionFailedListener {

    private lateinit var mapView: MapView

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val root = inflater.inflate(R.layout.map_fragment, container, false)

        mapView = root.findViewById(R.id.map_view)
        mapView.onCreate(savedInstanceState)
        mapView.getMapAsync(this)
        return root
    }

    override fun onConnectionFailed(connectionResult: ConnectionResult) {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun onMapReady(map: GoogleMap?) {
        val boston = LatLng(42.347234, -71.062753)
        map?.addMarker(MarkerOptions().position(boston).title("home"))
        map?.moveCamera(CameraUpdateFactory.newLatLng(boston))
        map_view.onResume()
    }

    companion object {
        @JvmStatic
        fun newInstance(): MapFragment {
            return MapFragment()
        }
    }
}