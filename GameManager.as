package 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Games.LetterGame;
	import Games.QuizGame;
	/**
	 * ...
	 * @author Anton Kovalyov
	 */
	
	public class GameManager 
	{
		const GAMES = 2;
		
		private static var _stage:Stage;
		public static var gameID:int = 1;
		public static var _currentGame:int = 0;
		public static var Score:int = 0;
		public static var mainTimeline:MovieClip;
		public static var inited:Boolean = false;
		
		public static var games:Array = new Array();
		
		public function GameManager(stage:Stage) 
		{
			_stage = stage;
			games = createGameList(20);
			executeGame(games[_currentGame]);
			
		}
		
		/*Create a list from 1 to GAMES const*/
		private function createGameList(size:int):Array
		{
			var gamelist:Array = new Array();
			for (var i:int = 0; i < size; i++)
			{
				gamelist[i] = Math.round(Math.random() * (GAMES - 1)) + 1;
			}
			return gamelist;
		}
		
		
		public static function wrapup()
		{
			mainTimeline.gotoAndPlay(1, "Endgame");
		}
		
		public static function changeGame()
		{
			_currentGame++;
			if (_currentGame >= games.length)
			{
				wrapup();
			}	
			mainTimeline.gotoAndPlay(1);
			delayedFunctionCall(1800, function(e:Event) { executeGame(games[_currentGame]); } );				
		}
		
		
		public static function delayedFunctionCall(delay:int, func:Function)
		{
			var timer:Timer = new Timer(delay, 1);
			timer.addEventListener(TimerEvent.TIMER, func);
			timer.start();
		}
		
		public static function executeGame(game:int)
		{
			switch(game)
			{
				case 1:
					var qGame:QuizGame = new QuizGame(_stage);
					break;
				case 2:
					var lGame:LetterGame = new LetterGame(_stage);
					break;
			}
		}
		
	}

}