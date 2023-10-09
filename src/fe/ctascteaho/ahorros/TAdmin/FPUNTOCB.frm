VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FPUNTOCB 
   BackColor       =   &H00C0C0C0&
   Caption         =   "Mantenimiento de Puntos de Atención"
   ClientHeight    =   6345
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9675
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   6345
   ScaleWidth      =   9675
   Begin VB.Frame Frame1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Tipo de Persona"
      ForeColor       =   &H00800000&
      Height          =   615
      Left            =   3360
      TabIndex        =   27
      Top             =   120
      Width           =   3375
      Begin VB.OptionButton OptPersona 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Persona Juridica"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   1
         Left            =   1680
         TabIndex        =   2
         Top             =   240
         Value           =   -1  'True
         Width           =   1575
      End
      Begin VB.OptionButton OptPersona 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Persona Natural"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   28
         Top             =   240
         Width           =   1455
      End
   End
   Begin VB.TextBox txtEstado 
      Height          =   285
      Left            =   5520
      MaxLength       =   10
      TabIndex        =   9
      Top             =   1590
      Width           =   495
   End
   Begin VB.TextBox txtNombre 
      Height          =   285
      Left            =   2040
      MaxLength       =   100
      TabIndex        =   3
      Top             =   840
      Width           =   4695
   End
   Begin VB.TextBox txtDireccion 
      Height          =   285
      Left            =   2040
      MaxLength       =   150
      TabIndex        =   8
      Top             =   2685
      Width           =   6540
   End
   Begin VB.TextBox txtCiudad 
      Height          =   285
      Left            =   2040
      MaxLength       =   10
      TabIndex        =   7
      Top             =   2325
      Width           =   735
   End
   Begin VB.TextBox txtDepto 
      Height          =   285
      Left            =   2040
      MaxLength       =   10
      TabIndex        =   6
      Top             =   1950
      Width           =   735
   End
   Begin VB.TextBox txtTipoDoc 
      Height          =   285
      Left            =   2040
      MaxLength       =   2
      TabIndex        =   4
      Top             =   1200
      Width           =   735
   End
   Begin VB.TextBox txtCodPunto 
      Height          =   285
      Left            =   2040
      MaxLength       =   10
      TabIndex        =   1
      Top             =   75
      Width           =   1215
   End
   Begin MSGrid.Grid grdPuntos 
      Height          =   3015
      Left            =   120
      TabIndex        =   24
      Top             =   3240
      Width           =   8415
      _Version        =   65536
      _ExtentX        =   14843
      _ExtentY        =   5318
      _StockProps     =   77
      BackColor       =   16777215
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   0
      Left            =   8760
      TabIndex        =   10
      Tag             =   "388;389"
      Top             =   120
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "&Buscar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FPUNTOCB.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   1
      Left            =   8760
      TabIndex        =   11
      Tag             =   "388;389"
      Top             =   960
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "Si&guiente"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
      Picture         =   "FPUNTOCB.frx":1592
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   2
      Left            =   8760
      TabIndex        =   12
      Top             =   1800
      WhatsThisHelpID =   2007
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1614
      _ExtentY        =   1455
      _StockProps     =   78
      Caption         =   "&Transmitir"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FPUNTOCB.frx":1E6C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   4
      Left            =   8760
      TabIndex        =   13
      Top             =   4200
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "&Limpiar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FPUNTOCB.frx":21E2
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   5
      Left            =   8760
      TabIndex        =   14
      Top             =   5040
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "&Salir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FPUNTOCB.frx":2ABC
   End
   Begin MSMask.MaskEdBox txtNumDoc 
      Height          =   285
      Left            =   2040
      TabIndex        =   5
      Tag             =   "1306"
      Top             =   1560
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      MaxLength       =   16
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      PromptChar      =   "_"
   End
   Begin VB.Label lblEstado 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   6090
      TabIndex        =   26
      Top             =   1605
      Width           =   2460
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Estado:"
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
      Index           =   7
      Left            =   4680
      TabIndex        =   25
      Top             =   1605
      Width           =   660
   End
   Begin VB.Label lblCiudad 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   2880
      TabIndex        =   23
      Top             =   2325
      Width           =   5700
   End
   Begin VB.Label lblDepartamento 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   2880
      TabIndex        =   22
      Top             =   1965
      Width           =   5700
   End
   Begin VB.Label lblDescTipoDoc 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   2880
      TabIndex        =   21
      Top             =   1215
      Width           =   5700
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   0
      X2              =   8640
      Y1              =   3120
      Y2              =   3120
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre:"
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
      Index           =   0
      Left            =   120
      TabIndex        =   20
      Top             =   840
      Width           =   720
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8640
      X2              =   8640
      Y1              =   0
      Y2              =   6240
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Dirección:"
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
      Index           =   6
      Left            =   120
      TabIndex        =   19
      Top             =   2685
      Width           =   885
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Ciudad:"
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
      Index           =   5
      Left            =   120
      TabIndex        =   18
      Top             =   2325
      Width           =   660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Departamento:"
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
      Index           =   4
      Left            =   120
      TabIndex        =   17
      Top             =   1965
      Width           =   1260
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Nro. Identificación:"
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
      Index           =   3
      Left            =   120
      TabIndex        =   16
      Top             =   1605
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Identificación:"
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
      Index           =   2
      Left            =   120
      TabIndex        =   15
      Top             =   1260
      Width           =   1665
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Cod Punto:"
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
      Index           =   1
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   960
   End
End
Attribute VB_Name = "FPUNTOCB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FConsMovCB.frm
' NOMBRE LOGICO:    FCONSMOVCB
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
' Permite realizar el mantenimiento del punto de CB
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 13-Ene-14      C. Avendaño     Emisión Inicial
'*************************************************************
Option Explicit
Dim VLOperacion As String
Dim VLValida As Boolean
'! removed Dim VLMTipoDoc(15) As String

Dim VLTipoDoc As String
Dim VLValidaD As String
Dim VLPaso As Integer
Dim VTR As Integer
Dim VGProvincia As String
Dim VGNumero As String

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0 'Buscar
        PLBuscar
    Case 1 '
        PLSiguientes
    Case 2 'Transmitir
        If VLOperacion = "I" Then
            PLTransmitir
        End If
        If VLOperacion = "U" Then
            PLModificar
        End If
    Case 4 'Limpiar
        PLLimpiar
    Case 5 ' Salir
        Unload FPUNTOCB
    End Select
End Sub
Sub PLSiguientes()
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "397"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
    PMPasoValores sqlconn&, "@i_codigo_cb", 0, SQLINT4&, VGCorresponsal
    grdPuntos.Row = grdPuntos.Rows - 1
    grdPuntos.Col = grdPuntos.Cols - 1
    PMPasoValores sqlconn&, "@i_codigo_punto", 0, SQLVARCHAR&, grdPuntos.Text
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2&, "1"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_punto_red_cb", True, "") Then
        PMMapeaGrid sqlconn&, grdPuntos, True
        PMChequea sqlconn&
        If Val(grdPuntos.Tag) = 20 Then
            cmdBoton(1).Enabled = True
        Else
            cmdBoton(1).Enabled = False
        End If
        grdPuntos.Col = 11
        grdPuntos.ColWidth(11) = 1
        grdPuntos.Col = 5
        grdPuntos.ColWidth(5) = 1
        grdPuntos.Col = 7
        grdPuntos.ColWidth(7) = 1
    Else
        PMChequea sqlconn&
    End If
End Sub
Sub PLLimpiar()
    VLOperacion = "I"
    txtNombre.Text = ""
    txtCodPunto.Enabled = True
    txtCodPunto.Text = ""
    txtTipoDoc.Text = ""
    lblDescTipoDoc.Caption = ""
    txtNumDoc.Enabled = True
    txtNumDoc.Mask = ""
    txtNumDoc.Text = ""
    'txtEstado.Text = ""
    'lblEstado.Caption = ""
    txtDepto.Text = ""
    lblDepartamento.Caption = ""
    txtCiudad.Text = ""
    lblCiudad.Caption = ""
    txtDireccion.Text = ""
    txtEstado.Text = "H"
    txtEstado_lostfocus
    txtEstado.Enabled = False
    PMLimpiaG grdPuntos
    cmdBoton(1).Enabled = False
    'cmdBoton(4).Enabled = False
    cmdBoton(2).Enabled = True
End Sub
Sub PLBuscar()
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "397"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
    PMPasoValores sqlconn&, "@i_codigo_cb", 0, SQLVARCHAR&, VGCorresponsal
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2&, "0"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_punto_red_cb", True, "") Then
        PMMapeaGrid sqlconn&, grdPuntos, False
        PMChequea sqlconn&
        If Val(grdPuntos.Tag) = 20 Then
            cmdBoton(1).Enabled = True
        Else
            cmdBoton(1).Enabled = False
        End If
        If Val(grdPuntos.Tag) > 20 Then
            grdPuntos.Col = 11
            grdPuntos.ColWidth(11) = 1
            grdPuntos.Col = 5
            grdPuntos.ColWidth(5) = 1
            grdPuntos.Col = 7
            grdPuntos.ColWidth(7) = 1
        End If
    Else
        PMChequea sqlconn&
    End If
End Sub

Private Sub Form_Load()
    Me.Width = 9795
    Me.Height = 6855
    Me.Top = 30
    Me.Left = 30
    VLOperacion = "I"
    txtEstado.Text = "H"
    txtEstado_lostfocus
    txtEstado.Enabled = False
    cmdBoton(4).Enabled = False
    'txtNombre.SetFocus
End Sub

Private Sub grdPuntos_DblClick()
    txtEstado.Enabled = True
    VLOperacion = "U"
    grdPuntos.Col = 11
    grdPuntos.ColWidth(11) = 1
    VLTipoDoc = grdPuntos.Text
    If VLTipoDoc = "C" Then
        OptPersona(1).Value = True
    Else
        OptPersona(0).Value = True
    End If
    grdPuntos.Col = 1
    txtCodPunto.Text = grdPuntos.Text
    txtCodPunto.Enabled = False
    grdPuntos.Col = 2
    txtNombre.Text = grdPuntos.Text
    grdPuntos.Col = 3
    txtTipoDoc.Text = grdPuntos.Text
    txtTipoDoc_LostFocus
    grdPuntos.Col = 4
    txtNumDoc.Mask = ""
    txtNumDoc.Text = grdPuntos.Text
    txtNumDoc_LostFocus
    'txtNumDocDig.Text = grdPuntos.Text
    grdPuntos.Col = 5
    grdPuntos.ColWidth(5) = 1
    txtDepto.Text = grdPuntos.Text
    grdPuntos.Col = 6
    lblDepartamento.Caption = grdPuntos.Text
    grdPuntos.Col = 7
    grdPuntos.ColWidth(7) = 1
    txtCiudad.Text = grdPuntos.Text
    grdPuntos.Col = 8
    lblCiudad.Caption = grdPuntos.Text
    grdPuntos.Col = 9
    txtDireccion.Text = grdPuntos.Text
    grdPuntos.Col = 10
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
    txtEstado.Text = Mid$(grdPuntos.Text, 1, 1)
    txtEstado_lostfocus
End Sub


Private Sub txtCiudad_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Código de la Ciudad  [F5] Ayuda"
End Sub

Private Sub txtCiudad_KeyDown(Keycode As Integer, Shift As Integer)
Dim VTValor As String
If Keycode% = VGTeclaAyuda% Then
   VLPaso% = True
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "A"
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
    PMPasoValores sqlconn&, "@i_provincia", 0, SQLINT2&, txtDepto.Text 'txtLugarDI.Text
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1300"
    PMPasoValores sqlconn&, "@i_pais", 0, SQLINT2&, 1
    PMHelpG "cobis", "sp_ciuxdept", 6, 1
    PMBuscarG 1, "@i_operacion", "H", SQLCHAR&
    PMBuscarG 2, "@i_tipo", "A", SQLCHAR&
    PMBuscarG 3, "@i_modo", "0", SQLINT1&
    PMBuscarG 4, "@t_trn", "1300", SQLINT2&
    PMBuscarG 5, "@i_pais", VGPais$, SQLINT2&
    VTValor$ = txtDepto.Text
    PMBuscarG 6, "@i_provincia", VTValor$, SQLINT2&
     PMSigteG 1, "@i_ciudad", 1, SQLINT4&
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_ciuxdept", True, "Ayuda Ciudad") Then
        PMMapeaGrid sqlconn&, grid_valores.gr_SQL, False
        PMChequea sqlconn&
        PMProcesG
        'NVR cambio ancho de columnas
        grid_valores!gr_SQL.ColWidth(1) = 800
        grid_valores!gr_SQL.ColWidth(2) = 2600
        grid_valores!gr_SQL.ColWidth(3) = 2600
        'fin arrreglo
        grid_valores.Show 1
        If Temporales(1) <> "" Then
            txtCiudad.Text = Temporales(1)
            lblCiudad.Caption = Temporales(2)
            VLPaso% = True
            SendKeys "{TAB}"
        End If
    Else
        VLPaso% = False
    End If
End If
End Sub

Private Sub txtCiudad_KeyPress(KeyAscii As Integer)
    If (KeyAscii <> 8) And (KeyAscii% <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub txtCiudad_LostFocus()
    ReDim VTArreglo(2) As String
    Dim VGnvr As Integer
    txtCiudad.Text = Trim$(txtCiudad.Text)
    If txtCiudad.Text <> "" Then
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V" '"A"
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
        PMPasoValores sqlconn&, "@i_pais", 0, SQLINT2&, VGPais$
        PMPasoValores sqlconn&, "@i_provincia", 0, SQLINT2&, (txtDepto.Text) 'VGProvincia$
        PMPasoValores sqlconn&, "@i_ciudad", 0, SQLINT4&, (txtCiudad.Text)
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1300" '"1550"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_ciuxdept", True, "Ayuda Ciudad") Then
            VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
            lblCiudad.Caption = VTArreglo(1)
            PMChequea sqlconn&
            VGnvr = 1    '  DDU....
        Else
            txtCiudad.Text = ""
            lblCiudad.Caption = ""
            txtCiudad.SetFocus
            txtCiudad.Refresh
        End If
    Else
        txtCiudad.Text = Trim$(txtCiudad.Text)
        lblCiudad.Caption = ""
    End If
End Sub

Private Sub txtCodPunto_Change()
If txtCodPunto.Text <> "" Then
    cmdBoton(4).Enabled = True
End If
End Sub

Private Sub txtCodPunto_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Código del Punto de Red"
End Sub

Private Sub txtCodPunto_KeyPress(KeyAscii As Integer)
    'KeyAscii% = FMVAlidaTipoDato("S", KeyAscii%)
End Sub

Private Sub txtCodPunto_LostFocus()
Dim VTR1 As Integer
If txtCodPunto.Text <> "" Then
    ReDim VTArreglo(50) As String
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4&, "397"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR&, "Q"
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT4&, 0
    PMPasoValores sqlconn&, "@i_codigo_cb", 0, SQLVARCHAR&, VGCorresponsal
    PMPasoValores sqlconn&, "@i_codigo_punto", 0, SQLVARCHAR&, (txtCodPunto.Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_punto_red_cb", True, "OK.. Verifica Código de Punto") Then
        VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
        PMChequea sqlconn&
        If VTR1% = 0 Then
            VLOperacion = "I"
        Else
            VLOperacion = "U"
            txtCodPunto.Enabled = False
            txtEstado.Enabled = True
        End If
        If VTArreglo(12) = "C" Then
            OptPersona(1).Value = True
        Else
            OptPersona(0).Value = True
        End If
        txtNombre.Text = VTArreglo(2)
        txtTipoDoc.Text = VTArreglo(3)
        txtTipoDoc_LostFocus
        txtNumDoc.Mask = ""
        txtNumDoc.Text = VTArreglo(4)
        txtDepto.Text = VTArreglo(5)
        lblDepartamento.Caption = VTArreglo(6)
        txtCiudad.Text = VTArreglo(7)
        lblCiudad.Caption = VTArreglo(8)
        txtDireccion.Text = VTArreglo(9)
        If VTArreglo(10) = "" Then
            txtEstado.Text = "H"
            txtEstado_lostfocus
        Else
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
            txtEstado.Text = Mid$(VTArreglo(10), 1, 1)
            txtEstado_lostfocus
        End If
    Else
        PMChequea sqlconn&
    End If
End If
End Sub

Private Sub txtDepto_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Código del Departamento  [F5] Ayuda"
End Sub

Private Sub txtDepto_KeyDown(Keycode As Integer, Shift As Integer)
If Keycode% = VGTeclaAyuda% Then
    VLPaso% = True
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "A"
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
    PMPasoValores sqlconn&, "@i_pais", 0, SQLINT2&, "1" 'Colombia
    'codigo de transaccion
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1550"
    PMHelpG "cobis", "sp_provincia", 5, 1
    PMBuscarG 1, "@i_operacion", "H", SQLCHAR&
    PMBuscarG 2, "@i_tipo", "A", SQLCHAR&
    PMBuscarG 3, "@i_modo", "0", SQLINT1&
    PMBuscarG 4, "@i_pais", "1", SQLINT2& 'Colombia
    PMBuscarG 5, "@t_trn", "1550", SQLINT2&
    PMSigteG 1, "@i_provincia", 1, SQLINT2&
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_provincia", True, "Ayuda Departamento") Then
        PMMapeaGrid sqlconn&, grid_valores.gr_SQL, False
        PMChequea sqlconn&
        PMProcesG
        grid_valores.Show 1
        If Temporales(1) <> "" Then
            txtDepto.Text = Temporales(1)
            VGProvincia = txtDepto.Text
            lblDepartamento.Caption = Temporales(2)
            VLPaso% = True
            SendKeys "{TAB}"
        End If
    End If
End If
End Sub

Private Sub txtDepto_KeyPress(KeyAscii As Integer)
    If (KeyAscii <> 8) And (KeyAscii% <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub txtDepto_LostFocus()
    ReDim VTArreglo(2) As String
    txtDepto.Text = Trim$(txtDepto.Text)
    If txtDepto.Text <> "" Then
        If Val(txtDepto.Text) > 32500 Then
           MsgBox "El Código del Departamento del Corresponsal no debe ser superior a 32500", 48, "Control Ingreso de Datos"
           txtDepto.Text = ""
           txtDepto.SetFocus
           VLPaso% = True
           Exit Sub
        End If
        
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V" '"A"
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
        PMPasoValores sqlconn&, "@i_pais", 0, SQLINT2&, 1
        PMPasoValores sqlconn&, "@i_provincia", 0, SQLINT2&, (txtDepto.Text)
        'codigo de transaccion
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1550"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_provincia", True, "Ayuda Departamento") Then
            VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
            PMChequea sqlconn&
            lblDepartamento.Caption = VTArreglo(1)
        Else
            txtDepto.Text = ""
            lblDepartamento.Caption = ""
            txtDepto.SetFocus
            VLPaso% = True
        End If
        PMChequea sqlconn&
    Else
        txtDepto.Text = Trim$(txtDepto.Text)
        lblDepartamento.Caption = ""
    End If
End Sub

Private Sub txtDireccion_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Dirección del Corresponsal "
End Sub

Private Sub txtDireccion_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("B", KeyAscii%)
End Sub

Private Sub txtEstado_KeyPress(KeyAscii As Integer)
If (KeyAscii% <> 8) And (KeyAscii% <> 32) And (KeyAscii% < 65 Or KeyAscii% > 90) And (KeyAscii% < 97 Or KeyAscii% > 122) Then
    KeyAscii% = 0
Else
    KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
End If
End Sub

Private Sub txtNombre_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Nombre del Codigo de Red"
End Sub

Private Sub txtNombre_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("B", KeyAscii%)
End Sub

Private Sub txtNumDoc_GotFocus()
    If txtNumDoc.ClipText <> "" Then
       VGNumero = txtNumDoc.ClipText
       VGNumero = txtNumDoc.Text
       VGNumero = FMGet_Numero(VGNumero)
    End If
    FPrincipal!pnlHelpLine.Caption = " Número de Documento "
End Sub

Private Sub txtNumDoc_KeyPress(KeyAscii As Integer)
    KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
End Sub

Private Sub txtNumDoc_LostFocus()
'*********************************************************
'Objetivo:  Calcula que el numero de cedula sea valido,
'           chequea el digito verificador
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************


Dim VLCedula As String
Dim VLRestrictivo As Boolean

    VLRestrictivo = False

    If txtNumDoc.ClipText <> "" And txtTipoDoc.Text <> "" Then
        VGNumero = txtNumDoc.ClipText
        VGNumero = FMGet_Numero(VGNumero)
'FIXIT: Replace 'LTrim' function with 'LTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
        VGNumero = LTrim$(VGNumero)

        If txtNumDoc.ClipText = "" And txtTipoDoc.Text <> "" Then
            MsgBox "El Número de la Cédula no puede ser vacio", 48, "Control Ingreso de Datos"
            Exit Sub
        End If

    Else
        If Val(txtNumDoc.ClipText) = 0 And txtTipoDoc.Text <> "" Then
            MsgBox "El Número de Identificación no puede ser vacío"
            txtNumDoc.SetFocus
            Exit Sub
        End If
    End If
End Sub

Public Sub VLControlNIT()
    Dim VLNitc As String
    Dim VTResul As Integer
    If txtNumDoc.ClipText <> "" Then 'JSA 20160516 MIGRACION COBIS CLOUD And txtNumDocDig.ClipText <> "" Then
       If VGMTipoDoc(7) = "S" Then
            VLNitc$ = txtNumDoc.ClipText 'JSA 20160516 MIGRACION COBIS CLOUD + txtNumDocDig.ClipText
            VLNitc$ = FMGet_Numero(VLNitc$)
            VTResul% = FMValidaNit(VLNitc$)
            If VTResul% = 0 Then
                MsgBox "Dígito de chequeo incorrecto "
                txtNumDoc.Visible = True
                txtNumDoc.SetFocus
                Exit Sub
             End If
        End If
        PLValidaDocP VLNitc$
    End If
End Sub

Private Sub txtTipoDoc_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Tipo de Documento [F5] Ayuda"
End Sub

Private Sub txtTipoDoc_KeyDown(Keycode As Integer, Shift As Integer)
Dim VLTipoDato As String
If Keycode% = VGTeclaAyuda% Then
    VLPaso% = True
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1115"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "A"
    If OptPersona(0).Value Then
        PMPasoValores sqlconn&, "@i_subtipo", 0, SQLCHAR&, "P"
    Else
        PMPasoValores sqlconn&, "@i_subtipo", 0, SQLCHAR&, "C"
    End If
    PMHelpG "cobis", "sp_tipodoc", 3, 1
    PMBuscarG 1, "@t_trn", "1115", SQLINT2&
    PMBuscarG 2, "@i_tipo", "A", SQLCHAR&
    If OptPersona(0).Value Then
        PMBuscarG 3, "@i_subtipo", "P", SQLCHAR&
    Else
        PMBuscarG 3, "@i_subtipo", "C", SQLCHAR&
    End If
    PMSigteG 1, "@i_codigo", 1, SQLCHAR&
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_tipodoc", True, "Ayuda Tipo Documento") Then
        PMMapeaGrid sqlconn&, grid_valores!gr_SQL, False
        PMChequea sqlconn&
        PMProcesG
        grid_valores.Show 1
        If Temporales(1) <> "" Then
            txtTipoDoc.Text = Temporales(1)
            lblDescTipoDoc.Caption = Temporales(2)
            If OptPersona(1).Value = True Then
                ReDim VTMatriz(7, 1) As String
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1115"
                PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
                PMPasoValores sqlconn&, "@i_subtipo", 0, SQLVARCHAR&, "C"
                PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR&, (txtTipoDoc.Text)
                If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_tipodoc", True, "Ayuda Tipo de Identificación") Then
                    VTR% = FMMapeaMatriz(sqlconn&, VTMatriz())
                    txtNumDoc.MaxLength = VTMatriz(2, 1)
                    txtNumDoc.Mask = VTMatriz(1, 1)
                    VLTipoDato = VTMatriz(3, 1)
                    VLValidaD = VTMatriz(6, 1)
                    PMChequea sqlconn&
                Else
                    VLPaso% = False
                    txtTipoDoc_LostFocus
                End If
            End If
            If txtTipoDoc.Text <> "" Then
                If OptPersona(0).Value = True Then
                    PMValida_TipoDoc txtTipoDoc.Text, "P"
                Else
                    PMValida_TipoDoc txtTipoDoc.Text, "C"
                End If
    
               lblDescTipoDoc.Caption = VGMTipoDoc(1)
               VLPaso = True
    
            End If
            VLPaso% = True
            SendKeys "{TAB}"
        Else
           VLPaso% = False
           If txtTipoDoc.Text <> "" Then
            txtTipoDoc_LostFocus
           End If
        End If
    End If
End If
End Sub

Private Sub txtTipoDoc_KeyPress(KeyAscii As Integer)
    If (KeyAscii% <> 8) And (KeyAscii% <> 32) And (KeyAscii% < 65 Or KeyAscii% > 90) And (KeyAscii% < 97 Or KeyAscii% > 122) Then
        KeyAscii% = 0
    Else
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    End If
End Sub

Private Sub txtTipoDoc_LostFocus()
If txtTipoDoc.Text <> "" Then
    If OptPersona(0).Value = True Then
        PMValida_TipoDoc txtTipoDoc.Text, "P"
    Else
        PMValida_TipoDoc txtTipoDoc.Text, "C"
    End If
    If VGMTipoDoc(1) = "" Then
        txtTipoDoc.Text = ""
        lblDescTipoDoc.Caption = ""
        If txtTipoDoc.Enabled Then
            txtTipoDoc.SetFocus
            Exit Sub
        End If
    End If
    lblDescTipoDoc.Caption = VGMTipoDoc(1)
    VLPaso = True
    If Tag = "U" Then
        'ELA no limpiar el numero de identificacion txtCedula.Mask = VGMTipoDoc(2)
    Else
        txtNumDoc.Mask = VGMTipoDoc(2)
    End If
Else
    lblDescTipoDoc.Caption = ""
End If
End Sub
Sub PLModificar()
    PLValidarCampos
    If VLValida = True Then
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "397"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, VLOperacion
        PMPasoValores sqlconn&, "@i_codigo_punto", 0, SQLVARCHAR&, txtCodPunto.Text
        PMPasoValores sqlconn&, "@i_codigo_cb", 0, SQLVARCHAR&, VGCorresponsal
        PMPasoValores sqlconn&, "@i_nombre", 0, SQLVARCHAR&, txtNombre.Text
        PMPasoValores sqlconn&, "@i_tipo_ced", 0, SQLVARCHAR&, txtTipoDoc.Text
        PMPasoValores sqlconn&, "@i_ced_ruc", 0, SQLVARCHAR&, txtNumDoc.ClipText
        PMPasoValores sqlconn&, "@i_cod_depto", 0, SQLVARCHAR&, txtDepto.Text
        PMPasoValores sqlconn&, "@i_cod_ciudad", 0, SQLVARCHAR&, txtCiudad.Text
        PMPasoValores sqlconn&, "@i_direccion", 0, SQLVARCHAR&, txtDireccion.Text
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR&, txtEstado.Text
        If OptPersona(0).Value Then
            PMPasoValores sqlconn&, "@i_tipo_p", 0, SQLCHAR&, "P"
        Else
            PMPasoValores sqlconn&, "@i_tipo_p", 0, SQLCHAR&, "C"
        End If
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_punto_red_cb", True, "") Then
            PMChequea sqlconn&
            MsgBox "REGISTRO MODIFICADO EXITOSAMENTE", vbInformation
            PLLimpiar
            PLBuscar
        Else
            PMChequea sqlconn&
        End If
    End If
End Sub
Sub PLTransmitir()
    PLValidarCampos
    If VLValida = True Then
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "397"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, VLOperacion
        PMPasoValores sqlconn&, "@i_codigo_punto", 0, SQLVARCHAR&, txtCodPunto.Text
        PMPasoValores sqlconn&, "@i_codigo_cb", 0, SQLVARCHAR&, VGCorresponsal
        PMPasoValores sqlconn&, "@i_nombre", 0, SQLVARCHAR&, txtNombre.Text
        PMPasoValores sqlconn&, "@i_tipo_ced", 0, SQLVARCHAR&, txtTipoDoc.Text
        PMPasoValores sqlconn&, "@i_ced_ruc", 0, SQLVARCHAR&, txtNumDoc.ClipText
        PMPasoValores sqlconn&, "@i_cod_depto", 0, SQLVARCHAR&, txtDepto.Text
        PMPasoValores sqlconn&, "@i_cod_ciudad", 0, SQLVARCHAR&, txtCiudad.Text
        PMPasoValores sqlconn&, "@i_direccion", 0, SQLVARCHAR&, txtDireccion.Text
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR&, txtEstado.Text
        If OptPersona(0).Value Then
            PMPasoValores sqlconn&, "@i_tipo_p", 0, SQLCHAR&, "P"
        Else
            PMPasoValores sqlconn&, "@i_tipo_p", 0, SQLCHAR&, "C"
        End If
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_punto_red_cb", True, "") Then
            PMChequea sqlconn&
            MsgBox "REGISTRO INGRESADO EXITOSAMENTE", vbInformation
            PLLimpiar
            PLBuscar
            cmdBoton(2).Enabled = False
        Else
            PMChequea sqlconn&
        End If
    End If
End Sub

Sub PLValidarCampos()
    If txtCodPunto.Text = "" Then
        MsgBox "EL CODIGO DEL PUNTO ES REQUERIDO", vbInformation
        txtCodPunto.SetFocus
        cmdBoton(4).Enabled = False
        VLValida = False
        Exit Sub
    End If
    If txtNombre.Text = "" Then
        MsgBox "EL NOMBRE DEL PUNTO ES REQUERIDO", vbInformation
        txtNombre.SetFocus
        VLValida = False
        Exit Sub
    End If
    If txtTipoDoc.Text = "" Then
        MsgBox "EL TIPO DE DOCUMENTO ES REQUERIDO", vbInformation
        txtTipoDoc.SetFocus
        VLValida = False
        Exit Sub
    End If
    If txtNumDoc.Text = "" Then
        MsgBox "EL NUMERO DE DOCUMENTO ES REQUERIDO", vbInformation
        txtNumDoc.SetFocus
        VLValida = False
        Exit Sub
    End If
    If txtDepto.Text = "" Then
        MsgBox "EL DEPARTAMENTO ES REQUERIDO", vbInformation
        txtDepto.SetFocus
        VLValida = False
        Exit Sub
    End If
    If txtCiudad.Text = "" Then
        MsgBox "LA CIUDAD ES REQUERIDA", vbInformation
        txtCiudad.SetFocus
        VLValida = False
        Exit Sub
    End If
    If txtDireccion.Text = "" Then
        MsgBox "LA DIRECCION ES REQUERIDA", vbInformation
        txtDireccion.SetFocus
        VLValida = False
        Exit Sub
    End If
    VLValida = True
End Sub
Private Sub txtEstado_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Estado [F5] Ayuda"
End Sub

Private Sub txtEstado_KeyDown(Keycode As Integer, Shift As Integer)
If Keycode% = VGTeclaAyuda% Then
   txtEstado.Text = ""
   lblEstado.Caption = ""
   PMLimpiaG grid_valores!gr_SQL
   PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "A"
   PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, "re_estado_servicio"
   PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
   If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, "Ayuda Acción del Cliente") Then
      PMMapeaGrid sqlconn&, grid_valores!gr_SQL, False
      PMChequea sqlconn&
      PMProcesG
      grid_valores.Show 1
      If Temporales(1) <> "" Then
         txtEstado.Text = Temporales(1)
         lblEstado.Caption = Temporales(2)
      Else
         txtEstado.Text = ""
         txtEstado.SetFocus
         lblEstado.Caption = ""
      End If
   End If
End If
End Sub
Private Sub txtEstado_lostfocus()
If VLPaso% = False Then
    If txtEstado.Text <> "" Then
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_estado_servicio"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtEstado.Text)
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta del parámetro " & "[" & txtEstado.Text & "]") Then
             PMMapeaObjeto sqlconn&, lblEstado
             PMChequea sqlconn&
        Else
            VLPaso% = True
            txtEstado.Text = ""
            lblEstado.Caption = ""
            'txtCampo(1).SetFocus
        End If
    Else
        lblEstado.Caption = ""
    End If
End If
End Sub

Public Sub PLValidaDocP(VLCedula As String)
    If txtTipoDoc.Text = "" Then
        MsgBox "Tipo de Identificación es obligatorio"
        If txtTipoDoc.Enabled Then txtTipoDoc.SetFocus
        Exit Sub
    End If

    If VLCedula$ = "" Then
        MsgBox "No. de Identificación es obligatoria"
        If txtNumDoc.Enabled Then txtNumDoc.SetFocus
        Exit Sub
    End If
End Sub

'FIXIT: Declare 'VLCedula' with an early-bound data type                                   FixIT90210ae-R1672-R1B8ZE
Public Sub VLValida_Cliente(VLCedula)
' FRI 01/29/2007 NR598 validacion de doc. existente enla base de datos
   
    Dim VLTipDoc As String
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "V"
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, 105
    PMPasoValores sqlconn&, "@i_ruc", 0, SQLVARCHAR&, VLCedula
    PMPasoValores sqlconn&, "@i_tipo_nit", 0, SQLVARCHAR&, txtTipoDoc.Text
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_compania_ins", True, "Cliente") Then
        PMMapeaVariable sqlconn&, VLTipDoc$
        PMChequea sqlconn&
        If VLTipDoc$ <> "1" Then
            If MsgBox("Desea continuar?", vbInformation + vbYesNo, App.Title) = vbNo Then
                'cmdComando_Click (1)
                txtNumDoc.Text = ""
                'JSA 20160516 MIGRACION COBIS CLOUD txtNumDocDig.Text = ""
                Exit Sub
            End If
            If VLTipDoc$ = txtTipoDoc.Text Then
                MsgBox "El Tipo de documento no puede ser igual al que se tiene en la BD para ese numero"
                Exit Sub
            End If
        End If
    End If
    PMChequea sqlconn&
End Sub

