package fnc.com.seeking_shelter

import android.os.Bundle
import android.support.v4.app.FragmentActivity
import fnc.com.seeking_shelter.homepage.HomeFragment

class MainActivity : FragmentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        supportFragmentManager.beginTransaction().add(R.id.fragment_container, HomeFragment()).commit()
    }


}
