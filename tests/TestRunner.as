/**
 * Created by jackevsen on 07.06.15.
 */
package {
import context.MainContextTest;

import controllers.services.DataLoadingServiceTest;

import flash.display.Sprite;

import models.ImagesDataModelTest;

import org.flexunit.internals.TraceListener;
import org.flexunit.runner.FlexUnitCore;

import view.holder.ImageHolderTest;

public class TestRunner extends Sprite {
    private var _core:FlexUnitCore;

    public function TestRunner() {
        super();

        _core = new FlexUnitCore();
        _core.addListener( new TraceListener() );
        _core.run(MainContextTest);
        _core.run(ImageHolderTest);
        _core.run(ImagesDataModelTest);
        _core.run(DataLoadingServiceTest);
    }
}
}
