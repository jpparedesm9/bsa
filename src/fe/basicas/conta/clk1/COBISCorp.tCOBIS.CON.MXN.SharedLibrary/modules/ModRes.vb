Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Drawing
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox

Public Module ModRes
    Public Sub FMMsgTransaccion(ByRef parCodMsg As Integer, ByRef parTexto As String)
        Dim VTMsg As String = ""
        If parCodMsg = 0 Then
            VTMsg = parTexto
        Else
            VTMsg = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(parCodMsg))
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(VTMsg)
        'fMain.pnlTransaccionLine.BackColor = SystemColors.Control
        'fMain.pnlTransaccionLine.ForeColor = SystemColors.ControlText
    End Sub

    'Public Function FMLoadResString(ByRef parCodMsg As Integer) As String
    '    FMLoadResString = FMLoadResString(parCodMsg.ToString())
    'End Function

    Public Sub FMMsgAyuda(ByRef parCodMsg As Integer, ByRef parTexto As String)
        Dim VTMsg As String = ""
        If parCodMsg = 0 Then
            VTMsg = parTexto
        Else
            VTMsg = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(parCodMsg))
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(VTMsg)
        'fMain.pnlTransaccionLine.BackColor = SystemColors.Control
        'fMain.pnlTransaccionLine.BackColor = SystemColors.Control
    End Sub

    ' ''Public Sub PMLoadResIcons(ByRef parFrm As Object)
    ' ''    Try
    ' ''        Dim VTsCtlType As String = ""
    ' ''        parFrm.Icon = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetIcon(VGResourceManager, "ico31000").ToBitmap()
    ' ''        For Each VTCtl As Object In ContainerHelper.Controls(parFrm)
    ' ''            VTsCtlType = VTCtl.GetType().Name
    ' ''            If VTsCtlType = "CommandButton" Or VTsCtlType = "SSCommand" Then
    ' ''                If VTCtl.Style = 1 Then
    ' ''                    VTCtl.Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetIcon(VGResourceManager, "ico" + CStr(parFrm.COBISResourceProvider.GetImageID(VTCtl) + 28000)).ToBitmap
    ' ''                End If
    ' ''            End If
    ' ''        Next VTCtl
    ' ''    Catch exc As System.Exception
    ' ''        'NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
    ' ''    End Try
    ' ''End Sub

    Public Sub PMLoadResIcons(ByRef parFrm As Object)
        Dim VTForm As Object = parFrm
        While (VTForm.GetType().BaseType.Name <> "COBISFuncionalityView")
            VTForm = VTForm.Parent
        End While
        Try
            Dim VTsCtlType As String = ""
            For Each VTCtl As Object In ContainerHelper.Controls(parFrm)
                VTsCtlType = VTCtl.GetType().Name
                If VTsCtlType = "CommandButton" Or VTsCtlType = "SSCommand" Or VTsCtlType = "Button" Then
                    If VTForm.COBISResourceProvider.GetImageID(VTCtl).ToString <> "" Then
                        VTCtl.Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetIcon(VGResourceManager, "ico" + CStr(VTForm.COBISResourceProvider.GetImageID(VTCtl) + 28000)).ToBitmap
                    End If
                End If
                If VTsCtlType = "ToolStrip" Then
                    Dim a As New ToolStrip
                    Dim VLNum As Integer = 0
                    Dim i As Integer = 0
                    a = VTCtl
                    VLNum = a.Items.Count
                    For i = 0 To VLNum - 1
                        If VTForm.COBISResourceProvider.GetImageID(a.Items.Item(i)).ToString <> "" Then
                            a.Items.Item(i).Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetIcon(VGResourceManager, "ico" + CStr(VTForm.COBISResourceProvider.GetImageID(a.Items.Item(i)) + 28000)).ToBitmap
                        End If
                    Next i
                End If
            Next VTCtl
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(500232))
        End Try
    End Sub

    Public Sub PMLoadResStrings(ByRef Control As Object, Optional ByVal VTForm As Object = Nothing)
        Dim VTTag As String = ""

        If TypeOf Control Is COBISExplorer.CompositeUI.COBISFuncionalityView Then
            VTForm = Control
        End If
        'TRY TEMPORAL
        Try
            'TRY TEMPORAL
            For Each childControl As Object In ContainerHelper.Controls(Control)

                If Not childControl.GetType.GetProperty("Text") Is Nothing Then
                    If Not VTForm.COBISResourceProvider.GetImageID(childControl) = String.Empty Then
                        If Not COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTForm.COBISResourceProvider.GetImageID(childControl))) = String.Empty Then
                            childControl.Text = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTForm.COBISResourceProvider.GetImageID(childControl)))
                        End If
                    End If
                End If
                If Not childControl.GetType.GetProperty("Caption") Is Nothing Then
                    If Not VTForm.COBISResourceProvider.GetImageID(childControl) = String.Empty Then
                        If Not COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTForm.COBISResourceProvider.GetImageID(childControl))) = String.Empty Then
                            childControl.Caption = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTForm.COBISResourceProvider.GetImageID(childControl)))
                        End If
                    End If
                End If
                If Not childControl.GetType.GetProperty("ToolTipText") Is Nothing Then
                    If Not VTForm.COBISResourceProvider.GetImageID(childControl) = String.Empty Then
                        If Not COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTForm.COBISResourceProvider.GetImageID(childControl))) = String.Empty Then
                            childControl.ToolTipText = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTForm.COBISResourceProvider.GetImageID(childControl)))
                        End If
                    End If
                End If
                If Not childControl.GetType.GetProperty("HelpLine") Is Nothing Then
                    If Not VTForm.COBISResourceProvider.GetImageID(childControl) = String.Empty Then
                        If Not COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTForm.COBISResourceProvider.GetImageID(childControl))) = String.Empty Then
                            childControl.HelpLine = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTForm.COBISResourceProvider.GetImageID(childControl)))
                        End If
                    End If
                End If
                If Not childControl.GetType.GetProperty("TabPages") Is Nothing Then
                    For Each VTi As TabPage In childControl.TabPages
                        VTTag = CStr(VTi.Text).Substring(0, Math.Min(VTi.Text.Length, 4))
                        If IsNumeric(VTTag) Then
                            If Not COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(CInt(VTTag))) = String.Empty Then
                                VTi.Text = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(CInt(VTTag)))
                            End If
                        End If
                    Next VTi
                End If
                If Not childControl.GetType.GetProperty("Items") Is Nothing Then
                    If TypeOf childControl Is ToolStrip Then
                        For Each VTi As ToolStripItem In childControl.items
                            If Not VTForm.COBISResourceProvider.GetResourceID(VTi) = String.Empty Then
                                If Not COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTForm.COBISResourceProvider.GetImageID(VTi))) = String.Empty Then
                                    VTi.Text = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTForm.COBISResourceProvider.GetImageID(VTi)))
                                End If
                            End If
                        Next VTi
                    End If
                End If
                If Not childControl.GetType.GetProperty("Columns") Is Nothing Then
                    For Each VTi As Object In childControl.Columns
                        If Not VTForm.COBISResourceProvider.GetImageID(VTi) = String.Empty Then
                            If Not COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTForm.COBISResourceProvider.GetImageID(VTi))) = String.Empty Then
                                VTi.ColTitle = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTForm.COBISResourceProvider.GetImageID(VTi)))
                            End If
                        End If
                    Next VTi
                End If
                If Not childControl.GetType.GetProperty("MaxCols") Is Nothing Then
                    childControl.Row = 0
                    For VTi As Integer = 1 To childControl.MaxCols
                        If Not COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(childControl.Text)) = String.Empty Then
                            childControl.Text = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(childControl.Text))
                        End If
                    Next
                End If

                If (childControl.HasChildren) Then
                    PMLoadResStrings(childControl, VTForm)
                End If
            Next
            'CATCH TEMPORAL
        Catch ex As Exception
        End Try
        'CATCH TEMPORAL

    End Sub

    Public Function FMMsgBox(ByRef parCodMsg As Integer, ByRef parButtons As COBISMsgBox.COBISButtons, ByRef parCodTitulo As Integer, ByRef parMsg As String, ByRef parTitulo As String) As Integer
        Dim VTTitulo As String = String.Empty
        Dim VTMsg As String = String.Empty
        If parCodMsg = 0 Then
            VTMsg = parMsg
        Else
            VTMsg = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(parCodMsg))
        End If
        If parCodTitulo = 0 Then
            VTTitulo = parTitulo
        Else
            VTTitulo = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(parCodTitulo))
        End If
        Dim VTRetorno As Integer = COBISMsgBox.MsgBox(VTMsg, parButtons, VTTitulo)
        Return VTRetorno
    End Function
End Module



