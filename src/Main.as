package {

import flash.display.Sprite;
import flash.events.Event;

public class Main extends Sprite {

    private var _mainContext:MainContext;

    public function Main() {
        if(stage){
            Init(null);
        }else{
            addEventListener(Event.ADDED_TO_STAGE, Init);
        }
    }

    private function Init(e:Event):void{
        if(hasEventListener(Event.ADDED_TO_STAGE)){
            removeEventListener(Event.ADDED_TO_STAGE, Init);
        }

        _mainContext  = new MainContext(this);
    }
}
}
