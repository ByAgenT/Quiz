package 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Anton Kovalyov
	 */
	public class Support 
	{
		
		public function Support() 
		{
			
		}
		
		public static function delayedFunctionCall(delay:int, func:Function)
		{
			var timer:Timer = new Timer(delay, 1);
			timer.addEventListener(TimerEvent.TIMER, func);
			timer.start();
		}
		
		//Array shuffle alghorithm
		public static function shuffleArray(arr:Array)
		{
			var shuffledArray:Array = new Array(arr.length);
			var randomPos:int = 0;
			for (var i:int = 0; i < arr.length; i++)
			{
				randomPos = int(Math.random() * arr.length);
				while (shuffledArray[randomPos] != null)
				{
					randomPos = int(Math.random() * arr.length);
				}
				shuffledArray[randomPos] = arr[i];
			}
			
			return shuffledArray;
		}
		
	}

}