# SpeechMe!

An app for those who want to check their pronounciation of English words...

##Backend folder
The backend folder houses a main function, which is not really used in the actual applicaiton, but can be used to check the backend functionality.
The main function calls Get_Score housed in transcribe.py, which returns a score for the user's pronounciation based on a recording and a target word.
The app.py is a flask file that runs Get_Score and returns it's value to the caller... which in this case is the swift front end.
