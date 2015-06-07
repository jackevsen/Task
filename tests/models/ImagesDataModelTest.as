/**
 * Created by jackevsen on 07.06.15.
 */
package models {
import models.vios.ImageDataVO;

import org.flexunit.Assert;

public class ImagesDataModelTest {
    private var _instance:ImagesDataModel;

    [Before]
    public function setUp():void {
        _instance = new ImagesDataModel();
    }

    [After]
    public function tearDown():void {
        _instance = null;
    }

    [Test(order=1)]
    public function testParseData():void {
        var xml:XML = <images>
                        <image url="images/1.jpg" width="142" height="89"/>
                      </images>;

        _instance.ParseData(xml);
        Assert.assertTrue("data parsed successful", _instance.imagesData.length == 1);

        var imageData:ImageDataVO = _instance.imagesData[0];
        Assert.assertTrue("instance contains data", _instance.ContainsImageData(imageData));
    }

    [Test(order=2)]
    public function testImagesData():void {
        Assert.assertNotNull("images data not null", _instance.imagesData);
    }
}
}
