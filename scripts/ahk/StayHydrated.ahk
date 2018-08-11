Loop {
	SoundPlay, %Home%\StayHydrated.mp3
		If (A_Min<30)
		Input:=A_Hour . "30"
		Else
		{
Now:=A_YYYY . A_MM . A_DD . A_Hour . "0000"
	    Now+=1, Hour
	    FormatTime, Input, %Now%, HHmm
		}
	SleepTill(Input)
}

SleepTill(Time) {
ST_Hour:=SubStr(Time, 1 ,2)
		ST_Min:=SubStr(Time, 3 ,2)
		ST_Sec:=(SubStr(Time, 5 ,2)<>"" ? SubStr(Time, 5 ,2) : "00")
		STime:=(((ST_Hour-A_Hour)*60+(ST_Min-A_Min))*60+(ST_Sec-A_Sec))*1000
		STime:=STime<0 ? STime+86400000 : STime
		Sleep %STime%
		Return % A_Hour ":" A_Min
}
