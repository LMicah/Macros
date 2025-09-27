#Requires AutoHotkey v2
#Include OCR.ahk

StrContains(haystack, needle) {
    return InStr(StrLower(haystack), StrLower(needle))
}


CleanText(text) {
    text := Trim(text) 
    text := RegExReplace(text, "\s+", "") ; 
    return text
}


CoordMode("Pixel")
CoordMode("Mouse", "Screen")

Down:: {
    ExitApp()
}

Up:: {
    origemRect_x := 855
    origemRect_y := 300
    origemRect_w := 100
    origemRect_h := 50

    campoRect_x := 565
    campoRect_y := 400
    campoRect_w := 100
    campoRect_h := 40

    boxRect_x := 1200
    boxRect_y := 408
    boxRect_w := 80
    boxRect_h := 30

    seta_x := 542
    seta_y := 236
    seta_w := 50
    seta_h := 50

    corBranca := 0xFFFFFF
    opcoesDeBusca := 5

    loop {
        encontradoX := 0
        encontradoY := 0
        encontrado := PixelSearch(&encontradoX, &encontradoY, seta_x, seta_y, seta_x + seta_w, seta_y + seta_h, corBranca, opcoesDeBusca)

        if (!encontrado) {
            ExitApp()
        }

        origemResult := OCR.FromRect(origemRect_x, origemRect_y, origemRect_w, origemRect_h, { lang: "pt-BR", scale: 2, grayscale: 1 })
        campoResult := OCR.FromRect(campoRect_x, campoRect_y, campoRect_w, campoRect_h, { lang: "pt-BR", scale: 1, grayscale: 1 })
        boxResult := OCR.FromRect(boxRect_x, boxRect_y, boxRect_w, boxRect_h, { lang: "pt-BR", scale: 2, grayscale: 1 })

        origemText := CleanText(origemResult.Text)
        campoText := CleanText(campoResult.Text)
        boxText := CleanText(boxResult.Text)

        tooltip("origem: " . origemText . "`ncampo: " . campoText . "`nbox: " . boxText)

        if (StrContains(origemText, "IInterna") && (campoText = "52002" || campoText = "")) {
            SequenciaDeAcoes("52001", "57")
        }
        else if (StrContains(origemText, "CCampo") && (campoText = "52001" || campoText = "")) {
            SequenciaDeAcoes("52002", "527")
        }
        else {
            MouseMove(A_ScreenWidth * 0.29, A_ScreenHeight * 0.24)
            Sleep(10)
            Click()
        }

        Sleep(100)
    }
    return
}

SequenciaDeAcoes(valor1, valor2) {
    first_click_x := A_ScreenWidth * 0.32
    first_click_y := A_ScreenHeight * 0.39

    top_x := A_ScreenWidth * 0.39
    top_y := A_ScreenHeight * 0.24

    middle_x := A_ScreenWidth * 0.48
    middle_y := A_ScreenHeight * 0.52

    pass_x := A_ScreenWidth * 0.29
    pass_y := A_ScreenHeight * 0.24

    MouseMove(first_click_x, first_click_y)
    Sleep(50)
    Click(2)
    Sleep(200)

    Send(valor1)
    Sleep(100)

    Send(valor2)
    Sleep(100)

    MouseMove(top_x, top_y)
    Sleep(50)
    Click()
    Sleep(400)

    MouseMove(middle_x, middle_y)
    Sleep(750)
    Click()
    Sleep(50)

    MouseMove(pass_x, pass_y)
    Sleep(750)
    Click()
}

return