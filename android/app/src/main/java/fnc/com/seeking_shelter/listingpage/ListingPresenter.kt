package fnc.com.seeking_shelter.listingpage

class ListingPresenter constructor(private val listingFragment: ListingFragment) {
    private lateinit var listingModel: ListingModel

    init {
        listingModel = ListingModel(this)
    }

    fun doThing() {
        listingModel.doThing()
    }
}