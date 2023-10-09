

Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Globalization
Imports System.Text
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module MCUSTOM
    Declare Sub BorraGrid Lib "map.dll" (ByRef Grid As Control)
    Dim FileName As String = ""
    Public X As Integer = 0
    Public Y As Integer = 0
    Public VTCont As Integer = 0
    Public bandera(5) As Boolean

    Public Function FMLoadResString(ByRef parCodMsg As Integer) As String
        Dim VTCodMsg As Integer = 0
        Select Case VGIdioma
            Case "CASTELLANO"
                VTCodMsg = parCodMsg
            Case "INGLES"
                If parCodMsg > 10000 Then
                    VTCodMsg = parCodMsg + 10000
                Else
                    VTCodMsg = parCodMsg + 5000
                End If
            Case Else
                VTCodMsg = parCodMsg
        End Select
        If VTCodMsg < 64001 Then
            Return COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(VTCodMsg))
        Else
            Return LoadResStringASB(VTCodMsg)
        End If
    End Function

    Function LoadResStringASB(ByRef Token As Integer) As String
        Return COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(Token)) 'CStr(Recursos.get_Item(Token))
    End Function

    Public Sub PMMapeaTextoGrid(ByRef parcontrol As COBISCorp.Framework.UI.Components.COBISGrid)
        Dim VTCabecera As String = ""
        Dim VTsCtlType As String = parcontrol.GetType().Name
        If VTsCtlType = "COBISGrid" Then
            For VTColumn As Integer = 0 To parcontrol.Cols - 1
                parcontrol.Row = 0
                parcontrol.Col = CShort(VTColumn)
                Dim dbNumericTemp As Double = 0
                If parcontrol.CtlText <> "" And Double.TryParse(parcontrol.CtlText, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
                    VTCabecera = FMLoadResString(CInt(parcontrol.CtlText))
                    parcontrol.CtlText = VTCabecera
                End If
            Next VTColumn
            Exit Sub
        End If
        If VTsCtlType = "fpSpread" Then
            parcontrol.Row = 0
            For VTColumn As Integer = 1 To parcontrol.Cols
                parcontrol.Col = CShort(VTColumn)
                Dim dbNumericTemp2 As Double = 0
                If parcontrol.CtlText <> "" And Double.TryParse(parcontrol.CtlText, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp2) Then
                    VTCabecera = FMLoadResString(CInt(parcontrol.CtlText))
                    parcontrol.CtlText = VTCabecera
                End If
            Next VTColumn
            Exit Sub
        End If
        If VTsCtlType = "vaSpread" Then
            For VTColumn As Integer = 1 To parcontrol.Cols
                parcontrol.Row = 1
                parcontrol.Col = CShort(VTColumn)
                VTCabecera = FMLoadResString(CInt(parcontrol.CtlText))
                parcontrol.CtlText = VTCabecera
            Next VTColumn
        End If
    End Sub

    Sub Iniciar_Preferencias_Custom(ByRef FileName As String)
        ReDim Formato_Fecha(3, 2)
        Formato_Fecha(1, 1) = "dd/mm/yyyy"
        Formato_Fecha(2, 1) = "mm/dd/yyyy"
        Formato_Fecha(3, 1) = "yyyy/mm/dd"
        Formato_Fecha(1, 2) = "103"
        Formato_Fecha(2, 2) = "101"
        Formato_Fecha(3, 2) = "111"
        ReDim Preferencias(34, 2)
        Preferencias(1, 1) = "FILIAL"
        Preferencias(2, 1) = "OFICINA"
        Preferencias(3, 1) = "ROL"
        Preferencias(4, 1) = "SERVIDOR"
        Preferencias(5, 1) = "TERMINAL"
        Preferencias(6, 1) = "USUARIO"
        Preferencias(7, 1) = "FORMATO-FECHA"
        Preferencias(8, 1) = "DEBUG"
        Preferencias(9, 1) = "ARCHIVO-DEBUG"
        Preferencias(10, 1) = "VERSION"
        Preferencias(11, 1) = "PATH-DESTINO"
        Preferencias(12, 1) = "PATH-EXCEL"
        Preferencias(13, 1) = "PATH-SALDOS"
        Preferencias(14, 1) = "DIRECCION-SERVIDOR"
        Preferencias(15, 1) = "EJECUTABLE-TRANSFERENCIA"
        Preferencias(16, 1) = "RANGO-COTIZACIONES"
        Preferencias(17, 1) = "PATH-BALANCE"
        Preferencias(18, 1) = "PATH-INCOME"
        Preferencias(19, 1) = "PATH-BALGENERAL"
        Preferencias(20, 1) = "PATH-ESTRESUL"
        Preferencias(21, 1) = "PATH-FONDOS"
        Preferencias(22, 1) = "PATH-INTCLAMINS"
        Preferencias(23, 1) = "PATH-BALANCE-GC"
        Preferencias(24, 1) = "PATH-ASSET"
        Preferencias(25, 1) = "PATH-INCOME-MIAMI"
        Preferencias(26, 1) = "PATH-CONTROLFIN"
        Preferencias(27, 1) = "PATH-PROFITC"
        Preferencias(28, 1) = "PATH-ACCOUNTAVG"
        Preferencias(29, 1) = "PATH-TRIALB"
        Preferencias(30, 1) = "PATH-VARBMES"
        Preferencias(31, 1) = "PATH-VARBDIA"
        Preferencias(32, 1) = "PATH-FEDERAL"
        Preferencias(33, 1) = "PATH-YIELD"
        Preferencias(34, 1) = "IDIOMA"


        Preferencias(1, 2) = Get_Preferencia("FILIAL")
        Preferencias(2, 2) = Get_Preferencia("OFICINA")
        Preferencias(3, 2) = Get_Preferencia("ROL")
        Preferencias(4, 2) = Get_Preferencia("SERVIDOR")
        Preferencias(5, 2) = Get_Preferencia("TERMINAL")
        Preferencias(6, 2) = Get_Preferencia("USUARIO")
        Preferencias(7, 2) = VGFormatoFecha
        If Preferencias(7, 2) = "" Then
            Preferencias(7, 2) = "yyyy/mm/dd"
        End If
        Preferencias(8, 2) = Get_Preferencia("DEBUG")
        If Preferencias(8, 2) = "" Then
            Preferencias(8, 2) = "N"
        End If
        Preferencias(9, 2) = Get_Preferencia("ARCHIVO-DEBUG")
        If Preferencias(9, 2) = "" Then
            Preferencias(9, 2) = "segurid.dbg"
        End If
        Preferencias(10, 2) = Get_Preferencia("VERSION")
        If Preferencias(10, 2) = "" Then
            Preferencias(10, 2) = "N"
        End If
        Preferencias(11, 2) = Get_Preferencia("PATH-DESTINO")
        Preferencias(12, 2) = Get_Preferencia("PATH-EXCEL")
        If Preferencias(12, 2) = "" Then
            Preferencias(12, 2) = "c:\msoffice\excel\excel.exe"
        End If
        Preferencias(13, 2) = Get_Preferencia("PATH-SALDOS")
        If Preferencias(13, 2) = "" Then
            Preferencias(13, 2) = VGPathResouces & "\saldos4i.xls"
        End If
        Preferencias(14, 2) = Get_Preferencia("DIRECCION-SERVIDOR")
        If Preferencias(14, 2) = "" Then
            Preferencias(14, 2) = "192.188.45.120"
        End If
        Preferencias(15, 2) = Get_Preferencia("EJECUTABLE-TRANSFERENCIA")
        If Preferencias(15, 2) = "" Then
            Preferencias(15, 2) = VGPathResouces & "\Transfer.bat"
        End If
        Preferencias(16, 2) = Get_Preferencia("RANGO-COTIZACIONES")
        Preferencias(17, 2) = Get_Preferencia("PATH-BALANCE")
        If Preferencias(17, 2) = "" Then
            Preferencias(17, 2) = VGPathResouces & "\Balance.xls"
        End If
        Preferencias(18, 2) = Get_Preferencia("PATH-INCOME")
        If Preferencias(18, 2) = "" Then
            Preferencias(18, 2) = VGPathResouces & "\Income.xls"
        End If
        Preferencias(19, 2) = Get_Preferencia("PATH-BALGENERAL")
        If Preferencias(19, 2) = "" Then
            Preferencias(19, 2) = VGPathResouces & "\bal_super.xls"
        End If
        Preferencias(20, 2) = Get_Preferencia("PATH-ESTRESUL")
        If Preferencias(20, 2) = "" Then
            Preferencias(20, 2) = VGPathResouces & "\estresul.xls"
        End If
        Preferencias(21, 2) = Get_Preferencia("PATH-FONDOS")
        If Preferencias(21, 2) = "" Then
            Preferencias(21, 2) = VGPathResouces & "\foncapital.xls"
        End If
        Preferencias(22, 2) = Get_Preferencia("PATH-INTCLAMINS")
        If Preferencias(22, 2) = "" Then
            Preferencias(22, 2) = VGPathResouces & "\intclaims.xls"
        End If
        Preferencias(23, 2) = Get_Preferencia("PATH-BALANCE-GC")
        If Preferencias(23, 2) = "" Then
            Preferencias(23, 2) = VGPathResouces & "\balancegc.xls"
        End If
        Preferencias(24, 2) = Get_Preferencia("PATH-ASSET")
        If Preferencias(24, 2) = "" Then
            Preferencias(24, 2) = VGPathResouces & "\asset_main.xls"
        End If
        Preferencias(25, 2) = Get_Preferencia("PATH-INCOME-MIAMI")
        If Preferencias(25, 2) = "" Then
            Preferencias(25, 2) = VGPathResouces & "\incomeMIAMI.xls"
        End If
        Preferencias(26, 2) = Get_Preferencia("PATH-CONTROLFIN")
        If Preferencias(26, 2) = "" Then
            Preferencias(26, 2) = VGPathResouces & "\salfinan.xls"
        End If
        Preferencias(27, 2) = Get_Preferencia("PATH-PROFITC")
        If Preferencias(27, 2) = "" Then
            Preferencias(27, 2) = VGPathResouces & "\profitab.xls"
        End If
        Preferencias(28, 2) = Get_Preferencia("PATH-ACCOUNTAVG")
        If Preferencias(28, 2) = "" Then
            Preferencias(28, 2) = VGPathResouces & "\avgMIAMI.xls"
        End If
        Preferencias(29, 2) = Get_Preferencia("PATH-TRIALB")
        If Preferencias(29, 2) = "" Then
            Preferencias(29, 2) = VGPathResouces & "\trialb.xls"
        End If
        Preferencias(30, 2) = Get_Preferencia("PATH-VARBMES")
        If Preferencias(30, 2) = "" Then
            Preferencias(30, 2) = VGPathResouces & "\varmes.xls"
        End If
        Preferencias(31, 2) = Get_Preferencia("PATH-VARBDIA")
        If Preferencias(31, 2) = "" Then
            Preferencias(31, 2) = VGPathResouces & "\vardia.xls"
        End If
        Preferencias(32, 2) = Get_Preferencia("PATH-FEDERAL")
        If Preferencias(32, 2) = "" Then
            Preferencias(32, 2) = VGPathResouces & "\federal_019.xls"
        End If
        Preferencias(33, 2) = Get_Preferencia("PATH-YIELD")
        If Preferencias(33, 2) = "" Then
            Preferencias(33, 2) = VGPathResouces & "\yield.xls"
        End If
        Preferencias(34, 2) = Get_Preferencia("IDIOMA")
        If Preferencias(34, 2) = "" Then
            Preferencias(34, 2) = "CASTELLANO"
        End If

        PMCargar_FechaSP(Preferencias(7, 2))
    End Sub

    Sub Set_Preferencia_Custom(ByRef Token As String, ByRef Valor As String)
        For i As Integer = 1 To Preferencias.GetUpperBound(0)
            If Preferencias(i, 1) = Token Then
                Select Case Token
                    Case "DEBUG", "ARCHIVO-DEBUG", "VERSION"
                End Select
                Preferencias(i, 2) = Valor
            End If
        Next i
    End Sub

    Function FMSeguridad_Custom() As Integer
        Dim result As Integer = 0
        Dim VTR1 As Integer = 0
        result = False
        ReDim VGTransacciones(0)
        Dim VTTran(5, 10000) As String
        Dim j As Integer = 0
        Dim VTModo As String = "0"
        PMPasoValores(sqlconn, "@i_rol", 0, SQLINT1, VGRol)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "rp_tr_autorizada", True, " Cargando transacciones autorizadas..." & "[" & Conversion.Str(VGTransacciones.GetUpperBound(0) + VTR1) & "]") Then
            VTR1 = FMMapeaMatriz(sqlconn, VTTran)
            PMChequea(sqlconn)
            VGNumTran% = VTR1
            ReDim Preserve VGTransacciones(VGTransacciones.GetUpperBound(0) + VTR1)
            For i As Integer = 1 To VTR1
                VGTransacciones(i + j) = VTTran(0, i)
            Next i
            VTModo = "1"
            j = VGTransacciones.GetUpperBound(0)
            Return True
        Else
            ReDim VGTransacciones(0)
            Return False
        End If
        Return result
    End Function

    Sub PMBotonSeguridad_Custom(ByRef Forma As Object, ByRef Indice As Integer)
        Dim VTPosicion As Integer = 0
        Dim VTTransacciones As Integer = 0
        Dim VTDato As New StringBuilder
        Dim VTArrayTran() As String = Nothing
        Dim VTProcesadas As Integer = 0
        Dim j As Integer = 0
        Dim VTFlag As Boolean
        For i As Integer = 0 To Indice
            VTPosicion = 1
            VTTransacciones = 0
            Do While VTPosicion < Strings.Len(Forma.cmdBoton(i).Tag)
                VTDato = New StringBuilder("")
                Do While (Strings.Mid(Forma.cmdBoton(i).Tag, VTPosicion, 1) <> ";") And (VTPosicion <= Strings.Len(Forma.cmdBoton(i).Tag))
                    VTDato.Append(Strings.Mid(Forma.cmdBoton(i).Tag, VTPosicion, 1))
                    VTPosicion += 1
                Loop
                VTTransacciones += 1
                ReDim Preserve VTArrayTran(VTTransacciones)
                VTArrayTran(VTTransacciones) = VTDato.ToString()
                VTPosicion += 1
            Loop
            VTProcesadas = 0
            j = 1
            VTFlag = True
            Do While (VTTransacciones > VTProcesadas) And VTFlag
                VTFlag = False
                For k As Integer = 1 To VGTransacciones.GetUpperBound(0)
                    If VGTransacciones(k) = VTArrayTran(j) Then
                        VTFlag = True
                        j += 1
                        VTProcesadas += 1
                        If VTProcesadas = VTTransacciones Then
                            Forma.cmdBoton(i).Enabled = True
                            Forma.cmdBoton(i).Visible = True
                        End If
                        Exit For
                    End If
                Next k
            Loop
        Next i
    End Sub

    Sub PMMenuSeguridad_Custom(ByRef Menu As Object)
        Dim VTDato As New StringBuilder
        Dim VTEncontro As Boolean = False
        Menu.Enabled = False
        Dim VTPosicion As Integer = 1
        Do While VTPosicion < Strings.Len(Convert.ToString(Menu.Tag))
            VTDato = New StringBuilder("")
            Do While (Strings.Mid(Convert.ToString(Menu.Tag), VTPosicion, 1) <> ";") And (VTPosicion <= Strings.Len(Convert.ToString(Menu.Tag)))
                VTDato.Append(Strings.Mid(Convert.ToString(Menu.Tag), VTPosicion, 1))
                VTPosicion += 1
            Loop
            VTEncontro = False
            For i As Integer = 1 To VGTransacciones.GetUpperBound(0)
                If VTDato.ToString() = VGTransacciones(i) Then
                    Menu.Enabled = True
                    VTEncontro = True
                    Exit For
                End If
            Next i
            If Not VTEncontro Then
                Menu.Enabled = False
                Exit Sub
            End If
            VTPosicion += 1
        Loop
    End Sub

    Sub PMObjetoSeguridad(ByRef parObjeto As Object)
        Dim VTMedio As Integer = 0
        Dim VTMin As Integer = 0
        Dim VTMax As Integer = 0
        Dim VTDato As String = ""
        parObjeto.Enabled = False
        Dim VTPosicion As Integer = 1
        While VTPosicion <= Strings.Len(parObjeto.Tag)
            VTDato = ""
            While (Strings.Mid(parObjeto.Tag, VTPosicion, 1) <> ";") And (VTPosicion <= Strings.Len(parObjeto.Tag))
                VTDato = VTDato & Strings.Mid(parObjeto.Tag, VTPosicion, 1)
                VTPosicion += 1
            End While
            VTMedio = VGNumTran \ 2
            VTMax = VGNumTran + 1
            VTMin = 0
            While (VTMedio > 1) And (VTMedio > VTMin) And (VTMedio < VTMax)
                If Val(VGTransacciones(VTMedio)) = Val(VTDato) Then
                    parObjeto.Enabled = True
                    Exit Sub
                Else
                    If Val(VGTransacciones(VTMedio)) < Val(VTDato) Then
                        VTMin = VTMedio
                        VTMedio += ((VTMax - VTMedio) \ 2)
                    Else
                        VTMax = VTMedio
                        VTMedio = VTMin + ((VTMedio - VTMin) \ 2)
                    End If
                End If
            End While
            VTPosicion += 1
        End While
    End Sub

    Public Function FMGetSeparadorDecimales_Custom() As String
        Dim VTSeparadorDecimales As String = ""
        If FMGetKeyValue(CG_HKEY_CURRENT_USER, "Control Panel\International", "sDecimal", VTSeparadorDecimales) Then
            Return VTSeparadorDecimales
        Else
            Return ""
        End If
    End Function

    Public Function FMGetSeparadorMiles_Custom() As String
        Dim VTSeparadorMiles As String = ""
        If FMGetKeyValue(CG_HKEY_CURRENT_USER, "Control Panel\International", "sThousand", VTSeparadorMiles) Then
            Return VTSeparadorMiles
        Else
            Return ""
        End If
    End Function

    Public Function FMGetFormatoFecha_Custom() As String
        Dim VTFormatoFecha As String = ""
        If FMGetKeyValue(CG_HKEY_CURRENT_USER, "Control Panel\International", "sShortDate", VTFormatoFecha) Then
            Return VTFormatoFecha
        Else
            Return ""
        End If
    End Function

    Sub PMMarcaRow(ByRef SSControl As Object, ByRef Row As Integer, Optional ByVal Col As Integer = 1)
        '*************************************************************
        ' Objetivo:  Sombrea los registros no marcados con blanco.
        '            Sombrea el registro seleccionado con color
        '            amarillo.
        ' Input   :  SSControl      Nombre del grid
        '            Row            Número de columna seleccionada
        ' Output  :  Ninguno
        '*************************************************************
        '                       MODIFICACIONES
        ' FECHA          AUTOR           RAZON
        ' 14-May-96      N. Silva        Emision Inicial
        '*************************************************************

        If Row > -1 Then 'el grid no pierde el foco
            'marcar todo el grid y deseleccionarlo
            SSControl.Col = Col
            SSControl.Row = 1
            SSControl.col2 = SSControl.MaxCols
            SSControl.Row2 = SSControl.MaxRows
            SSControl.BlockMode = True
            SSControl.BackColor = System.Drawing.ColorTranslator.FromOle(&HFFFFFF) 'blanco
            SSControl.BlockMode = False
            ' Sombrea el registro seleccionado con color amarillo
            SSControl.Col = Col
            SSControl.Row = Row
            SSControl.col2 = SSControl.MaxCols
            SSControl.Row2 = Row
            SSControl.BlockMode = True
            SSControl.BackColor = System.Drawing.SystemColors.Info '&HC0FFFF
            'SSControl.BackColor = System.Drawing.ColorTranslator.FromOle(&H80FFFF) 'amarillo
            SSControl.BlockMode = False
        End If
    End Sub
End Module
