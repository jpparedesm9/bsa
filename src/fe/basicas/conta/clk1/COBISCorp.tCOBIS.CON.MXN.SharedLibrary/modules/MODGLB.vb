Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.VB
Imports Microsoft.VisualBasic
Imports System
Imports System.Text
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports Microsoft.Office.Interop
Imports COBISCorp.tCOBIS.CON.MXN.ToolBar
Imports COBISCorp.tCOBIS.CON.MXN.SharedLibrary

Public Module MODGLB
    Public ServerName As String = ""
    Public LoginID As String = ""
    Public VGLogin As String = ""
    Public Password As String = ""
    Public DatabaseName As String = ""
    Public HostName As String = ""
    Public VGEditando As Integer = 0
    Public VGPaso As Integer = 0
    Public VGPaso1 As Integer = 0
    Public VGOperacion As String = ""
    Public VGTipComAnt As String = ""
    Public VGADatosI() As String
    Public VGADatosO() As String
    Public VGAyuda() As String
    Public VGBusqueda() As String
    Public VGIdioma As String = ""
    Public VGTeclaAyuda As Integer = 0
    Public VGCuentaMovimientoIM As Integer = 0
    Public VGFormatoFechaStr As String = ""
    Public VGFormatoFechaInt As Integer
    Public VGIndice As Integer = 0
    Public VGConsComp As Integer = 0
    Public VGCaptura As Integer = 0
    Public VGListindex As Integer = 0
    Public ServerNameLocal As String = ""
    Public VGFormatoFecha As String = ""
    Public VGModificar As Integer = 0
    Public CambNatu As Integer = 0
    Public VGCuenta As String = ""
    Public VGTipo As String = ""
    Public VGTipo1 As String = ""
    Public VGComprobante As String = ""
    Public VGFechaComp As String = ""
    Public VGFecha As String = ""
    Public VGSaldo As String = ""
    Public VGTipo_ter As String = ""
    Public VGActividad As String = ""
    Public VGRetencion As String = ""
    Public VGvalor As String = ""
    Public Const VGMaximoRows As Integer = 21
    Public VGDebug As Boolean = False
    Public sqlconn As Integer = 0
    Public VLAbrir As Integer = 0
    Public Consulta As Integer = 0
    Public OficDest As String = ""
    Public VTasto1 As Integer = 0
    Public Eliminar As Integer = 0
    Public intFoco As Integer = 0
    Public EsCtaTercero As Integer = 0
    Public EsGeneral As Integer = 0
    Public EsCredito As Integer = 0
    Public Esdocumento As Integer = 0
    Public chrOperacion As String = ""
    Public VGEditar As Boolean = False
    Public VGImprimir As String = ""
    Public VGRespuesta As String = ""
    Public VGProducto As String = ""
    Public VGBanco As String = ""
    Public VGPais As String = ""
    Public VGForma As Integer = 0
    Public VGMov As String = ""
    Public VGAPerfil As String = ""
    Public VGTIMERMAIL As Integer = 0
    Public VGUsuario As String = ""
    Public VGUsuarioNombre As String = ""
    Public Valores() As String
    Public VGFechaProceso As String = ""
    Public VLEnte As String
    Public VGPantalla As Integer = 0
    Public VGArreglo(100, 100)
    Public VG_nlabels As Integer
    Public VGCatalogo(10, 500, 2) As String
    Public VGetiquetas(100) As String

    Public Structure Empresa
        Dim Codigo As String
        Dim Nombre As String
        Dim Mascara As String
        Dim Sinonimo As String
        Dim Moneda As String
        Public Shared Function CreateInstance() As Empresa
            Dim result As New Empresa
            result.Codigo = String.Empty
            result.Nombre = String.Empty
            result.Mascara = String.Empty
            result.Sinonimo = String.Empty
            result.Moneda = String.Empty
            Return result
        End Function
    End Structure

    Public VGEmpresa As Empresa = Empresa.CreateInstance()

    Structure CatalogoUsuario
        Dim Codigo As String
        Dim Descripcion As String
        Public Shared Function CreateInstance() As CatalogoUsuario
            Dim result As New CatalogoUsuario
            result.Codigo = String.Empty
            result.Descripcion = String.Empty
            Return result
        End Function
    End Structure

    Public Structure CBaseProc
        Dim base As String
        Dim procedure As String
        Public Shared Function CreateInstance() As CBaseProc
            Dim result As New CBaseProc
            result.base = String.Empty
            result.procedure = String.Empty
            Return result
        End Function
    End Structure

    Public VGFilial As String = ""
    Public VGOficina As String = ""
    Public VGOfiOrig As String = ""
    Public VGOfiConta As String = ""
    Public VGMoneda As String = ""
    Public VGRol As String = ""
    Public VGCorreo As Integer = 0
    Public VGflagp As String = ""
    Public VGSoloConsulta As Integer = 0
    Public VGOfAreaComun As Integer = 0
    Public VGEnter As Integer = 0
    Public VGCotizaciones() As String
    Public NroCotizaciones As Integer = 0
    Public Const CGWidth As Integer = 9420
    Public Const CGHeight As Integer = 5730
    Public Const CGLeft As Integer = 15
    Public Const CGTop As Integer = 15
    Public VGTerminalName As String = ""
    Public VGFactura(5) As String
    Public VGOnline As Integer = 0

    Public Structure Conciliacion
        Dim comprobante As String
        Dim asiento As String
        Dim Operacion As String
        Dim Documento As String
        Public Shared Function CreateInstance() As Conciliacion
            Dim result As New Conciliacion
            result.comprobante = String.Empty
            result.asiento = String.Empty
            result.Operacion = String.Empty
            result.Documento = String.Empty
            Return result
        End Function
    End Structure

    Public VGConciliacion() As Conciliacion = Nothing
    Private Sub cmbEmpresa_SelectedIndexChanged(ByVal sender As Object, ByVal e As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISToolEventArgs)
        Dim VTNiveles(30) As String
        Dim VTTemporal() As String
        Dim VTBandera As Boolean

        If VGEmpresa.Codigo = String.Empty Or VGEmpresa.Codigo = Nothing Then VTBandera = True

        PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "6030")
        PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "N")
        PMPasoValores(SqlConn, "@i_empresa", 0, SQLINT1, CStr(Conversion.Val(sender.SelectedItem.ToString())).TrimStart())
        If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_empresa", True, " Actualizando las variables de ambiente...") Then
            VGEmpresa.Codigo = CStr(Conversion.Val(sender.SelectedItem.ToString())).TrimStart()
            PMMapeaVariable(sqlconn, VGEmpresa.Nombre)
            Y = FMMapeaArreglo(sqlconn, VTNiveles)
            PMMapeaVariable(sqlconn, VGEmpresa.Mascara)
            PMMapeaVariable(sqlconn, VGEmpresa.Moneda)
            PMChequea(sqlconn)
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6336")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, CStr(Conversion.Val(sender.SelectedItem.ToString())).TrimStart())
            If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_mascara", True, " Actualizando las variables de ambiente...") Then
                ReDim VTTemporal(3)
                Y = FMMapeaArreglo(sqlconn, VTTemporal)
                PMChequea(sqlconn)
                If Y <> 0 Then
                    VGEmpresa.Sinonimo = VTTemporal(2)
                Else
                    VGEmpresa.Sinonimo = ""
                End If
            End If
            If Not VTBandera Then _
            COBISCorp.eCOBIS.COBISExplorer.Container.MultiPageContainer.COBISMultipageContainer.ClearPages()

        End If
    End Sub

    Function FMGetServer() As String
        If VGOnline Then
            Return ServerName
        Else
            Return ServerNameLocal
        End If
    End Function

    Function FLFFechaSys() As String
        Dim VLDefault As String = String.Empty
        Dim VLFecha As String = String.Empty
        Dim VLFileName As String = String.Empty
        Dim VLLong As Integer = 0
        Dim vlentry As String = String.Empty
        Dim VLSection As String = String.Empty
        VLSection = "intl"
        vlentry = "sShortDate"
        VLLong = 15
        VLFileName = "win.ini"
        VLFecha = New String(" "c, 15)
        VLDefault = "mm/dd/yyyy"
        VLFecha = Get_Preferencia(vlentry)
        VLFecha = IIf(VLFecha = "", "mm/dd/yyyy ", VLFecha)
        VLLong = VLFecha.Length - 1
        Return Strings.Mid(VLFecha, 1, VLLong)
    End Function

    Function FMMascara(ByRef Variable As String, ByRef Mascara As String) As String
        Dim VTDigito As String = ""
        Dim j As Integer = 0
        Dim VTtxt As New StringBuilder
        VTtxt = New StringBuilder("")
        If Variable = "" Then
            For i As Integer = 1 To Mascara.Length
                If Strings.Mid(Mascara, i, 1) = "#" Then
                    VTtxt.Append("_")
                Else
                    VTtxt.Append(".")
                End If
            Next i
        Else
            j = 1
            For i As Integer = 1 To Mascara.Length
                If Strings.Mid(Mascara, i, 1) = "#" Then
                    VTDigito = Strings.Mid(Variable, j, 1)
                    If VTDigito <> "" Then
                        VTtxt.Append(VTDigito)
                    Else
                        VTtxt.Append("_")
                    End If
                    j += 1
                Else
                    VTtxt.Append(".")
                End If
            Next i
        End If
        Return VTtxt.ToString()
    End Function

    Sub PMEmpresa()
        Dim COBISTool As ToolBar.ToolBar = New ToolBar.ToolBar
        COBISTool.Add()


        Dim ToolCmbEmpresa As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComboBoxTool = COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISMenu.GetCOBISComboBoxTool("cmbEmpresa", "gprHerramienta")
        AddHandler ToolCmbEmpresa.ToolValueChanged, AddressOf cmbEmpresa_SelectedIndexChanged
        ToolCmbEmpresa.SetPropertyValue("AutoComplete", True)

        Dim VTIndice As Integer = 0
        If VGIndice Then
            VTIndice = VGListindex
        Else
            VTIndice = ToolCmbEmpresa.GetPropertyValue("ValueList.SelectedIndex")
        End If
        'cmbEmpresa.Enabled = False
        'cmbEmpresa.Items.Clear()
        ToolCmbEmpresa.InvokeMethod("Clear", "ValueList.ValueListItems", New Object() {}, New Type() {})

        Dim VTEmpresa(20, 20) As String
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6037")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_empresa", True, " Actualizando las variables de ambiente...") Then
            Y = FMMapeaMatriz(sqlconn, VTEmpresa)
            PMChequea(sqlconn)
            If Y <> 0 Then
                For i As Integer = 1 To Y
                    ToolCmbEmpresa.InvokeMethod("Add", "ValueList.ValueListItems", New Object() {VTEmpresa(0, i) & " - " & VTEmpresa(1, i)}, New Type() {GetType(Object)})
                Next i
                If VTIndice > 0 Then
                    ToolCmbEmpresa.SetPropertyValue("ValueList.SelectedIndex", VTIndice)
                Else
                    ToolCmbEmpresa.SetPropertyValue("ValueList.SelectedIndex", 0)
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6030")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "N")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, CStr(Conversion.Val(ToolCmbEmpresa.GetPropertyValue("ValueList.SelectedItem").ToString)).TrimStart())
                If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_empresa", True, " Actualizando las variables de ambiente...") Then
                    VGEmpresa.Codigo = CStr(Conversion.Val(ToolCmbEmpresa.GetPropertyValue("ValueList.SelectedItem").ToString)).TrimStart()
                    PMMapeaVariable(sqlconn, VGEmpresa.Nombre)
                    Dim VTNiveles(20) As String
                    Y = FMMapeaArreglo(sqlconn, VTNiveles)
                    PMMapeaVariable(sqlconn, VGEmpresa.Mascara)
                    PMMapeaVariable(sqlconn, VGEmpresa.Moneda)
                    PMChequea(sqlconn)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6336")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, CStr(Conversion.Val(ToolCmbEmpresa.GetPropertyValue("ValueList.SelectedItem").ToString)).TrimStart())
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_mascara", True, " Actualizando las variables de ambiente...") Then
                        Dim VTTemporal(2) As String
                        Y = FMMapeaArreglo(sqlconn, VTTemporal)
                        PMChequea(sqlconn)
                        If Y <> 0 Then
                            VGEmpresa.Sinonimo = VTTemporal(2)
                        Else
                            VGEmpresa.Sinonimo = ""
                        End If
                    End If
                    'cmbEmpresa.Enabled = True
                End If
            Else
                VGEmpresa.Codigo = ""
                VGEmpresa.Nombre = ""
                VGEmpresa.Mascara = ""
                VGEmpresa.Sinonimo = ""
            End If
        Else
            VGEmpresa.Codigo = ""
            VGEmpresa.Nombre = ""
            VGEmpresa.Mascara = ""
            VGEmpresa.Sinonimo = ""
        End If
    End Sub

    Function FMTipoDato(ByRef Campo As Object, ByRef tipo As String) As Integer
        Dim result As Integer = 0
        result = False
        Select Case tipo
            Case "INT4"
                If Campo.Text <> "" Then
                    If (Campo.Text >= 0) And (Campo.Text <= 2147483648.0#) Then
                        result = True
                    Else
                        COBISMessageBox.Show("El valor debe estar comprendido entre [0-2147483648]", "Mensaje de Error", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Campo.Text = ""
                    End If
                End If
            Case "INT2"
                If Campo.Text <> "" Then
                    If (Campo.Text >= 0) And (Campo.Text <= 32767) Then
                        result = True
                    Else
                        COBISMessageBox.Show("El valor debe estar comprendido entre [0-32767]", "Mensaje de Error", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Campo.Text = ""
                        Campo.SetFocus()
                    End If
                End If
            Case "INT1"
                If Campo.Text <> "" Then
                    If (Conversion.Val(Campo.Text) >= 0) And (Conversion.Val(Campo.Text) <= 255) Then
                        result = True
                    Else
                        COBISMessageBox.Show("El valor debe estar comprendido entre [0-255]", "Mensaje de Error", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Campo.Text = ""
                    End If
                End If
        End Select
        Return result
    End Function

    Function FMVerificar_WinIni() As Integer
        Dim result As Integer = 0
        Dim VTFechaPref As String = String.Empty
        Dim VTiDate As String = String.Empty
        Dim VTMsg As String = ""
        Dim VTProblema As Integer = False
        result = False
        Select Case VGFormatoFecha
            Case "mm/dd/yyyy"
                VTFechaPref = "MM/dd/yyyy"
                VTiDate = "0"
            Case "dd/mm/yyyy"
                VTFechaPref = "dd/MM/yyyy"
                VTiDate = "1"
            Case Else
                VTFechaPref = "yyyy/MM/dd"
                VTiDate = "2"
        End Select
        Dim VTMillar As String = New String(Strings.Chr(32), 255)
        Dim VTDecimal As String = New String(Strings.Chr(32), 255)
        Dim VTFormatoFecha As String = New String(Strings.Chr(32), 255)
        VTMillar = FMGetSeparadorMiles()
        If VTMillar <> "," Then VTProblema = True
        VTDecimal = FMGetSeparadorDecimales()
        If VTDecimal <> "." Then VTProblema = True
        VTFormatoFecha = FMGetFormatoFecha()
        Select Case VTFormatoFecha
            Case "MM/dd/aaaa"
                VTFormatoFecha = "MM/dd/yyyy"
            Case "dd/MM/aaaa"
                VTFormatoFecha = "dd/MM/yyyy"
            Case "aaaa/MM/dd"
                VTFechaPref = "yyyy/MM/dd"
        End Select
        If VTFormatoFecha <> VTFechaPref Then VTProblema = True
        If VTProblema Then
            VTProblema = False
            VTMsg = "La configuración para números y fechas del Panel de Control de Windows es "
            VTMsg = VTMsg & "incompatible con las preferencias de COBIS - CONTABILIDAD." & Strings.Chr(13).ToString()
            VTMsg = VTMsg & Strings.Chr(13).ToString() & "La configuración internacional del Panel de Control "
            VTMsg = VTMsg & "debe ser modificada." & Strings.Chr(13).ToString()
            VTMsg = VTMsg & Strings.Chr(13).ToString() & "Separador de miles : , "
            VTMsg = VTMsg & Strings.Chr(13).ToString() & "Separador de decimales : . "
            VTMsg = VTMsg & Strings.Chr(13).ToString() & "Formato de fecha : " & VTFechaPref
            COBISMessageBox.Show(VTMsg, "ERROR - Contabilidad", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            VTProblema = True
        End If
        Return Not VTProblema
    End Function

    Sub PMAnchoColGrid(ByRef lista1 As COBISCorp.Framework.UI.Components.COBISGrid, ByRef Col As Integer)
        lista1.Col = Col
        Dim VTColMax As Double = 5
        For i As Integer = 0 To lista1.Rows - 1
            lista1.Row = i
            If lista1.Text.TrimEnd().Length > VTColMax Then
                VTColMax = Strings.Len(lista1.Text)
            End If
        Next i
        VTColMax *= 110
        If VTColMax > 6500 Then
            lista1.ColWidth(CShort(Col)) = 6500
        Else
            lista1.ColWidth(CShort(Col)) = CInt(VTColMax)
        End If
    End Sub

    Sub PMAnchoColGrid3(ByRef lista1 As COBISCorp.Framework.UI.Components.COBISSpread, ByRef Col As Integer)
        lista1.Col = Col
        Dim VTColMax As Double = 5
        For i As Integer = 0 To lista1.MaxRows
            lista1.Row = i
            If lista1.Text.TrimEnd().Length > VTColMax Then
                VTColMax = Strings.Len(lista1.Text)
            End If
        Next i
        VTColMax *= 110
        If VTColMax > 6500 Then
            lista1.ColWidth(CShort(Col)) = 6500
        Else
            lista1.ColWidth(CShort(Col)) = CInt(VTColMax)
        End If
    End Sub

    Sub PMAjustaColsGrid(ByRef grdGrid As COBISCorp.Framework.UI.Components.COBISSpread)
        Dim VTColmax As Integer = 0
        For i As Integer = 0 To grdGrid.MaxCols
            grdGrid.Col = i
            VTColmax = 4
            For j As Integer = 0 To grdGrid.MaxRows
                grdGrid.Row = j
                If grdGrid.Text.TrimEnd().Length > VTColmax Then
                    VTColmax = Strings.Len(grdGrid.Text)
                End If
            Next j
            grdGrid.ColWidth(i) = VTColmax
        Next i
    End Sub

    Sub PMAnchoColGrid2(ByRef lista1 As COBISCorp.Framework.UI.Components.COBISSpread, ByRef Col As Integer)
        lista1.Col = Col
        Dim VTColMax As Double = 5
        For i As Integer = 0 To lista1.Row - 1
            lista1.Row = i
            If lista1.Text.TrimEnd().Length > VTColMax Then
                VTColMax = Strings.Len(lista1.Text)
            End If
        Next i
        VTColMax *= 110
        If VTColMax > 6500 Then
            lista1.ColWidth(CShort(Col)) = 6500
        Else
            lista1.ColWidth(CShort(Col)) = CInt(VTColMax)
        End If
    End Sub

    Sub PMCargar_FechaSP(ByRef Formato As String)
        For i As Integer = 1 To Formato_Fecha.GetUpperBound(0)
            If Formato_Fecha(i, 1) = Formato Then
                VGFecha_SP = Formato_Fecha(i, 2)
                VGFecha_Pref = Formato
            End If
        Next
    End Sub

    Sub PMCopyClip(ByRef Grid As COBISCorp.Framework.UI.Components.COBISGrid)
        Dim NR As String = Strings.Chr(13).ToString()
        Dim NC As String = Strings.Chr(9).ToString()
        Dim Col1 As Object = Grid.SelStartCol
        Dim Col2 As Object = Grid.SelEndCol
        Dim Row1 As Object = Grid.SelStartRow
        Dim Row2 As Object = Grid.SelEndRow
        Grid.SelStartCol = 1
        Grid.SelEndCol = Grid.Cols - 1
        Grid.SelStartRow = 1
        Grid.SelEndRow = Grid.Rows - 1
        Dim ClipText As String = Grid.Clip
        Dim CopyText As String = ""
        CopyText = CopyText & NC
        For count As Integer = 1 To ClipText.Length
            If Strings.Mid(ClipText, count, 1) <> Strings.Chr(13).ToString() Then
                CopyText = CopyText & Strings.Mid(ClipText, count, 1)
            Else
                CopyText = CopyText & NR & NC
            End If
        Next count
        My.Computer.Clipboard.SetText(CopyText)
        Grid.SelStartCol = CInt(Col1)
        Grid.SelEndCol = CInt(Col2)
        Grid.SelStartRow = CInt(Row1)
        Grid.SelEndRow = CInt(Row2)
    End Sub

    Sub PMInicializar_Variables()
        VGSoloConsulta = False
        VGOfAreaComun = True
        VGEnter = True
        VGIndice = False
        VGConsComp = False
        VGCaptura = False
    End Sub

    Sub PMLimpiagrid(ByRef grdGrid As COBISCorp.Framework.UI.Components.COBISGrid)
        grdGrid.Col = 2
        grdGrid.Row = 2
        For i As Integer = 0 To 1
            grdGrid.Col = i
            For j As Integer = 0 To 1
                grdGrid.Row = j
                grdGrid.Text = ""
            Next j
        Next i
        'grdGrid.Tag = ""
    End Sub

    Sub PMLimpiagrid2(ByRef grdGrid As COBISCorp.Framework.UI.Components.COBISSpread)
        For i As Integer = 0 To 1
            grdGrid.Col = i
            For j As Integer = 0 To 1
                grdGrid.Row = j
                grdGrid.Text = ""
            Next j
        Next i
    End Sub

    Public Sub PMBorrarGrid(ByRef parSSControl As COBISCorp.Framework.UI.Components.COBISSpread)
        If parSSControl.MaxCols > 0 Then
            parSSControl.Row = 1
            parSSControl.Col = 0
            parSSControl.Row2 = parSSControl.MaxRows
            parSSControl.Col2 = parSSControl.MaxCols
            parSSControl.BlockMode = True
            parSSControl.Action = 12
            parSSControl.BlockMode = False
            parSSControl.MaxRows = 0
            parSSControl.MaxCols = 0
        End If
        parSSControl.Tag = CStr(0)
    End Sub

    Sub PMCabeceraCobGrid(ByRef lista1 As COBISCorp.Framework.UI.Components.COBISGrid)
        lista1.Col = 0
        For i As Integer = 0 To lista1.Cols
            lista1.Col = i
            lista1.Row = 0
            lista1.CtlText = UCase(lista1.CtlText)
        Next i
    End Sub

    Public Sub PMBloqueaGrid(ByRef parSSControl As COBISCorp.Framework.UI.Components.COBISSpread)
        If parSSControl.MaxRows > 0 Then
            parSSControl.Row = 1
            parSSControl.Col = 1
            parSSControl.Row2 = parSSControl.MaxRows
            parSSControl.Col2 = parSSControl.MaxCols
            parSSControl.BlockMode = True
            parSSControl.Lock = True
            parSSControl.BlockMode = False
            parSSControl.Row = parSSControl.ActiveRow
        End If
    End Sub

    Public Sub PMBloqueaGridLimite(ByRef parSSControl As COBISCorp.Framework.UI.Components.COBISSpread, ByVal parColumnasDif As Integer)
        If parSSControl.MaxRows > 0 Then
            parSSControl.Row = 1
            parSSControl.Col = 1
            parSSControl.Row2 = parSSControl.MaxRows
            parSSControl.Col2 = parSSControl.MaxCols - parColumnasDif
            parSSControl.BlockMode = True
            parSSControl.Lock = True
            parSSControl.BlockMode = False
            parSSControl.Row = parSSControl.ActiveRow
        End If
    End Sub

    Sub GeneraDatos_Excel(ByRef Grilla As COBISCorp.Framework.UI.Components.COBISSpread, ByRef svTitulo As String)
        Try
            Dim XlsApl As Excel.Application
            Dim xlsLibro As Excel.Workbook
            Dim xlhoja As Excel.Worksheet
            Dim nlTimer As Integer = 0
            nlTimer = CInt(DateTime.Now.TimeOfDay.TotalSeconds)
            XlsApl = New Excel.Application()
            XlsApl.Visible = True
            XlsApl.Caption = svTitulo & CStr(nlTimer)
            XlsApl.Workbooks.Add()
            xlsLibro = XlsApl.ActiveWorkbook
            xlhoja = xlsLibro.Worksheets.Add()
            xlhoja.Name = "DATOS_MODULO" & nlTimer
            xlsLibro.Worksheets("DATOS_MODULO" & nlTimer).Activate()
            For Fil As Integer = 0 To Grilla.Row
                Grilla.Row = Fil
                For Col As Integer = 1 To Grilla.Col
                    Grilla.Col = Col
                    xlsLibro.Worksheets("DATOS_MODULO" & nlTimer).Cells(Fil + 1, Col).Value2 = Grilla.Text.ToUpper()
                Next
                If Fil = 0 Then
                    xlsLibro.Worksheets("DATOS_MODULO" & nlTimer).Rows("1:1", Type.Missing).Select()
                    XlsApl.Selection.Interior.ColorIndex = 37
                    XlsApl.Selection.Interior.Pattern = Excel.Constants.xlSolid
                    XlsApl.Selection.Font.Bold = True
                    XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
                    XlsApl.Cells.Select()
                    XlsApl.Range("E1").Activate()
                    XlsApl.Cells.EntireColumn.AutoFit()
                End If
            Next
            XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
            XlsApl.Cells.Select()
            XlsApl.Range("E1").Activate()
            XlsApl.Cells.EntireColumn.AutoFit()
        Catch excep As System.Exception
            COBISMessageBox.Show(CStr(Information.Err().Number) & " - " & excep.Message, My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            Exit Sub
        End Try
    End Sub

    Function ImprimirTextoEntre(ByRef texto As String, ByRef Desde As Single, ByRef Hasta As Single) As String
        Dim TextoAux As String = ""
        For i As Integer = 1 To texto.Length
            TextoAux = TextoAux & Strings.Mid(texto, i, 1)
            If COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.TextWidth(TextoAux) > (Hasta - Desde) - 1 Then
                Exit For
            End If
        Next i
        Return TextoAux
    End Function

    Sub GeneraDatosGrid_Excel_Gbl2(ByRef Grilla As COBISCorp.Framework.UI.Components.COBISGrid, ByRef svTitulo As String)
        Try
            Dim XlsApl As Excel.Application
            Dim xlsLibro As Excel.Workbook
            Dim xlhoja As Excel.Worksheet
            Dim nlTimer As Integer = 0
            nlTimer = CInt(DateTime.Now.TimeOfDay.TotalSeconds)
            XlsApl = New Excel.Application()
            XlsApl.Visible = True
            XlsApl.Caption = svTitulo
            XlsApl.Workbooks.Add()
            xlsLibro = XlsApl.ActiveWorkbook
            xlhoja = xlsLibro.Worksheets.Add()
            xlhoja.Name = svTitulo
            xlsLibro.Worksheets(svTitulo).Activate()
            For Fil As Integer = 0 To Grilla.Rows - 1
                Grilla.Row = CInt(CStr(Fil))
                For Col As Integer = 1 To Grilla.Cols - 1
                    Grilla.Col = Col
                    If Math.Abs(Conversion.Val(Grilla.CtlText)) >= 0 Then
                        If Not (Grilla.CtlText.IndexOf("/"c) + 1) Then
                            XlsApl.Selection.NumberFormat = "0"
                        Else
                            XlsApl.Selection.NumberFormat = "@"
                        End If
                    End If
                    xlsLibro.Worksheets(svTitulo).Cells(Fil + 1, Col).Value2 = Grilla.CtlText.ToUpper()
                Next
                If Fil = 0 Then
                    xlsLibro.Worksheets(svTitulo).Rows("1:1", Type.Missing).Select()
                    XlsApl.Selection.Interior.ColorIndex = 37
                    XlsApl.Selection.Interior.Pattern = Excel.Constants.xlSolid
                    XlsApl.Selection.Font.Bold = True
                    XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
                    XlsApl.Cells.Select()
                    XlsApl.Range("E1").Activate()
                    XlsApl.Cells.EntireColumn.AutoFit()
                End If
            Next
            XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
            XlsApl.Cells.Select()
            XlsApl.Range("E1").Activate()
            XlsApl.Cells.EntireColumn.AutoFit()
        Catch excep As System.Exception
            COBISMessageBox.Show(CStr(Information.Err().Number) & " - " & excep.Message, My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            Exit Sub
        End Try
    End Sub

    Sub GeneraDatosGrid_Excel_Gbl(ByRef Grilla As COBISCorp.Framework.UI.Components.COBISSpread, ByRef svTitulo As String)
        Try
            Dim XlsApl As Excel.Application
            Dim xlsLibro As Excel.Workbook
            Dim xlhoja As Excel.Worksheet
            Dim nlTimer As Integer = 0
            nlTimer = CInt(DateTime.Now.TimeOfDay.TotalSeconds)
            XlsApl = New Excel.Application()
            XlsApl.Visible = True
            XlsApl.Caption = svTitulo
            XlsApl.Workbooks.Add()
            xlsLibro = XlsApl.ActiveWorkbook
            xlhoja = xlsLibro.Worksheets.Add()
            xlhoja.Name = svTitulo
            xlsLibro.Worksheets(svTitulo).Activate()
            For Fil As Integer = 0 To Grilla.MaxRows
                Grilla.Row = CInt(CStr(Fil))
                For Col As Integer = 1 To Grilla.MaxCols
                    Grilla.Col = Col
                    If Math.Abs(Conversion.Val(Grilla.Text)) >= 0 Then
                        If Not (Grilla.Text.IndexOf("/"c) + 1) Then
                            XlsApl.Selection.NumberFormat = "0"
                        Else
                            XlsApl.Selection.NumberFormat = "@"
                        End If
                    End If
                    xlsLibro.Worksheets(svTitulo).Cells(Fil + 1, Col).Value2 = Grilla.Text.ToUpper()
                Next
                If Fil = 0 Then
                    xlsLibro.Worksheets(svTitulo).Rows("1:1", Type.Missing).Select()
                    XlsApl.Selection.Interior.ColorIndex = 37
                    XlsApl.Selection.Interior.Pattern = Excel.Constants.xlSolid
                    XlsApl.Selection.Font.Bold = True
                    XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
                    XlsApl.Cells.Select()
                    XlsApl.Range("E1").Activate()
                    XlsApl.Cells.EntireColumn.AutoFit()
                End If
            Next
            XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
            XlsApl.Cells.Select()
            XlsApl.Range("E1").Activate()
            XlsApl.Cells.EntireColumn.AutoFit()
        Catch excep As System.Exception
            If (Information.Err().Number = -2147418111) Then
                COBISMessageBox.Show(CStr(Information.Err().Number) & " - Se canceló la importación de datos", My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            Else
                COBISMessageBox.Show(CStr(Information.Err().Number) & " - " & excep.Message, My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            End If
            Exit Sub
        End Try
    End Sub

    Function FMPeticionVLA(ByRef VLORDEN As String) As Boolean
        Dim result As Boolean = False
        Dim VTOrden As String = ""
        Dim VTPausa As Byte = 0
        Dim PauseTime As Integer = 0
        Dim start As Integer = 0
        Dim Finish As Integer = 0
        Dim TotalTime As Integer = 0
        result = True
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6978")
        PMPasoValores(sqlconn, "@i_orden", 0, SQLINT4, VLORDEN)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
        PMPasoValores(sqlconn, "@o_orden", 1, SQLINT4, "")
        PMPasoValores(sqlconn, "@o_respuesta", 1, SQLCHAR, " ")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_con_dat_aux", True, "Petición Generacion Plano Auxiliar") Then
            PMChequea(sqlconn)
            VTOrden = FMRetParam(sqlconn, 1)
            VGRespuesta = FMRetParam(sqlconn, 2)
        Else
            PMChequea(sqlconn)
            result = False
        End If
        If VGRespuesta = "N" Then
            VTPausa = 1
            PauseTime = VTPausa
            start = CInt(DateTime.Now.TimeOfDay.TotalSeconds)
            Do While DateTime.Now.TimeOfDay.TotalSeconds < start + PauseTime
                Application.DoEvents()
            Loop
            Finish = CInt(DateTime.Now.TimeOfDay.TotalSeconds)
            TotalTime = Finish - start
            FMPeticionVLA(VTOrden)
        End If
        Return result
    End Function

    Sub PMCabeceraColGrid(ByRef lista1 As COBISCorp.Framework.UI.Components.COBISSpread, ByRef Col As Integer)
        lista1.Col = 0
        For i As Integer = 0 To lista1.MaxCols
            lista1.Col = i
            lista1.Row = 0
            lista1.Text = UCase(lista1.Text)
        Next i
    End Sub
End Module


