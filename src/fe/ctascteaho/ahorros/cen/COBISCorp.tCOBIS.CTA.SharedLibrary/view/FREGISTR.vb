Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Partial Public Class FRegistrosClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VTBanco As String = ""
    Dim VTCiudad As String = ""
    Dim VTOficina As String = ""

    Private Sub cmdSiguientes_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSiguientes.Click
        Dim VTUltimo As String = String.Empty
        Dim VLUltimo As String = "" 'JSA
        Select Case VGOperacion
            Case "sp_tranhistoricos"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2576")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, VGProducto)
                PMPasoValores(sqlconn, "@i_qry", 0, SQLCHAR, "T")
                PMPasoValores(sqlconn, "@i_tipotrn", 0, SQLINT4, "0")
                PMPasoValores(sqlconn, "@i_tipohis", 0, SQLCHAR, VGTipoHis)
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_qry_tranms", True, FMLoadResString(502520)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMAnchoColumnasGrid(Me.grdRegistros) 'JSA
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                    grdRegistros.Row = 1
                Else
                    PMChequea(sqlconn)
                End If
                PMChequea(sqlconn)
                grdRegistros.ColWidth(1) = 650
                grdRegistros.ColWidth(2) = 4500
            Case "sp_rem_ayuda"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "447")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, VGHelpRem)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT1, VGOficina)
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                VTUltimo = grdRegistros.CtlText.Trim()
                If VGHelpRem = "N" Then
                    VTUltimo = Strings.Mid(VTUltimo, 6, VTUltimo.Length - 5)
                Else
                    VTUltimo = Strings.Left(VLUltimo, 2)
                End If
                PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, VTUltimo)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_ayuda", True, FMLoadResString(508822)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMAnchoColumnasGrid(Me.grdRegistros) 'JSA
                    PMChequea(sqlconn)
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                    grdRegistros.Row = 1
                Else
                    PMChequea(sqlconn)
                End If
            Case "sp_tr_crea_rutayt"
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2587")
                PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "L")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_localidad", 0, SQLINT2, "0")
                PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_rutayt", True, FMLoadResString(503270)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMAnchoColumnasGrid(Me.grdRegistros) 'JSA
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
                cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                grdRegistros.Row = 1
            Case "sp_cat_bancos"
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "452")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cat_bancos", True, FMLoadResString(503277)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMAnchoColumnasGrid(Me.grdRegistros) 'JSA
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
                cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                grdRegistros.Row = 1
            Case "sp_tr_empresa_ach"
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT2, VGFilial)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "609")
                PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT2, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_empresa_ach", True, FMLoadResString(509244)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMAnchoColumnasGrid(Me.grdRegistros) 'JSA
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
                cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                grdRegistros.Row = 1
            Case "sp_tr_banco_ach"
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "605")
                PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT4, VGFilial)
                PMPasoValores(sqlconn, "@i_banco", 0, SQLINT2, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_banco_ach", True, FMLoadResString(509245)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMAnchoColumnasGrid(Me.grdRegistros) 'JSA
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
                cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                grdRegistros.Row = 1
            Case "sp_centro_canje"
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2810")
                PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_ciudad", 0, SQLINT4, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_centro_canje", True, FMLoadResString(509246)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMAnchoColumnasGrid(Me.grdRegistros) 'JSA
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
                cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                grdRegistros.Row = 1
            Case "sp_centro_canje1"
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2810")
                PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "H1")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_centro_canje", True, FMLoadResString(509246)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMAnchoColumnasGrid(Me.grdRegistros) 'JSA
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
                cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                grdRegistros.Row = 1
            Case "sp_banco"
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "18")
                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "O")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "1")
                PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT2, grdRegistros.CtlText)
                PMHelpG("cob_cuentas", "sp_banco", 7, 1)
                PMBuscarG(1, "@i_operacion", "H", SQLCHAR)
                PMBuscarG(2, "@i_tipo", "A", SQLCHAR)
                PMBuscarG(3, "@i_modo", "1", SQLINT1)
                PMBuscarG(4, "@t_trn", "18", SQLINT2)
                PMBuscarG(5, "@i_help", "A", SQLCHAR)
                PMBuscarG(6, "@i_tran", "O", SQLCHAR)
                PMBuscarG(7, "@i_filial", VGFilial, SQLINT1)
                PMSigteG(1, "@i_secuencial", grdRegistros.CtlText, SQLINT4)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_banco", True, FMLoadResString(503277)) Then
                    PMMapeaGrid(sqlconn, Me.grdRegistros, True)
                    PMAnchoColumnasGrid(Me.grdRegistros) 'JSA
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
                cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows
                grdRegistros.Row = 1
        End Select
        PLTSEstado()
    End Sub

    Private Sub FRegistros_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles MyBase.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If KeyAscii = 27 Then
            VGACatalogo.Descripcion = ""
            VGACatalogo.Codigo = ""
        Else
            If KeyAscii = 13 Then
                If grdRegistros.Rows > 1 Then
                    Select Case VGOperacion
                        Case "sp_tranhistoricos", "sp_tr_crea_rutayt", "sp_cat_bancos"
                            grdRegistros.Col = 1
                            VGACatalogo.Codigo = grdRegistros.CtlText
                            grdRegistros.Col = 2
                            VGACatalogo.Descripcion = grdRegistros.CtlText
                        Case "sp_rem_ayuda"
                            If VGHelpRem = "N" Then
                                grdRegistros.Col = 1
                                VGACatalogo.Codigo = grdRegistros.CtlText
                            End If
                            If VGHelpRem = "C" Then
                                grdRegistros.Col = 1
                                VTBanco = Strings.Left(grdRegistros.CtlText.Trim(), 3)
                                VTOficina = Strings.Mid(grdRegistros.CtlText.Trim(), 4, 3)
                                VTCiudad = Strings.Right(grdRegistros.CtlText.Trim(), 6)
                                VGACatalogo.Codigo = VTBanco & "-" & VTOficina & "-" & VTCiudad
                                grdRegistros.Col = 2
                                VGACatalogo.Descripcion = grdRegistros.CtlText
                            End If
                        Case "sp_cons_user_caja"
                            grdRegistros.Col = 1
                            VGACatalogo.Descripcion = grdRegistros.CtlText
                    End Select
                Else
                    VGACatalogo.Codigo = ""
                    VGACatalogo.Descripcion = ""
                End If
            End If
        End If
        'JSA 
        Me.Close()
        Me.Dispose()
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
        PLTSEstado()
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click
        grdRegistros.Col = 0
        grdRegistros.SelStartCol = 1
        grdRegistros.SelEndCol = grdRegistros.Cols - 1
        If grdRegistros.Row = 0 Then
            grdRegistros.SelStartRow = 1
            grdRegistros.SelEndRow = 1
        Else
            grdRegistros.SelStartRow = grdRegistros.Row
            grdRegistros.SelEndRow = grdRegistros.Row
        End If
        PLTSEstado()
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row) 'JSA
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row) 'JSA
        If grdRegistros.Rows > 1 Then
            Select Case VGOperacion
                Case "sp_tranhistoricos", "sp_tr_crea_rutayt", "sp_tr_crea_rutayt", "sp_cat_bancos", "sp_tr_empresa_ach", "sp_tr_banco_ach", "sp_centro_canje", "sp_centro_canje1"
                    grdRegistros.Col = 1
                    VGACatalogo.Codigo = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    VGACatalogo.Descripcion = grdRegistros.CtlText
                Case "sp_rem_ayuda"
                    If VGHelpRem = "N" Then
                        grdRegistros.Col = 1
                        VGACatalogo.Codigo = grdRegistros.CtlText
                    End If
                    If VGHelpRem = "C" Then
                        grdRegistros.Col = 1
                        VTBanco = Strings.Left(grdRegistros.CtlText.Trim(), 4)
                        VTOficina = Strings.Mid(grdRegistros.CtlText.Trim(), 5, 4)
                        VTCiudad = Strings.Right(grdRegistros.CtlText.Trim(), 4)
                        VGACatalogo.Codigo = VTBanco & "-" & VTOficina & "-" & VTCiudad
                        grdRegistros.Col = 2
                        VGACatalogo.Descripcion = grdRegistros.CtlText
                    End If
                Case "sp_cons_user_caja"
                    grdRegistros.Col = 1
                    VGACatalogo.Descripcion = grdRegistros.CtlText
                Case "sp_prodfin3"
                    grdRegistros.Col = 1
                    VGACatalogo.Codigo = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    VGACatalogo.Descripcion = grdRegistros.CtlText
                Case "sp_hp_sucursal"
                    grdRegistros.Col = 1
                    VGACatalogo.Codigo = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    VGACatalogo.Descripcion = grdRegistros.CtlText
                Case Else
                    grdRegistros.Col = 1
                    VGACatalogo.Codigo = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    VGACatalogo.Descripcion = grdRegistros.CtlText
            End Select
        Else
            VGACatalogo.Codigo = ""
            VGACatalogo.Descripcion = ""
        End If
        'JSA         
        Me.Dispose()
        Me.Close()
    End Sub

    Private Sub grdRegistros_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdRegistros.KeyUp
        grdRegistros.Col = 0
        grdRegistros.SelStartCol = 1
        grdRegistros.SelEndCol = grdRegistros.Cols - 1
        If grdRegistros.Row = 0 Then
            grdRegistros.SelStartRow = 1
            grdRegistros.SelEndRow = 1
        Else
            grdRegistros.SelStartRow = grdRegistros.Row
            grdRegistros.SelEndRow = grdRegistros.Row
        End If
        PLTSEstado()
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If cmdSiguientes.Enabled Then cmdSiguientes_Click(cmdSiguientes, e)
    End Sub

    Private Sub FRegistros_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLTSEstado()
        'PMMapeaTextoGrid(grdRegistros)
    End Sub
    Private Sub PLTSEstado()
        TSBSiguientes.Enabled = cmdSiguientes.Enabled
        TSBSiguientes.Visible = cmdSiguientes.Visible
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        grdRegistros.Col = 0
        If Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows Then
            cmdSiguientes.Enabled = True
            grdRegistros.Row = 1
        Else
            cmdSiguientes.Enabled = False
        End If
        VGACatalogo.Descripcion = ""
        VGACatalogo.Codigo = ""
        'PLAjustaGrid(grdRegistros, Me)
        'PMMapeaTextoGrid(grdRegistros)
        PMMapeaTextoGrid(grdRegistros)
        PMAnchoColumnasGrid(grdRegistros)
        PLTSEstado()
    End Sub

End Class


