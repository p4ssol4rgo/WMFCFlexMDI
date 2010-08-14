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
			
			var titulo:String = "Erro ";
			var mensagem:String = "";
			var detalhes:String = "";
			
			if (event.error is Error)
			{
				var error:Error = event.error as Error;
				titulo += error.errorID;
				mensagem = "" + error.name;
				detalhes = "" + error.message;
				
				trace(error.errorID, error.name, error.message);
			}
			else if(event.error is ErrorEvent)
			{
				var errorEvent:ErrorEvent = event.error as ErrorEvent;
				
				titulo += errorEvent.errorID;
				mensagem = errorEvent.text;
				detalhes = errorEvent.type;
				
				trace(errorEvent.errorID);
			}else{
				mensagem = "Erro desconhecido!";
				detalhes = event.text + "" + event.toString();
			}
			
			MessageBox.showError(mensagem + "\n" + detalhes, titulo);
		}
	}
}