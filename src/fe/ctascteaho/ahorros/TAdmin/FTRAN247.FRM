VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran247 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Consulta de Valores en Suspenso"
   ClientHeight    =   5325
   ClientLeft      =   465
   ClientTop       =   1605
   ClientWidth     =   9510
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
   HelpContextID   =   1048
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9510
   Tag             =   "3118"
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1950
      TabIndex        =   0
      Top             =   45
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   4296
      Left            =   30
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   1008
      Width           =   8448
      _Version        =   65536
      _ExtentX        =   14901
      _ExtentY        =   7578
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   5.99
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8600
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
      Left            =   8600
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
      Left            =   8600
      TabIndex        =   2
      Top             =   45
      WhatsThisHelpID =   2000
      Width           =   875
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
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   1
      Left            =   1950
      TabIndex        =   11
      Top             =   645
      Width           =   1815
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   2
      Left            =   6635
      TabIndex        =   10
      Top             =   645
      Width           =   1815
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Total Pendientes:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   1
      Left            =   15
      TabIndex        =   9
      Top             =   675
      WhatsThisHelpID =   5337
      Width           =   1590
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Total Cancelados:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   4680
      TabIndex        =   8
      Top             =   675
      WhatsThisHelpID =   5338
      Width           =   1635
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8550
      Y1              =   965
      Y2              =   980
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   1950
      TabIndex        =   5
      Top             =   345
      UseMnemonic     =   0   'False
      Width           =   6500
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. Cuenta de ahorros:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   0
      Left            =   15
      TabIndex        =   6
      Top             =   45
      WhatsThisHelpID =   5254
      Width           =   2295
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de la cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   15
      TabIndex        =   7
      Top             =   345
      WhatsThisHelpID =   5265
      Width           =   1920
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   8550
      X2              =   8550
      Y1              =   0
      Y2              =   9300
   End
End
Attribute VB_Name = "FTran247"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTRAN247.frm
' NOMBRE LOGICO:    FTran247
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
' Consulta de Valores en Suspenso
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Dim VLTotal As Double

Private Sub cmdBoton_Click(Index As Integer)
Dim bandera As Boolean  'Tania Suárez
Dim i As Integer
Dim contadorRegAnterior As Integer
Dim primVez As Boolean
Dim VTTotalC As Integer
Dim VTTotalP As Integer
    Select Case Index%
    Case 0
        'Buscar
        If mskCuenta.ClipText <> "" Then
            contadorRegAnterior = 0
            VLTotal = 0
            VTTotalP = 0
            VTTotalC = 0
            bandera = True
            primVez = True
            While bandera
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "247"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If primVez Then
                     PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, "0"
                Else
                    grdRegistros.Row = grdRegistros.Rows - 1
                    grdRegistros.Col = 1
                     PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, (grdRegistros.Text)
                End If
                PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_ah_cons_valsus", True, " Ok... Consulta de valores en suspenso") Then
                    If primVez Then
                         PMMapeaObjetoAB sqlconn&, lblDescripcion(1), lblDescripcion(2)
                         PMMapeaGrid sqlconn&, grdRegistros, False
                        primVez = False
                    Else
                         PMMapeaGrid sqlconn&, grdRegistros, True
                    End If
                     PMChequea sqlconn&
                End If
                If grdRegistros.Rows >= (contadorRegAnterior + 20) Then
                    contadorRegAnterior = grdRegistros.Rows - 1
                Else
                    bandera = False
                End If
            Wend


            If grdRegistros.Rows > 2 Then
                For i = 1 To grdRegistros.Rows - 1
                    grdRegistros.Row = i
                    grdRegistros.Col = 8

                    If (grdRegistros.Text = "C") Then
                         grdRegistros.Col = 6
                        VTTotalC = VTTotalC + CCur(grdRegistros.Text)
                    Else
                        grdRegistros.Col = 6
                        VTTotalP = VTTotalP + CCur(grdRegistros.Text)
                    End If
                Next i


                If VTTotalC = 0 Then
                    VLTotal = 0
                Else
                    VLTotal = Abs(VTTotalP - VTTotalC)
                    'lblDescripcion(2).Caption = Format(VLTotal, "#,##0.00")
                End If

            End If

        Else
            MsgBox "El número de Cuenta de Ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
        End If

    Case 1
        'mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        For i = 1 To 2
            lblDescripcion(i).Caption = ""
        Next i
        PMLimpiaGrid grdRegistros
        'mskCuenta.SetFocus
    Case 2
        Unload FTran247
    End Select
End Sub

Private Sub Form_Load()
    FTran247.Left = 0   '15
    FTran247.Top = 0   '15
    FTran247.Width = 9650   '9420
    FTran247.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaCte$
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta de Ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                'PLBuscar

            Else
                cmdBoton_Click (1)
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
            cmdBoton_Click (1)
            Exit Sub
        End If
    End If
End Sub


