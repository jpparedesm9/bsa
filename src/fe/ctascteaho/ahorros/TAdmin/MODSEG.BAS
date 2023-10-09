Attribute VB_Name = "MODSEG"
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          MODSEG.BAS
' NOMBRE LOGICO:    MODSEG
' PRODUCTO:         Terminal Administrativa
'*************************************************************
'                       IMPORTANTE
' Esta aplicacion es parte de los paquetes bancarios propiedad
' de MACOSA S.A.
' Su uso no  autorizado queda  expresamente prohibido asi como
' cualquier  alteracion o  agregado  hecho por  alguno  de sus
' usuarios sin el debido consentimiento por escrito de MACOSA.
' Este programa esta protegido por la ley de derechos de autor
' y por las  convenciones  internacionales de  propiedad inte-
' lectual.  Su uso no  autorizado dara  derecho a  MACOSA para
' obtener ordenes  de secuestro o  retencion y para  perseguir
' penalmente a los autores de cualquier infraccion.
'*************************************************************
'                         PROPOSITO
' Módulo de seguridad para el Front End
' Permite habilitar o desahabilitar los item de los menus
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

' Arreglo con el conjunto de transacciones permisibles para
' el rol del usuario

Global VGTransacciones() As String
Global VGNumTran As Integer
Dim VTArrayTran() As String
'Req. 371 Tarjeta Debito
Global VGValidaHuella As Boolean
Global VGRegistraHuellaAValidar As Boolean
Global VGTipoDoc As String
Global VGTipoDocValidado As String
Global VGNumDocValidado As String
Global VGFechaFormato As String
Global VGFila As Integer

Sub PMObjetoSeguridad(parObjeto As Control)
'*************************************************************
' PROPOSITO: Valida la seguridad de un objeto según el
'            rol de un usuario
' INPUT    : parObjeto         Nombre del control específico
' OUTPUT   : ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 29/Jul/96      S.Garcés        Emisión Inicial
'*************************************************************

    Dim VTPosicion As Integer
    Dim VTMedio As Integer
    Dim VTMin As Integer
    Dim VTMax As Integer
    Dim VTDato As String
    
    parObjeto.Enabled = False
    VTPosicion = 1
    While VTPosicion <= Len(parObjeto.Tag)
        VTDato = ""
        While (Mid$(parObjeto.Tag, VTPosicion, 1) <> ";") And (VTPosicion <= Len(parObjeto.Tag))
            VTDato = VTDato + Mid$(parObjeto.Tag, VTPosicion, 1)
            VTPosicion = VTPosicion + 1
        Wend

        VTMedio% = VGNumTran% \ 2
        VTMax% = VGNumTran% + 1
        VTMin% = 0

        While (VTMedio% > 1) And (VTMedio% > VTMin%) And (VTMedio% < VTMax%)
            If Val(VGTransacciones(0, VTMedio%)) = Val(VTDato) Then
                parObjeto.Enabled = True
                Exit Sub
            Else
                If Val(VGTransacciones(0, VTMedio%)) < Val(VTDato) Then
                    VTMin% = VTMedio%
                    VTMedio% = VTMedio% + ((VTMax% - VTMedio%) \ 2)
                Else
                    VTMax% = VTMedio%
                    VTMedio% = VTMin% + ((VTMedio% - VTMin%) \ 2)
                End If
            End If
        Wend
        VTPosicion = VTPosicion + 1
    Wend
End Sub



Function FMSeguridad() As Integer
    FMSeguridad% = False
    Dim VTR1 As Integer
    ReDim VGTransacciones(1, 10000) As String
     PMPasoValores sqlconn&, "@i_rol", 0, SQLINT1, VGRol$
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "rp_tr_autorizada", True, " Cargando transacciones autorizadas...") Then
         VGNumTran% = FMMapeaMatriz(sqlconn&, VGTransacciones())
         PMChequea sqlconn&
        FMSeguridad% = True
        FPrincipal!pnlTransaccionLine = "Transacciones Autorizadas...[" & Str$(VTR1) & "]"
    Else
        ReDim VGTransacciones(0, 0) As String
        FMSeguridad% = False
        Exit Function
    End If
End Function

Sub PMBotonSeguridad(Forma As Object, Indice As Integer)
    Dim VTPosicion As Integer
    Dim VTTransacciones As Integer
    Dim VTDato As String
    ' Rutina de Control de Seguridades para habilitación de
    ' Botones de Comandos
    Dim i As Integer
    Dim j As Integer
    Dim VTFlag As Boolean
    Dim VTProcesadas As Integer
    Dim VTMedio As Integer
    Dim VTMax As Integer
    Dim VTMin As Integer
    For i = 0 To Indice%
        VTPosicion = 1
        VTTransacciones = 0

'FIXIT: 'cmdBoton(i' is not a property of the generic 'Form' object in Visual Basic .NET. To access 'cmdBoton(i' declare 'Forma' using its actual type instead of 'Form'     FixIT90210ae-R1460-RCFE85
        While VTPosicion < Len(Forma.cmdBoton(i).Tag) = True
            VTDato = ""
'FIXIT: 'cmdBoton(i).Tag' is not a property of the generic 'Form' object in Visual Basic .NET. To access 'cmdBoton(i).Tag' declare 'Forma' using its actual type instead of 'Form'     FixIT90210ae-R1460-RCFE85
'FIXIT: 'cmdBoton(i' is not a property of the generic 'Form' object in Visual Basic .NET. To access 'cmdBoton(i' declare 'Forma' using its actual type instead of 'Form'     FixIT90210ae-R1460-RCFE85
            While (Mid$(Forma.cmdBoton(i).Tag, VTPosicion, 1) <> ";") And (VTPosicion <= Len(Forma.cmdBoton(i).Tag))
'FIXIT: 'cmdBoton(i).Tag' is not a property of the generic 'Form' object in Visual Basic .NET. To access 'cmdBoton(i).Tag' declare 'Forma' using its actual type instead of 'Form'     FixIT90210ae-R1460-RCFE85
                VTDato = VTDato & Mid$(Forma.cmdBoton(i).Tag, VTPosicion, 1)
                VTPosicion = VTPosicion + 1
            Wend
            VTTransacciones = VTTransacciones + 1
            ReDim Preserve VTArrayTran(VTTransacciones) As String
            VTArrayTran(VTTransacciones) = VTDato
            VTPosicion = VTPosicion + 1
        Wend

        VTProcesadas = 1
        j = 1
        VTFlag = True

        While (VTTransacciones >= VTProcesadas) And VTFlag
            VTFlag = False
            ' Busqueda Binaria

            VTMedio = VGNumTran% \ 2
            VTMax = VGNumTran%
            VTMin% = 0


            While (VTMedio% >= 1) And (VTMedio% > VTMin%) And (VTMedio% < VTMax)
                If Val(VGTransacciones(0, VTMedio%)) = Val(VTArrayTran(VTProcesadas)) Then
'FIXIT: 'cmdBoton(i' is not a property of the generic 'Form' object in Visual Basic .NET. To access 'cmdBoton(i' declare 'Forma' using its actual type instead of 'Form'     FixIT90210ae-R1460-RCFE85
                    Forma.cmdBoton(i).Enabled = True
'FIXIT: 'cmdBoton(i' is not a property of the generic 'Form' object in Visual Basic .NET. To access 'cmdBoton(i' declare 'Forma' using its actual type instead of 'Form'     FixIT90210ae-R1460-RCFE85
                    Forma.cmdBoton(i).Visible = True
                    VTMedio% = 0
                Else
                    If Val(VGTransacciones(0, VTMedio%)) < Val(VTArrayTran(VTProcesadas)) Then
                        VTMin% = VTMedio%
                        VTMedio% = VTMedio% + ((VTMax - VTMedio%) \ 2)
                    Else
                        VTMax = VTMedio%
                        VTMedio% = VTMin% + ((VTMedio% - VTMin%) \ 2)
                    End If
                End If
            Wend

            VTProcesadas = VTProcesadas + 1
        Wend

    Next i
End Sub

Sub PMMenuSeguridad(Menu As Control)
    Menu.Enabled = False
    'Menu.Visible = False
    Dim VTPosicion As Integer
    Dim VTDato As String
    Dim VTMax As Integer
    Dim VTMedio As Integer
    Dim VTMin As Integer
    VTPosicion = 1
    While VTPosicion <= Len(Menu.Tag)
        VTDato = ""
        While (Mid$(Menu.Tag, VTPosicion, 1) <> ";") And (VTPosicion <= Len(Menu.Tag))
            VTDato = VTDato & Mid$(Menu.Tag, VTPosicion, 1)
            VTPosicion = VTPosicion + 1
        Wend

        If Val(VGTransacciones(0, VGNumTran%)) = Val(VTDato) Then
            Menu.Enabled = True
            'Menu.Visible = True
            Exit Sub
        End If

        VTMedio% = VGNumTran% \ 2
        VTMax% = VGNumTran%
        VTMin% = 0

        While (VTMedio% >= 1) And (VTMedio% > VTMin%) And (VTMedio% < VTMax%)
            If Val(VGTransacciones(0, VTMedio%)) = Val(VTDato) Then
                Menu.Enabled = True
                'Menu.Visible = True
                Exit Sub
            Else
                If Val(VGTransacciones(0, VTMedio%)) < Val(VTDato) Then
                    VTMin% = VTMedio%
                    VTMedio% = VTMedio% + ((VTMax% - VTMedio%) \ 2)
                Else
                    VTMax% = VTMedio%
                    VTMedio% = VTMin% + ((VTMedio% - VTMin%) \ 2)
                End If
            End If
        Wend
        VTPosicion = VTPosicion + 1
    Wend
End Sub

Sub FMRegistraHuellaAValidar(TipoDoc As String, NumDoc As String, Titularidad As String, NumCuenta As String, TipoTran As String)
If TipoDoc = "" Or NumDoc = "" Or Titularidad = "" Or NumCuenta = "" Or TipoTran = "" Then
    MsgBox "Debe enviarse todos los datos del cliente para validar identidad", vbOKOnly, "FMRegistraHuella"
    VGValidaHuella = False
    Exit Sub
End If

    PMPasoValores sqlconn&, "@i_tipo_ced", 0, SQLVARCHAR&, TipoDoc
    PMPasoValores sqlconn&, "@i_ced_ruc", 0, SQLVARCHAR&, NumDoc
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "I"
    PMPasoValores sqlconn&, "@i_user", 0, SQLVARCHAR&, VGLogin
    PMPasoValores sqlconn&, "@i_id_caja", 0, SQLINT4&, "0"
    PMPasoValores sqlconn&, "@i_ref", 0, SQLVARCHAR&, NumCuenta
    PMPasoValores sqlconn&, "@i_titularidad", 0, SQLCHAR&, Titularidad
    PMPasoValores sqlconn&, "@i_trn", 0, SQLCHAR&, TipoTran 'TRANSACCION VALIDA HOMINI PARA RELACION CTA CANAL
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4&, "1610"

    If Not FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_tr_consulta_homini", True, " Ok ... Validación de huella") Then
        PMChequea sqlconn&
        VGValidaHuella = False
        MsgBox "Error registrando Cliente para Validación Documento: " + NumDoc + " Cuenta: " + NumCuenta, vbOKOnly, "Atención"
        Exit Sub
    Else
        VGValidaHuella = True
    End If
    PMChequea sqlconn&
End Sub

Sub FMVerificaHuella(NumCuenta As String, TipoTran As String)
If NumCuenta = "" Or TipoTran = "" Then
    MsgBox "Debe enviarse todos los datos del cliente para validar identidad", vbOKOnly, "FMValidaHuella"
    VGValidaHuella = False
    Exit Sub
End If

    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "V"
    PMPasoValores sqlconn&, "@i_user", 0, SQLVARCHAR&, VGLogin
    PMPasoValores sqlconn&, "@i_id_caja", 0, SQLINT4&, "0"
    PMPasoValores sqlconn&, "@i_ref", 0, SQLVARCHAR&, NumCuenta
    'PMPasoValores sqlconn&, "@i_titularidad", 0, SQLCHAR&, Titularidad
    PMPasoValores sqlconn&, "@i_trn", 0, SQLCHAR&, TipoTran 'TRANSACCION VALIDA HOMINI PARA RELACION CTA CANAL
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4&, "1610"

    PMPasoValores sqlconn&, "@o_tipo_ced", 1, SQLVARCHAR, Space(3)
    PMPasoValores sqlconn&, "@o_ced_ruc", 1, SQLVARCHAR, Space(13)
    
    If Not FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_tr_consulta_homini", True, " Ok ... Validación de huella") Then
        VGRegistraHuellaAValidar = False
    Else
        PMChequea sqlconn&
        VGTipoDocValidado = FMRetParam(sqlconn&, 1)
        VGNumDocValidado = FMRetParam(sqlconn&, 2)
        VGRegistraHuellaAValidar = True
    End If
End Sub

