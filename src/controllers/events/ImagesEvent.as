/**
 * Created by jackevsen on 04.06.15.
 */
package controllers.events {
import flash.events.Event;

public class ImagesEvent extends Event {
    public static const COMPOUND_IMAGES:String = "ImagesEvent_compoundImages";

    public function ImagesEvent(type:String) {
        super(type);
    }

    override public function clone():Event{
        return new ImagesEvent(type);
    }
}
}
