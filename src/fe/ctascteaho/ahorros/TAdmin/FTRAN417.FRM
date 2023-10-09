VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.ocx"
Begin VB.Form FTran417 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Consulta de Cartas Remesas por Oficina"
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
   Icon            =   "FTRAN417.frx":0000
   LinkTopic       =   "Form5"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Tag             =   "3885"
   Begin MSGrid.Grid grdficticio 
      Height          =   495
      Left            =   8490
      TabIndex        =   15
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
   Begin VB.TextBox txtCarta 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   780
      MaxLength       =   14
      TabIndex        =   11
      Top             =   90
      Width           =   645
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   4
      Top             =   1530
      WhatsThisHelpID =   2002
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Escoger"
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
      Picture         =   "FTRAN417.frx":030A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   14
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
      Picture         =   "FTRAN417.frx":0326
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8415
      TabIndex        =   13
      Top             =   765
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
      Picture         =   "FTRAN417.frx":0342
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   8130
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   6
      Top             =   555
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   7905
      Picture         =   "FTRAN417.frx":035E
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   7
      Top             =   555
      Visible         =   0   'False
      Width           =   195
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8400
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
      Picture         =   "FTRAN417.frx":0438
   End
   Begin MSGrid.Grid grdCarta 
      Height          =   1485
      Left            =   30
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   780
      Width           =   8310
      _Version        =   65536
      _ExtentX        =   14659
      _ExtentY        =   2620
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
   Begin MSGrid.Grid grdCheque 
      Height          =   2730
      Left            =   30
      TabIndex        =   1
      Top             =   2565
      Width           =   8310
      _Version        =   65536
      _ExtentX        =   14659
      _ExtentY        =   4816
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
      Left            =   8595
      Top             =   180
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
      TabIndex        =   5
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
      TabIndex        =   10
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
      TabIndex        =   12
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
      Left            =   30
      TabIndex        =   8
      Top             =   2340
      WhatsThisHelpID =   5422
      Width           =   2115
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cartas Remesas:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   30
      TabIndex        =   9
      Top             =   510
      WhatsThisHelpID =   5410
      Width           =   1515
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
      TabIndex        =   3
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
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   -60
      X2              =   8355
      Y1              =   2310
      Y2              =   2310
   End
End
Attribute VB_Name = "FTran417"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLFila As Integer
Dim VLFormatoFecha As String
Dim VLPaso As Boolean

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index
    Case 0
      PLSiguiente
    Case 1
      PMMarcarRegistro
    Case 2
      PLImprimir
    Case 3
     Unload FTran417
    End Select
End Sub

Private Sub Form_Load()
    VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
    FTran417.Left = 15
    FTran417.Top = 15
    FTran417.Width = 9420
    FTran417.Height = 5820
    PMLoadResStrings Me
    PMLoadResIcons Me
    txtCarta.Enabled = True
    txtCarta.Text = VGOficina
    txtCarta_LostFocus
    lblDescripcion(1).Caption = Format$(VGFecha, VLFormatoFecha)
    PLBuscar
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdCarta_Click()
    grdCarta.Col = 0
    grdCarta.SelStartCol = 1
    grdCarta.SelEndCol = grdCarta.Cols - 1
    
    If grdCarta.Row = 0 Then
        grdCarta.SelStartRow = 1
        grdCarta.SelEndRow = 1
    Else
        grdCarta.SelStartRow = grdCarta.Row
        grdCarta.SelEndRow = grdCarta.Row
    End If
    VLFila = grdCarta.Row
    PMCheques grdCheque
End Sub

Private Sub grdCarta_DblClick()
    ' Verificar que existan Carta para entregar
    If grdCarta.Rows <= 2 Then
        grdCarta.Row = 1
        grdCarta.Col = 1
        If Trim$(grdCarta.Text) = "" Then
            MsgBox "No existen Cartas en esta oficina", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    End If
    VLFila = grdCarta.Row
    PMMarcarRegistro
End Sub

Private Sub grdCarta_KeyUp(Keycode As Integer, Shift As Integer)
    grdCarta.Col = 0
    grdCarta.SelStartCol = 1
    grdCarta.SelEndCol = grdCarta.Cols - 1
    If grdCarta.Row = 0 Then
        grdCarta.SelStartRow = 1
        grdCarta.SelEndRow = 1
    Else
        grdCarta.SelStartRow = grdCarta.Row
        grdCarta.SelEndRow = grdCarta.Row
    End If

End Sub

Private Sub PLBuscar()
Dim i As Integer
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "602"
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "C"
     PMPasoValores sqlconn&, "@i_carta", 0, SQLINT2, "0"
     PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
     PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina
     If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_cons_carta_remesas", True, " Ok... Consulta de cartas remesas") Then
       PMMapeaGrid sqlconn&, grdCarta, False
       PMChequea sqlconn&

        grdCarta.ColWidth(1) = 800
        grdCarta.ColAlignment(1) = 2
        grdCarta.ColWidth(2) = 1500
        grdCarta.ColWidth(3) = 1800
        grdCarta.ColWidth(4) = 1800
        grdCarta.ColWidth(5) = 1800
        grdCarta.ColWidth(6) = 1200
        grdCarta.ColWidth(7) = 1200

                If grdCarta.Tag = 0 Then
                   grdCarta.Row = 1
                    grdCarta.Col = 0
                    grdCarta.Picture = picVisto(1)
                Else
                    cmdBoton(0).Enabled = True
                    cmdBoton(1).Enabled = True
                End If
                
               
                If grdCarta.Rows > 0 Then
                    For i = 1 To grdCarta.Rows - 1
                      grdCarta.Row = i
                      grdCarta.Col = 1
                      If Trim$(grdCarta.Text) <> "" Then
                        grdCarta.Col = 0
                        grdCarta.Text = CStr(grdCarta.Row)
                        grdCarta.Picture = picVisto(0)
                      End If
                    Next i
                End If

      If Val(grdCarta.Tag) >= 20 Then
        cmdBoton(0).Enabled = True
      Else
        cmdBoton(0).Enabled = False
      End If
     cmdBoton(1).Enabled = True
    End If
  
End Sub

Private Sub PLImprimir()

On Error GoTo ErrorImp
Const IDYES = 6
Dim i As Integer
Dim j As Integer
Dim VTR As Integer
If grdCarta.Rows > 1 Then
  
  Dim BaseDatos As Database
  Dim tablas1 As Recordset
  Dim tablas2 As Recordset
  Dim archivos As String
  Dim reportes As String
  Dim VTDesc As String
  Dim VTMsg As String
  Screen.MousePointer = 11
  archivos = VGPath & "\REMESAS.MDB"
  Set BaseDatos = DBEngine.OpenDatabase(archivos)
  Set tablas1 = BaseDatos.OpenRecordset("re_encabezado")
  Set tablas2 = BaseDatos.OpenRecordset("re_detalle")
  BaseDatos.Execute "delete from re_detalle"
  BaseDatos.Execute "delete from re_encabezado"

    For i = 1 To grdCarta.Rows - 1
      grdCarta.Row = i
      grdCarta.Col = 0
     
      If grdCarta.Picture = picVisto(0) Then
      
          tablas1.AddNew
          tablas1("en_oficina") = CInt(VGOficina)
          tablas1("en_desc_oficina") = lblDescripcion(0).Caption + " (" + VGOficina + ")"
          grdCarta.Col = 1
          tablas1("en_num_carta") = CInt(grdCarta.Text)
          tablas1("en_fecha") = lblDescripcion(1).Caption
          grdCarta.Col = 3
          tablas1("en_corresponsal") = grdCarta.Text
          grdCarta.Col = 4
          tablas1("en_cod_corresponsal") = grdCarta.Text
          grdCarta.Col = 8
          tablas1("en_destino") = grdCarta.Text
          grdCarta.Col = 9
          If Trim$(grdCarta.Text) = "N" Then
             VTDesc = "NEGOCIADA"
          ElseIf Trim$(grdCarta.Text) = "C" Then
                 VTDesc = "AL COBRO"
              Else
                 VTDesc = ""
          End If
          tablas1("en_tipo_remesa") = VTDesc
          tablas1("en_desc_moneda") = FPrincipal!cmbMoneda.Text
          grdCarta.Col = 7
          tablas1("en_num_cheques") = CInt(grdCarta.Text)
          grdCarta.Col = 2
          tablas1("en_valor") = CCur(grdCarta.Text)
          tablas1.Update
                      
            'Aqui se imprime el detalle de cada carta

            PMCheques grdficticio   'Llama el datelle
            
            For j = 1 To (grdficticio.Rows - 1)
                grdficticio.Row = j
               
                grdficticio.Col = 11 'Estado
                If grdficticio.Text <> "D" Then
                
                    tablas2.AddNew
                    
                    tablas2("de_oficina") = CInt(VGOficina)
                    
                    grdficticio.Col = 5 'No. Remesa
                    tablas2("de_num_remesa") = CLng(grdficticio.Text)
                    
                    grdficticio.Col = 2 'Cta. Depositada
                    tablas2("de_cta_deposito") = grdficticio.Text
        
                    grdficticio.Col = 1 'Cta. Girada
                    tablas2("de_cta_girada") = grdficticio.Text
        
    
                    grdficticio.Col = 3 'No. Cheque
                    tablas2("de_num_chq_tmp") = CLng(grdficticio.Text)
  
                    
                    grdficticio.Col = 4 'Valor
                    tablas2("de_valor") = CCur(grdficticio.Text)
                    
                    grdficticio.Col = 7 'Banco
                    tablas2("de_desc_banco") = grdficticio.Text
                    
                    grdficticio.Col = 8 'Codigo Ciudad
                    tablas2("de_num_ciudad_girada") = CLng(grdficticio.Text)
                    
                    grdficticio.Col = 9 'Ciudad
                    tablas2("de_desc_ciudad_girada") = grdficticio.Text
                    
                    grdficticio.Col = 10 'Departamento
                    tablas2("de_departamento") = grdficticio.Text
                    
                    tablas2.Update
                End If
            Next j
            tablas2.Close
      End If
     Next i
     tablas1.Close
   
     VTMsg = "Asegúrese de que la Impresora se encuentre lista. Desea continuar con la impresión?."
     VTR = MsgBox(VTMsg, 36, "Control de impresión de Datos.")
        
     If VTR = IDYES Then
          reportes = VGPath & "\cons_carta_rem_ofi.rpt"
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

Private Sub PLSiguiente()
Dim i As Integer
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "602"
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "C"
     PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
     PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina
    grdCarta.Row = VLFila
    grdCarta.Col = 1
     PMPasoValores sqlconn&, "@i_carta", 0, SQLVARCHAR, grdCarta.Text
    If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_cons_carta_remesas", True, " Ok... Consulta de cartas remesas") Then
       PMMapeaGrid sqlconn&, grdCarta, True
       PMChequea sqlconn&

        grdCarta.ColWidth(1) = 800
        grdCarta.ColAlignment(1) = 2
        grdCarta.ColWidth(2) = 1500
        grdCarta.ColWidth(3) = 1800
        grdCarta.ColWidth(4) = 1800
        grdCarta.ColWidth(5) = 1800
        grdCarta.ColWidth(6) = 1200
        grdCarta.ColWidth(7) = 1200

                If grdCarta.Tag = 0 Then
                   grdCarta.Row = 1
                    grdCarta.Col = 0
                    grdCarta.Picture = picVisto(1)
                Else
                    cmdBoton(0).Enabled = True
                    cmdBoton(1).Enabled = True
                End If
                
               
                If grdCarta.Rows > 0 Then
                    For i = 1 To grdCarta.Rows - 1
                      grdCarta.Row = i
                      grdCarta.Col = 1
                      If Trim$(grdCarta.Text) <> "" Then
                        grdCarta.Col = 0
                        grdCarta.Text = CStr(grdCarta.Row)
                        grdCarta.Picture = picVisto(0)
                      End If
                    Next i
                End If

     
      If Val(grdCarta.Tag) >= 20 Then
        cmdBoton(0).Enabled = True
      Else
        cmdBoton(0).Enabled = False
      End If

    End If

End Sub

Private Sub PMCheques(grdInterno As Control)
Dim VTAcumulaGrid As Integer
Dim VTNumero As Integer
 VTNumero = 20
 PMLimpiaGrid grdInterno
 
 While VTNumero >= 20

     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "602"
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "D"
     PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
     PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina
     grdCarta.Row = VLFila
     grdCarta.Col = 1
     PMPasoValores sqlconn&, "@i_carta", 0, SQLINT2, grdCarta.Text
    If grdInterno.Rows > 2 Then
    grdInterno.Col = 5
      If grdInterno.Text <> "" Then
         PMPasoValores sqlconn&, "@i_nref", 0, SQLINT4, grdInterno.Text
         VTAcumulaGrid = True
      Else
         PMPasoValores sqlconn&, "@i_nref", 0, SQLINT4, "0"
         VTAcumulaGrid = False
      End If
    Else
       PMPasoValores sqlconn&, "@i_nref", 0, SQLINT4, "0"
    End If


     If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_cons_carta_remesas", True, " Ok... Consulta de cartas remesas") Then
       PMMapeaGrid sqlconn&, grdInterno, VTAcumulaGrid 'False
       PMChequea sqlconn&
      cmdBoton(2).Enabled = True
      VTNumero = Val(grdInterno.Tag)
    Else
      VTNumero = 0
      cmdBoton(2).Enabled = False
    End If
 Wend

End Sub

Private Sub PMMarcarRegistro()
    grdCarta.Col = 0
    If grdCarta.Picture = picVisto(1) Then
        grdCarta.Text = Str$(grdCarta.Row)
        grdCarta.Picture = picVisto(0)
    Else
        grdCarta.Text = Str$(grdCarta.Row)
        grdCarta.Picture = picVisto(1)
    End If
End Sub

Private Sub txtCarta_LostFocus()
     If txtCarta.Text <> "" Then
       PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
       PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
       PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCarta.Text)
         If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCarta.Text & "]") Then
           PMMapeaObjeto sqlconn&, lblDescripcion(0)
           PMChequea sqlconn&
          txtCarta.Enabled = False
        Else
          VLPaso = True
          txtCarta.Enabled = True
          txtCarta.Text = ""
          lblDescripcion(0).Caption = ""
          MsgBox "El código de la Oficina no existe", 0 + 16, "Mensaje de Error"
          Exit Sub
        End If
    Else
       lblDescripcion(0).Caption = ""
    End If
End Sub
