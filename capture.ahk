#Requires AutoHotkey v2

^!s:: {
    MsgBox("Clique e arraste para selecionar a área da tela.")
    
    KeyWait("LButton", "D")
    
    x1 := 0, y1 := 0
    MouseGetPos(&x1, &y1)
    
    KeyWait("LButton", "U")
    
    x2 := 0, y2 := 0
    MouseGetPos(&x2, &y2)
    
    x := Min(x1, x2)
    y := Min(y1, y2)
    w := Abs(x2 - x1)
    h := Abs(y2 - y1)
    
    coordText := Format("x := {1}`ny := {2}`nw := {3}`nh := {4}", x, y, w, h)
    MsgBox("Área selecionada:`n" coordText)
    Clipboard := coordText
    
    ToolTip("Coordenadas copiadas para o clipboard!", x, y, 1)
    Sleep(2000)
    ToolTip("")
}
return