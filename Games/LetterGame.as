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
	
	/**
	 * ...
	 * @author Anton Kovalyov
	 */
	public class LetterGame 
	{
		
		//Answer coordinates
		private var coordsx:Array = new Array(550, 550, 550, 550);
		private var coordsy:Array = new Array(140, 250, 360, 470);
		
		
		private var _stage:Stage;
		
		
		//Graphical elements
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
		
		//Array shuffle alghorithm
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
		
		//Get question from XML
		public function GetQuestion()
		{
			var myXML:XML;
			var myLoader:URLLoader = new URLLoader();
			myLoader.load(new URLRequest("questions.xml"));
			myLoader.addEventListener(Event.COMPLETE, processXML);
			function processXML(e:Event)
			{
				var id:int = Math.round(Math.random() * (3 - 1));
				myXML = new XML(e.target.data);	
				switch(GameManager.gameID)
				{
					case 1:
						que.text = myXML.easy.letterQuestions.question[id].word;
						answer.text = myXML.easy.letterQuestions.question[id].answer;
						wrongAnswer1.text = myXML.easy.letterQuestions.question[id].wrong1;
						wrongAnswer2.text = myXML.easy.letterQuestions.question[id].wrong2;
						wrongAnswer3.text = myXML.easy.letterQuestions.question[id].wrong3;
						break;
				}
				
				
			}
		}
		
		//Draw game on the Scene
		public function DrawGame()
		{
			//Text formatting
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 55;
			myFormat.align = TextFormatAlign.CENTER;
			myFormat.font = "Majestic"; //FONT
			
			//Text formatting for answer
			var myAFormat:TextFormat = new TextFormat();
			myAFormat.size = 35;
			myAFormat.bold = true;
			myAFormat.align = TextFormatAlign.LEFT;
			myAFormat.font = "Majestic";
			
			//static question props
			que.wordWrap = true;		
			que.x = 180;
			que.y = 190;
			que.selectable = false;
			que.width = 300;
			que.height = 300;
			que.defaultTextFormat = myFormat;
			
			//word props
			_word.defaultTextFormat = myFormat;
			_word.selectable = false;
			_word.x = 512;
			_word.y = 130;
			_word.width = 300;
			_word.height = 100;
			
			//position id's
			var ids:Array = new Array(0, 1, 2, 3);
			ids = shuffleArray(ids);
			
			//wrongAnswer1 props
			wrongAnswer1.wordWrap = true;
			wrongAnswer1.width = 300;
			wrongAnswer1.height = 120;
			wrongAnswer1.x = coordsx[ids[0]];
			wrongAnswer1.y = coordsy[ids[0]];
			wrongAnswer1.selectable = false;
			wrongAnswer1.defaultTextFormat = myAFormat;
			
			//wrongAnswer2 props
			wrongAnswer2.wordWrap = true;
			wrongAnswer2.width = 300;
			wrongAnswer2.height = 120;
			wrongAnswer2.x = coordsx[ids[1]];
			wrongAnswer2.y = coordsy[ids[1]];
			wrongAnswer2.selectable = false;
			wrongAnswer2.defaultTextFormat = myAFormat;
			
			//wrongAnswer3 props
			wrongAnswer3.wordWrap = true;
			wrongAnswer3.width = 300;
			wrongAnswer3.height = 120;
			wrongAnswer3.x = coordsx[ids[2]];
			wrongAnswer3.y = coordsy[ids[2]];
			wrongAnswer3.selectable = false;
			wrongAnswer3.defaultTextFormat = myAFormat;
			
			//answer props
			answer.wordWrap = true;
			answer.width = 300;
			answer.height = 120;
			answer.x = coordsx[ids[3]];
			answer.y = coordsy[ids[3]];
			answer.selectable = false;
			answer.defaultTextFormat = myAFormat;
			
			answer.addEventListener(MouseEvent.MOUSE_OVER, ahighlight);
			function ahighlight(e:Event)
			{
				myAFormat.underline = true;
				answer.defaultTextFormat = myAFormat;
				answer.text = answer.text;
				
			}
			answer.addEventListener(MouseEvent.MOUSE_OUT, adehighlight);
			function adehighlight(e:Event)
			{
				myAFormat.underline = false;
				answer.defaultTextFormat = myAFormat;
				answer.text = answer.text;
			}
			wrongAnswer1.addEventListener(MouseEvent.MOUSE_OVER, highlight1);
			function highlight1(e:Event)
			{
				myAFormat.underline = true;
				wrongAnswer1.defaultTextFormat = myAFormat;
				wrongAnswer1.text = wrongAnswer1.text;
				
			}
			wrongAnswer1.addEventListener(MouseEvent.MOUSE_OUT, dehighlight1);
			function dehighlight1(e:Event)
			{
				myAFormat.underline = false;
				wrongAnswer1.defaultTextFormat = myAFormat;
				wrongAnswer1.text = wrongAnswer1.text;
			}
			wrongAnswer2.addEventListener(MouseEvent.MOUSE_OVER, highlight2);
			function highlight2(e:Event)
			{
				myAFormat.underline = true;
				wrongAnswer2.defaultTextFormat = myAFormat;
				wrongAnswer2.text = wrongAnswer2.text;
				
			}
			wrongAnswer2.addEventListener(MouseEvent.MOUSE_OUT, dehighlight2);
			function dehighlight2(e:Event)
			{
				myAFormat.underline = false;
				wrongAnswer2.defaultTextFormat = myAFormat;
				wrongAnswer2.text = wrongAnswer2.text;
			}
			wrongAnswer3.addEventListener(MouseEvent.MOUSE_OVER, highlight3);
			function highlight3(e:Event)
			{
				myAFormat.underline = true;
				wrongAnswer3.defaultTextFormat = myAFormat;
				wrongAnswer3.text = wrongAnswer3.text;
				
			}
			wrongAnswer3.addEventListener(MouseEvent.MOUSE_OUT, dehighlight3);
			function dehighlight3(e:Event)
			{
				myAFormat.underline = false;
				wrongAnswer3.defaultTextFormat = myAFormat;
				wrongAnswer3.text = wrongAnswer3.text;
			}
			
			//Event Listeners
			answer.addEventListener(MouseEvent.CLICK, commitAnswer);
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
		
		//Right Answer
		private function commitAnswer(e:MouseEvent)
		{
			screenClean();
			GameManager.changeGame();
			GameManager.Score++;
		}
		
		//Wrong Answer
		private function commitWrong(e:MouseEvent)
		{
			screenClean();
			GameManager.changeGame();
		}
		
	}

}