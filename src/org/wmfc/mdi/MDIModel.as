package org.wmfc.mdi
{
	import flash.events.ErrorEvent;
	import flash.events.UncaughtErrorEvent;
	
	import mx.events.FlexEvent;
	
	import org.wmfc.componentes.alert.MessageBox;
	
	import spark.components.Application;
	
	public class MDIModel extends Application
	{
		public static var mdi:MDIModel;
		
		public function MDIModel()
		{
			super();
			this.addEventListener(FlexEvent.APPLICATION_COMPLETE, on_AplicationComplete);
			
			mdi = this;
		}
		
		protected function on_AplicationComplete(event:FlexEvent):void {
			
			this.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, globalErrorHandler);
		}
		
		protected function globalErrorHandler(event:UncaughtErrorEvent):void {
			
			var title:String = "Error";
			var mensage:String = "";
			var detail:String = "";
			
			if (event.error is Error)
			{
				var error:Error = event.error as Error;
				title += error.errorID;
				mensage = "" + error.name;
				detail = "" + error.message;
				
				trace(error.errorID, error.name, error.message);
			}
			else if(event.error is ErrorEvent)
			{
				var errorEvent:ErrorEvent = event.error as ErrorEvent;
				
				title += errorEvent.errorID;
				mensage = errorEvent.text;
				detail = errorEvent.type;
				
				trace(errorEvent.errorID);
			}else{
				mensage = "Unknown Error!";
				detail = event.text + "" + event.toString();
			}
			
			MessageBox.showError(mensage + "\n" + detail, title);
		}
	}
}