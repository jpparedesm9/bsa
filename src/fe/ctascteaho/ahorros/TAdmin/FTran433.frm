VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran433 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Marcacion Servicio"
   ClientHeight    =   5580
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9330
   ForeColor       =   &H00FFFFFF&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5580
   ScaleWidth      =   9330
   Begin VB.TextBox txtCelular 
      Appearance      =   0  'Flat
      ForeColor       =   &H00000000&
      Height          =   285
      Left            =   1860
      MaxLength       =   12
      TabIndex        =   4
      Top             =   1340
      Width           =   1875
   End
   Begin VB.TextBox txtComercio 
      Appearance      =   0  'Flat
      ForeColor       =   &H00000000&
      Height          =   285
      Left            =   1860
      MaxLength       =   15
      TabIndex        =   5
      Top             =   2000
      Width           =   1875
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   1860
      MaxLength       =   15
      TabIndex        =   3
      Top             =   1020
      Width           =   1875
   End
   Begin VB.ComboBox cmbprodb 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   1860
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   50
      Width           =   1890
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   2
      Left            =   8445
      TabIndex        =   12
      Top             =   3600
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "*&Limpiar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   0
      Left            =   8450
      TabIndex        =   10
      Top             =   0
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "*&Buscar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   3
      Left            =   8445
      TabIndex        =   13
      Top             =   4415
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "*&Salir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   2235
      Left            =   120
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   3240
      Width           =   8220
      _Version        =   65536
      _ExtentX        =   14499
      _ExtentY        =   3942
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSMask.MaskEdBox Mskcuentadb 
      Height          =   285
      Left            =   1860
      TabIndex        =   2
      Top             =   390
      Width           =   1875
      _ExtentX        =   3307
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   1
      Left            =   8445
      TabIndex        =   11
      Tag             =   "727"
      Top             =   2785
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "*&Transmitir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Frame frmEstado 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   495
      Left            =   1860
      TabIndex        =   6
      Top             =   2240
      Width           =   3495
      Begin Threed.SSOption optEstado 
         Height          =   255
         Index           =   1
         Left            =   2100
         TabIndex        =   8
         TabStop         =   0   'False
         Top             =   160
         Width           =   615
         _Version        =   65536
         _ExtentX        =   1085
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "No"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption optEstado 
         Height          =   255
         Index           =   0
         Left            =   360
         TabIndex        =   7
         Top             =   160
         Width           =   615
         _Version        =   65536
         _ExtentX        =   1085
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Si"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
      End
   End
   Begin MSMask.MaskEdBox mskCuentadbNew 
      Height          =   285
      Left            =   1860
      TabIndex        =   26
      Top             =   720
      Width           =   1875
      _ExtentX        =   3307
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      Enabled         =   0   'False
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
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   3765
      TabIndex        =   28
      Top             =   700
      UseMnemonic     =   0   'False
      Width           =   4605
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de Cuenta Nueva:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   5
      Left            =   120
      TabIndex        =   27
      Top             =   750
      WhatsThisHelpID =   5475
      Width           =   1725
   End
   Begin VB.Label lblFila 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   7920
      TabIndex        =   25
      Top             =   1800
      Visible         =   0   'False
      Width           =   315
   End
   Begin VB.Label lblTitularidad 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   7920
      TabIndex        =   24
      Top             =   2160
      Visible         =   0   'False
      Width           =   315
   End
   Begin VB.Label lblTOperador 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   1860
      TabIndex        =   23
      Top             =   1670
      Width           =   1875
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Comercio:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   4
      Left            =   120
      TabIndex        =   22
      Top             =   2070
      WhatsThisHelpID =   5474
      Width           =   870
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Tipo Operador:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   2
      Left            =   120
      TabIndex        =   21
      Top             =   1710
      WhatsThisHelpID =   5473
      Width           =   1215
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nro. Celular:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   1
      Left            =   120
      TabIndex        =   20
      Top             =   1395
      WhatsThisHelpID =   5472
      Width           =   1035
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   3765
      TabIndex        =   17
      Top             =   1020
      Width           =   4605
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Servicio:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   0
      Left            =   120
      TabIndex        =   16
      Top             =   1095
      WhatsThisHelpID =   5444
      Width           =   750
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   14
      Left            =   120
      TabIndex        =   0
      Top             =   120
      WhatsThisHelpID =   5048
      Width           =   840
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de Cuenta:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   7
      Left            =   120
      TabIndex        =   14
      Top             =   450
      WhatsThisHelpID =   5449
      Width           =   1200
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   3765
      TabIndex        =   15
      Top             =   390
      UseMnemonic     =   0   'False
      Width           =   4605
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Habilitado:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   9
      Left            =   120
      TabIndex        =   18
      Top             =   2415
      WhatsThisHelpID =   5445
      Width           =   900
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Servicios Aplicados :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   3
      Left            =   120
      TabIndex        =   19
      Top             =   3000
      Width           =   1800
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8395
      Y1              =   2880
      Y2              =   2880
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8400
      X2              =   8400
      Y1              =   0
      Y2              =   5640
   End
End
Attribute VB_Name = "FTran433"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
' Este programa esta protegido por la ley de derechos de autor
' y por las  convenciones  internacionales de  propiedad inte-
' lectual.  Su uso no  autorizado dara  derecho a  MACOSA para
' obtener ordenes  de secuestro o  retencion y para  perseguir
' penalmente a los autores de cualquier infraccion.
'*************************************************************
'                         PROPOSITO
' Consulta de Transferencias Automáticas, cuenta origen
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 03162011       S.Molano        Emisión Inicial
'*************************************************************
Option Explicit
Dim VLPaso As Boolean
Dim VLFlag As Boolean
Dim VLExiste As String
Dim VLValor As String
Dim VLRespuesta As Integer
Dim VLProducto As Integer
Dim VLNumDoc As String

Private Sub cmbprodb_Click()
    txtCampo(0).Text = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
 Select Case Index
  Case 0 ' Buscar
         VLFlag = False
         PLBuscar
  Case 1 'Transmitir
         If txtCampo(0).Text = "COM" Then
            If txtComercio.Text = "" Or txtCelular.Text = "" Then
                MsgBox ("EL CODIGO DE COMERCIO Y NUMERO DE CELULAR SON OBLIGATORIOS")
                Exit Sub
            End If
            PLHuella
            If VGRegistraHuellaAValidar = False Then
                Exit Sub
            End If
         End If
         PLTransmitir
  Case 2 ' Limpiar
         PLLimpiar
  Case 3 ' Salir
         Screen.MousePointer = 0
         Unload Me
End Select
End Sub
Private Sub cmdBoton_GotFocus(Index As Integer)
If Index = 0 Then
FPrincipal!pnlHelpLine.Caption = "Buscar Servicios Aplicados"
End If
If Index = 1 Then
FPrincipal!pnlHelpLine.Caption = "Guardar Relacion Servicios"
End If
If Index = 2 Then
FPrincipal!pnlHelpLine.Caption = "Limpiar Pantalla Servicios Aplicados"
End If
If Index = 3 Then
FPrincipal!pnlHelpLine.Caption = "Salir Pantalla Servicios Aplicados"
End If
End Sub

Private Sub Form_Load()
    FTran433.Left = 0   '15
    FTran433.Top = 0
    FTran433.Width = 9420
    FTran433.Height = 6060
    PMLoadResStrings Me
    PMLoadResIcons Me
    cmbprodb.AddItem "AHORROS", 0
    cmbprodb.AddItem "CORRIENTES", 1
    cmbprodb.ListIndex = 0
    PMObjetoSeguridad FTran433.cmdBoton(1)
    Mskcuentadb.Mask = VGMascaraCtaAho
     VLExiste = "N"
    VLPaso = True
    txtCelular.Enabled = True
    txtComercio.Enabled = True
    
    mskCuentadbNew.Text = ""
    mskCuentadbNew.Enabled = False
    
    
End Sub
Private Sub cmbprodb_LostFocus()
    If cmbprodb.ListIndex = 0 Then  '' Corrientes
        Mskcuentadb.Mask = VGMascaraCtaCte
    Else
        Mskcuentadb.Mask = VGMascaraCtaAho
    End If
    PMLimpiaGrid grdRegistros
    cmdBoton(0).Enabled = True  ' Buscar
    cmdBoton(1).Enabled = True  ' Transmitir
    Call Mskcuentadb_LostFocus
End Sub
Private Sub cmbprodb_GotFocus()
FPrincipal!pnlHelpLine.Caption = " Tipo de Producto"
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
If grdRegistros.Rows > 0 Then
    grdRegistros.Col = 1
    Select Case grdRegistros.Text
     Case "CORRIENTES"
        cmbprodb.ListIndex = 1
     Case "AHORROS"
        cmbprodb.ListIndex = 0
    End Select
    
    grdRegistros.Col = 3
    txtCampo(0).Text = grdRegistros.Text
    grdRegistros.Col = 4
    lblDescripcion(1).Caption = grdRegistros.Text
    grdRegistros.Col = 5
    txtComercio.Text = grdRegistros.Text
    grdRegistros.Col = 6
    txtCelular.Text = grdRegistros.Text
    grdRegistros.Col = 7
    lblTOperador.Caption = grdRegistros.Text
    grdRegistros.Col = 8
    If grdRegistros.Text = "S" Then
       optEstado(0).Value = True
    Else
       optEstado(1).Value = True
    End If
    
    If txtCampo(0).Text = "COM" Then
        If txtCampo(0).Text = "COM" Then
            lblDescripcion(2).Caption = ""
            mskCuentadbNew.Enabled = True
            mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
        End If
    End If
End If
End Sub

Private Sub Mskcuentadb_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
    Mskcuentadb.SelStart = 0
    Mskcuentadb.SelLength = Len(Mskcuentadb.Text)
End Sub

Private Sub Mskcuentadb_LostFocus()
    On Error Resume Next
    If Mskcuentadb.ClipText <> "" Then
        If cmbprodb.ListIndex = 1 Then          '  Corrientes
            If FMChequeaCtaCte((Mskcuentadb.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
                If FMTransmitirRPC(sqlconn&, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & Mskcuentadb.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(0)
                    PMChequea sqlconn&
                Else
                    Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte)
                    lblDescripcion(0).Caption = ""
                    If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                    Exit Sub
                End If
            Else
               MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte)
                lblDescripcion(0).Caption = ""
                If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                Exit Sub
            End If
        Else  '  Ahorros
            If FMChequeaCtaAho((Mskcuentadb.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
                If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & Mskcuentadb.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(0)
                    PMChequea sqlconn&
                Else
                    Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho)
                    lblDescripcion(0).Caption = ""
                    If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho)
                lblDescripcion(0).Caption = ""
                If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                Exit Sub
            End If
        End If
    End If
End Sub
Sub PLLimpiar()
    PMLimpiaGrid grdRegistros
    cmbprodb.ListIndex = 0
    optEstado(0).Value = True
    lblDescripcion(1).Caption = ""
    txtCampo(0).Text = ""
    cmdBoton(1).Enabled = True
    cmbprodb.ListIndex = 0
    cmbprodb.SetFocus
    VLExiste = "N"
    txtCelular.Enabled = True
    txtComercio.Enabled = True
    txtCelular.Text = ""
    lblTOperador.Caption = ""
    txtComercio.Text = ""
    
    mskCuentadbNew.Mask = VGMascaraCtaAho
    mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
    mskCuentadbNew.Enabled = False
    lblDescripcion(2).Caption = ""
End Sub

Private Sub mskCuentadbNew_Change()
    VLPaso = False
End Sub

Private Sub mskCuentadbNew_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Consulta Cuentas del Titular [F5 Ayuda]"
    mskCuentadbNew.SelStart = 0
    mskCuentadbNew.SelLength = Len(mskCuentadbNew.Text)
End Sub

Private Sub mskCuentadbNew_KeyDown(Keycode As Integer, Shift As Integer)
        
If Keycode = VGTeclaAyuda Then
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4&, "727"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR&, "X"
        'CONSULTA CON BASE EN LA CUENTA ORIGINAL
        PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, VLProducto
        PMHelpG "cob_remesas", "sp_mto_marca_servicio", 4, 1
        PMBuscarG 1, "@t_trn", "727", SQLINT2&
        PMBuscarG 2, "@i_operacion", "X", SQLVARCHAR&
        PMBuscarG 3, "@i_cuenta", (Mskcuentadb.ClipText), SQLVARCHAR&
        PMBuscarG 4, "@i_producto", (VLProducto), SQLINT4&
        PMSigteG 1, "@i_siguiente", 1, SQLVARCHAR&
        If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_mto_marca_servicio", True, "OK.. Nro. Cuenta Cliente") Then
           PMMapeaGrid sqlconn&, grid_valores!gr_SQL, False
           PMChequea sqlconn&
           PMProcesG
           VLPaso = True
           grid_valores.Show 1
           If Temporales(1) <> "" Then
               mskCuentadbNew.Mask = VGMascaraCtaAho
               mskCuentadbNew.Text = FMMascara(Temporales(1), VGMascaraCtaAho)
            
               mskCuentadbNew_LostFocus
           Else
               mskCuentadbNew.Mask = VGMascaraCtaAho
               mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
               lblDescripcion(2).Caption = ""
           End If
        Else
           mskCuentadbNew.Mask = VGMascaraCtaAho
           mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
           lblDescripcion(2).Caption = ""
        End If
End If
End Sub

Private Sub mskCuentadbNew_KeyPress(KeyAscii As Integer)
If KeyAscii <> 116 Then
    KeyAscii = 0
End If
End Sub

Private Sub mskCuentadbNew_LostFocus()
On Error Resume Next
    If mskCuentadbNew.Text <> FMMascara("", VGMascaraCtaAho) Then
        If cmbprodb.ListIndex = 1 Then          '  Corrientes
            If FMChequeaCtaCte((mskCuentadbNew.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuentadbNew.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
                If FMTransmitirRPC(sqlconn&, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & Mskcuentadb.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(2)
                    PMChequea sqlconn&
                Else
                    mskCuentadbNew.Text = FMMascara("", VGMascaraCtaCte)
                    lblDescripcion(2).Caption = ""
                    If mskCuentadbNew.Enabled And mskCuentadbNew.Visible Then mskCuentadbNew.SetFocus
                    Exit Sub
                End If
            Else
               MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuentadbNew.Text = FMMascara("", VGMascaraCtaCte)
                lblDescripcion(2).Caption = ""
                If mskCuentadbNew.Enabled And mskCuentadbNew.Visible Then mskCuentadbNew.SetFocus
                Exit Sub
            End If
        Else  '  Ahorros
            If FMChequeaCtaAho((mskCuentadbNew.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, Replace(mskCuentadbNew.ClipText, "-", "")
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
                If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & Mskcuentadb.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(2)
                    PMChequea sqlconn&
                Else
                    mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
                    lblDescripcion(2).Caption = ""
                    If mskCuentadbNew.Enabled And mskCuentadbNew.Visible Then mskCuentadbNew.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
                lblDescripcion(2).Caption = ""
                If mskCuentadbNew.Enabled And mskCuentadbNew.Visible Then mskCuentadbNew.SetFocus
                Exit Sub
            End If
        End If
    End If
    txtCampo(0).SetFocus
End Sub

Private Sub txtCampo_Change(Index As Integer)
    VLPaso = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
   Select Case Index
   Case 0
     FPrincipal!pnlHelpLine.Caption = "Código del Servicio [F5 Ayuda]"
   End Select
   txtCampo(Index).SelStart = 0
   txtCampo(Index).SelLength = Len(txtCampo(Index).Text)
End Sub
Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
   If (KeyAscii <> 8) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 97) Or (KeyAscii > 122)) Then
       KeyAscii = 0
   Else
       KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
   End If
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode = VGTeclaAyuda Then
       VLPaso = True
       Select Case Index
            Case 0
               PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_marca_servicio"
               PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
               If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_hp_catalogo", True, " Consulta del Servicio " & "[" & txtCampo(Index).Text & "]") Then
                  PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                  PMChequea sqlconn&
                  FCatalogo.Show 1
                  txtCampo(0).Text = VGACatalogo.Codigo
                  lblDescripcion(1).Caption = VGACatalogo.Descripcion
               End If
               VLPaso = True
       End Select
    End If
    
    If txtCampo(0).Text = "COM" Then
       txtCelular.Enabled = True
       txtComercio.Enabled = True
    Else
       txtCelular.Text = ""
       txtComercio.Text = ""
       txtCelular.Enabled = False
       txtComercio.Enabled = False
    End If
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index
         Case 0
           If VLPaso = False Then
               If txtCampo(0).Text <> "" Then
                  PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_marca_servicio"
                  PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                  PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(Index).Text)
                  If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_hp_catalogo", True, " Consulta del Servicio " & "[" & txtCampo(Index).Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(1)
                     PMChequea sqlconn&
                  Else
                     VLPaso = True
                     txtCampo(0).Text = ""
                     lblDescripcion(1).Caption = ""
                     txtCampo(0).SetFocus
                  End If
               Else
                  lblDescripcion(1).Caption = ""
               End If
           End If
           If txtCampo(0).Text = "COM" Then
              txtCelular.Enabled = True
              txtComercio.Enabled = True
              txtCelular.Text = ""
              txtComercio.Text = ""
              lblTOperador.Caption = ""
           Else
              txtCelular.Text = ""
              txtComercio.Text = ""
              lblTOperador.Caption = ""
              txtCelular.Enabled = False
              txtComercio.Enabled = False
              If VLExiste = "S" Then
                 mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
                 lblDescripcion(2).Caption = ""
                 mskCuentadbNew.Enabled = False
                 VLExiste = "N"
              End If
           End If
           
    End Select
End Sub
Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Permite transmitir la informacion de la forma
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 17-Mar-2011   S. Molano        Emisión Inicial
'*************************************************************

If Mskcuentadb.ClipText = "" Then
      MsgBox "El campo cuenta es mandatorio", 0 + 16, "Mensaje de Error"
      Mskcuentadb.SetFocus
      Exit Sub
End If

If txtCampo(0).Text = "" Then
      MsgBox "El servicio es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(0).SetFocus
      Exit Sub
End If

If mskCuentadbNew.Enabled = True And mskCuentadbNew.ClipText = "" Then
      MsgBox "El campo nueva cuenta es mandatorio", 0 + 16, "Mensaje de Error"
      mskCuentadbNew.SetFocus
      Exit Sub
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 727
PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
Select Case cmbprodb.ListIndex
   Case 0
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "4"
   Case 1
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "3"
  End Select
If optEstado(0).Value = True Then
   PMPasoValores sqlconn&, "@i_habilitado", 0, SQLCHAR, "S"
Else
   PMPasoValores sqlconn&, "@i_habilitado", 0, SQLCHAR, "N"
   If grdRegistros.Row > 0 Then
      VLRespuesta = MsgBox("Desea eliminar la marca del servicio " + txtCampo(0).Text + " " + lblDescripcion(1) + " ?", 1 + 32 + 256, "Eliminar Registros")
        If VLRespuesta = 2 Then
           Exit Sub
        End If
   End If
End If
If VLExiste = "S" Then
   PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
   PMPasoValores sqlconn&, "@i_cuenta_nueva", 0, SQLVARCHAR, Replace(mskCuentadbNew.ClipText, "-", "")
Else
   PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
End If
PMPasoValores sqlconn&, "@i_servicio", 0, SQLVARCHAR, (txtCampo(0).Text)

PMPasoValores sqlconn&, "@i_celular", 0, SQLVARCHAR, txtCelular.Text
PMPasoValores sqlconn&, "@i_comercio", 0, SQLVARCHAR, txtComercio.Text


If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_mto_marca_servicio", True, "Ok... Ingresa Marca Servicio") Then
       PMMapeaGrid sqlconn&, grdRegistros, False
       PMChequea sqlconn&
Else
    Exit Sub
End If

PLLimpiar

End Sub

Private Sub PLBuscar()
PMLimpiaGrid grdRegistros
mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
lblDescripcion(2).Caption = ""
mskCuentadbNew.Enabled = False

If Mskcuentadb.ClipText = "" Then
      MsgBox "El campo cuenta es mandatorio", 0 + 16, "Mensaje de Error"
      Mskcuentadb.SetFocus
      Exit Sub
End If
PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 722
PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
Select Case cmbprodb.ListIndex
   Case 0
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "4"
   Case 1
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "3"
  End Select
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_mto_marca_servicio", True, "Ok... Consulta de Servicios Marcados") Then
   PMMapeaGrid sqlconn&, grdRegistros, VLFlag
   PMChequea sqlconn&
   VLExiste = "S"
End If
End Sub


Private Sub txtCelular_KeyDown(Keycode As Integer, Shift As Integer)
Dim VLProducto As Integer

    If Keycode = VGTeclaAyuda Then
    
        Select Case cmbprodb.ListIndex
        Case 0
            VLProducto = 4
        Case 1
            VLProducto = 3
        End Select
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4&, "727"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR&, "H"
        PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, VLProducto
        PMHelpG "cob_remesas", "sp_mto_marca_servicio", 4, 1
        PMBuscarG 1, "@t_trn", "727", SQLINT2&
        PMBuscarG 2, "@i_operacion", "H", SQLVARCHAR&
        PMBuscarG 3, "@i_cuenta", (Mskcuentadb.ClipText), SQLVARCHAR&
        PMBuscarG 4, "@i_producto", (VLProducto), SQLINT4&
        PMSigteG 1, "@i_siguiente", 1, SQLVARCHAR&
        If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_mto_marca_servicio", True, "OK.. Nro. Telefono") Then
           PMMapeaGrid sqlconn&, grid_valores!gr_SQL, False
           PMChequea sqlconn&
           PMProcesG
           VLPaso = True
           grid_valores.Show 1
           If Temporales(1) <> "" Then
               txtCelular.Text = Temporales(1)
               lblTOperador.Caption = Temporales(2)
           Else
               txtCelular.Text = ""
               lblTOperador.Caption = ""
           End If
        Else
           txtCelular.Text = ""
           lblTOperador.Caption = ""
        End If
    
    End If

End Sub

Private Sub txtCelular_KeyPress(KeyAscii As Integer)
   If (KeyAscii <> 8) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 97) Or (KeyAscii > 122)) Then
       KeyAscii = 0
   Else
       KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
   End If
End Sub

Private Sub txtCelular_LostFocus()
    If txtCelular.Text <> "" Then
       Select Case cmbprodb.ListIndex
       Case 0
           PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "4"
       Case 1
           PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "3"
       End Select
       
       PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "727"
       PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "V"
       PMPasoValores sqlconn&, "@i_celular", 0, SQLVARCHAR, txtCelular.Text
       PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
       
       If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_mto_marca_servicio", True, " Consulta de Nro Celular") Then
          PMMapeaVariable sqlconn&, VLValor
          PMChequea sqlconn&
          lblTOperador = VLValor
       Else
          lblTOperador.Caption = ""
       End If
    Else
       lblTOperador.Caption = ""
    End If
    
End Sub

Private Sub PLHuella()
   
   Dim VLNumeroDoc As String
   Dim VLTitularidad As String
   Dim VLCuenta As String
   Dim VLTipoTran As String
   
   If lblTitularidad.Caption = "INDIVIDUAL" Then
        If lblFila.Caption = "" Then
           Exit Sub
        End If
        VGTipoDoc = ""
        VLNumDoc = ""
        VLTipoTran = ""
        FMotorBusq!grdCuentas.Row = lblFila.Caption
        VLTipoTran = "1610"
        FMotorBusq!grdCuentas.Col = 7
        VGTipoDoc = FMotorBusq!grdCuentas.Text
        FMotorBusq!grdCuentas.Col = 8
        VLNumeroDoc = CStr(FMotorBusq!grdCuentas.Text)
        VLTipoTran = "722"
        VLCuenta = Mskcuentadb.ClipText
        VLTitularidad = lblTitularidad.Caption
        FMRegistraHuellaAValidar VGTipoDoc, VLNumeroDoc, VLTitularidad, VLCuenta, VLTipoTran
            
        VLTipoTran = "722"
        FMVerificaHuella VLCuenta, VLTipoTran
            
        If VGRegistraHuellaAValidar = False Then
           Exit Sub
        End If
  Else
        MsgBox "LA TITULARIDAD DE LA CUENTA NO ES INVIDUAL"
        Exit Sub
  End If
                  

End Sub

