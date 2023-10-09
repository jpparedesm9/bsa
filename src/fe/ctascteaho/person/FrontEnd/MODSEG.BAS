Attribute VB_Name = "MODSEG"
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
' Módulo de seguridad para el Front End
' Permite habilitar o desahabilitar los item de los menus

' Arreglo con el conjunto de transacciones permisibles para
' el rol del usuario

Global VGTransacciones() As String
Global VGNumTran As Integer

Function FMSeguridad() As Integer
Dim VTR1%
    FMSeguridad% = False
    ReDim VGTransacciones(1, 10000) As String
     PMPasoValores sqlconn&, "@i_rol", 0, SQLINT1, VGRol$
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "rp_tr_autorizada", True, " Cargando transacciones autorizadas...") Then
         VGNumTran% = FMMapeaMatriz(sqlconn&, VGTransacciones())
         PMChequea sqlconn&
        FMSeguridad% = True
        FPrincipal.pnlTransaccionLine = "Transacciones Autorizadas...[" & Str$(VTR1%) & "]"
    Else
        ReDim VGTransacciones(0, 0) As String
        FMSeguridad% = False
        Exit Function
    End If
End Function

Sub PMBotonSeguridad(Forma As Object, Indice As Integer)

Dim VTArrayTran() As String
Dim VTDato$
    ' Rutina de Control de Seguridades para habilitación de
    ' Botones de Comandos
Dim i%
Dim VTPosicion%
Dim vttransacciones%
Dim VTProcesadas%
Dim j%
Dim VTFlag%
Dim VTMedio%
Dim VTMax%
Dim VTMin%
    For i% = 0 To Indice%
        
        VTPosicion% = 1
        vttransacciones% = 0

'FIXIT: 'cmdBoton(i%' is not a property of the generic 'Form' object in Visual Basic .NET. To access 'cmdBoton(i%' declare 'Forma' using its actual type instead of 'Form'     FixIT90210ae-R1460-RCFE85
        While VTPosicion% < Len(Forma.cmdBoton(i%).Tag) = True
            VTDato$ = ""
'FIXIT: 'cmdBoton(i%).Tag' is not a property of the generic 'Form' object in Visual Basic .NET. To access 'cmdBoton(i%).Tag' declare 'Forma' using its actual type instead of 'Form'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'cmdBoton(i%' is not a property of the generic 'Form' object in Visual Basic .NET. To access 'cmdBoton(i%' declare 'Forma' using its actual type instead of 'Form'     FixIT90210ae-R1460-RCFE85
            While (Mid$(Forma.cmdBoton(i%).Tag, VTPosicion%, 1) <> ";") And (VTPosicion% <= Len(Forma.cmdBoton(i%).Tag))
'FIXIT: 'cmdBoton(i%).Tag' is not a property of the generic 'Form' object in Visual Basic .NET. To access 'cmdBoton(i%).Tag' declare 'Forma' using its actual type instead of 'Form'     FixIT90210ae-R1460-RCFE85
                VTDato$ = VTDato$ & Mid$(Forma.cmdBoton(i%).Tag, VTPosicion%, 1)
                VTPosicion% = VTPosicion% + 1
            Wend
            vttransacciones% = vttransacciones% + 1
            ReDim Preserve VTArrayTran(vttransacciones%) As String
            VTArrayTran(vttransacciones%) = VTDato$
            VTPosicion% = VTPosicion% + 1
        Wend

        VTProcesadas% = 1
        j% = 1
        VTFlag% = True


        While (vttransacciones% >= VTProcesadas%) And VTFlag%
            VTFlag% = False
            ' Busqueda Binaria

            VTMedio% = VGNumTran% \ 2
            VTMax% = VGNumTran%
            VTMin% = 0

            While (VTMedio% >= 1) And (VTMedio% > VTMin%) And (VTMedio% < VTMax%)
                If Val(VGTransacciones(0, VTMedio%)) = Val(VTArrayTran(VTProcesadas%)) Then
'FIXIT: 'cmdBoton(i%' is not a property of the generic 'Form' object in Visual Basic .NET. To access 'cmdBoton(i%' declare 'Forma' using its actual type instead of 'Form'     FixIT90210ae-R1460-RCFE85
                    Forma.cmdBoton(i%).Enabled = True
'FIXIT: 'cmdBoton(i%' is not a property of the generic 'Form' object in Visual Basic .NET. To access 'cmdBoton(i%' declare 'Forma' using its actual type instead of 'Form'     FixIT90210ae-R1460-RCFE85
                    Forma.cmdBoton(i%).Visible = True
                    VTMedio% = 0
                Else
                    If Val(VGTransacciones(0, VTMedio%)) < Val(VTArrayTran(VTProcesadas%)) Then
                        VTMin% = VTMedio%
                        VTMedio% = VTMedio% + ((VTMax% - VTMedio%) \ 2)
                    Else
                        VTMax% = VTMedio%
                        VTMedio% = VTMin% + ((VTMedio% - VTMin%) \ 2)
                    End If
                End If
            Wend

            VTProcesadas% = VTProcesadas% + 1
        Wend

    Next i%
End Sub

Sub PMMenuSeguridad(Menu As Control)
Dim VTPosicion%
Dim VTDato$
Dim VTMedio%
Dim VTMax%
Dim VTMin%
    Menu.Enabled = False
    VTPosicion% = 1
    While VTPosicion% <= Len(Menu.Tag)
        VTDato$ = ""
        While (Mid$(Menu.Tag, VTPosicion%, 1) <> ";") And (VTPosicion% <= Len(Menu.Tag))
            VTDato$ = VTDato$ & Mid$(Menu.Tag, VTPosicion%, 1)
            VTPosicion% = VTPosicion% + 1
        Wend

        VTMedio% = VGNumTran% \ 2
        VTMax% = VGNumTran%
        VTMin% = 0

        While (VTMedio% >= 1) And (VTMedio% > VTMin%) And (VTMedio% < VTMax%)
            If Val(VGTransacciones(0, VTMedio%)) = Val(VTDato$) Then
                Menu.Enabled = True
                Exit Sub
            Else
                If Val(VGTransacciones(0, VTMedio%)) < Val(VTDato$) Then
                    VTMin% = VTMedio%
                    VTMedio% = VTMedio% + ((VTMax% - VTMedio%) \ 2)
                Else
                    VTMax% = VTMedio%
                    VTMedio% = VTMin% + ((VTMedio% - VTMin%) \ 2)
                End If
            End If
        Wend
        VTPosicion% = VTPosicion% + 1
    Wend
End Sub

Sub PMObjetoSeguridad(objeto As Control)
      Dim VTArrayTran() As String
      Dim VTPosicion%
      Dim vttransacciones%
      Dim VTDato$
      Dim VTProcesadas%
      Dim j%
      Dim VTFlag%
      Dim VTMedio%
      Dim VTMax%
      Dim VTMin%
      objeto.Enabled = False
      VTPosicion% = 1
      vttransacciones% = 0
        While VTPosicion% < Len(objeto.Tag) = True
            VTDato$ = ""
            While (Mid$(objeto.Tag, VTPosicion%, 1) <> ";") And (VTPosicion% <= Len(objeto.Tag)) 'boton))
                VTDato$ = VTDato$ & Mid$(objeto.Tag, VTPosicion%, 1) '(boton, VTPosicion%, 1)
                VTPosicion% = VTPosicion% + 1
            Wend
            vttransacciones% = vttransacciones% + 1
            ReDim Preserve VTArrayTran(vttransacciones%) As String
            VTArrayTran(vttransacciones%) = VTDato$
            VTPosicion% = VTPosicion% + 1
        Wend
        VTProcesadas% = 1
        j% = 1
        VTFlag% = True
        While (vttransacciones% >= VTProcesadas%) And VTFlag%
            VTFlag% = False
            ' Busqueda Binaria
            VTMedio% = VGNumTran% \ 2
            VTMax% = VGNumTran%
            VTMin% = 0
            While (VTMedio% >= 1) And (VTMedio% > VTMin%) And (VTMedio% < VTMax%)
                If Val(VGTransacciones(0, VTMedio%)) = Val(VTArrayTran(VTProcesadas%)) Then
                    objeto.Enabled = True
                    objeto.Visible = True
                    VTMedio% = 0
                Else
                    If Val(VGTransacciones(0, VTMedio%)) < Val(VTArrayTran(VTProcesadas%)) Then
                        VTMin% = VTMedio%
                        VTMedio% = VTMedio% + ((VTMax% - VTMedio%) \ 2)
                    Else
                        VTMax% = VTMedio%
                        VTMedio% = VTMin% + ((VTMedio% - VTMin%) \ 2)
                    End If
                End If
            Wend
            VTProcesadas% = VTProcesadas% + 1
        Wend
End Sub


