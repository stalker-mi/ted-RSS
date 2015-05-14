package {
	import fl.containers.ScrollPane;
    import flash.events.MouseEvent;

    public class ScrollPain extends ScrollPane {

        protected override function endDrag(event:MouseEvent):void {

            if (stage) {

                stage.removeEventListener(MouseEvent.MOUSE_MOVE, doDrag);

            }

        }

    }

}