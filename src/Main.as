package {

import flash.display.Sprite;
import flash.events.Event;

import org.osflash.signals.natives.NativeSignal;

[SWF(width='800',height='600',backgroundColor='#ffffff',frameRate='25')]
public class Main extends Sprite {

    private var _mainContext:MainContext;
    private var _addedToStageSignal:NativeSignal;

    public function Main() {
        if(stage){
            Init(null);
        }else{
            _addedToStageSignal = new NativeSignal(this, Event.ADDED_TO_STAGE);
            _addedToStageSignal.addOnce(Init);
        }
    }

    private function Init(e:Event):void{
        _mainContext  = new MainContext(this);
    }

}
}
