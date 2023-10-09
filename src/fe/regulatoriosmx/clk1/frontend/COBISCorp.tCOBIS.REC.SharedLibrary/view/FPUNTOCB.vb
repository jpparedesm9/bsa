Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Partial Public Class FPUNTOCBClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLOperacion As String = ""
    Dim VLValida As Boolean = False
    Dim VLTipoDoc As String = ""
    Dim VLPaso As Integer = 0
    Dim VGNumero As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_4.Click, _cmdBoton_5.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TBSBotones.Focus()
        Select Case Index
            Case 0
                PLBuscar()
            Case 1
                PLSiguientes()
            Case 2
                If VLOperacion = "I" Then
                    PLTransmitir()
                End If
                If VLOperacion = "U" Then
                    PLModificar()
                End If
            Case 4
                PLLimpiar()
            Case 5
                Me.Close()
        End Select
    End Sub

    Sub PLSiguientes()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "397")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_codigo_cb", 0, SQLINT4, CStr(VGCorresponsal))
        grdPuntos.Row = grdPuntos.Rows - 1
        grdPuntos.Col = grdPuntos.Cols - 1
        PMPasoValores(sqlconn, "@i_codigo_punto", 0, SQLVARCHAR, grdPuntos.CtlText)
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "1")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_punto_red_cb", True, "") Then
            PMMapeaGrid(sqlconn, grdPuntos, True)
            PMChequea(sqlconn)
            cmdBoton(1).Enabled = Conversion.Val(Convert.ToString(grdPuntos.Tag)) = 20
            PLTSEstado()
            grdPuntos.Col = 11
            grdPuntos.ColIsVisible(11) = False 'grdPuntos.ColWidth(11) = 1
            grdPuntos.Col = 5
            grdPuntos.Col = 7
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Sub PLLimpiar()
        VLOperacion = "I"
        txtNombre.Text = ""
        txtCodPunto.Enabled = True
        txtCodPunto.Text = ""
        txtTipoDoc.Text = ""
        lblDescTipoDoc.Text = ""
        txtNumDoc.Enabled = True
        txtNumDoc.Mask = ""
        txtNumDoc.Text = ""
        txtDepto.Text = ""
        lblDepartamento.Text = ""
        txtCiudad.Text = ""
        lblCiudad.Text = ""
        txtDireccion.Text = ""
        txtEstado.Text = "H"
        txtEstado_Leave(txtEstado, New EventArgs())
        txtEstado.Enabled = False
        PMLimpiaG(grdPuntos)
        cmdBoton(1).Enabled = False
        cmdBoton(2).Enabled = True
        txtCodPunto.Focus()
        PLTSEstado()
    End Sub

    Sub PLBuscar()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "397")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_codigo_cb", 0, SQLVARCHAR, CStr(VGCorresponsal))
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "0")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_punto_red_cb", True, "") Then
            PMMapeaGrid(sqlconn, grdPuntos, False)
            PMChequea(sqlconn)
            cmdBoton(1).Enabled = Conversion.Val(Convert.ToString(grdPuntos.Tag)) = 20
            grdPuntos.ColIsVisible(11) = False
            If Conversion.Val(Convert.ToString(grdPuntos.Tag)) > 20 Then
                grdPuntos.Col = 11
                grdPuntos.Col = 5
                grdPuntos.Col = 7
            End If
            PLTSEstado()
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub FPUNTOCB_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" 'JSA
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar() 'JSA
        cmdBoton(1).Enabled = False
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()

        VLOperacion = "I"
        txtEstado.Text = "H"
        txtEstado_Leave(txtEstado, New EventArgs())
        txtEstado.Enabled = False
        cmdBoton(4).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub grdPuntos_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdPuntos.DblClick
        txtEstado.Enabled = True
        VLOperacion = "U"
        grdPuntos.Col = 11
        grdPuntos.ColWidth(11) = 1
        VLTipoDoc = grdPuntos.CtlText
        If VLTipoDoc = "C" Then
            OptPersona(1).Checked = True
        Else
            OptPersona(0).Checked = True
        End If
        grdPuntos.Col = 1
        txtCodPunto.Text = grdPuntos.CtlText
        txtCodPunto.Enabled = False
        grdPuntos.Col = 2
        txtNombre.Text = grdPuntos.CtlText
        grdPuntos.Col = 3
        txtTipoDoc.Text = grdPuntos.CtlText
        txtTipoDoc_Leave(txtTipoDoc, New EventArgs())
        grdPuntos.Col = 4
        txtNumDoc.Mask = ""
        txtNumDoc.Text = grdPuntos.CtlText
        txtNumDoc_Leave(txtNumDoc, New EventArgs())
        grdPuntos.Col = 5
        'grdPuntos.ColWidth(5) = 1
        txtDepto.Text = grdPuntos.CtlText
        grdPuntos.Col = 6
        lblDepartamento.Text = grdPuntos.CtlText
        grdPuntos.Col = 7
        txtCiudad.Text = grdPuntos.CtlText
        grdPuntos.Col = 8
        lblCiudad.Text = grdPuntos.CtlText
        grdPuntos.Col = 9
        txtDireccion.Text = grdPuntos.CtlText
        grdPuntos.Col = 10
        txtEstado.Text = Strings.Mid(grdPuntos.CtlText, 1, 1)
        txtEstado_Leave(txtEstado, New EventArgs())
    End Sub

    Private Sub txtCiudad_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCiudad.Enter

        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2452))
    End Sub

    Private Sub txtCiudad_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtCiudad.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim VTValor As String = ""
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
            PMPasoValores(sqlconn, "@i_provincia", 0, SQLINT2, txtDepto.Text)
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1300")
            PMPasoValores(sqlconn, "@i_pais", 0, SQLINT2, CStr(1))
            PMHelpG("cobis", "sp_ciuxdept", 6, 1)
            PMBuscarG(1, "@i_operacion", "H", SQLCHAR)
            PMBuscarG(2, "@i_tipo", "A", SQLCHAR)
            PMBuscarG(3, "@i_modo", "0", SQLINT1)
            PMBuscarG(4, "@t_trn", "1300", SQLINT2)
            PMBuscarG(5, "@i_pais", VGPais, SQLINT2)
            VTValor = txtDepto.Text
            PMBuscarG(6, "@i_provincia", VTValor, SQLINT2)
            PMSigteG(1, "@i_ciudad", 1, SQLINT4)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_ciuxdept", True, FMLoadResString(508921)) Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMChequea(sqlconn)
                PMProcesG()
                grid_valores.gr_SQL.ColWidth(1) = 800
                grid_valores.gr_SQL.ColWidth(2) = 2600
                grid_valores.gr_SQL.ColWidth(3) = 2600
                grid_valores.ShowPopup(Me)
                If Temporales(1) <> "" Then
                    txtCiudad.Text = Temporales(1)
                    lblCiudad.Text = Temporales(2)
                    VLPaso = True
                    SendKeys.Send("{TAB}")
                End If
            Else
                PMChequea(sqlconn)
                VLPaso = False
            End If
        End If
    End Sub

    Private Sub txtCiudad_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCiudad.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCiudad_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCiudad.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim VTArreglo(2) As String
        txtCiudad.Text = txtCiudad.Text.Trim()
        If txtCiudad.Text <> "" Then
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
            PMPasoValores(sqlconn, "@i_pais", 0, SQLINT2, VGPais)
            PMPasoValores(sqlconn, "@i_provincia", 0, SQLINT2, txtDepto.Text)
            PMPasoValores(sqlconn, "@i_ciudad", 0, SQLINT4, txtCiudad.Text)
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1300")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_ciuxdept", True, FMLoadResString(508921)) Then
                FMMapeaArreglo(sqlconn, VTArreglo)
                lblCiudad.Text = VTArreglo(1)
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
                txtCiudad.Text = ""
                lblCiudad.Text = ""
                txtCiudad.Focus()
                txtCiudad.Refresh()
            End If
        Else
            txtCiudad.Text = txtCiudad.Text.Trim()
            lblCiudad.Text = ""
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCodPunto_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCodPunto.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        If txtCodPunto.Text <> "" Then
            cmdBoton(4).Enabled = True
            PLTSEstado()
        End If
    End Sub

    Private Sub txtCodPunto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCodPunto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2447))
    End Sub

    Private Sub txtCodPunto_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCodPunto.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCodPunto_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCodPunto.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim VTR1 As Integer = 0
        If txtCodPunto.Text <> "" Then
            Dim VTArreglo(50) As String
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "397")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "Q")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, CStr(0))
            PMPasoValores(sqlconn, "@i_codigo_cb", 0, SQLVARCHAR, CStr(VGCorresponsal))
            PMPasoValores(sqlconn, "@i_codigo_punto", 0, SQLVARCHAR, txtCodPunto.Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_punto_red_cb", True, FMLoadResString(508939)) Then
                VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
                PMChequea(sqlconn)
                If VTR1 = 0 Then
                    VLOperacion = "I"
                Else
                    VLOperacion = "U"
                    txtCodPunto.Enabled = False
                    txtEstado.Enabled = True
                End If
                If VTArreglo(12) = "C" Then
                    OptPersona(1).Checked = True
                Else
                    OptPersona(0).Checked = True
                End If
                txtNombre.Text = VTArreglo(2)
                txtTipoDoc.Text = VTArreglo(3)
                txtTipoDoc_Leave(txtTipoDoc, New EventArgs())
                txtNumDoc.Mask = ""
                txtNumDoc.Text = VTArreglo(4)
                txtDepto.Text = VTArreglo(5)
                lblDepartamento.Text = VTArreglo(6)
                txtCiudad.Text = VTArreglo(7)
                lblCiudad.Text = VTArreglo(8)
                txtDireccion.Text = VTArreglo(9)
                If VTArreglo(10) = "" Then
                    txtEstado.Text = "H"
                    txtEstado_Leave(txtEstado, New EventArgs())
                Else
                    txtEstado.Text = Strings.Mid(VTArreglo(10), 1, 1)
                    txtEstado_Leave(txtEstado, New EventArgs())
                End If
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Private Sub txtDepto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtDepto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2451))
    End Sub

    Private Sub txtDepto_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtDepto.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
            PMPasoValores(sqlconn, "@i_pais", 0, SQLINT2, "1")
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1550")
            PMHelpG("cobis", "sp_provincia", 5, 1)
            PMBuscarG(1, "@i_operacion", "H", SQLCHAR)
            PMBuscarG(2, "@i_tipo", "A", SQLCHAR)
            PMBuscarG(3, "@i_modo", "0", SQLINT1)
            PMBuscarG(4, "@i_pais", "1", SQLINT2)
            PMBuscarG(5, "@t_trn", "1550", SQLINT2)
            PMSigteG(1, "@i_provincia", 1, SQLINT2)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_provincia", True, FMLoadResString(508922)) Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMChequea(sqlconn)
                PMProcesG()
                grid_valores.ShowPopup(Me)
                If Temporales(1) <> "" Then
                    txtDepto.Text = Temporales(1)
                    lblDepartamento.Text = Temporales(2)
                    VLPaso = True
                    SendKeys.Send("{TAB}")
                End If
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Private Sub txtDepto_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtDepto.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtDepto_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtDepto.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim VTArreglo(2) As String
        txtDepto.Text = txtDepto.Text.Trim()
        If txtDepto.Text <> "" Then
            If Conversion.Val(txtDepto.Text) > 32500 Then
                COBISMessageBox.Show(FMLoadResString(508932), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                txtDepto.Text = ""
                lblDepartamento.Text = ""
                txtDepto.Focus()
                VLPaso = True
                Exit Sub
            End If
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
            PMPasoValores(sqlconn, "@i_pais", 0, SQLINT2, CStr(1))
            PMPasoValores(sqlconn, "@i_provincia", 0, SQLINT2, txtDepto.Text)
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1550")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_provincia", True, FMLoadResString(508922)) Then
                FMMapeaArreglo(sqlconn, VTArreglo)
                PMChequea(sqlconn)
                lblDepartamento.Text = VTArreglo(1)
            Else
                PMChequea(sqlconn)
                txtDepto.Text = ""
                lblDepartamento.Text = ""
                txtDepto.Focus()
                VLPaso = True
            End If
            PMChequea(sqlconn)
        Else
            txtDepto.Text = txtDepto.Text.Trim()
            lblDepartamento.Text = ""
        End If
    End Sub

    Private Sub txtDireccion_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtDireccion.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2453))
    End Sub

    Private Sub txtDireccion_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtDireccion.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
        KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtEstado_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtEstado.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And (KeyAscii < 65 Or KeyAscii > 90) And (KeyAscii < 97 Or KeyAscii > 122) Then
            KeyAscii = 0
        Else
            KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtNombre_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtNombre.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2448))
    End Sub

    Private Sub txtNombre_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtNombre.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
        KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtNumDoc_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtNumDoc.Enter
        If txtNumDoc.ClipText <> "" Then
            VGNumero = txtNumDoc.ClipText
            VGNumero = txtNumDoc.Text
            VGNumero = FMGet_Numero(VGNumero)
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2450))
        VLPaso = True
    End Sub

    Private Sub txtNumDoc_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtNumDoc.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        'KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtNumDoc_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtNumDoc.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        If Not VLPaso Then
            If txtNumDoc.ClipText <> "" And txtTipoDoc.Text <> "" Then
                VGNumero = txtNumDoc.ClipText
                VGNumero = FMGet_Numero(VGNumero)
                VGNumero = VGNumero.TrimStart()
                If txtNumDoc.ClipText = "" And txtTipoDoc.Text <> "" Then
                    COBISMessageBox.Show(FMLoadResString(508934), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    Exit Sub
                End If
            Else
                If Conversion.Val(txtNumDoc.ClipText) = 0 And txtTipoDoc.Text <> "" Then
                    COBISMessageBox.Show(FMLoadResString(508933), My.Application.Info.ProductName)
                    txtNumDoc.Focus()
                    Exit Sub
                End If
            End If
        End If
    End Sub

    Public Sub VLControlNIT()
        Dim VLNitc As String = ""
        Dim VTResul As Integer = 0
        If txtNumDoc.ClipText <> "" Then
            If VGMTipoDoc(7) = "S" Then
                VLNitc = txtNumDoc.ClipText
                VLNitc = FMGet_Numero(VLNitc)
                VTResul = FMValidaNit(VLNitc)
                If VTResul = 0 Then
                    COBISMessageBox.Show(FMLoadResString(508926), My.Application.Info.ProductName)
                    txtNumDoc.Visible = True
                    txtNumDoc.Focus()
                    Exit Sub
                End If
            End If
            PLValidaDocP(VLNitc)
        End If
    End Sub

    Private Sub txtTipoDoc_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtTipoDoc.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2449))
    End Sub

    Private Sub txtTipoDoc_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtTipoDoc.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1115")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            If OptPersona(0).Checked Then
                PMPasoValores(sqlconn, "@i_subtipo", 0, SQLCHAR, "P")
            Else
                PMPasoValores(sqlconn, "@i_subtipo", 0, SQLCHAR, "C")
            End If
            PMHelpG("cobis", "sp_tipodoc", 3, 1)
            PMBuscarG(1, "@t_trn", "1115", SQLINT2)
            PMBuscarG(2, "@i_tipo", "A", SQLCHAR)
            If OptPersona(0).Checked Then
                PMBuscarG(3, "@i_subtipo", "P", SQLCHAR)
            Else
                PMBuscarG(3, "@i_subtipo", "C", SQLCHAR)
            End If
            PMSigteG(1, "@i_codigo", 1, SQLCHAR)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_tipodoc", True, FMLoadResString(508923)) Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMChequea(sqlconn)
                PMProcesG()
                grid_valores.ShowPopup(Me)
                If Temporales(1) <> "" Then
                    txtTipoDoc.Text = Temporales(1)
                    lblDescTipoDoc.Text = Temporales(2)
                    If OptPersona(1).Checked Then
                        Dim VTMatriz(7, 1) As String
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1115")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_subtipo", 0, SQLVARCHAR, "C")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtTipoDoc.Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_tipodoc", True, FMLoadResString(508924)) Then
                            FMMapeaMatriz(sqlconn, VTMatriz)
                            txtNumDoc.MaxLength = CInt(VTMatriz(2, 1))
                            txtNumDoc.Mask = VTMatriz(1, 1)
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            VLPaso = False
                            txtTipoDoc_Leave(txtTipoDoc, New EventArgs())
                        End If
                    End If
                    If txtTipoDoc.Text <> "" Then
                        If OptPersona(0).Checked Then
                            PMValida_TipoDoc(txtTipoDoc.Text, "P")
                        Else
                            PMValida_TipoDoc(txtTipoDoc.Text, "C")
                        End If
                        lblDescTipoDoc.Text = VGMTipoDoc(1)
                        VLPaso = True
                    End If
                    VLPaso = True
                    If Convert.ToString(Tag) = "U" Then
                    Else
                        txtNumDoc.Mask = VGMTipoDoc(2)
                    End If
                    SendKeys.Send("{TAB}")
                Else
                    VLPaso = False
                    If txtTipoDoc.Text <> "" Then
                        txtTipoDoc_Leave(txtTipoDoc, New EventArgs())
                    End If
                End If
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Private Sub txtTipoDoc_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtTipoDoc.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And (KeyAscii < 65 Or KeyAscii > 90) And (KeyAscii < 97 Or KeyAscii > 122) Then
            KeyAscii = 0
        Else
            KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtTipoDoc_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtTipoDoc.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        If Not VLPaso Then
            If txtTipoDoc.Text <> "" Then
                If OptPersona(0).Checked Then
                    PMValida_TipoDoc(txtTipoDoc.Text, "P")
                Else
                    PMValida_TipoDoc(txtTipoDoc.Text, "C")
                End If
                If VGMTipoDoc(1) = "" Then
                    txtTipoDoc.Text = ""
                    lblDescTipoDoc.Text = ""
                    If txtTipoDoc.Enabled Then
                        txtTipoDoc.Focus()
                        Exit Sub
                    End If
                End If
                lblDescTipoDoc.Text = VGMTipoDoc(1)
                VLPaso = True
                If Convert.ToString(Tag) = "U" Then
                Else
                    txtNumDoc.Mask = VGMTipoDoc(2)
                End If
            Else
                lblDescTipoDoc.Text = ""
            End If
        End If
    End Sub

    Sub PLModificar()
        PLValidarCampos()
        If VLValida Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "397")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, VLOperacion)
            PMPasoValores(sqlconn, "@i_codigo_punto", 0, SQLVARCHAR, txtCodPunto.Text)
            PMPasoValores(sqlconn, "@i_codigo_cb", 0, SQLVARCHAR, CStr(VGCorresponsal))
            PMPasoValores(sqlconn, "@i_nombre", 0, SQLVARCHAR, txtNombre.Text)
            PMPasoValores(sqlconn, "@i_tipo_ced", 0, SQLVARCHAR, txtTipoDoc.Text)
            PMPasoValores(sqlconn, "@i_ced_ruc", 0, SQLVARCHAR, txtNumDoc.ClipText)
            PMPasoValores(sqlconn, "@i_cod_depto", 0, SQLVARCHAR, txtDepto.Text)
            PMPasoValores(sqlconn, "@i_cod_ciudad", 0, SQLVARCHAR, txtCiudad.Text)
            PMPasoValores(sqlconn, "@i_direccion", 0, SQLVARCHAR, txtDireccion.Text)
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, txtEstado.Text)
            If OptPersona(0).Checked Then
                PMPasoValores(sqlconn, "@i_tipo_p", 0, SQLCHAR, "P")
            Else
                PMPasoValores(sqlconn, "@i_tipo_p", 0, SQLCHAR, "C")
            End If
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_punto_red_cb", True, "") Then
                PMChequea(sqlconn)
                COBISMessageBox.Show(FMLoadResString(508941), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                PLLimpiar()
                PLBuscar()
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Sub PLTransmitir()
        PLValidarCampos()
        If VLValida Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "397")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, VLOperacion)
            PMPasoValores(sqlconn, "@i_codigo_punto", 0, SQLVARCHAR, txtCodPunto.Text)
            PMPasoValores(sqlconn, "@i_codigo_cb", 0, SQLVARCHAR, CStr(VGCorresponsal))
            PMPasoValores(sqlconn, "@i_nombre", 0, SQLVARCHAR, txtNombre.Text)
            PMPasoValores(sqlconn, "@i_tipo_ced", 0, SQLVARCHAR, txtTipoDoc.Text)
            PMPasoValores(sqlconn, "@i_ced_ruc", 0, SQLVARCHAR, txtNumDoc.ClipText)
            PMPasoValores(sqlconn, "@i_cod_depto", 0, SQLVARCHAR, txtDepto.Text)
            PMPasoValores(sqlconn, "@i_cod_ciudad", 0, SQLVARCHAR, txtCiudad.Text)
            PMPasoValores(sqlconn, "@i_direccion", 0, SQLVARCHAR, txtDireccion.Text)
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, txtEstado.Text)
            If OptPersona(0).Checked Then
                PMPasoValores(sqlconn, "@i_tipo_p", 0, SQLCHAR, "P")
            Else
                PMPasoValores(sqlconn, "@i_tipo_p", 0, SQLCHAR, "C")
            End If
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_punto_red_cb", True, "") Then
                PMChequea(sqlconn)
                COBISMessageBox.Show(FMLoadResString(508940), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                PLLimpiar()
                PLBuscar()
                'cmdBoton(2).Enabled = False
            Else
                PMChequea(sqlconn)
            End If
            PLTSEstado()
        End If
    End Sub

    Sub PLValidarCampos()
        If txtCodPunto.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508927), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            txtCodPunto.Focus()
            cmdBoton(4).Enabled = False
            VLValida = False
            PLTSEstado()
            Exit Sub
        End If
        If txtNombre.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508929), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            txtNombre.Focus()
            VLValida = False
            Exit Sub
        End If
        If txtTipoDoc.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508931), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            txtTipoDoc.Focus()
            VLValida = False
            Exit Sub
        End If
        If txtNumDoc.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508930), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            txtNumDoc.Focus()
            VLValida = False
            Exit Sub
        End If
        If txtDepto.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508928), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            txtDepto.Focus()
            VLValida = False
            Exit Sub
        End If
        If txtCiudad.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508936), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            txtCiudad.Focus()
            VLValida = False
            Exit Sub
        End If
        If txtDireccion.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508937), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            txtDireccion.Focus()
            VLValida = False
            Exit Sub
        End If
        VLValida = True
    End Sub

    Private Sub txtEstado_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtEstado.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2454))
    End Sub

    Private Sub txtEstado_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtEstado.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            txtEstado.Text = ""
            lblEstado.Text = ""
            PMLimpiaG(grid_valores.gr_SQL)
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "re_estado_servicio")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(508920)) Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMChequea(sqlconn)
                PMProcesG()
                grid_valores.ShowPopup(Me)
                If Temporales(1) <> "" Then
                    txtEstado.Text = Temporales(1)
                    lblEstado.Text = Temporales(2)
                Else
                    txtEstado.Text = ""
                    txtEstado.Focus()
                    lblEstado.Text = ""
                End If
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Private Sub txtEstado_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtEstado.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        If Not VLPaso Then
            If txtEstado.Text <> "" Then
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "re_estado_servicio")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtEstado.Text)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502692) & " [" & txtEstado.Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblEstado)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    VLPaso = True
                    txtEstado.Text = ""
                    lblEstado.Text = ""
                End If
            Else
                lblEstado.Text = ""
            End If
        End If
    End Sub

    Public Sub PLValidaDocP(ByRef VLCedula As String)
        If txtTipoDoc.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508942), My.Application.Info.ProductName)
            If txtTipoDoc.Enabled Then txtTipoDoc.Focus()
            Exit Sub
        End If
        If VLCedula = "" Then
            COBISMessageBox.Show(FMLoadResString(508938), My.Application.Info.ProductName)
            If txtNumDoc.Enabled Then txtNumDoc.Focus()
            Exit Sub
        End If
    End Sub

    Public Sub VLValida_Cliente(ByRef VLCedula As Object)
        Dim VLTipDoc As String = ""
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "V")
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(105))
        PMPasoValores(sqlconn, "@i_ruc", 0, SQLVARCHAR, CStr(VLCedula))
        PMPasoValores(sqlconn, "@i_tipo_nit", 0, SQLVARCHAR, txtTipoDoc.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_compania_ins", True, FMLoadResString(501444)) Then
            PMMapeaVariable(sqlconn, VLTipDoc)
            PMChequea(sqlconn)
            If VLTipDoc <> "1" Then
                If COBISMessageBox.Show(FMLoadResString(508925), My.Application.Info.Title, COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Information) = System.Windows.Forms.DialogResult.No Then
                    txtNumDoc.Text = ""
                    Exit Sub
                End If
                If VLTipDoc = txtTipoDoc.Text Then
                    COBISMessageBox.Show(FMLoadResString(508935), My.Application.Info.ProductName)
                    Exit Sub
                End If
            End If
        Else
            PMChequea(sqlconn)
        End If
        PMChequea(sqlconn)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBSiguientes.Enabled = _cmdBoton_1.Enabled
        TSBSiguientes.Visible = _cmdBoton_1.Visible
        TBSTransmitir.Enabled = _cmdBoton_2.Enabled
        TBSTransmitir.Enabled = _cmdBoton_2.Enabled
        TBSLimpiar.Visible = _cmdBoton_4.Visible
        TBSLimpiar.Enabled = _cmdBoton_4.Enabled
        TBSSalir.Visible = _cmdBoton_5.Visible
        TBSSalir.Enabled = _cmdBoton_5.Enabled
    End Sub
    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TBSTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TBSTransmitir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TBSLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TBSLimpiar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TBSSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TBSSalir.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub OptPersona_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _OptPersona_0.Enter, _OptPersona_1.Enter

        Dim Index As Integer = Array.IndexOf(OptPersona, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2406))
            Case 1

                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2407))

        End Select
    End Sub

    Private Sub _OptPersona_0_Leave(sender As Object, e As EventArgs) Handles _OptPersona_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtDireccion_Leave(sender As Object, e As EventArgs) Handles txtDireccion.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdPuntos_Enter(sender As Object, e As EventArgs) Handles grdPuntos.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2220))
    End Sub

    Private Sub grdPuntos_Leave(sender As Object, e As EventArgs) Handles grdPuntos.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtTipoDoc_TextChanged(sender As Object, e As EventArgs) Handles txtTipoDoc.TextChanged
        VLPaso = False
    End Sub

    Private Sub txtNumDoc_TextChanged(sender As Object, e As EventArgs) Handles txtNumDoc.TextChanged
        VLPaso = False
    End Sub
End Class


