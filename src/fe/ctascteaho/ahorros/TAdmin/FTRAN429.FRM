VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.ocx"
Begin VB.Form FTran429 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Consulta de Cheques de Remesas por Oficina"
   ClientHeight    =   5325
   ClientLeft      =   210
   ClientTop       =   1800
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
   HelpContextID   =   1041
   Icon            =   "FTRAN429.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Tag             =   "3886"
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8415
      TabIndex        =   20
      Tag             =   "6335"
      Top             =   1500
      WhatsThisHelpID =   2009
      Width           =   875
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
      Enabled         =   0   'False
      Picture         =   "FTRAN429.frx":030A
   End
   Begin VB.TextBox txtOficina 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   1350
      MaxLength       =   4
      TabIndex        =   0
      Top             =   30
      Width           =   765
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   1
      Left            =   1350
      TabIndex        =   2
      Top             =   630
      Width           =   2430
      _ExtentX        =   4286
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   288
      Index           =   0
      Left            =   1356
      TabIndex        =   1
      Top             =   336
      Width           =   2424
      _ExtentX        =   4286
      _ExtentY        =   529
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSFrame FrameTipoR 
      Height          =   885
      Left            =   3795
      TabIndex        =   12
      Top             =   330
      WhatsThisHelpID =   5435
      Width           =   4560
      _Version        =   65536
      _ExtentX        =   8044
      _ExtentY        =   1561
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
         Left            =   2400
         TabIndex        =   6
         TabStop         =   0   'False
         Top             =   570
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
         Left            =   2400
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   330
         WhatsThisHelpID =   5413
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
         Left            =   675
         TabIndex        =   4
         TabStop         =   0   'False
         Top             =   570
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
         Left            =   675
         TabIndex        =   3
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
         Value           =   -1  'True
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   8
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
      Picture         =   "FTRAN429.frx":0326
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3660
      Left            =   15
      TabIndex        =   11
      Top             =   1650
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   6456
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
      TabIndex        =   10
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
      Picture         =   "FTRAN429.frx":0342
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   9
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
      Picture         =   "FTRAN429.frx":035E
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8415
      TabIndex        =   7
      Top             =   3030
      WhatsThisHelpID =   2007
      Width           =   870
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
      Picture         =   "FTRAN429.frx":037A
   End
   Begin Crystal.CrystalReport rptReporte 
      Left            =   8655
      Top             =   270
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      PrintFileLinesPerPage=   60
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Oficina:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   14
      Top             =   90
      WhatsThisHelpID =   5432
      Width           =   750
   End
   Begin VB.Label lblTotal 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2130
      TabIndex        =   19
      Top             =   30
      Width           =   6225
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha hasta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   18
      Top             =   690
      WhatsThisHelpID =   5412
      Width           =   1200
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha desde:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   60
      TabIndex        =   17
      Top             =   390
      WhatsThisHelpID =   5411
      Width           =   1245
   End
   Begin VB.Label lblTotal 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   1350
      TabIndex        =   16
      Top             =   930
      Width           =   2430
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
      Left            =   60
      TabIndex        =   15
      Top             =   990
      WhatsThisHelpID =   5438
      Width           =   1020
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
      Left            =   90
      TabIndex        =   13
      Top             =   1410
      WhatsThisHelpID =   5419
      Width           =   885
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
      X1              =   0
      X2              =   8385
      Y1              =   1350
      Y2              =   1350
   End
End
Attribute VB_Name = "FTran429"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLTipoR As String
Dim VLTotal As String
Dim VLPaso As Boolean
Dim VLFormatoFecha As String


Private Sub cmdBoton_Click(Index As Integer)
    Dim VTDias As Integer
    Dim VTModo As Boolean
    Dim VTFDesde As String
    Dim VTFHasta As String
    Select Case Index

    Case 0  'Transmitir

        ' Fecha de inicio de la consulta
        If Trim$(mskValor(0).ClipText) = "" Then
            MsgBox "La fecha de inicio es mandatorio", 0 + 16, "Mensaje de Error"
            mskValor(0).SetFocus
            Exit Sub
        End If

        ' Fecha de fin de la consulta
        If Trim$(mskValor(1).ClipText) = "" Then
            MsgBox "La fecha de fin es mandatorio", 0 + 16, "Mensaje de Error"
            mskValor(1).SetFocus
            Exit Sub
        End If

        'Fecha de fin no mayor a la actual
        If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
           VTDias = FMDateDiff("d", Format$(VGFecha, VLFormatoFecha), (mskValor(1).FormattedText), VLFormatoFecha)
           If VTDias > 0 Then
              MsgBox "Fecha hasta mayor a la fecha actual", 48, "Mensaje de Error"
              mskValor(1).Mask = ""
              mskValor(1).Text = ""
              mskValor(1).Mask = FMMascaraFecha(VLFormatoFecha)
              mskValor(1).SetFocus
              Exit Sub
           End If
        End If
         
        'Fecha desde mayor a fecha hasta
        If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
            VTDias = FMDateDiff("d", (mskValor(0).FormattedText), (mskValor(1).FormattedText), VLFormatoFecha)
            If VTDias < 0 Then
              MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
              mskValor(0).Mask = ""
              mskValor(0).Text = ""
              mskValor(0).Mask = FMMascaraFecha(VLFormatoFecha)
              mskValor(0).SetFocus
              Exit Sub
            End If
        End If
        
       VTModo = False
       If optTipoR(0) = True Then
          optTipoR_Click 0, True
         ElseIf optTipoR(1) = True Then
            optTipoR_Click 1, True
           ElseIf optTipoR(2) = True Then
              optTipoR_Click 2, True
             ElseIf optTipoR(3) = True Then
                optTipoR_Click 3, True
               Else
                  MsgBox "Tipo de Cheque Remesa mandatorio", 0 + 16, "Mensaje de Error"
                  Exit Sub
       End If
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "429"
         PMPasoValores sqlconn&, "@i_tiporem", 0, SQLCHAR, VLTipoR
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, VGMoneda
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (txtOficina.Text)
        VTFDesde = FMConvFecha((mskValor(0).FormattedText), VLFormatoFecha, "mm/dd/yyyy")
         PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde
        VTFHasta = FMConvFecha((mskValor(1).FormattedText), VLFormatoFecha, "mm/dd/yyyy")
         PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta
         PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT2, "0"
         If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_chequexofi", True, "Ok... Consulta de cheques de remesas por oficina") Then
             PMMapeaGrid sqlconn&, grdRegistros, VTModo
             PMMapeaVariable sqlconn&, VLTotal
            lblTotal(0).Caption = VLTotal
             PMChequea sqlconn&
            If grdRegistros.Rows <= 2 Then
                grdRegistros.Row = 1
                grdRegistros.Col = 1
                If grdRegistros.Text = "" Then
                    Exit Sub
                End If
            End If
            cmdBoton(3).Enabled = True
            txtOficina.Enabled = False
            FrameTipoR.Enabled = True
            If Val(grdRegistros.Tag) >= 20 Then
                cmdBoton(4).Enabled = True
            Else
                cmdBoton(4).Enabled = False
                If Val(grdRegistros.Tag) > 0 Then
                    lblTotal(0).Caption = VLTotal
                End If
           End If
        Else
            PLLimpiar
        End If
    Case 1  'Limpiar
        PLLimpiar
    Case 2 'Salir
        Unload FTran429
    Case 3  'Imprimir
        PLImprimir
    Case 4   'Siguientes
        VTModo = True '
           grdRegistros.Col = 12
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "429"
         PMPasoValores sqlconn&, "@i_tiporem", 0, SQLCHAR, VLTipoR
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, VGMoneda
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (txtOficina.Text)
        VTFDesde = FMConvFecha((mskValor(0).FormattedText), VLFormatoFecha, "mm/dd/yyyy")
         PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde
        VTFHasta = FMConvFecha((mskValor(1).FormattedText), VLFormatoFecha, "mm/dd/yyyy")
         PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta
         PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, (grdRegistros.Text)

        grdRegistros.Col = 14
         PMPasoValores sqlconn&, "@i_carta", 0, SQLINT4, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_chequexofi", True, "Ok... Consulta de cheques de remesas por oficina") Then
            PMMapeaGrid sqlconn&, grdRegistros, VTModo
            PMChequea sqlconn&
           If Val(grdRegistros.Tag) >= 20 Then
              cmdBoton(4).Enabled = True
             Else
                cmdBoton(4).Enabled = False
                VTModo = False
           End If
         Else
            PLLimpiar
        End If
    End Select
End Sub

Private Sub Form_Load()
Dim i As Integer
    FTran429.Left = 15
    FTran429.Top = 15
    FTran429.Width = 9420
    FTran429.Height = 5820
    PMLoadResStrings Me
    PMLoadResIcons Me
    VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
    For i = 0 To 1
        mskValor(i).Mask = FMMascaraFecha(VLFormatoFecha)
        mskValor(i).Text = Format$(VGFecha, VLFormatoFecha)
    Next i
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

Private Sub mskValor_GotFocus(Index As Integer)
    Select Case Index
       Case 0
        FPrincipal!pnlHelpLine.Caption = " Fecha de inicial de la consulta [dd/mm/yyyy]"
       Case 1
        FPrincipal!pnlHelpLine.Caption = " Fecha final de la consulta [dd/mm/yyyy]"
    End Select
    mskValor(Index).SelStart = 0
    mskValor(Index).SelLength = Len(mskValor(Index).Text)
End Sub

Private Sub mskValor_KeyPress(Index As Integer, KeyAscii As Integer)

    KeyAscii = FMVAlidaTipoDato("N", KeyAscii)

End Sub

Private Sub mskValor_LostFocus(Index As Integer)
'*********************************************************
'Objetivo:  Verifica la validez de la fecha ingresada
'           de acuerdo con el formato de la fecha
'           ingresada
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
Dim VTValido As Boolean
Dim VTDias As Integer
Dim i As Integer
  Select Case Index
    Case 0, 1
        If mskValor(Index).ClipText <> "" Then
            VTValido = FMVerFormato((mskValor(Index).FormattedText), VLFormatoFecha)
            If Not VTValido Then
                MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
                mskValor(Index).Mask = ""
                mskValor(Index).Text = ""
                mskValor(Index).Mask = FMMascaraFecha(VLFormatoFecha)
                mskValor(Index).SetFocus
                Exit Sub
            End If
        End If
        If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
            VTDias = FMDateDiff("d", (mskValor(0).FormattedText), (mskValor(1).FormattedText), VLFormatoFecha)
            If VTDias < 0 Then
                MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
                For i = 0 To 1
                    mskValor(i).Mask = FMMascaraFecha(VLFormatoFecha)
                    mskValor(i).Text = Format$(VGFecha, VLFormatoFecha)
                Next i
                mskValor(0).SetFocus
                Exit Sub
           End If
        End If
  End Select

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

End Sub

Private Sub PLImprimir()
    
    On Error GoTo ErrorImp
    Const IDYES = 6
    Dim i As Integer
    Dim VTR As Integer
    Dim archivos As String
    Dim reportes As String
    Dim VTTipo As String
    Dim VTMsg As String
    If grdRegistros.Tag > 1 Then
        PMOrdenarGrid grdRegistros, 2
    End If

    If grdRegistros.Rows > 1 Then

       Dim BaseDatos As Database
       Dim tablas1 As Recordset
       Dim tablas2 As Recordset
       Screen.MousePointer = 11
       archivos = VGPath & "\REMESAS.MDB"
       Set BaseDatos = DBEngine.OpenDatabase(archivos)
       Set tablas1 = BaseDatos.OpenRecordset("re_encabezado")
       Set tablas2 = BaseDatos.OpenRecordset("re_detalle")
       BaseDatos.Execute "delete from re_detalle"
       BaseDatos.Execute "delete from re_encabezado"
       tablas1.AddNew
       tablas1("en_oficina") = CInt(VGOficina)
       tablas1("en_desc_oficina") = txtOficina.Text + "  " + lblTotal(1).Caption

        If optTipoR(0).Value Then
            VTTipo = optTipoR(0).Caption 'Todos
        ElseIf optTipoR(1).Value Then
            VTTipo = optTipoR(1).Caption 'Pendientes
        ElseIf optTipoR(2).Value Then
            VTTipo = optTipoR(2).Caption 'Confirmados
        Else
            VTTipo = optTipoR(3).Caption 'Devueltos
        End If
       
       tablas1("en_tipo_remesa") = UCase$(VTTipo)
       tablas1.Update
       tablas1.Close

        For i = 1 To (grdRegistros.Rows - 1)
            grdRegistros.Row = i
            tablas2.AddNew

            tablas2("de_oficina") = CInt(VGOficina)

            grdRegistros.Col = 1 'Fecha
            tablas2("de_fecha") = grdRegistros.Text
            
            grdRegistros.Col = 2  'Banco Girador
            tablas2("de_num_bco_girado") = grdRegistros.Text
            
            grdRegistros.Col = 4  'Carta
            tablas2("de_num_carta") = grdRegistros.Text
            
            grdRegistros.Col = 6 'Cta Deposito
            tablas2("de_cta_deposito") = grdRegistros.Text
            
            grdRegistros.Col = 7 'Cheque
            tablas2("de_cheque") = grdRegistros.Text
            
            grdRegistros.Col = 11 'valor
            tablas2("de_valor") = grdRegistros.Text
                    
            tablas2.Update
        Next i
        tablas2.Close

        VTMsg = "Asegúrese de que la Impresora se encuentre lista. Desea continuar con la impresión?."
        VTR = MsgBox(VTMsg, 36, "Control de impresión de Datos.")

        If VTR = IDYES Then
                reportes = VGPath & "\cons_rem_ofi.rpt"
                rptReporte.ReportFileName = reportes
                rptReporte.CopiesToPrinter = 1
                rptReporte.DataFiles(0) = archivos
                rptReporte.Destination = 1
                rptReporte.Action = 1
        End If
        Screen.MousePointer = 0
        BaseDatos.Close
    Else
           MsgBox "No existen datos para mostrar", vbInformation, "Control de Información"
           Screen.MousePointer = 0
    End If

 Exit Sub

ErrorImp:
    MsgBox "Error en la Impresión del Reporte " + Err.Description, 0 + 16, "Mensaje de Error"
    Screen.MousePointer = 0
    Exit Sub

End Sub

Private Sub PLLimpiar()
Dim i As Integer
    PMLimpiaGrid grdRegistros
    lblTotal(0).Caption = ""
    lblTotal(1).Caption = ""
    txtOficina.Enabled = True
    txtOficina.Text = ""
    mskValor(0).Mask = ""
    mskValor(0).Text = ""
    mskValor(0).Mask = FMMascaraFecha(VLFormatoFecha)
    mskValor(1).Mask = ""
    mskValor(1).Text = ""
    mskValor(1).Mask = FMMascaraFecha(VLFormatoFecha)
    txtOficina.SetFocus
    If cmdBoton(4).Enabled = True Then
        cmdBoton(4).Enabled = False
    End If
    cmdBoton(3).Enabled = False
    VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
    For i = 0 To 1
        mskValor(i).Mask = FMMascaraFecha(VLFormatoFecha)
        mskValor(i).Text = Format$(VGFecha, VLFormatoFecha)
    Next i
End Sub

Private Sub txtOficina_Change()
   VLPaso = False
End Sub

Private Sub txtoficina_GotFocus()

   VLPaso = True
   FPrincipal!pnlHelpLine.Caption = "Código de la Oficina que emitió las carta [F5 Ayuda]"
   txtOficina.SelStart = 0
   txtOficina.SelLength = Len(txtOficina.Text)

End Sub

Private Sub txtOficina_KeyDown(Keycode As Integer, Shift As Integer)

    If Keycode = VGTeclaAyuda Then
        VGOperacion = "sp_oficina"
        VLPaso = True
        txtOficina.Text = ""
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtOficina.Text & "]") Then
            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
            PMChequea sqlconn&
           FCatalogo.Show 1
           txtOficina.Text = VGACatalogo.Codigo
           lblTotal(1).Caption = VGACatalogo.Descripcion
           If txtOficina.Text <> "" Then
              VLPaso = True
              mskValor(0).SetFocus
           End If
        End If
    End If

End Sub

Private Sub txtOficina_KeyPress(KeyAscii As Integer)

   KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
   
End Sub

Private Sub txtOficina_LostFocus()

   If VLPaso = False And txtOficina.Text <> "" Then
      If txtOficina.Text <> "" Then
          PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
          PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
          PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtOficina.Text)
          If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtOficina.Text & "]") Then
             PMMapeaObjeto sqlconn&, lblTotal(1)
             PMChequea sqlconn&
           Else
              txtOficina.Text = ""
              lblTotal(1).Caption = ""
              txtOficina.SetFocus
           End If
         Else
            lblTotal(1).Caption = ""
      End If
   End If
      
End Sub


Private Sub txtoficina_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Clipboard.Clear
    Clipboard.SetText ""
End Sub

