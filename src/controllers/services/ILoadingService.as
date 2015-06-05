/**
 * Created by jackevsen on 05.06.15.
 */
package controllers.services {

import org.osflash.signals.Signal;

public interface ILoadingService{
    function Load(url:String):void;
    function get processSignal():Signal;
}
}
