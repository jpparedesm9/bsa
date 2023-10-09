VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTRAN707 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Mantenimiento de Impresión de Notas de Débitos y Créditos"
   ClientHeight    =   5340
   ClientLeft      =   1620
   ClientTop       =   2715
   ClientWidth     =   9300
   ForeColor       =   &H00FFFFFF&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5340
   ScaleWidth      =   9300
   Tag             =   "3077"
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   2
      Left            =   2200
      MaxLength       =   3
      TabIndex        =   23
      Top             =   1020
      Width           =   615
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3135
      Left            =   0
      TabIndex        =   22
      Top             =   2160
      Width           =   8295
      _Version        =   65536
      _ExtentX        =   14631
      _ExtentY        =   5530
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   0
      Left            =   8400
      TabIndex        =   15
      Top             =   4560
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*&Salir"
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
      Picture         =   "FTRAN707.frx":0000
   End
   Begin VB.ComboBox cmbCamara 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   4776
      Style           =   2  'Dropdown List
      TabIndex        =   14
      Top             =   1368
      Width           =   705
   End
   Begin VB.ComboBox cmbafecta 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   7644
      Style           =   2  'Dropdown List
      TabIndex        =   4
      Top             =   1368
      Width           =   705
   End
   Begin VB.ComboBox cmbimpresion 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   2200
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Top             =   1368
      Width           =   705
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   1
      Left            =   2200
      MaxLength       =   3
      TabIndex        =   2
      Top             =   720
      Width           =   615
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   0
      Left            =   2200
      MaxLength       =   1
      TabIndex        =   1
      Top             =   400
      Width           =   615
   End
   Begin VB.ComboBox cmbTipo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   288
      Left            =   2200
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   30
      Width           =   2500
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   1
      Left            =   8400
      TabIndex        =   16
      Top             =   3840
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*&Limpiar"
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
      Picture         =   "FTRAN707.frx":001C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   2
      Left            =   8400
      TabIndex        =   17
      Top             =   3120
      WhatsThisHelpID =   2006
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*&Eliminar"
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
      Picture         =   "FTRAN707.frx":0038
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   3
      Left            =   8400
      TabIndex        =   18
      Top             =   2400
      WhatsThisHelpID =   2031
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*&Actualizar"
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   4
      Left            =   8400
      TabIndex        =   19
      Top             =   1680
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*&Crear"
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   5
      Left            =   8400
      TabIndex        =   20
      Top             =   720
      WhatsThisHelpID =   2020
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*Siguien&tes"
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   6
      Left            =   8400
      TabIndex        =   21
      Top             =   0
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*&Buscar"
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
      Picture         =   "FTRAN707.frx":0054
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Causal Ajuste"
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
      Height          =   192
      Index           =   6
      Left            =   108
      TabIndex        =   25
      Top             =   1008
      WhatsThisHelpID =   5155
      Width           =   1224
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
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
      Height          =   288
      Index           =   2
      Left            =   2820
      TabIndex        =   24
      Top             =   1020
      Width           =   5500
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Impresión Cámara:"
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
      Height          =   192
      Index           =   5
      Left            =   3072
      TabIndex        =   13
      Top             =   1404
      Width           =   1572
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Notas de Débito/Crédito Existentes:"
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
      Height          =   270
      Index           =   3
      Left            =   0
      TabIndex        =   12
      Top             =   1920
      WhatsThisHelpID =   5158
      Width           =   3495
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8380
      X2              =   8380
      Y1              =   0
      Y2              =   5310
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8380
      Y1              =   1800
      Y2              =   1800
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Afecta Fec. Ult. Mov:"
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
      Height          =   192
      Index           =   4
      Left            =   5544
      TabIndex        =   11
      Top             =   1404
      WhatsThisHelpID =   5157
      Width           =   1920
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Impresión de Nota:"
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
      Height          =   192
      Index           =   3
      Left            =   120
      TabIndex        =   10
      Top             =   1404
      WhatsThisHelpID =   5156
      Width           =   1692
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
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
      Index           =   1
      Left            =   2820
      TabIndex        =   9
      Top             =   720
      Width           =   5500
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Causal"
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
      TabIndex        =   8
      Top             =   720
      WhatsThisHelpID =   5155
      Width           =   660
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
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
      Index           =   0
      Left            =   2820
      TabIndex        =   7
      Top             =   400
      Width           =   1905
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Signo:"
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
      TabIndex        =   6
      Top             =   400
      WhatsThisHelpID =   5154
      Width           =   630
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto: "
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
      TabIndex        =   5
      Top             =   75
      WhatsThisHelpID =   5048
      Width           =   975
   End
End
Attribute VB_Name = "FTRAN707"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTRAN707.frm
' NOMBRE LOGICO:    FTRAN707
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
' Realiza el Mantenimiento de la Impresión de las Notas de
' Débito y Crédito-
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 04-Feb-2005   L.Bernuil        Emisión Inicial
'*************************************************************
Option Explicit
Dim VLPaso As Boolean

Private Sub Form_Load()
    FTRAN707.Left = 0   '15
    FTRAN707.Top = 0   '15
    FTRAN707.Width = 9420
    FTRAN707.Height = 5820
      
    PMLoadResStrings Me
    PMLoadResIcons Me
    
    cmbTipo.AddItem "CUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORRO", 1
    cmbTipo.ListIndex = 1
    
    cmbimpresion.AddItem "S"
    cmbimpresion.AddItem "N"
    cmbimpresion.ListIndex = 1
    
    cmbafecta.AddItem "S"
    cmbafecta.AddItem "N"
    cmbafecta.ListIndex = 0
    
    cmbCamara.AddItem "S"
    cmbCamara.AddItem "N"
    cmbCamara.ListIndex = 1
    
    cmdBoton(5).Enabled = False
End Sub
Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 1, 2
        VLPaso = False
    End Select
End Sub
Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = "Signo de la Causal [F5 Ayuda]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = "Causal de la Nota de Débito/Crédito [F5 Ayuda]"
    Case 2
        FPrincipal!pnlHelpLine.Caption = "Causal de Ajuste la Nota de Débito/Crédito [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub
Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode% = VGTeclaAyuda% Then
        VLPaso = True
        txtCampo(Index%).Text = ""
        lblDescripcion(Index%).Caption = ""
        Select Case Index%
            Case 0
                PMCatalogo "A", "re_signo_ndc", txtCampo(Index%), lblDescripcion(Index%)
            Case 1
                If txtCampo(0).Text = "" Then
                    txtCampo(Index%).Text = ""
                    lblDescripcion(Index%).Caption = ""
                    Exit Sub
                End If
                
                If cmbTipo.Text = "CUENTA CORRIENTE" Then
                    If txtCampo(0).Text = "C" Then 'Credito
                        PMCatalogo "A", "cc_causa_nc", txtCampo(Index%), lblDescripcion(Index%)
                    Else
                        PMCatalogo "A", "cc_causa_nd", txtCampo(Index%), lblDescripcion(Index%)
                    End If
                Else
                    If txtCampo(0).Text = "C" Then 'Credito
                        PMCatalogo "A", "ah_causa_nc", txtCampo(Index%), lblDescripcion(Index%)
                    Else
                        PMCatalogo "A", "ah_causa_nd", txtCampo(Index%), lblDescripcion(Index%)
                    End If
                    
                End If
            Case 2
                If txtCampo(0).Text = "" Then
                    txtCampo(Index%).Text = ""
                    lblDescripcion(Index%).Caption = ""
                    Exit Sub
                End If
                
                If cmbTipo.Text = "CUENTA CORRIENTE" Then
                    If txtCampo(0).Text = "C" Then 'Credito
                        PMCatalogo "A", "cc_causa_nd", txtCampo(Index%), lblDescripcion(Index%)
                    Else
                        PMCatalogo "A", "cc_causa_nc", txtCampo(Index%), lblDescripcion(Index%)
                    End If
                Else
                    If txtCampo(0).Text = "C" Then 'Credito
                        PMCatalogo "A", "ah_causa_nd", txtCampo(Index%), lblDescripcion(Index%)
                    Else
                        PMCatalogo "A", "ah_causa_nc", txtCampo(Index%), lblDescripcion(Index%)
                    End If
                    
                End If
        End Select
            
        If txtCampo(Index%).Text = "" Then
            txtCampo(Index%).Text = ""
            lblDescripcion(Index%).Caption = ""
        End If
    End If
End Sub
Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
        Case 0
            KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
        Case 1
            KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
        Case 2
            KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    End Select
End Sub
Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
        Case 0
            If VLPaso = False And txtCampo(Index%) <> "" Then
                PMCatalogo "V", "re_signo_ndc", txtCampo(Index%), lblDescripcion(0)
            End If
        Case 1
            If txtCampo(0).Text = "" Then
                txtCampo(Index%).Text = ""
                lblDescripcion(Index%).Caption = ""
                Exit Sub
            End If
    
            If VLPaso = False And txtCampo(Index%) <> "" Then
                If cmbTipo.Text = "CUENTA CORRIENTE" Then
                    If txtCampo(0).Text = "C" Then 'Credito
                        PMCatalogo "V", "cc_causa_nc", txtCampo(Index%), lblDescripcion(Index%)
                    Else
                        PMCatalogo "V", "cc_causa_nd", txtCampo(Index%), lblDescripcion(Index%)
                    End If
                Else
                    If txtCampo(0).Text = "C" Then 'Credito
                        PMCatalogo "V", "ah_causa_nc", txtCampo(Index%), lblDescripcion(Index%)
                    Else
                        PMCatalogo "V", "ah_causa_nd", txtCampo(Index%), lblDescripcion(Index%)
                    End If
                    
                End If
            End If
        Case 2
            If txtCampo(0).Text = "" Then
                txtCampo(Index%).Text = ""
                lblDescripcion(Index%).Caption = ""
                Exit Sub
            End If
    
            If VLPaso = False And txtCampo(Index%) <> "" Then
                If cmbTipo.Text = "CUENTA CORRIENTE" Then
                    If txtCampo(0).Text = "C" Then 'Credito
                        PMCatalogo "V", "cc_causa_nd", txtCampo(Index%), lblDescripcion(Index%)
                    Else
                        PMCatalogo "V", "cc_causa_nc", txtCampo(Index%), lblDescripcion(Index%)
                    End If
                Else
                    If txtCampo(0).Text = "C" Then 'Credito
                        PMCatalogo "V", "ah_causa_nd", txtCampo(Index%), lblDescripcion(Index%)
                    Else
                        PMCatalogo "V", "ah_causa_nc", txtCampo(Index%), lblDescripcion(Index%)
                    End If
                    
                End If
            End If
    End Select
    
    If txtCampo(Index%).Text = "" Then
        lblDescripcion(Index%).Caption = ""
    End If

End Sub
Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
       Case 0 'Salir
          Unload FTRAN707
       Case 1 'Limpiar
          PLLimpiar
       Case 2 'Eliminar
          PLEliminar
       Case 3 ' Crear un nuevo Registro de Nota de Credito y Debito a Imprimir
          PLActualizar
       Case 4 ' Actualizar Registro
          PLCrear
       Case 5 'Siguientes
          PLSiguientes
       Case 6 'Buscar
          PLBuscar
    End Select
End Sub
Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpia todos los valores de los objetos y del
'            grid de la forma.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 04-Feb-05     L.Bernuil       Emisión Inicial
'*************************************************************
    
    txtCampo(0).Enabled = True
    txtCampo(1).Enabled = True
    txtCampo(2).Enabled = True
    txtCampo(0).Text = ""
    txtCampo(1).Text = ""
    txtCampo(2).Text = ""
    lblDescripcion(0).Caption = ""
    lblDescripcion(1).Caption = ""
    lblDescripcion(2).Caption = ""
    
    cmbTipo.Enabled = True
    cmbTipo.ListIndex = 1
    
    cmbimpresion.Enabled = True
    cmbimpresion.ListIndex = 1
    
    cmbafecta.Enabled = True
    cmbafecta.ListIndex = 0
    
    cmbCamara.Enabled = True
    cmbCamara.ListIndex = 1
    
    txtCampo(0).SetFocus
    
    cmdBoton(3).Enabled = False
    cmdBoton(2).Enabled = False
    cmdBoton(4).Enabled = True
    
    grdRegistros.Rows = 2
    grdRegistros.Cols = 2
    grdRegistros.Row = 0
    grdRegistros.Col = 1
    grdRegistros.Text = ""
    grdRegistros.Row = 1
    grdRegistros.Col = 0
    grdRegistros.Text = ""
    grdRegistros.Row = 1
    grdRegistros.Col = 1
    grdRegistros.Text = ""
End Sub
Private Sub PLCrear()
'*************************************************************
' PROPOSITO: Crea un nuevo registro de Parametrizacion de
'            Notas de Crédito y Débito a Imprimir
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 04-Mar-05      L.Bernuil       Emisión Inicial
'*************************************************************

    ' Validacion de mandatoriedades
    If txtCampo(0).Text = "" Then
       MsgBox "El Signo de la Causa es Mandatorio", 0 + 16, "Mensaje de Error"
       txtCampo(0).SetFocus
       Exit Sub
    End If

    If txtCampo(1).Text = "" Then
       MsgBox "El Código de la Causa es Mandatorio", 0 + 16, "Mensaje de Error"
       txtCampo(1).SetFocus
       Exit Sub
    End If
    

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "707"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
    
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
    Else
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
    End If
    
    PMPasoValores sqlconn&, "@i_signo", 0, SQLCHAR, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_causa", 0, SQLVARCHAR, (txtCampo(1).Text)
    PMPasoValores sqlconn&, "@i_imprime", 0, SQLCHAR, (cmbimpresion.Text)
    PMPasoValores sqlconn&, "@i_act_fecha", 0, SQLCHAR, (cmbafecta.Text)
    PMPasoValores sqlconn&, "@i_camara", 0, SQLCHAR, (cmbCamara.Text)
    PMPasoValores sqlconn&, "@i_cau_aju", 0, SQLVARCHAR, (txtCampo(2).Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_personaliza_ndc", True, "Ok...Inserción de Notas de Débito/Crédito") Then
        PMChequea sqlconn&
        PLBuscar  'Traer los registros existentes mas los adicionados
    Else
        PLLimpiar
    End If

End Sub
Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Llena el grid de las notas de debito y Credito existentes
'            con los datos retornados por el stored procedure
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 04-Mar-05     L.Bernuil       Emisión Inicial
'*************************************************************
Dim VTTabla As String
    If txtCampo(0).Text = "" Then
        MsgBox "Debe Ingresar el Signo de la Causa", 0 + 16, "Mensaje de Error"
        txtCampo(0).SetFocus
        Exit Sub
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "707"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
    Else
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
    End If
        
    PMPasoValores sqlconn&, "@i_signo", 0, SQLCHAR, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_causa", 0, SQLVARCHAR, "0"
    
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
        If txtCampo(0).Text = "C" Then 'Credito
            VTTabla$ = "cc_causa_nc"
        Else
            VTTabla$ = "cc_causa_nd"
        End If
    Else
        If txtCampo(0).Text = "C" Then 'Credito
            VTTabla$ = "ah_causa_nc"
        Else
            VTTabla$ = "ah_causa_nd"
        End If
    End If
    
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, (VTTabla$)
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_personaliza_ndc", True, "Ok...Inserción de Notas de Débito/Crédito") Then
        PMMapeaGrid sqlconn&, grdRegistros, False
        PMChequea sqlconn&
        cmbTipo.Enabled = False
        txtCampo(0).Enabled = False
        
        If txtCampo(1).Enabled = True Then
            txtCampo(1).SetFocus
        End If
        
        If grdRegistros.Tag >= 20 Then
            cmdBoton(5).Enabled = True
        Else
            cmdBoton(5).Enabled = False
        End If
    Else
        PLLimpiar
        PMLimpiaG grdRegistros
        cmdBoton(5).Enabled = False
    End If
    End Sub
Private Sub PLSiguientes()
'*************************************************************
' PROPOSITO: Llena el grid de notas de debito existentes con
'            los siguientes 20 registros retornados por el stored
'            procedure
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 04-Mar-05     L.Bernuil       Emisión Inicial
'*************************************************************
Dim VTTabla As String
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "707"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
    Else
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
    End If
        
    PMPasoValores sqlconn&, "@i_signo", 0, SQLCHAR, (txtCampo(0).Text)
    
    grdRegistros.Col = 3
    grdRegistros.Row = grdRegistros.Rows - 1
    PMPasoValores sqlconn&, "@i_causa", 0, SQLVARCHAR, (grdRegistros.Text)
    
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
        If txtCampo(0).Text = "C" Then 'Credito
            VTTabla$ = "cc_causa_nc"
        Else
            VTTabla$ = "cc_causa_nd"
        End If
    Else
        If txtCampo(0).Text = "C" Then 'Credito
            VTTabla$ = "ah_causa_nc"
        Else
            VTTabla$ = "ah_causa_nd"
        End If
    End If
    
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, (VTTabla$)
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_personaliza_ndc", True, "Ok...Inserción de Notas de Débito/Crédito") Then
        PMMapeaGrid sqlconn&, grdRegistros, True
        PMChequea sqlconn&
          
        If txtCampo(1).Enabled Then
            txtCampo(1).SetFocus
        End If
        
        If grdRegistros.Tag >= 20 Then
            cmdBoton(5).Enabled = True
        Else
            cmdBoton(5).Enabled = False
        End If
    End If
End Sub
Private Sub PLEliminar()
'*************************************************************
' PROPOSITO: Permite eliminar el registro de nota de debito/credito
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 03-Mar-05      L.Bernuil       Emisión Inicial
'*************************************************************

    If txtCampo(0).Text = "" Then
       MsgBox "El Signo de la Causa es Mandatorio", 0 + 16, "Mensaje de Error"
       txtCampo(0).SetFocus
       Exit Sub
    End If

    If txtCampo(1).Text = "" Then
       MsgBox "El Código de la Causa es Mandatorio", 0 + 16, "Mensaje de Error"
       txtCampo(1).SetFocus
       Exit Sub
    End If
    

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "707"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
    
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
    Else
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
    End If
    
    PMPasoValores sqlconn&, "@i_signo", 0, SQLCHAR, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_causa", 0, SQLVARCHAR, (txtCampo(1).Text)

    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_personaliza_ndc", True, "Ok...Inserción de Notas de Débito/Crédito") Then
        PMChequea sqlconn&
        PLBuscar    'Trae los registros existentes en la base de datos
    Else
        PLLimpiar
    End If

    txtCampo(1).Enabled = True
    txtCampo(1).Text = ""
    lblDescripcion(1).Caption = ""

End Sub
Private Sub PLActualizar()
'*************************************************************
' PROPOSITO: Actualiza la una determinada nota de debito/credito
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 04-Mar-05      L.Bernuil       Emisión Inicial
'*************************************************************

    If txtCampo(0).Text = "" Then
       MsgBox "El Signo de la Causa es Mandatorio", 0 + 16, "Mensaje de Error"
       txtCampo(0).SetFocus
       Exit Sub
    End If

    If txtCampo(1).Text = "" Then
       MsgBox "El Código de la Causa es Mandatorio", 0 + 16, "Mensaje de Error"
       txtCampo(1).SetFocus
       Exit Sub
    End If
    

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "707"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
    
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
    Else
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
    End If
    
    PMPasoValores sqlconn&, "@i_signo", 0, SQLCHAR, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_causa", 0, SQLVARCHAR, (txtCampo(1).Text)
    PMPasoValores sqlconn&, "@i_imprime", 0, SQLCHAR, (cmbimpresion.Text)
    PMPasoValores sqlconn&, "@i_act_fecha", 0, SQLCHAR, (cmbafecta.Text)
    PMPasoValores sqlconn&, "@i_camara", 0, SQLCHAR, (cmbCamara.Text)
    PMPasoValores sqlconn&, "@i_cau_aju", 0, SQLVARCHAR, (txtCampo(2).Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_personaliza_ndc", True, "Ok...Inserción de Notas de Débito/Crédito") Then
        PMChequea sqlconn&
        PLBuscar    ' Traer los registros posterior a la actualización de los datos
    Else
        PLLimpiar
    End If
   
End Sub
Private Sub grdRegistros_Click()
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

End Sub
Private Sub grdregistros_DblClick()
    If grdRegistros.Rows <= 2 Then
       grdRegistros.Row = 1
       grdRegistros.Col = 1
       If Trim$(grdRegistros.Text) = "" Then
          MsgBox "No existen Notas de Débito", 0 + 16, "Mensaje de Error"
          Exit Sub
       End If
    End If
   
    grdRegistros.Col = 3
    txtCampo(1).Text = grdRegistros.Text
    txtCampo(1).Enabled = False

    grdRegistros.Col = 4
    lblDescripcion(1).Caption = grdRegistros.Text

    grdRegistros.Col = 5
    cmbimpresion.Text = grdRegistros.Text
    
    grdRegistros.Col = 6
    cmbafecta.Text = grdRegistros.Text
    
    grdRegistros.Col = 7
    cmbCamara.Text = grdRegistros.Text
    
    grdRegistros.Col = 8
    txtCampo(2).Text = grdRegistros.Text
    txtCampo_LostFocus (2)
    
    cmdBoton(3).Enabled = True
    cmdBoton(4).Enabled = False
    cmdBoton(2).Enabled = True

End Sub

