Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Partial Public Class FCatalogoClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VTUb1 As Integer = 0
    Dim VTUb2 As Object = DBNull.Value

    Private Sub cmdSiguientes_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSiguientes.Click
        Dim VTUb2 As Integer = 0
        ListBoxHelper.SetSelectedIndex(lstCatalogo, lstCatalogo.Items.Count - 1)
        VTUb1 = (lstCatalogo.Text.IndexOf(Strings.Chr(9).ToString()) + 1)
        Select Case VGOperacion
            Case "sp_filial"
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_filial", True, FMLoadResString(509147)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn) 'JSA
                End If
            Case "sp_oficina"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1574")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_oficina", True, FMLoadResString(502842)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn) 'JSA
                End If
            Case "sp_moneda"
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                FMLoadResString(502984)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_moneda", True, FMLoadResString(509148)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn) 'JSA
                End If
            Case "sp_agencia"
                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_sig", 0, SQLINT2, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(502842)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn) 'JSA
                End If
            Case "sp_tipo_chequera"
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "35")
                PMPasoValores(sqlconn, "@i_tchq", 0, SQLVARCHAR, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                FMLoadResString(502842)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tipo_chequera", True, FMLoadResString(509149)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn) 'JSA
                End If
            Case "sp_lotes"
                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_sig", 0, SQLINT2, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "496")
                FMLoadResString(502842)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_lotes", True, FMLoadResString(509150)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn) 'JSA
                End If
            Case "sp_area"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, CStr(6510))
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "F")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, CStr(1))
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_area_padre", 0, SQLINT4, CStr(250))
                PMPasoValores(sqlconn, "@i_area", 0, SQLINT4, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                FMLoadResString(502842)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_area", True, FMLoadResString(509151)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn) 'JSA
                End If
            Case "sp_tr_persnat_ach"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "613")
                PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT2, VGFilial)
                PMPasoValores(sqlconn, "@i_cta_ach", 0, SQLINT4, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                FMLoadResString(502842)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_persnat_ach", True, FMLoadResString(509152)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn) 'JSA
                End If
            Case "sp_tr_empresa_ach"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "609")
                PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT2, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT2, VGFilial)
                FMLoadResString(502842)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_empresa_ach", True, FMLoadResString(509153)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn) 'JSA
                End If
            Case "sp_tr_banco_ach"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "605")
                PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_banco", 0, SQLINT2, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT2, VGFilial)
                FMLoadResString(502842)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_banco_ach", True, FMLoadResString(509154)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn) 'JSA
                End If
            Case "sp_cons_ach_general_A"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "639")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "R")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT2, VGFilial)
                PMPasoValores(sqlconn, "@i_secuencial", 0, SQLFLT8, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                FMLoadResString(502842)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_ach_general", True, FMLoadResString(509155)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn) 'JSA
                End If
            Case "sp_pro_transaccion"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15020")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "9")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VGProductoConta)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "R")
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_transaccion", 0, SQLINT4, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_pro_transaccion", True, FMLoadResString(502984)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn) 'JSA
                End If
            Case "sp_perfil"
                VTUb2 = Strings.InStr(VTUb1 + 1, Me.lstCatalogo.Text, Strings.Chr(9).ToString())
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6907")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "2")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VGProductoConta)
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGFilial)
                If VTUb2 <> 0 Then
                    PMPasoValores(sqlconn, "@i_perfil1", 0, SQLVARCHAR, Strings.Mid(Me.lstCatalogo.Text, VTUb1 + 1, VTUb2 - VTUb1 - 1))
                Else
                    PMPasoValores(sqlconn, "@i_perfil1", 0, SQLVARCHAR, Strings.Mid(Me.lstCatalogo.Text, VTUb1 + 1, Strings.Len(Me.lstCatalogo.Text) - VTUb1 + 1))
                End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_perfil", True, FMLoadResString(2277)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn) 'JSA
                End If
            Case ""
                cmdSiguientes.Enabled = False
        End Select
        If VGOperacion <> "" Then
            cmdSiguientes.Enabled = Conversion.Val(CStr(lstCatalogo.Items.Count)) Mod 20 = 0
        End If
        PLTSEstado() 'JSA
    End Sub

    Private Sub FCatalogo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles MyBase.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim VTUb2 As Integer = 0
        If KeyAscii = 27 Then
            VGACatalogo.Codigo = ""
            VGACatalogo.Descripcion = ""
            Me.Close()
        Else
            If KeyAscii = 13 Then
                If Me.lstCatalogo.Items.Count <> 0 Then
                    VTUb1 = (lstCatalogo.Text.IndexOf(Strings.Chr(9).ToString()) + 1)
                    VGACatalogo.Codigo = Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1)
                    VTUb2 = Strings.InStr(VTUb1 + 1, Me.lstCatalogo.Text, Strings.Chr(9).ToString())
                    If VTUb2 <> 0 Then
                        VGACatalogo.Descripcion = Strings.Mid(Me.lstCatalogo.Text, VTUb1 + 1, VTUb2 - VTUb1 - 1)
                    Else
                        VGACatalogo.Descripcion = Strings.Mid(Me.lstCatalogo.Text, VTUb1 + 1, Strings.Len(Me.lstCatalogo.Text) - VTUb1 + 1)
                    End If
                Else
                    VGACatalogo.Codigo = ""
                    VGACatalogo.Descripcion = ""
                End If
                Me.Close()
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub lstCatalogo_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles lstCatalogo.DoubleClick
        Dim VTUb2 As Integer = 0
        If Me.lstCatalogo.Items.Count <> 0 Then
            VTUb1 = (lstCatalogo.Text.IndexOf(Strings.Chr(9).ToString()) + 1)
            VGACatalogo.Codigo = Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1)
            VTUb2 = Strings.InStr(VTUb1 + 1, Me.lstCatalogo.Text, Strings.Chr(9).ToString())
            If VTUb2 <> 0 Then
                VGACatalogo.Descripcion = Strings.Mid(Me.lstCatalogo.Text, VTUb1 + 1, VTUb2 - VTUb1 - 1)
            Else
                VGACatalogo.Descripcion = Strings.Mid(Me.lstCatalogo.Text, VTUb1 + 1, Strings.Len(Me.lstCatalogo.Text) - VTUb1 + 1)
            End If
        Else
            VGACatalogo.Codigo = ""
            VGACatalogo.Descripcion = ""
        End If
        Me.Close()
    End Sub

    Private Sub PLTSEstado()
        TSBSiguiente.Enabled = cmdSiguientes.Enabled
        TSBSiguiente.Visible = cmdSiguientes.Visible
    End Sub

    Private Sub FCatalogo_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLTSEstado()
        VGACatalogo.Codigo = ""
        VGACatalogo.Descripcion = ""
    End Sub

    Private Sub TSBSIGUIENTE_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdSiguientes.Enabled Then cmdSiguientes_Click(_cmdSiguientes, e)
        PLTSEstado()
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        cmdSiguientes.Enabled = Not (lstCatalogo.Items.Count < 20)
        If (ListBoxHelper.GetSelectedIndex(lstCatalogo) = -1) And (lstCatalogo.Items.Count > 0) Then
            ListBoxHelper.SetSelectedIndex(lstCatalogo, 0)
        End If
        PLTSEstado()
    End Sub
End Class


