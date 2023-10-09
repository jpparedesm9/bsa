Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.REC.SharedLibrary

Partial Public Class FRESGISTRANSClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim isInitializingComponent As Boolean



    Private Sub FRESGISTRANSClass_Load(sender As Object, e As EventArgs) Handles Me.Load        
        MyAppGlobals.AppActiveForm = ""

        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles TSBTransmitir.Click, TSBLimpiar.Click, TSBSalir.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 1
                insertar()
            Case 2
                Limpiar()
            Case 3
                Me.Close()
        End Select
    End Sub


    Private Sub insertar()

        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(600032), FMLoadResString(600031), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(600033), FMLoadResString(600031), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(2).Focus()
            Exit Sub
        End If

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "36002")
        PMPasoValores(sqlconn, "@i_operacion ", 0, SQLCHAR, "C")
        PMPasoValores(sqlconn, "@i_funcionario ", 0, SQLCHAR, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_descripcion ", 0, SQLCHAR, txtCampo(2).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_conta_super", "sp_cons_trns", True, FMLoadResString(600028)) Then
            PMChequea(sqlconn)


        Else
            PMChequea(sqlconn)

        End If
        Limpiar()


    End Sub
    Private Sub Limpiar()
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""

        txtCampo(1).Focus()



    End Sub


    Private Sub txtCampo_Enter(sender As Object, e As EventArgs) Handles _txtCampo_1.Enter, _txtCampo_2.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, sender)
        Select Case Index
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(600026))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(600027))
        End Select

    End Sub


    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_2.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            
            '     (KeyAscii <> 8) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 97) Or (KeyAscii > 122)) Then
            '           KeyAscii = 0
            Case 1
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 96) Or (KeyAscii > 122)) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())

                End If

            Case 2


                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii > 65) Or (KeyAscii < 90)) And (KeyAscii = 44) And (KeyAscii = 46) And (KeyAscii = 58) Or (KeyAscii = 59) And (KeyAscii = 13) Then

                    KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())

                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

End Class



