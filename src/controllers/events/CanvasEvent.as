/**
 * Created by jackevsen on 04.06.15.
 */
package controllers.events {
import flash.events.Event;

import view.holder.ImageHolder;

public class CanvasEvent extends Event {
    public static const ADD_TO_CANVAS:String = "CanvasEvent_addToCanvas";
    public static const REMOVE_FROM_CANVAS:String = "CanvasEvent_RemoveFromCanvas";

    private var _image:ImageHolder;

    public function CanvasEvent(type:String, image:ImageHolder = null) {
        super(type);

        _image = image;
    }

    public function get image():ImageHolder {
        return _image;
    }

    public function set image(value:ImageHolder):void {
        _image = value;
    }

    override public function clone():Event{
        return new CanvasEvent(type, image);
    }
}
}
