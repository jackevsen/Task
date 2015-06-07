/**
 * Created by jackevsen on 05.06.15.
 */
package controllers.services {

import controllers.loaders.ILoader;
import controllers.loaders.ImageLoader;

public class ImageLoadingService extends LoadingService{

    public function ImageLoadingService() {
        super();
    }

    override protected function GetLoaderFactory():ILoader{
        return new ImageLoader();
    }
}
}
