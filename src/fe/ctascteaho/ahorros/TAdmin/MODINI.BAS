Attribute VB_Name = "MODINI"
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*********************************************************
'   ARCHIVO:        MODINI.BAS
'   NOMBRE LOGICO:  MODINI
'   PRODUCTO:       Terminal Administrativa
'*********************************************************
'                       IMPORTANTE
' Esta Aplicación es parte de los paquetes bancarios pro-
' piedad de MACOSA, representantes exclusivos para el Ecua-
' dor de la NCR CORPORATION.  Su uso no autorizado queda
' expresamente prohibido así como cualquier alteración o
' agregado hecho por alguno de sus usuarios sin el debido
' consentimiento por escrito de la Presidencia Ejecutiva
' de MACOSA o su representante
'*********************************************************
'                   PROPOSITO
' DESCRIPCION:  Este módulo contiene las rutinas necesa-
'               rias para manejar las preferencias del
'               sistema
'*********************************************************
' DECLARACIONES GLOBALES:
' Registro para almacenar los tokens y el valor
'*********************************************************
'                 MODIFICACIONES
' FECHA         AUTOR              RAZON
' 10-Ene-02     C. Milán           Emisión Inicial
'*********************************************************
Type RegistroTOK
    Token As String
    valor As String
End Type

Global PathUnico As String          'Manejo de Terminal Server

Function Abrir_Archivo(Filename As String) As Integer
'*********************************************************
'PROPOSITO: Abre un archivo y devuelve el FileHandler asig-
'           nado a ese archivo
'INPUT   :  Filename        nombre del archivo
'OUTPUT  :  Abrir_Archivo   FileHandler del archivo abierto
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'*********************************************************
    Dim FNum As String
    On Error GoTo Salir
    FNum = FreeFile
    Open Filename For Input As #FNum
    Abrir_Archivo = FNum
    Exit Function
Salir:
    Abrir_Archivo = 0
    Exit Function
End Function

Function Buscar_Token(FileNum As Integer, Token As String) As String
'*********************************************************
'PROPOSITO: Busca un Token en el archivo .ini abierto y re-
'           torna el valor asociado
'INPUT   :  FileNum         FileHandler del archivo
'           Token           Token a buscar
'OUTPUT  :  Buscar_Token    Valor del token en el archivo
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'*********************************************************
    Dim pos1 As Integer
    Dim VTLinea As String
    Seek #FileNum, 1
    Do Until EOF(FileNum)
        Line Input #FileNum, VTLinea
        If InStr(1, VTLinea, "'") = 0 Then
            If InStr(1, VTLinea, Token) > 0 Then
                pos1% = InStr(1, VTLinea, "=")
                If pos1% > 0 Then
                    Buscar_Token = Mid$(VTLinea, pos1% + 1, Len(VTLinea))
                    Exit Function
                End If
            End If
        End If
    Loop
    Buscar_Token = ""
End Function

Sub Escribir_Ini(Filename As String)
'*********************************************************
'PROPOSITO: Dado el nombre del archivo .ini escribe el
'           contenido del Arreglo Preferencias() en
'           el archivo .ini en forma TOKEN=Valor
'INPUT   :  FileName        Nombre del Archivo
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'*********************************************************
    Dim i As Integer
    Dim FNum As Integer
    Dim Linea As String
    FNum = FreeFile
    Open Filename For Output As #FNum
    If FNum > 0 Then
            Linea = "[PREFERENCIAS]"
            Print #FNum, Linea
        For i% = 1 To UBound(Preferencias, 1)
            Linea = Preferencias(i%, 1) + "=" + Preferencias(i%, 2)
            Print #FNum, Linea
        Next i%
        Close (FNum)
    End If
End Sub

Sub Forma_Preferencias()
'*********************************************************
'PROPOSITO: Toma los datos del arreglo Preferencias() y
'           copia en el grid de la forma de preferencias
'INPUT   :  ninguno
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'*********************************************************
    Dim i As Integer
    FPreferencias!gr_preferencias.Rows = UBound(Preferencias, 1)
    FPreferencias!gr_preferencias.Tag = Str$(UBound(Preferencias, 1))
    FPreferencias!gr_preferencias.ColWidth(0) = 15 * 120
    FPreferencias!gr_preferencias.ColWidth(1) = 30 * 120
    For i% = 1 To UBound(Preferencias, 1)
        FPreferencias!gr_preferencias.Row = i% - 1
        FPreferencias!gr_preferencias.Col = 0
        FPreferencias!gr_preferencias.Text = Preferencias(i%, 1)
        FPreferencias!gr_preferencias.Col = 1
        FPreferencias!gr_preferencias.Text = Preferencias(i%, 2)
    Next i%
End Sub

Function Get_Preferencia(Token As String) As String
'*********************************************************
'PROPOSITO: Dado un Token busca el valor actual del mismo
'           en el arreglo Preferencias()
'INPUT   :  Token               Token del cual se busca el valor
'OUTPUT  :  Get_Preferencia     valor actual para Token
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'*********************************************************
    Dim i As Integer
    For i% = 1 To UBound(Preferencias, 1)
        If Preferencias(i%, 1) = Token Then
            Get_Preferencia = Preferencias(i%, 2)
            Exit Function
        End If
    Next i%
    Get_Preferencia = ""
End Function

Sub Iniciar_Preferencias(Filename As String)
'*********************************************************
'PROPOSITO: Dado un nombre de Archivo, copia el contenido
'           del archivo en el arreglo Preferencias()
'INPUT   :  FileName            Nombre del archivo .ini
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'07/Jul/94  J.Bucheli           Modificación Terminal
'                               Administrativa
'*********************************************************
Dim FNum As Integer

'*********************************************************
'CloVargas Oct/18/01 Manejo de Preferencias formato fecha
'  Hay que dimensionar este arreglo exactamente al número
'  de preferencias que van a ser manejadas
'*********************************************************
' Matriz que contiene el formato de fechas
    ReDim formato_fecha(3, 2)
    formato_fecha(1, 1) = "dd/mm/yyyy"
    formato_fecha(2, 1) = "mm/dd/yyyy"
    formato_fecha(3, 1) = "yyyy/mm/dd"
    formato_fecha(1, 2) = "103"
    formato_fecha(2, 2) = "101"
    formato_fecha(3, 2) = "111"
    
    ReDim Preferencias(9, 2)
    Preferencias(1, 1) = "FILIAL"
    Preferencias(2, 1) = "OFICINA"
    Preferencias(3, 1) = "ROL"
    Preferencias(4, 1) = "SERVIDOR"
    Preferencias(5, 1) = "TERMINAL"
    Preferencias(6, 1) = "USUARIO"
    Preferencias(7, 1) = "FORMATO-FECHA"
    Preferencias(8, 1) = "DEBUG"
    Preferencias(9, 1) = "ARCHIVO-LOG"
    FNum = Abrir_Archivo(Filename)
    If FNum > 0 Then
        Preferencias(1, 2) = Buscar_Token(FNum, "FILIAL")
        Preferencias(2, 2) = Buscar_Token(FNum, "OFICINA")
        Preferencias(3, 2) = Buscar_Token(FNum, "ROL")
        Preferencias(4, 2) = Buscar_Token(FNum, "SERVIDOR")
        Preferencias(5, 2) = Buscar_Token(FNum, "TERMINAL")
        Preferencias(6, 2) = Buscar_Token(FNum, "USUARIO")
        Preferencias(7, 2) = Buscar_Token(FNum, "FORMATO-FECHA")
        If Preferencias(7, 2) = "" Then
            Preferencias(7, 2) = "yyyy/mm/dd"
        End If
      'CloVargas Oct/18/01
      'Inicializo la variable global de fecha de preferencia
        VGFormatoFecha = Get_Preferencia("FORMATO-FECHA")
      
        Preferencias(8, 2) = Buscar_Token(FNum, "DEBUG")
        If Preferencias(8, 2) = "" Then
            Preferencias(8, 2) = "N"
        End If
        Preferencias(9, 2) = Buscar_Token(FNum, "ARCHIVO-LOG")
        If Preferencias(9, 2) = "" Then
            Preferencias(9, 2) = VGPath$ & "\logtran.txt"
        End If
        Close #FNum
    End If
End Sub

Sub Set_Forma_Preferencia(Token As String, valor As String)
'*********************************************************
'PROPOSITO: Dado un Token y su Valor copia el valor en
'           el grid de la forma de Preferencias.
'INPUT   :  Token           Token a fijar
'           Valor           Valor del Token
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'*********************************************************
    Dim i As Integer
    For i% = 0 To UBound(Preferencias, 1) - 1
        FPreferencias!gr_preferencias.Row = i%
        FPreferencias!gr_preferencias.Col = 0
        If FPreferencias.gr_preferencias.Text = Token Then
            FPreferencias!gr_preferencias.Col = 1
            FPreferencias!gr_preferencias.Text = valor
            Exit Sub
        End If
    Next i%
End Sub

Sub Set_Preferencia(Token As String, valor As String)
'*********************************************************
'PROPOSITO: Dado un Token y su Valor fija el valor del
'           token en el arreglo Preferencias(). Es decir
'           efectua un cambio en memoria de una prefe-
'           rencia.
'INPUT   :  Token           Token a fijar
'           Valor           Valor del Token
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'*********************************************************
    Dim i As Integer
    For i% = 1 To UBound(Preferencias, 1)
        If Preferencias(i%, 1) = Token Then
            Select Case Token
            Case "DEBUG"
                 If sqlconn& > 0 Then
                    If valor$ = "S" Then
                         PMDebug sqlconn&, True
                        VGDebug% = True
                    Else
                         PMDebug sqlconn&, False
                        VGDebug% = True
                    End If
                End If
            Case "ARCHIVO-LOG"
                VGLogTransacciones$ = valor$
            End Select
            Preferencias(i%, 2) = valor$
        End If
    Next i%
End Sub
