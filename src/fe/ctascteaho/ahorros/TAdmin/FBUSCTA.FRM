VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FBusCta 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Consulta de Cuentas"
   ClientHeight    =   3825
   ClientLeft      =   2790
   ClientTop       =   4260
   ClientWidth     =   6360
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
   HelpContextID   =   1111
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3825
   ScaleWidth      =   6360
   Tag             =   "0"
   Begin VB.TextBox txtProducto 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   480
      MaxLength       =   60
      TabIndex        =   8
      Top             =   840
      Visible         =   0   'False
      Width           =   600
   End
   Begin VB.TextBox txtcampo 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   960
      MaxLength       =   60
      TabIndex        =   0
      Top             =   10
      Width           =   1080
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   5475
      TabIndex        =   3
      Top             =   2290
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
      Index           =   1
      Left            =   5475
      TabIndex        =   1
      Top             =   770
      WhatsThisHelpID =   2001
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Sig&tes."
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
      Index           =   2
      Left            =   5475
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
      Index           =   3
      Left            =   5475
      TabIndex        =   4
      Top             =   3060
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
   Begin MSGrid.Grid grdCuentas 
      Height          =   3440
      Left            =   0
      TabIndex        =   5
      Top             =   360
      Width           =   5400
      _Version        =   65536
      _ExtentX        =   9525
      _ExtentY        =   6068
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
      Index           =   0
      Left            =   5475
      TabIndex        =   7
      Top             =   1530
      WhatsThisHelpID =   2002
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Escoger"
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
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   5430
      Y1              =   350
      Y2              =   350
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Cliente:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   0
      Left            =   60
      TabIndex        =   6
      Top             =   10
      Width           =   840
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   5430
      X2              =   5430
      Y1              =   0
      Y2              =   5265
   End
End
Attribute VB_Name = "FBusCta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
 Option Explicit
 Dim VLCtaBco As String
 Dim VLNombre1 As String
 
 
'*************************************************************
' ARCHIVO:          FBusCta.frm
' NOMBRE LOGICO:    FBusCta
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
' Permite realizar la Consulta de Cuentas (Help)
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Private Sub cmdBoton_Click(Index As Integer)
'! removed Dim i%

    Select Case Index%
    Case 0 'Escoger
        PLEscoger
    Case 1 'Siguientes
        PLSiguientes
    Case 2 'Buscar
        PLBuscar
    Case 3 'Salir
        Unload FBusCta
    Case 4 'Limpiar
        PLLimpiar
    End Select
End Sub

Private Sub Form_Activate()
    PLBuscar
End Sub

Private Sub Form_Load()
    FBusCta.Left = FPrincipal.Left + 50
    FBusCta.Top = FPrincipal.Top + 1000
    FBusCta.Width = 6450
    FBusCta.Height = 4200
    PMLoadResStrings Me
    PMLoadResIcons Me
    cmdBoton(2).Enabled = True
End Sub

Private Sub grdCuentas_Click()
    grdCuentas.col = 0
    grdCuentas.SelStartCol = 1
    grdCuentas.SelEndCol = grdCuentas.Cols - 1
    If grdCuentas.Row = 0 Then
       grdCuentas.SelStartRow = 1
       grdCuentas.SelEndRow = 1
    Else
       grdCuentas.SelStartRow = grdCuentas.Row
       grdCuentas.SelEndRow = grdCuentas.Row
    End If

End Sub

Private Sub grdCuentas_DblClick()
     PLEscoger
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

    PMLimpiaGrid grdCuentas
    grdCuentas.ColWidth(1) = 650
    cmdBoton(0).Enabled = False
    cmdBoton(1).Enabled = False
    'txtcampo.Enabled = True
    'txtcampo.Text = ""
    'txtcampo.SetFocus
End Sub

Private Sub PLSiguientes()
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
   If Trim(txtcampo.Text) = "" Then
      MsgBox "El nombre es mandatorio", 0 + 16, "Mensaje de Error"
      txtcampo.SetFocus
      Exit Sub
   End If
 
   grdCuentas.Row = grdCuentas.Rows - 1
   grdCuentas.col = 1
   VLCtaBco$ = grdCuentas.Text
   grdCuentas.col = 2
   VLNombre1$ = grdCuentas.Text
   

   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "340"
   PMPasoValores sqlconn&, "@i_nombre", 0, SQLCHAR, ""
   PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
   PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "2"
   PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT1, txtcampo.Text
   grdCuentas.Row = grdCuentas.Rows - 1
   grdCuentas.col = 1
   PMPasoValores sqlconn&, "@i_cuenta", 0, SQLCHAR, Me.grdCuentas.Text
   PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtProducto.Text
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_helpcta_ah", True, " Ok... Consulta de Cuentas") Then
      PMMapeaGrid sqlconn&, grdCuentas, True
      PMChequea sqlconn&
      If grdCuentas.Tag = 20 Then
         cmdBoton(1).Enabled = True
      Else
         cmdBoton(1).Enabled = False
      End If
   End If
End Sub

Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Consulta cuentas dado el nombre
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "340"
   PMPasoValores sqlconn&, "@i_nombre", 0, SQLCHAR, ""
   PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
   PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "2"
   PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, txtcampo.Text
   PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtProducto.Text
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_helpcta_ah", True, " Ok... Consulta de Cuentas") Then
      PMMapeaGrid sqlconn&, grdCuentas, False
      PMChequea sqlconn&
      cmdBoton(0).Enabled = True
      If grdCuentas.Tag = 20 Then
         cmdBoton(1).Enabled = True
      Else
         cmdBoton(1).Enabled = False
      End If
   End If
End Sub

Private Sub PLEscoger()
     grdCuentas.col = 1
     If Trim$(grdCuentas.Text) <> "" Then
        VGADatosO(0) = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
     End If
     Unload Me
End Sub

