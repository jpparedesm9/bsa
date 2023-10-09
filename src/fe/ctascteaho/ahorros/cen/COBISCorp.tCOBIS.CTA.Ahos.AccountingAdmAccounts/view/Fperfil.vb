Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FPerfilClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLPaso As Integer = 0
    Dim VLSecuencia As Integer = 0

    Sub PMProducto(ByRef ICampo As Integer, ByRef operacion As String, ByRef Producto As String)
        VLPaso = True
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "475")
        PMPasoValores(sqlconn, "@i_ope", 0, SQLCHAR, operacion)
        If operacion = "V" Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, Producto)
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_prod", True, FMLoadResString(2277)) Then
            If operacion = "A" Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtCampo(ICampo).Text = VGACatalogo.Codigo
                If ICampo > 0 Then lblDescripcion(ICampo).Text = VGACatalogo.Descripcion
            Else
                If ICampo > 0 Then PMMapeaObjeto(sqlconn, lblDescripcion(ICampo))
                PMChequea(sqlconn)
            End If
            If txtCampo(ICampo).Text.Trim() = "" Then
                If ICampo > 0 Then lblDescripcion(ICampo).Text = ""
                If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                    txtCampo(ICampo).Focus()
                End If
            End If
        Else
            PMChequea(sqlconn)
            lblDescripcion(ICampo).Text = ""
        End If
    End Sub

    Sub PMTransaccion(ByRef ICampo As Integer, ByRef IProducto As Integer, ByRef operacion As String, ByRef Transaccion As String)
        If txtCampo(IProducto).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502983), My.Application.Info.ProductName)
            If txtCampo(IProducto).Enabled And txtCampo(IProducto).Visible Then
                txtCampo(ICampo).Text = ""
                If ICampo > 0 Then lblDescripcion(ICampo).Text = ""
                txtCampo(IProducto).Focus()
            End If
            Exit Sub
        End If
        VLPaso = True
        If operacion = "S" Then
            VGOperacion = "sp_pro_transaccion"
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15020")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, operacion)
            PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "9")
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(IProducto).Text)
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "R")
            PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
            PMPasoValores(sqlconn, "@i_transaccion", 0, SQLINT4, "0")
            VGProductoConta = txtCampo(IProducto).Text 'JSA
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_pro_transaccion", True, FMLoadResString(502984)) Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtCampo(ICampo).Text = VGACatalogo.Codigo
                If ICampo > 0 Then lblDescripcion(ICampo).Text = VGACatalogo.Descripcion
                If txtCampo(ICampo).Text.Trim() = "" Then
                    txtCampo(ICampo).Text = ""
                    If ICampo > 0 Then lblDescripcion(ICampo).Text = ""
                    If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                        txtCampo(ICampo).Focus()
                    End If
                End If
            Else
                PMChequea(sqlconn)
                lblDescripcion(ICampo).Text = ""
            End If
        Else
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "494")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, operacion)
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, Transaccion)
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then
                If ICampo > 0 Then PMMapeaObjeto(sqlconn, lblDescripcion(ICampo))
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
                txtCampo(ICampo).Text = ""
                If ICampo > 0 Then lblDescripcion(ICampo).Text = ""
                If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                    txtCampo(ICampo).Focus()
                End If
            End If
        End If
    End Sub

    Sub PMPerfil(ByRef ICampo As Integer, ByRef IProducto As Integer)
        If txtCampo(IProducto).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(503318), My.Application.Info.ProductName)
            If txtCampo(IProducto).Enabled And txtCampo(IProducto).Visible Then
                txtCampo(IProducto).Focus()
            End If
            Exit Sub
        End If
        VLPaso = True
        VGOperacion = "sp_perfil"
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6907")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "0")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(IProducto).Text)
        PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_perfil", 0, SQLVARCHAR, "%")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_perfil", True, FMLoadResString(2277)) Then
            PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
            PMChequea(sqlconn)
            FCatalogo.ShowPopup(Me)
            txtCampo(ICampo).Text = VGACatalogo.Codigo
            If ICampo > 0 Then lblDescripcion(ICampo).Text = VGACatalogo.Descripcion
            txtCampo(ICampo).Text = VGACatalogo.Descripcion
            If ICampo > 0 Then lblDescripcion(ICampo).Text = ""
            If txtCampo(ICampo).Text.Trim() = "" And txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                txtCampo(ICampo).Focus()
            End If
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Sub PMCatalogo(ByRef ICampo As Integer, ByRef Tabla As String, ByRef operacion As String, ByRef Codigo As String)
        VGOperacion = ""
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, Tabla)
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, operacion)
        If operacion = "V" Then
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, Codigo)
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502985) & "[" & txtCampo(ICampo).Text & "]") Then
            If operacion = "A" Then
                VLPaso = True
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtCampo(ICampo).Text = VGACatalogo.Codigo
                If ICampo > 0 Then lblDescripcion(ICampo).Text = VGACatalogo.Descripcion
            Else
                If ICampo > 0 Then PMMapeaObjeto(sqlconn, lblDescripcion(ICampo))
                PMChequea(sqlconn)
            End If
            If txtCampo(ICampo).Text.Trim() = "" Then
                If ICampo > 0 Then lblDescripcion(ICampo).Text = ""
                If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                    txtCampo(ICampo).Focus()
                End If
            End If
        Else
            PMChequea(sqlconn)
            lblDescripcion(ICampo).Text = ""
        End If
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_4.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_5.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTRespuesta As Integer = 0
        Select Case Index
            Case 0
                PLIngresar()
            Case 1
                PLLimpiar()
            Case 2
                PLSalir()
            Case 3
                VTRespuesta = COBISMessageBox.Show(FMLoadResString(508905), FMLoadResString(502826), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Error)
                If VTRespuesta = 6 Then
                    GrdPerfiles.Col = 5
                    VLSecuencia = GrdPerfiles.CtlText.Trim()
                    PLEliminar()
                End If
            Case 4
                GrdPerfiles.Col = 5
                VLSecuencia = GrdPerfiles.CtlText.Trim()
                PLActualizar()
            Case 5
                PLBuscar()
        End Select
    End Sub

    Private Sub PLActualizar()
        If Not FMValidaEntradas() Then Exit Sub
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "720")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
        PMPasoValores(sqlconn, "@i_secuencia", 0, SQLINT4, CStr(VLSecuencia))
        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(1).Text.Trim())
        PMPasoValores(sqlconn, "@i_transaccion", 0, SQLINT2, txtCampo(3).Text.Trim())
        PMPasoValores(sqlconn, "@i_perfil", 0, SQLVARCHAR, txtCampo(0).Text.Trim())
        PMPasoValores(sqlconn, "@i_tipo_trn", 0, SQLVARCHAR, txtCampo(2).Text.Trim())
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_par_perfil", True, FMLoadResString(508877)) Then
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        PLLimpiar()
        PLBuscar()
    End Sub

    Private Sub PLEliminar()
        If Not FMValidaEntradas() Then Exit Sub
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "720")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
        PMPasoValores(sqlconn, "@i_secuencia", 0, SQLINT4, CStr(VLSecuencia))
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_par_perfil", True, FMLoadResString(508905)) Then
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        cmdBoton(3).Enabled = False
        PLLimpiar()
        PLBuscar()
        PLTSEstado()
    End Sub

    Private Sub PLIngresar()
        If Not FMValidaEntradas() Then Exit Sub
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "720")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(1).Text.Trim())
        PMPasoValores(sqlconn, "@i_transaccion", 0, SQLINT2, txtCampo(3).Text.Trim())
        PMPasoValores(sqlconn, "@i_perfil", 0, SQLVARCHAR, txtCampo(0).Text.Trim())
        PMPasoValores(sqlconn, "@i_tipo_trn", 0, SQLVARCHAR, txtCampo(2).Text.Trim())
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_par_perfil", True, FMLoadResString(508905)) Then
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        cmdBoton(0).Enabled = False
        PLLimpiar()
        PLBuscar()
        PLTSEstado()
    End Sub

    Private Function FMValidaEntradas() As Integer
        Dim result As Integer = 0
        result = False
        If txtCampo(1).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508909), FMLoadResString(502550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            txtCampo(1).Focus()
            Return result
        End If
        If txtCampo(3).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508910), FMLoadResString(502550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            txtCampo(3).Focus()
            Return result
        End If
        If txtCampo(0).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508911), FMLoadResString(502550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            txtCampo(0).Focus()
            Return result
        End If
        If txtCampo(2).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508912), FMLoadResString(502550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            txtCampo(2).Focus()
            Return result
        End If
        Return True
    End Function

    Private Sub PLBuscar()
        Dim VTSig As Integer = 0
        PMLimpiaG(GrdPerfiles)
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "721")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_transaccion", 0, SQLINT2, txtCampo(3).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_par_perfil", True, FMLoadResString(502827)) Then
            PMMapeaGrid(sqlconn, GrdPerfiles, False)
            PMAnchoColumnasGrid(GrdPerfiles)
            PMChequea(sqlconn)
            VTSig = True
            Do While VTSig And GrdPerfiles.Rows - 1 > 1 And CDbl(Convert.ToString(GrdPerfiles.Tag)) = 20
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "721")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_transaccion", 0, SQLINT2, txtCampo(3).Text)
                GrdPerfiles.Col = 5
                GrdPerfiles.Row = GrdPerfiles.Rows - 1
                If GrdPerfiles.CtlText.Trim() <> "" Then
                    PMPasoValores(sqlconn, "@i_secuencia", 0, SQLINT4, GrdPerfiles.CtlText.Trim())
                End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_par_perfil", True, FMLoadResString(508913)) Then
                    PMMapeaGrid(sqlconn, GrdPerfiles, True)
                    PMAnchoColumnasGrid(GrdPerfiles)
                    PMChequea(sqlconn)
                    VTSig = CDbl(Convert.ToString(GrdPerfiles.Tag)) = 20
                Else
                    PMChequea(sqlconn)
                    VTSig = False
                End If
            Loop
            GrdPerfiles.ColIsVisible.Set(5, False)
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLLimpiar()
        For i As Integer = 0 To 3
            txtCampo(i).Text = ""
        Next
        For i As Integer = 1 To 3
            lblDescripcion(i).Text = ""
        Next
        PMLimpiaG(GrdPerfiles)
        VLSecuencia = 0
        cmdBoton(5).Enabled = True
        cmdBoton(0).Enabled = True
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
        txtCampo(1).Focus()
        PLTSEstado()
    End Sub

    Private Sub PLSalir()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        Me.Close()
    End Sub

    Private Sub FPerfil_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        PLLimpiar()
    End Sub

    Private Sub GrdPerfiles_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles GrdPerfiles.Click
        PMLineaG(GrdPerfiles)
    End Sub

    Private Sub GrdPerfiles_ClickEvent(sender As Object, e As EventArgs) Handles GrdPerfiles.ClickEvent
        PMMarcaFilaCobisGrid(GrdPerfiles, GrdPerfiles.Row)
    End Sub

    Private Sub GrdPerfiles_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles GrdPerfiles.DblClick
        PMMarcaFilaCobisGrid(GrdPerfiles, GrdPerfiles.Row)
        Dim VTArreglo(10) As String
        Dim VTR As Integer = 0
        Dim VTRow As Integer = GrdPerfiles.Row
        If VTRow > 0 And GrdPerfiles.CtlText <> "" Then
            cmdBoton(0).Enabled = False
            cmdBoton(3).Enabled = True
            cmdBoton(4).Enabled = True
            PMLineaG(GrdPerfiles)
            GrdPerfiles.Col = 5
            GrdPerfiles.Row = VTRow
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "721")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
            If GrdPerfiles.CtlText.Trim() <> "" Then
                PMPasoValores(sqlconn, "@i_secuencia", 0, SQLINT4, GrdPerfiles.CtlText.Trim())
            End If
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_par_perfil", True, FMLoadResString(508885)) Then
                VTR = FMMapeaArreglo(sqlconn, VTArreglo)
                PMChequea(sqlconn)
                If VTR > 0 Then
                    VLSecuencia = CInt(GrdPerfiles.CtlText.Trim())
                    txtCampo(1).Text = VTArreglo(1).Trim()
                    txtCampo_Leave(txtCampo(1), New EventArgs())
                    txtCampo(3).Text = VTArreglo(2).Trim()
                    txtCampo_Leave(txtCampo(3), New EventArgs())
                    txtCampo(0).Text = VTArreglo(3).Trim()
                    txtCampo_Leave(txtCampo(0), New EventArgs())
                    txtCampo(2).Text = VTArreglo(4).Trim()
                    txtCampo_Leave(txtCampo(2), New EventArgs())
                End If
            Else
                PMChequea(sqlconn)
            End If
        End If
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_Enter(ByVal eventSender As Object, e As EventArgs) Handles _txtCampo_0.Enter, _txtCampo_3.Enter, _txtCampo_1.Enter, _txtCampo_2.Enter

        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501950)) 'perfil 509064
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509064)) 'PRODUCTO BANCARIO 509064
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509063)) 'tipo transaccion
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509065)) 'TRANSACCION  
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.TextChanged, _txtCampo_0.TextChanged, _txtCampo_1.TextChanged, _txtCampo_3.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If txtCampo(Index).Text.Trim() = "" And Index > 0 Then
            lblDescripcion(Index).Text = ""
            If Index = 1 Then
                txtCampo(0).Text = ""
                txtCampo(3).Text = ""
                txtCampo(2).Text = ""
                PMLimpiaG(GrdPerfiles)
            End If
        End If
        VLPaso = False
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_2.KeyDown, _txtCampo_0.KeyDown, _txtCampo_1.KeyDown, _txtCampo_3.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            Select Case Index
                Case 0
                    PMPerfil(Index, 1)
                Case 1
                    PMProducto(Index, "A", "")
                Case 2
                    PMCatalogo(Index, "re_tipo_trn", "A", "")
                Case 3
                    PMTransaccion(Index, 1, "S", "")
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_2.KeyPress, _txtCampo_0.KeyPress, _txtCampo_1.KeyPress, _txtCampo_3.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 2
                KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
            Case 1, 3
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Leave, _txtCampo_0.Leave, _txtCampo_1.Leave, _txtCampo_3.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Not VLPaso Then
            If txtCampo(Index).Text.Trim() <> "" Then
                Select Case Index
                    Case 0
                    Case 1
                        PMProducto(Index, "V", txtCampo(Index).Text)
                    Case 2
                        PMCatalogo(Index, "re_tipo_trn", "V", txtCampo(Index).Text)
                    Case 3
                        PMTransaccion(Index, 1, "H", txtCampo(Index).Text)
                End Select
                If lblDescripcion(Index).Text = "" Then txtCampo(Index).Text = ""
            End If
        End If
    End Sub

    Private Sub PLTSEstado()
        TSBCrear.Enabled = _cmdBoton_0.Enabled
        TSBCrear.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBEliminar.Enabled = _cmdBoton_3.Enabled
        TSBEliminar.Visible = _cmdBoton_3.Visible
        TSBActualizar.Enabled = _cmdBoton_4.Enabled
        TSBActualizar.Visible = _cmdBoton_4.Visible
        TSBBuscar.Enabled = _cmdBoton_5.Enabled
        TSBBuscar.Visible = _cmdBoton_5.Visible
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub GrdPerfiles_Enter(sender As Object, e As EventArgs) Handles GrdPerfiles.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508859))
    End Sub

    Private Sub GrdPerfiles_Leave(sender As Object, e As EventArgs) Handles GrdPerfiles.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class