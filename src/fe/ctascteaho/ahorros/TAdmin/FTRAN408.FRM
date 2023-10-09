VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran408 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Consulta de Cheques de Remesas por Cuenta"
   ClientHeight    =   5340
   ClientLeft      =   195
   ClientTop       =   2010
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
   HelpContextID   =   1040
   Icon            =   "FTRAN408.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5340
   ScaleWidth      =   9300
   Tag             =   "3883"
   Begin Threed.SSFrame FrameTipoR 
      Height          =   975
      Left            =   4545
      TabIndex        =   16
      Top             =   0
      WhatsThisHelpID =   5435
      Width           =   3720
      _Version        =   65536
      _ExtentX        =   6562
      _ExtentY        =   1720
      _StockProps     =   14
      Caption         =   "*Tipo Cheque Remesa"
      ForeColor       =   255
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSOption optTipoR 
         Height          =   195
         Index           =   3
         Left            =   2100
         TabIndex        =   5
         Top             =   615
         WhatsThisHelpID =   5423
         Width           =   1410
         _Version        =   65536
         _ExtentX        =   2487
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Devueltos"
         ForeColor       =   8388608
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
      Begin Threed.SSOption optTipoR 
         Height          =   195
         Index           =   2
         Left            =   2085
         TabIndex        =   4
         Top             =   345
         WhatsThisHelpID =   5407
         Width           =   1320
         _Version        =   65536
         _ExtentX        =   2328
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Confirmados"
         ForeColor       =   8388608
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
      Begin Threed.SSOption optTipoR 
         Height          =   195
         Index           =   1
         Left            =   375
         TabIndex        =   3
         Top             =   645
         WhatsThisHelpID =   5433
         Width           =   1410
         _Version        =   65536
         _ExtentX        =   2487
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Pendientes"
         ForeColor       =   8388608
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
      Begin Threed.SSOption optTipoR 
         Height          =   195
         Index           =   0
         Left            =   360
         TabIndex        =   2
         Top             =   330
         WhatsThisHelpID =   5436
         Width           =   1320
         _Version        =   65536
         _ExtentX        =   2328
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Todos"
         ForeColor       =   8388608
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
   Begin VB.ComboBox cmbTipo 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   1960
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   60
      Width           =   2430
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   6
      Top             =   2265
      WhatsThisHelpID =   2020
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Siguien&te"
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
      Picture         =   "FTRAN408.frx":030A
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3645
      Left            =   30
      TabIndex        =   10
      Top             =   1665
      Width           =   8310
      _Version        =   65536
      _ExtentX        =   14658
      _ExtentY        =   6429
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
      Index           =   2
      Left            =   8415
      TabIndex        =   9
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
      Picture         =   "FTRAN408.frx":0326
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   8
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
      Picture         =   "FTRAN408.frx":0342
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8415
      TabIndex        =   7
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
      Picture         =   "FTRAN408.frx":035E
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   300
      Left            =   1960
      TabIndex        =   1
      Top             =   375
      Width           =   2430
      _ExtentX        =   4286
      _ExtentY        =   529
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Valor total:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   30
      TabIndex        =   18
      Top             =   735
      WhatsThisHelpID =   5438
      Width           =   1020
   End
   Begin VB.Label lblTotal 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   300
      Left            =   1960
      TabIndex        =   17
      Top             =   690
      Width           =   2430
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   30
      TabIndex        =   14
      Top             =   150
      WhatsThisHelpID =   5434
      Width           =   915
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cheques:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   15
      Top             =   1425
      WhatsThisHelpID =   5419
      Width           =   885
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   300
      Index           =   0
      Left            =   1960
      TabIndex        =   11
      Top             =   1020
      Width           =   6300
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
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -30
      X2              =   8385
      Y1              =   1395
      Y2              =   1395
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   30
      TabIndex        =   13
      Top             =   435
      WhatsThisHelpID =   5405
      Width           =   1365
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
      Left            =   30
      TabIndex        =   12
      Top             =   1035
      WhatsThisHelpID =   5406
      Width           =   1920
   End
End
Attribute VB_Name = "FTran408"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLTipoR As String
Dim VLTotal As String

Private Sub cmbTipo_GotFocus()
     FPrincipal!pnlHelpLine.Caption = " Tipo de Producto"
End Sub

Private Sub cmbTipo_LostFocus()
  If cmbTipo.Text = "CUENTA CORRIENTE" Then
        mskCuenta.Mask = VGMascaraCtaCte
  Else
        mskCuenta.Mask = VGMascaraCtaAho
  End If
End Sub

Private Sub cmdBoton_Click(Index As Integer)
 Dim VTModo As Boolean
 Select Case Index
    Case 0  'Transmitir
        If mskCuenta.ClipText <> "" Then
            VTModo = False
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "408"
            If cmbTipo.Text = "CUENTA CORRIENTE" Then
                 PMPasoValores sqlconn&, "@i_prod", 0, SQLCHAR, "CTE"
            Else
                 PMPasoValores sqlconn&, "@i_prod", 0, SQLCHAR, "AHO"
            End If
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
             PMPasoValores sqlconn&, "@i_tiporem", 0, SQLCHAR, VLTipoR
             PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT2, "0"
             If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_chequexcta", True, "Ok... Consulta cheques de remesas por cuenta") Then
                 PMMapeaGrid sqlconn&, grdRegistros, VTModo
                 PMMapeaVariable sqlconn&, VLTotal
                 PMChequea sqlconn&
                If grdRegistros.Rows <= 2 Then
                   grdRegistros.Row = 1
                   grdRegistros.Col = 1
                   If grdRegistros.Text = "" Then
                        lblTotal.Caption = ""
                        Exit Sub
                   End If
                End If
                cmbTipo.Enabled = False
                mskCuenta.Enabled = False
                grdRegistros.ColAlignment(10) = 1
                If Val(grdRegistros.Tag) = 20 Then
                    cmbTipo.Enabled = False
                    mskCuenta.Enabled = False
                    cmdBoton(4).Enabled = True
                Else
                    cmdBoton(4).Enabled = False
                    If Val(grdRegistros.Tag) > 0 Then
                        lblTotal.Caption = VLTotal
                    End If
                End If
              Else
                 PLLimpiar
            End If
        Else
            If cmbTipo.Text = "CUENTA CORRIENTE" Then
                 MsgBox "El número de Cuenta Corriente es mandatorio", 0 + 16, "Mensaje de Error"
            Else
                 MsgBox "El número de Cuenta de Ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            End If
            mskCuenta.SetFocus
        End If
    Case 1  'Limpiar
       PLLimpiar
    Case 2 'Salir
        Unload FTran408
    Case 4   'Siguientes
        If mskCuenta.ClipText <> "" Then
            VTModo = True
            grdRegistros.Row = grdRegistros.Rows - 1
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "408"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
             PMPasoValores sqlconn&, "@i_tiporem", 0, SQLCHAR, VLTipoR
            grdRegistros.Col = 9
             PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT2, (grdRegistros.Text)
            grdRegistros.Col = 6 '12
             PMPasoValores sqlconn&, "@i_carta", 0, SQLINT4, (grdRegistros.Text)
             If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_chequexcta", True, "Ok... Consulta de cheques de remesas por cuenta") Then
                 PMMapeaGrid sqlconn&, grdRegistros, VTModo
                 PMChequea sqlconn&
                grdRegistros.ColAlignment(10) = 1
                If Val(grdRegistros.Tag) = 20 Then
                   cmdBoton(4).Enabled = True
                Else
                    cmdBoton(4).Enabled = False
                    mskCuenta.Enabled = True
                    cmbTipo.Enabled = True
                    VTModo = False
                    lblTotal.Caption = VLTotal
                End If
            Else
                cmdBoton(4).Enabled = False
            End If
        Else
            MsgBox "El número de Cuenta Corriente es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
        End If
    End Select
End Sub

Private Sub Form_Load()
    FTran408.Left = 15
    FTran408.Top = 15
    FTran408.Width = 9420
    FTran408.Height = 5820
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaCte
    cmbTipo.AddItem "CUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORRO", 1
    cmbTipo.ListIndex = 0
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
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

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de Cuenta"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
           If (mskCuenta.ClipText <> "9999999999") Then
              If FMChequeaCtaCte((mskCuenta.ClipText)) Then
                  PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                  PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                  PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
                  If FMTransmitirRPC(sqlconn&, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(0)
                     PMChequea sqlconn&
                   Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                    lblDescripcion(0).Caption = ""
                    mskCuenta.SetFocus
                    Exit Sub
                 End If
               Else
                MsgBox "El dígito verificador de la cuenta corriente está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                lblDescripcion(0).Caption = ""
                mskCuenta.SetFocus
                Exit Sub
              End If
             Else
                lblDescripcion(0).Caption = "CUENTA ESPECIAL PARA CHEQUES DE OTROS DEPARTAMENTOS"
           End If
         Else
            If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
                If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                   PMMapeaObjeto sqlconn&, lblDescripcion(0)
                   PMChequea sqlconn&
                 Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    lblDescripcion(0).Caption = ""
                    mskCuenta.SetFocus
                    Exit Sub
               End If
             Else
               MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
               mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
               lblDescripcion(0).Caption = ""
               mskCuenta.SetFocus
               Exit Sub
            End If
        End If
        FrameTipoR.Enabled = True
        optTipoR(0).SetFocus
        optTipoR_Click 0, True
        cmdBoton(0).SetFocus
    End If
End Sub

Private Sub optTipoR_Click(Index As Integer, Value As Integer)
  
   Select Case Index
      Case 0
         VLTipoR = "T"
         optTipoR(1).Value = False
         optTipoR(2).Value = False
         optTipoR(3).Value = False
      Case 1
         VLTipoR = "P"
         optTipoR(0).Value = False
         optTipoR(2).Value = False
         optTipoR(3).Value = False
      Case 2
         VLTipoR = "C"
         optTipoR(0).Value = False
         optTipoR(1).Value = False
         optTipoR(3).Value = False
      Case 3
         VLTipoR = "D"
         optTipoR(0).Value = False
         optTipoR(1).Value = False
         optTipoR(2).Value = False
   End Select
   PMLimpiaGrid grdRegistros
   lblTotal.Caption = ""
   cmdBoton(4).Enabled = False
End Sub

Private Sub PLLimpiar()

        PMLimpiaGrid grdRegistros
        cmbTipo.Enabled = True
        mskCuenta.Enabled = True
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
        lblDescripcion(0).Caption = ""
        lblTotal.Caption = ""
        FrameTipoR.Enabled = False
        mskCuenta.Enabled = True
        mskCuenta.SetFocus
        cmdBoton(4).Enabled = False
   
End Sub


