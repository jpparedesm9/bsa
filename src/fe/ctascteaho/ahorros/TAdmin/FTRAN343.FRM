VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{F856EC8B-F03C-4515-BDC6-64CBD617566A}#6.0#0"; "fpSpr60.ocx"
Begin VB.Form FTran343 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Consulta detalle de intereses"
   ClientHeight    =   5325
   ClientLeft      =   1200
   ClientTop       =   2325
   ClientWidth     =   9720
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
   HelpContextID   =   1044
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9720
   Tag             =   "3867"
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   3
      Left            =   8808
      TabIndex        =   4
      Top             =   3036
      WhatsThisHelpID =   2020
      Width           =   876
      _Version        =   65536
      _ExtentX        =   1535
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
   Begin MSMask.MaskEdBox mskValor 
      Height          =   288
      Index           =   1
      Left            =   7356
      TabIndex        =   2
      Top             =   612
      Width           =   1344
      _ExtentX        =   2381
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   288
      Index           =   0
      Left            =   1944
      TabIndex        =   1
      Top             =   612
      Width           =   1344
      _ExtentX        =   2355
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   288
      Left            =   1944
      TabIndex        =   0
      Top             =   12
      Width           =   2208
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   1
      Left            =   8808
      TabIndex        =   6
      Top             =   3792
      WhatsThisHelpID =   2003
      Width           =   876
      _Version        =   65536
      _ExtentX        =   1535
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
      Height          =   756
      Index           =   2
      Left            =   8808
      TabIndex        =   7
      Top             =   4560
      WhatsThisHelpID =   2008
      Width           =   876
      _Version        =   65536
      _ExtentX        =   1535
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
      Height          =   756
      Index           =   0
      Left            =   8808
      TabIndex        =   3
      Top             =   2268
      WhatsThisHelpID =   2007
      Width           =   876
      _Version        =   65536
      _ExtentX        =   1535
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   4
      Left            =   8808
      TabIndex        =   5
      Top             =   1512
      WhatsThisHelpID =   2009
      Width           =   876
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
   End
   Begin FPSpreadADO.fpSpread grdEstado 
      Height          =   3732
      Left            =   48
      TabIndex        =   16
      Top             =   1200
      Width           =   8652
      _Version        =   393216
      _ExtentX        =   15261
      _ExtentY        =   6583
      _StockProps     =   64
      BackColorStyle  =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MaxCols         =   5
      MaxRows         =   1
      OperationMode   =   1
      RetainSelBlock  =   0   'False
      SpreadDesigner  =   "FTRAN343.frx":0000
      VisibleCols     =   5
      VisibleRows     =   1
   End
   Begin VB.Label lblEtiqueta 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H000000FF&
      Height          =   288
      Index           =   4
      Left            =   7128
      TabIndex        =   15
      Top             =   5004
      Width           =   1572
   End
   Begin VB.Label lblEtiqueta 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "*Total Intereses:"
      ForeColor       =   &H00800000&
      Height          =   192
      Index           =   2
      Left            =   5676
      TabIndex        =   14
      Top             =   5028
      WhatsThisHelpID =   5339
      Width           =   1392
   End
   Begin VB.Label lblEtiqueta 
      BackStyle       =   0  'Transparent
      Caption         =   "*Transacciones:"
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   1
      Left            =   60
      TabIndex        =   13
      Top             =   1000
      WhatsThisHelpID =   5336
      Width           =   1335
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
      Left            =   60
      TabIndex        =   12
      Top             =   315
      WhatsThisHelpID =   5265
      Width           =   1920
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
      TabIndex        =   11
      Top             =   660
      WhatsThisHelpID =   5172
      Width           =   1245
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
      Left            =   60
      TabIndex        =   10
      Top             =   15
      WhatsThisHelpID =   5016
      Width           =   1365
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8748
      Y1              =   950
      Y2              =   950
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8770
      X2              =   8770
      Y1              =   0
      Y2              =   5310
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   288
      Index           =   0
      Left            =   1944
      TabIndex        =   9
      Top             =   312
      UseMnemonic     =   0   'False
      Width           =   6744
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha hasta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   5745
      TabIndex        =   8
      Top             =   660
      WhatsThisHelpID =   5173
      Width           =   1200
   End
End
Attribute VB_Name = "FTran343"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTran343.frm
' NOMBRE LOGICO:    FTran343
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
' Permite realizar la consulta de movimientos de la cuenta de
' ahorros.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Option Explicit
Dim VLIntTotal As Currency
Dim VLPosGrid As Long
Dim VLNumRegs As String

Private Sub Form_Load()
Dim i As Integer
    FTran343.Left = 0
    FTran343.Top = 0
    FTran343.Width = 9816
    FTran343.Height = 5808
    PMLoadResStrings Me
    PMLoadResIcons Me
    grdEstado.CursorStyle = CursorStyleArrow
    For i = 0 To 1
        MskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
        MskValor(i).Text = Format$(VGFecha, VGFormatoFecha)
    Next i
    mskCuenta.Mask = VGMascaraCtaAho
    cmdBoton(4).Enabled = False
    grdEstado.ColWidth(1) = 12
    grdEstado.ColWidth(2) = 13
    grdEstado.ColWidth(3) = 13
    grdEstado.ColWidth(4) = 12
    grdEstado.ColWidth(5) = 12
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Dim VTFDesde As String
    Dim VTFHasta As String
    Dim VTFecha As String
    Dim VTFecha1 As String
    Dim i As Integer
    Dim VTNumRegistros As Integer
    Dim vti As Integer
    Select Case Index
    Case 0     'transmitir
    If mskCuenta.ClipText <> "" Then
         PMBorrarGrid grdEstado
         grdEstado.MaxCols = 6
         grdEstado.Row = 0
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "343"
         PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, (mskCuenta.ClipText)
         VTFDesde = FMConvFecha((MskValor(0).FormattedText), VGFormatoFecha, CGFormatoBase)
         PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde
         VTFHasta = FMConvFecha((MskValor(1).FormattedText), VGFormatoFecha, CGFormatoBase)
         PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta
    
         VTNumRegistros = grdEstado.MaxRows
    
         If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros_his", "sp_consdetint_ah", True, "Ok... Consulta de detalle de intereses") Then
             PMMapeaGrid sqlconn&, grdEstado, False
             PMMapeaVariable sqlconn&, VLNumRegs
    
             'Activar el botón siguientes
             If grdEstado.Tag >= Val(VLNumRegs) Then
                 cmdBoton(3).Enabled = True
                 cmdBoton(3).SetFocus
             Else
                 cmdBoton(0).Enabled = False
                 cmdBoton(3).Enabled = False
                 cmdBoton(4).Enabled = True
                 ' Sumarizar los Intereses
                 VLIntTotal = 0
                 For i = 1 To grdEstado.MaxRows
                    grdEstado.Row = i
                    grdEstado.col = 6
                    VLIntTotal = VLIntTotal + CCur(grdEstado.Text)
                 Next i
                 lbletiqueta(4).Caption = VLIntTotal
             End If
             mskCuenta.Enabled = False
             MskValor(0).Enabled = False
             MskValor(1).Enabled = False
         Else
             grdEstado.Rows = 2
         End If
         PMChequea sqlconn&
         For vti = 1 To grdEstado.MaxRows
            grdEstado.RowHeight(vti) = 8.59
         Next vti
         grdEstado.Action = 0
         PMMarcaFilaGrid grdEstado, VLPosGrid
         PMBloqueaGrid grdEstado
    Else
       MsgBox "El número de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
       If mskCuenta.Visible And mskCuenta.Enabled Then mskCuenta.SetFocus
    End If

    Case 1
        ' Limpiar
        MskValor(0).Enabled = True
        MskValor(1).Enabled = True
        For i = 0 To 1
            MskValor(i).Text = Format$(VGFecha, VGFormatoFecha)
        Next i
        lbletiqueta(4).Caption = ""
        PMBorrarGrid grdEstado
        cmdBoton(0).Enabled = True
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
    Case 2
        ' Salir
        Unload FTran343
    Case 3
        ' Siguiente
        If grdEstado.MaxRows > 0 Then
           grdEstado.col = 1
           grdEstado.Row = grdEstado.MaxRows
           VTFecha = grdEstado.Text
        End If
    
        VTFecha1 = DateAdd("d", 1, VTFecha)
                        
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "343"
        PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, (mskCuenta.ClipText)
        VTFDesde = FMConvFecha((VTFecha1), VGFormatoFecha, CGFormatoBase)
        PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde
        VTFHasta = FMConvFecha((MskValor(1).FormattedText), VGFormatoFecha, CGFormatoBase)
        PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta
    
        If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros_his", "sp_consdetint_ah", True, "Ok... Consulta de detalle de intereses") Then
            PMMapeaGrid sqlconn&, grdEstado, True
            PMMapeaVariable sqlconn&, VLNumRegs
            '---------------------------------------
            'Activar el botón siguientes
            '---------------------------------------
            If grdEstado.Tag >= Val(VLNumRegs) Then
               cmdBoton(3).Enabled = True
               cmdBoton(3).SetFocus
            Else
               cmdBoton(0).Enabled = False
               cmdBoton(3).Enabled = False
               cmdBoton(4).Enabled = True
               ' Sumarizar los Intereses
                 VLIntTotal = 0
                 For i = 1 To grdEstado.MaxRows
                    grdEstado.Row = i
                    grdEstado.col = 5
                    VLIntTotal = VLIntTotal + CCur(grdEstado.Text)
                 Next i
                 lbletiqueta(4).Caption = VLIntTotal
            End If
        Else
            grdEstado.Rows = 2
        End If
        PMChequea sqlconn&
        grdEstado.Action = 0
        PMMarcaFilaGrid grdEstado, VLPosGrid
        PMBloqueaGrid grdEstado
        cmdBoton(4).SetFocus
    Case 4
        PLConfigurarImpresion
    End Select
End Sub

Private Sub grdEstado_LeaveCell(ByVal col As Long, ByVal Row As Long, ByVal NewCol As Long, ByVal NewRow As Long, Cancel As Boolean)
'*************************************************************
' PROPOSITO: Marcar la fila seleccionada y no permitir
'            que se desmarque la selección
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 13-May-99      L. Chango       Emision Inicial
'*************************************************************

    If NewRow > -1 Then
        PMMarcaFilaGrid grdEstado, NewRow
        VLPosGrid = NewRow
    End If
End Sub


Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la cuenta de ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
             PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"
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
End Sub

Private Sub mskValor_GotFocus(Index As Integer)
    Select Case Index
        Case 0
            FPrincipal!pnlHelpLine.Caption = " Fecha inicial de la consulta [" & VGFormatoFecha & "]"
        Case 1
            FPrincipal!pnlHelpLine.Caption = " Fecha final de la consulta [" & VGFormatoFecha & "]"
    End Select
    MskValor(Index).SelStart = 0
    MskValor(Index).SelLength = Len(MskValor(Index).Text)
End Sub

Private Sub mskValor_KeyPress(Index As Integer, KeyAscii As Integer)
    If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
        KeyAscii = 0
    End If
End Sub

Private Sub mskValor_LostFocus(Index As Integer)
'*********************************************************
'PORPOSITO: Verifica la validez de la fecha ingresada
'           de acuerdo con el formato de la fecha
'           ingresada
'INPUT    : Index    Identificador de campo
'OUTPUT   : ninguna
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    Dim VTValido As Boolean
    Dim i As Integer
    Dim VTDias As Integer
    On Error Resume Next
    
    ' Validacion de Mandatoriedad
    ' Numero de la Cuenta Ahorros
    If Trim$(mskCuenta.ClipText) = "" Then
        MsgBox "El número de Cuenta de Ahorros es mandatorio", 0 + 16, "Mensaje de Error"
        mskCuenta.SetFocus
        Exit Sub
    End If
                        
    If MskValor(Index).ClipText <> "" Then
       VTValido = FMVerFormato((MskValor(Index).FormattedText), VGFormatoFecha)
       If Not VTValido Then
          MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
          MskValor(Index).Text = Format$(VGFecha, VGFormatoFecha)
          MskValor(Index).SetFocus
          Exit Sub
        End If
    End If
    
    ' Valido Fecha Desde y Fecha Hasta
    Select Case Index
    Case 0
        If MskValor(Index).ClipText = "" Then
            For i = 0 To 1
                MskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
            Next i
        End If
    Case 1
        If MskValor(0).ClipText <> "" And MskValor(1).ClipText <> "" Then
            VTDias = FMDateDiff("d", (MskValor(0).FormattedText), (MskValor(1).FormattedText), VGFormatoFecha)
            If VTDias < 0 Then
                MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
                For i = 0 To 1
                    MskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                    MskValor(i).Text = Format$(VGFecha, VGFormatoFecha)
                Next i
                MskValor(Index).SetFocus
                Exit Sub
            End If
        End If
        cmdBoton(0).Enabled = True
        cmdBoton(3).Enabled = True
        cmdBoton(0).SetFocus
    End Select
              
End Sub
Sub PLConfigurarImpresion()
'**************************************************************
' PROPOSITO: Configura los datos requeridos para la impresión de
'            reportes.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'**************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-05      D. Villagomez   Emision Inicial
'**************************************************************

'FIXIT: Declare 'VTColumnas' with an early-bound data type                                 FixIT90210ae-R1672-R1B8ZE
    Dim VTColumnas() As Integer         'Contiene los índices de las columnas a imprimir
'FIXIT: Declare 'VTSepColumnas' with an early-bound data type                              FixIT90210ae-R1672-R1B8ZE
    Dim VTSepColumnas() As Integer      'Contiene las separaciones en caracteres de las columnas
'FIXIT: Declare 'VTCapSubtitulos' with an early-bound data type                            FixIT90210ae-R1672-R1B8ZE
    Dim VTCapSubtitulos() As Integer    'Contiene los números de recursos para los Nombres de los subtítulos
'FIXIT: Declare 'VTValSubtitulos' with an early-bound data type                            FixIT90210ae-R1672-R1B8ZE
    Dim VTValSubtitulos(7) As String    'Contiene los números de recursos para los Valores de los subtítulos
    Dim VTNumColumnas As Integer      'Contiene el número de filas a imprimir
'FIXIT: Declare 'VTAlineacion' with an early-bound data type                               FixIT90210ae-R1672-R1B8ZE
    Dim VTAlineacion() As Integer

    VTNumColumnas = 8 '5
    VTColumnas = Array(1, 2, 3, 4, 5, 6, 7, 8) ')
    VTSepColumnas = Array(10, 10, 15, 15, 15, 10, 10, 10)
    VTAlineacion = Array(CG_LEFT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN) ')
          
    VTCapSubtitulos = Array(5122, 5123, 5016, 5265, 5065, 5066, 5178, 5392)
       
    'VTValSubtitulos = Array("", "", "", "", "", "", "", "") 'Inicialización del arreglo
    VTValSubtitulos(0) = ""    'Tipo de ejecución
    VTValSubtitulos(1) = ""
    VTValSubtitulos(2) = ""
    VTValSubtitulos(3) = ""
    VTValSubtitulos(4) = ""
    VTValSubtitulos(5) = ""
    VTValSubtitulos(6) = ""
    VTValSubtitulos(7) = ""
    
    VTValSubtitulos(0) = LoadResString(5121)    'Tipo de ejecución
    VTValSubtitulos(1) = VGLogin
    VTValSubtitulos(2) = mskCuenta.Text
    VTValSubtitulos(3) = lblDescripcion(0).Caption
    VTValSubtitulos(4) = MskValor(0).Text
    VTValSubtitulos(5) = MskValor(1).Text
    VTValSubtitulos(6) = lbletiqueta(4).Caption
    VTValSubtitulos(7) = Format$(Date, VGFormatoFecha)
    'Llamada al procedimiento de Impresión de Reportes
    PMImprimirReporte grdEstado, VTNumColumnas, VTColumnas(), VTSepColumnas(), 3867, VTCapSubtitulos(), VTValSubtitulos, VTAlineacion(), CG_LANDSCAPE

End Sub



