VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTRAN2850 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "*Autorización de Notas de Crédito/Débito"
   ClientHeight    =   5370
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9330
   ForeColor       =   &H00FFFFFF&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5370
   ScaleWidth      =   9330
   Tag             =   "3083"
   Begin VB.Frame frmEstado 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   390
      Left            =   1560
      TabIndex        =   22
      Top             =   1080
      Width           =   6790
      Begin Threed.SSOption optEstado 
         Height          =   195
         Index           =   1
         Left            =   1800
         TabIndex        =   3
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
         TabIndex        =   2
         Top             =   150
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
      Begin Threed.SSOption optEstado 
         Height          =   195
         Index           =   2
         Left            =   3570
         TabIndex        =   4
         TabStop         =   0   'False
         Top             =   150
         Width           =   1305
         _Version        =   65536
         _ExtentX        =   2302
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Rechazadas"
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
         Index           =   3
         Left            =   5280
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   150
         Width           =   1305
         _Version        =   65536
         _ExtentX        =   2302
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Reversadas"
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
      TabIndex        =   20
      Top             =   1250
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
      TabIndex        =   19
      Top             =   1250
      Visible         =   0   'False
      Width           =   195
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
      Height          =   315
      Left            =   1560
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   420
      Width           =   2500
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8450
      TabIndex        =   11
      Top             =   3825
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
      TabIndex        =   6
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
      Index           =   2
      Left            =   8445
      TabIndex        =   9
      Top             =   2280
      WhatsThisHelpID =   2503
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Autorizar"
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8450
      TabIndex        =   12
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1560
      TabIndex        =   1
      Top             =   800
      Width           =   1650
      _ExtentX        =   2910
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      PromptChar      =   "_"
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3420
      Left            =   0
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   1875
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   6032
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
      Index           =   1
      Left            =   8445
      TabIndex        =   8
      Top             =   1515
      WhatsThisHelpID =   2502
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Rechazar"
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   5
      Left            =   8445
      TabIndex        =   24
      Tag             =   "6335"
      Top             =   750
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   6
      Left            =   8445
      TabIndex        =   10
      Top             =   3060
      WhatsThisHelpID =   2036
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Reversar"
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
      TabIndex        =   26
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
      TabIndex        =   25
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
      Left            =   120
      TabIndex        =   23
      Top             =   1200
      Width           =   660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Transacciones Crédito/Débito:"
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
      Left            =   0
      TabIndex        =   21
      Top             =   1605
      WhatsThisHelpID =   5205
      Width           =   2700
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8395
      Y1              =   1560
      Y2              =   1560
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
      Index           =   2
      Left            =   3235
      TabIndex        =   18
      Top             =   800
      UseMnemonic     =   0   'False
      Width           =   5120
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
      Index           =   2
      Left            =   120
      TabIndex        =   17
      Top             =   840
      WhatsThisHelpID =   5016
      Width           =   1380
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
      Index           =   1
      Left            =   120
      TabIndex        =   16
      Top             =   480
      WhatsThisHelpID =   5048
      Width           =   915
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Autorizante:"
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
      TabIndex        =   15
      Top             =   165
      WhatsThisHelpID =   5204
      Width           =   1110
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
      Left            =   1560
      TabIndex        =   14
      Top             =   120
      Width           =   1395
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
      Left            =   2980
      TabIndex        =   13
      Top             =   120
      Width           =   5370
   End
End
Attribute VB_Name = "FTRAN2850"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14-Aug-10
'*************************************************************
' ARCHIVO:          FTRAN2580.frm
' NOMBRE LOGICO:    FTRAN2580
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
' Esta pantalla permite ejecutar las Notas de Credito y Debito
' que han sido generadas desde caja.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 26-Abr-05      L. Bernuil      Emisión Inicial
'*************************************************************
Dim VLCredito As Double
Dim VLDebito As Double
Dim VLLin As Integer


Private Sub PLReversar()
Dim i As Integer

Dim VLMarcadas As Integer
    VLMarcadas = 0
    
    For i% = 1 To (grdRegistros.Rows - 1)
        grdRegistros.Row = i%
        grdRegistros.Col = 0
    
        If grdRegistros.Picture = picVisto(0) Then
            VLMarcadas = VLMarcadas + 1
        End If
    Next i%
    
    If VLMarcadas = 0 Then
        Exit Sub
    End If
    
    If MsgBox("¿Esta seguro de Reversar la(s) Transaccion(es) Seleccionada(s)?", vbYesNo + vbQuestion + vbDefaultButton2, "Advertencia") = vbNo Then
        Exit Sub
    End If
    
    For i% = 1 To (grdRegistros.Rows - 1)
        grdRegistros.Row = i%
        grdRegistros.Col = 0
        
        If grdRegistros.Picture = picVisto(0) Then 'Cuando estan con el VISTITO
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "698"  '2850
            
            'secuencial
            grdRegistros.Col = 2
            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (grdRegistros.Text)
            
            grdRegistros.Col = 18
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, (grdRegistros.Text)
            
'            Select Case cmbTipo.ListIndex
'                Case 0
'                    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, 3
'                Case 1
'                    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, 4
'            End Select
            
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "R"
            
            'secuencial
            grdRegistros.Col = 1
            PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, (grdRegistros.Text)
            
            'moneda
            grdRegistros.Col = 7
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, (grdRegistros.Text)
            
            'transaccion
            grdRegistros.Col = 4
            PMPasoValores sqlconn&, "@i_trn", 0, SQLINT4, (grdRegistros.Text)
            
            'ingresador
            grdRegistros.Col = 9
            PMPasoValores sqlconn&, "@i_funcionario", 0, SQLVARCHAR, (grdRegistros.Text)
            
            'Monto
            grdRegistros.Col = 6
            PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, (grdRegistros.Text)

            'SSN Branch
            grdRegistros.Col = 11
            PMPasoValores sqlconn&, "@i_ssn_branch", 0, SQLINT4, (grdRegistros.Text)
            
            'Causa
            grdRegistros.Col = 8
            PMPasoValores sqlconn&, "@i_cau", 0, SQLCHAR, (grdRegistros.Text)
            
            'concepto
            grdRegistros.Col = 10
            PMPasoValores sqlconn&, "@i_concepto", 0, SQLVARCHAR, (grdRegistros.Text)
            
            PMPasoValores sqlconn&, "@i_autorizante", 0, SQLVARCHAR, (lblDescripcion(0).Caption)
            
            PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "N"

            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_autndc_ccah", True, " Ok... Reversa Transacciones....") Then
                PMChequea sqlconn&
            End If
        End If
    Next i%
    
    PLBuscar
End Sub
Private Sub Form_Load()
Dim VLFormatoFecha As String

    FPrincipal.MousePointer = 11
    FTRAN2850.Left = 0   '15
    FTRAN2850.Top = 0   '15
    FTRAN2850.Width = 9450   '9420
    FTRAN2850.Height = 5900   '5730
    
    PMLoadResStrings Me
    PMLoadResIcons Me

    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    picVisto(0).Picture = LoadResPicture(31001, 0)
    
    cmbTipo.AddItem "CUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORROS", 1
    cmbTipo.AddItem "TODAS", 2
    cmbTipo.ListIndex = 2
    
    mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
    
    PLConsultaFuncionario
    FPrincipal.MousePointer = 0
    
End Sub
Private Sub PLConsultaFuncionario()
'*************************************************************
' PROPOSITO: Se obtiene la descripcion del funcionario
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 26-Abr-05      L. Bernuil      Emisión Inicial
'*************************************************************
    ' Obtener el nombre del funcionario
    ' SP que dado el login traiga código y nombre de funcionario
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "698"  '2850
    PMPasoValores sqlconn&, "@i_login", 0, SQLVARCHAR, VGLogin$
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "SF"
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "0"
    PMPasoValores sqlconn&, "@i_autorizante", 0, SQLVARCHAR, " "
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_autndc_ccah", True, "Ok.. Consulta de Funcionarios...") Then
        PMMapeaObjetoAB sqlconn&, lblDescripcion(0), lblDescripcion(1)
        PMChequea sqlconn&
    Else
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        
        cmbTipo.Enabled = False
        mskCuenta.Enabled = False
        
        cmdBoton(0).Enabled = False 'Buscar
        cmdBoton(1).Enabled = False
        cmdBoton(2).Enabled = False 'Transmitir
        cmdBoton(3).Enabled = False 'Limpiar
        cmdBoton(4).Enabled = True 'Salir
        
        optEstado(0).Enabled = False
        optEstado(1).Enabled = False
        optEstado(2).Enabled = False
    End If
End Sub
Private Sub cmbTipo_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Tipo de Producto"
End Sub
Private Sub cmbTipo_LostFocus()
    If cmbTipo.ListIndex = 0 Then  '' Corrientes
        mskCuenta.Mask = VGMascaraCtaCte$
    ElseIf cmbTipo.ListIndex = 1 Then
        mskCuenta.Mask = VGMascaraCtaAho$
    End If
    
    Call mskCuenta_LostFocus
End Sub
Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la cuenta"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub
Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If cmbTipo.ListIndex = 0 Then          '  Corrientes
            If FMChequeaCtaCte((mskCuenta.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(2)
                    PMChequea sqlconn&
                Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                    lblDescripcion(2).Caption = ""
                    mskCuenta.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(2).Caption = ""
                mskCuenta.SetFocus
                
                Exit Sub
            End If
        ElseIf cmbTipo.ListIndex = 1 Then   '  Ahorros
            If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(2)
                    PMChequea sqlconn&
                Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                    lblDescripcion(2).Caption = ""
                    mskCuenta.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                lblDescripcion(2).Caption = ""
                mskCuenta.SetFocus
                Exit Sub
            End If
        Else
                MsgBox "Si se desea consultar una cuenta especifica se debe escoger el producto de la cuenta", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                If cmbTipo.Enabled = True Then cmbTipo.SetFocus
                Exit Sub
        End If
    End If
End Sub
Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
        Case 4 'Salir
            Unload FTRAN2850
        Case 3 'Limpiar
            PLLimpiar
        Case 2 'Transmitir
            PLTransmitir
        Case 1
            PLRechazar
        Case 0 ' Buscar
            PLBuscar
        Case 5 ' Actualizar
            PLImprimir
            PLBuscar
        Case 6
           PLReversar
    End Select
End Sub
Private Sub PLImprimir()
Dim VTRegistros As Integer
Dim VTFlag As Boolean
Dim VTSecuencial As Integer
Dim VTModo As Integer
Dim VTProducto As String
Dim VTEstadond As String
Dim VTTitulo As String
Dim i As Integer
Dim j As Integer

'Inicialización de Variables
VLDebito = 0
VLCredito = 0
VLLin = 0

    PMLimpiaGrid grdRegistros
    grdRegistros.Col = 0
    grdRegistros.Picture = LoadPicture()

    VTRegistros% = 10
    VTFlag = False
    VTSecuencial = 0
    VTModo% = 0

    While VTRegistros% = 10
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "698"   '2850
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
        PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, VTSecuencial
        PMPasoValores sqlconn&, "@i_autorizante", 0, SQLVARCHAR, (lblDescripcion(0).Caption)

        Select Case cmbTipo.ListIndex
            Case 0
                PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "3"
                VTProducto$ = " -CORRIENTES- "
            Case 1
                PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "4"
                VTProducto$ = " -AHORROS- "
            Case 2
                PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "3"
                PMPasoValores sqlconn&, "@i_producto1", 0, SQLINT4, "4"
                VTProducto$ = " -TODOS- "
        End Select
        
        If optEstado(0).Value = True Then 'ingresadas
            PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "I"
            VTEstadond$ = " (INGRESADAS) "
        Else
            If optEstado(1).Value = True Then 'autorizadas
                PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "A"
                VTEstadond$ = " (AUTORIZADAS) "
            Else
                If optEstado(2).Value = True Then 'Rechazadas
                    PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "R"
                    VTEstadond$ = " (RECHAZADAS) "
                Else
                    If optEstado(3).Value = True Then 'Rerversados
                        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "N"
                        VTEstadond$ = " (REVERSADA) "
                    End If
                End If
           End If
        End If

        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_autndc_ccah", True, "Ok... Consulta de Transacciones Por Autorizar") Then
            PMMapeaGrid sqlconn&, grdRegistros, VTFlag
            PMChequea sqlconn&
            VTFlag = True

            VTRegistros% = Val(grdRegistros.Tag)
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
            VTSecuencial = grdRegistros.Text
        Else
            VTRegistros% = 0
        End If
    Wend

    If grdRegistros.Rows <= 2 Then
        grdRegistros.Row = 1
        grdRegistros.Col = 1

        If Trim$(grdRegistros.Text) = "" Then
            cmdBoton(2).Enabled = False
            cmdBoton(1).Enabled = False
            cmdBoton(6).Enabled = False
        Else
            If optEstado(0).Value = True Then 'ingresadas
                cmdBoton(2).Enabled = True
                cmdBoton(1).Enabled = True 'PCOELLO HABILITA EL BOTON RECHAZAR PARA LAS INGRESADAS
            End If
'            cmdBoton(1).Enabled = True
        End If
    Else
            If optEstado(0).Value = True Then 'ingresadas
                cmdBoton(2).Enabled = True
                cmdBoton(1).Enabled = True 'PCOELLO HABILITA EL BOTON RECHAZAR PARA LAS INGRESADAS
            End If
'            cmdBoton(1).Enabled = True
    End If

    grdRegistros.ColWidth(1) = 900
    grdRegistros.ColWidth(2) = 1000
    grdRegistros.ColWidth(3) = 2700
    grdRegistros.ColWidth(4) = 900

    'Proceso de Impresión
    On Error GoTo Salir
    If MsgBox("Esta seguro de imprimir el reporte de Notas de Débito/Crédito", vbYesNo + vbQuestion, "Mensaje del Sistema") = vbYes Then
        Screen.MousePointer = 11
        Printer.Orientation = vbPRORLandscape
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        VTTitulo = "NOTAS CREDITO Y NOTAS DEBITO" + VTProducto$ + VTEstadond$
        FMCabeceraReporteSob VGBanco$, Date, VTTitulo$, Time(), Me.Caption, VGFecha$, Printer.Page
        Printer.FontSize = 7
        Printer.Print ""
        Printer.Print String$(180, "-")
        Printer.Print "Cuenta"; Tab(13); "Nombre."; Tab(45);
        Printer.Print ; "Transaccion."; Tab(110); "  Monto."; Tab(119);
        Printer.Print "  Causa."; Tab(129); "Concepto."; Tab(169); "  Usuario."; Tab(105);
        Printer.Print ""
        Printer.Print String$(180, "-")
        Printer.Print ""
        For j% = 1 To grdRegistros.Rows - 1
            grdRegistros.Row = j%
            grdRegistros.Col = 1
                For i% = 2 To 8
                    grdRegistros.Col = i%
                    Select Case i%
                    Case 2
                        Printer.Print Tab(1 + 11 - Len(grdRegistros.Text));
                    Case 3
                        Printer.Print Tab(13);
                    Case 4
                        Printer.Print Tab(45);
                    Case 5
                        Printer.Print Tab(114 + 4 - Len(grdRegistros.Text));
                    Case 6
                        Printer.Print Tab(122 + 4 - Len(grdRegistros.Text));
                    Case 7
                        Printer.Print Tab(129);
                    Case 8
                        Printer.Print Tab(169);
                    End Select
                    Printer.Print grdRegistros.Text;
                Next i%
                Printer.Print ""
                VLLin = VLLin + 1
                If VLLin = 50 Then
                    Printer.NewPage
                    FMCabeceraReporteSob VGBanco$, Date, VTTitulo$, Time(), Me.Caption, VGFecha$, Printer.Page
                    Printer.Print ""
                    Printer.Print String$(180, "-")
                    Printer.Print "Cuenta"; Tab(13); "Nombre."; Tab(45);
                    Printer.Print ; "Transaccion."; Tab(110); "  Monto."; Tab(119);
                    Printer.Print "  Causa."; Tab(129); "Concepto."; Tab(169); "  Usuario."; Tab(105);
                    Printer.Print ""
                    Printer.Print String$(180, "-")
                    Printer.Print ""
                End If
        Next j%

        For j% = 1 To grdRegistros.Rows - 1
            grdRegistros.Row = j%
            grdRegistros.Col = 10
                If grdRegistros.Text = "48" Or grdRegistros.Text = "253" Then
                    grdRegistros.Col = 5
                    VLCredito = VLCredito + grdRegistros.Text
                End If

                If grdRegistros.Text = "240" Or grdRegistros.Text = "2502" Or grdRegistros.Text = "264" Or grdRegistros.Text = "50" Then
                    grdRegistros.Col = 5
                    VLDebito = VLDebito + grdRegistros.Text
                End If
        Next j%

        lblDescripcion(3).Caption = Format$(VLCredito, "#,##0.00")
        lblDescripcion(4).Caption = Format$(VLDebito, "#,##0.00")

        Printer.FontSize = 7
        Printer.Print String$(180, "-")
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print "Total Notas Crédito                   :"; Tab(55 + 10 - Len(lblDescripcion(3).Caption)); lblDescripcion(3).Caption
        Printer.Print "Total Notas Débito                    :"; Tab(55 + 10 - Len(lblDescripcion(4).Caption)); lblDescripcion(4).Caption
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        If VGCodPais$ <> "CO" Then
            Printer.Print "---  U L T I M A   L I N E A  ---"
        End If
        Printer.EndDoc
        Screen.MousePointer = 0
    End If
    Exit Sub
Salir:
    MsgBox "Se generó el siguiente error al intetar realizar la impresión, favor contacte a soporte:" + error$
    Screen.MousePointer = 0
    Exit Sub

End Sub
Private Sub PLSiguiente()
'*************************************************************
' PROPOSITO: Busca los registros que coincidan con el criterio
'            seleccionado
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 07-Mar-06      J.Suarez        Emision Inicial
'*************************************************************
Dim VTFlag As Boolean
Dim VTRegistros As Integer
Dim VTSecuencial As String

VTFlag = True
VTRegistros% = 10

While VTRegistros% = 10

    grdRegistros.Row = grdRegistros.Rows - 1
    grdRegistros.Col = 1
    VTSecuencial = grdRegistros.Text

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "698"   '2850
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"

    If mskCuenta.ClipText <> "" Then
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
    End If
        
    PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, VTSecuencial
    PMPasoValores sqlconn&, "@i_autorizante", 0, SQLVARCHAR, (lblDescripcion(0).Caption)
        
    Select Case cmbTipo.ListIndex
        Case 0
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "3"
        Case 1
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "4"
        Case 2
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "3"
            PMPasoValores sqlconn&, "@i_producto1", 0, SQLINT4, "4"
    End Select
                        
    If optEstado(0).Value = True Then 'ingresadas
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "I"
    Else
        If optEstado(1).Value = True Then 'autorizadas
            PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "A"
        Else
            If optEstado(2).Value = True Then 'Rechazadas
                PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "R"
            Else
                If optEstado(3).Value = True Then 'Rerversados
                    PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "N"
                End If
            End If
        End If
    End If
                        
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_autndc_ccah", True, "Ok... Consulta de Transacciones Por Autorizar") Then
        PMMapeaGrid sqlconn&, grdRegistros, VTFlag
        PMChequea sqlconn&
        VTFlag = True
            
        If Val(grdRegistros.Tag) < 10 Then
            VTRegistros% = 0
        End If
            
    Else
        VTRegistros% = 0
    End If
Wend

grdRegistros.ColWidth(1) = 900
grdRegistros.ColWidth(2) = 1000
grdRegistros.ColWidth(3) = 2700
grdRegistros.ColWidth(4) = 900
    
grdRegistros.ColWidth(11) = 3000
grdRegistros.ColWidth(12) = 1500
End Sub
Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Busca los registros que coincidan con el criterio
'            seleccionado
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 26-Abr-05      L.Bernuil       Emision Inicial
'*************************************************************
    Dim VTRegistros As Integer
    Dim VTFlag As Boolean
    Dim VTSecuencial As Integer
    Dim VTModo As Integer
    
    PMLimpiaGrid grdRegistros
    grdRegistros.Col = 0
    grdRegistros.Picture = LoadPicture()
    
    VTRegistros% = 10
    VTFlag = False
    VTSecuencial = 0
    VTModo% = 0

        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "698"   '2850
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"

        If mskCuenta.ClipText <> "" Then
            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
        End If
        
        PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, VTSecuencial
        PMPasoValores sqlconn&, "@i_autorizante", 0, SQLVARCHAR, (lblDescripcion(0).Caption)
        
        Select Case cmbTipo.ListIndex
            Case 0
                PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "3"
            Case 1
                PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "4"
                PMPasoValores sqlconn&, "@i_producto1", 0, SQLINT4, "4" 'PCOELLO TAMBIEN ENVIAR EL 4 POR QUE ESTA POR DEFAULT 3 ENTONCES MUESTRA TAMBIEN LAS CORRIENTES Y SOLO DEBE MOSTRAR LAS DE AHORROS
            Case 2
                PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "3"
                PMPasoValores sqlconn&, "@i_producto1", 0, SQLINT4, "4"
        End Select
                        
        If optEstado(0).Value = True Then 'ingresadas
            PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "I"
        Else
            If optEstado(1).Value = True Then 'autorizadas
                PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "A"
            Else
                If optEstado(2).Value = True Then 'Rechazadas
                    PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "R"
                Else
                    If optEstado(3).Value = True Then 'Rerversados
                        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "N"
                    End If
                End If
            End If
        End If
                        
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_autndc_ccah", True, "Ok... Consulta de Transacciones Por Autorizar") Then
            PMMapeaGrid sqlconn&, grdRegistros, VTFlag
            PMChequea sqlconn&
            VTFlag = True
            
            'JCSA
            If Val(grdRegistros.Rows - 1) >= 10 Then
                PLSiguiente
            End If
            
            If grdRegistros.Rows <= 2 Then
                grdRegistros.Col = 1
                grdRegistros.Row = 1
'                If grdregistros.Text = "" Then
'                    PLLimpiar
'                    Exit Sub
'                End If
            End If
            'JCSA
            
            'grdRegistros.Row = grdRegistros.Rows - 1
            'grdRegistros.Col = 1
            'VTSecuencial = grdRegistros.Text
            
            'cmdBoton(2).Enabled = True
            'cmdBoton(1).Enabled = True
        End If
        
    If grdRegistros.Rows <= 2 Then
        grdRegistros.Row = 1
        grdRegistros.Col = 1
        
        If Trim$(grdRegistros.Text) = "" Then
            cmdBoton(2).Enabled = False
            cmdBoton(1).Enabled = False
            cmdBoton(6).Enabled = False
        Else
            If optEstado(0).Value = True Then 'ingresadas
                cmdBoton(2).Enabled = True
                cmdBoton(1).Enabled = True 'PCOELLO HABILITA EL BOTON RECHAZAR PARA LAS INGRESADAS
            End If
'            cmdBoton(1).Enabled = True
        End If
    Else
            If optEstado(0).Value = True Then 'ingresadas
                cmdBoton(2).Enabled = True
                cmdBoton(1).Enabled = True 'PCOELLO HABILITA EL BOTON RECHAZAR PARA LAS INGRESADAS
            End If
'            cmdBoton(1).Enabled = True
    End If
    
    grdRegistros.ColWidth(1) = 900
    grdRegistros.ColWidth(2) = 1000
    grdRegistros.ColWidth(3) = 2700
    grdRegistros.ColWidth(4) = 900
    
    grdRegistros.ColWidth(11) = 3000
    grdRegistros.ColWidth(12) = 1500
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
Private Sub grdRegistros_DblClick()
    ' Verificar que existan registros de transacciones por autorizar
    If grdRegistros.Rows <= 2 Then
        grdRegistros.Row = 1
        grdRegistros.Col = 1
        
        If Trim$(grdRegistros.Text) = "" Then
            MsgBox "No existen Registros por Autorizar", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
        
    Else
        If optEstado(2).Value = True Then
            MsgBox "No Puede seleccionar Transacciones Rechazadas", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    End If

    PMMarcarRegistro
End Sub
Private Sub PMMarcarRegistro()
'*************************************************************
' PROPOSITO: Seleccionar y quitar la Seleccion de una fila del
'            grid
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    grdRegistros.Col = 0
    If grdRegistros.Picture = picVisto(1) Then
        grdRegistros.Text = Str$(grdRegistros.Row)
        grdRegistros.Picture = picVisto(0)
    Else
        grdRegistros.Text = Str$(grdRegistros.Row)
        grdRegistros.Picture = picVisto(1)
    End If
End Sub
Private Sub PLTransmitir()
    Dim VLMarcadas As Integer
    Dim i As Integer
    Dim VTTransaccion As String
    
    VLMarcadas = 0
    
    For i% = 1 To (grdRegistros.Rows - 1)
        grdRegistros.Row = i%
        grdRegistros.Col = 0
    
        If grdRegistros.Picture = picVisto(0) Then
            VLMarcadas = VLMarcadas + 1
        End If
    Next i%
    
    If VLMarcadas = 0 Then
        Exit Sub
    End If
    
    If MsgBox("¿Esta seguro de Autorizar la(s) Transaccion(es) Seleccionada(s)?", vbYesNo + vbQuestion + vbDefaultButton2, "Advertencia") = vbNo Then
        Exit Sub
    End If
        
    
    For i% = 1 To (grdRegistros.Rows - 1)
        grdRegistros.Row = i%
        grdRegistros.Col = 0
        
        If grdRegistros.Picture = picVisto(0) Then 'Cuando estan con el VISTITO
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "698"   '2850
            
            'secuencial
            grdRegistros.Col = 2
            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (grdRegistros.Text)
            
            grdRegistros.Col = 18
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, (grdRegistros.Text)
            'Select Case cmbTipo.ListIndex
            '    Case 0
            '        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, 3
            '    Case 1
            '        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, 4
            'End Select
            
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
            
            'secuencial
            grdRegistros.Col = 1
            PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, (grdRegistros.Text)
            
            'moneda
            grdRegistros.Col = 7
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, (grdRegistros.Text)
            
            'transaccion
            grdRegistros.Col = 4
            VTTransaccion$ = grdRegistros.Text
            PMPasoValores sqlconn&, "@i_trn", 0, SQLINT4, (grdRegistros.Text)
            
            'ingresador
            grdRegistros.Col = 9
            PMPasoValores sqlconn&, "@i_funcionario", 0, SQLVARCHAR, (grdRegistros.Text)
            
            'Monto
            grdRegistros.Col = 6
            PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, (grdRegistros.Text)

            'SSN Branch
            grdRegistros.Col = 11
            PMPasoValores sqlconn&, "@i_ssn_branch", 0, SQLINT4, (grdRegistros.Text)
            
            'Causa
            grdRegistros.Col = 8
            PMPasoValores sqlconn&, "@i_cau", 0, SQLCHAR, (grdRegistros.Text)
            
            'concepto
            grdRegistros.Col = 10
            PMPasoValores sqlconn&, "@i_concepto", 0, SQLVARCHAR, (grdRegistros.Text)
            
            'secuencial de branch
            grdRegistros.Col = 11
            PMPasoValores sqlconn&, "@i_sec_branch", 0, SQLINT4, (grdRegistros.Text)
            
            PMPasoValores sqlconn&, "@i_autorizante", 0, SQLVARCHAR, (lblDescripcion(0).Caption)
            
            Select Case VTTransaccion$
                Case "2502" 'Nota de debito por cheque devuelto en camara
            
                    'cta del cheque
                    grdRegistros.Col = 13
                    PMPasoValores sqlconn&, "@i_ctachq", 0, SQLVARCHAR, (grdRegistros.Text)
            
                    'Numero del cheque
                    grdRegistros.Col = 14
                    PMPasoValores sqlconn&, "@i_nchq", 0, SQLINT4, (grdRegistros.Text)
           
                    'Tipo de cheque
                    grdRegistros.Col = 15
                    PMPasoValores sqlconn&, "@i_tipchq", 0, SQLVARCHAR, (grdRegistros.Text)
            
                    'Codigo del Banco
                    grdRegistros.Col = 16
                    PMPasoValores sqlconn&, "@i_codbanco", 0, SQLVARCHAR, (grdRegistros.Text)
                                
                Case "240"
                    'cta del cheque
                    grdRegistros.Col = 13
                    PMPasoValores sqlconn&, "@i_ctachq", 0, SQLVARCHAR, (grdRegistros.Text)
            
                    'Numero del cheque
                    grdRegistros.Col = 14
                    PMPasoValores sqlconn&, "@i_nchq", 0, SQLINT4, (grdRegistros.Text)
                      
                    'Codigo del Banco
                    grdRegistros.Col = 16
                    PMPasoValores sqlconn&, "@i_codbanco", 0, SQLVARCHAR, (grdRegistros.Text)
                
            End Select
            
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_autndc_ccah", True, " Ok... Autoriza Transacciones....") Then
                PMChequea sqlconn&
            End If
        End If
    Next i%
    
    PLBuscar
End Sub
Private Sub PLRechazar()
    Dim VLMarcadas As Integer
    Dim i As Integer
    
    VLMarcadas = 0
    
    For i% = 1 To (grdRegistros.Rows - 1)
        grdRegistros.Row = i%
        grdRegistros.Col = 0
    
        If grdRegistros.Picture = picVisto(0) Then
            VLMarcadas = VLMarcadas + 1
        End If
    Next i%
    
    If VLMarcadas = 0 Then
        Exit Sub
    End If
    
    If MsgBox("¿Esta seguro de Rechazar la(s) Transaccion(es) Seleccionada(s)?", vbYesNo + vbQuestion + vbDefaultButton2, "Advertencia") = vbNo Then
        Exit Sub
    End If
    
    For i% = 1 To (grdRegistros.Rows - 1)
        grdRegistros.Row = i%
        grdRegistros.Col = 0
        
        If grdRegistros.Picture = picVisto(0) Then 'Cuando estan con el VISTITO
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "698"   '2850
            
            'secuencial
            grdRegistros.Col = 2
            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (grdRegistros.Text)
            
            grdRegistros.Col = 18
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, (grdRegistros.Text)
            
'            Select Case cmbTipo.ListIndex
'                Case 0
'                    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, 3
'                Case 1
'                    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, 4
'            End Select
            
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "R"
            
            'secuencial
            grdRegistros.Col = 1
            PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, (grdRegistros.Text)
            
            'moneda
            grdRegistros.Col = 7
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, (grdRegistros.Text)
            
            'transaccion
            grdRegistros.Col = 4
            PMPasoValores sqlconn&, "@i_trn", 0, SQLINT4, (grdRegistros.Text)
            
            'ingresador
            grdRegistros.Col = 9
            PMPasoValores sqlconn&, "@i_funcionario", 0, SQLVARCHAR, (grdRegistros.Text)
            
            'Monto
            grdRegistros.Col = 6
            PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, (grdRegistros.Text)

            'SSN Branch
            grdRegistros.Col = 11
            PMPasoValores sqlconn&, "@i_ssn_branch", 0, SQLINT4, (grdRegistros.Text)
            
            'Causa
            grdRegistros.Col = 8
            PMPasoValores sqlconn&, "@i_cau", 0, SQLCHAR, (grdRegistros.Text)
            
            'concepto
            grdRegistros.Col = 10
            PMPasoValores sqlconn&, "@i_concepto", 0, SQLVARCHAR, (grdRegistros.Text)
            
            PMPasoValores sqlconn&, "@i_autorizante", 0, SQLVARCHAR, (lblDescripcion(0).Caption)
            
            PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "R"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_autndc_ccah", True, " Ok... Autoriza Transacciones....") Then
                PMChequea sqlconn&
            End If
        End If
    Next i%
    
    PLBuscar
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
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    PMLimpiaGrid grdRegistros
    grdRegistros.Col = 0
    grdRegistros.Picture = LoadPicture()
        
    cmbTipo.ListIndex = 2
    mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
    lblDescripcion(2).Caption = ""
    cmbTipo.SetFocus
    
    cmdBoton(0).Enabled = True
    cmdBoton(1).Enabled = False
    cmdBoton(6).Enabled = False
    cmdBoton(2).Enabled = False
    cmdBoton(3).Enabled = True
    cmdBoton(4).Enabled = True
    
    optEstado(0).Enabled = True
    optEstado(1).Enabled = True
    optEstado(2).Enabled = True
        
    optEstado(0).Value = True
    
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub
Private Sub optEstado_Click(Index As Integer, Value As Integer)
If Index = 0 Then 'ingresadas
    cmdBoton(6).Enabled = False
    cmdBoton(1).Enabled = True
Else
    If Index = 1 Then 'autorizadas
        cmdBoton(6).Enabled = True
        cmdBoton(1).Enabled = False
    End If
End If
    PLBuscar
End Sub

