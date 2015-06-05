/**
 * Created by jackevsen on 03.06.15.
 */
package controllers.events {
import flash.events.Event;

public class StartupEvent extends Event {
    public  static const STARTUP:String = "startupEvent_startup";

    public function StartupEvent(type:String) {
        super(type);
    }

    override public function clone():Event{
        return new StartupEvent(type);
    }
}
}
