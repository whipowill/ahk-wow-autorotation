; =================================================
; AutoRotation for World of Warcraft
; by whipowill
; =================================================

#SingleInstance Force
#InstallKeybdHook
#InstallMouseHook

is_active := 0

; reset any icons
splashimage 1:, B W0 H0 X0 Y0
splashimage 2:, B W0 H0 X0 Y0
splashimage 3:, B W0 H0 X0 Y0
splashimage 4:, B W0 H0 X0 Y0
splashimage 5:, B W0 H0 X0 Y0

; show script is running
splashimage 1:, B W5 H5 X0 Y0 CWRed

; fishing stuff
is_fishing_active := 0

runtime := 15

colorFind := "0xFFEAF6" ; 0x450C0B, 0xFAE6E6, 0xFFEAF6
colorVariation := 5
delta := 15

; Get the screen's width and height
SysGet, MonitorWidth, 78
SysGet, MonitorHeight, 79

; Calculate the coordinates for the inner 70% of the screen
InnerWidth := MonitorWidth * 0.6
InnerHeight := MonitorHeight * 0.6
InnerX := (MonitorWidth - InnerWidth) // 2
InnerY := (MonitorHeight - InnerHeight) // 2

; Set the min and max values to be the inner 70% pixel range of the screen
xMin := InnerX
xMax := InnerX + InnerWidth
yMin := InnerY
yMax := InnerY + InnerHeight

; everything else is button bindings so return
return

PgUp::
    is_active := !is_active

    if (is_active)
    {
        SetTimer, AutoRotation, 500
        splashimage 2:, B W5 H5 X5 Y0 CWGreen

        SetTimer, MinuteCommand, 60000
    }
    else
    {
        SetTimer, AutoRotation, Off
        splashimage 2:, B W0 H0 X0 Y0

        SetTimer, MinuteCommand, Off
    }
return

PgDn::
    reload
return

AutoRotation:
    if (WinActive("World of Warcraft") && !is_fishing_active)
    {
        check1 := GetKeyState("Shift", "P")
        check2 := GetKeyState("Control", "P")
        check3 := GetKeyState("Alt", "P")

        if (!check1 && !check2 && !check3)
        {
            Send {F1}
            Send {F2}
            Send {F3}
            Send {F4}
            Send {F5}
            Send {F6}
            Send {F7}
            Send {F8}
            Send {F9}
            Send {F10}
            Send {F11}
            Send {F12}
        }
    }
return

; =================================================
; AutoFishing for World of Warcraft
; by hydromaniaccat, edited by whipowill
; =================================================

End::
    MouseGetPos X, Y
    PixelGetColor getColor, %X%, %Y%, RGB
    colorFind = %getColor%

    colorShow := RegExReplace(colorFind, "0x", "")
    splashimage 5:, B W5 H5 X5 Y5 CW%colorShow%
return

Home::
    is_fishing_active := 1
    splashimage 4:, B W5 H5 X0 Y5 CWBlue
    loop
    {
        if (((A_Tickcount - timer) / 1000) >= (60 * runtime))
        {
            reload
        }

        Random, time_key, 60, 100
        SetKeyDelay, %time_key%

        send, 1
        Random, time_beforeFish, 1000, 2000
        sleep, %time_beforeFish%
        gosub fish
        Random, time_betweenFish, 1000, 2000
        sleep, %time_betweenFish%
    }

    fish:
        PixelSearch, Px, Py, %xMin%, %yMin%, %xMax%, %yMax%, %colorFind%, %colorVariation%, Fast RGB
        Mousemove, %Px%, %Py%, 0

        time1 := A_Tickcount

        loop
        {
            sleep, 50

            PixelSearch, Px1, Py1, %xMin%, %yMin%, %xMax%, %yMax%, %colorFind%, %colorVariation%, Fast RGB

            d := Py1-Py
            if (d >= delta)
            {
                ;send, {Shift Down}

                Random, small_wait, 100, 300
                sleep, %small_wait%

                mouseclick, right

                Random, small_wait, 100, 300
                sleep, %small_wait%

                ;send, {Shift Up}

                Random, small_wait, 1000, 2000
                sleep, %small_wait%

                break
            }

            time2 := A_Tickcount
            elapsed := floor((time2-time1)/1000)
            if (elapsed >= 15)
            {
                send, {Shift Down}

                Random, small_wait, 100, 300
                sleep, %small_wait%

                mouseclick, right

                Random, small_wait, 100, 300
                sleep, %small_wait%

                send, {Shift Up}

                Random, small_wait, 1000, 2000
                sleep, %small_wait%

                break
            }
        }
return

; =================================================
; Mouse Buttons for World of Warcraft
; by whipowill
; =================================================

!LButton::Send, [
!RButton::Send, ]