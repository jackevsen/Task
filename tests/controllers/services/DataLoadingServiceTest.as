/**
 * Created by jackevsen on 07.06.15.
 */
package controllers.services {
import org.flexunit.Assert;

public class DataLoadingServiceTest {
    private var _service:DataLoadingService;

    [Before]
    public function setUp():void {
        _service = new DataLoadingService();
    }

    [After]
    public function tearDown():void {
        _service = null;
    }

    [Test]
    public function testLoad():void {
        _service.processSignal.addOnce(onDataLoaded);
        _service.Load(MainConstants.DATA_URL);
    }

    private function onDataLoaded(data:String):void{
        Assert.assertNotNull("loaded data not null", data);
    }
}
}
