Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module ModRes
    Public VGCulture As Globalization.CultureInfo

    Dim COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider

    Public Function FMLoadResString(ByRef parCodMsg As Integer) As String
        FMLoadResString = FMLoadResString(parCodMsg.ToString())
    End Function

    Public Function FMLoadResString(ByRef parCodMsg As String) As String
        If VGCulture Is Nothing Then
            FMLoadResString = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + parCodMsg)
        Else
            FMLoadResString = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + parCodMsg, VGCulture)
        End If
    End Function

    Public Sub FMMsgTransaccion(ByRef parCodMsg As Integer, ByRef parTexto As String)
        Dim VTMsg As String = ""
        If parCodMsg = 0 Then
            VTMsg = parTexto
        Else
            VTMsg = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(parCodMsg))
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(VTMsg)
    End Sub

    Public Sub FMMsgAyuda(ByRef parCodMsg As Integer, ByRef parTexto As String)
        Dim VTMsg As String = ""
        If parCodMsg = 0 Then
            VTMsg = parTexto
        Else
            VTMsg = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(parCodMsg))
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(VTMsg)
    End Sub

    Public Sub PMLoadResIcons(ByRef parFrm As Object)
        Try
            Dim VTsCtlType As String = ""
            For Each VTCtl As Object In ContainerHelper.Controls(parFrm)
                VTsCtlType = VTCtl.GetType().Name
                If VTsCtlType = "CommandButton" Or VTsCtlType = "SSCommand" Then
                    If VTCtl.Style = 1 Then
                        VTCtl.Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetIcon(VGResourceManager, "ico" + CStr(parFrm.COBISResourceProvider.GetImageID(VTCtl) + 28000)).ToBitmap
                    End If
                End If
                If VTsCtlType = "ToolStrip" Then
                    Dim a As New ToolStrip
                    Dim VLNum As Integer = 0
                    Dim i As Integer = 0
                    a = VTCtl
                    VLNum = a.Items.Count
                    For i = 0 To VLNum - 1
                        If parFrm.COBISResourceProvider.GetImageID(a.Items.Item(i)).ToString <> "" Then
                            Try
                                a.Items.Item(i).Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetIcon(VGResourceManager, "ico" + CStr(parFrm.COBISResourceProvider.GetImageID(a.Items.Item(i)) + 28000)).ToBitmap
                            Catch ex As Exception
                            End Try
                        End If
                    Next i
                End If
            Next VTCtl
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Public Sub PMLoadResStrings(ByRef parFrm As Object)
        Dim VTForm As Object = parFrm
        Dim parentForm As Object = Nothing
        Dim VTsCtlType As String = ""
        Dim VTnVal As Integer = 0
        Dim VTString As String = String.Empty
        If Not VTForm.GetType().IsSubclassOf(GetType(COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView)) Then
            While Not VTForm.GetType().IsSubclassOf(GetType(COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView))

                If Not VTForm.Parent Is Nothing Then
                    VTForm = VTForm.Parent
                Else
                    Exit While
                End If
            End While
        End If
        parentForm = VTForm
        For Each VTCtl As Object In ContainerHelper.Controls(parFrm)
            VTsCtlType = VTCtl.GetType().Name
            If VTsCtlType = "Menu" Then
                VTCtl.Text = FMLoadResString(parentForm.COBISResourceProvider.GetResourceID(VTCtl))
            ElseIf VTsCtlType = "TabStrip" Then
                For Each VTObj As Object In VTCtl.Tabs
                    VTObj.Caption = FMLoadResString(VTObj.Tag)
                    VTObj.ToolTipText = FMLoadResString(VTObj.ToolTipTextID)
                Next VTObj

            ElseIf VTsCtlType = "MenuItemControl" Then
                Dim text As String = String.Empty
                text = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTForm.COBISResourceProvider.GetResourceID(VTCtl.ToolStripItemInstance)))
                If text <> "" Then
                    VTCtl.Text = text
                End If
            ElseIf VTsCtlType = "TabControl" Then
                For Each VTObj As Object In VTCtl.TabPages
                    If IsNumeric(VTObj.Text) Then
                        VTObj.Text = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + VTObj.Text)
                    End If
                Next VTObj
            ElseIf VTsCtlType = "COBISTabControl" Then
                For Each VTObj As Object In VTCtl.TabPages
                    If CStr(VTObj.Tag) <> "" Then
                        VTObj.Text = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTObj.Tag))
                    End If
                Next VTObj
            ElseIf VTsCtlType = "MhTab" Then
                For VTi As Integer = 0 To VTCtl.Folders
                    VTCtl.Folder = VTi
                    VTCtl.TabCaption = FMLoadResString(VTCtl.TabCaption)
                Next VTi
            ElseIf VTsCtlType = "Mh3dList" Or VTsCtlType = "COBISMh3dList" Then
                For VTi As Integer = 0 To VTCtl.Col
                    VTCtl.Col = VTi
                    If IsNumeric(VTCtl.ColTitle) Then
                        VTCtl.ColTitle = FMLoadResString(VTCtl.ColTitle)
                    End If
                Next VTi
            ElseIf VTsCtlType = "Toolbar" Then
                For Each VTObj As Object In VTCtl.Buttons
                    VTObj.ToolTipText = FMLoadResString(VTObj.ToolTipText)
                Next VTObj
            ElseIf VTsCtlType = "ListView" Then
                For Each VTObj As Object In VTCtl.ColumnHeaders
                    VTObj.Text = FMLoadResString(VTObj.Tag)
                Next VTObj
            ElseIf VTsCtlType = "TextValid" Then
                VTCtl.HelpLine = FMLoadResString(parentForm.COBISResourceProvider.GetImageID(VTCtl))
            ElseIf VTsCtlType = "OpenFileDialog" Then
                VTCtl.Title = FMLoadResString(parentForm.COBISResourceProvider.GetResourceID(VTCtl))
            ElseIf VTsCtlType = "MaskInBox" Then
                VTCtl.HelpLine = FMLoadResString(parentForm.COBISResourceProvider.GetImageID(VTCtl))
            ElseIf VTsCtlType = "vaSpread" Or VTsCtlType = "COBISSpread" Then
                Dim wTexto As String = String.Empty
                For VTi As Integer = 0 To VTCtl.MaxCols - 1
                    If CStr(VTCtl.ActiveSheet.ColumnHeader.Columns(VTi).Label).Equals("A") Or CStr(VTCtl.ActiveSheet.ColumnHeader.Columns(VTi).Label).Trim.Equals("") Then

                        Exit For

                    Else
                        Try
                            wTexto = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTCtl.ActiveSheet.ColumnHeader.Columns(VTi).Label))
                        Catch ex As Exception
                            Exit For
                        End Try

                        If wTexto <> String.Empty Then
                            VTCtl.ActiveSheet.ColumnHeader.Columns(VTi).Label = wTexto
                        End If
                    End If
                Next
            ElseIf VTsCtlType = "PictureBox" Then
            ElseIf VTsCtlType = "MenuItemControl" Then
                VTCtl.Text = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTForm.COBISResourceProvider.GetResourceID(VTCtl.ToolStripItemInstance)))
            ElseIf VTsCtlType = "ToolStrip" Then
                Dim a As New ToolStrip
                Dim VLNum As Integer = 0
                Dim i As Integer = 0
                a = VTCtl
                VLNum = a.Items.Count
                For i = 0 To VLNum - 1
                    VTString = parentForm.COBISResourceProvider.GetResourceID(a.Items.Item(i)).ToString
                    If VTString <> "" Then
                        Try
                            If IsNumeric(VTString) Then
                                VTnVal = CInt(VTString)
                                a.Items.Item(i).Text = FMLoadResString(VTnVal)
                            End If
                        Catch ex As Exception
                        End Try
                    End If
                Next i
            Else
                VTnVal = 0
                VTnVal = CInt(Conversion.Val(CStr(parentForm.COBISResourceProvider.GetResourceID(VTCtl))))
                If VTnVal > 0 Then
                    VTCtl.Text = FMLoadResString(VTnVal)
                    VTnVal = 0
                End If
                PMLoadResStrings(VTCtl)
            End If
        Next VTCtl
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


