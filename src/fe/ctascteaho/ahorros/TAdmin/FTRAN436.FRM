VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.ocx"
Begin VB.Form FTran436 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Seguimiento Plan de Ahorro Progresivo"
   ClientHeight    =   4845
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
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4845
   ScaleWidth      =   9300
   Tag             =   "3893"
   Begin VB.ComboBox cmbprodb 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   1365
      Style           =   2  'Dropdown List
      TabIndex        =   5
      Top             =   330
      Width           =   2370
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8400
      TabIndex        =   14
      Tag             =   "6335"
      Top             =   2550
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
   Begin VB.TextBox txtOficina 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   1365
      MaxLength       =   4
      TabIndex        =   2
      Top             =   45
      Width           =   765
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   1
      Left            =   1365
      TabIndex        =   9
      Top             =   960
      Width           =   2310
      _ExtentX        =   4075
      _ExtentY        =   503
      _Version        =   393216
      Enabled         =   0   'False
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   0
      Left            =   1365
      TabIndex        =   7
      Top             =   660
      Width           =   2310
      _ExtentX        =   4075
      _ExtentY        =   503
      _Version        =   393216
      Enabled         =   0   'False
      PromptChar      =   "_"
   End
   Begin Threed.SSFrame FrameTipoR 
      Height          =   885
      Left            =   3780
      TabIndex        =   0
      Top             =   360
      WhatsThisHelpID =   5460
      Width           =   4100
      _Version        =   65536
      _ExtentX        =   7232
      _ExtentY        =   1561
      _StockProps     =   14
      Caption         =   "*Tipo de Consulta"
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
      Begin Threed.SSOption optTipoR 
         Height          =   195
         Index           =   1
         Left            =   1680
         TabIndex        =   11
         TabStop         =   0   'False
         Top             =   360
         WhatsThisHelpID =   5459
         Width           =   2280
         _Version        =   65536
         _ExtentX        =   4022
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Con Incumplimientos"
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
         Left            =   240
         TabIndex        =   10
         Top             =   360
         WhatsThisHelpID =   5458
         Width           =   1320
         _Version        =   65536
         _ExtentX        =   2328
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Por Vencer"
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
      Index           =   3
      Left            =   8400
      TabIndex        =   16
      Top             =   4080
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
      Height          =   3135
      Left            =   0
      TabIndex        =   13
      TabStop         =   0   'False
      Top             =   1700
      Width           =   8100
      _Version        =   65536
      _ExtentX        =   14287
      _ExtentY        =   5530
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
      Left            =   8400
      TabIndex        =   12
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
      Left            =   8400
      TabIndex        =   15
      Top             =   3315
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
   Begin Crystal.CrystalReport rptReporte 
      Left            =   8640
      Top             =   960
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      PrintFileLinesPerPage=   60
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8280
      Y1              =   1320
      Y2              =   1320
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Consulta Registros :"
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   5
      Left            =   0
      TabIndex        =   17
      Top             =   1400
      Width           =   1725
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   30
      TabIndex        =   4
      Top             =   330
      WhatsThisHelpID =   5048
      Width           =   915
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
      Left            =   30
      TabIndex        =   1
      Top             =   45
      WhatsThisHelpID =   5432
      Width           =   750
   End
   Begin VB.Label lblOficina 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2160
      TabIndex        =   3
      Top             =   45
      Width           =   5745
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha hasta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   30
      TabIndex        =   8
      Top             =   960
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
      Index           =   3
      Left            =   30
      TabIndex        =   6
      Top             =   660
      WhatsThisHelpID =   5411
      Width           =   1245
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8280
      X2              =   8280
      Y1              =   0
      Y2              =   4920
   End
End
Attribute VB_Name = "FTran436"
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
Dim VLFlag As Boolean
'FIXIT: Declare 'VLProdbanc' with an early-bound data type                                 FixIT90210ae-R1672-R1B8ZE
Dim VLProdbanc As String
Dim VLNumdias As String
Dim VLreg As String

  
Private Sub cmdBoton_Click(Index As Integer)
 Select Case Index
  Case 0 ' Buscar
         PLBuscar
  Case 1 'Imprimir
         PLImprimir
  Case 2 ' Limpiar
         PLLimpiar
  Case 3 ' Salir
         Screen.MousePointer = 0
         Unload Me
End Select
End Sub

Private Sub PLBuscar()
Dim VTProdBanc As Integer
Dim VTFDesde As String
Dim VTFHasta As String
Dim VTDias As Integer
Dim i As Integer
Dim SecGrid As Integer
PMLimpiaGrid grdRegistros

If txtOficina = "" Then
   MsgBox "El campo Oficina es mandatorio", 0 + 16, "Mensaje de Error"
   txtOficina.SetFocus
   Exit Sub
End If
If optTipoR(0).Value = True Then
   VLTipoR = "P"
Else
   VLTipoR = "D"
End If

If cmbprodb.Text = "AHORROS" Then
    VTProdBanc = 4
Else
    VTProdBanc = 3
End If

If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
    VTDias = FMDateDiff("d", (mskValor(0).FormattedText), (mskValor(1).FormattedText), VGFormatoFecha)
    If VTDias < 0 Then
        MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
        For i = 0 To 1
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
            mskValor(i).Text = Format$(VGFecha, VGFormatoFecha)
        Next i
        'mskValor(Index%).SetFocus Pendiente Validar IYU
        mskValor(i).SetFocus
        Exit Sub
    Else
     If VTDias > VLNumdias Then
        MsgBox "El numero de dias de la consulta es mayor al numero de dias parametrizados :" & " [" & VLNumdias & "] " & "dias", 0 + 48, "Mensaje de Error"
        Exit Sub
     End If
    End If
End If
    
           
PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 395
PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, VLTipoR
PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (txtOficina.Text)
VTFDesde = FMConvFecha((mskValor(0).FormattedText), VGFormatoFecha, CGFormatoBase)
PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde
VTFHasta = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha, CGFormatoBase)
PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta
PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, VTProdBanc
PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT2, 0
If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_reporte_ahorro_plan", True, "Ok... Reporte Seguimiento Plan de Ahorros") Then
   PMMapeaGrid sqlconn&, grdRegistros, VLFlag
   If VLTipoR = "P" Then
        PMMapeaObjeto sqlconn&, mskValor(0)
        PMMapeaObjeto sqlconn&, mskValor(1)
        PMMapeaVariable sqlconn&, VLTotal
   Else
        PMMapeaVariable sqlconn&, VLTotal
   End If
   
   grdRegistros.ColWidth(1) = "1"
   grdRegistros.ColWidth(12) = "1"
   
   grdRegistros.Row = 1
   grdRegistros.Col = 12
   VLProdbanc = grdRegistros.Text
   PMChequea sqlconn&
   
   grdRegistros.Row = grdRegistros.Rows - 1
   grdRegistros.Col = 0
   VLreg = grdRegistros.Text
   
   grdRegistros.Row = grdRegistros.Rows - 1
   grdRegistros.Col = 1
   SecGrid = grdRegistros.Text
   
   Do While (VLTotal > VLreg)
       
      grdRegistros.Row = grdRegistros.Rows - 1
      grdRegistros.Col = 1
      SecGrid = grdRegistros.Text
   
      PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 395
      PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, VLTipoR
      PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (txtOficina.Text)
      VTFDesde = FMConvFecha((mskValor(0).FormattedText), VGFormatoFecha, CGFormatoBase)
      PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde
      VTFHasta = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha, CGFormatoBase)
      PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta
      PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, VTProdBanc
      PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT2, SecGrid
      
      If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_reporte_ahorro_plan", True, "Ok... Reporte Seguimiento Plan de Ahorros") Then
         PMMapeaGrid sqlconn&, grdRegistros, True
         PMChequea sqlconn&
      End If
      
      grdRegistros.Row = grdRegistros.Rows - 1
      grdRegistros.Col = 0
      VLreg = grdRegistros.Text
   Loop
End If
End Sub
Private Sub Form_Load()
Dim i As Integer
    FTran436.Left = 15
    FTran436.Top = 15
    FTran436.Width = 9420
    FTran436.Height = 5355
    cmbprodb.AddItem "AHORROS", 0
    cmbprodb.AddItem "CORRIENTES", 1
    cmbprodb.ListIndex = 0
    PMLoadResStrings Me
    PMLoadResIcons Me
    PLBuscar_parametro
    VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
    For i = 0 To 1
        mskValor(i).Mask = FMMascaraFecha(VLFormatoFecha)
        mskValor(i).Text = Format$(VGFecha, VLFormatoFecha)
    Next i
End Sub
Private Sub cmbprodb_GotFocus()
FPrincipal!pnlHelpLine.Caption = " Tipo de Producto"
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
    Dim VTDias As Integer
    Dim i As Integer
    If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
        VTDias = FMDateDiff("d", (mskValor(0).FormattedText), (mskValor(1).FormattedText), VGFormatoFecha)
        If VTDias < 0 Then
            MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
            For i = 0 To 1
                mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                mskValor(i).Text = Format$(VGFecha, VGFormatoFecha)
            Next i
            'mskValor(Index%).SetFocus prueba pendiente}
            mskValor(i).SetFocus
            Exit Sub
        Else
         If VTDias > VLNumdias Then
            MsgBox "El numero de dias de la consulta es mayor al numero de dias parametrizados :" & " [" & VLNumdias & "] " & "dias", 0 + 48, "Mensaje de Error"
            Exit Sub
         End If
        End If

    End If
End Sub

Private Sub optTipoR_Click(Index As Integer, Value As Integer)
   Select Case Index
      Case 0
         VLTipoR = "P" 'Pendientes por vencer
         optTipoR(1).Value = False
         mskValor(0).Enabled = False
         mskValor(1).Enabled = False
      Case 1
         VLTipoR = "D" 'Vencidas o Descubiertas
         optTipoR(0).Value = False
         mskValor(0).Enabled = True
         mskValor(1).Enabled = True
   End Select
End Sub
Private Sub PLImprimir()
    Dim archivos As String
    Dim reportes As String
    Dim VTMsg As String
    Dim VTR As Integer
    Dim i As Integer
    On Error GoTo ErrorImp
    Const IDYES As Integer = 6
    
    grdRegistros.Row = 1
    grdRegistros.Col = 1
    
    If grdRegistros.Text <> "" Then

       Dim BaseDatos As Database
       Dim tablas1 As Recordset
       Dim tablas2 As Recordset
       Screen.MousePointer = 11
       archivos = VGPath & "\REPORTE.MDB"
       Set BaseDatos = DBEngine.OpenDatabase(archivos)
       Set tablas1 = BaseDatos.OpenRecordset("Reporte_Master")
       Set tablas2 = BaseDatos.OpenRecordset("Reporte_Detalle")
       BaseDatos.Execute "delete from Reporte_Master"
       BaseDatos.Execute "delete from Reporte_Detalle"
       tablas1.AddNew
       tablas1("rm_fecha_desde") = mskValor(0).Text
       tablas1("rm_fecha_hasta") = mskValor(1).Text
       tablas1("rm_usuario") = VGLogin
       tablas1("rm_oficina") = txtOficina.Text
       tablas1("rm_desc_oficina") = "  " + lblOficina(1).Caption
       tablas1("rm_prod_banc") = VLProdbanc
      
       tablas1.Update
       tablas1.Close

        For i = 1 To (grdRegistros.Rows - 1)
            grdRegistros.Row = i
            tablas2.AddNew

            tablas2("rp_oficina") = txtOficina.Text
            
            grdRegistros.Col = 2 'Cuenta
            tablas2("rp_cta_banco") = grdRegistros.Text
            
            grdRegistros.Col = 3  'Cedula
            tablas2("rp_ced_ruc") = grdRegistros.Text
            
            grdRegistros.Col = 4  'Nombre Largo
            tablas2("rp_nomlar") = grdRegistros.Text
            
            grdRegistros.Col = 5  'Fecha Apertura
            tablas2("rp_fecha_aper") = grdRegistros.Text
            
            grdRegistros.Col = 6 'Cuota
            tablas2("rp_cuota") = grdRegistros.Text
            
            grdRegistros.Col = 7 'Movimiento Mes
            tablas2("rp_mto_mes") = grdRegistros.Text
            
            grdRegistros.Col = 8 'Saldo Actual
            tablas2("rp_saldo_mes") = grdRegistros.Text
            
            grdRegistros.Col = 9 'Saldo Esperado
            tablas2("rp_saldo_esp") = grdRegistros.Text
            
            grdRegistros.Col = 10 'Diferencia
            tablas2("rp_diferencia") = grdRegistros.Text
            
            grdRegistros.Col = 11 'Telefono
            tablas2("rp_telefono") = grdRegistros.Text
            tablas2.Update
        Next i
        tablas2.Close

        VTMsg = "Asegúrese de que la Impresora se encuentre lista. Desea continuar con la impresión?."
        VTR = MsgBox(VTMsg, 36, "Control de impresión de Datos.")

        If VTR = IDYES Then
                reportes = VGPath & "\REPSEGUIPRO.RPT"
                rptReporte.ReportFileName = reportes
                rptReporte.DataFiles(0) = archivos
                rptReporte.Destination = 0
                rptReporte.Action = 0
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
    txtOficina.Enabled = True
    txtOficina.Text = ""
    lblOficina(1).Caption = ""
    mskValor(0).Mask = ""
    mskValor(0).Text = ""
    mskValor(0).Mask = FMMascaraFecha(VLFormatoFecha)
    mskValor(1).Mask = ""
    mskValor(1).Text = ""
    mskValor(1).Mask = FMMascaraFecha(VLFormatoFecha)
    txtOficina.SetFocus
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
        lblOficina(1).Caption = ""
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtOficina.Text & "]") Then
            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
            PMChequea sqlconn&
           FCatalogo.Show 1
           txtOficina.Text = VGACatalogo.Codigo
           lblOficina(1).Caption = VGACatalogo.Descripcion
           If txtOficina.Text <> "" Then
              VLPaso = True
              txtOficina.SetFocus
           End If
        End If
    End If

End Sub

Private Sub txtOficina_KeyPress(KeyAscii As Integer)
   KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
End Sub

Private Sub txtOficina_LostFocus()
      If txtOficina.Text <> "" Then
          lblOficina(1).Caption = ""
          PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
          PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
          PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtOficina.Text)
          If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtOficina.Text & "]") Then
             PMMapeaObjeto sqlconn&, lblOficina(1)
             PMChequea sqlconn&
           Else
              txtOficina.Text = ""
              lblOficina(1).Caption = ""
              txtOficina.SetFocus
           End If
         Else
            lblOficina(1).Caption = ""
      End If
End Sub


Private Sub txtoficina_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Clipboard.Clear
    Clipboard.SetText ""
End Sub
Private Sub PLBuscar_parametro()
'*************************************************************
' PROPOSITO: Permite transmitir la informacion de la forma
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 20-Sep-2011   S. Molano        Emisión Inicial
'*************************************************************
                 
PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 395
PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "S"
If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_reporte_ahorro_plan", True, "Ok... Reporte Seguimiento Plan de Ahorros") Then
   PMMapeaVariable sqlconn&, VLNumdias
   PMChequea sqlconn&
Else
   VLNumdias = 0
End If
End Sub

