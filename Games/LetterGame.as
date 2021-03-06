package Games 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Anton Kovalyov
	 */
	public class LetterGame 
	{
		
		//Answer coordinates
		private var coordsx:Array = new Array(550, 550, 550, 550);
		private var coordsy:Array = new Array(135, 255, 365, 475);
		
		private var _stage:Stage;
		
		//Graphical elements
		var myFormat:TextFormat = new TextFormat();
		var myAFormat:TextFormat = new TextFormat();
		private var _word:TextField = new TextField();
		private var que:TextField = new TextField();
		private var _answers:Array = new Array();
		private var answer:TextField = new TextField();
		private var wrongAnswer1:TextField = new TextField();
		private var wrongAnswer2:TextField = new TextField();
		private var wrongAnswer3:TextField = new TextField();
		
		//Constructor
		public function LetterGame(stage:Stage) 
		{
			_stage = stage;
			_word.wordWrap = true;
			GetQuestion();
			DrawGame();
		}
		
		//Get question from XML
		public function GetQuestion()
		{
			var myXML:XML;
			var myLoader:URLLoader = new URLLoader();
			myLoader.load(new URLRequest("questions.dat"));
			myLoader.addEventListener(Event.COMPLETE, processXML);
			function processXML(e:Event)
			{
				var id:int = GameManager.letterAIndexes[GameManager.currentLetterIndex];
				GameManager.currentLetterIndex++;
				myXML = new XML(e.target.data);	
				switch(GameManager.gameID)
				{
					case 1:
						que.text          = myXML.easy.letterQuestions.question[id].word;
						answer.text       = myXML.easy.letterQuestions.question[id].answer;
						wrongAnswer1.text = myXML.easy.letterQuestions.question[id].wrong1;
						wrongAnswer2.text = myXML.easy.letterQuestions.question[id].wrong2;
						wrongAnswer3.text = myXML.easy.letterQuestions.question[id].wrong3;
						break;
					case 2:
						que.text          = myXML.medium.letterQuestions.question[id].word;
						answer.text       = myXML.medium.letterQuestions.question[id].answer;
						wrongAnswer1.text = myXML.medium.letterQuestions.question[id].wrong1;
						wrongAnswer2.text = myXML.medium.letterQuestions.question[id].wrong2;
						wrongAnswer3.text = myXML.medium.letterQuestions.question[id].wrong3;
						break;
					case 3:
						que.text          = myXML.hard.letterQuestions.question[id].word;
						answer.text       = myXML.hard.letterQuestions.question[id].answer;
						wrongAnswer1.text = myXML.hard.letterQuestions.question[id].wrong1;
						wrongAnswer2.text = myXML.hard.letterQuestions.question[id].wrong2;
						wrongAnswer3.text = myXML.hard.letterQuestions.question[id].wrong3;
						break;
				}
				
				
			}
		}
		
		//Draw game on the Scene
		public function DrawGame()
		{
			//Text formatting
			myFormat.size           = 35;
			myFormat.align          = TextFormatAlign.CENTER;
			myFormat.bold           = false;
			myFormat.font           = "Majestic X"; //FONT
			
			//Text formatting for answer
			myAFormat.size          = 32;
			myAFormat.bold          = false;
			myAFormat.align         = TextFormatAlign.LEFT;
			myAFormat.font          = "Majestic X";
			
			//static question props
			que.wordWrap            = true;		
			que.x                   = 180;
			que.y                   = 180;
			que.selectable          = false;
			que.width               = 300;
			que.height              = 300;
			que.defaultTextFormat   = myFormat;
			
			//position id's
			var ids:Array = new Array(0, 1, 2, 3);
			ids = Support.shuffleArray(ids);
			
			//wrongAnswer1 props
			wrongAnswer1.wordWrap          = true;
			wrongAnswer1.width             =    300;
			wrongAnswer1.height            =   120;
			wrongAnswer1.x                 = coordsx[ids[0]];
			wrongAnswer1.y                 = coordsy[ids[0]];
			wrongAnswer1.selectable        = false;
			wrongAnswer1.defaultTextFormat = myAFormat;
			
			//wrongAnswer2 props
			wrongAnswer2.wordWrap          = true;
			wrongAnswer2.width             = 300;
			wrongAnswer2.height            = 120;
			wrongAnswer2.x                 = coordsx[ids[1]];
			wrongAnswer2.y                 = coordsy[ids[1]];
			wrongAnswer2.selectable        = false;
			wrongAnswer2.defaultTextFormat = myAFormat;
			
			//wrongAnswer3 props
			wrongAnswer3.wordWrap          = true;
			wrongAnswer3.width             = 300;
			wrongAnswer3.height            = 120;
			wrongAnswer3.x                 = coordsx[ids[2]];
			wrongAnswer3.y                 = coordsy[ids[2]];
			wrongAnswer3.selectable        = false;
			wrongAnswer3.defaultTextFormat = myAFormat;
			
			//answer props
			answer.wordWrap                = true;
			answer.width                   = 300;
			answer.height                  = 120;
			answer.x                       = coordsx[ids[3]];
			answer.y                       = coordsy[ids[3]];
			answer.selectable              = false;
			answer.defaultTextFormat       = myAFormat;
			
			answer.addEventListener      (MouseEvent.MOUSE_OVER, highlight);
			answer.addEventListener      (MouseEvent.MOUSE_OUT, dehighlight);
			wrongAnswer1.addEventListener(MouseEvent.MOUSE_OVER, highlight);
			wrongAnswer1.addEventListener(MouseEvent.MOUSE_OUT, dehighlight);
			wrongAnswer2.addEventListener(MouseEvent.MOUSE_OVER, highlight);
			wrongAnswer2.addEventListener(MouseEvent.MOUSE_OUT, dehighlight);
			wrongAnswer3.addEventListener(MouseEvent.MOUSE_OVER, highlight);
			wrongAnswer3.addEventListener(MouseEvent.MOUSE_OUT, dehighlight);
			
			//Event Listeners
			answer.addEventListener      (MouseEvent.CLICK, commitAnswer);
			wrongAnswer1.addEventListener(MouseEvent.CLICK, commitWrong);
			wrongAnswer2.addEventListener(MouseEvent.CLICK, commitWrong);
			wrongAnswer3.addEventListener(MouseEvent.CLICK, commitWrong);
			
			//adding items to stage (draw)
			_stage.addChild(que);
			_stage.addChild(_word);
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
		
		//Right Answer
		private function commitAnswer(e:MouseEvent)
		{
			que.textColor = 0x005000;
			myFormat.bold = true;
			myFormat.size = 50;
			que.defaultTextFormat = myFormat;
			que.text = "Правильно";
			answer.textColor = 0x005000;
			removeListeners();
			GameManager.Score += 0.7;
			Support.delayedFunctionCall(2000, function(e:Event) { endUp(); } );
		}
		
		//Wrong Answer
		private function commitWrong(e:MouseEvent)
		{
			que.textColor = 0x700000;
			myFormat.bold = true;
			myFormat.size = 50;
			que.defaultTextFormat = myFormat;
			que.text = "Неправильно";
			e.currentTarget.textColor = 0x700000;
			answer.textColor = 0x005000;
			removeListeners();
			Support.delayedFunctionCall(2000, function(e:Event) { endUp(); } );
		}
		
		//---------------------------CLEANERS-------------------------------------------------------------
		//Remove children from Stage
		private function screenClean()
		{
			_stage.removeChild(que);
			_stage.removeChild(_word);
			_stage.removeChild(answer);
			_stage.removeChild(wrongAnswer1);
			_stage.removeChild(wrongAnswer2);
			_stage.removeChild(wrongAnswer3);
		}
		
		private function removeListeners()
		{
			answer.removeEventListener      (MouseEvent.CLICK, commitAnswer);
			wrongAnswer1.removeEventListener(MouseEvent.CLICK, commitWrong);
			wrongAnswer2.removeEventListener(MouseEvent.CLICK, commitWrong);
			wrongAnswer3.removeEventListener(MouseEvent.CLICK, commitWrong);
		}
	
		private function endUp()
		{
			screenClean();
			GameManager.changeGame();
		}
		//-----------------------------------------------------------------------------------------	
	}
}