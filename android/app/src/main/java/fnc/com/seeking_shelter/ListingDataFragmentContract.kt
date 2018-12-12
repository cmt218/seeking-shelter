package fnc.com.seeking_shelter

import fnc.com.seeking_shelter.responses.ListingResponse

interface ListingDataFragmentContract {
    interface CanGetListings {
        fun onListingsLoaded(listings: List<ListingResponse>)
    }
}