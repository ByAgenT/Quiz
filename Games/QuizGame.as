package Games 
{
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Anton Kovalyov
	 */
	
	public class QuizGame extends MovieClip
	{
		//Answer coordinates
		private var coordsx:Array = new Array(560, 560, 560, 560);
		private var coordsy:Array = new Array(140, 250, 360, 470);
		
		private var _stage:Stage;
		
		//variables
		var Question:String = new String();
		var AnswerID:int;
		
		//Graphical obj
		var myFormat:TextFormat = new TextFormat();
		var myAFormat:TextFormat = new TextFormat();
		var que:TextField = new TextField();
		var answer:TextField = new TextField();
		var wrongAnswer1:TextField = new TextField();
		var wrongAnswer2:TextField = new TextField();
		var wrongAnswer3:TextField = new TextField();
		
		public function QuizGame(stage:Stage) 
		{
			_stage = stage;
			que.wordWrap = true;
			getQuestion();
			drawGame();
		}
		
		
		private function shuffleArray(arr:Array)
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
		
		public function getQuestion():void
		{
			var myXML:XML;
			var myLoader:URLLoader = new URLLoader();
			myLoader.load(new URLRequest("questions.dat"));
			myLoader.addEventListener(Event.COMPLETE, processXML);
			function processXML(e:Event)
			{
				myXML = new XML(e.target.data);		
				var qid:int = GameManager.quizAIndexes[GameManager.currentQuizIndex];
				GameManager.currentQuizIndex++;
				switch(GameManager.gameID)
				{
					case 1:
						que.text = myXML.easy.quizQuestions.question[qid].questionText.*;
						answer.text = myXML.easy.quizQuestions.question[qid].answer.*;
						wrongAnswer1.text = myXML.easy.quizQuestions.question[qid].wrong1.*;
						wrongAnswer2.text = myXML.easy.quizQuestions.question[qid].wrong2.*;
						wrongAnswer3.text = myXML.easy.quizQuestions.question[qid].wrong3.*;
						break;
					case 2:
						que.text = myXML.medium.quizQuestions.question[qid].questionText.*;
						answer.text = myXML.medium.quizQuestions.question[qid].answer.*;
						wrongAnswer1.text = myXML.medium.quizQuestions.question[qid].wrong1.*;
						wrongAnswer2.text = myXML.medium.quizQuestions.question[qid].wrong2.*;
						wrongAnswer3.text = myXML.medium.quizQuestions.question[qid].wrong3.*;
						break;
					case 3:
						que.text = myXML.hard.quizQuestions.question[qid].questionText.*;
						answer.text = myXML.hard.quizQuestions.question[qid].answer.*;
						wrongAnswer1.text = myXML.hard.quizQuestions.question[qid].wrong1.*;
						wrongAnswer2.text = myXML.hard.quizQuestions.question[qid].wrong2.*;
						wrongAnswer3.text = myXML.hard.quizQuestions.question[qid].wrong3.*;
						break;
				}	
			}		
		}
		
		public function drawGame():void
		{
			//Text formatting
			myFormat.size = 35;
			myFormat.align = TextFormatAlign.CENTER;
			myFormat.font = "Majestic";
			
			//Answer text formatting
			myAFormat.size = 35;
			myAFormat.bold = true;
			myAFormat.align = TextFormatAlign.LEFT;
			myAFormat.font = "Majestic";
			
			que.x = 180;
			que.y = 180;
			que.selectable = false;
			que.width = 300;
			que.height = 300;
			que.defaultTextFormat = myFormat;
			
			var ids:Array = new Array(0, 1, 2, 3);
			ids = shuffleArray(ids);
			
			wrongAnswer1.wordWrap = true;
			wrongAnswer1.width = 290;
			wrongAnswer1.height = 120;
			wrongAnswer1.x = coordsx[ids[0]];
			wrongAnswer1.y = coordsy[ids[0]];
			wrongAnswer1.selectable = false;
			wrongAnswer1.defaultTextFormat = myAFormat;
			
			wrongAnswer2.wordWrap = true;
			wrongAnswer2.width = 290;
			wrongAnswer2.height = 120;
			wrongAnswer2.x = coordsx[ids[1]];
			wrongAnswer2.y = coordsy[ids[1]];
			wrongAnswer2.selectable = false;
			wrongAnswer2.defaultTextFormat = myAFormat;
			
			wrongAnswer3.wordWrap = true;
			wrongAnswer3.width = 290;
			wrongAnswer3.height = 120;
			wrongAnswer3.x = coordsx[ids[2]];
			wrongAnswer3.y = coordsy[ids[2]];
			wrongAnswer3.selectable = false;
			wrongAnswer3.defaultTextFormat = myAFormat;
			
			answer.wordWrap = true;
			answer.width = 290;
			answer.height = 120;
			answer.x = coordsx[ids[3]];
			answer.y = coordsy[ids[3]];
			answer.selectable = false;
			answer.defaultTextFormat = myAFormat;
			
			answer.addEventListener(MouseEvent.MOUSE_OVER, highlight);
			answer.addEventListener(MouseEvent.MOUSE_OUT, dehighlight);
			wrongAnswer1.addEventListener(MouseEvent.MOUSE_OVER, highlight);
			wrongAnswer1.addEventListener(MouseEvent.MOUSE_OUT, dehighlight);
			wrongAnswer2.addEventListener(MouseEvent.MOUSE_OVER, highlight);
			wrongAnswer2.addEventListener(MouseEvent.MOUSE_OUT, dehighlight);
			wrongAnswer3.addEventListener(MouseEvent.MOUSE_OVER, highlight);
			wrongAnswer3.addEventListener(MouseEvent.MOUSE_OUT, dehighlight);
			
			answer.addEventListener(MouseEvent.CLICK, commitAnswer);
			wrongAnswer1.addEventListener(MouseEvent.CLICK, commitWrong);
			wrongAnswer2.addEventListener(MouseEvent.CLICK, commitWrong);
			wrongAnswer3.addEventListener(MouseEvent.CLICK, commitWrong);
			
			_stage.addChild(que);
			_stage.addChild(answer);
			_stage.addChild(wrongAnswer1);
			_stage.addChild(wrongAnswer2);
			_stage.addChild(wrongAnswer3);
		}
		
		private function highlight(e:Event)
		{
			myAFormat.underline = true;
			e.currentTarget.defaultTextFormat = myAFormat;
			e.currentTarget.text = e.currentTarget.text;
		}
		
		private function dehighlight(e:Event)
		{
			myAFormat.underline = false;
			e.currentTarget.defaultTextFormat = myAFormat;
			e.currentTarget.text = e.currentTarget.text;
		}
		
		private function screenClean()
		{
			_stage.removeChild(que);
			_stage.removeChild(answer);
			_stage.removeChild(wrongAnswer1);
			_stage.removeChild(wrongAnswer2);
			_stage.removeChild(wrongAnswer3);
		}
		
		private function commitAnswer(e:MouseEvent)
		{
			trace("Right Answer");
			screenClean();
			GameManager.changeGame();
			GameManager.Score++;
		}
		
		private function commitWrong(e:MouseEvent)
		{	
			trace("Wrong Answer");
			screenClean();
			GameManager.changeGame();
		}
		
	}

}