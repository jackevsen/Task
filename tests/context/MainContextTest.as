/**
 * Created by jackevsen on 07.06.15.
 */
package context {
import flash.display.Sprite;

import org.flexunit.Assert;


public class MainContextTest {
    private var instance:MainContext;

    [Before]
    public function setUp():void {
        instance = new MainContext(new Sprite());
    }

    [After]
    public function tearDown():void {
        instance = null;
    }

    [Test]
    public  function context_is_mainContext():void{
        Assert.assertTrue("instance is MainContext", instance is MainContext);
    }
}
}
