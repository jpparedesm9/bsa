Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.VB
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
 public  Partial  Class FPrintClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Private Sub cmbPrinters_Enter(sender As Object, e As EventArgs) Handles cmbPrinters.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2525))
    End Sub

	Private Sub cmbPrinters_SelectionChangeCommitted(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbPrinters.SelectionChangeCommitted
        VGImpresora = ""
		If cmbPrinters.SelectedIndex > 0 Then
            For Each X As Object In PrinterHelper.Printers
                If COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.DeviceName.ToUpper() = X.DeviceName.ToString.ToUpper Then
                    VGImpresora = X.DeviceName
                    Exit For
                End If
            Next X
        End If
	End Sub

	Private Sub cmdboton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdboton_1.Click, _cmdboton_0.Click
		Dim Index As Integer = Array.IndexOf(cmdboton, eventSender)
		Select Case Index
			Case 0
				If VGImpresora <> "" Then
					If optOrientacion(0).Checked Then
						VGImpOrientacion = 1
					Else
						VGImpOrientacion = 2
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500260), FMLoadResString(500261), COBISMessageBox.COBISButtons.OK)
				End If
            Case 1
        End Select
        Me.Dispose() 'JSA
        Me.Close()
    End Sub

    Private Sub optOrientacion_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optOrientacion_1.Enter, _optOrientacion_0.Enter
        Dim Index As Integer = Array.IndexOf(optOrientacion, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1012))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1011))
        End Select
    End Sub

    Private Sub cmdboton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdboton_1.Enter, _cmdboton_0.Enter
        Dim Index As Integer = Array.IndexOf(cmdboton, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501355))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500253))
        End Select
    End Sub

	Private Sub FPrint_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" 'JSA
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        FMCargarPrinters()
        PLInicializar() 'JSA
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        If VGCodPais = "CO" Then
            optOrientacion(0).Checked = True
        End If
    End Sub

	Private Sub FMCargarPrinters()
        cmbPrinters.Items.Clear()
        cmbPrinters.Items.Add("")
        For Each X As Object In PrinterHelper.Printers
            If Not cmbPrinters.Items.Contains(X.DeviceName.ToUpper) Then
                cmbPrinters.Items.Add(X.DeviceName.ToUpper)
            End If
        Next X
    End Sub

    Private Sub PLTSEstado()
        TSBAceptar.Enabled = _cmdboton_0.Enabled
        TSBAceptar.Visible = _cmdboton_0.Visible
        TSBCancelar.Enabled = _cmdboton_1.Enabled
        TSBCancelar.Visible = _cmdboton_1.Visible
    End Sub

    Private Sub TSBAceptar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBAceptar.Click
        If _cmdboton_0.Enabled Then cmdboton_Click(_cmdboton_0, e)
    End Sub

    Private Sub TSBCancelar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCancelar.Click
        If _cmdboton_1.Enabled Then cmdboton_Click(_cmdboton_1, e)
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
    End Sub
End Class


