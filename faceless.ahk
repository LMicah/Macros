XButton2:: 
{
    Send("=")
    Sleep 20
    Click()
    Sleep 60

    Send("1")
    Sleep 20
    Click()
    Sleep 60
    
    Send("4")
    Sleep 20
    Click()
    Sleep 470

    Loop 3
    {
        Send("3")
        Sleep 20
        Click()
        Sleep 60
    }

   
    Send("5")
    Sleep 20
    Click()
}