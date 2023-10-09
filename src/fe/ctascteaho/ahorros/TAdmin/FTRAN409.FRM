VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran409 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Consulta de Cheques por Endoso"
   ClientHeight    =   5325
   ClientLeft      =   150
   ClientTop       =   1395
   ClientWidth     =   9300
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
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   1605
      TabIndex        =   0
      Top             =   60
      Width           =   2790
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   4
      Top             =   4560
      WhatsThisHelpID =   2008
      Width           =   875
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   3
      Top             =   3795
      WhatsThisHelpID =   2003
      Width           =   875
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
      Left            =   8415
      TabIndex        =   2
      Top             =   3030
      WhatsThisHelpID =   2007
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
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
   Begin MSGrid.Grid grdRegistros 
      Height          =   2970
      Left            =   15
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   2340
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   5239
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Cheques:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   90
      TabIndex        =   21
      Top             =   2100
      Width           =   810
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8385
      Y1              =   2040
      Y2              =   2040
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Corresponsal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   150
      TabIndex        =   6
      Top             =   1410
      Width           =   1170
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Propietario:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   150
      TabIndex        =   16
      Top             =   510
      Width           =   990
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Emisor:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   150
      TabIndex        =   20
      Top             =   810
      Width           =   630
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Moneda:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   150
      TabIndex        =   19
      Top             =   1110
      Width           =   750
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Carta:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   4
      Left            =   4905
      TabIndex        =   18
      Top             =   1710
      Width           =   690
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "No. de días:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   150
      TabIndex        =   17
      Top             =   1710
      Width           =   1080
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   1605
      TabIndex        =   15
      Top             =   510
      Width           =   1500
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   3120
      TabIndex        =   14
      Top             =   510
      UseMnemonic     =   0   'False
      Width           =   5235
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   1605
      TabIndex        =   13
      Top             =   810
      Width           =   1500
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   3120
      TabIndex        =   12
      Top             =   810
      UseMnemonic     =   0   'False
      Width           =   5235
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   4
      Left            =   1605
      TabIndex        =   11
      Top             =   1110
      Width           =   1500
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   5
      Left            =   3120
      TabIndex        =   10
      Top             =   1110
      Width           =   5235
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   6
      Left            =   1605
      TabIndex        =   9
      Top             =   1410
      UseMnemonic     =   0   'False
      Width           =   6750
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   7
      Left            =   5625
      TabIndex        =   8
      Top             =   1710
      Width           =   2730
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   8
      Left            =   1605
      TabIndex        =   7
      Top             =   1710
      Width           =   1500
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5310
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "No. de endoso:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   150
      TabIndex        =   5
      Top             =   60
      Width           =   1320
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8385
      Y1              =   435
      Y2              =   435
   End
End
Attribute VB_Name = "FTran409"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTRAN409.frm
' NOMBRE LOGICO:    FTran409
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
' Permite la Consulta de Cheques por Endoso
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Option Explicit
Dim VLStatus As String
Dim VLRef As String
Dim VLVez As Integer
Dim VLSalir As Boolean
Private Sub Form_Load()
    FTran409.Left = 0
    FTran409.Top = 0
    FTran409.Width = 9450
    FTran409.Height = 5900
    PMLoadResStrings Me
    PMLoadResIcons Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Dim VTR1 As Integer
    Dim i As Integer
    Select Case Index
    Case 0  'Transmitir
        If txtCampo.Text <> "" Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "409"
             PMPasoValores sqlconn&, "@i_end", 0, SQLINT4, (txtCampo.Text)
             If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_chequexend", True, "Ok... Consulta de cheques por endoso") Then
                ReDim VTArreglo(20) As String
                 VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
                 PMMapeaGrid sqlconn&, grdRegistros, False
                 PMChequea sqlconn&
                lblDescripcion(0).Caption = VTArreglo(3)
                lblDescripcion(1).Caption = VTArreglo(4)
                lblDescripcion(2).Caption = VTArreglo(5)
                lblDescripcion(3).Caption = VTArreglo(6)
                lblDescripcion(4).Caption = VTArreglo(1)
                lblDescripcion(5).Caption = VTArreglo(2)
                lblDescripcion(6).Caption = VTArreglo(7)
                lblDescripcion(7).Caption = VTArreglo(8)
                lblDescripcion(8).Caption = VTArreglo(9)
            End If
        Else
            MsgBox "El número del endoso es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo.SetFocus
        End If
    Case 1  'Limpiar
        txtCampo.Text = ""
        For i = 0 To 8
            lblDescripcion(i).Caption = ""
        Next i
        PMLimpiaGrid grdRegistros
        txtCampo.SetFocus
    Case 2  'Salir
        Unload FTran409
    End Select
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
Dim VTR1 As Integer
   If grdRegistros.Text <> "" Then
        VLVez = 1
        VLSalir = False
        VLStatus = " "
        VLRef = "0"
        While Not VLSalir
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "407"
            grdRegistros.Col = 1
             PMPasoValores sqlconn&, "@i_secuen", 0, SQLINT4, (grdRegistros.Text)
            grdRegistros.Col = 2
             PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, FMConvFecha((grdRegistros.Text), VGFormatoFecha, CGFormatoBase)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
             PMPasoValores sqlconn&, "@i_status", 0, SQLVARCHAR, VLStatus
             PMPasoValores sqlconn&, "@i_ref", 0, SQLINT4, VLRef
             PMPasoValores sqlconn&, "@i_vez", 0, SQLINT1, Str$(VLVez)
             PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP)
             If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_consulcar", True, " OK... Consulta general de la carta de Cheques del Exterior") Then
                If VLVez = 1 Then
                    ReDim VTArreglo(20) As String
                     VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
                     PMMapeaGrid sqlconn&, FTran407!grdRegistros, False
                Else
                     PMMapeaGrid sqlconn&, FTran407!grdRegistros, True
                End If
                 PMChequea sqlconn&
                VLVez = VLVez + 1
                If FTran407!grdRegistros.Tag < 45 Then VLSalir = True
                FTran407!lblDescripcion(0).Caption = VTArreglo(1)
                FTran407!lblDescripcion(1).Caption = VTArreglo(2)
                FTran407!lblDescripcion(2).Caption = VTArreglo(3)
                FTran407!lblDescripcion(3).Caption = VTArreglo(4)
                FTran407!lblDescripcion(4).Caption = VTArreglo(5)
                FTran407!lblDescripcion(5).Caption = VTArreglo(6)
                FTran407!lblDescripcion(6).Caption = VTArreglo(7)
                FTran407!lblDescripcion(7).Caption = VTArreglo(8)
                FTran407!lblDescripcion(8).Caption = VTArreglo(9)
                FTran407!lblDescripcion(9).Caption = VTArreglo(10)
                grdRegistros.Col = 1
                FTran407.lblDescripcion(10).Caption = grdRegistros.Text
                grdRegistros.Col = 2
                FTran407.lblDescripcion(11).Caption = grdRegistros.Text
                FTran407!grdRegistros.Row = FTran407!grdRegistros.Rows - 1
                FTran407!grdRegistros.Col = 6
                VLStatus = FTran407!grdRegistros.Text
                FTran407!grdRegistros.Col = 7
                VLRef = FTran407!grdRegistros.Text
            End If
        Wend
        FTran407.Show 1
    End If
End Sub

Private Sub grdRegistros_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Doble click para consultar los cheques de la carta"
End Sub

Private Sub txtCampo_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Código del corresponsal"
    txtCampo.SelStart = 0
    txtCampo.SelLength = Len(txtCampo.Text)
End Sub

Private Sub txtCampo_KeyPress(KeyAscii As Integer)
    KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
End Sub


