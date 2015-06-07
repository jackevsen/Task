/**
 * Created by jackevsen on 04.06.15.
 */
package controllers.events {
import flash.events.Event;

public class ImagesEvent extends Event {
    public static const COMPOUND_IMAGES:String = "ImagesEvent_compoundImages";
    public static const MOVE_IMAGE:String = "ImagesEvent_moveImage";
    public static const DELETE_IMAGE:String = "ImagesEvent_deleteImage";

    public function ImagesEvent(type:String) {
        super(type);
    }

    override public function clone():Event{
        return new ImagesEvent(type);
    }
}
}
