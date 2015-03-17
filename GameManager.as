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
		public static var Score:Number = 0;
		public static var mainTimeline:MovieClip;
		public static var inited:Boolean = false;
		
		public static var currentQuizIndex:int = 0;
		public static var currentLetterIndex:int = 0;
		public static var quizAIndexes:Array = new Array(0, 1, 2, 3, 4, 5, 6);
		public static var letterAIndexes:Array = new Array(0, 1, 2, 3, 4, 5, 6);
		
		public static var games:Array = new Array(1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2);
		
		
		public function GameManager(stage:Stage) 
		{
			_stage = stage;
			quizAIndexes = Support.shuffleArray(quizAIndexes);
			letterAIndexes = Support.shuffleArray(letterAIndexes);
			executeGame(games[_currentGame]);
			
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
			Support.delayedFunctionCall(1800, function(e:Event) { executeGame(games[_currentGame]); } );				
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