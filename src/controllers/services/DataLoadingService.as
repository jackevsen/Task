/**
 * Created by jackevsen on 03.06.15.
 */
package controllers.services {

import controllers.loaders.DataLoader;
import controllers.loaders.ILoader;


public class DataLoadingService extends LoadingService {

    public function DataLoadingService() {
        super();
    }

    override protected function GetLoaderFactory():ILoader{
        return new DataLoader();
    }
}
}
