Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
 Public  Partial  Class FHelpOficialClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
	Dim VTCodigo As String = ""
	Dim VTR1 As Integer = 0
	Dim i As Integer = 0
	Dim VTemporal As String = ""
	Dim VTpos As Integer = 0

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		ReDim VGBusqueda(2)
		Dim VTpos As Integer = 0
		Dim  VTpos1 As Integer = 0
		Dim  VTpos2 As Integer = 0
		Dim VTNombre As String = ""
		Select Case Index
			Case 0
				VTpos = (otlOficiales.CtlText.IndexOf(" - ") + 1)
				If VTpos <> 0 Then
					VTCodigo = Strings.Mid(otlOficiales.CtlText, 1, VTpos - 1).Trim()
					VTpos1 = Strings.InStr(VTpos + 2, otlOficiales.CtlText, " - ")
					VTpos2 = Strings.InStr(VTpos1 + 2, otlOficiales.CtlText, " - ")
					VTNombre = Strings.Mid(otlOficiales.CtlText, VTpos1 + 2, VTpos2 - VTpos1 - 1).Trim()
				End If
				If otlOficiales.ListIndex <> 0 Then
					VGBusqueda(0) = VTCodigo
					VGBusqueda(1) = VTNombre
					Me.Close()
				End If
			Case 1
				VGBusqueda(0) = "*"
				Me.Close()
		End Select
	End Sub

	Private Sub cmdBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Enter, _cmdBoton_1.Enter
        'Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        'Select Case Index
        '	Case 0
        '              COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500240))
        '	Case 1
        '              COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2622))
        'End Select
	End Sub

	Private Sub FHelpOficial_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
		Dim VLSuper As String = ""
		PMLoadResStrings(Me)
		PMLoadResIcons(Me)
		otlOficiales.Clear()
		Dim VTOficiales(5, 100) As String
		If VGOficial <> "" Then
			VLSuper = VGOficial
		Else
			VLSuper = "32001"
		End If
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15153")
		PMPasoValores(sqlconn, "@i_super", 0, SQLINT2, VLSuper)
		PMPasoValores(sqlconn, "@i_nivel", 0, SQLVARCHAR, "1")
		PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_tr_cons_oficiales", True, FMLoadResString(2622)) Then
            VTR1 = FMMapeaMatriz(sqlconn, VTOficiales)
            PMChequea(sqlconn)
            otlOficiales.AddItem(FMLoadResString(509243), 0)
            For i As Integer = 1 To VTR1
                VTemporal = " " & VTOficiales(0, i) & " - " & "N" & VTOficiales(3, 1) & " - " & VTOficiales(1, i) & " - " & VTOficiales(2, i)
                otlOficiales.AddItem(VTemporal)
            Next i
            If VTR1 <> 0 Then
                otlOficiales.ListIndex = 1
            End If
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
	End Sub

	Private Sub otlOficiales_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles otlOficiales.DoubleClick
		Dim VTOficial As String = ""
		Dim VTIndex As Integer = otlOficiales.ListIndex
		Dim VTOficiales(5, 100) As String
		If otlOficiales.ListIndex <> 0 Then
            'JSA If otlOficiales.Expand(CShort(VTIndex)) Then
            If otlOficiales.ExpandIndexed(CShort(VTIndex)) Then
                'JSA otlOficiales.Expand(CShort(VTIndex)) = False
                otlOficiales.ExpandIndexed(CShort(VTIndex)) = False
            Else
                If Not otlOficiales.HasSubItems(CShort(VTIndex)) Then
                    VTpos = (otlOficiales.CtlText.IndexOf(" - ") + 1)
                    VTCodigo = Strings.Mid(otlOficiales.CtlText, 1, VTpos - 1).Trim()
                    VTOficial = "0"
                    Do While 1 = 1
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15153")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                        PMPasoValores(sqlconn, "@i_super", 0, SQLINT2, VTCodigo)
                        PMPasoValores(sqlconn, "@i_nivel", 0, SQLVARCHAR, "1")
                        PMPasoValores(sqlconn, "@i_oficial", 0, SQLINT2, VTOficial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_tr_cons_oficiales", True, FMLoadResString(2622)) Then
                            VTR1 = FMMapeaMatriz(sqlconn, VTOficiales)
                            PMChequea(sqlconn)
                            For i As Integer = 1 To VTR1
                                VTemporal = " " & VTOficiales(0, i) & " - " & "N" & VTOficiales(3, 1) & " - " & VTOficiales(1, i) & " - " & VTOficiales(2, i)
                                otlOficiales.AddItem(VTemporal)
                            Next i
                            If FMRetStatus(sqlconn) <> 20 Then
                                Exit Do
                            End If
                            VTOficial = VTOficiales(0, VTR1)
                        Else
                            PMChequea(sqlconn)
                        End If
                    Loop
                End If
            End If
            'JSA otlOficiales.Expand(CShort(VTIndex)) = True
            otlOficiales.ExpandIndexed(CShort(VTIndex)) = True
        Else
            COBISMessageBox.Show(FMLoadResString(500254), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
	End Sub

	Private Sub otlOficiales_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles otlOficiales.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500255))
    End Sub

    Private Sub PLTSEstado()
        TSBEscoger.Enabled = _cmdBoton_0.Enabled
        TSBEscoger.Visible = _cmdBoton_0.Visible
        TSBCancelar.Enabled = _cmdBoton_1.Enabled
        TSBCancelar.Visible = _cmdBoton_1.Visible
    End Sub

    Private Sub TSBEscoger_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBCancelar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCancelar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub otlOficiales_Leave(sender As Object, e As EventArgs) Handles otlOficiales.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


