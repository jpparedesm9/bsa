VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.ocx"
Begin VB.Form FTran604 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Relación de Cheques Remesas Vía Bancos por Oficina"
   ClientHeight    =   5325
   ClientLeft      =   900
   ClientTop       =   1470
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
   HelpContextID   =   1082
   Icon            =   "ftran604.frx":0000
   LinkTopic       =   "Form5"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Tag             =   "3890"
   Begin MSGrid.Grid grdficticio 
      Height          =   495
      Left            =   8490
      TabIndex        =   10
      Top             =   2865
      Visible         =   0   'False
      Width           =   720
      _Version        =   65536
      _ExtentX        =   1270
      _ExtentY        =   873
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
   Begin VB.TextBox txtOficina 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Left            =   780
      MaxLength       =   14
      TabIndex        =   6
      Top             =   90
      Width           =   645
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   9
      Tag             =   "6335"
      Top             =   3795
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
      Picture         =   "ftran604.frx":030A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8415
      TabIndex        =   8
      Top             =   720
      Visible         =   0   'False
      WhatsThisHelpID =   2020
      Width           =   870
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
      Picture         =   "ftran604.frx":0326
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8420
      TabIndex        =   0
      Top             =   4560
      WhatsThisHelpID =   2008
      Width           =   870
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
      Picture         =   "ftran604.frx":0342
   End
   Begin MSGrid.Grid grdCheque 
      Height          =   4575
      Left            =   30
      TabIndex        =   1
      Top             =   720
      Width           =   8310
      _Version        =   65536
      _ExtentX        =   14658
      _ExtentY        =   8070
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
   Begin Crystal.CrystalReport rptReporte 
      Left            =   8625
      Top             =   135
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      PrintFileLinesPerPage=   60
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   1
      Left            =   6765
      TabIndex        =   3
      Top             =   75
      Width           =   1575
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   6105
      TabIndex        =   5
      Top             =   120
      WhatsThisHelpID =   5428
      Width           =   675
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Oficina:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   45
      TabIndex        =   7
      Top             =   120
      WhatsThisHelpID =   5432
      Width           =   750
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Detalle de los Cheques:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   4
      Top             =   495
      WhatsThisHelpID =   5422
      Width           =   2115
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   1440
      TabIndex        =   2
      Top             =   90
      Width           =   4470
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
      X1              =   -60
      X2              =   8355
      Y1              =   450
      Y2              =   450
   End
End
Attribute VB_Name = "FTran604"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLFormatoFecha As String
Dim VLPAG As Integer

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0
      PLSiguiente
    Case 2
      PLImprimir
    Case 3
     Unload FTran604
    End Select
End Sub

Private Sub Form_Load()
    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    FTran604.Left = 15
    FTran604.Top = 15
    FTran604.Width = 9420
    FTran604.Height = 5820
    PMLoadResStrings Me
    PMLoadResIcons Me
    txtOficina.Text = VGOficina$
    txtOficina_LostFocus
    lblDescripcion(1).Caption = Format$(VGFecha$, VLFormatoFecha$)
    PLBuscar
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub PLBuscar()
Dim VTFecha As String
Dim i As Integer

     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "606"
     PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
     PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
     VTFecha$ = FMConvFecha(lblDescripcion(1), VLFormatoFecha$, "mm/dd/yyyy")
     PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFecha$
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rem_cons_chq_eofi", True, " Ok... Consulta de cheques remesas por oficina") Then
        PMMapeaGrid sqlconn&, grdCheque, False
        PMChequea sqlconn&

        grdCheque.ColWidth(1) = 1200
        grdCheque.ColWidth(2) = 1200
        grdCheque.ColWidth(3) = 800
        grdCheque.ColWidth(4) = 1800
        grdCheque.ColWidth(5) = 1200
        grdCheque.ColWidth(6) = 1500
        grdCheque.ColWidth(7) = 1200
        grdCheque.ColWidth(8) = 1500
        grdCheque.ColWidth(9) = 1500
        grdCheque.ColWidth(10) = 800
        grdCheque.ColWidth(11) = 800

        If Val(grdCheque.Tag) >= 20 Then
            PLSiguiente
        Else
            If grdCheque.Rows - 1 >= 1 Then cmdBoton(2).Enabled = True
        End If
        
        If grdCheque.Rows > 0 Then
            For i = 1 To grdCheque.Rows - 1
                grdCheque.Row = i
                grdCheque.Col = 1
                If Trim$(grdCheque.Text) <> "" Then
                  grdCheque.Col = 0
                  grdCheque.Text = CStr(grdCheque.Row)
                End If
            Next i
        End If
    End If
End Sub

Private Sub PLImprimir()

    On Error GoTo ErrorImp
    Const IDYES = 6
    Dim archivos As String
    Dim VTMsg As String
    Dim i As Integer
    Dim VTR As Integer
    Dim reportes As String
    If grdCheque.Rows > 1 Then
       
       Dim BaseDatos As Database
       Dim tablas1 As Recordset
       Dim tablas2 As Recordset
       Screen.MousePointer = 11
       archivos = VGPath$ & "\REMESAS.MDB"
       Set BaseDatos = DBEngine.OpenDatabase(archivos$)
       Set tablas1 = BaseDatos.OpenRecordset("re_encabezado")
       Set tablas2 = BaseDatos.OpenRecordset("re_detalle")
       BaseDatos.Execute "delete from re_detalle"
       BaseDatos.Execute "delete from re_encabezado"
       tablas1.AddNew
       tablas1("en_oficina") = CInt(VGOficina)
       tablas1("en_desc_oficina") = txtOficina.Text + "  " + lblDescripcion(0).Caption
       tablas1("en_fecha") = lblDescripcion(1).Caption
       tablas1.Update
       tablas1.Close
       
        For i = 1 To (grdCheque.Rows - 1)
            grdCheque.Row = i
            tablas2.AddNew
            
            tablas2("de_oficina") = CInt(VGOficina)
            
            grdCheque.Col = 1 'Cta. Depositada
            tablas2("de_cta_deposito") = grdCheque.Text
            
            grdCheque.Col = 2 'Cta. Girada
            tablas2("de_cta_girada") = grdCheque.Text
            
            grdCheque.Col = 3 'No. Cheque
            tablas2("de_num_cheque") = grdCheque.Text
            
            grdCheque.Col = 4 'Valor
            tablas2("de_valor") = grdCheque.Text
            
            grdCheque.Col = 5 'Banco
            tablas2("de_num_bco_girado") = grdCheque.Text
            
            grdCheque.Col = 6 'Desc. Banco
            tablas2("de_desc_banco") = grdCheque.Text
            
            grdCheque.Col = 7 'Codigo Ciudad
            tablas2("de_ciudad_girada") = grdCheque.Text
            
            grdCheque.Col = 8 'Ciudad
            tablas2("de_desc_ciudad") = grdCheque.Text
            
            grdCheque.Col = 9 'Departamento
            tablas2("de_departamento") = grdCheque.Text
            
            grdCheque.Col = 10 'Carta
            tablas2("de_num_carta") = grdCheque.Text
            
            grdCheque.Col = 11 'No. Remesa
            tablas2("de_num_remesa") = grdCheque.Text
            
            tablas2.Update
        Next i
        tablas2.Close
    
        VTMsg = "Asegúrese de que la Impresora se encuentre lista. Desea continuar con la impresión?."
        VTR = MsgBox(VTMsg$, 36, "Control de impresión de Datos.")
        
        If VTR% = IDYES Then
                reportes = VGPath$ & "\rel_chq_via_bcos.rpt"
                rptReporte.ReportFileName = reportes$
                rptReporte.CopiesToPrinter = 1
                rptReporte.DataFiles(0) = archivos$
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

Private Sub PLSiguiente()
     Dim VTFecha As String
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "606"
     PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
     PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
     VTFecha = FMConvFecha(lblDescripcion(1), VLFormatoFecha$, "mm/dd/yyyy")
     PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFecha$
     grdCheque.Row = grdCheque.Rows - 1
     grdCheque.Col = 10
     PMPasoValores sqlconn&, "@i_carta", 0, SQLINT4, grdCheque.Text
     grdCheque.Col = 11
     PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, grdCheque.Text
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rem_cons_chq_eofi", True, " Ok... Consulta de cheques remesas por oficina") Then
        PMMapeaGrid sqlconn&, grdCheque, True
        PMChequea sqlconn&

        grdCheque.ColWidth(1) = 1200
        grdCheque.ColWidth(2) = 1200
        grdCheque.ColWidth(3) = 800
        grdCheque.ColWidth(4) = 1800
        grdCheque.ColWidth(5) = 1200
        grdCheque.ColWidth(6) = 1500
        grdCheque.ColWidth(7) = 1200
        grdCheque.ColWidth(8) = 1500
        grdCheque.ColWidth(9) = 1500
        grdCheque.ColWidth(10) = 800
        grdCheque.ColWidth(11) = 800

        If Val(grdCheque.Tag) >= 20 Then
            PLSiguiente
        Else
            If grdCheque.Rows - 1 > 1 Then
                cmdBoton(2).Enabled = True
            End If
        End If
    End If
End Sub

Private Sub txtOficina_LostFocus()
    If txtOficina.Text <> "" Then
        PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
        PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtOficina.Text)
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtOficina.Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(0)
             PMChequea sqlconn&
        Else
             txtOficina.Text = ""
             lblDescripcion(0).Caption = ""
             MsgBox "El código de la Oficina no existe", 0 + 16, "Mensaje de Error"
             Exit Sub
        End If
    Else
        lblDescripcion(0).Caption = ""
    End If
End Sub
