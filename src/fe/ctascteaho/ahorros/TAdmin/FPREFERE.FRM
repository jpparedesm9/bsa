VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FPreferencias 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Preferencias"
   ClientHeight    =   2565
   ClientLeft      =   1620
   ClientTop       =   2385
   ClientWidth     =   6165
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "MS Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   Icon            =   "FPREFERE.frx":0000
   LinkMode        =   1  'Source
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2565
   ScaleWidth      =   6165
   Begin VB.CommandButton bb_cancelar 
      Appearance      =   0  'Flat
      Caption         =   "*&Cancelar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   405
      Left            =   4560
      TabIndex        =   6
      Top             =   1110
      WhatsThisHelpID =   2012
      Width           =   1545
   End
   Begin VB.CommandButton bb_ok 
      Appearance      =   0  'Flat
      Caption         =   "*&Ok"
      Default         =   -1  'True
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   405
      Left            =   4560
      TabIndex        =   5
      Top             =   690
      WhatsThisHelpID =   2041
      Width           =   1545
   End
   Begin VB.CommandButton bb_restablecer 
      Appearance      =   0  'Flat
      Caption         =   "*&Restablecer"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   405
      Left            =   4560
      TabIndex        =   4
      Top             =   1575
      WhatsThisHelpID =   2013
      Width           =   1545
   End
   Begin MSGrid.Grid gr_preferencias 
      Height          =   1710
      Left            =   75
      TabIndex        =   3
      Top             =   690
      Width           =   4440
      _Version        =   65536
      _ExtentX        =   7832
      _ExtentY        =   3016
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Rows            =   10
      FixedRows       =   0
      FixedCols       =   0
   End
   Begin VB.CommandButton bb_restablecer_all 
      Appearance      =   0  'Flat
      Caption         =   "*Restablecer &Todo"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   405
      Left            =   4560
      TabIndex        =   2
      Top             =   1995
      WhatsThisHelpID =   2014
      Width           =   1545
   End
   Begin VB.ComboBox cmbPreferencia 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   585
      TabIndex        =   1
      Top             =   405
      Width           =   3930
   End
   Begin Threed.SSRibbon cmdSeleccion 
      Height          =   300
      Index           =   0
      Left            =   75
      TabIndex        =   7
      Top             =   405
      Width           =   255
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   65
      BackColor       =   -2147483633
      Enabled         =   0   'False
      PictureUp       =   "FPREFERE.frx":1042
      PictureDisabled =   "FPREFERE.frx":112C
   End
   Begin Threed.SSRibbon cmdSeleccion 
      Height          =   300
      Index           =   1
      Left            =   330
      TabIndex        =   8
      Top             =   405
      Width           =   255
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   65
      BackColor       =   -2147483633
      Enabled         =   0   'False
      GroupAllowAllUp =   -1  'True
      PictureUp       =   "FPREFERE.frx":1216
      PictureDisabled =   "FPREFERE.frx":1300
   End
   Begin VB.Label il_preferencia 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Preferencia:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Left            =   105
      TabIndex        =   0
      Top             =   165
      Width           =   1050
   End
End
Attribute VB_Name = "FPreferencias"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*********************************************************
'   Archivo:        FPREFERE.BAS
'   Producto:       Master Information Subsystem
'   Diseñado por:   Myriam Dávila
'   Fecha de Documentación: 14/Ene/94
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
' Forma:    FPreferencias
' Descripción:  Esta forma permite modificar las preferen-
'               cias para esta aplicación. Se consideran
'               preferencias el código de la Filial, Ofi-
'               cina, nombre del Servidor, login del usua-
'               rio, rol del usuario, etc.
' VARIABLES GLOBALES:
'           ServerName$         nombre del servidor
' MODULOS
'   MODINI.BAS = rutinas para utilizar las preferencias.
'*********************************************************
Option Explicit
Dim VLP As String
'! removed Dim VTMonedaDescripcion As String
'! removed Dim VTMoneda As String

Dim VTCambios() As String
Dim VGPaso As Integer
Dim j As Integer
Dim i As Integer
Dim VTpos As Integer
Dim VTPref As String

Private Sub bb_cancelar_Click()
'*********************************************************
'Objetivo:  Oculta la forma de preferencias e ignora los
'           cambios realizados
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPreferencias.Hide
    For j% = 1 To UBound(VTCambios)
        For i% = 0 To gr_preferencias.Rows - 1
            gr_preferencias.Row = i%
            gr_preferencias.Col = 0
            If gr_preferencias.Text = VTCambios(j%) Then
                gr_preferencias.Col = 1
                gr_preferencias.Text = Get_Preferencia(VTCambios(j%))
            End If
        Next i%
    Next j%
    ReDim VTCambios(0)
    cmbPreferencia.Text = ""
End Sub

Private Sub bb_cancelar_GotFocus()
'*********************************************************
'Objetivo:  Despliega el Mensaje de Ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlHelpLine.Caption = " Salir y Cancelar los Cambios Realizados"
End Sub

Private Sub bb_ok_Click()
'*********************************************************
'Objetivo:  Oculta la forma de preferencias y acepta los
'           cambios realizados
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    If cmbPreferencia.Text <> "" Then
        VTpos% = InStr(1, cmbPreferencia.Text, " - ")
        If VTpos% > 0 Then
            VTPref$ = LTrim$(RTrim$(Mid$(cmbPreferencia.Text, 1, VTpos% - 1)))
        Else
            VTPref$ = LTrim$(RTrim$(cmbPreferencia.Text))
        End If
        Set_Preferencia VLP$, VTPref$
        Set_Forma_Preferencia VLP$, LTrim$(RTrim$(cmbPreferencia.Text))
        For i% = 1 To UBound(VTCambios)
            For j% = 0 To gr_preferencias.Rows - 1
                gr_preferencias.Row = j%
                gr_preferencias.Col = 0
                If VTCambios(i%) = gr_preferencias.Text Then
                    gr_preferencias.Col = 1
                    VTpos% = InStr(1, gr_preferencias.Text, " - ")
                    If VTpos% > 0 Then
                        VTPref$ = Trim$(Mid$(gr_preferencias.Text, 1, VTpos% - 1))
                    Else
                        VTPref$ = Trim$(gr_preferencias.Text)
                    End If
                    Set_Preferencia VTCambios(i%), VTPref$
                End If
            Next j%
        Next i%
        ReDim VTCambios(0)
    End If
    FPreferencias.Hide
'******************************************************************
'CloVargas Oct/19/01 Agregar código para manejo de Formato de Fecha
'******************************************************************
    VGFormatoFecha = Get_Preferencia("FORMATO-FECHA")
    PMCargar_FechaSP (VGFormatoFecha)
End Sub

Private Sub bb_ok_GotFocus()
'*********************************************************
'Objetivo:  Despliega el Mensaje de Ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlHelpLine.Caption = " Salir y Aceptar los Cambios Realizados"
End Sub

Private Sub bb_restablecer_all_Click()
'*********************************************************
'Objetivo:  Vuelve a cargar los valores de preferencias
'           en el archivo .ini
'           Esta rutina no tiene CANCELAR
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    Iniciar_Preferencias (ARCHIVOINI)
    Forma_Preferencias
    gr_preferencias.Row = 0
    gr_preferencias_Click
End Sub

Private Sub bb_restablecer_all_GotFocus()
'*********************************************************
'Objetivo:  Despliega el Mensaje de Ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlHelpLine.Caption = " Restablecer los Valores Iniciales"
End Sub

Private Sub bb_restablecer_Click()
'*********************************************************
'Objetivo:  Busca en el archivo .ini el valor del TOKEN
'           seleccionado del grid y lo trae nuevamente a
'           memoria y al grid.
'           Esta rutina no tiene CANCELAR
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    Dim FNum As Integer
    Dim Filename As String
    Filename$ = ARCHIVOINI
    FNum = Abrir_Archivo(Filename$)
    If FNum > 0 Then
        For i% = 1 To UBound(Preferencias, 1)
            If Preferencias(i%, 1) = VLP$ Then
                Preferencias(i%, 2) = Buscar_Token(FNum, VLP$)
                Set_Forma_Preferencia VLP$, Preferencias(i%, 2)
                Close (FNum)
                gr_preferencias_Click
                Exit Sub
            End If
        Next i%
    End If
End Sub

Private Sub bb_restablecer_GotFocus()
'*********************************************************
'Objetivo:  Despliega el Mensaje de Ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlHelpLine.Caption = " Anular el último cambio realizado"
End Sub

Private Sub cmbPreferencia_GotFocus()
'*********************************************************
'Objetivo:  Despliega el Mensaje de Ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlTransaccionLine.Caption = ""
    cmdSeleccion(0).Enabled = True
    cmdSeleccion(1).Enabled = True
    VGPaso% = True
    Select Case VLP$
    Case "TERMINAL"
        FPrincipal!pnlHelpLine.Caption = "Ingrese el Nombre de la Terminal"
    Case "USUARIO"
        FPrincipal!pnlHelpLine.Caption = "Ingrese el Login del Usuario de la Terminal"
    Case "SERVIDOR"
        FPrincipal!pnlHelpLine.Caption = "Ingrese el Nombre del Servidor al que se conectará la Terminal"
    Case "FILIAL"
        FPrincipal!pnlHelpLine.Caption = "Ingrese el Código de la Filial"
    Case "OFICINA"
        FPrincipal!pnlHelpLine.Caption = "Ingrese el Código de la Sucursal"
    Case "ROL"
        FPrincipal!pnlHelpLine.Caption = "Ingrese el Código del Rol con el que se conecta el usuario"
    Case "IMAGENES"
        FPrincipal!pnlHelpLine.Caption = "Ingrese el Path para las Imagenes de Clientes"
    Case "FORMATO-FECHA"
        FPrincipal!pnlHelpLine.Caption = "Escoja un Formato de Fecha"
    Case "DEBUG"
        FPrincipal!pnlHelpLine.Caption = "Escoja Opción de Debug"
    Case "ARCHIVO-LOG"
        FPrincipal!pnlHelpLine.Caption = "Nombre de archivo para Log Local"
    Case Else
    End Select
End Sub

Private Sub cmbPreferencia_KeyPress(KeyAscii As Integer)
'*********************************************************
'Objetivo:  Forza el contenido del texto al tipo de dato
'           del TOKEN escogido en el grid
'Input   :  KeyAscii    código de la tecla presionada
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************

    Select Case VLP$
    Case "TERMINAL"
    
    Case "USUARIO"
        If (KeyAscii% <> 8) And (KeyAscii% <> 32) And (KeyAscii% < 65 Or KeyAscii% > 90) And (KeyAscii% < 97 Or KeyAscii% > 122) Then
            KeyAscii% = 0
        Else
            KeyAscii% = Asc(LCase$(Chr$(KeyAscii%)))
        End If
                            
    Case "SERVIDOR"
        If (KeyAscii% <> 8) And (KeyAscii% <> 32) And (KeyAscii% < 65 Or KeyAscii% > 90) And (KeyAscii% < 97 Or KeyAscii% > 122) And (KeyAscii% < 48 Or KeyAscii% > 57) Then
            KeyAscii% = 0
        Else
            KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
        End If

    Case "FILIAL"
        If (KeyAscii% <> 8) And (KeyAscii% < 48 Or KeyAscii% > 57) Then
            KeyAscii% = 0
        End If
                                                                    
    Case "OFICINA"
        If (KeyAscii% <> 8) And (KeyAscii% < 48 Or KeyAscii% > 57) Then
            KeyAscii% = 0
        End If

    Case "ROL"
        If (KeyAscii% <> 8) And (KeyAscii% < 48 Or KeyAscii% > 57) Then
            KeyAscii% = 0
        End If

    Case "IMAGENES"

    Case "FORMATO-FECHA"
        KeyAscii% = 0
    Case "DEBUG"
        KeyAscii% = 0
        
    Case "ARCHIVO-LOG"

    End Select
End Sub

Private Sub cmbPreferencia_LostFocus()
'*********************************************************
'Objetivo:  Deshabilita los botones equis y visto
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    cmdSeleccion(0).Enabled = False
    cmdSeleccion(1).Enabled = False
End Sub

Private Sub cmdSeleccion_Click(Index As Integer, Value As Integer)
'*********************************************************
'Objetivo:  Si el botón es equis cancela el cambio. Si el
'           botón es visto, cambia el valor del TOKEN se-
'           ñalado
'Input   :  Index       identifica al botón
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
Dim VTpos%, VTPref$
    If Value Then
        Select Case Index
        Case 0
            cmbPreferencia.Text = ""
        Case 1
            VTpos% = InStr(1, cmbPreferencia.Text, " - ")
            If VTpos% > 0 Then
                VTPref$ = LTrim$(RTrim$(Mid$(cmbPreferencia.Text, 1, VTpos% - 1)))
            Else
                VTPref$ = LTrim$(RTrim$(cmbPreferencia.Text))
            End If
            Set_Forma_Preferencia VLP$, LTrim$(RTrim$(cmbPreferencia.Text))
            ReDim Preserve VTCambios(UBound(VTCambios) + 1)
            VTCambios(UBound(VTCambios)) = VLP$
        End Select
    End If
    If cmdSeleccion(0).Value Then
       cmdSeleccion(0).Value = False
    End If
    If cmdSeleccion(1).Value Then
        cmdSeleccion(1).Value = False
    End If
    cmdSeleccion(0).Enabled = False
    cmdSeleccion(1).Enabled = False
    bb_ok.SetFocus
End Sub

Private Sub Form_Activate()
    gr_preferencias.Row = 0
    gr_preferencias_Click
    ReDim VTCambios(0)
End Sub

Private Sub Form_Load()
    PMLoadResStrings Me
    PMLoadResIcons Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
'*********************************************************
'Objetivo:  Limpia las líneas de Mensaje y Transaccion
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub gr_preferencias_Click()
'*********************************************************
'Objetivo:  Pone el valor del TOKEN escogido en el grid
'           en el combo box superior
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
ReDim VTMatriz(0 To 2, 0 To 22) As String
Dim VTR As Integer
Dim VTItem As String
    If Val(gr_preferencias.Tag) > 0 Then
        gr_preferencias.Col = 0
        il_preferencia.Caption = gr_preferencias.Text + ":"
        VLP$ = gr_preferencias.Text
        Select Case VLP$
        Case "FILIAL"
             If sqlconn& <> 0 Then
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "A"
                'codigo de transaccion
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1571"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_filial", False, "") Then
                     VTR% = FMMapeaMatriz(sqlconn&, VTMatriz())
                    'llegaron datos?
                     PMChequea sqlconn&
                    If VTR% > 0 Then
                        'mapear a la lista
                        cmbPreferencia.Clear
                        For j% = 1 To VTR%
                            VTItem$ = VTMatriz(0, j%) + " - " + LTrim$(RTrim$(VTMatriz(1, j%)))
                            cmbPreferencia.AddItem VTItem$
                        Next j%
                        'lazo de recuperacion de 20 en 20
                        Do While VTR% > 0
                             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
                             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "1"
                             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1&, VTMatriz(0, VTR%)
                             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "A"
                            'codigo de transaccion
                             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1571"
                             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_filial", False, "") Then
                                 VTR% = FMMapeaMatriz(sqlconn&, VTMatriz())
                                'llegaron datos?
                                 PMChequea sqlconn&
                                If VTR% > 0 Then
                                    'mapear a la lista
                                    For j% = 1 To VTR%
                                        VTItem$ = VTMatriz(0, j%) + " - " + LTrim$(RTrim$(VTMatriz(1, j%)))
                                        cmbPreferencia.AddItem VTItem$
                                    Next j%
                                End If
                            Else
                                ReDim VTMatriz(0, 0)
                            End If
                        Loop
                    End If
                Else
                    cmbPreferencia.Clear
                End If
            Else
                cmbPreferencia.Clear
            End If
        Case "OFICINA"
             If sqlconn& <> 0 Then
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "AL"
                'codigo de transaccion
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1574"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_oficina", False, "") Then
                     VTR% = FMMapeaMatriz(sqlconn&, VTMatriz())
                    'llegaron datos?
                     PMChequea sqlconn&
                    If VTR% > 0 Then
                        'mapear a la lista
                        cmbPreferencia.Clear
                        For j% = 1 To VTR%
                            VTItem$ = VTMatriz(0, j%) + " - " + LTrim$(RTrim$(VTMatriz(1, j%)))
                            cmbPreferencia.AddItem VTItem$
                        Next j%
                        'lazo de recuperacion de 20 en 20
                        Do While VTR% > 0
                             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
                             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "1"
                             PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2&, VTMatriz(0, VTR%)
                             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "AL"
                            'codigo de transaccion
                             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1574"
                             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_oficina", False, "") Then
                                 VTR% = FMMapeaMatriz(sqlconn&, VTMatriz())
                                'llegaron datos?
                                 PMChequea sqlconn&
                                If VTR% > 0 Then
                                    'mapear a la lista
                                    For j% = 1 To VTR%
                                        VTItem$ = VTMatriz(0, j%) + " - " + LTrim$(RTrim$(VTMatriz(1, j%)))
                                        cmbPreferencia.AddItem VTItem$
                                    Next j%
                                End If
                            Else
                                ReDim VTMatriz(0, 0)
                            End If
                        Loop
                    End If
                Else
                    cmbPreferencia.Clear
                End If
            Else
                cmbPreferencia.Clear
            End If
        Case "FORMATO-FECHA"
            cmbPreferencia.Clear
            cmbPreferencia.AddItem "dd/mm/yyyy"
            cmbPreferencia.AddItem "mm/dd/yyyy"
            cmbPreferencia.AddItem "yyyy/mm/dd"
        Case "DEBUG"
            cmbPreferencia.Clear
            cmbPreferencia.AddItem "S - Si"
            cmbPreferencia.AddItem "N - No"
        Case Else
            cmbPreferencia.Clear
        End Select
        gr_preferencias.Col = 1
        cmbPreferencia.Text = gr_preferencias.Text
    End If
    gr_preferencias.SelStartCol = 0
    gr_preferencias.SelEndCol = gr_preferencias.Cols - 1
    gr_preferencias.SelStartRow = gr_preferencias.Row
    gr_preferencias.SelEndRow = gr_preferencias.Row

    cmbPreferencia.SetFocus
End Sub

Private Sub gr_preferencias_GotFocus()
'*********************************************************
'Objetivo:  Despliega el Mensaje de Ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlTransaccionLine.Caption = ""
    FPrincipal!pnlHelpLine.Caption = " Click para seleccionar el Item a cambiar"
End Sub


