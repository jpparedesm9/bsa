VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran410 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Consulta de Cartas por Corresponsal"
   ClientHeight    =   5340
   ClientLeft      =   720
   ClientTop       =   1935
   ClientWidth     =   9270
   ControlBox      =   0   'False
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
   HelpContextID   =   1029
   Icon            =   "FTRAN410.frx":0000
   LinkMode        =   1  'Source
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5340
   ScaleWidth      =   9270
   Tag             =   "3884"
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8415
      TabIndex        =   2
      Top             =   2265
      WhatsThisHelpID =   2020
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Si&guientes"
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
      Picture         =   "FTRAN410.frx":030A
   End
   Begin MSMask.MaskEdBox mskCampo 
      Height          =   285
      Left            =   2310
      TabIndex        =   0
      Top             =   75
      Width           =   1770
      _ExtentX        =   3122
      _ExtentY        =   503
      _Version        =   393216
      MaxLength       =   12
      Mask            =   "####-####-####"
      PromptChar      =   "_"
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   4245
      Left            =   0
      TabIndex        =   5
      Top             =   1065
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   7488
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
      Left            =   8415
      TabIndex        =   1
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
      Picture         =   "FTRAN410.frx":0326
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
      Picture         =   "FTRAN410.frx":0342
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
      Picture         =   "FTRAN410.frx":035E
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   1
      Left            =   5370
      TabIndex        =   9
      Top             =   420
      Width           =   2430
      _ExtentX        =   4286
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   0
      Left            =   1335
      TabIndex        =   10
      Top             =   390
      Width           =   2430
      _ExtentX        =   4286
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
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
      Left            =   75
      TabIndex        =   12
      Top             =   450
      WhatsThisHelpID =   5411
      Width           =   1245
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha hasta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   4110
      TabIndex        =   11
      Top             =   480
      WhatsThisHelpID =   5412
      Width           =   1200
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   4095
      TabIndex        =   8
      Top             =   75
      Width           =   4245
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cartas para el corresponsal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   7
      Top             =   825
      WhatsThisHelpID =   5409
      Width           =   2475
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8370
      Y1              =   735
      Y2              =   720
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Código del corresponsal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   75
      TabIndex        =   6
      Top             =   75
      WhatsThisHelpID =   5408
      Width           =   2190
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
End
Attribute VB_Name = "FTran410"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLPaso As Boolean
Dim VLFormatoFecha As String

Private Sub cmdBoton_Click(Index As Integer)
Dim VTFDesde As String
Dim VTFHasta As String
Dim VTUltimo As String
Dim i As Integer
Dim VTDias As Integer
VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
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
       
        ' Validacion de Mandatoriedades
        If mskCampo.ClipText = "" Then
            MsgBox "El código del corresponsal es mandatorio", 0 + 16, "Mensaje de Error"
            mskCampo.SetFocus
            Exit Sub
        End If

        ' Longitud del codigo de corresponsal
        If Len(mskCampo.ClipText) <> 12 Then
            MsgBox "Código de Corresponsal incorrecto [ 12 dígitos ]", 0 + 16, "Mensaje de Error"
            mskCampo.SetFocus
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "410"
         PMPasoValores sqlconn&, "@i_corres", 0, SQLVARCHAR, mskCampo.ClipText
         PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, "0"
         VTFDesde = FMConvFecha((mskValor(0).FormattedText), VLFormatoFecha, "mm/dd/yyyy")
         PMPasoValores sqlconn&, "@i_fecini", 0, SQLDATETIME, VTFDesde
         VTFHasta = FMConvFecha((mskValor(1).FormattedText), VLFormatoFecha, "mm/dd/yyyy")
         PMPasoValores sqlconn&, "@i_fecfin", 0, SQLDATETIME, VTFHasta
         If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_cltaxcorr", True, "Ok... Consulta de cartas por corresponsal") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
            If grdRegistros.Tag <> 0 Then
               cmdBoton(0).Enabled = True
               mskCampo.Enabled = False
            End If
            If (grdRegistros.Rows - 1) >= 20 Then
                cmdBoton(3).Enabled = True
            Else
                cmdBoton(3).Enabled = False
            End If
            grdRegistros.ColAlignment(2) = 2
        End If
     Case 1  'Limpiar
        mskCampo.Enabled = True
        mskCampo.Text = "____-____-____"
        lblDescripcion.Caption = ""
        PMLimpiaGrid grdRegistros
        mskCampo.SetFocus
        cmdBoton(3).Enabled = False
        cmdBoton(0).Enabled = False
        
        mskValor(0).Mask = ""
        mskValor(0).Text = ""
        mskValor(0).Mask = FMMascaraFecha(VLFormatoFecha)
        mskValor(1).Mask = ""
        mskValor(1).Text = ""
        mskValor(1).Mask = FMMascaraFecha(VLFormatoFecha)
    
        VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
        For i = 0 To 1
           mskValor(i).Mask = FMMascaraFecha(VLFormatoFecha)
           mskValor(i).Text = Format$(VGFecha, VLFormatoFecha)
        Next i
        
    Case 2  'Salir
        Unload FTran410
    Case 3  'Siguientes
        If mskCampo.ClipText <> "" Then
            If Len(mskCampo.ClipText) = 12 Then
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                VTUltimo = Trim$(grdRegistros.Text)
                VTUltimo = Mid$(VTUltimo, 6, (Len(VTUltimo) - 5))
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "410"
                 PMPasoValores sqlconn&, "@i_corres", 0, SQLVARCHAR, (mskCampo.ClipText)
                 PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, VTUltimo
                 VTFDesde = FMConvFecha((mskValor(0).FormattedText), VLFormatoFecha, "mm/dd/yyyy")
                 PMPasoValores sqlconn&, "@i_fecini", 0, SQLDATETIME, VTFDesde
                 VTFHasta = FMConvFecha((mskValor(1).FormattedText), VLFormatoFecha, "mm/dd/yyyy")
                 PMPasoValores sqlconn&, "@i_fecfin", 0, SQLDATETIME, VTFHasta
                 If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_cltaxcorr", True, "Ok... Consulta de cartas por corresponsal") Then
                     PMMapeaGrid sqlconn&, grdRegistros, True
                     PMChequea sqlconn&
                    If (grdRegistros.Rows - 1) >= 20 Then
                        cmdBoton(3).Enabled = True
                    Else
                        cmdBoton(3).Enabled = False
                    End If
                End If
            Else
                MsgBox "Código de Corresponsal incorrecto [ 12 dígitos ]", 0 + 16, "Mensaje de Error"
                mskCampo.SetFocus
            End If
        Else
            MsgBox "El código del corresponsal es mandatorio", 0 + 16, "Mensaje de Error"
            mskCampo.SetFocus
        End If
    End Select
End Sub

Private Sub Form_Activate()
    VGHelpRem = "C"
End Sub

Private Sub Form_Load()
Dim i As Integer
    FTran410.Left = 15
    FTran410.Top = 15
    FTran410.Width = 9420
    FTran410.Height = 5820
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

Private Sub grdregistros_DblClick()
    If grdRegistros.Text <> "" Then
        ReDim VGADatosI(3) As String
        grdRegistros.Col = 1
        VGADatosI(1) = (Mid$(Trim$(grdRegistros.Text), 6, Len(grdRegistros.Text) - 5))
        grdRegistros.Col = 2
        VGADatosI(2) = grdRegistros.Text
        grdRegistros.Col = 4
        VGADatosI(3) = grdRegistros.Text
        FTran432.Show 1
   End If
End Sub

Private Sub grdRegistros_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Doble click para consultar los cheques de la carta"
End Sub

Private Sub mskCampo_Change()

   VLPaso = False

End Sub

Private Sub mskCampo_GotFocus()
    
    VLPaso = True
    FPrincipal!pnlHelpLine.Caption = " Código del corresponsal [F5 Ayuda] "
    mskCampo.SelStart = 0
    mskCampo.SelLength = Len(mskCampo.Text)

End Sub

Private Sub mskCampo_KeyDown(Keycode As Integer, Shift As Integer)
    If Keycode = VGTeclaAyuda Then
       VGOperacion = "sp_rem_ayuda"
       VLPaso = True
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "447"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, VGHelpRem
        PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina
        If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_ayuda", True, " Ok... Consulta de Número de Carta Remesa") Then
           Load FRegistros
           PMMapeaGrid sqlconn&, FRegistros!grdRegistros, False
           PMChequea sqlconn&
          FRegistros.Show 1
          If Val(FRegistros!grdRegistros.Tag) = VGMaxRows Then
             FRegistros!cmdSiguientes.Enabled = True
            Else
               FRegistros!cmdSiguientes.Enabled = False
          End If
          If VGACatalogo.Codigo <> "" Then
             mskCampo.Text = VGACatalogo.Codigo
             lblDescripcion.Caption = VGACatalogo.Descripcion
             VLPaso = True
             cmdBoton(0).Enabled = True
             mskValor(0).SetFocus
            Else
               Exit Sub
          End If
       End If
    End If
End Sub

Private Sub mskCampo_KeyPress(KeyAscii As Integer)

   If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
       KeyAscii = 0
   End If
   
End Sub

Private Sub mskCampo_LostFocus()

   If VLPaso = False Then
      If Len(mskCampo.ClipText) = 12 And mskCampo.ClipText <> "" Then
         VGOperacion = "sp_rem_ayuda"
          PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "447"
          PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, VGHelpRem
          PMPasoValores sqlconn&, "@i_tipoc", 0, SQLCHAR, "I"
          PMPasoValores sqlconn&, "@i_banco_c", 0, SQLVARCHAR, (mskCampo.ClipText)
          PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina
          If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_ayuda", True, " Ok... Consulta de Número de Carta Remesa") Then
             PMMapeaObjeto sqlconn&, lblDescripcion
             PMChequea sqlconn&
            cmdBoton(0).Enabled = True
           
         Else
              VLPaso = True
              mskCampo.Text = "____-____-____"
              lblDescripcion.Caption = ""
              cmdBoton(0).Enabled = False
              cmdBoton(3).Enabled = False
              mskCampo.SetFocus
         End If
        Else
         MsgBox "Código de Corresponsal incorrecto [ 12 dígitos ]", 0 + 16, "Mensaje de Error"
         mskCampo.Text = "____-____-____"
         lblDescripcion.Caption = ""
         mskCampo.SetFocus
         Exit Sub
      End If
   End If
      

End Sub

Private Sub mskValor_KeyPress(Index As Integer, KeyAscii As Integer)
    KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
End Sub

Private Sub mskValor_LostFocus(Index As Integer)
Dim i As Integer
Dim VTDias As Integer
Dim VTValido As Boolean
VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
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

