VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FCtranAut 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Consulta de Transferencia Automaticas"
   ClientHeight    =   5370
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9330
   ForeColor       =   &H00FFFFFF&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   5370
   ScaleWidth      =   9330
   Begin VB.ComboBox cmbprodb 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   1500
      Style           =   2  'Dropdown List
      TabIndex        =   17
      Top             =   30
      Width           =   1890
   End
   Begin VB.Frame frmEstado 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   390
      Left            =   1455
      TabIndex        =   9
      Top             =   660
      Width           =   3435
      Begin Threed.SSOption optEstado 
         Height          =   195
         Index           =   1
         Left            =   1800
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   150
         Width           =   1305
         _Version        =   65536
         _ExtentX        =   2302
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Autorizadas"
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
         Height          =   195
         Index           =   0
         Left            =   300
         TabIndex        =   0
         Top             =   135
         Width           =   1110
         _Version        =   65536
         _ExtentX        =   1958
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Ingresada"
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
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   8040
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   7
      Top             =   990
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   7800
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   6
      Top             =   990
      Visible         =   0   'False
      Width           =   195
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8445
      TabIndex        =   4
      Top             =   3795
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
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
      Height          =   750
      Index           =   0
      Left            =   8450
      TabIndex        =   2
      Top             =   0
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
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
      Height          =   750
      Index           =   4
      Left            =   8450
      TabIndex        =   5
      Top             =   4575
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
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
      Height          =   3675
      Left            =   0
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   1620
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   6482
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   5
      Left            =   8445
      TabIndex        =   11
      Tag             =   "6335"
      Top             =   1560
      WhatsThisHelpID =   2009
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Imprimir"
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
   Begin MSMask.MaskEdBox Mskcuentadb 
      Height          =   285
      Left            =   1500
      TabIndex        =   14
      Top             =   375
      Width           =   1875
      _ExtentX        =   3307
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   1
      Left            =   8445
      TabIndex        =   19
      Top             =   780
      WhatsThisHelpID =   2020
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Siguien&tes"
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
      Enabled         =   0   'False
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto:"
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
      Index           =   14
      Left            =   60
      TabIndex        =   18
      Top             =   75
      WhatsThisHelpID =   5048
      Width           =   915
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de Cuenta:"
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
      Left            =   105
      TabIndex        =   16
      Top             =   345
      WhatsThisHelpID =   5016
      Width           =   1380
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   3405
      TabIndex        =   15
      Top             =   375
      UseMnemonic     =   0   'False
      Width           =   4965
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
      Index           =   4
      Left            =   3480
      TabIndex        =   13
      Top             =   5040
      Visible         =   0   'False
      Width           =   2235
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
      Index           =   3
      Left            =   120
      TabIndex        =   12
      Top             =   5040
      Visible         =   0   'False
      Width           =   2235
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
      Index           =   9
      Left            =   90
      TabIndex        =   10
      Top             =   810
      Width           =   660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Transferencias Automaticas :"
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
      Left            =   15
      TabIndex        =   8
      Top             =   1365
      Width           =   2490
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8395
      Y1              =   1245
      Y2              =   1245
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8400
      X2              =   8400
      Y1              =   0
      Y2              =   5310
   End
End
Attribute VB_Name = "FCtranAut"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
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
' 12212006       R.Linares        Emisión Inicial
'*************************************************************
Dim VLPaso As Integer
Dim VLFlag As Integer
Dim VTRegistros As Integer


Private Sub cmdBoton_Click(Index As Integer)
  Select Case Index
  Case 0 ' Buscar
         VLFlag% = False
         PLBuscar
  Case 1 'Siguiente
        VLFlag% = True
        PLBuscar
  Case 4 ' Salir
         Screen.MousePointer = 0
         Unload Me
  Case 3 ' Limpiar
         PLLimpiar

  Case 5 ' Imprimir
  
End Select
End Sub

Private Sub Form_Load()
    FPrincipal.MousePointer = 11
    FCtranAut.Left = 0   '15
    FCtranAut.Top = 0   '15
    FCtranAut.Width = 9450   '9420
    FCtranAut.Height = 5900   '5730
    
    PMLoadResStrings Me
    PMLoadResIcons Me
    cmbprodb.AddItem "CORRIENTE", 0
    cmbprodb.AddItem "AHORROS", 1
    cmbprodb.ListIndex = 0
    Mskcuentadb.Mask = VGMascaraCtaAho$
    VLPaso% = True
End Sub

Private Sub cmbprodb_LostFocus()
    If cmbprodb.ListIndex = 0 Then  '' Corrientes
        Mskcuentadb.Mask = VGMascaraCtaCte$
    Else
        Mskcuentadb.Mask = VGMascaraCtaAho$
    End If
    PMLimpiaGrid grdRegistros
    cmdBoton(0).Enabled = True  ' Buscar
    cmdBoton(1).Enabled = False ' Siguiente
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
    If grdRegistros.Rows <= 2 Then
        grdRegistros.Row = 1
        grdRegistros.Col = 1
        If Trim$(grdRegistros.Text) = "" Then
            MsgBox "No existen registros de transferencias automáticas", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    End If
   grdRegistros.Col = 1
   VGADatosO(0) = grdRegistros.Text
   Unload Me
End Sub


Private Sub Mskcuentadb_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la cuenta Débito"
    Mskcuentadb.SelStart = 0
    Mskcuentadb.SelLength = Len(Mskcuentadb.Text)
End Sub
Private Sub Mskcuentadb_LostFocus()
    On Error Resume Next
    If Mskcuentadb.ClipText <> "" Then
        If cmbprodb.ListIndex = 0 Then          '  Corrientes
            If FMChequeaCtaCte((Mskcuentadb.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & Mskcuentadb.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(0)
                    PMChequea sqlconn&
                    'cmdBoton(4).Enabled = True
                Else
                    'cmdboton_click (1)
                    Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte$)
                    lblDescripcion(0).Caption = ""
                    If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                'cmdboton_click (1)
                Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(0).Caption = ""
                If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                
                Exit Sub
            End If
        Else  '  Ahorros
            If FMChequeaCtaAho((Mskcuentadb.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & Mskcuentadb.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(0)
                    PMChequea sqlconn&
                    'cmdBoton(4).Enabled = True
                Else
                    'cmdboton_click (1)
                    Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho$)
                    lblDescripcion(0).Caption = ""
                    If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                'cmdboton_click (1)
                Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho$)
                lblDescripcion(0).Caption = ""
                If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                Exit Sub
            End If
        End If
    End If
End Sub

Sub PLBuscar()
Dim VTFlag As Integer
Dim VTModo As Integer



    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "711"     '"2756"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "T"
    PMPasoValores sqlconn&, "@i_cta_banco_dst", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
    If optEstado(0).Value = True Then  'Ingresados
       PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "I"
    Else                               'Autorizados
       PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "C"
    End If
    
    If cmbprodb.ListIndex = 0 Then   '  corriente
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "CTE"
    Else
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "AHO"
    End If
    If VLFlag% = False Then
       PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, "0"
    Else
       grdRegistros.Col = 1
       grdRegistros.Row = grdRegistros.Rows - 1
       PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, grdRegistros.Text
    End If
    

    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenca_transfer", True, "Ok... Consulta de Transferencias Automaticas") Then
       PMMapeaGrid sqlconn&, grdRegistros, VLFlag%
       PMChequea sqlconn&
       VTFlag% = True
       VTModo = 1
       VTRegistros = Val(grdRegistros.Tag)
       If VTRegistros% >= 20 Then
          cmdBoton(1).Enabled = True ' Siguiente
          cmdBoton(0).Enabled = False
       Else
          cmdBoton(0).Enabled = False ' Buscar
          cmdBoton(1).Enabled = False ' Buscar
       End If
    End If
End Sub

Private Sub optEstado_Click(Index As Integer, Value As Integer)
   PMLimpiaGrid grdRegistros
   cmdBoton(0).Enabled = True
   cmdBoton(1).Enabled = False
End Sub

Sub PLLimpiar()
        cmbprodb.ListIndex = 0
        Mskcuentadb.Mask = FMMascara("", VGMascaraCtaAho$)
        optEstado(0).Value = True
        PMLimpiaGrid grdRegistros
        cmdBoton(0).Enabled = True  ' Buscar
        cmdBoton(1).Enabled = False ' Siguiente
End Sub

