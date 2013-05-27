package etolib.components.supportClasses
{

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.game.gameant;
import org.game.ui.controls.supportClasses.TrackBase;
import org.game.ui.events.TrackEvent;

use namespace gameant;
/**
 *
 * @author zhangyu 2012-10-24
 *
 **/
public class SliderBase extends TrackBase
{
	//--------------------------------------------------------------------------
	//		Constructor
	//--------------------------------------------------------------------------
	public function SliderBase()
	{
		super();
	}
	//--------------------------------------------------------------------------
	//		Variables
	//--------------------------------------------------------------------------
	protected var highLightSkin:DisplayObject;
	//--------------------------------------------------------------------------
	//		Propertise
	//--------------------------------------------------------------------------
	private var _showHighLightSkin:Boolean = true;

	public function get showHighLightSkin():Boolean
	{
		return _showHighLightSkin;
	}

	public function set showHighLightSkin(value:Boolean):void
	{
		_showHighLightSkin = value;
		
		if(highLightSkin)
			highLightSkin.visible = value;
	}

	//--------------------------------------------------------------------------
	//		Method
	//--------------------------------------------------------------------------
	override protected function createChildren():void
	{
		super.createChildren();
		
		if(!highLightSkin)
		{
			highLightSkin = deferredSetStyles.getSkinInstance("highLightSkin");
			if(highLightSkin)
			{
				if(highLightSkin is InteractiveObject)
				{
					InteractiveObject(highLightSkin).mouseEnabled = false;
					
					if(highLightSkin is DisplayObjectContainer)
						DisplayObjectContainer(highLightSkin).mouseChildren = false;
				}
				
				highLightSkin.visible = _showHighLightSkin;
				addChildAt(highLightSkin, getChildIndex(thumb));
			}
		}
	}
	//--------------------------------------------------------------------------
	//		Event Handler
	//--------------------------------------------------------------------------
	override protected function trackMouseDownHandler(event:MouseEvent):void
	{
		var pt:Point = this.globalToLocal(new Point(event.stageX, event.stageY));
		var newValue:Number = pointToValue(pt.x, pt.y);
		newValue = validateValue(newValue);
		
		var oldValue:Number = this.value;
		this.value = newValue;
		
		dispatchEvent(new TrackEvent(TrackEvent.CHANGE, oldValue, newValue));
	}
	//--------------------------------------------------------------------------
	//		Private
	//--------------------------------------------------------------------------
}
}