Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
 public  Partial  Class FClaveClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Dim VTResult As String = ""
		Dim VT1 As String = ""
		Dim VT2 As Integer = 0
		Dim VT3 As String = ""
        Select Case Index
            Case 0
                Me.Close()
            Case 1
                If lblDescripcion(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(500449), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Exit Sub
                End If
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(509235), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(509236), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(0).Text <> txtCampo(1).Text Then
                    COBISMessageBox.Show(FMLoadResString(509237), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                VTResult = ""
                For i As Integer = 1 To Strings.Len(txtCampo(0).Text)
                    VT1 = Strings.Mid(txtCampo(0).Text, i, 1)
                    VT2 = Strings.AscW(VT1) + 3
                    VT3 = Strings.Chr(VT2).ToString()
                    VTResult = VTResult & VT3
                Next i
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "417")
                PMPasoValores(sqlconn, "@i_fun", 0, SQLINT2, lblDescripcion(0).Text)
                PMPasoValores(sqlconn, "@i_pwd", 0, SQLVARCHAR, VTResult)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_supervisor", True, FMLoadResString(509238)) Then
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
        End Select
	End Sub

    Private Sub PLInicializar()
        'Dim VTR1 As Integer = 0
        Dim VTArreglo(10) As String
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "419")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_supervisor", True, FMLoadResString(509239)) Then            
            FMMapeaArreglo(sqlconn, VTArreglo) 'VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            lblDescripcion(0).Text = VTArreglo(1)
            lblDescripcion(1).Text = VTArreglo(2)
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub FClave_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter, _txtCampo_0.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2522))
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2523))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2524))
		End Select
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToLower())
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

    Private Sub TSBTRANSMITIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSALIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub PLTSEstado()
        TSBTransmitir.Enabled = _cmdBoton_1.Enabled
        TSBTransmitir.Visible = _cmdBoton_1.Visible()
        TSBSalir.Enabled = _cmdBoton_0.Enabled
        TSBSalir.Visible = _cmdBoton_0.Visible()
    End Sub

End Class


