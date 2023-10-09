VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTranUpGMF 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Actualización GMF Ahorros/Corrientes"
   ClientHeight    =   4845
   ClientLeft      =   60
   ClientTop       =   1740
   ClientWidth     =   9480
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00FFFFFF&
   HelpContextID   =   1061
   Icon            =   "FTRANUPGMF.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4845
   ScaleWidth      =   9480
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   12
      Left            =   1920
      MaxLength       =   2
      TabIndex        =   3
      Top             =   2850
      Width           =   675
   End
   Begin VB.ComboBox cmbTipo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      HelpContextID   =   1
      Left            =   1920
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   120
      Width           =   2505
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   780
      Index           =   2
      Left            =   8460
      TabIndex        =   4
      Top             =   795
      WhatsThisHelpID =   2508
      Width           =   990
      _Version        =   65536
      _ExtentX        =   1746
      _ExtentY        =   1376
      _StockProps     =   78
      Caption         =   "*&Rta CIFIN"
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
      Picture         =   "FTRANUPGMF.frx":030A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   780
      Index           =   3
      Left            =   8460
      TabIndex        =   7
      Top             =   3180
      WhatsThisHelpID =   2003
      Width           =   990
      _Version        =   65536
      _ExtentX        =   1746
      _ExtentY        =   1376
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
      Picture         =   "FTRANUPGMF.frx":0326
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   780
      Index           =   4
      Left            =   8460
      TabIndex        =   8
      Top             =   3975
      WhatsThisHelpID =   2008
      Width           =   990
      _Version        =   65536
      _ExtentX        =   1746
      _ExtentY        =   1376
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
      Picture         =   "FTRANUPGMF.frx":0342
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   6030
      TabIndex        =   1
      Tag             =   "1"
      Top             =   120
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   503
      _Version        =   393216
      MaxLength       =   15
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   780
      Index           =   1
      Left            =   8460
      TabIndex        =   2
      Top             =   0
      WhatsThisHelpID =   2000
      Width           =   990
      _Version        =   65536
      _ExtentX        =   1746
      _ExtentY        =   1376
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
      Picture         =   "FTRANUPGMF.frx":035E
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   780
      Index           =   5
      Left            =   8460
      TabIndex        =   5
      Tag             =   "4142"
      Top             =   1590
      WhatsThisHelpID =   2509
      Width           =   990
      _Version        =   65536
      _ExtentX        =   1746
      _ExtentY        =   1376
      _StockProps     =   78
      Caption         =   "*&Marcar"
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
      Picture         =   "FTRANUPGMF.frx":037A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   780
      Index           =   6
      Left            =   8460
      TabIndex        =   6
      Tag             =   "4148"
      Top             =   2385
      WhatsThisHelpID =   2510
      Width           =   990
      _Version        =   65536
      _ExtentX        =   1746
      _ExtentY        =   1376
      _StockProps     =   78
      Caption         =   "*&Desmarcar"
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
      Picture         =   "FTRANUPGMF.frx":0396
   End
   Begin VB.Label lblFecDesm 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   1920
      TabIndex        =   32
      Top             =   4075
      Width           =   1920
   End
   Begin VB.Label lblFecMarca 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   1920
      TabIndex        =   31
      Top             =   2040
      Width           =   1920
   End
   Begin VB.Label lblOfiDesmarca 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   1920
      TabIndex        =   30
      Top             =   4470
      Width           =   675
   End
   Begin VB.Label lblOfiMarca 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   1920
      TabIndex        =   29
      Top             =   2460
      Width           =   675
   End
   Begin VB.Label txtdescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   525
      Left            =   2610
      TabIndex        =   28
      Top             =   2850
      Width           =   5685
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   3
      X1              =   0
      X2              =   8385
      Y1              =   925
      Y2              =   925
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   2
      Left            =   1920
      TabIndex        =   14
      Top             =   1100
      Width           =   6375
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Estado Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   120
      TabIndex        =   13
      Top             =   1145
      Width           =   1320
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   120
      TabIndex        =   27
      Top             =   4120
      Width           =   600
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Usuario:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   4560
      TabIndex        =   26
      Top             =   4120
      Width           =   720
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   6030
      TabIndex        =   25
      Top             =   4075
      Width           =   2265
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Oficina"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   120
      TabIndex        =   24
      Top             =   4515
      Width           =   615
   End
   Begin VB.Label lblOficinaDesm 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   2610
      TabIndex        =   23
      Top             =   4470
      Width           =   5685
   End
   Begin VB.Label Label1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Datos Desmarcación de Exención Cuenta :"
      ForeColor       =   &H00800000&
      Height          =   195
      Left            =   120
      TabIndex        =   22
      Top             =   3630
      Width           =   3585
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8385
      Y1              =   3470
      Y2              =   3470
   End
   Begin VB.Label lblOficinaMarca 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   2610
      TabIndex        =   20
      Top             =   2460
      Width           =   5685
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Oficina"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   120
      TabIndex        =   21
      Top             =   2505
      Width           =   615
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Concepto Exención:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   18
      Left            =   120
      TabIndex        =   17
      Top             =   2895
      Width           =   1725
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   14
      Left            =   6030
      TabIndex        =   19
      Top             =   2070
      Width           =   2265
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Usuario:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   20
      Left            =   4560
      TabIndex        =   18
      Top             =   2115
      Width           =   720
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   19
      Left            =   120
      TabIndex        =   16
      Top             =   2085
      Width           =   600
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   1920
      TabIndex        =   12
      Top             =   480
      Width           =   6375
   End
   Begin VB.Label lblobse 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Datos Marcación de Exención Cuenta :"
      ForeColor       =   &H00800000&
      Height          =   195
      Left            =   120
      TabIndex        =   15
      Top             =   1710
      Width           =   3480
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Producto :"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   120
      TabIndex        =   9
      Top             =   165
      Width           =   855
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   120
      TabIndex        =   11
      Top             =   525
      Width           =   1380
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8385
      Y1              =   1545
      Y2              =   1545
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "No. de Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   4560
      TabIndex        =   10
      Top             =   165
      Width           =   1305
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8400
      X2              =   8400
      Y1              =   0
      Y2              =   4850
   End
End
Attribute VB_Name = "FTranUpGMF"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*********************************************************
' MODIFICACIONES:
' LCM: FEB-17-2012 REQ 315: GMF Linea CIFIN
'*********************************************************
Option Explicit
Dim VLPaso As Integer
Dim VLFormatoFechaMar As String
Dim VLTipoPer As String
Dim VLUnicTit As String
Dim VLOtraEx As String
Dim VLProducto_ac As String
'FIXIT: Declare 'VLindDTN' with an early-bound data type                                   FixIT90210ae-R1672-R1B8ZE
Dim VLindDTN As String
'FIXIT: Declare 'VLNatTit' with an early-bound data type                                   FixIT90210ae-R1672-R1B8ZE
Dim VLNatTit As String
'FIXIT: Declare 'VLContCoTit' with an early-bound data type                                FixIT90210ae-R1672-R1B8ZE
Dim VLContCoTit As Integer
Dim VLMarcar As String
Dim VLPermisoMarcar As Boolean
Dim VLPermisoDesmarcar As Boolean
Dim VLFormatoFecha As String

Private Sub cmbTipo_LostFocus()
If cmbTipo.Text = "CUENTA CORRIENTE" Then
    mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
Else
    mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
End If

End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 1 'Buscar
        PLBuscar
    Case 2 'Respuesta CIFIN
        FRTACIFIN.Show
    Case 3 'Limpiar
        PLLimpiar
    Case 4 'Salir
        Unload FTranUpGMF
    Case 5 'Marcar
       VLMarcar = "S"
       PLTransmitir
       PLBuscar
    Case 6 'Desmarcar
       VLMarcar = "N"
       PLTransmitir
       PLBuscar
    End Select
End Sub

Private Sub Form_Load()
    FTranUpGMF.Left = 15
    FTranUpGMF.Top = 15
    FTranUpGMF.Width = 9570
    FTranUpGMF.Height = 5220
    
    'Habilita boton marcacion GMF
    PMObjetoSeguridad FTranUpGMF.cmdBoton(5)
    VLPermisoMarcar = FTranUpGMF.cmdBoton(5).Enabled
    
    'Habilita boton desmarcacion GMF
    PMObjetoSeguridad FTranUpGMF.cmdBoton(6)
    VLPermisoDesmarcar = FTranUpGMF.cmdBoton(6).Enabled
    
    cmbTipo.AddItem "CUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORRO", 1
    cmbTipo.ListIndex = 1
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
       mskCuenta.Mask = VGMascaraCtaCte$
    Else
        mskCuenta.Mask = VGMascaraCtaAho$
    End If
    cmbTipo.Enabled = False
    VLProducto_ac = Space(0)
    
    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    VLFormatoFechaMar = VLFormatoFecha$
    
    PMLoadResStrings Me
    PMLoadResIcons Me
    Call cmdBoton_Click(3)
        
End Sub

Private Sub mskCuenta_Change()
    txtCampo(12).Text = ""
    txtdescripcion.Caption = ""
    lblDescripcion(14).Caption = ""
    lblDescripcion(0).Caption = ""
End Sub

Private Sub mskCuenta_GotFocus()
   FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta "
   mskCuenta.SelStart = 0
   mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub PLBuscar()
Dim VTR1 As Integer
 If mskCuenta.ClipText <> "" Then
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
           If FMChequeaCtaCte((mskCuenta.ClipText)) Then
               PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, VLMarcar
               PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
               PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
               PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2747"
               If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_upd_gmf_cc", True, " Ok... Actualización de la cuenta de ahorros") Then
                   ReDim VTArreglo(8) As String
                   VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
                   PMChequea sqlconn&
                   lblDescripcion(0).Caption = VTArreglo(1)
                   VLindDTN = VTArreglo(6) 'indica cta dtn
                   VLNatTit = VTArreglo(7) 'naturaleza
                   VLContCoTit = VTArreglo(8) 'numero ti titulares
                   VLProducto_ac = "3"
                   If VTArreglo(2) = "S" Then
                      lblFecMarca.Caption = Format$(VTArreglo(3), VLFormatoFechaMar)
                      txtCampo(12).Text = VTArreglo(4)
                      Call txtCampo_LostFocus(12)
                      lblDescripcion(14) = VTArreglo(5)
                   End If
                
                   If VTArreglo(2) = "N" Then
                      txtCampo(12).Text = VTArreglo(4)
                      Call txtCampo_LostFocus(12) 'ccb para traer descripcion
                      txtCampo(12).Enabled = False
                      lblFecMarca.Caption = Format$(VTArreglo(3), VLFormatoFechaMar)
                      lblDescripcion(14) = VTArreglo(5)
                   End If

                   cmdBoton(2).Enabled = True
               Else
                   mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                   lblDescripcion(0).Caption = ""
                   If mskCuenta.Enabled = True Then
                      mskCuenta.SetFocus
                   End If
                   Exit Sub
               End If
           Else
               MsgBox "El dígito verificador de la cuenta corriente está incorrecto", 0 + 16, "Mensaje de Error"
               mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
               lblDescripcion(0).Caption = ""
               If mskCuenta.Enabled = True Then
                   mskCuenta.SetFocus
               End If
               Exit Sub
           End If
        Else
           If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4106"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_upd_gmf_ac", True, " Ok... Actualización de la cuenta de ahorros") Then
                    ReDim VTArreglo(17) As String
                    VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                    PMChequea sqlconn&
                    VLProducto_ac = "4"
                    
                    lblDescripcion(0).Caption = VTArreglo(1) 'Nombre
                    VLindDTN = VTArreglo(6) 'indica cta dtn
                    VLNatTit = VTArreglo(7) 'naturaleza
                    VLContCoTit = VTArreglo(8) 'numero titulares
                    lblDescripcion(2) = "CUENTA SIN EXENCIÓN DE GMF"
                    cmdBoton(2).Enabled = False
                    If VTArreglo(17) = "S" Then
                       cmdBoton(2).Enabled = True
                    End If
                    If VTArreglo(2) <> "" Then
                        If VTArreglo(2) = "S" Then
                           'Cuenta Exenta de GMF
                           lblDescripcion(2) = "CUENTA CON EXENCIÓN DE GMF"
                           txtCampo(12).Enabled = False
                           cmdBoton(5).Enabled = False
                           cmdBoton(6).Enabled = VLPermisoDesmarcar ' True
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                           If Trim$(VTArreglo(3)) <> "" Then
                              lblFecMarca.Caption = Format$(VTArreglo(3), VLFormatoFechaMar)  'Fecha Marcacion
                              txtCampo(12).Text = VTArreglo(4) 'Concepto
                              Call txtCampo_LostFocus(12)
                              lblDescripcion(14) = VTArreglo(5) 'Usuario
                              lblOfiMarca.Caption = VTArreglo(9) 'Oficina Marcacion
                              lblOficinaMarca.Caption = VTArreglo(11) 'Nombre Oficina Marcacion
                              lblFecDesm.Caption = ""  'Fecha Desmarcacion
                              lblDescripcion(1) = "" 'Usuario Desmarcacion
                              lblOfiDesmarca.Caption = ""  'Oficina Desmarcacion
                              lblOficinaDesm.Caption = "" 'Nombre Oficina Desmarcacion
                           End If
                        Else
                           'Cuenta No exenta de GMF
                           lblDescripcion(2) = "CUENTA SIN EXENCIÓN DE GMF"
                           txtCampo(12).Enabled = True
                           cmdBoton(5).Enabled = VLPermisoMarcar ' True
                           cmdBoton(6).Enabled = False
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                           If Trim$(VTArreglo(3)) <> "" Then
                              lblFecMarca.Caption = ""  'Fecha Marcacion
                              txtCampo(12).Text = ""
                              txtdescripcion.Caption = ""
                              lblDescripcion(14) = "" 'Usuario
                              lblOfiMarca.Caption = "" 'Oficina Marcacion
                              lblOficinaMarca.Caption = "" 'Nombre Oficina Marcacion
                              lblFecDesm.Caption = Format$(VTArreglo(13), VLFormatoFechaMar)  'Fecha Desmarcacion
                              lblDescripcion(1) = VTArreglo(14) 'Usuario Desmarcacion
                              lblOfiDesmarca.Caption = VTArreglo(15)  'Oficina Desmarcacion
                              lblOficinaDesm.Caption = VTArreglo(16) 'Nombre Oficina Desmarcacion
                           End If

                        End If
                    End If
                    
                 Else
                    Call cmdBoton_Click(3)
                    lblDescripcion(0).Caption = ""
                     If mskCuenta.Enabled = True Then
                      mskCuenta.SetFocus
                    End If
                    Exit Sub
                   End If
           Else
                MsgBox "El dígito verificador de la cuenta ahorro está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                lblDescripcion(0).Caption = ""
                If mskCuenta.Enabled = True Then
                  mskCuenta.SetFocus
                End If
                Exit Sub
           End If
        End If
        
  Else
     MsgBox "El Número de Cuenta es Mandatorio", 0 + 16, "Mensaje de Error"
  End If
End Sub
Private Sub PLLimpiar()
    cmbTipo.ListIndex = 1
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
       mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
    Else
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
    End If
    txtCampo(12).Text = ""
    txtdescripcion.Caption = ""
    lblDescripcion(14).Caption = ""
    lblDescripcion(0).Caption = ""
    lblFecMarca.Caption = ""
    cmdBoton(2).Enabled = False
    lblOfiMarca.Caption = ""
    lblOficinaMarca.Caption = ""
    lblFecDesm.Caption = ""
    lblDescripcion(1).Caption = ""
    lblOfiDesmarca.Caption = ""
    lblOficinaDesm.Caption = ""
    cmdBoton(5).Enabled = False
    cmdBoton(6).Enabled = False
End Sub

Private Sub PLTransmitir()
    ' Tipo de la cuenta de ahorros
    If cmbTipo.Text = "" Then
        MsgBox "El producto es mandatorio", 0 + 16, "Mensaje de Error"
        Exit Sub
    End If

    ' Nombre de la cuenta de ahorros
    If mskCuenta.Text = "" Then
        MsgBox "El numero de cuenta es mandatorio", 0 + 16, "Mensaje de Error"
        mskCuenta.SetFocus
        Exit Sub
    End If
   ' validacion fecha
   VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")

    
  'Para gmf
    If VLMarcar = "S" And txtCampo(12).Text = "" Then
    MsgBox "El concepto de exención es mandatorio", 0 + 16, "Mensaje de Error"
         txtCampo(12).SetFocus
         Exit Sub
    End If
   
    ' Validación concepto exención REQ. 453
    If VLTipoPer <> "Y" And VLMarcar = "S" = True Then
       If VLTipoPer <> VLNatTit Then
          MsgBox "Concepto de exención no permitido para tipo de persona del titular", 0 + 16, "Mensaje de Error"
          Exit Sub
       End If
    End If
 
    If VLUnicTit = "S" And VLMarcar = "S" = True Then
       If VLContCoTit > 1 Then
          MsgBox "La cuenta requiere titular único para marcación de exención de GMF ", 0 + 16, "Mensaje de Error"
          Exit Sub
       End If
    End If
    
    If mskCuenta.Text = "" Or mskCuenta.Text = "_-____-_-_____-_" Then
        MsgBox "Numero de Cuenta es obligatorio", 0 + 16, "Mensaje de Error"
        mskCuenta.SetFocus
        Exit Sub
    End If
    
      
    PMPasoValores sqlconn&, "@i_gmfmarca", 0, SQLCHAR, VLMarcar
    PMPasoValores sqlconn&, "@i_fecmarca", 0, SQLDATETIME, FMConvFecha(lblFecMarca.Caption, VLFormatoFecha$, "mm/dd/yyyy")
    PMPasoValores sqlconn&, "@i_concepto", 0, SQLINT2, txtCampo(12).Text
    PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP$ 'Y2K ARO
    PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR, (txtdescripcion.Caption)
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
    PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
       PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2747"
       If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_upd_gmf_cc", True, " Ok... Actualización de la cuenta de ahorros") Then
          cmdBoton(2).Enabled = False
       End If
    Else
       PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
       PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4106"
       If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_upd_gmf_ac", True, " Ok... Actualización de la cuenta de ahorros") Then
          cmdBoton(2).Enabled = False
       End If
    End If
    PMChequea sqlconn&
    If FMRetStatus(sqlconn&) = 0 Then
       If VLMarcar = "S" Then
          MsgBox "Proceso de Marcación de Exención de GMF Finalizado con Éxito"
       Else
          MsgBox "Proceso de Desmarcación de Exención de GMF Finalizado con Éxito"
       End If
       FRTACIFIN.Show
    End If
       
End Sub
Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 12
        VLPaso% = False
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 12
        FPrincipal!pnlHelpLine.Caption = " Concepto de Exención"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode = VGTeclaAyuda% Then
        VGOperacion$ = ""
        Select Case Index%
        Case 12
           PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "F"
           PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4105"
           PMPasoValores sqlconn&, "@i_cuenta", 0, SQLINT2, "0"
           PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VLProducto_ac
           VGOperacion$ = "sp_exencion"
           If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_calcula_gmf", True, " Ok... Consulta de agencias") Then
              PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True 'False
              PMChequea sqlconn&
              VLPaso% = True
              FCatalogo.Show 1
              txtCampo(12).Text = VGACatalogo.Codigo$
              txtdescripcion.Caption = VGACatalogo.Descripcion$
           End If
        
        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 12
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Dim VTR1 As Integer
    Select Case Index%
    Case 12
        If txtCampo(12).Text <> "" Then
           PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "B"
           PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4105"
           PMPasoValores sqlconn&, "@i_cuenta", 0, SQLINT2, txtCampo(12).Text
           PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VLProducto_ac
           If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_calcula_gmf", True, " Ok... Consulta de agencias") Then
              ReDim VTArreglo(5) As String
              VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
              PMChequea sqlconn&
              txtdescripcion.Caption = VTArreglo(1)
              VLTipoPer = VTArreglo(2)
              VLUnicTit = VTArreglo(3)
              VLOtraEx = VTArreglo(4)
           Else
              txtdescripcion.Caption = ""
              txtCampo(12).Text = ""
              txtCampo(12).SetFocus
           End If
        Else
              txtdescripcion.Caption = ""
        End If
    End Select
End Sub


